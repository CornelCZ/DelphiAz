unit uSettingsFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, uDatabaseADO, Mask;

type
  TSettingsFrame = class(TFrame)
    btnCancel: TButton;
    btnOk: TButton;
    chkbxShowPortionPrices: TCheckBox;
    Label1: TLabel;
    pnlBudgetedCostPriceMode: TPanel;
    rbtnMin: TRadioButton;
    rbtnMax: TRadioButton;
    rbtnAvg: TRadioButton;
    chkbxUseGlobalDefault: TCheckBox;
    bvlDivider1: TBevel;
    chkbxShowB2BName: TCheckBox;
    bvlDivider2: TBevel;
    lblNumberOfPortions1: TLabel;
    lblNumberOfPortions2: TLabel;
    edtMaxNumberOfPortions: TEdit;
    procedure chkbxUseGlobalDefaultClick(Sender: TObject);
    procedure edtMaxNumberOfPortionsKeyPress(Sender: TObject; var Key: Char);
  private
    FShowPortionPrices: Boolean;
    FCostPriceMode: TCostPriceMode;
    FGlobalCostPriceMode: TCostPriceMode;
    FShowB2BName: boolean;

    function GetShowPortionPrices: boolean;
    procedure SetShowPortionPrices(const Value: Boolean);

    function GetCostPriceMode: TCostPriceMode;
    procedure SetCostPriceMode(const Value: TCostPriceMode);
    procedure SetGlobalCostPriceMode(const Value: TCostPriceMode);
    procedure RenderCostPriceMode(ACostPriceMode: TCostPriceMode);

    function GetShowB2BName: boolean;
    procedure SetShowB2BName(const Value: boolean);

    function GetMaxNumberOfPortions: integer;
    procedure SetMaxNumberOfPortions(const value: integer);
  public
    property GlobalCostPriceMode: TCostPriceMode write SetGlobalCostPriceMode;
    property CostPriceMode: TCostPriceMode read GetCostPriceMode write SetCostPriceMode;
    property ShowPortionPrices: boolean read GetShowPortionPrices write SetShowPortionPrices;
    property ShowB2BName: boolean  read GetShowB2BName write SetShowB2BName;
    property MaxNumberOfPortions: integer read GetMaxNumberOfPortions write SetMaxNumberOfPortions;
  end;

implementation

{$R *.dfm}

function TSettingsFrame.GetCostPriceMode: TCostPriceMode;
begin
  if chkbxUseGlobalDefault.checked then
    FCostPriceMode := cpmNone
  else if rbtnMin.Checked then
    FCostPriceMode := cpmMinimum
  else if rbtnMax.Checked then
    FCostPriceMode := cpmMaximum
  else
    FCostPriceMode := cpmAverage;

  Result := FCostPriceMode;
end;

function TSettingsFrame.GetShowPortionPrices: boolean;
begin
  FShowPortionPrices := chkbxShowPortionPrices.Checked;
  Result := FShowPortionPrices;
end;

procedure TSettingsFrame.SetCostPriceMode(const Value: TCostPriceMode);
begin
  FCostPriceMode := Value;
  RenderCostPriceMode(FCostPriceMode);
  chkbxUseGlobalDefault.Checked := FCostPriceMode = cpmNone;
end;

procedure TSettingsFrame.SetShowPortionPrices(const Value: Boolean);
begin
  FShowPortionPrices := Value;
  chkbxShowPortionPrices.Checked := FShowPortionPrices;
end;

procedure TSettingsFrame.chkbxUseGlobalDefaultClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    RenderCostPriceMode(FGlobalCostPriceMode);
    rbtnMin.Enabled := False;
    rbtnMax.Enabled := False;
    rbtnAvg.Enabled := False;
    pnlBudgetedCostPriceMode.Enabled := False;
  end
  else begin
    rbtnMin.Enabled := True;
    rbtnMax.Enabled := True;
    rbtnAvg.Enabled := True;
    pnlBudgetedCostPriceMode.Enabled := True;
  end;
end;

procedure TSettingsFrame.SetGlobalCostPriceMode(
  const Value: TCostPriceMode);
begin
  FGlobalCostPriceMode := Value;
  RenderCostPriceMode(FCostPriceMode);
end;

procedure TSettingsFrame.RenderCostPriceMode(ACostPriceMode: TCostPriceMode);
begin
  case ACostPriceMode of
    cpmNone:
      if (FGlobalCostPriceMode <> cpmNone) then
        RenderCostPriceMode(FGlobalCostPriceMode);
    cpmMinimum: rbtnMin.Checked := True;
    cpmMaximum: rbtnMax.Checked := True;
    cpmAverage: rbtnAvg.Checked := True;
  end;
end;

procedure TSettingsFrame.SetShowB2BName(const Value: boolean);
begin
  FShowB2BName := Value;
  chkbxShowB2BName.Checked := FShowB2BName;
end;

function TSettingsFrame.GetShowB2BName: boolean;
begin
  FShowB2BName := chkbxShowB2BName.Checked;
  Result := FShowB2BName;
end;

function TSettingsFrame.GetMaxNumberOfPortions: integer;
begin
  result := ProductsDB.SafeStrToInt(edtMaxNumberOfPortions.Text);
end;

procedure TSettingsFrame.SetMaxNumberOfPortions(const value: integer);
begin
  edtMaxNumberOfPortions.Text := IntToStr(value);
end;

procedure TSettingsFrame.edtMaxNumberOfPortionsKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0','1','2','3','4','5', '6','7','8','9', char(vk_back)]) then key := #0;
end;

end.
