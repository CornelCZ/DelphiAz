unit uTicketingSendToEPOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus;

const
  ZOEStillPrinting = 19;
  ZOESuccess = 0;

type
  TAddToPrintQueue = function (const ipAddress: pWideChar;
                                       const id: Integer;
                                       const port: Integer;
                                       const baudRate: Integer;
                                       const minimumOfflineTimeout: Integer;
                                       const changePaperTimeOut: Integer;
                                       const job : pointer;
                                       const jobSize: Integer;
                                       var printJobID: int64;
                                       returnMessage: pWideChar;
                                       var returnCode: Integer) : WORDBOOL; cdecl;

  TCheckPrintComplete = function(const ipAddress: pWideChar;
                                       const id: Integer;
                                       var printJobID: int64;
                                       returnMessage: pWideChar;
                                       var returnCode: Integer) : WORDBOOL; cdecl;

  TPrintState = (psNull, psStarting, psPolling, psFailedToStart, psCompleted, psFailed);

  TPrinterDetails = class(TObject)
    IPAddress: widestring;
    EPoSDeviceID, PortNumber, BaudRate, MinimumOfflineTimeout, ChangePaperTimeout,
    EstBitsPerSecond: integer;
    Name: string;
    ImageData: string;
    PrintJobId: int64;
    PrintState: TPrintState;
    ErrorMessage: string[255];
    Selected: boolean;
  public
    function GetStatus: string;
    function Poll(AddToPrintQueue: TAddToPrintQueue; CheckPrintComplete: TCheckPrintComplete): boolean;
  end;

  TTicketSendThread = class(TThread)
    PrinterDetails: array of TPrinterDetails;
    OnUpdate: procedure of object;
    DoneTerminating: boolean;
    procedure Execute; override;
  end;

  TTicketingSendToEPOS = class(TForm)
    lbAvailablePrinters: TLabel;
    btSend: TButton;
    pbProgress: TProgressBar;
    ProgressTimer: TTimer;
    btClose: TButton;
    clbPrinterList: TCheckListBox;
    ContextMenu: TPopupMenu;
    SelectAll1: TMenuItem;
    SelectNone1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btSendClick(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btCloseClick(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectNone1Click(Sender: TObject);
  private
    { Private declarations }
    TicketSendThread: TTicketSendThread;
    StartTime: TDateTime;
    ETA_ms: integer;
    PrinterDetails: array of TPrinterDetails;
    ImageData: string;

    procedure GetPrinterDetails;
    procedure FreePrinterDetails;
    procedure OnUpdate;
    procedure HandleSendFinished(Sender: TObject);
    procedure UpdateJobStatus;

  public
    { Public declarations }
  end;

implementation

uses uFormNavigate, udmThemeData, DB, uTicketingDefineCBMImage, uSystemUtils;

{$R *.dfm}

procedure TTicketingSendToEPOS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(TicketSendThread) then
  begin
    TicketSendThread.Terminate;
    while Assigned(TicketSendThread) and not TicketSendThread.DoneTerminating do
      Application.ProcessMessages;
  end;
  FreePrinterDetails;
  Nav.MoveBack;
end;

procedure TTicketingSendToEPOS.FormShow(Sender: TObject);
var
  Images: array of TBitmap;
  BitmapBlobStream: TStream;
  i: integer;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'select bitmap from ThemeCloakroomImage where ThemeId = (select ThemeId from ThemeSites where SiteCode = dbo.fnGetSiteCode()) order by ThemeImageIndex';
    Open;
    SetLength(Images, RecordCount);
    i := 0;
    while not EOF do
    begin
      BitmapBlobStream := CreateBlobStream(FieldByName('Bitmap'), bmRead);
      Images[i] := TBitmap.Create;
      Images[i].LoadFromStream(BitmapBlobStream);
      BitmapBlobStream.free;
      Inc(i);
      Next;
    end;
    Close;
  end;

  ImageData := uTicketingDefineCBMImage.DefineImageData(Images, True);

  for i := low(Images) to high(Images) do
  begin
    Images[i].Free;
  end;

  GetPrinterDetails;
  UpdateJobStatus;
end;

procedure TTicketingSendToEPOS.GetPrinterDetails;
var
  i: integer;
begin
  with dmthemeData.adoqRun do
  begin
    SQL.Text :=
      'select a.IPAddress, a.EPoSDeviceID, CASE WHEN a.HardwareType = 7 THEN b.PortNumber + 2 ELSE b.PortNumber END AS PortNumber, '+
      ' c.BaudRate, c.[Timeout] as MinimumOfflineTimeout, b.ChangePaperTimeout, '+
      '  a.Name + '' / '' + b.name as Name, case when PrinterTypeID in (2521,2535) then 390 else 2500 end as EstBitsPerSecond '+
      'from ThemeEposDevice a '+
      'join ThemeEposPrinter b on a.SiteCode = b.SiteCode and a.EPoSDeviceID = b.EposDeviceID '+
      'join ThemePrinterType c on b.PrinterType = c.PrinterTypeID '+
      'where a.SiteCode = dbo.fnGetSiteCode() '+
      '  and PrinterTypeID in (2500, 2521) and IsPrinter = 1 '+
      // above was '... in (2500, 2521, 2535) ...'  bug 339390: don't select Orient BTP-R580II (IP) until Story 616239
      // for Story, get the proper fields for IP Printer, not as above.
      'order by Name';
    Open;
    SetLength(PrinterDetails, RecordCount);
    for i := low(PrinterDetails) to high(PrinterDetails) do
    begin
      PrinterDetails[i] := TPrinterDetails.Create;
      PrinterDetails[i].IPAddress := dmThemeData.adoqrun['IPAddress'];
      PrinterDetails[i].EPoSDeviceID := dmThemeData.adoqrun['EPoSDeviceID'];
      PrinterDetails[i].PortNumber := dmThemeData.adoqrun['PortNumber'];
      PrinterDetails[i].BaudRate := dmThemeData.adoqrun['BaudRate'];
      PrinterDetails[i].MinimumOfflineTimeout := dmThemeData.adoqrun['MinimumOfflineTimeout'];
      PrinterDetails[i].ChangePaperTimeout := dmThemeData.adoqrun['ChangePaperTimeout'];
      PrinterDetails[i].EstBitsPerSecond := dmThemeData.adoqrun['EstBitsPerSecond'];
      PrinterDetails[i].ImageData := self.ImageData;
      PrinterDetails[i].Name :=  dmThemeData.adoqrun['Name'];
      PrinterDetails[i].Selected := true;
      Next;
    end;
    Close;
  end;
end;

procedure TTicketingSendToEPOS.FreePrinterDetails;
var
  i: integer;
begin
  for i := low(PrinterDetails) to high(PrinterDetails) do
  begin
    PrinterDetails[i].Free;
  end;
end;

{ TPrinterDetails }

function TPrinterDetails.GetStatus: string;
begin
  case PrintState of
    psNull: Result := 'Send not started';
    psStarting: Result := 'Starting..';
    psPolling: Result := 'Send in progress';
    psFailedToStart, psFailed: Result := 'Send failed: '+ErrorMessage;
    psCompleted: Result := 'Complete';
  else
    Result := '???';
  end;
end;

function TPrinterDetails.Poll;
var
  ReturnMessage: array[0..511] of widechar;
  ReturnCode: integer;
  StartState: TPrintState;
  function NiceZOEMessage(input: string):string;
  const
    MessageStr = 'Message:';
  begin
    Result := input;
    if pos(MessageStr, input) <> 0 then
    begin
      result := copy(input, pos(MessageStr, input)+1+Length(MessageStr), length(input));
    end;
  end;
begin
  StartState := PrintState;
  case PrintState of
  psNull:
    PrintState := psStarting;
  psStarting:
    begin
      PrintJobId := 0;
      if AddToPrintQueue(PWideChar(IPAddress), EPoSDeviceID, PortNumber, BaudRate, MinimumOfflineTimeout, ChangePaperTimeout, PChar(ImageData), Length(ImageData), PrintJobId, returnMessage, returnCode) then
        PrintState := psPolling
      else
      if ReturnCode <> ZOESuccess then
      begin
        PrintState := psFailedToStart;
        ErrorMessage := NiceZoeMessage(widestring(returnMessage));
      end;
    end;
  psPolling:
    begin
      CheckPrintComplete(PWideChar(IPAddress), EposDeviceID, PrintJobID, returnMessage, returnCode);
      if returnCode = ZOESuccess then
        PrintState := psCompleted
      else
      if returnCode <> ZOEStillPrinting then
      begin
        PrintState := psFailed;
        ErrorMessage := NiceZoeMessage(widestring(returnMessage));
      end;
    end;
  end;
  result := PrintState <> StartState;
end;

{ TTicketSendThread }

procedure TTicketSendThread.Execute;
var
  i: integer;
  hZoeDll: Cardinal;
  AddToPrintQueue: TAddToPrintQueue;
  CheckPrintComplete: TCheckPrintComplete;
  AllComplete, StateChanged: boolean;
begin
  hZoeDll := SafeLoadLibrary(uSystemUtils.GetZOEDLLPath, SEM_FAILCRITICALERRORS or SEM_NOOPENFILEERRORBOX);
  try
    AddToPrintQueue := GetProcAddress(hZoeDll, 'Zoe_EPoSDeviceProxy_addRequestToPrintQueue');
    CheckPrintComplete := GetProcAddress(hZoeDll, 'Zoe_EPoSDeviceProxy_isRequestedPrintCompleted');
    repeat
      AllComplete := true;
      StateChanged := false;
      for i := low(PrinterDetails) to high(PrinterDetails) do
      begin
        if Terminated then break;
        if PrinterDetails[i].Poll(AddToPrintQueue, CheckPrintComplete) then
        begin
          StateChanged := true;
          if Assigned(OnUpdate) then
            Synchronize(OnUpdate);
        end;
        AllComplete := AllComplete and (PrinterDetails[i].PrintState in [psFailedToStart, psCompleted, psFailed]);
      end;
      if not StateChanged and not Terminated then sleep(10100);
    until AllComplete or Terminated;
    if Assigned(OnUpdate) then
      Synchronize(OnUpdate);
  finally
    FreeLibrary(hZoeDll);
  end;
  DoneTerminating := true;
end;

procedure TTicketingSendToEPOS.OnUpdate;
begin
  UpdateJobStatus;
  sleep(30);
end;

procedure TTicketingSendToEPOS.btSendClick(Sender: TObject);
var
  i: integer;
  SelIndex: integer;
  SelCount: integer;
  EstBitsPerSecond: integer;
begin
  SelCount := 0;
  EstBitsPerSecond := 99999;
  for i := 0 to Pred(clbPrinterList.Count) do
    if clbPrinterList.Checked[i] then
    begin
      inc(SelCount);
      if EstBitsPerSecond > PrinterDetails[i].EstBitsPerSecond then
        EstBitsPerSecond := PrinterDetails[i].EstBitsPerSecond;
    end;

  if SelCount = 0 then
    raise Exception.Create('Please select some items first!');



  StartTime := now;
  pbProgress.Position := 0;
  ETA_ms := (Length(ImageData)*8*1000) div EstBitsPerSecond;
  ProgressTimer.Interval := ETA_ms div (2*(pbProgress.Max - pbProgress.Min));
  ProgressTimer.Enabled := true;
  clbPrinterList.Enabled := false;

  TicketSendThread := TTicketSendThread.Create(true);

  SelIndex := 0;
  for i := low(PrinterDetails) to high(PrinterDetails) do
  begin
    PrinterDetails[i].Selected := clbPrinterList.Checked[i];
    if PrinterDetails[i].Selected then
    begin
      PrinterDetails[i].PrintState := psNull;
      SetLength(TicketSendThread.PrinterDetails, SelIndex+1);
      TicketSendThread.PrinterDetails[SelIndex] := PrinterDetails[i];
      inc(SelIndex);
    end;
  end;

  with TicketSendThread do
  begin
    OnTerminate := HandleSendFinished;
    OnUpdate := Self.OnUpdate;
    Resume;
  end;
  TButton(Sender).Enabled := false;
end;

procedure TTicketingSendToEPOS.HandleSendFinished(Sender: TObject);
begin
  ProgressTimer.Enabled := false;
  clbPrinterList.Enabled := true;
  btSend.Enabled := true;
  pbProgress.Position := 0;
  TicketSendThread.Free;
  TicketSendThread := nil;
end;

procedure TTicketingSendToEPOS.ProgressTimerTimer(Sender: TObject);
begin
  pbProgress.Position := pbProgress.Min + round(((now-StartTime) / (ETA_ms / MSecsPerDay)) * (pbProgress.Max-pbProgress.Min));
end;

procedure TTicketingSendToEPOS.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Assigned(TicketSendThread) then
  begin
    if MessageDlg('Print jobs are in progress. If you exit now, they will remain in the print queue until the terminals are rebooted.'+#13+
      'Are you sure you want to exit?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        CanClose := false;
  end;
end;

procedure TTicketingSendToEPOS.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TTicketingSendToEPOS.UpdateJobStatus;
var
  i: integer;
begin
  clbPrinterList.Clear;
  for i := low(PrinterDetails) to high(PrinterDetails) do
  begin
    clbPrinterList.Checked[
      clbPrinterList.Items.Add(PrinterDetails[i].Name + ' : '+PrinterDetails[i].GetStatus)
    ] := PrinterDetails[i].Selected;
  end;
end;

procedure TTicketingSendToEPOS.SelectAll1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Pred(clbPrinterList.Count) do
    clbPrinterList.Checked[i] := true;
end;

procedure TTicketingSendToEPOS.SelectNone1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Pred(clbPrinterList.Count) do
    clbPrinterList.Checked[i] := false;
end;

end.
