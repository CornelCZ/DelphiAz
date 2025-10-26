unit uAztecDBComboBox;

interface

uses
  DBCtrls, DB, Controls, Messages, Windows, Classes, StdCtrls, SysUtils,
  VDBConsts, Dialogs;

type
  TAztecDBComboBox = class(TCustomComboBox)
  private
    FDataLink: TFieldDataLink;
    FPaintControl: TPaintControl;
    FOnCreateNew: TNotifyEvent;
    FOldText: string;
    FTempItems: TStrings;
    FShowCreateNew: boolean;
    FInChangeHandler: boolean;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetComboText: string;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetShowCreateNew(show : boolean );
    procedure SetComboText(const Value: string);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEditReadOnly;
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
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
    property Field: TField read GetField;
    property Text;
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
    property Items write SetItems;
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
  RegisterComponents('Data Controls', [TAztecDBComboBox]);
end;

{ TAztecDBComboBox }

procedure TAztecDBComboBox.Change;
begin
  if FInChangeHandler then
    Exit;

  FInChangeHandler := true;
  try
    FDataLink.Edit;
    inherited Change;

    if ItemIndex = Items.IndexOf(NEW_ITEM) then
    begin
      ItemIndex := Items.IndexOf(FOldText);

      if Assigned(FOnCreateNew) then
        FOnCreateNew(Self);

      ItemIndex := Items.IndexOf(FOldText);

      Parent.SetFocus;
    end;

    FDataLink.Modified;
  finally
    FInChangeHandler := false;
  end;
end;

procedure TAztecDBComboBox.DropDown;
begin
  FOldText := Text;

  inherited DropDown;
end;

constructor TAztecDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FPaintControl := TPaintControl.Create(Self, 'COMBOBOX');
  FTempItems := TStringList.Create;
  FShowCreateNew := true;
  FInChangeHandler := false;
end;

destructor TAztecDBComboBox.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  FTempItems.Free;
  inherited Destroy;
end;

procedure TAztecDBComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TAztecDBComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TAztecDBComboBox.CreateWnd;
begin
  inherited CreateWnd;
  SetEditReadOnly;
end;

procedure TAztecDBComboBox.DataChange(Sender: TObject);
begin
  if not (Style = csSimple) and DroppedDown then Exit;
  if FDataLink.Field <> nil then
    SetComboText(FDataLink.Field.Text)
  else
    if csDesigning in ComponentState then
      SetComboText(Name)
    else
      SetComboText('');
end;

procedure TAztecDBComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := GetComboText;
end;

procedure TAztecDBComboBox.SetComboText(const Value: string);
var
  I: Integer;
  Redraw: Boolean;
begin
  if Value <> GetComboText then
  begin
    if Style <> csDropDown then
    begin
      Redraw := (Style <> csSimple) and HandleAllocated;
      if Redraw then SendMessage(Handle, WM_SETREDRAW, 0, 0);
      try
        if Value = '' then I := -1 else I := Items.IndexOf(Value);
        ItemIndex := I;
      finally
        if Redraw then
        begin
          SendMessage(Handle, WM_SETREDRAW, 1, 0);
          Invalidate;
        end;
      end;
      if I >= 0 then Exit;
    end;
    if Style in [csDropDown, csSimple] then begin
      Text := Value;
      FOldText := Value; // Allows user to set text during OnCreateNew
    end;
  end;
end;

function TAztecDBComboBox.GetComboText: string;
var
  I: Integer;
begin
  if Style in [csDropDown, csSimple] then Result := Text else
  begin
    I := ItemIndex;
    if I < 0 then Result := '' else Result := Items[I];
  end;
end;

procedure TAztecDBComboBox.Click;
begin
  FDataLink.Edit;
  inherited Click;
  FDataLink.Modified;
end;

function TAztecDBComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TAztecDBComboBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TAztecDBComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TAztecDBComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TAztecDBComboBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TAztecDBComboBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TAztecDBComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TAztecDBComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_F2 then begin
    DroppedDown := true;
    Key := 0;
  end;
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if not FDataLink.Edit and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
  end;
end;

procedure TAztecDBComboBox.KeyPress(var Key: Char);
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
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
      end;
  end;
end;

procedure TAztecDBComboBox.EditingChange(Sender: TObject);
begin
  SetEditReadOnly;
end;

procedure TAztecDBComboBox.SetEditReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(not FDataLink.Editing), 0);
end;

procedure TAztecDBComboBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then FDataLink.Edit else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
      WM_CREATE,
      WM_WINDOWPOSCHANGED,
      CM_FONTCHANGED:
        FPaintControl.DestroyHandle;
    end;
  inherited WndProc(Message);
end;

procedure TAztecDBComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_LBUTTONDOWN:
        if (Style = csSimple) and (ComboWnd <> EditHandle) then
          if not FDataLink.Edit then Exit;
    end;
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TAztecDBComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;

  if SysLocale.FarEast and FDataLink.CanModify then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(False), 0);
end;

procedure TAztecDBComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TAztecDBComboBox.WMPaint(var Message: TWMPaint);
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

procedure TAztecDBComboBox.SetItems(const Value: TStrings);
begin
  FTempItems.Clear;
  FTempItems.AddStrings(Value);
  TStringList(FTempItems).Sorted := False;

  if (FTempItems.IndexOf(NEW_ITEM) = -1) and FShowCreateNew then
    FTempItems.Add(NEW_ITEM);

  inherited SetItems(FTempItems);

  DataChange(Self);
end;

procedure TAztecDBComboBox.SetShowCreateNew(show : boolean );
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

procedure TAztecDBComboBox.SetStyle(Value: TComboboxStyle);
begin
  if (Value = csSimple) and Assigned(FDatalink) and FDatalink.DatasourceFixed then
    DatabaseError(SNotReplicatable);
  inherited SetStyle(Value);
end;

function TAztecDBComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TAztecDBComboBox.CMGetDatalink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TAztecDBComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TAztecDBComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

end.
