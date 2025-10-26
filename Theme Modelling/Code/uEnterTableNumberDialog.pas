unit uEnterTableNumberDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEnterTableNumberDialog = class(TForm)
    Label1: TLabel;
    edTableNumber: TEdit;
    btOk: TButton;
    btCancel: TButton;
    procedure edTableNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edTableNumberChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EnterTableNumberDialog: TEnterTableNumberDialog;

implementation

uses
  uAztecLog;

{$R *.dfm}

procedure TEnterTableNumberDialog.edTableNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key <> #8) and ((key < '0') or (key > '9')) then abort;
end;

procedure TEnterTableNumberDialog.edTableNumberChange(Sender: TObject);
begin
  btOk.enabled := length(edTableNumber.Text) > 0;
end;

procedure TEnterTableNumberDialog.FormShow(Sender: TObject);
begin
  Log('Form Show Enter Table Number');
end;

procedure TEnterTableNumberDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close Enter Table Number');
end;

procedure TEnterTableNumberDialog.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

procedure TEnterTableNumberDialog.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

end.
