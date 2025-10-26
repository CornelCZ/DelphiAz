unit FrmStaticAddressU;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmStaticAddress = class(TForm)
    lblIPAddress: TLabel;
    edtIPAddress: TEdit;
    lblSubnetMask: TLabel;
    edtIPSubnetMask: TEdit;
    btnSetStaticAddress: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edtDefaultGateway: TEdit;
    procedure edtIPAddressChange(Sender: TObject);
  private
    procedure SetButtonState;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStaticAddress: TFrmStaticAddress;

implementation

{$R *.dfm}

procedure TFrmStaticAddress.edtIPAddressChange(Sender: TObject);
begin
  SetButtonState;
end;

procedure TFrmStaticAddress.SetButtonState;
begin
  btnSetStaticAddress.Enabled := (Trim(edtIPAddress.text) <> '') and
                                 (Trim(edtIPSubnetMask.text) <> '') and
                                 (Trim(edtDefaultGateway.Text) <> '');
end;

end.
