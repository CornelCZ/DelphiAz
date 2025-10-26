unit uNewInvDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, wwdblook, Db, DBTables, Mask, Dialogs,
  ComCtrls, ADODB, Math;

type
  TfNewInvDlg = class(TForm)
    OKBtn: TBitBtn;
    BitBtn2: TBitBtn;
    SupplierLookUp: TwwDBLookupCombo;
    Label1: TLabel;
    lblInvoiceNumber: TLabel;
    Label3: TLabel;
    dtDateReceived: TDateTimePicker;
    qrySupplier: TADOQuery;
    wwqRun: TADOQuery;
    InvoiceNoEdit: TMaskEdit;
    Label4: TLabel;
    qStockOrder: TADOQuery;
    dsSupplier: TDataSource;
    StockOrderCombo: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure SupplierLookUpCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure InvoiceNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure dtDateReceivedKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SupplierLookUpChange(Sender: TObject);
    procedure StockOrderComboChange(Sender: TObject);
    procedure StockOrderComboCloseUp(Sender: TObject);
  private
    { Private declarations }
    procedure FillStockOrderList;
    procedure SetOrderNo;
    function StockOrderHasValidItems: Boolean;
  public
    { Public declarations }
    thedate : tdatetime;
    theMaskID: Smallint;
    theOrderNo: string;
  end;

var
  fnewinvdlg: Tfnewinvdlg;

implementation

uses
  uMainMenu, uADO, uGlobals, uLog;

const
  NO_ORDER = 'No stock order';

{$R *.DFM}

procedure TfNewInvDlg.FormShow(Sender: TObject);
begin
  fNewInvDlg.Caption := 'Add ' + GetLocalisedName(lsInvoice) + '...';
  lblInvoiceNumber.Caption := GetLocalisedName(lsInvoice) + ' No. (max. 15 characters)';

  dtDateReceived.Date := Date;

  try
    qrySupplier.Open;
    qStockOrder.Open;

    SupplierLookUp.SetFocus;
    SupplierLookUp.DropDown;
  except
    on E: Exception do
    begin
      Log.Event('fNewInvDlg; FormShow: ' + E.Message + '; ' + qrySupplier.SQL.Text);

      raise;
    end;
  end;
end;

procedure Tfnewinvdlg.SupplierLookUpCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  StockOrderCombo.Enabled := (qStockOrder.RecordCount > 0);
  FillStockOrderList;
  if StockOrderCombo.Enabled then
  begin
    StockOrderCombo.SetFocus;
    StockOrderCombo.DroppedDown := true;
  end
  else
  begin
    InvoiceNoEdit.SetFocus;
  end;
end;

procedure Tfnewinvdlg.InvoiceNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     dtDateReceived.SetFocus;
end;

procedure Tfnewinvdlg.OKBtnClick(Sender: TObject);
var
  MessageString, inv, aStr: string;
begin
  log.event('fnewinvdlg; OKBtnClick');
  inv := GetLocalisedName(lsInvoice);
  if Copy(inv, 1, 1) = 'I' then
    aStr := 'An '
  else
    aStr := 'A ';

  if SupplierLookUp.Text = '' then
  begin
     ShowMessage('You need to choose a supplier!');
     InvoiceNoEdit.Text := '';
     SupplierLookUp.SetFocus;
     Exit;
  end;

  if (TrimRight(InvoiceNoEdit.Text) = '') or
     (InvoiceNoEdit.IsMasked and not (InvoiceNoEdit.Text = InvoiceNoEdit.EditText)) then
  begin
    ShowMessage('You need to type in ' + LowerCase(aStr + inv) + ' number!');
    InvoiceNoEdit.SetFocus;
    Exit;
  end;

  // Job 16273
  if not dmAdo.DeliveryDateValid( dtDateReceived.DateTime ) then
  begin
    dtDateReceived.DateTime := Date;
    Exit;
  end;

  if (theOrderNo <> '') and not StockOrderHasValidItems then
  begin
    MessageDlg('The ' + GetLocalisedName(lsInvoice) + ' cannot be created from Stock Order "' + theOrderNo + '"' + #13 +
               'because it does not have any items with an amount greater than zero.', mtError, [mbOK],0);
    StockOrderCombo.SetFocus;
    Exit;
  end;

  with wwqRun do
  begin
    try
      Close;
      SQL.Clear;
      SQL.Add('SELECT [Date]');
      SQL.Add('FROM dbo.[PurchHdr]');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(SupplierLookUp.Text));
      SQL.Add('  AND [Delivery Note No.] = ' + QuotedStr(InvoiceNoEdit.Text));
      SQL.Add('  AND UPPER(ISNULL([Deleted],''N'')) = ''N''');
      Open;

      if RecordCount > 0 then
      begin
        if UKUSMode = 'UK' then
          MessageString := 'A '
        else
          MessageString := 'An ';

       MessageDlg(aStr + LowerCase(inv) + ' for supplier ' +
         dmADO.RemoveQuotes(SupplierLookUp.Text) + #13 + ' with '+ inv +
         ' No. ' + #39 + InvoiceNoEdit.Text + #39 + ' is already in the system!', mtInformation, [mbOK],0);
       InvoiceNoEdit.SetFocus;
       Close;

       Exit;
      end;

      Close;
      SQL.Clear;
      SQL.Add('SELECT [Date]');
      SQL.Add('FROM dbo.[AccPurHd]');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(SupplierLookUp.Text));
      SQL.Add('  AND [Delivery Note No.] = ' + QuotedStr(InvoiceNoEdit.Text));
      Open;

      if RecordCount > 0 then
      begin
        ShowMessage('An accepted ' + LowerCase(inv) + ' for supplier ' + #39 + dmADO.RemoveQuotes(SupplierLookUp.Text) +
          #39 + #13 + 'with ' + inv + ' No. ' + #39 + InvoiceNoEdit.Text + #39 + ' is already in the system!');
        InvoiceNoEdit.SetFocus;
        Close;

        Exit;
      end;

      Close;
    except
      on E: Exception do
      begin
        Log.Event('fNewInvDlg; OKBtnClick: Checking for duplicate invoices. ' +
          E.Message + '; ' + wwqRun.SQL.Text);

        raise;
      end;
    end;
  end;

  ModalResult := mrOk;
end;

procedure Tfnewinvdlg.dtDateReceivedKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    OKBtn.setfocus;
end;

procedure Tfnewinvdlg.FormCreate(Sender: TObject);
begin
  log.event('fnewinvdlg; FormCreate');
  if purchHelpExists then
    setHelpContextID(self, HLP_ADD_DELIVERY_NOTE_DLG)
end;

procedure Tfnewinvdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('fnewinvdlg; FormClose');
end;

procedure Tfnewinvdlg.SupplierLookUpChange(Sender: TObject);
var
  msk: string;
begin
  // get the mask for the selected supplier and apply it to InvoiceNoEdit
  // and get the maskID for passing to uInvFrm
  dmADO.GetCurrentSupplierMask(SupplierLookUp.Text, theMaskID, msk);
  InvoiceNoEdit.EditMask := msk;
end;

procedure Tfnewinvdlg.FillStockOrderList;
begin
  StockOrderCombo.Items.Clear;
  qStockOrder.First;
  while not qStockOrder.Eof do
  begin
    StockOrderCombo.Items.Add(qStockOrder.FieldByName('OrderNo').AsString);
    qStockOrder.Next;
  end;
  StockOrderCombo.Items.Add(NO_ORDER);
  StockOrderCombo.ItemIndex := 0;
  SetOrderNo;
end;

procedure Tfnewinvdlg.StockOrderComboChange(Sender: TObject);
begin
  SetOrderNo;
end;

procedure Tfnewinvdlg.SetOrderNo;
begin
  if (StockOrderCombo.Text = NO_ORDER) then
    theOrderNo := ''
  else
    theOrderNo := StockOrderCombo.Text;
end;

procedure Tfnewinvdlg.StockOrderComboCloseUp(Sender: TObject);
begin
  InvoiceNoEdit.SetFocus;
end;

function Tfnewinvdlg.StockOrderHasValidItems: Boolean;
var
  stockItemQry: TADOQuery;
begin
  stockItemQry := TADOQuery.Create(nil);
  with stockItemQry do
  try
    Connection := dmADO.AztecConn;
    SQL.Text :=
      'DECLARE ' +
      '  @OrderNo VARCHAR(16), ' +
      '  @SiteCode Int ' +
      'SET @SiteCode = ' + IntToStr(SiteCode) + ' ' +
      'SET @OrderNo = ' + QuotedStr(theOrderNo) + ' ' +
      'SELECT COUNT(*) AS ValidItemCount ' +
      'FROM StockOrderDetail ' +
      'WHERE (OrderNo = @OrderNo) ' +
      'AND (SiteCode = @SiteCode) ' +
      'AND ISNULL(Amount,0) <> 0 ';
      Open;
      Result := (FieldByName('ValidItemCount').AsInteger <> 0);
  finally
    Close;
    FreeAndNil(stockItemQry);
  end;
end;

end.
