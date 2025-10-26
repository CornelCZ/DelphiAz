unit FrmNewTaskU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmNewTask = class(TForm)
    lblFileName: TLabel;
    edtFileName: TEdit;
    btnStart: TButton;
    btnCancel: TButton;
    procedure edtFileNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNewTask: TFrmNewTask;

implementation

{$R *.dfm}

procedure TFrmNewTask.edtFileNameChange(Sender: TObject);
begin
  btnStart.Enabled := Trim(edtFileName.Text) <> '';
end;

end.
