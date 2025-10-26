unit uEditClmQrCodeText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  ActnList, Clipbrd, Menus;

type
  TEditClmQrCodeTextFrm = class(TForm)
    pnlDataGrid: TPanel;
    pnlButtons: TPanel;
    pnlFooterTextTop: TPanel;
    lblFooterText: TLabel;
    lblTextDescription: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    ActionList1: TActionList;
    PreviewQrCodeTextBtn: TButton;
    btnClearAll: TButton;
    actClearQrCodeAll: TAction;
    QrCodeHeaderTextPanel: TPanel;
    HeaderAlignmentLookUp: TwwDBLookupCombo;
    QrCodeHeaderTextDbGrid: TwwDBGrid;
    QrCodeFooterTextPanel: TPanel;
    QrCodeFooterTextDbGrid: TwwDBGrid;
    FooterAlignmentLookUp: TwwDBLookupCombo;
    Label1: TLabel;
    QrCodeHeaderButtonPanel: TPanel;
    QrCodeClearHeaderTextBtn: TButton;
    Label2: TLabel;
    QrCodeFooterButtonPanel: TPanel;
    QrCodeClearFooterTextBtn: TButton;
    actResetQrCodeHeader: TAction;
    actResetQrCodeFooter: TAction;
    bInsertFooterExpDate: TButton;
    eFooterExpDate: TEdit;
    eHeaderExpDate: TEdit;
    bInsertHeaderExpDate: TButton;
    actClearBarcodeAll: TAction;
    actResetBarcodeHeader: TAction;
    actResetBarcodeFooter: TAction;
    procedure PreviewQrCodeTextBtnClick(Sender: TObject);
    procedure QrCodeHeaderTextDbGridKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actClearQrCodeAllExecute(Sender: TObject);
    procedure actResetQrCodeHeaderExecute(Sender: TObject);
    procedure actResetQrCodeFooterExecute(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure bInsertFooterExpDateClick(Sender: TObject);
    procedure bInsertHeaderExpDateClick(Sender: TObject);
    procedure actClearBarcodeAllExecute(Sender: TObject);
    procedure actResetBarcodeHeaderExecute(Sender: TObject);
    procedure actResetBarcodeFooterExecute(Sender: TObject);
    procedure QrCodeClearHeaderTextBtnClick(Sender: TObject);
    procedure QrCodeClearFooterTextBtnClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
  private
    { Private declarations }
    isQrCodeMode: boolean; // true=QRCode false=Barcode
  public
    { Public declarations }
    class function ShowQrCodeTextFrm(isQrCode: boolean): boolean;
  end;

implementation

uses
  uADO, uAztecLog, uFooterPreview, DB;

{$R *.dfm}

class function TEditClmQrCodeTextFrm.ShowQrCodeTextFrm(isQrCode: boolean): boolean;
var
  EditClmQrCodeTextFrm: TEditClmQrCodeTextFrm;
begin
  //Log('Editing QR Code Text');
  EditClmQrCodeTextFrm := TEditClmQrCodeTextFrm.Create(Nil);
  with EditClmQrCodeTextFrm do
  begin
    isQrCodeMode := isQrCode;
    if (isQrCodeMode) then
      Log('Editing QR Code Text')
    else begin
      Log('Editing Barcode Text');
      Caption := 'Edit Barcode Text';
      lblFooterText.Caption := 'Barcode Text';
      lblTextDescription.Caption := 'Enter the text that will be printed above and below the Barcode';
      QrCodeHeaderTextDbGrid.DataSource := dmADO.dsBarcodeHeaderText;
      QrCodeFooterTextDbGrid.DataSource := dmADO.dsBarcodeFooterText;
    end;

    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TEditClmQrCodeTextFrm.PreviewQrCodeTextBtnClick(Sender: TObject);
var
  QrCodeTextPreview: TFooterPreview;
  pbTop: Integer;
  LineCount: Integer;
  PreviewFormCaption: String;
begin
  if (isQrCodeMode) then begin
    PreviewFormCaption:='QR Code Text Preview';
    if dmADO.TmpQrCodeHeaderText.State in [dsEdit] then
      dmADO.TmpQrCodeHeaderText.Post;
    if dmADO.TmpQrCodeFooterText.State in [dsEdit] then
      dmADO.TmpQrCodeFooterText.Post;
  end
  else
  begin
    PreviewFormCaption:='Barcode Text Preview';
    if dmADO.TmpBarcodeHeaderText.State in [dsEdit] then
      dmADO.TmpBarcodeHeaderText.Post;
    if dmADO.TmpBarcodeFooterText.State in [dsEdit] then
      dmADO.TmpBarcodeFooterText.Post;
  end;

  with dmADO.adoqRun do
  try
    // vkalchev - changed to 25x25 lines for header and footer
    (*
    SQL.Clear;
    SQL.Add('select LineNumber, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #QrCodeHeaderText');
    SQL.Add('UNION ALL');
    SQL.Add('Select 6, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
    SQL.Add('UNION ALL');
    SQL.Add('Select 7, ''[QR CODE]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
    SQL.Add('UNION ALL');
    SQL.Add('Select 8, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
    SQL.Add('UNION ALL');
    SQL.Add('select LineNumber + 8, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #QrCodeFooterText');
    Open;
    LineCount := RecordCount;
    *)
    SQL.Clear;

    if (isQrCodeMode) then begin
      SQL.Add('select LineNumber, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #QrCodeHeaderText');
      SQL.Add('UNION ALL');
      SQL.Add('Select 26, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('Select 27, ''[QR CODE]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('Select 28, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('select LineNumber + 28, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #QrCodeFooterText');
    end
    else
    begin
      SQL.Add('select LineNumber, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #BarcodeHeaderText');
      SQL.Add('UNION ALL');
      SQL.Add('Select 26, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('Select 27, ''[BARCODE]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('Select 28, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
      SQL.Add('UNION ALL');
      SQL.Add('select LineNumber + 28, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #BarcodeFooterText');
    end;

    Open;
    LineCount := RecordCount;

    QrCodeTextPreview := TFooterPreview.Create(nil, LineCount);
    QrCodeTextPreview.Caption := PreviewFormCaption;
    try
      First;
      pbTop := 50;
      while not Eof do
      begin
        QrCodeTextPreview.ConfigurePaintBox(FieldByName('LineNumber').AsInteger, pbTop, FieldByName('Text').AsString,
                  FieldByName('Alignment').AsInteger, FieldByName('Bold').AsBoolean, FieldByName('DoubleWidth').AsBoolean,
                  FieldByName('DoubleHeight').AsBoolean);
          pbTop := pbTop + 17;
        Next;
      end;
      QrCodeTextPreview.CreateTopAndBottomPaintBoxes;
      QrCodeTextPreview.ShowModal;
    finally
      QrCodeTextPreview.Free;
    end;
  finally
    Close;
    SQL.Clear;
  end;
end;

procedure TEditClmQrCodeTextFrm.QrCodeHeaderTextDbGridKeyPress(
  Sender: TObject; var Key: Char);
  function isValidNonAlphaChar: Boolean;
  begin
    //Key press is valid, but not alphanumeric
    result :=    (HiWord(GetKeyState(VK_ESCAPE)) <> 0)
              or (HiWord(GetKeyState(VK_BACK)) <> 0)
              or (HiWord(getKeyState(VK_INSERT)) <> 0)
              or (Key in [^C]);
  end;

var
  CharInsertionCount: Integer;
  Clpbrd: TClipboard;
  ErrorMessage: String;
  ErrorFieldName: String;
begin
  if isValidNonAlphaChar then
    Exit;

  with (Sender as TwwDBGrid) do
  begin
    ErrorFieldName := 'Double Width';

    if (GetActiveField.FieldName = 'Text') then
    begin
      if (DataSource.DataSet.FieldByName('DoubleWidth').AsBoolean) then
      begin
        if (InplaceEditor <> nil) then
        begin
          if (key in [^V]) then
          begin
            Clpbrd := Clipboard;
            CharInsertionCount := Length(Clpbrd.Astext);
          end
          else
            CharInsertionCount := 1;

          if ((Length(InplaceEditor.Text) + CharInsertionCount) > 20) then
          begin
            ErrorMessage := 'Only 20 characters can be entered when ' + QuotedStr(ErrorFieldName) + ' is checked.';
            if (CharInsertionCount > 1) then
              ErrorMessage := ErrorMessage + '  Input would be truncated.';
            ShowMessage(ErrorMessage);
            abort;
          end;
        end;
      end;
    end;
  end;
end;

procedure TEditClmQrCodeTextFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dmADO.qOutletBillFooter.State in [dsEdit, dsInsert] then
    dmADO.qOutletBillFooter.Post;
end;

procedure TEditClmQrCodeTextFrm.actClearQrCodeAllExecute(Sender: TObject);
begin
  actResetQrCodeHeaderExecute(Sender);
  actResetQrCodeFooterExecute(Sender);
end;

procedure TEditClmQrCodeTextFrm.actResetQrCodeHeaderExecute(
  Sender: TObject);
begin
  if dmADO.TmpQrCodeHeaderText.State in [dsEdit] then
        dmADO.TmpQrCodeHeaderText.Post;

  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #QrCodeHeaderText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    SQL.Add('WHERE Position = 1');
    ExecSQL;
  end;
  dmADO.TmpQrCodeHeaderText.Requery();
end;

procedure TEditClmQrCodeTextFrm.actResetQrCodeFooterExecute(
  Sender: TObject);
begin
  if dmADO.TmpQrCodeFooterText.State in [dsEdit] then
        dmADO.TmpQrCodeFooterText.Post;
        
  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #QrCodeFooterText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    SQL.Add('WHERE Position = 2');
    ExecSQL;
  end;
  dmADO.TmpQrCodeFooterText.Requery();
end;

procedure TEditClmQrCodeTextFrm.btnOKClick(Sender: TObject);
begin
    ModalResult := mrOk;
    try

      if (isQrCodeMode) then begin
        if dmADO.TmpQrCodeHeaderText.State in [dsEdit] then
                dmADO.TmpQrCodeHeaderText.Post;

        if dmADO.TmpQrCodeFooterText.State in [dsEdit] then
                dmADO.TmpQrCodeFooterText.Post;
      end
      else
      begin
        if dmADO.TmpBarcodeHeaderText.State in [dsEdit] then
                dmADO.TmpBarcodeHeaderText.Post;

        if dmADO.TmpBarcodeFooterText.State in [dsEdit] then
                dmADO.TmpBarcodeFooterText.Post;
      end;

    except
        on e: EParserError do
        begin
                MessageDlg(e.Message, mtError, [mbOK], 0);
                ModalResult := mrNone;
        end;
    end;
end;

procedure TEditClmQrCodeTextFrm.bInsertFooterExpDateClick(Sender: TObject);
var
  currText: String;
  numOfDays: Integer;
begin
  numOfDays := StrToIntDef(eFooterExpDate.Text, -1);
  if ((numOfDays <= 0) or (numOfDays >= 1000)) then begin
    ShowMessage('Invalid number of days! Should be positive number between 1 and 999.');
    eFooterExpDate.SetFocus;
    exit;
  end;

  if (isQrCodeMode) then begin
    currText := dmADO.TmpQrCodeFooterTextText.AsString;
    dmADO.TmpQrCodeFooterText.Edit();
    dmADO.TmpQrCodeFooterTextText.AsString := currText + '{date:' + IntToStr(numOfDays) + '}';
  end
  else
  begin
    currText := dmADO.TmpBarcodeFooterTextText.AsString;
    dmADO.TmpBarcodeFooterText.Edit();
    dmADO.TmpBarcodeFooterTextText.AsString := currText + '{date:' + IntToStr(numOfDays) + '}';
  end;
end;

procedure TEditClmQrCodeTextFrm.bInsertHeaderExpDateClick(Sender: TObject);
var
  currText: String;
  numOfDays: Integer;
begin
  numOfDays := StrToIntDef(eHeaderExpDate.Text, -1);
  if ((numOfDays <= 0) or (numOfDays >= 1000)) then begin
    ShowMessage('Invalid number of days! Should be positive number between 1 and 999.');
    eHeaderExpDate.SetFocus;
    exit;
  end;

  if (isQrCodeMode) then begin
    currText := dmADO.TmpQrCodeHeaderTextText.AsString;
    dmADO.TmpQrCodeHeaderText.Edit();
    dmADO.TmpQrCodeHeaderTextText.AsString := currText + '{date:' + IntToStr(numOfDays) + '}';
  end
  else
  begin
    currText := dmADO.TmpBarcodeHeaderTextText.AsString;
    dmADO.TmpBarcodeHeaderText.Edit();
    dmADO.TmpBarcodeHeaderTextText.AsString := currText + '{date:' + IntToStr(numOfDays) + '}';
  end;

end;

procedure TEditClmQrCodeTextFrm.actClearBarcodeAllExecute(Sender: TObject);
begin
  actResetBarcodeHeaderExecute(Sender);
  actResetBarcodeFooterExecute(Sender);
end;

procedure TEditClmQrCodeTextFrm.actResetBarcodeHeaderExecute(
  Sender: TObject);
begin
  if dmADO.TmpBarcodeHeaderText.State in [dsEdit] then
    dmADO.TmpBarcodeHeaderText.Post;

  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #BarcodeHeaderText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    SQL.Add('WHERE Position = 1');
    ExecSQL;
  end;
  dmADO.TmpBarcodeHeaderText.Requery();
end;

procedure TEditClmQrCodeTextFrm.actResetBarcodeFooterExecute(
  Sender: TObject);
begin
  if dmADO.TmpBarcodeFooterText.State in [dsEdit] then
    dmADO.TmpBarcodeFooterText.Post;
        
  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #BarcodeFooterText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    SQL.Add('WHERE Position = 2');
    ExecSQL;
  end;
  dmADO.TmpBarcodeFooterText.Requery();
end;

procedure TEditClmQrCodeTextFrm.QrCodeClearHeaderTextBtnClick(
  Sender: TObject);
begin
  if (isQrCodeMode) then
    actResetQrCodeHeaderExecute(Sender)
  else
    actResetBarcodeHeaderExecute(Sender);
end;

procedure TEditClmQrCodeTextFrm.QrCodeClearFooterTextBtnClick(
  Sender: TObject);
begin
  if (isQrCodeMode) then
    actResetQrCodeFooterExecute(Sender)
  else
    actResetBarcodeFooterExecute(Sender);
end;

procedure TEditClmQrCodeTextFrm.btnClearAllClick(Sender: TObject);
begin
  if (isQrCodeMode) then
    actClearQrCodeAllExecute(Sender)
  else
    actClearBarcodeAllExecute(Sender);
end;

end.
