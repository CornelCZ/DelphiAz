unit uEditDiscountProdGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uProductTreeBuilder, ImgList, DB, ADODB, ComCtrls, StdCtrls;

type
  TEditDiscountProdGroup = class(TProductTreeBuilder)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditDiscountProdGroup: TEditDiscountProdGroup;

implementation

{$R *.dfm}

procedure TEditDiscountProdGroup.FormShow(Sender: TObject);
begin
  inherited;
  setSearchBox(True);

  SearchRootNode := tvAllProducts.Selected;

  tvAllProducts.FullCollapse;
end;

end.
