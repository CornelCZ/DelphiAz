unit uMainMenu;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, ExtCtrls, AppEvnts, math,
  ADODB, FileCtrl;


type
  Tfmainmenu = class(TForm)
    btnStockOrders: TBitBtn;
    Label1: TLabel;
    btnMisc: TBitBtn;
    btnInvoiceEntry: TBitBtn;
    btnReports: TBitBtn;
    btnConfigure: TBitBtn;
    btnExit: TBitBtn;
    CheckInactiveTimer: TTimer;
    AppEvent: TApplicationEvents;
    files1: TFileListBox;
    wwtSysVar: TADOTable;
    wwqGetRepTax: TADOQuery;
    wwTable1: TADOTable;
    wwqGeneral: TADOQuery;
    btnInternalTransferMenu: TButton;
    btnDeliveryNoteValidation: TBitBtn;
    btnViewAcceptedInvoices: TBitBtn;
    lblUseAposMessage: TLabel;
    btnEQATECExceptionTest: TButton;
    procedure btnInvoiceEntryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnConfigureClick(Sender: TObject);
    procedure btnReportsClick(Sender: TObject);
    procedure btnMiscClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckInactiveTimerTimer(Sender: TObject);
    procedure AppEventMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStockOrdersClick(Sender: TObject);
    procedure btnInternalTransferMenuClick(Sender: TObject);
    procedure btnDeliveryNoteValidationClick(Sender: TObject);
    procedure btnViewAcceptedInvoicesClick(Sender: TObject);
    procedure btnEQATECExceptionTestClick(Sender: TObject);
  private
    { Private declarations }
    {Vars for - inactivity timer}
    activityticks, lastactivityticks: cardinal;
    lastactivitytime: TDateTime;
    appclosing: boolean;
    inactivity_timeout: TDateTime;
    theform : TForm;
    procedure AppRestore(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure SetFormStartupState;
    procedure ProcessNewSites;
    procedure SetAccessVars;
    procedure SetHelpFile;
    function OutstandingDeliveryNotes : Boolean;
    procedure ShowDeliveryNoteValidationForm;
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
    thetax : real;
    thesiteno : integer;
    thesitename: string;
    rep : integer;

    ImpFlag, TestFlag, autoclose : boolean;
    runstate: twindowstate;
    function WhatSite(showAllSitesChkBx: Boolean) : boolean;
  end;

var
  fmainmenu: Tfmainmenu;
  OldWindowProc: Pointer;
  MyMsg: Integer;

implementation

uses
  uInvMenu, uConfigDlg, uPassword, uInvFrm, UReports, uMiscMenu,
  uDMWklyPrchRep, uRptMenu1, U1WklyPurch, uGlobals, uADO, uSiteChoose, uLog,
  uAztecSplash, uStockOrderMenu, useful, uInternaltransferMenu,
  uDeliveryNoteValidation, uInvoiceManager, uEQATECMonitor;

{$R *.DFM}

function NewWindowProc(WindowHandle : hWnd; TheMessage : LongInt;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = MyMsg then
  begin {Tell the application to restore, let it restore the form}
    if fmainmenu.WindowState <> wsMinimized then
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

procedure Tfmainmenu.btnInvoiceEntryClick(Sender: TObject);
begin
  log.event('Main Menu; Invoice/DeliveryNote Entry button pressed');
  if not whatSite(False) then
    exit;

  InvoiceManager := nil;
  InvoiceMenu := nil;

  try
    InvoiceManager := TInvoiceManager.Create(self);
    InvoiceMenu := Tfinvmenu.create(self);

    InvoiceMenu.ShowModal;
  finally
    InvoiceManager.Free;
    InvoiceMenu.Free;
  end;
end;

procedure Tfmainmenu.FormShow(Sender: TObject);
begin
  log.event('Main Menu; FormShow: Main Menu being displayed');
  Application.processmessages;

  btnDeliveryNoteValidation.Caption := GetLocalisedName(lsInvoice) + ' Validation';

  btnReports.Enabled := PurReps;

  try
    wwtable1.TableName := 'Purchhdr';
    wwtable1.Open;
    screen.cursor := crdefault;

    log.event('Main Menu; FormShow: Get site and version details');
    with wwqGeneral do
    begin
      close;
      sql.clear;
      sql.Add('select a."site code", a."site name" from "site" a');

      open;
      thesiteno := FieldByName('site code').asinteger;
      thesitename := FieldByName('site name').asstring;
      close;
    end;

    log.event('Main Menu; FormShow: Get sysvar information');
    wwtsysvar.open;
    autoclose := (wwtsysvar.FieldByName('autoclose').asstring = 'Y');
    thetax := wwtsysvar.FieldByName('tax').asfloat;

    //fbn Import : N-no imports; Y-normal imports; T- test mode
    if wwtsysvar.FieldByName('Import').asstring = 'Y' then
    begin
      ImpFlag := true;
      TestFlag := false;
    end
    else
    begin
      if wwtsysvar.FieldByName('Import').asstring = 'T' then
      begin
        ImpFlag := true;
        TestFlag := true;
      end
      else
      begin
        ImpFlag := false;
      end;
    end;
    wwtsysvar.close;
    wwqgetreptax.close;
    wwqgetreptax.Parameters.ParamByName('thetax').value := thetax;
    //wwqgetreptax.Prepare;
    wwqgetreptax.open;
    rep := round(wwqgetreptax.FieldByName('MaxTo').asfloat);
    wwqgetreptax.close;

    // the main menu configure serves no purpose at HO's
    // this will change when HO's can edit invoices
    btnConfigure.Enabled := IsSite;

    //326670 - Site to site internal stock transfers
    btnInternalTransferMenu.Enabled := IsSite;

    with TADOQuery.create(self) do
    try
      connection := dmADO.AztecConn;
      sql.text := 'select pconfigs."Overnite Timeout"  as timeout from pconfigs';
      open;
      inactivity_timeout := max(fieldbyname('timeout').asinteger, 3) *
        1/24/60;
      close;
    finally
      free;
    end;

    Checkinactivetimer.enabled := autoclose;

    if OutstandingDeliveryNotes then
      ShowDeliveryNoteValidationForm;

    btnDeliveryNoteValidation.Enabled := OutstandingDeliveryNotes;
  except
    on E: Exception do
    begin
      Log.Event('Main Menu; ERROR - FormShow: ' + E.Message);
      raise;
    end;
  end;
end;

procedure Tfmainmenu.btnExitClick(Sender: TObject);
var
  i : integer;
begin
  files1.Directory := ExtractFilePath(Application.ExeName);
  files1.Mask := '_qsq*.*';
  files1.Update;

  for i := 0 to pred(Files1.Items.Count) do
  begin
  try
    sysutils.DeleteFile(Files1.items[i]);
  except
  end;
  end;
  log.event('Main Menu; Main Menu closed');
  Close;
end;

procedure Tfmainmenu.btnConfigureClick(Sender: TObject);
begin
  log.event('Main Menu; Configure button pressed');
  fconfigdlg := Tfconfigdlg.create(self);
  fconfigdlg.ShowModal;
  fconfigdlg.free;
end;

procedure Tfmainmenu.btnReportsClick(Sender: TObject);
begin
  log.event('Main Menu; Reports button pressed');

  if not fMainMenu.whatSite(true) then
    exit;

  //masterver
  frmDMWklyPrchRep := TfrmDMWklyPrchRep.Create(Self);
  frmRptMenu1 := TfrmRptMenu1.Create(Self);
  with frmRptMenu1 do
  begin
    WindowState := self.WindowState;
    Top := self.Top;
    Left := self.Left;
    ShowModal;
    Application.ProcessMessages;
    Free;
  end;
  frmDMWklyPrchRep.Free;
end;

function Tfmainmenu.WhatSite(showAllSitesChkBx: boolean) : boolean;
begin
  Result := false;
  if not IsSite then
  begin
    fSiteChoose := TFSiteChoose.myCreate(self, showAllSitesChkBx);
    fSiteChoose.Caption := 'Report for One Site';
    if fSiteChoose.ShowModal = mrCancel then
    begin
      fSiteChoose.free;
      screen.cursor := crDefault;
      exit;
    end;
    fSiteChoose.free;

    log.event('Main Menu; WhatSite: Get information from Config & Site');
    try
      with wwqGeneral do
      begin
        close;
        sql.Clear;
        sql.Add('SELECT DISTINCT [Area Name] FROM Config');
        sql.Add('WHERE [Site Code] = ' + inttostr(SiteCode));
        sql.Add('AND UPPER(ISNULL(Deleted,''N'')) = ''N''');
        open;
        AreaName := FieldByName('area name').asstring;

        close;
        sql.Clear;
        sql.Add('SELECT DISTINCT [Site Manager] FROM Site');
        sql.Add('WHERE [Site Code] = ' + inttostr(SiteCode));
        sql.Add('AND UPPER(ISNULL(Deleted,''N'')) = ''N''');
        open;
        SiteManager := FieldByName('site manager').asstring;
        close;
      end;
    except
      on E: Exception do
      begin
        Log.Event('Main Menu; ERROR - WhatSite: ' + E.Message);
        raise;
      end;
    end;
  end;
  Result := True;
end; // procedure..


procedure Tfmainmenu.btnMiscClick(Sender: TObject);
begin
  log.event('Main Menu; Misc button pressed');
  fmiscmenu := tfMiscMenu.Create(self);
  with fMiscMenu do
  begin
    top := self.Top;
    Left := self.Left;
    WindowState := self.WindowState;
    { TODO -owilma -ctidy up :
    Note BitBtn3 is now called InvoiceEntryBtn
This bit of code was removed in Clearcase version 34 at the same time as
uMiscMenu version 14.  I originally removed it because in version 13 of
uMiscMenu.FormShow the BitBtn3.visible was being set based on IsSite=true
and (UKUSmode = 'US') which would have overwritten the BitBtn3.visible value set here.
ImpFlag should be moved to tfMiscMenu and its value should be checked in uMiscMenu.FormShow}
//    BitBtn3.Visible := ImpFlag and (UKUSMode = 'US');
    ShowModal;
    free;
  end;
end;

procedure Tfmainmenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log.Event('Main Menu; FormClose...');
end;

procedure Tfmainmenu.CheckInactiveTimerTimer(Sender: TObject);
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
      screen.activeform.close
    else
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
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

procedure Tfmainmenu.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

procedure Tfmainmenu.AppRestore(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_RESTORE);
  SetActiveWindow(theform.Handle);
end;

procedure Tfmainmenu.AppMinimize(Sender: TObject);
begin
  theForm := Screen.ActiveForm;
  ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure Tfmainmenu.SetFormStartupState;
const
  MAIN_MENU_NORMAL_HEIGHT = 681;
  MAIN_MENU_REDUCED_HEIGHT = 362;
  ACCEPTED_INVOICES_BUTTON_TOP = 88;
  ACCEPTED_INVOICES_BUTTON_LEFT = 11;
  EXIT_BUTTON_LEFT = 192;
  EXIT_BUTTON_TOP = 214;
  INTERNAL_TRANSFERS_BUTTON_LEFT = 355;
  INTERNAL_TRANSFERS_BUTTON_TOP = 88;

begin
  Height := MAIN_MENU_NORMAL_HEIGHT;
  btnViewAcceptedInvoices.Visible := FALSE;
  lblUseAposMessage.Visible := FALSE;

  //Restrict functionality to 'View Accepted Delivery Notes' and 'Internal Transfers' if APOS is installed.
  if  dmADO.IsAposDatabaseInstalled then
  begin
    lblUseAposMessage.Visible := TRUE;
    if IsSite then
    begin
      Height := MAIN_MENU_REDUCED_HEIGHT;

      btnViewAcceptedInvoices.Visible := TRUE;
      btnViewAcceptedInvoices.Top := ACCEPTED_INVOICES_BUTTON_TOP;
      btnViewAcceptedInvoices.Left := ACCEPTED_INVOICES_BUTTON_LEFT;
      btnInternalTransferMenu.Top := INTERNAL_TRANSFERS_BUTTON_TOP;
      btnInternalTransferMenu.Left := INTERNAL_TRANSFERS_BUTTON_LEFT;
      btnExit.Top := EXIT_BUTTON_TOP;
      btnExit.Left := EXIT_BUTTON_LEFT;

      btnInvoiceEntry.Visible := FALSE;
      btnReports.Visible := FALSE;
      btnMisc.Visible := FALSE;
      btnConfigure.Visible := FALSE;
      btnDeliveryNoteValidation.Visible := FALSE;
      btnStockOrders.Visible := FALSE;
    end
    else
    begin
      btnStockOrders.Enabled := FALSE;
    end;
  end;

  RunState := wsNormal;
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from Genervar');
      SQL.Add('where VarName = ''RunMin''');
      SQL.Add('and VarString is not NULL and VarString = ''Y''');
      Open;

      if RecordCount > 0 then
        RunState := wsMinimized;

      Close;

      SQL.Clear;
      SQL.Add('select * from Genervar');
      SQL.Add('where VarName = ''RunMax''');
      SQL.Add('and VarString is not NULL and VarString = ''Y''');
      Open;

      if RecordCount > 0 then
        RunState := wsMaximized;

      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('Main Menu ERROR - SetFormStartupState: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfmainmenu.ProcessNewSites;
var
  sitelist: Tstringlist;
  i: integer;
begin
  sitelist := TStringList.Create;
  try
    with dmADO.adoqRun do
    begin
      close;
      SQL.Clear;
      sql.Add('select [site code]');
      sql.Add('from site where ([Windows Purchasing System] = ''Y'') and (UPPER(ISNULL(deleted,''N'')) = ''N'')');
      sql.Add('and [site code] not in (select distinct sitecode from PurSysVar where ISNULL(SiteCode,'''') <> '''')');
      open;
      while not eof do
      begin
        sitelist.Add(fieldbyName('Site Code').AsVariant);
        next;
      end;
      for i := 0 to sitelist.count - 1 do
      begin
        close;
        SQL.Clear;
        sql.Add('insert into PurSysVar (Version, Tax, PromptUC, ImportDT, ImportDir, import, AutoClose, SiteCode)');
        sql.Add('Values(''5.1.1'', 0, ''Y'',NULL, ''C:\Purchase\Alliant\Inv'', ''Y'', ''N'',' + sitelist.Strings[i] +')');
        ExecSQL;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('Main Menu ERROR - ProcessNewSites: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;
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
  tokenParam : string;
begin
  tokenParam := GetTokenParam;

  btnEQATECExceptionTest.Visible := EQATECMonitor.TriggerEQATECTestException();
   
  SplashForm := TSplashForm.Create(Self);
  SplashForm.Show;

  MyMsg := RegisterWindowMessage('AZTEC_PURCHASING');
  OldWindowProc := Pointer(SetWindowLong(fmainmenu.Handle, GWL_WNDPROC, LongInt(@NewWindowProc)));

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Purchasing will now terminate');
    Log.event('Main Menu; ERROR - FormCreate: Unable to load version information.');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Purchasing will now terminate');
    Log.event('Main Menu; ERROR - FormCreate: Unable to load version information.');
    Halt;
  end;

  SetFormStartupState;
  Application.OnRestore := AppRestore;
  Application.OnMinimize := AppMinimize;
  Application.OnException := AppException;

  screen.cursor := crhourglass;
  application.processmessages;

  dmADO.cmdPrunePurchase.Execute;

  uGlobals.GetGlobalData(dmADO.AztecConn);

  ProcessNewSites;

  screen.cursor := crDefault;

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

  if TfrmPassword.UserHasPermission('AZTEC PURCHASING') then
    SetAccessVars
  else
  begin
    ShowMessage('User ' + CurrentUser.UserName + ' does not have sufficient permissions to run Aztec Purchasing');
    Halt;
  end;

  Log.Event('Login; User ' + CurrentUser.UserName + ' has logged in.');

  setHelpFile;

  // create autoclose field in pursysvar if not there already....
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from PurSysVar');
    log.event('ffirstdlg; FormCreate: adoqRun opened: ' + dmADO.adoqRun.SQL.Text);
    open;

    autoclose := (FieldByName('autoclose').asstring = 'Y');

    close;
  end;

  label1.Caption := Application.Title;
  btnInvoiceEntry.Caption := GetLocalisedName(lsInvoice) + ' &Entry';
  btnViewAcceptedInvoices.Caption := 'View &Accepted ' + GetLocalisedName(lsInvoice) + 's';
  if purchHelpExists then
    setHelpContextID(self, HLP_MAIN_MENU);
   if EQATECMonitor.IsEQATECEnabled then
   begin
      EQATECMonitor.SetupMonitor(Application.Title);
      EQATECMonitor.TrackFeatureStart(Application.Title);
   end;
   
end;

procedure Tfmainmenu.AppException(Sender: TObject; E: Exception);
begin
   EQATECMonitor.EQATECAppException(Application.Title, E);
   Application.ShowException(E);
end;

procedure Tfmainmenu.FormDestroy(Sender: TObject);
begin
  SetWindowLong(fmainmenu.Handle, GWL_WNDPROC, LongInt(OldWindowProc));
end;

//------------------------------------------------------------------------------
procedure Tfmainmenu.btnStockOrdersClick(Sender: TObject);
var
  Dlg : TfrmStockOrderMenu;
begin
  Dlg := nil;
  try
    Dlg := TfrmStockOrderMenu.Create(self);
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure Tfmainmenu.SetAccessVars;
var
  i: integer;
  S, LocalName: string;
  AccessRights, RequiredRights: TStringList;
begin
  Log.Event('ffirstdlg; Setting Access Variables');

  // Set variables in the system to determine access once in the system
  if CurrentUser.IsZonalUser then
  begin
    PurEdit := True;
    PurAdd := True;
    PurAudit := True;
    PurViewAccepted := True;
    PurViewCurrent := True;
    PurReps := True;
  end
  else
  begin
    RequiredRights := TStringList.Create;

    try
      RequiredRights.Add('AZTEC PURCHASE ADD DELIVERY NOTE');
      RequiredRights.Add('AZTEC PURCHASE EDIT DELIVERY NOTE');
      RequiredRights.Add('AZTEC PURCHASE AUDIT DELIVERY NOTE');
      RequiredRights.Add('AZTEC PURCHASE REPORTS');
      RequiredRights.Add('AZTEC PURCHASE VIEW CURRENT');
      RequiredRights.Add('AZTEC PURCHASE VIEW ACCEPTED');

      AccessRights := TfrmPassword.GetAccessNodeLevels(RequiredRights);
    finally
      RequiredRights.Free;
    end;

    PurAdd := AccessRights.Find('AZTEC PURCHASE ADD DELIVERY NOTE', i);
    PurEdit := AccessRights.Find('AZTEC PURCHASE EDIT DELIVERY NOTE', i);
    PurAudit := AccessRights.Find('AZTEC PURCHASE AUDIT DELIVERY NOTE', i);
    PurReps := AccessRights.Find('AZTEC PURCHASE REPORTS', i);
    PurViewCurrent := AccessRights.Find('AZTEC PURCHASE VIEW CURRENT', i);
    PurViewAccepted := AccessRights.Find('AZTEC PURCHASE VIEW ACCEPTED', i);
  end;

  LocalName := GetLocalisedName(lsInvoice);

  s := 'Access Rights Granted: ';
  if PurEdit then
    s := s + 'Edit '+ LocalName + ', ';
  if PurAdd then
    s := s + 'Add ' + LocalName + ', ';
  if PurAudit then
    s := s + 'Audit ' + LocalName + ', ';
  if PurReps then
    s := s + LocalName + ' Reports, ';
  if PurViewCurrent then
    s := s + 'View Current ' + LocalName + ', ';
  if PurViewAccepted then
    s := s + 'View Accepted ' + LocalName + ', ';

  Log.Event(s);
end;

procedure Tfmainmenu.SetHelpFile;
var
  hlpFileDir, appHlpFile: String;
begin
  log.event('ffirstdlg; setHelpFile: assigning Purchase help file');
  hlpFileDir := EnsureTrailingSlash(getHelpFileDir);

  if UKUSmode = 'UK' then
  begin
    if IsSite then
    begin
      if IsMaster then
        appHlpFile := PURCH_HELP_FILE_UKSITEMASTER
      else
        appHlpFile := PURCH_HELP_FILE_UKSITE;
    end
    else
      appHlpFile := PURCH_HELP_FILE_UKHO;
  end
  else
  begin
    if IsSite then
    begin
      if IsMaster then
        appHlpFile := PURCH_HELP_FILE_USSITEMASTER
      else
        appHlpFile := PURCH_HELP_FILE_USSITE;
    end
    else
      appHlpFile := PURCH_HELP_FILE_USHO;
  end;

  AssignHelpFile(appHlpFile);

  if purchHelpExists then
    log.event('ffirstdlg; setHelpFile: Purchase help file assigned: '+hlpFileDir + appHlpFile)
  else
    MessageDlg('Could not locate help file: ' + hlpFileDir + appHlpFile +#13+
      'Help will not be available during this session.', mtInformation, [mbOK],0);
end;

procedure Tfmainmenu.btnInternalTransferMenuClick(Sender: TObject);
begin
  log.Event('MainMenu; **** START: Internal Transfer ****');
  frmInternalTransferMenu := TfrmInternalTransferMenu.Create(self);
  frmInternalTransferMenu.ShowModal;
  FreeAndNil(frmInternalTransferMenu);
  log.Event('MainMenu; **** END: Internal Transfer ****');
end;

procedure Tfmainmenu.btnDeliveryNoteValidationClick(Sender: TObject);
begin
  ShowDeliveryNoteValidationForm;
  btnDeliveryNoteValidation.Enabled := OutstandingDeliveryNotes;
end;

function Tfmainmenu.OutstandingDeliveryNotes: Boolean;
var
  hasRecords : Boolean;
begin

  with dmAdo.adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT COUNT(*) AS SQLCOUNT FROM dbo.[HandHeldDeliveryFailureHeader]' );
    Sql.Add('WHERE [Deleted] = 0');
    open;
    hasRecords := FieldByName('SQLCOUNT').AsInteger > 0;
  end;
  Result := hasRecords;

end;

procedure Tfmainmenu.ShowDeliveryNoteValidationForm;
begin
  Application.CreateForm(TfrmDeliveryNoteValidation, frmDeliveryNoteValidation);
  frmDeliveryNoteValidation.ShowModal;
  self.Refresh;
  self.Repaint;
  frmDeliveryNoteValidation.Free;
end;

procedure Tfmainmenu.btnViewAcceptedInvoicesClick(Sender: TObject);
begin
  log.event('Tfmainmenu; View Accepted Invoices button pressed');

  if not whatSite(False) then
    exit;

  InvoiceManager := TInvoiceManager.Create(self);
  try
    InvoiceManager.OpenInvoice(TASK_VIEW_ACC, Self);
  finally
    InvoiceManager.Free;
  end;
end;

procedure Tfmainmenu.btnEQATECExceptionTestClick(Sender: TObject);
begin
   raise Exception.Create('Test exception in '+Application.Title);
end;

end.
