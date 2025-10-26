unit uEditBarcodeRange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Mask, wwdbedit, Wwdbspin, wwdblook,
  ExtCtrls, ActnList, uADOBarcodeRanges;

type

  TRangeEditDisplayType = (EditRange, AddRange);

  TfrmEditBarcodeRange = class(TForm)
    Panel1: TPanel;
    lblDescription: TLabel;
    edtDescription: TEdit;
    lblRangeStart: TLabel;
    edtRangeStart: TEdit;
    lblRangeEnd: TLabel;
    edtRangeEnd: TEdit;
    Panel2: TPanel;
    btOk: TButton;
    btCancel: TButton;
    procedure btOkClick(Sender: TObject);
    procedure edtRangeStartKeyPress(Sender: TObject; var Key: Char);
    procedure edtRangeStartChange(Sender: TObject);
    procedure edtRangeStartEnter(Sender: TObject);
  private
    { Private declarations }
    BarcodeRangeID : int64;
    tTempRange : String;
    function overlapsExistingRange(vStart, vEnd : String) : Boolean;
    function hasExceptionsOutSideRange(vStart, vEnd : String) : Boolean;
    function ExternalBarcodesInRange(vStart, vEnd : String): Boolean;
    function DescriptionAlreadyExists(Description: string): Boolean;
  public
    { Public declarations }
  end;

function AddBarcodeRange(BarcodeSource: TBarcodeRangeSource; var NewBarcodeRangeID: int64; EntityCode: Double = 0): Boolean;
function EditBarcodeRange(theBarcodeRangeID: Int64): Boolean;


implementation

uses useful, uLog;

{$R *.dfm}

function AddBarcodeRange(BarcodeSource: TBarcodeRangeSource; var NewBarcodeRangeID: int64; EntityCode: Double = 0): Boolean;
var
  Dlg : TfrmEditBarcodeRange;
begin
  Result := FALSE;
  Dlg := nil;
  try
    Dlg := TfrmEditBarcodeRange.Create(nil);

    Dlg.Caption := 'Add Barcode Range';
    if Dlg.ShowModal = mrOk then
      with dmBarcodeRanges do
      begin
        NewBarcodeRangeID := GetNewId('ThemeBarcodeRange_repl','BarcodeRangeID');
        qInsertBarcodeRange.Parameters.ParamByName('barcodeRangeID').Value := NewBarcodeRangeID;
        qInsertBarcodeRange.Parameters.ParamByName('description').Value := Dlg.edtDescription.Text;
        qInsertBarcodeRange.Parameters.ParamByName('startValue').Value := Dlg.edtRangeStart.Text;
        qInsertBarcodeRange.Parameters.ParamByName('endValue').Value := Dlg.edtRangeEnd.Text;
        qInsertBarcodeRange.Parameters.ParamByName('source').Value := GetBarcodeRangeSourceAsInt(BarcodeSource);
        qInsertBarcodeRange.ExecSQL;
        if (BarcodeSource = brsProduct) then
        begin
          qInsertProductBarcodeRange.Parameters.ParamByName('entityCode').Value := EntityCode;
          qInsertProductBarcodeRange.Parameters.ParamByName('barcodeRangeID').Value := NewBarcodeRangeID;
          qInsertProductBarcodeRange.ExecSQL;
        end;
        Result := TRUE;
      end;
  finally
    Dlg.Free;
  end;
end;


function EditBarcodeRange(theBarcodeRangeID: Int64): Boolean;
var
  Dlg : TfrmEditBarcodeRange;
begin
  Result := FALSE;
  Dlg := nil;
  try
    Dlg := TfrmEditBarcodeRange.Create(nil);
    Dlg.Caption := 'Edit Barcode Range';
    with dmBarcodeRanges.qAllBarcodeRanges do
    begin
      Dlg.BarcodeRangeID := theBarcodeRangeID;
      Close;
      Open;
      Locate('BarcodeRangeID', theBarcodeRangeID,[]);
      Dlg.edtDescription.Text := FieldByName('Description').AsString;
      Dlg.edtRangeStart.Text := FieldByName('StartValue').AsString;
      Dlg.edtRangeEnd.Text := FieldByName('EndValue').AsString;
    end;
    if Dlg.ShowModal = mrOk then
    begin
      with dmBarcodeRanges.qAllBarcodeRanges do
      begin
        Open;
        Edit;
        FieldByName('Description').AsString := Dlg.edtDescription.Text;
        FieldByName('StartValue').AsString := Dlg.edtRangeStart.Text;
        FieldByName('EndValue').AsString := Dlg.edtRangeEnd.Text;
        Post;
        Close;
      end;
      Result := TRUE;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmEditBarcodeRange.btOkClick(Sender: TObject);
begin
  if edtDescription.Text = '' then
    raise Exception.Create('Description cannot be blank');

  edtRangeStart.Text := Trim(edtRangeStart.Text);
  edtRangeEnd.Text := Trim(edtRangeEnd.Text);

  if not IsNumeric(edtRangeStart.Text) then
    raise Exception.Create('Range start is invalid');
    
  if not IsNumeric(edtRangeEnd.Text) then
    raise Exception.Create('Range end is invalid');

  if not StringGreaterThan(edtRangeStart.Text, '0') then
    raise Exception.Create('Range start must be greater than 0');

  if StringGreaterThan(edtRangeStart.Text, edtRangeEnd.Text) then
    raise Exception.Create('Range start cannot be greater than range end');

  if hasExceptionsOutSideRange(Trim(edtRangeStart.Text), Trim(edtRangeEnd.Text)) then
     raise Exception.Create('There are exceptions outside the new barcode range.');

  // Overlap check
  if overlapsExistingRange(Trim(edtRangeStart.Text), Trim(edtRangeEnd.Text)) then
    raise Exception.Create('New range would overlap an existing range.');

  if ExternalBarcodesInRange(Trim(edtRangeStart.Text), Trim(edtRangeEnd.Text)) then
    raise Exception.Create('There are product barcodes which would be in this range.');

  if DescriptionAlreadyExists(Trim(edtDescription.Text)) then
    raise Exception.Create('A barcode range already exists with the description ' + edtDescription.Text);

  ModalResult := mrOk;
end;

function TfrmEditBarcodeRange.overlapsExistingRange(vStart, vEnd : String) : Boolean;
begin
  with dmBarcodeRanges do
  begin
    adoqRun.SQL.Text := Format(
      'select * from ThemeBarcodeRange where dbo.fnBarCodeInRange(StartValue, EndValue, %s, %s) = 1 and BarcodeRangeId <> %d',
      [QuotedStr(vStart), QuotedStr(vEnd), BarcodeRangeID]
    );

    adoqRun.Open;
    result := adoqRun.RecordCount > 0;
    adoqRun.Close;
  end;
end;

function TfrmEditBarcodeRange.hasExceptionsOutSideRange(vStart, vEnd : String) : Boolean;
begin
  result := false;
  if BarcodeRangeId <> 0 then
  begin
    with dmBarcodeRanges.adoqRun do
    begin
      Close;
      SQL.Text := Format('SELECT Value FROM ThemeBarcodeException ' +
                        ' WHERE BarcodeRangeID = %d ', [BarcodeRangeID]);
      Open;
      first;
      while not eof do
      begin
        if (StringGreaterThan(vStart, FieldByName('Value').AsString)) or (StringGreaterThan(FieldByName('Value').AsString, vEnd)) then
        begin
          Result := True;
          Exit;
        end;
        Next;
      end;
    end;
  end;
end;

// 344322 TODO:  Add all other types of barcodes to this check (see ThemeModelling Discount Barcodes for help)
function TfrmEditBarcodeRange.ExternalBarcodesInRange(vStart, vEnd : String): Boolean;
begin
  with dmBarcodeRanges.adoqRun do
  try
    Close;
    SQL.Text := Format(
      'select count(*) as MatchCount from ProductBarcode '+
      'where dbo.fnBarcodeInRange(Barcode, null, %s, %s) = 1', [vStart, vEnd]);
    try
      Open;
      Result := FieldByName('MatchCount').AsInteger > 0;
    except
      on E: Exception do
      begin
        log.Event('Error checking for barcode uniqueness: ' + E.Message);
        MessageDlg('Error checking for barcode uniqueness: ' + E.Message, mtError, [mbOK], 0);
        Result := FALSE;
      end;
    end;
  finally
    close;
  end;
end;

//TASK 358106 A user cannot keep the same Barcode Range description when editing the barcode range in Product Modelling
function TfrmEditBarcodeRange.DescriptionAlreadyExists(Description: string): Boolean;
var
  barCodeID: int64;
begin
  with dmBarcodeRanges.adoqRun do
  begin
    Close;
    SQL.Text := Format('SELECT COUNT(*) AS DescriptionInUse FROM ThemeBarcodeRange WHERE Description LIKE %s AND BarcodeRangeID <> %d', [QuotedStr(Description), BarcodeRangeID]);
    try
      Open;
      Result := (FieldByName('DescriptionInUse').AsInteger > 0);
    except on E: Exception do
      begin
        log.Event('Error checking for existing barcode names: ' + E.Message);
        MessageDlg('Error checking for existing barcode names: ' + E.Message, mtError, [mbOK], 0);
        Result := TRUE;
      end;
    end;
  end;
end;


procedure TfrmEditBarcodeRange.edtRangeStartKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not((Ord(Key) >= Ord('0')) and (Ord(Key) <= Ord('9'))) and (Key <> #8)
     and (Key <> #3) and (Key <> #22) and (Key <> #24) then
    Abort;
  if (Key = '0') and ((Length(TEdit(Sender).Text) = 0) or (TEdit(Sender).SelStart = 0)) then
    Abort;
  tTempRange := TEdit(Sender).Text;
end;

procedure TfrmEditBarcodeRange.edtRangeStartChange(Sender: TObject);
begin
   if Length(TEdit(Sender).Text) > 0 then
      begin
       if (TEdit(Sender).Text[1] = '0') then
          begin
            TEdit(Sender).Text := tTempRange;
            Raise Exception.Create('Range cannot begin with zero(0).');
          end
       else
       if not IsNumeric(TEdit(Sender).Text) then
          begin
            TEdit(Sender).Text := tTempRange;
            Raise Exception.Create('Range must be numeric.');
          end;
    end;
end;

procedure TfrmEditBarcodeRange.edtRangeStartEnter(Sender: TObject);
begin
  tTempRange := TEdit(Sender).Text;
end;


end.
