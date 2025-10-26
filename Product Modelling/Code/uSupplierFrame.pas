unit uSupplierFrame;

(*
 * Unit contains the TUnitSupplierFrame class - this represents the controls
 * for editing the supplier table for a standard line or purchase line.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, ActnList, DBActns, StdCtrls, ComCtrls, DBCtrls, Mask, uGlobals,
  dbcgrids, Math, uDatabaseADO, Grids, DBGrids, FlexiDBGrid, ExtCtrls;

type
  TUnitSupplierFrame = class(TFrame)
    Button2: TButton;
    Button3: TButton;
    SetDefaultSupplierButton: TButton;
    SetDefaultPurchaseUnitButton: TButton;
    ActionList1: TActionList;
    SetDefaultSupplierAction: TAction;
    SetDefaultPurchaseUnitAction: TAction;
    DeleteSupplierAction: TAction;
    FlexiDBGrid1: TFlexiDBGrid;
    AddSupplierAction: TAction;
    procedure DeleteSupplierActionExecute(Sender: TObject);
    procedure DeleteSupplierActionUpdate(Sender: TObject);
    procedure SetDefaultPurchaseUnitActionExecute(Sender: TObject);
    procedure SetDefaultPurchaseUnitActionUpdate(Sender: TObject);
    procedure SetDefaultSupplierActionExecute(Sender: TObject);
    procedure SetDefaultSupplierActionUpdate(Sender: TObject);
    procedure FlexiDBGrid1StepPastEnd(Sender: TComponent;
      reason: TFlexiStepPastEndReasonOption);
    procedure FrameExit(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure FlexiDBGrid1ToggleBooleanField(Sender: TObject);
    procedure AddSupplierActionExecute(Sender: TObject);
    procedure AddSupplierActionUpdate(Sender: TObject);
  private
    // Event handler - invoked if the default purchase unit changes (or any of its properties).
    FOnDefaultPurchaseUnitChange : TNotifyEvent;
    // True if the keyboard focus is currently within the frame.
    inFrame: boolean;

    // Information about the default purchase unit (for the default supplier):
    defUnitExists: boolean; // There is a default purchase unit
    defUnitRef: string;     // The import/export ref of the default purchase unit
    defUnitUnit: string;    // The units column of the default purchase unit
    defUnitCost: Double;    // The cost column for the default purchase unit

    oldDefUnitRef: string;

    // The supplier name and unit name before the current row was edited.
    preEditSupplierName: variant;
    preEditUnitName: variant;
    preEditFlavour: variant;

    // If non-null, the name of the only supplier in the list
    soleSupplier: string;

    // Set to true if a failure in post should not display any error messages
    silentPostFail: boolean;

    //Determine whether or not the temp table driving this frame needs saved
    FPendingChangesExist: Boolean;

    FIsFutureCostPrice: Boolean;
    FEffectiveDate: string;

    // Called after supplier table is put into insert mode.
    procedure UnitSupplierTableAfterInsert(DataSet: TDataSet);
    // Called after supplier table is put into edit mode.
    procedure UnitSupplierTableAfterEdit(DataSet: TDataSet);
    // Called before allowing a supplier record to be posted
    procedure UnitSupplierTableBeforePost(DataSet: TDataSet);
    // Called after posting data to the unit supplier table.
    procedure UnitSupplierTableAfterPost(DataSet: TDataSet);
    // Called if the data in the unit supplier table changes.
    procedure UnitSupplierTableDataChange(Sender: TObject; Field: TField);
    // Setup the pick list for the units column in the table - units must match the
    // purchase unit in the entity table.
    procedure setupUnitPickList;
    // Check that the units for each supplier entry match the purchase units for the
    // current entity.  Display error and raise EAbort if this test fails.
    procedure CheckSupplierUnits;
    procedure SetIsFutureCostPrice(const Value: Boolean);
    procedure SetEffectiveDate(const Value: string);

  public

    // Performs three functions:
    // 1) Update the unit supplier table to ensure that:
    //   (a) every supplier has a default purchase unit.
    //   (b) no supplier has more than one default purchase unit.
    // 2) Retrieves information about the default purchase unit for the
    //    default supplier and stores in in the defUnit... variables.
    // 3) If info for the default supplier has changed, invokes the
    //    OnDefaultPurchaseUnitChange event IF invokeCallback = true
    // Note: there must be no outstanding edits in the supplier table when this is called.
    procedure refreshSupplierInfo(invokeCallback: boolean);
    // Attach frame event handlers to the supplier table - this can't be done in
    // the designer.  This should be called once at startup.
    procedure attachToSupplierTable;
    // Setup static pick lists, e.g. the list of suppliers.  This should be called
    // once at startup.
    procedure setupStaticPickLists;

    // Called after moving to a new entity.  Updates form to reflect new entity.
    procedure InitialiseForCurrentProduct;
    // Called if data in the entity table changes.
    procedure onEntityDataChange( et: EntType; field: TField );
    // Called to validate the current entity before posting changes.
    procedure beforeEntityPost( et: EntType );

    // Get information about the default purchase unit for the default supplier:
    //   unitName: the units for the default purchase unit
    //   cost: the cost of the default purchase unit
    // Returns: true if there is a default purchase unit for the default supplier,
    //          false otherwise.
    function getDefaultPurchaseUnitInfo( out unitName: string;
                                         out cost: Double ): boolean;

    // Get information about the import/export ref of the default purchase unit
    // for the default supplier.
    // Returns: true if there is a default purchase unit for the default supplier,
    //          false otherwise.
    function getImportExportRef( out oldRef, newRef: string ): boolean;

    // If there is only one supplier defined in the list, this gives details of
    // that supplier.
    function isSoleSupplier : boolean;
    function getSoleSupplier : string;

    procedure SetEnabledProperties;

    // Event:  invoked if the information returned by getDefaultPurchaseUnitInfo
    // changes;  is NOT called when moving from entity to another.
    property OnDefaultPurchaseUnitChange : TNotifyEvent read FOnDefaultPurchaseUnitChange write FOnDefaultPurchaseUnitChange;
    property PendingChangesExist: Boolean read FPendingChangesExist write FPendingChangesExist;
    property IsFutureCostPrice: Boolean read FIsFutureCostPrice write SetIsFutureCostPrice;
    property EffectiveDate: string read FEffectiveDate write SetEffectiveDate;
  end;

implementation

uses uGuiUtils, uLineEdit, StrUtils, ADODB, uLog, uLocalisedText, Variants, uADO;

{$R *.dfm}

// Setup event handlers
procedure TUnitSupplierFrame.attachToSupplierTable;
begin
  productsDB.UnitSupplierTable.AfterInsert := UnitSupplierTableAfterInsert;
  productsDB.UnitSupplierTable.AfterEdit := UnitSupplierTableAfterEdit;
  productsDB.UnitSupplierTable.AfterPost := UnitSupplierTableAfterPost;
  productsDB.UnitSupplierTable.BeforePost := UnitSupplierTableBeforePost;
  productsDB.UnitSupplierDataSource.OnDataChange := UnitSupplierTableDataChange;
  silentPostFail := false;
end;

// Setup static pick lists and setup grid.
procedure TUnitSupplierFrame.setupStaticPickLists;
begin
  FlexiDBGrid1.Columns[0].PickList := productsDB.supplierStringList;
  FlexiDBGrid1.SetBooleanField( productsDB.UnitSupplierTableDefaultFlag, '*' );
end;

// Called after moving to a new entity;  refresh the form for the new entity.
procedure TUnitSupplierFrame.InitialiseForCurrentProduct;
begin
  // Find the default supplier for this entity.
  refreshSupplierInfo( false );
  // Move to the first supplier for this entity.
  productsDB.UnitSupplierTable.First;
  // Setup the pick list with the correct units for the purchase unit of this entity
  setupUnitPickList;
end;

procedure TUnitSupplierFrame.onEntityDataChange( et: EntType; field: TField );
begin
  // If purchase unit changes, update the pick list of matching units accordingly.
  if (field = nil) or (field = productsDB.ClientEntityTablePurchaseUnit) then
    setupUnitPickList;
end;

procedure TUnitSupplierFrame.beforeEntityPost( et: EntType );
begin
  // Ensure that the units column for all suppliers in the table is correct.
  CheckSupplierUnits;
end;

// Validate the current record before posting to the supplier table.
procedure TUnitSupplierFrame.UnitSupplierTableBeforePost(DataSet: TDataSet);
var LogText: string;
  ProductMatch: String;

  function OKToDeleteFutureCostPrices: Boolean;
  var
    mr: TModalResult;
  begin
    Result := True;
    with ProductsDB.ADOQuery do
    begin
      Close;
      SQL.CLear;
      SQL.Append('select count(*) as FutureCount');
      SQL.Append('from PurchaseUnitsFuture puf');
      SQL.Append('where puf.[Entity code] = :entityCode');
      SQL.Append('and puf.[Supplier Name] = :previousSupplierName');
      SQL.Append('and puf.[Unit Name] = :previousUnitName');
      if VarIsNull(preEditFlavour) then
        SQL.Append('and (puf.Flavour is null)')
      else
        SQL.Append('and puf.Flavour = '+QuotedStr(preEditFlavour));
      SQl.Append('and puf.EffectiveDate >= getdate()');
      Parameters.ParamByName('entityCode').Value := ProductsDB.ClientEntityTableEntityCode.AsString;
      Parameters.ParamByName('previousSupplierName').Value := preEditSupplierName;
      Parameters.ParamByName('previousUnitName').Value := preEditUnitName;
      Open;

      if not EOF then
      begin
        if FieldByName('FutureCount').AsInteger > 0 then
        begin
          mr := MessageDlg('Future product cost prices exist for this supplier/unit name/flavour combination.' + #13#10 +
                'Continuing with this edit will delete future product cost price changes.  Do you wish to continue?',
                mtWarning,[mbYes,mbNo],0);
          if mr = mrNo then
            Result := False;
        end;
      end;
    end;
  end;

begin
  // Check that supplier, unit and cost have all been filled in.
  if productsDB.UnitSupplierTableSupplierName.IsNull or
     (productsDB.UnitSupplierTableSupplierName.Value = '') then begin
    if not silentPostFail then begin
      FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableSupplierName;
      PrizmSetFocus( FlexiDBGrid1 );
      ShowMessage( 'You must enter the supplier name for the record' );
    end;
    SysUtils.Abort;
  end else if productsDB.UnitSupplierTableUnitName.IsNull or
              (productsDB.UnitSupplierTableUnitName.Value = '') then begin
    if not silentPostFail then begin
      FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitName;
      PrizmSetFocus( FlexiDBGrid1 );
      ShowMessage( 'You must enter the unit name for the record' );
    end;
    SysUtils.Abort;
  end else if productsDB.UnitSupplierTableUnitCost.IsNull then begin
    if not silentPostFail then begin
      FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitCost;
      PrizmSetFocus( FlexiDBGrid1 );
      ShowMessage( 'You must enter a cost for the record' );
    end;
    SysUtils.Abort;
  end;

  // Has unit name changed?
  if ((productsDB.UnitSupplierTable.State = dsInsert) or
      (preEditUnitName <> productsDB.UnitSupplierTableUnitName.Value)) then begin

    // Unit Name has changed - validate it
    if not FieldMatchesPickList( productsDB.UnitSupplierTableUnitName,
                                 productsDB.validUnitsStringList, false ) then begin

      if not silentPostFail then begin
        FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitName;
        PrizmSetFocus( FlexiDBGrid1 );
        ShowMessage( '"' + productsDB.UnitSupplierTableUnitName.Value +
                     '" is not a valid unit name.' );

        if productsDB.UnitSupplierTable.State <> dsInsert then
          productsDB.UnitSupplierTableUnitName.Value := preEditUnitName;
      end;

      SysUtils.Abort;

    end else begin
      // This is a valid unit name - but does it match the base type?
      if not productsDB.unitsHaveSameBaseType( productsDB.UnitSupplierTableUnitName.Value,
                                        productsDB.ClientEntityTablePurchaseUnit.Value ) then begin

        if not silentPostFail then begin
          FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitName;
          PrizmSetFocus( FlexiDBGrid1 );
          ShowMessage( 'The unit "' + productsDB.UnitSupplierTableUnitName.Value +
                       '" is not compatible with the purchase unit "' +
                       productsDB.ClientEntityTablePurchaseUnit.Value + '"' );

          if productsDB.UnitSupplierTable.State <> dsInsert then
            productsDB.UnitSupplierTableUnitName.Value := preEditUnitName;
        end;

        SysUtils.Abort;
      end;
    end;

  end;

  // Has supplier name changed?
  if ((productsDB.UnitSupplierTable.State = dsInsert) or
      (preEditSupplierName <> productsDB.UnitSupplierTableSupplierName.Value)) then begin

    // Supplier name has changed - check its validity
    if not FieldMatchesPickList( productsDB.UnitSupplierTableSupplierName,
                                 productsDB.supplierStringList, false ) then begin

      if not silentPostFail then begin
        FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableSupplierName;
        PrizmSetFocus( FlexiDBGrid1 );
        ShowMessage( '"' + productsDB.UnitSupplierTableSupplierName.Value +
                     '" is not a valid supplier name.' );
      end;
      SysUtils.Abort;
    end;
  end;

  // if Inserting a record ensure that null flavour is set to empty string
  if (productsDB.UnitSupplierTable.State = dsInsert) then
  begin
    if productsDB.UnitSupplierTableFlavour.IsNull then
      productsDB.UnitSupplierTableFlavour.Value := '';
  end;

  if (productsDB.UnitSupplierTable.State = dsEdit)
  and (     (preEditSupplierName <> productsDB.UnitSupplierTableSupplierName.Value)
        or  (preEditUnitName <> productsDB.UnitSupplierTableUnitName.Value)
        or  not VarSameValue(preEditFlavour, productsDB.UnitSupplierTableFlavour.AsVariant)) then
  begin
    if not OKToDeleteFutureCostPrices then
    begin
      productsDB.UnitSupplierTableSupplierName.value := preEditSupplierName;
      productsDB.UnitSupplierTableUnitName.value := preEditUnitName;
      productsDB.UnitSupplierTableFlavour.value := preEditFlavour;
      SysUtils.Abort;
    end;
  end;

  // Check for potential key violation
  if ProductsDB.WillADOPostCauseKeyViol(productsDB.UnitSupplierTable,
    ['Supplier Name','Unit Name','Flavour']) then
  begin
    if not silentPostFail then begin
      PrizmSetFocus( FlexiDBGrid1 );
      FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitName;
      MessageDlg( 'There is already an entry in the list for Supplier ' +
                   QuotedStr(productsDB.UnitSupplierTableSupplierName.Value) + ', Unit ' +
                   QuotedStr(productsDB.UnitSupplierTableUnitName.Value) + ' and Flavour ' +
                   QuotedStr(productsDB.UnitSupplierTableFlavour.Value) + '.',
                   mtInformation,
                   [mbOK],
                   0);
    end;
    SysUtils.Abort;
  end;

  // remove leading and trailing spaces...
  if trim(productsDB.UnitSupplierTableImportExportReference.AsString) = '' then // if empty...
  begin
    productsDB.UnitSupplierTableImportExportReference.AsVariant := null;        // ... store it as NULL
  end
  else  // ImportExportReference ("Supplier Ref" in the grid) is not NULL or empty
  begin
    // Check for potential key violation - check that a duplicate [supplier name],
    // [import/export reference] pair isn't being attempted for the product.  This
    // psuedo-constraint is enforced by the PurchaseUnits_UniqueRefs indexed view
    // but we check here to give the user some sensible feedback before attempting to
    // save the edits.

    //Check the temp table...
    if ProductsDB.WillADOPostCauseKeyViol(productsDB.UnitSupplierTable,
      ['Supplier Name','Import/Export Reference']) then
    begin
      if not silentPostFail then begin
        PrizmSetFocus( FlexiDBGrid1 );
        FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableImportExportReference;
        MessageDlg( 'There is already an entry in the list for Supplier ' +
                     QuotedStr(productsDB.UnitSupplierTableSupplierName.Value) + ' and Supplier Ref ' +
                     QuotedStr(productsDB.UnitSupplierTableImportExportReference.Value) + '.',
                     mtInformation,
                     [mbOK],
                     0);
      end;
      SysUtils.Abort;
    end
    else
    begin
      //..check the rest of the products
      with ProductsDB.ADOQuery do
      try
        SQL.Clear;
        SQL.Add('SELECT p.[Extended Rtl Name] as MatchName');
        SQL.Add('FROM Products p ');
        SQL.Add('INNER JOIN PurchaseUnits pu');
        SQl.Add('   ON p.EntityCode = pu.[Entity Code]');
        SQL.Add('WHERE pu.[Entity Code] <> :EntityCode');
        SQL.Add('  AND pu.[Supplier Name] = :SupplierName');
        SQL.Add('  AND pu.[Import/Export Reference] = :ImpExpReference');
        Parameters.ParamByName('EntityCode').Value := productsDB.UnitSupplierTableEntityCode.Value;
        Parameters.ParamByName('SupplierName').Value := ProductsDB.UnitSupplierTableSupplierName.Value;
        Parameters.ParamByName('ImpExpReference').Value := ProductsDB.UnitSupplierTableImportExportReference.Value;
        Open;

        if not (Bof and Eof) then
        begin
          ProductMatch := FieldByname('MatchName').AsString;

          if not silentPostFail then begin
            PrizmSetFocus( FlexiDBGrid1 );
            FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableImportExportReference;
            MessageDlg( 'Product ' + QuotedStr(ProductMatch) + ' already uses Supplier ' +
                         QuotedStr(productsDB.UnitSupplierTableSupplierName.Value) + ' and Supplier Ref ' +
                         QuotedStr(productsDB.UnitSupplierTableImportExportReference.Value) + '.',
                         mtInformation,
                         [mbOK],
                         0);
          end;
          SysUtils.Abort;
        end;
      finally
        Close;
      end;
    end;
  end;

  //Log the change
  with ProductsDb do
  begin
    if UnitSupplierTable.State = dsInsert then
    begin
      //Don't log anything if the purchase units are being added for a future date as these are not real changes,
      //they are simply the current purchase units being duplicated at the future date ready for editing.
      if UnitSupplierTableEffectiveDate.AsString = '' then
        LogProductChange('Purchase unit added. ' +
            'Supplier: "'+ UnitSupplierTableSupplierName.AsString + '", ' +
            'Unit: "' + UnitSupplierTableUnitName.AsString + '", ' +
            'Flavour: "' + UnitSupplierTableFlavour.AsString + '", ' +
            'Supplier Ref: "' + UnitSupplierTableImportExportReference.AsString + '", ' +
            'Barcode: "' + UnitSupplierTableBarcode.AsString + '", ' +
            'Cost: "' + UnitSupplierTableUnitCost.AsString + '"');
    end
    else
    begin
      LogText := '';

      if UnitSupplierTableSupplierName.OldValue <> UnitSupplierTableSupplierName.NewValue then
        LogText := LogText + 'Supplier changed from "' + VarToStr(UnitSupplierTableSupplierName.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableSupplierName.NewValue) + '"';

      if UnitSupplierTableUnitName.OldValue <> UnitSupplierTableUnitName.NewValue then
        LogText := LogText + 'Unit changed from "' + VarToStr(UnitSupplierTableUnitName.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableUnitName.NewValue) + '"';

      if UnitSupplierTableFlavour.OldValue <> UnitSupplierTableFlavour.NewValue then
        LogText := LogText + 'Flavour changed from "' + VarToStr(UnitSupplierTableFlavour.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableFlavour.NewValue) + '"';

      if UnitSupplierTableImportExportReference.OldValue <> UnitSupplierTableImportExportReference.NewValue then
        LogText := LogText + 'Supplier Ref changed from "' + VarToStr(UnitSupplierTableImportExportReference.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableImportExportReference.NewValue) + '"';

      if UnitSupplierTableBarcode.OldValue <> UnitSupplierTableBarcode.NewValue then
        LogText := LogText + 'Barcode changed from "' + VarToStr(UnitSupplierTableBarcode.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableBarcode.NewValue) + '"';

      if UnitSupplierTableUnitCost.OldValue <> UnitSupplierTableUnitCost.NewValue then
        LogText := LogText + 'Cost changed from "' + VarToStr(UnitSupplierTableUnitCost.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableUnitCost.NewValue) + '"';

      if UnitSupplierTableDefaultFlag.OldValue <> UnitSupplierTableDefaultFlag.NewValue then
        LogText := LogText + 'Default Flag changed from "' + VarToStr(UnitSupplierTableDefaultFlag.OldValue) + '" to "'+
          VarToStr(UnitSupplierTableDefaultFlag.NewValue) + '"';

      if LogText <> '' then
        LogProductChange('Purchase unit edited for ' + FEffectiveDate + ' (' +
            'Supplier: "'+ VarToStr(UnitSupplierTableSupplierName.OldValue) + '", ' +
            'Unit: "' + VarToStr(UnitSupplierTableUnitName.OldValue) + '", ' +
            'Flavour: "' + VarToStr(UnitSupplierTableFlavour.OldValue) + '"): ' + LogText);
    end;
  end;
end;

// Delete current supplier...
procedure TUnitSupplierFrame.DeleteSupplierActionExecute(Sender: TObject);
begin
  with ProductsDB do
  begin
    LogProductChange('Purchase unit deleted. ' +
        'Supplier: "'+ UnitSupplierTableSupplierName.AsString + '", ' +
        'Unit: "' + UnitSupplierTableUnitName.AsString + '", ' +
        'Flavour: "' + UnitSupplierTableFlavour.AsString + '", ' +
        'Supplier Ref: "' + UnitSupplierTableImportExportReference.AsString + '", ' +
        'Barcode: "' + UnitSupplierTableBarcode.AsString + '", ' +
        'Cost: "' + UnitSupplierTableUnitCost.AsString + '"');

    if UnitSupplierTable.State = dsEdit then begin
      UnitSupplierTable.Cancel;
      UnitSupplierTable.Delete;
      FPendingChangesExist := True;
    end else if UnitSupplierTable.State = dsInsert then begin
      UnitSupplierTable.Cancel;
    end else if UnitSupplierTable.State = dsBrowse then begin
      UnitSupplierTable.Delete;
      FPendingChangesExist := True;
    end;
  end;

  // Update the supplier table and inform event handler if necessary
  refreshSupplierInfo( true );
end;

// Allow delete only if
//  (a) focus is currently in the supplier frame and
//  (b) there is a supplier selected in the table.
procedure TUnitSupplierFrame.DeleteSupplierActionUpdate(Sender: TObject);
begin
  DeleteSupplierAction.Enabled :=
    inFrame and
   ((productsDB.UnitSupplierTable.State = dsEdit) or
    (productsDB.UnitSupplierTable.State = dsInsert) or
    (productsDB.UnitSupplierTable.State = dsBrowse)) and
    (not productsDB.UnitSupplierTable.IsEmpty) and
    not FIsFutureCostPrice;
end;

// Set the current row as the default purchase unit.
procedure TUnitSupplierFrame.SetDefaultPurchaseUnitActionExecute(Sender: TObject);
begin
  //If the column is read only then don't do anything
  if not FlexiDBGrid1.Columns[FlexiDBGrid1.SelectedIndex].ReadOnly then
  begin
    if productsDB.UnitSupplierTableDefaultFlag.Value <> '*' then begin
      productsDB.UnitSupplierTable.DisableControls;

      try
        // Set the current row as the default purchase unit
        productsDB.UnitSupplierTable.Edit;

        try
          productsDB.UnitSupplierTableDefaultFlag.Value := '*';
          productsDB.UnitSupplierTable.Post; // this could fail for many reasons.
        except else
          Log.Event('SetDefaultPurchaseUnit - Error on post to UnitSupplierTable');
          // Post failed for some reason - undo the default flag
          productsDB.UnitSupplierTableDefaultFlag.Value := ' ';
          raise;
        end;

        refreshSupplierInfo( true ); // This ensures there is only one default purchase unit
      finally
        productsDB.UnitSupplierTable.EnableControls;
      end;
    end;
  end;
end;

// Only allow user to set default purchase unit if focus is in the frame and there is
// a supplier selected in the table.
procedure TUnitSupplierFrame.SetDefaultPurchaseUnitActionUpdate(
  Sender: TObject);
begin
  TAction( Sender ).Enabled := inFrame and not productsDB.UnitSupplierTable.IsEmpty
    and not FIsFutureCostPrice;
end;

// Set the default supplier...
procedure TUnitSupplierFrame.SetDefaultSupplierActionExecute(
  Sender: TObject);
begin
  // post current row (or else we can't call refreshSupplierInfo)
  if productsDB.UnitSupplierTable.State <> dsBrowse then
    productsDB.UnitSupplierTable.Post;

  // Update the default supplier column in the entity table.
  if productsDB.ClientEntityTable.State = dsBrowse then
    productsDB.ClientEntityTable.Edit;

  if (productsDB.ClientEntityTable.State = dsEdit) or
     (productsDB.ClientEntityTable.State = dsInsert) then
  begin
    productsDB.ClientEntityTableDefaultSupplier.Assign(
      productsDB.UnitSupplierTableSupplierName );
  end;

  // Update information about the default purchase unit... don't invoke callback
  // until we've had a chance to update import export ref for the
  // client entity table.
  refreshSupplierInfo( false );

  if (productsDB.ClientEntityTable.State in [dsEdit,dsInsert]) and
     (defUnitRef <> '') then
  begin
    //Update the product import/export reference, but only if it is currently
    //tied to the default purchase unit import/export reference or is
    //null. (GDM 29/7/04: Bug 325066)
    if (productsDB.ClientEntityTableImportExportReference.Value = '') or
       (productsDB.ClientEntityTableImportExportReference.Value = olddefUnitRef)
    then
      productsDB.ClientEntityTableImportExportReference.Value := defUnitRef;
  end;

  // Invoke the callback now.
  if Assigned( FOnDefaultPurchaseUnitChange ) then
    FOnDefaultPurchaseUnitChange( self );
end;

// Only allow user to set default supplier if focus is in the frame and there is
// a supplier selected in the table.
procedure TUnitSupplierFrame.SetDefaultSupplierActionUpdate(
  Sender: TObject);
begin
  TAction( Sender ).Enabled := inFrame and not productsDB.UnitSupplierTable.IsEmpty
    and not FIsFutureCostPrice;
end;

// Setup unit pick list to match entity purchase unit.
procedure TUnitSupplierFrame.setupUnitPickList;
begin
  FlexiDBGrid1.Columns[1].PickList :=
    productsDB.getUnitsWithSameBaseType( productsDB.ClientEntityTablePurchaseUnit.Value, false );
end;

// User has stepped past the end of the supplier table - create a new supplier record.
procedure TUnitSupplierFrame.FlexiDBGrid1StepPastEnd(Sender: TComponent;
  reason: TFlexiStepPastEndReasonOption);
begin
  if (productsDB.UnitSupplierTable.State = dsEdit) or
     (productsDB.UnitSupplierTable.State = dsInsert) then
    productsDB.UnitSupplierTable.Post; // Post the current record... could fail.

  if (productsDB.UnitSupplierTable.State = dsBrowse)
  and not FIsFutureCostPrice then begin
    productsDB.UnitSupplierTable.Append;

    // Drop down supplier list box.
    if productsDB.UnitSupplierTable.State = dsInsert then begin
      FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableSupplierName;
      PrizmSetFocus( FlexiDBGrid1 );
      FlexiDBGrid1.ShowEditorPickList;
    end;
  end;
end;

// Get the information about the current purchase unit which was gathered by the
// refreshSupplierInfo function.
function TUnitSupplierFrame.getDefaultPurchaseUnitInfo(out unitName: string;
  out cost: Double): boolean;
begin
  if defunitexists then begin
    unitName := defunitunit;
    cost := defunitcost;
  end;
  Result := defunitexists;
end;

// Get the information about the current purchase unit which was gathered by the
// refreshSupplierInfo function.
function TUnitSupplierFrame.getImportExportRef(out oldRef,
  newRef: string): boolean;
begin
  if defunitexists then begin
    oldRef := oldDefUnitRef;
    newRef := defUnitRef;
  end;
  Result := defunitexists;
end;


// Performs three functions:
// 1) Update the unit supplier table to ensure that:
//   (a) every supplier has a default purchase unit.
//   (b) no supplier has more than one default purchase unit.
// 2) Retrieves information about the default purchase unit for the
//    default supplier and stores in in the defUnit... variables.
// 3) If info for the default supplier has changed, invokes the
//    OnDefaultPurchaseUnitChange event IF invokeCallback = true
// Note: there must be no outstanding edits in the supplier table when this is called.
procedure TUnitSupplierFrame.refreshSupplierInfo( invokeCallback: boolean );
var
  suppliersWithDefaults: TStringList;
  suppliersWithoutDefaults: TStringList;
  selectedSupplier: string;
  thisSupplier: string;
  thispos: TBookmark;
  index: Integer;

  gotSoleSupplier : boolean;
  defUnitDetailsChanged : boolean;
  defUnitDidExist : boolean;
  oldpos: TBookmark;

  // Check to see if the current supplier record is the record for the default purchase
  // unit, if so set defUnitExists, defUnitDetailsChanged (if necessary) and update the
  // corresponding fields of this class.
  procedure UpdateDefaultSupplierInfo;
  begin
    if productsDB.UnitSupplierTableSupplierName.Value =
       productsDB.ClientEntityTableDefaultSupplier.Value then begin
      if productsDB.UnitSupplierTableDefaultFlag.Value = '*' then begin

        defUnitExists := true;

        if (defUnitUnit <> productsDB.UnitSupplierTableUnitName.AsVariant) or
           (defUnitRef <> productsDB.UnitSupplierTableImportExportReference.AsVariant) or
           (defUnitCost <> productsDB.UnitSupplierTableUnitCost.AsVariant) or
           not defUnitDidExist then
          defUnitDetailsChanged := true;

        defUnitUnit := productsDB.UnitSupplierTableUnitName.Value;
        defUnitRef := productsDB.UnitSupplierTableImportExportReference.Value;
        defUnitCost := productsDB.UnitSupplierTableUnitCost.Value;
      end;
    end;
  end;

begin
  productsDB.UnitSupplierTable.DisableControls;

  oldpos := productsDB.UnitSupplierTable.GetBookmark;

  gotSoleSupplier := false;
  soleSupplier := '';
  defUnitDidExist := defunitexists;
  defUnitExists := false;
  defUnitDetailsChanged := false;

  oldDefUnitRef := defUnitRef;

  // Record all the supplier which have been encountered
  suppliersWithDefaults := TStringList.Create;
  suppliersWithoutDefaults := TStringList.Create;

  // If multiple entries for a single supplier are found to be set as the default,
  // normally the first entry is left as the default, and subsequent entries are
  // cleared.  However, if the current row has the default flag set, (when we
  // entered the procedure) then we always leave it set as the default.
  selectedSupplier := productsDB.UnitSupplierTableSupplierName.Value;
  if productsDB.UnitSupplierTableDefaultFlag.Value = '*' then
    // Add to list of suppliers which already have defaults; as a result, code later
    // will clear default flag on all other entries for this supplier.
    suppliersWithDefaults.Add( selectedSupplier );

  try try
    // First pass of table performs the following functions:
    // (a) Assemble lists of supplier which have and have not got default purchase units.
    // (b) Update information about the default purhcase unit for the default supplier.
    // (c) If any suppliers have more than one default purchase unit, clear the default
    //     flag on all but the first entry encountered.

    productsDB.UnitSupplierTable.First;
    while not productsDB.UnitSupplierTable.Eof do begin

      thisSupplier := productsDB.UnitSupplierTableSupplierName.Value;

      // Figure out if there is a sole supplier
      if not gotSoleSupplier then
      begin
        soleSupplier := thisSupplier;
        gotSoleSupplier := true;
      end
      else if soleSupplier <> thisSupplier then
        soleSupplier := '';


      index := suppliersWithDefaults.IndexOf( thisSupplier );
      if index <> -1 then begin

        // We have seen a default unit for this supplier

        if productsDB.UnitSupplierTableDefaultFlag.Value = '*' then begin

          // This is the second default supplier unit we have seen for this supplier.
          // Clear the flag on this entry UNLESS it is the initial
          // entry selected when we entered the procedure.
          thispos := productsDB.UnitSupplierTable.GetBookmark;
          if productsDB.UnitSupplierTable.CompareBookmarks( thispos, oldpos ) <> 0 then begin
            productsDB.UnitSupplierTable.Edit;
            productsDB.UnitSupplierTableDefaultFlag.Value := ' ';
            productsDB.UnitSupplierTable.Post;
          end;
          productsDB.UnitSupplierTable.FreeBookmark( thispos );
        end;

      end else begin

        index := suppliersWithoutDefaults.IndexOf( thisSupplier );
        if index <> -1 then begin

          // We have seen this supplier, but we have not seen a
          // default unit for it.
          if productsDB.UnitSupplierTableDefaultFlag.Value = '*' then begin
            suppliersWithoutDefaults.Delete( index );
            suppliersWithDefaults.Add( thisSupplier )
          end;

        end else begin
          // We have not seen this supplier before.
          if productsDB.UnitSupplierTableDefaultFlag.Value = '*' then
            suppliersWithDefaults.Add( thisSupplier )
          else
            suppliersWithoutDefaults.Add( thisSupplier );
        end;
      end;

      // Check to see if this is the default purchase unit for the default supplier.
      UpdateDefaultSupplierInfo;

      productsDB.UnitSupplierTable.Next;
    end;

    // We have removed duplicate default purchase items, and updated our internal
    // information about the default unit for the default supplier;
    // However, if there are any purchase units with no default purchase unit, we must
    // do another pass of the table to fix this.
    if suppliersWithoutDefaults.Count > 0 then begin

      // The first time we encounter a row for a supplier with no default purchase unit,
      // we set it as the default.
      productsDB.UnitSupplierTable.First;
      while not productsDB.UnitSupplierTable.Eof do begin

        thisSupplier := productsDB.UnitSupplierTableSupplierName.Value;

        index := suppliersWithoutDefaults.IndexOf( thisSupplier );
        if index <> -1 then begin


          suppliersWithoutDefaults.Delete( index );
          productsDB.UnitSupplierTable.Edit;
          productsDB.UnitSupplierTableDefaultFlag.Value := '*';
          productsDB.UnitSupplierTable.Post;

          // Check to see if this is the default purchase unit for the default supplier.
          UpdateDefaultSupplierInfo;
        end;

        productsDB.UnitSupplierTable.Next;
      end;
    end;

    // At this point, we have ensured that each supplier has exactly one default
    // purchase unit, and we have scanned the whole table for the default purchase unit
    // for the default supplier.

    // If the default purchase unit for default supplier has changed, invoke event.
    if defUnitDidExist and not defUnitExists then
      defUnitDetailsChanged := true;

    if defUnitDetailsChanged and invokeCallback and
       Assigned( FOnDefaultPurchaseUnitChange ) then
      FOnDefaultPurchaseUnitChange( self );

  finally
    suppliersWithDefaults.Free;
    suppliersWithoutDefaults.Free;
    if productsDB.UnitSupplierTable.BookmarkValid( oldpos ) then
      productsDB.UnitSupplierTable.GotoBookmark( oldpos );
    productsDB.UnitSupplierTable.FreeBookmark( oldpos );
  end finally
    productsDB.UnitSupplierTable.EnableControls;
  end;

end;

// Check all the unit types in the supplier table are compatible with the
// purchase unit.
procedure TUnitSupplierFrame.CheckSupplierUnits;
var
  restorePosition: boolean;
  oldpos : TBookmark;
begin
  restorePosition := true;
  productsDB.UnitSupplierTable.DisableControls;
  oldpos := productsDB.UnitSupplierTable.GetBookmark;

  try
    // Check the units of each table entry.
    productsDB.UnitSupplierTable.First;

    while not productsDB.UnitSupplierTable.EOF do begin
      if not productsDB.unitsHaveSameBaseType( productsDB.ClientEntityTablePurchaseUnit.Value,
                                        productsDB.UnitSupplierTableUnitName.Value ) then begin

        // Found an incompatible unit - leave cursor at this position and display error.
        productsDB.UnitSupplierTable.EnableControls;
        restorePosition := false;
        FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableUnitName;
        PrizmSetFocus( FlexiDBGrid1 );
        ShowMessage( 'Supplier unit ' + productsDB.UnitSupplierTableUnitName.Value +
          ' is incompatible with the stock unit ' + productsDB.ClientEntityTablePurchaseUnit.Value );
        SysUtils.Abort;
      end;
      productsDB.UnitSupplierTable.Next;
    end;

  finally
    if restorePosition then begin
      if productsDB.UnitSupplierTable.BookmarkValid( oldpos ) then
        productsDB.UnitSupplierTable.GotoBookmark( oldpos );
      productsDB.UnitSupplierTable.EnableControls;
    end;
    productsDB.UnitSupplierTable.FreeBookmark( oldpos );
  end;
end;

// When leaving the supplier frame, ensure all edits are cancelled or posted.
// If a post error occurs, the code will set focus back into the frame.
procedure TUnitSupplierFrame.FrameExit(Sender: TObject);
begin
  if (productsDB.UnitSupplierTable.state = dsInsert) and
      productsDB.UnitSupplierTableSupplierName.IsNull and
      productsDB.UnitSupplierTableUnitName.IsNull and
      productsDB.UnitSupplierTableFlavour.IsNull then
    productsDB.UnitSupplierTable.Cancel;

  if (productsDB.UnitSupplierTable.state = dsInsert) or (productsDB.UnitSupplierTable.state = dsEdit) then
    productsDB.UnitSupplierTable.Post;

  inFrame := false;
end;

procedure TUnitSupplierFrame.FrameEnter(Sender: TObject);
begin
  inFrame := true;
end;

// Called when user clicks on the 'boolean' field in the grid, i.e. the default purchase
// unit column.
procedure TUnitSupplierFrame.FlexiDBGrid1ToggleBooleanField(
  Sender: TObject);
begin
  SetDefaultPurchaseUnitActionExecute( Sender );
end;

// Don't allow any new entries in the supplier table if the user has not set the
// purchase unit.
procedure TUnitSupplierFrame.UnitSupplierTableAfterInsert(DataSet: TDataSet);
begin
  if productsDB.supplierStringList.Count = 0 then begin
    productsDB.ClientEntityTablePurchaseUnit.FocusControl;
    ShowMessage( 'There are currently no suppliers configured in the system.'#13#10+
                 'You must create at least one supplier in base data before'#13#10+
                 'attempting to setup supplier details in ' + ProductModellingTextName +'.' );
    productsDB.UnitSupplierTable.Cancel;
  end else if IsBlank( productsDB.ClientEntityTablePurchaseUnit ) then begin
    // Maybe the user has changed the stock unit in the combo box,
    // but it hasn't been committed to the dataset yet...?
    productsDB.ClientEntityTable.UpdateRecord;

    if IsBlank( productsDB.ClientEntityTablePurchaseUnit ) then begin
      productsDB.ClientEntityTablePurchaseUnit.FocusControl;
      ShowMessage( 'Please set the stock unit before adding a supplier.' );
      productsDB.UnitSupplierTable.Cancel;
    end;
  end;
end;

// Called after supplier table is put into edit mode.
procedure TUnitSupplierFrame.UnitSupplierTableAfterEdit(DataSet: TDataSet);
begin
  preEditSupplierName := productsDB.UnitSupplierTableSupplierName.AsVariant;
  preEditUnitName := productsDB.UnitSupplierTableUnitName.AsVariant;
  preEditFlavour := productsDB.UnitSupplierTableFlavour.AsString;
end;

// Called after posting data to the unit supplier table.
procedure TUnitSupplierFrame.UnitSupplierTableAfterPost(DataSet: TDataSet);
begin
  if not DataSet.ControlsDisabled then
    refreshSupplierInfo( true );

  FPendingChangesExist := True;
end;

// Called if the data in the unit supplier table changes.
procedure TUnitSupplierFrame.UnitSupplierTableDataChange(Sender: TObject; Field: TField);
begin
  if (productsDB.UnitSupplierTable.State = dsEdit) and
     (field <> nil) and not productsDB.UnitSupplierTable.ControlsDisabled then begin
    // Make sure modifications to the table get written immediately, so that
    // the budgeted cost price is updated.
    productsDB.UnitSupplierTable.DisableControls;
    try try
      silentPostFail := true;
      productsDB.UnitSupplierTable.Post;
      refreshSupplierInfo( true );
    except else
      Log.Event('UnitSupplierTableDataChange - Error updating UnitSupplier Table.');
      // Do nothing
    end finally
      silentPostFail := false;
      productsDB.UnitSupplierTable.EnableControls;
    end;
  end;
end;

procedure TUnitSupplierFrame.AddSupplierActionExecute(Sender: TObject);
begin
  productsDB.UnitSupplierTable.Insert;
  if productsDB.UnitSupplierTable.State = dsInsert then begin
    ProductsDB.UnitSupplierTable.FieldByName('Entity Code').Value := ProductsDB.ClientEntityTableEntityCode.Value;
    FlexiDBGrid1.SelectedField := productsDB.UnitSupplierTableSupplierName;
    PrizmSetFocus( FlexiDBGrid1 );
    FlexiDBGrid1.ShowEditorPickList;
  end;
end;

procedure TUnitSupplierFrame.AddSupplierActionUpdate(Sender: TObject);
begin
  AddSupplierAction.Enabled := not FIsFutureCostPrice;
end;

function TUnitSupplierFrame.getSoleSupplier: string;
begin
  Result := soleSupplier;
end;

function TUnitSupplierFrame.isSoleSupplier: boolean;
begin
  Result := Length( soleSupplier ) > 0;
end;

procedure TUnitSupplierFrame.SetEnabledProperties;
var
  Index: Integer;
begin
  with FlexiDBGrid1 do
  begin
    for Index := 0 to Columns.Count - 1 do
    begin
      if Columns[Index].FieldName <> 'Unit Cost' then
      begin
        Columns[Index].ReadOnly := FIsFutureCostPrice;
        case FIsFutureCostPrice of
          True: Columns[Index].Font.Color := clGraytext;
          False: Columns[Index].Font.Color := clWindowtext;
        end;
      end
    end;
  end;
end;

procedure TUnitSupplierFrame.SetIsFutureCostPrice(const Value: Boolean);
begin
  FIsFutureCostPrice := Value;

  SetEnabledProperties;
end;

procedure TUnitSupplierFrame.SetEffectiveDate(const Value: string);
begin
  FEffectiveDate := Value;
end;

end.
