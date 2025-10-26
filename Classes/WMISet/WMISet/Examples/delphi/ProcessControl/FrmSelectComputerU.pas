unit FrmSelectComputerU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, WmiProcessControl;

type
  TFrmSelectComputer = class(TForm)
    cmbComputers: TComboBox;
    lblSelectComputer: TLabel;
    pnlCredentials: TPanel;
    chbConnectAsCurrent: TCheckBox;
    lblDomain: TLabel;
    edtDomain: TEdit;
    lblUserName: TLabel;
    edtUserName: TEdit;
    Label1: TLabel;
    edtPassword: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure chbConnectAsCurrentClick(Sender: TObject);
    procedure cmbComputersDropDown(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FListLoaded: boolean;
  public
    { Public declarations }
  end;

var
  FrmSelectComputer: TFrmSelectComputer;

implementation

{$R *.dfm}

procedure TFrmSelectComputer.chbConnectAsCurrentClick(Sender: TObject);
  procedure DisableEdit(AEdit: TEdit);
  begin
    AEdit.Enabled   := false;
    AEdit.Color     := clBtnFace;
    AEdit.Text      := '';
  end;

  procedure EnableEdit(AEdit: TEdit);
  begin
    AEdit.Enabled   := true;
    AEdit.Color     := clWindow;
  end;
  
begin
  if chbConnectAsCurrent.Checked then
  begin
    DisableEdit(edtDomain);
    DisableEdit(edtUserName);
    DisableEdit(edtPassword);
  end else
  begin
    EnableEdit(edtDomain);
    EnableEdit(edtUserName);
    EnableEdit(edtPassword);
  end;
end;

procedure TFrmSelectComputer.cmbComputersDropDown(Sender: TObject);
var
  vControl: TWmiProcessControl;
  vCursor: TCursor;
begin
  if not FListLoaded then
  begin
    vControl := TWmiProcessControl.Create(nil);
    vCursor  := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      vControl.ListServers(cmbComputers.Items);
      if cmbComputers.Items.IndexOf(vControl.SystemInfo.ComputerName) = - 1 then
        cmbComputers.Items.Add(vControl.SystemInfo.ComputerName);
      FListLoaded := true;
    finally
      Screen.Cursor := vCursor;
      vControl.Free;
    end;
  end;
end;

procedure TFrmSelectComputer.FormCreate(Sender: TObject);
begin
  FListLoaded := false;
end;

end.
