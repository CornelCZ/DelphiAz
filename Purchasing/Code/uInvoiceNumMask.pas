unit uInvoiceNumMask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, Buttons, DB, ADODB, DBCtrls,
  ActnList, wwdblook, uADO, ComCtrls;

type

  TMaskChar = class(TObject)
  private
  public
    charType : SmallInt;
    charCase : SmallInt;
    literalChar : string;
    constructor Create;
    procedure reset;
  end;

  TfrmInvoiceNumMask = class(TForm)
    CharActionList: TActionList;
    DeleteCharAction: TAction;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    Action15: TAction;
    SaveAction: TAction;
    pnlSelectSupplier: TPanel;
    qrySuppliers: TADOQuery;
    SupplierLookUp: TwwDBLookupCombo;
    MaskLookUp: TwwDBLookupCombo;
    qrySuppliersSupplierName: TStringField;
    btnNewMask: TBitBtn;
    NewMaskAction: TAction;
    TmpMaskTbl: TADOTable;
    Label2: TLabel;
    Label3: TLabel;
    CloseAttrPanelAction: TAction;
    MainActionList: TActionList;
    pnlMain: TPanel;
    pnlTestMask: TPanel;
    Panel2: TPanel;
    cbxCurrentMask: TCheckBox;
    btnSave: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    MaskExample: TMaskEdit;
    Panel4: TPanel;
    btnOK: TBitBtn;
    pnlEditMask: TPanel;
    Label4: TLabel;
    pnlAttributes: TPanel;
    Image2: TImage;
    btnDeleteChar: TBitBtn;
    rgpCharType: TRadioGroup;
    rgpCase: TRadioGroup;
    gpLiteralChar: TGroupBox;
    editLiteralChar: TEdit;
    btnCloseAttr: TBitBtn;
    Char2Btn: TBitBtn;
    Char3Btn: TBitBtn;
    Char4Btn: TBitBtn;
    Char5Btn: TBitBtn;
    Char6Btn: TBitBtn;
    Char7Btn: TBitBtn;
    Char8Btn: TBitBtn;
    Char9Btn: TBitBtn;
    Char10Btn: TBitBtn;
    Char11Btn: TBitBtn;
    Char12Btn: TBitBtn;
    Char13Btn: TBitBtn;
    Char14Btn: TBitBtn;
    Char15Btn: TBitBtn;
    Char1Btn: TBitBtn;
    edit2: TEdit;
    edit3: TEdit;
    edit4: TEdit;
    edit5: TEdit;
    edit6: TEdit;
    edit7: TEdit;
    edit8: TEdit;
    edit9: TEdit;
    edit10: TEdit;
    edit11: TEdit;
    edit12: TEdit;
    edit13: TEdit;
    edit14: TEdit;
    edit15: TEdit;
    edit1: TEdit;
    StatusBar1: TStatusBar;
    procedure CharBtnActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgpCharTypeClick(Sender: TObject);
    procedure rgpCaseClick(Sender: TObject);
    procedure editLiteralCharChange(Sender: TObject);
    procedure DeleteCharActionExecute(Sender: TObject);
    procedure DeleteCharActionUpdate(Sender: TObject);
    procedure CharBtnActionUpdate(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure SaveActionUpdate(Sender: TObject);
    procedure SupplierLookUpChange(Sender: TObject);
    procedure MaskLookUpChange(Sender: TObject);
    procedure SupplierLookUpBeforeDropDown(Sender: TObject);
    procedure NewMaskActionExecute(Sender: TObject);
    procedure cbxCurrentMaskClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CloseAttrPanelActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    SelectedChar: TMaskChar;
    SelectedEdit: TEdit;
    AskSave: Boolean;
    Task : Smallint;
    theMaskID : Smallint;
    currentMask: Smallint;
    maskCharList, maskEditList: TStringList;
    function CurrentCharIsFilled: Boolean;
    function NextCharIsEmpty: Boolean;
    procedure BuildEditMask;
    procedure getCharStr(aCurrentChar, aPreviousChar: TMaskChar; var aCharStrings: TStringList; aPreviousCharNum: smallInt);
    // fill the maskChars from the editmask in supplierTable
    procedure FillMaskChars;
    procedure resetMaskChars;
    procedure setFirstChar(aMaskStr: string; var aStrPos: smallInt);
    procedure setChar(aCurrentChar, aPreviousChar: TMaskChar; aMaskEdit: TEdit; aMaskStr: string; var aStrPos: Smallint);
    function getNextMaskID(suppName: string): Smallint;
    procedure ConvertSupplierMasks;
    function getChar(aMaskStr: string; var aStrPos: smallInt; var aCharType: smallInt; var aCaseType: smallInt): string;
    procedure GetSupplierMasks(supplierName: String);
    function GetConvertedMask(aDatabaseMaskStr: String): String;
    procedure SaveTheMask;
    procedure FillMaskLists;
  public
    { Public declarations }
  end;


const
  TASK_INSERT = 1;
  TASK_VIEW = 2;
  TASK_NONE = 3;

  ALPHA_CHAR = 0;
  NUMERIC_CHAR = 1;
  ALPHA_NUMERIC_CHAR = 2;
  ANY_TYPE_CHAR = 3;
  LITERAL_CHAR = 4;
  NO_TYPE = 5;

  UPPER_CASE = 0;
  LOWER_CASE = 1;
  NEITHER = 2;
  NO_CASE = 5;

  CANT_EDIT_STATUS_STR = 'This mask cannot be edited as it may have been used in existing delivery notes';

  MAX_NUMBER_OF_CHARS = 15;

implementation

uses uCurrentMask, uGlobals;

{$R *.dfm}

{ TMaskChar }

constructor TMaskChar.Create;
begin
  inherited;
  charType := -1;
  charCase := -1;
end;

procedure TMaskChar.reset;
begin
  charType := -1;
  charCase := -1;
  literalChar := '';
end;

{ TfrmInvoiceNumMask }

procedure TfrmInvoiceNumMask.FillMaskLists;
var
  i: integer;
begin
  for i := 1 to MAX_NUMBER_OF_CHARS do
    maskCharList.AddObject('Char' + IntToStr(i),TMaskChar.Create);

  maskEditList.AddObject('Edit1',Edit1);
  maskEditList.AddObject('Edit2',Edit2);
  maskEditList.AddObject('Edit3',Edit3);
  maskEditList.AddObject('Edit4',Edit4);
  maskEditList.AddObject('Edit5',Edit5);
  maskEditList.AddObject('Edit6',Edit6);
  maskEditList.AddObject('Edit7',Edit7);
  maskEditList.AddObject('Edit8',Edit8);
  maskEditList.AddObject('Edit9',Edit9);
  maskEditList.AddObject('Edit10',Edit10);
  maskEditList.AddObject('Edit11',Edit11);
  maskEditList.AddObject('Edit12',Edit12);
  maskEditList.AddObject('Edit13',Edit13);
  maskEditList.AddObject('Edit14',Edit14);
  maskEditList.AddObject('Edit15',Edit15);
end;

procedure TfrmInvoiceNumMask.FormCreate(Sender: TObject);
begin
  AskSave := false;

  qrySuppliers.Open;
  maskCharList := TStringList.Create;
  maskEditList := TStringList.Create;
  FillMaskLists;
end;

procedure TfrmInvoiceNumMask.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to maskCharList.Count-1 do
  begin
    maskCharList.Objects[i].Free;
    maskCharList.Objects[i] := nil;
  end;
  maskCharList.Free;
  maskEditList.Free;
end;

procedure TfrmInvoiceNumMask.CharBtnActionExecute(Sender: TObject);
begin
  SelectedChar := TMaskChar(maskCharList.Objects[TAction(Sender).Tag-1]);
  SelectedEdit := TEdit(maskEditList.Objects[TAction(Sender).Tag-1]);
  if not pnlAttributes.Visible then
    pnlAttributes.Visible := true;
  pnlAttributes.Left := SelectedEdit.Left;
  pnlAttributes.TabStop := true;
  pnlAttributes.TabOrder := TAction(Sender).Tag;
  rgpCharType.ItemIndex := SelectedChar.charType;
  if (SelectedChar.charType = ALPHA_CHAR) then
  begin
    rgpCase.ItemIndex := SelectedChar.charCase;
    rgpCase.Visible := true;
  end
  else
  begin
    rgpCase.ItemIndex := -1;
    rgpCase.Visible := false;
  end;
  gpLiteralChar.Visible := (SelectedChar.charType = LITERAL_CHAR);
end;


procedure TfrmInvoiceNumMask.GetSupplierMasks(supplierName: String);
begin
  if dmADO.SQLTableExists('#tmpmask') then dmADO.DelSQLTable('#tmpmask');

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TABLE [#tmpmask] (');
    SQL.Add('	[Supplier Name] [varchar] (20) collate database_default NULL ,');
    SQL.Add('   [ConvertedMask] [varchar] (30) collate database_default NULL ,');
    SQL.Add('	[Mask] [varchar] (45) collate database_default NULL,');
    SQL.Add('	[MaskID] [smallint] NULL ,');
    SQL.Add('	[CurrentMask] [bit] NOT NULL DEFAULT (0)');
    SQL.Add(') ON [PRIMARY]');
    ExecSQL;
    Close;
    SQL.Clear;
    SQL.Add('Insert into #tmpmask');
    SQL.Add('select [Supplier Name], '''', [Mask], [MaskID], [CurrentMask]');
    SQL.Add('from SupplierMask');
    SQL.Add('where [Supplier Name] = ' + QuotedStr(supplierName));
    ExecSQL;
  end;
end;

procedure TfrmInvoiceNumMask.rgpCharTypeClick(Sender: TObject);
begin
  if not (SelectedChar.charType = rgpCharType.ItemIndex) then
    AskSave := True;
  SelectedChar.charType := rgpCharType.ItemIndex;
  rgpCase.ItemIndex := SelectedChar.charCase;
  rgpCase.Visible := (SelectedChar.charType = ALPHA_CHAR);
  gpLiteralChar.Visible := (SelectedChar.charType = LITERAL_CHAR);

  case SelectedChar.charType of
    NUMERIC_CHAR :
      SelectedEdit.Text := '9';
    ALPHA_NUMERIC_CHAR :
      SelectedEdit.Text := 'AN';
    ANY_TYPE_CHAR :
      SelectedEdit.Text := 'C';
    ALPHA_CHAR :
      case SelectedChar.charCase of
        UPPER_CASE : SelectedEdit.Text := 'A';
        LOWER_CASE : SelectedEdit.Text := 'a';
        NEITHER    : SelectedEdit.Text := 'Aa';
      end;
    LITERAL_CHAR :
      begin
        editLiteralChar.Text := SelectedChar.literalChar;
        SelectedEdit.Text := SelectedChar.literalChar;
        editLiteralChar.SetFocus;
      end;
  else
    Exit;
  end;
  BuildEditMask;
end;

procedure TfrmInvoiceNumMask.rgpCaseClick(Sender: TObject);
begin
  if not (SelectedChar.charCase = rgpCase.ItemIndex) then
    AskSave := True;
  SelectedChar.charCase := rgpCase.ItemIndex;
  case SelectedChar.charCase of
    UPPER_CASE : SelectedEdit.Text := 'A';
    LOWER_CASE : SelectedEdit.Text := 'a';
    NEITHER    : SelectedEdit.Text := 'Aa';
  else
    Exit;
  end;
  BuildEditMask;
end;

procedure TfrmInvoiceNumMask.editLiteralCharChange(Sender: TObject);
begin
  if not (SelectedChar.literalChar = editLiteralChar.Text) then
    AskSave := True;
  SelectedChar.literalChar := editLiteralChar.Text;
  SelectedEdit.Text := editLiteralChar.Text;
  BuildEditMask;
end;

procedure TfrmInvoiceNumMask.DeleteCharActionExecute(Sender: TObject);
begin
  SelectedChar.reset;
  SelectedEdit.Text := '';
  editLiteralChar.Text := '';
  rgpCase.ItemIndex := -1;
  rgpCharType.ItemIndex := -1;
  rgpCase.Visible := false;
  gpLiteralChar.Visible := false;
  BuildEditMask;
end;

// Don't allow a char to be deleted if the next char is filled.  This
// will prevent "gaps" being added to the mask
procedure TfrmInvoiceNumMask.DeleteCharActionUpdate(Sender: TObject);
begin
  DeleteCharAction.Enabled := (CurrentCharIsFilled and NextCharIsEmpty);
end;

function TfrmInvoiceNumMask.CurrentCharIsFilled: boolean;
begin
  Result := (SelectedEdit.Text <> '');
end;

function TfrmInvoiceNumMask.NextCharIsEmpty: Boolean;
begin
  if (SelectedEdit.Tag = maskEditList.Count) then
    Result := TRUE
  else
    Result := (TEdit(maskEditList.Objects[SelectedEdit.Tag]).Text = '');
end;


procedure TfrmInvoiceNumMask.BuildEditMask;
var
  i: integer;
  charStrings: TStringList;
begin
  charStrings := TStringList.Create;

  case TMaskChar(maskCharList.Objects[0]).charType of
    NUMERIC_CHAR :
      charStrings.Add('0');
    ALPHA_NUMERIC_CHAR :
      charStrings.Add('A');
    ANY_TYPE_CHAR :
      charStrings.Add('C');
    LITERAL_CHAR :
      charStrings.Add('\' + TMaskChar(maskCharList.Objects[0]).literalChar);
    ALPHA_CHAR :
      case TMaskChar(maskCharList.Objects[0]).charCase of
        UPPER_CASE :  charStrings.Add('>L<');
        LOWER_CASE :  charStrings.Add('<L>');
        NEITHER    :  charStrings.Add('<>L');
      end;
  end;

  for i := 1 to maskCharList.Count-1 do
    getCharStr(TMaskChar(maskCharList.Objects[i]),
               TMaskChar(maskCharList.Objects[i-1]),
               charStrings,i-1);

  MaskExample.EditMask := '';
  for i := 0 to charStrings.Count-1 do
    MaskExample.EditMask := MaskExample.EditMask + charStrings[i];

  MaskExample.Text := '';
  charStrings.Free;
end;

procedure TfrmInvoiceNumMask.getCharStr(aCurrentChar, aPreviousChar: TMaskChar; var aCharStrings: TStringList; aPreviousCharNum: smallint);
begin
  if (aCurrentChar.charType = -1) then
    Exit;

  case aCurrentChar.charType of
    NUMERIC_CHAR :
      aCharStrings.Add('0');
    ALPHA_NUMERIC_CHAR :
      aCharStrings.Add('A');
    ANY_TYPE_CHAR :
      aCharStrings.Add('C');
    LITERAL_CHAR :
      aCharStrings.Add('\' + aCurrentChar.literalChar);
    ALPHA_CHAR :
      case aCurrentChar.charCase of
        UPPER_CASE :
          if (aPreviousChar.charType = ALPHA_CHAR) then
            case aPreviousChar.charCase of
              UPPER_CASE :
                begin
                  acharStrings[aPreviousCharNum] := copy(aCharStrings[aPreviousCharNum],
                                                      1,pos('<',aCharStrings[aPreviousCharNum])-1);
                  aCharStrings.Add('L<');
                end;
              LOWER_CASE :
                aCharStrings.Add('L<');
              NEITHER    :
                aCharStrings.Add('>L<');
            end
          else
            aCharStrings.Add('>L<');
        LOWER_CASE :
          if (aPreviousChar.charType = ALPHA_CHAR) then
            case aPreviousChar.charCase of
              UPPER_CASE :
                aCharStrings.Add('L>');
              LOWER_CASE :
                begin
                  aCharStrings[aPreviousCharNum] := copy(aCharStrings[aPreviousCharNum],
                                                      1,pos('>',aCharStrings[aPreviousCharNum])-1);
                  aCharStrings.Add('L>');
                end;
              NEITHER    :
                aCharStrings.Add('<L>');
            end
          else
            aCharStrings.Add('<L>');
        NEITHER    :
          if (aPreviousChar.charType = ALPHA_CHAR) then
            case aPreviousChar.charCase of
              UPPER_CASE :
                aCharStrings.Add('>L');
              LOWER_CASE :
                begin
                  aCharStrings[aPreviousCharNum] := copy(aCharStrings[aPreviousCharNum],
                                                      1,pos('>',aCharStrings[aPreviousCharNum])-1);
                  aCharStrings.Add('<>L');
                end;
              NEITHER    :  aCharStrings.Add('<>L');
            end
          else
            aCharStrings.Add('<>L');
      end;
  end;
end;


procedure TfrmInvoiceNumMask.FillMaskChars;
var
  maskStr: string;
  strPos, i: smallInt;
begin
  maskStr :=  TmpMaskTbl.FieldByName('Mask').AsString;

  resetMaskChars;

  if (maskStr = '') then
  begin
    Exit;
  end;

  strPos := 1;
  setFirstChar(maskStr, strPos);

  for i := 1 to maskCharList.Count-1 do
    setChar(TMaskChar(maskCharList.Objects[i]),
            TMaskChar(maskCharList.Objects[i-1]),
            TEdit(maskEditList.Objects[i]),
            maskStr,strPos);

  BuildEditMask;
end;

procedure TfrmInvoiceNumMask.resetMaskChars;
var
  i: integer;
begin
  for i := 0 to maskCharList.Count-1 do
  begin
    TMaskChar(maskCharList.Objects[i]).reset;
    TEdit(maskEditList.Objects[i]).Text := '';
  end;
end;

function TfrmInvoiceNumMask.GetConvertedMask(aDatabaseMaskStr: String): String;
var
  maskStr, tmpStr, caseTypeStr: String;
  strPos, i: smallInt;
  charType, caseType: smallInt;
begin
  maskStr := '';
  strPos := 1;
  while strPos <= Length(aDatabaseMaskStr) do
  begin
    tmpStr := getChar(aDatabaseMaskStr, strPos, charType, caseType);
    if (charType = ALPHA_CHAR) then
    begin
      case caseType of
        UPPER_CASE : caseTypeStr := 'A';
        LOWER_CASE : caseTypeStr := 'a';
        NEITHER    : caseTypeStr := 'Aa';
      end;
      for i := 0 to Length(tmpStr)-1 do
      begin
        maskStr := maskStr + caseTypeStr;
      end;
    end
    else
    begin
      maskStr := maskStr + tmpStr;
    end;
  end;
  Result := maskStr;
end;

procedure TfrmInvoiceNumMask.ConvertSupplierMasks;
begin
  with TmpMaskTbl do
  begin
    Close;
    TableName := '#tmpmask';
    Open;
    First;
    while not Eof do
    begin
      Edit;
      TmpMaskTbl.FieldByName('ConvertedMask').Value := GetConvertedMask(TmpMaskTbl.FieldByName('Mask').Value);
      Post;
      Next;
    end;
  end;
end;

function TfrmInvoiceNumMask.getChar(aMaskStr: string; var aStrPos: smallInt; var aCharType: smallInt; var aCaseType: smallInt): string;
var
  i: integer;
begin
  aCharType := NO_TYPE;
  aCaseType := NO_CASE;
  Result := '';
  i := 0;

  if aStrPos > Length(aMaskStr) then
  begin
    Result := '';
    exit;
  end;

  if (Copy(aMaskStr, aStrPos, 1) = '0') then
  begin
    aCharType := NUMERIC_CHAR;
    Result := '9';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'A') then
  begin
    aCharType := ALPHA_NUMERIC_CHAR;
    Result := 'AN';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'C') then
  begin
    aCharType := ANY_TYPE_CHAR;
    Result := 'C';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '\') then
  begin
    aCharType := LITERAL_CHAR;
    Result := Copy(aMaskStr, aStrPos + 1, 1);
    aStrPos := aStrPos + 2;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '>') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      aCharType := ALPHA_CHAR;
      aCaseType := UPPER_CASE;
      i := aStrPos + 1;
    end
    else
    begin
      aCharType := NO_TYPE;
      aStrPos := aStrPos + 1;
    end;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '<') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = '>') then
    begin
      if (Copy(aMaskStr, aStrPos + 2, 1) = 'L') then
      begin
        aCharType := ALPHA_CHAR;
        aCaseType := NEITHER;
        i := aStrPos + 2;
      end
    end
    else if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      aCharType := ALPHA_CHAR;
      aCaseType := LOWER_CASE;
      i := aStrPos + 1;
    end
    else
    begin
      aCharType := NO_TYPE;
      aStrPos := aStrPos + 1;
    end;
  end;

  if (aCharType = ALPHA_CHAR) then
  begin
    while (Copy(aMaskStr, i, 1) = 'L') do
    begin
      Result := Result + 'L';
      i := i + 1;
    end;
    aStrPos := i;
  end;
end;

procedure TfrmInvoiceNumMask.setFirstChar(aMaskStr: string; var aStrPos: smallInt);
begin
  if aStrPos > Length(aMaskStr) then
    exit;

  if (Copy(aMaskStr, aStrPos, 1) = '0') then
  begin
    TMaskChar(maskCharList.Objects[0]).charType := NUMERIC_CHAR;
    TEdit(maskEditList.Objects[0]).Text := '9';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'A') then
  begin
    TMaskChar(maskCharList.Objects[0]).charType := ALPHA_NUMERIC_CHAR;
    TEdit(maskEditList.Objects[0]).Text := 'AN';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'C') then
  begin
    TMaskChar(maskCharList.Objects[0]).charType := ANY_TYPE_CHAR;
    TEdit(maskEditList.Objects[0]).Text := 'C';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '\') then
  begin
    TMaskChar(maskCharList.Objects[0]).charType := LITERAL_CHAR;
    TMaskChar(maskCharList.Objects[0]).literalChar := Copy(aMaskStr, aStrPos + 1, 1);
    TEdit(maskEditList.Objects[0]).Text := TMaskChar(maskCharList.Objects[0]).literalChar;
    aStrPos := aStrPos + 2;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '>') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      TMaskChar(maskCharList.Objects[0]).charType := ALPHA_CHAR;
      TMaskChar(maskCharList.Objects[0]).charCase := UPPER_CASE;
      TEdit(maskEditList.Objects[0]).Text := 'A';
      aStrPos := aStrPos + 2;
    end
    else if (Copy(aMaskStr, aStrPos + 1, 1) = '<') then
    begin
      if (Copy(aMaskStr, aStrPos + 2, 1) = 'L') then
      begin
        TMaskChar(maskCharList.Objects[0]).charType := ALPHA_CHAR;
        TMaskChar(maskCharList.Objects[0]).charCase := LOWER_CASE;
        TEdit(maskEditList.Objects[0]).Text := 'a';
        aStrPos := aStrPos + 3
      end;
    end;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '<') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      TMaskChar(maskCharList.Objects[0]).charType := ALPHA_CHAR;
      TMaskChar(maskCharList.Objects[0]).charCase := LOWER_CASE;
      TEdit(maskEditList.Objects[0]).Text := 'a';
      aStrPos := aStrPos + 2;
    end
    else
    if (Copy(aMaskStr, aStrPos + 1, 1) = '>') then
    begin
      if (Copy(aMaskStr, aStrPos + 2, 1) = 'L') then
      begin
        TMaskChar(maskCharList.Objects[0]).charType := ALPHA_CHAR;
        TMaskChar(maskCharList.Objects[0]).charCase := NEITHER;
        TEdit(maskEditList.Objects[0]).Text := 'Aa';
        aStrPos := aStrPos + 3;
      end
    end;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'L') then
  begin
    TMaskChar(maskCharList.Objects[0]).charType := ALPHA_CHAR;
    TMaskChar(maskCharList.Objects[0]).charCase := NEITHER;
    TEdit(maskEditList.Objects[0]).Text := 'Aa';
    aStrPos := aStrPos + 1;
  end;
end;

procedure TfrmInvoiceNumMask.setChar(aCurrentChar, aPreviousChar: TMaskChar; aMaskEdit: TEdit; aMaskStr: string; var aStrPos: smallInt);
begin
  if aStrPos > Length(aMaskStr) then
    exit;

  if (Copy(aMaskStr, aStrPos, 1) = '0') then
  begin
    aCurrentChar.charType := NUMERIC_CHAR;
    aMaskEdit.Text := '9';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'A') then
  begin
    aCurrentChar.charType := ALPHA_NUMERIC_CHAR;
    aMaskEdit.Text := 'AN';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'C') then
  begin
    aCurrentChar.charType := ANY_TYPE_CHAR;
    aMaskEdit.Text := 'C';
    aStrPos := aStrPos + 1;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '\') then
  begin
    aCurrentChar.charType := LITERAL_CHAR;
    aCurrentChar.literalChar := Copy(aMaskStr, aStrPos + 1, 1);
    aMaskEdit.Text := aCurrentChar.literalChar;
    aStrPos := aStrPos + 2;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '>') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      aCurrentChar.charType := ALPHA_CHAR;
      aCurrentChar.charCase := UPPER_CASE;
      aMaskEdit.Text := 'A';
      aStrPos := aStrPos + 2;
    end
    else if (Copy(aMaskStr, aStrPos + 1, 1) = '<') then
    begin
      if (Copy(aMaskStr, aStrPos + 2, 1) = 'L') then
      begin
        aCurrentChar.charType := ALPHA_CHAR;
        aCurrentChar.charCase := LOWER_CASE;
        aMaskEdit.Text := 'a';
        aStrPos := aStrPos + 3
      end;
    end
    else
    begin
      aCurrentChar.charType := NO_TYPE;
      aStrPos := aStrPos + 1;
      setChar(aCurrentChar,aPreviousChar,aMaskEdit,aMaskStr,aStrPos);
    end;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = '<') then
  begin
    if (Copy(aMaskStr, aStrPos + 1, 1) = 'L') then
    begin
      aCurrentChar.charType := ALPHA_CHAR;
      aCurrentChar.charCase := LOWER_CASE;
      aMaskEdit.Text := 'a';
      aStrPos := aStrPos + 2;
    end
    else
    if (Copy(aMaskStr, aStrPos + 1, 1) = '>') then
    begin
      if (Copy(aMaskStr, aStrPos + 2, 1) = 'L') then
      begin
        aCurrentChar.charType := ALPHA_CHAR;
        aCurrentChar.charCase := NEITHER;
        aMaskEdit.Text := 'Aa';
        aStrPos := aStrPos + 3;
      end
    end
    else
    begin
      aCurrentChar.charType := NO_TYPE;
      aStrPos := aStrPos + 1;
      setChar(aCurrentChar,aPreviousChar,aMaskEdit,aMaskStr,aStrPos);
    end;
  end
  else if (Copy(aMaskStr, aStrPos, 1) = 'L') then
  begin
    case aPreviousChar.charType of
      ALPHA_CHAR :
        begin
          case aPreviousChar.charCase of
            UPPER_CASE :  aMaskEdit.Text := 'A';
            LOWER_CASE :  aMaskEdit.Text := 'a';
          else
            aMaskEdit.Text := 'Aa';
          end;
          aCurrentChar.charType := aPreviousChar.charType;
          aCurrentChar.charCase := aPreviousChar.charCase;
        end;
    else
      aCurrentChar.charType := ALPHA_CHAR;
      aCurrentChar.charCase := NEITHER;
      aMaskEdit.Text := 'Aa';
    end;
    aStrPos := aStrPos + 1;
  end;
end;

procedure TfrmInvoiceNumMask.CharBtnActionUpdate(Sender: TObject);
begin
  if TAction(Sender).Tag = 1 then
    TAction(Sender).Enabled := not ( (Task = TASK_NONE) or (Task = TASK_VIEW) )
  else
    TAction(Sender).Enabled := (TEdit(maskEditList.Objects[TAction(Sender).Tag-2]).Text <> '') and
                               not (Task = TASK_VIEW);
end;

procedure TfrmInvoiceNumMask.SaveTheMask;
var
  frmCurrentMask: TfrmCurrentMask;
  selectedMask: string;
begin
  selectedMask := GetConvertedMask(MaskExample.EditMask);
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    case Task of
      TASK_INSERT:
        begin
          SQL.Add('INSERT INTO [SupplierMask]([Supplier Name], [MaskID], [Mask], [CurrentMask])');
          SQL.Add('VALUES(' + QuotedStr(SupplierLookUp.Text) + ', ');
          SQL.Add(IntToStr(theMaskID) + ', ');
          SQL.Add(QuotedStr(MaskExample.EditMask) + ', ');
          SQL.Add(IntToStr(currentMask) + ')');
          ExecSQL;
        end;
      TASK_VIEW:
        begin
          SQL.Add('UPDATE [SupplierMask]');
          SQL.Add('SET [CurrentMask] = ' + InttoStr(currentMask));
          SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(SupplierLookUp.Text));
          SQL.Add('AND [MaskID] = ' + IntToStr(theMaskID));
          ExecSQL;
        end;
    end;
    // if the new mask is the current mask then set all the other
    // masks currentMask value to 0
    if (currentMask = 1) then
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [SupplierMask]');
      SQL.Add('SET [CurrentMask] = 0');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(SupplierLookUp.Text));
      SQL.Add('AND [MaskID] <> ' + IntToStr(theMaskID));
      ExecSQL;
    end;
  end;

  // update the values needed by frmCurrentMask
  TmpMaskTbl.Edit;
  TmpMaskTbl.FieldByName('ConvertedMask').Value := SelectedMask;
  TmpMaskTbl.FieldByName('MaskID').Value := theMaskID;
  TmpMaskTbl.Post;


// If this is not currentmask then check other masks for the supplier
// and if there are none with currentmask = 1 then force user to select
// one as the current mask.  If this is the current mask then check other
// masks for currentmask = 1 and change them to currentmask = 0.
  if (currentMask = 0) then
  begin
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM [SupplierMask]');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(qrySuppliersSupplierName.Value));
      SQL.Add('AND [CurrentMask] = 1');
      Open;
      if not (RecordCount > 0) then
      begin
        Close;
        SQL.Clear;
        frmCurrentMask := TfrmCurrentMask.Create(nil);
        try
          frmCurrentMask.theSupplier := qrySuppliersSupplierName.Value;
          frmCurrentMask.ShowModal;
          SQL.Add('UPDATE [SupplierMask]');
          SQL.Add('SET [CurrentMask] = 1');
          SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(SupplierLookUp.Text));
          SQL.Add('AND [MaskID] = ' + IntToStr(frmCurrentMask.selectedMaskID));
          ExecSQL;
        finally
          frmCurrentMask.Free;
        end;
      end;
    end;
  end;
  GetSupplierMasks(qrySuppliersSupplierName.Value);
  ConvertSupplierMasks;
  TmpMaskTbl.Locate('ConvertedMask',SelectedMask,[]);
  MaskLookUp.Text := TmpMaskTbl.FieldByName('ConvertedMask').Value;
  AskSave := False;
end;

procedure TfrmInvoiceNumMask.SaveActionExecute(Sender: TObject);
begin
  if AskSave then
  begin
    case MessageDlg('Do you want to save the mask for supplier ' + qrySuppliersSupplierName.Value + '?' + #13#10#10 +
                    'Please note that once a mask has been saved it cannot be edited.' + #13#10,
                    mtConfirmation, [mbYes, mbNo], 0) of
      mrYes : SaveTheMask;
      mrNo : Exit;
    end;
  end;
end;

procedure TfrmInvoiceNumMask.SaveActionUpdate(Sender: TObject);
begin
  SaveAction.Enabled := AskSave;
  MaskLookUp.Enabled := (not AskSave) and (TmpMaskTbl.RecordCount > 0);
end;

procedure TfrmInvoiceNumMask.SupplierLookUpChange(Sender: TObject);
begin
  GetSupplierMasks(qrySuppliersSupplierName.Value);
  TmpMaskTbl.Close;
  TmpMaskTbl.Open;
  if TmpMaskTbl.RecordCount > 0 then
  begin
    ConvertSupplierMasks;
    TmpMaskTbl.First;
    MaskLookUp.Text := TmpMaskTbl.FieldByName('ConvertedMask').Value;
  end
  else
  begin
    Task := TASK_NONE;
    MaskLookUp.Text := '';
    ResetMaskChars;
    MaskExample.EditMask := '';
    // prevent setting AskSave to true at this stage
    cbxCurrentMask.Tag := 1;
    cbxCurrentMask.Checked := false;
    cbxCurrentMask.Tag := 0;
    theMaskID := 0;
  end;
  AskSave := False;
end;

procedure TfrmInvoiceNumMask.MaskLookUpChange(Sender: TObject);
begin
  if TmpMaskTbl.RecordCount > 0 then
  begin
    FillMaskChars;
    if (MaskLookUp.Tag) = 0 then    // if = 1 then it should be Task_Insert
    begin
      Task := TASK_VIEW;
      StatusBar1.Panels[0].Text := CANT_EDIT_STATUS_STR;
    end;
    theMaskID := TmpMaskTbl.FieldByName('MaskID').Value;
    // prevent setting AskSave to true at this stage
    cbxCurrentMask.Tag := 1;
    cbxCurrentMask.Checked := TmpMaskTbl.FieldByName('CurrentMask').Value;
    cbxCurrentMask.Tag := 0;
    pnlAttributes.Visible := false;
  end
  else
  begin
    StatusBar1.Panels[0].Text := '';
  end;
end;

procedure TfrmInvoiceNumMask.SupplierLookUpBeforeDropDown(Sender: TObject);
begin
  SaveAction.Execute;
  pnlAttributes.Visible := false;
end;

procedure TfrmInvoiceNumMask.NewMaskActionExecute(Sender: TObject);
begin
  SaveAction.Execute;
  Task := TASK_INSERT;
  AskSave := False;
  MaskLookUp.Tag := 1;
  MaskLookUp.Text := '';
  MaskLookUp.Tag := 0;
  ResetMaskChars;
  MaskExample.EditMask := '';
  cbxCurrentMask.Tag := 1;
  cbxCurrentMask.Checked := False;
  cbxCurrentMask.Tag := 0;
  StatusBar1.Panels[0].Text := '';
  theMaskID := getNextMaskID(SupplierLookUp.Text);
  Action1.Execute;
end;

function TfrmInvoiceNumMask.getNextMaskID(suppName: string): smallint;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ISNull(Max([MaskID]),0) + 1 as NextID');
    SQL.Add('FROM [SupplierMask]');
    SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(suppName));
    Open;
    Result := FieldByName('NextID').Value;
  end;
end;

procedure TfrmInvoiceNumMask.cbxCurrentMaskClick(Sender: TObject);
begin
  if cbxCurrentMask.Checked then
    currentMask := 1
  else
    currentMask := 0;
  if (cbxCurrentMask.Tag = 0) then      // tag = 1 if cbxCurrentMask changed by loading new mask
    AskSave := True;
end;

procedure TfrmInvoiceNumMask.FormShow(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, HLP_EDIT_INVOICE_MASK);

  Caption := 'Create ' + GetLocalisedName(lsInvoice) + ' Number Mask';
  TmpMaskTbl.TableName := '#TmpMask';
  MaskLookUp.LookupTable := TmpMaskTbl;
  MaskLookUp.LookupField := 'ConvertedMask';
  SupplierLookUp.Text := qrySuppliersSupplierName.Value;
  SupplierLookUp.PerformSearch;
end;

procedure TfrmInvoiceNumMask.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  SaveAction.Execute;
end;

procedure TfrmInvoiceNumMask.CloseAttrPanelActionExecute(Sender: TObject);
begin
  pnlAttributes.Visible := false;
end;


end.
