unit uEditTimedJobSecurity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, DB, uGenerateThemeIDs, ADODB, uTillButton,
  ExtCtrls, ActnList, uAdo;

const NULL_JOB_CODE = '-22222';

type
  TRequestWitnessState = (rwsFalse, rwsNoAction, rwsTrue);
  TButtonSecurityType = (bstNormal = 0, bstPostBillPrint = 1);

  TComboBoxProtectionHack = class(TCustomCheckBox)
  end;

  TTimedSecurity = packed record
    buttonid, timedsecurityid, commonSercurityID: int64;
    StartTime, EndTime: TDateTime;
    ValidDays: byte;
    ButtonSecurityID: integer;
    modified: boolean;
    deleted: boolean;
  end;

  TCommonSecurity = packed record
    commonSercurityID: int64;
    StartTime, EndTime: TDateTime;
    ValidDays: byte;
    ButtonSecurityID: integer;
    Count: Integer;
    modified: boolean;
    deleted: boolean;
  end;

  TEditTimedJobSecurity = class(TForm)
    btOk: TButton;
    btCancel: TButton;
    qRun: TADOQuery;
    chkbxWitnessRequired: TCheckBox;
    gpbxRoleSecurity: TGroupBox;
    Label2: TLabel;
    cbTimePeriods: TComboBox;
    btAddTimePeriod: TButton;
    btEditTimePeriod: TButton;
    btRemoveTimePeriod: TButton;
    Label1: TLabel;
    clbRoles: TCheckListBox;
    btnSelectAll: TButton;
    btnDeselectAll: TButton;
    alButtonSecurity: TActionList;
    actUseConditionalSecurity: TAction;
    pnlConditionalSecurity: TPanel;
    cmbbxConditionalSecurity: TComboBox;
    lblConditionalSecurity: TLabel;
    cbxUseConditionalSecurity: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btAddTimePeriodClick(Sender: TObject);
    procedure btEditTimePeriodClick(Sender: TObject);
    procedure btRemoveTimePeriodClick(Sender: TObject);
    procedure cbTimePeriodsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbTimePeriodsCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnDeselectAllClick(Sender: TObject);
    procedure OnWitnessRequiredClick(Sender: TObject);
    function allButtonsAreCorrectionMethod(ButtonList: TTillButtonList) : boolean;
    procedure FormDestroy(Sender: TObject);
    procedure cmbbxConditionalSecurityChange(Sender: TObject);
    procedure cmbbxConditionalSecurityDropDown(Sender: TObject);
    procedure cbxUseConditionalSecurityClick(Sender: TObject);
  private
    RolloverTime: TDateTime;
    { Private declarations }
    TimedSecurity: array[0..100] of TTimedSecurity;
    CommonSecurity: array[0..100] of TCommonSecurity;
    TimedSecurityCount, CommonSecurityCount: integer;
    CurrentPeriod: integer;
    FisStaticPanel : Boolean;
    FTimedSecurityTable : string;
    FButtonIDField : string;
    FIDCategory : TThemeIDCategory;
    ButtonNameList : string;
    procedure LoadButtonSecurity(ButtonSecurityId: integer);
    function Getdays(validdays:byte):string;
    function OverlappingPeriod(NewStartTime, NewEndTime: TDateTime;
      NewValidDays: integer; EditingPeriod: integer = -1): boolean;
    procedure SetIsStaticPanel(IsStaticPanel : Boolean);
    function AddMasterSecurityRecord: int64;
    function AddTimePeriod(CommonSecurityID: integer):integer;
    function GetPeriodStartTime(Input: TCommonSecurity): integer;
    function GetPeriodDescription(Input: TCommonSecurity): string;
    function AdjustToRolloverRelative(Input: TDateTime):TDateTime;
    function GetCommonSecurityID(TimedSecurityID: integer): integer;
    procedure UpdateSecuritySettingsFromCommonSecurity;
    procedure buildButtonNameList(ButtonID: int64);
    procedure LoadConditionalSecurityTypes;
    procedure CreateTempTables;
    procedure SetAllocatedJobs(ButtonSecurityType: TButtonSecurityType);
    procedure LoadRoles;
    procedure SaveSecurityTypeRoles(
      ButtonSecurityType: TButtonSecurityType);
    function SaveSecurity: integer;
    procedure LoadTimedButtonSecurity;
    procedure SaveTimedButtonSecurity;
    function ConditionalSecurityIsActive: Boolean;
    procedure SetConditionalSecurity;
    procedure SaveSecurityChanges;
  public
    { Public declarations }
    ButtonSecurityId: integer;
    FStaticPanelButton : TTillButton; {Only initialised if editing a static panel button}
    FThemeID : int64;                 {Only initialised if editing a static panel button}
    FButtonList : TTillButtonList;
    FRequestWitness: TRequestWitnessState;
    procedure SetCommonWitnessRequiredState;
    property isStaticPanel : Boolean read FisStaticPanel write SetIsStaticPanel;
  end;

  function SetStaticPanelSecurity(aThemeID : int64; aButton : TTillButton) : Integer;
  procedure ShowSecurityDlg_FixedPanel(aThemeID, aSecurityID : int64; aStaticPanelButton : TTillButton);
  function RequestWitnessStateFromBoolean(const Value: Boolean): TRequestWitnessState;
  function BooleanFromRequestWitnessState(const Value: TRequestWitnessState; const Default: Boolean): Boolean;
  function RequestWitnessStateFromCheckBoxState(const Value: TCheckBoxState): TRequestWitnessState;
  function CheckBoxStateFromRequestWitnessState(const Value: TRequestWitnessState): TCheckBoxState;
var
  EditTimedJobSecurity: TEditTimedJobSecurity;

implementation

uses uEditTimedJobPeriod, useful, uAztecLog, uDMThemeData;

{$R *.dfm}

type TTimePeriod = packed record StartMin, EndMin: word; ButtonID : Int64 end;

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

procedure ShowSecurityDlg_FixedPanel(aThemeID, aSecurityID : int64; aStaticPanelButton : TTillButton);
var
  Dlg : TEditTimedJobSecurity;
  DummyButton: TTillButton;
begin
  Dlg := nil;
  try
    Dlg := TEditTimedJobSecurity.Create(nil);
    Dlg.isStaticPanel := True;
    Dlg.FThemeID := aThemeID;

    //Due to the way that the buttonlist is "utilised" (aka abused) between standard and timed
    //security we have to create a "button" with a buttonid equal to the security ID we
    //are interested in.  Fix this at the next opportunity.
    DummyButton := TTillButton.create(nil);
    DummyButton.ButtonID := aSecurityID;
    Dlg.FButtonList.Add(DummyButton);

    Dlg.ButtonSecurityId := aStaticPanelButton.ButtonSecurityId;
    Dlg.FRequestWitness := uEditTimedJobSecurity.RequestWitnessStateFromBoolean(aStaticPanelButton.RequestWitness);
    Dlg.FStaticPanelButton := aStaticPanelButton;
    Dlg.ShowModal;
    if Dlg.ModalResult = mrOk then
    begin
      aStaticPanelButton.ButtonSecurityId := Dlg.ButtonSecurityId;
      if Dlg.FRequestWitness <> rwsNoAction then
        aStaticPanelButton.RequestWitness := BooleanFromRequestWitnessState(Dlg.FRequestWitness, aStaticPanelButton.RequestWitness);
      aStaticPanelButton.Invalidate;
    end;
  finally
    Dlg.Free;
  end;
end;


//------------------------------------------------------------------------------
function SetStaticPanelSecurity(aThemeID : int64; aButton : TTillButton) : Integer;
begin
  with dmthemedata.adoqRun do
  begin
    sql.text :=
      'declare @themeid integer, @panelname varchar(50), @buttonname varchar(50), @buttonparam1 varchar(50), @buttonparam2 varchar(50) '+
      'declare @securityid integer, @buttonsecurityid integer, @RequestWitness bit '+
      'set @themeid = :themeid '+
      'set @panelname = (select top 1 DialogPanelName from ThemeDialogPanelSet where Panelid = :panelid) '+
      'set @buttonname = (select name from ThemeButtonTypeChoiceLookup where id = :buttontypeid) '+
      'set @buttonparam1 = :data1 '+
      'set @buttonparam2 = :data2 '+
      'set @buttonsecurityid = :buttonsecurityid '+
      'set @RequestWitness = :RequestWitness '+
      'select @securityid = Securityid '+
      'from themedialogsecurity where themeid = @themeid and dialogname = @panelname and buttontype = @buttonname and '+
      '  isnull(buttonparamfilter1, '''') = isnull(@buttonparam1, '''') and isnull(buttonparamfilter2, '''') = isnull(@buttonparam2, '''') '+
      'if @securityid is null '+
      'begin '+
      '  exec getnextuniqueid ''ThemeDialogSecurity_repl'', ''SecurityID'', 100000, 2147483647 , @securityid OUTPUT '+
      '  insert ThemeDialogSecurity values (@themeid, @securityid, @panelname, @buttonname, @buttonparam1, @buttonparam2, @buttonsecurityid, @RequestWitness) '+
      'end '+
      'else '+
      '  update ThemeDialogSecurity set ButtonSecurityId = @buttonsecurityid, RequestWitness = @RequestWitness where securityid = @securityid '+
      'Update ThemeDialogSecurity_Repl Set ButtonSecurityId = NULL where buttonsecurityid = -2 '+
      'Select @securityid as SecurityID ';
    parameters.ParamByName('themeid').Value := aThemeid;
    parameters.ParamByName('panelid').Value := aButton.panelid;
    parameters.ParamByName('buttontypeid').Value := aButton.ButtonTypeID;
    parameters.ParamByName('data1').Value := aButton.ButtonTypeData;
    parameters.ParamByName('data2').Value := aButton.ButtonTypeData2;
    parameters.ParamByName('ButtonSecurityId').Value := aButton.ButtonSecurityId;
    parameters.ParamByName('RequestWitness').Value := aButton.RequestWitness;
    Open;
    Result := FieldByName('SecurityID').AsInteger;
    Close;
  end;
end;

procedure TEditTimedJobSecurity.FormShow(Sender: TObject);
var
  allSelectionsAreCorrectionMethods : boolean;
begin
  Log('Form Show ' + Caption);
  if ButtonSecurityId = -2 then
    ButtonSecurityId := 0;

  LoadConditionalSecurityTypes;

  LoadRoles;

  LoadButtonSecurity(ButtonSecurityID);

  LoadTimedButtonSecurity;

  chkbxWitnessRequired.State := CheckBoxStateFromRequestWitnessState(FRequestWitness);
  cbTimePeriods.ItemIndex := 0;

  // disable time period controls if button is a correction method
  allSelectionsAreCorrectionMethods := allButtonsAreCorrectionMethod(FButtonList);
  cbTimePeriods.Enabled := not allSelectionsAreCorrectionMethods;
  btAddTimePeriod.Enabled := not allSelectionsAreCorrectionMethods;
  btRemoveTimePeriod.Enabled := not allSelectionsAreCorrectionMethods;
  btEditTimePeriod.Enabled := not allSelectionsAreCorrectionMethods;
end;

procedure TEditTimedJobSecurity.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TEditTimedJobSecurity.btOkClick(Sender: TObject);
var
  i, count: integer;
begin
  ButtonClicked(Sender);
  SaveSecurityChanges;
  SaveTimedButtonSecurity;
  FRequestWitness := uEditTimedJobSecurity.RequestWitnessStateFromCheckBoxState(chkbxWitnessRequired.State);

  {
  ************************* H E R E   B E  D R A G O N S ***********************
  This is modelled after the pre-existing code and needs lots of explaining.
  The code that renders the design grid needs to know if any security is present
  on the button in order to draw the padlock.  However, any given button only
  knows of its own security state and the current class used for modelling a till
  button is designed in such a way as to make the button agnostic of where it
  comes form, i.e. normal panel fixed panel, shared panel, site panel etc.
  This means that we cannot easily determine if a button has timed security
  present while having default security for the'all times' time period and that
  is required to correctly to render the security padlock glyph. The "solution"
  previously used was to use a guard value to indicate the button had default
  security and also other timed security present.  Normally a button with default
  security has a null security value to indicate 'all roles'.  The refactor would
  be pretty extensive to get around this kludge and time does not allow for it.

  In this vein we will employ the guard value -2 to indicate that the button
  has default security and should therefore record its security value as null in
  the underlying DB.
  
  I am sad :-(
  }
  if ButtonSecurityId = 0 then
  begin
    count := 0;
    for i := 0 to pred(Timedsecuritycount) do
      if timedsecurity[i].deleted = false then
        inc(count);
    if count = 0 then
      ButtonSecurityId := -2;
  end;
  modalresult := mrOk;
end;

function TEditTimedJobSecurity.GetCommonSecurityID(TimedSecurityID: integer): integer;
var i : integer;
begin
  for i := 0 to Pred(CommonSecurityCount) do
      if (CommonSecurity[i].StartTime = TimedSecurity[TimedSecurityID].StartTime) and
         (CommonSecurity[i].EndTime = TimedSecurity[TimedSecurityID].EndTime) and
         (CommonSecurity[i].ValidDays = TimedSecurity[TimedSecurityID].ValidDays) then
         begin
              Inc(CommonSecurity[i].Count);
              Result := CommonSecurity[i].commonSercurityID;
              exit;
         end;

  CommonSecurity[CommonSecurityCount].commonSercurityID := CommonSecurityCount;
  CommonSecurity[CommonSecurityCount].StartTime := TimedSecurity[TimedSecurityID].StartTime;
  CommonSecurity[CommonSecurityCount].EndTime := TimedSecurity[TimedSecurityID].EndTime;
  CommonSecurity[CommonSecurityCount].ValidDays := TimedSecurity[TimedSecurityID].ValidDays;
  CommonSecurity[CommonSecurityCount].ButtonSecurityID := TimedSecurity[TimedSecurityID].ButtonSecurityID;
  Inc(CommonSecurity[CommonSecurityCount].Count);
  Result := CommonSecurityCount;

  Inc(CommonSecurityCount);
end;

function TEditTimedJobSecurity.AddMasterSecurityRecord : int64;
begin
  Result := SetStaticPanelSecurity(FThemeID,FStaticPanelButton);
end;

procedure TEditTimedJobSecurity.UpdateSecuritySettingsFromCommonSecurity;
var i, p, tempTimedSecurityCount : integer;
begin
  // update common matched security settings and update them with changes.
  for i := 0 to Pred(CommonSecurityCount) do
      for p := 0 to Pred(TimedSecurityCount) do
           if CommonSecurity[i].commonSercurityID = TimedSecurity[p].commonSercurityID then
              begin
                TimedSecurity[p].StartTime := CommonSecurity[i].StartTime;
                TimedSecurity[p].EndTime := CommonSecurity[i].EndTime;
                TimedSecurity[p].ValidDays := CommonSecurity[i].ValidDays;
                TimedSecurity[p].ButtonSecurityID := CommonSecurity[i].ButtonSecurityID;
                TimedSecurity[p].modified := CommonSecurity[i].modified;
                TimedSecurity[p].deleted := CommonSecurity[i].deleted;
              end;

  //once updates have been applied, add any new timesecurity periods for each button.
  tempTimedSecurityCount := TimedSecurityCount;
  for p := 0 to Pred(FButtonList.Count) do
     for i := 0 to Pred(CommonSecurityCount) do
        if CommonSecurity[i].commonSercurityID = -1 then
           begin
             TimedSecurity[tempTimedSecurityCount].timedsecurityid := 0;
             TimedSecurity[tempTimedSecurityCount].buttonid := FButtonList[p].ButtonID;
             TimedSecurity[tempTimedSecurityCount].StartTime := CommonSecurity[i].StartTime;
             TimedSecurity[tempTimedSecurityCount].EndTime := CommonSecurity[i].EndTime;
             TimedSecurity[tempTimedSecurityCount].ValidDays := CommonSecurity[i].ValidDays;
             TimedSecurity[tempTimedSecurityCount].ButtonSecurityID := CommonSecurity[i].ButtonSecurityID;
             TimedSecurity[tempTimedSecurityCount].modified := CommonSecurity[i].modified;
             TimedSecurity[tempTimedSecurityCount].deleted := CommonSecurity[i].deleted;
             TimedSecurity[tempTimedSecurityCount].commonSercurityID := -1;
             inc(tempTimedSecurityCount);
           end;

  TimedSecurityCount := tempTimedSecurityCount;
end;

function TEditTimedJobSecurity.Getdays(validdays: byte): string;
  function GetBit(data: byte; pos: integer):boolean;
  begin
    result := (data and (1 shl (pos-1)) > 0)
  end;

  function GetDateStr(day: integer):string;
  begin
    case day of
      1: result := 'Mon';
      2: result := 'Tue';
      3: result := 'Wed';
      4: result := 'Thu';
      5: result := 'Fri';
      6: result := 'Sat';
      7: result := 'Sun';
    else
      result := '';
    end;
  end;

var
  i: integer;
  run: boolean;
begin
  result := '';
  run := false;
  for i := 1 to 7 do
  begin
    if getbit(validdays, i) then
    begin
      if run and not getbit(validdays, i+1) then
      begin
        result := result + '-'+getdatestr(i);
        run := false;
      end
      else if not(run) then
      begin
        if not getbit(validdays, i+1) then
        begin
          if result <> '' then
            result := result + ',';
          result := result + getdatestr(i);
          run := false;
        end
        else
        begin
          if result <> '' then
            result := result + ',';
          result := result + getdatestr(i);
          run := true;
        end;
      end;
    end;
  end;
end;

procedure TEditTimedJobSecurity.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  modalresult := mrCancel;
end;

procedure TEditTimedJobSecurity.btAddTimePeriodClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  with TEditJobPeriod.create(nil) do
  try
    if showmodal = mrOk then
        with CommonSecurity[CommonSecurityCount] do
        begin
          commonSercurityID := -1;
          getvalues(starttime, endtime, validdays);
          ButtonSecurityID := -1;
          modified := true;
          if overlappingperiod(starttime, endtime, validdays) then
            begin
              if FButtonList.Count > 1 then
                 raise exception.create('Error: New values would overlap with an existing time period on the following buttons:'+#13#10+ButtonNameList)
              else
                 raise exception.create('Error: New values would overlap with an existing time period.');
              ButtonNameList := '';
            end;
          cbTimePeriods.ItemIndex := AddTimePeriod(CommonSecurityCount);
          Inc(CommonSecurityCount);
        end;
  finally
    free;
  end;
  SaveSecurityChanges;
end;

procedure TEditTimedJobSecurity.btEditTimePeriodClick(Sender: TObject);
var
  tsidx: integer;
  newst, newet: TDateTime;
  newvdays: byte;
begin
  ButtonClicked(Sender);
  if integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]) = 999 then
    raise Exception.create('You may not edit the "All times" time period!');
  tsidx := integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]);
  with CommonSecurity[tsidx] do
  begin
    with TEditJobPeriod.create(nil) do try
      setvalues(starttime, endtime, validdays);
      if showmodal = mrOk then
      begin
        getvalues(newst, newet, newvdays);
        if overlappingperiod(newst, newet, newvdays, CurrentPeriod) then
            begin
              if FButtonList.Count > 1 then
                 raise exception.create('Error: New values would overlap with an existing time period on the following buttons:'+#13#10+ButtonNameList)
              else
                 raise exception.create('Error: New values would overlap with an existing time period.');
              ButtonNameList := '';
            end;
        starttime := newst;
        endtime := newet;
        validdays := newvdays;
        modified := true;
        cbTimePeriods.Items.Delete(cbTimePeriods.ItemIndex);
        cbTimePeriods.ItemIndex := AddTimePeriod(TSIdx);
      end;
    finally
      free;
    end;
  end;
end;

function TEditTimedJobSecurity.OverlappingPeriod(NewStartTime, NewEndTime: TDateTime;
  NewValidDays: integer; EditingPeriod: integer = -1): boolean;
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
  for i := 0 to pred(TimedSecurityCount) do
  with TimedSecurity[i] do
  if (not deleted ) and (i <> EditingPeriod) then
  begin
    for j := 0 to 6 do
      if (ValidDays and (1 shl j)) > 0 then
      begin
        CurrentTimePeriods[CurrentTimePeriodsCount].StartMin := j*1440+  DateTimeToMins(AdjustToRolloverRelative(StartTime));
        CurrentTimePeriods[CurrentTimePeriodsCount].EndMin := j*1440+  (DateTimeToMins(AdjustToRolloverRelative(EndTime))-1);
        CurrentTimePeriods[CurrentTimePeriodsCount].ButtonID := buttonid;
        if AdjustToRolloverRelative(EndTime) < AdjustToRolloverRelative(StartTime) then
          CurrentTimePeriods[CurrentTimePeriodsCount].EndMin :=
            CurrentTimePeriods[CurrentTimePeriodsCount].EndMin + 1440;
        Inc(CurrentTimePeriodsCount);
      end;
  end;

  for j := 0 to 6 do
    if (NewValidDays and (1 shl j)) > 0 then
    begin
      NewTimePeriods[NewTimePeriodsCount].StartMin := j*1440+  DateTimeToMins(AdjustToRolloverRelative(NewStartTime));
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
           buildButtonNameList(CurrentTimePeriods[j].ButtonID);
           Result := TRUE;
        end;
    end;
end;

procedure TEditTimedJobSecurity.buildButtonNameList(ButtonID : int64);
var strButtonOverlap : String;
begin
  if FButtonList.Count > 1 then
     with dmADO.qRun do
     begin
       SQL.Text := Format('SELECT ISNULL(EPoSName1+'' ''+EPoSName2+'' ''+EPoSName3, ft.[Text]) AS ButtonText '+
                          '       FROM ThemePanelButton tpb   '+
                          '            INNER JOIN ThemeButtonTypeChoiceLookup cl ON cl.Id = tpb.ButtonTypeChoiceID  '+
                          '            INNER JOIN ThemeFunctionText ft ON ft.ButtonFunction = cl.Name '+
                          'WHERE ButtonID = %d', [ButtonID]);
       Open;
       First;
       strButtonOverlap := StringReplace(FieldByName('ButtonText').AsString, #$D#$A, ' ',[rfReplaceAll, rfIgnoreCase]);
       if AnsiPos(strButtonOverlap, ButtonNameList) = 0 then
          ButtonNameList := ButtonNameList + #13#10 + strButtonOverlap;
     end;
end;

procedure TEditTimedJobSecurity.btRemoveTimePeriodClick(Sender: TObject);
var
  i: integer;
  tsidx: integer;

  function imin(in1, in2: integer): integer;
  begin
    if in1 < in2 then
      result := in1
    else
      result := in2;
  end;

begin
  ButtonClicked(Sender);
  if integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]) = 999 then
    raise Exception.create('You may not remove the "All times" time period!');
  tsidx := integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]);
  with CommonSecurity[tsidx] do
  begin
    if commonSercurityID = -1 then
      modified := false
    else
      modified := true;
    deleted := true;
  end;
  i := cbTimePeriods.itemindex;
  cbTimePeriods.Items.Delete(cbTimePeriods.ItemIndex);
  cbTimePeriods.itemindex := imin(pred(cbTimePeriods.items.count), i);
  SaveSecurityChanges;

  UpdateSecuritySettingsFromCommonSecurity;
end;

procedure TEditTimedJobSecurity.cbTimePeriodsChange(Sender: TObject);
var
  i: integer;
begin
  try
    SaveSecurityChanges;
  except
    // undo the combo change!
    cbTimePeriods.OnChange := nil;
    for i := 0 to Pred(cbTimePeriods.Items.Count) do
    begin
      if integer(cbTimePeriods.Items.Objects[i]) = CurrentPeriod then
      begin
        cbTimePeriods.ItemIndex := i;
        break;
      end;
    end;
    cbTimePeriods.OnChange := cbTimePeriodsChange;
    raise;
  end;
end;

procedure TEditTimedJobSecurity.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TEditTimedJobSecurity.cbTimePeriodsCloseUp(Sender: TObject);
begin
  Log(cbTimePeriods.Text + ' Selected from Time Period Drop Down list');
end;

//------------------------------------------------------------------------------
procedure TEditTimedJobSecurity.SetIsStaticPanel(IsStaticPanel: Boolean);
begin
  FisStaticPanel := IsStaticPanel;
  if IsStaticPanel then
  begin
    FTimedSecurityTable := 'ThemeDialogTimedSecurity';
    FButtonIDField := 'SecurityID';
    FIDCategory := scThemeDialogueTimedSecurity;
  end
  else
  begin
    FTimedSecurityTable := 'ThemePanelButtonTimedSecurity';
    FButtonIDField := 'ButtonID';
    FIDCategory := scThemePanelButtonTimedSecurity;
  end;
end;

//------------------------------------------------------------------------------
procedure TEditTimedJobSecurity.FormCreate(Sender: TObject);
begin
  CreateTempTables;
  dmADO.adoqFoHRoles.Open;

  SetIsStaticPanel(False);
  CurrentPeriod := 999;
  qRun.Connection := uado.dmADO.AztecConn;

  qrun.SQL.text := 'select [rollover time] from timeout';
  qrun.open;
  rollovertime := useful.FixedStrToTime(qrun.fieldbyname('rollover time').asstring);
  qrun.close;

  FButtonList := TTillButtonList.Create;
end;

function TEditTimedJobSecurity.AddTimePeriod(
  CommonSecurityID: integer): integer;
var
  NewStartTime: integer;
  NewText: string;
  TmpList: TStrings;
  i: integer;
begin
  // Add time period to combo box using insertion sort
  // Return index of added item

  // An input of 999 causes time period "<All times>" to be added which is
  // always 1st in the sort order.
  // For real time periods an index into the TimedSecurity array is passed,
  // These are sorted on the "rollover relative" time of the start of the period
  if CommonSecurityID = 999 then
  begin
    NewText := '<All times>';
    NewStartTime := -1;
  end
  else
  begin
    NewStartTime := GetPeriodStartTime(CommonSecurity[CommonSecurityID]);
    NewText := GetPeriodDescription(CommonSecurity[CommonSecurityID]);
  end;
  Result := -1;
  TmpList := TStringList.Create;
  for i := 0 to Pred(cbTimePeriods.Items.Count) do
  begin
    if (Result = -1) and (Integer(cbTimePeriods.Items.Objects[i]) <> 999) and
      (GetPeriodStartTime(CommonSecurity[Integer(cbTimePeriods.Items.Objects[i])]) > NewStartTime) then
      Result := TmpList.AddObject(NewText, TObject(CommonSecurityID));
    TmpList.AddObject(cbTimePeriods.Items[i], cbTimePeriods.Items.Objects[i]);
  end;
  if (Result = -1) then
    Result := TmpList.AddObject(NewText, TObject(CommonSecurityID));
  cbTimePeriods.Items.Assign(TmpList);
  TmpList.Free;
end;

function TEditTimedJobSecurity.GetPeriodStartTime(Input: TCommonSecurity): integer;
var
  Day: integer;
begin
  Result := 0;
  with Input do
  begin
    for Day := 0 to 6 do
      if (ValidDays and (1 shl Day)) > 0 then
      begin
        Result := Day*1440+  DateTimeToMins(AdjustToRolloverRelative(StartTime));
        exit;
      end;
  end;
end;

function TEditTimedJobSecurity.GetPeriodDescription(
  Input: TCommonSecurity): string;
begin
  with Input do
    Result := Format('%s %s-%s', [getdays(validdays), formatdatetime('hh:mm', starttime), formatdatetime('hh:mm', endtime)]);
end;

function TEditTimedJobSecurity.AdjustToRolloverRelative(
  Input: TDateTime): TDateTime;
begin
  Result := Frac(1+Input-RolloverTime);
end;

procedure TEditTimedJobSecurity.btnSelectAllClick(Sender: TObject);
var
  i : integer;
begin
  for i:= 0 to pred(clbRoles.Items.Count) do
  begin
    clbRoles.checked[i] := True;
  end;
end;

procedure TEditTimedJobSecurity.btnDeselectAllClick(Sender: TObject);
var
  i : integer;
begin
  for i:= 0 to pred(clbRoles.Items.Count) do
  begin
    clbRoles.checked[i] := False;
  end;
end;

procedure TEditTimedJobSecurity.OnWitnessRequiredClick(Sender: TObject);
begin
  with (Sender as TCheckBox) do
  begin
    if AllowGrayed and (State in [cbChecked]) then
    begin
      AllowGrayed := False;
      State := cbUnchecked;
    end;

    FRequestWitness := uEditTimedJobSecurity.RequestWitnessStateFromCheckBoxState(chkbxWitnessRequired.State);
  end;
end;

procedure TEditTimedJobSecurity.SetCommonWitnessRequiredState;
var
  i: Integer;
  WitnessRequiredCount: Integer;
begin
  WitnessRequiredCount := 0;
  for i := 0 to Pred(FButtonList.Count) do
  begin
    if FButtonList[i].RequestWitness then
      Inc(WitnessRequiredCount);
  end;

  if WitnessRequiredCount = FButtonList.Count then
    chkbxWitnessRequired.State := cbChecked
  else if WitnessRequiredCount = 0 then
    chkbxWitnessRequired.State := cbUnchecked
  else begin
    chkbxWitnessRequired.AllowGrayed := True;
    chkbxWitnessRequired.State := cbGrayed;
  end;
  chkbxWitnessRequired.OnClick := OnWitnessRequiredClick;
  FRequestWitness := RequestWitnessStateFromCheckBoxState(chkbxWitnessRequired.State);
end;

function RequestWitnessStateFromBoolean(const Value: Boolean): TRequestWitnessState;
begin
  case Value of
    True: Result := rwsTrue;
    False: Result := rwsFalse;
    else
      REsult := rwsFalse;
  end;
end;

function BooleanFromRequestWitnessState(const Value: TRequestWitnessState; const Default: Boolean): Boolean;
begin
  case Value of
    rwsTrue: Result := True;
    rwsFalse: Result := False;
    else
      Result := Default;
  end;
end;

function RequestWitnessStateFromCheckBoxState(const Value: TCheckBoxState): TRequestWitnessState;
begin
  case Value of
    cbUnChecked: Result := rwsFalse;
    cbGrayed: Result := rwsNoAction;
    cbChecked: Result := rwsTrue;
    else
      Result := rwsFalse;
  end;
end;

function CheckBoxStateFromRequestWitnessState(const Value: TRequestWitnessState): TCheckBoxState;
begin
  case Value of
    rwsFalse: Result := cbUnchecked;
    rwsNoAction: Result := cbGrayed;
    rwsTrue: Result := cbChecked;
    else
      Result := cbUnChecked;
  end;
end;

function TEditTimedJobSecurity.allButtonsAreCorrectionMethod( buttonList : TTillButtonList) : Boolean;
var
  areAllCorrections : boolean;
  i : integer;
begin
  areAllCorrections := true;
  for i := 0 to (buttonList.Count - 1) do
  begin
    if not buttonList[i].IsCorrectionMethod then
    begin
      areAllCorrections := false;
      break;
    end;
  end;

  result := areAllCorrections;
end;

procedure TEditTimedJobSecurity.FormDestroy(Sender: TObject);
begin
  FButtonList.Free;
end;

procedure TEdittimedJobSecurity.LoadConditionalSecurityTypes;
var
  SecurityTypeID: integer;
  SecurityTypeName: string;
begin
  cmbbxConditionalSecurity.Items.Clear;
  with qRun do
  begin
    Close;
    SQL.Text := 'select Id, coalesce(Description, Value) as [DisplayText] from ButtonSecurityTypeLookup order by Id asc';
    Open;
    while not EOF do
    begin
      SecurityTypeID := FieldByName('Id').AsInteger;
      SecurityTypeName := FieldByName('DisplayText').AsString;
      cmbbxConditionalSecurity.Items.AddObject(SecurityTypeName, TObject(SecurityTypeID));
      Next;
    end;
  end;
  cmbbxConditionalSecurity.ItemIndex := 0;
end;

procedure TEditTimedJobSecurity.LoadButtonSecurity(
  ButtonSecurityId: integer);
begin
  with qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('declare @ButtonSecurityId int');
    SQL.Add('set @ButtonSecurityId = ' + IntToStr(ButtonSecurityId));
    SQL.Add('delete from #SecurityTypeRoles');
    SQL.Add('');
    SQL.Add('if @ButtonSecurityId = 0');
              //No button security set, give the default security all jobs.
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select bstl.Id, sub.RoleId');
    SQL.Add(' from ButtonSecurityTypeLookup bstl');
    SQL.Add(' cross join (select distinct Id as RoleId from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE + ') sub');
    SQL.Add(' where bstl.Id = 0;');
    SQL.Add('else');
    SQL.Add('begin');
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select bs.SecurityTypeId, RoleId');
    SQL.Add(' from ButtonSecurity bs');
    SQL.Add(' join ThemeTask tt on bs.TaskId = tt.TaskId');
    SQL.Add(' where bs.Id = @ButtonSecurityId');
    SQL.Add('');
              //Add in all the roles if the TaskID is 0 (ZERO).
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select sub2.SecurityTypeID, sub2.RoleId');
    SQL.Add(' from #SecurityTypeRoles str');
    SQL.Add(' right join (select bs.SecurityTypeId, sub.RoleId');
    SQL.Add('            from ButtonSecurity bs');
    SQL.Add('            cross join (select distinct Id as RoleId from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE + ') sub');
    SQL.Add('            where bs.TaskId = 0 and  bs.Id = @ButtonSecurityId) sub2');
    SQL.Add(' on str.SecurityTypeID = sub2.SecurityTypeId');
    SQL.Add(' where str.SecurityTypeId is null');
              //Add in a dummy record if no roles are required for a partic. security type.
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select SecurityTypeID, -1');
    SQL.Add(' from ButtonSecurity bs');
    SQL.Add(' where Id = @ButtonSecurityId and TaskId = -1');
    SQL.Add('end');
    ExecSQL;
  end;

  dmADO.adoqFoHRoles.Requery();

  //Revert to normal after a load.
  SetAllocatedJobs(bstNormal);

  SetConditionalSecurity;
end;

procedure TEditTimedJobSecurity.SetAllocatedJobs(ButtonSecurityType: TButtonSecurityType);
var
  i: Integer;
begin
  Assert(dmADO.adoqFoHRoles.Active,'adoqFoHRoles dataset not open');
  cmbbxConditionalSecurity.ItemIndex := Integer(cmbbxConditionalSecurity.items.IndexOfObject(Pointer(Ord(ButtonSecurityType))));
  for i := 0 to pred(clbRoles.Items.Count) do
  begin
    clbRoles.checked[i] := dmADO.adoqFoHRoles.Locate('SecurityTypeId;RoleId', VarArrayOf([Ord(ButtonSecurityType), cardinal(clbRoles.Items.Objects[i])]), []);
  end;
end;

procedure TEditTimedJobSecurity.CreateTempTables;
begin
  with qRun do
  begin
    Close;
    SQL.Add('if object_id(''tempdb..#SecurityTypeRoles'') is not null');
    SQL.Add(' drop table #SecurityTypeRoles');
    SQL.Add('create table #SecurityTypeRoles (');
    SQL.Add(' SecurityTypeId tinyint,');
    SQL.Add(' RoleId int)');
    ExecSQL;
  end;
end;

procedure TEditTimedJobSecurity.LoadRoles;
begin
  clbRoles.clear;

  with qRun, clbRoles do
  begin
    Close;
    SQL.Text := 'select distinct Id, Name from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE;
    Open;
    while not qRun.Eof do
    begin
      AddItem(qRun.fieldbyname('Name').asstring, TObject(qRun.fieldbyname('Id').asinteger));
      Next;
    end;
  end;
end;

procedure TEditTimedJobSecurity.cmbbxConditionalSecurityChange(
  Sender: TObject);
begin
  SetAllocatedJobs(TButtonSecurityType(Integer(cmbbxConditionalSecurity.items.objects[cmbbxConditionalSecurity.ItemIndex])));
end;
    
procedure TEditTimedJobSecurity.cmbbxConditionalSecurityDropDown(
  Sender: TObject);
begin
  SaveSecurityTypeRoles(TButtonSecurityType(cmbbxConditionalSecurity.Items.Objects[cmbbxConditionalSecurity.ItemIndex]));
end;

procedure TEditTimedJobSecurity.SaveSecurityTypeRoles(ButtonSecurityType: TButtonSecurityType);
var
  i: integer;
  UpdateQuery: string;
  UpdatQueryTemplate: String;
begin
  UpdateQuery := 'declare @temproles table (SecurityTypeId smallint, RoleId int)';
  UpdatQueryTemplate := 'insert @temproles values (%d, %d)';

  for i := 0 to clbRoles.Items.Count - 1 do
  begin
    if clbRoles.Checked[i] then
      UpdateQuery := UpdateQuery + #13#10 +
                     Format(UpdatQueryTemplate, [Ord(ButtonSecurityType), Integer(clbRoles.Items.Objects[i])]);
  end;

  UpdateQuery := UpdateQuery + #13#10 +
                 'merge #SecurityTypeRoles as target' + #13#10 +
                 'using @temproles as source' +#13#10 +
                 '  on target.SecurityTypeId = source.SecurityTypeId and target.RoleId = source.RoleID' + #13#10 +
                 'when not matched by target then' + #13#10 +
                 '  insert (SecurityTypeId, RoleId) values (source.SecurityTypeId, source.RoleId)' + #13#10 +
                 'when not matched by source and target.SecurityTypeId = ' + IntToStr(Ord(ButtonSecurityType)) + 'then' + #13#10 +
                 '  delete;' + #13#10#13#10 +
                 'insert #SecurityTypeRoles' + #13#10 +
                 'select 0, -1' + #13#10 +
                 'where not exists(select SecurityTypeId from #SecurityTypeRoles where SecurityTypeId = 0)';

  if cbxUseConditionalSecurity.Checked then
    UpdateQuery := UpdateQuery + #13#10 +
                   'insert #SecurityTypeRoles' + #13#10 +
                   'select 1, -1' + #13#10 +
                   'where not exists(select SecurityTypeId from #SecurityTypeRoles where SecurityTypeId = 1)'
  else
    UpdateQuery := UpdateQuery + #13#10 +
                   'delete #SecurityTypeRoles where SecurityTypeId >= 1';

  with qRun do
  begin
    Close;
    SQL.Text := UpdateQuery;
    ExecSQL;
  end;

  dmADO.adoqFoHRoles.Requery();
end;

function TEditTimedJobSecurity.SaveSecurity: Integer;
var
  NewSecurityId: integer;
begin
  NewSecurityId := -1;
  with dmADO.adoqSaveButtonSecurity do
  begin
    Close;
    Parameters.ParamByName('TotalRoles').value := clbRoles.Items.count;

    //dmADO.DumpTemp('#SecurityTypeRoles');
    Open;
    if not EOF then
    begin
      if not FieldByName('Output').IsNull then
      begin
        NewSecurityId := FieldByName('Output').AsInteger;
      end;
    end;
  end;
  Result := NewSecurityId;
end;

procedure TEditTimedJobSecurity.LoadTimedButtonSecurity;
var i : integer;
begin
  cbTimePeriods.clear;
  cbTimePeriods.Items.AddObject('<All times>', TObject(999));
  timedsecuritycount := 0;
  CommonSecurityCount := 0;
      with qrun.sql do
      begin
        Clear;
        Add('SELECT * FROM ' + FTimedSecurityTable);
        Add('WHERE '+ FButtonIDField + ' IN ('+ FButtonList.IDCommaText +') ');
        Add('ORDER BY TimedSecurityID ');
      end;
      qrun.open;
      while not qrun.Eof do
      begin
        with qrun, timedsecurity[timedsecuritycount] do
        begin
          buttonid := TLargeintfield(fieldbyname(FButtonIDField)).aslargeint;
          timedsecurityid := TLargeIntField(fieldbyname('timedsecurityid')).aslargeint;
          starttime := fieldbyname('StartTime').asdatetime;
          endtime := fieldbyname('EndTime').asdatetime;
          validdays := fieldbyname('DayOfWeek').asinteger;
          ButtonSecurityId := fieldbyname('ButtonSecurityID').AsInteger;
          modified := false;
          commonSercurityID := GetCommonSecurityID(TimedSecurityCount);
        end;
        inc(timedsecuritycount);
        qrun.next;
      end;
      qrun.close;

  for i := 0 to Pred(CommonSecurityCount) do
     if (CommonSecurity[i].Count = FButtonList.Count) then
        AddTimePeriod(i)
end;

procedure TEditTimedJobSecurity.SaveTimedButtonSecurity;
var
  i: integer;
begin
  UpdateSecuritySettingsFromCommonSecurity;
  with qrun.sql do
  begin
    Clear;
    Add('SELECT * FROM ' + FTimedSecurityTable);
    Add('WHERE ' + FButtonIDField + ' IN (' + FButtonList.IDCommaText + ') ');
    Add('ORDER BY TimedSecurityId');
  end;
  qrun.Open;
  for i := 0 to pred(timedsecuritycount) do
  with qrun, timedsecurity[i] do
  begin
    if modified and (timedsecurityid <> 0) then
    begin
      if not Locate('TimedSecurityID', timedsecurityid, []) then
        raise Exception.create('Error saving changes - please cancel out of timed security and try again');
      qrun.edit;
      fieldbyname('StartTime').asdatetime := starttime;
      fieldbyname('EndTime').asdatetime := endtime;
      fieldbyname('DayOfWeek').asinteger := validdays;
      fieldbyname('ButtonSecurityId').AsInteger := ButtonSecurityID;
      qrun.Post;
      modified := false;
    end;
    if (timedsecurityid <> 0) and deleted then
    begin
      if Locate('TimedSecurityID', TimedSecurityID, []) then
        delete;
    end;
    if (timedsecurityid = 0) and not deleted then
    begin
      timedsecurityid := uGenerateThemeIds.GetNewId(FIDCategory);
      if FisStaticPanel and (FButtonList[0].ButtonID = 0) then
        buttonid := AddMasterSecurityRecord;
      with qrun do
      begin
        insert;
        TLargeIntField(fieldbyname(FButtonIDField)).aslargeint := buttonid;
        TLargeIntField(fieldbyname('TimedSecurityId')).aslargeint := timedsecurityid;
        fieldbyname('ButtonSecurityId').AsInteger := ButtonSecurityID;
        fieldbyname('StartTime').asdatetime := starttime;
        fieldbyname('EndTime').asdatetime := endtime;
        fieldbyname('DayOfWeek').asinteger := validdays;
        post;
      end;
      modified := false;
    end;
  end;
  qrun.Close;
end;

function TEditTimedJobSecurity.ConditionalSecurityIsActive: Boolean;
begin
  with qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select case when max(SecurityTypeId) > 0 then 1 else 0 end as ConditionalSecurityInUse');
    SQL.Add('from #SecurityTypeRoles str');
    //SQL.Add('where str.SecurityTypeId >=0');
    Open;
    Result := 1 = FieldByName('ConditionalSecurityInUse').AsInteger;
  end;
end;

procedure TEditTimedJobSecurity.SetConditionalSecurity;
begin
  TComboBoxProtectionHack(cbxUseConditionalSecurity).ClicksDisabled := True;
  try
    cmbbxConditionalSecurity.Enabled := ConditionalSecurityIsActive;
    cbxUseConditionalSecurity.Checked := cmbbxConditionalSecurity.Enabled;
  finally
    TComboBoxProtectionHack(cbxUseConditionalSecurity).ClicksDisabled := False;
  end;
end;

procedure TEditTimedJobSecurity.cbxUseConditionalSecurityClick(
  Sender: TObject);
begin
  cmbbxConditionalSecurity.Enabled := (Sender as TCheckBox).Checked;

  if cmbbxConditionalSecurity.Enabled then
  begin
    //Carry through the default task list to the conditional security as a starter for 10
    with qRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('delete from #SecurityTypeRoles where SecurityTypeID > 0');
      SQL.Add('insert #SecurityTypeRoles');
      SQL.Add('select sub2.Id, sub2.RoleId');
      SQL.Add('from #SecurityTypeRoles str');
      SQL.Add('right join (select bstl.Id, sub.RoleId');
      SQL.Add('           from ButtonSecurityTypeLookup bstl');
      SQL.Add('           cross join (select RoleID from #SecurityTypeRoles where SecurityTypeId = 0) sub');
      SQL.Add('           where bstl.Id > 0) sub2');
      SQL.Add('on str.SecurityTypeID = sub2.Id');
      SQL.Add('where str.SecurityTypeId is null');
      ExecSQL;
    end;
  end
  else begin
    //Carry through the default task list to the conditional security as a starter for 10
    with qRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('delete from #SecurityTypeRoles where SecurityTypeID > 0');
      ExecSQL;
    end;
  end;
  SetAllocatedJobs(bstNormal);
end;

procedure TEditTimedJobSecurity.SaveSecurityChanges;
var
  tmp: integer;
begin
  SaveSecurityTypeRoles(TButtonSecurityType(cmbbxConditionalSecurity.Items.Objects[cmbbxConditionalSecurity.ItemIndex]));
  if CurrentPeriod = 999 then
    ButtonSecurityId := SaveSecurity
  else
    if (CurrentPeriod >= 0) and (CurrentPeriod < CommonSecurityCount) then
    begin
      tmp := SaveSecurity;
      if (tmp <> CommonSecurity[CurrentPeriod].ButtonSecurityID) and not CommonSecurity[CurrentPeriod].Deleted then
      begin
        CommonSecurity[CurrentPeriod].ButtonSecurityID := tmp;
        CommonSecurity[CurrentPeriod].Modified := true;
      end;
    end;

  if integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]) = 999 then
    LoadButtonSecurity(ButtonSecurityID)
  else
    LoadButtonSecurity(CommonSecurity[integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex])].ButtonSecurityID);
  CurrentPeriod := integer(cbTimePeriods.Items.Objects[cbTimePeriods.ItemIndex]);
end;

end.
