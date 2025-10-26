unit FrmEditStringU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFDEF Delphi6} Variants, {$ENDIF} 
  Dialogs, StdCtrls;

type
  TFrmEditString = class(TForm)
    lblValueName: TLabel;
    edtValueName: TEdit;
    lblValueData: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    edtValueData: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
