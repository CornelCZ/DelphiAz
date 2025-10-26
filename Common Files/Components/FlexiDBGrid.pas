unit FlexiDBGrid;

(*
 * Unit contains the TFlexiDBGrid class - a replacement for the TDBGrid class
 * which provides various additional functionality and fixes certain bugs over
 * the standard DBGrid component.  Note that this component is almost certainly
 * inferior to commercial DBGrid replacements and so it might be advisable
 * to replace it with a commercial grid in future.
 *
 * For a more detailed explanation of the capabilities of TFlexiDBGrid, see the
 * comments above the class definition below.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)

 interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Grids, DBGrids, DB, StrUtils, Dialogs;

type
  // Additional options for a FlexDBGrid
  TFlexiDBGridOption = (
    // Allow user to delete a row by typing Ctrl+Delete
    fdboAllowDelete,
    // Allow user to insert a row by typing Ctrl+Insert
    fdboAllowInsert,
    // If a column is read-only, display the editor (this is the default behaviour for a TDBGrid),
    // If this option is false, then the selection is shown as a highlighted square, rather than
    // using the editor (in fact this is achieved by altering the appearance of the editor to
    // make it look like the selected square).
    fdboShowEditorInROColumn,
    // If this option is set, then moving between grid squares by pressing the left or right keys
    // will skip over read-only columns.
    fdboCursorNaviagtionSkipsROColumn,
    // If this option is set, then columns with a drop down pick list will behave like a combo
    // box with the auto complete feature.
    fdboAutoCompleteCombos,
    // If this option is set, the vertical scroll bar is hidden:  Note that in the current
    // implementation, the scroll bar still flickers into and out of view when scrolling the grid.
    fdboHideVerticalScrollBar,
    // Normal grid allows user to tab out of control, fixing broken behaviour of a normal grid.
    // You can disable this fix
    fdboDontFixTableTabs,
    // Normal grid allows tabbing through multiple rows.  This option makes tabbing only go through
    // a single row.
    fdboSingleRowTableTabs
  );

  TFlexiDBGridOptions = set of TFlexiDBGridOption;

  // Options to control how inplace editing is performed:
  TInplaceEditOption = (
    // When editing a 'float' field, the default text in the edit box has the % character in in.
    // When validating text in the box, % symbols are ignored.
    ieoEditFloatAsPercentage,
    // When editing a 'float' fields, the user may type a fraction, e.g. 1/3, which is evaluated
    // correctly.
    ieoEditFloatAsFraction );

  TInplaceEditOptions = set of TInplaceEditOption;

  // An event invoked when the inplace editor is about to be displayed.  This gives the user of
  // the grid an opportunity to manipulate the TInplaceEditOptions for the current cell.
  TSetupInplaceEditEvent = procedure( Sender: TComponent;
                                      Editor: TInplaceEdit;
                                      Column: TColumn;
                                      var EditOptions: TInplaceEditOptions ) of object;

  // TStepPastEndEvent is an event invoked because the user steps past the end of the table.
  // If reason is sperKeyPress, the event was invoked because the user presses down when the
  // current row is the last row in the table.
  // If reason is sperMouseClick, the event was invoked because the user clicked just beyond
  // the last row of the table.
  TFlexiStepPastEndReasonOption = (sperKeyPress, sperMouseClick);
  TStepPastEndEvent = procedure( Sender: TComponent;
                                 reason: TFlexiStepPastEndReasonOption ) of object;

  // TFlexiDBGrid - extension of TDBGrid.  The grid can do the following:
  //
  // - turn off ability to insert & delete rows using Ctl+Insert & Ctl+Delete.
  // - skip over read-only columns when navigating table with the keyboard.
  // - display read-only cells as if there is no editor.
  // - drop down combobox in table can be made to behave like an auto-completing combo box.
  // - hide the vertical scroll bar (this functionality is not done well).
  // - invoke an event if user attempts to navigate past the end of the table.
  // - display a column as if it is a checkbox, and invoke event when it is clicked.
  // - allow inplace editor to permit editing of float fields as if the are percentages.
  // - allow typing of fractions (e.g. '1/2') in the inplace editor.
  //
  // It also circumvents the following bugs in TDBGrid:
  // - scroll wheel handling is broken.
  // - Setting SelectedField does not display the inplace editor event if
  //   dgAlwaysShowEditor option is set.
  //
  // Note that some of the functionality in the grid is implemented by using a custom
  // inplace editor in the grid - see TFlexiInplaceEditor later in this file.
  //
  TFlexiDBGrid = class(TDBGrid)
  private
    // The column which is to be displayed as if it is a checkbox (nil if no column is to be
    // displayed as a checkbox).
    boolField: TField;
    // If boolField has a value of boolCheckedVal, then it will be rendered as a checked checkbox,
    // otherwise it is rendered as an unchecked checkbox.
    boolCheckedVal: Variant;

    // Event handlers
    FOnSetupInplaceEdit: TSetupInplaceEditEvent;
    FOnStepPastEndEvent: TStepPastEndEvent;
    FOnToggleBooleanField: TNotifyEvent;
    // Extended options.
    FFlexiOptions: TFlexiDBGridOptions;
    // Editing options for the current cell.
    cellEditOptions: TInplaceEditOptions;

    // Shift state - stored for interested togglebooleanfield caller
    storedShiftState: TShiftState;

    // Returns true if the inplace editor should be displayed in the specified column when the
    // column is selected, or false, if the column should be shown as a selected cell.
    // colIndex - index into Columns property
    function WantToShowEditorInColumn(colIndex: Integer): boolean;
    // Should the specified DataColumn be rendered as a checkbox?
    // colIndex - index into Columns property
    function IsCheckboxColumn( colIndex: Integer ): boolean;
    // Should the user be allowed to navigate to the specified column using the left & right keys?
    function CanMoveToColumn( colIndex: Integer ): boolean;
    // Return the field corresponding to the currently selected column.
    function GetSelectedField: TField;
    // Find the column corresponding to field, and make it the currently selected column.
    procedure SetSelectedField( field: TField );

  protected
    // Called when inplace edit is complete
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    // Called to get the text to display in the inplace editor.
    function GetEditText(ACol, ARow: Longint): string; override;
    // Called to determine if a particular character may be entered in the inplace editor.
    function CanEditAcceptKey(Key: Char): Boolean; override;
    // Called to paint the grid.
    procedure Paint; override;
    // Called when a key is pressed in the grid.
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    // Called when the mouse is pressed in the grid.
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    // Called when the mouse is released in the grid.
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    // Called when the mouse wheel is moved over the grid.
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    // Called to render the cell corresponding to a column.
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); override;
    // Called to create the TInplaceEdit instance used as the inplace editor.
    function CreateEditor: TInplaceEdit; override;

  public
    // If the user editor the read-only properties of any properties, then the user must call
    // this function immediately afterwards to update the visual state of the grid
    procedure UpdateEditorForReadOnlyColumnChange;
    // Called to configure which column is the boolean column (which is rendered as a checkbox).
    // field - the field which is to be rendered as a checkbox in the grid.
    // checkedVal - the value the field must have in order to rendered as checked.
    //              If it takes any other value it is rendered as unchecked.
    procedure SetBooleanField( field: TField; checkedVal: Variant );
    // Display the pick list for the inplace editor
    procedure ShowEditorPickList;
    // return the shift state during mouse operations, when appropriate
    function  GetShiftState:TShiftState;

  published
    constructor Create( Owner: TComponent ); override;

    // OnSetupInplaceEdit event - called before displaying the inplace editor in a cell.
    // gives user an opportunity to configure the inplace edit options.
    property OnSetupInplaceEdit: TSetupInplaceEditEvent read FOnSetupInplaceEdit write FOnSetupInplaceEdit default nil;
    // OnStepPastEnd event - called when user navigates or clicks past the end of the grid.
    property OnStepPastEnd: TStepPastEndEvent read FOnStepPastEndEvent write FOnStepPastEndEvent default nil;
    // OnToggleBooleanField event - called it the user attempts to toggle the value in the boolean
    // column.  It is up to the user to actually modify the value of the field as required.
    property OnToggleBooleanField: TNotifyEvent read FOnToggleBooleanField write FOnToggleBooleanField default nil;
    // Additional options for the grid - see description of TFlexiDBGridOption
    property FlexiOptions: TFlexiDBGridOptions read FFlexiOptions write FFlexiOptions default [];
    // Expose base class property
    property InplaceEditor;
    // Expose base class property, but fix bug.
    property SelectedField read GetSelectedField write SetSelectedField;

  end;

procedure Register;

implementation

uses Graphics, DBCtrls, Variants, Forms, Math, StdCtrls;

procedure Register;
begin
  RegisterComponents('Data Controls', [TFlexiDBGrid]);
end;

{ TFlexiDBGrid }

// No change to base implementation
function TFlexiDBGrid.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;

  if (Index <= 0) and (Index < Columns.Count) then
    Result := Columns[Index].Field
  else
    Result := nil;
end;


// Fix bug in SelectedField property of grid;  ensure that inplace editor is displayed if
// required; setting TDBGrid.SelectedField does not display the inplace editor.
procedure TFlexiDBGrid.SetSelectedField( field: TField );
begin
  inherited SelectedField := field;
  if (DataSource <> nil) and (dgAlwaysShowEditor in inherited Options) then
    ShowEditor;
end;

// Override paint method - attempt to hide the vertical scroll bar (Note: this leads to
// flickering, unfortunately).
procedure TFlexiDBGrid.Paint;
begin
  if fdboHideVerticalScrollBar in FFlexiOptions then begin
    SetScrollRange(Self.Handle, SB_VERT, 0, 0, False);
  end;
  inherited Paint;
end;

// If user has enabled the ieoEditFloatAsPercentage option for editing a float column,
// allow the % key in the cell editor.
// If user has enabled the ieoEditFloatAsFraction option for editing a float column,
// allow the / key in the cell editor.
function TFlexiDBGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  case Key of
    '%':
      if ieoEditFloatAsPercentage in cellEditOptions then begin
        CanEditAcceptKey := true;
      end else begin
        CanEditAcceptKey := inherited CanEditAcceptKey(Key);
      end;

    '/':
      if ieoEditFloatAsFraction in cellEditOptions then begin
        CanEditAcceptKey := true;
      end else begin
        CanEditAcceptKey := inherited CanEditAcceptKey(Key);
      end;

  else
    CanEditAcceptKey := inherited CanEditAcceptKey(Key);
  end;
end;

constructor TFlexiDBGrid.Create(Owner: TComponent);
begin
  inherited;
end;

// Get the text to display in the inplace editor.
function TFlexiDBGrid.GetEditText(ACol, ARow: Longint): string;
var
  edittext : String;
  column: TColumn;
begin
  edittext := inherited GetEditText(ACol, ARow);
  column := Columns[ SelectedIndex ];
  cellEditOptions := [];

  // Inplace editor is about to be displayed;  invoke event and give user an opportunity to
  // configure the cellEditOptions
  if Assigned(FOnSetupInplaceEdit) then
    FOnSetupInplaceEdit( self, InplaceEditor, column, cellEditOptions );

  if not (column.Field is TFloatField) then
    cellEditOptions := [];

  // Format float as a % if ieoEditFloatAsPercentage is enabled
  if ieoEditFloatAsPercentage in cellEditOptions then begin
    if column.Field.IsNull then
      edittext := ''
    else
      edittext := FloatToStrF( TFloatField( column.Field ).Value * 100, ffGeneral,
                               TFloatField( column.Field ).Precision, 2 ) + '%';
  end;

  GetEditText := edittext;
end;

// User pressed a key in the grid.
procedure TFlexiDBGrid.KeyDown(var Key: Word; Shift: TShiftState);

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;

    function FIndicatorOffset : integer;
    begin
      if dgIndicator in Options then
        Result := 1
      else
        Result := 0;
    end;

    procedure SendToParent;
    begin
      GetParentForm(Self).Perform(CM_DIALOGKEY, VK_TAB, 0);
    end;

  begin
    ACol := Col;
    Original := ACol;
    BeginUpdate;    { Prevent highlight flicker on tab to next/prior row }
    try
      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= ColCount then
        begin
          if fdboSingleRowTableTabs in FFlexiOptions then begin
            SendToParent;
            Exit;
          end;
          DataSource.Dataset.Next;
          if DataSource.Dataset.Eof then begin
            SendToParent;
            Exit;
          end;
          ACol := FIndicatorOffset;
        end
        else if ACol < FIndicatorOffset then
        begin
          if fdboSingleRowTableTabs in FFlexiOptions then begin
            SendToParent;
            Exit;
          end;
          DataSource.Dataset.Prior;
          if DataSource.Dataset.Bof then begin
            SendToParent;
            Exit;
          end;
          ACol := ColCount - FIndicatorOffset;
        end;
        if ACol = Original then Exit;
        if TabStops[ACol] then
        begin
          SelectedIndex := RawToDataColumn( ACol );
          Exit;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;

var
  newIndex: Integer;

  procedure MoveToCol;
  begin
    SelectedIndex := newIndex;
  end;

begin

  // Disallow Insert and Delete on the table if the user doesn't want it
  if ( (not (fdboAllowDelete in FFlexiOptions)) and
       (ssCtrl in Shift) and
       (Key = VK_DELETE) ) or
     ( (not (fdboAllowInsert in FFlexiOptions)) and
       (Key = VK_INSERT) ) then begin

    // invoke any handlers - don't pass on to the inherited class
    if Assigned(OnKeyDown) then
      OnKeyDown( self, key, Shift );

  end else if (Key = VK_DOWN) and (Shift * [ssShift,ssAlt,ssCtrl] = []) then begin

    // User is trying to scroll down in the grid.

    if Assigned(OnKeyDown) then
      OnKeyDown( self, key, Shift );

    // Scroll to next record.
    // If user is trying to go past the end of the table, invoke the OnStepPastEndEvent.
    if Key = VK_DOWN then begin

      DataSource.DataSet.Next;

      if DataSource.DataSet.Eof then begin
        if Assigned( FOnStepPastEndEvent ) then
          FOnStepPastEndEvent( self, sperKeyPress );
      end;

    end;

  end else if (Key = VK_TAB) and not (fdboDontFixTableTabs in FFlexiOptions) then begin

    if not (ssAlt in Shift) then
      Tab( not( ssShift in Shift ) );

  end else begin

    if fdboCursorNaviagtionSkipsROColumn in FFlexiOptions then begin
      // Skip readonly columns when navigating left and right
      case Key of
        VK_LEFT:
          begin
            newIndex := SelectedIndex - 1;
            while (newIndex >= 0) and not CanMoveToColumn( newIndex ) do
              Dec( newIndex );
            if newIndex >= 0 then
              MoveToCol;
          end;
        VK_RIGHT:
          begin
            newIndex := SelectedIndex + 1;
            while (newIndex < ColCount) and not CanMoveToColumn( newIndex ) do
              Inc( newIndex );
            if newIndex < ColCount then
              MoveToCol;
          end;
        VK_HOME:
          begin
            newIndex := 0;
            while (newIndex < ColCount) and not CanMoveToColumn( newIndex ) do
              Inc( newIndex );
            if newIndex < ColCount then
              MoveToCol;
          end;
        VK_END:
          begin
            newIndex := ColCount - 1;
            while (newIndex >= 0) and not CanMoveToColumn( newIndex ) do
              Dec( newIndex );
            if newIndex >= 0 then
              MoveToCol;
          end;
      else
        inherited;
      end;
    end else
      inherited;
  end;
end;

// User has pressed a mouse button in the grid.
procedure TFlexiDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  grid: TGridCoord;
  col: Integer;
  firstRow: Integer;
  callInherited: boolean;
begin
  callInherited := true;

  storedShiftState := Shift;

  grid := MouseCoord( X, Y );

  if dgTitles in Options then
    firstRow := 1
  else
    firstRow := 0;

  // If there is just a single, empty row, then clicking in it causes an OnStepPastEndEvent.
  if Assigned( DataSource) then begin
    if Assigned( DataSource.DataSet ) then begin
      if DataSource.DataSet.Active and (DataSource.DataSet.RecordCount = 0) and
         (DataSource.DataSet.State = dsBrowse) then
        if (grid.Y = firstRow) then begin
          callInherited := false;
          if Assigned( FOnStepPastEndEvent ) then
            FOnStepPastEndEvent( self, sperMouseClick );
        end;
    end;
  end;

  // If the table has some rows, then clicking just past the last record causes the
  // OnStepPastEndEvent.
  if grid.Y = -1 then begin

    // User didn't click on a row...
    grid := MouseCoord( X, Y - DefaultRowHeight );
    callInherited := false;

    if grid.Y <> -1 then begin
      // But there is a row just above this point - user has click just past the end
      // of the table.
      if Assigned( FOnStepPastEndEvent ) then
        FOnStepPastEndEvent( self, sperMouseClick );
    end;
  end else begin
    // If you click on a checkbox column, cause an OnToggleBooleanField event.
    col := RawToDataColumn( grid.X );
    if (col >= 0) and (col < ColCount) then begin
      if IsCheckboxColumn( col ) and Assigned( FOnToggleBooleanField ) then begin
        inherited; // Must call inherited to write edits through to the table
        FOnToggleBooleanField( self );
        callInherited := false;
      end;
    end;
  end;

  if callInherited then
    inherited;
end;

procedure TFlexiDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  // The inherited handler has the unfortunate side effect of throwing away the current contents
  // of the editor if you click past the end of the grid.
  if FGridState in [gsSelecting,gsRowSizing, gsColSizing,gsColMoving,gsRowMoving] then
    inherited
  else
  begin
    Cell := MouseCoord(X,Y);

    if (Button = mbLeft) and (Cell.X >= IndicatorOffset) and (Cell.Y = 0) then
      TitleClick(Columns[RawToDataColumn(Cell.X)])
  end;
end;


// User has moved mouse wheel - this is broken on the TDBGrid, so we fix it here.
function TFlexiDBGrid.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  if Assigned( DataSource ) then
    if Assigned( DataSource.DataSet ) then begin
      // Accumulate mouse wheel movement.
      WheelAccumulator := WheelAccumulator + WheelDelta;
      if Abs( WheelAccumulator ) >= WHEEL_DELTA then begin
        // Move cursor forward or backward as appropriate.
        DataSource.DataSet.MoveBy( -Sign(WheelAccumulator) * (Abs(WheelAccumulator) div WHEEL_DELTA) );
        WheelAccumulator := Sign(WheelAccumulator) * (Abs(WheelAccumulator) mod WHEEL_DELTA);
      end;
      DoMouseWheel := true;
    end else
      DoMouseWheel := false
  else
    DoMouseWheel := false
end;

// User has finished an inplace edit - write value back to field.
procedure TFlexiDBGrid.SetEditText(ACol, ARow: Integer;
  const Value: string);
var
  str: string;
  slashpos: Integer;
  res, divisor: Double;
begin
  if (ieoEditFloatAsPercentage in cellEditOptions) or
     (ieoEditFloatAsFraction in cellEditOptions) then begin

    // User is using our special editor options, so we can't just use the default
    // implementation.

    // Remove % symbols from the string.
    str := AnsiReplaceStr( Value, '%', '' );

    slashpos := AnsiPos( '/', str ) - 1;

    try
      if Length( str ) = 0 then begin

        // There is no text - allow default handler to deal with it.
        inherited SetEditText( ACol, ARow, '' );

      end else begin

        if slashpos <> -1 then begin

          // user has expressed this as a fraction 'xxx/xxx' - evaluate the division
          divisor := StrToFloat( RightStr( str, Length( str ) - slashpos - 1 ) );
          if divisor = 0 then
            res := 1
          else
            res := StrToFloat( LeftStr( str, slashpos ) ) / divisor;

        end else begin

          // user has expressed this as a simple number
          res := StrToFloat( str );

          // divide by 100 if this is a percentage.
          if ieoEditFloatAsPercentage in cellEditOptions then
            res := res / 100;

        end;

        // Now allow the default handler to do it's stuff with our computed value.
        inherited SetEditText( ACol, ARow, FloatToStr( res ) );
      end;

    except
      on EConvertError do ;// StrToFloat failed - user typed rubbish - don't do anything.
    end;

  end else begin

    inherited;

  end;
end;

// Can we navigate to the specified column index?
function TFlexiDBGrid.CanMoveToColumn( colIndex: Integer ): boolean;
begin
  if not (fdboCursorNaviagtionSkipsROColumn in FFlexiOptions) then
    CanMoveToColumn := true
  else if (colIndex < 0) or (colIndex >= Columns.Count) then
    CanMoveToColumn := false
  else if not Columns[ colIndex ].Visible then
    CanMoveToColumn := false
  else if Columns[ colIndex ].Field = nil then
    CanMoveToColumn := false
  else if Columns[ colIndex ].Field.ReadOnly then
    CanMoveToColumn := false
  else if Columns[ colIndex ].ReadOnly then
    CanMoveToColumn := false
  else
    CanMoveToColumn := true;
end;

// Do we want to display the editor in the given column?
function TFlexiDBGrid.WantToShowEditorInColumn( colIndex: Integer ): boolean;
begin
  if (fdboShowEditorInROColumn in FFlexiOptions) then
    WantToShowEditorInColumn := true
  else if (colIndex < 0) or (colIndex >= Columns.Count) then
    WantToShowEditorInColumn := false
  else if Columns[ colIndex ].Field = nil then
    WantToShowEditorInColumn := false
  else if Columns[ colIndex ].Field.ReadOnly then
    WantToShowEditorInColumn := false
  else if Columns[ colIndex ].ReadOnly then
    WantToShowEditorInColumn := false
  else
    WantToShowEditorInColumn := true;
end;

// User is specifying a column to be rendered as a checkbox.
procedure TFlexiDBGrid.SetBooleanField( field: TField; checkedVal: Variant );
begin
  boolField := field;
  boolCheckedVal := checkedVal;
  if Handle <> 0 then
    Invalidate;   // Repaint
end;

function TFlexiDBGrid.IsCheckboxColumn( colIndex: Integer ): boolean;
begin
  if not Assigned( boolField ) or (colIndex >= Columns.Count) then
    Result := false
  else
    Result := Columns[colIndex].Field = boolField;
end;

procedure TFlexiDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
                                      Column: TColumn; State: TGridDrawState);
var
  DrawState: UINT;
begin
  if IsCheckboxColumn( DataCol ) then begin
    // Render this column as a checkbox
    with Canvas do begin
      Brush.Color := Columns[DataCol].Color;
      FillRect( Rect );

      DrawState := DFCS_BUTTONCHECK;
      if (Columns[DataCol].Field.AsVariant = boolCheckedVal) then
        DrawState := DrawState or DFCS_CHECKED;
      if Columns[DataCol].ReadOnly then
        DrawState := DrawState or DFCS_INACTIVE;

      DrawFrameControl(Handle, Rect,
                       DFC_BUTTON, DrawState);
    end
  end else
    inherited DrawColumnCell( Rect, DataCol, Column, State );
end;

{ TDBGridInplaceEdit - a direct copy of the class with the same name in DBGrids.pas in the VCL
  source.  In order to implement the inplace editor functionality we want, we need to derive
  from this class.
  Unfortunately, the writers of VCL decided not to make the TDBGridInplaceEdit class
  used by the TDBGrid public, and so the only way we can extend from it is to use a copy of
  the code here. }
type
  TDBGridInplaceEdit = class(TInplaceEditList)
  private
    // DO NOT delete these fields.  The sizeof this class must not change, or it will not
    // correctly interoperate with the TDBGrid code.
    FDataList: TDBLookupListBox;
    FUseDataList: Boolean;
    FLookupSource: TDatasource;
  protected
    procedure CloseUp(Accept: Boolean); override;
    procedure DoEditButtonClick; override;
    procedure DropDown; override;
    procedure UpdateContents; override;
  public
    constructor Create(Owner: TComponent); override;
  end;

{ TDBGridInplaceEdit - passes result of edit to DBField, and gets pick list from DBField }

constructor TDBGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FDataList := nil;
  FUseDataList := False;
  FLookUpSource := nil;
end;

procedure TDBGridInplaceEdit.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if ListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if PickList.ItemIndex <> -1 then
      ListValue := PickList.Items[PickList.ItemIndex];
    SetWindowPos(ActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    ListVisible := False;
    Invalidate;
    if Accept then
      if (not VarIsNull(ListValue)) and EditCanModify then
        with TFlexiDBGrid(Grid), Columns[SelectedIndex].Field do
          Text := ListValue;
  end;
end;

procedure TDBGridInplaceEdit.DoEditButtonClick;
begin
  TFlexiDBGrid(Grid).EditButtonClick;
end;

procedure TDBGridInplaceEdit.DropDown;
var
  Column: TColumn;
begin
  if not ListVisible then
  begin
    with TFlexiDBGrid(Grid) do
      Column := Columns[SelectedIndex];
    PickList.Items.Assign(Column.PickList);
    DropDownRows := Column.DropDownRows;
  end;

  if not Assigned(ActiveList) then
    Exit;

  inherited DropDown;
end;

procedure TDBGridInplaceEdit.UpdateContents;
var
  Column: TColumn;
begin
  inherited UpdateContents;
  with TFlexiDBGrid(Grid) do
    Column := Columns[SelectedIndex];
  Self.ReadOnly := Column.ReadOnly;
  Font.Assign(Column.Font);
  ImeMode := Column.ImeMode;
  ImeName := Column.ImeName;
end;


type
  // The TFlexiInplaceEditor can operate in 3 modes:
  // femNormal: behaves just like a TDBGridInplaceEdit
  // femNoEdit: contents of editor cannot be edited, so editor attempts to make itself
  //            look like a selected grid cell rather than a edit box.
  // femCheckbox: editor is rendered as a checkbox; no editing is allowed.
  TFlexiEditMode = (femNormal, femNoEdit, femCheckbox);

  // TFlexiInplaceEditor - the inplace editor which implements some of the functionality of
  // the TDBFlexiGrid, namely:
  // (a) When a readonly column is edited and the fdboShowEditorInROColumn is not set on the
  //     grid, the editor makes itself look & behave like a selected cell in the table.
  // (b) Then a cell is edited in the 'boolean checkbox' column, the editor renders itself like
  //     a checkbox.
  // (c) When the fdboAutoCompleteCombos option is set on the grid, and the editor has a picklist
  //     (i.e. it looks like a combo box), the editor behaves like an auto completing combobox,
  //     rather than the crappy functionality provided by a normal grid.  Namely:
  //    (i) If you type a letter in the grid square, the pick list pops down and performs an
  //        incremental search.
  //    (ii) Additional characters typed while the pick list is displayed do incremental searches
  //        on the pick list.
  TFlexiInplaceEditor = class(TDBGridInplaceEdit)
    private
      // Perform an incremental search in the dropdown list, searching for the string str.
      // Update the position of the selection in the list, and the text in the edit box.
      procedure IncSearchDropDown( str: String );
      // Modify the text in the edit box, selecting the portion of the text specified by
      // sstart and slen.
      procedure ModifyText( str: String; sstart, slen: integer );

    protected
      // The current mode of the inplace editor - see TFlexiEditMode
      FeditMode: TFlexiEditMode;
      // True if we have hidden the caret in the editor.
      FhiddenCaret: boolean;

      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure KeyPress(var Key: Char); override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                          X, Y: Integer); override;
      procedure OnComboChar(var Key: Char);
      procedure OnComboKeyDown(var KeyCode: Word; shift: TShiftState);
      procedure WndProc(var Message: TMessage); override;
      procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
      procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
      procedure DblClick; override;
      procedure PaintWindow(DC: HDC); override;

    public
      constructor Create( Owner: TComponent ); override;
      // Setup the inplace editor to begin editing a cell
      procedure UpdateContents; override;
  end;

constructor TFlexiInplaceEditor.Create( Owner: TComponent );
begin
  inherited;
  FeditMode := femNormal;
  FhiddenCaret := false;
end;

// Repaint the inplace editor.
procedure TFlexiInplaceEditor.PaintWindow(DC: HDC);
var
  R: TRect;
  State: UINT;
begin
  if FeditMode = femCheckbox then begin
    // If this editor should  be rendered as a checkbox, then perform the rendering here.
    R.Left := 0;
    R.Right := Width;
    R.Top := 0;
    R.Bottom := Height;

    State := DFCS_BUTTONCHECK;
    if (TFlexiDBGrid(grid).Columns[TFlexiDBGrid(grid).SelectedIndex].Field.AsVariant =
        TFlexiDBGrid(grid).boolCheckedVal) then
      State := State or DFCS_CHECKED;
    if TFlexiDBGrid(grid).Columns[TFlexiDBGrid(grid).SelectedIndex].ReadOnly then
      State := State or DFCS_INACTIVE;

    DrawFrameControl(DC, R,
                     DFC_BUTTON, State );
    // Prevent editor drawing over the checkbox bitmap.
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited;
end;

// Update the text and selection in the edit box.
procedure TFlexiInplaceEditor.ModifyText( str: String; sstart, slen: integer );
begin
  if Text <> str then begin
    if EditCanModify then begin
      Text := str;
      Modified := true;
      SelStart := sstart;
      SelLength := slen;

      // Modify field value in dataset as well
      with TFlexiDBGrid(Grid) do
        SetEditText(Col, Row, str); // get grid to do actual modification.
    end;
  end else begin
    SelStart := sstart;
    SelLength := slen;
  end;
end;

// Perform incremental search of the drop down.
procedure TFlexiInplaceEditor.IncSearchDropDown( str: String );
var
  i: Integer;
  found: boolean;

  // Reposition the scrollbar of the dropdown list so that the item at 'index' is at the top.
  procedure scrollToTop( index: Integer );
  begin
    PickList.TopIndex := index;
  end;

begin
  found := false;
  // Search all the pick list items for the first one that matches 'str'
  with PickList.Items do
    for i := 0 to Count - 1 do
      if AnsiStartsText( str, Strings[i] ) then begin
        // Found a matching item, select it
        scrollToTop( i );
        PickList.ItemIndex := i;
        // Fill the completed string into the edit box with the correct case.
        // The portion of text which the user has typed is not selected, the rest is.
        ModifyText( Strings[i], Length( str ), Length( Strings[i] ) - Length( str ) );
        found := true;
        Break;
      end;
  if not found then begin
    // Not found, clear selection and update the edit box.
    scrollToTop( 0 );
    PickList.ItemIndex := -1;
    ModifyText( str, Length( str ), 0 );
  end;
end;

// User has typed a character in the drop down list box.
procedure TFlexiInplaceEditor.OnComboChar(var Key: Char);
begin
  if fdboAutoCompleteCombos in TFlexiDBGrid(Grid).FFlexiOptions then begin
    // User typed a key in the dropdown - do incremental search
    case Key of
      #8, #27: Key := #0; // Prevent built in search code in the popup.

      #32..#255:
        begin
          // User has typed a regular character.
          // If user is typing at the end of the text in the editbox, do incremental search.
          // If user is typing in the middle of the text, do a regular edit.
          if SelStart + SelLength >= Length(Text) then begin
            IncSearchDropDown( LeftStr( Text, SelStart ) + StringOfChar( Key, 1 ) );
          end else begin
            ModifyText( LeftStr( Text, SelStart ) + Key +
                        RightStr( Text, Length( Text ) - SelStart - SelLength ),
                        SelStart + 1, 0 );
          end;

          Key := #0; // swallow key press
        end;
    end;
  end;
end;

// User has pressed a key in the drop down list box.
// The following keys are treated specially:  Backspace, Delete, Home, End, Left and Right.
// These key presses are overridden to perform the expected actions within the edit box,
// or, if the user attempts to navigate past the extremities of the edit box, they are
// passed onto the grid for handling.
procedure TFlexiInplaceEditor.OnComboKeyDown(var KeyCode: Word; shift: TShiftState);
begin
  case KeyCode of
    VK_BACK: // backspace
      begin
        KeyCode := 0;

        If SelLength > 0 then begin
          // Clear selected portion
          ModifyText( LeftStr( Text, SelStart ) +
                      RightStr( Text, Length( Text ) - SelStart - SelLength ),
                      SelStart, 0 );
        end else begin
          // Delete character before cursor
          if SelStart > 0 then begin
            ModifyText( LeftStr( Text, SelStart - 1 ) +
                        RightStr( Text, Length( Text ) - SelStart ),
                        SelStart - 1, 0 );
          end;
        end;
      end;
    VK_DELETE:
      begin
        KeyCode := 0;

        If SelLength > 0 then begin
          // Clear selected portion
          ModifyText( LeftStr( Text, SelStart ) +
                      RightStr( Text, Length( Text ) - SelStart - SelLength ),
                      SelStart, 0 );
        end else begin
          // Delete character after cursor
          if SelStart < Length(Text) then begin
            ModifyText( LeftStr( Text, SelStart ) +
                        RightStr( Text, Length( Text ) - SelStart - 1 ),
                        SelStart, 0 );
          end;
        end;
      end;
    VK_HOME:
      begin
        if SelStart = 0 then
          TFlexiDBGrid(Grid).KeyDown(KeyCode, Shift)
        else begin
          SelStart := 0;
          SendMessage(Handle, EM_SCROLLCARET, 0, 0);
        end;

        KeyCode := 0;
      end;
    VK_END:
      begin
        if SelStart = Length(Text) then
          TFlexiDBGrid(Grid).KeyDown(KeyCode, Shift)
        else begin
          SelStart := Length(Text);
          SendMessage(Handle, EM_SCROLLCARET, 0, 0);
        end;
        KeyCode := 0;
      end;
    VK_LEFT:
      begin
        if SelStart = 0 then begin
          TFlexiDBGrid(Grid).KeyDown(KeyCode, Shift)
        end else begin
          SelStart := SelStart - 1;
          SendMessage(Handle, EM_SCROLLCARET, 0, 0);
        end;
        KeyCode := 0;
      end;
    VK_RIGHT:
      begin
        if SelStart = Length(Text) then
          TFlexiDBGrid(Grid).KeyDown(KeyCode, Shift)
        else begin
          SelStart := SelStart + 1;
          SendMessage(Handle, EM_SCROLLCARET, 0, 0);
        end;
        KeyCode := 0;
      end;
  end;
end;

// Intercept windows messages being sent to the dropdown list.
// This is used to perform incremental search functionality if desired in the dropdown.
procedure TFlexiInplaceEditor.WndProc(var Message: TMessage);
var
  c: char;
  fwd: boolean;
begin
  fwd := true;

  if ListVisible then begin
    case Message.Msg of
      wm_KeyDown:
        begin
          // Keydown in dropdown list box.
          OnComboKeyDown( TWMKey(Message).CharCode,
                          KeyDataToShiftState(TWMKey(Message).KeyData) );
          if TWMKey(Message).CharCode = 0 then
            fwd := false;
        end;
      wm_char:
        begin
          // Character press in dropdown list box.
          c := char( TWMKey(Message).CharCode );
          OnComboChar( c );
          if c = #0 then
            fwd := false;
        end;
    end;
  end;

  if fwd then
    inherited;
end;

// A key press in the edit box.
procedure TFlexiInplaceEditor.KeyPress(var Key: Char);
begin
  if fdboAutoCompleteCombos in TFlexiDBGrid(Grid).FFlexiOptions then begin
    if Assigned(ActiveList) then begin
      // Open up drop down list and begin incremental search
      if (Ord(Key) >= Ord(' ')) and (Ord(Key) < 127) then begin
        // Do incremental search
        DropDown;
        IncSearchDropDown( Key );
        Key := #0;
      end;
    end;
  end;

  if (FeditMode = femNormal) and (Key = #13) then
    Key := #0;

  // Space can be used to toggle the state of a checkbox.
  if (FeditMode = femCheckbox) and (Key = ' ') then
    if Assigned( TFlexiDBGrid(Grid).FOnToggleBooleanField ) then
      TFlexiDBGrid(Grid).FOnToggleBooleanField( TFlexiDBGrid(Grid) );

  inherited;
end;

// A keydown in the inplace editor.
procedure TFlexiInplaceEditor.KeyDown(var Key: Word; Shift: TShiftState);

  // Pass this key stroke onto the grid.
  procedure SendToParent;
  begin
    TFlexiDBGrid(Grid).KeyDown(Key, Shift);
    Key := 0;
  end;

begin
  // If we are not allowing editing of the cell, then pass on navigation keystrokes directly
  // to the grid, rather than allowing user to scroll about in the edit box.
  if (FeditMode <> femNormal) and (Key in [VK_LEFT,VK_RIGHT,VK_HOME,VK_END]) then SendToParent;

  if (FeditMode = femNormal) and (Key = VK_RETURN) then begin
    if EditCanModify then begin
      with TFlexiDBGrid(Grid), Columns[SelectedIndex].Field do begin
        with Columns[SelectedIndex].Field do
          Text := self.Text;
      end;
      Key := 0;
    end;
      //SetEditText(Col, Row, self.Text); // Update this field value.
  end;

  if (Key = VK_F2) and (Assigned(ActiveList)) then begin
    DropDown;
    Key := 0;
  end;

  if Key <> 0 then begin
    inherited KeyDown(Key, Shift);
  end;
end;

// Setup editor to edit this cell.
procedure TFlexiInplaceEditor.UpdateContents;
begin
  inherited UpdateContents;
  if TFlexiDBGrid(Grid).IsCheckboxColumn( TFlexiDBGrid(Grid).SelectedIndex ) then begin
    // Setup editor to look like a checkbox:
    Text := '';
    FeditMode := femCheckbox;
    Color := clWindow;

    // Hide the caret.
    if Focused then begin
      if not FhiddenCaret then begin
        if Handle <> 0 then
          HideCaret( Handle );
        FhiddenCaret := true;
      end;
    end;
  end else if TFlexiDBGrid(Grid).WantToShowEditorInColumn( TFlexiDBGrid(Grid).SelectedIndex ) then begin
    // Setup editor to do normal editing.
    FeditMode := femNormal;
    Color := clWindow;

    // Make sure caret is visible.
    if FhiddenCaret then begin
      if Handle <> 0 then
        ShowCaret( Handle );
      FhiddenCaret := false;
    end;
  end else begin
    // Setup editor to look like a read-only selected cell.
    FeditMode := femNoEdit;

    // Hide the caret.
    if Focused then begin
      Color := clHighlight;
      if not FhiddenCaret then begin
        if Handle <> 0 then
          HideCaret( Handle );
        FhiddenCaret := true;
      end;
    end;
  end;
  SelectAll;
end;

// Focus has come to the inplace editor.
procedure TFlexiInplaceEditor.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if FeditMode = femNoEdit then begin
    // Ensure that the all text is selected in the cell (otherwise, text is rendered as
    // black on Blue, which isn't very pretty).
    Color := clHighlight;
    SelectAll;
  end;

  // Hide caret if appropriate.
  if FeditMode <> femNormal then begin
    if not FhiddenCaret then begin
      if Handle <> 0 then
        HideCaret( Handle );
      FhiddenCaret := true;
    end;
  end;
end;

// Focus is leaving the inplace editor.
procedure TFlexiInplaceEditor.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  // Return color of window to normal
  if FeditMode = femNoEdit then begin
    Color := clWindow;
  end;
  // Unhide caret, only hide it again when focu returns to this control.
  if FeditMode <> femNormal then begin
    if FhiddenCaret then begin
      if Handle <> 0 then
        ShowCaret( Handle );
      FhiddenCaret := false;
    end;
  end;
end;

// Double click on cell - disable annoying behaviour where double clicking on an inplace editor
// causes the pick list to select the next value in the pick list.
procedure TFlexiInplaceEditor.DblClick;
begin
  if (EditStyle = esPickList) then
    TFlexiDBGrid(Grid).DblClick
  else
    inherited;
end;

// Mouse down in the edit box.
procedure TFlexiInplaceEditor.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if ListVisible then
    CloseUp(False) // Always close up on any click
  else begin
    // Invoke checkbox toggled event.
    if FeditMode = femCheckBox then begin
      if Assigned( TFlexiDBGrid(Grid).FOnToggleBooleanField ) then
        TFlexiDBGrid(Grid).FOnToggleBooleanField( TFlexiDBGrid(Grid) );
    end;

    // If you click on the editor, and there is only a single empty row, treat this as an
    // attempt to navigate past the end of the table, and cause an event
    if Assigned( TFlexiDBGrid(Grid).DataSource.DataSet ) then begin
      if TFlexiDBGrid(Grid).DataSource.DataSet.Active and
         (TFlexiDBGrid(Grid).DataSource.DataSet.RecordCount = 0) and
         (TFlexiDBGrid(Grid).DataSource.DataSet.State = dsBrowse) then
        if Assigned( TFlexiDBGrid(Grid).FOnStepPastEndEvent ) then
          TFlexiDBGrid(Grid).FOnStepPastEndEvent( Grid, sperMouseClick )
        else
          inherited
      else
        inherited;
    end else begin
      inherited;
    end;
 end;
end;

// Make sure our inplace editor is used in the grid.
function TFlexiDBGrid.CreateEditor: TInplaceEdit;
begin
  Result := TFlexiInplaceEditor.Create(Self);
end;

// Must be called by user after fiddling with the readonly status of a column.
// Update the editor as appropriate to ensure it is readonly/editable as appropriate.
procedure TFlexiDBGrid.UpdateEditorForReadOnlyColumnChange;
begin
  if Assigned( InplaceEditor ) then begin
    TFlexiInplaceEditor(InplaceEditor).UpdateContents;
    TFlexiInplaceEditor(InplaceEditor).BoundsChanged;
  end;
  inherited;
end;

// Display the pick list for the inplace editor
procedure TFlexiDBGrid.ShowEditorPickList;
begin
  if TFlexiInplaceEditor(InplaceEditor).FeditMode = femNormal then
    TFlexiInplaceEditor(InplaceEditor).DropDown;
end;

function TFlexiDBGrid.GetShiftState: TShiftState;
begin
  GetShiftState := storedShiftState;
end;

end.




