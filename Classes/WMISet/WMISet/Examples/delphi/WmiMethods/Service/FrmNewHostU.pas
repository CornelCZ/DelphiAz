unit FrmNewHostU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  StdCtrls;

type
  TFrmNewHost = class(TForm)
    Label1: TLabel;
    edtHostName: TEdit;
    grbCredentials: TGroupBox;
    lblDomain: TLabel;
    edtDomain: TEdit;
    edtUserName: TEdit;
    lblUserName: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    btnConnect: TButton;
    btnCancel: TButton;
    procedure EditChanged(Sender: TObject);
  private
    function GetMachineName: widestring;
    procedure SetMachineName(const Value: widestring);
    function GetUserName: widestring;
    { Private declarations }
  public
    { Public declarations }
    property MachineName: widestring read GetMachineName write SetMachineName;
    property UserName: widestring read GetUserName;
  end;

var
  edtUserName: TFrmNewHost;

implementation

{$R *.dfm}

procedure TFrmNewHost.EditChanged(Sender: TObject);
begin
  btnConnect.Enabled := (Trim(edtHostName.Text) <> '') and
                       (Trim(edtUserName.Text) <> '');
end;

function TFrmNewHost.GetMachineName: widestring;
begin
  Result := edtHostName.Text; 
end;

function TFrmNewHost.GetUserName: widestring;
begin
  Result := edtUserName.Text;
  if Trim(edtDomain.Text) <> '' then
    Result := edtDomain.Text + '\' + Result;
end;

procedure TFrmNewHost.SetMachineName(const Value: widestring);
begin
  edtHostName.Text := Value;
  edtHostName.Enabled := Value = '';
end;

end.
