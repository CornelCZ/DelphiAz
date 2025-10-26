program SQLPricing;

uses
  ShareMem,
  Forms,
  Windows,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uPricingLog in 'uPricingLog.pas',
  uMainMenu in 'uMainMenu.pas' {fmainmenu},
  useful in '..\..\Common Files\useful.pas',
  uADO in 'uADO.pas' {dmADO: TDataModule},
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  SysUtils,
  uGlobals in '..\..\Common Files\uGlobals.pas',
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uSABands in 'uSABands.pas' {fSABands},
  uPriceMatrix in 'uPriceMatrix.pas' {fPriceMatrix},
  uProductStructureFilterFrame in 'uProductStructureFilterFrame.pas' {ProductStructureFilterFrame: TFrame},
  uBandParser in '..\..\Common Files\uBandParser.pas',
  uPriceStartDate in 'uPriceStartDate.pas' {fPriceStartDate},
  uIncDec in 'uIncDec.pas' {fIncDec},
  uAddMatrix in 'uAddMatrix.pas' {fAddMatrix},
  uDelMatrix in 'uDelMatrix.pas' {fDelMatrix},
  uSiteMatrix in 'uSiteMatrix.pas' {fSiteMatrix},
  MercWwControl in '..\..\Common Files\WinRunner\MercWwControl.pas',
  TestSrvr in '..\..\Common Files\WinRunner\TestSrvr.pas',
  uProgress in 'uProgress.pas' {ProgressForm},
  uCompanyStructureFilterFrame in 'uCompanyStructureFilterFrame.pas' {CompanyStructureFilterFrame: TFrame},
  uOffBandPricesForm in 'uOffBandPricesForm.pas' {OffBandPricesForm},
  uExcelExportImport in '..\..\Common Files\uExcelExportImport.pas',
  uImportErrorLog in '..\..\Common Files\uImportErrorLog.pas' {fImportErrorLog},
  uEditPriceBandName in 'uEditPriceBandName.pas' {EditPriceBandNameForm},
  uSetupRBuilderPreview in '..\..\Common Files\uSetupRBuilderPreview.pas',
  uOdbc2 in '..\..\Common Files\uOdbc2.pas',
  uTagSelection in '..\..\Common Files\uTagSelection.pas' {fTagSelection},
  uProductSearchFrame in 'uProductSearchFrame.pas' {ProductSearchFrame: TFrame},
  uEQATECMonitor in '..\..\Common Files\uEQATECMonitor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Aztec Pricing';

  CreateMutex(nil, false, 'Aztec_Pricing');

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, RegisterWindowMessage('Aztec_Pricing'), 0, 0);
    {Lets quit}
    Halt(0);
  end;

  Log.Setup('Log', 'BPLog', 99, 100);
  Log.Event('System', 'Basic Pricing System Starting');

  Application.CreateForm(TdmADO, dmADO);
  Application.CreateForm(Tfmainmenu, fmainmenu);
  try
    Application.Run;
    EQATECMonitor.CloseDown(Application.Title);
  except
    on E:exception do
    begin
      log.Event('System', 'MAJOR FAIL: ' + e.MESSAGE);
    end;
  end;

  Log.Event('System', 'Basic Pricing system ended');
end.
