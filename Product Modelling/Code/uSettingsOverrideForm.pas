unit uSettingsOverrideForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSettingsFrame, uDatabaseADO;

type
  TSettingsOverrideForm = class(TForm)
    SettingsFrame: TSettingsFrame;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(AOwner: TComponent); override;
  end;

var
  SettingsOverrideForm: TSettingsOverrideForm;

implementation

{$R *.dfm}

constructor TSettingsOverrideForm.create(AOwner: TComponent);
begin
  inherited;
  SettingsFrame.GlobalCostPriceMode := ProductsDB.costPriceModeForChoices;
  SettingsFrame.CostPriceMode := TCostPriceMode(ProductsDB.adotProductCostPriceCostPriceMode.AsInteger);
end;

procedure TSettingsOverrideForm.FormShow(Sender: TObject);
begin
  SettingsFrame.chkbxShowPortionPrices.Visible := False;
  SettingsFrame.chkbxShowB2BName.Visible := False;
  SettingsFrame.bvlDivider1.Visible := False;
  SettingsFrame.bvlDivider2.Visible := False;
  SettingsFrame.lblNumberOfPortions1.Visible := False;
  SettingsFrame.lblNumberOfPortions2.Visible := False;
  SettingsFrame.edtMaxNumberOfPortions.Visible := False;
end;

end.
