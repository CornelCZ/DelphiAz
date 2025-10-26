unit uNewPortionIngredientsFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uAztecDBLookupBox, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  Variants, DB, ActnList, uDatabaseADO, ComCtrls, Menus, Buttons,
  wwdbdatetimepicker, uFutureDate, Spin, wwcheckbox, Mask, wwdbedit,
  Wwdbspin, uPortionFilterForm;

const
  MAX_CHOICE_INGREDIENTS = 80;
  MAX_RECIPE_INGREDIENTS = 80;
  COLUMNS_PER_PORTION = 4;
  UNIT_COLUMN_WIDTH = 6;
  QUANTITY_COLUMN_WIDTH = 7;
  COST_COLUMN_WIDTH = 6;
  MINOR_COLUMN_WIDTH = 7;

  MAX_PRICING_VALUE = 99999.99;
  // Comparisons of float values can give false positives due to the fact that floats are stored in an imprecise manner. This
  // value is used to account for this when comparing values with 2dp accuracy
  TWO_DP_FUDGE_FACTOR = 0.001;

type
  TPortionType = class(TObject)
    Id: integer;
    Name: string;
    constructor Create(Id: integer; Name: string);
  end;


  // This class represents all portions of a single product that are visible, indexed by DisplayOrder.
  // If a portion type filter has been applied only the visible portion types are included.
  // The info maintained is minimal, only the name and Id of the portion type.
  TPortionsByDisplayOrder = class(TObject)
    private
      PortionTypeArray: array[1..ABSOLUTE_MAX_NUMBER_OF_PORTIONS] of TPortionType;
      function GetLow: Integer;
      function GetHigh: Integer;
      function GetPortionId(DisplayOrder: Integer): integer;
      function GetPortionName(DisplayOrder: Integer): String;
      function IsPortionAssigned(DisplayOrder: Integer): Boolean;
    public
      procedure ClearAll;
      procedure Clear(DisplayOrder: Integer);
      procedure AddPortion(DisplayOrder: Integer; PortionTypeId: integer; PortionName: String);
      function PreviousAssignedPortion(const DisplayOrder: integer): integer;
      function NextAssignedPortion(const DisplayOrder: integer): integer;
      property PortionId[DisplayOrder: Integer]: Integer read GetPortionId;
      property PortionName[DisplayOrder: Integer]: String read GetPortionName;
      property PortionAssigned[DisplayOrder: Integer]: Boolean read IsPortionAssigned; default;
      function NumberOfVisiblePortions: integer;
      function AllowFactorQuantities(const DisplayOrder: integer): boolean;
      function ContainsPortionType (const PortionTypeId: integer): boolean;
  end;

  //Expose the properties incoveniently hidden by the woll2woll component
  TProtectionHackGrid = class(TCustomGrid)
    public
      property Col;
      property Row;
      property Options;
  end;

  TNewPortionIngredientsFrame = class(TFrame)
    HoldingPanel: TPanel;
    ButtonPanel: TPanel;
    InsertButton: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BasePanel: TPanel;
    SubGridPanel: TPanel;
    PortionsActionList: TActionList;
    InsertIngredientAction: TAction;
    DeleteIngredientAction: TAction;
    AppendIngredientAction: TAction;
    EditIngredientAction: TAction;
    TopPanel: TPanel;
    PortiongridPopupMenu: TPopupMenu;
    DeletePortionAction: TAction;
    DeletePortion1: TMenuItem;
    N1: TMenuItem;
    AppendIngredient1: TMenuItem;
    DeleteIngredient1: TMenuItem;
    InsertIngredient1: TMenuItem;
    DeleteIngredient2: TMenuItem;
    dbgPortions: TwwDBGrid;
    CancelChangesAction: TAction;
    RightPanel: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    CookTimesButton: TButton;
    ContainersButton: TButton;
    Bevel1: TBevel;
    LeftPanel: TPanel;
    IngredientsAsOfCaption: TLabel;
    FuturePortionsExistlbl: TLabel;
    IngredientsAsOfComboBox: TComboBox;
    CancelChangesButton: TButton;
    Panel1: TPanel;
    grbMinMaxChoices: TGroupBox;
    lblMinChoice: TLabel;
    lblMaxChoice: TLabel;
    lblSupplement: TLabel;
    seMinChoice: TwwDBSpinEdit;
    seMaxChoice: TwwDBSpinEdit;
    seSuppChoice: TwwDBSpinEdit;
    cbxChoiceEnabled: TwwCheckBox;
    wwcbAllowPlain: TwwCheckBox;
    FormsActionList: TActionList;
    CookTimesAction: TAction;
    ContainersAction: TAction;
    PortionNameLookupCombo: TComboBox;
    btnMoveUp: TSpeedButton;
    btnMoveDown: TSpeedButton;
    lblBudgetedCostPriceMethodOverride: TLabel;
    btnSettingsOverride: TButton;
    Panel3: TPanel;
    dbgPortionPrices: TwwDBGrid;
    Panel2: TPanel;
    btnPortions: TButton;
    PortionFilterAction: TAction;
    gbPortionFilter: TGroupBox;
    cbPortionFilter: TCheckBox;
    procedure dbgPortionsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgPortionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure dbgPortionPricesCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure dbgPortionsCellChanged(Sender: TObject);
    procedure dbgPortionsLeftColChanged(Sender: TObject; NewLeftCol: Integer);
    procedure dbgPortionsDrawGroupHeaderCell(Sender: TObject;
      Canvas: TCanvas; GroupHeaderName: String; Rect: TRect;
      var DefaultDrawing: Boolean);
    procedure InsertIngredientActionExecute(Sender: TObject);
    procedure AppendIngredientActionExecute(Sender: TObject);
    procedure EditIngredientActionExecute(Sender: TObject);
    procedure dbgPortionsDblClick(Sender: TObject);
    procedure IngredientsAsOfComboBoxChange(Sender: TObject);
    procedure IngredientsAsOfComboBoxDropDown(Sender: TObject);
    procedure DeletePortionActionExecute(Sender: TObject);
    procedure DeletePortionActionUpdate(Sender: TObject);
    procedure DeleteIngredientActionExecute(Sender: TObject);
    procedure DeleteIngredientActionUpdate(Sender: TObject);
    procedure EditIngredientActionUpdate(Sender: TObject);
    procedure InsertIngredientActionUpdate(Sender: TObject);
    procedure CancelChangesActionExecute(Sender: TObject);
    procedure CancelChangesActionUpdate(Sender: TObject);
    procedure CookTimesActionExecute(Sender: TObject);
    procedure PortionsActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure AppendIngredientActionUpdate(Sender: TObject);
    procedure dbgPortionsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ContainersActionExecute(Sender: TObject);
    procedure cbxChoiceEnabledClick(Sender: TObject);
    procedure IngredientsAsOfComboBoxKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure IngredientsAsOfComboBoxEnter(Sender: TObject);
    procedure OnMinMaxChoiceChange(Sender: TObject);
    procedure dbgPortionPricesColEnter(Sender: TObject);
    procedure dbgPortionsColEnter(Sender: TObject);
    procedure dbgPortionPricesFieldChanged(Sender: TObject; Field: TField);
    procedure dbgPortionPricesDrawDataCell(Sender: TObject;
      const Rect: TRect; Field: TField; State: TGridDrawState);
    function PortionExistsInTheFuture(portionType: integer): boolean;
    procedure DeletePortionFromTheFuture(portionType: integer);
    function PortionUsedByAnotherNonDeletedProduct(portionType: integer): boolean;
    procedure ReplaceUsagesOfPortion(const oldPortionType, newPortionType: integer);
    procedure RemovePortionFromAllProducts(const portionType: integer);
    procedure PortionNameLookupComboSelect(Sender: TObject);
    procedure PortionNameLookupComboCloseUp(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnSettingsOverrideClick(Sender: TObject);
    procedure dbgPortionsDrawFooterCell(Sender: TObject; Canvas: TCanvas;
      FooterCellRect: TRect; Field: TField; FooterText: String;
      var DefaultDrawing: Boolean);
    procedure PortionFilterActionExecute(Sender: TObject);
    procedure cbPortionFilterClick(Sender: TObject);
  private
    FEntityCode: double;
    FEntityType: EntType;
    FPortionsGridConfiguredForEntityType: EntType;
    FPortionsGridConfiguredForPortionNumbers: TList; //List of portion numbers (aka Display Orders) the portions grid is currently showing
    FPricesGridConfiguredForPortionNumbers: TList;  //List of portion numbers (aka Display Orders) the prices grid is currently showing

    ParentEntityList: TStringList;
    ParentEntityTypeSet: set of EntType;
    FOld_EffectiveDate: String;
    FEffectiveDates: TAztecDateList;
    FPortionsByDisplayOrder: TPortionsByDisplayOrder;
    FGridPositionToPortionDisplayOrder: array[1..ABSOLUTE_MAX_NUMBER_OF_PORTIONS] of Integer; // Mapping of grid location to display order which takes portion filtering into account
    FTempTablesBuilt: Boolean;
    PricesGridConfigured: boolean;
    FSynchingCols: boolean;
    FPortionPriceChangesExist: boolean;
    FShowPortionPrices: boolean;
    FRefreshingPortionPriceInfo: boolean;
    FprocessingFieldChanged: boolean;
    FMinMaxChoiceControlsBeingInitialised: boolean;
    FPortionFilterDialog: TPortionFilterForm;
    FNoPortionsVisible: boolean;

    function OverlapsFixedCols(_Rect: TRect): Boolean;
    function OverlapsRHS(_Rect: TRect): Boolean;
    procedure CreateIngredient(IngredientDisplayOrder: Integer);
    procedure SetupPortionColumnGroups;
    function ValidChoiceIngredient(EntityCode: double): boolean;
    function IngredientIsAllowed: boolean;
    function CheckRecipeDepth(EntityCode: double; Depth: integer): boolean;
    procedure RenumberIngredientDisplayOrders(makeSpaceForDisplayOrder: Integer );
    procedure InsertIntoPortion(ingredientOrder: integer);
    function GetFocusedPortion: Integer;
    function DetermineUnitName(PortionTypeID: Integer; CalculationType: Integer; UnitName: String): String;
    procedure CreateNew;
    procedure SetupEffectiveDates(_EntityCode: Double); overload;
    procedure SetupEffectiveDates(EffectiveDates: String); overload;
    procedure GetIngredientsForDate(Date: String);
    procedure RefreshDisplay(EffectiveDate: String = CURRENT_ITEM);
    procedure BuildPortionComboBox;
    procedure RefreshDefaultCooktime;
    function ViewingCurrentData: Boolean;
    function ViewingDate: String;
    procedure BuildTempTables(EntityCode: Double; EffectiveDate: String);
    procedure CreateDefaultAztecPortion;
    procedure SetupGrids;

    procedure SetupGridPortionTypes;
    procedure SetupPortionsGrid;
    function PortionTypesFiltered: boolean;
    procedure GetVisiblePortionNumbers(var intlist: TList);
    function IntegerListsAreEqual(intList1, intList2: TList): boolean;
    procedure ConfigurePortionsGridColumnsIfNecessary;
    procedure SetPortionPricesGridVisibility(visible: boolean);
    procedure ScrollGridsHardLeft;
    procedure ApplyPortionTypeFilterChangeToGrids;
    function ShowPortionFilterDialog(out settingsChanged: boolean): Integer;

    procedure SetupPricesGrid;
    procedure UpdateDisplay;
    procedure EnsureSelfIngredientExists;
    procedure RefreshCostPriceTotals;
    procedure SetCostPriceToShowFourDecimalPlaces;
    procedure GridEnableControls;
    procedure SetGridTabStops;
    function GetSelectedDate: string;
    procedure SetupContainers;
    function GetPriceColumn(const portionColumn: string): string;
    function GetPortionColumn(const priceColumn: string): string;
    procedure HandleTaxRuleChange(Sender: TObject);
    function RefreshPricingFigures(fixedValue: TPortionPriceGridValue; const portion: integer; out errorMessage: string): boolean;
    procedure MovetoPricesTableRow(rowType: TPortionPriceGridValue);
    function CalculatePortionPrice(COSPercent: double; costPrice: double): double;
    function BudgetedCost(const portion: integer): double;
    procedure ClearCostPriceTotals;
    procedure ClearCostPriceTotal(portion: integer);
    procedure RefeshCostPriceMode;
    procedure SetupMinMaxChoices;
    procedure SetMinMaxChoiceControlVisibility;
    procedure RemoveIngredient(Sender: TObject; requireConfirmation: boolean = true);
    function MaxIngredients: integer;
    function PortionTypeExistsForEntity(PortionTypeID: Integer): boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateSelfIngredientNameAndDesc(_Name, _Description: String);
    function IsInitialisedForCurrentProduct: boolean;
    procedure ForceReinitialise;
    procedure EnsureInitialisedForCurrentProduct;
    procedure InitialiseForCurrentProduct;
    procedure InitialiseFromAnotherProduct(fullClone: Boolean; baseEntityCode: Double;  baseEntityType: EntType);
    procedure RefreshCostPrices;
    procedure DisplayFutureChangeLabel;
    procedure RemoveScaleContainers;
    procedure CheckStandardPortion;
    function PortionPriceChangesExist: boolean;
    procedure SavePendingPortionChanges;
    procedure SavePendingPortionPriceChanges;
    // check for NT Flags
    function CanAddPortionForProductFlags(EntityCode: Double): boolean;
  end;

  function DateOrderSort(List: TStringList; Index1, Index2: Integer): Integer;

var
  ZonalBlue, ZonalBlueGray, ZonalGray: Integer;

implementation

uses
  ADODB, uGuiUtils, uMaintPortionType,
  uSelectEntity, uPortionIngredientDialog, uGlobals, uADO,
  uPortionCooktimes, uDatePicker, uLog, DateUtils, FmtBcd, Math,
  uPortionScaleContainers, StrUtils, uSettingsOverrideForm, uLineEdit;

{$R *.dfm}

function DateOrderSort(List: TStringList; Index1, Index2: Integer): Integer;
var
  DateWrapper1: TAztecDateWrapper;
  DateWrapper2: TAztecDateWrapper;
begin
  DateWrapper1 := TAztecDateWrapper(List.Objects[Index1]);
  DateWrapper2 := TAztecDateWrapper(List.Objects[Index2]);

  if DateWrapper1.Date > DateWrapper2.Date then
    Result := 1
  else if DateWrapper1.Date < DateWrapper2.Date then
    Result := -1
  else
    Result := 0;
end;

{ TPortionType }
constructor TPortionType.Create(Id: integer; Name: string);
begin
  Inherited Create;
  self.Id := Id;
  self.Name := Name;
end;

{ TPortionsByDisplayOrder }
procedure TPortionsByDisplayOrder.AddPortion(DisplayOrder: Integer; PortionTypeId: integer; PortionName: String);
begin
  if (DisplayOrder >= Low(PortionTypeArray)) and (DisplayOrder <= High(PortionTypeArray)) then
  begin
    if PortionTypeArray[DisplayOrder] <> nil then
      FreeAndNil(PortionTypeArray[DisplayOrder]);
    PortionTypeArray[DisplayOrder] := TPortionType.Create(PortionTypeId, PortionName);
  end;
end;

procedure TPortionsByDisplayOrder.ClearAll;
var i: Integer;
begin
  for i := Low(PortionTypeArray) to High(PortionTypeArray) do Clear(i);
end;

procedure TPortionsByDisplayOrder.Clear(DisplayOrder: integer);
begin
  if PortionTypeArray[DisplayOrder] <> nil then
    FreeAndNil(PortionTypeArray[DisplayOrder]);
end;

function TPortionsByDisplayOrder.GetHigh: Integer;
begin
  result := High(PortionTypeArray);
end;

function TPortionsByDisplayOrder.GetLow: Integer;
begin
  result := Low(PortionTypeArray);
end;

function TPortionsByDisplayOrder.IsPortionAssigned(DisplayOrder: Integer): Boolean;
begin
  Result := GetPortionName(DisplayOrder) <> '';
end;

function TPortionsByDisplayOrder.GetPortionName(DisplayOrder: Integer): String;
begin
  result := '';
  if (DisplayOrder >= Low(PortionTypeArray)) and
     (DisplayOrder <= High(PortionTypeArray)) and
     (PortionTypeArray[DisplayOrder] <> nil)
  then
    result := PortionTypeArray[DisplayOrder].Name;
end;

function TPortionsByDisplayOrder.GetPortionId(DisplayOrder: Integer): integer;
begin
  Result := -1;
  if (DisplayOrder >= Low(PortionTypeArray)) and
     (DisplayOrder <= High(PortionTypeArray)) and
     (PortionTypeArray[DisplayOrder] <> nil)
  then
    result := PortionTypeArray[DisplayOrder].Id;
end;


function TPortionsByDisplayOrder.NextAssignedPortion(const DisplayOrder: integer): integer;
var p: integer;
begin
  p := DisplayOrder;

  repeat
    if p = GetHigh then
      p := GetLow
    else
      p := p + 1;
  until IsPortionAssigned(p) or (p = GetLow);

  Result := p;
end;

function TPortionsByDisplayOrder.PreviousAssignedPortion(const DisplayOrder: integer): integer;
var p: integer;
begin
  p := DisplayOrder;

  repeat
    if p = GetLow then
      p := GetHigh
    else
      p := p - 1;
  until IsPortionAssigned(p) or (p = GetLow);

  Result := p;
end;

function TPortionsByDisplayOrder.AllowFactorQuantities(const DisplayOrder: integer): boolean;
begin
  //The first portion cannot allow 'Factor' unit types
  Result := DisplayOrder <> 1
end;


function TPortionsByDisplayOrder.NumberOfVisiblePortions: integer;
var i: integer;
begin
  Result := 0;
  for i := Low(PortionTypeArray) to High(PortionTypeArray) do
    if IsPortionAssigned(i) then Result := Result + 1;
end;

function TPortionsByDisplayOrder.ContainsPortionType (const PortionTypeId: integer): boolean;
var i: integer;
begin
  Result := False;
  for i := Low(PortionTypeArray) to High(PortionTypeArray) do
  begin
    if (PortionTypeArray[i] <> nil) and (PortionTypeArray[i].Id = PortionTypeId) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


{ TNewPortionIngredientsFrame }
constructor TNewPortionIngredientsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  //dbgPortions.PaintOptions.ActiveRecordColor := ZonalBlueGray;
  dbgPortions.PaintOptions.ActiveRecordColor := clHighlight;

  //For some reason the Woll2Woll grid does not pay attention to the
  //dgIndicator property at all when set in the designer.  Do it here instead.
  dbgPortions.Options := dbgPortions.Options - [Wwdbigrd.dgIndicator];

  ProductsDB.SavePortionIngredients := SavePendingPortionChanges;
  ProductsDB.PortionPriceChangesExist := PortionPriceChangesExist;
  ProductsDB.SavePortionPriceChanges := SavePendingPortionPriceChanges;
  ProductsDB.OnTaxRulesChanged := HandleTaxRuleChange;

  PricesGridConfigured := False;
  FShowPortionPrices := False;
  FRefreshingPortionPriceInfo := False;
  FMinMaxChoiceControlsBeingInitialised := False;
  FEntityCode := -1;
  FEntityType := etNone;
  FPortionsGridConfiguredForEntityType := etNone;
  FPortionsGridConfiguredForPortionNumbers := TList.Create;
  FPricesGridConfiguredForPortionNumbers := TList.Create;

  btnMoveUp.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphUp');
  btnMoveDown.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphDown');
end;

procedure TNewPortionIngredientsFrame.SetupGrids;
begin
  SetupPortionsGrid;
  SetupPricesGrid;
  RefreshCostPriceTotals;
end;

procedure TNewPortionIngredientsFrame.SetPortionPricesGridVisibility(visible: boolean);
begin
  if dbgPortionPrices.Visible = visible then
    Exit;

  dbgPortions.LeftCol := dbgPortions.FixedCols;
  dbgPortionPrices.LeftCol := dbgPortionPrices.FixedCols;

  if visible then
  begin
    dbgPortionPrices.Visible := True;
    dbgPortions.ShowHorzScrollBar := False;
    Panel3.Height := Panel3.Height + dbgPortionPrices.Height;
  end
  else
  begin
    dbgPortionPrices.Visible := False;
    dbgPortions.ShowHorzScrollBar := True;
    Panel3.Height := Panel3.Height - dbgPortionPrices.Height;
  end;
end;

procedure TNewPortionIngredientsFrame.SetupPricesGrid;
var
  showPricesGrid: boolean;
  headingFieldWidth, i: integer;
  visiblePortionNumbers: TList;

  procedure AddGridColumn(fieldName: string; width: integer; readOnly: boolean = false);
  begin
    dbgPortionPrices.Selected.Add(fieldName+#9+InttoStr(width)+#9#9+ifthen(readOnly, 'T', 'F'));
  end;

begin
  showPricesGrid := ProductsDb.ShowPortionPrices and (FEntityType in [etStrdLine, etRecipe]);

  SetPortionPricesGridVisibility(showPricesGrid);

  if showPricesGrid then
  begin
    visiblePortionNumbers := TList.Create;

    try
      GetVisiblePortionNumbers(visiblePortionNumbers);

      if not(PricesGridConfigured) or not(IntegerListsAreEqual(visiblePortionNumbers, FPricesGridConfiguredForPortionNumbers)) then
      begin
        with dbgPortions do
        begin
          headingFieldWidth := ColumnByName('Row').DisplayWidth + ColumnByName('Description').DisplayWidth + ColumnByName('Name').DisplayWidth + 2;
        end;

        with dbgPortionPrices do
        begin
          Selected.Clear;

          AddGridColumn('Heading', headingFieldWidth, true);

          for i := 1 to ProductsDB.MaxAllowedPortions do
          begin
            if PortionTypesFiltered and not(FPortionsByDisplayOrder.IsPortionAssigned(i)) then
              continue;

            AddGridColumn(Format('DummyA%d', [i]), UNIT_COLUMN_WIDTH, true);
            AddGridColumn(Format('DummyB%d', [i]), QUANTITY_COLUMN_WIDTH, true);
            AddGridColumn(Format('Value%d', [i]), COST_COLUMN_WIDTH, false);
          end;

          ApplySelected;

          for i := 1 to ProductsDB.MaxAllowedPortions do
          begin
            PictureMasks.Add('Value' + IntToStr(i) + #9'[-]{{{#[#][#][#][#][.#[#]]},.#[#]}}'#9'T'#9'T');
          end;

          PricesGridConfigured := True;
          FPricesGridConfiguredForPortionNumbers.Assign(visiblePortionNumbers);
        end;
      end;
    finally
       visiblePortionNumbers.Free;
    end;

    // Every time the qEditPortionPrices is Closed and re-Opened all the settings on its TField objects are lost because
    // these objects are recreated. It may be worth creating persistent TField objects. This means the code would break if
    // MAX_NUMBER_OF_PORTIONS is changed but this break will be obvious(will it??) and easily fixed.
    ProductsDb.PortionPricesTable.FieldByName('Heading').Alignment := taRightJustify;
    for i := 1 to ProductsDB.MaxAllowedPortions do
    begin
      TBCDField(ProductsDb.PortionPricesTable.FieldByName(Format('Value%d', [i]))).DisplayFormat := '0.00';
    end;

  end; // if showPricesGrid
end;


procedure TNewPortionIngredientsFrame.SetupPortionsGrid;
begin
  with dbgPortions do
  begin
    BeginUpdate;
    try
      SetupGridPortionTypes;
      ConfigurePortionsGridColumnsIfNecessary;
      SetCostPriceToShowFourDecimalPlaces;
      SetupPortionColumnGroups;
      SetGridTabStops;
    finally
      EndUpdate;
    end;
    Refresh;
  end;
end;

function TNewPortionIngredientsFrame.PortionTypesFiltered: boolean;
begin
  result := cbPortionFilter.Checked and Assigned(FPortionFilterDialog) and FPortionFilterDialog.FilterApplied;
end;

procedure TNewPortionIngredientsFrame.GetVisiblePortionNumbers(var intlist: TList);
var i: integer;
begin
  intList.Clear;
  intList.Capacity := ProductsDB.MaxAllowedPortions;

  for i := 1 to ProductsDB.MaxAllowedPortions do
  begin
    if not(PortionTypesFiltered) then
    begin
      // No portion type filtering applied so all portions are visible
      intList.Add(Pointer(i))
    end
    else
    begin
      if FPortionsByDisplayOrder.IsPortionAssigned(i) then
        intList.Add(Pointer(i));
    end;
  end;
end;

function TNewPortionIngredientsFrame.IntegerListsAreEqual(intList1, intList2: TList): boolean;
var i: integer;
begin
  if (intList1.Count <> intList2.Count) then
  begin
    result := false;
    Exit;
  end;

  for i := 0 to intList1.Count - 1 do
  begin
    if (Integer(intList1[i]) <> Integer(intList2[i])) then
    begin
      result := false;
      Exit;
    end;
  end;

  result := true;
end;

procedure TNewPortionIngredientsFrame.ConfigurePortionsGridColumnsIfNecessary;
var
  i: Integer;
  visiblePortionNumbers: TList;

  procedure AddGridColumn(fieldName, displayName: string; width: integer; readOnly: boolean = false);
  begin
    dbgPortions.Selected.Add(fieldName+#9+InttoStr(width)+#9+DisplayName+#9+ifthen(readOnly, 'T', ''));
  end;

begin
  visiblePortionNumbers := TList.Create;
  try
    GetVisiblePortionNumbers(visiblePortionNumbers);

    if ((FPortionsGridConfiguredForEntityType = etChoice) and (FEntityType <> etChoice))
      or ((FPortionsGridConfiguredForEntityType <> etChoice) and (FEntityType = etChoice))
      or not(IntegerListsAreEqual(visiblePortionNumbers, FPortionsGridConfiguredForPortionNumbers))
    then
    begin
      if ProductsDB.CurrentEntityType <> etChoice then
         dbgPortions.FixedCols := 3
      else
         dbgPortions.FixedCols := 4;

      dbgPortions.Selected.Clear;

      AddGridColumn('Row', '', 2);
      AddGridColumn('Name', 'Name', 15);
      AddGridColumn('Description', 'Description', 15);

      if ProductsDB.CurrentEntityType = etChoice then
      begin
        AddGridColumn('IncludeByDefault', 'Default', 1, true);
        dbgPortions.ControlType.Add('IncludeByDefault;CheckBox;True;False');
      end;

      for i := 1 to ProductsDB.MaxAllowedPortions do
      begin
        if PortionTypesFiltered and not(FPortionsByDisplayOrder.IsPortionAssigned(i)) then
          continue;

        AddGridColumn(Format('UnitName%d', [i]), 'Unit', UNIT_COLUMN_WIDTH);
        AddGridColumn(Format('Quantity%d', [i]), 'Quantity', QUANTITY_COLUMN_WIDTH);
        AddGridColumn(Format('CostPrice%d', [i]), 'Cost', COST_COLUMN_WIDTH);
        AddGridColumn(Format('IsMinor%d', [i]), 'Is Minor', MINOR_COLUMN_WIDTH, True);
        dbgPortions.ControlType.Add(Format('IsMinor%d', [i])+';CheckBox;True;False'); 
      end;

      dbgPortions.ApplySelected;

      FPortionsGridConfiguredForEntityType := FEntityType;
      FPortionsGridConfiguredForPortionNumbers.Assign(visiblePortionNumbers);
    end;
  finally
    visiblePortionNumbers.Free;
  end;
end;

procedure TNewPortionIngredientsFrame.SetCostPriceToShowFourDecimalPlaces;
var i: integer;
begin
  for i := 1 to ProductsDB.MaxAllowedPortions do
    TBCDField(dbgPortions.datasource.dataset.FieldByName('CostPrice'+IntToStr(i))).DisplayFormat := '0.0000';
end;

procedure TNewPortionIngredientsFrame.SetupGridPortionTypes;
var
  portionTypeFilteredApplied: boolean;
  gridPosition, i : integer;
begin
  portionTypeFilteredApplied := PortionTypesFiltered;

  if not Assigned(FPortionsByDisplayOrder) then
  begin
    FPortionsByDisplayOrder := TPortionsByDisplayOrder.Create;
  end
  else
    FPortionsByDisplayOrder.ClearAll;

  FNoPortionsVisible := true;

  if not(portionTypeFilteredApplied and FPortionFilterDialog.NoneSelected) then
  begin
    with ProductsDB.ADOQuery do
    try
      Close;
      SQL.Text :=
        'SELECT tmpp.DisplayOrder, pt.Id AS PortionTypeId, pt.Name AS PortionTypeName ' +
        'FROM #TmpPortions tmpp JOIN ac_PortionType pt ON tmpp.PortionTypeId = pt.Id ';

      if portionTypeFilteredApplied then
        SQL.Text := SQL.Text +
        'WHERE pt.Id IN (' + FPortionFilterDialog.SelectedPortionTypesAsCommaSeparatedString + ')';

      Open;

      if not(Eof) then
      begin
        FNoPortionsVisible := false;

        while not EOF do
        begin
          FPortionsByDisplayOrder.AddPortion(
             FieldByName('DisplayOrder').AsInteger,
             FieldByName('PortionTypeId').AsInteger,
             FieldByName('PortionTypeName').AsString);
          Next;
        end;
      end;
    finally
      Close;
    end;

    gridPosition := 1;
    for i := 1 to ProductsDB.MaxAllowedPortions do
    begin
      if not(portionTypeFilteredApplied) or FPortionsByDisplayOrder.IsPortionAssigned(i) then
      begin
        FGridPositionToPortionDisplayOrder[gridPosition] := i;
        gridPosition := gridPosition + 1;
      end;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.SetupPortionColumnGroups;
var
  i: Integer;
  PortionTypeName: String;
  DisplayOrder: Integer;
  firstPortionColumn: integer;

begin
  firstPortionColumn := dbgPortions.FixedCols;

  //Set the group name for each column of the portions grid - the group name will be the name of the portion type with the
  //display order of the column.
  with dbgPortions do
  begin
    BeginUpdate;
    try
      for i := firstPortionColumn to dbgPortions.GetColCount - 1 do
      begin
        //This is the display order we are interested in
        DisplayOrder := FGridPositionToPortionDisplayOrder[((i-firstPortionColumn) div COLUMNS_PER_PORTION) + 1];

        PortionTypeName := FPortionsByDisplayOrder.PortionName[DisplayOrder];

        if PortionTypeName <> '' then
        begin
           if (lowercase(PortionTypeName) = 'standard') then
             dbgPortions.Columns[i].GroupName := PortionTypeName
           else
           begin
              if (IngredientsAsOfComboBox.Text = CURRENT_ITEM) then
                 dbgPortions.Columns[i].GroupName := '<'+PortionTypeName+'...>'
              else
                 dbgPortions.Columns[i].GroupName := PortionTypeName;
           end
        end
        else
           begin
           if (IngredientsAsOfComboBox.Text = CURRENT_ITEM) then
              dbgPortions.Columns[i].GroupName := '<Portion ' + IntToStr(DisplayOrder - 1)+'...>'
           else
              dbgPortions.Columns[i].GroupName := 'Portion ' + IntToStr(DisplayOrder - 1)
           end;
        end;
    finally
      EndUpdate;
    end;
    Refresh;
  end;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridCoordinate: TGridCoord;
  TargetRect: TRect;
  ClientPoint: TPoint;
  FirstColumnForPortion: integer;
begin
  GridCoordinate := dbgPortions.MouseCoord(x,y);
  ClientPoint := dbgPortions.ClientToScreen(Point(X,Y));

  //Zeroth col was the db indicator widget, not showing in this case, thus
  //0 and 1 are name and desc and 2,3 and 4 are the standard portion columns.
  //Show the portion combo box if we are not clicking the standard portion
  //and we are left clicking the group header.
  if (GridCoordinate.Y > 0) and (GridCoordinate.X = dbgPortions.FixedCols - 1) and cbxChoiceEnabled.checked then
    with dbgPortions do
    begin
      if not(dbgPortions.ColumnByName('IncludeByDefault').ReadOnly) then
      begin
        DataSource.DataSet.Edit;
        DataSource.DataSet.FieldByName('IncludeByDefault').AsBoolean := not DataSource.DataSet.FieldByName('IncludeByDefault').AsBoolean;
        DataSource.DataSet.Post;
        TADOQuery(DataSource.DataSet).UpdateBatch;
        RefreshCostPriceTotals;
      end;
    end;


  if (GridCoordinate.Y = 0) and (GridCoordinate.X >= dbgPortions.FixedCols) and (Y <= (dbgPortions.rowheights[0])) then
  begin
    //Move the selected column to the same column as the header cell just clicked
    if dbgPortions.GetActiveCol <> GridCoordinate.X then
    begin
      TProtectionHackGrid(dbgPortions).Col := GridCoordinate.X;
      dbgPortions.Refresh;
      dbgPortionsColEnter(nil);
    end;

    if (Y < (dbgPortions.rowheights[0]) div 2) and (Button = mbLeft)
      and (FPortionsByDisplayOrder.GetPortionId(GetFocusedPortion) <> STANDARD_PORTION_TYPE_ID) then
    begin
      if GetSelectedDate = CURRENT_ITEM then
      begin
         //Generate a TRect that spans the entire three visible columns that pertains to a portion
         FirstColumnForPortion := GridCoordinate.X - ((GridCoordinate.X - dbgPortions.FixedCols) MOD COLUMNS_PER_PORTION);
         TargetRect.TopLeft := dbgPortions.CellRect(FirstColumnForPortion, 0).TopLeft;
         TargetRect.BottomRight := dbgPortions.CellRect(FirstColumnForPortion + COLUMNS_PER_PORTION - 1, 0).BottomRight;

         //Show portions dropdown but only if all cells are visible.
         if not (OverlapsFixedCols(TargetRect) or OverlapsRHS(TargetRect)) then
         begin
            with PortionNameLookupCombo do
            begin
                Left := TargetRect.Left + dbgPortions.Left;
                Top := TargetRect.Top + dbgPortions.Top + 2;
                Width := TargetRect.Right - TargetRect.Left;
                Height := TargetRect.Bottom - TargetRect.Top - 2 ;

                Visible := True;
                BuildPortionComboBox;
                DroppedDown := True;
                SetFocus;
            end;
         end;
      end;
    end;
  end
  else
    PortionNameLookupCombo.Visible := False;

  //Handle context popup
  if (Button = mbRight) and (GridCoordinate.X >= dbgPortions.FixedCols) then
  begin
    PortiongridPopupMenu.Popup(ClientPoint.X,ClientPoint.Y);
  end;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  SelectedFieldName: String;
  TwinField, TwinField1, TwinField2: String;
  ColIdx: Integer;
  RowIdx: Integer;
begin
  //Only choosing colour for data cells
  if not (gdFixed in State) then
  begin
    ColIdx := TProtectionHackGrid(dbgPortions).Col;
    RowIdx := TProtectionHackGrid(dbgPortions).Row - 1;

    SelectedFieldName := dbgPortions.Fields[ColIdx].Fieldname;

    if (Pos('UnitName',SelectedFieldName) > 0) then
    begin
      TwinField := 'Quantity' + Copy(SelectedFieldName,Length('UnitName') + 1,MaxInt);
      TwinField1 := 'CostPrice' + Copy(SelectedFieldName,Length('UnitName') + 1,MaxInt);
      TwinField2 := 'IsMinor' + Copy(SelectedFieldName,Length('UnitName') + 1,MaxInt);
    end
    else if (Pos('Quantity',SelectedFieldName) > 0) then
    begin
      TwinField := 'UnitName' + Copy(SelectedFieldName,Length('Quantity') + 1,MaxInt);
      TwinField1 := 'CostPrice' + Copy(SelectedFieldName,Length('Quantity') + 1,MaxInt);
      TwinField2 := 'IsMinor' + Copy(SelectedFieldName,Length('Quantity') + 1,MaxInt);
    end
    else if (Pos('CostPrice',SelectedFieldName) > 0) then
    begin
      TwinField := 'UnitName' + Copy(SelectedFieldName,Length('CostPrice') + 1,MaxInt);
      TwinField1 := 'Quantity' + Copy(SelectedFieldName,Length('CostPrice') + 1,MaxInt);
      TwinField2 := 'IsMinor' + Copy(SelectedFieldName,Length('CostPrice') + 1,MaxInt);
    end
    else if (Pos('IsMinor',SelectedFieldName) > 0) then
    begin
      TwinField := 'UnitName' + Copy(SelectedFieldName,Length('IsMinor') + 1,MaxInt);
      TwinField1 := 'Quantity' + Copy(SelectedFieldName,Length('IsMinor') + 1,MaxInt);
      TwinField2 := 'CostPrice' + Copy(SelectedFieldName,Length('IsMinor') + 1,MaxInt);
    end;


    if  ((Field.FieldName = TwinField) or (Field.FieldName = TwinField1) or (Field.FieldName = TwinField2) or (Field.FieldName = SelectedFieldName))
    and (TwwCustomDbGrid(Sender).CalcCellRow = RowIdx) then
    begin
      ABrush.Color := ZonalBlue;
      AFont.Color := clWindowText;
    end;
  end
  else begin
    //make the fixed columns white just for aesthetic reasons.
    if not (Highlight) then
    begin
      ABrush.Color := clWindow;
      AFont.Color := clWindowText;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.dbgPortionPricesCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Copy(Field.FieldName, 1, 5) = 'Value' then
  begin
    ABrush.Color := clWindow;
    AFont.Color := clWindowText;
  end
  else
  begin
    ABrush.Color := clGradientInactiveCaption;
    AFont.Color := clWindowText;
  end;
end;

procedure TNewPortionIngredientsFrame.dbgPortionPricesDrawDataCell(
  Sender: TObject; const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
//  if Copy(Field.FieldName, 1, 5) = 'Value' then
//  begin
//    Inherited; //(Sender, Rect, Field, State)
//  end
//  else
//  begin
//    this.FillRect(Rect);
//  end;
end;


procedure TNewPortionIngredientsFrame.dbgPortionsCellChanged(Sender: TObject);
begin
  PortionNameLookupCombo.Visible := False;
  dbgPortions.Refresh;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsLeftColChanged(
  Sender: TObject; NewLeftCol: Integer);
begin
  if PortionNameLookupCombo.Visible then
    PortionNameLookupCombo.Visible := false;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsDrawGroupHeaderCell(
  Sender: TObject; Canvas: TCanvas; GroupHeaderName: String; Rect: TRect;
  var DefaultDrawing: Boolean);
var
  HorzPad: Integer;
  VertPad: Integer;
begin
  DefaultDrawing := false;
  if not OverlapsFixedCols(Rect) then
  begin
    if (Lowercase(GroupHeaderName) = 'standard') then
        begin
           dbgPortions.Canvas.Font.Style := [fsbold];
           dbgPortions.Canvas.Font.Color := clWindowText;
        end
        else begin
        if (IngredientsAsOfComboBox.Text = CURRENT_ITEM) then
           dbgPortions.Canvas.Font.Color := clBlue
        else
           dbgPortions.Canvas.Font.Color := clWindowText;
        end;
      end;

     HorzPad := (Rect.Right - Rect.Left - Canvas.TextWidth(Pchar(GroupHeaderName))) div 2;
     VertPad := (Rect.Bottom - Rect.Top - Canvas.TextHeight(Pchar(GroupHeaderName))) div 2;
     dbgPortions.Canvas.TextOut(Rect.Left + HorzPad,Rect.Top + VertPad,Pchar(GroupHeaderName));
end;

function TNewPortionIngredientsFrame.OverlapsFixedCols(_Rect: TRect): Boolean;
var
  RightEdgeOfFixedCols: Integer;
begin
  RightEdgeOfFixedCols := dbgPortions.CellRect(dbgPortions.FixedCols - 1,0).Right;
  Result := RightEdgeOfFixedCols > _Rect.Left;
end;

function TNewPortionIngredientsFrame.OverlapsRHS(_Rect: TRect): Boolean;
begin
  Result := (_Rect.Right = 0) or (_Rect.Right > (dbgPortions.Left + dbgPortions.Width));
end;

procedure TNewPortionIngredientsFrame.PortionNameLookupComboSelect(Sender: TObject);
var
  focusedPortion: integer;
  existingPortionType,
  selectedPortionType: integer;
  existingPortionName,
  selectedPortionName: string;
  portionPrice: Variant;
  fMaintPortionType: TfMaintPortionType;
begin
  selectedPortionType := -1;

  with PortionNameLookupCombo do
  begin
    if Items[ItemIndex] = NEW_ITEM then
    begin
      fMaintPortionType := TfMaintPortionType.Create(Self);

      try
        if fMaintPortionType.ShowModal = mrOk then
        begin
          selectedPortionType := fMaintPortionType.NewPortionId;
          selectedPortionName := fMaintPortionType.NewPortionName;
        end
      finally
        fMaintPortionType.Free;
      end;
    end
    else
    begin
      selectedPortionType := Integer(Items.Objects[ItemIndex]);
      selectedPortionName := Items[ItemIndex];
    end;
  end;

  if selectedPortionType = -1 then
    Exit;

  if PortionTypeExistsForEntity(selectedPortionType) then
  begin
    ShowMessage('Portion type ' + selectedPortionName + ' already exists for this product, but is not shown due to the current filter. ' + #13#10 +
                'To edit this portion type please amend or disable the portion type filter below.');
    Exit;
  end;

  focusedPortion := GetFocusedPortion;

  if FPortionsByDisplayOrder.PortionAssigned[focusedPortion] then
  begin
    existingPortionType := FPortionsByDisplayOrder.PortionId[focusedPortion];
    existingPortionName := FPortionsByDisplayOrder.PortionName[focusedPortion];

    if selectedPortionType = existingPortionType then
      Exit;

    //Give a warning if a portion is being deleted by replacing it with a different portion. But don't do this if the change
    //is in the future. (This could therefore cause problems in the future! Bug 357529 added GDM 11/02/14.)
    if ViewingCurrentData then
    begin
      if PortionUsedByAnotherNonDeletedProduct(existingPortionType) then
      begin
        if MessageDlg(
             'All products that currently use the ' + existingPortionName + ' portion will be changed to use the ' + selectedPortionName + ' portion.'#13#10#13#10+
             'Do you wish to continue ?',
              mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          Exit;
      end;

      //Note: Following proc called regardless of whether any non deleted products were found to use the portion. This is
      //because we also want to update deleted products, but no need to inform the user in this case.
      //Issue: Strictly speaking we would want to defer the execution of this until the whole product is saved so that it is
      //included in the save opeation's database transaction. As it stands if the product save fails for whatever reason we will have
      //ingredients which refer to a non-existent portion. It would be quite simple to implement such a deferred execution
      //of SQL queries: just need a TStringList with public AddSQL and ExectueSQL methods. ExecuteSQL execute each SQL
      //statement in turn and would be called within the Save transaction.
      ReplaceUsagesOfPortion(existingPortionType, selectedPortionType);
    end;


    with ProductsDb.ADOCommand do
    begin
      CommandText := Format(
        'UPDATE #TmpPortions SET PortionTypeId = %0:d, PortionName = ''%1:s'' WHERE DisplayOrder = %2:d',
        [selectedPortionType, selectedPortionName, focusedPortion]);
      Execute;
    end;
  end
  else
  begin
    with ProductsDb.ADOCommand do
    begin
      CommandText := Format(
        'INSERT #TmpPortions (PortionId, EntityCode, PortionTypeId, DisplayOrder, PortionName, DefaultCookTime) ' +
        'VALUES(%0:d, %1:f, %2:d, %3:d, ''%4:s'', %5:d)',
        [ProductsDB.GetNextPortionID, productsDB.ClientEntityTableEntityCode.Value, selectedPortionType, focusedPortion,
         selectedPortionName, 1]);
      Execute;
    end;
  end;


  ProductsDB.PortionChangesExist := True;

  FPortionsByDisplayOrder.AddPortion(focusedPortion, selectedPortionType, selectedPortionName);
  SetupPortionColumnGroups;

  if FShowPortionPrices then
  begin
    //Update the UI with the pricing values for the newly assigned portion.
    portionPrice := ProductsDb.GetCurrentBandAPrice(FPortionsByDisplayOrder.PortionId[focusedPortion]);

    with ProductsDb.PortionPricesTable do
    begin
      MovetoPricesTableRow(ppgvPortionPrice);
      Edit;
      FieldByName('OldValue' + IntToStr(focusedPortion)).AsVariant := portionPrice;

      //Only update the actual price from the database value if it is currently null. Whatever price the user may have
      //entered we want to keep.
      if FieldByName('Value' + IntToStr(focusedPortion)).IsNull then
        FieldByName('Value' + IntToStr(focusedPortion)).AsVariant := portionPrice;

      if (State = dsInsert) or (State = dsEdit) then
        Post;

      if FieldByName('Value' + IntToStr(focusedPortion)).AsVariant <> portionPrice then
        FPortionPriceChangesExist := True;
    end;
  end;

end;

function TNewPortionIngredientsFrame.PortionTypeExistsForEntity(PortionTypeID : Integer) : boolean;
begin
  with dmADO.adoqRun do
  begin
    SQL.Text := 'Select * from #TmpPortions where PortionTypeID = :PortionTypeID and EntityCode = :EntityCode';
    Parameters.ParamByName('PortionTypeID').Value := PortionTypeID;
    Parameters.ParamByName('EntityCode').Value := ProductsDB.CurrentEntityCode;
    Open;
    result := RecordCount > 0;
  end;
end;

function TNewPortionIngredientsFrame.IsInitialisedForCurrentProduct: boolean;
begin
  Result := (ProductsDB.CurrentEntityCode = FEntityCode);
end;

procedure TNewPortionIngredientsFrame.ForceReinitialise;
begin
  FEntityCode := -1;
  FEntityType := etNone;
  ProductsDB.PortionChangesExist := False;
  FPortionPriceChangesExist := False;
end;

procedure TNewPortionIngredientsFrame.EnsureInitialisedForCurrentProduct;
begin
  if IsInitialisedForCurrentProduct then
    Exit;

  InitialiseForCurrentProduct;
end;

procedure TNewPortionIngredientsFrame.InitialiseForCurrentProduct;
begin
  try
    FEntityCode := ProductsDB.CurrentEntityCode;
    FEntityType := ProductsDB.CurrentEntityType;

    if (not productsDB.ClientEntityTableEntityCode.IsNull) then
    begin
      FShowPortionPrices := ProductsDb.ShowPortionPrices and (FEntityType in [etStrdLine, etRecipe]);

      ProductsDB.PortionChangesExist := FALSE;
      FPortionPriceChangesExist := False;

      ClearCostPriceTotals;
      UpdateDisplay;
      RefeshCostPriceMode;
    end;
  except
     on E: Exception do
     begin
      FEntityCode := -1;
      FEntityType := etNone;

      Log.Event(Format(
        'Error in TNewPortionIngredientsFrame.InitialiseForCurrentProduct. Product=%0:f : %1:s',
        [ProductsDB.CurrentEntityCode, E.Message]));

      raise;
    end;
  end;
end;

//Initialise the portions data for the current product from the given product. If fullClone is
// True all portions data including ingredients are copied, if False only the portions and
// "self" ingredient quantity and unit (if this exists) are copied.
procedure TNewPortionIngredientsFrame.InitialiseFromAnotherProduct(fullClone: Boolean; baseEntityCode: Double; baseEntityType: EntType);
var i: integer;
begin
  try
    FEntityCode := ProductsDB.CurrentEntityCode;
    FEntityType := ProductsDB.CurrentEntityType;

    FShowPortionPrices := ProductsDb.ShowPortionPrices and (FEntityType in [etStrdLine, etRecipe]);

    //Rebuild the portion temp tables from the given product
    BuildTempTables(BaseEntityCode,CURRENT_ITEM);

    //Modify the data loaded into the temp tables accordingly
    with ProductsDB.ADOCommand do
    begin
      //Update self ingredient (if any) with correct entitycode
      CommandText :=
          'UPDATE #TmpPortionCrosstab ' +
          'SET EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString + ',name = null, description = null';

      for i := 1 to ProductsDB.MaxAllowedPortions do
        CommandText := CommandText + ', CostPrice' + IntToStr(i) + ' = null ';

      CommandText := CommandText +
          'WHERE EntityCode = ' + FloatToStr(baseEntityCode) + ' ';

      //If not doing a full clone delete all ingredients except for the "self" ingredient, if any.
      if not fullClone then
        CommandText := CommandText +
          'DELETE from #TmpPortionCrosstab ' +
          'WHERE EntityCode <> ' + productsDB.ClientEntityTableEntityCode.AsString + ' ';

      //Copy the old portions setup
      CommandText := CommandText +
          'declare portions_cur cursor for ' +
          '  select [portionid] ' +
          '  from #TmpPortions ' +

          'declare @portionid int ' +
          'declare @tempid int ' +
          'OPEN portions_cur ' +
          'FETCH NEXT FROM portions_cur INTO @portionid ' +

          'WHILE @@FETCH_STATUS = 0 ' +
          'BEGIN ' +
          '  exec GetNextUniqueID ' +
          '  @TableName = ''Portions'', ' +
          '    @IdField = ''PortionID'', ' +
          '    @RangeMin = 1, ' +
          '    @RangeMax = 2147483647, ' +
          '    @NextId = @tempid OUTPUT ' +
          '  UPDATE #TmpPortions ' +
          '  SET [PortionId] = @tempid ' +
          '  WHERE [PortionId] = @PortionId ' +
          '  FETCH NEXT FROM portions_cur INTO @portionid ' +
          'END ' +

          'CLOSE portions_cur ' +
          'DEALLOCATE portions_cur ' +

          'UPDATE #TmpPortions ' +
          'SET entitycode = ' + productsDB.ClientEntityTableEntityCode.AsString + ' ' +

          //Change this UPDATE depending on copyAllIngredients setting (change this to fullClone).
          //Should MinChoice/MaxChoice/SuppChoice/AllowPlain values be 0/1/0/0 as currently set in
          //TLineEditForm.CloneCurrentProduct? Is this table empty for a standard line/recipe?
          'UPDATE #TmpPortionChoices ' +
          'SET EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString + ', ' +
          '    PortionId = (SELECT PortionId FROM #TmpPortions WHERE DisplayOrder = 1) ';

          //If not doing a full clone set all Min/Max Choice settings to the defaults
      if not fullClone then
        CommandText := CommandText +
          ', EnableChoices = 0, MinChoice = NULL, MaxChoice = NULL, SuppChoice = NULL, AllowPlain = NULL ';

      CommandText := CommandText +
          'UPDATE #TmpPricesCrosstab SET ';

      for i := 1 to ProductsDB.MaxAllowedPortions do
        CommandText := CommandText + ifthen(i = 1, '', ', ') + 'Value' + IntToStr(i) + ' = null, OldValue' + IntToStr(i) + ' = null ';

      Execute;
    end;

    if fullClone and (baseEntityType = etChoice) then
    begin
      with ProductsDB.ADOQuery do
      try
        SQL.Text := 'SELECT CostPriceMode FROM ProductCostPriceMode WHERE EntityCode = ' + FloatToStr(baseEntityCode);
        Open;
        if not(EOF) then
        begin
          ProductsDB.adotProductCostPrice.Edit;
          ProductsDB.adotProductCostPriceCostPriceMode.AsInteger := FieldByName('CostPriceMode').AsInteger;
        end;
      finally
        Close;
      end;
    end;


    //Refresh the visible grid to show updates
    ProductsDB.qEditPortions.Close;
    ProductsDB.qEditPortions.Open;

    if FShowPortionPrices then
    begin
      ProductsDB.PortionPricesTable.Close;
      ProductsDB.PortionPricesTable.Open;
    end;

    SetupMinMaxChoices;

    ClearCostPriceTotals;
    RefreshDefaultCookTime;
    CreateDefaultAztecPortion;
    SetupEffectiveDates(ProductsDB.ClientEntityTable.FieldValues['entitycode']);
    SetupGrids;
    SetupContainers;
    if ProductsDB.CurrentEntityType = etChoice then
       dbgPortions.ColumnByName('IncludeByDefault').ReadOnly := ProductsDB.qEditPortions.RecordCount = 0;

    RefeshCostPriceMode;

    ProductsDB.PortionChangesExist := TRUE;
    FPortionPriceChangesExist := False;
  except
     on E: Exception do
     begin
      FEntityCode := -1;
      FEntityType := etNone;

      Log.Event(Format(
        'Error in TNewPortionIngredientsFrame.InitialiseFromAnotherProduct. This product=%0:f, other product=%1:f : %2:s',
        [ProductsDB.CurrentEntityCode, baseEntityCode, E.Message]));

      raise;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.ClearCostPriceTotals;
var i: integer;
begin
  for i := 1 to ProductsDB.MaxAllowedPortions do ClearCostPriceTotal(i);
end;

procedure TNewPortionIngredientsFrame.ClearCostPriceTotal(portion: integer);
const FOUR_DP_ZERO = '0.0000';
begin
  dbgPortions.ColumnByName('CostPrice'+IntToStr(portion)).FooterValue := FOUR_DP_ZERO;
end;

function TNewPortionIngredientsFrame.ValidChoiceIngredient(EntityCode: double): boolean;
var
  SavePlace: TBookMark;
begin
  Result := true;

  with dbgPortions.DataSource.DataSet do
  begin
    SavePlace := GetBookmark;
    try
      First;
      while not Eof do
      begin
        if (FieldValues['EntityCode'] = EntityCode) then
        begin
          Result := False;
          ShowMessage('The ingredient you have selected has already been added to this choice');
          break;
        end;
        next;
      end;
    finally
      GotoBookmark(SavePlace);
      FreeBookmark(SavePlace);
    end;
  end;
end;


//Return true if the currently selected product of the SelectEntityForm is an allowable ingredient of the current product.
function TNewPortionIngredientsFrame.IngredientIsAllowed: boolean;
begin
  Result := False;

  if (ProductsDB.CurrentEntityType = etChoice)
    and not(ValidChoiceIngredient(SelectEntityForm.getSelectedEntityCode)) then
    Exit;

  if ViewingCurrentData and not(CheckRecipeDepth(SelectEntityForm.getSelectedEntityCode, 0)) then
    Exit;

  // We can't add a special recipe to anything
  if SelectEntityForm.isSelectedSpecialRecipe then
  begin
    ShowMessage('A multi-divisional recipe may only be placed on a Variable Order Menu.');
    Exit;
  end;

  if SelectEntityForm.isSelectedSoldByWeight then
  begin
    ShowMessage('A sold by weight product may not be an ingredient of any other product.');
    Exit;
  end;

  if SelectEntityForm.isSelectedUsingContainers then
  begin
    ShowMessage('A product using containers may not be an ingredient of any other product.');
    Exit;
  end;

  Result := True;
end;


procedure TNewPortionIngredientsFrame.CreateIngredient(IngredientDisplayOrder: Integer);
var
  AppendEntry: boolean;
  IngredientAdded: boolean;
  portionDisplayOrder: string;
begin
  IngredientAdded := False;
  AppendEntry := (IngredientDisplayOrder = -1);

  if (dbgPortions.DataSource.DataSet.State = dsInsert) or (dbgPortions.DataSource.DataSet.State = dsEdit) then
    dbgPortions.DataSource.DataSet.Post;

  // check if OtherFlags allows to do the addition
  if not CanAddPortionForProductFlags(ProductsDB.CurrentEntityCode) then
  begin
    ShowMessage('Product is flagged as "Is Donation" or "Is Footfall". Please remove these flags to continue.');
    Exit;
  end;

  dbgPortions.DataSource.DataSet.DisableControls;

  try
    // Filter entity chooser to only allow valid entity types.
    case FEntityType of
      etChoice:
        SelectEntityForm.setFilter( [etStrdLine,etRecipe,etChoice,etInstruct],
                                    ProductsDB.CurrentEntityCode );

      else //etRecipe, etStrdLine
        SelectEntityForm.setFilter( [etStrdLine,etRecipe,etPurchLine,etPrepItem,etChoice],
                                    ProductsDB.CurrentEntityCode );
    end;

    SelectEntityForm.setCaptionAndHelpId('Add Portion Ingredient', 'Select the item to add:', AZPM_ADD_PORTION_INGRED_FORM );

    if SelectEntityForm.ShowModal <> mrOk then
      Exit;

    //TODO: It may be worth moving the following check to the SelectEntityForm and perform it on the OK button click.
    // That is where the min/max choice checks are already performed! It means the dialog stays open with the offending
    //product still selected should the check fail, which is good from a usability point of view. GDM
    if not IngredientIsAllowed then
      Exit;

    // All OK, add this item to the portion
    try
      if AppendEntry then
      begin
        //we want to insert the ingredient at the end of the list
        dbgPortions.DataSource.DataSet.Last;
        if dbgPortions.DataSource.DataSet.Bof then
          ingredientDisplayOrder := 1
        else
          ingredientDisplayOrder := dbgPortions.DataSource.DataSet.FieldValues['DisplayOrder'] + 1;
      end
      else
      begin
        // we want to insert the ingredient at the specified display order
        RenumberIngredientDisplayOrders(ingredientDisplayOrder);
      end;

      // Now create record
      InsertIntoPortion(ingredientDisplayOrder);

      ProductsDB.PortionChangesExist := True;

      ProductsDb.LogProductChange('Ingredient added to ' + GetSelectedDate + ' recipe: "' + SelectEntityForm.getSelectedRetailName + '" (' +
        FloatToStr(SelectEntityForm.getSelectedEntityCode) + ')');

      IngredientAdded := True;
    except
      on E: Exception do begin
        Log.Event('Cannot create ingredient: ' + E.Message);
        ShowMessage( 'Cannot create ingredient:'#13#10 + E.Message );
        ProductsDB.qEditPortions.Cancel;
      end;
    end;
  finally
    ProductsDB.qEditPortions.Close;
    ProductsDB.qEditPortions.Open;
    if ProductsDB.CurrentEntityType = etChoice then
         dbgPortions.ColumnByName('IncludeByDefault').ReadOnly := ProductsDB.qEditPortions.RecordCount = 0;
    SetCostPriceToShowFourDecimalPlaces;
    GridEnableControls;
    if AppendEntry then
      dbgPortions.DataSource.DataSet.Last
    else
      dbgPortions.Datasource.Dataset.Locate('DisplayOrder', ingredientDisplayOrder, []);
  end;

 //Automatically launch the dialog for choosing the ingredient quantity.
  if IngredientAdded then
  begin
    dbgPortions.SelectedIndex := dbgPortions.FixedCols; //Make sure the first portion is selected.
    portionDisplayOrder := IntToStr(GetFocusedPortion);

    EditIngredientActionExecute(nil);

    // check if added ingredient doesn't have any info (ie Edit box was cancelled rather than okayed)
    if ( dbgPortions.DataSource.DataSet.FieldByName('quantity' + portionDisplayOrder).AsInteger = 0 ) and
       (dbgPortions.DataSource.DataSet.FieldByName('UnitName' + portionDisplayOrder).AsString = '') then
      // delete ingredient without confirmation
      RemoveIngredient(nil, false);
  end;

  // check proper flags visibility after adding an ingredient
  if (ProductsDB.CurrentEntityType in [etStrdLine,etRecipe]) then begin
    LineEditForm.checkOtherFlagsVisibility(ProductsDB.CurrentEntityType, false);
  end;
end;

function TNewPortionIngredientsFrame.GetSelectedDate: string;
begin
  if IngredientsAsOfComboBox.Items[IngredientsAsOfComboBox.ItemIndex] <> CURRENT_ITEM then
    Result := FEffectiveDates[IngredientsAsOfComboBox.ItemIndex-1].GetAsISODateFormat
  else
    Result := CURRENT_ITEM;
end;

procedure TNewPortionIngredientsFrame.GridEnableControls;
begin
  dbgPortions.DataSource.DataSet.EnableControls;
  SetGridTabStops; //Restore the tabs stops which, annoyingly, are lost after calling EnableControls.
end;

procedure TNewPortionIngredientsFrame.SetGridTabStops;
var i: integer;
begin
  // Set the first of each portion's group of columns to be a tab stop so that a single press of the Tab
  //key moves to the next portion.
  with dbgPortions do
    for i := FixedCols to GetColCount - 1 do
      TabStops[i] := ((i - FixedCols + 1) mod COLUMNS_PER_PORTION) = 1
end;

procedure TNewPortionIngredientsFrame.InsertIngredientActionExecute(  Sender: TObject);
begin
  //Using the active row as a pseudo bookmark here due to the need
  //to call a requery.
    if not (dbgPortions.DataSource.DataSet.Bof and dbgPortions.DataSource.DataSet.Eof) then
      CreateIngredient( dbgPortions.DataSource.DataSet.FieldValues['DisplayOrder'] )
    else
      CreateIngredient( -1);
end;

procedure TNewPortionIngredientsFrame.AppendIngredientActionUpdate(
  Sender: TObject);
begin
  if not dbgPortions.DataSource.DataSet.Active or FNoPortionsVisible then
    (Sender as TAction).Enabled := false
  else
    (Sender as TAction).Enabled := (dbgPortions.DataSource.DataSet.RecordCount < MaxIngredients);
end;

procedure TNewPortionIngredientsFrame.EditIngredientActionUpdate(
  Sender: TObject);
var
  DisplayOrder: Integer;
begin
  if not dbgPortions.DataSource.DataSet.Active or FNoPortionsVisible then
    (Sender as TAction).Enabled := false
  else begin
    DisplayOrder := GetFocusedPortion;

    (Sender as TAction).Enabled :=
          ((dbgPortions.DataSource.DataSet.State = dsInsert) or
          not (dbgPortions.DataSource.DataSet.Bof and dbgPortions.DataSource.DataSet.Eof))
      and FPortionsByDisplayOrder.PortionAssigned[DisplayOrder];
  end;
end;

procedure TNewPortionIngredientsFrame.RefreshDisplay(EffectiveDate: String);
begin
  //Stop the grid drawing while we build our working dataset
  dbgPortions.BeginUpdate;
  dbgPortionPrices.BeginUpdate;
  try
    BuildTempTables(ProductsDB.ClientEntityTable.FieldValues['entitycode'],EffectiveDate);

    CreateDefaultAztecPortion;

    if FEntityType = etStrdLine then
      EnsureSelfIngredientExists;
  finally
    dbgPortions.EndUpdate;
    dbgPortionPrices.EndUpdate;
  end;

  RefreshDefaultCookTime;

  SetupGrids;

  if ProductsDB.CurrentEntityType = etChoice then
     SetupMinMaxChoices;

  SetupContainers;
end;

function TNewPortionIngredientsFrame.CheckRecipeDepth(EntityCode: double; Depth: integer): boolean;
var
  InitialInstance: Boolean;
  Query: TADOQuery;

  function ProductHasAssociatedContainers: Boolean;
  var
    q: TADOQuery;
  begin
    q := TADOQuery.Create(Self);
    try
      q.Connection := dmado.AztecConn;
      with q do
      begin
        if not ProductsDB.PortionChangesExist then
        begin
          SQL.Add('select count(*) as ContainerCount from products p');
          SQL.Add('join portions po');
          SQL.Add('on p.EntityCode = po.EntityCode');
          SQL.Add('where p.EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString);
          SQl.Add('and ContainerID is not null');
        end
        else begin
          SQL.Add('select count(*) as ContainerCount from #tmpPortions where ContainerId is not null');
        end;

        Open;

        Result := (FieldByName('ContainerCount').AsInteger > 0);
      end;
    finally
      q.Free;
    end;
  end;

begin
  Result := True;
  InitialInstance := False;

  //TODO (REFACTOR): Get rid of this InitialInstance rubbish!!!! It just overcomplicates the code.
  //Instead simply call the code within the "if Depth = 0" clause
  // prior to this procedure call along with the "if Depth = MAX_RECIPE_DEPTH" check. If the check fails call this procedure
  // which will now only check the selected ingredient and its descendants - will need to pass in the parent max depth to
  //perform the overall depth check. GDM
  if Depth = 0 then
  begin
    InitialInstance := True;

    ParentEntityList := TStringList.Create;
    ParentEntityTypeSet := [];
    ParentEntityList.Add(format('%f', [ProductsDB.CurrentEntityCode]));

    Depth := ProductsDB.GetMaxDepth(ProductsDB.CurrentEntityCode, ParentEntityList);
  end;

  if (etChoice in ParentEntityTypeSet) then
  begin
    if ProductsDB.ClientEntityTableSoldByWeight.AsBoolean then
    begin
      ShowMessage('Cannot insert ingredient.  Sold by weight products cannot contain choices.');
      Result := False;
    end
    else if ProductHasAssociatedContainers then
    begin
      ShowMessage('Cannot insert ingredient.  Products associated with containers cannot contain choices.');
      Result := False;
    end;
  end;

  //Only do this next, potentiallly expensive, bit if the previous checks on sold by weight products pass.
  if Result then
    if (Depth = MAX_RECIPE_DEPTH) then
    begin
      ShowMessage('Cannot insert ingredient.  Nesting of Portion Ingredients may not exceed ' + IntToStr(MAX_RECIPE_DEPTH) + ' levels.');
      Result := False;
    end
    else begin
      Query := TADOQuery.Create(Self);
      try
        with Query do
        begin
          Connection := dmADO.AztecConn;
          SQL.Clear;
          SQL.Add('select distinct po.EntityCode, p.[Entity Type], pi.IngredientCode');
          SQL.Add('from Portions po');
          SQL.Add('inner join PortionIngredients pi');
          SQL.Add('on po.PortionID = pi.PortionID');
          SQL.Add('inner join products p');
          SQL.Add('on p.EntityCode = po.[EntityCode]');
          SQL.Add('where po.EntityCode = ' + format('%f', [EntityCode]));
          SQL.Add('and pi.IngredientCode <> ' + format('%f', [EntityCode]));
          Open;

          if RecordCount > 0 then
          begin
            while not EOF do
            begin
              ParentEntityTypeSet := ParentEntityTypeSet + [EntTypeStringToEnum(FieldByName('Entity Type').AsString)];
              if ParentEntityList.IndexOf(format('%f', [FieldByName('IngredientCode').AsFloat])) <> -1 then
              begin
                ShowMessage('Cannot insert ingredient as it already exists as a nested ingredient.');
                Result := False;
                Break;
              end;

              if not CheckRecipeDepth(FieldByName('IngredientCode').AsFloat, Depth + 1) then
              begin
                Result := False;
                Break;
              end;

              Next;
            end;
          end;
        end;
      finally
        Query.Close;
        Query.Free;
      end;
    end;

  if InitialInstance then
    ParentEntityList.Free;
end;

procedure TNewPortionIngredientsFrame.RenumberIngredientDisplayOrders( makeSpaceForDisplayOrder: Integer );
begin
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update #tmpportioncrosstab');
    SQL.Add('set displayorder = displayorder + 1');
    SQL.Add('where displayorder >= ' + format('%d', [makespacefordisplayorder]));
    ExecSQL;
  end;
end;

procedure TNewPortionIngredientsFrame.InsertIntoPortion(ingredientOrder: integer);
begin
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert #tmpportioncrosstab (entitycode,name,description,displayorder)');
    SQL.Add('select');
    SQl.Add(  Format('%f',[SelectEntityForm.getSelectedEntityCode]) + ',');
    SQL.Add(' [Extended RTL Name], [Retail Description],');
    SQL.Add(  IntToStr(IngredientOrder));
    SQL.Add('from Products p');
    SQL.Add('where p.EntityCode = ''' + format('%f', [SelectEntityForm.getSelectedEntityCode]) + '''');
    ExecSQL;
  end;
end;

// Returns the DisplayOrder of the portion that currently has focus on the grid.
function TNewPortionIngredientsFrame.GetFocusedPortion: Integer;
var
  activeCol: Integer;
  gridPosition: integer;
begin
  activeCol := dbgPortions.GetActiveCol;
  if activeCol > 1 then
  begin
    gridPosition := ((activeCol - dbgPortions.FixedCols) div COLUMNS_PER_PORTION) + 1;
    Result := FGridPositionToPortionDisplayOrder[gridPosition];
  end
  else
    Result := -1;
end;

procedure TNewPortionIngredientsFrame.AppendIngredientActionExecute(
  Sender: TObject);
begin
  //Using the active row as a pseudo bookmark here due to the need
  //to call a requery.
    CreateIngredient(-1);
end;

procedure TNewPortionIngredientsFrame.EditIngredientActionExecute(Sender: TObject);
var
  PortionID: String;
  PortionID_int: integer;
  i: integer;
  finished: boolean;
  EffectiveDate: string;
  LogText: string;
begin
  //If the parent is a standard product and the ingredient to be edited is itself then
  //check first that the stock unit has been entered on the Supplier tab.
  if dbgPortions.DataSource.DataSet.FieldByName('entitycode').AsFloat = ProductsDB.CurrentEntityCode then
    if ProductsDB.ClientEntityTablePurchaseUnit.Value = '' then begin
        ShowMessage('You must first enter the Stock Unit for this product');
        exit;
    end;

  if (dbgPortions.DataSource.DataSet.State = dsInsert) or (dbgPortions.DataSource.DataSet.State = dsEdit) then
    dbgPortions.DataSource.DataSet.Post;

  EffectiveDate := GetSelectedDate;

  PortionId_int := GetFocusedPortion;
  finished := False;
  PortionIngredientDialog.AllowPortionNavigation := (FPortionsByDisplayOrder.NumberOfVisiblePortions > 1);

  while not(finished) do
  begin

    dbgPortions.DataSource.DataSet.DisableControls;
    try
      // Display dialog to set unit and quantity values
      PortionID := InttoStr(PortionId_int);

      PortionIngredientDialog.Title := FPortionsByDisplayOrder.PortionName[PortionId_int];
      PortionIngredientDialog.setIngredientDetails(dbgPortions.DataSource.DataSet.FieldByName('EntityCode').AsFloat,
                                                   dbgPortions.DataSource.DataSet.FieldByName('UnitName'+PortionID).AsString,
                                                   dbgPortions.DataSource.DataSet.FieldByName('portioningredients_portiontypeid'+PortionID).AsInteger,
                                                   dbgPortions.DataSource.DataSet.FieldByName('Quantity'+PortionID).AsFloat,
                                                   dbgPortions.DataSource.DataSet.FieldByName('CalculationType'+PortionID).AsInteger,
                                                   FPortionsByDisplayOrder.AllowFactorQuantities(PortionId_int),
                                                   FEntityType,
                                                   dbgPortions.DataSource.DataSet.FieldByName('IsMinor'+PortionID).AsBoolean);

      PortionIngredientDialog.SelectedPortionTypeID := PortionId_int;
      PortionIngredientDialog.EffectiveDate := EffectiveDate;

      with dbgPortions.DataSource.DataSet do
      begin
        if (PortionIngredientDialog.ShowModal = mrOk) then
        begin
          Edit;

          FieldByName('CalculationType' + PortionID).Value := PortionIngredientDialog.getCalculationType;
          Case PortionIngredientDialog.getCalculationType of
            ord(calcUnspecified) :
              begin
                FieldByName('UnitName'+PortionID).Clear;
                FieldByName('portioningredients_portiontypeid'+PortionID).Clear;
              end;
            ord(calcUnit) :
              begin
                FieldByName('UnitName'+PortionID).Value := PortionIngredientDialog.getUnitName;
                FieldByName('portioningredients_portiontypeid'+PortionID).Clear;
                FieldByName('CostPrice'+PortionId).Value :=
                   ProductsDb.GetUnitBudgetedCostPrice(StrToInt64(FieldByName('EntityCode').AsString),
                                                       PortionIngredientDialog.getUnitName,
                                                       PortionIngredientDialog.getQuantity, EffectiveDate);
              end;
            ord(calcPortion) :
              begin
                FieldByName('UnitName'+PortionID).Clear;
                FieldByName('portioningredients_portiontypeid'+PortionID).Value := PortionIngredientDialog.getPortionTypeID;
                FieldByName('CostPrice'+PortionId).Value :=
                   ProductsDb.GetPortionBudgetedCostPrice(StrToInt64(FieldByName('EntityCode').AsString),
                                                       PortionIngredientDialog.getPortionTypeID,
                                                       PortionIngredientDialog.getQuantity, EffectiveDate);
              end;
            ord(calcFactor) : // factor
              begin
                FieldByName('UnitName'+PortionID).Clear;
                FieldByName('portioningredients_portiontypeid'+PortionID).Clear;
                FieldByName('CostPrice'+PortionId).Value := FieldByName('CostPrice1').AsCurrency * PortionIngredientDialog.getQuantity;
              end;
          else // null
            begin
              FieldByName('UnitName'+PortionID).Clear;
              FieldByName('portioningredients_portiontypeid'+PortionID).Clear;
            end;
          end;
          FieldByName('Quantity'+PortionID).Value := PortionIngredientDialog.getQuantity;
          FieldByName('IsMinor'+PortionID).Value := PortionIngredientDialog.getIsMinor;

          FieldByName('UnitName'+PortionID).Value := DetermineUnitName(FieldByName('portioningredients_portiontypeid'+PortionID).AsInteger,
            FieldByName('CalculationType' + PortionID).AsInteger,
            FieldByName('UnitName'+PortionID).AsString);

          //If the Standard portion size has changed recalculate the cost price of any other portions that are
          //defined as a Factor of it.
          if PortionId = '1' then
          begin
            for i := 2 to ProductsDB.MaxAllowedPortions do
               if FieldByName('CalculationType' + IntToStr(i)).AsInteger = ord(calcFactor) then
                 //Note: In the statement below AsCurrency is used against the Quantity Tfield because the underlying
                 //database type is Decimal(10,4) and therefore the Delphi currency type is suitable.
                 FieldByName('CostPrice' + IntToStr(i)).Value := FieldByName('CostPrice1').AsCurrency * FieldByName('Quantity' + IntToStr(i)).AsCurrency;
          end;

          Post;
          ProductsDB.PortionChangesExist := True;

          // Log the details of the changes to the product modelling log file
          if FieldByName('CalculationType' + PortionID).OldValue <> FieldByName('CalculationType' + PortionID).NewValue then
            LogText := LogText +
              'Calculation type changed from "' +
              CalcTypeEnumToString(TCalculationType(ProductsDb.VarToInt(FieldByName('CalculationType' + PortionID).OldValue))) +
              '" to "' +
              CalcTypeEnumToString(TCalculationType(ProductsDb.VarToInt(FieldByName('CalculationType' + PortionID).NewValue))) + '". ';

          if FieldByName('UnitName' + PortionID).OldValue <> FieldByName('UnitName' + PortionID).NewValue then
            LogText := LogText +
              'Unit/Portion Name changed from "' +  VarToStr(FieldByName('UnitName' + PortionID).OldValue) + '" to "' +
              VarToStr(FieldByName('UnitName' + PortionID).NewValue) + '". ';


          //Note: The variants OldValue & NewValue are converted to strings before comparing them here. This is only
          //because without the conversion the error "Invalid variant operation" is sometimes given because OldValue
          //is evaluating to "Unknown type: 24". Delphi bug?
          if VarToStr(FieldByName('Quantity' + PortionID).OldValue) <> VarToStr(FieldByName('Quantity' + PortionID).NewValue) then
            LogText := LogText +
              'Quantity changed from "' + VarToStr(FieldByName('Quantity' + PortionID).OldValue) + '" to "' +
              VarToStr(FieldByName('Quantity' + PortionID).NewValue) + '". ';

          if LogText <> '' then
            ProductsDb.LogProductChange('Ingredient "' + FieldByName('Name').AsString +
               '" (' + FieldByName('EntityCode').AsString + ') edited for ' +
               FPortionsByDisplayOrder.PortionName[PortionId_int] + ' portion of ' + GetSelectedDate + ' recipe: ' + LogText);

          RefreshCostPriceTotals;
        end; // if (PortionIngredientDialog.ShowModal = mrOk)
      end; // with dbgPortions.DataSource.DataSet do

    finally
      // If record is not saved then something went wrong - cancel any changes.
      if (dbgPortions.DataSource.DataSet.State = dsInsert) or (dbgPortions.DataSource.DataSet.State = dsEdit) then
        dbgPortions.DataSource.DataSet.Cancel;

      GridEnableControls;
    end;

    if PortionIngredientDialog.NextPressed then
      PortionId_int := FPortionsByDisplayOrder.NextAssignedPortion(PortionId_int)
    else if PortionIngredientDialog.PrevPressed then
      PortionId_int := FPortionsByDisplayOrder.PreviousAssignedPortion(PortionId_int)
    else
      finished := True;
  end; { while not(finished) }

end;

function TNewPortionIngredientsFrame.PortionExistsInTheFuture(portionType: integer): boolean;
begin
  with ProductsDB.ADOQuery do
  try
     SQL.Text :=
        'IF EXISTS ( ' +
           'SELECT TOP 1 * FROM PortionsFuture ' +
           'WHERE EntityCode = ' +  Format('%f', [ProductsDB.CurrentEntityCode]) +
           'AND PortionTypeID = ' + IntToStr(portionType) + ')' +
        'SELECT 1 AS Result ' +
        'ELSE ' +
        'SELECT 0 AS Result';
     Open;
     Result := (FieldByName('Result').AsInteger = 1);
   finally
     Close;
   end;
end;

procedure TNewPortionIngredientsFrame.DeletePortionFromTheFuture(portionType: integer);
begin
   with ProductsDB.ADOCommand do
   begin
     CommandText := Format('DELETE PortionsFuture WHERE EntityCode = %0:f AND PortionTypeID = %1:d',
      [ProductsDB.CurrentEntityCode, portionType]);
     Execute;
   end;
end;

function TNewPortionIngredientsFrame.PortionUsedByAnotherNonDeletedProduct(portionType: integer): boolean;
  var
  IfExistsSQL: String;
begin
  IfExistsSQL:=
  'IF EXISTS (' +
         'SELECT TOP 1 * FROM %s a ' +
         '               JOIN Products b ' +
         '               ON a.IngredientCode = b.EntityCode ' +
         'WHERE ISNULL(b.Deleted, ''N'') = ''N'' ' +
         'AND IngredientCode = ' +  Format('%f', [ProductsDB.CurrentEntityCode]) +
         ' AND PortionTypeID = ' + IntToStr(portionType) + ') ' +
      'SELECT 1 AS Result ';
  with ProductsDB.ADOQuery do
  try
    SQL.Text :=
      Format(IfExistsSQL, ['PortionIngredients ']) +
      'ELSE ' +
      'BEGIN ' +
      Format(IfExistsSQL, ['PortionIngredientsFuture ']) +
      'ELSE ' +
      'SELECT 0 AS Result ' +
      'END;';
    Open;
    Result := (FieldByName('Result').AsInteger = 1);
  finally
    Close;
  end;
end;

//Remove the given portion of the product currently being edited from the ingredient list of all recipes etc.
procedure TNewPortionIngredientsFrame.RemovePortionFromAllProducts(const portionType: integer);
begin
  with ProductsDB.ADOCommand do
  begin
    CommandText := Format('DELETE PortionIngredients WHERE IngredientCode = %0:f AND PortionTypeID = %1:d; ' +
                          'DELETE PortionIngredientsFuture WHERE IngredientCode = %0:f AND PortionTypeID = %1:d; ',
                   [ProductsDB.CurrentEntityCode, portionType]);
    Execute;
  end;
end;

//Replace all ingredients that use the oldPortionType of the current product to instead use the newPortionType.
procedure TNewPortionIngredientsFrame.ReplaceUsagesOfPortion(const oldPortionType, newPortionType: integer);
begin
  with ProductsDB.ADOCommand do
  begin
    CommandText := Format(
      'UPDATE PortionIngredients SET PortionTypeId = %0:d WHERE IngredientCode = %1:f AND PortionTypeID = %2:d; ' +
      'UPDATE PortionIngredientsFuture SET PortionTypeId = %0:d WHERE IngredientCode = %1:f AND PortionTypeID = %2:d;',
      [newPortionType, ProductsDB.CurrentEntityCode, oldPortionType]);
    Execute;
  end;
end;


procedure TNewPortionIngredientsFrame.DeletePortionActionExecute(Sender: TObject);
var
  PortionType: integer;
  DisplayOrder: integer;
  DisplayOrderStr: string;
  PortionName: string;
  bkmark: TBookmark;
begin

  Assert(ViewingCurrentData, 'Failed due to entering the delete action of a future portion');

  DisplayOrder := GetFocusedPortion;
  DisplayOrderStr := InttoStr(DisplayOrder);
  PortionName := FPortionsByDisplayOrder.PortionName[DisplayOrder];

  if MessageDlg('The ' + portionName + ' portion will be deleted.' +
   #13#10 + 'Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Assert(FPortionsByDisplayOrder.PortionAssigned[DisplayOrder], 'Failed to discover the details of the portion to be deleted');

  PortionType := FPortionsByDisplayOrder.PortionId[DisplayOrder];

  //Give a warning if the portion to be deleted is used by another product. But don't do this if the portion is to be
  //deleted in the future. (This could therefore cause problems in the future! Bug 357529 added GDM 11/02/14.)

  if PortionExistsInTheFuture(PortionType) then
     DeletePortionFromTheFuture(PortionType);

  if PortionUsedByAnotherNonDeletedProduct(PortionType) then
    begin
      if MessageDlg('There are other products that use the ' + PortionName + ' portion of this product.'#13#10+
                    'If you continue this portion will be removed from these products.'#13#10#13#10+
                    'Do you wish to continue ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        Exit;
    end;

  //Note: Following proc called regardless of whether any non deleted products were found to use the portion. This is
  //because we also want to remove the portion from deleted products, but no need to inform the user in this case.
  RemovePortionFromAllProducts(PortionType);

  ProductsDB.ADOCommand.CommandText :=
        'DELETE #TmpPortions WHERE DisplayOrder = ' + DisplayOrderStr;
  ProductsDB.ADOCommand.Execute;
  ProductsDB.PortionChangesExist := True;

  with dbgPortions.DataSource.DataSet do
  begin
    DisableControls;
    bkmark := GetBookmark;
    try
      with ProductsDB.qEditPortions do
      begin
        First;
        While not EOF do
        begin
          Edit;
          FieldByName('UnitName'+DisplayOrderStr).Value := Null;
          FieldByName('Quantity'+DisplayOrderStr).Value := Null;
          FieldByName('CalculationType'+DisplayOrderStr).Value := Null;
          FieldByName('Portioningredients_PortionTypeID'+DisplayOrderStr).Value := Null;
          FieldByName('CostPrice'+DisplayOrderStr).Value := Null;
          Post;
          Next;
        end;

        if  (state = dsInsert) or (state = dsEdit) then
          Post;
      end;

      FPortionsByDisplayOrder.Clear(DisplayOrder);
      SetupPortionColumnGroups;
      GotoBookmark(bkmark);
      GridEnableControls;
    finally
      FreeBookmark(bkmark);
    end;
  end;

  ClearCostPriceTotal(DisplayOrder);

  if FShowPortionPrices then
  begin
    //Clear all pricing information from the UI.
    // Note that this will not cause prices for this portion to be removed from the database. Should a bug be raised for this perhaps? GDM 6/2/14
    with ProductsDb.PortionPricesTable do
    begin
      DisableControls;
      bkmark := GetBookmark;
      try
        First;
        while not EOF do
        begin
          Edit;
          FieldByName('Value' + DisplayOrderStr).Clear;
          FieldByName('OldValue' + DisplayOrderStr).Clear;
          Post;
          Next;
        end;

        if  (state = dsInsert) or (state = dsEdit) then
           Post;

        GotoBookmark(bkmark);
      finally
        FreeBookmark(bkmark);
        EnableControls;
      end;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.DeletePortionActionUpdate(
  Sender: TObject);
begin
  if not (IngredientsAsOfComboBox.Text = CURRENT_ITEM) then
    (Sender as TAction).Enabled := false
  else begin
     if not (dbgPortions.DataSource.DataSet.Active) then
       (Sender as TAction).Enabled := false
     else begin
       (Sender as TAction).Enabled := (FPortionsByDisplayOrder[GetFocusedPortion]) and
         (GetFocusedPortion <> 1);

       //Set a user friendly caption for use in the context menu
       (Sender as TAction).Caption := 'Delete Portion';
       if FPortionsByDisplayOrder.PortionName[GetFocusedPortion] <> '' then
         (Sender as TAction).Caption := 'Delete "' +
                                      FPortionsByDisplayOrder.PortionName[GetFocusedPortion] +
                                      '" portion';
     end;
  end;
end;


procedure TNewPortionIngredientsFrame.dbgPortionsDblClick(Sender: TObject);
var
  GridCoord: TGridCoord;
  ClientPoint: TPoint;
begin
  ClientPoint := dbgPortions.ScreenToClient(Mouse.CursorPos);
  GridCoord := dbgPortions.MouseCoord(ClientPoint.X,ClientPoint.Y);
  if (GridCoord.Y > 0) and (GridCoord.X > dbgPortions.FixedCols - 1) then
  begin
    EditIngredientAction.Execute;
  end;
end;

function TNewPortionIngredientsFrame.DetermineUnitName(PortionTypeID: Integer;
  CalculationType: Integer;
  UnitName: String): String;
begin
  if CalculationType <> 0 then
  begin
      case CalculationType of
        ord(calcUnit):
          Result := UnitName;

        ord(calcPortion):
          begin
            if PortionTypeID = 0 then
               Exit;
            if not ProductsDB.PortionTypeTable.Active then
              ProductsDB.PortionTypeTable.Active := TRUE;
            Result := ProductsDB.PortionTypeTable.Lookup('PortionTypeID',
              PortionTypeID,
              'PortionTypeName');
          end;

        ord(calcFactor):
          Result := 'Factor';

        else
          Result := '';
      end;
  end;
end;

procedure TNewPortionIngredientsFrame.SetupEffectiveDates(_EntityCode: Double);
var
  Target: String;
  InsertionPoint: Integer;
begin
  if not Assigned(FEffectiveDates) then
  begin
    FEffectiveDates := TAztecDateList.Create(ShortDateFormat);
  end
  else begin
    FEffectiveDates.Clear;
    FOld_EffectiveDate := '';
  end;

  //Check we have an entity code first?
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    Target := format('%f', [_EntityCode]);
    SQL.Text := 'select distinct dbo.fn_DateFromDateTime(pf.[EffectiveDate]) as ''effdate'' '
      + 'from portionsfuture pf '
      + 'where pf.entitycode = ' + Target + ' '
      + 'order by dbo.fn_DateFromDateTime(pf.[EffectiveDate]) desc';
    Open;

    while not EOF do
    begin
      FEffectiveDates.AddDate(FieldByName('effdate').AsDateTime,InsertionPoint);
      Next;
    end;
  end;
  SetupEffectiveDates(FEffectiveDates.Text);
end;

procedure TNewPortionIngredientsFrame.IngredientsAsOfComboBoxChange(Sender: TObject);
begin
  with sender as TComboBox do
  begin
    if ItemIndex = Items.IndexOf(NEW_ITEM) then
    begin
      ItemIndex := Items.IndexOf(FOld_EffectiveDate);

      //Make sure we have an up-to-date copy of the data
      if ItemIndex = Items.IndexOf(CURRENT_ITEM) then
        GetIngredientsForDate(CURRENT_ITEM)
      else
        GetIngredientsForDate(FEffectiveDates[ItemIndex - 1].AsISODateFormat);

      //Add a new effective date - the currently chosen data will be saved to
      //this new date whenever the IngredientsAsOf combo-box changes or a new
      //product is chosen.
      CreateNew;

      Parent.SetFocus;
    end
    else if ItemIndex = Items.IndexOf(CURRENT_ITEM) then
    begin
      GetIngredientsForDate(CURRENT_ITEM);
    end
    else begin
      GetIngredientsForDate(FEffectiveDates[ItemIndex - 1].AsISODateFormat);
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.SetupEffectiveDates(EffectiveDates: String);
begin
  IngredientsAsOfComboBox.Items.Clear;
  IngredientsAsOfComboBox.Items.Text := EffectiveDates;

  if (IngredientsAsOfComboBox.Items.IndexOf(NEW_ITEM) = -1) and not ProductsDB.CurrentEntityControlledByRM then
    IngredientsAsOfComboBox.Items.Add(NEW_ITEM)
  else if (IngredientsAsOfComboBox.Items.IndexOf(NEW_ITEM) <> -1) and ProductsDB.CurrentEntityControlledByRM then
    IngredientsAsOfComboBox.Items.Delete(IngredientsAsOfComboBox.Items.IndexOf(NEW_ITEM));

  if (IngredientsAsOfComboBox.Items.IndexOf(CURRENT_ITEM) = -1) then
    IngredientsAsOfComboBox.Items.Insert(0,CURRENT_ITEM);

  if FOld_EffectiveDate = '' then
    IngredientsAsOfComboBox.ItemIndex := 0
  else
    IngredientsAsOfComboBox.ItemIndex := IngredientsAsOfComboBox.Items.IndexOf(FOld_EffectiveDate);
  DisplayFutureChangeLabel;
end;

procedure TNewPortionIngredientsFrame.CreateNew;
var
  InsertionPoint: Integer;
  ProposedDate: TDateTime;
begin
  if MessageDlg( 'New future changes will be based upon the current product ingredients.  '
                + #13#10 + 'Do you wish to continue creating new future product changes?',
                  mtInformation,
                  [mbYes, mbNo],
                  0 ) = mrYes then
  begin
    // now user must select the date to apply changes.
    ProposedDate := Date + 1;
    //Date picker demands a min and max date - make the max date sufficiently
    //far in the future so as to make it unbounded for all pratical purposes
    DatePickerForm.SetQueryParams(
      'What date would you like future changes to become effective on site(s)?',
      ProposedDate, IncYear(ProposedDate,20), ProposedDate);
    if DatePickerForm.ShowModal = mrOk then
    begin
      if FEffectiveDates.AddDate(DatePickerForm.Date,InsertionPoint) then
      begin
        //Got a new effective date: set the pending changes flag to ensure the
        //current data, if unmodified by the user, gets saved off under the new date
        ProductsDB.PortionChangesExist := true;
        SetupEffectiveDates(FEffectiveDates.Text);
        IngredientsAsOfComboBox.ItemIndex := InsertionPoint + 1;
        SetupPortionColumnGroups;
        RefreshCostPrices; //The costs of the ingredients may be different on this new date so recalculate them.
        ProductsDB.LogProductChange('Future recipe created for ' + DateToStr(DatePickerForm.Date));
      end
      else begin
        MessageDlg('Future changes are already present for the chosen date.',
                    mtError,
                    [mbOK],
                    0);
      end;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.IngredientsAsOfComboBoxDropDown(Sender: TObject);
begin
  ProductsDB.LogProductChange('Portion Ingredients: Changing effective date for portions');
  //We may be about to change the snapshot, save any changes to the old snapshot
  ProductsDB.SaveAllTableChanges;

  FOld_EffectiveDate := (Sender as TComboBox).Text;
end;

procedure TNewPortionIngredientsFrame.GetIngredientsForDate(Date: String);
begin
  RefreshDisplay(Date);
end;

procedure TNewPortionIngredientsFrame.UpdateDisplay;
begin
  SetupEffectiveDates(ProductsDB.ClientEntityTable.FieldValues['entitycode']);
  RefreshDisplay;
end;

procedure TNewPortionIngredientsFrame.DeleteIngredientActionExecute(Sender: TObject);
begin
  // remove ingredient, requiring confirmation
  RemoveIngredient(Sender, true);
end;

procedure TNewPortionIngredientsFrame.RemoveIngredient(Sender: TObject; requireConfirmation : boolean = true);
var
  book : TBookMark;
  numIngredients : integer;
  ingredientId: double;
  ingredientName: string;
begin
  if (ProductsDB.CurrentEntityType = etStrdLine) and
     (dbgPortions.DataSource.DataSet.FieldByName('entitycode').AsFloat = ProductsDB.CurrentEntityCode) then
  begin
    // There must be at least one instance of this ingredient in the list - is this the last one?
    with dbgPortions.DataSource.DataSet do
    begin
      numIngredients := 0;
      if not (EOF and BOF) then begin
        DisableControls;
        book := GetBookmark;
        try
          First;
          while not EOF do begin
            if FieldByName('EntityCode').AsFloat = ProductsDB.CurrentEntityCode then
              Inc( numIngredients );
            Next;
          end;
        finally
          GotoBookmark(book);
          GridEnableControls;
        end;
      end;
    end;
    if numIngredients <= 1 then begin
      ShowMessage(
        'Sorry, this entry cannot be deleted:  the ingredient list for a Standard Line'#13#10+
        'must contain the product itself at least once.' );
      Abort;
    end;
  end;

  ingredientId := dbgPortions.DataSource.DataSet.FieldByName('EntityCode').AsFloat;
  ingredientName := dbgPortions.DataSource.DataSet.FieldByName('Name').AsString;

  if (not requireConfirmation) or (MessageDlg( 'Are you sure you want to delete ingredient ' + ingredientName + '?',
                 mtConfirmation, [mbOk, mbCancel], 0 ) = mrOk) then
  begin
    dbgPortions.DataSource.DataSet.DisableControls;
    try
      dbgPortions.DataSource.DataSet.Open;
      dbgPortions.DataSource.DataSet.Delete;
      ProductsDb.PortionChangesExist := True;
      RefreshCostPriceTotals;
      if ProductsDB.CurrentEntityType = etChoice then
           dbgPortions.ColumnByName('IncludeByDefault').ReadOnly := ProductsDB.qEditPortions.RecordCount = 0;
      ProductsDb.LogProductChange('Ingredient deleted from ' + GetSelectedDate + ' recipe: "' + ingredientName + '" (' + FloatToStr(ingredientId) + ')');
    finally
      GridEnableControls;
    end;
  end;

  // check proper flags visibility after removing an ingredient
  if (ProductsDB.CurrentEntityType in [etStrdLine,etRecipe]) then begin
    LineEditForm.checkOtherFlagsVisibility(ProductsDB.CurrentEntityType, false);
  end;
end;

procedure TNewPortionIngredientsFrame.DeleteIngredientActionUpdate(
  Sender: TObject);
begin
  if not dbgPortions.DataSource.DataSet.Active then
    (Sender as TAction).Enabled := False
  else
    (Sender as TAction).Enabled :=
      not (dbgPortions.DataSource.DataSet.Bof and dbgPortions.DataSource.DataSet.Eof);
end;

procedure TNewPortionIngredientsFrame.InsertIngredientActionUpdate(
  Sender: TObject);
begin
  if not dbgPortions.DataSource.DataSet.Active or FNoPortionsVisible then
    (Sender as TAction).Enabled := false
  else begin
    if (dbgPortions.DataSource.DataSet.RecordCount >= MaxIngredients) then
      (Sender as TAction).Enabled := false
    else
      // Don't allow insert if the  main product is a strd.line type and the
      // selected ingredient is the main product, this ensures that the main
      // product ingredient is always the first ingredient.
      (Sender as TAction).Enabled :=
      not ( (ProductsDB.CurrentEntityType = etStrdLine) and
             (dbgPortions.DataSource.DataSet.FieldByName('EntityCode').AsFloat =
               ProductsDB.ClientEntityTable.FieldByName('EntityCode').AsFloat) );
  end;
end;


procedure TNewPortionIngredientsFrame.PortionNameLookupComboCloseUp(Sender: TObject);
begin
  PortionNameLookupCombo.Visible := False;
end;

procedure TNewPortionIngredientsFrame.BuildPortionComboBox;
var
  focusedPortion: integer;
  focusedPortionType: integer;
  portionTypeId: integer;
  portionTypeName: string;
begin
  PortionNameLookupCombo.Clear;
  focusedPortion := GetFocusedPortion;
  focusedPortionType := FPortionsByDisplayOrder.PortionId[focusedPortion]; //Note: This will be -1 if no portion type is currently selected

  with ProductsDB.ADOQuery do
  try
    SQL.Text := 'SELECT Id, Name FROM ac_PortionType WHERE Id <> ' + IntToStr(STANDARD_PORTION_TYPE_ID) + ' AND Deleted = 0 ' + ' ORDER BY Name';
    Open;
    while not EOF do
    begin
       portionTypeId := FieldByName('Id').AsInteger;
       portionTypeName := FieldByName('Name').AsString;

       if portionTypeId = focusedPortionType then
       begin
          PortionNameLookupCombo.ItemIndex := PortionNameLookupCombo.Items.AddObject(portionTypeName, TObject(portionTypeId));
       end
       else if not(FPortionsByDisplayOrder.ContainsPortionType(portionTypeId)) then
          PortionNameLookupCombo.Items.AddObject(portionTypeName, TObject(portionTypeId));
       Next;
       end;
    finally
       Close;
    end;
    PortionNameLookupCombo.Items.Add(NEW_ITEM)
end;

procedure TNewPortionIngredientsFrame.SavePendingPortionChanges;
var
  EntityCode: String;
  EffectiveDate: String;
  OldQueryText: String;
begin
  Assert(IsInitialisedForCurrentProduct,
     'Erroneous attempt to save portion recipe for product ' + FloatToStr(FEntityCode) +
     ' against product ' + productsDB.ClientEntityTableEntityCode.AsString);

  if not ProductsDb.PortionChangesExist then
    Exit;

  if ProductsDb.ProductNewlyInsertedAndNotSaved then
    raise Exception.Create('Cannot save portions because product does not yet exist in Products table in DB');

  //This routine should only be called from within ProductsDB.SaveAllTableChanges
  //as we are relying on the LMDT of the Products table to provide concurrency
  //protection

  //Only save portions for the following entities
  if FEntityType in [etChoice, etRecipe, etStrdLine] then
  begin
    ProductsDB.qSavePortions.close;

    //Delphi param passing is no good - string replace to avoid problems with
    //the goto labels in the chunk of sql associated with this ADOQuery
    EffectiveDate := GetSelectedDate;
    EntityCode := ProductsDB.ClientEntityTable.FieldByName('entitycode').AsString;

    OldQueryText := ProductsDB.qSavePortions.SQL.Text;
    try
      ProductsDB.qSavePortions.SQL.Text :=
              Format(ProductsDB.qSavePortions.SQL.Text,
                    [EntityCode,
                     ProductsDB.MaxAllowedPortions,
                     EffectiveDate]);
      if (EffectiveDate = CURRENT_ITEM) then
        ProductsDB.LogProductChange('About to save PortionIngredients changes (current date) - updates Portions and PortionIngredients')
      else
        ProductsDB.LogProductChange('About to save PortionIngredients changes (future date) - updates PortionsFuture and PortionIngredientsFuture');

      // Although qSavePortions rolls back the transaction if any errors are raised, exception handling should handle any other type of error
      try
        ProductsDB.qSavePortions.ExecSQL;
        ProductsDB.LogProductChange('PortionIngredients changes SQL executed');
      except
        on E: Exception do
        begin
          Log.Event('Error saving PortionIngredient changes: ' + E.Message);
          ShowMessage('There has been an error saving portion ingredient changes: ' + E.Message);
        end;
      end;
    finally
      ProductsDB.qSavePortions.Close;
      ProductsDB.qSavePortions.SQL.Text := OldQueryText;
    end;
  end;

  ProductsDb.PortionChangesExist := False;
end;

function TNewPortionIngredientsFrame.PortionPriceChangesExist: boolean;
begin
  Result := FPortionPriceChangesExist;
end;

procedure TNewPortionIngredientsFrame.SavePendingPortionPriceChanges;
begin
  Assert(IsInitialisedForCurrentProduct,
     'Erroneous attempt to save portion prices for product ' + FloatToStr(FEntityCode) +
     ' against product ' + productsDB.ClientEntityTableEntityCode.AsString);

  if not PortionPriceChangesExist then
    Exit;

  PostRecord(ProductsDB.PortionPricesTable);

  with ProductsDb.qSavePortionPrices do
  begin
    Parameters.ParamByName('productId').Value := ProductsDB.CurrentEntityCode;
    Parameters.ParamByName('ppgtPortionPrice').Value := ord(ppgvPortionPrice);
    Parameters.ParamByName('maxPortions').Value := ProductsDB.MaxAllowedPortions;
    Parameters.ParamByName('userName').Value := productsDb.logonName;
    ExecSQL;
  end;

  FPortionPriceChangesExist := False;
end;

//procedure TNewPortionIngredientsFrame.PortionPriceChange(Sender: TField);
//begin
//  Assert(Copy(Sender.FieldName,1, 5) = 'Value', 'Portion price change handler invoked for unexpected field: ' + Sender.FieldName);
//
//  if ProductsDb.PortionPricesTable.FieldByName('Type').Value = ord(ppgvPortionPrice) then
//    FPortionPriceChangesExist := True;
//end;

procedure TNewPortionIngredientsFrame.CancelChangesActionExecute(
  Sender: TObject);
begin
  if MessageDlg('Future changes for ' + ViewingDate + ' will be deleted.' +
   #13#10 + 'Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  //Bulk cancelling changes for a date - empty both temp tables
  //and force a save.
  dbgPortions.DataSource.DataSet.DisableControls;
  try
    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('delete #tmpportioncrosstab');
      SQL.Add('delete #tmpportions');
      ExecSQL;
    end;
    ProductsDB.qEditPortions.close;
    ProductsDB.qEditPortions.open;
    ProductsDB.skipValidatePortion := True;
  finally
    GridEnableControls;
  end;
  ProductsDB.PortionChangesExist := True;
  ProductsDB.SaveAllTableChanges;
  UpdateDisplay;
  ProductsDB.skipValidatePortion := False;
end;

procedure TNewPortionIngredientsFrame.CancelChangesActionUpdate(
  Sender: TObject);
begin
  //Do not allow the 'Current' changes to be deleted/lost
  (Sender as TAction).Enabled := IngredientsAsOfComboBox.Items[IngredientsAsOfComboBox.ItemIndex] <> CURRENT_ITEM;
end;

procedure TNewPortionIngredientsFrame.CookTimesActionExecute(Sender: TObject);
var
  PortionCookTimeDialog:  TPortionCookTimes;
begin
  PortionCookTimeDialog := TPortionCookTimes.Create(Self,
    IngredientsAsOfComboBox.Items[IngredientsAsOfComboBox.ItemIndex]);
  try
    if PortionCookTimeDialog.ShowModal = mrOK then
    begin
      ProductsDB.PortionChangesExist := True;
      RefreshDefaultCookTime;
    end;
  finally
    PortionCookTimeDialog.Release;
  end;
end;

procedure TNewPortionIngredientsFrame.PortionsActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  RightPanel.Visible :=
    (ProductsDB.CurrentEntityType = etStrdLine)
     or
    (ProductsDB.CurrentEntityType = etRecipe);

  Panel1.Visible := (ProductsDB.CurrentEntityType = etChoice);

end;

procedure TNewPortionIngredientsFrame.RefreshDefaultCookTime;
begin
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select cooktime from #tmpportions where displayorder = 1';
    Open;
    if not EOF then
      Label2.Caption := FormatDateTime('hh:nn:ss',FieldByName('cooktime').AsDateTime);
  end;
end;

function TNewPortionIngredientsFrame.ViewingCurrentData: Boolean;
begin
  Result := IngredientsAsOfComboBox.Items[IngredientsAsOfComboBox.ItemIndex] = CURRENT_ITEM;
end;

procedure TNewPortionIngredientsFrame.BuildTempTables(EntityCode: Double; EffectiveDate: String);
begin
  with ProductsDB do
  begin
    qEditPortions.DisableControls;
    qEditPortions.Close;

    if FShowPortionPrices then
    begin
      PortionPricesTable.DisableControls;
      PortionPricesTable.Close;
    end;

    LoadPortionRecipesForProduct(EntityCode, EffectiveDate, FShowPortionPrices);

    qEditPortions.Open;
    GridEnableControls;

    if FShowPortionPrices then
    begin
      PortionPricesTable.Open;
      PortionPricesTable.EnableControls;
    end;
  end;

  FTempTablesBuilt := True;
end;

procedure TNewPortionIngredientsFrame.CreateDefaultAztecPortion;
begin
  //Two part process just because we need to know whether or not to force a save
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT [PortionID] ' +
                'FROM #tmpportions ' +
                'WHERE [DisplayOrder] = 1 ';
    Open;

    if RecordCount = 0 then
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DECLARE @portionid float ' +
                  'exec GetNextUniqueID '+
                  ' @TableName = ''Portions'', '+
                  ' @IdField = ''PortionID'', '+
                  ' @RangeMin = 1, '+
                  ' @RangeMax = 2147483647, '+
                  ' @NextId = @portionid OUTPUT '+
                  'INSERT #tmpportions (PortionID,EntityCode,PortionTypeID,DisplayOrder,CookTime) ' +
                  'VALUES (@portionid,' + productsDB.ClientEntityTableEntityCode.AsString + ',' + IntToStr(DefaultPortionTypeID) + ',1,null)';
      ExecSQL;
      ProductsDB.PortionChangesExist := True;
    end;
  end;
end;

function TNewPortionIngredientsFrame.ViewingDate: String;
begin
  Result := FEffectiveDates.AztecDisplayDate[IngredientsAsOfComboBox.ItemIndex-1];
end;

procedure TNewPortionIngredientsFrame.EnsureSelfIngredientExists;
begin
  //Two part process just because we need to know whether or not to force a save
  with ProductsDB.ADOQuery do
  try
    Close;
    SQL.Text := 'SELECT * FROM #TmpPortionCrosstab WHERE EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString;
    Open;

    if RecordCount = 0 then
    begin
      Close;
      SQL.Text :=
        'IF EXISTS(SELECT * FROM #TmpPortionCrosstab WHERE DisplayOrder = 1) ' +
        '  UPDATE #TmpPortionCrosstab SET DisplayOrder = DisplayOrder + 1 ' +

        'INSERT #TmpPortionCrosstab (EntityCode, DisplayOrder, Name, Description) ' +
        'VALUES(' + productsDB.ClientEntityTableEntityCode.AsString + ',1,' +
          QuotedStr(productsDB.ClientEntityTableExtendedRTLName.AsString)+ ', ' +
          QuotedStr(productsDB.ClientEntityTableRetailDescription.AsString) + ')';
      ExecSQL;

      dbgPortions.DataSource.DataSet.Close;
      dbgPortions.DataSource.DataSet.Open;

      ProductsDB.PortionChangesExist := True;
    end;
  finally
    Close;
  end;
end;

procedure TNewPortionIngredientsFrame.UpdateSelfIngredientNameAndDesc(_Name: String; _Description: String);
begin
  if not FTempTablesBuilt then
    Exit;

  if IsInitialisedForCurrentProduct then
  begin
    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE #tmpportioncrosstab');
      SQL.Add('SET Name = :name,');
      SQL.Add('Description = :description');
      SQL.Add('WHERE EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString);
      Parameters.ParamByName('name').Value := _Name;
      Parameters.ParamByName('description').Value := _Description;

      ExecSQL;
    end;
    ProductsDB.qEditPortions.Requery;
  end
  else
  begin
    InitialiseForCurrentProduct;
  end;
end;

procedure TNewPortionIngredientsFrame.RefreshCostPriceTotals;
var
  i: integer;
  costPriceCalc: string;
  isMinMaxChoiceWithDefaults : Boolean;
  errorMessage: string;
  CostPriceMode: TCostPriceMode;
  multiplier: integer;  //Value to multiply the budgeted cost by. Only > 1 if the product is a multi-choice with no default ingreds.
begin
  isMinMaxChoiceWithDefaults := False;
  multiplier := 1;

  if FEntityType = etChoice then
  begin
    if TCostPriceMode(ProductsDB.adotProductCostPriceCostPriceMode.AsInteger) <> cpmNone then
      CostPriceMode := TCostPriceMode(ProductsDB.adotProductCostPriceCostPriceMode.AsInteger)
    else
      CostPriceMode := ProductsDB.costPriceModeForChoices;

    case CostPriceMode of
      cpmAverage: costPriceCalc := 'AVG';
      cpmMaximum: costPriceCalc := 'MAX';
      cpmMinimum: costPriceCalc := 'MIN';
    end;

    if not ProductsDB.qEditPortionChoices.Active then
      SetupMinMaxChoices;

    if (cbxChoiceEnabled.Checked) then
    begin
      isMinMaxChoiceWithDefaults := ProductsDB.HasDefaultIngredientsInWorkingTempTable(ProductsDB.ClientEntityTableEntityCode.AsString);

      // If the product is a Multi-Choice with no default ingredients we will multiply the budgeted cost by
      // the minimum number of items that can be selected.
      if not(isMinMaxChoiceWithDefaults) then
        multiplier := Floor(seMinChoice.Value);
    end;

    if isMinMaxChoiceWithDefaults then
       costPriceCalc := 'SUM';
  end
  else
  begin
    costPriceCalc := 'SUM';
  end;


  with ProductsDB.ADOQuery do
  try
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    for i := 1 to ProductsDB.MaxAllowedPortions - 1 do
      SQL.Add(costPriceCalc + '(IsNull(CostPrice' + IntToStr(i) + ',0)) AS ''Total' + IntToStr(i) + ''',');
    SQL.Add(costPriceCalc + '(IsNull(CostPrice' + IntToStr(ProductsDB.MaxAllowedPortions) + ',0)) AS ''Total' + IntToStr(ProductsDB.MaxAllowedPortions) + '''');
    SQL.Add('FROM #TmpPortionCrosstab');
    if isMinMaxChoiceWithDefaults then
       SQL.Add(' WHERE IncludeByDefault = 1 ');
    Open;

    for i := 1 to ProductsDB.MaxAllowedPortions do
    begin
      if PortionTypesFiltered and not(FPortionsByDisplayOrder.IsPortionAssigned(i)) then
        continue;

      dbgPortions.ColumnByName('CostPrice'+IntToStr(i)).FooterValue :=
        FloatToStrF(FieldByName('Total'+IntToStr(i)).AsFloat * multiplier, ffFixed, 15, 4);

      if FShowPortionPrices then
      begin
        FRefreshingPortionPriceInfo := True;
        RefreshPricingFigures(ppgvPortionPrice, i, errorMessage); //Recalc GP% and GP Amount using new cost, leaving portion price as is.
        FRefreshingPortionPriceInfo := False;
      end;
    end;
  finally
    Close;
  end;

  dbgPortions.ColumnByName('Description').FooterValue := '       Budgeted Cost';
end;

//Recalculate the cost prices that are displayed.
//TODO: It may be worth paramterising this for the case when only the costs for the "self ingredient" of a Standard Line
// need to be re-calculated. This case can be made more efficient: don't have to call ClearBudgetedCostPriceCacheTables
// and only need to recalculate the costs for the "self ingredient" records.
procedure TNewPortionIngredientsFrame.RefreshCostPrices;
var
  i: integer;
  BM: TBookmark;
  EffectiveDate: string;
begin
  if not FTempTablesBuilt then Exit;

  EffectiveDate := GetSelectedDate;

  ProductsDb.ClearBudgetedCostPriceCacheTables;

  with dbgPortions.DataSource.DataSet do
  begin
    BM := GetBookmark;
    DisableControls;

    try
      First;
      while not(eof) do
      begin
        Edit;
        for i := 1 to ProductsDB.MaxAllowedPortions do
        begin
          case FieldByName('CalculationType' + IntToStr(i)).AsInteger of
            ord(calcUnit) :
                FieldByName('CostPrice' + IntToStr(i)).Value :=
                   ProductsDb.GetUnitBudgetedCostPrice(StrToInt64(FieldByName('EntityCode').AsString),
                                                       FieldByName('UnitName'+IntToStr(i)).AsString,
                                                       FieldByName('Quantity'+IntToStr(i)).AsCurrency,
                                                       EffectiveDate);
            ord(calcPortion) :
              begin
                FieldByName('CostPrice' + IntToStr(i)).Value :=
                   ProductsDb.GetPortionBudgetedCostPrice(StrToInt64(FieldByName('EntityCode').AsString),
                                                       FieldByName('portioningredients_portiontypeid'+IntToStr(i)).AsInteger,
                                                       FieldByName('Quantity'+IntToStr(i)).AsCurrency,
                                                       EffectiveDate);
              end;
            ord(calcFactor) :
              FieldByName('CostPrice' + IntToStr(i)).Value :=
                FieldByName('CostPrice1').AsCurrency * FieldByName('Quantity' + IntToStr(i)).AsCurrency;
          end; { case }
        end; { for i := 1 to MAX_NUMBER_OF_PORTIONS }

        Next;
      end; { while not(eof) }
    finally
      GotoBookmark(BM);
      FreeBookMark(BM);
      GridEnableControls;
    end;
  end; { with dbgPortions.DataSource.DataSet }

  RefreshCostPriceTotals;
end;


//TODO (GDM): Add this code from Pete for drawing vertical grid lines down to total rows?
//procedure TForm1.dbgPortionsDrawFooterCell(Sender: TObject; Canvas: TCanvas;
//  FooterCellRect: TRect; Field: TField; FooterText: String;
//  var DefaultDrawing: Boolean);
//var
//  VertSize: integer;
//begin
//  with TwwDBGrid(Sender) do
//  begin
//    VertSize := ClientHeight-10;
//  end;
//  canvas.Pen.Color := clBtnShadow;
//  canvas.MoveTo(footercellrect.Left-1, footercellrect.Top-4);
//  canvas.lineto(footercellrect.Left-1, footercellrect.Top-VertSize);
//  if (field.Index = TwwDBGrid(sender).FieldCount-1) then
//  begin
//    canvas.MoveTo(footercellrect.right, footercellrect.Top-4);
//    canvas.lineto(footercellrect.right, footercellrect.Top-VertSize);
//  end
//end;


procedure TNewPortionIngredientsFrame.dbgPortionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if EditIngredientAction.Enabled then EditIngredientAction.Execute;
    VK_INSERT: if InsertIngredientAction.Enabled then InsertIngredientAction.Execute;
    VK_DELETE: if DeleteIngredientAction.Enabled then DeleteIngredientAction.Execute;
  end;
end;


procedure TNewPortionIngredientsFrame.DisplayFutureChangeLabel;
begin
//  if not ProductsDB.PendingPortionChangesExist then
    FuturePortionsExistlbl.Visible := IngredientsAsOfComboBox.Items.Count > 2;
end;

procedure TNewPortionIngredientsFrame.ContainersActionExecute(
  Sender: TObject);
var
  PortionContainerDialog:  TPortionScaleContainers;
begin
  if ProductsDb.IsUsedAsIngredient(ProductsDB.CurrentEntityCode) then
  begin
    ShowMessage('This product is a child of another product and cannot have scale containers.');
  end
  else if ProductsDB.ProductHasChoices then
  begin
    ShowMessage('This product contains choices and cannot have scale containers.');
  end
  else if ProductsDB.ProductHasBarcodeRanges then
  begin
    ShowMessage('This product has barcode ranges and cannot have scale containers.');
  end
  else begin
    PortionContainerDialog := TPortionScaleContainers.Create(Self,
      IngredientsAsOfComboBox.Items[IngredientsAsOfComboBox.ItemIndex]);
    try
      if PortionContainerDialog.ShowModal = mrOK then
      begin
        ProductsDB.PortionChangesExist := True;
      end;
    finally
      PortionContainerDialog.Release;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.RemoveScaleContainers;
var
  RowCount: Integer;
  Query: String;
  TempTableUsed: Boolean;
begin
  if not ProductsDB.ClientEntityTableEntityCode.IsNull then
  begin
    TempTableUsed := False;
    if not ProductsDB.PortionChangesExist then
      Query := 'update Portions' + #13#10 +
               'set ContainerID = null' + #13#10 +
               'where EntityCode = ' +  ProductsDB.ClientEntityTableEntityCode.AsString
    else begin
      Query := 'update #tmpPortions set ContainerId = null';
      TempTableUsed := True;
    end;

    with ProductsDB.ADOQuery do
    begin
      SQL.Clear;
      SQL.Text := Query;
      RowCount := ExecSQL;

      if (RowCount > 0) and TempTableUsed then
        ProductsDB.PortionChangesExist := True;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.SetupContainers;
begin
  if (FEntityType in [etStrdLine, etRecipe]) then
  begin
    if (ProductsDB.ScaleContainerTable.RecordCount <= 0) then
    begin
      ContainersButton.Enabled := False;
    end
    else begin
      ContainersButton.Enabled := True;
    end;
  end
  else begin
    ContainersButton.Enabled := False;
  end;
end;

procedure TNewPortionIngredientsFrame.OnMinMaxChoiceChange(Sender: TObject);
var sName: String;
    controlName: string;
begin
  if FMinMaxChoiceControlsBeingInitialised then
    Exit;

  if TwwDBSpinEdit(Sender).Text = '' then
     ProductsDB.dtsEditPortionChoices.DataSet.FieldByName(TwwDBSpinEdit(Sender).DataField).AsInteger := 0;

  controlName := TwwDBSpinEdit(Sender).Name;

  if controlName = 'seMinChoice' then
     sName := 'Minimum choice set to '
  else
  if controlName = 'seMaxChoice' then
     sName := 'Maximum choice set to '
  else
  if controlName = 'seSuppChoice' then
     sName := 'Inclusive set to ';

  ProductsDB.LogProductChange(sName + VarToStr(TwwDBSpinEdit(Sender).Value));

  if controlName = 'seMinChoice' then
    RefreshCostPriceTotals;
end;


procedure TNewPortionIngredientsFrame.SetupMinMaxChoices;
begin
  FMinMaxChoiceControlsBeingInitialised := true;

  try
    ProductsDB.qEditPortionChoices.Close;
    ProductsDB.qEditPortionChoices.Open;

    SetMinMaxChoiceControlVisibility;

    seMinChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('MinChoice').AsInteger;
    if (ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').IsNull) or
       (ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').AsInteger = 0) then
      seMaxChoice.Value := 1
    else
      seMaxChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').AsInteger;
    seSuppChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('SuppChoice').AsInteger;
    wwcbAllowPlain.Checked := ProductsDB.qEditPortionChoices.FieldByName('AllowPlain').AsBoolean;

    dbgPortions.ColumnByName('IncludeByDefault').ReadOnly := (ProductsDB.qEditPortions.RecordCount = 0) or not cbxChoiceEnabled.Checked;
    dbgPortions.Refresh;
  finally
    FMinMaxChoiceControlsBeingInitialised := false;
  end;
end;

procedure TNewPortionIngredientsFrame.cbxChoiceEnabledClick(Sender: TObject);
begin
  if FMinMaxChoiceControlsBeingInitialised then
    Exit;

  FMinMaxChoiceControlsBeingInitialised := true;

  try
    SetMinMaxChoiceControlVisibility;

    if (ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').IsNull) or
       (ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').AsInteger = 0) then
    begin
      ProductsDB.qEditPortionChoices.Edit;
      ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').AsInteger := 1;
    end;

    //Need to force the false value since the checkbox treats null as false
    if ProductsDB.qEditPortionChoices.FieldByName('AllowPlain').IsNull then
    begin
      ProductsDB.qEditPortionChoices.Edit;
      ProductsDB.qEditPortionChoices.FieldByName('AllowPlain').AsBoolean := False;
    end;

    seMinChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('MinChoice').AsInteger;
    seMaxChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('MaxChoice').AsInteger;
    seSuppChoice.Value := ProductsDB.qEditPortionChoices.FieldByName('SuppChoice').AsInteger;
    wwcbAllowPlain.Checked := ProductsDB.qEditPortionChoices.FieldByName('AllowPlain').AsBoolean;

    dbgPortions.ColumnByName('IncludeByDefault').ReadOnly := (ProductsDB.qEditPortions.RecordCount = 0) or not cbxChoiceEnabled.Checked;
    dbgPortions.Refresh;
    RefreshCostPriceTotals;
  finally
    FMinMaxChoiceControlsBeingInitialised := false;
  end;

  if cbxChoiceEnabled.Checked then
     ProductsDB.LogProductChange('Multi-select Choice Selection enabled.')
  else
     ProductsDB.LogProductChange('Multi-select Choice Selection disabled.')
end;

procedure TNewPortionIngredientsFrame.SetMinMaxChoiceControlVisibility;
begin
  seMinChoice.Enabled := cbxChoiceEnabled.Checked;
  seMaxChoice.Enabled := cbxChoiceEnabled.Checked;
  seSuppChoice.Enabled := cbxChoiceEnabled.Checked;
  wwcbAllowPlain.Enabled := cbxChoiceEnabled.Checked;
end;

procedure TNewPortionIngredientsFrame.IngredientsAsOfComboBoxKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if productsDB.qEditPortionChoices.Active and (ProductsDB.CurrentEntityType = etChoice) then
     begin
       if productsDB.validateChoiceSelections then
          abort;
     end;
end;

procedure TNewPortionIngredientsFrame.IngredientsAsOfComboBoxEnter(
  Sender: TObject);
begin
   if productsDB.qEditPortionChoices.Active and (ProductsDB.CurrentEntityType = etChoice) then
     begin
       if productsDB.validateChoiceSelections then
          begin
            IngredientsAsOfComboBox.Enabled := false;
            IngredientsAsOfComboBox.Enabled := True;
            abort;
          end;
     end;
end;

procedure TNewPortionIngredientsFrame.CheckStandardPortion;
begin
  with ProductsDB.ADOQuery do
  try
    Close;
    SQL.Text :=
      'SELECT ' +
      '  CAST( ' +
      '    CASE ISNULL(UnitName1,'''') ' +
      '      WHEN '''' THEN 1 ' +
      '      ELSE 0 ' +
      '    END AS bit) AS UnitNameIsNull ' +
      'FROM #TmpPortionCrosstab ' +
      'WHERE EntityCode = ' + productsDB.ClientEntityTableEntityCode.AsString;
    Open;

    if FieldByName('UnitNameIsNull').AsBoolean then
    begin
      PrizmSetFocus( dbgPortions );
      ShowMessage( 'The Standard Portion Unit details have not been set up for this product.' );
      Abort;
    end;
  finally
    Close;
    SQL.Clear;
  end;
end;

function TNewPortionIngredientsFrame.BudgetedCost(const portion: integer): double;
begin
   Result := StrToFloat(dbgPortions.ColumnByName('CostPrice'+IntToStr(portion)).FooterValue);
end;

procedure TNewPortionIngredientsFrame.HandleTaxRuleChange(Sender: TObject);
var
  i: integer;
  errorMessage: string;
begin
  if FShowPortionPrices then
  begin
    FRefreshingPortionPriceInfo := True;
    for i := 1 to ProductsDB.MaxAllowedPortions do
       RefreshPricingFigures(ppgvPortionPrice, i, errorMessage); //Recalc GP% and GP Amount using new tax amount, leaving portion price as is.
    FRefreshingPortionPriceInfo := False;
  end;
end;

// Update the Portion Price, GP amount, GP% or COS% for the given portion. The fixedValue parameter determines
// which of the three values to leave as is, the others will be calculated using this and the budgeted cost.
// Formulas used:
//
// Gross = Net + (Net  *  TaxRate /100)
//
// Net = Gross / (1 + TaxRate /100)
//
// GP = Net - Cost
//
// GP% = 100 * (1 - Cost/Net)  => Net = (Cost * 100) / (100 - GP%)
//
// COS% = 100 * Cost/Net       => Net = (Cost * 100) / COS%
//
//Where:
//Gross = gross selling price
//Net    = net  selling price
//Cost  = total cost aka budgeted cost
//TaxRate = total inclusive tax rate
//GP% = Gross profit percentage
//GP    = Gross profit amount
//COS% = Cost of sales percentage
function TNewPortionIngredientsFrame.RefreshPricingFigures(
  fixedValue: TPortionPriceGridValue;
  const portion: integer;
  out errorMessage: string): boolean;

var
  valueField: string;
  costPrice: double;
  savePlace: TBookmark;
  setAllToNull: boolean;
  fixedAmount, grossPrice, netPrice, taxRate, GPAmount, GPPercent, COSPercent: double;

  function Limit2dpValue(value, maxValue: double): double;
  begin
    if value < -1 * (maxValue + TWO_DP_FUDGE_FACTOR) then
      Result := -1 * maxValue
    else if value > (maxValue + TWO_DP_FUDGE_FACTOR) then
      Result := maxValue
    else Result := value;
  end;

  procedure SetPricingFigure(pricingFigure: TPortionPriceGridValue; amount: double);
  begin
    with ProductsDB.PortionPricesTable do
    begin
      MovetoPricesTableRow(pricingFigure);
      Edit;
      if setAllToNull then
      begin
        FieldByName(valueField).Clear;
      end
      else
      begin
        FieldByName(valueField).AsFloat := RoundTo(Limit2dpValue(amount, MAX_PRICING_VALUE), -2);
      end;
      Post;
    end;
  end;

begin
  Result := False;
  errorMessage := '';
  setAllToNull := False;
  grossPrice := 0; GPAmount := 0; GPPercent := 0; COSPercent := 0;
  valueField := 'Value' + IntToStr(portion);

  SavePlace := ProductsDB.PortionPricesTable.GetBookmark;
  try try
    if Trim(dbgPortions.ColumnByName('CostPrice'+IntToStr(portion)).FooterValue) = '' then
    begin
      setAllToNull := True;
    end
    else
    begin
      costPrice := BudgetedCost(portion);

      with ProductsDB.PortionPricesTable do
      begin
        MovetoPricesTableRow(fixedValue);

        if FieldByName(valueField).IsNull then
        begin
          setAllToNull := True;
        end
        else
        begin
          //TODO (Maybe): Once portion price is calculated in GP% or GP amount mode and rounded to 2dps should perhaps
          // recalculate the fixedValue i.e. the value the user entered ? Otherwise the user can enter a value for, e.g. GP%,
          // move of the product to save the price change, move back, and the GP% may be slightly different from the value
          // that was entered due to it be recalculated from the rounded price.

          fixedAmount := RoundTo(FieldByName(valueField).AsFloat, -2);

          if (fixedAmount < -1 * (MAX_PRICING_VALUE + TWO_DP_FUDGE_FACTOR)) or (fixedAmount > (MAX_PRICING_VALUE + TWO_DP_FUDGE_FACTOR)) then
          begin
            errorMessage := Format('Value outside valid range (-%0:f to %0:f)', [MAX_PRICING_VALUE]);
            Exit;
          end;

          taxRate := ProductsDb.TotalInclusiveTax / 100;

          case fixedValue of
            ppgvPortionPrice:
              begin
                grossPrice := fixedAmount;

                netPrice := RoundTo(grossPrice / (1 + taxRate), -2);

                if netPrice = 0 then
                begin
                  GPPercent := -1 * MAX_PRICING_VALUE;
                  COSPercent := MAX_PRICING_VALUE;
                end
                else
                begin
                  COSPercent := 100 * costPrice / netPrice;
                  GPPercent := 100 - COSPercent;
                end;

                GPAmount := netPrice - costPrice;
              end;

            ppgvGPAmount:
              begin
                GPAmount := fixedAmount;

                netPrice := RoundTo(costPrice + GPAmount, -2);
                grossPrice := netPrice * (1 + taxRate);

                if netPrice = 0 then
                begin
                  GPPercent := -1 * MAX_PRICING_VALUE;
                  COSPercent := MAX_PRICING_VALUE;
                end
                else
                begin
                  COSPercent := 100 * costPrice / netPrice;
                  GPPercent := 100 - COSPercent;
                end;
              end;

            ppgvGPorCOSPercent:
              begin
                if ProductsDB.PortionPriceMode = ppmGP then
                begin
                  GPPercent := fixedAmount;
                  COSPercent := 100 - GPPercent;
                end
                else
                begin
                  COSPercent := fixedAmount;
                  GPPercent := 100 - GPPercent;
                end;

                netPrice := CalculatePortionPrice(COSPercent, costPrice);
                grossPrice := netPrice * (1 + taxRate);

                GPAmount := netPrice - costPrice;
              end;
          end;
        end;
      end;

      if (grossPrice < 0) or (grossPrice > (MAX_PRICING_VALUE + TWO_DP_FUDGE_FACTOR)) then
      begin
        errorMessage := Format('This would give a gross price of %0:f. The gross price must be between 0 and %1:f', [grossPrice, MAX_PRICING_VALUE]);
        Exit;
      end;
    end;

    SetPricingFigure(ppgvPortionPrice, grossPrice);
    SetPricingFigure(ppgvGPorCOSPercent, ifthen(ProductsDB.PortionPriceMode = ppmGP, GPPercent, COSPercent));
    SetPricingFigure(ppgvGPAmount, GPAmount);

    Result := True;
  except
    on E: Exception do
    begin
      Log.Event('Error saving portion price changes: ' + E.Message);
      errorMessage := 'Unexpected error occured: ' + E.Message;
    end;
  end;
  finally
    ProductsDB.PortionPricesTable.GotoBookMark(SavePlace);
    ProductsDB.PortionPricesTable.FreeBookMark(SavePlace);
  end;
end;

procedure TNewPortionIngredientsFrame.MovetoPricesTableRow(rowType: TPortionPriceGridValue);
begin
  with ProductsDB.PortionPricesTable do
  begin
    if FieldByName('Type').AsInteger <> ord(rowType) then
      if not Locate('Type', ord(rowType), []) then
        raise Exception.Create('Failed to locate record in #TmpPricesCrosstab with Type = ' + IntToStr(ord(rowType)));
  end;
end;


procedure TNewPortionIngredientsFrame.dbgPortionPricesFieldChanged(Sender: TObject; Field: TField);
var
  portion: integer;
  pricingField: TPortionPriceGridValue;
  revertChange: boolean;
  oldValue: Variant;
  errorMessage: string;

  function FloatVarToStr(value: Variant): string;
  begin
    if VarIsNull(value) then
      Result := 'null'
    else
      Result := FloatToStrF(value, ffFixed, 7, 2);
  end;

begin
  if FprocessingFieldChanged then
    Exit;

  FprocessingFieldChanged := True;

  try
     //Should only ever be a ValueX field that is changed, but check just in case
    if Copy(Field.FieldName, 1, 5) <> 'Value' then
      Exit;

    if FRefreshingPortionPriceInfo then
      Exit;

    FRefreshingPortionPriceInfo := True;
    try
      revertChange := False;
      errorMessage := '';
      portion := StrToInt(Copy(Field.FieldName, 6, length(Field.FieldName) - 5));
      pricingField := TPortionPriceGridValue(ProductsDb.PortionPricesTable.FieldByName('Type').AsInteger);
      oldValue := Field.OldValue;

      if (pricingField = ppgvPortionPrice) and ((Field.AsFloat < 0) or (Field.AsFloat > (MAX_PRICING_VALUE + TWO_DP_FUDGE_FACTOR))) then
      begin
        revertChange := True;
        errorMessage := Format('Price must be between 0 and %0:f', [MAX_PRICING_VALUE])
      end;

      if not(revertChange) then
        revertChange := not RefreshPricingFigures(pricingField, portion, errorMessage);

      if revertChange then
      begin
        messageDlg(errorMessage, mtError, [mbOk], 0);

        if ProductsDb.PortionPricesTable.State <> dsEdit then
          ProductsDb.PortionPricesTable.Edit;
        Field.Value := oldValue;
      end
      else
      begin
        FPortionPriceChangesExist := True;
        ProductsDb.LogProductChange(PortionPriceGridValueEnumToString(pricingField) + ' changed from ' +
          FloatVarToStr(oldValue) + ' to ' + FloatVarToStr(Field.Value) + ' for ''' + FPortionsByDisplayOrder.PortionName[portion] + ''' portion');
      end;

    finally
      FRefreshingPortionPriceInfo := False;
    end;
  finally
   FprocessingFieldChanged := False;
  end;
end;

function TNewPortionIngredientsFrame.CalculatePortionPrice(COSPercent: double; costPrice: double): double;
begin
  COSPercent := RoundTo(COSPercent, -2);

  if COSPercent = 0 then
    Result := MAX_PRICING_VALUE
  else
    Result := RoundTo( (costPrice * 100) / COSPercent, -2);
end;

procedure TNewPortionIngredientsFrame.dbgPortionPricesColEnter(Sender: TObject);
var
  fieldName: string;
  DisplayOrder: integer;
begin
  fieldName := dbgPortionPrices.FieldName(dbgPortionPrices.GetActiveCol);

  // Allow this field to be edited if it is a Value field (and not one of the dummy fields created purely to keep the grids
  // in synch) AND a portion type has been assigned.
  if Copy(fieldName, 1, 5) = 'Value' then
  begin
    DisplayOrder := StrToInt(Copy(fieldName, 6, length(fieldName)-5));

    if FPortionsByDisplayOrder.PortionAssigned[DisplayOrder] then
      dbgPortionPrices.Options := dbgPortionPrices.Options + [dgEditing]
    else
      dbgPortionPrices.Options := dbgPortionPrices.Options - [dgEditing];
  end
  else
  begin
    dbgPortionPrices.Options := dbgPortionPrices.Options - [dgEditing];
  end;

  if FSynchingCols then
    Exit;

  FSynchingCols := true;
  dbgPortions.SetActiveField(GetPortionColumn(dbgPortionPrices.FieldName(dbgPortionPrices.GetActiveCol)));
  FSynchingCols := false;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsColEnter(Sender: TObject);
begin
  if FSynchingCols then
    Exit;

  FSynchingCols := true;
  dbgPortionPrices.SetActiveField(GetPriceColumn(dbgPortions.FieldName(dbgPortions.GetActiveCol)));
  FSynchingCols := false;
end;

function TNewPortionIngredientsFrame.GetPriceColumn(const portionColumn: string): string;
begin
  if Copy(portionColumn, 1, 8) = 'UnitName' then
    Result := 'DummyA' + Copy(portionColumn, 9, length(portionColumn) - 8)
  else if Copy(portionColumn, 1, 8) = 'Quantity' then
    Result := 'DummyB' + Copy(portionColumn, 9, length(portionColumn) - 8)
  else if Copy(portionColumn, 1, 9) = 'CostPrice' then
    Result := 'Value' + Copy(portionColumn, 10, length(portionColumn) - 9)
  else
    Result := '';
end;

function TNewPortionIngredientsFrame.GetPortionColumn(const priceColumn: string): string;
begin
  if Copy(priceColumn, 1, 6) = 'DummyA' then
    Result := 'UnitName' + Copy(priceColumn, 7, length(priceColumn) - 6)
  else if Copy(priceColumn, 1, 6) = 'DummyB' then
    Result := 'Quantity' + Copy(priceColumn, 7, length(priceColumn) - 6)
  else if Copy(priceColumn, 1, 5) = 'Value' then
    Result := 'CostPrice' + Copy(priceColumn, 6, length(priceColumn) - 5)
  else
    Result := '';
end;


procedure TNewPortionIngredientsFrame.btnMoveDownClick(Sender: TObject);
begin
  ProductsDB.MoveCurrentIngredient(dDown);
end;

procedure TNewPortionIngredientsFrame.btnMoveUpClick(Sender: TObject);
begin
  ProductsDb.MoveCurrentIngredient(dUp);
end;

procedure TNewPortionIngredientsFrame.btnSettingsOverrideClick(
  Sender: TObject);
var
 SettingsOverrideForm: TSettingsOverrideForm;
 oldCostPriceMode, newCostPriceMode: TCostPriceMode;
begin
  SettingsOverrideForm := TSettingsOverrideForm.Create(Self);
  try
    if SettingsOverrideForm.ShowModal = mrOK then
    begin
      oldCostPriceMode := TCostPriceMode(ProductsDb.adotProductCostPriceCostPriceMode.AsInteger);

      newCostPriceMode := SettingsOverrideForm.SettingsFrame.CostPriceMode;

      if (newCostPriceMode = cpmNone) then
      begin
        if not ProductsDB.adotProductCostPriceEntityCode.IsNull then
          ProductsDB.adotProductCostPrice.Delete;
      end
      else begin
        ProductsDB.adotProductCostPrice.Edit;
        ProductsDB.adotProductCostPriceCostPriceMode.AsInteger := ord(newCostPriceMode);
      end;

      //Force a recalculation of cost prices if the method of calculating a choice cost price has changed.
      if oldCostPriceMode <> newCostPriceMode then
        productsdb.ClearBudgetedCostPriceCacheTables;

      if (oldCostPriceMode <> newCostPriceMode) then
      begin
        RefeshCostPriceMode;
        ProductsDb.SaveAllTableChanges;
        InitialiseForCurrentProduct;
      end;
    end;
  finally
    SettingsOverrideForm.Free;
  end;
end;

procedure TNewPortionIngredientsFrame.RefeshCostPriceMode;
begin
  btnSettingsOverride.Visible := ProductsDB.CurrentEntityType = etChoice;
  lblBudgetedCostPriceMethodOverride.Visible := (TCostPriceMode(ProductsDB.adotProductCostPriceCostPriceMode.AsInteger) <> cpmNone);
end;

function TNewPortionIngredientsFrame.MaxIngredients: integer;
begin
  if FEntityType = etChoice then
    Result := MAX_CHOICE_INGREDIENTS
  else
    Result := MAX_RECIPE_INGREDIENTS;
end;

procedure TNewPortionIngredientsFrame.dbgPortionsDrawFooterCell(
  Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField;
  FooterText: String; var DefaultDrawing: Boolean);
var
  Flags: integer;
  HorizontalPadding: Integer;

  function FixedColWidthTotal: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to (Sender as TwwDBGrid).FixedCols - 1 do
    begin
      Result := result + (Sender as TwwDBGrid).ColWidths[i];
    end;
  end;

  procedure LocalDrawFooterLines(rect: TRect);
  begin
    with Canvas do begin
     //Pen.color:= clBtnShadow;
     Pen.Color:= (sender as TwwDBGrid).LineColors.ShadowColor;
     MoveTo(rect.left+1, rect.bottom-2);
     LineTo(rect.left+1, rect.top+1);
     LineTo(rect.right-1, rect.top+1);

     if dgFooter3DCells in (sender as TwwDBGrid).Options then //(ColorToRGB(Brush.Color)=clWhite) then
     begin
      Pen.color:= clBlack;
      MoveTo(rect.left+2, rect.bottom-2);
      LineTo(rect.left+2, rect.top+2);
      LineTo(rect.right-1, rect.top+2);

      //Pen.color:= clBtnHighlight;
      Pen.Color:= (Sender as TwwDBGrid).LineColors.HighlightColor;
      MoveTo(rect.left+2, rect.bottom-2);
      LineTo(rect.right-1, rect.bottom-2);
      LineTo(rect.right-1, rect.top+1);

      Pen.color:= clBtnFace;
      MoveTo(rect.left+3, rect.bottom-3);
      LineTo(rect.right-2, rect.bottom-3);
      LineTo(rect.right-2, rect.top+1);
     end
     else begin
      //Pen.color:= clBtnHighlight;
      Pen.Color:= (Sender as TwwDBGrid).LineColors.HighlightColor;
      MoveTo(rect.left+2, rect.bottom-2);
      LineTo(rect.right-1, rect.bottom-2);
      LineTo(rect.right-1, rect.top+1);
     end
    end
  end;
begin
  if FooterText = '' then Exit;

  DefaultDrawing := False;

  Canvas.FillRect(FooterCellRect);

  HorizontalPadding := 2;

  //This needs a little explaining.
  //The footer cell notionally only belongs to the rightmost of the three portion sub-columns
  //(unit, quantity and cost), but in order to render big costs correctly we
  //need a little extra real estate.  To this end we inflate the footer rectangle to
  //cover the first two fields (unit and quantity) as well.  However, since we don't know their
  //prospective drawing rectangle size we assume that all three columns are the same size as the
  //cost column, but in fact the quantity column is a little bigger (see consts
  //UNIT_COLUMN_WIDTH, QUANTITY_COLUMN_WIDTH and COST_COLUMN_WIDTH).
  //
  //The 'else' branch catches the case of the fixed column footer which always
  //contains the text 'Budgeted Cost' and the Max() call in the main 'if'
  //sorts out the quirk present in the first true footer following the fixed columns
  //where we have to be mindful of the boundary of the fixed columns.
  if FooterCellRect.Right > FixedColWidthTotal + 2 then
  begin
    FooterCellRect.Left := FooterCellRect.left - (2 * (FooterCellRect.Right - FooterCellRect.Left + HorizontalPadding)) - HorizontalPadding;
    FooterCellRect.Left := Max(FixedColWidthTotal + (2 * HorizontalPadding), FooterCellRect.Left);
  end
  else
    FooterCellRect.Left := HorizontalPadding;

  LocalDrawFooterLines(FooterCellRect);

  Flags:= DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_WORD_ELLIPSIS;
  FooterCellRect.Top:= FooterCellRect.Top +
     (FooterCellRect.Bottom - FooterCellRect.Top - Canvas.TextHeight('A')) div 2;

  FooterCellRect.Right:= FooterCellRect.Right - 1;
  SetBkMode(Canvas.Handle, TRANSPARENT);
  DrawText(Canvas.Handle, PChar(FooterText), length(FooterText),
           FooterCellRect, Flags);
end;

procedure TNewPortionIngredientsFrame.ScrollGridsHardLeft;
begin
  dbgPortions.Perform(WM_HSCROLL, SB_LEFT, 0);
  dbgPortionPrices.Perform(WM_HSCROLL, SB_LEFT, 0);
  dbgPortions.SetActiveField(dbgPortions.Columns[dbgPortions.FixedCols].FieldName);
  dbgPortionPrices.SetActiveField(dbgPortionPrices.Columns[dbgPortionPrices.FixedCols + COLUMNS_PER_PORTION - 1].FieldName);
end;

procedure TNewPortionIngredientsFrame.ApplyPortionTypeFilterChangeToGrids;
begin
  //Before applying the filter to the grids must first scroll both grids to the left most position,
  //otherwise weird shit happens.
  ScrollGridsHardLeft;
  SetupGrids;
end;

function TNewPortionIngredientsFrame.ShowPortionFilterDialog(out settingsChanged: boolean): Integer;
var
  currentFilteredPortions,
  newFilteredPortions : TList;
begin
  if not assigned(FPortionFilterDialog) then
    FPortionFilterDialog := TPortionFilterForm.Create(self);

  settingsChanged := false;
  currentFilteredPortions := TList.Create;
  newFilteredPortions := TList.Create;

  try
    FPortionFilterDialog.SelectedPortionTypesAsIntList(currentFilteredPortions);

    if FPortionFilterDialog.ShowModal = mrOk then
    begin
      Result := mrOk;

      FPortionFilterDialog.SelectedPortionTypesAsIntList(newFilteredPortions);

      settingsChanged := not(IntegerListsAreEqual(currentFilteredPortions, newFilteredPortions));
    end
    else
    begin
      Result := mrCancel;
    end;
  finally
    currentFilteredPortions.Free;
    newFilteredPortions.Free;
  end;
end;

procedure TNewPortionIngredientsFrame.PortionFilterActionExecute(Sender: TObject);
var filterSettingsChanged: boolean;
begin
  //Note: The dual nature of the cbPortionFilter checkbox is confusing and makes the code harder to understand.
  //It is both a means of enabling/disabling any portion type filter AND a means of indicating whether or not
  //the portion types are currently filtered. This is the same meaning as the "Filtered" checkbox on the tEnityLookupFrame
  //which is why it was implemented this way - to be consistent.
  if ShowPortionFilterDialog(filterSettingsChanged) = mrOk then
  begin
    if filterSettingsChanged or (not cbPortionFilter.Checked and FPortionFilterDialog.FilterApplied) then
    begin
      setCbStateWithNoEvent(cbPortionFilter, FPortionFilterDialog.FilterApplied);  //Check this according to whether portions are currently filtered (see comment above)
      ApplyPortionTypeFilterChangeToGrids;
    end;
  end;
end;

procedure TNewPortionIngredientsFrame.cbPortionFilterClick(Sender: TObject);
var filterSettingsChanged: boolean;
begin
  if cbPortionFilter.Checked then
  begin
    setCbStateWithNoEvent(cbPortionFilter, false); // Untick because we don't yet know if a filter will actually be applied

    if (ShowPortionFilterDialog(filterSettingsChanged) = mrOk) and FPortionFilterDialog.FilterApplied then
    begin
      setCbStateWithNoEvent(cbPortionFilter, true);
      ApplyPortionTypeFilterChangeToGrids
    end;
  end
  else
    //TODO PM874: Create FPortionFilterDialog when this form created, but don't initialise with data in create. Instead
    //keep a private initialised variable and use this in OnShow to initialise if necessary. Can then call FilterApplied
    //without checking if  FPortionFilterDialog assigned.
    if Assigned(FPortionFilterDialog) and FPortionFilterDialog.FilterApplied then
      ApplyPortionTypeFilterChangeToGrids;
end;

function TNewPortionIngredientsFrame.CanAddPortionForProductFlags(EntityCode: Double): boolean;
begin
  if(ProductsDB.ClientPPTableIsDonation.Value or
     ProductsDB.ClientPPTableIsFootfall.Value) then
    Result := false
  else
    Result := true;
end;

initialization
  ZonalBlue := RGB(125,206,227);
  ZonalBlueGray := RGB(104,138,147);
  ZonalGray := RGB(186,186,186);
end.
