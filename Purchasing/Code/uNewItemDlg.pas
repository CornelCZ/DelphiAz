unit uNewItemDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, wwdblook, Db, DBTables, Wwquery, Wwlocate, Wwdatsrc,
  Grids, Wwdbigrd, Wwdbgrid, Wwkeycb, Messages, Menus, Dialogs, DBCtrls, ADODB,
  wwDialog, Variants, ActnList;

type
  Tfnewitemdlg = class(TForm)
    Panel1: TPanel;
    SearchLabel: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    wwDBGrid1: TwwDBGrid;
    wwDataSource1: TwwDataSource;
    wwFind: TwwLocateDialog;
    sbPurchName: TSpeedButton;
    sbSubCat: TSpeedButton;
    BtnNext: TBitBtn;
    BtnAccept: TBitBtn;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    wwincsearch: TwwIncrementalSearch;
    lookitem: TwwDBLookupCombo;
    BtnMidWord: TBitBtn;
    Bevel2: TBevel;
    BtnToggleSupplier: TBitBtn;
    qPurchName: TADOQuery;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    sbRetDesc: TSpeedButton;
    sbImpExpRef: TSpeedButton;
    Label4: TLabel;
    rgSearchMode: TRadioGroup;
    qRetDescr: TADOQuery;
    qSubCat: TADOQuery;
    qImpExpRef: TADOQuery;
    wwqSearch: TADOQuery;
    qAllSupplierProducts: TADOQuery;
    qSingleSupplierProds: TADOQuery;
    ActionList1: TActionList;
    ToggleSupplierAction: TAction;
    btnAdvanced: TBitBtn;
    procedure itemlookCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnNextClick(Sender: TObject);
    procedure BtnAcceptClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lookitemCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure BtnMidWordClick(Sender: TObject);
    procedure SearchModeButtonClick(Sender: TObject);
    procedure wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure wwincsearchEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgSearchModeClick(Sender: TObject);
    procedure ToggleSupplierActionExecute(Sender: TObject);
    procedure btnAdvancedClick(Sender: TObject);
    procedure ToggleSupplierActionUpdate(Sender: TObject);
  private
    { Private declarations }
    esc : boolean;
    invoiceTask: integer;  // holds the current InvFrm.Task
    supplierName: string;
    procedure SetViewAllSuppliersProducts;
    procedure GetSingleSupplierItems(theSupplier, delNoteDate: string);
    procedure GetAllSupplierItems(delNoteDate: string);
  public
    { Public declarations }
    ViewAllSupplierProds: Boolean;
    task : integer; // 1 = newitem, 2 = punit, 3 = flavor, 4 = search item
    selitem : string;
    procedure InitializeToggleSupplierAction; //(theSupplier, theDate: string; theInvoiceTask: integer);
    procedure UpdateVariables(theSupplier, theDate: string; theInvoiceTask: integer);
    function HasProducts: Boolean;
  end;

const
  // The context for opening this form
  TASK_NEW_ITEM = 1;
  TASK_SEARCH_ITEM = 4;
  // SearchModeRadioGroup item indexes
  PURCHASE_NAME_RB = 0;
  RETAIL_DESCR_RB = 1;
  SUB_CAT_RB = 2;
  IMP_EXP_RB = 3;
  // Search Field Names
  PURCHASE_NAME_FLD = 'Purchase Name';
  RETAIL_DESC_FLD = 'Retail Description';
  SUB_CAT_FLD = 'Sub-Category Name';
  IMP_EXP_REF_FLD = 'Import/Export Reference';


var
  fnewitemdlg: Tfnewitemdlg;

implementation

{$R *.DFM}

uses uinvfrm, umiddlg, uADO, uLog, uGlobals;

procedure Tfnewitemdlg.itemlookCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not esc then
   begin
      TwwDBLookupCombo(sender).PerformSearch;
      fnewitemdlg.ModalResult := mrOK;
   end;
   lookitem.enabled := false;
   lookitem.visible := false;
end;

procedure Tfnewitemdlg.FormShow(Sender: TObject);
begin
   esc := false;
   case task of
     TASK_NEW_ITEM:
       begin
          if not wwdatasource1.DataSet.Active then
            wwDataSource1.DataSet.Active := true;

          wwdatasource1.DataSet.first;
          fnewitemdlg.height := 482;
          fnewitemdlg.width := 799;
          panel1.Visible := false;
          panel2.visible := true;
          if sbPurchName.down then
          begin
            wwincsearch.text := selitem;
            wwdbgrid1.DataSource.DataSet.Locate(PURCHASE_NAME_FLD, selitem, []);
            wwincsearch.SearchField := PURCHASE_NAME_FLD;
            wwincsearch.SelectAll;
            wwincsearch.SetFocus;
          end
          else if sbRetDesc.Down then
          begin
            wwdbgrid1.DataSource.DataSet.Locate(PURCHASE_NAME_FLD, selitem, []);
            wwincsearch.Text := VarToStr(wwDBGrid1.DataSource.DataSet.FieldValues[RETAIL_DESC_FLD]);
            wwincsearch.SearchField := RETAIL_DESC_FLD;
            wwincsearch.SetFocus;
          end
          else if sbSubCat.Down then
          begin
            wwdbgrid1.DataSource.DataSet.Locate(PURCHASE_NAME_FLD, selitem, []);
            wwincsearch.text := '';
            wwincsearch.SearchField := SUB_CAT_FLD;
            wwincsearch.SetFocus;
          end
          else if sbImpExpRef.Down then
          begin
            wwdbgrid1.DataSource.DataSet.Locate(PURCHASE_NAME_FLD, selitem, []);
            wwincsearch.Text := VarToStr(wwDBGrid1.DataSource.DataSet.FieldValues[IMP_EXP_REF_FLD]);
            wwincsearch.SearchField := IMP_EXP_REF_FLD;
            wwincsearch.SetFocus;
          end;
          wwfind.SearchField := wwincsearch.SearchField;
       end;
     TASK_SEARCH_ITEM:
       begin
          fnewitemdlg.height := 238;
          fnewitemdlg.width := 236;
          panel1.Visible := true;
          panel2.Visible := false;

          rgSearchModeClick(rgSearchMode);
       end;
   end; // case...
end;

procedure Tfnewitemdlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    esc := true;
    modalresult := mrCancel;
  end;
end;


procedure Tfnewitemdlg.BtnNextClick(Sender: TObject);
begin
   //job 16489 16490
   if not (wwfind.FieldValue=wwincsearch.Text) then
     wwfind.FieldValue:=wwincsearch.Text;
   // only search if there is a value in wwincsearch.text
   if wwfind.FieldValue <> '' then
   begin
     // ensure that this only searches incrementally from 1st letter in
     // the value of the field
     wwfind.MatchType := mtPartialMatchStart;
     wwfind.FindNext;
   end;
end;

procedure Tfnewitemdlg.BtnAcceptClick(Sender: TObject);
begin
   fnewitemdlg.ModalResult := mrOK;
   application.processmessages;
end;

procedure Tfnewitemdlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  mymsg : TMessage;
begin
  if task > TASK_NEW_ITEM then
     exit;
  case key of
    vk_return : BtnAcceptclick(sender);
    vk_f3 : BtnNextClick(sender);
    vk_f2 : BtnMidWordClick(sender);
    vk_f5 : begin
              sbPurchName.Down := true;
              SearchModeButtonClick(sender);
            end;
    vk_f6 : begin
              sbRetDesc.Down := true;
              SearchModeButtonClick(sender);
            end;
    vk_f7 : begin
              sbSubCat.Down := true;
              SearchModeButtonClick(sender);
            end;
    vk_f8 : begin
              sbImpExpRef.Down := true;
              SearchModeButtonClick(sender);
            end;
    vk_f9 : btnAdvancedClick(sender);
    vk_prior, vk_next, vk_up, vk_down, vk_home, vk_end :
            begin
              mymsg.Msg := wm_keydown;
              mymsg.WParam := key;
              mymsg.LParam := 0;
              mymsg.Result := 0;
              fnewitemdlg.KeyPreview := false;
              wwdbgrid1.Dispatch(mymsg);
              key := 0;
           end;
  end; // case
  wwincsearch.setfocus;
end;

procedure Tfnewitemdlg.lookitemCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  try
   if not esc then
   begin
      lookitem.PerformSearch;
      finvfrm.searchrec := lookitem.LookupTable.FieldByName('recno').asfloat;
      fnewitemdlg.ModalResult := mrOK;
   end;
   lookitem.enabled := false;
   lookitem.visible := false;
  except
  end;
end;

procedure Tfnewitemdlg.BtnMidWordClick(Sender: TObject);
begin
   fmiddlg := tfmiddlg.create(self);
   fmiddlg.ShowModal;
   fmiddlg.free;
   wwincsearch.SetFocus;
end;

procedure Tfnewitemdlg.SearchModeButtonClick(Sender: TObject);
begin
  wwincsearch.Text := '';
  if sbPurchName.down then
  begin
    wwincsearch.SearchField := PURCHASE_NAME_FLD;
    wwincsearch.SetFocus;
  end
  else if sbRetDesc.Down then
  begin
    wwincsearch.SearchField := RETAIL_DESC_FLD;
    wwincsearch.SetFocus;
  end
  else if sbSubCat.Down then
  begin
    wwincsearch.SearchField := SUB_CAT_FLD;
    wwincsearch.SetFocus;
  end
  else if sbImpExpRef.Down then
  begin
    wwincsearch.SearchField := IMP_EXP_REF_FLD;
    wwincsearch.SetFocus;
  end;
  wwfind.SearchField := wwincsearch.SearchField;
  wwincsearch.SetFocus;
end;

procedure Tfnewitemdlg.wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fnewitemdlg.KeyPreview := true;
end;

procedure Tfnewitemdlg.wwDBGrid1DblClick(Sender: TObject);
begin
  BtnAcceptClick(sender);
  application.processmessages;
end;

procedure Tfnewitemdlg.wwincsearchEnter(Sender: TObject);
begin
	wwincsearch.SelectAll;
end;

procedure Tfnewitemdlg.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tfnewitemdlg.BtnOKClick(Sender: TObject);
begin
  lookitemCloseUp(lookitem,lookitem.LookupTable,nil,true);
end;

procedure Tfnewitemdlg.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_ADD_ITEM);
end;

procedure Tfnewitemdlg.rgSearchModeClick(Sender: TObject);

  procedure UpdateOrderSQL(var theQry: TADOQuery);
  var
    i: integer;
  begin
    theQry.Close;
    // remove "order by" statement
    for i := 0 to theQry.SQL.Count-1 do
    begin
      if pos('ORDER BY', theQry.SQL.Strings[i]) > 0 then
      begin
        theQry.SQL.Delete(i);
        break;
      end;
    end;
    // add current sort order
    case finvfrm.currentSortIndex of
      SORT_SUBCAT       : theQry.SQL.Add('ORDER BY SubCatName ASC, a.[itemname] ASC');
      SORT_IMP_EXP      : theQry.SQL.Add('ORDER BY ImpExpRef');
      SORT_DESC_TOTAL   : theQry.SQL.Add('ORDER BY [ItemCost] DESC');
      SORT_ASC_DELIVERY : theQry.SQL.Add('ORDER BY [Qty]');
      SORT_NATURAL      : theQry.SQL.Add('ORDER BY [recno]');
    end;
    try
      theQry.Open;
    except
      on E: Exception do
      begin
        Log.Event('fnewitemdlg; rgSearchModeClick, UpdateOrderSQL: ' + E.Message + '; '+ theQry.SQL.Text);
        raise;
      end;
    end;
  end;

begin

  lookitem.LookupField := '';
  lookitem.Selected.Clear;

  with Sender as TRadioGroup do
  begin
    case ItemIndex of
      PURCHASE_NAME_RB :
        begin
          UpdateOrderSQL(qPurchName);
          lookitem.LookupTable := qPurchName;
          lookitem.LookupField := 'itemname';
          SearchLabel.Caption := 'Search for Purchase Name:';
        end;
      RETAIL_DESCR_RB :
        begin
          UpdateOrderSQL(qRetDescr);
          lookitem.LookupTable := qRetDescr;
          lookitem.LookupField := 'RetailDesc';
          SearchLabel.Caption := 'Search for Retail Description:';
        end;
      SUB_CAT_RB :
        begin
          UpdateOrderSQL(qSubCat);
          lookitem.LookupTable := qSubCat;
          lookitem.LookupField := 'SubCatName';
          SearchLabel.Caption := 'Search for Sub-Category:';
        end;
      IMP_EXP_RB :
        begin
          UpdateOrderSQL(qImpExpRef);
          lookitem.LookupTable := qImpExpRef;
          lookitem.LookupField := 'ImpExpRef';
          SearchLabel.Caption := 'Search for Import/Export Reference:';
        end;
    end;
  end;
  lookitem.enabled := true;
  lookitem.Visible := true;
  lookitem.setfocus;
end;


procedure Tfnewitemdlg.ToggleSupplierActionExecute(Sender: TObject);
begin
  if finvfrm.OneSupplier then
  begin
    try
      qAllSupplierProducts.open;
      qSingleSupplierProds.close;
      wwDataSource1.dataset := qAllSupplierProducts;
    except
      on E: Exception do
      begin
        log.Event('fnewitemdlg; ToggleSupplierActionExecute: setting all suppliers item list. ' + E.Message + '; ' + qAllSupplierProducts.SQL.Text);
        raise;
      end;
    end;
    finvfrm.OneSupplier := false;
    ToggleSupplierAction.Caption := 'Single &Supplier';
  end
  else
  begin
    try
      qSingleSupplierProds.open;
      // if there are no products associated with the single supplier then
      // warn the user and do not change dataset or caption
      if (qSingleSupplierProds.RecordCount = 0) then
      begin
        ShowMessage('There are no products associated with supplier ' + finvfrm.thesupplier);
        log.event('fnewitemdlg; ToggleSupplierActionExecute: qSingleSupplierProds closed because it has no result records');
        qSingleSupplierProds.Close;
        exit;
      end;
      qAllSupplierProducts.Close;
      wwDataSource1.dataset := qSingleSupplierProds;
    except
      on E: Exception do
      begin
        log.Event('fnewitemdlg; ToggleSupplierActionExecute: setting single supplier item list. ' + E.Message + '; ' + qSingleSupplierProds.SQL.Text);
        raise;
      end;
    end;
    finvfrm.OneSupplier := true;
    ToggleSupplierAction.Caption := 'All &Suppliers';
  end;
  if fnewitemdlg.Active then
    wwincsearch.SetFocus;
end;

// This procedure is required as there is a problem in setting parameters when the
// supplier name contains an '&', strange thing is that it is the date parameter which
// throws the exception
procedure Tfnewitemdlg.GetSingleSupplierItems(theSupplier, delNoteDate: string);
begin
  if dmADO.SQLTableExists('#SingleSupplierItems') then dmADO.DelSQLTable('#SingleSupplierItems');
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT c.*, d.[Division Name]');
      SQL.Add('INTO #SingleSupplierItems');
      SQL.Add('FROM');
      SQL.Add('  (   SELECT DISTINCT');
      SQL.Add('        a.EntityCode as [Entity Code], a.[Purchase Name], a.[Retail Description], a.[Sub-Category Name],');
      SQL.Add('        b.[Supplier Name], b.[Import/Export Reference], b.[Unit Name], b.[Flavour],');
      SQL.Add('        b.[Default Flag],b.[Unit Cost], a.[Whether Sales Taxable], NULL AS MultiPurchaseProduct');
      SQL.Add('      FROM Products a INNER JOIN');
      SQL.Add('               punits b ON a.EntityCode = b.[Entity Code]');
      SQL.Add('      WHERE ( a.[Entity Type] = ''Strd.Line'' OR a.[Entity Type] = ''Purch.Line'' )');
      SQL.Add('      AND ( b.[Supplier Name] = ' + QuotedStr(thesupplier) + ')');
      SQL.Add('      AND (a.Deleted is NULL or a.Deleted <> ''Y'')');
      SQL.Add('      AND (a.discontinue <> 1 or a.Discontinue is Null)');
      SQL.Add('    UNION');
      SQL.Add('      SELECT DISTINCT');
      SQL.Add('        b.[MultiPurchParent], a.[Purchase Name], a.[Retail Description], a.[Sub-Category Name],');
      SQL.Add('        b.[Supplier Name], NULL, NULL, b.[Flavour], NULL, NULL, a.[Whether Sales Taxable], ''Y'' as MultiPurchaseProduct');
      SQL.Add('      FROM Products a INNER JOIN');
      SQL.Add('        MultiPurchSupplier b on a.[EntityCode] = b.[MultiPurchParent]');
      SQL.Add('      WHERE b.[Supplier Name] = ' + QuotedStr(thesupplier));
      SQL.Add('      AND (a.Deleted is NULL or a.Deleted <> ''Y'')');
      SQL.Add('  ) c, division d, category e, subcateg f');
      SQL.Add('WHERE c.[Sub-Category Name] = f.[Sub-Category Name]');
      SQL.Add('AND f.[Category Name] = e.[Category Name]');
      SQL.Add('AND e.[Division Name] = d.[Division Name]');
      SQL.Add('AND d.[Division Name] not in ');
      SQL.Add('    ( select st.Division');
      SQL.Add('      from Stocks st');
      SQL.Add('      where st.TID not in');
      SQL.Add('        (select TID');
      SQL.Add('         from threads ');
      SQL.Add('         where ISNULL(NoPurAcc,'''') = ''Y'')');
      SQL.Add('      and st.[EDate] >= ' + QuotedStr(delNoteDate));
      SQL.Add('      and st.StockCode > 1 )');
      SQL.Add('ORDER BY c.[Sub-Category Name], c.[Purchase Name], c.[Retail Description], c.[Default Flag] DESC, c.[Import/Export Reference]');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fnewitemdlg; GetSingleSupplierItems: ' + E.Message + '; '+ dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;

  with qSingleSupplierProds.SQL do
  begin
    Clear;
    Add('Select * from #SingleSupplierItems');
    Add('ORDER BY [Sub-Category Name], [Purchase Name], [Retail Description], [Default Flag] DESC, [Import/Export Reference]');
  end;
end;

procedure Tfnewitemdlg.GetAllSupplierItems(delNoteDate: string);
begin
  if dmADO.SQLTableExists('#AllSupplierItems') then dmADO.DelSQLTable('#AllSupplierItems');
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT c.*, d.[Division Name]');
      SQL.Add('INTO #AllSupplierItems');
      SQL.Add('FROM');
      SQL.Add('  (   SELECT DISTINCT');
      SQL.Add('        a.EntityCode as [Entity Code], a.[Purchase Name], a.[Retail Description], a.[Sub-Category Name],');
      SQL.Add('        b.[Supplier Name], b.[Import/Export Reference], b.[Unit Name], b.[Flavour],');
      SQL.Add('        b.[Default Flag],b.[Unit Cost], a.[Whether Sales Taxable], NULL AS MultiPurchaseProduct');
      SQL.Add('      FROM Products a INNER JOIN');
      SQL.Add('        (SELECT *');
      SQL.Add('         FROM punits pu INNER JOIN');
      SQL.Add('          (SELECT s2.[Supplier Name] AS SupplierName');
      SQL.Add('           FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2');
      SQL.Add('             ON s1.SupplierID = s2.[Supplier Code]) s');
      SQL.Add('           ON pu.[Supplier Name] = s.SupplierName) b');
      SQL.Add('        ON a.EntityCode = b.[Entity Code]');
      SQL.Add('      WHERE ( a.[Entity Type] = ''Strd.Line'' OR a.[Entity Type] = ''Purch.Line'' )');
      SQL.Add('      AND (a.Deleted is NULL or a.Deleted <> ''Y'')');
      SQL.Add('      AND (a.discontinue <> 1 or a.Discontinue is Null) ');
      SQL.Add('    UNION');
      SQL.Add('      SELECT DISTINCT');
      SQL.Add('        b.[MultiPurchParent], a.[Purchase Name], a.[Retail Description], a.[Sub-Category Name],');
      SQL.Add('        b.[Supplier Name], NULL, NULL, b.[Flavour], NULL, NULL, a.[Whether Sales Taxable], ''Y'' as MultiPurchaseProduct');
      SQL.Add('      FROM Products a INNER JOIN');
      SQL.Add('        (SELECT *');
      SQL.Add('         FROM MultiPurchSupplier pu INNER JOIN');
      SQL.Add('          (SELECT s2.[Supplier Name] AS SupplierName');
      SQL.Add('           FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2');
      SQL.Add('             ON s1.SupplierID = s2.[Supplier Code]) s');
      SQL.Add('           ON pu.[Supplier Name] = s.SupplierName) b');
      SQL.Add('        ON a.[EntityCode] = b.[MultiPurchParent]');
      SQL.Add('      WHERE (a.Deleted is NULL or a.Deleted <> ''Y'')');
      SQL.Add('  ) c, division d, category e, subcateg f');
      SQL.Add('WHERE c.[Sub-Category Name] = f.[Sub-Category Name]');
      SQL.Add('AND f.[Category Name] = e.[Category Name]');
      SQL.Add('AND e.[Division Name] = d.[Division Name]');
      SQL.Add('AND d.[Division Name] not in ');
      SQL.Add('    ( select st.Division');
      SQL.Add('      from Stocks st');
      SQL.Add('      where st.TID not in');
      SQL.Add('        (select TID');
      SQL.Add('         from threads ');
      SQL.Add('         where ISNULL(NoPurAcc,'''') = ''Y'')');
      SQL.Add('      and st.[EDate] >= ' + QuotedStr(delNoteDate));
      SQL.Add('      and st.StockCode > 1 )');
      SQL.Add('ORDER BY c.[Sub-Category Name], c.[Purchase Name], c.[Retail Description], c.[Default Flag] DESC, c.[Import/Export Reference]');
      ExecSQL;
      // remove any items that are also non-returnable ingredients in multi-purchase items
      Close;
      SQL.Clear;
      SQL.Add('delete #AllSupplierItems');
      SQL.Add('from #AllSupplierItems asi inner join');
      SQL.Add(' (select mpsi.[Entity Code], mpi.[UnitName], mpsi.[Supplier Name]');
      SQL.Add('  from MultiPurchSupplierIngreds mpsi, MultiPurchIngredients mpi');
      SQL.Add('  where mpsi.MultiPurchParent = mpi.EntityCode');
      SQL.Add('  and mpsi.[Entity Code] = mpi.IngredientCode');
      SQL.Add('  and ISNULL(mpsi.Returnable,0) = 0) mi');
      SQL.Add('            on asi.[Entity Code] = mi.[Entity Code] and asi.[Unit Name] = mi.[UnitName] and asi.[Supplier Name] = mi.[Supplier Name]');
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fnewitemdlg; GetAllSupplierItems: ' + E.Message + '; '+ dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;

  with qAllSupplierProducts.SQL do
  begin
    Clear;
    Add('Select * from #AllSupplierItems');
    Add('ORDER BY [Sub-Category Name], [Purchase Name], [Retail Description], [Default Flag] DESC, [Import/Export Reference]');
  end;
end;


procedure Tfnewitemdlg.btnAdvancedClick(Sender: TObject);
begin
  // set LocateDialog property to default values
  wwFind.FieldValue := wwincsearch.Text;
  wwFind.CaseSensitive := false;
  wwFind.MatchType := mtPartialMatchAny;
  wwFind.SearchField := wwincsearch.SearchField;

  // execute always shows the dialog, findnext will only show the dialog
  // if the FieldValue has not been set
  wwFind.Execute;
  wwincsearch.SetFocus;
end;

procedure Tfnewitemdlg.SetViewAllSuppliersProducts;
begin
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select ISNULL([ViewAllSuppliersProducts],'''') AS ViewAll');
      SQL.Add('from vwSupplier');
      SQL.Add('where [Supplier Name] = ' + QuotedStr(supplierName));
      Open;

      if RecordCount = 0 then
      begin
        ViewAllSupplierProds := False;
      end
      else
      begin
        if PurAudit and
           ( (invoiceTask = TASK_AUDIT) or (invoiceTask = TASK_AUDIT_ADD) ) then  // override the supplier view/edit settings for users that have audit permissions
        begin
          ViewAllSupplierProds := true;
        end
        else
        begin
          ViewAllSupplierProds := (FieldByName('ViewAll').AsString = 'Y');
        end;
      end;

      Close;
      SQL.Clear;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fnewitemdlg; SetViewAllSuppliersProducts: ' + E.Message + '; '+ dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfnewitemdlg.InitializeToggleSupplierAction; //(theSupplier, theDate: string; theInvoiceTask: integer);
begin
  ToggleSupplierAction.Caption := 'All &Suppliers';
  ToggleSupplierAction.ShortCut := ShortCut(Word('S'), [ssAlt]);
  if (qSingleSupplierProds.RecordCount = 0) and ViewAllSupplierProds then
    ToggleSupplierAction.Execute
  else
    wwDataSource1.dataset := fnewitemdlg.qSingleSupplierProds;
end;

procedure Tfnewitemdlg.UpdateVariables(theSupplier, theDate: string; theInvoiceTask: integer);
begin
  supplierName := theSupplier;
  invoiceTask := theInvoiceTask;
  SetViewAllSuppliersProducts;
  qAllSupplierProducts.Close;
  qSingleSupplierProds.Close;
  GetAllSupplierItems(theDate);
  GetSingleSupplierItems(thesupplier, theDate);
  try
    qAllSupplierProducts.Open;
    qSingleSupplierProds.Open;
  except
    on E: Exception do
    begin
      log.Event('fnewitemdlg; UpdateVariables: ' + E.Message);
      Raise;
    end;
  end;
end;

procedure Tfnewitemdlg.ToggleSupplierActionUpdate(Sender: TObject);
begin
//TODO:  Not sure if this is quite right
  ToggleSupplierAction.Enabled := ( ViewAllSupplierProds or
                                    (invoiceTask = TASK_AUDIT) or
                                    (invoiceTask = TASK_AUDIT_ADD) );
end;

function Tfnewitemdlg.HasProducts: Boolean;
var
  localisedStock: string;
begin
  if (UKUSMode = 'US') then
    localisedStock := 'inventory'
  else
    localisedStock := 'stock';

  Result := ((qSingleSupplierProds.RecordCount > 0) or (ViewAllSupplierProds and (qAllSupplierProducts.RecordCount > 0)));
  if not Result then
  begin
    qSingleSupplierProds.Close;
    MessageDlg('No products are available for adding to this ' + GetLocalisedName(lsInvoice)  + '.' + #13#10 +
               'There are two possible reasons for this:' + #13#10#10 +
               '-  All products associated with supplier ' + supplierName + #13#10 +
               'are in an accepted ' + localisedStock + ' period for the selected date.' + #13#10#10 +
               '-  Supplier ' + supplierName + ' has no products and is not ' + #13#10 +
               'configured to view all suppliers'' products', mtError, [mbOK], 0);
    Log.Event('fnewitemdlg; Can''t create a new invoice - No products associated with supplier ' + supplierName);
  end;
end;

end.
