unit FrmStartProcessU;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmStartProcess = class(TForm)
    lblCommandLine: TLabel;
    edtCommandLine: TEdit;
    lblDirectory: TLabel;
    edtStartDirectory: TEdit;
    SpeedButton1: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    CommandLineDialog: TOpenDialog;
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtCommandLineChange(Sender: TObject);
  private
    procedure SetButtonState;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStartProcess: TFrmStartProcess;

implementation

{$R *.dfm}

procedure TFrmStartProcess.SpeedButton1Click(Sender: TObject);
begin
  if CommandLineDialog.Execute then
  begin
    edtCommandLine.Text := CommandLineDialog.FileName;
    if Trim(edtStartDirectory.Text) = '' then
      edtStartDirectory.Text := ExtractFileDir(CommandLineDialog.FileName);
  end;
end;

procedure TFrmStartProcess.edtCommandLineChange(Sender: TObject);
begin
  SetButtonState;
end;

procedure TFrmStartProcess.SetButtonState;
begin
  btnOk.Enabled := (Trim(edtCommandLine.Text) <> '') and
                   (Trim(edtStartDirectory.Text) <> '');
end;

end.
