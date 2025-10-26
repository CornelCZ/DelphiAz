unit uPortionIngredientDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, DB, ADODB, wwdbedit, Buttons, uDatabaseADO,
  wwcheckbox;

type

  TPortionIngredientDialog = class(TForm)
    IngredientNameLabel: TLabel;
    IngredientTypeLabel: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    UnitNameComboBox: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    QuantityDBEdit: TwwDBEdit;
    OkButton: TBitBtn;
    CancelButton: TBitBtn;
    lblTitle: TLabel;
    Label6: TLabel;
    CalcTypeComboBox: TComboBox;
    PortionTypeNameQry: TADOQuery;
    SupportedPortionsQry: TADOQuery;
    PortionTypeIDQry: TADOQuery;
    btnPreviousPortion: TBitBtn;
    btnNextPortion: TBitBtn;
    MinorIngredientLbl: TLabel;
    MinorIngredientChkBx: TwwCheckBox;
    procedure CalcTypeComboBoxSelect(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPreviousPortionClick(Sender: TObject);
    procedure btnNextPortionClick(Sender: TObject);
  private
    { Private declarations }
    CalculationType: TCalculationType;
    IngredientCode: double;
    IngredientType: EntType;
    IngredientStockUnit: string;
    FNextPressed: boolean;
    FPrevPressed: boolean;
    FParentType: EntType;
    FNegativeQuantityAllowed: boolean;

    procedure SetCommonDetails(ingredient_Code: double; calculation_type: smallint;
                               AllowFactorQuantities: boolean; ParentType: EntType);
    procedure SetCalcTypeValue(calculation_type: smallint);
    procedure SetCalcTypeList(AllowFactorQuantities: boolean);
    procedure SetUnitNameList;
    function GetPortionTypeName(portion_type_id: integer): string;
    function MandatoryFieldsComplete: boolean;
    procedure SetTitle(const Value: string);
    procedure SetAllowPortionNavigation(const Value: boolean);
    function ValidateUserInput: boolean;
    function ValidateQuantity: boolean;
    function ValidateMinorIngredient: boolean;
  public
    { Public declarations }

    SelectedPortionTypeID: integer;
    EffectiveDate: string;

    // called from PortionIngredients.EditIngredientAction
    procedure setIngredientDetails(ingredient_Code: double;
                                   unit_name: string;
                                   portion_type_id: integer;
                                   qty: double;
                                   calculation_type: smallint;
                                   AllowFactorQuantities: boolean;
                                   ParentType: EntType;
                                   isMinor : boolean); overload;
    // called from PortionIngredients.Insert or AppendIngredientAction
    procedure setIngredientDetails(ingredient_Code: double; AllowFactorQuantities: boolean; ParentType: EntType; isMinor: Boolean); overload;
    function getUnitName: variant;
    function getPortionTypeID: variant;
    function getQuantity: Double;
    function getCalculationType: smallint;
    function getIsMinor: boolean;
    function childIsValidForMinorIngredients : boolean;
    function parentIsValidForMinorIngredients : boolean;
    function addingStdLineToItself : Boolean;
    property Title: string write SetTitle;
    property AllowPortionNavigation: boolean write SetAllowPortionNavigation;
    property NextPressed: boolean read FNextPressed;
    property PrevPressed: boolean read FPrevPressed;
  end;

var
  PortionIngredientDialog: TPortionIngredientDialog;


implementation

uses uADO, uGlobals, StrUtils;

{$R *.dfm}

// called from PortionIngredients.EditIngredientAction
procedure TPortionIngredientDialog.setIngredientDetails(ingredient_Code: double;
                                                        unit_name: string;
                                                        portion_type_id: integer;
                                                        qty: double;
                                                        calculation_type : smallint;
                                                        AllowFactorQuantities: boolean;
                                                        ParentType: EntType;
                                                        isMinor : boolean);
begin
  SetCommonDetails(ingredient_Code, calculation_type, AllowFactorQuantities, ParentType);

  if CalculationType = calcUnit then
    UnitNameComboBox.ItemIndex := UnitNameComboBox.Items.IndexOf(unit_name)
  else if CalculationType = calcPortion then
    UnitNameComboBox.ItemIndex := UnitNameComboBox.Items.IndexOf(GetPortionTypeName(portion_type_id));

  QuantityDBEdit.Text := FloatToStr(qty);
  MinorIngredientChkBx.Checked := isMinor;
end;

// called from PortionIngredients.Insert or AppendIngredientAction
procedure TPortionIngredientDialog.setIngredientDetails(ingredient_Code: double;
                                                        AllowFactorQuantities: boolean;
                                                        ParentType: EntType;
                                                        isMinor : boolean);
begin
  setCommonDetails(ingredient_Code, ord(calcUnspecified), AllowFactorQuantities, ParentType);
  UnitNameComboBox.Text := '';
  QuantityDBEdit.Text := '';
  MinorIngredientChkBx.Checked := false;
end;

procedure TPortionIngredientDialog.SetCommonDetails(ingredient_Code: double; calculation_type: smallint;
                                                    AllowFactorQuantities: boolean; ParentType: EntType);
begin
  IngredientCode := ingredient_Code;
  FParentType := ParentType;
  FNegativeQuantityAllowed := (FParentType in [etStrdLine, etRecipe]);

  if IngredientCode = ProductsDB.ClientEntityTableEntityCode.Value then begin
    //The ingredient is the same as the parent product (i.e. this is a standard product).
    //Take all details from the current record of the ClientEntityTableDataset.
      IngredientNameLabel.Caption := ProductsDB.ClientEntityTableExtendedRTLName.Value;
      IngredientType := ProductsDB.CurrentEntityType;
      IngredientStockUnit := ProductsDB.ClientEntityTablePurchaseUnit.Value;
  end else begin
    //Look up the product in the EntityTable dataset.
    if ProductsDB.EntityTableLookup(IngredientCode) then begin
      IngredientNameLabel.Caption := ProductsDB.EntityTableExtendedRTLName.Value;
      IngredientType := EntTypeStringToEnum( ProductsDB.EntityTableEntityType.Value );
      if IngredientType = etPrepItem then
        IngredientStockUnit := ProductsDB.GetAztecPreparedItemBatchUnit(IngredientCode)
      else
        IngredientStockUnit := ProductsDB.EntityTablePurchaseUnit.Value;
    end else begin
      // this should never happen
      raise Exception.Create('EntityTableLookup cannot locate the selected ingredient');
    end;
  end;

  //Make sure the Stock Unit i.e. Products.[Purchase Unit] is not null if a Standard, Purchase or Prepared product.
  // If it is then something has gone wrong, either with the program or the data.
  assert(not(IngredientType in [etStrdLine, etPurchLine, etPrepItem]) or (IngredientStockUnit <> ''),
         'Ingredient ('+FloatToStr(IngredientCode)+') Stock Unit is null');

  IngredientTypeLabel.Caption := EntTypeEnumToDisplayString(IngredientType);
  SetCalcTypeList(AllowFactorQuantities);
  SetCalcTypeValue(calculation_type);

  // if there is only one calculation type available to the ingredient then
  // set this as the selected calculation type before filling the UnitNameComboBox
  // dropdown list
  if CalcTypeComboBox.Items.Count = 1 then
  begin
    CalcTypeComboBox.ItemIndex := 0;
    CalculationType := CalcTypeStringToEnum(CalcTypeComboBox.Text);
  end
  else if CalcTypeComboBox.Items.Count > 1 then
  begin
    CalcTypeComboBox.ItemIndex := CalcTypeComboBox.Items.IndexOf(CalcTypeEnumToString(CalculationType));
  end;

  SetUnitNameList;
end;

procedure TPortionIngredientDialog.SetUnitNameList;
begin
  UnitNameComboBox.Clear;
  case CalculationType of
    calcUnit:
      begin
        UnitNameComboBox.Items := productsDB.getUnitsWithSameBaseType(IngredientStockUnit, false);
        UnitNameComboBox.Enabled := true;
      end;
    calcPortion:
      begin
        with SupportedPortionsQry do
        begin
          Parameters.ParamByName('parentEntityCode').Value := IngredientCode;
          Open;
          First;
          while not Eof do
          begin
            UnitNameComboBox.Items.Add(FieldByName('PortionTypeName').AsString);
            Next;
          end;
          Close;
          UnitNameComboBox.Enabled := true;
        end;
      end;
    calcFactor, calcUnspecified:
      UnitNameComboBox.Enabled := false;
  end;
end;

// set the quantity calculation type (UnitType) list according to the Ingredient
// EntityType
procedure TPortionIngredientDialog.SetCalcTypeList(AllowFactorQuantities: boolean);
var
  OwnProd: Boolean;
begin
  CalcTypeComboBox.Clear;

  //TODO: Would be better (cleaner) if the parent entity code was passed in, like the parent entity type is. GDM
  OwnProd := (IngredientCode = ProductsDB.ClientEntityTableEntityCode.Value);

  case FParentType of
    etChoice:
      case IngredientType of
        etChoice, etRecipe, etStrdLine:
          CalcTypeComboBox.Items.Add(PORTIONTYPE);
      end;
    etPrepItem:
      case IngredientType of
        etPrepItem, etPurchLine, etStrdLine:
          CalcTypeComboBox.Items.Add(UNITTYPE);
      end;
    etRecipe, etStrdLine:
      case IngredientType of
        etChoice, etRecipe:
          CalcTypeComboBox.Items.Add(PORTIONTYPE);
        etPrepItem, etPurchLine:
          CalcTypeComboBox.Items.Add(UNITTYPE);
        etStrdLine:
          begin
            if not OwnProd then
              CalcTypeComboBox.Items.Add(PORTIONTYPE);
            CalcTypeComboBox.Items.Add(UNITTYPE);
          end;
      end;
  end; { case }

  if AllowFactorQuantities then
    CalcTypeComboBox.Items.Add(FACTORTYPE);

  CalcTypeComboBox.Enabled := (CalcTypeComboBox.Items.Count > 1);
end;


procedure TPortionIngredientDialog.CalcTypeComboBoxSelect(Sender: TObject);
begin
  with Sender as TComboBox do
  begin
    if Text = UNITTYPE then
      CalculationType := calcUnit
    else if Text = PORTIONTYPE then
      CalculationType := calcPortion
    else if Text = FACTORTYPE then
      CalculationType := calcFactor
    else
      CalculationType := calcUnSpecified;
  end;

  SetUnitNameList;
end;

function TPortionIngredientDialog.MandatoryFieldsComplete: boolean;
begin
  Result := True;

  case CalculationType of
    calcUnit, calcPortion:
      begin
        Result := not ( (UnitNameComboBox.Text = '') or (QuantityDBEdit.Text = '') );
      end;
    calcFactor:
      begin
        Result := not (QuantityDBEdit.Text = '');
      end;
    calcUnspecified:
      begin
        if IngredientType = etInstruct then
          Result := not (QuantityDBEdit.Text = '')
        else
          Result := False;
      end;
  end;
end;

procedure TPortionIngredientDialog.SetCalcTypeValue(calculation_type: smallint);
begin
  case calculation_type of
    ord(calcUnspecified) : CalculationType := calcUnspecified;
    ord(calcUnit)        : CalculationType := calcUnit;
    ord(calcPortion)     : CalculationType := calcPortion;
    ord(calcFactor)      : CalculationType := calcFactor;
  else
    CalculationType := calcUnspecified;
  end;
end;

function TPortionIngredientDialog.GetPortionTypeName(portion_type_id: integer): string;
var
  portion_type_name: string;
begin
  portion_type_name := '';
  with PortionTypeNameQry do
  begin
    Parameters.ParamByName('portion_type_id').Value := portion_type_id;
    Open;
    First;
    portion_type_name := FieldByName('PortionTypeName').AsString;
    Close;
  end;
  Result := portion_type_name;
end;


function TPortionIngredientDialog.ValidateQuantity: boolean;
const
   MaxDigitsBeforePoint = 6;
   MaxDigitsAfterPoint = 4;
   ValidChars = ['0'..'9', '.'];
var
  qtyStr: string;
  qty: double;
  digitsBeforePoint,
  digitsAfterPoint: integer;
  dpCount, dpPosition: integer;
  i: integer;
begin
  Result := False;
  qtyStr := QuantityDBEdit.Text;

  //Remove the minus sign if there is one
  if qtyStr[1] = '-' then
    qtyStr := copy(qtyStr, 2, length(qtyStr) - 1);

  //Remove any leading zeros
  while (qtyStr[1] = '0') and (length(qtyStr) > 1) do
    qtyStr := copy(qtyStr, 2, length(qtyStr) - 1);

  dpCount := 0;
  for i := 1 to length(qtyStr) do
  begin
    if qtyStr[i] = '.' then
      dpCount := dpCount + 1;

    if not(qtyStr[i] in ValidChars) or (dpCount > 1) then
    begin
      ShowMessage('Quantity is not a valid number');
      Exit;
    end;
  end;

  dpPosition := pos('.', qtyStr);

  if dpPosition = 0 then
  begin
    digitsBeforePoint := length(qtyStr);
    digitsAfterPoint := 0;
  end
  else
  begin
    digitsBeforePoint := dpPosition - 1;
    digitsAfterPoint := length(qtyStr) - digitsBeforePoint - 1;
  end;

  if digitsBeforePoint > MaxDigitsBeforePoint then
  begin
    ShowMessage('Quantity is too large. Largest value is 999999.9999');
    Exit;
  end;

  if digitsAfterPoint > MaxDigitsAfterPoint then
  begin
    ShowMessage('Quantity has too many digits after the decimal point. Maximum is ' + IntToStr(MaxDigitsAfterPoint));
    Exit;
  end;


  qty := getQuantity;

  case IngredientType of
    etInstruct:
      begin
        if (qty <> 0) and (qty <> 1) then
        begin
          ShowMessage('Only quantities of 0 or 1 are valid for an instruction');
          Exit;
        end;
      end;

    etChoice:
      if (qty < 0) then
      begin
        ShowMessage('A negative quantity is not valid for a choice');
        Exit;
      end else if (qty <> Trunc(qty)) then
      begin
        ShowMessage('Only whole number quantities are valid for a choice');
        Exit;
      end;
  end;

  if not(FNegativeQuantityAllowed) and (qty < 0) then
  begin
    ShowMessage('Negative ingredients are only allowed in Recipes and Standard Lines');
    Exit;
  end;

  Result := True;
end;

function TPortionIngredientDialog.ValidateMinorIngredient: boolean;
var
  quantity: double;
  isMinor: boolean;
  ingredientPortionTypeID: variant;
  entityCode: double;

  usedAsMinorIngredient: boolean;
  usedAsNegativeQuantityIngredient: boolean;
  containsMinorIngredient: boolean;
  containsNegativeQuantityIngredient: boolean;

  usedAsMinorIngredientInTheFuture: boolean;
  usedAsNegativeQuantityIngredientInTheFuture: boolean;
  containsMinorIngredientInTheFuture: boolean;
  containsNegativeQuantityIngredientInTheFuture: boolean;
begin
  Result := False;

  quantity := getQuantity;
  isMinor := getIsMinor;

  if isMinor and (quantity < 0) then
  begin
    ShowMessage('The quantity cannot be negative while the ingredient is set to minor');
    Exit;
  end;

  ingredientPortionTypeID := getPortionTypeID;
  entityCode := ProductsDB.ClientEntityTableEntityCode.Value;

  with ProductsDB.GetPortionHierarchyFlags(entityCode, SelectedPortionTypeId, IngredientCode, ingredientPortionTypeID, EffectiveDate) do
  try
    usedAsMinorIngredient := FieldByName('UsedAsMinorIngredient').AsBoolean;
    usedAsNegativeQuantityIngredient := FieldByName('UsedAsNegativeQuantityIngredient').AsBoolean;
    containsMinorIngredient := FieldByName('ContainsMinorIngredient').AsBoolean;
    containsNegativeQuantityIngredient := FieldByName('ContainsNegativeQuantityIngredient').AsBoolean;

    usedAsMinorIngredientInTheFuture := FieldByName('UsedAsMinorIngredientInTheFuture').AsBoolean;
    usedAsNegativeQuantityIngredientInTheFuture := FieldByName('UsedAsNegativeQuantityIngredientInTheFuture').AsBoolean;
    containsMinorIngredientInTheFuture := FieldByName('ContainsMinorIngredientInTheFuture').AsBoolean;
    containsNegativeQuantityIngredientInTheFuture := FieldByName('ContainsNegativeQuantityIngredientInTheFuture').AsBoolean;
  finally
    Close;
  end;

  if isMinor then
  begin
    if containsNegativeQuantityIngredient then
    begin
      ShowMessage('The ingredient cannot be set to minor as the selected portion contains negative quantity ingredients');
      Exit;
    end;

    if usedAsNegativeQuantityIngredient then
    begin
      ShowMessage('The ingredient cannot be set to minor as it is used as a negative quantity ingredient');
      Exit;
    end;

    if containsNegativeQuantityIngredientInTheFuture then
    begin
      ShowMessage('The ingredient cannot be set to minor as the selected portion contains negative quantity ingredients, in a future portion');
      Exit;
    end;

    if usedAsNegativeQuantityIngredientInTheFuture then
    begin
      ShowMessage('The ingredient cannot be set to minor as it is used as a negative quantity ingredient, in a future portion');
      Exit;
    end;
  end;

  if (quantity < 0) then
  begin
    if containsMinorIngredient then
    begin
      ShowMessage('The ingredient cannot have a negative quantity as the selected portion contains minor ingredients');
      Exit;
    end;

    if usedAsMinorIngredient then
    begin
      ShowMessage('The ingredient cannot have a negative quantity as it is used as a minor ingredient');
      Exit;
    end;

    if containsMinorIngredientInTheFuture then
    begin
      ShowMessage('The ingredient cannot have a negative quantity as the selected portion contains minor ingredients, in a future portion');
      Exit;
    end;

    if usedAsMinorIngredientInTheFuture then
    begin
      ShowMessage('The ingredient cannot have a negative quantity as it is used as a minor ingredient, in a future portion');
      Exit;
    end;
  end;

  Result := True;
end;

function TPortionIngredientDialog.ValidateUserInput: boolean;
begin
  Result := False;

  if not MandatoryFieldsComplete then
  begin
    ShowMessage('Not all mandatory fields have been completed!');
    Exit;
  end;

  if not ValidateQuantity then
    Exit;

  if not ValidateMinorIngredient then
    Exit;

  Result := True;
end;

procedure TPortionIngredientDialog.OkButtonClick(Sender: TObject);
begin
  if ValidateUserInput then
    ModalResult := mrOk
end;

function TPortionIngredientDialog.getUnitName: variant;
begin
  Result := null;
  case CalculationType of
    calcUnit:
      Result := UnitNameComboBox.Text;
  end;
end;

function TPortionIngredientDialog.getPortionTypeID: variant;
begin
  Result := null;
  case CalculationType of
    calcPortion:
      begin
        with PortionTypeIDQry do
        begin
          Parameters.ParamByName('portion_type_name').Value := UnitNameComboBox.Text;
          Open;
          First;
          Result := FieldByName('PortionTypeID').AsInteger;
          Close;
        end;
      end;
  end;
end;

function TPortionIngredientDialog.getCalculationType: smallint;
begin
  Result := ord(CalculationType);
end;

function TPortionIngredientDialog.getQuantity: Double;
begin
  Result := StrToFloat(QuantityDBEdit.Text);
end;

function TPortionIngredientDialog.getIsMinor : Boolean;
begin
  Result := MinorIngredientChkBx.Checked;
end;

procedure TPortionIngredientDialog.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_ADD_EDIT_AZTEC_INGREDIENT );

  FNextPressed := False;
  FPrevPressed := False;

  if IngredientType = etInstruct then
  begin
    QuantityDBEdit.SetFocus;
  end
  else
  begin
    if CalcTypeComboBox.Items.Count = 1 then
      UnitNameComboBox.SetFocus
    else if CalcTypeComboBox.Items.Count > 1 then
      CalcTypeComboBox.SetFocus;
  end;

  MinorIngredientLbl.Visible := (childIsValidForMinorIngredients and parentIsValidForMinorIngredients) and not addingStdLineToItself;
  MinorIngredientChkBx.Visible := (childIsValidForMinorIngredients and parentIsValidForMinorIngredients) and not addingStdLineToItself;
end;

function TPortionIngredientDialog.childIsValidForMinorIngredients : Boolean;
begin
  Result := (IngredientType = etPurchLine) or (IngredientType = etStrdLine);
end;

function TPortionIngredientDialog.parentIsValidForMinorIngredients : Boolean;
begin
  Result := (FParentType = etPrepItem) or (FParentType = etRecipe) or (FParentType = etStrdLine);
end;

function TPortionIngredientDialog.addingStdLineToItself : Boolean;
begin
  Result := IngredientCode = ProductsDB.ClientEntityTableEntityCode.Value;
end;

procedure TPortionIngredientDialog.SetTitle(const Value: string);
begin
  lblTitle.Caption := Value;
end;

procedure TPortionIngredientDialog.btnPreviousPortionClick(Sender: TObject);
begin
  if ValidateUserInput then
  begin
    FPrevPressed := True;
    ModalResult := mrOk;
  end;
end;

procedure TPortionIngredientDialog.btnNextPortionClick(Sender: TObject);
begin
  if ValidateUserInput then
  begin
    FNextPressed := True;
    ModalResult := mrOk;
  end;
end;

procedure TPortionIngredientDialog.SetAllowPortionNavigation(const Value: boolean);
begin
  btnPreviousPortion.Visible := Value;
  btnNextPortion.Visible := Value;
end;

end.
