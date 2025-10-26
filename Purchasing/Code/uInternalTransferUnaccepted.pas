unit uInternalTransferUnaccepted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB;

type
  TfrmInternalTransferUnaccepted = class(TForm)
    pnlButtonPanel: TPanel;
    pnlDBGridPanel: TPanel;
    btnClose: TButton;
    btnNewTransfer: TButton;
    lblReceived: TLabel;
    lblSent: TLabel;
    wwDBGridTransfersReceived: TwwDBGrid;
    dsTransfersReceived: TDataSource;
    wwDBGridTranfersSent: TwwDBGrid;
    dsTransfersSent: TDataSource;
    ADOspGetRecvdTransfers: TADOStoredProc;
    ADOspGetSentTransfers: TADOStoredProc;
    btnViewRcvdTranferDetails: TButton;
    btnViewSebtTransferDetails: TButton;
    procedure FormShow(Sender: TObject);
    procedure wwDBGridTransfersReceivedDblClick(Sender: TObject);
    procedure wwDBGridTranfersSentDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnViewRcvdTranferDetailsClick(Sender: TObject);
    procedure btnViewSebtTransferDetailsClick(Sender: TObject);
    procedure btnNewTransferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInternalTransferUnaccepted: TfrmInternalTransferUnaccepted;

implementation

Uses ulog, uAdo, uUnacceptedInternalTransferDetail, uInternalTransferSiteSelect,
uGlobals;

{$R *.dfm}

{*------------------------------------------------------------------------------
FormShow: get the unaccepted received/sent internal transfer records
Calls stored proc: sp_getInternalTransferMasterRecs
------------------------------------------------------------------------------*}
procedure TfrmInternalTransferUnaccepted.FormShow(Sender: TObject);
begin
  log.Event('InternalTransferUnaccepted; START: FormShow');
  Screen.Cursor := crSQLWait;
  try
    log.Event('InternalTransferUnaccepted; Get Sent/Received Transfer Master Recs');
    ADOspGetRecvdTransfers.Open;
    ADOspGetSentTransfers.Open;
  finally
    Screen.Cursor := crDefault;
    log.Event('InternalTransferUnaccepted; Get Sent/Received Transfers complete');
  end;
  log.Event('InternalTransferUnaccepted; END: FormShow');
end;

{*------------------------------------------------------------------------------
display the detail records for the selected unaccpeted received record
Calls stored Proc: sp_getInternalTransferMasterRecs
------------------------------------------------------------------------------*}
procedure TfrmInternalTransferUnaccepted.wwDBGridTransfersReceivedDblClick(
  Sender: TObject);
Var
  TransferID, LastModified, RecvName : ShortString;
  SiteCode   : Smallint;
begin
  log.Event('InternalTransferUnaccepted; START: wwDBGridTransfersReceivedDblClick');
  if dsTransfersReceived.DataSet.RecordCount = 0 then
  begin
    ShowMessage('There are no unaccepted received transfers to view');
    exit;
  end;

  if (Sender IS TwwDBGrid) then
  begin
    with dsTransfersReceived do
    begin
      transferID := DataSet.FieldByName('Delivery Note No.').AsString;
      siteCode   := DataSet.FieldByName('ReceiverSiteCode').AsInteger;
      RecvName   := DataSet.FieldByName('Received From').AsString;
      LastModified := DateTimeToStr(DataSet.FieldByName('last Modified').AsDateTime);
    end;
    frmUnacceptedInternalTransferDetail :=
           TfrmUnacceptedInternalTransferDetail.createTransferDetail(transferID,
                                                                     siteCode,
                                                                     RecvName,
                                                                     LastModified,
                                                                     'R');
    frmUnacceptedInternalTransferDetail.ShowModal;
    FreeAndNil(frmUnacceptedInternalTransferDetail);
    ADOspGetRecvdTransfers.Requery();
    ADOspGetSentTransfers.Requery();
  end;
  log.Event('InternalTransferUnaccepted; END: wwDBGridTransfersReceivedDblClick');
end;

{*------------------------------------------------------------------------------
display the detail records for the selected unaccpeted sent record
Calls stored proc: sp_getInternalTransferMasterRecs
------------------------------------------------------------------------------*}
procedure TfrmInternalTransferUnaccepted.wwDBGridTranfersSentDblClick(
  Sender: TObject);
Var
  TransferID, LastModified, SendName : ShortString;
  SiteCode   : Smallint;
begin
  log.Event('InternalTransferUnaccepted; START: wwDBGridTranfersSentDblClick');
  if dsTransfersSent.DataSet.RecordCount = 0 then
  begin
    ShowMessage('There are no unaccepted received transfers to view');
    exit;
  end;

  if (Sender IS TwwDBGrid) then
  begin
    with dsTransfersSent do
    begin
      transferID := DataSet.FieldByName('Delivery Note No.').AsString;
      siteCode   := DataSet.FieldByName('DestinationSiteCode').AsInteger;
      SendName   := DataSet.FieldByName('Sent To').AsString;
      LastModified := DateTimeToStr( DataSet.FieldByName('last Modified').AsDateTime);
    end;
    frmUnacceptedInternalTransferDetail :=
           TfrmUnacceptedInternalTransferDetail.createTransferDetail(transferID,
                                                                     siteCode,
                                                                     sendName,
                                                                     LastModified,
                                                                     'S');
    frmUnacceptedInternalTransferDetail.ShowModal;
    FreeAndNil(frmUnacceptedInternalTransferDetail);
  end;
  log.Event('InternalTransferUnaccepted; END: wwDBGridTranfersSentDblClick');
end;

procedure TfrmInternalTransferUnaccepted.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.Event('InternalTransferUnaccepted; START: FormClose');
  ADOspGetRecvdTransfers.Close;
  ADOspGetSentTransfers.Close;
  log.Event('InternalTransferUnaccepted; END: FormClose');
end;

procedure TfrmInternalTransferUnaccepted.btnViewRcvdTranferDetailsClick(
  Sender: TObject);
begin
  log.Event('InternalTransferUnaccepted; START: btnViewRcvdTranferDetailsClick');
  wwDBGridTransfersReceivedDblClick(wwDBGridTransfersReceived);
  log.Event('InternalTransferUnaccepted; END: btnViewRcvdTranferDetailsClick');
end;

procedure TfrmInternalTransferUnaccepted.btnViewSebtTransferDetailsClick(
  Sender: TObject);
begin
  log.Event('InternalTransferUnaccepted; START: btnViewSebtTransferDetailsClick');
  wwDBGridTranfersSentDblClick(wwDBGridTranfersSent);
  log.Event('InternalTransferUnaccepted; END: btnViewSebtTransferDetailsClick');
end;

procedure TfrmInternalTransferUnaccepted.btnNewTransferClick(
  Sender: TObject);
begin
  log.Event('InternalTransferUnaccepted; START: btnNewTransferClick');
  frmInternalTransferSiteSelect := TfrmInternalTransferSiteSelect.Create(self);
  frmInternalTransferSiteSelect.ShowModal;
  FreeAndNil(frmInternalTransferSiteSelect);

  ADOspGetSentTransfers.Requery;
  log.Event('InternalTransferUnaccepted; END: btnNewTransferClick');
end;

procedure TfrmInternalTransferUnaccepted.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_INTERNAL_TRANSFER_UNACCEPTED);
end;

end.
