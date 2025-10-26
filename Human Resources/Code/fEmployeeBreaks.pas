unit fEmployeeBreaks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons, ExtCtrls,
  FlexiDBGrid;

type
  TEmployeeBreaksForm = class(TForm)
    tblEmployeeBreaks: TADODataSet;
    dsEmployeeBreaks: TDataSource;
    DBGrid: TFlexiDBGrid;

    fldStartTime: TStringField;
    fldDuration: TStringField;
    fldDurationMins: TIntegerField;
    fldBreakStartDate: TDateTimeField;
    fldBreakEndDate: TDateTimeField;
    fldTempID: TIntegerField;
    fldBreakID: TIntegerField;
    fldDeleted: TBooleanField;

    ADOCommand: TADOCommand;
    ADODataSet: TADODataSet;

    lblShiftTimes: TLabel;
    btnInsert: TBitBtn;
    btnDelete: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblEmployeeDetails: TLabel;
    lblTotalBreakTimeTitle: TLabel;
    lblTotalBreakTimeValue: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;

    procedure ValidateTime(Sender: TField);
    procedure btnOKClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridColExit(Sender: TObject);
    procedure tblEmployeeBreaksAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    EmployeeID: Int64;
    ClockInDate, ClockOutDate : TDateTime;
    ChangesSaved : boolean;
    inValidateTimeHandler : boolean;
    procedure Initialise(EmployeeID: Int64; EmployeeName: string; ClockInDate, ClockOutDate: TdateTime);
    function ChangesMade : boolean;
    function MinsToTimeStr (mins : integer) : string;
    function EmptyStrIfNull ( value : variant) : string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function EditBreaks(EmployeeID : Int64; EmployeeName: string; ClockInDate, ClockOutDate : TdateTime) : TModalResult;
    procedure ShowBreaks(EmployeeID : Int64; EmployeeName: string; ClockInDate, ClockOutDate : TdateTime);
    function TotalBreakTime : string;
    function TotalBreakTimeForShift(EmployeeID: Int64; ClockInDate, ClockOutDate: TdateTime) : string;
  end;

implementation

uses uADO, StrUtils, DateUtils, useful, uGlobals, uEmpmnu, dmodule1;

{$R *.dfm}

{ TEmployeeBreaksForm }

constructor TEmployeeBreaksForm.Create(AOwner: TComponent);
begin
  inherited;

  inValidateTimeHandler := false;

  //Create temporary table #EmployeeBreaks which will be used to
  //allow user editing.
  dmADO.DelSQLTable('#EmployeeBreaks');

  with ADOCommand do
  begin
    CommandText :=
      'CREATE TABLE #EmployeeBreaks (' +
      '  [TempID] int IDENTITY (1,1), ' +
      '  [BreakID] int, ' +
      '  [OriginalBreakStartDate] datetime NULL, ' +
      '  [BreakStartDate] datetime NULL, ' +
      '  [StartTime] char(5) NULL, ' +
      '  [OriginalBreakEndDate] datetime NULL, ' +
      '  [BreakEndDate] datetime NULL, ' +
      '  [Duration] char(5) NULL, ' +
      '  [DurationMins] int NULL, ' +
      '  [Deleted] bit NOT NULL DEFAULT 0)';
    Execute;
  end;
end;

procedure TEmployeeBreaksForm.Initialise(EmployeeID: Int64; EmployeeName: string;
                                       ClockInDate, ClockOutDate: TdateTime);
begin
  //Set the seconds part of ClockOutDate to 59 in order that breaks which end on the
  //same minute as ClockOutDate will be included. This to cope with the case
  //where the ClockOutDate has had it's seconds truncated.
  ClockOutDate := RecodeSecond(ClockOutDate, 59);

  Self.EmployeeID := EmployeeID;
  Self.ClockInDate := ClockInDate;
  Self.ClockOutDate := ClockOutDate;
  ChangesSaved := false;

  lblEmployeeDetails.Caption := EmployeeName + '  ' + LeftStr(TimeToStr(ClockInDate), 5) + ' - ' +
                                LeftStr(TimeToStr(ClockOutDate), 5);

  //Add breaks for the given shift to the temporary #EmployeeBreaks table.
  with ADOCommand do
  begin
    CommandText := 'DELETE FROM #EmployeeBreaks';
    Execute;

    CommandText :=
      'INSERT into #EmployeeBreaks (BreakID, '+
                                   'OriginalBreakStartDate, BreakStartDate, StartTime, '+
                                   'OriginalBreakEndDate, BreakEndDate, DurationMins) '+
      'SELECT BreakID, '+
             'BreakStartDate, '+
             'BreakStartDate, '+
             'dbo.TimeFromDateTime(BreakStartDate), '+
             'BreakEndDate, '+
             'BreakEndDate, '+
             'DATEDIFF(minute, BreakStartDate, BreakEndDate) '+
      'FROM EmployeeBreaksAccepted '+
      'WHERE EmployeeID = ' + QuotedStr(IntToStr(EmployeeID))+
       ' AND BreakStartDate >= ' + dmADO.FormatDateTimeForSQL(ClockInDate) +
       ' AND BreakEndDate <= ' + dmADO.FormatDateTimeForSQL(ClockOutDate) +
       ' AND Deleted = 0 ';
    Execute;
  end;

  // Set the Duration field in hh:mm format. Note: Could have used the following SQL in the
  // above query to set the Duration field but decided it was too complex:
  //    REPLACE(STR(FLOOR(DATEDIFF(minute, BreakStartDate, BreakEndDate) / 60), 2) + ':' +
  //            STR(DATEDIFF(minute, BreakStartDate, BreakEndDate) % 60, 2), ' ', '0')
  with tblEmployeeBreaks do
  begin
    Close; //Just in case an error left it open during a previous Edit/ShowBreaks call.
    Open;
    First;
    while not(eof) do
    begin
      Edit;
      FieldByName('Duration').AsString := MinsToTimeStr(FieldByName('DurationMins').AsInteger);
      Post; Next;
    end;
    First;
  end;

  lblTotalBreakTimeValue.Caption := TotalBreakTime;
end;

function TEmployeeBreaksForm.EditBreaks(EmployeeID: Int64; EmployeeName: string;
                                        ClockInDate, ClockOutDate: TdateTime) : TModalResult;
begin
  Initialise(EmployeeID, EmployeeName, ClockInDate, ClockOutDate);

  //Make the form non read-only
  Caption := 'Break Times';
  DBGrid.Options := DBGrid.Options + [dgEditing];
  btnInsert.Enabled := true;
  btnDelete.Enabled := true;
  btnCancel.Enabled := true;

  Result := ShowModal;
end;

procedure TEmployeeBreaksForm.ShowBreaks(EmployeeID: Int64; EmployeeName: string;
                                         ClockInDate, ClockOutDate: TdateTime);
begin
  Initialise(EmployeeID, EmployeeName, ClockInDate, ClockOutDate);

  //Make the form read-only
  Caption := 'Break Times (Read-Only)';
  DBGrid.Options := DBGrid.Options - [dgEditing]; 
  btnInsert.Enabled := false;
  btnDelete.Enabled := false;
  btnCancel.Enabled := false;

  ShowModal;
end;


//Event handler called after user has edited a time. Performs validation of
//the time change.
procedure TEmployeeBreaksForm.ValidateTime(Sender: TField);
var
  StartTimeAsTime, DurationAsTime : TDateTime;
  BreakStartDate, BreakEndDate : TDateTime;
  BreakStartDateStr, BreakEndDateStr, TempIDStr : String;
  OverlappingBreaks : boolean;
begin
  //Note: Because this proc changes the value of the field if it is invalid
  //that will cause this proc to be called again. However we are not interested
  //in validating this change hence the use of inValidateTimeHandler.
  if inValidateTimeHandler then Exit;

  inValidateTimeHandler := true;

  try
    //Check the value is a valid time.
    if (Sender.AsString <> '') and (Sender.AsString <> '  :  ') and not useful.IsValidTime(Sender.AsString) then
    begin
      ShowMessage('"' + Sender.AsString + '" is not a valid time');
      Sender.AsString := EmptyStrIfNull(Sender.OldValue);
      Abort;
    end;

    //Check the break itself is still valid but only if both times have been filled in.
    if (fldStartTime.AsString = '') or (fldStartTime.AsString = '  :  ') or
       (fldDuration.AsString = '') or (fldDuration.AsString = '  :  ') then
    begin
      fldBreakStartDate.Clear;
      fldBreakEndDate.Clear;
      Exit;
    end;

    StartTimeAsTime := StrToTime(fldStartTime.AsString);
    DurationAsTime := StrToTime(fldDuration.AsString);

    //If the break start time is earlier than the Clock In time then assume this is because we've crossed midnight. Set
    //the break start date to the day after the clock in date. Note that we cannot simply use the condition
    //TimeOf(ClockInDate) > StartTimeAsTime due to the different rounding that may have been applied to the two times causing
    //differences of a few pico seconds when in fact the two times started life identical.
    if dMod1.TimeToMins(StartTimeAsTime) < dMod1.TimeToMins(ClockInDate) then
      BreakStartDate := DateOf(ClockInDate) + 1 + StartTimeAsTime
    else
      BreakStartDate := DateOf(ClockInDate) + StartTimeAsTime;

    BreakEndDate :=  BreakStartDate + DurationAsTime;

    if (BreakStartDate < ClockInDate) or (BreakEndDate > ClockOutDate) then
    begin
      ShowMessage('Break starting '+ fldStartTime.AsString + ' does not lie within shift');
      Sender.AsString := EmptyStrIfNull(Sender.OldValue);
      Abort;
    end;

    //Check break doesn't overlap with an existing break.
    BreakStartDateStr := dmADO.FormatDateTimeForSQL(BreakStartDate);
    BreakEndDateStr := dmADO.FormatDateTimeForSQL(BreakEndDate);
    if fldTempID.IsNull then TempIDStr := '-1' else TempIDstr := fldTempID.AsString;

    with ADODataSet do
    begin
      Close;
      CommandText :=
        'SELECT COUNT(*) AS Count FROM #EmployeeBreaks '+
        'WHERE tempID <> '+ TempIDStr + ' AND Deleted = 0 AND ' +
              '(('+BreakStartDateStr+' >= BreakStartDate AND '+BreakStartDateStr+' <  BreakEndDate) OR '+
              ' ('+BreakEndDateStr+'   > BreakStartDate  AND '+BreakEndDateStr+'   <= BreakEndDate) OR '+
              ' ('+BreakStartDateStr+' < BreakStartDate  AND '+BreakEndDateStr+'   >  BreakEndDate))';
      Open;
      OverlappingBreaks := (FieldByName('Count').AsInteger > 0);
      Close;
    end;

    if OverlappingBreaks then
    begin
      ShowMessage('Break starting ' + fldStartTime.AsString + ' overlaps another break');
      Sender.AsString := EmptyStrIfNull(Sender.OldValue);
      Abort;
    end;

    //All validation OK so update the BreakStartDate and BreakEndDateFields.
    fldBreakStartDate.AsDateTime := BreakStartDate;
    fldBreakEndDate.AsDateTime := BreakEndDate;
  finally
    inValidateTimeHandler := false;
  end;
end;

//Save changes in #EmployeeBreaks to the EmployeeBreaksAccepted table
procedure TEmployeeBreaksForm.btnOKClick(Sender: TObject);
begin
  if tblEmployeeBreaks.State in [dsEdit, dsInsert] then
    tblEmployeeBreaks.Post;

  dmADO.BeginTransaction;

  try
    with ADOCommand do
    begin
      CommandText :=
        //Mark as deleted any breaks which were present on entry to this form
        //but are now invalid due to user backspacing the time.
        'UPDATE #EmployeeBreaks '+
        'SET Deleted = 1, '+
            'BreakStartDate = OriginalBreakStartDate, '+
            'BreakEndDate = OriginalBreakEndDate '+
        'WHERE BreakID IS NOT NULL AND ((BreakStartDate IS NULL) OR (BreakEndDate IS NULL))';
      Execute;

      //Ignore incomplete break records added in this session
      CommandText :=
        'DELETE FROM #EmployeeBreaks '+
        'WHERE BreakID IS NULL AND ((BreakStartDate IS NULL) OR (BreakEndDate IS NULL))';
      Execute;

      //Update records in EmployeeBreaksAccepted with changes.
      CommandText :=
        'UPDATE EmployeeBreaksAccepted '+
        'SET BreakStartDate = t.BreakStartDate, '+
            'BreakEndDate   = t.BreakEndDate, '+
            'Deleted        = t.Deleted, '+
            'ModifiedBy     = ' + QuotedStr(CurrentUser.UserName) + ' ' +
        'FROM (SELECT * FROM #EmployeeBreaks '+
              'WHERE BreakStartDate <> OriginalBreakStartDate OR '+
                    'BreakEndDate <> OriginalBreakEndDate OR '+
                    'Deleted = 1) t '+
        'WHERE EmployeeBreaksAccepted.BreakID = t.BreakID';
      Execute;

      //Insert new records into EmployeeBreaksAccepted. A record in
      //#Employeebreaks is known to be new if the BreakID field is null.
      CommandText :=
        'INSERT INTO EmployeeBreaksAccepted (SiteCode, EmployeeID, BreakStartDate, BreakEndDate, ModifiedBy) '+
        'SELECT '+IntToStr(uGlobals.SiteCode)+','+IntToStr(EmployeeID)+',BreakStartDate, BreakEndDate, '+QuotedStr(CurrentUser.UserName)+' '+
        'FROM #EmployeeBreaks t '+
        'WHERE t.BreakID IS NULL';
      Execute;
    end;

    dmAdo.CommitTransaction;
    ChangesSaved := true;
    tblEmployeeBreaks.Close;
    ModalResult := mrOK;
  finally
    if dmADO.InTransaction then
    begin
      dmADO.RollbackTransaction;
    end;
  end;
end; //TEmployeeBreaksForm.btnOKClick


procedure TEmployeeBreaksForm.btnDeleteClick(Sender: TObject);
begin
  if tblEmployeeBreaks.IsEmpty then
    Exit;

  if MessageDlg('Delete break starting ' + fldStartTime.AsString + ' ?',
                  mtConfirmation, [mbYes, mbNo],0) = mrNo then
    Exit;

  if fldBreakID.IsNull then
  begin
    tblEmployeeBreaks.Delete
  end else begin
    tblEmployeeBreaks.Edit;
    fldDeleted.AsBoolean := true;
    tblEmployeeBreaks.Post;
  end;
end;


procedure TEmployeeBreaksForm.btnInsertClick(Sender: TObject);
begin
  tblEmployeeBreaks.Insert;
  DBGrid.SetFocus;
end;

// Return true if user has made any changes
function TEmployeeBreaksForm.ChangesMade: boolean;
begin
  //Note: In the query below the check to see if BreakID is null is necessary
  //to catch new records. OriginalBreakStart(End)Date will be null therefore
  //comparison with BreakStart(End)Date will not equal true.
  with ADODataSet do
  begin
    Close;
    CommandText :=
      'SELECT COUNT(*) AS Count FROM #EmployeeBreaks '+
      'WHERE BreakID IS NULL OR '+
            'BreakStartDate <> OriginalBreakStartDate OR '+
            'BreakEndDate <> OriginalBreakEndDate OR '+
            'Deleted = 1';
    Open;
    Result := (FieldByName('Count').AsInteger > 0);
    Close;
  end;
end;

procedure TEmployeeBreaksForm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caHide;

  if not(ChangesSaved) and ChangesMade then
  begin
    if MessageDlg('Break times have been changed. Are you'+#13+#10+
                  'sure you want to abandon these changes ?',
                  mtConfirmation, [mbYes, mbNo],0) = mrNo then
      Action := caNone;
  end;

  if Action = caHide then tblEmployeeBreaks.Close;
end;

function TEmployeeBreaksForm.EmptyStrIfNull(value: variant): string;
begin
  if VarIsNull(value) then
    Result := ''
  else
    Result := value;
end;

//Convert a number of mins to a string formatted as 'hh:mm'
function TEmployeeBreaksForm.MinsToTimeStr(mins : integer) : string;
begin
  mins := mins mod 1440;
  Result := Format('%.2d:%.2d', [mins div 60, mins mod 60]);
end;

//Return in hh:mm string format the sum of all breaks in #EmployeeBreaks
function TEmployeeBreaksForm.TotalBreakTime: string;
begin
  with ADODataSet do
  begin
    Close;
    CommandText :=
      'SELECT ISNULL(SUM(DATEDIFF(minute, BreakStartDate, BreakEndDate)), 0) AS Total '+
      'FROM #EmployeeBreaks '+
      'WHERE BreakStartDate IS NOT NULL AND '+
            'BreakEndDate IS NOT NULL AND '+
            'Deleted = 0';
    Open;
    Result := MinsToTimeStr(FieldByName('Total').AsInteger);
    Close;
  end;
end;

//Return in hh:mm string format the sum of all breaks in EmployeeBreaksAccepted which lie
//within the given shift.
function TEmployeeBreaksForm.TotalBreakTimeForShift(EmployeeID: Int64; ClockInDate, ClockOutDate: TdateTime) : string;
begin
  //Set the seconds part of ClockOutDate to 59 in order that breaks which end on the
  //same minute as ClockOutDate will be included. This to cope with the case
  //where the ClockOutDate has had it's seconds truncated.
  ClockOutDate := RecodeSecond(ClockOutDate, 59);

  with ADODataSet do
  begin
    Close;
    CommandText :=
      'SELECT ISNULL(SUM(DATEDIFF(minute, BreakStartDate, BreakEndDate)), 0) AS Total '+
      'FROM EmployeeBreaksAccepted '+
      'WHERE EmployeeID = ' + QuotedStr(IntToStr(EmployeeID))+ ' AND ' +
            'BreakStartDate >= ' + dmADO.FormatDateTimeForSQL(ClockInDate) + ' AND '+
            'BreakEndDate <= ' + dmADO.FormatDateTimeForSQL(ClockOutDate) + ' AND '+
            'Deleted = 0';
    Open;
    Result := MinsToTimeStr(FieldByName('Total').AsInteger);
    Close;
  end;
end;

//Post record to #EmployeeBreaks when user changes the column in the grids
//so that total will be re-calculated.
procedure TEmployeeBreaksForm.DBGridColExit(Sender: TObject);
begin
  //Only post the record if their are non-null fields otherwise an
  //exception will be raised.
  with tblEmployeeBreaks do
    if (State in [dsEdit, dsInsert]) and
       not(FieldByName('TempID').IsNull and
           FieldByName('BreakID').IsNull and
           FieldByName('BreakStartDate').IsNull and
           FieldByName('BreakEndDate').IsNull)
    then
      tblEmployeeBreaks.Post;
end;

//Recalculate total break time on the form
procedure TEmployeeBreaksForm.tblEmployeeBreaksAfterPost(DataSet: TDataSet);
begin
  lblTotalBreakTimeValue.Caption := TotalBreakTime;
end;

end.

//TODO: Stop grid showing same value in fields above field in error when error dialog is displayed.
//TODO: If keyboard used after entering a duff time the field does not revert back to old value after
//      error dialog is cleared
