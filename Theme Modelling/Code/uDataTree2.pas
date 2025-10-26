unit uDataTree2;

interface

uses comctrls, adodb, classes, contnrs, dialogs, types;

(*
  Todo:
    Refactor to include "NamesTable" in constructor. This data is currently
    accessed via "NamesArray", however is required in table form for the
    node search functionality. If other modules use the node search we should
    move this parameter to the constructor and consider building the array
    internally but with caching; i.e. do not build multiple arrays for the
    same dataset - this is the reason its application-managed at the moment.

    ABOVE: done, NamesArray was taking 5 seconds to generate for Big HO data.
    TODO: maybe refactor the Find and FindAll, etc. to use the same NamesQuery instead of a table name parameter

    Remove use of FindAllNodes/FindAllNext/FindAllPrev - they are not generic.


*)

type
  TSearchType = (sstSearchNext, sstSearchPrev);

  TFoundNode = packed record
    Level: integer;
    ID: integer;
  end;

  TDataTree = class(TObject)
  private
    SearchString: string;
    NamesTable: string;
    FoundNodeCount: integer;
    FoundNodeIDs: array of TFoundNode;
    FoundNodeIndex: integer;
    FindMaxLevel: integer;
    FindMinLevel: integer;
    FindItemIndex: integer;
    DistinctSelect: boolean;
    DataTable: string;
    HoverNode: TTreeNode;
    SourceTree: TTreeView;
    BackUpTree: TTreeView;
    Connection: TADOConnection;
    LevelList: TObjectList;
    Levels: TStrings;
    FoundNodesValid: boolean;
    ActiveSearchIsAllNodes: boolean;
    hasNoGoProds: boolean;
    hasCheckedProds: boolean;
    namesQuery: TADOQuery;

    procedure ExpandSingleNodes(RootNode: TTreeNode);
    procedure HandleTreeExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure HandleTreeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure AddChildren(Node: TTreeNode; Nodes: TTreeNodes = nil);
    function GetChildSQL(ParentLevel, ParentId: integer; orderByName: boolean): string;
    //function CreateSelectionTable: string;
    procedure LocateFindNode;
    function NearestFindNode(GoForward: boolean): integer;
    function NodeID(Node: TTreeNode): int64;
    function IntegerArrayContains(value: integer; var intArray: array of integer): boolean;
    procedure BackupSourceTree;
    procedure RestoreSourceTreeFromBackup;
    function GetMatchingNodeInTargetTree(TargetTree: TTreeView; SourceNode: TTreeNode) : TTreeNode;
    function EnsureMatchingNodeExistsInTargetTree(TargetTree: TTreeView; SourceNode: TTreeNode) : TTreeNode;
    function GetChildNodeWithId(treeView: TTreeView; parentNode: TTreeNode; const id: integer; const text: string; CreateChildNodeIfNecessary: boolean): TTreeNode;
    procedure EnsureChildrenExistInTargetTree(TargetTree: TTreeView; TargetNode, SourceNode: TTreeNode);
    procedure DeleteChildlessNodes(const level: integer);
    function SourceTreeHasDeletedNodes: boolean;
    function FilterHasBeenApplied: boolean;
    function GetFilterWhereConditions: string;
    function GetFilteredDataTableSQL: string;
    procedure DeleteNodesNotInFilter(const level: integer; const filteredIdsTable: string);
    function GetLeafIdsFromSourceTree(ParentNode: TTreeNode): TIntegerDynArray;
    function GetLeafIdsFromTargetTree(TargetTree: TTreeView; ParentNode: TTreeNode): TIntegerDynArray;
  public
    initialLoading : boolean;
    constructor Create(SourceTree: TTreeView; Connection: TAdoConnection; DataTable: string; NamesTable: string;
                       PartialLevels: boolean = False; hasNoGoProds: boolean = False; hasCheckedProds: boolean = False);
    procedure AddLevel(LevelName, HintSQL: string);
    function GetMaxLevel: integer;
    procedure Initialise;
    destructor Destroy; override;
//    procedure LoadFromTempTable(TargetTree: TTreeView; TableName: string; IDField: string);
//    function SaveToTempTable(TargetTree: TTreeView): string;
    procedure SelectItem(TargetTree: TTreeView; SourceNode: TTreeNode = nil);
    procedure DeselectItem(TargetTree: TTreeView);
    procedure SelectAll(TargetTree: TTreeView);
    procedure DeselectAll(TargetTree: TTreeView);

    procedure FindNodes(SearchString: string; NamesTable: string; MinLevel, MaxLevel: integer);
    procedure FindNext;
    procedure FindPrev;
    function GetLeafIdListFromSourceTree(parentNode: TTreeNode): TStringList;
    // This is deprecated but currently offers "search within a node" functionality that FindNodes doesn't
    procedure FindAllNodes(SearchString, NamesTable: string; indexLevel, itemIndex, ItemLevel : integer);

    procedure ApplyFilter(const level: integer; const filteredIdsTable: string);
    procedure ClearFilter(const level: integer);

    function TargetTreeContainsSelectedNodeLeafItems(TargetTree: TTreeView): boolean;
  end;

  TDataLevel = class(TObject)
    Name: string;
    HintSQL: string;
    FilterApplied: boolean;   //True if a filter has been applied to the items at this level using the ApplyFilter method.
    FilteredIdsTable: string; //Name of the database table containing the Aztec Ids that satisfy the filter.
    HasDeletedNodes: boolean;  //True if the current tree of expanded nodes has had nodes removed at this level by the
                              //ApplyFilter method. Note that HasDeletedNodes can be False when FilterApplied is True if
                              //none of the nodes which don't satisfy the filter have been expanded in the SourceTree yet.
    class function CreateLevel(Name, HintSQL: string): TDataLevel;
  end;

implementation

uses windows, useful, math, commctrl, sysutils, forms, controls, db, uOdbc2, uAztecDatabaseUtils;


{ TDataTree }

constructor TDataTree.Create(SourceTree: TTreeView; Connection:TADOConnection; DataTable: string; NamesTable: string;
                             PartialLevels: boolean = False; hasNoGoProds: boolean = False; hasCheckedProds: boolean = False);
begin
  inherited Create;
  self.SourceTree := SourceTree;
  self.Connection := Connection;
  Levels := TStringlist.create;
  LevelList := TObjectList.Create;
  self.DataTable := DataTable;
  self.NamesTable := NamesTable;
  self.hasNoGoProds := hasNoGoProds;
  self.hasCheckedProds := hasCheckedProds;

  // If a subset of levels in the "DataTable" levels cache are being used,
  // we set this flag so that distinct selects are used to select hidden
  // node levels (i.e. if the cache has multiple POS records and we input one
  // site node, this prevents the sales area IDs being duplicated, which would
  // cause a key violation)
  DistinctSelect := PartialLevels;
  FoundNodesValid := True;
  ActiveSearchIsAllNodes := False;

  BackUpTree := TTreeView.Create(SourceTree.Owner);
  BackUpTree.Visible := False;
  BackUpTree.Parent := SourceTree.Parent;

  NamesQuery := TADOQuery.Create(nil);
  NamesQuery.Connection := Connection;
  NamesQuery.SQL.Text := 'SELECT ID, Name FROM [' + NamesTable +']';
  NamesQuery.Open;
end;

procedure TDataTree.AddLevel(LevelName, HintSQL: string);
begin
  LevelList.Add(TDataLevel.CreateLevel(LevelName, HintSQL));
end;

procedure TDataTree.AddChildren(Node: TTreeNode; Nodes: TTreeNodes = nil);
var
  Statement, nName: string;
  DataSet: TADODataSet;
  NewNode: TTreeNode;
  ParentLevel: integer;
  NodeData: integer;
  NewNodesHaveChildren: boolean;
  SavedCursorState: TCursor;
  NodeImageIndex: integer;
begin
  if Assigned(Node) then
  begin
    NodeImageIndex := Node.ImageIndex; // this the parent's imageIndex, to give a check or un-check to its children
    ParentLevel := Node.Level;
  end
  else
  begin
    NodeImageIndex := 0;
    ParentLevel := -1;
  end;

  Statement := GetChildSQL(ParentLevel, NodeID(Node), True);

  DataSet := TADODataSet.Create(nil);
  try
    DataSet.CursorLocation := clUseClient;
    DataSet.CursorType := ctOpenForwardOnly;
    // use of {eoAsyncFetchNonBlocking} seems to cause the first record to be
    // lost some times...
    DataSet.Recordset := Connection.Execute(Statement, cmdText, []);

    if (DataSet.RecordCount > 0) then
    begin
      SavedCursorState := Screen.Cursor;
      with Screen do Cursor := crHourGlass;

      NewNodesHaveChildren := not(Assigned(Node) and (Node.Level+1 = Levels.Count-1));
      if Node <> Nil then
        Nodes := Node.Owner;

      Nodes.BeginUpdate;

      DataSet.First;
      while not(DataSet.Eof) do
      begin
        NodeData := DataSet.FieldByName('ID').AsInteger;
        if NamesQuery.Locate('ID', DataSet.FieldByName('Name').AsInteger, []) then
          nName := NamesQuery.FieldByName('Name').AsString
        else
          nName := '';

        NewNode := Nodes.AddNode(nil, Node, nName, TObject(NodeData), naAddChild);
        NewNode.HasChildren := NewNodesHaveChildren;

        NewNode.ImageIndex := NodeImageIndex; // the "Default" setting...

        if (hasNoGoProds or hasCheckedProds) then // NoGo and Checked fields should be there
        begin
          if ParentLevel = 2 then // for Products only
          begin
            if hasNoGoProds and DataSet.FieldByName('noGo').AsBoolean then
              NewNode.ImageIndex := 3
            else if initialLoading then
            begin
              if hasCheckedProds and (NodeImageIndex = 0) then  // only for unchecked Sub
                if DataSet.FieldByName('checked').AsBoolean then
                  NewNode.ImageIndex := 2;
            end;
          end;
        end;

        NewNode.SelectedIndex := NewNode.ImageIndex;

        while DataSet.Eof and (stFetching in DataSet.RecordsetState) do
          sleep(5);
        DataSet.Next;
      end;

      Nodes.EndUpdate;

      with Screen do Cursor := SavedCursorState;
    end
    else
    begin
      if Node <> Nil then Node.HasChildren := False;
    end;
  finally
    DataSet.Close;
    DataSet.Free;
  end;
end;

  // GetChildSQL(-1, b) produces the top level list of nodes
  // GetChildSQL(a, b), a >= 0, produces SQL to get a dataset of child Ids and Names for parent with Id of a at level b.
function TDataTree.GetChildSQL(ParentLevel, ParentId: integer; orderByName: boolean): string;
begin
  //Note: The redundant WHERE condition "1=1" is used to simplify the optional addition of further WHERE conditions.

  if (hasNoGoProds or hasCheckedProds) and (ParentLevel = 2) then // only for Products of Discounts...
    Result := Format('SELECT DISTINCT Level%0:dID as ID, Level%0:dName as Name, NoGo, checked FROM %1:s WHERE 1=1', [ParentLevel+2, DataTable])
  else
    Result := Format('SELECT DISTINCT Level%0:dID as ID, Level%0:dName as Name FROM %1:s WHERE 1=1', [ParentLevel+2, DataTable]);

  if ParentLevel > -1 then
    Result := Result + Format(' AND Level%0:dID = %1:d', [ParentLevel+1, ParentId]);

  Result := Result + GetFilterWhereConditions;

  if orderByName then
    Result := Result + ' ORDER BY NAME';
end;


procedure TDataTree.Initialise;
var
  i: integer;
begin
  initialLoading := True;
  Levels.Clear;
  for i := 0 to pred(LevelList.Count) do
  begin
    if LevelList.Items[i] is TDataLevel then
      Levels.AddObject(TDataLevel(LevelList.Items[i]).Name, LevelList[i]);
  end;

  SourceTree.Items.Clear;
  SourceTree.OnExpanding := Self.HandleTreeExpanding;
  SourceTree.OnMouseMove := Self.HandleTreeMouseMove;
  SourceTree.ShowHint := true;
  SourceTree.ReadOnly := true;
  SourceTree.HideSelection := FALSE;

  if Levels.count > 0 then
    AddChildren(nil, SourceTree.Items);

  ExpandSingleNodes(SourceTree.items.GetFirstNode);
end;

destructor TDataTree.Destroy;
begin
  NamesQuery.close;
  NamesQuery.Free;
  BackUpTree.Free;
  LevelList.Free;
  Levels.Free;
  inherited;
end;

procedure TDataTree.HandleTreeExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  if Node.HasChildren and (Node.getFirstChild = nil) then
  begin
     AddChildren(Node);

    //If a filter has been applied at the level of this nodes children we must now assume that some nodes
    //at this level may have been deleted.
    with TDataLevel(LevelList[Node.Level + 1]) do
      HasDeletedNodes := HasDeletedNodes or FilterApplied;
  end;
end;


procedure TDataTree.HandleTreeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  CurrentHoverNode: TTreeNode;
  Statement, DBFetchedHint: string;
  DataSet: TADODataSet;
begin
  CurrentHoverNode := TTreeView(Sender).GetNodeAt(X,Y);
  if CurrentHoverNode <> nil then
  begin
    if CurrentHoverNode <> HoverNode then
    with TDataLevel(Levels.Objects[CurrentHoverNode.Level]) do
    begin
      if HintSQL <> '' then
      begin
        Statement := Format(HintSQL, [Integer(CurrentHoverNode.Data)]);
        DataSet := TADODataSet.Create(nil);
        DataSet.Recordset := Connection.Execute(Statement, cmdText, []);
        if Length(Trim(DataSet.FieldByName('Hint').AsString)) = 0 then
          DBFetchedHint := ''
        else
          DBFetchedHint := ' / '+Trim(DataSet.FieldByName('Hint').AsString);
        DataSet.Close;
        DataSet.Free;
      end
      else
        DBFetchedHint := '';
      TTreeView(Sender).Hint := Levels.Strings[CurrentHoverNode.level] + ': ' +CurrentHoverNode.text + DBFetchedHint;
    end;
  end;

end;

//procedure TDataTree.LoadFromTempTable(TargetTree: TTreeView; TableName: string; IDField: string);
//var
//  Statement, nName: string;
//  i: integer;
//  ADOQuery: TADOQuery;
//  NodeID: array of integer;
//  NewNodeID: array of integer;
//  ParentLevel, NewLevel: integer;
//  ParentStack: TStack;
//  NodeText: string;
//  NewNode: TTreeNode;
//begin
//  // join TableName field IDField to max level ID in source table
//
//  // Main bottleneck is the TreeView load.
//  // This has been sped up as much as possible
//
//  // nodes ordered by name then ID at each level, so nodes can be read in
//  // depth first order, sorted by name
//
//  Statement := Format('SELECT b.* FROM %s a '+
//    'JOIN %s b '+
//    'ON a.%s = b.Level%dID '+
//    'ORDER BY ', [TableName, DataTable, IDField, Levels.Count]);
//  for i := 1 to Levels.Count do
//    Statement := Statement + Format('b.Level%0:dName, b.Level%0:dID, ', [i]);
//  Statement := Copy(Statement, 1, Length(Statement)-2);
//
//  ADOQuery := TADOQuery.Create(nil);
//  ADOQuery.Connection := Connection;
//
//  ADOQuery.CursorType := ctOpenForwardOnly;
//
//  ADOQuery.SQL.Text := Statement;
//  ParentStack := TStack.Create;
//  try
//    ADOQuery.Open;
//
//    TargetTree.Items.BeginUpdate;
//    TargetTree.Items.Clear;
//
//    ParentStack.Push(nil);
//    SetLength(NewNodeID, Levels.Count);
//    SetLength(NodeID, Levels.Count);
//
//    for i := low(NodeId) to high(NodeId) do
//      NodeId[i] := -1;
//
//    ParentLevel := -1;
//
//    // Build tree from flat table
//    ADOQuery.First;
//    while not ADOQuery.Eof do
//    begin
//      for i := 0 to Levels.Count-1 do
//        NewNodeID[i] := ADOQuery.Fields[i].Value;
//      for i := 0 to Levels.Count-1 do
//      begin
//        if NewNodeID[i] <> NodeID[i] then
//        begin
//          NewLevel := i;
//
//        if NamesQuery.Locate('ID', ADOQuery.FieldByName(Format('Level%dname', [NewLevel+1])).AsInteger, []) then
//          nName := NamesQuery.FieldByName('Name').AsString
//        else
//          nName := '';
//
//
//          NodeText := nName;
//
//          while ParentLevel > (NewLevel-1) do
//          begin
//            ParentStack.Pop;
//            ParentLevel := ParentLevel - 1;
//          end;
//
//          NewNode := TargetTree.Items.AddChildObject(ParentStack.Peek, NodeText, TObject(NewNodeID[NewLevel]));
//
//          if NewLevel < Levels.Count-1 then
//          begin
//            ParentStack.Push(NewNode);
//            ParentLevel := ParentLevel + 1;
//          end;
//
//          NodeID[NewLevel] := NewNodeID[NewLevel];
//
//        end;
//      end;
//      ADOQuery.Next;
//    end;
//
//    ADOQuery.Close;
//
//    ExpandSingleNodes(TargetTree.Items.GetFirstNode);
//    TargetTree.Items.EndUpdate;
//  finally
//    ADOQuery.Free;
//    ParentStack.Free;
//  end;
//end;
//
//function TDataTree.SaveToTempTable(TargetTree: TTreeView): string;
//var
//  Projector: string;
//  TableName, FileName: string;
//  DataStream: TStringStream;
//  FileStream: TFileStream;
//  i,j: integer;
//  TmpLevel: integer;
//  BlankLine, CurLine: string;
//  ADOCommand: TADOCommand;
//begin
//  FileName :=  useful.GetTempDir + 'TDataTree_'+inttostr(GetTickCount);
//  TableName := CreateSelectionTable;
//
//  // Populate file from tree
//  DataStream := TStringStream.Create('');
//  //  BlankLine := StringOfchar(#9, Levels.count)+#13#10;
//  BlankLine := StringReplace(StringOfchar(#9, Levels.count), #9, '0'#9, [rfReplaceAll])+'0'#13#10;
//
//  for i := 0 to Pred(TargetTree.items.Count) do
//  begin
//    if TargetTree.Items[i].getFirstChild = nil then
//    begin
//      CurLine := BlankLine;
//      TmpLevel := TargetTree.Items[i].Level+1;
//      // Its a sparse table in tab delimited format
//      // So insert the data field at the relevant position in an
//      // empty tab-separated line.
//      Insert(IntToStr(Integer(TargetTree.Items[i].Data)), CurLine, 2*(TmpLevel+1));
//      // insert the level number at the start
//      Insert(IntToStr(TmpLevel), Curline, 2);
//      DataStream.WriteString(CurLine);
//    end;
//  end;
//
//  if FileExists(FileName) then
//    DeleteFile(FileName);
//
//  DataStream.Seek(0, soFromBeginning);
//  FileStream := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
//  FileStream.CopyFrom(DataStream, DataStream.Size);
//  FileStream.Free;
//  DataStream.Free;
//
//  // Populate table using BCP data file
//
//  with TOdbcBulkCopy.Create(nil) do try
//    Connection := TOdbcConnection.Create(nil);
//    connection.AdoConnectionString := uAztecDatabaseUtils.GetSysAdminAztecDBConnectionString;
//    Connection.Open;
//    BulkCopyMode := bcmClipExport;
//    Query := TableName;
//    OutputFile := FileName;
//    ExecuteIn(nil);
//  finally
//    Connection.Close;
//    Connection.Free;
//    Free;
//  end;
//
//  if FileExists(FileName) then
//    DeleteFile(FileName);
//
//  // Render data into leaf nodes
//
//  ADOCommand := TADOCommand.Create(nil);
//  ADOCommand.Connection := Connection;
//
//  try
//    Projector := '';
//    for i := 1 to Levels.Count-1 do
//    begin
//      Projector := Projector + Format('b.Level%dID, ', [i]);
//    end;
//
//    ADOCommand.CommandText := Format(
//      ' update a set ', [TableName]);
//    for i := 1 to Levels.Count - 1 do
//    begin
//      ADOCommand.CommandText := ADOCommand.CommandText + Format('a.Level%0:dID = b.Level%0:dID, ', [i])
//    end;
//    ADOCommand.CommandText :=  ADOCommand.CommandText
//                             + Format(   'a.Level%1:dID = b.Level%1:dID '
//                                       + 'from %0:s a '
//                                       + 'join %2:s b '
//                                       + 'on a.level = %1:d and a.Level%1:dID = b.Level%1:dID ',
//                               [TableName, Levels.Count, DataTable]);
//    ADOCommand.Execute;
//
//    for j := Levels.Count-1 downto 1 do
//    begin
//      ADOCommand.CommandText := Format(
//        'insert %0:s select %1:d, %2:s b.Level%1:dID '+
//        'from %0:s a '+
//        'join %3:s b on a.level = %4:d and a.Level%4:dID = b.Level%4:dID ',
//        [TableName, Levels.Count, Projector, DataTable, j]);
//      if DistinctSelect then
//        ADOCommand.CommandText := StringReplace(ADOCommand.CommandText, 'select', 'select distinct', []);
//      ADOCommand.Execute;
//      ADOCommand.CommandText := Format('delete from %s where Level = %d', [TableName, j]);
//      ADOCommand.Execute;
//    end;
//    Result := TableName;
//  finally
//    ADOCommand.Free;
//  end;
//end;

function TDataTree.GetFilteredDataTableSQL: string;
begin
  if FilterHasBeenApplied then
    Result := '(SELECT * FROM ' + DataTable + ' WHERE 1=1' + GetFilterWhereConditions + ')'
  else
    Result := DataTable;
end;

//Create a SQL WHERE condition for each level in the tree that has a filter applied.
function TDataTree.GetFilterWhereConditions: string;
var level: integer;
begin
  for level := 0 to LevelList.Count - 1 do
  begin
    with TDataLevel(LevelList[level]) do
      if FilterApplied then
        Result := Result + Format(' AND Level%0:dID IN (SELECT Id FROM ',[level+1])  + FilteredIdsTable + ')';
  end;
end;

function TDataTree.NodeID(Node: TTreeNode): int64;
begin
  if Assigned(Node) then
  begin
    Result := Integer(Node.Data);
  end
  else
    Result := 0;
end;

//function TDataTree.CreateSelectionTable: string;
//var
//  ADOQuery: TADOQuery;
//  TableName, DMLFields, KeyFields: string;
//  i: integer;
//  Statement: string;
//begin
//  ADOQuery := TADOQuery.Create(nil);
//  ADOQuery.Connection := Connection;
//  ADOQuery.SQL.Text := 'SELECT @@SPID';
//  ADOQuery.Open;
//  TableName := Format('##TDataTree_%s_%u', [ADOQuery.Fields[0].AsString, GetTickCount]);
//  ADOQuery.Close;
//  ADOQuery.Free;
//  // create table dynamically to hold sparse table of tree contents
//  DMLFields := 'Level int not null, ';
//  KeyFields := '';
//  for i := 0 to pred(Levels.Count) do
//  begin
//    DMLFields := DMLFields + Format('[Level%dID] int not null', [i+1]);
//    if i < pred(Levels.count) then
//      DMLFields := DMLFields + ', ';
//    KeyFields := KeyFields + Format('[Level%dID]', [i+1]);
//    if i < pred(Levels.count) then
//      KeyFields := KeyFields + ', ';
//  end;
//
//  Statement := Format('CREATE TABLE %s (%s, primary key (%s))', [TableName, DMLFields, KeyFields]);
//  Connection.Execute(Statement);
//  Result := TableName;
//end;

{ TRelHierarchyLevel }

class function TDataLevel.CreateLevel(Name, HintSQL: string): TDataLevel;
begin
  result := TDataLevel.Create;
  result.Name := Name;
  result.HintSQL := HintSQL;
  result.FilterApplied := False;
  result.FilteredIdsTable := '';
  result.HasDeletedNodes := False;
end;

procedure TDataTree.DeselectAll(TargetTree: TTreeView);
begin
  TargetTree.Items.BeginUpdate;
  TargetTree.Items.Clear;
  TargetTree.Items.EndUpdate;
end;

procedure TDataTree.DeselectItem(TargetTree: TTreeView);
var
  TmpParent, TmpParent2: TTreeNode;
begin
  if not Assigned(TargetTree.Selected) then exit;
  TargetTree.Items.BeginUpdate;
  TmpParent := TargetTree.Selected.Parent;
  TargetTree.Items.Delete(TargetTree.Selected);
  // recurse up the way removing blank parent nodes
  while assigned(TmpParent) and (TmpParent.getFirstChild = nil) do
  begin
    TmpParent2 := TmpParent.Parent;
    TargetTree.Items.Delete(TmpParent);
    TmpParent := TmpParent2;
  end;
  TargetTree.Items.EndUpdate;
end;

//Add a items available in the SourceTree to the given TTreeView. So if the SourceTree is filtered only the filtered items
//will be added. All existing items in the given TTreeView are preserved.
procedure TDataTree.SelectAll(TargetTree: TTreeView);
var
 SelectedNode, TopLevelNode: TTreeNode;

begin
  SelectedNode := SourceTree.Selected;

  TargetTree.Items.BeginUpdate;
  SourceTree.Items.BeginUpdate;

  try
    TopLevelNode := SourceTree.Items.GetFirstNode;

    while Assigned(TopLevelNode) do
    begin
      SelectItem(TargetTree, TopLevelNode);
      TopLevelNode := TopLevelNode.GetNextSibling;
    end;

    SourceTree.FullCollapse;
    if Assigned(SelectedNode) then
      SourceTree.Selected := SelectedNode
    else
      ExpandSingleNodes(SourceTree.Items.GetFirstNode);

    ExpandSingleNodes(TargetTree.Items.GetFirstNode);
  finally
    TargetTree.Items.EndUpdate;
    SourceTree.Items.EndUpdate;
  end;
end;

//Return the node from the TargetTree that matches the given SourceTree node, if it exists.
function TDataTree.GetMatchingNodeInTargetTree(TargetTree: TTreeView; SourceNode: TTreeNode) : TTreeNode;
var targetParent: TTreeNode;
begin
  targetParent := nil;
  if SourceNode.Parent <> nil then
  begin
    targetParent := GetMatchingNodeInTargetTree(TargetTree, SourceNode.parent);
    if targetParent = nil then
    begin
      Result := nil;
      Exit;
    end;
  end;

  Result := GetChildNodeWithId(TargetTree, targetParent, Integer(SourceNode.Data), SourceNode.Text, False);
end;

//Ensure the given node from the SourceTree exists in the given TargetTree, creating one if necessary.
//The corresponding TargetTree node is returned.
function TDataTree.EnsureMatchingNodeExistsInTargetTree(TargetTree: TTreeView; SourceNode: TTreeNode) : TTreeNode;
var targetParent: TTreeNode;
begin
  targetParent := nil;
  if SourceNode.Parent <> nil then
    targetParent := EnsureMatchingNodeExistsInTargetTree(TargetTree, SourceNode.parent);

  Result := GetChildNodeWithId(TargetTree, targetParent, Integer(SourceNode.Data), SourceNode.Text, True);
end;


function TDataTree.GetChildNodeWithId(
  TreeView: TTreeView;
  ParentNode: TTreeNode;
  const Id: integer;
  const Text: string;
  CreateChildNodeIfNecessary: boolean): TTreeNode;
var
  childNode: TTreeNode;
begin
  Result := nil;

  if ParentNode = nil then
    childNode := treeView.Items.GetFirstNode
  else
    childNode := parentNode.getFirstChild;

  while Assigned(childNode) do
  begin
    if Integer(childNode.Data) = id then
    begin
      Result := childNode;
      Break;
    end;

    childNode := childNode.GetNextSibling;
  end;

  if (Result = nil) and CreateChildNodeIfNecessary then
    Result := TreeView.Items.AddChildObject(parentNode, text, TObject(id));
end;

//Ensure the descendant nodes of the given SourceTree node (SourceNode) exist in the given target tree node (TargetNode)
//The descendant nodes are created if necessary.
procedure TDataTree.EnsureChildrenExistInTargetTree(TargetTree: TTreeView; TargetNode, SourceNode: TTreeNode);
var sourceChild, targetChild: TTreeNode;
begin
  SourceNode.Expand(False);
  sourceChild := SourceNode.getFirstChild;
  while sourceChild <> nil do
  begin
    targetChild := GetChildNodeWithId(TargetTree, TargetNode, Integer(sourceChild.Data), sourceChild.Text, True);

    EnsureChildrenExistInTargetTree(TargetTree, targetChild, sourceChild);

    sourceChild := sourceChild.GetNextSibling;
  end;
end;

procedure TDataTree.SelectItem(TargetTree: TTreeView; SourceNode: TTreeNode = nil);
var
 TargetNode: TTreeNode;
 SelectedNode: TTreeNode;
 SavedCursorState: TCursor;
begin
  if not Assigned(SourceTree.Selected) and not Assigned(SourceNode) then exit;

  SavedCursorState := Screen.Cursor;
  with Screen do Cursor := crHourGlass;

  try
    SelectedNode := SourceTree.Selected;

    if SourceNode = nil then
      SourceNode := SelectedNode;

    TargetTree.Items.BeginUpdate;
    SourceTree.Items.BeginUpdate;

    try
      TargetNode := EnsureMatchingNodeExistsInTargetTree(TargetTree, SourceNode);
      EnsureChildrenExistInTargetTree(TargetTree, TargetNode, SourceNode);

      SourceTree.FullCollapse;
      ExpandSingleNodes(SourceTree.Items.GetFirstNode);

      if Assigned(SelectedNode) then
      begin
        //Make sure the next sibling of the selected node, if there is one, is selected and visible in the source tree.
        if SelectedNode.getNextSibling <> nil then
          SourceTree.Selected :=  SelectedNode.getNextSibling
        else
          SourceTree.Selected := SelectedNode;

        SourceTree.Selected.MakeVisible;
      end;

      //Make sure the node we have just added is shown in the correct position.
      if TargetNode.Parent = nil then
        TargetTree.Items.AlphaSort(true)
      else
        TargetNode.Parent.AlphaSort(true);

      //Make sure the node we have just added is visible in the target tree
      TargetTree.FullCollapse;
      ExpandSingleNodes(TargetTree.Items.GetFirstNode);
      TargetTree.Selected := TargetNode;
      TargetTree.Selected.MakeVisible;
    finally
      TargetTree.Items.EndUpdate;
      SourceTree.Items.EndUpdate;
    end;
  finally
    with Screen do Cursor := SavedCursorState;
  end;
end;

procedure TDataTree.ExpandSingleNodes(RootNode: TTreeNode);
var
  TempNode: TTreeNode;
begin
  // Expand all single child nodes starting at the root
  TempNode := RootNode;
  while Assigned(TempNode) do
  begin
    if (TempNode.GetNextSibling = nil) then
      TempNode.Expand(false);
    TempNode := TempNode.getFirstChild;
  end;
end;

procedure TDataTree.FindNodes(SearchString, NamesTable: string; MinLevel, MaxLevel: integer);
var
  AdoQuery: TAdoQuery;
  i,j: integer;
  OrderStr: string;
  NodeFields: string;
begin
  FindMinLevel := MinLevel;
  FindMaxLevel := MaxLevel;
  if Length(Trim(SearchString)) = 0 then
  begin
    FoundNodeIndex := -1;
    FoundNodeCount := 0;
    SetLength(FoundNodeIDs, FoundNodeCount);
    exit;
  end;

  OrderStr := '';
  for i := MinLevel + 1 to MaxLevel+1 do
    OrderStr := OrderStr + Format('Level%dName, Level%dID, ', [i, i]);
  OrderStr := Copy(OrderStr, 1, Length(OrderStr)-2);
  AdoQuery := TAdoQuery.Create(nil);
  AdoQuery.Connection := Connection;

  AdoQuery.SQL.Text := '';

  for i := FindMinLevel to FindMaxLevel do
  begin
    NodeFields := '';
    for j := FindMinLevel to i do
      NodeFields := NodeFields + Format(
        'Level%0:dID, Level%0:dName, ', [j+1]
      );
    for j := i+1 to MaxLevel do
      NodeFields := NodeFields + Format(
        '-1 as Level%0:dID, -1 as Level%0:dName, ', [j+1]
      );
    NodeFields := Copy(NodeFields, 1, Length(NodeFields)-2);

    AdoQuery.SQL.Add(
        Format(
        'select distinct %0:d as Level, %4:s from %1:s a '+
        'where Level%0:dName in (select ID from %2:s where Name like %3:s)',
        [i+1, GetFilteredDataTableSQL, NamesTable, QuotedStr('%'+SearchString+'%'), NodeFields]
      )
    );
    if i < MaxLevel then
      AdoQuery.SQL.Add('union');
  end;
  AdoQuery.SQL.Add('order by '+OrderStr);

  AdoQuery.Open;
  FoundNodeIndex := -1;
  FoundNodeCount := AdoQuery.RecordCount;
  SetLength(FoundNodeIDs, FoundNodeCount);
  i := Low(FoundNodeIDs);
  while not AdoQuery.Eof do
  begin
    FoundNodeIDs[i].Level := AdoQuery.FieldByName('Level').AsInteger;
    FoundNodeIDs[i].ID := AdoQuery.FieldByName(Format('Level%dID', [FoundNodeIDs[i].Level])).AsInteger;
    AdoQuery.Next;
    inc(i);
  end;
  AdoQuery.Close;
  AdoQuery.Free;

  self.SearchString := SearchString;
  self.NamesTable := NamesTable;
  FoundNodesValid := True;
  ActiveSearchIsAllNodes := False;

  if FoundNodeCount = 0 then
    raise Exception.Create('No items found matching "'+SearchString+'".');
end;

procedure TDataTree.FindNext;
begin
  // If something has invalidated the current set of "Found nodes", e.g. a filter has been applied/removed, we must
  // re-apply the search conditions.
  if not FoundNodesValid then
    if ActiveSearchIsAllNodes then
      FindAllNodes(SearchString, NamesTable, FindMaxLevel,  FindItemIndex, FindMinLevel)
    else
      FindNodes(SearchString, NamesTable, FindMinLevel, FindMaxLevel);

  if FoundNodeCount = 0 then
    Exit;

  if (not Assigned(SourceTree.Selected)) or ((FoundNodeIndex <> -1)
      and (Integer(SourceTree.Selected.Level+1) = FoundNodeIDs[FoundNodeIndex].Level)
    and (Integer(SourceTree.Selected.Data) = FoundNodeIDs[FoundNodeIndex].ID)) then
  begin
    // If we are on a node already "found" by FindNext/FindPrev, move to the next
    // on the list
    inc(FoundNodeIndex);
    if FoundNodeIndex > Pred(FoundNodeCount) then
      FoundNodeIndex := 0;
  end
  else
    // We are not on a found node, so look up the nearest
    FoundNodeIndex := NearestFindNode(True);

  LocateFindNode;
end;

procedure TDataTree.FindPrev;
begin
  // If something has invalidated the current set of "Found nodes", e.g. a filter has been applied/removed, we must
  // re-apply the search conditions.
  if not FoundNodesValid then
    if ActiveSearchIsAllNodes then
      FindAllNodes(SearchString, NamesTable, FindMaxLevel,  FindItemIndex, FindMinLevel)
    else
      FindNodes(SearchString, NamesTable, FindMinLevel, FindMaxLevel);

  if FoundNodeCount = 0 then
    Exit;

  if (not Assigned(SourceTree.Selected)) or ((FoundNodeIndex <> -1)
    and (Integer(SourceTree.Selected.Level+1) = FoundNodeIDs[FoundNodeIndex].Level)
    and (Integer(SourceTree.Selected.Data) = FoundNodeIDs[FoundNodeIndex].ID)) then
  begin
    dec(FoundNodeIndex);
    if FoundNodeIndex < 0 then
      FoundNodeIndex := Pred(FoundNodeCount);
  end
  else
    FoundNodeIndex := NearestFindNode(False);

  LocateFindNode;
end;

procedure TDataTree.LocateFindNode;
var
  AdoQuery: TADOQuery;
  i: integer;
  NodeRef: TTreeNode;
  procedure LocateNode(NodeID: integer);
  var
    SearchNode: TTreeNode;
  begin
    if NodeRef = nil then
      SearchNode := Self.SourceTree.Items.GetFirstNode
    else
      SearchNode := NodeRef.GetFirstChild;
    while Assigned(SearchNode) and (Integer(SearchNode.Data) <> NodeID) do
      SearchNode := SearchNode.getNextSibling;
    NodeRef := SearchNode;
  end;
begin
  if FoundNodeCount <> 0 then
  begin
    SourceTree.Items.BeginUpdate;
    AdoQuery := TAdoQuery.Create(nil);
    AdoQuery.Connection := Connection;
    AdoQuery.SQL.Text :=
      Format('select * '+
        'from %s a '+
        'where Level%dID = %d ', [GetFilteredDataTableSQL, FoundNodeIDs[FoundNodeIndex].Level, FoundNodeIDs[FoundNodeIndex].ID]);
    AdoQuery.Open;
    NodeRef := nil;
    if AdoQuery.RecordCount > 0 then
      for i := 1 to FoundNodeIDs[FoundNodeIndex].Level do
      begin
        LocateNode(AdoQuery.FieldByName(Format('Level%dID', [i])).AsInteger);
        if i < FoundNodeIDs[FoundNodeIndex].Level then
          NodeRef.Expand(false);
      end;

    if Assigned(NodeRef)
      and (NodeRef.Level+1 = FoundNodeIDs[FoundNodeIndex].Level)
      and (Integer(NodeRef.Data) = FoundNodeIDs[FoundNodeIndex].ID) then
    begin
      SourceTree.Selected := NodeRef;
      NodeRef.MakeVisible;
    end;

    AdoQuery.Close;
    AdoQuery.Free;
    SourceTree.Items.EndUpdate;
  end;
end;

function TDataTree.NearestFindNode(GoForward: boolean): integer;
var
  ADOQuery: TADOQuery;
  SelectedItemData: array of integer;
  SelectedItemNames: array of integer;
  SelectedNameFields: string;
  SelectedIDCheck: string;
  OrderStr: string;
  NodeFields: string;
  TmpStr: string;
  i,j: integer;
  TempNode: TTreeNode;
  FoundNodeLevel, FoundNodeID: integer;
  CompareOp: string;
  FindLevel: integer;
begin
  // This function is called when we don't have a position in the search results
  Result := 0;

  if not assigned(SourceTree.Selected) then
    exit;

  // first scan the search results to see if we are on one
  for i := 0 to FoundNodeCount-1 do
  begin
    if (FoundNodeIDs[i].Level = SourceTree.Selected.Level+1)
      and (FoundNodeIDs[i].ID = Integer(SourceTree.Selected.Data)) then
    begin
      if GoForward then
        result := (i+1) mod FoundNodeCount
      else
        result := (i+(FoundNodeCount-1)) mod FoundNodeCount;
      exit;
    end;
  end;

  // do a database search for the nearest search result at any level
  ADOQuery := TADOQuery.Create(nil);
  ADOQuery.Connection := Connection;

  SetLength(SelectedItemData, Levels.Count);
  SetLength(SelectedItemNames, Levels.Count);
  TempNode := SourceTree.Selected;
  SelectedNameFields := '';
  SelectedIDCheck := '';
  while assigned(TempNode) do
  begin
    SelectedItemData[TempNode.Level] := Integer(TempNode.Data);
    SelectedNameFields := Format('Level%dName, ', [TempNode.Level+1]) + SelectedNameFields;
    SelectedIDCheck := SelectedIDCheck + Format('Level%dID = %d and ', [TempNode.Level+1, Integer(TempNode.Data)]);
    TempNode := TempNode.Parent;
  end;
  for i := SourceTree.Selected.Level+1 to Levels.Count-1 do
  begin
    SelectedItemData[i] := -1;
    SelectedNameFields := SelectedNameFields + Format('-1 as Level%dName, ', [i+1]);
  end;
  SelectedNameFields := Copy(SelectedNameFields, 1, Length(SelectedNameFields)-2);
  SelectedIDCheck := Copy(SelectedIDCheck, 1, Length(SelectedIDCheck)-4);

  ADOQuery.SQL.Text := Format('select distinct %0:s from %1:s a where %s',
    [SelectedNameFields, GetFilteredDataTableSQL, SelectedIDCheck
  ]);
  ADOQuery.Open;

  for i := 0 to pred(Levels.Count) do
  begin
    SelectedItemNames[i] := ADOQuery.FieldByName(Format('Level%dName', [i+1])).AsInteger;
  end;

  AdoQuery := TAdoQuery.Create(nil);
  try
    AdoQuery.Connection := Connection;
    // This code originally had a top 1 clause here, but this seems
    // (paradoxically) to take longer to query. Probably could
    // be fixed with better keys on the data/name lookup tables.
    AdoQuery.SQL.Text := 'select * from (';

    // Rebuild a unioned dataset for all search hits. This is only required
    // when syncing to the search results; when a search result is selected,
    // the in-memory cache of found nodes makes FindNext/FindPrev much faster.
    for i := FindMinLevel to FindMaxLevel do
    begin
      NodeFields := '';
      // Fetch data and name ID from the data temp table.
      for j := 0 to i do
        NodeFields := NodeFields + Format(
          'Level%0:dID, Level%0:dName, ', [j+1]
        );
      // Return -1 in place of a name ID for when upper level nodes are selected
      for j := i+1 to GetMaxLevel do
        NodeFields := NodeFields + Format(
          '-1 as Level%0:dID, -1 as Level%0:dName, ', [j+1]
        );
      NodeFields := Copy(NodeFields, 1, Length(NodeFields)-2);

      // Cross tabulate search hits for all levels
      AdoQuery.SQL.Add(
        Format(
          'select %0:d as Level, %4:s '+
          'from %1:s a '+
          'where Level%0:dName in (select ID from %2:s where Name like %3:s)',
          [i+1, GetFilteredDataTableSQL, NamesTable, QuotedStr('%'+SearchString+'%'), NodeFields]
        )
      );
      if i < FindMaxLevel then
        AdoQuery.SQL.Add('union');
    end;
    ADOQuery.SQL.Add(') sub ');
    ADOQuery.SQL.Add('where');

    FindLevel := SourceTree.Selected.Level;

    if GoForward then
      CompareOp := '>'
    else
      CompareOp := '<';

    // This bit builds the check for a breadth first search that is
    // sorted on the names of nodes at each level. Takes advantage of the
    // fact that the Name IDs are allocated in alphabetical order.

    // There is a tiny bug here in that it should compare Data IDs when
    // name IDs are identical, I figured this was rarely required to justify
    // any extra complexity.
    TmpStr := '(';
    for i := 0 to FindLevel do
    begin
      TmpStr := TmpStr + '(';
      for j := 0 to i do
      begin
        if j = i then
        begin
          // I think this is the only case that needs '>=' (!)
          if GoForward and (j = FindLevel) then
            TmpStr := TmpStr + Format('Level%dName %s= %d and ', [j+1, CompareOp, SelectedItemNames[j]])
          else
            TmpStr := TmpStr + Format('Level%dName %s %d and ', [j+1, CompareOp, SelectedItemNames[j]]);
        end
        else
          TmpStr := TmpStr + Format('Level%dName = %d and ', [j+1, SelectedItemNames[j]])
      end;
      TmpStr := Copy(TmpStr, 1, Length(TmpStr)-Length('and '));
      TmpStr := TmpStr + ') or '
    end;
    TmpStr := Copy(TmpStr, 1, Length(TmpStr)-Length(' or '));
    TmpStr := TmpStr + ')';
    ADOQuery.SQL.Add(TmpStr);

    // Build order list so that the first result is the one we're after
    OrderStr := '';
    for i := 0 to Levels.Count-1 do
      if GoForward then
        OrderStr := OrderStr + Format('Level%dName asc, Level%dID asc, ', [i+1, i+1])
      else
        OrderStr := OrderStr + Format('Level%dName desc, Level%dID desc, ', [i+1, i+1]);

    OrderStr := Copy(OrderStr, 1, Length(OrderStr)-2);

    ADOQuery.SQL.Add(Format('order by %s', [OrderStr]));

    // Open the query to find the next search hit
    ADOQuery.Open;

    if ADOQuery.RecordCount = 0 then
    begin
      // No nodes found, so wrap search around to first or last result
      if GoForward then
        Result := 0
      else
        Result := FoundNodeCount-1;
    end
    else
    begin
      FoundNodeLevel := AdoQuery.FieldByName('Level').AsInteger;
      FoundNodeID := AdoQuery.FieldByName(Format('Level%dID', [FoundNodeLevel])).AsInteger;

      for i := 0 to Pred(FoundNodeCount) do
      begin
        if (FoundNodeIDs[i].Level = FoundNodeLevel)
          and (FoundNodeIDs[i].ID = FoundNodeID) then
        begin
          result := i;
          break;
        end;
      end;
    end;

    ADOQuery.Close;
  finally
    ADOQuery.Free;
  end;
end;

function TDataTree.GetMaxLevel: integer;
begin
  result := Levels.Count-1;
end;

procedure TDataTree.FindAllNodes(SearchString: string; NamesTable: string; indexLevel, itemIndex, ItemLevel : integer);
var
  AdoQuery: TAdoQuery;
  i,j: integer;
  OrderStr: string;
  NodeFields, SelectNodeFields: string;
begin
  FindMinLevel := ItemLevel;
  FindMaxLevel := indexLevel;
  FindItemIndex := itemIndex;

  if FindMinLevel > FindMaxLevel then
     raise Exception.Create('No items found matching "'+SearchString+'".');

  if Length(Trim(SearchString)) = 0 then
  begin
    FoundNodeIndex := -1;
    FoundNodeCount := 0;
    SetLength(FoundNodeIDs, FoundNodeCount);
    exit;
  end;

  OrderStr := '';
  for i := ItemLevel + 1 to indexLevel+1 do
    OrderStr := OrderStr + Format('Level%dName, Level%dID, ', [i, i]);
  OrderStr := Copy(OrderStr, 1, Length(OrderStr)-2);
  AdoQuery := TAdoQuery.Create(nil);
  AdoQuery.Connection := Connection;

  AdoQuery.SQL.Text := '';

  for i := FindMinLevel to FindMaxLevel do
  begin
    SelectNodeFields := '';
    for j := FindMinLevel to i do
      SelectNodeFields := SelectNodeFields + Format(
        'Level%0:dID, Level%0:dName, ', [j+1]
      );
    for j := i+1 to indexLevel do
      SelectNodeFields := SelectNodeFields + Format(
        'Level%0:dID, Level%0:dName, ', [j+1]
      );
    SelectNodeFields := Copy(SelectNodeFields, 1, Length(SelectNodeFields)-2);
  end;
  
  AdoQuery.SQL.Add(Format('select Level, %s from ( ',[SelectNodeFields]));

  for i := FindMinLevel to FindMaxLevel do
  begin
    NodeFields := '';
    for j := FindMinLevel to i do
      NodeFields := NodeFields + Format(
        'Level%0:dID, Level%0:dName, ', [j+1]
      );
    for j := i+1 to indexLevel do
      NodeFields := NodeFields + Format(
        '-1 as Level%0:dID, -1 as Level%0:dName, ', [j+1]
      );
    NodeFields := Copy(NodeFields, 1, Length(NodeFields)-2);

    AdoQuery.SQL.Add(
        Format(
        'select distinct %0:d as Level, %4:s from %1:s a '+
        'where Level%0:dName in (select ID from %2:s where Name like %3:s)',
        [i+1, GetFilteredDataTableSQL, NamesTable, QuotedStr('%'+SearchString+'%'), NodeFields]
      )
    );

    if i < indexLevel then
      AdoQuery.SQL.Add('union');
  end;
  AdoQuery.SQL.Add(' ) x ');
  AdoQuery.SQL.Add(Format(' where level > %d ', [ItemLevel+1]));

  AdoQuery.SQL.Add(Format(' and Level%0:dID = %d ', [ItemLevel+1, itemIndex]));

  AdoQuery.SQL.Add('order by '+OrderStr);

  AdoQuery.Open;
  FoundNodeIndex := -1;
  FoundNodeCount := AdoQuery.RecordCount;
  SetLength(FoundNodeIDs, FoundNodeCount);
  i := Low(FoundNodeIDs);
  while not AdoQuery.Eof do
  begin
    FoundNodeIDs[i].Level := AdoQuery.FieldByName('Level').AsInteger;
    FoundNodeIDs[i].ID := AdoQuery.FieldByName(Format('Level%dID', [FoundNodeIDs[i].Level])).AsInteger;
    AdoQuery.Next;
    inc(i);
  end;
  AdoQuery.Close;
  AdoQuery.Free;

  self.SearchString := SearchString;
  self.NamesTable := NamesTable;
  FoundNodesValid := True;
  ActiveSearchIsAllNodes := True;

  if FoundNodeCount = 0 then
    raise Exception.Create('No items found matching "'+SearchString+'".');
end;

//IMPORTANT: This method assumes that intArray is sorted. It will not work correctly if it isn't.
function TDataTree.IntegerArrayContains(value: integer; var intArray: array of integer): boolean;
var lowerBound, upperBound, x: integer;
begin
  Result := False;

  //Perform a binary search on the given ORDERED array.
  lowerBound := 0;
  upperBound := length(intArray)-1;

  while lowerBound <= upperBound do
  begin
    x := (upperBound + lowerBound) div 2;
    if value < intArray[x] then
      upperBound := x - 1
    else if value > intArray[x] then
      lowerBound := x + 1
    else
    begin
      Result := true;
      Break;
    end;
  end;

end;

procedure TDataTree.ClearFilter(const level: integer);
var
  i: integer;
  LowestFilteredLevel: integer;
  SavedCursorState: TCursor;
begin
  SavedCursorState := Screen.Cursor;
  with Screen do Cursor := crHourGlass;

  try
    with TDataLevel(LevelList[level]) do
    begin
      if not FilterApplied then
        Exit;

      FilterApplied := False;
      FilteredIdsTable := '';
    end;

    if SourceTreeHasDeletedNodes then
    begin
      SourceTree.Items.BeginUpdate;
      try
        RestoreSourceTreeFromBackup;

        for i := 0 to LevelList.Count - 1 do
          TDataLevel(LevelList[i]).HasDeletedNodes := False;

        // Re-apply any other filters.
        if FilterHasBeenApplied then
        begin
          LowestFilteredLevel := 0;

          for i := 0 to LevelList.Count - 1 do
            with TDataLevel(LevelList[i]) do
              if FilterApplied then
              begin
                LowestFilteredLevel := i;
                DeleteNodesNotInFilter(i, FilteredIdsTable);
              end;

          DeleteChildlessNodes(LowestFilteredLevel - 1);
        end;

        ExpandSingleNodes(SourceTree.Items.GetFirstNode);
      finally
        SourceTree.Items.EndUpdate;
      end;
    end;

    FoundNodesValid := False; //Any lists of nodes produced by FindNodes/FindAllNodes will need re-generating
                              //because they may include nodes no longer visible.
  finally
    with Screen do Cursor := SavedCursorState;
  end;
end;

procedure TDataTree.BackupSourceTree;
begin
  //TODO PM639: Make this more intelligent so that it only takes a backup if the tree has changed (i.e. more nodes expanded)
  //since the last backup.

  BackUpTree.Items.BeginUpdate;
  BackUpTree.Items.Clear;
  BackUpTree.Items.Assign(SourceTree.Items);
  BackUpTree.Items.EndUpdate;
end;

procedure TDataTree.RestoreSourceTreeFromBackup;
var i: integer;
begin
  SourceTree.Items.Clear;
  SourceTree.Items.Assign(BackUpTree.Items);
  for i := 0 to SourceTree.Items.Count - 1 do
    if SourceTree.Items[i].Level+1 <= Levels.Count-1 then SourceTree.Items[i].HasChildren := True;
end;


procedure TDataTree.DeleteNodesNotInFilter(const level: integer; const filteredIdsTable: string);
var
  i: integer;
  levelInfo: TDataLevel;
  filteredIds: array of Integer;
  nodesToDelete: TList;
begin
  with TADODataset.Create(nil) do
  try
    Connection := self.Connection;
    CommandType := cmdText;
    CommandText := 'SELECT Id FROM ' + filteredIdsTable + ' ORDER BY Id';
    Open;
    if RecordCount > 0 then
    begin
      SetLength(filteredIds, RecordCount);
      i := 0;
      while not(eof) do
      begin
        filteredIds[i] := FieldByName('Id').AsInteger;
        i := i + 1;
        Next;
      end;
    end;
  finally
    free;
  end;

  levelInfo := TDataLevel(LevelList[level]);
  levelInfo.HasDeletedNodes := False;

  nodesToDelete := TList.Create;
  try
    for i := 0 to SourceTree.Items.Count - 1 do
      if (SourceTree.Items[i].Level = level) and not IntegerArrayContains(Integer(SourceTree.Items[i].Data), filteredIds) then
        nodesToDelete.Add(SourceTree.Items[i]);

    if nodesToDelete.Count > 0 then
    begin
      levelInfo.HasDeletedNodes := True;

      for i := 0 to nodesToDelete.Count - 1 do
        SourceTree.Items.Delete(TTreeNode(nodesToDelete[i]));
    end;
  finally
    nodesToDelete.Free;
  end;

  filteredIds := nil;
end;

// Make the given level of the SourceTree only show nodes whose Id is in the "filteredIdsTable" SQL table.
procedure TDataTree.ApplyFilter(const level: integer; const filteredIdsTable: string);
var
  i: integer;
  SavedCursorState: TCursor;
  levelInfo: TDataLevel;
  lowestFilteredLevel: integer;
begin
  lowestFilteredLevel := level;
  levelInfo := TDataLevel(LevelList[level]);

  levelInfo.FilterApplied := True;
  levelInfo.FilteredIdsTable := filteredIdsTable;

  SavedCursorState := Screen.Cursor;
  with Screen do Cursor := crHourGlass;
  try
    //Keep a backup of the the latest state of the Main Tree that does not have deleted nodes.
    //This will be used as the starting point of the Main Tree if the filter is changed or cleared.
    if not SourceTreeHasDeletedNodes then
      BackupSourceTree;

    SourceTree.Items.BeginUpdate;

    try
      //If nodes at any level are currently deleted restore the SourceTree to the last backup of complete data with no deleted nodes.
      //This must be done before a different set of filter Ids is applied.
      if SourceTreeHasDeletedNodes then
      begin
        RestoreSourceTreeFromBackup;

        //Apply all filters, not just the one passed to this proc.
        for i := 0 to LevelList.Count - 1 do
        begin
          levelInfo :=TDataLevel(LevelList[i]);
          if levelInfo.FilterApplied then
          begin
            lowestFilteredLevel := i;
            DeleteNodesNotInFilter(i, levelInfo.FilteredIdsTable);
          end;
        end
      end
      else
      begin
        DeleteNodesNotInFilter(level, filteredIdsTable);
      end;

      if lowestFilteredLevel > 0 then
        DeleteChildlessNodes(lowestFilteredLevel - 1);

      if SourceTreeHasDeletedNodes then
        ExpandSingleNodes(SourceTree.Items.GetFirstNode);

      FoundNodesValid := False; //Any lists of nodes produced by FindNodes/FindAllNodes will need re-generating
                                //because they may include nodes no longer visible.
    finally
      SourceTree.Items.EndUpdate;
    end;
  finally
    with Screen do Cursor := SavedCursorState;
  end;
end;

//Return True if the SourceTree is currently missing nodes because of filtering.
function TDataTree.SourceTreeHasDeletedNodes: boolean;
var i: integer;
begin
  Result := False;

  for i := 0 to LevelList.Count - 1 do
    if TDataLevel(LevelList[i]).HasDeletedNodes then
    begin
      Result := True;
      Break
    end;
end;

// Return True if any level currently has a filter applied to it.
function TDataTree.FilterHasBeenApplied: boolean;
var i: integer;
begin
  Result := False;

  for i := 0 to LevelList.Count - 1 do
    if TDataLevel(LevelList[i]).FilterApplied then
    begin
      Result := True;
      Break
    end;
end;

procedure TDataTree.DeleteChildlessNodes(const level: integer);
var
  i : integer;
  childlessIds: array of integer;
  nodesToDelete: TList;
begin
  if level < 0 then
    Exit;

  with TADODataset.Create(nil) do
  try
    Connection := self.Connection;
    CommandType := cmdText;
    CommandText := Format(
      'SELECT DISTINCT Level%0:dId AS Id FROM %1:s ' +
      'WHERE Level%0:dId NOT IN ' +
      '  (SELECT DISTINCT Level%0:dId FROM %1:s WHERE 1=1 %2:s ) ' +
      'ORDER BY Level%0:dId', [level+1, DataTable, GetFilterWhereConditions]);

    Open;
    if RecordCount > 0 then
    begin
      SetLength(childlessIds, RecordCount);
      i := 0;
      while not(eof) do
      begin
        childlessIds[i] := FieldByName('Id').AsInteger;
        i := i + 1;
        Next;
      end;
    end;
  finally
    free;
  end;


  if length(childlessIds) > 0 then
  begin
    nodesToDelete := TList.Create;

    try
      for i := 0 to SourceTree.Items.Count - 1 do
        if (SourceTree.Items[i].Level = level) and IntegerArrayContains(Integer(SourceTree.Items[i].Data), childlessIds) then
          nodesToDelete.Add(SourceTree.Items[i]);

      if nodesToDelete.Count > 0 then
      begin
        TDataLevel(LevelList[level]).HasDeletedNodes := True;

        for i := 0 to nodesToDelete.Count - 1 do
          SourceTree.Items.Delete(TTreeNode(nodesToDelete[i]));
      end;
    finally
      nodesToDelete.Free;
    end;
  end;

  childlessIds := nil;

  if level > 0 then
    DeleteChildlessNodes(level-1);
end;

//Return an integer array containing the Ids from the lowest level of the source tree starting from ParentNode.
function TDataTree.GetLeafIdsFromSourceTree(parentNode: TTreeNode): TIntegerDynArray;
var
 i: integer;
begin
  with TADODataset.Create(nil) do
  try
    Connection := self.Connection;
    CommandType := cmdText;
    CommandText :=
       'SELECT DISTINCT Level' + IntToStr(GetMaxLevel + 1) + 'Id AS Id FROM ' + DataTable +
       ' WHERE Level' + IntToStr(ParentNode.Level + 1) + 'Id = ' + IntToStr(Integer(parentNode.Data)) + GetFilterWhereConditions +
       ' ORDER BY Id';
    Open;
    SetLength(Result, RecordCount);
    i := 0;
    while not(eof) do
    begin
      Result[i] := FieldByName('Id').AsInteger;
      i := i + 1;
      Next;
    end;
  finally
    free;
  end;
end;

//Return a StringList containing the Ids from the lowest level of the source tree starting from ParentNode.
function TDataTree.GetLeafIdListFromSourceTree(parentNode: TTreeNode): TStringList;
begin
  with TADODataset.Create(nil) do
  try
    Connection := self.Connection;
    CommandType := cmdText;
    CommandText :=
       'SELECT DISTINCT Level' + IntToStr(GetMaxLevel + 1) + 'Id AS Id FROM ' + DataTable +
       ' WHERE Level' + IntToStr(ParentNode.Level + 1) + 'Id = ' + IntToStr(Integer(parentNode.Data)) + GetFilterWhereConditions +
       ' ORDER BY Id';
    Open;
    Result := TStringList.Create;
    while not(eof) do
    begin
      Result.Add(FieldByName('Id').AsString);
      Next;
    end;
  finally
    free;
  end;
end;

//Return an integer array containing the Ids from the lowest level of TargetTree starting from ParentNode.
function TDataTree.GetLeafIdsFromTargetTree(TargetTree: TTreeView; ParentNode: TTreeNode): TIntegerDynArray;
var
  i, j: integer;
  childLeafIdArrays: array of TIntegerDynArray;
  leafCount: integer;
  resultId: integer;
begin
  if ParentNode.Level = GetMaxLevel then
    Exit;
    
  if ParentNode.Level = GetMaxLevel - 1 then
  begin
    //The ParentNode has leaf nodes as children. Get the Ids of its child leaf nodes.
    SetLength(Result, ParentNode.Count);
    for i := 0 to (ParentNode.Count - 1) do
       Result[i] := Integer(ParentNode.Item[i].Data);
  end
  else
  begin
    //The ParentNode has children that are not leaf nodes. Recursively get the leaf Ids from each child and
    //assemble into a single array of leaf Ids.
    if ParentNode.Count = 1 then
    begin
      Result := GetLeafIdsFromTargetTree(TargetTree, ParentNode.getFirstChild);
    end
    else
    begin
      SetLength(childLeafIdArrays, ParentNode.Count);
      leafCount := 0;
      for i := 0 to (ParentNode.Count - 1) do
      begin
         childLeafIdArrays[i] := GetLeafIdsFromTargetTree(TargetTree, ParentNode.Item[i]);
         leafCount := leafCount + length(childLeafIdArrays[i]);
      end;

      SetLength(Result, leafCount);
      resultId := 0;
      for i := 0 to (ParentNode.Count - 1) do
      begin
        for j := 0 to length(childLeafIdArrays[i]) - 1 do
        begin
          Result[resultId] := childLeafIdArrays[i][j];
          inc(resultId);
        end;

        childLeafIdArrays[i] := nil; //Make sure the memory assigned to the intermediary arrays is released.
      end;

      childLeafIdArrays := nil; //Make sure the memory assigned to the intermediary arrays is released.
    end;
  end;
end;


// Return true if the given TargetTree contains any of the leaf items of the currently selected node in the source tree.
function TDataTree.TargetTreeContainsSelectedNodeLeafItems(targetTree: TTreeView): boolean;
var
  targetNode: TTreeNode;
  i: integer;
  sourceLeafIds, targetLeafIds: TIntegerDynArray;
begin
  Result := False;
  sourceLeafIds := nil;  //Setting these to nil to avoid a compiler warning. No idea why the warning is being given!
  targetLeafIds := nil;

  if not assigned(SourceTree.Selected) then
    Exit;

  targetNode := GetMatchingNodeInTargetTree(targetTree, SourceTree.Selected);

  if TargetNode <> nil then
  begin
    if targetNode.Level = GetMaxLevel then
    begin
      Result := true;
    end
    else
    begin
      sourceLeafIds := GetLeafIdsFromSourceTree(SourceTree.Selected);
      targetLeafIds := GetLeafIdsFromTargetTree(targetTree, targetNode);

      if (length(sourceLeafIds) > 0) and (length(targetLeafIds) > 0) then
        for i := 0 to length(targetLeafIds) do
        begin
          if IntegerArrayContains(targetLeafIds[i], sourceLeafIds) then
          begin
            Result := True;
            Break;
          end;
        end;

      sourceLeafIds := nil;  //Make sure the memory used by these dynamic arrays is released.
      targetLeafIds := nil;
    end;
  end;
end;

end.



