program ThemeModelling;

{$R *.res}

{--$R '..\..\Common Files\XPFix.res' '..\..\Common Files\XPFix.rc'}
{--$R '..\..\Common Files\GridSortHelper\GridGlyphs.res' '..\..\Common Files\GridSortHelper\GridGlyphs.rc'}

{$R '..\..\Common Files\Icons\ProgressWheel16\ProgressWheel16.res' '..\..\Common Files\Icons\ProgressWheel16\ProgressWheel16.rc'}
{$R '..\..\Common Files\Hardware Icons\AztecHardwareIcons32x32_ico.res' '..\..\Common Files\Hardware Icons\AztecHardwareIcons32x32_ico.rc'}
{$R 'Resource\PromotionalFooterSQL.res' 'Resource\PromotionalFooterSQL.rc'}
{$R 'SiteVariationSQL.res' 'Resource\SiteVariationSQL.rc'}

uses
  ShareMem,
  Forms,
  dialogs,
  controls,
  sysutils,
  Windows,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  uTillButton in 'uTillButton.pas',
  uEditPanelDesignDetails in 'uEditPanelDesignDetails.pas' {EditPanelDesignDetails},
  uEditGenericDetails in 'uEditGenericDetails.pas' {EditGenericDetails},
  uEditThemeDetails in 'uEditThemeDetails.pas' {ThemeDetails},
  uMatchOutletTablePlans in 'uMatchOutletTablePlans.pas' {MatchOutletTablePlans},
  uOutletTablePlans in 'uOutletTablePlans.pas' {OutletTablePlans},
  uSharedPanels in 'uSharedPanels.pas' {SharedPanels},
  uThemeModellingMenu in 'uThemeModellingMenu.pas' {ThemeModellingMenu},
  uThemes in 'uThemes.pas' {Themes},
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  useful in '..\..\Common Files\useful.pas',
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uADO in 'uADO.pas' {dmADO: TDataModule},
  uDMThemeData in 'uDMThemeData.pas' {dmThemeData: TDataModule},
  uGenerateThemeIDs in 'uGenerateThemeIDs.pas',
  uEditOutletTablePlan in 'uEditOutletTablePlan.pas' {EditOutletTablePlan},
  uEnterTableNumberDialog in 'uEnterTableNumberDialog.pas' {EnterTableNumberDialog},
  uTillLabelEditor in 'uTillLabelEditor.pas' {TillLabelEditor},
  uTillButtonEditor in 'uTillButtonEditor.pas' {TillButtonEditor},
  uTillPanelEditor in 'uTillPanelEditor.pas' {TillPanelEditor},
  uXMLSave in '..\..\Common Files\uXMLSave.pas',
  uADODB_27_TLB in '..\..\Common Files\uADODB_27_TLB.pas',
  uAztecZoeComms in 'uAztecZoeComms.pas',
  ZOEDLL in '..\..\Common Files\ZOEDLL.PAS',
  uEditThemeTablePlan in 'uEditThemeTablePlan.pas' {EditThemeTablePlan},
  uEditSharedPanel in 'uEditSharedPanel.pas' {EditSharedPanel},
  uEditPanelDesign in 'uEditPanelDesign.pas' {EditPanelDesign},
  uDesignSharedPanel in 'uDesignSharedPanel.pas' {DesignSharedPanel},
  uButtonTypeDropDown in 'uButtonTypeDropDown.pas' {ButtonMenuCombo},
  uButtonPicker in 'uButtonPicker.pas' {ButtonPicker},
  uPickSite in 'uPickSite.pas' {PickSite},
  uBaseEdit in 'uBaseEdit.pas' {BaseEdit},
  uAddEdit in 'uAddEdit.pas' {frmAddEdit},
  uAddEditPrinter in 'uAddEditPrinter.pas' {frmAddEditPrinter},
  uAddEditTerminal in 'uAddEditTerminal.pas' {frmAddEditTerminal},
  uSharedPanelProperties in 'uSharedPanelProperties.pas' {frmSharedPnlInfo},
  uUpdateTerminals in 'uUpdateTerminals.pas' {UpdateTerminals},
  uStdGrid in 'uStdGrid.pas' {frmStdGrid},
  uPanelOutline in 'uPanelOutline.pas',
  uValidateSubPanels in 'uValidateSubPanels.pas' {frmSubPanelValidate},
  uEditJobSecurity in 'uEditJobSecurity.pas' {EditJobSecurity},
  uEditDialogs in 'uEditDialogs.pas' {EditDialogs},
  uEditSeatPlan in 'uEditSeatPlan.pas' {frmTableSetUp},
  uSiteCustomise in 'uSiteCustomise.pas' {SiteCustomise},
  uThemeTablePlanGroups in 'uThemeTablePlanGroups.pas' {ThemeTablePlanGroups},
  uEditChoices in 'uEditChoices.pas' {EditChoices},
  uEditDialogSecurity in 'uEditDialogSecurity.pas' {EditDialogSecurity},
  uEditTimedJobSecurity in 'uEditTimedJobSecurity.pas' {pnlConditionalSecurity},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  uEditTimedJobPeriod in 'uEditTimedJobPeriod.pas' {EditJobPeriod},
  uShowSitePriceReport in 'uShowSitePriceReport.pas' {ShowSitePriceReport},
  uSitePriceReport in 'uSitePriceReport.pas' {SitePriceReport},
  uTillSubPanelEditor in 'uTillSubPanelEditor.pas' {TillSubPanelEditor},
  uSitePanels in 'uSitePanels.pas' {SitePanels},
  uDesignSitePanel in 'uDesignSitePanel.pas' {DesignSitePanel},
  uEditTicketing in 'uEditTicketing.pas' {EditTicketing},
  uAddEditTicketSequence in 'uAddEditTicketSequence.pas' {AddEditTicketSequence},
  uPickProduct in 'uPickProduct.pas' {PickProduct},
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uAztecLog in '..\..\Common Files\uAztecLog.pas',
  uFunctionVersionWarning in 'uFunctionVersionWarning.pas' {frmFunctionVersionDlg},
  uSelectServers in 'uSelectServers.pas' {SelectServers},
  uSelectPort in 'uSelectPort.pas' {SelectPortForm},
  uWidestringUtils in 'uWidestringUtils.pas',
  uXMLModify in 'uXMLModify.pas',
  AztecResourceStrings in '..\..\Common Files\AztecResourceStrings.pas',
  uEditSwipeCardRange in 'uEditSwipeCardRange.pas' {frmEditSwipeCardRange},
  uSwipeCardRanges in 'uSwipeCardRanges.pas' {frmSwipeCardRanges},
  uTerminalGraphics in 'uTerminalGraphics.pas' {TerminalGraphics},
  uAddGraphic in 'uAddGraphic.pas' {AddGraphic},
  uAddEditConquerorTerminal in 'uAddEditConquerorTerminal.pas' {frmAddEditConquerorTerminal},
  uHardwareIcons in '..\..\Common Files\Hardware Icons\uHardwareIcons.pas',
  uEditOrderDisplay in 'uEditOrderDisplay.pas' {EditOrderDisplay},
  uDatabaseVersion in '..\..\Classes\Database\uDatabaseVersion.pas',
  uAztecDatabaseUtils in '..\..\Classes\Database\uAztecDatabaseUtils.pas',
  uAztecStringUtils in '..\..\Classes\Utilities\uAztecStringUtils.pas',
  uSystemUtils in '..\..\Classes\Utilities\uSystemUtils.pas',
  ULogFile in '..\..\Classes\Logging\ULogFile.pas',
  uGraphicsUtils in '..\..\Classes\Utilities\uGraphicsUtils.pas',
  uEposDevice in '..\..\Classes\Base Classes\uEposDevice.pas',
  uXPFix in '..\..\Common Files\uXPFix.pas',
  uSiteVariations in 'uSiteVariations.pas' {SiteVariations},
  uExcelExportImport in '..\..\Common Files\uExcelExportImport.pas',
  uImportErrorLog in '..\..\Common Files\uImportErrorLog.pas' {fImportErrorLog},
  uPickFutureDate in 'uPickFutureDate.pas' {PickFutureDate},
  uEditVariationPanel in 'uEditVariationPanel.pas' {EditVariationPanel},
  uProductInPanelReport in 'uProductInPanelReport.pas' {ProductInPanelReport},
  uSiteThemes in 'uSiteThemes.pas' {SiteThemes},
  uReports in 'uReports.pas' {Reports},
  uProductInPanelReportParams in 'uProductInPanelReportParams.pas' {ProductInPanelReportParams},
  uDataTree in '..\..\Common Files\uDataTree.pas',
  uSiteVariationsImportErrors in 'uSiteVariationsImportErrors.pas' {SiteVariationsImportErrors},
  uSiteVariationsImportErrorReport in 'uSiteVariationsImportErrorReport.pas' {SiteVariationsImportErrorReport},
  uGridSortHelper in '..\..\Common Files\GridSortHelper\uGridSortHelper.pas',
  uSimpleLocalise in '..\..\Common Files\uSimpleLocalise.pas',
  uPleaseWaitForm in '..\..\Common Files\uPleaseWaitForm.pas' {PleaseWaitForm},
  uMutexControl in 'uMutexControl.pas',
  uKeyLines in 'uKeyLines.pas' {KeyLinesForm},
  uEditOutletDriveThru in 'uEditOutletDriveThru.pas' {EditOutletDriveThru},
  uEditParkingSpace in 'uEditParkingSpace.pas' {EditParkingSpace},
  uAuditReadControl in 'uAuditReadControl.pas',
  uPreviewManager in 'uPreviewManager.pas' {PreviewManager},
  uFormNavigate in 'uFormNavigate.pas',
  uRunProcess in 'uRunProcess.pas',
  uSelectTerminal in 'uSelectTerminal.pas' {SelectTerminalForm},
  uDefineMacros in 'uDefineMacros.pas' {DefineMacros},
  uEditMacro in 'uEditMacro.pas' {EditMacro},
  uSimpleEPOSLineWrap in 'uSimpleEPOSLineWrap.pas',
  uEPOSTextHelper in 'uEPOSTextHelper.pas',
  uWinHelpFixup in '..\..\Common Files\uWinHelpFixup.pas',
  uEditDefaultPanelCycle in 'uEditDefaultPanelCycle.pas' {EditDefaultPanelCycle},
  uEngDeviceList in 'uEngDeviceList.pas' {EngDeviceList},
  uXMLRectanglePatch in '..\..\Common Files\uXMLRectanglePatch.pas',
  uPerformRolloverTasks in 'uPerformRolloverTasks.pas',
  uAddDefaultPanelCycle in 'uAddDefaultPanelCycle.pas' {AddDefaultPanelCycle},
  uEditHotelAnalysisCode in 'uEditHotelAnalysisCode.pas' {EditHotelAnalysisCode},
  uHotelCodeAllocation in 'uHotelCodeAllocation.pas' {HotelCodeAllocation},
  uSwipeCardExceptions in 'uSwipeCardExceptions.pas' {SwipeCardExceptions},
  uSwipeCardExceptionValue in 'uSwipeCardExceptionValue.pas' {SwipeCardExceptionValue},
  uOdbc2 in '..\..\Common Files\uOdbc2.pas',
  uTicketingImageManagement in 'uTicketingImageManagement.pas' {TicketingImageManagement},
  uTicketingImageAddEdit in 'uTicketingImageAddEdit.pas' {TicketingImageAddEdit},
  uTicketingSendToEPOS in 'uTicketingSendToEPOS.pas' {TicketingSendToEPOS},
  uTicketingDefineCBMImage in 'uTicketingDefineCBMImage.pas',
  uEditScaleContainer in 'uEditScaleContainer.pas' {EditScaleContainer},
  uEditDefaultJobPanel in 'uEditDefaultJobPanel.pas' {EditDefaultJobPanel},
  uADO_SwipeRange in 'uADO_SwipeRange.pas' {dmADO_SwipeRange: TDataModule},
  uEditValidationConfigs in 'uEditValidationConfigs.pas' {frmEditValidationConfigs},
  uPromotionalFooter in 'uPromotionalFooter.pas' {PromotionalFooter},
  uDMPromotionalFooter in 'uDMPromotionalFooter.pas' {dmPromotionalFooter: TDataModule},
  uPromotionalFooterWizard in 'uPromotionalFooterWizard.pas' {PromotionalFooterWizard},
  uPreloadWaitScreen in 'uPreloadWaitScreen.pas' {PreloadWaitScreen},
  uFooterPreview in 'uFooterPreview.pas' {FooterPreview},
  uPromotionalFooterPriorities in 'uPromotionalFooterPriorities.pas' {PromotionalFooterPriorities},
  uProductTreeBuilder in 'uProductTreeBuilder.pas' {ProductTreeBuilder},
  uEditDiscount in 'uEditDiscount.pas' {EditDiscount},
  uEditDiscountProdGroup in 'uEditDiscountProdGroup.pas' {EditDiscountProdGroup},
  uMapFooterText in 'uMapFooterText.pas' {MapFooterText},
  uEstateSetup in 'uEstateSetup.pas' {EstateSetup},
  uEditDiscountBarcodes in 'uEditDiscountBarcodes.pas' {EditDiscountBarcodes},
  uTextOverrideWizard in 'uTextOverrideWizard.pas' {TextOverrideWizard},
  uViewMOATerminal in 'uViewMOATerminal.pas' {ViewMOATerminal},
  uBaseEditReconfigurePinPads in 'uBaseEditReconfigurePinPads.pas' {BaseEditReconfigurePinPads},
  uBaseTagFilterFrame in '..\..\Common Files\uBaseTagFilterFrame.pas' {BaseTagFilterFrame: TFrame},
  uSiteTagFilterFrame in '..\..\Common Files\uSiteTagFilterFrame.pas' {SiteTagFilterFrame: TFrame},
  uEQATECMonitor in '..\..\Common Files\uEQATECMonitor.pas',
  uTagListFrame in '..\..\Common Files\uTagListFrame.pas' {TagListFrame: TFrame},
  uEditDiscountReasons in 'uEditDiscountReasons.pas' {EditDiscountReasons},
  uEditTableMoveReasons in 'uEditTableMoveReasons.pas' {EditTableMoveReasons},
  uNewReason in 'uNewReason.pas' {frmNewReason},
  uEditOutletBillFooter in 'uEditOutletBillFooter.pas' {EditOutletBillFooter},
  uSelectReasonsFrame in 'uSelectReasonsFrame.pas' {SelectReasonsFrame: TFrame},
  uEditClmQrCodeText in 'uEditClmQrCodeText.pas' {EditClmQrCodeTextFrm},
  uEditQrCodeOnReceiptText in 'uEditQrCodeOnReceiptText.pas' {EditQrCodeOnReceiptText},
  uConfigureQRCode in 'uConfigureQRCode.pas' {ConfigureQRCode},
  uPosAesKeysService in 'uPosAesKeysService.pas' {PosAesKeysService: TDataModule},
  uDataTree2 in 'uDataTree2.pas';

//  uPrizmTransferForm in '..\..\Common Files\PRIZM Data Transfer\uPrizmTransferForm.pas' {PrizmTransferForm};


{$R version.res}

var
  AutoSendSuccess: boolean;
  tokenParam : string;

function HandleStartup: boolean;
begin
  Result := False;
  uGlobals.GetGlobalData(dmADO.AztecConn);
  SplashForm.Dismiss;

  if TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    dmADO.Logon_Name := UpperCase(CurrentUser.UserName);

    if not ((TfrmPassword.UserHasPermission('AZTEC HO THEME MODELLING') and IsMaster)
            or
            (TfrmPassword.UserHasPermission('AZTEC SITE THEME MODELLING') and IsSite)) then
    begin
      MessageDlg('User has insufficent privileges to edit products' + #10 + #13 +
        #10 + #13 + 'The application will now terminate', mtInformation, [mbOK], 0);
      Log( 'User : ' + dmADO.Logon_Name + ' Failed to login , insufficient rights');
      Exit;
    end;
  end
  else
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    Log('User Cancelled Login');
    Exit;
  end;

  Result := True;
  Log('*********** ' + dmADO.Logon_Name + ' LOGGED IN *********');
  SetLogUserName(dmADO.Logon_Name);
end;

procedure DoExit(Success: boolean);
begin
  // Terminate with response code so status of an AutoSend request
  // can be checked;
  if Success then
  begin
    Halt(0);
  end
  else
  begin
    Halt(1);
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

var
  i, terminalIDForThemeSend : integer;
begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + uSimpleLocalise.LocaliseString('\log\'));
  InitialiseLog(ExtractFilePath(Application.ExeName) + uSimpleLocalise.LocaliseString('\log\ThemeModelling.log'));

  Log(' ');
  Log('Reading command line parameters');
  tokenParam := GetTokenParam;
  uUpdateTerminals.DoingThemeAutoSend := FindCmdLineSwitch('autosend', ['/', '\', '-'], true);
  uUpdateTerminals.SendingThemeToEmptyPos := FindCmdLineSwitch('themesendtoemptypos', ['/', '\', '-'], true);
  uUpdateTerminals.PreventResetOnAutoSend := FindCmdLineSwitch('preventreboot', ['/', '\', '-'], true);
  if FindCmdLineSwitch('performrollovertasks', ['/', '\', '-'], true) then
  begin
    Log('Perfoming rollover tasks.');
    try
      uPerformRolloverTasks.PerformRolloverTasks;
    except on E:Exception do
      Log('Exception raised in rollover tasks: '+E.Message);
    end;
    Log('Done.');
    halt;
  end;
  if uUpdateTerminals.SendingThemeToEmptyPos then
  begin
    Log('Reading terminal ID passed for ThemeSendToEmptyPos');
    for i := 1 to ParamCount do
    begin
      Log('Parameter : ' + IntToStr(i) + '; Value : ' + ParamStr(i));
      if (Pos('deviceid', LowerCase(ParamStr(i))) > 0) then
      begin
        terminalIDForThemeSend := StrToInt(Copy(ParamStr(i),11,(Length(ParamStr(i)) - 10)));
        Log('Terminal ID read as ' + IntToStr(terminalIDForThemeSend));
        uUpdateTerminals.TerminalIDForThemeAutoSend := terminalIDForThemeSend;
        break;
      end;
    end;
  end; 

  Application.Initialize;
  Application.Title := 'Theme Modelling';
  with Application do Title := LocaliseString(Title);

  if uUpdateTerminals.DoingThemeAutoSend or uUpdateTerminals.SendingThemeToEmptyPos then
  begin
    if useful.RunningOnVista and (useful.GetTerminalServicesSessionID = 0) then
      with Application do ShowMainForm := false;
    with Application do CreateForm(TThemeModellingMenu, ThemeModellingMenu);
    dmThemeData := TdmThemeDAta.create(nil);
    dmADO := TdmADO.Create(nil);
    Log('Automatic Send to EPOS initiated at: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',now));
    AutoSendSuccess := ThemeModellingMenu.UpdateTills;
    if AutoSendSuccess then
      Log('Automatic Send successful')
    else
      Log('Automatic Send failed');
    Log('Finished: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',now));
    DoExit(AutoSendSuccess);
  end
  else
  begin
    uWinHelpFixup.ShutDownWinHelpOnClose := false;
    Application.CreateForm(TThemeModellingMenu, ThemeModellingMenu);
  Application.CreateForm(TSplashForm, SplashForm);
  SplashForm.ProductName.Caption := LocaliseString(SplashForm.ProductName.Caption);
    SplashForm.Show;
  end;

  Application.CreateForm(TThemes, Themes);
  Application.CreateForm(TSharedPanels, SharedPanels);
  Application.CreateForm(TOutletTablePlans, OutletTablePlans);
  Application.CreateForm(TMatchOutletTablePlans, MatchOutletTablePlans);
  Application.CreateForm(TdmThemeData, dmThemeData);
  Application.CreateForm(TdmPromotionalFooter, dmPromotionalFooter);
  Application.CreateForm(TdmADO, dmADO);
  Application.CreateForm(TPickSite, PickSite);
  Application.CreateForm(TButtonPicker, ButtonPicker);
  Application.CreateForm(TSiteCustomise, SiteCustomise);
  Application.CreateForm(TSiteVariations, SiteVariations);
  Application.CreateForm(TSiteThemes, SiteThemes);
  Application.CreateForm(TReports, Reports);
  Application.CreateForm(TEditOutletDriveThru, EditOutletDriveThru);
  Application.CreateForm(TPreviewManager, PreviewManager);
  Application.CreateForm(TdmADO_SwipeRange, dmADO_SwipeRange);
  if HandleStartup then
  begin
   Application.Run;
      EQATECMonitor.CloseDown(Application.Title);
  end;
end.
