unit FrmNewDiskQuotaU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmNewDiskQuota = class(TForm)
    lblUserName: TLabel;
    lblWarningLimit: TLabel;
    cmbWarningLimit: TComboBox;
    lblLimit: TLabel;
    cmbLimit: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    cmbUser: TComboBox;
    procedure OnControlChange(Sender: TObject);
    procedure cmbLimitKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNewDiskQuota: TFrmNewDiskQuota;

implementation

{$R *.dfm}

procedure TFrmNewDiskQuota.OnControlChange(Sender: TObject);
begin
  btnOk.Enabled := (cmbUser.Text <> '') and
                   (cmbWarningLimit.Text <> '') and
                   (cmbLimit.Text <> '');
end;

procedure TFrmNewDiskQuota.cmbLimitKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',
          Char(VK_BACK),
          Char(VK_DELETE),
          Char(VK_LEFT),
          Char(VK_RIGHT),
          Char(VK_TAB)
          ]) then Key := #0;
end;

end.
