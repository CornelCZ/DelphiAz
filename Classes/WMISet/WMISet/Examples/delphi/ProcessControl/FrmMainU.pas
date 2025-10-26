unit FrmMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls, WmiAbstract,
  WmiProcessControl, FrmSelectColumnsU, FrmNewHostU,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  FrmNewTaskU, WmiComponent, FrmAboutU;

type
  TFrmMain = class(TForm)
    mnuMain: TMainMenu;
    miFile: TMenuItem;
    miNewTask: TMenuItem;
    N1: TMenuItem;
    miExit: TMenuItem;
    miView: TMenuItem;
    miRefresh: TMenuItem;
    miUpdateSpeed: TMenuItem;
    N2: TMenuItem;
    miSelectColumns: TMenuItem;
    miHigh: TMenuItem;
    miNormal: TMenuItem;
    miLow: TMenuItem;
    miPaused: TMenuItem;
    miSelectComputer: TMenuItem;
    stbInfo: TStatusBar;
    pcMain: TPageControl;
    tsProcesses: TTabSheet;
    tsTrace: TTabSheet;
    pnlBottom: TPanel;
    pnlButton: TPanel;
    btnTerminate: TButton;
    lvProcesses: TListView;
    wmiProcesses: TWmiProcessControl;
    tmRefresh: TTimer;
    lbProcessTrace: TListBox;
    miAbout: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnChangeSpeed(Sender: TObject);
    procedure tmRefreshTimer(Sender: TObject);
    procedure miSelectColumnsClick(Sender: TObject);
    procedure miRefreshClick(Sender: TObject);
    procedure btnTerminateClick(Sender: TObject);
    procedure miSelectComputerClick(Sender: TObject);
    procedure miNewTaskClick(Sender: TObject);
    procedure wmiProcessesProccessStarted(Sender: TObject;
      ProcessId: Cardinal; ExecutablePath: WideString);
    procedure wmiProcessesProcessStopped(Sender: TObject;
      ProcessId: Cardinal; ExecutablePath: WideString);
    procedure miAboutClick(Sender: TObject);
  private
    { Private declarations }

    // the list of process IDs and their respective CPU time,
    // as measured last time. This is required to calculate deltas.
    FPrevProcessList: TStrings;
    FPrevTotalProcessTime: int64;
    FPrevIdleTime: int64;

    // The new list of process IDs and their CPU time.
    FNewProcessList: TStrings;
    FNewTotalProcessTime: int64;
    FNewIdleTime: int64;

    procedure BuildColumns;
    procedure ReloadProcesses;
    procedure UpdateFormCaption;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

const
  COLUMN_COUNT             = 22;

  TAG_IMAGE_NAME           = 0;
  TAG_PID                  = 1;
  TAG_SESSION_ID           = 2;
  TAG_CPU                  = 3;
  TAG_CPU_TIME             = 4;
  TAG_MEMORY_USAGE         = 5;
  TAG_PEAK_MEMORY_USAGE    = 6;
  TAG_PAGE_FAULTS          = 7;
  TAG_IO_READS             = 8;
  TAG_IO_READ_BYTES        = 9;
  TAG_VIRTUAL_MEMORY_SIZE  = 10;
  TAG_PAGED_POOL           = 11;
  TAG_NON_PAGED_POOL       = 12;
  TAG_BASE_PRIORITY        = 13;
  TAG_HANDLE_COUNT         = 14;
  TAG_THREAD_COUNT         = 15;
  TAG_IO_WRITES            = 16;
  TAG_IO_WRITE_BYTES       = 17;
  TAG_IO_OTHER             = 18;
  TAG_IO_OTHER_BYTES       = 19;
  TAG_STARTED              = 20;
  TAG_FULL_PATH            = 21;

type
  PColumnRec = ^TColumnRec;
  TColumnRec = record
    Index:      integer;
    Alignment: TAlignment;
    FullName:   widestring;
    ShortName:  widestring;
    Visible:    boolean;
    Width:      integer;
    Tag:        integer;
  end;

var
  TABLE_DEF: array [0..COLUMN_COUNT - 1] of TColumnRec = (
   (Index: 0;  Alignment: taLeftJustify;  FullName: 'Image Name';               ShortName: 'Image Name';      Visible: true;  Width: 150; Tag: TAG_IMAGE_NAME;),
   (Index: 1;  Alignment: taRightJustify; FullName: 'PID (Process Identifier)'; ShortName: 'PID';             Visible: true;  Width: 40;  Tag: TAG_PID;),
   (Index: 2;  Alignment: taRightJustify; FullName: 'Session ID';               ShortName: 'Session ID';      Visible: false; Width: 80;  Tag: TAG_SESSION_ID;),
   (Index: 3;  Alignment: taLeftJustify;  FullName: 'CPU Usage';                ShortName: 'CPU';             Visible: true;  Width: 40;  Tag: TAG_CPU;),
   (Index: 4;  Alignment: taLeftJustify;  FullName: 'CPU Time';                 ShortName: 'CPU Time';        Visible: true;  Width: 75;  Tag: TAG_CPU_TIME;),
   (Index: 5;  Alignment: taRightJustify; FullName: 'Memory Usage';             ShortName: 'Mem Usage';       Visible: true;  Width: 90;  Tag: TAG_MEMORY_USAGE;),
   (Index: 6;  Alignment: taRightJustify; FullName: 'Peak Memory Usage';        ShortName: 'Peak Mem Usage';  Visible: false; Width: 150; Tag: TAG_PEAK_MEMORY_USAGE;),
   (Index: 7;  Alignment: taRightJustify; FullName: 'Page Faults';              ShortName: 'Page Faults';     Visible: false; Width: 110; Tag: TAG_PAGE_FAULTS;),
   (Index: 8;  Alignment: taRightJustify; FullName: 'I/O Reads';                ShortName: 'I/O Reads';       Visible: false; Width: 80;  Tag: TAG_IO_READS;),
   (Index: 9;  Alignment: taRightJustify; FullName: 'I/O Read Bytes';           ShortName: 'I/O Read Bytes';  Visible: false; Width: 150; Tag: TAG_IO_READ_BYTES;),
   (Index: 10; Alignment: taRightJustify; FullName: 'Virtual Memory Size';      ShortName: 'VM Size';         Visible: false; Width: 80;  Tag: TAG_VIRTUAL_MEMORY_SIZE;),
   (Index: 11; Alignment: taRightJustify; FullName: 'Paged Pool';               ShortName: 'Paged Pool';      Visible: false; Width: 90;  Tag: TAG_PAGED_POOL;),
   (Index: 12; Alignment: taRightJustify; FullName: 'Non-paged Pool';           ShortName: 'NP Pool';         Visible: false; Width: 80;  Tag: TAG_NON_PAGED_POOL;),
   (Index: 13; Alignment: taRightJustify; FullName: 'Base Priority';            ShortName: 'Base Pri';        Visible: false; Width: 70;  Tag: TAG_BASE_PRIORITY;),
   (Index: 14; Alignment: taRightJustify; FullName: 'Handle Count';             ShortName: 'Handles';         Visible: false; Width: 70;  Tag: TAG_HANDLE_COUNT;),
   (Index: 15; Alignment: taRightJustify; FullName: 'Thread Count';             ShortName: 'Threads';         Visible: false; Width: 70;  Tag: TAG_THREAD_COUNT;),
   (Index: 16; Alignment: taRightJustify; FullName: 'I/O Writes';               ShortName: 'I/O Writes';      Visible: false; Width: 80;  Tag: TAG_IO_WRITES;),
   (Index: 17; Alignment: taRightJustify; FullName: 'I/O Write Bytes';          ShortName: 'I/O Write Bytes'; Visible: false; Width: 110; Tag: TAG_IO_WRITE_BYTES;),
   (Index: 18; Alignment: taRightJustify; FullName: 'I/O Other';                ShortName: 'I/O Other';       Visible: false; Width: 80;  Tag: TAG_IO_OTHER;),
   (Index: 19; Alignment: taRightJustify; FullName: 'I/O Other Bytes';          ShortName: 'I/O Other Bytes'; Visible: false; Width: 120; Tag: TAG_IO_OTHER_BYTES;),
   (Index: 20; Alignment: taLeftJustify;  FullName: 'Started at';               ShortName: 'Started at';      Visible: false;  Width: 150; Tag: TAG_STARTED;),
   (Index: 21; Alignment: taLeftJustify;  FullName: 'Full Path';                ShortName: 'Full Path';       Visible: false;  Width: 220; Tag: TAG_FULL_PATH;)
   );

function GetColumnRecByTag(ATag: integer): PColumnRec;
var
  i: integer;
begin
  for i := 0 to COLUMN_COUNT - 1 do
    if TABLE_DEF[i].Tag = ATag then
    begin
      Result := @TABLE_DEF[i];
      Exit;   
    end;
  raise Exception.Create('Column not found');
end;

function GetColumnRecByIndex(AIndex: integer): PColumnRec;
var
  i: integer;
begin
  for i := 0 to COLUMN_COUNT - 1 do
    if TABLE_DEF[i].Index = AIndex then
    begin
      Result := @TABLE_DEF[i];
      Exit;   
    end;
  raise Exception.Create('Column not found');
end;

function GetVisibleColumnIndex(ATag: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to COLUMN_COUNT - 1 do
    if TABLE_DEF[i].Tag = Atag then
    begin
      if not TABLE_DEF[i].Visible then Result := - 1;
      Exit;
    end else
    begin
      if TABLE_DEF[i].Visible then Result := Result + 1;
    end;
  raise Exception.Create('Column not found');
end;

function DateTimeToStringDef(ADateTime: TDateTime): widestring;
begin
  if ADateTime = 0 then Result := ''
    else Result := DateTimeToStr(ADateTime);
end;

function ProcessorTimeToString(A100Nonasec: int64): string;
var
  vTmp, vHours, vOneHour: double;
  vDateTime:    TDateTime;
begin
  // Show time as number of hours, minutes, seconds;
  // number of hours may be more than 24;
  vTmp    := 60; vTmp := vTmp * 60*24*10000000;
  vDateTime := A100Nonasec /vTmp;
  vOneHour  := 1/24;
  vHours  := Int(vDateTime / vOneHour);
  DateTimeToString(Result, ':nn:ss',vDateTime);
  Result := IntToStr(Trunc(vHours)) + Result;
end;

function BytesToSizeString(ABytes: int64): widestring;
var
  vValue: double;
begin
  if ABytes < 1024 then Result := IntToStr(ABytes)
    else
  if (ABytes >= 1024) and  (ABytes < 10000) then
  begin
    vValue := ABytes / 1024;
    Result := Format('%2.1n K', [vValue]);
  end
    else
    begin
      vValue := ABytes / 1024;
      Result := Format('%6.0n K', [vValue]);
    end
end;

procedure TFrmMain.ReloadProcesses;
var
  iProcess: integer;
  iColumn:  integer;
  vProcess: TWmiProcess;
  vItem:    TListItem;
  vColumnRec: TColumnRec;

  vOldSelectedProcessId: cardinal;
  vBottomIndex: integer;

  vCpuTime:         int64;
  vPrevCpuTime:     int64;
  vCpuUsage:        double;
  vDeltaIdle:       int64;
  vTotalDeltaCpu:   int64;
  vProcessDeltaCpu: int64;
  vName: string;

begin
  UpdateFormCaption;

  lvProcesses.Items.BeginUpdate;
  try
    if lvProcesses.TopItem = nil then vBottomIndex := 0
      else
      vBottomIndex := lvProcesses.TopItem.Index + lvProcesses.VisibleRowCount - 1;
    if lvProcesses.Selected = nil then vOldSelectedProcessId := DWORD(-1)
      else vOldSelectedProcessId := WmiProcesses.Processes[lvProcesses.Selected.Index].ProcessId;

    lvProcesses.Items.Clear;
    WmiProcesses.Refresh;
    FNewProcessList.Clear;
    FNewTotalProcessTime := 0;
    for iProcess := 0 to WmiProcesses.Processes.Count - 1 do
    begin
       vProcess      := WmiProcesses.Processes[iProcess];
       vItem         := lvProcesses.Items.Add;
       vItem.Caption := vProcess.Caption;
       vCpuTime      := vProcess.KernelModeTime + vProcess.UserModeTime;
       FNewProcessList.Add(IntToStr(vProcess.ProcessId) + '=' + IntToStr(vCpuTime));
       if vProcess.ProcessId = 0 then FNewIdleTime := vCpuTime
         else FNewTotalProcessTime := FNewTotalProcessTime + vCpuTime;

       if vOldSelectedProcessId = vProcess.ProcessId then lvProcesses.Selected := vItem;
       for iColumn := 1 to COLUMN_COUNT - 1 do
       begin
         vColumnRec := GetColumnRecByIndex(iColumn)^;
         if vColumnRec.Visible then
         begin
           case vColumnRec.Tag of
             TAG_PID:                 vItem.SubItems.Add(IntToStr(vProcess.ProcessId));
             TAG_SESSION_ID:          vItem.SubItems.Add(IntToStr(vProcess.SessionId));
             TAG_CPU:                 vItem.SubItems.Add(''); // this is just a place holder; value will be added later
             TAG_CPU_TIME:            vItem.SubItems.Add(ProcessorTimeToString(vCpuTime));
             TAG_MEMORY_USAGE:        vItem.SubItems.Add(BytesToSizeString(vProcess.WorkingSetSize));
             TAG_PEAK_MEMORY_USAGE:   vItem.SubItems.Add(BytesToSizeString(vProcess.PeakWorkingSetSize));
             TAG_PAGE_FAULTS:         vItem.SubItems.Add(IntToStr(vProcess.PageFaults));
             TAG_IO_READS:            vItem.SubItems.Add(IntToStr(vProcess.ReadOperationCount));
             TAG_IO_READ_BYTES:       vItem.SubItems.Add(BytesToSizeString(vProcess.ReadTransferCount));
             TAG_VIRTUAL_MEMORY_SIZE: vItem.SubItems.Add(BytesToSizeString(vProcess.PeakVirtualSize));
             TAG_PAGED_POOL:          vItem.SubItems.Add(BytesToSizeString(vProcess.QuotaPagePoolUsage));
             TAG_NON_PAGED_POOL:      vItem.SubItems.Add(BytesToSizeString(vProcess.QuotaNonPagePoolUsage));
             TAG_BASE_PRIORITY:       vItem.SubItems.Add(IntToStr(vProcess.Priority));
             TAG_HANDLE_COUNT:        vItem.SubItems.Add(IntToStr(vProcess.HandleCount));
             TAG_THREAD_COUNT:        vItem.SubItems.Add(IntToStr(vProcess.ThreadCount));
             TAG_IO_WRITES:           vItem.SubItems.Add(IntToStr(vProcess.WriteOperationCount));
             TAG_IO_WRITE_BYTES:      vItem.SubItems.Add(BytesToSizeString(vProcess.WriteTransferCount));
             TAG_IO_OTHER:            vItem.SubItems.Add(IntToStr(vProcess.OtherOperationCount));
             TAG_IO_OTHER_BYTES:      vItem.SubItems.Add(BytesToSizeString(vProcess.OtherTransferCount));
             TAG_STARTED:             vItem.SubItems.Add(DateTimeToStringDef(vProcess.CreationDate));
             TAG_FULL_PATH:           vItem.SubItems.Add(vProcess.ExecutablePath);
           end;
         end;
       end;
    end;

    // calculate deltas
    vDeltaIdle := FNewIdleTime - FPrevIdleTime;
    vTotalDeltaCpu  := FNewTotalProcessTime - FPrevTotalProcessTime;
    
    stbInfo.Panels[0].Text := Format('Processes: %d ', [FNewProcessList.Count]);
    if (vTotalDeltaCpu + vDeltaIdle) > 0 then 
      vCpuUsage := (vTotalDeltaCpu/(vTotalDeltaCpu + vDeltaIdle)) * 100
      else vCpuUsage := 0;
    stbInfo.Panels[1].Text := Format('CPU Usage: %2.0f %', [vCpuUsage]);

    // If corresponding column is visible,  fill in CPU  usage for each process
    iColumn := GetVisibleColumnIndex(TAG_CPU);
    if iColumn <> -1 then
    begin
      for iProcess := 0 to FNewProcessList.Count - 1 do
      begin
        vName := FNewProcessList.Names[iProcess];
        vCpuTime         := StrToInt64(FNewProcessList.Values[vName]);
        vPrevCpuTime     := StrToInt64Def(FPrevProcessList.Values[vName], 0);
        vProcessDeltaCpu := vCpuTime - vPrevCpuTime;
        if (vTotalDeltaCpu + vDeltaIdle <> 0) then
        begin
          vCpuUsage        := (vProcessDeltaCpu/(vTotalDeltaCpu + vDeltaIdle)) * 100;
          lvProcesses.Items[iProcess].SubItems[iColumn - 1] := Format('%2.0f ', [vCpuUsage])
        end;  
      end;
    end;
    // save current times to be able to calculate deltas next time:
    FPrevProcessList.Assign(FNewProcessList);
    FPrevIdleTime := FNewIdleTime;
    FPrevTotalProcessTime := FNewTotalProcessTime; 

    if vBottomIndex >= lvProcesses.Items.Count then
      vBottomIndex := lvProcesses.Items.Count - 1;
    if vBottomIndex >= 0 then
      lvProcesses.Items[vBottomIndex].MakeVisible(true)
  finally
    lvProcesses.Items.EndUpdate;
  end;
end;

procedure TFrmMain.BuildColumns;
var
  i: integer;
  vColumn: TListColumn;
begin
  lvProcesses.Columns.BeginUpdate;
  try
    lvProcesses.Columns.Clear;
    for i := 0 to COLUMN_COUNT - 1 do
    begin
      if TABLE_DEF[i].Visible then
      begin
      vColumn         := lvProcesses.Columns.Add;
      vColumn.Caption := TABLE_DEF[i].ShortName;
      vColumn.Width   := TABLE_DEF[i].Width;
      vColumn.Alignment := TABLE_DEF[i].Alignment;
      end;
    end;
  finally
    lvProcesses.Columns.EndUpdate;
  end;
end;

procedure TFrmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  lvProcesses.DoubleBuffered := true;
  wmiProcesses.Active := true;
  BuildColumns;
  ReloadProcesses;
end;

procedure TFrmMain.UpdateFormCaption;
var
  s1, s2: string;
begin
  s1 := 'Processes on ';
  s2 := Trim(wmiProcesses.MachineName);
  if s2 = '' then Caption := s1 + 'local computer'
    else Caption := s1 + s2;
end;

procedure TFrmMain.OnChangeSpeed(Sender: TObject);
var
  vInterval: integer;
  vMenuItem: TMenuItem;
begin
  vMenuItem := TMenuItem(Sender);
  vMenuItem.Checked := true;
  
  vInterval := vMenuItem.Tag;
  tmRefresh.Enabled := vInterval <> 0;
  tmRefresh.Interval := vInterval;
end;

procedure TFrmMain.tmRefreshTimer(Sender: TObject);
begin
  ReloadProcesses;
end;

constructor TFrmMain.Create(AOwner: TComponent);
begin
  inherited;
  FPrevProcessList := TStringList.Create;
  FNewProcessList := TStringList.Create;
end;

destructor TFrmMain.Destroy;
begin
  FPrevProcessList.Free;
  FNewProcessList.Free;
  inherited;
end;

procedure TFrmMain.miSelectColumnsClick(Sender: TObject);
begin
  with TFrmSelectColumns.Create(nil) do
  try
    chbIOOther.Checked         := GetColumnRecByTag(TAG_IO_OTHER)^.Visible;
    chbPID.Checked             := GetColumnRecByTag(TAG_PID)^.Visible;
    chbIOOtherBytes.Checked    := GetColumnRecByTag(TAG_IO_OTHER_BYTES)^.Visible;
    chbCpuUsage.Checked        := GetColumnRecByTag(TAG_CPU)^.Visible;
    chbPagedPool.Checked       := GetColumnRecByTag(TAG_PAGED_POOL)^.Visible;
    chbCpuTime.Checked         := GetColumnRecByTag(TAG_CPU_TIME)^.Visible;
    chbNonPagedPool.Checked    := GetColumnRecByTag(TAG_NON_PAGED_POOL)^.Visible;
    chbMemoryUsage.Checked     := GetColumnRecByTag(TAG_MEMORY_USAGE)^.Visible;
    chbBasePriority.Checked    := GetColumnRecByTag(TAG_BASE_PRIORITY)^.Visible;
    chbPeakMemoryUsage.Checked := GetColumnRecByTag(TAG_PEAK_MEMORY_USAGE)^.Visible;
    chbHandleCount.Checked     := GetColumnRecByTag(TAG_HANDLE_COUNT)^.Visible;
    chbPageFaults.Checked      := GetColumnRecByTag(TAG_PAGE_FAULTS)^.Visible;
    chbThreadCount.Checked     := GetColumnRecByTag(TAG_THREAD_COUNT)^.Visible;
    chbIOReads.Checked         := GetColumnRecByTag(TAG_IO_READS)^.Visible;
    chbVirtualMemory.Checked   := GetColumnRecByTag(TAG_VIRTUAL_MEMORY_SIZE)^.Visible;
    chbIOReadBytes.Checked     := GetColumnRecByTag(TAG_IO_READ_BYTES)^.Visible;
    chbSessionId.Checked       := GetColumnRecByTag(TAG_SESSION_ID)^.Visible;
    chbIOWrites.Checked        := GetColumnRecByTag(TAG_IO_WRITES)^.Visible;
    chbStartedAt.Checked       := GetColumnRecByTag(TAG_STARTED)^.Visible;
    chbIOWriteBytes.Checked    := GetColumnRecByTag(TAG_IO_WRITE_BYTES)^.Visible;
    chbFullPath.Checked        := GetColumnRecByTag(TAG_FULL_PATH)^.Visible;

    if ShowModal = mrOk then
    begin
      GetColumnRecByTag(TAG_IO_OTHER)^.Visible            := chbIOOther.Checked;
      GetColumnRecByTag(TAG_PID)^.Visible                 := chbPID.Checked;             
      GetColumnRecByTag(TAG_IO_OTHER_BYTES)^.Visible      := chbIOOtherBytes.Checked;
      GetColumnRecByTag(TAG_CPU)^.Visible                 := chbCpuUsage.Checked;        
      GetColumnRecByTag(TAG_PAGED_POOL)^.Visible          := chbPagedPool.Checked;       
      GetColumnRecByTag(TAG_CPU_TIME)^.Visible            := chbCpuTime.Checked;         
      GetColumnRecByTag(TAG_NON_PAGED_POOL)^.Visible      := chbNonPagedPool.Checked;    
      GetColumnRecByTag(TAG_MEMORY_USAGE)^.Visible        := chbMemoryUsage.Checked;     
      GetColumnRecByTag(TAG_BASE_PRIORITY)^.Visible       := chbBasePriority.Checked;
      GetColumnRecByTag(TAG_PEAK_MEMORY_USAGE)^.Visible   := chbPeakMemoryUsage.Checked;
      GetColumnRecByTag(TAG_HANDLE_COUNT)^.Visible        := chbHandleCount.Checked;     
      GetColumnRecByTag(TAG_PAGE_FAULTS)^.Visible         := chbPageFaults.Checked;      
      GetColumnRecByTag(TAG_THREAD_COUNT)^.Visible        := chbThreadCount.Checked;     
      GetColumnRecByTag(TAG_IO_READS)^.Visible            := chbIOReads.Checked;         
      GetColumnRecByTag(TAG_VIRTUAL_MEMORY_SIZE)^.Visible := chbVirtualMemory.Checked;   
      GetColumnRecByTag(TAG_IO_READ_BYTES)^.Visible       := chbIOReadBytes.Checked;     
      GetColumnRecByTag(TAG_SESSION_ID)^.Visible          := chbSessionId.Checked;       
      GetColumnRecByTag(TAG_IO_WRITES)^.Visible           := chbIOWrites.Checked;        
      GetColumnRecByTag(TAG_STARTED)^.Visible             := chbStartedAt.Checked;       
      GetColumnRecByTag(TAG_IO_WRITE_BYTES)^.Visible      := chbIOWriteBytes.Checked;    
      GetColumnRecByTag(TAG_FULL_PATH)^.Visible           := chbFullPath.Checked;

      BuildColumns;
      ReloadProcesses;        
    end;
  
  finally
    Free;
  end; 
end;

procedure TFrmMain.miRefreshClick(Sender: TObject);
begin
  ReloadProcesses;
end;

procedure TFrmMain.btnTerminateClick(Sender: TObject);
var
  vMessage: string;
  vIndex: integer;
begin
  if lvProcesses.Selected <> nil then
  begin
    vMessage := 'WARNING: terminating the process may cause data loss and '+
                'system instability. Do you want to continue? ';
            if Application.MessageBox(PChar(vMessage), 'Warning', MB_ICONWARNING + MB_YESNO) = IDYES then
    begin
      vIndex := lvProcesses.Selected.Index;
      wmiProcesses.Processes[vIndex].Terminate(0);
      ReloadProcesses;
    end;
  end;  
end;

procedure TFrmMain.miSelectComputerClick(Sender: TObject);
var
  vUserName: string;
  vWasCursor: TCursor;

  vOldUserName, vOldPassword, vOldMachineName: widestring;
  vFrmNewHost: TFrmNewHost;
begin
  vFrmNewHost := TFrmNewHost.Create(nil);
  try
    while true do
    begin
      if vFrmNewHost.ShowModal = mrOk then
      begin
        // save current credentials to be able to restore
        // them if new credentials are invalid.
        vOldUserName := wmiProcesses.Credentials.UserName;
        vOldPassword := wmiProcesses.Credentials.Password;
        vOldMachineName := wmiProcesses.MachineName;

        wmiProcesses.Active := false;
        tmRefresh.Enabled   := false;
        vUserName := vFrmNewHost.edtUserName.Text;
        if vFrmNewHost.edtDomain.Text <> '' then
          vUserName := vFrmNewHost.edtDomain.Text + '\' + vUserName;

        wmiProcesses.Credentials.UserName := vUserName;
        wmiProcesses.Credentials.Password := vFrmNewHost.edtPassword.Text;
        wmiProcesses.MachineName := vFrmNewHost.edtHostName.Text;

        vWasCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          try
            wmiProcesses.Active := true;
            ReloadProcesses;
            tmRefresh.Enabled   := true;
            lbProcessTrace.Items.Add(wmiProcesses.MachineName);
            Break;
          finally
            Screen.Cursor := vWasCursor;
          end;
        except
          on E: Exception do
            begin
              Application.MessageBox(PChar(E.Message), 'Error', MB_Ok + MB_ICONSTOP);
              // restore previous credentials.
              wmiProcesses.Credentials.UserName := vOldUserName;
              wmiProcesses.Credentials.Password := vOldPassword;
              wmiProcesses.MachineName          := vOldMachineName;
              wmiProcesses.Active := true;
              ReloadProcesses;
              tmRefresh.Enabled   := true;
            end;
        end;
      end else
      begin
        Break;
      end;
    end;  
  finally
    vFrmNewHost.Free;
  end;
end;

procedure TFrmMain.miNewTaskClick(Sender: TObject);
var
  vPath: string;
begin
  if FrmNewTask.ShowModal = mrOk then
  begin
    vPath := ExtractFilePath(FrmNewTask.edtFileName.Text);
    if vPath = '' then vPath := 'c:\';
    wmiProcesses.StartProcess(FrmNewTask.edtFileName.Text,
                               vPath,
                               false);
  end;
end;

procedure TFrmMain.wmiProcessesProccessStarted(Sender: TObject;
  ProcessId: Cardinal; ExecutablePath: WideString);
begin
  lbProcessTrace.Items.Add('Process started: '+ IntToStr(ProcessId) + ' ' + ExecutablePath);
end;

procedure TFrmMain.wmiProcessesProcessStopped(Sender: TObject;
  ProcessId: Cardinal; ExecutablePath: WideString);
begin
  lbProcessTrace.Items.Add('Process finished: '+ IntToStr(ProcessId) + ' ' + ExecutablePath);
end;

procedure TFrmMain.miAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.

