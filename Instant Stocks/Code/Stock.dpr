program Stock;

uses
  ShareMem,
  Windows,
  Forms,
  sysutils,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  uaccepted in 'uaccepted.pas' {faccepted},
  uAudit in 'uAudit.pas' {fAudit},
  uImportStock in 'uImportStock.pas' {ImportStockForm},
  uCurrdlg in 'uCurrdlg.pas' {fCurrdlg},
  udata1 in 'udata1.pas' {data1: TDataModule},
  uDataProc in 'uDataProc.pas' {dataProc: TDataModule},
  uRepHold in 'uRepHold.pas' {fRepHold: TDataModule},
  uMainMenu in 'uMainMenu.pas' {fMainMenu},
  uReps1 in 'uReps1.pas' {fReps1},
  uRepSP in 'uRepSP.pas' {fRepSP: TDataModule},
  uStkdatesdlg in 'uStkdatesdlg.pas' {fStkDatesDlg},
  uStkDivdlg in 'uStkDivdlg.pas' {fStkDivdlg},
  uStkMisc in 'uStkMisc.pas' {fstkmisc},
  uRepTrad in 'uRepTrad.pas' {fRepTrad: TDataModule},
  uwait in 'uwait.pas' {fwait},
  uADO in 'uADO.pas' {dmADO: TDataModule},
  uConfTh in 'uConfTh.pas' {fConfTh},
  dAccPurch in 'dAccPurch.pas' {dmAccPurch: TDataModule},
  ustkutil in 'ustkutil.pas' {fStkutil},
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uSetNom in 'uSetNom.pas' {fSetNom},
  uPickRep in 'uPickRep.pas' {fPickRep},
  uReps2 in 'uReps2.pas' {fReps2},
  uHOrep in 'uHOrep.pas' {fHOrep},
  uAud1Pr in 'uAud1Pr.pas' {fAud1Pr},
  uAudCalc in 'uAudCalc.pas' {fAudCalc},
  uComdlg in 'uComdlg.pas' {fComdlg},
  uWasteAdj in 'uWasteAdj.pas' {fWasteAdj},
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uNewAudit in 'uNewAudit.pas' {fNewAudit},
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uSecurity in 'uSecurity.pas' {fSecurity},
  uSecCopy in 'uSecCopy.pas' {fSecCopy},
  uWaitAR in 'uWaitAR.pas' {fWaitAR},
  uConfig in 'uConfig.pas' {ConfigForm},
  uLC in 'uLC.pas' {fLC},
  uLCTempl in 'uLCTempl.pas' {fLCtempl},
  uLCmultiDM in 'uLCmultiDM.pas' {LCmultiDM: TDataModule},
  uHZmove in 'uHZmove.pas' {fHZmove},
  uPCWasteEdit in 'uPCWasteEdit.pas' {fPCWasteEdit},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  dRunSP in 'dRunSP.pas' {dmRunSP: TDataModule},
  uLCchoose in 'uLCchoose.pas' {fLCchoose},
  uLCRep in 'uLCRep.pas' {fLCRep},
  TestSrvr in '..\..\Common Files\WinRunner\TestSrvr.pas',
  MercWwControl in '..\..\Common Files\WinRunner\MercWwControl.pas',
  MercControl in '..\..\Common Files\WinRunner\MercControl.pas',
  MercCustControl in '..\..\Common Files\WinRunner\MercCustControl.pas',
  uLineCheckComment in 'uLineCheckComment.pas' {GetLineCheckCommentForm},
  uHandHeldStockImport in 'uHandHeldStockImport.pas' {frmHandHeldStockCountImport},
  Serial5 in '..\..\Common Files\Components\Serial5.pas',
  useful in '..\..\Common Files\useful.pas',
  uXPFix in '..\..\Common Files\uXPFix.pas',
  uHZMoveImportDelivery in 'uHZMoveImportDelivery.pas' {fHZMoveImportDelivery},
  uHZMoveChoose in 'uHZMoveChoose.pas' {fHZMoveChoose},
  uHZMoveRep in 'uHZMoveRep.pas' {fHZMoveRep},
  uPCWaste in 'uPCWaste.pas' {fPCWaste},
  uHZMedit in 'uHZMedit.pas' {fHZMedit},
  uPCWasteRep in 'uPCWasteRep.pas' {fPCWasteRep},
  uPCWasteChoose in 'uPCWasteChoose.pas' {fPCWasteChoose},
  uPCWasteHZChoose in 'uPCWasteHZChoose.pas' {fPCWasteHZChoose},
  uSetupRBuilderPreview in '..\..\Common Files\uSetupRBuilderPreview.pas',
  uEQATECMonitor in '..\..\Common Files\uEQATECMonitor.pas',
  ulog in '..\..\Common Files\ulog.pas',
  uAddEditLocation in 'uAddEditLocation.pas' {fAddEditLocation},
  uLocationList in 'uLocationList.pas' {fLocationList},
  uAuditLocations in 'uAuditLocations.pas' {fAuditLocations},
  uWasteAdjLoc in 'uWasteAdjLoc.pas' {fWasteAdjLoc},
  uMobileStockImport in 'uMobileStockImport.pas' {frmMobileStockImport},
  dAutoStockTake in 'dAutoStockTake.pas' {dmAutoStockTake: TDataModule},
  uStockLocationService in 'uStockLocationService.pas',
  uNegativeTheoStockWarning in 'uNegativeTheoStockWarning.pas' {fNegativeTheoStockWarning},
  uAutoFillStockConfirmation in 'uAutoFillStockConfirmation.pas' {fAutoFillStockConfirmation},
  uMustCountItems in 'uMustCountItems.pas' {fMustCountItems};

{$R *.res}

begin
  CreateMutex(nil, false, PChar('AZSS_MUTEX'));

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, RegisterWindowMessage(PChar('AZSS_MUTEX')), 0, 0);
    {Lets quit}
    Halt(0);
  end;

  Application.Initialize;

  Application.HintHidePause := 5000;
  Application.Title := 'Aztec Stock System';
  log.setup('log','SSlog',99,100);
  log.SetModule('');
  log.event('');

  if paramstr(1) = 'blind' then
  begin
    log.event('START BLIND -------------------------------------------');
    Application.CreateForm(TdmAutoStockTake, dmAutoStockTake);
    Application.CreateForm(TfNegativeTheoStockWarning, fNegativeTheoStockWarning);
    Application.CreateForm(TfAutoFillStockConfirmation, fAutoFillStockConfirmation);
  end
  else
  begin
    log.event('START -------------------------------------------------');
    Application.CreateForm(TfMainMenu, fMainMenu);
  end; 
  
  Application.Run;
   EQATECMonitor.CloseDown(Application.Title);
end.
