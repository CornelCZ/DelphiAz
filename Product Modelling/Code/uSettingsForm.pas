unit uSettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uDatabaseADO, uSettingsFrame;

type
  TSettingsForm = class(TForm)
    SettingsFrame: TSettingsFrame;
    procedure FormShow(Sender: TObject);
    procedure SettingsFramebtnOkClick(Sender: TObject);
  public
    constructor create(AOwner: TComponent); override; 
  end;

implementation

{$R *.dfm}

constructor TSettingsForm.create(AOwner: TComponent);
begin
  inherited;
  SettingsFrame.CostPriceMode := ProductsDB.costPriceModeForChoices;
  SettingsFrame.GlobalCostPriceMode := ProductsDB.costPriceModeForChoices;
  SettingsFrame.ShowPortionPrices := ProductsDB.ShowPortionPrices;
  SettingsFrame.ShowB2BName := ProductsDB.ShowB2BName;
  SettingsFrame.MaxNumberOfPortions := ProductsDB.GetMaxAllowedPortions;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  SettingsFrame.chkbxUseGlobalDefault.Visible := False;
  SettingsFrame.pnlBudgetedCostPriceMode.BevelInner := bvNone;
  SettingsFrame.pnlBudgetedCostPriceMode.BevelOuter := bvNone;
end;

procedure TSettingsForm.SettingsFramebtnOkClick(Sender: TObject);
var maxPortionsInUse: integer;
begin
  if  (SettingsFrame.MaxNumberOfPortions < ABSOLUTE_MIN_NUMBER_OF_PORTIONS)
   or (SettingsFrame.MaxNumberOfPortions > ABSOLUTE_MAX_NUMBER_OF_PORTIONS) then
  begin
    ShowMessage(Format('Number of portions must be between %d and %d', [ABSOLUTE_MIN_NUMBER_OF_PORTIONS, ABSOLUTE_MAX_NUMBER_OF_PORTIONS]));
    ModalResult := mrNone;
    Exit;
  end;

  maxPortionsInUse := ProductsDB.GetMaxPortionsInUse;
  if (SettingsFrame.MaxNumberOfPortions < maxPortionsInUse) then
  begin
    ShowMessage(Format('Number of portions cannot be set to less than the number currently in use, which is %d.', [maxPortionsInUse]));
    ModalResult := mrNone;
    Exit;
  end;
end;

end.
