{------------------------------------------------------------------------------
 Project      : Aztec Standard Pricing
 Module       : Excel selection DB Grid
 Unit Name    : zcXLDBGrid.pas
 Created By   : Peter Wishart Sept 1999

 Description  : Component derived from TwwCustomDBGrid to allow cell selection
                on a standard paradox table. Selection is defined through
                properties XLSelected:boolean and XLSelection:TGridRect

 Use-cases    : WP01-UC-020 Select price matrix prices

 Copyright (c) Zonal Retail Data Systems 1999
-------------------------------------------------------------------------------
 Changes log:
 02/02/2000 PW: Fixed job 12946
 07/02/2000 PW: Added overriden createeditor proc.and customised TwwInplaceEdit
                 for Job 13061 (Removing context menu ops. on Editing cell).
 13/11/2000 NF: Jobs 13717 + 13800
 29/11/2000 PW: Job 13800:
            Modified Paint method to reduce right coord of selection by one
            pixel to avoid vertical scrolling artefacts when selecting e.g 2 by
            2 cells whose right edge is on the centre of the FAR RIGHT of the
            view (inherited paint method did not scroll right hand margin).
            Modified Paint method to undraw XOR selection (used when dragging)
            before Painting, and to redraw if afterwards.
            Removed commented out code.
            Modifed MouseDown, MouseUp and MouseMove handlers to allow
            3 modes of selection - columns, rows or cells. Dragging is now
            supported for selection in all three modes.
            Modified MouseUp handler to use last dragged mouse co-ord if the
            end of a drag is outside the grid client area (previously this
            cleared the selection - was not intuitive).
            Added speeding up of scrolling based on the length of time that the
            user has been dragging the selection for.
            TO DO:
              Rewrite all grid coordinates to be in TABLE coordinates rather
              than grid coords, where the top row's record number gets added to
              the y coords.
              Rewrite the selection code to do an XOR-drawn, dashed, moving
              boundary. This is much easier to see, and is the same as used by
              Excel.
-------------------------------------------------------------------------------}
unit XLDBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, DB, extctrls, stdctrls, math, ClipBrd, ADODB, Variants;

type
  TXLGrid = class;
  TXLGridMode = (xlgmCellSelection, xlgmRowSelection, xlgmColSelection);

  TzcXLSelectRecordEvent =
    procedure(Grid: TXLGrid; Selecting: Boolean;
      var Accept: Boolean) of object;

  {Trick delphi into allowing us access to protected properties}
  TwwCustomDBGridCracked = class(TwwCustomDBGrid);
  {PW Job 13061}
  {Derive a version of TwwInplaceEdit, this is created in the overridden}
  {CreateEditor procedure of TXLGrid. This class exists purely to trap and}
  {ignore WMPaste and WMRButtonDown messages, that would otherwise allow a}
  {poup context menu allowing copy, cut, select all and paste on the}
  {"in place editor" i.e. field view mode of the grid. This menu has been}
  {got rid of to a) provide a consistent copy/paste operation and b) to prevent}
  {invalid data from entering the view.. the paste operation seems to go}
  {directly to the record buffer (without passing go or raising an OnValidate}
  {event) so I could not find a nicer way of intercepting it.}
  {One bug remains: although a WM_PASTE message directed at the inplace editor}
  {does not actually paste information, a change is registered. I think I}
  {spotted where this was done, but will leave this for now - I can't see anyone}
  {losing any sleep about it... ?}
  TzcInplaceEdit = class(TwwInplaceEdit)
  public
    {constructor}
    constructor zcCreate(AOwner:TComponent; Int: Integer);
    {Do-nothing methods to remove message handling}
    procedure WMPaste_Kill(var Message: TMessage); message WM_Paste;
    {This procedure prevents the inplace editor setting focus when}
    procedure WMRButttonDown_Kill(var Message: TMessage); message WM_RButtonDown;
    procedure WMSetFocus(var Message: TMessage); message WM_SetFocus;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;
  {End Job 13061}

  TXLGrid = class(TwwCustomDBGridCracked)
  public
    XLSelected: boolean;
    XLSelection: TGridRect;
    XLSelecting: boolean; // are we dragging a selection at this time?
    XLDragScrolling: boolean; // are we scrolling a dragged selection?
    FOnDrawTitleCell: TwwDrawTitleCellEvent;

    procedure UnselectAll; override;
    procedure SelectAll;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X,Y: Integer); override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure SetSelection(Top,Bottom,Left,Right: integer);
    constructor Create(AOwner: TComponent); override;
  private
    XLLastMouseMove: TGridCoord;
    DragScrollTimer: TTimer;
    FOnMultiSelectRecord: TzcXLSelectRecordEvent; // multi selection event
    XLDragSpeed: integer; // the number of rows etc to move by each time
    XLDragTicks: cardinal;
    FXLSelRect: TRect;    // a TRect defining the selection
    FXLMouseDown: TGridCoord; // mouse down grid coord
    FXLMouseDownTopRow: integer; // top row when mouse down hit
    XLLastScrollDirection: integer; // last direction we scrolled in
    XLDragScrollDirection: integer; // direction we are scrolling in
    {PW:9/11/99 Function GetXLTopRow gets rid of the problem where the scroll bar, only if used}
    {to drag the view, does not update the top row record number used to calculate the position}
    {of the selection rectangle. This is because the top row record number was maintained in a}
    {private var of this component, and updated by the overridden scroll method. The Scroll}
    {"thumb tracking" facility does not use the scroll method.. hence the maintained count got}
    {out of sync. There is a happy ending, though: The GetXLTopRow function calculates the}
    {top row record number by taking the cursor grid row number away from the cursor record number}
    {yielding the top row record number!}
    mode : TXLGridMode;
    function GetXLTopRow: integer; // calculate top row of grid's recno
    Procedure MySetXLSelected(SetValue: Boolean); // set XLselected to true
    procedure DragScrollOnTimer(Sender: TObject); // timer event for dragging
    procedure DragScroll; // method to handle the actual drag
  published
    property DataSource;
    property Options;
    property KeyOptions;
    property FixedCols;
    property FixedRows;
    property TitleLines;
    property TitleImageList;
    property OnMouseDown;
    property OnCalcTitleImage;
    property OnDrawTitleCell: TwwDrawTitleCellEvent read FOnDrawTitleCell write FOnDrawTitleCell;

    property OnZCMultiSelectRecord: TzcXLSelectRecordEvent read
      FOnMultiSelectRecord write FOnMultiSelectRecord;
  protected
    {Return handle to a descendent of TInplaceEdit. Well thought out by}
    {the Infopower people! All non-implementation declared helper objects}
    {should be created this way to make modification possible.}
    function CreateEditor: TInplaceEdit; override;
  end;

  TXLDBGrid = class(TXLGrid)
  protected
    function XIndicatorOffset: integer;
  private
    DrawingCell: Boolean;
    FFixedCols: Integer;
    ClipFmtHandle: integer;
    FCopyFields: TStrings;
    FColumnHeadingsMismatchUserMessage : string;
    procedure setCopyFields(const Value: TStrings);
    function RemoveLineBreaks(const s: string): string;
    function GetBandNameFromColumnName(const columnName: string): string;
  public
    procedure SetColumnAttributes; override;
    procedure SetFixedCols(val: integer);
    function GetFixedCols: integer;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    Function GetActiveRow: integer;
    Function GetActiveCol: integer;
    Function GetActiveField: TField;
    property Canvas;
    procedure XLCopySelection;
    procedure XLPasteToSelection(BandsList: TStrings);
    property ColumnHeadingsMismatchUserMessage : string write FColumnHeadingsMismatchUserMessage;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property KeyOptions;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleLines;
    property TitleFont;
    property TitleAlignment;
    property TitleImageList;
    property Visible;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell; { obsolete }
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    property FixedCols: integer read getFixedCols write setFixedCols;
    property OnCalcCellColors;
    property OnZCMultiSelectRecord;
    property PaintOptions;
    property OnMouseMove;
    property OnCalcTitleImage;
    property CopyFields: TStrings read FCopyFields write setCopyFields;
  end;

procedure Register;

implementation

uses Types;

procedure Register;
begin
  RegisterComponents('Zonal', [TXLDBGrid]);
end;


{***********************************************************************
* TXLGrid                                                          *
***********************************************************************}

constructor TXLGrid.Create(AOwner: TComponent);
begin
  inherited;
  DragScrollTimer := TTimer.create(self);
  DragScrollTimer.interval := 100;
  DragScrollTimer.ontimer := DragScrollOnTimer;
  UnselectAll;
end;

procedure TXLGrid.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {setting the drag speed variables here traps the case where a mousedown}
  {event is proceeded by a mousemove outside the client area. Prevents the}
  {speed being retained from the previous drag in this very rare case.}
  XLDragSpeed := 1;
  XLDragTicks := 0;
  if datasource.dataset.active = false then
    exit;
  UnselectAll;
  paint;
  {PW Job 12946 check for non-fixed columns moved to here}
  {prevents component from picking up selection starting}
  {from a fixed column/row}
  FXLMouseDown := MouseCoord(X, Y);
  {End Job 12946}
// Added by AK for PM360
  if (FXLMouseDown.X < Fixedcols) and (FXLMouseDown.y < Fixedrows) then
// Left Blank intentionally - allows condition through to project code
  else
  begin
  {PW do not start a selection if the topleft-section is clicked}
    FXLMouseDownTopRow := getxltoprow;
    XLSelecting := true;
    {Adjust MouseDown coordinates to respect row/column or cell selection}
    if FXLMouseDown.Y < Fixedrows then
    begin
      mode := xlgmColSelection;
      FXLMouseDown.Y := Fixedrows;
      FXLMouseDownTopRow := 1;
    end
    else
      if FXLMouseDown.X < Fixedcols then
      begin
        mode := xlgmRowSelection;
        FXLMouseDown.X := Fixedcols;
      end
      else
        mode := xlgmCellSelection;
  end;
  try
    inherited;
//    SetCapture(self.handle);
  except;
    UnselectAll;
  end;
end;

procedure TXLGrid.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  FXLMouseUp: TGridCoord;
  procedure exchange(var a, b: integer);
  var
    tmp: Integer;
  begin
    tmp := a;
    a := b;
    b := tmp;
  end;
begin
  if datasource.dataset.active = false then
    exit;

  {PW Job 12946 if not doing a valid selection do not attempt to define one}
  if (XLSelecting = false) then
    exit;
  XLSelecting := false;
  FXLMouseUp := MouseCoord(X, Y);
  ReleaseCapture;
  if (FXLMouseUp.X = -1) and
    (FXLMouseUp.Y = -1) then
  begin
    FXLMouseUp := XLLastMouseMove;
  end;
  {convert grid coordinates to database coordinates of selection}
  if mode = xlgmColSelection then FXLMouseUp.Y := datasource.dataset.recordcount
  else
  if mode = xlgmRowSelection then FXLMouseUp.X := pred(ColCount)
  else
  begin
    {Clip grid coordinates to be valid cell selections}
    {The Y coordinate is still in range 0..pred(Rowcount)}
    FXLMouseUp.X := max(FXLMouseUp.X, leftcol);
    FXLMouseUp.Y := max(FXLMouseUp.Y, FixedRows);
  end;
  if (FXLMouseUp.X = FXLMouseDown.X) and
    (FXLMouseUp.Y = FXLMouseDown.Y) then
  begin
    // single cell selected
    UnselectAll;
    
    inherited;
  end else
  begin
{    if (FXLMouseUp.X = -1) and
      (FXLMouseUp.Y = -1) then
    begin
      FXLMouseUp := XLLastMouseMove;
    end;}
    {the user has made a valid drag over the grid}
    XLSelection.left := (FXLMouseDown.X);
    XLSelection.right := (FXLMouseUp.X);
    XLSelection.top := FXLMouseDown.Y + FXLMouseDownTopRow - FixedRows;
    XLSelection.bottom := (FXLMouseUp.Y + (getxltoprow - FixedRows));
    { if moving from right to left and left is less than FixedCols }
    { ensure that selection is clipped to valid cells }
    if XLSelection.left > XLSelection.Right then
    begin
      exchange(XLSelection.left, XLSelection.right);
      if (XLSelection.Left < FixedCols) then
        XLSelection.Left := FixedCols;
    end;
    if XLSelection.top > XLSelection.bottom then
      exchange(XLSelection.top, XLSelection.bottom);
    MySetXLSelected(true);
    Editormode := false;
  end;
  XLLastScrollDirection := 0;
  invalidate;

  if not XLSelected then
    ShowEditor;
end;

procedure TXLGrid.MouseMove(Shift: TShiftState; X,Y: Integer);
var
  XLNewMouseMove: TGridCoord;
  DragCellBound : TRect;
  MPt: TPoint;
  i, IndicatorOffset: integer;
begin
  if dgIndicator in Options then
    IndicatorOffset := 1
  else
    IndicatorOffset := 0;

  if not datasource.dataset.active then
    exit;

  if XLSelecting then
  begin
    XLNewMouseMove := MouseCoord(X, Y);

    Mpt.X := X;
    Mpt.Y := Y;

    Mpt := ClientToScreen(Mpt);

    // Find coordinate of left hand side of the grid, and offset by the
    // fixed columns width.
    DragCellBound.Left := BoundsRect.Left;

    for i := 0 to pred(FixedCols) do
      DragCellBound.Left := DragCellBound.Left + succ(ColWidthsPixels[i]);

    // Find coordinate of top of the grid, and offset by the
    // top columns row height.
    DragCellBound.Top := BoundsRect.Top + succ(RowHeights[0]);

    // Right hand side of the grid is the Left hand side offset by the width
    // of the visible columns.
    DragCellBound.Right := DragCellBound.Left;

    for i := LeftCol to (LeftCol + pred(VisibleColCount)) do
      DragCellBound.Right := DragCellBound.Right + succ(ColWidthsPixels[i]);

    // Bottom of grid is the top offset by the height of the visible rows.
    DragCellBound.Bottom := DragCellBound.Top + (Succ(RowHeights[1]) * VisibleRowCount);

    // Convert to screen coordinates.
    DragCellBound.TopLeft := Parent.ClientToScreen(DragCellBound.TopLeft);
    DragCellBound.BottomRight := Parent.ClientToScreen(DragCellBound.BottomRight);

    // Check if mouse has left client area.
    if not PtInRect(DragCellBound, MPt) then
    begin
      if (MPt.Y < DragCellBound.Top) then
      begin
        XLDragScrollDirection := 1; // Up
        Y := ScreenToClient(DragCellBound.TopLeft).Y;
      end;

      if (MPt.X > DragCellBound.Right) then
      begin
        XLDragScrollDirection := 2; // Right
        X := ScreenToClient(DragCellBound.BottomRight).X;
      end;

      if (MPt.Y > DragCellBound.Bottom) then
      begin
        XLDragScrollDirection := 3; // Down
        Y := ScreenToClient(DragCellBound.BottomRight).Y;
      end;

      if (MPt.X < DragCellBound.Left) then
      begin
        XLDragScrollDirection := 4; // Left
        X := ScreenToClient(DragCellBound.TopLeft).X;
      end;

      XLNewMouseMove := MouseCoord(X,Y);

      XLDragScrolling := True;
      DragScrollTimer.Enabled := True;
    end
    else
    begin
      XLDragSpeed := 1;
      XLDragTicks := 0;

      XLDragScrolling := False;
    end;

    if Mode = xlgmColSelection then
      XLNewMouseMove.Y := DataSource.DataSet.RecordCount;

    if Mode = xlgmRowSelection then
      XLNewMouseMove.X := (ColCount - pred(FixedCols)) + IndicatorOffset;

    if (XLNewMouseMove.X <> XLLastMouseMove.X) or
       (XLNewMouseMove.Y <> XLLastMouseMove.Y) then
      XLLastMouseMove := XLNewMouseMove;
  end;

  inherited;
end;

procedure TXLGrid.UnselectAll;
begin
  MySetXLSelected(False);
end;

procedure TXLGrid.SelectAll;
begin
  XLSelection.left := fixedcols;
  XLSelection.right := pred(ColCount);
  XLSelection.top := 1;
  XLSelection.bottom := datasource.dataset.recordcount;
  MySetXLSelected(true);
  Invalidate;
end;

procedure TXLGrid.Paint;
var
  TmpSelTop, indoffset: Integer;
begin
  {PW: 28/11/00}
  {The Paint method seems to be used for updating the new parts of the grid
  created by scrolling of the grid to the left or right}
  {This causes horizontal artefacts as any XOR-drawn selection may be over-
  written by the new cells being painted}
  {So, remove XOR-selection before painting, and put it back again later!}
  
  inherited;
  // If a selection has been defined
  if XLSelected then
  begin
    if datasource.dataset.active = false then
      exit;
    // paint our selection
    if not (
      (XLSelection.Bottom < getxltoprow) or
      (XLSelection.Top > getxltoprow + VisibleRowCount)) then
    begin
      with canvas do
      begin
        // calulate selection top - fixed rows are not drawn upon
        TmpSelTop := XLSelection.Top - (getxltoprow - FixedRows);
        if tmpseltop < fixedrows then
          tmpseltop := fixedrows;

        FXLSelRect := BoxRect(
          XLSelection.Left,
          TmpSelTop,
          XLSelection.Right,
          XLSelection.Bottom - (getxltoprow - FixedRows));
        Brush.color := clSilver;
        {if rightmost cell is partially visible, move it off screen}
        if XLSelection.Right >= (LeftCol+VisibleColCount) then
          inc(FXLSelRect.Right);
        FillRect(FXLSelrect);
        // Job 13717
        Brush.Color := clBlack;
        Inflaterect(FXLSelRect, 1, 1);
        if dgIndicator in Options then
          indoffset := 1
        else
          indoffset := 0;
        if (XLSelection.Right = ColCount - (fixedcols - indoffset)) and
          ((LeftCol+VisibleColCount) = ColCount )then
          dec(FXLSelrect.right);
        if (XLSelection.Bottom - pred(getxltoprow)) = (Rowcount-FixedRows) then
          dec(FXLSelrect.bottom);
        FillRect(FXLSelrect);
      end;
    end;
  end;
end;

procedure TXLGrid.MySetXLSelected(SetValue: Boolean);
var
  Accept: boolean;
begin
  Accept := true;
  if Assigned(FOnMultiSelectRecord) then
    FOnMultiSelectRecord(Self,SetValue,Accept);
  XLSelected := SetValue;
end;

function TXLGrid.GetXLTopRow: integer;
begin
  // calculate record number of the top row in the Grid.
  result := datasource.dataset.recno - pred(row);
end;

procedure TXLGrid.DragScrollOnTimer(Sender: TObject);
  function setspeed(ticks: integer): integer;
  begin
    result := 1 + min(trunc(sqrt(ticks *12)), 100);
  end;
begin
  inc(XLDragTicks);
  if XLSelecting then
  begin
    XLDragSpeed := setspeed(XLDragTicks);
    if XLDragScrolling then
      DragScroll;
  end
  else
    // safety check - just in case
    TTimer(Sender).Enabled := false;
end;

procedure TXLGrid.DragScroll;
var
  DirString: String;
  Key: Word;
  MoveToEnd: Boolean;
  i: Integer;
{Handles mouse events outside the screen...}
begin
  for i := 1 to XLDragSpeed do
    case XLDragScrollDirection of
      1:
        begin
          movetoend := (row <> fixedrows);
          DirString := 'Up';
          Key := VK_Up;
          if MoveToEnd then
            datasource.dataset.moveby(1-row)
          else
            KeyDown(Key,[]);
        end;
      2:
        begin
          movetoend := ((col-Leftcol) <> visiblecolcount);
          DirString := 'Right';
          if MoveToEnd then
            col := LeftCol+pred(VisibleColCount);
          Key := VK_Right;
          KeyDown(Key,[]);
        end;
      3:
        begin
          movetoend := (row <> visiblerowcount);
          DirString := 'Down';
          Key := VK_Down;
          if MoveToEnd then
            datasource.dataset.moveby(visiblerowcount-row)
          else
            KeyDown(Key,[]);
        end;
      4:
        begin
          movetoend := (col <> LeftCol);
          DirString := 'Left';
          if MoveToEnd then
            col := LeftCol;
          Key := VK_Left;
          KeyDown(key,[]);
        end;
    end;
end;

Procedure TXLGrid.SetSelection(Top,Bottom,Left,Right:integer);
begin
  XLSelection.top := top;
  XLSelection.bottom := bottom;
  XLSelection.left := left;
  XLSelection.right := right;
  XLSelecting := false;
  XLSelected := true;
  EditorMode := false;
end;

function TXLGrid.CreateEditor: TInplaceEdit;
begin
  result := TzcInplaceEdit.zccreate(self,0);
end;

{***********************************************************************
* TXLDBGrid                                                          *
***********************************************************************}

procedure TXLDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  indicatoroffset: integer;
begin
  if dgIndicator in Options then
    indicatoroffset := 1
  else
    indicatoroffset := 0;
  if drawingCell then exit; { Avoid recursion }
  drawingCell := True;

  if XLSelected then
  begin
    if (ARow >= XLSelection.Top - GetXLTopRow + 1) and
      (ARow <= XLSelection.Bottom - GetXLTopRow + 1) and
      (ACol >= XLSelection.Left) and (ACol <= XLSelection.Right) then
      AState := AState + [gdSelected]
    else
      AState := AState - [gdSelected];
  end;

  inherited DrawCell(ACol, ARow, ARect, AState);

  { Make cells 3D style }
   if DefaultDrawing and ((ACol < (FixedCols+indicatoroffset))
     or (ARow < FixedRows)) then
     Draw3DLines(ARect, ACol, ARow, AState);

  drawingCell := False;
end;

procedure TXLDBGrid.SetFixedCols(val: integer);
begin
  if (csDesigning in ComponentState) then begin
    if ((dataSource <> nil) and (dataSource.dataSet <> nil) and
      (dataSource.dataSet.active) and (val + xIndicatorOffset > ColCount)) or
      (val < 0) then
    begin
      MessageDlg('Invalid value for FixedCols', mtWarning, [mbok], 0);
      exit;
    end
  end;

  FFixedCols := val;
  LayoutChanged;
end;

function TXLDBGrid.GetFixedCols: integer;
begin
  result := FFixedCols;
end;

procedure TXLDBGrid.SetColumnAttributes;
var i: integer;
begin
  { Update fixed columns if changed }
  if (inherited FixedCols <> FFixedCols + xIndicatorOffset) and
    (datasource <> nil) and (datasource.dataset <> nil) and
    (datasource.dataset.active) then
  begin
    if (FFixedCols + xIndicatorOffset < ColCount) and (FFixedCols >= 0) then
    begin
      inherited FixedCols := FFixedCols + xIndicatorOffset;
      for i := 0 to FFixedCols + xIndicatorOffset do TabStops[i] := False;
    end
  end;

  inherited setColumnAttributes;

end;

function TXLDBGrid.XIndicatorOffset: integer;
begin
  if dgIndicator in Options then result := 1
  else result := 0;
end;

Function TXLDBGrid.GetActiveRow: integer;
begin
  result := dbrow(row);
end;

Function TXLDBGrid.GetActiveCol: integer;
begin
   result:= col;
end;

Function TXLDBGrid.GetActiveField: TField;
begin
   result:= GetColField(dbCol(Col));
end;

procedure TXLDBGrid.XLCopySelection;
var
  StartRecNo: integer;
  lpstTemp: PCHAR;
  stTemp: string;
  slCopy: TStringList;
  i, j: integer;
  tmpHandle: tHandle;

  // gets as a string the Nth line of a multi-line string
  // where N is 1-based.
  function GetLine(aString: string; LineIndex: integer): string;
  begin
    with TStringlist.Create do
    begin
      Text := aString;

      if pred(LineIndex) < Count then
        Result := strings[pred(LineIndex)];

      Free;
    end;
  end;
begin
  // copy selection into clipboard

  // first register our custom clip format
  // this does not get any data stored against it, but
  // it used as a token to differentiate Zonal clipboard formats
  if ClipFmtHandle = 0 then
  begin
    stTemp := 'ZonalPriceMatrixPasteFmt';
    lpstTemp := @stTemp;
    ClipFmtHandle := RegisterClipboardFormat(lpstTemp);
  end;

  if not XLSelected then
    SetSelection(DataSource.DataSet.RecNo, DataSource.DataSet.RecNo,
      GetActiveCol, GetActiveCol);

  // now build up stringlist for insertion
  slCopy := TStringList.Create;
  try
    // build up header line
    // consists of Band and Band Desc.
    // add a tab to align row headers (product name header is not exported);
    stTemp := '';

    for j := 0 to FCopyFields.Count - 1 do
      stTemp := stTemp + #9;

    for j := XLSelection.Left to XLSelection.Right do
    begin
      stTemp := stTemp + RemoveLineBreaks(fields[j - XIndicatorOffset].DisplayName);

      if j <> XLSelection.Right then
        stTemp := stTemp + #9;  // add tab separator
    end;

    // add the header line
    slCopy.add(stTemp);

    // convert the actual data to text in slCopy
    DataSource.DataSet.DisableControls;
    StartRecNo := DataSource.DataSet.RecNo;
    DataSource.DataSet.RecNo := XLSelection.Top;

    for i := XLSelection.Top to XLSelection.Bottom do
    begin
      stTemp := '';

      {Add product name}
      for j := 0 to FCopyFields.Count - 1 do
        stTemp := stTemp + DataSource.DataSet.FieldByName(FCopyFields.Strings[j]).asString + #9;

      for j := XLSelection.Left to XLSelection.Right do
      begin
        stTemp := stTemp + Fields[j - XIndicatorOffset].AsString;
        if j <> XLSelection.Right then
          stTemp := stTemp + #9;  // add tab separator
      end;

      slCopy.add(stTemp);

      DataSource.DataSet.Next;
    end;

    DataSource.DataSet.RecNo := StartRecNo;
    DataSource.DataSet.EnableControls;

    // do the copy
    with Clipboard do
    begin
      Open;
      try
        Clear;
        // set text in clipboard
        AsText := slCopy.text;
        // alloc the token
        tmpHandle := GlobalAlloc(GMEM_MOVEABLE and GMEM_DDESHARE, 4);
        if tmpHandle = 0 then
        begin
          raise Exception.Create(
            'Could not allocate clipboard information');
        end;
        // put in zonal clipboard format token
        SetAsHandle(word(ClipFmtHandle), tmpHandle);
      finally
        Close;
      end;
    end;
  finally
    slCopy.free;
  end;
end;

function TXLDBGrid.RemoveLineBreaks(const s: string): string;
begin
  Result := StringReplace(s, #$D#$A, ' ', [rfReplaceAll])
end;

// Return the band name from a string formatted:
//    char*(band name)char*
// For example:
//    Country Pub(GG)
// In this example the result will be GG.
// The band name and the right hand set of characters (if any) must not contain brackets.
//
// If the given string does not have the above format the string is returned as is.
function TXLDBGrid.GetBandNameFromColumnName(const columnName: string): string;
var
 foundRightBracket: boolean;
 i : integer;
begin
  foundRightBracket := false;
  Result := '';
  for i := Length(columnName) downto 1 do
  begin
    if columnName[i] = '(' then
      break;

    if foundRightBracket then
      Result := columnName[i] + Result
    else
      foundRightBracket := (columnName[i] = ')');
  end;

  if not(foundRightBracket) then
    Result := columnName;

  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

procedure TXLDBGrid.XLPasteToSelection(BandsList: TStrings);
{
  Paste the clipboard contents into the view.
  Subprocedures:
    PastedBandsAreDifferent : Checks the bands in the header of the clipboard
      against the currently selected bands. Returns true if they are different.
    MakeClipTable : Creates a temp. table from the clipboard contents.

  If the cliboard was generated internally (i.e. we are not pasting from excel
  etc.) then the pasted table is wrapppped or cropped into the selection using
  a record loop with MODs to pick the right cells in the paste table.
  Otherwise, the paste table is batchmoved into the matrix edit view directly.

  PW: 11/11/99 now that we use cached updates, the batchmove has been taken out!
  It has been replaced with a record loop as per the other operations. This is
  normally a really crap way to do things, but it saves more problems than it
  creates - because cached updates are enabled (Batchmoves dont work on a cached
  updates table).
}

var
  StartRecNo: integer;
  stTemp: string;
  lpstTemp: pchar;
  Internal: boolean;
  slPaste: TStringList;
  slPastedBands: TStringList;
  slTemp: TStringlist;
  i, j, pastefield: Integer;
  ok, converror: boolean;
  tmpTable: TADOTable;

  function convexcelfloat(input: string): double;
  var
    number: string;
    i: integer;
  begin
    number := '';
    for i := 1 to length(input) do
      if not (input[i] in [',', '£', '$']) then number := number + input [i];
    result := strtofloat(number);
  end;

  function StrToCurrSafe(Value: string): Currency;
  begin
    if Value = '' then
      Result := 0
    else
      Result := StrToCurr(Value);
  end;

  function RangeCheck(Value: Currency): Currency;
  const LIMIT: Currency = 99999.99;
  begin
    Result := Value;
    if (Value * Sign(Value)) > LIMIT then
      Result := Sign(Value) * LIMIT;
  end;

  // Checks whether the selected bands match the pasted ones
  function PastedBandsAreDifferent(slpasted, slselected: tstrings): boolean;
  var
    i, j: integer;
  begin
    with slPasted do
    begin
      result := false;
      for i := 0 to pred(count) do
      begin
        try
          j := 0;
          while (j < slSelected.count) and (slSelected[j] <> slPasted[i]) do
          begin
            inc(j);
          end;
          if (j >= slSelected.count) then
            result := result or true;
        except
          result := result or true;
        end;
      end;
    end;
  end;

  procedure MakeClipTable(Internal : boolean);
  var
    i, j: integer;
    firstline, stName: string;
    stClipLine: string;
    iClipLineIdx: integer;
    AQuery: TADOQuery;
    ATable: TADOTable;
    NextToken : String;

    // Get the next tab-separated item from stClipLine
    // how far along the clip line we are is stored in iClipLineIdx
    function GetNextToken: string;
    var
      stToken: string;
      done: boolean;
    begin
      stToken := '';
      done := false;
      while not (done) and (iClipLineIdx <= length(stClipLine)) do
      begin
        if (stClipLine[iClipLineIdx] = #9) or
          (iClipLineIdx > length(stClipLine)) then
        begin
          result := stToken;
          done := true;
        end
        else
        begin
          stToken := sttoken + stClipLine[iClipLineIdx];
        end;
        inc(iClipLineIdx);
      end;
      if (iClipLineIdx > length(stClipLine)) then
        result := stToken;
    end;

  begin
    // get all band names from after first tab
    firstline := copy(slPaste.Strings[0], pos(#9, slPaste.Strings[0]),
      length(slPaste.Strings[0]));
    stName := '';

    // scan from after first tab
    for i := (FCopyFields.Count + 1 + pos(firstline, #9)) to length(firstline) do
    begin
      if (firstline[i] = #9) then
      begin
        slPastedBands.Add(GetBandNameFromColumnName(stName));
        stName := '';
      end
      else
        stName := stName + firstline[i];
    end;

    // add the last band
    slPastedBands.Add(GetBandNameFromColumnName(stName));

    AQuery := TADOQuery.Create(nil);

    try
      AQuery.Connection := TADODataSet(DataSource.DataSet).Connection;
      AQuery.SQL.Clear;
      AQuery.SQL.Add('IF OBJECT_ID(''tempdb..#CopyTable'') IS NOT NULL');
      AQuery.SQL.Add('drop table #CopyTable');

      try
        AQuery.ExecSQL;
      except
      end;

      AQuery.Close;

      AQuery.SQL.Clear;
      AQuery.SQL.Add('CREATE TABLE #CopyTable(');
      AQuery.SQL.Add('  IndexNo INT,');
      AQuery.SQL.Add('  ProductID FLOAT,');
      AQuery.SQL.Add('  ProductName VARCHAR(16),');
      AQuery.SQL.Add('  PortionName VARCHAR(16)');
      AQuery.SQL.Add(')');

      if slPastedBands.count > 0 then
      begin
        for i := 0 to pred(slPastedBands.count) do
        begin
          //create each band field
          stTemp := ', [' + slPastedBands.strings[i] + '] money';
          AQuery.SQL.Insert(AQuery.Sql.Count - 1, stTemp);
        end;
      end;

      if not Internal then
        AQuery.SQL.insert(AQuery.Sql.Count - 1, ', PRIMARY KEY (ProductID, PortionName)')
      else
        AQuery.SQL.Insert(AQuery.Sql.Count - 1, ', PRIMARY KEY (IndexNo)');
      AQuery.ExecSql;
    finally
      AQuery.Free;
    end;

    ATable := TADOTable.Create(nil);

    try
      ATable.Connection := TADODataSet(DataSource.DataSet).Connection;
      ATable.TableName := '#CopyTable';

      ATable.Open;
      for i := 1 to pred(slPaste.Count) do
      begin
        iClipLineIdx := 1;
        stClipLine := slPaste[i];

        try
          ATable.Append;
          ATable.Fields[0].AsInteger := i;
          ATable.Fields[1].AsFloat := ConvExcelFloat(GetNextToken);
          ATable.Fields[2].AsString := GetNextToken;
          GetNextToken;
          ATable.Fields[3].AsString := GetNextToken;

          for j := 0 to pred(ATable.FieldCount - 3) do
          begin
            try
              NextToken := GetNextToken;
              if NextToken = '' then
                ATable.Fields[j + 4].Clear //Set field to Null.
              else
                ATable.Fields[j + 4].AsCurrency := RangeCheck(StrToCurr(NextToken));
            except
              ConvError := True;
            end;
          end;

          ATable.Post;
        except;
          ConvError := True;
        end;
      end;
      ATable.Close;
    finally
      ATable.Free;
    end;
  end;
begin
  ConvError := False;
  Internal := False;

  if ClipFmtHandle = 0 then
  begin
    stTemp := 'ZonalPriceMatrixPasteFmt';
    lpstTemp := @stTemp;
    ClipFmtHandle := RegisterClipboardFormat(lpstTemp);
  end;

  slPaste := TStringList.Create;
  slPastedBands := TStringList.Create;
  slTemp := TStringList.Create;

  try
    try
      Internal := IsClipBoardFormatAvailable(ClipFmtHandle);

      Clipboard.Open;

      try
        slPaste.Text := Clipboard.asText;
      finally
        Clipboard.Close;
      end;

      if slPaste.Count < 2 then
      begin
        ShowMessage('Nothing in clipboard to paste!');
        Exit;
      end;

      try
        MakeClipTable(Internal);
      except
        begin
          Showmessage('Paste failed!');
          Exit;
        end;
      end;

      tmpTable := TADOTable.Create(nil);

      try
        tmpTable.Connection := TADODataSet(DataSource.DataSet).Connection;
        tmpTable.TableName := '#CopyTable';
        tmpTable.Open;

        if Internal then
        begin
          tmpTable.Sort := 'IndexNo ASC';
          if not XLSelected then
          begin
            SetSelection(DataSource.DataSet.recno, DataSource.DataSet.recno + pred(tmpTable.recordcount),
              GetActiveCol, min(GetActiveCol +
              pred(tmpTable.Fieldcount - 4), self.fieldcount));
          end;

          // internal format - do a wrapped paste if selection areas are different
          // Does the paste area match exactly?
          OK := (slPastedbands.count) =
            1 + (XLSelection.Right - XLSelection.Left);

          OK := OK and ((tmpTable.recordcount - 1) = (XLSelection.Bottom - XLSelection.Top));
          if not OK then
          begin
            // they are not the same size
            if messagedlg('Warning:' + #13 +
              'The target area and clipboard contents are of different sizes,' + #13 +
              'this will cause pasted prices to be wrapped or cropped within' + #13 +
              'the target area.' + #13 +
              'Do you wish to continue?',
              mtConfirmation, [mbYes, mbNo], 0) = mrNo then
              exit;
          end;
          //
          // do wrapped paste - implemented as a record loop
          //

          // loop over rows in selection
          DataSource.DataSet.DisableControls;

          StartRecNo := DataSource.DataSet.RecNo;
          DataSource.DataSet.recno := XLSelection.Top;
          for i := 0 to (XLSelection.Bottom - XLSelection.top) do
          begin
            // synchronize records
            if tmpTable.recordcount <> 1 then
            begin
              //check for div by zero
              if (i mod (tmpTable.RecordCount)) = 0 then
                tmpTable.first
              else
                tmpTable.next;
            end;

            DataSource.DataSet.edit;

            for j := XLSelection.Left - XIndicatorOffset to XLSelection.Right - XIndicatorOffset do
            begin
              if j > pred(FieldCount) then
                Continue;

              pastefield := 4 + ((j - (XLSelection.left - XIndicatorOffset)) mod (tmpTable.Fields.Count - 4));
              fields[j].Value := tmpTable.Fields[pastefield].Value;
            end;
            DataSource.DataSet.post;
            DataSource.DataSet.next;
          end;
          DataSource.DataSet.RecNo := StartRecNo;
          tmpTable.Close;

          DataSource.DataSet.EnableControls;
        end
        else
        begin
          if PastedBandsAreDifferent(slPastedBands, BandsList) or converror then
          begin
            if messagedlg('Warning:' + #13 +
              FColumnHeadingsMismatchUserMessage + #13 +
              'Do you wish to continue?',
              mtConfirmation, [mbYes, mbNo], 0) = mrNo then
              Exit;
          end;

          // update entity codes with name-matched versions
          DataSource.DataSet.DisableControls;
          StartRecNo := DataSource.DataSet.RecNo;

          // Match names to get entities
          tmpTable.First;

          // Loop over queried paste data
          while not tmpTable.EOF do
          begin
            // Locate product in matrix table
            DataSource.DataSet.Locate('ProductID;PortionTypeName',
              VarArrayOf([tmpTable.FieldByName('ProductID').AsFloat, tmpTable.FieldByName('PortionName').AsString]),
              []);
            DataSource.DataSet.Edit;

            //loop over fields to fill them in
            for i := 4 to pred(tmpTable.Fields.Count) do
            begin
              DataSource.DataSet.FieldByName(tmpTable.Fields[i].FieldName).Value := tmpTable.Fields[i].Value;
            end;

            DataSource.DataSet.Post;
            tmpTable.Next;
          end;

          tmpTable.Close;

          DataSource.DataSet.RecNo := StartRecNo;
          DataSource.DataSet.EnableControls;
        end;
      finally
        tmpTable.Free;
      end;
    finally
      if not (internal) then
      begin
      end;
    end;
  finally
    if DataSource.DataSet.ControlsDisabled then
      DataSource.DataSet.EnableControls;
      
    slPaste.free; 
    slPastedBands.free;
    slTemp.free;
  end;
end;

Constructor TzcInplaceEdit.zcCreate(AOwner: TComponent; Int:Integer);
begin
  wwCreate(Aowner,int);
end;

{PW Job 13061}
procedure TzcInplaceEdit.WMPaste_Kill(var Message: TMessage);
begin
  //
end;

procedure TzcInplaceEdit.WMRButttonDown_Kill(var Message: TMessage);
begin
  //
end;
{End Job 13061}

procedure TzcInplaceEdit.WMSetFocus(var Message: TMessage);
begin
  if TXLDBGrid(Owner).XLSelecting then exit;
  inherited;
end;

constructor TXLDBGrid.Create(AOwner: TComponent);
begin
  inherited;

  FCopyFields := TStringList.Create;
  FColumnHeadingsMismatchUserMessage := 'The Clipboard contains price bands which have not been Loaded.';
end;

destructor TXLDBGrid.Destroy;
begin
  FCopyFields.Free;

  inherited;
end;

procedure TXLDBGrid.setCopyFields(const Value: TStrings);
begin
  FCopyFields.Text := Value.Text;
end;

procedure TXLGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_TAB] then
  begin
    // Using a Cursor Key or Tab Key to navigate to a cell is effectively the same as
    // Mouse Down in a single cell.  When a Mouse Down event in a single cell occurs
    // the XLSelected value is set to FALSE so the same should be down for cursor/tab
    // key down events.  This ensures that the cell receiving the cursor/tab key down
    // event will be selected and will be updated by CTRL-V.  Without this the previously
    // selected cell(s) will be updated by CTRL-V.
    MySetXLSelected(FALSE);
    ShowEditor;
  end;
end;

procedure TzcInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_RETURN] then
  begin
    TXLDBGrid(Owner).SetFocus;

    if Key = VK_RETURN then
      Key := VK_DOWN;

    TXLDBGrid(Owner).KeyDown(Key, Shift);

    Key := 0;
  end;

  inherited;
end;

end.

