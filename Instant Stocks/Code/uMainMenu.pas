unit uMainMenu;

interface

{$R Version.RES}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DBTables, INIfILES, ExtCtrls, Variants, Registry, ADODB;

type
  TfMainMenu = class(TForm)
    btnNew: TBitBtn;
    btnCurr: TBitBtn;
    btnExit: TBitBtn;
    btnAcc: TBitBtn;
    btnThreads: TBitBtn;
    btnRep: TBitBtn;
    btnSec: TBitBtn;
    btnConfig: TBitBtn;
    btnLC: TBitBtn;
    btnHZmove: TBitBtn;
    btnPCwaste: TBitBtn;
    btnEQATECExceptionTest: TBitBtn;
    procedure NewStkBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure CurrBtnClick(Sender: TObject);
    procedure AccBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure AppRestore(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure btnRepClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnLCClick(Sender: TObject);
    procedure btnHZmoveClick(Sender: TObject);
    procedure btnPCwasteClick(Sender: TObject);
    procedure btnEQATECExceptionTestClick(Sender: TObject);

  private
    progStart, bugout : boolean;
    theButs : array[1 .. 12] of TBitBtn;

    procedure SetFormStartupState;
    function CheckStocksEnabled: boolean;
    procedure LogException(Sender: TObject; E: Exception);
  public
    RunState: TWindowState;
  end;


var
  fMainMenu: TfMainMenu;

implementation

uses udata1, uDataProc, uwait, uAudit, uCurrdlg, uaccepted, ulog, uConfTh,
  dAccPurch, uPassword, uADO, uAboutForm,
  uStkDivdlg, uStkdatesdlg, uPickRep, uHOrep, uAztecSplash, uSecurity, uConfig,
  uLC, uHZmove, uGlobals, uLCchoose, uLCRep, uRepSP, uHandHeldStockImport,
  uHZMoveChoose, uPCWasteChoose, uEQATECMonitor, uAuditLocations, uMobileStockImport;

{$R *.DFM}

var
  OldWindowProc : Pointer; {Variable for the old windows proc}
  MyMsg : DWord; {custom systemwide message}

function NewWindowProc(WindowHandle : hWnd; TheMessage : LongWord;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = MyMsg then
  begin {Tell the application to restore, let it restore the form}
    if fMainMenu.WindowState <> wsMinimized then
    begin  // do this to bring app to the top instead of just flashing on tool bar
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end
    else
    begin
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end;
    SetForegroundWindow(Application.Handle);
    {We handled the message - we are done}
    Result := 0;
    exit;
  end;
  {Call the original winproc}
  Result := CallWindowProc(OldWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
end;


//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 24 mar 99
//  Inputs: None
//  Outputs: None
//  Globals (R): None
//  Globals (W): None
//  Objects Used: None
//
//  This is the top level procedure that controls the generation of a new
//  stock. The main procedures are numbered following the US Stock System
//  Data Flow Diagram.
//
///////////////////////////////////////////////////////////////////////////////
procedure TfMainMenu.NewStkBtnClick(Sender: TObject);
var
  s1 : string;
begin

  log.event('New Stock Started');

  data1.initGlobals;
  data1.UpdateCurrStage(0); // stage 0

  fStkDivdlg := TfStkDivdlg.Create(Self);
  if fStkDivDlg.ShowModal <> mrOK then //...user cancelled return to main menu.
  begin
    fStkDivDlg.Free;
  	Exit;
  end;
  fStkDivDlg.Free;

  // 259153 - clear AuditLocationsCur
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('UPDATE  a ');
    sql.Add('SET     a.ACount = 0, a.ActCloseStk = 0 ');
    sql.Add('FROM    AuditLocationsCur a ');
    execSql;
  end;

  if data1.curEndOnDoW > 0 then  // fixed End Date, do not show End Date chooser to user...
  begin
    Data1.Etime := '';
    data1.NeedEnd := False;
    Data1.Edate := data1.GetDateForStockEndOnDoW(data1.curEndOnDoW);
    log.Event('  New Stock (Fixed DoW) - End Date: ' + formatdatetime('ddmmmyy', data1.Edate));
  end
  else
  begin
    // get user to supply stock dates\time
    fStkDatesdlg := TfStkDatesdlg.Create(Self);  // set the SDate here

    if fStkDatesdlg.ShowModal <> mrOK then  // back to main if user cancelled
    begin
       fStkDatesdlg.Free;
       Exit;
    end;
    fStkDatesdlg.Free;
    log.Event('  New Stock - End Date: ' + formatdatetime('ddmmmyy', data1.Edate) + ', End Time: ' + data1.etime);
  end;


  //make new rec in CURSTOCK AND STKMISC
  with data1, dmADO.adoTRun do
  begin
    // set SDT, EDT in data1
    if Stime <> '' then
    begin
      if Stime >= roll then
      begin
        SDT := SDate + strtotime(stime);
      end
      else
      begin
        SDT := SDate + 1 + strtotime(stime);
      end;
    end
    else
    begin
      SDT := SDate + troll;
    end;

    if Etime <> '' then
    begin
      if Etime >= roll then
      begin
        EDT := EDate + 1 + strtotime(etime);
      end
      else
      begin
        EDT := EDate + 2 + strtotime(etime);
      end;
    end
    else
    begin
      EDT := EDate + 1 + troll;
    end;

    Close;
    TableName := 'curstock';
    Open;

    if curBgCP then
      AppendRecord([TheSiteCode,curTid,StkCode,TheDiv,Sdate,Stime,Edate,Etime,SDT, EDT,null,
                    null,'UnAudited','B',null,null,StkTypeLong,PrevStkCode,curByHZ,null, curRTrcp,
                    Now, curByLocation])
    else
      AppendRecord([TheSiteCode,curTid,StkCode,TheDiv,Sdate,Stime,Edate,Etime,SDT, EDT,null,
                    null,'UnAudited','A',null,null,StkTypeLong,PrevStkCode,curByHZ,null, curRTrcp,
                    Now, curByLocation]);
    Close;

    // if this is a stock where late HHs were ignored then log this fact in stkDBGlog
    if data1.logIgnoreLateHHs <> '' then
    begin
      s1 := 'TID: '  + inttostr(curTid) + ', Stk: ' + inttostr(StkCode) +
         ', StartDate: '  + formatdatetime(data1.ukusDateForm2y, Sdate);
      if Stime <> '' then
        s1 := s1 + ', StartTime: '  + Stime;
      s1:= s1 + ', EndDate: '  + formatdatetime(data1.ukusDateForm2y, Edate);
      if Etime <> '' then
        s1 := s1 + ', EndTime: '  + Etime;
      s1 := s1 + ', Stock Taker: "' + TheStkTkr + '", Current User: "' + CurrentUser.UserName + '"';


      data1.logIgnoreLateHHs := s1 + #13 + data1.logIgnoreLateHHs;

      with dmADO.adoqRun do
      begin
        Close;
        sql.Clear;
        sql.Add('INSERT stkDBGlog ([LogDT], [Caller], [LogInt], [LogFloat],[LogString], [LogText]) ');     //
        sql.Add('VALUES (''' + formatDateTime('yyyymmdd hh:nn:ss', Now)  +''', ''New Stock, Div: "' + data1.TheDiv + '"'', ' +
                  inttostr(data1.CurTid) + ', ' +  inttostr(data1.StkCode)  + ', ''Thread: "' + data1.curTidName + '"'', ''' + data1.logIgnoreLateHHs + ''')'); //
        execSQL;
      end;
    end;

    // if this is a stock where late AzTabs were ignored then log this fact in stkDBGlog
    if data1.logIgnoreLateAzTabs <> '' then
    begin
      s1 := 'TID: '  + inttostr(curTid) + ', Stk: ' + inttostr(StkCode) +
         ', StartDate: '  + formatdatetime(data1.ukusDateForm2y, Sdate);
      if Stime <> '' then
        s1 := s1 + ', StartTime: '  + Stime;
      s1:= s1 + ', EndDate: '  + formatdatetime(data1.ukusDateForm2y, Edate);
      if Etime <> '' then
        s1 := s1 + ', EndTime: '  + Etime;
      s1 := s1 + ', Stock Taker: "' + TheStkTkr + '", Current User: "' + CurrentUser.UserName + '"';


      data1.logIgnoreLateAzTabs := s1 + #13 + data1.logIgnoreLateAzTabs;

      with dmADO.adoqRun do
      begin
        Close;
        sql.Clear;
        sql.Add('INSERT stkDBGlog ([LogDT], [Caller], [LogInt], [LogFloat],[LogString], [LogText]) ');
        sql.Add('VALUES (''' + formatDateTime('yyyymmdd hh:nn:ss', Now)  +''', ''New Stock, Div: "' +
                  data1.TheDiv + '"'', ' + inttostr(data1.CurTid) + ', ' +  inttostr(data1.StkCode)  +
                  ', ''Thread: "' + data1.curTidName + '"'', ''' + data1.logIgnoreLateAzTabs + ''')');
        execSQL;
      end;
    end;
  end;

  with data1, dmADO.adoTRun do
  begin
    Close;
    TableName := 'stkmisc';
    Open;
    // first add the Site Wide record...
    AppendRecord([TheSiteCode,curtid,StkCode,0,null,null,null,null,null,
                  null,TheMgr,TheStkTkr,null,RepHdr,TheStkType,
                  null]);

    // then if needed add the individual HZs records
    if curByHz then
    begin
      dmADO.adoqRun.close;
      dmADO.adoqRun.sql.Clear;
      dmADO.adoqRun.sql.Add('select * from stkHZs where active = 1');
      dmADO.adoqRun.open;

      while not dmADO.adoqRun.eof do
      begin
        Append;
        FieldByName('SiteCode').asinteger := TheSiteCode;
        FieldByName('Tid').asinteger := curtid;
        FieldByName('StockCode').asinteger := StkCode;
        FieldByName('HzID').asinteger := dmADO.adoqRun.FieldByName('HzID').asinteger;
        FieldByName('SiteManager').asstring := TheMgr;
        FieldByName('StockTaker').asstring := TheStkTkr;
        FieldByName('ReportHeader').asstring := RepHdr;
        FieldByName('StockTypeShort').asstring := TheStkType;

        FieldByName('hzName').asstring := dmADO.adoqRun.FieldByName('hzName').asstring;
        FieldByName('hzPurch').asBoolean := dmADO.adoqRun.FieldByName('ePur').asBoolean;
        FieldByName('hzSales').asBoolean := dmADO.adoqRun.FieldByName('eSales').asBoolean;
        Post;
        dmADO.adoqRun.next;
      end; // while

      dmADO.adoqRun.close;
    end;

    Close;
  end;

  // START Stock calculation PROCESSING
  data1.UpdateCurrStage(0); // stage 0, sdate, edate, etc...

  with data1 do
  begin
    logDetsCurStock := '(Tid '+IntToStr(data1.curtid) + ' ' + data1.curTidName;

    if curbyHZ then
      logDetsCurStock := logDetsCurStock + '(byHZ) '
    else
      logDetsCurStock := logDetsCurStock + '(bySite) ';

    curStkByHZ := curByHZ;
    curStkByLocation := curByLocation;

    logDetsCurStock := logDetsCurStock + ' Stk ' +
      inttostr(data1.StkCode) + ' (' + theDiv + ') ' + formatDateTime('ddmmmyy hhnnss', SDT) + '-' +
      formatDateTime('ddmmmyy hhnnss', EDT) + '(ED ' + formatDateTime('ddmmmyy', EDate) + ' ET ' +
      ETime + ') ';

    if curStkbyLocation then
      logDetsCurStock := logDetsCurStock + ' byLocation '
    else if curStkbyHZ then
      logDetsCurStock := logDetsCurStock + ' byHZ '
    else
      logDetsCurStock := logDetsCurStock + ' bySite ';

    if curRtrcp then
      logDetsCurStock := logDetsCurStock + 'RealTimeThRed.'
    else
      logDetsCurStock := logDetsCurStock + 'CountTimeThRed.';

    if curisMth then
      logDetsCurStock := logDetsCurStock + ' MASTER(Slv ' + inttostr(curSTh) + ' ' + curSthName + ')';

    if curisSth then
      logDetsCurStock := logDetsCurStock + ' SLAVE(Master ' + inttostr(curMTh) + ' ' + curMthName + ')';
  end;

  log.event('New Stock START PROCESSING - ' + data1.logDetsCurStock);

  dataproc.FastPurch(TRUE);

  if not dataProc.PreAudit(data1.curRTrcp, True, 0) then
  begin
    log.event('ERROR - PreAudit did not work, Stage is now 0');
    exit;
  end;
  data1.PushStkMain; // push sales, purch data into stkmain
  data1.UpdateCurrStage(1); // stage 1, Sales & purch got & calc'ed & saved...

  log.event('New Stock Info Gathered - Ask to enter Audit.');


  // if this is done by Location -------------------------------------------------------------------------------
    // the system looks for Products that are newly calculated as being in Stock or having had stock movement
    // that do not belong to any Location. The user will be asked to go configure them but only once!
    // This is done by checking if the "visible" Products that are now in <No Location> appear in
    // older AuditLocations record batches for <No Location>. If yes then the user was OK with it in the past...
  //   ---------------------------------------------------------------------------------------------------------

  if data1.curByLocation then
  begin
    Data1.GenerateCurrentStockAuditLocationFigures(False, False);

    with dmADO.adoqRun do
    begin
      // check to see if any of these products are new for this site's stock levels/movement...
      Close;
      sql.Clear;
      SQL.Add('select a.EntityCode  ');
      SQL.Add('from (select * from AuditLocationsCur 	 WHERE LocationID = 999  ');
      SQL.Add('      AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0) or ("WastePC" <> 0))) a ');
      SQL.Add('left join (select * from AuditLocations  WHERE LocationID = 999  ');
      SQL.Add('            AND StkCode = ' + IntToStr(data1.StkCode - 1) + ' AND Tid = '+IntToStr(data1.curtid));
      SQL.Add('          ) l on a.EntityCode = l.EntityCode  ');
      SQL.Add('left join (select * from AuditLocations  WHERE LocationID = 999  ');
      SQL.Add('	    AND StkCode = ' + IntToStr(data1.StkCode) + ' AND Tid = '+IntToStr(data1.curtid));
      SQL.Add('          ) c on a.EntityCode = c.EntityCode   ');
      SQL.Add('where l.EntityCode is NULL and c.EntityCode is NULL ');
      open;

      if RecordCount > 0 then
      begin
        case MessageDlg('There are ' + inttostr(RecordCount) + ' products newly detected by the system which are '+#13+#10+
             'expected to be on Site but are not allocated to any Count Location.'+#13+#10+''+#13+#10+
             'You can proceed with the '+ data1.SSlow +' and these products will appear in "<No Location>"' + #13+#10+
             'or you can stop and go to configure these products in one or more Locations'+#13+#10+#13+#10+
             'Do you want to continue with the '+ data1.SSlow +'?'+#13+
             'Click "No" to save the figures calculated so far and enter the Audit Counts later.'+#13+
             'Click "Abort" to remove all data for this ' + data1.SSlow + '.',mtConfirmation,[mbYes,mbNo,mbAbort],0) of
         mrNo: begin
                close;
                exit;
               end;
         mrAbort: begin
               // remove all data for this stock
               close;
               fMainMenu.Enabled := False;
               data1.killStock(data1.CurTid, data1.StkCode);
               fMainMenu.Enabled := True;
               exit;
               end;
        end; // case..
       end;

       close;
     end; // with
  end; // if byLocation

  if not data1.noCountSheetDlg then // if not configured to suppress the Count Sheet printing prompt
  begin
    if MessageDlg('In the next step the actual closing ' + data1.SSlow +
      ' levels will be required to complete the ' + data1.SSbig + '.' +
      #13 + #13 + 'Do you want to print the Count Sheets for the Current ' + data1.SSbig + ' now?',
      mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin
      fRepSP := TfRepSP.Create(Self);
      if data1.curByHZ then
      begin
        Data1.GenerateCurrentStockAuditFigures(False, False);
        with dmADO.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('select hzid, hzname from stkHZs where active = 1');
          open;

          while not eof do
          begin
            fRepSP.adoqCount.sql.Clear;
            fRepSP.adoqCount.sql.Add('SELECT [HzID], [EntityCode], [SubCat], [ImpExRef], [Name], [OpStk],');
            fRepSP.adoqCount.sql.Add('[ThRedQty], [ThCloseStk], [ActCloseStk], [PurchUnit], [PurchBaseU], [ACount],');
            fRepSP.adoqCount.sql.Add('[WasteTill], [WastePC], [WasteTillA], [WastePCA], [Wastage], [ShouldBe],');
            fRepSP.adoqCount.sql.Add('(purchstk + moveqty) AS PurchStk, moveQty, PurchCostPU, NomPricePU, MustCount FROM AuditCur');
            fRepSP.adoqCount.sql.Add('WHERE hzid = ' + FieldByName('hzid').asstring);
            fRepSP.adoqCount.sql.Add('AND (shouldbe = 0 OR MustCount = 1)');
            fRepSP.adoqCount.sql.Add('Order BY "SubCat", "Name"');
            fRepSP.adoqCount.Open;
            fRepSP.ppLabel23.Visible := True;
            fRepSP.ppLabel23.Caption := 'For Holding Zone: ' + FieldByName('hzname').asstring;
            fRepSP.ACSprint(false); // sets the fields
            fRepSP.PrintCount;
            fRepSP.adoqCount.Close;
            next;
          end; // while

          close;
        end;
      end
      else  if data1.curByLocation then
      begin
         Data1.GenerateCurrentStockAuditLocationFigures(False, False);

         // first print the <No Location> Count Sheet, if there are any products for it...
         // use "normal" count sheet
         fRepSP.adoqCount.Close;
         fRepSP.adoqCount.sql.Clear;
         fRepSP.adoqCount.sql.Add('select * from AuditLocationsCur');
         fRepSP.adoqCount.sql.Add('WHERE LocationID = 999');
         fRepSP.adoqCount.sql.Add('AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ' +
                          ' ("WasteTill" <> 0) or ("WastePC" <> 0) or (MustCount = 1))');
         fRepSP.adoqCount.sql.Add('Order By SubCat, [Name]');

         fRepSP.ppLabel23.Visible := TRUE;
         fRepSP.ppLabel23.Caption := 'For Products not assigned to any Location';
         fRepSP.ppLabel3.Caption := '"No Location" Count';
         fRepSP.ACSprint(false); // sets the fields
         fRepSP.ppDBText3.DataField := 'Unit';

         fRepSP.adoqCount.Open;
         if fRepSP.adoqCount.RecordCount > 0 then
           fRepSP.PrintCount;
         fRepSP.adoqCount.Close;

         // now print the Locations sheets...
         with dmADO.adoqRun do
         begin
           Close;
           sql.Clear;
           SQL.Add('select loc.[LocationID], loc.[LocationName], loc.Active, loc.PrintNote');
           SQL.Add('from stkLocations loc  ');
           SQL.Add('WHERE loc.SiteCode = ' +IntToStr(data1.TheSiteCode));
           SQL.Add('and loc.Deleted = 0 order by loc.[LocationName]');
           open;

           while not eof do
           begin
             fRepSP.Free;
             fRepSP := TfRepSP.Create(Self);

             fRepSP.ppLabel67.Caption := 'For Count Location: ' + FieldByName('LocationName').asstring;
             fRepSP.ppLabel11.Caption := FieldByName('LocationName').asstring + '  Count';
             fRepSP.ppMemoLocNote.Text := FieldByName('PrintNote').asstring;
             fRepSP.adoqLocationCount.sql.Clear;
             fRepSP.adoqLocationCount.sql.Add('select * from AuditLocationsCur');
             fRepSP.adoqLocationCount.sql.Add('WHERE LocationID = ' + FieldByName('LocationID').asstring);
             fRepSP.adoqLocationCount.sql.Add('Order By RecID');
             fRepSP.adoqLocationCount.Open;

             if fRepSP.adoqLocationCount.RecordCount > 0 then
               fRepSP.PrintLocationCount;
             fRepSP.adoqLocationCount.Close;
             next;
           end; // while
         end;
      end
      else  // not by HZ and not by Location...
      begin
        Data1.GenerateCurrentStockAuditFigures(False, False);
        fRepSP.adoqCount.sql.Clear;
        fRepSP.adoqCount.sql.Add('SELECT [HzID], [EntityCode], [SubCat], [ImpExRef], [Name], [OpStk],');
        fRepSP.adoqCount.sql.Add('[ThRedQty], [ThCloseStk], [ActCloseStk], [PurchUnit], [PurchBaseU], [ACount],');
        fRepSP.adoqCount.sql.Add('[WasteTill], [WastePC], [WasteTillA], [WastePCA], [Wastage], [ShouldBe],');
        fRepSP.adoqCount.sql.Add('(purchstk + moveqty) AS PurchStk, moveQty, PurchCostPU, NomPricePU, MustCount FROM AuditCur');
        fRepSP.adoqCount.sql.Add('WHERE hzid = 0');
        fRepSP.adoqCount.sql.Add('AND (shouldbe = 0 OR MustCount = 1)');
        fRepSP.adoqCount.sql.Add('Order BY "SubCat", "Name"');
        fRepSP.adoqCount.Open;
        fRepSP.ppLabel23.Visible := False;
        fRepSP.ACSprint(false); // sets the fields
        fRepSP.PrintCount;
        fRepSP.adoqCount.Close;
      end;
      fRepSP.Free;
    end;  // Count Sheets printed before the Audit...
  end; // end    if not data1.noCountSheetDlg

  // Get user to enter stock levels
  Case MessageDlg('All opening ' + data1.SSlow + ', purchases and sales '+
           'information has been gathered and processed.'+#13+
           'The actual closing ' + data1.SSlow + ' levels are now required to complete the ' + data1.SSbig + '.'+#13+
           #13+'Click "Yes" to enter audited ' + data1.SSlow + ' levels.'+#13+
           'Click "No" to save the figures calculated so far and enter the audit levels later.'+#13+
           'Click "Abort" to remove all data for this ' + data1.SSlow + '.'
           ,mtConfirmation,[mbYes,mbNo,mbAbort],0) of
       mrNo: begin
              // save all figs so far & return to main
               exit;
             end;
    mrAbort: begin
              // remove all data for this stock
               fMainMenu.Enabled := False;
               data1.killStock(data1.CurTid, data1.StkCode);
               fMainMenu.Enabled := True;
               exit;
             end;
  end; // case..

  log.event('Before Audit.');
  // user chose to continue...

  if data1.curByLocation then
    Data1.GenerateCurrentStockAuditLocationFigures(False, True)
  else
    Data1.GenerateCurrentStockAuditFigures(False, True);

  // Stock Import rules:   for Locations, only the new MobileStockImport
  //                       for HZs, only the old HandHeldImport
  //                       normal Stocks, choose the MobileStock if any, if not get the HandHeld.
  if data1.curByLocation and data1.MobileStockImportsExist then
    DisplayMobileStockImportForm
  else if data1.curByHz and data1.HandHeldImportsExist then
    DisplayHandHeldImportForm
  else if data1.MobileStockImportsExist then
    DisplayMobileStockImportForm
  else if data1.HandHeldImportsExist then
    DisplayHandHeldImportForm;

  if data1.curByLocation then
  begin
    fAuditLocations := TfAuditLocations.Create(Self);
    fAuditLocations.Top := self.Top;
    fAuditLocations.Left := self.Left;
    if fAuditLocations.ShowModal = mrCancel then
    begin
      fAuditLocations.Free;
      exit;
    end;
    fAuditLocations.Free;

    with data1.adoqRun do
    begin
      // by now the AuditLocations table has all the Locations Count data summed up and stored in LocationID = 0
      // as far as the rest of the system is concerned that is the only Audit Count data...

      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET AuditStk = sq.ActCloseStk,');
      sql.Add(' ActCloseStk = sq.ActCloseStk, WasteTillA = sq.WasteTillA, WastePCA = sq.WastePCA,');                                                     /////////////
      sql.Add(' Wastage = WasteTill + WastePC + sq.WasteTillA + sq.WastePCA');
      sql.Add('from');
      sql.Add('  (select a.entitycode, sum(a.ActCloseStk * a.PurchBaseU) as ActCloseStk,');
      sql.Add('    sum(a.wastetilla * a.PurchBaseU) as wastetilla, sum(a.wastepca * a.PurchBaseU) as wastepca');
      sql.Add('   FROM AuditLocations a WHERE a.stkcode = '+IntToStr(data1.StkCode));
      sql.Add('   and tid = '+IntToStr(data1.curtid));
      sql.Add('   group by a.entitycode) sq');
      sql.Add('where stkcrdiv.entitycode = sq.entitycode and stkcrdiv.hzid = 0');
      Execsql;
    end;
  end
  else    // not by Location
  begin
    // if this site is in "special" MatchDay mode then import Spot Checks into Auditcur as Stock Counts
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('IF [dbo].[fn_GetConfigurationSetting] (''EnableMatchDayStock'') = ''1'' ');
      sql.Add('   exec stkSP_StockCountFromSpotChecks');
      Execsql;
    end;

    fAudit := TfAudit.Create(Self);
    if fAudit.ShowModal = mrCancel then
    begin
      fAudit.Free;
      exit;
    end;
    fAudit.Free;

    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE StkCrDiv SET AuditStk = sq."ActCloseStk",'); // 17841 & 17700
      sql.Add('ActCloseStk = sq."ActCloseStk",');                                                     /////////////
      sql.Add('WasteTillA = sq."WasteTillA", WastePCA = sq."WastePCA", Wastage = sq."Wastage"');
      sql.Add('from');
      sql.Add(' ( SELECT a.hzid, a."entitycode", ');
      sql.Add('   (a."ActCloseStk" * a."PurchBaseU") as ActCloseStk,');
      sql.Add('   (a."WasteTillA" * a."PurchBaseU") as WasteTillA,');
      sql.Add('   (a."WastePCA" * a."PurchBaseU") as WastePCA,');
      sql.Add('   (a."Wastage" * a."PurchBaseU") as Wastage');
      sql.Add('   FROM "Audit" a WHERE a."stkcode" = '+IntToStr(data1.StkCode));
      sql.Add('   and tid = '+IntToStr(data1.curtid));
      sql.Add(' ) as sq');
      sql.Add('where stkcrdiv.entitycode = sq."entitycode" and stkcrdiv.hzid = sq.hzid');
      Execsql;
    end;
  end;       // if by Location, else, end.

  log.event('Audit figures in. Start processing again...');
  if not dataProc.PostAudit then
  begin
    log.event('ERROR - PostAudit did not work');
    exit;
  end;
  data1.PushStkMain;
  data1.PushStkSold;
  data1.PushPrepared;
  data1.UpdateCurrStage(3); // stage 3, All audit figs, costs, prices, sitems calc'ed

  if data1.FinishStk(True) then // get misc stuff, prep for reps & acceptance
  begin
    data1.UpdateCurrStage(4); // stage 4, ready for acceptance
    log.event('Stock complete');
    showmessage(data1.SSbig + ' complete, go to "Current ' + data1.SSplural + '" to view reports.');
  end
  else
  begin
    log.event('Stock Audited - User cancelled out of Misc Info');
    showmessage(data1.SSbig + ' is Audited but not Complete, go to "Current ' + data1.SSplural + '" to continue when ready.');
  end;
end; // procedure

procedure TfMainMenu.CloseBtnClick(Sender: TObject);
begin
  log.event('Stock System Closed-------------------------------');

	Application.Terminate;
end;

procedure TfMainMenu.CurrBtnClick(Sender: TObject);
begin
  fCurrdlg := TfCurrdlg.Create(self);
  if fCurrdlg.wwqCurStk.RecordCount = 0 then
  begin
    showMessage('There are no ' + data1.SSplural + ' currently active.');
    FreeAndNil(fcurrdlg);
    exit;
  end;
  fCurrdlg.Top := self.Top;
  fCurrdlg.Left := self.Left;

  fCurrdlg.ShowModal;
  FreeAndNil(fcurrdlg);
end;

procedure TfMainMenu.AccBtnClick(Sender: TObject);
begin
	faccepted := Tfaccepted.Create(Self);

  faccepted.wwtaccstk.Open;
  if faccepted.wwtaccstk.RecordCount = 0 then
  begin
    showMessage('There are no Accepted ' + data1.SSplural + '.');
    faccepted.free;
    exit;
  end;

  faccepted.Top := self.Top;
  faccepted.Left := self.Left;

  faccepted.ShowModal;
  faccepted.Free;
end;

procedure TfMainMenu.FormActivate(Sender: TObject);
begin
  if bugout then
    Halt;
end;

procedure TfMainMenu.BitBtn10Click(Sender: TObject);
begin
  // configure threads
  fConfTh := TfConfTh.Create(self);
  fConfTh.ShowModal;
  fConfTh.Free;
end;

function GetLocale: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Control Panel\International', False);

    if Reg.ReadString('Locale') = '00000409' then
      Result := 'US'
    else
      Result := 'UK';
  finally
    Reg.Free;
  end;
end;

procedure TfMainMenu.LogException(Sender: TObject; E: Exception);
begin
  Log.event('** ERROR - Exception: ' + E.ClassName + ', ' + E.Message);
  EQATECMonitor.EQATECAppException(Application.Title, E);
  Application.ShowException(E);
end;

function GetTokenParam: string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to ParamCount do
  begin
    if Copy(LowerCase(ParamStr(i)),1,6) = 'token=' then
      Result := Copy( ParamStr(i), 7, Length(ParamStr(i)) );
  end;
end;

procedure TfMainMenu.FormCreate(Sender: TObject);
var
  ssUKUS, paperName, errStr, s1: string;
  ModuleVersion, MinDBVersion: array[0..25] of char;

  showSec, showTh, showHOR, showSR, showCur,
  showAcc, showNew, showLC, showConfig, showHZmove, showPCwaste: Boolean;
  nextB, curB : integer;
  tokenParam : string;
begin
  {Register a custom windows message}
  MyMsg := RegisterWindowMessage(PChar('AZSS_MUTEX'));// + ExtractFilePath(Application.ExeName)));
  {Set form's windows proc to ours and remember the old window proc}
  OldWindowProc := Pointer(SetWindowLong(fMainMenu.Handle, GWL_WNDPROC, LongInt(@NewWindowProc)));

  btnEQATECExceptionTest.Visible := EQATECMonitor.TriggerEQATECTestException();

  Application.OnMinimize := AppMinimize;
  Application.OnRestore := AppRestore;
  Application.OnException := LogException;

  progStart := true;

  if not progStart then
    exit;

  tokenParam := GetTokenParam;

  progStart := false;
  Application.CreateForm(TdmADO, dmADO);

  // put the right name in the splash form depending where you are...
  SplashForm := TSplashForm.Create(Self);
  if GetLocale = 'US' then
  begin
    SplashForm.ProductName.Caption := 'Inventory';
  end
  else
  begin
    SplashForm.ProductName.Caption := 'Stock Auditing';
  end;
  SplashForm.Show;

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      Application.Title + ' will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      Application.Title + ' will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;

  uGlobals.GetGlobalData(dmADO.AztecConn);

  data1 := TData1.Create(self);
  dataProc := TdataProc.Create(self);

  SetFormStartupState;

  // get UKUS mode
  data1.UKUSMode := GetLocale;

  if data1.UKUSmode = 'UK' then
  begin
    ssUKUS := 'UK';
    data1.SSbig := 'Stock';
    data1.SSplural := 'Stocks';
    data1.SSsmall := 'Stk.';
    data1.sslow := 'stock';
    data1.ss6 := 'Stock';
    data1.ssTill := 'Till';
    data1.ukusDateForm2y := 'dd/mm/yy';
    Application.Title := 'Aztec Stock Auditing';
  end
  else
  begin
    ssUKUS := 'US';
    data1.SSbig := 'Inventory';
    data1.SSplural := 'Inventories';
    data1.SSsmall := 'Invt';
    data1.sslow := 'inventory';
    data1.ss6 := 'Invtry';
    data1.ssTill := 'Register';
    data1.ukusDateForm2y := 'mm/dd/yy';
    Application.Title := 'Aztec Inventory';
  end;

   if EQATECMonitor.IsEQATECEnabled then
   begin
     EQATECMonitor.SetupMonitor(Application.Title);
     EQATECMonitor.TrackFeatureStart(Application.Title);  
   end;

  // get repPaperName
  with data1.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('select * from Genervar');
    SQL.Add('where VarName = ''RPaperName''');
    Open;


    if recordcount = 0 then // create it first
    begin
      close;
      sql.Clear;
      sql.Add('insert into GenerVar (VarName) Values(''RPaperName'')');
      execSQL;
      paperName := '';
    end
    else
    begin
      paperName := FieldByName('varstring').asstring;
      close;
    end;

    // if papername not set, set default values...
    if paperName = '' then
    begin
      if data1.UKUSmode = 'UK' then
      begin
        paperName := 'A4';
      end
      else
      begin
        paperName := 'Letter';
      end;

      close;
      sql.Clear;
      sql.Add('update GenerVar set VarString = ' + quotedstr(paperName));
      sql.Add('where VarName = ''RPaperName''');
      execSQL;
    end;
  end;

  if not CheckStocksEnabled then
  begin
    ShowMessage(Application.Title + ' has not been configured to run yet!');

    dmADO.Free;
    data1.Free;
    dataProc.Free;

    Application.Terminate;
      bugout := True;
      exit;
  end;

  if uGlobals.IsSite then
  begin
    if uGlobals.IsMaster then
    begin
      self.Caption := Application.Title + ' - - Single Site Master';
      Application.HelpFile := 'Help\IS_SITEMASTER_' + ssUKUS + '.HLP';
      self.HelpContext := 1001;
    end
    else
    begin
      self.Caption := Application.Title + ' - - Site: ' + data1.theSiteName;
      Application.HelpFile := 'Help\IS_SITE_' + ssUKUS + '.HLP';
      self.HelpContext := 1001;
    end;

    if data1.noTillsOnSite then
      self.Caption := self.Caption + ' (No Terminals on this Site)';

    // kill the LC "lock" in case it wasn't killed last time...
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''LConLck''');
      sql.Add('     AND SiteCode = '+IntToStr(data1.TheSiteCode)+' ) = 1');
      sql.Add('BEGIN');
      sql.Add('  DELETE stkVarLocal where VarName = ''LConLck''');
      sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
      sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+',''LConLck'', 0, GetDate())');
      sql.Add('END');
      execSQL;
    end;
  end
  else
  begin
    self.Caption := Application.Title + ' - - Head Office';
    Application.HelpFile := 'Help\IS_HO_' + ssUKUS + '.HLP';
    self.HelpContext := 1001;
  end;

  if TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    if not TfrmPassword.UserHasPermission('action://InstantStocks/ModuleAccess') then
    begin
      MessageDlg('User has insufficent privileges to run Aztec Instant Stocks.' + #10 + #13 +
        #10 + #13 + 'The application will now terminate.', mtInformation, [mbOK], 0);

      Application.Terminate;
      Exit;
    end;
  end
  else
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log.Event('WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log.Event('WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log.Event('Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    ShowMessage('You do not have sufficient permissions to run the Aztec Instant Stocks.' +
              #13 + #10 + #13 + #10 + 'The application will now terminate.');
    bugout := True;
    Halt;
  end;

  SplashForm.Dismiss; 

  Log.Event('User & Pass Verified OK. User: "' + CurrentUser.UserName +
    '". MainMenu Title: "' + self.Caption + '"');
  Log.setuser(CurrentUser.UserName);


    // set the global Printer Size to be ised by all reports...
    // set it only now because seeting it changes the Command Line Parameters to lower case (?!?!?!?)
    // and that makes it impossible to log on with a Token
    data1.SetPrinterSize(paperName);



  // wake up the security adoQuery in data1 to have the UserAllowed function working...
  with data1.adoqSecure do
  begin
    close;
    sql.Clear;
    sql.Add('select * from stkSecurity');
    sql.Add('where roleid '+ uGlobals.CurrentUser.Roles.AsSQLCheck);
    open;
  end;


  if uGlobals.IsMaster then // HO and Single SM
  begin
    // how many reps are set up? should be 10
    try
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('select count(AR) as thecount from stkareps');
        open;
        if FieldByName('thecount').AsInteger < 10 then
        begin
          close;
          sql.Clear;
          sql.Add('DELETE FROM [stkAReps]');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (1,''Holding - Basic Version (Portrait page)'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (3,''Sales & Profitability Report'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (4,''Loss/Gain - at Cost'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (2,''Holding - with Theo. & Prep. Reduction'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (5,''Loss/Gain - at Value'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (6,''Loss/Gain - Cost & Value'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (7,''Traditional Summary'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (8,''Retail Summary - Cost Variance'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (9,''Retail Summary - Profit Variance'')');
          sql.Add('INSERT INTO [dbo].[stkAreps]([AR], [Text]) VALUES (10,''Holding - with Var. Cost/Value & Yield'')');
          execSQL;
        end;
      end;
    except
      on E:exception do
      begin
        Log.event('ERROR Re-filling table stkAReps; Error Message: ' + E.Message);
      end;
    end;
  end;

  // create stksectids to hold the threads permissions for this user
  dmADO.DelSQLTable('stksectids');
  with dmADO.adoqRun do
  begin
    if CurrentUser.IsZonalUser then
    begin
      close;
      sql.Clear;
      sql.Add('select distinct a.tid, b.permid into dbo.[stksectids] ');
      sql.Add('from threads a, stkSecPerms b');
      sql.Add('where b.parent > 1');
      execSQL;
    end
    else
    begin
      close;
      sql.Clear;
      sql.Add('select distinct tid, permid into dbo.[stksectids] from stkSecurity');
      sql.Add('where RoleID '+CurrentUser.Roles.AsSQLCheck);
      sql.Add('and permset = ''Y''');
      execSQL;
    end;
  end;

  // determine what buttons are visible depending on Security permissions

  showSec := (data1.UserAllowed(0, 4) or data1.UserAllowed(0, 5));
  showTh := (data1.UserAllowed(0, 1) or data1.UserAllowed(0, 2) or data1.UserAllowed(0, 3));
  showHOR := (data1.UserAllowed(0, 26) and (not uGlobals.isSite));

  showSR := (data1.UserAllowed(-1, 21) and uGlobals.isSite);
  showCur := data1.UserAllowed(-1, 8);
  showAcc := data1.UserAllowed(-1, 18);
  showNew := data1.UserAllowed(-1, 7);
  showConfig := ((data1.UserAllowed(-1, 27) and uGlobals.isSite) or
                  (data1.UserAllowed(-1, 33) and uGlobals.isMaster));
  showLC := (data1.UserAllowed(-1, 28) or data1.UserAllowed(-1, 31));
  showHZMove := data1.UserAllowed(-1, 32);
  showPCwaste := data1.UserAllowed(-1, 36);

  nextB := 1;
  // determine what buttons are visible depending on Site/Ho/SiteMaster
  if uGlobals.IsSite then
  begin
    // first, common ones for Site OR Site/Master
    if showNew then
    begin
      theButs[nextB] := btnNew;
      inc(nextB);
    end;
    if showSR then
    begin
      theButs[nextB] := btnRep;
      inc(nextB);
    end;
    if showCur then
    begin
      theButs[nextB] := btnCurr;
      inc(nextB);
    end;
    if showAcc then
    begin
      theButs[nextB] := btnAcc;
      inc(nextB);
    end;

    // now for Site/Master only
    if uGlobals.IsMaster then
    begin
      if showTh then
      begin
        theButs[nextB] := btnThreads;
        inc(nextB);
      end;
      if showSec then
      begin
        theButs[nextB] := btnSec;
        inc(nextB);
      end;
    end;

    // and again common ones for Site OR Site/Master
    if showLC then
    begin
      theButs[nextB] := btnLC;
      inc(nextB);
    end;
    if showConfig then
    begin
      theButs[nextB] := btnConfig;
      inc(nextB);
    end;

    if showHZmove then
    begin
      theButs[nextB] := btnHZmove;
      inc(nextB);
    end;

    if showPCwaste then
    begin
      theButs[nextB] := btnPCwaste;
      inc(nextB);
    end;

  end
  else if uGlobals.IsMaster then // Normal Master
  begin
    if showTh then
    begin
      theButs[nextB] := btnThreads;
      inc(nextB);
    end;
    if showHOR then
    begin
      theButs[nextB] := btnRep;
      inc(nextB);
    end;
    if showSec then
    begin
      theButs[nextB] := btnSec;
      inc(nextB);
    end;
    if showConfig then
    begin
      theButs[nextB] := btnConfig;
      inc(nextB);
    end;
  end;

  if btnEQATECExceptionTest.Visible then
  begin
      theButs[nextB] := btnEQATECExceptionTest;
      inc(nextB);
  end;

  theButs[nextB] := btnExit;

  // if the only button to be seen is the exit one (nextB = 1) then tell user and bug out...
  bugout := false;

  if nextB = 1 then
  begin
    showMessage('You do not have Security Permissions for any operation on any ' + data1.SSbig + ' Thread!' + #13 + #13 +
                'These Permissions are configured from within the Head Office ' + data1.SSbig + ' System.' + #13 +
                'Only an authorized user at Head Office can set up these permissions.' + #13 + #13 +
                'Please contact your Head Office or your Aztec System Administrator for more information.' +
     #13 + #13 + 'The system will now close.');
    HALT;
  end;

  // arrange buttons on form
  for curB := 1 to nextB do
  begin
    theButs[curB].Visible := True;
    theButs[curB].Top := 8 + (91 * (((curB + 1) div 2) - 1));
    theButs[curB].Left := 8 + (325 * ((curB + 1) mod 2));
    theButs[curB].TabOrder := curB;
  end; // for..

  if odd(nextB) then // last row has only 1 button, center it..
    theButs[nextB].Left := 171;

  // set form height
  self.Height := theButs[nextB].Top + theButs[nextB].Height + 35;


  btnNew.Caption := '&New ' + data1.SSbig;
  btnCurr.Caption := '&Current ' + data1.SSplural;
  btnAcc.Caption := '&Accepted ' + data1.SSplural;
  btnExit.Caption := 'E&xit ' + Application.Title;

  btnHZmove.Enabled := data1.SiteUsesHZs;

  if uGlobals.isSite then
  begin
    // check All the locks
    errStr := data1.CheckSPsLocks;

    if pos('RERR ', errStr) > 0 then
    begin
      // extract the lock datetime
      s1 := copy(errStr, pos('RERR ', errStr) + 5, 18);

      // stk121Rcp lock is Stuck on, warn the user
      showmessage('                 ----- RECIPE MAP WARNING! -----' + #13 + #13 +
                  'The process that creates the one-to-one Recipe Map was interrupted' + #13 +
                  'on its last run (run started: ' + s1 + ')' + #13 + #13 +
                  'The Recipe Map may now be invalid so calculations based on it may be incorrect!' +
                   #13 + 'This should be investigated as soon as possible.');
      log.event('User Warned to investigate the 121RcpMap Lock stuck ON from: ' + s1);
    end;

    if pos('TERR ', errStr) > 0 then
    begin
      // extract the lock datetime
      s1 := copy(errStr, pos('TERR ', errStr) + 5, 18);

      // stk121Rcp lock is Stuck on, warn the user
      showmessage('                 ----- THEO. REDUCTION WARNING! -----' + #13 + #13 +
                  'The process that makes Theo. Reduction from Sales was interrupted' + #13 +
                  'on its last run (run started: ' + s1 + ')' + #13 + #13 +
                  'The Theo. Reduction data may now be invalid so calculations based on it may be incorrect!' +
                   #13 + 'This should be investigated as soon as possible.');
      log.event('User Warned to investigate the TheoRed Lock stuck ON from: ' + s1);
    end;



    with dmADO.adoqRun do
    begin
      errStr := '';

      // even if the "hard" locks are not on now, were they "killed" by make121Rcp or by makeTheoRed?
      close;
      sql.Clear;
      sql.Add('select * from stkDBGlog where SUBSTRING([logstring], 1, 12) = ''EntRcp lock ''');
      sql.Add('and caller <> ''stkSP_make121Rcp'''); // if killed by make121Rcp that's OK as
      sql.Add('order by logdt DESC');                // the map is now up to date
      open;

      if recordcount >= 1 then
      begin
        showmessage('There was a failure when re-creating the one-to-one Recipe Map!' + #13 +
                    '      (error flagged at: ' + FieldByName('logdt').AsString + ')' + #13 + #13 +
                    'The Recipe Map may be obsolete. This should be investigated as soon as possible.');

        log.event('User Warned to investigate the 121RcpMap Lock (' + FieldByName('logdt').AsString + ' - "' +
              FieldByName('logstring').asstring + '") - stkDBGlog was changed');

        edit;
        FieldByName('logstring').AsString := 'WARNED - ' + FieldByName('logstring').AsString;
        FieldByName('logText').asstring := 'WARNING GIVEN: ' +
          formatDateTime('dd mmm yy hh:nn:ss', Now) + ' To: ' + CurrentUser.UserName;
        post;
      end;

      close;

    end;
  end;
end;

procedure TfMainMenu.FormDestroy(Sender: TObject);
begin
  {Set form's window proc back to it's original procedure}
  SetWindowLong(fMainMenu.Handle, GWL_WNDPROC, LongInt(OldWindowProc));
end;

procedure TfMainMenu.AppMinimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TfMainMenu.AppRestore(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_RESTORE);
end;

procedure TfMainMenu.btnRepClick(Sender: TObject);
begin
  if not uGlobals.isSite then // normal Master
  begin
    fhoRep := TfhoRep.Create(self);
    fhoRep.ShowModal;
    fhoRep.Free;       
  end
  else
  begin
    fPickRep := TfPickRep.Create(self);
    fPickRep.ShowModal;
    fPickRep.Free;
  end;
end;

procedure TfMainMenu.FormShow(Sender: TObject);
begin
  if bugout then
    exit;

  WindowState := RunState;
  try
    theButs[1].SetFocus;
  except
  end;

  if data1.CheckForOutstandingDeliveryNotes() then
    MessageDlg('There are currently existing Hand Held Delivery Notes that require user intervention.'
        +#13#10 + #13#10 + 'It is recommended that you attend to these before making any changes to the Stocks system.'
        + ' Use the Purchasing system to address these issues.',
        mtWarning, [mbOK], 0);

end;

procedure TfMainMenu.SetFormStartupState;
begin
    RunState := wsNormal;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Genervar');
    SQL.Add('where VarName = ''RunMin''');
    SQL.Add('and VarString is not NULL and VarString = ''Y''');
    Open;

    if RecordCount > 0 then
      RunState := wsMinimized;

    Close;

    SQL.Clear;
    SQL.Add('select * from Genervar');
    SQL.Add('where VarName = ''RunMax''');
    SQL.Add('and VarString is not NULL and VarString = ''Y''');
    Open;

    if RecordCount > 0 then
      RunState := wsMaximized;

    Close;
  end;
end;

function TfMainMenu.CheckStocksEnabled: boolean;
var
  i : integer;
begin
  if uGlobals.IsMaster then
  begin
    // is stkSites there? if not create it...
    if not dmADO.SQLTableExists('stkSites') then
    begin
      try
        with dmADO.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('CREATE TABLE dbo.stkSites');
          sql.Add('  (SiteCode INT,');
          sql.Add('   DateAdd SMALLDATETIME,');
          sql.Add('   CONSTRAINT ID_PKstkSites PRIMARY KEY (SiteCode))');
          execSQL;
        end;
      except
        on E:exception do
        begin
          showMessage('Error trying to Create a table!' + #13 + #13 +
            'Error Message: ' + E.Message + #13 + #13 +
            'The system cannot continue. Please contact Zonal.');
          Log.event('HALT PROGRAM! Error Creating table stkSites; Error Message: ' + E.Message);

          HALT;
        end;
      end;
    end;

    // now check that all sites in table "site" that have the stksys turned ON are already
    // in stkSites. If not set Threads LMDT to NOW and add the new site(s) to the table.
    // The Threads table will be sent to ALL sites again on the next PCLink

    with dmADO.adoqRun do
    begin
      // but first delete any sites from stkSites that should no longer be there
      // this is required as if the site is "re-enabled" later the Threads table should
      // have its LMDT changed again...

      close;
      sql.Clear;
      sql.Add('delete stkSites');
      sql.Add('where [SiteCode] not in ');
      SQL.Add('(select distinct [Site Code] from Site');
      SQL.Add('where (Deleted is NULL or Deleted <> ''Y'')');
      SQL.Add('and [Aztec Stock] is not NULL');
      SQL.Add('and [Aztec Stock] = ''Y'')');
      i := execSQL;

      if i > 0 then
      begin
        Log.event('Deleted ' + inttostr(i) + ' site(s) from stkSites');
      end;

      Close;
      SQL.Clear;
      SQL.Add('select distinct [Site Code] from Site');
      SQL.Add('where  (Deleted is NULL or Deleted <> ''Y'')');
      SQL.Add('and [Aztec Stock] is not NULL');
      SQL.Add('and [Aztec Stock] = ''Y''');
      sql.Add('and [Site Code] not in (select distinct [SiteCode] from stkSites)');
      Open;

      if RecordCount > 0 then // new sites
      begin
        Log.event('Adding new site(s) to stkSites (' + inttostr(RecordCount) + ')');

        close;
        sql.Clear;
        sql.Add('insert into stkSites');
        SQL.Add('select distinct [Site Code],' +
           quotedStr(formatDateTime('mm/dd/yyyy hh:nn', Now))  + ' from Site');
        SQL.Add('where  (Deleted is NULL or Deleted <> ''Y'')');
        SQL.Add('and [Aztec Stock] is not NULL');
        SQL.Add('and [Aztec Stock] = ''Y''');
        sql.Add('and [Site Code] not in (select distinct [SiteCode] from stkSites)');
        execSQL;

        close;
        sql.Clear;
        sql.Add('update [Threads] set lmBy = ''Sys-Sites Added'',');
        sql.Add('lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)));
        execSQL;
      end;

      Close;
    end;
    Result := True;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Site');
    SQL.Add('where [Site Code] = ' + inttostr(Data1.TheSiteCode));
    SQL.Add('and (Deleted is NULL or Deleted <> ''Y'')');
    SQL.Add('and [Aztec Stock] is not NULL');
    SQL.Add('and [Aztec Stock] = ''Y''');
    Open;

    Result := RecordCount > 0;

    Close;
  end;
end;

procedure TfMainMenu.btnSecClick(Sender: TObject);
begin
  fSecurity := TfSecurity.Create(self);
  if fSecurity.okToShow then
  begin
    fSecurity.showThread := -1;
    fSecurity.Caption := 'Security Configuration';
    fSecurity.ShowModal;
  end;
  fSecurity.Free;
end;

procedure TfMainMenu.btnConfigClick(Sender: TObject);
begin
  ConfigureSystem;

  btnHZmove.Enabled := data1.siteUsesHZs;
end;

procedure TfMainMenu.btnLCClick(Sender: TObject);
var
  someLC : boolean;
begin
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(*) from stkECLevel');
    open;
    someLC := (fields[0].AsInteger > 0);
    close;
  end;

  if not someLC then
  begin
    // either there are no Threads and/or accepted stocks (not dummy stocks with stockcode = 1)
    // or there are some but not for the threads for which this user has security permissions
    // EITHER WAY, no LCs can be done and it stands to reason that no LCs are available to report

    showmessage('There are no accepted ' + data1.SSplural + ' to provide a Base for Line Checks.' +
      #13 + #13 + 'Line Checks are not available.');

    exit;
  end;

  if data1.UserAllowed(-1, 28) then // if doLC allowed for at least 1 thread...
  begin
    fLCchoose := TfLCchoose.Create(self);
    fLCchoose.btnRepLC.Visible := data1.UserAllowed(-1, 31);
    fLCchoose.ShowModal;
    fLCchoose.Free;
  end
  else
  begin
    if data1.UserAllowed(-1, 31) then // if LC reps allowed for at least 1 thread...
    begin
      // reports but NOT doLC, go straight to choose report...
      fLCrep := TfLCrep.Create(self);
      fLCrep.ShowModal;
      fLCrep.Free;
    end;
  end;
end;

procedure TfMainMenu.btnHZmoveClick(Sender: TObject);
var
  fHZMoveChoose: TfHZMoveChoose;
begin
  fHZMoveChoose := TfHZMoveChoose.Create(self);
  try
    fHZMoveChoose.ShowModal;
  finally
    fHZMoveChoose.Release;
  end;
end;

procedure TfMainMenu.btnPCwasteClick(Sender: TObject);
var
  fPCWasteChoose: TfPCWasteChoose;
begin
  fPCWasteChoose := TfPCWasteChoose.Create(self);
  try
    fPCWasteChoose.ShowModal;
  finally
    fPCWasteChoose.Release;
  end;
end;

procedure TfMainMenu.btnEQATECExceptionTestClick(Sender: TObject);
begin
   raise Exception.Create(Application.Title+' exception test.');
end;

end.

