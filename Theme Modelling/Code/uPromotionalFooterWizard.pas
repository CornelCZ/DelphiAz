unit uPromotionalFooterWizard;

{$R 'WizardBitmaps.res' 'WizardBitmaps.rc'}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, wwdbedit, Wwdbspin, ActnList,
  Spin, uDataTree, Grids, Wwdbigrd, Wwdbgrid, uFooterPreview, DB, wwdblook,
  Wwkeycb, wwDialog, Wwlocate, StrUtils, CheckLst, wwdbdatetimepicker,
  ADODB, DBCtrls, Wwdotdot, Wwdbcomb;

const
  TIMAGE_TAG_ZONAL_Z_BIG = 101;
  TIMAGE_TAG_ZONAL_Z_SMALL = 102;
  UM_INITFOCUS = WM_USER;
  PANE_RESIZE_LEFT_OFFSET = -27;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;

type
  TPromotionData = class(Tobject)
    FPromotionID: Int64;
    FName: String;
    FDescription: String;
    FEnabled: Boolean;
    FFooterID: Integer;
    FOriginalFooterID: Integer;
    FFooterName: String;
    FIsAssigned : boolean;
    FWasAssigned: boolean;
    property IsAssigned : boolean read FIsAssigned write FIsAssigned;
    property WasOriginallyAssigned : boolean read FWasAssigned;
    public
      class function Compare(Data1,Data2: TPromotionData): Integer;
  end;

  TDataModified = packed record
    SalesAreaSelectionChanged: boolean;
    ProductGroupSelection: array of boolean;
    ProductGroupSelectionRationalised: array of boolean;
    ProductLoadRequired: boolean;
  end;

  TWizardDirection = (wdNext, wdBack);

  TWizardMode = (wmOverrideFooter, wmDefineFooter);

  TPromotionalFooterWizard = class(TForm)
    pcFooterWizard: TPageControl;
    tsFooterDetails: TTabSheet;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    pnlLogo: TPanel;
    pnlBottom: TPanel;
    imZonalLogo: TImage;
    lblName: TLabel;
    edtName: TEdit;
    lblDescription: TLabel;
    mmDescription: TMemo;
    gbPrintFrequency: TGroupBox;
    rbAlwaysPrint: TRadioButton;
    rbPrintEveryNth: TRadioButton;
    lblOccurrances: TLabel;
    lblWizardName: TLabel;
    lblWizardDescription: TLabel;
    actlPromotionalFooter: TActionList;
    actNext: TAction;
    actBack: TAction;
    tsSalesAreas: TTabSheet;
    pnlSalesAreaTop: TPanel;
    bvlSelectSites: TBevel;
    imgSelectSites: TImage;
    lblSelectSites: TLabel;
    lblSelectSitesDesc: TLabel;
    cbSeparateFromReceipt: TCheckBox;
    sePrintFrequency: TSpinEdit;
    tvAvailableSA: TTreeView;
    tvSelectedSA: TTreeView;
    edtSASearch: TEdit;
    btnFindPrevSA: TButton;
    btnIncludeSA: TButton;
    btnIncludeAllSA: TButton;
    btnRemoveAllSA: TButton;
    btnRemoveSA: TButton;
    btnFindNextSA: TButton;
    actFindNextSA: TAction;
    actFindPrevSA: TAction;
    actIncludeSA: TAction;
    actRemoveSA: TAction;
    actIncludeAllSA: TAction;
    actRemoveAllSA: TAction;
    lblAvailableSA: TLabel;
    lblSelectedSA: TLabel;
    tsFinish: TTabSheet;
    pnlFinishTop: TPanel;
    imgFinished: TImage;
    lblFinish: TLabel;
    bvlFinished: TBevel;
    lblFinishedMessage: TLabel;
    tsSalesGroupProducts: TTabSheet;
    bvlSelectProducts: TBevel;
    pnlSelectProductsTop: TPanel;
    imgSelectProducts: TImage;
    lblSelectProducts: TLabel;
    lblSelectProductsDesc: TLabel;
    tsSalesGroups: TTabSheet;
    bvlDefineGroups: TBevel;
    pnlDefineGroupsTop: TPanel;
    imgDefineGroups: TImage;
    lblDefineGroups: TLabel;
    lblDefineGroupsDesc: TLabel;
    lblSaleGroups: TLabel;
    dbgSaleGroups: TwwDBGrid;
    tsFooterText: TTabSheet;
    pnlFooterTextTop: TPanel;
    imgFooterText: TImage;
    lblFooterText: TLabel;
    lblTextDescription: TLabel;
    dbgFooterText: TwwDBGrid;
    btnShowPreview: TButton;
    actShowPreview: TAction;
    luSaleGroupType: TwwDBLookupCombo;
    Label11: TLabel;
    lbSelectedProducts: TLabel;
    btnExcludeAllProducts: TButton;
    btnExcludeProduct: TButton;
    btnIncludeProduct: TButton;
    btnIncludeAllProducts: TButton;
    tvAvailableProducts: TTreeView;
    tcSalesGroupProducts: TTabControl;
    btProductFindNext: TButton;
    btProductFindPrev: TButton;
    edtProductSearchTerm: TEdit;
    actIncludeProduct: TAction;
    actRemoveProduct: TAction;
    actIncludeAllProducts: TAction;
    actRemoveAllProducts: TAction;
    actFindNextProduct: TAction;
    actFindPrevProduct: TAction;
    tsFooterBarcode: TTabSheet;
    bvlSelectBarcode: TBevel;
    pnlSelectBarcodeTop: TPanel;
    imgSelectBarcode: TImage;
    lblSelectBarcode: TLabel;
    lblSelectBarcodeDesc: TLabel;
    lblBarcode: TLabel;
    gbProductBarcodes: TGroupBox;
    dbgProductBarcodes: TwwDBGrid;
    btnUseProductBarcode: TButton;
    edtProductBarcodeSearch: TEdit;
    wwldProductBarcodeSearch: TwwLocateDialog;
    btnSearchPrev: TButton;
    btnSearchNext: TButton;
    actFindNextProductBarcode: TAction;
    actFindPrevProductBarcode: TAction;
    actUseBarcode: TAction;
    edtBarcode: TEdit;
    lblPOSNotificationText: TLabel;
    tsActivationDetails: TTabSheet;
    bvlActivationDetails: TBevel;
    pnlActivationDetailsTop: TPanel;
    imgActivationDetails: TImage;
    lblActivationDetails: TLabel;
    lblActivationDetailsDesc: TLabel;
    bvlFooterText: TBevel;
    lblStartDate: TLabel;
    lblEndDate: TLabel;
    dtStartDate: TwwDBDateTimePicker;
    dtEndDate: TwwDBDateTimePicker;
    chkbxAllTimes: TCheckBox;
    gbxActiveTimes: TGroupBox;
    btnNewTimePeriod: TButton;
    btnDeleteTimePeriod: TButton;
    pnlTimePeriodEdit: TPanel;
    lblDaysActive: TLabel;
    lblStartTime: TLabel;
    lblEndTime: TLabel;
    dtStartTime: TDateTimePicker;
    dtEndTime: TDateTimePicker;
    clbValidDays: TCheckListBox;
    dbgridValidTimes: TwwDBGrid;
    qValidTimes: TADOQuery;
    qValidTimesDisplayOrder: TAutoIncField;
    qValidTimesValidDays: TStringField;
    qValidTimesStartTime: TDateTimeField;
    qValidTimesEndTime: TDateTimeField;
    qValidTimesValidDaysDisplay: TStringField;
    dsValidTimes: TDataSource;
    tsPromotionTriggers: TTabSheet;
    bvlPromotions: TBevel;
    pnlPromotionsTop: TPanel;
    imgPromotions: TImage;
    lblPromotions: TLabel;
    lblPromotionsDescription: TLabel;
    lblPromotionList: TLabel;
    lblSelectedPromotions: TLabel;
    btnIncludePromotion: TButton;
    btnRemovePromotion: TButton;
    lbAvailablepromotions: TListBox;
    lbSelectedPromotions: TListBox;
    actIncludePromotion: TAction;
    actRemovePromotion: TAction;
    edtSearchPromotions: TEdit;
    btnSearchPrevPromotion: TButton;
    btnSearchNextPromotion: TButton;
    actFindPrevPromotion: TAction;
    actFindNextPromotion: TAction;
    tsSalesAreaTextOverride: TTabSheet;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnORIncludeSA: TButton;
    btnORIncludeAll: TButton;
    btnORRemoveAll: TButton;
    btnORRemoveSA: TButton;
    tvOverrideSA: TTreeView;
    lblORSelectedSA: TLabel;
    tvNonOverrideSA: TTreeView;
    actORIncludeSA: TAction;
    actORRemoveSA: TAction;
    actORIncludeAll: TAction;
    actORRemoveAll: TAction;
    tsFooterOverride: TTabSheet;
    pnlSiteLogo: TPanel;
    imgSiteZonalLogo: TImage;
    lblOverrideWizardName: TLabel;
    lblOverrideWizardDesc: TLabel;
    dbgFooterOverrides: TwwDBGrid;
    Button3: TButton;
    btnDeleteOverride: TButton;
    actDeleteOverride: TAction;
    actAddOverride: TAction;
    lblBarcodeValidation: TLabel;
    bvlSAtextOverride: TBevel;
    edtEPoSNotificationText: TEdit;
    pnlPrintMultipleFooters: TPanel;
    cbPrintMultipleFooters: TCheckBox;
    pnlAddSaleGroup: TPanel;
    btnAddSaleGroup: TButton;
    pnlDeleteSaleGroup: TPanel;
    btnDeleteSaleGroup: TButton;
    actDeleteSalesGroup: TAction;
    actAddSalesGroup: TAction;
    pnlPrintVoucherCode: TPanel;
    edtCampaignID: TEdit;
    lblCampaignID: TLabel;
    cbPrintVoucherCode: TCheckBox;
    actPrintVoucherCode: TAction;
    lblPrintWith: TLabel;
    dblcPrintWith: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure SearchEnter(Sender: TObject);
    procedure SearchExit(Sender: TObject);
    procedure actIncludeSAExecute(Sender: TObject);
    procedure actRemoveSAExecute(Sender: TObject);
    procedure actIncludeAllSAExecute(Sender: TObject);
    procedure actRemoveAllSAExecute(Sender: TObject);
    procedure actFindNextSAExecute(Sender: TObject);
    procedure actFindPrevSAExecute(Sender: TObject);
    procedure edtSASearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgFooterTextFieldChanged(Sender: TObject; Field: TField);
    procedure actShowPreviewExecute(Sender: TObject);
    procedure dbgFooterTextKeyPress(Sender: TObject; var Key: Char);
    procedure tcSalesGroupProductsChange(Sender: TObject);
    procedure actIncludeProductExecute(Sender: TObject);
    procedure actIncludeAllProductsExecute(Sender: TObject);
    procedure actRemoveProductExecute(Sender: TObject);
    procedure actRemoveAllProductsExecute(Sender: TObject);
    procedure edtProductBarcodeSearchChange(Sender: TObject);
    procedure actFindNextProductBarcodeExecute(Sender: TObject);
    procedure actFindPrevProductBarcodeExecute(Sender: TObject);
    procedure actUseBarcodeUpdate(Sender: TObject);
    procedure actUseBarcodeExecute(Sender: TObject);
    procedure chkbxAllTimesClick(Sender: TObject);
    procedure qValidTimesCalcFields(DataSet: TDataSet);
    procedure btnNewTimePeriodClick(Sender: TObject);
    procedure clbValidDaysClickCheck(Sender: TObject);
    procedure btnDeleteTimePeriodClick(Sender: TObject);
    procedure dtStartTimeChange(Sender: TObject);
    procedure dtEndTimeChange(Sender: TObject);
    procedure qValidTimesAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure actIncludePromotionExecute(Sender: TObject);
    procedure PromotionsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure actRemovePromotionExecute(Sender: TObject);
    procedure edtSearchPromotionsChange(Sender: TObject);
    procedure actFindPrevPromotionExecute(Sender: TObject);
    procedure actFindNextPromotionExecute(Sender: TObject);
    procedure actORIncludeSAExecute(Sender: TObject);
    procedure actORRemoveSAExecute(Sender: TObject);
    procedure actORIncludeAllExecute(Sender: TObject);
    procedure actORRemoveAllExecute(Sender: TObject);
    procedure actAddOverrideExecute(Sender: TObject);
    procedure actDeleteOverrideExecute(Sender: TObject);
    procedure dbgProductBarcodesCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure tsSalesAreaTextOverrideResize(Sender: TObject);
    procedure tsPromotionTriggersResize(Sender: TObject);
    procedure tsSalesGroupProductsResize(Sender: TObject);
    procedure tsSalesAreasResize(Sender: TObject);
    procedure actShowPreviewUpdate(Sender: TObject);
    procedure actFindNextProductExecute(Sender: TObject);
    procedure actFindPrevProductExecute(Sender: TObject);
    procedure edtProductSearchTermChange(Sender: TObject);
    procedure actDeleteOverrideUpdate(Sender: TObject);
    procedure tsFooterOverrideShow(Sender: TObject);
    procedure actDeleteSalesGroupUpdate(Sender: TObject);
    procedure actAddSalesGroupUpdate(Sender: TObject);
    procedure actAddSalesGroupExecute(Sender: TObject);
    procedure actDeleteSalesGroupExecute(Sender: TObject);
    procedure sePrintFrequencyKeyPress(Sender: TObject; var Key: Char);
    procedure sePrintFrequencyChange(Sender: TObject);
    procedure edtCampaignIDKeyPress(Sender: TObject; var Key: Char);
    procedure actPrintVoucherCodeUpdate(Sender: TObject);
    procedure cbPrintVoucherCodeClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentPage: integer;
    FPromotionalFooterID: Integer;
    FOverrideID: Integer;
    FExistingID: integer;
    FSalesAreaDataTree: TDataTree;
    FProductDataTree: TDataTree;
    FSASearchTerm: string;
    FSASearchTermChanged: boolean;
    FProductSearchTerm: String;
    FProductSearchTermChanged: boolean;
    FProductBarcodeSearchTerm: string;
    FProductBarcodeSearchTermChanged: boolean;
    FFooterPreview: TFooterPreview;
    FProductSelectionTrees: array of TTreeView;
    FSalesGroupCount: Integer;
    FDataModified: TDataModified;
    FWizardMode: TWizardMode;
    FFooterPreviewConfigured: Boolean;

    procedure OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
    procedure OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
    function FindTab(PageControl: TPageControl; CurrentTabIndex: integer;
      GoForward: boolean): integer;
    procedure MoveToPage(PageIndex: integer);
    procedure UpdateNavigationButtons;
    procedure LoadData;
    procedure SaveData;
    function CheckTextValue(Value, Error: String): Boolean;
    procedure GetSalesAreaSelection(TableName: string);
    procedure ConfigureFooterTextPreview;
    procedure ConfigureFooterTextGrid;
    procedure ProcessProductGroupChange;
    procedure AddSaleGroup(SaleGroupID: integer);
    procedure RemoveSaleGroup(SaleGroupID: integer);
    procedure SetSaleGroupName(SaleGroupID: integer; Name: string);
    procedure ProcessSalesGroupSelection(GroupID: integer;
      TableName: string);
    procedure SaveSalesGroupSelection;
    procedure ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);
    procedure SetActivationDefaults;
    procedure BuildPromotionTriggersList;
    procedure MovePromotion(Source, Target: TListBox);
    function FindPromotion(L, R: Integer; Target: String; Source: TStrings;
      out Index: Integer): Boolean;
    procedure InitialiseTextOverrideTreeViews;
    procedure UpdateTextOverrideTreeViews;
    procedure MoveOverrideNode(FromTreeView, ToTreeView: TTreeView; IsOverride, DeleteFromTree: Boolean);
    procedure MoveAllOverrideNodes(FromTreeView, ToTreeView: TTreeView; IsOverride: Boolean);
    procedure PrepareFooterOverrideEditing;
    procedure AddFooterOverride(OverrideID: Integer);
    Procedure SetupSalesGroupGrid;
    Procedure SetupOverridesGrid;
    function PromotionAssignedToAnotherFooter(Promotion: TPromotionData ): boolean;
    function PromotionAssignedToThisFooter(
      Promotion: TPromotionData): boolean;
    function PromotionOriginallyAssignedToThisFooter(
      Promotion: TPromotionData): boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; WizardMode: TWizardMode); reintroduce;
    class function ShowWizard(APromotionalFooterID, AExistingID: integer; WizardMode: TWizardMode = wmDefineFooter): boolean;
    property PromotionalFooterID: Integer read FPromotionalFooterID write FPromotionalFooterID;
    property ExistingID: Integer read FExistingID write FExistingID;
    property WizardMode: TWizardMode read FWizardMode write FWizardMode;
  end;

var
  PromotionalFooterWizard: TPromotionalFooterWizard;

implementation

uses
  useful, uDMPromotionalFooter, udmThemeData, uAztecLog, uSimplelocalise,
  DateUtils, uADO, Clipbrd;

{$R *.dfm}

class function TPromotionalFooterWizard.ShowWizard(APromotionalFooterID, AExistingID: integer; WizardMode: TWizardMode): boolean;
var
  WizardInstance: TPromotionalFooterWizard;
begin
  Log('Footer Wizard - Creating - Id= ' + inttostr(APromotionalFooterID) + ', ExistingId=' + inttostr(AExistingID));
  dmPromotionalFooter.AwaitPreload;
  WizardInstance := TPromotionalFooterWizard.Create(nil, WizardMode);
  with WizardInstance do
  begin
    PromotionalFooterID := APromotionalFooterID;
    ExistingID := AExistingID;
    PostMessage(Handle, UM_INITFOCUS, 0, 0);
    LoadData;
    InitialiseTextOverrideTreeviews;
    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TPromotionalFooterWizard.FormCreate(Sender: TObject);

  procedure DisableControls(Control: TWinControl);
  var
    i: Integer;
  begin
    for i := 0 to Control.ControlCount - 1 do
    begin
      if Control.Controls[i] is TWinControl then
        if TWinControl(Control.Controls[i]).ControlCount > 0 then
          DisableControls(TWinControl(Control.Controls[i]));
      Control.Controls[i].Enabled := False;
    end;
  end;

var
  i: Integer;
begin
  if (WizardMode = wmOverrideFooter) then
  begin
    tsFooterDetails.Enabled := False;
    tsSalesAreas.Enabled := False;
    tsSalesGroupProducts.Enabled := False;
    tsSalesGroups.Enabled := False;
    tsFooterBarcode.Enabled := False;
    tsActivationDetails.Enabled := False;
    tsPromotionTriggers.Enabled := False;
    tsSalesAreaTextOverride.Enabled := False;
  end
  else begin
    tsFooterOverride.Enabled := False;
  end;

  // Ensure the correct start tab sheet.
  pcFooterWizard.ActivePage := nil;
  for i := 0 to Pred(pcFooterWizard.PageCount) do
    pcFooterWizard.Pages[i].TabVisible := False;
  MoveToPage(FindTab(pcFooterWizard, -1, True));

  //Side/top bar images loaded from compiled resource.
  for i := 0 to Pred(ComponentCount) do
  begin
    if (Components[i] is TImage) then
      case TImage(Components[i]).Tag of
        TIMAGE_TAG_ZONAL_Z_BIG:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk100x100');
        TIMAGE_TAG_ZONAL_Z_SMALL:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
      end;
  end;

    // Initialise sales area selection page
  FSalesAreaDataTree := TDataTree.Create(tvAvailableSA, dmThemeData.AztecConn, '##ConfigTree_Data', ConfigNamesArray, True);
  FSalesAreaDataTree.AddLevel('Company', '');
  FSalesAreaDataTree.AddLevel('Area', '');
  FSalesAreaDataTree.AddLevel('Site', '');
  FSalesAreaDataTree.AddLevel('Sales Area', '');
  FSalesAreaDataTree.Initialise;
  tvSelectedSA.ShowHint := True;
  tvSelectedSA.ReadOnly := True;

  //Initialise the product structure datatree for later use.
  FProductDataTree := TDataTree.Create(tvAvailableProducts, dmThemeData.AztecConn, '##ProductTree_Data', ProductNamesArray);
  FProductDataTree.AddLevel('Division', '');
  FProductDataTree.AddLevel('Category', '');
  FProductDataTree.AddLevel('Subcategory', '');
  FProductDataTree.AddLevel('Product', '');
  FProductDataTree.AddLevel('Portion', '');
  FProductDataTree.Initialise;

  FFooterPreviewConfigured := False;
end;


procedure TPromotionalFooterWizard.ConfigureFooterTextPreview;
var
  pbTop: SmallInt;
begin
  if not FFooterPreviewConfigured then
  begin
    FFooterPreviewConfigured := True;

    FFooterPreview := TFooterPreview.Create(nil);
  //  FFooterPreview.Left := self.Left + self.Width + 20;
  end;

  with dmThemeData.adoqRun do
  try
    SQL.Clear;
    if FWizardMode = wmOverrideFooter then
    begin
      SQL.Add('SELECT LineNumber, [Text], Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode');
      SQL.Add('FROM #SitePromotionalFooterTextOverride');
      SQL.Add('WHERE OverrideID = ' + IntToStr(FOverrideID));
    end
    else
      SQL.Text := 'SELECT * FROM #PromotionalFooterText';
    Open;
    First;
    pbTop := 50;
    while not Eof do
    begin
      FFooterPreview.ConfigurePaintBox(FieldByName('LineNumber').AsInteger, pbTop,
                  FieldByName('Text').AsString, FieldByName('Bold').AsBoolean,
                  FieldByName('DoubleSize').AsBoolean, FieldByName('AppendSurveyCode').AsBoolean,
                  FieldByName('AppendVoucherCode').AsBoolean and cbPrintVoucherCode.Checked);
      pbTop := pbTop + 17;
      Next;
    end;
  finally
    Close;
    SQL.Clear;
  end;

  FFooterPreview.CreateTopAndBottomPaintBoxes;
  dbgFooterText.DataSource.DataSet.Open;
end;


procedure TPromotionalFooterWizard.OnEnterPage(Page: TTabSheet;
  Direction: TWizardDirection);
var
  i: integer;
  Statement: string;
begin
  if Assigned(Page) then
    Log('Footer Wizard - OnEnterPage: ' + Page.Name);
  if (Page = tsFooterDetails) then
  begin
    cbPrintMultipleFooters.Enabled := not (dmPromotionalFooter.qEditFooterSaleGroups.RecordCount > 1);
    pnlPrintMultipleFooters.ShowHint := not cbPrintMultipleFooters.Enabled;
  end
  else if (Page = tsFooterText) then
  begin
    ConfigureFooterTextPreview;

    ConfigureFooterTextGrid;

    if FFooterPreview.IsShowing then
      FFooterPreview.Show
    else
      FFooterPreview.Hide;
  end
  else if Page = tsSalesGroups then
  begin
    SetupSalesGroupGrid;
    //ProcessProductGroupChange;
  end
  else if Page = tsSalesGroupProducts then
  begin
    if FDataModified.ProductLoadRequired then
    begin
      for i := 0 to Pred(FSalesGroupCount) do
      begin
        with dmThemeData.adoqRun do
        begin
          Statement := Format(
            '(select GroupingTypeTargetId '+
            'from #PromotionalFooterSaleGroupDetail a '+
            'where SaleGroupID = %d)',
            [i+1]
          );

          FProductDataTree.LoadFromTempTable(FProductSelectionTrees[i], Statement, 'GroupingTypeTargetID');
        end;
      end;
      FDataModified.ProductLoadRequired := False;
    end;
    if tcSalesGroupProducts.TabIndex = -1 then
    begin
      tcSalesGroupProducts.TabIndex := 0;
      tcSalesGroupProductsChange(tcSalesGroupProducts);
    end;
  end
  else if Page = tsFooterBarcode then
  begin
    dmPromotionalFooter.qProductBarcodes.Active := True;

    dmPromotionalFooter.qProductBarcodes.Locate('Barcode',edtBarcode.Text,[loCaseInsensitive]);
  end
  else if Page = tsPromotionTriggers then
  begin
    BuildPromotionTriggersList;
  end;
end;

procedure TPromotionalFooterWizard.OnLeavePage(Page: TTabSheet;
  Direction: TWizardDirection);
var
  i, ExistingOverrideCount, currRecNo, PrintFrequency: Integer;
  duplicateTimePeriods, BarcodeText, TempSQL: string;
  Description, EPoSNotificationText: String;
  HasZeroSalegroupQuantities: Boolean;
begin
  if Assigned(Page) then
    Log('Footer Wizard OnLeavePage: ' + Page.Name);
  if (Page = tsFooterDetails) and (Direction = wdNext) then
  begin
    if dmPromotionalFooter.qEditPromotionalFooter.State in [dsEdit] then
       dmPromotionalFooter.qEditPromotionalFooter.Post;

    if not CheckTextValue(edtName.Text, 'Please enter a name before continuing') then abort;

    // check for duplicate names
    dmThemeData.adoqRun.SQL.Text :=
      Format('SELECT Name FROM promotionalFooter where Name = %s and ISNULL(Description,'''') = %s and Id <> %d',
      [QuotedStr(edtName.Text), QuotedStr(mmDescription.Lines.Text), FPromotionalFooterId]);

    dmThemeData.adoqRun.Open;
    if (not dmThemeData.adoqRun.Eof) then begin
      MessageDlg(Format('A footer named "%s" (with the same description) already exists.'#13#10+
        'Please enter a unique name and description.', [edtName.Text]), mtError, [mbOK], 0);
      abort;
    end;

    dmThemeData.adoqRun.SQL.Text :=
      Format('SELECT Name FROM PromotionalFooter where Name = %s and Id <> %d',
      [QuotedStr(edtName.Text), FPromotionalFooterId]);

    dmThemeData.adoqRun.Open;
    if (not dmThemeData.adoqRun.Eof) then begin
      MessageDlg(Format ('Footer name "%s" is not unique. '#13#10+
        'Please note this can cause ambiguity in reports, or if these footers are used on the same site.',
        [edtName.Text]), mtWarning, [mbOK], 0);
    end;

    // Save promotion data
    if rbAlwaysPrint.Checked then
      PrintFrequency := 1
    else
      PrintFrequency := sePrintFrequency.Value;

    Description := mmDescription.Text;
    if Description = '' then
      Description := 'null'
    else
      Description := QuotedStr(Description);

    EPoSNotificationText := edtEPoSNotificationText.Text;
    if EPoSNotificationText = '' then
      EPoSNotificationText := 'null'
    else
      EPoSNotificationText := QuotedStr(EPoSNotificationText);

    if cbPrintVoucherCode.Checked and (edtCampaignID.Text = '') then
    begin
      MessageDlg('A voucher code has been requested for this promotional footer, but no campaign ID has been supplied.', mtError, [mbOK], 0);
      Abort;
    end;

    if cbPrintVoucherCode.Checked and (edtCampaignID.Text <> '') then
    begin
      try
        StrToInt(edtCampaignID.Text);
      except
        on EConvertError do
        begin
          MessageDlg(Format('An invalid campaign ID (%s) has been supplied for this promotional footer.'#13#10+
            'The campaign ID must be between %d and %d.', [edtCampaignID.Text, 1, MAXINT]), mtError, [mbOK], 0);
          Abort;
        end;
      end;
    end;

    dmThemeData.adoqRun.SQL.Text :=
      Format('UPDATE #PromotionalFooter SET Name = %s, Description = %s, SeparateFromReceipt = %d, ' +
             'PrintFrequency = %d, EPoSNotificationText = %s, PrintMultipleFooters = %d, ' + // PrintWithSlipType = %d, ' +
             'PrintVoucherCode = %d, CampaignID = %s',
        [QuotedStr(edtName.Text), Description , Integer(cbSeparateFromReceipt.Checked), PrintFrequency, EPosNotificationText,
         Integer(cbPrintMultipleFooters.Checked),
          Integer(cbPrintVoucherCode.Checked), QuotedStr(edtCampaignID.Text)]);
    dmThemeData.adoqRun.ExecSQL;
  end
  else
  if (Page = tsSalesAreas) and (Direction = wdNext) then
  begin
    if tvSelectedSA.Items.Count = 0 then
    begin
      MessageDlg (LocaliseString('Please select a Site/Sales area before continuing.'), mtInformation, [mbOK], 0);
      abort;
    end;
    if FDataModified.SalesAreaSelectionChanged then
    begin
      GetSalesAreaSelection(FSalesAreaDataTree.SaveToTempTable(tvSelectedSA));
      UpdateTextOverrideTreeviews;
      FDataModified.SalesAreaSelectionChanged := False;
    end;
    dmPromotionalFooter.updateMaxSurveyCodeLength;
  end
  else
  if (Page = tsFooterText) then
  begin
    if dbgFooterText.Datasource.Dataset.State in [dsInsert, dsEdit] then
      dbgFooterText.Datasource.Dataset.Post;
    if (Direction = wdNext) then
    begin
      if FWizardMode = wmOverrideFooter then
        TempSQL := 'SELECT COUNT(*) AS LineCount FROM #SitePromotionalFooterTextOverride WHERE ISNULL([Text],'''') <> '''''
      else
        TempSQL := 'SELECT COUNT(*) AS LineCount FROM #PromotionalFooterText WHERE ISNULL([Text],'''') <> ''''';
      dmThemeData.adoqRun.SQL.Text := TempSQL;
      dmThemeData.adoqRun.Open;
      if (dmThemeData.adoqRun.FieldByName('LineCount').Value = 0) then
      begin
        MessageDlg('Please enter at least one text line before continuing.', mtInformation, [mbOK], 0);
        Abort;
      end;
    end;
    if FFooterPreview.Showing then
      FFooterPreview.Hide;
  end
  else
  if (Page = tsSalesGroups) and (Direction = wdNext) then
  begin
    if dmPromotionalFooter.qEditFooterSaleGroups.State = dsEdit then
      dmPromotionalFooter.qEditFooterSaleGroups.Post;

    with dmThemeData.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('select count(*) as NumZeroGroups');
      SQL.Add('from #PromotionalFooterSaleGroup');
      SQL.Add('where Value = 0');
      Open;
      HasZeroSalegroupQuantities := FieldByName('NumZeroGroups').Value > 0;
      Close;
    end;

    {#######################}
    { TODO 1 -oEd Barrett : add relevant quantity/value check later}
    {#######################}
    {with dmThemeData.adoqRun do
    begin
      SQL.Clear;
      SQL.Add ('SELECT * FROM #PromotionalFooterSaleGroup');
      SQL.Add ('WHERE (Quantity is Null) OR (Quantity NOT BETWEEN 1 AND 99999.99)');
      Open;
      if not Eof then
      begin
        MessageDlg ('All sale quantities must be between 1 and 99999.99.', mtInformation, [mbOK], 0);
        abort;
      end;
      Close;
    end;}
    if (dmPromotionalFooter.qEditFooterSaleGroups.RecordCount <> 1) and (cbPrintMultipleFooters.Checked) then
    begin
      MessageDlg('A single Sales Group is required if "Print multiple footers" is enabled.', mtInformation, [mbOK],0);
      Abort;
    end;

    if HasZeroSalegroupQuantities and (cbPrintMultipleFooters.Checked) then
    begin
      MessageDlg('Sales Groups cannot have a value of 0 if "Print multiple footers" is enabled.', mtInformation, [mbOK],0);
      Abort;
    end;

    if dmPromotionalFooter.qEditFooterSaleGroups.RecordCount > 0 then
    begin
      tsSalesGroupProducts.Enabled := True;
      ProcessProductGroupChange
    end
    else
      tsSalesGroupProducts.Enabled := False;
  end
  else
  if (Page = tsSalesGroupProducts) and (Direction = wdNext) then
  begin
    // Check first that we have all the data needed before we save any of it to temp tables
    for i := 0 to Pred(FSalesGroupCount) do
    begin
      if FProductSelectionTrees[i].Items.Count = 0 then
      begin
        MessageDlg ('A minimum of 1 product must be selected for each group.', mtInformation, [mbOK], 0);
        abort;
      end;
    end;
    SaveSalesGroupSelection;
  end
  else if (Page = tsFooterBarcode) and (Direction = wdNext) then
  begin
    if (edtBarcode.Text <> '') and (Length(edtBarCode.Text) <> 12) and not IsNumeric(edtBarcode.Text) then
    begin
      MessageDlg('Please enter a 12-digit barcode or delete the barcode before continuing.', mtInformation, [mbOK], 0);
      edtBarCode.SetFocus;
      Abort;
    end
    else if not IsValidBarcode(edtbarcode.Text) then
    begin
      MessageDlg('Invalid barcode entered.  Please re-enter.', mtInformation, [mbOK], 0);
      edtBarCode.SetFocus;
      Abort;
    end;

    BarcodeText := edtBarcode.Text;
    if BarcodeText = '' then
      BarcodeText := 'null'
    else
      BarcodeText := QuotedStr(BarcodeText);

    dmThemeData.adoqRun.SQL.Text :=
      Format('UPDATE #PromotionalFooter SET Barcode = %s',
        [BarcodeText]);
    dmThemeData.adoqRun.ExecSQL;
  end
  else
  if (Page = tsActivationDetails) and (Direction = wdNext) then
  begin
    with dmPromotionalFooter do
    begin
      if not CheckTextValue (dtStartDate.Text, 'Please enter a value for start date.') then abort;
      if dtEndDate.Text <> '' then
      begin
        if dtStartDate.Date > dtEndDate.Date then
        begin
          MessageDlg ('Please select and end date that is after the start date.', mtInformation, [mbOK], 0);
          abort;
        end;
      end;

      //Check that at least one day has been selected as an active day for the promotion
      if chkbxAllTimes.Checked then
      begin
        if dmPromotionalFooter.ValidDaysStrFromCheckboxes(clbValidDays) = '' then
        begin
          MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
          abort;
        end;
      end
      else
        with qValidTimes do
        begin
          currRecNo := RecNo;
          First;
          while not(Eof) do
          begin
            if qValidTimesValidDays.AsString = '' then
            begin
              MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
              abort;
            end;
            Next;
          end;
          RecNo := currRecNo; //
        end;

      with dmThemeData.adoqRun do
      try
        SQL.Text :=
          'SELECT ValidDays, dbo.fn_TimeFromDateTime(StartTime) AS StartTime, dbo.fn_TimeFromDateTime(EndTime) AS EndTime ' +
          'FROM #PromotionalFooterTimeCycles ' +
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

      dmThemeData.adoqrun.SQL.Text := Format('UPDATE #PromotionalFooter SET StartDate = %s, EndDate = %s', [GetSQLDate(dtStartDate.Date), GetSQLDate(dtEndDate.Date)]);
      dmThemeData.adoqrun.ExecSQL;
    end
  end
  else if Page = tsFooterOverride then
  begin
    with dmThemeData.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('select IsNull(count(*),0) as ExistingOverrideCount');
      SQL.Add('from SitePromotionalFooterOverride');
      SQL.Add('where PromotionalFooterID = ' + IntToStr(FPromotionalFooterID));
      Open;

      ExistingOverrideCount := FieldByName('ExistingOverrideCount').AsInteger;
      Close;
    end;

    FOverrideID := dmPromotionalFooter.qSiteFooterOverride.FieldByName('OverrideID').AsInteger;

    if dmPromotionalFooter.qSiteFooterOverride.State in [dsInsert, dsEdit] then
      dmPromotionalFooter.qSiteFooterOverride.Post;

    if (dmPromotionalFooter.qSiteFooterOverride.RecordCount = 0) then
    begin
      if (ExistingOverrideCount > 1) then
      begin
        tsFooterText.Enabled := False;
        if MessageDlg ('All previous overrides for the chosen footer will now be deleted. Continue?.',
            mtConfirmation, [mbYes, mbNO], 0) = mrNo then
          Abort;
      end
      else if (ExistingOverrideCount = 1) then
      begin
        tsFooterText.Enabled := False;
      end
      else if (ExistingOverrideCount = 0) then
      begin
        MessageDlg ('Please select an override to proceed.',
        mtInformation, [mbOK], 0);
        Abort;
      end;
    end
    else
      PrepareFooterOverrideEditing;
  end;
end;

procedure TPromotionalFooterWizard.MoveToPage(PageIndex: integer);
begin
  FCurrentPage := PageIndex;
  pcFooterWizard.ActivePageIndex := PageIndex;
  if PageIndex = -1 then
  begin
    // Wizard is now finished
    SaveData;
    ModalResult := mrOk;
  end
  else
    UpdateNavigationButtons;
end;

procedure TPromotionalFooterWizard.UpdateNavigationButtons;
var
  PrevTabIndex, NextTabIndex: integer;
begin
  // Find the previous and next tab numbers, tells us what the state of the
  // back and next/finish buttons should be
  PrevTabIndex := FindTab(pcFooterWizard, FCurrentPage, False);
  NextTabIndex := FindTab(pcFooterWizard, FCurrentPage, True);

  if PrevTabIndex <> -1 then
    btnBack.Enabled := True
  else
    btnBack.Enabled := False;

  if NextTabIndex <> -1 then
    btnNext.Caption := 'Next'
  else
    btnNext.Caption := 'Finish';
end;

procedure TPromotionalFooterWizard.btnCloseClick(Sender: TObject);
begin
  Log('Footer Wizard - Close button pressed');
  Close;
end;

procedure TPromotionalFooterWizard.actBackExecute(Sender: TObject);
var
  ActivePageIndex: integer;
begin
  // Save and clear the current active page
  // This is so it can change the available pages and have this
  // affect the FindTab call
  ActivePageIndex := pcFooterWizard.ActivePageIndex;
  dmPromotionalFooter.BeginHourglass;
  try
    OnLeavePage(pcFooterWizard.ActivePage, wdBack);
    pcFooterWizard.ActivePageIndex := -1;
    MoveToPage(FindTab(pcFooterWizard, ActivePageIndex, False));
    // Cheat, as we are not handling the page entry via events
    if Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(pcFooterWizard.ActivePage, wdBack);
  finally
    dmPromotionalFooter.EndHourglass;
  end;
end;

procedure TPromotionalFooterWizard.actNextExecute(Sender: TObject);
var
  ActivePageIndex: integer;
begin
  ActivePageIndex := pcFooterWizard.ActivePageIndex;
  dmPromotionalFooter.BeginHourglass;
  try
    // NB:on leave page needs direction added to it
    OnLeavePage(pcFooterWizard.ActivePage, wdNext);
    // Force TabSheet hide event to fire before the new one shows
    pcFooterWizard.ActivePageIndex := -1;
    MoveToPage(FindTab(pcFooterWizard, ActivePageIndex, True));
    if Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(pcFooterWizard.ActivePage, wdNext);
  finally
    dmPromotionalFooter.EndHourglass;
  end;
end;

function TPromotionalFooterWizard.FindTab(PageControl: TPageControl;
  CurrentTabIndex: integer; GoForward: boolean): integer;
var
  i: integer;
begin
  // Navigate through the page list - pages with enabled set to false
  // are ignored.
  // PageControl has similar functionality but uses the TabVisible property,
  // therefore it is limited to having tabs in use when functioning in a
  // Wizard-like manner. In effect this code replaces the PageControl management
  // of the active page.
  Result := -1;
  if GoForward then
  begin
    for i := CurrentTabIndex+1 to Pred(PageControl.PageCount) do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end
  else
  begin
    for i := CurrentTabIndex-1 downto 0 do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end;
end;

procedure TPromotionalFooterWizard.LoadData;
var savedEventHandler: TNotifyEvent;
    PrintFrequency: Integer;
    LoadSiteDataStr: String;
begin
  Log('Footer Wizard - LoadData - started');

  with dmPromotionalFooter do
  begin
    // Set up form
    dmThemeData.adoqRun.SQL.Text := StringReplace(GetStringResource('LoadPromotionalFooterData', 'TEXT'), '@PromotionalFooterID', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);
    LoadSiteDataStr := '0';
    if FWizardMode = wmOverrideFooter then
      LoadSiteDataStr := '1';
    dmThemeData.adoqRun.SQL.Text := StringReplace(dmThemeData.adoqRun.SQL.Text, '@LoadSiteData', LoadSiteDataStr, [rfReplaceAll, rfIgnoreCase]);

    dmThemeData.SafeExecSQL;

    if ExistingID = -1 then
      SetActivationDefaults;

    if (ExistingID <> -1) and (PromotionalFooterID = -1) then
    begin
      // Footer is being copied. Need to set the IDs in the editing
      // tables to -1
      dmThemeData.adoqRun.SQL.Text := StringReplace(GetStringResource('SetUpCopyFooter', 'TEXT'), '@PromotionID', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);
      dmThemeData.SafeExecSQL;
    end;

    // load GUI with existing values
    if ExistingID <> -1 then
    begin
      dmPromotionalFooter.qEditPromotionalFooter.Open;

      //Promotional Footer details
      edtName.Text := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('Name').AsString;
      mmDescription.Text := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('Description').AsString;
      cbSeparateFromReceipt.Checked := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('SeparateFromReceipt').AsBoolean;
      PrintFrequency := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('PrintFrequency').AsInteger;
      edtBarcode.text := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('Barcode').AsString;
      edtEPoSNotificationText.Text := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('EPoSNotificationText').AsString;
      if PrintFrequency = 1 then
        rbAlwaysPrint.Checked := True
      else begin
        rbPrintEveryNth.Checked := True;
        sePrintFrequency.Value := PrintFrequency;
      end;
      dtStartDate.Date := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('StartDate').AsDateTime;
      dtEndDate.Date := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('EndDate').AsDateTime;
      cbPrintMultipleFooters.Checked := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('PrintMultipleFooters').AsBoolean;
      cbPrintVoucherCode.Checked := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('PrintVoucherCode').AsBoolean;
      edtCampaignID.Text := dmPromotionalFooter.qEditPromotionalFooter.FieldByName('CampaignID').AsString;

      //Sales areas
      FSalesAreaDataTree.LoadFromTempTable(tvSelectedSA, '#PromotionalFooterSalesArea', 'SalesAreaID');

      dmPromotionalFooter.updateMaxSurveyCodeLength;
      ProcessProductGroupChange;
    end;

    qValidTimes.Active := True;
    btnDeleteTimePeriod.Enabled := (qValidTimes.RecordCount > 1);

    //If there is only one time cycle defined on this promotion and it starts at rollover and ends at RollOver - 1 min
    //then check the 'runs at all times' box.
    savedEventHandler := chkbxAllTimes.OnClick;    //Disable this event handler while we set this checkbox state.
    chkbxAllTimes.OnClick := nil;
    if (qValidTimes.RecordCount = 1) and
       SameTime(qValidTimesStartTime.Value, dmThemeData.RolloverTime) and
       SameTime(qValidTimesEndTime.Value, IncMinute(dmThemeData.RolloverTime, -1)) then
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

    dmPromotionalFooter.qEditFooterSaleGroups.Active := True;
    dmPromotionalFooter.qEditPromotionalFooter.Active := True;
    dmPromotionalFooter.qSiteFooterOverride.Active := True;
    dmPromotionalFooter.qSiteFooterTextOverride.Active := True;
    FDataModified.ProductLoadRequired := True;

    if dmPromotionalFooter.qEditFooterSaleGroups.RecordCount > 1 then
      cbPrintMultipleFooters.Enabled := False;
  end;
  Log('Footer Wizard - LoadData - finished');
end;

procedure TPromotionalFooterWizard.SaveData;
var
  i: Integer;
begin
  Log('Footer Wizard - SaveData - started');
  if FWizardMode = wmOverrideFooter then
  begin
    with dmThemeData do
    begin
      adoqRun.SQL.Text := StringReplace(GetStringResource('SiteSavePromotionalFooterData', 'TEXT'), '@PromotionalFooterID', IntToStr(FPromotionalFooterID), [rfReplaceAll, rfIgnoreCase]);
      SafeExecSQL;
    end;
  end
  else begin
    for i := 0 to Pred(FSalesGroupCount) do
    begin
      if (not FDataModified.ProductGroupSelectionRationalised[i]) or FDataModified.ProductGroupSelection[i]  then
      begin
        ProcessSalesGroupSelection(i+1, FProductDataTree.SaveToTempTable(FProductSelectionTrees[i]));
        FDataModified.ProductGroupSelectionRationalised[i] := True;
      end;
    end;

    with dmThemeData do
    begin
      if FPromotionalFooterID = -1 then
      begin
        // Generate new promotion ID and update temporary tables with it
        adoqRun.SQL.Text := StringReplace(GetStringResource('GetUniqueID', 'TEXT'), '@InputTableName', 'PromotionalFooter_repl', [rfReplaceAll, rfIgnoreCase]);
        adoqrun.Open;
        FPromotionalFooterID := TLargeIntField(adoqrun.fieldbyname('Output')).Asinteger;
        adoqrun.Close;
        // Generate initial "priority" for the promotion
        adoqrun.SQL.Text := 'UPDATE #PromotionalFooter SET Priority = (SELECT 1+ISNULL(MAX(Priority), 0) FROM PromotionalFooter)';
        SafeExecSQL;
      end;


      adoqRun.SQL.Text := StringReplace(GetStringResource('SavePromotionalFooterData', 'TEXT'), '@PromotionalFooterID', IntToStr(FPromotionalFooterID), [rfReplaceAll, rfIgnoreCase]);
      SafeExecSQL;

      // Inelegant way to ensure priority is not duplicated when multiple
      // users are running.
      //FixPriorities;
    end;
  end;
  Log('Footer Wizard - SaveData - finished');
end;

procedure TPromotionalFooterWizard.actIncludeSAExecute(Sender: TObject);
begin
  Log('Footer Wizard - Select Sites - Include Sales Area (>) Clicked');
  FSalesAreaDataTree.SelectItem(tvSelectedSA);
  FDataModified.SalesAreaSelectionChanged := True;
end;

procedure TPromotionalFooterWizard.actRemoveSAExecute(Sender: TObject);
begin
  Log('Footer Wizard - Select Sites - Exclude Sales Area (<) Clicked');
  FSalesAreaDataTree.DeselectItem(tvSelectedSA);
  FDataModified.SalesAreaSelectionChanged := True;
end;

procedure TPromotionalFooterWizard.actIncludeAllSAExecute(Sender: TObject);
begin
  Log('Footer Wizard - Select Sites - Include All Sales Areas (>>) Clicked');
  FSalesAreaDataTree.SelectAll(tvSelectedSA);
  FDataModified.SalesAreaSelectionChanged := True;
end;

procedure TPromotionalFooterWizard.actRemoveAllSAExecute(Sender: TObject);
begin
  Log('Footer Wizard - Select Sites - Exclude All Sales Areas (<<) Clicked');
  FSalesAreaDataTree.DeselectAll(tvSelectedSA);
  FDataModified.SalesAreaSelectionChanged := True;
end;

procedure TPromotionalFooterWizard.actFindNextSAExecute(Sender: TObject);
begin
  with FSalesAreaDataTree do
  begin
    if FSASearchTermChanged then
    begin
      FSASearchTermChanged := false;
      FindNodes(FSASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableSA.SetFocus;
end;

procedure TPromotionalFooterWizard.actFindPrevSAExecute(Sender: TObject);
begin
 with FSalesAreaDataTree do
  begin
    if FSASearchTermChanged then
    begin
      FSASearchTermChanged := false;
      FindNodes(FSASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableSA.SetFocus;
end;

procedure TPromotionalFooterWizard.edtSASearchChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if FSASearchTerm <> TEdit(Sender).Text then
    begin
      FSASearchTermChanged := true;
      actFindNextSA.Enabled := true;
      actFindPrevSA.Enabled := true;
      FSASearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TPromotionalFooterWizard.SearchEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TPromotionalFooterWizard.SearchExit(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) = 0 then
  begin
    TEdit(Sender).Tag := 1;
    TEdit(Sender).Font.Color := clGrayText;
    TEdit(Sender).Text := '<Type keywords to search>';
  end;
end;

procedure TPromotionalFooterWizard.GetSalesAreaSelection(TableName: string);
begin
  with dmThemeData.adoqRun do
  try
    SQL.Text := 'delete #PromotionalFooterSalesArea';
    ExecSQL;

    SQL.Text := Format('insert #PromotionalFooterSalesArea (PromotionalFooterID, SalesAreaID) '+
      'select %d, Level4ID from %s ', [FPromotionalFooterID, TableName]);
    ExecSQL;

    SQL.Text := Format('drop table %s', [TableName]);
    ExecSQL;

    SQL.Text := 'SELECT COUNT(*) AS [Count] FROM #PromotionalFooterSalesArea';
    Open;
    Close;
  finally
    Close;
  end;
end;

function TPromotionalFooterWizard.CheckTextValue (Value : String; Error : String) : Boolean;
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

procedure TPromotionalFooterWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Footer Wizard - Form Close');
  with dmThemeData do
  begin
    try
      adoqRun.SQL.Text := GetStringResource('DropPromotionalFooterData', 'TEXT');
      adoqrun.ExecSQL;
    except on E:Exception do
      if Pos('cannot drop', LowerCase(E.Message)) = 0 then
        raise;
    end;
  end;
  if FFooterPreviewConfigured then
  begin
    FFooterPreview.Close;
    FFooterPreview.Destroy;
  end;
  dmPromotionalFooter.qSiteFooterOverride.Active := False;
  dmPromotionalFooter.qSiteFooterTextOverride.Active := False;
  dmPromotionalFooter.qEditPromotionalFooter.Active := False;
  dmPromotionalFooter.qEditFooterSaleGroups.Active := False;
  dmPromotionalFooter.qFooterText.Active := False;
end;

procedure TPromotionalFooterWizard.dbgFooterTextFieldChanged(
  Sender: TObject; Field: TField);
var
  ChangedText: String;
  ChangedBold: Boolean;
  ChangedDoubleWidth: Boolean;
  ChangedAppendSurveyCode: Boolean;
  ChangedAppendVoucherCode: Boolean;
  PaintBox: TLocalPaintBox;
begin
  ChangedText := dbgFooterText.Datasource.Dataset.FieldByName('Text').AsString;
  ChangedBold := dbgFooterText.Datasource.Dataset.FieldByName('Bold').AsBoolean;
  ChangedDoubleWidth := dbgFooterText.Datasource.Dataset.FieldByName('DoubleSize').AsBoolean;
  ChangedAppendSurveyCode := dbgFooterText.Datasource.Dataset.FieldByName('AppendSurveyCode').AsBoolean;
  ChangedAppendVoucherCode := dbgFooterText.Datasource.Dataset.FieldByName('AppendVoucherCode').AsBoolean;

  //Field 0 = LineNumber
  PaintBox := FFooterPreview.PaintBox[StrToInt(dbgFooterText.Datasource.Dataset.FieldByName('LineNumber').Value)-1];
  if Assigned(PaintBox) then
    with FFooterPreview.PaintBox[StrToInt(dbgFooterText.Datasource.Dataset.FieldByName('LineNumber').Value)-1] do
    begin
      Text := ChangedText;
      Bold := ChangedBold;
      DoubleWidth := ChangedDoubleWidth;
      AppendSurveyCode := ChangedAppendSurveyCode;
      AppendVoucherCode := ChangedAppendVoucherCode;
      Invalidate;  // Forces repaint
    end;
end;

procedure TPromotionalFooterWizard.actShowPreviewExecute(Sender: TObject);
begin
  if dbgFooterText.DataSource.DataSet.State in [dsEdit] then
    dbgFooterText.DataSource.DataSet.Post;
  ConfigureFooterTextPreview;
  if FFooterPreview.Showing then
  begin
    FFooterPreview.Hide;
    FFooterPreview.IsShowing := FALSE;
    actShowPreview.Caption := 'Show Preview';
  end
  else
  begin
    FFooterPreview.Show;
    FFooterPreview.IsShowing := TRUE;
    actShowPreview.Caption := 'Hide Preview';
  end;
end;

procedure TPromotionalFooterWizard.dbgFooterTextKeyPress(Sender: TObject;
  var Key: Char);

  function isValidNonAlphaChar: Boolean;
  begin
    //Key press is valid, but not alphanumeric
    result :=    (HiWord(GetKeyState(VK_ESCAPE)) <> 0)
              or (HiWord(GetKeyState(VK_BACK)) <> 0)
              or (Key in [^C]);
  end;

var
  CharInsertionCount: Integer;
  Clpbrd: TClipboard;
  ErrorMessage: String;
begin
  if isValidNonAlphaChar then
    Exit;

  if (dbgFooterText.GetActiveField.FieldName = 'Text') then
  begin
    if dbgFooterText.DataSource.DataSet.FieldByName('AppendSurveyCode').AsBoolean then
    begin
      ShowMessage('A survey code is being appended to this line.  Further editing is not possible.');
      Abort;
    end;

    if dbgFooterText.DataSource.DataSet.FieldByName('AppendVoucherCode').AsBoolean then
    begin
      ShowMessage('A voucher code is being appended to this line.  Further editing is not possible.');
      Abort;
    end;

    if dbgFooterText.datasource.DataSet.FieldByName('DoubleSize').AsBoolean then
    with (Sender as TwwDBGrid) do
    begin
      if (InplaceEditor <> nil) then
      begin
        if (key in [^V]) then
        begin
          Clpbrd := Clipboard;
          CharInsertionCount := Length(Clpbrd.Astext);
        end
        else
          CharInsertionCount := 1;

        if ((Length(InplaceEditor.Text) + CharInsertionCount) > 20) then
        begin
          ErrorMessage := 'Only 20 characters can be entered when ''Double Size'' is checked.';
          if (CharInsertionCount > 1) then
            ErrorMessage := ErrorMessage + '  Input would be truncated.';
          ShowMessage(ErrorMessage);
          abort;
        end;
      end;
    end;
  end;
end;


procedure TPromotionalFooterWizard.AddSaleGroup(SaleGroupID: integer);
begin
  SetLength(FProductSelectionTrees, FSaleSGroupCount+1);
  SetLength(FDataModified.ProductGroupSelection, FSalesGroupCount+1);
  SetLength(FDataModified.ProductGroupSelectionRationalised, FSalesGroupCount+1);

  FDataModified.ProductGroupSelection[SaleGroupID-1] := False;
  FDataModified.ProductGroupSelectionRationalised[SaleGroupID-1] := False;
  tcSalesGroupProducts.Tabs.Add('Group '+IntToStr(SaleGroupID));
  FProductSelectionTrees[SaleGroupID-1] := TTreeView.Create(tcSalesGroupProducts);
  FProductSelectionTrees[SaleGroupID-1].Parent := tcSalesGroupProducts;
  FProductSelectionTrees[SaleGroupID-1].Align := alClient;
  FProductSelectionTrees[SaleGroupID-1].HideSelection := False;
  FProductSelectionTrees[SaleGroupID-1].SendToBack;
  FProductSelectionTrees[SaleGroupID-1].BorderStyle := bsNone;
  FProductSelectionTrees[SaleGroupID-1].ShowHint := True;
  FProductSelectionTrees[SaleGroupID-1].ReadOnly := True;

  FSalesGroupCount := FSalesGroupCount + 1;
end;

procedure TPromotionalFooterWizard.RemoveSaleGroup(SaleGroupID: integer);
var
  i: integer;
begin
  FProductSelectionTrees[SaleGroupID-1].Parent := nil;

  FProductSelectionTrees[SaleGroupID-1].Free;

  for i := SaleGroupID to High(FProductSelectionTrees) do
  begin
    tcSalesGroupProducts.Tabs[i] := 'Group '+IntToStr(i);
    FProductSelectionTrees[i-1] := FProductSelectionTrees[i];
  end;
  tcSalesGroupProducts.Tabs.Delete(SaleGroupID-1);

  dmPromotionalFooter.DeleteDataForSaleGroup(SaleGroupID);
  FSalesGroupCount := FSalesGroupCount - 1;

  SetLength(FProductSelectionTrees, FSalesGroupCount);
  SetLength(FDataModified.ProductGroupSelection, FSalesGroupCount);
  SetLength(FDataModified.ProductGroupSelectionRationalised, FSalesGroupCount);
end;

procedure TPromotionalFooterWizard.SetSaleGroupName(SaleGroupID: integer;
  Name: string);
begin
  tcSalesGroupProducts.Tabs[SaleGroupID-1] := StringReplace(Name, '&', '&&', [rfReplaceAll]);
end;

procedure TPromotionalFooterWizard.ProcessProductGroupChange;
var
  NewSaleGroupCount: integer;
  NameStr: string;
  i: integer;
begin
  dmThemeData.adoqRun.SQL.Text := 'SELECT COUNT(*) as GroupCount FROM #PromotionalFooterSaleGroup';
  dmThemeData.adoqRun.Open;
  NewSaleGroupCount := dmThemeData.adoqRun.FieldByName('GroupCount').AsInteger;
  dmThemeData.adoqRun.Close;
  if NewSaleGroupCount <> FSalesGroupCount then
  begin
    // Remove or create tabs for product groups
    if FSalesGroupCount > NewSaleGroupCount then
    begin
      for i := FSalesGroupCount-1 downto NewSaleGroupCount do
      begin
        RemoveSaleGroup(i+1);
      end;
    end;
    for i := FSalesGroupCount to Pred(NewSaleGroupCount) do
    begin
      AddSaleGroup(i+1);
    end;
  end;
  with dmThemeData.adoqrun do
  begin
    SQL.Text := 'select SaleGroupID from #PromotionalFooterSaleGroup';
    Open;
    while not EOF do
    begin
      NameStr := Format('Group %d', [FieldByName('SaleGroupID').AsInteger]);
      SetSaleGroupName(FieldByName('SaleGroupID').AsInteger, NameStr);
      Next;
    end;
  end;
end;

procedure TPromotionalFooterWizard.tcSalesGroupProductsChange(
  Sender: TObject);
var
  i: Integer;
begin
  for i := Low(FProductSelectionTrees) to High(FProductSelectionTrees) do
    FProductSelectionTrees[i].Visible := False;
  FProductSelectionTrees[TTabControl(Sender).TabIndex].Visible := True;
end;

procedure TPromotionalFooterWizard.actIncludeProductExecute(
  Sender: TObject);
begin
  Log(Format('Footer Wizard - Select Products - Include Product (>) Clicked - %s', [tcSalesGroupProducts.Tabs[tcSalesGroupProducts.TabIndex]]));
  FProductDataTree.SelectItem(FProductSelectionTrees[tcSalesGroupProducts.TabIndex]);
  FDataModified.ProductGroupSelection[tcSalesGroupProducts.TabIndex] := True;
end;

procedure TPromotionalFooterWizard.actIncludeAllProductsExecute(
  Sender: TObject);
begin
  Log(Format('Footer Wizard - Select Products - Include All Products (>>) Clicked - %s', [tcSalesGroupProducts.Tabs[tcSalesGroupProducts.TabIndex]]));
  FProductDataTree.SelectAll(FProductSelectionTrees[tcSalesGroupProducts.TabIndex]);
  FDataModified.ProductGroupSelection[tcSalesGroupProducts.TabIndex] := True;
end;

procedure TPromotionalFooterWizard.actRemoveProductExecute(
  Sender: TObject);
begin
  Log(Format('Footer Wizard - Select Products - Exclude Product (<) Clicked - %s', [tcSalesGroupProducts.Tabs[tcSalesGroupProducts.TabIndex]]));
  FProductDataTree.DeSelectItem(FProductSelectionTrees[tcSalesGroupProducts.TabIndex]);
  FDataModified.ProductGroupSelection[tcSalesGroupProducts.TabIndex] := True;
end;

procedure TPromotionalFooterWizard.actRemoveAllProductsExecute(
  Sender: TObject);
begin
  Log(Format('Footer Wizard - Select Products - Exclude All Products (<<) Clicked - %s', [tcSalesGroupProducts.Tabs[tcSalesGroupProducts.TabIndex]]));
  FProductDataTree.DeSelectAll(FProductSelectionTrees[tcSalesGroupProducts.TabIndex]);
  FDataModified.ProductGroupSelection[tcSalesGroupProducts.TabIndex] := True;
end;

procedure TPromotionalFooterWizard.SaveSalesGroupSelection;
var
  i: integer;
begin
  for i := 0 to Pred(FSalesGroupCount) do
  begin
    if FDataModified.ProductGroupSelection[i] then
    begin
      ProcessSalesGroupSelection(i+1, FProductDataTree.SaveToTempTable(FProductSelectionTrees[i]));
      FDataModified.ProductGroupSelection[i] := False;
      FDataModified.ProductGroupSelectionRationalised[i] := True;
    end;
  end;
end;

procedure TPromotionalFooterWizard.ProcessSalesGroupSelection(GroupID: integer; TableName: string);
var
  QueryText: String;
begin
  QueryText := GetStringResource('ProcessSaleGroupDetail', 'TEXT');
  QueryText := StringReplace(QueryText,'%SaleGroupId%',InttoStr(GroupId),[rfReplaceAll, rfIgnoreCase]);
  QueryText := StringReplace(QueryText,'%PromotionalFooterId%',InttoStr(FPromotionalFooterID),[rfReplaceAll, rfIgnoreCase]);
  QueryText := StringReplace(QueryText,'%temptable%',TableName,[rfReplaceAll, rfIgnoreCase]);
  dmPromotionalFooter.qProcessSaleGroupDetail.SQL.Text := QueryText;
  dmPromotionalFooter.qProcessSaleGroupDetail.ExecSQL;
end;

procedure TPromotionalFooterWizard.edtProductBarcodeSearchChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if FProductBarcodeSearchTerm <> TEdit(Sender).Text then
    begin
      FproductBarcodeSearchTermChanged := true;
      actFindNextProductBarcode.Enabled := true;
      actFindPrevProductBarcode.Enabled := true;
      FProductBarcodeSearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TPromotionalFooterWizard.actFindNextProductBarcodeExecute(
  Sender: TObject);
begin
  wwldProductBarcodeSearch.FieldValue := edtProductBarcodeSearch.Text;

  if wwldProductBarcodeSearch.FieldValue = '' then
    exit;
  wwldProductBarcodeSearch.FindNext;
end;

procedure TPromotionalFooterWizard.actFindPrevProductBarcodeExecute(
  Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
begin
  wwldProductBarcodeSearch.FieldValue := edtProductBarcodeSearch.Text;

  if wwldProductBarcodeSearch.FieldValue = '' then
    exit;

  // find prior has to be done programatically...
  with dmPromotionalFooter.qProductBarcodes do
  begin
    disablecontrols;
    { get a bookmark so that we can return to the same record }
    SavePlace := GetBookmark;
    try
      matchyes := false;
      while (not bof) do
      begin
        Prior;
        matchyes := AnsiContainsText(FieldByName('Extended RTL Name').asstring,edtProductBarcodeSearch.Text);
        if matchyes then break;
      end;

      {if match not found Move back to the bookmark}
      if not matchyes then
      begin
        GotoBookmark(SavePlace);
        MessageDlg('No more matches found',mtInformation,[mbOK],0);
      end;
      { Free the bookmark }
    finally
      FreeBookmark(SavePlace);
    end;
    enablecontrols;
  end;
end;

procedure TPromotionalFooterWizard.actUseBarcodeUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled :=
    not (dmPromotionalFooter.qProductBarcodes.Eof and dmPromotionalFooter.qProductBarcodes.Bof)
    and dmPromotionalFooter.qProductBarcodes.FieldByName('CanSelect').AsBoolean;
end;

procedure TPromotionalFooterWizard.actUseBarcodeExecute(Sender: TObject);
begin
  edtBarcode.Text := dmPromotionalFooter.qProductBarcodes.FieldbyName('Barcode').AsString;
end;

procedure TPromotionalFooterWizard.chkbxAllTimesClick(Sender: TObject);
begin
  if chkbxAllTimes.Checked then
  begin
    //Save current active time settings so can restore them if the "runs at all times" checkbox in unchecked,
    //and insert a rollover to rollover record instead.
    qValidTimes.DisableControls;
    qValidTimes.Active := False;
    dmThemeData.adoqrun.SQL.Text :=
      'TRUNCATE TABLE #PromotionalFooterTimeCycles_saved ' +
      'INSERT #PromotionalFooterTimeCycles_saved SELECT * FROM #PromotionalFooterTimeCycles ' +

      'TRUNCATE TABLE #PromotionalFooterTimeCycles ' +
      'INSERT #PromotionalFooterTimeCycles (ValidDays, StartTime, EndTime) ' +
      'VALUES (' + QuotedStr(dmPromotionalFooter.ValidDaysStrFromCheckboxes(clbValidDays)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', dmThemeData.RolloverTime)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', IncMinute(dmThemeData.RolloverTime, -1))) + ')';
    dmThemeData.SafeExecSQL;
    qValidTimes.Active := True;
    qValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(True);

  end
  else
  begin
    //Restore any active time settings that were saved when the user checked the "runs at all times" checkbox.
    qValidTimes.DisableControls;
    qValidTimes.Active := False;
    dmThemeData.adoqrun.SQL.Text :=
      'IF EXISTS(SELECT * FROM #PromotionalFooterTimeCycles_saved) '+
      'BEGIN '+
      '  SET IDENTITY_INSERT #PromotionalFooterTimeCycles ON '+

      '  TRUNCATE TABLE #PromotionalFooterTimeCycles ' +
      '  INSERT #PromotionalFooterTimeCycles (DisplayOrder, ValidDays, StartTime, EndTime) '+
      '  SELECT * FROM #PromotionalFooterTimeCycles_saved ' +

      '  SET IDENTITY_INSERT #PromotionalFooterTimeCycles OFF '+
      'END';
    dmThemeData.SafeExecSQL;
    qValidTimes.Active := True;
    qValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(False);
  end;
end;

procedure TPromotionalFooterWizard.ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);
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

procedure TPromotionalFooterWizard.qValidTimesCalcFields(
  DataSet: TDataSet);
begin
  qValidTimesValidDaysDisplay.Value := dmPromotionalFooter.ValidDaysDisplay(qValidTimesValidDays.Value);
end;

procedure TPromotionalFooterWizard.dtEndTimeChange(Sender: TObject);
begin
  qValidTimes.Edit;
  qValidTimesEndTime.Value := dtEndTime.Time;
  qValidTimes.Post;
end;

procedure TPromotionalFooterWizard.clbValidDaysClickCheck(Sender: TObject);
begin
  qValidTimes.Edit;
  qValidTimesValidDays.Value := dmPromotionalFooter.ValidDaysStrFromCheckboxes(clbValidDays);
  qValidTimes.Post;
end;

procedure TPromotionalFooterWizard.btnNewTimePeriodClick(Sender: TObject);
begin
  qValidTimes.Append;
  qValidTimesStartTime.Value := StrToDateTime('00:00');
  qValidTimesEndTime.Value := StrToDateTime('00:00');
  qValidTimes.Post;
  btnDeleteTimePeriod.Enabled := True;
end;

procedure TPromotionalFooterWizard.btnDeleteTimePeriodClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete the current Time Period?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    qValidTimes.Delete;

  if qValidTimes.RecordCount = 1 then
    btnDeleteTimePeriod.Enabled := False;
end;

procedure TPromotionalFooterWizard.dtStartTimeChange(Sender: TObject);
begin
  qValidTimes.Edit;
  qValidTimesStartTime.Value := dtStartTime.Time;
  qValidTimes.Post;
end;

procedure TPromotionalFooterWizard.qValidTimesAfterScroll(
  DataSet: TDataSet);
var
  i: integer;
begin
  for i := 1 to 7 do
    clbValidDays.Checked[i - 1] := Pos(IntToStr(i), qValidTimesValidDays.Value) <> 0;

  dtStartTime.Time := qValidTimesStartTime.Value;
  dtEndTime.Time := qValidTimesEndTime.Value;
end;

procedure TPromotionalFooterWizard.SetActivationDefaults;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text :=
      'TRUNCATE TABLE #PromotionalFooterTimeCycles ' +

      'INSERT #PromotionalFooterTimeCycles (ValidDays, StartTime, EndTime) ' +
      'VALUES (' +
         '''1234567'', ' +
         QuotedStr(FormatDateTime('hh:mm', dmThemeData.RolloverTime)) + ',' +
         QuotedStr(FormatDateTime('hh:mm', IncMinute(dmThemeData.RolloverTime, -1))) + ')';
    dmThemeData.SafeExecSQL;
  end;

  dtStartDate.Date := Trunc(now);
  dtEndDate.Date := 0.0;
end;

procedure TPromotionalFooterWizard.FormShow(Sender: TObject);
begin
  if (FPromotionalFooterID = -1) and (FExistingID = -1) then
  begin
    lblWizardName.Caption := 'New Footer Wizard';
    lblWizardDescription.Caption := 'This wizard will guide you through the process of setting up a new footer.';
  end
  else
  if (FPromotionalFooterID = -1) and (ExistingID <> -1) then
  begin
    lblWizardName.Caption := 'Copy Footer Wizard';
    lblWizardDescription.Caption := 'This wizard will guide you through the process of setting up a new footer based on an existing one.';
  end
  else
  if (FPromotionalFooterID = ExistingID) then
  begin
    lblWizardName.Caption := 'Edit Footer Wizard';
    lblWizardDescription.Caption := 'This wizard allows you to review and/or edit all parts of the selected footer.';
  end;
  Log('Promotional Footer - FormShow ' + lblWizardName.Caption);
end;

procedure TPromotionalFooterWizard.BuildPromotionTriggersList;
var
  TempPromoData: TPromotionData;
  Index: Integer;
  TempSiteCode: String;
begin
  for Index := 0 to lbAvailablePromotions.Count - 1 do
    TPromotionData(lbAvailablePromotions.Items.Objects[Index]).Free;
  for Index := 0 to lbSelectedPromotions.Count - 1 do
    TPromotionData(lbSelectedPromotions.Items.Objects[Index]).Free;
  lbAvailablePromotions.Clear;
  lbSelectedPromotions.Clear;

  if IsSite and IsMaster then
    TempSiteCode := 'dbo.fnGetSiteCode()'
  else
    TempSiteCode := '0';
    
  with dmThemeData.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('select p.PromotionID, p.Name, p.Description, p.Status, pt.PromotionalFooterId as promotionalFooterId, pt.OriginalPromotionalFooterID as OriginalPromotionalFooterID, pf.Name as PromotionalFooterName');
    SQL.Add('from Promotion p');
    SQL.Add('left join #PromotionalFooterPromotionTriggers pt');
    SQL.Add('on p.PromotionID = pt.PromotionID');
    SQL.Add('left join PromotionalFooter pf');
    SQL.Add('on pt.PromotionalFooterID = pf.ID');
    SQL.Add('where p.SiteCode = ' + TempSiteCode);
    if dmPromotionalFooter.HideDisabledPromotionalFooters then
      SQL.Add('and p.Status = 0');

    Active := True;

    while not EOF do
    begin
      TempPromoData := TPromotionData.Create;
      TempPromoData.FPromotionID := TLargeIntField(FieldByName('PromotionID')).AsLargeInt;
      TempPromoData.FName := FieldByName('Name').AsString;
      TempPromoData.FDescription := FieldByName('Description').AsString;
      TempPromoData.FEnabled := FieldByName('Status').AsInteger = 0;
      if not FieldByName('PromotionalFooterID').IsNull then
        TempPromoData.FFooterID := FieldByName('PromotionalFooterID').AsInteger;
      TempPromoData.IsAssigned := not FieldByName('PromotionalFooterID').IsNull;
      if not FieldByName('OriginalPromotionalFooterID').IsNull then
        TempPromoData.FOriginalFooterID := FieldByName('OriginalPromotionalFooterID').AsInteger;
      TempPromoData.FWasAssigned := not FieldByName('OriginalPromotionalFooterID').IsNull;
      TempPromoData.FFooterName := FieldByName('PromotionalFooterName').AsString;

      if ( PromotionAssignedToThisFooter(TempPromoData) ) then
        lbSelectedPromotions.Items.AddObject(TempPromoData.FName, TempPromoData)
      else
        lbAvailablePromotions.Items.AddObject(TempPromoData.FName, TempPromoData);

      Next;
    end;
  end;
end;

function TPromotionalFooterWizard.PromotionAssignedToAnotherFooter( Promotion : TPromotionData ) : boolean;
begin
  with dmThemeData.adoqRun do
  begin
    sql.Clear;
    sql.Add('select PromotionalFooterID, PromotionID, OriginalPromotionalFooterID ');
    sql.Add('from #PromotionalFooterPromotionTriggers');
    Open;
  end;
  result := (Promotion.FFooterId <> FPromotionalFooterID)
        and ( dmThemeData.adoqRun.Locate('PromotionID',Promotion.FPromotionID,[loCaseInsensitive, loPartialKey]) );
end;

function TPromotionalFooterWizard.PromotionAssignedToThisFooter( Promotion : TPromotionData ) : boolean;
begin
  result := Promotion.FFooterID = FPromotionalFooterID;
end;

function TPromotionalFooterWizard.PromotionOriginallyAssignedToThisFooter( Promotion : TPromotionData ) : boolean;
begin
  result := Promotion.WasOriginallyAssigned AND ( Promotion.FOriginalFooterID = FPromotionalFooterID );
end;

procedure TPromotionalFooterWizard.PromotionsDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  TempData: TPromotionData;
  TextOutput: String;
begin
  with (Control as TListBox).Canvas do
  begin
    TempData := TPromotionData(TListBox(Control).Items.Objects[Index]);

    TextOutput := (Control as TListBox).Items[Index];

    if PromotionAssignedToAnotherFooter( TempData ) then
    begin
      Font.Style := Font.Style + [fsBold];
      //TextOutput := (Control as TListBox).Items[Index] +
      //              ' (Mapped to "' +
      //              TempData.FFooterName +
      //              '")';
    end;

    if not TPromotionData(
      TListBox(Control).Items.Objects[Index]
      ).FEnabled then
    begin
      Font.Color := clGrayText;
      //TextOutput := (Control as TListBox).Items[Index] +
      //              ' (disabled)';
    end;

    FillRect(Rect);
    TextOut(Rect.Left + 2, Rect.Top, TextOutput);
  end;
end;

procedure TPromotionalFooterWizard.actIncludePromotionExecute(
  Sender: TObject);
var
  TempData: TPromotionData;
begin
  if lbAvailablePromotions.ItemIndex <> -1 then
  begin
    TempData := TPromotionData(lbAvailablePromotions.Items.Objects[lbAvailablePromotions.ItemIndex]);

    if  PromotionAssignedToAnotherFooter(TempData) then
    begin
      if MessageDlg(Format('This promotions has already been mapped to a promotional footer '#13#10+
            '"%s" and will be remapped to this promotional footer.  Continue?', [TempData.FFooterName]), mtInformation, [mbYes, mbNo], 0) = mrNo then
      Abort
    end
    else if not TempData.FEnabled then
    begin
      if MessageDlg(Format('This promotion is currently disabled.  Adding this promotion as a trigger may'#13#10+
            'result in the promotional footer not being printed when expected.  Continue?', [TempData.FFooterName]), mtInformation, [mbYes, mbNo], 0) = mrNo then
      Abort
    end;
    MovePromotion(lbAvailablepromotions,lbSelectedPromotions);
  end;
end;

procedure TPromotionalFooterWizard.MovePromotion(Source, Target: TListBox);
var
  TempPromoData: TPromotionData;
begin
  if Source.ItemIndex <> -1 then
  begin
    TempPromoData := TPromotionData(Source.Items.Objects[Source.ItemIndex]);
    if (Source = lbAvailablePromotions) and (not TempPromoData.IsAssigned) then
    begin
      TempPromoData.FFooterID := FPromotionalFooterID;
      TempPromoData.IsAssigned := TRUE;
      with dmThemeData.adoqRun do
      begin
        sql.Clear;
        sql.Add('insert into #PromotionalFooterPromotionTriggers ');
        sql.Add('values (:PromotionalFooterID, :PromotionID, :OriginalPromotionalFooterID)');
        Parameters.ParamByName('PromotionalFooterID').Value := TempPromoData.FFooterID;
        Parameters.ParamByName('PromotionID').Value := TempPromoData.FPromotionID;
        Parameters.ParamByName('OriginalPromotionalFooterID').Value := TempPromoData.FOriginalFooterID;
        ExecSQL;
      end;
    end
    else if (Source = lbAvailablepromotions) then
    begin
      TempPromoData.FFooterID := FPromotionalFooterID;
      TempPromoData.IsAssigned := TRUE;
      with dmThemeData.adoqRun do
      begin
        sql.Clear;
        sql.Add('update #PromotionalFooterPromotionTriggers ');
        sql.Add('set PromotionalFooterID = :PromotionalFooterID ');
        sql.Add('where PromotionID = :PromotionID ');
        Parameters.ParamByName('PromotionalFooterID').Value := FPromotionalFooterID;
        Parameters.ParamByName('PromotionID').Value := TempPromoData.FPromotionID;
        ExecSQL;
      end;
    end
    else if (Source = lbSelectedPromotions) and
        (TempPromoData.WasOriginallyAssigned) and (not PromotionOriginallyAssignedToThisFooter(TempPromoData))then
    begin
      TempPromoData.FFooterID := TempPromoData.FOriginalFooterID;
      TempPromoData.IsAssigned := TRUE;
      with dmThemeData.adoqRun do
      begin
        sql.Clear;
        sql.Add('update #PromotionalFooterPromotionTriggers ');
        sql.Add('set PromotionalFooterID = OriginalPromotionalFooterID ');
        sql.Add('where PromotionID = :PromotionID ');
        Parameters.ParamByName('PromotionID').Value := TempPromoData.FPromotionID ;
        ExecSQL;
      end;
    end
    else if (Source = lbSelectedPromotions) and (PromotionAssignedToThisFooter( TempPromoData )) then
    begin
      TempPromoData.FFooterID := 0;
      TempPromoData.IsAssigned := FALSE;
      with dmThemeData.adoqRun do
      begin
        sql.Clear;
        sql.Add('delete #PromotionalFooterPromotionTriggers ');
        sql.Add('where PromotionID = ' + IntToStr(TempPromoData.FPromotionID));
        ExecSQL;
      end;
    end;
    Target.Items.AddObject(TempPromoData.FName, TempPromoData);
    Source.Items.Delete(Source.ItemIndex);
  end;
end;

procedure TPromotionalFooterWizard.actRemovePromotionExecute(
  Sender: TObject);
begin
  MovePromotion(lbSelectedPromotions, lbAvailablepromotions);
end;

{ TPromotionData }

class function TPromotionData.Compare(Data1,
  Data2: TPromotionData): Integer;
begin
  Result := AnsiCompareText(Data1.FName,Data2.FName);
end;

procedure TPromotionalFooterWizard.edtSearchPromotionsChange(
  Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if FProductBarcodeSearchTerm <> TEdit(Sender).Text then
    begin
      FproductBarcodeSearchTermChanged := true;
      actFindNextSA.Enabled := true;
      actFindPrevSA.Enabled := true;
      FProductBarcodeSearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TPromotionalFooterWizard.actFindPrevPromotionExecute(
  Sender: TObject);
var
  Index: Integer;
  Start: Integer;
begin
  if lbAvailablepromotions.ItemIndex = -1 then
    Start := lbAvailablepromotions.Count - 1
  else
    Start := lbAvailablepromotions.ItemIndex -1;
  if FindPromotion(Start, 0, edtSearchPromotions.Text, lbAvailablepromotions.Items, Index) then
    lbAvailablePromotions.ItemIndex := Index
  else
    MessageDlg('No more matches found',mtInformation,[mbOK],0);
end;

procedure TPromotionalFooterWizard.actFindNextPromotionExecute(
  Sender: TObject);
var
  Index: Integer;
begin
  if FindPromotion(lbAvailablePromotions.ItemIndex + 1, lbAvailablepromotions.Items.Count - 1, edtSearchPromotions.Text, lbAvailablepromotions.Items, Index) then
    lbAvailablePromotions.ItemIndex := Index
  else
    MessageDlg('No more matches found',mtInformation,[mbOK],0);
end;

function TPromotionalFooterWizard.FindPromotion(L, R: Integer; Target: String; Source: TStrings; out Index: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if   ((L < 0) or (L > Source.Count - 1))
    or ((R < 0) or (R > Source.Count - 1)) then
    Result := False
  else if L < R then
  begin
    for i := L to R do
    begin
      if AnsiContainsText(Source[i], Target) then
      begin
        Result := True;
        Index := i;
        Break;
      end;
    end;
  end
  else begin
    for i := L downto R do
    begin
      if AnsiContainsText(Source[i], Target) then
      begin
        Result := True;
        Index := i;
        Break;
      end;
    end;
  end;
end;



procedure TPromotionalFooterWizard.InitialiseTextOverrideTreeviews;
var
  siteQry, saQry: TADOQuery;
  siteNode: TTreeNode;
  saNode: TTreeNode;

  procedure AddOverrideNodes(IsOverride: Boolean);
  begin
    siteQry.SQL.Text :=
      'SELECT DISTINCT a.SiteID, s.Name as SiteName ' +
      'FROM #PromotionalFooterSalesArea p  ' +
      'join ac_salesArea a on p.SalesAreaID = a.id ' +
      'join ac_pos t on t.SalesAreaID = a.id ' +
      'join ac_site s on a.SiteID = s.ID ';
    if IsOverride then
      siteQry.SQL.Add('where p.AllowSiteFooterOverride = 1 ')
    else
      siteQry.SQL.Add('where p.AllowSiteFooterOverride = 0 ');
    siteQry.Open;
    siteQry.First;
    while not siteQry.Eof do
    begin
      if IsOverride then
        siteNode := tvOverrideSA.Items.Add(nil, siteQry.FieldByName('SiteName').AsString)
      else
        siteNode := tvNonOverrideSA.Items.Add(nil, siteQry.FieldByName('SiteName').AsString);
      siteNode.Data := TObject(siteQry.FieldByName('SiteID').AsInteger);
      saQry.SQL.Text :=
        'SELECT DISTINCT a.ID, a.Name as SalesArea ' +
        'FROM #PromotionalFooterSalesArea p ' +
        'join ac_salesArea a on p.SalesAreaID = a.ID ' +
        'join ac_pos t on t.SalesAreaID = a.ID ' +
        'where a.SiteID =  ' + IntToStr(siteQry.FieldByName('SiteID').AsInteger) + ' ';
      if IsOverride then
        saQry.SQL.Add('and p.AllowSiteFooterOverride = 1 ')
      else
        saQry.SQL.Add('and p.AllowSiteFooterOverride = 0 ');
      saQry.Open;
      saQry.First;
      while not saQry.Eof do
      begin
        if IsOverride then
          saNode := tvOverrideSA.Items.AddChild(siteNode, saQry.FieldByName('SalesArea').AsString)
        else
          saNode := tvNonOverrideSA.Items.AddChild(siteNode, saQry.FieldByName('SalesArea').AsString);
        saNode.Data := TObject(saQry.FieldByName('ID').AsInteger);
        saQry.Next;
      end;
      saQry.Close;
      siteQry.Next;
    end;
  end;

begin
  siteQry := TADOQuery.Create(nil);
  saQry := TADOQuery.Create(nil);

  with siteQry do
  try
    siteQry.Connection := dmThemeData.AztecConn;
    saQry.Connection := dmThemeData.AztecConn;
    AddOverrideNodes(FALSE);
    AddOverrideNodes(TRUE);
  finally
    siteQry.Close;
    FreeAndNil(siteQry);
    FreeAndNil(saQry);
  end;
end;

procedure TPromotionalFooterWizard.MoveOverrideNode(FromTreeView, ToTreeView: TTreeView; IsOverride, DeleteFromTree: Boolean);
var
  FromSiteNode, FromSANode, MatchingParent: TTreeNode;
const
  SITE_LEVEL = 0;
  SALES_AREA_LEVEL = 1;

  procedure SetToTreeViewMatchingParent(SelectedFromTreeNode: TTreeNode);
  var
    FoundMatchingParent: Boolean;
    ToSiteNode: TTreeNode;
  begin
    if (ToTreeView.Items.Count = 0) then
    begin
      MatchingParent := ToTreeView.Items.Add(nil, SelectedFromTreeNode.Text);
      MatchingParent.Data := SelectedFromTreeNode.Data;
    end
    else
    begin
      FoundMatchingParent := FALSE;
      ToSiteNode := ToTreeView.Items.GetFirstNode;
      while (ToSiteNode <> nil) do
      begin
        if (Integer(ToSiteNode.Data) = Integer(SelectedFromTreeNode.Data)) then
        begin
          FoundMatchingParent := TRUE;
          MatchingParent := ToSiteNode;
          Break;
        end
        else
          ToSiteNode := ToSiteNode.getNextSibling;
      end;
      if not FoundMatchingParent then
      begin
        MatchingParent := ToTreeView.Items.Add(nil, SelectedFromTreeNode.Text);
        MatchingParent.Data := SelectedFromTreeNode.Data;
      end;
    end;
  end;

  procedure UpdateRecordOverride(SalesAreaID: Integer);
  begin
    with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Add('UPDATE #PromotionalFooterSalesArea ');
      if IsOverride then
        SQL.Add(' SET AllowSiteFooterOverride = 1 ')
      else
        SQL.Add(' SET AllowSiteFooterOverride = 0 ');
      SQL.Add('WHERE SalesAreaID = ' + IntToStr(SalesAreaID));
      ExecSQL;
    end;
  end;

begin
  if not Assigned(FromTreeView.Selected) then exit;

  if (FromTreeView.Selected.Level = SITE_LEVEL) then
  begin
    SetToTreeViewMatchingParent(FromTreeView.Selected);

    FromSANode := FromTreeView.Selected.getFirstChild;
    while (FromSANode <> nil) do
    begin
      ToTreeView.Items.AddChildObject(MatchingParent, FromSANode.Text, FromSANode.Data);
      UpdateRecordOverride(Integer(FromSANode.Data));
      FromSANode := FromSANode.getNextSibling;
    end;

    if DeleteFromTree then
    begin
      FromTreeView.Selected.DeleteChildren;
      FromTreeView.Selected.Delete;
    end;
  end
  else if (FromTreeView.Selected.Level = SALES_AREA_LEVEL) then
  begin
    SetToTreeViewMatchingParent(FromTreeView.Selected.Parent);

    ToTreeView.Items.AddChildObject(MatchingParent, FromTreeView.Selected.Text, FromTreeView.Selected.Data);
    UpdateRecordOverride(Integer(FromTreeView.Selected.Data));

    if DeleteFromTree then
    begin
      FromSiteNode := FromTreeView.Selected.Parent;
      FromTreeView.Selected.Delete;
      if (FromSiteNode.Count = 0) then
      begin
        FromSiteNode.Delete;
      end;
    end;
  end;
end;

procedure TPromotionalFooterWizard.MoveAllOverrideNodes(FromTreeView, ToTreeView: TTreeView; IsOverride: Boolean);
var
  TmpSiteNode, TmpSiteNode2: TTreeNode;
begin
  if (FromTreeView.Items.Count = 0) then exit;

  TmpSiteNode := FromTreeView.Items.GetFirstNode;
  while (TmpSiteNode <> nil) do
  begin
    FromTreeView.Selected := TmpSiteNode;
    MoveOverrideNode(FromTreeView, ToTreeView, IsOverride, FALSE);
    TmpSiteNode := FromTreeView.Selected.getNextSibling;
  end;

  TmpSiteNode := FromTreeView.Items.GetFirstNode;
  TmpSiteNode2 := TmpSiteNode.getNextSibling;
  while (tmpSiteNode2 <> nil) do
  begin
    TmpSiteNode.Delete;
    TmpSiteNode := TmpSiteNode2;
    tmpSiteNode2 := TmpSiteNode.getNextSibling;
  end;
  tmpSiteNode.Delete;
end;

procedure TPromotionalFooterWizard.actORIncludeSAExecute(Sender: TObject);
begin
  MoveOverrideNode(tvNonOverrideSA, tvOverrideSA, TRUE, TRUE);
end;

procedure TPromotionalFooterWizard.actORRemoveSAExecute(Sender: TObject);
begin
  MoveOverrideNode(tvOverrideSA, tvNonOverrideSA, FALSE, TRUE);
end;

procedure TPromotionalFooterWizard.actORIncludeAllExecute(Sender: TObject);
begin
  MoveAllOverrideNodes(tvNonOverrideSA, tvOverrideSA, TRUE);
end;

procedure TPromotionalFooterWizard.actORRemoveAllExecute(Sender: TObject);
begin
  MoveAllOverrideNodes(tvOverrideSA, tvNonOverrideSA, FALSE);
end;

procedure TPromotionalFooterWizard.UpdateTextOverrideTreeViews;
begin
  tvOverrideSA.Items.Clear;
  tvNonOverrideSA.Items.Clear;
  InitialiseTextOverrideTreeViews;
end;



procedure TPromotionalFooterWizard.actAddOverrideExecute(Sender: TObject);
var
  NewID: Integer;
begin
  Log('Footer Wizard - Add Site Override Clicked');
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'select max(OverrideID) from #SitePromotionalFooterOverride';
    Open;
    NewID := 1 + Fields[0].AsInteger;
    Close;
  end;

  with dmPromotionalFooter.qSiteFooterOverride do
  begin
    Append;
    FieldValues['SiteCode'] := -1;
    FieldValues['OverrideID'] := NewId;
    FieldValues['OverrideName'] := 'Override' + InttoStr(NewId);
    Post;
  end;

  AddFooterOverride(NewID);
  Log(Format('Footer Wizard - Add Site Override - Override %d added',[NewId]));
  SetupOverridesGrid;
end;

procedure TPromotionalFooterWizard.actDeleteOverrideExecute(
  Sender: TObject);
var
  OverrideId: Integer;
  OverrideName: String;
begin
  Log('Footer Wizard - Delete Footer Override Clicked');
  if dbgFooterOverrides.DataSource.State in [dsEdit, dsInsert] then
    dbgFooterOverrides.DataSource.Dataset.Post;
  OverrideId := dmPromotionalFooter.qSiteFooterOverride.FieldByName('OverrideId').AsInteger;
  Overridename := dmPromotionalFooter.qSiteFooterOverride.FieldByName('OverrideName').AsString;
  if MessageDlg('Are you sure you want to delete override '+OverrideName+'?',
    mtInformation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  dmPromotionalFooter.DeleteDataForSiteFooterOverride(OverrideId);
  Log(Format('Footer Wizard - Delete Text Override - Override %d deleted',[OverrideId]));
  dmPromotionalFooter.qSiteFooterOverride.Requery;
  if not dmPromotionalFooter.qSiteFooterOverride.Locate('OverrideID', OverrideID, []) then
    dmPromotionalFooter.qSiteFooterOverride.Locate('OverrideID', OverrideID -1, []);
  SetupOverridesGrid;
end;

procedure TPromotionalFooterWizard.PrepareFooterOverrideEditing;
begin
  dbgFooterText.DataSource := dmPromotionalFooter.dsSiteFooterTextOverride;
  dmPromotionalFooter.qSiteFooterTextOverride.Parameters.ParamByName('OverrideID').Value := dbgFooterOverrides.DataSource.DataSet.FieldByName('OverrideID').AsInteger;
  dmPromotionalFooter.qSiteFooterTextOverride.Active := True;
  dmPromotionalFooter.qSiteFooterTextOverride.Requery;
end;

procedure TPromotionalFooterwizard.AddFooterOverride(OverrideID: Integer);
begin
  dmPromotionalFooter.AddDataForSiteFooterOverride(OverrideID);
end;

procedure TPromotionalFooterWizard.dbgProductBarcodesCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  with (Sender as TwwDBGrid) do
  begin
    if not DataSource.DataSet.FieldByName('CanSelect').AsBoolean then
      AFont.Color := clGray;
  end;
end;

constructor TPromotionalFooterWizard.Create(AOwner: TComponent;
  WizardMode: TWizardMode);
begin
  FWizardMode := WizardMode;
  inherited Create(AOwner);
end;

procedure TPromotionalFooterWizard.SetupSalesGroupGrid;
begin
  dbgSaleGroups.Enabled := FSaleSGroupCount > 0;
end;

procedure TPromotionalFooterWizard.tsSalesAreaTextOverrideResize(
  Sender: TObject);
begin
  tvNonOverrideSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tvOverrideSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  btnORIncludeSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnORIncludeAll.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnORRemoveAll.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnORRemoveSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tvOverrideSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lblORSelectedSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TPromotionalFooterWizard.tsPromotionTriggersResize(
  Sender: TObject);
begin
  lbAvailablepromotions.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  lbSelectedPromotions.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  btnRemovePromotion.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnincludePromotion.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  lbSelectedPromotions.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lblSelectedPromotions.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TPromotionalFooterWizard.tsSalesGroupProductsResize(
  Sender: TObject);
begin
  tvAvailableProducts.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tcSalesGroupProducts.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  btnIncludeProduct.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnIncludeAllProducts.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnExcludeProduct.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnExcludeAllProducts.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tcSalesGroupProducts.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lbSelectedProducts.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TPromotionalFooterWizard.tsSalesAreasResize(Sender: TObject);
begin
  tvAvailableSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tvSelectedSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  btnIncludeSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnIncludeAllSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnRemoveSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnRemoveAllSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tvSelectedSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lblSelectedSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TPromotionalFooterWizard.actShowPreviewUpdate(Sender: TObject);
begin
  if FFooterPreview.Showing then
  begin
    actShowPreview.Caption := 'Hide Preview';
  end
  else
  begin
    actShowPreview.Caption := 'Show Preview';
  end;
end;

procedure TPromotionalFooterWizard.actFindNextProductExecute(
  Sender: TObject);
begin
  with FProductDataTree do
  begin
    if FProductSearchTermChanged then
    begin
      FProductSearchTermChanged := false;
      FindNodes(FProductSearchTerm, '##ProductTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableProducts.SetFocus;
end;

procedure TPromotionalFooterWizard.actFindPrevProductExecute(
  Sender: TObject);
begin
  with FProductDataTree do
  begin
    if FProductSearchTermChanged then
    begin
      FProductSearchTermChanged := false;
      FindNodes(FProductSearchTerm, '##ProductTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableProducts.SetFocus;
end;

procedure TPromotionalFooterWizard.edtProductSearchTermChange(
  Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if FProductSearchTerm <> TEdit(Sender).Text then
    begin
      FProductSearchTermChanged := true;
      actFindPrevProduct.Enabled := true;
      actFindNextProduct.Enabled := true;
      FProductSearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TPromotionalFooterWizard.SetupOverridesGrid;
begin
  dbgFooterOverrides.Enabled := dbgFooterOverrides.DataSource.DataSet.RecordCount > 0;
end;

procedure TPromotionalFooterWizard.actDeleteOverrideUpdate(
  Sender: TObject);
begin
 (Sender as TAction).Enabled := dbgFooterOverrides.DataSource.DataSet.RecordCount > 0;
end;

procedure TPromotionalFooterWizard.tsFooterOverrideShow(Sender: TObject);
begin
  SetupOverridesGrid;
end;

procedure TPromotionalFooterWizard.ConfigureFooterTextGrid;
var
  ShowAppendSurveyCheckbox : Boolean;
  ShowAppendVoucherCheckbox : Boolean;
  TextWidth: Integer;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('Select count(*) as UsingSurvey FROM #PromotionalFooterSalesArea pfsa');
    SQL.Add('JOIN ac_SalesArea sa ON sa.Id = pfsa.SalesAreaId');
    SQL.Add('JOIN ThemeOutletConfigs toc ON toc.SiteCode = sa.SiteId');
    SQL.Add('WHERE SurveyCodeSupplier <> 0');
    Open;
    ShowAppendSurveyCheckbox := FieldByName('UsingSurvey').AsInteger > 0;
    Close;
  end;
  ShowAppendVoucherCheckbox := cbPrintVoucherCode.Checked;

  with dbgFooterText do
  begin
    dbgFooterText.BeginUpdate;
    try
      Selected.Clear;
      Selected.Add('LineNumber'#9'4'#9'Line~No.');

      //Use the text column as a compressible area in order to
      //show the optional checkboxes.
      TextWidth := 75;
      if ShowAppendSurveyCheckbox then
        Dec(TextWidth, 10);
      if ShowAppendVoucherCheckbox then
        Dec(TextWidth, 10);

      Selected.Add('Text'#9+IntToStr(TextWidth)+#9'Text'#9'F');
      Selected.Add('Bold'#9'5'#9'Bold');
      Selected.Add('DoubleSize'#9'9'#9'Double-~Width');
      ControlType.Add('Bold;CheckBox;True;False');
      ControlType.Add('DoubleSize;CheckBox;True;False');
      if ShowAppendSurveyCheckbox then
      begin
        Selected.Add('AppendSurveyCode'+#9+'9'+#9+'Append~Survey~Code');
        ControlType.Add('AppendSurveyCode;CheckBox;True;False');
      end;
      if ShowAppendVoucherCheckbox then
      begin
        Selected.Add('AppendVoucherCode'+#9+'9'+#9+'Append~Voucher~Code');
        ControlType.Add('AppendVoucherCode;CheckBox;True;False');
      end;
      ApplySelected;
    finally
      dbgFooterText.EndUpdate;
    end;
    dbgFooterText.Refresh;
  end;
end;

procedure TPromotionalFooterWizard.actDeleteSalesGroupUpdate(
  Sender: TObject);
begin
  (Sender as TAction).Enabled := not dmPromotionalFooter.qEditFooterSaleGroups.FieldByName('SaleGroupID').IsNull;
end;

procedure TPromotionalFooterWizard.actAddSalesGroupUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled :=    (cbPrintMultipleFooters.Checked and (dmPromotionalFooter.qEditFooterSaleGroups.RecordCount = 0))
                                  or not cbPrintMultipleFooters.Checked;
  pnlAddSaleGroup.ShowHint := not (Sender as TAction).Enabled;
end;

procedure TPromotionalFooterWizard.actAddSalesGroupExecute(
  Sender: TObject);
var
  NewID: Integer;
begin
  Log('Footer Wizard - Add Sales Group Clicked');
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'select max(SaleGroupID) from #PromotionalFooterSaleGroup';
    Open;
    NewID := 1 + Fields[0].AsInteger;
    Close;
  end;

  with dmPromotionalFooter.qEditFooterSaleGroups do
  begin
    Append;
    FieldValues['SaleGroupID'] := NewId;
    FieldValues['PromotionalFooterID'] := FPromotionalFooterID;
    FieldValues['SaleGroupType'] := 1;
    FieldValues['Value'] := 0;
    FieldValues['ProductGroupingId'] := varNull;
    Post;
  end;

  AddSaleGroup(NewID);
  Log(Format('Footer Wizard - Add Sales Group - Sales Group %d added',[NewId]));

  SetupSalesGroupGrid;
end;

procedure TPromotionalFooterWizard.actDeleteSalesGroupExecute(
  Sender: TObject);
var
  SaleGroupId: Integer;
begin
  Log('Footer Wizard - Delete Sales Group Clicked');
  if dbgSaleGroups.DataSource.State in [dsEdit, dsInsert] then
    dbgSaleGroups.DataSource.Dataset.Post;

  if dmPromotionalFooter.qEditFooterSaleGroups.FieldByName('SaleGroupID').IsNull then
  begin
    MessageDlg('Please select a sales group.', mtError, [mbok], 0);
    Abort;
  end;

  SaleGroupID := dmPromotionalFooter.qEditFooterSaleGroups.FieldByName('SaleGroupID').AsInteger;
  if MessageDlg('Are you sure you want to delete Group '+IntToStr(SaleGroupID)+'?',
    mtInformation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  RemoveSaleGroup(SaleGroupID);
  Log(Format('Footer Wizard - Delete Sales Group - Sales Group %d deleted',[SaleGroupID]));
  dmPromotionalFooter.qEditFooterSaleGroups.Requery;
  if not dmPromotionalFooter.qEditFooterSaleGroups.Locate('SaleGroupID', SaleGroupID, []) then
    dmPromotionalFooter.qEditFooterSaleGroups.Locate('SaleGroupID', SaleGroupID -1, []);
  SetupSalesGroupGrid;
end;

procedure TPromotionalFooterWizard.sePrintFrequencyKeyPress(
  Sender: TObject; var Key: Char);
var
  Clpbrd: TClipboard;
begin
  // #3 = ctrl-c, #8 = backspace, #22 = ctrl-v
  if not (Key in [#3, #8, '0'..'9', #22]) then
  begin
    Key := #0;
  end
  else if Key = #22 then
  begin
    Clpbrd := Clipboard;
    try
      StrToInt(Clpbrd.AsText);
    except
      on e:EConvertError do
      begin
        Abort;
      end;
    end;
  end;
end;

procedure TPromotionalFooterWizard.sePrintFrequencyChange(Sender: TObject);
begin
  with Sender as TSpinEdit do
  begin
    try
      if Text <> '' then
        if StrToInt(Text) > MaxValue then
        begin
          MessageDlg(Format('Value may not exceed %d.',[MaxValue]),mtError, [mbOK],0);
          Value := MaxValue;
        end;
    except
      on E:EConvertError do
      begin
        MessageDlg(Format('Value must be numeric and may not exceed %d.',[MaxValue]),mtError, [mbOK],0);
        Value := MaxValue;
      end;
    end;
  end;
end;

procedure TPromotionalFooterWizard.edtCampaignIDKeyPress(Sender: TObject;
  var Key: Char);
const OtherKeys = [VK_RETURN, VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_TAB, VK_BACK, VK_ESCAPE, VK_DELETE];
begin
  if not ((Key in ['0'..'9']) or (Ord(Key) in OtherKeys)) then
    Key := #0;
end;

procedure TPromotionalFooterWizard.actPrintVoucherCodeUpdate(
  Sender: TObject);
begin
  lblCampaignID.Enabled := (Sender as TAction).Checked;
  edtCampaignID.Enabled := lblCampaignID.Enabled;
end;

procedure TPromotionalFooterWizard.cbPrintVoucherCodeClick(
  Sender: TObject);
begin
  lblCampaignID.Enabled := (Sender as TCheckBox).Checked;
  edtCampaignID.Enabled := lblCampaignID.Enabled;
end;

end.
