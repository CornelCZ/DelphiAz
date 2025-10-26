program Purchase0;

uses
  ShareMem,
  TestSrvr,
  MercWwControl,
  Windows,
  Forms,
  SysUtils,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  config in 'config.pas' {frmMainConfig},
  U1WklyPurch in 'U1WklyPurch.pas' {frm1wklypurch},
  uAlliant in 'uAlliant.pas' {fAlliant},
  uChgDate in 'Uchgdate.pas' {fchgdate},
  uConfigDlg in 'uConfigDlg.pas' {fconfigdlg},
  uDMWklyPrchRep in 'uDMWklyPrchRep.pas' {frmDMWklyPrchRep: TDataModule},
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uGetInvDlg in 'uGetInvDlg.pas' {fgetinvdlg},
  uinscat in 'uinscat.pas' {InsertFixCatDlg},
  uinscode in 'uinscode.pas' {frmInsCodeCateg},
  uInvFrm in 'uInvFrm.pas' {finvfrm},
  uInvMenu in 'uInvMenu.pas' {finvmenu},
  uMainMenu in 'uMainMenu.pas' {fmainmenu},
  umiddlg in 'umiddlg.pas' {fmiddlg},
  uMiscMenu in 'uMiscMenu.pas' {fmiscmenu},
  uNewInvDlg in 'uNewInvDlg.pas' {fnewinvdlg},
  uNewItemDlg in 'uNewItemDlg.pas' {fnewitemdlg},
  uProdDlg in 'uProdDlg.pas' {fProddlg},
  UReports in 'UReports.pas' {fReports},
  uRptMenu1 in 'uRptMenu1.pas' {frmRptMenu1},
  uSumDlg in 'uSumDlg.pas' {fsumdlg},
  uwait in 'Uwait.pas' {fwait},
  uADO in 'uADO.pas' {dmADO: TDataModule},
  uComdlg in 'uComdlg.pas' {fComdlg},
  uSiteChoose in 'uSiteChoose.pas' {fSiteChoose},
  uFullReCfg in 'uFullReCfg.pas' {fFullReCfg},
  uConfigure in 'uConfigure.pas' {frmConfigure},
  uSuppliers in 'uSuppliers.pas' {frmSuppliers},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uInvoiceNumMask in 'uInvoiceNumMask.pas' {frmInvoiceNumMask},
  uCurrentMask in 'uCurrentMask.pas' {frmCurrentMask},
  uSaveCostChange in 'uSaveCostChange.pas' {SaveCostChangeDlg},
  uStockOrderMenu in 'uStockOrderMenu.pas' {frmStockOrderMenu},
  dmStock in '..\..\Stock Ordering\Code\dmStock.pas' {StockData: TDataModule},
  dmMain in '..\..\Stock Ordering\Code\dmMain.pas' {Data: TDataModule},
  OrderSummary in '..\..\Stock Ordering\Code\OrderSummary.pas' {frmOrderSummary},
  WaitDlg in '..\..\Stock Ordering\Code\WaitDlg.pas' {frmWaitDlg},
  StdGrid in '..\..\Stock Ordering\Code\StdGrid.pas' {frmStdGrid},
  Schedule in '..\..\Stock Ordering\Code\Schedule.pas' {frmSchedule},
  SupplierSettings in '..\..\Stock Ordering\Code\SupplierSettings.pas' {frmSupplierConfig},
  Order in '..\..\Stock Ordering\Code\Order.pas' {frmOrder},
  OrderFlavour in '..\..\Stock Ordering\Code\OrderFlavour.pas' {frmOrderFlavour},
  EditOrder in '..\..\Stock Ordering\Code\EditOrder.pas' {frmEditOrder},
  EditFlavour in '..\..\Stock Ordering\Code\EditFlavour.pas' {frmEditFlavour},
  SelectItem in '..\..\Stock Ordering\Code\SelectItem.pas' {frmSelectItem},
  SelectFreeFlavour in '..\..\Stock Ordering\Code\SelectFreeFlavour.pas' {frmFreeFlavour},
  SpecifyPUnit in '..\..\Stock Ordering\Code\SpecifyPUnit.pas' {frmSelectPUnit},
  NewOrderNoDlg in '..\..\Stock Ordering\Code\NewOrderNoDlg.pas' {frmNewOrderNo},
  uOrderDates in '..\..\Stock Ordering\Code\uOrderDates.pas' {frmOrderDates},
  WeekReport in '..\..\Stock Ordering\Code\WeekReport.pas' {frmWeekRpt},
  useful in '..\..\Common Files\useful.pas',
  Emailer in '..\..\Stock Ordering\Code\Emailer.pas' {FEmail},
  uADOUtils in '..\..\Common Files\uADOUtils.pas',
  Reports in '..\..\Stock Ordering\Code\Reports.pas' {frmReports},
  Profile in '..\..\Stock Ordering\Code\Profile.pas' {frmProfile},
  uUnacceptedInternalTransferDetail in 'uUnacceptedInternalTransferDetail.pas' {frmUnacceptedInternalTransferDetail},
  uInternaltransferMenu in 'uInternalTransferMenu.pas' {frmInternalTransferMenu},
  uInternalTransferSiteSelect in 'uInternalTransferSiteSelect.pas' {frmInternalTransferSiteSelect},
  uInternalTransferUnaccepted in 'uInternalTransferUnaccepted.pas' {frmInternalTransferUnaccepted},
  uNewInternalTransfer in 'uNewInternalTransfer.pas' {frmNewInternalTransfer},
  uDeliveryNoteValidation in 'uDeliveryNoteValidation.pas' {frmDeliveryNoteValidation},
  uDeliveryNoteCorrection in 'uDeliveryNoteCorrection.pas' {frmDeliveryNoteCorrection},
  Serial5 in '..\..\Common Files\Components\Serial5.pas',
  uInvoiceManager in 'uInvoiceManager.pas' {InvoiceManager: TDataModule},
  uSetupRBuilderPreview in '..\..\Common Files\uSetupRBuilderPreview.pas',
  uEQATECMonitor in '..\..\Common Files\uEQATECMonitor.pas',
  uAztecStringUtils in '..\..\Classes\Utilities\uAztecStringUtils.pas',
  uInternalTransferRestService in 'uInternalTransferRestService.pas',
  ulog in '..\..\Common Files\ulog.pas';

{$R *.RES}
{$R version.res}

begin
  CreateMutex(nil, false, 'AZTEC_PURCHASING');

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, RegisterWindowMessage('AZTEC_PURCHASING'), 0, 0);
    {Lets quit}
    Halt(0);
  end;

  Application.Initialize;
  log.setup('log','PULog',99,100);
  log.SetModule('');
  log.event('');
  log.event('Start Up; System starting');
  Application.Title := 'Aztec Purchasing';
  Application.CreateForm(TdmADO, dmADO);
  Application.CreateForm(TData, Data);
  Application.CreateForm(Tfmainmenu, fmainmenu);
  Application.CreateForm(TSaveCostChangeDlg, SaveCostChangeDlg);
  Application.CreateForm(TStockData, StockData);
  Application.CreateForm(TfrmOrderSummary, frmOrderSummary);
  Application.CreateForm(TfrmWaitDlg, frmWaitDlg);
  Application.CreateForm(TFEmail, FEmail);
  Application.CreateForm(TfrmReports, frmReports);
  Application.CreateForm(TfrmProfile, frmProfile);
  Application.CreateForm(TfrmDeliveryNoteCorrection, frmDeliveryNoteCorrection);
  Application.CreateForm(TfrmDeliveryNoteValidation, frmDeliveryNoteValidation);
  try
    Application.Run;
    EQATECMonitor.CloseDown(Application.Title);
  except
    on E:Exception do
    begin
      log.event('SYSTEM ERROR; MAJOR FAIL: ' + e.Message);
    end;
  end;

  log.event('Exit; System ended');
end.
