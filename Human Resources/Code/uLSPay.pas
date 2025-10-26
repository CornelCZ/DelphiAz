unit uLSPay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Wwtable, Wwdatsrc, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  StdCtrls, Buttons, Wwquery, ADODB, Variants;

type
  TfLSPay = class(TForm)
    wwDataSource1: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    Label1: TLabel;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDel: TBitBtn;
    btnDone: TBitBtn;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    lblPanelName: TLabel;
    rbLSPay: TRadioButton;
    rbDays: TRadioButton;
    edDesc: TEdit;
    edValue: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblTotPay: TLabel;
    wwTable1: TADOTable;
    wwTable1Value: TCurrencyField;
    wwTable1Description: TStringField;
    wwTable1InsDT: TDateTimeField;
    wwTable1InsBy: TStringField;
    wwTable1SiteCode: TSmallintField;
    wwTable1WStart: TDateField;
    wwTable1SEC: TFloatField;
    wwTable1Deleted: TStringField;
    wwTable1LMBy: TStringField;
    wwTable1LMDT: TDateTimeField;
    qryRun: TADOQuery;
    rbHours: TRadioButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbLSPayClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateTotPay;
    { Private declarations }
  public
    { Public declarations }
    dayValue: double;
    hourValue: double;
    UserId: int64;
    thecurruser : string;
    doAdd : boolean;
    site : integer;
    wstart : tdatetime;
  end;

var
  fLSPay: TfLSPay;

implementation

uses uGlobals, uADO, dModule1;

{$R *.DFM}

procedure TfLSPay.btnAddClick(Sender: TObject);
begin
  lblpanelName.Caption := 'Add Extra Payment';
  rbLSPay.Checked := true;
  rbLSPayClick(self);
  edDesc.Text := '';
  edValue.Text := '';
  doAdd := true;
  panel1.Visible := true;
end;

procedure TfLSPay.btnEditClick(Sender: TObject);
begin
  doAdd := false;
  rbLSPay.Checked := true;
  rbLSPayClick(self);
  lblpanelName.Caption := 'Edit Extra Payment (current value: ' +
    formatfloat(currencyString + '0.00', wwtable1.FieldByName('value').asfloat) + ')';
  edDesc.Text := wwtable1.FieldByName('description').asstring;
  edValue.Text := formatfloat('0.00', wwtable1.FieldByName('value').asfloat);
  panel1.Visible := true;
end;

procedure TfLSPay.btnDelClick(Sender: TObject);
begin
  if MessageDlg('You are about to delete the payment with description:'+#13+#10+
    '"' + wwtable1.FieldByName('description').asstring + '"' +#13+#10+''+#13+#10+
    'Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    with wwtable1 do
    begin
      edit;
      FieldByName('deleted').asstring := 'Y';
      FieldByName('lmby').asstring := CurrentUser.UserName;
      FieldByName('lmdt').asdatetime := Now;
      post;
      refresh;
    end;

    wwDBGrid1.refresh;

    if wwtable1.RecordCount = 0 then
    begin
      btnEdit.Enabled := false;
    end
    else
    begin
      btnEdit.Enabled := true;
    end;
    btnDel.Enabled := btnEdit.Enabled;

    UpdateTotPay;
  end;
end;

procedure TfLSPay.UpdateTotPay;
begin
  with qryRun do
  begin
    close;
    open;

    lblTotPay.Caption := formatfloat(currencystring + '0.00', FieldByName('totval').asfloat);

    close;
  end;
end; // procedure..


procedure TfLSPay.FormShow(Sender: TObject);
begin
  wwtable1.open;

  if wwtable1.RecordCount = 0 then
  begin
    btnEdit.Enabled := false;
  end
  else
  begin
    btnEdit.Enabled := true;
  end;
  btnDel.Enabled := btnEdit.Enabled;
  UpdateTotPay;
end;

procedure TfLSPay.rbLSPayClick(Sender: TObject);
begin
  if rbLSPay.Checked then
  begin
    label6.Caption := 'Enter Lump Sum Payment (no currency symbol, e.g. 530.55)';
    edValue.Text := '';
  end
  else if rbDays.Checked then
  begin
    label6.Caption := 'Enter No. of Days to pay (e.g. 3.25)';
    edValue.Text := '';
  end
  else if rbHours.Checked then
  begin
    label6.Caption := 'Enter No. of Hours to pay (e.g. 2.75)';
    edValue.Text := '';
  end;
end;

procedure TfLSPay.BitBtn2Click(Sender: TObject);
begin
  panel1.Visible := false;
end;

procedure TfLSPay.BitBtn1Click(Sender: TObject);
var
  amount : double;
begin
  // validate value entry....
  try
    amount := strtofloat(edvalue.Text);
  except
    on exception do
    begin
            showmessage('"' + edValue.text + '" is not a valid entry!' + #13 +
        'Type a number (without using any currency sign), e.g. 12.56');
      edValue.text := '';
      edValue.SetFocus;
      edValue.SelectAll;
      exit;
    end;
  end;

  if rbDays.Checked then
    amount := amount * dayValue
  else if rbHours.Checked then
    amount := amount * hourValue;

  with wwTable1 do
  begin
    if doAdd then
    begin
      Insert;
      FieldByName('sitecode').asinteger := site;
      FieldByName('wstart').asdatetime := wstart;
      FieldByName('sec').asfloat := UserId;
      FieldByName('insby').asstring := CurrentUser.UserName;
      FieldByName('insdt').asdatetime := Now;
      FieldByName('value').asfloat := amount;
      FieldByName('description').asstring := edDesc.Text;
      FieldByName('lmby').asstring := CurrentUser.UserName;
      FieldByName('lmdt').asdatetime := Now;
      //FieldByName('Deleted').asstring := '';
      FieldByName('Deleted').value := NULL;
      post;
    end
    else
    begin
      Edit;
      FieldByName('value').asfloat := amount;
      FieldByName('description').asstring := edDesc.Text;
      FieldByName('lmby').asstring := CurrentUser.UserName;
      FieldByName('lmdt').asdatetime := Now;
      Post;
    end;
    Refresh;
  end;

  wwDBGrid1.refresh;
  if wwtable1.RecordCount = 0 then
  begin
    btnEdit.Enabled := false;
  end
  else
  begin
    btnEdit.Enabled := true;
  end;
  btnDel.Enabled := btnEdit.Enabled;

  UpdateTotPay;
  panel1.Visible := false;  
end;

procedure TfLSPay.wwDBGrid1DblClick(Sender: TObject);
begin
  if btnEdit.Enabled then
    btnEditClick(self);
end;

procedure TfLSPay.FormCreate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self, EMP_EXTRA_PAYMENT);
end;

end.
