unit uAutoFillStockConfirmation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TCustomModalResults = (mrAutoComplete = 99, mrSaveStock = 98);

type
  TfAutoFillStockConfirmation = class(TForm)
    lblConfirmationText: TLabel;
    btnAutoComplete: TButton;
    btnSave: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAutoFillStockConfirmation: TfAutoFillStockConfirmation;

implementation

{$R *.dfm}

{ TfStockConfirmation }

end.
