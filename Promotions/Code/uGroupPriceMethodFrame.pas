unit uGroupPriceMethodFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ActnList, uPromoCommon;

type

  TPricingMethodTag = class(TObject)
    MethodTag: SmallInt;
    constructor Create(Tag: SmallInt);
  end;

  TGroupPriceMethodFrame = class(TFrame)
    cbCalculationMethod: TComboBox;
    Label1: TLabel;
    lbParameterCaption: TLabel;
    edValue: TEdit;
    lbPercentage: TLabel;
    cbBandList: TComboBox;
    ckRememberCalculation: TCheckBox;
    Bevel1: TBevel;
    lbGroupName: TLabel;
    ActionList1: TActionList;
    RememberCalculationChange: TAction;
    procedure cbCalculationMethodChange(Sender: TObject);
    procedure edValueKeyPress(Sender: TObject; var Key: Char);
    procedure edValueChange(Sender: TObject);
    procedure RememberCalculationChangeExecute(Sender: TObject);
    procedure cbBandListChange(Sender: TObject);
  private
    BandListInitialised: boolean;
    FModified: boolean;
    CurrentMethodTag: SmallInt;
    FPromotionMode: TPromotionMode;
    function GetGroupName: String;
    procedure SetGroupName(const Value: String);
    function GetCalculationType: Integer;
    procedure SetCalculationType(const Value: Integer);
    function GetCalculationBand: String;
    function GetCalculationValue: extended;
    procedure SetCalculationBand(const Value: String);
    procedure SetCalculationValue(const Value: extended);
    function GetRememberCalc: Boolean;
    procedure SetRememberCalc(const Value: Boolean);
    procedure SetModified(const Value: boolean);
    function GetPricingMethodIndexForTag(PricingMethodTag: Integer): Integer;
    function GetPricingMethodTag: Integer;
    procedure SetPricingMethodIndexFromTag(const Value: Integer);
    procedure SetPromotionType(PromotionType: Integer);
    procedure SetPromotionMode(const Value: TPromotionMode);
    { Private declarations }
  public
    { Public declarations }
    property GroupName : String read GetGroupName write SetGroupName;
    property PromotionType : Integer write SetPromotionType;
    property PricingMethodTag : Integer read GetPricingMethodTag write SetPricingMethodIndexFromTag;
    property CalculationType : Integer read GetCalculationType write SetCalculationType;
    property CalculationValue : extended read GetCalculationValue write SetCalculationValue;
    property CalculationBand : String read GetCalculationBand write SetCalculationBand;
    property RememberCalculation : Boolean read GetRememberCalc write SetRememberCalc;
    property Modified: boolean read FModified write SetModified;
    property PromotionMode: TPromotionMode read FPromotionMode write SetPromotionMode;
    procedure CheckValidValue;
    constructor Create(AOwner: TComponent; APromotionType: Integer; APromotionMode: TPromotionMode); reintroduce; overload;
    destructor Destroy; override;
  end;

implementation

uses udmPromotions;

{$R *.dfm}

const
  PRICE_ENTRY = 'Price Entry';
  VALUE_INCREASE = 'Value Increase';
  VALUE_DECREASE = 'Value Decrease';
  PERCENTAGE_INCREASE = 'Percentage Increase';
  PERCENTAGE_DECREASE = 'Percentage Decrease';
  BANDED_PRICE = 'Banded Price';
  

constructor TPricingMethodTag.Create(Tag: SmallInt);
begin
  MethodTag := Tag;
end;

constructor TGroupPriceMethodFrame.Create(AOwner: TComponent; APromotionType: Integer; APromotionMode: TPromotionMode);
begin
  inherited Create(AOwner);
  SetPromotionType(APromotionType);
  PromotionMode := APromotionMode;
  CurrentMethodTag := CalcType_PriceEntry;
  lbParameterCaption.Visible := FALSE;
  ckRememberCalculation.Checked := FALSE;
  RememberCalculation := FALSE;
  ckRememberCalculation.Visible := FALSE;
end;

procedure TGroupPriceMethodFrame.SetPromotionType(PromotionType: Integer);
var
  i: Integer;
  TempCalcType: Integer;
begin
  TempCalcType := GetCalculationType;
  for i := 0 to (cbCalculationMethod.Items.Count - 1) do
  begin
    cbCalculationMethod.items.Objects[i].Free;
  end;
  cbCalculationMethod.Items.Clear;

  if (PromotionType = PromoType_EventPricing) then
  begin
    with cbCalculationMethod do
    begin
      Items.AddObject(PRICE_ENTRY, TPricingMethodTag.Create(CalcType_PriceEntry));
      if FPromotionMode <> pmSite then
        Items.AddObject(BANDED_PRICE, TPricingMethodTag.Create(CalcType_BandedPrice));
    end;
  end
  else
  begin
    with cbCalculationMethod do
    begin
      Items.AddObject(PRICE_ENTRY, TPricingMethodTag.Create(CalcType_PriceEntry));
      Items.AddObject(VALUE_INCREASE, TPricingMethodTag.Create(CalcType_ValueIncrease));
      Items.AddObject(VALUE_DECREASE, TPricingMethodTag.Create(CalcType_ValueDecrease));
      Items.AddObject(PERCENTAGE_INCREASE, TPricingMethodTag.Create(CalcType_PercentIncrease));
      Items.AddObject(PERCENTAGE_DECREASE, TPricingMethodTag.Create(CalcType_PercentDecrease));
      if FPromotionMode <> pmSite then
        Items.AddObject(BANDED_PRICE, TPricingMethodTag.Create(CalcType_BandedPrice));
    end;
  end;
  SetCalculationType(TempCalcType);
end;

procedure TGroupPriceMethodFrame.cbCalculationMethodChange(Sender: TObject);
var
  theMethodTag: SmallInt;
begin

  theMethodTag := TPricingMethodTag(TComboBox(Sender).Items.Objects[TComboBox(Sender).ItemIndex]).MethodTag;

  if (theMethodTag = CurrentMethodTag) then
    Exit;

  lbPercentage.Visible := FALSE;
  edValue.Visible := FALSE;
  lbParameterCaption.Visible := TRUE;
  cbBandList.Visible := FALSE;
  ckRememberCalculation.Visible := FALSE;

  case theMethodTag of
    CalcType_ValueIncrease, CalcType_ValueDecrease, CalcType_PercentIncrease, CalcType_PercentDecrease:
      begin
        edValue.Visible := TRUE;
        edValue.Text := '0';
        lbParameterCaption.Caption := 'Value';
        ckRememberCalculation.Visible := TRUE;
        lbPercentage.Visible := (theMethodTag in [CalcType_PercentIncrease, CalcType_PercentDecrease]);
      end;
    CalcType_BandedPrice:
      begin
        lbParameterCaption.Caption := 'Band';
        if not BandListInitialised then
          dmPromotions.GetBandsList(cbBandList.Items);

        cbBandList.ItemIndex := 0;
        cbBandListChange(cbBandList);
        cbBandList.Visible := TRUE;
      end;
  else   // CalcType_PriceEntry
    lbParameterCaption.Visible := FALSE;
    ckRememberCalculation.Checked := FALSE;
    RememberCalculation := FALSE;
  end;

  CurrentMethodTag := theMethodTag;
  Modified := True;
end;

function TGroupPriceMethodFrame.GetCalculationBand: String;
begin
  Result := cbBandList.Text;
end;

function TGroupPriceMethodFrame.GetCalculationType: Integer;
begin
  Result := dmPromotions.GetCalcType(cbCalculationMethod.Text);
end;

function TGroupPriceMethodFrame.GetCalculationValue: extended;
begin
  Result := StrToFloatDef(edValue.text, 0);
end;

function TGroupPriceMethodFrame.GetGroupName: String;
begin
  Result := lbGroupName.Caption;
end;

function TGroupPriceMethodFrame.GetPricingMethodTag: Integer;
begin
  Result := TPricingMethodTag(cbCalculationMethod.Items.Objects[cbCalculationMethod.ItemIndex]).MethodTag;
end;

function TGroupPriceMethodFrame.GetRememberCalc: Boolean;
begin
  Result := ckRememberCalculation.Checked;
end;

function TGroupPriceMethodFrame.GetPricingMethodIndexForTag(PricingMethodTag: Integer): Integer;
var
  i, idx: SmallInt;
begin
  idx := 0;
  for i := 0 to cbCalculationMethod.Items.Count-1 do
  begin
    if (TPricingMethodTag(cbCalculationMethod.Items.Objects[i]).MethodTag = PricingMethodTag) then
    begin
      idx := i;
      Break;
    end;
  end;
  Result := idx;
end;

procedure TGroupPriceMethodFrame.SetCalculationBand(const Value: String);
begin
  cbBandList.ItemIndex := cbBandList.Items.IndexOf(Value);
end;

procedure TGroupPriceMethodFrame.SetCalculationType(const Value: Integer);
begin
  cbCalculationMethod.ItemIndex := GetPricingMethodIndexForTag(Value);
  cbCalculationMethodChange(cbCalculationMethod);
end;

procedure TGroupPriceMethodFrame.SetCalculationValue(const Value: extended);
begin
  edValue.Text := FloatToStr(Value);
end;

procedure TGroupPriceMethodFrame.SetGroupName(const Value: String);
begin
  lbGroupName.Caption := value;
end;

procedure TGroupPriceMethodFrame.SetPricingMethodIndexFromTag(const Value: Integer);
begin
  cbCalculationMethod.ItemIndex := GetPricingMethodIndexForTag(Value);
end;

procedure TGroupPriceMethodFrame.SetRememberCalc(const Value: Boolean);
begin
  ckRememberCalculation.Checked := Value;
end;

procedure TGroupPriceMethodFrame.edValueKeyPress(Sender: TObject; var Key: Char);
var
  CurrText: String;
  Edit: TEdit;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  Edit := TEdit(Sender);

  CurrText := Edit.Text;
  DecimalPos := Pos('.',CurrText);
  SelPos := Edit.SelStart;
  SelLength := Edit.SelLength;

  udmPromotions.ValidatePriceKeyPress(Key, CurrText, SelPos, SelLength, DecimalPos, false);
end;

procedure TGroupPriceMethodFrame.SetModified(const Value: boolean);
begin
  FModified := Value;
end;

procedure TGroupPriceMethodFrame.edValueChange(Sender: TObject);
begin
  Modified := True;
end;

procedure TGroupPriceMethodFrame.RememberCalculationChangeExecute(
  Sender: TObject);
begin
  Modified := True;
end;

procedure TGroupPriceMethodFrame.CheckValidValue;
var
  TmpValue: extended;
begin

  case GetPricingMethodTag of
    CalcType_ValueIncrease,
    CalcType_ValueDecrease:
    begin
      TmpValue := StrToFloatDef(edValue.Text, LOW_PRICE_RANGE-1.0);
      if (TmpValue > HIGH_PRICE_RANGE) or (TmpValue < LOW_PRICE_RANGE) then
        raise Exception.Create(Format('Price values must be between %f and %f.', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]));
    end;
    CalcType_PercentIncrease,
    CalcType_PercentDecrease:
    begin
      TmpValue := StrToFloatDef(edValue.Text, LOW_PERCENTAGE-1.0);
      if (TmpValue > HIGH_PERCENTAGE) or (TmpValue < LOW_PERCENTAGE) then
        raise Exception.Create(Format('Percentage values must be between %f and %f.', [HIGH_PERCENTAGE, LOW_PERCENTAGE]));
    end;
  end;
end;

procedure TGroupPriceMethodFrame.cbBandListChange(Sender: TObject);
begin
  Modified := True;
  ckRememberCalculation.Checked := TRUE;
  RememberCalculation := TRUE;
end;

procedure TGroupPriceMethodFrame.SetPromotionMode(const Value: TPromotionMode);
var
  Index: Integer;
begin
  FPromotionMode := Value;
  if (cbCalculationMethod.Items.Count > 0) and (FPromotionMode = pmSite) then
  begin
    Index := GetPricingMethodIndexForTag(CalcType_BandedPrice);
    TPricingMethodTag(cbCalculationMethod.Items.Objects[Index]).Free;
    cbCalculationMethod.Items.Delete(Index);
  end;
end;

destructor TGroupPriceMethodFrame.Destroy;
var
  i : integer;
begin
  for i := 0 to cbCalculationMethod.Items.Count - 1 do
  begin
    cbCalculationMethod.Items.Objects[i].Free;
  end;
  cbCalculationMethod.Items.Clear;
  inherited;
end;

end.
