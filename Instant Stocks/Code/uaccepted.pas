unit uaccepted;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Wwdatsrc, DBTables, Wwtable, Grids, Wwdbigrd,
  Wwdbgrid, ADODB, Variants, ExtCtrls, DBCtrls, uGlobals;

type
  Tfaccepted = class(TForm)
    wwDS1: TwwDataSource;
    UnaccBtn: TBitBtn;
    RepBtn: TBitBtn;
    CloseBtn: TBitBtn;
    wwtaccstk: TADOQuery;
    Grid: TwwDBGrid;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    adoqMaxStock: TADOQuery;
    Panel1: TPanel;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Label23: TLabel;
    pnlDebug: TPanel;
    DBText2: TDBText;
    DBText1: TDBText;
    Label3: TLabel;
    procedure RepBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UnaccBtnClick(Sender: TObject);
    procedure wwtaccstkAfterScroll(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure GridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure GridTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure GridCalcTitleAttributes(Sender: TObject; AFieldName: String;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure Label23DblClick(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
  private
    passcount, stkSlaveCode : integer;
    strSlave, yellField, redField : string;
    function CheckPass: boolean;
    function UnAcceptPurch: boolean;
    procedure DoUnAccept;
    procedure SetSecurity;
    { Private declarations }
  public
    { Public declarations }
    unaccreason : string;
  end;

var
  faccepted: Tfaccepted;

implementation

uses udata1, uADO, uDataProc, dAccPurch, ulog, uReps1;

{$R *.DFM}

procedure Tfaccepted.SetSecurity;
var
  curTid : integer;
begin
  CurTid := wwtAccStk.FieldByName('tid').AsInteger;

  repBtn.Visible := data1.UserAllowed(curTid, 19);
  unAccbtn.Visible := data1.UserAllowed(curTid, 20);
end; // procedure..


procedure Tfaccepted.RepBtnClick(Sender: TObject);
begin
  log.event('In fAccepted.RepBtnClick, StockCode = ' + IntToStr(wwtAccStk.FieldByName('stockcode').AsInteger) +
    ', ThreadId = ' + IntToStr(wwtAccStk.FieldByName('tid').AsInteger));

  data1.initCurr(wwtAccStk.FieldByName('tid').AsInteger,
     wwtAccStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, False);

  fReps1 := TfReps1.Create(self);
  fReps1.ShowModal;
  fReps1.Free;

  log.Event('Exiting fAccepted.RepBtnClick');
end;

procedure Tfaccepted.FormShow(Sender: TObject);
begin
  with wwtaccstk do
  begin
    close;
    sql.Clear;
    sql.Add('select a.*, b."tname", b."slaveTh", (b."byHZ") as ThByHZ');
    sql.Add('from "Stocks" a, "threads" b where a.tid = b.tid and a.PureAZ = 1');
    sql.Add('and a."stockcode" > 1 and b.tid in (select tid from stksectids where permid = 18)');
    sql.Add('order by a.division, b.tname, a."edt" DESC');
  end;

  yellField := '';
  redField := '';
  wwtaccstk.Open;
  adoqMaxStock.Open;
  wwtAccstk.First;
  UnAccbtn.Caption := 'Un Accept ' + data1.SSbig;
  grid.Columns[8].DisplayLabel := data1.ss6 + ' Kind';
  self.Caption := 'Accepted ' + data1.SSplural;
end;

procedure Tfaccepted.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  adoqMaxStock.Close;
  wwtaccstk.Close;
end;

procedure Tfaccepted.UnaccBtnClick(Sender: TObject);
begin
  if UnaccBtn.caption = 'Un Accept ' + data1.SSbig then
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT a."tid" FROM "curstock" a');
      sql.Add('WHERE a."tid" = '+ wwtAccStk.FieldByName('tid').AsString);
      open;

      if (Recordcount > 0) then
      begin // current stock, DO NOT proceed...
        showmessage('There is a Current ' + data1.SSbig + ' for this thread.' +
          #13 + 'Cannot continue with Un-Accept.');
        close;
        exit;
      end;
      close; // if this point is reached there is no current stock, proceed...
    end;

    showMessage('Un Accepting a ' + data1.SSbig + ' is not recommended except as a last resort!' +
      #13 + 'Please enter your password in the edit box and then click "Proceed with Un Accept" to continue');


    UnaccBtn.caption := 'Proceed with Un Accept';
    edit1.Text := '';
    edit1.Visible := True;
    label1.Visible := True;
    bitbtn2.Visible := True;
  end
  else
  begin
    // check password....
    if CheckPass then
    begin
      bitbtn1.Enabled := False;
      edit2.Text := '';
      panel1.Left := grid.Left;
      panel1.Visible := True;
      edit1.Visible := false;
      label1.Visible := false;
      bitbtn2.Visible := false;
    end;
  end;
end;

function Tfaccepted.CheckPass: boolean;
begin
  Result := False;
  if uppercase(edit1.Text) <> CurrentUser.Password then
  begin
    if passcount = 3 then
    begin
      log.event('+++++++++ Attempt to Unaccept FAILED - Wrong Password, App Terminated +++++++++');
      showmessage('Wrong Password. You clearly should not be here! Program will now close.');
      Application.Terminate;
      exit;
    end
    else
    begin
      showmessage('Wrong Password. You have ' + inttostr(3 - passcount) + ' more tries at this!');
      inc(passcount);
      edit1.SetFocus;
      edit1.SelectAll;
      exit;
    end;
  end
  else
  begin
    Result := True;
  end;
end; // function..


procedure Tfaccepted.DoUnAccept;
var
  i, j : integer;
  errstr, strSlave2 : string;
begin
  log.event('In fAccepted.DoUnAccept, StockCode = ' + IntToStr(wwtAccStk.FieldByName('stockcode').AsInteger) +
    ', ThreadId = ' + IntToStr(wwtAccStk.FieldByName('tid').AsInteger));

  data1.initCurr(wwtAccStk.FieldByName('tid').AsInteger,
       wwtAccStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, False);

  if wwtAccStk.FieldByName('slaveTh').Asinteger > 0 then
  begin
    with data1.adoqRun do
    begin
      // try to find the Auto-Gen slave stock that corresponds to the Master stock about to be un-accepted...
      Close;
      sql.Clear;
      sql.Add('SELECT a."StockCode", a."EDate", a."ETime", a."sdate", a."stime"');
      sql.Add('FROM "stocks" a');
      sql.Add('WHERE a."tid" = ' + inttostr(data1.curSTh));
      sql.Add('AND a."SiteCode" = '+IntToStr(data1.TheSiteCode));
      sql.Add('AND a.EDT = ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
      open;

      stkSlaveCode := FieldByName('stockcode').asinteger;

      // if for some strange reason this is not found then get the earliest slave stock done at the same time
      // or after the Master stock. This will stop the system from deleting all Slave stocks...
      if (recordcount = 0) or (stkSlaveCode = 0) then
      begin
        Close;
        sql.Clear;
        sql.Add('SELECT a."StockCode", a."EDate", a."ETime", a."sdate", a."stime"');
        sql.Add('FROM "stocks" a');
        sql.Add('WHERE a."tid" = ' + inttostr(data1.curSTh));
        sql.Add('AND a."SiteCode" = '+IntToStr(data1.TheSiteCode));
        sql.Add('AND a.EDT >= ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss', data1.EDT)));
        sql.Add('order by a.EDT');
        open;

        stkSlaveCode := FieldByName('stockcode').asinteger;
        log.event('UN-ACCEPT: Sub. Auto-Gen stock NOT FOUND (Tid: ' + inttostr(data1.curSTh) +
          ') will instead delete back to  StockCode: ' + inttostr(stkSlaveCode) + ', EDT: ' +
          quotedStr(formatDateTime('ddmmmyy hh:nn:ss', data1.EDT)));
      end;

      strSlave := ' with Start Date: ' + FieldByName('Sdate').asstring;
      if FieldByName('STime').asstring <> '' then
      begin
        strSlave := strSlave + ' and Start Time: ' + FieldByName('STime').asstring;
      end;

      close;
    end;

    if data1.lastSThAccCode = stkSlaveCode then
    begin
      strSlave2 := 'Auto-Created ' + data1.SSbig;
    end
    else
    begin
      strSlave2 := 'Auto-Created ' + data1.SSbig + #13 + ' and ALSO any ' +
        data1.SSplural + ' accepted after it (' + inttostr(data1.lastSThAccCode - stkSlaveCode) +
        '), all ';
    end;

    if MessageDlg('This ' + data1.SSbig + ' belongs to a Master Thread.' + #13 +
      'When it was accepted it automatically created and accepted the ' + data1.SSbig + ' ' + strSlave +
      ' from the Subordinate Thread "' + data1.CurSThName + '".' + #13 + #13 +
      'Un-Accepting this ' + data1.SSbig + ' will automatically un-accept AND CANCEL the ' + strSlave2 +
      ' from the Subordinate Thread.' + #13 + #13 + 'Do you want to continue?'
      , mtWarning, [mbYes,mbNo], 0) = mrNo then
    begin
      exit;
    end;
  end
  else if (wwtaccstk.FieldByName('slaveTh').Asinteger < 0)
         and (copy(wwtaccstk.FieldByName('stkkind').asstring,1,8) = 'AUTOGEN-') then
  begin
    showmessage('This ' + data1.SSbig + ' belongs to a Subordinate Thread and was automatically created by ' +
      ' the Master Thread.' + #13 + 'It cannot be Un-Accepted.');
    exit;
  end
  else if (wwtaccstk.FieldByName('stkkind').asstring = 'MAC') then
  begin
    if MessageDlg('This is a MAC ' + data1.SSbig + '.' +
      //#13 +'(Auto Generated by External Audit Counts)' +
      #13 + #13 +
      'Un-Accepting this ' + data1.SSbig + ' will automatically CANCEL it as well!' +
      #13 + #13 + 'Do you want to continue?'
      , mtWarning, [mbYes,mbNo], 0) = mrNo then
    begin
      exit;
    end;
  end;

  try
    screen.Cursor := crHourGlass;
    errstr := 'begin';
    with data1.adoqRun do
    begin
      // stocks -> curstock
      log.event('UN-ACCEPT: Start with Tid: ' + inttostr(data1.curtid) +
        ' StockCode: ' + inttostr(data1.StkCode));

      if not data1.curNoPurAcc then
      begin
        log.event('UN-ACCEPT: Starting to unaccept purchases');
        errstr := 'UnAcceptPurch';
        if not UnAcceptPurch then
        begin
          showMessage('Invoices involved in this ' + data1.SSlow + ' could not be un-accepted because of an error!' +
            #13 + #13 +
            'This ' + data1.SSlow + ' can not be un-accepted until that error is fixed.');

          log.event('Stock Un-Accept stopped because of error in Un-Accept Purchases');

          exit;
        end;
        errstr := 'UnAcceptPurch DONE';
        log.event('UN-ACCEPT Purch: Done.');
      end;


      // delete from Audit just in case of a rogue reconfigure
      Close;
      sql.Clear;
      sql.Add('Delete Audit');
      sql.Add('WHERE StkCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

        errstr := 'insert into audit'; // insert into Audit from StkMain...
      close;
      sql.Clear;
      sql.Add('insert into audit ([SiteCode], [tid],[StkCode], hzid, "entitycode", "name", "subcat",');
      sql.Add('"ImpExRef", OpStk, PurchStk, ThRedQty,');
      sql.Add('ThCloseStk, ActCloseStk,"purchunit", "purchbaseU",');
      sql.Add('[wastetill], [wastetillA], [wastepc], [wastepcA], [wastage], [LMDT])');
      sql.Add('SELECT a."SiteCode", a."tid", a."StkCode", a.hzid, b."entitycode",');

      sql.Add(' (CASE ');
      sql.Add('    WHEN (a."key2" < 1000) THEN b."purchasename"'); // NORMAL items
      sql.Add('    ELSE b."retailname"');                                                // 17841 - Prep.Items
      sql.Add('  END) as purchasename,');

      if data1.RepHdr = 'Sub-Category' then
        sql.Add('(b.[SCat]) as SubCatName, b."ImpExRef",')
      else
        sql.Add('(b.[Cat]) as SubCatName, b."ImpExRef",');

      sql.Add(' (CASE ');
      sql.Add('    WHEN ((a."key2" = 55) or (a."key2" = 1055)) THEN -888888'); // 17841 - NEW Items
      sql.Add('    ELSE (a."OpStk" / a."purchbaseU")');                        // NORMAL items
      sql.Add('  END) as OpStk,');

      sql.Add(' (CASE ');
      sql.Add('    WHEN (a."key2" < 1000) THEN (a."PurchStk" / a."purchbaseU")'); // NORMAL items
      sql.Add('    ELSE -999999');                                                // 17841 - Prep.Items
      sql.Add('  END) as PurchStk,');

      sql.Add('(a."ThRedQty" / a."purchbaseU") as ThRedQty,');
      sql.Add('(a."ThCloseStk" / a."purchbaseU") as ThCloseStk,');
      sql.Add('(a."ActCloseStk" / a."purchbaseU") as ActCloseStk,');
      sql.Add('a."purchunit", a."purchbaseU", (a.[wastetill] / a."purchbaseU"),');
      sql.Add('(a.[wastetillA] / a."purchbaseU"), (a.[wastepc] / a."purchbaseU"),');
      sql.Add('(a.[wastepcA] / a."purchbaseU"), (a.[wastage] / a."purchbaseU"),');
      sql.Add( '' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
      sql.Add('FROM "StkMain" a, "stkEntity" b');
      sql.Add('WHERE a."entitycode" = b."entitycode"');
      sql.Add('and (   (a."OpStk" <> 0)');
      sql.Add('     or (a."PurchStk" <> 0)');
      sql.Add('     or (a."ActCloseStk" <> 0)');
      sql.Add('     or (a."ThRedQty" <> 0))');
      sql.Add('and a."tid" = ' + IntToStr(data1.curtid)+' and a."stkcode" = ' + IntToStr(data1.StkCode));
      execSQL;

      errstr := 'INSERT INTO [stkUnAccept]';
      i := 9999;
      while i > 0 do
      begin
        close;
        sql.Clear;
        sql.Add('select a.[sitecode] from [stkUnAccept] a');
        sql.Add('WHERE a.[SiteCode] = '+IntToStr(data1.TheSiteCode));
        sql.Add('and a.[Tid] = '+IntToStr(data1.curtid));
        sql.Add('and a.[StockCode] = '+IntToStr(data1.StkCode));
        sql.Add('and a.[unaccdate] = ' + quotedStr(formatDateTime('mm/dd/yyyy', Date)));
        sql.Add('and a.[unacctime] = ' + quotedStr(formatDateTime('hh:nn', Time)) );
        open;

        if recordcount = 0 then
          i := 0
        else
          sleep(5000);
      end;

      errstr := 'DELETE FROM "stocks" and insert in curstock';
      // do this in one sql statement so an error does not leave the stock in both Current and Accepted state

      close;
      sql.Clear;
      sql.Add('INSERT INTO [stkUnAccept]');
      sql.Add('SELECT a.[SiteCode], a.[Tid], a.[StockCode],');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy', Date)) + ') as UnAccDate,');
      sql.Add('(' + quotedStr(formatDateTime('hh:nn', Time)) + ') as UnAccTime,');
      sql.Add('(' + quotedStr(CurrentUser.UserName) + ') as UnAccBy,');

      sql.Add('a.[Division], a.[SDate], a.[STime],');
      sql.Add('a.[EDate], a.[ETime], a.[AccDate], a.[AccTime], a.[Stage], a.[Type], a.[PrevStkCode],');
      sql.Add('b.[MiscBalReason1], b.[MiscBal1], b.[MiscBalReason2], b.[MiscBal2],');
      sql.Add('b.[MiscBalReason3], b.[MiscBal3], b.[SiteManager],');
      sql.Add('b.[StockTaker], b.[Banked], b.[ReportHeader], b.[StockTypeShort],');
      sql.Add('b.[StockNote], b.[TotOpCost], b.[TotPurch], b.[TotCloseCost],');
      sql.Add('b.[TotInc], b.[TotNetInc], b.[TotCostVar], b.[TotProfVar], b.[TotSPCost],');
      sql.Add('b.[TotConsVal], b.[TotLGW], b.[TotRcpVar], b.[Per],');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as LMDT,');
      sql.Add('(' + quotedStr(unaccreason) + ') as Reason');

      sql.Add('FROM stocks a, stkmisc b');
      sql.Add('WHERE a.[SiteCode] = b.[SiteCode] and a.[Tid] = b.[Tid]');
      sql.Add('and a.[StockCode] = b.[StockCode]');
      sql.Add('and a.[Tid] = '+IntToStr(data1.curtid));
      sql.Add('and a.[StockCode] = '+IntToStr(data1.StkCode));
      sql.Add('and b.hzid = 0');
      sql.Add('  ');

      sql.Add('  ');
      sql.Add('insert curstock ([SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('      [ETime], [SDT], [EDT], [Stage], [Type], [DateRecalc],');
      sql.Add('      [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], [CurStage], [RTRcp], [LMDT])');
      sql.Add('select [SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('       [ETime], [SDT], [EDT], ''Completed'', [Type], [DateRecalc],');
      sql.Add('       [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], 4, [RTRcp],');
      sql.Add( '' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
      sql.Add('from Stocks');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      sql.Add('  ');

      sql.Add('  ');
      sql.Add('DELETE FROM "stocks"');
      sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      ExecSQL;

      if data1.curIsMTh then  // kill the slave Stock now...
      begin
        // insert the slave stk info into stkUnAccept as well
        for j := data1.lastSThAccCode downto stkSlaveCode do
        begin
          // one more layer of insurance against deleting old stocks...
          Close;
          sql.Clear;
          sql.Add('SELECT a."StockCode", a."EDate"');
          sql.Add('FROM "stocks" a');
          sql.Add('WHERE a."tid" = ' + inttostr(data1.curSTh));
          sql.Add('AND a."SiteCode" = '+IntToStr(data1.TheSiteCode));
          sql.Add('AND a."StockCode" = '+IntToStr(j));
          open;
          if fieldByName('EDate').AsDateTime < data1.Edate then
            continue;

          i := 9999;
          while i > 0 do
          begin
            close;
            sql.Clear;
            sql.Add('select a.[sitecode] from [stkUnAccept] a');
            sql.Add('WHERE a.[SiteCode] = '+IntToStr(data1.TheSiteCode));
            sql.Add('and a.[Tid] = '+IntToStr(data1.curSTh));
            sql.Add('and a.[StockCode] = '+IntToStr(j));
            sql.Add('and a.[unaccdate] = ' + quotedStr(formatDateTime('mm/dd/yyyy', Date)));
            sql.Add('and a.[unacctime] = ' + quotedStr(formatDateTime('hh:nn', Time)) );
            open;

            if recordcount = 0 then
              i := 0
            else
              sleep(5000);
          end;

          close;
          sql.Clear;
          sql.Add('INSERT INTO [stkUnAccept]');
          sql.Add('SELECT a.[SiteCode], a.[Tid], a.[StockCode],');
          sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy', Date)) + ') as UnAccDate,');
          sql.Add('(' + quotedStr(formatDateTime('hh:nn', Time)) + ') as UnAccTime,');
          sql.Add('(' + quotedStr(CurrentUser.UserName) + ') as UnAccBy,');

          sql.Add('a.[Division], a.[SDate], a.[STime],');
          sql.Add('a.[EDate], a.[ETime], a.[AccDate], a.[AccTime], a.[Stage], a.[Type], a.[PrevStkCode],');
          sql.Add('b.[MiscBalReason1], b.[MiscBal1], b.[MiscBalReason2], b.[MiscBal2],');
          sql.Add('b.[MiscBalReason3], b.[MiscBal3], b.[SiteManager],');
          sql.Add('b.[StockTaker], b.[Banked], b.[ReportHeader], b.[StockTypeShort],');
          sql.Add('b.[StockNote], b.[TotOpCost], b.[TotPurch], b.[TotCloseCost],');
          sql.Add('b.[TotInc], b.[TotNetInc], b.[TotCostVar], b.[TotProfVar], b.[TotSPCost],');
          sql.Add('b.[TotConsVal], b.[TotLGW], b.[TotRcpVar], b.[Per],');
          sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as LMDT,');
          sql.Add('(' + quotedStr(unaccreason) + ') as Reason');

          sql.Add('FROM stocks a, stkmisc b');
          sql.Add('WHERE a.[SiteCode] = b.[SiteCode] and a.[Tid] = b.[Tid]');
          sql.Add('and a.[StockCode] = b.[StockCode]');
          sql.Add('and a.[Tid] = '+IntToStr(data1.curSTh));
          sql.Add('and a.[StockCode] = '+IntToStr(j));
          sql.Add('and b.hzid = 0');
          execSQL;

          data1.killStock(data1.curSTh, j);
        end; // for..
      end
      else if wwtaccstk.FieldByName('stkkind').asstring = 'MAC' then // kill the stock, at least for Pilot...
      begin
        data1.killStock(data1.curtid, data1.StkCode);
      end;

      wwtAccStk.Requery;
      Grid.Refresh;

      if wwtAccStk.RecordCount = 0 then
      begin
        showMessage('There are no more Accepted ' + data1.SSplural + ' to view!');
        modalResult := mrOK;
      end;

      close;
    end;
    screen.Cursor := crDefault;
    log.event('Exiting fAccepted.DoUnAccept');
  except
    on E:exception do
    begin
      log.event('UN-ACCEPT: ERROR in main proc (' + errstr + ') ErrMsg: ' + E.Message);
      screen.Cursor := crDefault;
      showmessage('ERROR while Un Accepting.' + #13 + 'Please contact Zonal.');
    end;
  end;
end; // procedure..


function Tfaccepted.UnAcceptPurch: boolean;
begin
  // reverse of AcceptPurch...
  try
    dmAccPurch := TdmAccPurch.Create(self);
    Result := dmAccPurch.UnAcceptPurchases;
    dmAccPurch.Free;
  except
    on E:exception do
    begin
      Result := False;
      log.event('UN-ACCEPT: ERROR in proc UnAcceptPurch ErrMsg: ' + E.Message);
      screen.Cursor := crDefault;
      showmessage('ERROR while Un Accepting.' + #13 + 'Please contact Zonal.');
    end;
  end;

end; // procedure..


procedure Tfaccepted.wwtaccstkAfterScroll(DataSet: TDataSet);
begin
  UnaccBtn.caption := 'Un Accept ' + data1.SSbig;
  edit1.Visible := false;
  label1.Visible := false;
  bitbtn2.Visible := false;
  panel1.Visible := false;

  // only show unAccept for the latest stock....
  if adoqMaxStock.active and
    (wwtaccstk.FieldByName('stockcode').AsInteger =
    adoqMaxStock.FieldByName('mS').AsInteger) then
  begin
    // if this is an AutoGen SlaveStk it cannot be unaccepted...
    if (wwtaccstk.FieldByName('slaveTh').Asinteger < 0)
      and (copy(wwtaccstk.FieldByName('stkkind').asstring,1,8) = 'AUTOGEN-') then
    begin
      UnaccBtn.Enabled := False;
    end
    // if this is the new MAC kind it can only be un-accepted by Zonal user... TODO: maybe change after Pilot?
    else if (wwtaccstk.FieldByName('stkkind').asstring = 'MAC') then
    begin
      UnaccBtn.Enabled := (CurrentUser.IsZonalUser);
    end
    else  // not a Slave Stock and not a MAC stock
    begin
      UnaccBtn.Enabled := True;
    end;
  end
  else
  begin
    UnaccBtn.Enabled := False;
  end;
  SetSecurity;
end;

procedure Tfaccepted.BitBtn2Click(Sender: TObject);
begin
  UnaccBtn.caption := 'Un Accept ' + data1.SSbig;
  edit1.Visible := false;
  label1.Visible := false;
  bitbtn2.Visible := false;
end;

procedure Tfaccepted.Edit2Change(Sender: TObject);
begin
  if length(edit2.Text) >= 10 then
  begin
    bitbtn1.Enabled := True;
  end
  else
  begin
    bitbtn1.Enabled := False;
  end;
end;

procedure Tfaccepted.BitBtn3Click(Sender: TObject);
begin
  UnaccBtn.caption := 'Un Accept ' + data1.SSbig;
  edit1.Visible := false;
  label1.Visible := false;
  bitbtn2.Visible := false;
  panel1.Visible := False;
end;

procedure Tfaccepted.BitBtn1Click(Sender: TObject);
begin
  log.event('In fAccepted.BitBtn1Click');
  unaccreason := Edit2.Text;
  DoUnAccept;
  panel1.Visible := False;
  UnaccBtn.caption := 'Un Accept ' + data1.SSbig;
  log.event('Exiting fAccepted.BitBtn1Click');
end;

procedure Tfaccepted.GridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  // Master Thread or Slave Thread visual indicators ONLY...
  if Field.FieldName = 'tname' then
  begin
    if wwtaccstk.FieldByName('slaveTh').Asinteger > 0 then
    begin
      ABrush.Color := clBlue;
      AFont.Color := clWhite;
      AFont.Style := [fsBold];
    end
    else if wwtaccstk.FieldByName('slaveTh').Asinteger < 0 then
    begin
      ABrush.Color := clAqua;
      AFont.Color := clBlack;
      AFont.Style := [fsBold];
    end
    else
    begin
      ABrush.Color := clWindow;
      AFont.Color := clWindowText;
      AFont.Style := [];
    end;
  end
  else if (Field.FieldName = 'EDate') or (Field.FieldName = 'ETime') or
         (Field.FieldName = 'AccDate') or (Field.FieldName = 'AccTime') then
  begin
    if (wwtaccstk.FieldByName('slaveTh').Asinteger < 0)
      and (copy(wwtaccstk.FieldByName('stkkind').asstring,1,8) = 'AUTOGEN-') then
    begin
      ABrush.Color := clAqua;
      AFont.Color := clBlack;
    end
    else
    begin
      ABrush.Color := clWindow;
      AFont.Color := clWindowText;
    end;
  end
  else
  begin
    if (wwtaccstk.FieldByName('slaveTh').Asinteger < 0)
      and (copy(wwtaccstk.FieldByName('stkkind').asstring,1,8) = 'AUTOGEN-') then
    begin
      ABrush.Color := clAqua;
      AFont.Color := clBlack;
    end
  end;
end;

procedure Tfaccepted.GridTitleButtonClick(Sender: TObject; AFieldName: String);
begin
  if (AFieldName = 'STime') or (AFieldName = 'ETime') or (AFieldName = 'AccTime') then
    exit;

  with wwtaccstk do
  begin
    DisableControls;

    if (AFieldName = 'Division') or (AFieldName = redField) then
    begin
      close;
      sql[3] := 'order by a.division, b.tname, a."edt" DESC';
      open;
      redField := '';
      yellField := '';
    end
    else
    begin
      if AFieldName = yellField then // already Yellow, make Red and do DESC by this field...
      begin
        close;
        sql[3] := 'order by [' + AFieldName + '] DESC';
        open;
        redField := AFieldName;
        yellField := '';
      end
      else    // no order or ordered by another field, make Yellow and order by ASCending
      begin
        close;
        sql[3] := 'order by [' + AFieldName + ']';
        open;
        redField := '';
        yellField := AFieldName;
      end;
    end;

    EnableControls;
    First;
  end;

end;

procedure Tfaccepted.GridCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = yellField then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if afieldname = redField then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;
end;

procedure Tfaccepted.Label23DblClick(Sender: TObject);
begin
  if data1.ssDebug then
    pnlDebug.Visible := not pnlDebug.Visible;
end;

{Used to minimise the whole app if the current form is minimised}
procedure Tfaccepted.WMSysCommand;
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


end.
