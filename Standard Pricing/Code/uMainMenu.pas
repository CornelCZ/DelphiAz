unit uMainMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, Wwquery, Wwtable, ExtCtrls, Mask,
  AppEvnts, Math, ADODB, Variants, uPriceMatrix;

type
  Tfmainmenu = class(TForm)
    Label1: TLabel;
    btnExit: TBitBtn;
    CheckInactiveTimer: TTimer;
    AppEvent: TApplicationEvents;
    wwqGeneral: TADOQuery;
    btnPriceMatrix: TButton;
    btnSABands: TButton;
    spSetFutureToCurrent: TADOStoredProc;
    btnSupplementBands: TBitBtn;
    btnSiteMatrix: TBitBtn;
    spSetFutureToCurrentMatrix: TADOStoredProc;
    btnOffBandPricing: TButton;
    btnEQATECExceptionTest: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure CheckInactiveTimerTimer(Sender: TObject);
    procedure AppEventMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPriceMatrixClick(Sender: TObject);
    procedure btnSABandsClick(Sender: TObject);
    procedure btnSupplementBandsClick(Sender: TObject);
    procedure btnSiteMatrixClick(Sender: TObject);
    procedure btnOffBandPricingClick(Sender: TObject);
    procedure btnEQATECExceptionTestClick(Sender: TObject);
  private
    { Private declarations }
    activityticks, lastactivityticks: cardinal;
    lastactivitytime: TDateTime;
    appclosing: boolean;
    inactivity_timeout: TDateTime;
    theForm : TForm;
    fPriceMatrix: TfPriceMatrix;
    procedure AppRestore(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure UpdateSABands;
    procedure UpdateSiteMatrix;
    procedure SetUpHelp;
    function GetIsTerminatingFromInactivity: boolean;
    procedure GetBookingsOnlySalesAreas;
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
    property IsTerminatingFromInactivity : boolean read GetIsTerminatingFromInactivity;
  end;

var
  fmainmenu: Tfmainmenu;
  OldWindowProc : Pointer; {Variable for the old windows proc}
  MyMsg : Integer; {custom systemwide message}

implementation

uses uPassword, uADO, uGlobals, uPricinglog, uAztecSplash, uSABands, uSiteMatrix, uOffBandPricesForm,
  uEQATECMonitor;

{$R *.DFM}
{$R Version.RES}

function NewWindowProc(WindowHandle : hWnd; TheMessage : LongInt;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = MyMsg then
  begin {Tell the application to restore, let it restore the form}
    if fMainMenu.WindowState <> wsMinimized then
    begin  // do this to bring app to the top instead of just flashing on tool bar
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end
    else
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);

    SetForegroundWindow(Application.Handle);
    {We handled the message - we are done}
    Result := 0;
    exit;
  end;
  {Call the original winproc}
  Result := CallWindowProc(OldWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
end;

procedure Tfmainmenu.FormShow(Sender: TObject);
begin
  Log.Event('Main Menu', 'Form Show');

  with TADOQuery.Create(self) do
  try
    Connection := dmADO.AztecConn;
    SQL.Text := 'select [Overnite Timeout] from PConfigs';
    Open;
    inactivity_timeout := max(fieldbyname('Overnite Timeout').AsInteger, 3) *
      1/24/60;
    Close;
  finally
    free;
  end;
  Checkinactivetimer.enabled := true;

  if UKUSMode = 'UK' then
    btnSABands.Caption := 'Sales Area &Bandings'
  else
    btnSABands.Caption := 'Profit Center &Bandings';
end;

procedure Tfmainmenu.btnExitClick(Sender: TObject);
begin
  Log.Event('Main Menu', 'Exit Button');
  Close;
end;

procedure Tfmainmenu.FormClose(Sender: TObject; var Action: TCloseAction);
var
  theDate: TDateTime;
begin
  if Time <= RolloverTime then
    theDate := Date - 1
  else
    theDate := Date;

  spSetFutureToCurrent.Parameters.ParamByName('CurrDate').Value := formatDateTime('yyyymmdd', theDate);
  spSetFutureToCurrent.Parameters.ParamByName('TableName').Value := 'SABands';
  spSetFutureToCurrent.ExecProc;

  spSetFutureToCurrent.Parameters.ParamByName('CurrDate').Value := formatDateTime('yyyymmdd', theDate);
  spSetFutureToCurrent.Parameters.ParamByName('TableName').Value := 'SupplementBands';
  spSetFutureToCurrent.ExecProc;
end;

procedure Tfmainmenu.WMSysCommand(var Msg: TWMSysCommand);
begin
 {Used to minimise the whole app if the current form is minimised}
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

procedure Tfmainmenu.CheckInactiveTimerTimer(Sender: TObject);
begin
  TTimer(Sender).interval := 1000;
  if lastactivitytime = 0 then
    lastactivitytime := now;
  if (lastactivityticks <> activityticks) or ((fPriceMatrix<>nil) and fPriceMatrix.UnsavedChangesExist) then
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
    begin
      screen.activeform.close;
    end
    else application.terminate;
  end;

end;

procedure Tfmainmenu.AppEventMessage(var Msg: tagMSG;
  var Handled: Boolean);
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

procedure Tfmainmenu.AppRestore(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_RESTORE);
  SetActiveWindow(theForm.Handle);
end;

procedure Tfmainmenu.AppMinimize(Sender: TObject);
begin
  theForm := Screen.ActiveForm;
  ShowWindow(Application.Handle, SW_MINIMIZE);
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

procedure Tfmainmenu.FormCreate(Sender: TObject);
var
  ModuleVersion, MinDBVersion: array[0..25] of char;
  theDate: TDateTime;
  tokenParam : string;
begin
  tokenParam := GetTokenParam;

  btnEQATECExceptionTest.Visible := EQATECMonitor.TriggerEQATECTestException();

  SplashForm := TSplashForm.Create(Self);
  SplashForm.Show;

  MyMsg := RegisterWindowMessage('Aztec_Pricing');
  OldWindowProc := Pointer(SetWindowLong(fMainMenu.Handle, GWL_WNDPROC, LongInt(@NewWindowProc)));

  Application.OnRestore := AppRestore;
  Application.OnMinimize := AppMinimize;
  Application.OnException := AppException;

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Pricing will now terminate');
    Log.Event('Main Menu', 'Unable to load version information.');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Pricing will now terminate');
    Log.Event('Main Menu', 'Unable to load version information.');
    Halt;
  end;
  
  if EQATECMonitor.IsEQATECEnabled then
  begin
   EQATECMonitor.SetupMonitor(Application.Title);
   EQATECMonitor.TrackFeatureStart(Application.Title);
  end;
    
  uGlobals.GetGlobalData(dmADO.AztecConn);

  // Load help file.
  SetUpHelp;


  if TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('Logon', 'WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('Logon', 'WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon', 'Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    if not TfrmPassword.UserHasPermission('action://StandardPricing/ModuleAccess') then
     begin
      MessageDlg('User has insufficent privileges to run Aztec Standard Pricing' + #10 + #13 +
        #10 + #13 + 'The application will now terminate', mtInformation, [mbOK], 0);

      Application.Terminate;
      Exit;
     end;
  end
  else
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('Logon', 'WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('Logon', 'WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon', 'Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    Halt;
  end;

  SplashForm.Dismiss;

  if Time <= RolloverTime then
    theDate := Date - 1
  else
    theDate := Date;

  spSetFutureToCurrent.Parameters.ParamByName('CurrDate').Value := formatDateTime('yyyymmdd', theDate);
  spSetFutureToCurrent.Parameters.ParamByName('TableName').Value := 'SABands';
  spSetFutureToCurrent.ExecProc;

  spSetFutureToCurrent.Parameters.ParamByName('CurrDate').Value := formatDateTime('yyyymmdd', theDate);
  spSetFutureToCurrent.Parameters.ParamByName('TableName').Value := 'SupplementBands';
  spSetFutureToCurrent.ExecProc;

  spSetFutureToCurrentMatrix.Parameters.ParamByName('CurrDate').Value := formatDateTime('yyyymmdd', theDate);
  spSetFutureToCurrentMatrix.ExecProc;

  GetBookingsOnlySalesAreas;

  // Remove any deleted or add any new sales areas and Sub-Categories
  UpdateSABands;

  // Remove any deleted or add any new sites
  UpdateSiteMatrix;

  if HelpExists then
    setHelpContextID(self, PRC_MAIN_MENU);

  Assert(StandardPortionTypeExists(dmADO.AztecConn), 'Data corruption - Standard portion not found in PortionType table');
end;

procedure Tfmainmenu.AppException(Sender: TObject; E: Exception);
begin
   EQATECMonitor.EQATECAppException(Application.Title, E);
   Application.ShowException(E);
end;

procedure Tfmainmenu.GetBookingsOnlySalesAreas;
begin
  // save all sales areas that only have BookingsAPI terminals to temporary table
  with dmADO.adoqRun do
  try
    Close;
    SQL.Text :=
      'if OBJECT_ID(''tempdb..#BookingsOnlySalesAreas'') is not null drop table #BookingsOnlySalesAreas ' +
      ' ' +
      'declare @BookingsTills table (SalesAreaID int, PosID int) ' +
      'declare @NonBookingsTills table (SalesAreaID int, PosID int) ' +
      'declare @BookingsHardwareType int ' +
      'set @BookingsHardwareType = 11 ' +
      ' ' +
      'insert @BookingsTills ' +
      'select distinct SalesAreaID, ID from ac_pos ' +
      'where ID in (select PosCode from ThemeEposDevice where HardwareType = @BookingsHardwareType) ' +
      ' ' +
      'insert @NonBookingsTills ' +
      'select distinct SalesAreaID, ID from ac_Pos ' +
      'where ID in (select PosCode from ThemeEposDevice where HardwareType <> @BookingsHardwareType) ' +
      'and Deleted = 0 ' +
      ' ' +
      'insert @NonBookingsTills ' +
      'select distinct SalesAreaID, ID from ac_Pos ' +
      'where ID not in (select POSCode from ThemeEposDevice where POSCode is not null) ' +
      'and Deleted = 0 ' +
      ' ' +
      'select distinct Id ' +
      'into #BookingsOnlySalesAreas ' +
      'from ac_SalesArea ' +
      'where ID in (select SalesAreaId from @BookingsTills) ' +
      'and ID not in (select SalesAreaId from @NonBookingsTills)';
    ExecSQL;
  finally
    SQL.Clear;
  end;
end;

procedure Tfmainmenu.FormDestroy(Sender: TObject);
begin
  SetWindowLong(fMainMenu.Handle, GWL_WNDPROC, LongInt(OldWindowProc));
end;

procedure Tfmainmenu.btnPriceMatrixClick(Sender: TObject);
begin
  fPriceMatrix := TfPriceMatrix.Create(Self);

  try
    fPriceMatrix.ShowModal;
  finally
    FreeAndNil(fPriceMatrix);
  end;
end;

procedure Tfmainmenu.btnSABandsClick(Sender: TObject);
begin
  DisplaySalesAreaBandings;
end;

procedure Tfmainmenu.UpdateSABands;
begin
  with dmADO.adoqRun do
  try
    // Add new Sales Areas and Sub Categories
    Close;
    SQL.Text :=
      'insert SABands(SalesAreaCode, SubCategoryCode, CurrentBand, LMDT, ModifiedBy) ' +
      'select sa.Id, sc.Id, NULL, getDate(), ''StartUp'' ' +
      'from ac_SalesArea sa cross join ac_ProductSubCategory sc ' +
      '  left outer join SABands sb on sb.SubCategoryCode = sc.Id and sb.SalesAreaCode = sa.Id ' +
      'where sa.Deleted = 0 ' +
      'and sc.Deleted = 0 ' +
      'and sa.Id not in (select Id from #BookingsOnlySalesAreas) ' +
      'and sb.SalesAreaCode is null ';
    ExecSQL;

    // Remove old Sales Areas and Sub Categories
    SQL.Text :=
      'Delete from SABands ' +
      'from SABands ' +
      '  left outer join ' +
      '    (select sa.Id as SalesAreaID, sc.Id as SubcatID ' +
      '     from ac_SalesArea sa cross join ac_ProductSubCategory sc ' +
      '     left outer join #BookingsOnlySalesAreas b ' +
      '       on b.Id = sa.Id ' +
      '     where sa.Deleted = 0 and sc.Deleted = 0 ' +
      '     and b.Id is null) s ' +
      '  on SABands.SalesAreaCode = s.SalesAreaID ' +
      '     and SABands.SubCategoryCode = s.SubcatID ' +
      'where s.SalesAreaID is NULL ';
    ExecSQL;

    // Repeat for Supplement prices.
    SQL.Text :=
      'insert SupplementBands(SalesAreaCode, SubCategoryCode, CurrentBand, LMDT, ModifiedBy) ' +
      'select sa.Id, sc.Id, NULL, getDate(), ''StartUp'' ' +
      'from ac_SalesArea sa cross join ac_ProductSubCategory sc ' +
      '  left outer join SupplementBands sb ' +
      '    on sb.SalesAreaCode = sa.Id and sb.SubCategoryCode = sc.Id ' +
      'where sa.Deleted = 0 ' +
      'and sc.Deleted = 0 ' +
      'and sa.Id not in (select Id from #BookingsOnlySalesAreas) ' +
      'and sb.SalesAreaCode is null';
    ExecSQL;

    // Remove old Sales Areas and Sub Categories
    SQL.Text :=
      'delete from SupplementBands ' +
      'from SupplementBands ' +
      '  left outer join ' +
      '    (select sa.Id as SalesAreaID, sc.Id as SubcatID ' +
      '     from ac_SalesArea sa cross join ac_ProductSubCategory sc ' +
      '     left outer join #BookingsOnlySalesAreas b on b.Id = sa.Id ' +
      '     where sa.Deleted = 0 and sc.Deleted = 0 ' +
      '     and b.id is null) s ' +
      '  on SupplementBands.SalesAreaCode = s.SalesAreaID ' +
      '     and SupplementBands.SubCategoryCode = s.SubcatID ' +
      'where s.SalesAreaID is null';
    ExecSQL;
  finally
    SQL.Clear;
  end;
end;

procedure Tfmainmenu.btnSupplementBandsClick(Sender: TObject);
begin
  DisplaySupplementBandings;
end;

procedure Tfmainmenu.btnSiteMatrixClick(Sender: TObject);
var
 fSiteMatrix: TfSiteMatrix;
begin
  fSiteMatrix := TfSiteMatrix.Create(nil);

  try
    fSiteMatrix.ShowModal;
  finally
    fSiteMatrix.Free;
  end;
end;

procedure Tfmainmenu.btnOffBandPricingClick(Sender: TObject);
begin
  EditOffBandPrices;
end;

procedure Tfmainmenu.UpdateSiteMatrix;
begin
  with dmADO.adoqRun do
  begin
    // Add new Sites
    Close;
    SQL.Clear;
    SQL.Add('insert SiteMatrix(SiteCode, CurrentMatrix, LMDT, LMBy)');
    SQL.Add('select [Site Code], 1, getDate(), ''StartUp''');
    SQL.Add('from SiteAztec');
    SQL.Add('where Deleted is NULL and [Aztec Pricing] is not NULL and [Aztec Pricing] = ''Y''');
    SQL.Add('and not exists (select * from SiteMatrix where SiteCode = SiteAztec.[Site Code])');
    ExecSQL;
    Close;

    // Reinstate previously deleted sites.
    SQL.Clear;
    SQL.Add('update SiteMatrix');
    SQL.Add('set Deleted = 0, LMDT = getDate(), LMBy = ''StartUp''');
    SQL.Add('where Deleted = 1');
    SQL.Add('and SiteCode in (');
    SQL.Add('    select [Site Code]');
    SQL.Add('    from SiteAztec');
    SQL.Add('    where Deleted is NULL and [Aztec Pricing] is not NULL and [Aztec Pricing] = ''Y'')');
    ExecSQL;
    Close;

    // Remove old Sites
    SQL.Clear;
    SQL.Clear;
    SQL.Add('update SiteMatrix');
    SQL.Add('set Deleted = 1, LMDT = getDate(), LMBy = ''StartUp''');
    SQL.Add('where SiteCode not in (');
    SQL.Add('    select [Site Code]');
    SQL.Add('    from SiteAztec');
    SQL.Add('    where Deleted is NULL and [Aztec Pricing] is not NULL and [Aztec Pricing] = ''Y'')');
    ExecSQL;
    Close;
  end;
end;

procedure Tfmainmenu.SetUpHelp;
var
  HelpFileName: string;
begin
  if UKUSMode = 'UK' then
    HelpFileName := PRICING_HO_UK_HELP_FILE
  else
    HelpFileName := PRICING_HO_US_HELP_FILE;

  AssignHelpFile(HelpFileName);

  if HelpExists then
    Log.Event('Login Dialog', 'Pricing help file assigned: ' + Application.HelpFile)
  else
  begin
    MessageDlg('Could not locate help file: ' + HelpFileName + '.' + #13 +
      'Help will not be available during this session.', mtInformation, [mbOK], 0);
    Log.Event('Login Dialog', 'Could not locate help file: ' + HelpFileName);
  end;
end;

function Tfmainmenu.GetIsTerminatingFromInactivity: boolean;
begin
  Result := appclosing;
end;

procedure Tfmainmenu.btnEQATECExceptionTestClick(Sender: TObject);
begin
   raise Exception.Create(Application.Title+' exception test.');
end;

end.
