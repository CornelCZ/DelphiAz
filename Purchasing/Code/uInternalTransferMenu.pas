unit uInternaltransferMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmInternalTransferMenu = class(TForm)
    btnUnacceptedInternalTransfers: TButton;
    btnNewInternalTransfer: TButton;
    btnClose: TButton;
    procedure btnUnacceptedInternalTransfersClick(Sender: TObject);
    procedure btnNewInternalTransferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInternalTransferMenu: TfrmInternalTransferMenu;

implementation

Uses uLog, uInternalTransferUnaccepted, uInternaltransferSiteSelect, uGlobals;

{$R *.dfm}

procedure TfrmInternalTransferMenu.btnUnacceptedInternalTransfersClick(
  Sender: TObject);
begin
  log.Event('InternalTransferMenu; START: Unaccepted Transfers');
  frmInternalTransferUnaccepted := TfrmInternalTransferUnaccepted.Create(self);
  frmInternalTransferUnaccepted.ShowModal;
  FreeAndNil(frmInternalTransferUnaccepted);
  log.Event('InternalTransferMenu; END: Unaccepted Transfers');
end;

procedure TfrmInternalTransferMenu.btnNewInternalTransferClick(
  Sender: TObject);
begin
  log.Event('InternalTransferMenu; START: New Internal Transfer');
  frmInternalTransferSiteSelect := TfrmInternalTransferSiteSelect.Create(self);
  frmInternalTransferSiteSelect.ShowModal;
  FreeAndNil(frmInternalTransferSiteSelect);
  log.Event('InternalTransferMenu; END: New Internal Transfer');
end;

procedure TfrmInternalTransferMenu.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_INTERNAL_TRANSFER_MENU);
end;

end.
