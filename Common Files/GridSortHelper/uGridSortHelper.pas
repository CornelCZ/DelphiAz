unit uGridSortHelper;

interface

// Add this to the DPR for automatic resource building
{$R '..\..\Common Files\GridSortHelper\GridGlyphs.res' '..\..\Common Files\GridSortHelper\GridGlyphs.rc'}

// TODO: persist sort option in HKCU?

uses wwdbgrid, classes, graphics, db, types, forms, controls;

type
  TGridSortHelper = class(TObject)
  private
    IncSearchString: string;
    LastKeyTime: TDateTime;
    GlyphUp, GlyphDown: TBitmap;
    GlyphRect: TRect;
    Grid: TwwDBGrid;
    SavedOnDblClick: TNotifyEvent;
    SavedOnKeyPress: TKeyPressEvent;
    SortField: integer;
    IsAscending: boolean;
    function GetInitialSortField: integer;
    procedure RebuildQuery;
    // PW See Refresh method
    procedure ReopenQuery(KeyField: string = '');
    procedure HandleTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure HandleDblClick(Sender: TObject);
    procedure HandleDrawTitleCell(Sender: TObject; Canvas: TCanvas;
      Field: TField; Rect: TRect; var DefaultDrawing: Boolean);
    procedure HandleKeyPress(Sender: TObject; var Key: Char);
  public
    procedure Initialise(Grid: TwwDBGrid);
    procedure Reset;
    // PW KeyField parameter had to be added due to behaviour of bookmarks
    // not working correctly on the Theme Modelling "shared panels" dataset
    // This dataset has a calculated field and so isn't 1:1 updatable, there
    // may be a more elegant fix that I couldn't spot.
    // Might be nicer to specify this optionally in Initialise().
    procedure Refresh(KeyField: string = '');
    destructor Destroy; override;
  end;

implementation

uses Grids, ADODB, sysutils, Wwdbigrd;

{ TGridSortHelper }

destructor TGridSortHelper.Destroy;
begin
  GlyphUp.Free;
  GlyphDown.Free;
  inherited;
end;

function TGridSortHelper.GetInitialSortField: integer;
var
  FName: string;
  i: integer;
begin
  Result := 0;
  if Assigned(grid) and assigned(grid.datasource) then
  with Grid do
  begin
    if Selected.Count <> 0 then
    begin
      FName := Copy(Selected[0], 1, Pos(#9, Selected[0])-1);
      for i := 0 to Pred(datasource.dataset.FieldCount) do
        if datasource.dataset.Fields[i].FieldName = FName then
        begin
          Result := i;
          exit;
        end;
    end
    else
    begin
      for i := 0 to Pred(datasource.dataset.FieldCount) do
        if datasource.dataset.Fields[i].Visible then
        begin
          Result := i;
          exit;
        end;
    end;
  end;
end;

procedure TGridSortHelper.HandleDblClick(Sender: TObject);
var
  pos: TPoint;
  gridpos: TGridCoord;
begin
  pos := Mouse.CursorPos;
  pos := TwwdbGrid(sender).ScreenToClient(pos);
  if PtInRect(TwwDBGrid(sender).ClientRect, pos) then
    gridpos := TwwdbGrid(sender).MouseCoord(pos.x, pos.y)
  else
    gridpos.y := -1;
  if (gridpos.y <> 0) then
    if Assigned(SavedOnDblClick) then
      SavedOnDblClick(Sender);
end;

procedure TGridSortHelper.HandleDrawTitleCell(Sender: TObject;
  Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
var
  TmpRect: TRect;
  GlyphBitmap: TBitmap;
begin

  DefaultDrawing := True;
  if TwwDBGrid(Sender).datasource.dataset.fields.indexof(Field) = SortField then
  begin
    if IsAscending then
      GlyphBitmap := GlyphUp
    else
      GlyphBitmap := GlyphDown;

    TmpRect := Rect;
    TmpRect.Left := TmpRect.Right - (GlyphRect.Right - GlyphRect.Left);
    TmpRect.Top := TmpRect.top +  (
      (tmprect.Bottom - tmprect.Top) -
      (GlyphRect.Bottom - GlyphRect.Top)
    ) div 2;

    tmprect.Top := tmprect.Top + 1;
    tmprect.Left := tmprect.left - 2;

    tmpREct.Right := tmpRect.Left + (GlyphRect.Right - GlyphRect.Left);
    tmpRect.Bottom := Tmprect.Top + (GlyphRect.Bottom - GlyphRect.Top);
    Canvas.BrushCopy(TmpRect, GlyphBitmap, GlyphRect, clWhite);
  end;
end;

procedure TGridSortHelper.HandleKeyPress(Sender: TObject; var Key: Char);
begin
  if (now-LastKeyTime) > (0.65/24.0/60.0/60.0) then
    IncSearchString := '';
  LastKeyTime := now;
  IncSearchString := IncSearchString + Key;
  // Todo: better way to enable incremental sort, currently uses the rowselect
  // option which some apps (themes, promotions) use for all "read only" grids.
  // Problem is that editable grids take keyboard focus so you can't incrementally
  // locate records while the edit is going on.
  if (Grid.DataSource.DataSet.State = dsBrowse) and (dgRowSelect in Grid.Options) then
  begin
    try
      TADOQuery(Grid.Datasource.DataSet).Locate(
        TADOQuery(Grid.Datasource.DataSet).Fields[SortField].FieldName,
        IncSearchString,
        [loCaseInsensitive, loPartialKey]
      );
    except
    end;
  end;
  if Assigned(SavedOnKeyPress) then
    SavedOnKeyPress(Sender, Key);
end;

procedure TGridSortHelper.HandleTitleButtonClick(Sender: TObject;
  AFieldName: string);
var
  i: integer;
begin
  with TwwDBGrid(Sender) do
  begin
    for i := 0 to pred (datasource.dataset.fields.count) do
      if datasource.dataset.fields[i].FieldName = AFieldName then
      begin
        if datasource.dataset.fields[i].FieldKind = fkCalculated then
          exit;
        if SortField <> i then
        begin
          SortField := i;
          IsAscending := True;
        end
        else
          IsAscending := not IsAscending;
        ReopenQuery;
        break;
      end;
  end;
end;

procedure TGridSortHelper.Initialise(Grid: TwwDBGrid);
var
  UserDblClick, GridSortDblClick: TNotifyEvent;
  UserKeyPress, GridSortKeyPress: TKeyPressEvent;
begin
  if Assigned(GlyphUp) then
    GlyphUp.Free;
  if Assigned(GlyphDown) then
    GlyphDown.Free;
  GlyphUp := TBitmap.Create;
  GlyphUp.LoadFromResourceName(HInstance, 'GridGlyphUp');
  GlyphDown := TBitmap.Create;
  GlyphDown.LoadFromResourceName(HInstance, 'GridGlyphDown');

  GlyphRect.Right := GlyphUp.Width;
  GlyphRect.Bottom := GlyphUp.Height;

  UserDblClick := Grid.OnDblClick;
  GridSortDblClick := HandleDblClick;
  UserKeyPress := Grid.OnKeyPress;
  GridSortKeyPress := HandleKeyPress;

  if Assigned(UserDblClick) and (@UserDblClick <> @GridSortDblClick) then
    SavedOnDblClick := UserDblClick;
  if Assigned(UserKeyPress) and (@UserKeyPress <> @GridSortKeyPress) then
    SavedOnKeyPress := UserKeyPress;

  Self.Grid := Grid;
  Grid.OnDblClick := HandleDblClick;
  Grid.OnTitleButtonClick := HandleTitleButtonClick;
  Grid.OnDrawTitleCell := HandleDrawTitleCell;
  Grid.OnKeyPress := HandleKeyPress;
  Grid.TitleButtons := true;
  SortField := -1;
  IsAscending := True;
end;

procedure TGridSortHelper.RebuildQuery;
var
  orderstr: string;
  i: integer;
  SortFieldName: string;
begin
  if Assigned(Grid.Datasource) and (Grid.Datasource.DataSet is TADOQuery) then
  with TADOQuery(Grid.Datasource.DataSet) do
  begin
    if SortField <> -1 then
    begin
      if Fields[SortField].Lookup then
        SortFieldName := Fields[SortField].KeyFields
      else
        SortFieldName := Fields[SortField].FieldName;
      if IsAscending then
        OrderStr := format('order by [%s] ASC', [SortFieldName])
      else
        OrderStr := format('order by [%s] DESC', [SortFieldName]);
    end
    else
      OrderStr := '';

    for i := 0 to pred(SQL.Count) do
    begin
      if Pos('order by', LowerCase(SQL[i])) <> 0 then
      begin
        if Pos('order by', LowerCase(SQL[i])) = 1 then
          SQL[i] := OrderStr
        else
          SQL[i] := Copy(SQL[i], 1, Pred(Pos('order by', LowerCase(SQL[i])))) + OrderStr;
        Exit;
      end;
    end;


    if orderstr <> '' then
      SQL.add(OrderStr);
  end;
end;

procedure TGridSortHelper.Refresh(KeyField: string = '');
begin
  ReopenQuery(KeyField);
end;

procedure TGridSortHelper.ReopenQuery(KeyField: string = '');
var
  OldRecNo: integer;
  ActiveField: string;
  KeyValue: variant;
begin
  if Grid.Datasource.DataSet is TADOQuery then
  with TADOQuery(Grid.Datasource.DataSet) do
  begin
    if State = dsEdit then
      Post;

    if KeyField = '' then
    begin
      OldRecNo := RecNo;
    end
    else
    begin
      OldRecNo := 0;
      KeyValue := FieldByName(KeyField).Value;
    end;
    if Assigned(Grid.SelectedField) then
      ActiveField := Grid.SelectedField.FieldName
    else
      ActiveField := '';
    RebuildQuery;
    Open;
    Grid.SetActiveField(ActiveField);

    if KeyField = '' then
    begin
      RecNo := OldRecNo;
    end
    else
      Locate(KeyField, KeyValue, []);
  end;
end;

procedure TGridSortHelper.Reset;
begin
  if SortField <> GetInitialSortField then
  begin
    SortField := GetInitialSortField;
    ReopenQuery;
  end;
end;

end.
