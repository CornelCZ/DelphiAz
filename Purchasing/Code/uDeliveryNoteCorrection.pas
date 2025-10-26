unit uDeliveryNoteCorrection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, Buttons;

type
  TfrmDeliveryNoteCorrection = class(TForm)
    lblSupplierName: TLabel;
    lblStockOrder: TLabel;
    lblDeliveryNoteNo: TLabel;
    lblDateReceived: TLabel;
    cmbStockOrders: TComboBox;
    dtpFinalised: TDateTimePicker;
    lblSupplier: TLabel;
    edbxDeliveryNoteNumber: TMaskEdit;
    btnOK: TBitBtn;
    btnClose: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function MergeWithExisting : Boolean;
    procedure btnCloseClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    lstStockOrders : TStringList;
    FRecordID : String;
    thisSupplier : Integer;
    procedure SetRecordID (const Value: String);
    function ValidateDeliveryNoteNumber : Boolean;
    function ValidateStockOrderNumberExists : Boolean;
    procedure SetFixedLabels;
  public
    { Public declarations }
    WasDeleted : Boolean;
    property RecordID : String read FRecordID write SetRecordID;
  end;

var
  frmDeliveryNoteCorrection: TfrmDeliveryNoteCorrection;

implementation

uses
  uADO, dmMain, uGlobals, uLog;

{$R *.dfm}

procedure TfrmDeliveryNoteCorrection.FormCreate(Sender: TObject);
begin

  lstStockOrders := TStringList.Create;
  if purchHelpExists then
    setHelpContextID(Self, HLP_HANDHELD_IMPORT_CORRECTIONS);


end;

procedure TfrmDeliveryNoteCorrection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  lstStockOrders.Free;

end;

procedure TfrmDeliveryNoteCorrection.FormShow(Sender: TObject);
var
  theMaskID: Smallint;
  msk : String;
begin
  SetFixedLabels;

  WasDeleted := false;
  with dmAdo.adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add ('SELECT s.[Supplier Name], h.[OrderNumber], h.[DeliveryNoteNumber],');
    Sql.Add ('h.[FinalisedDateTime], h.[SupplierID]');
    Sql.Add ('FROM dbo.[HandHeldDeliveryFailureHeader] h, dbo.[Supplier] s');
    Sql.Add ('WHERE s.[Supplier Code] = h.[SupplierID]');
    Sql.Add ('AND h.[RecordID] = ' + RecordID);
    Open;

    dmADO.GetCurrentSupplierMask(FieldByName('Supplier Name').AsString, theMaskID, msk);
    edbxDeliveryNoteNumber.EditMask := msk;

    lblSupplier.Caption := FieldByName('Supplier Name').AsString;

    if FieldByName('OrderNumber').AsString <> '' then
    begin
      cmbStockOrders.Items.Add(FieldByName('OrderNumber').AsString);
      cmbStockOrders.ItemIndex := cmbStockOrders.Items.IndexOf(FieldByName('OrderNumber').AsString);
    end;

    edbxDeliveryNoteNumber.Text := FieldByName('DeliveryNoteNumber').AsString;
    dtpFinalised.DateTime := FieldByName('FinalisedDateTime').AsDateTime;
    thisSupplier := FieldByName('SupplierID').AsInteger;

     

    Close;
    Sql.Clear;
    Sql.Add ('SELECT so.[OrderNo]');
    Sql.Add ('FROM dbo.[StockOrder] so');
    Sql.Add ('INNER JOIN dbo.[Supplier] s');
    Sql.Add ('  ON s.[Supplier Name] = so.[Supplier]');
    Sql.Add ('WHERE s.[Supplier Code] = ' + inttostr(thisSupplier));
    Sql.Add ('  AND so.[Deleted] = 0');
    Sql.Add ('  AND (so.[Status] = ' + inttostr(so_New) + ' OR so.[Status] = ' + IntToStr(so_ConfirmationPending) +')');
    Sql.Add ('  AND  NOT EXISTS (SELECT [Order No] FROM dbo.[PurchHdrAztec] where [Order No] = so.[OrderNo])');
    Open;

    while not EOF do
    begin
      cmbStockOrders.Items.Add( FieldByName('OrderNo').AsString );
      Next;
    end;
  end;
end;

function TfrmDeliveryNoteCorrection.MergeWithExisting: Boolean;
begin
  Log.Event('MergeWithExisting; Entered Function.');
  Result := False;
  dmAdo.BeginTransaction;

  try
    with dmAdo.adoqrun do
    begin
      Close;
      SQL.Clear;
      Log.Event('MergeWithExisting; Executing zspMergeFailureDeliveryWithExisting ' + RecordID);
      Sql.Add('EXEC zspMergeFailureDeliveryWithExisting ' + RecordID);
      Open;

      if FieldByName('ErrorCode').AsInteger <> 0 then
      begin
        Log.Event('MergeWithExisting; zspMergeFailureDeliveryWithExisting ended with errors. Aborting.');
        dmAdo.RollbackTransaction;
        MessageDlg('An error occured while executing zspMergeFailureDeliveryWithExisting'
          +#13#10 + #13#10 + 'Please contact Zonal Support.', mtError, [mbOK], 0);
        Exit;
      end;

      Log.Event('MergeWithExisting; zspMergeFailureDeliveryWithExisting completed OK');
      Close;
      SQL.Clear;
      Log.Event('MergeWithExisting; Executing zspRemoveDeliveriesFromFailure ' + RecordID);
      Sql.Add('EXEC zspRemoveDeliveriesFromFailure ' + RecordID);
      Open;

      if FieldByName('ErrorCode').AsInteger <> 0 then
      begin
        Log.Event('MergeWithExisting; zspRemoveDeliveriesFromFailure ended with errors. Aborting.');
        dmAdo.RollbackTransaction;
        MessageDlg('An error occured while executing zspRemoveDeliveriesFromFailure'
          +#13#10 + #13#10 + 'Please contact Zonal Support.', mtError, [mbOK], 0);
        Exit;
      end;

      Log.Event('MergeWithExisting; zspMergeFailureDeliveryWithExisting completed OK');
      dmAdo.CommitTransaction;
      Result := True;
    end;
    except on e:Exception do
    begin
      Log.Event('MergeWithExisting; Error occured during procedure. ' + e.message);
      dmAdo.RollbackTransaction;
      Result := False;
      MessageDlg('An error has occured while importing the ' + GetLocalisedName(lsInvoice) + '. The error is reported as:'
        +#13#10 + #13#10 + e.Message
        + #13#10 + #13#10 + 'Contact Zonal Support for assistance.', mtError, [mbOK], 0);
    end;
  end;
end;

procedure TfrmDeliveryNoteCorrection.btnCloseClick(Sender: TObject);
begin
  Log.Event('btnCancelClick; Cancel clicked. Closing screen.');
  Close;
end;

procedure TfrmDeliveryNoteCorrection.OKBtnClick(Sender: TObject);
var
  msgStr : String;
  MergeMessage : String;
begin
  Log.Event('btnOKClick; OK Clicked');

  if not ValidateDeliveryNoteNumber then
    Exit;

  if not dmAdo.DeliveryDateValid(dtpFinalised.DateTime) then
  begin
    Log.Event('btnOKClick; Invalid Date Selected. Aborting.');
    dtpFinalised.DateTime := Date;
    Exit;
  end;

  with dmAdo.adoqrun do
  begin
    close;
    sql.Clear;

    //Are there any *unaccepted* delivery notes that match the selected one?
    sql.Add('SELECT p.[Delivery Note No.], p.[Supplier Name], [Order No]');
    sql.Add('FROM dbo.[purchhdr] p INNER JOIN dbo.[Supplier] s');
    sql.Add('ON p.[Supplier Name] = s.[Supplier Name]');
    sql.Add('WHERE s.[Supplier Code] = ' + IntToStr(thisSupplier));
    sql.Add('AND [delivery note no.] = ''' + edbxDeliveryNoteNumber.Text + '''');
    sql.Add('AND p.[Deleted] is NULL');
    open;

    if recordcount > 0 then
    begin
      if UKUSmode = 'UK' then
        msgStr := 'A '
      else
        msgStr := 'An ';

      MergeMessage := msgStr + GetLocalisedName(lsInvoice) +' for supplier ' +
        dmADO.RemoveQuotes(lblSupplier.Caption) + ' with '+ GetLocalisedName(lsInvoice) +
        ' No. ' + #39 + edbxDeliveryNoteNumber.Text + #39 + ' is already in the system.';
      if FieldByName('Order No').AsString <> '' then
        MergeMessage := MergeMessage + #13#10 + #13#10 + 'This ' + GetLocalisedName(lsInvoice) + ' has the Stock Order number ' + #39 + FieldByName('Order No').AsString + #39 + ' assigned to it.';
      MergeMessage := MergeMessage + #13#10 + #13#10 + 'Would you like to merge this ' + GetLocalisedName(lsInvoice) + ' with the existing one?';

      if MessageDlg(MergeMessage, mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
        if MergeWithExisting then
        begin
          MessageDlg('The ' + GetLocalisedName(lsinvoice) + ' "' + edbxDeliveryNoteNumber.Text + '" was successfully '
                    + ' merged into the system.', mtInformation, [mbOK], 0);
          WasDeleted := True;
          self.Close;
          Exit;
        end else
        begin
          MessageDlg('An error occured while executing zspTransferDeliveriesFromFailureToPurchase'
          +#13#10 + #13#10 + 'Please contact Zonal Support.', mtError, [mbOK], 0);
          Exit;
        end;
      end;
      edbxDeliveryNoteNumber.setfocus;
      exit;
      close;
    end;

    if not ValidateStockOrderNumberExists then
    begin
      Log.Event('btnOKClick; Invalid Stock Order number selected. Aborting.');
      cmbStockOrders.SetFocus;
      Exit;
    end;

    close;
    sql.Clear;
    sql.Add('select [date] from accpurhd');
    sql.Add('where [supplier name] = ' + QuotedStr(lblSupplier.Caption));
    sql.Add('and [delivery note no.] = ' + QuotedStr(edbxDeliveryNoteNumber.Text));
    open;
    if recordcount > 0 then
    begin
      showmessage('An accepted invoice for supplier ' + #39 + dmADO.RemoveQuotes(lblSupplier.Caption) +
       #39 + #13 + 'with invoice no. ' + #39 + edbxDeliveryNoteNumber.Text + #39 + ' is already in the system!');
       edbxDeliveryNoteNumber.setfocus;
       exit;
       close;
    end;
    close;
  end;

  Log.Event('btnOKClick; Checks complete. Starting update transaction');

  dmAdo.BeginTransaction;
  try
    with dmAdo.adoqrun do
    begin
      Close;
      Sql.Clear;
      Sql.Add('UPDATE dbo.[HandHeldDeliveryFailureHeader] SET [DeliveryNoteNumber] = :DelNoteNumber,');
      Sql.Add('[OrderNumber] = :OrderNumber, [FinalisedDateTime] = :Finalised');
      Sql.Add('WHERE [RecordID] = :RecID');
      Parameters.ParamByName('DelNoteNumber').Value := edbxDeliveryNoteNumber.Text;

      if cmbStockOrders.ItemIndex = 0 then
        Parameters.ParamByName('OrderNumber').Value := ''
      else
        Parameters.ParamByName('OrderNumber').Value := cmbStockOrders.Text;

      Parameters.ParamByName('Finalised').Value := dtpFinalised.DateTime;
      Parameters.ParamByName('RecID').Value := RecordID;
      ExecSql;
      Log.Event('btnOKClick; Updated holding table delivery note with any changes.');

      Close;
      Sql.Clear;
      Log.Event('btnOKClick; Executing zspTransferDeliveriesFromFailureToPurchase with parameter ' + RecordID + '.');
      Sql.Add('EXEC zspTransferDeliveriesFromFailureToPurchase ' + RecordID);
      Open;

      if FieldByName('ErrorCode').AsInteger <> 0 then
      begin
        Log.Event('btnOKClick; zspTransferDeliveriesFromFailureToPurchase returned with ErrorCode. Aborting.');
        dmAdo.RollbackTransaction;
        MessageDlg('An error occured while executing zspTransferDeliveriesFromFailureToPurchase'
          +#13#10 + #13#10 + 'Please contact Zonal Support.', mtError, [mbOK], 0);
        Exit;
      end;

      Close;
      Sql.Clear;
      Log.Event('btnOKClick; Executing zspRemoveDeliveriesFromFailure with parameter ' + RecordID + '.');
      Sql.Add('EXEC zspRemoveDeliveriesFromFailure ' + RecordID);
      Open;

      if FieldByName('ErrorCode').AsInteger <> 0 then
      begin
        Log.Event('btnOKClick; zspRemoveDeliveriesFromFailure returned with ErrorCode. Aborting.');
        dmAdo.RollbackTransaction;
        MessageDlg('An error occured while executing zspRemoveDeliveriesFromFailure'
          +#13#10 + #13#10 + 'Please contact Zonal Support.', mtError, [mbOK], 0);
        Exit;
      end;

      with dmAdo.adoQRun do
      begin
        Close;
        Sql.Clear;
        Sql.Add ('UPDATE dbo.[StockOrder]');
        Sql.Add ('SET [Status] = ' + inttostr(so_Closed));
        Sql.Add ('WHERE [OrderNo] = ' + QuotedStr( cmbStockOrders.Text ));
        ExecSql;
      end;

      WasDeleted := True;
      dmAdo.CommitTransaction;
      MessageDlg('The ' + GetLocalisedName(lsInvoice) + ' "' + edbxDeliveryNoteNumber.Text + '" was successfully '
                    + 'imported into the system.', mtInformation, [mbOK], 0);

      Log.Event('btnOKClick; Transfer from Holding to Purchases completed. Transaction commited.');
      Self.Close;
    end;
  except on e:Exception do
    begin
      dmAdo.RollbackTransaction;
      Log.Event('btnOKClick; Error transfering records. ' + e.message);
      MessageDlg('An error has occured while importing the ' + GetLocalisedName(lsInvoice) + '. The error is reported as:'
        +#13#10 + #13#10 + e.Message
        + #13#10 + #13#10 + 'Contact Zonal Support for assistance.', mtError, [mbOK], 0);
    end;
  end;

end;

procedure TfrmDeliveryNoteCorrection.SetRecordID(const Value: String);
begin

  FRecordID := Value;

end;

function TfrmDeliveryNoteCorrection.ValidateDeliveryNoteNumber: Boolean;
begin
  Result := True;

  if (edbxDeliveryNoteNumber.Text = '') or
     (edbxDeliveryNoteNumber.IsMasked and not (edbxDeliveryNoteNumber.Text = edbxDeliveryNoteNumber.EditText)) then
  begin
    Log.Event('ValidateDeliveryNoteNumber; Missing Devlivery Note Number. Aborting.');
    MessageDlg('You need to type in an ' + GetLocalisedName(lsInvoice) + ' number !', mtInformation, [mbOK], 0);
    edbxDeliveryNoteNumber.setfocus;
    Result := False;
  end;
end;

function TfrmDeliveryNoteCorrection.ValidateStockOrderNumberExists: Boolean;
begin

  Result := True;
  if cmbStockOrders.ItemIndex = 0 then
    Exit;

  with dmAdo.adoqRun do
  begin
    Close;
    Sql.Clear;
    sql.Add(Format('EXEC zspStockOrderNumberExists ''%s'', %d', [cmbStockOrders.Text, thisSupplier]));
    Open;
    if RecordCount = 0 then
    begin
      Log.Event('ValidateStockOrderNumber; Stock order number is not valid in the system. Aborting.');
      MessageDlg('The Stock Order number entered (' + cmbStockOrders.Text + ') is not available in the system.'
        +#13#10 + #13#10 + 'Please select an existing stock order number, or else select "' +
        cmbStockOrders.Items[0] + '"', mtInformation, [mbOK], 0);
      Result := False;
    end;
  end;


end;

procedure TfrmDeliveryNoteCorrection.SetFixedLabels;
begin
  lblStockOrder.Caption := GetLocalisedName(lsInventory);

  lblDeliveryNoteNo.Caption := GetLocalisedName(lsInvoice) + ' Number';

  cmbStockOrders.Items[0] := 'No ' + GetLocalisedName(lsInventory);
end;

end.
