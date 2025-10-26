unit uStkMisc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Wwquery, Db, Wwdatsrc, Wwtable, Mask, wwdbedit, StdCtrls,
  DBCtrls, Buttons, ADODB, ExtCtrls, Wwdbgrid, ComCtrls, ImgList;

type
  Tfstkmisc = class(TForm)
    wwDS1: TwwDataSource;
    wwqStkMisc: TADOQuery;
    memoDlg: TwwMemoDialog;
    Panel1: TPanel;
    wwqStkMiscSiteCode: TSmallintField;
    wwqStkMiscTid: TSmallintField;
    wwqStkMiscStockCode: TSmallintField;
    wwqStkMiscHzID: TSmallintField;
    wwqStkMiscMiscBalReason1: TStringField;
    wwqStkMiscMiscBal1: TFloatField;
    wwqStkMiscMiscBalReason2: TStringField;
    wwqStkMiscMiscBal2: TFloatField;
    wwqStkMiscMiscBalReason3: TStringField;
    wwqStkMiscMiscBal3: TFloatField;
    wwqStkMiscSiteManager: TStringField;
    wwqStkMiscStockTaker: TStringField;
    wwqStkMiscBanked: TFloatField;
    wwqStkMiscReportHeader: TStringField;
    wwqStkMiscStockTypeShort: TStringField;
    wwqStkMiscStockNote: TMemoField;
    wwqStkMiscTotOpCost: TFloatField;
    wwqStkMiscTotPurch: TFloatField;
    wwqStkMiscTotMoveCost: TFloatField;
    wwqStkMiscTotCloseCost: TFloatField;
    wwqStkMiscTotInc: TFloatField;
    wwqStkMiscTotNetInc: TFloatField;
    wwqStkMiscTotCostVar: TFloatField;
    wwqStkMiscTotProfVar: TFloatField;
    wwqStkMiscTotSPCost: TFloatField;
    wwqStkMiscTotConsVal: TFloatField;
    wwqStkMiscTotLGW: TFloatField;
    wwqStkMiscTotRcpVar: TFloatField;
    wwqStkMiscTotAWvalue: TFloatField;
    wwqStkMiscPer: TSmallintField;
    wwqStkMiscLMDT: TDateTimeField;
    wwqStkMiscextraInc: TFloatField;
    wwqStkMiscTotTillVar: TFloatField;
    wwqStkMischzName: TStringField;
    wwqStkMischzPurch: TBooleanField;
    wwqStkMischzSales: TBooleanField;
    wwqStkMiscDeclaredPay: TFloatField;
    hzTabs: TPageControl;
    hzTab0: TTabSheet;
    PanelMiddle: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEditR1: TwwDBEdit;
    DBEditA1: TwwDBEdit;
    DBEditA2: TwwDBEdit;
    DBEditR2: TwwDBEdit;
    DBEditR3: TwwDBEdit;
    DBEditA3: TwwDBEdit;
    StaticText1: TStaticText;
    stAWvalue: TDBEdit;
    PanelBottom: TPanel;
    Label3: TLabel;
    OKBtn: TBitBtn;
    DBStkMemo: TDBMemo;
    CancelBtn: TBitBtn;
    PanelTop: TPanel;
    Shape1: TShape;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label9: TDBText;
    Label8: TDBText;
    Label6: TDBText;
    labWholeSite: TLabel;
    labNoSales: TLabel;
    DBEditActT: TwwDBEdit;
    pnlNoTills: TPanel;
    Label10: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure DBStkMemoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure hzTabsChange(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    viewHZ : smallint;
    newStk : boolean;
  end;

var
  fstkmisc: Tfstkmisc;

implementation

uses udata1, uADO;

{$R *.DFM}

procedure Tfstkmisc.FormShow(Sender: TObject);
begin
  self.Caption := 'Miscellaneous ' + data1.SSbig + ' Figures';
  label3.Caption := data1.SSbig + ' Note (Dbl-Click to edit in large window):';

  with data1.adoqRun do
  begin

    // create stkCrMisc..
    dmADO.DelSQLTable('stkCrMisc');

    Close;
    sql.Clear;
    sql.Add('select * into dbo.stkCrMisc from stkMisc');
    sql.Add('where stockCode = '+IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    execSQL;

    // if the number of HZs has changed since this stock was last calculated...
    if data1.curByHz then
    begin
      // delete any HZs that no longer exist...
      close;
      sql.Clear;
      sql.Add('delete stkCrMisc where (hzid > 0) and');
      sql.Add('  (hzid not in(select hzid from stkHZs where active = 1)) ');
      execSQL;

      // update the ePur and eSales in case the properties changed...
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set HzPurch = sq.ePur, HzSales = sq.eSales, HzName = sq.HzName');
      sql.Add('from (select * from stkHZs where active = 1) sq');
      sql.Add('where stkCrMisc.hzid = sq.hzid'); 
      execSQL;

      // add records for HZs newly created...
      close;
      sql.Clear;
      sql.Add('insert stkCrMisc ([SiteCode], [Tid], [StockCode], [HzID], [MiscBalReason1], ');
      sql.Add('    [MiscBal1], [MiscBalReason2], [MiscBal2], [MiscBalReason3], [MiscBal3], ');
      sql.Add('    [SiteManager], [StockTaker], [Banked], [ReportHeader], [StockTypeShort],');
      sql.Add('    [StockNote], [TotOpCost], [TotPurch], [TotMoveCost], [TotCloseCost],    ');
      sql.Add('    [TotInc], [TotNetInc], [TotCostVar], [TotProfVar], [TotSPCost],         ');
      sql.Add('    [TotConsVal], [TotLGW], [TotRcpVar], [TotAWvalue], [Per], [LMDT],       ');
      sql.Add('    [extraInc], [TotTillVar], [HzName], [HzPurch], [HzSales])                ');
      sql.Add('select s.[SiteCode], s.[Tid], s.[StockCode], h.[HzID], null, 0, null, 0, null, 0,');
      sql.Add(' s.[SiteManager], s.[StockTaker], 0, s.[ReportHeader], s.[StockTypeShort], null, 0, 0,');
      sql.Add(' 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, s.[Per], null, 0, 0, h.[HzName], h.[ePur], h.[eSales]');
      sql.Add('from (select * from stkCrMisc  where HzID = 0) s,   ');
      sql.Add('   (select * from stkHZs where active = 1           ');
      sql.Add('   and hzid not in (select hzid from stkCrMisc)) h  ');
      execSQL;
    end;


    // if set up as such (pcWAtoMisc = True)
    // load the first Misc Allowance with pcWaste Adjustment (if any)
    // for now it will NOT be Read Only (until the effect on Master/Slave is clarified)
    if data1.pcWAtoMisc then
    begin
      // as stkCrDiv data is already summed up there is no need to sum up for hzID = 0 if
      // stock is done byHZ....
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set miscBal1 = sq.wv, miscBalReason1 = ''PC Waste Adj. Value''');
      sql.Add('from (');
      sql.Add('  SELECT hzid, sum("wastePCA" * "NomPrice") as Wv');
      sql.Add('  FROM "StkCrDiv"');
      sql.Add('  WHERE "key2" < 1000');
      sql.Add('  group by hzid having sum("wastePCA" * "NomPrice") <> 0) sq');
      sql.Add('where stkCrMisc.hzid = sq.hzid');
      execSQL;

      DBEditR1.ReadOnly := True;
      DBEditR1.Color := clTeal;
      DBEditR1.Font.Color := clWhite;

      DBEdita1.ReadOnly := True;
      DBEdita1.Color := clTeal;
      DBEdita1.Font.Color := clWhite;
    end;

    // null and 0 the fields that are always recalculated ...
    Close;
    sql.Clear;
    sql.Add('update stkCrMisc set totInc = 0, totNetInc = 0, totTillVar = 0, totAWValue = 0');
    execSQL;

    if not data1.noTillsOnSite then
    begin
      // get tot income and NetIncome from StkCrSld into stkCrMisc
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set totInc = sq.income, totNetInc = sq.totnetinc');
      sql.Add('from (select a.hzid, (sum(a."income")) as income,');
      sql.Add('      (sum(a."Income" - a."vatRate")) as totNetInc');
      sql.Add('      from "stkCrSld" a group by a.hzid) sq');
      sql.Add('where stkCrMisc.hzid = sq.hzid');
      execSQL;

      // now get the till variances
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set totTillVar = sq.TillVar from ');

      if data1.curByHZ then
      begin
        sql.Add('(select b.hzid, (sum(a."declaration variance")) as tillVar');
        sql.Add('from "posdec" a, stkHZPos b, fn_PosCodeToTerminalIdMap() t');
      end
      else
      begin
        sql.Add('(select (sum("declaration variance")) as tillVar');
        sql.Add('from "posdec"');
      end;

      // Stock First Date
      if data1.NeedBeg then
      begin
        if data1.STime >= data1.roll then
        begin
          sql.Add('where (([End Date] = ' + quotedStr(formatDateTime('yyyymmdd', data1.SDate)));
          sql.Add('  and [End Time] >= ' + quotedStr(data1.STime) + ')');
        end
        else
        begin
          sql.Add('where (([End Date] = ' + quotedStr(formatDateTime('yyyymmdd', data1.SDate + 1)));
          sql.Add('  and [End Time] >= ' + quotedStr(data1.STime) + ')');
        end;
      end
      else
      begin
        sql.Add('where (([End Date] = ''' + formatdatetime('yyyymmdd', data1.sDate) + '''');
        sql.Add('       and [End Time] >= ''' + data1.roll + ''')');
      end;

      // Stock Dates no 1st or last
      sql.Add(' or ([End date] > ' + quotedStr(formatdatetime('yyyymmdd', data1.sDate)));
      sql.Add('      and [End date] <= ' + quotedStr(formatdatetime('yyyymmdd', data1.eDate)) + ')');

      // Stock Last Date
      if data1.NeedEnd then
      begin
        if data1.ETime >= data1.roll then
        begin
          sql.Add('or ([End Date] = ' + quotedStr(formatDateTime('yyyymmdd', data1.EDate + 1)));
          sql.Add('  and [End Time] < ' + quotedStr(data1.ETime) + '))');
        end
        else
        begin
          sql.Add('or ([End Date] = ' + quotedStr(formatDateTime('yyyymmdd', data1.EDate + 2)));
          sql.Add('  and [End Time] < ' + quotedStr(data1.ETime) + '))');
        end;
      end
      else
      begin
        sql.Add('  or ([End Date] = ' + quotedStr(formatDateTime('yyyymmdd', data1.EDate + 1)));
        sql.Add('    and [End Time] < ''' + data1.roll + '''))');
      end;

      if data1.curByHZ then
      begin
        sql.Add('and a.[pos code] = t.POSCode and t.TerminalID = b.TerminalID group by b.hzid) as sq');
        sql.Add('where stkCrMisc.hzid = sq.hzid');
        execSQL;

        // now SUM UP per hzid and add it to hzid = 0
        close;
        sql.Clear;
        sql.Add('update stkCrMisc set totTillVar = sq.totTillVar');
        sql.Add('from');
        sql.Add('  (select sum(a.totTillVar) as totTillVar');
        sql.Add('   from stkCrMisc a where a.hzid > 0) sq');
        sql.Add('where stkCrMisc.hzid = 0');
        execSQL;
      end
      else
      begin
        sql.Add(') as sq');
        execSQL;
      end;

      // Auto Waste
      dmADO.DelSQLTable('#Ghost');

      // take the AutoWaste records for the period from stkPCwaste and place in ghost
      // express the waste in Base Units

      close;
      sql.Clear;
      sql.Add('SELECT a.hzid, a.EntityCode, (a.WValue * u.[Base Units]) as baseWaste');
      sql.Add('INTO #ghost');
      sql.Add('FROM stkPCwaste a INNER JOIN Units u ON a.Unit = u.[Unit Name]');
      sql.Add('where a.WasteDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
      sql.Add('and a.WasteDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
      sql.Add('and a.WasteFlag = ''A''');
      execSQL;

      close;
      sql.Clear;
      sql.Add('update stkCrMisc set totAWValue = sq.aw');
      sql.Add('from (');
      sql.Add('  select a.hzid, sum(a."baseWaste" * b.nomprice) as aw');
      sql.Add('  from "#Ghost" a, stkcrdiv b');
      sql.Add('  where a.hzid = b.hzid and a.entitycode = b.entitycode');
      sql.Add('   group by a.hzid having sum(a."baseWaste") <> 0) sq');
      sql.Add('where stkCrMisc.hzid = sq.hzid');
      execSQL;

      if data1.curByHZ then
      begin
        // Autowaste could be BOTH byHZ and by Site
        // if there's any waste done per site (hzid = 0) then put in the purchase hzid...
        close;
        sql.Clear;
        sql.Add('update stkCrMisc set totAWValue = stkCrMisc.totAWValue + sq.totAWValue');
        sql.Add('from (select totAWValue from stkCrMisc where hzid = 0) sq');
        sql.Add('where stkCrMisc.hzid = ' + inttostr(data1.purHZid));
        execSQL;

        // now SUM UP per hzid and add it to hzid = 0 (any waste already there will be overwritten)
        close;
        sql.Clear;
        sql.Add('update stkCrMisc set totAWValue = sq.totAWValue');
        sql.Add('from');
        sql.Add('  (select sum(a.totAWValue) as totAWValue');
        sql.Add('   from stkCrMisc a where a.hzid > 0) sq');
        sql.Add('where stkCrMisc.hzid = 0');
        execSQL;
      end;

      close;
      sql.Clear;
      if data1.curTillVarTak then
      begin
        label8.Font.Style := [fsBold];
        sql.Add('update stkCrMisc set banked = totInc + totTillVar');
      end
      else
      begin
        label8.Font.Style := [];
        sql.Add('update stkCrMisc set banked = totInc');
      end;
      sql.Add('where (totInc is not NULL)');

      if data1.curEditTak then
      begin
        sql.Add('and (banked is NULL)');
      end;

      execSQL;
    end;
  end;

  if data1.curByHZ then
  begin
    hzTabsChange(Sender);
  end
  else
  begin
    with wwqstkMisc do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT *, (totInc + tottillvar) as DeclaredPay  FROM "stkCrMisc" a');
      if data1.curByHZ then
        sql.Add('WHERE hzid = 0');

      Open;

      Edit;

    end;
  end;

  if data1.curEditTak then
    dbEditActT.Enabled := True
  else
    dbEditActT.Enabled := False;
end;

procedure Tfstkmisc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	wwqStkMisc.Close;
end;


procedure Tfstkmisc.OKBtnClick(Sender: TObject);
var
  hzCount : integer;
begin
  if wwqStkMisc.State = dsEdit then
    wwqStkMisc.Post;

  // if this is by HZ make sure to update the Complete Site figures
  if data1.curByHZ then
  begin
    hzCount := hzTabs.PageCount - 1; // hzid = 0 not counted...

    // sum-up, place in the hzid = 0...
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set banked = sq.banked, miscBal1 = sq.miscBal1,');
      sql.Add(' miscBal2 = sq.miscBal2, miscBal3 = sq.miscBal3');
      sql.Add('from');
      sql.Add('  (select sum(banked) as banked, sum(miscBal1) as miscBal1,');
      sql.Add('     sum(miscBal2) as miscBal2, sum(miscBal3) as miscBal3');
      sql.Add('   from  stkCrMisc where hzid > 0) sq');
      sql.Add('where stkCrMisc.hzid = 0');
      execSQL;

      // the Site Wide reasons will be set to NULL is not ALL hzids have the same reason.
      // they will be set to the reasons of the hzs if they are all identical
      close;
      sql.Clear;
      sql.Add('update stkcrmisc set miscbalreason1 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason1 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason1, count(miscbalreason1) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason1) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      sql.Add(' ');
      sql.Add('update stkcrmisc set miscbalreason2 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason2 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason2, count(miscbalreason2) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason2) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      sql.Add(' ');
      sql.Add('update stkcrmisc set miscbalreason3 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason3 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason3, count(miscbalreason3) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason3) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      execSQL;
    end;
  end; // if by HZ...

  with dmADO.adoqRun do
  begin

    // if the number of HZs has changed since this stock was last calculated update will not work
    // so do a delete and then an insert
    if data1.curByHz then
    begin
      close;
      sql.Clear;
      sql.Add('delete stkMisc            ');
      sql.Add('WHERE StockCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      sql.Add('             ');
      sql.Add('insert stkMisc ([SiteCode], [Tid], [StockCode], [HzID], [MiscBalReason1], ');
      sql.Add('    [MiscBal1], [MiscBalReason2], [MiscBal2], [MiscBalReason3], [MiscBal3], ');
      sql.Add('    [SiteManager], [StockTaker], [Banked], [ReportHeader], [StockTypeShort],');
      sql.Add('    [StockNote], [TotOpCost], [TotPurch], [TotMoveCost], [TotCloseCost],    ');
      sql.Add('    [TotInc], [TotNetInc], [TotCostVar], [TotProfVar], [TotSPCost],         ');
      sql.Add('    [TotConsVal], [TotLGW], [TotRcpVar], [TotAWvalue], [Per], [LMDT],       ');
      sql.Add('    [extraInc], [TotTillVar], [HzName], [HzPurch], [HzSales])                ');
      sql.Add('select [SiteCode], [Tid], [StockCode], [HzID], [MiscBalReason1],');
      sql.Add('    [MiscBal1], [MiscBalReason2], [MiscBal2], [MiscBalReason3], [MiscBal3], ');
      sql.Add('    [SiteManager], [StockTaker], [Banked], [ReportHeader], [StockTypeShort],');
      sql.Add('    [StockNote], [TotOpCost], [TotPurch], [TotMoveCost], [TotCloseCost],    ');
      sql.Add('    [TotInc], [TotNetInc], [TotCostVar], [TotProfVar], [TotSPCost],         ');
      sql.Add('    [TotConsVal], [TotLGW], [TotRcpVar], [TotAWvalue], [Per], [LMDT],       ');
      sql.Add('    [extraInc], [TotTillVar], [HzName], [HzPurch], [HzSales]                ');
      sql.Add('from stkCrMisc   ');
      execSQL;
    end
    else
    begin
      close;
      sql.Clear;
      sql.Add('update stkMisc set ');
      sql.Add('  [MiscBalReason1] = sq.[MiscBalReason1], [MiscBal1] = sq.[MiscBal1],');
      sql.Add('  [MiscBalReason2] = sq.[MiscBalReason2], [MiscBal2] = sq.[MiscBal2],');
      sql.Add('  [MiscBalReason3] = sq.[MiscBalReason3], [MiscBal3] = sq.[MiscBal3],');
      sql.Add('  [Banked] = sq.[Banked], [TotInc] = sq.[TotInc], [TotTillVar]= sq.[TotTillVar],');
      sql.Add('  [TotNetInc] = sq.[TotNetInc], [TotAWvalue]= sq.[TotAWvalue], StockNote = sq.StockNote');
      sql.Add('from');
      sql.Add('  (select * from stkCrMisc) sq');
      sql.Add('WHERE stkMisc.StockCode = '+IntToStr(data1.StkCode));
      sql.Add('and stkMisc.tid = '+IntToStr(data1.curtid));
      sql.Add('and stkMisc.hzid = sq.hzid');
      execSQL;
    end;
  end;
end;

procedure Tfstkmisc.CancelBtnClick(Sender: TObject);
begin
	wwqStkMisc.Cancel;
end;

procedure Tfstkmisc.DBStkMemoDblClick(Sender: TObject);
begin
  DBStkMemo.Field.AsString := DBStkMemo.Text;
  memodlg.Caption := data1.SSbig + ' Note (WYSIWYG; you can use Enter and/or Tab for formatting):';
  memodlg.Execute;
end;

procedure Tfstkmisc.FormCreate(Sender: TObject);
var
  h1 : smallint;
  NewTab : TTabSheet;
begin
  if data1.curByHZ then
  begin
    // use the HZtabs but first make them up...
    self.HelpContext := 1044;

    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select hzid, hzname, epur, eSales from stkHZs where Active = 1 order by hzid');
      open;
      h1 := 1;
      while not eof do
      begin
        NewTab := TTabSheet.Create(hzTabs);
        NewTab.PageControl := hzTabs;
        newTab.Tag := FieldByName('hzid').asinteger;
        newTab.PageIndex := h1;
        newTab.Caption := FieldByName('hzname').asstring;
        newTab.ImageIndex := -1;

        if FieldByName('esales').asboolean then
        begin
          if FieldByName('epur').asboolean then
            newTab.ImageIndex := 2
          else
            newTab.ImageIndex := 0
        end
        else
        begin
          if FieldByName('epur').asboolean then
            newTab.ImageIndex := 1;
        end;

        next;
        inc(h1);
      end;

      close;
    end;

    hzTabs.Visible := True;
    hzTabs.ActivePageIndex := 1;
  end
  else
  begin
    // DO NOT show the HZtabs...
    self.HelpContext := 1012;
    hzTabs.ActivePageIndex := 0;
    hzTabs.Visible := False;

    self.ClientHeight := 444;

    if data1.noTillsOnSite then
    begin
      pnlNoTills.Visible := TRUE;
      pnlNoTills.Height := label3.Top - 2;
    end
    else
    begin
      pnlNoTills.Visible := FALSE;
    end;
  end;

  if not data1.UserAllowed(data1.curtid, 35) then //"Misc Allowances" permission
  begin
    PanelMiddle.visible := False;
    ClientHeight := ClientHeight - PanelMiddle.Height;
  end;
end;

procedure Tfstkmisc.hzTabsChange(Sender: TObject);
var
  hzCount : integer;
begin
  if wwqStkMisc.State = dsEdit then
    wwqStkMisc.Post;

  if hzTabs.ActivePage.Tag = 0 then
  begin // make read only, show label not buttons...
    hzCount := hzTabs.PageCount - 1; // hzid = 0 not counted...

    // sum-up, place in the hzid = 0...
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set banked = sq.banked, miscBal1 = sq.miscBal1,');
      sql.Add(' miscBal2 = sq.miscBal2, miscBal3 = sq.miscBal3');
      sql.Add('from');
      sql.Add('  (select sum(banked) as banked, sum(miscBal1) as miscBal1,');
      sql.Add('     sum(miscBal2) as miscBal2, sum(miscBal3) as miscBal3');
      sql.Add('   from  stkCrMisc where hzid > 0) sq');
      sql.Add('where stkCrMisc.hzid = 0');
      execSQL;

      // the Site Wide reasons will be set to NULL is not ALL hzids have the same reason.
      // they will be set to the reasons of the hzs if they are all identical
      close;
      sql.Clear;
      sql.Add('update stkcrmisc set miscbalreason1 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason1 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason1, count(miscbalreason1) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason1) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      sql.Add(' ');
      sql.Add('update stkcrmisc set miscbalreason2 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason2 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason2, count(miscbalreason2) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason2) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      sql.Add(' ');
      sql.Add('update stkcrmisc set miscbalreason3 = CASE');
      sql.Add('  WHEN sq.thecount = ' + inttostr(hzCount));
      sql.Add('  THEN sq.miscbalreason3 ELSE NULL END');
      sql.Add('from');
      sql.Add('  (select TOP 1 miscbalreason3, count(miscbalreason3) as thecount');
      sql.Add('  from stkcrmisc where hzid > 0 group by miscbalreason3) sq');
      sql.Add('where stkcrmisc.hzid = 0');
      execSQL;
    end;

    with wwqstkMisc do
    begin
      if State = dsEdit then
        Post;
      DisableControls;

      close;
      sql.Clear;
      sql.Add('SELECT *, (totInc + tottillvar) as DeclaredPay  FROM "stkCrMisc" a');
      if data1.curByHZ then
        sql.Add('WHERE hzid = ' + inttostr(hzTabs.ActivePage.Tag));

      Open;

      EnableControls;
      requery;
      Edit;
    end;


    dbEditActT.Visible := True;
    dbEditActT.Font.Style := [fsBold];
    dbEditActT.ReadOnly := True;
    dbEditA1.ReadOnly := True;
    dbEditA2.ReadOnly := True;
    dbEditA3.ReadOnly := True;
    dbEditr1.ReadOnly := True;
    dbEditr2.ReadOnly := True;
    dbEditr3.ReadOnly := True;

    dbEditActT.color := clBlue;
    dbEditA1.color := clBlue;
    dbEditA2.color := clBlue;
    dbEditA3.color := clBlue;
    dbEditr1.color := clBlue;
    dbEditr2.color := clBlue;
    dbEditr3.color := clBlue;

    dbEditActT.Font.Color := clWhite;
    dbEditA1.Font.Color := clWhite;
    dbEditA2.Font.Color := clWhite;
    dbEditA3.Font.Color := clWhite;
    dbEditr1.Font.Color := clWhite;
    dbEditr2.Font.Color := clWhite;
    dbEditr3.Font.Color := clWhite;

    labWholeSite.Visible := True;
    labNoSales.Visible := False;

  end
  else
  begin
    with wwqstkMisc do
    begin
      if State = dsEdit then
        Post;
      DisableControls;

      close;
      sql.Clear;
      sql.Add('SELECT *, (totInc + tottillvar) as DeclaredPay  FROM "stkCrMisc" a');
      if data1.curByHZ then
        sql.Add('WHERE hzid = ' + inttostr(hzTabs.ActivePage.Tag));

      Open;

      EnableControls;
      requery;
      Edit;
    end;

    dbEditActT.Font.Style := [];
    dbEditActT.Visible := (hzTabs.ActivePage.ImageIndex = 0) or (hzTabs.ActivePage.ImageIndex = 2);
    labNoSales.Visible := not ((hzTabs.ActivePage.ImageIndex = 0) or (hzTabs.ActivePage.ImageIndex = 2));

    labWholeSite.Visible := False;

    dbEditActT.ReadOnly := False;
    dbEditA1.ReadOnly := False;
    dbEditA2.ReadOnly := False;
    dbEditA3.ReadOnly := False;
    dbEditr1.ReadOnly := False;
    dbEditr2.ReadOnly := False;
    dbEditr3.ReadOnly := False;

    dbEditActT.color := clWhite;
    dbEditA1.color := clWhite;
    dbEditA2.color := clWhite;
    dbEditA3.color := clWhite;
    dbEditr1.color := clWhite;
    dbEditr2.color := clWhite;
    dbEditr3.color := clWhite;

    dbEditActT.Font.Color := clBlack;
    dbEditA1.Font.Color := clBlack;
    dbEditA2.Font.Color := clBlack;
    dbEditA3.Font.Color := clBlack;
    dbEditr1.Font.Color := clBlack;
    dbEditr2.Font.Color := clBlack;
    dbEditr3.Font.Color := clBlack;
  end;

end;

end.



