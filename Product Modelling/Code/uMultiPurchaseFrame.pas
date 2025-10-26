unit uMultiPurchaseFrame;

(*
 * Unit contains the TTMultiPurchaseFrame class - this represents the ingredient
 * list in the for a multi purchase item (a group of items purchased as a group).
 *
 * Author: Hamish Martin, Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, StdCtrls, Grids, DBGrids, FlexiDBGrid, uDatabaseADO, Mask,
  DBCtrls;

type
  TTMultiPurchaseFrame = class(TFrame)
    DBGrid1: TFlexiDBGrid;
    Button3: TButton;
    Button5: TButton;
    Button4: TButton;
    ActionList1: TActionList;
    InsertIngredientAction: TAction;
    DeleteIngredientAction: TAction;
    AppendIngredientAction: TAction;
    InvoiceNameLabel: TLabel;
    InvoiceNameEdit: TDBEdit;
    procedure InsertIngredientActionUpdate(Sender: TObject);
    procedure DeleteIngredientActionUpdate(Sender: TObject);
    procedure InsertIngredientActionExecute(Sender: TObject);
    procedure AppendIngredientActionExecute(Sender: TObject);
    procedure DeleteIngredientActionExecute(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1StepPastEnd(Sender: TComponent;
      reason: TFlexiStepPastEndReasonOption);
    procedure FrameExit(Sender: TObject);
    procedure DBGrid1ToggleBooleanField(Sender: TObject);
  private
    // The Child Code currently selected in the MultiPurchaseIngredientTable.
    childcode: Double;

    // Create a new ingredient at the specified position in the ingredient list.
    procedure CreateIngredient(ingredientDisplayOrder: Integer);
    // Renumber all the ingredients from 1..n.  If makeSpaceForDisplayOrder isn't
    // -1, then a gap is left in the numbering at the specified number.
    procedure RenumberIngredientDisplayOrders(
      makeSpaceForDisplayOrder: Integer);

    // Get the default supplier for an entity; on failure return ''.
    function getDefaultSupplier( ecode : double ) : string;
    // Get the default purchase unit for an entity (from punits); on failure return ''.
    function getDefaultPurchaseUnit( ecode: double ): string;
    // Get the first available purchase unit for an entity (from punits); on fail return ''.
    function getFirstPurchaseUnit( ecode: double ): string;
    // Get a list of units types configured for an entity in punits.  If none are configured,
    // return nil.  The caller is responsible for freeing the returned list.
    function getUnitTypesForIngredient( ecode: double ) : TStringList;
    // Get the default purchase unit and flavour for an (entity, supplier) by consulting
    // punits.  If no entry exists for the entity, supplier, punit and flavour are set to ''.
    procedure getDefaultPurchaseUnitAndFlavour(ecode: double;
      supplier: string; var punit, flavour: string);

    // Get the 'primary' ingredient for the currently selected multi purch (defined to be
    // the first non-returnable item in the list).  On failure return -1.0
    function getPrimaryIngredient(var retname: string): double;
  public
    // Setup boolean column of TFlexiDBGrid
    procedure setupDbGrid;
    // Called after moving to a new entity; reposition focus and dataset position.
    procedure InitialiseForCurrentProduct;
    // Validate ingredient entry in the list.
    procedure beforeMultiPurchIngredientPost;
    // Setup the correct units in the drop-down list for the ingredient.
    procedure afterMultiPurchIngredientScroll;
    // Validate this entity before moving to another entity
    procedure beforeEntityPost;
    procedure InitialiseFromAnotherProduct(baseEntityCode: Double);
  end;

implementation

uses uSelectEntity, DB, uGuiUtils, Variants, uADO, ADODB, uGlobals;

{$R *.dfm}

procedure TTMultiPurchaseFrame.InsertIngredientActionUpdate(
  Sender: TObject);
begin
  // Only allow insert if the recipe is not full.
  with Sender as TAction do
    Enabled := productsDB.MultiPurchIngredientTable.RecordCount < 7;
end;

procedure TTMultiPurchaseFrame.DeleteIngredientActionUpdate(
  Sender: TObject);
begin
  // Only allow delete when there is something in the table.
  DeleteIngredientAction.Enabled :=
    (productsDB.MultiPurchIngredientTable.State = dsInsert) or
    not (productsDB.MultiPurchIngredientTable.Bof and productsDB.MultiPurchIngredientTable.Eof);
end;

procedure TTMultiPurchaseFrame.CreateIngredient( ingredientDisplayOrder: Integer );
var
  validIngredient: boolean;
  unitName : string;
begin
  if (productsDB.MultiPurchIngredientTable.State = dsInsert) or (productsDB.MultiPurchIngredientTable.State = dsEdit) then
    productsDB.MultiPurchIngredientTable.Post;

  productsDB.MultiPurchIngredientTable.DisableControls;

  try
    // Filter entity chooser to only allow valid entity types.
    SelectEntityForm.setFilter( [etStrdLine,etPurchLine],
                                productsDB.ClientEntityTableEntityCode.Value );
    SelectEntityForm.setCaptionAndHelpId(
      'Add Multi Purchase Ingredient',
      'Select the item to add:',
      AZPM_ADD_MULTI_PURCH_ITEM_FORM );

    validIngredient := SelectEntityForm.ShowModal = mrOk;

    if validIngredient then
    begin
      if productsDB.MultiPurchIngredientTable.Locate(
        'EntityCode;IngredientCode',
        VarArrayOf([productsDB.ClientEntityTableEntityCode.Value,
                    SelectEntityForm.getSelectedEntityCode]),[]) then
      begin
        ShowMessage( 'The ingredient has already been added to this Multi Purchase.' );
        validIngredient := false;
      end;
    end;

    if validIngredient then
    begin
      unitName := getDefaultPurchaseUnit( SelectEntityForm.getSelectedEntityCode );
      if unitName = '' then
        unitName := getFirstPurchaseUnit( SelectEntityForm.getSelectedEntityCode );

      if unitName = '' then begin
        ShowMessage( 'No suppliers have been configured for this ingredient.'#10#13+
                     'Supplier information must be setup before you can add an ingredient'#10#13+
                     'to a Multi Purchase.' );
        validIngredient := false;
      end;
    end;

    if validIngredient then
    begin
      // OK, add this item to the portion
      if ingredientDisplayOrder = -1 then
      begin
        // we want to insert this at the end of the list...
        productsDB.MultiPurchIngredientTable.Last;
        if productsDB.MultiPurchIngredientTable.Bof then
          ingredientDisplayOrder := 1
        else
          ingredientDisplayOrder := productsDB.MultiPurchIngredientTableDisplayOrder.AsInteger + 1;
      end
      else
      begin
        // we want to insert this at the specified display order
        RenumberIngredientDisplayOrders(ingredientDisplayOrder);
      end;

      // Now create record
      productsDB.MultiPurchIngredientTable.Insert;
      productsDB.MultiPurchIngredientTableIngredientCode.Value :=
        SelectEntityForm.getSelectedEntityCode;
      productsDB.MultiPurchIngredientTableDisplayOrder.Value :=
        ingredientDisplayOrder;
      productsDB.MultiPurchIngredientTableUnitName.AsString := unitName;

      // Post and notify event handler that ingredients have changed.
      try
        productsDB.MultiPurchIngredientTable.Post;
        PrizmSetFocus( DBGrid1 );
      except
        on E: Exception do begin
          ShowMessage( 'Cannot add ingredient:'#13#10 + E.Message );
          productsDB.MultiPurchIngredientTable.Cancel;
        end;
      else
        productsDB.MultiPurchIngredientTable.Cancel;
      end;
    end;

  finally
    productsDB.MultiPurchIngredientTable.EnableControls;
  end;
end;


procedure TTMultiPurchaseFrame.InsertIngredientActionExecute(
  Sender: TObject);
begin
  // If table is empty insert ingredient at end, otherwise insert at current position.
  if not (productsDB.MultiPurchIngredientTable.Bof and
          productsDB.MultiPurchIngredientTable.Eof) then
    CreateIngredient( productsDB.MultiPurchIngredientTableDisplayOrder.Value )
  else
    CreateIngredient( -1 );
end;

procedure TTMultiPurchaseFrame.AppendIngredientActionExecute(
  Sender: TObject);
begin
  // Insert ingredient at end
  CreateIngredient( -1 );
end;

procedure TTMultiPurchaseFrame.DeleteIngredientActionExecute(
  Sender: TObject);
begin
  if MessageDlg( 'Are you sure you want to delete ingredient ''' +
                 productsDB.MultiPurchIngredientTableIngredientName.Value + '''?', mtConfirmation,
                 [mbOk, mbCancel], 0 ) <> mrOk then
    Abort;

  // Delete the currently selected ingredient
  productsDB.MultiPurchIngredientTable.DisableControls;
  try
    if (productsDB.MultiPurchIngredientTable.State = dsInsert) then

      productsDB.MultiPurchIngredientTable.Cancel

    else begin

      if (productsDB.MultiPurchIngredientTable.State = dsEdit) then
        productsDB.MultiPurchIngredientTable.Cancel;

      if not (productsDB.MultiPurchIngredientTable.Bof and
              productsDB.MultiPurchIngredientTable.Eof) then begin

        productsDB.MultiPurchIngredientTable.Delete;
        // Renumber choice codes to remove gap caused by deleted item
        RenumberIngredientDisplayOrders( -1 );
      end;

    end;

  finally
    productsDB.MultiPurchIngredientTable.EnableControls;
  end;
end;

procedure TTMultiPurchaseFrame.RenumberIngredientDisplayOrders( makeSpaceForDisplayOrder: Integer );
var
  ingredientDisplayOrder : Integer;
begin
  ingredientDisplayOrder := 0;

  // Renumber entries in the table.  We must do this carefully to avoid a key violation.

  // First of all, we will iterate through all entries from first to last;  if the display order
  // of an entry is too high we will set it to the correct value.
  // Secondly, we will iterate through all entries from last to first;  if the display order
  // of an entry is too low we will set it to the correct value.

  // start at the beginning and decrease display orders...
  productsDB.MultiPurchIngredientTable.Open;
  productsDB.MultiPurchIngredientTable.First;
  while not productsDB.MultiPurchIngredientTable.EOF do begin
    Inc( ingredientDisplayOrder );
    if ingredientDisplayOrder = makeSpaceForDisplayOrder then
      Inc( ingredientDisplayOrder ); // Don't use this display order.

    // bring display order down to the correct value
    if productsDB.MultiPurchIngredientTableDisplayOrder.Value > ingredientDisplayOrder then
    begin
      productsDB.MultiPurchIngredientTable.Edit;
      productsDB.MultiPurchIngredientTableDisplayOrder.Value := ingredientDisplayOrder;
      productsDB.MultiPurchIngredientTable.Post;
    end;

    productsDB.MultiPurchIngredientTable.Next;
  end;

  // start at the end and increase display orders...
  Inc( ingredientDisplayOrder );
  productsDB.MultiPurchIngredientTable.Last;
  while not productsDB.MultiPurchIngredientTable.BOF do begin
    Dec( ingredientDisplayOrder );
    if ingredientDisplayOrder = makeSpaceForDisplayOrder then
      Dec( ingredientDisplayOrder );

    // bring display order up to the correct value
    if productsDB.MultiPurchIngredientTableDisplayOrder.Value < ingredientDisplayOrder then
    begin
      productsDB.MultiPurchIngredientTable.Edit;
      productsDB.MultiPurchIngredientTableDisplayOrder.Value := ingredientDisplayOrder;
      productsDB.MultiPurchIngredientTable.Post;
    end;

    productsDB.MultiPurchIngredientTable.Prior;
  end;
end;

procedure TTMultiPurchaseFrame.InitialiseForCurrentProduct;
begin
  // Scrolled to a new entity:  reposition ingredient table at the first entry
  DBGrid1.SelectedField := productsDB.MultiPurchIngredientTableUnitName;
  productsDB.MultiPurchIngredientTable.First;
end;

// Validate MultiPurchIngredient table record before posting
procedure TTMultiPurchaseFrame.beforeMultiPurchIngredientPost;
var
  strings : TStringList;
begin
  strings := getUnitTypesForIngredient(
    productsDB.MultiPurchIngredientTableIngredientCode.Value );

  if Assigned( strings ) then begin
    try
      // Find entity entry corresponding to this ingredient.
      if not FieldMatchesPickList( productsDB.MultiPurchIngredientTableUnitName,
                                   productsDB.validUnitsStringList, false ) then begin
        PrizmSetFocus( DBGrid1 );
        DBGrid1.SelectedField := productsDB.MultiPurchIngredientTableUnitName;
        ShowMessage( '''' + productsDB.MultiPurchIngredientTableUnitName.Value +
                     ''' is not a valid unit name.' );
        Abort;
      end;

      // Check units are compatible with the ingredient's definition
      if not FieldMatchesPickList( productsDB.MultiPurchIngredientTableUnitName,
                                   strings, false ) then begin
        PrizmSetFocus( DBGrid1 );
        DBGrid1.SelectedField := productsDB.MultiPurchIngredientTableUnitName;
        ShowMessage( 'No suppliers have been configured for ingredient '''+
                     productsDB.MultiPurchIngredientTableIngredientName.Value + ''' and unit '''+
                     productsDB.MultiPurchIngredientTableUnitName.Value +'''.  If you wish '+
                     'to use this unit, you must add a suitable supplier entry in '+
                     'the supplier page for '''+
                     productsDB.MultiPurchIngredientTableIngredientName.Value+'''.' );
        Abort;
      end;

    finally
      strings.Free;
    end;
  end else begin
    // this should never happen
    ShowMessage('There are no supplier entries for '''+
                productsDB.MultiPurchIngredientTableIngredientName.Value+
                '''.  In order for purchasing to work correctly, you should add a supplier entry for '+
                'this ingredient, and then return here and select a suitable unit for this ingredient.');
  end;
end;

procedure TTMultiPurchaseFrame.afterMultiPurchIngredientScroll;
var
  strings : TStrings;
begin
  if not (productsDB.MultiPurchIngredientTable.EOF and
          productsDB.MultiPurchIngredientTable.BOF) then begin
    if childcode <> productsDB.MultiPurchIngredientTableIngredientCode.Value then begin

      // We have scrolled to a new MultiPurchIngredient entry - update the picks
      // lists and read-only-ness of the columns in the grid.
      childcode := productsDB.MultiPurchIngredientTableIngredientCode.Value;

      strings := getUnitTypesForIngredient( childcode );
      if Assigned( strings ) then begin
        DBGrid1.Columns[2].PickList := strings;
        strings.Free;
      end else
        DBGrid1.Columns[2].PickList := ProductsDB.nullStringList;
    end;
  end;
end;

// Use has pressed insert in the DBGrid
procedure TTMultiPurchaseFrame.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // Insert a new ingredient if the user presses insert.
  if Key = VK_INSERT then
    InsertIngredientAction.Execute
end;

// If user clicks or moves past the end of the recipe, append an ingredient.
procedure TTMultiPurchaseFrame.DBGrid1StepPastEnd(Sender: TComponent;
  reason: TFlexiStepPastEndReasonOption);
begin
  AppendIngredientAction.Execute;
end;

// Make sure errors with the current ingredient are trapped before the user leaves the
// ingredients frame.
procedure TTMultiPurchaseFrame.FrameExit(Sender: TObject);
begin
  with productsDB.MultiPurchIngredientTable do
    if (state = dsInsert) or (state = dsEdit) then
      Post;
end;

procedure TTMultiPurchaseFrame.DBGrid1ToggleBooleanField(Sender: TObject);
begin
  if not (ProductsDB.MultiPurchIngredientTable.EOF and
          ProductsDB.MultiPurchIngredientTable.BOF) then
  begin
    ProductsDB.MultiPurchIngredientTable.Edit;
    ProductsDB.MultiPurchIngredientTableReturnable.Value :=
      not ProductsDB.MultiPurchIngredientTableReturnable.Value;
  end;
end;

function TTMultiPurchaseFrame.getFirstPurchaseUnit( ecode: double ) : string;
var
  strings : TStringList;
begin
  Result := '';
  strings := getUnitTypesForIngredient( ecode );
  if Assigned( strings ) then
    Result := strings[0];
  strings.Free;
end;

function TTMultiPurchaseFrame.getDefaultSupplier( ecode : double ) : string;
begin
  Result := '';
  if ProductsDB.EntityTableLookup( ecode ) then
    Result := ProductsDB.EntityTableDefaultSupplier.Value;
end;

function TTMultiPurchaseFrame.getDefaultPurchaseUnit( ecode: double ) : string;
var
  supplier : string;
  pu, flav : string;
begin
  Result := '';
  supplier := getDefaultSupplier( ecode );
  if supplier <> '' then begin
    getDefaultPurchaseUnitAndFlavour( ecode, supplier, pu, flav );
    Result := pu;
  end;
end;

procedure TTMultiPurchaseFrame.getDefaultPurchaseUnitAndFlavour(
  ecode: double; supplier : string; var punit, flavour: string );
begin
  punit := '';
  flavour := '';

  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT [Unit Name], [Flavour]');
    SQL.Add('FROM PurchaseUnits');
    SQL.Add('WHERE [Entity Code] = ' + FloatToStr( ecode ));
    SQL.Add('AND [Supplier Name] = ' + QuotedStr(supplier));
    SQL.Add('AND [Default Flag] = ''*''');

    Open;
    try
      // Look for one with default flag set
      if not EOF then
      begin
        punit := FieldByName('Unit Name').AsString;
        flavour := FieldByName('Flavour').AsString;
        Exit;
      end;
    finally
      Close;
    end;
  end;
end;

function TTMultiPurchaseFrame.getUnitTypesForIngredient( ecode: double ) : TStringList;
var
  strings : TStringList;
  unitname : string;
begin
  strings := nil;

  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT [Unit Name]');
    SQL.Add('FROM PurchaseUnits');
    SQL.Add('WHERE [Entity Code] = ' + FloatToStr( ecode ));

    Open;
    try
      // Look for one with default flag set
      if not EOF then
      begin
        strings := TStringList.Create;
        strings.CaseSensitive := true;
        while not EOF do begin
          unitname := FieldByName('Unit Name').AsString;
          if strings.IndexOf( unitname ) = -1 then
            strings.Add( unitname );
          Next;
        end;
        strings.CaseSensitive := false;
        strings.Sort;
      end;
    finally
      Close;
    end;
  end;
  Result := strings;
end;

function TTMultiPurchaseFrame.getPrimaryIngredient( var retname : string )  : double;
var
  resultDisplayOrder : Integer;
begin
  Result := -1.0;
  retname := '';

  resultDisplayOrder := 10000;

  // Search the ingredient list for the default one
  with ProductsDB, MultiPurchIngredientTable do begin
    DisableControls;
    try

      // Find the non-returnable ingredient with the lowest display order.
      First;
      while not EOF do begin
        if (not MultiPurchIngredientTableReturnable.Value) and
           (MultiPurchIngredientTableDisplayOrder.Value < resultDisplayOrder) then begin
          resultDisplayOrder := MultiPurchIngredientTableDisplayOrder.Value;
          retname := MultiPurchIngredientTableIngredientName.Value;
          Result := MultiPurchIngredientTableIngredientCode.Value;
        end;
        Next;
      end;

      // No non-returnable ingredients - just find the ingredient with the lowest display order
      if resultDisplayOrder = 10000 then begin
        First;
        while not EOF do begin
          if (MultiPurchIngredientTableDisplayOrder.Value < resultDisplayOrder) then begin
            resultDisplayOrder := MultiPurchIngredientTableDisplayOrder.Value;
            retname := MultiPurchIngredientTableIngredientName.Value;
            Result := MultiPurchIngredientTableIngredientCode.Value;
          end;
          Next;
        end;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TTMultiPurchaseFrame.beforeEntityPost;
var
  primaryIngredient : double;
  primaryIngredientName : string;
  defsupplier, defunit, defflavour : string;
//  punitsClone : TADODataSet;
  ingredientWithNoDefSupplierEntry, returnableIngredientWithNoDefSupplierEntry : string;
  completeMessage: string;

  // Check the punits table to see if there is an entry for the given entity & unit name,
  // and the default supplier and flavour.
  function punitsContainsEntry( ecode: double; unitname : string; returnable: boolean ) : boolean;
  begin
    Result := false;
    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT [Flavour], [Flavour]');
      SQL.Add('FROM PurchaseUnits');
      SQL.Add('WHERE [Entity Code] = ' + FloatToStr( ecode ));
      SQL.Add('AND [Supplier Name] = ' + QuotedStr(defsupplier));
      SQL.Add('AND [Unit Name] = ' + QuotedStr(unitname));

      Open;
      try
        while not EOF do
        begin
          if (FieldByName('Flavour').AsString = defflavour) or
             ( returnable and
              ((FieldByName('Flavour').AsString = '') or (VarIsNull(FieldByName('Flavour').Value))) ) then
          begin
            Result := true;
            Break;
          end;
          Next;
        end;
      finally
        Close;
      end;
    end;
    {Result := false;
    // Look for a punits entry for this ingredient
    with punitsClone do begin
      // Can't filter by flavour because if flavour is '' or null, we want to match both
      // nulls and '' in punits and the stupid ADO filter property is too pathetic to
      // do this.  We filter by all the other fields and then manually search
      // for the flavour we want.
      Filter :=
        '[Entity Code] = ' + FloatToStr( ecode ) +
        ' and '+
        '[Supplier Name] = ' + QuotedStr( defsupplier ) +
        ' and '+
        '[Unit Name] = ' + QuotedStr( unitname );
      Filtered := true;
      First;
      while not EOF do begin
        if (FieldByName('Flavour').AsString = defflavour) or
           ( returnable and
            ((FieldByName('Flavour').AsString = '') or (VarIsNull(FieldByName('Flavour').Value))) ) then begin
          Result := true;
          Break;
        end;
        Next;
      end;
    end;}
  end;

begin
  // Validation is as follows:  get the default supplier and flavour for the
  // primary ingredient (i.e. the first one in the list with Returnable = false)
  // Then, check that all the ingredients have an entry for that supplier and flavour.
  // If they don't give a warning.
  primaryIngredient := getPrimaryIngredient( primaryIngredientName );

  // If there are no ingredients then there is no checking to do.
  if primaryIngredient <> - 1 then begin

    defsupplier := getDefaultSupplier( primaryIngredient );
    if defsupplier = '' then begin
      ShowMessage( 'No default supplier is set for ingredient '''+primaryIngredientName+
                   '''.  Please set a default supplier to this ingredient, and ensure '+
                   'that suitable supplier entries are setup for all other ingredients' );
      Exit;
    end;

    getDefaultPurchaseUnitAndFlavour( primaryIngredient, defsupplier, defunit, defflavour );
    if defunit = '' then begin
      ShowMessage( 'No default flavour is set for ingredient '''+primaryIngredientName+
                   ''' and supplier '''+defsupplier+'''.  Please add a default purchase unit'+
                   'to this ingredient for the supplier, and ensure '+
                   'that suitable supplier entries are setup for all other non-returnable ingredients' );
      Exit;
    end;

    // Build a list of non-returnable ingredients that do not have an entry for the
    // default supplier, flavour in punits and build a list of returnable ingredients
    // that do not have an entry for the default supplier and either the flavour or a
    // null flavour.
    ingredientWithNoDefSupplierEntry := '';
    returnableIngredientWithNoDefSupplierEntry := '';
    completeMessage := '';

    with ProductsDB, MultiPurchIngredientTable do begin
      DisableControls;
      try
        First;
        while not EOF do begin

          if not punitsContainsEntry(
              MultiPurchIngredientTableIngredientCode.Value,
              MultiPurchIngredientTableUnitName.Value,
              MultiPurchIngredientTableReturnable.Value ) then
          begin
            // Add this ingredient to the list.
            if MultiPurchIngredientTableReturnable.Value then
            begin
              if Length( ingredientWithNoDefSupplierEntry ) > 0 then
                returnableIngredientWithNoDefSupplierEntry := returnableIngredientWithNoDefSupplierEntry + ', ';

              returnableIngredientWithNoDefSupplierEntry := returnableIngredientWithNoDefSupplierEntry +
                   MultiPurchIngredientTableIngredientName.Value;
            end
            else
            begin
              if Length( ingredientWithNoDefSupplierEntry ) > 0 then
                ingredientWithNoDefSupplierEntry := ingredientWithNoDefSupplierEntry + ', ';

              ingredientWithNoDefSupplierEntry := ingredientWithNoDefSupplierEntry +
                   MultiPurchIngredientTableIngredientName.Value;
            end
          end;

          Next;
        end;
      finally
        EnableControls;
      end;
    end;

    if (ingredientWithNoDefSupplierEntry <> '') or (returnableIngredientWithNoDefSupplierEntry <> '') then
    begin
      if ingredientWithNoDefSupplierEntry <> '' then
        completeMessage := 'The following non-returnable ingredients do not have supplier entries set up for '+
                           'the default supplier ''' + defsupplier +
                           ''' (flavour '''+defflavour+'''): '#10#13+
                           ingredientWithNoDefSupplierEntry +#10#13#10#13;

      if returnableIngredientWithNoDefSupplierEntry <> '' then
        completeMessage := completeMessage +
                           'The following returnable ingredients do not have supplier entries set up for '+
                           'the default supplier ''' + defsupplier +
                           ''' (flavour '''+defflavour+''' or a null flavour): '#10#13+
                           returnableIngredientWithNoDefSupplierEntry +#10#13#10#13;

      completeMessage := completeMessage +
                         'You should set up suitable supplier entries for these ingredients.';
      ShowMessage(completeMessage);
    end;
  end;
end;

procedure TTMultiPurchaseFrame.setupDbGrid;
begin
  DBGrid1.SetBooleanField( ProductsDB.MultiPurchIngredientTableReturnable, true );
end;

procedure TTMultiPurchaseFrame.InitialiseFromAnotherProduct(baseEntityCode: Double);
var ADODataset: TADODataset;
begin
  with ProductsDb do
  begin
    ADODataset := TADODataset.Create(nil);
    try
      ADODataset.Connection := dmADO.AztecConn;
      ADODataset.CommandType := cmdText;

      ADODataset.CommandText := Format(
        'SELECT * FROM MultiPurchIngredients WHERE EntityCode = %0:f ORDER BY DisplayOrder',
        [baseEntityCode]);

      ADODataset.Open;
      while not(ADODataset.EOF) do
      begin
        MultiPurchIngredientTable.Append;
        MultiPurchIngredientTableIngredientCode.AsVariant := ADODataset.FieldByName('IngredientCode').Value;
        MultiPurchIngredientTableUnitName.AsVariant       := ADODataset.FieldByName('UnitName').Value;
        MultiPurchIngredientTableReturnable.AsVariant := ADODataset.FieldByName('Returnable').Value;
        MultiPurchIngredientTableDisplayOrder.AsVariant   := ADODataset.FieldByName('DisplayOrder').Value;
        ADODataset.Next;
      end;
    finally
      ADODataset.Free;
    end;
  end;
end;


end.
