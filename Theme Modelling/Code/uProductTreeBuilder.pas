unit uProductTreeBuilder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, DB, ADODB, ComCtrls, StdCtrls, uDataTree2, uEPOSTextHelper;

const
  Checkbox_UnChecked = 0;
  Checkbox_Greyed = 1;
  Checkbox_Checked = 2;
  Checkbox_Nogo = 3;

type
  TDiscountItem = class // Used to store each selected node. These Nodes are then added to the ThemeDiscountItems table.
    uniqueName : String;
    displayName : String;
    indexLevel : integer;
    include : integer;
    itemIndex : integer;
    GroupQualifier : boolean;
    nogo : boolean;
  end;

// ==================================================================================
type
  TNodeStack = class
  private
    FItems: array of TTreeNode;
    FCount: Integer;
  public
    constructor Init;
    procedure Push(Item: TTreeNode);
    function Pop: TTreeNode;
    function Count: Integer;
  end;
// ==================================================================================

type
  TProductTreeBuilder = class(TForm)
    AppFeatureBox: TGroupBox;
    SearchGroupBox: TGroupBox;
    SearchTextEdit: TEdit;
    RestrictSearchComboBox: TComboBox;
    SearchAllRadioButton: TRadioButton;
    SearchSelectedRadioButton: TRadioButton;
    FindNextButton: TButton;
    FindPrevButton: TButton;
    RestrictSearchCheckBox: TCheckBox;
    tvAllProducts: TTreeView;
    btOk: TButton;
    btCancel: TButton;
    adoqrun: TADOQuery;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvAllProductsClick(Sender: TObject);
    procedure tvAllProductsCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvAllProductsDblClick(Sender: TObject);
    procedure tvAllProductsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvAllProductsKeyPress(Sender: TObject; var Key: Char);
    procedure FindNextButtonClick(Sender: TObject);
    procedure SearchTextEditChange(Sender: TObject);
    procedure SearchAllRadioButtonClick(Sender: TObject);
    procedure SearchSelectedRadioButtonClick(Sender: TObject);
    procedure RestrictSearchCheckBoxClick(Sender: TObject);
    procedure RestrictSearchComboBoxClick(Sender: TObject);
  private
    //ProductNamesArray: TNamesArray;
    ProductDataTree: TDataTree;
    Item : TDiscountItem;
    SearchStringChanged: boolean;
    noGoList : TStringList;
    noGoProducts : Boolean;
    checkProducts : Boolean;
    checkItems : Boolean;
    procedure getNoGoItems;
    procedure CheckIfGreyedIterative(Node: TTreeNode);
    //loopCount1, loopCount2, setCheck1, setCheck2 : integer;
  public
    CollapseExpand:Boolean;
    SearchRootNode : TTreeNode;
    DiscountItemsCount : integer;
    ProdGroupToLoadList : TStringList;
    ProdGroupToSaveList : TStringList;

    function treeNodesDivisonalCheck: boolean;
    function treeSubNodesCheck: boolean;
    procedure ToggleSelection(Node: TTreeNode);
    procedure setSearchBox(activate: boolean);
    procedure TreeBuilderSaveDiscItems(DiscountID : integer; isGroupQualifier : boolean);
    procedure TreeBuilderLoadDiscItems(DiscountID : integer; isGroupQualifier : boolean);
    function isIncluded: boolean; overload;
    procedure InitialiseTreeView(isGroupQualifier : boolean);
  end;

var
  ProductTreeBuilder: TProductTreeBuilder;

implementation

{$R *.dfm}

uses uADO, uAztecLog, StrUtils;


procedure TProductTreeBuilder.FormCreate(Sender: TObject);
begin
  noGoList := TStringList.Create;
  ProdGroupToLoadList := TStringList.Create;
  ProdGroupToSaveList := TStringList.Create;
  GetNoGoItems;
end;


procedure TProductTreeBuilder.InitialiseTreeView(isGroupQualifier : boolean);
var
  hintSql : string;
begin
  // by this point #NoDiscountItems and #ThemeDiscountItems are loaded...

  dmADO.AztecConn.Execute('if object_id(''tempdb..#producttree_names'') is not null drop table #producttree_names ' +
      'if object_id(''tempdb..#ProductTree_Data'') is not null drop table #ProductTree_Data  ' +
      'if object_id(''tempdb..#SellableProds'') is not null drop table #SellableProds  ');

  with adoqrun do
  begin
    close;
    SQL.Clear;
    sql.Add(
      'create table #SellableProds ([EntityCode] bigint, [Sub-Category Name] varchar(50), [Extended RTL Name] varchar(50)) ' +
      'insert #SellableProds  ' +
      'select [EntityCode], [Sub-Category Name], [Extended RTL Name]  ' +
      'from products where (deleted = ''N'' or deleted is null) and [Entity Type] in (''Recipe'', ''Strd.Line'') ' +
      '  and entitycode < 19999999999.0 -- PW fix for unsupported "site products" with massive entity codes');
    sql.Add(
      'create table #ProductTree_Names (ID int identity(1,1), Name varchar(50) COLLATE DATABASE_DEFAULT) ' +
      'insert #ProductTree_Names  ' +
      'select Name from (select Name from ac_ProductDivision union select Name from ac_ProductCategory ' +
      '  union select Name from ac_ProductSubCategory where deleted = 0  ' +
      '  union select [extended rtl name] as Name from #SellableProds) a order by Name');
    sql.Add(
      'create table #ProductTree_data (Level1ID int, Level2ID int, Level3ID int, Level4ID int,  Level1Name int, ' +
      ' Level2Name int, Level3Name int, Level4Name int, noGo bit DEFAULT 0, checked bit DEFAULT 0, ' +
      ' primary key (Level1ID, Level2ID, Level3ID, Level4ID))   ');
    execSQL;

    if isGroupQualifier then
    begin
      // if in GroupQualifer mode then a temp table is already made.
      // This has the GQ items as they were last modified in THIS Edit Discount session
      // If none (no editing of GQ yet) it has the the GQ items loaded from the DB as saved from a previous session

      SQL.Text :=
        'insert #ProductTree_Data  ' +
        'select d.Id as Level1ID, c.Id as Level2ID, s.Id as Level3ID, cast((p.[entitycode] - 10000000000.0) as int) as Level4ID, ' +
        '    dname.ID as Level1Name, cname.ID as Level2Name, sname.ID as Level3Name, pName.ID as Level4Name   ' +
        '  , IIF(nogo.[Unique Name] is null, 0, 1) as noGo, IIF(ck.[Unique Name] is null, 0, 1) as checked ' +
        'from #SellableProds p  join #ProductTree_Names pName on p.[extended rtl name] = pName.Name           ' +
        'join ac_ProductSubCategory s on p.[sub-category name] = s.name join #ProductTree_Names sname on s.Name = sname.Name  ' +
        'join ac_ProductCategory c on s.ProductCategoryId = c.Id join #ProductTree_Names cname on c.Name = cname.Name  ' +
        'join ac_ProductDivision d on c.ProductDivisionId = d.Id join #ProductTree_Names dname on d.Name = dname.Name  ' +
        'left join #NoDiscountItems nogo on p.[entitycode] = nogo.[Unique Name]  ' +
        'left join (select * from #GQItems where [Unique Name] NOT LIKE ''%[^0-9]%'' and include = 2) ck ' + // only checks for Products...
        '   on cast(p.[entitycode] as varchar) = ck.[Unique Name]' +
        'order by d.Name, c.Name, s.Name, p.[Extended RTL Name] ';
      execSQL;

      SQL.Text := 'select count(*) as rc from #GQItems where [Unique Name] NOT LIKE ''%[^0-9]%'' and include = 2';
      Open;
      checkProducts := (fieldByName('rc').AsInteger > 0);
      Close;

      SQL.Text := 'select count(*) as rc from #GQItems where include = 2';
      Open;
      checkItems := (fieldByName('rc').AsInteger > 0);
      Close;
    end
    else
    begin
      SQL.Text :=
        'insert #ProductTree_Data  ' +
        'select d.Id as Level1ID, c.Id as Level2ID, s.Id as Level3ID, cast((p.[entitycode] - 10000000000.0) as int) as Level4ID, ' +
        '    dname.ID as Level1Name, cname.ID as Level2Name, sname.ID as Level3Name, pName.ID as Level4Name   ' +
        '  , IIF(nogo.[Unique Name] is null, 0, 1) as noGo, IIF(ck.[Unique Name] is null, 0, 1) as checked ' +
        'from #SellableProds p  join #ProductTree_Names pName on p.[extended rtl name] = pName.Name           ' +
        'join ac_ProductSubCategory s on p.[sub-category name] = s.name join #ProductTree_Names sname on s.Name = sname.Name  ' +
        'join ac_ProductCategory c on s.ProductCategoryId = c.Id join #ProductTree_Names cname on c.Name = cname.Name  ' +
        'join ac_ProductDivision d on c.ProductDivisionId = d.Id join #ProductTree_Names dname on d.Name = dname.Name  ' +
        'left join #NoDiscountItems nogo on p.[entitycode] = nogo.[Unique Name]  ' +
        'left join (select * from #ThemeDiscountItems ' +
        '           where [Unique Name] NOT LIKE ''%[^0-9]%'' and include = 2 and isGroupQualifier = 0) ck ' + // only checks for Products...
        '   on cast(p.[entitycode] as varchar) = ck.[Unique Name]' +
        'order by d.Name, c.Name, s.Name, p.[Extended RTL Name] ';
      execSQL;

      SQL.Text := 'select count(*) as rc from #ThemeDiscountItems where [Unique Name] NOT LIKE ''%[^0-9]%'' and include = 2';
      Open;
      checkProducts := (fieldByName('rc').AsInteger > 0);
      Close;

      SQL.Text := 'select count(*) as rc from #ThemeDiscountItems where include = 2';
      Open;
      checkItems := (fieldByName('rc').AsInteger > 0);
      Close;
    end;


       // uncomment below for debugging
//       SQL.Text :=
//        ' IF OBJECT_ID(''DBG_ProductTree_data'') IS NOT NULL DROP TABLE DBG_ProductTree_data ' +
//        ' select * into DBG_ProductTree_data from #ProductTree_data ';
//       ExecSQL;
  end;

  hintSQL :=
   ' SELECT IIF(ppa.Entitycode is not null, ''<Admission - NOT ALLOWED> '' + isnull([Retail Description], ''''), ' +
   '   IIF(ppd.Entitycode is not null, ''<Donation - NOT ALLOWED> '' + isnull([Retail Description], ''''), ' +
   '        [Retail Description])) as Hint ' +
   ' FROM (select EntityCode, [Retail Description] from Products ' +
   '        where cast((EntityCode-10000000000.0) as int)  = %d and EntityCode < 20000000000.0) p ' +
   '  left join ProductProperties ppa on p.EntityCode = ppa.Entitycode and ppa.IsAdmission = 1 ';

   if not dmADO.NoDiscAdmissions then         // ensures no [ProductProperties] recs are selected if toggle is off
     hintSQL := hintSQL + ' and 1 = 2 ';      // but the left join query still works ok

   hintSQL := hintSQL +
     ' left join ProductProperties ppd on p.EntityCode = ppd.Entitycode and ppd.IsDonation = 1 ';

   if not dmADO.NoDiscDonations then          // ensures no [ProductProperties] recs are selected if toggle is off
     hintSQL := hintSQL + ' and 1 = 2 ';      // but the left join query still works ok

  ProductDataTree := TDataTree.Create(tvAllproducts, dmADO.AztecConn,
                                      '#ProductTree_Data', '#ProductTree_Names', false, NoGoProducts, checkProducts);
  ProductDataTree.AddLevel('Division', '');
  ProductDataTree.AddLevel('Category', '');
  ProductDataTree.AddLevel('Subcategory', '');
  ProductDataTree.AddLevel('Product', hintSQL);
  ProductDataTree.Initialise;
  tvAllProducts.DoubleBuffered := True;
end;

procedure TProductTreeBuilder.FormDestroy(Sender: TObject);
begin
  ProductDataTree.free;
  noGoList.Free;
  ProdGroupToLoadList.Free;
  ProdGroupToSaveList.Free;
  adoqRun.Free;
end;

// Adds each discount item to the table that has been selected.  Works out what item will
// appear in the XML Discount container by setting a selected parents record to include = True.
// ----- There could be more done here. We save the same info, in different forms, to ThemeDiscountItems and to
// ----- to ProductGrouping. ProductGrouping is used for TGEM but not to load the data here (??).
// ----- Could refactor to only use ProductGrouping and eliminate ThemeDiscountItems.
// ----- Also, right now, ThemeDiscountItems can be made a Local table (HO only) and not Comms-ed down.
procedure TProductTreeBuilder.TreeBuilderSaveDiscItems(DiscountID : integer; isGroupQualifier : boolean);
var
  i : integer;
  CurrentPos : TTreeNode;
  ParentNodes : Array[0..2] of TTreeNode;
  discountItemList : TStringList;

  procedure saveDiscountItem(discountID: integer; uniqueName, displayName : String; include, itemIndex : integer; GroupQualifier : boolean );
  begin
    with dmADO.qRun do
      try
        SQL.Clear;
        SQL.Add('INSERT INTO #ThemeDiscountItems(DiscountID, [Unique Name], DisplayName, ItemIndex, Include, isGroupQualifier)');
        SQL.Add('VALUES('''+IntToStr(discountID)+''', '''+uniqueName+''', '''+displayName+''', '+IntToStr(itemIndex)+', '+ IntToStr(include)+', '+IntToStr(integer(GroupQualifier))+')');
        ExecSQL;
        Log('Discount Item ' + UniqueName + ', ' + displayName + ' saved');
      except on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
  end;

  function getUniqueName(level, itemID : Integer) : String;
  begin
    if level = 0 then       result := 'DIV'+IntToStr(itemID)
    else if level = 1 then  result := 'CAT'+IntToStr(itemID)
    else if level = 2 then  result := 'SUB'+IntToStr(itemID)
    else                    result := IntToStr(10000000000 + itemID); // Pad out ItemIndex to make product entity code.
  end;

  function assessParentNode(level : integer) : TTreeNode;
  var i : integer;
  begin
    Result := nil;
    for i := level - 1 downto 0 do
      if (ParentNodes[i].getNextSibling <> nil) then
      begin
       Result := ParentNodes[i].getNextSibling;
       Break;
      end;
  end;

  procedure searchCheckedNodes(node : TTreeNode); // onlt proc left recursive, seems fast.
  begin
    if node = nil then exit;

    //Add all the visible nodes to the table.
    Item := TDiscountItem.Create;
    Item.displayName := node.Text;
    Item.indexLevel := node.Level;
    Item.GroupQualifier := isGroupQualifier;
    Item.itemIndex := Integer(node.Data);

    case node.ImageIndex of
    Checkbox_Checked :
                 begin
                   Item.include := Checkbox_Checked;
                   discountItemList.AddObject(node.Text+IntToStr(integer(Node.Data)+Node.Level), Item);
                   if (node.getNextSibling = nil) and (node.Level = 0) then
                      exit
                   else if (node.getNextSibling = nil) and (node.Level in [1,2,3]) then
                      searchCheckedNodes(assessParentNode(node.Level))
                   else if node.getNextSibling <> nil then
                      searchCheckedNodes(node.getNextSibling)
                 end;
    Checkbox_Greyed :
                 begin
                   ParentNodes[node.Level] := node;
                   if node.getNext <> nil then
                      searchCheckedNodes(node.getNext)
                   else
                      searchCheckedNodes(node.getFirstChild);
                 end;
    Checkbox_UnChecked, Checkbox_NoGo :
                 begin
                   if node.getNextSibling <> nil then
                      searchCheckedNodes(node.getNextSibling)
                   else if node.Parent <> nil then
                   begin
                      if node.Parent.getNextSibling = nil then
                         searchCheckedNodes(node.getNext)
                      else
                         searchCheckedNodes(node.Parent.getNextSibling);
                   end;
                 end;
    end;
  end;

  procedure AddItemToProductGroup(ItemLevel: integer; ItemIndex : Largeint);
  begin
    with dmADO.qRun do
    try
      if ItemLevel = 3 then ItemIndex := (ItemIndex + 10000000000);

      SQL.Text := ' INSERT INTO #AllProductGrouping(GroupingType, GroupingTypeTargetId, isGroupQualifier) ' +
        'VALUES (' + IntToStr(ItemLevel) + ', ' + IntToStr(ItemIndex) + ', ' + IntToStr(integer(isGroupQualifier)) + ')';
      ExecSQL;
    except
      on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;
  end;
begin
  if isGroupQualifier then
    Log('Saving Group Qualifier items for discount "' + dmADO.qDiscountsName.AsString + '"')
  else
    Log('Saving Discount items for discount "' + dmADO.qDiscountsName.AsString + '"');
  dmADO.logTime1 := Now;

  discountItemList := TStringList.Create;
  try
    discountItemList.Sorted := True;
    discountItemList.CaseSensitive := false;

    currentPos := tvAllProducts.Items.GetFirstNode;
    searchCheckedNodes(currentPos);
    //dmADO.LogDuration('searchCheckedNodes');

    // Delete any existing product grouping items for GroupQualifier
    with dmADO.qRun do
    try
      SQL.Text :=
        ' DELETE #AllProductGrouping ' +
        ' WHERE IsGroupQualifier = ' + IntToStr(integer(isGroupQualifier));
      ExecSQL;
    except
      on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text) ;
        raise;
      end;
    end;

    //Delete existing records for GroupQualifier before adding new items.
    with dmADO.qRun do
    try
      SQL.Clear;
      SQL.Add('Delete from #ThemeDiscountItems where IsGroupQualifier = '+IntToStr(integer(isGroupQualifier)));
      ExecSQL;
    except
      on e: exception do
      begin
        Log('Error :' + e.message);
        Log('Executing SQL: '+SQL.Text);
        raise;
      end;
    end;

    if (isGroupQualifier) then
       ProdGroupToSaveList := discountItemList
    else
      //_s has been added to allow duplicate objects to be added to the final discount list.
       for i := 0 to Pred(ProdGroupToSaveList.Count) do
           discountItemList.AddObject(ProdGroupToSaveList.Strings[i]+'_s', ProdGroupToSaveList.Objects[i]);

    for i := 0 to discountItemList.Count - 1 do
      with TDiscountItem(discountItemList.Objects[i]) do
      begin
        uniqueName := getUniqueName(indexLeveL, itemIndex);
        if not (isGroupQualifier) then
        begin
          saveDiscountItem(discountID,
                           stringreplace(uniqueName, '''', '', [rfReplaceAll, rfIgnoreCase]),
                           stringreplace(displayName, '''', '', [rfReplaceAll, rfIgnoreCase]),
                           include,
                           itemIndex,
                           GroupQualifier);

          if (include = checkbox_Checked) and not (GroupQualifier) then
             AddItemToProductGroup(indexLevel, itemIndex);
        end
        else if (include = checkbox_Checked) then
          AddItemToProductGroup(indexLevel, itemIndex);
      end;

    DiscountItemsCount := discountItemList.Count;
    dmADO.LogDuration('saveDiscountItems END');
  finally
    if not isGroupQualifier then discountItemList.Free;
  end;
end;

procedure TProductTreeBuilder.TreeBuilderLoadDiscItems(DiscountID : integer; isGroupQualifier : boolean);
var
  tmpItem : TDiscountItem;
  loadedItemsList : TStringList;
  selectedNode, noGoNode : Boolean;

  function getIndexLevel(level : String) : Integer; // Assigns a node the correct level based on its unique name.
  begin
    level := LeftStr(level, 3);
    if level = 'DIV' then      result := 0
    else if level = 'CAT' then result := 1
    else if level = 'SUB' then result := 2
    else                       result := 3
  end;

  procedure isSelectedOrNoGo(node : TTreeNode); // If a node matches a TDiscountItem then set Selected or NoGo flags
  var
    i, nodeData : integer;
  begin
    nodeData := Integer(node.Data);
    noGoNode := False;
    selectedNode := False;

    for i := 0 to loadedItemsList.Count - 1 do
    begin
       tmpItem := TDiscountItem(loadedItemsList.Objects[i]);

       if (nodeData = tmpItem.itemIndex) and (node.Level = getIndexLevel(tmpItem.uniqueName)) then // found an Item for Node
       begin                                                 
         if (tmpItem.include = Checkbox_Nogo) then
            noGoNode := True      // item found is a NoGo
         else
            selectedNode := True; // NOT NoGo, it MUST be a selected one: tmpItem.include = 2, i.e. Checkbox_Checked
         Break;
       end;
    end;
  end;

  // to cut down processing and thus time, Product Nodes are NOT processed here but in uDataTree2, based on TempTables,
  // see InitialiseTreeView. But if there are any Products checked we Expand the SubCateg nodes here to allow uDataTree2
  // code to set them. This Expand of each SubCateg is the time consuming operation.
  // If only Divs/Cats/Subs are checked, this is fast. If most Products have their Divs/Cats checked it is also fast.
  // Else, for 65,000 Recipes, with the biggest Divs (Food & Wet) unchecked, it can take 10-15 seconds to traverse the Tree.
  procedure checkTreeNodesIterative;
  var
    i: integer;
    stack: TNodeStack;
    node: TTreeNode;
  begin
    stack := TNodeStack.Create;
    try
      stack.Push(tvAllProducts.Items.GetFirstNode);
      while stack.Count > 0 do
      begin
        node := stack.Pop;
        if node = nil then Continue;

        isSelectedOrNoGo(node);

        if noGoNode then
        begin
          node.ImageIndex := Checkbox_Nogo;
          node.SelectedIndex := Checkbox_Nogo;
        end
        else if selectedNode then
        begin
          if (node.Level = 3) and noGoProducts then // only Products can be NoGo, check it. May be overkill...
          begin
            for i := 0 to noGoList.Count - 1 do
            begin
              if (Integer(node.Data) = TDiscountItem(noGoList.Objects[i]).itemIndex) then // found Item for Node
              begin
                node.ImageIndex := Checkbox_Nogo;
                node.SelectedIndex := Checkbox_Nogo;
                Break;
              end;
            end;
          end;

          if node.ImageIndex <> Checkbox_Nogo then // double check to ensure that NoGo never changes
          begin
            node.ImageIndex := Checkbox_Checked;
            node.SelectedIndex := Checkbox_Checked;
          end;  // no need to add its children to the Stack, TDataTree code will take care of this on Expand.

          // After processing node, see if any parent nodes need to be updated to Gray or Checked.
          // The lower level ones don't need checking for Gray, as they are all turned to Checked. May be overkill...
          CheckIfGreyedIterative(node.Parent);
        end
        else  if (node.Level < 3) then // for non-selected node, look at its children, maybe they are selected
        begin                          // but not for Subs, as Products selected are checked at Tree Creation. This reduces time.
          if node.Level = 2 then // this is an unchecked SubCategory
          begin
            if checkProducts then
            begin
              node.Expand(false);           // don't add Products to the stack, just expand...
              CheckIfGreyedIterative(node); // ... now check for Gray as nodes of selected Products are now checked.
            end;
          end
          else
          begin // unchecked Division or Category
            node.Expand(false);
            if node.HasChildren then 
            begin
              stack.Push(node.getFirstChild);
            end
          end;
        end;

        stack.Push(node.getNextSibling);
      end;
    finally
      stack.Free;
    end;
  end;

  procedure getDiscountItems;
  var
    loadedItem : TDiscountItem;
  begin
    // This ancestor unit is used to either select Products for a Discount or to select Group Qualifiers for that Discount.
    // The source for Discounts, **here** is a Temp Table (from the Database)
    // The source for Qualifiers, **here** is TStringList ProdGroupToLoadList and only if that's empty, the TempTable
    //    (the list itself was filled in from the DB or it may be from the last Edit Group Quals in this same session)

    if IsGroupQualifier then
    begin
      if (ProdGroupToLoadList.Count > 0) then  // saved GQ items take precedence...
      begin
        loadedItemsList.Assign(ProdGroupToLoadList); // Use Assign to copy contents
      end
      else
      begin                                    // ... if no saved GQ items load from DB, if any
        with adoqRun do
        begin
          close;
          SQL.Text := 'select * from #ThemeDiscountItems where IsGroupQualifier = 1';
          open;

          while not Eof do
          begin
            loadedItem := TDiscountItem.Create;
            loadedItem.include := FieldByName('Include').AsInteger;
            loadedItem.itemIndex := FieldByName('ItemIndex').AsInteger;
            loadedItem.uniqueName := FieldByName('Unique Name').AsString;
            loadedItem.GroupQualifier := FieldByName('isGroupQualifier').AsBoolean;
            loadedItemsList.AddObject(FieldByName('DisplayName').AsString + FieldByName('ItemIndex').AsString, loadedItem);
            Next;
          end;

          close;
        end;
      end;
    end
    else               // for Discount Items, only option is to load from DB.
    begin
      with adoqRun do
      begin
        close;
        SQL.Text := 'select * from #ThemeDiscountItems where IsGroupQualifier = 0';
        open;

        while not Eof do
        begin
          loadedItem := TDiscountItem.Create;
          loadedItem.include := FieldByName('Include').AsInteger;
          loadedItem.itemIndex := FieldByName('ItemIndex').AsInteger;
          loadedItem.uniqueName := FieldByName('Unique Name').AsString;
          loadedItem.GroupQualifier := FieldByName('isGroupQualifier').AsBoolean;
          loadedItemsList.AddObject(FieldByName('DisplayName').AsString + FieldByName('ItemIndex').AsString, loadedItem);
          Next;
        end;

        close;
      end;
    end;
  end;

begin
  if isGroupQualifier then
    Log('Loading Group Qualifier items for discount "' + dmADO.qDiscountsName.AsString + '"')
  else
    Log('Loading Discount items for discount "' + dmADO.qDiscountsName.AsString + '"');
  tvAllProducts.Items.BeginUpdate;
  try
    loadedItemsList := TStringList.Create;

    getDiscountItems;
    //dmADO.LogDuration('getDiscountItems');

    if checkItems then
      checkTreeNodesIterative;
    //dmADO.LogDuration('checkTreeNodesIterative');
    ProductDataTree.initialLoading := False;
  finally
    tvAllProducts.Items.EndUpdate;
    loadedItemsList.Free;
  end;
end;

// Ensures that at least one discount node has been selected as part of the discount.
function TProductTreeBuilder.treeNodesDivisonalCheck : boolean;
var
  i, j : integer;
begin
  j:=0;
  for i := 0 to pred(tvAllProducts.Items.Count) do
       if (tvAllProducts.Items.Item[i].ImageIndex = Checkbox_Checked) then
          j := j + 1;

  result := j > 0;
end;

// Flags an warning message if non divisional nodes have been selected
function TProductTreeBuilder.treeSubNodesCheck : boolean;
var
  i, j : integer;
begin
  j:=0;
  for i := 0 to pred(tvAllProducts.Items.Count) do
       if (tvAllProducts.Items.Item[i].ImageIndex = Checkbox_Greyed )
           and (tvAllProducts.Items.Item[i].Level = 0 )then
          j := j + 1;

  result := j > 0;
end;

procedure TProductTreeBuilder.ToggleSelection(Node: TTreeNode);

  procedure SetSelectionIterative(Node: TTreeNode; SelectionValue: integer);
  var
    stack: TNodeStack;
    currentNode, TmpNode: TTreeNode;
    i : integer;
  begin
    stack := TNodeStack.Create;
    try
      stack.Push(Node);
      while stack.Count > 0 do
      begin
        currentNode := stack.Pop;
        if currentNode = nil then Continue;

        if (currentNode.Level = 3) and noGoProducts then // only Products can be NoGo, check it...
        begin
          for i := 0 to noGoList.Count - 1 do
          begin
           if (Integer(currentNode.Data) = TDiscountItem(noGoList.Objects[i]).itemIndex) then //  found Item for Node
           begin
             currentNode.ImageIndex := Checkbox_Nogo;
             currentNode.SelectedIndex := Checkbox_Nogo;
             Break; // can be no children, move on...
           end;
          end;
        end;

        if SelectionValue = Checkbox_Nogo then
        begin
          currentNode.ImageIndex := Checkbox_Nogo;
          currentNode.SelectedIndex := Checkbox_Nogo;
        end;

        if currentNode.ImageIndex <> Checkbox_Nogo then // for whatever SelectionValue: NoGo never changes
        begin
          currentNode.ImageIndex := SelectionValue;
          currentNode.SelectedIndex := SelectionValue;

          //CurrentNode.Expand(False);
          TmpNode := currentNode.getFirstChild;  // add its children to the Stack
          while TmpNode <> nil do
          begin
            stack.Push(TmpNode);
            TmpNode := currentNode.GetNextChild(TmpNode);
          end;
        end;
      end;

      // After processing node and its children, see if any parent nodes need to be updated to Gray or Checked
      // the lower level ones don't need checking for Gray as they are all turned to SelectionValue
      CheckIfGreyedIterative(Node.Parent);
    finally
      stack.Free;
    end;
  end;

begin
  if Node.ImageIndex in [Checkbox_Checked, Checkbox_Greyed] then // node checked or grayed: uncheck it & its descendants
    SetSelectionIterative(Node, Checkbox_UnChecked)
  else if Node.ImageIndex = Checkbox_UnChecked then              //  NOT checked-grayed-NoGo: check it & its descendants
    SetSelectionIterative(Node, Checkbox_Checked)
  else if Node.ImageIndex = Checkbox_Nogo then                   // for safety
    SetSelectionIterative(Node, Checkbox_Nogo);
end;

// check this node's children to set this node as Checked/UnChecked/Grayed. Then go **up** the Tree, parent-grandparent
procedure TProductTreeBuilder.CheckIfGreyedIterative(Node: TTreeNode);
var
  stack: TNodeStack;
  TmpNode: TTreeNode;
  HasChecked, HasUnChecked, HasGreyed: boolean;
begin
  stack := TNodeStack.Create;
  try
    stack.Push(Node);
    while stack.Count > 0 do
    begin
      Node := stack.Pop;
      if not Assigned(Node) then Continue;

      HasChecked := False;
      HasUnChecked := False;
      HasGreyed := False;

      TmpNode := Node.getFirstChild;
      while Assigned(TmpNode) do
      begin
        HasChecked := HasChecked or (TmpNode.ImageIndex = Checkbox_Checked);
        HasUnChecked := HasUnChecked or (TmpNode.ImageIndex = Checkbox_UnChecked);
        HasGreyed := HasGreyed or (TmpNode.ImageIndex = Checkbox_Greyed);
        TmpNode := Node.GetNextChild(TmpNode);
      end;

      if HasGreyed or (HasChecked and HasUnChecked) then
        Node.ImageIndex := Checkbox_Greyed
      else if HasChecked and (not (HasUnChecked or HasGreyed)) then
        Node.ImageIndex := Checkbox_Checked
      else if (not (HasChecked or HasGreyed)) then
        Node.ImageIndex := Checkbox_UnChecked;

      Node.SelectedIndex := Node.ImageIndex;

      if Assigned(Node.Parent) then
        stack.Push(Node.Parent);
    end;
  finally
    stack.Free;
  end;
end;

procedure TProductTreeBuilder.getNoGoItems;
var
  loadedItem : TDiscountItem;
begin
  with adoqrun do
  begin
    close;
    SQL.Text := 'select * from #NoDiscountItems';
    Open;
    First;
    while not EOF do
    begin
      loadedItem := TDiscountItem.Create;
      loadedItem.include := Checkbox_NoGo;
      loadedItem.itemIndex := FieldByName('ItemIndex').AsInteger;
      loadedItem.uniqueName := FieldByName('Unique Name').AsString;
      loadedItem.GroupQualifier := false;
      noGoList.AddObject(FieldByName('DisplayName').AsString+FieldByName('ItemIndex').AsString, loadedItem);
      Next;
    end;
    Close;
  end;

  noGoProducts := (noGoList.Count > 0);
end;

procedure TProductTreeBuilder.tvAllProductsClick(Sender: TObject);
var
  hti: THitTests; // set of THitTest = (htAbove, htBelow, htNowhere, htOnItem, htOnButton, htOnIcon,
                  //         htOnIndent, htOnLabel, htOnRight, htOnStateIcon, htToLeft, htToRight);
  MousePos: TPoint;
begin
  if CollapseExpand then
     CollapseExpand := FALSE
  else
  begin
    MousePos := TTreeView(sender).ScreenToClient(Mouse.CursorPos);
    hti := TTreeView(sender).GetHitTestInfoAt(MousePos.x, MousePos.y);
    if htOnIcon in hti then
    begin
      TTreeView(Sender).items.BeginUpdate;
      ToggleSelection(TTreeView(sender).GetNodeAt(MousePos.x, MousePos.y));
      TTreeView(Sender).Items.EndUpdate;
    end;
  end;
  SearchRootNode := TTreeView(Sender).Selected;
end;

procedure TProductTreeBuilder.tvAllProductsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (SearchSelectedRadioButton.Enabled = True) then
     begin
       if (tvAllProducts.Selected.Level <> 3) then
         begin
           SearchSelectedRadioButton.Caption := 'Search ' + tvAllProducts.Selected.Text;
         end
       else
         begin
           SearchSelectedRadioButton.Caption := 'Search ' + tvAllProducts.Selected.Parent.Text;
         end
     end;
end;

procedure TProductTreeBuilder.tvAllProductsKeyPress(Sender: TObject; var Key: Char);
begin
  if assigned(TTreeView(Sender).selected) and (Key = ' ') then
  begin
    TTreeView(Sender).items.BeginUpdate;
    ToggleSelection(TTreeView(Sender).selected);
    TTreeView(Sender).items.EndUpdate;
  end;
end;

procedure TProductTreeBuilder.tvAllProductsDblClick(Sender: TObject);
var
  hti: THitTests;
  MousePos: TPoint;
begin
  CollapseExpand := FALSE;
  MousePos := TTreeView(sender).ScreenToClient(Mouse.CursorPos);
  hti := TTreeView(sender).GetHitTestInfoAt(MousePos.x, MousePos.y);
  if htOnIcon in hti then
  begin
    abort;
  end
end;

procedure TProductTreeBuilder.tvAllProductsCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
   CollapseExpand := TRUE;
end;

procedure TProductTreeBuilder.FindNextButtonClick(Sender: TObject);
var
  CurrentIndex, CurrentLevel : Integer;
begin
  CurrentIndex := 0;
  if (SearchTextEdit.Text <> '') then
  begin

    if (SearchStringChanged) or (CurrentIndex <> integer(SearchRootNode.Data))  then
       begin
         if SearchSelectedRadioButton.Checked = true then
            begin
         // Exclude Products from being the lowest node that can be searched within.
            if SearchRootNode.Level = 3 then
               begin
                 CurrentIndex := integer(SearchRootNode.Parent.Data);
                 CurrentLevel := SearchRootNode.Parent.level;
               end
            else
               begin
                 CurrentIndex := integer(SearchRootNode.Data);
                 CurrentLevel := SearchRootNode.level;
               end;


            if RestrictSearchCheckBox.Checked = true then
               ProductDataTree.FindAllNodes(SearchTextEdit.Text, '#producttree_names',
                                            RestrictSearchComboBox.ItemIndex,
                                            CurrentIndex,
                                            CurrentLevel)
            else
               ProductDataTree.FindAllNodes(SearchTextEdit.Text, '#producttree_names', ProductDataTree.GetMaxLevel,
                                            CurrentIndex,
                                            CurrentLevel);
            end
         else
         if RestrictSearchCheckBox.Checked = true then
            ProductDataTree.FindNodes(SearchTextEdit.Text, '#producttree_names',
                                         RestrictSearchComboBox.ItemIndex,
                                         RestrictSearchComboBox.ItemIndex)
         else
            ProductDataTree.FindNodes(SearchTextEdit.Text, '#producttree_names', 0, ProductDataTree.GetMaxLevel);
       end;
    SearchStringChanged := False;
    if TButton(Sender).Name = 'FindNextButton' then
       ProductDataTree.FindNext
    else
       ProductDataTree.FindPrev;
 end;
end;

procedure TProductTreeBuilder.SearchTextEditChange(Sender: TObject);
begin
   if SearchTextEdit.Text <> '' then
      SearchStringChanged := true;
end;

procedure TProductTreeBuilder.RestrictSearchComboBoxClick(Sender: TObject);
begin
  SearchStringChanged := True;
end;

procedure TProductTreeBuilder.SearchSelectedRadioButtonClick(Sender: TObject);
begin
  SearchStringChanged := True;
end;

procedure TProductTreeBuilder.SearchAllRadioButtonClick(Sender: TObject);
begin
  SearchStringChanged := True;
end;

procedure TProductTreeBuilder.RestrictSearchCheckBoxClick(Sender: TObject);
begin
  RestrictSearchComboBox.Enabled := RestrictSearchCheckBox.Checked;
  SearchStringChanged := True;
end;

procedure TProductTreeBuilder.setSearchBox(activate : boolean);
begin

  SearchSelectedRadioButton.Enabled := activate;
  if tvAllProducts.Selected = nil then
     begin
       tvAllProducts.Selected := tvAllProducts.Items.GetFirstNode;
       SearchSelectedRadioButton.caption := 'Search '+ tvAllProducts.Selected.Text;
     end;

  SearchAllRadioButton.Enabled := activate;

  RestrictSearchCheckBox.enabled := activate;

  RestrictSearchComboBox.Enabled := false;
  SearchAllRadioButton.Checked := true;

  RestrictSearchCheckBox.checked := false;
end;

// Checks discountitems list to work out XML optimisation.
// If included items count is less than or equal to excluded items then return true.
function TProductTreeBuilder.isIncluded : boolean;
begin
  with dmADO.qRun do
     begin
       Close;
       SQl.Clear;
       SQL.Add('select (select count(*) from themediscountitems');
       SQL.Add(' where include = 0 and discountID = '+ dmADO.qDiscounts.FieldbyName('DiscountID').AsString +') as Exclude,');
       SQL.Add('(select count(*) from themediscountitems');
       SQL.Add(' where include = 2 and discountID = '+ dmADO.qDiscounts.FieldbyName('DiscountID').AsString +') as Include ');
       Open;
       if (Fields[1].AsInteger <= Fields[0].AsInteger) or (Fields[0].AsInteger = 0) then
          result := True
       else
          result := False;
     end;
end;



// ==================================================================================
constructor TNodeStack.Init;
begin
  SetLength(FItems, 0);
  FCount := 0;
end;

procedure TNodeStack.Push(Item: TTreeNode);
begin
  Inc(FCount);
  SetLength(FItems, FCount);
  FItems[FCount - 1] := Item;
end;

function TNodeStack.Pop: TTreeNode;
begin
  if FCount = 0 then
    Result := nil
  else
  begin
    Result := FItems[FCount - 1];
    Dec(FCount);
    SetLength(FItems, FCount);
  end;
end;

function TNodeStack.Count: Integer;
begin
  Result := FCount;
end;
// ==================================================================================

end.
