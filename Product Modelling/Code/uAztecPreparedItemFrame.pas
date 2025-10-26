unit uAztecPreparedItemFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, uAztecDBComboBox, uPortionIngredients, uDatabaseADO,
  wwdbedit;

type
  TAztecPreparedItemFrame = class(TFrame)
    lblPreparationBatch: TLabel;
    dbEditBatchSize: TwwDBEdit;
    cbBatchUnit: TAztecDBComboBox;

    lblStorageCountUnit: TLabel;
    cbStorageUnit: TAztecDBComboBox;

    PortionIngredientsFrame: TPortionIngredientsFrame;

    lblNotes: TLabel;
    dbMemoNotes: TDBMemo;

    btnInsertIngredient: TButton;
    btnDeleteIngredient: TButton;
    btnEditIngredient: TButton;
    btnAppendIngredient: TButton;
    Label1: TLabel;
    procedure CreateNewUnit(Sender: TObject);
  private
    procedure EnsureAztecPortionExists(Sender: TObject);
  public
    procedure ValidateData;
    procedure onEntityStateChange(et: EntType);
    procedure SetupStaticPickLists;
    procedure InitialiseFromAnotherProduct(baseEntityCode: Double);
    procedure ConfigureGrid;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses DB, uGuiUtils, uMaintUnit, uADO, ADODB;

constructor TAztecPreparedItemFrame.Create(AOwner: TComponent);
begin
  inherited;

  PortionIngredientsFrame.BeforeIngredientAdded := EnsureAztecPortionExists;
  { Don't allow ingredient quantities to be expressed as Portions, only unit types (e.g. litres) can
    be used with prepared items }
  PortionIngredientsFrame.AllowFactorQuantities := FALSE;
  ConfigureGrid;
end;

procedure TAztecPreparedItemFrame.ConfigureGrid;
begin
  PortionIngredientsFrame.IngredientsGrid.Selected.Add('IsMinor'+#9+InttoStr(5)+#9+'Is Minor'+#9+'T'+#9);
  PortionIngredientsFrame.IngredientsGrid.ControlType.Add('IsMinor;CheckBox;True;False');
end;

procedure TAztecPreparedItemFrame.EnsureAztecPortionExists(Sender: TObject);
begin
  ProductsDB.CreatePreparedItemPortionIfNecessary;
end;

procedure TAztecPreparedItemFrame.InitialiseFromAnotherProduct(baseEntityCode: Double);
var ADODataset: TADODataset;
begin
  with ProductsDb do
  begin
    ADODataset := TADODataset.Create(nil);
    try
      ADODataset.Connection := dmADO.AztecConn;
      ADODataset.CommandType := cmdText;

      ADODataset.CommandText := 'SELECT * FROM PreparedItemDetail WHERE EntityCode = ' + FloatToStr(baseEntityCode);
      ADODataset.Open;
      if not ADODataset.EOF then
      begin
        tblPreparedItemDetails.Edit;
        tblPreparedItemDetailsStorageUnit.Value := ADODataset.FieldByName('StorageUnit').Value;
        tblPreparedItemDetailsBatchUnit.Value := ADODataset.FieldByName('BatchUnit').Value;
        tblPreparedItemDetailsBatchSize.Value := ADODataset.FieldByName('BatchSize').Value;
        tblPreparedItemDetailsNotes.Value := ADODataset.FieldByName('Notes').Value;
      end;
      ADODataset.Close;

      ADODataset.CommandText := Format(
        'SELECT * FROM PortionIngredients ' +
        'WHERE PortionID = (SELECT TOP 1 PortionID FROM Portions WHERE EntityCode = %0:f AND PortionTypeID = %1:d) ' +
        'ORDER BY DisplayOrder',
        [baseEntityCode, DefaultPortionTypeID]);

      ADODataset.Open;
      if not(ADODataset.EOF) then
      begin
        EnsureAztecPortionExists(nil);

        while not(ADODataset.EOF) do
        begin
          IngredientsQuery1.Append;
          IngredientsQuery1PortionID.Value             := PortionsQuery1.FieldByName('PortionId').Value;
          IngredientsQuery1IngredientCode.Value        := ADODataset.FieldByName('IngredientCode').Value;
          IngredientsQuery1UnitName.Value              := ADODataset.FieldByName('UnitName').Value;
          IngredientsQuery1Quantity.Value              := ADODataset.FieldByName('Quantity').Value;
          IngredientsQuery1DisplayOrder.Value          := ADODataset.FieldByName('DisplayOrder').Value;
          IngredientsQuery1IsMinor.Value               := ADODataset.FieldByName('IsMinor').Value;
          IngredientsQuery1CalculationType.Value       := ord(calcUnit);
          ADODataset.Next;
        end;
      end;
    finally
      ADODataset.Free;
    end;
  end;
end;


procedure TAztecPreparedItemFrame.ValidateData;
begin
  with productsDB.tblPreparedItemDetails do
  begin
    if IsBlank(FieldByName('BatchUnit')) then
    begin
      PrizmSetFocus(cbBatchUnit);
      ShowMessage('Cannot have a blank Preparation Batch unit');
      Abort;
    end;

    if IsBlank(FieldByName('BatchSize')) then
    begin
      PrizmSetFocus(dbEditBatchSize);
      ShowMessage('Cannot have a blank Preparation Batch quantity');
      Abort;
    end;

    if IsBlank(FieldByName('StorageUnit')) then
    begin
      PrizmSetFocus(cbStorageUnit);
      ShowMessage('Cannot have a blank Storage Count unit');
      Abort;
    end;

    if not FieldMatchesPickList(FieldByName('BatchUnit') as TStringField, productsDB.validUnitsStringList, FALSE) then
    begin
      PrizmSetFocus(cbBatchUnit);
      ShowMessage('''' + FieldByName('BatchUnit').Value +  ''' is not a valid unit name.' );
      Abort;
    end;

    if not FieldMatchesPickList(FieldByName('StorageUnit') as TStringField, productsDB.validUnitsStringList, FALSE) then
    begin
      PrizmSetFocus(cbStorageUnit);
      ShowMessage('''' + FieldByName('StorageUnit').Value + ''' is not a valid unit name.' );
      Abort;
    end;

    if not ProductsDB.unitsHaveSameBaseType(FieldByName('BatchUnit').Value, FieldByName('StorageUnit').Value) then
    begin
      PrizmSetFocus(cbBatchUnit);
      ShowMessage('The Preparation Batch unit is not compatible with the Storage Count unit');
      Abort;
    end;
  end; { with productsDB.tblPreparedItemDetails }
end; { procedure ValidateData }

procedure TAztecPreparedItemFrame.SetupStaticPickLists;
begin
  setComboBoxItems(cbBatchUnit, productsDB.validUnitsStringList);
  setComboBoxItems(cbStorageUnit, productsDB.validUnitsStringList);
end;

procedure TAztecPreparedItemFrame.CreateNewUnit(Sender: TObject);
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

procedure TAztecPreparedItemFrame.onEntityStateChange(et: EntType);
begin
  SetupStaticPickLists;
end;

end.
