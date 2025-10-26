program ProductModelling;

(*
 * *****************
 * Product Modelling
 * *****************
 *
 * Provides a MicroSoft Windows(TM) implementation of the
 * PRIZM MASTER | EDIT-LINES module
 *
 * Run without arguments for GLOBAL line editing;
 *
 * Normal command line arguments:
 *   -site              run SITE line editing;
 *
 * Debugging command line arguments:
 *   -progress          expand progress dialogs to include
 *                      *lots* of debugging information
 *
 * Authors: Hamish Martin & Stuart Boutell, Edesix Ltd.
 *)


{$R '..\..\Common Files\Icons\ArrowGlyphs.res'}


uses
  ShareMem,
  SysUtils,
  Dialogs,
  Forms,
  Controls,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  uLineEdit in 'uLineEdit.pas' {LineEditForm},
  uSupplierFrame in 'uSupplierFrame.pas' {UnitSupplierFrame: TFrame},
  uGuiUtils in 'uGuiUtils.pas',
  uSelectSiteLevel in 'uSelectSiteLevel.pas' {SelectLevelForm},
  uDatePicker in 'uDatePicker.pas' {DatePickerForm},
  uEntityLookup in 'uEntityLookup.pas' {EntityLookupFrame: TFrame},
  uSelectEntity in 'uSelectEntity.pas' {SelectEntityForm},
  uProgress in 'uProgress.pas' {ProgressForm},
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uEntityDeleteDialog in 'uEntityDeleteDialog.pas' {EntityDeleteDialog},
  uEntityDelete in 'uEntityDelete.pas' {EntityDelete: TDataModule},
  uEntityChange in 'uEntityChange.pas' {EntityChange: TDataModule},
  Useful in '..\..\Common Files\Useful.pas',
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uDatabaseADO in 'uDatabaseADO.pas' {ProductsDB: TDataModule},
  uADO in 'uADO.pas' {dmADO: TDataModule},
  uPortionIngredients in 'uPortionIngredients.pas' {PortionIngredientsFrame: TFrame},
  uPortionIngredientDialog in 'uPortionIngredientDialog.pas' {PortionIngredientDialog},
  uMaintSubCateg in 'uMaintSubCateg.pas' {fMaintSubCateg},
  uMaintUnit in 'uMaintUnit.pas' {fMaintUnit},
  uMaintPrintStream in 'uMaintPrintStream.pas' {fMaintPrintStream: Unit1},
  uCourseAndTaxFrame in 'uCourseAndTaxFrame.pas' {TCoursesAndTaxRulesFrame: TFrame},
  uMaintCourses in 'uMaintCourses.pas' {fMaintCourses},
  uMaintPortionType in 'uMaintPortionType.pas' {fMaintPortionType},
  uMaintCategory in 'uMaintCategory.pas' {fMaintCategory},
  uMaintDivision in 'uMaintDivision.pas' {fMaintDivision},
  uSupplierInfoFrame in 'uSupplierInfoFrame.pas' {SupplierInfoFrame: TFrame},
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  uMultiPurchaseFrame in 'uMultiPurchaseFrame.pas' {TMultiPurchaseFrame: TFrame},
  uEntityFilter in 'uEntityFilter.pas' {EntityFilterForm},
  uSearchUtils in 'uSearchUtils.pas',
  MercWwControl in '..\..\Common Files\WinRunner\MercWwControl.pas',
  TestSrvr in '..\..\Common Files\WinRunner\TestSrvr.pas',
  uAztecPreparedItemFrame in 'uAztecPreparedItemFrame.pas' {AztecPreparedItemFrame: TFrame},
  MercControl in '..\..\Common Files\WinRunner\MercControl.pas',
  MercCustControl in '..\..\Common Files\WinRunner\MercCustControl.pas',
  uLocalisedText in 'uLocalisedText.pas',
  uPortionCookTimes in 'uPortionCookTimes.pas' {PortionCookTimes},
  FlexiDBGrid in '..\..\Common Files\Components\FlexiDBGrid.pas',
  uNewPortionIngredientsFrame in 'uNewPortionIngredientsFrame.pas' {NewPortionIngredientsFrame: TFrame},
  uAztecDBComboBox in 'Components\uAztecDBComboBox.pas',
  uZip32 in '..\..\Classes\Utilities\uZip32.pas',
  uAztecDatabaseUtils in '..\..\Classes\Database\uAztecDatabaseUtils.pas',
  uAztecStringUtils in '..\..\Classes\Utilities\uAztecStringUtils.pas',
  uSystemUtils in '..\..\Classes\Utilities\uSystemUtils.pas',
  uUser in '..\..\Common Files\uUser.pas',
  uXPFix in '..\..\Common Files\uXPFix.pas',
  uFutureDate in 'uFutureDate.pas',
  uBarCodeForm in 'uBarCodeForm.pas' {BarCodeForm},
  uSettingsForm in 'uSettingsForm.pas' {SettingsForm},
  uPortionScaleContainers in 'uPortionScaleContainers.pas' {PortionScaleContainers},
  uBarcodeExceptionValue in 'uBarcodeExceptionValue.pas' {BarcodeExceptionValue},
  uBarcodeRanges in 'uBarcodeRanges.pas' {frmBarcodeRanges},
  uEditBarcodeRange in 'uEditBarcodeRange.pas' {frmEditBarcodeRange},
  uADOBarcodeRanges in 'uADOBarcodeRanges.pas' {dmBarcodeRanges: TDataModule},
  uMaintSuperCategory in 'uMaintSuperCategory.pas' {fMaintSuperCategory},
  uMaintSubDivision in 'uMaintSubDivision.pas' {fMaintSubDivision},
  uEQATECMonitor in '..\..\common files\uEQATECMonitor.pas',
  uTagListFrame in '..\..\Common Files\uTagListFrame.pas' {TagListFrame: TFrame},
  uProductTagsFrame in '..\..\Common Files\uProductTagsFrame.pas' {ProductTagsFrame: TFrame},
  uSettingsFrame in 'uSettingsFrame.pas' {SettingsFrame: TFrame},
  uSettingsOverrideForm in 'uSettingsOverrideForm.pas' {SettingsOverrideForm},
  uExtendedCheckListBox in 'Components\uExtendedCheckListBox.pas',
  uPortionFilterForm in 'uPortionFilterForm.pas' {PortionFilterForm},
  midaslib,
  ulog in '..\..\Common Files\ulog.pas';

{$R *.res}

var
  tokenParam : string;

function HandleStartup: Boolean;
var
  helpFileName : string;
begin
  Result := False;

  if not dmADO.CheckAztecDatabase then
  begin
    Log.Event('Failed checking Aztec Database.');
    Exit;
  end;

  if not dmADO.CheckRequiredData then
  begin
    Log.Event('Required data is missing.');
    Exit;
  end;

  Log.event('SQL Provider: ' + dmADO.AztecConn.Provider);
  GetGlobalData( dmADO.AztecConn );
  uLocalisedText.InitialiseLocalisedText;

  // Setup help
  if UKUSMode = 'UK' then
    helpFileName := AZPM_HO_UK_HELP_FILE
  else
    helpFileName := AZPM_HO_US_HELP_FILE;

  AssignHelpFile( helpFileName );

  if HelpExists then begin
    log.Event('Help file assigned: '+helpFileName)
  end else begin
    // Disabled until a help file is available
    //MessageDlg('Could not locate help file: ' + helpFileName + '.'#13#10 +
    //  'Help will not be available during this session.', mtInformation, [mbOK], 0);
    log.Event('Could not locate help file: ' + helpFileName);
  end;

  // we are about to prompt the user; dismiss our splash screen
  SplashForm.Hide;

  if not TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    Exit;
  end;

  if uGlobals.LogonFailedTimes > 0 then
    Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
      copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
  if uGlobals.LogonErrorString <> '' then
    Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
  if uGlobals.LogonUserName <> ''  then
    Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

  SplashForm.Dismiss;


  if not (TfrmPassword.userHasPermission('AZTEC PRODUCT MODELLING') OR TfrmPassword.userHasPermission('AZTEC SITE LINES')) then
  begin
    Log.Event('User has insufficient privileges.');
    MessageDlg('User has insufficient privileges to edit products' + #10 + #13 +
    #10 + #13 + 'The application will now terminate', mtInformation, [mbOK], 0);
    Exit;
  end;

  ProductsDB.logonName := CurrentUser.UserName;
  Log.Setuser(CurrentUser.UserName);

  // test user has sufficient privilege
  if FindCmdLineSwitch('site', ['-','/'], True) then
  begin
    Log.Event('Found SITE command line switch.');
    // SITE LINES
    if TfrmPassword.userHasPermission('AZTEC SITE LINES') then
    begin
      // Site level is requested - bring up level chooser
      if SelectLevelForm.doSiteLevelSelect then
      begin
        productsDB.setSiteCode(SelectLevelForm.getSiteCode, SelectLevelForm.getSiteName);
      end
      else
      begin
        Log.Event('Failed to select site.');
        Exit;
      end;
    end
    else
    begin
      Log.Event('User has insufficient privileges.');
      // user has insufficient priv
      MessageDlg('User has insufficient privilege to edit site lines' + #10 + #13 +
        #10 + #13 + 'The application will now terminate', mtInformation, [mbOK], 0);
      Exit;
    end;
  end
  else
  begin
    // GLOBAL LINES
    if TfrmPassword.userHasPermission('AZTEC PRODUCT MODELLING') then
      productsDB.setGlobal
    else
    begin
      Log.Event('User has insufficient privileges.');
      // user has insufficient priv
      MessageDlg('User has insufficient privilege to edit global lines' + #10 + #13 +
        #10 + #13 + 'The application will now terminate', mtInformation, [mbOK], 0);
      Exit
    end;
  end;

  if not ProductsDB.RecipeModellingConnectionOK then
  begin
    Log.Event('Recipe Modelling installed but a connection could not be established.');
    MessageDlg('Unable to connect to the Recipe Modelling database.' + #13#10#13#10 +
               'The application will now terminate.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if not ProductsDB.GetPMAppLock then
  begin
    Log.Event('Unable to attain shared lock on resource AztecProductModellingAppLock.');
    MessageDlg('Recipe Modelling is importing data from or exporting data to Product Modelling.' + #13#10 +
               'Editing within Product Modelling is not possible until the import or export finishes.' + #13#10#13#10 +
               'The application will now terminate.', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
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

begin
  Application.Initialize;
  Application.Title := 'Product Modelling';

  tokenParam := GetTokenParam;

  log.setup('Log', 'PMlog', 99, 100);
  log.event('******** Product Modelling system starting ********');

  Application.CreateForm(TdmADO, dmADO);
  Application.CreateForm(TProductsDB, ProductsDB);
  Application.CreateForm(TLineEditForm, LineEditForm);
  Application.CreateForm(TSelectLevelForm, SelectLevelForm);
  Application.CreateForm(TDatePickerForm, DatePickerForm);
  Application.CreateForm(TSelectEntityForm, SelectEntityForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TEntityDeleteDialog, EntityDeleteDialog);
  Application.CreateForm(TEntityDelete, EntityDelete);
  Application.CreateForm(TEntityChange, EntityChange);
  Application.CreateForm(TPortionIngredientDialog, PortionIngredientDialog);
  Application.CreateForm(TSplashForm, SplashForm);
  Application.CreateForm(TfrmBarcodeRanges, frmBarcodeRanges);
  Application.CreateForm(TdmBarcodeRanges, dmBarcodeRanges);
  try
    // Need to set to "Product Modeling" for US which means that uGlobals.GetGlobalData
    // will be called twice.
    uGlobals.GetGlobalData(dmADO.AztecConn);
    if (UKUSmode = 'US') then
    begin
      SplashForm.ProductName.Caption := 'Product Modeling';
      Application.Title := 'Product Modeling';
    end;

    SplashForm.Show;

    // Close app if it's already running
    ensureSingleInstanceApp;

    if HandleStartup then
    begin
      // Start the main product modelling form
      productsDB.Start;
      SelectEntityForm.Initialise;
      Application.Run;
      EQATECMonitor.CloseDown(Application.Title);
      ProductsDB.ReleasePMAppLock;
    end
    else
    begin
      SplashForm.Dismiss;

      // exit without displaying main form
      Application.ShowMainForm := False;
      Application.MainForm.Visible := False;
      EQATECMonitor.CloseDown(Application.Title);
      Application.Terminate;
    end;

    log.event('******** Product Modelling system ended ********');
    //OptionLock.unlock;
  except
    on E: EAbort do
      begin
        //OptionLock.unlock;
        Application.ShowMainForm := false;
        Application.MainForm.Visible := false;
        EQATECMonitor.EQATECAppException(Application.Title, E);
        EQATECMonitor.CloseDown(Application.Title);
               
        Application.Terminate;
      end;
    on E: Exception do
      begin
        MessageDlg(E.Message+#13+'The application will now terminate.', mtError, [mbOK], E.HelpContext);
        log.event('MAJOR FAIL: ' + e.MESSAGE);
        //OptionLock.unlock;
        Application.ShowMainForm := false;
        Application.MainForm.Visible := false;
        EQATECMonitor.EQATECAppException(Application.Title, E);
        EQATECMonitor.CloseDown(Application.Title);
       
        Application.Terminate;
      end;
  end;

end.
