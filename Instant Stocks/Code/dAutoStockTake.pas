unit dAutoStockTake;

interface

uses
  SysUtils, Classes, Forms, DB, ADODB, Math, Variants;

type
  TdmAutoStockTake = class(TDataModule)
    adoqThreads: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure AutoProcess;
    procedure Auto1StockTake(Tid: integer; StockTaker: string; SessionEndDT: tdatetime);
    procedure InitMAC;
    procedure CalcMAC;
    procedure AuditMAC;
    procedure TakingsMAC;
    procedure AcceptMAC;
  private
    { Private declarations }
    dayStartMAC : boolean;
    errStr: string;
    dt1: tdatetime;
  public
    { Public declarations }
  end;

var
  dmAutoStockTake: TdmAutoStockTake;

implementation

uses udata1, uADO, uDataProc, ulog, uPassword, uGlobals, dRunSP, dAccPurch, uUser;

{$R *.dfm}

procedure TdmAutoStockTake.DataModuleCreate(Sender: TObject);
begin
  dmADO := TdmADO.Create(self);

  uGlobals.GetGlobalData(dmADO.AztecConn);

  data1 := TData1.Create(self);
  data1.blindRun := TRUE;
  dataProc := TdataProc.Create(self);

  // in this release there will be no Security...
  CurrentUser := TUser.Create(-1, '_System-MAC', '');
  CurrentUser.IsZonalUser:=true;  
  Log.setuser(CurrentUser.UserName);

  if uGlobals.isSite then
  begin
    // check All the locks
    errStr := data1.CheckSPsLocks;

    with dmADO.adoqRun do
    begin
      // even if the "hard" locks are not on now, were they "killed" by make121Rcp or by makeTheoRed?
      close;
      sql.Clear;
      sql.Add('select * from stkDBGlog where SUBSTRING([logstring], 1, 12) = ''EntRcp lock ''');
      sql.Add('and caller <> ''stkSP_make121Rcp'''); // if killed by make121Rcp that's OK as
      sql.Add('order by logdt DESC');                // the map is now up to date
      open;

      if recordcount >= 1 then
      begin
        log.event('FAILURE WARNING: investigate the 121RcpMap Lock (' + FieldByName('logdt').AsString + ' - "' +
              FieldByName('logstring').asstring + '") - The Recipe Map may be obsolete.');
      end;
      close;
    end;

    AutoProcess;
    log.event('Auto Process finished. Exiting... ----------------------');

    Application.Terminate;
  end
  else
  begin
    log.event('Blind mode not allowed on HO installation. Exiting... ----------------------');
    Application.Terminate; // this should not run in blind mode on a Master PC
  end;
end;

procedure TdmAutoStockTake.AutoProcess;
var
  countSessEndDT: tdatetime;
  loopTID: integer;
begin
  try
    with data1.adoqRun do
    begin
      // are there any Threads for MAC stocks? Check this before any other stuff is done...
      Close;
      sql.Clear;
      sql.Add('select * from Threads where MobileAutoCount = 1');
      sql.Add('and Active = ''Y'' and isnull(SlaveTh, 0) <= 0');
      if data1.siteUsesHZs then
         sql.Add(' and ByHZ = 0 '); // for sites using Holding Zones bypass Threads using HZs
      open;                         // other Threads are OK...

      if recordcount = 0 then
      begin
        close;
        log.event('There are no valid Threads set-up for MAC stocks, nothing to do...');
        exit;
      end
      else
      begin
        log.event('There are '+ inttostr(recordcount) +' valid Threads set-up for MAC stocks, looking for Mobile Sessions...');
      end;

      close;
      sql.Clear;
      SQL.Add('IF object_id(''stkMACSessions'') IS NOT NULL DROP TABLE stkMACSessions');
      execSQL;

      // for each Thread that uses MAC, look for Mobile Count sessions not imported...
      errstr := 'Get Mobile Count Sessions';
      Close;
      SQL.Clear;
      SQL.Add('SELECT ms.[SessionId], ms.[StockThread], ms.[UserName], ms.[StockTakerName], ms.[StartTime],');
      SQL.Add('  ms.[EndTime], ms.LastImported, dbo.fn_ConvertToBusinessDate(ms.EndTime) as BsDate');
      SQL.Add('INTO dbo.stkMACSessions');
      SQL.Add('FROM ac_MobileStockSession ms,');
      sql.Add('  (select * from Threads where MobileAutoCount = 1');
      if data1.siteUsesHZs then
         sql.Add(' and ByHZ = 0 '); // for sites using Holding Zones bypass Threads using HZs
      sql.Add('   and Active = ''Y'' and isnull(SlaveTh, 0) <= 0) th');
      SQL.Add('WHERE ms.StockThread = th.TID and ms.EndTime is not NULL');
      ExecSQL;

      // per Thread, only keep sessions of Bs Date of the last seesion (even if imported), if there are more.
      // this ensures that "lost" sessions of days ago appearing in the system after newer sessions have been
      // processed will not be picked up and risk messing up the numbers, but will trully stay "lost".
      errstr := 'Keep last day only';
      Close;
      SQL.Clear;
      SQL.Add('delete stkMACSessions ');
      SQL.Add('from stkMACSessions dt join  ');
      SQL.Add('  (select StockThread, MAX(BsDate) as maxBsDate ');
      SQL.Add('   from stkMACSessions group by StockThread) mcs');
      sql.Add('on dt.StockThread = mcs.StockThread');
      sql.Add('   and dt.BsDate  <> mcs.maxBsDate');
      ExecSQL;

      errstr := 'Discard Imported Sessions';
      Close;
      SQL.Clear;
      SQL.Add('delete stkMACSessions ');
      SQL.Add('where LastImported is NOT NULL');
      ExecSQL;

      Close;
      sql.Clear;
      sql.Add('select count(*) as Sessions, count(distinct StockThread) as Threads from stkMACSessions ');
      open;

      if fieldByName('Sessions').asinteger < 1 then
      begin
        log.event('No Mobile Count Sessions eligible for MAC stocks where found.');
        exit;
      end;

      log.event('Found ' + fieldByName('Sessions').asstring + ' Mobile Count Sessions (Threads: '+
             fieldByName('Threads').asstring + ') eligible for MAC stocks');
      close;
    end;  // with ADOqRun

    // select the latest Session per Thread, this will give its End Time as the MAC stock's End Date Time
    // all other sessions for that Thread for the day will have thier Qtys added up to this one...
    with adoqThreads do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ms.[StockThread], ms.[UserName], ms.[StockTakerName], ');
      SQL.Add(' ms.[EndTime], ms.BsDate');
      SQL.Add('FROM stkMACSessions ms join ');
      SQL.Add('  (select StockThread, MAX(EndTime) as maxEndTime ');
      SQL.Add('   from stkMACSessions group by StockThread) mcs');
      sql.Add('on ms.StockThread = mcs.StockThread');
      sql.Add('   and ms.EndTime  = mcs.maxEndTime');
      SQL.Add('order by ms.[StockThread]');
      open;
    end;

    // main loop  --- for each Thread that has Sessions
    while not adoqThreads.eof do
    begin
      errstr := 'Process Thread';

      countSessEndDT := adoqThreads.FieldByName('EndTime').asdatetime;
      loopTID :=  adoqThreads.FieldByName('stockthread').asinteger;

      // as there is no interface we cannot deal with AzTabs that are late unless some Config is done
      // to turn this on and off per Thread maybe;
      // if such a thing is done later this is the place for it; see code for it in uStkDivDlg.pas

      // check the Tills have been read up to date for the latest Session
      if countSessEndDT > data1.LADT then // tills not read up to the Count Session End Time
      begin
        // log this
        log.event('Auto Stock Take NOT done for TID: ' + inttostr(loopTID) +
          ' as the Tills are not up to the DateTime of the last Mobile Count Session (' +
          formatDateTime('ddMMMyy hh:nn:ss', countSessEndDT)  +')');
        adoqThreads.Next;
        continue;
      end;
      
      errstr := 'Auto One Stock Take'; // if here then we found one stock to do...
      log.event('---- Auto Stock Take, TID: ' + inttostr(loopTid) + ', EndDT: ' +
         formatDateTime('ddMMMyy hh:nn:ss', countSessEndDT));
      Auto1StockTake(loopTID, adoqThreads.FieldByName('StockTakerName').asstring, countSessEndDT);

      log.event('---- Auto Stock Take FINISHED, TID: ' + inttostr(loopTid) + ', EndDT: ' +
         formatDateTime('ddMMMyy hh:nn:ss', countSessEndDT));
      adoqThreads.Next;
    end; // main loop 
  except
    on E: exception do
    begin
      log.event('ERROR in Main Loop - Error Location: ' + errstr + ' Error Message: ' + E.Message);
      exit;
    end;
  end;

  log.event('MAC session FINISHED.');
end;


procedure TdmAutoStockTake.Auto1StockTake(Tid: integer; StockTaker: string; SessionEndDT: tdatetime);
begin
  try
    // set the curTid to 0 to avoid killing a proper stock in case of error before tid is set
    data1.CurTid := 0;
    data1.StkCode := 0;

    with data1.adoqRun do
    begin
      Close;
      sql.Clear;
      sql.Add('select * from Threads where TID = ' + inttostr(Tid));
      open;

      Data1.TheStkTkr := StockTaker;
      Data1.TheStkType := 'MAC';
      data1.StkTypeLong := 'MAC';
      data1.CurTid := Tid;
      data1.curTidName := FieldByName('tname').asstring;
      data1.TheDiv := FieldByName('division').Asstring;
      data1.curNomPrice := FALSE;
      data1.curFillClose := TRUE;
      data1.curDozForm := (FieldByName('dozForm').asstring = 'Y');      // 17701
      data1.curEditTak := FALSE;
      data1.curIsGP := (FieldByName('isGP').asstring = 'Y');
      data1.curCPS := (FieldByName('doCPS').asstring = 'Y');
      data1.curCPNew := (FieldByName('CPSMode').asstring = 'N');
      data1.curCPSet := (FieldByName('CPSMode').asstring = 'R');
      data1.curGallForm := (FieldByName('gallform').asstring = 'Y');
      data1.curTillVarTak := (FieldByName('tillVarTak').asstring = 'Y');
      data1.curByLocation := (FieldByName('byHZ').asboolean) and data1.siteUsesLocations;
      data1.curByHz := FALSE;
      data1.curWasteAdj := FALSE;

      data1.curisMth := FALSE;
      data1.curisSth := (FieldByName('slaveTh').asinteger < 0);
      data1.curSth := 0;

      data1.curMngSig := FieldByName('MngSig').asboolean;
      data1.curAudSig := FieldByName('AudSig').asboolean;
      data1.curACSfields := FieldByName('ACSfields').asstring;
      data1.curACSnp := FALSE;
      data1.curACSheight := FieldByName('ACSheight').asfloat;
      data1.curShowImpExpRef := FieldByName('ShowImpExRef').AsBoolean;

      data1.curTidAsBase := FieldByName('LCBase').asboolean;
      data1.curRTrcp := FieldByName('InstTR').asboolean;
      data1.curThreadIsMAC := TRUE; // this may be useful later...

      dayStartMAC := FieldByName('dayStartMAC').asboolean;

      data1.EDT := SessionEndDT;
      data1.ETime := FormatDateTime('hh:mm', SessionEndDT);

      if data1.ETime > data1.roll then
        data1.EDate := floor(SessionEndDT)
      else
        data1.EDate := floor(SessionEndDT) - 1;

      // for Counts done at the end of of the day (EoBD) both Sales and Purchases are considered to be
      // for "today" (the day of the Count Session)

      // when Counts are done at Start of the Day (SoBD) the stock is for "yesterday";
      // this does not affect the Sales selected, just the Purchases
      if dayStartMAC then
        data1.EDate := data1.EDate - 1;

      Close;
    end;

    InitMAC;

    if errstr = 'MAC initialised' then
    begin
      CalcMAC;  // now do the stock....

      if errstr = 'MAC calculated' then
      begin
        AcceptMAC;  // now accept the stock....

        if errStr <> 'MAC accepted' then
        begin
          log.event('ERROR Accepting MAC: ' + errstr);
          data1.killStock(data1.curtid, data1.StkCode);
          exit;
        end;

        // if here it means Stock was done and accepted OK. Mark the Sessions as imported...
        with data1.adoqRun do
        begin
          Close;
          sql.Clear;
          sql.Add('update ac_MobileStockSession set LastImported = GetDate()');
          sql.Add('from ac_MobileStockSession m, ');
          SQL.Add('(SELECT DISTINCT SessionID FROM stkMACSessions WHERE StockThread = '+ inttostr(data1.CurTid));
          SQL.Add(' ) i where m.SessionID = i.SessionID');
          execSQL;
        end;
      end;
    end;
  except
    on E: exception do
    begin
      log.event('ERROR Processing MAC - Error Location: ' + errstr + ' Error Message: ' + E.Message);
      data1.killStock(data1.curtid, data1.StkCode);
      exit;
    end;
  end;
end;

procedure TdmAutoStockTake.InitMAC;
begin
  with data1 do
  begin
    errStr := 'Init MAC 1';
    // get last stock code for this thread from stocks
    adoqRun.Close;
    adoqRun.sql.Clear;
    adoqRun.sql.Add('Select a.StockCode, a.EDate, a.ETime, a.EDT');
    adoqRun.sql.Add('From stocks a JOIN');
    adoqRun.sql.Add(' (SELECT Max(a."StockCode") as prevCode FROM "stocks" a');
    adoqRun.sql.Add('  WHERE a."tid" = '+ inttostr(CurTid) + ' AND a."SiteCode" = '+IntToStr(TheSiteCode));
    adoqRun.sql.Add(' ) b on a.StockCode = b.PrevCode');
    adoqRun.sql.Add('Where a."tid" = '+ inttostr(CurTid) + ' AND a."SiteCode" = '+IntToStr(TheSiteCode));
    adoqRun.open;

    // set this thread's previous stock code
    PrevStkCode := adoqRun.FieldByName('StockCode').AsInteger;

    if PrevStkCode < 1 then
    begin
      log.event('---- Cannot do MAC: the Thread is NOT initialised');
      exit;
    end;

    stkCode := prevStkCode + 1;
    errStr := 'Init MAC 2';   // set stock's dates

    // for MAC stocks the SDT and EDT are important and used for Sales and the
    // SDate and EDate (meaning business dates) are used for Purchases

    // For ANY kind of stock the Start Date is the previous stock End Date + 1.
    // This means that the minimum possible Stock (of one day) is defined by the End Date
    // as given by the Mobile Session minus the End Date of the last stock.

    // in the case of EoBD counts the End Date is the same date as the Mobile Session
    // while for SoBD counts the End Date is the date of the Mobile Session -1.
    // A consequence is that a Stock done by the EoBD method cannot be followed by a one day stock
    // done by the method SoBD (because the user decided to change the way they do business).
    // The first such attempt would start by having a 0 day Stock. Only the second day
    // (assuming it has counts) will allow a daily stock.

    // also these stocks will NOT enforce that there is at least 24 hours between SDT and EDT;
    // it is envisiged that the Sales period will be roughyl around 24 hours but it does not have to be,
    // in theory it could be as small as one minute or so (the two times have to be either side
    // of a rollover so as to fall in different Business Dates) but of course this could not happen two days in a row.

    Sdate := adoqRun.FieldByName('EDate').AsDateTime + 1;
    SDT := adoqRun.FieldByName('EDT').AsDateTime + StrToTime('00:00:01');
    Stime := adoqRun.FieldByName('ETime').AsString;

    adoqRun.close;
  end; // with data1


  errStr := 'Init MAC 7';
  // ensure there is at least 1 full Business day to do a stock for; this is normally EDT - SDT >= 1,
  // i.e. min 24 hrs of Sales, but for these stocks it's about having at least one Purchase Date so...
  if data1.EDate - data1.SDate >= 0 then  // EDate = SDate is OK...
  begin
    if data1.EDT - data1.SDT > 731 then
    begin
      log.event('---- Will not do MAC: the Stock would be longer than 2 years (' +
         formatDateTime('ddmmmyy hh:nn:ss', data1.SDT) + '-' + formatDateTime('ddmmmyy hh:nn:ss', data1.EDT));
      exit;
    end;

    //make new rec in CURSTOCK AND STKMISC
    with data1, dmADO.adoTRun do
    begin
      curStkByHZ := FALSE;
      curStkByLocation := curByLocation;

      Close;
      TableName := 'curstock';
      Open;
      log.event('   MAC: appending record to CurrStock');
      AppendRecord([TheSiteCode,curTid,StkCode,TheDiv,Sdate,Stime,Edate,Etime,SDT, EDT,null,
                      null,'UnAudited','A',null,null,stkTypeLong,PrevStkCode,curStkByHZ,null, curRTRcp,
                      Now, curStkByLocation]);

      Close;
      errStr := 'Init MAC 8';
      TableName := 'stkmisc';
      Open;
      // first add the Site Wide record...
      log.event('   MAC: adding site wide record to stkMisc');
      AppendRecord([TheSiteCode,curtid,StkCode,0,null,0,null,0,null,0,TheMgr,TheStkTkr,0,RepHdr,TheStkType, null]);
      Close;

      logDetsCurStock := '(Tid '+IntToStr(data1.curtid) + ', ' + data1.curTidName + ', (' + theDiv;
      if dayStartMAC then
        logDetsCurStock := logDetsCurStock + ' MAC-SoDB) '
      else
        logDetsCurStock := logDetsCurStock + ' MAC-EoDB) ';

      logDetsCurStock := logDetsCurStock + ' Stk ' +
        inttostr(data1.StkCode) + ', ' + formatDateTime('ddmmmyy hhnnss', SDT) + '-' +
        formatDateTime('ddmmmyy hhnnss', EDT) + ' (SD ' + formatDateTime('ddmmmyy', SDate) +
        ' - ED ' + formatDateTime('ddmmmyy', EDate) + ') ';

      if curStkbyLocation then
        logDetsCurStock := logDetsCurStock + ' byLocation '
      else
        logDetsCurStock := logDetsCurStock + ' bySite ';

      if curRtrcp then
        logDetsCurStock := logDetsCurStock + 'RT ThRed.'
      else
        logDetsCurStock := logDetsCurStock + 'CT ThRed.';

      log.event('   MAC Start Processing - ' + data1.logDetsCurStock);
    end;  // with data1, dmADO.adoTRun

    errStr := 'MAC initialised';
  end
  else
  begin
    log.event('Cannot do MAC: there is not a full Business day between Start (' +
       formatDateTime('ddmmmyy', data1.SDate) + ') and End dates (' + formatDateTime('ddmmmyy', data1.EDate) + ').');
  end;
end;

procedure TdmAutoStockTake.CalcMAC;
begin
  try
    errStr := 'Start MAC calculating'; // START Stock calc: Pre-Audit, audit, Post-Audit, stkMisc
    data1.UpdateCurrStage(0); // stage 0, sdate, edate, etc...

    errStr := 'MAC get purchases';
    dataproc.FastPurch(TRUE);

    errStr := 'MAC Pre Audit';
    // -------------------------------------------------------------------------------------------------
    if not dataProc.PreAudit(data1.curRTrcp, True, 0) then       // Theo Reduction, Op Stock, Theo Costs
    begin
      log.event('ERROR MAC PreAudit did not work, Stage is now 0');
      exit;
    end;
    data1.PushStkMain; // push sales, purch data into stkmain
    data1.UpdateCurrStage(1); // stage 1, Sales & purch got & calc'ed & saved...

    log.event('   MAC Pre Audit OK');

    errStr := 'MAC Generate Audit Figures';
    // -------------------------------------------------------------------------------------------------
    AuditMAC;                                  // MAC fill Audit table, get counts, put them in stkCrDiv

    if errStr <> 'MAC Audit Counted' then
      exit;
    log.event('   MAC Audit figures Copied. Start processing again...');

    errStr := 'MAC Post Audit';
    // -------------------------------------------------------------------------------------------------
    if not dataProc.PostAudit then           // Act Reduction, Act Costs, Recipe/Ingred Costs/Nom Prices
    begin
      log.event('ERROR - MAC PostAudit did not work');
      exit;
    end;
    errStr := 'MAC Post Audit OK';

    data1.PushStkMain;  // update stkmain.db from stkcrdiv.db
    data1.PushStkSold;
    data1.PushPrepared;

    data1.UpdateCurrStage(3); // stage 3, All audit figs, costs, prices, sitems calc'ed

    errStr := 'MAC Takings';
    // -------------------------------------------------------------------------------------------------
    TakingsMAC; //                                  get Takings and Till Variances, put them in stkMisc
    if errStr <> 'MAC Takings Added' then
      exit;

    data1.UpdateCurrStage(4); // stage 4, ready for acceptance
    log.event('   MAC Auto Stock complete');

    errstr := 'MAC calculated';
  except
    on E: exception do
    begin
      log.event('ERROR Calculating the MAC - Error Location: ' + errstr + ' Error Message: ' + E.Message);
      data1.killStock(data1.curtid, data1.StkCode);
      exit;
    end;
  end;
end;

procedure TdmAutoStockTake.AuditMAC;
begin
  errStr := 'Start MAC Audit Counts';

  with data1.adoqRun do
  begin
    errStr := 'MAC Fill with Theo Close'; // fill stkCrDiv Actual Close Qty with the TheoClose or 0
    close;
    sql.Clear;
    sql.Add('UPDATE StkCrDiv SET AuditStk = isNULL(ThCloseStk,0), ActCloseStk = isNULL(ThCloseStk,0)');
    sql.Add('where ThCloseStk >= 0');
    Execsql;

    // get all sessions and sessions counts
    // add all counts per product and unit (add all records, locations and sessions together)
    errStr := 'MAC Get Mobile Counts';
    Close;
    SQL.Clear;
    SQL.Add('IF object_id(''stkMACCounts'') IS NOT NULL DROP TABLE stkMACCounts');
    execSQL;

    Close;
    SQL.Clear;
    SQL.Add('SELECT ms.SessionID, msc.LocationID, msc.ProductID, msc.UnitName, SUM(msc.[Count]) as [Count], ');
    SQL.Add('  Count(*) as Recs, CAST(0 as float) PurchBaseU');
    SQL.Add('INTO dbo.stkMACCounts');
    SQL.Add('FROM stkMACSessions ms');
    SQL.Add('JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.SessionId');
    SQL.Add('WHERE ms.StockThread = '+ inttostr(data1.CurTid));
    if not data1.curStkByLocation then
      SQL.Add('AND msc.LocationId = 999');
    SQL.Add('GROUP BY ms.SessionID, msc.LocationID, msc.ProductID, msc.UnitName');
    ExecSQL;

    // log what's about to be imported...
    Close;
    sql.Clear;
    sql.Add('select count(distinct SessionID) as SessCount, count(distinct LocationID) as LocCount,');
    sql.Add(' count(distinct ProductID) as ProdCount, SUM(Recs) as RecCount,');
    sql.Add(' count(distinct (CAST(ProductID as varchar) + UnitName)) as ProdUnitCount ');
    SQL.Add('from stkMACCounts');
    open;

    if data1.curStkByLocation then
      log.event('    Importing Counts for: ' + fieldByName('SessCount').AsString + ' Sessions, ' +
        fieldByName('LocCount').AsString + ' Locations, ' + fieldByName('ProdCount').AsString + ' Products, ' +
        fieldByName('ProdUnitCount').AsString + ' Prod-Unit pairs, ' +
        fieldByName('RecCount').AsString + ' Count Rows')
    else
      log.event('    Importing Counts for: ' + fieldByName('SessCount').AsString + ' Sessions, ' +
          fieldByName('ProdCount').AsString + ' Products, ' +
          fieldByName('RecCount').AsString + ' Count Rows');

    // get the Base Units for the Units...
    errStr := 'MAC Get Base Units';
    close;
    sql.Clear;
    sql.Add('update stkMACCounts set purchbaseu = sq.[base units]');
    sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
    sql.Add('where unitName = sq.[unit name]');
    execSQL;

    errStr := 'MAC Store Audit changes'; // just store that a fresh Calculation was done, no details
    close;
    sql.Clear;
    sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], [ChangedBy])');
    sql.Add('VALUES ('+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',  '+IntToStr(data1.StkCode));
    if data1.curStkByLocation then
      sql.Add(', -2, ')
    else
      sql.Add(', -1, ');
    sql.Add('''Stock Calculation'',  ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss', Now)) + ', '+ quotedStr(CurrentUser.UserName) + ')');
    ExecSQL;

    // transform the Counts into Base Units and fill stkCrDiv straight from these Counts in Base Units.
    errStr := 'MAC Store Audit Counts'; // add it all to stkCrDiv to continue processing...
    close;
    sql.Clear;
    sql.Add('UPDATE StkCrDiv SET AuditStk = sq.CloseStk, ActCloseStk = sq.CloseStk');
    SQL.Add('FROM (select ProductID, SUM([Count] * PurchBaseU) as CloseStk');
    SQL.Add('      FROM stkMACCounts group by ProductID) sq');
    SQL.Add('WHERE stkcrdiv.entitycode = sq.ProductID');
    Execsql;
  end;

  errstr := 'MAC Audit Counted';
end;

procedure TdmAutoStockTake.TakingsMAC;
begin
  with data1.adoqRun do
  begin
    // create stkCrMisc..
    errstr := 'MAC Empty stkCrMisc';
    dmADO.DelSQLTable('stkCrMisc');

    errstr := 'MAC Reset stkCrMisc';
    Close;
    sql.Clear;
    sql.Add('select * into dbo.stkCrMisc from stkMisc');
    sql.Add('where stockCode = '+IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    execSQL;

    // null and 0 the fields that are always recalcualted ...
    Close;
    sql.Clear;
    sql.Add('update stkCrMisc set totInc = 0, totNetInc = 0, totTillVar = 0, totAWValue = 0, banked = 0');
    execSQL;

    // get tot income and NetIncome from StkCrSld into stkCrMisc
    errstr := 'MAC Get Income';
    close;
    sql.Clear;
    sql.Add('update stkCrMisc set totInc = sq.income, totNetInc = sq.totnetinc');
    sql.Add('from (select (sum(a."income")) as income, (sum(a."Income" - a."vatRate")) as totNetInc');
    sql.Add('      from "stkCrSld" a) sq');
    execSQL;

    // now get the till variances
    errstr := 'MAC Get Variances';
    close;
    sql.Clear;
    sql.Add('update stkCrMisc set totTillVar = sq.TillVar from ');

    sql.Add('(select (sum(q1.DecVariance)) as tillVar');
    sql.Add('from ');

    sql.Add('(SELECT fe.Id, fe.SiteId,  fe.EndDateTime, counts.PaymentMethodId, ');
    sql.Add('  (ISNULL(counts.Counted,0) - ISNULL(counts.Expected,0)) AS [DecVariance]');
    sql.Add(' FROM                                                                     ');
    sql.Add(' (SELECT fe.Id, fe.SiteId, (SELECT MAX(EndDateTime) FROM ac_TerminalSession ts ');
    sql.Add('	                 WHERE ts.CashupEntryId = fe.Id and ts.SiteId = fe.SiteId) as EndDateTime ');
    sql.Add('  FROM ac_FinanceEntry fe   WHERE fe.Type = 12 /* Terminal Cashup */                       ');
    sql.Add(' UNION ALL                                                                                  ');
    sql.Add('  SELECT fe.Id, fe.SiteId, (SELECT MAX(EndDateTime) FROM ac_TerminalSession ts              ');
    sql.Add('	                 WHERE ts.CashupEntryId = fe.Id and ts.SiteId = fe.SiteId) as EndDateTime ');
    sql.Add('  FROM ac_FinanceEntry fe   WHERE fe.Type = 13 /* Money belt cashup */                     ');
    sql.Add(' UNION ALL                                                                                  ');
    sql.Add('  SELECT fe.Id, fe.SiteId, (SELECT MAX(EndDateTime) FROM ac_TerminalSession ts              ');
    sql.Add('                  WHERE ts.CashupEntryId = fe.Id and ts.SiteId = fe.SiteId) as EndDateTime ');
    sql.Add('  FROM ac_FinanceEntry fe   WHERE fe.Type = 14 /* Sales area cashup */                     ');
    sql.Add('  ) fe                                                                                       ');
    sql.Add('  LEFT OUTER JOIN                                                                          ');
    sql.Add(' (SELECT SiteId, Id, PaymentMethodId, SUM(Counted) as Counted, SUM(Expected) as Expected    ');
    sql.Add('  FROM (SELECT fe.SiteId, fe.Id, count.PaymentMethodId, count.BaseCurrencyAmount as Counted,');
    sql.Add('           CAST(0 as money) as Expected FROM ac_FinanceEntry fe                            ');
    sql.Add('         JOIN ac_FinanceCashBreakdownElement count                                         ');
    sql.Add('           ON fe.CountBreakdownId = count.CashBreakdownId AND fe.SiteId = count.SiteId  ');
    sql.Add('          WHERE fe.Type IN (12, 13, 14)                                                    ');
    sql.Add('       UNION ALL                                                                           ');
    sql.Add('       SELECT fe.SiteId, fe.Id, expected.PaymentMethodId, 0, expected.BaseCurrencyAmount as Expected ');
    sql.Add('          FROM ac_FinanceEntry fe                                                          ');
    sql.Add('         JOIN ac_TerminalSession ts ON fe.SiteId = ts.SiteId AND ts.CashupEntryId = fe.Id  ');
    sql.Add('         JOIN ac_FinanceCashBreakdownElement expected                                      ');
    sql.Add('           ON ts.ExpectedBreakdownId = expected.CashBreakdownId AND ts.SiteId = expected.SiteId');
    sql.Add('          WHERE fe.Type IN (12, 13, 14)                                                    ');
    sql.Add('       ) x                                                                                 ');
    sql.Add('  GROUP BY SiteId, Id, PaymentMethodId                                                     ');
    sql.Add(' ) counts ON fe.SiteId = counts.SiteId AND fe.Id = counts.Id                                ');
    sql.Add(') q1                                                                                        ');
    sql.Add('where q1.EndDateTime > ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', data1.SDT)));
    sql.Add('and q1.EndDateTime <= ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', data1.EDT)));

    sql.Add(') as sq');
    execSQL;

    // Auto Waste
    errstr := 'MAC Get Auto-Waste';
    dmADO.DelSQLTable('#Ghost');

    // take the AutoWaste records for the period from stkPCwaste and place in ghost
    // express the waste in Base Units
    close;
    sql.Clear;
    sql.Add('SELECT a.EntityCode, (a.WValue * u.[Base Units]) as baseWaste');
    sql.Add('INTO #ghost');
    sql.Add('FROM stkPCwaste a INNER JOIN Units u ON a.Unit = u.[Unit Name]');
    sql.Add('where a.WasteDT >= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.SDT)));
    sql.Add('and a.WasteDT <= ' + quotedstr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
    sql.Add('and a.WasteFlag = ''A''');
    execSQL;

    errstr := 'MAC Get Auto-Waste 2';
    close;
    sql.Clear;
    sql.Add('update stkCrMisc set totAWValue = ISNULL(sq.aw,0)');
    sql.Add('from (');
    sql.Add('  select sum(a."baseWaste" * b.nomprice) as aw');
    sql.Add('  from "#Ghost" a, stkcrdiv b');
    sql.Add('  where a.entitycode = b.entitycode) sq');
    execSQL;

    errstr := 'MAC Set Takings';
    close;
    sql.Clear;
    if data1.curTillVarTak then
      sql.Add('update stkCrMisc set banked = ISNULL(totInc + totTillVar,0)')
    else
      sql.Add('update stkCrMisc set banked = ISNULL(totInc,0)');
    execSQL;

    errstr := 'MAC Store Takings and Variances';
    close;
    sql.Clear;
    sql.Add('update stkMisc set ');
    sql.Add('  [Banked] = sq.[Banked], [TotInc] = sq.[TotInc], [TotTillVar]= sq.[TotTillVar],');
    sql.Add('  [TotNetInc] = sq.[TotNetInc], [TotAWvalue]= sq.[TotAWvalue], ');
    sql.Add(' StockNote = ' +  quotedSTR('Automatically Created and Accepted by a Mobile Count Session'));
    sql.Add('from');
    sql.Add('  (select * from stkCrMisc) sq');
    sql.Add('WHERE stkMisc.StockCode = '+IntToStr(data1.StkCode));
    sql.Add('and stkMisc.tid = '+IntToStr(data1.curtid));
    execSQL;
  end;  // with data1.adoqRun

  errstr := 'MAC Takings Added';
end;

procedure TdmAutoStockTake.AcceptMAC;
begin
  // now ACCEPT the Auto stock
  errStr := 'Accept MAC';

  if not data1.curNoPurAcc then
  begin
    // accept invoices ...
    try
      dmAccPurch := TdmAccPurch.Create(self);
      if not dmAccPurch.AcceptPurchases then
      begin
        log.event('ERROR - MAC Stock Acceptance stopped because of error in Accept Purchases');
        data1.killStock(data1.curTid, data1.StkCode);
        exit;
      end;
    finally
      dmAccPurch.Free;
    end;
  end;

  // set summary data in stkMisc...
  try
    errStr := 'get figures from stkCrDiv';
    with dmADO.adoqRun do
    begin
      // get the main figures from stkCrDiv
      close;
      sql.Clear;
      sql.Add('update stkMisc set');
      sql.Add('	[TotOpCost] = sq.opCost, ');
      sql.Add('	[TotCloseCost] = sq.closeCost, ');
      sql.Add('	[TotMoveCost] = sq.moveCost, ');
      sql.Add('	[TotLGW] = (sq.gains - sq.faultVal), ');
      sql.Add('	[TotConsVal] = sq.grossCons');
      sql.Add('from');
      sql.Add('(SELECT sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
      sql.Add('  sum(b."opStk" * b."opCost") as opCost,');
      sql.Add('  sum(moveQty * moveCost) as moveCost,');

      sql.Add('  (sum ');
      sql.Add('   (CASE');
      sql.Add('    WHEN b.key2 >= 1000 THEN 0');
      sql.Add('    ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
      sql.Add('   END)) as gains,');

      sql.Add('  (sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
      sql.Add('  (sum (b."wastage" * b."NomPrice")) as faultVal');
      sql.Add('  FROM "StkCrDiv" b) sq');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'get figures from StkCrSld';
      // get recipe variance (and tot income and VAT) from StkCrSld.
      close;
      sql.Clear;
      sql.Add('update stkMisc set');
      sql.Add('	[TotInc] = sq.income, ');
      sql.Add('	[TotNetInc] = sq.totNetInc, ');
      sql.Add('	[TotCostVar] = sq.totCostvar, ');
      sql.Add('	[TotProfVar] = sq.totprofvar, ');
      sql.Add('	[TotSPCost] = sq.totActcost, ');
      sql.Add('	[TotRcpVar] = sq.rcpvar, ');
      sql.Add('	[extraInc] = sq.extraInc');
      sql.Add('from');
      sql.Add('(select (sum(a."income")) as income,');
      sql.Add('  (sum((CASE ');
      sql.Add('         WHEN a.[ProductType] like ''R%''  THEN a.[income]');
      sql.Add('         ELSE 0');
      sql.Add('        END))) as rcpVar,');
      sql.Add('  (sum((CASE ');
      sql.Add('         WHEN a.[ProductType] like ''X%''  THEN a.[income]');
      sql.Add('         ELSE 0');
      sql.Add('        END))) as extraInc,');
      sql.Add('  (sum (a."ActCost" * a."salesQty")) as totActCost,');
      sql.Add('  (sum (a."cos%")) as totCostVar,');
      sql.Add('  (sum ((a."TheoCost" * a."salesQty") - (a."ActCost" * a."salesQty"))) as totProfVar,');
      sql.Add('  (sum(a."Income" - a."vatRate")) as totNetInc');
      sql.Add('  FROM "StkCrSld" a ) sq');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'put period figures into StkMisc';
      // now put all this into StkMisc
      close;
      sql.Clear;
      sql.Add('update stkMisc set');
      sql.Add('	[Per] = ' + inttostr(trunc(data1.Edate - data1.Sdate + 1)) + ', ');
      sql.Add(' [miscBal1] = (CASE WHEN [miscBal1] is NULL THEN 0 ELSE [miscBal1] END),');
      sql.Add(' [miscBal2] = (CASE WHEN [miscBal2] is NULL THEN 0 ELSE [miscBal2] END),');
      sql.Add(' [miscBal3] = (CASE WHEN [miscBal3] is NULL THEN 0 ELSE [miscBal3] END),');
      sql.Add(' [totPurch] = (CASE WHEN [totPurch] is NULL THEN 0 ELSE [totPurch] END),');
      sql.Add(' [extraInc] = (CASE WHEN [extraInc] is NULL THEN 0 ELSE [extraInc] END),');

      sql.Add(' [totInc] = (CASE WHEN [totInc] is NULL THEN 0 ELSE [totInc] END),');
      sql.Add(' [totNetInc] = (CASE WHEN [totNetInc] is NULL THEN 0 ELSE [totNetInc] END),');
      sql.Add(' [totCostVar] = (CASE WHEN [totCostVar] is NULL THEN 0 ELSE [totCostVar] END),');
      sql.Add(' [totProfVar] = (CASE WHEN [totProfVar] is NULL THEN 0 ELSE [totProfVar] END),');
      sql.Add(' [totSPCost] = (CASE WHEN [totSPCost] is NULL THEN 0 ELSE [totSPCost] END),');
      sql.Add(' [totRcpVar] = (CASE WHEN [totRcpVar] is NULL THEN 0 ELSE [totRcpVar] END),');
      sql.Add('	[lmdt] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'curstock -> stocks';

      close;
      sql.Clear;
      sql.Add('insert Stocks ([SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('      [ETime], [SDT], [EDT], [AccDate], [AccTime], [Stage], [Type], [DateRecalc],');
      sql.Add('      [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], [LMDT], [AccBy], [PureAZ], [rtRcp])');
      sql.Add('select [SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('       [ETime], [SDT], [EDT], ' + quotedStr(formatDateTime('yyyymmdd', Date)) + ',' +
        quotedStr(formatDateTime('hh:nn', Time)) + ', ''Accepted'', [Type], [DateRecalc],');
      sql.Add('       [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], ' +
        quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', Now)) + ', ' + quotedStr(CurrentUser.UserName) + ', 1, [rtRcp]');
      sql.Add('from curstock');
      sql.Add('WHERE StockCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
       sql.Add('      '); // now set lmdt on StkMain and StkSold to have these recs tx'd to the HO
      sql.Add('update StkMain set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
       sql.Add('      ');
      sql.Add('update StkSold set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'DELETE FROM "curstock"';
      close;
      sql.Clear;
      sql.Add('DELETE FROM "curstock"');
      sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      ExecSQL;
    end; // with

    if data1.curTidAsBase then
    begin
      errStr := 'Update Est Stock Level';
      dmRunSP := TdmRunSP.Create(self);
      with dmRunSP do
      begin
        //spConn.ConnectionString := dmADO.AztecConn.ConnectionString;
        spConn.Open;

        with adoqRunSP do
        begin
          close;
          sql.Clear;
          sql.Add('DECLARE @ret int');
          sql.Add('exec @ret = stkSP_ECLbase ' + IntToStr(data1.curtid) + ', ' + IntToStr(data1.StkCode));
          sql.Add('SELECT @ret');
          dt1 := Now;
          try
           Open;
           if fields[0].AsInteger = -5 then
            log.event('   Warning - ECLevel SP Body NOT Executed - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
           else
            log.event('   MAC - ECLevel SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
              ' RET CODE: ' + fields[0].AsString);
          except
            on E:Exception do
              log.event('ERROR MAC - ECLEvel SP ERROR -  "' + sql[1] + '"' +
              ' ERR MSG: ' + E.Message);
          end;
          Close;
        end;
        spConn.Close;
      end; // with dmRunSP
      dmRunSP.Free;
    end;
  except
    on E:Exception do
    begin
      log.event('ERROR - MAC Accepting Stock (Tid: ' + IntToStr(data1.curtid) +
        ', StkCode: ' + IntToStr(data1.StkCode) + ') Location: ' + errstr +
        ' Message: ' + E.Message);
      data1.killStock(data1.curtid, data1.StkCode);
      exit;
    end;
  end;

  log.event('   MAC Stock Accepted.');
  errStr := 'MAC accepted';
end;

end.

// Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=Aztec;Data Source=SO-CORNEL
