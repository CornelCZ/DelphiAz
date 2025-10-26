unit uEntityDelete;

(*
 * Unit perform all the manipulations to validate and perform
 * a delete an entity.
 *
 * Author: Stuart Boutell, Ice Cube/Edesix
 *)

interface

uses
  SysUtils, Classes, Dialogs, Controls, DB, DBTables, ADODB, Clipbrd, uGlobals;

type
  TLinkTableDeleteMode = (delWhereParent, delWhereChild, delWhereParentOrChild);

  TEntityDelete = class(TDataModule)

    EntityIngredientOrMenuItemQuery: TADOQuery;

    ADOCommand: TADOCommand;
  private
    { Private declarations }
    procedure DeleteRecipeNotes(entityCode: double);
    procedure DeleteProductFromPunits(entityCode: double);
    procedure DeleteBarCodes(entityCode: double);
    procedure DeleteProductFromPortionIngredients(EntityCode : double);
    procedure EnableGUI;
    procedure DisableGUI;
    procedure CancelAllDetailEditsInProgress;
  public
    { Public declarations }
    procedure entityDelete;
    procedure LinkedProducts;
  end;

var
  EntityDelete: TEntityDelete;

implementation

uses uDatabaseADO, uLineEdit, uProgress, uEntityDeleteDialog, variants,
  uADO, uLog, uLocalisedText;

{$R *.dfm}

{ TEntityDelete }

// Added by AK for PM334
procedure TEntityDelete.LinkedProducts;
const
  progressTitle:string = 'Linked Items';
var
  entityCode : double;
  entityExtendedRetailName,
  entityProductDescription:string;
  promptEntityNameStart, promptEntityNameEnd : String;
  temp:string;
  loop:integer;

begin
    if productsDB.ClientEntityTableEntityCode.IsNull then
      Exit;

    entityCode := productsDB.ClientEntityTableEntityCode.Value;
    entityExtendedRetailName := productsDB.ClientEntityTableExtendedRTLName.Value;
    entityProductDescription := ProductsDB.ClientEntityTableRetailDescription.Value;

    // make null-name items look reasonable;
    if productsDB.ClientEntityTableExtendedRtlName.Value <> '' then begin
      promptEntityNameStart := QuotedStr(productsDB.ClientEntityTableExtendedRtlName.Value);
      promptEntityNameEnd   := QuotedStr(productsDB.ClientEntityTableExtendedRtlName.Value);
    end else begin
      promptEntityNameStart := 'This item';
      promptEntityNameEnd := 'this item';
    end;

    // Check 1 - see if this is a child of anyone/thing
    with EntityIngredientOrMenuItemQuery do
    try
      Parameters.ParamByName('ecode').Value := entityCode;
      Active := true;
      if FindFirst then
      begin
        if EntityDeleteDialog.entityLinkedProducts('Copy ' + promptEntityNameStart +
                                                   ' details to Clipboard?',
           TDataSet(EntityIngredientOrMenuItemQuery) ) then
        begin
          Clipboard.Open;
          Clipboard.Clear;
          //Header as per CR
          temp := CurrentUser.UserName + #13#10;
          temp := temp + DateTimeToStr(now) + #13#10;
          temp := temp + FloatToStr(entityCode) + #13#10;
          temp := temp + entityExtendedRetailName + #13#10;
          temp := temp + entityProductDescription + #13#10;
          //Body as per CR
          First;
          while not Eof do
          begin
            for loop := 0 to pred(FieldCount) do
            begin
               temp := temp + Fields[loop].AsString + #9 ;
            end;
            temp := temp + #13#10;
            Next;
          end;
          Clipboard.SetTextBuf(PChar(temp));
          Clipboard.Close;
        end;
      end
      else
      begin
        ShowMessage(entityExtendedRetailName + ' is not used by any other product')
      end;
    finally
      EntityIngredientOrMenuItemQuery.Close;
    end;
end;

procedure TEntityDelete.entityDelete;
const
  progressTitle:string = 'Deleting Item';
  ChangedByOtherUserText:string = 'Row cannot be located for updating';
var
  entityCode : double;
  entityType : EntType;
  promptEntityNameStart, promptEntityNameEnd : String;
  doDelete, warningGiven : boolean;

  // states held during delete
  entbeforescroll, entbeforepost: TDataSetNotifyEvent;

begin
  doDelete := true;

  progressForm.progressStart(7, LineEditForm, false);
  progressForm.progress(progressTitle,'Finding dependent items');
  try try

    entityCode := productsDB.ClientEntityTableEntityCode.Value;
    entityType := EntTypeStringToEnum( productsDB.ClientEntityTableEntityType.Value );

    // make null-name items look reasonable;
    if productsDB.ClientEntityTableExtendedRTLName.Value <> '' then begin
      promptEntityNameStart := QuotedStr(productsDB.ClientEntityTableExtendedRTLName.Value);
      promptEntityNameEnd   := QuotedStr(productsDB.ClientEntityTableExtendedRTLName.Value);
    end else begin
      promptEntityNameStart := 'This item';
      promptEntityNameEnd := 'this item';
    end;

    warningGiven := false;

    // Check 1 - see if this is a child of anyone/thing
    with EntityIngredientOrMenuItemQuery do begin
      Parameters.ParamByName('ecode').Value := entityCode;
      Active := true;

      if FindFirst then begin
        warningGiven := true;
        progressForm.progressPause;
        if EntityDeleteDialog.entityDeleteConfirm(
            promptEntityNameStart+' will be removed from these products.'+#13#10+
            'Proceed with delete?',
            TDataSet(EntityIngredientOrMenuItemQuery) ) then begin
          doDelete := true;
        end else begin
          doDelete := false;
        end;
        progressForm.progressResume;
      end;
      // leave query active (for adding to lnkchngM later)
    end; {with EntityIngredientOrMenuItemQuery }

    progressForm.progress(progressTitle, 'Checking sales areas');

    // last chance for user to have change of heart
    if doDelete AND NOT warningGiven then begin
      progressForm.progress(progressTitle, 'Checking user');
      progressForm.progressPause;
      if MessageDlg( 'Are you sure you want to delete '+promptEntityNameEnd+'?',
                     mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
        doDelete := true;
      end else begin
        doDelete := false;
      end;
      progressForm.progressResume;
    end else begin
      progressForm.progress(progressTitle, 'Checking user (OK)');
    end;

    // finally - to delete, or not delete.
    if doDelete then begin
      progressForm.progress(progressTitle, 'Preparing to delete');

      with productsDB do begin
        // copy aside affected dialog handlers
        entbeforescroll := ClientEntityTable.BeforeScroll;
        entbeforepost   := ClientEntityTable.BeforePost;
      end;

      try
        progressForm.progressLog('Disabling Controls', pLogDevProgress);
        with productsDB do begin
          // disable GUI, to prevent our motions slowing everything down.
          DisableGUI;

          CancelAllDetailEditsInProgress;

          // unhook the client entity scroll handler
          ClientEntityTable.BeforeScroll := nil;
          ClientEntityTable.BeforePost   := ClientEntityTableBeforePost;
        end;

        dmADO.BeginTransaction;
        try try
          // "regular" delete of references to this product as a child
          progressForm.progress(progressTitle, 'Deleting from recipes, menus and choices');
          DeleteProductFromPortionIngredients(entityCode);

          progressForm.progress(progressTitle,'Deleting associated purchase units');
          DeleteProductFromPunits(entityCode);

          progressForm.progress(progressTitle,'Deleting recipe notes');
          deleteRecipeNotes(entityCode);

          progressForm.progress(progressTitle,'Deleting product barcodes');
          DeleteBarcodes(entityCode);

          progressForm.progress(progressTitle, 'Deleting Item');
          if ProductsDB.ProductNewlyInsertedAndNotSaved then begin
            // New item - never got saved.  Scrub it completely
            productsDB.ClientEntityTable.CancelUpdates;
          end else begin
            productsDB.ClientEntityTable.Edit;
            productsDB.ClientEntityTableDeleted.Value := 'Y';
            // other changes applied by post handler
            productsDB.ClientEntityTable.Post;
            productsDB.ClientEntityTable.ApplyUpdates(0);

            // remove from ProductProperties
            productsDB.ClientPPTable.Delete;
          end;

          if entityType in [etRecipe, etStrdLine, etInstruct] then
          begin
            productsDB.RemoveEntityFromThemeModel(entityCode);
            productsDB.RemoveProductFromAllTicketSequences;
          end;
        except
          Log.Event('EntityDelete - Exception occurred, Rolling Back.');
          // if an error occurs make sure that nothing is deleted.
          productsDB.ClientEntityTable.CancelUpdates;
          dmADO.RollbackTransaction;
          raise;
        end;
        finally
          if dmADO.InTransaction then dmADO.CommitTransaction
        end;

        progressForm.progress(progressTitle, 'Refreshing datasets');
        //Refresh the datasets of all tables which may have had records deleted.
        with productsDB do begin
          RecipeNotesTable.Requery;
          tblPreparedItemDetails.Requery;
          if IngredientsQuery1.Active then IngredientsQuery1.Requery;
        end;

      finally
        progressForm.progressLog('Restoring Controls', pLogDevProgress);
        // restore GUI;
        with productsDB do begin
          ClientEntityTable.beforePost   := entbeforepost;
          ClientEntityTable.beforeScroll := entbeforescroll;
          EnableGUI;
        end;
      end;

    end else begin
      progressForm.progressDone(False); // don't wait
    end;

  except on E:Exception do
    begin
      progressForm.progressDone(False); // don't wait
      Log.Event('Could not delete product: ' + E.Message);
      if Copy( E.Message, 0, Length( ChangedByOtherUserText ) ) = ChangedByOtherUserText then
        ShowMessage('The product could not be deleted because another user has changed or deleted'#10#13+
        'it since you since you opened ' + ProductModellingTextName + '.  The other user''s changes '#10#13+
        'will now be made visible to you.  If the item is still present, please try '#10#13+
        'deleting it again.' )
      else
        ShowMessage('Could not delete product due to the following error:'#13#10+E.Message);

      productsDB.RefreshDataFromDatabase;
    end;
  end;
  finally
    // close out those queries (if active)
    EntityIngredientOrMenuItemQuery.Active := false;
    progressForm.progressDone(False); // don't wait
  end;
end;

procedure TEntityDelete.EnableGUI;
begin
  with productsDB do begin
    ClientEntityTable.EnableControls;
    RecipeNotesTable.EnableControls;
    UnitSupplierTable.EnableControls;
    tblPreparedItemDetails.EnableControls;
  end;
end;

procedure TEntityDelete.DisableGUI;
begin
  with productsDB do begin
    ClientEntityTable.DisableControls;
    RecipeNotesTable.DisableControls;
    UnitSupplierTable.DisableControls;
    tblPreparedItemDetails.DisableControls;
  end;
end;

procedure TEntityDelete.CancelAllDetailEditsInProgress;
begin
  with productsDB do begin
    RecipeNotesTable.CancelUpdates;
    tblPreparedItemDetails.CancelUpdates;
  end;
end;

procedure TEntityDelete.DeleteProductFromPortionIngredients(EntityCode : double);
begin
  //Delete the Product from all portion recipes except where the parent product is itself, as will
  //be the case for a standard product, or where the parent product is deleted.

  //1. Do it for the current products
  with ADOCommand do begin
     CommandText := 'DECLARE @Temp TABLE (ParentEntityCode bigint, PortionID int, IngredientCode float) '+

                    //Which portioningredients entries are affected?
                    'INSERT INTO @Temp '+
                    'SELECT p.EntityCode, pg.[PortionID], pg.[IngredientCode] '+
                    'FROM Products p JOIN Portions po ON p.[EntityCode] = po.[EntityCode] '+
                    '                JOIN PortionIngredients pg ON po.[PortionID] = pg.[PortionID] '+
                    'WHERE p.[EntityCode] <> :ecode1 AND '+
                    '      pg.[IngredientCode] = :ecode2 AND (p.[Deleted] <> ''Y'' OR p.[Deleted] IS NULL) '+

                    //Touch the associated products to ensure 'commsing' of the parent
                    'UPDATE Products '+
                    'SET LMDT = getdate() '+
                    'FROM Products p '+
                    'JOIN @Temp t '+
                    'ON t.ParentEntityCode = p.EntityCode '+

                    //Delete the actual ingredients
                    'DELETE PortionIngredients '+
                    'FROM PortionIngredients po JOIN @Temp t '+
                    '  ON po.[IngredientCode] = t.[IngredientCode] AND '+
                    '     po.[PortionID] = t.[PortionID] ';

     Parameters.ParamByName('eCode1').Value := EntityCode;
     Parameters.ParamByName('eCode2').Value := EntityCode;
     Execute;
  end;

  //2. Do it for future product changes
  with ADOCommand do begin
     CommandText := 'DECLARE @Temp TABLE (PortionID int, IngredientCode float, EffectiveDate datetime) '+

                    'INSERT INTO @Temp '+
                    'SELECT pgf.[PortionID], pgf.[IngredientCode], pgf.[EffectiveDate]'+
                    'FROM Products p JOIN PortionsFuture pof ON p.[EntityCode] = pof.[EntityCode] '+
                    '                JOIN PortionIngredientsFuture pgf ON  pof.[PortionID] = pgf.[PortionID] AND '+
                    '                     pof.[EffectiveDate] = pgf.[EffectiveDate] ' +
                    'WHERE p.[EntityCode] <> :ecode1 AND '+
                    '      pgf.[IngredientCode] = :ecode2 AND (p.[Deleted] <> ''Y'' OR p.[Deleted] IS NULL) '+


                    'DELETE PortionIngredientsFuture '+
                    'FROM PortionIngredientsFuture pgf JOIN @Temp t '+
                    '  ON pgf.[IngredientCode] = t.[IngredientCode] AND '+
                    '     pgf.[PortionID] = t.[PortionID] AND ' +
                    '     pgf.[EffectiveDate] = t.[EffectiveDate]';
     Parameters.ParamByName('eCode1').Value := EntityCode;
     Parameters.ParamByName('eCode2').Value := EntityCode;
     Execute;
  end;
end;

procedure TEntityDelete.DeleteProductFromPunits(entityCode: double);
begin
  with ADOCommand do begin
     CommandText := Format(
       'SET NOCOUNT ON ' +

       'DECLARE @EntityCode float = %0:f ' +
       'DECLARE @now datetime = GetDate() ' +

       'DELETE PurchaseUnitsFuture WHERE [Entity Code] = @EntityCode AND [EffectiveDate] > @now ' +

       'INSERT PurchaseUnitsFuture ([Entity Code], [Supplier Name], [Unit Name], [Flavour], [Unit Cost], [EffectiveDate], [DeactivatedDate], [UserID] ,[LMDT]) ' +
       'SELECT [Entity Code], [Supplier Name], [Unit Name], [Flavour], [Unit Cost], @now, @now, %1:d , @now ' +
       'FROM PurchaseUnits ' +
       'WHERE [Entity Code] = @EntityCode ' +

       'DELETE PurchaseUnits WHERE [Entity Code] = @EntityCode ',
       [entityCode, CurrentUser.ID]);

     Execute;
  end;
end;

procedure TEntityDelete.DeleteRecipeNotes(entityCode: double);
begin
  with ADOCommand do begin
     CommandText := 'DELETE FROM RecipeNt WHERE [Entity Code] = :ecode';

     Parameters.ParamByName('eCode').Value := EntityCode;
     Execute;
  end;
end;

procedure TEntityDelete.DeleteBarCodes(entityCode: double);
begin
  with ADOCommand do
  begin
     CommandText := 'DELETE FROM ProductBarCode WHERE [EntityCode] = :ecode';
     Parameters.ParamByName('eCode').Value := EntityCode;
     Execute;
  end;
end;

end.
