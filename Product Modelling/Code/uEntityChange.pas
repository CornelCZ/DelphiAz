unit uEntityChange;

(*
 * Unit performs all the validation and manipulation in order
 * to change an entity from one type to another.
 *
 * PRIZM functionality:
 *   ENT1LB.SC
 *     entedit_entity_wait     - entity type field form handling
 *     canChangeVarToOrderMenu
 *     and so on...
 *
 * Author: Stuart Boutell, IceCube/Edesix
 *)

interface

uses
  SysUtils, Classes,  Dialogs, DB, uDatabaseADO, DBTables, ADODB, Controls, uADOBarcodeRanges;

type
  TEntityChange = class(TDataModule)
  private
    procedure blankOffCertainValues(newEntType: EntType);
    procedure rejectChange(curET, newET: EntType);
    function entityTypeHasIngredients(const entityType: EntType): boolean;
  public
    function entityTypeChange(curEntType: EntType; var newEntType: EntType): boolean;
  end;

var
  EntityChange: TEntityChange;

{$R *.dfm}
implementation

uses uLineEdit, uProgress, uLog, StrUtils;

// *****************************************************************************
// PRIVATE PROCEDURES
// *****************************************************************************


// -----------------------------------------------------------------------------
// blankOffCertainValues
//   (re)set certain fields by entity type
//   PRIZM: ENT1LB.SC blank_off_certain_values
procedure TEntityChange.blankOffCertainValues(newEntType:EntType);
begin
  case newEntType of
    etInstruct: begin
      productsDB.ClientEntityTablePurchaseName.value := '';
      productsDB.ClientEntityTablePurchaseUnit.value := '';
      productsDB.ClientEntityTableDefaultSupplier.value := '';
      productsDB.ClientEntityTableBudgetedCostPrice.Clear;
      productsDB.ClientEntityTableRollupPriceWhenChild.Value := false;
    end;
    etChoice: begin
      productsDB.ClientEntityTablePurchaseName.value := '';
      productsDB.ClientEntityTablePurchaseUnit.value := '';
      productsDB.ClientEntityTableDefaultSupplier.value := '';
      productsDB.ClientEntityTableDefaultPrinterStream.value := '';
      productsDB.ClientEntityTableRollupPriceWhenChild.Value := false;
      productsDB.ClientEntityTableFollowCourseWhenChild.Value := false;
      productsDB.ClientEntityTablePrintStreamWhenChild.Clear;
      productsDB.ClientEntityTableCourseID.Clear;
    end;
    etRecipe: begin
      productsDB.ClientEntityTablePurchaseName.value := '';
      productsDB.ClientEntityTablePurchaseUnit.value := '';
      productsDB.ClientEntityTableDefaultSupplier.value := '';
    end;
    etPrepItem: begin
      productsDB.ClientEntityTablePurchaseName.value := '';
      productsDB.ClientEntityTablePurchaseUnit.value := '';
      productsDB.ClientEntityTableDefaultSupplier.value := '';
      productsDB.ClientEntityTableRollupPriceWhenChild.Value := false;
      productsDB.ClientEntityTableFollowCourseWhenChild.Value := false;
      productsDB.ClientEntityTablePrintStreamWhenChild.Clear;
      productsDB.ClientEntityTableCourseID.Clear;
    end;
    etPurchLine: begin
      productsDB.ClientEntityTableDefaultPrinterStream.value := '';
      productsDB.ClientEntityTableRollupPriceWhenChild.Value := false;
      productsDB.ClientEntityTableFollowCourseWhenChild.Value := false;
      productsDB.ClientEntityTablePrintStreamWhenChild.Clear;
      productsDB.ClientEntityTableCourseID.Clear;
    end;
    etMultiPurch: begin
      productsDB.ClientEntityTablePurchaseUnit.value := '';
      productsDB.ClientEntityTableDefaultSupplier.value := '';
      productsDB.ClientEntityTableBudgetedCostPrice.Clear;
      productsDB.ClientEntityTableDefaultPrinterStream.value := '';
      productsDB.ClientEntityTableRollupPriceWhenChild.Value := false;
      productsDB.ClientEntityTableFollowCourseWhenChild.Value := false;
      productsDB.ClientEntityTablePrintStreamWhenChild.Clear;
      productsDB.ClientEntityTableCourseID.Clear;
    end;
  end;

  // Although Prizm doesn't do this, it's pretty clear that it should...
  if newEntType <> etRecipe then
    productsDB.ClientEntitytableSpecialRecipe.Clear;
end;

function TEntityChange.entityTypeHasIngredients(const entityType: EntType): boolean;
begin
  Result := entityType in [etStrdLine, etRecipe, etChoice, etPrepItem]
end;

// -----------------------------------------------------------------------------
// etcRejectChange
//   give a hearty 'no'
procedure TEntityChange.rejectChange( curET,newET:EntType);
begin
  messageDlg('Cannot change a '+ EntTypeEnumToDisplayString(curET) +
             ' into a '+EntTypeEnumToDisplayString(newET), mtInformation, [mbOk], 0);
end;

// *****************************************************************************
// PUBLIC INTERFACES
// *****************************************************************************

// -----------------------------------------------------------------------------
// entityTypeChange
//   change the existing ClientEntityTable row to the new entity type, where
//   allowed, and perform the required manipulations.
//   returns true if succeeded
//   PRIZM: ENT1LB.SC entedit_entity_wait (entity type field handler)
function TEntityChange.entityTypeChange(curEntType:EntType; var newEntType:EntType):boolean;
var
  typeChangeOk: Boolean;
  SoldbyWeight: Boolean;

procedure DeleteProductBarcodeRanges;
begin
  with dmBarcodeRanges.qDeleteProductBarcodeRanges do
  try
    Parameters.ParamByName('entityCode').Value := ProductsDB.EntityTableEntityCode.Value;
    ExecSQL;
  except
    on E: Exception do
    begin
      Log.Event('Error :' + e.Message);
      Log.Event('Executing SQL to delete ProductBarcodeRanges');
      raise;
    end
  end;
end;

// if the item is being changed from std. line to purch. line then
// the button will be deleted if it exists on any theme design panels.
procedure DeleteProductThemeButton;
begin
  with ProductsDB.ADOQuery do
  try
    Close;
    SQL.Clear;
    SQL.Text := 'EXEC theme_RemoveProduct '+ ProductsDB.EntityTableEntityCode.AsString;
    ExecSQL
  except on e: exception do
    begin
      Log.Event('Error :' + e.message);
      Log.Event('Executing SQL: '+SQL.Text) ;
      raise;
    end;
  end;
end;

procedure DeleteBarcodes;
begin
  with ProductsDB.ADOCommand do
  try
    CommandText := 'DELETE ProductBarCode WHERE Entitycode = ' + ProductsDB.EntityTableEntityCode.AsString;
    Execute;
  except on e: exception do
    begin
      Log.Event('Error :' + e.message);
      Log.Event('Executing SQL: ' + CommandText) ;
      raise;
    end;
  end;
end;

begin
  if curEntType = newEntType then
  begin
    Result := False;
    Exit;
  end;

  typeChangeOk := false;

  productsDB.ClientEntityTable.DisableControls;

  try
    try
(*  The following manipulations are allowed:
                                        CURRENT ENTITY TYPE
              Instruc Prep.It Purch.L Std.Lin Recipe MultPurc <INS>
      Choice    Nx      N       N       N       N       N      Y
NEW   Instruc	-       N       N       N       N       N      Y
ENT   Prep.It	N       -       Y       Y       Y       N      Y
TYPE  Purch.L	N       Y       -       Y       Y       N      Y
      Std.Lin	N       Y       Y       -       Y       N      Y
      Recipe	N       Y       Y       Y       -       N      Y
      MultPurc  N       N       N       N       N       -      Y


      KEY COMMENTARY
      --- ----------
       Y  change allowed
       N  no change allowed
*)


      if productsDB.ProductNewlyInsertedAndNotSaved then
      begin
        // always ok
        typeChangeOk := true;
      end
      else
      begin
        SoldbyWeight := ProductsDB.ClientEntityTableSoldByWeight.Value;

        // test the current type for validitity to change
        case curEntType of
          etChoice, etInstruct, etMultiPurch:
            rejectChange(curEntType, newEntType);

          etPrepItem, etPurchLine:
            if newEntType in [etChoice, etInstruct, etMultiPurch] then
              rejectChange(curEntType, newEntType)
            else
              typeChangeOk := true;

          etStrdLine, etRecipe:
            if newEntType in [etChoice,etInstruct,etMultiPurch] then
            begin
              rejectChange(curEntType, newEntType);
            end
            else if SoldbyWeight then
            begin
              messageDlg('Cannot change a '+ EntTypeEnumToFriendlyDisplayString(curEntType) +
                         ' into a ' + EntTypeEnumToFriendlyDisplayString(newEntType)+' if the product is sold by weight',
                          mtInformation, [mbOk], 0);
            end
            else if (newEntType = etPrepItem) and ProductsDb.ProductHasChoices then
            begin
              messageDlg('This product contains a choice and so cannot be converted to a prepared item',
                          mtInformation, [mbOk], 0);
            end
            else if (newEntType = etPrepItem) and ProductsDb.ProductHasNegativeIngredientQuantities then
            begin
              messageDlg('This product contains ingredients with negative quantities and so cannot be converted to a prepared item',
                          mtInformation, [mbOk], 0);
            end
            else if (newEntType = etPrepItem) and ProductsDb.ProductHasPortionedIngredients then
            begin
              messageDlg('This product contains ingredients which are measured in portions and so cannot be converted to a prepared item',
                           mtInformation, [mbOk], 0);
            end
            else if (newEntType = etPrepItem) and ProductsDb.ProductIsUsedAsIngredient then
            begin
              MessageDlg('This product is an ingredient in another product and so cannot be converted to a prepared item.'#13#10 +
                         'The ingredient amount will not be compatible with a prepared item.',
                           mtInformation, [mbOk], 0)
            end
            else if (newEntType in [etPurchLine,etPrepItem]) then
            begin
              if MessageDlg(
                'If this product is changed to a ' + EntTypeEnumToDisplayString(newEntType) + ' :' + #13#10 +
                '  - All this product''s buttons will be removed from theme panels.' + #13#10 +
                '  - All barcodes and barcode ranges applied to this product will be removed.' + #13#10 +
                ifthen(newEntType = etPrepItem,
                  '  - All portions except the Standard portion will be removed.' + #13#10, '') +
                ifthen(productsdb.ProductInATicketSequence,
                  '  - It will be removed from all ticket sequences it currently belongs to.' + #13#10, '') +
                #13#10 + 'Continue?',
                mtWarning, [mbOk, mbCancel], 0) = mrOk then
              begin
                typeChangeOk := true;
                DeleteProductThemeButton;  //Will remove the button from any theme design panel.
                DeleteProductBarcodeRanges; //Will delete all barcode ranges linked to the product
                DeleteBarcodes;
                //TODO: To be consistent we should move all of the above "delete" procedures to productsDB
                productsDb.RemoveProductFromAllTicketSequences;
              end
            end
            else begin
              typeChangeOk := true;
            end;

          else
            raise Exception.Create('Unknown product type EntTypeEnumToDisplayString(curEntType)');
        end;
      end;

      if typeChangeOk then begin
        // prepare for change
        if entityTypeHasIngredients(curEntType) then
        begin
          if not entityTypeHasIngredients(newEntType) then
          begin
            ProductsDB.DeleteAllPortions();
          end
          else
          begin
            // We are about to directly modify the database tables which hold ingredient data. Make sure any
            // pending ingredient changes are applied first.
            ProductsDB.SavePendingPortionChangesIfPossible;

            if (NewEntType = etPrepItem) then
              ProductsDB.DeleteAllButCurrentStandardPortion();

            if (curEntType = etStrdLine) then
              ProductsDB.RemoveSelfIngredient();

            if (newEntType = etStrdLine) then
              ProductsDB.AddSelfIngredient();
          end;
        end;

        ProductsDB.ResetPortionAttributes(curEntType, NewEntType);
        blankOffCertainValues(newEntType);
        productsDB.ClientEntityTableDefaultFill(newEntType); // Ensure there are no blanks on the back page
      end;

    except on E:Exception do begin
      Log.Event('Could not change entity type: ' + E.Message);
      ShowMessage('Could not change entity type:'#13#10+E.Message);
      typeChangeOk := false;
    end;
  end;
  finally
    entityTypeChange := typeChangeOk;
    with productsDB do begin
      // reconnect GUI
      ClientEntityTable.EnableControls;
    end;
  end;
end;


end.

