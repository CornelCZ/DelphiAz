(*
Unit Name : uStructureTreeFrame.pas

Code creates a new class TSelectedFlags that is used to populate the TTreeView object
with Division, Categories, Sub Categories and Products.

The code controls how nodes are assigned their TImage property when another node is selected.
It also assigns an image to the nodes parent and child to ensure that a selection effects the whole
branch

The search facility is controlled by user input and

*)

unit uStructureTreeFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, uStructureUtils, DB, ActnList, ImgList, ExtCtrls, uPleaseWaitForm;

type


  TStructureSearchType = (sstSearchInc, sstSearchNext, sstSearchPrev);

  TStructureLevel = (slDivision, slCategory, slSubCategory, slProduct);

  // TEposXMLItem is an object that will be used to store the items that
  // will be displayed in the XML Discount container.
  TEposXMLItem = class
    displayName : String;
    indexLevel : TStructureLevel;
  end;

  TSelectedFlags = set of (
     pmfSelected, pmfPartSelected);

  // TSelectableNode represents each node of the TTreeView.  The class is assigned data
  // from temp tables based on each divsion.
  TSelectableNode = class
    uniqueName : string;
    displayName : string;
    flags : TSelectedFlags;
    treeNode : TTreeNode;
    childIndex : Integer;
    parent : TSelectableNode;
  end;

  // Used to store each selected node.  These Nodes are then added to the ThemeDiscountItems
  // table.
  TDiscountItem = class
    uniqueName : String;
    displayName : String;
    include : boolean;
    indexLevel : TStructureLevel;
  end;

  TStructureTreeFrame = class(TFrame)
    treeView: TTreeView;
    SearchGroupBox: TGroupBox;
    SearchTextEdit: TEdit;
    RestrictSearchComboBox: TComboBox;
    SearchAllRadioButton: TRadioButton;
    SearchSelectedRadioButton: TRadioButton;
    FindNextButton: TButton;
    FindPrevButton: TButton;
    RestrictSearchCheckBox: TCheckBox;
    BlockExpansionTimer: TTimer;
    Timer1: TTimer;
    ImageList: TImageList;
    NoFeatureTreeWarningLabel: TMemo;
    procedure treeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure treeViewKeyPress(Sender: TObject; var Key: Char);
    procedure treeViewCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
    procedure treeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RestrictSearchCheckBoxClick(Sender: TObject);
    procedure SearchTextEditChange(Sender: TObject);
    procedure treeViewCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure treeViewExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
  private
    procedure enterNode( node: TTreeNode );
    procedure setTreeSelection(permissions : TStrings);
    procedure featureTreeToggle;
    procedure createDivisionTable(divsionName : String);
    procedure addRootItem(Parent, NodeName, UniqueName : String; Index : integer);
    procedure setDivisionItems(divsionIndex : Integer);
    procedure setCategoryItems(categoryIndex : Integer);
    procedure setSubCategoryItems(subcategoryName : String; subcategoryIndex : String);
    procedure deleteEposDiscountItems;
    function shouldAllowExpand( node : TTreeNode ) : boolean;
    procedure suppressExpandNodeToggled( node : TTreeNode );
    procedure BlockExpansionTimerTimer(Sender: TObject);
  public
    FReadOnly : boolean;
    // Part of handling to prevent double clicking on a check box expanding/collapsing
    // nodes.  See suppressExpandNodeToggled().
    suppressExpandToggledNode : TTreeNode;
    // List of Nodes.  Strings are the unique name strings.  The
    // Object for each string is a point to an instance of TSelectableNode.
    selectableNodeList : TStringList;
    // Root Node.
    rootDiscountItem : TSelectableNode;
    DivisionlistID: integer;
    tableDivsion : String;
    // Start of find next and find prev searches
    SearchNextFirstMatch, SearchPrevFirstMatch: TTreeNode;
    // If the user chooses to search a sub-tree of the organization, this is the item
    // in the tree is used as the 'root' for the search
    subTreeSearchRoot: TTreeNode;
    // True if last search resulted in a message box
    FFinishedSearch : boolean;
    discountItem : TDiscountItem;
    eposItem : TEposXMLItem;
    selectedItems : TStringList;

    procedure loadTreeDisplayInfo(includeAll : Boolean);
    procedure loadTreeSelectionFromDb(includeAll : Boolean);
    procedure repopulateTree;
    procedure readDiscountItemTreeSelectionFromGui;
    procedure saveDiscountItems(includeAllProducts : Boolean);
    procedure populateTree(includeAll : Boolean);
    // Perform a search on the structure tree.
    procedure SearchDiscoutItems( searchType: TStructureSearchType);
    // Reset Search Box
    procedure setSearchBox(activate : boolean);
    procedure setEposDiscountItems;
    function treeNodesChecked : Boolean;
  end;

implementation

uses StrUtils, uGuiUtils, uADO, uAztecLog, ADODB;

{$R *.dfm}

type
  TCheckImage = (ciUnchecked, ciChecked, ciGrayed);

procedure setImage( node : TTreeNode; img : TCheckImage );
begin
  node.ImageIndex := Ord( img );
  node.SelectedIndex := Ord( img );
end;

procedure TStructureTreeFrame.populateTree(includeAll : Boolean);
var
  waitForm : TPleaseWaitForm;
begin
  waitForm := TPleaseWaitForm.ShowPleaseWait('Aztec Discounts', 'Populating Tree with items');
  loadTreeDisplayInfo(includeAll);

  if dmADO.isNewDiscount = False then
     loadTreeSelectionFromDb(includeAll);

  repopulateTree;
  waitForm.free;
end;

// User has pressed right arrow key in the tree - move selection to first child of the
// current node.  Skip nodes with only one child.
procedure TStructureTreeFrame.enterNode( node: TTreeNode );
begin
  if node.Count > 0 then begin
    node.Expanded := true;
    while (node.Count = 1) and node.getFirstChild.HasChildren do begin
      node := node.getFirstChild;
      node.Expanded := true;
    end;
    treeView.Select( node.getFirstChild );
  end;
end;

procedure TStructureTreeFrame.treeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RIGHT:
      begin
        if Assigned( treeView.Selected ) then
          enterNode( treeView.Selected );
        Key := 0;
      end;
  end;
end;

procedure TStructureTreeFrame.treeViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Ord(Key) of
    32..127:
      begin
        SearchTextEdit.SetFocus;
        SearchTextEdit.Text := Key;
        SearchTextEdit.SelStart := 1;
      end;
  end;

  if Key = #32 then begin
    Key := #0;
    featureTreeToggle;
  end;

end;


procedure TStructureTreeFrame.loadTreeDisplayInfo(IncludeAll : Boolean);

  //creates the TSelectableNode and adds the object to the selectableNodeList
  function getDiscountNodes( uniqueName : string ) : TSelectableNode;
  var
    i : Integer;
  begin
    i := selectableNodeList.IndexOf( uniqueName );
    if i = -1 then begin
      Result := TSelectableNode.Create;
      Result.uniqueName := uniqueName;
      Result.parent := rootDiscountItem;
      Result.flags := [];
      selectableNodeList.AddObject( uniqueName, Result );
    end else begin
      Result := TSelectableNode( selectableNodeList.Objects[i] );
    end;
  end;

  // Reads each table and creates the parent and child TSelectableNode for each record
  // in the table.
  procedure readFeatureTable( table : TDataSet;
    rootName : string;
    NameCol : string);
  var
    node : TSelectableNode;
  begin
    with table do begin
      Open;
      try
        First;
        while not EOF do
        begin
          node := getDiscountNodes(FieldByName( NameCol ).AsString);

          // Assign the node the parent root node.
          if not AnsiSameText( FieldByName( NameCol ).AsString, rootName ) then
             node.parent := getDiscountNodes(FieldByName( 'Parent' ).AsString);

          node.displayName := FieldByName( 'Node Name' ).AsString;

          node.childIndex := FieldByName( 'Index' ).AsInteger;
          Next;
        end;
      finally
        Close;
      end;
    end;
  end;

begin
  // creates each TStringList to hold each TSelectableNode.
  selectableNodeList := TStringList.Create;
  selectableNodeList.Sorted := true;
  selectableNodeList.CaseSensitive := false;
  try
    with dmADO.qDivision do
    begin
      Open;
      First;

      while not EOF do
      begin
        //Creates a temp table based on the division Name.
        createDivisionTable(FieldByName('DivisionName').asString);
        //Insert the division as the root item.
        addRootItem('NULL',
                    FieldByName('DivisionName').asString,
                    'DIV'+FieldByName('IndexNo').asString,
                    0);
        if includeAll = true then //Loads sub items if version supports.
             setDivisionItems(FieldByName('IndexNo').AsInteger);

        dmADO.BaseDataTable.CommandText := 'SELECT * FROM ##'+tableDivsion;
        readFeatureTable( dmADO.BaseDataTable, 'DIV'+FieldByName('IndexNo').asString, 'Unique Name');

        next;
      end;
    end;
  finally
  end;
end;

procedure TStructureTreeFrame.createDivisionTable(divsionName : String);
begin
  tableDivsion := StringReplace(divsionName, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  tableDivsion := StringReplace(tableDivsion, '/', '', [rfReplaceAll, rfIgnoreCase]);
  with dmADO.qRun do
  begin

    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..##'+tableDivsion+''') IS NOT NULL DROP TABLE ##'+tableDivsion+'');
    SQL.Add('CREATE TABLE ##'+tableDivsion+' (');
    SQL.Add('  Parent varchar(50),');
    SQL.Add('  [Node Name] varchar(50),');
    SQL.Add('  [Unique Name] varchar(50),');
    SQL.Add('  [Index] int)');
    try
      ExecSQL;
    except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
  end;
end;

procedure TStructureTreeFrame.addRootItem(Parent, NodeName, UniqueName : String; Index : integer);
begin
 NodeName := StringReplace(NodeName, '''', '', [rfReplaceAll, rfIgnoreCase]);
  with dmADO.qRun do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO ##'+tableDivsion+'(Parent, [Node Name], [Unique Name], [Index])');
    SQL.Add('VALUES ('''+Parent+''', '''+NodeName+''', '''+UniqueName+''', '+inttostr(Index)+') ');
    try
      ExecSQL;
    except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
  end;
end;

procedure TStructureTreeFrame.setDivisionItems(divsionIndex : Integer);
begin
  with dmADO.qCategories do
  try
    close;
    Parameters.ParamValues['DivisionIndex'] := divsionIndex;
    Open;
    First;
    while not EOF do
    begin
      addRootItem('DIV'+inttostr(divsionIndex),
                  FieldByName('CategoryName').AsString,
                  'CAT'+FieldByName('IndexNo').AsString,
                  1);
      setCategoryItems(FieldByName('IndexNo').AsInteger);
      next;
    end;
      except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
end;

procedure TStructureTreeFrame.setCategoryItems(categoryIndex : Integer);
begin
  with dmADO.qSubCategories do
  try
    close;
    Parameters.ParamValues['CategoryIndex'] := categoryIndex;
    Open;
    First;
    while not EOF do
    begin
      addRootItem('CAT'+inttostr(categoryIndex),
                  FieldByName('SubCategoryName').AsString,
                  'SUB'+FieldByName('IndexNo').AsString,
                  2);
      setSubCategoryItems(FieldByName('SubCategoryName').AsString, FieldByName('IndexNo').AsString);
      next;
    end;
      except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
end;

procedure TStructureTreeFrame.setSubCategoryItems(subcategoryName : String; subcategoryIndex : String);
begin
  with dmADO.qProducts do
  try
    close;
    Parameters.ParamValues['SubCatName'] := subcategoryName;
    Open;
    First;
    while not EOF do
    begin
      addRootItem('SUB'+subcategoryIndex,
                  FieldByName('RetailName').AsString,
                  FieldByName('EntityCode').AsString,
                  3);
      next;
    end;
      except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
end;

// If the site cannot run the new functionality then the exisiting loadDivisionList(itemList)
// procedure will be used to populate the tree.
procedure TStructureTreeFrame.loadTreeSelectionFromDb(includeAll : Boolean);
var
  itemList : TStringList;
begin
  itemList := TStringList.Create;
  try
    if includeAll = True then
       dmADO.getDiscountItems(itemList)
    else
       dmADO.loadDivisionList(itemList);

    setTreeSelection(itemList);
  finally
    itemList.Free;
  end;
end;

procedure TStructureTreeFrame.repopulateTree;

  // Traverses up the branch to ensure that a nodes parent has been assgned a part selected flag.
  procedure selectParentNode( pm : TSelectableNode );
  begin
      if Assigned( pm.parent ) then
        with pm.parent do
          if not (pmfSelected in pm.parent.flags) then
          begin
            pm.parent.flags := pm.parent.flags + [pmfPartSelected];
            selectParentNode( pm.parent );
          end;
  end;

  // Sets the TImage property to ciGrayed.
  procedure setGrayParentImage( node : TTreeNode );
  begin
    while node.ImageIndex = Ord(ciChecked) do
    begin
      setImage( node, ciGrayed );
      node := node.Parent;
    end;
  end;

  procedure createNode( fi : TSelectableNode );
  begin
    if fi.parent = fi then
      ShowMessage( 'loop at node ' + fi.displayName + ' ' + fi.uniquename );
    if fi.treeNode <> nil then
      Exit;

    if fi.parent = Nil then
    begin
      fi.treeNode := treeView.Items.AddObject(
             nil, fi.displayName, Pointer( fi ) );
    end else begin
      createNode( fi.parent );
      fi.treeNode := treeView.Items.AddChildObject(
             fi.parent.treeNode, fi.displayName, Pointer( fi ) );
    end;

    // If node has been selected set Image property to ci Checked or Unchecked.
    if pmfSelected in fi.flags then
       setImage( fi.treeNode, ciChecked )
      else
        setImage( fi.treeNode, ciUnchecked );

        // Node has child nodes selected so it will be assigned a ciGrayed Image.
    if pmfPartSelected in fi.flags then
           setImage( fi.treeNode, ciGrayed )

  end;

var
  i : Integer;
  node : TTreeNode;
begin
  treeView.Items.BeginUpdate;
  try
    // clears the TTreeView
    treeView.Items.Clear;
    treeView.SortType := stNone;
    for i := 0 to selectableNodeList.Count - 1 do
      with TSelectableNode( selectableNodeList.Objects[i] ) do
           treeNode := nil;

      // If a node has been selected ensure parent node is assigned a selected flag
      for i := 0 to selectableNodeList.Count - 1 do
        if pmfSelected in TSelectableNode( selectableNodeList.Objects[i] ).flags then
          selectParentNode( TSelectableNode( selectableNodeList.Objects[i] ) );

      // Create a node for each object in selectableNodeList
      for i := 0 to selectableNodeList.Count - 1 do
        with TSelectableNode( selectableNodeList.Objects[i] ) do
             createNode(TSelectableNode( selectableNodeList.Objects[i] ));

      node := treeView.Items.GetFirstNode;
      while Assigned( node ) do begin
        if node.getFirstChild <> nil then
        begin
          case node.Level of
            // Display TTreeview with the first level expanded to show Division Categories.
            0: begin
              node.Expanded := true;
              node.Expanded := TCheckImage( node.ImageIndex ) = ciGrayed;
               end;
          else
            node.Expanded := false;
          end;
        end;
        node := node.GetNext;
      end;

    treeView.SortType := stText;
  finally
    treeView.Items.EndUpdate;
  end;
end;

procedure TStructureTreeFrame.setTreeSelection(permissions : TStrings);
var
  i : Integer;
  permissionIndex : Integer;
  uniqueName : string;
begin
  for i := 0 to selectableNodeList.Count - 1 do
    with TSelectableNode( selectableNodeList.Objects[i] ) do
      flags := flags - [pmfSelected];

  for i := 0 to permissions.Count - 1 do
  begin
    uniqueName := permissions[i];
    permissionIndex := selectableNodeList.IndexOf( uniqueName );
    if permissionIndex <> -1 then
    begin
      with TSelectableNode( selectableNodeList.Objects[permissionIndex] ) do
        flags := flags + [pmfSelected];
    end;
  end;
end;

// Toggle the checked state of the selected node in the feature tree
procedure TStructureTreeFrame.featureTreeToggle;

  function areAnyDescendentsChecked( node : TTreeNode ) : boolean;
  var
    i : Integer;
  begin
    Result := false;
    for i := 0 to node.Count - 1 do
      if (TCheckImage(node[i].ImageIndex) in [ciGrayed,ciChecked]) then
      begin
        Result := true;
        Break;
      end;
  end;

  function areAllDescendentsChecked( node : TTreeNode ) : boolean;
  var
    i : Integer;
  begin
    Result := true;
    for i := 0 to node.Count - 1 do
      if (TCheckImage(node[i].ImageIndex) <> ciChecked) then
      begin
        Result := false;
        Break;
      end;
  end;

  procedure setStateNonRecursiveAllFeatures( node : TTreeNode; checked : boolean ); forward;
  procedure setStateRecursive( node : TTreeNode; checked : boolean ); forward;


  procedure checkParentNodeState( node : TTreeNode );
  begin
      // The state of this node itself is significant - it may remain checked, even
      // if all its children are unchecked.
      case TCheckImage( node.ImageIndex ) of
        ciChecked, ciGrayed:
          setStateNonRecursiveAllFeatures( node, true );
        ciUnchecked:
          if areAnyDescendentsChecked( node ) then
            setStateNonRecursiveAllFeatures( node, true );
      end;
  end;

  // Set the checked/unchecked state of a single feature/tree node.
  procedure setStateNonRecursiveOneFeature( node : TTreeNode; checked : boolean );
  var
    newImage : TCheckImage;
  begin
    // Figure out the correct icon
    if checked then begin
      if areAllDescendentsChecked( node ) then
        newImage := ciChecked
      else
        newImage := ciGrayed
    end else
      newImage := ciUnchecked;

    if Ord(newImage) <> node.ImageIndex then
    begin
      // Change icon - this may have an impact on the parent.  If we are unchecking
      // we also have to uncheck all children.
      setImage( node, newImage );
      if (newImage = ciUnchecked) and (node.Count > 0) then
        setStateRecursive( node, false );

      if node.Parent <> nil then
         checkParentNodeState( node.Parent );
    end;
  end;

  // Set the checked/unchecked state of a feature + all features which share the
  // same node.
  procedure setStateNonRecursiveAllFeatures( node : TTreeNode; checked : boolean );
  var
    permission : TSelectableNode;
  begin
    permission := TSelectableNode( node.Data );
      if Assigned( permission.treeNode ) then
          setStateNonRecursiveOneFeature( permission.treeNode, checked );
  end;

  // Set the state of a node, all its children and any other node which share
  // a TSelectablenode with any of the affected tree nodes.
  procedure setStateRecursive( node : TTreeNode; checked : boolean );
  var
    child : TTreeNode;
  begin
    child := node.getFirstChild;
    while child <> nil do begin
      setStateRecursive( child, checked );
      child := child.getNextSibling;
    end;
    setStateNonRecursiveAllFeatures( node, checked );
  end;

var
  node : TTreeNode;
begin
  if FReadOnly then
    Exit;
  // Toggle state of node & children and related features.
  node := treeView.Selected;
  if Assigned( node ) then begin
    treeView.Items.BeginUpdate;
    try
      setWaitCursor;
      case TCheckImage(node.ImageIndex) of
        ciUnchecked:
          setStateRecursive( node, true );
        ciChecked, ciGrayed:
          setStateRecursive( node, false );
      end;
    finally
      clearWaitCursor;
      treeView.Items.EndUpdate;
    end;
  end;
end;

procedure TStructureTreeFrame.treeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // User has clicked on the checkbox.  Toggle this node.
  if htOnIcon in treeView.GetHitTestInfoAt( X, Y ) then begin
    treeView.Selected := treeView.GetNodeAt( X, Y );
    featureTreeToggle;
  end;
  
  if (SearchSelectedRadioButton.Enabled = True) then
     begin
       if (treeView.Selected.Level <> 3) then
         begin
           SearchSelectedRadioButton.Caption := 'Search ' + treeView.Selected.Text;
           subTreeSearchRoot := treeView.Selected;
         end
       else
         begin
           SearchSelectedRadioButton.Caption := 'Search ' + treeView.Selected.Parent.Text;
           subTreeSearchRoot := treeView.Selected.Parent;
         end
     end;
end;

// Compare two nodes in the feature tree to ensure correct sort order.
procedure TStructureTreeFrame.treeViewCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
var
  f1, f2 : TSelectableNode;
begin
  f1 := TSelectableNode( Node1.Data );
  f2 := TSelectableNode( Node2.Data );
  if Assigned( f1 ) and Assigned( f2 ) then
  begin
    if f1.childIndex < f2.childIndex then
      Compare := -1
    else if f1.childIndex > f2.childIndex then
      Compare := 1
    else if f1.displayName < f2.displayName then
      Compare := -1
    else if f1.displayName > f2.displayName then
      Compare := 1
    else
      Compare := 0;
  end else
    Compare := 0;
end;

// Setup the pmfSelected flag based on the Nodes selected in the GUI.
procedure TStructureTreeFrame.readDiscountItemTreeSelectionFromGui;
var
  i : Integer;
begin
  for i := 0 to selectableNodeList.Count - 1 do
    with TSelectableNode( selectableNodeList.Objects[i] ) do
    begin
      flags := flags - [pmfSelected];
      if Assigned( treeNode ) and
           (TCheckImage( treeNode.ImageIndex ) in [ciChecked]) then
          flags := flags + [pmfSelected];
    end;
end;

procedure TStructureTreeFrame.saveDiscountItems(includeAllProducts : Boolean);
var
  i : integer;

  // Assign a TStructureLevel to each TSelectableNode.
  function getIndexLevel(level : String) : TStructureLevel;
  begin
    level := LeftStr(level, 3);

    if level = 'DIV' then
       result := slDivision
    else
      if level = 'CAT' then
         result := slCategory
      else
         if level = 'SUB' then
            result := slSubCategory
         else
            result := slProduct
  end;

begin

  selectedItems := TStringList.Create;

  readDiscountItemTreeSelectionFromGui;
  //Add each selected selectableNode to the selectedItems stringlist
  for i := 0 to selectableNodeList.Count - 1 do
    with TSelectableNode( selectableNodeList.Objects[i] ) do
         if (pmfSelected in flags) and (uniqueName <> '') then
            begin
              if includeAllProducts = true then
                begin
                   discountItem := TDiscountItem.Create;
                   discountItem.uniqueName := uniqueName;
                   discountItem.displayName := displayName;
                   discountItem.indexLevel := getIndexLevel(uniqueName);
                   selectedItems.AddObject(uniqueName, discountItem);
                end
              else
                selectedItems.Add( uniqueName );
            end;

    if selectedItems.Count <> 0 then
      begin
      // If site cannot run new functionality, use the older functionality.
       if includeAllProducts = true then
          begin
            deleteEposDiscountItems;
            setEposDiscountItems;
          end
        else
            dmADO.SaveDivisionlist(selectedItems);
      end;

end;

// Deletes each record from the ThemeDiscountItems table that has a
// similar discount id to prepare for new update.
procedure TStructureTreeFrame.deleteEposDiscountItems;
begin
  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ThemeDiscountItems WHERE DiscountID = '+dmADO.qDiscounts.FieldbyName('DiscountID').AsString);
    ExecSQL;
  end;
end;

// Adds each discount item to the table that has been selected.  Works out what item
// will appear in the XML Discount container by setting a selected parents record to
// includeItem = True.
procedure TStructureTreeFrame.setEposDiscountItems;
var
  includeXMLItems : TStringList;
  i : integer;
  currentPos : TTreeNode;
  discountID : String;

  procedure saveDiscountItem(discountID, uniqueName, displayName : String; include : Boolean );
  begin
    with dmADO.qRun do
      try
        SQL.Clear;
        SQL.Add('INSERT INTO ThemeDiscountItems(DiscountID, [Unique Name], DisplayName, Include, LMDT)');
        SQL.Add('VALUES('+DiscountID+', '''+uniqueName+''', '''+displayName+''', '+ BoolToStr(include)+', GETDATE())');
        ExecSQL;
      except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
  end;

  //Checks to see if a nodes and parent node has been added to the XML list.
  function checkExistsInXML(FdisplayName : String; FindexLevel : TStructureLevel) : boolean;
  var j : integer;
  begin
    for j := 0 to includeXMLItems.Count -1 do
    with TEposXMLItem(includeXMLItems.Objects[j]) do
      if (displayName = FdisplayName) and (indexLevel = FindexLevel) then
         begin
           result := true;
           exit;
         end
      else
         result := false;
  end;

  function getIndexLevel(level : Integer) : TStructureLevel;
  begin

    if level = 0 then
       result := slDivision
    else
      if level = 1 then
         result := slCategory
      else
         if level = 2 then
            result := slSubCategory
         else
            result := slProduct

  end;

  procedure searchCheckedNodes(node : TTreeNode);
  begin
    if node = nil then
       exit;

    if (TCheckImage( node.ImageIndex ) in [ciChecked, ciGrayed]) then
       begin
         if (TCheckImage( node.ImageIndex ) in [ciChecked]) then
            begin
              eposItem := TEposXMLItem.Create;
              eposItem.displayName := node.Text;
              eposItem.indexLevel := getIndexLevel(node.Level);
              includeXMLItems.AddObject(node.Text, eposItem);
              searchCheckedNodes(node.getNextSibling);
            end
         else
            begin
              if node.getNext <> nil then
                 searchCheckedNodes(node.getNext)
              else
                 searchCheckedNodes(node.Parent.getNextSibling);
            end;
       end
    else
       begin
         if node.getNextSibling <> nil then
            searchCheckedNodes(node.getNextSibling)
         else
           begin
            if node.Parent.getNextSibling = nil then
               searchCheckedNodes(node.getNext)
            else
               searchCheckedNodes(node.Parent.getNextSibling);
           end;
       end;
  end;

begin

  discountID := dmADO.qDiscounts.FieldbyName('DiscountID').AsString;

  includeXMLItems := TStringList.Create;
  includeXMLItems.Sorted := True;
  includeXMLItems.CaseSensitive := false;

  currentPos := treeView.Items.GetFirstNode;
  searchCheckedNodes(currentPos);

  if includeXMLItems.count <> 0 then
     begin
       for i := 0 to selectedItems.Count - 1 do
          with TDiscountItem(selectedItems.Objects[i]) do
           begin
             if checkExistsInXML(displayName, indexLevel) then
                include := true
             else
                include := false;

             saveDiscountItem(discountID, uniqueName, displayName, include);
           end;
     end;
end;

// Peform a search next, search prev or incremental search on the org. tree.
procedure TStructureTreeFrame.SearchDiscoutItems( searchType: TStructureSearchType );
var
 restrictedSearch, hitFirstMatch: boolean;
  restrictedSearchLevel: Integer;
  searchRoot: TTreeNode;
  currentPos: TTreeNode;
  searchText: string;
  foundItem: boolean;

  // Does the given tree node match the search parameters?
  function selectionMatches( sel: TTreeNode ): boolean;
  begin
    if restrictedSearch then begin
      if restrictedSearchLevel <> sel.level then begin
        Result := false;
        Exit;
      end;
    end;
    Result := AnsiContainsText( sel.text, searchText );
  end;

  // Get the first item to search in a subtree (nil = whole tree)
  function getFirstItem( root: TTreeNode ): TTreeNode;
  var
    node: TTreeNode;
  begin
    Result := nil;
    case searchType of
      sstSearchNext, sstSearchInc:
        // Find the first node in the tree or sub-tree
        if Assigned( root ) then begin
          Result := root;
        end
        else
        if treeView.Items.GetFirstNode <> nil then
          Result := treeView.Items.GetFirstNode;
      sstSearchPrev:
        // Find the last node in the tree or sub-tree
        if Assigned( root ) then begin
          node := root;
          while node.HasChildren do
            node := node.GetLastChild;
          if Assigned( node ) then
            Result := node
        end else if treeView.Items.Count > 0 then begin
          Result := treeView.Items.Item[ treeView.Items.Count - 1 ];
        end;
    end;
  end;

   // Get the next item to check in the tree.  root is the root node for the entire search -
  // this is nil if a search of the entire tree is being performed.  start is the previous
  // item which was searched.  Returns nil if we walk off the start/end of the tree.
  function getNextItem( root, start: TTreeNode ): TTreeNode;
  var
    node: TTreeNode;
    ret: TTreeNode;
  begin
    ret := nil;

    case searchType of
      sstSearchNext, sstSearchInc:
        begin
          // Get the successor to the current node.
          node := start.GetNext;
          if Assigned( node ) then begin
            ret := node;
            if Assigned( root ) and ( Ord(ret.level) <= Ord(root.level) ) then
              ret := nil;
          end;
        end;
      sstSearchPrev:
        // Get the predeccessor to the current node.
        if start <> root then begin
          node := start.GetPrev;
          if Assigned( node ) then begin
            ret := node;
          end;
        end;
    end;
    Result := ret;
  end;

  // Perform a search of a sub-tree.  Returns true if a match is found, false otherwise.
  // if root is non-null, only the sub-tree root is searched.  start indicates where the
  // search should begin; it must not be nil.
  function searchSubTree( root, start: TTreeNode ): boolean;
  var
    item: TTreeNode;
  begin
    item := start;
    // Search tree until we find what we're after
    while (not hitFirstMatch) and Assigned( item ) do
    begin
      if (item = SearchNextFirstMatch) then
      begin
        if (SearchType = sstSearchNext) then
          hitFirstMatch := true
        else
          SearchNextFirstMatch := nil
      end;
      if (item = SearchPrevFirstMatch) then
      begin
        if (SearchType = sstSearchPrev) then
          hitFirstMatch := true
        else
          SearchPrevFirstMatch := nil
      end;

      if hitFirstMatch then
        Break;

      if selectionMatches( item ) then
      begin
        treeView.Select( item );
        Result := true;
        Exit;
      end;

      item := getNextItem( root, item );
    end;
    Result := false;
  end;
begin

  hitFirstMatch := False;

  searchText := SearchTextEdit.Text;
  if searchText = '' then
    Exit;

  restrictedSearch := RestrictSearchCheckBox.Checked and (RestrictSearchComboBox.ItemIndex >= 0);
  restrictedSearchLevel := 0;
  Inc( restrictedSearchLevel, RestrictSearchComboBox.ItemIndex );

  // Figure out sub-tree to search
  if SearchSelectedRadioButton.Checked then
    searchRoot := subTreeSearchRoot
  else
    searchRoot := nil;

  // Find the current position, i.e. the place we will search from.
  currentPos := nil;
  if (treeView.Selected <> nil) then begin
    currentPos := treeView.Selected;
  end;

  if Assigned( currentPos ) and (SearchType in [sstSearchNext,sstSearchPrev]) and
     selectionMatches( currentPos ) then
  begin
    if FFinishedSearch then begin
      // Clear start position unless we are actually on the start position
      // in which case we DO want to warn if we wrap round to the same place
      if (SearchType = sstSearchNext) and (currentPos <> SearchNextFirstMatch) then
        SearchNextFirstMatch := nil;
      if (SearchType = sstSearchPrev) and (currentPos <> SearchPrevFirstMatch) then
        SearchPrevFirstMatch := nil;
    end else begin
      // Remember where this search is starting so that we can warn when we're finished
      if (SearchType = sstSearchNext) and not Assigned(SearchNextFirstMatch) then
        SearchNextFirstMatch := currentPos;
      if (SearchType = sstSearchPrev) and not Assigned(SearchPrevFirstMatch) then
        SearchPrevFirstMatch := currentPos;
    end;
    // Start search at the next item
    currentPos := getNextItem( searchRoot, currentPos );
  end else begin
    // Don't remember where we started search - there will be no warning
    SearchNextFirstMatch := nil;
    SearchPrevFirstMatch := nil;
  end;

  // Ensure that we have a valid item to start the search from
  if not Assigned( currentPos ) then begin
    currentPos := getFirstItem( searchRoot );
    if not Assigned( currentPos ) then
      Exit;
  end;

  foundItem := searchSubTree( searchRoot, currentPos );
  if (not foundItem) and (not hitFirstMatch) then
    foundItem := searchSubTree( searchRoot, getFirstItem( searchRoot ) ); 

  treeView.HideSelection := not (foundItem or hitFirstMatch);
  FFinishedSearch := hitFirstMatch;   

  if hitFirstMatch then
    ShowMessage('No more matches found.')
  else if (not foundItem) and (searchType <> sstSearchInc) then
    ShowMessage('No matches found.');
end;

procedure TStructureTreeFrame.setSearchBox(activate : boolean);
begin

  SearchSelectedRadioButton.Enabled := activate;
  if treeView.Selected = nil then
     begin
       treeView.Selected := treeView.Items.GetFirstNode;
       SearchSelectedRadioButton.caption := 'Search '+ treeView.Selected.Text;
     end;

  SearchAllRadioButton.Enabled := activate;

  RestrictSearchCheckBox.enabled := activate;

  RestrictSearchComboBox.Enabled := false;
  SearchAllRadioButton.Checked := true;

  RestrictSearchCheckBox.checked := false;
end;

procedure TStructureTreeFrame.RestrictSearchCheckBoxClick(Sender: TObject);
begin
  RestrictSearchComboBox.Enabled := RestrictSearchCheckBox.Checked;
  SearchAllRadioButton.Checked := RestrictSearchCheckBox.Checked;
end;

procedure TStructureTreeFrame.SearchTextEditChange(Sender: TObject);
begin
  if SearchTextEdit.Text <> '' then
    SearchDiscoutItems(sstSearchInc);
end;

function TStructureTreeFrame.treeNodesChecked : boolean;
var
  i, j : integer;
begin
  j:=0;
  for i := 0 to selectableNodeList.Count - 1 do
    with TSelectableNode( selectableNodeList.Objects[i] ) do
    begin
      if Assigned( treeNode ) and
           ( TCheckImage( treeNode.ImageIndex ) in [ciChecked]) then
          j := j + 1;
    end;
    result := j > 0;
end;

procedure TStructureTreeFrame.treeViewCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
AllowCollapse := shouldAllowExpand( Node );
end;

procedure TStructureTreeFrame.treeViewExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  AllowExpansion := shouldAllowExpand( Node );
end;

procedure TStructureTreeFrame.suppressExpandNodeToggled( node : TTreeNode );
begin
  suppressExpandToggledNode := node;
  // If timer is running, then stop it - we've successfully prevented the expand.
  BlockExpansionTimer.Enabled := false;
end;

function TStructureTreeFrame.shouldAllowExpand( node : TTreeNode ) : boolean;
begin
  Result := node <> suppressExpandToggledNode;
  if not Result then
    // We've suppressed the expand.  Start the timer.
    BlockExpansionTimer.Enabled := true;
end;

procedure TStructureTreeFrame.BlockExpansionTimerTimer(Sender: TObject);
var
  expandNode : TTreeNode;
begin
  // Timer expired.  This means we suppressed an expand, but it turns out that the
  // expand wasn't caused by double-clicking on a checkbox.  we'd better do the
  // expand now.
  expandNode := suppressExpandToggledNode;
  suppressExpandToggledNode := nil;
  BlockExpansionTimer.Enabled := false;

  expandNode.Expanded := not expandNode.Expanded;
end;


end.
