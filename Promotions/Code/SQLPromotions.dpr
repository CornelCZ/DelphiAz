program SQLPromotions;

{$R 'PromotionsSQL.res' 'PromotionsSQL.rc'}
{$R 'WizardBitmaps.res' 'WizardBitmaps.rc'}
{$R 'AztecProgressAnim\AztecProgressAnim.res' 'AztecProgressAnim\AztecProgressAnim.rc'}
{$R '..\..\Common Files\Icons\ArrowGlyphs.res' '..\..\Common Files\Icons\ArrowGlyphs.rc'}

uses
  Forms,
  SysUtils,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  uXPFix in '..\..\Common Files\uXPFix.pas',
  uPromotionWizard in 'uPromotionWizard.pas' {PromotionWizard},
  uPromotionList in 'uPromotionList.pas' {PromotionList},
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  udmPromotions in 'udmPromotions.pas' {dmPromotions: TDataModule},
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  useful in '..\..\Common Files\useful.pas',
  uDataTree in '..\..\Common Files\uDataTree.pas',
  uExceptionWizard in 'uExceptionWizard.pas' {ExceptionWizard},
  uGroupPriceMethodFrame in 'uGroupPriceMethodFrame.pas' {GroupPriceMethodFrame: TFrame},
  uSetPromotionOrderFrame in 'uSetPromotionOrderFrame.pas' {SetPromotionOrderFrame: TFrame},
  uPreloadWaitScreen in 'uPreloadWaitScreen.pas' {PreloadWaitScreen},
  uExcelExportImport in '..\..\Common Files\uExcelExportImport.pas',
  uImportErrorLog in '..\..\Common Files\uImportErrorLog.pas' {fImportErrorLog},
  uPromotionReports in 'uPromotionReports.pas' {PromotionReports},
  uPromoCommon in 'uPromoCommon.pas',
  uSimpleLocalise in '..\..\Common Files\uSimpleLocalise.pas',
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uPromotionSummary in 'uPromotionSummary.pas' {PromotionSummary},
  uGridSortHelper in '..\..\Common Files\GridSortHelper\uGridSortHelper.pas',
  uPromotionFilterFrame in 'uPromotionFilterFrame.pas' {PromotionFilterFrame: TFrame},
  uSetupRBuilderPreview in '..\..\Common Files\uSetupRBuilderPreview.pas',
  uOdbc2 in '..\..\Common Files\uOdbc2.pas',
  uSwipeCardRanges in '..\..\Theme Modelling\Code\uSwipeCardRanges.pas' {frmSwipeCardRanges},
  uADO_SwipeRange in '..\..\Theme Modelling\Code\uADO_SwipeRange.pas' {dmADO_SwipeRange: TDataModule},
  uEditSwipeCardRange in '..\..\Theme Modelling\Code\uEditSwipeCardRange.pas' {frmEditSwipeCardRange},
  uSwipeCardExceptions in '..\..\Theme Modelling\Code\uSwipeCardExceptions.pas' {SwipeCardExceptions},
  uSwipeCardExceptionValue in '..\..\Theme Modelling\Code\uSwipeCardExceptionValue.pas' {SwipeCardExceptionValue},
  uGenerateThemeIDs in '..\..\Theme Modelling\Code\uGenerateThemeIDs.pas',
  uEditValidationConfigs in '..\..\Theme Modelling\Code\uEditValidationConfigs.pas' {frmEditValidationConfigs},
  uPriceIncDec in 'uPriceIncDec.pas' {frmPriceIncDec},
  uAddPortionPriceMapping in 'uAddPortionPriceMapping.pas' {fAddPortionPriceMapping},
  uSiteTagFilterFrame in '..\..\Common Files\uSiteTagFilterFrame.pas' {SiteTagFilterFrame: TFrame},
  uBaseTagFilterFrame in '..\..\Common Files\uBaseTagFilterFrame.pas' {BaseTagFilterFrame: TFrame},
  uProductTagFilterFrame in '..\..\Common Files\uProductTagFilterFrame.pas' {ProductTagFilterFrame: TFrame},
  uTag in '..\..\Common Files\uTag.pas',
  uADO in 'uADO.pas' {dmADO: TDataModule},
  uAztecLog in '..\..\Common Files\uAztecLog.pas',
  MemCheck in '..\..\Common Files\MemCheck.pas',
  uPriorityTemplates in 'uPriorityTemplates.pas' {fPriorityTemplates},
  uPriorityTemplateWizard in 'uPriorityTemplateWizard.pas' {fPriorityTemplateWizard},
  uSiteTemplates in 'uSiteTemplates.pas' {fSiteTemplates},
  uSiteSASelectionFrame in 'uSiteSASelectionFrame.pas' {SiteSASelectionFrame: TFrame},
  uSitePromotionPriorities in 'uSitePromotionPriorities.pas' {fSitePromotionPriorities},
  uWizardManager in '..\..\Common Files\uWizardManager.pas',
  uTagListFrame in '..\..\Common Files\uTagListFrame.pas' {TagListFrame: TFrame},
  uTagSelection in '..\..\Common Files\uTagSelection.pas',
  uViewDeleted in 'uViewDeleted.pas' {fViewDeleted},
  uwait in 'uwait.pas' {fwait};

{$R version.res}
{$R *.res}

begin
  Application.Initialize;
  InitialiseLog(ExtractFilePath(Application.ExeName) + '\log\PPLog.log');
  Log('System', 'Promotional Pricing System Starting');
  Application.Title := 'Promotions';
  Application.CreateForm(TdmPromotions, dmPromotions);
  Application.CreateForm(TPromotionList, PromotionList);
  Application.CreateForm(TdmADO_SwipeRange, dmADO_SwipeRange);
  Application.CreateForm(TfrmEditValidationConfigs, frmEditValidationConfigs);
  Application.CreateForm(TfAddPortionPriceMapping, fAddPortionPriceMapping);
  Application.CreateForm(TdmADO, dmADO);
  Application.CreateForm(TfSiteTemplates, fSiteTemplates);
  Application.CreateForm(TfSitePromotionPriorities, fSitePromotionPriorities);
  Application.Run;
  Log('System', 'Promotional Pricing system ended');
end.
