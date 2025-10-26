unit uEditQrCodeOnReceiptText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid,
  ExtCtrls, Clipbrd;

type
  TEditQrCodeOnReceiptText = class(TForm)
    pnlDataGrid: TPanel;
    pnlButtons: TPanel;
    pnlFooterTextTop: TPanel;
    lblFooterText: TLabel;
    lblTextDescription: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    ActionList1: TActionList;
    PreviewQrCodeTextBtn: TButton;
    actClearAll: TAction;
    QrCodeFooterTextPanel: TPanel;
    QrCodeFooterTextDbGrid: TwwDBGrid;
    FooterAlignmentLookUp: TwwDBLookupCombo;
    Label2: TLabel;
    QrCodeFooterButtonPanel: TPanel;
    QrCodeClearFooterTextBtn: TButton;
    actResetQrCodeHeader: TAction;
    actResetQrCodeFooter: TAction;
    procedure PreviewQrCodeTextBtnClick(Sender: TObject);
    procedure QrCodeHeaderTextDbGridKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actResetQrCodeFooterExecute(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FSiteCode: Integer;
  public
    { Public declarations }
    class function ShowQrCodeOnReceiptTextFrm(SiteCode: Integer): boolean;
  end;

implementation

{$R *.dfm}
uses
  uADO, uAztecLog, uFooterPreview, DB;


class function TEditQrCodeOnReceiptText.ShowQrCodeOnReceiptTextFrm(SiteCode: Integer): boolean;
var
  EditQrCodeOnReceiptText: TEditQrCodeOnReceiptText;
begin
  Log('Editing QR Code On Receipt Text');
  EditQrCodeOnReceiptText := TEditQrCodeOnReceiptText.Create(Nil);
  with EditQrCodeOnReceiptText do
  begin
    FSiteCode := SiteCode;
    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TEditQrCodeOnReceiptText.PreviewQrCodeTextBtnClick(Sender: TObject);
var
  QrCodeTextPreview: TFooterPreview;
  pbTop: Integer;
  LineCount: Integer;
begin
  if dmADO.TmpQrCodeOnReceiptFooterText.State in [dsEdit] then
    dmADO.TmpQrCodeOnReceiptFooterText.Post;

  with dmADO.adoqRun do
  try
    SQL.Clear;
    SQL.Add('Select 1 AS LineNumber, ''[       ]'' AS Text, 1 AS Alignment, CAST(0 AS bit) AS Bold, CAST(0 AS bit) AS DoubleWidth, CAST(0 AS bit) AS DoubleHeight');
    SQL.Add('UNION ALL');
    SQL.Add('Select 2, ''[QR CODE]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
    SQL.Add('UNION ALL');
    SQL.Add('Select 3, ''[       ]'', 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit)');
    SQL.Add('UNION ALL');
    SQL.Add('select LineNumber + 3, Text, Alignment, Bold, DoubleWidth, DoubleHeight from #QrCodeOnReceiptFooterText');
    Open;
    LineCount := RecordCount;

    QrCodeTextPreview := TFooterPreview.Create(nil, LineCount);
    QrCodeTextPreview.Caption := 'QR Code Text Preview';
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

procedure TEditQrCodeOnReceiptText.QrCodeHeaderTextDbGridKeyPress(
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

procedure TEditQrCodeOnReceiptText.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dmADO.qOutletBillFooter.State in [dsEdit, dsInsert] then
    dmADO.qOutletBillFooter.Post;
end;

procedure TEditQrCodeOnReceiptText.actResetQrCodeFooterExecute(
  Sender: TObject);
begin
  if dmADO.TmpQrCodeOnReceiptFooterText.State in [dsEdit] then
        dmADO.TmpQrCodeOnReceiptFooterText.Post;
        
  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #QrCodeOnReceiptFooterText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    SQL.Add('WHERE Position = 2');
    ExecSQL;
  end;
  dmADO.TmpQrCodeOnReceiptFooterText.Requery();
end;

procedure TEditQrCodeOnReceiptText.btnOKClick(Sender: TObject);
begin
    ModalResult := mrOk;
    try
        if dmADO.TmpQrCodeOnReceiptFooterText.State in [dsEdit] then
            dmADO.TmpQrCodeOnReceiptFooterText.Post;
    except
        on e: EParserError do
        begin
                MessageDlg(e.Message, mtError, [mbOK], 0);
                ModalResult := mrNone;
        end;
    end;
end;

end.
