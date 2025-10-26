unit dAccPurch;

interface

uses
  SysUtils, Classes, DBTables, DB, Dialogs, Math;

type
  TdmAccPurch = class(TDataModule)
  private
    ssuser : string[20];
    MaxEDate : TDateTime;
    { Private declarations }
  public
    { Public declarations }
    function AcceptPurchases: boolean;
    function UnAcceptPurchases: boolean;
  end;

var
  dmAccPurch: TdmAccPurch;

implementation

uses uADO, udata1, ulog;

{$R *.dfm}

///////////  CC  //////////////////////////////////////////////////////////////
//  Date: 18/10/2002
//  Inputs: None
//  Outputs: None
//  
//  This proc handles accepting of purchases that have been included in stocks
//
//  1. Create temp table from Purchase & PurchHdr with Site,SuppName, DelivNoteNo,
//     EntityCode, and (invoice)Date, and empty fields Div and Done = N
//  2. Add Division to the table.
//  3. Get ghost with latest Accepted stocks form each thread (only div and end date)
//  4. Keep only latest dates per division
//  5. For each record at 4. update the temp table. Set Done = Y
//     if (Invoice)Date <= division/stock end date (i.e. invoice entity has been counted)
//  6. Sum up per Invoice (site, supp, delivNoteNo) with count, having count = 0 where Done = N
//  7. For all invoices at 6. do transfer to Accepted.
//
///////////////////////////////////////////////////////////////////////////////
function TdmAccPurch.AcceptPurchases: boolean;
var
  errstr, logstr : string;
  i : integer;
begin
  Result := False;
  // prepare special string for modified by field...
  // take the last 4 digits of the stock code
  ssuser := inttostr(data1.StkCode);
  ssuser := copy(ssuser, max(length(ssuser) - 3, 1), 4);
  // add thread id. if tid > 99 keep just its last 2 digits
  ssuser := copy(inttostr(data1.CurTid),max(length(inttostr(data1.CurTid)) - 1, 1), 2) +'-'+ ssuser;
  ssuser := ' StkAc' + ssuser;

  dmADO.DelSQLTable('#ghost');
  dmADO.DelSQLTable('#TempPurch');
  dmADO.DelSQLTable('#NonActiveDivisions');
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT [Division Name]');
    sql.Add('INTO #NonActiveDivisions');
    sql.Add('FROM division');
    sql.Add('WHERE [division name] not in');
    sql.Add('	(SELECT division');
    sql.Add('	 FROM threads');
    sql.Add('	 WHERE isNull(Active, ''N'') = ''Y'')');
    execSQL;

    close;
    sql.Clear;
    sql.Add('SELECT distinct (a."site code") as sitecode, (c."supplier name") as suppname,');
    sql.Add('(a."delivery note no.") as invNo, (a."entity code") as entitycode, (c."date") as invDate,');
    sql.Add('(b."sub-category name") as subcat, (''D'') as Done');
    sql.Add('    into #ghost ');
    sql.Add('FROM "entity" b, "PurchHdr" c, "Purchase" a');
    sql.Add('WHERE a."entity code" = b."entity code"');
    sql.Add('AND a."site code" = c."site code"');
    sql.Add('AND a."Supplier name" = c."Supplier name"');
    sql.Add('AND a."delivery note no." = c."delivery note no."');
    sql.Add('and (c."deleted" is NULL OR c."deleted" <> ''Y'')');
    execSQL;

    close;
    sql.Clear;
    sql.Add('SELECT distinct a.sitecode, a.suppname,');
    sql.Add('a.invNo, a.entitycode, a.invDate,');
    sql.Add('(c."division name") as Division, a.Done');
    sql.Add('    into #TempPurch ');
    sql.Add('FROM "subcateg" b, "category" c, "#ghost" a');
    sql.Add('WHERE a."subcat" = b."sub-category name"');
    sql.Add('AND c."category name" = b."category name"');
    execSQL;

    // delete all records for invoices were the current division is not involved at all
    sql.Clear;
    sql.Add('update [#temppurch] set done = ''N''');
    sql.Add('from (select distinct a.sitecode, a.suppname,a.invNo');
    sql.Add('   from [#temppurch] a');
    sql.Add('   where a.division = ' + quotedStr(data1.TheDiv));
    sql.Add('   or a.Division in (SELECT * FROM #NonActiveDivisions)');
    sql.Add('   group by a.sitecode, a.suppname,a.invNo) as sq');
    sql.Add('where [#temppurch].sitecode = sq.sitecode');
    sql.Add('and [#temppurch].suppname = sq.suppname');
    sql.Add('and [#temppurch].invNo = sq.invNo');
    execSQL;

    close;
    sql.Clear;
    sql.Add('delete [#temppurch]');
    sql.Add('where done = ''D''');
    execSQL;

    // get accepted stocks dates
    dmADO.DelSQLTable('#ghost');

    close;
    sql.Clear;
    sql.Add('update #tempPurch set Done = ''Y''');
    sql.Add('from (select division, max(edate) as maxdate');
    sql.Add('      from stocks group by division) as q');
    sql.Add('where #tempPurch.division = q.division');
    sql.Add('and #tempPurch.invDate <= q.maxdate');
    execSQL;

    // 17064
    // set Done 'Y' for lines where division does not have current active thread...
    close;
    sql.Clear;
    sql.Add('update #tempPurch set Done = ''N''');
    sql.Add('where #tempPurch.division not in');
    sql.Add(' (select distinct division');
    sql.Add('      from threads where active = ''Y'')');
    execSQL;

    // for THIS division the max edate should be the edate of the stock about to be accepted...
    // of course if items from THIS division were not accepted before although stocks (from other threads)
    // were accepted with edate > THIS edate then they may be accepted now...
    close;
    sql.Clear;
    sql.Add('update #tempPurch set Done = ''Y''');
    sql.Add('where (#tempPurch.division = ' + quotedStr(data1.TheDiv));
    sql.Add('or #tempPurch.Division in (SELECT * FROM #NonActiveDivisions))');
    sql.Add('and #tempPurch.invDate <= ' + quotedStr(formatDateTime('mm/dd/yy',data1.Edate)));
    execSQL;

    close;
    sql.Clear;
    sql.Add('SELECT distinct a.sitecode, a.suppname,a.invNo, a."done", count(a."done") as thecount');
    sql.Add('    into #Ghost ');
    sql.Add('FROM "#temppurch" a');
    sql.Add('where a.done = ''N''');
    sql.Add('group by a.sitecode, a.suppname,a.invNo, a."done" having count(a."done") > 0');
    execSQL;
    // [Site Code], [Supplier Name], [Delivery Note No.], [Record ID]
    close;
    sql.Clear;
    sql.Add('delete from #temppurch');
    sql.Add('from (select a.sitecode, a.suppname,a.invNo');
    sql.Add('      from #ghost a) as q');
    sql.Add('where #tempPurch.sitecode = q.sitecode');
    sql.Add('and #tempPurch.suppname = q.suppname');
    sql.Add('and #tempPurch.invNo = q.invNo');
    execSQL;

    // now only records belonging to invoices that have ALL entities "Done" are left.

    close;
    sql.Clear;
    sql.Add('SELECT distinct a.sitecode, a.suppname,a.invNo');
    sql.Add('FROM "#temppurch" a');
    open;

    if recordcount = 0 then
    begin
      log.event('No purchases to Accept.');
      Result := True;  // no purchases to accept? That's OK, just accept the stock
      close;
      exit;
    end;

    close;

    // 17158
    // accept purchases in SQL too...
    dmADO.DelSQLTable('#ghost');

    close;
    sql.Clear;
    sql.Add('SELECT distinct a.* INTO [#ghost] FROM "purchhdr" a, "#temppurch" z');
    sql.Add('where a."site code" = z."sitecode"');
    sql.Add('AND a."Supplier name" = z."Suppname"');
    sql.Add('AND a."delivery note no." = z."invno"');
    sql.Add('and (a."deleted" is NULL OR a."deleted" <> ''Y'')');
    execSQL;

    // all invoice headers to be accepted are now in ghost...
    // begin the transaction in SQL Server...

    if dmADO.AztecConn.InTransaction then
    begin
      log.event('Error in Accept Purchases (before BeginTrans): Already in Transaction');
      if not data1.blindRun then
      showMessage('Error trying to accept Purchases!' + #13 + #13 +
        'Cannot begin transaction' + #13 + #13 + 'The ' + data1.SSlow + ' will not be Accepted.');

      exit;
    end;

    dmADO.AztecConn.BeginTrans;

    try
      // guard against key violations in ACCPurHd
      errstr := 'Avoid Key Viol. in AccPurHd';
      close;
      sql.Clear;
      sql.Add('delete [AccPurHd]');
      sql.Add('from [AccPurHd] a, [#ghost] z');
      sql.Add('where a."site code" = z."site code"');
      sql.Add('AND a."Supplier name" = z."Supplier name"');
      sql.Add('AND a."delivery note no." = z."delivery note no."');
      execSQL;

      // insert them in AccPurHd (but calculate the Total Cost first.)
      errstr := 'Insert in AccPurHd';
      close;
      sql.Clear;
      sql.Add('insert into [AccPurHd] ("Site Code", "Supplier Name", "Delivery Note No.",');
      sql.Add('       "Date", "Note", "Order No", "Total Amount", ');
      sql.Add('       "LMDT")');
      sql.Add('select a."Site Code", a."Supplier Name", a."Delivery Note No.",');
      sql.Add('a."Date", a."Note", a."Order No",');
      sql.Add('sum(b."total cost") as TotAmt, ');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as lmdt');
      sql.Add('from "#ghost" a, "purchase" b');
      sql.Add('where a."Site Code" = b."Site Code"');
      sql.Add('AND a."Supplier Name" = b."Supplier Name"');
      sql.Add('AND a."Delivery Note No." = b."Delivery Note No."');
      sql.Add('GROUP BY a."Site Code", a."Supplier Name", a."Delivery Note No.",');
      sql.Add('a."Date", a."Note", a."Order No"');
      i := ExecSQL;

      logstr := 'Acc Inv: ' + inttostr(i);

      // 4.
      errstr := 'Update PurchHdr';
      close;
      sql.Clear;
      sql.Add('update [PurchHdr] set');
      sql.Add('[deleted] = ''Y'', [Modified By] = ' + quotedStr(ssuser) + ',');
      sql.Add('[LMDT] = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
      sql.Add('from purchHdr a, [#ghost] z');
      sql.Add('where a."site code" = z."site code"');
      sql.Add('AND a."Supplier name" = z."Supplier name"');
      sql.Add('AND a."delivery note no." = z."delivery note no."');
      execSQL;

      // guard against key violations in ACCPurch
      errstr := 'Avoid Key Viol. in AccPurch';
      close;
      sql.Clear;
      sql.Add('delete [AccPurch]');
      sql.Add('from [AccPurch] a, [#ghost] z');
      sql.Add('where a."site code" = z."site code"');
      sql.Add('AND a."Supplier name" = z."Supplier name"');
      sql.Add('AND a."delivery note no." = z."delivery note no."');
      execSQL;

      // 5.
      errstr := 'Insert in AccPurch';
      close;
      sql.Clear;
      sql.Add('insert into [AccPurch] ("Site Code", "Supplier Name", "Delivery Note No.",');
      sql.Add('       "Record Id", "Entity Code", "Purchase Name", "Flavour", "Quantity",');
      sql.Add('       "Unit Name", "Cost Per Unit", "Total Cost", "Shortage")');
      sql.Add('select b."Site Code", b."Supplier Name", b."Delivery Note No.",');
      sql.Add('b."Record Id", b."Entity Code", b."Purchase Name", b."Flavour", b."Quantity",');
      sql.Add('b."Unit Name", b."Cost Per Unit", b."Total Cost", b."Shortage"');
      sql.Add('from "#ghost" a, "purchase" b');
      sql.Add('where a."Site Code" = b."Site Code"');
      sql.Add('AND a."Supplier Name" = b."Supplier Name"');
      sql.Add('AND a."Delivery Note No." = b."Delivery Note No."');
      i := ExecSQL;

      logstr := logstr + ', Prods: ' + inttostr(i);

      // if AccPurch is NOT empty delete the dummy record if it's there...
      close;
      sql.Clear;
      sql.Add('if (select count([site code]) from AccPurch) > 1');
      sql.Add('Delete AccPurch ');
      sql.Add('where "Supplier Name" = ''   DUMMY'' and "Delivery Note No." = ''   DUMMY''');
      execSQL;


      // 6.
      // delete from purchase ....
      errstr := 'Delete from Purchase';
      close;
      sql.Clear;
      sql.Add('delete Purchase from Purchase a, [#ghost] c');
      sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
      sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
      execSQL;

    except
      on E:exception do
      begin
        // Error in transaction, attempt to rollback
        if dmADO.AztecConn.InTransaction then
        begin
          dmADO.RollbackTransaction;

          if not data1.blindRun then
          showMessage('Transaction Error trying to accept Purchases! (' + errstr + ')' + #13 + #13 +
            'Error Message: ' + E.Message + #13 + #13 +
            'The ' + data1.SSlow + ' will not be Accepted.');

          log.event('Error in Accept Purchases - Trans. Rolled Back (' + errstr + '): ' + E.Message);
        end
        else
        begin
          if not data1.blindRun then
          showMessage('Transaction Error trying to accept Purchases! (' + errstr + ')' + #13 + #13 +
            'Error Message: ' + E.Message + #13 + #13 +
            'The ' + data1.SSlow + ' will not be Accepted.' + #13 +
            'Data Integrity concerning Purchases may have been compromised!');

          log.event('Error in Accept Purchases - Trans. NOT Rolled Back (' + errstr + '): ' + E.Message);

        end;

        exit;
      end;
    end;

    close;
    // [Site Code], [Supplier Name], [Delivery Note No.], [Record ID]
    dmADO.CommitTransaction;
    log.event('Accept AZ Purchases OK = ' + logstr);

    Result := True;
  end;
end; // procedure..

function TdmAccPurch.UnAcceptPurchases: boolean;
Var
  StartDate: TDateTime;
  NonStockedStartDate : TDateTime;
  syr,smth,sday,
  eyr,emth,eday : Word;
  i, sint, eint : integer;
begin
  // prepare special string for modified by field...
  // take the last 4 digits of the stock code
  ssuser := inttostr(data1.StkCode);
  ssuser := copy(ssuser, max(length(ssuser) - 3, 1), 4);
  // add thread id. if tid > 99 keep just its last 2 digits
  ssuser := copy(inttostr(data1.CurTid),max(length(inttostr(data1.CurTid)) - 1, 1), 2) +'-'+ ssuser;
  ssuser := ' StkUn' + ssuser;

  dmADO.DelSQLTable('#ghost');
  dmADO.DelSQLTable('#TempPurch');
  dmADO.DelSQLTable('#NonActiveDivisions');

  with data1.adoqRun do
  begin
    // first get the Biggest End Date for all OTHER accepted stocks of THIS division.
    // If THIS stock's End Date <= Biggest End Date then no purchases can be un-accepted
    // If THIS stock's End Date > Biggest End Date then un-accept the invoices
    //   with invoice date > Biggest End Date that contain even 1 item from THIS division.
    //   or a divsion for which no active stock thread exists

    // IGNORE threads with NoPurAcc = Y

    close;
    sql.Clear;
    sql.Add('SELECT [Division Name]');
    sql.Add('INTO #NonActiveDivisions');
    sql.Add('FROM division');
    sql.Add('WHERE [division name] not in');
    sql.Add('	(SELECT division');
    sql.Add('	 FROM threads');
    sql.Add('	 WHERE isNull(Active, ''N'') = ''Y'')');
    execSQL;

    close;
    sql.Clear;
    sql.Add('select a.division, max(a.edate) as maxdate');
    sql.Add('from stocks a, threads b ');
    sql.Add('where a.division = ' + quotedStr(data1.TheDiv));
    sql.Add('and not (a.tid = ' + inttostr(data1.CurTid));
    sql.Add('          and a.stockcode = ' + inttostr(data1.StkCode) + ')');
    sql.Add('and a.stockcode not in ');
    sql.Add('	        (select stockcode');
    sql.Add('             from stocks x');
    sql.Add('             where x.tid = isnull((select z.SlaveTh');
    sql.Add('                                   from Threads z');
    sql.Add('                                   where z.tid = ' + inttostr(data1.CurTid) + ' and z.SlaveTh > 0), -1) and');
    sql.Add('		       x.edt = (Select EDT');
    sql.Add('                           from stocks y');
    sql.Add('                           where y.tid = '+ inttostr(data1.CurTid) + ' and y.stockcode = ' + inttostr(data1.StkCode) + '))');
    sql.Add('and a.stockcode > 1');
    sql.Add('and a.tid = b.tid');
    sql.Add('and ((b.NoPurAcc <> ''Y'') or (b.NoPurAcc is NULL))');
    sql.Add('group by a.division');
    open;

    MaxEDate := FieldByName('maxdate').asdatetime; // enddate of the latest stock of this Div
                                                   // from all threads, except THIS stock
    close;
    sql.Clear;
    sql.Add('select max(a.edate) as LastStockTime');
    sql.Add('FROM stocks a JOIN threads b ON a.tid = b.tid ');
    sql.Add('WHERE a.division <> ' + quotedStr(data1.TheDiv));
    sql.Add('   AND ISNULL(b.NoPurAcc, ''N'') <> ''Y''');
    log.event(sql.Text);
    execSQL;
    open;

    NonStockedStartDate := FieldByName('LastStockTime').asdatetime;

    if MaxEDate >= data1.Edate then
    begin
      // nothing to un-accept, get out
      log.event('No purchases to Un-Accept (other stocks for this Div have later end dates).');
      Result := True;
      close;
      exit;
    end
    else
    begin
      // only un-accept invoices with date > MaxEDate
      // this MaxEDate is either > sDate for this stock (if from another thread)
      // or it is sDate - 1 (same thread, stock just before THIS one).
      StartDate := MaxEDate + 1;
      log.event('About to Un-Accept purchases from date = ' + formatDateTime('dd/mmm/yy',StartDate));
    end;

    // select all invoices from AccPurHd from the start date
    // include invoices from AccPurHd that have a start date greater than that from
    // any other thread
    // look only for the products of those selected invoices in AccPurch and chunks
    // with the division for each product of the selected stock
    // get distinct invoice key (deliv note no, supplier, etc.) in #ghost

    close;
    sql.Clear;
    sql.Add('SELECT distinct a."site code", c."Supplier Name", c."Delivery Note No.",');
    sql.Add('c."date", c."note", c."order no", b."div"');
    sql.Add('INTO [#ghost]');
    sql.Add('FROM "stkEntity" b, "AccPurHd" c, "accpurch" a');
    sql.Add('WHERE ((c."date" >= ' +#39+formatDateTime('mm/dd/yy',StartDate)+#39);
    sql.Add('AND b."div" = ' + quotedStr(data1.TheDiv) + ')');
    sql.Add(' OR (c."date" >= ' +#39+formatDateTime('mm/dd/yy',NonStockedStartDate)+#39);
    sql.Add('     and c."date" >= ' +#39+formatDateTime('mm/dd/yy',StartDate)+#39);
    sql.Add('and b."div" in (SELECT * FROM #NonActiveDivisions)))');
    sql.Add('AND a."entity code" = b."entitycode"');
    sql.Add('AND a."site code" = c."site code"');
    sql.Add('AND a."Supplier name" = c."Supplier name"');
    sql.Add('AND a."delivery note no." = c."delivery note no."');
    log.event(' un accept SQL');
    log.event(sql.Text);
    execSQL;
    close;

    // delete all entries who's dates fall before the last date for any division
    // not being unaccepted
    close;
    sql.Clear;
    sql.Add('delete from #ghost where [date] <= '
        +#39
        +formatDateTime('mm/dd/yy',NonStockedStartDate)
        +#39
        +' and "div" in (SELECT * FROM #NonActiveDivisions)');
    execSQL;
    close;
    // #ghost now holds some of the invoice headers involved...
    // chunks...
    //--------------------------

    DecodeDate(StartDate,syr,smth,sday);
    DecodeDate(Date,eyr,emth,eday);

    sint := (syr * 12) + smth;
    eint := (eyr * 12) + emth;

    while sint <= eint do
    begin
      try
        with data1.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('Insert INTO [#ghost] ("site code", "Supplier Name", "Delivery Note No.",');
          sql.Add('   "date", "note", "order no")');
          sql.Add('SELECT distinct a."site code", c."Supplier Name", c."Delivery Note No.",');
          sql.Add('c."date", c."note", c."order no"');
          sql.Add('FROM "stkEntity" b, "AccPurHd" c, "acc' + formatDateTime('mmmyy',StartDate) + '" a');
          sql.Add('WHERE c."date" >= '
                            +#39+formatDateTime('mm/dd/yy',(MaxEDate + 1))+#39);
          sql.Add('AND a."entity code" = b."entitycode"');
          sql.Add('AND a."site code" = c."site code"');
          sql.Add('AND a."Supplier name" = c."Supplier name"');
          sql.Add('AND a."delivery note no." = c."delivery note no."');
          sql.Add('and b."div" = ' + quotedStr(data1.TheDiv));
          execSQL;
        end; //with

      except
        //table does not exist
      end; //try

      StartDate := IncMonth(StartDate,1);
      DecodeDate(StartDate,syr,smth,sday);
      sint := (syr * 12) + smth;
    end; // while

    // all invoice headers to be un-accepted are now in ghost

    // Delete from #Ghost any duplicate purchases that may cause a key violation when
    // Inserted into Purrhcase table

    close;
    sql.Clear;
    sql.Add('Delete [#Ghost] FROM [#Ghost] a,');
    sql.Add('  (SELECT [Site Code], [Supplier Name],  [Delivery Note No.], Max(DIV) as MaxDiv');
    sql.Add('   FROM [#Ghost]');
    sql.Add('   GROUP BY [Site Code], [Supplier Name], [Delivery Note No.] Having Count(*) > 1) b');
    sql.Add('WHERE  a.[Site Code] = b.[Site Code] AND a.[Supplier Name] = b.[Supplier Name]');
    sql.Add('  AND a.[Delivery Note No.] = b.[Delivery Note No.] AND b.MaxDiv <> a.Div');
    ExecSQL;

    close;
    sql.Clear;
    sql.Add('select * from #ghost');
    open;

    if recordcount = 0 then // no invoices to un-accept were found...
    begin
      log.event('No purchases to Un-Accept (none found for given date).');
      Result := True;
      close;
      exit;
    end;

    //1. gather all these products in #temppurch
    close;
    sql.Clear;
    sql.Add('select a.*, (' + quotedStr(ssuser) + ') as Modifiedby,');
    sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:mm:ss.zzz', now)) + ') as lmdt');
    sql.Add('INTO [#tempPurch]');
    sql.Add('FROM "accpurch" a, [#ghost] c');
    sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
    sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
    i := execSQL;

    if i > 0 then
    begin
      // guard against key violations if for any reason records in ACCPurch are also in purchase
      close;
      sql.Clear;
      sql.Add('delete Purchase from Purchase a, [#ghost] c');
      sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
      sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
      execSQL;

      //2. insert in Purchase
      close;
      sql.Clear;
      sql.Add('INSERT INTO Purchase ("site code", "Supplier Name", "Delivery Note No.",');
      sql.Add('"Record Id", "Entity Code", "Purchase Name", "Flavour", "Quantity", "Unit Name",');
      sql.Add('"Cost Per Unit", "Total Cost", "Shortage",');
      sql.Add('"LMDt", "Modified by")');
      sql.Add('SELECT "site code", "Supplier Name", "Delivery Note No.",');
      sql.Add('"Record Id", "Entity Code", "Purchase Name", "Flavour", "Quantity", "Unit Name",');
      sql.Add('"Cost Per Unit", "Total Cost", "Shortage",');
      sql.Add('"LMDT", "Modifiedby" From [#tempPurch]');
      execSQL;

      //3. delete from accPurch
      close;
      sql.Clear;
      sql.Add('delete AccPurch from accpurch a, [#tempPurch] c');
      sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
      sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
      execSQL;

      //4. if AccPurch is empty insert a dummy record...
      close;
      sql.Clear;
      sql.Add('if (select count([site code]) from AccPurch) = 0');
      sql.Add('INSERT AccPurch ("site code", "Supplier Name", "Delivery Note No.", "Record Id")');
      sql.Add('VALUES (' + inttostr(data1.TheSiteCode)  + ', ''   DUMMY'', ''   DUMMY'', 9999)');
      execSQL;
    end;

    // do the same for any chunks used...
    StartDate := MaxEDate + 1;
    DecodeDate(StartDate,syr,smth,sday);
    DecodeDate(Date,eyr,emth,eday);

    sint := (syr * 12) + smth;
    eint := (eyr * 12) + emth;

    while sint <= eint do
    begin
      try
        with data1.adoqRun do
        begin
          dmADO.DelSQLTable('#TempPurch');

          //1. gather all these products in #temppurch
          close;
          sql.Clear;
          sql.Add('select a.*, (' + quotedStr(ssuser) + ') as Modifiedby,');
          sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:mm:ss.zzz', now)) + ') as lmdt');
          sql.Add('INTO [#tempPurch]');
          sql.Add('FROM "acc' + formatDateTime('mmmyy',StartDate) + '" a, [#ghost] c');
          sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
          sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
          i := execSQL;

          if i > 0 then
          begin
            // guard against key violations if for any reason records in ACCPurch are also in purchase
            close;
            sql.Clear;
            sql.Add('delete Purchase from Purchase a, [#ghost] c');
            sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
            sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
            execSQL;
            //2. insert in Purchase
            close;
            sql.Clear;
            sql.Add('INSERT INTO Purchase ("site code", "Supplier Name", "Delivery Note No.",');
            sql.Add('"Record Id", "Entity Code", "Purchase Name", "Flavour", "Quantity", "Unit Name",');
            sql.Add('"Cost Per Unit", "Total Cost", "Shortage",');
            sql.Add('"LMDt", "Modified by")');
            sql.Add('SELECT "site code", "Supplier Name", "Delivery Note No.",');
            sql.Add('"Record Id", "Entity Code", "Purchase Name", "Flavour", "Quantity", "Unit Name",');
            sql.Add('"Cost Per Unit", "Total Cost", "Shortage",');
            sql.Add('"LMDT", "Modifiedby" From [#tempPurch]');
            execSQL;

            //3. delete from accPurch
            close;
            sql.Clear;
            sql.Add('delete "acc' + formatDateTime('mmmyy',StartDate) + '" ');
            sql.Add('from "acc' + formatDateTime('mmmyy',StartDate) + '" a, [#tempPurch] c');
            sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
            sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
            execSQL;
          end;
        end; //with

      except
        //table does not exist
      end; //try

      StartDate := IncMonth(StartDate,1);
      DecodeDate(StartDate,syr,smth,sday);
      sint := (syr * 12) + smth;
    end; // while

    // guard against key violations in PurchHdr
    close;
    sql.Clear;
    sql.Add('delete [PurchHdr]');
    sql.Add('from [PurchHdr] a, [#ghost] z');
    sql.Add('where a."site code" = z."site code"');
    sql.Add('AND a."Supplier name" = z."Supplier name"');
    sql.Add('AND a."delivery note no." = z."delivery note no."');
    execSQL;

    close;
    sql.Clear;
    sql.Add('Insert INTO [purchHdr] ("site code", "Supplier Name", "Delivery Note No.",');
    sql.Add('   "lmdt", "modified by", "date", "note", "order no")');
    sql.Add('SELECT distinct c."site code", c."Supplier Name", c."Delivery Note No.",');
    sql.Add('"Lmdt" = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:mm:ss.zzz', now)) + ',');
    sql.Add('"Modified by" = ' + quotedStr(ssuser) + ',');
    sql.Add('c."date", c."note", c."order no"');
    sql.Add('FROM [#ghost] c');
    execSQL;

    close;
    sql.Clear;
    sql.Add('delete AccPurHd');
    sql.Add('FROM accPurHd a, [#ghost] c');
    sql.Add('where c."site code" = a."site code" and c."Supplier Name" = a."Supplier Name"');
    sql.Add('and c."Delivery Note No." = a."Delivery Note No."');
    execSQL;

    Result := True;
  end;
end;

end.
