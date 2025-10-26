unit uDataProc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ADODB, Wwquery, Variants;

type
  TdataProc = class(TDataModule)
  private
    errStr : string;
    dt1 : tdatetime;
    procedure GetMthNomPrices;
    procedure PrepItemQtyToIngredients;
    procedure PleaseWait(barPercent: smallint; actionText: string);
    { Private declarations }

  public
    { Public declarations }
    RcpErr: boolean;

    procedure SetCosts(IsAct: boolean);
    procedure FIFOcost(isActual: boolean);
    function PreAudit(rtRcp, getCosts: boolean; oneHZid: smallint): boolean;
    function PostAudit:boolean;

    procedure FastPurch(updtStkMisc: boolean = FALSE);

    procedure CreateEntCopy;
  end;

var
  dataProc: TdataProc;

implementation

uses udata1, uADO, uwait, uSetNom, uMainMenu, ulog, dRunSP;

{$R *.DFM}

procedure TDataProc.FastPurch(updtStkMisc: boolean = FALSE);
Var
  totpurch : real;
  errStr : string;
begin
  log.event('In dataProc.FastPurch, upDtStkMisc = ' + sysutils.BoolToStr(updtstkMisc, TRUE));
  try
    dmRunSP := TdmRunSP.Create(self);
    with dmRunSP do
    begin
      spConn.Open;

      with adoqRunSP do
      begin
        close;
        sql.Clear;
        sql.Add('exec stkSP_GetPurch ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.Sdate)) +
           ', ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.Edate)) + ', ' +
           quotedStr(data1.TheDiv) + ', 0');
        dt1 := Now;

        try
          execSQL;
          log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' +
             sql[0] + '"');
        except
          on E:Exception do
          begin
            log.event('SP ERROR - "' + sql[0] + '"' +
            ' ERR MSG: ' + E.Message);
            if not data1.blindRun then
            showMessage('ERROR Calculating Retail Cost and Nominal Prices!' + #13 +
              'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
            exit;
          end;
        end;
      end;
      spConn.Close;
    end;
    dmRunSP.Free;

    if updtStkMisc then
    with data1.adoqRun do
    begin
      // load tot purch value in StkMisc for reports...
      errStr := 'Calculate Total Value';
      close;
      sql.Clear;
      sql.Add('select sum(cvalue) as totpurch from stkpurch');
      open;

      totpurch := FieldByName('totpurch').asfloat;

      errStr := 'Load Total Value';
      close;
      sql.Clear;
      if data1.curByHZ then
      begin
        sql.Add('update stkMisc set totPurch = ' + floattostr(totpurch));
        sql.Add('WHERE StockCode = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        sql.Add('and (hzid = 0 or hzid = ' + inttostr(data1.purHZid) + ')');
      end
      else
      begin
        sql.Add('update stkMisc set totPurch = ' + floattostr(totpurch));
        sql.Add('WHERE StockCode = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
      end;
      execSQL;
    end;
  except
     on E: exception do
     begin
       log.event('ERROR: ' + errstr + ' Msg: ' + e.Message);
       if not data1.blindRun then
       showmessage('ERROR: ' + errstr + #13 + #13 + 'Error Message: '+#13 +e.message);
     end;
  end; //try
end; // function..


// used both for Theoretical and Actual Costs, depending on parameter IsAct
procedure TdataProc.SetCosts(IsAct: boolean);
Var
  Item, PurchQ, CloseStk, OpCost, PCost,                 // opening cost, purchase cost
  AccumQ, AccumV : real; 				 // Sum so far Qty, Value of purchases
  target : boolean; // done calculating entity reduction value
  RedField, CloseField: String; // destination field names according to IsAct param.
begin
  if IsAct then
  begin
    RedField 	 := 'ActRedCost';
    CloseField := 'ActCloseCost';
  end
  else
  begin
    RedField   := 'ThRedCost';
    CloseField := 'ThCloseCost';
  end;

  with data1, data1.adoqRun do
  begin
    // ensure that there are no recs in stkPurch.db that do no exist in StkCrDiv.db

    // at this point it is imperative that there is only ONE rec per entity
    // this referes to prepared items.
    wwtRun.Close;
    wwtRun.TableName := 'StkCrDiv';
    wwtRun.Filter := 'hzid = 0';
    wwtRun.Filtered := True;
    wwtRun.Open;
    wwtRun.First;

    close;
    sql.Clear;
    sql.Add('SELECT a."entitycode", a."date", a."baseqty", a."basecost", a."cvalue"');
    sql.Add('FROM "StkPurch" a WHERE a."sitecode" = '+IntToStr(TheSiteCode));
    sql.Add('ORDER BY a."entitycode", a."date" DESC');
    Open;
    First;

    if isAct then
      PleaseWait(21,'Calculate Actual Costs (FIFO 2).')
    else
      PleaseWait(95,'Calculate Theo. Costs (FIFO 1).');

    if RecordCount > 0 Then  // are therte any purchases????
    begin
      // outer loop on StkCrDiv.db (all in order of entity)
      while not wwtRun.EOF do
      begin
        if wwtRun.FieldByName('key2').AsInteger >= 1000 then // 17841 - No FIFO for PrepItems, costs done later
        begin
          wwtRun.next;
          continue;
        end;

        Item := wwtRun.FieldByName('entitycode').AsFloat;

        if IsAct then
        begin
          CloseStk := wwtRun.FieldByName('ActCloseStk').AsFloat + wwtRun.FieldByName('ClosePrep').AsFloat;
        end
        else
        begin
          CloseStk := wwtRun.FieldByName('ThCloseStk').AsFloat + wwtRun.FieldByName('OpenPrep').AsFloat;
        end;
        PurchQ   := wwtRun.FieldByName('PurchStk').AsFloat;
        OpCost   := wwtRun.FieldByName('OpCost').AsFloat;
        PCost    := wwtRun.FieldByName('PurchCost').AsFloat;

        if closeStk = 0 then  // case #4: All was consumed, Close Cost = last purchase cost...
        begin
          if PurchQ > 0 then // at least one purchase is there...
          begin
            locate('entitycode', Item, []); // locate the first record as order is by date DESC...

            wwtRun.Edit;
            wwtRun.FieldByName(CloseField).AsFloat := FieldByName('basecost').asfloat;
            wwtRun.Post;
          end
          else 	// purchQ <=  // no purchases, use open cost
          begin
            wwtRun.Edit;
            wwtRun.FieldByName(CloseField).AsFloat := OpCost;
            wwtRun.Post;
          end; 	//if PurchQ > 0
        end
        else 		// closestk > 0
        begin
          if closeStk >= PurchQ then // case #2: No purchased stock consumed...
          begin                      // also case #1: Nothing was consumed...
            if PurchQ < 0 then // no purchases, use open cost
            begin
              wwtRun.Edit;
              wwtRun.FieldByName(CloseField).AsFloat := OpCost;
              wwtRun.Post;
            end
            else 	// PurchQ >= 0
            begin
              wwtRun.Edit;
              wwtRun.FieldByName(CloseField).AsFloat :=
              	 ((PurchQ * Pcost) + ((CloseStk - PurchQ) * OpCost)) / CloseStk;
              wwtRun.Post;
            end; 	// if PurchQ < 0
          end
          else    // closeStk < PurchQ, do fifo...
          begin   // case #3: all op stk consumed and some purchases....
            Target := False;
            AccumQ := 0;
            AccumV := 0;

            /////////////// cc 17 may 99 //////////////////////////////////////
            // locate the first record in StkPurch(wwqRun) with the entity code = Item.
            locate('entitycode', Item, []);

            while (NOT Target) AND (NOT EOF) AND (Item = FieldByName('entitycode').AsFloat) do
            begin
              accumQ := accumQ + FieldByName('baseqty').asfloat;

              if AccumQ < CloseStk then
              begin                                                 // add the purch record value, no
                AccumV := AccumV + (FieldByName('cvalue').asfloat); // multiplication needed, avoid rounding errors
              end
              else  // found all purchases left un consumed, loop stops here...
              begin  // only use enough purch qty that was really left over....
                AccumV := AccumV + ((CloseStk - accumQ + FieldByName('baseqty').asfloat) * FieldByName('basecost').asfloat);
                Target := True;
              end;
              Next;
            end;
            wwtRun.Edit;
            wwtRun.FieldByName(CloseField).AsFloat := AccumV / CloseStk;
            wwtRun.Post;
          end;	// if closeStk >= PurchQ else...
        end; 	// if closeStk = 0 else...
        wwtRun.Next;
      end; // while outer loop on StkCrDiv.db (all in order of entity)
      wwtRun.Close;
      close;
    end
    else // stkpurch empty...
    begin
      wwtRun.Close;
      // There are no purchases for ANY items!?!?!?! So set the close costs as
      // the open cost except where no qtys.
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('"'+CloseField+'" = "OpCost" where hzid = 0');
      ExecSQL;
    end; // if..else.. stkpurch full/empty

    // now set reduction costs
    if IsAct then
    begin

  PleaseWait(25,'Set Actual Reduction Costs.');
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('"ActRedCost" = ');
      sql.Add('            (CASE ');
      sql.Add('               WHEN ActRedQty = 0 THEN OpCost');
      sql.Add('               ELSE (("OpCost" * "OpStk") + ("PurchStk" * "PurchCost") - ' +
                                   '("ActCloseStk" * "ActCloseCost")) / "ActRedQty"');
      sql.Add('             END)');
      sql.Add('where hzid = 0 and key2 < 1000');
      ExecSQL;
    end
    else
    begin
  PleaseWait(98,'Set Theo. Reduction Costs.');
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('"ThRedCost" = ');
      sql.Add('            (CASE ');
      sql.Add('               WHEN ThRedQty = 0 THEN OpCost');
      sql.Add('               ELSE (("OpCost" * "OpStk") + ("PurchStk" * "PurchCost") - ' +
                                   '("thCloseStk" * "thCloseCost")) / "thRedQty"');
      sql.Add('             END)');
      sql.Add('where hzid = 0');
      ExecSQL;
    end;

    wwtRun.Filter := '';
    wwtRun.Filtered := False;
    wwtRun.Close;
  end; // with..
end; // procedure..


procedure TDataProc.GetMthNomPrices;
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkcrdiv set NomPrice = sq.NomPrice');
    sql.Add('from (');
    sql.Add('  SELECT a."entitycode", a.NomPrice');
    sql.Add('   FROM "stkMain" a WHERE a."stkcode" = '+IntToStr(data1.lastSThAccCode));
    sql.Add('   and tid = '+IntToStr(data1.curMth));
    sql.Add('  ) sq ');
    sql.Add('where stkcrdiv.entitycode = sq.entitycode');
    sql.Add('and ((stkcrdiv.nomPrice = 0) or (stkcrdiv.nomPrice is NULL))');
    execSQL;
  end;
end; // procedure..

///////////  CC  //////////////////////////////////////////////////////////////
//  Date: 31 Aug 2004
//  Inputs: rtRcp - Real Time Recipes: uses the Theo Red calcualted at Sale Time
//          getCosts - normally True but for Line Checks it is not required
//  Outputs: None directly; Main output is data in the table stkCrDiv
//
//  This proc gathers TheoRed and Till Waste, OpStk & Cost, Purch Qty & Cost
//  and PCWaste (incl Auto Waste) and derives a Theo Close (estimated Stock Holding) figure
///////////////////////////////////////////////////////////////////////////////
function TdataProc.PreAudit(rtRcp, getCosts: boolean; oneHZid : smallint): boolean;
var
  termIDs : string; // array of termianl ids separated by comma and space to be used in queries
  oneHZePur : boolean;
  i : integer;
begin
  Result := FALSE;
  oneHZePur := FALSE;

  if not data1.blindRun then
  begin
  fwait := Tfwait.Create(self);
  fwait.Show;
  end;

  try
    PleaseWait(1,'Creating Divisional Ingredients Table.');

  with data1.adoqRun do
  begin
    try
      errStr := 'PreAudit Start';
      termIDs := '';

      dmADO.DelSQLTable('#HZsGhost');
      dmADO.DelSQLTable('stkTRtemp');

      if data1.curByHz then
      begin
        close;
        sql.Clear;
        sql.Add('select hzid, hzname, epur, esales into [#HZsGhost] from stkHZs where active = 1');
        sql.Add('Insert [#HZsGhost] (hzid, hzname) VALUES (0, ''Whole Site'')');
        execSQL;

        errStr := 'Read Holding Zones';
        if onehzid <> 0 then // this run is only for 1 holding zone...
        begin
          close;
          sql.Clear;
          sql.Add('select * from [stkhzpos] where hzid = ' + inttostr(onehzid));
          open;

          termids := FieldByName('TerminalID').AsString;
          next;
          while not eof do
          begin
            termids := termids + ', ' + FieldByName('TerminalID').AsString;
            next;
          end;
          close;

          close;
          sql.Clear;
          sql.Add('select * from [#hzsghost] where hzid = ' + inttostr(onehzid));
          open;
          oneHZePur := FieldByName('ePur').AsBoolean;
          close;
        end;
      end
      else
      begin
        close;
        sql.Clear;
        sql.Add('select 0 as hzid, (''Whole Site'') as hzname into [#HZsGhost]');
        execSQL;
      end;
        PleaseWait(5,'Select Divisional Ingredients.');

      dmADO.EmptySQLTable('StkCrDiv');
      errStr := 'Select Ingredients';

      // fill stkcrDiv with all stockable entity codes
      close;
      sql.Clear;
      sql.Add('Insert into [StkCrDiv] (hzid, entitycode, key2, purchUnit,PurchBaseU)');
      sql.Add('SELECT b.hzid, a.[EntityCode], (CASE a.etcode WHEN ''P'' THEN 1020 ELSE 20 END),');
      sql.Add('       a.[PurchaseUnit], a.[PurchBaseU]');
      sql.Add('FROM "stkEntity" a, [#HZsGhost] b');
      sql.Add('WHERE a."etcode" in (''G'', ''S'', ''P'')'); // Purch.Line, Strd.Line, PrepItem
      sql.Add('and a.div = ' + quotedStr(data1.TheDiv));
      if (data1.curByHz) and (onehzid <> 0) then
        sql.Add('and b.hzid = ' + inttostr(onehzid));
      execSQL;

        PleaseWait(10,'Set Intial Default Values.');
      errStr := 'Set Default Values';
      // initialise all numeric fields with zero
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('"OpStk" = 0, "OpCost" = 0, "PurchStk" = 0, "PurchCost" = 0,');
      sql.Add('"MoveQty" = 0, "MoveCost" = 0, "SoldQty" = 0,"ThRedQty" = 0, "ThRedCost" = 0,');
      sql.Add('"ThCloseStk" = 0,"ThCloseCost" = 0, "ActRedQty" = 0, "ActRedCost" = 0, "AuditStk" = 0,');
      sql.Add('"ActCloseStk" = 0, "ActCloseCost" = 0, "PrepRedQty" = 0, VATRate = 0,');
      sql.Add('"WasteTill" = 0, "WastePC" = 0, "WasteTillA" = 0, "WastePCA" = 0, "Wastage" = 0,');
      sql.Add('"OpenPrep" = 0, "ClosePrep" = 0, TrueRedCost = 0');
      Execsql;


     // 1. Get the Theo Reduction and Till Waste
      // Depending on rtRcp there are two ways of doing this
        PleaseWait(20,'Calc. Theo Reduction');


      // for Sites with no Tills do not call the Stored Procedures. Simply create the
      // temp table stkTRtemp and leave it empty to have system behave as much as possible as
      // a normal system but without any sales or wastage for the period of the stock...
      if data1.noTillsOnSite then
      begin
        close;
        sql.Clear;
        sql.Add('CREATE TABLE dbo.[stkTRtemp] ([TermID] [smallint] NULL, [DT] [datetime] NULL,');
        sql.Add('	[FromTrx] [bigint] NULL, [EntityCode] [float] NULL,	[RedQty] [float] NULL,');
        sql.Add('	[WasteFlag] [bit] NULL,	[ProcFlag] [int] NOT NULL, [BsDate] [datetime] NULL,');
        sql.Add('	[LMDT] [datetime] NULL,	[PArent] [bigint] NULL,	[Source] [varchar] (1) NULL)');
        execSQL;
      end
      else  // there are tills on site, get the Theo Reduction...
      begin
        if rtRcp then  // use Real Time Recipes - simply sum up data from stkTheoRed...
        begin
          errStr := 'Get RT Reduction';
          // place all the data we'll use in stkTRtemp from stkTheoRed...
          close;
          sql.Clear;
          sql.Add('select * INTO dbo.stkTRtemp from stkTheoRed');
          sql.Add('where DT > ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.SDT)));
          sql.Add('and DT <= ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.EDT)));
          sql.Add('and entitycode in (select entitycode from stkEntity where div = ' + quotedStr(data1.TheDiv) + ')');
          if (data1.curByHz) and (onehzid <> 0) then
            sql.Add('and termid IN ' + termids);
          execSQL;
        end
        else           // use Time of Stock Recipes - old methodology, read on...
        begin
          // CALL a SP which does exactly what stkSP_TheoRed does but it has a certain date range
          // and it places the results directly in stkTRtemp
          errStr := 'Get ST Reduction';
          dmRunSP := TdmRunSP.Create(self);
          with dmRunSP do
          begin
            spConn.Open;

            with adoqRunSP do
            begin
              close;
              sql.Clear;
              sql.Add('DECLARE @ret int');
              sql.Add('exec @ret = stkSP_TheoRedCR ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.SDT)) +
                   ', ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.EDT)) + ', ' +
                   inttoStr(onehzid) + ', ' + quotedStr(data1.TheDiv));
              sql.Add('SELECT @ret');
              dt1 := Now;
              try
               Open;

               if fields[0].AsInteger = -5 then
               begin
                log.event('SP NOT Executed WILL try again - ' +
                           formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"');

                close;
                Application.ProcessMessages;
                sleep(60000);
                Application.ProcessMessages;

                try
                  Open;
                  if fields[0].AsInteger = 0 then
                   log.event('SP EXEC on 2nd try - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
                  else if fields[0].AsInteger = -5 then
                  begin
                    log.event('SP NOT Executed on 2nd try, LOCK still on - ' +
                               formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"');

                      if not data1.blindRun then
                    showMessage('The Stored Procedure gathering Sales Reduction could not run' + #13 +
                      'because re-building of the Recipe Map appears to be going on.' + #13 + #13 +
                      'The ' + data1.SSbig + ' Taking process cannot continue at this time.' + #13 +
                      'Please try again in a few minutes.');
                      exit;
                  end
                  else
                  begin
                   log.event('SP ERROR - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
                     ' ERR CODE: ' + fields[0].AsString);
                      if not data1.blindRun then
                    showMessage('ERROR in Stored Procedure getting Sales Reduction' + #13 +
                      'Please contact Zonal.');
                    exit;
                  end;
                except
                  on E:Exception do
                  begin
                    log.event('SP ERROR - "' + sql[1] + '"' +
                    ' ERR MSG: ' + E.Message);
                      if not data1.blindRun then
                    showMessage('ERROR in Stored Procedure getting Sales Reduction' + #13 +
                      'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
                    exit;
                  end;
                end; // try .. except
               end
               else
                 log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
                  ' RET CODE: ' + fields[0].AsString);

              except
                on E:Exception do
                begin
                  log.event('SP ERROR - "' + sql[1] + '"' +
                  ' ERR MSG: ' + E.Message);
                    if not data1.blindRun then
                  showMessage('ERROR in Stored Procedure getting Sales Reduction' + #13 +
                    'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
                  exit;
                end;
              end;
              Close;
            end;
            spConn.Close;
          end;
          dmRunSP.Free;
        end; // now the sales reduction data should be in stkTRtemp
      end;


      if (data1.curByHz) then
      begin
        // if there are ANY sales for this period where the terminal IDs are NOT in the terminal IDs
        // assigned to HZs (while the HZ setup IS VALID !?!?!) then it can only be that a terminal ID
        // has been deleted from AztecPOS/Config (and stkHZPOS) which is forbidden. Kill the process...
          PleaseWait(80,'Check POS Validity');
        errStr := 'Check POS validity';

        close;
        sql.Clear;
        sql.Add('select termID, count(distinct FromTrx) as Sls from stkTRtemp');
        sql.Add('where termid not in (select TerminalID from stkhzpos where TerminalID is NOT NULL)');
        sql.Add('and (source = ''S'' or source = ''L'')');
        sql.Add('group by termid');
        open;      

        // ERROR ERROR ERROR!
        if recordcount > 0 then
        begin
          // re-use termids to compose the err msg..
          termids := '';
          i := 0;
          while not eof do
          begin
            termids := termids + FieldByName('termID').asstring + ', ';
            i := i + FieldByName('sls').AsInteger;
            next;
          end;

          log.event('Configuration ERROR - ' + inttostr(recordcount) + ' Tills have ' +
            inttostr(i) + ' sales but the TermID is not in stkHZPOS (' + termids + ')');
            if not data1.blindRun then
          showMessage('ERROR in Pre-Audit process!' + #13 +
            'Error: "There are ' + inttostr(i) + ' Sales where the POS was not found in the system setup".' +
            #13 + #13 + 'Please contact Zonal.');
          exit;
        end;
      end;

        PleaseWait(80,'Get Theo Reduction');
      errStr := 'Get Theo Reduction';
      // add the theoRedQty to stkcrdiv
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET SoldQty = sq."TheoRed", key2 = key2 - 20');
      sql.Add('from');

      if data1.curByHz then
      begin
        sql.Add('(select b.hzid, a.entitycode, sum(a.redqty) as theored');
        sql.Add('from stkTRtemp a, stkhzpos b');
        sql.Add('where a.termid = b.TerminalID');
        sql.Add('and (a.source = ''S'' or a.source = ''D'' or a.source = ''L'')');
        sql.Add('group by b.hzid, a.entitycode) as sq');
      end
      else
      begin
        sql.Add('(SELECT 0 as hzid, a.entitycode, SUM(a.redqty) as TheoRed FROM stkTRtemp a');
        sql.Add(' where (a.source = ''S'' or a.source = ''D'' or a.source = ''L'') GROUP BY a.entitycode) as sq');
      end;

      sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = sq.hzid');
      Execsql;

        PleaseWait(85,'Get Till Waste');
      errStr := 'Get Till Waste';
      // add the Till Waste to stkcrdiv
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET WasteTill = sq."TheoRed", ');
      sql.Add('  key2 = (CASE key2 WHEN 20 THEN 0 WHEN 1020 THEN 1000 ELSE key2 END)');
      sql.Add('from');

      if data1.curByHz then
      begin
        sql.Add('(select b.hzid, a.entitycode, sum(a.redqty * -1) as theored');
        sql.Add('from stkTRtemp a, stkHzPos b');
        sql.Add('where a.termid = b.TerminalID');
        sql.Add('and a.wasteFlag = 1 and (a.source = ''S'' or a.source = ''D'' or a.source = ''L'')');
        sql.Add('group by b.hzid, a.entitycode) as sq');
      end
      else
      begin
        sql.Add('(SELECT 0 as hzid, a.entitycode, SUM(a.redqty * -1) as TheoRed');
        sql.Add('  FROM stkTRtemp a where a.wasteFlag = 1 and (a.source = ''S'' or a.source = ''D'' or a.source = ''L'') GROUP BY a.entitycode) as sq');
      end;

      sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = sq.hzid');
      Execsql;


     // 2. Get Opening Stock and Cost
        PleaseWait(86,'Get Opening ' + data1.SSbig + '...');
      errStr := 'Get Open Qty and Cost';
      dmADO.DelSQLTable('stktouse');

      //   place old stock in stktouse.db
      close;
      sql.Clear;
      sql.Add('SELECT a.* into dbo.stktouse FROM "StkMain" a');
      sql.Add('WHERE a."SiteCode" = '+IntToStr(data1.TheSiteCode));
      sql.Add('AND a."stkCode" = '+IntToStr(data1.PrevStkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      i := execSQL;
        PleaseWait(87,'Get Opening ' + data1.SSbig + '...');

      if i > 0 then
      begin
        // everything OK process StkToUse.DB
        errStr := 'Get Open Qty and Cost 2';
        close;
        sql.Clear;
        sql.Add('UPDATE StkCrDiv SET OpStk = sq."ActCloseStk",');
        sql.Add(' OpCost = sq."ActCloseCost", OpenPrep = sq."ClosePrep", GP = sq.GP');
        sql.Add('from');
        sql.Add(' (SELECT hzid, entitycode, ActCloseStk, ActCloseCost, ClosePrep, ');

        sql.Add('  (CASE');
        sql.Add('    WHEN GP is NULL THEN NULL');
        sql.Add('    WHEN FLOOR(GP / 1000000) = 99 THEN NULL'); // tariff price -- DON'T KEEP
        sql.Add('    WHEN FLOOR(GP / 1000000) = 98 THEN NULL'); // edited tariff price -- DON'T KEEP
        sql.Add('    WHEN FLOOR(GP / 1000000) = 88 THEN GP'); // old price KEEP as is
        sql.Add('    WHEN FLOOR(GP / 1000000) = 87 THEN (GP + 1000000)'); // edited old price, drop the "edited"
        sql.Add('    ELSE 88000000 + GP'); // was typed last time, now is an "old price"
        sql.Add('   END) as GP');


        sql.Add('  FROM StkToUse) as sq');
        sql.Add('where stkcrdiv.entitycode = sq."entitycode" and stkcrdiv.hzid = sq.hzid');
        Execsql;

        // does not include entities that were deleted since last stock

        // HZ processing
        // the old stock will have figures for HZid = 0 regardless if old stock was made by HZ or not.
        // so if this new stock is NOT by HZ then there is no problem...
        // but if the old stock was Site Wide and the new one is by HZs OR the old stock had HZs that are
        // no longer active and/or the new stock has extra HZs compared with the old stock then there is
        // the problem of what to do about the old HZ to new HZ discrepancy.

        // SOLUTION:
        // 1. Do a check to see if OpStk for HZ = 0 is equal to SUM(OpStk) for all current HZs in StkCrDiv
        // 2. If NOT then obviously there was 1 or more HZs in the old stock not transferred to the new
        //    one because the old HZs are now inactive (so not present in this stkCrDiv). This is also
        //    the case if the old stock was done without HZs (so qtys are only in HZid = 0)
        // 3. In this case take the difference and allocate it to the HZ with Purchases (add to qtys already there)
        // 4. In the case of new non-purchase HZs they simply start up with 0 Opening Stock.
        // 5. Opening Cost is the same per site so it doesn't matter...

        if (data1.curByHZ) and (oneHZid = 0) then  // only for proper stocks NOT for oneHZ LC
        begin
          errStr := 'Get Open Qty and Cost 3';
          dmADO.DelSQLTable('#stkGhostOpStk');
          dmADO.DelSQLTable('#stkGhostOpDiff');
          // get the SUM for all HZs
          close;
          sql.Clear;
          sql.Add('select entitycode, sum(opStk) as sumOp, sum(OpenPrep) as sumPrep into #stkGhostOpStk');
          sql.Add('FROM Stkcrdiv where hzid <> 0 group by entitycode');
          execSQL;

          errStr := 'Get Open Qty and Cost 4';
          close;
          sql.Clear;
          sql.Add('select a.entitycode, (a.opstk - b.sumOp) as opDiff,');
          sql.Add('(a.OpenPrep - b.sumPrep) as prepDiff INTO #stkGhostOpDiff');
          sql.Add('from stkcrdiv a, #stkGhostOpStk b');
          sql.Add('where a.entitycode = b.entitycode');
          sql.Add('and a.hzid = 0 and ((a.opstk <> b.sumOp) or (a.OpenPrep <> b.sumPrep))');
          i := execSQL;
          // BTW, the opDiff should NEVER be < 0!!!!!!

          // is there any difference at all?
          if i > 0 then
          begin
              PleaseWait(88,'Get Opening ' + data1.SSbig + '...');
            errStr := 'Get Open Qty and Cost 5';

            // now add the difference in the purch HZ
            close;
            sql.Clear;
            sql.Add('update stkcrdiv set opstk = opstk + sq.opdiff, OpenPrep = OpenPrep + sq.prepDiff');
            sql.Add('from (select entitycode, opdiff, prepDiff from #stkGhostOpDiff) sq');
            sql.Add('where stkcrdiv.entitycode = sq.entitycode');
            sql.Add('and stkcrdiv.hzid = ' + inttostr(data1.purHZid));
            execSQL;
          end;
        end;
      end;

      errStr := 'Get Open Qty and Cost 6';
      close;          // set OpStk = zero where NULL
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET OpStk = 0 where opstk is NULL');
      sql.Add('');
      sql.Add('UPDATE "StkCrDiv" SET OpCost = 0 where opCost is NULL');
      sql.Add('');
      sql.Add('UPDATE "StkCrDiv" SET OpenPrep = 0 where OpenPrep is NULL');
      Execsql;

      // now that the figures from the old stock have been loaded (including the GP which holds
      // typed in Nominal Prices) it's time to load the saved Nominal Prices.
      // These exist only if the [Enter Nom Prices] screen had already been reached once and the
      // user had typed some figures. If these figures overwrite any GP figures from the old stock
      // then that's OK.
      if data1.curNomPrice then
      begin
        try
          errStr := 'Keep Saved Nom Prices';
          close;
          sql.Clear;
          sql.Add('UPDATE "StkCrDiv" SET GP = b.GP');
          sql.Add('FROM "StkCrDiv" a, "#nomp" b');
          sql.Add('where (a."entitycode" = b."entitycode")');
          Execsql;
        except
        end;
      end;

        PleaseWait(90,'Get Purchases');
      errStr := 'Get Purchases';
     // 3. Get Purchases (if this a oneHZ LC then it's OK, stkCrDiv has only the oneHZ to update)

     // when SUM(a."baseqty") = 0  or almost 0 (i.e. rounding errors) then  store the Purch Cost difference as a v. big
     // cost figure with a v. small qty that is multiplied to its true Total Cost value. Use "key2" to flag such fields...
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET PurchStk = sq."PurchStk", PurchCost = sq."PurchCost", key2 = key2 + sq.k2');
      sql.Add('from');
      sql.Add(' (SELECT a."entitycode", ');
      sql.Add('  (CASE ');
      sql.Add('     WHEN (SUM(a."baseqty") > -0.000001 AND SUM(a."baseqty") < 0.000001) THEN (1)');
      sql.Add('     ELSE SUM(a."baseqty")');
      sql.Add('   END) as Purchstk,');
      sql.Add('  (CASE ');
      sql.Add('     WHEN (SUM(a."baseqty") > -0.000001 AND SUM(a."baseqty") < 0.000001) THEN 1');
      sql.Add('     ELSE 0');
      sql.Add('   END) as k2,');
      sql.Add('  (CASE ');
      sql.Add('     WHEN (SUM(a."baseqty") > -0.000001 AND SUM(a."baseqty") < 0.000001) THEN SUM(a."cvalue")');
      sql.Add('     ELSE (SUM(a."cvalue")) / (SUM(a."baseqty"))');
      sql.Add('   END) as PurchCost');
      sql.Add('   FROM "StkPurch" a');
      sql.Add('   GROUP BY a."entitycode"');
      sql.Add('   HAVING (((SUM(a."baseqty") <= -0.000001 OR SUM(a."baseqty") >= 0.000001)) OR (SUM(a."cvalue") <> 0))');
      sql.Add(' ) as sq');
      sql.Add('where stkcrdiv.entitycode = sq."entitycode"');
      sql.Add('and (stkcrdiv.hzid = ' + inttostr(data1.purHZid));
      sql.Add('     or stkcrdiv.hzid = 0)');
      Execsql;

      errStr := 'Get Purchases 2';
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('"PurchStk" = "PurchStk" / 100000, PurchCost = PurchCost * 100000');
      sql.Add('where key2 in (1,21)');
      ExecSQL;

      if data1.curByHZ then
      begin
          PleaseWait(91,'Summarize Internal Transfer Data.');
        errStr := 'Get Transfers';
        // bring in the MoveIn/MoveOut qtys per HZ....
        // first select all moveins with positive sign into #ghostIN
        dmADO.DelSQLTable('#ghostIN');
        dmADO.DelSQLTable('#ghostOUT');
        dmADO.DelSQLTable('#ghost');
        close;
        sql.Clear;
        sql.Add('select b.hzIDDest, a.entitycode, sum(a.qty) as qtyin INTO #ghostIN');
        sql.Add('from stkHZMprods a, stkHZmoves b');
        sql.Add('where b.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
        sql.Add('and b.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
        sql.Add('and a.moveid = b.moveid');
        sql.Add('group by b.hzIDDest, a.entitycode');
        execSQL;

        errStr := 'Get Transfers 1';
        // then select all moveouts with negative sign into #ghostOUT
        close;
        sql.Clear;
        sql.Add('select b.hzIDSource, a.entitycode, sum(-1 * a.qty) as qtyout INTO #ghostOUT');
        sql.Add('from stkHZMprods a, stkHZmoves b');
        sql.Add('where b.MoveDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
        sql.Add('and b.MoveDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
        sql.Add('and a.moveid = b.moveid');
        sql.Add('group by b.hzIDSource, a.entitycode');
        execSQL;

          PleaseWait(92,'Include Internal Transfer Data.');
        errStr := 'Get Transfers 2';
        // bring it all toghether in #ghost
        close;
        sql.Clear;
        sql.Add('SELECT a.hzIDDest, a.entitycode, a.qtyin, b.qtyout, b.entitycode AS entout, b.hzIDSource');
        sql.Add('into #ghost  FROM #ghostIN a FULL OUTER JOIN');
        sql.Add('  #ghostOUT b ON a.hzIDDest = b.hzIDSource AND a.entitycode = b.entitycode');
        sql.Add('');   // process ghost
        sql.Add('Update #ghost set hziddest = hzidsource, entitycode = entout where hziddest is NULL');
        sql.Add('');
        sql.Add('Update #ghost set qtyin = 0 where qtyin is NULL');
        sql.Add('');
        sql.Add('Update #ghost set qtyout = 0 where qtyout is NULL');
        execSQL;

        // finally add the sum per hzid/entity into StkCrDiv
        errStr := 'Get Transfers 3';
        close;
        sql.Clear;
        sql.Add('update stkcrdiv set moveQty = sq.Qty');
        sql.Add('from (');
        sql.Add('  select a.hzidDest, a."entitycode", sum(a.qtyin + a.qtyout) as Qty');
        sql.Add('  from "#Ghost" a');
        sql.Add('  group by a.hzidDest, a."entitycode") sq'); // is group by really needed???
        sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = sq.hzidDest');
        i := execSQL;
        log.event('Data Proc: Added HZ Moves: ' + inttostr(i) + ' records');
      end;


     // 4. Get PCWaste
        PleaseWait(93,'Add PC wastage...');
      errStr := 'Get PC wastage';

      dmADO.DelSQLTable('#Ghost');

      // take the waste records for the period from stkTRtemp and place in ghost
      close;
      sql.Clear;
      sql.Add('SELECT a.termid as hzid, a.EntityCode, (a.RedQty) as baseWaste');
      sql.Add('INTO #ghost');
      sql.Add('FROM stkTRtemp a');
      sql.Add('where (a.source <> ''S'' and a.source <> ''D'' and a.source <> ''L'')');
      if (data1.curByHz) and (onehzid <> 0) then
      begin
        if oneHZePur then
        begin
          sql.Add('and ((a.termid = 0) or (a.termid = ' + inttostr(onehzid) + '))');
        end
        else
        begin
          sql.Add('and a.termid = ' + inttostr(onehzid));
        end;
      end;
      execSQL;

      errStr := 'Get PC Waste 1';
      close;
      sql.Clear;
      sql.Add('update stkcrdiv set WastePC = sq.Qty');
      sql.Add('from (');
      sql.Add('  select a.hzid, a."entitycode", sum(a."baseWaste") as Qty');
      sql.Add('  from "#Ghost" a');
      sql.Add('  group by a.hzid, a."entitycode"');
      sql.Add('  having sum(a."baseWaste") <> 0) sq');
      sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = sq.hzid');
      i := execSQL;
      log.event('Data Proc: Added PC waste: ' + inttostr(i) + ' records');

      // get PrepItem waste if any...
      dmADO.DelSQLTable('#WasteGhost');

      close;
      sql.Clear;
      sql.Add('select p.hzid, p.[EntityCode], SUM(p.WValue * p.BaseUnits) as TotWasteBU');
      sql.Add('INTO #WasteGhost');
      sql.Add('FROM [stkPCWaste] p');
      sql.Add('where p.WasteFlag = ''P'' and p.Deleted = 0');
      sql.Add('and p.WasteDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
      sql.Add('and p.WasteDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
      sql.Add('Group By p.hzid, p.[EntityCode]');
      execSQL;

      errStr := 'Get PC Waste 1 pi';
      close;
      sql.Clear;
      sql.Add('update stkcrdiv set WastePC = sq.Qty');
      sql.Add('from (');
      sql.Add('  select a.hzid, a."entitycode", sum(a."TotWasteBU") as Qty');
      sql.Add('  from "#WasteGhost" a');
      sql.Add('  group by a.hzid, a."entitycode"');
      sql.Add('  having sum(a."TotWasteBU") <> 0) sq');
      sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = sq.hzid');
      i := execSQL;
      log.event('Data Proc: Added PC PrepItem waste: ' + inttostr(i) + ' records');

      if data1.curByHZ then
      begin
        errStr := 'Get PC Waste 2';
        // wastePC could be BOTH byHZ and by Site
        // if there's any pcwaste done per site (hzid = 0) then put in the purchase hzid...
        close;
        sql.Clear;
        sql.Add('update stkcrdiv set wastepc = stkCrDiv.wastepc + sq.Qty');
        sql.Add('from (');
        sql.Add('  select a.hzid, a."entitycode", sum(a."baseWaste") as Qty');
        sql.Add('  from "#Ghost" a');
        sql.Add('  where a.hzid = 0');
        sql.Add('  group by a.hzid, a."entitycode"');
        sql.Add('  having sum(a."baseWaste") <> 0) sq');
        sql.Add('where stkcrdiv.entitycode = sq.entitycode');
        sql.Add('and stkcrdiv.hzid = ' + inttostr(data1.purHZid));
        execSQL;

        // do the same for the PrepItem waste if any...
        close;
        sql.Clear;
        sql.Add('update stkcrdiv set WastePC = stkCrDiv.wastepc + sq.Qty');
        sql.Add('from (');
        sql.Add('  select a.hzid, a."entitycode", sum(a."TotWasteBU") as Qty');
        sql.Add('  from "#WasteGhost" a');
        sql.Add('  where a.hzid = 0');
        sql.Add('  group by a.hzid, a."entitycode"');
        sql.Add('  having sum(a."TotWasteBU") <> 0) sq');
        sql.Add('where stkcrdiv.entitycode = sq.entitycode ');
        sql.Add('and stkcrdiv.hzid = ' + inttostr(data1.purHZid));
        execSQL;

        // now SUM UP Sales, Wastage per hzid and add it to hzid = 0
        // (any pcwaste already there will be overwritten) but only for proper site wide stocks
        if onehzid = 0 then
        begin
          errStr := 'Get PC Waste 3';
          close;
          sql.Clear;
          sql.Add('update stkCrDiv set SoldQty = sq.SoldQty, wastetill = sq.wastetill,');
          sql.Add('  wastepc = sq.wastepc, wastage = sq.wastage');
          sql.Add('from');
          sql.Add('  (select a.entitycode, sum(a.SoldQty) as SoldQty,');
          sql.Add('    sum(a.wastetill) as wastetill, sum(a.wastepc) as wastepc, sum(a.wastage) as wastage');
          sql.Add('   from stkCrDiv a where a.hzid > 0');
          sql.Add('   group by a.entitycode) sq');
          sql.Add('where stkCrDiv.hzid = 0 and stkCrDiv.entitycode = sq.entitycode');
          execSQL;
        end;
      end;

     // 5. All data in StkCrDiv

      errStr := 'Avoid SoldQty rounding errors';
      Close;           // for v. small Sold Qty due to rounding errors
      sql.Clear;      // (e.g. sell 5 times one item then correct 5 items at once somtimes ends up 0.0000000000233)
      sql.Add('UPDATE StkCrDiv SET SoldQty = 0');
      sql.Add('WHERE (SoldQty > -0.000001 AND SoldQty < 0.000001)');
      ExecSQL;

      errStr := 'Calc Theo Close';
      close;
      sql.Clear;
      sql.Add('UPDATE "StkCrDiv" SET ');
      sql.Add('ThRedQty = SoldQty + WasteTill + WastePC,');
      sql.Add('Wastage = WasteTill + WastePC,');
      sql.Add('ThCloseStk = OpStk + PurchStk + MoveQty - SoldQty - WasteTill - WastePC');
      ExecSQL;


     // 6. Depending on getCosts get Theo Costs -- assumes the PrepItems qtys stay the same
      if getCosts then
      begin
        errStr := 'Call FIFOCosts';
        FIFOCost(False); // calculate FIFO ThRedCost & ThCloseCost.

        // if byHZ distribute Open/Close/Reduction costs from site wide to HZ's
        if data1.curByHZ then
        begin
          errStr := 'Distribute Costs';
            PleaseWait(99,'Distribute Costs...');
          dmADO.DelSQLTable('#ghost');

          // get the site costs in ghost...
          close;
          sql.Clear;
          sql.Add('select entitycode, opcost, ThCloseCost, ThRedCost INTO #ghost from stkCrDiv where hzid = 0');
          execSQL;

          // now update all like this...
          errStr := 'Costs by HZ';
          close;
          sql.Clear;
          sql.Add('update stkcrdiv set opcost = sq.opcost, ThCloseCost = sq.ThCloseCost, ThRedCost = sq.ThRedCost');
          sql.Add('from (');
          sql.Add('  select * ');
          sql.Add('  from "#Ghost") sq');
          sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid > 0');
          execSQL;
        end;
      end;
      Result := True;
    except
      on E:Exception do
      begin
          log.event('ERROR - Pre-Audit "' + errStr + '" ERR MSG: ' + E.Message);
          if not data1.blindRun then
        showMessage('ERROR in Pre-Audit process (' + errstr + ')!' + #13 +
          'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
        exit;
      end;
    end; // try .. except
  end; // with data1.adoqRun
    PleaseWait(100,'Pre-Audit Processing Finished.');
  finally
    if fwait <> nil then fwait.free;
  end;
end;

///////////  CC  //////////////////////////////////////////////////////////////
//  Date: 6 SEP 2004
//  Inputs: None
//  Outputs: None directly; Main output is data in the tables stkCrDiv and stkCrSld.
///////////////////////////////////////////////////////////////////////////////
function TdataProc.PostAudit: boolean;
var
  s1 : string;
  i : integer;
begin
  Result := False;
  if not data1.blindRun then
  begin
  fwait := Tfwait.Create(self);
  fwait.Show;
  end;

  try
    PleaseWait(1,'Post Audit.');

  // by this time the stkCrDiv table already has the Audited Qty for each ingredient
  with data1.adoqRun do
  begin
    try
      errStr := 'Eliminate rounding errors';
        PleaseWait(5,'Audited Figures Loaded');
      Close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET ');
      sql.Add('ActCloseStk = (OpStk + PurchStk + MoveQty)');
      sql.Add('WHERE ((OpStk + PurchStk - ActCloseStk + MoveQty) > -0.00001)');
      sql.Add('AND ((OpStk + PurchStk - ActCloseStk + MoveQty) < 0.00001)');
      sql.Add('and not (key2 in (1,21))');
      sql.Add('AND NOT (AuditStk = 0 and ((OpStk + PurchStk + MoveQty < 0.000001)');
      sql.Add('                           and (OpStk + PurchStk + MoveQty > -0.000001)))');
      ExecSQL;

        PleaseWait(7,'Filter Audited Figures');
      errStr := 'Kill inert Prep Items';
      close;
      sql.Clear;
      sql.Add('Delete From stkcrdiv');
      sql.add('Where Key2 >= 1000');
      sql.Add('    and (OpStk = 0.0 and ActCloseStk = 0.0)');
      ExecSql;

        PleaseWait(10,'Calc. Prepared Items');
      errStr := 'Split Prep Items';
      PrepItemQtyToIngredients;

        PleaseWait(18,'Calc. Actual Reduction');
      errStr := 'Calc. Actual Reduction';
      Close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET ');
      sql.Add('ActRedQty = (OpStk + PurchStk - ActCloseStk + MoveQty),');
      sql.Add('ThRedQty = (SoldQty + Wastage)'); // this accounts for any waste adjustments ...
      ExecSQL;

      // override actual reductions for small opening quantities where user has explicitly entered 0
      Close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv ');
      sql.Add('SET ActRedQty = 0.0');
      sql.Add('WHERE (AuditStk = 0 and ((OpStk + PurchStk + MoveQty < 0.000001)');
      sql.Add('                           and (OpStk + PurchStk + MoveQty > -0.000001)))');
      ExecSQL;

       PleaseWait(20,'Calculate Actual Costs');
      errStr := 'Calc. Costs';
     FIFOCost(true);

     // Calculate "INTERNAL" reduction costs, using the Prepared Qtys as if they are still on the shelf...
       PleaseWait(28,'Set True Reduction Costs.');
     close;
     sql.Clear;
     sql.Add('UPDATE "StkCrDiv" SET ');
     sql.Add('TrueRedCost = (CASE ');
     sql.Add('      WHEN (ActRedQty + PRepRedQty) = 0 THEN isNULL(OpCost, 0)');
     sql.Add('      WHEN (ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost) THEN isNULL(OpCost, 0)');
     sql.Add('      WHEN ((ActRedQty + PRepRedQty) between -0.000001 and 0.000001) and (ActRedCost > 0) THEN ActRedCost');
     sql.Add('      WHEN ((ActRedQty + PRepRedQty) between -0.000001 and 0.000001) and (ActRedCost = 0) THEN isNULL(OpCost, 0)');
     sql.Add('      ELSE ((isNULL(OpCost, 0) * (OpStk + OpenPrep)) + (PurchStk * isNULL(PurchCost, 0)) - ');
     sql.Add('           (isNULL(ActCloseCost, 0) * (ActCloseStk + ClosePrep))) / (ActRedQty + PRepRedQty) END)');
     sql.Add('where hzid = 0 and key2 < 1000');
     ExecSQL;

     // if byHZ distribute Open/Close/Reduction costs from site wide to HZ's
     if data1.curByHZ then
     begin
         PleaseWait(29,'Distribute Costs...');
       dmADO.DelSQLTable('#ghost');
       errStr := 'Distribute Costs';

       // get the site costs in ghost...
       close;
       sql.Clear;
       sql.Add('select entitycode, ActCloseCost, ActRedCost INTO #ghost from stkCrDiv where hzid = 0');
       execSQL;

       errStr := 'Distribute Costs 2';
       // now update all like this...
       close;
       sql.Clear;
       sql.Add('update stkcrdiv set ActCloseCost = sq.ActCloseCost, ActRedCost = sq.ActRedCost');
       sql.Add('from (');
       sql.Add('  select * ');
       sql.Add('  from "#Ghost") sq');
       sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid > 0');
       execSQL;

       errStr := 'Transfer Costs';
       // Calculate MoveCosts per hzid (though they are just make believe figures...)
       close;
       sql.Clear;
       sql.Add('UPDATE "StkCrDiv" SET ');
       sql.Add('"moveCost" = ABS(((ActRedQty * ActRedCost) - (opStk * opCost) - (PurchStk * purchCost) + ' +
         '(ActCloseStk * ActCloseCost)) / MoveQty)');
       sql.Add('where MoveQty <> 0');
       execSQL;
     end;

     // give closing costs to Prepared Items
     close;
     sql.Clear;
     sql.Add('update stkCrDiv set ActCloseCost = sq.Cost');
     sql.Add('from');
     sql.Add(' (select p.hzid, p.PreparedItem, sum(p.Ratio * s.ActCloseCost) as Cost');
     sql.Add('  from [#PreparedItemSplit] p, stkCrDiv s');
     sql.Add('  where p.hzid = s.hzid and p.ingredient = s.entitycode');
     sql.Add('  group by p.hzid, p.PreparedItem) sq');
     sql.Add('where stkCrDiv.hzid = sq.hzid and stkCrDiv.entitycode = sq.PreparedItem');
     execSQL;


     dmADO.EmptySQLTable('stkCrSld');

     if not data1.noTillsOnSite then
     begin
       // calculate NomPrices and Retail Costs results in stkCrDiv and stkCrSld...
         PleaseWait(30,'Calc. Nom Price & Retail Cost');
       errStr := 'Calc. Nom Price & Retail Cost';

       if data1.curByHZ then
         s1 := '1, '
       else
         s1 := '0, ';

       if data1.ssDebug then
         s1 := s1 + '1'
       else
         s1 := s1 + '0';

       dmRunSP := TdmRunSP.Create(self);
       with dmRunSP do
       begin
         //spConn.ConnectionString := dmADO.AztecConn.ConnectionString;
         spConn.Open;

         with adoqRunSP do
         begin
           close;
           sql.Clear;
           sql.Add('exec stkSP_RetCost_NomPrice ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.SDT)) +
                ', ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', data1.EDT)) + ', ' +
                quotedStr(data1.TheDiv) + ', ' + s1);
           dt1 := Now;

           try
             execSQL;
             log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' +
                sql[0] + '"');
           except
             on E:Exception do
             begin
               log.event('SP ERROR - "' + sql[0] + '"' +
               ' ERR MSG: ' + E.Message);
                 if not data1.blindRun then
               showMessage('ERROR Calculating Retail Cost and Nominal Prices!' + #13 +
                 'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
               exit;
             end;
           end;
         end;
         spConn.Close;
       end;
       dmRunSP.Free;

  ////////////////////////////////////////////////////////////////////////////////////////////////////
      // ask user to set Nom Prices where 0 or NULL
      // any previously entered and saved NomPrices will be in field GP
      // ONLY FOR THE WHOLE SITE
         PleaseWait(60,'Nom Price checking');
       errStr := 'Nom Price checking';
      if data1.autoSlaveStk then
      begin
       errStr := 'Master Nom Price check';
        getMThNomPrices;
      end
      else if data1.curNomPrice then
      begin
         dmAdo.EmptySQLTable('auditcur');

         with data1.adoqRun do
         begin
           close;
           sql.Clear;
           sql.Add('insert into auditcur ("entitycode", "name", "subcat",');
           sql.Add('"ImpExRef", OpStk, WasteTill,'); // use opstk and wasteTill for closing stk and cost
           sql.Add('PurchStk, WastePC,');       // use purchstk and wastePC for Act Red Qty and cost
           sql.Add('ThRedQty, "purchunit", "purchbaseU", ActCloseStk, WasteTillA)');

           sql.Add('SELECT b."entitycode", b."purchasename",');
           if data1.RepHdr = 'Sub-Category' then
             sql.Add('(b.[SCat]) as SubCatName, b."ImpExRef",')
           else
             sql.Add('(b.[Cat]) as SubCatName, b."ImpExRef",');
           sql.Add('(a."actCloseStk" / a."purchbaseU") as OpStk,');
           sql.Add('(a."actCloseCost" * a."purchbaseU") as OpCost,');
           sql.Add(' (CASE ');
           sql.Add('    WHEN ((a."key2" = 1055) or (a."key2" = 55)) THEN -888888'); // 17841 - NEW Items
           sql.Add('    ELSE (a."ActRedQty" / a."purchbaseU")');                  // NORMAL items
           sql.Add('  END) as PurchStk,');
           sql.Add('(a."ActRedCost" * a."purchbaseU") as PurchCost,');
                                                                      // 17841 use ThRedQty to signal PrepItems
           sql.Add(' (CASE ');
           sql.Add('    WHEN (a."key2" < 1000) THEN (a."ThRedQty" / a."purchbaseU")'); // NORMAL items
           sql.Add('    ELSE -999999');                                                // 17841 - Prep.Items
           sql.Add('  END) as ThRedQty,');
           sql.Add('a."purchunit", a."purchbaseU",');
           sql.Add('(a."purchbaseU" * ');
           sql.Add('  (CASE');
           sql.Add('    WHEN FLOOR(a.GP / 1000000) = 99 THEN a.GP - 99000000'); // tariff price
           sql.Add('    WHEN FLOOR(a.GP / 1000000) = 88 THEN a.GP - 88000000'); // old price
           sql.Add('    ELSE a.GP');
           sql.Add('   END)) as SvNomPrice,');
           sql.Add('  (CASE');
           sql.Add('    WHEN FLOOR(a.GP / 1000000) = 99 THEN -999999'); // tariff price
           sql.Add('    WHEN FLOOR(a.GP / 1000000) = 88 THEN -888888'); // old price
           sql.Add('    ELSE NULL');
           sql.Add('   END) as wasteTillA');
           sql.Add('FROM "StkCrDiv" a, "stkEntity" b');
           sql.Add('WHERE a."entitycode" = b."entitycode"');
           sql.Add('and (a."nomprice" is NULL)');
           sql.Add('and (   (a."OpStk" <> 0)');
           sql.Add('     or (a."actCloseStk" <> 0)');
           sql.Add('     or (a."PurchStk" <> 0)');
           sql.Add('     or (a."SoldQty" <> 0)');
           sql.Add('     or (a."Wastage" <> 0))');
           sql.Add('and a.hzid = 0');

           i := execSQL;
            PleaseWait(64,'Nominal Price');

           if i > 0 then
           begin

             // get Tarrif prices for Strd.Line items without nom price...
             // put prices in Ghost with date effective smaller than curr stock
             dmADO.DelSQLTable('#Ghost');


              PleaseWait(65,'Get Prices');
             close;
             sql.clear;

             sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#TariffPrices''))');
             sql.Add('   DROP TABLE #TariffPrices');
             sql.Add(' ');

             sql.Add('CREATE TABLE #TariffPrices (');
             sql.Add('  	SalesAreaCode Int not null,');
             sql.Add('  	ProductID     BigInt not null,');
             sql.Add('  	PortionTypeID Int not null,');
             sql.Add('  	TariffPrice   Money null)');
             sql.Add('INSERT #TariffPrices');
             sql.Add('EXEC sp_TariffPrices ''' + formatdatetime('mm/dd/yy', data1.sdate) + ''',' + inttostr(data1.TheSiteCode));
             sql.Add('ALTER TABLE #TariffPrices ADD PRIMARY KEY CLUSTERED (SalesAreaCode, ProductID, PortionTypeID)');

             sql.Add('select a.* into [#ghost] from auditcur b,');

             sql.Add('(SELECT [SalesAreaCode], [ProductID] as EntityCode, [TariffPrice] ');
             sql.Add(' FROM #TariffPrices p');
             sql.Add(' INNER JOIN ');
             sql.Add('  (SELECT DISTINCT [Sales Area Code] FROM [dbo].[Config] ');
             sql.Add('    WHERE [Site Code] = ' + inttostr(data1.TheSiteCode));
             sql.Add('    AND ISNULL([DELETED], ''N'') = ''N''');
             sql.Add('    AND [Sales Area Code] IS NOT NULL) sas ');
             sql.Add(' ON p.[SalesAreaCode] = sas.[Sales Area Code] ');
             sql.Add(' WHERE p.[PortionTypeID] = 1) a ');

             sql.Add('where a.entitycode = b.entitycode');
             sql.Add('and (b.ActCloseStk is NULL) ');
             sql.Add('and a.TariffPrice <> 0 and a.TariffPrice is not NULL');
             sql.Add('order by a."salesareacode", a.entitycode  DESC');
             execSQL;


              PleaseWait(67,'Load Prices');
             // divide theoPrice by stdBaseSize and then mult. by purchBaseU when updating auditCur...
             close;
             sql.clear;
             sql.Add('update auditcur');                                                // tarrif price "flag"
             sql.Add(' set actclosestk = sq.[nomprice] * [purchbaseu], wasteTillA = -999999');
             sql.Add('from (select a."entitycode", (a.TariffPrice / e.[RcpQty]) as nomPrice');
             sql.Add('      from (select entitycode, max("TariffPrice") as TariffPrice ');
             sql.Add('            from [#ghost] group by entitycode) a, stk121Rcp e');
             sql.Add('      where e.[Parent] = a.entitycode');
             sql.Add('      and e.[PPortion] = 1');
             sql.Add('      and e.[Parent] = e.[Child]) sq');
             sql.Add('where auditcur.entitycode = sq."entitycode"');
             execSQL;

             // Tarrif prices got, continue...



              PleaseWait(68,'Nominal Price');

             close;
             sql.Clear;
             sql.Add('update auditcur set PurchStk = NULL, WastePC = NULL where ThRedQty = -999999 and PurchStk <> -888888');
             execSQL;

             fSetNom := TfSetNom.Create(self);

             if fSetNom.ShowModal = mrOK then
             begin
               // save the nominal prices (div by purchbaseU) to stkcrdiv....
               errStr := 'Load New Nom Prices';
               close;
               sql.Clear;
               sql.Add('update stkcrdiv set NomPrice = sq.NomPrice,');
               sql.Add(' GP = ');
               sql.Add('  (CASE');
               sql.Add('    WHEN sq.wastetillA = -999999 THEN 99000000 + sq.NomPrice'); // tariff price
               sql.Add('    WHEN sq.wastetillA = -888888 THEN 88000000 + sq.NomPrice'); // old price
               sql.Add('    ELSE sq.NomPrice');
               sql.Add('   END)');
               sql.Add('from (');
               sql.Add('  SELECT a."entitycode", (a."actclosestk" / a."purchbaseU") as NomPrice, wastetilla');
               sql.Add('  FROM "auditcur" a) sq');
               sql.Add('where stkcrdiv.entitycode = sq.entitycode');
               execSQL;
             end;
             fSetNom.Free;
           end;
         end;
      end;

  ////////////////////////////////////////////////////////////////////////////////////////////////////

        PleaseWait(70,'Ingredients with no Sold Recipes...');

      dmADO.DelSQLTable('stkOrphan'); // get orphans (now includes Strd.Line)
        errStr := 'Find Orphans';

      close;
      sql.Clear;
      sql.Add('select a.hzid, a."entitycode", a."purchbaseu", a."opStk", a."opCost", a."PurchStk", a."purchCost",');
      sql.Add('a."ActCloseStk", a."ActCloseCost", a."ActRedQty", a."ActRedCost", a."purchUnit"');
      sql.Add('into dbo.stkOrphan from stkcrdiv a, stkEntity b');
      if data1.curByHZ then
      begin
        sql.Add('where (a.entitycode + (1000000000000 * a.hzid)) not in ');
        sql.Add('  (select distinct (t.entitycode + (1000000000000 * h.hzid))');
        sql.Add('   from stkTRtemp t, stkHzPos h where t.Termid = h.TerminalID');
        sql.Add('   group by t.entitycode, h.hzid having sum(t.redQty) <> 0)');
        sql.Add('and a.hzid > 0');
      end
      else
      begin
        sql.Add('where a. entitycode not in ' +
                 '(select entitycode from stktrtemp group by entitycode having sum(redQty) <> 0)');
      end;
      sql.Add('and a.entitycode = b.entitycode');
      sql.Add('and ((a."opStk" * a."opCost") + (a."PurchStk" * a."purchCost") - ');
      sql.Add('    (a."ActCloseStk" * a."ActCloseCost")) <> 0 and a.key2 < 1000');  // ignore PRepItems...
      execSQL;

        errStr := 'Find Orphans 2';
      // put orphans in StkCrSld..
        PleaseWait(71,'Ingredients with no Sold Recipes...');
      close;
      sql.Clear;
      sql.Add('INSERT into stkCrSld (hzid, entitycode, ProductType, SalesQty, Income, ActCost, TheoCost, VATRate, Portion)');
      sql.Add('SELECT a.hzid, a."entitycode", ('+#39+'Z'+#39+') as non,');
      sql.Add('(a."ActRedQty" / a."purchbaseu") as ActRedQty, 0,');
      sql.Add('(a."ActRedCost" * a."purchbaseu") as ActRedCost,0 , 0, -1');
      sql.Add('FROM "StkOrphan" a');
      execSQL;

        errStr := 'Find Orphans 3';
      // update StkCrDiv to mark up orphans
        PleaseWait(75,'Ingredients with no Sold Recipes...');
      close;
      sql.Clear;
      sql.Add('update stkCrDiv set TheoPrice = -99999');
      sql.Add('from stkCrDiv a, stkOrphan b');
      sql.Add('where a.entitycode = b.entitycode and a.hzid = b.hzid');
      execSQL;
      // Wrong Recipe Items (Sold but with no children of their own) DONE in the SP

      if data1.curByHZ then
      begin
          PleaseWait(80,'Summarize per site...');
        errStr := 'Summarize per site';
        // now SUM/AVG UP figures per hzid and add it to hzid = 0
        close;
        sql.Clear;
        sql.Add('insert stkCrSld ([HzID], [EntityCode], [Portion], [ProductType], [StdBaseSize], [SalesQty],');
        sql.Add('  [Income], [TheoCost], [ActCost], [IngPrice], VATRate)');
        sql.Add('select (0), [EntityCode], [Portion], [ProductType], max([StdBaseSize]),');
                                 // temporarily store some figures * SoldQty, divide later
        sql.Add('   SUM([SalesQty]), SUM([Income]), SUM([TheoCost] * [SalesQty]), ');
        sql.Add('   SUM([ActCost] * [SalesQty]), SUM([IngPrice] * [SalesQty]), SUM([VATRate])');
        sql.Add('   from stkCrSld where hzid > 0');
        sql.Add('   group by entitycode, portion, producttype');
        execSQL;

          PleaseWait(82,'Summarize per site...');
        // now divide by SoldQty
        errStr := 'Summarize per site 2';
        Close;
        sql.Clear;
        sql.Add('update stkCrSld set [AvSalesPrice] = [Income] / [SalesQty],');
        sql.Add('  [TheoCost] = [TheoCost] / [SalesQty],');
        sql.Add('  [ActCost] = [ActCost] / [SalesQty],');
        sql.Add('  [IngPrice] = [IngPrice] / [SalesQty]');
        sql.Add('where [SalesQty] <> 0 and hzid = 0');
        execSQL;

          PleaseWait(84,'Summarize per site...');
        errStr := 'Summarize per site 3';
        Close;
        sql.Clear;
        sql.Add('update stkCrSld set [AvSalesPrice] = 0,');
        sql.Add('  [TheoCost] = 0, [ActCost] = 0, [IngPrice] = 0');
        sql.Add('where [SalesQty] = 0 and hzid = 0');
        execSQL;

        // do the same for stkCrSldChoice
          PleaseWait(85,'Summarize per site...');
        errStr := 'Summarize per site 4';
        // now SUM/AVG UP figures per hzid and add it to hzid = 0
        close;
        sql.Clear;
        sql.Add('insert stkCrSldChoice ([HzID], [EntityCode], [Portion], [Choice], [ProductType], ');
        sql.Add('  [SalesQty], [Income], [TheoCost], [ActCost], [VATRate])');
        sql.Add('select (0), [EntityCode], [Portion], [Choice], [ProductType],');
                                 // temporarily store some figures * SoldQty, divide later
        sql.Add('   SUM([SalesQty]), SUM([Income]), SUM([TheoCost] * [SalesQty]), ');
        sql.Add('   SUM([ActCost] * [SalesQty]), SUM([VATRate])');
        sql.Add('   from stkCrSldChoice where hzid > 0');
        sql.Add('   group by entitycode, portion, [Choice], producttype');
        execSQL;

          PleaseWait(86,'Summarize per site...');
        // now divide by SoldQty
        errStr := 'Summarize per site 5';
        Close;
        sql.Clear;
        sql.Add('update stkCrSldChoice set [AvSalesPrice] = [Income] / [SalesQty],');
        sql.Add('  [TheoCost] = [TheoCost] / [SalesQty],');
        sql.Add('  [ActCost] = [ActCost] / [SalesQty]');
        sql.Add('where [SalesQty] <> 0 and hzid = 0');
        execSQL;

          PleaseWait(87,'Summarize per site...');
        errStr := 'Summarize per site 6';
        Close;
        sql.Clear;
        sql.Add('update stkCrSldChoice set [AvSalesPrice] = 0,');
        sql.Add('  [TheoCost] = 0, [ActCost] = 0');
        sql.Add('where [SalesQty] = 0 and hzid = 0');
        execSQL;
      end;

        PleaseWait(88,'Calculate Retail COS%');
       errStr := 'Retail COS 1';

      close;
      sql.Clear;
      sql.Add('update stkcrsld set [cos%] = ');
      sql.Add(' (CASE');
      sql.Add('     WHEN TheoCost = 0 THEN (Income - vatRate)');
      sql.Add('     ELSE ((Income - vatRate) * (1 - (ActCost / TheoCost))) + ' +
                    '(SalesQty * (ActCost - TheoCost))');
      sql.Add('   END)');
      sql.Add('where [income] <> 0');
      Execsql;

        PleaseWait(90,'Calculate Retail COS%');
       errStr := 'Retail COS 2';
      close;
      sql.Clear;
      sql.Add('update stkcrsld set [cos%] = (TheoCost * salesQty) - (ActCost * salesQty)');
      sql.Add('where [income] = 0');
      Execsql;

        PleaseWait(92,'Calculate Retail COS%');
       errStr := 'Retail COS 3';
      close;
      sql.Clear;
      sql.Add('update stkcrsldchoice set [cos%] = ');
      sql.Add(' (CASE');
      sql.Add('     WHEN TheoCost = 0 THEN (Income - vatRate)');
      sql.Add('     ELSE ((Income - vatRate) * (1 - (ActCost / TheoCost))) + ' +
                    '(SalesQty * (ActCost - TheoCost))');
      sql.Add('   END)');
      sql.Add('where [income] <> 0');
      Execsql;

        PleaseWait(93,'Calculate Retail COS%');
       errStr := 'Retail COS 4';
      close;
      sql.Clear;
      sql.Add('update stkcrsldchoice set [cos%] = (TheoCost * salesQty) - (ActCost * salesQty)');
      sql.Add('where [income] = 0');
      Execsql;
    end; // if not data1.noTillsOnSite


    errStr := 'Calc LG, COS%';
      PleaseWait(95,'Calculate GP, COS, Loss/Gain, etc...');
    close;     // calculate gross profit, cost of sales %, and Loss/Gain
    sql.Clear;
    sql.Add('UPDATE "StkCrDiv" SET ');
    sql.Add('"lossgain" = "SoldQty" - "prepredqty" - "ActRedQty"');
    ExecSQL;

    errStr := 'Calc LG, COS% 2';
      PleaseWait(98,'Calculate GP, COS, Loss/Gain, etc...');
    close;      // make all nomprice = 0 if NULL
    sql.Clear;
    sql.Add('update stkcrdiv set nomprice = 0 where nomprice is null');
    Execsql;

    close;
    sql.Clear;
    sql.Add('UPDATE "StkCrDiv" SET ');
    sql.Add('"COS%" = (CASE WHEN (("NomPrice" - "VATRate") * SoldQty) = 0 THEN 100');
    sql.Add('         ELSE 100 * ((opStk * opCost) + (PurchStk * purchCost) - ' +
            '(ActCloseStk * ActCloseCost) + (moveQty * moveCost)) / (("NomPrice" - "VATRate") * SoldQty) END)');
    ExecSQL;


    Result := True;
    except
      on E:exception do
      begin
        log.event('ERROR in Post Audit (' + errstr + ') ErrMsg: ' + E.Message);
        screen.Cursor := crDefault;
          if not data1.blindRun then
        showmessage('ERROR while Calculating with Actual Figures (' + errstr + ')' + #13 +
          #13 + 'Error Msg: ' + E.Message + #13 + #13 +'Please contact Zonal.');
      end;
    end; // try .. except
  end; // with data1.adoqRun
    PleaseWait(100,'Post Audit Processing Finished.');
  finally
    if fwait <> nil then fwait.free;
  end;
end;

procedure TdataProc.PrepItemQtyToIngredients;
begin   // 11..17
  // take each PRepItem Close Qty and split to its FINAL ingredients
  // save result in PReparedItemsSplit table
  // sum up per ingredient and save it in ClosePrep in stkCrDiv

  with TADOQuery.Create(self) do
  begin
    try
      Connection := dmADO.AztecConn;

      dmADO.DelSQLTable('#PreparedItemSplit');

      close;
      sql.Clear;
      sql.Add('select s.hzid, s.entitycode as PreparedItem,');
      sql.Add('p.BatchUnit, p.BatchSize, r.child as Ingredient, r.RcpQty as Ratio,  r.RcpQty as oldRatio,');
      sql.Add('s.OpStk as OpToSplit, (s.OpStk * r.RcpQty) as OpenSplit,');
      sql.Add('s.ActCloseStk as CloseToSplit, (s.ActCloseStk * r.RcpQty) as CloseSplit,');
      sql.Add('(s.OpStk - s.ActCloseStk) as PrepVariance,');
      sql.Add('((s.OpStk - s.ActCloseStk) * r.RcpQty) as Adjustment');
      sql.Add('INTO [#PreparedItemSplit]   FROM stkCrDiv s, PreparedItemDetail p, stk121Rcp r');
      sql.Add('where s.key2 >= 1000');
      sql.Add('and s.entitycode = p.entitycode');
      sql.Add('and s.entitycode = r.parent and r.ptype = ''P'' and r.ctype is NULL');
      sql.Add('order by hzid, s.entitycode, r.child');
      if execSQL > 0 then
      begin
      // note: above includes a split for Prep Items with Close Qty = 0 as well. Though there
      //       is nothing to split as such, the records are needed for reporting and there will be
      //       some Consumed Adjustment qty as well...

        if data1.StkCode > 2 then  // PRepItem recipe changes, but only from the second "proper" stock onwards...
        begin
          // PrepItem gains a new Ingredient: ensure the OpenSplit is 0 as the Open Qty is assumed to be at "old" Recipe
          // look in PRepItemSplit and see if there are ingredients in the old Stock Code that are no longer here now...
          // this also covers the case where the Ratio has changed. Item apearing new is equivalent with "old Ratio = 0"
          // use [BatchSize] to record this, -888 for new item, -999 for changed recipe Ratio
          close;
          sql.Clear;
          sql.Add('UPDATE [#PreparedItemSplit] set OpenSplit = isNULL(sq.oldClose, 0), ');
          sql.Add('  Adjustment = isNULL(sq.oldClose, 0) - p.CloseSplit,                 ');
          sql.Add('  BatchSize = CASE  WHEN (sq.oldClose is NULL) THEN -888 ELSE -999 END');
          sql.Add('FROM [#PreparedItemSplit] p  ');
          sql.Add('LEFT OUTER JOIN              ');
          sql.Add('  (Select [HoldingZoneID] as hzid, [PreparedItem], [Ingredient], [Ratio] as oldR, [CloseSplit] as oldClose ');
          sql.Add('   FROM PreparedItemSplit ');
          sql.Add('   WHERE StockCode = '+IntToStr(data1.StkCode - 1));
          sql.Add('   and ThreadID = '+IntToStr(data1.curtid));
          sql.Add('   and SiteCode = '+IntToStr(data1.repSite) + ') sq');
          sql.Add('ON p.HzID = sq.hzid and p.PreparedItem = sq.PreparedItem and p.Ingredient = sq.Ingredient');
          sql.Add('Where p.OpToSplit <> 0 and ((sq.Ingredient is NULL) or (p.Ratio <> sq.oldR) or (p.OpenSplit <> sq.oldClose)) ');
          execSQL;

          // a PrepItem loses an Ingredient: ensure the CloseSplit = 0 and the (new) Ratio = 0 but have
          // the OpenSplit from last time, record this in BatchSize = -777
          close;
          sql.Clear;
          sql.Add('INSERT [#PreparedItemSplit]  ([hzid], [PreparedItem], [BatchUnit], [BatchSize], [Ingredient], [Ratio],');
          sql.Add('   [OpToSplit], [OpenSplit], [CloseToSplit], [CloseSplit], [PrepVariance], [Adjustment]) ');
          sql.Add('select sq.HoldingZoneID, sq.PreparedItem, sq.[BatchUnit], -777, sq.[Ingredient], ');
          sql.Add('   0, 0, sq.CloseSplit, 0, 0, 0, sq.CloseSplit   ');
          sql.Add('FROM  (Select * FROM PreparedItemSplit         ');
          sql.Add('   WHERE StockCode = '+IntToStr(data1.StkCode - 1));
          sql.Add('   and ThreadID = '+IntToStr(data1.curtid));
          sql.Add('   and SiteCode = '+IntToStr(data1.repSite) + ') sq');
          sql.Add('LEFT OUTER JOIN [#PreparedItemSplit] p  ');
          sql.Add('ON p.HzID = sq.HoldingZoneID and p.PreparedItem = sq.PreparedItem and p.Ingredient = sq.Ingredient ');
          sql.Add('WHERE sq.CloseSplit <> 0 and (p.Ingredient is NULL) ');
          execSQL;
        end;

        close;
        sql.Clear;
        sql.Add('update stkCrDiv set ClosePrep = sq.Split, PrepRedQty = OpenPrep - sq.Split');  //  PrepRedQty = sq.Adj
        sql.Add('from ');
        sql.Add('  (select hzid, ingredient, sum(CloseSplit) as Split, sum(Adjustment) as Adj');
        sql.Add('   from #PreparedItemSplit group by hzid, ingredient) sq');
        sql.Add('where stkCrDiv.hzid = sq.hzid and stkCrDiv.entitycode = sq.ingredient');
        execSQL;
      end;

    finally
      free;
    end;
  end;
end;


procedure TdataProc.FIFOcost(isActual: boolean);
begin
  // more or less reproduce existing proc...
  // for now just call it...
  SetCosts(isActual);
end;

// ONLY for stocks made with the old system using the PZM product/rcp Model (Entity etc.)
procedure TdataProc.CreateEntCopy;
begin
  log.event('In dataProc.CreateEntCopy');
  with data1.adoqRun do
  begin
    //  Creates a table (ENTCOPY) for the current stock Divis including only entities
    //  belonging to that division. ENTCOPY is made up from entity.db, units.db and category.db.
    dmAdo.DelSQLTable('EntCopy');
    dmAdo.DelSQLTable('#Ghost1');
    dmAdo.DelSQLTable('#Ghost2');

    close;
    sql.Clear;
    sql.Add('SELECT E."Entity Code", E.[extended RTL name] as "Retail Name",E."Entity Type",');
    sql.Add('C."Category Name",C."Division Name",E."Sub-Category Name",');
    sql.Add('E."Strd Portion Unit",E."Strd Portion Size",E."Half Portion Size",');
    sql.Add('E."Double Portion Size",E."Off Sale Portion Size",E."Off Sale Unit",');
    sql.Add('U."Base Units",U."Base Type Unit", E."Import/Export Reference",');
    sql.Add('( E."Strd Portion Size" * U."Base Units" ) as StdBaseSize,');
    sql.Add('E."Purchase Name",E."Purchase Unit", ');
    sql.Add('E."Creation Date", E."Budgeted Cost Price", E."Tax Band"');
      sql.Add('INTO [#Ghost1]');
    sql.Add('FROM "ENTITY" E, "CATEGORY" C,"SUBCATEG" S, "UNITS" U');
    sql.Add('WHERE (E."Sub-Category Name" = S."Sub-Category Name" )');
    sql.Add('AND	  ( S."Category Name" = C."Category Name" )');
    sql.Add('AND   ( C."Division Name" = ' + QuotedStr(data1.TheDiv) + ')');
    sql.Add('AND   ( E."Strd Portion Unit" = U."Unit Name" )');
    sql.Add('');
    sql.Add('');
    sql.Add('SELECT E."Entity Code" as EntityCode,E."Retail Name" as RetailName,E."Entity Type" as EntityType,');
    sql.Add('E."Category Name" as CategoryName,E."Division Name" as DivisionName,E."Sub-Category Name" as SubCatName,');
    sql.Add('E."Strd Portion Unit" as StrdPortionUnit,E."Strd Portion Size" as StrdPortionSize,E."Half Portion Size" as HalfPortionSize,');
    sql.Add('E."Double Portion Size" as DoublePortionSize,E."Off Sale Portion Size" as OffSalePortionSize,E."Off Sale Unit" as OffSaleUnit,');
    sql.Add('E."Base Units" as BaseUnits,E."Base Type Unit" as BaseTypeUnit,E.StdBaseSize, E."Import/Export Reference" as ImpExRef,');
    sql.Add('( E."Off Sale Portion Size" * U."Base Units" ) as OffBaseSize,');
    sql.Add('E."Purchase Name" as PurchaseName,E."Purchase Unit" as PurchaseUnit,');
    sql.Add('E."Creation Date" as CreationDate,E."Budgeted Cost Price" as RcpCost, E."Tax band" as VatBand');
      sql.Add('INTO [#Ghost2]');
    sql.Add('FROM [#Ghost1] E LEFT JOIN "UNITS" U ON');
    sql.Add(' ( E."Off Sale Unit" = U."Unit Name" )');
    sql.Add('ORDER BY E."Entity Code"');
    sql.Add('');
    sql.Add(''); // get purchase base units
    sql.Add('SELECT E."EntityCode",E."RetailName",E."EntityType",');
    sql.Add('E."CategoryName",E."DivisionName",E."SubCatName",');
    if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
      sql.Add('(E."SubCatName") as repHdr,')
    else
      sql.Add('(E."CategoryName") as repHdr,');
    sql.Add('E."StrdPortionUnit",E."StrdPortionSize",E."HalfPortionSize",');
    sql.Add('E."DoublePortionSize",E."OffSalePortionSize",E."OffSaleUnit",');
    sql.Add('E."BaseUnits",E."BaseTypeUnit",E.StdBaseSize,');
    sql.Add('E."OffBaseSize", E."ImpExRef",');
    sql.Add('E."PurchaseName",E."PurchaseUnit",(U."Base Units") as PurchBaseU,');
    sql.Add('E."RcpCost", E."VatBand",E."CreationDate"');
      sql.Add('INTO dbo.EntCopy');
    sql.Add('FROM [#Ghost2] E LEFT JOIN "UNITS" U ON');
    sql.Add(' ( E."PurchaseUnit" = U."Unit Name" )');
    sql.Add('ORDER BY E."EntityCode"');
    execSQL;
  end;
  log.event('Exiting dataProc.CreateEntCopy');
end;

procedure TdataProc.PleaseWait(barPercent: smallint; actionText: string);
begin
  if fwait <> nil then
    fwait.UpdateBar(barPercent,actionText);
end;

end.







