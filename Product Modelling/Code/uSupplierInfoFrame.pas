unit uSupplierInfoFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, DB, Forms, Dialogs,
  StdCtrls, uAztecDBComboBox, Mask, DBCtrls, uSupplierFrame, uDatabaseADO, DateUtils,
  uFutureDate, uGlobals, ActnList, ExtCtrls;

type
   TSupplierInfoFrame = class(TFrame)
    InvoiceNameLabel: TLabel;
    InvoiceNameEdit: TDBEdit;

    StockUnitLabel: TLabel;
    PurchaseUnitComboBox: TAztecDBComboBox;

    DefaultSupplierLabel: TLabel;
    DefaultSupplierEdit: TDBEdit;

    AlcoholLabel: TLabel;
    AlcoholEdit: TDBEdit;

    UnitSupplierFrame: TUnitSupplierFrame;
    BudgetedCostPriceLabel: TLabel;
    FutureCostlbl: TLabel;
    CancelFutureCostBtn: TButton;
    FutureCostDateCbx: TComboBox;
    FutureCostPricesExistlbl: TLabel;
    BudgetedCostPriceMemo: TMemo;
    B2BNameLabel: TLabel;
    B2BNameEdit: TDBEdit;

    constructor Create(Owner: TComponent); override;
    procedure PurchaseUnitComboBoxCreateNew(Sender: TObject);
    procedure ComboBoxExit(Sender: TObject);
    procedure FutureCostDateCbxChange(Sender: TObject);
    procedure FutureCostDateCbxDropDown(Sender: TObject);
    procedure CancelFutureCostBtnClick(Sender: TObject);
    procedure UnitSupplierFrameFlexiDBGrid1Exit(Sender: TObject);
  private
    // Event handler - invoked if the default purchase unit changes (or any of its properties).
    FOnDefaultPurchaseUnitChange : TNotifyEvent;

    FOld_EffectiveDate: String;
    FInitialFutureDate: TDate;
    FEffectiveDates: TAztecDateList;

    FEntityCode: double;

    procedure FilterFutureCostData;

    function ViewingDate: String;

    procedure checkComboNamesValid( et: EntType; comboBox: TDBComboBox );
    procedure DefaultPurchaseUnitChange(Sender: TObject);
    // Set the import/export ref to match the default purchase unit.
    procedure updateImportExportRef;

    function PendingChangesExist: Boolean;
    procedure SetInitialFutureDate(const Value: TDate);
    function GetInitialFutureDate: TDate;
    procedure UpdateBudgetedCostPriceDisplay(Value: Double);
    function IsInitialisedForCurrentProduct: boolean;
  public
    procedure beforeEntityPost( et: EntType );
    procedure onEntityStateChange( et: EntType );
    procedure onEntityDataChange( et: EntType; field: TField );
    procedure setupUnitPickLists;
    procedure setupStaticPickLists;
    // Recalculate the budgeted cost price for the current product.
    procedure calculateBudgetedCostPrice;

    function ReverseStringDate(ADate:string):string;
    procedure SetupEffectiveDates(_EntityCode: Double);overload;
    procedure SetupEffectiveDates(EffectiveDates: String);overload;
    procedure CreateNew;
    procedure EnsureInitialisedForCurrentProduct;
    procedure InitialiseForCurrentProduct;
    procedure InitialiseFromAnotherProduct(fullClone: boolean; BaseEntityCode: Double);
    procedure SaveChanges;
    procedure DisplayFutureChangeLabel;
    procedure ShowHideB2BName;

    // Event handler - invoked if the default purchase unit changes (or any of its properties).
    property OnDefaultPurchaseUnitChange : TNotifyEvent read FOnDefaultPurchaseUnitChange write FOnDefaultPurchaseUnitChange;
    property InitialFutureDate: TDate read GetInitialFutureDate write SetInitialFutureDate;
  end;

implementation

{$R *.dfm}

uses variants, uGuiUtils, uMaintUnit, uLineEdit, uDatePicker, ADODB, uADO, uLog, Math;

constructor TSupplierInfoFrame.Create(Owner: TComponent);
begin
  inherited;
  // Make sure we are informed when the user changes the default purchase unit, so that the budgeted cost price
  // and bar code can be updated.
  UnitSupplierFrame.OnDefaultPurchaseUnitChange := DefaultPurchaseUnitChange;

//Added by AK for PM335
  ProductsDB.UnitSupplierTable.Active := FALSE;
  ProductsDB.UnitSupplierTable.TableName := '#tmpPurchaseUnits';
  ProductsDB.UnitSupplierTable.Active := TRUE;

  ProductsDB.SaveUnitSupplierChanges := SaveChanges;
  ProductsDB.UnitSupplierChangesExist := PendingChangesExist;

  // introduced for PM740
  ShowHideB2BName;

  FInitialFutureDate := Date + 1;
  FEntityCode := -1;
end;

procedure TSupplierInfoFrame.DefaultPurchaseUnitChange(Sender: TObject);
begin
  updateImportExportRef;

  calculateBudgetedCostPrice;

  // Pass this event on.
  if assigned(FOnDefaultPurchaseUnitChange) then FOnDefaultPurchaseUnitChange(self);
end;

// Do validation before allowing any changes to be posted.
procedure TSupplierInfoFrame.beforeEntityPost( et: EntType );

  procedure GetPortionUnits(UnitList: TStringList);
  var
    UnitName: String;
    i: Integer;
  begin
    if not Assigned(UnitList) then Exit;

    if not (LineEditForm.NewPortionIngredientsFrame.IsInitialisedForCurrentProduct)  then
    begin
      LineEditForm.NewPortionIngredientsFrame.InitialiseForCurrentProduct;
    end;

    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT UnitName1,UnitName2,UnitName3,Unitname4,UnitName5,');
      SQL.Add('UnitName6,UnitName7,UnitName8,Unitname9,UnitName10');
      SQL.Add('FROM #TmpPortionCrosstab');
      SQL.Add('WHERE EntityCode = ' + FloatToStr(FEntityCode));
      Open;

      if not EOF then
      begin
        for i := 1 to 10 do
        begin
          if not FieldByName('UnitName' + IntTostr(i)).IsNull then
          begin
            UnitName := FieldByName('UnitName' + IntTostr(i)).AsString;
            UnitList.Add(UnitName);
          end;
        end;
      end;
    end;
  end;

var
  unitName: string;
  cost: Double;
  UsedUnits: TStringList;
  i: Integer;
begin
  if IsBlank( productsDB.ClientEntityTablePurchaseUnit ) then begin
    PrizmSetFocus( PurchaseUnitComboBox );
    ShowMessage( 'Cannot have a blank Stock unit' );
    Abort;
  end;

  if IsBlank( productsDB.ClientEntityTableDefaultSupplier ) then begin
    PrizmSetFocus( UnitSupplierFrame.FlexiDBGrid1 );
    if productsDB.UnitSupplierTable.RecordCount = 0 then
    begin
      ShowMessage( 'You must add at least one supplier.' );
      Abort;
    end else if not UnitSupplierFrame.isSoleSupplier then
    begin
      ShowMessage( 'There must be a default supplier - please set a default supplier.' );
      Abort;
    end else
    begin
      // Only one supplier - help out the user in this case
      if MessageDlg( 'You have not set a default supplier.'#10#13+
                     'Do you want to use '''+UnitSupplierFrame.getSoleSupplier+''' as the default supplier?',
                     mtWarning, [mbOk,mbCancel], 0 ) <> mrOk then
      begin
        ShowMessage( 'Please set a default supplier.' );
        Abort;
      end else begin
        UnitSupplierFrame.SetDefaultSupplierActionExecute( nil );
      end;
    end;
  end;

  // Check default supplier is in the list
  if not UnitSupplierFrame.getDefaultPurchaseUnitInfo( unitName, cost ) then begin
    PrizmSetFocus( UnitSupplierFrame.FlexiDBGrid1 );
    if not UnitSupplierFrame.isSoleSupplier then
    begin
      ShowMessage(
        'The default supplier ' + productsDB.ClientEntityTableDefaultSupplier.Value +
        ' is not in the list of suppliers.'#13#10'Please add an entry for this supplier ' +
        ' or set a different supplier'#13#10'as the default supplier.' );
      Abort;
    end else begin
      // Only one supplier - offer to switch to it.
      if MessageDlg(
        'The default supplier ' + productsDB.ClientEntityTableDefaultSupplier.Value +
        ' is not in the list of suppliers.'#13#10+
        'Do you want to set '''+UnitSupplierFrame.getSoleSupplier+''' as the default supplier?',
        mtWarning, [mbOk,mbCancel], 0 ) <> mrOk then
      begin
        ShowMessage(
          'Please add an entry for supplier '+ productsDB.ClientEntityTableDefaultSupplier.Value+
          #13#10'or set a different supplier as the default.' );
        Abort;
      end else begin
        UnitSupplierFrame.SetDefaultSupplierActionExecute( nil );
      end;
    end;
  end;

  if (et = etStrdLine) then
  begin
    // Check stock unit is compatible with the selling unit.
    UsedUnits := TStringList.Create;
    try
      UsedUnits.Sorted := True;
      UsedUnits.Duplicates := dupIgnore;
      GetPortionUnits(UsedUnits);

      for i := 0 to UsedUnits.Count - 1 do
      begin
        unitName := UsedUnits[i];
        if (unitName <> '') and (Lowercase(unitName) <> Lowercase(FACTORTYPE))
          and (Lowercase(unitName) <> Lowercase(PORTIONTYPE)) then
        begin
          if not productsDB.unitsHaveSameBaseType( unitName,
                                          productsDB.ClientEntityTablePurchaseUnit.Value ) then begin
            PrizmSetFocus( PurchaseUnitComboBox );
            ShowMessage( 'Stock unit ' + productsDB.ClientEntityTablePurchaseUnit.Value + ' is not ' +
             'compatible with'#13#10'the portion unit ' + unitName );
            Abort;
          end;
        end;
      end;
    finally
      UsedUnits.Free;
    end;
  end;

  // Check purchase units for all suppliers
  UnitSupplierFrame.beforeEntityPost( et );
end;

// Check contents of combo boxes is valid.
procedure TSupplierInfoFrame.checkComboNamesValid( et: EntType; comboBox: TDBComboBox );
var
  newProduct : boolean;

  // Should a particular field be validated?  Only if the field has been modified, and,
  // if we are only validating a single combo box, only if the field corresponds to that combo box.
  function ShouldValidateField( field: TField ): boolean;
  begin
    if Assigned( combobox ) and (combobox.Field <> field) then
      Result := false // Only validate the field we are leaving
    else if productsDB.ProductNewlyInsertedAndNotSaved then
      Result := true  // Validate all fields on insert
    else if field.AsVariant <> field.OldValue then
      Result := true  // Validate changed field
    else
      Result := false // Don't validate unchanged field
  end;

begin
  newProduct := productsDB.ProductNewlyInsertedAndNotSaved;

  // Check units specified are legal.
  // Only validate if units specified have changed.
  // Ignore blanks when dealing with a new record - blanks are picked up when posting record.
  if ShouldValidateField( productsDB.ClientEntityTablePurchaseUnit ) and
     not FieldMatchesPickList( productsDB.ClientEntityTablePurchaseUnit,
                               productsDB.validUnitsStringList,
                               newProduct ) then begin

    PrizmSetFocus( PurchaseUnitComboBox );
    ShowMessage( '''' + productsDB.ClientEntityTablePurchaseUnit.Value + ''' is not a valid unit name.' );
    if not newProduct then
      productsDB.ClientEntityTablePurchaseUnit.AsVariant :=
        productsDB.ClientEntityTablePurchaseUnit.OldValue;
    Abort;
  end;

  // Base unit type may not be changed on a product, unless the product is still in the process
  // of being created. This is the blunt approach to prevent the problem of a recipe using an amount
  // of an ingredient whose unit is no longer compatible with the unit the product is purchased in.
  if not productsDB.AllowBaseUnitChange then
  begin
    if ShouldValidateField(productsDB.ClientEntityTablePurchaseUnit)
      and (ProductsDB.OriginalBaseUnit <> '')
      and not productsDB.unitsHaveSameBaseType(productsDB.ClientEntityTablePurchaseUnit.Value, ProductsDB.OriginalBaseUnit) then
    begin
      PrizmSetFocus( PurchaseUnitComboBox );

      ShowMessage( 'The stock unit may not be changed from ' + productsDB.ClientEntityTablePurchaseUnit.OldValue +
                   ' to ' + productsDB.ClientEntityTablePurchaseUnit.Value );

      productsDB.ClientEntityTablePurchaseUnit.AsVariant :=
        productsDB.ClientEntityTablePurchaseUnit.OldValue;

      Abort;
    end;
  end; // not allowAnyUnits
end;

procedure TSupplierInfoFrame.onEntityStateChange( et: EntType );
begin
  // When dataset is in insert mode, user may pick any units;  but normally, only units
  // compatible with the current purchase unit are allowed.  When dataset state changes,
  // update the pick lists for units.
  setupUnitPickLists;
end;

// Called if data changes in the entity table.
procedure TSupplierInfoFrame.onEntityDataChange( et: EntType; field: TField );
begin
  UnitSupplierFrame.onEntityDataChange( et, field );

  if (field = productsDB.ClientEntityTablePurchaseUnit) then begin
    // Change to purchase unit affect budgeted cost price & num out
    calculateBudgetedCostPrice;
  end;
end;

procedure TSupplierInfoFrame.setupStaticPickLists;
begin
  UnitSupplierFrame.setupStaticPickLists;
end;

procedure TSupplierInfoFrame.setupUnitPickLists;
begin
  if productsDB.AllowBaseUnitChange then
  begin
    // Allow any units for a new row.
    setComboBoxItems( PurchaseUnitComboBox, productsDB.validUnitsStringList );
  end else
  begin
    // Only units with the same base type are allowed for an existing row.
    setComboBoxItems( PurchaseUnitComboBox, productsDB.getUnitsWithSameBaseType(
      ProductsDB.OriginalBaseUnit, false ) );
  end;
end;

procedure TSupplierInfoFrame.ComboBoxExit(Sender: TObject);
begin
  if (productsDB.ClientEntityTable.State = dsInsert) or (productsDB.ClientEntityTable.State = dsEdit) then
    checkComboNamesValid( EntTypeStringToEnum( productsDB.ClientEntityTableEntityType.Value ),
                          TDBComboBox( Sender ) );
end;

procedure TSupplierInfoFrame.PurchaseUnitComboBoxCreateNew(
  Sender: TObject);
begin
  fMaintUnit := TfMaintUnit.Create(Self);

  try
    if fMaintUnit.ShowModal = mrOk then begin
      TAztecDBComboBox( Sender ).DataSource.Edit;
      TAztecDBComboBox( Sender ).Field.Text := fMaintUnit.edtUName.Text;
    end;
  finally
    fMaintUnit.Free;
  end;
end;

// Update budgeted cost price
{ TODO (Code review GDM): I think this method should really be in a datamodule not in this GUI class. Ideally the datamodule
   would automatically be informed when the relevant fields changed (via the datasets themselves) rather than
   be informed by the GUI  }
procedure TSupplierInfoFrame.calculateBudgetedCostPrice;
var
  defPurchUnitUnitName : string;
  defPurchUnitUnitCost : Double;
  budgeted_cost_price : Double;
  base_purchase_units, base_defpurch_units: Double;
begin
  base_purchase_units := productsDB.getBaseUnits( productsDB.ClientEntityTablePurchaseUnit.Value );

  // Get the default purchase unit...
  if UnitSupplierFrame.getDefaultPurchaseUnitInfo(
    defPurchUnitUnitName,
    defPurchUnitUnitCost ) then begin

    base_defpurch_units := productsDB.getBaseUnits( defPurchUnitUnitName );

    if (base_defpurch_units <> 0) and (base_purchase_units <> 0) then begin

      // Simple sum to work out cost price.
      budgeted_cost_price := defPurchUnitUnitCost * base_purchase_units / base_defpurch_units;

    end else begin

      // Something was wrong with the units...
      budgeted_cost_price := -1;

    end;

  end else begin

    // No default purchase unit
    budgeted_cost_price := -1;

  end;

  if not UnitSupplierFrame.IsFutureCostPrice then
  begin
    if budgeted_cost_price = -1 then begin
      productsDB.ClearBudgetedCostPrice;
    end else begin
      productsDB.SetBudgetedCostPrice( budgeted_cost_price );
    end;
    UpdateBudgetedCostPriceDisplay(productsDB.ClientEntityTableBudgetedCostPrice.Value);
  end
  else
    UpdateBudgetedCostPriceDisplay(budgeted_cost_price);
end;

procedure TSupplierInfoFrame.updateImportExportRef;
var
  oldImpExpRef, newImpExpRef: string;
begin
  if UnitSupplierFrame.getImportExportRef(
    oldImpExpRef, newImpExpRef ) then
  begin
    // If the user has typed something different into the import/export reference,
    // then preserve it.
    if (productsDB.ClientEntityTableImportExportReference.Value = oldImpExpRef) and
       (oldImpExpRef <> newImpExpRef) then
    begin
      productsDB.ClientEntityTable.Edit;
      productsDB.ClientEntityTableImportExportReference.Value := newImpExpRef;
    end;
  end;
end;

procedure TSupplierInfoFrame.EnsureInitialisedForCurrentProduct;
begin
  if IsInitialisedForCurrentProduct then
    Exit;

  InitialiseForCurrentProduct;
end;

procedure TSupplierInfoFrame.InitialiseForCurrentProduct;
var
  isStdLine: boolean;
  et: EntType;
begin
  et := EntTypeStringToEnum(productsDB.ClientEntityTableEntityType.Value);
  isStdLine := (et = etStrdLine);
  AlcoholLabel.Visible := isStdLine;
  AlcoholEdit.Visible := isStdLine;

  FEntityCode := ProductsDB.ClientEntityTableEntityCode.AsFloat;
  SetupEffectiveDates(FEntityCode);

  // Setup unit pick lists with units compatible with the current purchase unit.
  setupUnitPickLists;

  // Update supplier frame.
  UnitSupplierFrame.InitialiseForCurrentProduct;
end;

function TSupplierInfoFrame.ReverseStringDate(ADate:string):string;
var
  temp:string;
  loop:integer;
begin
   temp := ADate;
   Result := '';
   repeat
     loop := LastDelimiter('/',temp);
     if loop > 0 then
     begin
       Result := Result + copy(temp,loop + 1,length(temp) - (loop)) + '-';
       delete(temp,loop,length(temp));
     end;
   until loop = 0;
   Result := Result + temp;
end;


procedure TSupplierInfoFrame.FilterFutureCostData;
var
  datefilter:string;
  EntityCode: String;
  EffectiveDate: String;
begin
//Added by AK for PM335
//This is used in place of the Master/Source connection in the productsbd.UnitSupplierTable table component
//so that the same save/delete procedures can be used to save the future cost prices
//To Renable the Master/Source connection select EntityDataSource as the MasterSource
//and set the MastersFields value to EntityCode

  if FutureCostDateCbx.Items[FutureCostDateCbx.Itemindex] = CURRENT_ITEM then
  begin
    datefilter := datetostr(date);
    CancelFutureCostBtn.Enabled := FALSE;
    UnitSupplierFrame.IsFutureCostPrice := False
  end
  else
  begin
    datefilter := ViewingDate;
    CancelFutureCostBtn.Enabled := not ProductsDB.CurrentEntityControlledByRM;
    UnitSupplierFrame.IsFutureCostPrice := True
  end;

  ProductsDB.UnitSupplierTable.Active := FALSE;
  try
    if FutureCostDateCbx.Items[FutureCostDateCbx.ItemIndex] <> CURRENT_ITEM then
      EffectiveDate := FEffectiveDates[FutureCostDateCbx.ItemIndex-1].GetAsISODateFormat
    else
      EffectiveDate := CURRENT_ITEM;

    UnitSupplierFrame.EffectiveDate := EffectiveDate;

    EntityCode := ProductsDB.ClientEntityTableEntityCode.AsString;

    ProductsDB.qLoadPurchaseUnits.Parameters.ParamByName('entitycode').value := EntityCode;
    ProductsDB.qLoadPurchaseUnits.Parameters.ParamByName('effectivedate').value := EffectiveDate;
    ProductsDB.qLoadPurchaseUnits.ExecSQL;
    ProductsDB.qLoadPurchaseUnits.Close;
  finally
    ProductsDB.UnitSupplierTable.Active := TRUE;
  end;

  if EffectiveDate <> CURRENT_ITEM then
  begin
    //Don't fire the callback - impexref not changed, just calc the budgeted
    // cost price based on the future cost prices being shown
    UnitSupplierFrame.refreshSupplierInfo(False);
    calculateBudgetedCostPrice;
  end
  else
    //If it's current just use the products.[Budgeted Cost Price] value
    UpdateBudgetedCostPriceDisplay(ProductsDb.ClientEntityTableBudgetedCostPrice.Value);
end;

procedure TSupplierInfoFrame.SetupEffectiveDates(_EntityCode: Double);
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

    SQL.Text := 'select distinct dbo.fn_DateFromDateTime(puf.[EffectiveDate]) as ''effdate'' '
      + 'from PurchaseUnitsFuture puf '
      + 'where puf.[entity code] = ' + Target
      + ' and dbo.fn_DateFromDateTime(puf.[EffectiveDate]) > ''' + FormatDateTime('yyyy-mm-dd',date)
      + ''' order by dbo.fn_DateFromDateTime(puf.[EffectiveDate]) desc';
    Open;

    while not EOF do
    begin
      FEffectiveDates.AddDate(FieldByName('effdate').AsDateTime,InsertionPoint);
      Next;
    end;
  end;
  SetupEffectiveDates(FEffectiveDates.Text);
  FilterFutureCostData;
end;

procedure TSupplierInfoFrame.SetupEffectiveDates(EffectiveDates: String);
begin
  with FutureCostDateCbx do
  begin
    Items.Clear;
    Items.Text := EffectiveDates;

    if (Items.IndexOf(NEW_ITEM) = -1) and not ProductsDB.CurrentEntityControlledByRM then
      Items.Add(NEW_ITEM)
    else if (Items.IndexOf(NEW_ITEM) <> -1) and ProductsDB.CurrentEntityControlledByRM then
      Items.Delete(Items.IndexOf(NEW_ITEM));

    if Items.IndexOf(CURRENT_ITEM) = -1 then
      Items.Insert(0,CURRENT_ITEM);

    if FOld_EffectiveDate = '' then
      ItemIndex := 0
    else
      ItemIndex := Items.IndexOf(FOld_EffectiveDate);
  end;

  DisplayFutureChangeLabel;
end;

procedure TSupplierInfoFrame.FutureCostDateCbxDropDown(Sender: TObject);
begin
  ProductsDB.UnitSupplierTable.DisableControls;
  try
    if PendingChangesExist then
    begin
      ProductsDB.LogProductChange('Supplier Purchase Units: Changing effective date for prices');
      ProductsDB.SaveAllTableChanges;
    end;
  finally
    ProductsDB.UnitSupplierTable.EnableControls;
  end;

  FOld_EffectiveDate := FutureCostDateCbx.Text;
end;

procedure TSupplierInfoFrame.FutureCostDateCbxChange(Sender: TObject);
begin
  with sender as TComboBox do
  begin
    if ItemIndex = Items.IndexOf(NEW_ITEM) then
    begin
      ItemIndex := Items.IndexOf(FOld_EffectiveDate);
      CreateNew;
    end
    else
      FilterFutureCostData;
  end;
end;

procedure TSupplierInfoFrame.CreateNew;
var
  InsertionPoint: Integer;
begin
    // now user must select the date to apply changes.
    with FutureCostDateCbx do
    //Date picker demands a min and max date - make the max date sufficiently
    //far in the future so as to make it unbounded for all pratical purposes
    DatePickerForm.SetQueryParams(
      'On which date would you like future changes to become effective on site(s)?',
      Date + 1, IncYear(Date,20), InitialFutureDate);
    if DatePickerForm.ShowModal = mrOk then
    begin
      if FEffectiveDates.AddDate(DatePickerForm.Date,InsertionPoint) then
      begin
        InitialFutureDate := DatePickerForm.Date;

        SetupEffectiveDates(FEffectiveDates.Text);
        FutureCostDateCbx.ItemIndex := InsertionPoint + 1;

        FilterFutureCostData;

        UnitSupplierFrame.PendingChangesExist := True;
        UnitSupplierFrame.FlexiDBGrid1.SetFocus;
      end
      else
        MessageDlg('Future changes are already present for the chosen date.',
                    mtError,
                    [mbOK],
                    0);
    end;
end;

procedure TSupplierInfoFrame.CancelFutureCostBtnClick(Sender: TObject);
begin
  if MessageDlg('Future changes for ' + ViewingDate + ' will be deleted.' +
   #13#10 + 'Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  with ProductsDB.UnitSupplierTable do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Log.Event(Format('Future cost price change deleted by %s : ' +
        'Entity Code = %s, Supplier = %s, Unit = %s, Flavour = %s, Cost = %s, Effective Date = %s',
        [CurrentUser.UserName,
        FieldByName('Entity Code').AsString,
        FieldByName('Supplier Name').AsString,
        FieldByName('Unit Name').AsString,
        FieldByName('Flavour').AsString,
        FieldByName('Unit Cost').AsString,
        FEffectiveDates[FutureCostDateCbx.ItemIndex-1].GetAsISODateFormat]));
      Delete;
    end;
    UnitSupplierFrame.PendingChangesExist := True;
  finally
    EnableControls;
  end;
  ProductsDB.SaveAllTableChanges;
  InitialiseForCurrentProduct;
end;

function TSupplierInfoFrame.ViewingDate: String;
begin
  Result := FEffectiveDates.AztecDisplayDate[FutureCostDateCbx.ItemIndex-1];
end;

procedure TSupplierInfoFrame.SaveChanges;
var
  EntityCode: String;
  EffectiveDate: String;
  OldQueryText: String;
begin
  Assert(IsInitialisedForCurrentProduct,
     'Erroneous attempt to save supplier details for product ' + FloatToStr(FEntityCode) +
     ' against product ' + productsDB.ClientEntityTableEntityCode.AsString);

  if FutureCostDateCbx.Items[FutureCostDateCbx.ItemIndex] <> CURRENT_ITEM then
    EffectiveDate := FEffectiveDates[FutureCostDateCbx.ItemIndex-1].GetAsISODateFormat
  else
    EffectiveDate := CURRENT_ITEM;
  EntityCode := ProductsDB.ClientEntityTableEntityCode.AsString;
  OldQueryText := ProductsDB.qSavePurchaseUnits.SQL.Text;
  try
    ProductsDB.qSavePurchaseUnits.SQL.Text :=
            Format(ProductsDB.qSavePurchaseUnits.SQL.Text,
                  [EffectiveDate,EntityCode,CurrentUser.ID]);
    if (EffectiveDate = CURRENT_ITEM) then
      ProductsDB.LogProductChange('About to save PurchaseUnits changes (current date) - updates PurchaseUnits and PurchaseUnitsFuture ')
    else
      ProductsDB.LogProductChange('About to save PurchaseUnits changes (future date) - updates PurchaseUnitsFuture');

    // Although qSavePurchaseUnits rolls back the transaction if any errors are raised, exception handling should handle any other type of error
    try
      ProductsDB.qSavePurchaseUnits.ExecSQL;
      ProductsDB.LogProductChange('PurchaseUnits changes SQL executed');
    except
      on E: Exception do
      begin
        Log.Event('Error saving PurchaseUnits changes: ' + E.Message);
        raise Exception.Create('Error saving Supplier Purchase Unit changes: ' + E.Message);
      end;
    end;
  finally
    ProductsDB.qSavePurchaseUnits.Close;
    UnitSupplierFrame.PendingChangesExist := False;
    ProductsDB.qSavePurchaseUnits.SQL.Text := OldQueryText;
  end;

  DisplayFutureChangeLabel;
end;

function TSupplierInfoFrame.PendingChangesExist: Boolean;
begin
  Result := UnitSupplierFrame.PendingChangesExist;
end;

procedure TSupplierInfoFrame.DisplayFutureChangeLabel;
begin
  if ProductsDB.ClientEntityTableEntityCode.AsString <> '' then
  begin
    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.Clear;

      SQL.Add('select count(distinct EffectiveDate) as NumFutureDates');
      SQL.Add('from PurchaseUnitsFuture');
      SQL.Add('where [entity Code] = ' + ProductsDB.ClientEntityTableEntityCode.AsString);
      SQL.Add('and effectivedate > GETDATE()');

      Open;
      if not EOF then
        FutureCostPricesExistlbl.Visible := FieldByName('NumFutureDates').AsInteger > 0;
      Close;
    end;
  end;
end;

procedure TSupplierInfoFrame.SetInitialFutureDate(const Value: TDate);
begin
  if (Value > Date + 1) and (FInitialFutureDate <= (Date + 1)) then
    FInitialFutureDate := Value;
end;

function TSupplierInfoFrame.GetInitialFutureDate: TDate;
begin
  if FInitialFutureDate >= Date + 1 then
    Result := FInitialFutureDate
  else
    Result := Date + 1;
end;

procedure TSupplierInfoFrame.InitialiseFromAnotherProduct(fullClone: boolean; BaseEntityCode: Double);

  procedure ClearPurchaseUnits;
  begin
    ProductsDB.UnitSupplierTable.Active := FALSE;
    try
      ProductsDB.ADOCommand.CommandText := 'delete from #tmpPurchaseUnits';
      ProductsDB.ADOCommand.Execute;
    finally
      ProductsDB.UnitSupplierTable.Active := TRUE;
    end;
  end;

  procedure AddPurchaseUnit(supplierName, unitName, flavour, defaultFlag: string);
  begin
    with ProductsDB.UnitSupplierTable do
    begin
      Append;
      FieldByName('Entity Code').Value := FEntityCode;
      FieldByName('Supplier Name').value := supplierName;
      FieldByName('Unit Name').value := unitName;
      FieldByName('Flavour').value := flavour;
      FieldByName('Unit Cost').value := 0;
      FieldByName('Default Flag').value := defaultFlag;
      Post;
    end;
  end;

begin
  ClearPurchaseUnits;

  if fullClone then
  begin
    //Copy the purchase units of the base product but exclude the Import/Export Reference and Cost Price.

    with ProductsDB.ADOQuery do
    try
      SQL.Text := 'SELECT * FROM PurchaseUnits WHERE [Entity Code] = ' + FloatToStr(BaseEntityCode);
      Open;

      while not EOF do
      begin
        AddPurchaseUnit(
          FieldByName('Supplier Name').AsString,
          FieldByName('Unit Name').AsString,
          FieldByName('Flavour').AsString,
          FieldByName('Default Flag').AsString);
        Next;
      end;
    finally
      Close;
    end;
  end
  else
  begin
    //Create a single purchase unit based on the default purchase unit of the base product

    with ProductsDB.ADOQuery do
    try
      SQL.Text := 'SELECT [Default Supplier], [Purchase Unit] FROM Products WHERE EntityCode = ' + FloatToStr(BaseEntityCode);
      Open;

      if not EOF then
        AddPurchaseUnit(FieldByName('Default Supplier').AsString, FieldByName('Purchase Unit').AsString, '', '*');
    finally
      Close;
    end;
  end;

  FEntityCode := ProductsDB.ClientEntityTableEntityCode.AsFloat;
end;

procedure TSupplierInfoFrame.UnitSupplierFrameFlexiDBGrid1Exit(
  Sender: TObject);
begin
  if (productsDB.UnitSupplierTable.state = dsInsert) and
      productsDB.UnitSupplierTableSupplierName.IsNull and
      productsDB.UnitSupplierTableUnitName.IsNull and
      productsDB.UnitSupplierTableFlavour.IsNull then
    productsDB.UnitSupplierTable.Cancel;

  if (productsDB.UnitSupplierTable.state = dsInsert) or (productsDB.UnitSupplierTable.state = dsEdit) then
    productsDB.UnitSupplierTable.Post;
end;

procedure TSupplierInfoFrame.UpdateBudgetedCostPriceDisplay(Value: Double);
var
  budgetedcostpricetmp: int64;
begin
  if Value = -1 then
    BudgetedCostPriceMemo.Text := ''
  else begin
    //Work to 4 dp precision before rendering to 2 dp (db type is money)
    budgetedcostpricetmp := Round(Value *10000);
    BudgetedCostPriceMemo.Text := FloatToStrF(budgetedcostpricetmp/10000, ffCurrency, 15, 2);
  end;
end;

procedure TSupplierInfoFrame.ShowHideB2BName;
begin
  B2BNameLabel.Visible := ProductsDB.ShowB2BName;
  B2BNameEdit.Visible := ProductsDB.ShowB2BName;
end;

function TSupplierInfoFrame.IsInitialisedForCurrentProduct: boolean;
begin
  Result := (productsDB.CurrentEntityCode = FEntityCode);
end;

end.
