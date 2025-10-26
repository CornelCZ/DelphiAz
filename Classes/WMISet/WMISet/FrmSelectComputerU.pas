unit FrmSelectComputerU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, WmiAbstract, WmiProcessControl;

type
  TFrmSelectComputer = class(TForm)
    pnlTop: TPanel;
    lblSelectDomain: TLabel;
    cmbDomains: TComboBox;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    pnlResult: TPanel;
    lblSelectedComputer: TLabel;
    edtSelectedComputer: TEdit;
    lbxComputers: TListBox;
    WmiProcessControl1: TWmiProcessControl;
    procedure FormCreate(Sender: TObject);
    procedure cmbDomainsChange(Sender: TObject);
    procedure lbxComputersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetComputerName: widestring;
    procedure SetComputerName(Value: widestring);
  public
    { Public declarations }
    property ComputerName: widestring read GetComputerName write SetComputerName;
  end;

var
  FrmSelectComputer: TFrmSelectComputer;

implementation

{$R *.DFM}

function TFrmSelectComputer.GetComputerName: widestring;
begin
  Result := edtSelectedComputer.Text;
end;

procedure TFrmSelectComputer.SetComputerName(Value: widestring);
begin
  edtSelectedComputer.Text := Value;
end;

procedure TFrmSelectComputer.FormCreate(Sender: TObject);
begin
  WmiProcessControl1.ListDomains(cmbDomains.Items);
  cmbDomains.Text := WmiProcessControl1.SystemInfo.DomainName;
  cmbDomainsChange(cmbDomains);
end;

procedure TFrmSelectComputer.cmbDomainsChange(Sender: TObject);
begin
  lbxComputers.Items.Clear;
  if Trim(cmbDomains.Text) <> '' then
    WmiProcessControl1.ListServersInDomain(Trim(cmbDomains.Text), lbxComputers.Items)
    else WmiProcessControl1.ListServers(lbxComputers.Items);
end;

procedure TFrmSelectComputer.lbxComputersClick(Sender: TObject);
begin
  edtSelectedComputer.Text := lbxComputers.Items[lbxComputers.ItemIndex];
end;

procedure TFrmSelectComputer.FormShow(Sender: TObject);
begin
  ClientWidth := cmbDomains.Left + cmbDomains.Width + 4; 
end;

end.
