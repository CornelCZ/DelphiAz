unit uPortionIngredients;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ActnList, DB, ADODB, Variants, Wwdbigrd, Wwdbgrid;

type
  TPortionIngredientsFrame = class(TFrame)
    PortionIngredientActionList: TActionList;
    DeletePortionIngredientAction: TAction;
    InsertPortionIngredientAction: TAction;
    AppendPortionIngredientAction: TAction;
    EditPortionIngredientAction: TAction;
    IngredientsGrid: TwwDBGrid;
    procedure InsertPortionIngredientActionExecute(Sender: TObject);
    procedure DeletePortionIngredientActionExecute(Sender: TObject);
    procedure DeletePortionIngredientActionUpdate(Sender: TObject);
    procedure EditPortionIngredientActionExecute(Sender: TObject);
    procedure EditPortionIngredientActionUpdate(Sender: TObject);
    procedure IngredientsGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AppendPortionIngredientActionExecute(Sender: TObject);
    function CheckRecipeDepth(EntityCode: double; Depth: integer): boolean;
    procedure IngredientsGridDblClick(Sender: TObject);
    procedure IngredientsGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IngredientsGridUpdateFooter(Sender: TObject);

  private
    fAllowFactorQuantities: boolean;
    fEditOnDblClick: boolean;
    FBeforeIngredientAdded : TNotifyEvent;
    ParentEntityList: TStringList;
    
    UpdatingGridFooter: boolean;

    // This call displays a form allowing the user to pick an ingredient to add, and if
    // the user picks a valid ingredient, adds it with the current PortionCode.
    procedure CreateIngredient(ingredientDisplayOrder: Integer);
    procedure RenumberIngredientDisplayOrders( portionDataSet, ingredDataSet: TDataSet; makeSpaceForDisplayOrder: Integer );
    procedure InsertIntoPortion( portionsQry, ingredientsQry: TDataset; ingredientOrder: integer;
                                 ingredCalcType, ingredUnitName, ingredPortionTypeID: variant; ingredQty : double; ingredIsMinor : boolean );
    procedure DeleteFromPortion( portionDataSet, ingredDataSet: TDataSet; ingredientCode: double; ingredientDisplayOrder: integer );
    function ValidChoiceIngredient(EntityCode: double): boolean;
  public
    constructor Create(AOwner: TComponent); override;
    property BeforeIngredientAdded: TNotifyEvent read FBeforeIngredientAdded write FBeforeIngredientAdded;
    property AllowFactorQuantities: boolean read fAllowFactorQuantities write fAllowFactorQuantities;
  end;

implementation

uses uDatabaseADO, uSelectEntity, uPortionIngredientDialog, uLog, uADO, uGlobals;

{$R *.dfm}

constructor TPortionIngredientsFrame.Create(AOwner: TComponent);
begin
  inherited;

  fAllowFactorQuantities := FALSE;
  UpdatingGridFooter := FALSE;
end;

procedure TPortionIngredientsFrame.InsertPortionIngredientActionExecute(Sender: TObject);
begin
  if not (IngredientsGrid.DataSource.DataSet.bof and IngredientsGrid.DataSource.DataSet.Eof) then
    CreateIngredient( IngredientsGrid.DataSource.DataSet.FieldValues['DisplayOrder'] )
  else
    CreateIngredient( -1);
end;

procedure TPortionIngredientsFrame.DeletePortionIngredientActionExecute(Sender: TObject);
var
  ingredientId: double;
  ingredientName: string;
  ingredDisplayOrder: integer;
  book : string;
  numIngredients : integer;
begin
  if (ProductsDB.ClientEntityTableEntityType.Value = 'Strd.Line') and
     (IngredientsGrid.DataSource.DataSet.FieldByName('IngredientCode').AsFloat =
      ProductsDB.ClientEntityTableEntityCode.Value) then
  begin
    // There must be at least one instance of this ingredient in the list - is this the last one?
    with IngredientsGrid.DataSource.DataSet do
    begin
      numIngredients := 0;
      if not (EOF and BOF) then begin
        DisableControls;
        try
          book := Bookmark;
          First;
          while not EOF do begin
            if FieldByName('IngredientCode').AsFloat = ProductsDB.ClientEntityTableEntityCode.Value then
              Inc( numIngredients );
            Next;
          end;
        finally
          Bookmark := book;
          EnableControls;
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

  ingredientId := IngredientsGrid.DataSource.DataSet.FieldByName('IngredientCode').AsFloat;
  ingredientName := IngredientsGrid.DataSource.DataSet.FieldByName('IngredientName').AsString;

  ingredDisplayOrder := IngredientsGrid.DataSource.DataSet.FieldByName('DisplayOrder').AsInteger;
  if MessageDlg( 'Are you sure you want to delete ingredient ' + ingredientName + '?',
                 mtConfirmation, [mbOk, mbCancel], 0 ) <> mrOk then
    Abort;

  // Delete the currently selected ingredient
  IngredientsGrid.DataSource.DataSet.DisableControls;
  try
    with ProductsDB do
    begin
      DeleteFromPortion(PortionsQuery1, IngredientsQuery1, ingredientId, ingredDisplayOrder);
    end;

    IngredientsGridUpdateFooter(nil);

    ProductsDb.LogProductChange('Ingredient deleted: "' + ingredientName + '" (' + FloatToStr(ingredientId) + ')');
  finally
    IngredientsGrid.DataSource.DataSet.EnableControls;
  end;
end;

procedure TPortionIngredientsFrame.DeleteFromPortion( portionDataSet, ingredDataSet: TDataSet; ingredientCode: double; ingredientDisplayOrder: integer );
var foundIngredient : boolean;
begin
  portionDataSet.Open;
  if not (portionDataSet.RecordCount > 0) then
    exit;


  //Note: Tried using TDataSet.Locate instead of the following scan but it didn't work. Don't know why! GDM
  with ingredDataSet do begin
    foundIngredient := false;
    Open;
    First;
    while not(Eof) and not(foundIngredient) do begin
      if (FieldByName('DisplayOrder').Value = ingredientDisplayOrder) and
         (FieldByName('IngredientCode').Value = ingredientCode) then
        foundIngredient := true
      else
        Next;
    end;

    //If cannot find ingredient something has gone wrong.
    Assert(foundIngredient, 'Failed to find ingredient to delete (' + IntToSTr(ingredientDisplayOrder) + ',' +
                            FloatToSTr(ingredientCode) + ') in dataset ' + ingredDataSet.Name);

    Delete;
  end;
end;

procedure TPortionIngredientsFrame.DeletePortionIngredientActionUpdate(Sender: TObject);
begin
  // Don't allow delete if there is nothing in the table.  Although you can't delete
  // the 'self' ingredient of a standard line, we check for this in the execute
  // event, not here.
  DeletePortionIngredientAction.Enabled :=
    not (IngredientsGrid.DataSource.DataSet.Bof and IngredientsGrid.DataSource.DataSet.Eof);
end;

procedure TPortionIngredientsFrame.EditPortionIngredientActionExecute(Sender: TObject);
var
  LogText: string;
begin
  //If the parent is a standard product and the ingredient to be edited is itself then
  //check first that the stock unit has been entered on the Supplier tab.
  if IngredientsGrid.DataSource.DataSet.FieldByName('IngredientCode').AsFloat = ProductsDB.ClientEntityTableEntityCode.Value then
    if ProductsDB.ClientEntityTablePurchaseUnit.Value = '' then begin
        ShowMessage('You must first enter the Stock Unit for this product');
        exit;
    end;

  if (IngredientsGrid.DataSource.DataSet.State = dsInsert) or (IngredientsGrid.DataSource.DataSet.State = dsEdit) then
    IngredientsGrid.DataSource.DataSet.Post;

  IngredientsGrid.DataSource.DataSet.DisableControls;

  try
    // display dialog to set unit and quantity values
    PortionIngredientDialog.Title := '';
    PortionIngredientDialog.AllowPortionNavigation := False;
    PortionIngredientDialog.setIngredientDetails(IngredientsGrid.DataSource.DataSet.FieldByName('IngredientCode').AsFloat,
                                                 IngredientsGrid.DataSource.DataSet.FieldByName('UnitName').AsString,
                                                 IngredientsGrid.DataSource.DataSet.FieldByName('PortionTypeID').AsInteger,
                                                 IngredientsGrid.DataSource.DataSet.FieldByName('Quantity').AsFloat,
                                                 IngredientsGrid.DataSource.DataSet.FieldByName('CalculationType').AsInteger,
                                                 AllowFactorQuantities, EntTypeStringToEnum(productsDB.ClientEntityTableEntityType.Value),
                                                 IngredientsGrid.DataSource.DataSet.FieldByName('IsMinor').AsBoolean);

    with IngredientsGrid.DataSource.DataSet do
    begin
      if (PortionIngredientDialog.ShowModal = mrOk) then
      begin
        Edit;

        FieldByName('CalculationType').Value := PortionIngredientDialog.getCalculationType;
        Case PortionIngredientDialog.getCalculationType of
          ord(calcUnspecified) :
            begin
              FieldByName('UnitName').Clear;
              FieldByName('PortionTypeID').Clear;
            end;
          ord(calcUnit) :
            begin
              FieldByName('UnitName').Value := PortionIngredientDialog.getUnitName;
              FieldByName('PortionTypeID').Clear;
            end;
          ord(calcPortion) :
            begin
              FieldByName('UnitName').Clear;
              FieldByName('PortionTypeID').Value := PortionIngredientDialog.getPortionTypeID;
            end;
          ord(calcFactor) : // factor
            begin
              FieldByName('UnitName').Clear;
              FieldByName('PortionTypeID').Clear;
            end;
        else // null
          begin
            FieldByName('UnitName').Clear;
            FieldByName('PortionTypeID').Clear;
          end;
        end;
        FieldByName('Quantity').Value := PortionIngredientDialog.getQuantity;
        FieldByName('IsMinor').Value := PortionIngredientDialog.getIsMinor;
        IngredientsGrid.DataSource.DataSet.Post;

        // Log the details of the changes to the product modelling log file
        if FieldByName('CalculationType').OldValue <> FieldByName('CalculationType').NewValue then
          LogText := LogText +
            'Calculation type changed from "' +
            CalcTypeEnumToString(TCalculationType(ProductsDb.VarToInt(FieldByName('CalculationType').OldValue))) +
            '" to "' +
            CalcTypeEnumToString(TCalculationType(ProductsDb.VarToInt(FieldByName('CalculationType').NewValue))) + '". ';

        if FieldByName('UnitName').OldValue <> FieldByName('UnitName').NewValue then
          LogText := LogText +
            'Unit/Portion Name changed from "' +  VarToStr(FieldByName('UnitName').OldValue) + '" to "' +
            VarToStr(FieldByName('UnitName').NewValue) + '". ';


        //Note: The variants OldValue & NewValue are converted to strings before comparing them here. This is only
        //because without the conversion the error "Invalid variant operation" is sometimes given because OldValue
        //is evaluating to "Unknown type: 24". Delphi bug?
        if VarToStr(FieldByName('Quantity').OldValue) <> VarToStr(FieldByName('Quantity').NewValue) then
          LogText := LogText +
            'Quantity changed from "' + VarToStr(FieldByName('Quantity').OldValue) + '" to "' +
            VarToStr(FieldByName('Quantity').NewValue) + '". ';

        if LogText <> '' then
          ProductsDb.LogProductChange('Ingredient edited: "' + FieldByName('IngredientName').AsString +
             '" (' + FieldByName('IngredientCode').AsString + '): ' + LogText);


        IngredientsGridUpdateFooter(nil);
      end; // if (PortionIngredientDialog.ShowModal = mrOk)
    end; // with IngredientsGrid.DataSource.DataSet do

  finally
    // If record is not saved then something went wrong - cancel any changes.
    if (IngredientsGrid.DataSource.DataSet.State = dsInsert) or (IngredientsGrid.DataSource.DataSet.State = dsEdit) then
      IngredientsGrid.DataSource.DataSet.Cancel;

    IngredientsGrid.DataSource.DataSet.EnableControls;
  end;

end;

procedure TPortionIngredientsFrame.EditPortionIngredientActionUpdate(Sender: TObject);
begin
  // Only allow edit when there is something in the table.
  EditPortionIngredientAction.Enabled :=
    (IngredientsGrid.DataSource.DataSet.State = dsInsert) or
    not (IngredientsGrid.DataSource.DataSet.Bof and IngredientsGrid.DataSource.DataSet.Eof);
end;

procedure TPortionIngredientsFrame.CreateIngredient( ingredientDisplayOrder: Integer );
var
  validIngredient, ingredIsMinor: boolean;
  ingredCalcType, ingredUnitName, ingredPortionTypeID, ingredQty: variant;
  ParentProductType : EntType;
begin
  if (IngredientsGrid.DataSource.DataSet.State = dsInsert) or (IngredientsGrid.DataSource.DataSet.State = dsEdit) then
    IngredientsGrid.DataSource.DataSet.Post;

  IngredientsGrid.DataSource.DataSet.DisableControls;

  try
    ParentProductType := EntTypeStringToEnum(ProductsDB.ClientEntityTableEntityType.Value);

    // Filter entity chooser to only allow valid entity types.
    case ParentProductType of
      etChoice:
        SelectEntityForm.setFilter( [etStrdLine,etRecipe,etChoice,etInstruct],
                                    productsDB.ClientEntityTableEntityCode.Value );

      etPrepItem:
        SelectEntityForm.setFilter( [etStrdLine,etPurchLine,etPrepItem],
                                    productsDB.ClientEntityTableEntityCode.Value );

      else //etRecipe, etStrdLine
        SelectEntityForm.setFilter( [etStrdLine,etRecipe,etPurchLine,etPrepItem,etChoice],
                                    productsDB.ClientEntityTableEntityCode.Value );
    end;

    if ParentProductType = etPrepItem then
      SelectEntityForm.setCaptionAndHelpId('Add Prepared Item Ingredient', 'Select the item to add:',
                                           AZPM_ADD_PREPAREDITEM_INGRED_FORM)
    else
      SelectEntityForm.setCaptionAndHelpId('Add Portion Ingredient', 'Select the item to add:',
                                           AZPM_ADD_PORTION_INGRED_FORM );


    validIngredient := SelectEntityForm.ShowModal = mrOk;

    if validIngredient and (EntTypeStringToEnum( ProductsDB.ClientEntityTableEntityType.Value) = etChoice) then
      validIngredient := ValidChoiceIngredient(SelectEntityForm.getSelectedEntityCode);

    if validIngredient then
      validIngredient := CheckRecipeDepth(SelectEntityForm.getSelectedEntityCode, 0);

    if validIngredient then
    begin
      // We can't add a special recipe to anything
      if SelectEntityForm.isSelectedSpecialRecipe then
      begin
        ShowMessage( 'A multi-divisional recipe may only be placed on a Variable Order Menu.' );
        validIngredient := false;
      end;
    end;

    try
      if validIngredient then
      begin
        // OK, add this item to the portion
        if ingredientDisplayOrder = -1 then
        begin
          // we want to insert this at the end of the list...
          IngredientsGrid.DataSource.DataSet.Last;
          if IngredientsGrid.DataSource.DataSet.Bof then
            ingredientDisplayOrder := 1
          else
            ingredientDisplayOrder := IngredientsGrid.DataSource.DataSet.FieldValues['DisplayOrder'] + 1;
        end
        else
        begin
          // we want to insert this at the specified display order
          with ProductsDB do
          begin
            RenumberIngredientDisplayOrders(PortionsQuery1, IngredientsQuery1, ingredientDisplayOrder);
          end;
        end;

        if Assigned(FBeforeIngredientAdded) then
          FBeforeIngredientAdded(Self);

        // Now create record
        with IngredientsGrid.DataSource.DataSet do
        begin
          // don't need PortionIngredientDialog for instructions
          if SelectEntityForm.getSelectedEntityType = etInstruct then
          begin
            with ProductsDB do
            begin
              InsertIntoPortion(PortionsQuery1, IngredientsQuery1, ingredientDisplayOrder,ord(calcUnspecified),null,null,1, PortionIngredientDialog.getIsMinor);
            end;
          end
          else
          begin
            PortionIngredientDialog.Title := '';
            PortionIngredientDialog.setIngredientDetails(SelectEntityForm.getSelectedEntityCode,
                                                         AllowFactorQuantities, EntTypeStringToEnum(productsDB.ClientEntityTableEntityType.Value),
                                                         PortionIngredientDialog.getIsMinor);

            // display dialog to get unit and quantity values
            if (PortionIngredientDialog.ShowModal = mrOk) then
            begin
              ingredCalcType := PortionIngredientDialog.getCalculationType;
              ingredUnitName := PortionIngredientDialog.getUnitName;
              ingredPortionTypeID := PortionIngredientDialog.getPortionTypeID;
              ingredQty := PortionIngredientDialog.getQuantity;
              ingredIsMinor := PortionIngredientDialog.getIsMinor;
              with ProductsDB do
              begin
                InsertIntoPortion(PortionsQuery1, IngredientsQuery1, ingredientDisplayOrder, ingredCalcType, ingredUnitName, ingredPortionTypeID, ingredQty, ingredIsMinor);
              end;
            end;
          end;

          ProductsDb.LogProductChange(
            'Ingredient added: "' + SelectEntityForm.getSelectedRetailName + '" (' +
             FloatToStr(SelectEntityForm.getSelectedEntityCode) + '), ' +
            'Calculation type: "' + CalcTypeEnumToString(TCalculationType(FieldByName('CalculationType').AsInteger)) + '", ' +
            'Unit Name: "' +  FieldByName('UnitName').AsString + '", ' +
            'Quantity: " ' + FieldByName('Quantity').AsString  + '"');
        end;


        PostRecord(ProductsDB.IngredientsQuery1);
        IngredientsGridUpdateFooter(nil);
      end;

    except
      on E: Exception do begin
        Log.Event('Cannot create ingredient: ' + E.Message);
        ShowMessage( 'Cannot create ingredient:'#13#10 + E.Message );
        ProductsDB.IngredientsQuery1.Cancel;
      end;
    end;

  finally
    IngredientsGrid.DataSource.DataSet.EnableControls;
  end;
end;

function TPortionIngredientsFrame.ValidChoiceIngredient(EntityCode: double): boolean;
var
  SavePlace: TBookMark;
begin
  Result := true;
  with IngredientsGrid.DataSource.DataSet do
  begin
    SavePlace := GetBookmark;
    try
      First;
      while not Eof do
      begin
        if (FieldValues['IngredientCode'] = EntityCode) then
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

procedure TPortionIngredientsFrame.InsertIntoPortion( portionsQry, ingredientsQry: TDataset; ingredientOrder: integer;
                                                      ingredCalcType, ingredUnitName, ingredPortionTypeID: variant; ingredQty : double; ingredIsMinor: boolean );
begin
  with ingredientsQry do
  begin
    portionsQry.Open;

    if portionsQry.RecordCount > 0 then   // if a portion has been created
    begin
      Open;
      Insert;
      FieldValues['PortionID'] := portionsQry.FieldByName('PortionID').AsInteger;
      FieldValues['DisplayOrder'] := ingredientOrder;
      FieldValues['IngredientCode'] := SelectEntityForm.getSelectedEntityCode;
      // if ingredientsQry is the dataset for the currently displayed Portion Tab
      if (IngredientsGrid.DataSource.DataSet = ingredientsQry) then
      begin
        // enter details specific to ingredients in the displayed portion
        FieldValues['CalculationType'] := ingredCalcType;
        if not VarIsNull(ingredUnitName) then FieldValues['UnitName'] := ingredUnitName;
        if not VarIsNull(ingredPortionTypeID) then FieldValues['PortionTypeID'] := ingredPortionTypeID;
        FieldValues['Quantity'] := ingredQty;
        FieldValues['IsMinor'] := ingredIsMinor;
      end
      else
      begin
        // enter details for ingredients in the 3 portions not being displayed
        FieldValues['Quantity'] := 0;
      end;
    end;
  end;
end;

procedure TPortionIngredientsFrame.RenumberIngredientDisplayOrders( portionDataSet, ingredDataSet: TDataSet; makeSpaceForDisplayOrder: Integer );
var
  ingredientDisplayOrder : Integer;
begin
  portionDataSet.Open;
  if not (portionDataSet.RecordCount > 0) then
    exit;

  ingredientDisplayOrder := 0;

  // Renumber entries in the table.  We must to this carefully to avoid a key violation.

  // First of all, we will iterate through all entries from first to last;  if the display order
  // of an entry is too high we will set it to the correct value.
  // Secondly, we will iterate through all entries from last to first;  if the display order
  // of an entry is too low we will set it to the correct value.

  // start at the beginning and decrease display orders...
  ingredDataSet.Open;
  ingredDataSet.First;
  while not ingredDataSet.EOF do begin
    Inc( ingredientDisplayOrder );
    if ingredientDisplayOrder = makeSpaceForDisplayOrder then
      Inc( ingredientDisplayOrder ); // Don't use this display order.

    // bring display order down to the correct value
    if ingredDataSet.FieldByName('DisplayOrder').Value > ingredientDisplayOrder then
    begin
      ingredDataSet.Edit;
      ingredDataSet.FieldByName('DisplayOrder').Value := ingredientDisplayOrder;
      ingredDataSet.Post;
    end;

    ingredDataSet.Next;
  end;

  // start at the end and increase display orders...
  Inc( ingredientDisplayOrder );
  ingredDataSet.Last;
  while not ingredDataSet.BOF do begin
    Dec( ingredientDisplayOrder );
    if ingredientDisplayOrder = makeSpaceForDisplayOrder then
      Dec( ingredientDisplayOrder );

    // bring display order up to the correct value
    if ingredDataSet.FieldByName('DisplayOrder').Value < ingredientDisplayOrder then
    begin
      ingredDataSet.Edit;
      ingredDataSet.FieldByName('DisplayOrder').Value := ingredientDisplayOrder;
      ingredDataSet.Post;
    end;

    ingredDataSet.Prior;
  end;
end;


procedure TPortionIngredientsFrame.IngredientsGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if InsertPortionIngredientAction.Enabled then InsertPortionIngredientAction.Execute;
    VK_RETURN: if EditPortionIngredientAction.Enabled then EditPortionIngredientAction.Execute;
    VK_DELETE: if DeletePortionIngredientAction.Enabled then DeletePortionIngredientAction.Execute;
  end
end;

procedure TPortionIngredientsFrame.AppendPortionIngredientActionExecute(Sender: TObject);
begin
  CreateIngredient(-1);
end;

function TPortionIngredientsFrame.CheckRecipeDepth(EntityCode: double; Depth: integer): boolean;
var
  InitialInstance: Boolean;
begin
  Result := True;
  InitialInstance := False;

  if Depth = 0 then
  begin
    InitialInstance := True;

    ParentEntityList := TStringList.Create;
    ParentEntityList.Add(format('%f', [ProductsDB.ClientEntityTableEntityCode.Value]));

    Depth := ProductsDb.GetMaxDepth(ProductsDB.ClientEntityTableEntityCode.Value, ParentEntityList);
  end;

  if Depth = MAX_RECIPE_DEPTH then
  begin
    ShowMessage('Cannot insert ingredient.  Nesting of Portion Ingredients may not exceed ' + IntToStr(MAX_RECIPE_DEPTH) + ' levels.');
    Result := False;
  end
  else
  begin
    with TADOQuery.Create(Self) do
    begin
      Connection := dmADO.AztecConn;
      SQL.Clear;
      SQL.Add('select p.EntityCode, i.IngredientCode');
      SQL.Add('from Portions p inner join PortionIngredients i');
      SQL.Add('on p.PortionID = i.PortionID');
      SQL.Add('where p.EntityCode = ' + format('%f', [EntityCode]));
      SQL.Add('and i.IngredientCode <> ' + format('%f', [EntityCode]));
      Open;

      if RecordCount > 0 then
      begin
        while not EOF do
        begin
          if ParentEntityList.IndexOf(format('%f', [FieldByName('IngredientCode').AsFloat])) <> -1 then
          begin
            ShowMessage('Cannot insert ingredient as it already exists as a nested ingredient.');
            Result := False;
            Break;
          end;

          Result := Result and CheckRecipeDepth(FieldByName('IngredientCode').AsFloat, Depth + 1);

          Next;
        end;
      end;

      Close;
      Free;
    end;
  end;

  if InitialInstance then
    ParentEntityList.Free;
end;

procedure TPortionIngredientsFrame.IngredientsGridDblClick(
  Sender: TObject);
begin
  if fEditOnDblClick then
    EditPortionIngredientAction.Execute;
end;

procedure TPortionIngredientsFrame.IngredientsGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  grid: TGridCoord;
begin
  // This handling should be in the mouse down handler, but it doesn't get
  // invoked if you click on a valid row!  Even better would be to use a
  // grid which gives you X,Y coordinates in the double click handler.
  grid := IngredientsGrid.MouseCoord( X, Y );
  fEditOnDblClick := (grid.Y >= 1);
end;

procedure TPortionIngredientsFrame.IngredientsGridUpdateFooter(Sender: TObject);
var TotalCost: currency;
begin
  if UpdatingGridFooter then
    Exit;

  UpdatingGridFooter := True;

  IngredientsGrid.ColumnByName('UnitDisplayName').FooterValue := 'Budgeted Cost';

  TotalCost := 0;
  with IngredientsGrid.DataSource.DataSet do
  begin
    First;
    while not(eof) do
    begin
      TotalCost := TotalCost + FieldByName('Cost').Value;
      Next;
    end;
  end;

  IngredientsGrid.ColumnByName('Cost').FooterValue := FloatToStrF(TotalCost, ffCurrency, 10, 4);

  UpdatingGridFooter := False;
end;

end.
