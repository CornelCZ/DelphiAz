unit uEPOSTextHelper;

interface

uses stdctrls, menus;

type
  TEPOSTextHelper = class(TObject)
    constructor Create(NameEdit: TEdit; EPOSTextMemo: TMemo);
  private
    MemoContextMenu: TPopupMenu;
    LinkedEdit: TEdit;
    LinkedMemo: TMemo;
    AutoGenerateButtonText: boolean;
    procedure CheckForButtonTextOverride;
    procedure HandleEditChange(Sender: TObject);
    procedure HandleMemoChange(Sender: TObject);
    procedure HandleMemoKeyPress(Sender: TObject; var Key: Char);
    procedure HandleMenuClick(Sender: TObject);
  end;

implementation

uses uSimpleEPOSLineWrap, sysutils;

{ TEPOSTextHelper }

constructor TEPOSTextHelper.Create(NameEdit: TEdit; EPOSTextMemo: TMemo);
var
  TmpItem: TMenuItem;
begin
  LinkedEdit := NameEdit;
  LinkedMemo := EPOSTextMemo;
  LinkedEdit.OnChange := HandleEditChange;
  LinkedMemo.OnChange := HandleMemoChange;
  LinkedMemo.OnKeyPress := HandleMemoKeyPress;
  AutoGenerateButtonText := true;
  MemoContextMenu := TPopupMenu.Create(LinkedMemo);
  TmpItem := TMenuItem.Create(LinkedMemo);
  TmpItem.Caption := 'Revert';
  TmpItem.OnClick := HandleMenuClick;
  TmpItem.Enabled := True;
  MemoContextMenu.Items.Add(TmpItem);
  LinkedMemo.PopupMenu := MemoContextMenu;
end;


procedure TEPOSTextHelper.HandleEditChange(Sender: TObject);
begin
  if AutoGenerateButtonText then
  begin
     LinkedMemo.lines.text := uSimpleEPOSLineWrap.GetWrappedText(LinkedEdit.Text);
  end
  else
    CheckForButtonTextOverride;
end;

procedure TEPOSTextHelper.HandleMemoChange(Sender: TObject);
begin
  if TMemo(Sender).Lines.Count > 3 then TMemo(sender).lines.Delete(3);
  CheckForButtonTextOverride;
end;

procedure TEPOSTextHelper.HandleMemoKeyPress(Sender: TObject;
  var Key: Char);
var
  i, linecount: integer;
  tmpstr: string;
begin
  linecount := 0;
  tmpstr := TMemo(sender).lines.text;
  for i := 1 to length(tmpstr) do
    if (tmpstr[i] = #13) then inc(linecount);
  if (key = #13) and (linecount >= 2) then abort;
end;

procedure TEPOSTextHelper.CheckForButtonTextOverride;
var
  SaveButtontext, GeneratedButtonText: string;
begin
  SaveButtonText := StringReplace(LinkedMemo.text, #13#10, #13, [rfReplaceAll]);
  GeneratedButtonText := uSimpleEPOSLineWrap.GetWrappedText(LinkedEdit.Text);

  while (Length(SaveButtonText) > 0) and (SaveButtonText[Length(SaveButtonText)] = #13) do
    SetLength(SaveButtonText, Length(SaveButtonText)-1);
  while (Length(GeneratedButtonText) > 0) and (GeneratedButtonText[Length(GeneratedButtonText)] = #13) do
    SetLength(GeneratedButtonText, Length(GeneratedButtonText)-1);

  AutoGenerateButtonText := not ((GeneratedButtonText <> SaveButtonText)
    and (Length(Trim(LinkedMemo.text)) <> 0));

  MemoContextMenu.Items[0].Enabled := not AutoGenerateButtonText;
end;

procedure TEPOSTextHelper.HandleMenuClick(Sender: TObject);
begin
  AutoGenerateButtonText := True;
  HandleEditChange(LinkedEdit);
end;

end.
