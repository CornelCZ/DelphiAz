unit uEditOutletBillFooter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  ActnList, Clipbrd, Menus;

type
  TEditOutletBillFooter = class(TForm)
    pnlDataGrid: TPanel;
    dbgrdOutletBillFooter: TwwDBGrid;
    luAlignment: TwwDBLookupCombo;
    pnlButtons: TPanel;
    pnlFooterTextTop: TPanel;
    lblFooterText: TLabel;
    lblTextDescription: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    ActionList1: TActionList;
    actPasteFooter: TAction;
    btnPasteFooter: TButton;
    btnPreviewBill: TButton;
    pmCopyPasteMenu: TPopupMenu;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    actPaste: TAction;
    actCopy: TAction;
    actCut: TAction;
    btnClearAll: TButton;
    actClearAll: TAction;
    procedure btnPreviewBillClick(Sender: TObject);
    procedure dbgrdOutletBillFooterKeyPress(Sender: TObject;
      var Key: Char);
    procedure actPasteFooterExecute(Sender: TObject);
    procedure actPasteUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPasteExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure CutCopyActionUpdate(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
  private
    { Private declarations }
    function isFooterBlank : boolean;
  public
    { Public declarations }
    class function ShowOutletBillFooter(SiteCode: Integer): boolean;
  end;

implementation

uses
  uADO, uAztecLog, uFooterPreview, DB;

{$R *.dfm}

class function TEditOutletBillFooter.ShowOutletBillFooter(SiteCode: Integer): boolean;
var
  EditOutletBillFooter: TEditOutletBillFooter;
begin
  Log('Editing Outlet Bill Footer for Site Code ' + IntToStr(SiteCode));
  EditOutletBillFooter := TEditOutletBillFooter.Create(Nil);
  with EditOutletBillFooter do
  begin
    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TEditOutletBillFooter.btnPreviewBillClick(Sender: TObject);
var
  FooterPreview: TFooterPreview;
  pbTop: Integer;
  LineCount: Integer;
begin
  if dmADO.qOutletBillFooter.State in [dsEdit, dsInsert] then
    dmADO.qOutletBillFooter.Post;

  with dmADO.adoqRun do
  try
    SQL.Clear;
    SQL.Add('select * from #OutletBillFooterText order by LineNumber');
    Open;
    LineCount := RecordCount;

    dmADO.qOutletBillFooter.Requery;
    FooterPreview := TFooterPreview.Create(nil, LineCount);
    try
      First;
      pbTop := 50;
      while not Eof do
      begin
        FooterPreview.ConfigurePaintBox(FieldByName('LineNumber').AsInteger, pbTop, FieldByName('Text').AsString,
                  FieldByName('Alignment').AsInteger, FieldByName('Bold').AsBoolean, FieldByName('DoubleWidth').AsBoolean,
                  FieldByName('DoubleHeight').AsBoolean);
          pbTop := pbTop + 17;
        Next;
      end;
      FooterPreview.CreateTopAndBottomPaintBoxes;
      FooterPreview.ShowModal;
    finally
      FooterPreview.Free;
    end;
  finally
    Close;
    SQL.Clear;
  end;
end;

procedure TEditOutletBillFooter.dbgrdOutletBillFooterKeyPress(
  Sender: TObject; var Key: Char);

  function isValidNonAlphaChar: Boolean;
  begin
    //Key press is valid, but not alphanumeric
    result :=    (HiWord(GetKeyState(VK_ESCAPE)) <> 0)
              or (HiWord(GetKeyState(VK_BACK)) <> 0)
              or (HiWord(getKeyState(VK_INSERT)) <> 0)
              or (Key in [^C]);
  end;
begin
  if isValidNonAlphaChar then
    Exit;

  if (Key in [^V]) then
  begin
    actPasteExecute(Sender);
    Key := #0;
  end;

end;

procedure TEditOutletBillFooter.actPasteFooterExecute(Sender: TObject);
var
  clipText, outputText: TStrings;
  inputLine, outputLine, startCharacter : smallint;
  i: smallint;
begin
  clipText := TStringList.Create;
  outputText := TStringList.Create;

  try
    if Clipboard.HasFormat(CF_TEXT) then
    begin
      if (not isFooterBlank) and
        (MessageDlg('This action will remove the existing footer text - continue?', mtWarning, mbOKCancel, 0) <> mrOK ) then
        Abort;

      clipText.Text := Clipboard.AsText;

      inputLine := 0;
      outputLine := 0;

      while (inputLine < 14) and (inputLine < clipText.Count) and (outputLine < 14) do
      begin
        startCharacter := 1;
        repeat
          outputText.Add(copy(clipText.Strings[inputLine], startCharacter, 40));
          outputLine := outputLine + 1;
          startCharacter := startCharacter + 40;
        until (startCharacter > Length(clipText.Strings[inputLine])) or (outputLine >= 14);
        inputLine := inputLine + 1;
      end;

      for i := outputLine to 14 do
      begin
        outputText.Add('');
      end;

      with dmADO.qOutletBillFooter do
      try
        DisableControls;
        First;
        while not Eof do
        begin
          Edit;
          FieldByName('Text').Text := outputText.Strings[FieldByName('LineNumber').AsInteger-1];
          FieldByName('Bold').AsBoolean := FALSE;
          FieldByName('DoubleWidth').AsBoolean := FALSE;
          FieldByName('DoubleHeight').AsBoolean := FALSE;
          FieldByName('Alignment').AsInteger := 1;
          Post;
          Next;
        end;
      finally
        EnableControls;
      end;
    end
    else
      MessageDlg('There is no text on the Clipboard', mtInformation,
            [mbOK],0);
  finally
    clipText.Free;
    outputText.Free;
  end;
end;

procedure TEditOutletBillFooter.actPasteUpdate(Sender: TObject);
begin
  actPasteFooter.Enabled := (Clipboard.HasFormat(CF_TEXT));
end;

procedure TEditOutletBillFooter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dmADO.qOutletBillFooter.State in [dsEdit, dsInsert] then
    dmADO.qOutletBillFooter.Post;
end;

function TEditOutletBillFooter.isFooterBlank: boolean;
begin
  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM #OutletBillFooterText');
    SQL.Add('WHERE Text <> ''''');
    Open;
    result := RecordCount = 0;
  end;
end;

procedure TEditOutletBillFooter.actPasteExecute(Sender: TObject);
var
  ClipText : TStringList;
begin
  ClipText := TStringList.Create;
  try
    if Clipboard.HasFormat(CF_TEXT) then
    begin
      if isFooterBlank then
        actPasteFooterExecute(Sender)
      else
      begin
        ClipText.Text := ClipBoard.AsText;
        // we only want to paste first line if there is more than 1 line on clipboard
        Clipboard.AsText := ClipText[0];
        If assigned(dbgrdOutletBillFooter.InplaceEditor) then
          dbgrdOutletBillFooter.InplaceEditor.PasteFromClipboard;
        // set the clipboard text back
        Clipboard.AsText := ClipText.Text;
      end;
    end;
  finally
    ClipText.Free;
  end;
end;

procedure TEditOutletBillFooter.actCopyExecute(Sender: TObject);
begin
  If assigned(dbgrdOutletBillFooter.InplaceEditor) then
    dbgrdOutletBillFooter.InplaceEditor.CopyToClipboard;
end;

procedure TEditOutletBillFooter.actCutExecute(Sender: TObject);
begin
  If assigned(dbgrdOutletBillFooter.InplaceEditor) then
    dbgrdOutletBillFooter.InplaceEditor.CutToClipboard;
end;

procedure TEditOutletBillFooter.CutCopyActionUpdate(Sender: TObject);
begin
  If assigned(dbgrdOutletBillFooter.InplaceEditor) then
    TAction(Sender).Enabled := dbgrdOutletBillFooter.InplaceEditor.SelLength > 0 ;
end;

procedure TEditOutletBillFooter.actClearAllExecute(Sender: TObject);
begin
  with dmADO.qRun do
  begin;
    SQL.Clear;
    SQL.Add('UPDATE #OutletBillFooterText');
    SQL.Add('SET Alignment = 1, Text = '''', Bold = 0, DoubleWidth = 0, DoubleHeight = 0');
    ExecSQL;
  end;
  dmADO.qOutletBillFooter.Requery();
end;

end.
