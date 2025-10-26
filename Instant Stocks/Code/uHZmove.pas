unit uHZmove;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls,
  DBCtrls, Grids, Wwdbigrd, Wwdbgrid, DB, Wwdatsrc, ADODB, wwdblook,
  Wwkeycb, wwDialog, Wwlocate, strUtils, ppStrtch, ppMemo, ppBands,
  ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppComm,
  ppRelatv, ppDB, ppDBPipe, Printers, wwdbdatetimepicker, uGlobals;

type
  TfHZmove = class(TForm)
    pnlStep1: TPanel;
    pnlStep3: TPanel;
    pnlStep2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnChooseItems: TBitBtn;
    BitBtn2: TBitBtn;
    adoqSource: TADOQuery;
    dsList: TwwDataSource;
    adoqDest: TADOQuery;
    lookSource: TwwDBLookupCombo;
    lookDest: TwwDBLookupCombo;
    dsProds: TwwDataSource;
    adotProds: TADOTable;
    adotList: TADOTable;
    wwFind: TwwLocateDialog;
    adotListRecID: TIntegerField;
    adotListEntityCode: TFloatField;
    adotListSub: TStringField;
    adotListPurN: TStringField;
    adotListQty: TFloatField;
    adotListUnit: TStringField;
    adotListBaseUnits: TFloatField;
    adotListgrp: TIntegerField;
    adotListrecid2: TIntegerField;
    adotListDescr: TStringField;
    wwDBGrid1: TwwDBGrid;
    Panel1: TPanel;
    Label18: TLabel;
    lblFrom: TLabel;
    Label20: TLabel;
    lblTo: TLabel;
    Memo1: TMemo;
    Label19: TLabel;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Label21: TLabel;
    ppDBPipeline1: TppDBPipeline;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppShape3: TppShape;
    pplTitle: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine24: TppLine;
    pplMvDate: TppLabel;
    pplFromTo: TppLabel;
    pplMvBy: TppLabel;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine10: TppLine;
    ppLine12: TppLine;
    ppLine16: TppLine;
    ppLine9: TppLine;
    ppLine11: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine17: TppLine;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLabel4: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel16: TppLabel;
    ppMemo1: TppMemo;
    Label22: TLabel;
    dtPick: TwwDBDateTimePicker;
    Label24: TLabel;
    PanelLeft: TPanel;
    pnlSearch: TPanel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edSearch: TEdit;
    rbSInc: TRadioButton;
    rbsMid: TRadioButton;
    btnPriorSearch: TBitBtn;
    btnNextSearch: TBitBtn;
    incSearch1: TwwIncrementalSearch;
    gridProds: TwwDBGrid;
    PanelTop: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Panel4: TPanel;
    Label23: TLabel;
    lblFrom1: TLabel;
    Label25: TLabel;
    lblTo1: TLabel;
    ClientPanel: TPanel;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Bevel4: TBevel;
    Label4: TLabel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    lookDiv: TComboBox;
    lookCat: TComboBox;
    lookSCat: TComboBox;
    edFilt: TEdit;
    rbStart: TRadioButton;
    rbMid: TRadioButton;
    btnFilter: TBitBtn;
    btnNoFilter: TBitBtn;
    btnTransfer: TBitBtn;
    btnDel: TBitBtn;
    btnEdit: TBitBtn;
    BitBtn9: TBitBtn;
    gridList: TwwDBGrid;
    BitBtnImportDeliveryNote: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnChooseItemsClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure lookCatCloseUp(Sender: TObject);
    procedure lookDivCloseUp(Sender: TObject);
    procedure lookSCatCloseUp(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnNoFilterClick(Sender: TObject);
    procedure rbSIncClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPriorSearchClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure gridProdsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure gridProdsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure adotListQtyGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure gridProdsDblClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure adotListAfterPost(DataSet: TDataSet);
    procedure gridListDblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure ppDBText5GetText(Sender: TObject; var Text: String);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure lookSourceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure lookDestChange(Sender: TObject);
    procedure BitBtnImportDeliveryNoteClick(Sender: TObject);
  private
    hzidsource, hziddest : integer;
    hznamesource, hznamedest : string[30];
    hzPurSource: Boolean;

    fillDiv, fillCat, fillSCat, awGridFilt, awOnlyFilt : string;
    userMoveDT : tdatetime;

    procedure ViewPanel(thePanel: TPanel);
    procedure SetGridFilt;
    procedure EdDelButs;
    procedure ImportFromDeliveryNote(SiteCode: Integer; SupplierName: String;
      DeliveryNoteNo: String; Curr: Boolean);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  fHZmove: TfHZmove;

implementation

uses uADO, udata1, uHZMedit, dRunSP, ulog, uHZMoveImportDelivery;

{$R *.dfm}

// #ccToDo: Logging and error handling for this form...

procedure TfHZmove.FormCreate(Sender: TObject);
begin
  ViewPanel(pnlStep1);
  adoqDest.Open;
  adoqSource.Open;
  dtPick.DateTime := Now;
  dtPick.MinDate := Date - 37;


  BitBtnImportDeliveryNote.Caption := 'Import ' + uGlobals.GetLocalisedName(lsInvoice)
end;

procedure TfHZmove.ViewPanel(thePanel: TPanel);
begin
  // make all panels invisible
  pnlStep1.Visible := false;
  pnlStep2.Visible := false;
  pnlStep3.Visible := false;
  //pnlStep4.Visible := false;

  // make this panel visible
  thePanel.Visible := True;
  thePanel.Top := 0;
  thePanel.Left := 0;
  self.HelpContext := thePanel.HelpContext;

  // resize form
  self.ClientHeight := thepanel.Height;
  self.ClientWidth := thepanel.Width;
  self.Left := (screen.WorkAreaWidth div 2) - (self.Width div 2);
  self.Top := (screen.WorkAreaHeight div 2) - (self.Height div 2);

  Application.ProcessMessages;
end; // procedure..

procedure TfHZmove.btnChooseItemsClick(Sender: TObject);
var
  LoopDivision: string;
begin
  try
    // proc date time
    if dtPick.DateTime > Now then
    begin
      showMessage('You cannot Transfer things in the future!');
      dtPick.DateTime := Now;
      dtPick.SetFocus;
      exit;
    end;

    if dtPick.DateTime < (Date - 37) then
    begin
      showMessage('You cannot do Transfers for dates before ' +
        formatDateTime('ddddd', Date - 37));
      dtPick.DateTime := Now;
      dtPick.SetFocus;
      exit;
    end;

    userMoveDT := dtPick.DateTime;

    self.Enabled := False; // lock form while long processing is done

    lookSource.PerformSearch;
    lookDest.PerformSearch;

    hzidSource := adoqSource.FieldByName('hzid').asinteger;
    hzNameSource := adoqSource.FieldByName('hzname').asstring;
    hzPurSource := adoqSource.FieldByName('ePur').AsBoolean;
    BitBtnImportDeliveryNote.Visible := hzPurSource;

    hzidDest := adoqDest.FieldByName('hzid').asinteger;
    hzNameDest := adoqDest.FieldByName('hzname').asstring;

    lblFrom1.Caption := ' ' + hznamesource + ' ';
    lblTo1.Caption := ' ' + hznamedest + ' ';


    // fill adotProds with products

    with dmADO.adoqRun do                                                                                                         
    begin
      // should special formatting for Dozen and Gallon be turned on?
      // Yes if it is set for at least one active thread...
      close;
      sql.Clear;
      sql.Add('select count(dozform) as dozes from threads where active = ''Y'' and dozform = ''Y''');
      open;

      if FieldByName('dozes').AsInteger > 0 then
        data1.curdozForm := True
      else
        data1.curdozForm := False;

      close;
      sql.Clear;
      sql.Add('select count(gallform) as galls from threads where active = ''Y'' and gallform = ''Y''');
      open;

      if FieldByName('galls').AsInteger > 0 then
        data1.curGallForm := True
      else
        data1.curGallForm := False;

      close;

      // re-do the stkHZMProdsTMP table

      dmADO.DelSQLTable('stkHZMProdsTMP');
      close;
      sql.Clear;
      sql.Add('SELECT [EntityCode], [Cat], [Div], [SCat] as Sub,');
      sql.Add('[PurchaseName] as PurN, [PurchaseUnit] as PurUnit, [RetailName] as Descr');
      sql.Add('INTO dbo.stkHZMProdsTMP');
      sql.Add('FROM stkEntity');
      sql.Add('WHERE [EntityType] IN (''Strd.Line'', ''Purch.Line'', ''Prep.Item'')');
      sql.Add('order by [Div], [Cat], [SCat], [PurchaseName]');
      execSQL;

      close;
      sql.Clear;
      sql.Add('select distinct div from stkHZMProdsTMP');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookDiv.Items.Clear;
      while not eof do
      begin
        lookDiv.Items.Add(FieldByName('div').asstring);
        LoopDivision := FieldByName('div').asstring;

        with TADOQuery.Create(nil) do
        try
          Connection := dmADO.AztecConn;

          SQL.Clear;
          SQL.Add('delete stkHZMProdsTMP');
          SQL.Add('from');
          SQL.Add(' (select a.entitycode from stkHZMProdsTMP a, Products b');
          SQL.Add('  where a.Div = ' + quotedStr(LoopDivision));
          SQL.Add('  and a.entitycode = b.entitycode');
          SQL.Add('  and b.Deleted = ''Y''');
          SQL.Add('  and b.lmdt < (select max(SDate) from Stocks where ' +
                           'Division = ' + quotedStr(LoopDivision) + ')) sq');
          SQL.Add('where stkHZMProdsTMP.entitycode = sq.entitycode');
          ExecSQL;
        finally
          Free;
        end;

        next;
      end;

      close;

      sql.Clear;
      sql.Add('select distinct cat from stkHZMProdsTMP');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      lookCat.Items.Clear;
      while not eof do
      begin
        lookCat.Items.Add(FieldByName('cat').asstring);
        next;
      end;

      close;

      sql.Clear;
      sql.Add('select distinct sub from stkHZMProdsTMP');
      sql.Add('union select ('' - SHOW ALL - '') as divname');
      open;
      first;

      looksCat.Items.Clear;
      while not eof do
      begin
        looksCat.Items.Add(FieldByName('sub').asstring);
        next;
      end;
      close;

      // re-create the List table
      dmADO.DelSQLTable('stkHZMListTMP');
      close;
      sql.Clear;
      sql.Add('CREATE TABLE dbo.[stkHZMListTMP] ([RecID] [int] NULL, [EntityCode] [float] NULL,');
      sql.Add('	[Sub] [varchar] (20) NULL, [PurN] [varchar] (40) NULL, [grp] [int] NULL,');
      sql.Add('	[Qty] [float] NULL,	[Unit] [varchar] (10) NULL,	[BaseUnits] [float] NULL,');
      sql.Add(' [recid2] [int], [Descr] [varchar] (20) NULL,');
      sql.Add(' [temp_transfer_identity] [int] IDENTITY(1,1) NOT NULL,)');
      execSQL;

      adotProds.Open;
      adotList.Open;
    end;

    fillDiv := '';
    fillCat := '';
    fillSCat := '';
    awGridFilt := '';
    awOnlyFilt := '';
    lookdiv.ItemIndex := 0;
    lookcat.ItemIndex := 0;
    lookscat.ItemIndex := 0;
    edFilt.Text := '';
    edSearch.Text := '';
    incsearch1.Text := '';
    adotProds.Filter := '';
    adotProds.Filtered := False;
    rbStart.Checked := True;
    wwFind.MatchType := mtPartialMatchStart;
    label15.Color := clGreen;
    label15.Caption := 'Filtering is OFF';
    adotProds.IndexFieldNames := 'Sub';

    Self.Caption := 'Internal Transfer (' + formatDateTime('ddddd hh:nn', userMoveDT) + ') - Step 2: Set Products & quantities';
    ViewPanel(pnlStep2);

  finally
    self.Enabled := True; // unlock form even if error in processing
  end;

end;

procedure TfHzMove.SetGridFilt;
var
  s1 : string;
begin
  s1 := trim(LowerCase(edFilt.Text));

  if s1 <> '' then
  begin
    if rbmid.Checked then
      s1 := '*' + s1 + '*'
    else
      s1 := s1 + '*';

    awOnlyFilt := 'purN LIKE ' + quotedStr(s1);
  end
  else
  begin
    awOnlyFilt := '';
  end;

  if awGridFilt <> '' then
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awGridFilt + ' AND ' + awOnlyFilt
    else
      adotProds.Filter := awGridFilt;
  end
  else
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awOnlyFilt
    else
      adotProds.Filter := '';
  end;

//  if adotProds.State = dsBrowse then
//    adotProdsAfterScroll(adotProds);
end;

procedure TfHzMove.lookDivCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookDiv.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillDiv := lookDiv.Text;
    fillCat := '';
    fillSCat := '';
  end
  else
  begin
    fillDiv := '';
    fillCat := '';
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;


  // 1. "filter" the adoqCat
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stkHZMProdsTMP');
    if fillDiv <> '' then
       sql.add('where div = ' + quotedStr(fillDiv));

    sql.Add('union select ('' - SHOW ALL - '') as divname');
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

  // 2. "filter" the adoqSCat
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct sub from stkHZMProdsTMP');
    if f1 <> '' then
       sql.add('where ' + f1);

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  //SetGridFilt;
end;

procedure TfHzMove.lookCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillCat := lookCat.Text;
    fillSCat := '';
  end
  else
  begin
    fillCat := '';
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;

  // 2. "filter" the adoqSCat
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct sub from stkHZMProdsTMP');
    if f1 <> '' then
       sql.add('where ' + f1);

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  //SetGridFilt;
end;

procedure TfHzMove.lookSCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookSCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillSCat := lookSCat.Text;
  end
  else
  begin
    fillSCat := '';
  end;

  f1 := '';
  if fillDiv <> '' then
  begin
    f1 := 'Div = ' + quotedStr(fillDiv);
    if fillCat <> '' then
      f1 := f1 + ' AND Cat = ' + quotedStr(fillCat); // for lookSCat

    f2 := f1;
    if fillSCat <> '' then
      f2 := f2 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
  end
  else
  begin
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  //SetGridFilt;
end;

procedure TfHZmove.BitBtn4Click(Sender: TObject);
begin
  try
    self.Enabled := False; // lock form while long processing is done
    Self.Caption := 'Internal Transfer (' + formatDateTime('ddddd hh:nn', userMoveDT) + ') - Step 3: Confirm and Save';

    lblFrom.Caption := ' ' + hznamesource + ' ';
    lblTo.Caption := ' ' + hznamedest + ' ';

    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(recid) as thecount, count(distinct entitycode) as theents');
      sql.Add('from stkHZMListTMP');
      open;

      label21.Caption := 'Transfer Rows: ' + FieldByName('thecount').asstring + ' ' + #13 +
                         'Products: ' + FieldByName('theents').asstring + ' ' + #13 +
                         '("Confirm && Save" also Prints)';
      close;
    end;


    ViewPanel(pnlStep3);
  finally
    self.Enabled := True; // unlock form even if error in processing
  end;

end;

procedure TfHZmove.btnFilterClick(Sender: TObject);
begin
  SetGridFilt;
  if adotProds.Filter = '' then
  begin
    adotProds.Filtered := False;
    showMessage('Filter conditions not set. No Filtering is done.');
    label15.Color := clGreen;
    label15.Caption := 'Filtering is OFF';
  end
  else
  begin
    adotProds.Filtered := True;
    label15.Color := clRed;
    label15.Caption := 'Filtering is ON';
  end;
end;

procedure TfHZmove.btnNoFilterClick(Sender: TObject);
begin
  adotProds.Filtered := False;
  label15.Color := clGreen;
  label15.Caption := 'Filtering is OFF';
end;

procedure TfHZmove.rbSIncClick(Sender: TObject);
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

procedure TfHZmove.btnNextSearchClick(Sender: TObject);
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;

procedure TfHZmove.btnPriorSearchClick(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;

  // find prior has to be done programatically...
  with adotProds do
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
        if rbsInc.Checked then // incremental.
          matchyes := AnsiStartsText(incSearch1.Text, FieldByName('purN').asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName('purN').asstring,edSearch.Text);

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

procedure TfHZmove.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pnlStep2.Visible then
  begin
    case key of
      VK_DELETE: begin
                   if gridList.HasFocus then
                   begin
                     Key := 0;
                     btnDelClick(Sender);
                   end;
                 end;
      VK_RETURN: begin
                   if gridList.HasFocus then
                   begin
                     Key := 0;
                     btnEditClick(Sender);
                   end
                   else
                   begin
                     Key := 0;
                     btnTransferClick(Sender);
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
               rbsInc.Checked := True;
               rbSIncClick(Sender);
             end;
      VK_F8: begin
               Key := 0;
               rbsMid.Checked := True;
               rbSIncClick(Sender);
             end;
    end; // case..
  end;
end;

procedure TfHZmove.BitBtn3Click(Sender: TObject);
begin
  try
    self.Enabled := False; // lock form while long processing is done

    adotprods.Close;
    adotList.Close;
    Self.Caption := 'Internal Transfer';

    ViewPanel(pnlStep1);
  finally
    self.Enabled := True; // unlock form even if error in processing
  end;
end;

procedure TfHZmove.gridProdsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = adotProds.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end;

end;

procedure TfHZmove.gridProdsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotProds do
  begin
    DisableControls;

    if AFieldName <> IndexFieldNames then
      IndexFieldNames := AFieldName;

    EnableControls;
  end;
end;

procedure TfHZmove.BitBtn9Click(Sender: TObject);
begin
  // print
  pplMvDate.Caption := '---- Transfer NOT Confirmed ----';
  pplFromTo.Caption := 'From: ' + hznamesource + '  --  To: ' + hznamedest;
  pplMvBy.Caption := 'Entered By: ' + CurrentUser.UserName;
  ppSummaryBand1.Visible := False;
  ppReport1.Print;
end;

procedure TfHZmove.btnTransferClick(Sender: TObject);
begin
  // show insert/edit form
  fHZMEdit := TfHZMEdit.Create(self);
  fhzmedit.editmode := False;

  fhzmEdit.ShowModal;
  fhzmedit.Free;
  EdDelButs;
end;

procedure TfHZmove.adotListQtyGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  Text := data1.dozGallFloatToStr(adotListUnit.Value, sender.Asfloat);
end;

procedure TfHZmove.gridProdsDblClick(Sender: TObject);
begin
  btnTransferClick(Sender);
end;

procedure TfHZmove.btnEditClick(Sender: TObject);
begin
  // show insert/edit form
  fHZMEdit := TfHZMEdit.Create(self);
  fhzmedit.editmode := True;
  fhzmEdit.ShowModal;
  fhzmedit.Free;
  EdDelButs;
end;

procedure TfHZmove.btnDelClick(Sender: TObject);
var
  recid, grp : string;
begin
  with data1.adoqRun do
  begin
    recid := gridList.DataSource.DataSet.FieldByName('recid').asstring;
    grp := gridList.DataSource.DataSet.FieldByName('grp').asstring;

    close;
    sql.Clear;
    sql.Add('delete from stkHZMListTmp where recid = ' + recid + ' and grp = ' + grp);
    execSQL;

    // renumber the list table...
    close;
    sql.Clear;
    sql.Add('select * from stkHZMListTmp order by grp, recid');
    open;

    if recordcount > 0 then
    begin
      while not eof do
      begin
        edit;
        FieldByName('recid2').asinteger := recno;
        post;
        next;
      end;

      close;

      close;
      sql.Clear;
      sql.Add('update stkHZMListTmp set recid = recid2');
      execSQL;
    end;
    close;

    adotList.disablecontrols;
    adotList.requery;
    adotList.enablecontrols;
  end;
  EdDelButs;

end;

procedure TfHZmove.EdDelButs;
begin
  btnDel.Enabled := (adotList.RecordCount > 0);
  btnEdit.Enabled := btnDel.Enabled;
  bitBtn4.Enabled := btnDel.Enabled;
  bitBtn9.Enabled := btnDel.Enabled;
end; // procedure..


procedure TfHZmove.adotListAfterPost(DataSet: TDataSet);
begin
 EdDelButs;
end;

procedure TfHZmove.gridListDblClick(Sender: TObject);
begin
  btnEditClick(Sender);
end;

procedure TfHZmove.BitBtn7Click(Sender: TObject);
begin
  try
    self.Enabled := False; // lock form while long processing is done

    Self.Caption := 'Internal Transfer (' + formatDateTime('ddddd hh:nn', userMoveDT) + ') - Step 2: Set Products & quantities';

    ViewPanel(pnlStep2);
  finally
    self.Enabled := True; // unlock form even if error in processing
  end;
end;

procedure TfHZmove.BitBtn8Click(Sender: TObject);
var
  mdt, dt1 : tDateTime;
  moveID : integer;
begin
  // save everithing to stkHZMoves and stkHZMProds
  // do it all in one batch to be able to use SCOPE_IDENTITY() to get the MoveID from stkHZMoves
  // and use it as part of Key for stkHZMProds...

  with data1.adoqRun do
  begin
    dmADO.DelSQLTable('#ScopeGhost');
    mdt := Now;
    close;
    sql.Clear;
    sql.Add('insert stkHZMoves ([SiteCode], [hzIDSource], [hzIDDest], [MoveDT], [MoveBy],');
    sql.Add('       [LMDT], [LMBy], [MoveNote])');
    sql.Add('VALUES (('+IntToStr(data1.TheSiteCode)+'), ('+IntToStr(hzidSource)+'),');
    sql.Add(' ('+IntToStr(hziddest)+'), ('+ quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss', userMoveDT)) +'),');
    sql.Add(' ('+quotedStr(CurrentUser.UserName)+'), (' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', mdt)) + '),');
    sql.Add(' ('+quotedStr(CurrentUser.UserName)+'), (' + quotedStr(Trim(memo1.Text)) + '))');
    sql.Add('');
    sql.Add('DECLARE @si int');
    sql.Add('SET @si = SCOPE_IDENTITY()');
    sql.Add('');
    sql.Add('SELECT @si AS [SCOPE_IDENTITY] into #ScopeGhost');
    sql.Add('');
    sql.Add('insert stkHZMProds ([SiteCode], [MoveID], [RecID],');
    sql.Add('       [EntityCode], [Qty], [BaseU], [MoveU], [LMDT])');
    sql.Add('Select ('+IntToStr(data1.TheSiteCode)+'), @si, [recid], ');
    sql.Add('  [entitycode], ([qty] * [baseunits]), [baseunits], [unit],');
    sql.Add('  (' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', mdt)) + ')');
    sql.Add(' from stkHZMListTMP');
    execSQL;

    close;
    sql.Clear;
    sql.Add('select [SCOPE_IDENTITY] from #ScopeGhost');
    open;
    moveID := FieldByName('SCOPE_IDENTITY').asinteger;
    close;

    log.event('Int Transfer ID: ' + inttoStr(moveID) + ', ' + hznamesource + ' -> ' +
               hznamedest + '(' + inttoStr(hzidSource) + '->' + inttoStr(hziddest) +
                          '), MoveDT: ' + formatDateTime('ddddd hh:nn:ss', userMoveDT));

    // CALL stkSP_ECLTransfer procedure....
    dmRunSP := TdmRunSP.Create(self);
    with dmRunSP do
    begin
      spConn.Open;
      with adoqRunSP do
      begin
        close;
        sql.Clear;
        sql.Add('DECLARE @ret int');
        sql.Add('exec @ret = stkSP_ECLtransfer ' + inttoStr(moveID) + ', ' + inttoStr(hzidSource) +
          ', ' + inttoStr(hziddest) + ', ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', userMoveDT)));
        sql.Add('SELECT @ret');
        dt1 := Now;

        try
         Open;
         if fields[0].AsInteger >= 0 then
          log.event('SP EXECUTED - (' + fields[0].AsString + ' recs Upd or Ins) ' +
            formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
         else if fields[0].AsInteger = -5 then // no HZs in stkECLevel
         begin
           log.event('SP EXECUTED but No HZs in stkECLevel yet ' +
                      formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"');
         end
         else if fields[0].AsInteger = -6 then // HZs in stkECLevel but not for the Divs in the Move
         begin
           log.event('SP EXECUTED but stkECLevel not by HZ for the req Divs ' +
                      formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"');
         end
         else if fields[0].AsInteger = -7 then // HZs in stkECLevel for the Divs in the Move but
         begin                                 //   Move DT <= BaseDT (i.e. Stock already accepted)
           log.event('SP EXECUTED but Move DT is before EndDT of last Acc Stock ' +
                      formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"');
         end
         else
         begin
          log.event('SP EXECUTED - ' +
            formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
            ' RET CODE: ' + fields[0].AsString);
         end;
        except
          on E:Exception do
          begin
            log.event('SP ERROR - "' + sql[1] + '"' +
            ' ERR MSG: ' + E.Message);
            showMessage('ERROR in Stored Procedure Setting Current Level from this Transfer' + #13 +
              'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.' + #13 +
              '(NOTE: The Transfer itself has been saved to the database)');
          end;
        end;
      end;
      spConn.Close;
    end;
    dmRunSP.Free;
  end;

  // print transfer list
  pplMvDate.Caption := 'Transfer Date/Time: ' + formatDateTime('ddddd hh:nn:ss', userMoveDT);
  pplFromTo.Caption := 'From: ' + hznamesource + '  --  To: ' + hznamedest;
  pplMvBy.Caption := 'Entered By: ' + CurrentUser.UserName;
  pplTitle.Caption := 'Internal Transfer ' + inttostr(moveID);
  ppSummaryBand1.Visible := True;
  if Memo1.Text = '' then
  begin
    ppmemo1.Visible := False;
    pplabel16.Visible := False;
  end
  else
  begin
    ppmemo1.Visible := true;
    pplabel16.Visible := true;
    ppmemo1.Text := memo1.Text;
  end;

  if data1.ssDebug then
  begin
    ppReport1.ShowPrintDialog := True;
    ppReport1.DeviceType := 'Screen';
  end
  else
  begin
    ppReport1.ShowPrintDialog := False;
    ppReport1.DeviceType := 'Printer';
  end;

  ppReport1.PrinterSetup.PaperName := data1.repPaperName;

  ppReport1.Print;
end;

procedure TfHZmove.ppDBText5GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText4.Text,Text);
end;

procedure TfHZmove.ppReport1PreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfHZmove.lookSourceCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
  i1 : integer;
begin
  try
    i1 := strtoint(lookSource.LookupValue);
  except
    i1 := -1;
  end;

  adoqDest.Parameters.ParamByName('thesource').Value := i1;
  adoqDest.Requery;

  lookDest.Text := '';

  if adoqDest.RecordCount > 0 then
  begin
    lookDest.Enabled := True;
  end
  else
  begin
    lookDest.Enabled := False;
  end;
end;

procedure TfHZmove.lookDestChange(Sender: TObject);
begin
  btnChooseItems.Enabled := (lookDest.Text <> '') and (lookSource.Text <> '');
end;

procedure TfHZmove.BitBtnImportDeliveryNoteClick(Sender: TObject);
var
  DeliveryNoteSelectionForm: TfHZMoveImportDelivery;
begin
  DeliveryNoteSelectionForm := TfHZMoveImportDelivery.Create(self);
  try
    if DeliveryNoteSelectionForm.ShowModal = mrOK then
      ImportFromDeliveryNote(DeliveryNoteSelectionForm.SiteCode,
        DeliveryNoteSelectionForm.SupplierName,
        DeliveryNoteSelectionForm.DeliveryNoteNo,
        DeliveryNoteSelectionForm.Curr);
  finally
    DeliveryNoteSelectionForm.Release;
  end;
end;

procedure TfHZmove.ImportFromDeliveryNote(SiteCode: Integer; SupplierName,
  DeliveryNoteNo: String; Curr: Boolean);
var
  thegrp: integer;
  tablename: string;
begin
  with data1.adoqRun do
  try
    if Curr then
      tablename := 'Purchase'
    else
      tablename := 'AccPurch';

    close;
    sql.Clear;
    sql.Add('select max(grp) as thegrp from stkHZMListTmp');
    open;

    thegrp := FieldByName('thegrp').asinteger + 1;
    close;

    // now insert the quantities wherever totq > 0...
    close;
    sql.Clear;
    sql.Add('insert stkHZMListTmp ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr])');
    sql.Add('select 0, [Entity Code], p.[Sub-Category Name], a.[Purchase Name], Quantity, [Unit name],');
    sql.Add('dbo.fn_UnitAsBaseUnits(a.[Unit name]), ' + IntToStr(thegrp) + ', p.[Extended RTL Name]');
    sql.Add('from ' + tablename + ' a');
    sql.Add('join products p');
    sql.Add('on a.[Entity Code] = p.EntityCode');
    sql.Add('where a.[supplier name] = ''' + SupplierName + '''');
    sql.Add('and a.[Delivery Note No.] = ''' + DeliveryNoteNo + '''');
    sql.Add('and a.[Site Code] = ' + IntToStr(SiteCode));
    sql.Add('and Quantity > 0');

    execSQL;

    // renumber the list table...
    close;
    sql.Clear;
    sql.Add('select * from stkHZMListTmp order by grp, recid');
    open;

    while not eof do
    begin
      edit;
      FieldByName('recid2').asinteger := recno;
      post;
      next;
    end;

    close;

    close;
    sql.Clear;
    sql.Add('update stkHZMListTmp set recid = recid2');
    execSQL;

    adotList.disablecontrols;
    adotList.requery;
    adotList.enablecontrols;
  finally
    close;
  end;
  EdDelButs
end;

end.
