unit uMustCountItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, wwdbedit, Wwdotdot, Wwdbcomb, DB, Wwdatsrc, ADODB,
  wwfltdlg, wwDialog, Wwlocate, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  StdCtrls, Wwkeycb, Buttons, Math, StrUtils;

type
  TfMustCountItems = class(TForm)
    pnlTop: TPanel;
    Label2: TLabel;
    lblTopInfo: TLabel;
    lblProdCount: TLabel;
    Label1: TLabel;
    pnlSearch: TPanel;
    Bevel2: TBevel;
    Label14: TLabel;
    rbSInc: TRadioButton;
    rbsMid: TRadioButton;
    btnPriorSearch: TBitBtn;
    btnNextSearch: TBitBtn;
    Panel1: TPanel;
    rbSearchProds: TRadioButton;
    rbSearchList: TRadioButton;
    edSearch: TEdit;
    incSearch1: TwwIncrementalSearch;
    pnlBottom: TPanel;
    Bevel1: TBevel;
    Label5: TLabel;
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
    Panel2: TPanel;
    btnDiscard: TBitBtn;
    btnDone: TBitBtn;
    btnResetFilters: TBitBtn;
    pnlList: TPanel;
    Splitter3: TSplitter;
    gridList: TwwDBGrid;
    gridProds: TwwDBGrid;
    wwFind: TwwLocateDialog;
    adotProds: TADOTable;
    dsProds: TwwDataSource;
    adotList: TADOTable;
    dsList: TwwDataSource;
    Label4: TLabel;
    lookDiv: TComboBox;
    btnRemove: TBitBtn;
    btnAssign: TBitBtn;
    wwLoc: TwwLocateDialog;
    procedure lookDivCloseUp(Sender: TObject);
    procedure lookCatCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDoneClick(Sender: TObject);
    procedure btnDiscardClick(Sender: TObject);
    procedure btnAssignClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure adotListAfterPost(DataSet: TDataSet);
    procedure btnFilterClick(Sender: TObject);
    procedure btnNoFilterClick(Sender: TObject);
    procedure btnResetFiltersClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure rbSIncClick(Sender: TObject);
    procedure rbSearchProdsClick(Sender: TObject);
    procedure gridProdsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure gridProdsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure gridProdsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure gridListCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure gridListCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure gridListTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPriorSearchClick(Sender: TObject);
  private
    { Private declarations }
    curDiv, curCat: string;
    procedure LoadProducts;
    procedure ReloadList;
  public
    { Public declarations }
    curTemplateID : integer;
    curTemplateName : string;
  end;

var
  fMustCountItems: TfMustCountItems;

implementation

uses uADO, udata1;

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

procedure TfMustCountItems.btnPriorSearchClick(Sender: TObject);
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


procedure TfMustCountItems.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_DELETE, VK_CLEAR, VK_BACK: begin
                 if gridList.HasFocus then
                 begin
                   Key := 0;
                   btnRemoveClick(self);
                 end;
               end;
    VK_INSERT: begin
                 if gridProds.HasFocus then
                 begin
                   Key := 0;
                   btnAssignClick(Sender);
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
  end; // case..
end;



procedure TfMustCountItems.lookDivCloseUp(Sender: TObject);
begin
  curDiv := lookDiv.Text;

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
    if curDiv <> ' - SHOW ALL - ' then
      sql.add('  and div = ' + quotedStr(curDiv));
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
    sql.Add('select distinct scat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
    if curDiv <> ' - SHOW ALL - ' then
      sql.add('  and div = ' + quotedStr(curDiv));
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

procedure TfMustCountItems.lookCatCloseUp(Sender: TObject);
begin
  curDiv := lookDiv.Text;
  curCat := lookCat.Text;

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct scat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
    if curDiv <> ' - SHOW ALL - ' then
      sql.add('  and div = ' + quotedStr(curDiv));
    if curCat <> ' - SHOW ALL - ' then
      sql.add('  and cat = ' + quotedStr(curCat));
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

procedure TfMustCountItems.FormShow(Sender: TObject);
begin
  self.Caption := 'Edit "Must Count" Products List for Template "' + curTemplateName + '"';

  adotProds.TableName := '#AllProducts';
  adotList.TableName := '#TemplateList';

  // fill dropdowns
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct div from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    lookDiv.Items.Clear;
    while not eof do
    begin
      lookDiv.Items.Add(FieldByName('div').asstring);
      next;
    end;
    close;
    lookDiv.Refresh;
    lookDiv.ItemIndex := 0;


    close;
    sql.Clear;
    sql.Add('select distinct cat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
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
    sql.add('  where etcode in (''G'',''P'',''S'')');
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

  LoadProducts;
  ReloadList;

  lblProdCount.Caption := inttostr(adotList.recordcount);

  Application.ProcessMessages;
end;

procedure TfMustCountItems.LoadProducts;
begin
  with dmado.adoqRun do
  try
    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#AllProducts'') IS NOT NULL DROP TABLE #AllProducts');

    SQL.Add('  ');
    SQL.Add('SELECT se.[EntityCode] as [Product ID], se.[Div] as [Division], se.[Cat] as [Category], ');
    SQL.Add('se.[SCat] as [Sub-Category], se.[PurchaseName] as [Product Name], p.[Retail Description] as Description,');
    SQL.Add('se.EntityType as [Product Type], se.[PurchaseUnit] as Unit, 0 as [InList], se.[ImpExRef] as [Imp/Exp Ref]');

    SQL.Add('INTO #AllProducts');
    SQL.Add('FROM stkEntity se');
    SQL.Add('JOIN products p on se.EntityCode = p.EntityCode');
    SQL.Add('WHERE se.[EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')');
    SQL.Add('  ');
    SQL.Add('CREATE CLUSTERED INDEX #AllProducts_IX1 ON [#AllProducts] ([Product ID])  ');
    ExecSQL;

  finally
    Close;
  end;

  adotProds.Close;
  adotProds.Open;
end;

procedure TfMustCountItems.ReloadList;
begin
  with dmado.adoqRun do
  try
    // load Products already in the Template...
    close;
    SQL.Clear;
    SQL.Add('IF object_id(''tempdb..#TemplateList'') IS NOT NULL DROP TABLE #TemplateList');

    SQL.Add('SELECT se.[EntityCode] as [Product ID], se.[Div] as [Division], se.[Cat] as [Category], ');
    SQL.Add('se.[SCat] as [Sub-Category], se.[PurchaseName] as [Product Name],');
    SQL.Add('se.EntityType as [Product Type], se.[ImpExRef] as [Imp/Exp Ref]');

    SQL.Add('INTO #TemplateList');
    SQL.Add('FROM stkEntity se');
    SQL.Add('JOIN (select * from #MustCountItems where Deleted = 0 and TemplateID = ' +
                        intToStr(curTemplateID) + ') i on se.EntityCode = i.ProductID ');
    SQL.Add('WHERE se.[EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')');
    ExecSQL;

    // reset inList for AllProducts
    Close;
    sql.Clear;
    sql.Add('update #AllProducts set inList = 0');
    execSQL;
    sql.Add('update #AllProducts set inList = 1');
    sql.Add('from #AllProducts p, #TemplateList t where p.[Product ID] = t.[Product ID]');
    execSQL;
  finally
    Close;
  end;

  if data1.ssDebug then DumpTemp('#AllProducts', '3');


  adotList.Close;
  adotList.Open;
  adotProds.close;
  adotProds.Open;
  gridProds.Refresh;

  btnDiscard.Enabled := False;
  lblProdCount.Caption := inttostr(adotList.recordcount);
end;


procedure TfMustCountItems.btnDoneClick(Sender: TObject);
begin
  if btnDiscard.Enabled then
  begin
    with dmado.adoqRun do
    try

      close;

      // products in the list in the #MustCountItems already, maybe Deleted or not; --- UPDATE
      SQL.Clear;
      sql.Add('update #MustCountItems set Deleted = 0');
      sql.Add('from #MustCountItems p, #TemplateList t where p.[ProductID] = t.[Product ID]');
      SQL.Add('and p.TemplateID = ' + inttostr(curTemplateID));
      execSQL;

      // products in the list NOT in the #MustCountItems already; --- INSERT
      SQL.Clear;
      sql.Add('insert #MustCountItems ([TemplateID], [ProductID], [Deleted])');
      SQL.Add('SELECT ' + inttostr(curTemplateID) + ', t.[Product ID], 0');
      sql.Add('from #TemplateList t ');
      SQL.Add('LEFT OUTER JOIN (select * from #MustCountItems where TemplateID = ' + inttostr(curTemplateID) + ' ) p');
      SQL.Add('on p.[ProductID] = t.[Product ID]');
      SQL.Add('WHERE p.[ProductID] is NULL');
      execSQL;   

      // products NOT in the list but in #MustCountItems set to Deleted...
      SQL.Clear;
      sql.Add('update #MustCountItems set Deleted = 1');
      sql.Add('where TemplateID = ' + inttostr(curTemplateID));
      SQL.Add('and [ProductID] not in (select [Product ID] from #TemplateList)');
      execSQL;

    finally
      Close;
    end;
    modalResult := mrOK;
  end
  else
    modalResult := mrCancel;
end;

procedure TfMustCountItems.btnDiscardClick(Sender: TObject);
begin
  ReloadList;
end;

procedure TfMustCountItems.btnAssignClick(Sender: TObject);
var
  curRecNo, i: integer;
begin

  if gridProds.SelectedList.Count > 1 then
  begin
    curRecNo := adotProds.RecNo;
    adotProds.DisableControls;

    for i := 0 to gridProds.SelectedList.Count - 1 do
    begin
      adotProds.GotoBookmark(gridProds.SelectedList.items[i]);

      adotList.Insert;
      adotList.fieldbyname('Product ID').asstring := adotProds.fieldbyname('Product ID').asstring;
      adotList.fieldbyname('Division').asstring := adotProds.fieldbyname('Division').asstring;
      adotList.fieldbyname('Category').asstring := adotProds.fieldbyname('Category').asstring;
      adotList.fieldbyname('Sub-Category').asstring := adotProds.fieldbyname('Sub-Category').asstring;
      adotList.fieldbyname('Product Name').asstring := adotProds.fieldbyname('Product Name').asstring;
      adotList.fieldbyname('Product Type').asstring := adotProds.fieldbyname('Product Type').asstring;
      adotList.fieldbyname('Imp/Exp Ref').asstring := adotProds.fieldbyname('Imp/Exp Ref').asstring;
      adotList.Post;

      adotProds.Edit;
      adotProds.fieldbyname('inList').asinteger := 1;
      adotProds.Post;
    end;

    gridProds.UnselectAll;

    if (adotProds.RecordCount > 0) and (curRecNo > 0) then
    begin
      adotProds.RecNo := Min(curRecNo, adotProds.RecordCount);
    end;

    adotProds.EnableControls;
    gridProds.Refresh;
    gridList.Refresh;
  end
  else
  begin
    adotList.Insert;
    adotList.fieldbyname('Product ID').asstring := adotProds.fieldbyname('Product ID').asstring;
    adotList.fieldbyname('Division').asstring := adotProds.fieldbyname('Division').asstring;
    adotList.fieldbyname('Category').asstring := adotProds.fieldbyname('Category').asstring;
    adotList.fieldbyname('Sub-Category').asstring := adotProds.fieldbyname('Sub-Category').asstring;
    adotList.fieldbyname('Product Name').asstring := adotProds.fieldbyname('Product Name').asstring;
    adotList.fieldbyname('Product Type').asstring := adotProds.fieldbyname('Product Type').asstring;
    adotList.fieldbyname('Imp/Exp Ref').asstring := adotProds.fieldbyname('Imp/Exp Ref').asstring;
    adotList.Post;

    adotProds.Edit;
    adotProds.fieldbyname('inList').asinteger := 1;
    adotProds.Post;
    gridProds.Refresh;
    gridList.Refresh;
  end;


end;

procedure TfMustCountItems.btnRemoveClick(Sender: TObject);
var
  curRecNo, i: integer;
begin

  if gridList.SelectedList.Count > 1 then
  begin
    curRecNo := adotList.RecNo;
    adotList.DisableControls;

    for i := 0 to gridList.SelectedList.Count - 1 do
    begin
      adotList.GotoBookmark(gridList.SelectedList.items[i]);

      with dmADO.adoqRun do
      begin
        SQL.Clear;
        sql.Add('update #AllProducts set inList = 0');
        sql.Add('where [Product ID] = ' + adotList.fieldbyname('Product ID').asstring);
        execSQL;
      end;

      adotList.Delete;
    end;

    gridList.UnselectAll;

    if (adotList.RecordCount > 0) and (curRecNo > 0) then
    begin
      adotList.RecNo := Min(curRecNo, adotList.RecordCount);
    end;

    adotList.EnableControls;
    adotProds.Requery;
    gridProds.Refresh;
    gridList.Refresh;
  end
  else
  begin
    with dmADO.adoqRun do
    begin
      SQL.Clear;
      sql.Add('update #AllProducts set inList = 0');
      sql.Add('where [Product ID] = ' + adotList.fieldbyname('Product ID').asstring);
      execSQL;
    end;

    adotProds.Requery;

    adotList.Delete;
    gridProds.Refresh;
    gridList.Refresh;
  end;
end;

procedure TfMustCountItems.adotListAfterPost(DataSet: TDataSet);
begin
  lblProdCount.Caption := inttostr(adotList.recordcount);
  btnDiscard.Enabled := TRUE;
end;

procedure TfMustCountItems.btnFilterClick(Sender: TObject);
var
  s1, filtDiv, filtCat, filtSCat, filtNoLoc, filtThisLoc, filtName : string;
begin
  if lookDiv.Text <> ' - SHOW ALL - '  then filtDiv := ' and Division = ' + quotedStr(lookDiv.Text);
  if lookCat.Text <> ' - SHOW ALL - '  then filtCat := ' and Category = ' + quotedStr(lookCat.Text);
  if lookSCat.Text <> ' - SHOW ALL - ' then filtSCat := ' and Sub-Category = ' + quotedStr(lookSCat.Text);

  s1 := trim(LowerCase(edFilt.Text));
  if s1 <> '' then
  begin
    if rbmid.Checked then
      s1 := '*' + s1;
    filtName := ' and [Product Name] LIKE ' + quotedStr(s1 + '*');
  end;

  s1 := filtDiv + filtCat + filtSCat + filtNoLoc + filtThisLoc + filtName;

  if s1 = '' then
  begin
    adotProds.Filter := 'inList = 0 ';
    showMessage('Filter conditions not set. No Filtering is done.');
    lblFilterStatus.Color := clGreen;
    lblFilterStatus.Caption := 'Filtering' + #13 + ' is OFF';
  end
  else
  begin
    adotProds.Filter := 'inList = 0 ' + s1;
    lblFilterStatus.Color := clRed;
    lblFilterStatus.Caption := 'Filtering' + #13 + ' is ON';
  end;

  adotProds.Filtered := TRUE;
end;

procedure TfMustCountItems.btnNoFilterClick(Sender: TObject);
begin
  adotProds.Filter := 'inList = 0 ';
  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering' + #13 + 'is OFF';
end;

procedure TfMustCountItems.btnResetFiltersClick(Sender: TObject);
begin
  lookDiv.ItemIndex := 0;

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
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
    sql.Add('select distinct scat from stkEntity');
    sql.add('  where etcode in (''G'',''P'',''S'')');
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


  edFilt.Text := '';
  adotProds.Filter := 'inList = 0 ';

  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering' + #13 + 'is OFF';

  Application.ProcessMessages;

end;

procedure TfMustCountItems.btnNextSearchClick(Sender: TObject);
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;

  wwFind.FindNext;
end;

procedure TfMustCountItems.rbSIncClick(Sender: TObject);
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

procedure TfMustCountItems.rbSearchProdsClick(Sender: TObject);
begin
  if rbSearchProds.Checked then
  begin
    incSearch1.DataSource := dsProds;
  end
  else
  begin
    incSearch1.DataSource := dsList;
  end;

  wwFind.DataSource := incSearch1.DataSource;
  wwFind.SearchField := incSearch1.SearchField;
  rbsearchprods.Font.Color := clWhite;
end;

procedure TfMustCountItems.gridProdsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if  (Field.FieldName = 'Product Type') then  // (Field.FieldName = 'Descr') or
  begin
    if Field.AsString = 'Prep.Item' then   //adotProds.FieldByName('Product Type').asstring = 'Prep.Item' then
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

procedure TfMustCountItems.gridProdsCalcTitleAttributes(Sender: TObject;
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

procedure TfMustCountItems.gridProdsTitleButtonClick(Sender: TObject;
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
      IndexFieldNames := '[Division], [Category], [Sub-Category], [Product Name]';
    end
    else
    begin
      IndexFieldNames := '[' + AFieldName + ']';
    end;

    EnableControls;
  end;
end;

procedure TfMustCountItems.gridListCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if  (Field.FieldName = 'Product Type') then  // (Field.FieldName = 'Descr') or
  begin
    if Field.AsString = 'Prep.Item' then   //adotProds.FieldByName('Product Type').asstring = 'Prep.Item' then
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

procedure TfMustCountItems.gridListCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if '[' + (AFieldName) + ']'  = adotList.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if '[' + (AFieldName + '] DESC') = adotList.IndexFieldNames then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;  
end;

procedure TfMustCountItems.gridListTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotList do
  begin
    DisableControls;

    if '[' + (AFieldName) + ']' = IndexFieldNames then // already Yellow, go to red...
    begin
      IndexFieldNames := '[' + AFieldName + '] DESC';
    end
    else if '[' + (AFieldName + '] DESC') = IndexFieldNames then // already Red, go to nothing...
    begin
      IndexFieldNames := '[Division], [Category], [Sub-Category], [Product Name]';
    end
    else
    begin
      IndexFieldNames := '[' + AFieldName + ']';
    end;

    EnableControls;
  end;
end;

end.
