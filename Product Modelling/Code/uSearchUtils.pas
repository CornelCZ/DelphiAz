unit uSearchUtils;

(*
 * Unit contains various GUI utility procedures.
 *
 * Author: Hamish Martin, Edesix
 *)

interface
  uses Controls, StdCtrls, Classes;

// Setup a search box frame containing an edit box, Find Next/Prev buttons, and
// optionally a 'mid-word search' button.  target must be a TDBGrid or a
// TwwDBGrid.  searchCols are the columns of the target which are searched.
// startSearchTypeCols are columns which if you type in them start the search.
procedure setupSearchBox( searchBox: TGroupBox; target: TControl;
                          const searchCols: array of string;
                          const startSearchTypeCols: array of string;
                          searchEvent : TNotifyEvent = nil;
                          returnEvent : TNotifyEvent = nil );

implementation

uses Windows, DBGrids, DB, StrUtils, Dialogs, Messages, ExtCtrls, SysUtils;

type
  TSearchType = (searchNext, searchInc, searchPrev);

  // One instance of TSearchBoxConfig is created per search box.  This class contains all
  // the event handlers required to implement the search functionality
  TSearchBoxConfig = class(TComponent)
  public
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
    // Event invoked prior to performing a search.
    preSearchEvent : TNotifyEvent;
    // Event invoked prior to performing a search.
    onReturnHandler : TNotifyEvent;

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
  entCodeSearch : boolean;
  entCode : double;
  start: Integer;
  startBook: string;
  wrapped: Integer;
  firstSearch: boolean;
  searchFields: array of TField; // Field objects to be searched
  dataset: TDataSet;
  haveDoneBeforeScroll : boolean;
  dsBeforeScroll, dsAfterScroll : TDatasetNotifyEvent;

  // Initialise searchFields with a list of dataset fields to be searched
  procedure findSearchFields;
  var
    i : Integer;
  begin
    SetLength( searchFields, 0 );
    entCodeSearch := false;

    // Is the user searching for a specific ent code?
    try
      entCode := StrToFloat( editBox.Text );
      if (entCode >= 10000000000.0) and (entCode <= 50000000000.0) then
      begin
        SetLength( searchFields, 1 );
        searchFields[0] := dataset.FieldByName('EntityCode');
        entCodeSearch := true;
        noMatchText := '';
        Exit;
      end;
    except
      on e : Exception do ; // It obviously wasn't a valid ent code...
    end;

    // Look for grid columns matching the searchColNames
    with dbGrid do begin
      for i := 0 to Columns.Count - 1 do begin
        if Columns[i].Field <> nil then begin
          if AnsiMatchText( Columns[i].Field.FieldName, searchColNames ) or
             AnsiMatchText( Columns[i].Field.DisplayName, searchColNames ) or
             AnsiMatchText( Columns[i].Title.Caption, searchColNames ) then begin
            SetLength( searchFields, Length( searchFields ) + 1 );
            searchFields[ Length( searchFields ) - 1 ] := Columns[i].Field;
          end;
        end;
      end;
    end;
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
    if entCodeSearch then
    begin
      Result := searchFields[0].AsFloat = entCode;
      Exit;
    end;

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
        dbGrid.SelectedField := searchFields[i];
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

  // Invoked prior to moving the dataset cursor
  procedure beforeScroll;
  begin
    if not haveDoneBeforeScroll then begin
      if Assigned( dataset.BeforeScroll ) then
        dataset.BeforeScroll( dataset );

      dsBeforeScroll := dataset.BeforeScroll;
      dsAfterScroll := dataset.AfterScroll;
      dataset.BeforeScroll := nil;
      dataset.AfterScroll := nil;
      haveDoneBeforeScroll := true;
    end;
  end;

  procedure afterScroll;
  begin
    if haveDoneBeforeScroll then begin
      dataset.BeforeScroll := dsBeforeScroll;
      dataset.AfterScroll := dsAfterScroll;
      if Assigned( dsAfterScroll ) then
        dsAfterScroll( dataset );
    end;
  end;

begin
  if Assigned( preSearchEvent ) then
    preSearchEvent( self );

  // Work out which fields to search
  if not Assigned( dbGrid.DataSource.DataSet ) then Exit;
  dataset := dbGrid.DataSource.DataSet;
  findSearchFields;

  wrapped := 0;
  firstSearch := false;
  if searchFinished then begin
    searchFinished := false;
  end;

  dataset.DisableControls; // If we don't disable controls, this will be WAY too slow.

  haveDoneBeforeScroll := false;
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

                beforeScroll;

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

              beforeScroll;

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
                  Inc( wrapped );
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

              beforeScroll;

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
        ShowMessage('No matches found.')
      else
        ShowMessage('No more matches found.');
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
    afterScroll;
  end;
end;

procedure TSearchBoxConfig.showSelectedLine;
begin
  dbGrid.Options := dbGrid.Options + [DBGrids.dgAlwaysShowSelection]
end;

procedure TSearchBoxConfig.hideSelectedLine;
begin
  dbGrid.Options := dbGrid.Options - [DBGrids.dgAlwaysShowSelection]
end;

procedure TSearchBoxConfig.panelEnter(Sender: TObject);
begin
  // Show current selection in the grid; this allows user to see search result
  if hideGridSelection then begin
    showSelectedLine;
  end;
end;

procedure TSearchBoxConfig.panelExit(Sender: TObject);
begin
  editBox.Text := '';
  noMatchText := '';

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
      begin
        if Assigned( OnReturnHandler ) then begin
          OnReturnHandler( grid );
          Key := 0;
        end else
          grid.SetFocus;
      end;
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
    ShowMessage('Please enter the text you wish to search for.');
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
    if DBGrids.dgRowSelect in dbGrid.Options then begin
      Result := true;
      Exit;
    end;
    field := dbGrid.SelectedField;
    if dbGrid.SelectedIndex <> -1 then
      colTitle := dbGrid.Columns[ dbGrid.SelectedIndex ].Title.Caption;

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
    13:
      if Assigned( OnReturnHandler ) then begin
        OnReturnHandler( grid );
        Key := #0;
      end;
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
                          searchEvent : TNotifyEvent = nil;
                          returnEvent : TNotifyEvent = nil );
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
    dbGrid := nil;
    if target is TDBGrid then begin

      dbGrid := TDBGrid( target );
      hideGridSelection := not (DBGrids.dgAlwaysShowSelection in dbGrid.Options);

    end else
      assert( false, 'setupSearchBox: searchBox must be a DBGrid' );

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
    onReturnHandler := returnEvent;
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
    if Length( startSearchTypeColNames ) > 0 then
      dbGrid.OnKeyPress := gridKeyPress;
  end;
end;

end.
