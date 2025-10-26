unit uInternalTransferSiteSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wwdbdatetimepicker, DB, ADODB, StdCtrls, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, ExtCtrls, ComCtrls, DBCtrls, wwdblook;

type
  TfrmInternalTransferSiteSelect = class(TForm)
    btnPanelButtons: TPanel;
    pnlFormPanel: TPanel;
    btnOK: TButton;
    btnClose: TButton;
    ADOqryValidTransferSites: TADOQuery;
    dtpDeliveryDate: TDateTimePicker;
    lblTransferTo: TLabel;
    lblDeliveryDate: TLabel;
    cbValidTransferSites: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function validSiteSelect: Boolean;
  public
    { Public declarations }
  end;

var
  frmInternalTransferSiteSelect: TfrmInternalTransferSiteSelect;

implementation
Uses
  ulog, uAdo, uNewInternalTransfer, uGlobals;
{$R *.dfm}

procedure TfrmInternalTransferSiteSelect.FormShow(Sender: TObject);
begin
  log.Event('InternalTransferSiteSelect; START: FormShow');
  try
    ADOqryValidTransferSites.open;
    dtpDeliveryDate.MinDate := date;
    dtpDeliveryDate.Date := date;
  except
    on E: exception do
    begin
      log.Event('InternalTransferSiteSelect; ERROR: '+E.message);
      ShowMessage('Could not get site information.'+#13+E.message);
      Exit;
    end;
  end;
  log.Event('InternalTransferSiteSelect; END: FormShow');
end;

function TfrmInternalTransferSiteSelect.validSiteSelect: Boolean;
begin
  log.Event('InternalTransferSiteSelect; START: validSiteSelect');
  result := (cbValidTransferSites.Text <> '') and
            (dtpDeliveryDate.Date >= date);
  log.Event('InternalTransferSiteSelect; END: validSiteSelect');
end;

procedure TfrmInternalTransferSiteSelect.btnOKClick(Sender: TObject);
begin
  log.Event('InternalTransferSiteSelect; START: btnOKClick');
  if not validSiteSelect then
  begin
    ShowMessage('Please enter valid site and date details');
    log.Event('InternalTransferSiteSelect; END: btnOKClick - Invalid data');
    exit;
  end;
  //do new transfer
  frmNewInternalTransfer := TfrmNewInternalTransfer.CreateNewTransfer(
                      ADOqryValidTransferSites.FieldByName('SiteName').AsString,
                      ADOqryValidTransferSites.FieldByName('ID').Asinteger,
                      ADOqryValidTransferSites.FieldByName('IPAddress').AsString,
                      dtpDeliveryDate.Date);
  frmNewInternalTransfer.ShowModal;
  FreeAndNil(frmNewInternalTransfer);
  ModalResult := mrOK;
  log.Event('InternalTransferSiteSelect; END: btnOKClick');
end;

procedure TfrmInternalTransferSiteSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.Event('InternalTransferSiteSelect; START: FormClose');
  ADOqryValidTransferSites.Close;
  log.Event('InternalTransferSiteSelect; END: FormClose');
end;

procedure TfrmInternalTransferSiteSelect.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_INTERNAL_TRANSFER_SITE_SELECT);
end;

end.
