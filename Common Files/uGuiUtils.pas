unit uGuiUtils;

(*
 * Unit contains various GUI utility procedures.
 *
 * Author: Hamish Martin, Edesix
 *)

interface
  uses ComCtrls, Math, Controls, StdCtrls, DBCtrls, Classes, ExtCtrls, Messages, Forms, Dialogs;

type
  // This class is designed to detect if a blocking dialog (e.g. a message box)
  // is popped up within a piece of code.  It can be useful to know whether a
  // piece of code executed virtually instantly, or whether it stopped to wait
  // for user input.
  //
  // Before executing the piece of code, create an instance of this class.
  // After the code has been executed, the hasPopupOccurred property will
  // indicate if another blocking window has been popped up.
  TPopupDetector = class( TObject )
  private
    FWindowHandle: integer;
    FhasPopupOccurred: boolean;
    procedure WndProc(var Msg: TMessage);
  public
    property hasPopupOccurred: boolean read FhasPopupOccurred;
    constructor Create;
    destructor Destroy; override;
  end;

  // Fills in the pick list for a combo box.  If the list of strings is the same as the
  // list already in the combobox, then no action is performed (This latter step avoids
  // an annoying problem where setting the pick list for a combo box causes the dropdown
  // list to close.  WinPrizm frequently needs to change the picks lists in certain comboboxes.
  // combobox - the combo box on which to set the pick list.
  // strings  - the list of strings to put in the combo box.
  procedure setComboBoxItems( combobox: TDBComboBox; strings: TStrings );
  // Set focus to a particular control.  If the control is hidden because it is in a tab of
  // a tab dialog which is not currently visible, this procedure will switch tabs to make
  // the control visible.  Any errors generated while switching focus are swallowed silently.
  procedure PrizmSetFocus( ctl: TWinControl );
  // Set the default button on a form, clearing the default property on all other buttons
  // on the form.
  procedure PrizmSetDefaultButton( button: TButton );
  // This procedure customizes the keyboard handling on a control and all its children.
  // This procedure can be called for a form, and its effects will be applied to all
  // child controls on the form.
  // This is done to overcome the following bugs in the standard controls:
  // - If you press Escape in a TDBComboBox, the behaviour is not correct.  This procedure
  //   fixes that behaviour.
  // - The tab stop behaviour of a TDBRadioGroup is not correct.  This procedure fixes the
  //   tab stop behaviour.
  // - ... if any more bugs are found, this procedure will be updated to fix them.
  procedure installCustomKeyboardHandling( parent: TControl );

  // Display an hourglass cursor
  procedure setWaitCursor;
  // Clear the hourglass cursor (only if clearWaitCursor has been called the same
  // number of times as setWaitCursor).
  procedure clearWaitCursor;
  // Move the specified form to the centre of the visible screen area.
  procedure CentreForm(Form: TForm);

  type
    StandardWindowsIcon = (
      IDI_APPLICATION = 32512,
      IDI_HAND = 32513,
      IDI_QUESTION = 32514,
      IDI_EXCLAMATION = 32515,
      IDI_ASTERISK = 32516 );
  // This procedure retrieves the standard windows icon, and places it into
  // the given form icon (if possible).
  procedure setImageToStandardIcon( image: TImage; icon: StandardWindowsIcon );

  // Setup a search box frame containing an edit box, Find Next/Prev buttons, and
  // optionally a 'mid-word search' button.  target must be a TDBGrid or a
  // TwwDBGrid.  searchCols are the columns of the target which are searched.
  // startSearchTypeCols are columns which if you type in them start the search.
  procedure setupSearchBox( searchBox: TGroupBox; target: TControl;
                            const searchCols: array of string;
                            const startSearchTypeCols: array of string;
                            searchEvent : TNotifyEvent = nil );

  // Ensure that this application is not already running - if it is, then bring
  // the other app into focus and raise an EAbort exception.
  procedure ensureSingleInstanceApp;

implementation

uses Windows, DBGrids, DB, Wwdbgrid, StrUtils, wwdbigrd, SysUtils;

procedure PrizmSetFocus( ctl: TWinControl );
var
  child, parent: TWinControl;
begin
  try
    // If control is within a tabbed dialog, switch to the correct tab
    child := ctl;
    parent := ctl.Parent;
    while parent <> nil do begin
      if (parent is TPageControl) and (child is TTabSheet) then
        TPageControl(parent).ActivePage := TTabSheet( child );
      child := parent;
      parent := child.Parent;
    end;

    // Now set focus to the control
    ctl.SetFocus;
  except else
    // Ignore all exceptions
  end;
end;

procedure setComboBoxItems( combobox: TDBComboBox; strings: TStrings );
var
  changeitems: boolean;
  i: integer;
begin
  //
  // Only update the Items array if it is different to the current one.
  //
  // This prevents problems when selecting a new unit in the Std Portion Unit
  // combo box.  Making the selection causes the table to go into Edit mode
  // which causes the Items property for the Std Portion Unit combo box to be
  // updated.
  //
  // If this happens the ComboBox gets confused and thinks the user has
  // selected a blank string.  The code below prevents this problem.
  //

  changeitems := false;

  if combobox.Items.Count <> strings.Count then
    changeitems := true;

  if not changeitems then begin
    for i := 0 to strings.Count - 1 do
      if strings[i] <> combobox.Items[i] then begin
        changeitems := true;
        Break;
      end;
  end;

  if changeitems then
    combobox.Items := strings;
end;


type
  // Class override keypress event on a combo box.
  TDBComboKeyPressHandler = class(TComponent)
  public
    keyPressHandler: TKeyPressEvent; // the original key press handler on the control.
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

procedure TDBComboKeyPressHandler.OnKeyPress(Sender: TObject; var Key: Char);
begin
  // TDBComboBox Escape handling is broken - fix it.
  with Sender as TDBComboBox do begin
    if Key = #27 then begin
      // When escape is pressed, we want the drop down to close, but without messing up
      // the value written to the field.  The only way to achieve this is to set the
      // keystroke to #9 - tab.  Setting this to #0 doesn't work.
      Key := #9;
    end;

    // Invoke the original key press handler.
    if Assigned( keyPressHandler ) then
      keyPressHandler( Sender, Key );
  end;
end;

var
  // Parent object used to own all instances of TDBComboKeyPressHandler
  handlerOwner: TComponent;


// Fix up keyboard handling
procedure installCustomKeyboardHandling( parent: TControl );
var
  i: Integer;
  dbComboKeyPressHandler: TDBComboKeyPressHandler;
begin
  // Create a parent object for all the handlers.
  if handlerOwner = nil then
    handlerOwner := TComponent.Create( nil );

  // Recursively invoke this procedure on all children of this component.
  if parent is TWinControl then begin
    with parent as TWinControl do begin
      // Install handlers on children
      for i := 0 to ControlCount - 1 do
        installCustomKeyboardHandling( Controls[i] );
    end;
  end;

  // Now perform customization actions on this control

  // When you hit Escape in a TDBComboBox the behaviour is totally broken:
  // The text in the combo box is updated to reflect the selected item, but
  // the field in the database table reverts to its previous value!
  // This handler fixes this problem.
  if parent is TDBComboBox then
    with parent as TDBComboBox do begin
      dbComboKeyPressHandler := TDBComboKeyPressHandler.Create( handlerOwner );
      dbComboKeyPressHandler.keyPressHandler := OnKeyPress;
      OnKeyPress := dbComboKeyPressHandler.OnKeyPress;
    end;

  // It is impossible to get the Tab behaviour of a TDBRadioGroup correct in
  // the designer.  The children of the control should be tab stops, but the
  // control itself should not.
  // In order to get the correct behaviour,  make the TDBRadioGroup a tab stop
  // in the designer (this causes its children to be tab stops).  This piece
  // of code then stops the parent being a tab stop.
  if parent is TDBRadioGroup then
    with parent as TDBRadioGroup do
      TabStop := false;
end;

// Sets the icon to the given windows standard icon
procedure setImageToStandardIcon( image: TImage; icon: StandardWindowsIcon );
var
  hdl: HIcon;
begin
  hdl := LoadImage( 0, Pointer(Ord(icon)), IMAGE_ICON, 0, 0,
                    LR_DEFAULTSIZE or LR_DEFAULTCOLOR or LR_SHARED );

  if hdl <> 0 then begin
    image.Picture.Icon.ReleaseHandle;
    image.Picture.Icon.Handle := hdl;
  end;
end;

// Set the default button on a form, clearing the default property on all other buttons
// on the form.
procedure PrizmSetDefaultButton( button: TButton );
var
  form : TWinControl;

  // Recursive clearing of Default property
  procedure unsetDefaultProperty( ctl: TControl );
  var
    i : Integer;
  begin
    // If this is button, clear the default property
    if (ctl <> button) and (ctl is TButton) then
      TButton(ctl).Default := false;

    // Unset property on children
    if ctl is TWinControl then
      with ctl as TWinControl do
        for i := 0 to ControlCount - 1 do
          unsetDefaultProperty( Controls[i] );
  end;

begin
  button.Default := true;

  // Find enclosing form
  form := button;
  while form.Parent <> nil do
    form := form.Parent;

  // Clear default property on all other buttons.
  unsetDefaultProperty( form );
end;

{ TPopupDetector }

constructor TPopupDetector.Create;
begin
  inherited Create;
  FhasPopupOccurred := false;
  // Create a window and send a message to it.  If the message is received, then
  // we know that an 'inner message loop' has been executed, indicating that
  // another blocking dialog has been popped up.
  FWindowHandle := Classes.AllocateHWnd(WndProc);
  PostMessage(FWindowHandle, WM_USER, 0, 0);
end;

destructor TPopupDetector.Destroy;
begin
  // Close the window (note that this flushes through the WM_USER message).
  Classes.DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TPopupDetector.WndProc(var Msg: TMessage);
begin
  // A message has been received - this indicates that a popup has occurred, or that
  // TPopupDetector.Destroy has been called.  Record that a popup has occurred.
  // (In the case of TPopupDetector.Destroy being called, it doesn't matter than
  // FhasPopupOccurred is set to true, since the whole class is being destroyed).
  with Msg do
    if Msg = WM_USER then
      FhasPopupOccurred := true
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

var
  waitCount: Integer = 0;
  oldCursor: TCursor;

// Display an hourglass cursor
procedure setWaitCursor;
begin
  Inc( waitCount );
  if waitCount = 1 then begin
    oldCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
  end;
end;

procedure clearWaitCursor;
begin
  Dec( waitCount );
  assert( waitCount >= 0 );
  if waitCount = 0 then begin
    Screen.Cursor := OldCursor;
  end;
end;

procedure CentreForm(Form: TForm);
begin
  With Form do begin
    Left := (Monitor.WorkareaRect.Right + Monitor.WorkareaRect.Left - Width) div 2;
    Top := (Monitor.WorkareaRect.Bottom + Monitor.WorkareaRect.Top - Height) div 2;
    if Left < Monitor.WorkareaRect.Left then
      Left := Monitor.WorkareaRect.Left;
    if Top < Monitor.WorkareaRect.Top then
      Top := Monitor.WorkareaRect.Top;
  end;
end;

type
  TSearchType = (searchNext, searchInc, searchPrev);

  // One instance of TSearchBoxConfig is created per search box.  This class contains all
  // the event handlers required to implement the search functionality
  TSearchBoxConfig = class(TComponent)
  public
    // Dataset being searched
    dataset: TDataSet;
    // The record on which the current search started
    NextSearchStartRecNo: Integer; // -1 = No forward search in progress
    PrevSearchStartRecNo: Integer; // -1 = No backward search in progress
    StartingRecNo: Integer;
    SearchFinished: boolean;

    // If this string is not-null, then this string had no matches.  This information
    // can be used to avoid doing another incremental search if the user keeps
    // typing
    noMatchText: string;

    // The grid control being searched
    grid : TWinControl;
    // wwDbGrid = grid if grid is a TwwDBGrid, or = nil if its not.
    wwDbGrid : TwwDBGrid;
    // dbGrid = grid if grid is a TDBGrid, or = nil if its not.
    dbGrid : TDBGrid;
    // The edit box where the user types the search string.
    editBox : TCustomEdit;
    // Find next and find prev buttons (can be nil)
    nextButton, prevButton : TButton;
    // Midword search checkbox (can be nil)
    midWordSearch : TCheckBox;
    // Should the grid selection be hidden when we are not in the search box?
    hideGridSelection : boolean;
    // Columns of dataset to be searched.
    searchColNames : array of string;
    // Columns of grid which typing in starts a search.
    startSearchTypeColNames : array of string;
    // Even invoked prior to performing a search.
    preSearchEvent : TNotifyEvent;

    // Display the current dataset line in the grid.
    procedure showSelectedLine;
    // Hide the current dataset line in the grid.
    procedure hideSelectedLine;
    // Perform a search next, search prev, or incremental search
    procedure doSearch(searchType: TSearchType );

    // Event handlers
    procedure panelEnter(Sender: TObject); // User enters search panel
    procedure panelExit(Sender: TObject);  // User leaves search panel
    procedure editChange(Sender: TObject); // User changes search text
    // User presses a key in the search text edit box
    procedure editKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    // User clicks find next or find prev
    procedure findButtonClick(Sender: TObject);
    // User clicks find next or find prev
    procedure midWordSearchClick(Sender: TObject);
    // User presses a key in the grid control
    procedure gridKeyPress(Sender: TObject; var Key: Char);
  end;

procedure TSearchBoxConfig.doSearch(searchType: TSearchType);
var
  start: Integer;
  startBook: string;
  wrapped: Integer;
  firstSearch: boolean;
  searchFields: array of TField; // Field objects to be searched

  // Initialise searchFields with a list of dataset fields to be searched
  procedure findSearchFields;
  var
    i : Integer;
  begin
    SetLength( searchFields, 0 );

    // Look for grid columns matching the searchColNames
    if Assigned( dbGrid ) then begin
      with dbGrid do begin
        for i := 0 to FieldCount - 1 do begin
          if AnsiMatchText( Fields[i].FieldName, searchColNames ) or
             AnsiMatchText( Fields[i].DisplayName, searchColNames ) or
             AnsiMatchText( Columns[i].Title.Caption, searchColNames ) then begin
            SetLength( searchFields, Length( searchFields ) + 1 );
            searchFields[ Length( searchFields ) - 1 ] := Fields[i];
          end;
        end;
      end;
    end else begin
      with wwDbGrid do begin
        for i := 0 to FieldCount - 1 do begin
          if AnsiMatchText( Fields[i].FieldName, searchColNames ) or
             AnsiMatchText( Fields[i].DisplayName, searchColNames ) or
             AnsiMatchText( Columns[i].DisplayLabel, searchColNames ) then begin
            SetLength( searchFields, Length( searchFields ) + 1 );
            searchFields[ Length( searchFields ) - 1 ] := Fields[i];
          end;
        end;
      end;
    end;

  end;

  // Invoked prior to moving the dataset cursor
  procedure postChanges;
  begin
    if Assigned( preSearchEvent ) then
      preSearchEvent( self );
  end;

  function doMidWordSearch : boolean;
  begin
    if Assigned( midWordSearch ) then
      doMidWordSearch := midWordSearch.Checked
    else
      doMidWordSearch := true;
  end;

  // Does the current dataset line match the search criteria?
  function currLineMatches : boolean;
  var
    text: string;
    i : Integer;
    match : boolean;
  begin
    text := editBox.Text;

    // Case insensitive search
    for i := Low(searchFields) to High(searchFields) do begin
      if doMidWordSearch then
        match := AnsiContainsText( searchFields[i].AsString, text )
      else
        match := AnsiStartsText( text, searchFields[i].AsString );

      if match then begin
        Result := true;

        // Select the column that matched
        if Assigned( dbGrid ) then
          dbGrid.SelectedField := searchFields[i]
        else
          wwDbGrid.SelectedField := searchFields[i];
        Exit;
      end;
    end;
    Result := false;
  end;

  function CurrentTextMightMatch : boolean;
  begin
    // noMatchText indicates a string we know doesn't match.  Use this to
    // figure out if there is any chance that the current string will match.
    Result := true;
    if Length( noMatchText ) > 0 then
      if doMidWordSearch then begin
        if AnsiContainsText( editBox.Text, noMatchText ) then
          Result := false;
      end else begin
        if AnsiStartsText( noMatchText, editBox.Text ) then
          Result := false;
      end;
  end;

begin
  // Work out which fields to search
  findSearchFields;

  wrapped := 0;
  firstSearch := false;
  if searchFinished then begin
    searchFinished := false;
  end;

  dataset.DisableControls; // If we don't disable controls, this will be WAY too slow.
  try
    if not CurrentTextMightMatch then
    begin
      // We have determined that the text the user typed cannot possibly match
      // anything.  We can skip the search - this significantly improves the
      // responsiveness on a large dataset if the user types a non-match in the
      // incremental search box.
      if searchType <> searchInc then begin
        firstSearch := true;
        searchFinished := true;
      end;
      NextSearchStartRecNo := -1;
      PrevSearchStartRecNo := -1;
    end
    else
    begin
      // Move the position of the dataset as required by the search
      case searchType of

        SearchInc:
          begin

            NextSearchStartRecNo := -1;
            PrevSearchStartRecNo := -1;
            SearchFinished := false;

            if not (dataset.BOF and dataset.EOF) then
            begin

              // Only depart the current line if it no longer matches search criteria
              if not CurrLineMatches then begin

                postChanges;

                start := dataset.RecNo;

                // Keep moving to next row until we find a match, or until we end up
                // where we started.
                repeat begin

                  dataset.Next; // Beware: this could raise an exception
                  if dataset.EOF then begin
                    Inc( wrapped );
                    dataset.First; // Wrapped - start at the beginning again
                  end;

                end
                until (Wrapped > 1 ) or CurrLineMatches or (dataset.RecNo = start);

              end;
            end;

          end;

        SearchNext:
          begin
            if not (dataset.BOF and dataset.EOF) then begin

              postChanges;

              if NextSearchStartRecNo = -1 then
              begin
                // Start a new search
                NextSearchStartRecNo := dataset.RecNo;
                PrevSearchStartRecNo := -1;
                firstSearch := true;
                StartingRecNo := dataset.RecNo;
              end
              else
              begin
                firstSearch := false;
              end;

              startBook := dataset.Bookmark;

              // Keep moving to next row until we find a match, or until we end up
              // where we started.
              repeat
                dataset.Next; // Beware: this could raise an exception

                if dataset.EOF then begin
                  Inc( Wrapped );
                  dataset.First; // Wrapped - start at the beginning again
                end;

                if DataSet.RecNo = StartingRecNo then begin
                  if not firstSearch then
                    // Stay at the last matching item
                    DataSet.Bookmark := startBook;
                  searchFinished := true;
                  NextSearchStartRecNo := -1;
                end;
              until searchFinished or CurrLineMatches or (wrapped > 1);

            end;
          end;

        SearchPrev:
          begin
            if not (dataset.BOF and dataset.EOF) then begin

              postChanges;

              if PrevSearchStartRecNo = -1 then
              begin
                // Start a new search
                PrevSearchStartRecNo := dataset.RecNo;
                firstSearch := true;
                NextSearchStartRecNo := -1;
                StartingRecNo := dataset.RecNo;
              end
              else
              begin
                firstSearch := false;
              end;

              startBook := dataset.Bookmark;

              // Keep moving to next row until we find a match, or until we end up
              // where we started.
              repeat
                dataset.Prior; // Beware: this could raise an exception

                if dataset.BOF then begin
                  Inc( Wrapped );
                  dataset.Last;  // Wrapped - start at the end again
                end;

                if DataSet.RecNo = StartingRecNo then begin
                  if not firstSearch then
                    // Stay at the last matching item
                    DataSet.Bookmark := startBook;
                  searchFinished := true;
                  PrevSearchStartRecNo := -1;
                end;
              until searchFinished or CurrLineMatches or (wrapped > 1);

            end;
          end;
      end;
    end;

    if (wrapped > 1) and (searchType <> searchInc) then begin
      searchFinished := true;
      NextSearchStartRecNo := -1;
      PrevSearchStartRecNo := -1;
    end;

    if searchFinished then begin
      if firstSearch and not CurrLineMatches then
        MessageDlg('No matches found.',mtInformation,[mbOK],0)
      else
        MessageDlg('No more matches found.',mtInformation,[mbOK],0)
    end;

    // If the current line matches the search criteria, then the search was successful:
    // Display the selection.  If current line doesn't match (which happens in an incremental
    // search), then hide the selection, to give user a visual indication that selection
    // has failed.
    if CurrLineMatches then begin
      showSelectedLine;
      noMatchText := '';
    end else begin
      hideSelectedLine;

      // This string found no matches.  Record it so that if the user keeps typing,
      // we can quickly determine that there will be no more matches.
      if (searchType = searchInc) and (Length( noMatchText ) = 0) then
        noMatchText := editBox.Text;
    end;


  finally
    dataset.EnableControls;
  end;

end;

procedure TSearchBoxConfig.showSelectedLine;
begin
  if Assigned( dbGrid ) then
    dbGrid.Options := dbGrid.Options + [DBGrids.dgAlwaysShowSelection]
  else
    wwDbGrid.Options := wwDbGrid.Options + [wwdbigrd.dgAlwaysShowSelection];
end;

procedure TSearchBoxConfig.hideSelectedLine;
begin
  if Assigned( dbGrid ) then
    dbGrid.Options := dbGrid.Options - [DBGrids.dgAlwaysShowSelection]
  else
    wwDbGrid.Options := wwDbGrid.Options - [wwdbigrd.dgAlwaysShowSelection];
end;

procedure TSearchBoxConfig.panelEnter(Sender: TObject);
begin
  // Show current selection in the grid; this allows user to see search result
  if hideGridSelection then begin
    showSelectedLine;
  end;
  PrizmSetDefaultButton( nextButton );
end;

procedure TSearchBoxConfig.panelExit(Sender: TObject);
begin
  editBox.Text := '';
  noMatchText := '';
  if Assigned(midWordSearch) then
    midWordSearch.Checked := false;

  // Hide current row in the grid.
  if hideGridSelection then
    hideSelectedLine
  else
    showSelectedLine;
end;

procedure TSearchBoxConfig.editChange(Sender: TObject);
begin
  // Typing in edit box causes incremental search
  if editBox.Text <> '' then
    doSearch(searchInc);
end;

procedure TSearchBoxConfig.midWordSearchClick(Sender: TObject);
begin
  // Incremental search when user checks the checkbox
  noMatchText := '';
  if editBox.Text <> '' then
    doSearch(searchInc);
end;

procedure TSearchBoxConfig.editKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    // User has pressed a navigation key - make this scroll the grid
    VK_DOWN, VK_UP, VK_HOME, VK_END, VK_PRIOR, VK_NEXT:
      begin
        grid.SetFocus;
        PostMessage( grid.Handle, WM_KEYDOWN, Key, 0 );
        PostMessage( grid.Handle, WM_KEYUP, Key, 0 );
      end;
    VK_RETURN:
      grid.SetFocus;
    VK_F7:
      // Toggle midword search
      if Assigned( midWordSearch ) then
        midWordSearch.Checked := not midWordSearch.Checked;
    VK_F8, VK_F3:
      // F8 and F3 do the search again - hold down shift to scroll backwards.
      if editBox.Text <> '' then
        if ssShift in Shift then
          doSearch(SearchPrev)
        else
          doSearch(SearchNext);
  end;
end;

procedure TSearchBoxConfig.findButtonClick(Sender: TObject);
begin
  if editBox.Text = '' then begin
    MessageDlg('Please enter the text you wish to search for.', mtInformation, [mbOK], 0);
    editBox.SetFocus;
  end else begin
    if Sender = prevButton then
      doSearch( searchPrev )
    else
      doSearch( searchNext );
  end;
end;

procedure TSearchBoxConfig.gridKeyPress(Sender: TObject; var Key: Char);

  // Should typing in the currently selected column cause a search?
  function shouldTypingInCurrentColumnStartSearch : boolean;
  var
    field : TField;
    colTitle : string;
  begin
    colTitle := '';
    if Assigned( wwDbGrid ) then begin
      if wwdbigrd.dgRowSelect in wwDbGrid.Options then begin
        Result := true;
        Exit;
      end;
      field := wwDbGrid.SelectedField;
      if wwDbGrid.SelectedIndex <> -1 then
        colTitle := wwDbGrid.Columns[ wwDbGrid.SelectedIndex ].DisplayLabel;
    end else begin
      if DBGrids.dgRowSelect in dbGrid.Options then begin
        Result := true;
        Exit;
      end;
      field := dbGrid.SelectedField;
      if dbGrid.SelectedIndex <> -1 then
        colTitle := dbGrid.Columns[ dbGrid.SelectedIndex ].Title.Caption;
    end;

    // See if the name of the field or the name of the column match any of
    // the strings provided by the caller
    if Assigned( field ) then begin
      if AnsiMatchText( field.FieldName, startSearchTypeColNames ) or
         AnsiMatchText( field.DisplayName, startSearchTypeColNames ) then begin
        Result := true;
        Exit;
      end;
    end;

    if Length( colTitle ) > 0 then begin
      if AnsiMatchText( colTitle, startSearchTypeColNames ) then begin
        Result := true;
        Exit;
      end;
    end;

    Result := false;
  end;

begin
  case Ord(Key) of
    32..127:
      begin
        if shouldTypingInCurrentColumnStartSearch then begin
          // User typed alphanumeric characters - move focus to the search box and
          // begin search
          editBox.SetFocus;
          editBox.Text := Key;
          editBox.SelStart := 1;
        end;
      end;
  end;
end;

procedure setupSearchBox( searchBox: TGroupBox; target: TControl;
                          const searchCols: array of string;
                          const startSearchTypeCols: array of string;
                          searchEvent : TNotifyEvent = nil );
var
  config : TSearchBoxConfig;
  i : Integer;
  tmpButton : TButton;

  // Search for the relevant controls in a parent control
  procedure findControls( ctl: TWinControl );
  var
    j : Integer;
  begin
    for j := 0 to ctl.ControlCount - 1 do begin
      if ctl.Controls[ j ] is TWinControl then
        findControls( ctl.Controls[ j ] as TWinControl ); // recurse down control hierarchy

      if ctl.Controls[ j ] is TCheckBox then
        config.midWordSearch := TCheckBox( ctl.Controls[ j ] );

      if (ctl.Controls[ j ] is TEdit) or
         (ctl.Controls[ j ] is TLabeledEdit) then
        config.editBox := TCustomEdit( ctl.Controls[ j ] );

      if ctl.Controls[ j ] is TButton then begin
        if Assigned( config.nextButton ) then
          config.prevButton := TButton( ctl.Controls[ j ] )
        else
          config.nextButton := TButton( ctl.Controls[ j ] );
      end;
    end;
  end;

begin
  config := TSearchBoxConfig.Create( searchBox );
  with config do begin

    // Get the grid and the data source
    wwDbGrid := nil;
    dbGrid := nil;
    if target is TDBGrid then begin

      dbGrid := TDBGrid( target );
      if Assigned( dbGrid.DataSource ) then
        dataset := dbGrid.DataSource.DataSet;
      hideGridSelection := not (DBGrids.dgAlwaysShowSelection in dbGrid.Options);

    end else if target is TwwDBGrid then begin

      wwDbGrid := TwwDBGrid( target );
      if Assigned( wwDbGrid.DataSource ) then
        dataset := wwDbGrid.DataSource.DataSet;
      hideGridSelection := not (wwdbigrd.dgAlwaysShowSelection in wwDbGrid.Options);

    end else
      assert( false, 'setupSearchBox: searchBox must be a DBGrid' );

    assert( Assigned( dataset ), 'setupSearchBox: could not find TDataset' );
    grid := TWinControl( target );

    // Now find the child controls
    editBox := nil;
    nextButton := nil;
    prevButton := nil;
    midWordSearch := nil;
    findControls( searchBox );

    assert( Assigned( editBox ), 'setupSearchBox: could not find edit box' );
    if Assigned( nextButton ) and Assigned( prevButton ) then begin
      // Check we have these the right way round...
      if AnsiContainsText( prevButton.Caption, 'next' ) then begin
        tmpButton := nextButton;
        nextButton := prevButton;
        prevButton := tmpButton;
      end
    end;

    // Record the columns to search
    SetLength( searchColNames, Length( searchCols ) );
    for i := Low( searchCols ) to High( searchCols ) do
      searchColNames[ i ] := searchCols[ i ];

    // Record which columns the user can type in to start a search
    SetLength( startSearchTypeColNames, Length( startSearchTypeCols ) );
    for i := Low( startSearchTypeCols ) to High( startSearchTypeCols ) do
      startSearchTypeColNames[ i ] := startSearchTypeCols[ i ];

    // Setup event handlers
    preSearchEvent := searchEvent;
    searchBox.OnEnter := panelEnter;
    searchBox.OnExit := panelExit;

    if editBox is TEdit then begin
      TEdit(editBox).OnChange := editChange;
      TEdit(editBox).OnKeyDown := editKeyDown;
    end else if editBox is TLabeledEdit then begin
      TLabeledEdit(editBox).OnChange := editChange;
      TLabeledEdit(editBox).OnKeyDown := editKeyDown;
    end;

    if Assigned( nextButton ) then
      nextButton.OnClick := findButtonClick;
    if Assigned( prevButton ) then
      prevButton.OnClick := findButtonClick;
    if Assigned( midWordSearch ) then
      midWordSearch.OnClick := midWordSearchClick;
    if Assigned( dbGrid ) and (Length( startSearchTypeColNames ) > 0) then
      dbGrid.OnKeyPress := gridKeyPress
    else
      wwDbGrid.OnKeyPress := gridKeyPress;
  end;
end;

//
// Code to ensure application single instance
//
var
  ThisAppRestoreMessage : Integer;
  OldMainWindowProc : Pointer;

function NewMainFormWindowProc(WindowHandle : hWnd; TheMessage : LongInt;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = ThisAppRestoreMessage then
  begin {Tell the application to restore, let it restore the form}
    if Application.MainForm.WindowState <> wsMinimized then
    begin  // do this to bring app to the top instead of just flashing on tool bar
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end
    else
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);

    SetForegroundWindow(Application.Handle);
    {We handled the message - we are done}
    Result := 0;
    exit;
  end;
  {Call the original winproc}
  Result := CallWindowProc(OldMainWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
end;

procedure ensureSingleInstanceApp;
var
  msgName, mutexName : string;
begin
  msgName := Application.Title + '_Restore';
  mutexName := Application.Title + '_Mutex';

  ThisAppRestoreMessage := RegisterWindowMessage( PChar(msgName) );
  CreateMutex(nil, false, PChar(mutexName) );

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, ThisAppRestoreMessage, 0, 0);
    {Lets quit}
    SysUtils.Abort;
  end;

  // Install a custom event handler on the main form to detect the restore
  // message and restore the app when we receive it
  OldMainWindowProc := Pointer(SetWindowLong(Application.MainForm.Handle, GWL_WNDPROC, LongInt(@NewMainFormWindowProc)));
end;

end.
