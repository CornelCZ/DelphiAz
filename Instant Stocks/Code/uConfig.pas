unit uConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Wwdatsrc, ADODB, Wwkeycb, StdCtrls, wwdblook, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, ComCtrls, Mask, wwdbedit, DBCtrls, Buttons,
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppBands,
  ppCtrls, ppVar, ppPrnabl, ppCache, Printers, strUtils, Spin, Wwdotdot,
  Wwdbcomb, Math, wwDialog, Wwlocate;

type
  TConfigForm = class(TForm)
    PageControl1: TPageControl;
    tabPW: TTabSheet;
    pnlFormBottom: TPanel;
    Bevel1: TBevel;
    wwDBGrid1: TwwDBGrid;
    adotProds: TADOTable;
    adoqRun: TADOQuery;
    wwDataSource1: TwwDataSource;
    edtWastageQuantity: TwwDBEdit;
    adoqAWU: TADOQuery;
    cmbbxWastageUnit: TwwDBLookupCombo;
    lookDiv: TComboBox;
    lookCat: TComboBox;
    lookSCat: TComboBox;
    wwDataSource2: TwwDataSource;
    wwIncrementalSearch2: TwwIncrementalSearch;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblWastageQuantity: TLabel;
    lblWastageUnit: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblProductName: TDBText;
    Shape1: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbAWonly: TCheckBox;
    btnDone: TBitBtn;
    btnAutoWasteReport: TBitBtn;
    adoqAWrep: TADOQuery;
    dsAWrep: TwwDataSource;
    ppAWrep: TppReport;
    pipeAWrep: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppShape3: TppShape;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine24: TppLine;
    ppLabel1: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppSummaryBand1: TppSummaryBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppLine1: TppLine;
    ppLabel4: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine8: TppLine;
    ppLine11: TppLine;
    ppLine20: TppLine;
    ppLine23: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    ppLine7: TppLine;
    ppLine9: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBCalc7: TppDBCalc;
    ppDBCalc8: TppDBCalc;
    ppLine13: TppLine;
    ppLine15: TppLine;
    ppLine10: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLabel2: TppLabel;
    ppLine45: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppLine48: TppLine;
    ppLine49: TppLine;
    ppLine50: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine54: TppLine;
    ppLabel16: TppLabel;
    ppDBText11: TppDBText;
    ppShape1: TppShape;
    ppShape2: TppShape;
    ppShape4: TppShape;
    ppLine57: TppLine;
    ppLine58: TppLine;
    ppLine59: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLine67: TppLine;
    ppShape5: TppShape;
    ppLine16: TppLine;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLine55: TppLine;
    ppLine56: TppLine;
    ppLine60: TppLine;
    cbDoz: TCheckBox;
    cbGall: TCheckBox;
    ppLabel17: TppLabel;
    tabLoc_HZ: TTabSheet;
    dsHZs: TwwDataSource;
    wwDataSource4: TwwDataSource;
    gridHZs: TwwDBGrid;
    adotHZs: TADOTable;
    adoqHzPOS: TADOQuery;
    wwDBGrid2: TwwDBGrid;
    btnNewZone: TBitBtn;
    btnActivate: TBitBtn;
    btnAllocateToHZ: TBitBtn;
    btnReleaseFromHZ: TBitBtn;
    btnAcceptPurchases: TBitBtn;
    wwDBGrid3: TwwDBGrid;
    adoqNONhzPOS: TADOQuery;
    wwDataSource3: TwwDataSource;
    Label11: TLabel;
    Label12: TLabel;
    btnCheckSettings: TBitBtn;
    adotHZsSiteCode: TIntegerField;
    adotHZshzID: TIntegerField;
    adotHZshzName: TStringField;
    adotHZsePur: TBooleanField;
    adotHZseOut: TBooleanField;
    adotHZseMoveIn: TBooleanField;
    adotHZseMoveOut: TBooleanField;
    adotHZseSales: TBooleanField;
    adotHZseWaste: TBooleanField;
    adotHZsActive: TBooleanField;
    adotHZsLMDT: TDateTimeField;
    btnSaveChanges: TBitBtn;
    btnDiscardChanges: TBitBtn;
    Label13: TLabel;
    lblHoldingZoneStatus: TLabel;
    Bevel3: TBevel;
    Label15: TLabel;
    tabMinStk: TTabSheet;
    gridMinLevel: TwwDBGrid;
    Panel2: TPanel;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    Label18: TLabel;
    Bevel4: TBevel;
    lookSCMin: TComboBox;
    lookMinLevel: TComboBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    lookDivMin: TComboBox;
    hzTabs: TPageControl;
    hzTab0: TTabSheet;
    Panel4: TPanel;
    Label16: TLabel;
    prodSearch: TwwIncrementalSearch;
    adotMinLevel: TADOTable;
    dsMinLevel: TwwDataSource;
    Panel5: TPanel;
    Label17: TLabel;
    Label22: TLabel;
    labelDel: TLabel;
    Panel3: TPanel;
    Label23: TLabel;
    tabGlobal: TTabSheet;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    Label24: TLabel;
    cbLCzeroLG: TCheckBox;
    cbPcWAtoMisc: TCheckBox;
    Label25: TLabel;
    Label26: TLabel;
    lblStockType: TLabel;
    cbxStockType: TComboBox;
    tabMandatoryLineCheck: TTabSheet;
    pcMandatoryLineCheck: TPageControl;
    tabMLCDefaultSettings: TTabSheet;
    gridDefaultSubcatSettings: TwwDBGrid;
    gridDefaultProductSettings: TwwDBGrid;
    tabMLCSiteSettings: TTabSheet;
    lblChooseSite: TLabel;
    gridSiteSubcatSettings: TwwDBGrid;
    gridSiteProductSettings: TwwDBGrid;
    cmbbxMLCChooseSite: TComboBox;
    chkbxOnlyListSitesWithExceptions: TCheckBox;
    btnRevertThisSiteToDefault: TButton;
    gridMLCDivisions: TwwDBGrid;
    Label31: TLabel;
    pnlColourKey: TPanel;
    lblColourKey: TLabel;
    lblSiteExceptionColour: TLabel;
    lblSiteException: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    btnSiteExceptionsReport: TButton;
    btnRevertAllSitesToDefault: TButton;
    btnMLCSaveChanges: TBitBtn;
    btnMLCDiscardChanges: TBitBtn;
    adotMLCSubcat: TADODataSet;
    adotMLCSubcatSubCategoryName: TStringField;
    adotMLCSubcatExcludedProductsText: TStringField;
    adotMLCSubcatTargetYieldPercent: TIntegerField;
    adotMLCSubcatExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCSubcatDivisionId: TIntegerField;
    adotMLCSubcatSubCategoryId: TIntegerField;
    adotMLCSubcatExcludedProducts: TIntegerField;
    adotMLCSubcatProductCount: TIntegerField;
    adotMLCSubcatModified: TBooleanField;
    dsMLCSubcat: TDataSource;
    adotMLCSiteSubcat: TADODataSet;
    adotMLCSiteSubcatSubCategoryName: TStringField;
    adotMLCSiteSubcatExcludedProductsText: TStringField;
    adotMLCSiteSubcatTargetYieldPercent: TIntegerField;
    adotMLCSiteSubcatExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCSiteSubcatSiteId: TIntegerField;
    adotMLCSiteSubcatSubCategoryId: TIntegerField;
    adotMLCSiteSubcatDivisionId: TIntegerField;
    adotMLCSiteSubcatModified: TBooleanField;
    adotMLCSiteSubcatExcludedProducts: TIntegerField;
    adotMLCSiteSubcatProductCount: TIntegerField;
    dsMLCSiteSubcat: TDataSource;
    adotMLCProduct: TADODataSet;
    dsMLCProduct: TDataSource;
    adotMLCSiteProduct: TADODataSet;
    dsMLCSiteProduct: TDataSource;
    adotMLCDivision: TADODataSet;
    adotMLCDivisionDivisionName: TStringField;
    adotMLCDivisionIncludeInMandatoryLineCheck: TBooleanField;
    adotMLCDivisionDivisionId: TIntegerField;
    dsMLCDivision: TDataSource;
    cmdLoadMandatoryLineCheckData: TADOCommand;
    cmdSaveMandatoryLineCheckChanges: TADOCommand;
    ADOCommand: TADOCommand;
    adotMLCSiteSubcatEstate_TargetYieldPercent: TIntegerField;
    adotMLCSiteSubcatEstate_ExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCSiteProductSiteID: TIntegerField;
    adotMLCSiteProductProductId: TLargeintField;
    adotMLCSiteProductPurchaseName: TStringField;
    adotMLCSiteProductSubcategoryId: TIntegerField;
    adotMLCSiteProductExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCSiteProductEstate_ExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCSiteProductModified: TBooleanField;
    edtNumMandatoryProducts: TSpinEdit;
    adotMLCDivisionModified: TBooleanField;
    adotMLCProductProductId: TLargeintField;
    adotMLCProductPurchaseName: TStringField;
    adotMLCProductSubcategoryId: TIntegerField;
    adotMLCProductExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCProductOriginal_ExcludeFromMandatoryLineCheck: TBooleanField;
    adotMLCProductModified: TBooleanField;
    lblPleaseChooseASite: TLabel;
    lblSiteVersionWarning: TLabel;
    pagesLocOrHz: TPageControl;
    tabLocations: TTabSheet;
    tabHoldingZones: TTabSheet;
    Bevel5: TBevel;
    Label6: TLabel;
    gridLocations: TwwDBGrid;
    cbShowDeletedLoc: TCheckBox;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    btnEditList: TBitBtn;
    btnAddLocation: TBitBtn;
    btnEditLocation: TBitBtn;
    btnDeleteLocation: TBitBtn;
    adoqLocations: TADOQuery;
    dsLocations: TwwDataSource;
    adoqLocationList: TADOQuery;
    dsLocationList: TwwDataSource;
    gridLocationList: TwwDBGrid;
    lookDivLoc: TwwDBComboBox;
    pnlLocOrHZ: TPanel;
    lblHZLocText: TLabel;
    btnUseLocations: TBitBtn;
    btnUseHZs: TBitBtn;
    cbLCbyLoc: TCheckBox;
    adoqLocationsLocationID: TIntegerField;
    adoqLocationsLocationName: TStringField;
    adoqLocationsPrintNote: TStringField;
    adoqLocationsHasFixedQty: TBooleanField;
    adoqLocationsallLines: TIntegerField;
    adoqLocationsunqProdUnits: TIntegerField;
    adoqLocationsunqProds: TIntegerField;
    adoqLocationsLastEdit: TDateTimeField;
    adoqLocationsDeleted: TBooleanField;
    tabMustCount: TTabSheet;
    lblCompany: TLabel;
    cbCompany: TComboBox;
    lblArea: TLabel;
    cbArea: TComboBox;
    gridMustCountTemplate: TwwDBGrid;
    wwDBEdit2: TwwDBEdit;
    dsMustCountTemplate: TwwDataSource;
    dsMustCountTemplateSites: TwwDataSource;
    adotMustCountTemplateSites: TADOTable;
    gridMustCountTemplateSites: TwwDBGrid;
    cbNoTemplateSites: TCheckBox;
    cbNotUsedTemplates: TCheckBox;
    adoqMustCountTemplates: TADOQuery;
    btnAddTemplate: TBitBtn;
    btnEditTemplate: TBitBtn;
    btnDeleteTemplate: TBitBtn;
    btnTemplateList: TBitBtn;
    cbShowDeletedTemplates: TCheckBox;
    Label14: TLabel;
    btnSaveTemplateChanges: TBitBtn;
    btnDiscardTemplateChanges: TBitBtn;
    incSearch1: TwwIncrementalSearch;
    btnPriorSearch: TBitBtn;
    btnNextSearch: TBitBtn;
    wwFind: TwwLocateDialog;
    edSearch: TEdit;
    rbSearchSiteName: TRadioButton;
    rbSearchSiteRef: TRadioButton;
    Label27: TLabel;
    rgSearchKind: TRadioGroup;
    Label28: TLabel;
    btnUnAssignTemplate: TBitBtn;
    btnAssignTemplate: TBitBtn;
    btnCopyTemplate: TBitBtn;
    cbNoCountSheetDlg: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure lookDivCloseUp(Sender: TObject);
    procedure lookCatCloseUp(Sender: TObject);
    procedure lookSCatCloseUp(Sender: TObject);
    procedure adotProdsAfterScroll(DataSet: TDataSet);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cbAWonlyClick(Sender: TObject);
    procedure adotProdsAfterEdit(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure wwDBGrid1CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtWastageQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure edtWastageQuantityExit(Sender: TObject);
    procedure btnAutoWasteReportClick(Sender: TObject);
    procedure ppDBText6GetText(Sender: TObject; var Text: String);
    procedure cmbbxWastageUnitCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
      procedure setMask;
    procedure adotProdsBeforeScroll(DataSet: TDataSet);
    procedure cbDozClick(Sender: TObject);
    procedure cbGallClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ppAWrepPreviewFormCreate(Sender: TObject);
    procedure ppGroupHeaderBand3BeforePrint(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppGroupFooterBand3BeforePrint(Sender: TObject);
    procedure adotHZsAfterScroll(DataSet: TDataSet);
    procedure btnNewZoneClick(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure btnAcceptPurchasesClick(Sender: TObject);
    procedure adoqNONhzPOSAfterOpen(DataSet: TDataSet);
    procedure adoqHzPOSAfterOpen(DataSet: TDataSet);
    procedure btnAllocateToHZClick(Sender: TObject);
    procedure btnReleaseFromHZClick(Sender: TObject);
    procedure adotHZseSalesChange(Sender: TField);
    procedure gridHZsExit(Sender: TObject);
    procedure gridHZsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure btnDiscardChangesClick(Sender: TObject);
    procedure adotHZsAfterEdit(DataSet: TDataSet);
    procedure btnCheckSettingsClick(Sender: TObject);
    procedure lookDivMinCloseUp(Sender: TObject);
    procedure lookSCMinCloseUp(Sender: TObject);
    procedure lookMinLevelCloseUp(Sender: TObject);
    procedure gridMinLevelRowChanged(Sender: TObject);
    procedure gridMinLevelCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure gridMinLevelTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure adotMinLevelAfterScroll(DataSet: TDataSet);
    procedure adotMinLevelBeforePost(DataSet: TDataSet);
    procedure gridMinLevelExit(Sender: TObject);
    procedure adotMinLevelAfterEdit(DataSet: TDataSet);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure hzTabsChange(Sender: TObject);
    procedure gridMinLevelCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure labelDelDblClick(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure cbLCzeroLGClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbxStockTypeChange(Sender: TObject);
    procedure adotMLCSubcatCalcFields(DataSet: TDataSet);
    procedure adotMLCSiteSubcatCalcFields(DataSet: TDataSet);
    procedure btnRevertAllSitesToDefaultClick(Sender: TObject);
    procedure gridSiteSubcatSettingsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure gridSiteProductSettingsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure gridDefaultSubcatSettingsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure btnRevertThisSiteToDefaultClick(Sender: TObject);
    procedure btnMLCDiscardChangesClick(Sender: TObject);
    procedure btnMLCSaveChangesClick(Sender: TObject);
    procedure MLCAfterEdit(DataSet: TDataSet);
    procedure pcMandatoryLineCheckChange(Sender: TObject);
    procedure adotMLCDivisionAfterScroll(DataSet: TDataSet);
    procedure adotMLCSiteSubcatAfterScroll(DataSet: TDataSet);
    procedure cmbbxMLCChooseSiteChange(Sender: TObject);
    procedure edtNumMandatoryProductsChange(Sender: TObject);
    procedure TargetYieldPercentValidate(Sender: TField);
    procedure chkbxOnlyListSitesWithExceptionsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbbxMLCChooseSiteEnter(Sender: TObject);
    procedure adotMLCSiteProductExcludeFromMandatoryLineCheckChange(
      Sender: TField);
    procedure adotMLCProductExcludeFromMandatoryLineCheckChange(
      Sender: TField);
    procedure edtNumMandatoryProductsKeyPress(Sender: TObject;
      var Key: Char);
    procedure adotMLCSubcatAfterScroll(DataSet: TDataSet);
    procedure adotMLCSubcatExcludeFromMandatoryLineCheckChange(
      Sender: TField);
    procedure adotMLCSiteSubcatExcludeFromMandatoryLineCheckChange(
      Sender: TField);
    procedure btnSiteExceptionsReportClick(Sender: TObject);
    procedure btnAddLocationClick(Sender: TObject);
    procedure btnEditLocationClick(Sender: TObject);
    procedure btnDeleteLocationClick(Sender: TObject);
    procedure btnEditListClick(Sender: TObject);
    procedure cbShowDeletedLocClick(Sender: TObject);
    procedure adoqLocationsAfterScroll(DataSet: TDataSet);
    procedure lookDivLocCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure gridLocationsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnUseLocationsClick(Sender: TObject);
    procedure btnUseHZsClick(Sender: TObject);
    procedure cbLCbyLocClick(Sender: TObject);
    procedure cbCompanyCloseUp(Sender: TObject);
    procedure cbNoTemplateSitesClick(Sender: TObject);
    procedure cbAreaCloseUp(Sender: TObject);
    procedure adoqMustCountTemplatesAfterScroll(DataSet: TDataSet);
    procedure btnAddTemplateClick(Sender: TObject);
    procedure btnEditTemplateClick(Sender: TObject);
    procedure btnDeleteTemplateClick(Sender: TObject);
    procedure btnTemplateListClick(Sender: TObject);
    procedure cbShowDeletedTemplatesClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure btnPriorSearchClick(Sender: TObject);
    procedure rbSearchSiteNameClick(Sender: TObject);
    procedure rgSearchKindClick(Sender: TObject);
    procedure adotMustCountTemplateSitesAfterScroll(DataSet: TDataSet);
    procedure btnUnAssignTemplateClick(Sender: TObject);
    procedure btnAssignTemplateClick(Sender: TObject);
    procedure gridMustCountTemplateCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure btnCopyTemplateClick(Sender: TObject);
    procedure btnSaveTemplateChangesClick(Sender: TObject);
    procedure btnDiscardTemplateChangesClick(Sender: TObject);
    procedure adotMustCountTemplateSitesAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    errstr, debugString : string;
    execRes : integer;
    initialMandLC : boolean;
    time1 : tdatetime;

    curValue : string;

    // Pipe Wastage variables
    fillDiv, fillCat, fillSCat, awGridFilt, awOnlyFilt : string;

    // Locations variables
    siteIDstr, curDivision, curDivIDstr : string;
    // HZ variables
    curHz, CurrentTerminal : integer;

    // Min Stk Level variables
    fillDivMin, fillSCMin, mlGridFilt, mlMinLevel : string;

    // Mandatory Line Check variables
    CurrSiteId, CurrDivisionId, CurrSubcatId: integer;
    CurrSiteName: string;
    MLCSiteSettingsRequireUpdate: boolean;
    OriginalNumMandatoryProducts: integer;
    RevertAllSitesToDefault: boolean;
    RevertThisSiteToDefault: boolean;
    AllSitesListCreated: boolean;
    AllSitesList: TStringList;
    RecreateExceptionSitesList: boolean;
    ExceptionSitesList: TStringList;
    SavedDivisionId: integer;
    SavedProductId: Int64;
    SavedSubcategoryId: integer;
    SavedSiteProductId: Int64;
    SavedSiteSubcategoryId: integer;
    NumSitesOlderThan320: integer;

    procedure SetGridFilter;
    procedure SetMinGridFilter;
    procedure PrintAW;
    procedure PrintMinLevel;
    procedure ReLoadHOConf;
    procedure CheckHoldingZoneSettings;
    procedure SaveChangesToHZs;

    procedure UpdateAutoWastage;
    procedure SetUpScreen;
    procedure getStockType;
    procedure setStockType;
    procedure updateLocation;

    procedure PostRecord(dataset: TDataSet);
    procedure SetMLCSiteSubcatFilter;
    procedure SetMLCSiteProductFilter;
    procedure RevertSiteToDefault(SiteId: integer);
    function GetChangeSummaryText: string;
    function GetNumMandatoryLineCheckProducts: integer;
    procedure PopulateMLCChooseSiteCombo(OnlySitesWithExceptions: boolean);
    function GetAllSitesList: TStrings;
    function GetExceptionSitesList: TStrings;
    function SaveChangesToMandatoryLineCheckSettings: boolean;
    procedure SaveSelectedItems;
    procedure RestoreSelectedItems;
    procedure EnableProductExcludeColumn(ProductGrid: TwwDBGrid; enable: boolean);
    procedure InitialiseMandatoryLineCheckTab;
    procedure UpdateMLCSiteSettings;
    procedure InitLocationsTab;
    procedure RequeryLocationList;
    procedure RequeryLocations;
    procedure SetLocOrHZbuttons;
    procedure ReloadMustCountTemplatesAndSites;
    procedure SetTempleteSitesFilter;
    procedure RequeryTemplates;
    function SaveTemplateChanges: boolean;
    function GetMaxStockLocationCount(): Integer;
  end;

procedure ConfigureSystem;

implementation

uses uADO, udata1, ulog, uGlobals, uModuleLauncher, uLocationList, uAddEditLocation, uRepTrad, uMustCountItems, uWait;

const
  NUM_MANDATORY_LINECHECK_PRODUCTS_CONFIGURATION_KEY = 'NumProductsInMandatoryLineCheck';
  DEFAULT_NUM_MANDATORY_LINECHECK_PRODUCTS = 5;

{$R *.dfm}

procedure ConfigureSystem;
var
  ConfigForm: TConfigForm;
begin
  ConfigForm := TConfigForm.Create(nil);

  try
    ConfigForm.ShowModal;
  finally
    FreeAndNil(ConfigForm);
  end;

end;

procedure TConfigForm.FormCreate(Sender: TObject);
begin
  time1 := Now;  // formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)
  debugString := '';

  if uGlobals.IsMaster and not(uGlobals.IsSite) then
    with adoqRun do
    try
      Sql.Text :=
        'DECLARE @Count integer ' +
        'EXEC spGetCountOfSitesOnPreviousVersions ''3.2.0.0'', @Count out ' +
        'SELECT @Count AS NumSitesOlderThan320';
      Open;
      NumSitesOlderThan320 := FieldByName('NumSitesOlderThan320').AsInteger;
    finally
      Close;
    end
  else
    NumSitesOlderThan320 := 0;

  lblSiteVersionWarning.Visible := False;

  if data1.ssDebug then
    debugString := '   ~~~~ CREATE Config form - Debug times: t1 ' + formatDateTime('nn:ss.zzz', Now - time1);
  time1 := Now;

  if ((data1.UserAllowed(-1, 33)) and (uGlobals.isMaster)) then
  begin
    tabGlobal.TabVisible := True;
    tabMandatoryLineCheck.TabVisible := True;
    initialMandLC := True;

    ReLoadHOConf;

    bitbtn15.Enabled := False;
    bitbtn16.Enabled := False;

    tabMustCount.TabVisible := data1.UserAllowed(-1, 37);

    pagecontrol1.ActivePage := tabGlobal;
  end
  else
  begin
    tabGlobal.TabVisible := False;
    tabMandatoryLineCheck.TabVisible := False;
    tabMustCount.TabVisible := False;
  end;

  if not uGlobals.isSite then  // if this is not a site don't bother with sec settings for site config pages...
  begin
    tabPW.TabVisible := False;
    tabLoc_HZ.TabVisible := False;
    tabMinStk.TabVisible := False;

    btnAutoWasteReport.Visible := false;
    cbDoz.Visible := false;
    cbGall.Visible := false;
    exit;
  end;

  //this is a site if the code made it so far...

  // set Site Config pages visible/not depending on security access
  if data1.UserAllowed(-1, 27) then
  begin
    tabPW.TabVisible := (not data1.noTillsOnSite);
    tabLoc_HZ.TabVisible := (not data1.noTillsOnSite);
    tabMinStk.TabVisible := True;
  end
  else
  begin
    tabPW.TabVisible := False;
    tabLoc_HZ.TabVisible := False;
    tabMinStk.TabVisible := False;

    exit;
  end;

  // for more than one page...
  with adoqRun do
  begin
      // should special formatting for Dozen and Gallon be turned on?
    // Yes if it is set for at least one active thread...
    close;
    sql.Clear;
    sql.Add('select count(dozform) as dozes from threads where active = ''Y'' and dozform = ''Y''');
    open;

    if FieldByName('dozes').AsInteger > 0 then
      cbDoz.Checked := True
    else
      cbDoz.Checked := False;

    close;
    sql.Clear;
    sql.Add('select count(gallform) as galls from threads where active = ''Y'' and gallform = ''Y''');
    open;

    if FieldByName('galls').AsInteger > 0 then
      cbGall.Checked := True
    else
      cbGall.Checked := False;

    data1.curdozForm := cbDoz.Checked;
    data1.curGallForm:= cbGall.Checked;

    close;
  end;

  // now do initial data procs depending on what pages are visible
  if tabPW.TabVisible then
  begin
    with adoqRun do
    begin
      // re-do the stkAWprods table
      dmADO.DelSQLTable('stkAwProds');
      close;
      sql.Clear;
      sql.Add('SELECT a.[EntityCode], a.[RetailName] as RetN, a.[Cat], a.[Div], a.[SCat] as Sub,');
      sql.Add('a.[PurchaseName] as PurN, a.[PurchaseUnit], a.[PurchaseUnit] as awUnit,');
      sql.Add('(a.[EntityCode] * 0) as awValue, a.[EntityCode] as EntityCode2, (''     '') as uType,');
      sql.Add('b.Deleted');
      sql.Add('INTO dbo.stkAwProds');
      sql.Add('FROM stkEntity a, Products b');
      sql.Add('WHERE a.[EntityType] = ''Strd.Line''');
      sql.Add('and a.entitycode = b.entitycode');
      sql.Add('order by a.[Div], a.[Cat], a.[SCat], a.[RetailName], a.[PurchaseName]');
      execSQL;

      close;
      sql.Clear;
      sql.Add('update stkAWProds set uType = sq.[Base Type Unit]');
      sql.Add('from (select * from units) sq');
      sql.Add('where stkAWProds.PurchaseUnit = sq.[Unit Name]');
      execSQL;

      // set awValue and awUnit from storage...
      close;
      sql.Clear;
      sql.Add('update stkAwProds set awunit = sq.unit, awvalue = sq.awvalue');
      sql.Add('from (select entitycode, unit, awvalue from stksetaw) sq');
      sql.Add('where stkAwProds.entitycode = sq.entitycode');
      execSQL;

      // delete all items with Deleted = Y except those with AW already set...
      close;
      sql.Clear;
      sql.Add('delete stkAWProds where [Deleted] = ''Y''');
      sql.Add('and ((awvalue = 0) or (awvalue is NULL))');
      execSQL;
    end;

    adotProds.Open;
    adoqAWU.Open;

    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select distinct div from stkawprods');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookDiv.Items.Clear;
      while not eof do
      begin
        lookDiv.Items.Add(FieldByName('div').asstring);
        next;
      end;

      close;

      sql.Clear;
      sql.Add('select distinct cat from stkawprods');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookCat.Items.Clear;
      while not eof do
      begin
        lookCat.Items.Add(FieldByName('cat').asstring);
        next;
      end;

      close;

      sql.Clear;
      sql.Add('select distinct sub from stkawprods');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      looksCat.Items.Clear;
      while not eof do
      begin
        looksCat.Items.Add(FieldByName('sub').asstring);
        next;
      end;
      close;
    end;

    SetMask;

    fillDiv := '';
    fillCat := '';
    fillSCat := '';
    awGridFilt := '';
    awOnlyFilt := '';
    lookdiv.ItemIndex := 0;
    lookcat.ItemIndex := 0;
    lookscat.ItemIndex := 0;
    adotProds.Filter := '';
  end;

  if data1.ssDebug then
    debugString := debugString + '; t4 ' + formatDateTime('nn:ss.zzz', Now - time1);
  time1 := Now;

  // HZ page
  if tabLoc_HZ.TabVisible then
  begin
    pnlLocOrHz.Left := 0;

    // initialise the Locations sub-tab
    InitLocationsTab;

    // initialise the Holding Zones sub-tab
    dmADO.DelSQLTable('stkHZsTmp');
    dmADO.DelSQLTable('stkHzPosTmp');

    // load the temp tables...
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select * INTO dbo.stkHZsTmp from stkHZs');
      sql.Add('');
      execSQL;

      Close;
      SQL.Clear;
      SQL.Add('SELECT SiteCode, hzID, TerminalID, Active, LMDT as LModDT');
      SQL.Add('INTO dbo.stkHzPosTmp');
      SQL.Add('FROM stkHzPos');
      ExecSQL;
    end;

    with adoqNONhzPOS do
    begin
      close;
      sql.Clear;
      SQL.Add('SELECT EPOSDeviceID, [Name], Deleted');
      SQL.Add('FROM ThemeEPOSDevice_repl');
      SQL.Add('WHERE EPOSDeviceID NOT IN (SELECT TerminalID FROM stkHZPosTmp)');
      SQL.Add('AND (  (IsServer = 0)  ');                                                // select only Tills
      SQL.Add('     OR(  (IsServer = 1)');                                               // or "Servers" that are
      SQL.Add('        AND (HardwareType IN (SELECT HardwareType FROM TerminalHardware');// inputs for Hotel plugins
      SQL.Add('                              WHERE HardwareName = ''Hotel System''))))');
      SQL.Add('and SiteCode = ' + inttostr(Data1.TheSiteCode));
      SQL.Add('and HardwareType NOT IN');
      SQL.Add(' (SELECT HardwareType FROM TerminalHardware WHERE HardwareName = ''External API Access'')');
    end;
  end;

  if data1.ssDebug then
    debugString := debugString + '; t5 ' + formatDateTime('nn:ss.zzz', Now - time1);
  time1 := Now;

  // tabMinStk page
  if tabMinStk.TabVisible then
  begin
    tabMinStk.Caption := 'Min. ' + data1.SSbig + ' Levels';
  end; // if minStk page Visible

  if data1.noTillsOnSite then
  begin
    pagecontrol1.ActivePage := tabMinStk;
    pageControl1Change(nil);
  end
  else
  begin
    pagecontrol1.ActivePage := tabPW;
  end;

  if data1.ssDebug then
  begin
    debugString := debugString + '; t6 ' + formatDateTime('nn:ss.zzz', Now - time1);
  end;
end;

procedure TConfigForm.SetGridFilter;
begin
  if awGridFilt <> '' then
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awGridFilt + ' AND ' + awOnlyFilt
    else
      adotProds.Filter := awGridFilt;
  end
  else
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awOnlyFilt
    else
      adotProds.Filter := '';
  end;

  if adotProds.State = dsBrowse then
    adotProdsAfterScroll(adotProds);

  edtWastageQuantity.Enabled := adotProds.RecordCount > 0;
  cmbbxWastageUnit.Enabled   := adotProds.RecordCount > 0;
end;

procedure TConfigForm.lookDivCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookDiv.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillDiv := lookDiv.Text;
    fillCat := '';
    fillSCat := '';
  end
  else
  begin
    fillDiv := '';
    fillCat := '';
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;


  // 1. "filter" the adoqCat
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkawprods');
    if fillDiv <> '' then
       sql.add('where div = ' + quotedStr(fillDiv));

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    lookCat.Items.Clear;
    while not eof do
    begin
      lookCat.Items.Add(FieldByName('cat').asstring);
      next;
    end;
    close;

    lookCat.Refresh;
    lookCat.ItemIndex := 0;
  end;

  // 2. "filter" the adoqSCat
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct sub from stkawprods');
    if f1 <> '' then
       sql.add('where ' + f1);

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  SetGridFilter;
end;

procedure TConfigForm.lookCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillCat := lookCat.Text;
    fillSCat := '';
  end
  else
  begin
    fillCat := '';
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;

  // 2. "filter" the adoqSCat
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct sub from stkawprods');
    if f1 <> '' then
       sql.add('where ' + f1);

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  SetGridFilter;
end;

procedure TConfigForm.lookSCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookSCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillSCat := lookSCat.Text;
  end
  else
  begin
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  SetGridFilter;
end;

procedure TConfigForm.adotProdsAfterScroll(DataSet: TDataSet);
begin
  edtWastageQuantity.Text := data1.dozGallFloatToStr(adotProds.FieldByName('awunit').AsString,
     adotProds.FieldByName('awvalue').AsFloat);

  SetUpScreen;

  labelDel.Visible := (adotProds.FieldByName('deleted').asstring = 'Y');

  SetMask;

  curValue := edtWastageQuantity.Text;
end;

procedure TConfigForm.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Highlight then
    exit;

  if adotProds.FieldByName('awvalue').asfloat > 0 then
  begin
    ABrush.Color := clBlue;
    AFont.Color := clWhite;
  end
  else
  begin
    ABrush.Color := clWhite;
    AFont.Color := clBlack;
  end;
end;

procedure TConfigForm.cbAWonlyClick(Sender: TObject);
begin
  if cbAWonly.Checked then
    awOnlyFilt := 'awvalue > 0'
  else
    awOnlyFilt := '';

  SetGridFilter;
end;

procedure TConfigForm.adotProdsAfterEdit(DataSet: TDataSet);
begin
  bitbtn1.Enabled := True;
  bitbtn2.Enabled := True;
end;

procedure TConfigForm.BitBtn2Click(Sender: TObject);
begin
  if adotProds.State = dsEdit then
    adotprods.Post;

  // re-load the grid, discard all changes...
  if MessageDlg('The changes made so far will be discarded!'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrNo then
    exit;

  // re-do the stkAWprods table
  adoqAWU.Close;
  adotProds.DisableControls;
  adotProds.close;

  with adoqRun do
  begin
    // re-do the stkAWprods table
    dmADO.DelSQLTable('stkAwProds');
    close;
    sql.Clear;
    sql.Add('SELECT a.[EntityCode], a.[RetailName] as RetN, a.[Cat], a.[Div], a.[SCat] as Sub,');
    sql.Add('a.[PurchaseName] as PurN, a.[PurchaseUnit], a.[PurchaseUnit] as awUnit,');
    sql.Add('(a.[EntityCode] * 0) as awValue, a.[EntityCode] as EntityCode2, (''     '') as uType,');
    sql.Add('b.Deleted');
    sql.Add('INTO dbo.stkAwProds');
    sql.Add('FROM stkEntity a, Products b');
    sql.Add('WHERE a.[EntityType] = ''Strd.Line''');
    sql.Add('and a.entitycode = b.entitycode');
    sql.Add('order by a.[Div], a.[Cat], a.[SCat], a.[RetailName], a.[PurchaseName]');
    execSQL;

    close;
    sql.Clear;
    sql.Add('update stkAWProds set uType = sq.[Base Type Unit]');
    sql.Add('from (select * from units) sq');
    sql.Add('where stkAWProds.PurchaseUnit = sq.[Unit Name]');
    execSQL;

    // set awValue and awUnit from storage...
    close;
    sql.Clear;
    sql.Add('update stkAwProds set awunit = sq.unit, awvalue = sq.awvalue');
    sql.Add('from (select entitycode, unit, awvalue from stksetaw) sq');
    sql.Add('where stkAwProds.entitycode = sq.entitycode');
    execSQL;

    // delete all items with Deleted = Y except those with AW already set...
    close;
    sql.Clear;
    sql.Add('delete stkAWProds where [Deleted] = ''Y''');
    sql.Add('and ((awvalue = 0) or (awvalue is NULL))');
    execSQL;
  end;

  fillDiv := '';
  fillCat := '';
  fillSCat := '';
  awGridFilt := '';
  awOnlyFilt := '';
  lookdiv.ItemIndex := 0;
  lookcat.ItemIndex := 0;
  lookscat.ItemIndex := 0;
  adotProds.Filter := '';
  cbAWonly.Checked := False;

  adotProds.Open;
  adotProds.EnableControls;
  adoqAWU.Open;

  bitbtn1.Enabled := False;
  bitbtn2.Enabled := False;
end;

procedure TConfigForm.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotProds do
  begin
    DisableControls;

    if AFieldName = IndexFieldNames then // already Yellow, go back to nothing...
      IndexFieldNames := ''
    else
      IndexFieldNames := AFieldName;

    EnableControls;

    if adotProds.State = dsBrowse then
      adotProdsAfterScroll(adotProds);
  end;
end;

procedure TConfigForm.wwDBGrid1CalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = adotProds.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end;
end;

procedure TConfigForm.BitBtn1Click(Sender: TObject);
begin
  // save ALL changes (in transaction...)
  if adotProds.State = dsEdit then
    adotprods.Post;
  adotProdsBeforeScroll(adotProds);

  // begin the transaction in SQL Server...

  if dmADO.AztecConn.InTransaction then
  begin
    log.event('Error in Save AW settings (before BeginTrans): Already in Transaction');
    showMessage('Error trying to save the Auto Waste settings!' + #13 + #13 +
      'Cannot begin transaction' + #13 + #13 +
      'The previous settings are still in force.');

    exit;
  end;

  dmADO.AztecConn.BeginTrans;

  try
    with adoqRun do
    begin
      // insert items where AW was set now
      errstr := 'Insert new items';
      close;
      sql.Clear;
      sql.Add('insert into [stkSetAW] ("SiteCode", "hzid", "Condition", "EntityCode",');
      sql.Add('       "Unit", "AWValue", "LMDT", LMBy)');
      sql.Add('select ('+IntToStr(data1.TheSiteCode)+') as SiteCode, 0, 0, a."entitycode",');
      sql.Add('a."awunit", a."awvalue",');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as lmdt,');
      sql.Add('('+quotedStr(CurrentUser.UserName)+') as lmBy');
      sql.Add('from "stkAWProds" a');
      sql.Add('where a."entitycode" not in (select distinct entitycode from [stkSetAW])');
      sql.Add('AND a."awvalue" > 0');
      ExecSQL;

      // update items that were changed (either edited qty or unit)
      errstr := 'Update edited items';
      close;
      sql.Clear;
      sql.Add('update [stkSetAW] set awValue = sq.awValue, unit = sq.awunit,');
      sql.Add('[lmBy] = ' + quotedStr(CurrentUser.UserName) + ',');
      sql.Add('[LMDT] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add('from (select a.entitycode, a."awunit", a."awvalue"');
      sql.Add('      from stkAWProds a, stkSetAW b');
      sql.Add('      where a."entitycode" = b."entitycode" and a.awvalue > 0');
      sql.Add('      and not (a.awValue = b.awValue AND a.awunit = b.unit)) sq');
      sql.Add('where stkSetAW."entitycode" = sq."entitycode"');
      execSQL;

      // delete from stkSetAW all items with aw = 0
      errstr := 'Delete Reseted items';
      close;
      sql.Clear;
      sql.Add('Delete [stkSetAW] where awvalue = 0');
      execSQL;

      sql.Clear;
      sql.Add('Delete [stkSetAW] where "entitycode" not in');
      sql.Add(' (select distinct entitycode from [stkAWProds] where awvalue > 0)');
      execSQL;
    end;
  except
    on E:exception do
    begin
      // Error in transaction, attempt to rollback
      if dmADO.AztecConn.InTransaction then
      begin
        dmADO.RollbackTransaction;

        showMessage('Transaction Error trying to save Auto Waste settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'The previous settings are still in force.');

        log.event('Error save AW - Trans. Rolled Back (' + errstr + '): ' + E.Message);
      end
      else
      begin
        showMessage('Transaction Error trying to save Auto Waste settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'Data Integrity concerning Auto Waste settings may have been compromised!');

        log.event('Error in saveAW - Trans. NOT Rolled Back (' + errstr + '): ' + E.Message);
      end;

      exit;
    end;
  end;

  // all OK by now, commit...
  dmADO.CommitTransaction;

  bitbtn1.Enabled := False;
  bitbtn2.Enabled := False;
end;

procedure TConfigForm.edtWastageQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SetUpScreen;
end;

procedure TConfigForm.edtWastageQuantityExit(Sender: TObject);
begin
  UpdateAutoWastage;
end;

procedure TConfigForm.btnAutoWasteReportClick(Sender: TObject);
begin
  if pagecontrol1.ActivePage = tabPW then
    PrintAW
  else if pagecontrol1.ActivePage = tabMinStk then
    PrintMinLevel;
end;

procedure TConfigForm.PrintAW;
begin
  // save AW if edited?
  if bitbtn1.Enabled then
  begin
    if MessageDlg('You have made changes to the Auto Waste Config which have not been saved!'+
      #13+#10+'This report will show the SAVED Auto Waste Config.'+#13+#10+''+
      #13+#10+'Do you still want to view the report now?', mtWarning, [mbYes,mbNo], 0) = mrNo then

      exit;
  end;

  dmADO.DelSQLTable('#ghost');
  with adoqRun do
  begin
    // get the products, names, ...
    close;
    sql.Clear;
    sql.Add('SELECT a.EntityCode, e.Cat, e.Div, e.SCat as Sub,');
    sql.Add('e.PurchaseName as PurN, a.unit, a.awvalue, u."base units" as baseu');
    sql.Add('INTO #ghost');
    sql.Add('FROM stkSetAW a, stkEntity e, Units u');
    sql.Add('WHERE e.Entitycode = a.entitycode');
    sql.Add('and a.unit = u."unit name"');

    if fillDiv <> '' then
    begin
      sql.Add('and c."division name" = ' + quotedStr(fillDiv));
    end;

    if execSQL = 0 then
    begin
      if fillDiv <> '' then
      begin
        showMessage('No items have Auto Wastage set for Division: '  + quotedStr(fillDiv) + #13 +
          'Nothing to report.');
      end
      else
      begin
        showMessage('No items have Auto Wastage set.' + #13 +
          'Nothing to report.');
      end;
      exit;
    end;

    dmADO.DelSQLTable('#ghost2');
    // get the last accepted stocks
    close;
    sql.Clear;
    sql.Add('select division, max(edate) as maxed into #ghost2 from stocks');
    sql.Add('where stockcode > 1');
    if fillDiv <> '' then
    begin
      sql.Add('and division = ' + quotedStr(fillDiv));
    end;
    sql.Add('group by division');
    execSQL;

    dmADO.DelSQLTable('#ghost3');
    // now get the stk numbers
    close;
    sql.Clear;
    sql.Add('select a.division, a.tid, a.stockcode as stkcode into #ghost3 from stocks a, #ghost2 b');
    sql.Add('where a.division = b.division and a.edate = b.maxed');
    execSQL;

    // if 2 threads of same div have stocks with same end date there will be 2 records here
    // make sure only one is left
    // Bugzilla 325054
    close;
    sql.Clear;
    sql.Add('delete [#ghost3] from (');
    sql.Add(' select a.division, min(a.tid) as mtid from [#ghost3] a');
    sql.Add(' group by a.division having count(tid) > 1) sq');
    sql.Add('where [#ghost3].division = sq.division');
    sql.Add('and [#ghost3].tid <> sq.mtid');
    execSQL;
  end;

  // finally get the ActRedCost and NomPrice from stkMain and  * baseu * awvalue
  with adoqawrep do
  begin
    close;
    sql.Clear;
    sql.Add('select a.entitycode, a.div, a.cat, a.sub, a.purn, a.unit, a.awvalue,');
    sql.Add('(b.ActRedCost * a.baseu * a.awvalue) as awCost,');
    sql.Add('(b.NomPrice * a.baseu * a.awvalue) as awPrice');

    sql.Add('FROM StkMain b INNER JOIN');
    sql.Add('  [#ghost3] c ON b.Tid = c.tid AND b.StkCode = c.stkcode RIGHT OUTER JOIN');
    sql.Add('  [#ghost] a ON b.EntityCode = a.EntityCode');
    sql.Add('order by a.div, a.cat, a.sub, a.purn, a.unit');

    open;

    if fillDiv <> '' then
    begin
      pplabel1.Caption := 'Only for Division: ' + fillDiv;
      ppSummaryBand1.Visible := False;
    end
    else
    begin
      pplabel1.Caption := 'Showing ALL DIVISIONS';
      ppSummaryBand1.Visible := True;
    end;

    ppAWrep.print;

    close;
  end;
end;

procedure TConfigForm.PrintMinLevel;
var
  AComponent : TComponent;
begin
  if bitbtn13.Enabled then
  begin
    if MessageDlg('You have made changes to the Min. Level Settings which have not been saved!'+
      #13+#10+''+
      #13+#10+'Do you still want to view the report now?', mtWarning, [mbYes,mbNo], 0) = mrNo then

      exit;
  end;

  dmADO.DelSQLTable('#ghost');
  fRepTrad := TfRepTrad.Create(self);

  if bitbtn13.Enabled then
    fRepTrad.lghzAcc.Visible := True;

  if data1.SiteUsesHZs then
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update [stkHZMinMaxTmp] set MinLevel = sq.MinLevel');
      sql.Add('from');
      sql.Add('  (select a.entitycode, sum(a.MinLevel) as MinLevel');
      sql.Add('   from [stkHZMinMaxTmp] a where a.hzid > 0');
      sql.Add('   group by a.entitycode) sq');
      sql.Add('where [stkHZMinMaxTmp].hzid = 0 and [stkHZMinMaxTmp].entitycode = sq.entitycode');
      execSQL;

      //import the floats in the string field
      close;                                 //326399
      sql.Clear;
      sql.Add('select * from [stkHZMinMaxTmp] where MinLevel is NOT NULL and hzid = 0');
      open;

      while not eof do
      begin
        edit;
        FieldByName('ACount').AsString :=
            data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('MinLevel').asfloat);
        post;
        next;
      end;
      close;
    end;

    adotMinLevel.Requery;

    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT a.hzid, a.[EntityCode], a.[DivisionName], a.[repHdr] as SubCatName, a.[PurchaseName], a.[PurchUnit], a.[ACount]');
      sql.Add('INTO #ghost FROM "stkHZminMaxTmp" a');
      sql.Add('WHERE a.Acount > ''0''');
      sql.Add('Order By a.hzid, a.[DivisionName], a.[repHdr], a.[PurchaseName]');
      execRes := execSQL;

      if execRes = 0 then
      begin
        showmessage('There are no Min. Levels set. Nothing to report.');
        exit;
      end;

      dmADO.DelSQLTable('#minLevelRep');
      // create the report table...
      dmADO.adoqRun2.close;
      dmADO.adoqRun2.sql.Clear;
      dmADO.adoqRun2.sql.Add('CREATE TABLE [#minLevelRep] (');
      dmADO.adoqRun2.sql.Add('	[EntityCode] [float] NULL ,');
      dmADO.adoqRun2.sql.Add('	[DivisionName] [varchar] (20) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('	[SubCatName] [varchar] (20) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('	[PurchaseName] [varchar] (40) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('	[PurchUnit] [varchar] (10) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('	[lgSite] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg1] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg2] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg3] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg4] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg5] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg6] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg7] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg8] [varchar] (9) collate database_default NULL ,');
      dmADO.adoqRun2.sql.Add('  [lg9] [varchar] (9) collate database_default NULL )');
      dmADO.adoqRun2.execSQL;

      dmADO.DelSQLTable('#mlhzList');
      // get all HZs involved in this report
      close;
      sql.Clear;
      sql.Add('select IDENTITY(int, 1,1) AS ID_Num, hzid, hzname INTO [#mlhzList] from stkHZs ');
      sql.Add('where active = 1 and hzid in (select distinct hzid from #ghost)');
      execSQL;

      close;
      sql.Clear;
      sql.Add('SET IDENTITY_INSERT [#mlhzList] ON');
      sql.Add('');
      sql.Add('INSERT [#mlhzList] (ID_Num, hzid, hzname) VALUES (0, 0, ''Site'')');
      sql.Add('');
      sql.Add('SET IDENTITY_INSERT [#mlhzList] OFF');
      execSQL;

      // add each entity from #ghost
      close;
      sql.Clear;
      sql.Add('INSERT [#minLevelRep] ([EntityCode], [DivisionName],[SubCatName], [PurchaseName], [PurchUnit])');
      sql.Add('SELECT DISTINCT [EntityCode], [DivisionName],[SubCatName], [PurchaseName], [PurchUnit] from [#ghost]');
      execSQL;

      close;
      sql.Clear;
      sql.Add('select * from [#mlhzList] order by id_num');
      open;

      first; // this is the site wide...

      dmADO.adoqRun2.close;
      dmADO.adoqRun2.sql.Clear;
      dmADO.adoqRun2.sql.Add('update [#minLevelRep] set lgSite = sq.ACount FROM');
      dmADO.adoqRun2.sql.Add('(select entitycode, Acount from [#ghost] where hzid = 0) sq');
      dmADO.adoqRun2.sql.Add('where [#minLevelRep].entitycode = sq.entitycode');
      dmADO.adoqRun2.execSQL;

      next;  // now the "proper" HZs start...
      while not eof do
      begin
        // set label caption, make it visible
        AComponent := fRepTrad.FindComponent('lghzLab' + FieldByName('id_num').asstring);
        if Assigned(AComponent) then
        begin
          if AComponent is TppLabel then
          begin
            TppLabel(AComponent).Visible := True;
            TppLabel(AComponent).Caption := FieldByName('hzname').asstring;

            case length(TppLabel(AComponent).Caption) of
               1..10 : begin
                         TppLabel(AComponent).Height := 0.17;
                         TppLabel(AComponent).Top := 0.28;
                       end;
               11..20: begin
                         TppLabel(AComponent).Height := 0.3;
                         TppLabel(AComponent).Top := 0.2;
                       end;
                  else begin
                         TppLabel(AComponent).Height := 0.44;
                         TppLabel(AComponent).Top := 0.14;
                       end;
            end; // end case
          end;
        end;

        if FieldByName('id_num').asinteger >= 2 then // 1 HZ at least always visible...
        begin
          // make corresponding lines/db text visible
          AComponent := fRepTrad.FindComponent('lghzTLine' + FieldByName('id_num').asstring);
          if Assigned(AComponent) then
          begin
            if AComponent is TppLine then
            begin
              TppLine(AComponent).Visible := True;
            end;
          end;

          AComponent := fRepTrad.FindComponent('lghzLine' + FieldByName('id_num').asstring);
          if Assigned(AComponent) then
          begin
            if AComponent is TppLine then
            begin
              TppLine(AComponent).Visible := True;
            end;
          end;

          AComponent := fRepTrad.FindComponent('lghzText' + FieldByName('id_num').asstring);
          if Assigned(AComponent) then
          begin
            if AComponent is TppDBText then
            begin
              TppDBText(AComponent).Visible := True;
            end;
          end;
        end;

        // set length of horizontal lines
        fRepTrad.lghzHBotLine.Width := fRepTrad.lghzHBotLine.Width + 0.8124;
        fRepTrad.lghzHMidLine.Width := fRepTrad.lghzHBotLine.Width;
        fRepTrad.lghzHTopLine.Width := fRepTrad.lghzHTopLine.Width + 0.8124;

        // put the data in proper field of [#minLevleRep]
        dmADO.adoqRun2.close;
        dmADO.adoqRun2.sql.Clear;
        dmADO.adoqRun2.sql.Add('update [#MinLevelRep] set lg' + FieldByName('id_num').asstring + ' = sq.ACount FROM');
        dmADO.adoqRun2.sql.Add('(select entitycode, ACount from [#ghost]');
        dmADO.adoqRun2.sql.Add('  where hzid = ' + FieldByName('hzid').asstring + ') sq');
        dmADO.adoqRun2.sql.Add('where [#minLevelRep].entitycode = sq.entitycode');
        dmADO.adoqRun2.execSQL;

        next;
      end;

      // portrait or landscape
      if recordcount <= 6 then
      begin
        // make it portrait
        fRepTrad.ppLGhz.PrinterSetup.Orientation := poPortrait;

        fRepTrad.lghzShape1.left := fRepTrad.lghzShape1.left - 1;
        fRepTrad.lghzTitle.left := fRepTrad.lghzTitle.left - 1;

        fRepTrad.lghzAcc.left := fRepTrad.lghzAcc.left - 2.75;
        fRepTrad.lghzPage.left := fRepTrad.lghzPage.left - 2.75;
        fRepTrad.lghzPrTime.left := fRepTrad.lghzPrTime.left - 2.75;
        fRepTrad.lghzPrinted.left := fRepTrad.lghzPrinted.left - 2.75;

        fRepTrad.ppline413.Width := fRepTrad.ppline413.Width - 2.75;
        fRepTrad.ppline189.Width := fRepTrad.ppline413.Width;
        fRepTrad.ppline190.Width := fRepTrad.ppline413.Width;
        fRepTrad.ppline191.Width := fRepTrad.ppline413.Width;
      end;

      fRepTrad.lghzTitle.Text := pageControl1.ActivePage.Caption + ' Settings';
      fRepTrad.lghzlab0.Text := 'Complete Site';
      fRepTrad.lghzlab1.Visible := True;

      close;
    end;// with
  end   // if haveHZs
  else
  begin // by Site only
    with dmADO.adoqRun do
    begin
      dmADO.DelSQLTable('#minLevelRep');
      close;
      sql.Clear;
      sql.Add('SELECT a.[EntityCode], a.[DivisionName], a.[repHdr] as SubCatName, ');
      sql.Add('a.[PurchaseName], a.[PurchUnit], a.[ACount] as lgSite');
      sql.Add('INTO #minLevelRep FROM "stkHZminMaxTmp" a');
      sql.Add('WHERE a.Acount > ''0''');
      sql.Add('Order By a.[DivisionName], a.[repHdr], a.[PurchaseName]');
      execRes := execSQL;

      if execRes = 0 then
      begin
        showmessage('There are no Min. Levels set. Nothing to report.');
        exit;
      end;

      // only show the site column....
      fRepTrad.lghzlab0.Text := 'Minimum Level';
      fRepTrad.lghzlab1.Visible := False;
        // make it portrait
        fRepTrad.pplghz.PrinterSetup.Orientation := poPortrait;

        fRepTrad.lghzShape1.left := fRepTrad.lghzShape1.left - 1;
        fRepTrad.lghzTitle.left := fRepTrad.lghzTitle.left - 1;

        fRepTrad.lghzAcc.left := fRepTrad.lghzAcc.left - 1.7708;
        fRepTrad.lghzPage.left := fRepTrad.lghzPage.left - 1.7708;
        fRepTrad.lghzPrTime.left := fRepTrad.lghzPrTime.left - 1.7708;
        fRepTrad.lghzPrinted.left := fRepTrad.lghzPrinted.left - 1.7708;

        fRepTrad.ppline413.Width := fRepTrad.ppline413.Width - 1.7708;
        fRepTrad.ppline189.Width := fRepTrad.ppline413.Width;
        fRepTrad.ppline190.Width := fRepTrad.ppline413.Width;
        fRepTrad.ppline191.Width := fRepTrad.ppline413.Width;

      fRepTrad.lghzTitle.Text := pageControl1.ActivePage.Caption + ' Settings';
    end;
  end;

  fRepTrad.lghzTLine1.Visible := fRepTrad.lghzlab1.Visible;
  fRepTrad.lghzLine1.Visible := fRepTrad.lghzlab1.Visible;
  fRepTrad.lghzText1.Visible := fRepTrad.lghzlab1.Visible;

  with fRepTrad.adoqLGhz do
  begin
    close;
    sql.Clear;
    sql.Add('select * from [#minLevelRep] Order By "DivisionName", "subcatname", "purchaseName"');
    open;
  end;

  fRepTrad.ppLGhz.Print;
  fRepTrad.adoqLGhz.Close;
  fRepTrad.free;
end;

procedure TConfigForm.ppDBText6GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText5.Text,Text);
end;

procedure TConfigForm.cmbbxWastageUnitCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  setMask;
end;

procedure TConfigForm.setMask;
begin                                                               // 326393 -> No "-" allowed.
  if (data1.isDozen(adotProds.FieldByName('awunit').AsString)) then
  begin
    edtWastageQuantity.Picture.PictureMask := '{{{#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,' +
        '8,9}]},' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,8,9,10,11}}}';
  end
  else if (data1.isGallon(adotProds.FieldByName('awunit').AsString)) then
  begin
    edtWastageQuantity.Picture.PictureMask :=
     '{{{#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7}]},' + data1.dozgalchar +
     '{0,1[{0,1}],2,3,4,5,6,7}}}';
  end
  else
    edtWastageQuantity.Picture.PictureMask := '{{{#[#][#][#][#][#][.#[#]]},.#[#]}}';

end;

procedure TConfigForm.adotProdsBeforeScroll(DataSet: TDataSet);
begin
  UpdateAutoWastage;
end;

procedure TConfigForm.cbDozClick(Sender: TObject);
begin
  data1.curdozForm := cbDoz.Checked;
end;

procedure TConfigForm.cbGallClick(Sender: TObject);
begin
  data1.curGallForm:= cbGall.Checked;
end;

procedure TConfigForm.PageControl1Change(Sender: TObject);
var
  atab : TTabSheet;
  i : integer;
  reph : string;
begin
  panel3.Visible := False;
  pnlLocOrHZ.Visible := False;
  if (pagecontrol1.ActivePage = tabPW) or (pagecontrol1.ActivePage = tabMinStk) then
  begin
    btnAutoWasteReport.Visible := TRUE;
    if pagecontrol1.ActivePage = tabMinStk then
    begin
      panel3.Visible := True;
      panel3.Align := alClient;
      Application.ProcessMessages;
      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
      begin
        reph := 'SCat';
        label20.Caption := 'Sub-Category';
      end
      else
      begin
        reph := 'Cat';
        label20.Caption := 'Category';
      end;

      btnAutoWasteReport.Caption := 'Min. ' + data1.SSbig + ' Levels Report';
      cbDoz.Visible := false;
      cbGall.Visible := false;

      // load the temp tables...
      with dmADO.adoqRun do
      begin
        // re-do the stkHZMinMaxTmp table
        dmADO.DelSQLTable('stkHZMinMaxTmp');

        close;
        sql.Clear;
        sql.Add('CREATE TABLE dbo.[stkHZMinMaxTmp] ([hzid] [int] NOT NULL,');
        sql.Add('	[EntityCode] [float] NULL, [DivisionName] [varchar] (20) NULL,');
        sql.Add('	[repHdr] [varchar] (20) NULL, [PurchaseName] [varchar] (40) NULL,');
        sql.Add('	[ImpExRef] [varchar] (15) NULL, [EntityType] [varchar] (10) NULL,');
        sql.Add('	[PurchUnit] [varchar] (10) NULL, [PurchBaseU] [float] NULL,');
        sql.Add('	[MinLevel] [float] NULL,	[ACount] [varchar] (9) NULL)');
        execSQL;
      end;

      // destroy any TTabSheet that belongs to hzTabs
      for i := (hzTabs.PageCount - 1) downto 1 do
      begin
        aTab := hzTabs.Pages[i];
        aTab.Free;
      end; // for..


      if data1.SiteUsesHZs then
      begin
        // use the HZtabs but first make them up...
        with dmADO.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('select hzid, hzname, epur, eSales from stkHZs where Active = 1 order by hzid');
          open;

          while not eof do
          begin
            with TTabSheet.Create(hzTabs) do
            begin
              PageControl := hzTabs;
              Tag := FieldByName('hzid').asinteger;
              PageIndex := recNo;
              Caption := FieldByName('hzname').asstring;
              ImageIndex := -1;

              if FieldByName('esales').asboolean then
              begin
                if FieldByName('epur').asboolean then
                  ImageIndex := 2
                else
                  ImageIndex := 0
              end
              else
              begin
                if FieldByName('epur').asboolean then
                  ImageIndex := 1;
              end;
            end;
            next;
          end;

          close;
          // now create stkHZminmaxTmp for HZid 0 and all the other HZs
          close;
          sql.Clear;
          sql.Add('insert stkHZMinMaxTmp ([hzid], [EntityCode], [DivisionName], [repHdr], [PurchaseName],');
          sql.Add(' [ImpExRef], [EntityType], [PurchUnit], [PurchBaseU], [MinLevel], [ACount])');
          sql.Add('select a.hzid, b.[EntityCode], b.[Div], b.' + reph + ', b.[PurchaseName],');
          sql.Add(' b.[ImpExRef], b.[EntityType], b.[PurchaseUnit], b.[PurchBaseU], NULL, ''''');
          sql.Add('from stkEntity b, ');
          sql.Add('  (SELECT h.hzid from stkHZs h where h.Active = 1 UNION SELECT 0) a');
          sql.Add('where b.etcode in (''G'', ''S'')');
          sql.Add('order by a.hzid, b.entitycode');
          execSQL;

          // now bring stored data in from stkHZMinMax
          close;
          sql.Clear;
          sql.Add('update stkHZMinMaxTmp set minLevel = sq.minlevel');
          sql.Add('from ');
          sql.Add('  (select [hzID], [EntityCode], [MinLevel] from stkHZMinMax) sq');
          sql.Add('where stkHZMinMaxTmp.hzid = sq.hzid and stkHZMinMaxTmp.entitycode = sq.entitycode');
          execSQL;

          // if the hzid = 0 has level but the others do not then this is the first time Min Level is set by HZ
          // if the hzid = 0 has a level <> SUM(all other levels) then a HZid was dropped.
          // for both above situations take the Difference and add it to Cellar.
          close;
          sql.Clear;
          sql.Add('update stkHZMinMaxTmp set minLevel = sq.LevelDiff');
          sql.Add('from ');
          sql.Add('  (select a.[EntityCode], (a.[MinLevel] - b.SumMin) as LevelDiff');
          sql.Add('   from stkHZMinMaxTmp a, ');
          sql.Add('        (select m.[EntityCode], SUM(m.[MinLevel]) as SumMin from stkHZMinMaxTmp m');
          sql.Add('         where m.hzid > 0 group by m.[EntityCode]) b');
          sql.Add('   where a.[EntityCode] = b.[EntityCode] and a.hzid = 0');
          sql.Add('   and ABS(a.[MinLevel] - b.SumMin) > 0.000001) sq');
          sql.Add('where stkHZMinMaxTmp.entitycode = sq.entitycode and stkHZMinMaxTmp.hzid = ' +
                                              inttostr(data1.purHZid));
          execSQL;
        end;

        hzTabs.Visible := True;
        hzTabs.ActivePageIndex := 1;
        label22.Visible := False;
      end
      else
      begin
        // DO NOT show the HZtabs...

        hzTabs.ActivePageIndex := 0;
        hzTabs.Visible := False;

        with dmADO.adoqRun do
        begin
          // now create stkHZminmaxTmp For HZid = 0 ONLY
          close;
          sql.Clear;
          sql.Add('insert stkHZMinMaxTmp ([hzid], [EntityCode], [DivisionName], [repHdr], [PurchaseName],');
          sql.Add(' [ImpExRef], [EntityType], [PurchUnit], [PurchBaseU], [MinLevel], [ACount])');
          sql.Add('select 0, b.[EntityCode], b.[Div], b.' + reph + ', b.[PurchaseName],');
          sql.Add(' b.[ImpExRef], b.[EntityType], b.[PurchaseUnit], b.[PurchBaseU], NULL, ''''');
          sql.Add('from stkEntity b');
          sql.Add('where b.etcode in (''G'', ''S'')');
          sql.Add('order by b.entitycode');
          execSQL;

          // now bring stored data in from stkHZMinMax for HZid = 0 only
          // if stkHZMinMax has data for other HZids (from the past) then it will be deleted
          // if user Saves Changes.
          close;
          sql.Clear;
          sql.Add('update stkHZMinMaxTmp set minLevel = sq.minlevel');
          sql.Add('from ');
          sql.Add('  (select [EntityCode], [MinLevel] from stkHZMinMax where hzid = 0) sq');
          sql.Add('where stkHZMinMaxTmp.entitycode = sq.entitycode');
          execSQL;
       end;
      end;

      with dmADO.adoqRun do
      begin
        //import the floats in the string field
        close;
        sql.Clear;
        sql.Add('select * from [stkHZMinMaxTmp] where MinLevel is NOT NULL');
        open;

        while not eof do
        begin
          edit;
          FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('MinLevel').asfloat);
          post;
          next;
        end;
        close;

        // set up the Filter drop downs
        close;
        sql.Clear;
        sql.Add('select distinct divisionname from stkHZMinMaxTmp');
        sql.Add('union select ('' - SHOW ALL - '') as divisionname order by divisionname');
        open;
        first;

        lookDivMin.Items.Clear;
        while not eof do
        begin
          lookDivMin.Items.Add(FieldByName('divisionname').asstring);
          next;
        end;

        close;
        sql.Clear;
        sql.Add('select distinct rephdr from stkHZMinMaxTmp');
        sql.Add('union select ('' - SHOW ALL - '') as divname');
        open;
        first;

        lookSCMin.Items.Clear;
        while not eof do
        begin
          lookSCMin.Items.Add(FieldByName('rephdr').asstring);
          next;
        end;
        close;
      end;

      lookDivMin.ItemIndex := 0;
      lookSCMin.ItemIndex := 0;
      lookMinLevel.ItemIndex := 0;

      fillDivMin := '';
      fillSCMin := '';
      mlGridFilt := '';
      mlMinLevel := '';

      SetMinGridFilter;

      with gridMinLevel, gridMinLevel.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;
        Selected.Add('DivisionName'#9'20'#9'Division'#9'F');
        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          Selected.Add('repHdr'#9'20'#9'Sub-Category'#9#9)
        else
          Selected.Add('repHdr'#9'20'#9'Category'#9#9);
        Selected.Add('PurchaseName'#9'40'#9'Product Name'#9'F');
        Selected.Add('PurchUnit'#9'10'#9'Unit'#9'F');
        Selected.Add('ACount'#9'12'#9'Set Min. Level'#9'F');

        ApplySelected;

        EnableControls;
        Open;
      end;
      panel3.Visible := False;
    end
    else
    begin
      btnAutoWasteReport.Caption := 'Auto Waste Config Report';
      cbDoz.Visible := true;
      cbGall.Visible := true;
    end;
  end
  else
  begin
    adotMinLevel.Close;
    btnAutoWasteReport.Visible := false;
    cbDoz.Visible := false;
    cbGall.Visible := false;
  end;

  if pagecontrol1.ActivePage = tabLoc_HZ then
  begin
    adotMinLevel.Close;

    adoqNONhzPOS.open;
    adothzs.open;
    adoqhzPOS.open;
    adothzs.First;
    CheckHoldingZoneSettings;

    RequeryLocations;
    RequeryLocationList;

    // check the status of HZs and Location and set the variables, just in case...
    data1.siteUsesLocations := data1.CheckSiteUsesLocations;
    data1.siteUsesHZs := data1.CheckSiteUsesHZs;

    if data1.siteUsesHZs then
      PagesLocOrHz.ActivePage := tabHoldingZones
    else
      PagesLocOrHz.ActivePage := tabLocations;



    SetLocOrHZbuttons;
    pnlLocOrHZ.Visible := TRUE;
  end
  else
  begin
    adoqLocationList.Close;
    adoqLocations.Close;
    adothzs.close;
    adoqNONhzPOS.close;
    adoqhzPOS.close;
  end;

  if (pagecontrol1.ActivePage = tabMandatoryLineCheck) then
  begin
    // moved v. slow init code here, so people who do not use Mandatory LC don't have to wait when opening Config screen
    if initialMandLC then
    begin
      InitialiseMandatoryLineCheckTab;
      initialMandLC := False;
    end;
  end;

  if pagecontrol1.ActivePage = tabMustCount then
  begin
    ReloadMustCountTemplatesAndSites;
  end
  else
  begin
    adotMustCountTemplateSites.Close;
    adoqMustCountTemplates.Close;
  end;

end;

procedure TConfigForm.ppAWrepPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TConfigForm.ppGroupHeaderBand3BeforePrint(Sender: TObject);
begin
  if ppAWrep.DeviceType = 'Printer' then
  begin
    ppshape4.Brush.Color := clCream;
  end
  else
  begin
    ppshape4.Brush.Color := clSilver;
  end;
end;

procedure TConfigForm.ppDetailBand1BeforePrint(Sender: TObject);
begin
  if ppAWrep.DeviceType = 'Printer' then
  begin
    ppshape1.Brush.Color := clCream;
  end
  else
  begin
    ppshape1.Brush.Color := clSilver;
  end;
  ppshape5.Brush.Color := ppshape1.Brush.Color;
end;

procedure TConfigForm.ppGroupFooterBand3BeforePrint(Sender: TObject);
begin
  if ppAWrep.DeviceType = 'Printer' then
  begin
    ppshape2.Brush.Color := clCream;
  end
  else
  begin
    ppshape2.Brush.Color := clSilver;
  end;
end;

procedure TConfigForm.adotHZsAfterScroll(DataSet: TDataSet);
begin
  if adotHZs.RecordCount = 0 then
  begin
    btnActivate.Enabled := FALSE;
  end
  else
  begin
    btnActivate.Enabled := TRUE;
  end;


  curHz := adotHZs.FieldByName('hzid').AsInteger;
  label12.Caption := 'POS Terminals allocated to' + #13 +
     'HZ: "' + adotHZs.FieldByName('hzname').AsString + '"';

  if adotHZs.FieldByName('active').asboolean then
  begin
    btnActivate.Caption := 'De-Activate';
    btnAcceptPurchases.Enabled := not adotHZs.FieldByName('ePur').asboolean;
    btnAllocateToHZ.Visible := adotHZs.FieldByName('eSales').asboolean;

    adotHZseSales.ReadOnly := FALSE;
    adotHZseWaste.ReadOnly := FALSE;
    adotHZshzName.ReadOnly := FALSE;
  end
  else
  begin
    btnActivate.Caption := 'Activate';
    btnAcceptPurchases.Enabled := FALSE;
    btnAllocateToHZ.Visible := FALSE;

    adotHZseSales.ReadOnly := TRUE;
    adotHZseWaste.ReadOnly := TRUE;
    adotHZshzName.ReadOnly := TRUE;
  end;

  wwDBGrid2.Visible        := btnAllocateToHZ.Visible;
  btnReleaseFromHZ.Visible := btnAllocateToHZ.Visible;
  label12.Visible          := btnAllocateToHZ.Visible;
  label25.Visible          := btnAllocateToHZ.Visible;
  label26.Visible          := btnAllocateToHZ.Visible;


  btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
  if adoqhzPOS.Active then
    btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);

  label25.Enabled := btnAllocateToHZ.Enabled;
  label26.Enabled := btnReleaseFromHZ.Enabled;

end;

procedure TConfigForm.btnNewZoneClick(Sender: TObject);
var
  maxHzID : integer;
begin
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(hzid) as cc from stkhzstmp where [active] = 1');
    open;

    if FieldByName('cc').asinteger < MAX_HOLDING_ZONES then
    begin
      adotHZs.disablecontrols;

      close;
      sql.Clear;
      sql.Add('select max(hzid) as themax from stkhzstmp');
      open;

      maxHzID := FieldByName('themax').asinteger;
      close;

      close;
      sql.Clear;
      sql.Add('insert into [stkHZstmp] ([SiteCode], [hzID], [hzName], ');
      sql.Add('       [eMoveIn], [eMoveOut], [Active], [ePur], [eSales])');
      sql.Add('Values (' + inttostr(data1.TheSiteCode) + ',');
      sql.Add(inttostr(maxhzid + 1) + ', ''Holding Zone ' + inttostr(maxhzid + 1) + ''',');
      sql.Add('1, 1, 1, 0, 0)');
      ExecSQL;

      adotHZs.requery;
      adotHZs.locate('hzid', maxhzid + 1, []);
      adotHZs.enablecontrols;
    end  // if.. then..
    else
    begin
      showmessage('There are ' + inttostr(MAX_HOLDING_ZONES) + ' ' + data1.SSbig +
        ' Holding Zones active, which is the maximum number allowed' + #13 +
        'If you want to add another Holding Zone you need to De-Activate one that is currently active first');
    end; //if.. then.. else..
    close;
  end;

  btnSaveChanges.Enabled := True;
  btnDiscardChanges.Enabled := True;
end;

procedure TConfigForm.btnActivateClick(Sender: TObject);
begin

  if btnActivate.Caption = 'Activate' then
  begin
    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(hzid) as cc from stkhzstmp where [active] = 1');
      open;

      if FieldByName('cc').asinteger < MAX_HOLDING_ZONES then
      begin
        with adotHZs do
        begin
          disablecontrols;
          adotHzsActive.ReadOnly := False;

          edit;
          FieldByName('Active').AsBoolean := True;
          post;

          adotHzsActive.ReadOnly := True;
          enablecontrols;
        end;

      end  // if.. then..
      else
      begin
        showmessage('There are ' + inttostr(MAX_HOLDING_ZONES) + ' '  + data1.SSbig +
          ' Holding Zones active, which is the maximum number allowed' + #13 +
          'If you want to activate this Holding Zone you need to De-Activate one that is currently active first');
      end; //if.. then.. else..
      close;
    end;
  end
  else
  begin
    with adotHZs do
    begin
      disablecontrols;
      adotHzsActive.ReadOnly := False;
      adotHzsePur.ReadOnly := False;

      edit;
      FieldByName('Active').AsBoolean := False;
      // release the Purchaseable and Sales flags...
      FieldByName('ePur').asBoolean := False;
      FieldByName('eSales').asBoolean := False;
      if adotHZs.State = dsEdit then // needed as adotHZ could have been posted by eSalesOnChange
        post;

      // de-allocate any POSes...
      with adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('delete stkhzpostmp where hzid = ' + inttostr(curHZ));
        execSQL;
      end;

      adoqNONhzPOS.requery;
      adoqhzPOS.requery;
      btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
      btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);

      adotHzsActive.ReadOnly := True;
      adotHzsePur.ReadOnly := True;
      enablecontrols;
    end;
  end;
end;

procedure TConfigForm.btnAcceptPurchasesClick(Sender: TObject);
begin
  with adotHZs do
  begin
    curHz := FieldByName('hzid').AsInteger;

    disablecontrols;
    adotHzsePur.ReadOnly := False;

    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkhzstmp set ePur = 0');
      sql.Add('');
      sql.Add('update stkhzstmp set ePur = 1 where hzid = ' + inttostr(curHz));
      execSQL;
    end;

    requery;

    locate('hzid', curHz, []);

    adotHzsePur.ReadOnly := True;
    enablecontrols;
    btnSaveChanges.Enabled := True;
    btnDiscardChanges.Enabled := True;
  end;
end;

procedure TConfigForm.adoqNONhzPOSAfterOpen(DataSet: TDataSet);
begin
  btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
end;

procedure TConfigForm.adoqHzPOSAfterOpen(DataSet: TDataSet);
begin
  btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);
end;

procedure TConfigForm.btnAllocateToHZClick(Sender: TObject);
begin
  if not (btnAllocateToHZ.Visible and btnAllocateToHZ.Enabled) then  // if this proc is called from the grid's Dbl Click
    exit;                      // and the button is not visible or not enabled then exit

  curHz := adotHZs.FieldByName('hzid').AsInteger;
  CurrentTerminal := adoqNONhzPOS.FieldByName('EPOSDeviceID').AsInteger;

  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('insert stkhzpostmp (sitecode, hzid, TerminalID)');
    sql.Add('Values(' + inttostr(data1.TheSiteCode) + ', '  + inttostr(curHz) +
                    ', ' + inttostr(CurrentTerminal) + ')');
    execSQL;
  end;

  adoqNONhzPOS.requery;
  adoqhzPOS.requery;
  btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
  btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);

  label25.Enabled := btnAllocateToHZ.Enabled;
  label26.Enabled := btnReleaseFromHZ.Enabled;

  btnSaveChanges.Enabled := True;
  btnDiscardChanges.Enabled := True;
end;

procedure TConfigForm.btnReleaseFromHZClick(Sender: TObject);
begin
  if not (btnReleaseFromHZ.Visible and btnReleaseFromHZ.Enabled) then  // if this proc is called from the grid's Dbl Click
    exit;                      // and the button is not visible or not enabled then exit

  curHz := adotHZs.FieldByName('hzid').AsInteger;
  CurrentTerminal := adoqhzPOS.FieldByName('TerminalID').asinteger;

  with adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE stkhzpostmp');
    SQL.Add('where hzid = ' + inttostr(curHZ));
    SQL.Add('AND TerminalID = ' + inttostr(CurrentTerminal));
    ExecSQL;
  end;

  adoqNONhzPOS.requery;
  adoqhzPOS.requery;
  btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
  btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);

  label25.Enabled := btnAllocateToHZ.Enabled;
  label26.Enabled := btnReleaseFromHZ.Enabled;

  btnSaveChanges.Enabled := True;
  btnDiscardChanges.Enabled := True;
end;

procedure TConfigForm.adotHZseSalesChange(Sender: TField);
var
  s1 : string;
begin
  if adotHZs.State <> dsEdit then
    Exit;

  if adotHZseSales.AsBoolean = False then
  begin
    // check to see if any tills allocated to this HZ
    if adoqhzPOS.RecordCount > 0 then
    begin
      if adoqhzPOS.RecordCount = 1 then
        s1 := 'There is one POS allocated to this HZ.'+#13+
          'Disabling Sales for this HZ will automatically de-allocate the POS.'
      else
        s1 := 'There are ' + inttostr(adoqhzPOS.RecordCount) + ' POS Terminals allocated to this HZ.'+#13+
          'Disabling Sales for this HZ will automatically de-allocate the POS Terminals.';

      if MessageDlg(s1 +#13+''+#13+
        'Do you still want to disable Sales for this HZ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        curHz := adotHZs.FieldByName('hzid').AsInteger;

        with adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('delete stkhzpostmp where hzid = ' + inttostr(curHZ));
          execSQL;
        end;

        adoqNONhzPOS.requery;
        adoqhzPOS.requery;
        btnAllocateToHZ.Enabled := (adoqNONhzPOS.RecordCount > 0);
        btnReleaseFromHZ.Enabled := (adoqhzPOS.RecordCount > 0);
      end
      else
      begin
        adotHZseSales.AsBoolean := True;
        exit;
      end;
    end;
  end;

  adotHZs.Post;
end;

procedure TConfigForm.gridHZsExit(Sender: TObject);
begin
  if (adotHZs.State = dsEdit) or (adotHZs.State = dsInsert) then
    adotHZs.Post;
end;

procedure TConfigForm.gridHZsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if adotHZsActive.AsBoolean then
  begin
    if (Field.FieldName = 'Active') or (Field.FieldName = 'ePur') then
    begin
      if Highlight then
      begin
        ABrush.Color := clInactiveCaption;
      end
      else
      begin
        ABrush.Color := clBtnFace;
      end;
    end;
  end
  else
  begin
    if Highlight then
      ABrush.Color := clInactiveCaption
    else
      ABrush.Color := clBtnFace;
    AFont.Style := [fsItalic];
  end;
end;


procedure TConfigForm.btnSaveChangesClick(Sender: TObject);
begin
  SaveChangesToHZs;
end;


procedure TConfigForm.btnDiscardChangesClick(Sender: TObject);
begin
  // re-load the grids, discard all changes...
  if MessageDlg('Any changes made so far will be discarded!'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrNo then
    exit;

  adothzs.disablecontrols;
  adoqNONhzPOS.disablecontrols;
  adoqhzPOS.disablecontrols;

  adothzs.close;
  adoqNONhzPOS.close;
  adoqhzPOS.close;

  dmADO.DelSQLTable('stkHZsTmp');
  dmADO.DelSQLTable('stkHzPosTmp');

  // load the temp tables...
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * INTO dbo.stkHZsTmp from stkHZs');
    sql.Add('');
    execSQL;

    close;
    sql.Clear;
    sql.Add('select * INTO dbo.stkHzPosTmp from stkHzPos');
    execSQL;
  end;

  adoqNONhzPOS.open;
  adothzs.open;
  adoqhzPOS.open;

  adothzs.enablecontrols;
  adoqNONhzPOS.enablecontrols;
  adoqhzPOS.enablecontrols;

  adothzs.First;
  btnSaveChanges.Enabled := False;
  btnDiscardChanges.Enabled := False;

  CheckHoldingZoneSettings;
end;

procedure TConfigForm.adotHZsAfterEdit(DataSet: TDataSet);
begin
  btnSaveChanges.Enabled := True;
  btnDiscardChanges.Enabled := True;
end;

procedure TConfigForm.btnCheckSettingsClick(Sender: TObject);
begin
  CheckHoldingZoneSettings;
end;


procedure TConfigForm.lookDivMinCloseUp(Sender: TObject);
begin
  if lookDivMin.Text <> ' - SHOW ALL - ' then
  begin // restrict lookSCMin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select distinct rephdr from stkHZMinMaxTmp');
      sql.add('where divisionname = ' + quotedStr(lookDivMin.Text));
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookSCMin.Items.Clear;
      while not eof do
      begin
        lookSCMin.Items.Add(FieldByName('rephdr').asstring);
        next;
      end;
      close;
    end;

    fillDivMin := lookDivMin.Text;
    fillSCMin := '';
    lookSCMin.ItemIndex := 0;
    lookSCMin.Refresh;
  end
  else
  begin
    // "release" lookSCMin just in case it was restricted...
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select distinct rephdr from stkHZMinMaxTmp');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookSCMin.Items.Clear;
      while not eof do
      begin
        lookSCMin.Items.Add(FieldByName('rephdr').asstring);
        next;
      end;
      close;
    end;

    fillDivMin := '';
    fillSCMin := '';
    lookSCMin.ItemIndex := 0;
    lookSCMin.Refresh;
  end;


  if fillDivMin <> '' then
  begin
    mlGridFilt := 'Divisionname = ' + quotedStr(fillDivMin);
  end
  else
  begin
    mlGridFilt := '';
  end;
  SetMinGridFilter;
end;

procedure TConfigForm.lookSCMinCloseUp(Sender: TObject);
begin
  if fillDivMin <> '' then
  begin
    if lookSCMin.Text <> ' - SHOW ALL - ' then
    begin
      mlGridFilt := '((Divisionname = ' + quotedStr(fillDivMin) + ') AND (RepHdr = ' +
        quotedStr(lookSCMin.Text) + '))';
    end
    else
    begin
      mlGridFilt := '(Divisionname = ' + quotedStr(fillDivMin) + ')';
    end;
  end
  else
  begin
    if lookSCMin.Text <> ' - SHOW ALL - ' then
    begin
      mlGridFilt := '(RepHdr = ' + quotedStr(lookSCMin.Text) + ')';
    end
    else
    begin
      mlGridFilt := '';
    end;
  end;
  SetMinGridFilter;
end;

procedure TConfigForm.lookMinLevelCloseUp(Sender: TObject);
begin
  case lookMinLevel.ItemIndex of
    1: mlMinLevel := '(Acount <= ''0'')';
    2: mlMinLevel := '(Acount > ''0'')';
  else mlMinLevel := '';
  end; // case..
  SetMinGridFilter;
end;


procedure TConfigForm.SetMinGridFilter;
var
  f1 : string;
begin
  // always filter by HZ...
  f1 := '(hzID = ' + inttostr(hzTabs.ActivePage.tag) + ')';

  if mlGridFilt <> '' then
  begin
    f1 := f1 + ' AND (' + mlGridFilt + ')';
  end;

  if mlMinLevel <> '' then
  begin
    f1 := f1 + ' AND (' + mlMinLevel + ')';
  end;

  adotMinLevel.Filter := f1;

//  if adotMinLevel.State = dsBrowse then
//    adotMinLevelAfterScroll(adotMinLevel);

end; // procedure..

procedure TConfigForm.gridMinLevelRowChanged(Sender: TObject);
begin
  gridMinLevel.PictureMasks.Strings[0] := 'ACount' +
     data1.setGridMask(adotMinLevel.FieldByName('PurchUnit').asstring,'');
end;

procedure TConfigForm.gridMinLevelCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = adotMinLevel.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end;
end;

procedure TConfigForm.gridMinLevelTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotMinLevel do
  begin
    DisableControls;

    if AFieldName = IndexFieldNames then // already Yellow, go back to nothing...
      IndexFieldNames := '[hzid]; [DivisionName]; [repHdr]; [PurchaseName]'
    else
      IndexFieldNames := AFieldName;

    if IndexFieldNames = 'PurchaseName' then
    begin
      //prodSearch.Enabled := True;
      prodSearch.ReadOnly := False;
      prodSearch.Color := clWindow;
    end
    else
    begin
      //prodSearch.Enabled := False;
      prodSearch.ReadOnly := True;
      prodSearch.Color := clBtnFace;
    end;


    EnableControls;

    if adotMinLevel.State = dsBrowse then
      adotMinLevelAfterScroll(adotMinLevel);
  end; 
end;

procedure TConfigForm.adotMinLevelAfterScroll(DataSet: TDataSet);
begin
  if adotMinLevel.RecordCount = 0 then
  begin
    if (mlGridFilt <> '') or (mlMinLevel <> '') then
      showmessage('There are no products for the selected filter criteria.')
    else
      showmessage('There are no products available.');

    gridMinLevel.Enabled := False;
  end
  else
  begin
    if (hzTabs.Visible) and (hzTabs.ActivePage.tag = 0) then
      gridMinLevel.Enabled := false
    else
      gridMinLevel.Enabled := true;

    gridMinLevel.PictureMasks.Strings[0] := 'ACount' +
         data1.setGridMask(adotMinLevel.FieldByName('PurchUnit').Value,'');
  end;
end;

procedure TConfigForm.adotMinLevelBeforePost(DataSet: TDataSet);
begin
  if adotMinLevel.FieldByName('ACount').asstring = '' then
  begin
    adotMinLevel.FieldByName('MinLevel').asstring := '';
  end
  else
  begin
    adotMinLevel.FieldByName('MinLevel').AsFloat :=
       data1.dozGallStrToFloat(adotMinLevel.FieldByName('PurchUnit').Value,
                                adotMinLevel.FieldByName('ACount').asstring);
  end;

end;

procedure TConfigForm.gridMinLevelExit(Sender: TObject);
begin
  if gridMinLevel.DataSource.DataSet.State = dsEdit then
    gridMinLevel.DataSource.DataSet.Post;

end;

procedure TConfigForm.adotMinLevelAfterEdit(DataSet: TDataSet);
begin
  bitbtn13.Enabled := True;
  bitbtn14.Enabled := True;
end;

procedure TConfigForm.BitBtn13Click(Sender: TObject);
begin
  // save ALL changes (in transaction...)
  if adotMinLevel.State = dsEdit then
    adotMinLevel.Post;

  // begin the transaction in SQL Server...
  if dmADO.AztecConn.InTransaction then
  begin
    log.event('Error in Save Min Level settings (before BeginTrans): Already in Transaction');
    showMessage('Error trying to save the Min. Level settings!' + #13 + #13 +
      'Cannot begin transaction' + #13 + #13 +
      'The previous settings are still in force.');

    exit;
  end;

  dmADO.AztecConn.BeginTrans;

  try
    with adoqRun do
    begin
      if data1.SiteUsesHZs then
      begin
        close;
        sql.Clear;
        sql.Add('update [stkHZMinMaxTmp] set MinLevel = sq.MinLevel');
        sql.Add('from');
        sql.Add('  (select a.entitycode, sum(a.MinLevel) as MinLevel');
        sql.Add('   from [stkHZMinMaxTmp] a where a.hzid > 0');
        sql.Add('   group by a.entitycode) sq');
        sql.Add('where [stkHZMinMaxTmp].hzid = 0 and [stkHZMinMaxTmp].entitycode = sq.entitycode');
        execSQL;
      end;

      sql.Clear;
      sql.Add('Truncate Table [stkHZMinMax]');
      execSQL;

      sql.Add('insert into [stkHZMinMax] ([SiteCode], [hzID], [EntityCode],');
      sql.Add('       [HoldingUnit], [MinLevel], [BaseU], [LMDT], [LMBy])');
      sql.Add('select ('+IntToStr(data1.TheSiteCode)+') as SiteCode, hzid, "entitycode",');
      sql.Add('       [PurchUnit], [MinLevel], [PurchBaseU],');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as lmdt,');
      sql.Add('('+quotedStr(CurrentUser.UserName)+') as lmBy');
      sql.Add('from [stkHZMinMaxTmp]');
      sql.Add('where [MinLevel] is not NULL and [MinLevel] > 0');
      ExecSQL;
    end;
  except
    on E:exception do
    begin
      // Error in transaction, attempt to rollback
      if dmADO.AztecConn.InTransaction then
      begin
        dmADO.RollbackTransaction;

        showMessage('Transaction Error trying to save Min. Level settings!' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'The previous settings are still in force.');

        log.event('Error save Min. Level - Trans. Rolled Back : ' + E.Message);
      end
      else
      begin
        showMessage('Transaction Error trying to save Min. Level settings!' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'Data Integrity concerning Min. Level settings may have been compromised!');

        log.event('Error in saveMin. Level - Trans. NOT Rolled Back : ' + E.Message);
      end;

      exit;
    end;
  end;

  // all OK by now, commit...
  dmADO.CommitTransaction;

  bitbtn13.Enabled := False;
  bitbtn14.Enabled := False;
end;

procedure TConfigForm.BitBtn14Click(Sender: TObject);
begin
  if gridMinLevel.DataSource.DataSet.State = dsEdit then
    gridMinLevel.DataSource.DataSet.Post;

  // re-load the grid, discard all changes...
  if MessageDlg('The changes made so far will be discarded!'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrNo then
    exit;

  adotMinLevel.DisableControls;
  adotMinLevel.close;

  with adoqRun do
  begin
    // erase existing levels
    close;
    sql.Clear;
    sql.Add('update stkHZMinMaxTmp set minLevel = NULL, ACount = NULL');
    execSQL;

    if data1.SiteUsesHZs then
    begin
      // now bring stored data in from stkHZMinMax
      close;
      sql.Clear;
      sql.Add('update stkHZMinMaxTmp set minLevel = sq.minlevel');
      sql.Add('from ');
      sql.Add('  (select [hzID], [EntityCode], [MinLevel] from stkHZMinMax) sq');
      sql.Add('where stkHZMinMaxTmp.hzid = sq.hzid and stkHZMinMaxTmp.entitycode = sq.entitycode');
      execSQL;

      // if the hzid = 0 has level but the others do not then this is the first time Min Level is set by HZ
      // if the hzid = 0 has a level <> SUM(all other levels) then a HZid was dropped.
      // for both above situations take the Difference and add it to Cellar.
      close;
      sql.Clear;
      sql.Add('update stkHZMinMaxTmp set minLevel = sq.LevelDiff');
      sql.Add('from ');
      sql.Add('  (select a.[EntityCode], (a.[MinLevel] - b.SumMin) as LevelDiff');
      sql.Add('   from stkHZMinMaxTmp a, ');
      sql.Add('        (select m.[EntityCode], SUM(m.[MinLevel]) as SumMin from stkHZMinMaxTmp m');
      sql.Add('         where m.hzid > 0 group by m.[EntityCode]) b');
      sql.Add('   where a.[EntityCode] = b.[EntityCode] and a.hzid = 0');
      sql.Add('   and ABS(a.[MinLevel] - b.SumMin) > 0.000001) sq');
      sql.Add('where stkHZMinMaxTmp.entitycode = sq.entitycode and stkHZMinMaxTmp.hzid = ' +
                                          inttostr(data1.purHZid));
      execSQL;
    end
    else
    begin
      close;
      sql.Clear;
      sql.Add('update stkHZMinMaxTmp set minLevel = sq.minlevel');
      sql.Add('from ');
      sql.Add('  (select [EntityCode], [MinLevel] from stkHZMinMax where hzid = 0) sq');
      sql.Add('where stkHZMinMaxTmp.entitycode = sq.entitycode');
      execSQL;
    end;

    //import the floats in the string field
    close;                                  //326399
    sql.Clear;
    sql.Add('select * from [stkHZMinMaxTmp] where MinLevel is NOT NULL');
    open;

    while not eof do
    begin
      edit;
      FieldByName('ACount').AsString :=
          data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('MinLevel').asfloat);
      post;
      next;
    end;
    close;

    // reset filter boxes
    close;
    sql.Clear;
    sql.Add('select distinct rephdr from stkHZMinMaxTmp');
    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    lookSCMin.Items.Clear;
    while not eof do
    begin
      lookSCMin.Items.Add(FieldByName('rephdr').asstring);
      next;
    end;
    close;

    lookDivMin.ItemIndex := 0;
    lookSCMin.ItemIndex := 0;
    lookMinLevel.ItemIndex := 0;
    lookSCMin.Refresh;

    fillDivMin := '';
    fillSCMin := '';
    mlGridFilt := '';
    mlMinLevel := '';

    SetMinGridFilter;
  end;

  adotMinLevel.Open;
  adotMinLevel.EnableControls;

  bitbtn13.Enabled := False;
  bitbtn14.Enabled := False;
end;

procedure TConfigForm.hzTabsChange(Sender: TObject);
begin
  if gridMinLevel.DataSource.DataSet.State = dsEdit then
    gridMinLevel.DataSource.DataSet.Post;

  adotMinLevel.DisableControls;

  if data1.SiteUsesHZs then
  begin
    if hzTabs.ActivePageIndex = 0 then
    begin // make read only

      // sum-up, place in the hzid = 0, fill ACount for it...
      with data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update [stkHZMinMaxTmp] set MinLevel = sq.MinLevel');
        sql.Add('from');
        sql.Add('  (select a.entitycode, sum(a.MinLevel) as MinLevel');
        sql.Add('   from [stkHZMinMaxTmp] a where a.hzid > 0');
        sql.Add('   group by a.entitycode) sq');
        sql.Add('where [stkHZMinMaxTmp].hzid = 0 and [stkHZMinMaxTmp].entitycode = sq.entitycode');
        execSQL;

        //import the floats in the string field
        close;                                  //326399
        sql.Clear;
        sql.Add('select * from [stkHZMinMaxTmp] where MinLevel is NOT NULL and hzid = 0');
        open;

        while not eof do
        begin
          edit;
          FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('MinLevel').asfloat);
          post;
          next;
        end;
        close;
      end;

      adotMinLevel.Requery;

      adotMinLevel.FieldByName('ACount').ReadOnly := True;

      label22.Visible := True;
      SetMinGridFilter;
    end
    else
    begin
      adotMinLevel.Requery;
      adotMinLevel.FieldByName('ACount').ReadOnly := False;

      label22.Visible := False;
      SetMinGridFilter;
    end;
  end;

  adotMinLevel.EnableControls;
end;

procedure TConfigForm.gridMinLevelCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if Field.FieldName = 'ACount' then
    if Field.ReadOnly then
      ABrush.Color := clBtnFace
//    else
//      ABrush.Color := clWindow;
end;

procedure TConfigForm.labelDelDblClick(Sender: TObject);
begin
  ShowMessage('This product is no longer active in the Product Model!' + #13 + #13 +
    'Set its Auto Waste level to 0 (ZERO) and it will no longer be shown.' + #13 +
    'If you leave it as it is Auto Waste will continue to be generated for it.');
end;

procedure TConfigForm.BitBtn16Click(Sender: TObject);
begin
  if MessageDlg('The changes made so far will be discarded!'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrNo then
    exit;

  ReLoadHOConf;

  bitbtn15.Enabled := False;
  bitbtn16.Enabled := False;
end;

procedure TConfigForm.ReLoadHOConf;
begin
  // fill checkboxes, etc...
  with dmADO.adoqRun do
  begin
    // Get stkHOConf GLOBAL variables
    close;
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    // Default is NO (cbit = 0)
    if locate('cname', 'LCzeroLG', []) then
    begin
      cbLCzeroLG.Checked := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      cbLCzeroLG.Checked := False;
    end;

    // should I set Misc1 to be Sum(pcWaste Adjustment RETAIL VALUE)?
    // Default is NO (cbit = 0)
    if locate('cname', 'pcWAtoMisc', []) then
    begin
      cbPCWAtoMisc.Checked := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'pcWAtoMisc';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      cbPCWAtoMisc.Checked := False;
    end;

    // should I Suppress the Count Sheet Dialog
    // Default is NO (cbit = 0)
    if locate('cname', 'NoCSheetDlg', []) then
    begin
      cbNoCountSheetDlg.Checked := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'NoCSheetDlg';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      cbNoCountSheetDlg.Checked := False;
    end;

    close;
  end;
  getStockType;
end;

procedure TConfigForm.BitBtn15Click(Sender: TObject);
begin
  // save all configs

  // save GLOBAL configs to stkConfHO
  with dmADO.adoqRun do
  begin
    // Get stkHOConf GLOBAL variables
    close;
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    if locate('cname', 'LCzeroLG', []) then
    begin
      edit;
      FieldByName('cbit').asboolean := cbLCzeroLG.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := cbLCzeroLG.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end;

    // should I set Misc1 to be Sum(pcWaste Adjustment RETAIL VALUE)?
    if locate('cname', 'pcWAtoMisc', []) then
    begin
      edit;
      FieldByName('cbit').asboolean := cbPCWAtoMisc.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'pcWAtoMisc';
      FieldByName('cbit').asboolean := cbPCWAtoMisc.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end;

    // should I Suppress the Count Sheet Dialog
    if locate('cname', 'NoCSheetDlg', []) then
    begin
      edit;
      FieldByName('cbit').asboolean := cbNoCountSheetDlg.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'NoCSheetDlg';
      FieldByName('cbit').asboolean := cbNoCountSheetDlg.Checked;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
    end;

    close;
  end;
  setStockType;
  bitbtn15.Enabled := False;
  bitbtn16.Enabled := False;
end;

procedure TConfigForm.cbLCzeroLGClick(Sender: TObject);
begin
  bitbtn15.Enabled := True;
  bitbtn16.Enabled := True;
end;

procedure TConfigForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  saveWhat : string;
  i : shortint;
begin                     //326384
  saveWhat := '';

  if bitbtn1.Enabled then
    saveWhat := 'Automatic Wastage, ';

  if btnSaveChanges.Enabled then
    saveWhat := saveWhat + 'Holding Zones, ';

  if bitbtn13.Enabled then
    saveWhat := saveWhat + 'Min.' + data1.SSbig + ' Levels, ';

  if bitbtn15.Enabled then
    saveWhat := saveWhat + 'Global Settings, ';

  if btnMLCSaveChanges.Enabled then
    saveWhat := saveWhat + 'Mandatory Line Check settings, ';

  if btnSaveTemplateChanges.Enabled then
    saveWhat := saveWhat + '"Must Count" Item Templates, ';

  if saveWhat <> '' then // show the Message Dialog...
  begin
    // reverse the string to make the list from "A, B, C, " into "A, B and C"
    saveWhat := ReverseString(saveWhat);

    // kill last comma and space from the string
    saveWhat := copy(saveWhat, 3, length(saveWhat));

    // if at least one comma is left replace it with "and"
    i := pos(' ,', saveWhat);
    if i > 0 then
    begin
      saveWhat := copy(saveWhat, 1, i - 1) + ' dna ' + copy(saveWhat, i + 2, length(saveWhat));
    end;

    // finally undo the reverse and ask the question
    saveWhat := ReverseString(saveWhat);

    case MessageDlg('Changes to ' + saveWhat + ' have not been saved!'+#13+''+#13+
      'Do you wish to save your changes before closing the Configuration window?'
      , mtWarning, [mbYes,mbNo, mbCancel], 0) of
      mrCancel : begin
                   canClose := False;
                   exit;
                 end;
      mrYes    : begin
                   if bitbtn1.Enabled then
                     bitbtn1Click(nil);

                   if btnSaveChanges.Enabled then
                     SaveChangesToHZs;

                   if bitbtn13.Enabled then
                     bitbtn13Click(nil);

                   if bitbtn15.Enabled then
                     bitbtn15Click(nil);

                   if btnMLCSaveChanges.Enabled then
                     CanClose := SaveChangesToMandatoryLineCheckSettings;

                   if btnSaveTemplateChanges.Enabled then
                     CanClose := SaveTemplateChanges;

                 end;
    end; // case..
  end;
end;

procedure TConfigForm.CheckHoldingZoneSettings;
begin
  // say if this is valid...
  if Data1.CheckHZsValid(True) then
  begin
    adotHZs.Requery;
    lblHoldingZoneStatus.Caption := 'VALID';
    lblHoldingZoneStatus.Color := clBlue;
  end
  else
  begin
    lblHoldingZoneStatus.Caption := 'INVALID';
    lblHoldingZoneStatus.Color := clRed;
  end;
end;

procedure TConfigForm.SaveChangesToHZs;
begin
  if data1.CheckHZsValid(True) then
  begin
    if adotHZs.Active then
      adotHZs.Requery;
    lblHoldingZoneStatus.Caption := 'VALID';
    lblHoldingZoneStatus.Color := clBlue;
  end
  else
  begin
    lblHoldingZoneStatus.Caption := 'INVALID';
    lblHoldingZoneStatus.Color := clRed;
    if MessageDlg('The current settings are INVALID.'+#13+#10+''+#13+#10+
      'Click "OK" if you want to go ahead and save. You should set '+#13+#10+
      'things up correctly later if you intend to use Holding Zones.',
      mtWarning, [mbOK,mbCancel], 0) = mrCancel then
    exit;
  end;

  // save ALL changes (in transaction...)
  // begin the transaction in SQL Server...

  if dmADO.AztecConn.InTransaction then
  begin
    log.event('Error in Save HZ settings (before BeginTrans): Already in Transaction');
    showMessage('Error trying to save the '+ data1.SSbig +' Holding Zones settings!' + #13 + #13 +
      'Cannot begin transaction' + #13 + #13 +
      'The previous settings are still in force.');

    exit;
  end;

  dmADO.AztecConn.BeginTrans;

  try
    with adoqRun do
    begin
      // insert items where hz was made now
      errstr := 'Insert new items';
      close;
      sql.Clear;
      sql.Add('insert into [stkHZs] ([SiteCode], [hzID], [hzName], [ePur], [eOut], ');
      sql.Add('       [eMoveIn], [eMoveOut], [eSales], [eWaste], [Active], [LMDT])');
      sql.Add('select a.[SiteCode], a.[hzID], a.[hzName], a.[ePur], a.[eOut],');
      sql.Add(' a.[eMoveIn], a.[eMoveOut], a.[eSales], a.[eWaste], a.[Active], GetDate()');
      sql.Add('from stkhzstmp a');
      sql.Add('where a.[hzid] not in (select hzid from stkhzs)');
      ExecSQL;

      // update hs that were changed
      errstr := 'Update edited items';
      close;
      sql.Clear;
      sql.Add('update [stkHZs] set [hzName] = sq.[hzName], [ePur] = sq.[ePur],');
      sql.Add('[eSales] = sq.[eSales], [eWaste] = sq.[eWaste], [Active] = sq.[Active],');
      sql.Add('[LMDT] = GetDate()');
      sql.Add('from (select a.[hzID], a.[hzName], a.[ePur], a.[eSales], a.[eWaste], a.[Active]');
      sql.Add('      from stkhzstmp a, stkHZs b');
      sql.Add('      where a.[hzid] = b.[hzid]');
      sql.Add('      and not (a.[hzName] = b.[hzName] AND a.[ePur] = b.[ePur] AND ');
      sql.Add('       a.[eSales] = b.[eSales] AND a.[eWaste] = b.[eWaste] AND a.[Active] = b.[Active] )) sq');
      sql.Add('where [stkHZs].[hzID] = sq.[hzID]');
      execSQL;

      // delete from stkhzpos all items
      errstr := 'Delete hzpos';
      close;
      sql.Clear;
      sql.Add('Delete [stkhzpos]');
      execSQL;

      SQL.Clear;
      SQL.Add('INSERT stkhzpos (SiteCode, hzID, TerminalID, LMDT)');
      SQL.Add('SELECT SiteCode, hzID, TerminalID, GetDate()');
      SQL.Add('FROM stkhzpostmp');
      ExecSQL;
    end;
  except
    on E:exception do
    begin
      // Error in transaction, attempt to rollback
      if dmADO.AztecConn.InTransaction then
      begin
        dmADO.RollbackTransaction;

        showMessage('Transaction Error trying to save '+ data1.SSbig +' Holding Zones settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'The previous settings are still in force.');

        log.event('Error save HZ - Trans. Rolled Back (' + errstr + '): ' + E.Message);
      end
      else
      begin
        showMessage('Transaction Error trying to save '+ data1.SSbig +' Holding Zones settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'Data Integrity concerning '+ data1.SSbig +' Holding Zones settings may have been compromised!');

        log.event('Error in saveHZ - Trans. NOT Rolled Back (' + errstr + '): ' + E.Message);
      end;

      exit;
    end;
  end;

  // all OK by now, commit...
  dmADO.CommitTransaction;

  // make sure the system "knows" about the change
  data1.siteHasValidHZs := data1.CheckHZsValid(false);

  btnSaveChanges.Enabled := False;
  btnDiscardChanges.Enabled := False;

  SetLocOrHZbuttons;
end;

procedure TConfigForm.UpdateAutoWastage;
begin
  if (curValue <> edtWastageQuantity.Text) and (adotProds.RecNo > 0) then
  begin
    adotProds.Edit;
    adotProds.FieldByName('AWValue').AsFloat :=
      Data1.DozGallStrToFloat(adotProds.FieldByName('AWUnit').AsString, edtWastageQuantity.Text);
    adotProds.Post;

    curValue := edtWastageQuantity.Text;
  end;
end;

procedure TConfigForm.SetUpScreen;
begin
  if (edtWastageQuantity.Text <> '0') and (edtWastageQuantity.Text <> '') then
  begin
    lblProductName.Color := clBlue;
    lblProductName.Font.Color := clWhite;

    lblWastageQuantity.Caption := 'Edit Waste Qty; 0 to Reset';

    lblWastageUnit.Enabled := TRUE;
    cmbbxWastageUnit.Enabled := TRUE;
  end
  else
  begin
    lblProductName.Color := clWhite;
    lblProductName.Font.Color := clBlue;

    lblWastageQuantity.Caption := 'Input > 0 to set Auto Waste';

    lblWastageUnit.Enabled := FALSE;
    cmbbxWastageUnit.Enabled := FALSE;
  end;
end;

procedure TConfigForm.FormShow(Sender: TObject);
begin
   getStockType;
   updateLocation;
   if data1.ssDebug then
     log.Event(debugString);
end;

procedure TConfigForm.cbxStockTypeChange(Sender: TObject);
begin
  BitBtn15.Enabled := True;
  BitBtn16.Enabled := True;
end;

procedure TConfigForm.getStockType;
begin
   if data1.repHdr = '' then
      cbxStockType.ItemIndex := -1
   else
      cbxStockType.ItemIndex := cbxStockType.Items.IndexOf(data1.repHdr);
end;

procedure TConfigForm.setStockType;
begin
   with dmADO.adoqRun do
   begin
     SQL.Clear;
     SQL.Add('UPDATE PConfigs SET Stock_Type = '''+cbxStockType.Text+''' ');
     ExecSQL;
   end;
   data1.initGlobals;
end;

procedure TConfigForm.updateLocation;
begin
   with dmADO.adoqRun do
   begin
     SQL.Clear;
     SQL.Add('EXEC stkSP_UpdateLocationsAll');
     ExecSQL;
   end;
   data1.initGlobals;
end;


//////////////////////////////////////////////////////////////////////////////////////
//
//                  Mandatory Line Check Routines
//
//////////////////////////////////////////////////////////////////////////////////////


procedure TConfigForm.InitialiseMandatoryLineCheckTab;
var
  fWait: Tfwait;
begin
  fwait := Tfwait.Create(self);
  try
    fwait.Show;

    fwait.UpdateBar(11,'Mandatory Line Check: loading data');
    Application.ProcessMessages;

    cmdLoadMandatoryLineCheckData.Execute;

    fwait.UpdateBar(71,'Mandatory Line Check: set drop downs');
    Application.ProcessMessages;
    OriginalNumMandatoryProducts := GetNumMandatoryLineCheckProducts;
    edtNumMandatoryProducts.Value := OriginalNumMandatoryProducts;

    CurrSiteId := -1;
    CurrSiteName := '';
    CurrDivisionId := -1;
    CurrSubcatId := -1;
    AllSitesListCreated := False;
    RecreateExceptionSitesList := True;
    AllSitesList := TStringList.Create;
    ExceptionSitesList := TStringList.Create;

    PopulateMLCChooseSiteCombo(False);

    fwait.UpdateBar(80,'Mandatory Line Check: opening tables ');
    adotMLCSiteSubcat.Open;
    adotMLCProduct.Open;
    adotMLCSubcat.Open;
    adotMLCDivision.Open;

    SetMLCSiteSubcatFilter;
    SetMLCSiteProductFilter;

    pcMandatoryLineCheck.ActivePage := tabMLCDefaultSettings;
    btnMLCSaveChanges.Enabled := False;
    btnMLCDiscardChanges.Enabled := False;

    gridSiteSubcatSettings.Visible := False;
    gridSiteProductSettings.Visible := False;
    lblPleaseChooseASite.Visible := True;
    fwait.UpdateBar(90,'Mandatory Line Check: almost done');

    // If Single Site Master hide all GUI widgets only relevant for site exceptions Bugs 335689 and 335753
    if (isMaster and isSite) then
    begin
      tabMLCSiteSettings.TabVisible := False;
      btnSiteExceptionsReport.Visible := False;
      btnRevertAllSitesToDefault.Visible := False;
      lblSiteExceptionColour.Visible := False;
      lblSiteException.Visible := False;
    end;
  finally
    if fwait <> nil then fwait.free;
  end;
end;


procedure TConfigForm.PostRecord( dataset: TDataSet );
begin
  with dataset do begin
    if (state = dsInsert) or (state = dsEdit) then
      Post;
  end;
end;

procedure TConfigForm.adotMLCSubcatCalcFields(DataSet: TDataSet);
begin
  adotMLCSubcatExcludedProductsText.Value :=
     IntToStr(adotMLCSubcatExcludedProducts.Value) + ' of ' + IntToStr(adotMLCSubcatProductCount.Value);
end;

procedure TConfigForm.adotMLCSiteSubcatCalcFields(DataSet: TDataSet);
begin
  adotMLCSiteSubcatExcludedProductsText.Value :=
     IntToStr(adotMLCSiteSubcatExcludedProducts.Value) + ' of ' + IntToStr(adotMLCSiteSubcatProductCount.Value);
end;


procedure TConfigForm.gridSiteSubcatSettingsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if ((Field.FieldName = 'ExcludeFromMandatoryLineCheck') and
      (adotMLCSiteSubcat.FieldByName('ExcludeFromMandatoryLineCheck').Value <>
                adotMLCSiteSubcat.FieldByName('Estate_ExcludeFromMandatoryLineCheck').Value))
     OR
    ((Field.FieldName = 'TargetYieldPercent') and
      (adotMLCSiteSubcat.FieldByName('TargetYieldPercent').Value <>
                adotMLCSiteSubcat.FieldByName('Estate_TargetYieldPercent').Value))
  then
     ABrush.Color := clSkyBlue
  else if (Field.FieldName = 'ExcludedProductsText') and (adotMLCSiteSubcatExcludedProducts.AsInteger > 0) then
     ABrush.Color := clMoneyGreen;
end;

procedure TConfigForm.gridSiteProductSettingsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.FieldName = 'ExcludeFromMandatoryLineCheck') then
    if Field.ReadOnly then
      ABrush.Color := clInactiveCaption
    else
      if (adotMLCSiteProduct.FieldByName('ExcludeFromMandatoryLineCheck').Value <>
          adotMLCSiteProduct.FieldByName('Estate_ExcludeFromMandatoryLineCheck').Value)
      then
        ABrush.Color := clSkyBlue;
end;

procedure TConfigForm.gridDefaultSubcatSettingsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.FieldName = 'ExcludedProductsText') and (adotMLCSubcatExcludedProducts.AsInteger > 0) then
     ABrush.Color := clMoneyGreen;
end;


procedure TConfigForm.RevertSiteToDefault(SiteId : integer);
begin
  Log.Event('Reverting site ' + IntToStr(SiteId)+ ' to default (-1 means All sites). Currently '+
            IntToStr(GetExceptionSitesList.Count) + ' site(s) have exceptions.');

  SaveSelectedItems;

  PostRecord(adotMLCSubcat);
  PostRecord(adotMLCProduct);
  PostRecord(adotMLCSiteSubcat);
  PostRecord(adotMLCSiteProduct);

  adotMLCSiteSubcat.DisableControls;
  adotMLCSiteProduct.DisableControls;
  adotMLCSiteSubcat.Close;
  adotMLCSiteProduct.Close;

  with ADOCommand do
  begin
    CommandText :=
      'UPDATE #MLCSiteSubcat ' +
      'SET TargetYieldPercent = b.TargetYieldPercent, ' +
      '    ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
      '    Estate_TargetYieldPercent = b.TargetYieldPercent, ' +
      '    Estate_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
      '    Modified = 1 ' +
      'FROM #MLCSiteSubcat a ' +
      '     INNER JOIN #MLCSubcat b ON a.SubCategoryId = b.SubcategoryId ' +
      'WHERE (a.TargetYieldPercent <> a.Estate_TargetYieldPercent OR ' +
      '       a.ExcludeFromMandatoryLineCheck <> a.Estate_ExcludeFromMandatoryLineCheck) ';

    if SiteId <> -1 then
      CommandText := CommandText + ' AND a.SiteId = ' + IntToStr(SiteId) + ' ';

    CommandText := CommandText +
      'UPDATE #MLCSiteProduct ' +
      'SET ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
      '    Estate_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
      '    Modified = 1 ' +
      'FROM #MLCSiteProduct a ' +
      '     INNER JOIN #MLCProduct b ON a.ProductId = b.ProductId ' +
      'WHERE a.ExcludeFromMandatoryLineCheck <> a.Estate_ExcludeFromMandatoryLineCheck ';

    if SiteId <> -1 then
      CommandText := CommandText + ' AND a.SiteId = ' + IntToStr(SiteId) + ' ';

    CommandText := CommandText +
      'UPDATE #MLCSiteSubcat ' +
      'SET ExcludedProducts = b.ExcludedProducts ' +
      'FROM #MLCSiteSubcat a INNER JOIN #MLCSubcat b ON a.SubCategoryId = b.SubcategoryId ';

    if SiteId <> -1 then
      CommandText := CommandText + 'WHERE a.SiteId = ' + IntToStr(SiteId) + ' ';

    Execute;
  end;

  adotMLCSiteProduct.Open;
  adotMLCSiteSubcat.Open;

  RestoreSelectedItems;

  adotMLCSiteSubcat.EnableControls;
  adotMLCSiteProduct.EnableControls;

  MLCSiteSettingsRequireUpdate := false;

  Log.Event('Revert site to default finished');
end;

procedure TConfigForm.btnRevertAllSitesToDefaultClick(Sender: TObject);
var NumSitesWithExceptions: integer;
begin
  if not data1.UserAllowed(-1, 34) then
  begin
    MessageDlg('Your security permissions do not allow you to use this function.', mtInformation, [mbOK], 0);
    Exit;
  end;

  NumSitesWithExceptions := GetExceptionSitesList.Count;

  if NumSitesWithExceptions = 0 then
  begin
    ShowMessage('No sites have exceptions');
    Exit;
  end;

  if MessageDlg( 'This will revert all sites to the default settings. Presently ' +
    IntToStr(NumSitesWithExceptions) + ' site(s) have exceptions.' + #13#10#13#10 + ' Continue?', mtConfirmation,
                 [mbYes, mbNo], 0 ) = mrYes then
  try
    Screen.Cursor := crHourglass;

    RevertSiteToDefault(-1);

    RevertAllSitesToDefault := True;
    RecreateExceptionSitesList := True;
    btnMLCSaveChanges.Enabled := True;
    btnMLCDiscardChanges.Enabled := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TConfigForm.btnRevertThisSiteToDefaultClick(Sender: TObject);
begin
  if not data1.UserAllowed(-1, 34) then
  begin
    MessageDlg('Your security permissions do not allow you to use this function.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if GetExceptionSitesList.IndexOf(CurrSiteName) = -1 then
  begin
    ShowMessage('This site does not have exceptions');
    Exit;
  end;

  if MessageDlg( 'This will revert site "' + CurrSiteName + '" to the default settings. Continue?', mtConfirmation,
                 [mbYes, mbNo], 0 ) = mrYes then
  try
    Screen.Cursor := crHourglass;

    RevertSiteToDefault(CurrSiteId);

    RevertThisSiteToDefault := True;
    RecreateExceptionSitesList := True;
    btnMLCSaveChanges.Enabled := true;
    btnMLCDiscardChanges.Enabled := true;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TConfigForm.btnMLCDiscardChangesClick(Sender: TObject);
var ChangeSummaryText: string;
begin
  ChangeSummaryText := GetChangeSummaryText;

  if MessageDlg('About to Discard Changes!'+#13#10#13#10+'Summary of changes made in this session:'+#13+#10+ChangeSummaryText,
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then
  try
    Screen.Cursor := crHourGlass;

    Log.Event('Discard Mandatory Line Check changes started. Change summary: "' + ChangeSummaryText + '"');

    SaveSelectedItems;

    adotMLCDivision.Close;
    adotMLCSubcat.Close;
    adotMLCProduct.Close;
    adotMLCSiteSubcat.Close;
    adotMLCSiteProduct.Close;

    cmdLoadMandatoryLineCheckData.Execute;

    OriginalNumMandatoryProducts := GetNumMandatoryLineCheckProducts;
    edtNumMandatoryProducts.Value := OriginalNumMandatoryProducts;
    RecreateExceptionSitesList := True;
    RevertAllSitesToDefault := False;
    RevertThisSiteToDefault := False;

    adotMLCSiteProduct.Open;
    adotMLCSiteSubcat.Open;
    adotMLCProduct.Open;
    adotMLCSubcat.Open;
    adotMLCDivision.Open;

    RestoreSelectedItems;

    btnMLCSaveChanges.Enabled := False;
    btnMLCDiscardChanges.Enabled := False;

    Log.Event('Successfully discarded Mandatory Line Check changes.');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TConfigForm.btnMLCSaveChangesClick(Sender: TObject);
begin
  SaveChangesToMandatoryLineCheckSettings;
end;

function TConfigForm.SaveChangesToMandatoryLineCheckSettings: boolean;
var ChangeSummaryText: string;
begin
  Result := False;

  ChangeSummaryText := GetChangeSummaryText;

  if MessageDlg('About to save Mandatory Line Check changes.'+#13#10#13#10+'Summary of changes made in this session:'+#13+#10+ChangeSummaryText,
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then
  try
    Screen.Cursor := crHourglass;
    Log.Event('Save Mandatory Line Check changes started. Change summary: "' + ChangeSummaryText + '"');

    //Must first ensure any changes made to the Default Settings are applied to the Site Settings. This is not
    //required for saving the changes, only for ensuring the Site Settings tab shows the correct values if it
    //is sunsequently selected. Further, it is only necessary to call this routine here because it relies on the Modified
    //fields of the tables that store the default settings which are cleared by this save operation.
    UpdateMLCSiteSettings;

    SaveSelectedItems;

    btnMLCSaveChanges.Enabled := False;
    btnMLCDiscardChanges.Enabled := False;

    adotMLCDivision.Close;
    adotMLCSubcat.Close;
    adotMLCProduct.Close;
    adotMLCSiteSubcat.Close;
    adotMLCSiteProduct.Close;

    dmADO.BeginTransaction;

    with cmdSaveMandatoryLineCheckChanges do
    try try
      Parameters.ParamByName('NumProductsInMandatoryLineCheck_Key').Value := NUM_MANDATORY_LINECHECK_PRODUCTS_CONFIGURATION_KEY;
      Parameters.ParamByName('NumProductsInMandatoryLineCheck_Value').Value := edtNumMandatoryProducts.Value;
      Execute;

      dmADO.CommitTransaction;

      OriginalNumMandatoryProducts := GetNumMandatoryLineCheckProducts;
      RevertAllSitesToDefault := False;
      RevertThisSiteToDefault := False;

      Log.Event('Successfully saved Mandatory Line Check changes.');
      Result := True;
    except
      on E:exception do
      begin
        Log.Event('Error saving Mandatory Line Check changes: ' + E.ClassName + ' ' + E.Message);
        dmADO.RollbackTransaction;    // if an error occurs make sure that nothing is saved

        ShowMessage('Failed to save changes due to an unexpected error.'#13#10#13#10 +
                    'Error message: ' + E.ClassName + ' ' + E.Message);

        btnMLCSaveChanges.Enabled := True;
        btnMLCDiscardChanges.Enabled := True;
      end;
    end;
    finally
      if dmADO.InTransaction then dmADO.RollbackTransaction;
    end;

    adotMLCSiteProduct.Open;
    adotMLCSiteSubcat.Open;
    adotMLCProduct.Open;
    adotMLCSubcat.Open;
    adotMLCDivision.Open;

    RestoreSelectedItems;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TConfigForm.MLCAfterEdit(DataSet: TDataSet);
begin
  btnMLCSaveChanges.Enabled := true;
  btnMLCDiscardChanges.Enabled := true;

  Dataset.FieldByName('Modified').AsBoolean := true;

  if (Dataset = adotMLCSubcat) or (Dataset = adotMLCProduct) then
     MLCSiteSettingsRequireUpdate := True;

  //A change to the default or site exception settings can result in the number of sites that
  //have exceptions to change.
  RecreateExceptionSitesList := True;
end;

procedure TConfigForm.SaveSelectedItems;
begin
  SavedDivisionId := adotMLCDivisionDivisionId.Value;
  SavedProductId := adotMLCProductProductId.Value;
  SavedSubcategoryId := adotMLCSubcatSubCategoryId.Value;
  SavedSiteProductId := adotMLCSiteProductProductId.Value;
  SavedSiteSubcategoryId := adotMLCSiteSubcatSubCategoryId.Value;
end;

procedure TConfigForm.RestoreSelectedItems;
begin
  if adotMLCDivisionDivisionId.Value <> SavedDivisionId then
    adotMLCDivision.Locate('DivisionId', SavedDivisionId, []);

  if adotMLCSubcatSubcategoryId.Value <> SavedSubcategoryId then
    adotMLCSubcat.Locate('SubcategoryId', SavedSubcategoryId, []);

  if adotMLCProductProductId.Value <> SavedProductId then
    adotMLCProduct.Locate('ProductId', SavedProductId, []);

  if adotMLCSiteSubcatSubcategoryId.Value <> SavedSiteSubcategoryId then
    adotMLCSiteSubcat.Locate('SiteId;SubcategoryId', VarArrayOf([CurrSiteId, SavedSiteSubcategoryId]), []);

  if adotMLCSiteProductProductId.Value <> SavedSiteProductId then
    adotMLCSiteProduct.Locate('SiteId;ProductId', VarArrayOf([CurrSiteId, SavedSiteProductId]), []);
end;

procedure TConfigForm.UpdateMLCSiteSettings;
begin
  if MLCSiteSettingsRequireUpdate then
  try
    Screen.Cursor := crHourglass;

    SaveSelectedItems;

    PostRecord(adotMLCSubcat);
    PostRecord(adotMLCProduct);
    PostRecord(adotMLCSiteSubcat);
    PostRecord(adotMLCSiteProduct);

    adotMLCSiteSubcat.DisableControls;
    adotMLCSiteProduct.DisableControls;
    adotMLCSiteSubcat.Close;
    adotMLCSiteProduct.Close;

    with ADOCommand do
    begin
      Commandtext :=
        'UPDATE #MLCSiteSubcat ' +
        'SET TargetYieldPercent = b.TargetYieldPercent, ' +
        '    Original_TargetYieldPercent = b.TargetYieldPercent ' +
        'FROM #MLCSiteSubcat a ' +
        '     INNER JOIN #MLCSubcat b ON a.SubCategoryId = b.SubcategoryId ' +
        'WHERE b.Modified = 1 AND a.TargetYieldPercent = a.Estate_TargetYieldPercent ' +

        'UPDATE #MLCSiteSubcat ' +
        'SET ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
        '    Original_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck ' +
        'FROM #MLCSiteSubcat a ' +
        '     INNER JOIN #MLCSubcat b ON a.SubCategoryId = b.SubcategoryId ' +
        'WHERE b.Modified = 1 AND a.ExcludeFromMandatoryLineCheck = a.Estate_ExcludeFromMandatoryLineCheck ' +

        'UPDATE #MLCSiteSubcat ' +
        'SET Estate_TargetYieldPercent = b.TargetYieldPercent, ' +
        '    Estate_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck ' +
        'FROM #MLCSiteSubcat a ' +
        '     INNER JOIN #MLCSubcat b ON a.SubCategoryId = b.SubcategoryId ' +
        'WHERE b.Modified = 1 ' +

        'UPDATE #MLCSiteProduct ' +
        'SET ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck, ' +
        '    Original_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck ' +
        'FROM #MLCSiteProduct a ' +
        '     INNER JOIN #MLCProduct b ON a.ProductId = b.ProductId ' +
        'WHERE b.Modified = 1 AND a.ExcludeFromMandatoryLineCheck = a.Estate_ExcludeFromMandatoryLineCheck ' +

        'UPDATE #MLCSiteProduct ' +
        'SET Estate_ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck ' +
        'FROM #MLCSiteProduct a ' +
        '     INNER JOIN #MLCProduct b ON a.ProductId = b.ProductId ' +
        'WHERE b.Modified = 1 ' +

        //The number of excluded products for each site may now be different so must update this figure in #MLCSiteSubcat
        'IF @@RowCount > 0 ' +
        'BEGIN ' +
        '  UPDATE #MLCSiteSubcat ' +
        '  SET ExcludedProducts = b.ExcludedProducts ' +
        '  FROM #MLCSiteSubcat a ' +
        '       INNER JOIN ' +
        '       (SELECT SiteId, SubcategoryId, SUM(CONVERT(int, ExcludeFromMandatoryLineCheck)) AS ExcludedProducts ' +
        '        FROM #MLCSiteProduct ' +
        '        GROUP BY SiteId, SubcategoryId) b ON a.SiteID = b.SiteId AND a.SubcategoryId = b.SubcategoryId ' +
        'END ';

      Execute;
    end;

    adotMLCSiteProduct.Open;
    adotMLCSiteSubcat.Open;

    RestoreSelectedItems;

    adotMLCSiteSubcat.EnableControls;
    adotMLCSiteProduct.EnableControls;

    MLCSiteSettingsRequireUpdate := false;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TConfigForm.pcMandatoryLineCheckChange(Sender: TObject);
begin
  if (pcMandatoryLineCheck.ActivePage = tabMLCSiteSettings)then
  begin
    // Update the data displayed on the Site Settings tab with any changes made on the Default Settings tab.
    UpdateMLCSiteSettings;
  end;
end;

procedure TConfigForm.SetMLCSiteSubcatFilter;
begin
  adotMLCSiteSubcat.Filtered := False;
  adotMLCSiteSubcat.Filter := 'SiteId=' + IntToStr(CurrSiteId) + ' and DivisionId=' + IntToStr(CurrDivisionId);
  adotMLCSiteSubcat.Filtered := True;
  if adotMLCSiteSubcat.isempty then
    gridSiteSubcatSettings.ReadOnly := True
  else
    gridSiteSubcatSettings.ReadOnly := False;
end;

procedure TConfigForm.SetMLCSiteProductFilter;
begin
  adotMLCSiteProduct.Close;
  adotMLCSiteProduct.CommandText := format('SELECT * FROM #MLCSiteProduct ' +
                                        'WHERE SiteID = %s AND SubcategoryID = %s ' +
                                        'ORDER BY SiteId, PurchaseName ',[IntToStr(CurrSiteID), IntToStr(CurrSubcatId)]);
  adotMLCSiteProduct.Open;

  if adotMLCSiteProduct.isempty then
    gridSiteProductSettings.ReadOnly := True
  else
    gridSiteProductSettings.ReadOnly := False;
end;


procedure TConfigForm.adotMLCDivisionAfterScroll(DataSet: TDataSet);
begin
  CurrDivisionId := adotMLCDivisionDivisionId.Value;
  SetMLCSiteSubcatFilter;
end;


procedure TConfigForm.adotMLCSiteSubcatAfterScroll(DataSet: TDataSet);
begin
  CurrSubcatId := adotMLCSiteSubcatSubCategoryId.Value;
  SetMLCSiteProductFilter;

  EnableProductExcludeColumn(gridSiteProductSettings, not(adotMLCSiteSubcatExcludeFromMandatoryLineCheck.Value));
end;

procedure TConfigForm.cmbbxMLCChooseSiteChange(Sender: TObject);
begin
  SaveSelectedItems;

  adotMLCSiteSubcat.DisableControls;
  adotMLCSiteProduct.DisableControls;

  if cmbbxMLCChooseSite.ItemIndex = -1 then
  begin
    CurrSiteId := -1;
    CurrSiteName := '';
    tabMLCSiteSettings.Caption := 'Site Exceptions';
  end
  else
  begin
    CurrSiteId := Integer(cmbbxMLCChooseSite.Items.Objects[cmbbxMLCChooseSite.ItemIndex]);
    CurrSiteName := cmbbxMLCChooseSite.Items[cmbbxMLCChooseSite.ItemIndex];
    tabMLCSiteSettings.Caption := 'Site Exceptions (' + CurrSiteName + ')';
  end;

  SetMLCSiteSubcatFilter;

  RestoreSelectedItems;

  adotMLCSiteSubcat.EnableControls;
  adotMLCSiteProduct.EnableControls;

  btnRevertThisSiteToDefault.Enabled := True;
  gridSiteSubcatSettings.Visible := True;
  gridSiteProductSettings.Visible := True;
  lblPleaseChooseASite.Visible := False;
end;

procedure TConfigForm.edtNumMandatoryProductsChange(Sender: TObject);
begin
  if (edtNumMandatoryProducts.Text <> '') and
     (edtNumMandatoryProducts.Text[1] <> '0') and
     (edtNumMandatoryProducts.Value <> OriginalNumMandatoryProducts) then
  begin
    btnMLCSaveChanges.Enabled := true;
    btnMLCDiscardChanges.Enabled := true;
  end;
end;

procedure TConfigForm.edtNumMandatoryProductsKeyPress(Sender: TObject;
  var Key: Char);
begin
  //Disallow the '.' and '-' characters from being entered.
  if (Ord(Key) = Ord('.')) or (Ord(Key) = Ord('-')) or (Ord(Key) = Ord('+')) then
    Abort;
end;

procedure TConfigForm.TargetYieldPercentValidate(Sender: TField);
begin
  if (Sender.AsInteger < 0) OR (Sender.AsInteger > 150) then
  begin
    ShowMessage('Target Yield% must be in the range 0..150%');
    Abort;
  end;
end;

function TConfigForm.GetChangeSummaryText: string;
begin
  Result := '';

  //Ensure all changes are recorded in the temp database tables.
  PostRecord(adotMLCDivision);
  PostRecord(adotMLCSubcat);
  PostRecord(adotMLCProduct);
  PostRecord(adotMLCSiteSubcat);
  PostRecord(adotMLCSiteProduct);

  if OriginalNumMandatoryProducts <> edtNumMandatoryProducts.Value then
    Result := Result + '  Number of mandatory products to Line Check changed' + #13#10;

  if RevertAllSitesToDefault then
    Result := Result + '  "Revert All Sites To Default" used' + #13#10;

  if RevertThisSiteToDefault then
    Result := Result + '  "Revert This Site To Default" used on at least one site' + #13#10;

  with adoqRun do
  begin
    SQL.Text :=
      'SELECT COUNT(*) AS Count FROM #MLCDivision ' +
      'WHERE IncludeInMandatoryLineCheck <> Original_IncludeInMandatoryLineCheck';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Division(s) changed status' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count FROM #MLCSubcat ' +
      'WHERE Modified = 1 AND TargetYieldPercent <> Original_TargetYieldPercent';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Default target yield %(s) changed' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count ' +
      'FROM #MLCSubcat ' +
      'WHERE Modified = 1 AND ExcludeFromMandatoryLineCheck <> Original_ExcludeFromMandatoryLineCheck ';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Default sub category exclusion(s) changed' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count ' +
      'FROM #MLCProduct ' +
      'WHERE Modified = 1 AND ExcludeFromMandatoryLineCheck <> Original_ExcludeFromMandatoryLineCheck ';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Default product exclusion(s) changed' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count ' +
      'FROM (SELECT DISTINCT(SiteId) FROM #MLCSiteSubcat ' +
      '      WHERE Modified = 1 AND TargetYieldPercent <> Original_TargetYieldPercent) a ';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Site(s) had changes to target yield %' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count ' +
      'FROM (SELECT DISTINCT(SiteId) FROM #MLCSiteSubcat ' +
      '      WHERE Modified = 1 AND ExcludeFromMandatoryLineCheck <> Original_ExcludeFromMandatoryLineCheck) a ';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Site(s) had changes to sub category exclusions' + #13#10;
    Close;

    SQL.Text :=
      'SELECT COUNT(*) AS Count ' +
      'FROM (SELECT DISTINCT(SiteId) FROM #MLCSiteProduct ' +
      '      WHERE Modified = 1 AND ExcludeFromMandatoryLineCheck <> Original_ExcludeFromMandatoryLineCheck) a ';
    Open;
    if FieldbyName('Count').AsInteger > 0 then
       Result := Result + '  ' + FieldbyName('Count').AsString + ' Site(s) had changes to product exclusions' + #13#10;
    Close;

  end;
end;

function TConfigForm.GetNumMandatoryLineCheckProducts: integer;
begin
  with ADOqRun do
  try
    Close;
    SQL.Text := Format('sp_GetConfiguration %d, ''%s''', [0, NUM_MANDATORY_LINECHECK_PRODUCTS_CONFIGURATION_KEY]);
    Open;
    if FieldByName('Setting').IsNull then
      Result := DEFAULT_NUM_MANDATORY_LINECHECK_PRODUCTS
    else
      Result := FieldByName('Setting').AsInteger;
  finally
    Close;
  end;
end;


function TConfigForm.GetAllSitesList: TStrings;
begin
  if not AllSitesListCreated then
  begin
    AllSitesList.Clear;

    with adoqRun do
    try
      Close;
      SQL.Text := 'SELECT SiteId, Name FROM #MLCSite ORDER BY Name';
      Open;

      while not EOF do
      begin
        AllSitesList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('SiteId').AsInteger)));
        Next;
      end;
    finally
      Close;
    end;

    AllSitesListCreated := True;
  end;

  Result := AllSitesList;
end;

function TConfigForm.GetExceptionSitesList: TStrings;
begin
  if RecreateExceptionSitesList then
  try
    Screen.Cursor := crHourGlass;
    ExceptionSitesList.Clear;

    //Ensure any unposted changes to the tables we are about to query are posted now.
    PostRecord(adotMLCSiteSubcat);
    PostRecord(adotMLCSiteProduct);

    //Update #MLCSite.HasExceptions with latest changes made to site exceptions.
    with ADOCommand do
    begin
      CommandText :=
        'UPDATE #MLCSite SET HasExceptions = 0 ' +

        'UPDATE #MLCSite ' +
        'SET HasExceptions = 1 ' +
        'WHERE SiteId IN ' +
        '   (SELECT DISTINCT SiteId ' +
        '    FROM ' +
        '      (SELECT DISTINCT SiteId ' +
        '       FROM #MLCSiteSubcat ' +
        '       WHERE (TargetYieldPercent <> Estate_TargetYieldPercent) ' +
        '          OR (ExcludeFromMandatoryLineCheck <> Estate_ExcludeFromMandatoryLineCheck) ' +
        '       UNION ALL ' +
        '       SELECT DISTINCT SiteId ' +
        '       FROM #MLCSiteProduct ' +
        '       WHERE ExcludeFromMandatoryLineCheck <> Estate_ExcludeFromMandatoryLineCheck) a)';
      Execute;
    end;

    with adoqRun do
    try
      Close;
      SQL.Text := 'SELECT SiteId, Name FROM #MLCSite WHERE HasExceptions = 1 ORDER BY Name';
      Open;

      while not EOF do
      begin
        ExceptionSitesList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('SiteId').AsInteger)));
        Next;
      end;
    finally
      Close;
    end;

    RecreateExceptionSitesList := False;

    Log.event(IntToStr(ExceptionSitesList.Count) + ' sites have exceptions');
  finally
    Screen.Cursor := crDefault;
  end;

  Result := ExceptionSitesList;
end;


procedure TConfigForm.PopulateMLCChooseSiteCombo(OnlySitesWithExceptions: boolean);
begin
  if OnlySitesWithExceptions then
    cmbbxMLCChooseSite.Items.Assign(GetExceptionSitesList)
  else
    cmbbxMLCChooseSite.Items.Assign(GetAllSitesList);

  if CurrSiteName <> '' then
    cmbbxMLCChooseSite.ItemIndex := cmbbxMLCChooseSite.Items.IndexOf(CurrSiteName)
  else
    cmbbxMLCChooseSite.ItemIndex := -1;
end;

procedure TConfigForm.chkbxOnlyListSitesWithExceptionsClick(Sender: TObject);
begin
  PopulateMLCChooseSiteCombo(chkbxOnlyListSitesWithExceptions.Checked);
end;

procedure TConfigForm.FormDestroy(Sender: TObject);
begin
  AllSitesList.Free;
  ExceptionSitesList.Free;
end;

procedure TConfigForm.cmbbxMLCChooseSiteEnter(Sender: TObject);
begin
  if chkbxOnlyListSitesWithExceptions.Checked then
    cmbbxMLCChooseSite.Items.Assign(GetExceptionSitesList)
end;

procedure TConfigForm.adotMLCSiteProductExcludeFromMandatoryLineCheckChange(Sender: TField);
begin
  adotMLCSiteSubcat.Edit;

  if adotMLCSiteProductExcludeFromMandatoryLineCheck.Value then
    adotMLCSiteSubcatExcludedProducts.Value := adotMLCSiteSubcatExcludedProducts.Value + 1
  else
    adotMLCSiteSubcatExcludedProducts.Value := adotMLCSiteSubcatExcludedProducts.Value - 1;

  // force post of both SiteProduct and SiteSubcat temp tables to ensure states are in sync after above change
  adotMLCSiteSubcat.Post;
  adotMLCSiteProduct.Post;
end;

procedure TConfigForm.adotMLCProductExcludeFromMandatoryLineCheckChange(Sender: TField);
begin
  adotMLCSubcat.Edit;

  if adotMLCProductExcludeFromMandatoryLineCheck.Value then
    adotMLCSubcatExcludedProducts.Value := adotMLCSubcatExcludedProducts.Value + 1
  else
    adotMLCSubcatExcludedProducts.Value := adotMLCSubcatExcludedProducts.Value - 1;

  adotMLCSubcat.Post;
end;

procedure TConfigForm.EnableProductExcludeColumn(ProductGrid: TwwDBGrid; enable: boolean);
begin
  with ProductGrid do
  begin
    Selected.Delete(1);
    if enable then
      Selected.Add('ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9'F'#9)
    else
      Selected.Add('ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9'T'#9);
    ApplySelected;
  end;
end;

procedure TConfigForm.adotMLCSubcatExcludeFromMandatoryLineCheckChange(Sender: TField);
begin
  EnableProductExcludeColumn(gridDefaultProductSettings, not(Sender.AsBoolean));
end;

procedure TConfigForm.adotMLCSiteSubcatExcludeFromMandatoryLineCheckChange(Sender: TField);
begin
  EnableProductExcludeColumn(gridSiteProductSettings, not(Sender.AsBoolean));
end;

procedure TConfigForm.adotMLCSubcatAfterScroll(DataSet: TDataSet);
begin
  EnableProductExcludeColumn(gridDefaultProductSettings, not(adotMLCSubcatExcludeFromMandatoryLineCheck.Value));
end;


procedure TConfigForm.btnSiteExceptionsReportClick(Sender: TObject);
begin
  if btnMLCSaveChanges.Enabled and
     (MessageDlg('You have made changes which have not been saved.' + #13#10 +
                'The report will only show saved settings.' + #13#10#13#10 +
                'Do you still want to view the report now?', mtWarning, [mbYes,mbNo], 0) = mrNo) then
    Exit;

  RunModule(ReportsModule, '"username=zbs;password=sh1lton" "folder=Stocks" "report=Site Exceptions to Mandatory Line Check Settings" "print=N"');
end;


//////////////////////////////////////////////////////////////////
//
//  Locations code
//
procedure TConfigForm.InitLocationsTab;
begin
  siteIDstr := intToStr(data1.TheSiteCode);

//  with gridLocationList, gridLocationList.DataSource.DataSet do
//  begin
//    DisableControls;
//    Selected.Clear;
//
//    Selected.Add('RecID'#9'4'#9'Row'#9'F');
//    Selected.Add('PurchaseName'#9'30'#9'Product Name'#9'F');
//    Selected.Add('Unit'#9'10'#9'Unit'#9'F');
//    Selected.Add('Scat'#9'20'#9'Sub-Category'#9'F');
//    Selected.Add('Descr'#9'30'#9'Description'#9'F');
//    
//    ApplySelected;
//    EnableControls;
//  end;


  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct div, divix from stkEntity');
    open;
    first;

    lookDivLoc.Items.Clear;
    while not eof do
    begin
      lookDivLoc.Items.Add(FieldByName('div').asstring + #9 + FieldByName('divix').asstring);
      next;
    end;

    lookDivLoc.ApplyList;

    close;

    lookDivLoc.ItemIndex := 0;
    curDivision := lookDivLoc.Text;
    curDivIDstr := lookDivLoc.Value;
  end;

end;

procedure TConfigForm.btnAddLocationClick(Sender: TObject);
var
  nextLocationID, maxNoOfLocations : integer;
begin

  maxNoOfLocations := GetMaxStockLocationCount();

  with dmado.adoqRun do
  try
    close;      // how many active locations we have?
    sql.Clear;
    sql.Add('select * from stkLocations where Deleted = 0');
    open;

    if recordcount >= maxNoOfLocations then
    begin
      close;
      showmessage(Format('The maximum number of Active Locations (%d) has been reached.' + #13 +
        'A new Location can be added only after one or more Active Locations are deleted.', [maxNoOfLocations]));
      exit;
    end;

    fAddEditLocation := TfAddEditLocation.Create(self);
    try
      fAddEditLocation.editLocName.Text := '';
      fAddEditLocation.memoPrintNote.Text := '';
      fAddEditLocation.Caption := 'Add a new Location';

      fAddEditLocation.locationNames.Clear;

      // get the current names and load the StringList for checking...
      close;
      sql.Clear;
      sql.Add('select * from stkLocations where Deleted = 0');
      open;

      while not eof do
      begin
        fAddEditLocation.locationNames.Add(FieldByName('LocationName').asstring);
        next;
      end;

      close;

      if fAddEditLocation.ShowModal = mrOK then  // save
      begin
        close;
        sql.Clear;
        sql.Add('select max(LocationID) as maxID from stkLocations ');
        open;

        nextLocationID := fieldByName('maxID').asinteger + 1;

        close;
        sql.Clear;
        sql.Add('insert stkLocations ([SiteCode], [LocationID], ');
        sql.Add('       [LocationName], [Active], [Deleted], [LMDT], [PrintNote], HasFixedQty) ');
        sql.Add('VALUES ( ' + siteIDstr + ', '+ inttoStr(nextLocationID) + ', ' );
        sql.Add('   ' + quotedStr(fAddEditLocation.editLocName.Text) + ', 1, 0, ');
        sql.Add('   ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)) + ', ');
        sql.Add('   ' + quotedStr(fAddEditLocation.memoPrintNote.Text) + ',');
        if fAddEditLocation.cbHasFixedStock.Checked then
          sql.Add('   1)')
        else
          sql.Add('   0)');
        execSQL;

        RequeryLocations;
        adoqLocations.Locate('LocationID', nextLocationID, []);

        data1.siteHasValidLocations := data1.CheckLocationsValid;
        SetLocOrHZbuttons;
      end;

    finally
      fAddEditLocation.Free;
    end;
  finally
    Close;  // close dmado.adoqRun
  end;
end;

procedure TConfigForm.btnEditLocationClick(Sender: TObject);
var
  curLocationID, curRecNo : integer;
begin
  fAddEditLocation := TfAddEditLocation.Create(self);
  try
    fAddEditLocation.editLocName.Text := adoqLocations.fieldByName('LocationName').asstring;
    fAddEditLocation.memoPrintNote.Text := adoqLocations.fieldByName('PrintNote').asstring;
    fAddEditLocation.Caption := 'Edit Location "' +
                                    adoqLocations.fieldByName('LocationName').asstring + '"';
    fAddEditLocation.cbHasFixedStock.Checked := adoqLocations.fieldByName('HasFixedQty').asBoolean;
    curLocationID := adoqLocations.fieldByName('LocationID').asinteger;
    curRecNo := adoqLocations.RecNo;

    fAddEditLocation.locationNames.Clear;

    with dmado.adoqRun do
    try
      // get the current names and load the StringList for checking...
      close;
      sql.Clear;
      sql.Add('select * from stkLocations where Deleted = 0 and locationid <> ' + inttostr(curLocationID));
      open;

      while not eof do
      begin
        fAddEditLocation.locationNames.Add(FieldByName('LocationName').asstring);
        next;
      end;

      close;

      if fAddEditLocation.ShowModal = mrOK then  // save
      begin
        close;
        sql.Clear;
        SQL.Add('UPDATE [stkLocations] SET LocationName = ' + quotedStr(fAddEditLocation.editLocName.Text));
        SQL.Add('   , PrintNote = ' + quotedStr(fAddEditLocation.memoPrintNote.Text));
        SQL.Add('   , LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
        if fAddEditLocation.cbHasFixedStock.Checked then
          sql.Add(' , HasFixedQty = 1')
        else
          sql.Add(' , HasFixedQty = 0');
        SQL.Add('WHERE SiteCode = ' + siteIDstr);
        SQL.Add('AND LocationID = ' + intToStr(curLocationID));
        ExecSQL;

        RequeryLocations;
        adoqLocations.RecNo := curRecNo;
      end;

    finally
      Close;  // close dmado.adoqRun
    end;
  finally
    fAddEditLocation.Free;
  end;
end;

procedure TConfigForm.btnDeleteLocationClick(Sender: TObject);
var
  linesThisDiv, linesOtherDivs, otherDivs : integer;
  s1 : string;
  maxNoOfLocations: Integer;
begin
  if adoqLocations.fieldByName('Deleted').asBoolean = FALSE then    // Delete
  begin
    with dmado.adoqRun do
    try
      Close;
      sql.Clear;
      SQL.Add('Select ll.[RecID]');
      SQL.Add('FROM [stkLocationLists] ll');
      SQL.Add('WHERE ll.Deleted = 0 AND ll.SiteCode = ' + siteIDstr);
      SQL.Add('AND ll.LocationID = ' + adoqLocations.fieldByName('LocationID').asstring );
      SQL.Add('AND ll.DivisionID = ' + curDivIDstr );
      open;

      linesThisDiv := recordcount;

      Close;
      sql.Clear;
      SQL.Add('Select count(*) tc, count(distinct DivisionID) tcd');
      SQL.Add('FROM [stkLocationLists] ll');
      SQL.Add('WHERE ll.Deleted = 0 AND ll.SiteCode = ' + siteIDstr);
      SQL.Add('AND ll.LocationID = ' + adoqLocations.fieldByName('LocationID').asstring );
      SQL.Add('AND ll.DivisionID <> ' + curDivIDstr );
      open;

      linesOtherDivs := fieldByName('tc').asinteger;
      otherDivs := fieldByName('tcd').asinteger;



      if (linesThisDiv + linesOtherDivs) > 0 then
      begin
        if linesThisDiv = 0 then
          s1 := 'but '
        else
          s1 := 'and ';

        s1 := s1 + inttostr(linesOtherDivs) +
           ' lines in ' + inttostr(otherDivs) + ' other Division';

        if otherDivs = 1 then
          s1 := s1 + ')'
        else
          s1 := s1 + 's)';

        showmessage('There are ' + inttostr(linesThisDiv + linesOtherDivs) + ' Count lines in this Location List.' + #13 +
           '(' + inttostr(linesThisDiv) + ' lines in this Division ' + s1 + #13 + #13 +
           'Locations cannot be Deleted if they contain any Count lines.');
        close;
        exit;
      end;


      if MessageDlg('Are you sure you want to Delete Location "' +
        adoqLocations.fieldByName('LocationName').asstring + '"?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        // ensure Name is unique among Deleted locations, if not then ask user to choose another...
        s1 := adoqLocations.fieldByName('LocationName').asstring;

        Close;
        sql.Clear;
        sql.Add('select * from stkLocations');
        SQL.Add('WHERE SiteCode = ' + siteIDstr);
        SQL.Add('AND LocationName = ' + quotedStr(s1));
        sql.Add('AND Deleted = 1 ');
        open;

        while recordcount > 0 do
        begin
          if not inputquery('Type a unique Location Name (1-25 char.)',
          'Deleted Location Names have to be unique.' +
            #13 + '(Click "Cancel" to abandon Delete)', s1) then
          begin
            exit;
          end;

          Close;
          sql.Clear;
          sql.Add('select * from stkLocations');
          SQL.Add('WHERE SiteCode = ' + siteIDstr);
          SQL.Add('AND LocationName = ' + quotedStr(s1));
          sql.Add('AND Deleted = 1 ');
          open;
        end;

        close;
        sql.Clear;
        SQL.Add('UPDATE [stkLocations] SET Deleted = 1');
        SQL.Add('   , LocationName = ' + quotedStr(s1));
        SQL.Add('   , LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
        SQL.Add('WHERE SiteCode = ' + siteIDstr);
        SQL.Add('AND LocationID = ' + adoqLocations.fieldByName('LocationID').asstring);
        ExecSQL;

        RequeryLocations;
        data1.siteHasValidLocations := data1.CheckLocationsValid;
        SetLocOrHZbuttons;
      end;

    finally
      Close;  // close dmado.adoqRun
    end;

  end
  else          // ---------------------------------------------- UN-Delete
  begin
    maxNoOfLocations := GetMaxStockLocationCount();

    with dmado.adoqRun do
    try
      close;      // how many active locations we have? Max is 20...
      sql.Clear;
      sql.Add('select * from stkLocations where Deleted = 0');
      open;

      if recordcount >= maxNoOfLocations then
      begin
        close;
        showmessage(Format('The maximum number of Active Locations (%d) has already been reached.' + #13 +
          'This Location can be Un-Deleted only after one Active Location is deleted to make place for it.', [maxNoOfLocations]));
        exit;
      end;


      if MessageDlg('Do you want to Un-Delete Location "' +
        adoqLocations.fieldByName('LocationName').asstring + '", deleted on ' +
        adoqLocations.fieldByName('LMDT').asstring + ' ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        // ensure Name is unique, if not then ask user to choose another...
        s1 := adoqLocations.fieldByName('LocationName').asstring;

        Close;
        sql.Clear;
        sql.Add('select * from stkLocations');
        SQL.Add('WHERE SiteCode = ' + siteIDstr);
        SQL.Add('AND LocationName = ' + quotedStr(s1));
        sql.Add('AND Deleted = 0 ');
        open;

        while recordcount > 0 do
        begin
          if not inputquery('Type a unique Location Name (1-25 char.)', 'Un-Deleted Location Names have to be unique.' +
            #13 + '(Click "Cancel" to abandon Un-Delete)', s1) then
          begin
            exit;
          end;

          Close;
          sql.Clear;
          sql.Add('select * from stkLocations');
          SQL.Add('WHERE SiteCode = ' + siteIDstr);
          SQL.Add('AND LocationName = ' + quotedStr(s1));
          sql.Add('AND Deleted = 0 ');
          open;
        end;

        close;
        sql.Clear;
        SQL.Add('UPDATE [stkLocations] SET Deleted = 0');
        SQL.Add('   , LocationName = ' + quotedStr(s1));
        SQL.Add('   , LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
        SQL.Add('WHERE SiteCode = ' + siteIDstr);
        SQL.Add('AND LocationID = ' + adoqLocations.fieldByName('LocationID').asstring);
        ExecSQL;

        RequeryLocations;
        data1.siteHasValidLocations := data1.CheckLocationsValid;
        SetLocOrHZbuttons;
      end;

    finally
      Close;  // close dmado.adoqRun
    end;
  end;
end;

procedure TConfigForm.btnEditListClick(Sender: TObject);
var
  fLocationList: TfLocationList;
  curRecNo : integer;

  setString, s1, sSizes, sPositions : string;
  wintop, winleft, winheight, winwidth, splitter, i : integer;
begin
  if (adoqLocations.fieldByName('LocationID').asinteger = 0) or (not btnEditList.Enabled) then
    exit; // not for <No Location> or for Deleted Locations...

  fLocationList := TfLocationList.Create(self);
  try
    curRecNo := adoqLocations.RecNo;
    fLocationList.siteIDstr := siteIDstr;
    fLocationList.lookDiv.Items := lookDivLoc.Items;
    fLocationList.lookDiv.ItemIndex := lookDivLoc.ItemIndex;

    fLocationList.lookLocation.ItemIndex := fLocationList.lookLocation.Items.IndexOf(
      adoqLocations.fieldByName('LocationName').asstring + #9 + adoqLocations.fieldByName('LocationID').asstring);

    fLocationList.curLocName := fLocationList.lookLocation.Text;
    fLocationList.curLocIDstr := fLocationList.lookLocation.Value;

    fLocationList.curDivision := curDivision;
    fLocationList.curDivIDstr := curDivIDstr;

    fLocationList.ReloadProducts;
    fLocationList.ReloadList;

    fLocationList.formH := -1;

    with dmado.adoqRun do
    begin
      close;
      sql.Clear;
      SQL.Add('SELECT StringValue FROM LocalConfiguration');
      SQL.Add('WHERE KeyName = ''LocationListConfigWindow'' and SiteCode = '+ siteIDstr);
      open;
      setString := fieldByName('StringValue').AsString;
      close;

    end;

    try
      if pos('=WinTop ', setString) <> 0 then
      begin
        s1 := copy(setString, 1, pos('=WinTop ', setString) - 1);
        wintop := strtoint(s1);
        Delete(setString, 1, pos('=WinTop ', setString) + 7);

        s1 := copy(setString, 1, pos('=WinLeft ', setString) - 1);
        winleft := strtoint(s1);
        Delete(setString, 1, pos('=WinLeft ', setString) + 8);

        s1 := copy(setString, 1, pos('=WinHeight ', setString) - 1);
        winheight := strtoint(s1);
        Delete(setString, 1, pos('=WinHeight ', setString) + 10);

        s1 := copy(setString, 1, pos('=WinWidth ', setString) - 1);
        winwidth := strtoint(s1);
        Delete(setString, 1, pos('=WinWidth ', setString) + 9);

        s1 := copy(setString, 1, pos('=Splitter ', setString) - 1);
        splitter := strtoint(s1);
        Delete(setString, 1, pos('=Splitter ', setString) + 9);

        s1 := copy(setString, 1, pos('=Positions ', setString) - 1);
        sPositions := s1;
        Delete(setString, 1, pos('=Positions ', setString) + 10);

        s1 := copy(setString, 1, pos('=Sizes ', setString) - 1);
        sSizes := s1;
        Delete(setString, 1, pos('=Sizes ', setString) + 6);

        fLocationList.Position := poDesigned;
        fLocationList.Top := wintop;
        fLocationList.Left := winleft ;
        fLocationList.formH := winheight ;
        fLocationList.formW := winwidth ;
        fLocationList.gridProds.Width := splitter ;
      end;

      // if either the Positions or the Sizes are missing then keep the Defaults...
      if (sPositions <> '') and (sSizes <> '') then
      begin
        // set the position array    it looks like n1, n2 ,n3 ,n4...n10
        for i := 1 to 10 do
        begin
          s1 := copy(sPositions, 1, pos(', ', sPositions) - 1);
          fLocationList.fieldPositions[i] := strtoint(s1);
          Delete(sPositions, 1, pos(', ', sPositions) + 1);
        end;

        // set the sizes array
        for i := 1 to 10 do
        begin
          s1 := copy(sSizes, 1, pos(', ', sSizes) - 1);
          fLocationList.fieldSizes[i] := s1;
          Delete(sSizes, 1, pos(', ', sSizes) + 1);
        end;

          // set the popup check state...
        for i := 0 to (fLocationList.gridPopup.items.Count - 1) do
        begin
          if fLocationList.gridPopup.Items[i].Enabled then
          begin
            fLocationList.gridPopup.Items[i].Checked := (fLocationList.fieldPositions[i+1] > 0);
          end;
        end;
      end;

      fLocationList.SetGridFields(true);
    except
        on E:Exception do
        begin
          log.event('Error reading Location List screen settings (' + setString + '). ErrMsg: ' + E.Message);
          exit;
        end;
    end;

    fLocationList.ShowModal;

    RequeryLocations;
    adoqLocations.RecNo := curRecNo;
  finally
    fLocationList.Release;
  end;
end;

procedure TConfigForm.cbShowDeletedLocClick(Sender: TObject);
var
  curRecNo : integer;
begin
  curRecNo := adoqLocations.RecNo;
  RequeryLocations;
  adoqLocations.RecNo := curRecNo;
end;

procedure TConfigForm.RequeryLocations;
begin
  with adoqLocations do
  begin
    DisableControls;

    try
      Close;
      sql.Clear;
      SQL.Add('select loc.[LocationID], loc.[LocationName], loc.[Active], loc.[Deleted], loc.[LMDT],');
      SQL.Add('   loc.[PrintNote], ll.allLines, ll.unqProdUnits, ll.unqProds, ll.LastEdit, loc.HasFixedQty');
      SQL.Add('from stkLocations loc  ');
      SQL.Add('left join (select locationid, count(*) as allLines,  ');
      SQL.Add('        count(distinct (cast((entitycode - 10000000000) as varchar (12)) + unit)) as unqProdUnits,');
      SQL.Add('        count(distinct entitycode) as unqProds, MAX(LMDT) as LastEdit ');
      SQL.Add('        from stkLocationLists llc ');
      SQL.Add('        where Deleted = 0 and DivisionID = ' + curDivIDstr + ' and SiteCode = ' + siteIDstr);
      SQL.Add('        group by locationid) ll  ');
      SQL.Add('  on loc.LocationID = ll.LocationID');
      SQL.Add('WHERE loc.SiteCode = ' + siteIDstr);

      if not cbShowDeletedLoc.Checked then
        SQL.Add('and loc.Deleted = 0');

      sql.Add('  ');
      SQL.Add('UNION  ');
      SQL.Add('  ');
      SQL.Add('SELECT 0, ''<No Location>'', 0, cast(0 as bit), NULL, ''Products not assigned to any Location'',  ');
      SQL.Add('  NULL, NULL, theCount, NULL, NULL ');
      SQL.Add('from (select count(distinct se.EntityCode) as theCount  ');
      SQL.Add('      from(select entitycode from stkEntity where DivIx = ' + curDivIDstr);
      SQL.Add('            and [EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')) se  ');
      SQL.Add('       LEFT OUTER JOIN  ');
      SQL.Add('          (select entitycode from stkLocationLists where Deleted = 0  ');
      SQL.Add('           and DivisionID = ' + curDivIDstr + ' and SiteCode = ' + siteIDstr + ') ll2');
      SQL.Add('       ON se.EntityCode = ll2.EntityCode  ');
      SQL.Add('      where ll2.EntityCode is NULL) sq2  ');
      SQL.Add('order by [Deleted], [Active], locationName  ');
      open;

      with gridLocations do   // grid field names, etc...
      begin
        Selected.Clear;

        Selected.Add('LocationName'#9'24'#9'Location Name'#9'F');
        Selected.Add('allLines'#9'8'#9'Rows in~Location'#9'F');
        Selected.Add('unqProds'#9'8'#9'Unique~Products'#9'F');
        Selected.Add('LastEdit'#9'14'#9'Product List~Last Edited'#9'F');
        Selected.Add('HasFixedQty'#9'5'#9'Fixed~' + data1.ss6 + ''#9'F');

        gridLocations.ApplySelected;
      end;

    finally
      EnableControls;
    end;
  end;
end;


procedure TConfigForm.RequeryLocationList;
begin
  with adoqLocationList do
  begin
    DisableControls;

    try
      if adoqLocations.fieldByName('LocationID').asinteger <> 0 then  // "real" location
      begin
        Close;
        sql.Clear;
        SQL.Add('Select ll.[RecID],ll.[EntityCode],ll.[Unit],ll.[ManualAdd], se.[SCat], se.[PurchaseName], ');
        SQL.Add('CASE se.ETCode WHEN ''P'' THEN ''Prep.- '' + isNULL(p.[Retail Description], '''')' +
                                'ELSE p.[Retail Description] END  as Descr,');
        SQL.Add('CASE se.ETCode WHEN ''P'' THEN se.ETCode ELSE '''' END as isPrepItem, ');
        SQL.Add('CASE WHEN se.PurchaseUnit = ll.Unit THEN 1 ELSE 0 END as isPurchUnit');
        SQL.Add('FROM [stkLocationLists] ll');
        SQL.Add('   join stkEntity se on ll.EntityCode = se.EntityCode');
        SQL.Add('   join products p on se.EntityCode = p.EntityCode');
        SQL.Add('WHERE ll.Deleted = 0 AND ll.SiteCode = ' + siteIDstr);
        SQL.Add('AND ll.LocationID = ' + adoqLocations.fieldByName('LocationID').asstring );
        SQL.Add('AND ll.DivisionID = ' + curDivIDstr );
        sql.Add('order by  RecID');
        open;

        with gridLocationList do
        begin
          Selected.Clear;

          Selected.Add('RecID'#9'4'#9'Row'#9'F');
          Selected.Add('PurchaseName'#9'30'#9'Product Name'#9'F');
          Selected.Add('Unit'#9'10'#9'Unit'#9'F');
          Selected.Add('Scat'#9'20'#9'Sub-Category'#9'F');
          Selected.Add('Descr'#9'30'#9'Description'#9'F');

          ApplySelected;
        end;
      end
      else
      begin
        Close;
        sql.Clear;
        SQL.Add('Select ll.[RecID],se.[EntityCode],se.[PurchaseUnit] as Unit, 0 as [ManualAdd], se.[SCat], se.[PurchaseName], ');
        SQL.Add('CASE se.ETCode WHEN ''P'' THEN ''Prep.- '' + isNULL(p.[Retail Description], '''')' +
                                'ELSE p.[Retail Description] END  as Descr,');
        SQL.Add('CASE se.ETCode WHEN ''P'' THEN se.ETCode ELSE '''' END as isPrepItem, ');
        SQL.Add('1 as isPurchUnit');
        SQL.Add('FROM stkEntity se');
        SQL.Add(' join products p on se.EntityCode = p.EntityCode');
        SQL.Add(' LEFT join (select recid, entitycode from stkLocationLists ');
        SQL.Add('            where Deleted = 0 and SiteCode = ' + siteIDstr);
        SQL.Add('           ) ll on ll.EntityCode = se.EntityCode');
        SQL.Add('WHERE ll.RecID is NULL');
        SQL.Add('and se.[EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')');
        SQL.Add('AND se.Div = ' + QuotedStr(curDivision) );
        sql.Add('order by SCat, se.[PurchaseName]');
        open;

        with gridLocationList do
        begin
          Selected.Clear;

          Selected.Add('Scat'#9'20'#9'Sub-Category'#9'F');
          Selected.Add('PurchaseName'#9'30'#9'Product Name'#9'F');
          Selected.Add('Unit'#9'10'#9'Unit'#9'F');
          Selected.Add('Descr'#9'30'#9'Description'#9'F');

          ApplySelected;
        end;
      end;

    finally
      EnableControls;
    end;

  end;
end;


procedure TConfigForm.adoqLocationsAfterScroll(DataSet: TDataSet);
begin
  if adoqLocations.fieldByName('LocationID').asinteger = 0 then  // dummy <No Location>
  begin
    btnEditList.Enabled := False;
    btnEditLocation.Enabled := False;
    btnDeleteLocation.Enabled := False;
    btnDeleteLocation.Caption := 'Delete'+ #13 +'Location';
    RequeryLocationList;
  end
  else if adoqLocations.fieldByName('Deleted').asBoolean = TRUE then // Deleted location, if visible...
  begin
    btnEditList.Enabled := False;
    btnEditLocation.Enabled := False;
    btnDeleteLocation.Enabled := True;
    btnDeleteLocation.Caption := 'Un-Delete'+ #13 +'Location';
    RequeryLocationList;
  end
  else     // normal Location, not deleted...
  begin
    btnEditList.Enabled := True;
    btnEditLocation.Enabled := True;
    btnDeleteLocation.Enabled := True;
    btnDeleteLocation.Caption := 'Delete'+ #13 +'Location';
    RequeryLocationList;
  end;

end;

procedure TConfigForm.lookDivLocCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
var
  curRecNo : integer;
begin
  curDivision := lookDivLoc.Text;
  curDivIDstr := lookDivLoc.Value;
  curRecNo := adoqLocations.RecNo;

  // re-fill Cat and SubCat dropdowns
  // reset LocationList filters if any set

  RequeryLocations;
  adoqLocations.RecNo := curRecNo;
end;

procedure TConfigForm.gridLocationsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if adoqLocations.fieldByName('Deleted').AsBoolean = TRUE then
  begin
    if  (Field.FieldName = 'LocationName') then
    begin
      if gdSelected in State then
      begin
        aFont.Color := clWhite;
        aBrush.Color := clTeal;
      end
      else
      begin
        aFont.Color := clSilver;
        aBrush.Color := clDkGray;
      end;
    end
    else
    begin
      aFont.Color := clDkGray;
      aBrush.Color := clDkGray;
    end;
  end;
end;

procedure TConfigForm.SetLocOrHZbuttons;
var
  s1, s2 : string;
begin
  // 3. There will be two new buttons on the Config form (visible when you are on the right page).
  //   a. If the Site uses neither Locations nor HZs then one button will be "Use Count Locations"
  //      and the other will be "Use Holding Zones". Only if the user clicks a button (and Confirms
  //      when a Message Dialog appears) will the Locations or HZs turn on and be used by the Site.
  //   b. If the Site uses Locations there will be a label stating this and the buttons will
  //      read "Stop Using Count Locations" and "Cannot use Holding Zones" with the second button
  //      disabled. If the user clicks "Stop Using..." then the Site will no longer use Locations
  //      and the buttons will revert to the (a) state.
  //   c. If the Site uses HZs the button meanings will be reversed from (b) above.
  // 4. All above assume that HZs are set up and Valid and Locations are also setup (here the
  //    "Valid" state is simply to have 1 Location active, even if with no products, as we always
  //    have <No Location> as a fall-back). If the HZs are not Valid the button will state
  //    "Holding Zones INVALID" and be disabled, and the same for Locations. Obviously if HZs are
  //    Invalid you cannot turn on HZs to be used by the Site and the same goes for Locations.
  // 5. If either HZs or Locations are in use by the site and the user configures them as Invalid
  //    (and saves) then buttons will get the captions as above and the Site will no longer use HZs or Locations. (This can be done by Deleting the last Location, or by Invalidating the HZs setup, bear in mind that HZs become invalid if the HO adds a Till and the Site forgets to update the HZs setup).

  if not data1.siteHasValidHZs then
  begin
    btnUseHZs.Caption := 'Holding Zones INVALID';
    btnUseHZs.Enabled := FALSE;
    s2 := ' Holding Zones cannot be turned ON';
  end
  else
  begin
    if data1.siteUsesHZs then
    begin
      btnUseHZs.Caption := 'Stop Using Holding Zones';
      btnUseHZs.Enabled := TRUE;
      s1 := ' to use Locations first turn OFF Holding Zones';
      s2 := ' --- Holding Zones are IN USE ---';
    end
    else
    begin
      if data1.siteUsesLocations then
      begin
        btnUseHZs.Caption := 'Cannot Use Holding Zones';
        btnUseHZs.Enabled := FALSE;
        s2 := ' to use Holding Zones first turn OFF Locations';
      end
      else
      begin
        btnUseHZs.Caption := 'Use Holding Zones';
        btnUseHZs.Enabled := TRUE;
        s2 := ' Holding Zones can be turned ON...';
      end;
    end;
  end;

  if not data1.siteHasValidLocations then
  begin
    btnUseLocations.Caption := 'Count Locations INVALID';
    btnUseLocations.Enabled := FALSE;
    s1 := ' Count Locations cannot be turned ON';
  end
  else
  begin
    if data1.siteUsesLocations then
    begin
      btnUseLocations.Caption := 'Stop Using Count Locations';
      btnUseLocations.Enabled := TRUE;
      s1 := ' --- Count Locations are IN USE ---';
    end
    else
    begin
      if data1.siteUsesHZs then
      begin
        btnUseLocations.Caption := 'Cannot Use Count Locations';
        btnUseLocations.Enabled := FALSE;
      end
      else
      begin
        btnUseLocations.Caption := 'Use Count Locations';
        btnUseLocations.Enabled := TRUE;
        s1 := ' Count Locations can be turned ON...';
      end;
    end;
  end;

  self.lblHZLocText.Caption := s1 + #13 + s2;
  cbLCbyLoc.Checked := data1.siteLCbyLocation;
end;


procedure TConfigForm.btnUseLocationsClick(Sender: TObject);
var
  s: string;
begin
  // use field VarString to store if Locations apply to Line Checks or not...
  if cbLCbyLoc.Checked then
    s := 'LC'
  else
    s := '';

  if btnUseLocations.Caption = 'Use Count Locations' then
  begin
    if MessageDlg('You are about to turn ON Audit Counting by Count Location.'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      with adoqRun do
      begin
        // this should be OK by now but still, check if HZs are turned ON before you proceed...
        close;
        sql.Clear;
        sql.Add('SELECT VarBit from stkVarLocal where VarName = ''UseHZs'' ');
        sql.Add('and [SiteCode] = ' + inttostr(data1.thesitecode));
        open;

        // useHZs should NOT be true by now!?!?! Log this and turn it off...
        if (fieldByName('VarBit').asboolean) then
        begin
          close;
          sql.Clear;
          sql.Add('  DELETE stkVarLocal where VarName = ''UseHZs''');
          sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
          sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseHZs'', 0, GetDate())');
          execSQL;

          log.event('WARNING: UseHZs was ON in the table but was turned OFF before Locations was set ON!');
        end;

        close;
        sql.Clear;
        sql.Add('  DELETE stkVarLocal where VarName = ''UseLocatns''');
        sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [VarString], [LMDT])');
        sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseLocatns'', 1, '+ QuotedStr(s) +', GetDate())');
        execSQL;

        log.event('UseLocations was turned ON');
        data1.siteUsesLocations := data1.CheckSiteUsesLocations;
        data1.siteUsesHZs := data1.CheckSiteUsesHZs;
        SetLocOrHZbuttons;
      end;
    end;
  end
  else
  begin
    if MessageDlg('You are about to turn OFF Audit Counting by Count Location.'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      with adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('  DELETE stkVarLocal where VarName = ''UseLocatns''');
        sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [VarString], [LMDT])');
        sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseLocatns'', 0, '+ QuotedStr(s) +', GetDate())');
        execSQL;

        log.event('UseLocations was turned OFF');
        data1.siteUsesLocations := data1.CheckSiteUsesLocations;
        data1.siteUsesHZs := data1.CheckSiteUsesHZs;
        SetLocOrHZbuttons;
      end;
    end;
  end;
end;

procedure TConfigForm.btnUseHZsClick(Sender: TObject);
begin
  if btnUseHZs.Caption = 'Use Holding Zones' then
  begin
    if MessageDlg('You are about to turn ON Audit Counting by Holding Zone.'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      with adoqRun do
      begin
        // this should be OK by now but still, check if HZs are turned ON before you proceed...
        close;
        sql.Clear;
        sql.Add('SELECT VarBit from stkVarLocal where VarName = ''UseLocatns'' ');
        sql.Add('and [SiteCode] = ' + inttostr(data1.thesitecode));
        open;

        // useLocs should NOT be true by now!?!?! Log this and turn it off...
        if (fieldByName('VarBit').asboolean) then
        begin
          close;
          sql.Clear;
          sql.Add('  DELETE stkVarLocal where VarName = ''UseLocatns''');
          sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
          sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseLocatns'', 0, GetDate())');
          execSQL;

          log.event('WARNING: UseLocations was ON in the table but was turned OFF before HZs was set ON!');
        end;

        close;
        sql.Clear;
        sql.Add('  DELETE stkVarLocal where VarName = ''UseHZs''');
        sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
        sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseHZs'', 1, GetDate())');
        execSQL;

        log.event('UseHZs was turned ON');
        data1.siteUsesLocations := data1.CheckSiteUsesLocations;
        data1.siteUsesHZs := data1.CheckSiteUsesHZs;
        SetLocOrHZbuttons;
      end;
    end;
  end
  else
  begin
    if MessageDlg('You are about to turn OFF Audit Counting by Holding Zone.'+#13+#10+''+#13+#10+
                     'Are you sure?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      with adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('  DELETE stkVarLocal where VarName = ''UseHZs''');
        sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
        sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''UseHZs'', 0, GetDate())');
        execSQL;

        log.event('UseLocations was turned OFF');
        data1.siteUsesLocations := data1.CheckSiteUsesLocations;
        data1.siteUsesHZs := data1.CheckSiteUsesHZs;
        SetLocOrHZbuttons;
      end;
    end;
  end;
end;

procedure TConfigForm.cbLCbyLocClick(Sender: TObject);
begin
  if cbLCbyLoc.Checked then
  begin
    with adoqRun do
    begin
      // update only, no insert needed; if record not there then Locations were never turned on
      // and with Location use OFF LCs by Location is off anyway...
      close;
      sql.Clear;
      sql.Add('UPDATE stkVarLocal SET VarString = ''LC'', LMDT = GetDate()');
      sql.Add('where VarName = ''UseLocatns'' and SiteCode = ' +IntToStr(data1.TheSiteCode));
      execSQL;

      log.event('LC by Locations was turned ON');
      data1.siteUsesLocations := data1.CheckSiteUsesLocations;
      data1.siteUsesHZs := data1.CheckSiteUsesHZs;
    end;
  end
  else
  begin
    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE stkVarLocal SET VarString = '''', LMDT = GetDate()');
      sql.Add('where VarName = ''UseLocatns'' and SiteCode = ' +IntToStr(data1.TheSiteCode));
      execSQL;

      log.event('LC by Locations was turned OFF');
      data1.siteUsesLocations := data1.CheckSiteUsesLocations;
      data1.siteUsesHZs := data1.CheckSiteUsesHZs;
    end;
  end;
end;

// 305259 ---------------------------------------------------------------------------------------------
procedure TConfigForm.ReloadMustCountTemplatesAndSites;
begin
  adotMustCountTemplateSites.DisableControls;
  adotMustCountTemplateSites.Close;

  with dmado.adoqRun do
  try
    // first get the sites with their Company and Area...
    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#MustCountTemplateSites'') IS NOT NULL DROP TABLE #MustCountTemplateSites');

    SQL.Add('SELECT s.Id as SiteCode, s.[Name] as SiteName, s.Reference, a.Id as AreaID, a.[Name] as AreaName,');
    SQL.Add('    c.Id as CompanyID, c.[Name] as CompanyName, m.TemplateID, t.TemplateName ');
    SQL.Add('INTO [#MustCountTemplateSites]  ');
    SQL.Add('FROM ac_Site s                  ');
    SQL.Add('JOIN ac_Area a on s.AreaId = a.Id       ');
    SQL.Add('JOIN ac_Company c on a.CompanyId = c.Id ');
    SQL.Add('LEFT OUTER JOIN stkMustCountTemplateSites m on m.SiteCode = s.Id      ');
    SQL.Add('LEFT OUTER JOIN stkMustCountTemplate t on t.TemplateID = m.TemplateID ');
    SQL.Add('WHERE s.Deleted = 0 ');
    ExecSQL;


    // fill the company and area comboboxes...
    cbCompany.Items.Clear;
    cbCompany.Items.AddObject(' - SHOW ALL - ', TObject(0));
    cbArea.Items.Clear;
    cbArea.Items.AddObject(' - SHOW ALL - ', TObject(0));

    Close;
    SQL.Text := 'SELECT distinct CompanyId, CompanyName FROM #MustCountTemplateSites ORDER BY CompanyName';
    Open;

    while not EOF do
    begin
      cbCompany.Items.AddObject(FieldByName('CompanyName').AsString, TObject((FieldByName('CompanyId').AsInteger)));
      Next;
    end;

    Close;
    SQL.Text := 'SELECT distinct AreaId, AreaName FROM #MustCountTemplateSites ORDER BY AreaName';
    Open;

    while not EOF do
    begin
      cbArea.Items.AddObject(FieldByName('AreaName').AsString, TObject((FieldByName('AreaId').AsInteger)));
      Next;
    end;


    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#MustCountTemplate'') IS NOT NULL DROP TABLE #MustCountTemplate');
    SQL.Add('SELECT *, TemplateID as TemplateID2');
    SQL.Add('INTO [#MustCountTemplate]  ');
    SQL.Add('FROM stkMustCountTemplate ');
    ExecSQL;

    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#MustCountItems'') IS NOT NULL DROP TABLE #MustCountItems');
    SQL.Add('SELECT [TemplateID], [ProductID], [Deleted]');
    SQL.Add('INTO [#MustCountItems]  ');
    SQL.Add('FROM stkMustCountItems');
    ExecSQL;


  finally
    Close;
  end;

  adotMustCountTemplateSites.Open;
  adotMustCountTemplateSites.EnableControls;

  cbCompany.ItemIndex := 0;
  cbArea.ItemIndex := 0;

  RequeryTemplates;

  SetTempleteSitesFilter;
end;

procedure TConfigForm.RequeryTemplates;
var
  curRecNo : integer;
begin
  if adoqMustCountTemplates.Active then
    curRecNo := adoqMustCountTemplates.RecNo
  else
    curRecNo := 0;

  with adoqMustCountTemplates do
  begin
    DisableControls;

    try
      Close;
      sql.Clear;
      SQL.Add('select t.TemplateID, t.TemplateName, t.Note, i.items, s.sites, t.Deleted ');
      SQL.Add('from #MustCountTemplate t                                     ');
      SQL.Add('left join (select templateid, count(*) as items                 ');
      SQL.Add('           from #MustCountItems  where deleted = 0 group by TemplateID) i ');
      SQL.Add('on t.TemplateID = i.TemplateID ');
      SQL.Add('left join (select templateid, count(*) as sites                  ');
      SQL.Add('           from #MustCountTemplateSites group by TemplateID) s ');
      SQL.Add('on t.TemplateID = s.TemplateID  ');
      if cbShowDeletedTemplates.Checked then
      begin
        if cbNotUsedTemplates.Checked then
          SQL.Add('where s.sites is NULL');
      end
      else
        if cbNotUsedTemplates.Checked then
          SQL.Add('where t.Deleted = 0 and s.sites is NULL')
        else
          SQL.Add('where t.Deleted = 0             ');

      SQL.Add('order by TemplateName           ');
      open;

      with gridMustCountTemplate do   // grid field names, etc...
      begin
        Selected.Clear;

        Selected.Add('TemplateName'#9'40'#9'Template Name'#9'F');
        Selected.Add('items'#9'7'#9'Items~Count'#9'F');
        Selected.Add('sites'#9'8'#9'Used~by Sites'#9'F');

        gridLocations.ApplySelected;
      end;

      if adoqMustCountTemplates.RecordCount > 0 then
      begin
        if adoqMustCountTemplates.RecordCount < curRecNo then
          adoqMustCountTemplates.RecNo := adoqMustCountTemplates.RecordCount
        else if curRecNo > 0 then
          adoqMustCountTemplates.RecNo := curRecNo;
      end;  
    finally
      EnableControls;
    end;
  end;
end;



procedure TConfigForm.cbCompanyCloseUp(Sender: TObject);
var
  companyID : integer;
begin
  companyID := Integer(cbCompany.Items.Objects[cbCompany.ItemIndex]);

  with adoqRun do
  begin
    cbArea.Items.Clear;
    cbArea.Items.AddObject(' - SHOW ALL - ', TObject(0));

    Close;
    sql.Clear;
    sql.Add('SELECT distinct AreaId, AreaName FROM #MustCountTemplateSites');
    if companyID <> 0 then
       sql.add('where CompanyID = ' + inttostr(companyID));
    sql.Add('ORDER BY AreaName');
    Open;

    while not EOF do
    begin
      cbArea.Items.AddObject(FieldByName('AreaName').AsString, TObject((FieldByName('AreaId').AsInteger)));
      Next;
    end;
  end;

  cbArea.Refresh;
  cbArea.ItemIndex := 0;

  SetTempleteSitesFilter;
end;

procedure TConfigForm.SetTempleteSitesFilter;
var
  theFilter : string;
begin
  theFilter := '';

  if cbNoTemplateSites.Checked then
    theFilter := 'TemplateID = NULL AND ';

  if cbCompany.Text <> ' - SHOW ALL - ' then
    theFilter := theFilter + 'CompanyID = ' +
      inttostr(Integer(cbCompany.Items.Objects[cbCompany.ItemIndex])) + ' AND ';

  if cbArea.Text <> ' - SHOW ALL - ' then
    theFilter := theFilter + 'AreaID = ' +
      inttostr(Integer(cbArea.Items.Objects[cbArea.ItemIndex])) + ' AND ';

  // get rid of the last 5 characters
  delete(theFilter, length(theFilter) - 4, 5);

  adotMustCountTemplateSites.Filter := theFilter;
  adotMustCountTemplateSites.Filtered := (theFilter <> '')
end;

procedure TConfigForm.cbNoTemplateSitesClick(Sender: TObject);
begin
  SetTempleteSitesFilter;
end;

procedure TConfigForm.cbAreaCloseUp(Sender: TObject);
begin
  SetTempleteSitesFilter;
end;

procedure TConfigForm.adoqMustCountTemplatesAfterScroll(DataSet: TDataSet);
begin
  if adoqMustCountTemplates.RecordCount = 0 then
  begin
    btnTemplateList.Enabled := False;
    btnEditTemplate.Enabled := False;
    btnDeleteTemplate.Enabled := False;
    btnAssignTemplate.Enabled := False;
    btnCopyTemplate.Enabled := False;
  end
  else
  begin
    if adoqMustCountTemplates.fieldByName('Deleted').asBoolean = TRUE then
    begin
      btnAssignTemplate.Enabled := False;
      btnTemplateList.Enabled := False;
      btnEditTemplate.Enabled := False;
      btnCopyTemplate.Enabled := True;
      btnDeleteTemplate.Enabled := True;
      btnDeleteTemplate.Caption := 'Un-Delete'+ #13 +'Template';
    end
    else
    begin
      btnAssignTemplate.Enabled := True;
      btnTemplateList.Enabled := True;
      btnEditTemplate.Enabled := True;
      btnCopyTemplate.Enabled := True;
      btnDeleteTemplate.Enabled := (adoqMustCountTemplates.fieldByName('sites').asinteger = 0);
      btnDeleteTemplate.Caption := 'Delete'+ #13 +'Template';
    end;
  end;
end;

procedure TConfigForm.btnAddTemplateClick(Sender: TObject);
var
  nextTemplateID : integer;
begin
  with dmado.adoqRun do
  try
    fAddEditLocation := TfAddEditLocation.Create(self);
    try
      fAddEditLocation.editLocName.Text := '';
      fAddEditLocation.memoPrintNote.Text := '';
      fAddEditLocation.editLocName.MaxLength := 35;
      fAddEditLocation.memoPrintNote.MaxLength := 250;
      fAddEditLocation.Caption := 'Add a new "Must Count" Template';
      fAddEditLocation.lblName.Caption := 'Template Name';
      fAddEditLocation.lblNameInfo.Caption := 'Min. 1, Max. 35 characters, unique, required.';
      fAddEditLocation.lblNote.Caption := 'Template Note';
      fAddEditLocation.lblNoteInfo.Caption := 'Max. 250 characters, optional.';
      fAddEditLocation.cbHasFixedStock.Visible := FALSE;

      fAddEditLocation.locationNames.Clear;

      // get the current names and load the StringList for checking...
      close;
      sql.Clear;
      sql.Add('select * from #MustCountTemplate where Deleted = 0');
      open;

      while not eof do
      begin
        fAddEditLocation.locationNames.Add(FieldByName('TemplateName').asstring);
        next;
      end;

      close;

      if fAddEditLocation.ShowModal = mrOK then  // save
      begin
        close;
        sql.Clear;
        sql.Add('select max(TemplateID) as maxID from #MustCountTemplate');
        open;

        nextTemplateID := fieldByName('maxID').asinteger + 1;

        // use temp IDs, all > 1000 to be able to add this sessions's new Templates to the real tables
        // on "Save Changes" (as well as their assignments and Products Lists) to avoid Key Violations
        // if 2 users add a new template at the same time...
        if nextTemplateID < 1000 then
          nextTemplateID := 1000;

        close;
        sql.Clear;
        sql.Add('insert #MustCountTemplate ([TemplateID], [TemplateName], [Note], [Deleted], [LMDT], [LMBy], TemplateID2) ');
        sql.Add('VALUES ( '+ inttoStr(nextTemplateID) + ', ' );
        sql.Add('   ' + quotedStr(fAddEditLocation.templateName) + ', ');
        sql.Add('   ' + quotedStr(fAddEditLocation.memoPrintNote.Text) + ', 0,');
        sql.Add('   ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)) + ', NULL, 0)');
        execSQL;

        RequeryTemplates;
        adoqMustCountTemplates.Locate('TemplateID', nextTemplateID, []);
        btnSaveTemplateChanges.Enabled := True;
        btnDiscardTemplateChanges.Enabled := True;
      end;

    finally
      fAddEditLocation.Free;
    end;
  finally
    Close;  // close dmado.adoqRun
  end;
end;


procedure TConfigForm.btnEditTemplateClick(Sender: TObject);
var
  curTemplateID : integer;
begin
  with dmado.adoqRun do
  try
    fAddEditLocation := TfAddEditLocation.Create(self);
    try
      fAddEditLocation.editLocName.Text := adoqMustCountTemplates.fieldByName('TemplateName').asstring ;
      fAddEditLocation.templateName := adoqMustCountTemplates.fieldByName('TemplateName').asstring ;
      fAddEditLocation.memoPrintNote.Text := adoqMustCountTemplates.fieldByName('Note').asstring;
      fAddEditLocation.editLocName.MaxLength := 35;
      fAddEditLocation.memoPrintNote.MaxLength := 250;
      fAddEditLocation.Caption := 'Edit "Must Count" Template: ' + adoqMustCountTemplates.fieldByName('TemplateName').asstring;
      fAddEditLocation.lblName.Caption := 'Template Name';
      fAddEditLocation.lblNameInfo.Caption := 'Min. 1, Max. 35 characters, unique, required.';
      fAddEditLocation.lblNote.Caption := 'Template Note';
      fAddEditLocation.lblNoteInfo.Caption := 'Max. 250 characters, optional.';
      fAddEditLocation.cbHasFixedStock.Visible := FALSE;

      curTemplateID := adoqMustCountTemplates.fieldByName('TemplateID').asinteger;
      fAddEditLocation.locationNames.Clear;

      // get the current names and load the StringList for checking...
      close;
      sql.Clear;
      sql.Add('select * from #MustCountTemplate where Deleted = 0 and TemplateID <> ' + inttostr(curTemplateID));
      open;

      while not eof do
      begin
        fAddEditLocation.locationNames.Add(FieldByName('TemplateName').asstring);
        next;
      end;

      close;

      if fAddEditLocation.ShowModal = mrOK then  // save
      begin
        close;
        sql.Clear;
        sql.Add('UPDATE #MustCountTemplate  ');
        sql.Add('  SET [TemplateName] = ' + quotedStr(fAddEditLocation.templateName) + ', ');
        sql.Add('      [Note]  = ' + quotedStr(fAddEditLocation.memoPrintNote.Text));
        SQL.Add('WHERE TemplateID = ' + intToStr(curTemplateId));
        execSQL;

        RequeryTemplates;
        adoqMustCountTemplates.Locate('TemplateID', curTemplateID, []);
        btnSaveTemplateChanges.Enabled := True;
        btnDiscardTemplateChanges.Enabled := True;
      end;

    finally
      fAddEditLocation.Free;
    end;
  finally
    Close;  // close dmado.adoqRun
  end;
end;


procedure TConfigForm.btnDeleteTemplateClick(Sender: TObject);
var
  s1 : string;
begin
  s1 := adoqMustCountTemplates.fieldByName('TemplateName').asstring;

  if adoqMustCountTemplates.fieldByName('Deleted').asBoolean = FALSE then    // Delete
  begin
    with dmado.adoqRun do
    try
      // should be OK but check Template is not assigned to a Site, just in case...
      Close;
      sql.Clear;
      sql.Add('select * from #MustCountTemplateSites');
      SQL.Add('WHERE TemplateID = ' + (adoqMustCountTemplates.fieldByName('TemplateID').asstring));
      open;

      if recordcount > 0 then
      begin
        showMessage('Template "' + s1 + '" is assigned to ' + inttostr(recordcount) + ' sites.' +#13#13+
          'Only Templates not assigned to any Site can be Deleted.');
        close;
        exit;
      end;

      if MessageDlg('Are you sure you want to Delete Template "' + s1 + '"?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        // ensure Name is unique among Deleted locations, if not then ask user to choose another...
        Close;
        sql.Clear;
        sql.Add('select * from #MustCountTemplate');
        SQL.Add('WHERE TemplateName = ' + quotedStr(s1));
        sql.Add('AND Deleted = 1 ');
        open;

        while recordcount > 0 do
        begin
          if not inputquery('Type a unique Template Name (1-35 char.)',
          'Deleted Template Names have to be unique.' +
            #13 + '(Click "Cancel" to abandon Delete)', s1) then
          begin
            exit;
          end;

          Close;
          sql.Clear;
          sql.Add('select * from #MustCountTemplate');
          SQL.Add('WHERE TemplateName = ' + quotedStr(s1));
          sql.Add('AND Deleted = 1 ');
          open;
        end;

        close;
        sql.Clear;
        SQL.Add('UPDATE #MustCountTemplate SET Deleted = 1');
        SQL.Add('   , TemplateName = ' + quotedStr(s1));
        SQL.Add('   , LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
        SQL.Add('WHERE TemplateID = ' + adoqMustCountTemplates.fieldByName('TemplateID').asstring);
        ExecSQL;

        btnSaveTemplateChanges.Enabled := True;
        btnDiscardTemplateChanges.Enabled := True;
      end;

    finally
      Close;  // close dmado.adoqRun
    end;
  end
  else          // ---------------------------------------------- UN-Delete
  begin
    with dmado.adoqRun do
    try
      if MessageDlg('Do you want to Un-Delete Template "' +
        s1 + '"?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        Close;
        sql.Clear;
        sql.Add('select * from #MustCountTemplate');
        SQL.Add('WHERE TemplateName = ' + quotedStr(s1));
        sql.Add('AND Deleted = 0 ');
        open;

        while recordcount > 0 do
        begin
          if not inputquery('Type a unique Template Name (1-35 char.)',
          'Template Names have to be unique.' +
            #13 + '(Click "Cancel" to abandon Un-Delete)', s1) then
          begin
            exit;
          end;

          Close;
          sql.Clear;
          sql.Add('select * from #MustCountTemplate');
          SQL.Add('WHERE TemplateName = ' + quotedStr(s1));
          sql.Add('AND Deleted = 0 ');
          open;
        end;

        close;
        sql.Clear;
        SQL.Add('UPDATE #MustCountTemplate SET Deleted = 0');
        SQL.Add('   , TemplateName = ' + quotedStr(s1));
        SQL.Add('   , LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
        SQL.Add('WHERE TemplateID = ' + adoqMustCountTemplates.fieldByName('TemplateID').asstring);
        ExecSQL;

        btnSaveTemplateChanges.Enabled := True;
        btnDiscardTemplateChanges.Enabled := True;
      end;
    finally
      Close;  // close dmado.adoqRun
    end;
  end;
  RequeryTemplates;

end;

procedure TConfigForm.btnTemplateListClick(Sender: TObject);
begin
  if (adoqMustCountTemplates.fieldByName('TemplateID').asinteger = 0) or (not btnTemplateList.Enabled) then
    exit;

  fMustCountItems := TfMustCountItems.Create(self);
  try

    fMustCountItems.curTemplateID := adoqMustCountTemplates.fieldByName('TemplateID').asinteger;
    fMustCountItems.curTemplateName := adoqMustCountTemplates.fieldByName('TemplateName').AsString;

    if fMustCountItems.ShowModal = mrOK then
    begin
      RequeryTemplates;
      btnSaveTemplateChanges.Enabled := True;
      btnDiscardTemplateChanges.Enabled := True;
    end;
    
  finally
    fMustCountItems.Release;
  end;
end;

procedure TConfigForm.cbShowDeletedTemplatesClick(Sender: TObject);
begin
  RequeryTemplates;
end;

procedure TConfigForm.btnNextSearchClick(Sender: TObject);
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;    

procedure TConfigForm.btnPriorSearchClick(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
   tempTab : TADOTable;
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;

  tempTab := TADOTable(incSearch1.DataSource.Dataset); // ensures the correct Table is searched as set by user with RadioButton

  // find prior has to be done programatically...
  with tempTab do
  begin
    disablecontrols;

    { get a bookmark so that we can return to the same record }
    SavePlace := GetBookmark;
    try
      matchyes := false;

      while (not bof) do
      begin
        Prior;

        // check for match  ... incSearch1.SearchField ensures the correct field name is used
        if (rgSearchKind.ItemIndex = 0) then // incremental.
          matchyes := AnsiStartsText(incSearch1.Text, FieldByName(incSearch1.SearchField).asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName(incSearch1.SearchField).asstring,edSearch.Text);

        if matchyes then break;
      end;

      {if match not found Move back to the bookmark}
      if not matchyes then
      begin
        GotoBookmark(SavePlace);
        showMessage('No More Matches found!');
      end;

      { Free the bookmark }
    finally
      FreeBookmark(SavePlace);
    end;

    enablecontrols;
  end;
end;


procedure TConfigForm.rbSearchSiteNameClick(Sender: TObject);
begin
  if rbSearchSiteName.Checked then
  begin
    incSearch1.SearchField := 'SiteName';
  end
  else
  begin
    incSearch1.SearchField := 'Reference';
  end;
  wwFind.SearchField := incSearch1.SearchField;
end;

procedure TConfigForm.rgSearchKindClick(Sender: TObject);
begin
  incSearch1.Visible := (rgSearchKind.ItemIndex = 0);
  edSearch.Visible := not incSearch1.Visible;

  if incSearch1.Visible then
  begin
    wwFind.MatchType := mtPartialMatchStart;
    incSearch1.SetFocus;
  end
  else
  begin
    wwFind.MatchType := mtPartialMatchAny;
    edSearch.SetFocus;
  end;
end;

procedure TConfigForm.adotMustCountTemplateSitesAfterScroll(DataSet: TDataSet);
begin
  btnUnassignTemplate.Enabled := not (adotMustCountTemplateSites.FieldByName('TemplateID').IsNull);
end;

procedure TConfigForm.btnUnAssignTemplateClick(Sender: TObject);
var
  curRecNo, i: integer;
begin

  if gridMustCountTemplateSites.SelectedList.Count > 1 then
  begin
    // confirm...
    if MessageDlg('You are about to un-assign the Templates from the Selected Sites (' +
         inttostr(gridMustCountTemplateSites.SelectedList.Count) + ' Sites).' + #10#13 + #10#13 +
         'Are you sure you want to proceed?', mtWarning, [mbYes,mbNo], 0) = mrNo then
      exit;

    curRecNo := adotMustCountTemplateSites.RecNo;
    adotMustCountTemplateSites.DisableControls;

    for i := 0 to gridMustCountTemplateSites.SelectedList.Count - 1 do
    begin
      adotMustCountTemplateSites.GotoBookmark(gridMustCountTemplateSites.SelectedList.items[i]);

      adotMustCountTemplateSites.Edit;
      adotMustCountTemplateSites.fieldbyname('TemplateID').asString := '';
      adotMustCountTemplateSites.fieldbyname('TemplateName').asstring := '';
      adotMustCountTemplateSites.Post;
    end;

    gridMustCountTemplateSites.UnselectAll;
    adotMustCountTemplateSites.RecNo := curRecNo;
    adotMustCountTemplateSites.EnableControls;
  end
  else
  begin
      adotMustCountTemplateSites.Edit;
      adotMustCountTemplateSites.fieldbyname('TemplateID').asString := '';
      adotMustCountTemplateSites.fieldbyname('TemplateName').asstring := '';
      adotMustCountTemplateSites.Post;
  end;

  RequeryTemplates;
  btnUnassignTemplate.Enabled := not (adotMustCountTemplateSites.FieldByName('TemplateID').IsNull);
end;

procedure TConfigForm.btnAssignTemplateClick(Sender: TObject);
var
  curRecNo, i, j: integer;
begin
  if gridMustCountTemplateSites.SelectedList.Count > 1 then
  begin
    curRecNo := adotMustCountTemplateSites.RecNo;
    adotMustCountTemplateSites.DisableControls;
    j := 0;

    for i := 0 to gridMustCountTemplateSites.SelectedList.Count - 1 do
    begin
      adotMustCountTemplateSites.GotoBookmark(gridMustCountTemplateSites.SelectedList.items[i]);

      if adotMustCountTemplateSites.fieldbyname('TemplateID').asinteger > 0 then
        inc(j);
    end;

    if j > 0 then
    begin
      if MessageDlg('You are about to assign Template "' +
           adoqMustCountTemplates.fieldByName('TemplateName').asstring +
           '" to ' + inttostr(i) + ' selected sites.' + #10#13 + #10#13 +
           'But '  + inttostr(j) + ' of them already have Templates assigned.'+ #10#13 +
           'Assigning a new Template will un-assign the existing ones.' + #10#13 + #10#13+
           'Are you sure you want to proceed?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
        adotMustCountTemplateSites.RecNo := curRecNo;
        adotMustCountTemplateSites.EnableControls;
        exit;
      end;
    end; 

    for i := 0 to gridMustCountTemplateSites.SelectedList.Count - 1 do
    begin
      adotMustCountTemplateSites.GotoBookmark(gridMustCountTemplateSites.SelectedList.items[i]);

      adotMustCountTemplateSites.Edit;
      adotMustCountTemplateSites.fieldbyname('TemplateID').asinteger :=
                    adoqMustCountTemplates.fieldByName('TemplateID').asinteger;
      adotMustCountTemplateSites.fieldbyname('TemplateName').asstring :=
                    adoqMustCountTemplates.fieldByName('TemplateName').asstring;
      adotMustCountTemplateSites.Post;
    end;

    gridMustCountTemplateSites.UnselectAll;
    adotMustCountTemplateSites.RecNo := curRecNo;
    adotMustCountTemplateSites.EnableControls;
    gridMustCountTemplateSites.Refresh;
  end
  else
  begin
    if adotMustCountTemplateSites.fieldbyname('TemplateID').asinteger > 0 then
    begin
      if MessageDlg('Site "' + adotMustCountTemplateSites.fieldbyname('SiteName').AsString +
          '" already has Template "' + adotMustCountTemplateSites.fieldbyname('TemplateName').AsString +
          '" assigned.' + #10#13 +
          'Assigning a new Template will un-assign the existing one.' + #10#13 +
          'Are you sure you want to assign Template "' +
                adoqMustCountTemplates.fieldByName('TemplateName').asstring +
          '" to it?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
        exit;
    end;
    adotMustCountTemplateSites.Edit;
    adotMustCountTemplateSites.fieldbyname('TemplateID').asinteger :=
                  adoqMustCountTemplates.fieldByName('TemplateID').asinteger;
    adotMustCountTemplateSites.fieldbyname('TemplateName').asstring :=
                  adoqMustCountTemplates.fieldByName('TemplateName').asstring;
    adotMustCountTemplateSites.Post;
    gridMustCountTemplateSites.Refresh;
  end;

  RequeryTemplates;
  btnUnassignTemplate.Enabled := not (adotMustCountTemplateSites.FieldByName('TemplateID').IsNull);
end;

procedure TConfigForm.gridMustCountTemplateCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if adoqMustCountTemplates.fieldByName('Deleted').AsBoolean = TRUE then
  begin
    if  (Field.FieldName = 'TemplateName') then
    begin
      if gdSelected in State then
      begin
        aFont.Color := clWhite;
        aBrush.Color := clTeal;
      end
      else
      begin
        aFont.Color := clSilver;
        aBrush.Color := clDkGray;
      end;
    end
    else
    begin
      aFont.Color := clDkGray;
      aBrush.Color := clDkGray;
    end;
  end;

end;

procedure TConfigForm.btnCopyTemplateClick(Sender: TObject);
var
  nextTemplateID, curTemplateID : integer;
begin
  with dmado.adoqRun do
  try
    fAddEditLocation := TfAddEditLocation.Create(self);
    try
      fAddEditLocation.editLocName.Text := '';
      fAddEditLocation.memoPrintNote.Text := '';
      fAddEditLocation.editLocName.MaxLength := 35;
      fAddEditLocation.memoPrintNote.MaxLength := 250;
      fAddEditLocation.Caption := 'Duplicate the Template: ' + adoqMustCountTemplates.fieldByName('TemplateName').asstring;
      fAddEditLocation.lblName.Caption := 'Template Name';
      fAddEditLocation.lblNameInfo.Caption := 'Min. 1, Max. 35 characters, unique, required.';
      fAddEditLocation.lblNote.Caption := 'Template Note';
      fAddEditLocation.lblNoteInfo.Caption := 'Max. 250 characters, optional.';
      fAddEditLocation.cbHasFixedStock.Visible := FALSE;

      fAddEditLocation.locationNames.Clear;

      // get the current names and load the StringList for checking...
      close;
      sql.Clear;
      sql.Add('select * from #MustCountTemplate where Deleted = 0');
      open;

      while not eof do
      begin
        fAddEditLocation.locationNames.Add(FieldByName('TemplateName').asstring);
        next;
      end;

      close;

      if fAddEditLocation.ShowModal = mrOK then  // save
      begin
        close;
        sql.Clear;
        sql.Add('select max(TemplateID) as maxID from #MustCountTemplate');
        open;

        nextTemplateID := fieldByName('maxID').asinteger + 1;

        // use temp IDs, all > 1000 to be able to add this sessions's new Templates to the real tables
        // on "Save Changes" (as well as their assignments and Products Lists) to avoid Key Violations
        // if 2 users add a new template at the same time...
        if nextTemplateID < 1000 then
          nextTemplateID := 1000;

        close;
        sql.Clear;
        sql.Add('insert #MustCountTemplate ([TemplateID], [TemplateName], [Note], [Deleted], [LMDT], [LMBy], TemplateID2) ');
        sql.Add('VALUES ( '+ inttoStr(nextTemplateID) + ', ' );
        sql.Add('   ' + quotedStr(fAddEditLocation.templateName) + ', ');
        sql.Add('   ' + quotedStr(fAddEditLocation.memoPrintNote.Text) + ', 0,');
        sql.Add('   ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)) + ', NULL, 0)');
        execSQL;

        // now copy the Product List of the old template to the new template
        curTemplateID := adoqMustCountTemplates.fieldByName('TemplateID').asinteger;
        SQL.Clear;
        sql.Add('insert #MustCountItems ([TemplateID], [ProductID], [Deleted])');
        SQL.Add('SELECT ' + inttostr(nextTemplateID) + ', [ProductID], 0');
        sql.Add('from #MustCountItems where TemplateID = ' + inttostr(curTemplateID) );
        SQL.Add('and Deleted = 0');
        execSQL;


        RequeryTemplates;
        adoqMustCountTemplates.Locate('TemplateID', nextTemplateID, []);
        btnSaveTemplateChanges.Enabled := True;
        btnDiscardTemplateChanges.Enabled := True;
      end;

    finally
      fAddEditLocation.Free;
    end;
  finally
    Close;  // close dmado.adoqRun
  end;
end;

procedure TConfigForm.btnSaveTemplateChangesClick(Sender: TObject);
begin
  SaveTemplateChanges;
end;

function TConfigForm.SaveTemplateChanges: boolean;
begin
  Result := False;
  // remember and change the 1000's to the next ID...

  // save the templates and the products in one transaction to mimimize the chance of KV in cases
  // of multi-users trying to insert Templates with the same "next Template ID"...
  with dmado.adoqRun do
  try try
    if MessageDlg('Do you want to Save all Changes to "Must Count" item Templates done in this session?',
          mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin

      Close;
      sql.Clear;

      sql.Add('begin transaction ');
      sql.Add(' ');
      sql.Add('declare @maxID int ');
      sql.Add('select @maxid = max(TemplateID) from stkMustCountTemplate ');
      sql.Add('update [#MustCountTemplate] set TemplateID2 = TemplateID + isNULL(@maxID, 0) - 999 where TemplateID >= 1000 ');

      sql.Add(' ');  // save changes to Template header; UPDATE first use TemplateID as
                     //      new templates (TemplateID >= 1000) would not be there anyway...
      sql.Add('update stkMustCountTemplate set ');
      sql.Add('[TemplateName] = b.[TemplateName], [Note] = b.[Note], [Deleted] = b.[Deleted],');
      sql.Add(' [LMDT] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add(' , [LMBy] = ' + quotedStr(CurrentUser.UserName));
      sql.Add('from stkMustCountTemplate a, #MustCountTemplate b where a.[TemplateID] = b.[TemplateID]');
      sql.Add('and (a.[TemplateName] <> b.[TemplateName] or a.[Note] <> b.[Note] or a.[Deleted] <> b.[Deleted])');

      sql.Add(' '); // ... now INSERT new ones, use Template2 field as the Template ID...
                    //        except deleted ones as they have no reason to be saved...

      sql.Add('insert stkMustCountTemplate ([TemplateID], [TemplateName], [Note], [Deleted], [LMDT], [LMBy])');
      SQL.Add('SELECT t.[TemplateID2], t.[TemplateName], t.[Note], 0,');
      sql.Add(' (' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ' ) as lmdt,');
      sql.Add(' (' + quotedStr(CurrentUser.UserName) + ') as lmby');
      sql.Add('from #MustCountTemplate t ');
      SQL.Add('LEFT OUTER JOIN (select * from stkMustCountTemplate) p');
      SQL.Add('on p.[TemplateID] = t.[TemplateID2]');
      SQL.Add('WHERE p.[TemplateID] is NULL and t.Deleted = 0');

      sql.Add(' '); // save changes to Template products list;

      sql.Add('update stkMustCountItems set [Deleted] = b.[Deleted],'); // only field to update is Deleted...
      sql.Add(' [LMDT] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add(' , [LMBy] = ' + quotedStr(CurrentUser.UserName));
      sql.Add('from stkMustCountItems a, #MustCountItems b where a.[TemplateID] = b.[TemplateID]');
      sql.Add('and a.[ProductID] = b.[ProductID] and a.[Deleted] <> b.[Deleted]');

      sql.Add(' '); // now insert new records but use TemplateID2 from #MustCountTemplates also
                    //   no need to insert Deleted = 1 -NEW- records as they were never sent to sites
      sql.Add('insert stkMustCountItems ([TemplateID], [ProductID], [Deleted], [LMDT], [LMBy])');
      SQL.Add('SELECT t.[TemplateID2], p.[ProductID], 0,');
      sql.Add(' (' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) +' ) as lmdt,');
      sql.Add(' (' + quotedStr(CurrentUser.UserName) +') as lmby');
      sql.Add('from #MustCountTemplate t ');
      SQL.Add('JOIN (select * from #MustCountItems where Deleted = 0) p');
      SQL.Add('on p.[TemplateID] = t.[TemplateID]');
      SQL.Add('LEFT OUTER JOIN stkMustCountItems i');
      SQL.Add('on i.[TemplateID] = t.[TemplateID2] and i.[ProductID] = p.[ProductID] ');
      SQL.Add('WHERE i.[TemplateID] is NULL');

      sql.Add(' '); // save changes to template allocation to sites use TemplateID2 from #MustCountTemplates

      sql.Add('update stkMustCountTemplateSites set TemplateID = b.[TemplateID2],');
      sql.Add(' [LMDT] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add(' , [LMBy] = ' + quotedStr(CurrentUser.UserName));
      sql.Add('from stkMustCountTemplateSites a ');
      SQL.Add('JOIN (select t.templateid2, s.siteCode from #MustCountTemplate t');
      sql.Add('      right outer join #MustCountTemplateSites s on t.templateid = s.TemplateID) b');
      SQL.Add('on a.[SiteCode] = b.[SiteCode]');

      sql.Add(' '); // now insert new records but use TemplateID2 from #MustCountTemplates

      sql.Add('insert stkMustCountTemplateSites ([SiteCode], [TemplateID], [LMDT], [LMBy])');
      SQL.Add('SELECT  s.[SiteCode], t.[TemplateID2], ');
      sql.Add(' (' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) +' ) as lmdt,');
      sql.Add(' (' + quotedStr(CurrentUser.UserName) +') as lmby');
      sql.Add('from #MustCountTemplate t ');
      SQL.Add('JOIN #MustCountTemplateSites s on t.templateid = s.TemplateID');
      SQL.Add('where s.[SiteCode] not in (select sitecode from stkMustCountTemplateSites)');
      sql.Add(' ');
      sql.Add('commit transaction ');
      ExecSQL;

      ReloadMustCountTemplatesAndSites;
      btnSaveTemplateChanges.Enabled := False;
      btnDiscardTemplateChanges.Enabled := False;
      Result := True;
    end;
  except
      on E:exception do
      begin
        Log.Event('Error saving Must Count Template changes: ' + E.ClassName + ' ' + E.Message);

        ShowMessage('Failed to save changes due to an unexpected error.'#13#10#13#10 +
                    'Error message: ' + E.ClassName + ' ' + E.Message); 
      end;
    end;
  finally
    Close;  // close dmado.adoqRun
  end;
end;

procedure TConfigForm.btnDiscardTemplateChangesClick(Sender: TObject);
begin
  // are there changes? What changes? Ask to confirm...
  dmADO.DumpTemp('#MustCountTemplate');

  ReloadMustCountTemplatesAndSites;
  btnSaveTemplateChanges.Enabled := False;
  btnDiscardTemplateChanges.Enabled := False;
end;

procedure TConfigForm.adotMustCountTemplateSitesAfterPost(
  DataSet: TDataSet);
begin
  btnSaveTemplateChanges.Enabled := True;
  btnDiscardTemplateChanges.Enabled := True;
end;

procedure TConfigForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if PageControl1.ActivePage = tabMustCount then
  begin
    case key of
      VK_F2: begin
               Key := 0;
               btnPriorSearchClick(Sender);
             end;
      VK_F3: begin
               Key := 0;
               btnNextSearchClick(Sender);
             end;
    end; // case..
  end;
end;

function TConfigForm.GetMaxStockLocationCount(): Integer;
var
  maxNoOfLocations: Integer;
begin
  with dmado.adoqRun do
  begin
    // what is the Max No of Locations this Site can have? (Default is 20)
    Close;
    sql.Clear;
    sql.Add('DECLARE @MaxNo varchar(5)');
    sql.Add('SELECT @MaxNo = [dbo].[fn_GetConfigurationSetting] (''MaxNoOfLocations'')');
    sql.Add('SELECT CASE isNumeric(@MaxNo) WHEN 0 THEN 0 ELSE @MaxNo END as MaxLocs');
    open;

    if fieldByName('MaxLocs').AsInteger <> 0 then
      maxNoOfLocations := Min(fieldByName('MaxLocs').AsInteger, 100)
    else
      maxNoOfLocations := 20;

    Result := Max(maxNoOfLocations, 10);

    close;
  end;
end;

end.
