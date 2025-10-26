unit uAztecDBLookupBox;

interface

uses
  DBCtrls, DB, Controls, Messages, Windows, Classes, StdCtrls, SysUtils,
  VDBConsts, Dialogs, Variants;

type
  TAztecDBLookupBox = class(TCustomComboBox)
  private
    FDataLink: TFieldDataLink;
    FPaintControl: TPaintControl;
    FOnCreateNew: TNotifyEvent;
    FOnChangeSaved: TNotifyEvent;
    FOldText: string;
    FTempItems: TStrings;
    FListFieldName: string;
    FKeyFieldName: string;
    FListLink: TDataLink;
    FExcludeList: TStringList;
    FShowCreateNew: boolean;
    FDisplayValWhenNull: string;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetComboText: Variant;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function UpdateDataSource: boolean;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetShowCreateNew(show : boolean );
    procedure SetComboText(const Value: Variant);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEditReadOnly;
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
//    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetListSource: TDataSource;
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    function GetKeyFieldName: string;
    procedure SetKeyFieldName(const Value: string);
    procedure UpdateDataset;
    procedure UpdateItems;
  protected
    procedure Change; override;
    procedure Click; override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: Pointer); override;
    procedure CreateWnd; override;
    procedure DropDown; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetItems(const Value: TStrings); override;
    procedure SetStyle(Value: TComboboxStyle); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    procedure RemoveItems(ExcludeItems: array of string);
    property Field: TField read GetField;
    property Text;
    property DisplayValueWhenNull: string read FDisplayValWhenNull write FDisplayValWhenNull;
  published
    property Style; {Must be published before Items}
    property Anchors;
    property AutoComplete;
    property AutoDropDown;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property Items;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property ShowCreateNew: Boolean read FShowCreateNew write SetShowCreateNew default True;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    //Following event is called after the dataset connected to this component has been updated.
    property OnChangeSaved: TNotifyEvent read FOnChangeSaved write FOnChangeSaved;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnCreateNew: TNotifyEvent read FOnCreateNew write FOnCreateNew;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;
  end;

const
  NEW_ITEM = '<Create New...>';

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Data Controls', [TAztecDBLookupBox]);
end;

{ TAztecDBLookupBox }

procedure TAztecDBLookupBox.Change;
begin
  if ItemIndex = -1 then Exit;

  if ItemIndex = Items.IndexOf(NEW_ITEM) then
  begin
    ItemIndex := Items.IndexOf(FOldText);

    if Assigned(FOnCreateNew) then
      FOnCreateNew(Self);

    UpdateItems; // Pick up any new item added by the user

    ItemIndex := Items.IndexOf(FOldText);

    Parent.SetFocus;
  end
  else
  begin
    UpdateDataSource;
    inherited Change;

    FDataLink.Modified;

    //In a change to the normal TCustomComboBox behaviour we will write the selected value to the
    //underlying dataset now rather than wait until the component loses focus.
    UpdateDataset;
  end;
end;


//procedure TAztecDBLookupBox.Change;
//begin
//  FDataLink.Edit;
//  inherited Change;
//
//  if ItemIndex = Items.IndexOf(NEW_ITEM) then
//  begin
//    ItemIndex := Items.IndexOf(FOldText);
//
//    if Assigned(FOnCreateNew) then
//      FOnCreateNew(Self);
//
//    ItemIndex := Items.IndexOf(FOldText);
//
//    Parent.SetFocus;
//  end
//  else
//  begin
//    FDataLink.Modified;
//
//    //In a change to the normal TCustomComboBox behaviour we will write the selected value to the
//    //underlying dataset now rather than wait until the component loses focus.
//    UpdateDataset;
//  end;
//end;

//Update the underlying dataset connected to this combobox with the selected value
procedure TAztecDBLookupBox.UpdateDataset;
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;

  if Assigned(FOnChangeSaved) then
    FOnChangeSaved(Self);
end;

procedure TAztecDBLookupBox.UpdateItems;
var
  NewList: TStrings;
  i, ExcludeIndex: integer;
begin
  NewList := TStringList.Create;

  with FListLink.DataSet do
  begin
    Active := True;

    while not Eof do
    begin
      NewList.Add(FieldByName(FListFieldName).AsString);

      Next;
    end;

    Active := False;
  end;

  for i := 0 to FExcludeList.Count - 1 do
  begin
    ExcludeIndex := NewList.IndexOf(FExcludeList.Strings[i]);

    if ExcludeIndex <> -1 then
      NewList.Delete(ExcludeIndex);
  end;

  if DisplayValueWhenNull <> '' then
    NewList.Add( DisplayValueWhenNull );

  SetItems(NewList);

  NewList.Free;
end;

procedure TAztecDBLookupBox.DropDown;
begin
  FOldText := Text;

  UpdateItems;

  inherited DropDown;
end;

constructor TAztecDBLookupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FPaintControl := TPaintControl.Create(Self, 'COMBOBOX');
  FListLink := TDataLink.Create;
  FExcludeList := TstringList.Create;
  FTempItems := TStringList.Create;
  FShowCreateNew := true;
  FDisplayValWhenNull := '';
end;

destructor TAztecDBLookupBox.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  FListLink.Free;
  FExcludeList.Free;
  FTempItems.Free;
  inherited Destroy;
end;

procedure TAztecDBLookupBox.Loaded;
begin
  inherited Loaded;
  //if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TAztecDBLookupBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TAztecDBLookupBox.CreateWnd;
begin
  inherited CreateWnd;
  SetEditReadOnly;
end;

procedure TAztecDBLookupBox.DataChange(Sender: TObject);
begin
  if not (Style = csSimple) and DroppedDown then Exit;
  if FDataLink.Field <> nil then
    SetComboText(FDataLink.Field.Value);
end;

procedure TAztecDBLookupBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Value := GetComboText;
end;

procedure TAztecDBLookupBox.SetComboText(const Value: Variant);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
  begin
    with FListLink.DataSet do
    begin
      Active := True;

      if VarIsNull(Value) then
        Text := FDisplayValWhenNull
      else if (Locate(FKeyFieldName, Value, [])) then
        Text := FieldByName(FListFieldName).AsString
      else
        Text := '';

      Active := False;
    end;
  end
  else
    Text := Name;

  FOldText := Text; // Allow user to modify field in CreateNew
end;

function TAztecDBLookupBox.GetComboText: Variant;
var
  SelectedName: string;
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
  begin
    SelectedName := Items[ItemIndex];

    with FListLink.DataSet do
    begin
      Active := True;

      if SelectedName = FDisplayValWhenNull then
        Result := Null
      else if Locate(FListFieldName, SelectedName, []) then
        Result := FieldByName(FKeyFieldName).Value
      else
        Result := -1;

      Active := False;
    end;
  end
  else
    Result := Name;
end;

procedure TAztecDBLookupBox.Click;
begin
//  FDataLink.Edit;
  inherited Click;
//  FDataLink.Modified;
end;

function TAztecDBLookupBox.GetDataSource: TDataSource;
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

function TAztecDBLookupBox.UpdateDataSource: boolean;
begin
  if (ItemIndex = Items.IndexOf(NEW_ITEM)) or (ItemIndex = -1) then
    Result := true
  else
    Result := FDataLink.Edit;
end;

procedure TAztecDBLookupBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TAztecDBLookupBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TAztecDBLookupBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TAztecDBLookupBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TAztecDBLookupBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TAztecDBLookupBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TAztecDBLookupBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_F2 then begin
    DroppedDown := true;
    Key := 0;
  end;
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if not UpdateDataSource and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
  end;
end;

procedure TAztecDBLookupBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      UpdateDataSource;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
      end;
  end;
end;

procedure TAztecDBLookupBox.EditingChange(Sender: TObject);
begin
  SetEditReadOnly;
end;

procedure TAztecDBLookupBox.SetEditReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(not FDataLink.Editing), 0);
end;

procedure TAztecDBLookupBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not UpdateDataSource then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then UpdateDataSource else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
      WM_CREATE,
      WM_WINDOWPOSCHANGED,
      CM_FONTCHANGED:
        FPaintControl.DestroyHandle;
    end;
  inherited WndProc(Message);
end;

procedure TAztecDBLookupBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_LBUTTONDOWN:
        if (Style = csSimple) and (ComboWnd <> EditHandle) then
          if not UpdateDataSource then Exit;
    end;
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TAztecDBLookupBox.CMEnter(var Message: TCMEnter);
begin
  inherited;

  if SysLocale.FarEast and FDataLink.CanModify then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(False), 0);
end;

//procedure TAztecDBLookupBox.CMExit(var Message: TCMExit);
//begin
//  UpdateDataset;
//  inherited;
//end;

procedure TAztecDBLookupBox.WMPaint(var Message: TWMPaint);
var
  S: string;
  R: TRect;
  P: TPoint;
  Child: HWND;
begin
  if csPaintCopy in ControlState then
  begin
    if FDataLink.Field <> nil then S := FDataLink.Field.Text else S := '';
    if Style = csDropDown then
    begin
      SendMessage(FPaintControl.Handle, WM_SETTEXT, 0, Longint(PChar(S)));
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
      Child := GetWindow(FPaintControl.Handle, GW_CHILD);
      if Child <> 0 then
      begin
        Windows.GetClientRect(Child, R);
        Windows.MapWindowPoints(Child, FPaintControl.Handle, R.TopLeft, 2);
        GetWindowOrgEx(Message.DC, P);
        SetWindowOrgEx(Message.DC, P.X - R.Left, P.Y - R.Top, nil);
        IntersectClipRect(Message.DC, 0, 0, R.Right - R.Left, R.Bottom - R.Top);
        SendMessage(Child, WM_PAINT, Message.DC, 0);
      end;
    end else
    begin
      SendMessage(FPaintControl.Handle, CB_RESETCONTENT, 0, 0);
      if Items.IndexOf(S) <> -1 then
      begin
        SendMessage(FPaintControl.Handle, CB_ADDSTRING, 0, Longint(PChar(S)));
        SendMessage(FPaintControl.Handle, CB_SETCURSEL, 0, 0);
      end;
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
    end;
  end else
    inherited;
end;

procedure TAztecDBLookupBox.SetItems(const Value: TStrings);
begin
  FTempItems.Clear;
  FTempItems.AddStrings(Value);

  if (FTempItems.IndexOf(NEW_ITEM) = -1) and FShowCreateNew then
    FTempItems.Add(NEW_ITEM);

  inherited SetItems(FTempItems);

  DataChange(Self);
end;

procedure TAztecDBLookupBox.SetShowCreateNew(show : boolean );
begin
  if show <> FShowCreateNew then begin

    if show then begin
      if Items.IndexOf(NEW_ITEM) = -1 then
        Items.Add(NEW_ITEM);
    end else begin
      if Items.IndexOf(NEW_ITEM) <> -1 then
        Items.Delete( Items.IndexOf(NEW_ITEM) );
    end;

    FShowCreateNew := show;
  end;
end;

procedure TAztecDBLookupBox.SetStyle(Value: TComboboxStyle);
begin
  if (Value = csSimple) and Assigned(FDatalink) and FDatalink.DatasourceFixed then
    DatabaseError(SNotReplicatable);
  inherited SetStyle(Value);
end;

function TAztecDBLookupBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TAztecDBLookupBox.CMGetDatalink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TAztecDBLookupBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TAztecDBLookupBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TAztecDBLookupBox.GetKeyFieldName: string;
begin
  Result := FKeyFieldName;
end;

function TAztecDBLookupBox.GetListSource: TDataSource;
begin
  if (csLoading in ComponentState) then
    Result := nil
  else
    Result := FListLink.DataSource;
end;

procedure TAztecDBLookupBox.SetKeyFieldName(const Value: string);
begin
  if FKeyFieldName <> Value then
    FKeyFieldName := Value;
end;

procedure TAztecDBLookupBox.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
    FListFieldName := Value;
end;

procedure TAztecDBLookupBox.SetListSource(Value: TDataSource);
begin
  FListLink.DataSource := Value;

  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TAztecDBLookupBox.RemoveItems(ExcludeItems: array of string);
var
  i: integer;
begin
  FExcludeList.Clear;

  for i := low(ExcludeItems) to high(ExcludeItems) do
    FExcludeList.Add(ExcludeItems[i]);
end;

end.
