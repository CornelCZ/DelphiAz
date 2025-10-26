unit uSelectSiteLevel;

(*
 * Unit contains the TSelectLevelForm form - used to allow the user to select the site
 * whose entities will be edited by the current session.  This is similar to the 'level chooser'
 * used within Prizm.
 *
 * Author: Hamish Martin, Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DBTables, DB, DBClient, DBLocal, DBLocalB, ActnList,
  StdCtrls, DBCtrls, ADODB;

type
  TSelectLevelForm = class(TForm)
    CompanyLabel: TLabel;
    AreaLabel: TLabel;
    SiteLabel: TLabel;
    CompanySelLabel: TLabel;
    AreaSelLabel: TLabel;
    SiteSelLabel: TLabel;
    PromptLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    ActionList1: TActionList;
    BackAction: TAction;
    NextAction: TAction;
    ListBox: TListBox;

    ConfigTable: TADODataSet;
    ConfigTableCompanyCode: TSmallintField;
    ConfigTableAreaCode: TSmallintField;
    ConfigTableSiteCode: TSmallintField;
    ConfigTableSalesAreaCode: TSmallintField;
    ConfigTableCompanyName: TStringField;
    ConfigTableAreaName: TStringField;
    ConfigTableSiteName: TStringField;
    qryConfig: TADOQuery;
    SearchLabel: TLabel;

    procedure BackActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure NextActionUpdate(Sender: TObject);
    procedure ListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxExit(Sender: TObject);
    procedure ListBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    // levelcodes[0] = Company code selected by the user.
    // levelcodes[1] = Area code selected by the user.
    // levelcodes[2] = Site code selected by the user.
    levelcodes: array [0..2] of Integer;
    // levelnames[0] = Company name selected by the user.
    // levelnames[1] = Area name selected by the user.
    // levelnames[2] = Site name selected by the user.
    levelnames: array [0..2] of String;
    // The next level which the user must select a value for, e.g. when nextlevel = 0,
    // the user is selecting the company.
    nextlevel: Integer;
    // Rubbish search ability built into box
    searchString: string;

    // Display the selections which the user has already made in the labels at the
    // LHS of the form, and update the caption to prompt the user for the next selection.
    procedure displayLevel;
    // Fill the list box on the form with the valid values which can be selected for the
    // nextlevel which the user must select.
    procedure populateListBox;
    // Called when an item has been selected from the list;  this call updates the dialog as
    // appropriate for choosing the next level, if there are still remaining levels.
    // itemIndex - index of item in the listbox to select.
    // Returns:  True if all level selections have now been made.
    //           False if there are still level selections to be made.
    function selectItem(itemIndex: Integer) : boolean;
    procedure clearSearch;
    procedure doSearch(findNext, silent: boolean);
  public
    // Display the form, allow user to select a site;  return true if user selects a site, or
    // false if user cancels/backs out.
    function doSiteLevelSelect: boolean;
    // Get the site code the user selected.
    function getSiteCode: Integer;
    // Get the name of the site the user selected.
    function getSiteName: String;
  end;

var
  SelectLevelForm: TSelectLevelForm;

implementation

uses uLog, StrUtils, uGlobals;

{$R *.dfm}

// Display the current selection and display the prompt for the next selection.
procedure TSelectLevelForm.displayLevel;
var
  i: Integer;
  lblCtl, dispCtl: TLabel;
begin
  // For each level...
  for i := 0 to 2 do begin
    // Get the labels for displaying this level's selection.
    case i of
      0: begin
        lblCtl := CompanyLabel;
        dispCtl := CompanySelLabel;
      end;
      1: begin
        lblCtl := AreaLabel;
        dispCtl := AreaSelLabel;
      end;
      2: begin
        lblCtl := SiteLabel;
        dispCtl := SiteSelLabel;
      end;
    else
      begin
        Log.Event('DisplayLevel - Unknown Level');
        raise Exception.Create( 'unknown level' );
      end;
    end;

    // If user has selected a value for this level, then display it, otherwise hide
    // the labels.
    if i < nextlevel then begin
      dispCtl.Caption := levelnames[i];

      lblCtl.Visible := true;
      dispCtl.Visible := true;
    end else begin
      lblCtl.Visible := false;
      dispCtl.Visible := false;
    end;
  end;

  // now display the prompt
  case nextlevel of
    0: PromptLabel.Caption := 'Select a company:';
    1: PromptLabel.Caption := 'Select an area:';
    2: PromptLabel.Caption := 'Select a site:';
  end;
end;

// Fill the listbox with valid selections for the current level.
procedure TSelectLevelForm.populateListBox;
var
  lastcode: Integer;
begin
  clearSearch;
  ListBox.Clear;

  // Find the columns from the table for retrieving the name and code for this level.
  case NextLevel of
  0: begin
       with qryConfig do
       begin
         Close;
         SQL.Clear;
         SQL.Add('select [Company Code] as CodeField, [Company Name] as NameField');
         SQL.Add('from Company');
         SQL.Add('where [Company Code] in');
         SQL.Add('  (select [Company Code]');
         SQL.Add('   from Config');
         SQL.Add('   where (Deleted IS NULL) or (Deleted = ''N''))');
         SQL.Add('and (Deleted IS NULL) or (Deleted = ''N'')');
         SQL.Add('order by [company name]');
         Open;
       end;
     end;
  1: begin
       with qryConfig do
       begin
         Close;
         SQL.Clear;
         SQL.Add('select [Area Code] as CodeField, [Area Name] as NameField');
         SQL.Add('from Area');
         SQL.Add('where [Area Code] in');
         SQL.Add('  (select [Area Code]');
         SQL.Add('   from Config');
         SQL.Add('   where [Company Code] = ' + IntToStr(LevelCodes[0]));
         SQL.Add('   and (Deleted IS NULL) or (Deleted = ''N''))');
         SQL.Add('and (Deleted IS NULL) or (Deleted = ''N'')');
         SQL.Add('order by [Area Name]');
         Open;
       end;
     end;
  2: begin
       with qryConfig do
       begin
         Close;
         SQL.Clear;
         SQL.Add('select [Site Code] as CodeField, [Site Name] as NameField');
         SQL.Add('from Site');
         SQL.Add('where [Site Code] in');
         SQL.Add('  (select [Site Code]');
         SQL.Add('   from Config');
         SQL.Add('   where [Company Code] = ' + IntToStr(LevelCodes[0]));
         SQL.Add('   and [Area Code] = ' + IntToStr(LevelCodes[1]));
         SQL.Add('   and (Deleted IS NULL) or (Deleted = ''N''))');
         SQL.Add('and (Deleted IS NULL) or (Deleted = ''N'')');
         SQL.Add('order by [Site Name]');
         Open;
       end;
     end;
  else
    begin
      Log.Event('populateListBox - Unknown Level');
      raise Exception.Create( 'unknown level' );
    end;
  end;

  // Put all the valid items into the list; use the item code as the data for the list item.
  while not qryConfig.EOF do
  begin
    ListBox.AddItem(qryConfig.FieldByName('NameField').AsString,
      Pointer(qryConfig.FieldByName('CodeField').AsInteger));
    LastCode := qryConfig.FieldByName('CodeField').AsInteger;

    // Select this entry, if the user has previously selected it.
    if LastCode = LevelCodes[NextLevel] then
      ListBox.ItemIndex := ListBox.Items.Count - 1;

    qryConfig.Next;
  end;

  qryConfig.Close;
end;

// Select an item from the list and update/close the dialog as appropriate.
function TSelectLevelForm.selectItem( itemIndex: Integer ) : boolean;
var
  i: Integer;
  selCode: Integer;
begin
  selCode := Integer(Pointer(ListBox.Items.Objects[ itemindex ]));

  // If user has changed their mind about this value, then clear all subsequent
  if levelcodes[ nextlevel ] <> selCode then begin
    for i := nextlevel + 1 to 2 do
      levelcodes[ i ] := -1;
  end;

  // Record user selection.
  levelcodes[ nextlevel ] := selCode;
  levelnames[ nextlevel ] := ListBox.Items.Strings[ itemindex ];
  Inc( nextlevel );

  if nextlevel < 3 then begin
    // There is still at least one more level of selection to perform, fill in the
    // list box.
    populateListBox;

    // If there is only 1 item, select it automatically
    if ListBox.Items.Count = 1 then begin

      // Recursive call to select the only item in the list.
      selectItem := selectItem( 0 )

    end else begin

      // Update dialog and return.
      displayLevel;
      selectItem := false;

    end;

  end else begin

    // We have completed all the required selections.
    selectItem := true;
  end;
end;

// Popup form and perform level selection.
function TSelectLevelForm.doSiteLevelSelect : boolean;
var
  i: Integer;
begin
  for i := 0 to 2 do
    levelcodes[ i ] := -1;

  nextlevel := 0;

  // populate the list box
  populateListBox;

  // if there is only 1 item, select it automatically...
  if ListBox.Items.Count = 1 then begin
    if selectItem( 0 ) then begin

      // There can only be one site within the whole organization -
      // it has been automatically selected.
      doSiteLevelSelect := true

    end else begin

      // Popup form to allow user to select the site.
      ShowModal;
      doSiteLevelSelect := ModalResult = mrOk;

    end;
  end else begin

    // Setup the level display on the left
    displayLevel;

    // Popup form to allow user to select the site.
    ShowModal;
    doSiteLevelSelect := ModalResult = mrOk;

  end;
end;

// User has pressed back.
procedure TSelectLevelForm.BackActionExecute(Sender: TObject);
begin
  if nextlevel = 0 then begin

    // we have backed out of the dialog
    ModalResult := mrCancel;

  end else begin

    // Rewind a level and repopulate the list box.
    Dec( nextlevel );

    populateListBox;

    if ListBox.Items.Count = 1 then
      // Only one item in the list - go back past that one as well.
      BackActionExecute( Sender )
    else begin
      // Display dialog at this new level.
      displayLevel;
      ListBox.SetFocus;
    end;
  end;
end;

// User has pressed next.
procedure TSelectLevelForm.NextActionExecute(Sender: TObject);
begin
  if ListBox.ItemIndex <> -1 then begin
    if selectItem( ListBox.ItemIndex ) then begin
      // Selection is complete - close dialog.
      ModalResult := mrOk;

    end else
      ListBox.SetFocus;
  end;
end;

procedure TSelectLevelForm.NextActionUpdate(Sender: TObject);
begin
  // Enable next when something is selected in the list.
  NextAction.Enabled := ListBox.ItemIndex <> -1;
end;

function TSelectLevelForm.getSiteCode: Integer;
begin
  getSiteCode := levelcodes[2];
end;

function TSelectLevelForm.getSiteName: String;
begin
  getSiteName := levelnames[2];
end;

// When user double clicks in the list, it's like pressing next.
procedure TSelectLevelForm.ListBoxDblClick(Sender: TObject);
begin
  NextAction.Execute;
end;

// When user presses Enter in the list, it's like pressing next
procedure TSelectLevelForm.ListBoxKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13:
      begin
        NextAction.Execute;
        Key := #0;
      end;
    #8:
      begin
        // Backspace
        searchString := LeftStr( searchString, Length( searchString ) - 1 );
        if Length( searchString ) > 0 then
          doSearch( false, true ) // silent
        else
          clearSearch;
        Key := #0;
      end;
    #32..#127:
      begin
        if (Length( searchString ) = 0) and (ListBox.Items.Count > 0) then
          ListBox.ItemIndex := 0;
        searchString := searchString + Key;
        doSearch( false, false );
        Key := #0;
      end;
  end;
end;

procedure TSelectLevelForm.ListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F3:
      begin
        doSearch( true, false );
        Key := 0;
      end;
    VK_DOWN, VK_UP, VK_HOME, VK_END, VK_PRIOR, VK_NEXT:
      clearSearch;
    VK_RIGHT:
      begin
        NextAction.Execute;
        Key := 0;
      end;
    VK_LEFT:
      begin
        BackAction.Execute;
        Key := 0;
      end;
  end;
end;

procedure TSelectLevelForm.doSearch( findNext: boolean; silent : boolean );
var
  index : Integer;
begin
  if findNext then
    index := ListBox.ItemIndex + 1
  else
    index := ListBox.ItemIndex;
  if index = -1 then
    index := 0;

  while index < ListBox.Items.Count do
  begin
    if AnsiContainsText( ListBox.Items[ index ], searchString ) then
    begin
      SearchLabel.Caption := 'Search: '''+searchString+'''';
      ListBox.ItemIndex := index;
      Exit;
    end;
    Inc( index );
  end;

  if not silent then
    if findNext then
      ShowMessage('No more entries matching '''+searchString+''' found.')
    else
      ShowMessage('No entries matching '''+searchString+''' found.');
  clearSearch;
end;

procedure TSelectLevelForm.clearSearch;
begin
  SearchLabel.Caption := '';
  searchString := '';
end;

procedure TSelectLevelForm.ListBoxExit(Sender: TObject);
begin
  clearSearch;
end;

procedure TSelectLevelForm.ListBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clearSearch;
end;

procedure TSelectLevelForm.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_SELECT_SITE_FORM );
end;

end.
