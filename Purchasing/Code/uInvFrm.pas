{ Mike Palmer
  20th September 2004
  325252 - Unit Costs should be greyed out
  Altered wwDBGrid1.fixedCols original setting 5, new setting 6


  Mike Palmer
  21st September 2004
  325174 - Supplier field can overlap the Delivery Note/Invoice number
  Re-aligned fields, increased the size of Supplier Name and switched on
  Wordwrap

  Wilma Lobban
  29th September 2004
  325252 - Unit Costs should be greyed out
  Changed wwDBGrid1.fixedCols back to 5 and added an extra check to
  wwDbGrid1CalcCellColors using CostPricesAreReadOnly }

unit uInvFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, DBTables, StdCtrls,
  ExtCtrls, Buttons, wwdblook, Menus, ppBands, ppCtrls, ppClass,
  ppViewr, ppPrnabl, ppCache, ppComm, ppReport, ppDevice, ppDB, ppDBBDE, ppProd,
  ppVar, ppTypes, ppDBPipe, ppRelatv, Variants, ADODB, ActnList, ImgList, Math,
  wwDataInspector, wwcheckbox, ppStrtch, ppRegion, ppSubRpt, Mask, uSumDlg;

type
  Tfinvfrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    lblInvoiceDateHeader: TLabel;
    Label3: TLabel;
    lblInvoiceNumberHeader: TLabel;
    lblSiteName: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblTaxHeader: TLabel;
    Label12: TLabel;
    lblInvoiceTotalHeader: TLabel;
    EditItemCount: TEdit;
    EditUnitCount: TEdit;
    EditSalesTax: TEdit;
    EditItemTotal: TEdit;
    EditInvoiceTotal: TEdit;
    DSInvoice: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    BtnDeleteItem: TBitBtn;
    BtnDeleteInvoice: TBitBtn;
    BtnInvoiceSearch: TBitBtn;
    btnNewInv: TBitBtn;
    BtnItemSearch: TBitBtn;
    btnNewItem: TBitBtn;
    btnShowSummary: TBitBtn;
    BtnPrintInvoice: TBitBtn;
    BtnClose: TBitBtn;
    EditNote: TEdit;
    Label14: TLabel;
    XwwDataSource2: TwwDataSource;   // if program runs OK this should be deleted
    ppRep: TppReport;
    ppRepHeaderBand1: TppHeaderBand;
    ppRepDetailBand1: TppDetailBand;
    ppRepLine4: TppLine;
    ppRepLine13: TppLine;
    ppRepLine14: TppLine;
    ppRepLine15: TppLine;
    ppRepLine16: TppLine;
    ppRepLine17: TppLine;
    ppRepLine18: TppLine;
    ppRepLine19: TppLine;
    ppRepLine20: TppLine;
    ppRepLine21: TppLine;
    ppRepDBText1: TppDBText;
    ppRepDBText2: TppDBText;
    ppRepDBText3: TppDBText;
    ppRepDBText4: TppDBText;
    ppRepDBText5: TppDBText;
    ppRepDBText6: TppDBText;
    ppRepDBText7: TppDBText;
    ppRepDBText8: TppDBText;
    ppRepFooterBand1: TppFooterBand;
    ppRepLabel9: TppLabel;
    ppRepLabel10: TppLabel;
    labsup: TppLabel;
    labno: TppLabel;
    labdate: TppLabel;
    ppRepLabel14: TppLabel;
    labsite: TppLabel;
    ppRepLabel16: TppLabel;
    ppRepLabel21: TppLabel;
    ppRepSum: TppSummaryBand;
    invpipe: TppBDEPipeline;
    sbDate: TSpeedButton;
    ppRepCalc1: TppSystemVariable;
    ppRepCalc2: TppSystemVariable;
    wwtPurchase: TADOTable;
    wwtPurchHead: TADOTable;
    PUnitsTab: TADOTable;
    wwqTot: TADOQuery;
    wwqGeneric: TADOQuery;
    wwtInvoice: TADOTable;
    wwqDelPurch: TADOQuery;
    wwqPUnit: TADOQuery;
    wwqFlavor: TADOQuery;
    tblInvoiceTemp: TADOTable;
    Panel4: TPanel;
    SortGroupBox: TGroupBox;
    naturalSortRB: TRadioButton;
    SubcatRetNameRB: TRadioButton;
    ImpExpRefRB: TRadioButton;
    DescTotCostRB: TRadioButton;
    AscDeliveryRB: TRadioButton;
    btnFreeItem: TBitBtn;
    qryGetEditLevel: TADOQuery;
    wwtInvoiceRecNo: TFloatField;
    wwtInvoiceItemID: TFloatField;
    wwtInvoiceItemName: TStringField;
    wwtInvoicePUnit: TStringField;
    wwtInvoiceFlavor: TStringField;
    wwtInvoiceUCost: TBCDField;
    wwtInvoiceTax: TStringField;
    wwtInvoiceQty: TFloatField;
    wwtInvoiceDataSource: TSmallIntField;
    wwtInvoiceItemCost: TBCDField;
    wwtInvoiceOU: TFloatField;
    wwtInvoiceItemTax: TBCDField;
    wwtInvoiceImpExpRef: TStringField;
    wwtInvoiceSubCatName: TStringField;
    Bevel1: TBevel;
    qInvalidSubcats: TADOQuery;
    wwtInvoiceReadOnly: TBooleanField;
    ActionList1: TActionList;
    DeleteInvoiceAction: TAction;
    ImageList1: TImageList;
    wwqDelPurchRef: TADOQuery;
    wwtPurchRef: TADOTable;
    btnFreeze: TBitBtn;
    ToggleFreezeAction: TAction;
    qryFrozenAndAmended: TADOQuery;
    lblFrozen: TLabel;
    wwtInvoiceMultiPurchQty: TFloatField;
    wwtInvoiceMultiPurchParentID: TFloatField;
    wwtInvoiceSortImpExpRef: TStringField;
    wwtInvoiceSortSubcat: TStringField;
    wwtInvoiceSortItemCost: TBCDField;
    wwtInvoiceSortItemName: TStringField;
    wwtInvoiceSortQty: TFloatField;
    wwtInvoiceReturnImage: TSmallintField;
    wwtInvoiceIngredItemCost: TBCDField;
    LegendPanel: TPanel;
    BottleImg: TImage;
    BottleLabel: TLabel;
    wwtInvoicePurchaseItemType: TSmallintField;
    qryMultiPurchQty: TADOQuery;
    wwtPurchParent: TADOTable;
    wwtPurchIngreds: TADOTable;
    wwqDelParent: TADOQuery;
    wwqDelIngreds: TADOQuery;
    wwtInvoiceGroupRecID: TFloatField;
    qGetIngreds: TADOQuery;
    qryReportItems: TADOQuery;
    DSReportItems: TwwDataSource;
    wwtInvoiceReturnable: TBooleanField;
    wwtInvoiceIngredQty: TFloatField;
    wwtInvoiceIngredOU: TFloatField;
    NewItemAction: TAction;
    NewInvoiceAction: TAction;
    ShowSummaryAction: TAction;
    DeleteItemAction: TAction;
    ItemSearchAction: TAction;
    InvoiceSearchAction: TAction;
    PrintInvoiceAction: TAction;
    FreeItemAction: TAction;
    SelectDateAction: TAction;
    ItemsHistoryPipe: TppDBPipeline;
    ItemsHistoryDS: TDataSource;
    qryReportItemsRecNo: TFloatField;
    qryReportItemsItemID: TFloatField;
    qryReportItemsItemName: TStringField;
    qryReportItemsPUnit: TStringField;
    qryReportItemsFlavor: TStringField;
    qryReportItemsUCost: TBCDField;
    qryReportItemsTax: TStringField;
    qryReportItemsQty: TFloatField;
    qryReportItemsItemCost: TBCDField;
    qryReportItemsOU: TFloatField;
    qryReportItemsItemTax: TBCDField;
    qryReportItemsImpExpRef: TStringField;
    qryReportItemsSubCatName: TStringField;
    SubReportItem: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppDetailBand3: TppDetailBand;
    ppRegion2: TppRegion;
    auditLMDT: TppDBText;
    auditModBy: TppDBText;
    AuditUCDiff: TppDBText;
    AuditQtyDiff: TppDBText;
    AuditICDiff: TppDBText;
    ppLine38: TppLine;
    ppLine39: TppLine;
    TaxColumnLine: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppLine48: TppLine;
    ppLine50: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppSummaryBand3: TppSummaryBand;
    ppLine54: TppLine;
    ItemsHistory: TADOQuery;
    drillDownItem: TppRegion;
    QryGetChangedItemFields: TADOQuery;
    HeaderHistory: TADOQuery;
    HeaderHistoryDS: TDataSource;
    HeaderHistoryPipe: TppDBPipeline;
    drillDownHeader: TppRegion;
    HdrHistLbl: TppLabel;
    SubReportHeader: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    HdrRegion: TppRegion;
    YellowShape: TppShape;
    ppRepLabel1: TppLabel;
    ppRepLabel2: TppLabel;
    ppRepLabel3: TppLabel;
    ppRepLabel4: TppLabel;
    ppRepLabel5: TppLabel;
    ppRepLabel6: TppLabel;
    ppRepLabel7: TppLabel;
    ppRepLabel8: TppLabel;
    ppRepLine2: TppLine;
    ppRepLine3: TppLine;
    ppRepLine5: TppLine;
    ppRepLine6: TppLine;
    ppRepLine7: TppLine;
    ppRepLine8: TppLine;
    ppRepLine9: TppLine;
    ppRepLine10: TppLine;
    ppRepLine11: TppLine;
    ppRepShape1: TppShape;
    ppRepLabel17: TppLabel;
    labtax: TppLabel;
    ppRepLabel19: TppLabel;
    labnote: TppLabel;
    ppLblFrozenOn: TppLabel;
    ppLblFrozenBy: TppLabel;
    ppFrozenOn: TppLabel;
    ppFrozenBy: TppLabel;
    ppLblAmendedOn: TppLabel;
    ppLblAmendedBy: TppLabel;
    ppAmendedOn: TppLabel;
    ppAmendedBy: TppLabel;
    ExpandLbl: TppLabel;
    ExpandAllShape: TppShape;
    CollapseLbl: TppLabel;
    CollapseAllShape: TppShape;
    ClickYellowLbl: TppLabel;
    ppRegion1: TppRegion;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppRegion3: TppRegion;
    hdrAuditLMDT: TppDBText;
    ppDBText4: TppDBText;
    hdrAuditDelNoteDate: TppDBText;
    ppDBText2: TppDBText;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    QryGetChangedHdrFields: TADOQuery;
    ItemsHistoryRecID: TFloatField;
    ItemsHistoryProduct: TFloatField;
    ItemsHistoryUnitCostDiff: TFloatField;
    ItemsHistoryQtyDiff: TFloatField;
    ItemsHistoryItemCostDiff: TFloatField;
    ItemsHistoryLMDT: TDateTimeField;
    ItemsHistoryModifiedBy: TStringField;
    ItemsHistoryChangeType: TSmallintField;
    LastAmendedLabel: TLabel;
    EditInvoiceNo: TMaskEdit;
    AuditLogQry: TADOQuery;
    GetChildrenQry: TADOQuery;
    DeletedItems: TADOQuery;
    DeletedItemsDS: TDataSource;
    DrillDownDeleted: TppRegion;
    SubReportCategory: TppSubReport;
    ppChildReport4: TppChildReport;
    SubReportDivision: TppSubReport;
    ppChildReport5: TppChildReport;
    ppTitleBand4: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppSummaryBand4: TppSummaryBand;
    ppShape2: TppShape;
    ppInvTotals: TppLabel;
    ppLine31: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLblTax: TppLabel;
    ppLblCostAndTax: TppLabel;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppLabel15: TppLabel;
    ppInvSummary: TppLabel;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppTitleBand5: TppTitleBand;
    ppDetailBand5: TppDetailBand;
    CategoryDS: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    categoryPipe: TppDBPipeline;
    ppDBText13: TppDBText;
    ppLine42: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppLine49: TppLine;
    ppLine55: TppLine;
    ppLine56: TppLine;
    ppLine57: TppLine;
    CtgTotalsPipe: TppDBPipeline;
    CtgTotalsDS: TDataSource;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    DivTotalsDS: TDataSource;
    DivisionPipe: TppDBPipeline;
    ppLabel9: TppLabel;
    ppLine58: TppLine;
    ppLabel16: TppLabel;
    ppLine59: TppLine;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLine67: TppLine;
    ppLine68: TppLine;
    ppLine69: TppLine;
    ppLine70: TppLine;
    ppLine71: TppLine;
    ppSummaryBand5: TppSummaryBand;
    ppLine72: TppLine;
    DelLabelRegion: TppRegion;
    DelLabel: TppLabel;
    ppLine73: TppLine;
    DeletedItemsRecID: TFloatField;
    DeletedItemsProduct: TFloatField;
    DeletedItemsUnitCostDiff: TFloatField;
    DeletedItemsQtyDiff: TFloatField;
    DeletedItemsItemCostDiff: TFloatField;
    DeletedItemsLMDT: TDateTimeField;
    DeletedItemsModifiedBy: TStringField;
    DeleteHistoryPipe: TppDBPipeline;
    SubReportDeletedItems: TppSubReport;
    ppChildReport3: TppChildReport;
    ppDetailBand2: TppDetailBand;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppDBText3: TppDBText;
    ppLine16: TppLine;
    ppDeleteQty: TppDBText;
    ppTitleBand3: TppTitleBand;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppShape3: TppShape;
    ppLabel1: TppLabel;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    DeletedItemsPurchaseName: TStringField;
    ppLine25: TppLine;
    ppDBText21: TppDBText;
    ppLabel14: TppLabel;
    ppLine26: TppLine;
    ppLabel7: TppLabel;
    ppDeleteAction: TppDBText;
    DeletedItemsChangeMade: TStringField;
    ppItemAction: TppDBText;
    LblStockOrderNo: TLabel;
    StockOrderNo: TLabel;
    wwtInvoiceExpectedQty: TFloatField;
    StockOrderLbl: TppLabel;
    labStockOrder: TppLabel;
    qryReportItemsGroupID: TIntegerField;
    invpipeppField14: TppField;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppRepLine1: TppLine;
    ppRepLine12: TppLine;
    procedure FormShow(Sender: TObject);
    procedure wwtInvoiceQtyChange(Sender: TField);
    procedure BtnCloseClick(Sender: TObject);
    procedure InsertItem(freeItem: Boolean);
    procedure wwDBGrid1ColEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwtInvoiceUcostChange(Sender: TField);
    procedure wwtInvoiceItemCostChange(Sender: TField);
    procedure wwtInvoiceIngredItemCostChange(Sender: TField);
    procedure FormActivate(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid1ColExit(Sender: TObject);
    procedure ppRepPreviewFormCreate(Sender: TObject);
    procedure GetTotals;
    procedure SaveInv;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure wwDBGrid1Exit(Sender: TObject);
    procedure EditNoteChange(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure wwtInvoiceAfterDelete(DataSet: TDataSet);
    procedure wwtInvoiceAfterInsert(DataSet: TDataSet);
    procedure wwtInvoiceAfterPost(DataSet: TDataSet);
    procedure wwtInvoiceAfterScroll(DataSet: TDataSet);
    procedure wwtInvoiceBeforeEdit(DataSet: TDataSet);
    procedure wwtInvoiceBeforeInsert(DataSet: TDataSet);
    procedure naturalSortRBClick(Sender: TObject);
    procedure ImpExpRefRBClick(Sender: TObject);
    procedure SubcatRetNameRBClick(Sender: TObject);
    procedure DescTotCostRBClick(Sender: TObject);
    procedure AscDeliveryRBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwtInvoiceUCostGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwtInvoiceItemCostGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwtInvoiceBeforePost(DataSet: TDataSet);
    procedure EditInvoiceNoChange(Sender: TObject);
    procedure ppRepBeforePrint(Sender: TObject);
    procedure wwtInvoiceCalcFields(DataSet: TDataSet);
    procedure DeleteInvoiceActionExecute(Sender: TObject);
    procedure DeleteInvoiceActionUpdate(Sender: TObject);
    procedure ToggleFreezeActionExecute(Sender: TObject);
    procedure ToggleFreezeActionUpdate(Sender: TObject);
    procedure wwtInvoiceBeforeScroll(DataSet: TDataSet);
    procedure wwDBGrid1FieldChanged(Sender: TObject; Field: TField);
    procedure wwtInvoiceIngredItemCostGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure NewItemActionExecute(Sender: TObject);
    procedure NewItemActionUpdate(Sender: TObject);
    procedure NewInvoiceActionExecute(Sender: TObject);
    procedure NewInvoiceActionUpdate(Sender: TObject);
    procedure ShowSummaryActionExecute(Sender: TObject);
    procedure ShowSummaryActionUpdate(Sender: TObject);
    procedure DeleteItemActionExecute(Sender: TObject);
    procedure DeleteItemActionUpdate(Sender: TObject);
    procedure ItemSearchActionExecute(Sender: TObject);
    procedure ItemSearchActionUpdate(Sender: TObject);
    procedure InvoiceSearchActionExecute(Sender: TObject);
    procedure InvoiceSearchActionUpdate(Sender: TObject);
    procedure PrintInvoiceActionExecute(Sender: TObject);
    procedure PrintInvoiceActionUpdate(Sender: TObject);
    procedure FreeItemActionExecute(Sender: TObject);
    procedure FreeItemActionUpdate(Sender: TObject);
    procedure SelectDateActionExecute(Sender: TObject);
    procedure SelectDateActionUpdate(Sender: TObject);
    procedure ppAuditValueGetText(Sender: TObject; var Text: String);
    procedure ExpandAllShapeDrawCommandClick(Sender, aDrawCommand: TObject);
    procedure CollapseAllShapeDrawCommandClick(Sender, aDrawCommand: TObject);
    procedure ppDeleteQtyGetText(Sender: TObject; var Text: String);
  private
    { Private declarations }
    howinsert : integer;
    lastcol: TField;
    lastPurchaseItemType: SmallInt;  // used in wwDBGrid1ColEnter for determining which field can be entered
    ParentQtyChanged: boolean;  // for recording that multipurchparent qty has been changed
    ChildUnitCostChanged: boolean; // for recording that multipurchingred unit cost has been changed
    ChildItemCostChanged: boolean; // for recording that multipurchingred item cost has been changed
    lastParent: double;            // used when multipurchingred unit or item cost has been changed
    lastGroupRecID: real;          //     ditto
    check, editing, scroll, deleting, asksave : boolean;
    OldQty: Real;
    ViewCostPrices, EditCostPrices, FreeItems, SendToTills: Boolean;
    NewInvoiceNo: string;
    CurrentInvoiceFrozen: boolean;
    FrozenDate: TDateTime;
    FrozenBy: string;
    CurrentInvoiceAmended: boolean;
    AmendedDate: TDateTime;
    AmendedBy: string;

    procedure SetFixedLabels;
    procedure GetStockOrderItems;
    procedure EnableSortGroupBox(AEnabled: Boolean);
    procedure doSortOrderCycle;
    procedure ToggleCostPriceHeaderFields;
    procedure EnableAllGridFields(AEnabled: boolean);
    procedure UpdateGridFieldsEnabled;
    procedure InitFrozenDetails;
    procedure SortTableForSupplier;
    procedure UpdateFormForSelectedInvoice;
    procedure UpdateFormForNewInvoice;
    procedure FocusOnGrid;
    procedure UpdateProductList;
    // Job 18923 - This is used to prevent editing of frozen invoices but to
    // allow users with edit privileges to search for and edit invoices that
    // have not been frozen.
    // Job 19213 - Changed to include AmendedDate and AmendedBy information
    procedure SetAmendedDetails;
    procedure UpdateFrozenAmended(theDate: TDateTime; changeType: smallint);
    procedure UnfreezeInvoice;
    procedure UpdateMultiPurchValues;
    procedure MoveItemsDown(InsertPosn: real; NumToInsert: integer);
    procedure MoveItemsUp(StartPosn: real; NumDeleted: integer);
    procedure SetInvoiceValuesAndPost(insertPosn, entcode: real; setValueToZero: boolean);
    procedure SetMultiPurchIngredientsAndPost(insertPosn, entcode: real; setValueToZero: boolean);
    function SubcatIsReadOnly(subcat: string): Boolean;
    function SaveCurrentInvoiceQuery: Boolean;

    function CostPricesAreReadOnly: boolean;
    function SaveInvoice: boolean;
    procedure DeleteTheInvoice(calledBy: String);
    procedure UpdateStockOrderStatus;
    procedure ExpandCollapse(var Msg: TMsg); message WM_USER + 3646;
    function SaveRequired: Boolean;
    function NewDateInAcceptedStock(newDate: TDate): Boolean;
  public
    { Public declarations }
    OneSupplier, promptuc, hideSort, insertAfter : boolean;
    invtot, thetax , searchrec: real;
    currentSortIndex: integer;
    theMaskID : Smallint;
    thedate : tdatetime;
    defunit,thesupplier, invoiceno, selitem, invoiceNoMask, theOrderNo : string;
    FromStockOrder: boolean;
    Task : integer; // add invoice : 0, edit invoice : 1,
                    // view current invoices : 2, view accepted : 3,
                    // audit invoice : 4
    S1 : TDatasetState;
    InvoiceHasAcceptedItems: Boolean;
    ReportExpanded: Boolean;
    procedure ModifyInvFormGridForLocale;
    procedure SetNumericFieldPrecision;
    procedure GetEditLevels;
    procedure GetAcceptedItemsExist;
    procedure GetFrozenAndAmended;
    procedure UpdateComponentsForTask;
    function HasAuditHistory: Boolean;
    procedure AddInitialAuditHistory;
    procedure LoadAuditHistory;
    procedure CreateTempAuditTable;
    procedure AddChangesToAuditLog(newRecID: Integer);
    procedure UpdateAuditDelNoteNo;
    procedure UpdateAuditItemRecIDs;
    procedure SetAuditDeletedItems(dateAsFloat: real);
    procedure DeleteInvoiceFromLog;
  end;

const
  TASK_ADD       = 0;
  TASK_EDIT      = 1;
  TASK_VIEW_CURR = 2;
  TASK_VIEW_ACC  = 3;
  TASK_AUDIT     = 4;
  TASK_AUDIT_ADD = 5;   // to indicate that a new invoice was created from AUDIT Mode

  SORT_SUBCAT       = 1;
  SORT_IMP_EXP      = 2;
  SORT_DESC_TOTAL   = 3;
  SORT_ASC_DELIVERY = 4;
  SORT_NATURAL      = 5;

  MULTI_PURCH_NONE   = 0;
  MULTI_PURCH_PARENT = 1;
  MULTI_PURCH_CHILD  = 2;

  CHANGE_TYPE_FROZEN  = 1;
  CHANGE_TYPE_AMENDED = 2;

  // special colours for displaying multipurchase items
  clMPParent = TColor($00B0B999);
  clMPChild  = TColor($00BDCCB5);

  // Values for howInsert which is used to determine where the InsertItem action
  // came from so that RecNo is calculated properly, e.g. FROM_DOWN_ARROW just gets
  // the highest recNo + 1 and FROM_INSERT_KEY will need to calculate RecNo so
  // that it will be stored above the selected record.
  FROM_NEW_OR_FREE_ITEM = 0;
  FROM_DOWN_ARROW = 1;
  FROM_INSERT_KEY = 2;

  // values for the change type of records in the PurchaseAuditLog.
  // Note that if any of these values are changed, the ADOQuery ItemHistory
  // has also to be changed and the changetype field in the PurchAuditLog
  // table will have to be updated to ensure that the old audit records are in sync.
  INVOICE_CREATE = 1;
  HEADER_CHANGE = 2;
  ADD_ITEM = 4;
  CHANGE_ITEM = 5;
  DELETE_CREATE_ITEM = 6;
  DELETE_CHANGED_ITEM = 7;
  DELETE_ITEM = 8;

var
  finvfrm: Tfinvfrm;

implementation

uses
  uNewItemDlg, uInvMenu, uChgDate, uGetInvDlg, uNewInvDlg, uADO, uGlobals, uLog,
  uSaveCostChange, uInvoiceManager;

{$R *.DFM}

procedure Tfinvfrm.FormCreate(Sender: TObject);
begin
  log.event('finvfrm; FormCreate');
  scroll := true;
  fnewitemdlg := tfnewitemdlg.Create(self);
end;

procedure Tfinvfrm.FormShow(Sender: TObject);
begin
  // set the labels etc. that are fixed by task and US/UK mode
  // - these only need to be set once, i.e. when the form has been opened
  //   from InvMenu
  SetFixedLabels;
  // set the form components and variables for the specific invoice and supplier
  if Task = TASK_ADD then
    UpdateFormForNewInvoice
  else
    UpdateFormForSelectedInvoice;
  self.WindowState := wsMaximized;
  screen.Cursor := crDefault;
end;

procedure Tfinvfrm.FormActivate(Sender: TObject);
begin
  if (Task = TASK_ADD) or (Task = TASK_AUDIT_ADD) then
  begin
    if FromStockOrder then
    begin
      wwtInvoice.Close;
      GetStockOrderItems;
      wwtInvoice.Open;
      wwdbgrid1.setactivefield('qty');
//      Refresh;
//      wwdbgrid1.RefreshDisplay;
//      Application.ProcessMessages;
    end
    else
    begin
      NewItemActionExecute(Sender);
    end;
  end;
end;

procedure Tfinvfrm.GetStockOrderItems;
begin
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO [Invoice]([RecNo], [ItemID], [ItemName], [PUnit], [Flavor], [UCost], [Qty], [ItemCost],');
      SQL.Add('                      [OU], [ExpectedQty], [ImpExp Ref], [SubCat Name], [PurchaseItemType],');
      SQL.Add('                      [Returnable], [SortImpExpRef], [SortSubcat], [SortItemName], [SortQty])');
      SQL.Add('SELECT a.RecNo, a.ItemID, a.ItemName, a.PUnit, a.Flavour, a.UnitCost, a.ExpectedQty as Qty, a.ExpectedQty * a.UnitCost,');
      SQL.Add('       a.OU, a.ExpectedQty, pu.[Import/Export Reference] as [ImpExp Ref], a.[SubCat Name], 0 as PurchaseItemType,');
      SQL.Add('       0 as Returnable, pu.[Import/Export Reference] as SortImpExpRef, a.SortSubcat, a.SortItemName, 0 as SortQty');
      SQL.Add('from');
      SQL.Add('(SELECT so.Supplier, so.[Line] as RecNo, so.[Product] as ItemID, pr.[Purchase Name] as ItemName,');
      SQL.Add('        so.[PurchaseUnit] as PUnit, so.[Flavour], so.[UnitCost], 0 as OU,');
      SQL.Add('        so.[Amount] as ExpectedQty, pr.[Sub-Category Name] as [SubCat Name], pr.[Sub-Category Name] as SortSubcat,');
      SQL.Add('        pr.[Purchase Name] as SortItemName');
      SQL.Add('FROM [StockOrderDetail] so, [Products] pr');
      SQL.Add('WHERE so.[OrderNo] = ' + QuotedStr(theOrderNo));
      SQL.Add('AND so.[FlavLine] = 0');
      SQL.Add('AND so.[Sitecode] = ' + IntToStr(SiteCode));
      SQL.Add('AND so.[Deleted] = 0');
      SQL.Add('AND ISNULL(so.Amount,0) <> 0');
      SQL.Add('AND so.[Product] = pr.EntityCode) a left outer join');
      SQL.Add('    PUnits pu on a.ItemID = pu.[Entity Code]');
      SQL.Add('AND a.[Supplier] = pu.[Supplier Name]');
      SQL.Add('AND a.[PUnit] = pu.[Unit Name]');
      SQL.Add('AND a.[Flavour] = pu.[Flavour]');
      ExecSQL;
      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - GetStockOrderItems: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;

  try
    // add records to #TmpItemAuditLog
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO #TmpItemAuditLog([NewRecID], [Product], [OldUnitCost], [NewUnitCost], ');
      SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost], [ChangeType])');
      SQL.Add('SELECT [RecNo], [ItemID], 0, [UCost], 0, [Qty], 0, 0, ' + IntToStr(ADD_ITEM));
      SQL.Add('FROM [Invoice]');
      ExecSQL;
    end;

  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - GetStockOrderItems: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

// Set labels, captions etc. that are fixed by US/UK mode and the task the form
// is initially opened in
procedure Tfinvfrm.SetFixedLabels;
begin
  SortGroupBox.Caption  := GetLocalisedName(lsInvoice) + ' Sort Order (F7)';
  SortGroupBox.Visible := not HideSort;

  if UKUSMode = 'US' then
  begin
    EditSalesTax.Text := FormatFloat('0.00', TheTax);
    wwtInvoiceFlavor.DisplayLabel := 'Flavor';
  end
  else
  begin
    wwtInvoiceFlavor.DisplayLabel := 'Flavour';

    //Tax is never applied in the UK (all calls to GetLocalisedItemTax have
    //UKTaxed param set as false) so do not show the tax label and edit box.
    lblTaxHeader.Visible := False;
    EditSalesTax.Visible := False;
  end;

  lblInvoiceDateHeader.Caption := GetLocalisedName(lsInvoice) + ' Date:';
  lblInvoiceNumberHeader.Caption := GetLocalisedName(lsInvoice) + ' No:';
  lblSiteName.Caption := SiteName;

  lblTaxHeader.Caption := GetLocalisedName(lsSalesTax) + ':';
  lblInvoiceTotalHeader.Caption := GetLocalisedName(lsInvoice) + ' Total:';

  InvoiceSearchAction.Caption := GetLocalisedName(lsInvoice) + #13 + 'Search';
  InvoiceSearchAction.Hint := 'Edit/View another ' + GetLocalisedName(lsInvoice);

  NewInvoiceAction.Caption := 'Ne&w' + #13 + GetLocalisedName(lsInvoice);
  NewInvoiceAction.Hint := 'Create another ' + GetLocalisedName(lsInvoice);

  DeleteInvoiceAction.Caption := '&Delete' + #13 + GetLocalisedName(lsInvoice);
  DeleteInvoiceAction.Hint := 'Delete the current ' + GetLocalisedName(lsInvoice);

  PrintInvoiceAction.Caption := '&Print' + #13 + GetLocalisedName(lsInvoice);
  PrintInvoiceAction.Hint := 'Print the current ' +  GetLocalisedName(lsInvoice) + ' (with summary)';
end;

procedure Tfinvfrm.UpdateFormForSelectedInvoice;
begin
  // initialise invoice "state" variables
  editing := false;
  check := true;
  scroll := true;
  deleting := false;

  // set variables, components that are supplier and/or invoice specific
  GetEditLevels;
  GetFrozenAndAmended;
  GetAcceptedItemsExist;
  UpdateComponentsForTask;
  CreateTempAuditTable;
  if not HasAuditHistory then
    AddInitialAuditHistory;
  LoadAuditHistory;
  InitFrozenDetails;
  label6.caption        := thesupplier;
  label7.caption        := formatDateTime('ddddd',thedate);
  EditInvoiceNo.Tag          := 1;    // Tag = 1 prevents OnChange from being called.
  EditInvoiceNo.EditMask := invoiceNoMask;
  EditInvoiceNo.Text         := invoiceno;
  EditInvoiceNo.Tag          := 0;
  NewInvoiceNo := InvoiceNo;

  FromStockOrder := not (theOrderNo = '');
  LblStockOrderNo.Visible := FromStockOrder;
  StockOrderNo.Caption := theOrderNo;

  SortTableForSupplier;

  // now the grid has been sorted, set focus on the quantity field of the first
  // record in the grid
  FocusOnGrid;
end;

procedure Tfinvfrm.UpdateFormForNewInvoice;
begin
  editing := false;
  check := true;
  scroll := true;
  deleting := false;

  GetEditLevels;
  CurrentInvoiceAmended := false;
  CurrentInvoiceFrozen := false;
  InvoiceHasAcceptedItems := false;
  lblFrozen.Caption := '';
  LastAmendedLabel.Caption := '';
  UpdateComponentsForTask;
  CreateTempAuditTable;

  label6.caption        := thesupplier;
  label7.caption        := formatDateTime('ddddd',thedate);
  EditInvoiceNo.Tag          := 1;    // Tag = 1 prevents OnChange from being called.
  EditInvoiceNo.EditMask := invoiceNoMask;
  EditInvoiceNo.Text         := invoiceno;
  EditInvoiceNo.Tag          := 0;
  NewInvoiceNo := InvoiceNo;

  FromStockOrder := not (theOrderNo = '');
  LblStockOrderNo.Visible := FromStockOrder;
  StockOrderNo.Caption := theOrderNo;

  FocusOnGrid;
end;

// Invoice opened for Edit/Audit or new Invoice created so
// refresh the product selection list
procedure Tfinvfrm.UpdateProductList;
begin
  if (Task = TASK_ADD) or
     (Task = TASK_AUDIT_ADD) or
     ((Task = TASK_EDIT) and not CurrentInvoiceFrozen) or
     (Task = TASK_AUDIT) then
  begin
    fnewitemdlg.UpdateVariables(theSupplier, FormatDateTime('yyyymmdd', thedate), Task);
    OneSupplier := true;
    fnewitemdlg.InitializeToggleSupplierAction; //(theSupplier, FormatDateTime('yyyymmdd', thedate), Task);
    Application.ProcessMessages;
  end;
end;

// get sort order for the supplier and sort the invoice table
procedure Tfinvfrm.SortTableForSupplier;
begin
  try
    with wwqGeneric do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT [Sort Order Prefix] FROM vwSupplier');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(theSupplier));
      Log.Event('finvfrm; FormShow: wwqGeneric opened: ' + wwqGeneric.SQL.Text);
      Open;
      currentSortIndex := FieldByName('Sort Order Prefix').AsInteger;
      case currentSortIndex of
        SORT_SUBCAT:       SubcatRetNameRB.OnClick(SubcatRetNameRB);
        SORT_IMP_EXP:      ImpExpRefRB.OnClick(ImpExpRefRB);
        SORT_DESC_TOTAL:   DescTotCostRB.OnClick(DescTotCostRB);
        SORT_ASC_DELIVERY: AscDeliveryRB.OnClick(AscDeliveryRB);
        SORT_NATURAL:      naturalSortRB.OnClick(naturalSortRB);
        else
            naturalSortRB.OnClick(naturalSortRB);
      end;

      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - SortTableForSupplier: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

// Set focus on the quantity field of the grid
procedure Tfinvfrm.FocusOnGrid;
begin
  case Task of
    TASK_ADD, TASK_AUDIT_ADD :
      begin
        wwDBGrid1.SetFocus;
        wwDBGrid1.SetActiveField('Qty');
      end;
    TASK_AUDIT :
      begin
        wwDBGrid1.SetFocus;
        OldQty := wwtInvoice.FieldByName('Qty').AsFloat;
        UpdateGridFieldsEnabled;
        wwDBGrid1.SetActiveField('Qty');
      end;
    TASK_EDIT :
      if not CurrentInvoiceFrozen then
      begin
        wwDBGrid1.SetFocus;
        OldQty := wwtInvoice.FieldByName('Qty').AsFloat;
        UpdateGridFieldsEnabled;
        wwDBGrid1.SetActiveField('Qty');
      end;
  end;
end;

procedure Tfinvfrm.ToggleCostPriceHeaderFields;
begin
  ppRepDBText4.Visible := ViewCostPrices;
  ppRepDBText7.Visible := ViewCostPrices;
  ppDBText10.Visible := ViewCostPrices;
  ppDBText11.Visible := ViewCostPrices;
  ppDBText12.Visible := ViewCostPrices;
  ppDBText16.Visible := ViewCostPrices;
  ppDBText17.Visible := ViewCostPrices;
  ppDBText18.Visible := ViewCostPrices;
  ppDBText20.Visible := ViewCostPrices;
  EditItemTotal.Enabled := ViewCostPrices;
  EditInvoiceTotal.Enabled := ViewCostPrices;
  if not ViewCostPrices then
  begin
    EditItemTotal.Font.Color := clInactiveCaption;
    EditInvoiceTotal.Font.Color := clInactiveCaption;
  end
  else
  begin
    EditItemTotal.Font.Color := clInactiveCaptionText;
    EditInvoiceTotal.Font.Color := clInactiveCaptionText;
  end;
end;

procedure TfInvFrm.InitFrozenDetails;
begin
  try
    with qryFrozenAndAmended do
    begin
      Close;
      Parameters.ParamByName('StCode').Value := SiteCode;
      Parameters.ParamByName('SuppName').Value := TheSupplier;
      Parameters.ParamByName('InvNum').Value := InvoiceNo;

      Log.Event('fInvFrm; InitFrozenDetails: qryFrozenAndAmended opened: ' + qryFrozenAndAmended.SQL.Text);
      Open;

      if FieldByName('Frozen').AsBoolean then
      begin
        lblFrozen.Caption := 'This ' + GetLocalisedName(lsInvoice) + ' was frozen on ' +
          FormatDateTime(TheDateFormat, FieldByName('FrozenOn').AsDateTime);
        ToggleFreezeAction.Caption := 'Unfreeze' + #13 + GetLocalisedName(lsInvoice);
      end
      else
      begin
        lblFrozen.Caption := '';
        ToggleFreezeAction.Caption := 'Freeze' + #13 + GetLocalisedName(lsInvoice);
      end;

      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fInvFrm; ERROR - InitFrozenDetails: ' + E.Message + '; ' + TheSupplier +
        ', ' + InvoiceNo);

      raise;
    end;
  end;
end;


//////////////////////////////////////////////////////////////////////////////
//
//          INSERT ITEM
//    .......................................................................
//
/////////////////////////////////////////////////////////////////////////////

procedure Tfinvfrm.InsertItem(freeItem: Boolean);

  function EndOfGrid: boolean;
  begin
    try
      with wwqGeneric do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT MAX(RecNo) AS LastRecNo FROM Invoice');
        Open;
        Result := (wwtInvoiceRecNo.Value = FieldByName('LastRecNo').Value);
      end;
    except
      on E: Exception do
      begin
        Log.Event('finvfrm; ERROR - InsertItem, EndOfGrid: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
        raise;
      end;
    end;
  end;

  function GetChildCount(groupID: real): integer;
  begin
    try
      with wwqGeneric do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select count(*)-1 as ChildCount from Invoice where GroupRecID = ' + FloatToStr(groupID));
        Open;
        Result := FieldByName('ChildCount').Value;
      end;
    except
      on E: Exception do
      begin
        Log.Event('finvfrm; ERROR - InsertItem, GetChildCount: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
        raise;
      end;
    end;
  end;

var
   f1, entcode : real;
   insertPosn: real;
begin
  insertPosn := 1;

  try
    // NewItemDlg now set ot screen centre
    fnewitemdlg.position := poScreenCenter;

    wwtinvoice.disablecontrols;
    if wwtinvoice.State = dsInsert then
      wwtinvoice.cancel;

    // if the currently selected item is a multi-purchase child and is not
    // the last item in the grid then do not allow insertion of a new
    // item
    if ((wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) and
        (not EndOfGrid)) then
    begin
      wwtInvoice.Cancel;
      exit;
    end;

    fnewitemdlg.selitem := selitem;

    // set the new record number...
    if wwtinvoice.RecordCount = 0 then
      insertPosn := 1
    else if howInsert = FROM_DOWN_ARROW then
    begin
      wwtInvoice.Sort := '[RecNo] ASC';
      wwtInvoice.Last;
      insertPosn := wwtinvoice.FieldByName('recno').asfloat + 1.0;
    end
    else if insertAfter then
    begin
      f1 := wwtinvoice.FieldByName('recno').asfloat;
      if (wwtInvoicePurchaseItemType.Value = MULTI_PURCH_PARENT) then
        insertPosn := f1 + GetChildCount(wwtInvoiceGroupRecID.Value) + 1.0
      else
        insertPosn := f1 + 1.0;
      wwtInvoice.Sort := '[RecNo] ASC';
    end
    else
    begin
      f1 := wwtinvoice.FieldByName('recno').asfloat;
      insertPosn := f1;
      wwtInvoice.Sort := '[RecNo] ASC';
    end;

//Job 17152
    // ensure that all fields are set to readOnly = false
    EnableAllGridFields(true);

    // get the item
    fnewitemdlg.Task := TASK_NEW_ITEM;

    if fnewitemdlg.showmodal = mrCancel then
    begin
      exit;
    end;

    entCode :=  fnewitemdlg.wwdatasource1.dataset.FieldByName('entity code').asfloat;

    if fnewitemdlg.wwDataSource1.DataSet.FieldByName('MultiPurchaseProduct').Value = 'Y' then
    begin
      SetMultiPurchIngredientsAndPost(insertPosn, entCode, freeItem);
    end
    else
    begin
      SetInvoiceValuesAndPost(insertPosn, entcode, freeItem);
    end;

  finally
    case currentSortIndex of
      SORT_SUBCAT:       SubcatRetNameRB.OnClick(SubcatRetNameRB);
      SORT_IMP_EXP:      ImpExpRefRB.OnClick(ImpExpRefRB);
      SORT_DESC_TOTAL:   DescTotCostRB.OnClick(DescTotCostRB);
      SORT_ASC_DELIVERY: AscDeliveryRB.OnClick(AscDeliveryRB);
      SORT_NATURAL:      naturalSortRB.OnClick(naturalSortRB);
      else
          naturalSortRB.OnClick(naturalSortRB);
    end;
    wwtinvoice.enablecontrols;

    wwtInvoice.Locate('RecNo', InsertPosn, []);
    wwdbgrid1.SetFocus;
    { TODO -owilma -ctidy up :
Don't see why an ingredient would be the selected record - it should be the
multi-purchase parent }
    if wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD then
      wwdbgrid1.SetActiveField('UCost')
    else
    begin
      wwtInvoiceQty.ReadOnly := false;
      wwdbgrid1.setactivefield('qty');
    end;
    if wwtinvoice.State = dsInsert then
       wwtinvoice.Cancel;
  end; // finally...
end;


// Decrease the RecID of all records from the start position to last to keep recIDs consecutive
procedure Tfinvfrm.MoveItemsUp(StartPosn: real; NumDeleted: integer);
var
  NewGroupID, OldGroupID, parentID: real;
  GroupSubcat: string;
begin
  try
    with wwtInvoice do
    begin
      Sort := '[RecNo] ASC';
      if not Locate('RecNo', StartPosn, []) then
        exit;
      while not Eof do
      begin
        Edit;
        FieldByName('RecNo').Value := FieldByName('RecNo').Value - NumDeleted;
        if (FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) then
        begin
          NewGroupID := FieldByName('RecNo').Value;
          OldGroupID := FieldByName('GroupRecID').Value;
          ParentID := FieldByName('ItemID').Value;
          GroupSubcat := FieldByName('SubCat Name').Value;
          FieldByName('SortSubcat').Value := GroupSubcat + FormatFloat('000.0',NewGroupID);
          FieldByName('GroupRecID').Value := NewGroupID;
          Post;

          with dmADO.adoqRun do
          begin
            Close;
            SQL.Clear;
            SQL.Add('Update Invoice');
            SQL.Add('Set GroupRecID = ' + FloatToStr(NewGroupID) + ',');
            SQL.Add('   SortSubcat = ' + QuotedStr(GroupSubcat + FormatFloat('000.0',NewGroupID)));
            SQL.Add('Where GroupRecID = ' + FloatToStr(OldGroupID));
            SQL.Add('And MultiPurchParentID = ' + FloatToStr(ParentID));
            ExecSQL;
          end;
        end
        else
          Post;

        Next;
      end;

      Requery([]);
    end;
  except
    On E: Exception do
    begin
      Log.Event('finvfrm; ERROR - MoveItemsUp: ' + E.Message + '; ' + wwtInvoice.TableName);
      raise;
    end;
  end;

  try
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update #TmpItemAuditLog');
      SQL.Add('Set NewRecID = NewRecID - ' + IntToStr(NumDeleted));
      SQL.Add('Where NewRecID >= ' + FloatToStr(StartPosn));
      ExecSQL;
    end;
  except
    On E: Exception do
    begin
      Log.Event('finvfrm; ERROR - MoveItemsUp: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;

end;

// Increase the RecID of all records after the insert position to prevent key violations
procedure Tfinvfrm.MoveItemsDown(InsertPosn: real; NumToInsert: integer);
var
  NewGroupID, OldGroupID, parentID: real;
  GroupSubcat: string;
begin
  if wwtInvoice.RecordCount < 1 then
    Exit;

  try
    with wwtInvoice do
    begin
      Last;
      while not ((FieldByName('RecNo').Value < InsertPosn) or BOF) do
      begin
        Edit;
        FieldByName('RecNo').Value := FieldByName('RecNo').Value + NumToInsert;
        if (FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) then
        begin
          NewGroupID := FieldByName('RecNo').Value;
          OldGroupID := FieldByName('GroupRecID').Value;
          ParentID := FieldByName('ItemID').Value;
          GroupSubcat := FieldByName('SubCat Name').Value;
          FieldByName('SortSubcat').Value := GroupSubcat + FormatFloat('000.0',NewGroupID);
          FieldByName('GroupRecID').Value := NewGroupID;
          Post;

          with dmADO.adoqRun do
          begin
            Close;
            SQL.Clear;
            SQL.Add('Update Invoice');
            SQL.Add('Set GroupRecID = ' + FloatToStr(NewGroupID) + ',');
            SQL.Add('   SortSubcat = ' + QuotedStr(GroupSubcat + FormatFloat('000.0',NewGroupID)));
            SQL.Add('Where GroupRecID = ' + FloatToStr(OldGroupID));
            SQL.Add('And MultiPurchParentID = ' + FloatToStr(ParentID));
            ExecSQL;
          end;
        end
        else
          Post;

        Prior;
      end;

      Requery([]);
    end;
  except
    On E: Exception do
    begin
      Log.Event('finvfrm; ERROR - MoveItemsDown: ' + E.Message + '; ' + wwtInvoice.TableName);
      raise;
    end;
  end;

  try
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update #TmpItemAuditLog');
      SQL.Add('Set NewRecID = NewRecID + ' + IntToStr(NumToInsert));
      SQL.Add('Where NewRecID >= ' + FloatToStr(InsertPosn));
      ExecSQL;
    end;
  except
    On E: Exception do
    begin
      Log.Event('finvfrm; ERROR - MoveItemsDown: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.SetMultiPurchIngredientsAndPost(insertPosn, entcode: real; setValueToZero: boolean);

  function getGroupID(currRecID, selRecID: real; childCount: smallint): real;
  var
    newID, f3: real;
    i: Integer;
  begin
    newID := currRecID;
    f3 := newID;
    for i := 1 to ChildCount + 1 do
    begin
      newID := ((f3 - selRecID)/2) + selRecID;
      f3 := newID;
    end;
    result := f3;
  end;

var
  f1: real;
  NumToInsert: integer;
begin
  try
    f1 := insertPosn;
    // Get MultiPurchaseProduct children
    with GetChildrenQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT ''-- '' + p.[Purchase Name] AS PurchaseName, mp.[Entity Code],');
      SQL.Add('p.[Whether Sales Taxable], mpi.UnitName, mp.Flavour, mp.[Unit Cost], p.[Sub-Category Name],');
      SQL.Add('mp.[Import/Export Reference], mp.MultiPurchParent, mp.Returnable,');
      SQL.Add('NULL AS GroupRecID, NULL AS SortImpExpRef, p2.[Sub-Category Name] AS SortSubcat,');
      SQL.Add('0 AS SortItemCost, p2.[Purchase Name] AS SortItemName, 0 AS SortQty, mpi.DisplayOrder');
      SQL.Add('FROM Products p INNER JOIN');
      SQL.Add('  MultiPurchSupplierIngreds mp ON mp.[Entity Code] = p.EntityCode INNER JOIN');
      SQL.Add('  Products p2 ON mp.MultiPurchParent = p2.EntityCode INNER JOIN');
      SQL.Add('  MultiPurchIngredients mpi ON mp.MultiPurchParent = mpi.EntityCode');
      SQL.Add('  AND mp.[Entity Code] = mpi.IngredientCode');
      SQL.Add('WHERE mp.[Supplier Name] = ' + QuotedStr(fnewitemdlg.wwDataSource1.DataSet.FieldByName('Supplier Name').AsString));
      SQL.Add('AND mp.MultiPurchParent = ' + FloatToStr(entCode));
      SQL.Add('AND ( (mp.flavour = ' + QuotedStr(fnewitemdlg.wwDataSource1.DataSet.FieldByName('Flavour').AsString) + ' AND ISNULL(mp.Returnable, 0) = 0)');
      SQL.Add('OR ( (ISNULL(mp.Returnable, 0) = 1)');
      SQL.Add('AND ( (mp.flavour = ' + QuotedStr(fnewitemdlg.wwDataSource1.DataSet.FieldByName('Flavour').AsString) + ')');
      SQL.Add('OR ( ISNULL(mp.flavour,'''') = ''''');
      SQL.Add('AND mp.[Entity Code] NOT IN');
      SQL.Add('( SELECT a1.[Entity Code]');
      SQL.Add('FROM');
      SQL.Add('( SELECT DISTINCT mp.[Entity Code], mp.Flavour');
      SQL.Add('  FROM MultiPurchSupplierIngreds mp');
      SQL.Add('  INNER JOIN MultiPurchIngredients mpi');
      SQL.Add('  ON mp.MultiPurchParent = mpi.EntityCode');
      SQL.Add('  AND mp.[Entity Code] = mpi.IngredientCode');
      SQL.Add('  WHERE mp.[Supplier Name] = ' + QuotedStr(fnewitemdlg.wwDataSource1.DataSet.FieldByName('Supplier Name').AsString));
      SQL.Add('  AND mp.MultiPurchParent = ' + FloatToStr(entCode));
      SQL.Add('  AND ISNULL(mp.Returnable, 0) = 1');
      SQL.Add('  AND (mp.flavour = ' + QuotedStr(fnewitemdlg.wwDataSource1.DataSet.FieldByName('Flavour').AsString) + ' OR ISNULL(mp.flavour,'''') = '''')');
      SQL.Add(') a1');
      SQL.Add('GROUP BY a1.[Entity Code]');
      SQL.Add('HAVING COUNT(a1.Flavour) > 1 )))))');
      SQL.Add('ORDER BY mpi.DisplayOrder');

      Open;

      NumToInsert := RecordCount + 1;    // number of children plus 1 for the parent
      MoveItemsDown(insertPosn, NumToInsert);  // update the recID of all subsequent records

      // Insert the MultiPurchaseParent record
      check := false;
      wwtInvoice.Insert;
      wwtInvoiceItemName.ReadOnly := false;
      wwtInvoiceFlavor.ReadOnly := false;
      wwtInvoiceQty.ReadOnly := false;
      wwtInvoiceItemCost.ReadOnly := false;
      wwtInvoiceMultiPurchQty.ReadOnly := false;
      wwtInvoiceRecNo.ReadOnly := false;
      wwtInvoiceItemID.ReadOnly := false;
      wwtInvoiceSubCatName.ReadOnly := false;
      wwtInvoicePurchaseItemType.ReadOnly := false;
      wwtInvoiceMultiPurchParentID.ReadOnly := false;
      wwtInvoiceGroupRecID.ReadOnly := false;
      wwtInvoiceSortSubcat.ReadOnly := false;
      wwtInvoiceSortItemCost.ReadOnly := false;
      wwtInvoiceSortItemName.ReadOnly := false;
      wwtInvoiceSortQty.ReadOnly := false;

      wwtInvoiceItemName.Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('purchase name').asstring + ' : ';
      // Set parent flavour to blank - this is to be consistent with what appears on the screen when
      // a delivery note is loaded for edit/audit/view - the flavour is not stored in PurchMultiPurchParent
      // so the parent flavour is blank.
      wwtInvoiceFlavor.Value := '';
      wwtInvoice.FieldByName('OU').ReadOnly := false;
      wwtInvoiceOU.Value := 0;    // must set OU value before setting qty as qty change will set OU readonly to true
      wwtInvoiceExpectedQty.ReadOnly := false;
      wwtInvoiceExpectedQty.Value := 0;
      wwtInvoiceExpectedQty.ReadOnly := true;
      wwtInvoiceQty.Value := 0;
      wwtInvoiceItemCost.Value := 0;
      wwtInvoiceMultiPurchQty.Value := 0;
      wwtInvoiceRecNo.Value := f1;
      wwtInvoiceItemID.Value := entcode;
      wwtInvoiceSubCatName.Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('Sub-Category Name').asstring;
      wwtInvoicePurchaseItemType.Value := MULTI_PURCH_PARENT;
      wwtInvoiceMultiPurchParentID.Value := entCode;
      wwtInvoiceGroupRecID.Value := insertPosn;
      wwtInvoiceSortSubcat.Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('Sub-Category Name').asstring + FormatFloat('000.0',insertPosn);
      wwtInvoiceSortItemCost.Value := 0;
      wwtInvoiceSortItemName.Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('purchase name').asstring;
      wwtInvoiceSortQty.Value := 0;
      if setValueToZero then
        Log.Event('finvfrm; SetMultiPurchIngredientsAndPost: New Free Item ' + wwtInvoiceItemName.Value + ' added')
      else
        Log.Event('finvfrm; SetMultiPurchIngredientsAndPost: New Item ' + wwtInvoiceItemName.Value + ' added');
      wwtInvoice.Post;

      first;     // GetChildrenQry

      // Insert MultiPurchaseProduct children
      while not Eof do
      begin
        f1 := f1 + 1;
        check := false;
        wwtinvoice.insert;
        wwtinvoice.FieldByName('ucost').ReadOnly := false;
        wwtinvoice.FieldByName('recno').ReadOnly := false;
        wwtinvoice.FieldByName('itemname').ReadOnly := false;
        wwtinvoice.FieldByName('itemid').ReadOnly := false;
        wwtInvoice.FieldByName('tax').ReadOnly := false;
        wwtInvoice.FieldByName('punit').ReadOnly := false;
        wwtInvoice.FieldByName('flavor').ReadOnly := false;
        wwtInvoice.FieldByName('SubCat Name').ReadOnly := false;
        wwtInvoice.FieldByName('ImpExp Ref').ReadOnly := false;
        wwtInvoice.FieldByName('PurchaseItemType').ReadOnly := false;
        wwtInvoice.FieldByName('IngredQty').ReadOnly := false;
        wwtinvoice.FieldByName('ucost').ReadOnly := false;
        wwtInvoice.FieldByName('MultiPurchParentID').ReadOnly := false;
        wwtInvoice.FieldByName('Returnable').ReadOnly := false;
        wwtInvoice.FieldByName('GroupRecID').ReadOnly := false;
        wwtInvoice.FieldByName('SortImpExpRef').ReadOnly := false;
        wwtInvoice.FieldByName('SortSubcat').ReadOnly := false;
        wwtInvoice.FieldByName('SortItemCost').ReadOnly := false;
        wwtInvoice.FieldByName('SortItemName').ReadOnly := false;
        wwtInvoice.FieldByName('SortQty').ReadOnly := false;


        wwtinvoice.FieldByName('recno').Value := f1;
        wwtinvoice.FieldByName('itemname').asstring := FieldByName('PurchaseName').asstring;
        wwtinvoice.FieldByName('itemid').asfloat := fieldByName('Entity Code').AsFloat;
        wwtInvoice.FieldByName('tax').asstring := FieldByName('whether sales taxable').asstring;
        wwtInvoice.FieldByName('punit').asstring := FieldByName('UnitName').AsString;
        wwtInvoice.FieldByName('flavor').asstring := FieldByName('Flavour').AsString;
        wwtInvoice.FieldByName('SubCat Name').AsString := FieldByName('Sub-Category Name').asstring;
        wwtInvoice.FieldByName('ImpExp Ref').AsString := FieldByName('Import/Export Reference').asstring;
        wwtInvoice.FieldByName('PurchaseItemType').Value := MULTI_PURCH_CHILD;
        if setValueToZero then
          wwtinvoice.FieldByName('ucost').value := 0.0
        else
          wwtinvoice.FieldByName('ucost').value := FieldByName('Unit Cost').Value;
        wwtInvoice.FieldByName('MultiPurchParentID').AsFloat := FieldByName('MultiPurchParent').AsFloat;
        wwtInvoice.FieldByName('Returnable').Value := FieldByName('Returnable').Value;
        wwtInvoice.FieldByName('GroupRecID').Value := InsertPosn;
        wwtInvoice.FieldByName('SortImpExpRef').Value := FieldByName('SortImpExpRef').Value;
        wwtInvoice.FieldByName('SortSubcat').Value := FieldByName('SortSubcat').Value + FormatFloat('000.0',InsertPosn);;
        wwtInvoice.FieldByName('SortItemCost').Value := FieldByName('SortItemCost').Value;
        wwtInvoice.FieldByName('SortItemName').Value := FieldByName('SortItemName').Value;
        wwtInvoice.FieldByName('SortQty').Value := FieldByName('SortQty').Value;
        wwtinvoice.Post;

        // add record to #TmpItemAuditLog
        try
          with AuditLogQry do
          begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO #TmpItemAuditLog([NewRecID], [Product], [OldUnitCost], [NewUnitCost], ');
            SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost], [ChangeType])');
            SQL.Add('VALUES(' + wwtInvoiceRecNo.AsString + ',');
            SQL.Add(wwtInvoiceItemID.AsString + ',');
            if VarIsNull(wwtInvoice.FieldByName('ucost').Value) then
              SQL.Add('0,Null,')
            else
              SQL.Add('0,' + wwtinvoice.FieldByName('ucost').AsString + ',');
            SQL.Add('0,0,0,0,' + IntToStr(ADD_ITEM) + ')');
            ExecSQL;
          end;
        except
          on E: Exception do
          begin
            Log.Event('finvfrm; ERROR - SetMultiPurchIngredientsAndPost: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
            raise;
          end;
        end;

        Next;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - SetMultiPurchIngredientsAndPost: ' + E.Message + '; ' + GetChildrenQry.SQL.Text);
      raise;
    end;
  end;
end;


procedure Tfinvfrm.SetInvoiceValuesAndPost(insertPosn, entcode: real; setValueToZero: boolean);
begin
  MoveItemsDown(insertPosn, 1);
  // set field values and post
  check := false;
  wwtinvoice.insert;
  wwtinvoice.FieldByName('recno').ReadOnly := false;
  wwtinvoice.FieldByName('itemname').ReadOnly := false;
  wwtinvoice.FieldByName('itemid').ReadOnly := false;
  wwtInvoice.FieldByName('tax').ReadOnly := false;
  wwtInvoice.FieldByName('punit').ReadOnly := false;
  wwtInvoice.FieldByName('flavor').ReadOnly := false;
  wwtinvoice.FieldByName('ucost').ReadOnly := false;
  wwtInvoice.FieldByName('ItemCost').ReadOnly := false;
  wwtinvoice.FieldByName('ucost').ReadOnly := false;
  wwtInvoice.FieldByName('SubCat Name').ReadOnly := false;
  wwtInvoice.FieldByName('ImpExp Ref').ReadOnly := false;
  wwtInvoice.FieldByName('PurchaseItemType').ReadOnly := false;
  wwtInvoice.FieldByName('SortImpExpRef').ReadOnly := false;
  wwtInvoice.FieldByName('SortSubcat').ReadOnly := false;
  wwtInvoice.FieldByName('SortItemCost').ReadOnly := false;
  wwtInvoice.FieldByName('SortItemName').ReadOnly := false;
  wwtInvoice.FieldByName('SortQty').ReadOnly := false;

  wwtinvoice.FieldByName('recno').asfloat := insertPosn;
  wwtinvoice.FieldByName('itemname').asstring :=
       fnewitemdlg.wwdatasource1.dataset.FieldByName('purchase name').asstring;
  wwtinvoice.FieldByName('itemid').asfloat := entcode;
  wwtInvoice.FieldByName('tax').asstring :=
       fnewitemdlg.wwdatasource1.dataset.FieldByName('whether sales taxable').asstring;
  wwtInvoice.FieldByName('punit').asstring := fnewitemdlg.wwDataSource1.DataSet.FieldByName('Unit Name').AsString;
  wwtInvoice.FieldByName('flavor').asstring := fnewitemdlg.wwDataSource1.DataSet.FieldByName('Flavour').AsString;
  if setValueToZero then
  begin
    wwtinvoice.FieldByName('ucost').value := 0;
    wwtInvoice.FieldByName('ItemCost').Value := 0;
  end
  else
  begin
    wwtinvoice.FieldByName('ucost').value := fnewitemdlg.wwDataSource1.DataSet.FieldByName('Unit Cost').Value;
    wwtInvoice.FieldByName('SubCat Name').AsString := fnewitemdlg.wwdatasource1.dataset.FieldByName('Sub-Category Name').asstring;
  end;
  wwtInvoiceExpectedQty.ReadOnly := false;
  wwtInvoiceExpectedQty.Value := 0;
  wwtInvoiceExpectedQty.ReadOnly := true;
  wwtInvoice.FieldByName('ImpExp Ref').AsString := fnewitemdlg.wwdatasource1.dataset.FieldByName('Import/Export Reference').asstring;
  wwtInvoice.FieldByName('PurchaseItemType').Value := 0;
  wwtInvoice.FieldByName('SortSubcat').Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('Sub-Category Name').asstring;
  wwtInvoice.FieldByName('SortItemCost').Value := 0;
  wwtInvoice.FieldByName('SortItemName').Value := fnewitemdlg.wwdatasource1.dataset.FieldByName('purchase name').asstring;
  wwtInvoice.FieldByName('SortQty').Value := 0;
  if setValueToZero then
    Log.Event('finvfrm; SetInvoiceValuesAndPost: New Free Item ' + wwtInvoiceItemName.Value + ' added')
  else
    Log.Event('finvfrm; SetInvoiceValuesAndPost: New Item ' + wwtInvoiceItemName.Value + ' added');
  wwtinvoice.Post;
  try
    // add record to #TmpItemAuditLog
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO #TmpItemAuditLog([NewRecID], [Product], [OldUnitCost], [NewUnitCost], ');
      SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost], [ChangeType])');
      SQL.Add('VALUES(' + wwtInvoiceRecNo.AsString + ',');
      SQL.Add(wwtInvoiceItemID.AsString + ',');
      if VarIsNull(wwtInvoice.FieldByName('ucost').Value) then
        SQL.Add('0,Null,')
      else
        SQL.Add('0,' + wwtinvoice.FieldByName('ucost').AsString + ',');
      SQL.Add('0,0,0,0,' + IntToStr(ADD_ITEM) + ')');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - SetInvoiceValuesAndPost: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

function Tfinvfrm.CostPricesAreReadOnly: Boolean;
begin
  Result := not ( (Task in [TASK_AUDIT, TASK_AUDIT_ADD]) or
                  (EditCostPrices and ViewCostPrices) );
end;

procedure Tfinvfrm.wwtInvoiceQtyChange(Sender: TField);
var
  newQty: double;
begin
  if not editing then
    exit;
  try
    if (sender.AsString <> '') then
    begin
      case wwtInvoicePurchaseItemType.Value of
        MULTI_PURCH_NONE:
          begin
            try
              // save change to #TmpItemAuditLog
              with AuditLogQry do
              begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE [#TmpItemAuditLog]');
                SQL.Add('SET [NewQty]= ' + Sender.AsString);
                SQL.Add('WHERE [NewRecID] = ' + wwtInvoiceRecNo.AsString);
                ExecSQL;
              end;
            except
              on E: Exception do
              begin
                Log.Event('finvfrm; ERROR - wwtInvoiceQtyChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
                raise;
              end;
            end;

            if wwtInvoiceSortQty.ReadOnly then wwtInvoiceSortQty.ReadOnly := false;
            if (Sender.AsFloat < 0) then
              wwtInvoiceSortQty.Value := SimpleRoundTo(Abs(Sender.AsFloat),-2) * -1
            else
              wwtInvoiceSortQty.Value := SimpleRoundTo(Sender.AsFloat, -2);
            if (wwtinvoiceucost.asstring <> '') then
            begin
              if wwtInvoiceItemCost.ReadOnly then wwtInvoiceItemCost.ReadOnly := false;
              if wwtInvoiceSortItemCost.ReadOnly then wwtInvoiceSortItemCost.ReadOnly := false;
              if (Sender.AsFloat < 0) then
                wwtInvoiceItemCost.AsFloat := (SimpleRoundTo(Abs(Sender.AsFloat),-2) * -1) * wwtInvoiceUCost.AsFloat
              else
                wwtinvoiceitemcost.AsFloat := SimpleRoundTo(Sender.AsFloat, -2) * wwtinvoiceucost.asfloat;
              wwtInvoiceSortItemCost.Value := wwtInvoiceItemCost.Value;
              // item tax

              if wwtInvoiceTax.Visible then
              begin
                if wwtInvoiceItemTax.ReadOnly then wwtInvoiceItemTax.ReadOnly := false;
                if (wwtInvoice.FieldByName('tax').asstring = 'Y') then
                  wwtinvoiceitemtax.asfloat := GetLocalisedItemTax(wwtinvoiceitemcost.asfloat,theTax, False)
                else
                  wwtinvoiceitemtax.asfloat := 0.0;
              end;
              // update the Over/Under value
              wwtInvoiceOU.ReadOnly := False;
              if FromStockOrder then
                wwtInvoiceOU.Value := Sender.AsFloat - wwtInvoiceExpectedQty.AsFloat
              else
                wwtInvoiceOU.Value := Sender.AsFloat;
              wwtInvoiceOU.ReadOnly := True;

              gettotals;
              // reset the readonly properties as necessary
              wwtInvoiceItemCost.ReadOnly := CostPricesAreReadOnly;
            end;
          end;
        MULTI_PURCH_PARENT:
          begin
            if (Sender.AsFloat < 0) then
              newQty := SimpleRoundTo(Abs(Sender.AsFloat), -2) * -1
            else
              newQty := SimpleRoundTo(Sender.AsFloat, -2);
            // get children and updatechanges(?) for each and change oldQty
            with qGetIngreds do
            begin
              Close;
              Parameters.ParamByName('grpID').Value := wwtInvoiceGroupRecID.Value;
              try
                Open;
              except
                on E: Exception do
                begin
                  Log.Event('finvfrm; ERROR - wwtInvoiceQtyChange: ' + E.Message + '; ' + qGetIngreds.SQL.Text);
                  raise;
                end;
              end;

              First;
              while not Eof do
              begin
                try
                  // save Qty change to #TmpItemAuditLog
                  with AuditLogQry do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE [#TmpItemAuditLog]');
                    SQL.Add('SET [NewQty]= ' + Sender.AsString + ',');
                    SQL.Add('    [NewItemCost]= ' + FloatToStr(newQty) + '*NewUnitCost');
                    SQL.Add('WHERE [NewRecID] = ' + qGetIngreds.FieldByName('RecNo').AsString);
                    ExecSQL;
                  end;
                except
                  on E: Exception do
                  begin
                    Log.Event('finvfrm; ERROR - wwtInvoiceQtyChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
                    raise;
                  end;
                end;
                OldQty := qGetIngreds.FieldByName('IngredQty').AsFloat;
                Next;
              end;
              Close;
            end;

            try
              with wwqGeneric do
              begin
                Close;
                SQL.Clear;
                // update the qty, itemcost and OU values of the MultiPurchase ingredient items
                SQL.Add('UPDATE INVOICE');
                SQL.Add('SET IngredQty = ' + FloatToStr(newQty) + ',');
                SQL.Add('    IngredItemCost = ' + FloatToStr(newQty) + '*UCost,');
                if FromStockOrder then
                  SQL.Add('    IngredOU = (' + FloatToStr(newQty) + ' - ISNULL(ExpectedQty,0))')
                else
                  SQL.Add('    IngredOU = ' + FloatToStr(newQty));
                SQL.Add('FROM [Invoice]');
                SQL.Add('WHERE [MultiPurchParentID] = ' + FloatToStr(wwtInvoiceMultiPurchParentID.AsFloat));
                SQL.Add('AND PurchaseItemType = 2');
                SQL.Add('AND GroupRecID = ' + FloatToStr(wwtInvoiceGroupRecID.AsFloat));
                ExecSQL;
                Close;
                // Update the item cost of the MultiPurchase parent item (sum of ingredient item costs)
                SQL.Clear;
                SQL.Add('UPDATE INVOICE');
                SQL.Add('SET ItemCost = b.NewItemCost from');
                SQL.Add('  Invoice a,');
                SQL.Add('  (select distinct GroupRecID, sum([IngredItemCost]) AS NewItemCost');
                SQL.Add('   from Invoice');
                SQL.Add('   where MultiPurchParentID = ' + FloatToStr(wwtInvoiceMultiPurchParentID.AsFloat));
                SQL.Add('   and PurchaseItemType = 2');
                SQL.Add('   group by GroupRecID) b');
                SQL.Add('WHERE a.GroupRecID = b.GroupRecID');
                SQL.Add('AND a.GroupRecID = ' + FloatToStr(wwtInvoiceGroupRecID.AsFloat));
                SQL.Add('AND a.PurchaseItemType = 1');
                ExecSQL;
                Close;
                // Update the sortQty and sortItemCost values of the MultiPurchase Ingredient items
                SQL.Clear;
                SQL.Add('UPDATE INVOICE');
                SQL.Add('SET SortQty = ' + FloatToStr(newQty) + ',');
                SQL.Add('    SortItemCost = b.ItemCost FROM');
                SQL.Add('  Invoice a,');
                SQL.Add('  (SELECT DISTINCT ItemID, Qty, ItemCost, GroupRecID');
                SQL.Add('   FROM Invoice');
                SQL.Add('   WHERE ItemID = ' + FloatToStr(wwtInvoiceMultiPurchParentID.AsFloat));
                SQL.Add('   AND GroupRecID = ' + FloatToStr(wwtInvoiceGroupRecID.AsFloat));
                SQL.Add('   AND PurchaseItemType = 1) b');
                SQL.Add('WHERE a.MultiPurchParentID = b.ItemID');
                SQL.Add('AND a.GroupRecID = b.GroupRecID');
                ExecSQL;
                Close;

                // Update the tax values of the MultiPurchase ingredient items
                SQL.Clear;
                SQL.Add('SELECT *');
                SQL.Add('FROM Invoice a');
                SQL.Add('WHERE a.MultiPurchParentID = ' + FloatToStr(wwtInvoiceMultiPurchParentID.AsFloat));
                SQL.Add('AND a.PurchaseItemType = 2');
                SQL.Add('AND a.GroupRecID = ' + FloatToStr(wwtInvoiceGroupRecID.AsFloat));
                Open;
                if wwtInvoiceTax.Visible then
                begin
                  wwqGeneric.First;
                  while not wwqGeneric.Eof do
                  begin
                    wwqGeneric.Edit;
                    if (wwqGeneric.FieldByName('tax').asstring = 'Y') then
                      wwqGeneric.FieldByName('itemtax').AsFloat := GetLocalisedItemTax(wwqGeneric.FieldByName('IngredItemCost').asfloat, theTax, False)
                    else
                      wwqGeneric.FieldByName('itemtax').asfloat := 0.0;
                    wwqGeneric.Post;
                    wwqGeneric.Next;
                  end;
                end;
                Close;
              end;
            except
              on E: Exception do
              begin
                Log.Event('finvfrm; ERROR - wwtInvoiceQtyChange: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
                raise;
              end;
            end;
            // update the Over/Under value
            wwtInvoiceOU.ReadOnly := False;
            if FromStockOrder then
              wwtInvoiceOU.Value := Sender.AsFloat - wwtInvoiceExpectedQty.AsFloat
            else
              wwtInvoiceOU.Value := Sender.AsFloat;
            wwtInvoiceOU.ReadOnly := True;
            // this is to allow wwtInvoice to be refreshed in the AfterScroll event handler
            // without causing recursion to this procedure
            ParentQtyChanged := true;
          end;
      end;
    end;
  except
    // log any non-sql exceptions
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtQtyChange: ' + E.Message);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.BtnCloseClick(Sender: TObject); // close button
begin
  log.event('finvfrm; Close button pressed');
  Close;
end;


procedure Tfinvfrm.wwDBGrid1ColEnter(Sender: TObject);
begin
  lastcol := wwdbgrid1.GetActiveField;
end;


procedure Tfinvfrm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ActiveControl = wwdbgrid1 then
    if wwdbgrid1.GetActiveCol = 7 then
       if key = VK_RETURN then
          key := VK_DOWN;

  if key = VK_F7 then
  begin
    doSortOrderCycle;
  end;

  if key = VK_INSERT then
    if (wwtInvoicePurchaseItemType.Value = MULTI_PURCH_CHILD) then
      key := VK_NONAME;  // don't allow insert if selected record is a multi-purchase child

  if key = VK_DELETE then
  begin
    key := VK_NONAME; //re-assign the key value to avoid default (keyboard) delete functionality.
    DeleteItemAction.Execute;
  end;
end;

procedure TfinvFrm.doSortOrderCycle;
begin
  //get the current sort index from the radiobuttons
  //if current Sort index == 5 set to 1 else inc(sort index)
  if currentSortIndex = SORT_NATURAL then
    currentSortIndex := SORT_SUBCAT
  else
    inc(currentSortIndex);

  case currentSortIndex of
      SORT_SUBCAT:       SubcatRetNameRB.OnClick(SubcatRetNameRB);
      SORT_IMP_EXP:      ImpExpRefRB.OnClick(ImpExpRefRB);
      SORT_DESC_TOTAL:   DescTotCostRB.OnClick(DescTotCostRB);
      SORT_ASC_DELIVERY: AscDeliveryRB.OnClick(AscDeliveryRB);
      SORT_NATURAL:      naturalSortRB.OnClick(naturalSortRB);
      else
          naturalSortRB.OnClick(naturalSortRB);
  end;
end;

procedure Tfinvfrm.wwtInvoiceUcostChange(Sender: TField);
begin
  if not Editing then
    Exit;

  try
    // save change to #TmpItemAuditLog
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [#TmpItemAuditLog]');
      SQL.Add('SET [NewUnitCost]= ' + Sender.AsString);
      SQL.Add('WHERE [NewRecID] = ' + wwtInvoiceRecNo.AsString);
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceUcostChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;

  try
   //job 16487
    if (wwdbgrid1.getactivefield = sender) and (sender.asstring <> '') then
    begin
      if wwtInvoiceItemTax.ReadOnly then wwtInvoiceItemTax.ReadOnly := false;

      case wwtInvoicePurchaseItemType.Value of
        MULTI_PURCH_NONE:
          begin
            if (wwtinvoiceqty.asstring <> '') then
            begin
              Log.Event('finvfrm; wwtInvoiceUCostChange: Updating item cost');
              if wwtinvoiceitemcost.ReadOnly then wwtinvoiceitemcost.ReadOnly := false;
              wwtinvoiceitemcost.asfloat := sender.asfloat * wwtinvoiceqty.asfloat;
              wwtInvoiceItemTax.AsFloat := GetLocalisedItemTax(wwtinvoiceitemcost.asfloat, thetax, false);
            end;

            // reset the readonly property as required
            wwtInvoiceItemCost.ReadOnly := CostPricesAreReadOnly;

            // prompt for the change....
            if EditCostPrices and promptuc then
            begin
              case SaveCostChangeDlg.ShowModal of
                mrNo, mrCancel : Exit;
              end;
            end;

            Log.Event('finvfrm; wwtInvoiceUCostChange: Saving new Unit Cost to PUnits');
            try
              // save to database...
              with wwqGeneric do
              begin
                Close;
                SQL.Clear;
                SQL.Add('update punits set [unit cost] = ' + Sender.AsString);
                SQL.Add('where [entity code] = ' + QuotedStr(wwtInvoiceItemId.AsString));
                SQL.Add('and [unit name] = ' + QuotedStr(wwtInvoicePUnit.AsString));
                SQL.Add('and ([flavour] = ' + QuotedStr(wwtInvoiceFlavor.AsString));
                SQL.Add('or [flavour] is null)');

                if OneSupplier then
                  SQL.Add('and [supplier name] = ' + QuotedStr(theSupplier));

                Log.Event('finvfrm; wwtInvoiceUcostChange: wwqGeneric opened: ' + wwqGeneric.SQL.Text);
                ExecSQL;
              end;
            except
              on E: Exception do
              begin
                Log.Event('finvfrm; ERROR - wwtInvoiceUcostChange: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
                raise;
              end;
            end;
          end;
        MULTI_PURCH_CHILD:
          begin
            if (wwtInvoiceIngredQty.asstring <> '') then
            begin
              Log.Event('finvfrm; wwtInvoiceUCostChange: Updating ingredient item cost');
              if wwtInvoiceIngredItemCost.ReadOnly then wwtInvoiceIngredItemCost.ReadOnly := false;
              wwtInvoiceIngredItemCost.asfloat := sender.asfloat * wwtInvoiceIngredQty.asfloat;
              wwtInvoiceItemTax.AsFloat := GetLocalisedItemTax(wwtInvoiceIngredItemCost.asfloat, thetax, false);
            end;
            
            // save values to ensure that multipurch parent is updated
            lastParent := wwtInvoiceMultiPurchParentID.AsFloat;
            lastGroupRecID := wwtInvoiceGroupRecID.AsFloat;
            ChildUnitCostChanged := true;

            // reset the readonly property as required
            wwtInvoiceIngredItemCost.ReadOnly := CostPricesAreReadOnly;

            // prompt for the change....
            if EditCostPrices and promptuc then
            begin
              case SaveCostChangeDlg.ShowModal of
                mrNo, mrCancel : Exit;
              end;
            end;

            Log.Event('finvfrm; wwtInvoiceUCostChange: Saving new Unit Cost to PUnits');
            try
              // save to database...
              with wwqGeneric do
              begin
                Close;
                SQL.Clear;
                SQL.Add('update MultiPurchSupplierIngreds set [unit cost] = ' + Sender.AsString);
                SQL.Add('from [MultiPurchSupplierIngreds] a, MultiPurchIngredients b');
                SQL.Add('where a.MultiPurchParent = ' + QuotedStr(wwtInvoiceMultiPurchParentID.AsString));
                SQL.Add('and a.[entity code] = ' + QuotedStr(wwtInvoiceItemId.AsString));
                SQL.Add('and a.[entity code] = b.[IngredientCode]');
                SQL.Add('and a.[MultiPurchParent] = b.[EntityCode]');
                SQL.Add('and b.[unitname] = ' + QuotedStr(wwtInvoicePUnit.AsString));
                SQL.Add('and (a.[flavour] = ' + QuotedStr(wwtInvoiceFlavor.AsString));
                SQL.Add('or a.[flavour] is null)');
                if OneSupplier then
                  SQL.Add('and a.[supplier name] = ' + QuotedStr(theSupplier));

                Log.Event('finvfrm; wwtInvoiceUcostChange: wwqGeneric opened: ' + wwqGeneric.SQL.Text);
                ExecSQL;
                Close;
              end;
            except
              on E: Exception do
              begin
                Log.Event('finvfrm; ERROR - wwtInvoiceUcostChange: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
                raise;
              end;
            end;
          end;
      end;
    end;
  except
    // log any non-sql exceptions
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceUcostChange: ' + E.Message);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.wwtInvoiceItemCostChange(Sender: TField);
begin
  if not editing then
    exit;
  try
    // save change to #TmpItemAuditLog
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [#TmpItemAuditLog]');
      SQL.Add('SET [NewItemCost]= ' + Sender.AsString);
      SQL.Add('WHERE [NewRecID] = ' + wwtInvoiceRecNo.AsString);
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceItemCostChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;

  try
    if (wwdbgrid1.getactivefield = sender) and
       (sender.asstring <> '') and
       (wwtinvoiceqty.asstring <> '') and
       (wwtInvoiceQty.Value <> 0) and
       (wwtInvoicePurchaseItemType.Value = MULTI_PURCH_NONE) then
    begin
      Log.Event('finvfrm; wwtInvoiceItemCostChange: Updating unit cost');
      if wwtinvoiceucost.ReadOnly then wwtinvoiceucost.ReadOnly := false;
      if wwtInvoiceSortItemCost.ReadOnly then wwtInvoiceSortItemCost.ReadOnly := false;
      wwtinvoiceucost.asfloat := sender.asfloat / wwtinvoiceqty.asfloat;
      wwtInvoiceSortItemCost.Value := Sender.AsFloat;
      if wwtInvoiceItemTax.ReadOnly then wwtInvoiceItemTax.ReadOnly := false;
      wwtInvoiceItemTax.AsFloat := GetLocalisedItemTax(sender.AsFloat, thetax, false);
      // reset the readonly property as necessary
      wwtInvoiceUCost.ReadOnly := CostPricesAreReadOnly;
    end;
  except
    // log any non-sql exceptions
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceItemCostChange: ' + E.Message);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.wwtInvoiceIngredItemCostChange(Sender: TField);
begin
  if not editing then
    exit;

  try
    // save change to #TmpItemAuditLog
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [#TmpItemAuditLog]');
      SQL.Add('SET [NewItemCost]= ' + Sender.AsString);
      SQL.Add('WHERE [NewRecID] = ' + wwtInvoiceRecNo.AsString);
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceIngredItemCostChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;

  try
    if (wwdbgrid1.getactivefield = sender) and
       (sender.asstring <> '') and
       (wwtInvoiceIngredQty.asstring <> '') and
       (wwtInvoiceIngredQty.Value <> 0) and
       (wwtInvoicePurchaseItemType.Value = MULTI_PURCH_CHILD) then
    begin
      Log.Event('finvfrm; wwtInvoiceItemCostChange: Updating unit cost');
      if wwtinvoiceucost.ReadOnly then wwtinvoiceucost.ReadOnly := false;
      wwtinvoiceucost.asfloat := sender.asfloat / wwtInvoiceIngredQty.asfloat;
      if wwtInvoiceItemTax.ReadOnly then wwtInvoiceItemTax.ReadOnly := false;
      wwtInvoiceItemTax.AsFloat := GetLocalisedItemTax(sender.AsFloat, thetax, false);
      lastParent := wwtInvoiceMultiPurchParentID.AsFloat;
      lastGroupRecID := wwtInvoice.FieldByName('GroupRecID').Value;
      ChildItemCostChanged := true;
      // reset the readonly property as required
      wwtInvoiceUCost.ReadOnly := CostPricesAreReadOnly;
    end;
  except
    // log any non-sql exceptions
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - wwtInvoiceIngredItemCostChange: ' + E.Message);
      raise;
    end;
  end;
end;


procedure Tfinvfrm.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (wwtInvoice.FieldByName('ReadOnly').AsBoolean) then
  begin
    if (Task = TASK_EDIT) or (Task = TASK_AUDIT) or (Task = TASK_VIEW_CURR) then
    begin
      if ( wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_NONE ) or
         ( (Field.FieldName = 'UCost') or (Field.FieldName = 'IngredItemCost') or
           (Field.FieldName = 'Qty') or (Field.FieldName = 'Tax') or
           (Field.FieldName = 'OU') or (Field.FieldName = 'ItemCost') or
           (Field.FieldName = 'ItemTax') ) or
         ( (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) and
           ( (Field.FieldName = 'ImpExp Ref') or (Field.FieldName = 'PUnit') or
             (Field.FieldName = 'Flavor') or (Field.FieldName = 'ReturnImage') ) ) then
      begin
        AFont.Color := clWindowText;
        ABrush.Color := clBtnFace;
      end
      else
      begin
        AFont.Color := clWindowText;
        if (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) then
          ABrush.Color := clMPParent
        else
          ABrush.Color := clMPChild;
      end;
    end;
  end
  else
  begin
    if (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) then
    begin
      if (Field.FieldName = 'ItemName') then
      begin
         AFont.Color := clWindowText;
         ABrush.Color := clMPParent;
      end
      else if (Field.FieldName = 'Qty') then
      begin
        if (task = TASK_VIEW_CURR) or (task = TASK_VIEW_ACC) then
        begin
          AFont.Color := clWindowText;
          ABrush.Color := clBtnFace;
        end;
      end
      else
      begin
         AFont.Color := clWindowText;
         ABrush.Color := clBtnFace;
      end;
    end
    else
    begin
      if (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) then
      begin
        if (task = TASK_VIEW_CURR) or (task = TASK_VIEW_ACC) then
        begin
           AFont.Color := clWindowText;
            if (Field.FieldName = 'UCost') or
               (Field.FieldName = 'IngredItemCost') or
               (Field.FieldName = 'Qty') or
               (Field.FieldName = 'ItemCost') or
               (Field.FieldName = 'OU') or
               (Field.FieldName = 'IngredOU') then
              ABrush.Color := clBtnFace
            else
              ABrush.Color := clMPChild;
        end
        else
          if (Field.FieldName <> 'UCost') and
             (Field.FieldName <> 'IngredItemCost') then
          begin
            AFont.Color := clWindowText;
            if (Field.FieldName = 'Qty') or
               (Field.FieldName = 'ItemCost') or
               (Field.FieldName = 'OU') or
               (Field.FieldName = 'IngredOU') then
              ABrush.Color := clBtnFace
            else
              ABrush.Color := clMPChild;
          end;
      end
      else
      begin

        if ((Field.FieldName = 'IngredQty') or (Field.FieldName = 'IngredItemCost') or
            (Field.FieldName = 'IngredOU')) then
        begin
          AFont.Color := clWindowText;
          ABrush.Color := clBtnFace;
        end;

        if (wwtInvoice.FieldByName('UCost').AsFloat = 0) and
           ((Field.FieldName = 'UCost') or (Field.FieldName = 'ItemCost')) then
        begin
          AFont.Color := clWindowText;
          ABrush.Color := clBtnFace;
        end;


        if (Task < TASK_VIEW_CURR) or (Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD) then
        begin
          if (Field.FieldName = 'Tax') or
             (Field.FieldName = 'Ou') then
          begin
            AFont.Color := clWindowText;
            ABrush.Color := clBtnFace;
          end
          else if ((Field.FieldName = 'UCost') or
                  (Field.FieldName = 'ItemCost')) and
                  CostPricesAreReadOnly then
          begin
            AFont.Color := clWindowText;
            ABrush.Color := clBtnFace;
          end;
        end
        else
        begin
          if (Field.FieldName = 'Tax') or
             (Field.FieldName = 'Ucost') or
             (Field.FieldName = 'Qty') or
             (Field.FieldName = 'ItemCost') or
             (Field.FieldName = 'Ou') then
          begin
            AFont.Color := clWindowText;
            ABrush.Color := clBtnFace;
          end;
        end;
      end;
    end;
  end;

  if (wwtInvoice.FieldByName('DataSource').AsInteger > 0) then
  begin
    AFont.Style := [fsItalic];
  end;

end;


procedure Tfinvfrm.wwDBGrid1ColExit(Sender: TObject);
begin
  if ((wwdbgrid1.GetActiveField = wwtInvoiceUCost)    or
      (wwdbgrid1.GetActiveField = wwtInvoiceItemCost) or
      (wwdbgrid1.GetActiveField = wwtInvoiceQty)      or
      (wwdbgrid1.GetActiveField = wwtInvoiceIngredItemCost))   and (wwtinvoice.State = dsEdit) then
       wwtinvoice.post;
end;

procedure Tfinvfrm.ppRepPreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

procedure Tfinvfrm.GetTotals;
begin
  try
    with wwqTot do
    begin
      open;
      EditItemCount.Text := inttostr(FieldByName('IDCount').asinteger);
      EditUnitCount.Text := formatfloat('######.####', FieldByName('qty').asfloat);
      EditItemTotal.Text := formatfloat(currencystring + '#,0.0000',wwtinvoice.FieldByName('itemcost').asfloat);
      invtot := FieldByName('itemtax').asfloat +
                                         FieldByName('itemcost').asfloat;
      EditInvoiceTotal.Text := formatfloat(currencystring + '#,0.0000',invtot);
      close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - GetTotals: ' + E.Message + '; ' + wwqTot.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (((Task < TASK_VIEW_CURR) and not CurrentInvoiceFrozen) or
    (Task = TASK_AUDIT) or
    (Task = TASK_AUDIT_ADD) ) and
    (not Deleting) and AskSave then
  begin
    if SaveRequired then
    begin
      case MessageDlg('Do you want to save the current ' + GetLocalisedName(lsInvoice) +
                      '?', mtConfirmation, mbYesNoCancel,0) of
        mrYes :
          if SaveInvoice then
            ModalResult := mrOK
          else
            CanClose := False;

        mrCancel : CanClose := False;

        mrNo : ModalResult := mrCancel;
      end;
    end;
  end;
end;

procedure Tfinvfrm.DeleteInvoiceFromLog;
begin
  try
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM [PurchAuditLog]');
      SQL.Add('WHERE SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('AND SupplierName = ' + QuotedStr(thesupplier));
      SQL.Add('AND DeliveryNoteNo = ' + QuotedStr(invoiceNo));
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - DeleteInvoiceFromLog: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.UpdateAuditDelNoteNo;
begin
  try
    // update the delivery note number in all existing log records for this invoice
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update PurchAuditLog');
      SQL.Add('set DeliveryNoteNo = ' + QuotedStr(NewInvoiceNo));
      SQL.Add('where DeliveryNoteNo = ' + QuotedStr(invoiceno));
      SQL.Add('and SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('and SupplierName = ' + QuotedStr(theSupplier));
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateAuditDelNoteNo: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;

  try
    // get header changes for audit log
    with QryGetChangedHdrFields do
    begin
      Close;
      Open;
      if (FieldByName('NumberChanged').Value = 1) or
         (FieldByName('DateChanged').Value = 1) then
        with AuditLogQry do
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO PurchAuditLog([SiteCode], [SupplierName], [DeliveryNoteNo],');
          SQL.Add('[RecID], [ChangeType], [LMDT], [Modified By], [OldDelNoteNo], [NewDelNoteNo],');
          SQL.Add('[OldDelNoteDate], [NewDelNoteDate])');
          SQL.Add('Select ' + IntToStr(SiteCode) + ',');
          SQL.Add(':SupplierName, :DeliveryNoteNo,');
          SQL.Add('null,' + IntToStr(HEADER_CHANGE) + ',');
          SQL.Add('''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', now) + ''',' + QuotedStr(CurrentUser.UserName) + ',');
          SQL.Add(' :OldDelNoteNo, :NewDelNoteNo,');
          SQL.Add('''' + FormatDateTime('yyyy/mm/dd', QryGetChangedHdrFields.FieldByName('OldDelNoteDate').Value) + ''',');
          SQL.Add('''' + FormatDateTime('yyyy/mm/dd', QryGetChangedHdrFields.FieldByName('NewDelNoteDate').Value) + '''');

          Parameters.ParamByName('SupplierName').Value := theSupplier;
          Parameters.ParamByName('DeliveryNoteNo').Value := NewInvoiceNo;
          Parameters.ParamByName('OldDelNoteNo').Value := QryGetChangedHdrFields.FieldByName('OldDelNoteNo').AsString;
          Parameters.ParamByName('NewDelNoteNo').Value := QryGetChangedHdrFields.FieldByName('NewDelNoteNo').AsString;
          ExecSQL;
        end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateAuditDelNoteNO: ' + E.Message + '; ' + QryGetChangedHdrFields.SQL.Text);
      raise;
    end;
  end;
end;

{
procedure Tfinvfrm.UpdateAuditItemRecIDs;
begin
  try
    // update the recID in all "undeleted" item log records for this invoice
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE PurchAuditLog');
      SQL.Add('set RecID =');
      SQL.Add('  (select distinct [NewRecID]');
      SQL.Add('   from #TmpItemAuditLog');
      SQL.Add('   where #TmpItemAuditLog.[OldRecID] = PurchAuditLog.[RecID]');
      SQL.Add('   and PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('   and PurchAuditLog.SupplierName = ' + QuotedStr(theSupplier));
      SQL.Add('   and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(NewInvoiceNo));
      SQL.Add('   and PurchAuditLog.ChangeType in (' + IntToStr(ADD_ITEM) + ',' + IntToStr(CHANGE_ITEM) + '))');
      SQL.Add('from PurchAuditLog, #TmpItemAuditLog');
      SQL.Add('where PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('and PurchAuditLog.SupplierName = ' + QuotedStr(theSupplier));
      SQL.Add('and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(NewInvoiceNo));
      SQL.Add('and PurchAuditLog.ChangeType in (' + IntToStr(ADD_ITEM) + ',' + IntToStr(CHANGE_ITEM) + ')');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateAuditItemRecIDs: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;
}

procedure Tfinvfrm.UpdateAuditItemRecIDs;
begin
  try
    // update the recID in all "undeleted" item log records for this invoice
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('IF CURSOR_STATUS(''global'',''UpdCursor'')>=-1');
      SQL.Add('BEGIN');
      SQL.Add('     CLOSE UpdCursor');
      SQL.Add('     DEALLOCATE UpdCursor');
      SQL.Add('END');

      SQL.Add('DECLARE UpdCursor CURSOR');
      SQL.Add('FOR');
      SQL.Add('select distinct [OldRecID], [NewRecID]');
      SQL.Add('from #TmpItemAuditLog');
      SQL.Add('join PurchAuditLog on #TmpItemAuditLog.[OldRecID] = PurchAuditLog.[RecID]');
      SQL.Add('and PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('and PurchAuditLog.SupplierName = ' + QuotedStr(theSupplier));
      SQL.Add('and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(NewInvoiceNo));
      SQL.Add('and PurchAuditLog.ChangeType in (' + IntToStr(ADD_ITEM) + ',' + IntToStr(CHANGE_ITEM) + ')');
      SQL.Add('order by OldRecID desc');

      SQL.Add('Open UpdCursor');

      SQL.Add('declare @OldRecID float');
      SQL.Add('declare @NewRecID float');

      SQL.Add('FETCH NEXT FROM UpdCursor INTO @OldRecID, @NewRecID');
      SQL.Add(' -- the loop');
      SQL.Add('While @@FETCH_STATUS = 0');
      SQL.Add('BEGIN');
      SQL.Add('  Print ''-- old new rec''');
      SQL.Add('  Print @OldRecID');
      SQL.Add('  print @NEwRecID');

      SQL.Add(' 	update PurchAuditLog');
      SQL.Add(' 	set RecID =@NewRecID');
      SQL.Add(' 	where RecID = @OldRecID');
      SQL.Add(' 	and  PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('     and PurchAuditLog.SupplierName = ' + QuotedStr(theSupplier));
      SQL.Add('     and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(NewInvoiceNo));
      SQL.Add('     and PurchAuditLog.ChangeType in (' + IntToStr(ADD_ITEM) + ',' + IntToStr(CHANGE_ITEM) + ')');

      SQL.Add(' FETCH NEXT FROM UpdCursor INTO @OldRecID, @NewRecID');
      SQL.Add('END');

      SQL.Add('CLOSE UpdCursor');
      SQL.Add('DEALLOCATE UpdCursor');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateAuditItemRecIDs: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.SetAuditDeletedItems(dateAsFloat: real);
begin
  try
    with AuditLogQry do
    begin
      // set all ADD_ITEM records to DELETE_CREATE_ITEM and set recID
      Close;
      SQL.Clear;
      SQL.Add('update purchauditlog');
      SQL.Add('set ChangeType = ' + IntToStr(DELETE_CREATE_ITEM) + ',');
      SQL.Add('    RecID = #TmpItemAuditLog.OldRecID + ' + FloatToStr(dateAsFloat));
      SQL.Add('from PurchAuditLog, #TmpItemAuditLog');
      SQL.Add('where PurchAuditLog.RecID = #TmpItemAuditLog.OldRecID');
      SQL.Add('and #TmpItemAuditLog.ChangeType = ' + IntToStr(DELETE_ITEM));
      SQL.Add('and PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('and PurchAuditLog.SupplierName = ' + QuotedStr(thesupplier));
      SQL.Add('and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(invoiceNo));
      SQL.Add('and PurchAuditLog.ChangeType = ' + IntToStr(ADD_ITEM));
      ExecSQL;
      // set all CHANGE_ITEM records to DELETE_CHANGED_ITEM and set RecID
      Close;
      SQL.Clear;
      SQL.Add('update purchauditlog');
      SQL.Add('set ChangeType = ' + IntToStr(DELETE_CHANGED_ITEM) + ',');
      SQL.Add('    RecID = #TmpItemAuditLog.OldRecID + ' + FloatToStr(dateAsFloat));
      SQL.Add('from PurchAuditLog, #TmpItemAuditLog');
      SQL.Add('where PurchAuditLog.RecID = #TmpItemAuditLog.OldRecID');
      SQL.Add('and #TmpItemAuditLog.ChangeType = ' + IntToStr(DELETE_ITEM));
      SQL.Add('and PurchAuditLog.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('and PurchAuditLog.SupplierName = ' + QuotedStr(thesupplier));
      SQL.Add('and PurchAuditLog.DeliveryNoteNo = ' + QuotedStr(invoiceNo));
      SQL.Add('and PurchAuditLog.ChangeType = ' + IntToStr(CHANGE_ITEM));
      ExecSQL;
      // finally add a DELETE_ITEM record
      Close;
      SQL.Clear;
      SQL.Add('INSERT PurchAuditLog');
      SQL.Add('SELECT ' + IntToStr(SiteCode) + ',' + QuotedStr(thesupplier) + ',' + QuotedStr(invoiceNo) + ',');
      // need the milliseconds (.z) below to prevent key violations when the
      // another record with the same recID is deleted in a future edit of the invoice
      SQL.Add('(OldRecID + ' + FloatToStr(dateAsFloat) + ') as TheRecID, ' + IntToStr(DELETE_ITEM) + ',''' + FormatDateTime('yyyy/mm/dd hh:nn:ss.z', now) + ''',');
      SQL.Add(QuotedStr(CurrentUser.UserName) + ',null, null, null, null,');
      SQL.Add('Product, null, null, OldUnitCost, 0, OldQty, 0, OldItemCost, 0');
      SQL.Add('FROM #TmpItemAuditLog');
      SQL.Add('WHERE ChangeType = ' + IntToStr(DELETE_ITEM));
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - SetAuditDeletedItems: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

//procedure Tfinvfrm.AddChangesToAuditLog(oldRecID: Double; newRecID: Integer);
procedure Tfinvfrm.AddChangesToAuditLog(newRecID: Integer);
begin
  try
    // get item changes for audit log
    with QryGetChangedItemFields do
    begin
      Close;
      Parameters.ParamByName('RecID').Value := newRecID;
      Open;
      if (FieldByName('UCostChanged').Value = 1) or
         (FieldByName('QtyChanged').Value = 1) or
         (FieldByName('ItemCostChanged').Value = 1) then
        with AuditLogQry do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into PurchAuditLog([SiteCode], [SupplierName], [DeliveryNoteNo],');
          SQL.Add('[RecID], [ChangeType], [LMDT], [Modified By], [Product], [OldUnitCost], [NewUnitCost],');
          SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost])');
          SQL.Add('Select ' + IntToStr(SiteCode) + ',');
          SQL.Add(' :theSupplier, :NewInvoiceNo,');
          SQL.Add(FloatToStr(newRecID) + ',' + IntToStr(QryGetChangedItemFields.FieldByName('ChangeType').Value) + ',');
          SQL.Add('''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', now) + ''',' + QuotedStr(CurrentUser.UserName) + ',');
          SQL.Add(FloatToStr(wwtInvoiceItemID.Value) + ',');
          if VarIsNull(QryGetChangedItemFields.FieldByName('OldUnitCost').Value) then
            SQL.Add('null,')
          else
            SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('OldUnitCost').Value) + ',' );
          if VarIsNull(QryGetChangedItemFields.FieldByName('NewUnitCost').Value) then
            SQL.Add('null,')
          else
            SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('NewUnitCost').Value) + ',');
          SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('OldQty').Value)+ ',');
          SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('NewQty').Value) + ',');
          SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('OldItemCost').Value) + ',');
          SQL.Add(FloatToStr(QryGetChangedItemFields.FieldByName('NewItemCost').Value));

          Parameters.ParamByName('theSupplier').Value := theSupplier;
          Parameters.ParamByName('NewInvoiceNo').Value := NewInvoiceNo;
          ExecSQL;
        end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - AddChangesToAuditLog: ' + E.Message + '; ' + QryGetChangedItemFields.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.UpdateStockOrderStatus;
begin
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [StockOrder]');
      SQL.Add('SET [Status]=3');
      SQL.Add('WHERE [OrderNo]=' + QuotedStr(theOrderNo));
      SQL.Add('AND [SiteCode]=' + IntToStr(SiteCode));
      SQL.Add('AND [Supplier]=' + QuotedStr(theSupplier));
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateStockOrderStatus: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
    end;
  end;
end;

procedure Tfinvfrm.DeleteTheInvoice(calledBy: String);
begin
  try
    with wwqdelpurch do
    begin
       Parameters.ParamByName('thesite').Value := SiteCode;
       Parameters.ParamByName('supplier').Value := thesupplier;
       Parameters.ParamByName('invno').Value := invoiceno;   // need to use old invoice no. here
       execsql;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - ' + calledBy + '/DeleteTheInvoice: wwqDelPurch - ' + E.Message + '; ' + wwqdelpurch.SQL.Text);
      raise;
    end;
  end;

  try
    with wwqDelPurchRef do
    begin
       Parameters.ParamByName('thesite').Value := SiteCode;
       Parameters.ParamByName('supplier').Value := thesupplier;
       Parameters.ParamByName('invno').Value := invoiceno;
       execsql;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - ' + calledBy + '/DeleteTheInvoice: wwqDelPurchRef - ' + E.Message + '; ' + wwqdelpurchref.SQL.Text);
      raise;
    end;
  end;

  try
    with wwqDelParent do
    begin
       Parameters.ParamByName('thesite').Value := SiteCode;
       Parameters.ParamByName('supplier').Value := thesupplier;
       Parameters.ParamByName('invno').Value := invoiceno;
       execsql;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - ' + calledBy + '/DeleteTheInvoice: wwqDelParent - ' + E.Message + '; ' + wwqdelparent.SQL.Text);
      raise;
    end;
  end;

  try
    with wwqDelIngreds do
    begin
       Parameters.ParamByName('thesite').Value := SiteCode;
       Parameters.ParamByName('supplier').Value := thesupplier;
       Parameters.ParamByName('invno').Value := invoiceno;
       execsql;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - ' + calledBy + '/DeleteTheInvoice: wwqDelIngreds - ' + E.Message + '; ' + wwqdelingreds.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.SaveInv;
var
  theRecID: integer;
  edorins : boolean;
  thedateAsFloat: real;
begin

  //WTF:  Doesnt matter if user presses OK or Cancel - it doesn't do anything
  //      either way, anyway this is trapped before it gets here but I like
  //      the message!
  if wwtInvoice.recordcount = 0 then
  begin
    if MessageDlg('This ' + GetLocalisedName(lsInvoice) + ' has no products! An ' +
      GetLocalisedName(lsInvoice) + ' with no products cannot exist.'+#13+#10+''+#13+#10+
      'Click OK to go ahead and delete this ' + GetLocalisedName(lsInvoice) + '.'+#13+#10+
      'Click Cancel to return to the ' + GetLocalisedName(lsInvoice) +
      ' form (and maybe put some products in)',
      mtWarning, [mbOK, mbCancel], 0) = mrOK then
  end;

  // get the current date/time for calculating the new recID for Deleted items in PurchAuditLog
  // to ensure that records appear in their original order
  thedateAsFloat := Now;

  wwtInvoice.disablecontrols;
  if (Task < TASK_VIEW_CURR) or (Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD) then
  begin
    try
      dmADO.BeginTransaction;
      screen.Cursor := crHourGlass;
      GetTotals;
      if (Task = TASK_EDIT) or (Task = TASK_AUDIT) then // edit invoice...
      begin
        log.event('finvfrm; SaveInv: opening wwtPurchHead: ' + wwtPurchHead.TableName);
        try
          if NewInvoiceNo = invoiceno then
          begin
            with wwtpurchhead do
            begin
               Open;
               Locate('Site Code;Supplier Name;Delivery Note No.',
                         VarArrayOf([SiteCode, thesupplier, invoiceno]), []);
               Edit;

               FieldByName('Delivery Note No.').AsString := NewInvoiceNo;
               FieldByName('modified by').AsString := CurrentUser.UserName;
               FieldByName('LMDT').AsDatetime := Now;
               FieldByName('note').AsString := EditNote.Text;
               FieldByName('date').AsDatetime := theDate; // 15816
               Post;
               Close;
            end;
          end
          else
          begin
            with wwtpurchhead do
            begin
               Open;

               // if the Invoice No. has been changed then need to insert a new record with the new name
               // and mark the record with the old name as deleted (so that it goes to HO).

               // however, if the new name already exists then there are 2 possibilites:
               // 1. the Invoice is non-deleted - allow KV error as normal
               // 2. the Invoice is deleted - edit the record of the "deleted" Invoice...

               edorins := True;
               if locate('supplier name;delivery note no.',
                 VarArrayOf([thesupplier, NewInvoiceNo]), []) then
               begin
                 if FieldByName('deleted').asstring = 'Y' then
                 begin
                   edorins := False;
                   edit;
                 end;
               end;

               if edorins then
                 insert;

               FieldByName('Site Code').asinteger := SiteCode;
               FieldByName('Supplier Name').asstring := thesupplier;
               FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
               FieldByName('Modified By').asstring := CurrentUser.UserName;
               FieldByName('LMDT').asdatetime := Now;
               FieldByName('Date').asdatetime := thedate; // 15816
               FieldByName('Note').asstring := EditNote.Text;
               FieldByName('Order No').AsString := theOrderNo;
               FieldByName('Deleted').Value := NULL;
               FieldByName('Amended').asboolean := TRUE;
               FieldByName('MaskID').AsInteger := theMaskID;
               Post;


               // now mark the old record as Deleted...
               Locate('Site Code;Supplier Name;Delivery Note No.',
                         VarArrayOf([SiteCode, thesupplier, invoiceno]), []);
               Edit;

               FieldByName('Deleted').Value := 'Y';
               FieldByName('modified by').AsString := CurrentUser.UserName;
               FieldByName('LMDT').AsDatetime := Now;
               Post;
               Close;
            end;
          end;
        except
          on E: Exception do
          begin
            Log.Event('finvfrm; ERROR - SaveInv: ' + wwtpurchhead.TableName + ' (Edit mode)) ' + E.Message);
            raise;
          end;
        end;
        DeleteTheInvoice('SaveInv');
        // Remove "deleted" items from AuditLog
        SetAuditDeletedItems(thedateAsFloat);
        UpdateAuditItemRecIDs; // change all historic records with new recIDs
      end
      else   // add invoice
      begin
        log.event('finvfrm; SaveInv: opening wwtPurchHead: ' + wwtPurchHead.TableName);
        try
          with wwtpurchhead do
          begin
             open;

             edorins := True;
             // if this a table using 'deleted' field the inv may be there, deleted,
             // in which case edit. If it not deleted then try to insert (and of course ERROR)...
             { TODO -owilma -cimportant :
    There is a bug here - when the data is written from Invoice to purchase etc.
    a key violation exception will be raised because the record id will already
    be there for the original items of the previously deleted invoice }
             if locate('supplier name;delivery note no.',
               VarArrayOf([thesupplier, invoiceno]), []) then
             begin
               if FieldByName('deleted').asstring = 'Y' then
               begin
                 edorins := False;
                 edit;
               end;
             end;

             if edorins then
               insert;

             FieldByName('Site Code').asinteger := SiteCode;
             FieldByName('Supplier Name').asstring := thesupplier;
             FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
             FieldByName('Modified By').asstring := CurrentUser.UserName;
             FieldByName('LMDT').asdatetime := Now;
             FieldByName('Date').asdatetime := thedate; // 15816
             FieldByName('Note').asstring := EditNote.Text;
             FieldByName('Order No').AsString := theOrderNo;
             FieldByName('Deleted').Value := NULL;
             FieldByName('MaskID').AsInteger := theMaskID;
             Post;
             Close;
          end;
        except
          on E: Exception do
          begin
            Log.Event('finvfrm; ERROR - SaveInv: ' + wwtpurchhead.TableName + ' (Add mode)) ' + E.Message);
            raise;
          end;
        end;

        UpdateStockOrderStatus;

        try
          // Save header details to PurchAuditLog
          with AuditLogQry do
          begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO PurchAuditLog([SiteCode],[SupplierName],[DeliveryNoteNo],');
            SQL.Add('[ChangeType],[LMDT],[Modified By], [OldDelNoteNo], [NewDelNoteNo],');
            SQL.Add('[OldDelNoteDate],[NewDelNoteDate])');
            SQL.Add('SELECT [SiteCode], [SupplierName], [DeliveryNoteNo], ');
            SQL.Add(IntToStr(INVOICE_CREATE) + ',''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', now) + ''',' + QuotedStr(CurrentUser.UserName) + ',');
            SQL.Add('[OldDelNoteNo],[NewDelNoteNo],[OldDelNoteDate],[NewDelNoteDate]');
            SQL.Add('FROM [#TmpHdrAuditLog]');
            ExecSQL;
          end;
        except
          on E: Exception do
          begin
            Log.Event('finvfrm; ERROR - SaveInv: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
            raise;
          end;
        end;
      end;

      // save the invoice
      log.event('finvfrm; SaveInv: opening Purchase tables ' + wwtPurchase.TableName + ', PurchMultiPurchParent, PurchMultiPurchIngreds, PurchReference.');
      try
        wwtPurchase.open;
        wwtPurchIngreds.Open;
        wwtPurchParent.Open;
        wwtPurchRef.Open;
        wwtInvoice.First;
        theRecID := wwtInvoice.FieldByName('RecNo').Value;

        while not (wwtInvoice.EOF) do
        begin
         case wwtInvoice.FieldByName('PurchaseItemType').Value of
           MULTI_PURCH_NONE, MULTI_PURCH_CHILD :
             begin
               AddChangesToAuditLog(theRecID);
               wwtPurchase.insert;
               wwtPurchase.FieldByName('Site Code').asinteger := SiteCode;
               wwtPurchase.FieldByName('Supplier Name').asstring := thesupplier;
               wwtPurchase.FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
               wwtPurchase.FieldByName('Modified By').asstring := CurrentUser.UserName;
               wwtPurchase.FieldByName('LMDT').asdatetime := Now;
               wwtPurchase.FieldByName('Record ID').Value := wwtInvoice.FieldByName('RecNo').Value;
               wwtPurchase.FieldByName('Entity Code').Value := wwtInvoice.FieldByName('itemid').Value;
               wwtPurchase.FieldByName('Flavour').asstring := wwtInvoice.FieldByName('flavor').asstring;
               if wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_NONE then
               begin
                 wwtPurchase.FieldByName('Purchase Name').asstring := wwtInvoice.FieldByName('itemname').asstring;
                 wwtPurchase.FieldByName('Quantity').asfloat := wwtInvoice.FieldByName('qty').asfloat;
                 wwtPurchase.FieldByName('Total Cost').asfloat := wwtInvoice.FieldByName('itemcost').asfloat;
                 wwtPurchase.FieldByName('Shortage').value := wwtInvoice.FieldByName('ou').value;
                end
               else
               begin
                 wwtPurchIngreds.Insert;
                 wwtPurchIngreds.FieldByName('Site Code').asinteger := SiteCode;
                 wwtPurchIngreds.FieldByName('Supplier Name').asstring := thesupplier;
                 wwtPurchIngreds.FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
                 wwtPurchIngreds.FieldByName('Record ID').Value := wwtInvoice.FieldByName('RecNo').Value;
                 wwtPurchIngreds.FieldByName('EntityCode').Value := wwtInvoice.FieldByName('itemid').Value;
                 wwtPurchIngreds.FieldByName('GroupRecID').Value := wwtInvoice.FieldByName('GroupRecID').Value;
                 wwtPurchIngreds.FieldByName('MultiPurchParent').Value := wwtInvoice.FieldByName('MultiPurchParentID').Value;
                 wwtPurchIngreds.FieldByName('Returnable').Value := wwtInvoice.FieldByName('Returnable').Value;
                 wwtPurchIngreds.FieldByName('LMDT').AsDateTime := Now;
                 wwtPurchIngreds.Post;
                 wwtPurchase.FieldByName('Purchase Name').asstring :=
                                  copy(wwtInvoice.FieldByName('itemname').asstring, 4, length(wwtInvoice.FieldByName('itemname').asstring)-3);
                 wwtPurchase.FieldByName('Quantity').asfloat := wwtInvoice.FieldByName('IngredQty').asfloat;
                 wwtPurchase.FieldByName('Total Cost').asfloat := wwtInvoice.FieldByName('IngredItemCost').asfloat;
                 wwtPurchase.FieldByName('Shortage').value := wwtInvoice.FieldByName('IngredOU').value;
               end;
               wwtPurchase.FieldByName('Unit Name').asstring := wwtInvoice.FieldByName('punit').asstring;
               wwtPurchase.FieldByName('Cost Per Unit').asfloat := wwtInvoice.FieldByName('ucost').asfloat;
               wwtPurchase.Post;

               wwtPurchRef.Insert;
               wwtPurchRef.FieldByName('Site Code').asinteger := SiteCode;
               wwtPurchRef.FieldByName('Supplier Name').asstring := thesupplier;
               wwtPurchRef.FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
               wwtPurchRef.FieldByName('Record ID').Value := wwtInvoice.FieldByName('RecNo').Value;
               wwtPurchRef.FieldByName('Import/Export Reference').asstring := wwtInvoice.FieldByName('ImpExp Ref').AsString;
               wwtPurchRef.FieldByName('LMDT').AsDateTime := Now;
               wwtPurchRef.FieldByName('DataSource').AsInteger := wwtInvoice.FieldbyName('DataSource').AsInteger;
               wwtPurchRef.Post;
             end;
           MULTI_PURCH_PARENT :
             begin
               wwtPurchParent.Insert;
               wwtPurchParent.FieldByName('Site Code').asinteger := SiteCode;
               wwtPurchParent.FieldByName('Supplier Name').asstring := thesupplier;
               wwtPurchParent.FieldByName('Delivery Note No.').asstring := NewInvoiceNo;
               wwtPurchParent.FieldByName('Record ID').Value := wwtInvoice.FieldByName('RecNo').Value;
               wwtPurchParent.FieldByName('EntityCode').Value := wwtInvoice.FieldByName('itemid').Value;
               wwtPurchParent.FieldByName('MultiPurchQty').Value := wwtInvoice.FieldByName('qty').Value;
               wwtPurchParent.FieldByName('Total Cost').Value := wwtInvoice.FieldByName('itemcost').AsFloat;
               wwtPurchParent.FieldByName('Shortage').Value := wwtInvoice.FieldByName('OU').Value;
               wwtPurchParent.Post;
             end;
         end;
         wwtinvoice.next;
         theRecID := wwtInvoice.FieldByName('RecNo').Value;
        end;
        wwtPurchase.close;
        wwtPurchIngreds.Close;
        wwtPurchParent.Close;
        wwtPurchRef.Close;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - SaveInv: writing to Purchase tables ' + E.Message);
          raise;
        end;
      end;

      UpdateAuditDelNoteNo;  // change all historic records to new invoice number

      if CurrentInvoiceAmended then
        UpdateFrozenAmended(Now, CHANGE_TYPE_AMENDED);
      dmADO.CommitTransaction;
      Log.Event('finvfrm; All changes have been committed to the database');
    finally
      if dmADO.InTransaction then
      begin
        Log.Event('finvfrm; An error was raised while saving this delivery note - rolling back all database changes');
        dmADO.RollbackTransaction;
      end;
    end;
  end;

  wwtinvoice.EnableControls;

  if (Task = TASK_ADD) or (Task = TASK_AUDIT_ADD) then
    if MessageDlg('Do you want to print the new ' + GetLocalisedName(lsInvoice) +
                  '?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
      PrintInvoiceAction.Execute;
end;

procedure Tfinvfrm.wwDBGrid1Exit(Sender: TObject);
begin
  if (wwtInvoice.State = dsEdit) or (wwtInvoice.State = dsInsert) then
    wwtInvoice.post;

  { The following code is normally done in wwtInvoiceAfterScroll but that will have
    been by-passed by selecting another control on the form. }
  // Reset ParentQtyChanged - the multi-purch ingredients will already have been updated
  // in wwtInvoiceQtyChange.
  // if ChildUnitCostChanged or ChildItemCostChanged are true then update multi-purch
  // parent item cost and reset ChildUnitCostChanged, ChildItemCostChanged to false
  UpdateMultiPurchValues;
end;

procedure Tfinvfrm.EditNoteChange(Sender: TObject);
begin
  asksave := true;
  SetAmendedDetails;
end;

procedure Tfinvfrm.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

procedure Tfinvfrm.wwtInvoiceAfterDelete(DataSet: TDataSet);
begin
  GetTotals;
  AskSave := True;
  SetAmendedDetails;
end;

procedure Tfinvfrm.wwtInvoiceAfterInsert(DataSet: TDataSet);
begin
  if check then
  begin
    if wwtinvoice.eof then
      howinsert := FROM_DOWN_ARROW // down arrow on last record...
    else
      howinsert := FROM_INSERT_KEY;

    InsertItem(False);
  end
  else
    check := true;
end;

procedure Tfinvfrm.wwtInvoiceAfterPost(DataSet: TDataSet);
begin
  if editing then
    GetTotals;

  editing := false;
  asksave := true;

  wwtinvoicetax.ReadOnly := true;

  case wwtInvoice.FieldByName('PurchaseItemType').Value of
    MULTI_PURCH_NONE:
        OldQty := wwtInvoice.FieldByName('Qty').AsFloat;
    MULTI_PURCH_PARENT:
        OldQty := wwtInvoice.FieldByName('Qty').AsFloat;
    MULTI_PURCH_CHILD:
        OldQty := wwtInvoice.FieldByName('IngredQty').AsFloat;
  end;

end;

procedure Tfinvfrm.wwtInvoiceAfterScroll(DataSet: TDataSet);
begin
  if (scroll) and (Visible) then
    case wwtInvoicePurchaseItemType.Value of
      MULTI_PURCH_NONE :
        selitem := wwtInvoiceItemName.Value;
    else
      selitem := wwtInvoiceSortItemName.Value;
    end;

  UpdateMultiPurchValues;

  if wwtInvoicePurchaseItemType.Value = MULTI_PURCH_CHILD then
    OldQty := wwtInvoice.FieldByName('IngredQty').AsFloat
  else
    OldQty := wwtInvoice.FieldByName('Qty').Asfloat;

  GetTotals;

  if (Task = TASK_ADD) or (TASK = TASK_AUDIT_ADD) or
     (Task = TASK_EDIT) or (Task = TASK_AUDIT) then
  begin
    UpdateGridFieldsEnabled;
  end;
end;

procedure Tfinvfrm.wwtInvoiceBeforeEdit(DataSet: TDataSet);
begin
  if Visible then
    Editing := True;
end;

procedure Tfinvfrm.wwtInvoiceBeforeInsert(DataSet: TDataSet);
begin
  wwtinvoicetax.ReadOnly := false;
end;

procedure TfinvFrm.EnableSortGroupBox( AEnabled: Boolean );
begin
  SortGroupBox.Enabled := ( AEnabled and SortGroupBox.Visible );
end;

procedure Tfinvfrm.naturalSortRBClick(Sender: TObject);
begin
  wwtInvoice.Sort := '[RecNo] ASC';
  with (Sender as TRadioButton) do
  begin
    currentSortIndex := Tag;
    Checked := True;
    GetTotals;
  end
end;

procedure Tfinvfrm.ImpExpRefRBClick(Sender: TObject);
begin
  wwtInvoice.Sort := '[SortImpExpRef] ASC, [RecNo] ASC';
  with (Sender as TRadioButton) do
  begin
    currentSortIndex := Tag;
    Checked := True;
    GetTotals;
  end
end;

procedure Tfinvfrm.SubcatRetNameRBClick(Sender: TObject);
begin
  wwtInvoice.Sort := '[SortSubCat] ASC, [SortItemName] ASC, [RecNo] ASC';
  with (Sender as TRadioButton) do
  begin
    currentSortIndex := Tag;
    Checked := True;
    GetTotals;
  end
end;

procedure Tfinvfrm.DescTotCostRBClick(Sender: TObject);
begin
  wwtInvoice.Sort := '[SortItemCost] DESC, [RecNo] ASC';
  with (Sender as TRadioButton) do
  begin
    currentSortIndex := Tag;
    Checked := True;
    GetTotals;
  end
end;

procedure Tfinvfrm.AscDeliveryRBClick(Sender: TObject);
begin
  wwtInvoice.Sort := 'SortQty ASC, [RecNo] ASC';
  with (Sender as TRadioButton) do
  begin
    currentSortIndex := Tag;
    Checked := True;
    GetTotals;
  end
end;

procedure Tfinvfrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('finvfrm; FormClose');
  fnewitemdlg.Free;
end;


procedure Tfinvfrm.GetEditLevels;
begin
  try
    with qryGetEditLevel do
    begin
      Parameters.ParamByName('Supplier').Value := theSupplier;
      Open;

      if RecordCount = 0 then
      begin
        ViewCostPrices := False;
        EditCostPrices := False;
        FreeItems := False;
        SendToTills := False;
      end
      else
      begin
        if PurAudit and ((Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD)) then  // override the supplier view/edit settings for users that have audit permissions
        begin
          ViewCostPrices := true;
          EditCostPrices := true;
          FreeItems := true;
          SendToTills := (FieldByName('Send Deliveries To Till').AsString = 'Y');
        end
        else
        begin
          ViewCostPrices := (FieldByName('View Cost Prices').AsString = 'Y');
          EditCostPrices := (FieldByName('Update Cost Prices').AsString = 'Y');
          FreeItems := (FieldByName('Add Free Items').AsString = 'Y');
          SendToTills := (FieldByName('Send Deliveries To Till').AsString = 'Y');
        end;
      end;

      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - GetEditLevels: ' + E.Message + '; ' + QryGetEditLevel.SQL.Text);
      raise;
    end;
  end;

  ToggleCostPriceHeaderFields;
end;

procedure Tfinvfrm.wwtInvoiceUCostGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if (ViewCostPrices) and (not Sender.IsNull) then
    Text := FormatFloat('0.0000', Sender.Asfloat)
  else
    Text := '';
end;

procedure Tfinvfrm.wwtInvoiceItemCostGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if (ViewCostPrices) and (not Sender.IsNull) then
    Text := FormatFloat('0.0000', Sender.Asfloat)
  else
    Text := '';
end;

procedure Tfinvfrm.wwtInvoiceIngredItemCostGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if (ViewCostPrices) and (not Sender.IsNull) then
    Text := FormatFloat('0.0000', Sender.AsFloat)
  else
    Text := '';
end;


procedure Tfinvfrm.wwtInvoiceBeforePost(DataSet: TDataSet);
begin
  case Task of
     TASK_VIEW_CURR: {do nothing};
     TASK_VIEW_ACC: {do nothing};
     // we don't currently use the ordering system so just set the O/U value to the received qty value
     TASK_ADD, TASK_AUDIT_ADD, TASK_EDIT, TASK_AUDIT:
       begin
//TODO:  Move this to QtyChange Handler
//         DataSet.FieldByName('OU').ReadOnly := false;
//         if DataSet.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD then
//           DataSet.FieldByName('OU').Value := null   // TODO - what happens if FromStockOrder???
//         else
//           if FromStockOrder then
//             DataSet.FieldByName('OU').Value := DataSet.FieldByName('Qty').AsFloat - DataSet.FieldByName('ExpectedQty').AsFloat
//           else
//             DataSet.FieldByName('OU').Value := DataSet.FieldByName('Qty').Value;
//         DataSet.FieldByName('OU').ReadOnly := true;
       end;
  end;
end;

procedure Tfinvfrm.ModifyInvFormGridForLocale;
begin
  if UKUSmode = 'UK' then
  begin
    wwtInvoiceTax.Visible := false;
    wwtInvoiceQty.DisplayLabel := 'Delivery';
    wwtInvoiceFlavor.DisplayLabel := 'Flavour';
  end
  else
  begin
    wwtInvoiceTax.Visible := true;
    wwtInvoiceTax.Index := 4;
    wwtInvoiceQty.DisplayLabel := 'Received';
    wwtInvoiceFlavor.DisplayLabel := 'Flavor';
  end;
  AscDeliveryRB.Caption := 'Ascending ' + wwtInvoiceQty.DisplayLabel;
end;

procedure Tfinvfrm.SetNumericFieldPrecision;
begin
  // note that UCost, ItemCost and IngredItemCost are set in GetText procedures
  wwtInvoiceQty.DisplayFormat := '0.00';
  wwtInvoiceOU.DisplayFormat := '0.00';
  wwtInvoiceMultiPurchQty.DisplayFormat := '0.00';
end;

procedure Tfinvfrm.EditInvoiceNoChange(Sender: TObject);
begin
  // Tag will be set to 1 when the program is loading the
  // initial value for this component and then set to 0
  if EditInvoiceNo.Tag = 0 then
  begin
    NewInvoiceNo := EditInvoiceNo.Text;
    AskSave := True;
    SetAmendedDetails;
    try
      // save change to #TmpHdrAuditLog (it only has 1 record)
      with AuditLogQry do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE [#TmpHdrAuditLog]');
        SQL.Add('SET [NewDelNoteNo]= ' + QuotedStr(EditInvoiceNo.Text));
        ExecSQL;
      end;
    except
      on E: Exception do
      begin
        Log.Event('finvfrm; ERROR - EditInvoiceNoChange: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
        raise;
      end;
    end;
  end;
end;

procedure Tfinvfrm.ppRepBeforePrint(Sender: TObject);
begin
  if UKUSMode = 'UK' then
    ppRep.PrinterSetup.PaperName := 'A4'
  else
    ppRep.PrinterSetup.PaperName := 'Letter';
end;

function Tfinvfrm.SubcatIsReadOnly(subcat: string): boolean;
begin
  result := false;
  with qInvalidSubcats do
  begin
    First;
    while not Eof do
    begin
      if subcat = FieldByName('Sub-Category Name').Value then
      begin
        result := true;
        break;
      end;
      Next;
    end;
  end;
end;

procedure Tfinvfrm.wwtInvoiceCalcFields(DataSet: TDataSet);
begin
  case Task of
    TASK_AUDIT, TASK_VIEW_CURR :
      DataSet.FieldByName('ReadOnly').Value :=
           SubcatIsReadOnly(VarToStr(DataSet.fieldByName('SubCat Name').Value));
    TASK_EDIT:
      if CurrentInvoiceFrozen then
        DataSet.FieldByName('ReadOnly').Value := true
      else
        DataSet.FieldByName('ReadOnly').Value :=
             SubcatIsReadOnly(VarToStr(DataSet.fieldByName('SubCat Name').Value));
  else
    DataSet.FieldByName('ReadOnly').Value := false;
  end;

   if (DataSet.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) then
     if (DataSet.FieldByName('Returnable').AsBoolean) then
       DataSet.FieldByName('ReturnImage').Value := 2;
end;

procedure Tfinvfrm.EnableAllGridFields(AEnabled: boolean);
var
  i : integer;
begin
  if AEnabled then
  begin
    { set relevant fields to readonly, i.e. if MPC then qty, item cost, ou
      if non MP then ingredqty, ingreditemcost, ingredOU
      if MPP then ingredqty, ingreditemcost, ingredOU, unitcost, itemcost, ou
      all types then ?? }
    with wwtInvoice do
    begin
      FieldByName('OU').ReadOnly := true;
      FieldByName('ItemTax').ReadOnly := false;
      // ensure that all Sort Fields are set to readonly = false
      wwtInvoiceSortImpExpRef.ReadOnly := false;
      wwtInvoiceSortItemCost.ReadOnly := false;
      wwtInvoiceSortItemName.ReadOnly := false;
      wwtInvoiceSortQty.ReadOnly := false;
      wwtInvoiceSortSubcat.ReadOnly := false;
      if not VarIsNull(FieldByName('PurchaseItemType').Value) then
        Case FieldByName('PurchaseItemType').Value of
          MULTI_PURCH_NONE :
            begin
              FieldByName('IngredItemCost').ReadOnly := true;
              FieldByName('Qty').ReadOnly := false;
              if CostPricesAreReadOnly then
              begin
                FieldByName('UCost').ReadOnly := true;
                FieldByName('ItemCost').ReadOnly := true;
              end
              else
              begin
                FieldByName('UCost').ReadOnly := false;
                FieldByName('ItemCost').ReadOnly := false;
              end;
            end;
          MULTI_PURCH_PARENT :
            begin
              FieldByName('IngredItemCost').ReadOnly := true;
              FieldByName('UCost').ReadOnly := true;
              FieldByName('Qty').ReadOnly := false;
              FieldByName('ItemCost').ReadOnly := true;
            end;
          MULTI_PURCH_CHILD :
            begin
              FieldByName('Qty').ReadOnly := true;
              FieldByName('ItemCost').ReadOnly := true;
              if CostPricesAreReadOnly then
              begin
                FieldByName('IngredItemCost').ReadOnly := true;
                FieldByName('UCost').ReadOnly := true;
              end
              else
              begin
                FieldByName('IngredItemCost').ReadOnly := false;
                FieldByName('UCost').ReadOnly := false;
              end;
            end;
        end;
    end;
  end
  else        // AEnabled is false so set all fields.readonly to true
  begin
    for i := 0 to wwtInvoice.Fields.Count-1 do
    begin
      if not ((wwtInvoice.Fields[i].FieldName = 'RecNo') or (wwtInvoice.Fields[i].FieldName = 'SortSubcat')) then
        wwtInvoice.Fields[i].ReadOnly := true;
    end;
  end;
end;

//TODO:  The code in this procedure should be moved somewhere else
procedure Tfinvfrm.UpdateGridFieldsEnabled;
begin
  if (wwtInvoice.FieldByName('ReadOnly').AsBoolean) then
  begin
    EnableAllGridFields(false);
  end
  else
  begin
    EnableAllGridFields(true);
  end;
end;

procedure Tfinvfrm.GetAcceptedItemsExist;
begin
  InvoiceHasAcceptedItems := false;
  with wwtInvoice do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('ReadOnly').AsBoolean then
      begin
        InvoiceHasAcceptedItems := true;
        break;
      end;
      Next;
    end;
  end;
end;


procedure Tfinvfrm.DeleteInvoiceActionExecute(Sender: TObject);
begin
  log.event('finvfrm; Delete Invoice button pressed');
  if messagedlg('If you continue the current ' + GetLocalisedName(lsInvoice) + ' will be lost!',
                mtWarning, [mbOk, mbCancel], 0) = mrCancel then
    exit;
  deleting := true;

  if (Task = TASK_EDIT) OR (Task = TASK_AUDIT) then
  begin
     with wwtpurchhead do
     begin
       log.event('finvfrm; DeleteInvoiceAction: wwtpurchhead opened: ' + wwtPurchHead.TableName);
       open;
       if Locate('Site Code;Supplier Name;Delivery Note No.',
                  VarArrayOf([SiteCode, thesupplier, invoiceno]), []) then
       begin
         { TODO -owilma -ctidy up :
Why is there a check for FindField('deleted')?.  wwtpurchhead.tablename is always
PurchHdr which has a 'deleted' field. }
         Log.Event('finvfrm; DeleteInvoiceActionExecute: Deleting invoice ' + wwtPurchHead.FieldByName('Delivery Note No.').AsString);
         if not (FindField('deleted') = nil) then
         begin
           edit;
           FieldByName('modified by').asstring := CurrentUser.UserName;
           FieldByName('LMDT').asdatetime := Now;
           FieldByName('note').asstring := EditNote.Text;
           FieldByName('date').asdatetime := thedate;
           FieldByName('deleted').asstring := 'Y';
           post;
         end
         else
         begin
           delete;
         end;

         DeleteTheInvoice('DeleteInvoiceAction');

         DeleteInvoiceFromLog;

         // integration with iStocks - call stored procedure stkSP_ECLPurch
         with dmADO.adoqRun do
         begin
           Close;
           SQL.Clear;
           SQL.Add('exec stkSP_ECLPurch');
           ExecSQL;
           Close;
         end;
       end
       else
       begin
         showmessage('Could not locate this ' + GetLocalisedName(lsInvoice) + ' in the Header!');
       end;
       close;
    end;
  end;
  ModalResult := mrOK;
end;

procedure Tfinvfrm.DeleteInvoiceActionUpdate(Sender: TObject);
begin
  Case Task of
    TASK_VIEW_CURR, TASK_VIEW_ACC :
      DeleteInvoiceAction.Enabled := False;
    TASK_ADD, TASK_AUDIT_ADD :
      DeleteInvoiceAction.Enabled := wwtInvoice.Active;
    TASK_EDIT :
      DeleteInvoiceAction.Enabled := ( (not CurrentInvoiceFrozen) and (not InvoiceHasAcceptedItems) );
    TASK_AUDIT :
      DeleteInvoiceAction.Enabled := (not InvoiceHasAcceptedItems);
  end;
end;

procedure Tfinvfrm.UpdateMultiPurchValues;
var
  NewItemCost: currency;
begin
  if (ParentQtyChanged) then
  begin
    wwtInvoice.Refresh;
    ParentQtyChanged := false;
  end
  else if ChildUnitCostChanged or ChildItemCostChanged then
  begin
    try
      // Update the item cost of the MultiPurchase parent item (sum of ingredient item costs)
      with wwqGeneric do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select sum([IngredItemCost]) AS NewItemCost');
        SQL.Add('from Invoice');
        SQL.Add('where MultiPurchParentID = ' + FloatToStr(lastParent));
        SQL.Add('and PurchaseItemType = 2');
        SQL.Add('and GroupRecID = ' + FloatToStr(lastGroupRecID));
        open;
        NewItemCost := FieldByName('NewItemCost').Value;
        Close;
        SQL.Clear;
        SQL.Add('UPDATE INVOICE');
        SQL.Add('SET ItemCost = ' + FloatToStr(NewItemCost) + ',');
        SQL.Add('    SortItemCost = ' + FloatToStr(NewItemCost));
        SQL.Add('WHERE ItemID = ' + FloatToStr(lastParent));
        SQL.Add('AND GroupRecID = ' + FloatToStr(lastGroupRecID));
        SQL.Add('AND PurchaseItemType = 1');
//        SQL.Add('UPDATE INVOICE');
//        SQL.Add('SET ItemCost = b.NewItemCost from');
//        SQL.Add('  Invoice a,');
//        SQL.Add('  (select distinct GroupRecID, sum([IngredItemCost]) AS NewItemCost');
//        SQL.Add('   from Invoice');
//        SQL.Add('   where MultiPurchParentID = ' + FloatToStr(lastParent));
//        SQL.Add('   and PurchaseItemType = 2');
//        SQL.Add('   group by GroupRecID) b');
//        SQL.Add('WHERE a.GroupRecID = b.GroupRecID');
//        SQL.Add('AND a.GroupRecID = ' + FloatToStr(lastGroupRecID));
//        SQL.Add('AND a.PurchaseItemType = 1');
        ExecSQL;
        Close;
        SQL.Clear;
        SQL.Add('UPDATE INVOICE');
        SQL.Add('SET SortItemCost = ' + FloatToStr(NewItemCost));
        SQL.Add('WHERE MultiPurchParentID = ' + FloatToStr(lastParent));
        SQL.Add('AND GroupRecID = ' + FloatToStr(lastGroupRecID));
        SQL.Add('AND PurchaseItemType = 2');
        ExecSQL;
        Close;
      end;
    except
      on E: Exception do
      begin
        Log.Event('finvfrm; ERROR - UpdateMultiPurchValues: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
        raise;
      end;
    end;
    wwtInvoice.Refresh;
    ChildUnitCostChanged := false;
    ChildItemCostChanged := false;
  end;
end;


procedure Tfinvfrm.ToggleFreezeActionExecute(Sender: TObject);
begin
  if ToggleFreezeAction.Caption = 'Freeze' + #13 + GetLocalisedName(lsInvoice) then
  begin
    log.event('finvfrm; Freeze/Unfreeze button pressed - Freeze action');
    FrozenDate := now;
    FrozenBy := CurrentUser.UserName;
    UpdateFrozenAmended(FrozenDate, CHANGE_TYPE_FROZEN);
    ToggleFreezeAction.Caption := 'Unfreeze' + #13 + GetLocalisedName(lsInvoice);
    lblFrozen.Caption := 'This ' + GetLocalisedName(lsInvoice) + ' was frozen on ' + FormatDateTime(theDateFormat, now);
    CurrentInvoiceFrozen := true;
  end
  else
  begin
    log.event('finvfrm; Freeze/Unfreeze button pressed - Unfreeze action');
    UnfreezeInvoice;
    ToggleFreezeAction.Caption := 'Freeze' + #13 + GetLocalisedName(lsInvoice);
    lblFrozen.Caption := '';
    CurrentInvoiceFrozen := false;
  end;
end;

procedure Tfinvfrm.UpdateFrozenAmended(theDate: TDateTime; changeType: smallint);
var
  dateTimeStr: string;
begin
  dateTimeStr := FormatDateTime('yyyymmdd hh:nn:ss', theDate);
  try
    with wwqGeneric do
    begin
      close;
      SQL.Clear;
      SQL.Add('UPDATE [dbo].[PurchHdrAztec]');
      if ChangeType = CHANGE_TYPE_FROZEN then
      begin
        SQL.Add('SET [Frozen] = 1,');
        SQL.Add('    [FrozenOn]= ''' + dateTimeStr + ''',');
        SQL.Add('    [FrozenBy] = ' + QuotedStr(CurrentUser.UserName));
      end
      else
      begin
        SQL.Add('SET [Amended] = 1');
      end;
      SQL.Add('WHERE [Site Code] = ' + IntToStr(SiteCode));
      SQL.Add('AND [Supplier Name] = ' + QuotedStr(theSupplier));
      SQL.Add('AND [Delivery Note No.] = ' + QuotedStr(invoiceno));
      Log.Event('finvfrm; UpdateFrozenAmended: wwqGeneric opened: ' + wwqGeneric.SQL.Text);
      ExecSQL;
      Close;
    end
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UpdateFrozenAmended: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.UnfreezeInvoice;
begin
  try
    with wwqGeneric do
    begin
      close;
      SQL.Clear;
      SQL.Add('UPDATE [dbo].[PurchHdrAztec]');
      SQL.Add('SET [Frozen] = 0,');
      SQL.Add('    [FrozenOn]= NULL,');
      SQL.Add('    [FrozenBy] = NULL');
      SQL.Add('WHERE [Site Code] = ' + IntToStr(SiteCode));
      SQL.Add('AND [Supplier Name] = ' + QuotedStr(theSupplier));
      SQL.Add('AND [Delivery Note No.] = ' + QuotedStr(invoiceno));
      Log.Event('finvfrm; UnfreezeInvoice: wwqGeneric opened: ' + wwqGeneric.SQL.Text);
      ExecSQL;
      Close;
    end
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - UnfreezeInvoice: ' + E.Message + '; ' + wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.ToggleFreezeActionUpdate(Sender: TObject);
begin
  ToggleFreezeAction.Enabled := ( (Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD) );
end;


procedure Tfinvfrm.GetFrozenAndAmended;
begin
  try
    with qryFrozenAndAmended do
    begin
      Close;
      Parameters.ParamByName('stCode').Value := SiteCode ;
      Parameters.ParamByName('suppName').Value := theSupplier;
      Parameters.ParamByName('invNum').Value := invoiceno;
      Open;
      CurrentInvoiceFrozen := FieldByName('Frozen').AsBoolean;
      CurrentInvoiceAmended := FieldByName('Amended').AsBoolean;
      if CurrentInvoiceFrozen then
      begin
        FrozenDate := FieldByName('FrozenOn').AsDateTime;
        FrozenBy := FieldByName('FrozenBy').AsString;
      end;
      if CurrentInvoiceAmended then
      begin
        AmendedDate := FieldByName('LMDT').AsDateTime;
        AmendedBy := FieldByName('Modified By').AsString;
        LastAmendedLabel.Caption := 'Last amended on ' + FormatDateTime(theDateFormat, AmendedDate) +
                  ' by ' + AmendedBy;
        // Right-justify position of LastAmendedLabel
        LastAmendedLabel.Left := Bevel1.Left + Bevel1.Width - LastAmendedLabel.Width;
      end
      else
      begin
        LastAmendedLabel.Caption := '';
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - GetFrozenAndAmended: ' + E.Message + '; ' + qryFrozenAndAmended.SQL.Text);
      raise;
    end;
  end;
end;


procedure Tfinvfrm.SetAmendedDetails;
begin
  CurrentInvoiceAmended := ( (not (Task = TASK_ADD)) and (not (Task = TASK_AUDIT_ADD)) );  // Job 19213
  if CurrentInvoiceAmended then
  begin
    AmendedDate := now;
    AmendedBy := CurrentUser.UserName;
  end;
end;

procedure Tfinvfrm.wwtInvoiceBeforeScroll(DataSet: TDataSet);
begin
  lastPurchaseItemType := wwtInvoicePurchaseItemType.Value;
end;

procedure Tfinvfrm.wwDBGrid1FieldChanged(Sender: TObject; Field: TField);
begin
  SetAmendedDetails;
end;


function Tfinvfrm.SaveInvoice: boolean;
var
  inv, aStr: string;
begin
  inv := GetLocalisedName(lsInvoice);
  if Copy(inv, 1, 1) = 'I' then
    aStr := 'An '
  else
    aStr := 'A ';

  if (TrimRight(NewInvoiceNo) = '') then
  begin
    Result := FALSE;
    MessageDlg('Please enter ' + LowerCase(aStr + inv) + ' number.', mtInformation, [mbOK], 0);
    EditInvoiceNo.SetFocus;
    Exit;
  end;

  if wwtInvoice.RecordCount = 0 then
  begin
    if MessageDlg('The current ' + inv + ' has no products! ' + aStr + inv +
      ' with no products cannot be saved.' + #13 + #13 + 'Any reference to this ' + inv +
      ' will be deleted. Click "OK" to continue.' + #13 + 'Click "Cancel" to return to the ' + inv + '.',
      mtConfirmation, [mbOK,mbCancel],0) = mrOK then
    begin
      Result := True;
      if (Task = TASK_EDIT) OR (Task = TASK_AUDIT) then
      begin
        with wwtPurchHead do
        begin
          Log.Event('finvfrm; SaveInvoice: wwtPurchHead opened: ' + wwtPurchHead.TableName);
          Open;

          Log.Event('finvfrm; SaveInvoice: Deleting ' + inv + ' ' + invoiceno + ' as it has no products');
          if Locate('Site Code;Supplier Name;Delivery Note No.',
                     VarArrayOf([SiteCode, thesupplier, invoiceno]), []) then
          begin
            if not (FindField('deleted') = nil) then
            begin
              edit;
              FieldByName('modified by').asstring := CurrentUser.UserName;
              FieldByName('LMDT').asdatetime := Now;
              FieldByName('note').asstring := EditNote.Text;
              FieldByName('date').asdatetime := thedate;
              FieldByName('deleted').asstring := 'Y';
              post;
            end
            else
            begin
              delete;
            end;

            DeleteTheInvoice('SaveInvoice');

            DeleteInvoiceFromLog;
          end
          else
            ShowMessage('Could not locate this ' + inv + ' in the Header!');

          Close;
        end;
      end;
    end
    else
    begin
      Result := False;   // user pressed Cancel
      Exit;
    end;
  end
  else
  begin
    Log.Event('finvfrm; SaveInvoice: Saving ' + inv + ' ' + invoiceno);
    SaveInv;
    Result := true;
  end;

  // integration with iStocks - call stored procedure stkSP_ECLPurch
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('exec stkSP_ECLPurch');
    ExecSQL;
    Close;
  end;
end;


procedure Tfinvfrm.NewItemActionExecute(Sender: TObject);
begin
  if fnewitemdlg.wwDataSource1.dataset.RecordCount <= 0 then
  begin
    ShowMessage('There are no items available for selection for supplier ' +
                thesupplier + ' and this supplier is not configured for viewing products for all suppliers.  All items for the supplier must have been ' +
                'included in a stocktake after the date of this ' +
                GetLocalisedName(lsInvoice) + '.');
    exit;
  end;

  howinsert := FROM_NEW_OR_FREE_ITEM;   // new item button...
  //check := false;
  InsertItem(False);
end;

procedure Tfinvfrm.NewItemActionUpdate(Sender: TObject);
begin
  if (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) then
    NewItemAction.Enabled := False
  else
    Case Task of
      TASK_VIEW_CURR, TASK_VIEW_ACC :
        NewItemAction.Enabled := False;
      TASK_ADD, TASK_AUDIT_ADD :
        NewItemAction.Enabled := wwtInvoice.Active;
      TASK_EDIT :
        NewItemAction.Enabled := (not CurrentInvoiceFrozen);
      TASK_AUDIT :
        NewItemAction.Enabled := True;
    end;
end;

function Tfinvfrm.SaveCurrentInvoiceQuery: Boolean;
begin
  Result := True;
  if ( ((Task < TASK_VIEW_CURR) and not CurrentInvoiceFrozen) OR
       (Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD) ) and
     asksave then
  begin
    if SaveRequired then
    begin
      case MessageDlg('Do you want to save the current ' + GetLocalisedName(lsInvoice) +
                          '?', mtConfirmation, mbYesNoCancel,0) of
        mrYes :
          if not SaveInvoice then
                Result := False;
        mrCancel :
          Result := False;
      end;
    end;
  end;
end;


procedure Tfinvfrm.NewInvoiceActionExecute(Sender: TObject);
var
  currAskSave: Boolean;
begin
  log.event('finvfrm; New Invoice button pressed');

  currAskSave := asksave;

  if not SaveCurrentInvoiceQuery then
    Exit;

  fnewinvdlg.StockOrderCombo.ClearSelection;
  fnewinvdlg.InvoiceNoEdit.Clear;

  if fnewinvdlg.showmodal = mrOK then
  begin

    // pre-check whether there are any products for the selected supplier and
    // exit if there are none and if the supplier is not configured for ViewAllSupplierProds
    fnewitemdlg.UpdateVariables(fnewinvdlg.SupplierLookUp.text,
                                FormatDateTime('yyyymmdd', fNewInvDlg.dtDateReceived.Date), Task);
    if not fnewitemdlg.HasProducts then
    begin
      if (Task = TASK_AUDIT_ADD) then
        Task := TASK_AUDIT
      else if (Task = TASK_ADD) then
        Task := TASK_EDIT;
      case Task of
        TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR:
          begin
            try
              qInvalidSubcats.Close;
              qInvalidSubcats.Parameters.ParamByName('delNoteDate').Value := FormatDateTime('yyyymmdd', finvfrm.thedate);
              qInvalidSubcats.Open;
            except
              on E: Exception do
              begin
                Log.Event('finvfrm; ERROR - NewInvoiceActionExecute: ' + E.Message + '; ' + qInvalidSubcats.SQL.Text);
                raise;
              end;
            end;
          end;
      end;
      UpdateFormForSelectedInvoice;
      UpdateProductList;  // reset the product list to displayed delivery note
      asksave := currAskSave;
      Screen.Cursor := crDefault;
      Application.ProcessMessages;
      Exit;
    end;

    if ( (Task = TASK_AUDIT) or (Task = TASK_AUDIT_ADD) )  then
      Task := TASK_AUDIT_ADD
    else
      Task := TASK_ADD;

    OneSupplier := true;
    fnewitemdlg.InitializeToggleSupplierAction;
    thesupplier := fnewinvdlg.SupplierLookUp.text;
    thedate := fnewinvdlg.dtDateReceived.Date;
    invoiceno := fnewinvdlg.InvoiceNoEdit.Text;
    theOrderNo := fnewinvdlg.theOrderNo;
    theMaskID := fnewinvdlg.theMaskID;

    invoiceNoMask := fnewInvDlg.InvoiceNoEdit.EditMask;
    Log.Event('finvfrm; Adding new invoice ' + invoiceNo);
    UpdateFormForNewInvoice;

    wwtInvoice.Close;
    dmADO.EmptySQLTable('Invoice');
    log.event('finvfrm; btnNewInvClick: opening finvfrm.wwtInvoice: ' + wwtInvoice.TableName);

    if FromStockOrder then
    begin
      GetStockOrderItems;
      wwtInvoice.Open;
      Refresh;
      wwdbgrid1.RefreshDisplay;
      Application.ProcessMessages;
      wwdbgrid1.setactivefield('qty');
    end
    else
    begin
      wwtInvoice.Open;
      Refresh;
      wwdbgrid1.RefreshDisplay;
      Application.ProcessMessages;
      NewItemActionExecute(sender);
    end;
  end;

  screen.Cursor := crDefault;
end;

procedure Tfinvfrm.NewInvoiceActionUpdate(Sender: TObject);
begin
  if (IsMaster and (not IsSite)) or (not PurAdd) then
    NewInvoiceAction.Enabled := False;
end;

procedure Tfinvfrm.ShowSummaryActionExecute(Sender: TObject);
var
  thepoint : TPoint;
begin
  log.event('finvfrm; Show Summary button pressed');
  fsumdlg := tfsumdlg.create(self);
  thepoint.x := 0;
  thepoint.y := 0;
  thepoint := label14.ClientToScreen(thepoint);
  fsumdlg.top := thepoint.Y;
  fsumdlg.left := thepoint.X;
  fsumdlg.viewCostPrices := ViewCostPrices;
  fsumdlg.ShowModal;
  // for some reason the the fsumdlg was setting the finvDlg modalResult to a non zero value, thus closing the form.
  ModalResult := 0;

  fsumdlg.free;
end;

procedure Tfinvfrm.ShowSummaryActionUpdate(Sender: TObject);
begin
  Case Task of
    TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR, TASK_VIEW_ACC :
      ShowSummaryAction.Enabled := True;
    TASK_ADD, TASK_AUDIT_ADD :
      ShowSummaryAction.Enabled := wwtInvoice.Active;
  end;
end;

procedure Tfinvfrm.DeleteItemActionExecute(Sender: TObject);

    function getMsgStr(isMultiPurch: boolean): string;
    var
      msgStr: String;
    begin
      if isMultiPurch then
        msgStr := 'Delete ' + copy(wwtinvoice.FieldByName('ItemName').AsString, 1,
                                   length(wwtInvoice.FieldByName('itemname').asstring)-3) + ' from the '
      else
        msgStr := 'Delete ' + wwtinvoice.FieldByName('ItemName').AsString +' from the ';

      Result := msgStr + GetLocalisedName(lsInvoice) + '?';
    end;

    procedure LogDeletion;
    begin
      try
        // Change corresponding record in #TmpItemAuditLog to DELETE_ITEM if the
        // deleted item was previously saved back to the Purchase table, i.e. if
        // OldRecID was retrieved from the Purchase table.
        with AuditLogQry do
        begin
          Close;
          SQL.Clear;
          SQL.Add('UPDATE #TmpItemAuditLog');
          SQL.Add('SET ChangeType = ' + IntToStr(DELETE_ITEM) + ',');
          SQL.Add('    NewUnitCost = 0,');
          SQL.Add('    NewQty = 0,');
          SQL.Add('    NewItemCost = 0');
          SQL.Add('WHERE NewRecID = ' + FloatToStr(wwtInvoiceRecNo.Value));
          SQL.Add('AND ISNULL(OldRecID,0) <> 0');
          ExecSQL;
          // physically delete record from #TmpItemAuditLog as it is new and has never
          // been saved back to the Purchase table (the above update query will not have changed
          // anything)
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM #TmpItemAuditLog');
          SQL.Add('WHERE NewRecID = ' + FloatToStr(wwtInvoiceRecNo.Value));
          SQL.Add('AND ISNULL(OldRecID,0) = 0');
          ExecSQL;
        end;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - DeleteItemActionExecute/LogDeletion: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
          raise;
        end;
      end;
    end;

var
  i, ingredCount, numDeleted: smallint;
  startPosn: real;
  // the recID of the next record in the current sort order for locating after delete
  nextRecSorted: real;
begin
  log.event('finvfrm; Delete Item button pressed');
  startPosn := 0;
  numDeleted := 0;
  
  if wwtinvoice.RecordCount > 0 then
  begin
// Job 20475
    wwtInvoice.DisableControls;
    if wwtInvoicePurchaseItemType.Value = MULTI_PURCH_PARENT then
    begin
      // if messagedlg = mrOK then delete Parent and Children
      if MessageDlg(getMsgStr(true), mtConfirmation, [mbOK, mbCANCEL],0) = mrOK then
      begin
        try
          // get children and updatechanges(0) for each and change oldQty
          with qGetIngreds do
          begin
            Close;
            Parameters.ParamByName('grpID').Value := wwtInvoiceGroupRecID.Value;
            Open;
            ingredCount := RecordCount;
            First;
            while not Eof do
            begin
              OldQty := qGetIngreds.FieldByName('IngredQty').Value;
              Next;
            end;
            Close;
          end;
        except
          on E: Exception do
          begin
            Log.Event('finvfrm; ERROR - DeleteItemActionExecute (UpdatingChanges): ' + E.Message + '; ' + QGetIngreds.SQL.Text);
            raise;
          end;
        end;
        // delete the parent and children
        // save position of next record for updating recIDs
        numDeleted := ingredCount + 1;
        startPosn := wwtInvoiceRecNo.Value + numDeleted;
        Log.Event('finvfrm; DeleteItemActionExecute: Deleting item ' + wwtInvoiceItemName.Value);
        wwtInvoice.Delete;     // parent
        for i := 1 to ingredCount do
        begin
          LogDeletion;
          wwtInvoice.Delete;   // ingredient
        end;
      end;
    end
    else
    begin
      if MessageDlg(getMsgStr(false), mtConfirmation, [mbOK, mbCANCEL],0) = mrOK then
      begin
        numDeleted := 1;
        startPosn := wwtInvoiceRecNo.Value + 1;
        LogDeletion;
        Log.Event('finvfrm; DeleteItemActionExecute: Deleting item ' + wwtInvoiceItemName.Value);
        wwtinvoice.Delete;
      end;
    end;

    // save the position of the next record in the grid for the current sort order
    if (wwtInvoicePurchaseItemType.Value = MULTI_PURCH_CHILD) then
      nextRecSorted := wwtInvoiceGroupRecID.Value
    else
      nextRecSorted := wwtInvoiceRecNo.Value;

    if (wwtInvoiceRecNo.Value >= startPosn) then
      nextRecSorted := nextRecSorted - numDeleted;

    MoveItemsUp(startPosn, numDeleted);  // update the recIDs of remaining records

    // restore the original sort order
    case currentSortIndex of
      SORT_SUBCAT:       SubcatRetNameRB.OnClick(SubcatRetNameRB);
      SORT_IMP_EXP:      ImpExpRefRB.OnClick(ImpExpRefRB);
      SORT_DESC_TOTAL:   DescTotCostRB.OnClick(DescTotCostRB);
      SORT_ASC_DELIVERY: AscDeliveryRB.OnClick(AscDeliveryRB);
      SORT_NATURAL:      naturalSortRB.OnClick(naturalSortRB);
      else
          naturalSortRB.OnClick(naturalSortRB);
    end;

    wwtInvoice.EnableControls;
    wwtInvoice.Locate('RecNo', nextRecSorted, []);
  end;

  wwdbgrid1.SetFocus;
end;

procedure Tfinvfrm.DeleteItemActionUpdate(Sender: TObject);
begin
  if ( (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) or
       (wwtInvoice.FieldByName('ReadOnly').AsBoolean) ) then
    DeleteItemAction.Enabled := False
  else
    Case Task of
      TASK_VIEW_CURR, TASK_VIEW_ACC :
        DeleteItemAction.Enabled := False;
      TASK_ADD, TASK_AUDIT_ADD :
        DeleteItemAction.Enabled := wwtInvoice.Active;
      TASK_EDIT :
        DeleteItemAction.Enabled := (not CurrentInvoiceFrozen);
      TASK_AUDIT :
        DeleteItemAction.Enabled := True;
    end;
end;

procedure Tfinvfrm.ItemSearchActionExecute(Sender: TObject);
begin
  log.event('finvfrm; Item Search button pressed');
  fnewitemdlg.task := TASK_SEARCH_ITEM;
  fnewitemdlg.selitem := selitem;
  if fnewitemdlg.showmodal = mrCancel then
  begin
    exit;
  end;
  fnewitemdlg.wwqSearch.close;
  wwtinvoice.Locate('recno', searchrec,[]);
  wwdbgrid1.Refresh;
end;

procedure Tfinvfrm.ItemSearchActionUpdate(Sender: TObject);
begin
  Case Task of
    TASK_ADD, TASK_AUDIT_ADD :
      ItemSearchAction.Enabled := wwtInvoice.Active;
    TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR, TASK_VIEW_ACC :
      ItemSearchAction.Enabled := True;
  end;
end;

procedure Tfinvfrm.UpdateComponentsForTask;
begin
  GetTotals;

  case Task of
    TASK_ADD, TASK_AUDIT_ADD :
      begin
        asksave := True;
        // need to set caption and grid options for TASK_ADD in case the task has
        // to been changed to TASK_ADD by pressing btnNewInv
        Caption := 'Add New ' + GetLocalisedName(lsInvoice) + '...';
        invtot := 0.0;
        wwdbgrid1.Options := [dgEditing,dgAlwaysShowEditor,dgTitles,dgIndicator,
                              dgColumnResize,dgColLines,dgRowLines,dgTabs,dgWordWrap];
        wwdbgrid1.KeyOptions := [dgentertotab,dgallowdelete,dgallowinsert];
      end;
    TASK_AUDIT :
      begin
        asksave := False;
        // need to set the caption in case the task has been changed from
        // TASK_AUDIT_ADD to TASK_AUDIT by pressing btnInvoiceSearch
        Caption := 'Audit ' + GetLocalisedName(lsInvoice) + '...';
      end;
    TASK_EDIT :
      begin
        asksave := False;
        if CurrentInvoiceFrozen then
        begin
          Caption := 'View Current ' + GetLocalisedName(lsInvoice) + '...';
          wwdbgrid1.Options := [dgTitles,dgIndicator,dgAlwaysShowSelection,
                                dgColumnResize,dgColLines,dgRowLines,dgTabs,
                                dgRowSelect,dgWordWrap];
          wwdbgrid1.KeyOptions := [];
        end
        else
        begin
          Caption := 'Edit ' + GetLocalisedName(lsInvoice) + '...';
          wwdbgrid1.Options := [dgEditing,dgAlwaysShowEditor,dgTitles,dgIndicator,
                                dgColumnResize,dgColLines,dgRowLines,dgTabs,dgWordWrap];
          wwdbgrid1.KeyOptions := [dgentertotab,dgallowdelete,dgallowinsert];
        end;
      end;
    TASK_VIEW_CURR, TASK_VIEW_ACC :
      begin
        wwdbgrid1.Options := [dgTitles,dgIndicator,dgAlwaysShowSelection,
                            dgColumnResize,dgColLines,dgRowLines,dgTabs,
                            dgRowSelect,dgWordWrap];
        wwdbgrid1.KeyOptions := [];
      end;
  end;
end;

// Create a temporary log table for saving to PurchAuditLog if
// the delivery note is changed
procedure Tfinvfrm.CreateTempAuditTable;
begin
  if dmADO.SQLTableExists('#TmpHdrAuditLog') then dmADO.DelSQLTable('#TmpHdrAuditLog');
  if dmADO.SQLTableExists('#TmpItemAuditLog') then dmADO.DelSQLTable('#TmpItemAuditLog');
  try
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE [#TmpHdrAuditLog] (');
      SQL.Add('  [SiteCode] [smallint] NULL ,');
      SQL.Add('  [SupplierName] [varchar] (20) collate database_default NULL ,');
      SQL.Add('  [DeliveryNoteNo] [varchar] (15) collate database_default NULL ,');
      SQL.Add('  [OldDelNoteNo] [varchar] (15) collate database_default NULL ,');
      SQL.Add('  [NewDelNoteNo] [varchar] (15) collate database_default NULL ,');
      SQL.Add('  [OldDelNoteDate] [datetime] NULL ,');
      SQL.Add('  [NewDelNoteDate] [datetime] NULL ,');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE [#TmpItemAuditLog] (');
      SQL.Add('  [OldRecID] [float] NULL ,');
      SQL.Add('  [NewRecID] [float] NULL ,');
      SQL.Add('  [OldGroupRecID] [float] NULL ,');
      SQL.Add('  [NewGroupRecID] [float] NULL ,');
      SQL.Add('  [Product] [float] NULL ,');
      SQL.Add('  [OldUnitCost] [float] NULL ,');
      SQL.Add('  [NewUnitCost] [float] NULL ,');
      SQL.Add('  [OldQty] [float] NULL ,');
      SQL.Add('  [NewQty] [float] NULL ,');
      SQL.Add('  [OldItemCost] [float] NULL ,');
      SQL.Add('  [NewItemCost] [float] NULL ,');
      SQL.Add('  [ChangeType] [smallint] NULL');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO #TmpHdrAuditLog ([SiteCode], [SupplierName], [DeliveryNoteNo], ');
      SQL.Add('[OldDelNoteNo], [NewDelNoteNo], [OldDelNoteDate], [NewDelNoteDate])');
      SQL.Add('VALUES (' + IntToStr(SiteCode) + ', :theSupplier, :DeliveryNoteNo,');
      SQL.Add(' :NewDelNoteNo, :OldDelNoteNo,');
      SQL.Add('''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', theDate) + ''',''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', theDate) + ''')');

      Parameters.ParamByName('theSupplier').Value := theSupplier;
      Parameters.ParamByName('DeliveryNoteNo').Value := invoiceNo;
      Parameters.ParamByName('NewDelNoteNo').Value := invoiceNo;
      Parameters.ParamByName('OldDelNoteNo').Value := invoiceNo;
      ExecSQL;
      Close;

      SQL.Clear;
      SQL.Add('INSERT #TmpItemAuditLog');
      SQL.Add('SELECT [RecNo], [RecNo], [GroupRecID], [GroupRecID], [ItemID], [UCost], [UCost],');
      SQL.Add('OldQty = case PurchaseItemType when 2 then [IngredQty] else [Qty] end,');
      SQL.Add('NewQty = case PurchaseItemType when 2 then [IngredQty] else [Qty] end,');
      SQL.Add('OldItemCost = case PurchaseItemType when 2 then [IngredItemCost] else [ItemCost] end,');
      SQL.Add('NewItemCost = case PurchaseItemType when 2 then [IngredItemCost] else [ItemCost] end,');
      SQL.Add(IntToStr(CHANGE_ITEM));
      SQL.Add('FROM [Invoice] WHERE PurchaseItemType IN (0,2)');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - CreateTempAuditTable: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

// check if there are any audit log records
function Tfinvfrm.HasAuditHistory: Boolean;
begin
  try
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT [RecID]');
      SQL.Add('FROM [PurchAuditLog]');
      SQL.Add('WHERE [SiteCode] = ' + IntToStr(SiteCode));
      SQL.Add('AND [SupplierName] = ' + QuotedStr(theSupplier));
      SQL.Add('AND [DeliveryNoteNo] = ' + QuotedStr(invoiceno));
      Open;
      Result := (RecordCount > 0);
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - HasAuditHistory: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

// Create retrospective audit records
// (Need to do this as the report fails in all task modes if there are no records in the
//  subAuditReport datasource - it seems to be a bug in ReportBuilder)
procedure Tfinvfrm.AddInitialAuditHistory;
begin
  try
    with AuditLogQry do
    begin
      // insert "CreateInvoice" log record
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO [PurchAuditLog]([SiteCode], [SupplierName], [DeliveryNoteNo],');
      SQL.Add('[RecID], [ChangeType], [LMDT], [Modified By], [OldDelNoteNo], ');
      SQL.Add('[NewDelNoteNo], [OldDelNoteDate], [NewDelNoteDate])');
      SQL.Add('SELECT ' + IntToStr(SiteCode) + ', :SupplierName, :DeliveryNoteNo,');
      SQL.Add('null, ' + IntToStr(INVOICE_CREATE) + ', ''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', theDate) + ''', ' + QuotedStr(CurrentUser.UserName) +',');
      SQL.Add(' :NewDelNoteNo, :OldDelNoteNo,');
      SQL.Add(''''  + FormatDateTime('yyyy/mm/dd hh:nn:ss', theDate) + ''', ');
      SQL.Add('''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', theDate) + '''');
      Parameters.ParamByName('SupplierName').Value := theSupplier;
      Parameters.ParamByName('DeliveryNoteNo').Value := invoiceNo;
      Parameters.ParamByName('NewDelNoteNo').Value := invoiceNo;
      Parameters.ParamByName('OldDelNoteNo').Value := invoiceNo;
      ExecSQL;
      // insert "CreateItem" log records for each of the items
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO PurchAuditLog([SiteCode], [SupplierName], [DeliveryNoteNo],');
      SQL.Add('[RecID], [ChangeType], [LMDT], [Modified By], [Product], [OldUnitCost], [NewUnitCost],');
      SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost])');
      SQL.Add('SELECT ' + IntToStr(SiteCode) + ', :SupplierName, :DeliveryNoteNo,');
      SQL.Add('[RecNo], ' + IntToStr(ADD_ITEM) + ', ''' + FormatDateTime('yyyy/mm/dd hh:nn:ss',theDate) + ''', ' + QuotedStr(CurrentUser.UserName) + ',');
      SQL.Add('[ItemID], 0 as OldUnitCost, [uCost] as NewUnitCost,');
      SQL.Add('0 as OldQty, NewQty = case PurchaseItemType when 2 then [IngredQty] else [Qty] end,');
      SQL.Add('0 as OldItemCost, NewItemCost = case PurchaseItemType when 2 then [IngredItemCost] else [ItemCost] end');
      SQL.Add('from Invoice');
      SQL.Add('where PurchaseItemType in (0,2)');
      Parameters.ParamByName('SupplierName').Value := theSupplier;
      Parameters.ParamByName('DeliveryNoteNo').Value := invoiceNo;
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - AddInitialAuditHistory: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfinvfrm.LoadAuditHistory;
begin
  if dmADO.SQLTableExists('#ItemAudit') then dmADO.DelSQLTable('#ItemAudit');
  if dmADO.SQLTableExists('#ItemDeleteAudit') then dmADO.DelSQLTable('#ItemDeleteAudit');
  if dmADO.SQLTableExists('#HeaderAudit') then dmADO.DelSQLTable('#HeaderAudit');
  try
    // load the audit log records
    with AuditLogQry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE [#HeaderAudit] (');
      SQL.Add('	[LMDT] [datetime] NULL ,');
      SQL.Add('	[Modified By] [varchar] (20) collate database_default NULL ,');
      SQL.Add('	[ChangeType] [smallint] NULL ,');
      SQL.Add('	[OldDelNoteNo] [varchar] (15) collate database_default NULL ,');
      SQL.Add('	[NewDelNoteNo] [varchar] (15) collate database_default NULL ,');
      SQL.Add('	[OldDelNoteDate] [datetime] NULL ,');
      SQL.Add('	[NewDelNoteDate] [datetime] NULL');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE [#ItemAudit] (');
      SQL.Add('	[RecID] [float] NULL ,');
      SQL.Add('	[ChangeType] [smallint] NULL ,');
      SQL.Add('	[Product] [float] NULL ,');
      SQL.Add('	[OldUnitCost] [float] NULL ,');
      SQL.Add('	[NewUnitCost] [float] NULL ,');
      SQL.Add('	[OldQty] [float] NULL ,');
      SQL.Add('	[NewQty] [float] NULL ,');
      SQL.Add('	[OldItemCost] [float] NULL ,');
      SQL.Add('	[NewItemCost] [float] NULL ,');
      SQL.Add('	[LMDT] [datetime] NULL ,');
      SQL.Add('	[Modified By] [varchar] (20) collate database_default NULL');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE [#ItemDeleteAudit] (');
      SQL.Add('	[RecID] [float] NULL ,');
      SQL.Add('	[ChangeType] [smallint] NULL ,');
      SQL.Add('	[Product] [float] NULL ,');
      SQL.Add('	[PurchaseName] [varchar] (40) collate database_default NULL ,');
      SQL.Add('	[OldUnitCost] [float] NULL ,');
      SQL.Add('	[NewUnitCost] [float] NULL ,');
      SQL.Add('	[OldQty] [float] NULL ,');
      SQL.Add('	[NewQty] [float] NULL ,');
      SQL.Add('	[OldItemCost] [float] NULL ,');
      SQL.Add('	[NewItemCost] [float] NULL ,');
      SQL.Add('	[LMDT] [datetime] NULL ,');
      SQL.Add('	[Modified By] [varchar] (20) collate database_default NULL');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;
      Close;
      SQL.Clear;
      if (Task = TASK_ADD) or (Task = TASK_AUDIT_ADD) then
      begin
        // HEADER
        Close;
        SQL.Clear;
        SQL.Add('INSERT #HeaderAudit');
        SQL.Add('SELECT ''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', now) + ''',' + QuotedStr(CurrentUser.UserName) + ',');
        SQL.Add(IntToStr(INVOICE_CREATE) + ' AS ChangeType, [OldDelNoteNo], [NewDelNoteNo], [OldDelNoteDate], [NewDelNoteDate]');
        SQL.Add('FROM [#TmpHdrAuditLog]');
        ExecSQL;
        // ITEMS
        // in Add mode, if there are multi-purchase items or items have been inserted between items,
        // the recID in the Invoice table will be different from the recID in PurchAuditLog so the
        // report will not be able to show the history for items in the Invoice table.
        // A way round this is to use #TmpItemAuditLog instead
        Close;
        SQL.Clear;
        SQL.Add('INSERT #ItemAudit');
        SQL.Add('SELECT [OldRecID], [ChangeType], [Product], [OldUnitCost], [NewUnitCost],');
        SQL.Add('[OldQty], [NewQty], [OldItemCost], [NewItemCost],');
        SQL.Add('''' + FormatDateTime('yyyy/mm/dd hh:nn:ss', now) + ''',' + QuotedStr(CurrentUser.UserName));
        SQL.Add('FROM [#TmpItemAuditLog]');
        ExecSQL;
      end
      else
      begin
        // HEADER
        Close;
        SQL.Clear;
        SQL.Add('INSERT #HeaderAudit');
        SQL.Add('SELECT [LMDT], [Modified By], [ChangeType], [OldDelNoteNo], [NewDelNoteNo],');
        SQL.Add('[OldDelNoteDate], [NewDelNoteDate]');
        SQL.Add('FROM [PurchAuditLog]');
        SQL.Add('WHERE [SiteCode] = ' + IntToStr(SiteCode));
        SQL.Add('AND [SupplierName] = ' + QuotedStr(theSupplier));
        SQL.Add('AND [DeliveryNoteNo] = ' + QuotedStr(invoiceno));
        SQL.Add('AND [ChangeType] in (' + IntToStr(INVOICE_CREATE) + ',' + IntToStr(HEADER_CHANGE) + ')');
        SQL.Add('ORDER BY [LMDT]');
        ExecSQL;
        // ITEMS
        Close;
        SQL.Clear;
        SQL.Add('INSERT #ItemAudit');
        SQL.Add('SELECT [RecID], [ChangeType], [Product],');
        SQL.Add('[OldUnitCost], [NewUnitCost], [OldQty], [NewQty],');
        SQL.Add('[OldItemCost], [NewItemCost], [LMDT], [Modified By]');
        SQL.Add('FROM [PurchAuditLog]');
        SQL.Add('WHERE [SiteCode] = ' + IntToStr(SiteCode));
        SQL.Add('AND [SupplierName] = ' + QuotedStr(theSupplier));
        SQL.Add('AND [DeliveryNoteNo] = ' + QuotedStr(invoiceno));
        SQL.Add('AND [ChangeType] in (' + IntToStr(ADD_ITEM) + ',' + IntToStr(CHANGE_ITEM) + ')');
        SQL.Add('ORDER BY [RecID], [ChangeType], [LMDT]');
        ExecSQL;
        // DELETED ITEMS
        Close;
        SQL.Clear;
        SQL.Add('INSERT #ItemDeleteAudit');
        SQL.Add('SELECT pl.[RecID], pl.[ChangeType], pl.[Product], pr.[Purchase Name],');
        SQL.Add('pl.[OldUnitCost], pl.[NewUnitCost], pl.[OldQty], pl.[NewQty],');
        SQL.Add('pl.[OldItemCost], pl.[NewItemCost], pl.[LMDT], pl.[Modified By]');
        SQL.Add('FROM [PurchAuditLog] pl, [Products] pr');
        SQL.Add('WHERE pl.[SiteCode] = ' + IntToStr(SiteCode));
        SQL.Add('AND pl.[SupplierName] = ' + QuotedStr(theSupplier));
        SQL.Add('AND pl.[DeliveryNoteNo] = ' + QuotedStr(invoiceno));
        SQL.Add('AND pl.[ChangeType] in (' + IntToStr(DELETE_CREATE_ITEM) + ',' + IntToStr(DELETE_CHANGED_ITEM) + ',' + IntToStr(DELETE_ITEM) + ')');
        SQL.Add('AND pl.[Product] = pr.[EntityCode]');
        SQL.Add('ORDER BY pl.[RecID], pl.[ChangeType], pl.[LMDT]');
        ExecSQL;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvfrm; ERROR - LoadAuditHistory: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
      raise;
    end;
  end;
end;

{ TODO -owilma -ctidy up :
This code is basically saving the current invoice, selecting another invoice
and displaying the selected invoice on the screen.  It is almost the same as
when the form is opened from uInvMenu.  The code should be moved into common
procedures. }
procedure Tfinvfrm.InvoiceSearchActionExecute(Sender: TObject);
var
  msgStr1, msgStr2, logStr: String;
begin
  log.event('finvfrm; Invoice Search button pressed');
  if not SaveCurrentInvoiceQuery then
    Exit;

  scroll := false;

  msgStr1 := 'current ';
  case Task of
    TASK_EDIT :
      begin
        msgStr2 := ' to edit';
        logStr := 'btnEditInvClick: ';
      end;
    TASK_AUDIT, TASK_AUDIT_ADD :
      begin
        msgStr2 := ' to audit';
        logStr := 'btnAuditInvoiceClick: ';
      end;
    TASK_VIEW_CURR :
      begin
        msgStr2 := ' to view';
        logStr := 'btnViewCurrClick: ';
      end;
    TASK_VIEW_ACC :
      begin
        msgStr1 := 'accepted ';
        msgStr2 := ' to view';
        logStr := 'btnViewAccClick: ';
      end;
  end;
  // edit invoice...
  fgetinvdlg.SetTask(Task);
  fgetinvdlg.Caption := 'Select ' + msgStr1 + GetLocalisedName(lsInvoice) + msgStr2 + '...';

  if fgetinvdlg.ShowModal = mrOK then
  begin
    screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    // reset TASK_AUDIT_ADD back to TASK_AUDIT
    if (Task = TASK_AUDIT_ADD) then
      Task := TASK_AUDIT;

    thesupplier := fgetinvdlg.SupplierName;
    thedate := fgetinvdlg.DeliveryNoteDate;
    invoiceno := fgetinvdlg.DeliveryNoteNo;
    theOrderNo := fgetinvdlg.OrderNo;
    theMaskID := fgetinvdlg.theMaskID;
    invoiceNoMask := fgetInvDlg.invoiceNoMask;
    // set top edits...
    EditNote.Text := fgetinvdlg.Note;

    wwtinvoice.DisableControls;
    case Task of
      TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR:
        begin
          try
            qInvalidSubcats.Close;
            qInvalidSubcats.Parameters.ParamByName('delNoteDate').Value := FormatDateTime('yyyymmdd', finvfrm.thedate);
            qInvalidSubcats.Open;
          except
            on E: Exception do
            begin
              Log.Event('finvfrm; ERROR - InvoiceSearchActionExecute: ' + E.Message + '; ' + qInvalidSubcats.SQL.Text);
              raise;
            end;
          end;
          InvoiceManager.MoveToTemporary('Purchase');
        end;
      TASK_VIEW_ACC :
        InvoiceManager.MoveToTemporary( InvoiceManager.GetAccChunkName );
    end;

    log.event('finvfrm; BtnInvoiceSearchClick: opening fInvFrm.wwtInvoice: ' + wwtInvoice.TableName);
    wwtInvoice.open;

    InvoiceManager.SetItemTax;

    UpdateFormForSelectedInvoice;
    UpdateProductList;

    wwtinvoice.EnableControls;
    screen.Cursor := crDefault;

    Refresh;
    wwdbgrid1.RefreshDisplay;
    Application.ProcessMessages;
  end;
end;

procedure Tfinvfrm.InvoiceSearchActionUpdate(Sender: TObject);
begin
  if (Task = TASK_ADD) then
    InvoiceSearchAction.Enabled := false
  else
    InvoiceSearchAction.Enabled := true;
end;

procedure Tfinvfrm.PrintInvoiceActionExecute(Sender: TObject);
var
  inv, aStr: string;
begin
  inv := GetLocalisedName(lsInvoice);
  if Copy(inv, 1, 1) = 'I' then
    aStr := 'An '
  else
    aStr := 'A ';

  if wwtInvoice.RecordCount = 0 then
  begin
    MessageDlg('The current ' + inv + ' has no products! ' + aStr + inv +
      ' with no products cannot be printed.', mtError, [mbOK],0);
    Exit;
  end;

  // in ADD mode, the audit source tables for the report will be empty so they need
  // to be loaded before printing the report because of a bug in ReportBuilder
  if (Task = TASK_ADD) or (Task = TASK_AUDIT_ADD) then
    LoadAuditHistory;

  log.event('finvfrm; PrintInvoiceActionExecute');

  wwtinvoice.DisableControls;

  try
    fsumdlg := tfsumdlg.create(self);

    try
      { TODO -owilma -ctidy up :
Some of this code is repeated in fsumdlg.FormShow - could pull it out into
a fsumdlg public procedure }
      qryReportItems.Close;
      try
        qryReportItems.Open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: qryReportItems, ' + E.Message + '; ' + qryReportItems.SQL.Text);
          raise;
        end;
      end;

      fsumdlg.GetData;
      fsumdlg.wwqByDiv.Close;
      try
        fsumdlg.wwqByDiv.open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: fsumDlg.wwqByDiv, ' + E.Message + '; ' + fsumdlg.wwqByDiv.SQL.Text);
          raise;
        end;
      end;

      HeaderHistory.Close;
      try
        HeaderHistory.Open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: HeaderHistory, ' + E.Message + '; ' + HeaderHistory.SQL.Text);
          raise;
        end;
      end;

      DeletedItems.Close;
      try
        DeletedItems.Open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: DeletedItems, ' + E.Message + '; ' + DeletedItems.SQL.Text);
          raise;
        end;
      end;

      if UKUSMode = 'UK' then
        fsumdlg.CalculateUKSubCatTax;

      log.event('finvfrm; BtnPrintInvoiceClick: fsumdlg.wwqByCtg opened');
      try
        fsumdlg.wwqByCtg.open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: ' + E.Message + '; ' + fsumdlg.wwqByCtg.SQL.Text);
          raise;
        end;
      end;

      log.event('finvfrm; BtnPrintInvoiceClick: fsumdlg.wwqTotal opened');
      try
        fsumdlg.wwqTotal.open;
      except
        on E: Exception do
        begin
          Log.Event('finvfrm; ERROR - PrintInvoiceActionExecute: ' + E.Message + '; ' + fsumdlg.wwqTotal.SQL.Text);
          raise;
        end;
      end;

      labnote.caption := EditNote.text;
      labsite.caption := SiteName;
      labsup.caption := thesupplier;
      // datetostr changed to formatdatetime - MH 10/12/1999
      labdate.caption := formatdatetime('ddddd',thedate);
      labno.caption := invoiceno;

      // show/hide frozen details
      ppLblFrozenOn.Visible := CurrentInvoiceFrozen;
      ppLblFrozenBy.Visible := CurrentInvoiceFrozen;
      ppFrozenOn.Visible := CurrentInvoiceFrozen;
      ppFrozenBy.Visible := CurrentInvoiceFrozen;
      if CurrentInvoiceFrozen then
      begin
        ppFrozenBy.Caption := FrozenBy;
        if UKUSMode = 'UK' then
          ppFrozenOn.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', FrozenDate)
        else
          ppFrozenOn.Caption := FormatDateTime('mm/dd/yyyy hh:nn:ss', FrozenDate);
      end;

      // show/hide amended details
      ppLblAmendedOn.Visible := CurrentInvoiceAmended;
      ppLblAmendedBy.Visible := CurrentInvoiceAmended;
      ppAmendedOn.Visible := CurrentInvoiceAmended;
      ppAmendedBy.Visible := CurrentInvoiceAmended;
      if CurrentInvoiceAmended then
      begin
        ppAmendedBy.Caption := AmendedBy;
        if UKUSMode = 'UK' then
          ppAmendedOn.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', AmendedDate)
        else
          ppAmendedOn.Caption := FormatDateTime('mm/dd/yyyy hh:nn:ss', AmendedDate);
      end;

      if FromStockOrder then
      begin
        StockOrderLbl.Visible := True;
        labStockOrder.Visible := True;
        labStockOrder.Caption := theOrderNo;
      end
      else
      begin
        StockOrderLbl.Visible := False;
        labStockOrder.Visible := False;
        labStockOrder.Caption := '';
      end;

      //format the report for UK/US Mode
      ppRepLabel14.Caption := GetLocalisedName(lsInvoice) + ' Date:';
      ppRepLabel10.Caption := GetLocalisedName(lsInvoice) + ' Number:';
      ppInvSummary.Caption := GetLocalisedName(lsInvoice) + ' Summary:';
      ppInvTotals.Caption  := GetLocalisedName(lsInvoice) + ' Totals:';

      if UKUSmode = 'UK' then
      begin
        ppRepLabel3.Caption := 'Flavour';
        ppRepLabel17.Visible := FALSE;
        ppRepLabel6.Caption := 'Delivery';

        labDate.Left := 169;
        labno.Left := 537;
        ppRepLabel6.Left := 529;
        ppInvTotals.Left := 54;
        ppRepLabel5.Visible := False;
        ppRepLine9.Visible := False;
        ppRepLine17.Visible := False;
        ppRepDBText5.Visible := False;
        // hide tax column line in subReportAudit
        taxColumnLine.Visible := False;

        ppLblTax.Caption := 'VAT';
        ppLblCostAndTax.Caption := 'Cost + VAT';
        hdrAuditLMDT.DisplayFormat := 'dd/mm/yyyy';
        auditLMDT.DisplayFormat := 'dd/mm/yyyy';
        hdrAuditDelNoteDate.DisplayFormat := 'dd/mm/yyyy';
        labtax.Visible := FALSE;
      end
      else
      begin
        ppRepLabel3.Caption := 'Flavor';
        ppRepLabel17.Caption := 'Sales Tax:';
        ppRepLabel6.Caption := 'Received';
        labDate.Left := 130;
        labno.Left := 498;
        ppRepLabel6.Left := 525;
        ppInvTotals.Left := 54;

        ppLblTax.Caption := 'Sales Tax';
        ppLblCostAndTax.Caption := 'Cost + Tax';
        hdrAuditLMDT.DisplayFormat := 'mm/dd/yyyy';
        auditLMDT.DisplayFormat := 'mm/dd/yyyy';
        hdrAuditDelNoteDate.DisplayFormat := 'mm/dd/yyyy';
        labtax.caption := floattostr(thetax) + '%';
      end;


      // Show the DrillDownComponent that opens the subReportAudit
      drillDownHeader.Visible := (Task = TASK_AUDIT);
      SubReportHeader.Visible := (Task = TASK_AUDIT);
      HdrHistLbl.Visible := (Task = TASK_AUDIT);
      ClickYellowLbl.Visible := (Task = TASK_AUDIT);
      YellowShape.Visible := (Task = TASK_AUDIT);
      ExpandLbl.Visible := (Task = TASK_AUDIT);
      ExpandAllShape.Visible := (Task = TASK_AUDIT);
      CollapseLbl.Visible := (Task = TASK_AUDIT);
      CollapseAllShape.Visible := (Task = TASK_AUDIT);
      drillDownItem.Visible := (Task = TASK_AUDIT);
      SubReportItem.Visible := (Task = TASK_AUDIT);
      dellabelregion.Visible := (Task = TASK_AUDIT);
      drilldowndeleted.Visible := (Task = TASK_AUDIT);

      // In Audit mode...
      if (Task = TASK_AUDIT) then
        // Print to screen instead of printer so that the Auditor can view Audit Log
        pprep.DeviceType := dtScreen
      else
        pprep.DeviceType := dtPrinter;

      // have to set these as for some reason ReportBuilder sets them to nil
      // after printing the report once
      CategoryDS.DataSet := fsumdlg.wwqByCtg;
      DivTotalsDS.DataSet := fsumdlg.wwqByDiv;
      CtgTotalsDS.DataSet := fsumdlg.wwqTotal;

      if UKUSMode = 'UK' then
        ppRep.PrinterSetup.PaperName := 'A4'
      else
        ppRep.PrinterSetup.PaperName := 'Letter';

      pprep.Print;
    finally
      fsumdlg.free;
    end;

  finally
    wwtinvoice.EnableControls;
  end;
end;

procedure Tfinvfrm.PrintInvoiceActionUpdate(Sender: TObject);
begin
  Case Task of
    TASK_ADD, TASK_AUDIT_ADD :
      PrintInvoiceAction.Enabled := wwtInvoice.Active;
    TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR, TASK_VIEW_ACC :
      PrintInvoiceAction.Enabled := True;
  end;
end;

procedure Tfinvfrm.FreeItemActionExecute(Sender: TObject);
begin
   howinsert := FROM_NEW_OR_FREE_ITEM;
   InsertItem(True);
end;

procedure Tfinvfrm.FreeItemActionUpdate(Sender: TObject);
begin
  if (wwtInvoice.FieldByName('PurchaseItemType').Value = MULTI_PURCH_CHILD) then
    FreeItemAction.Enabled := False
  else
    case Task of
      TASK_ADD :
        FreeItemAction.Enabled := ( FreeItems and wwtInvoice.Active );
      TASK_EDIT :
        FreeItemAction.Enabled := ( FreeItems and (not CurrentInvoiceFrozen) );
      TASK_AUDIT :
        FreeItemAction.Enabled := True;
      TASK_AUDIT_ADD :
        FreeItemAction.Enabled := wwtInvoice.Active;
      TASK_VIEW_CURR, TASK_VIEW_ACC :
        FreeItemAction.Enabled := False;
    end;
end;

function Tfinvfrm.NewDateInAcceptedStock(newDate: TDate): Boolean;
var
  theQry: TADOQuery;
begin
  theQry := TADOQuery.Create(nil);
  with theQry do
  try
    Connection := dmADO.AztecConn;
    SQL.Text :=
      'select i.ItemID from invoice i join Subcateg s ' + #13#10 +
      '  on s.[Sub-Category Name] = i.[SubCat Name] join Category c ' + #13#10 +
      '  on c.[Index No] = s.[Category Index] join Division d ' + #13#10 +
      '  on d.[Index No] = c.[Division Index] ' + #13#10 +
      'where d.[Division Name] in ' + #13#10 +
      '  ( select st.Division ' + #13#10 +
      '      from Stocks st ' + #13#10 +
      '      where st.TID not in ' + #13#10 +
      '        (select TID ' + #13#10 +
      '         from threads ' + #13#10 +
      '         where ISNULL(NoPurAcc,'''') = ''Y'') ' + #13#10 +
      '      and st.[EDate] >= ' + QuotedStr(FormatDateTime('yyyymmdd',newDate)) + #13#10 +
      '      and st.StockCode > 1 )';
      Open;
      Result := (RecordCount > 0);
  finally
    Close;
    FreeAndNil(theQry);
  end;
end;

procedure Tfinvfrm.SelectDateActionExecute(Sender: TObject);
var
  OrigDate : string;
  localisedStock: string;
begin
  log.event('finvfrm; Date Change button pressed');
  if (UKUSMode = 'US') then
    localisedStock := 'inventory'
  else
    localisedStock := 'stock';

  OrigDate := Label7.Caption;
  fchgDate := TfChgDate.Create(self);
  fchgDate.dtNewDate.Date := thedate; // 15816
  if fchgdate.ShowModal = mrOK then
  begin
    if NewDateInAcceptedStock(fchgDate.dtNewdate.Date) then
    begin
      MessageDlg('The date ' + FormatDateTime(TheDateFormat,fchgdate.dtNewDate.Date) + ' is invalid because ' + #13#10 +
                 'it is within an accepted ' + localisedStock + ' period for at ' + #13#10 +
                 'least one of the items in this ' + GetLocalisedName(lsInvoice) + '.',mtError,[mbOK],0);
      Exit;
    end;
    theDate := fchgdate.dtNewDate.Date;  // 15816
    label7.Caption := FormatDateTime('ddddd',thedate); // 15816
    log.event('finvfrm; Date changed from ' + OrigDate + ' to ' + Label7.Caption);
    asksave := true;
    SetAmendedDetails;
    try
      // save change to #TmpHdrAuditLog (it only has 1 record)
      with AuditLogQry do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE [#TmpHdrAuditLog]');
        SQL.Add('SET [NewDelNoteDate]= ''' + FormatDateTime('yyyy/mm/dd', theDate) + '''');
        ExecSQL;
      end;
    except
      on E: Exception do
      begin
        Log.Event('finvfrm; ERROR - SelectDateActionExecute: ' + E.Message + '; ' + AuditLogQry.SQL.Text);
        raise;
      end;
    end;
  end;
  fchgdate.free;
end;

// Cheating here by setting non-action component properties
// as well as SelectDateAction
procedure Tfinvfrm.SelectDateActionUpdate(Sender: TObject);
begin
  case Task of
    TASK_ADD, TASK_AUDIT_ADD:
      begin
        SelectDateAction.Enabled := True;
        EditInvoiceNo.ReadOnly := False;
        EnableSortGroupBox(True);
        EditNote.Enabled := True;
        wwDBGrid1.ReadOnly := False;
      end;
    TASK_EDIT:
      begin
        SelectDateAction.Enabled := ( (not CurrentInvoiceFrozen) and (not InvoiceHasAcceptedItems) );
        EditInvoiceNo.ReadOnly := ( CurrentInvoiceFrozen or InvoiceHasAcceptedItems );
        EnableSortGroupBox( (not CurrentInvoiceFrozen) );
        EditNote.Enabled := (not CurrentInvoiceFrozen);
        wwDBGrid1.ReadOnly := CurrentInvoiceFrozen;
      end;
    TASK_AUDIT:
      begin
        SelectDateAction.Enabled := ( not InvoiceHasAcceptedItems );
        EditInvoiceNo.ReadOnly := InvoiceHasAcceptedItems;
        EnableSortGroupBox(True);
        EditNote.Enabled := True;
        wwDBGrid1.ReadOnly := False;
      end;
    TASK_VIEW_CURR, TASK_VIEW_ACC :
      begin
        SelectDateAction.Enabled := False;
        EditInvoiceNo.ReadOnly := True;
        EnableSortGroupBox(False);
        EditNote.Enabled := False;
        wwDBGrid1.ReadOnly := True;
      end;
  end;
end;


// make sure that positive values have a plus sign in UK Mode unless they are
// in a "create item", "InvoiceNumChange" or "InvoiceDateChange" audit log record
procedure Tfinvfrm.ppAuditValueGetText(Sender: TObject; var Text: String);
begin
  if UKUSmode = 'UK' then
    if (ppItemAction.Text = IntToStr(CHANGE_ITEM)) then
      if text <> '' then
        if text[1] <> '-' then
          text := '+' + text;
end;

procedure Tfinvfrm.ExpandAllShapeDrawCommandClick(Sender, aDrawCommand: TObject);
begin
  if not ReportExpanded then
    PostMessage(finvfrm.Handle, WM_USER + 3646, 0, 0);
end;

procedure Tfinvfrm.CollapseAllShapeDrawCommandClick(Sender,
  aDrawCommand: TObject);
begin
  ReportExpanded := True;
  if ReportExpanded then
    PostMessage(finvfrm.handle, WM_USER + 3646, 0, 0);
end;

procedure Tfinvfrm.ExpandCollapse(var Msg: TMsg);
begin
  if ReportExpanded then
  begin
    ppRep.CollapseDrillDowns;
    ReportExpanded := False;
  end
  else
  begin
    ppRep.ExpandDrillDowns;
    ReportExpanded := True;
  end;

  ppRep.PrintToDevices;
end;

procedure Tfinvfrm.ppDeleteQtyGetText(Sender: TObject; var Text: String);
begin
  if UKUSmode = 'UK' then
    if not (ppDeleteAction.Text = 'Created') then
      if text <> '' then
        if text[1] <> '-' then
          text := '+' + text;
end;

function Tfinvfrm.SaveRequired: Boolean;
begin
  Result := True;

  //If we are in 'add invoice' mode and a header rec already exists which is not
  //deleted then do no save as there are associated Purchase and PurcReference
  //records which will cause primary key violations.  Allow saving in other modes
  //or when the associated PurchHdrAztec is marked as deleted: in this case the
  //associated Purchase and PurchReference records will have been deleted already.
  if Task = TASK_ADD then
  begin
    with wwtpurchhead do
    begin
      open;
      if locate('supplier name;delivery note no.',
        VarArrayOf([thesupplier, invoiceno]), []) then
        if (FieldByName('deleted').asstring = 'N') or (FieldByName('deleted').IsNull) then
          Result := False;
      Close;
    end;
  end;
end;

end.
