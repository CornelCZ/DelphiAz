unit uMaintUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfMaintUnit = class(TForm)
    Label1: TLabel;
    edtUName: TEdit;
    edtUSize: TEdit;
    cmbbxBaseUnit: TComboBox;
    nameLabel: TLabel;
    AmountLabel: TLabel;
    UnitTypeLabel: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    DescriptionLabel: TLabel;
    UnitDescriptionMemo: TMemo;
    DefinedByUnitComboBox: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbbxBaseUnitChange(Sender: TObject);
    procedure BuildDefinedByList(BaseTypeID: Integer);
    procedure ClearDefinedByList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TBaseObject = class(TObject)
    BaseID: Integer;
    BaseType: string;
    BaseUnit: string;
  end;

  TUnitObject = class(TObject)
    Name: String;
    UnitID: Integer;
    //BaseType: string;
    //BaseUnit: string;
  end;

var
  fMaintUnit: TfMaintUnit;

implementation

{$R *.dfm}

uses uADO, uDatabaseADO, uLineEdit, uLog, uGlobals, DB;

procedure TfMaintUnit.FormShow(Sender: TObject);
var
  TempObj: TBaseObject;
begin
  setHelpContextID( self, AZPM_NEW_UNIT_FORM );

  cmbbxBaseUnit.Clear;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ac_UnitType');
    Open;

    while not Eof do
    begin
      TempObj := TBaseObject.Create;
      TempObj.BaseID   := FieldByName('Id').AsInteger;
      TempObj.BaseType := FieldByName('Name').AsString;
      TempObj.BaseUnit := FieldByName('Unit').AsString;

      cmbbxBaseUnit.Items.AddObject(TempObj.BaseType + ' (' +
        TempObj.BaseUnit + ')', TempObj);

      Next;
    end;

    Close;
  end;
end;

procedure TfMaintUnit.btnOKClick(Sender: TObject);
var
  BaseType, BaseUnit: String;
  DefinedByUnit: String;
  BaseTypeID: Integer;
  et: EntType;
  Description: String;
begin
  if edtUName.Text = '' then
  begin
    ShowMessage('Please supply a unit name.');
    edtUName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  try
    StrToFloat(edtUSize.Text);
  except
    ShowMessage('Please enter a valid unit size.');
    edtUSize.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if cmbbxBaseUnit.ItemIndex = -1 then
  begin
    ShowMessage('Please select a base unit.');
    cmbbxBaseUnit.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  BaseType := TBaseObject(cmbbxBaseUnit.Items.Objects[cmbbxBaseUnit.ItemIndex]).BaseType;
  BaseUnit := TBaseObject(cmbbxBaseUnit.Items.Objects[cmbbxBaseUnit.ItemIndex]).BaseUnit;
  BaseTypeID := TBaseObject(cmbbxBaseUnit.Items.Objects[cmbbxBaseUnit.ItemIndex]).BaseID;
  if DefinedByUnitComboBox.ItemIndex <> -1 then
    DefinedByUnit := InttoStr(TUnitObject(DefinedByUnitComboBox.Items.Objects[DefinedByUnitComboBox.ItemIndex]).UnitID)
  else
    DefinedByUnit := 'null';

  if UnitDescriptionMemo.Text = '' then
    Description := 'null'
  else
    Description := QuotedStr(UnitDescriptionMemo.Text);

  with dmADO.adoqRun do
  begin
    Log.Event('Create Unit - ' + QuotedStr(edtUName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertUnit %s,%s,%d,%s,%s,@ID OUTPUT',
            [QuotedStr(edtUName.Text),Description,
             BaseTypeID,edtUSize.Text,DefinedByUnit]));
    try
      ExecSQL;
      Close;

      SQL.Clear;
      SQL.Add('SELECT [Unit Name], [Base Units], [Base Type]');
      SQL.Add('FROM Units');
      SQL.Add('WHERE [Unit Name] = ' + QuotedStr(edtUName.Text));
      Open;

      if not EOF then
        ProductsDB.AddNewUnit(edtUName.Text,
                              FieldByName('Base Type').AsString,
                              FieldByName('Base Units').AsFloat);
    except
      on E:Exception do
      begin
        log.Event('Create Unit Failure - ' + E.Message);
        MessageDlg('Failed to create unit: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;

 { TODO (Code review): This is a nasty dependency. How about adding RefreshUnits and addUnitsChangeListener methods to
   ProductsDB and create an interface UnitsChangeListener which the various GUI forms can implement
   with a single method called HandleChangedUnits. }
  et := EntTypeStringToEnum( productsDB.ClientEntityTableEntityType.Value );

  // Entity-type specific responses to state change.
  case et of
    etPurchLine, etStrdLine:
      begin
        LineEditForm.SupplierInfoFrame.onEntityStateChange( et );
        LineEditForm.SupplierInfoFrame.UnitSupplierFrame.onEntityDataChange( et, nil );
      end;
    etPrepItem:
      LineEditForm.AztecPreparedItemFrame.onEntityStateChange(et);
  end;
end;

procedure TfMaintUnit.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to cmbbxBaseUnit.Items.Count - 1 do
    TBaseObject(cmbbxBaseUnit.Items.Objects[i]).Free;
end;

procedure TfMaintUnit.cmbbxBaseUnitChange(Sender: TObject);
var
  BaseObject: TBaseObject;
begin
  with Sender as TComboBox do
  begin
    BaseObject := TBaseObject(Items.Objects[cmbbxBaseUnit.ItemIndex]);
    BuildDefinedByList(BaseObject.BaseID);
  end;
end;

procedure TfMaintUnit.BuildDefinedByList(BaseTypeID: Integer);
var
  TempObj: TUnitObject;
begin
  ClearDefinedByList;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ac_Unit where [UnitType] = ' + IntToStr(BaseTypeID));
    Open;

    while not Eof do
    begin
      TempObj := TUnitObject.Create;
      TempObj.Name := FieldByName('Name').AsString;
      TempObj.UnitID := FieldByName('Id').AsInteger;

      DefinedByUnitComboBox.Items.AddObject(TempObj.Name, TempObj);

      Next;
    end;

    Close;
  end;
end;

procedure TfMaintUnit.ClearDefinedByList;
var
  i: Integer;
begin
  for i := 0 to DefinedByUnitComboBox.Items.Count - 1 do
    TUnitObject(DefinedByUnitComboBox.Items.Objects[i]).Free;
  DefinedByUnitComboBox.Clear;
end;

end.
