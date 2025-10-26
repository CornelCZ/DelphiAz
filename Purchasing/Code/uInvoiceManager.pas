unit uInvoiceManager;

interface

uses
  Forms, SysUtils, Classes, DB, ADODB;

type
  TInvoiceManager = class(TDataModule)
    wwqGetInvoice: TADOQuery;
    wwtSysVar: TADOTable;
    qryRun: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    promptuc, hideSort, insertAfter : boolean;
    selsupp: string;
    thetax : real;

    procedure MoveNonMultiPurchItems(SourceTable: string);
    procedure MoveMultiPurchParents;
    procedure MoveMultiPurchIngredients(SourceTable: string);
    procedure SetSortSubcat;
    function InvoicesExist(TblName: string): boolean;
  public
    procedure OpenInvoice(theTask: integer; CallingForm: TForm);
    procedure CreateNewInvoice(CallingForm: TForm);
    procedure MoveToTemporary(SourceTable: string);
    function GetAccChunkName: String;
    procedure SetItemTax;
  end;

var
  InvoiceManager: TInvoiceManager;

implementation

uses Controls, Dialogs, uGetInvDlg, uInvFrm, uNewItemDlg, uGlobals, uNewInvDlg, uADO, uLog;

const
  INV_FORM_LEFT = 83;
  INV_FORM_TOP = 112;

{$R *.dfm}

procedure TInvoiceManager.CreateNewInvoice(CallingForm: TForm);
begin
  while (fnewinvdlg.showmodal = mrOK) do
  begin
    finvfrm := tfinvfrm.Create(self);
    // pre-check whether there are any products for the selected supplier and
    // exit if there are none and if the supplier is not configured for ViewAllSupplierProds
    finvfrm.thesupplier := fnewinvdlg.SupplierLookUp.text;
    finvfrm.GetEditLevels;
    fnewitemdlg.UpdateVariables(finvfrm.thesupplier, FormatDateTime('yyyymmdd', fnewinvdlg.dtDateReceived.Date), TASK_ADD);
    if not fnewitemdlg.HasProducts then
      exit;

    finvfrm.OneSupplier := true;
    fnewitemdlg.InitializeToggleSupplierAction();
    if purchHelpExists then
      setHelpContextID(finvfrm, HLP_ADD_DELIVERY_NOTE);
    finvfrm.windowstate := CallingForm.WindowState;
    finvfrm.Top := INV_FORM_TOP;
    finvfrm.Left := INV_FORM_LEFT;
    finvfrm.task := TASK_ADD; // task 0 === add invoice
    finvfrm.thetax := thetax;
    finvfrm.promptuc := promptuc;
    finvfrm.hideSort := hideSort;
    finvfrm.insertAfter := insertAfter;
    finvfrm.thedate := fnewinvdlg.dtDateReceived.Date;
    finvfrm.invoiceno := fnewinvdlg.InvoiceNoEdit.Text;
    finvfrm.theOrderNo := fnewinvdlg.theOrderNo;
    finvfrm.theMaskID := fnewinvdlg.theMaskID;
    finvFrm.invoiceNoMask := fnewInvDlg.InvoiceNoEdit.EditMask;

    Log.Event('finvmenu; Adding new invoice ' + finvfrm.invoiceno);

    finvfrm.wwtInvoice.Close;
    dmADO.EmptySQLTable('Invoice');
    try
      finvfrm.wwtInvoice.Open;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu; ERROR - btnNewInvClick: ' + E.Message);
        Raise;
      end;
    end;
    finvfrm.ModifyInvFormGridForLocale;
    finvfrm.SetNumericFieldPrecision;
    finvfrm.invtot := 0.0;
    finvfrm.Caption := 'Add New ' + GetLocalisedName(lsInvoice) + '...';
    finvfrm.showmodal;
    finvfrm.Free;
    fnewinvdlg.StockOrderCombo.ClearSelection;
    fnewinvdlg.InvoiceNoEdit.Clear;
  end;
end;

procedure TInvoiceManager.OpenInvoice(theTask: integer; CallingForm: TForm);
var
  msgStr1, msgStr2, logStr, captionStr : string;
  hlpContext: integer;
begin
  hlpContext := -1;
  msgStr1 := 'current ';
  case theTask of
    TASK_EDIT :
      begin
        if not InvoicesExist( 'PurchHdr' ) then
        begin
          ShowMessage('There are no current ' + GetLocalisedName(lsInvoice)+'s' + ' to edit.');
          exit;
        end;
        msgStr2 := ' to edit';
        logStr := 'btnEditInvClick: ';
        hlpContext := HLP_EDIT_DELIVERY_NOTE;
        captionStr := 'Edit ' + GetLocalisedName(lsInvoice) + '...';
      end;
    TASK_AUDIT :
      begin
        if not InvoicesExist( 'PurchHdr' ) then
        begin
          ShowMessage('There are no current ' + GetLocalisedName(lsInvoice)+'s' + ' to audit.');
          exit;
        end;
        msgStr2 := ' to audit';
        logStr := 'btnAuditInvoiceClick: ';
        hlpContext := HLP_AUDIT_DELIVERY_NOTE;
        captionStr := 'Audit ' + GetLocalisedName(lsInvoice) + '...';
      end;
    TASK_VIEW_CURR :
      begin
        if not InvoicesExist( 'PurchHdr' ) then
        begin
          ShowMessage('There are no current ' + GetLocalisedName(lsInvoice)+'s' + ' to view.');
          exit;
        end;
        msgStr2 := ' to view';
        logStr := 'btnViewCurrClick: ';
        hlpContext := HLP_VIEW_CURRENT_DELIVERY_NOTE;
        captionStr := 'View Current ' + GetLocalisedName(lsInvoice) + '...';
      end;
    TASK_VIEW_ACC :
      begin
        if not InvoicesExist( 'AccPurHd' ) then
        begin
          ShowMessage('There are no accepted ' + GetLocalisedName(lsInvoice)+'s' + ' to view.');
          exit;
        end;
        msgStr1 := 'accepted ';
        msgStr2 := ' to view';
        logStr := 'btnViewAccClick: ';
        hlpContext := HLP_VIEW_ACCEPTED_DELIVERY_NOTE;
        captionStr := 'View Accepted ' + GetLocalisedName(lsInvoice) + '...';
      end;
  end;


  fgetinvdlg.SetTask(theTask);
  fgetinvdlg.Caption := 'Select ' + msgStr1 + GetLocalisedName(lsInvoice) + msgStr2 + '...';
  fgetinvdlg.suppsearch.Text := selsupp;
  fgetinvdlg.SpeedBtnDelNote.Caption := GetLocalisedName(lsInvoice) + ' No. (F6)';

  while fgetinvdlg.ShowModal = mrOK do
  begin
    screen.Cursor := crHourGlass;
    finvfrm := tfinvfrm.Create(self);

    if purchHelpExists then
      setHelpContextID(finvfrm, hlpContext);

    finvfrm.windowstate := CallingForm.WindowState;
    finvfrm.Top := INV_FORM_TOP;
    finvfrm.Left := INV_FORM_LEFT;
    finvfrm.task := theTask;
    // set top labels...
    finvfrm.thetax := thetax;
    finvfrm.promptuc := promptuc;
    finvfrm.hideSort := hideSort;
    finvfrm.insertAfter := insertAfter;
    finvfrm.thesupplier := fgetinvdlg.SupplierName;
    finvfrm.thedate := fgetinvdlg.DeliveryNoteDate;
    finvfrm.invoiceno := fgetinvdlg.DeliveryNoteNo;
    finvfrm.theOrderNo := fgetinvdlg.OrderNo;
    finvfrm.theMaskID := fgetinvdlg.theMaskID;
    finvFrm.invoiceNoMask := fgetInvDlg.invoiceNoMask;
    // set top edits...
    finvfrm.Caption := captionStr;
    finvfrm.EditNote.Text := fgetinvdlg.Note;

    Log.Event('finvmenu; '+logStr + 'opening invoice ' + finvfrm.invoiceno);

    case theTask of
      TASK_EDIT, TASK_AUDIT, TASK_VIEW_CURR :
        begin
          try
            finvfrm.qInvalidSubcats.Close;
            finvfrm.qInvalidSubcats.Parameters.ParamByName('delNoteDate').Value := FormatDateTime('yyyymmdd', finvfrm.thedate);
            finvfrm.qInvalidSubcats.Open;
          except
            on E: Exception do
            begin
              Log.Event('finvmenu; ERROR - OpenInvoice: ' + logStr + ' - ' + E.Message + '; ' + finvfrm.qInvalidSubcats.SQL.Text);
              raise;
            end;
          end;
          MoveToTemporary('Purchase');
        end;
      TASK_VIEW_ACC :
        begin
          MoveToTemporary( GetAccChunkName );
        end;
    end;

    try
      finvfrm.wwtInvoice.open;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu; ERROR - OpenInvoice: ' + logStr + ' - ' + E.Message + '; ' + fInvFrm.wwtInvoice.TableName);
        raise;
      end;
    end;
    finvfrm.ModifyInvFormGridForLocale;
    finvfrm.SetNumericFieldPrecision;
    setItemTax;
    fnewitemdlg.UpdateVariables(finvfrm.thesupplier, FormatDateTime('yyyymmdd', finvfrm.thedate), finvfrm.Task);
    finvfrm.OneSupplier := true;
    fnewitemdlg.InitializeToggleSupplierAction;
    finvfrm.showmodal;
    finvfrm.free;

    //fgetinvdlg.SetTask(theTask);

    screen.Cursor := crDefault;
  end;
end;

procedure TInvoiceManager.MoveToTemporary(SourceTable: string);
begin
  // empty Invoice table
  finvfrm.wwtInvoice.Close;
  dmADO.EmptySQLTable('Invoice');
  // get purchase invoice
  if SourceTable = 'Purchase' then
  begin
    MoveNonMultiPurchItems(SourceTable);
    MoveMultiPurchParents;
    MoveMultiPurchIngredients(SourceTable);
  end
  else
  // get accepted invoice
  begin
    if SourceTable <> '' then // then it is a chunk
    begin
      MoveNonMultiPurchItems(SourceTable);
      MoveMultiPurchParents;
      MoveMultiPurchIngredients(SourceTable);
    end;
    // check AccPurch but don't get multipurchparents if they have already been
    // added above
    MoveNonMultiPurchItems('AccPurch');
    // chunk didnt exist so need to get multipurchparents
    if SourceTable = '' then MoveMultiPurchParents;
    MoveMultiPurchIngredients('AccPurch')
  end;
  SetSortSubcat;
end;

function TInvoiceManager.GetAccChunkName: String;
const
  yrarray : array [1..12] of string[3] = ('Jan','Feb','Mar','Apr','May','Jun',
                                          'Jul','Aug','Sep','Oct','Nov','Dec');
var
  syr : string;
  day,month,yr : word;
begin
  decodedate(finvfrm.thedate, yr, month, day);
  syr := 'ACC' + yrarray[month] + copy(inttostr(yr),length(inttostr(yr)) - 1,2);

  try
    with wwqGetInvoice do
    begin
      close;
      sql.clear;
      sql.add('select count([Record Id])');
      sql.add('from ' + syr);
      open;
      close;
    end;
  except
   on exception do
     syr := '';  // chunk file does not exist, use AccPurch instead...
  end;

  Result := syr;
end;

procedure TInvoiceManager.SetItemTax;
begin
  try
    with finvfrm do
    begin
      while not wwtInvoice.eof do
      begin
        if wwtInvoiceItemTax.ReadOnly then wwtInvoiceItemTax.ReadOnly := false;
        case wwtInvoice.FieldByName('PurchaseItemType').Value of
          // DON'T WANT TO SET A VALUE IF MULTI_PURCH_PARENT
          MULTI_PURCH_NONE :
            begin
              wwtInvoice.edit;
              if (wwtInvoice.FieldByName('tax').asstring = 'Y') then
                wwtinvoiceitemtax.asfloat := GetLocalisedItemTax(wwtinvoiceitemcost.asfloat,
                  theTax, False)
              else
                wwtinvoiceitemtax.asfloat := 0.0;
              wwtInvoice.post;
            end;
          MULTI_PURCH_CHILD :
            begin
              wwtInvoice.edit;
              if (wwtInvoice.FieldByName('tax').asstring = 'Y') then
                wwtinvoiceitemtax.asfloat := GetLocalisedItemTax(wwtInvoiceIngredItemCost.asfloat,
                  theTax, False)
              else
                wwtinvoiceitemtax.asfloat := 0.0;
              wwtInvoice.post;
            end;
        end;
        wwtInvoice.next;
      end; // while...
      wwtinvoice.first;
    end; // with...
  except
    on E: Exception do
    begin
      Log.Event('finvmenu; ERROR - SetItemTax: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TInvoiceManager.MoveNonMultiPurchItems(SourceTable: string);
begin
  with wwqGetInvoice do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Insert into Invoice(RecNo, ItemId, ItemName, Punit, Flavor, Ucost, Tax, Qty, ItemCost, Ou, ExpectedQty,');
    SQL.Add('                    [ImpExp Ref], [SubCat Name], IngredQty, IngredItemCost, IngredOU, MultiPurchQty,');
    SQL.Add('                    PurchaseItemType, MultiPurchParentID, Returnable, GroupRecID, SortImpExpRef, SortSubcat,');
    SQL.Add('                    SortItemName, SortItemCost, SortQty, DataSource)');
    SQL.Add('select distinct a.[Record Id], a.[Entity Code], a.[Purchase Name], a.[Unit Name], a.[Flavour], a.[Cost Per Unit],');
    SQL.Add('                b.[Whether Sales Taxable], a.[Quantity], a.[Total Cost], a.[Shortage], (a.[Quantity] - a.[Shortage]) as ExpectedQty,');
    SQL.Add('                a.[Import/Export Reference], b.[Sub-Category Name], NULL as IngredQty, NULL as IngredItemCost, NULL as IngredOU,');
    SQL.Add('                NULL as MultiPurchQty, 0 as PurchaseItemType,');
    SQL.Add('                NULL AS MultiPurchParentID, NULL as Returnable, NULL as GroupRecID, a.[Import/Export Reference] as SortImpExpRef,');
    SQL.Add('                b.[Sub-Category Name] as SortSubcat, b.[Purchase Name] as SortItemName, a.[Total Cost] as SortItemCost,');
    SQL.Add('                a.[Quantity] as SortQty, a.DataSource');
    SQL.Add('from (select p.*, r.[Import/Export Reference], ISNULL(r.[DataSource], 0) AS DataSource');
    SQL.Add('      from ' + SourceTable + ' p left outer join PurchReference r');
    SQL.Add('      on p.[Site Code] = r.[Site Code]');
    SQL.Add('      and p.[Supplier Name] = r.[Supplier Name] and p.[Delivery Note No.] = r.[Delivery Note No.]');
    SQL.Add('      and p.[Record ID] = r.[Record ID]) a, Entity b');
    SQL.Add('WHERE a.[Supplier Name] = ' + QuotedStr((fgetinvdlg.SupplierName)));
    if SiteCode <> 0 then //not all sites
      SQL.Add('AND a.[Site Code] = ''' + inttostr(SiteCode) + '''');
    SQL.Add('AND a.[Delivery Note No.] = ' + QuotedStr(fgetinvdlg.DeliveryNoteNo));
    SQL.Add('AND a.[Entity Code] = b.[Entity Code]');
    SQL.Add('AND a.[Record ID] NOT IN');
    SQL.Add('(SELECT [Record ID] from PurchMultiPurchIngreds');
    SQL.Add('where [Supplier Name] = ' + QuotedStr(fgetinvdlg.SupplierName));
    if SiteCode <> 0 then //not all sites
      SQL.Add('AND [Site Code] = ''' + inttostr(SiteCode) + '''');
    SQL.Add('AND [Delivery Note No.] = ' + QuotedStr(fgetinvdlg.DeliveryNoteNo) + ')');

    try
      ExecSQL;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu; ERROR - MoveNonMultiPurchItems: ' + E.Message + '; ' + wwqGetInvoice.SQL.Text);
        raise;
      end;
    end;
  end;
end;

procedure TInvoiceManager.MoveMultiPurchParents;
begin
  with wwqGetInvoice do
  begin
    try
      Close;
      SQL.Clear;
      SQL.Clear;
      SQL.Add('Insert into Invoice(RecNo, ItemId, ItemName, Punit, Flavor, Ucost, Tax, Qty, ItemCost, Ou, ExpectedQty,');
      SQL.Add('                    [ImpExp Ref], [SubCat Name], IngredQty, IngredItemCost, IngredOU, MultiPurchQty,');
      SQL.Add('                    PurchaseItemType, MultiPurchParentID, Returnable, GroupRecID, SortImpExpRef,');
      SQL.Add('                    SortItemName, SortItemCost, SortQty)');
      SQL.Add('SELECT DISTINCT mp.[Record ID], mp.[EntityCode] as [Entity Code], pr.[Purchase Name] + '' : '' as [Purchase Name],');
      SQL.Add('      NULL as [Unit Name], NULL as [Flavour], NULL as [Cost Per Unit], NULL as [Whether Sales Taxable],');
      SQL.Add('      mp.[MultiPurchQty] as Quantity, mp.[Total Cost], mp.[Shortage], (mp.[MultiPurchQty] - ISNULL(mp.[Shortage],0)) as ExpectedQty,');
      SQL.Add('      NULL as [Import/Export Reference], pr.[Sub-Category Name], NULL as IngredQty, NULL as IngredItemCost, NULL as IngredOU,');
      SQL.Add('      mp.[MultiPurchQty], 1 as PurchaseItemType, mp.[EntityCode] as MultiPurchParentID, NULL as Returnable,');
      SQL.Add('      mp.[Record ID] as GroupRecID, NULL as SortImpExpRef, ');
      SQL.Add('      pr.[Purchase Name] as SortItemName, mp.[Total Cost] as SortItemCost, mp.[MultiPurchQty] as SortQty');
      SQL.Add('FROM PurchMultiPurchParent mp, Products pr');
      SQL.Add('WHERE mp.[Supplier Name] = ' + QuotedStr(fgetinvdlg.SupplierName));
      if SiteCode <> 0 then //not all sites
        SQL.Add('AND mp.[Site Code] = ''' + inttostr(SiteCode) + '''');
      SQL.Add('AND mp.[Delivery Note No.] = ' + QuotedStr(fgetinvdlg.DeliveryNoteNo));
      SQL.Add('AND mp.[EntityCode] = pr.[EntityCode]');

      ExecSQL;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu; ERROR - MoveMultiPurchParents: ' + E.Message + '; ' + wwqGetInvoice.SQL.Text);
        raise;
      end;
    end;
  end;
end;

procedure TInvoiceManager.MoveMultiPurchIngredients(SourceTable: string);
begin
  with wwqGetInvoice do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Insert into Invoice(RecNo, ItemId, ItemName, Punit, Flavor, Ucost, Tax, Qty, ItemCost, Ou, ExpectedQty,');
    SQL.Add('                    [ImpExp Ref], [SubCat Name], IngredQty, IngredItemCost, IngredOU, MultiPurchQty,');
    SQL.Add('                    PurchaseItemType, MultiPurchParentID, Returnable, GroupRecID, SortImpExpRef,');
    SQL.Add('                    SortItemName, SortItemCost, SortQty, DataSource)');
    SQL.Add('SELECT  i.[Record ID], i.EntityCode AS [Entity Code], ''-- '' + p.[Purchase Name] AS [Purchase Name],');
    SQL.Add('  p.[Unit Name], p.Flavour, p.[Cost Per Unit], e.[Whether Sales Taxable], NULL AS Quantity,');
    SQL.Add('  NULL AS [Total Cost], NULL AS Shortage, (p.Quantity - ISNULL(p.Shortage,0)) as ExpectedQty, pr.[Import/Export Reference], e.[Sub-Category Name],');
    SQL.Add('  p.Quantity AS IngredQty, p.[Total Cost] AS IngredItemCost, p.Shortage AS IngredOU, NULL AS MultiPurchQty,');
    SQL.Add('  2 AS PurchaseItemType, i.MultiPurchParent AS MultiPurchParentID, i.Returnable, i.GroupRecID,');
    SQL.Add('  NULL AS SortImpExpRef, ');
    SQL.Add('  e2.[Purchase Name] AS SortItemName, mp.[Total Cost] AS SortItemCost, mp.MultiPurchQty AS SortQty, pr.DataSource');
    SQL.Add('FROM ' + SourceTable + ' p INNER JOIN');
    SQL.Add('      PurchReference pr');
    SQL.Add('        ON p.[Site Code] = pr.[Site Code] AND p.[Supplier Name] = pr.[Supplier Name]');
    SQL.Add('        AND p.[Delivery Note No.] = pr.[Delivery Note No.] AND p.[Record ID] = pr.[Record ID] INNER JOIN');
    SQL.Add('      PurchMultiPurchIngreds i');
    SQL.Add('        ON p.[Site Code] = i.[Site Code] AND p.[Supplier Name] = i.[Supplier Name]');
    SQL.Add('        AND p.[Delivery Note No.] = i.[Delivery Note No.] AND p.[Record ID] = i.[Record ID] INNER JOIN');
    SQL.Add('      PurchMultiPurchParent mp');
    SQL.Add('        ON i.[Site Code] = mp.[Site Code] AND i.[Supplier Name] = mp.[Supplier Name]');
    SQL.Add('        AND i.[Delivery Note No.] = mp.[Delivery Note No.] AND i.GroupRecID = mp.[Record ID] INNER JOIN');
    SQL.Add('      Products e');
    SQL.Add('        ON i.EntityCode = e.EntityCode INNER JOIN');
    SQL.Add('      Products e2');
    SQL.Add('        ON mp.EntityCode = e2.EntityCode');
    SQL.Add('WHERE p.[Supplier Name] = ' + QuotedStr(fgetinvdlg.SupplierName));
    if SiteCode <> 0 then //not all sites
      SQL.Add('AND p.[Site Code] = ''' + inttostr(SiteCode) + '''');
    SQL.Add('AND p.[Delivery Note No.] = ' + QuotedStr(fgetinvdlg.DeliveryNoteNo));

    try
      ExecSQL;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu; ERROR - MoveMultiPurchIngredients: ' + E.Message + '; ' + wwqGetInvoice.SQL.Text);
        raise;
      end;
    end;
  end;
end;

procedure TInvoiceManager.SetSortSubcat;
begin
  // set the value for SortSubcat in MultiPurchase Parent items
  with finvfrm.wwtInvoice do
  begin
    Open;
    First;
    while not Eof do
    begin
      if (FieldByName('PurchaseItemType').Value = MULTI_PURCH_PARENT) then
      begin
        Edit;
        FieldByName('SortSubcat').Value := FieldByName('SubCat Name').Value + FormatFloat('000.0',FieldByName('RecNo').Value);
        Post;
      end;
      Next;
    end;
    Close;
  end;
  // set SortSubcat for MultiPurchase Child items
  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update Invoice');
      SQL.Add('set SortSubcat = p.SortSubcat');
      SQL.Add('from Invoice a,');
      SQL.Add('(select distinct GroupRecID, ItemID, SortSubcat');
      SQL.Add(' from Invoice');
      SQL.Add(' where PurchaseItemType = ' + IntToStr(MULTI_PURCH_PARENT) + ') p');
      SQL.Add('where a.GroupRecID = p.GroupRecID');
      SQL.Add('and a.MultiPurchParentID = p.ItemID');
      SQL.Add('and a.PurchaseItemType = ' + IntToStr(MULTI_PURCH_CHILD));
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Log.Event('finvmenu ERROR - SetSortSubcat: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end;
end;

procedure TInvoiceManager.DataModuleCreate(Sender: TObject);
const
  STANDARD_UK_VAT_RATE = 17.5;
begin
  log.event('TInvoiceManager; FormCreate');

  try
    wwtsysvar.open;

    if UKUSmode = 'UK' then
      thetax := STANDARD_UK_VAT_RATE
    else
      thetax := wwtsysvar.FieldByName('tax').asfloat;

    if wwtsysvar.FieldByName('promptuc').asstring = 'Y' then
      promptuc := true
    else
      promptuc := false;

    hideSort := wwtSysVar.FieldByName('HideSortOrder').AsBoolean;

    wwtsysvar.close;

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from Genervar');
      SQL.Add('where VarName = ''PUInsAfter''');
      Open;

      if RecordCount = 0 then // create it first
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert GenerVar ([VarName], [VarString])');
        SQL.Add('Values(''PUInsAfter'', ''Y'')');
        ExecSQL;
        insertAfter := True;
      end
      else
      begin
        insertAfter := (FieldByName('VarString').AsString = 'Y');
        Close;
      end;
    end;

    fnewinvdlg := tfnewinvdlg.Create(self);
    fgetinvdlg := tfgetinvdlg.create(self);
  except
    on E: Exception do
    begin
      Log.Event('TInvoiceManager; ERROR - DataModuleCreate: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TInvoiceManager.DataModuleDestroy(Sender: TObject);
begin
  fnewinvdlg.Free;
  fgetinvdlg.Free;
end;

function TInvoiceManager.InvoicesExist(TblName: string): boolean;
begin
  result := True;
  with qryRun do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + TblName);

    if LowerCase(TblName) = 'purchhdr' then
      SQL.Add('WHERE UPPER(ISNULL(Deleted,''N'')) = ''N''');

    try
      Open;
    except
      on E: Exception do
      begin
        Log.Event('finvmenu ERROR - InvoicesExist: Table is ' + TblName + ', ' + E.Message + '; ' + qryRun.SQL.Text);
        raise;
      end;
    end;

    if recordCount = 0 then
    begin
      result := False;
    end;
    Close;
  end;
end;


end.
