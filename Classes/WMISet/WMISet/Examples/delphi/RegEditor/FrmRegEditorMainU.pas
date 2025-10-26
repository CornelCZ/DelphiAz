unit FrmRegEditorMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, WmiAbstract, WmiComponent, WmiRegistry, ImgList, ComCtrls,
  ToolWin, ExtCtrls, Menus,
  {$IFDEF Delphi6} Variants, {$ENDIF}
  WmiUtil, FrmAboutU, FrmGetNameU;

type
  TFrmRegEditorMain = class(TForm)
    WmiRegistry1: TWmiRegistry;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    miSelectComputer: TMenuItem;
    N1: TMenuItem;
    miExit: TMenuItem;
    tvRegTree: TTreeView;
    Splitter1: TSplitter;
    lvValues: TListView;
    imlFolders: TImageList;
    pmValue: TPopupMenu;
    miValueModify: TMenuItem;
    N3: TMenuItem;
    miValueDelete: TMenuItem;
    miNew: TMenuItem;
    miNewBinaryValue: TMenuItem;
    miNewDWORDValue: TMenuItem;
    miNewStringValue: TMenuItem;
    N4: TMenuItem;
    miNewKey: TMenuItem;
    N5: TMenuItem;
    pmKey: TPopupMenu;
    miNew2: TMenuItem;
    miNewKey2: TMenuItem;
    MenuItem3: TMenuItem;
    miNewStringValue2: TMenuItem;
    miNewDWORDValue2: TMenuItem;
    miNewBinaryValue2: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem10: TMenuItem;
    miDeleteKey: TMenuItem;
    About1: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure tvRegTreeGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvRegTreeChange(Sender: TObject; Node: TTreeNode);
    procedure lvValuesResize(Sender: TObject);
    procedure lvValuesColumnClick(Sender: TObject; Column: TListColumn);
    procedure miSelectComputerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tvRegTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miNewStringValueClick(Sender: TObject);
    procedure miNewDWORDValueClick(Sender: TObject);
    procedure miNewBinaryValueClick(Sender: TObject);
    procedure pmValuePopup(Sender: TObject);
    procedure tvRegTreeExpanded(Sender: TObject; Node: TTreeNode);
    procedure miNewKeyClick(Sender: TObject);
    procedure miDeleteKeyClick(Sender: TObject);
    procedure pmKeyPopup(Sender: TObject);
    procedure miValueModifyClick(Sender: TObject);
    procedure miValueDeleteClick(Sender: TObject);
    procedure lvValuesDblClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    procedure InitTree;
    procedure AddChildren(ANode: TTreeNode);
    function GetNodePath(ANode: TTreeNode): string;
    function GetRootKey(ANode: TTreeNode): DWORD;
    procedure DisplayValues(Node: TTreeNode);
    procedure ResizeColumns;
    procedure MakeCaption;
    function GetNewValueName: string;
    procedure CreateValue(AType: integer);
    function GetNewKeyName: string;
    procedure CreateKey;
    procedure PopulateNodeChildren(Node: TTreeNode);
    procedure DeleteKey;
    procedure ModifyValue;
    procedure EditDWORDValue;
    procedure EditStringValue;
    procedure DeleteValue;
    procedure EditBinaryValue;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegEditorMain: TFrmRegEditorMain;

implementation

uses FrmSelectComputerU, FrmEditStringU, FrmEditDWORDU, FrmEditBinaryU;

const
  CAPTION_PREFIX = 'Registry on ';
  DEFAULT_VALUE = '(Default)';
{$R *.dfm}

function RootNameToRootKey(AName: string): DWORD;
begin
  if AName = 'HKEY_CLASSES_ROOT'     then Result := HKEY_CLASSES_ROOT else
  if AName = 'HKEY_CURRENT_USER'     then Result := HKEY_CURRENT_USER else
  if AName = 'HKEY_LOCAL_MACHINE'    then Result := HKEY_LOCAL_MACHINE else
  if AName = 'HKEY_USERS'            then Result := HKEY_USERS else
  if AName = 'HKEY_PERFORMANCE_DATA' then Result := HKEY_PERFORMANCE_DATA else
  if AName = 'HKEY_CURRENT_CONFIG'   then Result := HKEY_CURRENT_CONFIG else
  if AName = 'HKEY_DYN_DATA'         then Result := HKEY_DYN_DATA else
    Result := 0;
end;

function RegTypeToString(AValue: DWORD): string;
begin
  case AValue of
    REG_NONE:                       Result := 'REG_NONE';
    REG_SZ:                         Result := 'REG_SZ';
    REG_EXPAND_SZ:                  Result := 'REG_EXPAND_SZ';
    REG_BINARY:                     Result := 'REG_BINARY';
    REG_DWORD:                      Result := 'REG_DWORD';
    REG_DWORD_BIG_ENDIAN:           Result := 'REG_DWORD_BIG_ENDIAN';
    REG_LINK:                       Result := 'REG_LINK';
    REG_MULTI_SZ:                   Result := 'REG_MULTI_SZ';
    REG_RESOURCE_LIST:              Result := 'REG_RESOURCE_LIST';
    REG_FULL_RESOURCE_DESCRIPTOR:   Result := 'REG_FULL_RESOURCE_DESCRIPTOR';
    REG_RESOURCE_REQUIREMENTS_LIST: Result := 'REG_RESOURCE_REQUIREMENTS_LIST';
    else Result := IntToStr(AValue);
  end;
end;

procedure TFrmRegEditorMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRegEditorMain.MakeCaption;
begin
  if WmiRegistry1.MachineName = '' then
    Caption := CAPTION_PREFIX + 'local computer'
    else Caption := CAPTION_PREFIX + WmiRegistry1.MachineName;
end;

procedure TFrmRegEditorMain.InitTree;
var
  vNode: TTreeNode;
begin
  tvRegTree.Items.Clear;
  lvValues.Items.Clear;
  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_CLASSES_ROOT));
  tvRegTree.Items.AddChild(vNode, '');

  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_CURRENT_USER));
  tvRegTree.Items.AddChild(vNode, '');

  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_LOCAL_MACHINE));
  tvRegTree.Items.AddChild(vNode, '');

  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_USERS));
  tvRegTree.Items.AddChild(vNode, '');

  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_CURRENT_CONFIG));
  tvRegTree.Items.AddChild(vNode, '');

  vNode := tvRegTree.Items.AddChild(nil, WmiRegistry1.RegRootToString(HKEY_DYN_DATA));
  tvRegTree.Items.AddChild(vNode, '');
end;

procedure TFrmRegEditorMain.tvRegTreeGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if not Node.HasChildren then Node.ImageIndex := 1 else
    begin
    if Node.Expanded then Node.ImageIndex := 0 else Node.ImageIndex := 2;
    end;
  Node.StateIndex    := Node.ImageIndex;
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TFrmRegEditorMain.PopulateNodeChildren(Node: TTreeNode);
var
  tmpNode: TTreeNode;
begin
  try
  Screen.Cursor := crHourGlass;
  tmpNode := Node.GetFirstChild;
  if (tmpNode <> nil) and (tmpNode.Text = '') then
      begin
      tvRegTree.Items.Delete(tmpNode);
      AddChildren(Node);
      end;
  finally
  Screen.Cursor := crDefault;
  end;
end;

procedure TFrmRegEditorMain.AddChildren(ANode: TTreeNode);
var
  vList: TStringList;
  i: integer;
  tmpNode: TTreeNode;
begin
  tvRegTree.Items.BeginUpdate;
  try
    tmpNode := ANode;
    if tmpNode.HasChildren then tmpNode.DeleteChildren;

    WmiRegistry1.RootKey := GetRootKey(ANode);
    WmiRegistry1.CurrentPath := GetNodePath(ANode);
    vList := TStringList.Create;
    try
      WmiRegistry1.ListSubKeys(vList);
      vList.Sorted := true;
      for i := 0 to vList.Count - 1 do
      begin
        tmpNode := tvRegTree.Items.AddChild(ANode, vList[i]);
        tvRegTree.Items.AddChild(tmpNode, '');
      end;
    finally
      vList.Free;
    end;
  finally
    tvRegTree.Items.EndUpdate;
  end;
end;

function TFrmRegEditorMain.GetNodePath(ANode: TTreeNode): string;
begin
  Result := '';
  while ANode.Parent <> nil do
    begin  Result := ANode.Text+'\'+Result; ANode := ANode.Parent; end;
  if (Length(Result) > 0) and (Result[Length(Result)] = '\') then
    Result := Copy(Result, 1, Length(Result) - 1);
end;

function TFrmRegEditorMain.GetRootKey(ANode: TTreeNode): DWORD;
begin
  while ANode.Parent <> nil do ANode := ANode.Parent;
  Result := RootNameToRootKey(ANode.Text);
end;

procedure TFrmRegEditorMain.tvRegTreeChange(Sender: TObject; Node: TTreeNode);
begin
  DisplayValues(Node);
end;

procedure TFrmRegEditorMain.DisplayValues(Node: TTreeNode);
var
  vItem: TListItem;
  vList: TStringList;
  i: integer;
begin
  lvValues.Items.BeginUpdate;
  try
    lvValues.Items.Clear;
    WmiRegistry1.RootKey := GetRootKey(Node);
    WmiRegistry1.CurrentPath := GetNodePath(Node);
    vList := TStringList.Create;
    try
      WmiRegistry1.ListValues(vList);
      vList.Sorted := true;
      for i := 0 to vList.Count - 1 do
      begin
        vItem := lvValues.Items.Add;
        if vList[i] <> '' then vItem.Caption := vList[i]
          else vItem.Caption := DEFAULT_VALUE;
        WmiRegistry1.ValueName := vList[i];
        vItem.SubItems.Add(RegTypeToString(WmiRegistry1.ValueType));
        if WmiRegistry1.ValueType in [REG_SZ, REG_EXPAND_SZ, REG_BINARY, REG_DWORD, REG_MULTI_SZ] then
          vItem.SubItems.Add(VariantToString(WmiRegistry1.Value))
          else vItem.SubItems.Add('(Unknown)');
      end;
    finally
      vList.Free;
    end;
  finally
    lvValues.Items.EndUpdate;
  end;  

end;

procedure TFrmRegEditorMain.lvValuesResize(Sender: TObject);
begin
  ResizeColumns;
end;

procedure TFrmRegEditorMain.ResizeColumns;
begin
  lvValues.Columns[2].Width := lvValues.ClientWidth -
                               lvValues.Columns[0].Width -
                               lvValues.Columns[1].Width -1;
end;

procedure TFrmRegEditorMain.lvValuesColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ResizeColumns;
end;

procedure TFrmRegEditorMain.miSelectComputerClick(Sender: TObject);
var
  vUserName: string;
  vWasCursor: TCursor;

  vOldUserName, vOldPassword, vOldMachineName: widestring;
begin
  if FrmSelectComputer.ShowModal = mrOk then
  begin
    // save current credentials to be able to restore
    // them if new credentials are invalid.
    vOldUserName := WmiRegistry1.Credentials.UserName;
    vOldPassword := WmiRegistry1.Credentials.Password;
    vOldMachineName := WmiRegistry1.MachineName; 

    WmiRegistry1.Active := false;
    vUserName := FrmSelectComputer.edtUserName.Text;
    if FrmSelectComputer.edtDomain.Text <> '' then
      vUserName := FrmSelectComputer.edtDomain.Text + '\' + vUserName;
      
    WmiRegistry1.Credentials.UserName := vUserName;
    WmiRegistry1.Credentials.Password := FrmSelectComputer.edtPassword.Text;
    WmiRegistry1.MachineName := FrmSelectComputer.cmbComputers.Text;

    vWasCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      try
        WmiRegistry1.Active := true;
        InitTree;
        MakeCaption;
      finally
        Screen.Cursor := vWasCursor;
      end;
    except
      on E: Exception do
        begin
          Application.MessageBox(PChar(E.Message), 'Error', MB_Ok + MB_ICONSTOP);
          // restore previous credentials.
          WmiRegistry1.Credentials.UserName := vOldUserName;
          WmiRegistry1.Credentials.Password := vOldPassword;
          WmiRegistry1.MachineName          := vOldMachineName; 
          WmiRegistry1.Active := true;
        end;
    end;
  end;
end;

procedure TFrmRegEditorMain.FormShow(Sender: TObject);
begin
  WmiRegistry1.Active := true;
  InitTree;
  MakeCaption;
end;

procedure TFrmRegEditorMain.FormActivate(Sender: TObject);
begin
  lvValues.Refresh;
end;

procedure TFrmRegEditorMain.tvRegTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  vPoint: TPoint;  
begin
  vPoint.X := X;
  vPoint.Y := Y;
  vPoint := ClientToScreen(vPoint);
  if (Button = mbRight) and (tvRegTree.Selected <> nil) then
    pmKey.Popup(vPoint.X, vPoint.Y);
end;

procedure TFrmRegEditorMain.CreateValue(AType: integer);
var
  vName: string;
  vItem: TListItem;
begin
  vName := GetNewValueName;
  vItem := lvValues.Items.Add;
  case AType of
    REG_SZ: begin
              WmiRegistry1.WriteString(vName, '');
              vItem.SubItems.Add('REG_SZ');
              vItem.SubItems.Add('');
            end;
    REG_DWORD: begin
              WmiRegistry1.WriteInteger(vName, 0);
              vItem.SubItems.Add('REG_DWORD');
              vItem.SubItems.Add('0');
            end;
    REG_BINARY: begin
              WmiRegistry1.WriteBinaryData(vName, AType, 0);
              vItem.SubItems.Add('REG_BINARY');
              vItem.SubItems.Add('{}');
            end
  end;

  vItem.Caption := vName;
end;

function TFrmRegEditorMain.GetNewValueName: string;
var
  vList: TStrings;
  i: integer;
begin
  vList := TStringList.Create;
  try
    WmiRegistry1.ListValues(vList);
    i := 1;
    repeat
      Result := 'New Value #' + IntToStr(i);
      Inc(i);
    until vList.IndexOf(Result) = -1;
  finally
    vList.Free;
  end;

  with TFrmGetName.Create('New Value', Result) do
  try
    if ShowModal = mrOk then Result := edtName.Text else Abort;
  finally
    Free;
  end;
end;

function TFrmRegEditorMain.GetNewKeyName: string;
var
  vList: TStrings;
  i: integer;
begin
  vList := TStringList.Create;
  try
    WmiRegistry1.ListSubKeys(vList);
    i := 1;
    repeat
      Result := 'New Key #' + IntToStr(i);
      Inc(i);
    until vList.IndexOf(Result) = -1;
  finally
    vList.Free;
  end;

  with TFrmGetName.Create('New Key', Result) do
  try
    if ShowModal = mrOk then Result := edtName.Text else Abort;
  finally
    Free;
  end;

end;


procedure TFrmRegEditorMain.miNewStringValueClick(Sender: TObject);
begin
  CreateValue(REG_SZ);
end;

procedure TFrmRegEditorMain.miNewDWORDValueClick(Sender: TObject);
begin
  CreateValue(REG_DWORD);
end;

procedure TFrmRegEditorMain.miNewBinaryValueClick(Sender: TObject);
begin
  CreateValue(REG_BINARY);
end;

procedure TFrmRegEditorMain.CreateKey;
var
  vName: String;
begin
  vName := GetNewKeyName;
  PopulateNodeChildren(tvRegTree.Selected);
  tvRegTree.Selected.Expand(false);
  if not WmiRegistry1.CreateKey(vName) then
  begin
    Application.MessageBox('Error writing to the registry', 'Error Creating Key', MB_ICONHAND+MB_OK);
  end else
  begin
    tvRegTree.Selected := tvRegTree.Items.AddChild(tvRegTree.Selected, vName);
  end;
end;

procedure TFrmRegEditorMain.pmValuePopup(Sender: TObject);
begin
  miNew.Enabled := lvValues.Selected = nil;
  miValueModify.Enabled := not miNew.Enabled;
  miValueDelete.Enabled := not miNew.Enabled;
end;

procedure TFrmRegEditorMain.tvRegTreeExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  PopulateNodeChildren(Node);
end;

procedure TFrmRegEditorMain.miNewKeyClick(Sender: TObject);
begin
  CreateKey;
end;

procedure TFrmRegEditorMain.DeleteKey;
begin
  if Wmiregistry1.DeleteKey(GetNodePath(tvRegTree.Selected)) then
  begin
    tvRegTree.Items.Delete(tvRegTree.Selected);
  end else
  begin
    Application.MessageBox('Error while deleting key', 'Error', MB_ICONHAND+MB_OK);
  end;
end;

procedure TFrmRegEditorMain.miDeleteKeyClick(Sender: TObject);
begin
  DeleteKey;
end;

procedure TFrmRegEditorMain.pmKeyPopup(Sender: TObject);
begin
  miDeleteKey.Enabled := (tvRegTree.Selected <> nil) and
                          (GetNodePath(tvRegTree.Selected) <> '');
end;

procedure TFrmRegEditorMain.EditStringValue;
var
  vName: string;
begin
  vName := lvValues.Selected.Caption;
  if vName = DEFAULT_VALUE then vName := '';

  with TFrmEditString.Create(nil) do
  try
    edtValueName.Text := lvValues.Selected.Caption;
    edtValueData.Text := WmiRegistry1.ReadString(vName);

    if ShowModal = mrOk then
    begin
      WmiRegistry1.WriteString(vName, edtValueData.Text);
      DisplayValues(tvRegTree.Selected);
    end;
  finally
    Free;
  end;
end;


procedure TFrmRegEditorMain.EditDWORDValue;
var
  vName: string;
begin
  vName := lvValues.Selected.Caption;
  if vName = DEFAULT_VALUE then vName := '';

  with TFrmEditDWORD.Create(nil) do
  try
    edtValueName.Text := lvValues.Selected.Caption;
    ValueData := WmiRegistry1.ReadInteger(vName);

    if ShowModal = mrOk then
    begin
      WmiRegistry1.WriteInteger(vName, ValueData);
      DisplayValues(tvRegTree.Selected);
    end;
  finally
    Free;
  end;
end;

procedure TFrmRegEditorMain.EditBinaryValue;
var
  vName: string;
begin
  vName := lvValues.Selected.Caption;
  if vName = DEFAULT_VALUE then vName := '';

  with TFrmEditBinaryValue.Create(nil) do
  try
    edtValueName.Text := lvValues.Selected.Caption;
    ValueData := WmiRegistry1.ReadValue(vName);

    if ShowModal = mrOk then
    begin
//      WmiRegistry1.WriteBinary(vName, ValueData);
      DisplayValues(tvRegTree.Selected);
    end;
  finally
    Free;
  end;

end;


procedure TFrmRegEditorMain.ModifyValue;
var
  vName: string;
begin
  vName := lvValues.Selected.Caption;
  if vName = DEFAULT_VALUE then vName := '';
  case WmiRegistry1.GetValueType(vName) of
    REG_SZ: EditStringValue;
    REG_DWORD: EditDWORDValue;
    REG_BINARY: EditBinaryValue;
    else Application.MessageBox('Editing is not implemented for this data type',
                                'Error', MB_OK + MB_ICONHAND);
  end;
end;


procedure TFrmRegEditorMain.miValueModifyClick(Sender: TObject);
begin
  ModifyValue;
end;

procedure TFrmRegEditorMain.DeleteValue;
var
  vName: string;
begin
  vName := lvValues.Selected.Caption;
  if vName = DEFAULT_VALUE then vName := '';
  WmiRegistry1.DeleteValue(vName);
  DisplayValues(tvRegTree.Selected);
end;

procedure TFrmRegEditorMain.miValueDeleteClick(Sender: TObject);
begin
  DeleteValue;
end;

procedure TFrmRegEditorMain.lvValuesDblClick(Sender: TObject);
begin
  if lvValues.Selected <> nil then
    ModifyValue;
end;

procedure TFrmRegEditorMain.About1Click(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
