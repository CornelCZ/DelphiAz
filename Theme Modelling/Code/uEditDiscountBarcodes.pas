unit uEditDiscountBarcodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, Wwdbigrd, Wwdbgrid, wwdblook,
  ActnList, Buttons, ExtCtrls;

type
  TEditDiscountBarcodes = class(TForm)
    qryDiscountBarcodes: TADOQuery;
    dsDiscountBarcodes: TDataSource;
    qryDiscountBarcodesBarcode: TStringField;
    qryDiscountBarcodesFromPromotionalFooter: TBooleanField;
    qryDiscountBarcodesPromotionalFooterID: TIntegerField;
    ActionList1: TActionList;
    actEnterBarcode: TAction;
    actDeleteBarcode: TAction;
    qryDiscountBarcodesPromotionalFooterName: TStringField;
    qryLookUpFooterBarcodes: TADOQuery;
    qryLookUpFooterBarcodesName: TStringField;
    qryLookUpFooterBarcodesId: TIntegerField;
    qryLookUpFooterBarcodesBarcode: TStringField;
    pnlTop: TPanel;
    lblDiscount: TLabel;
    pnlData: TPanel;
    pnlGrid: TPanel;
    lblAssignedBarcodes: TLabel;
    grdDiscountBarcodes: TwwDBGrid;
    pnlAddBarcodes: TPanel;
    pnlBottom: TPanel;
    btnDeleteBarcode: TButton;
    pnlEnterBarcode: TPanel;
    pnlFooterBarcode: TPanel;
    lblSelectFooterBarcode: TLabel;
    luFooterBarcodes: TwwDBLookupCombo;
    edtEnterBarcode: TEdit;
    Label1: TLabel;
    btnNewBarcode: TButton;
    pnlButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    lblDiscountName: TLabel;
    qryEnteredBarcodeExists: TADOQuery;
    qryFooterBarcodeExists: TADOQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure actEnterBarcodeExecute(Sender: TObject);
    procedure luFooterBarcodesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure actDeleteBarcodeExecute(Sender: TObject);
    procedure actDeleteBarcodeUpdate(Sender: TObject);
    procedure actEnterBarcodeUpdate(Sender: TObject);
  private
    { Private declarations }
    BarcodesModified: Boolean;
    DiscountID: Integer;
    procedure RefreshPromotionalFooterLookup;
    function EnteredBarcodeExists(Barcode : String): Boolean;
    procedure CheckFooterBarcode(Barcode : String; FooterID: integer);
  public
    { Public declarations }
    class function AssignDiscountBarcodes(_DiscountID: Integer; DiscountName: String): Boolean;
  end;


implementation

uses uADO, uAztecLog, Useful;

{$R *.dfm}

class function TEditDiscountBarcodes.AssignDiscountBarcodes(_DiscountID: Integer; DiscountName: String): Boolean;
var
  EditDiscountBarcodes: TEditDiscountBarcodes;
begin
  EditDiscountBarcodes := TEditDiscountBarcodes.Create(nil);

  with EditDiscountBarcodes do
  try
    lblDiscountName.Caption := DiscountName;
    Log('Opening Discount Barcodes form for Discount "' + lblDiscountName.Caption + '"');
    DiscountID := _DiscountID;
    qryLookUpFooterBarcodes.SQL.Text :=
      StringReplace(qryLookUpFooterBarcodes.SQL.Text, ':DiscountID', IntToStr(DiscountID), [rfIgnoreCase]);
    qryDiscountBarcodes.Open;
    RefreshPromotionalFooterLookup;
    BarcodesModified := FALSE;
    if (ShowModal = mrOK) then
      Result := BarcodesModified
    else
      Result := FALSE;
  finally
    FreeAndNil(EditDiscountBarcodes);
  end;
end;

procedure TEditDiscountBarcodes.btnCancelClick(Sender: TObject);
begin
  Log('Changes to Discount "' + lblDiscountName.Caption + '" barcodes cancelled');
  Close;
end;

procedure TEditDiscountBarcodes.actEnterBarcodeExecute(Sender: TObject);
begin
  if (edtEnterBarcode.Text <> '') and (Length(edtEnterBarcode.Text) <> 12) and not IsNumeric(edtEnterBarcode.Text) then
  begin
    MessageDlg('Please enter a 12-digit barcode or delete the barcode before continuing.', mtInformation, [mbOK], 0);
    edtEnterBarcode.SetFocus;
    Exit;
  end
  else if not IsValidBarcode(edtEnterBarcode.Text) then
  begin
    MessageDlg('Invalid barcode entered.  Please re-enter.', mtInformation, [mbOK], 0);
    edtEnterBarcode.SetFocus;
    Exit;
  end
  else if EnteredBarcodeExists(edtEnterBarcode.Text) then
  begin
    edtEnterBarcode.SetFocus;
    Exit;
  end;

  qryDiscountBarcodes.Insert;
  qryDiscountBarcodesBarcode.value := edtEnterBarcode.Text;
  qryDiscountBarcodesFromPromotionalFooter.Value := FALSE;
  qryDiscountBarcodes.Post;
  grdDiscountBarcodes.RefreshDisplay;
  BarcodesModified := TRUE;
  Log('New barcode entered: "' + edtEnterBarcode.Text + '"');
  edtEnterBarcode.Clear;
end;

procedure TEditDiscountBarcodes.luFooterBarcodesCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);

  function PromoFooterAlreadyAdded: Boolean;
  var
    Barcode: String;
    FooterName: String;
  begin
    Barcode := LookUpTable.FieldByName('Barcode').AsString;
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('SELECT Barcode FROM #DiscountBarcodes WHERE Barcode = ' + LookUpTable.FieldByName('Barcode').AsString);
      Open;
      Result := RecordCount > 0;
      if Result then
      begin
        FooterName := LookupTable.FieldByName('Name').AsString;
        MessageDlg(Format('Barcode %s referenced by Promotional Footer ''%s'' is already in use.',[Barcode, FooterName]),
          mtInformation,
          [mbOK],
          0);
      end;
    end;
  end;

begin
  if modified
    and (TwwDBLookUpCombo(Sender).Text <> '<None>')
    and (TwwDBLookUpCombo(Sender).Text <> '')
    and not PromoFooterAlreadyAdded then
  begin
    CheckFooterBarcode(LookUpTable.FieldByName('Barcode').AsString, LookUpTable.FieldByName('Id').AsInteger);
    qryDiscountBarcodes.Insert;
    qryDiscountBarcodesPromotionalFooterID.value := LookupTable.FieldByName('Id').AsInteger;
    qryDiscountBarcodesBarcode.value := LookupTable.FieldByName('Barcode').AsString;
    qryDiscountBarcodesFromPromotionalFooter.Value := TRUE;
    qryDiscountBarcodesPromotionalFooterName.Value := LookupTable.FieldByName('Name').AsString;
    qryDiscountBarcodes.Post;
    grdDiscountBarcodes.RefreshDisplay;
    RefreshPromotionalFooterLookup;
    BarcodesModified := TRUE;
    Log('Promotional Footer "' + qryDiscountBarcodesPromotionalFooterName.Value + '" Barcode added');
  end;
end;

procedure TEditDiscountBarcodes.actDeleteBarcodeExecute(Sender: TObject);
begin
  qryDiscountBarcodes.Delete;
  RefreshPromotionalFooterLookup;
  BarcodesModified := TRUE;
end;

procedure TEditDiscountBarcodes.actDeleteBarcodeUpdate(Sender: TObject);
begin
  actDeleteBarcode.Enabled :=
    (qryDiscountBarcodes.RecordCount > 0) and
    (qryDiscountBarcodes.State = dsBrowse);

  btnOK.Enabled := BarcodesModified;
  luFooterBarcodes.Enabled := (qryLookUpFooterBarcodes.RecordCount > 0);
end;

procedure TEditDiscountBarcodes.RefreshPromotionalFooterLookup;
begin
  qryLookUpFooterBarcodes.Close;
  qryLookUpFooterBarcodes.Open;
  qryLookUpFooterBarcodes.First;
end;

function TEditDiscountBarcodes.EnteredBarcodeExists(Barcode : String): Boolean;
begin
  with qryEnteredBarcodeExists do
  try
    Close;
    Parameters.ParamByName('CheckBarcode').Value := Barcode;
    Parameters.ParamByName('DiscountID').Value := DiscountID;
    Open;
    Result := FieldByName('BarcodeExists').AsBoolean;
    if Result then
    begin
      MessageDlg(StringReplace(FieldByName('WhereFound').AsString, '\n', #13#10, [rfIgnoreCase,rfReplaceAll]), mtInformation, [mbOK], 0);
    end;
  finally
    Close;
  end;
end;

procedure TEditDiscountBarcodes.CheckFooterBarcode(Barcode : String; FooterID: integer);
begin
  with qryFooterBarcodeExists do
  try
    Close;
    Parameters.ParamByName('CheckBarcode').Value := Barcode;
    Parameters.ParamByName('FooterID').Value := FooterID;
    Open;
    if FieldByName('BarcodeUsed').AsBoolean then
    begin
      MessageDlg(StringReplace(FieldByName('WhereFound').AsString, '\n', #13#10, [rfIgnoreCase,rfReplaceAll]),  mtInformation, [mbOK], 0);
    end;
  finally
    Close;
  end;
end;

procedure TEditDiscountBarcodes.actEnterBarcodeUpdate(Sender: TObject);
begin
  actEnterBarcode.Enabled := (edtEnterBarcode.Text <> '');
end;

end.
