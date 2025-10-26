unit uMaintVATBand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB, ExtCtrls, wwdblook, DBCtrls,
  ActnList;

type
  TfMaintVATBand = class(TForm)
    MainPanel: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    edtName: TEdit;
    tblTaxRules: TADOTable;
    pnlHeading: TPanel;
    qrySubjectToTax: TADOQuery;
    pnlTop: TPanel;
    tblTaxTables: TADOTable;
    tblTaxTablesTaxTableID: TIntegerField;
    tblTaxTablesName: TStringField;
    cbExclusive: TCheckBox;
    cbPurchasedGoods: TCheckBox;
    cbTaxOnTax: TCheckBox;
    RateEdit: TEdit;
    RateLabel: TLabel;
    lblPosName: TLabel;
    mmPosName: TMemo;
    UseTaxTableLabel: TLabel;
    lkupTaxTables: TwwDBLookupCombo;
    cbServiceCharge: TCheckBox;
    lblInclusiveTaxRuleToApply: TLabel;
    luSubjectToTax: TwwDBLookupCombo;
    Bevel1: TBevel;
    qryHotelDivisions: TADOQuery;
    lblHotelDivisionAssigned: TLabel;
    cboHotelDivisionAssigned: TwwDBLookupCombo;
    DescriptionMemo: TMemo;
    Label1: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbExclusiveClick(Sender: TObject);
    procedure cbServiceChargeClick(Sender: TObject);
    procedure tblTaxTablesAfterOpen(DataSet: TDataSet);
    procedure mmPosNameChange(Sender: TObject);
    procedure RateEditKeyPress(Sender: TObject; var Key: Char);
    procedure RateEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure ApplyRegionalDefaults;
    procedure DoLocalSpecificChanges;
    { Private declarations }
  public
    NewIx : Integer;
    DoRateEditKeyPress: Boolean;
  end;

var
  fMaintVATBand: TfMaintVATBand;

implementation

uses uLineEdit, uDatabaseADO, uADO, uLog, uGlobals;

{$R *.dfm}

const
  NONE_TEXT = '<None>';

procedure TfMaintVATBand.btnOKClick(Sender: TObject);
var
  Rate: real;
  TaxTableID: String;
  Description: String;
  InclusiveTax: String;
begin
  if edtName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Tax Rule.');
    edtName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if (lkupTaxTables.Text = '') then
  begin
    try
      Rate := StrToFloat(RateEdit.Text);
    except
      ShowMessage('Please supply a valid Rate Amount.');
      RateEdit.SetFocus;
      ModalResult := mrNone;
      Exit;
    end;

    if not ((Rate >= 0) and (Rate < 100)) then
    begin
      ShowMessage('Rate amount must be between 0 and 100.');
      RateEdit.SetFocus;
      ModalResult := mrNone;
      Exit;
    end;

    TaxTableID := 'null'
  end
  else begin
    TaxTableID := tblTaxTables.FieldByName('TaxTableID').AsString;
  end;

  if Trim(mmPosName.Text) = '' then
    {Use the tax Rule name as the PosName. Placing it in the memo will use
     existing functionality to do any required spacing across multiple lines.}
    mmPosName.Text := edtName.Text;

  if DescriptionMemo.Text = '' then
    Description := 'null'
  else
    Description := QuotedStr(DescriptionMemo.Text);

  if VarIsNull(qrySubjectToTax.FieldByName('Index No').Value) then
    InclusiveTax := 'null'
  else
    InclusiveTax := qrySubjectToTax.FieldByName('Index No').AsString;

  Log.Event('Create Tax Rule - ' + QuotedStr(edtName.Text));

  //New stuff
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertTaxRule %s,%s,%s,%d,'+
                   '%d,%d,%s,%s,%s,%s,%d,%s,%d,@ID OUTPUT',
            [QuotedStr(edtName.Text),
             Description,
             RateEdit.Text,
             Integer(cbTaxOnTax.Checked),
             Integer(cbPurchasedGoods.Checked),
             Integer(cbExclusive.Checked),
             QuotedStr(mmPosName.Lines[0]),
             QuotedStr(mmPosName.Lines[1]),
             QuotedStr(mmPosName.Lines[2]),
             TaxTableID,
             Integer(cbServiceCharge.Checked),
             InclusiveTax,
             qryHotelDivisions.FieldByName('HotelDivisionID').AsInteger
             ]));
    SQL.Add('SELECT @ID as ID');
    try
      Open;

      NewIx := -1;
      if not EOF and not FieldByName('ID').IsNull then
        NewIx := FieldByName('ID').AsInteger;

      Close;

      ProductsDB.AddVATBand(edtName.Text, NewIx);
    except
      on E:Exception do
      begin
        log.Event('Create Tax Rule Failure - ' + E.Message);
        MessageDlg('Failed to create tax rule: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfMaintVATBand.ApplyRegionalDefaults;
begin
  if UKUSmode = 'US' then
  begin
    cbTaxOnTax.Checked := True;
    cbExclusive.Checked := True;
  end
end;

procedure TfMaintVATBand.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_VATBAND_FORM );
  qrySubjectToTax.Open;
  qryHotelDivisions.Open;
  TblTaxTables.Open;
  luSubjectToTax.LookupValue := NONE_TEXT;
  ApplyRegionalDefaults;

  DoLocalSpecificChanges;

  cbExclusiveClick(cbExclusive);
end;

procedure TfMaintVATBand.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qrySubjectToTax.Close;
  qryHotelDivisions.Close;
end;

procedure TfMaintVATBand.cbExclusiveClick(Sender: TObject);
begin
  with Sender as TCheckBox do
  begin
    lblPosName.Enabled := Checked;
    mmPosName.Enabled := Checked;

    cbServiceCharge.Enabled := Checked;

    luSubjectToTax.Enabled := Checked and cbServiceCharge.Checked;
    lblInclusiveTaxRuleToApply.Enabled := Checked and cbServiceCharge.Checked;

    UseTaxTableLabel.Enabled := Checked;
    lkupTaxTables.Enabled := Checked;
  end;
end;

procedure TfMaintVATBand.cbServiceChargeClick(Sender: TObject);
var
  HasHotelDivisions: Boolean;
begin
  with Sender as TCheckBox do
  begin
    HasHotelDivisions := (qryHotelDivisions.RecordCount > 0);
    cboHotelDivisionAssigned.Enabled := HasHotelDivisions and Checked;
    lblHotelDivisionAssigned.Enabled := HasHotelDivisions and Checked;

    luSubjectToTax.Enabled := Checked and cbExclusive.Checked;
    lblInclusiveTaxRuleToApply.Enabled := Checked and cbExclusive.Checked;

    if not Checked then
      luSubjectToTax.LookupValue := NONE_TEXT;
  end;
end;

procedure TfMaintVATBand.tblTaxTablesAfterOpen(DataSet: TDataSet);
begin
  lkupTaxTables.Enabled := DataSet.RecordCount > 0;
  if DataSet.RecordCount = 0 then
  begin
    lkupTaxTables.Text := '';
  end;
end;

procedure TfMaintVATBand.mmPosNameChange(Sender: TObject);
begin
  if mmPosName.Lines.Count > 3 then
  begin
    mmPosName.Text := mmPosName.Lines[0] + mmPosName.Lines[1] +
      mmPosName.Lines[2] + Copy(mmPosName.Lines[3],1,Length(mmPosName.Lines[3]) -1);
  end;
end;

procedure TfMaintVATBand.RateEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not DoRateEditKeyPress then Exit;

  if not( (Key in ['0'..'9'])
    or    ((Key = '.') and (Pos('.',(Sender as TEdit).Text) = 0)) ) then
    Key := #0;
end;

procedure TfMaintVATBand.RateEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DoRateEditKeyPress := True;
  if (Key in [VK_BACK, VK_DELETE, VK_ESCAPE, VK_LEFT, VK_RIGHT]) then
    DoRateEditKeyPress := False;
end;

procedure TfMaintVATBand.DoLocalSpecificChanges;
var
  Offset: Integer;
begin
  if (GetLocale = 'US') then
  begin
    UseTaxTableLabel.Visible := True;
    lkupTaxTables.Visible := True;
  end
  else begin
    Offset := (pnlTop.Height - lkupTaxTables.top);
    pnlTop.Height := pnlTop.Height - Offset;
    Height := Height - Offset;
  end;
end;

end.
