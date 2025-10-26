unit uEstateSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, wwcheckbox, wwdblook, Grids,
  Wwdbigrd, Wwdbgrid, DB, ADODB, DBGrids, uGridSortHelper, ActnList,
  AppEvnts, uSelectReasonsFrame, ExtCtrls;

type
  TInstruction = class(TObject)
    public
    EntityCode: LargeInt;
    Name: string;
    constructor Create(InstructionEntityCode: LargeInt; InstructionName: String);
  end;

  TVariationSummary = packed record
    VarCount, VarChecksum, VarPanelCount, VarPanelChecksum: integer;
  end;

  TColumnLookupData = packed record
    ColumnID: integer;
    ColumnName: string;
    FieldName: string;
    DisplaySize: integer;
    DisplaySizePixels: integer;
    LookupQuery: TADOQuery;
    LookupControl: TwwDBLookupCombo;
    LookupField: TStringField;
    DataField: TIntegerField;
  end;

  TEstateSetup = class(TForm)
    pcBaseData: TPageControl;
    TabConfigSets: TTabSheet;
    Label8: TLabel;
    gConfigSchemes: TwwDBGrid;
    btAddConfigScheme: TButton;
    btDeleteConfigScheme: TButton;
    wwdbLookupKDSType: TwwDBLookupCombo;
    wwDBLookupTerminalGraphic: TwwDBLookupCombo;
    GroupBoxOrderDestinations: TGroupBox;
    CheckBoxShowOrderDestinations: TwwCheckBox;
    gConfigSetDestinationSettings: TwwDBGrid;
    GroupBox3: TGroupBox;
    gConfigSetDivisionalSettings: TwwDBGrid;
    GroupBox4: TGroupBox;
    gSubCategorySettings: TwwDBGrid;
    wwDBLookupCombo1: TwwDBLookupCombo;
    GlobalConfigs: TTabSheet;
    HotelAnalysisCodesGroup: TGroupBox;
    grdHotelAnalysisCodes: TwwDBGrid;
    btAddAnalysisCode: TButton;
    btEditAnalysisCode: TButton;
    btDeleteAnalysisCode: TButton;
    ScaleContainerGroupBox: TGroupBox;
    dbgScaleContainers: TwwDBGrid;
    btnAddScaleContainer: TButton;
    btnEditScaleContainer: TButton;
    btnDeleteScaleContainer: TButton;
    pgcReasonsConfiguration: TTabSheet;
    lblReasons: TLabel;
    btnAddReason: TButton;
    btnSaveConfiguration: TButton;
    gbTerminalOptions: TGroupBox;
    lblReasonButton: TLabel;
    mmReasonEposName: TMemo;
    cbOpenReasonType: TCheckBox;
    lbReasons: TListBox;
    btnClose: TButton;
    grbxUnattended: TGroupBox;
    lblKioskPayment: TLabel;
    cmbbxKioskPaymentMethod: TComboBox;
    lblCorrectionMethodRegular: TLabel;
    cmbbxKioskCorrectionMethodRegular: TComboBox;
    lblCorrectionmethodClearAll: TLabel;
    cmbbxKioskCorrectionMethodClearAll: TComboBox;
    tsMultiSiteOverride: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    btAddSMOverride: TButton;
    btEditSMOverride: TButton;
    btDeleteSMOverride: TButton;
    btAddPFOverride: TButton;
    btEditPFOverride: TButton;
    btDeletePFOverride: TButton;
    dbgSMOverride: TwwDBGrid;
    dbgPFOverride: TwwDBGrid;
    lblBFOverride: TLabel;
    dbgBFOverride: TwwDBGrid;
    btAddBFOverride: TButton;
    btEditBFOverride: TButton;
    btDeleteBFOverride: TButton;
    tsReportOverrides: TTabSheet;
    lblClockoutTicketFooterOverrides: TLabel;
    dbgrdClockouttocketFooterOverrides: TwwDBGrid;
    btnAddClockoutTicketFooterOverride: TButton;
    btnEditClockoutTicketFooterOverride: TButton;
    btnDeleteClockoutTicketFooterOverride: TButton;
    tsDiscounts: TTabSheet;
    gDiscounts: TwwDBGrid;
    btAddDiscount: TButton;
    btEditDiscount: TButton;
    btDeleteDiscount: TButton;
    btnSecurityRanges: TButton;
    Label3: TLabel;
    gpbxHotelDivisions: TGroupBox;
    gHotelDivisions: TwwDBGrid;
    btAddHotelDivision: TButton;
    btEditHotelDivision: TButton;
    btDeleteHotelDivision: TButton;
    gpbxMisc: TGroupBox;
    btnTerminalGraphics: TButton;
    udCurrencyRoundingFactor: TUpDown;
    edCurrencyRoundingFactor: TEdit;
    Label25: TLabel;
    cbxOmitMerchantEFTReceipt: TCheckBox;
    cbxPrintCustomerICCReceiptFirst: TCheckBox;
    cbxShowInclusiveTaxOnBill: TCheckBox;
    cbVATMode: TComboBox;
    Label21: TLabel;
    tsZcpsConfigs: TTabSheet;
    dbgVariationGrid: TwwDBGrid;
    ZcpsConfigActions: TActionList;
    ZcpsConfigsInit: TAction;
    ZcpsConfigsDeInit: TAction;
    ZcpsConfigsLoad: TAction;
    ZcpsConfigsSave: TAction;
    Button1: TButton;
    Button2: TButton;
    lbZcpsConfigsTitle: TLabel;
    gpbxMainsAway: TGroupBox;
    lblMainsAwayInstruction: TLabel;
    cmbbxInstruction: TComboBox;
    lblMainsCourse: TLabel;
    cmbbxCourse: TComboBox;
    gCustomerInformationPrompts: TwwDBGrid;
    wwDBLookupCustomerInfoPrompts: TwwDBLookupCombo;
    btnAddInformationPrompt: TButton;
    btnDeleteInformationPrompt: TButton;
    tsCustomerInfoPrompts: TTabSheet;
    tsCorrections: TTabSheet;
    lblCorrectionMethod: TLabel;
    cbCorrectionMethod: TComboBox;
    CorrectionReasonsFrame: TSelectReasonsFrame;
    btnEditTableMoveReasons: TButton;
    cbPromoDetailsMaint: TCheckBox;
    lblRetentionPeriod: TLabel;
    edRetentionPeriod: TEdit;
    udRetentionPeriod: TUpDown;
    Bevel1: TBevel;
    EditQrCodeTextBtn: TButton;
    QrCodeTextLabel: TLabel;
    BarCodeTextLabel: TLabel;
    EditBarCodeTextBtn: TButton;
    
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabConfigSetsShow(Sender: TObject);
    procedure gConfigSchemesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure gConfigSetDestinationSettingsFieldChanged(Sender: TObject;
      Field: TField);
    procedure btAddConfigSchemeClick(Sender: TObject);
    procedure btDeleteConfigSchemeClick(Sender: TObject);
    procedure TabConfigSetsHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbVATModeChange(Sender: TObject);
    procedure GlobalConfigsShow(Sender: TObject);
    procedure GlobalConfigsHide(Sender: TObject);
    procedure btAddDiscountClick(Sender: TObject);
    procedure btEditDiscountClick(Sender: TObject);
    procedure btDeleteDiscountClick(Sender: TObject);
    procedure btnSecurityRangesClick(Sender: TObject);
    procedure btAddHotelDivisionClick(Sender: TObject);
    procedure btEditHotelDivisionClick(Sender: TObject);
    procedure btDeleteHotelDivisionClick(Sender: TObject);
    procedure btnTerminalGraphicsClick(Sender: TObject);
    procedure btAddAnalysisCodeClick(Sender: TObject);
    procedure btEditAnalysisCodeClick(Sender: TObject);
    procedure btDeleteAnalysisCodeClick(Sender: TObject);
    procedure btnAddScaleContainerClick(Sender: TObject);
    procedure btnEditScaleContainerClick(Sender: TObject);
    procedure btnDeleteScaleContainerClick(Sender: TObject);
    procedure pgcReasonsConfigurationShow(Sender: TObject);
    procedure pgcReasonsConfigurationHide(Sender: TObject);
    procedure btnAddReasonClick(Sender: TObject);
    procedure lbReasonsClick(Sender: TObject);
    procedure btnSaveConfigurationClick(Sender: TObject);
    procedure mmReasonEposNameChange(Sender: TObject);
    procedure cbOpenReasonTypeClick(Sender: TObject);
    procedure pcBaseDataChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pcBaseDataChange(Sender: TObject);
    procedure dbgScaleContainersDblClick(Sender: TObject);
    procedure tsMultiSiteOverrideShow(Sender: TObject);
    procedure tsMultiSiteOverrideHide(Sender: TObject);
    procedure btDeleteSMOverrideClick(Sender: TObject);
    procedure btAddSMOverrideClick(Sender: TObject);
    procedure btEditSMOverrideClick(Sender: TObject);
    procedure btAddPFOverrideClick(Sender: TObject);
    procedure btEditPFOverrideClick(Sender: TObject);
    procedure btDeletePFOverrideClick(Sender: TObject);
    procedure dbgSMOverrideDblClick(Sender: TObject);
    procedure dbgPFOverrideDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbbxKioskPaymentMethodSelect(Sender: TObject);
    procedure btAddBFOverrideClick(Sender: TObject);
    procedure btEditBFOverrideClick(Sender: TObject);
    procedure btDeleteBFOverrideClick(Sender: TObject);
    procedure dbgBFOverrideDblClick(Sender: TObject);
    procedure btnAddClockoutTicketFooterOverrideClick(Sender: TObject);
    procedure btnEditClockoutTicketFooterOverrideClick(Sender: TObject);
    procedure btnDeleteClockoutTicketFooterOverrideClick(Sender: TObject);
    procedure dbgrdClockouttocketFooterOverridesDblClick(Sender: TObject);
    procedure tsReportOverridesShow(Sender: TObject);
    procedure tsReportOverridesHide(Sender: TObject);
    procedure tsDiscountsShow(Sender: TObject);
    procedure tsDiscountsHide(Sender: TObject);
    procedure cmbbxCourseCloseUp(Sender: TObject);
    procedure cmbbxInstructionCloseUp(Sender: TObject);
    procedure ZcpsConfigsInitExecute(Sender: TObject);
    procedure ZcpsConfigsDeInitExecute(Sender: TObject);
    procedure ZcpsConfigsHandleDatasetAfterEdit(Sender: TDataset);
    procedure ZcpsConfigsLoadExecute(Sender: TObject);
    procedure ZcpsConfigsSaveExecute(Sender: TObject);
    procedure ZcpsConfigsLoadUpdate(Sender: TObject);
    procedure dbgVariationGridCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure ZcpsConfigActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure gDiscountsDblClick(Sender: TObject);
    procedure gDiscountsKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddInformationPromptClick(Sender: TObject);
    procedure btnDeleteInformationPromptClick(Sender: TObject);
    procedure tsCustomerInfoPromptsHide(Sender: TObject);
    procedure gConfigSchemesMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure cbCorrectionMethodChange(Sender: TObject);
    procedure tsCorrectionsShow(Sender: TObject);
    procedure tsCorrectionsHide(Sender: TObject);
    procedure cbCorrectionMethodEnter(Sender: TObject);
    procedure SaveCorrectionReasons;
    procedure btnEditTableMoveReasonsClick(Sender: TObject);
    procedure EditQrCodeTextBtnClick(Sender: TObject);
    procedure cbPromoDetailsMaintClick(Sender: TObject);
    procedure EditBarCodeTextBtnClick(Sender: TObject);
  private
    { Private declarations }
    SMOverrideSortHelper: TGridSortHelper;
    PFOverrideSortHelper: TGridSortHelper;
    BFOverrideSortHelper: TGridSortHelper;
    vatmode: integer;
    currencyroundingfactor: integer;
    showInclusiveTaxOnBill: boolean;
    printCustomerICCReceiptFirst: boolean;
    omitMerchantEFTReceipt: boolean;
    ReasonIndex: integer;
    KioskPaymentMethod : integer;
    KioskCorrectionMethodRegular : integer;
    KioskCorrectionMethodClearAll : integer;
    SelectedKioskPaymentMethodIndex: integer;
    KioskPaymentMethodName: string;
    PaymentMethodList : TStringList;
    CorrectionMethodList : TStringList;
    CourseList : TStringList;
    InstructionList : TStringList;
    MainsAwayInstruction: TInstruction;
    MainsAwayInstructionValue: LargeInt;
    MainsAwayCourse: Integer;
    ZcpsConfigsDatamodified: boolean;
    VariationSummary: TVariationSummary;
    ColumnLookupData: array of TColumnLookupData;
    ZcpsConfigsLoadSQL, ZcpsConfigsSaveSQL: string;
    ZcpsConfigsDropSQL, ZcpsConfigsCreateSQL: string;
    FgConfigSchemeColumns: TStringList;
    promoRetentionPeriod: smallint;
    CurrentAppHintDelay : integer;

    procedure EnableOrderDestinations;
    procedure PostConfigSetData;
    function FullyUpgraded : Boolean;
    procedure RequerySwipeCardRangeInfo;
    procedure RefreshReasons;
    procedure SaveChangedReasons;
    procedure RefreshOptions(ACorrectionReason : string);
    function ValidateOrderDestinations: Boolean;
    procedure PopulateCorrectionMethodComboBox;
    procedure EditScaleContainer;
    function PopulateKioskPaymentMethods : TStrings;
    procedure PopulateKioskCorrectionMethods;
    procedure RefreshTextOverrides(DataSet: TAdoQuery);
    procedure InitialiseCorrectionReasons;
    procedure PopulateMainsAwayCourses;
    procedure PopulateMainsAwayInstructions(CourseID: Integer; MainsAwayInstructionValue: LargeInt = -1);
    procedure ZcpsConfigsClearLookupData();
    procedure ZcpsConfigsPostChanges();
    procedure ZcpsConfigsPromptSaveChanges();
    function AddSpaceToCamelCase(input: string): string;
    procedure EditOneDiscount;
    procedure SetInfoPromptGridState;
  end;

  TPaymentMethod = class(TObject)
  public
    Id: smallint;
    UsedOnPanel: Boolean;
    constructor Create(paymentMethodId: Integer; onPanel: Boolean);
  end;

implementation

uses uAztecLog, uSimpleLocalise, dADOAbstract, uDMThemeData, uFormNavigate, uADO,
     uGlobals, AztecResourceStrings, uEditDiscount, uSwipeCardRanges, uGenerateThemeIDs,
     uEditGenericDetails, uTerminalGraphics, uEditHotelAnalysisCode, uEditSCaleContainer,
     uScaleContainerDeletionDialog, uNewReason, uEditTableMoveReasons,
     uTextOverrideWizard, math, useful, uThemeModellingMenu, StrUtils, uEditClmQrCodeText;

type
  TwwDBGridHack = class(TwwDBGrid)
  end;

const
  STD_VAT = 0;
  NAR_VAT = 1;
  RND_VAT = 2;
  MAXIMUM_ASSIGNED_REASON_COUNT_WITH_MATCH_DAY_STOCK = 98;

{$R *.dfm}

procedure TEstateSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
begin
  for i := PaymentMethodList.Count-1 downto 0 do
     PaymentMethodList.Objects[i].Free;
  FgConfigSchemeColumns.Free;
  Nav.MoveBack;
  Application.HintHidePause := CurrentAppHintDelay;
end;


procedure TEstateSetup.EnableOrderDestinations;
begin
  gConfigSetDestinationSettings.Enabled := udmThemeData.OrderDestinationsEnabled;
  CheckBoxShowOrderDestinations.Enabled := udmThemeData.OrderDestinationsEnabled;
  GroupBoxOrderDestinations.Enabled := udmThemeData.OrderDestinationsEnabled;
  GroupBoxOrderDestinations.Visible := udmThemeData.OrderDestinationsEnabled;
end;


procedure TEstateSetup.TabConfigSetsShow(Sender: TObject);

  procedure OpenOrRequeryQuery(query: TADOQuery);
  begin
    if assigned(query) then
    begin
      query.DisableControls;
      try
        if query.Active then
          query.Requery
        else
          query.Open;
      finally
        query.EnableControls;
      end;
    end;
  end;

  procedure AmendConfigSetEditability;
  var
    i: Integer;
    configSetFieldName: string;
  begin
    gConfigSchemes.DataSource.DataSet.FieldByName('PrintPriceEmbeddedBarcode').Visible := dmThemeData.PriceEmbeddedBarcodePrefixSpecified;
    gConfigSchemes.DataSource.DataSet.FieldByName('AllowCharityDonations').ReadOnly := not dmThemeData.CharityDonationsEnabledForTheEstate;
    gConfigSchemes.DataSource.DataSet.FieldByName('PromptToRedeemBookingOnStartTable').ReadOnly := not dmThemeData.RedeemDepositPaymentMethodExists;

    gConfigSchemes.Selected.Clear;
    for i := 0 to FgConfigSchemeColumns.Count -1 do
    begin
      configSetFieldName := LeftStr(FgConfigSchemeColumns[i], Pos(#9, FgConfigSchemeColumns[i]) - 1);

      if gConfigSchemes.DataSource.DataSet.FieldByName(configSetFieldName).Visible then
        gConfigSchemes.Selected.Add(FgConfigSchemeColumns[i]);
    end;
    gConfigSchemes.ApplySelected;
  end;

begin
  //Hideous redrawing artifacts unless we call a refresh.....
  TabConfigSets.Refresh;

  dmThemeData.qKitchenScreenType.Open;
  dmThemeData.qTerminalGraphicsWithDefault.Open;
  dmThemedata.qConfigSetCheckDivisions.execsql;
  dmThemedata.qConfigSetCheckOrderDestinations.ExecSQL;

  OpenOrRequeryQuery(dmThemeData.qDestinations);
  OpenOrRequeryQuery(dmThemeData.qConfigSets);
  AmendConfigSetEditability;
  OpenOrRequeryQuery(dmThemedata.qConfigSetDivisions);
  OpenOrRequeryQuery(dmThemedata.qConfigSetSubcat);
  OpenOrRequeryQuery(dmThemedata.qConfigSetDestinations);

  if dmThemeData.qHotelDivsCombo.active then
    dmThemeData.qHotelDivsCombo.Requery([])
  else
    dmThemeData.qHotelDivsCombo.open;

  wwDBLookupCombo1.Enabled := dmThemeData.qHotelDivsCombo.RecordCount > 0;
  if(wwDBLookupCombo1.Enabled) then
    gSubCategorySettings.Hint := 'Select Hotel Division'
  else
    gSubCategorySettings.Hint := 'No Hotel Divisions are configured';
  LocaliseText(gConfigSetDivisionalSettings);
  LocaliseText(gConfigSchemes);
end;

procedure TEstateSetup.gConfigSchemesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if (Field.FieldName = 'Name') and not Highlight then
    ABrush.Color := clWindow;

  if (Field.FieldName = 'ConversationalRecipesAutoAdvance') then
  begin
    if not Field.DataSet.FieldByName('ConversationalRecipesEnabled').AsBoolean then
      ABrush.Color := clBtnFace;
  end
  else if (Field.FieldName = 'UseDrawerAssignment') then
  begin
    if Field.DataSet.FieldByName('UseDrawerAssignment').AsBoolean AND
    (dmThemeData.IsMultiDrawerModeInUseForConfigSet(Field.DataSet.FieldByName('ConfigSetId').AsInteger)) then
    begin
      ABrush.Color := clBtnFace;
    end;
  end
  else if (Field.FieldName = 'i700CheckDrawerStatusBeforeOpening') then
  begin
    if (Field.DataSet.FieldByName('i700CheckDrawerStatusBeforeOpening').AsBoolean) and (Field.DataSet.FieldByName('DisableAllButtonsWhenDrawerOpen').AsBoolean) then
      ABrush.Color := clBtnFace;
  end
  else
  begin
    if Field.ReadOnly then
      ABrush.Color := clBtnFace;
  end;
end;

procedure TEstateSetup.gConfigSetDestinationSettingsFieldChanged(
  Sender: TObject; Field: TField);
var
  IsDefault: Boolean;
  Destination: Integer;
  UseDestination: Boolean;
  OldPos: TBookmark;
  TempIsDefault: Boolean;
  TempDestination: Integer;
begin
  if (Field.FieldName = 'IsDefault') then
  begin
    gConfigSetDestinationSettings.BeginUpdate;
    dmThemeData.qConfigSetDestinations.DisableControls;

    Destination := dmThemeData.qConfigSetDestinations.FieldByName('OrderDestination').AsInteger;
    IsDefault := dmThemeData.qConfigSetDestinations.FieldByName('IsDefault').AsBoolean;
    UseDestination := dmThemeData.qConfigSetDestinations.FieldByName('UseDestination').AsBoolean;

    if IsDefault and not UseDestination then
    begin
      dmthemeData.qConfigSetDestinations.Edit;
      dmThemeData.qConfigSetDestinations.FieldByName('UseDestination').Value := True;
      dmthemeData.qConfigSetDestinations.Post;
    end;

    OldPos := dmThemeData.qConfigSetDestinations.GetBookmark;
    try
      dmThemeData.qConfigSetDestinations.First;
      while not dmThemeData.qConfigSetDestinations.Eof do
      begin
        TempDestination := dmThemeData.qConfigSetDestinations.FieldByName('OrderDestination').AsInteger;
        TempIsDefault := dmThemeData.qConfigSetDestinations.FieldByName('IsDefault').AsBoolean;
        if (TempDestination <> Destination) and (TempIsDefault) then
        begin
          dmThemeData.qConfigSetDestinations.Edit;
          dmThemeData.qConfigSetDestinations.FieldByName('IsDefault').Value := False;
        end;

        dmThemeData.qConfigSetDestinations.Next;
      end;
    finally
      dmThemeData.qConfigSetDestinations.EnableControls;
      dmThemeData.qConfigSetDestinations.GotoBookmark(OldPos);
      gConfigSetDestinationSettings.EndUpdate(True);
    end;
  end
  else if  (Field.FieldName = 'UseDestination') then
  begin
    gConfigSetDestinationSettings.BeginUpdate;
    dmThemeData.qConfigSetDestinations.DisableControls;

    IsDefault := dmThemeData.qConfigSetDestinations.FieldByName('IsDefault').AsBoolean;
    UseDestination := dmThemeData.qConfigSetDestinations.FieldByName('UseDestination').AsBoolean;

    try
      if IsDefault and not UseDestination then
      begin
        dmthemeData.qConfigSetDestinations.Edit;
        dmThemeData.qConfigSetDestinations.FieldByName('IsDefault').Value := False;
        dmthemeData.qConfigSetDestinations.Post;
      end;
    finally
      dmThemeData.qConfigSetDestinations.EnableControls;
      gConfigSetDestinationSettings.EndUpdate(True);
    end;
  end;
end;

procedure TEstateSetup.btAddConfigSchemeClick(Sender: TObject);
var
  i : smallint;
begin
  Log('Add Terminal Configuration set clicked');

  PostConfigSetData;

  with dmado.qRun do
  begin
    // ensure Name uniqueness
    i := 0;
    Close;
    sql.Clear;
    sql.Add('select * from themeconfigset');
    sql.Add('where [name] = ''New config set''');
    open;

    if recordcount <> 0 then
    begin
      for i := 1 to 999 do
      begin
        Close;
        sql.Clear;
        sql.Add('select * from themeconfigset');
        sql.Add('where [name] = ''New config set ' + inttostr(i) + '''');
        open;

        if recordcount = 0 then
          break;
      end;
      close;
    end;


    sql.text := 'select 1 + max(configsetid) as newid from themeconfigset_repl';
    open;
    dmThemeData.qConfigSets.Insert;
    dmThemeData.qConfigSets.FieldByName('configsetid').asinteger := fieldbyname('newid').asinteger;
    if i = 0 then
      dmThemeData.qConfigSets.FieldByName('name').asstring := 'New config set'
    else
      dmThemeData.qConfigSets.FieldByName('name').asstring := 'New config set ' + inttostr(i);
    dmThemeData.qConfigSets.Post;
    close;
  end;

  dmThemedata.qDestinations.Requery;

  dmThemedata.qConfigSetCheckDivisions.ExecSQL;
  dmThemedata.qConfigSetCheckOrderDestinations.ExecSQL;

  dmThemedata.qConfigSets.Refresh;
  dmThemedata.qConfigSetDivisions.Refresh;
  dmThemedata.qConfigSetDestinations.Refresh;
end;

procedure TEstateSetup.btDeleteConfigSchemeClick(Sender: TObject);
begin
  Log('Delete Terminal Configuration set clicked');
  if gConfigSchemes.DataSource.DataSet.FieldByName('ConfigSetID').asinteger = 0 then
    raise exception.create('You may not delete the default config set');
  with dmado.qrun do
  begin
    sql.text := 'select * from themeeposdevice where configsetid = '+ gConfigSchemes.DataSource.DataSet.FieldByName('ConfigSetID').asstring;
    open;
    if recordcount > 0 then
    begin
      close;
      raise exception.create('You may not delete this configuration set as it is still in use.');
    end;
    close;
  end;
  gConfigSchemes.DataSource.DataSet.Delete;
  dmThemedata.qConfigSetCheckDivisions.execsql;
  dmThemeData.qConfigSetCheckOrderDestinations.ExecSQL;
end;

procedure TEstateSetup.PostConfigSetData;
begin
  if dmThemeData.qConfigSets.State in [dsEdit, dsInsert] then
    dmThemeData.qConfigSets.post;
  if dmThemeData.qConfigSetDivisions.State in [dsEdit, dsInsert] then
    dmThemeData.qConfigSetDivisions.post;
  // qConfigSetSubcat always gets posted if master dataset qConfigSets is posted
  // and qConfigSets is always in edit state whenever this tab is shown (have not investigated why)
  // but its probably safer to leave this code in:
  if dmThemeData.qConfigSetSubCat.State in [dsEdit, dsInsert] then
    dmThemeData.qConfigSetSubCat.post;
  if dmThemeData.qConfigSetDestinations.State in [dsEdit, dsInsert] then
    dmThemeData.qConfigSetDestinations.post;
end;

procedure TEstateSetup.TabConfigSetsHide(Sender: TObject);
begin
  if not Showing then
    Exit;
  PostConfigSetData;
  dmThemeData.qHotelDivsCombo.close;
  dmThemeData.qKitchenScreenType.Close;
  dmThemeData.qTerminalGraphicsWithDefault.Close;
  dmThemedata.qConfigSets.close;
end;

procedure TEstateSetup.FormShow(Sender: TObject);
begin
  PaymentMethodList := TStringList.Create;
  cmbbxKioskPaymentMethod.Items.Assign(PopulateKioskPaymentMethods);
  cmbbxKioskPaymentMethod.ItemIndex := PaymentMethodList.IndexOf(KioskPaymentMethodName);
  SelectedKioskPaymentMethodIndex:= cmbbxKioskPaymentMethod.ItemIndex;
  CorrectionMethodList := TStringList.Create;
  PopulateKioskCorrectionMethods;
  cmbbxKioskCorrectionMethodRegular.Items.Assign(CorrectionMethodList);
  cmbbxKioskCorrectionMethodRegular.ItemIndex := CorrectionMethodList.IndexOfObject(TObject(KioskCorrectionMethodRegular));
  cmbbxKioskCorrectionMethodClearAll.Items.Assign(CorrectionMethodList);
  cmbbxKioskCorrectionMethodClearAll.ItemIndex := CorrectionMethodList.IndexOfObject(TObject(KioskCorrectionMethodClearAll));

  dmThemeData.qConfigSetsUseFastEFT.ReadOnly := not CurrentUser.IsZonalUser;
  HotelAnalysisCodesGroup.Visible := CurrentUser.IsZonalUser;
  pcBaseData.ActivePage := TabConfigSets;

  dmThemeData.qCustomerInformationPrompts.Active := true;
  SetInfoPromptGridState;
  if UKUSmode = 'US' then
  begin
    EditQrCodeTextBtn.Caption := 'Edit QR code text for Check Payment';
    EditBarCodeTextBtn.Caption := 'Edit Barcode text for Checks and Receipts'
  end;

  dmado.adoqrun.close;
  dmADO.adoqrun.SQL.Clear;
  dmADO.adoqRun.SQL.Add('declare @Adm varchar(20), @Don varchar(20) ' +
    ' select @Adm = dbo.fn_GetConfigurationSetting(''NoDiscountForAdmissions''), ' +
    '   @Don = dbo.fn_GetConfigurationSetting(''NoDiscountForDonations'') ' +
    ' SELECT CAST(IIF(ISNUMERIC(@Adm) > 0, IIF(CAST(@Adm as int) = 1, 1, 0), IIF(@Adm = ''true'', 1, 0)) as bit) NoDiscAdmissions, ' +
    '   CAST(IIF(ISNUMERIC(@Don) > 0, IIF(CAST(@Don as int) = 1, 1, 0), IIF(@Don = ''true'', 1, 0)) as bit) NoDiscDonations');
  dmADO.adoqRun.Open;
  dmADO.NoDiscAdmissions := dmado.adoqrun.fieldbyname('NoDiscAdmissions').AsBoolean;
  dmADO.NoDiscDonations := dmado.adoqrun.fieldbyname('NoDiscDonations').AsBoolean;

  CurrentAppHintDelay := Application.HintHidePause;
  Application.HintHidePause := 4000;
end;

function TEstateSetup.PopulateKioskPaymentMethods : TStrings;
var
  i: integer;
begin
  if Assigned(PaymentMethodList) then
    for i := PaymentMethodList.Count-1 downto 0 do
       PaymentMethodList.Objects[i].Free;

    PaymentMethodList.Clear;
    with dmADO.qRun do
    try
      Close;
      SQL.Text :=
        'SELECT NULL AS ID, '''' AS Name, CAST(0 AS bit) AS OnPanel ' +
        '  UNION ' +
        'SELECT pm.Id, pm.Name, ' +
        '  CASE ISNULL(bpm.PaymentMethodID, -1) ' +
        '    WHEN -1 THEN CAST(0 AS bit) ' +
        '    ELSE CAST(1 AS bit) ' +
        '  END ' +
        'FROM ' +
        '  ac_PaymentMethod pm ' +
        '    LEFT OUTER JOIN ' +
        '  ( ' +
        '    SELECT DISTINCT CAST(b.ButtonTypeChoiceAttr01 AS int) AS PaymentMethodId ' +
        '    FROM ' +
        '      ThemePanelButton b ' +
        '        INNER JOIN ' +
        '      ThemeButtonTypeChoiceLookup t ' +
        '        ON t.Id = b.ButtonTypeChoiceID AND t.ElemAttrName01 = ''PaymentMethod'' ' +
        '  ) bpm ON bpm.PaymentMethodId = pm.Id ' +
        'WHERE pm.PaymentMethodType IN (1,2) ' +
        'AND pm.QuickPay <> 1 ' +
        'ORDER BY Name ';
      Open;
      while not EOF do
      begin
        PaymentMethodList.AddObject(FieldByName('Name').AsString,
          TPaymentMethod.Create(FieldByName('ID').AsInteger, FieldByName('OnPanel').AsBoolean));
        Next;
      end
    finally
      Close;
    end;
  Result := PaymentMethodList;
end;

procedure TEstateSetup.PopulateKioskCorrectionMethods;
begin
    CorrectionMethodList.Clear;
    with dmADO.qRun do
    try
      Close;
      SQL.Text := 'SELECT NULL AS ID, '''' AS Name '+
                  '  UNION '+
                  'SELECT tcm.CorrectionMethodID, tcm.Name '+
                  'FROM ThemeCorrectionMethod tcm '+
                  'WHERE tcm.Deleted = 0 and tcm.CorrectionType = 0';
      Open;
      while not EOF do
      begin
        CorrectionMethodList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('ID').AsInteger)));
        Next;
      end
    finally
      Close;
    end;
end;

procedure TEstateSetup.btnCloseClick(Sender: TObject);
var
  canClose: boolean;
begin
  // Ensure that all edits/inserts are posted...
  pcBaseDataChanging(Sender, canClose);
  if canClose then
    Close;
end;

procedure TEstateSetup.FormCreate(Sender: TObject);
  function PrintEmbeddedPriceBarcodeCorrectlyPositioned: Boolean;
  var
    i: Integer;
  begin
    Result := False;
    with gConfigSchemes do
    for i := (Selected.Count - 1) downto 0 do
    begin
      Result := (Pos('UsesPosPrinting', Selected[i-1]) > 0)
        and (Pos('PrintPriceEmbeddedBarcode', Selected[i]) > 0);
      if result then Break;
    end;
  end;

begin
  Assert(PrintEmbeddedPriceBarcodeCorrectlyPositioned, 'PrintPriceEmbeddedBarcode column should be immediately after UserPosPrinting');

  lblBFOverride.Caption := LocaliseString(lblBFOverride.Caption);
  PaymentMethodList := TStringList.Create;
  cmbbxKioskPaymentMethod.Items.Assign(PopulateKioskPaymentMethods);

  CorrectionMethodList := TStringList.Create;
  PopulateKioskCorrectionMethods;
  cmbbxKioskCorrectionMethodRegular.Items.Assign(CorrectionMethodList);
  cmbbxKioskCorrectionMethodClearAll.Items.Assign(CorrectionMethodList);

  PFOverrideSortHelper := TGridSortHelper.Create;
  PFOverrideSortHelper.Initialise(dbgPFOverride);
  SMOverrideSortHelper := TGridSortHelper.Create;
  SMOverrideSortHelper.Initialise(dbgSMOverride);
  BFOverrideSortHelper := TGridSortHelper.Create;
  BFOverrideSortHelper.Initialise(dbgBFOverride);

  EnableOrderDestinations;
  cbVatMode.Items.Insert(0, 'Simple ' + VAT);
  cbVatMode.Items.Insert(1, 'Normal Accounting Rules (NAR) ' + VAT);
  cbVatMode.Items.Insert(2, 'Bespoke VAT Rounding ');

  CourseList := TStringList.Create;
  InstructionList := TStringList.Create;

  //Squirrel away the column definitions of the config schemes grid.
  FgConfigSchemeColumns := TStringList.Create;
  FgConfigSchemeColumns.AddStrings(gConfigSchemes.Selected);

  CorrectionReasonsFrame.PerformSave := SaveCorrectionReasons;
  CorrectionReasonsFrame.BehaveAsDialog := False;
end;

function TEstateSetup.FullyUpgraded : Boolean;
var
  sites : string;
begin
  with dmADO.qRun do
  begin
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('A.[Site Ref] as SiteCode, A.[Site Name] as SiteName');
    SQL.Add('FROM');
    SQL.Add('CommsVersions C, SiteAztec A');
    SQL.Add('WHERE');
    SQL.Add('C.SiteCode = A.[Site Code]');
    SQL.Add('AND');
    SQL.Add('C.DBVersion < ''2.9.1.0'' ');
    SQL.Add('AND ');
    SQL.Add('A.deleted is null or A.deleted = ''N'' ');
    Open;
  end;

  if (dmADO.qRun.RecordCount > 0) and (dmADO.qRun.RecordCount <=10) then
  begin
    dmADO.qRun.First;
    while not dmADO.qRun.Eof do
    begin
      sites := sites + dmADO.qRun.FieldByName('SiteCode').AsString + #9 + ' - ' +dmADO.qRun.FieldByName('SiteName').AsString + #13#10;
      dmADO.qRun.Next;
    end;
    MessageDlg('The following sites will need to be upgraded before this VAT mode can be selected:'+ #13#10
               + sites , mtWarning, [mbOK], 0);
    Result := False;
  end
  else
    if (dmADO.qRun.RecordCount > 10) then
    begin
      MessageDlg('There are more than ten sites which will need to be upgraded befroe this VAT'+ #13#10
        +'mode can be selected.' , mtWarning, [mbOK], 0);
      Result := False;
    end
    else
      Result := True;
end;


procedure TEstateSetup.cbVATModeChange(Sender: TObject);
begin
   if (cbVATMode.ItemIndex = RND_VAT) then
     if (not FullyUpgraded) then
       cbVATMode.ItemIndex := vatmode;
end;

procedure TEstateSetup.GlobalConfigsShow(Sender: TObject);
begin
  dmado.adoqrun.sql.text :=
    'select * from ThemeGlobalConfigs';
  dmado.adoqrun.open;
  vatmode := dmado.adoqrun.fieldbyname('VatMode').asinteger;
  currencyroundingfactor := dmado.adoqrun.fieldbyname('currencyroundingfactor').asinteger;
  showInclusiveTaxOnBill := dmado.adoqrun.fieldbyname('ShowInclusiveTaxOnBill').asboolean;
  printCustomerICCReceiptFirst := dmado.adoqrun.fieldbyname('PrintCustomerICCReceiptFirst').asboolean;
  omitMerchantEFTReceipt := dmado.adoqrun.fieldbyname('DisableEFTMerchantReceipt').asboolean;
  KioskPaymentMethod := dmado.adoqRun.FieldByName('KioskPaymentMethod').AsInteger;
  KioskCorrectionMethodRegular := dmado.adoqRun.FieldByName('KioskCorrectionMethodRegular').AsInteger;
  KioskCorrectionMethodClearAll := dmado.adoqRun.FieldByName('KioskCorrectionMethodClearAll').AsInteger;
  dmado.adoqrun.close;
  dmADO.adoqRun.SQL.Text := 'SELECT Name FROM ac_paymentmethod WHERE Id = ' + IntToStr(KioskPaymentMethod);
  dmADO.adoqRun.Open;
  KioskPaymentMethodName := dmado.adoqRun.FieldByName('Name').AsString;
  dmADO.adoqRun.Close;

  cmbbxKioskPaymentMethod.ItemIndex := PaymentMethodList.IndexOf(KioskPaymentMethodName);
  cmbbxKioskCorrectionMethodRegular.ItemIndex := CorrectionMethodList.IndexOfObject(TObject(KioskCorrectionMethodRegular));
  cmbbxKioskCorrectionMethodClearAll.ItemIndex := CorrectionMethodList.IndexOfObject(TObject(KioskCorrectionMethodClearAll));
  SelectedKioskPaymentMethodIndex:= cmbbxKioskPaymentMethod.ItemIndex;

  edCurrencyRoundingFactor.Text := inttostr(currencyroundingfactor);
  cbVATMode.ItemIndex := vatmode;
  cbxShowInclusiveTaxOnBill.Checked := showInclusiveTaxOnBill;
  cbxPrintCustomerICCReceiptFirst.Checked := printCustomerICCReceiptFirst;
  cbxOmitMerchantEFTReceipt.Checked := omitMerchantEFTReceipt;

  dmThemeData.qHotelDivisions.open;
  if CurrentUser.IsZonalUser then
    dmThemeData.qHotelAnalysisCodes.Open;
  dmThemeData.qScaleContainer.open;

  PopulateMainsAwayCourses;
  cmbbxCourse.Items.Assign(CourseList);

  dmado.adoqrun.close;
  dmADO.adoqrun.SQL.text := Format(
    'declare @SiteCode int '+
    'set @SiteCode = dbo.fnGetSiteCode() '+
    'exec sp_GetConfiguration @SiteCode,%s', [QuotedStr('MainsAwayInstruction')]);
  dmADO.adoqRun.Open;
  if VarIsNull(dmado.adoqrun.FieldByName('Setting').Value) then
    MainsAwayInstructionValue := 0
  else
    MainsAwayInstructionValue := dmado.adoqrun.FieldByName('Setting').Value;

  dmADO.adoqrun.Close;
  dmado.adoqrun.close;
  dmADO.adoqrun.SQL.text := Format(
    'select Id '+
    'from ac_Course c '+
    'join products p on p.CourseId = c.Id ' +
    'and p.EntityCode = %d', [MainsAwayInstructionValue]);
  dmADO.adoqRun.Open;
  if VarIsNull(  dmado.adoqrun.fieldbyname('id').Value) then
    MainsAwayCourse := 0
  else
    MainsAwayCourse := dmado.adoqrun.fieldbyname('id').AsInteger;
  dmADO.adoqrun.Close;

  PopulateMainsAwayInstructions(MainsAwayCourse, MainsAwayInstructionValue);
  cmbbxInstruction.Items.Assign(InstructionList);

  cmbbxCourse.ItemIndex := CourseList.IndexOfObject(TObject(MainsAwayCourse));
  cmbbxInstruction.ItemIndex := InstructionList.IndexOfObject(TObject(MainsAwayInstruction));

  dmado.adoqrun.close;
  dmADO.adoqrun.SQL.Clear;
  dmADO.adoqRun.SQL.Add('declare @str varchar(20) select @str =  dbo.fn_GetConfigurationSetting(' +
    QuotedStr('DaysKeepArchPromo') + ')');
  dmADO.adoqRun.SQL.Add('SELECT CASE WHEN ISNUMERIC(@str) > 0 THEN CAST(@str AS INT) ELSE 0 END as days');
  dmADO.adoqRun.Open;
  promoRetentionPeriod := dmado.adoqrun.fieldbyname('days').AsInteger;

  if promoRetentionPeriod <= 0 then
  begin
    udRetentionPeriod.Min := 0;
    udRetentionPeriod.Position := 0;
  end
  else
  begin
    udRetentionPeriod.Min := 90;

    // if outside of bounds keep promoRetentionPeriod "wrong" so it's corrected in the DB on save.
    if promoRetentionPeriod < 90 then
      udRetentionPeriod.Position := 90
    else if promoRetentionPeriod > 1096 then
      udRetentionPeriod.Position := 1096
    else
      udRetentionPeriod.Position := promoRetentionPeriod;
  end;

  cbPromoDetailsMaint.Checked := (udRetentionPeriod.Position > 0);
  edRetentionPeriod.Text := inttostr(udRetentionPeriod.Position);
  edRetentionPeriod.Enabled := cbPromoDetailsMaint.Checked;
  udRetentionPEriod.Enabled := cbPromoDetailsMaint.Checked;
  lblRetentionPEriod.Enabled := cbPromoDetailsMaint.Checked;
end;

procedure TEstateSetup.GlobalConfigsHide(Sender: TObject);
  procedure SetVATMode;
  begin
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set VatMode = %d', [cbVATMode.itemindex]);
    dmado.adoqrun.execsql;
    vatmode := cbVATMode.itemindex
  end ;

var
  tmpint, i: integer;
  savePromoRetentionPeriod: smallint;
  TempKioskCorrectionMethodRegular, TempKioskCorrectionMethodClearAll: String;
begin
  dmado.adoqrun.sql.text :=
    'if (select count(*) from themeglobalconfigs) = 0 '+
    'insert themeglobalconfigs (VatMode) values (0) ';
  dmado.adoqrun.execsql;

  if cbVATMode.itemindex <> vatmode then
  begin
    case cbVATMode.itemindex of
       STD_VAT :  begin
                     if MessageDlg('Are you sure you wish to change the VAT mode to "Simple VAT"?', mtInformation,
                                    [mbOK, mbCancel], 0) = mrOK then
                        SetVATMode;
                  end;
       NAR_VAT :  begin
                     if MessageDlg('Are you sure you wish to change the VAT mode to "Normal Accounting Rules (NAR) VAT"?'+#13#10#13#10
                                   +'Note that the ability to hide promotions from customers in not available in this mode and,'+#13#10
                                   +'IMPORTANTLY, the use of this VAT mode requires permission from the Inland Revenue.',
                                    mtInformation, [mbOK, mbCancel], 0) = mrOK then
                        SetVATMode;
                  end;

       RND_VAT :  begin
                     if MessageDlg('Are you sure you wish to change the VAT mode to "Bespoke VAT Rounding"?'+#13#10#13#10
                                   +'IMPORTANT: The use of this VAT mode requires permission from the Inland Revenue.',
                                        mtInformation, [mbOK, mbCancel], 0) = mrOK then
                        SetVATMode;
                  end;
       else
          cbVATMode.itemindex := vatmode;
    end;
  end;

  if CurrentUser.IsZonalUser then
  begin
    if dmThemeData.qHotelAnalysisCodes.State in [dsEdit, dsInsert] then
      dmThemeData.qHotelAnalysisCodes.Post;
    dmThemeData.qHotelAnalysisCodes.Close;
  end;

  tmpint := udCurrencyRoundingFactor.Position;
  if tmpint <> currencyroundingfactor then
  begin
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set currencyroundingfactor = %d', [tmpint]);
    dmado.adoqrun.execsql;
    currencyroundingfactor := tmpint;
  end;

  if cbxShowInclusiveTaxOnBill.Checked <> showInclusiveTaxOnBill then
  begin
    tmpint := integer(cbxShowInclusiveTaxOnBill.Checked);
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set ShowInclusiveTaxOnBill = %d', [tmpint]);
    dmado.adoqrun.execsql;
    showInclusiveTaxOnBill := cbxShowInclusiveTaxOnBill.Checked;
  end;

  if cbxPrintCustomerICCReceiptFirst.Checked <> printCustomerICCReceiptFirst then
  begin
    tmpint := integer(cbxPrintCustomerICCReceiptFirst.Checked);
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set PrintCustomerICCReceiptFirst = %d', [tmpint]);
    dmado.adoqrun.execsql;
    printCustomerICCReceiptFirst := cbxPrintCustomerICCReceiptFirst.Checked;
  end;

  if cbxOmitMerchantEFTReceipt.Checked <> omitMerchantEFTReceipt then
  begin
    tmpint := integer(cbxOmitMerchantEFTReceipt.Checked);
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set DisableEFTMerchantReceipt = %d', [tmpint]);
    dmado.adoqrun.execsql;
    omitMerchantEFTReceipt := cbxOmitMerchantEFTReceipt.Checked;
  end;

  if cmbbxKioskPaymentMethod.ItemIndex > 0 then
  begin
    dmado.adoqrun.sql.text := format(
      'update themeglobalconfigs set KioskPaymentMethod = %d',
             [TPaymentMethod(cmbbxKioskPaymentMethod.Items.Objects[cmbbxKioskPaymentMethod.ItemIndex]).Id]);
    dmado.adoqrun.execsql;
  end
  else
     begin
       dmado.adoqrun.sql.text := format(
          'update themeglobalconfigs set KioskPaymentMethod = NULL', []);
       dmado.adoqrun.execsql;
     end;

  TempKioskCorrectionMethodRegular := 'null';
  if cmbbxKioskCorrectionMethodRegular.ItemIndex > 0 then
    TempKioskCorrectionMethodRegular := IntToStr(Integer(cmbbxKioskCorrectionMethodRegular.Items.Objects[cmbbxKioskCorrectionMethodRegular.ItemIndex]));
  TempKioskCorrectionMethodClearAll := 'null';
  if cmbbxKioskCorrectionMethodClearAll.ItemIndex > 0 then
    TempKioskCorrectionMethodClearAll := IntToStr(Integer(cmbbxKioskCorrectionMethodClearAll.Items.Objects[cmbbxKioskCorrectionMethodClearAll.ItemIndex]));
  dmado.adoqrun.sql.text := format('update themeglobalconfigs set KioskCorrectionMethodRegular = %s, KioskCorrectionMethodClearAll = %s',
                                   [TempKioskCorrectionMethodRegular,TempKioskCorrectionMethodClearAll]);
  dmado.adoqrun.execsql;

  if cmbbxInstruction.ItemIndex > 0 then
    dmADO.adoqRun.SQL.Text := Format('exec sp_SetGlobalConfiguration ''MainsAwayInstruction'', %d',[TInstruction(cmbbxInstruction.Items.Objects[cmbbxInstruction.ItemIndex]).EntityCode])
  else
    dmADO.adoqRun.SQL.Text := 'exec sp_SetGlobalConfiguration ''MainsAwayInstruction'', NULL';
  dmADO.adoqRun.ExecSQL;

  for i := InstructionList.Count-1 downto 0 do
    InstructionList.Objects[i].Free;
  Instructionlist.Clear;
  CourseList.Clear;

  if cbPromoDetailsMaint.Checked then
  begin
    savePromoRetentionPeriod := udRetentionPeriod.Position;
  end
  else
  begin
    savePromoRetentionPeriod := 0;
  end;

  if savePromoRetentionPeriod <> promoRetentionPeriod then
  begin
    dmado.adoqrun.close;
    dmADO.adoqrun.SQL.Clear;
    dmADO.adoqRun.SQL.Add('exec sp_SetGlobalConfiguration ''DaysKeepArchPromo'', ' +
      QuotedStr(inttostr(savePromoRetentionPeriod)));
    dmado.adoqrun.ExecSql;

    if savePromoRetentionPeriod <> 0 then
      if promoRetentionPeriod <> 0 then
        Log('Changed Promotion Details archive retention to: ' + inttostr(savePromoRetentionPeriod) +
          ' days (from: ' + inttostr(promoRetentionPeriod) + ' days)')
      else
        Log('Archiving Details of Deleted Promotions was turned ON and archive retention is set to: ' +
          inttostr(savePromoRetentionPeriod) + ' days')
    else
      Log('Archiving Details of Deleted Promotions was turned OFF (from a retention period of: ' +
          inttostr(promoRetentionPeriod) + ' days)');
  end;
end;

procedure TEstateSetup.btAddDiscountClick(Sender: TObject);
begin
  Log('Button Add Discount Method clicked');
  dmADO.logTime1 := Now;
  with TEditDiscount.create(self) do
  begin
    EditingDiscount := FALSE;
    CurrDiscountId := 0;
    MinSpendDiscountItemsCount := 0;
    qTmp.FieldByName('MaximumRate').AsInteger := 100;
    LoadNoGoForDiscounts;
    InitialiseTreeView(false);
    dmADO.LogDuration('TEstateSetup Add Discount - TEditDiscount.Create and LoadData');
    if showmodal = mrOk then
    begin
      CurrDiscountId := uGenerateThemeIDs.GetNewId(scThemeDiscount);
      dmado.qdiscounts.Insert;
      dmado.qDiscounts.FieldByName('discountid').AsInteger := CurrDiscountId;
      SaveData;
      RequerySwipeCardRangeInfo;
    end;
    free;
  end;
end;

procedure TEstateSetup.btEditDiscountClick(Sender: TObject);
begin
  Log('Button Edit Discount Method clicked, Discount: ' + dmADO.qDiscountsName.AsString);
  EditOneDiscount;
end;

procedure TEstateSetup.EditOneDiscount;
begin
  dmADO.logTime1 := Now;
  if dmAdo.qDiscounts.RecordCount = 0 then
    raise Exception.Create('Please pick an item to edit first!');
  with TEditDiscount.Create(self) do
  begin
    EditingDiscount := TRUE;
    CurrDiscountId := dmado.qDiscounts.FieldByName('discountid').AsInteger;
    SingleItemDiscount := dmado.qDiscounts.FieldByName('AppliesToOrderLineFamily').AsBoolean;
    LoadData;
    InitialiseTreeView(false);
    dmADO.LogDuration('TEstateSetup Edit Discount - TEditDiscount.Create and LoadData');
    if ShowModal = mrOk then
    begin
      SaveData;
      RequerySwipeCardRangeInfo;
    end;
    Free;
  end;
end;

procedure TEstateSetup.btDeleteDiscountClick(Sender: TObject);
var
  DiscountID: Integer;
begin
  Log('Button Delete Discount Method clicked');

  if dmADO.qDiscounts.RecordCount = 0 then
    raise Exception.Create('Please pick an item to delete first!');

  if MessageDlg(Format('Are you sure you want to delete "%s"?', [dmADO.qDiscounts.FieldByName('Name').AsString]),
    mtconfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Log('The user has confirmed deletion of Discount: ' + dmADO.qDiscountsName.AsString);

  DiscountID := dmADO.qDiscounts.FieldByName('DiscountID').AsInteger;

  with dmADO.qRun do
  begin
    SQL.Clear;
    SQL.Add('SELECT [ButtonID]');
    SQL.Add('FROM [dbo].[ThemePanelButton]');
    SQL.Add('WHERE [ButtonTypeChoiceID] = ');
    SQL.Add('(');
    SQL.Add('   SELECT [ID]');
    SQL.Add('   FROM [dbo].[ThemeButtonTypeChoiceLookup]');
    SQL.Add('   WHERE [Name] = ''ApplyBillDiscount''');
    SQL.Add(')');
    SQL.Add('AND [ButtonTypeChoiceAttr01] = ' + QuotedStr(IntToStr(DiscountID)));
    Open;

    if RecordCount > 0 then
    begin
      if MessageDlg(Format('Warning! This discount is used %d time(s) in panel designs.' + #13 +
        'Press OK to remove this discount anyway.', [RecordCount]), mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel then
        Exit;

      Log('Discount ' + dmADO.qDiscountsName.AsString + ' is used in panel designs, user has confirmed deletion');

      Close;
      SQL.Clear;
      SQL.Add('DELETE [dbo].[ThemePanelButton]');
      SQL.Add('WHERE [ButtonTypeChoiceID] = ');
      SQL.Add('(');
      SQL.Add('   SELECT [ID]');
      SQL.Add('   FROM [dbo].[ThemeButtonTypeChoiceLookup]');
      SQL.Add('   WHERE [Name] = ''ApplyBillDiscount''');
      SQL.Add(')');
      SQL.Add('AND [ButtonTypeChoiceAttr01] = ' + QuotedStr(IntToStr(DiscountID)));
      ExecSQL;
    end
    else
      Close;

    SQL.Clear;
    SQL.Add('DELETE FROM [dbo].[ThemeDiscountCardSecurity]');
    SQL.Add('WHERE [DiscountID] = ' + IntToStr(DiscountID));
    ExecSQL;

    SQL.Clear;
    SQL.Add('DELETE FROM [dbo].[ThemeDiscountItems]');
    SQL.Add('WHERE [DiscountID] = ' + IntToStr(DiscountID));
    ExecSQL;

    SQL.Clear;
    SQL.Add('SET NOCOUNT ON;');
    SQL.Add('BEGIN TRY');
    SQL.Add('  DELETE ac_ClmSiteDiscount ');
    SQL.Add('  WHERE DiscountID = ' + IntToStr(DiscountID));
    SQL.Add('END TRY');
    SQL.Add('BEGIN CATCH');
    SQL.Add('  EXEC ac_spRethrowError');
    SQL.Add('END CATCH');
    ExecSQL;
  end;

  dmADO.qDiscounts.Delete;
end;

procedure TEstateSetup.btnSecurityRangesClick(Sender: TObject);
begin
  uSwipeCardRanges.ShowSwipeCardRanges(false);
end;

procedure TEstateSetup.RequerySwipeCardRangeInfo;
var
  SelectedDiscountID : Integer;
begin
 {The number of discounts is calculated using a sub select of the detail table
  and as such is not directly updated when we post the other changes, it needs
  to requeried, this is the same as a close and open statment}
  with dmADO.qDiscounts do
  begin
    SelectedDiscountID := FieldByName('DiscountID').AsInteger;
    Requery([]);
    Locate('DiscountID',SelectedDiscountID,[]);
  end;
end;

procedure TEstateSetup.btAddHotelDivisionClick(Sender: TObject);
const
  MAX_HOTEL_DIVISION_NAME = 25;
  MAX_HOTEL_DIVISION = 35;
var
  NewHotelDivisionID : integer;
  TrimmedName, TrimmedDescription: String;
begin
  with dmThemeData.qHotelDivisions do
  begin
    // Get next available hotel division ID
    dmThemeData.adoqRun.SQL.Text := format(
      'declare @Counter int '+#13+
      'set @Counter = 1 '+#13+
      'while (@Counter <=%d) and exists(select * from ThemeHotelDivision where HotelDivisionID = @Counter)  '+#13+
      'begin '+#13+
      '  set @Counter = @Counter + 1 '+#13+
      'end '+#13+
      'if @Counter > %d  '+#13+
      '  set @Counter = -1 '+#13+
      'select @Counter as NewID', [MAX_HOTEL_DIVISION, MAX_HOTEL_DIVISION]);
    dmThemeData.adoqRun.open;
    NewHotelDivisionID := dmThemeData.adoqrun.fieldbyname('NewID').asinteger;
    dmThemeData.adoqRun.Close;

    // Raise error if no more hotel division ids available
    if NewHotelDivisionID = -1 then
      raise Exception.create('The maximum number of hotel divisions have already been defined.');

    // Allow user to edit name and save the division details (unless they cancel)
    with TEditGenericDetails.Create(nil) do try
      HelpContext := 5050;
      Caption := 'New Hotel Division';
      lbName.Caption := 'Hotel Division name';
      edName.MaxLength := MAX_HOTEL_DIVISION_NAME;
      edName.Text := format('HotelDiv%d', [NewHotelDivisionID]);
      mmDescription.MaxLength := MAX_HOTEL_DIVISION_NAME;
      mmDescription.Height := edName.Height;
      if ShowModal = mrOK then
      begin
        TrimmedName := Trim(edName.Text);
        TrimmedDescription := Trim(mmDescription.Text);
        InsertRecord([NewHotelDivisionID, TrimmedName, TrimmedDescription]);
      end;
    finally
      free;
    end;
  end;
end;

procedure TEstateSetup.btEditHotelDivisionClick(Sender: TObject);
var
  TrimmedName, TrimmedDescription: String;
begin
  if dmThemeData.qHotelDivisions.RecordCount < 1 then
    raise Exception.create('Please pick a record to edit first!');
  with TEditGenericDetails.Create(nil) do try
    HelpContext := 5050;
    Caption := 'Edit Hotel Division';
    lbName.Caption := 'Hotel Division name';
    edName.MaxLength := 25;
    edName.text := dmThemeData.qHotelDivisions.fieldbyname('name').asstring;
    mmDescription.MaxLength := 25;
    mmDescription.Height := edName.Height;
    mmDescription.Text := dmThemeData.qHotelDivisions.FieldByName('Description').AsString;
    if showmodal = mrok then
    begin
      TrimmedName := Trim(edName.Text);
      TrimmedDescription := Trim(mmDescription.Text);
      dmThemeData.qHotelDivisions.Edit;
      dmThemeData.qHotelDivisions.fieldbyname('name').asstring := TrimmedName;
      dmThemeData.qHotelDivisions.FieldByName('Description').AsString := TrimmedDescription;
      dmThemeData.qHotelDivisions.Post;
    end;
  finally
    free;
  end;
end;

procedure TEstateSetup.btDeleteHotelDivisionClick(Sender: TObject);
begin
  if dmThemeData.qHotelDivisions.RecordCount < 1 then
    raise Exception.create('Please pick a record to delete first!');
  with dmThemeData.adoqRun do
  begin
    sql.text := format('select count(*) from themeconfigsetsubcategory a '+
      'where a.hoteldivision = %d', [
      dmThemeData.qHotelDivisions.fieldbyname('HotelDivisionID').asinteger
    ]);
    open;
    if fields[0].asinteger > 0 then
    begin
      close;
      raise Exception.create('The selected hotel division is still used in some config sets. Please remove it first.');
    end;
    close;
  end;
  dmThemeData.qHotelDivisions.Delete;
end;

procedure TEstateSetup.btnTerminalGraphicsClick(Sender: TObject);
var
  SavedCurrentDir: string;
begin
  if not assigned(TerminalGraphics) then
  begin
    SavedCurrentDir := GetCurrentDir;
    TerminalGraphics := TTerminalGraphics.Create(Self);
    TerminalGraphics.ShowModal;
    FreeAndNil(TerminalGraphics);
    if GetCurrentDir <> SavedCurrentDir then
      SetCurrentDir(SavedCurrentDir);
  end;
end;

procedure TEstateSetup.btAddAnalysisCodeClick(Sender: TObject);
const
  MAX_ANALYSIS_CODE = 30;
var
  NewAnalysisCodeID : integer;
  theStoredProc: TADOStoredProc;
  TrimmedName: String;
begin
  // get the next Unique ID
  theStoredProc := TADOStoredProc.Create(Nil);
  with theStoredProc do
  try
    Connection := dmADO.AztecConn;
    CommandTimeout := 0;
    ProcedureName := 'GetNextUniqueID';
    Parameters.Refresh;
    Parameters.ParamByName('@TableName').Value := 'HotelCodes';
    Parameters.ParamByName('@IdField').Value := 'ID';
    Parameters.ParamByName('@RangeMin').Value := 1;
    Parameters.ParamByName('@RangeMax').Value := 2147483647;
    Parameters.ParamByName('@NextID').Value := -1;
    ExecProc;
    NewAnalysisCodeID := Parameters.ParamByName('@NextID').Value;
    if NewAnalysisCodeID = -1 then
    begin
      Log('Error adding Hotel Analysis Code: Stored proc GetNextProductID failed with unknown error');
      raise Exception.Create('Error adding Hotel Analysis Code: Stored proc GetNextProductID failed with unknown error');
    end;

    with TEditHotelAnalysisCode.Create(nil) do
    try
      Caption := 'New Hotel Analysis Code';
      edName.MaxLength := MAX_ANALYSIS_CODE;
      edName.Text := format('Code%d', [NewAnalysisCodeID]);
      CodeID := NewAnalysisCodeID;
      lbDescription.Visible := FALSE;
      mmDescription.Visible := FALSE;

      if ShowModal = mrOK then
      begin
        try
          TrimmedName := Trim(edName.Text);
          with dmThemeData.qHotelAnalysisCodes do
          begin
            Insert;
            FieldByName('ID').AsInteger := NewAnalysisCodeID;
            FieldByName('SiteID').AsInteger := SiteCode;
            FieldByName('Package').AsString := 'RezLynx';
            FieldByName('Code').AsString := TrimmedName;
            Post;
          end;
        except
          on E: Exception do
          begin
            Log('Error inserting new HotelAnalysisCode: ' + E.Message);
            raise;
          end;
        end;
      end;
    finally
      free;
    end;
  finally
    FreeAndNil(theStoredProc);
  end;
end;

procedure TEstateSetup.btEditAnalysisCodeClick(Sender: TObject);
var
  TrimmedName: String;
begin
  if dmThemeData.qHotelAnalysisCodes.RecordCount < 1 then
    raise Exception.create('Please pick a record to edit first!');

  with TEditHotelAnalysisCode.Create(nil) do
  try
    Caption := 'Edit Hotel Analysis Code';
    edName.MaxLength := 30;
    edName.text := dmThemeData.qHotelAnalysisCodes.FieldByName('Code').AsString;
    CodeID := dmThemeData.qHotelAnalysisCodes.FieldByName('ID').AsInteger;
    lbDescription.Visible := FALSE;
    mmDescription.Visible := FALSE;

    if ShowModal = mrOk then
    begin
      TrimmedName := Trim(edName.Text);
      with dmThemeData.qHotelAnalysisCodes do
      begin
        Edit;
        FieldByName('Code').AsString := TrimmedName;
        Post;
      end;
    end;
  finally
    free;
  end;
end;

procedure TEstateSetup.btDeleteAnalysisCodeClick(Sender: TObject);
begin
  if dmThemeData.qHotelAnalysisCodes.RecordCount < 1 then
    raise Exception.Create('Please pick a record to edit first!');

  with dmThemeData.adoqRun do
  try
    SQL.Text := Format('SELECT COUNT(*) FROM HotelCodesAllocation WHERE HotelCodeID = %d',
                       [dmThemeData.qHotelAnalysisCodes.FieldByName('ID').asinteger]);
    Open;
    if Fields[0].AsInteger > 0 then
    begin
      if MessageDlg(QuotedStr(dmThemeData.qHotelAnalysisCodes.FieldByName('Code').AsString) +
                 ' is used in one or more hotel divisions.  Do you want to continue with the deletion?',
                 mtConfirmation,[mbYes, mbNo],0) = mrNo then
        Exit;
    end;
  finally
    Close;
  end;

  dmThemeData.qHotelAnalysisCodes.Delete;
end;

procedure TEstateSetup.btnAddScaleContainerClick(Sender: TObject);
var
  NewScaleContainerID : integer;
  theStoredProc: TADOStoredProc;
  TrimmedName: String;
  TrimmedDesc: String;
begin
  // get the next Unique ID
  theStoredProc := TADOStoredProc.Create(Nil);
  with theStoredProc do
  try
    Connection := dmADO.AztecConn;
    CommandTimeout := 0;
    ProcedureName := 'GetNextUniqueID';
    Parameters.Refresh;
    Parameters.ParamByName('@TableName').Value := 'ThemeScaleContainer_repl';
    Parameters.ParamByName('@IdField').Value := 'ContainerId';
    Parameters.ParamByName('@RangeMin').Value := 1;
    Parameters.ParamByName('@RangeMax').Value := 2147483647;
    Parameters.ParamByName('@NextID').Value := -1;
    ExecProc;
    NewScaleContainerID := Parameters.ParamByName('@NextID').Value;
    if NewScaleContainerID = -1 then
    begin
      Log('Error adding Scale Container: Stored proc GetNextUniqueID failed with unknown error');
      raise Exception.Create('Error adding Scale Container: Stored proc GetNextUniqueID failed with unknown error');
    end;

    with TEditScaleContainer.Create(nil) do
    try
      Caption := 'New Scale Container';
      ContainerID := NewScaleContainerID;

      if ShowModal = mrOK then
      begin
        try
          TrimmedName := Trim(edtContainerName.Text);
          TrimmedDesc := Trim(memoDesc.Text);
          with dmThemeData.qScaleContainer do
          begin
            Insert;
            FieldByName('ContainerId').AsInteger := NewScaleContainerID;
            FieldByName('Name').AsString := TrimmedName;
            FieldByName('Description').AsString := TrimmedDesc;
            FieldByName('TareWeight').AsFloat := StrToFloat(edtTareWeight.Text);
            Post;
          end;
        except
          on E: Exception do
          begin
            Log('Error inserting new ThemeScaleContainer: ' + E.Message);
            raise;
          end;
        end;
      end;
    finally
      free;
    end;
  finally
    FreeAndNil(theStoredProc);
  end;
end;

procedure TEstateSetup.btnEditScaleContainerClick(Sender: TObject);
begin
  EditScaleContainer;
end;

procedure TEstateSetup.EditScaleContainer;
var
  TrimmedName: String;
  TrimmedDesc: String;
begin
  if dmThemeData.qScaleContainer.RecordCount < 1 then
    raise Exception.create('Please pick a record to edit.');

  with TEditScaleContainer.Create(nil) do
  try
    Caption := 'Edit Scale Container';
    edtContainerName.text := dmThemeData.qScaleContainer.FieldByName('Name').AsString;
    memoDesc.Text := dmThemeData.qScaleContainer.FieldByName('Description').AsString;
    edtTareWeight.Text := dmThemeData.qScaleContainer.FieldByName('TareWeight').AsString;

    if ShowModal = mrOk then
    begin
      TrimmedName := Trim(edtContainerName.Text);
      TrimmedDesc := Trim(memoDesc.Text);
      with dmThemeData.qScaleContainer do
      begin
        Edit;
        FieldByName('Name').AsString := TrimmedName;
        FieldByName('Description').AsString := TrimmedDesc;
        FieldByName('TareWeight').AsFloat := StrToFloat(edtTareWeight.Text);
        Post;
      end;
    end;
  finally
    free;
  end;
end;

procedure TEstateSetup.btnDeleteScaleContainerClick(Sender: TObject);
var
  DeletionDialog: TScaleContainerDeletionDialog;
begin
  if dmThemeData.qScaleContainer.RecordCount < 1 then
    raise Exception.Create('Please pick a record to delete.');

  with dmThemeData.adoqRun do
  try
    SQL.Clear;
    SQL.Add('SELECT COUNT(*)');
    SQL.Add('FROM Products p');
    SQL.Add('JOIN Portions po');
    SQL.Add('on p.EntityCode = po.EntityCode');
    SQL.Add('WHERE po.ContainerId = ' + dmThemeData.qScaleContainer.FieldByName('ContainerId').AsString);
    SQL.Add('AND ((p.Deleted = ''N'') or (p.Deleted is null))');
    Open;
    if Fields[0].AsInteger > 0 then
    begin
      DeletionDialog := TScaleContainerDeletionDialog.Create(self);
      try
        DeletionDialog.ScaleContainerID := dmThemeData.qScaleContainer.FieldByName('ContainerId').AsInteger;
        DeletionDialog.ScaleContainerName := dmThemeData.qScaleContainer.FieldByName('Name').AsString;
        DeletionDialog.ShowModal;
      finally
        DeletionDialog.Release;
      end;
      Exit;
    end;
  finally
    Close;
  end;

  dmThemeData.qScaleContainer.Delete;
end;

procedure TEstateSetup.pgcReasonsConfigurationShow(
  Sender: TObject);
begin
  lbReasons.Clear;
  dmADO.adoqReasons.Open;
  RefreshReasons;

  if lbReasons.Items.Count = 0 then
  begin
    ReasonIndex := -1;
    lbReasons.ItemIndex := ReasonIndex;
    mmReasonEposName.Text := '';
    cbOpenReasonType.Checked := FALSE;
  end
  else
  begin
    lbReasons.ItemIndex := 0;
    lbReasonsClick(self);
  end;

  btnSaveConfiguration.Enabled := FALSE;

  lblReasonButton.Enabled := lbReasons.Items.Count > 0;
  mmReasonEposName.Enabled := lbReasons.Items.Count > 0;
  cbOpenReasonType.Enabled := lbReasons.Items.Count > 0;
end;

procedure TEstateSetup.pgcReasonsConfigurationHide(
  Sender: TObject);
begin
  SaveChangedReasons;
  dmADO.adoqReasons.Close;
end;

procedure TEstateSetup.RefreshReasons;
begin
   while not dmADO.adoqReasons.Eof do
   begin
      lbReasons.Items.Add(dmADO.adoqReasons.FieldByName('Name').AsString);
      dmADO.adoqReasons.Next;
   end;
end;

procedure TEstateSetup.btnAddReasonClick(Sender: TObject);
const
  BLANK_STRING = '''''';
var
  ReasonID : integer;
  ReasonName         : string;
begin
  SaveChangedReasons;

  Log('New Correction Reason button clicked');

  if GetReasonName(ReasonName) then
  begin
    ReasonID := uGenerateThemeIDs.GetNewId(scThemeReason);
    dmADO.qRun.SQL.Clear;
    dmADO.qRun.SQL.Text:= 'Insert into ThemeReason (ReasonID, Name, EposLine1,EposLine2, EposLine3) '+
                          'Values ( ' + inttostr(ReasonID) + ',' + QuotedStr(ReasonName) +
                          ', ' + BLANK_STRING + ', ' + BLANK_STRING + ', '+ BLANK_STRING + ' )';
    dmADO.qRun.ExecSQL;

    ReasonIndex := lbReasons.Items.Add(ReasonName);
    lbReasons.Selected[ReasonIndex] := TRUE;


    RefreshReasons;
    RefreshOptions(ReasonName);
    btnAddReason.Enabled := FALSE;
    btnSaveConfiguration.Enabled := TRUE;
    lbReasons.Enabled := FALSE;
  end;

  lblReasonButton.Enabled := lbReasons.Items.Count > 0;
  mmReasonEposName.Enabled := lbReasons.Items.Count > 0;
  cbOpenReasonType.Enabled := lbReasons.Items.Count > 0;
end;

procedure TEstateSetup.lbReasonsClick(Sender: TObject);
var
  ReasonName : string;
  ErrorMessage     : string;
begin
  try
    SaveChangedReasons;
  except on E: Exception do
    begin
      ErrorMessage := E.Message;
      lbReasons.ItemIndex := ReasonIndex;
      raise Exception.Create(ErrorMessage);
    end;
  end;

  ReasonIndex := lbReasons.ItemIndex;

  if ReasonIndex <> -1 then
  begin
    ReasonName := lbReasons.Items[ReasonIndex];
    RefreshOptions(ReasonName);
  end;

  btnSaveConfiguration.Enabled := FALSE;
end;

procedure TEstateSetup.btnSaveConfigurationClick(Sender: TObject);
var
  OpenReasonType : integer;
  ReasonName : string;
begin
  OpenReasonType := 0;
  if cbOpenReasonType.Checked then
     OpenReasonType := 1;

  ReasonName := lbReasons.Items[ReasonIndex];

  if trim(mmReasonEposName.Text) = '' then
    raise Exception.Create('Value required for Epos Button Text');

  dmADO.qRun.SQL.Clear;
  dmADO.qRun.SQL.Text := 'Update ThemeReason  Set ' +
                         'EPoSLine1 = '+ QuotedStr(mmReasonEposName.Lines[0]) +',';

  if mmReasonEposName.Lines.Count > 1 then
    dmADO.qRun.SQL.Add('EPoSLine2 = '+ QuotedStr(mmReasonEposName.Lines[1]) +',')
  else
    dmADO.qRun.SQL.Add('EPoSLine2 = '''',');

  if mmReasonEposName.Lines.Count > 2 then
    dmADO.qRun.SQL.Add('EPoSLine3 = '+ QuotedStr(mmReasonEposName.Lines[2]) +',')
  else
    dmADO.qRun.SQL.Add('EPoSLine3 = '''',');

  dmADO.qRun.SQL.Add('OpenReasonType = '+ IntToStr(OpenReasonType));
  dmADO.qRun.SQL.Add('Where [Name] = ' + QuotedStr(ReasonName));
  dmADO.qRun.ExecSQL;
  dmADO.qRun.Close;
  RefreshOptions(ReasonName);
  btnSaveConfiguration.Enabled := FALSE;
  btnAddReason.Enabled := TRUE;
  lbReasons.Enabled := TRUE;
end;

procedure TEstateSetup.mmReasonEposNameChange(Sender: TObject);
begin
  if mmReasonEposName.Lines.Count > 3 then
  begin
    mmReasonEposName.Text := mmReasonEposName.Lines[0] + mmReasonEposName.Lines[1] +
      mmReasonEposName.Lines[2] + copy(mmReasonEposName.Lines[3], 1, Length(mmReasonEposName.Lines[3]) - 1);
    mmReasonEposName.SelStart := Length(mmReasonEposName.Text);
  end;

  btnSaveConfiguration.Enabled := TRUE;
end;

procedure TEstateSetup.cbOpenReasonTypeClick(Sender: TObject);
begin
  btnSaveConfiguration.Enabled := True;
end;

procedure TEstateSetup.SaveChangedReasons;
begin
  if btnSaveConfiguration.Enabled then
  begin
    btnSaveConfigurationClick(Self);
    btnSaveConfiguration.Enabled := FALSE;
  end;
end;
  
procedure TEstateSetup.pcBaseDataChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := True;
  if pcBaseData.ActivePage = tsZcpsConfigs then
  begin
    try
      ZcpsConfigsDeInitExecute(nil);
    except on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        AllowChange := FALSE;
      end;
    end;
  end
  else
  if pcBaseData.ActivePage = pgcReasonsConfiguration then
  begin
    try
      SaveChangedReasons;
    except on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        AllowChange := FALSE;
      end;
    end;
  end
  else if pcbaseData.ActivePage = TabConfigSets then
  begin
    if dmThemeData.qConfigSets.State = dsEdit then
      dmThemeData.qConfigSets.Post;

    AllowChange := ValidateOrderDestinations;
  end;
end;

procedure TEstateSetup.RefreshOptions(ACorrectionReason : string);
begin
  cbOpenReasonType.Checked := FALSE;
  mmReasonEposName.Text := '';

  dmADO.qRun.SQL.Clear;
  dmADO.qRun.SQL.Text := 'select * from ThemeReason '+
                         'Where [Name] = '+QuotedStr(ACorrectionReason);
  dmADO.qRun.Open;

  if dmADO.qRun.FieldByName('EposLine3').AsString <> '' then
    mmReasonEposName.Text := #13#10 + dmADO.qRun.FieldByName('EposLine3').AsString;

  if dmADO.qRun.FieldByName('EposLine2').AsString <> '' then
    mmReasonEposName.Text := #13#10 + dmADO.qRun.FieldByName('EposLine2').AsString + mmReasonEposName.Text
  else if dmADO.qRun.FieldByName('EposLine3').AsString <> '' then
    mmReasonEposName.Text := #13#10 + mmReasonEposName.Text;

  if dmADO.qRun.FieldByName('EposLine1').AsString <> '' then
    mmReasonEposName.Text := dmADO.qRun.FieldByName('EposLine1').AsString + mmReasonEposName.Text;

  cbOpenReasonType.Checked := dmAdo.qRun.FieldByName('OpenReasonType').AsBoolean;

  dmADO.qRun.Close;
end;


function TEstateSetup.ValidateOrderDestinations: Boolean;
var
  ConfigSets: TStringlist;
  ErrText: String;
begin
  Result := True;

  if not uDMThemeData.OrderDestinationsEnabled then Exit;

  with dmADO.qRun do
  begin
    ConfigSets := TStringList.Create;
    try
      SQL.Clear;
      SQL.Add('SELECT distinct tcsod.configsetid, tcs.name FROM ThemeConfigSetOrderDestinations_Repl tcsod');
      SQL.Add('join ThemeConfigSet_repl  tcs on tcsod.configsetid = tcs.configsetid');
      SQL.Add('WHERE not Exists(SELECT * FROM ThemeConfigSetOrderDestinations_Repl tcsod2');
      SQL.Add('	WHERE tcsod2.configsetid = tcsod.configsetid and tcsod2.IsDefault = 1)');
      SQL.Add('AND tcs.deleted = 0');
      Open;

      While not EOF do
      begin
        ConfigSets.Add(FieldByName('Name').AsString);
        Next;
      end;

      if ConfigSets.Count > 0 then
      begin
        Result := False;

        if ConfigSets.Count = 1 then
          ErrText := Format('Configuration set %s has no default order destination.' + #13#10 +
                            'Please enter a default order destination.',
                            [ConfigSets.Delimitedtext])
        else
          ErrText := Format('The following configuration sets have no default order destination: ' + #13#10#13#10 +
                            '%s.' + #13#10#13#10 + 'Please enter default order destinations.',
                            [ConfigSets.Delimitedtext]);
        MessageDlg(Errtext,
                   mtError,
                   [mbOK],
                   0);
      end;
    finally
      ConfigSets.Free;
    end;
  end;
end;

procedure TEstateSetup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ThemeModellingMenu.ApplicationClosing then exit; //if auto close has started close without saving.

  if not ValidateOrderDestinations then
    CanClose := false
  else if Assigned(pcBaseData.ActivePage) and Assigned(pcBaseData.ActivePage.OnHide) then
    pcBaseData.ActivePage.OnHide(Self);
end;

procedure TEstateSetup.cbCorrectionMethodChange(Sender: TObject);
begin
  InitialiseCorrectionReasons;
end;

procedure TEstateSetup.cbCorrectionMethodEnter(Sender: TObject);
begin
  CorrectionReasonsFrame.SaveAnyChanges;
end;

procedure TEstateSetup.SaveCorrectionReasons;
var
  CorrectionMethodID : integer;
  CorrectionReasonID : integer;
  Index              : integer;
begin
  CorrectionMethodID := Integer(cbCorrectionMethod.Items.Objects[cbCorrectionMethod.ItemIndex]);

  dmADO.qRun.SQL.Clear;
  dmADO.qRun.SQL.Text := 'Delete from ThemeCorrectionReasonMap '+
                         'Where CorrectionMethodID = '+ IntToStr(CorrectionMethodID);
  dmADO.qRun.ExecSQL;
  for Index := 0 to (CorrectionReasonsFrame.ChosenReasons.Count - 1) do
  begin
    CorrectionReasonID := Integer(CorrectionReasonsFrame.ChosenReasons.Objects[Index]);
    dmADO.qRun.SQL.Clear;
    dmADO.qRun.SQL.Text := 'Insert into ThemeCorrectionReasonMap '+
                           '(ReasonID, CorrectionMethodID) '+
                           'Values ('+ IntToStr(CorrectionReasonID)+','+ IntToStr(CorrectionMethodID)+')';
    dmADO.qRun.ExecSQL;
  end;
end;

procedure TEstateSetup.pcBaseDataChange(Sender: TObject);
begin
  Log(pcBaseData.ActivePage.Caption + ' Tab Selected');
end;

procedure TEstateSetup.dbgScaleContainersDblClick(Sender: TObject);
begin
  EditScaleContainer;
end;

procedure TEstateSetup.tsMultiSiteOverrideShow(Sender: TObject);
begin
  dmADO.qPFOverride.active := true;
  dmADO.qSMOverride.active := true;
  dmADO.qBFOverride.Active := True;
  SMOverrideSortHelper.Reset;
  PFOverrideSortHelper.Reset;
  BFOverrideSortHelper.Reset;
end;

procedure TEstateSetup.tsMultiSiteOverrideHide(Sender: TObject);
begin
  dmADO.qPFOverride.active := false;
  dmADO.qSMOverride.active := false;
  dmADO.qBFOverride.Active := false;
end;

procedure TEstateSetup.btDeleteSMOverrideClick(Sender: TObject);
begin
  Log('Delete Scrolling message override clicked');
  if dmAdo.dsSMOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  if messagedlg(
    format('Are you sure you want to delete "%s"?', [dbgSMOverride.datasource.dataset.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    log('Deleting Scrolling message override ' + dbgSMOverride.datasource.dataset.fieldbyname('Name').asstring);
    dmado.qRun.SQL.Text := Format('update ThemeEposDevice set ScrollingMessageOverrideId = null where ScrollingMessageOverrideId = %d',
      [dbgSMOverride.datasource.dataset.fieldbyname('Id').AsInteger]);
    dmado.qRun.ExecSQL;
    dmAdo.qSMOverride.delete;
  end;
end;

procedure TEstateSetup.btAddSMOverrideClick(Sender: TObject);
begin
  Log('Add Scrolling message override clicked');
  if TTextOverrideWizard.ShowWizard(-1, -1, wmScrollingMessageOverride) then
    RefreshTextOverrides(dmADO.qSMOverride);
end;

procedure TEstateSetup.btEditSMOverrideClick(Sender: TObject);
var
  OverrideId: integer;
begin
  Log('Edit Scrolling message override clicked');
  if dmAdo.dsSMOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  OverrideId := dbgSMOverride.datasource.dataset.fieldbyname('Id').AsInteger;
  if TTextOverrideWizard.ShowWizard(OverrideId, OverrideID, wmScrollingMessageOverride) then
    RefreshTextOverrides(dmADO.qSMOverride);
end;

procedure TEstateSetup.btAddPFOverrideClick(Sender: TObject);
begin
  Log('Add Receipt footer override clicked');
  if TTextOverrideWizard.ShowWizard(-1, -1, wmStandardFooterOverride) then
    RefreshTextOverrides(dmADO.qPFOverride);

end;

procedure TEstateSetup.btEditPFOverrideClick(Sender: TObject);
var
  OverrideId: integer;
begin
  Log('Edit Receipt footer override clicked');
  if dmAdo.dsPFOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  OverrideId := dbgPFOverride.datasource.dataset.fieldbyname('Id').AsInteger;
  if TTextOverrideWizard.ShowWizard(OverrideId, OverrideID, wmStandardFooterOverride) then
    RefreshTextOverrides(dmADO.qPFOverride);
end;

procedure TEstateSetup.btDeletePFOverrideClick(Sender: TObject);
begin
  Log('Delete Receipt footer override clicked');
  if dmAdo.dsPFOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  if messagedlg(
    format('Are you sure you want to delete "%s"?', [dbgPFOverride.datasource.dataset.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    log('Deleting Receipt footer override ' + dbgPFOverride.datasource.dataset.fieldbyname('Name').asstring);
    dmado.qRun.SQL.Text := Format('update ThemeOutletStandardPrintConfigs set StandardFooterOverrideId = null where StandardFooterOverrideId = %d',
      [dbgPFOverride.datasource.dataset.fieldbyname('Id').AsInteger]);
    dmado.qRun.ExecSQL;
    dmAdo.qPFOverride.delete;
  end;
end;

procedure TEstateSetup.dbgSMOverrideDblClick(Sender: TObject);
begin
  btEditSMOverride.Click;
end;

procedure TEstateSetup.dbgPFOverrideDblClick(Sender: TObject);
begin
  btEditPFOverride.Click;
end;

procedure TEstateSetup.dbgBFOverrideDblClick(Sender: TObject);
begin
  btEditBFOverride.Click;
end;

procedure TEstateSetup.RefreshTextOverrides(DataSet: TAdoQuery);
var
  Bookmark: integer;
begin
  BookMark := DataSet.fieldbyname('Id').AsInteger;
  DataSet.Requery();
  DataSet.Locate('Id', BookMark, []);
end;

procedure TEstateSetup.FormDestroy(Sender: TObject);
begin
  SMOverrideSortHelper.Free;
  PFOverrideSortHelper.Free;
  BFOverrideSortHelper.Free;
  CorrectionMethodList.Free;
  PaymentMethodList.Free;
  CourseList.Free;
  InstructionList.Free;
end;

procedure TEstateSetup.InitialiseCorrectionReasons;
var
  CorrectionMethodId : integer;
begin
  if cbCorrectionMethod.ItemIndex = -1 then
    cbCorrectionMethod.ItemIndex := 0;
    
  CorrectionMethodId := Integer(cbCorrectionMethod.Items.Objects[cbCorrectionMethod.ItemIndex]);

  CorrectionReasonsFrame.AllReasonsSQL := Format(
    'SELECT tr.ReasonId, tr.Name, CAST(CASE WHEN tcrm.ReasonID IS NULL THEN 0 ELSE 1 END as BIT) as Used ' +
    'FROM ThemeReason tr LEFT OUTER JOIN ThemeCorrectionReasonMap tcrm on ' +
       'tr.ReasonId = tcrm.ReasonID AND tcrm.CorrectionMethodID = %0:d',
    [CorrectionMethodId]);

  if dmADO.IsMatchDayStockEnabled() = True then
    CorrectionReasonsFrame.MaximumAssignedReasonCount := MAXIMUM_ASSIGNED_REASON_COUNT_WITH_MATCH_DAY_STOCK;

  CorrectionReasonsFrame.Initialise;
end;

procedure TEstateSetup.cmbbxKioskPaymentMethodSelect(Sender: TObject);
begin
 if TPaymentMethod(cmbbxKioskPaymentMethod.Items.Objects[cmbbxKioskPaymentMethod.ItemIndex]).UsedOnPanel then
 begin
   MessageDlg(cmbbxKioskPaymentMethod.Text + ' cannot be selected because it has a button on at least one theme panel design.',
      mtInformation, [mbOK],0);
   cmbbxKioskPaymentMethod.ItemIndex := SelectedKioskPaymentMethodIndex;
 end
 else
   SelectedKioskPaymentMethodIndex := cmbbxKioskPaymentMethod.ItemIndex;
end;

{ TPaymentMethod }

constructor TPaymentMethod.Create(paymentMethodId: Integer; onPanel: Boolean);
begin
  inherited create;
  Id := paymentMethodId;
  UsedOnPanel := onPanel;
end;

procedure TEstateSetup.btAddBFOverrideClick(Sender: TObject);
begin
  Log('Add Bill footer override clicked');
  if TTextOverrideWizard.ShowWizard(-1, -1, wmBillFooterOverride) then
    RefreshTextOverrides(dmADO.qBFOverride);
end;

procedure TEstateSetup.btEditBFOverrideClick(Sender: TObject);
var
  OverrideId: integer;
begin
  Log('Edit Bill footer override clicked');
  if dmAdo.dsBFOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  OverrideId := dbgBFOverride.datasource.dataset.fieldbyname('Id').AsInteger;
  if TTextOverrideWizard.ShowWizard(OverrideId, OverrideID, wmBillFooterOverride) then
    RefreshTextOverrides(dmADO.qBFOverride);
end;

procedure TEstateSetup.btDeleteBFOverrideClick(Sender: TObject);
begin
  Log('Delete Bill footer override clicked');
  if dmAdo.dsBFOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  if messagedlg(
    format('Are you sure you want to delete "%s"?', [dbgBFOverride.datasource.dataset.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    log('Deleting Bill footer override ' + dbgBFOverride.datasource.dataset.fieldbyname('Name').asstring);
    dmado.qRun.SQL.Text := Format('update ThemeOutletStandardPrintConfigs set BillFooterOverrideId = null where BillFooterOverrideId = %d',
      [dbgbFOverride.datasource.dataset.fieldbyname('Id').AsInteger]);
    dmado.qRun.ExecSQL;
    dmAdo.qBFOverride.delete;
  end;
end;

procedure TEstateSetup.btnAddClockoutTicketFooterOverrideClick(
  Sender: TObject);
begin
  Log('Add clockout ticket footer override clicked');
  if TTextOverrideWizard.ShowWizard(-1, -1, wmClockoutticketFooterOverride) then
    RefreshTextOverrides(dmADO.qClockoutTicketFooterOverride);
end;

procedure TEstateSetup.btnEditClockoutTicketFooterOverrideClick(
  Sender: TObject);
var
  OverrideID: Integer;
begin
  Log('Edit clockout ticket footer override clicked');
  if dmADO.dsClockoutTicketFooterOverride.DataSet.RecordCount < 1 then
    raise Exception.Create('Please add some items first!');
  OverrideId := dbgrdClockouttocketFooterOverrides.datasource.dataset.fieldbyname('Id').AsInteger;
  if TTextOverrideWizard.ShowWizard(OverrideId, OverrideID, wmClockoutTicketFooterOverride) then
    RefreshTextOverrides(dmADO.qClockoutTicketFooterOverride);
end;

procedure TEstateSetup.btnDeleteClockoutTicketFooterOverrideClick(
  Sender: TObject);
var
  ConfirmationText: String;
  UseCount: Integer;
begin
  Log('Delete clockout ticket footer override clicked');
  if dbgrdClockouttocketFooterOverrides.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a clockout ticket footer to delete first');

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Text := Format('select isnull(count(*),0) as UseCount from ac_role where ClockOutTicketFooterId = %d', [dmado.qClockoutTicketFooterOverrideID.AsInteger]);
    Open;

    useCount := FieldByName('UseCount').AsInteger;

    if UseCount > 0 then
      ConfirmationText := Format('"%s" is mapped to one or more front of house roles. ' + #13#10 +
                                 'Proceed with deletion and revert the affected roles to the standard footer text?',[dmADO.qClockoutTicketFooterOverrideName.AsString])
    else
      ConfirmationText := Format('Are you sure you want to delete "%s"?',[dmADO.qClockoutTicketFooterOverrideName.AsString]);

    if MessageDlg(ConfirmationText, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Log('Deleting clockout ticket footer - ' + dmADO.qClockoutTicketFooterOverride.FieldByName('ID').AsString);
      SQL.Clear;
      SQL.Add(Format('delete ThemeClockOutTicketFooterOverride where ID = %d',
        [dbgrdClockouttocketFooterOverrides.DataSource.Dataset.FieldByName('ID').AsInteger]));
      if UseCount > 0 then
        SQL.Add(Format('update ac_Role set ClockOutTicketFooterId = 1 where ClockOutTicketFooterId = %d',[dmADO.qClockoutTicketFooterOverrideID.AsInteger]));
      ExecSQL;
      dmADO.qClockoutTicketFooterOverride.Delete;
    end;
  end;
end;

procedure TEstateSetup.dbgrdClockouttocketFooterOverridesDblClick(
  Sender: TObject);
begin
  btnEditClockoutTicketFooterOverride.Click;
end;

procedure TEstateSetup.tsReportOverridesShow(Sender: TObject);
begin
  dmADO.qClockoutTicketFooterOverride.active := true;
end;

procedure TEstateSetup.tsReportOverridesHide(Sender: TObject);
begin
  dmADO.qClockoutTicketFooterOverride.active := false;
end;

procedure TEstateSetup.tsDiscountsShow(Sender: TObject);
begin
  dmado.qDiscounts.close;
  dmado.qDiscounts.open;
  gDiscounts.SetFocus;
end;

procedure TEstateSetup.tsDiscountsHide(Sender: TObject);
begin
  if dmado.qDiscounts.State in [dsEdit, dsInsert] then
    dmado.qDiscounts.post;
  dmado.qDiscounts.close;
end;

procedure TEstateSetup.PopulateMainsAwayCourses;
begin
  CourseList.Clear;
  with dmADO.qRun do
  try
    Close;
    SQL.Text :=
      'SELECT NULL AS ID, '''' AS Name ' +
      '  UNION ' +
      'SELECT Id, Name ' +
      'FROM ' +
      '  ac_Course';
    Open;
    while not EOF do
    begin
      CourseList.AddObject(FieldByName('Name').AsString,
        TObject(FieldByName('ID').AsInteger));
      Next;
    end
  finally
    Close;
  end;
end;

procedure TEstateSetup.PopulateMainsAwayInstructions(CourseID: Integer; MainsAwayInstructionValue: LargeInt);
var
  i: integer;
  TempInstruction: TInstruction;
begin
  if Assigned(InstructionList) then
    for i := InstructionList.Count-1 downto 0 do
       InstructionList.Objects[i].Free;

  InstructionList.Clear;
  with dmADO.qRun do
  try
    Close;
    SQL.Text :=
      'SELECT cast(NULL as bigint) AS EntityCode, '''' AS Name ' +
      '  UNION ' +
      'SELECT Cast(EntityCode as bigint), [Extended RTL Name] as Name ' +
        'FROM Products ' +
        'WHERE CourseID = ' + IntToStr(CourseID) + ' and [Entity Type] = ''Instruct.''';
    Open;
    while not EOF do
    begin
      TempInstruction := TInstruction.Create(TLargeIntField(FieldByName('EntityCode')).AsLargeInt,FieldByName('Name').AsString);
      InstructionList.AddObject(FieldByName('Name').AsString, TempInstruction);

      if (MainsAwayInstructionValue = TempInstruction.EntityCode) then
        MainsAwayInstruction := TempInstruction;
      Next;
    end
  finally
    Close;
  end;
end;

procedure TEstateSetup.cmbbxCourseCloseUp(Sender: TObject);
var
  NewMainsAwayCourse: Integer;
begin
  NewMainsAwayCourse := Integer(cmbbxCourse.items.objects[cmbbxCourse.ItemIndex]);
  if (NewMainsAwayCourse <> MainsAwayCourse) then
  begin
    MainsAwayCourse := NewMainsAwayCourse;
    PopulateMainsAwayInstructions(MainsAwayCourse);
    cmbbxInstruction.Items.Assign(InstructionList);
    MainsAwayInstructionValue := -1;
    MainsAwayInstruction := nil;
    cmbbxInstruction.ItemIndex := 0;
  end;
end;

procedure TEstateSetup.cmbbxInstructionCloseUp(Sender: TObject);
begin
  if cmbbxInstruction.ItemIndex <> -1 then
  begin
    MainsAwayInstruction := TInstruction(cmbbxInstruction.items.objects[cmbbxInstruction.ItemIndex]);
    MainsAwayInstructionValue := MainsAwayInstruction.EntityCode;
  end;
end;

{ TInstruction }

constructor TInstruction.Create(InstructionEntityCode: LargeInt; InstructionName: String);
begin
  inherited create;
  EntityCode := InstructionEntityCode;
  Name := InstructionName;
end;

procedure TEstateSetup.ZcpsConfigsClearLookupData;
var
  i: integer;
begin
  // TwwDBGrid is missing the required notifications for it
  // to successfully free up the CurrentCustomEdit - was obviously
  // only written to support design time setting of custom edit controls.
  TwwDBGridHack(dbgVariationGrid).currentcustomedit := nil;

  dbgVariationGrid.DataSource.DataSet.Cancel;
  dbgVariationGrid.Selected.Clear;
  for i := Low(ColumnLookupData) to high(ColumnLookupData) do
  with ColumnLookupData[i] do
  begin
    if ColumnID <> 0 then
    begin
      LookupQuery.Active := false;
      ColumnID := 0;
      LookupControl.Parent := nil;
      Self.RemoveControl(LookupControl);
      dbgVariationGrid.DataSource.DataSet.Fields.Remove(LookupField);
      dbgVariationGrid.DataSource.DataSet.Fields.Remove(DataField);
      LookupField.Free;
      DataField.Free;
      LookupQuery.Free;
      LookupControl.Free;
    end;
  end;
  SetLength(ColumnLookupData, 0);
end;

procedure TEstateSetup.ZcpsConfigsHandleDatasetAfterEdit(Sender: TDataset);
begin
  ZcpsConfigsDataModified := True;
end;

procedure TEstateSetup.ZcpsConfigsPostChanges;
begin
  If dmThemeData.qEditSiteVariations.State in [dsInsert, dsEdit] then
    dmThemeData.qEditSiteVariations.Post;
end;

procedure TEstateSetup.ZcpsConfigsPromptSaveChanges;
begin
  if dmThemeData.qEditZcpsConfigs.Active then
  begin
    ZcpsConfigsPostChanges;
    if ZcpsConfigsDataModified then
      if MessageDlg('Save changes?', mtConfirmation, [mbYes, MbNo], 0) = mrYes then
        ZcpsConfigsSave.Execute
      else
        ZcpsConfigsDataModified := false;
  end;
end;

function TEstateSetup.AddSpaceToCamelCase(input: string): string;
var
  TempResult: string;
  OutLength, i: integer;
const
  UpperCaseSubstitutions: array[1..7] of string = ('Eft', 'Ats', 'Zcps', 'Pcc', 'Pc', 'Rfm', 'Dpg');
begin
  OutLength := 0;
  SetLength(TempResult, Length(input)*2);
  for i := 1 to Length(input) do
  begin
    if (i > 1) and (
        (useful.IsNumeric(input[i-1]) and not useful.IsNumeric(input[i]))
      or
        (not useful.IsNumeric(input[i-1]) and useful.IsNumeric(input[i]))
      or
        (not useful.IsNumeric(input[i]) and (input[i] = UpCase(input[i])))
      ) then
    begin
      Inc(OutLength);
      TempResult[OutLength] := ' ';
    end;
    Inc(OutLength);
    TempResult[OutLength] := input[i];
  end;
  SetLength(TempResult, OutLength);

  for i := Low(UpperCaseSubstitutions) to High(UpperCaseSubstitutions) do
  begin
    if Pos(UpperCaseSubstitutions[i], TempResult) <> -1 then
    begin
      TempResult := StringReplace(TempResult, UpperCaseSubstitutions[i], UpperCase(UpperCaseSubstitutions[i]), [rfReplaceAll]);
    end;
  end;
  result := TempResult;
end;

procedure TEstateSetup.ZcpsConfigsInitExecute(Sender: TObject);
var
  TmpSummary: TVariationSummary;
  i: integer;
  CWidth: integer;
  bmk: Pointer;
  ScriptName: string;
begin
  dmThemeData.BeginHourglass;
  if (dmThemeData.qEditZcpsConfigs.Active) then
  begin
    Bmk := dmThemeData.qEditZcpsConfigs.GetBookmark;
    dmThemeData.qEditZcpsConfigs.Active := false;
  end
  else
    Bmk := nil;

  try
    with dmThemeData.qInitZcpsConfigs, TmpSummary do
    begin
      if CurrentUser.IsZonalUser then
        SQL[2] := 'set @IsSecureUser = 1'
      else
        SQL[2] := 'set @IsSecureUser = 0';
      Open;

      with dmThemeData.qInitZcpsConfigsGetSummary do
      begin
        open;
        VarCount := FieldByName('ColCount').AsInteger;
        VarChecksum := FieldByName('ColChecksum').AsInteger;
        VarPanelCount := FieldByName('ValCount').AsInteger;
        VarPanelChecksum := FieldByName('ValChecksum').AsInteger;
        close;
      end;

      if VarCount = 0 then
      begin
        lbZcpsConfigsTitle.Caption := 'No ZCPS configs available.';
        dmThemeData.qInitZcpsConfigs.Close;
        dbgVariationGrid.Visible := false;
        exit;
      end;

      // Check for changes to variation data, prevents having to redo schema
      // manipulation of temporary editing table
      if (TmpSummary.VarCount <> VariationSummary.VarCount)
        or (TmpSummary.VarChecksum <> VariationSummary.VarChecksum)
        or (TmpSummary.VarPanelCount <> VariationSummary.VarPanelCount)
        or (TmpSummary.VarPanelChecksum <> VariationSummary.VarPanelChecksum) then
      begin

        // Process display names where not defined in qInitZcpsConfigs
        with dmThemeData.adoqRun do
        begin
          SQL.Text := 'select * from #ZcpsMetaConfigColumns';
          Open;
          while not EOF do
          begin
            if FieldByName('DisplayName').IsNull then
            begin
              Edit;
              FieldByName('DisplayName').AsString := AddSpaceToCamelCase(FieldByName('Name').AsString);
              Post;
            end;
            Next;
          end;
          Close;
        end;

        with dmThemeData.adoqRun do
        begin
          SQL.Text := 'select * from #ZcpsMetaConfigValues';
          Open;
          while not EOF do
          begin
            if FieldByName('DisplayName').IsNull then
            begin
              Edit;
              FieldByName('DisplayName').AsString := AddSpaceToCamelCase(FieldByName('Name').AsString);
              Post;
            end;
            Next;
          end;
          Close;
        end;

        ZcpsConfigsClearLookupData;

        ZcpsConfigsDropSQL := '';
        ZcpsConfigsCreateSQL := '';
        ZcpsConfigsLoadSQL := '';
        ZcpsConfigsSaveSQL := '';

        while not EOF do
        begin
          ScriptName := FieldByName('ScriptName').AsString;
          if ScriptName = 'DropSQL' then
            ZcpsConfigsDropSQL := ZcpsConfigsDropSQL + FieldByName('SQL').AsString;
          if ScriptName = 'CreateSQL' then
            ZcpsConfigsCreateSQL := ZcpsConfigsCreateSQL + FieldByName('SQL').AsString;
          if ScriptName = 'LoadSQL' then
            ZcpsConfigsLoadSQL := ZcpsConfigsLoadSQL + FieldByName('SQL').AsString;
          if ScriptName = 'SaveSQL' then
            ZcpsConfigsSaveSQL := ZcpsConfigsSaveSQL + FieldByName('SQL').AsString;
          Next;
        end;
        Close;

        // setup display/pick lists in grid
        with dbgVariationGrid do
        begin
          CWidth := Canvas.TextWidth('0');
          Selected.Clear;
          Selected.Add('SiteName'+#9'20'#9+'Site Name');
          Selected.Add('SiteRef'#9'10'#9'Site Ref');
          Selected.Add('AreaName'#9'20'#9'Area Name');

          with dmThemeData.adoqRun do
          begin
            SQL.Text := 'select * from #ZcpsMetaConfigColumns order by ColumnID';
            Open;
            SetLength(ColumnLookupData, RecordCount);
            while not (EOF) do
            with ColumnLookupData[FieldByName('ColumnID').AsInteger-1] do
            begin
              ColumnID := FieldByName('ColumnID').AsInteger;
              ColumnName := FieldByName('DisplayName').AsString;
              FieldName := Format('CrossTabColumn%d', [ColumnID]);
              LookupQuery := TADOQuery.Create(self);
              LookupQuery.Connection := dmThemeData.AztecConn;
              LookupQuery.SQL.Text := Format('select ValueID, Name, DisplayName from #ZcpsMetaConfigValues where ColumnID = %d order by Name', [ColumnID]);
              DisplaySizePixels := Canvas.TextWidth(ColumnName);
              LookupQuery.Open;
              while not LookupQuery.Eof do
              begin
                // Uses RowHeights[0] as an estimate of the combobox dropdown button width
                DisplaySizePixels := Max(DisplaysizePixels, RowHeights[0]+Canvas.TextWidth(LookupQuery.FieldByName('DisplayName').AsString));
                LookupQuery.Next;
              end;
              DisplaySize := DisplaySizePixels div CWidth;

              LookupControl := TwwDBLookupCombo.Create(self);
              LookupControl.Name := FieldName+'LookupControl';
              LookupControl.Parent := tsZcpsConfigs;//self;
              LookupControl.Top := ColumnID * 30;
              LookupControl.Style := csDropDownList;
              LookupControl.DataSource := dbgVariationGrid.DataSource;
              LookupControl.DataField := FieldName;
              LookupControl.LookupTable := LookupQuery;
              LookupControl.LookupField := 'ValueID';
              LookupControl.Selected.Text := 'DisplayName'#9'7'#9'DisplayName';

              LookupQuery.Close;

              DataField := TIntegerField.Create(nil);
              DataField.Name := FieldName;
              DataField.FieldName := FieldName;
              DataField.FieldKind := fkData;
              DataField.Visible := False;
              DataField.DataSet := dbgVariationGrid.DataSource.DataSet;
              LookupField := TStringField.Create(nil);
              LookupField.Size := 50;
              LookupField.Name := FieldName+'Lookup';
              LookupField.FieldName := LookupField.Name;
              LookupField.Lookup := True;
              LookupField.FieldKind := fkLookup;
              LookupField.Visible := True;
              LookupField.DisplayLabel := ColumnName;
              LookupField.KeyFields := FieldName;
              LookupField.LookupDataSet := LookupQuery;
              LookupField.LookupKeyFields := 'ValueID';
              LookupField.LookupResultField := 'DisplayName';
              LookupField.DataSet := dbgVariationGrid.DataSource.DataSet;
              dbgVariationGrid.Selected.Add(LookupField.Name+#9+IntToStr(DisplaySize)+#9+ColumnName);
              dbgVariationGrid.SetControlType(LookupField.FieldName, fctCustom, LookupControl.Name);
              Next;
            end;
          end;

          ApplySelected;
          Invalidate;

          for i := low(ColumnLookupData) to high(ColumnLookupData) do
          with ColumnLookupData[i] do
          begin
            LookupControl.DropDownWidth :=
              dbgVariationGrid.ColWidthsPixels[i+3];
          end;
        end;
        dmThemeData.AztecConn.Execute(ZcpsConfigsDropSQL);
        dmThemeData.AztecConn.Execute(ZcpsConfigsCreateSQL);

        VariationSummary := TmpSummary;
      end;
    end;

    dmThemeData.qEditZcpsConfigs.AfterEdit := ZcpsConfigsHandleDatasetAfterEdit;

    dmThemeData.AztecConn.Execute(ZcpsConfigsLoadSQL);
    ZcpsConfigsDataModified := False;

    dmThemeData.qEditZcpsConfigs.Active := true;

  finally
    if Assigned(Bmk) and dmThemeData.qEditZcpsConfigs.BookmarkValid(Bmk) then
    begin
      if (dmThemeData.qEditZcpsConfigs.Active) then
        dmThemeData.qEditZcpsConfigs.GotoBookmark(Bmk);
      dmThemeData.qEditZcpsConfigs.FreeBookmark(bmk);
    end;
    dmThemeData.EndHourGlass;
  end;
end;

procedure TEstateSetup.ZcpsConfigsDeInitExecute(Sender: TObject);
begin
  if not dmThemeData.qEditZcpsConfigs.Active then exit;
  if not Assigned(Sender) then
  begin
    ZcpsConfigsPromptSaveChanges();
  end
  else
  begin
    ZcpsConfigsPromptSaveChanges();
    dmThemeData.AztecConn.Execute(ZcpsConfigsDropSQL);
    VariationSummary.VarCount := -1;
    VariationSummary.VarPanelCount := -1;
    dmThemeData.qEditZcpsConfigs.Active := false;
    ZcpsConfigsClearLookupData();
  end;
end;

procedure TEstateSetup.ZcpsConfigsLoadExecute(Sender: TObject);
begin
  if (dmThemeData.qEditZcpsConfigs.State in [dsEdit, dsInsert]) then
    dmThemeData.qEditZcpsConfigs.Cancel;
  dmThemeData.AztecConn.Execute(ZcpsConfigsLoadSQL);
  ZcpsConfigsDataModified := False;
  dmThemeData.qEditZcpsConfigs.Requery();
end;

procedure TEstateSetup.ZcpsConfigsSaveExecute(Sender: TObject);
begin
  if (dmThemeData.qEditZcpsConfigs.State in [dsEdit, dsInsert]) then
    dmThemeData.qEditZcpsConfigs.Post;
  dmThemeData.AztecConn.Execute(ZcpsConfigsSaveSQL);
  ZcpsConfigsDataModified := False;
end;

procedure TEstateSetup.ZcpsConfigsLoadUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ZcpsConfigsDatamodified;
end;

procedure TEstateSetup.dbgVariationGridCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if Assigned(TwwDBGrid(sender).DataSource)
    and (Field.Index <= TwwDBGrid(sender).FixedCols)
    and Assigned(TwwDBGrid(sender).DataSource.DataSet)
    and TwwDBGrid(sender).DataSource.DataSet.Active then
  begin
    if TwwDBGrid(sender).DataSource.DataSet.FieldByName('SiteCode').AsInteger = 0 then
      AFont.Style := [fsBold];
  end;
end;

procedure TEstateSetup.ZcpsConfigActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
    Log(Action.Name+' clicked');
end;

procedure TEstateSetup.gDiscountsDblClick(Sender: TObject);
begin
  Log('gDiscounts double clicked, Discount: ' + dmADO.qDiscountsName.AsString);
  EditOneDiscount;
end;

procedure TEstateSetup.gDiscountsKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) in [VK_RETURN] then
  begin
    Log('gDiscounts enter pressed, Discount: ' + dmADO.qDiscountsName.AsString);
    EditOneDiscount;
  end;
end;

procedure TEstateSetup.btnAddInformationPromptClick(Sender: TObject);
begin
  dmThemeData.qCustomerInformationPrompts.Insert;
  dmThemeData.qCustomerInformationPrompts.FieldByName('id').asinteger  := uGenerateThemeIDs.GetNewId(scThemeCustomerInformationPrompt);
  dmThemeData.qCustomerInformationPrompts.FieldByName('PromptText').asstring := 'New prompt';
  dmThemeData.qCustomerInformationPrompts.FieldByName('MaximumEntryLength').AsInteger := 10;
  dmThemeData.qCustomerInformationPrompts.Post;
  gCustomerInformationPrompts.Refresh;
  SetInfoPromptGridState;
end;

procedure TEstateSetup.btnDeleteInformationPromptClick(Sender: TObject);
begin
  if gCustomerInformationPrompts.DataSource.DataSet.FieldByName('id').asinteger = 0 then
    raise exception.create('You may not delete the ''No prompt'' option');
  with dmado.qrun do
  begin
    sql.text := 'select * from themeconfigset where CustomerInformationPrompt = '
                + gCustomerInformationPrompts.DataSource.DataSet.FieldByName('id').asstring;
    open;
    if recordcount > 0 then
    begin
      close;
      raise exception.create('You may not delete this Prompt as it is still in use.');
    end;
    close;
  end;
  gCustomerInformationPrompts.DataSource.DataSet.Delete;
  SetInfoPromptGridState;
end;

procedure TEstateSetup.SetInfoPromptGridState;
begin
  gCustomerInformationPrompts.Enabled := not (gCustomerInformationPrompts.DataSource.DataSet.RecordCount = 0);
  btnDeleteInformationPrompt.Enabled := gCustomerInformationPrompts.Enabled;
end;

procedure TEstateSetup.tsCustomerInfoPromptsHide(Sender: TObject);
begin
  if (dmThemeData.qCustomerInformationPrompts.State = dsInsert) or (dmThemeData.qCustomerInformationPrompts.State = dsEdit) then
    dmThemeData.qCustomerInformationPrompts.Post;
end;
  
procedure TEstateSetup.gConfigSchemesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  GridPos : TGridCoord;
  Hint: String;
  field: TField;
begin
  Hint := '';
  GridPos := TwwdbGrid(Sender).MouseCoord(X,Y);

  if (gridpos.X > TwwDbgrid(Sender).FixedCols - 1) and (gridPos.Y >= 0) then
  begin
    field := TwwDbgrid(Sender).Fields[GridPos.X-1];

    if field.ReadOnly then
    begin
      if (field.fieldName = 'PrintPriceEmbeddedBarcode') then
        Hint := 'No Price Embedded Barcode prefix has been specified.'

      else if (field.fieldName = 'AllowCharityDonations') then
        Hint := 'Charity donations must be enabled in Base Data > Estate Settings'

      else if (field.fieldName = 'PromptToRedeemBookingOnStartTable') then
        Hint := 'A Redeem Booking Deposit payment method must be created';
    end;
  end;

  TwwdbGrid(Sender).Hint := Hint;
  TwwdbGrid(Sender).ShowHint := Hint <> '';
end;

procedure TEstateSetup.tsCorrectionsShow(Sender: TObject);
begin
  PopulateCorrectionMethodComboBox;
  InitialiseCorrectionReasons;
end;

procedure TEstateSetup.tsCorrectionsHide(Sender: TObject);
begin
  CorrectionReasonsFrame.SaveAnyChanges;
end;

procedure TEstateSetup.PopulateCorrectionMethodComboBox;
begin
  cbCorrectionMethod.Clear;

  with dmADO.adoqCorrectionMethods do
  try
    Open;
    while not Eof do
    begin
      cbCorrectionMethod.Items.AddObject(FieldByName('Name').AsString, TObject(FieldByName('CorrectionMethodId').AsInteger));
      Next;
    end
  finally
    Close;
  end;
end;

procedure TEstateSetup.btnEditTableMoveReasonsClick(Sender: TObject);
var EditTableMoveReasons: TEditTableMoveReasons;
begin
  EditTableMoveReasons := TEditTableMoveReasons.Create(Self);
  try
    Log('Editing table move/merge reasons.');
    EditTableMoveReasons.ShowModal;
  finally
    EditTableMoveReasons.Release;
  end;
end;

procedure TEstateSetup.EditQrCodeTextBtnClick(Sender: TObject);
begin
  Log('Edit QR Code Text button clicked');
  try
        dmADO.qCreateQrCodeTempTables.ExecSQL;
        dmAdo.TmpQrCodeHeaderText.Open;
        dmAdo.TmpQrCodeFooterText.Open;

        if TEditClmQrCodeTextFrm.ShowQrCodeTextFrm(True) then
        begin
                dmADO.qSaveQrCodeText.ExecSQL;
        end;

  finally
  begin
        dmADO.qSaveQrCodeText.Close;
        dmADO.qCreateQrCodeTempTables.Close;
        dmAdo.TmpQrCodeHeaderText.Close;
        dmAdo.TmpQrCodeFooterText.Close;
  end;
  end;
end;

procedure TEstateSetup.cbPromoDetailsMaintClick(Sender: TObject);
begin
  if cbPromoDetailsMaint.Checked then
  begin
    if udRetentionPeriod.Position = 0 then // if NOT 0 leave it as it was
      udRetentionPeriod.Position := 395;   // if 0 then it loaded as 0, set it to default

    udRetentionPeriod.Min := 90;
  end;
  edRetentionPeriod.Enabled := cbPromoDetailsMaint.Checked;
  udRetentionPEriod.Enabled := cbPromoDetailsMaint.Checked;
  lblRetentionPeriod.Enabled := cbPromoDetailsMaint.Checked;
end;

procedure TEstateSetup.EditBarCodeTextBtnClick(Sender: TObject);
begin
  Log('Edit Barcode Text button clicked');
  try
        dmADO.qCreateBarcodeTempTables.ExecSQL;
        dmAdo.TmpBarcodeHeaderText.Open;
        dmAdo.TmpBarcodeFooterText.Open;

        if TEditClmQrCodeTextFrm.ShowQrCodeTextFrm(False) then
        begin
                dmADO.qSaveBarcodeText.ExecSQL;
        end;

  finally
  begin
        dmADO.qSaveBarcodeText.Close;
        dmADO.qCreateBarcodeTempTables.Close;
        dmAdo.TmpBarcodeHeaderText.Close;
        dmAdo.TmpBarcodeFooterText.Close;
  end;
  end;
end;

end.

