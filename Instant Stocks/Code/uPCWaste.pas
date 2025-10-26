unit uPCWaste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, Grids, Wwdbigrd, Wwdbgrid,
  ExtCtrls, ActnList, DBCtrls, Wwkeycb, wwDialog, Wwlocate;

const SHOW_ALL = ' - SHOW ALL - ';

type
  TfPCWaste = class(TForm)
    BottomPanel: TPanel;
    MainPanel: TPanel;
    LeftPanel: TPanel;
    RightPanel: TPanel;
    PanelProduct: TPanel;
    SearchPanel: TPanel;
    wwDBGrid1: TwwDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    AddBitBtn: TBitBtn;
    DeleteBitBtn: TBitBtn;
    EditBitBtn: TBitBtn;
    wwDBGrid2: TwwDBGrid;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    dsTmpProducts: TDataSource;
    adottmpProducts: TADOTable;
    WasteLabel: TLabel;
    ProductsLabel: TLabel;
    adoqLoadTmpProducts: TADOQuery;
    dsPCWaste: TDataSource;
    ActionList1: TActionList;
    ActAddWaste: TAction;
    ActDeleteWaste: TAction;
    ActEditWaste: TAction;
    adotstkPCWaste: TADOTable;
    adoqPCWaste: TADOQuery;
    LabelNote: TLabel;
    DBMemoNote: TDBMemo;
    adotstkPCWasteRecID: TIntegerField;
    adotstkPCWasteEntityCode: TFloatField;
    adotstkPCWasteSub: TStringField;
    adotstkPCWastePurN: TStringField;
    adotstkPCWastegrp: TIntegerField;
    adotstkPCWasteQty: TFloatField;
    adotstkPCWasteUnit: TStringField;
    adotstkPCWasteBaseUnits: TFloatField;
    adotstkPCWasterecid2: TIntegerField;
    adotstkPCWasteDescr: TStringField;
    adotstkPCWasteNote: TStringField;
    LabelNameSearch: TLabel;
    EditMidwordSearchName: TEdit;
    wwFind: TwwLocateDialog;
    wwIncrementalSearchName: TwwIncrementalSearch;
    RadioButtonIncremental: TRadioButton;
    LabelF7: TLabel;
    RadioButtonMidword: TRadioButton;
    LabelF8: TLabel;
    ActIncrementalSearch: TAction;
    ActMidwordSearch: TAction;
    BitBtnPrev: TBitBtn;
    BitBtnNext: TBitBtn;
    ActSearchPrev: TAction;
    ActSearchNext: TAction;
    GroupBox1: TGroupBox;
    LabelDivision: TLabel;
    LabelCategory: TLabel;
    LabelSubCategory: TLabel;
    ComboBoxDivisionFilter: TComboBox;
    ComboBoxCategoryFilter: TComboBox;
    ComboBoxSubCategoryFilter: TComboBox;
    ActSave: TAction;
    adotstkPCWasteETCode: TStringField;
    Label1: TLabel;
    rbAll: TRadioButton;
    rbExpSite: TRadioButton;
    lblProdCount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ActAddWasteExecute(Sender: TObject);
    procedure ActEditWasteExecute(Sender: TObject);
    procedure wwDBGrid2DblClick(Sender: TObject);
    procedure ActDeleteWasteExecute(Sender: TObject);
    procedure ActDeleteWasteUpdate(Sender: TObject);
    procedure ActEditWasteUpdate(Sender: TObject);
    procedure ActMidwordSearchExecute(Sender: TObject);
    procedure ActIncrementalSearchExecute(Sender: TObject);
    procedure ActSearchNextExecute(Sender: TObject);
    procedure ActSearchPrevExecute(Sender: TObject);
    procedure ComboBoxDivisionFilterChange(Sender: TObject);
    procedure ComboBoxCategoryFilterChange(Sender: TObject);
    procedure ComboBoxSubCategoryFilterChange(Sender: TObject);
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure BottomPanelDblClick(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActSaveUpdate(Sender: TObject);
    procedure adotstkPCWasteQtyGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
  private
    { Private declarations }
    FHzID: Integer;
    FHzName: String;
    procedure BuildDivisionList;
    procedure BuildCategoryList;
    procedure BuildSubCategoryList;
    procedure DoFilter;
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
  public
    { Public declarations }
    property HzID: Integer read FHzID write FHzID;
    property HzName: String read FHzName write FHzName;
  end;

  // Provider=SQLNCLI.1;Password=sa;Persist Security Info=True;User ID=sa

var
  fPCWaste: TfPCWaste;

implementation

uses uADO, StrUtils, uPCWasteEdit, uGlobals, uLog, udata1;

{$R *.dfm}

procedure TfPCWaste.FormShow(Sender: TObject);
begin
  adoqLoadTmpProducts.ExecSQL;

  adoqPCWaste.ExecSQL;

  with dmado.adoqRun do
  try
    // set the Expected Items status from stkECLevel.
    Close;
    sql.Clear;
    sql.Add('update #tmpProducts set Expected = 1  ');
    SQL.Add('from #tmpProducts t, (select distinct [EntityCode]  from stkECLevel  ');
    SQL.Add('       where [BaseQty] <> 0 or [PurQty] <> 0 or [Transfers] <> 0     ');
    SQL.Add('	   or [TheoRed] <> 0 or [TrueECL] <> 0 or [ECL] <> 0 or [SCVar] <> 0) sq  ');
    SQL.Add('where t.EntityCode = sq.EntityCode  ');
    execSQL;

    SQL.Clear;
    SQL.Add('SELECT SUM(CASE dozform  WHEN ''Y'' THEN 1 ELSE 0 END) AS dozs,');
    SQL.Add('       SUM(CASE gallform WHEN ''Y'' THEN 1 ELSE 0 END) AS galls');
    SQL.Add('FROM Threads');
    SQL.Add('WHERE Active = ''Y''');
    Open;

    if not (BOF and EOF) then
    begin
      data1.curGallForm := FieldByName('galls').AsInteger > 0;
      data1.curdozForm := FieldByName('dozs').AsInteger > 0;
    end;
  finally
    Close;
  end;

  adottmpProducts.Active := True;
  adotstkPCWaste.Active := True;
  RadioButtonIncremental.Checked := True;

  if FHzName <> '' then
    ProductsLabel.Caption := ProductsLabel.Caption + ' - Holding Zone: ' + FHzName;

  BuildDivisionList;
end;

procedure TfPCWaste.ActAddWasteExecute(Sender: TObject);
var
  fPCWasteEdit: TfPCWasteEdit;
begin
  // show insert/edit form
  fPCWasteEdit := TfPCWasteEdit.Create(self);
  try
    fPCWasteEdit.ProductDataset := TADODataset(adottmpProducts);
    fPCWasteEdit.WasteDataset := TADODataset(adotstkPCWaste);
    fPCWasteEdit.editmode := False;
    fPCWasteEdit.ShowModal;
  finally
    fPCWasteEdit.Free;
  end;
end;

procedure TfPCWaste.ActEditWasteExecute(Sender: TObject);
var
  fPCWasteEdit: TfPCWasteEdit;
begin
  // show insert/edit form
  fPCWasteEdit := TfPCWasteEdit.Create(self);
  try
    fPCWasteEdit.ProductDataset := TADODataset(adottmpProducts);
    fPCWasteEdit.WasteDataset := TADODataset(adotstkPCWaste);
    fPCWasteEdit.editmode := True;
    fPCWasteEdit.ShowModal;
  finally
    fPCWasteEdit.Free;
  end;
end;

procedure TfPCWaste.wwDBGrid2DblClick(Sender: TObject);
begin
  ActEditWaste.Execute;
end;

procedure TfPCWaste.ActDeleteWasteExecute(Sender: TObject);
var
  TheGrp: String;
  WasRecNo: Integer;
begin
  with adotstkPCWaste do
  begin
    if not (EOF and BOF) then
    begin
      TheGrp := FieldByName('grp').AsString;

      Delete;

      with dmADO.adoqRun do
      try
        WasRecNo := adotstkPCWaste.RecNo;

        Close;
        SQL.Clear;
        SQL.Add('IF NOT EXISTS(SELECT TOP 1 * FROM #PCWaste WHERE grp = ' + TheGrp + ')');
        SQL.Add(' UPDATE #PCWaste SET grp = grp - 1 WHERE grp > ' + TheGrp);
        ExecSQL;

        adotstkPCWaste.Requery;

        if WasRecNo <= adotstkPCWaste.RecordCount then
          adotstkPCWaste.RecNo := WasRecNo;
      finally
        Close;
      end;
    end;
  end;
end;

procedure TfPCWaste.ActDeleteWasteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not (adotstkPCWaste.Eof and adotstkPCWaste.Bof);
end;

procedure TfPCWaste.ActEditWasteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not (adotstkPCWaste.Eof and adotstkPCWaste.Bof);
end;

procedure TfPCWaste.ActMidwordSearchExecute(Sender: TObject);
begin
  wwIncrementalSearchName.Visible := not ActMidwordSearch.Checked;
  EditMidwordSearchName.Visible := ActMidwordSearch.Checked;

  if EditMidwordSearchName.Visible then
  begin
    wwFind.MatchType := mtPartialMatchAny;
    EditMidwordSearchName.SetFocus;
  end;
end;

procedure TfPCWaste.ActIncrementalSearchExecute(Sender: TObject);
begin
  wwIncrementalSearchName.Visible := ActIncrementalSearch.Checked;
  EditMidwordSearchName.Visible := not ActIncrementalSearch.Checked;

  if wwIncrementalSearchName.Visible then
  begin
    wwFind.MatchType := mtPartialMatchStart;
    wwIncrementalSearchName.SetFocus;
  end;
end;

procedure TfPCWaste.ActSearchNextExecute(Sender: TObject);
begin
  if wwIncrementalSearchName.Visible then
    wwFind.FieldValue := wwIncrementalSearchName.Text
  else
    wwFind.FieldValue := EditMidwordSearchName.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;

procedure TfPCWaste.ActSearchPrevExecute(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
begin
  if wwIncrementalSearchName.Visible then
    wwFind.FieldValue := wwIncrementalSearchName.Text
  else
    wwFind.FieldValue := EditMidwordSearchName.Text;

  if wwFind.FieldValue = '' then
    exit;

  // find prior has to be done programatically...
  with adottmpProducts do
  begin
    disablecontrols;

    { get a bookmark so that we can return to the same record }
    SavePlace := GetBookmark;
    try
      matchyes := false;

      while (not bof) do
      begin
        Prior;

        // check for match
        if ActIncrementalSearch.Checked then // incremental.
          matchyes := AnsiStartsText(wwIncrementalSearchName.Text, FieldByName('Name').asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName('Name').asstring,EditMidwordSearchName.Text);

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

procedure TfPCWaste.BuildDivisionList;
begin
  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct div as divname from #tmpProducts');
    SQl.Add('union select ('' - SHOW ALL - '') as divname');
    SQl.Add('order by div asc');
    Open;
    First;

    ComboboxDivisionFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxDivisionFilter.Items.Add(FieldByName('divname').asstring);
      Next;
    end;
    Close;

    ComboboxDivisionFilter.Refresh;
    ComboboxDivisionFilter.ItemIndex := 0;
  finally
    Close;
  end;

  BuildCategoryList;
end;

procedure TfPCWaste.BuildCategoryList;
begin
  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct cat from #tmpProducts');
    if ComboBoxDivisionFilter.Text <>  SHOW_ALL then
      SQL.Add('where div = ' + QuotedStr(ComboBoxDivisionFilter.Text));
    SQL.Add('union select ('' - SHOW ALL - '') as cat');
    SQL.Add('order by cat asc');
    Open;
    First;

    ComboboxCategoryFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxCategoryFilter.Items.Add(FieldByName('cat').AsString);
      Next;
    end;
    Close;

    ComboboxCategoryFilter.Refresh;
    ComboboxCategoryFilter.ItemIndex := 0;
  finally
    Close;
  end;

  BuildSubCategoryList;
end;

procedure TfPCWaste.BuildSubCategoryList;
var
  DivText: String;
  Cattext: String;
  FilterText: String;
begin
  FilterText := '';
  DivText := ComboBoxDivisionFilter.Text;
  CatText := ComboBoxCategoryFilter.Text;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct sub from #tmpProducts');

    if (DivText <>  SHOW_ALL)
    or (CatText <>  SHOW_ALL) then
    begin
      if DivText <>  SHOW_ALL then
        FilterText := 'div = ' + QuotedStr(DivText);

      if CatText <>  SHOW_ALL then
      begin
        if DivText <>  SHOW_ALL then
          FilterText := FilterText + ' and ';
        FilterText := FilterText + 'cat = ' + QuotedStr(CatText);
      end;
    end;

    if FilterText <> '' then
      SQL.Add('where ' + FilterText);
    SQL.Add('union select ('' - SHOW ALL - '') as sub');
    SQL.Add('order by sub asc');
    Open;
    First;

    ComboboxSubCategoryFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxSubCategoryFilter.Items.Add(FieldByName('sub').AsString);
      Next;
    end;
    Close;

    ComboboxSubCategoryFilter.Refresh;
    ComboboxSubCategoryFilter.ItemIndex := 0;
  finally
    Close;
  end;

  DoFilter;
end;

procedure TfPCWaste.ComboBoxSubCategoryFilterChange(Sender: TObject);
begin
  DoFilter;
end;

procedure TfPCWaste.DoFilter;
var
  filterText : string;
  DivText, CatText, SubCatText: String;
begin   
  DivText := ComboBoxDivisionFilter.Text;
  CatText := ComboBoxCategoryFilter.Text;
  SubCatText := ComboBoxSubCategoryFilter.Text;

  if rbExpSite.Checked then
    filterText := 'Expected = 1'
  else
    filterText := 'Expected < 100'; // this ensures the filter string can be added to with an "and" in safety...

  if DivText <>  SHOW_ALL then
    FilterText := FilterText + ' and div = ' + QuotedStr(DivText);

  if CatText <>  SHOW_ALL then
    FilterText := FilterText + ' and cat = ' + QuotedStr(CatText);

  if SubCatText <>  SHOW_ALL then
    FilterText := FilterText + ' and sub = ' + QuotedStr(SubCatText);

  adottmpProducts.DisableControls;
  adottmpProducts.Filter := FilterText;
  adottmpProducts.Filtered := True;
  adottmpProducts.Requery;
  adottmpProducts.EnableControls;

  if adottmpProducts.RecordCount = 0 then
  begin
    wwdbGrid1.Enabled := false;
    lblProdCount.Caption := '(No Products with these Filter criteria)';
  end
  else
  begin
    wwdbGrid1.Enabled := true;
    lblProdCount.Caption := '(Showing ' + inttostr(adottmpProducts.RecordCount) + ' Products)';
  end;

  addBitBtn.Enabled := wwdbGrid1.Enabled;
  bitBtnPrev.Enabled := wwdbGrid1.Enabled;
  bitBtnNext.Enabled := wwdbGrid1.Enabled;
end;

procedure TfPCWaste.ComboBoxDivisionFilterChange(Sender: TObject);
begin
  BuildCategoryList;
end;

procedure TfPCWaste.ComboBoxCategoryFilterChange(Sender: TObject);
begin
  BuildSubCategoryList;
end;

procedure TfPCWaste.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin

  if (adotstkPCWaste.FieldByName('ETCode').asstring = 'P') then
  begin
    if (Field.FieldName = 'PurN') then
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
      if gdSelected in State then
      begin
        ABrush.Color := clHighlight;
        AFont.Color := clHighlightText;
      end
      else
      begin
        AFont.Color := clWindowText;
        if (adotstkPCWaste.FieldByName('grp').AsInteger mod 2) = 1 then
          ABrush.Color := clAqua
        else
          ABrush.Color := clWhite;
      end;
    end;
  end
  else
  begin
      if gdSelected in State then
      begin
        ABrush.Color := clHighlight;
        AFont.Color := clHighlightText;
      end
      else
      begin
        AFont.Color := clWindowText;
        if (adotstkPCWaste.FieldByName('grp').AsInteger mod 2) = 1 then
          ABrush.Color := clAqua
        else
          ABrush.Color := clWhite;
      end;
  end;
end;

procedure TfPCWaste.BottomPanelDblClick(Sender: TObject);
begin
  if data1.ssDebug then
    with dmADO.adoqRun2 do
    begin
      Close;
      sql.Clear;
      sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_PCWaste'')) DROP TABLE [stkZZ_PCWaste]');
      sql.Add('SELECT * INTO dbo.[stkZZ_PCWaste] FROM [#pcWaste]');
      execSQL;
    end;
end;

procedure TfPCWaste.wwDBGrid1DblClick(Sender: TObject);
begin
  ActAddWaste.Execute;
end;

procedure TfPCWaste.ActSaveExecute(Sender: TObject);
var
  theTermID: string;
begin
  if MessageDlg('Do you wish to save these Waste records and exit this screen?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // if any Prep Item waste then calculate and store the Waste for its ingredients,
    // both in stkPCWaste for detail reporting and in stkTheoRed for "proper" calculations...
    // use the same DateTime as the parent waste, use C as ETCode...

    with dmADO.adoqRun do
    begin
      // Group By to ensure that if a Prep Item has the same ingredient more than once then it is
      // only 1 record per ingredient that gets wasted, with the tot waste qty...

      Close;
      sql.Clear;
      sql.Add('insert [#pcwaste] ([RecID], [EntityCode], [Sub], [PurN], [grp], [Qty], [Unit], ');
      sql.Add('                   [BaseUnits], [recid2], [Descr], [Note], [WasteDt], [ETCode], Parent)');
      sql.Add('select wr.recid, wr.Child, null, null, null, wr.iQty / e.PurchBaseU, ');
      sql.Add('    e.PurchaseUnit, e.PurchBaseU, 0, '''', '''', wr.WasteDT, ''C'', wr.entitycode');
      sql.Add('from  ');
      sql.Add(' (select w.recid, w.WasteDT, w.entitycode, r.Child, SUM(r.RcpQty * w.qty) as iQty ');
      sql.Add('   from [#pcwaste] w join stk121Rcp r on r.Parent = w.EntityCode');
      sql.Add('   where w.ETcode = ''P''');
      sql.Add('   group by w.recid, w.WasteDT, w.entitycode, r.Child) wr');
      sql.Add(' join stkEntity e on e.EntityCode = wr.Child');
      execSQL;
    end;

    with dmADO.adoqRun do
    begin
      // Get ByHz for each product in #pcwaste so that products that are not in any thread division
      // that is Holding Zone enabled will be saved to stkPCWaste with 0 as HzID.  This ensures
      // that the wastage values for those products will be included in stocks for their division
      Close;
      SQL.Clear;
      SQL.Text :=
        'IF object_id(''tempdb..#tmpProductByHz'') IS NOT NULL DROP TABLE #tmpProductByHz ' +
        'SELECT DISTINCT p.EntityCode, th.ByHz ' +
        'INTO #tmpProductByHz ' +
        'FROM ' +
        '  Products p ' +
        'JOIN ' +
        '  ac_ProductSubCategory s ON s.Name = p.[Sub-Category Name] ' +
        'JOIN ' +
        '  ac_ProductCategory c ON c.Id = s.ProductCategoryId ' +
        'JOIN ' +
        '  ac_ProductDivision d ON d.Id = c.ProductDivisionId ' +
        'JOIN ' +
        '  ( ' +
        '    SELECT t.Division, MAX(CAST(t.ByHz AS smallint)) AS ByHz ' +
        '    FROM ' +
        '      Threads t ' +
        '    INNER JOIN ' +
        '      ( ' +
        '        SELECT Tid, MAX(StockCode) AS StockCode ' +
        '        FROM Stocks ' +
        '        GROUP BY Tid ' +
        '      ) s on s.Tid = t.Tid ' +
        '    WHERE s.StockCode > 1 ' +
        '    AND t.Active = ''Y'' ' +
        '    GROUP BY t.division ' +
        '  ) th ON th.Division = d.Name ';
      execSQL;
    end;


    if data1.ssDebug then
      with dmADO.adoqRun2 do
      begin
        Close;
        sql.Clear;
        sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_PCWaste'')) DROP TABLE [stkZZ_PCWaste]');
        sql.Add('SELECT * INTO dbo.[stkZZ_PCWaste] FROM [#pcWaste]');
        execSQL;
        Close;
        sql.Clear;
        sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_tmpProductByHz'')) DROP TABLE [stkZZ_tmpProductByHz]');
        sql.Add('SELECT * INTO dbo.[stkZZ_tmpProductByHz] FROM [#tmpProductByHz]');
        execSQL;
      end;

    dmADO.BeginTransaction;
    try
      try
        with dmADO.adoqRun do
        try
          Close;

          SQL.Clear;
          SQL.Add('INSERT stkPCWaste ([SiteCode], [HzID], [EntityCode], [WasteDT],');
          SQL.Add(' [BsDate], [Unit],	[WValue],	[BaseUnits], [WasteBy], [WasteFlag],');
          SQl.Add('	[LMBy], [Note], [Deleted], Parent)');
          SQL.Add('SELECT dbo.fnGetSiteCode(), ');
          SQL.Add(' CASE h.ByHz WHEN 0 THEN 0 ELSE ' + IntToStr(FHzID) + ' END AS HzID, ' );
          SQL.Add(' a.[EntityCode], a.[WasteDT],');
          SQL.Add(' dbo.fn_ConvertToBusinessDate(a.[WasteDT]), [Unit], [Qty],');
          SQL.Add(' [BaseUnits], ' + QuotedStr(uGlobals.CurrentUser.UserName) + ', ');
          SQL.Add(' ETCode, '+ QuotedStr(uGlobals.CurrentUser.UserName) + ',[Note],0, [Parent] ');
          SQL.Add('FROM #PCWaste a ');
          SQL.Add('JOIN #tmpProductByHz h ON h.EntityCode = a.EntityCode ');
          ExecSQL;

          //In terms of Waste the FromTrx field values are:
          //  0 - Automatic Waste i.e pipe waste
          //  1 - Manual waste
          // -1 - Corrected (i.e. Deleted) manual waste
          //  2 - Ingred. Waste coming from a PRepared Item
          // -2 - Corrected (i.e. Deleted) Ingred. Waste coming from a PRepared Item

          theTermID := '0';
          if FHzID > 0 then // if using Holding Zones
          begin
            // for the Cellar HZ the TermID = 0, for any other HZ pick the 1st TerminalID of that HZ,
            
            close;
            sql.Clear;
            sql.Add('select top 1 p.TerminalID, h.ePur');
            sql.Add('from stkHZs h LEFT OUTER JOIN stkHzPOS p');
            sql.Add('on h.HZID = p.HZID and h.SiteCode = p.SiteCode ');
            sql.Add('where h.active = 1 and h.HZID = ' + IntToStr(FHzID) + ' and h.SiteCode = ' + IntToStr(data1.TheSiteCode));
            open;

            theTermID := fieldByName('TerminalID').AsString;

            // if a HZ  does not have a Terminal (Cellar or another) then the Waste goes to Cellar...
            if theTermID = '' then
              theTermID := '0';
            close;
          end;

          SQL.Clear;
          SQL.Add('');
          SQL.Add('INSERT stkTheoRed ([TermID], [DT], [FromTrx], [EntityCode], [RedQty],');
          SQL.Add('                   [WasteFlag], [ProcFlag], [BsDate], [LMDT], [Parent], [Source])');
          SQL.Add('SELECT '+ theTermID +', a.wasteDT, CASE ETCode WHEN ''C'' THEN 2 ELSE 1 END,');
          SQL.Add('       a.EntityCode, SUM(a.[Qty] * a.[BaseUnits]) as RedQty, 1, 0,');
          SQL.Add('  dbo.fn_ConvertToBusinessDate(a.[WasteDT]), GETDATE() as LMDT, Parent, ETCode');
          SQL.Add('FROM #PCWaste a where ETCode <> ''P''');
          SQL.Add('GROUP BY a.EntityCode,a.WasteDT, ETCode, Parent');

          ExecSQL;

          //Ensure the waste records appear in any subsequent line check
          SQL.Clear;
          SQL.Add('exec stkSP_ECLRed');

          ExecSQL;

          dmADO.CommitTransaction;
        finally
          Close;
        end;
      except
        on E:Exception do
          log.event('Error saving PCWaste record - error: ' + E.Message);
      end;
    finally
      if dmADO.InTransaction then
      begin
        dmADO.RollbackTransaction;
        log.event('Error saving PCWaste record - transaction rolled back');
      end;
    end;
  end
  else
  begin
    modalResult := mrNone;
  end;
end;

procedure TfPCWaste.ActSaveUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not (adotstkPCWaste.Bof and adotstkPCWaste.Eof);
end;

procedure TfPCWaste.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfPCWaste.adotstkPCWasteQtyGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  Text := data1.dozGallFloatToStr(adotstkPCWasteUnit.Value, sender.Asfloat);
end;

procedure TfPCWaste.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin     
  if  (Field.FieldName = 'Name') then  // (Field.FieldName = 'Descr') or
  begin
    if adottmpProducts.FieldByName('ETCode').asstring = 'P' then
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

procedure TfPCWaste.BitBtnCancelClick(Sender: TObject);
begin
  if not (adotstkPCWaste.Eof and adotstkPCWaste.Bof) then
    if MessageDlg('You have entered some Waste in this session which is NOT saved.' + #10#13 +
      'Do you wish to exit this screen now?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      modalResult := mrNone;
    end;
end;

procedure TfPCWaste.rbAllClick(Sender: TObject);
begin
  DoFilter;
end;

end.
