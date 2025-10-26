unit uAddPortionPriceMapping;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  ExtCtrls, udmPromotions, wwdblook;

type
  TEditMode = (emEdit, emInsert);

  TfAddPortionPriceMapping = class(TForm)
    pnlMain: TPanel;
    pnlBottom: TPanel;
    lblSalesGroup: TLabel;
    lblTargetPortion: TLabel;
    lblSourcePortion: TLabel;
    lblCalculationType: TLabel;
    lblValue: TLabel;
    btnCancel: TButton;
    btnAdd: TButton;
    qPermissableBasePortions: TADOQuery;
    dblSaleGroup: TwwDBLookupCombo;
    dblTargetPortionType: TwwDBLookupCombo;
    dblSourcePortiontype: TwwDBLookupCombo;
    dblCalculationType: TwwDBLookupCombo;
    qPermissableTargetPortions: TADOQuery;
    dbeCalculationValue: TwwDBEdit;
    qPermissableSalesGroups: TADOQuery;
    procedure dblSaleGroupCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure dblSourcePortiontypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure dblCalculationTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeCalculationValueKeyPress(Sender: TObject; var Key: Char);
  private
    FPromotionID: Int64;
    FEditMode: TEditMode;
    FSiteCode: Integer;
    { Private declarations }
  public
    { Public declarations }
    property SiteCode: Integer read FSiteCode write FSiteCode;
    property PromotionID: Int64 read FPromotionID write FPromotionID;
    property EditMode: TEditMode read FEditMode write FEditMode;
  end;

var
  fAddPortionPriceMapping: TfAddPortionPriceMapping;

implementation

{$R *.dfm}

procedure TfAddPortionPriceMapping.dblSaleGroupCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if modified then
  begin
    dmPromotions.qEditPromoPortionPriceMapping.FieldByname('SourcePortionTypeId').Value := null;
    dblSourcePortiontype.Enabled := False;
    lblSourcePortion.Enabled := False;

    dmPromotions.qEditPromoPortionPriceMapping.FieldByname('TargetPortionTypeId').Value := null;
    dblTargetPortionType.Enabled := False;
    lblTargetPortion.Enabled := False;

    if not VarIsNull(dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value) then
    begin
      qPermissableBasePortions.Close;
      qPermissableBasePortions.Parameters.ParamValues['PromotionId'] := IntToStr(FPromotionID);
      qPermissableBasePortions.Parameters.ParamValues['SaleGroupId'] := dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value;
      qPermissableBasePortions.Open;
      dblSourcePortiontype.Enabled := True;
      lblSourcePortion.Enabled := True;
    end;
  end;
end;

procedure TfAddPortionPriceMapping.dblSourcePortiontypeCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if modified then
  begin
    dmPromotions.qEditPromoPortionPriceMapping.FieldByname('TargetPortionTypeId').Value := null;
    dblTargetPortionType.Enabled := False;
    lblTargetPortion.Enabled := False;

    if not VarIsNull(dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value) then
    begin
      qPermissableTargetPortions.Close;
      qPermissableTargetPortions.Parameters.ParamValues['PromotionId'] := IntToStr(FPromotionID);
      qPermissableTargetPortions.Parameters.ParamValues['SaleGroupId'] := dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value;
      qPermissableTargetPortions.Parameters.ParamValues['SourcePortion'] := dmpromotions.qEditPromoPortionPriceMappingSourcePortionTypeId.Value;
      if not VarIsNull(dmpromotions.qEditPromoPortionPriceMapping.FieldbyName('TargetPortionTypeId').Value) then
        qPermissableTargetPortions.Parameters.ParamValues['TargetPortion'] := dmpromotions.qEditPromoPortionPriceMappingTargetPortionTypeId.Value
      else
        qPermissableTargetPortions.Parameters.ParamValues['TargetPortion'] := null;
      qPermissableTargetPortions.Open;
      dblTargetPortionType.Enabled := True;
      lblTargetPortion.Enabled := True;
    end;
  end;
end;

procedure TfAddPortionPriceMapping.FormShow(Sender: TObject);
begin
  //Esnure pending changes are posted
  if dmPromotions.qEditPromoPortionPriceMapping.State in [dsEdit, dsInsert] then
    dmPromotions.qEditPromoPortionPriceMapping.Post;

  if FEditMode = emInsert then
  begin
    dblSourcePortionType.Enabled := False;
    lblSourcePortion.Enabled := False;

    dblTargetPortionType.Enabled := False;
    lblTargetPortion.Enabled := False;

    dmPromotions.qEditPromoPortionPriceMapping.Insert;
  end
  else begin
    dmPromotions.qEditPromoPortionPriceMapping.Edit;

    //In edit mode so setup the lookups
    qPermissableBasePortions.Close;
    qPermissableBasePortions.Parameters.ParamValues['PromotionId'] := IntToStr(FPromotionID);
    qPermissableBasePortions.Parameters.ParamValues['SaleGroupId'] := dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value;
    qPermissableBasePortions.Open;

    qPermissableTargetPortions.Close;
    qPermissableTargetPortions.Parameters.ParamValues['PromotionId'] := IntToStr(FPromotionID);
    qPermissableTargetPortions.Parameters.ParamValues['SaleGroupId'] := dmpromotions.qEditPromoPortionPriceMappingSaleGroupId.Value;
    qPermissableTargetPortions.Parameters.ParamValues['SourcePortion'] := dmpromotions.qEditPromoPortionPriceMappingSourcePortionTypeId.Value;
    qPermissableTargetPortions.Parameters.ParamValues['TargetPortion'] := dmpromotions.qEditPromoPortionPriceMappingTargetPortionTypeId.Value;
    qPermissableTargetPortions.Open;
  end;

  qPermissableSalesGroups.Close;
  qPermissableSalesGroups.Open;
end;

procedure TfAddPortionPriceMapping.dblCalculationTypeCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  //Force the nice %/£ formatting on the Calculation Value field
  if dmPromotions.qEditPromoPortionPriceMappingCalculationValue.Text <> '' then
    dmPromotions.qEditPromoPortionPriceMappingCalculationValue.Text := dmPromotions.qEditPromoPortionPriceMappingCalculationValue.Text;
end;

procedure TfAddPortionPriceMapping.FormClose(Sender: TObject;
  var Action: TCloseAction);

  function FieldIsNull(_Field: TField; Component: TWinControl): boolean;
  begin
    Result := False;
    if VarIsNull(_Field.Value) then
    begin
      MessageDlg(Format('No %s has been defined for this mapping',[_Field.DisplayLabel]), mtError, [mbOK],0);
      Component.SetFocus;
      Result := True;
    end
  end;

begin
  if (dmPromotions.qEditPromoPortionPriceMapping.State in [dsEdit, dsInsert]) and (ModalResult = mrOK) then
  begin
    if (FieldIsNull(dmPromotions.qEditPromoPortionPriceMapping.FieldByName('SaleGroupId'),dblSaleGroup)
      or FieldIsNull(dmPromotions.qEditPromoPortionPriceMapping.FieldByName('SourcePortionTypeId'),dblSourcePortiontype)
      or FieldIsNull(dmPromotions.qEditPromoPortionPriceMapping.FieldByName('TargetPortionTypeId'),dblTargetPortionType)
      or FieldIsNull(dmPromotions.qEditPromoPortionPriceMapping.FieldByName('CalculationType'),dblCalculationType)
      or FieldIsNull(dmPromotions.qEditPromoPortionPriceMapping.FieldByName('CalculationValue'),dbeCalculationValue)) then
    begin
      Abort
    end
    else if dmPromotions.qEditPromoPortionPriceMappingCalculationValue.Value < 0 then
    begin
      MessageDlg(Format('%s must be non-negative .',
                 [dmPromotions.qEditPromoPortionPriceMappingCalculationValue.DisplayLabel]),
                 mtError,
                 [mbOK],
                 0);
      dbeCalculationValue.SetFocus;
      Abort;
    end
    else if (dmPromotions.qEditPromoPortionPriceMappingCalculationType.Value in [CalcType_PercentIncrease, CalcType_PercentDecrease])
            and(    (dmPromotions.qEditPromoPortionPriceMappingCalculationValue.AsFloat > VERY_HIGH_PERCENTAGE)
                 or (dmPromotions.qEditPromoPortionPriceMappingCalculationValue.AsFloat < LOW_PERCENTAGE)) then
    begin
      MessageDlg(Format('%s percentages must be between %f and %f.',
                        [dmPromotions.qEditPromoPortionPriceMappingCalculationValue.DisplayLabel, LOW_PERCENTAGE, VERY_HIGH_PERCENTAGE]),
                 mtError,
                 [mbOK],
                 0);
      dbeCalculationValue.SetFocus;
      Abort;
    end
    else if (dmPromotions.qEditPromoPortionPriceMappingCalculationType.Value in [CalcType_PercentIncrease, CalcType_PercentDecrease])
            and (   (dmPromotions.qEditPromoPortionPriceMappingCalculationValue.AsFloat > HIGH_PRICE_RANGE)
                 or (dmPromotions.qEditPromoPortionPriceMappingCalculationValue.AsFloat < LOW_PRICE_RANGE)) then
    begin
      MessageDlg(Format('%s prices must be between %f and %f.',
                        [dmPromotions.qEditPromoPortionPriceMappingCalculationValue.DisplayLabel, LOW_PRICE_RANGE, HIGH_PRICE_RANGE]),
                 mtError,
                 [mbOK],
                 0);
      dbeCalculationValue.SetFocus;
      Abort;
    end
    else begin
      //WARNING
      //New promotionid are set to -1, but the ADO components in this version of Delphi
      //will not allow the setting of a TLargeIntField (which PromotionID is under the hood)
      //to a negative value ('Multiple-step operation generated errors. Check each status value'
      //error is thrown.
      //This means we cannot set qEditPromoPortionPriceMappingPromotionID.Value to -1. The solution
      //used in this case is to give the column a default value of -1 in the temporary table definition
      //and let SQL handle it for us.
      //WARNING
      if FPromotionID <> -1 then
        dmPromotions.qEditPromoPortionPriceMappingPromotionID.Value := FPromotionID;
      dmPromotions.qEditPromoPortionPriceMappingSiteCode.Value := FSiteCode;
      dmPromotions.qEditPromoPortionPriceMapping.Post;

      // Note: It is necessary to close and reopen the dataset in order for the qEditPromoPortionPriceMappingPromotionID field
      // component to pick up the -1 value set via the database field's default value when adding a new mapping for a new promotion.
      // If this is not done then subsequently editing the mapping before leaving the wizard page will fail with a
      // "Row cannot be located..." OLEDB exception because the DB field contains -1 but the field component contains 0.
      // Doing this has the added benefit of positioning a new mapping in the "correct" position in the UI list of mappings.
      dmPromotions.qEditPromoPortionPriceMapping.Close;
      dmPromotions.qEditPromoPortionPriceMapping.Open;
    end;
  end
  else
    dmPromotions.qEditPromoPortionPriceMapping.CancelUpdates;
end;

procedure TfAddPortionPriceMapping.dbeCalculationValueKeyPress(
  Sender: TObject; var Key: Char);
var
  CurrText: String;
  DBEdit: TwwDBEdit;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  DBEdit := TwwDBEdit(Sender);

  CurrText := DBEdit.EditText;
  DecimalPos := Pos('.',CurrText);
  SelPos := DBEdit.SelStart;
  SelLength := DBEdit.SelLength;

  udmPromotions.ValidatePriceKeyPress(Key, CurrText, SelPos, SelLength, DecimalPos);
end;

end.