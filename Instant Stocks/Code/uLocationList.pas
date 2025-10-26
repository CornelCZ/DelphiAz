unit uLocationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Grids, Wwdbigrd, Wwdbgrid, ADODB, Wwdatsrc,
  StdCtrls, Buttons, Wwkeycb, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwDialog,
  Wwlocate, strUtils, wwfltdlg, Menus, uStockLocationService;

type
  TUnprotectedGrid = class(TwwDBGrid);

type
  TfLocationList = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlList: TPanel;
    Splitter3: TSplitter;
    dsProds: TwwDataSource;
    adotProds: TADOTable;
    gridProds: TwwDBGrid;
    dsList: TwwDataSource;
    adotList: TADOTable;
    gridList: TwwDBGrid;
    btnInsert: TBitBtn;
    DeleteBitBtn: TBitBtn;
    ScrollTimer: TTimer;
    btnSave: TBitBtn;
    btnAppend: TBitBtn;
    lookDiv: TwwDBComboBox;
    lblDivision: TLabel;
    lblLocation: TLabel;
    lookLocation: TwwDBComboBox;
    Label14: TLabel;
    incSearch1: TwwIncrementalSearch;
    rbSInc: TRadioButton;
    rbsMid: TRadioButton;
    btnPriorSearch: TBitBtn;
    btnNextSearch: TBitBtn;
    Label5: TLabel;
    Bevel2: TBevel;
    pnlSearch: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    rbSearchProds: TRadioButton;
    rbSearchList: TRadioButton;
    Bevel1: TBevel;
    Label13: TLabel;
    lblFilterStatus: TLabel;
    LabelCategory: TLabel;
    LabelSubCategory: TLabel;
    lookCat: TComboBox;
    lookSCat: TComboBox;
    edFilt: TEdit;
    rbStart: TRadioButton;
    rbMid: TRadioButton;
    btnNoFilter: TBitBtn;
    btnFilter: TBitBtn;
    cbProdsNoLocation: TCheckBox;
    btnDone: TBitBtn;
    btnDiscard: TBitBtn;
    btnMoveTo: TBitBtn;
    editMove: TEdit;
    Bevel4: TBevel;
    Label4: TLabel;
    lblTopInfo: TLabel;
    Panel2: TPanel;
    btnRemoveProduct: TBitBtn;
    Label3: TLabel;
    Label7: TLabel;
    cbShowExpectedOnly: TCheckBox;
    cbProdsNotThisLocation: TCheckBox;
    lblProdCount: TLabel;
    edSearch: TEdit;
    wwFind: TwwLocateDialog;
    wwFill: TwwFilterDialog;
    btnAdvFilter: TBitBtn;
    btnResetFilters: TBitBtn;
    gridPopup: TPopupMenu;
    SubCategory1: TMenuItem;
    ProductID1: TMenuItem;
    ProductName1: TMenuItem;
    Description1: TMenuItem;
    Barcodes1: TMenuItem;
    Unit1: TMenuItem;
    ImpExpRef1: TMenuItem;
    DefaultSupplier1: TMenuItem;
    Category1: TMenuItem;
    InList1: TMenuItem;
    btnReturnChangeList: TBitBtn;
    btnReturnNoChange: TBitBtn;
    btnPrintSample: TBitBtn;
    lblLocHasFixedQty: TLabel;
    adotListRecID: TIntegerField;
    adotListEntityCode: TFloatField;
    adotListSCat: TStringField;
    adotListName: TStringField;
    adotListUnit: TStringField;
    adotListManualAdd: TBooleanField;
    adotListrecid2: TIntegerField;
    adotListDescr: TStringField;
    adotListisPrepItem: TStringField;
    adotListisPurchUnit: TIntegerField;
    adotListinList: TIntegerField;
    adotListFixedQty: TFloatField;
    adotListStringFixedQty: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure gridProdsDblClick(Sender: TObject);
    procedure gridListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure gridListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure gridListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollTimerTimer(Sender: TObject);
    procedure gridListEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure gridProdsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnSaveClick(Sender: TObject);
    procedure gridListCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure gridProdsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAppendClick(Sender: TObject);
    procedure lookDivCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure lookLocationCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure DeleteBitBtnClick(Sender: TObject);
    procedure editMoveKeyPress(Sender: TObject; var Key: Char);
    procedure btnDoneClick(Sender: TObject);
    procedure btnDiscardClick(Sender: TObject);
    procedure btnMoveToClick(Sender: TObject);
    procedure gridListDblClick(Sender: TObject);
    procedure gridProdsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure gridProdsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure gridProdsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure btnRemoveProductClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnNoFilterClick(Sender: TObject);
    procedure lookCatCloseUp(Sender: TObject);
    procedure cbShowExpectedOnlyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbProdsNoLocationClick(Sender: TObject);
    procedure rbSIncClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure btnPriorSearchClick(Sender: TObject);
    procedure rbSearchProdsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdvFilterClick(Sender: TObject);
    procedure btnResetFiltersClick(Sender: TObject);
    procedure gridProdsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure gridProdsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure Category1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnReturnNoChangeClick(Sender: TObject);
    procedure btnReturnChangeListClick(Sender: TObject);
    procedure btnPrintSampleClick(Sender: TObject);
    procedure gridListRowChanged(Sender: TObject);
    procedure adotListBeforePost(DataSet: TDataSet);
    procedure adotListAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    theEntityCodeString, theUnitName: string;
    scrollState: integer; // scrollState = 0-none, 1-up, 2-down
    curLocHasFixedQty : boolean;

    gridCoordFrom,gridCoordTo: TGridCoord;
    cFromRecID,cToRecID : integer;

    mainFilter, gridDefaultOrder : string;
    fieldNamesStrings : TStrings;

    procedure AddProductToList(addAfter: boolean);
    procedure MoveRow(fromRow, toRow: integer; addAfter: boolean);
    procedure AddManyProductsToList(append: boolean);
    procedure SaveListAndReloadAudit;
    function SavePromptRequired: Boolean;
  public
    { Public declarations }
    siteIDstr, curLocName, curLocIDstr, curDivision, curDivIDstr: string;
    formH, formW : integer;

    fieldSizes: array[1..10] of string;
    fieldPositions : array[1..10] of smallint;

    procedure ReloadProducts;
    procedure ReloadList;
    procedure SetMainFilter;

    procedure SetGridFields(initial: boolean);
  end;

var
  fLocationList: TfLocationList;

implementation

uses uADO , udata1, uRepSP;   // , ulog

const
  FieldStrings: array[1..10] of string =
       ('Category',
        'Sub-Category',
        'Product ID',
        'Product Name',
        'Unit',
        'In List',
        'Description',
        'Barcodes',
        'Imp/Exp Ref',
        'Default Supplier');

   //     format: 'string'#9'size'#9'string'#9#9

   FieldDefSizes: array[1..10] of string =
       ('18','18','12','30','10','3','30','3','14','20');

{$R *.dfm}

function DumpTemp(tableName, id: string): Boolean;
begin
  Result := False;
  try
    dmADO.adocRun.CommandText := 'if exists (select * from dbo.sysobjects ' + #13 +
      '  where id = object_id(N''[00_' + tableName + id +']'') ' + #13 +
      '  and OBJECTPROPERTY(id, N''IsUserTable'') = 1)' + #13 +
      'drop table [00_' + tableName +  id +']' + #13 +
      '' + #13 +
      'select * into [00_' + tableName +  id +'] from [' + tableName + ']';
    dmADO.adocRun.Execute;
    Result := True;
  except
  end;
end;


////////////////////////////////////////////////////////////////////////////
///
///  2 grids on this form, the Available Products grid (gridProds) and the
///  Count Location Selected Products List (gridList).
///  User configures gridList out of gridProds using drag-and-drop, dbl-click,
///  Insert and Delete keys and buttons on the form.
///
///  For this screen gridProds shows all availalble Units for a Product, on separate rows.
///  Both grids look on Temp Tables. Both Temp Tables are re-filled whenever the Division
///  is changed and the List one whenever the Location is changed so the List one will only
///  ever hold products for one Division and one Location.
///
///  Saving is not compulsory and is prompted for before a change or exit.
///

procedure TfLocationList.FormCreate(Sender: TObject);
var
  i : integer;
begin
  with dmado.adoqRun do
  try
    close;
    sql.Clear;
    sql.Add('select * from stkLocations where Deleted = 0');
    sql.Add(' and SiteCode = ' + intToStr(data1.TheSiteCode));
    open;
    first;

    lookLocation.Items.Clear;
    while not eof do
    begin
      lookLocation.Items.Add(FieldByName('LocationName').asstring + #9 + FieldByName('LocationID').asstring);
      next;
    end;
    lookLocation.ApplyList;
  finally
    Close;
  end;

  fieldNamesStrings := TStringList.Create;

  for i := 1 to 10 do
    fieldNamesStrings.Add(FieldStrings[i]);

  // default sizes
  fieldSizes[1] := '18';     // Category
  fieldSizes[2] := '18';     // Sub-Category
  fieldSizes[3] := '12';     // Product ID
  fieldSizes[4] := '30';     // Product Name
  fieldSizes[5] := '10';     // Unit
  fieldSizes[6] := '3';      // In List
  fieldSizes[7] := '30';     // Description
  fieldSizes[8] := '3';      // Barcodes
  fieldSizes[9] := '14';     // Imp/Exp Ref
  fieldSizes[10] := '20';    // Default Supplier

  // default positions, 0 is invisible
  fieldPositions[1] := 0;     // Category
  fieldPositions[2] := 1;     // Sub-Category
  fieldPositions[3] := 0;     // Product ID
  fieldPositions[4] := 2;     // Product Name
  fieldPositions[5] := 3;     // Unit
  fieldPositions[6] := 4;     // In List
  fieldPositions[7] := 5;     // Description
  fieldPositions[8] := 0;     // Barcodes
  fieldPositions[9] := 0;     // Imp/Exp Ref
  fieldPositions[10] := 0;    // Default Supplier


  gridDefaultOrder := '[Sub-Category], [Product Name], isPurchUnit, Unit';   //
  lblLocHasFixedQty.Caption := 'Fixed ' + data1.SSbig + ' Location';
end;

procedure TfLocationList.ReloadProducts;
var
  expectedItems : integer;
begin
  with dmado.adoqRun do
  try
    // first get the products with their Purchase Unit (default stock unit)
    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#AllProducts'') IS NOT NULL DROP TABLE #AllProducts');

    SQL.Add('SELECT se.[EntityCode] as [Product ID], se.[Div] as [Division], se.[Cat] as [Category], ');
    SQL.Add('se.[SCat] as [Sub-Category], se.[PurchaseName] as [Product Name], ');
    SQL.Add('CASE se.ETCode WHEN ''P'' THEN ''Prep.- '' + isNULL(p.[Retail Description], '''')' +
                            'ELSE p.[Retail Description] END  as Description,');
    SQL.Add('CASE se.ETCode WHEN ''P'' THEN se.ETCode ELSE '''' END as [Prep Item],');
    SQL.Add('se.[PurchaseUnit] as Unit, 1 as IsPurchUnit, 0 as [In List], 0 as Expected, 0 as InOtherLists,');
    SQL.Add('0 as Barcodes, p.[Import/Export Reference] as [Imp/Exp Ref], p.[Default Supplier]');

    SQL.Add('INTO #AllProducts');
    SQL.Add('FROM stkEntity se');
    SQL.Add('JOIN products p on se.EntityCode = p.EntityCode');
    SQL.Add('WHERE se.[EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')');
    SQL.Add('and se.DivIx = ' + curDivIDstr);
    ExecSQL;

    if data1.ssDebug then DumpTemp('#AllProducts', '1');

    // now add records for any other units found in PurchaseUnits ...
    SQL.Clear;
    SQL.Add('INSERT #AllProducts ([Product ID], [Division], [Category], [Sub-Category], [Product Name],');
    SQL.Add('    Description, [Prep Item], Unit, isPurchUnit, [In List], Expected, InOtherLists,');
    SQL.Add('    Barcodes, [Imp/Exp Ref], [Default Supplier])');
    SQL.Add('SELECT l.[Product ID], l.[Division], l.[Category], l.[Sub-Category], l.[Product Name],');
    SQL.Add('  l.Description, l.[Prep Item], pu.[Unit Name], 2, 0, 0, 0, 0, [Imp/Exp Ref], [Default Supplier]');
    SQL.Add('FROM #AllProducts l');
    SQL.Add('JOIN (select distinct [Entity Code], [Unit Name] from PurchaseUnits) pu ');
    SQL.Add('  on (l.[Product ID] = pu.[Entity Code] and l.Unit <> pu.[Unit Name])');
    ExecSQL;


    // get the number of Barcodes...
    SQL.Clear;
    SQL.Add('UPDATE #AllProducts SET Barcodes = sq1.Barcodes');
    SQL.Add('FROM (SELECT entitycode, count(*) as Barcodes from ProductBarcode group by EntityCode) sq1');
    SQL.Add('WHERE #AllProducts.[product id] = sq1.entitycode');
    ExecSQL;

    // mark the products expected to be on site by the last Stock taken for this Div.
    // These are prods with existing stock Level, sales, purch, etc. in the last stock
    // or in LCs since the last stock
    close;
    sql.Clear;
    sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#stkExpected''))');
    sql.Add('   DROP TABLE [#stkExpected]');
    execSQL;

    Close;
    sql.Clear;
    sql.Add('select distinct [entitycode] INTO [#stkExpected] from stkECLevel');
    sql.Add('where division = ' + quotedStr(curDivision));
    sql.Add('and (([PurQty] <> 0) or ([Transfers] <> 0) or ([TheoRed] <> 0) or ([TrueECL] <> 0) or');
    sql.Add('  ([ECL] <> 0) or ([SCVar] <> 0))');
    execSQL;

    Close;
    sql.Clear;
    sql.Add('INSERT [#stkExpected] (entitycode)');
    sql.Add('SELECT distinct entitycode from stkMain m');
    sql.Add(' JOIN (select top 1 tid, StockCode from Stocks');
    sql.Add('       where division = ' + quotedStr(curDivision) + ' order by EDT Desc) s');
    sql.Add(' ON m.Tid = s.Tid and m.StkCode = s.StockCode');

    sql.Add('WHERE (("OpStk" <> 0) or ("MoveQty" <> 0) or ("PurchStk" <> 0) ' +
        ' or ("ThRedQty" <> 0) or ("ThCloseStk" <> 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0)' +
        ' or ("WastePC" <> 0) or ("Wastage" <> 0))');
    execSQL;

    // now mark them
    SQL.Clear;
    SQL.Add('UPDATE #AllProducts SET Expected = 1');
    SQL.Add('FROM (SELECT distinct entitycode from [#stkExpected]) sq1');
    SQL.Add('WHERE #AllProducts.[product id] = sq1.entitycode');
    expectedItems := ExecSQL;

    // now mark the records from the product list that are already in other lists
    SQL.Clear;
    SQL.Add('UPDATE #AllProducts SET inOtherLists = sq1.theCount');
    SQL.Add('FROM (SELECT entitycode, COUNT(distinct LocationID) as theCount ');
    SQL.Add('      FROM stkLocationLists  WHERE Deleted = 0');
    SQL.Add('      and DivisionID = ' + curDivIDstr + ' and LocationID <> ' + curLocIDstr);
    SQL.Add('      GROUP BY entitycode) sq1');
    SQL.Add('WHERE #AllProducts.[product id] = sq1.entitycode');
    ExecSQL;

    if data1.ssDebug then DumpTemp('#AllProducts', '2');
  finally
    Close;
  end;

  adotProds.Close;
  adotProds.Open;

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;

  cbShowExpectedOnly.Checked := (expectedItems > 0); // by default show Expected Items only except when none expected...
  cbShowExpectedOnlyClick(self);
end;

procedure TfLocationList.ReloadList;

  procedure RebuildLocationListGrid();
  begin
    //Refactor - there are various odd bits here.  See the individual commets.
    //EB 28/2/2018

    with dmado.adoqRun do
    try
      //TODO: The if..then..else block contains too much repitition.
      //EB 28/2/2018
      if curLocHasFixedQty then
      begin
        close;
        sql.Clear;
        sql.Add('select * from #LocationList');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('FixedQty').asstring = '' then
            FieldByName('StringFixedQty').AsString := ''
          else
            FieldByName('StringFixedQty').AsString :=
              data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('FixedQty').asfloat);
          post;
          next;
        end;

        //TODO: Reference to gridList.DataSource.DataSet is not needed.
        //EB 28/2/2018
        with gridList, gridList.DataSource.DataSet do   // grid field names, etc...
        begin
          DisableControls;
          Selected.Clear;

          //TODO: This block is repeated with the block in the next
          //branch and I can't see why we can't have the if around the
          //'StringFixedQty' addition.
          //EB 28/2/2018
          Selected.Add('RecID'#9'4'#9'Row'#9'T');
          Selected.Add('Name'#9'30'#9'Product Name'#9'T');
          Selected.Add('Unit'#9'10'#9'Unit'#9'T');
          Selected.Add('StringFixedQty'#9'9'#9'Fixed Qty'#9'F');
          Selected.Add('inList'#9'4'#9'Entries'#9'T');
          Selected.Add('SCat'#9'20'#9'Sub-Category'#9'T');
          Selected.Add('Descr'#9'30'#9'Description'#9'T');

          gridList.ApplySelected;

          if not (Wwdbigrd.dgEditing in gridList.Options) then
          begin
            gridList.Options := gridList.Options + [Wwdbigrd.dgEditing];
            gridList.Options := gridList.Options - [Wwdbigrd.dgRowSelect];
          end;

          //TODO: This message is *almost* identical to the one further on but not quite!
          //EB 28/2/2018
          lblTopInfo.Caption := 'Products Grid: use Buttons or Drag-Drop, Dbl-Click,' +
                ' "Ins" key to Insert in List; Drag-Drop, "Space" key to Append to List.' + #13 +
                'List Grid Re-order: Drag-and-Drop or Ctrl - Home/Up/Down/End keys;' +
                ' Remove from List: Dbl-Click or use button.';

          EnableControls;
        end;
      end
      else
      begin
        with gridList do   // grid field names, etc...
        begin
          DisableControls;
          Selected.Clear;

          //TODO: What does the #9#9 mean at the ens of the selection additions?
          //I thought the last field is 'read-only' status...  Looks wrong to me.
          //EB 28/2/2018
          Selected.Add('RecID'#9'4'#9'Row'#9#9);
          Selected.Add('Name'#9'30'#9'Product Name'#9'F');
          Selected.Add('Unit'#9'10'#9'Unit'#9#9);
          Selected.Add('inList'#9'4'#9'Entries'#9#9);
          Selected.Add('SCat'#9'20'#9'Sub-Category'#9#9);
          Selected.Add('Descr'#9'30'#9'Description'#9'F');

          gridList.ApplySelected;

          if (Wwdbigrd.dgEditing in gridList.Options) then
          begin
            gridList.Options := gridList.Options - [Wwdbigrd.dgEditing];
            gridList.Options := gridList.Options + [Wwdbigrd.dgRowSelect];
          end;
          lblTopInfo.Caption := 'Products Grid: use Buttons or Drag-Drop, Dbl-Click,' +
                ' "Ins" key to Insert in List; Drag-Drop, "Space" key to Append to List.' + #13 +
                'List Grid Re-order: Drag-and-Drop or Ctrl - Home/Up/Down/End keys;' +
                ' Remove from List: "Del" key, Dbl-Click or use button.';

          EnableControls;
        end;
      end;
    finally
      Close;
    end;
  end;

begin
  with dmado.adoqRun do
  try
    // is this a Fixed Stock Location?
    Close;
    sql.Clear;
    sql.Add('select HasFixedQty from stkLocations');
    SQL.Add('WHERE SiteCode = ' + siteIDstr);
    SQL.Add('AND LocationID = ' + curLocIDstr);
    Open;
    curLocHasFixedQty := fieldByName('HasFixedQty').asBoolean;
    close;

    // temp table #LocationList has to have a fixed order that also allows insertion and re-ordering
    // it uses a clustered index where the "primary" ordering is done by RecID with RecID2 being 1 most of the time
    // Records can be inserted or moved only one at a time.
    // So, when a record is inserted in front of the current 6th record the new record gets RecID = 6 and RecID2 = 0
    // thus appearing "in front" of the old 6th record. If the need is to place it behind, then it gets RecID2 = 2 (but
    // in this implementation this is only for the last record). The table is then looped through and the
    // field RecID is renumbered and RecID2 is reset to 1 ready for the next re-order.
    StockLocationService.CreateLocationListTempTable();

    // load Products already in the Location in Location List grid...
    SQL.Clear;
    SQL.Add('INSERT INTO #LocationList ([RecID],[EntityCode],[Unit],[ManualAdd],[SCat],[Name],[Descr], ');
    SQL.Add('   [isPrepItem], [isPurchUnit], [recid2], inList, FixedQty, StringFixedQty)');
    SQL.Add('Select ll.[RecID],ll.[EntityCode],ll.[Unit],ll.[ManualAdd], se.[SCat], se.[PurchaseName], ');
    SQL.Add('CASE se.ETCode WHEN ''P'' THEN ''Prep.- '' + isNULL(p.[Retail Description], '''')' +
                            'ELSE p.[Retail Description] END  as Descr,');
    SQL.Add('CASE se.ETCode WHEN ''P'' THEN se.ETCode ELSE '''' END as isPrepItem, ');
    SQL.Add('CASE WHEN se.PurchaseUnit = ll.Unit THEN 1 ELSE 0 END as isPurchUnit, 1, 0, FixedQty, NULL');
    SQL.Add('FROM [stkLocationLists] ll');
    SQL.Add('   join stkEntity se on ll.EntityCode = se.EntityCode');
    SQL.Add('   join products p on se.EntityCode = p.EntityCode');
    SQL.Add('WHERE ll.SiteCode = ' + siteIDstr);
    SQL.Add('and ll.DivisionID = ' + curDivIDstr);
    SQL.Add('AND ll.LocationID = ' + curLocIDstr);
    SQL.Add('and ll.Deleted = 0');
    ExecSQL;

    StockLocationService.UpdateCountOfProductsInTempLocationList();
    StockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
  finally
    Close;
  end;

  RebuildLocationListGrid();

  adotProds.Requery;
  adotList.Close;
  adotList.Open;
  btnSave.Enabled := False;
  btnReturnChangeList.Enabled := False;
  lblLocHasFixedQty.Visible := curLocHasFixedQty;
end;

procedure TfLocationList.btnSaveClick(Sender: TObject);
begin
  if gridList.DataSource.DataSet.State in [dsEdit, dsInsert] then
    gridList.DataSource.DataSet.Post;
  with dmado.adoqRun do
  try
    StockLocationService.RenumberTempLocationList();

    // For records for this Division and Location...
    // 1. update all records that are in stkLocationLists from the temp table
    // 2. set as Deleted all records in stkLocationLists that are not in the temp table
    // 3. insert from temp table in stkLocationLists what's not there already
    //    note: either 2 or 3 will happen and not both as it's all based on sequential Line No.
    //   for easier/safer SQL the "deletion" will be done first, to all records, then update.

    SQL.Clear;
    SQL.Add('UPDATE [stkLocationLists] SET Deleted = 1, LMDT = ' +
                                                quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
    SQL.Add('WHERE SiteCode = ' + siteIDstr);
    SQL.Add('AND DivisionID = ' + curDivIDstr);
    SQL.Add('AND LocationID = ' + curLocIDstr);
    ExecSQL;

    SQL.Clear;
    SQL.Add('UPDATE [stkLocationLists] SET Deleted = 0, EntityCode = sq.EntityCode, Unit = sq.Unit,');
    SQL.Add('   FixedQty = sq.FixedQty,');
    SQL.Add('   [ManualAdd] = sq.ManualAdd, LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
    SQL.Add('FROM (SELECT * FROM #LocationList) sq');
    SQL.Add('WHERE SiteCode = ' + siteIDstr);
    SQL.Add('AND DivisionID = ' + curDivIDstr);
    SQL.Add('AND LocationID = ' + curLocIDstr);
    SQL.Add('AND [stkLocationLists].RecID = sq.RecID');
    ExecSQL;


    SQL.Clear;
    SQL.Add('INSERT INTO [stkLocationLists] ([SiteCode],[LocationID], DivisionID, [RecID],[EntityCode],');
    SQL.Add('         [Unit],[ManualAdd],[Deleted], FixedQty,[LMDT])');
    SQL.Add('Select ' + siteIDstr + ', ' + curLocIDstr + ',' + curDivIDstr + ',ll.[RecID],[EntityCode],');
    SQL.Add('         [Unit],[ManualAdd],0,FixedQty,' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)) );
    SQL.Add('FROM #LocationList ll');
    SQL.Add(' LEFT OUTER join (SELECT RecID FROM stkLocationLists');
    SQL.Add('             WHERE SiteCode = ' + siteIDstr);
    SQL.Add('             AND DivisionID = ' + curDivIDstr);
    SQL.Add('             AND LocationID = ' + curLocIDstr);
    SQL.Add('          ) sq1 ON ll.RecID = sq1.RecID ');
    SQL.Add('WHERE sq1.RecID is NULL');
    ExecSQL;

    btnSave.Enabled := FALSE;
  finally
    Close;
  end;
end;


procedure TfLocationList.AddProductToList(addAfter: boolean);
var
  i, newrecid, prodrecid: integer;
begin
  if adotProds.RecordCount = 0 then exit;

  newrecid := adotlist.RecNo;

  if newrecid < 1 then // this is for when the grid is empty...
    newrecid := 1;

  if addAfter then
    i := 2
  else
    i := 0;

  theEntityCodeString := adotProds.fieldbyname('Product ID').AsString;
  theUnitName := adotProds.fieldbyname('Unit').AsString;

  with dmado.adoqRun do
  try
    close;
    SQL.Clear;
    sql.Add('insert #LocationList (RecID, EntityCode, SCat, Name, Unit, descr, isPrepItem, isPurchUnit, recid2)');
    sql.Add('  select ' + inttostr(newrecid) +', (' + theEntityCodeString + '),  ');
    sql.Add('    (' + quotedStr(adotProds.fieldbyname('Sub-Category').AsString) + '),  ');
    sql.Add('    (' + quotedStr(adotProds.fieldbyname('Product Name').AsString) + '),  ');
    sql.Add('    (' + quotedStr(theUnitName) + '),   ');
    sql.Add('    (' + quotedStr(adotProds.fieldbyname('description').AsString) + '),');
    sql.Add('    (' + quotedStr(adotProds.fieldbyname('Prep Item').AsString) + '),  ');
    sql.Add('    (' + (adotProds.fieldbyname('isPurchUnit').AsString) + '), ' + inttostr(i));
    execSQL;

    StockLocationService.RenumberTempLocationList();
    StockLocationService.UpdateCountOfProductsInTempLocationList();
    StockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
  finally
    Close;
  end;

  prodRecID := adotProds.RecNo;
  adotList.DisableControls;
  adotProds.DisableControls;
  try
    adotList.Requery;
    if i = 0 then
      adotList.RecNo := newrecid
    else
      adotList.RecNo := newrecid +1;

    adotProds.Requery;
    if adotProds.RecordCount > 0 then
      adotProds.RecNo := prodRecID;
    btnSave.Enabled := True;
    btnReturnChangeList.Enabled := (btnReturnChangeList.Visible);
  finally
    adotList.EnableControls;
    adotProds.EnableControls;
  end;
end;

procedure TfLocationList.AddManyProductsToList(append: boolean);
var
  i, newrecid, prodrecid: integer;
begin
  if adotProds.RecordCount = 0 then exit;

  if append then
    newrecid := adotlist.RecordCount
  else
    newrecid := adotlist.RecNo;

  if newrecid < 1 then  newrecid := 1;// this is for when the grid is empty...


  prodRecID := adotProds.RecNo;
  adotProds.DisableControls;

  with dmado.adoqRun do
  try
    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#MultiAppend'') IS NOT NULL DROP TABLE #MultiAppend');
    SQL.Add('CREATE TABLE #MultiAppend (  ');
    SQL.Add('  [RecID] [int] NULL,  [ProductID] [float] NULL,  [Unit] [varchar] (10) NULL, [recid2] [int] NULL) ');
    ExecSQL;

    SQL.Clear;
    for i := 0 to gridProds.SelectedList.Count - 1 do
    begin
      adotProds.GotoBookmark(gridProds.SelectedList.items[i]);

      SQL.Add('insert #MultiAppend (RecID, ProductID, Unit, recid2)');
      SQL.Add('select ' + inttostr(newrecid) + ', ' + adotProds.fieldbyname('Product ID').AsString + ',  ' +
           '' + quotedStr(adotProds.fieldbyname('Unit').AsString) + ',   ' + inttostr(i+2));
    end;
    ExecSQL;

    SQL.Clear;
    SQL.Add('insert #LocationList (RecID, EntityCode, SCat, Name, Unit, descr, isPrepItem, isPurchUnit, recid2)');
    SQL.Add('SELECT m.RecID, m.ProductID, a.[Sub-Category], a.[Product Name], a.Unit , a.description, ');
    SQL.Add('              a.[Prep Item], a.isPurchUnit, m.recid2');
    SQL.Add('FROM #AllProducts a JOIN #MultiAppend m');
    SQL.Add('ON a.[Product ID] = m.ProductID and a.Unit = m.Unit ');
    execSQL;

    StockLocationService.RenumberTempLocationList();
    StockLocationService.UpdateCountOfProductsInTempLocationList();
    StockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
  finally
    Close;
  end;

  adotList.DisableControls;
  try
    adotList.Requery;
    adotList.RecNo := newrecid +1;

    adotProds.Requery;
    if adotProds.RecordCount > 0 then
      adotProds.RecNo := prodRecID;
    btnSave.Enabled := True;
    btnReturnChangeList.Enabled := (btnReturnChangeList.Visible);
  finally
    adotList.EnableControls;
    adotProds.EnableControls;
  end;
end;


procedure TfLocationList.btnInsertClick(Sender: TObject);
begin
  if gridProds.SelectedList.Count > 1 then
    AddManyProductsToList(FALSE)
  else
    AddProductToList(TRUE);
end;

procedure TfLocationList.btnAppendClick(Sender: TObject);
begin
  if adotlist.RecordCount > 0 then
    adotlist.RecNo := adotlist.RecordCount;

  if gridProds.SelectedList.Count > 1 then
    AddManyProductsToList(FALSE)
  else
    AddProductToList(TRUE);
end;


procedure TfLocationList.gridProdsDblClick(Sender: TObject);
begin
  btnInsertClick(self);
end;


//  //  type
//  //    TDBGHack = class (TDbGrid)
//  //    end;
//  //
//  //  procedure TFormDrag.DBGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
//  //  var
//  //    gc: TGridCoord;
//  //  begin
//  //    gc := TDBGHack (DbGrid1).MouseCoord (x, y);
//  //    if (gc.y > 0) and (gc.x > 0) then
//  //    begin
//  //      DbGrid1.DataSource.DataSet.MoveBy (gc.y - TDBGHack(DbGrid1).Row);
//  //      DbGrid1.DataSource.DataSet.Edit;
//  //      DBGrid1.Columns.Items [gc.X - 1].Field.AsString := EditDrag.Text;
//  //    end;
//  //    DBGrid1.SetFocus;
//  //  end;
//  //
//  //  ================================================
//  //  The first operation determines the cell over which the mouse was released.
//  //  Starting with the x and y mouse coordinates, you can call the protected MouseCoord
//  //  method to access the row and column of the cell.
//  //  Unless the drag target is the first row (usually hosting the titles) or the first column
//  //  (usually hosting the indicator), the program moves the current record by the difference
//  //  between the requested row (gc.y) and the current active row (the grid's protected Row property).
//  //  The next step puts the dataset into edit mode, grabs the field of the target column
//  //  (Columns.Items [gc.X - 1].Field), and changes its text.

//  // also see: http://caryjensen.blogspot.co.uk/2012/08/dragging-and-dropping-into-dbgrids.html
//  //      and: http://caryjensen.blogspot.co.uk/2013/08/dragging-and-dropping-in-dbgrids.html

//  //  Get the dataset's record number from the grid's visible row number; You need to use class helper or
//  //  TUnprotectedGrid(aTDBGrid) (THackGrid) to get access to the Row and TopRow protected properties of TCustomGrid...
//  //
//  //  function TDBGridHelper.RecNoFromVisibleRow(Value: Integer): Integer;
//  //  begin
//  //    if Value = -1 then
//  //    begin
//  //      Result := DataSource.DataSet.RecNo - Row + TopRow + VisibleRowCount
//  //    end
//  //    else
//  //    begin
//  //      Result := DataSource.DataSet.RecNo - Row + TopRow + Value;
//  //      if dgTitles in Options then
//  //        Dec(Result);
//  //    end;
//  //  end;



//  //    if gdSelected in State then
//  //    begin
//  //      canvas.Brush.Color := clRed;
//  //      rect1.Left := Rect.Left;
//  //      rect1.Top := Rect.Top - 2;
//  //      rect1.Right := Rect.Right;
//  //      rect1.Bottom := Rect.Top + 4;
//  //      canvas.FillRect(rect1);
//  //    end;

//  //  Mouse wheel behaves strangely with dbgrids - this code handler will correct this behavior.
//  //  Just drop a TApplicationEvents ("Additional" tab on the Component Palette) component on a form
//  //  and handle it's OnMessage event as:
//  //  .~~~~~~~~~~~~~~~~~~~~~~~~~
//  //  procedure TForm1.ApplicationEvents1Message
//  //     (var Msg: TMsg; var Handled: Boolean) ;
//  //  var
//  //     i: SmallInt;
//  //  begin
//  //     if Msg.message = WM_MOUSEWHEEL then
//  //     begin
//  //
//  //
//  //
//  //  Msg.message := WM_KEYDOWN;
//  //       Msg.lParam := 0;
//  //       i := HiWord(Msg.wParam) ;
//  //       if i > 0 then
//  //         Msg.wParam := VK_UP
//  //       else
//  //         Msg.wParam := VK_DOWN;
//  //
//  //       Handled := False;
//  //     end;
//  //  end;
//  //  ~~~~~~~~~~~~~~~~~~~~~~~~~
//  //
//  //.Note: This fixes the mouse wheel behavior not only for DBGrid-s but for all other list component (TListBox, TListView, etc).


procedure TfLocationList.MoveRow(fromRow, toRow: integer; addAfter: boolean);
begin
  if fromRow = toRow then
    exit; // nothing to do...

  adotList.DisableControls;
  try
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('UPDATE #LocationList SET RecID = ' + inttostr(toRow) + ', ');
        if addafter then  SQL.Add(' RecID2 = 2')
        else              SQL.Add(' RecID2 = 0');
      SQL.Add('WHERE #LocationList.RecID = ' + inttostr(fromRow));
      ExecSQL;

      StockLocationService.RenumberTempLocationList();
    end;

    adotList.Requery;

    if (fromRow < toRow) and (not addAfter) then
      adotList.RecNo := toRow - 1
    else
      adotList.RecNo := toRow;

    btnSave.Enabled := True;
    btnReturnChangeList.Enabled := (btnReturnChangeList.Visible);
  finally
    adotList.EnableControls;
  end; 
end;


procedure TfLocationList.gridListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  // accept the drop?

  gridCoordTo := gridList.MouseCoord(X,Y);

  if Source = gridList then  // re-order from the List grid...
  begin
    // what is the current row?
    cToRecID := gridList.DataSource.DataSet.fieldbyname('RecID').asinteger;

    if gridCoordTo.Y = -1 then  // if the mouse is beyond the last record then add it AFTER the last record...
      MoveRow(cFromRecID, cToRecID, TRUE)
    else                     // otherwise add it BEFORE the record under the mouse...
      MoveRow(cFromRecID, cToRecID, FALSE);
  end
  else if Source = gridProds then  // insert from All Products grid...
  begin
    // if the mouse is beyond the last record then add it AFTER the last record...
    // otherwise add it BEFORE the record under the mouse...
    AddProductToList(gridCoordTo.Y = -1);
  end;
end;

procedure TfLocationList.gridListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  try
    if (Source = gridProds) or (Source = gridList) then
    begin
      Accept := True;
      gridCoordTo := gridList.MouseCoord(X,Y);

      if (gridCoordTo.Y = 0)  then // title row... and (adotList.recno >= 1)
      begin
        scrollState := 1;

        if Y < 3 then
          ScrollTimer.Interval := 100
        else
          ScrollTimer.Interval := 200;

        ScrollTimer.Enabled := True;
      end
      else if (gridCoordTo.Y = -1) then // below bottom row...
      begin
        scrollState := 2;

        if Y > gridList.Height - 7 then
          ScrollTimer.Interval := 100
        else
          ScrollTimer.Interval := 200;

        ScrollTimer.Enabled := True;
      end
      else
      begin
        scrollstate := 0;
        ScrollTimer.Enabled := False;
        adotList.MoveBy(gridCoordTo.Y - TUnprotectedGrid(gridlist).Row);
      end;
    end
    else
    begin
      Accept := false;
    end;
  except
    on E:exception do
    begin
      showmessage('Dragging Error: ' + E.Message);
      EndDrag(False);
    end;
  end;
end;

procedure TfLocationList.gridListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    if (gridList.DataSource.DataSet.RecordCount > 0) then
    begin
      With (sender as TwwDBGrid) do
      begin
        gridCoordFrom := gridList.MouseCoord(X,Y);
        if (gridCoordFrom.Y > 0) and (gridCoordFrom.X > 0) then // not for titles, indicator, white space and scroll bars
        begin
          gridList.BeginDrag(False);
          cFromRecID := gridList.DataSource.DataSet.fieldbyname('RecID').asinteger;
        end;
      end;
    end; //if
  end;
end;

procedure TfLocationList.ScrollTimerTimer(Sender: TObject);
begin
  case scrollState of
    1 : begin
            gridList.DataSource.DataSet.MoveBy(-1);
            gridList.RedrawGrid;
            Application.ProcessMessages;
        end;
    2 : begin
            gridList.DataSource.DataSet.MoveBy(1);
            gridList.RefreshDisplay;
            Application.ProcessMessages;
        end;
  else ScrollTimer.Enabled := False;
  end;
end;

procedure TfLocationList.gridListEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  scrollState := 0;
  scrollTimer.Enabled := False;
end;

procedure TfLocationList.gridProdsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if  (Field.FieldName = 'Unit') then  // (Field.FieldName = 'Descr') or
  begin
    if adotProds.FieldByName('isPurchUnit').asinteger = 1 then
    begin
      aFont.Style := [fsBold];
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else   if  (Field.FieldName = 'Product Name') then  // (Field.FieldName = 'Descr') or
  begin
    if adotProds.FieldByName('Prep Item').asstring = 'P' then
    begin
      if gdSelected in State then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end;
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else  if  (Field.FieldName = 'StringFixedQty') then
  begin
    aBrush.Color := clWindow;
    aFont.Color := clWindowText;
  end;
end;

procedure TfLocationList.gridListCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if (TUnprotectedGrid(gridlist).DataLink.ActiveRecord + 1 =
      TUnprotectedGrid(gridlist).Row)
  or (gdFocused in State) or (gdSelected in State) then
  begin
    gridList.Canvas.Brush.Color := clHighlight;
    gridList.Canvas.Font.Color := clHighlightText;
  end;

  if  (Field.FieldName = 'Unit') then
  begin
    if adotList.FieldByName('isPurchUnit').asinteger = 1 then
    begin
      aFont.Style := [fsBold];
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else  if  (Field.FieldName = 'RecID') then
  begin
    if adotList.FieldByName('manualadd').asboolean then
    begin
      aBrush.Color := clAqua;
      aFont.Style := [fsBold];
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else  if  (Field.FieldName = 'Name') then  // (Field.FieldName = 'Descr') or
  begin
    if adotList.FieldByName('isPrepItem').asstring = 'P' then
    begin
      if gdSelected in State then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end;
    end
    else
    begin
      aFont.Style := [];
    end;
  end;
end;

procedure TfLocationList.gridProdsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  gridCoordProd : TGridCoord;
begin
  if Button = mbLeft then
  begin
    if gridProds.DataSource.DataSet.RecordCount > 0 then
    begin
      With (sender as TwwDBGrid) do
      begin
        gridCoordProd := gridProds.MouseCoord(X,Y);
        if (gridCoordProd.Y > 0) and (gridCoordProd.X > 0) then // not for titles, indicator, white space and scroll bars
        begin
          gridProds.BeginDrag(False);
        end;
      end;
    end; //if
  end;
end;


procedure TfLocationList.lookDivCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  // any editing? Do you want to save?
  if SavePromptRequired then
  begin
    case MessageDlg('You have made changes to the Location Count List.'+#13+#10+' '+#13+#10+
              'Do you want to save those changes before switching away '+#13+#10+
              'from Division "'+ curDivision +'"?', mtConfirmation, [mbYes,mbNo,mbCancel], 0) of
      mrYes: begin
               btnSaveClick(self);
             end;
      mrCancel:
             begin // stay with the current Division...
               lookDiv.ItemIndex := lookDiv.Items.IndexOf(curDivision + #9 + curDivIDstr);
               lookDiv.Text := curDivision;
               exit;
             end;
      // for mrNo (or else) just do nothing, change continues and edits are NOT saved...
    end;
  end;

  curDivision := lookDiv.Text;
  curDivIDstr := lookDiv.Value;

  // re-fill Cat and SubCat dropdowns
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkEntity');
    sql.add('  where divix = ' + curDivIDstr);
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    lookCat.Items.Clear;
    while not eof do
    begin
      lookCat.Items.Add(FieldByName('cat').asstring);
      next;
    end;
    close;
    lookCat.Refresh;
    lookCat.ItemIndex := 0;
  end;

  ReloadProducts;
  ReloadList;

  btnResetFiltersClick(self); // turns filters off, resets SCat lookup...
end;

procedure TfLocationList.lookLocationCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  // any editing? Do you want to save?
  if SavePromptRequired then
  begin
    case MessageDlg('You have made changes to the Location Count List.'+#13+#10+' '+#13+#10+
              'Do you want to save those changes before switching away '+#13+#10+
              'from Location "'+ curLocName +'"?', mtConfirmation, [mbYes,mbNo,mbCancel], 0) of
      mrYes: begin
               btnSaveClick(self);
             end;
      mrCancel:
             begin // stay with the current Division...
               lookLocation.ItemIndex := lookLocation.Items.IndexOf(curLocName + #9 + curLocIDstr);
               lookLocation.Text := curLocName;
               exit;
             end;
      // for mrNo (or else) just do nothing, change continues and edits are NOT saved...
    end;
  end;

  curLocName := lookLocation.Text;
  curLocIDstr := lookLocation.Value;

  ReloadProducts;    // may not be needed...
  ReloadList;

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;

  Application.ProcessMessages;
end;

procedure TfLocationList.DeleteBitBtnClick(Sender: TObject);
var
  delrecid, prodrecid: integer;
begin
  delrecid := adotlist.fieldByName('RecID').asinteger;

  if delrecid < 1 then // this is for when the grid is empty, nothing to delete, get out...
    exit;

  if (btnReturnChangeList.Visible) and (adotList.RecordCount < 2) then // cannot delete the last product in this mode...
  begin
    showMessage('You cannot empty the Location List in "Quick Change" mode (from Audit screen "Edit List").');
    exit;
  end;

  with dmado.adoqRun do
  try
    close;
    SQL.Clear;
    sql.Add('Delete #LocationList where RecID = ' + inttostr(delrecid));
    execSQL;

    StockLocationService.RenumberTempLocationList();
    StockLocationService.UpdateCountOfProductsInTempLocationList();
    StockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
  finally
    Close;
  end;

  prodRecID := adotProds.RecNo;
  adotList.DisableControls;
  adotProds.DisableControls;
  try
    adotList.Requery;
    if adotList.RecordCount > 0 then
      adotList.RecNo := delrecid;
    adotProds.Requery;
    if adotProds.RecordCount > 0 then
      adotProds.RecNo := prodRecID;
    btnSave.Enabled := True;
    btnReturnChangeList.Enabled := (btnReturnChangeList.Visible);
  finally
    adotList.EnableControls;
    adotProds.EnableControls;
  end;
end;

procedure TfLocationList.editMoveKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    btnMoveToClick(self);
  end
  else
  begin
    // remember #8 backspace, #27 escape, #9 tab
    if not (key in ['0'..'9', #8, #27]) then
      Key := #0;
  end; 
end;

procedure TfLocationList.btnDoneClick(Sender: TObject);
begin
  if SavePromptRequired then
  begin
    case MessageDlg('You have made changes to the "'+ curLocName +'" Location Count List.'+#13+#10+' '+#13+#10+
              'Do you want to save those changes before exiting?', mtConfirmation, [mbYes,mbNo,mbCancel], 0) of
      mrYes: begin
               btnSaveClick(self);
             end;
      mrCancel:
             begin // stay with the current Division...
               modalResult := mrNone;
             end;
      // for mrNo (or else) just do nothing, exit continues and edits are NOT saved...
    end;
  end;
end;

procedure TfLocationList.btnDiscardClick(Sender: TObject);
begin
  //ReloadProducts;
  ReloadList;
end;

procedure TfLocationList.btnMoveToClick(Sender: TObject);
var
  i : integer;
begin
  try
    i := strtoint(editMove.Text);
  except
    exit;
  end;

  if adotlist.fieldByName('RecID').asinteger = i then exit;
  if i < 1 then i := 1;

  MoveRow(adotlist.fieldByName('RecID').asinteger, i, (adotlist.fieldByName('RecID').asinteger < i));
end;


procedure TfLocationList.gridListDblClick(Sender: TObject);
begin
  DeleteBitBtnClick(self);
end;

procedure TfLocationList.gridProdsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = gridList then
  begin
    DeleteBitBtnClick(self);
  end;
end;

procedure TfLocationList.gridProdsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = gridList);
end;

procedure TfLocationList.gridProdsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  scrollState := 0;
  scrollTimer.Enabled := False;
end;

procedure TfLocationList.btnRemoveProductClick(Sender: TObject);
var
  delrecid, prodrecid: integer;
  strEntityCode, strName : string;
begin
  delrecid := adotlist.fieldByName('RecID').asinteger;

  if delrecid < 1 then // this is for when the grid is empty, nothing to delete, get out...
    exit;

  strEntityCode := adotlist.fieldByName('EntityCode').asstring;
  strName := adotlist.fieldByName('Name').asstring;

  with dmado.adoqRun do
  try
    Close;
    sql.Clear;
    sql.Add('SELECT count(*) as allRecs FROM #LocationList');
    sql.Add('where EntityCode = ' + strEntityCode);
    open;

    // in Quick Change mode ensure that List is not emptied...
    if (btnReturnChangeList.Visible) and (fieldByName('allRecs').asinteger >= adotList.RecordCount) then
    begin
      showMessage('You cannot empty the Location List in "Quick Change" mode (from Audit screen "Edit List").');
      close;
      exit;
    end;

    if MessageDlg('There are ' + fieldByName('allRecs').asstring + ' rows for product "' + strName +
        '" in the current List.' +#13+#10+' '+#13+#10+ 'About to remove these rows from Location "' +
        curLocName + '".', mtConfirmation, [mbOK,mbCancel], 0) = mrCancel then
    begin
      close;
      exit;
    end;

    close;
    SQL.Clear;
    sql.Add('Delete #LocationList where EntityCode = ' + strEntityCode);
    execSQL;

    StockLocationService.RenumberTempLocationList();
    StockLocationService.UpdateCountOfProductsInTempLocationList();
    StockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
  finally
    Close;
  end;

  prodRecID := adotProds.RecNo;
  adotList.DisableControls;
  adotProds.DisableControls;
  try
    adotList.Requery;
    if adotList.RecordCount > 0 then
      adotList.RecNo := delrecid;
    adotProds.Requery;
    if adotProds.RecordCount > 0 then
      adotProds.RecNo := prodRecID;
    btnSave.Enabled := True;
    btnReturnChangeList.Enabled := (btnReturnChangeList.Visible);
  finally
    adotList.EnableControls;
    adotProds.EnableControls;
  end;
end;

procedure TfLocationList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  setString, sSizes, sPositions : string;
  i: integer;
begin
   // saving field visibility, position and size...
   setGridFields(false);
   sPositions := '';
   sSizes := '';
   for i := 0 to (gridPopup.items.Count - 1) do
   begin
    if gridPopup.Items[i].Checked then
    begin
      sPositions := sPositions + inttostr(fieldPositions[i+1]) + ', ';
      sSizes := sSizes + fieldSizes[i+1] + ', ';
    end
    else
    begin
      sPositions := sPositions + '0, ';
      sSizes := sSizes + '0, ';
    end;
   end;


  // save window and controls size/position, etc.
  setString := inttostr(self.Top) + '=WinTop ' + inttostr(self.Left) + '=WinLeft ' +
        inttostr(self.Height) +'=WinHeight ' + inttostr(self.Width) + '=WinWidth ' +
        inttostr(gridProds.Width) + '=Splitter ' + sPositions + '=Positions ' +
        sSizes + '=Sizes ';

  with dmado.adoqRun do
  begin
    close;
    sql.Clear;
    SQL.Add('IF EXISTS(SELECT * FROM LocalConfiguration');
    SQL.Add('WHERE KeyName = ''LocationListConfigWindow'' and SiteCode = '+ siteIDstr + ')');
    SQL.Add(' UPDATE LocalConfiguration ');
    SQL.Add(' SET StringValue = ' + quotedStr(setString));
    SQL.Add(' WHERE KeyName = ''LocationListConfigWindow'' and SiteCode = '+ siteIDstr);
    SQL.Add('ELSE');
    SQL.Add(' INSERT LocalConfiguration ([SiteCode], [KeyName], [StringValue], [Deleted], [LMDT])');
    SQL.Add(' VALUES ('+ siteIDstr + ', ''LocationListConfigWindow'', ');
    SQL.Add(  quotedStr(setString) + ', 0, GetDate())');
    execSQL;
  end;
end;

procedure TfLocationList.FormActivate(Sender: TObject);
begin
  if formH <> -1 then
  begin
    self.Height := formH;
    self.Width := formW;
  end;
end;

procedure TfLocationList.btnFilterClick(Sender: TObject);
begin
  SetMainFilter;

  if cbShowExpectedOnly.Checked then
  begin
    if mainFilter = '' then
    begin
      adotProds.Filter := 'Expected = 1';
      showMessage('Filter conditions not set. No Filtering is done.');
      lblFilterStatus.Color := clGreen;
      lblFilterStatus.Caption := 'Filtering is OFF';
    end
    else
    begin
      adotProds.Filter := mainFilter + ' and Expected = 1';
      lblFilterStatus.Color := clRed;
      lblFilterStatus.Caption := 'Filtering is ON';
    end;

    adotProds.Filtered := TRUE;
  end
  else
  begin
    if mainFilter = '' then
    begin
      adotProds.Filter := '';
      adotProds.Filtered := False;
      showMessage('Filter conditions not set. No Filtering is done.');
      lblFilterStatus.Color := clGreen;
      lblFilterStatus.Caption := 'Filtering' + #13 + 'is OFF';
    end
    else
    begin
      adotProds.Filter := mainFilter;
      adotProds.Filtered := True;
      lblFilterStatus.Color := clRed;
      lblFilterStatus.Caption := 'Filtering' + #13 + 'is ON';
    end;
  end;

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
end;

procedure TfLocationList.btnNoFilterClick(Sender: TObject);
begin
  wwFill.ClearFilter;

  if cbShowExpectedOnly.Checked then
  begin
    adotProds.Filter := 'Expected = 1';
    adotProds.Filtered := TRUE;
  end
  else
  begin
    adotProds.Filter := '';
    adotProds.Filtered := False;
  end;

  mainFilter := '';
  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering' + #13 + 'is OFF';

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
end;


procedure TfLocationList.SetMainFilter;
var
  s1, filtCat, filtSCat, filtNoLoc, filtThisLoc, filtName : string;
begin
  if lookCat.Text <> ' - SHOW ALL - '  then filtCat := ' and Category = ' + quotedStr(lookCat.Text);
  if lookSCat.Text <> ' - SHOW ALL - ' then filtSCat := ' and Sub-Category = ' + quotedStr(lookSCat.Text);
  if cbProdsNoLocation.Checked         then filtNoLoc := ' and InOtherLists = 0';
  if cbProdsNotThisLocation.Checked    then filtThisLoc := ' and [in List] = 0';

  s1 := trim(LowerCase(edFilt.Text));
  if s1 <> '' then
  begin
    if rbmid.Checked then
      s1 := '*' + s1;
    filtName := ' and [Product Name] LIKE ' + quotedStr(s1 + '*');   //  ' and Name LIKE ' + quotedStr(s1 + '*');
  end;

  mainFilter := filtCat + filtSCat + filtNoLoc + filtThisLoc + filtName;
  Delete(mainFilter, 1, 5);
end;


procedure TfLocationList.lookCatCloseUp(Sender: TObject);
begin
  with dmADO.adoqRun do
  begin
    if lookCat.Text = ' - SHOW ALL - ' then
    begin
      close;
      sql.Clear;
      sql.Add('select distinct scat from stkEntity');
      sql.add('  where divix = ' + curDivIDstr);
      sql.Add('union select ('' - SHOW ALL - '')');
      open;
      first;

      looksCat.Items.Clear;
      while not eof do
      begin
        looksCat.Items.Add(FieldByName('scat').asstring);
        next;
      end;
      close;
      lookSCat.Refresh;
      lookSCat.ItemIndex := 0;
    end
    else
    begin
      close;
      sql.Clear;
      sql.Add('select distinct scat from stkEntity');
      sql.add('  where divix = ' + curDivIDstr);
      sql.add('  and cat = ' + quotedStr(lookCat.Text));
      sql.Add('union select ('' - SHOW ALL - '')');
      open;
      first;

      looksCat.Items.Clear;
      while not eof do
      begin
        looksCat.Items.Add(FieldByName('scat').asstring);
        next;
      end;
      close;
      lookSCat.Refresh;
      lookSCat.ItemIndex := 0;
    end;
  end;
end;

procedure TfLocationList.cbShowExpectedOnlyClick(Sender: TObject);
begin
  // quick acting filter
  if cbShowExpectedOnly.Checked then
  begin
    if mainFilter = '' then
      adotProds.Filter := 'Expected = 1'
    else
      adotProds.Filter := mainFilter + ' and Expected = 1';

    adotProds.Filtered := TRUE;
  end
  else
  begin
    if mainFilter = '' then // the button filter is off...
    begin
      adotProds.Filter := '';
      adotProds.Filtered := FALSE;
    end
    else    // the button filter is ON, just remove the Expected...
    begin
      adotProds.Filter := mainFilter;
      adotProds.Filtered := TRUE;
    end;
  end;

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
end;

procedure TfLocationList.FormShow(Sender: TObject);
begin
  // fill Cat and SubCat dropdowns
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkEntity');
    sql.add('  where divix = ' + curDivIDstr);
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    lookCat.Items.Clear;
    while not eof do
    begin
      lookCat.Items.Add(FieldByName('cat').asstring);
      next;
    end;
    close;
    lookCat.Refresh;
    lookCat.ItemIndex := 0;

    close;
    sql.Clear;
    sql.Add('select distinct sCat from stkEntity');
    sql.add('  where divix = ' + curDivIDstr);
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    lookSCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sCat').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;
  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;

  Application.ProcessMessages;
end;

procedure TfLocationList.cbProdsNoLocationClick(Sender: TObject);
begin
  if cbProdsNoLocation.Checked then // check the "not on this list" CB as it's included..
  begin
    cbProdsNotThisLocation.Checked := TRUE;
    cbProdsNotThisLocation.Enabled := FALSE;
  end
  else
  begin
    cbProdsNotThisLocation.Checked := FALSE;
    cbProdsNotThisLocation.Enabled := TRUE;
  end;
end;

procedure TfLocationList.rbSIncClick(Sender: TObject);
begin
  incSearch1.Visible := rbsinc.Checked;
  edSearch.Visible := not incSearch1.Visible;

  if incSearch1.Visible then
  begin
    wwFind.MatchType := mtPartialMatchStart;
    incSearch1.SetFocus;
  end
  else
  begin
    wwFind.MatchType := mtPartialMatchAny;
    edSearch.SetFocus;
  end;
end;

procedure TfLocationList.btnNextSearchClick(Sender: TObject);
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;

procedure TfLocationList.btnPriorSearchClick(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
   tempTab : TADOTable;
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;

  tempTab := TADOTable(incSearch1.DataSource.Dataset); // ensures the correct Table is searched as set by user with RadioButton

  // find prior has to be done programatically...
  with tempTab do
  begin
    disablecontrols;

    { get a bookmark so that we can return to the same record }
    SavePlace := GetBookmark;
    try
      matchyes := false;

      while (not bof) do
      begin
        Prior;

        // check for match  ... incSearch1.SearchField ensures the correct field name is used depending on Table searched.
        if rbsInc.Checked then // incremental.
          matchyes := AnsiStartsText(incSearch1.Text, FieldByName(incSearch1.SearchField).asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName(incSearch1.SearchField).asstring,edSearch.Text);

        if matchyes then break;
      end;

      {if match not found Move back to the bookmark}
      if not matchyes then
      begin
        GotoBookmark(SavePlace);
        showMessage('No More Matches found!');
      end;

      { Free the bookmark }
    finally
      FreeBookmark(SavePlace);
    end;

    enablecontrols;
  end;
end;

procedure TfLocationList.rbSearchProdsClick(Sender: TObject);
begin
  if rbSearchProds.Checked then
  begin
    incSearch1.DataSource := dsProds;
    incSearch1.SearchField := 'Product Name';
  end
  else
  begin
    incSearch1.DataSource := dsList;
    incSearch1.SearchField := 'Name';
  end;

  wwFind.DataSource := incSearch1.DataSource;
  wwFind.SearchField := incSearch1.SearchField;
end;

procedure TfLocationList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_DELETE, VK_CLEAR, VK_BACK: begin
                 if gridList.HasFocus then
                 begin
                   if not (self.curLocHasFixedQty) then
                   begin
                     Key := 0;
                     DeleteBitBtnClick(self);
                   end;
                 end;
               end;
    VK_INSERT: begin
                 if gridProds.HasFocus then
                 begin
                   Key := 0;
                   btnInsertClick(Sender);
                 end;
               end;
    VK_SPACE: begin
                 if gridProds.HasFocus then
                 begin
                   Key := 0;
                   btnAppendClick(Sender);
                 end;
               end;
    VK_F2: begin
             Key := 0;
             btnPriorSearchClick(Sender);
           end;
    VK_F3: begin
             Key := 0;
             btnNextSearchClick(Sender);
           end;
    VK_F5: begin
             Key := 0;
             btnFilterClick(Sender);
           end;
    VK_F6: begin
             Key := 0;
             btnNoFilterClick(Sender);
           end;
    VK_F7: begin
             Key := 0;
             btnAdvFilterClick(Sender);
           end;
//    VK_F8: begin
//             Key := 0;
//             rbsMid.Checked := True;
//             rbSIncClick(Sender);
//           end;
  end; // case..

  if (Key = VK_HOME) and (ssAlt in Shift) then // move to top
  begin
    key := 0;
    MoveRow(adotlist.fieldByName('RecID').asinteger, 1, false);
  end
  else if (Key = VK_UP) and (ssAlt in Shift) then  // move up 1
  begin
    key := 0;
    MoveRow(adotlist.fieldByName('RecID').asinteger, adotlist.fieldByName('RecID').asinteger - 1, false);
  end
  else if (Key = VK_DOWN) and (ssAlt in Shift) then // move down 1
  begin
    key := 0;
    MoveRow(adotlist.fieldByName('RecID').asinteger, adotlist.fieldByName('RecID').asinteger + 1, true);
  end
  else if (Key = VK_END) and (ssAlt in Shift) then // move to bottom
  begin
    key := 0;
    MoveRow(adotlist.fieldByName('RecID').asinteger, adotlist.recordcount, true);
  end; 
end;

procedure TfLocationList.btnAdvFilterClick(Sender: TObject);
begin
  btnResetFiltersClick(self);

  wwFill.Execute;

  if wwFill.FieldInfo.Count > 0 then
  begin
    lblFilterStatus.Color := clRed;
    lblFilterStatus.Caption := 'Advanced' + #13 + 'Filtering' + #13 + 'is ON';
  end;

  adotProds.Requery;
  gridProds.RefreshDisplay;
  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;

  Application.ProcessMessages;
end;

procedure TfLocationList.btnResetFiltersClick(Sender: TObject);
begin
  lookcat.ItemIndex := 0;  // lookCat.Text = ' - SHOW ALL - '

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct scat from stkEntity');
    sql.add('  where divix = ' + curDivIDstr);
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('scat').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  cbProdsNoLocation.Checked := FALSE;
  cbProdsNotThisLocation.Checked := FALSE;
  edFilt.Text := '';

  wwFill.ClearFilter;

  if cbShowExpectedOnly.Checked then
  begin
    adotProds.Filter := 'Expected = 1';
    adotProds.Filtered := TRUE;
  end
  else
  begin
    adotProds.Filter := '';
    adotProds.Filtered := False;
  end;

  mainFilter := '';
  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering' + #13 + 'is OFF';

  lblProdCount.Caption := inttostr(adotProds.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;

  Application.ProcessMessages;
end;

procedure TfLocationList.gridProdsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotProds do
  begin
    DisableControls;

    if '[' + (AFieldName) + ']' = IndexFieldNames then // already Yellow, go to red...
    begin
      IndexFieldNames := '[' + AFieldName + '] DESC';
    end
    else if '[' + (AFieldName + '] DESC') = IndexFieldNames then // already Red, go to nothing...
    begin
      IndexFieldNames := gridDefaultOrder;
    end
    else
    begin
      IndexFieldNames := '[' + AFieldName + ']';
    end;

    EnableControls;
  end;

end;

procedure TfLocationList.gridProdsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if '[' + (AFieldName) + ']'  = adotProds.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if '[' + (AFieldName + '] DESC') = adotProds.IndexFieldNames then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;
end;

procedure TfLocationList.SetGridFields(initial: boolean);
var
  i, colFixedIndex : integer;
  orderedFields: array[1..22] of integer; // holds fixed column indexes in visible order in grid...
begin
   with gridProds, gridProds.DataSource.DataSet do   // grid field names, etc...
   begin
     DisableControls;

     for i := 1 to 22 do
       orderedFields[i] := 0;

     if not initial then
     begin
       for i := 1 to 10 do  // first set all as invisible in the array...
       begin
         fieldPositions[i] := 0;
       end;

       // load the size and position arrays with the current grid set as done by user...
       for i := 0 to gridProds.GetColCount - 2 do
       begin
         colFixedIndex := fieldNamesStrings.IndexOf(columns[i].DisplayLabel) + 1;

         fieldPositions[colFixedIndex] := i + 1;
         fieldSizes[colFixedIndex] := IntToStr(columns[i].DisplayWidth);
       end;

       // take the visible status from the popup in case it was just changed...
       // if a field is already visible then leave it alone
       // if a field is unticked make it invisible
       // if a field is ticked and was invisible make it visible and add it to the end and set its size to its default...
       for i := 0 to (gridPopup.items.Count - 1) do
       begin
        if gridPopup.Items[i].Checked then
        begin
          if fieldPositions[i+1] = 0 then
          begin
            fieldPositions[i+1] := i+11;
            fieldSizes[i+1] := fieldDefSizes[i+1];
          end;
        end
        else
          fieldPositions[i+1] := 0;
       end;
     end;

     // fieldPositions array now has 0s and some integers but not sequential; make it so...
     for i := 1 to 10 do
     begin
       if fieldPositions[i] > 0 then
         orderedFields[fieldPositions[i]] := i;
     end;
     
     Selected.Clear;   // now make up the selected strings...

     for i := 1 to 22 do  // in order of "orderedFields" array
     begin
       colFixedIndex := orderedFields[i];
       if colFixedIndex > 0 then  // next field's Fixed Column index
       begin
         Selected.Add(fieldStrings[colFixedIndex] + #9 + fieldSizes[colFixedIndex] +
                                                    #9 + fieldStrings[colFixedIndex] + #9#9);
       end;//     format: 'string'#9'size'#9'string'#9#9
     end;
   

     gridProds.ApplySelected;
     gridDefaultOrder := '';
     try
       if gridProds.ColumnByName('Sub-Category').DisplayWidth > 0 then
       begin
         gridDefaultOrder := '[Sub-Category], [Product Name], isPurchUnit, Unit';
       end
       else if gridProds.ColumnByName('Category').DisplayWidth > 0 then
       begin
         gridDefaultOrder := '[Category], [Product Name], isPurchUnit, Unit';
       end
       else
       begin
         gridDefaultOrder := '[Product Name], isPurchUnit, Unit';
       end;
     except
       // do nothing
     end;

     TADOTable(gridProds.DataSource.DataSet).IndexFieldNames := gridDefaultOrder;

     EnableControls;
   end;
   Application.ProcessMessages;
end;


procedure TfLocationList.Category1Click(Sender: TObject);
begin
  SetGridFields(false);
end;

procedure TfLocationList.FormDestroy(Sender: TObject);
begin
  fieldNamesStrings.Free;
end;

procedure TfLocationList.btnReturnNoChangeClick(Sender: TObject);
begin
  // back to Audit Form, no changes to the List
end;

procedure TfLocationList.btnReturnChangeListClick(Sender: TObject);
begin
  with dmado.adoqRun do
  try
    StockLocationService.RenumberTempLocationList();

    // are there any changes (as opposed to several operations that left the grid the same as it was)
    close;
    sql.Clear;
    sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#ListChanges''))');
    sql.Add('   DROP TABLE [#ListChanges]');
    execSQL;

    SQL.Clear;
    SQL.Add('select IDENTITY(int) as nRowID,  ll.*, t.RecID tRecID, t.[EntityCode] tEntityCode, ');
    SQL.Add('       t.[Unit] tUnit, t.FixedQty tFixedQty ');
    SQL.Add('into [#ListChanges]  ');
    SQL.Add('FROM ( SELECT [RecID], [EntityCode], [Unit], FixedQty FROM stkLocationLists');
    SQL.Add('        WHERE Deleted = 0 AND SiteCode = ' + siteIDstr);
    SQL.Add('        AND DivisionID = ' + curDivIDstr);
    SQL.Add('        AND LocationID = ' + curLocIDstr );
    SQL.Add('      UNION');
    SQL.Add('       SELECT [RecID], [EntityCode], [Unit], NULL FROM [#appendedToList]');
    SQL.Add('      ) ll');
    SQL.Add('FULL OUTER JOIN #LocationList t ON ll.RecID = t.RecID');
    SQL.Add('WHERE ll.EntityCode <> t.EntityCode or ll.Unit <> t.Unit or t.RecID is NULL or ll.RecID is NULL ');
    if self.curLocHasFixedQty then
      SQL.Add('      or ll.FixedQty <> t.FixedQty');
    execSQL;

    Close;
    sql.Clear;
    sql.Add('select * from [#ListChanges]');
    open;

    if recordcount = 0 then
    begin
      showMessage('The edits done did not result in an actual change to the List, there is nothing to save.');
      btnReturnChangeList.Enabled := FALSE;
      ModalResult := mrNone;
      close;
      exit;
    end;
    // now it's definite that there are changes to save...

    // can the changes be temporary (offer choice) or can they be only permanent?
    // compare the temp table with the stkLocationLists table for this Div/Loc
    SQL.Clear;
    SQL.Add('select *   ');
    SQL.Add('FROM (SELECT * FROM stkLocationLists');
    SQL.Add('      WHERE Deleted = 0 AND SiteCode = ' + siteIDstr);
    SQL.Add('      AND DivisionID = ' + curDivIDstr);
    SQL.Add('      AND LocationID = ' + curLocIDstr + ' ) ll');
    SQL.Add('LEFT OUTER JOIN #LocationList t ON ll.RecID = t.RecID');
    SQL.Add('WHERE ll.EntityCode <> t.EntityCode or ll.Unit <> t.Unit or t.RecID is NULL ');
    open;

    if recordcount = 0 then // only additions were performed...
    begin
      case MessageDlg('Existing rows in the configured Location List were NOT changed or deleted.'+#13+#10+
          'Rows appended to the end of the List can be used to enter Audit Counts for this ' + data1.SSbig + ' only '+#13+#10+
          'or they can be saved to the configured Location List used for future '+ data1.SSplural + ' as well.'+#13+#10+''+#13+#10+
          'Do you want to save the extra rows to the Location List for the use of future '+ data1.SSplural + '? '+
          #13+#10+'(click "No" to only use them for this ' + data1.SSbig + ') ', mtConfirmation, [mbYes,mbNo,mbCancel], 0) of
        mrYes :
          begin   // save and use...
            SaveListAndReloadAudit;
          end;    // save and use
        mrNo  :
          begin   // temp use only...
            // first select the records in the grid that are not in the saved List ("for this Stock only")
            close;
            sql.Clear;
            sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#ListChanges''))');
            sql.Add('   DROP TABLE [#ListChanges]');
            execSQL;

            SQL.Clear;
            SQL.Add('select IDENTITY(int) as nRowID, t.RecID tRecID, t.[EntityCode] tEntityCode, t.[Unit] tUnit ');
            SQL.Add('into [#ListChanges]  ');
            SQL.Add('FROM ( SELECT [RecID], [EntityCode], [Unit] FROM stkLocationLists');
            SQL.Add('        WHERE Deleted = 0 AND SiteCode = ' + siteIDstr);
            SQL.Add('        AND DivisionID = ' + curDivIDstr);
            SQL.Add('        AND LocationID = ' + curLocIDstr );
            SQL.Add('      ) ll');
            SQL.Add('FULL OUTER JOIN #LocationList t ON ll.RecID = t.RecID');
            SQL.Add('WHERE ll.EntityCode <> t.EntityCode or ll.Unit <> t.Unit or t.RecID is NULL or ll.RecID is NULL');
            SQL.Add('ORDER BY t.RecID');
            execSQL;

            // if there were apended rows "for this Stock only" then preserve them if possible...
            // these rows will have the same RecID (> 1000000), same EntityCode and same Unit.
            // Delete any others (with RecID > 1000000) from AuditLocationsCur to be added afterwards...

            SQL.Clear;
            SQL.Add('DELETE [AuditLocationsCur]   ');
            SQL.Add('FROM (SELECT * FROM [#ListChanges] chg FULL OUTER JOIN #appendedToList alc                ');
            SQL.Add('         ON alc.alcRecID = (chg.nRowID + 1000000)  ');
            SQL.Add('      WHERE nRowID is NULL or not ((tEntityCode = EntityCode and tUnit = Unit))) sq ');
            SQL.Add('WHERE [AuditLocationsCur].RecID = sq.alcRecID and [AuditLocationsCur].LocationID = ' + curLocIDstr);
            ExecSQL;

            // add extra record(s) to AuditLocationsCur for the appended rows to the List
              // use OpStk field to store the "appended row No." (i.e. as 1 for 1st appended row, etc.)
              // use PurchCostPU (otherwise NULL for Locations rows) to mark out these special rows

            close;
            sql.Clear;
            sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
            sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
            sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
            sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');

            sql.Add('SELECT ' + curLocIDstr + ', tll.nRowID + 1000000, b.entitycode,');
            sql.Add(' (CASE ');
            sql.Add('    WHEN (a.key2 < 1000) THEN b.purchasename'); // NORMAL items
            sql.Add('    ELSE b.retailname');                                                // 17841 - Prep.Items
            sql.Add('  END) as purchasename,');

            if data1.RepHdr = 'Sub-Category' then
              sql.Add('(b.[SCat]) as SubCatName, b.ImpExRef,')
            else
              sql.Add('(b.[Cat]) as SubCatName, b.ImpExRef,');

            sql.Add(' 0,');
            sql.Add(' (CASE  WHEN (a.key2 < 1000) THEN PurchStk'); // NORMAL items
            sql.Add('    ELSE -999999  END) as PurchStk,');    // 17841 - Prep.Items
            sql.Add('(a.ThRedQty) as ThRedQty, (a.ThCloseStk) as ThCloseStk, tll.tUnit, NULL,  ');
            sql.Add(' (CASE WHEN (tll.tUnit = a.purchunit) THEN 1 ELSE 0 END) as IsPurchUnit,');
            sql.Add('0, 0, 0, 0, NULL, 1, tll.nRowID, NULL  ');
            sql.Add('FROM StkCrDiv a, stkEntity b, ');
            SQL.Add('   (SELECT * FROM [#ListChanges] chg FULL OUTER JOIN #appendedToList alc                ');
            SQL.Add('         ON alc.alcRecID = (chg.nRowID + 1000000)  ');
            SQL.Add('    WHERE alcRecID is NULL or not ((tEntityCode = EntityCode and tUnit = Unit))) tll ');
            sql.Add('WHERE tll.tEntityCode = a.entitycode and a.entitycode = b.entitycode');
            execSQL;

            // get the Base Units for the Units ...
            close;
            sql.Clear;
            sql.Add('update auditLocationsCur set purchbaseu = sq.[base units]');
            sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
            sql.Add('where unit = sq.[unit name] and RecID > 1000000 and LocationID = ' + curLocIDstr);
            execSQL;


            // check if the Product(s) in question have an entry in Location 999 (which means that until this
            //    addition they were not presetn in any Location). If so, delete those rows from AuditLocationsCur.
            close;
            sql.Clear;
            sql.Add('delete auditLocationsCur ');
            sql.Add('from auditLocationsCur a JOIN [#ListChanges] tll');
            sql.Add('on a.LocationID = 999 and a.EntityCode = tll.tEntityCode');
            execSQL;


            if data1.IncludePrepItemsInAudit then
            begin
              close;
              sql.Clear;
              sql.Add('update auditLocationscur set ThRedQty = sq.theCount');
              sql.Add('from');
              sql.Add('  (select sq1.Child, COUNT (DISTINCT t.Parent) as TheCount ');
              sql.Add('   from (select s1.* from ');
              sql.Add('     (select * from auditLocationscur a where PurchStk = -999999) ac ');
              sql.Add('     inner join ');
              sql.Add('     (select r.Child, r.Parent from stk121Rcp r where r.Ctype = ''P'' and r.Ptype is NULL) s1 ');
              sql.Add('     on ac.EntityCode = s1.Child) sq1');
              sql.Add('   inner join stkTRtemp t on t.Parent = sq1.Parent');
              sql.Add('   group by Child  ) sq');
              sql.Add('where auditLocationscur.entitycode = sq.Child');
              execSQL;
            end;

            // markup records depending if they should be there or not based on open/purch/move/sold/waste/thclose
            close;
            sql.Clear;
            sql.Add('update auditLocationscur set ShouldBe = 0');
            sql.Add('where (   ("OpStk" <> 0)');
            sql.Add('       or (("PurchStk" <> 0) and ("PurchStk" <> -999999))');
            sql.Add('       or ("ThRedQty" <> 0)');
            sql.Add('       or ("ThCloseStk" <> 0)');
            sql.Add('       or ("WasteTill" <> 0)');
            sql.Add('       or ("WastePC" <> 0)');
            sql.Add('       or ("Wastage" <> 0))');
            execSQL;

            // for Locations OpStk is meant to show the Location Audit Count of the previous stock
            // for the same Row ID (as long as there is the same Product-Unit).

            close;
            sql.Clear;
            sql.Add('update auditLocationscur set opstk = 0 where LocationID > 0 and LocationID < 999 ');
            sql.Add(' and opstk <> -888888 and (PurchCostPU is not NULL)');
            execSQL;

            // markup records depending if they should be there or not based on last audited in Location
            // there should not be a need for this except in rare circumstances (normally OpStk per Site should take care of this)
            close;
            sql.Clear;
            sql.Add('update auditLocationscur set ShouldBe = 0');
            sql.Add('where (   ("OpStk" <> 0)');
            sql.Add('       and (ShouldBe <> 0))');
            execSQL;

            // empty ThRed if PrepItem
            close;
            sql.Clear;
            sql.Add('update auditLocationscur set thredqty = NULL where PurchStk = -999999');
            execSQL;

            // fill Wastage with -999999 if PrepItem for Locations only...
            close;
            sql.Clear;
            sql.Add('update auditLocationscur set Wastage = -999999 where PurchStk = -999999');
            sql.Add('  and LocationID > 0 and LocationID < 999');
            execSQL;
          end;    // temp use only
      else modalResult := mrNone;      // mrCancel
      end;
    end
    else
    begin
      // ask for OK/Cancel confirmation, no temp use allowed...
      if MessageDlg('The List Changes for Location "' + curLocName + '", Division "' + curDivision + '" are about to be saved.' + #10#13 +
         'The new List will be used for the current Audit Count as well.', mtConfirmation, [mbOK,mbCancel], 0) = mrOk then
      begin
        SaveListAndReloadAudit;
      end
      else
      begin
        modalResult := mrNone;
      end; // if.. else MessageDlg = OK (to save List changes)
    end;

  finally
    Close;  // close dmado.adoqRun
  end;
end;

procedure TfLocationList.SaveListAndReloadAudit;
begin
  with dmado.adoqRun do
  try
    // first save the new Location List

    // For records for this Division and Location...
    // 1. update all records that are in stkLocationLists from the temp table
    // 2. set as Deleted all records in stkLocationLists that are not in the temp table
    // 3. insert from temp table in stkLocationLists what's not there already
    //    note: either 2 or 3 will happen and not both as it's all based on sequential Line No.
    //   for easier/safer SQL the "deletion" will be done first, to all records, then update.

    SQL.Clear;
    SQL.Add('UPDATE [stkLocationLists] SET Deleted = 1, LMDT = ' +
                                                quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
    SQL.Add('WHERE SiteCode = ' + siteIDstr);
    SQL.Add('AND DivisionID = ' + curDivIDstr);
    SQL.Add('AND LocationID = ' + curLocIDstr);
    ExecSQL;

    SQL.Clear;
    SQL.Add('UPDATE [stkLocationLists] SET Deleted = 0, EntityCode = sq.EntityCode, Unit = sq.Unit,');
    SQL.Add('   FixedQty = sq.FixedQty,');
    SQL.Add('   [ManualAdd] = NULL, LMDT = ' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)));
    SQL.Add('FROM (SELECT * FROM #LocationList) sq');
    SQL.Add('WHERE SiteCode = ' + siteIDstr);
    SQL.Add('AND DivisionID = ' + curDivIDstr);
    SQL.Add('AND LocationID = ' + curLocIDstr);
    SQL.Add('AND [stkLocationLists].RecID = sq.RecID');
    ExecSQL;


    SQL.Clear;
    SQL.Add('INSERT INTO [stkLocationLists] ([SiteCode],[LocationID], DivisionID, [RecID],[EntityCode],');
    SQL.Add('         [Unit],[ManualAdd],[Deleted],FixedQty,[LMDT])');
    SQL.Add('Select ' + siteIDstr + ', ' + curLocIDstr + ',' + curDivIDstr + ',ll.[RecID],[EntityCode],');
    SQL.Add('         [Unit],NULL,0,FixedQty,' + quotedStr(formatdatetime('yyyymmdd hh:nn:ss.zzz', Now)) );
    SQL.Add('FROM #LocationList ll');
    SQL.Add(' LEFT OUTER join (SELECT RecID FROM stkLocationLists');
    SQL.Add('             WHERE SiteCode = ' + siteIDstr);
    SQL.Add('             AND DivisionID = ' + curDivIDstr);
    SQL.Add('             AND LocationID = ' + curLocIDstr);
    SQL.Add('          ) sq1 ON ll.RecID = sq1.RecID ');
    SQL.Add('WHERE sq1.RecID is NULL');
    ExecSQL;


    // now re-load the AuditLocationsCur table and reset the grid in the Audit form before returning to it...

    // delete the records for "this" Location and for <No Location> as a change to a Location List
    // could mean a change to what's left in <No Location>
    StockLocationService.UpdateAuditLocationsCur(curLocIDstr);
  finally
    Close;  // close dmado.adoqRun
  end;
end;

procedure TfLocationList.btnPrintSampleClick(Sender: TObject);
begin
  fRepSP := TfRepSP.Create(Self);

  fRepSP.adoqLocationCount.sql.Text := 'select [RecID], [Unit], [Name], ' +
     ' CASE WHEN isPrepItem = ''P'' THEN -999999 ELSE 0 END as PurchStk ' +
     ' FROM #LocationList ORDER BY [RecID]';

  with data1.adoqRun do
  begin
    Close;
    sql.Clear;
    SQL.Add('select loc.PrintNote');
    SQL.Add('from stkLocations loc  ');
    SQL.Add('WHERE loc.SiteCode = ' + siteIDstr);
    sql.Add('AND LocationID = ' + curLocIDstr);
    open;
    fRepSP.ppMemoLocNote.Text := FieldByName('PrintNote').asstring;
    close;
  end;

  fRepSP.ppLabel67.Caption := 'For Count Location: ' + curLocName;
  fRepSP.ppLabel11.Caption := curLocName + '  SAMPLE';
  fRepSP.ppLabel62.Caption := 'Division: ' + curDivision;

  fRepSP.pplabel66.Text := 'Header: SAMPLE';
  fRepSP.pplabel65.Text := 'Thread Name: SAMPLE';
  fRepSP.pplabel35.Text := data1.SSbig + ' Type: SAMPLE';
  fRepSP.pplabel59.Text := data1.SSbig + ' Taker: ' + data1.UserName;
  fRepSP.pplabel63.Text := 'From: 00/00/0000   To: 00/00/0000';
  fRepSP.pplabel64.Text := '';
  fRepSP.pplabel60.Text := 'Period Length: SAMPLE Days';

  fRepSP.adoqLocationCount.Open;
  if fRepSP.adoqLocationCount.RecordCount > 0 then
    fRepSP.ppLocationCount.Print
  else
    ShowMessage('No Products in the List, nothing to print...');
  fRepSP.adoqLocationCount.Close;

  fRepSP.Free;
end;

procedure TfLocationList.gridListRowChanged(Sender: TObject);
begin
  if self.curLocHasFixedQty then
    gridList.PictureMasks.Strings[0] := 'StringFixedQty' +
       data1.setGridMask(adotList.fieldByName('Unit').asstring,'');
end;

procedure TfLocationList.adotListBeforePost(DataSet: TDataSet);
begin
  if adotList.FieldByName('StringFixedQty').asstring = '' then
  begin
    adotList.FieldByName('FixedQty').asstring := '';
  end
  else
  begin
    adotList.FieldByName('FixedQty').AsFloat := data1.dozGallStrToFloat(
              adotList.FieldByName('Unit').AsString,adotList.FieldByName('StringFixedQty').asstring);
  end;
end;

procedure TfLocationList.adotListAfterPost(DataSet: TDataSet);
begin
  btnSave.Enabled := True;
  btnReturnChangeList.Enabled := True;
end;

function TfLocationList.SavePromptRequired: Boolean;
begin
  //TODO:  Remove the reliance on the Enabled property of the button.
  //Temporarily wrapped the following changes into this method in order to hide the mess :-(.
  //The following code is side-effect inducing: calling the post causes
  //adotListAfterPost to fire which will then force the btnSave.Enabled value to change.
  //EB 06/08/2018

  if gridList.DataSource.DataSet.State in [dsEdit, dsInsert] then
    gridList.DataSource.DataSet.Post;

  Result := btnSave.Enabled;
end;

end.















