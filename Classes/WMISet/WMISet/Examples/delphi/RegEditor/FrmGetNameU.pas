unit FrmGetNameU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmGetName = class(TForm)
    lblPrompt: TLabel;
    edtName: TEdit;
    btnOk: TButton;
    Cancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(APrompt, AValue: string); reintroduce;
  end;

var
  FrmGetName: TFrmGetName;

implementation

{$R *.DFM}

{ TForm1 }

constructor TFrmGetName.Create(APrompt, AValue: string);
begin
  inherited Create(nil);
  lblPrompt.Caption := APrompt;
  Caption := APrompt;
  edtName.Text := AValue;
end;

end.
