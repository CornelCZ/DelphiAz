unit uEditDefaultPanelCycle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, DBCtrls, Grids, Wwdbigrd, Wwdbgrid,
  CheckLst, ComCtrls, StrUtils, ExtCtrls;

type
  TPanelTimings = packed record
    StartTime, EndTime: TDateTime;
    ValidDays: String;
  end;

type
  TEditDefaultPanelCycle = class(TForm)
    btCancel: TButton;
    gbxTimeCycles: TGroupBox;
    btnAdd: TButton;
    btnRemove: TButton;
    gbxActiveTimes: TGroupBox;
    btnNewTimePeriod: TButton;
    btnDeleteTimePeriod: TButton;
    pnlTimePeriodEdit: TPanel;
    Label45: TLabel;
    lblStartTime: TLabel;
    lblEndTime: TLabel;
    dtStartTime: TDateTimePicker;
    dtEndTime: TDateTimePicker;
    clbValidDays: TCheckListBox;
    dbgridValidTimes: TwwDBGrid;
    lblPanel: TLabel;
    cbxPanelList: TComboBox;
    lblPanelDesign: TLabel;
    cbxPanelDesign: TComboBox;
    qPanelCycles: TADOQuery;
    dtsPanelCycles: TDataSource;
    dbgTimeCycleList: TwwDBGrid;
    qTimePeriods: TADOQuery;
    dtsTimePeriods: TDataSource;
    qTimePeriodsID: TLargeintField;
    qTimePeriodsCycleID: TLargeintField;
    qTimePeriodsPanelID: TIntegerField;
    qTimePeriodsDayOfWeekDisplay: TStringField;
    qTimePeriodsPanelName: TStringField;
    qTimePeriodsStartTime: TTimeField;
    qTimePeriodsEndTime: TTimeField;
    qTimePeriodsDayOfWeek: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnNewTimePeriodClick(Sender: TObject);
    procedure qTimePeriodsAfterScroll(DataSet: TDataSet);
    procedure clbValidDaysClickCheck(Sender: TObject);
    procedure qTimePeriodsCalcFields(DataSet: TDataSet);
    procedure dtStartTimeChange(Sender: TObject);
    procedure dtEndTimeChange(Sender: TObject);
    procedure cbxPanelListChange(Sender: TObject);
    procedure qPanelCyclesAfterScroll(DataSet: TDataSet);
    procedure btnDeleteTimePeriodClick(Sender: TObject);
    procedure cbxPanelDesignSelect(Sender: TObject);
    procedure qTimePeriodsBeforeScroll(DataSet: TDataSet);
    procedure qPanelCyclesBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
    PanelTimesCount : Integer;
    PanelTimes : Array[0..20] of TPanelTimings;
    RolloverTime: TDateTime;
    Deleted : Boolean;
    function GetPanelDesigns: TStrings;
    procedure GetDefaultPanelCycles;
    procedure InitialisePanelTimes;
    function ValidDaysStrFromCheckboxes(
      ValidDaysCheckboxes: TCheckListBox): String;
    function ValidDaysDisplay(ValidDays: string): string;
    procedure TogglePanelOptions(isEnabled: Boolean);
    function GetPanelName(PanelID: Int64): String;
    function ValidTimePeriods: Boolean;
    function ValidateTimePeriods: Boolean;
    function OverlappingPeriod(NewStartTime, NewEndTime: TDateTime;
             NewValidDays: String; EditingPeriod: integer = -1): boolean;
    function AdjustToRolloverRelative(Input: TDateTime):TDateTime;
    function NotValidTimes: Boolean;
    function timecycleInUse: boolean;
  public
    { Public declarations }
    FSiteCode, FThemeID, FPanelDesignID : Integer;
    PanelList, PanelDesignNames: TStringList;
    modified : Boolean;
    function GetPanelList: TStrings;
  published
    property ModalResult;
  end;

var
  EditDefaultPanelCycle: TEditDefaultPanelCycle;

implementation

uses uADO, udmThemeData, uAddDefaultPanelCycle, uGenerateThemeIDs, uAztecLog;

type TTimePeriod = packed record StartMin, EndMin: word; end;

function DateTimeToMins(Input: TDateTime):integer;
var
  Hours, Minutes, Dummy: word;
begin
  DecodeTime(Input,Hours,Minutes,Dummy,Dummy);
  Result := Hours * 60 + Minutes;
end;

function Overlap(in1: TTimePeriod; in2: TTimePeriod): boolean;
begin
  Result := ((in2.StartMin >= in1.StartMin) and (in2.StartMin <= in1.EndMin)) or
   ((in2.EndMin >= in1.StartMin) and (in2.EndMin <= in1.EndMin));
end;

{$R *.dfm}

function TEditDefaultPanelCycle.GetPanelList: TStrings;
begin
    PanelList.Clear;
    with dmADO.qRun do
    try
      Close;
      SQL.Text := 'declare @result table(id int, name varchar(100))  '+
                  'declare @paneldesignid int '+
                  'set @paneldesignid = '+ IntToStr(FPanelDesignID) +''+

                  'insert @result select 0, ''Root'' '+
                  'insert @result select tableplanid, ''Table Plan "'' +name+''"''  '+
                  'from  ThemeTablePlan where '+
                  'themeid = (select top 1 themeid from ThemePanelDesign where paneldesignid = @paneldesignid) '+
                  'insert @result        '+
                  'select panelid, name from themepanel     '+
                  'where paneltype = 3 and paneldesignid = @paneldesignid   '+
                  'and panelid not in     '+
                  '(                       '+
                  'select root from themepaneldesign where paneldesignid = @paneldesignid '+
                  'union '+
                  'select correctaccount from themepaneldesign where paneldesignid = @paneldesignid '+
                  ') '+
                  'union  '+
                  'select ts.panelid, tp.name from themepanelbutton tpb  '+
                  '         join themepanelsharedpos ts on CAST(ts.panelid as varchar) = tpb.ButtonTypeChoiceAttr01  '+
                  '         join themepanel tp on tp.panelid = ts.panelid  '+
                  'where ts.paneldesignid = @paneldesignid  '+
                  'order by name  '+
                  'select * from @result';
      Open;
      while not EOF do
      begin
        PanelList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('ID').AsInteger)));
        Next;
      end
    finally
      Close;
    end;
  Result := PanelList;
end;


procedure TEditDefaultPanelCycle.FormShow(Sender: TObject);
begin
  PanelDesignNames := TStringList.Create;
  PanelList := TStringList.Create;

  GetDefaultPanelCycles;
  InitialisePanelTimes;
end;

function TEditDefaultPanelCycle.GetPanelDesigns: TStrings;
begin
  with dmThemeData.adoqRun do
     begin
       Close;
       SQL.Text := Format('SELECT PanelDesignID, Name '+
                          '       FROM ThemePanelDesign '+
                          '  WHERE ThemeID = %d ',[FThemeID]);
       Open;

       First;
       while not EOF do
       begin
         PanelDesignNames.AddObject(FieldByName('Name').AsString, TObject((FieldByName('PanelDesignID').AsInteger)));
         Next;
       end;
     end;
   Result := PanelDesignNames;
end;

procedure TEditDefaultPanelCycle.btCancelClick(Sender: TObject);
begin
  if ValidTimePeriods then
     begin
       ModalResult := mrOk;
       PanelDesignNames.Free;
       PanelList.Free;
     end
end;

procedure TEditDefaultPanelCycle.GetDefaultPanelCycles;
begin
  with qPanelCycles do
    begin
       Close;
       SQL.Text := Format('SELECT ID, Name, PanelDesignID '+
                          '       FROM ThemeDefaultPanelCycles '+
                          '  WHERE PanelDesignID = %d ', [FPanelDesignID]);
       Open;
    end;

    dtsPanelCycles.DataSet := qPanelCycles;
end;

procedure TEditDefaultPanelCycle.btnAddClick(Sender: TObject);
begin
  if not ValidTimePeriods then
     abort
  else
    with TAddDefaultPanelCycle.Create(nil) do
      try
         PanelDesignID := FPanelDesignID;
         if ShowModal = mrOk then
            begin
              with qPanelCycles do
                begin
                  Insert;
                  FieldByName('ID').AsInteger := GetNewId(scThemeDefaultPanelCycle);
                  FieldByName('Name').AsString := edtCycleName.Text;
                  FieldByName('PanelDesignID').AsInteger := FPanelDesignID;
                  Post;
                  Log('Time Cycle '+edtCycleName.Text+' created.');
                end;
              qPanelCycles.Close;
              qPanelCycles.Open;
            end;

      finally
          free;
    end;
end;



procedure TEditDefaultPanelCycle.btnRemoveClick(Sender: TObject);
begin
  if qPanelCycles.RecordCount <= 0 then
     raise Exception.Create('There are no Time Cycles available.')
else
  if MessageDlg('Are you sure you wish to delete this Time Cycle?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       if timecycleInUse then
          begin
            if MessageDlg('This Time Cycle has been assigned to one or more Terminals.'+ #10#13 +
                          'Do you wish to continue to delete this Time Cycle and remove it from all Terminals?', mtWarning, [mbYes,mbNo], 0) = mrYes then
               begin
                 with dmADO.qRun do
                    begin
                      SQL.Text := format('UPDATE ThemeEposDesign SET DefaultCycleID = NULL '+
                                        '       WHERE DefaultCycleID = %d ', [dbgTimeCycleList.DataSource.DataSet.FieldByName('ID').AsInteger]);
                      ExecSQL;
                    end;
                end
                 else
                   exit;
                end;

         with qPanelCycles do
            begin
               if Locate('ID', dbgTimeCycleList.DataSource.DataSet.FieldByName('ID').AsInteger, []) then
                  delete;
               Log('Time Cycle '+ dbgTimeCycleList.DataSource.DataSet.FieldByName('Name').AsString +' has been deleted.');
            end;

         qTimePeriods.Close;
         qTimePeriods.Open;

         initialisePanelTimes;
     end;
end;

function TEditDefaultPanelCycle.timecycleInUse : boolean;
begin
  Result := False;
  with dmADO.qRun do
    begin
      SQL.Text := Format('SELECT * FROM ThemeEposDesign WHERE DefaultCycleID = %d ', [dbgTimeCycleList.DataSource.DataSet.FieldByName('ID').AsInteger]);
      Open;

      if recordCount > 0 then
         Result := True;
    end;
end;

procedure TEditDefaultPanelCycle.btnNewTimePeriodClick(Sender: TObject);
begin
  if qPanelCycles.RecordCount <= 0 then
     raise Exception.Create('There are no Time Cycles available.')
  else
  if not ValidTimePeriods then
     abort
  else
    begin
      qTimePeriods.Insert;
      TogglePanelOptions(True);
      qTimePeriodsID.Value := GetNewId(scThemeDefaultPanelTimes);
      qTimePeriodsPanelID.Value := 0;
      qTimePeriodsCycleID.Value := dbgTimeCycleList.DataSource.DataSet.FieldByName('ID').AsInteger;
      dtStartTime.Time := StrToDateTime('00:00:00');
      dtEndTime.Time := StrToDateTime('23:59:00');
      qTimePeriodsStartTime.Value := dtStartTime.Time;
      qTimePeriodsEndTime.Value := dtEndTime.Time;

      qTimePeriods.Post;
      Log('New Time Period created for Time Cycle ' + dbgTimeCycleList.DataSource.DataSet.FieldByName('Name').AsString + '.');
      modified := True;

    end;
end;

procedure TEditDefaultPanelCycle.qTimePeriodsAfterScroll(DataSet: TDataSet);
var i : integer;
begin
   for i := 1 to 7 do
       clbValidDays.Checked[i - 1] := Pos(IntToStr(i), IntToStr(qTimePeriodsDayOfWeek.Value)) <> 0;

   dtStartTime.Time := qTimePeriodsStartTime.Value;
   dtEndTime.Time := qTimePeriodsEndTime.Value;

   cbxPanelList.ItemIndex := PanelList.IndexOfObject(TObject(qTimePeriodsPanelID.Value));
end;

procedure TEditDefaultPanelCycle.InitialisePanelTimes;
var i : integer;
begin
  for i := 1 to 7 do
    clbValidDays.Checked[i - 1] := Pos(IntToStr(i), IntToStr(0)) <> 0;


  PanelDesignNames.Clear;
  cbxPanelDesign.Items.Assign(GetPanelDesigns);
  cbxPanelDesign.ItemIndex := PanelDesignNames.IndexOfObject(TObject(FPanelDesignID));

  PanelList.Clear;
  cbxPanelList.Items.Assign(GetPanelList);

  qTimePeriods.Close;
  qTimePeriods.Parameters.ParamByName('CycleID').Value := dbgTimeCycleList.DataSource.DataSet.FieldByName('ID').AsInteger;
  qTimePeriods.Open;

  if qTimePeriods.RecordCount <> 0 then
    begin
      if qTimePeriodsPanelID.Value <> 0 then
         cbxPanelList.ItemIndex := PanelList.IndexOfObject(TObject(qTimePeriodsPanelID.Value))
      else
         cbxPanelList.ItemIndex := PanelList.IndexOfObject(TObject(0));
     end
  else
    begin
      dtStartTime.Time := StrToDateTime('00:00:00');
      dtEndTime.Time := StrToDateTime('23:59:00');
    end;

  TogglePanelOptions(qTimePeriods.RecordCount > 0);
end;

procedure TEditDefaultPanelCycle.clbValidDaysClickCheck(Sender: TObject);
begin
  qTimePeriods.Edit;
  qTimePeriodsDayOfWeek.Value := StrToInt(ValidDaysStrFromCheckboxes(clbValidDays));
  qTimePeriods.Post;
  modified := True;
end;

function TEditDefaultPanelCycle.ValidDaysStrFromCheckboxes(ValidDaysCheckboxes: TCheckListBox): String;
var day: integer;
begin
  Result := '0';
  for day := 1 to 7 do
    if ValidDaysCheckboxes.Checked[day-1] then
    begin
      Result := Result + IntToStr(day);
    end;
end;

procedure TEditDefaultPanelCycle.qTimePeriodsCalcFields(DataSet: TDataSet);
begin
  if not deleted then
     begin
       qTimePeriodsDayOfWeekDisplay.Value := ValidDaysDisplay(IntToStr(qTimePeriodsDayOfWeek.Value));
       qTimePeriodsPanelName.Value := GetPanelName(qTimePeriodsPanelID.value);
     end;
end;

function TEditDefaultPanelCycle.GetPanelName(PanelID:Int64) : String;
var i : integer;
begin
  for i:= 0 to Pred(PanelList.Count) do
    begin
      if Integer(PanelList.Objects[i]) = PanelID then
         result := PanelList.Strings[i]
    end;
end;

function TEditDefaultPanelCycle.ValidDaysDisplay(ValidDays: string): string;
const DAY_NAME: array[1..7] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
var
  ValidDaysDisplay: string;
  i: integer;
  MaxIndex: integer;
begin
  ValidDaysDisplay := '';

  i := 1;
  while i < 8 do
  begin
    if Pos(IntToStr(i), ValidDays) <> 0 then
    begin
      MaxIndex := i;
      while MaxIndex < 8 do
      begin
        if Pos(InttoStr(MaxIndex+1), ValidDays) = 0 then
          break;
        inc(MaxIndex);
      end;

      if (i <> MaxIndex) then
      begin
        ValidDaysDisplay := ValidDaysDisplay +
          Format('%s-%s,', [DAY_NAME[i], DAY_NAME[MaxIndex]]);
        i := MaxIndex+1;
      end
      else
        ValidDaysDisplay := ValidDaysDisplay + Format('%s,', [DAY_NAME[i]]);
    end;
    i := i + 1;
  end;

  Result := Copy(ValidDaysDisplay, 1, Length(ValidDaysDisplay)-1);
end;

procedure TEditDefaultPanelCycle.TogglePanelOptions(isEnabled:Boolean);
begin
  cbxPanelList.Enabled := isEnabled;
  clbValidDays.Enabled := isEnabled;
  dtStartTime.Enabled := isEnabled;
  dtEndTime.Enabled := isEnabled;
end;

procedure TEditDefaultPanelCycle.dtStartTimeChange(Sender: TObject);
begin
  qTimePeriods.Edit;
  qTimePeriodsStartTime.Value := dtStartTime.Time;
  qTimePeriods.Post;
  modified := True;
end;

procedure TEditDefaultPanelCycle.dtEndTimeChange(Sender: TObject);
begin
  qTimePeriods.Edit;
  qTimePeriodsEndTime.Value := dtEndTime.Time;
  qTimePeriods.Post;
  modified := True;
end;

procedure TEditDefaultPanelCycle.cbxPanelListChange(Sender: TObject);
begin
  qTimePeriods.Edit;
  qTimePeriodsPanelID.Value := Integer(cbxPanelList.Items.Objects[cbxPanelList.ItemIndex]);
  qTimePeriods.Post;
  modified := True;
end;

procedure TEditDefaultPanelCycle.qPanelCyclesAfterScroll(DataSet: TDataSet);
begin
  InitialisePanelTimes 
end;

procedure TEditDefaultPanelCycle.btnDeleteTimePeriodClick(Sender: TObject);
begin
  if qTimePeriods.RecordCount <= 0 then
     raise Exception.Create('There are no Time Periods available.')
else
  if MessageDlg('Are you sure you wish to delete this Time Period?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       Deleted := True;
       with qTimePeriods do
          begin
            if Locate('ID', dbgridValidTimes.DataSource.DataSet.FieldByName('ID').AsInteger, []) then
               delete;
            Log('Time Period '+ dbgridValidTimes.DataSource.DataSet.FieldByName('ID').AsString +
                'deleted for Time Cycle ' + dbgTimeCycleList.DataSource.DataSet.FieldByName('Name').AsString +'.');
            Deleted := False;
          end;

       modified := false;
       InitialisePanelTimes;
     end;
end;

function TEditDefaultPanelCycle.ValidTimePeriods : Boolean;
begin
  Result := True;
  if modified then
     begin
       if qTimePeriodsDayOfWeek.value = 0 then
          begin
            MessageDlg('The selected Time Period is invalid.  Please select at least one day.', mtWarning,[mbOk],0);
            Result := false;
          end
       else
       if NotValidTimes then
          begin
            MessageDlg('The Start and End Times are invalid.', mtWarning,[mbOk],0);
            Result := false;
          end
       else
       if ValidateTimePeriods then
          begin
            MessageDlg('The Start or End Time overlap with another Time Period.', mtWarning,[mbOk],0);
            Result := false;
          end
       else
          modified := False;
     end;
end;

procedure TEditDefaultPanelCycle.cbxPanelDesignSelect(Sender: TObject);
begin
  if not ValidTimePeriods then
     cbxPanelDesign.ItemIndex := PanelDesignNames.IndexOfObject(TObject(FPanelDesignID))
  else
    begin
      FPanelDesignID := Integer(cbxPanelDesign.Items.Objects[cbxPanelDesign.ItemIndex]);
      GetDefaultPanelCycles;
      InitialisePanelTimes;
    end;
end;

function TEditDefaultPanelCycle.ValidateTimePeriods : Boolean;
begin
  Result := False;

  PanelTimesCount := 0;

  dmADO.qRun.Clone(qTimePeriods);

  while not dmADO.qRun.Eof do
    begin
      with dmADO.qRun, PanelTimes[PanelTimesCount] do
        begin
          starttime := frac(FieldByName('StartTime').AsDateTime);
          endtime := frac(FieldByName('EndTime').AsDateTime);
          validdays := FieldByName('DayOfWeek').AsString;

          if OverlappingPeriod(starttime, EndTime, ValidDays) then
             Result := True;
        end;
      inc(PanelTimesCount);
      dmADO.qRun.next;
    end;
end;

function TEditDefaultPanelCycle.NotValidTimes : Boolean;
begin
  Result := False;

  PanelTimesCount := 0;

  dmADO.qRun.Clone(qTimePeriods);

  while not dmADO.qRun.Eof do
    begin
      with dmADO.qRun, PanelTimes[PanelTimesCount] do
        begin
          if FieldByName('StartTime').AsDateTime > FieldByName('EndTime').AsDateTime then
             Result := True
          else
          if FieldByName('EndTime').AsDateTime < FieldByName('StartTime').AsDateTime then
             Result := True
          else
          if FieldByName('StartTime').AsDateTime = FieldByName('EndTime').AsDateTime then
             Result := True;
        end;
      inc(PanelTimesCount);
      dmADO.qRun.next;
    end;
end;


function TEditDefaultPanelCycle.OverlappingPeriod(NewStartTime, NewEndTime: TDateTime;
  NewValidDays: String; EditingPeriod: integer = -1): boolean;
var
  CurrentTimePeriods: array[0..399] of TTimePeriod;
  CurrentTimePeriodsCount: integer;
  NewTimePeriods: array[0..9] of TTimePeriod;
  NewTimePeriodsCount: integer;
  i,j: integer;
begin
  CurrentTimePeriodsCount := 0;
  NewTimePeriodsCount := 0;
  // build map of adjusted "rollover day minutes" for whole business week
  // subtract 1 minute from end time to produce a closed interval
  for i := 0 to pred(PanelTimesCount) do
  with PanelTimes[i] do
  begin
    for j := 0 to 6 do
      if (AnsiPos( IntToStr(j+1),ValidDays)) > 0 then
      begin
        CurrentTimePeriods[CurrentTimePeriodsCount].StartMin := j*1440+ DateTimeToMins(AdjustToRolloverRelative(StartTime));
        CurrentTimePeriods[CurrentTimePeriodsCount].EndMin := j*1440+ (DateTimeToMins(AdjustToRolloverRelative(EndTime))-1);
        if AdjustToRolloverRelative(EndTime) < AdjustToRolloverRelative(StartTime) then
          CurrentTimePeriods[CurrentTimePeriodsCount].EndMin :=
            CurrentTimePeriods[CurrentTimePeriodsCount].EndMin + 1440;
        Inc(CurrentTimePeriodsCount);
      end;
  end;

  for j := 0 to 6 do
    if (AnsiPos( IntToStr(j+1),NewValidDays)) > 0 then
    begin
      NewTimePeriods[NewTimePeriodsCount].StartMin := j*1440+ DateTimeToMins(AdjustToRolloverRelative(NewStartTime));
      NewTimePeriods[NewTimePeriodsCount].EndMin := j*1440+ (DateTimeToMins(AdjustToRolloverRelative(NewEndTime)) -1);
      if AdjustToRolloverRelative(NewEndTime) < AdjustToRolloverRelative(NewStartTime) then
        NewTimePeriods[NewTimePeriodsCount].EndMin :=
          NewTimePeriods[NewTimePeriodsCount].EndMin + 1440;
      Inc(NewTimePeriodsCount);
    end;

  // check for overlap
  Result := FALSE;
  for i := 0 to pred(NewTimePeriodsCount) do
    for j := 0 to pred(CurrentTimePeriodsCount) do
    begin
      if Overlap(NewTimePeriods[i],CurrentTimePeriods[j]) then
      begin
        Result := TRUE;
        break;
      end;
    end;
end;

function TEditDefaultPanelCycle.AdjustToRolloverRelative(
  Input: TDateTime): TDateTime;
begin
  Result := Frac(1+Input-RolloverTime);
end;



procedure TEditDefaultPanelCycle.qTimePeriodsBeforeScroll(DataSet: TDataSet);
begin
  if not Deleted then
     if not ValidTimePeriods then
        abort;
end;

procedure TEditDefaultPanelCycle.qPanelCyclesBeforeScroll(DataSet: TDataSet);
begin
  if not ValidTimePeriods then
     Abort;
end;

end.
