unit uNewInternalTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ADODB, DB, Provider, DBClient, Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, Wwkeycb,
  wwDialog, wwfltdlg;

type
  TfrmNewInternalTransfer = class(TForm)
    pnlButtonPanel: TPanel;
    pnlHeaderPanel: TPanel;
    pnlFormPanel: TPanel;
    btnClose: TButton;
    btnAddItem: TButton;
    btnSend: TButton;
    lblSendToSite: TLabel;
    lblDateToSend: TLabel;
    edSendToSite: TEdit;
    edDateToSend: TEdit;
    cdsNewTransferItems: TClientDataSet;
    dspNewTransferItems: TDataSetProvider;
    dsNewTransferItems: TDataSource;
    pnlProductList: TPanel;
    wwDBGridProductList: TwwDBGrid;
    pnlTransferItems: TPanel;
    wwDBGridNewTransferItems: TwwDBGrid;
    lblTransferItems: TLabel;
    lblProductList: TLabel;
    dsAllProductsList: TDataSource;
    cdsNewTransferItemsDestinationSiteCode: TSmallintField;
    cdsNewTransferItemsSenderName: TStringField;
    cdsNewTransferItemsInternalTransferSentID: TStringField;
    cdsNewTransferItemsRecordID: TFloatField;
    cdsNewTransferItemsEntityCode: TFloatField;
    cdsNewTransferItemsPurchaseName: TStringField;
    cdsNewTransferItemsFlavour: TStringField;
    cdsNewTransferItemsQuantity: TBCDField;
    cdsNewTransferItemsUnitName: TStringField;
    cdsNewTransferItemsCostPerUnit: TBCDField;
    cdsNewTransferItemsTotalCost: TBCDField;
    cdsNewTransferItemsLMDT: TDateTimeField;
    cdsNewTransferItemsSentBy: TStringField;
    cdsNewTransferItemsAccepted: TStringField;
    ADOsp_createMasterSentRec: TADOStoredProc;
    ADOqryInternalTransferSentDetail: TADOQuery;
    btnRemoveItem: TButton;
    ADOqryGetTransferableProducts: TADOQuery;
    ADOqryGetTransferableProductsEntityCode: TFloatField;
    ADOqryGetTransferableProductsPurchaseName: TStringField;
    ADOqryGetTransferableProductsRetailDescription: TStringField;
    ADOqryGetTransferableProductsSubCategoryName: TStringField;
    ADOqryGetTransferableProductsUnitName: TStringField;
    ADOqryGetTransferableProductsFlavour: TStringField;
    ADOqryGetTransferableProductsUnitCost: TBCDField;
    edOrderNo: TEdit;
    lbltransferID: TLabel;
    gbFindProduct: TGroupBox;
    btnPrevious: TButton;
    btnNext: TButton;
    cbMidWordSearch: TCheckBox;
    gbFilter: TGroupBox;
    cbFiltered: TCheckBox;
    btnSetFilter: TButton;
    edSearchEdit: TEdit;
    ADOQrySearchSubSet: TADOQuery;
    wwfdProducts: TwwFilterDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure wwDBGridProductListDblClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure QuantityChange(Sender: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure wwDBGridNewTransferItemsColEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSearchEditChange(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure cbMidWordSearchClick(Sender: TObject);
    procedure btnSetFilterClick(Sender: TObject);
    procedure cbFilteredClick(Sender: TObject);
  private
    { Private declarations }
    receiverSiteName    : ShortString;
    receiverSiteCode    : Smallint;
    receiverSiteIP      : ShortString;
    receiverDeliveryDate: TDate;
    transferOrderNo     : ShortString;
    procedure CheckThatSearchQueryIsOpen;
    function saveTransferRecords: Boolean;
    function SendTransferToReceiverRest: integer;
    function SendTransferToReceiver: Boolean;
    procedure renumberTranferItems;
    function SetProductListFilter: Boolean;
    procedure StringSearch(IsMidWordSearch: Boolean; ASearchString: String);
  public
    { Public declarations }
    constructor CreateNewTransfer(AsiteName: ShortString; AsiteCode: Smallint; AsiteIP: ShortString; AdeliverDate: TDate);
  end;

var
  frmNewInternalTransfer: TfrmNewInternalTransfer;

implementation
Uses ulog, uAdo, dmMain, uMainMenu, uGlobals, uAztecRemoteSQL, uAztecComputer, uAztecStringUtils, uInternalTransferRestService;
{$R *.dfm}

constructor TfrmNewInternalTransfer.CreateNewTransfer(
  AsiteName: ShortString; AsiteCode: Smallint; AsiteIP: ShortString; AdeliverDate: TDate);
begin
  log.Event('NewInternalTransfer; START: CreateNewTransfer');
  Inherited create(nil);
  receiverSiteName      := AsiteName;
  receiverSiteCode      := AsiteCode;
  receiverSiteIP        := AsiteIP;
  receiverDeliveryDate  := AdeliverDate;
  transferOrderNo       := '';
  log.Event('NewInternalTransfer; END: CreateNewTransfer');
end;

procedure TfrmNewInternalTransfer.FormShow(Sender: TObject);
begin
  log.Event('NewInternalTransfer; START: FormShow');
  Application.HintHidePause := 4000;
  edSendToSite.Text := receiverSiteName;
  edDateToSend.Text := DateToStr(receiverDeliveryDate);
  edOrderNo.Text    := transferOrderNo;
  wwDBGridNewTransferItems.ReadOnly := False;

  with ADOqryInternalTransferSentDetail do
  begin
    Close;
    Parameters.ParamByName('sitecode').Value   := receiverSiteCode;
    Parameters.ParamByName('transferID').Value := transferOrderNo;
    Prepared := true;
    try
      open;
    except
      on E: exception do
      begin
        log.Event('NewInternalTransfer; ERROR: '+E.message);
        ShowMessage('Could not get sent tranfer details.'+#13+E.message);
        Exit;
      end; // on
    end; // try
  end; // with  

  cdsNewTransferItems.Open;

  try
    ADOqryGetTransferableProducts.Open;
  except
    on E: exception do
    begin
      log.Event('NewInternalTransfer; ERROR: '+E.message);
      ShowMessage('Could not get product details.'+#13+E.message);
      Exit;
    end; // on
  end; // try
  log.Event('NewInternalTransfer; END: FormShow');
end;

procedure TfrmNewInternalTransfer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.Event('NewInternalTransfer; START: FormClose');
  cdsNewTransferItems.Close;
  ADOqryGetTransferableProducts.Close;
  ADOqryInternalTransferSentDetail.Close;
  log.Event('NewInternalTransfer; END: FormClose');
end;

procedure TfrmNewInternalTransfer.btnSendClick(Sender: TObject);
var
  RollbackRequired: Boolean;
  MessageText: String;
  itemCount,fieldCountIdx: Integer;
  transferItems: array of Variant;
  transferSuccess: Boolean;
  errorCodeFromHttpClient: integer;
begin
  MessageText := '';
  RollbackRequired := False;
  transferSuccess := false;
  log.Event('NewInternalTransfer; START: btnSendClick');
  dmado.BeginTransaction;
  try
    if saveTransferRecords then
    begin
      log.Event('  ; Local Transfer records saved: '+transferOrderNo);
      errorCodeFromHttpClient := 0;
      if internalTransferRestService.SiteRestServiceConnectionDetailsValid() then
      begin
        errorCodeFromHttpClient := SendTransferToReceiverRest();
        transferSuccess := (errorCodeFromHttpClient = 0);
      end;

      // -100 returned from the ZcfHttpClient.exe = PK Violation. No point in falling back to remote SQL in this case.
      if (not transferSuccess) and (errorCodeFromHttpClient <> -100) then
      begin
        transferSuccess := SendTransferToReceiver;
      end;

      if transferSuccess then
      begin
        btnAddItem.Enabled    := False;
        btnSend.Enabled       := False;
        btnRemoveItem.Enabled := False;
        wwDBGridNewTransferItems.ReadOnly := True;
        edOrderNo.Text := transferOrderNo;
        MessageText := 'Internal Transfer Complete for Transfer ID: '+transferOrderNo;
        close;
      end
      else
      begin
        RollbackRequired := True;

        log.Event('  ; Remote Transfer send failed, removing local records: '+transferOrderNo);
        if errorCodeFromHttpClient = -100 then
        begin
          MessageText := 'Internal Transfer failed sending records to '+receiverSiteName+#13+
                         'The response indicates that a transfer with ID: '+transferOrderNo+#13+
                         'already exists at the receiving site.';
          log.Event('  ; Internal Transfer failed sending records to . '+receiverSiteName+'PK Violation - see ZcfHttpClient.exe.log');
        end
        else
        begin
                MessageText := 'Internal Transfer failed sending records to '+receiverSiteName+#13+
                               'Make sure receiving site is available on the network.';
                log.Event('  ; Internal Transfer failed sending records to . '+receiverSiteName);
        end;
      end;
    end
    else
    begin
      RollbackRequired := True;
      MessageText := 'Internal Transfer failed to save the transfer records.' +#13+
        'No Transfer details have been sent to the destination site.';
      log.Event('  ; Internal Transfer failed to save the transfer records.');
    end;
  finally
  if RollbackRequired then
    begin
      dmado.RollbackTransaction;

      //   The TClientDataSet cdsNewTransferItems does not rollback cleanly.
      // Records created in the database are correctly rolled back by the the transaction rollback above.
      // However as far as the TClientDataSet is concerned, the records still exist in the database.
      // This means that if the user attempts to retry, the TClientDataset will attempt to perform an update
      // statement on the previously deleted records. The only recource for the user is to exit the transfer screen
      // which results in them losing all the records they've marked for transfer.
      //
      //   Despite best efforts I can't come up with a clean fix for this. I've taken the approach of taking a copy of each record,
      // refreshing the TClientDataSet, then re-adding each item again. This seems to work fine.
      itemCount := 0;
      // Create temporary holding array.
      SetLength(transferItems, cdsNewTransferItems.RecordCount);

      with cdsNewTransferItems do
      begin
        DisableControls;
        First;
        while not Eof do
        begin
          // Copy each record into the holding array. First create an empty array to hold the field data.
          transferItems[itemCount] := VarArrayCreate([0, FieldCount-1], varVariant);
          // Then copy the value from each field.
          for fieldCountIdx := 0 to FieldCount-1 do
            transferItems[itemCount][fieldCountIdx] := Fields[fieldCountIdx].Value;
          inc(itemCount);
          Next;
        end;
        // This clears out the records with the incorrect state (all of them) from the TClientDataSet
        cdsNewTransferItems.Refresh;

        // Now re-add each record from the holding array.
        for itemCount := 0 to length(transferItems) -1 do
        begin
          Append;
          for fieldCountIdx := 0 to FieldCount-1 do
            Fields[fieldCountIdx].Value := transferItems[itemCount][fieldCountIdx];
        end;
        EnableControls;
      end;
    end
  else
    dmado.CommitTransaction;
  end;
  if (MessageText <> '') then
    ShowMessage(MessageText);
  log.Event('NewInternalTransfer; END: btnSendClick');
end;

procedure TfrmNewInternalTransfer.btnAddItemClick(Sender: TObject);
begin
  log.Event('NewInternalTransfer; START: btnAddItemClick');

  renumberTranferItems;

  cdsNewTransferItems.AppendRecord([receiverSiteCode, uGlobals.SiteName,
            transferOrderNo,
            cdsNewTransferItems.RecordCount + 1,
            ADOqryGetTransferableProducts.FieldByName('EntityCode').AsFloat,
            ADOqryGetTransferableProducts.FieldByName('Purchase Name').AsString,
            ADOqryGetTransferableProducts.FieldByName('Flavour').AsString,
            0,
            ADOqryGetTransferableProducts.FieldByName('Unit Name').AsString,
            ADOqryGetTransferableProducts.FieldByName('Unit Cost').AsFloat,
            0,
            now,
            CurrentUser.UserName,
            'N']);
  btnSend.Enabled := (cdsNewTransferItems.RecordCount > 0);
  log.Event('NewInternalTransfer; END: btnAddItemClick');
end;


function TfrmNewInternalTransfer.SendTransferToReceiverRest: integer;
var
  inputString: string;

begin
  log.Event('NewInternalTransfer; START: SendTransferToReceiverRest');

	// Handcraft JSON string containing tranfer data.
	inputString :=
  '{' +
	  '"SendingSiteId":' + IntToStr(receiverSiteCode) + ',' +
	  '"SiteName":"' + EscapeJsonParam(uGlobals.SiteName) + '",' +
    '"TransferId":"' + EscapeJsonParam(transferOrderNo) + '",' +
	  '"SentBy":"' + EscapeJsonParam(CurrentUser.UserName) + '",' +
	  '"Products":' +
	  '[';

	with cdsNewTransferItems do
    begin
      First;
      while not Eof do
      begin
	      inputString := inputString +
        '{' +
			    '"RecordId":' + IntToStr(FieldByName('RecordID').AsInteger) + ',' +
			    '"EntityCode":' + FloatToStr(FieldByName('EntityCode').AsFloat) + ',' +
			    '"Name":"' + EscapeJsonParam(FieldByName('PurchaseName').AsString) + '",' +
			    '"Flavour":"' + EscapeJsonParam(FieldByName('Flavour').AsString) + '",' +   
			    '"Quantity":' + FloatToStr(FieldByName('Quantity').AsFloat) + ',' +
			    '"UnitName":"' + EscapeJsonParam(FieldByName('UnitName').AsString) + '",' +
			    '"CostPerUnit":' + CurrToStr(FieldByName('CostPerUnit').AsCurrency) +
        '},';
        next;
      end; // while
    end; // with

	// Remove trailing comma from product list
	delete(inputString,length(inputString),1);
	
	inputString := inputString +
	  ']' +
	'}';

  Screen.Cursor := crHourGlass;
  Result := internalTransferRestService.Send(receiverSiteCode, inputString);
  Screen.Cursor := crDefault;

  log.Event('NewInternalTransfer; END: SendTransferToReceiverRest');
end;

function TfrmNewInternalTransfer.SendTransferToReceiver: Boolean;
var
  remoteSQL: TAztecRemoteSQL;
  AztecComputer : TAztecComputer;
  SQL_Str, ResultString: String;
begin
  log.Event('NewInternalTransfer; START: SendTransferToReceiver');
  Result := FALSE;
  // send transfer to receiver
  SQL_Str := 'INSERT INTO InternalTransferReceivedMaster (ReceiverSiteCode, ReceivedFrom, InternalTransferRecvdID, LMDT, AcceptedBy, DateAccepted, Accepted) ';
  SQL_Str := SQL_Str + 'Values('+ IntToStr(receiverSiteCode) +', '+
                                  QuotedStr(uGlobals.SiteName) +', '+
                                  QuotedStr(transferOrderNo) +', '+
                                  dmAdo.FormatDateTimeForSQL(now) +', '+
                                  'NULL, '+
                                  'NULL, '+
                                  QuotedStr('N') +
                                  ')';

  AztecComputer := TAztecComputer.Create(receiverSiteIP, receiverSiteIP, EmptyStr, EmptyStr, EmptyStr);
  remoteSQL := TAztecRemoteSQL.Create();

  // Check connection to remote server
  remoteSQL.SQL.Text := 'select @@rowcount';
  Screen.Cursor := crSQLWait;
  try
    remoteSQL.Execute(AztecComputer, ResultString);
  except on E:Exception do
    begin
      Screen.Cursor := crDefault;
      log.Event('  ; ERROR: Exception accessing remote SQL server - '+E.Message);
      // No need to show error message as FALSE return will trigger an error message
      exit;
    end;
  end;
  remoteSQL.SQL.Clear;
  remoteSQL.SQL.Add(SQL_Str);
  remoteSQL.SQL.Add('GO');
  try
    log.Event('  ; SENDING MASTER: '+SQL_Str);
    Result := remoteSQL.Execute(AztecComputer, ResultString);
    log.Event('  ; SENDING MASTER: RemoteSQL.Execute Result: '+ResultString);
  finally
    Screen.Cursor := crDefault;
  end;

  if Result then
  begin
    SQL_Str := '';
    with cdsNewTransferItems do
    begin
      First;
      while not Eof do
      begin
        SQL_Str := SQL_Str + 'INSERT INTO InternalTransferReceivedDetail (InternalTransferRecvdID, ReceiverSiteCode, ReceivedFrom, RecordID, EntityCode, PurchaseName, Flavour, Quantity, UnitName, CostPerUnit, TotalCost, LMDT, AcceptedBy, Accepted) '+#13;
        SQL_Str := SQL_Str + 'Values('+
                  QuotedStr(FieldByName('InternalTransferSentID').AsString) +', '+
                  IntToStr( FieldByName('DestinationSiteCode').AsInteger ) +', '+
                  QuotedStr(FieldByName('SenderName').AsString) +', '+
                  IntToStr( FieldByName('RecordID').AsInteger ) +', '+
                  FloatToStr( FieldByName('EntityCode').AsFloat ) +', '+
                  QuotedStr(FieldByName('PurchaseName').AsString) +', '+
                  QuotedStr(FieldByName('Flavour').AsString) +', '+
                  FloatToStr( FieldByName('Quantity').AsFloat ) +', '+
                  QuotedStr(FieldByName('UnitName').AsString) +', '+
                  CurrToStr( FieldByName('CostPerUnit').AsCurrency ) +', '+
                  CurrToStr( FieldByName('TotalCost').AsCurrency ) +', '+
                  dmAdo.FormatDateTimeForSQL(now) +', '+
                  QuotedStr(FieldByName('SentBy').AsString)+', '+
                  QuotedStr(FieldByName('Accepted').AsString) +')'+#13;
        log.Event('  ; SQL SENT TO RECEIVER: '+#13+SQL_Str);
        next;
      end; // while
    end; // with
    remoteSQL.SQL.Clear;
    remoteSQL.SQL.Add(SQL_Str);
    remoteSQL.SQL.Add('GO');

    Screen.Cursor := crSQLWait;
    try
      log.Event('  ; SENDING DETAIL: '+SQL_Str);
      Result := remoteSQL.Execute(AztecComputer, ResultString);
      log.Event('  ; SENDING DETAIL: RemoteSQL.Execute Result: '+ResultString);
    finally
      FreeAndNil(remoteSQL);
      Screen.Cursor := crDefault;
    end;
  end;
  log.Event('NewInternalTransfer; END: SendTransferToReceiver');
end;

function TfrmNewInternalTransfer.saveTransferRecords: Boolean;
begin
  log.Event('NewInternalTransfer; START: saveTransferRecords');
  result := TRUE;
  //save the master record
  with ADOsp_createMasterSentRec do
  begin
    Close;
    Parameters.ParamByName('@siteCode').Value     := receiverSiteCode;
    Parameters.ParamByName('@senderName').Value   := uGlobals.SiteName ;

    Parameters.ParamByName('@sentBy').Value       := CurrentUser.UserName;
    Parameters.ParamByName('@deliveryDate').Value := FormatDateTime('yyyy-mm-dd',receiverDeliveryDate);
    Parameters.ParamByName('@accepted').Value     := 'N';
    Prepared := True;

    try
      Screen.Cursor := crSQLWait;
      try
        ExecProc;
        transferOrderNo := Parameters.ParamByName('@transferID').Value;
        log.Event('  ; Tranfer header record saved: '+transferOrderNo);
      Except
        on E: Exception do
        begin
          ShowMessage('Could not create Tranfer header record'#13+
                       'ERROR: '+E.Message);
          log.Event('  ; Could not create Tranfer header record: '+E.Message);
          result := false;
          exit;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;

    // save the detail records
    if (Parameters.ParamByName('@RETURN_VALUE').Value = 0) AND Result then
    begin
      with cdsNewTransferItems do
      begin
        log.Event('  ; Saving '+IntToStr(RecordCount) +' Tranfer Detail records: '+transferOrderNo);
        DisableControls;
        First;
        while not Eof do
        begin
          Edit;
          FieldByName('InternalTransferSentID').AsString := transferOrderNo;
          Post;
          Next;
        end;
        EnableControls;
      end;
      Result := (cdsNewTransferItems.ApplyUpdates(-1) = 0);
      if not Result then
        log.Event('  ; An error occurred saving Tranfer Detail records: '+transferOrderNo);
    end
    else
      Result := FALSE;
  end; // with
  log.Event('NewInternalTransfer; END: saveTransferRecords');
end;

procedure TfrmNewInternalTransfer.wwDBGridProductListDblClick(
  Sender: TObject);
begin
 log.Event('NewInternalTransfer; START: wwDBGridProductListDblClick');
  btnAddItemClick(btnAddItem);
 log.Event('NewInternalTransfer; END: wwDBGridProductListDblClick');
end;

procedure TfrmNewInternalTransfer.btnRemoveItemClick(Sender: TObject);
begin
  log.Event('NewInternalTransfer; START: btnRemoveItemClick');
  cdsNewTransferItems.Delete;
  renumberTranferItems;
  btnSend.Enabled := (cdsNewTransferItems.RecordCount > 0);
  log.Event('NewInternalTransfer; END: btnRemoveItemClick');
end;

procedure TfrmNewInternalTransfer.QuantityChange(
  Sender: TField);
begin
  log.Event('NewInternalTransfer; START: QuantityChange');
   cdsNewTransferItems.FieldByName('TotalCost').Value :=
                 cdsNewTransferItems.FieldByName('Quantity').AsFloat *
                  cdsNewTransferItems.FieldByName('CostPerUnit').AsFloat;
   wwDBGridNewTransferItems.Refresh;
  log.Event('NewInternalTransfer; END: QuantityChange');
end;

procedure TfrmNewInternalTransfer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  log.Event('NewInternalTransfer; START: FormCloseQuery');
  if cdsNewTransferItems.ChangeCount > 0 then
  begin
    if MessageDlg('Do you want to exit without sending this transfer?', mtConfirmation,
               [mbYes, mbNo], 0) = mrYes then
    begin
      cdsNewTransferItems.CancelUpdates;
      CanClose := True;
    end
    else
      CanClose := False;
  end
  else
    CanClose := True;
  log.Event('NewInternalTransfer; END: FormCloseQuery');
end;

procedure TfrmNewInternalTransfer.wwDBGridNewTransferItemsColEnter(
  Sender: TObject);
begin
  if wwDBGridNewTransferItems.SelectedField.FieldName <> 'Quantity' then
     wwDBGridNewTransferItems.SetActiveField('Quantity');
end;

procedure TfrmNewInternalTransfer.renumberTranferItems;
var
  recNo: Integer;
begin
  cdsNewTransferItems.First;
  for recNo := 1 to cdsNewTransferItems.RecordCount do
  begin
    cdsNewTransferItems.Edit;
    cdsNewTransferItems.FieldByName('RecordID').Value := recNo;
    cdsNewTransferItems.Next;
  end;
end;

procedure TfrmNewInternalTransfer.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_INTERNAL_TRANSFER_NEW);
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.edSearchEditChange
This procedure calls StringSearch which takes the input from the search edit box
and the mid-word check box.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.edSearchEditChange(Sender: TObject);
begin
  StringSearch(cbMidWordSearch.Checked, edSearchEdit.Text);
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.btnNextClick
TfrmNewInternalTransfer.btnPreviousClick
The following two procedures use the search query to navigate through the
(un)filtered list of products locating the next/previous matching record.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.btnNextClick(Sender: TObject);
begin
  CheckThatSearchQueryIsOpen;
  with ADOQrySearchSubSet do
  begin
    next;
    if not Eof then
      ADOqryGetTransferableProducts.Locate('Purchase Name;Unit Name;Unit Cost',
                              VarArrayOf([FieldByName('Purchase Name').AsString,
                                          FieldByName('Unit Name').AsString,
                                          FieldByName('Unit Cost').AsVariant]),
                              [loPartialKey])
    else
      ShowMessage('No more matching products found.');
  end;
end;

procedure TfrmNewInternalTransfer.btnPreviousClick(Sender: TObject);
begin
  CheckThatSearchQueryIsOpen;
  with ADOQrySearchSubSet do
  begin
    Prior;
    if not Bof then
      ADOqryGetTransferableProducts.Locate('Purchase Name;Unit Name;Unit Cost',
                               VarArrayOf([FieldByName('Purchase Name').AsString,
                                           FieldByName('Unit Name').AsString,
                                           FieldByName('Unit Cost').AsVariant]),
                               [loPartialKey])
    else
      ShowMessage('No more matching products found.');
  end;

end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.cbMidWordSearchClick
The user wants to do a mid-word incremental search.
Calls edSearchEditChange.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.cbMidWordSearchClick(Sender: TObject);
begin
//  edSearchEdit.OnChange(nil);
  StringSearch(cbMidWordSearch.Checked, edSearchEdit.Text);
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.btnSetFilterClick
This procedure displays the Product Filter dialog, from here the user sets the
filter criteria. If confirmed the 'Filter' check box is checked.
Calls function SetProductListFilter.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.btnSetFilterClick(Sender: TObject);
begin
  cbFiltered.Checked := SetProductListFilter;
  StringSearch(cbMidWordSearch.Checked, edSearchEdit.Text);
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.cbFilteredClick
The Filtered check box is only enabled when a filter is in operation, in this
case when the user unchecks the Filter box the current filter is removed from
the Product list.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.cbFilteredClick(Sender: TObject);
begin
  if not cbFiltered.Checked then
  begin
    wwfdProducts.ClearFilter;
    wwfdProducts.ApplyFilter;
    cbFiltered.Enabled := FALSE;
  end;
  StringSearch(cbMidWordSearch.Checked, edSearchEdit.Text);
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.SetProductListFilter
Displays the Filter dialog, if a filter has been set i.e. the user did not
cancel the dialog or set the filter to '', then
a) the product list is restricted to the filter criteria
b) the query that displays this list is copied to the hidden search query and a
parameter clause (on purchase name) is added.
Return: Boolean - indicating whether or not a filter has been set.
------------------------------------------------------------------------------*}
function TfrmNewInternalTransfer.SetProductListFilter: Boolean;
var
  i: Integer;
begin
  if cbMidWordSearch.Checked then
    wwfdProducts.DefaultMatchType := fdMatchAny;

  result := wwfdProducts.Execute;
  // if the filter was set to '' and OK clicked the the above line returns true
  // even though no filter was set. The following line checks for this.
  result := (wwfdProducts.FieldInfo.Count > 0) AND result;

  if result then
  begin
    with ADOQrySearchSubSet do
    begin
      Close;
      SQL.Text := ADOqryGetTransferableProducts.SQL.Text;
      with Parameters.AddParameter do
      begin
        DataType := ftString;
        Direction := pdInput;
        Name := '@PurchName';
        Value := '%';
      end;
      for i := SQL.Count -1 downto 0 do
      begin
        if pos('WHERE', UpperCase(SQL[i])) > 0 then
        begin
          SQL.Insert(i+1, 'AND a.[Purchase Name] LIKE :@PurchName');
          Break;
        end;
      end;
      Open;
      cbFiltered.Enabled := TRUE;
    end;
  end
  else
  begin
    wwfdProducts.ClearFilter;
    wwfdProducts.ApplyFilter;
    cbFiltered.Enabled := FALSE;
  end;
end;

{*------------------------------------------------------------------------------
TfrmNewInternalTransfer.StringSearch
This procedure takes a string value and passes it as a parameter to the 'hidden'
product list query which generates a search result set. This result set is used
to navigate through the (un)filtered list of products.
@Param: IsMidWordSearch - Boolean value indicating whether to do a partial match
                          at the beginning of the purchase name or anywhere in
                          the purchase name.
@Param: ASearchString - The string to search for.
------------------------------------------------------------------------------*}
procedure TfrmNewInternalTransfer.StringSearch(IsMidWordSearch: Boolean; ASearchString: String);
begin
  ASearchString := ASearchString+'%';
  if IsMidWordSearch then
    ASearchString := '%'+ASearchString;

  with ADOQrySearchSubSet do
  begin
    Close;
    Parameters.ParamByName('@PurchName').Value := ASearchString;
    Open;
    First;
    ADOqryGetTransferableProducts.Locate('Purchase Name;Unit Name;Unit Cost',
                              VarArrayOf([FieldByName('Purchase Name').AsString,
                                          FieldByName('Unit Name').AsString,
                                          FieldByName('Unit Cost').AsVariant]),
                              [loPartialKey]);
  end;
end;

procedure TfrmNewInternalTransfer.CheckThatSearchQueryIsOpen;
begin
  if not ADOQrySearchSubset.Active then
  begin
    ADOQrySearchSubSet.SQL.Text := ADOqryGetTransferableProducts.SQL.Text;
    ADOQrySearchSubSet.Active := true;
  end;
end;



end.

