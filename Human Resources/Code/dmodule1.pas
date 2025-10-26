unit dmodule1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Wwtable, Wwquery, Wwdatsrc, ADODB, Variants, ppComm,
  ppRelatv, ppProd, ppClass, ppReport;

const
  NULL_JOB_CODE: integer = -22222;

type
  TShiftPayTypes = (sptClocked=0, sptScheduled=1);

  TPayTypes = (ptHourlyRates=1, ptDailySalary=2, ptWeeklyApportioned=3, ptWeeklyNonApportioned=4, ptMonthlySalary=5,
               pt4WeekWeeklySalary=6, ptHeadOffice=7);
  TPayTypeSet = set of TPayTypes;

  TdMod1 = class(TDataModule)
    wwsGenerVar: TwwDataSource;
    wwtSysVar: TADOTable;
    SchdlTable: TADOTable;
    wwtGenerVar: TADOTable;
    wwtMasterVar: TADOTable;
    wwtSiteVar: TADOTable;
    wwtPrizmSite: TADOTable;
    adoqRun: TADOQuery;
    adoqRun2: TADOQuery;
    adotRun: TADOTable;
    wwqROAtt: TADOQuery;
    dsROAtt: TwwDataSource;
    wwtAttCd: TADOTable;
    dsAtt: TwwDataSource;
    ADOtWageCostUplift: TADOTable;
    dsWageCostUplift: TwwDataSource;
    adoqGetAllJobs: TADOQuery;
    adoqGetAllEmployeesAndJobs: TADOQuery;
    wwtac_User: TADOTable;
    wwtac_Role: TADOTable;
    qSiteStartOfWeek: TADOQuery;
    procedure EmployeeJobsBeforePost(DataSet: TDataSet);
    procedure SchdlTableBeforePost(DataSet: TDataSet);
    procedure SchdlTableUpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure SchdlTableNewRecord(DataSet: TDataSet);
    function TimeToDecimalTime(TimeValue: TDateTime): Real;
    procedure wwtSysVarAfterOpen(DataSet: TDataSet);
    procedure wwtSiteVarAfterOpen(DataSet: TDataSet);
    procedure wwtMasterVarAfterOpen(DataSet: TDataSet);
    procedure wwtGenerVarBeforePost(DataSet: TDataSet);
    procedure wwtMasterVarBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure wwtAttCdBeforePost(DataSet: TDataSet);
    procedure wwtAttCdBeforeEdit(DataSet: TDataSet);
  private
    function GetWagePercentUplift: real;
    function stringToTime(s: string): TDateTime;
  public
    theSEC: real;
    oldattdisp : string;
    procedure LogEventInDatabase(Event : String; int : integer; float : double; text : String);

    procedure dopaper(var rep:TppReport;country:string);
    property WagePercentUplift: real read GetWagePercentUplift;

    { Employee pay type related routines }
    function SiteSalariedPayType(const PayTypeID : integer) : boolean;
    function PayTypeSetToStr(const PayTypes : TPayTypeSet) : string;
    procedure PostCurrentRecord(DataSet: TDataSet);

    procedure CreateScheduleTempTables;
    procedure DeleteScheduleTempTables;
    function GetSiteStartOfWeek(SiteID : Integer) : Integer;
    function TimeToMins(Value: TDateTime):integer;
    function GetDateTimeOfLatestProcessedAuditTrail: TDatetime;
    procedure DimReport(AUserName, APassword, AModuleName, AComponentName: string; AStartDate, AEndDate: TDateTime);
  end;

var
  dMod1: TdMod1;

implementation

uses ubasefrm, uempmnu, uGlobals, ulog, uADO, uSetupRBuilderPreview, Math, uPassToken, uReporting;

{$R *.DFM}

procedure Tdmod1.PostCurrentRecord(DataSet: TDataSet);
begin
  if DataSet.State in [dsEdit, dsInsert] then DataSet.Post;
end;

function Tdmod1.TimeToDecimalTime(TimeValue: TDateTime) : Real;
var
  Hours, Minutes, Seconds, MilliSeconds : Word;
  DecimalHours, DecimalMinutes, DecimalSeconds, DecimalMilliSeconds : Real;
Const
  MINUTE_SECONDS    = 60;
  HOUR_SECONDS      = 3600;
  HOUR_MILLISECONDS = 3600000;
begin
  DecodeTime(TimeValue, Hours, Minutes, Seconds, MilliSeconds);
  DecimalHours        := Hours;
  DecimalMinutes      := Minutes / MINUTE_SECONDS;
  DecimalSeconds      := Seconds / HOUR_SECONDS;
  DecimalMilliSeconds := MilliSeconds / HOUR_MILLISECONDS;

  Result := DecimalHours + DecimalMinutes + DecimalSeconds + DecimalMilliSeconds;
end;

procedure TdMod1.SchdlTableBeforePost(DataSet: TDataSet);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdMod1.SchdlTableUpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdMod1.SchdlTableNewRecord(DataSet: TDataSet);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdMod1.wwtSysVarAfterOpen(DataSet: TDataSet);
begin
  with DataSet do
  begin
    uglobals.PayMode := fieldbyname('PayMode').asstring;
    uglobals.WarControl := fieldbyname('WarControl').asstring;
    uglobals.AttControl := fieldbyname('AttControl').asstring;
    uglobals.UDFControl := fieldbyname('UDFControl').asstring;
    uglobals.TermControl := fieldbyname('TermControl').asstring;
    uglobals.JobControl := fieldbyname('JobControl').asstring;
    wwtSiteVar.active := true;
    // make sure master variables have been read first
    wwtMasterVar.active := true;
    if isMaster and isSite then
      uGlobals.jobControl := 'S'; // for site master treat as site with job control = S
  end;


  Assert((uGlobals.PayMode = 'F') or (uGlobals.PayMode = 'S'),
         'Error, invalid SysVar.PayMode setting of ' + uGlobals.PayMode + '. Valid values are F and S');
end;

procedure TdMod1.wwtSiteVarAfterOpen(DataSet: TDataSet);
var
  tmpdatetime: TDateTime;
begin
  with Dataset do
  begin
    if not(locate('SiteCode', uGlobals.SiteCode, [])) then
    begin
      insert;
      fieldbyname('SiteCode').asinteger := uGlobals.SiteCode;
      {calculate exact start of current week}
      tmpdatetime := (date -
        {dayofweek, sunday=1}
        dayofweek(date-1) +
        {stweekm monday=1}
        GetSiteStartOfWeek(uGlobals.SiteCode)) + uGlobals.rollovertime;
      fieldbyname('LastTxDate').asdatetime := tmpdatetime;
      fieldbyname('LastTxTime').asstring := formatdatetime('hh:mm',tmpdatetime);
      fieldbyname('NewLADT').asdatetime := tmpdatetime;
      fieldbyname('LastAdtDate').asdatetime := tmpdatetime;
      fieldbyname('LastAdtTime').asstring := formatdatetime('hh:mm',tmpdatetime);
      fieldbyname('LastAccTxDate').asdatetime := tmpdatetime;
      fieldbyname('LastAccTxTime').asstring := formatdatetime('hh:mm',tmpdatetime);
      post;
    end;
  end;
end;

procedure TdMod1.wwtMasterVarAfterOpen(DataSet: TDataSet);
begin
  Assert(DataSet.RecordCount=1,
         'Error: MasterVar table should have 1 record but has ' + IntToStr(DataSet.RecordCount) + ' records.');

  with DataSet do
  begin
    uGlobals.tipsrep := fieldbyname('tipsrep').asinteger;
    uGlobals.EIN := fieldbyname('EIN').asstring;
  end;
end;

procedure TdMod1.wwtGenerVarBeforePost(DataSet: TDataSet);
begin
  wwtGenerVar.FieldByName('LMDT').asDateTime := now;
end;

procedure TdMod1.EmployeeJobsBeforePost(DataSet: TDataSet);
begin
  Dataset.FieldByName('LMDT').asDateTime := now;
  Dataset.FieldByName('ModBy').asString := CurrentUser.UserName;
end;

procedure TdMod1.wwtMasterVarBeforePost(DataSet: TDataSet);
begin
  with DataSet do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdMod1.DataModuleCreate(Sender: TObject);
begin
  wwtSysVar.open;                                    // cc 15701
end;

procedure TdMod1.LogEventInDatabase(event : String; int : integer; float : double; text : String);
begin
  with adoqRun do
  begin
    close;
    sql.clear;
    sql.Add('INSERT INTO Log (dt, action, [by], int1, float1, text120)');
    sql.Add('  VALUES (GetDate(),' +
                       QuotedStr(event) + ',' +
                       QuotedStr(CurrentUser.UserName) + ',' +
                       IntToStr(int) + ',' +
                       FloatToStr(float) + ',' +
                       QuotedSTr(text) + ')'
                       );
    ExecSql;
  end;
end;


procedure TdMod1.dopaper(var rep:TppReport;country:string);
var
  papNames : TStringList;
  s1, s2 : string;
  i : integer;
begin
  SetupRBuilderPreview(rep);
  papNames := TStringList.Create;

  papNames.Text := rep.PrinterSetup.PaperNames.Text;
  if uppercase(country)='UK' then
    s2:='A4'
  else
    s2:='Letter';

  for i := 0 to (papnames.Count - 1) do
  begin
    s1 := papnames[i];

    if pos(uppercase(s2), uppercase(s1)) > 0 then
    begin
      s2 := s1;
      break;
    end;

  end; // for..

  rep.PrinterSetup.PaperName := s2;
  papNames.Free;
end;

function TdMod1.GetWagePercentUplift: real;
begin
  with adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select [Wage Cost Uplift Factor] from PConfigs');
    Open;

    if FieldByName('Wage Cost Uplift Factor').IsNull then
      Result := 0
    else
      Result := FieldByName('Wage Cost Uplift Factor').AsFloat;

    Close;
  end;
end;

function TdMod1.SiteSalariedPayType(const PayTypeID : integer) : boolean;
begin
  Result := (PayTypeID <> Ord(ptHourlyRates)) and
            (PayTypeID <> Ord(ptHeadOffice));
end;

function TdMod1.PayTypeSetToStr(const PayTypes : TPayTypeSet) : string;
begin
  Result := '';
  if ptHourlyRates          in PayTypes then Result := Result + IntToStr(Ord(ptHourlyRates)) + ',';
  if ptDailySalary          in PayTypes then Result := Result + IntToStr(Ord(ptDailySalary)) + ',';
  if ptWeeklyApportioned    in PayTypes then Result := Result + IntToStr(Ord(ptWeeklyApportioned)) + ',';
  if ptWeeklyNonApportioned in PayTypes then Result := Result + IntToStr(Ord(ptWeeklyNonApportioned)) + ',';
  if ptMonthlySalary        in PayTypes then Result := Result + IntToStr(Ord(ptMonthlySalary)) + ',';
  if pt4WeekWeeklySalary    in PayTypes then Result := Result + IntToStr(Ord(pt4WeekWeeklySalary)) + ',';
  if ptHeadOffice           in PayTypes then Result := Result + IntToStr(Ord(ptHeadOffice)) + ',';

  Delete(Result, Length(Result), 1);  { Remove the superfluous ',' from the end }
end;

procedure TdMod1.wwtAttCdBeforePost(DataSet: TDataSet);
begin
  if wwtAttCd.State = dsEdit then
    begin
    with dmod1.adoqRun do
    begin
      // check unique display...
      close;
      sql.Clear;
      sql.Add('select a."attcode", a."default" from attcodes a');
      sql.Add('where upper(a."display") = ' +
        QuotedStr(uppercase(wwtAttCd.FieldByName('display').asstring)));
      sql.Add('and a."attcode" <> ' +
        QuotedStr(wwtAttCd.FieldByName('attcode').asstring));
      open;

      if recordcount > 0 then
    begin
        if FieldByName('default').asstring = 'Y' then
    begin
          showmessage('The Display String "' + wwtAttCd.FieldByName('display').asstring +
            '" is already present (default code "' + FieldByName('attcode').asstring +
            '"). Please type in another Display String (case insensitive).');
    end
    else
    begin
          showmessage('The Display String "' + wwtAttCd.FieldByName('display').asstring +
            '" is already present (code "' + FieldByName('attcode').asstring +
            '"). Please type in another Display String (case insensitive).');
    end;

        wwtAttCd.FieldByName('display').asstring := oldAttDisp;
    end;

      close;
      end;
    end;

end;

procedure TdMod1.wwtAttCdBeforeEdit(DataSet: TDataSet);
begin
  oldattdisp := wwtAttCd.FieldByName('display').asstring;
end;                                                    

procedure TdMod1.CreateScheduleTempTables;
begin
  dmADO.adocRun.CommandText :=
    'CREATE TABLE #tmpschdl (' +
    '[UserId] [bigint] NOT NULL ,' +
    '[Shift] [smallint] NOT NULL DEFAULT 1,' +
    '[RoleId] [int] NOT NULL ,' +
    '[Monin] [varchar] (5) collate database_default NULL ,' +
    '[Monout] [varchar] (5) collate database_default NULL ,' +
    '[F1] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Tuein] [varchar] (5) collate database_default NULL ,' +
    '[Tueout] [varchar] (5) collate database_default NULL ,' +
    '[F2] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Wedin] [varchar] (5) collate database_default NULL ,' +
    '[Wedout] [varchar] (5) collate database_default NULL ,' +
    '[F3] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Thuin] [varchar] (5) collate database_default NULL ,' +
    '[Thuout] [varchar] (5) collate database_default NULL ,' +
    '[F4] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Friin] [varchar] (5) collate database_default NULL ,' +
    '[Friout] [varchar] (5) collate database_default NULL ,' +
    '[F5] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Satin] [varchar] (5) collate database_default NULL ,' +
    '[Satout] [varchar] (5) collate database_default NULL ,' +
    '[F6] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[Sunin] [varchar] (5) collate database_default NULL ,' +
    '[Sunout] [varchar] (5) collate database_default NULL ,' +
    '[F7] [varchar] (1) collate database_default NULL DEFAULT (''1''),' +
    '[monoc] [varchar] (2) collate database_default NULL ,' +
    '[tueoc] [varchar] (2) collate database_default NULL ,' +
    '[wedoc] [varchar] (2) collate database_default NULL ,' +
    '[thuoc] [varchar] (2) collate database_default NULL ,' +
    '[frioc] [varchar] (2) collate database_default NULL ,' +
    '[satoc] [varchar] (2) collate database_default NULL ,' +
    '[sunoc] [varchar] (2) collate database_default NULL ,' +
    '[Old1] [datetime] NULL ,' +
    '[Old2] [datetime] NULL ,' +
    '[Old3] [datetime] NULL ,' +
    '[Old4] [datetime] NULL ,' +
    '[Old5] [datetime] NULL ,' +
    '[Old6] [datetime] NULL ,' +
    '[Old7] [datetime] NULL ,' +
    '[Deleted] [varchar] (1) collate database_default NULL ,' +
    '[LeftJob] [bit] NULL) ' +

    'CREATE UNIQUE CLUSTERED INDEX [PK_TMPSCHDL] ON #tmpschdl (UserId, Shift, RoleId) ' +

    'CREATE TABLE #WeekShifts (UserId bigint, RoleId int, InTime datetime, OutTime datetime, PaySchemeVersionId int, UserPayRateOverrideVersionID int, InScheduleTable bit NOT NULL DEFAULT(0)) ' +
    'CREATE TABLE #DailyWageCosts(UserId bigint, RoleId int, BusinessDate datetime, PaySchemeBandType int, WageCost money, WorkedTimeMins int)';

  dmADO.adocRun.Execute;
end;

procedure TdMod1.DeleteScheduleTempTables;
begin
  dmADO.adocRun.CommandText :=
    'DROP TABLE #tmpschdl ' +
    'DROP TABLE #WeekShifts ' +
    'DROP TABLE #DailyWageCosts ';

  dmADO.adocRun.Execute;

end;

{*
Note for future development:
The MOD result below has been added to ensure the correct day is used throughout
the system.  To ensure date consistancy, please refer to the grid below.

             Delphi        HR Module        C#
Sunday         1               6            0
Monday         2               0            1
Tuesday        3               1            2
Wednesday      4               2            3
Thursday       5               3            4
Friday         6               4            5
Saturday       7               5            6

to make HR DoW into Delphi DoW: DDoW = ((HRDoW + 1) mod 7) + 1

*}
function TdMod1.GetSiteStartOfWeek(SiteID : Integer) : Integer;
begin
  with qSiteStartOfWeek do
    begin
      Close;
      Parameters[0].Value := SiteID;
      Open;
      First;
      Result := (FieldByName('StartOfWeek').AsInteger + 6) mod 7;
    end;
end;


function TdMod1.TimeToMins(Value: TDateTime):integer;
var
  Hours, Minutes, Seconds, Milliseconds: word;
begin
  DecodeTime(Value, Hours, Minutes, Seconds, Milliseconds);
  Result := Hours * 60 + Minutes;
end;

function TdMod1.GetDateTimeOfLatestProcessedAuditTrail: TDatetime;
var datasetActive: boolean;
begin
  datasetActive := wwtSiteVar.Active;

  if not(datasetActive) then
    wwtSiteVar.Open;

  Result := wwtsitevar.fieldbyname('LastAdtDate').asdatetime + stringToTime(wwtsitevar.fieldbyname('LastAdtTime').asstring);

  if not(datasetActive) then
    wwtSiteVar.Close;
end;

function TdMod1.stringToTime(s: string): TDateTime;
begin
  if s = '' then
    Result := 0
  else
    Result := strtotime(s);
end;

procedure TdMod1.DimReport(AUserName, APassword, AModuleName,
  AComponentName: string; AStartDate, AEndDate: TDateTime);
var
  token : string;
begin
  token := 'token=' + Obfuscate(AUserName, APassword);
  CreateReport(token, AModuleName, AComponentName, AStartDate, AEndDate);
end;

end.


