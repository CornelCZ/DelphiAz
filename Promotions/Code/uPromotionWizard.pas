unit uPromotionWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ImgList, Buttons, Grids, DBGrids,
  uDataTree, wwdbdatetimepicker, CheckLst, ActnList, Mask, DBCtrls, Wwdbigrd,
  Wwdbgrid, uGroupPriceMethodFrame, uAztecLog, uGridSortHelper,
  //uPromotionFilterFrame,
  ADODB, uPromoCommon, wwdblook, uAddPortionPriceMapping,
  uSiteTagFilterFrame, uBaseTagFilterFrame, uProductTagFilterFrame,
  uSiteSASelectionFrame, uWizardManager, wwdbedit, Wwdotdot, Wwdbcomb,
  uPromotionFilterFrame;

const
  TIMAGE_TAG_ZONAL_Z_BIG = 101;
  TIMAGE_TAG_ZONAL_Z_SMALL = 102;
  UM_INITFOCUS = WM_USER;
  PANE_RESIZE_LEFT_OFFSET = -27;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;

  FINISH_TEXT = 'You have entered all required details for the Promotion.' + #13#10 +
                'Click ''Back'' to review details, or click Finish to save the Promotion.';
  READONLY_FINISH_TEXT = 'You have reviewed all details for the Promotion.' + #13#10 +
                         'Click ''Back'' to review details or click ''Finish'' to exit the Promotion.';

type
  TExceptionStatus = (esEnabled, esDisabled);

  TProtectionHackedGrid = class(TwwCustomDBGrid);

  TProtectionHackedCheckBox = class(TCheckBox);

  TDataModified = packed record
    SalesAreaSelectionChanged: boolean;
    SalesAreaSelectionUnProcessed: boolean;
    ProductGroupSelection: array of boolean;
    ProductLoadRequired: boolean;
    PriceCalculationRequired: boolean;
    GroupPriceSettingsRefreshRequired: boolean;
    PortionPriceMappingsChanged: boolean;
  end;

  TPromotionWizard = class(TForm)
    pcWizard: TPageControl;
    tsPromoDetails: TTabSheet;
    tsSelectSites: TTabSheet;
    tsSelectProducts: TTabSheet;
    btnBack: TButton;
    btnNext: TButton;
    btClose: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    imZonalBig: TImage;
    lbWizardTitle: TLabel;
    lbWizardDescription: TLabel;
    Label3: TLabel;
    edName: TEdit;
    Label4: TLabel;
    edDescription: TMemo;
    Label5: TLabel;
    cbPromotionType: TComboBox;
    Label6: TLabel;
    cbFavourCustomer: TComboBox;
    Panel3: TPanel;
    Label8: TLabel;
    Bevel1: TBevel;
    lbSelectSitesInfo: TLabel;
    Image2: TImage;
    Panel5: TPanel;
    Label13: TLabel;
    Bevel3: TBevel;
    lbSelectProductsInfo: TLabel;
    Image4: TImage;
    Label11: TLabel;
    tvAvailableProducts: TTreeView;
    sbExcludeAllProducts: TButton;
    sbExcludeProduct: TButton;
    sbIncludeProduct: TButton;
    sbIncludeAllProducts: TButton;
    lbSelectedProducts: TLabel;
    tsSingleRewardPrice: TTabSheet;
    Panel6: TPanel;
    Label17: TLabel;
    Bevel4: TBevel;
    Label18: TLabel;
    Image5: TImage;
    tsDefineGroups: TTabSheet;
    Panel9: TPanel;
    Label23: TLabel;
    Bevel7: TBevel;
    lbDefineGroupsInfo: TLabel;
    Image1: TImage;
    tsGroupPriceMethod: TTabSheet;
    Panel7: TPanel;
    Label19: TLabel;
    Bevel5: TBevel;
    Label20: TLabel;
    Image6: TImage;
    tsGroupPrices: TTabSheet;
    Panel8: TPanel;
    Label21: TLabel;
    Bevel6: TBevel;
    lbGroupPricesInfo: TLabel;
    Image7: TImage;
    tsExceptions: TTabSheet;
    Panel10: TPanel;
    Label26: TLabel;
    Bevel8: TBevel;
    lbExceptionsInfo: TLabel;
    Image8: TImage;
    cbLeaveUnpriced: TCheckBox;
    lbDefineGroups: TLabel;
    btAddGroup: TButton;
    btDeleteGroup: TButton;
    tcProductGroups: TTabControl;
    Label32: TLabel;
    btNewException: TButton;
    btDeleteException: TButton;
    btEditException: TButton;
    PromotionActions: TActionList;
    rbSingleRewardPrice: TRadioButton;
    rbPerSalesAreaRewardPrice: TRadioButton;
    btPriceExport: TButton;
    btPriceImport: TButton;
    rbDefinePricesLater: TRadioButton;
    NextPage: TAction;
    PrevPage: TAction;
    SetRewardPriceMode: TAction;
    dbedRewardPrice: TDBEdit;
    btRewardPriceImport: TButton;
    btRewardPriceExport: TButton;
    RewardPriceExport: TAction;
    RewardPriceImport: TAction;
    dbgRewardPrices: TwwDBGrid;
    sbPromoGroupPriceMethod: TScrollBox;
    Label28: TLabel;
    cbEditPriceGroup: TComboBox;
    Label29: TLabel;
    cbEditPriceSA: TComboBox;
    Label30: TLabel;
    Label33: TLabel;
    dbgPromoPrices: TwwDBGrid;
    btCopyException: TButton;
    btEnableDisable: TButton;
    cbHideDisabledExceptions: TCheckBox;
    tsFinish: TTabSheet;
    Panel11: TPanel;
    Label10: TLabel;
    Bevel9: TBevel;
    Label12: TLabel;
    Image9: TImage;
    Label34: TLabel;
    dbgPromotionGroups: TwwDBGrid;
    GroupPriceExport: TAction;
    GroupPriceImport: TAction;
    DisableException: TAction;
    DeleteException: TAction;
    CopyException: TAction;
    HideDisabledExceptions: TAction;
    dbgrdExceptions: TwwDBGrid;
    EditException: TAction;
    NewException: TAction;
    tsEventPromotionActions: TTabSheet;
    Panel12: TPanel;
    Label35: TLabel;
    Bevel10: TBevel;
    Label36: TLabel;
    Image10: TImage;
    dbgPromotionActions: TwwDBGrid;
    btActivateNoPromotions: TButton;
    btActivateAllPromotions: TButton;
    Label37: TLabel;
    SATreeFindPrev: TAction;
    SATreeFindNext: TAction;
    ProductTreeFindPrev: TAction;
    ProductTreeFindNext: TAction;
    lbPriceHighlightLegend: TLabel;
    lbDuplicateWarning: TLabel;
    PromotionFilterFrame: TPromotionFilterFrame;
    tsPromoActivation: TTabSheet;
    Panel15: TPanel;
    Label38: TLabel;
    Bevel12: TBevel;
    Label41: TLabel;
    Image12: TImage;
    chkbxAllTimes: TCheckBox;
    dstValidTimes: TADODataSet;
    dsValidTimes: TDataSource;
    gbxActiveTimes: TGroupBox;
    btnNewTimePeriod: TButton;
    btnDeleteTimePeriod: TButton;
    pnlTimePeriodEdit: TPanel;
    Label45: TLabel;
    lblStartTime: TLabel;
    lblEndTime: TLabel;
    dtStartTime: TDateTimePicker;
    dtEndTime: TDateTimePicker;
    dbgridValidTimes: TwwDBGrid;
    clbValidDays: TCheckListBox;
    dstValidTimesValidDays: TStringField;
    dstValidTimesStartTime: TDateTimeField;
    dstValidTimesEndTime: TDateTimeField;
    dstValidTimesValidDaysDisplay: TStringField;
    pnlHideFromCustomer: TPanel;
    cbHideFromCustomer: TCheckBox;
    cbHideDisabledPromotions: TCheckBox;
    lbOtherUserChangesWarning: TLabel;
    btnRewardPriceIncDec: TButton;
    btnPriceIncDec: TButton;
    GroupPriceIncDec: TAction;
    RewardPriceIncDec: TAction;
    gbPromoVerification: TGroupBox;
    cbVerification: TComboBox;
    lblSwipeCardGroup: TLabel;
    cbSwipeCardGroup: TComboBox;
    lblCardValidation: TLabel;
    cbValidation: TComboBox;
    pnlValidWithAllPaymentMethods: TPanel;
    cbValidWithAllPaymentMethods: TCheckBox;
    pnlLoyalty: TPanel;
    chkbxLoyaltyPromotion: TCheckBox;
    edtLoyaltyPointsRequired: TEdit;
    lblLoyaltyPointsRequired: TLabel;
    actLoyaltyPromotion: TAction;
    tsPortionPriceMappings: TTabSheet;
    pnlPortionPriceMappingTop: TPanel;
    Bevel2: TBevel;
    lblPortionPriceMapping: TLabel;
    lblDefinePortionPriceMappings: TLabel;
    lblPromotionPriceGroupingInfo: TLabel;
    dbgPortionPriceMapping: TwwDBGrid;
    btnAddPortionPriceMapping: TButton;
    btEditPortionPriceMapping: TButton;
    actAddPortionPriceMapping: TAction;
    actEditPortionPriceMapping: TAction;
    btnDeletePortionPricemapping: TButton;
    actDeletePortionPriceMapping: TAction;
    cbCanIncreasePrice: TCheckBox;
    pnlEventOnly: TPanel;
    cbEventOnly: TCheckBox;
    cbGroupItemsUnderPromotion: TCheckBox;
    ProductTagFilterFrame: TProductTagFilterFrame;
    cmbbxPortion: TComboBox;
    edProductSearchTerm: TEdit;
    btProductFindPrev: TButton;
    btProductFindNext: TButton;
    grpbxProductFilter: TGroupBox;
    chkbxPortionFilter: TCheckBox;
    Label2: TLabel;
    cbReferenceRequired: TCheckBox;
    SiteSASelectionFrame: TSiteSASelectionFrame;
    dbComboRecipeChildrenMode: TwwDBComboBox;
    cbPromotionalDeal: TCheckBox;
    lblStartDate: TLabel;
    lblEndDate: TLabel;
    dtStartDate: TDateTimePicker;
    dtEndDate: TDateTimePicker;
    cbValidWithAllDiscounts: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbIncludeProductClick(Sender: TObject);
    procedure sbIncludeAllProductsClick(Sender: TObject);
    procedure sbExcludeAllProductsClick(Sender: TObject);
    procedure sbExcludeProductClick(Sender: TObject);
    procedure tcProductGroupsChange(Sender: TObject);
    procedure btAddGroupClick(Sender: TObject);
    procedure btDeleteGroupClick(Sender: TObject);
    procedure NextPageExecute(Sender: TObject);
    procedure PrevPageExecute(Sender: TObject);
    procedure SetRewardPriceModeExecute(Sender: TObject);

    procedure tsSelectProductsResize(Sender: TObject);
    procedure RewardPriceExportExecute(Sender: TObject);
    procedure RewardPriceImportExecute(Sender: TObject);
    procedure cbEditPriceGroupCloseUp(Sender: TObject);
    procedure GroupPriceExportExecute(Sender: TObject);
    procedure GroupPriceImportExecute(Sender: TObject);
    procedure DisableExceptionExecute(Sender: TObject);
    procedure DeleteExceptionExecute(Sender: TObject);
    procedure CopyExceptionExecute(Sender: TObject);
    procedure dbgPromoPricesRowChanged(Sender: TObject);
    procedure dbgPromoPricesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure HideDisabledExceptionsExecute(Sender: TObject);
    procedure PromotionActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure NewExceptionExecute(Sender: TObject);
    procedure EditExceptionExecute(Sender: TObject);
    procedure dbgrdExceptionsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure DisableExceptionUpdate(Sender: TObject);
    procedure btActivateAllPromotionsClick(Sender: TObject);
    procedure btActivateNoPromotionsClick(Sender: TObject);
    procedure cbPromotionTypeChange(Sender: TObject);
    procedure SearchTermEnter(Sender: TObject);
    procedure SearchTermExit(Sender: TObject);
    procedure ProductTreeFindUpdate(Sender: TObject);
    procedure ProductTreeFindPrevExecute(Sender: TObject);
    procedure ProductTreeFindNextExecute(Sender: TObject);
    procedure edProductSearchTermChange(Sender: TObject);
    procedure dbgPromoPricesDrawDataCell(Sender: TObject;
      const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure dbgrdExceptionsDrawDataCell(Sender: TObject;
      const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure tsExceptionsShow(Sender: TObject);
    procedure tsExceptionsResize(Sender: TObject);
    procedure tsDefineGroupsShow(Sender: TObject);
    procedure dstValidTimesCalcFields(DataSet: TDataSet);
    procedure dstValidTimesAfterScroll(DataSet: TDataSet);
    procedure dtStartTimeChange(Sender: TObject);
    procedure dtEndTimeChange(Sender: TObject);
    procedure clbValidDaysClickCheck(Sender: TObject);
    procedure btnNewTimePeriodClick(Sender: TObject);
    procedure btnDeleteTimePeriodClick(Sender: TObject);
    procedure chkbxAllTimesClick(Sender: TObject);
    procedure cbHideDisabledPromotionsClick(Sender: TObject);
    procedure cbVerificationChange(Sender: TObject);
    procedure cbSwipeCardGroupChange(Sender: TObject);
    procedure cbValidationChange(Sender: TObject);
    procedure GroupPriceIncDecExecute(Sender: TObject);
    procedure RewardPriceIncDecExecute(Sender: TObject);
    procedure dbgPromoPricesMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure GroupPriceIncDecUpdate(Sender: TObject);
    procedure RewardPriceIncDecUpdate(Sender: TObject);
    procedure RewardPriceExportUpdate(Sender: TObject);
    procedure RewardPriceImportUpdate(Sender: TObject);
    procedure GroupPriceExportUpdate(Sender: TObject);
    procedure GroupPriceImportUpdate(Sender: TObject);
    procedure actLoyaltyPromotionExecute(Sender: TObject);
    procedure edtLoyaltyPointsRequiredKeyPress(Sender: TObject;
      var Key: Char);
    procedure actAddPortionPriceMappingExecute(Sender: TObject);
    procedure actEditPortionPriceMappingExecute(Sender: TObject);
    procedure actDeletePortionPriceMappingExecute(Sender: TObject);
    procedure actEditPortionPriceMappingUpdate(Sender: TObject);
    procedure actDeletePortionPriceMappingUpdate(Sender: TObject);
    procedure dbgPortionPriceMappingDblClick(Sender: TObject);
    procedure dbgPortionPriceMappingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbbxPortionChange(Sender: TObject);
    procedure chkbxPortionFilterClick(Sender: TObject);
    procedure tsPromoDetailsShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridPriceKeyPress(Sender: TObject; var Key: Char);
    procedure dbedRewardPriceKeyPress(Sender: TObject; var Key: Char);
    procedure tsSelectSitesResize(Sender: TObject);
    procedure dbComboRecipeChildrenModeChange(Sender: TObject);
    procedure dbgPromotionGroupsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure dbgPromotionGroupsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure dtEndDateClick(Sender: TObject);
    procedure dtEndDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExceptionButtonUpdate(Sender: TObject);
  private
    ValidColumnResize:Boolean;
    NameColumnWidth:integer;
    EventPricing: boolean;
    CurrentAppHintDelay : integer;

    ProductSearchTerm: string;
    ProductSearchTermChanged: boolean;
    DataModified: TDataModified;
    SalesAreaDataTree: TDataTree;
    ProductDataTree: TDataTree;
    ProductGroupCount: integer;
    ProductSelectionTrees: array of TTreeView;
    ProductGroupPriceMethods: array of TGroupPriceMethodFrame;
    PromotionActionsSortHelper: TGridSortHelper;
    itemValidation, itemVerification, itemSwipeGroup : integer;
    CurrentPortionFilterId: integer;
    WizardManager: TWizardManager;
    procedure OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
    procedure OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
    procedure LoadData;
    procedure SaveData;
    procedure AddSaleGroup(SaleGroupID: integer);
    procedure RemoveSaleGroup(SaleGroupID: integer);
    procedure SetSaleGroupName(SaleGroupID: integer; Name: string);
    procedure ProcessProductGroupChange;
    procedure GetSalesAreaSelection(TableName: string);
    procedure ProcessSalesAreaSelection;
    procedure ProcessProductGroupSelection(GroupID: integer; TableName: string);

    function CheckTextValue (Value : String; Error : String) : Boolean;
    procedure LoadPricegroupSetting (PriceSettingFrame : TGroupPriceMethodFrame; GroupID : Integer);
    procedure SavePricegroupSetting (PriceSettingFrame : TGroupPriceMethodFrame; GroupID : Integer);
    procedure RefreshPricegroupSettings;
    procedure BuildPriceReviewSQL;
    procedure LoadPriceReviewSANames;
    procedure SetActivationDefaults;
    procedure ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);

    procedure CheckEventGroupSelection(SelectTargetIndex: integer; SelectAll: boolean);
    procedure SaveProductGroupSelection;
    procedure LogTimePeriods;
    procedure LogAnyZeroTariffPrices;
    procedure LogRowCountsForPromotion;
    procedure storeDisabledSwipeCardValues(nValidation, nSwipeCardGroup,
      nVerification: integer);
    procedure restoreDisabledSwipeCardValues(Sender: TObject);
    procedure UpdateGroupPrices(GroupID : Integer);
    procedure DeletePrices(GroupId, PortionTypeID : Integer);
    procedure AddEditPortionPriceMapping(Mode: TEditMode);
    procedure PopulatePortionFilterComboBox;
    procedure ApplyPortionFilter;
    procedure HideNonstandardPromoDetailsFields;
    procedure AdjustPrice(Grid: TwwDbGrid; Caption: String);
  public
    PromotionID, ExistingID: Int64;
    WizardSiteCode: Integer;
    promoTypeIndex: Integer; // promoTypeIndex: 0 for Timed, 1 for MultiBuy, 2 for BOGOF **and** for EnhancedBOGOF, etc.
    ReadOnly: Boolean;
    class function ShowWizard(APromotionID, AExistingID: Int64; ASiteCode: integer; AEditable: Boolean = False): boolean;
    class procedure DoExportImport(ASiteCode: integer; APromotionID: Int64; DoImport: Boolean);
    procedure HandleInitFocus(var Msg: TMsg); message UM_INITFOCUS;
    procedure ResizeForNewException;
  end;

var
  PromotionWizard: TPromotionWizard;

implementation

uses
  udmPromotions, dADOAbstract, useful, uExceptionWizard, dateutils, comobj,
  uExcelExportImport, uSimpleLocalise, math, uPriceIncDec, uADO, types, uGlobals;

{$R *.dfm}

const
  ALL_ITEMS = 'All Items';

class function TPromotionWizard.ShowWizard(APromotionID, AExistingID: Int64; ASiteCode: integer; AEditable: Boolean): boolean;
var
  WizardInstance: TPromotionWizard;
begin
  Log('Promotion Wizard', 'Creating. PromotionId= ' + inttostr(APromotionID) + ', ExistingId=' + inttostr(AExistingID) + ', SiteCode=' + IntToStr(ASiteCode));
  dmPromotions.AwaitPreload(pwSiteAndProductTree);
  WizardInstance := TPromotionWizard.Create(nil);
  with WizardInstance do
  try
  begin
    PromotionID := APromotionID;
    ExistingID := AExistingID;
    WizardSiteCode := ASiteCode;
    ReadOnly := not AEditable;

    //PostMessage(Handle, UM_INITFOCUS, 0, 0);
    LoadData;
    Result := ShowModal = mrOk;
  end;
  finally
    WizardInstance.Free;
  end;
end;


class procedure TPromotionWizard.DoExportImport(ASiteCode: integer; APromotionID: Int64; DoImport: boolean);
var
  WizardInstance: TPromotionWizard;
  ActionName: string;

  procedure NavigateToPrices(_WizardInstance: TPromotionWizard; PriceSheet: TTabSheet);
  begin
    repeat
      _WizardInstance.NextPage.Execute;
    until _WizardInstance.pcWizard.ActivePage = PriceSheet;
  end;

  procedure NavigateToEnd(_WizardInstance: TPromotionWizard);
  begin
    while (_WizardInstance.pcWizard.ActivePageIndex <> -1) do
      _WizardInstance.NextPage.Execute;
  end;

begin
  // Hack of the century! Effectvely this "scripts" the wizard form to automate
  // importing and exporting via the Wizard.
  if DoImport then
    ActionName := 'import'
  else
    ActionName := 'export';
  Log('Promotion Wizard', 'Import/Export');
  Log('  PromotionID - ',inttostr(APromotionID));
  Log('  Action      - ',ActionName);
  dmPromotions.AwaitPreload(pwSiteAndProductTree);
  WizardInstance := TPromotionWizard.Create(nil);
  with WizardInstance do try
    PromotionID := APromotionID;
    ExistingID := APromotionID;
    WizardSiteCode := ASiteCode;
    LoadData;
    OnShow(WizardInstance);
    case promoTypeIndex of
      PromoType_MultiBuy:
        begin
          Log('  Promotion Type - ','MultiBuy');
          NavigateToPrices(WizardInstance, WizardInstance.tsSingleRewardPrice);
          if rbSingleRewardPrice.Checked then
            raise Exception.Create(LocaliseString('Cannot '+ActionName+' this Multi-buy promotion, it does not have prices per sales area'))
          else
          begin
            rbPerSalesAreaRewardPrice.Checked := True;
            if DoImport then
            begin
              RewardPriceImport.Execute;
              NavigateToEnd(WizardInstance);
            end
            else
              RewardPriceExport.Execute;
          end;
        end;
      PromoType_EventPricing:
        begin
          Log('  Promotion Type - ','Event Pricing');
          NavigateToPrices(WizardInstance, WizardInstance.tsGroupPrices);
          if DoImport then
          begin
            GroupPriceImport.Execute;
            NavigateToEnd(WizardInstance);
          end
          else
            GroupPriceExport.Execute;
        end;
      PromoType_Timed, PromoType_BOGOF:
        begin
          Log('  Promotion Type - ', cbPromotionType.Text);
          NavigateToPrices(WizardInstance, tsGroupPrices);
          cbLeaveUnpriced.Checked := False;
          if DoImport then
          begin
            GroupPriceImport.Execute;
            NavigateToEnd(WizardInstance);
          end
          else
            GroupPriceExport.Execute;
        end;
    end;
  finally
    Close;
    Free;
  end;
end;

procedure TPromotionWizard.FormCreate(Sender: TObject);
var
  i: integer;
begin
  WizardManager := TWizardManager.Create(pcWizard, btnNext, btnBack, OnEnterPage, OnLeavePage);
  WizardManager.WizardName := 'Promotion Wizard';

  for i := 0 to Pred(ComponentCount) do
  begin
    // Hacky use of tags to bind images to TImage instances
    // Avoids clogging up the form with identical images
    if (Components[i] is TImage) then
      case TImage(Components[i]).Tag of
        TIMAGE_TAG_ZONAL_Z_BIG:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk100x100');
        TIMAGE_TAG_ZONAL_Z_SMALL:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
      end;
  end;

  // Initialise sales area selection page
  SalesAreaDataTree := TDataTree.Create(SiteSASelectionFrame.tvAvailableItems, dmPromotions.AztecConn, '##ConfigTree_Data', ConfigNamesArray, True);
  SalesAreaDataTree.AddLevel('Company', '');
  SalesAreaDataTree.AddLevel('Area', '');
  SalesAreaDataTree.AddLevel('Site', '');
  SalesAreaDataTree.AddLevel('Sales Area', '');
  SalesAreaDataTree.Initialise;
  SiteSASelectionFrame.InitialiseFrame(SalesAreaDataTree);

  ProductDataTree := TDataTree.Create(tvAvailableProducts, dmPromotions.AztecConn, '##ProductTree_Data', ProductNamesArray);
  ProductDataTree.AddLevel('Division', '');
  ProductDataTree.AddLevel('Category', '');
  ProductDataTree.AddLevel('Subcategory', '');
  ProductDataTree.AddLevel('Product', '');
  ProductDataTree.AddLevel('Portion', '');
  ProductDataTree.Initialise;

  uSimpleLocalise.LocaliseForm(self);

  for i := 0 to Pred(cbFavourCustomer.Items.Count) do
    cbFavourCustomer.Items[i] := uSimpleLocalise.LocaliseString(cbFavourCustomer.Items[i]);
  cbFavourCustomer.ItemIndex := 0;

  cbEditPriceGroup.Items.Add(ALL_ITEMS);

  PromotionActionsSortHelper := TGridSortHelper.Create;
  PromotionActionsSortHelper.Initialise(dbgPromotionActions);

  // Hook up the promotion list filter to the Promotions datamodule.
  PromotionFilterFrame.ApplyFilter := dmPromotions.SetEventPromotionListFilter;
  PromotionFilterFrame.ClearFilter := dmPromotions.ClearEventPromotionListFilter;

  // If the system is configured to use NAR (Normal Accounting Rules) Vat we must disabled the "Hide from customer"
  // checkbox. The two settings are not compatible with each other.
  if dmPromotions.NARVatEnabled then
  begin
    cbHideFromCustomer.Enabled := False;
    pnlHideFromCustomer.ShowHint := True; //Enable the hint that explains why the control is disabled.
  end;

  cbHideDisabledPromotions.Checked := True;
  dmPromotions.EventPromotionsHideDisabled := True;

  ProductTagFilterFrame.ADOConnection := dmPromotions.AztecConn;
  ProductTagFilterFrame.DataTreeToFilter := ProductDataTree;

  CurrentPortionFilterId := -1;
  PopulatePortionFilterComboBox;

  dtStartDate.Format := uGlobals.theDateFormat;
  dtEndDate.Format := uGlobals.theDateFormat;
  
{  VV
  dtStartDate.DisplayFormat := uGlobals.theDateFormat;
  dtEndDate.DisplayFormat := uGlobals.theDateFormat;
}
end;

procedure TPromotionWizard.btCloseClick(Sender: TObject);
begin
  Log('Promotion Wizard', 'Close Button Clicked');
  Close;
end;

procedure TPromotionWizard.FormShow(Sender: TObject);
begin
  if (PromotionID = -1) and (ExistingID = -1) then
  begin
    lbWizardTitle.Caption := 'New Promotion Wizard';
    lbWizardDescription.Caption := 'This wizard will guide you through the process of setting up a new promotion.';
  end
  else
  if (PromotionID = -1) and (ExistingID <> -1) then
  begin
    lbWizardTitle.Caption := 'Copy Promotion Wizard';
    lbWizardDescription.Caption := 'This wizard will guide you through the process of setting up a new promotion based on an existing one.';
  end
  else
  if (PromotionID = ExistingID) then
  begin
    lbWizardTitle.Caption := 'Edit Promotion Wizard';
    lbWizardDescription.Caption := 'This wizard allows you to review and/or edit all parts of the selected promotion.';
  end;
  Log('  FormShow ', lbWizardTitle.Caption);
  cbHideDisabledExceptions.Checked := dmPromotions.PromotionExceptionsHideDisabled;

  CurrentAppHintDelay := Application.HintHidePause;
  Application.HintHidePause := 3000;
end;

procedure TPromotionWizard.HandleInitFocus(var Msg: TMsg);
begin
  if not ReadOnly then
    FocusControl(edName);
end;

procedure TPromotionWizard.NextPageExecute(Sender: TObject);
begin
  ModalResult := WizardManager.NextPageExecute(Sender);
  if (ModalResult = mrOK) and not ReadOnly then
    SaveData;
end;

procedure TPromotionWizard.PrevPageExecute(Sender: TObject);
begin
  ModalResult := WizardManager.PrevPageExecute(Sender);
end;

procedure TPromotionWizard.LoadData;
var savedEventHandler: TNotifyEvent;
    swipeGroupID, rating : Integer;
    LoadPromotionDataSQL: String;
    endDate: TDate;
begin
  Log('Promotion Wizard', 'Load Data');

  swipeGroupID := 0;
  rating := 0;
  with dmPromotions do
  begin
    // Set up form
    LoadPromotionDataSQL := GetStringResource('LoadPromotionData', 'TEXT');
    LoadPromotionDataSQL := StringReplace(LoadPromotionDataSQL, '@PromotionID', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);
    LoadPromotionDataSQL := StringReplace(LoadPromotionDataSQL, '@SiteCode', IntToStr(WizardSiteCode), [rfReplaceAll, rfIgnoreCase]);
    adoqRun.SQL.Text := LoadPromotionDataSQL;

    SafeExecSQL;

    if ExistingID = -1 then
      SetActivationDefaults;

    if (ExistingID <> -1) and (PromotionID = -1) then
    begin
      // Promotion is being copied. Need to set the promotion IDs in the editing
      // tables to -1.
      adoqRun.SQL.Text := StringReplace(GetStringResource('SetUpCopyPromotion', 'TEXT'), '@PromotionID', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);
      SafeExecSQL;
    end;

    // load GUI with existing values
    if ExistingID <> -1 then
    with dmPromotions.adoqRun do
    begin
      SQL.Text :=
        'SELECT Name, Description, PromoTypeID, FavourCustomer, EventOnly, HideFromCustomer, StartDate, EndDate,'+
        '  ISNULL(CardActivated, 0) AS CardActivated, ISNULL(SwipeGroupID, 0) AS SwipeGroupID, ISNULL(CardRating, -1) AS CardRating,'+
        '  ValidWithAllPaymentMethods, ValidWithAllDiscounts, LoyaltyPromotion, LoyaltyPointsRequired,'+
        '  CanIncreasePrice, GroupItemsUnderPromotion, ReferenceRequired, ExtendedFlag, UserSelectsProducts '+
        'FROM #Promotion';
      Open;
      edName.Text := FieldByName('Name').AsString;
      edDescription.Text := FieldByName('Description').AsString;

      if ((FieldByName('PromoTypeID').AsInteger - 1) = PromoType_BOGOF) and FieldByName('ExtendedFlag').AsBoolean then
        cbPromotionType.ItemIndex := PromoType_EnhancedBOGOF
      else
        cbPromotionType.ItemIndex := FieldByName('PromoTypeID').AsInteger-1;
      cbPromotionType.OnChange(cbPromotionType);

      cbFavourCustomer.ItemIndex := Integer(FieldByName('FavourCustomer').AsBoolean);
      cbEventOnly.Checked := FieldByName('EventOnly').AsBoolean;
      cbHideFromCustomer.Checked := not(dmPromotions.NARVatEnabled) and FieldByName('HideFromCustomer').AsBoolean;

      dtStartDate.Date := FieldByName('StartDate').AsDateTime;

      endDate := FieldByName('EndDate').AsDateTime;

      if endDate = 0 then
      begin
        dtEndDate.Date := Trunc(now);
        dtEndDate.Format := GetBlankDateTimePicker;
      end
      else
        dtEndDate.Date := endDate;

      cbVerification.ItemIndex := Integer(FieldByName('CardActivated').AsBoolean);
      cbValidWithAllPaymentMethods.Checked := FieldByName('ValidWithAllPaymentMethods').AsBoolean;
      cbValidWithAllDiscounts.Checked := FieldByName('ValidWithAllDiscounts').AsBoolean;
      swipeGroupID := FieldByname('SwipeGroupID').AsInteger;
      rating := FieldByName('CardRating').AsInteger;
      chkbxLoyaltyPromotion.Checked := FieldByName('LoyaltyPromotion').AsBoolean;
      edtLoyaltyPointsRequired.Text := FieldByName('LoyaltyPointsRequired').AsString;
      cbCanIncreasePrice.Checked := FieldByName('CanIncreasePrice').AsBoolean;
      cbGroupItemsUnderPromotion.Checked := FieldByName('GroupItemsUnderPromotion').AsBoolean;
      cbReferenceRequired.Checked := FieldByName('ReferenceRequired').AsBoolean;
      cbPromotionalDeal.Checked := FieldByName('UserSelectsProducts').AsBoolean and dmPromotions.usePromoDeals;
      Close;

      cbSwipeCardGroup.Enabled := cbVerification.ItemIndex = 1;
      cbValidation.Enabled := cbVerification.ItemIndex = 1;
      Log('  Name', edName.Text);
      Log('  Description', edDescription.Text);
      Log('  Promotion Type', cbPromotionType.Text);
      Log('  Promotion Bias', cbFavourCustomer.Text);

      SiteSASelectionFrame.LoadData('#PromotionSalesArea', 'SalesAreaID');

      ProcessProductGroupChange;
    end;
                           
    cbPromotionalDeal.Visible := dmPromotions.usePromoDeals;
    dstValidTimes.Active := True;
    btnDeleteTimePeriod.Enabled := (dstValidTimes.RecordCount > 1);

    with dmPromotions.adoqRun do
    begin
       SQL.Text := 'SELECT GroupID, Name FROM ThemeSwipeCardGroups ORDER BY Name';
       Open;
       cbSwipeCardGroup.Items.AddObject('None',TObject(0));
       cbSwipeCardGroup.ItemIndex := 0;
       First;
       while not EOF do
         begin
           cbSwipeCardGroup.Items.AddObject(FieldByName('Name').AsString, TObject(FieldByName('GroupID').AsInteger));
           if swipeGroupID = FieldByName('GroupID').AsInteger then
              cbSwipeCardGroup.ItemIndex := Integer(cbSwipeCardGroup.Items.Count -1);

           next;
         end;
    end;

    with dmPromotions.adoqRun do
    begin
       SQL.Text := 'SELECT 0 AS CardRating, ''None'' AS Name '+
                   ' UNION ' +
                   ' SELECT Rating, DisplayString FROM CardRangeValidationRatings WHERE Deleted = 0';
       Open;

       cbValidation.ItemIndex := 0;
       First;
       while not EOF do
       begin
         cbValidation.Items.AddObject(FieldByName('Name').AsString, TObject(FieldByName('CardRating').AsInteger));
         if rating = FieldByName('CardRating').AsInteger then
            cbValidation.ItemIndex := Integer(cbValidation.Items.Count -1);
         next;
      end;

      if rating = -1 then
         cbValidation.ItemIndex := 0;

      if recordcount = 0 then
         begin
            cbValidation.ItemIndex := 0;
            cbValidation.Enabled := False;
         end;
    end;



    //If there is only one time cycle defined on this promotion and it starts at rollover and ends at RollOver - 1 min
    //then check the 'Promotion runs at all times' box.
    savedEventHandler := chkbxAllTimes.OnClick;    //Disable this event handler while we set this checkbox state.
    chkbxAllTimes.OnClick := nil;

    if (dstValidTimes.RecordCount = 1) and
       SameTime(dstValidTimesStartTime.Value, dmPromotions.RolloverTime) and
       SameTime(dstValidTimesEndTime.Value, IncMinute(dmPromotions.RolloverTime, -1)) then
    begin
      chkbxAllTimes.Checked := True;
      ConfigureActivationDetailsGUI(True);
    end
    else
    begin
      chkbxAllTimes.Checked := False;
      ConfigureActivationDetailsGUI(False);
    end;

    chkbxAllTimes.OnClick := savedEventHandler;

    Log('  Start Date', DateToStr(dtStartDate.Date));
    Log('  Stop Date', DateToStr(dtEndDate.Date));
    LogTimePeriods;

    Log('Promotion Wizard', Format('Row counts for promotion id %s at start', [IntToStr(PromotionId)]));
    LogRowCountsForPromotion;

    dmPromotions.qEditPromotionGroups.Active := True;
    DataModified.PriceCalculationRequired := True;
    DataModified.ProductLoadRequired := True;

    with adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ac_Module WHERE SystemName = ''Loyalty'' AND Deleted = 0');
      Open;
      if RecordCount >= 1 then
      begin
        actLoyaltyPromotion.Visible := True;
        pnlLoyalty.Visible := True;
      end
      else begin
        actLoyaltyPromotion.Visible := False;
        pnlLoyalty.Visible := False;
      end;
      Close;
    end;
  end;

  itemValidation := cbValidation.ItemIndex;
  itemVerification := cbVerification.ItemIndex;
  itemSwipeGroup := cbSwipeCardGroup.ItemIndex;
end;

procedure TPromotionWizard.SaveData;
const
  DEADLOCK_VICTIM_ERROR = 'Error 1205';
var
  deadlockVictim: boolean;
begin
  deadlockVictim := false;

  Log('Promotion Wizard', 'Save Data');
  if not rbPerSalesAreaRewardPrice.Checked then
  begin
    dmPromotions.adoqrun.SQL.Text := 'delete #PromotionSalesAreaRewardPrice';
    dmPromotions.SafeExecSQL;
  end;

  // ensure fields RecipeChildrenMode and MakeChildrenFree are set to Default if this is NOT Enhanced BOGOF...
  if (cbPromotionType.itemindex <> PromoType_EnhancedBOGOF) then
  begin
    dmPromotions.adoqrun.SQL.Text := 'update #PromotionSaleGroup set RecipeChildrenMode = 0, MakeChildrenFree = 0';
    dmPromotions.SafeExecSQL;
  end;

  if PromotionID = -1 then
  begin
    // Generate new promotion ID and update temporary tables with it
    dmPromotions.adoqRun.SQL.Clear;
    dmPromotions.adoqRun.SQL.Add('declare @newid bigint');
    dmPromotions.adoqRun.SQL.Add(Format('exec ac_spGetTableIdNextValue %s, %s output',['Promotion_Repl','@newid']));
    dmPromotions.adoqRun.SQL.Add('select @newid as Output');
    dmPromotions.adoqrun.Open;
    PromotionID := TLargeIntField(dmPromotions.adoqrun.fieldbyname('Output')).AsLargeInt;
    dmPromotions.adoqrun.Close;

  end;

  // BELOW -------- uncomment for diagnostics -------------------------------------------------
  // dmPromotions.adoqrun.SQL.Text :=
  //    ' IF OBJECT_ID(''PromotionExceptionTMP_1'') IS NOT NULL DROP TABLE PromotionExceptionTMP_1 ' +
  //    ' select * into PromotionExceptionTMP_1 from #PromotionException ' +
  //    ' IF OBJECT_ID(''PromotionExceptionSalesAreaTMP_1'') IS NOT NULL DROP TABLE PromotionExceptionSalesAreaTMP_1 ' +
  //    ' select * into PromotionExceptionSalesAreaTMP_1 from #PromotionExceptionSalesArea ';
  //  dmPromotions.SafeExecSQL;
  
  dmPromotions.adoqRun.SQL.Text := GetStringResource('UpdateExceptionData', 'TEXT');
  dmPromotions.adoqrun.execsql;

  // BELOW -------- uncomment for diagnostics -------------------------------------------------
  //   dmPromotions.adoqrun.SQL.Text :=
  //     ' IF OBJECT_ID(''PromotionExceptionTMP_2'') IS NOT NULL DROP TABLE PromotionExceptionTMP_2 ' +
  //     ' select * into PromotionExceptionTMP_2 from #PromotionException ' +
  //     ' IF OBJECT_ID(''PromotionExceptionSalesAreaTMP_2'') IS NOT NULL DROP TABLE PromotionExceptionSalesAreaTMP_2 ' +
  //     ' select * into PromotionExceptionSalesAreaTMP_2 from #PromotionExceptionSalesArea ';
  //   dmPromotions.SafeExecSQL;


  // CC 06/03/2024 - I believe the SQL below is wrong and don't know what it's for so I commented it
  //               ---------------------------------------------------------------------------------
  //  dmPromotions.adoqRun.SQL.Text := GetStringResource('AddExceptionData', 'TEXT');
  //  dmPromotions.adoqrun.execsql;



  // Sites running on old version need to do a forced recalculation of prices,
  // because this version does not save calculated prices to the database.
  // Therefore we force a send of the SABands table for all sites that have
  // the promotion.
  // Also adds price records for multi buy promotion items using the tariff
  // price.
  // PW: Argh, this query needs access to tariff prices.
  dmPromotions.AwaitPreload(pwTarrifPrices);

  repeat
    try
      deadlockVictim := false;

      dmPromotions.adoqRun.SQL.Text := StringReplace(GetStringResource('SavePromotionData', 'TEXT'), '@PromotionID', IntToStr(PromotionID), [rfReplaceAll, rfIgnoreCase]);
      dmPromotions.adoqrun.execsql;
      // Inelegant way to ensure priority is not duplicated when multiple
      // users are running.
      dmPromotions.FixPriorities(WizardSiteCode);

      Log('Promotion Wizard', Format('Row counts for promotion id %s at finish', [IntToStr(PromotionID)]));
      LogRowCountsForPromotion;
    except
      on e: Exception do
      begin
        if Pos(DEADLOCK_VICTIM_ERROR, e.Message) <> 0 then
        begin
          deadlockVictim := true;
          Log('Promotion Wizard', 'Deadlock error saving promotion, retrying: ' + e.ClassName + ' ' + e.Message);
          // Wait briefly so that the other transaction has a chance to complete and release its locks that formed part of the deadlock cycle.
          Sleep(2000);
        end
        else
        begin
          Log('Promotion Wizard', 'Error saving promotion: ' + e.ClassName + ' ' + e.Message);

          MessageDlg('Failed to save changes due to an unexpected error:'#13#10#13#10 +
                     e.ClassName + ' - ' + e.Message, mtError, [mbOk], 0)
        end;
      end;
    end;
  until not(deadlockVictim);
  dmPromotions.InsertMissingPromotionPriorities;
end;

procedure TPromotionWizard.LogRowCountsForPromotion;

  procedure LogRowCountInTable(const tableName: string);
  begin
    with dmPromotions.adoqRun do
    try
      Close;
      SQL.Text := Format('SELECT COUNT(*) AS [RowCount] FROM %s WHERE PromotionId = %s', [tableName, InttoStr(PromotionID)]);
      Open;
      Log('    ', Format('%s rows in %s', [FieldByName('RowCount').AsString, tableName]));
    finally
      Close;
    end;
  end;

begin
  LogRowCountInTable('PromotionSalesArea');
  LogRowCountInTable('PromotionTimeCycles');
  LogRowCountInTable('PromotionPrices');
  LogRowCountInTable('PromotionSalegroup');
end;

procedure TPromotionWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Promotion Wizard', 'Form Close');
  with dmPromotions do
  begin
    try
      adoqRun.SQL.Text := GetStringResource('DropPromotionData', 'TEXT');
      adoqrun.ExecSQL;
    except on E:Exception do
      if Pos('cannot drop', LowerCase(E.Message)) = 0 then
        raise;
    end;
  end;
  dmPromotions.qEditPromotionGroups.Active := False;
  dmPromotions.qEditPromotionExceptions.Active := False;
  dmPromotions.qEditPromoPrice.Active := False;
  dmPromotions.qEditSalesAreaRewardPrice.Active := False;
  dmPromotions.qEditSingleRewardPrice.Active := False;
  dmPromotions.qEditEventStatus.Active := false;

  Application.HintHidePause := CurrentAppHintDelay;
end;

procedure TPromotionWizard.LoadPricegroupSetting (PriceSettingFrame : TGroupPriceMethodFrame; GroupID : Integer);
var
  RememberCalc : Boolean;
  CalcType: integer;
begin
  Log('Promotion Wizard', 'LoadPriceGroupSetting');
  with dmPromotions.adoqRun do begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add ('SELECT Quantity, CalculationType, CalculationValue, CalculationBand, RememberCalculation');
    SQL.Add ('FROM #PromotionSaleGroup');
    SQL.Add (Format ('WHERE (PromotionID = %s) AND (SaleGroupID = %d)', [IntToStr(PromotionID), GroupID]));
    Open;
    if not Eof then
    begin
      RememberCalc := FieldByName ('RememberCalculation').AsBoolean;
      CalcType := FieldByName ('CalculationType').AsInteger;
      if CalcType = -1 then
        CalcType := 0;
      PriceSettingFrame.CalculationType := CalcType;
      PriceSettingFrame.CalculationValue := FieldByName ('CalculationValue').AsFloat;
      PriceSettingFrame.CalculationBand := FieldByName ('CalculationBand').AsString;
      PriceSettingFrame.RememberCalculation := RememberCalc;
      Log('  Pricing Method', inttostr(PriceSettingFrame.CalculationType));
      Log('  Value', floattostr(PriceSettingFrame.CalculationValue));
      Log('  Group', PriceSettingFrame.CalculationBand);
      if RememberCalc then
         Log('  Remember Calculation', 'TRUE')
      else
         Log('  Remember Calculation', 'FALSE')

    end;
    PriceSettingFrame.Modified := false;
  end;
end;

procedure TPromotionWizard.SavePricegroupSetting(PriceSettingFrame : TGroupPriceMethodFrame; GroupID : Integer);
begin
  Log('Promotion Wizard', 'SavePriceGroupSetting');
  with dmPromotions.adoqRun do
  try
    SQL.Clear;
    SQL.Add('UPDATE #PromotionSaleGroup SET ');
    if PriceSettingFrame.CalculationType in [CalcType_ValueIncrease..CalcType_BandedPrice] then
      SQL.Add(Format('CalculationType = %d,', [PriceSettingFrame.CalculationType]))
    else
    begin
      PriceSettingFrame.RememberCalculation := false;
      SQL.Add('CalculationType = null,');
    end;

    case PriceSettingFrame.CalculationType of
      CalcType_ValueIncrease..CalcType_PercentDecrease:
      begin
        SQL.Add(Format('CalculationValue = %5.2f, CalculationBand = null, ',
          [PriceSettingFrame.CalculationValue]));
      end;
      CalcType_BandedPrice:
      begin
        SQL.Add(Format('CalculationValue = null, CalculationBand = ''%s'',',
          [PriceSettingFrame.CalculationBand]));
      end;
    else
      SQL.Add('CalculationValue = null, CalculationBand = null, ');
    end;
    SQL.Add(Format('RememberCalculation = %d', [Integer(PriceSettingFrame.RememberCalculation)]));
    SQL.Add(Format('WHERE (PromotionID = %s) AND (SaleGroupID = %d)', [IntToStr(PromotionID), GroupID]));
    Log('  SavePriceGroupSetting - ',SQL.Text);
    ExecSQL;
  finally
    dmPromotions.qEditPromotionGroups.Requery;
  end;
end;

procedure TPromotionWizard.RefreshPricegroupSettings;
var
  i: Integer;
begin
  if DataModified.GroupPriceSettingsRefreshRequired then
  begin
    for i := Low(ProductGroupPriceMethods) to High(ProductGroupPriceMethods) do
      ProductGroupPriceMethods[i].PromotionType := promoTypeIndex;
    DataModified.GroupPriceSettingsRefreshRequired := FALSE;
  end;
end;

procedure TPromotionWizard.ProcessProductGroupChange;
var
  NewProductGroupCount: integer;
  NameStr: string;
  i: integer;
begin
  Log('Promotion Wizard', 'ProcessProductGroupChange');
  dmPromotions.adoqRun.SQL.Text := 'SELECT COUNT(*) as GroupCount FROM #PromotionSaleGroup';
  dmPromotions.adoqRun.Open;
  NewProductGroupCount := dmPromotions.adoqRun.FieldByName('GroupCount').AsInteger;
  dmPromotions.adoqRun.Close;
  if NewProductGroupCount <> ProductGroupCount then
  begin
    // Remove or create tabs for product groups
    if ProductGroupCount > NewProductGroupCount then
    begin
      for i := ProductGroupCount-1 downto NewProductGroupCount do
      begin
        RemoveSaleGroup(i+1);
      end;
    end;
    for i := ProductGroupCount to Pred(NewProductGroupCount) do
    begin
      AddSaleGroup(i+1);
    end;
  end;
  with dmPromotions.adoqrun do
  begin
    SQL.Text := 'select SaleGroupID, Name from #PromotionSaleGroup';
    Open;
    while not EOF do
    begin
      if FieldByName('Name').IsNull then
        NameStr := Format('Group %d', [FieldByName('SaleGroupID').AsInteger])
      else
        NameStr := FieldByName('Name').AsString;
      SetSaleGroupName(FieldByName('SaleGroupID').AsInteger, NameStr);
      Next;
    end;
  end;

end;

procedure TPromotionWizard.sbIncludeProductClick(Sender: TObject);
begin
  Log('  Select Products', 'Include Product (>) Clicked');
  if promoTypeIndex = PromoType_EventPricing then
  begin
    CheckEventGroupSelection(tcProductGroups.TabIndex, false);
  end;
  ProductDataTree.SelectItem(ProductSelectionTrees[tcProductGroups.TabIndex]);
  DataModified.ProductGroupSelection[tcProductGroups.TabIndex] := True;
end;

procedure TPromotionWizard.sbIncludeAllProductsClick(Sender: TObject);
begin
  Log('  Select Products', 'Include All Products (>>) Clicked');
  if promoTypeIndex = PromoType_EventPricing then
  begin
    CheckEventGroupSelection(tcProductGroups.TabIndex, true);
  end;
  ProductDataTree.SelectAll(ProductSelectionTrees[tcProductGroups.TabIndex]);
  DataModified.ProductGroupSelection[tcProductGroups.TabIndex] := True;
end;

procedure TPromotionWizard.sbExcludeAllProductsClick(Sender: TObject);
begin
  Log('  Select Products', 'Exclude Product (<) Clicked');
  ProductDataTree.DeSelectAll(ProductSelectionTrees[tcProductGroups.TabIndex]);
  DataModified.ProductGroupSelection[tcProductGroups.TabIndex] := True;
end;

procedure TPromotionWizard.sbExcludeProductClick(Sender: TObject);
begin
  Log('  Select Products', 'Exclude All Products (<<) Clicked');
  ProductDataTree.DeSelectItem(ProductSelectionTrees[tcProductGroups.TabIndex]);
  DataModified.ProductGroupSelection[tcProductGroups.TabIndex] := True;
end;

procedure TPromotionWizard.tcProductGroupsChange(Sender: TObject);
var
  i: integer;
begin
  Log('Promotion Wizard', 'tcProductGroupsChange');
  for i := Low(ProductSelectionTrees) to High(ProductSelectionTrees) do
    ProductSelectionTrees[i].Visible := False;
  ProductSelectionTrees[TTabControl(Sender).TabIndex].Visible := True;
end;

procedure TPromotionWizard.btAddGroupClick(Sender: TObject);
var
  NewID: integer;
begin
  Log('  Define Groups', 'Add Button Clicked');
  with dmPromotions.adoqRun do
  begin
    SQL.Text := 'select max(SaleGroupID) from #PromotionSaleGroup';
    Open;
    NewID := 1 + Fields[0].AsInteger;
    Close;
  end;
  Log('  Define Groups', 'New Group ID ' + inttostr(NewID) + ' Created');

  //New promotionid are set to -1, but the ADO components in this version of Delphi
  //will not allow the setting of a TLargeIntField (which PromotionID is under the hood)
  //to a negative value ('Multiple-step operation generated errors. Check each status value'
  //error is thrown.  Push the value into the temp table ourselves....<sigh>
  with dmPromotions.adoqRun do
  begin
    SQL.Text := '';
    SQL.Add('insert #PromotionSaleGroup (SiteCode, PromotionID, SaleGroupID, Name, Quantity, RecipeChildrenMode, MakeChildrenFree, RememberCalculation)');
    SQL.Add(Format('Values (%d, %s, %d, null, 1, 0, 0, 0)',[WizardSiteCode, IntToStr(PromotionID),NewID]));
    ExecSQL;
  end;
  dmPromotions.qEditPromotionGroups.Requery;
  dmPromotions.qEditPromotionGroups.Locate('SaleGroupID', NewID, []);

  {with dmPromotions.qEditPromotionGroups do
  begin
    //The grid that uses this ado query (dbgPromotionGroups) has implemented the 'Store display settings in TFields'
    //option.  This has the effect of forcing the displayed fields to the 'front'
    //of the persistent field order, i.e. it changes the order (at runtime!) from
    //  PromotionID, SaleGroupID, Name, Quantity, CalculationType, CalculationValue, CalculationBand, RememberCalculation, SiteCode
    // to
    //  SaleGroupID, Quantity, Name, PromotionID, CalculationType, CalculationValue, CalculationBand, RememberCalculation, SiteCode
     //AppendRecord([NewID, null, 1, WizardSiteCode, IntToStr(PromotionID), null, null, null, false]);
     //if State in [dsEdit] then
     // Post;
     Append;
     dmpromotions.DumpTemp('#promotionsalegroup');
     dmPromotions.qEditPromotionGroupsSaleGroupID.Value := NewID;
     dmPromotions.qEditPromotionGroupsQuantity.Value := 1;
     TLargeintField(dmPromotions.qEditPromotionGroups.FieldByName('PromotionID')).AsString := IntToStr(-10);
     dmPromotions.qEditPromotionGroupsRememberCalculation.Value := false;
     dmPromotions.qEditPromotionGroupsSiteCode.Value := WizardSiteCode;
     Post;
  end;}
  AddSaleGroup(NewID);
end;

procedure TPromotionWizard.btDeleteGroupClick(Sender: TObject);
var
  SaleGroupID: integer;
begin
  if dbgPromotionGroups.DataSource.State in [dsEdit, dsInsert] then
    dbgPromotionGroups.DataSource.Dataset.Post;
  Log('  Define Groups', 'Delete Button Clicked');
  if ProductGroupCount = 1 then
    raise Exception.Create('A Promotion must have at least one Group defined.');
  SaleGroupID := dmPromotions.qEditPromotionGroups.FieldByName('SaleGroupID').AsInteger;
  if MessageDlg('Are you sure you want to delete Group '+IntToStr(SaleGroupID)+'?',
    mtInformation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  RemoveSaleGroup(SaleGroupID);
  dmPromotions.qEditPromotionGroups.Requery;
  if not dmPromotions.qEditPromotionGroups.Locate('SaleGroupID', SaleGroupID, []) then
    dmPromotions.qEditPromotionGroups.Locate('SaleGroupID', SaleGroupID -1, []);
end;

procedure TPromotionWizard.chkbxAllTimesClick(Sender: TObject);
begin
  if chkbxAllTimes.Checked then
  begin
    //Save current active time settings so can restore them if the "Promotion runs at all times" checkbox in unchecked,
    //and insert a rollover to rollover record instead.
    dstValidTimes.DisableControls;
    dstValidTimes.Active := False;
    dmPromotions.adoqrun.SQL.Text :=
      'TRUNCATE TABLE #PromotionTimeCycles_saved ' +
      'INSERT #PromotionTimeCycles_saved SELECT * FROM #PromotionTimeCycles ' +

      'TRUNCATE TABLE #PromotionTimeCycles ' +
      'INSERT #PromotionTimeCycles (ValidDays, StartTime, EndTime) ' +
      'VALUES (' + QuotedStr(ValidDaysStrFromCheckboxes(clbValidDays)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', dmPromotions.RolloverTime)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', IncMinute(dmPromotions.RolloverTime, -1))) + ')';
    dmPromotions.SafeExecSQL;
    dstValidTimes.Active := True;
    dstValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(True);

    Log('  Activation Details', 'Promotion runs at all times checked')
  end
  else
  begin
    //Restore any active time settings that were saved when the user checked the "Promotion runs at all times" checkbox.
    dstValidTimes.DisableControls;
    dstValidTimes.Active := False;
    dmPromotions.adoqrun.SQL.Text :=
      'IF EXISTS(SELECT * FROM #PromotionTimeCycles_saved) '+
      'BEGIN '+
      '  SET IDENTITY_INSERT #PromotionTimeCycles ON '+

      '  TRUNCATE TABLE #PromotionTimeCycles ' +
      '  INSERT #PromotionTimeCycles (DisplayOrder, ValidDays, StartTime, EndTime) '+
      '  SELECT * FROM #PromotionTimeCycles_saved ' +

      '  SET IDENTITY_INSERT #PromotionTimeCycles OFF '+
      'END';
    dmPromotions.SafeExecSQL;
    dstValidTimes.Active := True;
    dstValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(False);

    Log('  Activation Details', 'Promotion runs at all times unchecked');
  end;
end;


procedure TPromotionWizard.ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);
begin
  if PromoRunsAllTimes then
  begin
    lblStartTime.Visible        := False;
    lblEndTime.Visible          := False;
    dtStartTime.Visible         := False;
    dtEndTime.Visible           := False;

    dbgridValidTimes.Visible    := False;
    btnNewTimePeriod.Visible    := False;
    btnDeleteTimePeriod.Visible := False;
  end
  else
  begin
    lblStartTime.Visible        := True;
    lblEndTime.Visible          := True;
    dtStartTime.Visible         := True;
    dtEndTime.Visible           := True;

    dbgridValidTimes.Visible    := True;
    btnNewTimePeriod.Visible    := True;
    btnDeleteTimePeriod.Visible := True;
  end;
end;

procedure TPromotionWizard.GetSalesAreaSelection(TableName: string);
var
 qryTmp: TADOQuery;
begin
  Log('Promotion Wizard', 'GetSalesAreaSelection');
  with dmPromotions.adoqRun do
  try
    SQL.Text := 'delete #PromotionSalesArea';
    ExecSQL;

    SQL.Text := Format('insert #PromotionSalesArea (SiteCode, PromotionID, SalesAreaID) '+
      'select %d, %s, Level4ID from %s ', [WizardSiteCode, InttoStr(PromotionID), TableName]);
    ExecSQL;

    SQL.Text := Format('drop table %s', [TableName]);
    ExecSQL;

    SQL.Text := 'SELECT COUNT(*) AS [Count] FROM #PromotionSalesArea';
    Open;
    Log('    ', FieldByName('Count').AsString + ' sales areas selected and saved to #PromotionSalesArea');
    Close;

    // Ensure that Exception sales areas are synchronized with Promotion sales areas
    SQL.Text := 'DELETE #PromotionExceptionSalesArea ' +
                'WHERE NOT EXISTS ' +
                '  (SELECT * ' +
                '   FROM #PromotionSalesArea ' +
                '   WHERE #PromotionExceptionSalesArea.SalesAreaID = #PromotionSalesArea.SalesAreaID)';
    ExecSQL;
    // If there are exceptions with no sales areas then delete the exceptions
    // and eventstatus
    SQL.Text := 'SELECT DISTINCT ExceptionID FROM #PromotionException ' +
                'WHERE PromotionID = ' + IntToStr(PromotionID) +
                ' AND ExceptionID NOT IN ' +
                '   (SELECT ExceptionID FROM #PromotionExceptionSalesArea)';
    Open;

    if (RecordCount = 0) then
      Exit;

    First;
    qryTmp := TADOQuery.Create(nil);
    try
      qryTmp.Connection := dmPromotions.AztecConn;
      qryTmp.CommandTimeout := 0;
      while not dmPromotions.adoqRun.Eof do
      begin
        qryTmp.SQL.Text :=  'delete #PromotionException where ExceptionID = ' +
             IntToStr(TLargeIntField(dmPromotions.adoqRun.FieldByName('ExceptionID')).AsLargeInt);
        qryTmp.ExecSQL;
        qryTmp.SQL.Text :=  'delete #PromotionExceptionEventStatus where ExceptionID = ' +
             IntToStr(TLargeIntField(dmPromotions.adoqRun.FieldByName('ExceptionID')).AsLargeInt);
        qryTmp.ExecSQL;
        qryTmp.SQL.Text :=  'delete #PromotionExceptionTimeCycles where ExceptionID = ' +
             IntToStr(TLargeIntField(dmPromotions.adoqRun.FieldByName('ExceptionID')).AsLargeInt);
        qryTmp.ExecSQL;
        dmPromotions.adoqRun.Next;
      end;
    finally
      FreeAndNil(qryTmp);
      // not sure if its correct to use Requery but didn't want to use
      // dmPromotions.UpdateExceptionsQuery as that seems to be only used  if the
      // ExceptionWizard has not previously been opened in this edit session
      if dmPromotions.qEditPromotionExceptions.Active then
        dmPromotions.qEditPromotionExceptions.Requery();
    end;
  finally
    Close;
  end;
end;

procedure TPromotionWizard.ProcessSalesAreaSelection;
begin
  Log('Promotion Wizard', 'ProcessSalesAreaSelection');
  with dmPromotions.adoqRun do
  begin
    SQL.Text :=
      // Take copy of new selection data
      'select * into #NewData from #PromotionSalesArea '+
      // Remove reward price records for deselected sales areas
      'delete #PromotionSalesAreaRewardPrice '+
      'from #PromotionSalesAreaRewardPrice a '+
      'left outer join #PromotionSalesArea b '+
      'on (a.SalesAreaID = b.SalesAreaID) '+
      'and (a.PromotionID = b.PromotionID) '+
      'Where (b.SalesAreaID is Null) '+
      // Remove record from Newdata that already exist in rewardprice
      'delete #NewData '+
      'from #NewData a '+
      'join #PromotionSalesAreaRewardPrice b '+
      'on (a.SalesAreaID = b.SalesAreaID) '+
      'and (a.PromotionID = b.PromotionID) '+
      'insert #PromotionSalesAreaRewardPrice (SiteCode, PromotionID, SalesAreaID) '+
      'select SiteCode, PromotionID, SalesAreaID '+
      'from #NewData ';
    ExecSQL;

    // vk
    SQL.Text :=
      'if OBJECT_ID(''tempdb..##PromoSASelection'') is not null drop table ##PromoSASelection ';
    ExecSQL;

    SQL.Text := 'Select * into ##PromoSASelection from #PromotionSalesAreaRewardPrice';
    ExecSQL;
    
    SQL.Text :=
      'if OBJECT_ID(''tempdb..#NewData'') is not null drop table #NewData ';
    ExecSQL;
  end;
end;

procedure TPromotionWizard.ProcessProductGroupSelection(GroupID: integer; TableName: string);
begin
  Log('Promotion Wizard', 'ProcessProductGroupSelection');
  with dmPromotions.adoqRun do
  begin
    SQL.Text := Format('select cast(EntityCode as bigint) as ProductID, PortionTypeID '+
      'into #NewGroupItems '+
      'from Portions '+
      'join %s sel on Portions.PortionID = sel.Level5ID ', [TableName]);
    ExecSQL;

    SQL.Text := Format(
      'delete #promotionsalegroupdetail '+
      'from #promotionsalegroupdetail a '+
      'left outer join #newgroupitems b '+
      'on (a.productid = b.productid) and (a.portiontypeid = b.portiontypeid) '+
      'where a.salegroupid = %2:d '+
      'and b.productid is null '+

      'delete #newgroupitems '+
      'from #promotionsalegroupdetail a '+
      'join #newgroupitems b '+
      'on (a.productid = b.productid) and (a.portiontypeid = b.portiontypeid) '+
      'where a.salegroupid = %2:d '+

      'insert #promotionsalegroupdetail (SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID) '+
      'select %0:d, %1:s, %2:d, ProductID, PortionTypeID '+
      'from #newgroupitems', [WizardSiteCode, IntToStr(PromotionID), GroupID]);
    ExecSQL;

    SQL.Text := Format('drop table %s', [TableName]);
    ExecSQL;
    SQL.Text := Format('drop table #NewGroupItems', [TableName]);
    ExecSQL;

  end;
end;

procedure TPromotionWizard.OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
var
  i: integer;
  Statement: string;
  TmpPromoStatus: integer;
begin
  if Assigned(Page) then
    Log('Promotion Wizard', 'OnEnterPage: ' + Page.Name);
  if (Page = tsFinish) and (Direction = wdNext) then
  begin
    with dmPromotions.adoqrun do
    begin
      SQL.Text := Format('if exists(select * from #PromotionSaleGroupDetail a '+
        'join PromotionSaleGroupDetail b on b.PromotionID <> %s and a.ProductID = b.ProductID '+
        'and a.PortionTypeID = b.PortionTypeID) '+
        'select 1 as Duplicates else select 0 as Duplicates', [InttoStr(PromotionID)]);
      Open;
      lbDuplicateWarning.Visible := (Fields[0].AsInteger = 1);
      Close;
      SQL.Text := Format('if exists(select * from #PromotionModTime a '+
        'join Promotion_repl b on b.PromotionId = %s and a.LMDT <> b.LMDT) '+
        'select 1 else select 0', [InttoStr(PromotionID)]);
      Open;
      lbOtherUserChangesWarning.Visible := (Fields[0].AsInteger = 1);
      Close;
      if lbOtherUserChangesWarning.Visible and not lbDuplicateWarning.Visible then
        lbOtherUserChangesWarning.Top := lbDuplicateWarning.Top;
    end;
    if ReadOnly then
      Label34.Caption := READONLY_FINISH_TEXT
    else
      Label34.Caption := FINISH_TEXT;
  end
  else
  if Page = tsSingleRewardPrice then
  begin
    if dbgRewardPrices.SelectedList.Count > 0 then
      dbgRewardPrices.UnselectAll;
      
    with dmPromotions.adoqRun do
    begin
      SQL.Text := 'select status from #Promotion';
      Open;
      TmpPromoStatus := FieldByName('Status').AsInteger;
      Close;
    end;

    dmPromotions.qEditSingleRewardPrice.Active := True;

    if TmpPromoStatus = 2 then
      rbDefinePricesLater.Checked := True
    else
    begin
      with dmPromotions.adoqRun do
      begin
        SQL.Text := 'select * from #PromotionSalesAreaRewardPrice where RewardPrice is not null';
        Open;
        if RecordCount > 0 then
          rbPerSalesAreaRewardPrice.Checked := true;
        Close;
      end;
    end;

    SetRewardPriceMode.Execute;

    dmPromotions.qEditSalesAreaRewardPrice.Active := True;
  end
  else
  if Page = tsGroupPriceMethod then
  begin
    with dmPromotions.adoqRun do
    begin
      SQL.Text := 'select status from #Promotion';
      Open;
      TmpPromoStatus := FieldByName('Status').AsInteger;
      Close;
    end;

    cbLeaveUnpriced.Checked := TmpPromoStatus = 2;
  end
  else
  if (Page = tsGroupPrices) then
  begin
    if dbgPromoPrices.SelectedList.Count > 0 then
      dbgPromoPrices.UnselectAll;

    lbPriceHighlightLegend.Visible :=
      (promoTypeIndex = PromoType_EventPricing);
    if (Direction = wdNext) then
    begin
      Log('Promotion Wizard', 'Loading sales area names for price grid');

      LoadPriceReviewSANames;
      if (cbEditPriceSA.Items.Count > 0) and (cbEditPriceSA.ItemIndex = -1) then
        cbEditPriceSA.ItemIndex := 0;

      if (cbEditPriceGroup.Items.Count > 0) and (cbEditPriceGroup.ItemIndex = -1) then
        cbEditPriceGroup.ItemIndex := 0;

      with dmPromotions do
      begin
        BeginHourglass;
        dmPromotions.BuildCalculatedGroupList;

        // This query will normally raise a SQL warning due to the
        // "ignore dup key" set on the prices editing table
        if DataModified.PriceCalculationRequired then
        begin
          Log('Promotion Wizard', 'Running LoadPromotionPrices.sql');

          adoqRun.SQL.Text := StringReplace(GetStringResource('LoadPromotionPrices', 'TEXT'), '<PromotionId>', IntToStr(PromotionID), [rfReplaceAll, rfIgnoreCase]);

          try
            adoqrun.ExecSQL;
          except on E:EOLEException do
            if Pos('duplicate key was ignored', LowerCase(E.Message)) = 0 then
              raise;
          end;
          DataModified.PriceCalculationRequired := false;

          LogAnyZeroTariffPrices; //Added for job 337943
        end;
        Log('Promotion Wizard', 'Building dataset for prices grid');
        BuildPriceReviewSQL;
        qEditPromoPrice.Active := True;
        Log('Promotion Wizard', 'Showing prices grid');
        EndHourglass;
      end;
    end;
  end
  else
  if Page = tsSelectProducts then
  begin
    if DataModified.ProductLoadRequired then
    begin
      for i := 0 to Pred(ProductGroupCount) do
      begin
        with dmPromotions.adoqRun do
        begin
          // TODO for multiple group loads of a large amount of products, creating one
          // temporary table for all groups then passing query parts to LoadFromTempTable
          // would provide some speedup. Currently uses a subquery that is different for
          // each group. However the actual treeview load is the bottleneck in the cases
          // I've (PW) tested.
          Statement := Format(
            '(select PortionID '+
            'from #promotionsalegroupdetail a '+
            'join Portions b on a.ProductID = b.EntityCode and a.PortionTypeID = b.PortionTypeID '+
            'where SaleGroupID = %d)',
            [i+1]
          );

          ProductDataTree.LoadFromTempTable(ProductSelectionTrees[i], Statement, 'PortionID');
        end;
      end;
      DataModified.ProductLoadRequired := False;
    end;
    if tcProductGroups.TabIndex = -1 then
    begin
      tcProductGroups.TabIndex := 0;
      tcProductGroupsChange(tcProductGroups);
    end;
  end
  else
  if Page = tsExceptions then
  begin
      if not dmPromotions.qEditPromotionExceptions.Active then
        dmPromotions.UpdateExceptionsQuery;
  end
  else
  if Page = tsDefineGroups then
  begin
    ProcessProductGroupChange;
  end
  else
  if Page = tsEventPromotionActions then
  begin
    dmPromotions.LoadTmpEventStatus('#PromotionEventStatus');
    if not (dbgPromotionActions.Datasource.Dataset.Active) then
      PromotionActionsSortHelper.Reset;
    PromotionFilterFrame.ApplyFilterSettings(self); //Apply any existing filter settings
  end
  else if Page = tsPortionPriceMappings then
  begin
    dmPromotions.qEditPromoPortionPriceMapping.Close;
    dmPromotions.qEditPromoPortionPriceMapping.Open;

    if Visible then
      dbgPortionPriceMapping.SetFocus;
    dmPromotions.qPromoCalcType.Active := True;
  end;

  if ReadOnly and Assigned(Page) then
  begin
    DisablePromotionControls(Page);
    if Page = tsExceptions then
    begin
      EditException.Enabled := True;
      btEditException.Enabled := True;
    end
    else if Page = tsFinish then
    begin
      Label34.Enabled := True;
      lbDuplicateWarning.Enabled := True;
      lbOtherUserChangesWarning.Enabled := True;
    end
    else if Page = tsPromoDetails then
    begin
      HideNonstandardPromoDetailsFields;
    end;
  end;
end;

procedure TPromotionWizard.LogAnyZeroTariffPrices;
var
  exampleSalesArea: integer;
begin
  with dmPromotions.adoqRun do
  try
    Log('Promotion Wizard', 'Checking for products with zero tariff price');

    Close;
    SQL.Text := 'SELECT TOP 1 ProductId FROM #PromotionPrices WHERE TariffPrice = 0';
    Open;

    if not (IsEmpty) then
    begin
      Log('Promotion Wizard', 'Some products in the promotion have a zero tariff price. Some example sales areas with zero priced products:');

      Close;
      SQL.Text :=
        'SELECT TOP 10 SalesAreaID, COUNT(*) AS ZeroCount FROM #PromotionPrices ' +
        'WHERE TariffPrice = 0 GROUP BY SalesAreaId ORDER BY SalesAreaid';
      Open;

      exampleSalesArea := FieldByName('SalesAreaId').AsInteger;

      LogDataSet(dmPromotions.adoqRun, '  Sales Area: %s, Zero price count: %s', 2);

      Close;
      SQL.Text := Format(
        'SELECT TOP 10 b.[Extended Rtl Name], a.ProductID, c.Name ' +
        'FROM #PromotionPrices a ' +
        '   JOIN Products b ON a.ProductId = b.EntityCode ' +
        '   JOIN ac_PortionType c ON a.PortionTypeId = c.Id ' +
        'WHERE SalesAreaId = %d AND TariffPrice = 0 ORDER BY a.PortionTypeId, a.ProductId DESC',
        [exampleSalesArea]);
      Open;

      Log('Promotion Wizard', format('Some example products that have zero tariff price in sales area %d:', [exampleSalesArea]));
      LogDataSet(dmPromotions.adoqRun, '  %16s (%s) Portion: %s', 3);
    end;
  finally
    Close;
  end;
end;

function TPromotionWizard.CheckTextValue (Value : String; Error : String) : Boolean;
begin
  if Value = '' then
  begin
    MessageDlg(Error, mtCustom, [mbOK], 0);
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TPromotionWizard.UpdateGroupPrices(GroupID : Integer);
begin
  with dmPromotions.adoqRun do
    begin
      SQL.Clear;
      SQL.Text := Format('DELETE #PromotionPrices '+
                         '       FROM #PromotionPrices  '+
                         '            JOIN #PromotionSaleGroup ON #PromotionPrices.PromotionID = #PromotionSaleGroup.PromotionID '+
                         '                                        AND #PromotionPrices.SaleGroupID = #PromotionSaleGroup.SaleGroupID '+
                         ' WHERE CalculationType in (1, 2, 3, 4, 5) and #PromotionPrices.SaleGroupID = %d', [GroupID]);
      ExecSQL;
    end
end;

procedure TPromotionWizard.OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
var
  i: integer;
  currRecNo, cardValidation : integer;
  duplicateTimePeriods: string;
  IllFormedExceptions: string;
  LoyaltyPointsStr: String;
  LoyaltyPointsInt: Integer;
begin
  if Assigned(Page) then
    Log('Promotion Wizard', 'OnLeavePage: ' + Page.Name);
  if (Page = tsPromoDetails) and (Direction = wdNext) then
  begin
    if not CheckTextValue(edName.Text, 'Please enter a name before continuing') then abort;
    tsSingleRewardPrice.Enabled := promoTypeIndex = PromoType_MultiBuy;
    tsGroupPriceMethod.Enabled := not (promoTypeIndex in [PromoType_MultiBuy]);
    tsGroupPrices.Enabled := not (promoTypeIndex = PromoType_MultiBuy);
    tsDefineGroups.Enabled := not (promoTypeIndex = PromoType_Timed);
    tsPromoActivation.Enabled := not (promoTypeIndex = PromoType_EventPricing);
    tsEventPromotionActions.Enabled := promoTypeIndex = PromoType_EventPricing;
    tsPortionPriceMappings.Enabled := promoTypeIndex in [PromoType_Timed, PromoType_BOGOF];
    EventPricing := promoTypeIndex = PromoType_EventPricing;

    // check for duplicate names
    dmPromotions.adoqRun.SQL.Text :=
      Format('SELECT Name FROM promotion where Name = %s and Description = %s and PromotionId <> %s',
      [QuotedStr(edName.Text), QuotedStr(edDescription.Lines.Text), IntToStr(PromotionID)]);

    dmPromotions.adoqRun.Open;
    if (not dmPromotions.adoqRun.Eof) then begin
      MessageDlg(Format('A promotion named %s (with the same description) already exists.'#13#10+
        'Please enter a unique name and description.', [edName.Text]), mtInformation, [mbOK], 0);
      abort;
    end;
    // if a promotion is card activated then at least one group will need to be selected
    if (cbVerification.ItemIndex = 1) and (cbSwipeCardGroup.ItemIndex = 0) then
       begin
         MessageDlg('Please select a valid swipe card group.', mtInformation, [mbOk], 0);
         Abort;
       end;

    dmPromotions.adoqRun.SQL.Text :=
      Format('SELECT Name FROM promotion where Name = %s and PromotionId <> %s',
      [QuotedStr(edName.Text), IntToStr(PromotionID)]);

    dmPromotions.adoqRun.Open;
    if (not dmPromotions.adoqRun.Eof) then begin
      MessageDlg(Format ('Promotion name %s is not unique. '#13#10+
        'Please note this can cause ambiguity in reports, or if these promotions are run on the same site.',
        [edName.Text]), mtWarning, [mbOK], 0);
    end;

    if promoTypeIndex <> PromoType_EventPricing then
    begin
      dmPromotions.adoqRun.SQL.Text :=
        'UPDATE #PromotionSaleGroup SET Name = null';
      dmPromotions.SafeExecSQL;
    end;

    if promoTypeIndex = PromoType_Timed then
    begin
      // Timed promotion - delete groups other than 1
      dmPromotions.adoqRun.SQL.Text :=
        'DELETE #PromotionSaleGroup where SaleGroupID > 1 ';
      dmPromotions.adoqRun.ExecSQL;
      dmPromotions.qEditPromotionGroups.Requery();
      ProcessProductGroupChange;
    end
    else
    if promoTypeIndex = PromoType_EventPricing then
    with dmPromotions do
    begin
      // Promotion is being switched to Event Pricing.
      SaveProductGroupSelection;
      // Ensure all groups don't overlap. Delete higher group numbers.
      adoqrun.SQL.Text :=
        'delete #promotionsalegroupdetail '+
        'from #promotionsalegroupdetail a '+
        'join ( '+
        '  select min(salegroupid) salegrouptokeep, productid, portiontypeid '+
        '  from #promotionsalegroupdetail '+
        '  group by promotionid, productid, portiontypeid '+
        '  having count(*) > 1 '+
        ') sub on a.productid = sub.productid and a.portiontypeid = sub.portiontypeid '+
        '    and a.salegroupid > salegrouptokeep';
      SafeExecSQL;
      if adoqrun.RowsAffected > 0 then
      begin
        DataModified.ProductLoadRequired := true;
      end;

      // Ensure all groups except Banded Price groups are set to Price Entry calculation type
      adoqrun.SQL.Text :=
        'UPDATE #PromotionSaleGroup '+
        '  SET CalculationType = NULL, ' +
        '      CalculationValue = NULL, ' +
        'RememberCalculation = 0 '+
        'WHERE ISNULL(CalculationType,0) NOT IN (0,5) ';

      SafeExecSQL;
      if adoqrun.RowsAffected > 0 then
      begin
        if qEditPromotionGroups.Active then
          qEditPromotionGroups.Requery();
        DataModified.PriceCalculationRequired := true;
      end;

      // Set the "default" activation
      SetActivationDefaults;
    end;

    // Update wizard page "info labels"
    if promoTypeIndex = PromoType_EventPricing then
    begin
      lbSelectSitesInfo.Caption := LocaliseString('Select the sites and/or sales areas that the event applies to');
      lbDefineGroupsInfo.Caption := 'Define the event groups of eligible products; If multiple groups are defined, sites may activate event pricing for one or more of the groups.';
      lbDefineGroups.Caption := 'Event groups:';
      lbSelectProductsInfo.Caption := 'Select the products to define event prices for';
      lbExceptionsInfo.Caption := LocaliseString('Define exceptions to the event promotion actions for a set of sites/sales areas');
      lbGroupPricesInfo.Caption := 'Review or edit event prices for the selected products'
    end
    else
    begin
      lbSelectSitesInfo.Caption := LocaliseString('Select the sites and/or sales areas that the promotion applies to');
      lbDefineGroupsInfo.Caption := 'Define the sale groups of eligible products for the promotion';
      lbDefineGroups.Caption := 'Sale groups:';
      lbSelectProductsInfo.Caption := 'Select the products that the promotion applies to';
      lbExceptionsInfo.Caption := LocaliseString('Define exceptions to the products and activation rules for a set of sites/sales areas');
      lbGroupPricesInfo.Caption := 'Review or edit the effective prices for all products and groups';
    end;

    // Ensure that the GroupPriceMethodFrame calculationtype dropdown has the relevant
    // calculation types for the promotion type
    RefreshPricegroupSettings;

    if promoTypeIndex = PromoType_EventPricing then
      dmPromotions.qEditPromotionGroups.FieldByName('SaleGroupID').DisplayLabel := 'Event Group ID'
    else
      dmPromotions.qEditPromotionGroups.FieldByName('SaleGroupID').DisplayLabel := 'Sale Group ID';

    dbgPromotionGroups.DataSource.DataSet.FieldByName('Name').Visible :=
      promoTypeIndex = PromoType_EventPricing;
    dbgPromotionGroups.DataSource.DataSet.FieldByName('Quantity').Visible :=
      promoTypeIndex <> PromoType_EventPricing;
    dbgPromotionGroups.DataSource.DataSet.FieldByName('RecipeChildrenMode').Visible :=
      cbPromotionType.ItemIndex = PromoType_EnhancedBOGOF;
    dbgPromotionGroups.DataSource.DataSet.FieldByName('MakeChildrenFree').Visible :=
      cbPromotionType.ItemIndex = PromoType_EnhancedBOGOF;



    if cbValidation.ItemIndex = 0 then
       cardValidation := -1
    else
       cardValidation := integer(cbValidation.Items.Objects[cbValidation.ItemIndex]);

    if actLoyaltyPromotion.Checked then
    begin
      LoyaltyPointsInt := 0;
      try
        LoyaltyPointsInt := StrToInt(edtLoyaltyPointsRequired.Text);
      except
        on E: EConvertError do
        begin
          MessageDlg ('The point redemption cost for this loyalty promotion must be a non-zero whole number less than 1000000000.', mtError, [mbOK], 0);
          Abort;
        end;
        on E: Exception do
        begin
          MessageDlg ('The point redemption cost for this loyalty promotion is invalid.', mtError, [mbOK], 0);
          Abort;
        end;
      end;
      if LoyaltyPointsInt <= 0 then
      begin
        MessageDlg ('The point redemption cost for this loyalty promotion must be a non-zero whole number less than 1000000000.', mtError, [mbOK], 0);
        Abort;
      end
      else if LoyaltyPointsInt > 1000000000 then
      begin
        MessageDlg ('The point redemption cost for this loyalty promotion must be a non-zero whole number less than 1000000000.', mtError, [mbOK], 0);
        Abort;
      end;
    end;

    // Save promotion data
    LoyaltyPointsStr := edtLoyaltyPointsRequired.Text;
    if LoyaltyPointsStr = '' then
      LoyaltyPointsStr := 'null';
    dmPromotions.adoqRun.SQL.Text :=
      Format('UPDATE #Promotion '+
             'SET Name = %s, Description = %s, PromoTypeID = %d, FavourCustomer = %d, EventOnly = %d, HideFromCustomer = %d,'+
             '    CardActivated = %d, SwipeGroupID = %d, CardRating = %d, ValidWithAllPaymentMethods = %d, ValidWithAllDiscounts = %d,'+
             '    LoyaltyPromotion = %d, LoyaltyPointsRequired = %s, CanIncreasePrice = %d, GroupItemsUnderPromotion = %d,' +
             '    ReferenceRequired = %d, ExtendedFlag = %d, UserSelectsProducts = %d',
        [QuotedStr(edName.Text), QuotedStr(edDescription.Text),
        promoTypeIndex+1, cbFavourCustomer.itemindex, Integer(cbEventOnly.Checked), Integer(cbHideFromCustomer.Checked),
        cbVerification.itemindex, integer(cbSwipeCardGroup.Items.Objects[cbSwipeCardGroup.ItemIndex]), cardValidation,
        Integer(cbValidWithAllPaymentMethods.Checked), Integer(cbValidWithAllDiscounts.Checked), Integer(actLoyaltyPromotion.Checked),
        LoyaltyPointsStr, Integer(cbCanIncreasePrice.Checked), Integer(cbGroupItemsUnderPromotion.Checked), Integer(cbReferenceRequired.Checked),
        Integer(cbPromotionType.itemindex = PromoType_EnhancedBOGOF), Integer(cbPromotionalDeal.Checked and dmPromotions.usePromoDeals)]);
    dmPromotions.adoqRun.ExecSQL;
    Log('  Name', edName.Text);
    Log('  Description', edDescription.Text);
    Log('  Promotion Type', cbPromotionType.Text);
    Log('  Promotion Bias', cbFavourCustomer.Text);
  end
  else
  if (Page = tsSelectSites) and (Direction = wdNext) then
  begin
    if SiteSASelectionFrame.SelectedItems.Items.Count = 0 then
    begin
      MessageDlg (LocaliseString('Please select a Site/Sales area before continuing.'), mtInformation, [mbOK], 0);
      abort;
    end;
    if SiteSASelectionFrame.SelectionChanged then
    begin
      GetSalesAreaSelection(SalesAreaDataTree.SaveToTempTable(SiteSASelectionFrame.SelectedItems));
      SiteSASelectionFrame.SelectionChanged := False;
      DataModified.SalesAreaSelectionChanged := False;
      DataModified.SalesAreaSelectionUnProcessed := False;
      DataModified.PriceCalculationRequired := True;
    end;
    if not(DataModified.SalesAreaSelectionUnProcessed) then
    begin
      ProcessSalesAreaSelection;
      DataModified.SalesAreaSelectionUnProcessed := True;
    end;
  end
  else
  if (Page = tsDefineGroups) and (Direction = wdNext) then
  begin
    if dmPromotions.qEditPromotionGroups.State = dsEdit then
      dmPromotions.qEditPromotionGroups.Post;
    if dmPromotions.qEditPromotionGroups.RecordCount = 0 then
    begin
      MessageDlg ('Please setup a group of eligible products for this promotion.', mtInformation, [mbOK], 0);
      abort;
    end;
    with dmPromotions.adoqRun do
    begin
      SQL.Clear;
      SQL.Add ('SELECT * FROM #PromotionSaleGroup');
      SQL.Add ('WHERE (Quantity is Null) OR (Quantity NOT BETWEEN 1 AND 99999.99)');
      Open;
      if not Eof then
      begin
        MessageDlg ('All sale quantities must be between 1 and 99999.99.', mtInformation, [mbOK], 0);
        abort;
      end;
      Close;

      if EventPricing then
      begin
        SQL.Text :=
          'select * from #PromotionSaleGroup where Len(IsNull(Name, '''')) = 0';
        Open;
        if not Eof then
        begin
          MessageDlg ('Please give a name to all sale groups.', mtInformation, [mbOK], 0);
          abort;
        end;
        Close;

        SQL.Text :=
          'select Name from #PromotionSaleGroup group by Name having count(*) > 1';
        Open;
        if not Eof then
        begin
          MessageDlg ('All sale groups must have different names.', mtInformation, [mbOK], 0);
          abort;
        end;
        Close;
      end;
    end;
    ProcessProductGroupChange;
  end
  else
  if (Page = tsSelectProducts) and (Direction = wdNext) then
  begin
    // Check first that we have all the data needed before we save any of it to temp tables
    for i := 0 to Pred(ProductGroupCount) do
    begin
      if ProductSelectionTrees[i].Items.Count = 0 then
      begin
        MessageDlg ('A minimum of 1 product must be selected for each group.', mtInformation, [mbOK], 0);
        abort;
      end;
    end;
    SaveProductGroupSelection;

    // vk
    with dmPromotions.adoqRun do
    begin
      SQL.Text :=
        'if OBJECT_ID(''tempdb..##PromoProductSelection'') is not null drop table ##PromoProductSelection ';
      ExecSQL;

      SQL.Text := 'Select * into ##PromoProductSelection from #promotionsalegroupdetail';
      ExecSQL;
    end;
    // vk move TariffPricesPreload here to filter with site and product selections

    dmPromotions.GetDelayTariffPricesThread.Execute;
    dmPromotions.AwaitPreload(pwTarrifPrices);

  end
  else
  if (Page = tsPromoActivation) and (Direction = wdNext) then
    with dmPromotions do
    begin
      if not CheckTextValue (DateToStr(dtStartDate.Date), 'Please enter a value for start date.') then abort;
      if dtEndDate.Format <> GetBlankDateTimePicker then
      begin
        if Trunc(dtStartDate.Date) > Trunc(dtEndDate.Date) then
        begin
          MessageDlg ('Please select and end date that is after the start date.', mtInformation, [mbOK], 0);
          abort;
        end;
      end;

      //Check that at least one day has been selected as an active day for the promotion
      if chkbxAllTimes.Checked then
      begin
        if ValidDaysStrFromCheckboxes(clbValidDays) = '' then
        begin
          MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
          abort;
        end;
      end
      else
        with dstvalidTimes do
        begin
          currRecNo := RecNo;
          First;
          while not(Eof) do
          begin
            if dstValidTimesValidDays.AsString = '' then
            begin
              MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
              abort;
            end;
            Next;
          end;
          RecNo := currRecNo; //
        end;

      with adoqRun do
      try
        SQL.Text :=
          'SELECT ValidDays, dbo.fn_TimeFromDateTime(StartTime) AS StartTime, dbo.fn_TimeFromDateTime(EndTime) AS EndTime ' +
          'FROM #PromotionTimeCycles ' +
          'GROUP BY ValidDays, dbo.fn_TimeFromDateTime(StartTime), dbo.fn_TimeFromDateTime(EndTime) ' +
          'HAVING COUNT(*) > 1';
        Open;
        if RecordCount > 0 then
        begin
          while not(eof) do
          begin
            duplicateTimePeriods := duplicateTimePeriods +
                ValidDaysDisplay(FieldByName('ValidDays').AsString) + '  ' +
                FormatDateTime('hh:mm', FieldByName('StartTime').Value) + ' to ' +
                FormatDateTime('hh:mm', FieldByName('EndTime').Value) + #13#10;
            Next;
          end;
          MessageDlg ('The following time period(s) are duplicated. Please ensure there are no duplicates.'#13#10#13#10+
            duplicateTimePeriods, mtInformation, [mbOK], 0);
          Abort;
        end;
      finally
        Close;
      end;

      with adoqRun do
      try
        SQL.Text :=
          'SELECT pe.Name, dbo.fn_DateFromDateTime(IsNull(pe.StartDate, p.StartDate)) AS StartDate, ' +
          '   CASE pe.EndDate WHEN null THEN pe.EndDate ELSE dbo.fn_DateFromDateTime(IsNull(pe.EndDate, p.EndDate)) END AS EndDate ' +
          'FROM #Promotion p ' +
          'JOIN #PromotionException pe ' +
          'ON p.PromotionID = pe.PromotionID ' +
          'WHERE pe.StartDate < ''' + FormatDateTime('yyyy-mm-dd', dtStartDate.Date) + '''';

          if dtEndDate.Format <> GetBlankDateTimePicker then
            SQL.Text := SQL.Text + ' OR pe.EndDate > ''' + FormatDateTime('yyyy-mm-dd', dtEndDate.Date) + '''';
        Open;
        if RecordCount > 0 then
        begin
          while not(eof) do
          begin
            IllFormedExceptions := IllFormedExceptions + '"' +
                FieldByName('Name').AsString + '":  starting on ' +
                DateToStr(FieldByName('StartDate').AsDateTime);
            if not FieldByName('EndDate').IsNull then
              IllFormedExceptions := IllFormedExceptions + ', ending on ' + DateToStr(FieldByName('EndDate').AsDateTime);
            IllFormedExceptions := IllFormedExceptions + '.'#13#10;
            Next;
          end;
          MessageDlg ('The following exceptions overlap the given start and/or end dates and '#13#10 +
                      'must be amended before changing the start date and/or end date.'#13#10#13#10 +
                      IllFormedExceptions, mtInformation, [mbOK], 0);
          Abort;
        end;
      finally
        Close;
      end;

      if dtEndDate.Format <> GetBlankDateTimePicker then
        adoqrun.SQL.Text := Format('UPDATE #Promotion SET StartDate = %s, EndDate = %s', [GetSQLDate(dtStartDate.Date), GetSQLDate(dtEndDate.Date)])
      else
        adoqrun.SQL.Text := Format('UPDATE #Promotion SET StartDate = %s, EndDate = %s', [GetSQLDate(dtStartDate.Date), GetSQLDate(0)]);

      adoqrun.ExecSQL;

      Log('  Start Date', DateToStr(dtStartDate.Date));
      Log('  Stop Date', DateToStr(dtEndDate.Date));
      LogTimePeriods;
    end
  else
  if (Page = tsSingleRewardPrice) and (Direction = wdBack) then
  begin
    with dmPromotions.qEditSalesAreaRewardPrice do
      if State = dsEdit then
        Post;
    with dmPromotions.qEditSingleRewardPrice do
      if State = dsEdit then
        Post;
    dmPromotions.qEditSalesAreaRewardPrice.Active := False;
    dmPromotions.qEditSingleRewardPrice.Active := False;
  end
  else
  if (Page = tsSingleRewardPrice) and (Direction = wdNext) then
  begin

    with dmPromotions.qEditSalesAreaRewardPrice do
      if State = dsEdit then
        Post;
    with dmPromotions.qEditSingleRewardPrice do
      if State = dsEdit then
        Post;

    if rbDefinePricesLater.Checked then
    begin
      dmPromotions.adoqRun.SQL.Text := 'UPDATE #Promotion SET Status = 2';
    end
    else
    begin
      // Ensure status is no longer "unpriced"
      dmPromotions.adoqRun.SQL.Text := 'UPDATE #Promotion SET Status = 0 where Status = 2';
    end;
    dmPromotions.adoqRun.ExecSQL;

    if rbSingleRewardPrice.Checked then
    begin
      if not CheckTextValue(dbedRewardPrice.Text, 'Please enter a single reward price.') then
        abort;

      if not ((dmPromotions.qEditSingleRewardPrice.FieldByName('SingleRewardPrice').AsCurrency <= HIGH_PRICE_RANGE)
        and (dmPromotions.qEditSingleRewardPrice.FieldByName('SingleRewardPrice').AsCurrency >= LOW_PRICE_RANGE)) then
      begin
       MessageDlg (Format('The reward price must be between %f and %f.', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]), mtInformation, [mbOK], 0);
       abort;
      end;
    end
    else
    begin
      // Set the single reward price to null if per sales area prices are to be used
      dmPromotions.qEditSingleRewardPrice.Edit;
      dmPromotions.qEditSingleRewardPrice.FieldByName('SingleRewardPrice').Clear;
      dmPromotions.qEditSingleRewardPrice.Post;
    end;

    if rbPerSalesAreaRewardPrice.Checked then
    begin
      with dmPromotions.adoqRun do
      begin
        SQL.Clear;
        SQL.Add('SELECT RewardPrice FROM #PromotionSalesAreaRewardPrice');
        SQL.Add(Format('WHERE (RewardPrice NOT BETWEEN %f and %f) OR RewardPrice IS NULL', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]));
        Open;
        if recordcount > 0 then
        begin
          MessageDlg(Format('All prices must be between %f and %f.', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]), mtInformation, [mbOK], 0);
          abort;
        end;
        Close;
      end;
    end;
    dmPromotions.qEditSalesAreaRewardPrice.Active := False;
    dmPromotions.qEditSingleRewardPrice.Active := False;
  end
  else
  if (Page = tsGroupPriceMethod) and (Direction = wdNext) then
  begin
    // need to process the items in the Group Price Settings and save them to the database
    for i:=0 to High (ProductGroupPriceMethods) do
    begin
      ProductGroupPriceMethods[i].CheckValidValue;
      if ProductGroupPriceMethods[i].Modified then
      begin
        SavePriceGroupSetting(ProductGroupPriceMethods [i], i+1);
        UpdateGroupPrices(i+1);
        ProductGroupPriceMethods[i].Modified := false;
        DataModified.PriceCalculationRequired := true;
      end;
    end;
    if cbLeaveUnpriced.Checked then
    begin
      tsGroupPrices.Enabled := False;
      dmPromotions.adoqRun.SQL.Text := 'UPDATE #Promotion SET Status = 2';
      Log(' OnLeavePage - ',dmPromotions.adoqRun.SQL.Text);
      dmPromotions.adoqRun.ExecSQL;
    end
    else
    begin
      tsGroupPrices.Enabled := not (promoTypeIndex = PromoType_MultiBuy);
      dmPromotions.adoqRun.SQL.Text := 'UPDATE #Promotion SET Status = 0 where Status = 2';
      dmPromotions.adoqRun.ExecSQL;
      dmPromotions.AwaitPreload(pwTarrifPrices);
    end;

    if (Direction = wdNext) then
    begin
      //Lets not show the Portion-Price Mapping screeni if there are no applicable groups
      with dmPromotions.adoqRun do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select count(*) as NumPermissableGroups');
        SQL.Add('from #PromotionSaleGroup');
        SQL.Add('where  CalculationType between 1 and 4');
        Open;
        tsPortionPriceMappings.Enabled := FieldByName('NumPermissableGroups').AsInteger > 0;
      end;
    end;
  end
  else
  if (Page = tsPortionPriceMappings) and (Direction = wdNext) then
  begin
    with dmPromotions.qEditPromoPortionPriceMapping do
    begin
      if State = dsEdit then
        dmPromotions.qEditPromoPortionPriceMapping.Post;
    end;
    DataModified.PriceCalculationRequired := DataModified.PriceCalculationRequired or DataModified.PortionPriceMappingsChanged;
  end
  else
  if (Page = tsGroupPrices) and (Direction = wdBack) then
  begin
    with dmPromotions.qEditPromoPrice do
    begin
      if State = dsEdit then
        Post;
    end;
  end
  else
  if (Page = tsGroupPrices) and (Direction = wdNext) then
  begin
    with dmPromotions.qEditPromoPrice do
    begin
      if State = dsEdit then
        Post;
    end;
    with dmPromotions.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Price');
      SQL.Add('FROM #PromotionPrices a');
      SQL.Add(Format('WHERE (a.Price NOT BETWEEN %f and %f) OR a.Price IS NULL', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]));
      Open;
      if not Eof then begin
        MessageDlg (Format('All prices must be between %f and %f.', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]), mtInformation, [mbOK], 0);
        abort;
      end;
      Close;
    end;
  end
  else if Page = tsEventPromotionActions then
  begin
    dmPromotions.SaveTmpEventStatus(WizardSiteCode, '#PromotionEventStatus', PromotionID);
    dmPromotions.qEditEventStatus.Active := false;
  end;
end;

procedure TPromotionWizard.SetRewardPriceModeExecute(Sender: TObject);
begin
  dbedRewardPrice.Enabled := rbSingleRewardPrice.Checked;
  dbgRewardPrices.Enabled := rbPerSalesAreaRewardPrice.Checked;
  case dbgRewardPrices.Enabled of
    True:
      dbgRewardPrices.Font.Color := clBlack;
    False:
      dbgRewardPrices.Font.Color := clGrayText;
  end;
  if rbSingleRewardPrice.Checked then
    Log('  Reward Price', 'Single Reward Price Checked')
  else
    if rbPerSalesAreaRewardPrice.Checked then
      Log('  Reward Price', 'Sales Area Per Reward Price Checked')
    else
      Log('  Reward Price', 'Define Prices Checked');
end;

procedure TPromotionWizard.tsSelectSitesResize(Sender: TObject);
begin
  SiteSASelectionFrame.OnResize(Sender);
end;
procedure TPromotionWizard.tsSelectProductsResize(Sender: TObject);
begin
  tvAvailableProducts.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tcProductGroups.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  sbIncludeProduct.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbIncludeAllProducts.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeAllProducts.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeProduct.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tcProductGroups.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lbSelectedProducts.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;


procedure TPromotionWizard.RewardPriceExportExecute(Sender: TObject);
begin
  Log('  Reward Price', 'Export Button Clicked');
  with dmPromotions.qEditSalesAreaRewardPrice do
    if State = dsEdit then
      Post;
  with dmPromotions.adoqRun do
  begin
    SQL.Text :=
      'select a.SalesAreaID, SiteRef, SiteName, SalesAreaName, a.RewardPrice '+
      'into #ExportTemp '+
      'from #PromotionSalesAreaRewardPrice a '+
      'left outer join ( '+
      '  select distinct '+
      '    cast(config.[Sales Area Code] as smallint) as SalesAreaID, '+
      '    siteaztec.[Site Ref] as SiteRef, '+
      '    siteaztec.[Site Name] as SiteName, '+
      '    config.[Sales Area Name] as SalesAreaName '+
      '  from config '+
      '  join siteaztec on config.[site code] = siteaztec.[site code] '+
      '  where (config.deleted is null or config.deleted = ''N'') '+
      '    and config.[Sales Area Code] is not null '+
      ') b on a.SalesAreaID = b.SalesAreaID';
    ExecSQL;
  end;
  try
    with TExcelExportImport.Create do
    begin
      CopyToClipBoard(dmPromotions.AztecConn, '#ExportTemp', 'SalesAreaID', 'SiteRef,SiteName,SalesAreaName,RewardPrice', 'SiteRef,SiteName,SalesAreaName');
      Free;
    end;
  finally
    with dmPromotions.adoqRun do
    begin
      SQL.Text :=
        'drop table #ExportTemp';
      ExecSQL;
    end
  end;
end;

procedure TPromotionWizard.RewardPriceImportExecute(Sender: TObject);
var
  slErrors: TStringlist;
  PriceField: Integer;

  function DeterminePriceFieldIndex: Integer;
  var
    Fixed: TStringList;
    Key: TStringList;
  begin
    Fixed := TStringList.Create;
    Key := TStringList.Create;
    try
      ExtractStrings([','], [' '], PChar('SalesAreaID'), Fixed);
      ExtractStrings([','], [' '], PChar('SiteRef,SiteName,SalesAreaName'), Key);
      Result := Fixed.Count + Key.Count;
    finally
      Fixed.Free;
      Key.Free;
    end;
  end;

begin
  Log('  Reward Price', 'Export Button Clicked');
  with dmPromotions.qEditSalesAreaRewardPrice do
    if State = dsEdit then
      Post;
  slErrors := TStringList.create;

  with TExcelExportImport.Create do
  begin
    PriceField := DeterminePriceFieldIndex;
    PasteFromClipBoard(dmPromotions.AztecConn, '#PromotionSalesAreaRewardPrice', 'SalesAreaID', 'SiteRef,SiteName,SalesAreaName', 'RewardPrice', '', slErrors, [PriceField]);
    if slErrors.Count > 0 then
    begin
      Log('BCP Import Error - Reward Price ','Error importing from clipboard, details:');
      Log('BCP Import Error - ',slErrors.Text);
    end;
    Free;
  end;
  slErrors.Free;

  dmPromotions.qEditSalesAreaRewardPrice.Close;
  dmPromotions.qEditSalesAreaRewardPrice.Open;
end;

procedure TPromotionWizard.cbEditPriceGroupCloseUp(Sender: TObject);
begin
  if (dbgPromoPrices.SelectedList.Count > 0) then
    dbgPromoPrices.UnselectAll;
  if Tedit(Sender).Name = cbEditPriceGroup.Name then
     Log('  Review/Edit Prices', 'Group Selected')
  else
     Log('  Review/Edit Prices', 'Site/Sales Area Selected');
  BuildPriceReviewSQL;
  dmPromotions.qEditPromoPrice.Active := True;
end;

procedure TPromotionWizard.BuildPriceReviewSQL;
begin
  // Use of ProductNameCache is rather rubbish, but the lack of a primary
  // key on that table causes a specific error to ADO when updating a temp
  // table that is JOINed to the Products table directly.
  // The only other workaround was to use a server side cursor which had other
  // consequences (seemed to change the SPID context of the main SQL connection).
  dmPromotions.qEditPromoPrice.SQL.Clear;
  dmPromotions.qEditPromoPrice.SQL.Add('SELECT a.*');
  dmPromotions.qEditPromoPrice.SQL.Add('FROM #PromotionPrices a');
  dmPromotions.qEditPromoPrice.SQL.Add('JOIN ##ProductNameCache b on a.ProductID = b.EntityCode');
  dmPromotions.qEditPromoPrice.SQL.Add('JOIN #SiteSANames c on a.SalesAreaID = c.SalesAreaID');

  // first item in both these combo boxes is All Items so we only apply the where if one of them is not 0
  if (cbEditPriceGroup.ItemIndex > 0) or (cbEditPriceSA.ItemIndex > 0) then
  begin
    dmPromotions.qEditPromoPrice.SQL.Add('WHERE');
    if (cbEditPriceGroup.ItemIndex > 0) then
      dmPromotions.qEditPromoPrice.SQL.Add(Format ('(a.SaleGroupID = %d)', [cbEditPriceGroup.ItemIndex]));
    if (cbEditPriceGroup.ItemIndex > 0) and (cbEditPriceSA.ItemIndex > 0) then
      dmPromotions.qEditPromoPrice.SQL.Add('AND');
    if (cbEditPriceSA.ItemIndex > 0) then
      dmPromotions.qEditPromoPrice.SQL.Add(Format ('(a.SalesAreaID = %d)', [Integer(cbEditPriceSA.Items.Objects[cbEditPriceSA.ItemIndex])]));
  end;
  dmPromotions.qEditPromoPrice.SQL.Add('order by a.SaleGroupID, c.SiteRef, c.SalesAreaName, b.[Extended RTL Name], a.PortionTypeID');
end;

procedure TPromotionWizard.LoadPriceReviewSANames;
begin
  with dmPromotions.adoqRun do
  begin
    SQL.Clear;
    SQL.Text :=
    'SELECT IsNull(s.Reference + '' '', '''') + s.Name + '' : '' + sa.Name as SAName, sa.Id AS [Sales Area Code]'+
    'FROM ac_SalesArea sa'+
    '  JOIN ac_Site s ON s.Id = sa.SiteId '+
    'WHERE sa.Id IN (SELECT SalesAreaId FROM #PromotionSalesArea) '+
      'ORDER BY 1';
    Open;
    cbEditPriceSA.Items.Clear;
    cbEditPriceSA.Items.AddObject(ALL_ITEMS,TObject(-1));
    while not Eof do
    begin
      cbEditPriceSA.Items.AddObject(FieldByName('SAName').AsString, TObject(FieldByName('Sales Area Code').AsInteger));
      Next;
    end;
    Close;
  end;
end;

procedure TPromotionWizard.GroupPriceExportExecute(Sender: TObject);
begin
  Log('  Review/Edit Prices', 'Export Button Clicked');
  with dmPromotions.adoqRun do
  begin
    SQL.Text :=
      'select a.SaleGroupID as GroupID, a.SalesAreaID, a.ProductID, a.PortionTypeID, IsNull(c.Name, ''Group ''+cast(a.SaleGroupID as varchar(10))) as GroupName, '+
      '  SiteRef, SiteName, SalesAreaName, [Extended RTL Name] as ProductName, PortionTypeName, a.TariffPrice, a.Price '+
      'into #ExportTemp '+
      'from #PromotionPrices a '+
      'join ( '+
      '  select distinct '+
      '    cast(config.[Sales Area Code] as smallint) as SalesAreaID, '+
      '    siteaztec.[Site Ref] as SiteRef, '+
      '    siteaztec.[Site Name] as SiteName, '+
      '    config.[Sales Area Name] as SalesAreaName '+
      '  from config '+
      '  join siteaztec on config.[site code] = siteaztec.[site code] '+
      '  where (config.deleted is null or config.deleted = ''N'') '+
      '    and config.[Sales Area Code] is not null '+
      ') b on a.SalesAreaID = b.SalesAreaID '+
      'join #PromotionSaleGroup c on a.SaleGroupID = c.SaleGroupID and c.RememberCalculation = 0 '+
      'join ##ProductNameCache on '+
      '  a.ProductID = EntityCode '+
      'join PortionType on a.PortionTypeID = PortionType.PortionTypeID';
    ExecSQL;
  end;
  try
    with TExcelExportImport.Create do
    begin
      CopyToClipBoard(dmPromotions.AztecConn, '#ExportTemp', 'GroupID,SalesAreaID,ProductID,PortionTypeID', 'GroupName,SiteRef,SiteName,SalesAreaName,ProductName,PortionTypeName,TariffPrice,Price', 'GroupName,SiteRef,SiteName,SalesAreaName,ProductName,PortionTypeName');
      Free;
    end;
  finally
    with dmPromotions.adoqRun do
    begin
      SQL.Text :=
        'drop table #ExportTemp';
      ExecSQL;
    end
  end;
end;

procedure TPromotionWizard.GroupPriceImportExecute(Sender: TObject);
var
  slErrors: TStringlist;
  PriceField: Integer;

  function DeterminePriceFieldIndex: Integer;
  var
    Fixed: TStringList;
    Key: TStringList;
  begin
    Fixed := TStringList.Create;
    Key := TStringList.Create;
    try
      ExtractStrings([','], [' '], PChar('SaleGroupID as GroupID,SalesAreaID,ProductID,PortionTypeID'), Fixed);
      ExtractStrings([','], [' '], PChar('GroupName,SiteRef,SiteName,SalesAreaName,ProductName,PortionTypeName,TariffPrice'), Key);
      Result := Fixed.Count + Key.Count;
    finally
      Fixed.Free;
      Key.Free;
    end;
  end;

begin
  Log('  Review/Edit Prices', 'Import Button Clicked');
  slErrors := TStringList.create;
  with dmPromotions.adoqRun do
  begin
    with TExcelExportImport.Create do
    begin
      PriceField := DeterminePriceFieldIndex;
      PasteFromClipBoard(dmPromotions.AztecConn, '#PromotionPrices', 'SaleGroupID as GroupID,SalesAreaID,ProductID,PortionTypeID', 'GroupName,SiteRef,SiteName,SalesAreaName,ProductName,PortionTypeName,TariffPrice', 'Price', '', slErrors, [PriceField]);
      if slErrors.Count > 0 then
      begin
        Log('BCP Import Error - Group Price ','Error importing from clipboard, details:');
        Log('BCP Import Error - ',slErrors.text);
      end;
      Free;
    end;
  end;
  slErrors.Free;
  BuildPriceReviewSQL;
  dmPromotions.qEditPromoPrice.Active := True;
end;

procedure TPromotionWizard.NewExceptionExecute(Sender: TObject);
begin
  Log('Exceptions', 'New Clicked');
  if TExceptionWizard.ShowWizard(WizardSiteCode, PromotionID, -1, False, ReadOnly) = mrOk then
  begin
    dmPromotions.UpdateExceptionsQuery;
    ResizeForNewException;
  end;
end;

procedure TPromotionWizard.EditExceptionExecute(Sender: TObject);
begin
  Log('Exceptions', 'Edit Clicked');

  if TExceptionWizard.ShowWizard(WizardSiteCode, PromotionID,
    TLargeIntField(dmPromotions.qEditPromotionExceptions.FieldByName('ExceptionID')).AsLargeInt,
      False, ReadOnly) = mrOk then
  begin
    dmPromotions.UpdateExceptionsQuery;
    ResizeForNewException;
  end;
end;

procedure TPromotionWizard.CopyExceptionExecute(Sender: TObject);
begin
  Log('Exceptions', 'Copy Clicked');
    
  if TExceptionWizard.ShowWizard(WizardSiteCode, PromotionID,
    TLargeIntField(dmPromotions.qEditPromotionExceptions.FieldByName('ExceptionID')).AsLargeInt,
      True, ReadOnly) = mrOk then
    dmPromotions.UpdateExceptionsQuery;
end;

procedure TPromotionWizard.DisableExceptionExecute(Sender: TObject);
var
  Dataset: TDataset;

  procedure SetStatus(Status: TPromotionStatus);
  begin
    with dmPromotions.adoqrun do
    begin
      SQL.Clear;
      SQL.Add(Format ('UPDATE #PromotionException SET Status = %d', [Ord(Status)]));
      SQL.Add(Format ('WHERE ExceptionID = %s', [dbgrdExceptions.DataSource.DataSet.FieldByName('ExceptionID').AsString]));
      ExecSQL;
    end;
    if (Status = psDisabled) and (cbHideDisabledExceptions.Checked) then
    begin
      Dataset.DisableControls;
      Dataset.Prior;
      dmPromotions.UpdateExceptionsQuery;
      Dataset.EnableControls;
    end
    else
      dmPromotions.UpdateExceptionsQuery;
  end;

  function ExceptionText: String;
  begin
    Result := 'Please pick a promotion to %s first';
    if Dataset.RecordCount <> 0 then
    case TPromotionStatus(Dataset.FieldByName('Status').AsInteger) of
      psEnabled: Result := Format(Result, ['disable']);
      psDisabled: Result := Format(Result, ['enable']);
    end;
  end;

begin
  Log('Exceptions', 'Enable/Disable Clicked');

  Dataset := dbgrdExceptions.DataSource.DataSet;
  if dbgrdExceptions.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create(ExceptionText);
  if Dataset.RecordCount <> 0 then
    case TPromotionStatus(Dataset.FieldByName('Status').AsInteger) of
      psEnabled: SetStatus(psDisabled);
      psDisabled: SetStatus(psEnabled);
    end;
end;

procedure TPromotionWizard.DeleteExceptionExecute(Sender: TObject);
var
  exceptionId: integer;
  exceptionName: string;
begin
  Log('Exceptions', 'Delete Clicked');

  exceptionId := dbgrdExceptions.DataSource.DataSet.FieldByName('ExceptionID').AsInteger;
  exceptionName := dbgrdExceptions.DataSource.DataSet.FieldByName('Name').AsString;

  if MessageDlg(Format('Delete "%s" ?', [exceptionName]), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  with dmPromotions.adoqRun do
  begin
    SQL.Clear;
    SQL.Add(Format ('DELETE #PromotionException WHERE ExceptionID = %d', [exceptionId]));
    SQL.Add(Format ('DELETE #PromotionExceptionSalesArea WHERE ExceptionID = %d', [exceptionId]));
    SQL.Add(Format ('DELETE #PromotionExceptionTimeCycles WHERE ExceptionID = %d', [exceptionId]));
    SQL.Add(Format ('DELETE #PromotionExceptionEventStatus WHERE ExceptionID = %d', [exceptionId]));

    ExecSQL;
    dmPromotions.UpdateExceptionsQuery;
  end;
end;

procedure TPromotionWizard.dbgPromoPricesRowChanged(Sender: TObject);
begin
  TwwDBGrid(sender).Fields[6].ReadOnly := dmPromotions.IsCalculatedGroup(TwwDBGrid(Sender).Fields[0].AsInteger);
  if TwwDBGrid(sender).Fields[6].ReadOnly then
    TwwDBGrid(sender).Options := TwwDBGrid(sender).Options - [dgEditing]
  else
    TwwDBGrid(sender).Options := TwwDBGrid(sender).Options + [dgEditing];
end;

procedure TPromotionWizard.dbgPromoPricesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  with TwwDBGrid(Sender) do
  begin
    if (Field.FieldName = 'Price') and (dmPromotions.IsCalculatedGroup(Fields[0].AsInteger)) then
    begin
      ABrush.Color := clBtnFace;
    end;
  end;
end;

procedure TPromotionWizard.HideDisabledExceptionsExecute(Sender: TObject);
begin
  if cbHideDisabledExceptions.Checked then
    Log('Exceptions', 'Hide Disabled Exceptions Checked')
  else
    Log('Exceptions', 'Hide Disabled Exceptions Unchecked');
  dmPromotions.HideDisabledExceptions(cbHideDisabledExceptions.Checked);
end;

procedure TPromotionWizard.PromotionActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if (Action = NewException) or (Action = EditException) or
    (Action = CopyException) or (Action = DisableException) or
    (Action = DeleteException) then
    dbgrdExceptions.SetFocus;
end;

procedure TPromotionWizard.dbgrdExceptionsTitleButtonClick(Sender: TObject;
  AFieldName: String);
var
  i: integer;
begin
  Log('Exceptions', 'Title Button Clicked');
  with TwwDBGrid(Sender) do
  begin
    for i := 0 to Pred(Selected.Count) do
      if Copy(Selected[i], 1, length(AFieldName)) = AFieldName then
       dmPromotions.ToggleExceptionsFieldOrder(i+1);
  end;
end;

procedure TPromotionWizard.DisableExceptionUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  // User is not allowed to enable or disable an promo with status of unpriced
  Dataset := dbgrdExceptions.DataSource.DataSet;
  TAction(Sender).Enabled := Dataset.RecordCount <> 0;
  if Dataset.RecordCount <> 0 then
    case TPromotionStatus(Dataset.FieldByName('Status').AsInteger) of
      psEnabled: TAction(Sender).Caption := 'Disable';
      psDisabled: TAction(Sender).Caption := 'Enable';
      psUnpriced: TAction(Sender).Enabled := False;
    end;
end;

procedure TPromotionWizard.ExceptionButtonUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dbgrdExceptions.DataSource.Dataset.RecordCount > 0;
end;

procedure TPromotionWizard.AddSaleGroup(SaleGroupID: integer);
begin
  SetLength(ProductSelectionTrees, ProductGroupCount+1);
  SetLength(DataModified.ProductGroupSelection, ProductGroupCount+1);
  SetLength(ProductGroupPriceMethods, ProductGroupCount+1);

  DataModified.ProductGroupSelection[SaleGroupID-1] := False;
  tcProductGroups.Tabs.Add('Group '+IntToStr(SaleGroupID));
  cbEditPriceGroup.Items.Add('Group '+IntToStr(SaleGroupID));
  ProductSelectionTrees[SaleGroupID-1] := TTreeView.Create(tcProductGroups);
  ProductSelectionTrees[SaleGroupID-1].ReadOnly := True;
  ProductSelectionTrees[SaleGroupID-1].ShowHint := True;
  ProductSelectionTrees[SaleGroupID-1].Parent := tcProductGroups;
  ProductSelectionTrees[SaleGroupID-1].Align := alClient;
  ProductSelectionTrees[SaleGroupID-1].HideSelection := False;
  ProductSelectionTrees[SaleGroupID-1].SendToBack;
  // Clash of border style between TTreeView and TScrollBox looks
  // a bit weird under XP themes
  ProductSelectionTrees[SaleGroupID-1].BorderStyle := bsNone;
  ProductGroupPriceMethods[SaleGroupID-1] := TGroupPriceMethodFrame.Create(sbPromoGroupPriceMethod, promoTypeIndex, dmPromotions.PromotionMode);
  ProductGroupPriceMethods[SaleGroupID-1].Parent := sbPromoGroupPriceMethod;
  // PW: This line is required to set the scroll y position within the scrollbox
  // to 0. Otherwise, the controls we add have the correct TOP coordinate
  // but actually appear with the TOP coordinate + the scroll offset at the time
  // they were added.
  sbPromoGroupPriceMethod.ScrollInView(ProductGroupPriceMethods[0]);
  ProductGroupPriceMethods[SaleGroupID-1].Top := (SaleGroupID-1) * ProductGroupPriceMethods[SaleGroupID-1].Height;
  ProductGroupPriceMethods[SaleGroupID-1].Width := sbPromoGroupPriceMethod.ClientWidth;

  // Need to load the proper values for this here
  ProductGroupPriceMethods[SaleGroupID-1].Name := Format('GroupFrame%d', [SaleGroupID]);
  ProductGroupPriceMethods[SaleGroupID-1].GroupName := Format('Group %d', [SaleGroupID]);
  LoadPricegroupSetting(ProductGroupPriceMethods[SaleGroupID-1], SaleGroupID);

  ProductGroupCount := ProductGroupCount + 1;
end;

procedure TPromotionWizard.RemoveSaleGroup(SaleGroupID: integer);
var
  i: integer;
begin
  // This is required so that top values can be set for the price group
  // controls.
  sbPromoGroupPriceMethod.ScrollInView(ProductGroupPriceMethods[0]);

  ProductSelectionTrees[SaleGroupID-1].Parent := nil;
  ProductGroupPriceMethods[SaleGroupID-1].Parent := nil;

  ProductGroupPriceMethods[SaleGroupID-1].Free;
  ProductSelectionTrees[SaleGroupID-1].Free;

  for i := SaleGroupID to High(ProductSelectionTrees) do
  begin
    tcProductGroups.Tabs[i] := 'Group '+IntToStr(i);
    cbEditPriceGroup.Items[i+1] := 'Group '+IntToStr(i);
    ProductGroupPriceMethods[i].Name := Format('GroupFrame%d', [i]);
    ProductGroupPriceMethods[i].GroupName := 'Group '+IntToStr(i);
    ProductGroupPriceMethods[i].Top := ProductGroupPriceMethods[i].Top - ProductGroupPriceMethods[i].Height;
    ProductSelectionTrees[i-1] := ProductSelectionTrees[i];
    ProductGroupPriceMethods[i-1] := ProductGroupPriceMethods[i];
  end;
  tcProductGroups.Tabs.Delete(SaleGroupID-1);
  cbEditPRiceGroup.Items.Delete(SaleGroupID);

  dmPromotions.DeleteDataForSaleGroup(SaleGroupID);
  ProductGroupCount := ProductGroupCount - 1;
  SetLength(ProductSelectionTrees, ProductGroupCount);
  SetLength(DataModified.ProductGroupSelection, ProductGroupCount);
  SetLength(ProductGroupPriceMethods, ProductGroupCount);
end;

procedure TPromotionWizard.SetSaleGroupName(SaleGroupID: integer;
  Name: string);
begin
  tcProductGroups.Tabs[SaleGroupID-1] := StringReplace(Name, '&', '&&', [rfReplaceAll]);
  if lowercase(Name) = Format('group %d', [SaleGroupID]) then
    cbEditPriceGroup.Items[SaleGroupID] := Name
  else
    cbEditPriceGroup.Items[SaleGroupID] := Format('%d: %s', [SaleGroupID, Name]);

  ProductGroupPriceMethods[SaleGroupID-1].GroupName := Name;
end;

procedure TPromotionWizard.SetActivationDefaults;
begin
  with dmPromotions.adoqRun do
  begin
    SQL.Text :=
      'TRUNCATE TABLE #PromotionTimeCycles ' +

      'INSERT #PromotionTimeCycles (ValidDays, StartTime, EndTime) ' +
      'VALUES (''1234567'', ' +
         QuotedStr(FormatDateTime('hh:mm', dmPromotions.RolloverTime)) + ',' +
         QuotedStr(FormatDateTime('hh:mm', IncMinute(dmPromotions.RolloverTime, -1))) + ')';
    dmPromotions.SafeExecSQL;
  end;

  dtStartDate.Date := Trunc(now);
  dtEndDate.Date := Trunc(now);
  dtEndDate.Format := GetBlankDateTimePicker;  // set EndDate TDateTimePicker to blank

  cbCanIncreasePrice.Checked := True;
end;

procedure TPromotionWizard.btActivateAllPromotionsClick(Sender: TObject);
begin
  with dbgPromotionActions do
  begin
    with DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Activate').AsBoolean := true;
        Post;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;
  dbgPromotionActions.SetFocus;
end;

procedure TPromotionWizard.btActivateNoPromotionsClick(Sender: TObject);
begin
  with dbgPromotionActions do
  begin
    with DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Activate').AsBoolean := false;
        Post;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;
  dbgPromotionActions.SetFocus;
end;

procedure TPromotionWizard.cbPromotionTypeChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = PromoType_EnhancedBOGOF then
    promoTypeIndex := PromoType_BOGOF
  else
    promoTypeIndex := TComboBox(Sender).ItemIndex;

  cbEventOnly.Enabled := promoTypeIndex <> PromoType_EventPricing;
  cbHideFromCustomer.Enabled := not(dmPromotions.NARVatEnabled) and (promoTypeIndex <> PromoType_EventPricing);
  cbValidWithAllPaymentMethods.Enabled := (promoTypeIndex <> PromoType_EventPricing);
  cbValidWithAllDiscounts.Enabled := (promoTypeIndex <> PromoType_EventPricing);
  pnlValidWithAllPaymentMethods.ShowHint := not cbValidWithAllPaymentMethods.Enabled;
  cbFavourCustomer.Enabled := cbEventOnly.Enabled;
  if not cbEventOnly.Enabled then
    cbEventOnly.Checked := False;
  if not cbHideFromCustomer.Enabled then
    cbHideFromCustomer.Checked := False;
  if not cbFavourCustomer.Enabled then
    cbFavourCustomer.ItemIndex := 1;
  if not cbValidWithAllPaymentMethods.Enabled then
    cbValidWithAllPaymentMethods.Checked := False;
  if not cbValidWithAllDiscounts.Enabled then
    cbValidWithAllDiscounts.Checked := False;

  if promoTypeIndex = PromoType_EventPricing then
     storeDisabledSwipeCardValues(cbValidation.ItemIndex, cbSwipeCardGroup.ItemIndex, cbVerification.ItemIndex)
  else
     restoreDisabledSwipeCardValues(TComboBox(Sender));

  cbVerification.Enabled :=  promoTypeIndex <> PromoType_EventPricing;
  cbSwipeCardGroup.Enabled := (promoTypeIndex <> PromoType_EventPricing) and (cbVerification.ItemIndex <> 0);
  cbValidation.Enabled := (promoTypeIndex <> PromoType_EventPricing) and (cbVerification.ItemIndex <> 0);
  DataModified.GroupPriceSettingsRefreshRequired := TRUE;
end;

procedure TPromotionWizard.storeDisabledSwipeCardValues(nValidation, nSwipeCardGroup, nVerification : integer);
begin
  itemValidation := nValidation;
  itemSwipeGroup := nSwipeCardGroup;
  itemVerification := nVerification;

  cbValidation.ItemIndex := 0;
  cbVerification.ItemIndex := 0;
  cbSwipeCardGroup.ItemIndex := 0;
end;

procedure TPromotionWizard.restoreDisabledSwipeCardValues(Sender: TObject);
begin
  cbVerification.ItemIndex := itemVerification;
  cbValidation.ItemIndex := itemValidation;
  cbSwipeCardGroup.ItemIndex := itemSwipeGroup;
end;

//Check that the products in the selected node of the source product tree do not already exist in
//any of the product groups, excluding the currently selected one - given by SelectTargetIndex.
procedure TPromotionWizard.CheckEventGroupSelection(SelectTargetIndex: integer; SelectAll: boolean);
var
  i: integer;
  SavedCursorState: TCursor;
begin
  SavedCursorState := Screen.Cursor;
  with Screen do Cursor := crHourGlass;

  try
    if SelectAll then
    begin
      for i := Low(ProductSelectionTrees) to High(ProductSelectionTrees) do
      begin
        if TTreeView(ProductSelectionTrees[i]).Items.Count > 0 then
          raise Exception.Create('This item is already selected in another group');
      end;
    end
    else
    begin
      if not assigned(tvAvailableProducts.Selected) then
        exit;

      for i := Low(ProductSelectionTrees) to High(ProductSelectionTrees) do
      begin
        if i <> SelectTargetIndex then
          if ProductDataTree.TargetTreeContainsSelectedNodeLeafItems(TTreeView(ProductSelectionTrees[i])) then
            raise Exception.Create('This item is already selected in another group');
      end;
    end;
  finally
    with Screen do Cursor := SavedCursorState;
  end;
end;


procedure TPromotionWizard.SaveProductGroupSelection;
var
  i: integer;
begin
  for i := 0 to Pred(ProductGroupCount) do
    if DataModified.ProductGroupSelection[i] then
    begin
      ProcessProductGroupSelection(i+1, ProductDataTree.SaveToTempTable(ProductSelectionTrees[i]));
      DataModified.ProductGroupSelection[i] := False;
      DataModified.PriceCalculationRequired := True;
    end;
end;

procedure TPromotionWizard.SearchTermEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TPromotionWizard.SearchTermExit(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) = 0 then
  begin
    TEdit(Sender).Tag := 1;
    TEdit(Sender).Font.Color := clGrayText;
    TEdit(Sender).Text := '<Type keywords to search>';
  end;
end;



procedure TPromotionWizard.ProductTreeFindUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Length(ProductSearchTerm) <> 0;
end;

procedure TPromotionWizard.ProductTreeFindPrevExecute(Sender: TObject);
begin
  with ProductDataTree do
  begin
    if ProductSearchTermChanged then
    begin
      ProductSearchTermChanged := false;
      FindNodes(ProductSearchTerm, '##ProductTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableProducts.SetFocus;
end;

procedure TPromotionWizard.ProductTreeFindNextExecute(Sender: TObject);
begin
  with ProductDataTree do
  begin
    if ProductSearchTermChanged then
    begin
      ProductSearchTermChanged := false;
      FindNodes(ProductSearchTerm, '##ProductTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableProducts.SetFocus;
end;

procedure TPromotionWizard.edProductSearchTermChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if ProductSearchTerm <> TEdit(Sender).Text then
    begin
      ProductSearchTermChanged := true;
      ProductTreeFindPrev.Enabled := true;
      ProductTreeFindNext.Enabled := true;
      ProductSearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TPromotionWizard.dbgPromoPricesDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  if (EventPricing)
    and (Field.FieldName = 'Price') then
  begin
    if not Field.IsNull and (Field.Value <> Field.DataSet.FieldByName('TariffPrice').Value) then
    with TwwdbGrid(sender) do
    begin
      Canvas.Lock;
      Canvas.Font.Color := clWhite;
      Canvas.TextOut(Rect.Left+1, Rect.top-1, '*');
      Canvas.TextOut(Rect.Left+1, Rect.top, '*');
      Canvas.TextOut(Rect.Left+1, Rect.top+1, '*');
      Canvas.TextOut(Rect.Left+2, Rect.top-1, '*');
      Canvas.TextOut(Rect.Left+2, Rect.top+1, '*');
      Canvas.TextOut(Rect.Left+3, Rect.top-1, '*');
      Canvas.TextOut(Rect.Left+3, Rect.top, '*');
      Canvas.TextOut(Rect.Left+3, Rect.top+1, '*');
      Canvas.Font.Color := clGrayText;
      Canvas.TextOut(Rect.Left+2, Rect.top, '*');
      Canvas.Unlock;
    end;
  end;
end;

procedure TPromotionWizard.dbgrdExceptionsDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
//335424 - AK
//Sets Width of Column to size of longest Exception Title
  if ValidColumnResize then
  begin
    dbgrdExceptions.ColWidths[0] := NameColumnWidth + 8;
    dbgrdExceptions.ColWidths[1] := dbgrdExceptions.Width - dbgrdExceptions.ColWidths[0] - dbgrdExceptions.ColWidths[2] - 20;
    ValidColumnResize := FALSE;
  end;
end;

procedure TPromotionWizard.tsExceptionsShow(Sender: TObject);
begin
  ResizeForNewException;
end;

procedure TPromotionWizard.tsExceptionsResize(Sender: TObject);
begin
  ValidColumnResize := TRUE;
end;

procedure TPromotionWizard.tsDefineGroupsShow(Sender: TObject);
begin
  if dbgPromotionGroups.DataSource.DataSet.FieldByName('RecipeChildrenMode').Visible and
       dbgPromotionGroups.DataSource.DataSet.FieldByName('MakeChildrenFree').Visible  then
    dbgPromotionGroups.ColWidths[2] := dbgPromotionGroups.Width - dbgPromotionGroups.ColWidths[1] -
       dbgPromotionGroups.ColWidths[3] - dbgPromotionGroups.ColWidths[4] - 40
  else
    dbgPromotionGroups.ColWidths[2] := dbgPromotionGroups.Width - dbgPromotionGroups.ColWidths[1] - 35;
end;

procedure TPromotionWizard.ResizeForNewException;
var
  MinNCW,
  MaxNCW:integer;
  id : int64;
begin
//335424 - AK
//Detects size of longest Exception Title
  ValidColumnResize := TRUE;
  MinNCW := dbgrdExceptions.Canvas.TextWidth(StringOfChar('A',5));
  MaxNCW := dbgrdExceptions.Canvas.TextWidth(StringOfChar('A',50));
  NameColumnWidth := 0;
  with TADOQuery.Create(self ) do
  try
    Connection := dmPromotions.AztecConn;
    // 445916 GJG
    if ( ExistingID > 0) then
      id := ExistingID
    else
      id := PromotionID;
    SQl.Append('Select Name from #PromotionException where PromotionID = ' + inttostr(id));
    Open;
    First;
    repeat
      NameColumnWidth := Max(NameColumnWidth,dbgrdExceptions.Canvas.TextWidth(Fields[0].AsString));
      Next;
    until Eof;
  finally
    Free;
  end;
  if NameColumnWidth < MinNCW then
     NameColumnWidth := MinNCW;
  if NameColumnWidth > MaxNCW then
     NameColumnWidth := MaxNCW;
  dbgrdExceptions.Invalidate;
end;

procedure TPromotionWizard.dstValidTimesCalcFields(DataSet: TDataSet);
begin
  dstValidTimesValidDaysDisplay.Value := ValidDaysDisplay(dstValidTimesValidDays.Value);
end;

procedure TPromotionWizard.dstValidTimesAfterScroll(DataSet: TDataSet);
var i: integer;
begin
  for i := 1 to 7 do
    clbValidDays.Checked[i - 1] := Pos(IntToStr(i), dstValidTimesValidDays.Value) <> 0;

  dtStartTime.Time := dstValidTimesStartTime.Value;
  dtEndTime.Time := dstValidTimesEndTime.Value;
end;

procedure TPromotionWizard.dtStartTimeChange(Sender: TObject);
begin
  Log('Promotion Wizard', 'User has changed a start time');

  dstValidTimes.Edit;
  dstValidTimesStartTime.Value := dtStartTime.Time;
  dstValidTimes.Post;
end;

procedure TPromotionWizard.dtEndTimeChange(Sender: TObject);
begin
  Log('Promotion Wizard', 'User has changed an end time');

  dstValidTimes.Edit;
  dstValidTimesEndTime.Value := dtEndTime.Time;
  dstValidTimes.Post;
end;


procedure TPromotionWizard.clbValidDaysClickCheck(Sender: TObject);
begin
  Log('Promotion Wizard', 'User has changed an active day');

  dstValidTimes.Edit;
  dstValidTimesValidDays.Value := ValidDaysStrFromCheckboxes(clbValidDays);
  dstValidTimes.Post;
end;

procedure TPromotionWizard.btnNewTimePeriodClick(Sender: TObject);
begin
  Log('Promotion Wizard', 'User is adding a new time period');

  dstValidTimes.Append;
  dstValidTimesStartTime.Value := StrToDateTime('00:00');
  dstValidTimesEndTime.Value := StrToDateTime('00:00');
  dstValidTimes.Post;
  btnDeleteTimePeriod.Enabled := True;
end;

procedure TPromotionWizard.btnDeleteTimePeriodClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete the current Time Period?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    dstValidTimes.Delete;

  Log('Promotion Wizard', 'User is deleting a time period');

  if dstValidTimes.RecordCount = 1 then
    btnDeleteTimePeriod.Enabled := False;
end;

procedure TPromotionWizard.LogTimePeriods;
var
  clone: TADODataset;
begin
  if not dstValidTimes.Active then
    Exit;

  clone := TADODataset.Create(nil);
  try
    clone.Clone(dstValidTimes);
    clone.First;
    while not clone.Eof do
    begin
      Log('  Time period',
        ValidDaysDisplay(clone.FieldByName('ValidDays').AsString) + ' ' +
        FormatDateTime('hh:mm', clone.FieldByName('StartTime').Value) + ' to ' +
        FormatDateTime('hh:mm', clone.FieldByName('EndTime').Value));
      clone.Next;
    end;
    clone.Close;
  finally
    clone.Free;
  end;

end;

procedure TPromotionWizard.cbHideDisabledPromotionsClick(Sender: TObject);
begin
  dmPromotions.EventPromotionsHideDisabled := cbHideDisabledPromotions.Checked;
end;

procedure TPromotionWizard.cbVerificationChange(Sender: TObject);
begin
  itemVerification := cbVerification.ItemIndex;

  if cbVerification.ItemIndex = 0 then
     storeDisabledSwipeCardValues(cbValidation.ItemIndex, cbSwipeCardGroup.ItemIndex, cbVerification.ItemIndex)
  else
     restoreDisabledSwipeCardValues(TComboBox(Sender));

  cbSwipeCardGroup.Enabled := cbVerification.ItemIndex <> 0;
  cbValidation.Enabled := cbVerification.ItemIndex <> 0;

  cbVerification.ItemIndex := itemVerification;
end;

procedure TPromotionWizard.cbSwipeCardGroupChange(Sender: TObject);
begin
  itemSwipeGroup := cbSwipeCardGroup.ItemIndex;
end;

procedure TPromotionWizard.cbValidationChange(Sender: TObject);
begin
  itemValidation := cbValidation.ItemIndex;
end;

procedure TPromotionWizard.GroupPriceIncDecExecute(Sender: TObject);
begin
  Log('  Review/Edit Price', '+/- button clicked');
  AdjustPrice(dbgPromoPrices,'Price');
end;

procedure TPromotionWizard.RewardPriceIncDecExecute(Sender: TObject);
begin
  Log('  Reward Price', '+/- button clicked');
  AdjustPrice(dbgRewardPrices,'RewardPrice');
end;

procedure TPromotionWizard.AdjustPrice(Grid: TwwDbGrid; Caption: String);
var
  frmPriceIncDec: TfrmPriceIncDec;
begin
  frmPriceIncDec := TfrmPriceIncDec.Create(nil);
  try
    frmPriceIncDec.IncDecPrices(Grid, Caption);
  finally
    frmPriceIncDec.Free;
  end;
end;

procedure TPromotionWizard.dbgPromoPricesMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  //Don't allow selection of records from calculated groups.
  with Grid do
  begin
    if Selecting and (dmPromotions.IsCalculatedGroup(Fields[0].AsInteger)) then
      Accept := False
    else
      Accept := True;
  end;
end;

procedure TPromotionWizard.GroupPriceIncDecUpdate(Sender: TObject);
begin
  GroupPriceIncDec.Enabled := (dbgPromoPrices.SelectedList.Count > 0) and not ReadOnly;
end;

procedure TPromotionWizard.RewardPriceIncDecUpdate(Sender: TObject);
begin
  RewardPriceIncDec.Enabled :=     (dbgRewardPrices.SelectedList.Count > 0)
                               and rbPerSalesAreaRewardPrice.Checked
                               and not ReadOnly;
end;

procedure TPromotionWizard.RewardPriceExportUpdate(Sender: TObject);
begin
  if rbPerSalesAreaRewardPrice.Checked then
    (Sender as TAction).Enabled := True
  else
    (Sender as TAction).Enabled := False;
end;

procedure TPromotionWizard.RewardPriceImportUpdate(Sender: TObject);
begin
  if rbPerSalesAreaRewardPrice.Checked then
    (Sender as TAction).Enabled := True
  else
    (Sender as TAction).Enabled := False;
end;

procedure TPromotionWizard.GroupPriceExportUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled :=  not dmPromotions.IsCalculatedGroup(dmPromotions.qEditPromoPriceSaleGroupID.AsInteger);
end;

procedure TPromotionWizard.GroupPriceImportUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled :=  not dmPromotions.IsCalculatedGroup(dmPromotions.qEditPromoPriceSaleGroupID.AsInteger);
end;

procedure TPromotionWizard.actLoyaltyPromotionExecute(Sender: TObject);
var
  mr: TModalResult;
  chkd: Boolean;
  i: Integer;
begin
  chkd := (Sender as TAction).Checked;

  if chkd then
  begin
    if promoTypeIndex <> PromoType_BOGOF then
    begin
      mr := MessageDlg('Loyalty promotions are compatible only with BOGOF promotion types.'#13#10 +
                       'Do you wish to change the promotion type to BOGOF and continue with this edit? ',
                       mtWarning,
                       [mbYes, mbNO],
                       0);
      if mr = mrYes then
      begin
        cbPromotionType.ItemIndex := PromoType_BOGOF;
        promoTypeIndex := PromoType_BOGOF;
      end
      else begin
        (Sender as tAction).Checked := False;
        Abort;
      end;
    end;
  end
  else
    edtLoyaltyPointsRequired.Text := '';

  cbPromotionType.Enabled := not chkd;
  pnlLoyalty.Enabled := chkd;
  lblLoyaltyPointsRequired.Enabled := chkd;

  gbPromoVerification.Enabled := not chkd;
  for i := 0 to gbPromoVerification.ControlCount - 1 do
  begin
    gbPromoVerification.Controls[i].Enabled := not chkd;
  end;

  if not gbPromoVerification.Enabled then
  begin
    cbVerification.ItemIndex := 0;
    cbSwipeCardGroup.ItemIndex := 0;
    cbValidation.ItemIndex := 0;
  end;
end;

procedure TPromotionWizard.edtLoyaltyPointsRequiredKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not (Key in [#8,'0'..'9', #127]) then
  begin
    Key := #0;
  end;
end;

procedure TPromotionWizard.actAddPortionPriceMappingExecute(
  Sender: TObject);
begin
  Log('  Start Date', DateToStr(dtStartDate.Date));
  AddEditPortionPriceMapping(emInsert);
end;

procedure TPromotionWizard.actEditPortionPriceMappingExecute(
  Sender: TObject);
begin
  AddEditPortionPriceMapping(emEdit);
end;

procedure TPromotionWizard.AddEditPortionPriceMapping(Mode: TEditMode);
var
  AddEditMapping: TfAddPortionPriceMapping;
begin
  AddEditMapping := TfAddPortionPriceMapping.Create(Self);
  try
    //move to somewhere in the form creation
    AddEditMapping.PromotionID := PromotionID;
    AddEditMapping.SiteCode := dmPromotions.SiteCode;
    AddEditMapping.EditMode := Mode;

    if AddEditMapping.ShowModal = mrOK then
    begin
      DataModified.PortionPriceMappingsChanged := True;
    end;
  finally
    AddEditMapping.Free;
  end;
end;

procedure TPromotionWizard.actDeletePortionPriceMappingExecute(Sender: TObject);
var GroupId, PortiontypeId: integer;
begin
  if MessageDlg('Delete this mapping?', mtConfirmation, [mbyes, mbNo], 0) = mrYes then
  begin
    GroupId := dmPromotions.qEditPromoPortionPriceMapping.FieldByName('SaleGroupId').Value;
    PortiontypeId := dmPromotions.qEditPromoPortionPriceMapping.FieldByName('TargetPortionTypeId').Value;

    dmPromotions.qEditPromoPortionPriceMapping.Delete;
    DataModified.PortionPriceMappingsChanged := True;
    DeletePrices(GroupId, PortionTypeID); // Force the promotion prices affected by this deleted mapping to be recalculated
  end;
end;

procedure TPromotionWizard.DeletePrices(GroupId, PortionTypeID : Integer);
begin
  with dmPromotions.adoqRun do
    begin
      SQL.Clear;
      SQL.Text := Format('DELETE #PromotionPrices WHERE SaleGroupID = %d AND PortionTypeId = %d', [GroupID, PortionTypeId]);
      ExecSQL;
    end
end;

procedure TPromotionWizard.actEditPortionPriceMappingUpdate(
  Sender: TObject);
begin
  (Sender as TAction).Enabled := dmPromotions.qEditPromoPortionPriceMapping.RecNo > 0;
end;

procedure TPromotionWizard.actDeletePortionPriceMappingUpdate(
  Sender: TObject);
begin
  (Sender as TAction).Enabled := dmPromotions.qEditPromoPortionPriceMapping.RecNo > 0;
end;

procedure TPromotionWizard.dbgPortionPriceMappingDblClick(Sender: TObject);
begin
  actEditPortionPriceMapping.Execute;
end;

procedure TPromotionWizard.dbgPortionPriceMappingKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key  = VK_INSERT then
    actAddPortionPriceMapping.Execute
  else if key = VK_DELETE then
    actDeletePortionPriceMapping.Execute;
end;

procedure TPromotionWizard.PopulatePortionFilterComboBox;
begin
  with dmpromotions.adoqRun do
  try
    Close;
    SQL.Text := 'SELECT PortionTypeID, PortionTypeName FROM PortionType ORDER BY PortionTypeName';
    Open;
    while not EOF do
    begin
      cmbbxPortion.Items.AddObject(FieldByName('PortionTypeName').AsString, TObject(FieldByName('PortionTypeID').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
  cmbbxPortion.ItemIndex := -1; //IndexOfName('Standard')
end;

procedure TPromotionWizard.cmbbxPortionChange(Sender: TObject);
begin
  if chkbxPortionFilter.Checked then
    ApplyPortionFilter;
end;

procedure TPromotionWizard.chkbxPortionFilterClick(Sender: TObject);
begin
  if chkbxPortionFilter.Checked then
    ApplyPortionFilter
  else
    if CurrentPortionFilterId <> -1 then
    begin
      ProductDataTree.ClearFilter(4);
      CurrentPortionFilterId := -1;
    end;
end;

procedure TPromotionWizard.ApplyPortionFilter;
var SelectedPortionId: integer;
begin
  if cmbbxPortion.ItemIndex = -1 then
    Exit;
    
  SelectedPortionId := Integer(cmbbxPortion.Items.Objects[cmbbxPortion.ItemIndex]);

  if SelectedPortionId <> CurrentPortionFilterId then
  begin
    with dmPromotions.adocRun do
    begin
      CommandText := Format(
        'IF OBJECT_ID(''tempdb..#FilteredPortions'') IS NOT NULL ' +
        '  DELETE #FilteredPortions ' +
        'ELSE ' +
        '  CREATE TABLE #FilteredPortions (Id int PRIMARY KEY) ' +

        'INSERT #FilteredPortions ' +
        'SELECT PortionId FROM Portions ' +
        'WHERE PortionTypeID = %d ' +
        '  AND EntityCode IN (SELECT EntityCode FROM Products WHERE ISNULL(Deleted, ''N'') = ''N'')',
        [SelectedPortionId]);
      Execute;
      ProductDataTree.ApplyFilter(4, '#FilteredPortions');
    end;

    CurrentPortionFilterId := SelectedPortionId;
  end;
end;

procedure TPromotionWizard.tsPromoDetailsShow(Sender: TObject);
begin
  if ReadOnly then
  begin
    DisablePromotionControls(tsPromoDetails);
    HideNonstandardPromoDetailsFields;
  end;
end;

procedure TPromotionWizard.HideNonstandardPromoDetailsFields;
begin
    cbPromotionType.Enabled := False;
    cbFavourCustomer.Enabled := False;
    cbVerification.Enabled := False;
    cbSwipeCardGroup.Enabled := False;
    cbValidation.Enabled := False;
end;

procedure TPromotionWizard.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  SalesAreaDataTree.Free;
  ProductDataTree.Free;
  PromotionActionsSortHelper.Free;
  WizardManager.Free;
  for i := low(ProductGroupPriceMethods) to High(ProductGroupPriceMethods) do
    ProductGroupPriceMethods[i].Free;
end;

procedure TPromotionWizard.GridPriceKeyPress(Sender: TObject; var Key: Char);
var
  CurrText: String;
  HackGrid: TProtectionHackedGrid;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  HackGrid := TProtectionHackedGrid(Sender);
  if not HackGrid.EditorMode then
     exit;
  if (HackGrid.InplaceEditor = nil) then
     exit;

  CurrText := HackGrid.InplaceEditor.EditText;
  DecimalPos := Pos('.',CurrText);
  SelPos := HackGrid.InplaceEditor.SelStart;              
  SelLength := HackGrid.InplaceEditor.SelLength;

  udmPromotions.ValidatePriceKeyPress(Key, CurrText, SelPos, SelLength, DecimalPos);
end;


procedure TPromotionWizard.dbedRewardPriceKeyPress(Sender: TObject;
  var Key: Char);
var
  CurrText: String;
  DBEdit: TDBEdit;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  DBEdit := TDBEdit(Sender);

  CurrText := DBEdit.EditText;
  DecimalPos := Pos('.',CurrText);
  SelPos := DBEdit.SelStart;
  SelLength := DBEdit.SelLength;

  udmPromotions.ValidatePriceKeyPress(Key, CurrText, SelPos, SelLength, DecimalPos);
end;


procedure TPromotionWizard.dbComboRecipeChildrenModeChange(
  Sender: TObject);
begin
  if dbComboRecipeChildrenMode.Value = '' then
    exit;

  case strtoint(dbComboRecipeChildrenMode.Value) of
    0 : dbComboRecipeChildrenMode.Hint := 'Only the Parent Price is used for Promotion calculations.' +
                  #13+ 'Priced Child Items are not included.';
    1 : dbComboRecipeChildrenMode.Hint := '“Family Price” is both the Parent price and any Child item price(s) combined.';
    2 : dbComboRecipeChildrenMode.Hint := '“Family Price” is both the Parent price and any Child item price(s) combined.';
  else ;
     dbComboRecipeChildrenMode.Hint := 'Unknown Value...'
  end;

end;

procedure TPromotionWizard.dbgPromotionGroupsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  
  if (Field.FieldName = 'MakeChildrenFree') then
  begin
    if dmPromotions.qEditPromotionGroups.FieldByName('RecipeChildrenMode').AsInteger = 0 then
    begin
      if Highlight then
      begin
        ABrush.Color := clInactiveCaption;
      end
      else
      begin
        ABrush.Color := clScrollBar;
      end;
    end
    else
    begin
      if Highlight then
      begin
        ABrush.Color := clHighlight;
      end
      else
      begin
        ABrush.Color := clWindow;
      end;
    end;
  end;

end;

procedure TPromotionWizard.dbgPromotionGroupsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  row, col : integer;
  rec : integer;
begin
  inherited;

  if cbPromotionType.ItemIndex = PromoType_EnhancedBOGOF then
  begin
    TCustomDrawGrid(Sender).MouseToCell(X, Y, col, row);
    Dec(row);
    Dec(col);

    if (TwwDBGrid(Sender)).DataLink.Active and (row >= 0) and (col >= 0) then
    begin
      if TwwDBGrid(Sender).Columns[col].FieldName = 'RecipeChildrenMode' then
      begin
        rec := (TwwDBGrid(Sender)).DataLink.ActiveRecord;
        try
          (TwwDBGrid(Sender)).DataLink.ActiveRecord := row;

          case TADOQuery(TwwDBGrid(Sender).DataLink.DataSet).fieldByName(
                                  TwwDBGrid(Sender).Columns[col].FieldName).AsInteger of
            0 : TwwDBGrid(Sender).Hint := 'Only the Parent Price is used for Promotion calculations.' +
                          #13+ 'Priced Child Items are not included.';
            1 : TwwDBGrid(Sender).Hint := '“Family Price” is both the Parent price and any Child item price(s) combined.';
            2 : TwwDBGrid(Sender).Hint := '“Family Price” is both the Parent price and any Child item price(s) combined.';
          else ;
             TwwDBGrid(Sender).Hint := 'Unknown Value...'
          end;
          Application.ActivateHint(Mouse.CursorPos);
        finally
          (TwwDBGrid(Sender)).DataLink.ActiveRecord:= rec;
        end;
      end
      else if TwwDBGrid(Sender).Columns[col].FieldName = 'MakeChildrenFree' then
      begin
        TwwDBGrid(Sender).Hint := 'If enabled, any priced Child items that have been added to a Parent item are free.';
        Application.ActivateHint(Mouse.CursorPos);
      end
      else
        TwwDBGrid(Sender).Hint := '';
    end;
  end;
end;

procedure TPromotionWizard.dtEndDateClick(Sender: TObject);
begin
  dtEndDate.Format := uGlobals.theDateFormat;
end;
// added by Ventsislav Vulchev
// Bug 520201: Promotions "End date" cannot be removed.
procedure TPromotionWizard.dtEndDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    dtEndDate.Format := GetBlankDateTimePicker;
end;

end.


