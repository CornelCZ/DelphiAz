unit uReps1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ppCtrls, Printers;

type
  TfReps1 = class(TForm)
    SPBtn: TBitBtn;
    GroupBox1: TGroupBox;
    RetSumBtn: TBitBtn;
    TrSumBtn: TBitBtn;
    CloseBtn: TBitBtn;
    btnLossGain: TBitBtn;
    rbCost: TRadioButton;
    rbPrice: TRadioButton;
    rbBoth: TRadioButton;
    cbSPprof: TRadioButton;
    RadioButton1: TRadioButton;
    Bevel2: TBevel;
    GroupBox2: TGroupBox;
    HoldBtn: TBitBtn;
    rbHoldPo: TRadioButton;
    rbHold1: TRadioButton;
    rbHold2: TRadioButton;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    rgInv: TRadioGroup;
    Panel2: TPanel;
    hzTabs: TPageControl;
    hzTab0: TTabSheet;
    Bevel3: TGroupBox;
    rbHZsummary: TRadioButton;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    rbSite: TRadioButton;
    rbProds: TRadioButton;
    cbDetail: TCheckBox;
    procedure HoldBtnClick(Sender: TObject);
    procedure SPBtnClick(Sender: TObject);
    procedure TrSumBtnClick(Sender: TObject);
    procedure btnLossGainClick(Sender: TObject);
    procedure RetSumBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure hzTabsChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
  private
    { Private declarations }
    execRes : integer;
  public
    { Public declarations }
    doTheo : boolean;
    repHZid, repHZpurch : smallint;
    repHZidStr, repHZName : string;
    function TheoRepCalc: boolean;
    procedure Collapse(var Msg: TMsg); message WM_USER + 3646;


end;


var
  fReps1: TfReps1;

implementation

uses udata1, uRepHold, uRepSP, uRepTrad, //uCurrdlg,uSetNom,uDataProc,
  uwait, uADO, ulog, uDataProc, uGlobals;

{$R *.DFM}

{Used to minimise the whole app if the current form is minimised}
procedure TfReps1.WMSysCommand;
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

procedure TfReps1.HoldBtnClick(Sender: TObject);
var
  acc, current : real;
begin
  try
    data1.ERRSTR1 := 'Create Report Form';
    fRepHold := TfRepHold.Create(Self);
    fRepHold.wwqRun.Close;

    data1.ERRSTR1 := 'Gather Main Data';
    data1.HoldRepQuery(repHZidStr, fRepHold.wwqRun);

    fRepHold.wwqRun.Open;

    if fRepHold.wwqRun.RecordCount = 0 then
    begin
      showmessage('No ' + data1.SSsmall + ' movement detected. Nothing to report.');
    end
    else
    begin
      with dmADO.adoqRun do
      begin
        data1.ERRSTR1 := 'Check for Ingr. with no Parents sold';
        close;
        sql.Clear;
        sql.Add('select count(entitycode) as orphans from StkCrDiv where TheoPrice = -99999');
        open;

        if FieldByName('orphans').asinteger > 0 then
        begin
          fRepHold.pplabel103.Visible := True;
          fRepHold.pplabel103.caption := '* Ing NS: ' + FieldByName('orphans').asstring +
            ' Ingredients which are not part of any Item Sold in the current period (No Theoretical Reduction/Nominal Price/Consumption Value)';
          fRepHold.pplabel109.caption := '* Ing NS: ' + FieldByName('orphans').asstring +
            ' Ingredients which are not part of any Item Sold in the current period (No Consumption Value)';
        end
        else
        begin
          fRepHold.pplabel103.Visible := False;
        end;

        close;
        fRepHold.pplabel109.Visible := fRepHold.pplabel103.Visible;
        fRepHold.pplabel131.Visible := fRepHold.pplabel103.Visible;
        fRepHold.pplabel131.Caption := fRepHold.pplabel103.caption;

        if rbHold1.Checked then
        begin
          // prepare for Prepared Items' ingredients list
          data1.ERRSTR1 := 'Data for Prep Items 1';
          dmADO.DelSQLTable('PreparedReportTMP');
          dmADO.DelSQLTable('PrepWasteReportTMP');

          close;
          sql.Clear;
          sql.Add('select p.[PreparedItem], p.[Ingredient], (p.[OpenSplit] / e.PurchBaseU) as OpenSplit, ');
          sql.Add('(p.[CloseSplit] / e.PurchBaseU) as CloseSplit, (p.[Adjustment] / e.PurchBaseU) as Adj,');
          sql.Add(' (0 * p.[Adjustment] / e.PurchBaseU) as WasteSplit,');
          sql.Add('e.PurchaseName as IngName, e.PurchaseUnit as IngUnit, e.PurchaseName as PrepName,');
          sql.Add('((s.OpCost * p.[OpenSplit]) - (s.ActCloseCost * p.[CloseSplit])) as CostAdj,');
          sql.Add('(s.NomPrice * p.[Adjustment]) as PriceAdj, (s.ActCloseCost * p.[CloseSplit]) as CloseCost,');
          sql.Add('CASE WHEN p.BatchSize < -776 THEN p.BatchSize ELSE 0 END as ChangeFlag');
          sql.Add('INTO dbo.PreparedReportTMP');
          sql.Add('FROM [#PreparedItemSplit] p, stkEntity e, stkCrDiv s');
          sql.Add('where p.hzid = ' + repHzIDstr + ' and s.hzid = p.hzid');
          sql.Add('and p.[Ingredient] = e.entitycode and p.[Ingredient] = s.entitycode');
          execSQL;

          // bring the Wastage Split from stkPCWaste
          data1.ERRSTR1 := 'Data for Prep Items 2';
          close;
          sql.Clear;
          sql.Add('select p.[Parent], p.[EntityCode], SUM(p.WValue * p.BaseUnits) as TotWasteBU');
          sql.Add('INTO dbo.PrepWasteReportTMP');
          sql.Add('FROM [stkPCWaste] p');
          sql.Add('where p.hzid = ' + repHzIDstr + ' and p.WasteFlag = ''C'' and p.Deleted = 0');
          sql.Add('and p.WasteDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
          sql.Add('and p.WasteDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
          sql.Add('Group By p.[Parent], p.[EntityCode]');
          execSQL;

          data1.ERRSTR1 := 'Data for Prep Items 3';
          close;
          sql.Clear;
          sql.Add('Update dbo.PreparedReportTMP set WasteSplit = sq.TotWaste ');
          sql.Add('FROM ');
          sql.Add(' ');
          sql.Add(' (select p.[Parent], p.[EntityCode], (p.TotWasteBU / e.PurchBaseU) as TotWaste, ');
          sql.Add('  e.PurchaseName as IngName, e.PurchaseUnit as IngUnit');
          sql.Add('  FROM dbo.PrepWasteReportTMP p, stkEntity e');
          sql.Add('  where p.[EntityCode] = e.entitycode) sq');
          sql.Add('where dbo.PreparedReportTMP.PreparedItem = sq.Parent');
          sql.Add('and dbo.PreparedReportTMP.Ingredient = sq.EntityCode');
          execSQL;

          // could there be wastage reduction withour PrepItemSplit? Maybe, so deal with it...
          data1.ERRSTR1 := 'Data for Prep Items 4';
          close;
          sql.Clear;
          sql.Add('INSERT dbo.PreparedReportTMP ([PreparedItem], [Ingredient], [OpenSplit], [CloseSplit], [Adj], ');
          sql.Add('           [WasteSplit], [IngName], [IngUnit], [PrepName], [CostAdj], [PriceAdj], [CloseCost] ) ');
          sql.Add('SELECT sq.Parent, sq.EntityCode, 0, 0, 0, sq.TotWaste,  ');
          sql.Add('           sq.[IngName], sq.[IngUnit], '''', 0, 0, 0 ');
          sql.Add(' FROM');
          sql.Add('  (select p.[Parent], p.[EntityCode], (p.TotWasteBU / e.PurchBaseU) as TotWaste, ');
          sql.Add('   e.PurchaseName as IngName, e.PurchaseUnit as IngUnit');
          sql.Add('   FROM dbo.PrepWasteReportTMP p, stkEntity e');
          sql.Add('   where p.[EntityCode] = e.entitycode) sq');
          sql.Add(' LEFT OUTER JOIN dbo.PreparedReportTMP pt');
          sql.Add('  ON pt.PreparedItem = sq.Parent and pt.Ingredient = sq.EntityCode');
          sql.Add('WHERE pt.Ingredient IS NULL and pt.PreparedItem IS NULL');
          execSQL;

          data1.ERRSTR1 := 'Data for Prep Items 5';
          if NOT dmADO.IsEmptyTable('PreparedReportTMP') then
          begin
            // bring in Prepared Item names
            close;
            sql.Clear;
            sql.Add('update PreparedReportTMP set PrepName = sq.PurchaseName');
            sql.Add('from ');
            sql.Add('   (select p.[PreparedItem], e.PurchaseName FROM [#PreparedItemSplit] p, stkEntity e');
            sql.Add('    where p.[PreparedItem] = e.entitycode) sq');
            sql.Add('where PreparedReportTMP.[PreparedItem] = sq.[PreparedItem]');
            execSQL;

            // include ALL in field prepared items at least once
            close;
            sql.Clear;
            sql.Add('insert PreparedReportTMP (PreparedItem) select entitycode from stkcrdiv');
            sql.Add('where entitycode not in (select preparedItem from PreparedReportTMP)');
            execSQL;

            // include ALL in field ingredients at least once
            close;
            sql.Clear;
            sql.Add('insert PreparedReportTMP (Ingredient) select entitycode from stkcrdiv');
            sql.Add('where entitycode not in (select ingredient from PreparedReportTMP where ingredient is not NULL)');
            execSQL;

            data1.ERRSTR1 := 'Data for Prep Items 6';
            fRepHold.adoqIngredients.Open;
            fRepHold.adoqParents.Open;

            fRepHold.ppSubReport2.Visible := True;
            fRepHold.ppSubReport6.Visible := True;
          end
          else
          begin
            fRepHold.ppSubReport2.Visible := False;
            fRepHold.ppSubReport6.Visible := False;

            fRepHold.ppsubreport2.DataPipeline := nil;
            fRepHold.ppsubreport6.DataPipeline := nil;

            showmessage('No Prepared Items Breakdown ' + data1.SSsmall + ' movement detected. Nothing to report.');
            fRepHold.wwqRun.Close;
            fRepHold.adoqPurSlv.close;
            fRepHold.adoqIngredients.Close;
            fRepHold.adoqParents.Close;
            fRepHold.Free;
            exit;
          end;
        end
        else
        begin
          fRepHold.ppSubReport2.Visible := False;
          fRepHold.ppSubReport6.Visible := False;

          fRepHold.ppsubreport2.DataPipeline := nil;
          fRepHold.ppsubreport6.DataPipeline := nil;
        end;
      end;

      if (uGlobals.isSite) then
      begin
        if repHZid = 0 then // site wide show the purch sub-report with cost breakdown
        begin
          data1.ERRSTR1 := 'Data for Purch 1';
          fRepHold.ppSubReport3.Visible := True;
          fRepHold.ppSubReport4.Visible := True;

          fRepHold.ppSubReport5.Visible := False;
          fRepHold.ppSubReport7.Visible := False;
          fRepHold.ppsubreport5.DataPipeline := nil;
          fRepHold.ppsubreport7.DataPipeline := nil;

          fRepHold.ppLabel349.Visible := False;
          fRepHold.ppLabel350.Visible := False;
          fRepHold.ppLabel351.Visible := False;
          // get the purchase sub report data
          with dmADO.adoqRun do
          begin
            dmADO.DelSQLTable('stkPurAllghost');

            close;
            sql.Clear;
            sql.Add('select IDENTITY(int, 1,1) AS RecID, *, baseqty as acc into dbo.stkPurAllghost from stkpurAll order by entitycode, date, supp, invno');
            execSQL;

            // now make up accumulator...
            close;
            sql.Clear;
            sql.Add('select * from stkpurallghost');
            open;
            first;

            current := FieldByName('entitycode').AsFloat;
            acc := FieldByName('baseqty').AsFloat;
            next;

            data1.ERRSTR1 := 'Data for Purch 2';
            while not eof do
            begin
              if current = FieldByName('entitycode').AsFloat then
              begin // accumulate qty
                acc := acc + FieldByName('baseqty').AsFloat;
                edit;
                FieldByName('acc').asfloat := acc;
                post;
              end
              else
              begin
                current := FieldByName('entitycode').AsFloat;
                acc := FieldByName('baseqty').AsFloat;
              end;

              next;
            end;

            close;

            // add items from stkCrDiv not present here (because they have no purchases)...
            data1.ERRSTR1 := 'Data for Purch 3';
            close;
            sql.Clear;
            sql.Add('INSERT stkPurAllGhost (sitecode, entitycode, unitcost, quantity,');
            sql.Add('       cvalue, baseqty, baseunits, acc)');
            sql.Add('select '+ inttostr(data1.repsite) + ', b.entitycode, 0,0,0,0,0,0');
            sql.Add('FROM "StkCrDiv" b');
            sql.Add('WHERE b."entitycode" not in (select distinct entitycode from stkPurAllGhost)');
            sql.Add('and ((b."OpStk" <> 0) or (b."PurchStk" <> 0) or (b."actCloseStk" <> 0) or');
            sql.Add('  ((b."soldQty" <> 0) and (b."key2" < 1000)) or (b."Wastage" <> 0) or');
            sql.Add('   (b."PrepRedQty" <> 0) or b.purchcost <> 0)');
            execSQL;

          end;
          data1.ERRSTR1 := 'Data for Purch 4';
          fRepHold.adoqPurSlv.open;
        end
        else
        begin
          data1.ERRSTR1 := 'Data for Purch 5';
          fRepHold.ppLabel349.Visible := True;
          fRepHold.ppLabel350.Visible := True;
          fRepHold.ppLabel351.Visible := True;
          fRepHold.ppLabel349.Caption := 'For Holding Zone: ' + repHZname;
          fRepHold.ppLabel350.Caption := 'For Holding Zone: ' + repHZname;
          fRepHold.ppLabel351.Caption := 'For Holding Zone: ' + repHZname;

          fRepHold.ppSubReport3.Visible := False;
          fRepHold.ppSubReport4.Visible := False;
          fRepHold.ppsubreport3.DataPipeline := nil;
          fRepHold.ppsubreport4.DataPipeline := nil;

          fRepHold.ppSubReport5.Visible := True;
          fRepHold.ppSubReport7.Visible := True;
          fRepHold.ppSubReport5.DrillDownComponent := fRepHold.ppShape22;
          fRepHold.ppSubReport7.DrillDownComponent := fRepHold.ppShape24;
          // now prepare for move subreport...
          with dmADO.adoqRun do
          begin
            dmADO.DelSQLTable('stkHZMPRep');

            close;
            sql.Clear;
            sql.Add('select CONVERT(DateTime, CONVERT(VarChar, [MoveDT], 1)) AS [JustDate], b.MoveDT,');
            sql.Add('(''Transfers'') as SubGroup, (''OUT'') as MoveType, (c.hzName) as SuppToFrom,');
            sql.Add('CAST(a.[MoveID] AS varchar(15)) as InvNoMoveID, a.[RecID], a.[EntityCode],');
            sql.Add('(-1 * a.[Qty] / a.[BaseU]) as Qty, a.[MoveU] as theUnit');
            sql.Add('into dbo.stkHZMPRep');
            sql.Add('from stkHZMprods a, stkHZMoves b, stkHZs c');
            sql.Add('where b.hzidSource = ' + repHZidStr);
            sql.Add('and a.sitecode = b.sitecode and a.moveid = b.moveid');
            sql.Add('and a.entitycode in (select entitycode from stkcrdiv)');
            sql.Add('and b.sitecode = c.sitecode and b.hzidDest = c.hzid');
            sql.Add('and b.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
            sql.Add('and b.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
            sql.Add('UNION');
            sql.Add('select CONVERT(DateTime, CONVERT(VarChar, [MoveDT], 1)) AS [JustDate], b.MoveDT,');
            sql.Add('(''Transfers'') as SubGroup, (''IN'') as MoveType, (c.hzName) as SuppToFrom,');
            sql.Add('CAST(a.[MoveID] AS varchar(15)) as InvNoMoveID, a.[RecID], a.[EntityCode],');
            sql.Add('(a.[Qty] / a.[BaseU]) as Qty, a.[MoveU] as theUnit');
            sql.Add('from stkHZMprods a, stkHZMoves b, stkHZs c');
            sql.Add('where b.hzidDest = ' + repHZidStr);
            sql.Add('and a.sitecode = b.sitecode and a.moveid = b.moveid');
            sql.Add('and a.entitycode in (select entitycode from stkcrdiv)');
            sql.Add('and b.sitecode = c.sitecode and b.hzidSource = c.hzid');
            sql.Add('and b.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
            sql.Add('and b.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
            if repHZid = data1.purHZid then
            begin
              sql.Add('UNION');
              sql.Add('select a.[date], NULL, (''Purchases'') as SubGroup, (''PURCH'') as MoveType, a.[supp], a.[invno],');
              sql.Add('(0) , a.[entitycode], a.[quantity], a.[purchunit]');
              sql.Add('from stkPurAll a');
            end;
            execSQL;

            // add items from stkCrDiv not present here (because they have no moves or purchases)...
            data1.ERRSTR1 := 'Data for Purch 6';
            close;
            sql.Clear;
            sql.Add('INSERT stkHZMPRep ([SubGroup], [MoveType],[RecID], [EntityCode], [Qty])');
            sql.Add('select '''', '''',0, b.entitycode, 0');
            sql.Add('FROM "StkCrDiv" b');
            sql.Add('WHERE b."entitycode" not in (select distinct entitycode from stkHZMPRep)');
            sql.Add('and ((b."OpStk" <> 0) or (b."PurchStk" <> 0) or (b."actCloseStk" <> 0) or');
            sql.Add('  ((b."soldQty" <> 0) and (b."key2" < 1000)) or (b."Wastage" <> 0) or');
            sql.Add('   (b."PrepRedQty" <> 0) or (b.purchcost <> 0) or (b."MoveQty" <> 0))');
            sql.Add('and b.hzid = ' + repHZidStr);
            execSQL;

          end;
          data1.ERRSTR1 := 'Data for Purch 7';
          fRepHold.adoqMoveSlv.open;
        end;
      end
      else
      begin
        fRepHold.ppsubreport3.Visible := false;
        fRepHold.ppsubreport4.Visible := false;
        fRepHold.ppsubreport5.Visible := false;
        fRepHold.ppSubReport7.Visible := False;
        fRepHold.ppsubreport3.DataPipeline := nil;
        fRepHold.ppsubreport4.DataPipeline := nil;
        fRepHold.ppsubreport5.DataPipeline := nil;
        fRepHold.ppsubreport7.DataPipeline := nil;
      end;

      data1.ERRSTR1 := 'Set Global Labels';
      if data1.curIsGP then
      begin
        fRepHold.ppLabel24.Caption := 'Expected GP %';
        fRepHold.ppHoldRepLabel23.Caption := 'Expec. GP %';
        fRepHold.ppLabel144.Caption := 'Expect GP %';
      end
      else
      begin
        fRepHold.ppLabel24.Caption := 'Expected COS %';
        fRepHold.ppHoldRepLabel23.Caption := 'Expec. COS %';
        fRepHold.ppLabel144.Caption := 'Expect COS %';
      end;

      fRepHold.doTheo := (self.Caption = 'Reports Menu - UN-AUDITED ' + data1.SSbig);

      if data1.noTillsOnSite then
      begin
        fRepHold.ppLabel349.Visible := True;
        fRepHold.ppLabel350.Visible := True;
        fRepHold.ppLabel351.Visible := True;
        fRepHold.ppLabel349.Caption := 'No Terminals on this Site';
        fRepHold.ppLabel350.Caption := 'No Terminals on this Site';
        fRepHold.ppLabel351.Caption := 'No Terminals on this Site';
      end;

      data1.ERRSTR1 := 'View/Print Report';
      if rbHoldPo.Checked then
      begin
        fRepHold.ppHoldRep.Print;
      end
      else if rbHold1.Checked then
        fRepHold.ppHoldRepBig.Print
      else // the Yield version must be checked...
        fRepHold.ppHoldRep2.Print;
    end;

    data1.ERRSTR1 := 'Close all queries';
    fRepHold.wwqRun.Close;
    fRepHold.adoqPurSlv.close;
    fRepHold.adoqIngredients.Close;
    fRepHold.adoqParents.Close;
    fRepHold.Free;

  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Holding Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Holding Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.SPBtnClick(Sender: TObject);
begin
  try
    data1.ERRSTR1 := 'Gather Main Retail Data';
    if data1.SPQuery(repHZidStr) = 0 then
    begin
      showmessage('No stockable products have been sold. Nothing to report.');
    end
    else
    begin
      data1.ERRSTR1 := 'Create Sales & Prof Report Form';
      fRepSP := TfRepSP.Create(Self);
      fRepSP.spSlave := False;

      if cbDetail.Checked then
      begin
        data1.ERRSTR1 := 'Gather Sub-Report Retail Data';
        dmADO.DelSQLTable('#spSlave');

        with dmADO.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('CREATE TABLE [#spSlave] ([HzID] [smallint] NULL, [EntityCode] [float] NULL,');
          sql.Add('	[Portion] [smallint] NULL, [Choice] [varchar] (240) NULL, [ProductType] [varchar] (2) NULL,');
          sql.Add('	[SalesQty] [float] NULL, [Income] [float] NULL, [AvSalesPrice] [float] NULL,');
          sql.Add('	[TheoCost] [float] NULL, [ActCost] [float] NULL, [VATRate] [float] NULL,');
          sql.Add(' [Memo1] [varchar] (1140) NULL)');
          execSQL;

          data1.ERRSTR1 := 'Exec Retail Stored Procedure';
          close;
          sql.Clear;
          sql.Add('exec stkSP_RepSPDetail ' + repHZidStr +
                ', ' + intToStr(data1.repSite) + ', ' + intToStr(data1.CurTid)
                 + ', ' + intToStr(data1.StkCode));
          try
            execSQL;
          except
            on E:exception do
            begin
              log.event('ERROR executing stkSP_RepSPDetail. Message: ' + E.Message);
            end;
          end;

          data1.ERRSTR1 := 'Gather Sub-Report Retail Data 2';
          close;
          sql.Clear;
          sql.Add('update [#sp] SET choices = sq.ch');
          sql.Add('from (select entitycode, portion, count(*) as ch from [#spSlave]');
          sql.Add('      group by entitycode, portion) sq');
          sql.Add('where [#sp].entitycode = sq.entitycode and [#sp].portion = sq.portion');
          if execSQL > 0 then
            fRepSP.spSlave := True;
        end;
      end;

      data1.ERRSTR1 := 'Set Main Sales & Prof Query';
      fRepSP.wwqRun.close;
      fRepSP.wwqRun.sql.Clear;
      fRepSP.wwqRun.sql.Add('select * from [#sp] order by SubCatName, RetailName, producttype');
      fRepSP.wwqRun.Open;

      if fRepSP.spSlave then
      begin
        data1.ERRSTR1 := 'Set Sales & Prof Sub-Report Query';
        fRepSP.ppSPslave.Visible := True;

        if data1.curIsGP then
        begin
          fRepSP.adoqSPSlave.sql[1] := '(CASE WHEN income = 0 then 0' +
                     '  ELSE (1- (TheoCost * salesqty / (Income - vatRate))) * 100 END) as ThGpP,';
          fRepSP.adoqSPSlave.sql[2] := '(CASE WHEN income = 0 then 0' +
                     '  ELSE (1- (ActCost * salesqty / (Income - vatRate))) * 100 END) as ActGpP,';
        end
        else
        begin
          fRepSP.adoqSPSlave.sql[1] := '(CASE WHEN income = 0 then 0' +
                     '  ELSE (TheoCost * salesqty / (Income - vatRate)) * 100 END) as ThGpP,';
          fRepSP.adoqSPSlave.sql[2] := '(CASE WHEN income = 0 then 0' +
                     '  ELSE (ActCost * salesqty / (Income - vatRate)) * 100 END) as ActGpP,';
        end;

        fRepSP.adoqSPSlave.sql[4] := 'from [#spSlave]';
        fRepSP.adoqSPSlave.Open;
      end
      else
      begin
        fRepSP.ppSPslave.Visible := False;
        fRepSP.ppSPslave.DataPipeline := nil;
      end;

      data1.ERRSTR1 := 'Set Sales & Prof Labels 1';
      fRepSP.ppShape19.Visible := fRepSP.ppSPslave.Visible;

      fRepSP.ppLabel349.Caption := 'For Holding Zone: ' + repHZname;
      fRepSP.ppLabel349.Visible := (repHZid <> 0);
      fRepSP.doTheo := (self.Caption = 'Reports Menu - UN-AUDITED ' + data1.SSbig);

      if data1.curIsGP then
      begin
        fRepSP.ppS_PrepLabel7.Caption := 'Target GP%';
        fRepSP.ppS_PrepLabel8.Caption := 'Actual GP%';
      end
      else
      begin
        fRepSP.ppS_PrepLabel7.Caption := 'Target COS%';
        fRepSP.ppS_PrepLabel8.Caption := 'Actual COS%';
      end;

      data1.ERRSTR1 := 'Set Sales & Prof Labels 2';
      fRepSP.wwqOrphan.close;
      fRepSP.wwqOrphan.sql.Clear;
      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        fRepSP.wwqOrphan.sql.Add('SELECT (a."SCat") as rephdr, ')
      else
        fRepSP.wwqOrphan.sql.Add('SELECT (a."Cat") as rephdr,');
      fRepSP.wwqOrphan.sql.Add('a."PurchaseName", b."salesqty", b."actCost", a."entitycode",');
      fRepSP.wwqOrphan.sql.Add('(- b."ActCost" * b."salesqty") as GrossProf, a."purchaseunit",');
      fRepSP.wwqOrphan.sql.Add('(b."ActCost" * b."salesqty") as ActVal, (1) as grp');
      fRepSP.wwqOrphan.sql.Add('FROM stkEntity a, "StkCrSld" b');
      fRepSP.wwqOrphan.sql.Add('WHERE a."entitycode" = b."entitycode" and (b."producttype" = ''Z'')');
      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        fRepSP.wwqOrphan.sql.Add('Order By grp, a."SCat", a."PurchaseName"')
      else
        fRepSP.wwqOrphan.sql.Add('Order By grp, a."Cat",a."PurchaseName"');
      fRepSP.wwqOrphan.Open;

      data1.ERRSTR1 := 'View/Print Sales & Prof Report';
      fRepSP.ppS_PRep.Print;

      data1.ERRSTR1 := 'Close all Sales & Prof Queries';
      fRepSP.wwqOrphan.Close;
      fRepSP.adoqSPSlave.Close;
      fRepSP.wwqRun.Close;

      fRepSP.Free;
    end;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Sales & Profitablity Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Sales & Prof Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.TrSumBtnClick(Sender: TObject);
begin
  try
    data1.ERRSTR1 := 'Create Trad Report Form';
    fRepTrad := TfRepTrad.Create(Self);
    fRepTrad.repHZid := repHZid;
    fRepTrad.repHZidStr := repHZidStr;
    if repHZid = 0 then
    begin
      if data1.noTillsOnSite then
      begin
        fRepTrad.ppLabel349.Visible := True;
        fRepTrad.ppLabel349.Caption := 'No Terminals on this Site';
      end
      else
      begin
        fRepTrad.ppLabel349.Visible := False;
      end;

      fRepTrad.pplabel211.Visible := True;
      fRepTrad.pplabel211.Caption := 'Cost of Purchases';
      fRepTrad.ppLabel212.Visible := False;
      fRepTrad.pplabel32.Caption := ' Purchases   Cost';
    end
    else
    begin
      fRepTrad.ppLabel349.Visible := True;
      fRepTrad.ppLabel349.Caption := 'For Holding Zone: ' + repHZname;
      if (repHZid = data1.purHZid) then
      begin
        fRepTrad.pplabel211.Visible := False;
        fRepTrad.ppLabel212.Visible := True;
        fRepTrad.pplabel32.Caption := 'Purchases & Transfers Cost';
      end
      else
      begin
        fRepTrad.pplabel211.Visible := True;
        fRepTrad.pplabel211.Caption := 'Cost of Transfers';
        fRepTrad.ppLabel212.Visible := False;
        fRepTrad.pplabel32.Caption := ' Transfers   Cost';
      end;
    end;

    if self.Caption = 'Reports Menu - UN-AUDITED ' + data1.SSbig then
      fRepTrad.audited := False
    else
      fRepTrad.audited := True;

    data1.ERRSTR1 := 'Gather Trad Report Data';
    if fRepTrad.MakeRep then
      fRepTrad.ppTrad.Print
    else
      showmessage('No ' + data1.SSsmall + ' movement detected. Nothing to report.');

    fRepTrad.Free;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Trad Summary Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Trad Summ Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.RetSumBtnClick(Sender: TObject);
begin
  try
    data1.ERRSTR1 := 'Create Retail Report Form';
    fRepTrad := TfRepTrad.Create(Self);
    fRepTrad.repHZid := repHZid;
    fRepTrad.repHZidStr := repHZidStr;
    if repHZid = 0 then
    begin
      fRepTrad.ppLabel210.Visible := False;
      fRepTrad.pplabel105.Caption := ' Purchases   Cost';
    end
    else
    begin
      fRepTrad.ppLabel210.Visible := True;
      fRepTrad.ppLabel210.Caption := 'For Holding Zone: ' + repHZname;
      if (repHZid = data1.purHZid) then
      begin
        fRepTrad.pplabel105.Caption := 'Purchases & Transfers Cost';
      end
      else
      begin
        fRepTrad.pplabel105.Caption := ' Transfers   Cost';
      end;
    end;

    if self.Caption = 'Reports Menu - UN-AUDITED ' + data1.SSbig then
      fRepTrad.audited := False
    else
      fRepTrad.audited := True;
    fRepTrad.prof := cbSPprof.Checked;

    data1.ERRSTR1 := 'Gather Retail Report Data';
    if fRepTrad.MakeRetRep then
      fRepTrad.ppRet.Print
    else
      showmessage('No stockable products have been sold. Nothing to report.');

    fRepTrad.Free;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Retail Summary Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Retail Summ Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.btnLossGainClick(Sender: TObject);
var
  AComponent: TComponent;
  noOfHZs: integer;
begin
  try
    data1.ERRSTR1 := 'Create Report Form';
    fRepHold := TfRepHold.Create(Self);

    if not rbHZsummary.Checked then // normal LG report...
    begin
      data1.ERRSTR1 := 'Gather LG Data';
      data1.LGRepQuery(repHZidStr, fRepHold.adoqLG);
      fRepHold.adoqLG.Open;

      if self.Caption = 'Reports Menu - UN-AUDITED ' + data1.SSbig then
        fRepHold.doTheo := True
      else
        fRepHold.doTheo := False;

      if fRepHold.adoqLG.RecordCount = 0 then
        showmessage('There are no Losses or Gains to report.')
      else
      begin
        data1.ERRSTR1 := 'Set LG Labels';
        if repHZid = 0 then
        begin
          if data1.noTillsOnSite then
          begin
            fRepHold.ppLabel352.Visible := True;
            fRepHold.ppLabel353.Visible := True;
            fRepHold.ppLabel352.Caption := 'No Terminals on this Site';
            fRepHold.ppLabel353.Caption := 'No Terminals on this Site';
          end
          else
          begin
            fRepHold.ppLabel352.Visible := False;
            fRepHold.ppLabel353.Visible := False;
          end;
        end
        else
        begin
          fRepHold.ppLabel352.Visible := True;
          fRepHold.ppLabel353.Visible := True;
          fRepHold.ppLabel352.Caption := 'For Holding Zone: ' + repHZname;
          fRepHold.ppLabel353.Caption := 'For Holding Zone: ' + repHZname;
        end;

        if rbBoth.Checked then
        begin
          data1.ERRSTR1 := 'View/Print LG Report (C&V)';
          fRepHold.ppLG.Print;
        end
        else
        begin
          with fRepHold do
          begin
            if rbPrice.Checked then
            begin
              data1.ERRSTR1 := 'LG Report (Val)';
              pplabel84.Text := 'Value';
              ppdbtext47.DataField := 'sv';
              ppdbtext50.DataField := 'dv';
              ppdbtext54.DataField := 'Wv';
              ppdbtext48.DataField := 'totv';
              pplabel65.Text := data1.SSbig + ' Loss/Gain Value Report';
            end
            else
            begin
              data1.ERRSTR1 := 'LG Report (Cost)';
              pplabel84.Text := 'Cost';
              ppdbtext47.DataField := 'sc';
              ppdbtext50.DataField := 'dc';
              ppdbtext54.DataField := 'Wc';
              ppdbtext48.DataField := 'totc';
              pplabel65.Text := data1.SSbig + ' Loss/Gain Cost Report';
            end;

            ppDBCalc9.DataField  := ppdbtext47.DataField; // Surplus Summs
            ppDBCalc16.DataField := ppdbtext47.DataField;

            ppDBCalc12.DataField := ppdbtext50.DataField; // Deficit Summs
            ppDBCalc35.DataField := ppdbtext50.DataField;

            ppDBCalc13.DataField := ppdbtext54.DataField; // Wastage Summs
            ppDBCalc37.DataField := ppdbtext54.DataField;

            ppDBCalc17.DataField := ppdbtext48.DataField; // Total Summs
            ppDBCalc18.DataField := ppdbtext48.DataField;

            pplabel93.Text := pplabel84.Text;
            pplabel88.Text := pplabel84.Text;
            pplabel85.Text := 'Total ' + pplabel84.Text;
          end;

          data1.ERRSTR1 := 'View/Print ' + data1.ERRSTR1;
          fRepHold.ppLGsmall.Print;
        end;
      end;

      fRepHold.adoqLG.Close;
    end
    else
    begin  // HZ breakdown.....
      // get the LG (no wastage) qtys per HZ and for Site...
      dmADO.DelSQLTable('#ghost');

      data1.ERRSTR1 := 'Gather LG Data (HZ)';
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('SELECT b.hzid, b.entitycode, ');
        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          sql.Add('(a."SCat") as SubCatName,')
        else
          sql.Add('(a."Cat") as SubCatName,');
        sql.Add('a."PurchaseName", b."PurchUnit",');
        sql.Add('((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU") as theLG');
        sql.Add('INTO #ghost FROM "stkEntity" a, "StkCrDiv" b');
        sql.Add('WHERE a."entitycode" = b."entitycode"');
        sql.Add('and (ABS((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU") >= 0.001)');
        sql.Add('and b."key2" < 1000');
        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          sql.Add('Order By b.hzid, a.SCat,a."purchaseName"')
        else
          sql.Add('Order By b.hzid, a.Cat,a."purchaseName"');
        execRes := execSQL;

        if execRes = 0 then
        begin
          showmessage('There are no Losses or Gains to report.');
          fRepHold.Free;
          exit;
        end;

        data1.ERRSTR1 := 'Create Crosscheck table (HZ)';
        dmADO.DelSQLTable('#lghzRep');
        // create the report table...
        dmADO.adoqRun2.close;
        dmADO.adoqRun2.sql.Clear;
        dmADO.adoqRun2.sql.Add('CREATE TABLE [#lghzRep] (');
        dmADO.adoqRun2.sql.Add('	[EntityCode] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('	[SubCatName] [varchar] (20) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('	[PurchaseName] [varchar] (40) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('	[PurchUnit] [varchar] (10) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('  [lgSite] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg1] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg2] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg3] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg4] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg5] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg6] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg7] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg8] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg9] [float] NULL )');
        dmADO.adoqRun2.execSQL;

        data1.ERRSTR1 := 'Get Holding Zones (HZ)';
        dmADO.DelSQLTable('#lghzList');
        // get all HZs involved in this report
        close;
        sql.Clear;
        sql.Add('select IDENTITY(int, 1,1) AS ID_Num, hzid, hzname INTO [#lghzList] from stkHZs ');
        sql.Add('where active = 1 and hzid in (select distinct hzid from #ghost)');
        noOfHZs := execSQL;

        data1.ERRSTR1 := 'Get Holding Zones (HZ) 1';
        close;
        sql.Clear;
        sql.Add('SET IDENTITY_INSERT [#lghzList] ON');
        sql.Add('');
        sql.Add('INSERT [#lghzList] (ID_Num, hzid, hzname) VALUES (0, 0, ''Site'')');
        sql.Add('');
        sql.Add('SET IDENTITY_INSERT [#lghzList] OFF');
        execSQL;

        // restrict to Max No of Holding Zones just in case there are more ...
        data1.ERRSTR1 := 'Get Holding Zones (HZ) 2';
        close;
        sql.Clear;
        sql.Add('delete [#lghzList] where ID_Num > ' + inttostr(MAX_HOLDING_ZONES));
        execSQL;

        // TFS 305262 - if there are more than 9 HZs to display we sumup HZs 9 to 99 and
        //              present them all in one column (so Site, HZ1, HZ2, .., HZ8, Rest of HZs)
        if noOfHZs > 9 then
        begin
          data1.ERRSTR1 := 'Sum up HZ > 8';
          // sum up all numbers for HZs that don't fit in 8 columns (NOT necessarily the 9th HZ and higher!!!)
          // and add them as a "special" HZid.
          dmADO.adoqRun2.close;
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('insert [#ghost] (hzid, entitycode, SubCatName, PurchaseName, PurchUnit, theLG)');
          dmADO.adoqRun2.sql.Add('select 999, entitycode, SubCatName, PurchaseName, PurchUnit, sum(theLG)');
          dmADO.adoqRun2.sql.Add(' from [#ghost] where hzid in ');
          dmADO.adoqRun2.sql.Add('            (select hzid from [#lghzList] where ID_Num >= 9) ');
          dmADO.adoqRun2.sql.Add(' group by entitycode, SubCatName, PurchaseName, PurchUnit');
          dmADO.adoqRun2.execSQL;

          // now delete the individual entries that were summarised above...
          dmADO.adoqRun2.close;
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('delete [#ghost] where hzid in');
          dmADO.adoqRun2.sql.Add('(select hzid from [#lghzList] where ID_Num >= 9) ');
          dmADO.adoqRun2.execSQL;

          // change name and HZid of the 9th HZ record in #lghzListand delete the ones from 10th upwards
          data1.ERRSTR1 := 'Create summary column';
          dmADO.adoqRun2.close;
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('update [#lghzList] set hzid = 999, hzName = ''Sum of ' +
                                   inttostr(noOfHZs - 8) + ' other Holding Zones''');
          dmADO.adoqRun2.sql.Add('where ID_Num = 9');
          dmADO.adoqRun2.sql.Add('delete [#lghzList] where ID_Num > 9');
          dmADO.adoqRun2.execSQL;

          // the rest of the code below should now work without modification...
        end;



        // add each entity from #ghost into [#lghzRep]
        data1.ERRSTR1 := 'Get Holding Zones (HZ) 3';
        close;
        sql.Clear;
        sql.Add('INSERT [#lghzRep] ([EntityCode], [SubCatName], [PurchaseName], [PurchUnit])');
        sql.Add('SELECT DISTINCT [EntityCode], [SubCatName], [PurchaseName], [PurchUnit] from [#ghost]');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select * from [#lghzList] order by id_num');
        open;

        first; // this is the site wide...

        data1.ERRSTR1 := 'Start Holding Zones Loop';
        dmADO.adoqRun2.close;
        dmADO.adoqRun2.sql.Clear;
        dmADO.adoqRun2.sql.Add('update [#lghzRep] set lgSite = sq.theLG FROM');
        dmADO.adoqRun2.sql.Add('(select entitycode, theLG from [#ghost] where hzid = 0) sq');
        dmADO.adoqRun2.sql.Add('where [#lghzRep].entitycode = sq.entitycode');
        dmADO.adoqRun2.execSQL;

        next;  // now the "proper" HZs start...
        while not eof do
        begin
          // set label caption, make it visible
          AComponent := fRepHold.FindComponent('lghzLab' + FieldByName('id_num').asstring);
          if Assigned(AComponent) then
          begin
            if AComponent is TppLabel then
            begin
              TppLabel(AComponent).Visible := True;
              TppLabel(AComponent).Caption := FieldByName('hzname').asstring;

              case length(TppLabel(AComponent).Caption) of
                 1..10 : begin
                           TppLabel(AComponent).Height := 0.17;
                           TppLabel(AComponent).Top := 0.28;
                         end;
                 11..20: begin
                           TppLabel(AComponent).Height := 0.3;
                           TppLabel(AComponent).Top := 0.2;
                         end;
                    else begin
                           TppLabel(AComponent).Height := 0.44;
                           TppLabel(AComponent).Top := 0.14;
                         end;
              end; // end case
            end;
          end;

          if FieldByName('id_num').asinteger >= 2 then // 1 HZ at least always visible...
          begin
            // make corresponding lines/db text visible
            AComponent := fRepHold.FindComponent('lghzTLine' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppLine then
              begin
                TppLine(AComponent).Visible := True;
              end;
            end;

            AComponent := fRepHold.FindComponent('lghzLine' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppLine then
              begin
                TppLine(AComponent).Visible := True;
              end;
            end;

            AComponent := fRepHold.FindComponent('lghzText' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppDBText then
              begin
                TppDBText(AComponent).Visible := True;
              end;
            end;
          end;

          // set length of horizontal lines
          fRepHold.lghzHBotLine.Width := fRepHold.lghzHBotLine.Width + 0.8124;
          fRepHold.lghzHMidLine.Width := fRepHold.lghzHBotLine.Width;
          fRepHold.lghzHTopLine.Width := fRepHold.lghzHTopLine.Width + 0.8124;

          // put the data in proper field of [#lghzRep]
          dmADO.adoqRun2.close;
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('update [#lghzRep] set lg' + FieldByName('id_num').asstring + ' = sq.theLG FROM');
          dmADO.adoqRun2.sql.Add('(select entitycode, theLG from [#ghost]');
          dmADO.adoqRun2.sql.Add('  where hzid = ' + FieldByName('hzid').asstring + ') sq');
          dmADO.adoqRun2.sql.Add('where [#lghzRep].entitycode = sq.entitycode');
          dmADO.adoqRun2.execSQL;

          next;
        end;

        data1.ERRSTR1 := 'Set Labels (HZ)';
        // portrait or landscape
        if recordcount <= 7 then
        begin
          // make it portrait
          fRepHold.ppLGhz.PrinterSetup.Orientation := poPortrait;

          fRepHold.lghzStockTaker.left := fRepHold.lghzStockTaker.left - 1;
          fRepHold.lghzFrom.left := fRepHold.lghzFrom.left - 1;
          fRepHold.lghzIncl.left := fRepHold.lghzIncl.left - 1;
          fRepHold.lghzDiv.left := fRepHold.lghzDiv.left - 1;
          fRepHold.lghzShape1.left := fRepHold.lghzShape1.left - 1;
          fRepHold.lghzTitle.left := fRepHold.lghzTitle.left - 1;

          fRepHold.lghzLength.left := fRepHold.lghzLength.left - 1.7708;
          fRepHold.lghzAcc.left := fRepHold.lghzAcc.left - 1.7708;
          fRepHold.lghzPage.left := fRepHold.lghzPage.left - 1.7708;
          fRepHold.lghzPrTime.left := fRepHold.lghzPrTime.left - 1.7708;
          fRepHold.lghzPrinted.left := fRepHold.lghzPrinted.left - 1.7708;

          fRepHold.ppline413.Width := fRepHold.ppline413.Width - 1.7708;
        end;

        close;
      end;// with

      data1.ERRSTR1 := 'Open LG Query (HZ)';
      with fRepHold.adoqLGhz do
      begin
        close;
        sql.Clear;
        sql.Add('select * from [#lghzRep] Order By "subcatname", "purchaseName"');
        open;
      end;

      data1.ERRSTR1 := 'View/Print LG Report (HZ)';
      fRepHold.ppLGhz.Print;
      fRepHold.adoqLGhz.Close;
    end;

    fRepHold.Free;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Loss/Gain Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing LG Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.FormShow(Sender: TObject);
begin
  log.event('In Reps1.FormShow');
  if uGlobals.isSite then
  begin
    panel1.Visible := true;
  end
  else
  begin
    self.Height := self.height - 77;
    closebtn.Top := closebtn.Top - 77;
    panel1.Visible := False;
  end;

  groupbox3.Visible := (panel1.Visible and data1.curStkByHZ);

  // reproduce the AfterAudit calculations but with theo figures for actual ones...
  if doTheo then
  begin
    self.Caption := 'Reports Menu - UN-AUDITED ' + data1.SSbig;
  end
  else
  begin
    self.Caption := 'Single ' + data1.SSbig + ' Reports Menu';
  end;
  holdbtn.Caption := data1.SSbig + ' Holding';
  log.event('Exiting Reps1.FormShow');
end;


function TfReps1.TheoRepCalc: boolean;
begin
  Result := False;
  try
    log.event('Non Audited Reports: Calcs. Started - Thread: ' + data1.curTidName +
      ', StkCode: ' + inttostr(data1.StkCode));

    with data1.adoqRun do
    begin
      /////// process No. 3.2.1 ////////////////////////////////
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET ActCloseStk = ');
      sql.Add('CASE WHEN ThCloseStk < 0 THEN 0 ELSE ThCloseStk END');
      sql.add('Where "Key2" < 1000');
      Execsql;

      // NO PREP ITEMS reduction for theo stock as we don't know the Closing Stk - we assume no Reduction...
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET ActCloseStk = OpStk');
      sql.add('Where "Key2" >= 1000');
      Execsql;
    end; //with data1.adoqRun

    dataProc.PostAudit;

    Result := True;
    log.event('Non Audited Reports: Calculations Finished OK');
  except
    on E:Exception do
    begin
      log.event('ERROR NonAuditReports Calculations. Message: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.BitBtn1Click(Sender: TObject);
begin
  try
    data1.ERRSTR1 := 'Get Purch Data';
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(entitycode) as thecount from stkPurAll');
      open;

      if FieldByName('thecount').asinteger = 0 then
      begin
        showmessage('Nothing to report.');
        close;
        exit;
      end;
      close;
    end;

    data1.ERRSTR1 := 'Create Purch Report Form';
    fRepHold := TfRepHold.Create(Self);
    fRepHold.adoqInvSlv.Close;
    fRepHold.adoqInvMas.Close;

    with fRepHold.adoqInvMas do
    begin
      data1.ERRSTR1 := 'Open Purch Query';
      close;
      sql.Clear;

      if data1.curStkLastCalc = '' then
      begin
        sql.Add('SELECT p.supp, p.invno, p.[date], count(entitycode) as itemscount, sum(cvalue) as totval, 0 as cFlag');
        sql.Add('FROM stkPurAll p ');
        sql.Add('Group By supp, invno, [date]');
      end
      else
      begin
        sql.Add('SELECT p.supp, p.invno, p.[date], count(entitycode) as itemscount, sum(cvalue) as totval, ');
        sql.Add('  CASE WHEN c.LMDT is NULL THEN 0 ELSE 1 END as cFlag');
        sql.Add('FROM stkPurAll p LEFT OUTER JOIN  ');
        Sql.Add('   (SELECT [Supplier Name], [Delivery Note No.], [LMDT]');
        Sql.Add('    FROM dbo.[PurchHdrAztec] P');
        Sql.Add('    WHERE P.[Date] BETWEEN ' + quotedStr(formatDateTime('yyyymmdd', data1.SDate)));
        Sql.Add('                        AND' + quotedStr(formatDateTime('yyyymmdd', data1.EDate)));
        Sql.Add('    AND P.[LMDT] > ' + QuotedStr(data1.curStkLastCalc));
        Sql.Add('    AND P.[Deleted] is Null');
        sql.Add('    ) c  ON p.supp = c.[Supplier Name] and p.invno = c.[Delivery Note No.]  ');
        sql.Add('Group By supp, invno, [date], c.LMDT');
      end;

      case rgInv.ItemIndex of
        0 : sql.Add('Order By [date], supp, invno');
        1 : sql.Add('Order By supp, [date], invno');
      else sql.Add('Order By invno, [date]'); // 2
      end; // case..

      open;
    end;

    data1.ERRSTR1 := 'Open Purch Sub-Report Query';
    fRepHold.adoqInvSlv.close;
    if data1.RepHdr = 'Sub-Category' then
      fRepHold.adoqInvSlv.sql[1] := '(a.[SCat]) as SubCatName,'
    else
      fRepHold.adoqInvSlv.sql[1] := '(a.[Cat]) as SubCatName,';
    fRepHold.adoqInvSlv.open;

    data1.ERRSTR1 := 'View/Print Purch Report';
    fRepHold.ppInv.Print;

    fRepHold.adoqInvSlv.Close;
    fRepHold.adoqInvMas.Close;
    fRepHold.Free;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Purchase Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Purchase Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps1.FormCreate(Sender: TObject);
var
  h1 : smallint;
  NewTab : TTabSheet;
begin
  log.event('In Reps1.FormCreate');
  if (data1.curStkByHZ) then
  begin
    // use the HZtabs but first make them up...
    log.event('Reps1.FormCreate: using Holding Zones');

    with dmADO.adoqRun do
    begin                  // use the HZ settings from stkMisc as some old stock could have a
      close;               // different HZ setup than at present.
      sql.Clear;
      sql.Add('select distinct hzid, hzname, hzpurch, hzsales from stkmisc');
      sql.Add('where SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and [tid] = ' + inttostr(data1.curTid));
      sql.Add('and [stockcode]  = ' + inttostr(data1.stkCode));
      sql.Add('and hzid > 0 ');
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

        if FieldByName('hzsales').asboolean then
        begin
          if FieldByName('hzpurch').asboolean then
            newTab.ImageIndex := 2
          else
            newTab.ImageIndex := 0
        end
        else
        begin
          if FieldByName('hzpurch').asboolean then
            newTab.ImageIndex := 1;
        end;

        if FieldByName('hzpurch').asboolean then
          rephzPurch := FieldByName('hzid').asinteger;

        next;
        inc(h1);
      end;

      close;
    end;

    hzTabs.Visible := True;
    hzTabs.ActivePageIndex := 0;
  end
  else
  begin
    log.event('Reps1.FormCreate: does not use Holding Zones');
    // DO NOT show the HZtabs...
    hzTabs.ActivePageIndex := 0;
    hzTabs.Visible := False;
    GroupBox3.Visible := False;

    self.ClientHeight := 372;
  end;

  if hztabs.Visible and (hzTabs.ActivePageIndex = 0) then
  begin
    rbCost.Top := 9;
    rbPrice.Top := 26;
    rbBoth.Top := 43;
    rbHZsummary.Visible := (uGlobals.isSite);
  end
  else
  begin
    rbCost.Top := 15;
    rbPrice.Top := 34;
    rbBoth.Top := 53;
    rbHZsummary.Visible := False;
  end;

  if data1.noTillsOnSite then
  begin
    log.event('Reps1.FormCreate: No tills on site');
    rbCost.Checked := TRUE;
    spBtn.Visible := FALSE;
    cbDetail.Visible := FALSE;
    radiobutton1.Visible := FALSE;
    cbSPprof.Visible := FALSE;
    retSumBtn.Visible := FALSE;
    bevel2.Visible := FALSE;
    rbCost.Visible := FALSE;
    rbPrice.Visible := FALSE;
    rbBoth.Visible := FALSE;
    rbHZsummary.Visible := FALSE;
  end;

  repHZid := 0;
  repHZidStr := '0';
  log.event('Exiting Reps1.FormCreate');
end;

procedure TfReps1.hzTabsChange(Sender: TObject);
begin
  repHZid := hzTabs.ActivePage.Tag;
  repHZidStr := inttostr(repHZid);
  repHZName := hzTabs.ActivePage.Caption;

  spBtn.Enabled := ((hzTabs.ActivePage.ImageIndex = 0) or (hzTabs.ActivePage.ImageIndex = 2) or(repHzid = 0));
  radiobutton1.Enabled := spBtn.Enabled;
  cbSPprof.Enabled := spBtn.Enabled;
  retSumBtn.Enabled := spBtn.Enabled;

  bitbtn1.Enabled := ((repHZid = repHZpurch) or (repHzid = 0));
  rgInv.Enabled := bitbtn1.Enabled;

  if hztabs.Visible and (hzTabs.ActivePageIndex = 0) then
  begin
    rbCost.Top := 9;
    rbPrice.Top := 26;
    rbBoth.Top := 43;
    rbHZsummary.Visible := (uGlobals.isSite);
  end
  else
  begin
    rbCost.Top := 15;
    rbPrice.Top := 34;
    rbBoth.Top := 53;
    rbHZsummary.Visible := False;
    if rbHZsummary.Checked then
      rbCost.Checked := True;
  end;

end;

procedure TfReps1.BitBtn2Click(Sender: TObject);
var
  AComponent : TComponent;
begin
  try
    if rbSite.Checked then // the Transfer Lists report
    begin
      data1.ERRSTR1 := 'Create HZ Transfer Report Form';
      fRepSP := TfRepSP.Create(Self);
      fRepSP.adoqHZMSite.Close;

      with fRepSP.adoqHZMSite do
      begin
        data1.ERRSTR1 := 'Open HZ Transfer Query';
        close;
        sql.Clear;
        sql.Add('SELECT m.[MoveID], m.[hzIDSource], m.[hzIDDest], m.[MoveDT], m.[MoveBy], m.[MoveNote],');
        sql.Add('h1.[hzname] as hzSource, h2.[hzname] as hzDest, p.[EntityCode], p.[RecID],');
        sql.Add('(p.[Qty] / p.[BaseU]) as MoveQty, p.[MoveU], e.div as Div, e."PurchaseName" as PurN,');
        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        begin
          sql.Add('(e."SCat") as Sub');
          fRepSP.pplabel46.Caption := 'Sub-Category';
        end
        else
        begin
          sql.Add('(e."Cat") as Sub');
          fRepSP.pplabel46.Caption := 'Category';
        end;
        sql.Add('FROM stkHZMoves m, stkHZMProds p, stkHZs h1, stkHZs h2, [stkENTITY] e');
        sql.Add('WHERE m.[MoveID] = p.[MoveID]');
        sql.Add('AND m.[hzIDSource] = h1.[hzid]');
        sql.Add('AND m.[hzIDDest] = h2.[hzid]');
        sql.Add('AND p.[EntityCode] = e."EntityCode"');
        sql.Add('and m.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
        sql.Add('and m.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
        sql.Add('order by m.[MoveID], p.[RecID]');
        open;
      end;

      if fRepSP.adoqHZMSite.RecordCount = 0 then
      begin
        showmessage('No Internal Transfers for this period. Nothing to report.');
      end
      else
      begin
        data1.ERRSTR1 := 'View/Print HZ Transfer (by Transfer)';
        fRepSP.ppHZMSite.Print;
      end;

      fRepSP.adoqHZMSite.Close;
      fRepSP.Free;
    end
    else              // Products by HZ report
    begin
      data1.ERRSTR1 := 'Create HZ Transfer Report Form 2';
      fRepSP := TfRepSP.Create(Self);


      dmADO.DelSQLTable('#ghost');
      with dmADO.adoqRun do
      begin
        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 1';
        close;
        sql.Clear;
        sql.Add('SELECT m.[MoveID], m.[hzIDSource], m.[hzIDDest], m.[MoveDT], m.[MoveBy], m.[MoveNote],');
        sql.Add('p.[EntityCode],');
        sql.Add('p.[Qty], p.[BaseU], p.[MoveU], e.div as Div, e."PurchaseName" as PurN,');
        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        begin
          sql.Add('(e."SCat") as Sub,');
          fRepSP.pplabel46.Caption := 'Sub-Category';
        end
        else
        begin
          sql.Add('(e."Cat") as Sub,');
          fRepSP.pplabel46.Caption := 'Category';
        end;
        sql.Add('e."PurchaseUnit" as PurUnit, u.[Base Units] as PurBaseU');
        sql.Add('into #ghost');
        sql.Add('FROM stkHZMoves m, stkHZMProds p, "stkENTITY" e, [Units] u');
        sql.Add('WHERE m.[MoveID] = p.[MoveID]');
        sql.Add('AND p.[EntityCode] = e."EntityCode"');
        sql.Add('and m.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
        sql.Add('and m.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
        sql.Add('and E."PurchaseUnit" = U.[unit name]');

        execRes := execSQL;

        if execRes = 0 then
        begin
          showmessage('No Internal Transfers for this period. Nothing to report.');
          exit;
        end;

        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 2';
        dmADO.DelSQLTable('#hzmRep');
        // create the report table...
        dmADO.adoqRun2.close;
        dmADO.adoqRun2.sql.Clear;
        dmADO.adoqRun2.sql.Add('CREATE TABLE [#hzmRep] (');
        dmADO.adoqRun2.sql.Add('	[EntityCode] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('	[Div] [varchar] (20) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('	[Sub] [varchar] (20) collate database_default NULL ,');

        dmADO.adoqRun2.sql.Add('	[PurName] [varchar] (40) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('	[PurUnit] [varchar] (10) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('  [PurBaseU] [float] NULL ,');

        dmADO.adoqRun2.sql.Add('	[MoveID] [int] NULL ,');
        dmADO.adoqRun2.sql.Add('	[MoveDT] [datetime] NULL ,');
        dmADO.adoqRun2.sql.Add('	[MoveU] [varchar] (10) collate database_default NULL ,');
        dmADO.adoqRun2.sql.Add('  [BaseU] [float] NULL ,');

        dmADO.adoqRun2.sql.Add('  [lg1] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg2] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg3] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg4] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg5] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg6] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg7] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg8] [float] NULL ,');
        dmADO.adoqRun2.sql.Add('  [lg9] [float] NULL )');
        dmADO.adoqRun2.execSQL;

        dmADO.DelSQLTable('#lghzList');
        // get all HZs involved in this report
        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 3';
        close;
        sql.Clear;
        sql.Add('select IDENTITY(int, 1,1) AS ID_Num, hzid, hzname INTO [#lghzList] from stkHZs ');
        sql.Add('where (hzid in (select distinct hzidSource from #ghost))');
        sql.Add('or (hzid in (select distinct hzidDest from #ghost))');
        execSQL;

        // add each entity from #ghost into [#hzmRep]
        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 4';
        close;
        sql.Clear;
        sql.Add('INSERT [#hzmRep] ([EntityCode], [Div], [Sub], [PurName], [PurUnit], [PurBaseU],');
        sql.Add('                  [MoveID], [MoveDT], [MoveU], [BaseU])');
        sql.Add('SELECT DISTINCT [EntityCode], [Div], [Sub], [PurN], [PurUnit], [PurBaseU],');
        sql.Add(' [MoveID], [MoveDT], [MoveU], [BaseU] from [#ghost]');
        execSQL;

        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 5';
        close;
        sql.Clear;
        sql.Add('select * from [#lghzList] order by id_num');
        open;

        first;

        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 6';
        while not eof do
        begin
          // set label caption, make it visible
          AComponent := fRepSP.FindComponent('lghzLab' + FieldByName('id_num').asstring);
          if Assigned(AComponent) then
          begin
            if AComponent is TppLabel then
            begin
              TppLabel(AComponent).Visible := True;
              TppLabel(AComponent).Caption := FieldByName('hzname').asstring;

              case length(TppLabel(AComponent).Caption) of
                 1..10 : begin
                           TppLabel(AComponent).Height := 0.17;
                           TppLabel(AComponent).Top := 0.43;
                         end;
                 11..20: begin
                           TppLabel(AComponent).Height := 0.3;
                           TppLabel(AComponent).Top := 0.35;
                         end;
                    else begin
                           TppLabel(AComponent).Height := 0.44;
                           TppLabel(AComponent).Top := 0.29;
                         end;
              end; // end case
            end;
          end;

          if FieldByName('id_num').asinteger >= 2 then // 1 HZ at least always visible...
          begin
            // make corresponding lines/db text visible
            AComponent := fRepSP.FindComponent('lghzTLine' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppLine then
              begin
                TppLine(AComponent).Visible := True;
              end;
            end;

            AComponent := fRepSP.FindComponent('lghzLine' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppLine then
              begin
                TppLine(AComponent).Visible := True;
              end;
            end;

            // move the SubReport top/bottom Right edge lines to the right...
            fRepSP.hzmLRTop.Width := TppLine(AComponent).Width;
            fRepSP.hzmLRTop.Left := TppLine(AComponent).Left;
            fRepSP.hzmLRTop.Position := TppLine(AComponent).Position;
            fRepSP.hzmLRBot.Width := TppLine(AComponent).Width;
            fRepSP.hzmLRBot.Left := TppLine(AComponent).Left;
            fRepSP.hzmLRBot.Position := TppLine(AComponent).Position;

            AComponent := fRepSP.FindComponent('lghzText' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppDBText then
              begin
                TppDBText(AComponent).Visible := True;
              end;
            end;

            // for the SubReport
            AComponent := fRepSP.FindComponent('hzmLine' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppLine then
              begin
                TppLine(AComponent).Visible := True;
              end;
            end;

            AComponent := fRepSP.FindComponent('hzmText' + FieldByName('id_num').asstring);
            if Assigned(AComponent) then
            begin
              if AComponent is TppDBText then
              begin
                TppDBText(AComponent).Visible := True;
              end;
            end;
          end;

          // set length of horizontal lines
          fRepSP.lghzHBotLine.Width := fRepSP.lghzHBotLine.Width + 0.8124;
          fRepSP.lghzHMidLine.Width := fRepSP.lghzHBotLine.Width;
          fRepSP.lghzHTopLine.Width := fRepSP.lghzHTopLine.Width + 0.8124;

          fRepSP.hzmLBot.Width := fRepSP.lghzHBotLine.Width;
          fRepSP.hzmLMid.Width := fRepSP.hzmLMid.Width + 0.8124;
          fRepSP.hzmLTop.Width := fRepSP.hzmLTop.Width + 0.8124;


          // put the data in proper fields of [#hzmRep]
          dmADO.adoqRun2.close;             // first the Source...
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('update [#hzmRep] set lg' + FieldByName('id_num').asstring + ' = sq.qty FROM');
          dmADO.adoqRun2.sql.Add('(select entitycode, moveid, moveU, (Qty * -1) as qty from [#ghost]');
          dmADO.adoqRun2.sql.Add('  where hzidSource = ' + FieldByName('hzid').asstring + ') sq');
          dmADO.adoqRun2.sql.Add('where [#hzmRep].entitycode = sq.entitycode');
          dmADO.adoqRun2.sql.Add('and [#hzmRep].moveid = sq.moveid');
          dmADO.adoqRun2.sql.Add('and [#hzmRep].moveU = sq.moveU');
          dmADO.adoqRun2.execSQL;

          dmADO.adoqRun2.close;             // now the Dest...
          dmADO.adoqRun2.sql.Clear;
          dmADO.adoqRun2.sql.Add('update [#hzmRep] set lg' + FieldByName('id_num').asstring + ' = sq.qty FROM');
          dmADO.adoqRun2.sql.Add('(select entitycode, moveid, moveU, Qty from [#ghost]');
          dmADO.adoqRun2.sql.Add('  where hzidDest = ' + FieldByName('hzid').asstring + ') sq');
          dmADO.adoqRun2.sql.Add('where [#hzmRep].entitycode = sq.entitycode');
          dmADO.adoqRun2.sql.Add('and [#hzmRep].moveid = sq.moveid');
          dmADO.adoqRun2.sql.Add('and [#hzmRep].moveU = sq.moveU');
          dmADO.adoqRun2.execSQL;

          next;
        end;

        data1.ERRSTR1 := 'Get HZ Transfer (by Product) 7';
        // portrait or landscape
        if recordcount <= 7 then
        begin
          // make it portrait
          fRepSP.ppReport1.PrinterSetup.Orientation := poPortrait;

          fRepSP.lghzFrom.left := fRepSP.lghzFrom.left - 1;
          fRepSP.lghzShape1.left := fRepSP.lghzShape1.left - 1;
          fRepSP.lghzTitle.left := fRepSP.lghzTitle.left - 1;

          fRepSP.lghzLength.left := fRepSP.lghzLength.left - 1.7708;
          fRepSP.lghzPage.left := fRepSP.lghzPage.left - 1.7708;
          fRepSP.lghzPrTime.left := fRepSP.lghzPrTime.left - 1.7708;
          fRepSP.lghzPrinted.left := fRepSP.lghzPrinted.left - 1.7708;

          fRepSP.ppline413.Width := fRepSP.ppline413.Width - 1.7708;
          fRepSP.ppline189.Width := fRepSP.ppline413.Width;
          fRepSP.ppline190.Width := fRepSP.ppline413.Width;
          fRepSP.ppline191.Width := fRepSP.ppline413.Width;
          fRepSP.ppline95.Width := fRepSP.ppline413.Width;
          fRepSP.ppline96.Width := fRepSP.ppline413.Width;

        end;

        close;

      end;// with

      with fRepSP.adoqHZM1 do
      begin

        data1.ERRSTR1 := 'Open HZ Transfer (by Product) Query';
        close;
        sql.Clear;
        sql.Add('SELECT [EntityCode], [Div], [Sub], [PurName], [PurUnit],');
        sql.Add('count(MoveID) as Moves, (SUM([lg1]) / PurBaseU) as lg1,');
        sql.Add('(SUM([lg2]) / PurBaseU) as lg2,	(SUM([lg3]) / PurBaseU) as lg3,');
        sql.Add('(SUM([lg4]) / PurBaseU) as lg4,	(SUM([lg5]) / PurBaseU) as lg5,');
        sql.Add('(SUM([lg6]) / PurBaseU) as lg6,	(SUM([lg7]) / PurBaseU) as lg7,');
        sql.Add('(SUM([lg8]) / PurBaseU) as lg8,	(SUM([lg9]) / PurBaseU) as lg9 ');
        sql.Add('FROM [#hzmRep]');
        sql.Add('GROUP BY [EntityCode], [Div], [Sub], [PurName], [PurUnit], [PurBaseU]');
        sql.Add('ORDER BY [Div], [Sub], [PurName], [PurUnit]');
        open;
      end;

      fRepSP.adoqHZM2.Open;

      data1.ERRSTR1 := 'View/Print HZ Transfer (by Product) Report';
      fRepSP.ppreport1.print;
      fRepSP.adoqHZM1.close;
      fRepSP.adoqHZM2.close;

      fRepSP.Free;
    end;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a HZ Internal Transfer Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing HZ Transfer Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;


procedure TfReps1.Collapse(var Msg: TMsg);
begin
  fRepHold.ppHoldRepBig.CollapseDrillDowns;
  fRepHold.ppHoldRepBig.PrintToDevices;
end;

end.

