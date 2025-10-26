unit FrmAddDiskQuotaU;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmAddDiskQuota = class(TForm)
    lblUserName: TLabel;
    lblVolume: TLabel;
    cmbVolume: TComboBox;
    lblWarningLimit: TLabel;
    edtWarningLimit: TEdit;
    lblLimit: TLabel;
    edtLimit: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cmbUser: TComboBox;
    procedure OnControlChange(Sender: TObject);
    procedure edtLimitKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddDiskQuota: TFrmAddDiskQuota;

implementation

{$R *.dfm}

procedure TFrmAddDiskQuota.OnControlChange(Sender: TObject);
begin
  btnOk.Enabled := (cmbUser.Text <> '') and
                   (cmbVolume.Text <> '') and
                   (edtWarningLimit.Text <> '') and
                   (edtLimit.Text <> '');
end;

procedure TFrmAddDiskQuota.edtLimitKeyPress(Sender: TObject;
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
