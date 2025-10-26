unit dShiftMatch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, math, Variants, ADODB, DateUtils;

type
  TdmShiftMatch = class(TDataModule)
    SchdlTable: TADOTable;
    wwtRun: TADOTable;
    wwtRun3: TADOTable;
    wwtRun2: TADOTable;
    wwqRun: TADOQuery;
    wwqRun2: TADOQuery;
    procedure dmMainCreate(Sender: TObject);
    procedure SchdlTableBeforePost(DataSet: TDataSet);
    procedure SchdlTableNewRecord(DataSet: TDataSet);
    procedure SchdlTableUpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
  private
    over24, fromDOS : integer;
    errstring1, errstring2: string;
    escount: integer;
    logstr1, logstr2, logstr3, logstr4: string;
    leevar, gracetm, leeway1, leeway2, grace, roll: string;
    siteno: Integer;
    paidflag, matchflag: boolean;

    empNewLADT, pzNewLADT: tdatetime;
    schlow, schhigh, dtroll, dtgrace : tdatetime;

    loglist : TStringList;
    procedure PatchShifts;
    function fixed_strtotime(timestr: string): TDateTime;
    function GetAztecData: integer;
    procedure InitValues;
    procedure LogInfo;
    procedure ConvertFieldsToDateTime;
    procedure DoMatch;
    procedure EditSchedule;
    procedure Matching;
    procedure UnMatched;
  end;

var
  dmShiftMatch: TdmShiftMatch;

implementation

uses uGlobals, BDE, dmodule1, uADO, uLog, uEPoSDevice;

{$R *.DFM}

procedure TdmShiftMatch.dmMainCreate(Sender: TObject);
begin
  try
    loglist := TStringList.Create;
    log.SetModule('ShiftMatch');

    InitValues;
    if empNewLADT < pzNewLADT then
    begin
      try
        dmADO.BeginTransaction;
        matchflag := true;

        Matching;
        // 5.3.2 changed to make sure the newest audit DT is recorded...

        with dmod1.wwtSiteVar do
        begin
          open;
          edit;
          fieldbyname('NewLADT').value := pzNewLADT;
          fieldbyname('LastAdtDate').AsDateTime := int(pzNewLADT);
          fieldbyname('LastAdtTime').AsString := formatDateTime('hh:nn', pzNewLADT);
          post;
        end;

        if matchflag then
        begin
          with loglist do
          begin
            Clear;
            add('->->-> ERROR. Error String: ' + errstring1);
            if errstring2 <> '' then
              add('++>' + errstring2);
          end;
          LogInfo;

          // keep the oldest saved data just in case...
          if dmADO.SQLTableExists('backsch2') then
          begin
            with wwqRun do
            begin
              close;
              sql.Clear;
              sql.Add('select * into [S' + formatDateTime('ddmmyyhhnn', now) + '] from backsch2');
              execSQL;
            end;
          end
          else
          begin
            with loglist do
            begin
              Clear;
              add('->->-> ERROR. Could not back up data from BackSch2 table as it does not exist.');
            end;
            LogInfo;
          end;
        end
        else
        begin
          // back up BackSch1.db to BackSch2.db and Schedule to BackSch1.db
          if dmADO.SQLTableExists('backsch2') then
            dmAdo.DelSQLTable('backsch2');

          with wwqRun do
          begin
            if dmADO.SQLTableExists('backsch1') then
            begin
              close;
              sql.Clear;
              sql.Add('select * into dbo.backsch2 from backsch1');
              execSQL;

              dmAdo.DelSQLTable('backsch1');
            end
            else
            begin
              with loglist do
              begin
                Clear;
                add('->->-> WARNING. Could not copy data from BackSch1 table into BackSch2 table as BackSch1 does not exist.');
              end;
              LogInfo;
            end;

            close;
            sql.Clear;
            sql.Add('select * into dbo.backsch1 from schedule');
            execSQL;
          end;

          with loglist do
          begin
            Clear;
            add('Matching Ended OK. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
          end;
          LogInfo;
        end;
        matchflag := false;

        dmADO.CommitTransaction;
      except
        on E:exception do
        begin
          with loglist do
          begin
            Clear;
            add('->->-> ERROR. Error String: ' + errstring1);
            if errstring2 <> '' then
              add('++' + errstring2);
            add('Delphi Message: ' + E.Message);
          end;
          LogInfo;
          raise;
        end;
      end; // try..except

    end
    else
    begin
        loglist.Clear;
        with loglist do
        begin
          add('Ext Match Exit - NO PROCESSING DONE: No new Audit Read found;');
          add('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        end;
        LogInfo;

    end;
  finally
    if dmADO.InTransaction then
      dmADO.RollbackTransaction;

    log.SetModule('');
  end;
end;

procedure TdmShiftMatch.InitValues;
begin
  with wwqRun do // get rollover time
  begin
    close;
    sql.Clear;
    sql.Add('select "rollover time" from timeout');
    open;
    roll := FieldByName('rollover time').asstring;
    close;
  end;

  dmod1.wwtsysvar.open;
  siteno := uGlobals.SiteCode;
  //siteno := wwtsysvar.fieldbyname('site').asinteger;

  gracetm := dmod1.wwtsysvar.fieldbyname('grace').asstring;
  leeway1 := dmod1.wwtsysvar.fieldbyname('leeway1').asstring;
  leeway2 := dmod1.wwtsysvar.fieldbyname('leeway2').asstring;
  if gracetm = '' then
    gracetm := '00:00';
  if leeway1 = '' then
    leeway1 := '00:00';
  if leeway2 = '' then
    leeway2 := '00:00';

  dtroll := fixed_strtotime(roll);
  dtgrace := dtroll - fixed_strtotime(gracetm);
  grace := formatDateTime('hh:nn', dtgrace);
  if dmod1.wwtsysvar.fieldbyname('paidbreak').asstring = 'Y' then
    paidflag := true
  else
    paidflag := false;

  dmod1.wwtmastervar.open;
  uGlobals.stweek := dmod1.GetSiteStartOfWeek(siteno);

  {PW: open Sitevar table, for site}
  with dmod1.wwtSiteVar do
  begin
    open;
    empNewLADT := fieldbyname('NewLADT').asdatetime;
  end;

  loglist.Clear;
  with loglist do
  begin
    add('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    add('Ext Match started at: ' + DateTimeToStr(Now) + ' ;');
    add('Global variables state = ' +
      'roll time: ' + roll + '; grace: ' + gracetm + '; grace time: ' + grace +
      '; grace as DT: ' + floattostr(dtgrace) +  '; lway1: ' + leeway1 + '; lway2: ' + leeway2);
  end;

  with wwqRun do
  begin
    // are there any AzTabs with Read error?
    Close;
    sql.Clear;
    sql.Add('SELECT  a.[TerminalID], t.POSCode, a.LRDT, a.ErrorOnLastRead, a.ErrorReason, t.[Name]');
    sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
    sql.Add('WHERE t.HardwareType = h.HardwareType');
    SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
    sql.Add('and t.[SiteCode] = ' + inttostr(siteno));
    sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
    sql.Add('and t.POSCode = c.[POS Code]');
    sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
    sql.Add(Format('and (h.HardwareType = %d and a.ErrorOnLastRead = 1)',[Ord(ehtAzTab)]));
    sql.Add('ORDER BY a.LRDT');
    open;

    if recordcount > 0 then
    begin
      while not eof do
      begin
        loglist.Add('  -- AzTab READ ERROR TermID: ' + fieldbyname('TerminalID').AsString +  ', POS: ' +
              fieldbyname('POSCode').AsString + ', Name: ' + fieldbyname('Name').AsString + ', Last Read: ' +
              fieldByName('LRDT').AsString + ', Read Err: ' + fieldbyname('ErrorReason').AsString);
        next;
      end;
    end;

    Close;
    SQL.Clear;
    sql.Add('SELECT t.POSCode, a.LRDT');
    sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
    sql.Add('WHERE t.HardwareType = h.HardwareType');
    SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
    sql.Add('and t.[SiteCode] = ' + inttostr(siteno));
    sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
    sql.Add('and t.POSCode = c.[POS Code]');
    sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
    sql.Add(Format('and not (h.HardwareType = %d and a.ErrorOnLastRead = 1)',[Ord(ehtAzTab)]));
    sql.Add('ORDER BY a.LRDT');

    Open;
    pzNewLADT := FieldByName('LRDT').AsDateTime;
    close;

    with loglist do
    begin
      add('Audit Times: Tills Current Min LADT: ' + formatdatetime('mm/dd/yyyy hh:nn:ss', pzNewLADT) +
        '; Last LADT matched OK by EmpSys: ' + formatdatetime('mm/dd/yyyy hh:nn:ss', empNewLADT));
    end;
    LogInfo;
  end;
end; // procedure..

// MAIN Matching PROCEDURE WHICH CALLS ALL OTHER PARTS OF MATCHING PROCESS
procedure TdmShiftMatch.Matching;
var
  i : integer;
begin
  // first check that there is new data to process

  dmAdo.DelSQLTable('#ghost');

  if dmADO.SQLTableExists('#ClockInOutAndBreaks') then
    dmADO.DelSQLTable('#ClockInOutAndBreaks');

  i := GetAztecData;

  if i = 0 then
  begin
    loglist.Clear;
    with loglist do
    begin
      add('Ext Match - NO PROCESSING DONE: No new records in ClockedShifts;');
      add('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    end;
    LogInfo;
    matchflag := false;
    exit;
  end;


  with wwqRun do
  begin
    close;
    SQL.Clear;
    SQL.Add('CREATE TABLE [dbo].[#ClockInOutAndBreaks] (');
    SQL.Add('    [Site Code] [smallint] NULL ,');
    SQL.Add('    [UserId] [bigint] NULL ,');
    SQL.Add('    [Date In] [datetime] NULL ,');
    SQL.Add('    [Time In] [varchar] (5)  NULL ,');
    SQL.Add('    [Date Out] [datetime] NULL ,');
    SQL.Add('    [Time Out] [varchar] (5)  NULL ,');
    SQL.Add('    [RoleId] [int] NULL ,');
    SQL.Add('    [Break] [smallint] NULL,');
    SQL.Add('    [ClockedPaySchemeVersionId] [int] NULL,');
    SQL.Add('    [ClockedUserPayRateOverrideVersionID] [int] NULL');
    SQL.Add(') ON [PRIMARY]');
    ExecSQL;
    SQL.Clear;
    SQL.Add('CREATE  UNIQUE  CLUSTERED  INDEX [PK_ClockInOutAndBreaks] ON [dbo].[#ClockInOutAndBreaks]([Site Code], [UserId], [Date In], [Time In]) ON [PRIMARY]');
    ExecSQL;

    close;
    sql.Clear;
    sql.Add('SET ANSI_NULLS OFF');
    sql.Add('');
    sql.Add('INSERT INTO #ClockInOutAndBreaks ');
    sql.Add('("Site code", UserId, "Date in", "Time in", "Date out",');
    sql.Add('"Time out", RoleId, "break", "ClockedPaySchemeVersionId",');
    sql.Add('"ClockedUserPayRateOverrideVersionID")');
    sql.Add('SELECT t."Site code", t.UserId, t."Date in", t."Time in", t."Date out",');
    sql.Add('t."Time out", t.RoleId, t."break", t."ClockedPaySchemeVersionId",');
    sql.Add('t."ClockedUserPayRateOverrideVersionID" FROM #ghost AS t');
    sql.Add('SET ANSI_NULLS ON');
    ExecSql;

    close;
    sql.Clear;
    sql.Add('select a."Site code", a.UserId, a."Date in", a."Time in", a."Date out",');
    sql.Add('a."Time out", a."break", a."RoleId", a."ClockedPaySchemeVersionId",');
    sql.Add('a."ClockedUserPayRateOverrideVersionID"');
    sql.Add('from "#ClockInOutAndBreaks" a');
    open;

    if recordcount = 0 then
    begin
      matchflag := false;
      close;
      exit;
    end;
  end;

  // at this point there is data to match, leave wwqRun open for Convert...
  // log the action..
  loglist.clear;
  with loglist do
  begin
    add('External Matching started ;');
  end;
  LogInfo;
  // end of logging..

  // from DOS empusck to emp empshift date + time -> datetime, tilljob -> jobid..
  errstring1 := 'Start Convert...';
  ConvertFieldsToDateTime;

  errstring1 := 'Start Do Match...';
  DoMatch;

  // log the action..
  loglist.clear;
  with loglist do
  begin
    add(logstr1);
    add(logstr2);
    if length(logstr3) > 500 then
      logstr3 := copy(logstr3, 1, 500) +  'Only 500 chars shown!';
    add(logstr3);
    if length(logstr4) > 500 then
      logstr4 := copy(logstr4, 1, 500) +  'Only 500 chars shown!';
    add(logstr4);
  end;
  LogInfo;
  // end of logging..

  errstring1 := 'Start Edit Schedule...';
  EditSchedule;

  matchflag := false;
end;

// RECORDS FROM EMPUSCK.DB CONTAIN SEPARATE FIELDS FOR DATE AND TIME BUT THESE ARE
// COMBINED INTO A DATETIME FIELD AND THE RESULTANT RECORDS ARE PLACED INTO EMPSHIFT.db
// TABLE
// wwqRun : selected recs from #ClockInOutAndBreaks (taken from dos.empusck.db),
// wwqRun2 : list of jobs,
// wwtRun : empshift.db
procedure TdmShiftMatch.ConvertFieldsToDateTime;
var
  timein, timeout : TDateTime;
begin
  wwtRun.close;
  wwtRun.TableName := '#empshift';
  wwtRun2.close;
  wwtRun2.TableName := 'eOver24h';
  wwtRun.open;
  wwtRun2.open;
  with wwqRun do // left open from Matching proc (top part)
  begin
    fromDOS := recordcount;
    over24 := 0;
    first;
    while not eof do
    begin
      timein := (fieldbyname('date in').asdatetime)
        + fixed_strtotime(fieldbyname('Time in').asstring);
      timeout := (fieldbyname('date out').asdatetime)
        + fixed_strtotime(fieldbyname('Time out').asstring);

      if timeout - timein >= 1.0 then // shift over 24 hrs!!!!
      begin
        wwtRun2.insert;
        wwtRun2.fieldbyname('site').asinteger := fieldbyname('site code').asinteger;
        wwtRun2.fieldbyname('sec').Value := fieldbyname('UserId').value;
        wwtRun2.fieldbyname('Clockin').asdatetime := timein;
        wwtRun2.fieldbyname('Clockout').asdatetime := timeout;
        wwtRun2.fieldbyname('tin').asdatetime := TimeOf(timein);
        wwtRun2.fieldbyname('tout').asdatetime := TimeOf(timeout);
        wwtRun2.fieldbyname('din').asdatetime := DateOf(timein);
        wwtRun2.fieldbyname('dout').asdatetime := DateOf(timeout);
        wwtRun2.fieldbyname('Break').asdatetime := encodetime((min(1439,fieldbyname('break').asinteger)
          div 60), (min(1439,fieldbyname('break').asinteger) mod 60), 0, 0);
        wwtRun2.FieldByName('JobId').AsInteger := fieldbyname('RoleId').asinteger;
        wwtRun2.FieldByName('insDT').asdatetime := Now;
        wwtRun2.FieldByName('match').asstring := 'N';
        wwtRun2.FieldByName('solved').asstring := 'N'; // N-not solved, D-deleted,
                                                       // M-modified & inserted in schedule
        wwtRun2.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
        wwtRun2.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;

        try
          wwtRun2.post;
          inc(over24);
        except
          on Exception do
            wwtRun2.cancel;
        end;
      end
      else
      begin
        wwtRun.insert;
        wwtRun.fieldbyname('site').asinteger := fieldbyname('site code').asinteger;
        TLargeIntField(wwtRun.fieldbyname('UserId')).AslargeInt := fieldbyname('UserId').Value;
        wwtRun.fieldbyname('Clockin').asdatetime := timein;
        wwtRun.fieldbyname('Clockout').asdatetime := timeout;
        wwtRun.fieldbyname('Break').asdatetime := encodetime((min(1439,fieldbyname('break').asinteger)
          div 60), (min(1439,fieldbyname('break').asinteger) mod 60), 0, 0);
        wwtRun.fieldbyname('RoleId').asinteger := fieldbyname('RoleId').asinteger;
        wwtRun.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
        wwtRun.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
        wwtRun.post;
      end;

      next;
    end;
    close;
  end;
  //wwqRun2.close;

  with wwqRun do
  begin
    close; // DELETES EVERYTHING confirmed by user from empshift
    sql.Clear;
    sql.Add('delete #empshift from #empshift e, schedule a');
    sql.Add('where e.site = a."sitecode" and e.UserId = a.UserId and e.clockin = a."clockin"');
    sql.Add('and a."clockin" >= ''' +
      formatdatetime('mm/dd/yyyy', empNewLADT - 1) + '''');
    sql.Add('and (a."visible" = ''N'' or a."confirmed" = ''Y'')');
    execSQL;

    close;
  end;
end; // proc ConvertFieldsToDateTime...


// PERFORMS MATCHING PROCESS BETWEEN SHIFTS WHICH ARE SCHEDULED AND THOSE THAT HAVE
// BEEN WORKED
procedure TdmShiftMatch.DoMatch;
var
  UserId: Int64;
begin

  wwtRun3.close;
  wwtRun3.TableName := '#schbatch';
  wwtRun3.open;
  SchdlTable.open;

  wwtRun2.close;
  wwtRun2.TableName := '#matching';
  wwtRun2.open;

  with wwqRun do
  begin
    // get the low and high limits of clock records to select only the required no.
    // of records from Schedule...
    close;
    sql.Clear;
    sql.Add('select (min(a."clockin")) as lowC,(max(a."clockout")) as highC');
    sql.Add('from "#empshift" a');
    open;
    schlow := FieldByName('lowC').asdatetime;
    schhigh := FieldByName('highC').asdatetime;

    close;
    sql.Clear;
    sql.Add('select * from Schedule a');
    sql.Add('where a."sitecode" = ' + inttostr(siteno));
    sql.Add('and a."schout" > ''' + formatdatetime('mm/dd/yyyy hh:nn:ss',schlow) + '''');
    sql.Add('and a."schin" < ''' + formatdatetime('mm/dd/yyyy hh:nn:ss',schhigh) + '''');
    sql.Add('and a."RoleId" <> ' + IntToStr(NULL_JOB_CODE));
    sql.Add('and a."visible" = ''Y''');
    sql.Add('and a."confirmed" = ''N''');
    sql.Add('and a."accin" is null and a."accout" is null'); // this bypasses all records that have found a...
    sql.Add('order by a."sitecode", a."UserId", a."schin"'); // match already or have had an auto-fill from schedule
    open;
    first;
    logstr1 := 'Sel. for match (Sch): ' + inttostr(recordcount) +
      ' records. SchLow: ' + formatdatetime(shortdateformat+'yy hh:nn:ss',schlow) +
      ' SchHigh: ' + formatdatetime(shortdateformat+'yy hh:nn:ss',schhigh);
  end;

  if leeway1 >= leeway2 then
    leevar := leeway1
  else
    leevar := leeway2;

  with wwtRun do
  begin
    close;
    tableName := '#empshift';
    open;
    first;
    escount := 1;
    logstr2 := 'Empshift has: ' + inttostr(recordcount) + ' recs.; ' +
      'Shifts read from DOS: ' + inttostr(fromDOS) +
      '; Shifts Over 24hrs: ' + inttostr(over24);
    logstr3 := 'Matched rec. nos. : ';
    logstr4 := 'Unmatched rec. nos. : ';

    // ALL RECORDS WHICH ARE MATCHED ARE PLACED INTO MATCHING TABLE
    while not eof do
    begin
      if wwqRun.fieldbyname('UserId').Value = fieldbyname('UserId').Value then
      begin
        if (wwqRun.fieldbyname('Schin').asdatetime - fixed_strtotime(leevar)) <=
          fieldbyname('Clockout').asdatetime then
        begin
          if (wwqRun.fieldbyname('Schout').asdatetime + fixed_strtotime(leevar)) >=
            fieldbyname('Clockin').asdatetime then
          begin
            // now check that the Scheduled shift was not "claimed" already by a previous
            // clock shift; if it was then keep looking or leave the clocked shift "Unmatched"
            with wwqRun2 do
            begin
              Close;
              sql.Clear;
              sql.Add('select count(*) as Shifts from #matching a');
              sql.Add('where a."site" = ' + inttostr(siteno));
              sql.Add('and a."UserId" = ' + wwqRun.fieldbyname('UserId').AsString);
              sql.Add('and a."schin" = ''' + formatdatetime('mm/dd/yyyy hh:nn:ss', wwqRun.fieldbyname('schin').asdatetime) + '''');
            end;

            wwqRun2.Open;

            if wwqRun2.fieldbyname('Shifts').AsInteger = 0 then
            begin
              // at this point the time intervals from schedule and from empshift
              // have some common period so they are considered matched...
              wwtRun2.insert;
              TLargeIntField(wwtRun2.fieldbyname('UserId')).AsLargeInt := fieldbyname('UserId').Value;
              wwtRun2.fieldbyname('site').asinteger := fieldbyname('site').asinteger;
              wwtRun2.fieldbyname('schin').asdatetime := wwqRun.fieldbyname('schin').asdatetime;
              wwtRun2.fieldbyname('clockin').asdatetime := fieldbyname('clockin').asdatetime;
              wwtRun2.fieldbyname('clockout').asdatetime := fieldbyname('clockout').asdatetime;
              wwtRun2.fieldbyname('FIn').asfloat := fieldbyname('clockin').asdatetime;
              wwtRun2.fieldbyname('FOut').asfloat := fieldbyname('clockout').asdatetime;
              wwtRun2.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
              wwtRun2.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
               wwtRun2.fieldbyname('RoleId').asInteger := fieldbyname('RoleId').asInteger;
              wwtRun2.fieldbyname('fBreak').asfloat := fieldbyname('break').asdatetime;
              try
                wwtRun2.post;
                logstr3 := logstr3 + inttostr(escount) + ', ';
              except
                on E: exception do
                begin
                  wwtRun2.cancel;
                end;
              end;
              next;
              escount := escount + 1;
            end
            else begin // scheduled shift already "claimed" by another Clocked shift...
              wwqRun.next; // try another scheduled shift...
              if wwqRun.eof then
              begin     // gone through all the Scheduled shifts that could match this...
                while not eof do
                begin
                  Unmatched;
                  next;
                  escount := escount + 1;
                end;
                close;
                wwtRun2.close;
                wwqRun.close;
                wwtRun3.close;
                exit;
              end;

              if not (wwqRun.fieldbyname('UserId').Value = fieldbyname('UserId').Value) then
              begin
                UserId := fieldbyname('UserId').Value;
                while (UserId = fieldbyname('UserId').Value) and (not eof) do
                begin
                  Unmatched;
                  next;
                  escount := escount + 1;
                end;
              end;
            end;
          end
          else begin
            wwqRun.next; // try another scheduled shift...
            if wwqRun.eof then
            begin    // gone through all the Scheduled shifts that could match this...
              while not eof do
              begin
                Unmatched;
                next;
                escount := escount + 1;
              end;
              close;
              wwtRun2.close;
              wwqRun.close;
              wwtRun3.close;
              exit;
            end;
            if not (wwqRun.fieldbyname('UserId').Value = fieldbyname('UserId').Value) then
            begin
              UserId :=fieldbyname('UserId').Value;
              while (UserId = fieldbyname('UserId').Value) and (not eof) do
              begin
                Unmatched;
                next;
                escount := escount + 1;
              end;
            end;
          end; // if schout >= clockin .. else ..
        end
        else begin
          Unmatched;
          next;
          escount := escount + 1;
        end;
      end
      else begin// else of if UserIds match
        if not (wwqRun.locate('UserId', fieldbyname('UserId').Value, [])) then
        begin
          UserId := fieldbyname('UserId').Value;
          while (UserId = fieldbyname('UserId').Value) and (not eof) do
          begin
            Unmatched;
            next;
            escount := escount + 1;
          end;
        end; // end of if - locate
      end;
    end; // end of empshift (wwtRun) while not eof loop
    close;
    wwtRun2.close;
    wwtRun3.close;
    wwqRun.close;
  end; // end of with empshift (wwtRun)
end; // end of proc DoMatch


// INSERTS UNMATCHED RECORDS  INTO SCHEDULE BATCH TABLE AND MATCHING TABLE
// called from proc DoMatch (just above)
procedure TdmShiftMatch.UnMatched;
begin
  errstring2 := 'UnMatched Start';
  with wwtRun do // wwtRun is empshift.db, was set as such in proc DoMatch
  begin
    wwtRun3.insert; // wwtRun3 is schBatch.db, was set as such in proc DoMatch
    TLargeIntField(wwtRun3.fieldbyname('UserId')).AslargeInt := fieldbyname('UserId').Value;
    wwtRun3.fieldbyname('site').asinteger := fieldbyname('site').asinteger;
    wwtRun3.fieldbyname('schin').asdatetime := fieldbyname('clockin').asdatetime;
    wwtRun3.fieldbyname('schout').asdatetime := fieldbyname('clockin').asdatetime;
    wwtRun3.fieldbyname('clockin').asdatetime := fieldbyname('clockin').asdatetime;
    wwtRun3.fieldbyname('clockout').asdatetime := fieldbyname('clockout').asdatetime;
    wwtRun3.fieldbyname('Fworked').asfloat := (fieldbyname('clockout').asdatetime -
      fieldbyname('clockin').asdatetime);
    wwtRun3.fieldbyname('roleId').asinteger := NULL_JOB_CODE;
    wwtRun3.fieldbyname('wRoleId').asinteger := fieldbyname('RoleId').asinteger;
    wwtRun3.fieldbyname('fbreak').asfloat := fieldbyname('break').asdatetime;
    wwtRun3.fieldbyname('worked').asdatetime := (fieldbyname('clockout').asdatetime -
      fieldbyname('clockin').asdatetime) - fieldbyname('break').asdatetime;
    wwtRun3.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
    wwtRun3.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
    try
      wwtRun3.post;
    except
      on E: exception do
      begin
        wwtRun3.cancel;
      end;
    end;
    errstring2 := 'UnMatched Insert in Matching';
    wwtRun2.insert; // wwtRun2 is Matching.db, set as such in proc DoMatch
    TLargeIntField(wwtRun2.fieldbyname('UserId')).AsLargeInt := fieldbyname('UserId').Value;
    wwtRun2.fieldbyname('site').asinteger := fieldbyname('site').asinteger;
    wwtRun2.fieldbyname('schin').asdatetime := fieldbyname('clockin').asdatetime;
    wwtRun2.fieldbyname('clockin').asdatetime := fieldbyname('clockin').asdatetime;
    wwtRun2.fieldbyname('clockout').asdatetime := fieldbyname('clockout').asdatetime;
    wwtRun2.fieldbyname('Fin').asfloat := fieldbyname('clockin').asdatetime;
    wwtRun2.fieldbyname('FOut').asfloat := fieldbyname('clockout').asdatetime;
    wwtRun2.fieldbyname('fBreak').asfloat := fieldbyname('break').asdatetime;
    wwtRun2.fieldbyname('RoleId').asinteger := fieldbyname('RoleId').asinteger;
    wwtRun2.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
    wwtRun2.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
    try
      wwtRun2.post;
      logstr4 := logstr4 + inttostr(escount) + ', ';
    except
      on E: exception do
      begin
        wwtRun2.cancel;
      end;
    end;
  end;
  errstring2 := '';
end;

// MOVES ALL RECORDS FROM UNSCHEDULED TABLE AND MATCH TABLE INOT SCHEDULE TABLE

procedure TdmShiftMatch.EditSchedule;
begin
  wwtRun.close;
  wwtRun.TableName := '#schunmch';

  // in order to know exactly what records were given the clockin-out info
  // (or what records were added) just in this matching process run, put the string
  // "ZZ-999" in the PaySchemeVersionLMBy field. When pay rates are written to the schedule this
  // field will be used to select the records to be updated.

  // first clear the 'ZZ-999' from wherever it is in the Schedule table. It should be
  // in records that came in last time and who's rates were not modified...
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update schedule set "PaySchemeVersionLMBy" = null, LMDT = getDate()');
    sql.Add('where "PaySchemeVersionLMBy" = ''ZZ-999''');
    execSQL;
  end;

  //recs from Matching.db that perfectly match recs from schedule (same UserId, schin
  //and RoleId) are used to update Schedule.db (clock in/out, worked and break info)
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set clockin = q.clockin, clockout = q.clockout, fworked = q.fworked,');
    sql.Add('fbreak = q.fbreak, wRoleId = q.RoleId, cRoleId = q.RoleId, PaySchemeVersionLMBy = ''ZZ-999'',');
    sql.Add('ClockedPaySchemeVersionId = q.ClockedPaySchemeVersionId,');
    sql.Add('ClockedUserPayRateOverrideVersionID = q.ClockedUserPayRateOverrideVersionId,');
    sql.Add('LMDT = getDate()');
    sql.Add('from ');
    sql.Add(' (');
    sql.Add('   select  a."sitecode",a."UserId", a."schin", b."clockin",');
    sql.Add('   b."clockout", (b."Fout" - b."fin") as fworked,');
    sql.Add('   b."fbreak", b."RoleId", b."ClockedPaySchemeVersionId",');
    sql.Add('   b."ClockedUserPayRateOverrideVersionId"');
    sql.Add('     from schedule a, #matching b');
    sql.Add('     where b."site"= a."sitecode"');
    sql.Add('     and (b."UserId"= a."UserId")');
    sql.Add('     and (b."schin"= a."schin")');
    sql.Add('     and (a."RoleId" = b."RoleId")');
    sql.Add('     and (a."RoleId" <> ' + IntToStr(NULL_JOB_CODE) + ')');
    sql.Add(' ) q');
    sql.Add('where schedule."sitecode"= q."sitecode"');
    sql.Add('and schedule."UserId"= q."UserId"');
    sql.Add('and schedule."schin"= q."schin"');
    execSQL;

    errstring2 := 'Edit Sch. #1';

    // now delete all records from schbatch.db (which has all the unmatched recs from
    // empshift) that match the records transferred just now (site, UserId, schin). There
    // should be none but just in case...
    sql.Clear;
    sql.Add('delete #schbatch');
    sql.Add('from ');
    sql.Add(' (');
    sql.Add('    select  a."sitecode",a."UserId", a."schin"');
    sql.Add('    from schedule a, #matching b');
    sql.Add('    where b."site"= a."sitecode"');
    sql.Add('    and(b."UserId"= a."UserId")');
    sql.Add('    and(b."schin"= a."schin")');
    sql.Add('    and(a."RoleId" = b."RoleId")');
    sql.Add('    and(a."RoleId" <> ' + inttostr(NULL_JOB_CODE) + ')');
    sql.Add(' ) q');
    sql.Add('where #schbatch."site"= q."sitecode"');
    sql.Add('and #schbatch."UserId"= q."UserId"');
    sql.Add('and #schbatch."schin"= q."schin"');
    execSQL;

    close;
  end; // with wwqRun (recs from Matching updating the schedule table)

  errstring2 := 'Edit Sch. #2';

  // select all recs from Schedule that were not updated above (for any reason)
  // and put them in SchUnmch table to decide what to do with them...
  with wwqRun do
  begin
    close;
    sql.Clear;

    sql.Add('insert into #SchUnmch');
    sql.Add('(site, UserId, schin, schout, clockin, clockout, fworked, [break],');
    sql.Add(' fbreak, worked, RoleId, wRoleId, shift, ClockedPaySchemeVersionId,');
    sql.Add(' ClockedUserPayRateOverrideVersionId)');
    sql.Add('select a.sitecode, a.UserId, a.schin, a.schout, a.clockin, a.clockout,');
    sql.Add(' a.fworked, a.[break], a.fbreak, a.worked, a.RoleId, a.wRoleId, a.shift,');
    sql.Add(' a.ClockedPaySchemeVersionId, a.ClockedUserPayRateOverrideVersionId');
    sql.Add('from Schedule a');
    sql.Add('where a."sitecode" = ' + inttostr(siteno));
    sql.Add('and a."schout" > ''' + formatdatetime('mm/dd/yyyy hh:nn:ss',schlow) + '''');
    sql.Add('and a."schin" < ''' + formatdatetime('mm/dd/yyyy hh:nn:ss',schhigh) + '''');
    sql.Add('and a."RoleId" <> ' + inttostr(NULL_JOB_CODE));
    sql.Add('and a."visible" = ''Y''');
    sql.Add('and a."confirmed" = ''N''');
    sql.Add('and a."clockout" is null');
    sql.Add('and a."clockin" is null');
    execSQL;

    close;
    errstring2 := 'Edit Sch. #3';
  end;

  //select recs from Matching.db that partially match recs from schedule (same UserId, schin)
  //but NOT THE SAME JOBID, try to find these recs in SchUnmch (locate should always work
  //as schUnmch has ALL the unmatched recs), and put the clock in/out etc. info in these
  //recs. This matches records by time and employee but where the emps did not do the
  //scheduled job. Extra code (elses) is here to allow for 'crazy' worked shifts...
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select  b."site",a."UserId", a."schin", b."clockin",');
    sql.Add(' b."clockout",(b."Fout" - b."fin") as fwk,');
    sql.Add(' b."fbreak", b."RoleId", b."ClockedPaySchemeVersionId",');
    sql.Add(' b."ClockedUserPayRateOverrideVersionId"');
    sql.Add('from #matching b, schedule a');
    sql.Add('where b."site"= a."sitecode"');
    sql.Add('and(b."UserId"= a."UserId")');
    sql.Add('and(b."schin"= a."schin")');
    sql.Add('and(a."RoleId" <> b."RoleId")');
    sql.Add('and(a."RoleId" <> ' + inttostr(NULL_JOB_CODE) + ')');
    sql.Add('order by b.site, a.UserId, a.schin, b.clockin');
    open;
    first;
    errstring2 := 'Edit Sch. #4';
    if (fieldbyname('site').asstring <> '') and (not (FieldByName('UserId').value = null)) then
    begin
      wwtRun.open; // schunmch.db, set above
      while not eof do
      begin
        if (wwtRun.locate('site;UserId;schin', vararrayof([fieldbyname('site').asinteger,
          fieldbyname('UserId').Value, fieldbyname('schin').asdatetime]), [])) then
        begin
          if (wwtRun.fieldbyname('clockin').asstring = '') then
          begin
            wwtRun.edit;
            wwtRun.fieldbyname('clockin').asdatetime := FieldByName('clockin').value;
            wwtRun.fieldbyname('clockout').asdatetime := FieldByName('clockout').value;
            wwtRun.fieldbyname('fworked').asfloat := FieldByName('fwk').value;
            wwtRun.fieldbyname('fbreak').asfloat := FieldByName('fbreak').value;
            wwtRun.fieldbyname('wRoleId').asinteger := FieldByName('RoleId').value;
            wwtRun.fieldbyname('ClockedPaySchemeVersionId').Value := FieldByName('ClockedPaySchemeVersionId').value;
            wwtRun.fieldbyname('ClockedUserPayRateOverrideVersionId').Value := FieldByName('ClockedUserPayRateOverrideVersionId').value;
            wwtRun.post;
          end
          else
          begin // found the scheduled rec but already taken by some other worked shift - add as UNSCHEDULED
            wwtRun.insert;
            wwtRun.fieldbyname('site').asinteger := FieldByName('site').Value;
            TLargeIntField(wwtRun.fieldbyname('UserId')).AsLargeInt := FieldByName('UserId').Value;
            wwtRun.fieldbyname('schin').asdatetime := FieldByName('clockin').value;
            wwtRun.fieldbyname('schout').asdatetime := FieldByName('clockin').value;
            wwtRun.fieldbyname('clockin').asdatetime := FieldByName('clockin').value;
            wwtRun.fieldbyname('clockout').asdatetime := FieldByName('clockout').value;
            wwtRun.fieldbyname('fworked').asfloat := FieldByName('fwk').value;
            wwtRun.fieldbyname('fbreak').asfloat := FieldByName('fbreak').value;
            wwtRun.fieldbyname('RoleId').asinteger := NULL_JOB_CODE;
            wwtRun.fieldbyname('WRoleId').asinteger := FieldByName('RoleId').value;
            wwtRun.fieldbyname('ClockedPaySchemeVersionId').Value := FieldByName('ClockedPaySchemeVersionId').Value;
            wwtRun.fieldbyname('ClockedUserPayRateOverrideVersionId').Value := FieldByName('ClockedUserPayRateOverrideVersionId').Value;
            wwtRun.post;
          end; // if..else clockin = ''...
        end
        else
        begin // did not locate any scheduled shift waiting to be updated... - add as UNSCHEDULED
          wwtRun.insert;
          wwtRun.fieldbyname('site').asinteger := FieldByName('site').Value;
          TLargeIntField(wwtRun.fieldbyname('UserId')).AsLargeInt := FieldByName('UserId').Value;
          wwtRun.fieldbyname('schin').asdatetime := FieldByName('clockin').value;
          wwtRun.fieldbyname('schout').asdatetime := FieldByName('clockin').value;
          wwtRun.fieldbyname('clockin').asdatetime := FieldByName('clockin').value;
          wwtRun.fieldbyname('clockout').asdatetime := FieldByName('clockout').value;
          wwtRun.fieldbyname('fworked').asfloat := FieldByName('fwk').value;
          wwtRun.fieldbyname('fbreak').asfloat := FieldByName('fbreak').value;
          wwtRun.fieldbyname('RoleId').asinteger := NULL_JOB_CODE;
          wwtRun.fieldbyname('WRoleId').asinteger := FieldByName('RoleId').value;
          wwtRun.fieldbyname('ClockedPaySchemeVersionId').Value := FieldByName('ClockedPaySchemeVersionId').value;
          wwtRun.fieldbyname('ClockedUserPayRateOverrideVersionId').Value := FieldByName('ClockedUserPayRateOverrideVersionId').value;
          wwtRun.post;
        end; // if..else  locate...
        next;
      end; // while not eof...
      //wwtRun.close;
    end; // if fbn'clockin' <> '' ...
    close;
    errstring2 := 'Edit Sch. #5';
  end;

  // now some records form schUnmch have been matched by time (but with wrong job),
  // and some have been left unchanged (no clock in/out.. info). Some more records
  // might have been added. Delete the unchanged records and send the rest all back
  // to Schedule in AppendUpdate mode
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('delete from #schunmch');
    sql.Add('where "clockin" is null and "clockout" is null');
    execSQL;

    //replaces batUpdate
    close;
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set clockin = q.clockin, clockout = q.clockout, fworked = q.fworked, [break] = q.[break],');
    sql.Add('worked = q.worked, RoleId = q.RoleId, shift = q.shift, schout = q.schout,');
    sql.Add('fbreak = q.fbreak, wRoleId = q.wRoleId, cRoleId = q.wRoleId, PaySchemeVersionLMBy = sflag,');
    sql.Add('ClockedPaySchemeVersionId = q.ClockedPaySchemeVersionId,');
    sql.Add('ClockedUserPayRateOverrideVersionId = q.ClockedUserPayRateOverrideVersionId,');
    sql.Add('LMDT = getDate()');
    sql.Add('from schedule a, #schUnmch q');
    sql.Add('where a."sitecode"= q."site"');
    sql.Add('and a."UserId"= q."UserId"');
    sql.Add('and a."schin"= q."schin"');
    execSQL;

    errstring2 := 'Edit Sch. #6';

    // The records used to batAppendUpdate in Schedule should be deleted from schBatch, do it now
    sql.Clear;
    sql.Add('delete #schbatch');
    sql.Add('from #schUnmch a, #schbatch q');
    sql.Add('where a."site"= q."site"');
    sql.Add('and a."UserId"= q."UserId"');
    sql.Add('and a."schin"= q."schin"');
    execSQL;

    // replaces batAppend..

    // 1. delete the records in #schunmch just used to update schedule
    sql.Clear;
    sql.Add('delete #schunmch');
    sql.Add('from schedule a, #schUnmch q');
    sql.Add('where a."sitecode"= q."site"');
    sql.Add('and a."UserId"= q."UserId"');
    sql.Add('and a."schin"= q."schin"');
    execSQL;


    // 2. now insert into schedule whatever's left
    sql.Clear;
    sql.Add('insert into schedule');
    sql.Add('(sitecode, UserId, schin, schout, clockin, clockout, fworked, [break],');
    sql.Add(' fbreak, worked, RoleId, wRoleId, cRoleId, shift, PaySchemeVersionLMBy, LMDT,');
    sql.Add(' ClockedPaySchemeVersionId, ClockedUserPayRateOverrideVersionId)');
    sql.Add('select a.site, a.UserId, a.schin, a.schout, a.clockin, a.clockout,');
    sql.Add(' a.fworked, a.[break], a.fbreak, a.worked, a.RoleId, a.wRoleId, a.wRoleId, a.shift, a.sflag, getDate(),');
    sql.Add(' a.ClockedPaySchemeVersionId, a.ClockedUserPayRateOverrideVersionId');
    sql.Add('from  #schunmch a');
    execSQL;

    errstring2 := 'Edit Sch. #7';

  // schbatch still holds all unmatched recs. Some of them may have been matched as
  // 'good time wrong job' above and already the clock & worked info is in Schedule
  // it is probable that by now all original recs from schbatch.db have already been
  // sent to Schedule.db and so the table is empty but just in case it's not...
  // send them all there in AppendUpdate

    //replaces batUpdate
    close;
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set clockin = q.clockin, clockout = q.clockout, fworked = q.fworked, [break] = q.[break],');
    sql.Add('worked = q.worked, RoleId = q.RoleId, shift = q.shift, schout = q.schout,');
    sql.Add('fbreak = q.fbreak, wRoleId = q.wRoleId, cRoleId = q.wRoleId, PaySchemeVersionLMBy = sflag,');
    sql.Add('ClockedPaySchemeVersionId = q.ClockedPaySchemeVersionId,');
    sql.Add('ClockedUserPayRateOverrideVersionId = q.ClockedUserPayRateOverrideVersionId,');
    sql.Add('LMDT = getDate()');
    sql.Add('from schedule a, #schBatch q');
    sql.Add('where a."sitecode"= q."site"');
    sql.Add('and a."UserId"= q."UserId"');
    sql.Add('and a."schin"= q."schin"');
    execSQL;

  errstring2 := 'Edit Sch. #8';
    // replaces batAppend..

    // 1. delete the records in #schbatch just used to update schedule
    sql.Clear;
    sql.Add('delete #schbatch');
    sql.Add('from schedule a, #schbatch q');
    sql.Add('where a."sitecode"= q."site"');
    sql.Add('and a."UserId"= q."UserId"');
    sql.Add('and a."schin"= q."schin"');
    execSQL;


    // 2. now insert into schedule whatever's left
    sql.Clear;
    sql.Add('insert into schedule');
    sql.Add('(sitecode, UserId, schin, schout, clockin, clockout, fworked, [break],');
    sql.Add(' fbreak, worked, RoleId, WRoleId, CRoleId, shift, PaySchemeVersionLMBy,');
    sql.Add(' ClockedPaySchemeVersionId, ClockedUserPayRateOverrideVersionId,');
    sql.Add(' LMDT)');
    sql.Add('select a.site, a.Userid, a.schin, a.schout, a.clockin, a.clockout,');
    sql.Add(' a.fworked, a.[break], a.fbreak, a.worked, a.RoleId, a.WRoleId, a.WRoleId, a.shift, a.sflag,');
    sql.Add(' a.ClockedPaySchemeVersionId, a.ClockedUserPayRateOverrideVersionId,');
    sql.Add(' getDate()');
    sql.Add('from  #schbatch a');
    execSQL;


  end;

  errstring2 := 'Edit Sch. #9';
  //////////////////////////////////////////////////////////////////////////////
  // Introduce the pay rates here
  //////////////////////////////////////////////////////////////////////////////

  // first all employee-job matched or inserted records
  // get their rates from empjob.
  with wwqRun do
  begin
    close;
    sql.Clear;
    //PaySchemeVersionId/UserPayRateOverrideVersionID should be left as whatever
    //was scheduled and WorkedPaySchemeVersionId/WorkedUserPayRateOverrideVersionID
    //should be updated to be the same as the clocked values that were determined
    //when the clockedshifts entry was entered.
    sql.Add('update schedule');
    sql.Add('set WorkedPaySchemeVersionId = ClockedPaySchemeVersionId,');
    sql.Add('WorkedUserPayRateOverrideVersionID = ClockedUserPayRateOverrideVersionID,');
    SQL.Add('LMDT = getDate()');
    sql.Add('from schedule s');
    sql.Add('join ac_AllUserSites us');
    sql.Add('on s.UserId = us.UserId');
    sql.Add('where us.SiteId = ' + IntToStr(siteno));
    sql.Add('and s."PaySchemeVersionLMBy" = ''ZZ-999''');

    execSQL;

    errstring2 := 'Edit Sch. #11';
  end;

  // now the only recs left without pay info are the ones with
  // WRoleId = NULL_JOB_CODE (role from the till not present in ac_Role, nothing to be done)
  // or ones where wjobid for an sec could not be found in ac_UserRoles (either UserId not found
  // or UserId-WRoleId comb. not found). If user exists in ac_UserRoles then make WRoleId the
  // the UserIds default role and flag the record.
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select *');
    sql.Add('from schedule s');
    sql.Add('where s.PaySchemeVersionLMBy = ' + #39 + 'ZZ-999' + #39);
    sql.Add('and s.WorkedPaySchemeVersionid is null');
    open;
    first;

    errstring2 := 'Edit Sch. #18';
    // prepare tables for action

    dmod1.adoqGetAllEmployeesAndJobs.Close;
    dmod1.adoqGetAllEmployeesAndJobs.Parameters.ParamByName('SiteId').value := SiteNo;
    dmod1.adoqGetAllEmployeesAndJobs.Open;
    while not eof do
    begin
      // first try to locate the sec in the list of all valis user jobs(non deleted record, default job)
      if dmod1.adoqGetAllEmployeesAndJobs.locate('UserId;default',
        VarArrayOf([FieldByName('UserId').Value,1]), []) then
      begin // default job located, put it in wjob and get the payrates as well
        edit;
        // different error codes for wjobid = NULL_JOB_CODE and for wjobid valid job in jobcode
        if FieldByName('WRoleId').asInteger = NULL_JOB_CODE then
          FieldByName('ErrCode').asInteger := 1 // wjobid unknown
        else
        begin
          FieldByName('ErrCode').asInteger := 2; // wjobid not this emp's job
          FieldByName('CRoleId').asInteger := FieldByName('WRoleId').asinteger;

          FieldByName('WRoleId').asInteger := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('RoleId').asinteger;
          FieldByName('PaySchemeVersionId').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
          FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionID').Value;

          FieldByName('accin').asfloat := FieldByName('clockin').asfloat;
          FieldByName('accout').asfloat := FieldByName('clockout').asfloat;
        end;
        FieldByName('LMDT').AsDateTime := Now;
        post;
      end
      else  // no job to use from ac_UserRoles for this UserId, set ErrCode and leave it at that
      begin
        edit;
        // now the UserId is not present in user-role mapping; this could be because the UserId does not
        // have a role at all but it does exist in ac_user
        dmod1.wwtac_user.Open;
        try
          if dmod1.wwtac_User.locate('Id', FieldByName('UserId').Value, []) then
          begin // sec exists it just doesn't have a default job or even the wjobid as deleted..
            FieldByName('ErrCode').asinteger := 3; // sec does not have any valid job
          end
          else // ... or the sec doesn't exist at all!!!
          begin
            FieldByName('ErrCode').asinteger := 4;
          end;
          FieldByName('LMDT').AsDateTime := Now;
          post;
        finally
          dmod1.wwtac_User.Close;
        end;
      end;
      next;
    end;
    dmod1.adoqGetAllEmployeesAndJobs.Close;

    close;
    errstring2 := 'Edit Sch. #19';
    // at this point all records either have pay info or have an errCode.

    // now all records with worked paytype having source="clocked times" get accin/out = clockin/out
    close;
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set otime = (''C''), accin = s."clockin", accout = s."clockout",');
    SQL.Add('LMDT = getDate()');
    sql.Add('from schedule s');
    sql.Add('join ac_PaySchemeVersion v');
    sql.Add('on s.WorkedPaySchemeVersionId = v.Id');
    sql.Add(' join ac_PayScheme p');
    sql.Add(' on v.PaySchemeId = p.Id');
    sql.Add('where s."PaySchemeVersionLMBy" = ' + #39 + 'ZZ-999' + #39);
    sql.Add('and s."WRoleId" <> ' + inttostr(NULL_JOB_CODE));
    sql.Add('and (    ((s."accin" is null)   and (s."accout" is null)   )');
    sql.Add('      or ((s.accin = s.clockin) and (s.accout = s.clockout))');
    sql.Add('    )');
    sql.Add('and p.AcceptedTimesSourceId = ' + IntToStr(Ord(sptClocked)));

    execSQL;
    errstring2 := 'Edit Sch. #17';

    // now all records with worked paytype having source="scheduled times" get accin/out = schin/out
    // unless they are unscheduled in this case they get clockin/out
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set otime = (''S''), accin = s."schin", accout = s."schout",');
    SQL.Add('LMDT = getDate()');
    sql.Add('from schedule s');
    sql.Add('join ac_PaySchemeVersion v');
    sql.Add('on s.WorkedPaySchemeVersionId = v.Id');
    sql.Add(' join ac_PayScheme p');
    sql.Add(' on v.PaySchemeId = p.Id');
    sql.Add('where s."PaySchemeVersionLMBy" = ' + #39 + 'ZZ-999' + #39);
    sql.Add('and s."RoleId" <> ' + inttostr(NULL_JOB_CODE));
    sql.Add('and s."WRoleId" <> ' + inttostr(NULL_JOB_CODE));
    sql.Add('and s."accin" is null');
    sql.Add('and s."accout" is null');
    sql.Add('and p.AcceptedTimesSourceId = ' + IntToStr(Ord(sptScheduled)));
    execSQL;

    errstring2 := 'Edit Sch. #10';

    // unscheduled records get clockin/out...
    close;
    sql.Clear;
    sql.Add('update schedule');
    sql.Add('set otime = (''U''), accin = "clockin", accout = "clockout",');
    SQL.Add('LMDT = getDate()');
    sql.Add('where "PaySchemeVersionLMBy" = ' + #39 + 'ZZ-999' + #39);
    sql.Add('and "RoleId" = ' + inttostr(NULL_JOB_CODE));
    sql.Add('and "WRoleId" <> ' + inttostr(NULL_JOB_CODE));
    sql.Add('and "accin" is null');
    sql.Add('and "accout" is null');
    execSQL;
  end;


  // now for all records with source = S (field otime) make worked = accout - accin.
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from schedule');
    sql.Add('where otime = ''S'' and PaySchemeVersionLMBy = ''ZZ-999''');

    open;
    errstring2 := 'Edit Sch. #20';
    first;
    while not eof do
    begin
      edit;
      FieldByName('worked').asdatetime := FieldByName('accout').asdatetime -
        FieldByName('accin').asdatetime;
      FieldByName('LMDT').AsDateTime := Now;
      post;
      next;
    end;

    // FOR EACH RECORD with source = C (field otime) THIS CALCULATES WORKED AND BREAK TIMES
    // fworked holds the sum of times worked if more than 1 period has been matched to
    // a sched. shift. fbreak holds breaks coming from empusck.
    close;
    sql.Clear;
    sql.Add('select * from schedule');
    sql.Add('where otime <> ''S'' and PaySchemeVersionLMBy = ''ZZ-999'' and (fworked is not null)');
    open;
    first;
    while not eof do
    begin
      edit;
      FieldByName('worked').asdatetime := FieldByName('fworked').asfloat -
        FieldByName('fbreak').asfloat;
      FieldByName('break').asdatetime := FieldByName('clockout').asdatetime -
        FieldByName('clockin').asdatetime - FieldByName('worked').asdatetime;
      FieldByName('LMDT').AsDateTime := Now;
      post;
      next;
    end;
    close;
    errstring2 := 'Edit Sch. #21';
    // worked will now have the real worked time, which excludes the 'official' breaks
    // (from empusck) AS WELL AS the time between the worked periods (if more than 1)
    // break now holds the sum of all official breaks + the time between periods (if more than 1)
  end;


  // for all records involved in this matching process (PaySchemeVersionLMBy = ZZ-999)
  // set BsDate to the rolled over date of SchIn
  with SchdlTable do
  begin
    close;
    filter := 'PaySchemeVersionLMBy = ' + #39 + 'ZZ-999' + #39;
    filtered := true;
    open;
    errstring2 := 'Edit Sch. #24';
    first;
    while not eof do
    begin
      edit;

      if dtgrace > frac(FieldByName('schin').asfloat) then
      begin //previous day
        FieldByName('BsDate').asstring :=
          formatDateTime(ShortDateFormat+'yy', FieldByName('schin').asdatetime - 1);
      end
      else
      begin // same day
        FieldByName('BsDate').asstring :=
          formatDateTime(ShortDateFormat+'yy', FieldByName('schin').asdatetime);
      end;

      post;
      next;
    end;

    filtered := false;
    close;
    errstring2 := 'Edit Sch. #25';
  end;

  PatchShifts;

  errstring1 := 'Edit Schedule Ends OK';
  errstring2 := '';
end; // procedure

// Matching Section ends...----------------------------------------------------


procedure TdmShiftMatch.LogInfo;
var
  i: integer;
begin
  for i := 0 to loglist.count - 1 do
  begin
    log.Event(loglist[i]);
  end;
end;

procedure TdmShiftMatch.SchdlTableBeforePost(DataSet: TDataSet);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdmShiftMatch.SchdlTableNewRecord(DataSet: TDataSet);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdmShiftMatch.SchdlTableUpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  with Dataset do
  begin
    fieldbyname('LMDT').Value := Now;
  end;
end;

procedure TdmShiftMatch.PatchShifts;
var
  bdate : tdatetime;
  UserId : Int64;
  shiftno : shortint;
begin
  // PATCH PATCH PATCH PATCH...
  // MAKE SURE THAT 1. for each day the recs for 1 emp are ordered by schin and
  //                   are given the correct shift...

  if SchdlTable.State = dsInactive then
    SchdlTable.open;

  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a."sitecode", a."UserId", a."schin", a."bsdate"');
    sql.Add('from "schedule" a');
    sql.Add('where a."PaySchemeVersionLMBy" = ''ZZ-999''');
    sql.Add('order by a."bsdate", a."UserId", a."schin"');
    open;

    errstring2 := 'Edit Sch. #26 (patch)';
    bdate := 0;
    UserId := -1;
    shiftno := 1;
    first;
    while not eof do
    begin
      if bdate = FieldByName('bsdate').asdatetime then
      begin
        if UserId = FieldByName('UserId').Value then
        begin
          if SchdlTable.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
            FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
          begin
            SchdlTable.edit;
            SchdlTable.FieldByName('shift').asinteger := shiftno;
            SchdlTable.post;
            inc(shiftno);
          end;
        end
        else
        begin
          UserId := FieldByName('UserId').Value;
          shiftno := 1;
          if SchdlTable.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
            FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
          begin
            SchdlTable.edit;
            SchdlTable.FieldByName('shift').asinteger := shiftno;
            SchdlTable.post;
            inc(shiftno);
          end;
        end;
      end
      else
      begin
        bdate := FieldByName('bsdate').asdatetime;
        UserId := FieldByName('UserId').Value;
        shiftno := 1;
        if SchdlTable.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
          FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
        begin
          SchdlTable.edit;
          SchdlTable.FieldByName('shift').asinteger := shiftno;
          SchdlTable.post;
          inc(shiftno);
        end;
      end;
      next;
    end;
    close;
    SchdlTable.close;
    errstring2 := 'Edit Sch. #27 (patch)';
  end;
end;

function TdmShiftMatch.fixed_strtotime(timestr: string): TDateTime;
{fixed strtotime, format must be hh:mm}
var
  hours, mins: integer;
begin
  if timestr = '' then
    timestr := '00:00';
  try
    hours := strtoint(copy(timestr, 1, pred(pos(':', timestr))));
    mins := strtoint(copy(timestr, succ(pos(':', timestr)), 2));
    result := (hours * 1.0 / 24.00) + (mins * 1.0 / 24.00 / 60.00);
  except
    result := strtotime(timestr);
  end;
end;

function TdmShiftMatch.GetAztecData: integer;
begin
  with wwqRun do
  begin
    SQL.Clear;

    SQL.Add('select ' + inttostr(SiteCode) + ' as [Site Code], EmployeeID as UserId, ' +
      'ClockedInDateTime as [Date In], ' + 'ClockedOutDateTime as [Date Out], Role as [RoleId], 0 as [Break], ' +
      'convert(DateTime, NULL) as [Time In],convert(DateTime, NULL) as [Time Out], ClockInDate, ClockOutDate,' +
      'ClockedPaySchemeVersionId, ClockedUserPayRateOverrideVersionID');
    SQL.Add('into #ghost');
    SQL.Add('from ClockedShifts');
    SQL.Add('where ClockedOutDateTime > ' + dmADO.FormatDateTimeForSQL(empNewLADT));
    SQL.Add('and ClockedOutDateTime <= ' + dmADO.FormatDateTimeForSQL(PZNewLADT));
    SQL.Add('and ClockOutDate is not NULL');
    // job 331038: the line below discards any shifts where the Clockin and Clockout are in the same minute
    sql.Add('and NOT ((convert(datetime, convert(varchar(16), [ClockInDate], 120), 120)) = ' +
                              '(convert(datetime, convert(varchar(16), [ClockOutDate], 120), 120)))');
    ExecSQL;
    Close;
  end;

  // Get breaks data from EmployeeBreaksAudited table. Add this to the EmployeeBreaksAccepted table
  // where they can be edited by the site manager, and add the total break time to the
  // #Ghost table created previously. (GDM 30/08/04: Added for job 325625)
  with wwqRun do
  begin
    //Call stored proc to match end breaks to start breaks i.e. populates
    //EmployeeBreaksAudited.BreakEndDate from BreakEndsUnprocessed table.
    SQL.Text := 'EXEC MatchStartEndBreaks';
    ExecSQl;

    // The NOT EXISTS... condition is there to safeguard against anyone manually
    // editing the NewLADT value in SiteVar
    SQL.Text :=
      'INSERT INTO EmployeeBreaksAccepted (SiteCode, EmployeeID, BreakStartDate, BreakEndDate) ' +
      'SELECT ' + inttostr(SiteCode) + ', au.EmployeeID, au.BreakStartDate, au.BreakEndDate ' +
      'FROM EmployeeBreaksAudited au ' +
      'WHERE au.BreakEndDate >  ' + dmADO.FormatDateTimeForSQL(empNewLADT) +
      '  AND au.BreakEndDate <= ' + dmADO.FormatDateTimeForSQL(PZNewLADT) +
      '  AND au.BreakEndDate IS NOT NULL' +
      '  AND NOT EXISTS ' +
      '  ( SELECT * FROM EmployeeBreaksAccepted as ac ' +
      '    WHERE ac.SiteCode = ' + IntToStr(SiteCode) +
      '    AND ac.EmployeeId = au.EmployeeID ' +
      '    AND ac.BreakStartDate = au.BreakStartDate ' +
      '    AND ac.BreakEndDate = au.BreakEndDate ) ';
    ExecSQl;

    //Set [#Ghost.Break] to the total break duration in minutes
    SQL.Text :=
      'update [#Ghost] ' +
      'set [Break] = c.[Break] ' +
      'from (select a.UserId, a.ClockInDate, a.ClockOutDate, ' +
      '        CASE WHEN sum(datediff(minute, b.BreakStartDate, b.BreakEndDate)) > 1439 THEN 1439 ' +
      '             ELSE sum(datediff(minute, b.BreakStartDate, b.BreakEndDate)) ' +
      '        END as [Break] ' +
      '      from [#Ghost] a join EmployeeBreaksAccepted b ' +
      '        on a.UserId = b.EmployeeId and ' +
      '           a.[Date In] <= b.BreakStartDate and ' +
      '           a.[Date Out] >= b.BreakEndDate and ' +
      '           b.Deleted = 0 ' +
      '      group by a.UserId, a.ClockInDate, a.ClockOutDate) c ' +
      'where [#Ghost].UserId = c.UserId and ' +
      '      [#Ghost].ClockInDate = c.ClockInDate and ' +
      '      [#Ghost].ClockOutDate = c.ClockOutDate ';
    ExecSQl;
  end;

  with wwqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select count(*) as Shifts from #ghost');
    Open;
    Result := FieldByName('Shifts').asInteger;
    Close;
  end;

end;

end.
