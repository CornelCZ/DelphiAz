unit uempmnu;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, dialogs, Wwdbigrd, Wwdbgrid, AppEvnts, math,
  ADODB, DB, DBTables, Variants, Animate;

type
  TfEmpMnu = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    AppEvent: TApplicationEvents;
    CheckInactiveTimer: TTimer;
    adoqRun: TADOQuery;
    wwtRun: TADOTable;
    Editbbtn: TBitBtn;
    loglist: TListBox;
    Schwarnbbtn: TBitBtn;
    BitBtn1: TBitBtn;
    btnAztecReports: TBitBtn;
    Doschdbbtn: TBitBtn;
    Vrfybbtn: TBitBtn;
    MatchPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Animation: TAnimatedImage;
    btnEQATECExceptionTest: TButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DoschdbbtnClick(Sender: TObject);
    procedure SchwarnbbtnClick(Sender: TObject);
    procedure VrfybbtnClick(Sender: TObject);
    procedure EditbbtnClick(Sender: TObject);
    procedure LogInfo;
    procedure FormActivate(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure BitBtn1Click(Sender: TObject);
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckInactiveTimerTimer(Sender: TObject);
    procedure AppEventMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnAztecReportsClick(Sender: TObject);
    procedure btnEQATECExceptionTestClick(Sender: TObject);

  private
    matchflag, quitMatch, JumpToSignOff: boolean;
    {Vars for job 14409 - inactivity timer}
    activityticks, lastactivityticks: cardinal;
    lastactivitytime: TDateTime;
    appclosing: boolean;
    inactivity_timeout: TDateTime;
    ThisModuleVersion: String;

    procedure Solve24hrs;
    procedure AppRestore(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    function DispWarnings: boolean;

    procedure SetAccessVars;
    procedure SetUpHelp;
    function EnsureFirstWeekToSignOffSelected: boolean;
  public
    leevar, gracetm, leeway1, leeway2, grace, roll: string;
    dtgrace, dtroll: tdatetime;
    pctype : Integer;
    siteno: Integer;
    dispsite: Integer;
    paidflag, fillsch, fillschALL, ratechg, forceWeekSignOff, allowShiftDeletion: boolean;
    empLADT, pzLAudFst, pzLAudLst, pzLAudDate: tdatetime;
    pzLAudTmLst: string;
    payDSign, SOweek: tdatetime;
    procedure LogException(Sender: TObject; E: Exception);
    procedure ESDatabaseStartup;
    function GetIsTerminatingFromInactivity: Boolean;
  end;

const
  theWeek: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
    'Saturday', 'Sunday');

var
  fEmpMnu: TfEmpMnu;
  MyMsg : DWord;
  OldWindowProc : Pointer;

implementation

uses dmodule1, ubasefrm, uAztecSplash, UWarn, UVerify, uwait, uPickWeek,
  uSchedule, uOver24, uAttend, uGlobals, dShiftMatch, uSiteChoose, uAboutForm,
  ulog, useful, uADO, uPassword, uPickSignoffDate, uUser,
  uEQATECMonitor;

{$R *.DFM}
{$R Version.RES}

procedure TfEmpMnu.FormShow(Sender: TObject);
var
  oldSoW, newSoW: smallint;
begin
  log.setmodule('Main Menu');
  log.event('Main Menu shown');

  dmod1.wwtSysVar.open;
  dispsite := 1;

  with dmod1.adoqRun do
  begin // get the SignOffWeek....
    close;
    sql.Clear;
    sql.Add('select max(a."perend") as thedate from paysign a');
    open;
    SOWeek := FieldByName('thedate').asdatetime + 1;

    // if the day of week changed since last SignOff then we need a new SignOff Date and thus
    // a new Start Of Week (SOweek). This should be such that no days are left un-signed off,
    // i.e. he new week should include days already signed off rather than have days that have
    // not been signed off but do not fall in the new week either.

    if (((uGlobals.stweek + 1) mod 7) + 1) <> (dayofweek(SOweek)) then
    begin
      // set the SOweek BACK with the required no. of days so its DayOfWeek now
      // corresponds to the current Start of week's DayOfWeek
      oldSoW := (dayofweek(SOweek));
      newSoW := (((uGlobals.stweek + 1) mod 7) + 1);

      SOweek := SOweek - ((7 - (newSoW - oldSoW)) mod 7);
    end;

    bitbtn1.Hint := 'Sign Off Payroll from ' +
      formatDateTime('ddd ddddd', SOweek) + ' to ' +
      formatDateTime('ddd ddddd', SOweek + 6);

    //if the sign off week is still in progress disable the button....
    if ((SOweek + 6) >= Date) or ((SOweek + 6 + dtroll) >= empLADT) then
    begin
      bitbtn1.Enabled := false;
    end
    else
    begin
      bitbtn1.Enabled := true;
    end;

    close;
    sql.text := 'select "Overnite Timeout"  as timeout from pconfigs';
    open;
    inactivity_timeout := max(fieldbyname('timeout').asinteger, 3) *
      1/24/60;
    close;
  end;

  dmod1.wwtSiteVar.Open;
  if dmod1.wwtSiteVar.FieldByName('autoclose').asstring = 'Y' then
  begin
    Checkinactivetimer.enabled := true;
  end;
end;

procedure Tfempmnu.WMSysCommand;
{Used to minimise the whole app if the current form is minimised}
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfEmpMnu.SpeedButton2Click(Sender: TObject);
begin
  // remove QSQ files
  try
    useful.deletefiles(ExtractFilePath(Application.ExeName)+'_qsq*');;
  finally
    Close;
  end;
end;

procedure TfEmpMnu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dMod1.LogEventInDatabase('Close', 0, 0, '');
  ModalResult := mrOK;
  log.event('Main Menu closed');
end;

procedure TfEmpMnu.LogException(Sender: TObject; E: Exception);
begin
  Log.Event('** ERROR: ' + E.Message);
  EQATECMonitor.EQATECAppException(Application.Title, E);
  Application.ShowException(E);
end;

function NewWindowProc(WindowHandle : hWnd; TheMessage : LongWord;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = MyMsg then
  begin {Tell the application to restore, let it restore the form}
    if fEmpMnu.WindowState <> wsMinimized then
    begin  // do this to bring app to the top instead of just flashing on tool bar
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end
    else
    begin
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end;
    SetForegroundWindow(Application.Handle);
    {We handled the message - we are done}
    Result := 0;
    exit;
  end;
  {Call the original winproc}
  Result := CallWindowProc(OldWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
end;

procedure TfEmpMnu.AppRestore(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_RESTORE);
end;

procedure TfEmpMnu.AppMinimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TfEmpMnu.ESDatabaseStartup;
var
  ConfigurationDataMissing: boolean;

const
  DEFAULT_TIPS_GATHERING_TIME_WINDOW = '3'; {Days}

  procedure ProcessNewESSites;
  var
    i : integer;
    DefPayMode, DefControls: string;
  begin
    with adoqRun do
    begin
      Close;
      SQL.Text := 'update Sysvar set LMDT = getdate() where LMDT is NULL';
      ExecSQL;

      // Check for Master record.
      Close;
      SQL.Text := 'Select * from SysVar where SiteCode = ' + inttostr(SiteCode);
      Open;

      if RecordCount = 0 then
      begin
        if UKUSMode = 'US' then
        begin
          DefPayMode := 'F';
          DefControls := 'M';
        end
        else
        begin
          DefPayMode := 'S';
          DefControls := 'M';
        end;

        // Override control location for Site Master.
        if IsSite then
          DefControls := 'S';

        Close;
        SQL.Clear;
        SQL.Add('insert SysVar(SiteCode, Grace, Leeway1, Leeway2, Totals, PayMode,' +
          'Schedule, JobControl, WarControl, AttControl, UDFControl, TermControl, LMDT)');
        SQL.Add('values(' + inttostr(SiteCode) + ',''00:00'', ''00:15'', ''00:15'',' +
          '''1111111111'', ' + QuotedStr(DefPayMode) + ', ''Y'', ' + QuotedStr(DefControls) + ', ' +
          QuotedStr(DefControls) + ', ' + QuotedStr(DefControls) + ', ' + QuotedStr(DefControls) + ', ' +
          QuotedStr(DefControls) + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', Now) + ''')');
        ExecSQL;
      end;

      // Create site records.
      Close;
      SQL.Clear;
      sql.Add('insert SysVar');
      sql.Add('select a.[Site Code], b.Grace, b.Leeway1, b.Leeway2, b.Schedule, b.PaidBreak,' +
        '  b.Totals, b.FillSch, b.JPayChg, b.RateChg, b.PayMode, b.JobControl, b.WarControl,' +
        '  b.AttControl, b.UDFControl, b.TermControl, b.AutoPrintPayReport, b.PayReportDecimalHours, getDate()');
      sql.Add('from SiteAztec a, (Select * from SysVar where SiteCode = 0) b');
      sql.Add('where a.[Site Code] not in (select SiteCode from SysVar)');
      sql.Add('and a.[Aztec Human Resources] = ''Y''');
      sql.Add('and a.[Aztec Human Resources] is not NULL');
      sql.Add('and a.[Deleted] is NULL');
      i := ExecSQL;

      log.event(inttostr(i) +  ' new Sites were detected and added to SysVar.');
    end;
  end;

begin
  if uGlobals.IsSite then
  begin
    if uGlobals.IsMaster then
      self.Caption := 'Time & Attendance - - Single Site Master'
    else
      self.Caption := 'Time & Attendance - - Site: ' + uGlobals.SiteName;
  end
  else
    self.Caption := 'Time & Attendance - - Head Office';

  if uGlobals.IsMaster then
  begin
    { Initialise configuration information if necessary }
    with dmADO.adoqRun do
    try
      SQL.Text :=
        'IF NOT EXISTS(SELECT * FROM MasterVar) ' +
        '  INSERT INTO MasterVar (TipsRep, LMDT) ' +
        '  VALUES (' +  DEFAULT_TIPS_GATHERING_TIME_WINDOW + ', GetDate())';
      ExecSQL;
    finally
      Close;
    end;

    ProcessNewESSites;
  end
  else
  begin
    with dmADO.adoqRun do
    try
      { Check the site has recieved its configuration information from Head Office. If not abort.}
      Close;
      SQL.Text := 'select * from SysVar where [SiteCode] = ' + inttostr(uGlobals.SiteCode);
      Open;
      ConfigurationDataMissing := (RecordCount = 0);

      Close;
      SQL.Text := 'select * from MasterVar';
      Open;
      ConfigurationDataMissing := ConfigurationDataMissing or (RecordCount = 0);

      if ConfigurationDataMissing then
      begin
        Showmessage('Aztec Time & Attendance has not yet received initial configurations from Head Office.' +
          #13 + ' Please perform a PC link operation from Head Office to rectify.');
        Application.Terminate;
      end;
    finally
      Close;
    end;
  end;
end;

{ Ensure the first week to be signed off has been selected. Should only happen on first run
  of application on site. }
function TfEmpMnu.EnsureFirstWeekToSignOffSelected: boolean;
var
  FirstWeekToSignOff : TDate;
begin
  Result := TRUE;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Text := 'SELECT * FROM PaySign';
    Open;
    if RecordCount = 0 then
    begin
      if GetFirstWeekToSignOff(FirstWeekToSignOff, uGlobals.stWeek) then
      begin
        Close;
        SQL.Text :=
          'INSERT PaySign(SiteCode, PerSt, PerEnd, SignDT, SignBy, LMDT) ' +
          'VALUES(' + inttostr(uGlobals.SiteCode) + ', ' +
                  dmADO.FormatDateForSQL(FirstWeekToSignOff - 1) + ',' +
                  dmADO.FormatDateForSQL(FirstWeekToSignOff - 1) + ',' +
                  dmADO.FormatDateForSQL(FirstWeekToSignOff - 1) + ', ''1stINSTALL'',  GetDate())';
        ExecSQL;
      end
      else
        Result := FALSE;
    end;
  finally
    Close;
  end;
end;

function TfEmpMnu.DispWarnings: boolean;
var
  remstring: string;
begin
  // 14885 begs CC - 9/8/01 master cannot change till nos or empjob so it should'n bother...
  if isSite then
  begin
    // warn about shift errors
    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select a."errcode", count(a."schin") as countschin from schedule a');
      sql.Add('where a."errcode" > 0');
      sql.Add('group by a."errcode"');
      open;
      remstring := '';
      if FieldByName('errcode').asstring <> '' then
      begin
        if locate('errcode', 1, []) then
        begin
          remstring := remstring + #13 + ' - There are ' + FieldByName('countschin').asstring +
            ' shifts where the worked job ID (from the register) does not appear in the Employee database! (code 0)';
        end;

        if locate('errcode', 4, []) then
        begin
          remstring := remstring + #13 + ' - There are ' + FieldByName('countschin').asstring +
            ' shifts where the employee ID (from the register) does not appear in the Employee database! (code 4)';
        end;

        if locate('errcode', 3, []) then
        begin
          remstring := remstring + #13 + ' - There are ' + FieldByName('countschin').asstring +
            ' shifts where the Employee working the shift is not assigned any job! (code 3)';
        end;
        if remstring <> '' then
        begin
          showmessage('WARNING: There are errors in the worked shifts information:' +
            #13 + remstring + #13 + #13 + 'This should be rectified as soon as possible!' +
            ' (Call ZONAL if you do not know how to rectify this.)');
           log.event('Shift information errors :'+remstring);
        end;
      end;
      close;
    end;
  end; // if isSite  // 14885 ends CC

  Result := true;
end;

function GetTokenParam: string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to ParamCount do
  begin
    if Copy(LowerCase(ParamStr(i)),1,6) = 'token=' then
      Result := Copy( ParamStr(i), 7, Length(ParamStr(i)) );
  end;
end;

procedure TfEmpMnu.FormCreate(Sender: TObject);
var
  i: integer;
  ModuleVersion, MinDBVersion: array[0..25] of char;
  tokenParam : string;
begin
  log.event('Main Menu created');
  tokenParam := GetTokenParam;
  JumpToSignOff := False;

  btnEQATECExceptionTest.Visible := EQATECMonitor.TriggerEQATECTestException();
  
  forceWeekSignOff := FALSE;
  allowShiftDeletion := FALSE;

  SplashForm := TSplashForm.Create(Self);
  SplashForm.Show;

  Application.OnException := LogException;
  // run app once code
  {Register a custom windows message}
  MyMsg := RegisterWindowMessage('AZTEC_HUMAN_RESOURCE');
  {Set form's windows proc to ours and remember the old window proc}
  OldWindowProc := Pointer(SetWindowLong(fEmpMnu.Handle, GWL_WNDPROC, LongInt(@NewWindowProc)));

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Time & Attendance will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;

  ThisModuleVersion := ModuleVersion;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Time & Attendance will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;
  Application.OnMinimize := AppMinimize;
  Application.OnRestore := AppRestore;

  try
    Application.CreateForm(TdmADO, dmADO);
  except
    on E:exception do
    begin
      log.event('FATAL ERROR:  Cannot create dmADO!!!. Error: ' +
        E.Message);
    end;
  end;

  uGlobals.GetGlobalData(dmADO.AztecConn);

  try
    ESDatabaseStartup;
  except on E: Exception do
    begin
      showmessage('An error is preventing Aztec Time & Attendance from starting:' + #13 +
          E.message);
      log.event('Fatal error encountered :'+E.message);
      halt;
    end;
  end;

  if FindCmdLineSwitch('initialiseonly', ['\', '-'], true) then
  begin
    log.event('Command line switch "initialiseonly" found');
    Application.Terminate;
    Exit;
  end;

  if FindCmdLineSwitch('EMPJOB', ['\', '-'], true) then
  begin
    dmod1 := Tdmod1.Create(self);
    DispWarnings;
    dmod1.free;
    Application.Terminate;
    Exit;
  end;

  if FindCmdLineSwitch('autocollect', ['\', '-'], true) then
  begin
    if uGlobals.IsSite then
    begin
      dmod1 := Tdmod1.Create(self);

      with TdmShiftMatch.create(nil) do
        free;

      dmod1.free;
    end;
    Application.Terminate;
    Exit;
  end;

  // Load Help files.
  SetupHelp;

  longtimeformat := 'HH:mm:ss';
  shorttimeformat := 'HH:mm';

  {specify leading zero, 2 digit year format}
  if pos('m', lowercase(shortdateformat)) > pos('d', lowercase(shortdateformat)) then
    ShortDateFormat := 'dd/mm/yy'
  else
    ShortDateFormat := 'mm/dd/yy';

  for i := 1 to ParamCount do
    if UpperCase(ParamStr(i)) = 'SIGNOFF' then
      JumpToSignOff := True;

  SplashForm.Dismiss;

  if not TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    Halt;
  end;

  if uGlobals.LogonFailedTimes > 0 then
    Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
      copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
  if uGlobals.LogonErrorString <> '' then
    Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
  if uGlobals.LogonUserName <> ''  then
    Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

  if TfrmPassword.userHasPermission('AZTEC HUMAN RESOURCE') then
    SetAccessVars
  else
  begin
    ShowMessage('You do not have sufficient permissions to run Aztec Time & Attendance!' +
              #13 + #10 + #13 + #10 + 'The application will now terminate');
    Halt;
  end;


  if (JumpToSignOff and not EmpHrs) then
  begin
    ShowMessage('You do not have the required access to perform this task.');
    Application.Terminate;
    Exit;
  end;

  // password OK, keep going...

  // create dmod1...
  try
    dmod1 := Tdmod1.Create(fEmpMnu);
    log.event('Initializing Data Module');
  except
    on E: Exception do
    begin
      MessageDlg('An error with the following message:' + #13 + #34 +
        E.Message + #34 + #13 +
        'has occured while Initializing the Data Module.' + #13 + #13 +
        'Please Contact ZONAL to resolve this matter.',
        mtError, [mbOK], 0);
     log.event('Fatal error in data module :'+E.Message);
    end;
  end;
  if EQATECMonitor.IsEQATECEnabled then
  begin
   EQATECMonitor.SetupMonitor(Application.Title);
   EQATECMonitor.TrackFeatureStart(Application.Title);
  end;
  
  dMod1.LogEventInDatabase('Open', 0, 0, '');

  if uGlobals.IsSite then
  begin
    if not EnsureFirstWeekToSignOffSelected then
    begin
      showmessage('The first week to begin payroll signoff must be selected before Aztec Time & Attendance can be used');
      log.event('User has not selected first week to signoff. Aborting');
      Application.Terminate;
      Exit;
    end;
  end;

  DispWarnings;
  siteno := uGlobals.SiteCode;

  matchflag := true;
  pctype := 1;
  if EmpHrs then
  begin
    Vrfybbtn.Enabled := True;
    BitBtn1.Enabled := True;
  end
  else
  begin
    Vrfybbtn.Enabled := False;
    BitBtn1.Enabled := False;
  end;
  if EmpSched then
  begin
    Doschdbbtn.Enabled := True;
  end
  else
  begin
    Doschdbbtn.Enabled := False;
  end;

  btnAztecReports.Enabled := EmpReps;
  // End Job 14285

  if not isSite then
  begin
    BitBtn1.Visible := False;
  end
  else
  begin
    BitBtn1.Visible := True;
  end;

  with dmod1.adoqRun do // get rollover time
  begin
    close;
    sql.Clear;
    sql.Add('select a."rollover time" from timeout a');
    open;
    roll := FieldByName('rollover time').asstring;
    close;
  end;

  dmod1.wwtsysvar.open;
  empLADT := dMod1.GetDateTimeOfLatestProcessedAuditTrail;
  gracetm := dmod1.wwtsysvar.fieldbyname('grace').asstring;
  leeway1 := dmod1.wwtsysvar.fieldbyname('leeway1').asstring;
  leeway2 := dmod1.wwtsysvar.fieldbyname('leeway2').asstring;
  if gracetm = '' then
    gracetm := '00:00';
  if leeway1 = '' then
    leeway1 := '00:00';
  if leeway2 = '' then
    leeway2 := '00:00';
  dtroll := strtotime(roll);
  dtgrace := dtroll - strtotime(gracetm);
  grace := formatDateTime('hh:nn', dtgrace);
  if dmod1.wwtsysvar.fieldbyname('paidbreak').asstring = 'Y' then
    paidflag := true
  else
    paidflag := false;

  if dmod1.wwtsysvar.fieldbyname('fillsch').asstring = 'Y' then
  begin
    fillschALL := false;
    fillsch := true;
  end
  else
  begin
    if dmod1.wwtsysvar.fieldbyname('fillsch').asstring = 'A' then
    begin
      fillschALL := true;
      fillsch := true;
    end
    else
    begin
      fillsch := false;
      fillschALL := false;
    end;
  end;

  if dmod1.wwtsysvar.fieldbyname('ratechg').asstring = 'Y' then
    ratechg := true
  else
    ratechg := false;

  ///////////// GENERVAR configuration variables ////////////////////////

  with dmod1.adoqRun do // get the lot then use locate
  begin
    close;
    sql.Clear;
    sql.Add('select * from genervar');
    open;

    // now get your variables by name...

    close;


    if uGlobals.IsSite then
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT VerifyCurrentWeekOnly , AllowShiftDeletion FROM ac_SitePayrollSettings');
      open;

      forceWeekSignOff := FieldByName('VerifyCurrentWeekOnly').AsBoolean;
      allowShiftDeletion := FieldByName('AllowShiftDeletion').AsBoolean;

      close;
    end;
  end;

  uGlobals.stweek := dmod1.GetSiteStartOfWeek(siteno);

  loglist.items.clear;
  with loglist.items do
  begin
    clear;
    add('********************************');
    add('EMPLOYEE started at: ' + DateTimeToStr(Now) + ' by: ' +
      CurrentUser.UserName + ' ;');
    add('Global vars: roll time = ' + roll + '; grace = ' + gracetm +
      ' grace time = ' + grace +
      ' lway1 = ' + leeway1 + '; lway2 = ' + leeway2 + '; grace time as DT = ' +
      floatToStr(dtgrace) +
      ' send sch. = ' + dmod1.wwtsysvar.fieldbyname('schedule').asstring + '; SoW: ' +
      theweek[stweek + 1]);
  end;
  LogInfo;
  Application.ProcessMessages;

  if HelpExists then
    setHelpContextID(self, EMP_MAIN_MENU);
end;

procedure TfEmpMnu.DoschdbbtnClick(Sender: TObject);
var
  i: integer;
  dtFrm: string[5];
  SiteCode : integer;
  SiteName : string[20];
  ScheduleLookAheadWeeks: integer;
begin
  screen.cursor := crHourglass;

  try
    log.event('Schedule clicked');
    SiteName := '';
    SiteCode := 0;

    if isSite then
    begin
      SiteCode := uGlobals.SiteCode;
      SiteName := uGlobals.siteName;
    end
    else
    begin
      fSiteChoose := TFSiteChoose.Create(self);
      fSiteChoose.Caption := 'Review Site Schedule';
      if fSiteChoose.ShowModal = mrCancel then
      begin
        fSiteChoose.free;
        screen.cursor := crDefault;
        exit;
      end;
      SiteCode := fSiteChoose.theSite;
      SiteName := fSiteChoose.sitename;
      fSiteChoose.free;
    end;

    with dmod1.adoqGetAllJobs do
    begin
      Close;
      Parameters.ParamByName('siteid').value := SiteCode;
      Open;

      if RecordCount = 0 then
      begin
        ShowMessage('There are no jobs assigned to any employees.  Cannot edit schedule.');
        Close;
        Exit;
      end;

      Close;
    end;

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from MasterVar');
      Open;
      ScheduleLookAheadWeeks := FieldByName('ScheduleLookAhead').AsInteger;
      Close;
    end;

    fPickWeek := TfPickWeek.Create(self);
    fPickWeek.Caption := 'Choose a week to edit schedule';
    fPickWeek.extraDays := ScheduleLookAheadWeeks * 7;
    fPickWeek.VSiteCode := SiteCode;
    fPickWeek.Mode := pwmSchedule;
    if fPickWeek.showModal = mrCancel then
    begin
      fPickWeek.free;
      exit;
    end;

    dMod1.LogEventInDatabase('Do Schedule', 0, 0, 'for week starting ' + formatDateTime('ddd mm/dd/yyyy', fPickWeek.selWeekSt));

    fSchedule := TfSchedule.create(application);
    fSchedule.monstr := fPickWeek.selWeekSt;
    with fSchedule do
    begin
      // SETS UP THE LABEL CAPTIONS ABOVE THE SCHEDULE GRID.
      // EACH DATE IS CALCULATED FROM THE DATE OF THE MONDAY IN THE SELECTED WEEK.
      // dates labels
      dtFrm := copy(ShortDateFormat, 1, 5);
      label8.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt);
      label9.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 1);
      label10.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 2);
      label11.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 3);
      label12.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 4);
      label13.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 5);
      label14.caption := formatdatetime(dtFrm, fPickWeek.selWeekSt + 6);

      // days of week labels
      for i := 0 to panel3.controlcount - 1 do
      begin
        if panel3.controls[i] is tlabel then
        begin
          if tlabel(panel3.controls[i]).tag > 0 then
            tlabel(panel3.controls[i]).caption :=
              theweek[(((tlabel(panel3.controls[i]).tag + stweek)
              - 1) mod 7) + 1];
        end;
      end;
    end;
    fPickWeek.free;
  finally
    screen.cursor := crDefault;
  end;

  fSchedule.vSiteCode := SiteCode;
  fSchedule.vSiteName := SiteName;
  fSchedule.showmodal;
  fSchedule.free;
  log.SetModule('Main Menu');
  log.event('Schedule freed');
  dMod1.LogEventInDatabase('Exit Do Schedule', 0, 0, '');
end;

procedure TfEmpMnu.SchwarnbbtnClick(Sender: TObject);
begin
  log.event('Warning Controls clicked');
  Fwarn := TFwarn.Create(fempmnu);
  Fwarn.showmodal;
  fwarn.free;
  log.setmodule('Main Menu');
  log.event('Warning Controls freed');
end;

procedure TfEmpMnu.VrfybbtnClick(Sender: TObject);
var
  i: integer;
  s1: string[6];
  vSiteCode : integer;
  vSiteName : string[20];
begin
  log.event('Verify Times clicked');
  screen.cursor := crHourglass;

  vSiteName := '';
  vSiteCode := 0;

  if not isSite then
  begin
    fSiteChoose := TFSiteChoose.Create(self);
    fSiteChoose.Caption := 'Review Site Clock Times';
    if fSiteChoose.ShowModal = mrCancel then
    begin
      fSiteChoose.free;
      screen.cursor := crDefault;
      exit;
    end;
    vSiteCode := fSiteChoose.theSite;
    vSiteName := fSiteChoose.sitename;
    fSiteChoose.free;
  end;

  fPickWeek := TfPickWeek.Create(self);
  fPickWeek.Caption := 'Choose a week to verify clock times';
  fPickWeek.mode := pwmVerifyShifts;
  { Mike Palmer (325734)
    20th September 2004}
  fpickweek.extraDays := 0;
  { End Mike Palmer }
  fPickWeek.VSiteCode := VSiteCode;
  if fPickWeek.showModal = mrCancel then
  begin
    fPickWeek.free;
    screen.cursor := crDefault;
    exit;
  end;

  VrfyDlg := TVrfyDlg.Create(self);
  VrfyDlg.selWeekSt := fpickweek.selWeekSt;


  for i := 0 to VrfyDlg.verifypc.pagecount - 1 do
  begin
    VrfyDlg.verifypc.pages[i].caption :=
      theweek[((i + stweek) mod 7) + 1] + ' ' +
      formatdatetime(copy(ShortDateFormat, 1, 5), fpickweek.selWeekSt + i);
  end;

  if (fpickweek.selWeekSt < SOweek) then
  begin
    VrfyDlg.reviewFlag := true;
    s1 := 'Review';
  end
  else
  begin
    VrfyDlg.reviewFlag := false;
    s1 := 'Verify';
  end;

  if isSite then
  begin
    VrfyDlg.vSiteCode := uGlobals.SiteCode;
    VrfyDlg.vSiteName := uGlobals.siteName;
  end
  else
  begin
    VrfyDlg.vSiteCode := vSiteCode;
    VrfyDlg.vSiteName := vSiteName;
    VrfyDlg.reviewFlag := true;
    s1 := 'Review';
  end;

  log.event(s1+' Clock Times week starting ' + formatDateTime('ddd mm/dd/yyyy', fPickWeek.selWeekSt));
  dMod1.LogEventInDatabase(s1 + ' Clock Times', 0, 0, 'for week starting ' + formatDateTime('ddd mm/dd/yyyy', fPickWeek.selWeekSt));

  vrfydlg.paytypes := TStringList.Create;
  try
    vrfydlg.paytypes.Clear;
    with dmod1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select Id, Name from ac_PayFrequency');
      open;
      while not eof do
      begin
        vrfydlg.paytypes.Append(FieldByName('Id').asstring + '=' +
          FieldByName('Name').asstring);
        next;
      end;
      close;
    end;

    VrfyDlg.ShowModal;
  finally
    vrfydlg.paytypes.Free;
  end;

  screen.cursor := crdefault;
  vrfydlg.free;

  log.setmodule('Main Menu');
  log.event(s1+ ' clock times freed');
  dMod1.LogEventInDatabase('Exit ' + s1 + ' Clk Tms', 0, 0, '');
end;

procedure TfEmpMnu.EditbbtnClick(Sender: TObject);
begin
  log.event('Edit base data clicked');
  screen.cursor := crHourglass;
  fbasefrm := Tfbasefrm.Create(fempmnu);
  log.setmodule('Base Data');
  fbasefrm.showmodal;
  fbasefrm.free;
  log.event('Edit base data exited');
  log.setmodule('Main Menu');
end;

procedure TfEmpMnu.LogInfo;
var
  i: integer;
begin
  for i := 0 to loglist.count - 1 do
  begin
    log.Event(loglist.Items[i]);
  end;
end;

procedure TfEmpMnu.FormActivate(Sender: TObject);
var
  s1 : string;
begin
  log.event('Main Menu activated');
  if not matchflag then
    exit;
  screen.cursor := crdefault;

  ///////// Call ExtMatch ///////////////////
  matchpanel.Align := alClient;
  matchPanel.Visible := true;
  Animation.Active := True;
  try
    if uGlobals.IsSite then
    begin
      s1 := 'Matching Shifts';
      label2.Caption := #$D#$A + 'Gathering && Matching Shifts...' + #$D#$A;
      Application.ProcessMessages;
      with TdmShiftMatch.create(nil) do
        free;
    end;
    log.event('Finished Matching, Sales & Tips.');
  except
    on E: exception do

    begin
        // log the action..
      fempmnu.loglist.items.clear;
      with fempmnu.loglist.items do
      begin
        add('Run Ext Progs ERROR; Error Msg: ');
        add(E.message);
      end;
      fempmnu.LogInfo;
        // end of logging..
      showmessage('There was an Error while ' + s1 + '!' +
        #13 + 'Aztec Time & Attendance may not have the latest data available.');
      log.event('Error while ' + s1 + ' ERROR: ' + E.message);
    end;

  end; // try..except

  Animation.Active := False;
  matchPanel.Visible := false;
  matchflag := false;
  matchpanel.visible := false;

  ///////// Sort out over 24 hrs shifts ////////////////

  Solve24hrs;

  //////////////////////////////////////////////////////
  screen.cursor := crdefault;
  speedbutton2.visible := true;

  empLADT := dMod1.GetDateTimeOfLatestProcessedAuditTrail;

  //if the sign off week is still in progress disable the button....
  if ((SOweek + 6) >= Date) or ((SOweek + 6 + dtroll) >= empLADT) then
  begin
    bitbtn1.Enabled := false;
  end
  else
  begin
    bitbtn1.Enabled := true;
  end;

  if JumpToSignOff then
  begin
    if BitBtn1.Enabled then
      BitBtn1Click(Self)
    else
      ShowMessage('Payroll week not yet ready to sign off');

    Application.Terminate;
    Exit;
  end;
end;

procedure TfEmpMnu.BitBtn1Click(Sender: TObject);
begin
  //SOweek := 36899;//36906;
  // check all the shifts are confirmed...
  log.event('Sign off pay roll clicked');
  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(a."UserId") as thecount');
    sql.Add('from schedule a');
    sql.Add('where a."sitecode" = ' + inttostr(siteno));
    sql.Add('and a."bsdate" >= ' + quotedstr(formatDateTime('mm/dd/yyyy', SOweek)));
    sql.Add('and a."bsdate" <= ' + quotedstr(formatDateTime('mm/dd/yyyy', SOweek + 6)));
    sql.Add('and a."visible" = ''Y'' and a."confirmed" = ''N''');
    sql.Add('and a."UserId" in');
    sql.Add('  (select distinct u.Id');
    sql.Add('   from ac_User u');
    sql.Add('     join ac_UserRoles ur on u.Id = ur.UserId');
    sql.Add('     join ac_Role r on ur.RoleId = r.Id');
    sql.Add('   where r.ShowInTimeAndAttendance = 1)');
    open;
    if FieldByName('thecount').asinteger > 0 then
    begin
      showmessage('There are ' + FieldByName('thecount').asstring +
        ' shifts unconfirmed in the week you wish to sign off!' + #13 +
        'All shifts have to be confirmed before you can proceed.');
      log.event( FieldByName('thecount').asstring+' shifts unconfirmed in the week returning to Main Menu');
      close;
      exit;
    end;

    // bypass Attendance codes if in US mode
    if uGlobals.UKUSmode = 'US' then
    begin
      // warn, ask for confirmation....
      if MessageDlg('You are about to sign off a week. If you proceed you will not be able to modify' +
        ' the week''s shift information anymore.' + #13 + #13 +
        'Click OK To Sign Off the Payroll from ' +
        formatDateTime('ddd mm/dd/yyyy', SOweek) + ' to ' +
        formatDateTime('ddd mm/dd/yyyy', SOweek + 6),
        mtConfirmation, [mbOK, mbCancel], 0) = mrOK then
      begin
        log.event('Sign off confirmed');
        // now sign-off the week...
        dmod1.adotRun.close;
        dmod1.adotRun.TableName := 'PaySign';
        dmod1.adotRun.open;
        dmod1.adotRun.insert;
        dmod1.adotRun.FieldByName('sitecode').asinteger := sitecode;
        dmod1.adotRun.FieldByName('PerSt').asdatetime := SOweek;
        dmod1.adotRun.FieldByName('PerEnd').asdatetime := SOweek + 6;
        dmod1.adotRun.FieldByName('SignDT').asdatetime := Now;
        dmod1.adotRun.FieldByName('SignBy').asstring := CurrentUser.UserName;
        dmod1.adotRun.FieldByName('LMDT').asdatetime := Now;
        dmod1.adotRun.post;
        dmod1.adotRun.close;
      end;

      // get the SignOffWeek....
      close;
      sql.Clear;
      sql.Add('select max(a."perend") as thedate from paysign a');
      open;
      SOWeek := FieldByName('thedate').asdatetime + 1;
      close;

      bitbtn1.Hint := 'Sign Off Payroll from ' +
        formatDateTime('ddd ddddd', SOweek) + ' to ' +
        formatDateTime('ddd ddddd', SOweek + 6);

      //if the sign off week is still in progress disable the button....
      if ((SOweek + 6) >= Date) or ((SOweek + 6 + dtroll) >= empLADT) then
      begin
        bitbtn1.Enabled := false;
      end
      else
      begin
        bitbtn1.Enabled := true;
      end;

      close;
      exit;
    end;


    // In prep for the next step FOR THIS WEEK...
    //   - Empty all worked days from empattcd.db
    //   - Remove any employees which had attendance data added but which are now configured to not be shown in this module.
    close;
    sql.Clear;
    sql.Add('delete from empattcd');
    sql.Add('where SiteCode = ' + inttostr(siteno));
    sql.Add('  and (AttCode = ''W''');
    sql.Add('    or SEC not in');
    sql.Add('        (select distinct u.Id');
    sql.Add('         from ac_User u');
    sql.Add('           join ac_UserRoles ur on u.Id = ur.UserId');
    sql.Add('           join ac_Role r on ur.RoleId = r.Id');
    sql.Add('         where r.ShowInTimeAndAttendance = 1))');
    sql.Add('and Date >= ''' + formatDateTime('mm/dd/yyyy', SOweek) + '''');
    sql.Add('and Date <= ''' + formatDateTime('mm/dd/yyyy', SOweek + 6) + '''');
    execSQL;

    // put WORKED attendance data in empattcd from the week's times.

    // first Append disregarding key violations

    // guard against any key violations
    close;
    sql.Clear;
    sql.Add('delete EmpAttCd');
    sql.Add('from EmpAttCd s, schedule a');
    sql.Add('where a."sitecode" = ' + inttostr(siteno));
    sql.Add('and a."bsdate" >= ''' + formatDateTime('mm/dd/yyyy', SOweek) + '''');
    sql.Add('and a."bsdate" <= ''' + formatDateTime('mm/dd/yyyy', SOweek + 6) + '''');
    sql.Add('and a."visible" = ''Y'' and a."confirmed" = ''Y''');
    sql.Add('and a."WRoleId" is not NULL and a."WRoleId" <> 0');
    sql.Add('and a."accin" is not NULL and a."accout" is not NULL');
    sql.Add('and s.sitecode = a.sitecode and s.sec = a.UserId and s.date = a.bsdate');
    execSQL;

    // now insert
    close;
    sql.Clear;
    sql.Add('insert into EmpAttCd(SiteCode, SEC, [Date], AttCode, LMDT)');
    sql.Add('select a."sitecode", a."UserId", a."bsdate", (''W'') as att,');
    sql.Add('(''' + formatDateTime('mm/dd/yyyy HH:nn:ss', Now) + ''') as lmdt from schedule a');
    sql.Add('where a."sitecode" = ' + inttostr(siteno));
    sql.Add('and a."bsdate" >= ''' + formatDateTime('mm/dd/yyyy', SOweek) + '''');
    sql.Add('and a."bsdate" <= ''' + formatDateTime('mm/dd/yyyy', SOweek + 6) + '''');
    sql.Add('and a."visible" = ''Y'' and a."confirmed" = ''Y''');
    sql.Add('and a."WroleId" is not NULL and a."WRoleId" <> 0');
    sql.Add('and a."accin" is not NULL and a."accout" is not NULL');
    sql.Add('and a."UserId" in');
    sql.Add('  (select distinct u.Id');
    sql.Add('   from ac_User u');
    sql.Add('     join ac_UserRoles ur on u.Id = ur.UserId');
    sql.Add('     join ac_Role r on ur.RoleId = r.Id');
    sql.Add('   where r.ShowInTimeAndAttendance = 1)');
    sql.Add('group by a."sitecode", a."UserId", a."bsdate"');
    execSQL;
  end;

  fAttend := TfAttend.Create(self);
  fAttend.sitecode := siteno;
  fAttend.selWeekSt := SOweek;
  log.event('FAttend created and shown');
  if fAttend.ShowModal = mrAll then // theweek was signed off
  begin

    with dmod1.adoqRun do
    begin // get the SignOffWeek....
      close;
      sql.Clear;
      sql.Add('select max(a."perend") as thedate from paysign a');
      open;
      SOWeek := FieldByName('thedate').asdatetime + 1;
      close;
    end;

    bitbtn1.Hint := 'Sign Off Payroll from ' +
      formatDateTime('ddd ddddd', SOweek) + ' to ' +
      formatDateTime('ddd ddddd', SOweek + 6);

    //if the sign off week is still in progress disable the button....
    if ((SOweek + 6) >= Date) or ((SOweek + 6 + dtroll) >= empLADT) then
    begin
      bitbtn1.Enabled := false;
    end
    else
    begin
      bitbtn1.Enabled := true;
    end;
  end;

  fAttend.free;
  log.event('fattend freed');
  log.setmodule('Main Menu');
end;



procedure TfEmpMnu.Solve24hrs;
begin
  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from eOver24h a where a."solved" = ''N''');
    open;
    if recordcount = 0 then
    begin
      close;
      exit;
    end;
  end;
  // use a dialog box...
  fOver24 := TfOver24.Create(self);
  fOver24.ShowModal;
  fOver24.free;
  dmod1.adoqRun.close;
end;

procedure TfEmpMnu.Label1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (button = mbright) and (ssalt in shift) and (ssshift in shift) then
  begin
    Application.ProcessMessages;
    quitMatch := true;
    Application.ProcessMessages;
  end;
end;

procedure TfEmpMnu.SpeedButton1Click(Sender: TObject);
begin
  with TAboutForm.create(nil) do try
    VersionText := fEmpMnu.ThisModuleVersion;
    Showmodal;
  finally
    free;
  end;
end;

procedure TfEmpMnu.CheckInactiveTimerTimer(Sender: TObject);
{Job 14409 - Inactivity timer}
begin
  TTimer(Sender).interval := 1000;
  if lastactivitytime = 0 then
    lastactivitytime := now;
  if lastactivityticks <> activityticks then
  begin
    lastactivityticks := activityticks;
    lastactivitytime := now;
  end
  else
    if now-lastactivitytime > (inactivity_timeout) then
    {after some time of no mouse movement or keyboard input, quit.}
    begin
      if appclosing = false then
      begin
        appclosing := true;
        log.event('Time out tripped, user given 10 second warning');
        // cause a one-time delay of 10 seconds for the inactivity check
        // timer.
        TTimer(sender).interval := 10000;
        if messagedlg('Inactivity Warning - This application will close itself in 10 seconds.'+#13+
          'Press NO to stop this and continue with your work.', mtWarning,
            [mbCancel, mbNo], 0) = mrNo then
        begin
          // cancel the auto close process.
          appclosing := false;
          lastactivitytime := now;
          TTimer(sender).interval := 1000;
          log.event('User canceled time out');
        end;
      end
      else
        appclosing := true;
    end;
  if appclosing then
  begin
    {kill off all the windows}
    {N.b. the use of "screen.activeform" works for "Save changes?" message
     dialog boxes too, but will nor save changes}
    if assigned(screen.activeform) then
      screen.activeform.close
    else
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);

    log.event('Applcation timed out exiting');
  end;
end;

procedure TfEmpMnu.AppEventMessage(var Msg: tagMSG;
  var Handled: Boolean);
{Job 14409 - Inactivity timer}
begin
  if (Msg.message = WM_MOUSEMOVE) or
     (Msg.message = WM_KEYDOWN) or
     (Msg.message = WM_NCMOUSEMOVE) then
  begin
    {wrap the ticks counter round so as not to cause integer overflow}
    if activityticks = $ffffffff then
      activityticks := 0
    else
      inc(activityticks);
  end;
end;

procedure TfEmpMnu.FormDestroy(Sender: TObject);
begin
  SetWindowLong(fEmpMnu.Handle, GWL_WNDPROC, LongInt(OldWindowProc));
end;

procedure TfEmpMnu.SetAccessVars;
var
  i: integer;
  S: string;
  AccessRights, RequiredRights: TStringList;
begin
  Log.Event('Setting Access levels');

  if CurrentUser.IsZonalUser then
  begin
    EmpHrs   := True;
    EmpSched := True;
    EmpReps  := True;
  end
  else
  begin
    RequiredRights := TStringList.Create;

    try
      RequiredRights.Add('AZTEC HR EMPLOYEES HOURS');
      RequiredRights.Add('AZTEC HR SCHEDULING');
      RequiredRights.Add('AZTEC HR REPORTS');

      AccessRights := TfrmPassword.GetAccessNodeLevels(RequiredRights);
    finally
      RequiredRights.Free;
    end;

    EmpHrs := AccessRights.Find('AZTEC HR EMPLOYEES HOURS', i);
    EmpSched := AccessRights.Find('AZTEC HR SCHEDULING', i);
    EmpReps := AccessRights.Find('AZTEC HR REPORTS', i);
  end;

  s := 'Access Rights Granted: ';
  if EmpHrs then
    s := s + 'Edit hours, ';
  if EmpSched then
    s := s + 'Edit schedules, ';
  if EmpReps then
    s := s + 'Reports';

  Log.Event(s);
end;

procedure TfEmpMnu.SetUpHelp;
var
  HelpFileName: string;
begin
  if UKUSMode = 'UK' then
  begin
    if IsSite then
      if IsMaster then
        HelpFileName := EMPLOYEE_SITEMASTER_UK_HELP_FILE
      else
        HelpFileName := EMPLOYEE_SITE_UK_HELP_FILE
    else
      HelpFileName := EMPLOYEE_HO_UK_HELP_FILE;
  end
  else
  begin
    if IsSite then
      if IsMaster then
        HelpFileName := EMPLOYEE_SITEMASTER_US_HELP_FILE
      else
        HelpFileName := EMPLOYEE_SITE_US_HELP_FILE
    else
      HelpFileName := EMPLOYEE_HO_US_HELP_FILE;
  end;

  AssignHelpFile(HelpFileName);

  if HelpExists then
    Log.Event('Employee help file assigned: '+Application.HelpFile)
  else
  begin
    MessageDlg('Could not locate help file: ' + HelpFileName + '.' + #13 +
      'Help will not be available during this session.', mtInformation, [mbOK], 0);
    Log.Event('Could not locate help file: ' + HelpFileName);
  end;
end;

procedure TfEmpMnu.btnAztecReportsClick(Sender: TObject);
begin
  dmod1.DimReport(CurrentUser.UserName, CurrentUser.Password, 'Time & Attendance', TBitBtn(Sender).Name, 0, 0);
end;

function TfEmpMnu.GetIsTerminatingFromInactivity: Boolean;
begin
  Result := appClosing;
end;

procedure TfEmpMnu.btnEQATECExceptionTestClick(Sender: TObject);
var
   AppTitle : string;
begin
   AppTitle := StringReplace(Application.Title, '&&', '&', [rfReplaceAll, rfIgnoreCase]);
   raise Exception.Create(AppTitle+' exception error test.');
end;

end.

