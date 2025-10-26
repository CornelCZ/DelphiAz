unit uPromotionalFooters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid;

type
  TPromotionalFooters = class(TForm)
    wwDBGrid1: TwwDBGrid;
    Bevel1: TBevel;
    lblPromoFooters: TLabel;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PromotionalFooters: TPromotionalFooters;

implementation

uses
  uDMPromotionalFooter;

{$R *.dfm}

end.
