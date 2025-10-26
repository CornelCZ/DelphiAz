unit uUnacceptedInternalTransferDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Mask, wwdbedit,
  ExtCtrls, uAztecRemoteSQL, uAztecComputer;

type
  TfrmUnacceptedInternalTransferDetail = class(TForm)
    dsTransferDetail: TDataSource;
    pnlFormPanel: TPanel;
    lblTransferID: TLabel;
    lblSiteCode: TLabel;
    lblSenderName: TLabel;
    Panel2: TPanel;
    wwDBGridTransferDetail: TwwDBGrid;
    pnlButtonPanel: TPanel;
    lblLMDT: TLabel;
    btnClose: TButton;
    btnAccept: TButton;
    ADOspTransferDetail: TADOStoredProc;
    edTransferID: TEdit;
    edName: TEdit;
    edLMDT: TEdit;
    edSiteCode: TEdit;
    ADOspAcceptTransfer: TADOStoredProc;
    ADOqryGetSiteIP: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TransferID, SendRecvName, LastModified : ShortString;
    SiteCode, SenderSiteCode   : Smallint;
    SiteIP     : ShortString;
    SentOrReceived: Char;
    procedure setupGUI;
    function AcceptTransfer: Boolean;
    function AcceptRemoteTransfer(useRestService: Boolean;remoteSQL: TAztecRemoteSQL; AztecComputer: TAztecComputer): Boolean;
  public
    { Public declarations }
    constructor createTransferDetail(ATransferID: ShortString;
                                          ASiteCode: Smallint;
                                          ASendRecvName: ShortString;
                                          ALastModified: ShortString;
                                          ASentOrReceived: Char);
  end;

var
  frmUnacceptedInternalTransferDetail: TfrmUnacceptedInternalTransferDetail;

implementation

Uses ulog, uAdo,uMainMenu, uGlobals, uAztecStringUtils, uInternalTransferRestService;
{$R *.dfm}

{*------------------------------------------------------------------------------
initialise the Transfer detail object with the header key and sent or received
parameter
------------------------------------------------------------------------------*}
constructor TfrmUnacceptedInternalTransferDetail.createTransferDetail(
  ATransferID: ShortString; ASiteCode: Smallint; ASendRecvName: ShortString;
  ALastModified: ShortString; ASentOrReceived: Char);
begin
  log.Event('UnacceptedInternalTransferDetail; START: createTransferDetail');
  inherited create(nil);
  transferID     := ATransferID;
  siteCode       := ASiteCode;
  SendRecvName   := ASendRecvName;
  LastModified   := ALastModified;
  SentOrReceived := ASentOrReceived;
  with ADOqryGetSiteIP do
  begin
    Parameters.ParamByName('sitename').Value := ASendRecvName;
    Open;
    SiteIP := FieldByName('IPAddress').AsString;
    SenderSiteCode := FieldByName('ID').AsInteger;
    close;
  end;
  log.Event('UnacceptedInternalTransferDetail; END: createTransferDetail');
end;
{*------------------------------------------------------------------------------
Calls stored proc: sp_getInternalTransferDetailRecs
------------------------------------------------------------------------------*}
procedure TfrmUnacceptedInternalTransferDetail.FormShow(Sender: TObject);
begin
  log.Event('UnacceptedInternalTransferDetail; START: FormShow');

  setupGUI;

  with ADOspTransferDetail do
  begin
    Parameters.ParamByName('@transferID').Value := transferID;
    Parameters.ParamByName('@siteCode').Value   := siteCode;
    Parameters.ParamByName('@S_R').Value        := SentOrReceived;
    Open;
  end;
  log.Event('UnacceptedInternalTransferDetail; END: FormShow');
end;

{*------------------------------------------------------------------------------
Set up the GUI components for either sent or received transfer details.
------------------------------------------------------------------------------*}
procedure TfrmUnacceptedInternalTransferDetail.setupGUI;
begin
  if SentOrReceived = 'R' then
  begin
    btnAccept.Visible := True;
    Caption := Caption + ' - RECEIVED';
    lblSenderName.Caption := 'Sent By';
    edSiteCode.Text   := IntToStr(SenderSiteCode);
  end
  else
  begin
    btnAccept.Visible := False;
    Caption := Caption + ' - SENT';
    lblSenderName.Caption := 'Sent To';
    edSiteCode.Text   := IntToStr(SiteCode);
  end;

  edTransferID.Text := TransferID;
  edName.Text       := SendRecvName;
  edLMDT.Text       := LastModified;
end;

{*------------------------------------------------------------------------------
Calls stored proc: sp_AcceptReceivedTransfer
------------------------------------------------------------------------------*}
procedure TfrmUnacceptedInternalTransferDetail.btnAcceptClick(
  Sender: TObject);
  
  procedure startDistributedTransaction;
  begin
    log.Event('UnacceptedInternalTransferDetail; Distributed transaction starting');
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('BEGIN DISTRIBUTED TRANSACTION');
      ExecSQL;
    end;
  end;
  
  procedure startTransaction;
  begin
    log.Event('UnacceptedInternalTransferDetail; Transaction starting');
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('BEGIN TRANSACTION');
      ExecSQL;
    end;
  end;

  procedure rollbackTransaction;
  begin
    log.Event('UnacceptedInternalTransferDetail; Distributed transaction rolled back');
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('ROLLBACK TRANSACTION');
      ExecSQL;
    end;
  end;

  procedure commitTransaction;
  begin
    log.Event('InternalTransfer; Committing distributed transaction');
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('COMMIT TRANSACTION');
      ExecSQL;
    end;
  end;
var
  useRestService: Boolean;
  remoteSQL: TAztecRemoteSQL;
  AztecComputer: TAztecComputer;
  ResultString: String;
begin
  log.Event('UnacceptedInternalTransferDetail; START: btnAcceptClick');
  if MessageDlg('Accept This Transfer?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
	useRestService := internalTransferRestService.SiteRestServiceConnectionDetailsValid();
	
	try
	if useRestService then
		startTransaction
	else
	begin
                Screen.Cursor := crSQLWait;
	        try
		  startDistributedTransaction;
		except on E:Exception do
		  begin
			log.Event('UnacceptedInternalTransferDetail; ERROR: Exception starting distributed transaction - '+E.Message);
			ShowMessage('The distributed transaction could not be started - ' +
					'please ensure that the Distributed Transaction Coordinator service is available.'+#13+
					'The transfer will remain unaccepted.');
			exit;
		  end;
		end;

		// Check connection to remote server
		AztecComputer := TAztecComputer.Create(SiteIP, SiteIP, EmptyStr, EmptyStr, EmptyStr);

		remoteSQL := TAztecRemoteSQL.Create();
		remoteSQL.SQL.Text := 'select @@rowcount';

		try
		  remoteSQL.Execute(AztecComputer, ResultString);
		except on E:Exception do
		  begin
			Screen.Cursor := crDefault;
			log.Event('UnacceptedInternalTransferDetail; ERROR: Exception accessing remote SQL server - '+E.Message);
			ShowMessage('The sending site could not be contacted at this time.'+#13+
				'The transfer will remain unaccepted.');
			rollbackTransaction;
			exit;
		  end;
		end;
	end;


	btnAccept.Enabled := FALSE;
	Screen.Cursor := crHourGlass;
	try
		if AcceptTransfer and AcceptRemoteTransfer(useRestService, remoteSQL, AztecComputer) then
		begin
			commitTransaction;
			ShowMessage('Internal Transfer Accepted.');
			Self.Close;
		end
		else
		begin
			ShowMessage('A problem occured while accepting this transfer. '+#13+
                'The transfer will remain unaccepted.');
			rollbackTransaction;
		end;
		Screen.Cursor := crDefault;
	except
		on E: Exception do
		begin
		  log.Event('InternalTransfer; ERR0R: '+E.Message);
		  ShowMessage('A problem occured while accepting this transfer. '+#13+
			  'The transfer will remain unaccepted.'+#13+'ERROR: '+E.Message);
		  Screen.Cursor := crDefault;
		  rollbackTransaction;
		  exit;
		end; // on exception
	end; // try/except
	finally
                FreeAndNil(remoteSQL);
                FreeAndNil(AztecComputer);
	end; // try
  end; // msg dlg
  log.Event('UnacceptedInternalTransferDetail; END: btnAcceptClick');
end;

function TfrmUnacceptedInternalTransferDetail.AcceptTransfer: Boolean;
begin
  with ADOspAcceptTransfer do
  begin
	  Parameters.ParamByName('@siteCode').Value   := SiteCode;
	  Parameters.ParamByName('@transferID').Value := TransferID;
	  Parameters.ParamByName('@acceptedBy').Value := fmainmenu.thesitename;
	  Parameters.ParamByName('@dateAccepted').Value := date;
	  Prepared := True;

	  log.Event('InternalTransfer; (LocalSQL) Accepting Internal Transfer: '+ADOspAcceptTransfer.ProcedureName +
			   IntToStr(SiteCode)+', '+TransferID+', '+fmainmenu.thesitename+', '+ DateToStr(date));
	  ExecProc;
	  Result := ADOspAcceptTransfer.Parameters.ParamByName('@RETURN_VALUE').Value = 0;

          if Result then
                log.Event('InternalTransfer; (LocalSQL) Accepting Internal Transfer: Success')
          else
                log.Event('InternalTransfer; (LocalSQL) Accepting Internal Transfer: Failed');
  end;
end;

function TfrmUnacceptedInternalTransferDetail.AcceptRemoteTransfer(useRestService: Boolean;remoteSQL: TAztecRemoteSQL; AztecComputer: TAztecComputer): Boolean;
var
  inputString: string;
  resultString: string;
begin
        Result := false;
	if useRestService then
	begin
                log.Event('InternalTransfer; (ZCF) Accepting Internal Transfer');
		// Handcraft JSON string containing tranfer data.
		inputString :=
		'{' +
			'"AcceptingSiteId":' + IntToStr(SiteCode) + ',' +
			'"TransferID":"' + EscapeJsonParam(TransferID) + '"' +
		'}';
		Result := (uInternalTransferRestService.internalTransferRestService.Accept(SenderSiteCode, inputString) = 0);

                if Result then
                        log.Event('InternalTransfer; (ZCF) Accepting Internal Transfer: Success')
                else
                        log.Event('InternalTransfer; (ZCF) Accepting Internal Transfer: Failed - trying remoteSQL');
	end;

	if Result = false then
	begin
                log.Event('InternalTransfer; (RemoteSQL) Accepting Internal Transfer');

                if remoteSQL = nil then
                        remoteSQL := TAztecRemoteSQL.Create();

                if AztecComputer = nil then
                        AztecComputer := TAztecComputer.Create(SiteIP, SiteIP, EmptyStr, EmptyStr, EmptyStr);

		remoteSQL.SQL.Text := 'Exec sp_updateAztecPurchaseWithSentTransfer '+ QuotedStr(TransferID)+', '+IntToStr(SiteCode);

		Result := remoteSQL.Execute(AztecComputer, resultString);

                if Result then
                        log.Event('InternalTransfer; (RemoteSQL) Accepting Internal Transfer: Success')
                else
                        log.Event('InternalTransfer; (RemoteSQL) Accepting Internal Transfer: Failed');
	end;
end;

procedure TfrmUnacceptedInternalTransferDetail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.Event('UnacceptedInternalTransferDetail; START: FormClose');
  ADOspTransferDetail.Close;
  ADOspAcceptTransfer.Close;
  log.Event('UnacceptedInternalTransferDetail; END: FormClose');
end;

procedure TfrmUnacceptedInternalTransferDetail.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_INTERNAL_TRANSFER_DETAIL);
end;

end.


