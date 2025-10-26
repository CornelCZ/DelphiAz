unit uNegativeTheoStockWarning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfNegativeTheoStockWarning = class(TForm)
    lblWarningText: TLabel;
    btnYes: TButton;
    btnNo: TButton;
    lblContinue: TLabel;
    memProductList: TMemo;
  private
    procedure setProductList(productList: TStringList);
  public
    property ProductList: TStringList write setProductList;
    constructor CreateWithProductList(AOwner: TComponent; productList: TStringList); overload;
  end;

var
  fNegativeTheoStockWarning: TfNegativeTheoStockWarning;

implementation

{$R *.dfm}

{ TNegativeTheoStockWarning }

constructor TfNegativeTheoStockWarning.CreateWithProductList(AOwner: TComponent; productList: TStringList);
begin
  inherited Create(AOwner);
  self.ProductList := productList;
end;

procedure TfNegativeTheoStockWarning.setProductList(
  productList: TStringList);
begin
  memProductList.Lines := productList;
end;

end.
