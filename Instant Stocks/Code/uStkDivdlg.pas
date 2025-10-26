//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 25 mar 99
//  Unit: uStkDivdlg
//  Form: fStkDivdlg
//
//  Displays form fStkDivdlg where user selects division, stock type and
//  supplies managers & stock takers name. On OK the division is validated
//  against CURSTOCK to see if a stock for this division currently exists,
//  if yes the user re-selects a division or cancels. Global variables are
//  set in udata1 if all values supplied are OK and the Stock code and
//  previous stock code are set.
//
///////////////////////////////////////////////////////////////////////////////
unit uStkDivdlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls,Messages,Dialogs, DBCtrls, Db, Wwdatsrc, Mask,
  wwdbedit, Grids, Wwdbigrd, Wwdbgrid, ADODB, DateUtils;

type
  TfStkDivdlg = class(TForm)
    MgrEdit: TEdit;
    StkTkrEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SiteLbl: TLabel;
    Bevel1: TBevel;
    StkTypeLCB: TDBLookupComboBox;
    wwStktypeDS: TwwDataSource;
    Label5: TLabel;
    Label1: TLabel;
    adoqThreads: TADOQuery;
    dsThreads: TwwDataSource;
    adoqDivs: TADOQuery;
    dsDivs: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    adoqThStock: TADOQuery;
    dsThStocks: TwwDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    wwDBEdit1: TwwDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label12: TLabel;
    adoqThStockSiteCode: TSmallintField;
    adoqThStockTid: TSmallintField;
    adoqThStockStockCode: TSmallintField;
    adoqThStockDivision: TStringField;
    adoqThStockSDate: TDateTimeField;
    adoqThStockSTime: TStringField;
    adoqThStockEDate: TDateTimeField;
    adoqThStockETime: TStringField;
    adoqThStockAccDate: TDateTimeField;
    adoqThStockAccTime: TStringField;
    adoqThStockStage: TStringField;
    adoqThStockType: TStringField;
    adoqThStockDateRecalc: TDateTimeField;
    adoqThStockTimeRecalc: TStringField;
    adoqThStockStkKind: TStringField;
    adoqThStockPrevStkCode: TSmallintField;
    Panel4: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    BitBtn1: TBitBtn;
    Panel5: TPanel;
    Label18: TLabel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    cbCPS: TCheckBox;
    adoqThStockSDT: TDateTimeField;
    adoqThStockEDT: TDateTimeField;
    adoqThStockByHZ: TBooleanField;
    adoqThStockLMDT: TDateTimeField;
    adoqThStockAccBy: TStringField;
    cbAskRcp: TCheckBox;
    adoqThStockPureAZ: TBooleanField;
    adoqThStockRTRcp: TBooleanField;
    Label19: TLabel;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CancelBtnClick(Sender: TObject);
    procedure adoqThStockAfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LAfbD : Tdatetime;
    intEndDoW: smallint;    // intEndDoW: 0- OFF, 1-Mon, 2-Tue, ..., 7-Sun
    dateEndDoW: tdatetime;

    procedure SetSecurity;
  public
    { Public declarations }
  end;

var
  fStkDivdlg: TfStkDivdlg;

implementation

uses Udata1, uADO, ustkutil, ulog, uGlobals;

{$R *.DFM}

//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 25 mar 99
//
//  Division List box is filled. stock type combobox values retrieved and
//  displayed. site name, manager values displayed.
//
///////////////////////////////////////////////////////////////////////////////
procedure TfStkDivdlg.FormShow(Sender: TObject);
begin
  self.Caption := 'New ' + data1.SSbig + ' Setup - Step 1';

  Label3.Caption := data1.SSbig + ' Takers Name:';
  Label5.Caption := data1.SSbig + ' Type:';
  Label9.Caption := data1.SSbig + ' Type:';
  Label12.Caption := ' Last Accepted ' + data1.SSbig + ' Info for selected Thread ';
  Label15.Caption := 'Not initialised (no ' + data1.SSbig + ' Counts available)';
  Label16.Caption := 'No Accepted ' + data1.SSbig + ' on this Thread';
  Label17.Caption := 'You need to initialise this thread. '#13#10'You need to provide initial ' +
    data1.SSbig + ' Counts and Costs for the ' + data1.SSlow + ' items.';

  Label18.Caption := 'There is already a Current ' + data1.SSbig +
      ' for this Thread!'#13#10#13#10'A new ' + data1.SSbig + '' +
      ' can be done only after the Current ' + data1.SSbig + ' is Accepted or Cancelled.';

  adoqDivs.open;
  adoqThreads.Open;
  adoqThStock.open;

  // get list of stock types for drop down list
  Data1.wwtRun.close;
  Data1.wwtRun.TableName := 'StkType';
  wwStktypeDS.DataSet := Data1.wwtRun;
  StkTypeLCB.ListSource := wwStktypeDS;
  StkTypeLCB.Listfield := 'StockTypeShort;Description';
  StkTypeLCB.KeyField := 'StockTypeShort';
  Data1.wwtRun.open; // table needs to stay open until form closed

  // Display site and Managers name
  SiteLbl.Caption := data1.ThesiteName;
  MgrEdit.Text    := data1.TheMgr;
  panel5.Left := 0;
end;

//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 25 mar 99
//  Inputs: None
//  Outputs: None
//  Globals (R): None
//  Globals (W): TheDiv, TheMgr, TheStkTkr, TheStkType
//  Objects Used: None
//
//  Validate user input. Not allowed to progress unless all fields are supplied.
//  Division is validated against CURSTOCK.DB to ensure there is not an existing
//  stock for that division. Globals are set if all values are valid.
//
///////////////////////////////////////////////////////////////////////////////
procedure TfStkDivdlg.OKBtnClick(Sender: TObject);
var
  localETime, s1 : string;
begin
  ModalResult := mrNone;

  if MgrEdit.Text = '' then
    ShowMessage('You Must Enter a Manager Name')
  else if StkTkrEdit.Text = '' then
  	ShowMessage('You Must Enter a ' + data1.SSbig + ' Taker Name')
  else if StkTypeLCB.Text = '' then
     ShowMessage('You Must Enter a ' + data1.SSbig + ' Type')
  else // all ok, set globals
  begin
    Data1.TheMgr := MgrEdit.Text;
    Data1.TheStkTkr := StkTkrEdit.Text;
    Data1.TheStkType := StkTypeLCB.Text;
    data1.StkTypeLong := data1.wwtRun.FieldByName('description').asstring;
    data1.CurTid := adoqThreads.FieldByName('tid').AsInteger;
    data1.curTidName := adoqThreads.FieldByName('tname').asstring;
    data1.TheDiv := adoqThreads.FieldByName('division').Asstring;
    data1.SetCurrentDivisionId(data1.TheDiv);
    data1.curNomPrice := (adoqThreads.FieldByName('nomprice').asstring = 'Y');
    data1.curFillClose := (adoqThreads.FieldByName('fillclose').asstring = 'Y');
    data1.curDozForm := (adoqThreads.FieldByName('dozForm').asstring = 'Y');      // 17701
    data1.curEditTak := (adoqThreads.FieldByName('editTak').asstring = 'Y');
    data1.curIsGP := (adoqThreads.FieldByName('isGP').asstring = 'Y');
    data1.curCPS := (adoqThreads.FieldByName('doCPS').asstring = 'Y');
    data1.curCPNew := (adoqThreads.FieldByName('CPSMode').asstring = 'N');
    data1.curCPSet := (adoqThreads.FieldByName('CPSMode').asstring = 'R');
    data1.curGallForm := (adoqThreads.FieldByName('gallform').asstring = 'Y');
    data1.curTillVarTak := (adoqThreads.FieldByName('tillVarTak').asstring = 'Y');
    data1.curByLocation := (adoqThreads.FieldByName('byHZ').asboolean) and data1.siteUsesLocations; // only one of ...
    data1.curByHz := (adoqThreads.FieldByName('byHZ').asboolean) and data1.siteUsesHZs;            // these 2 can be TRUE
    data1.curWasteAdj := (adoqThreads.FieldByName('WasteAdj').asboolean);

    data1.curisMth := (adoqThreads.FieldByName('slaveTh').asinteger > 0);
    data1.curisSth := (adoqThreads.FieldByName('slaveTh').asinteger < 0);
    data1.curSth := adoqThreads.FieldByName('slaveTh').asinteger;

    data1.curMngSig := adoqThreads.FieldByName('MngSig').asboolean;
    data1.curAudSig := adoqThreads.FieldByName('AudSig').asboolean;
    data1.curACSfields := adoqThreads.FieldByName('ACSfields').asstring;
    data1.curACSnp := (data1.curACSfields[4] = '1');
    data1.curACSheight := adoqThreads.FieldByName('ACSheight').asfloat;
    data1.curShowImpExpRef := adoqThreads.FieldByName('ShowImpExRef').AsBoolean;

    data1.curTidAsBase := adoqThreads.FieldByName('LCBase').asboolean;
    data1.curThreadIsMAC := adoqThreads.FieldByName('MobileAutoCount').asboolean;
    data1.curHideFillAudit := adoqThreads.FieldByName('HideFillAudit').asboolean;
    data1.curAutoFillBlankCounts := adoqThreads.FieldByName('AutoFillBlindStockBlankCounts').AsBoolean;    
    data1.curNomPriceTariffRO := adoqThreads.FieldByName('NomPriceTariffRO').asboolean;
    data1.curNomPriceOldRO := adoqThreads.FieldByName('NomPriceOldRO').asboolean;
    data1.curEndOnDoW := adoqThreads.FieldByName('EndOnDoW').asinteger;

    data1.curAutoRep := (adoqThreads.FieldByName('AutoRep').asstring = 'Y');
    data1.curNoPurAcc := (adoqThreads.FieldByName('NoPurAcc').asstring = 'Y');
    data1.confirmMobileStockCountImports := (adoqThreads.FieldByName('ConfirmMobileStockImport').asboolean) AND data1.curByLocation;
    data1.curUseMustCountItems := adoqThreads.FieldByName('UseMustCountItems').asboolean;


    // Tid settings for What rcp to use
    if adoqThreads.FieldByName('InstTR').asboolean then
    begin
      if adoqThreads.FieldByName('AskTR').asboolean then
      begin
        data1.curTidRcpHow := 2;   // ask on new stock
        data1.curRTrcp := cbAskRcp.Checked;
      end
      else
      begin
        data1.curTidRcpHow := 1;   // use Real Time (time of sale) recipes
        data1.curRTrcp := True;
      end;
    end
    else
    begin
      data1.curTidRcpHow  := 0;   // use Stock Time Recipe
      data1.curRTrcp := False;
    end;

    if cbCPS.Visible and cbCPS.Checked then
      data1.curBgCP := True
    else
      data1.curBgCP := False;

    with data1 do
    begin
      // get MTh/STh info if needed...
      if curisMth then
      begin
        adoqRun.Close;
        adoqRun.sql.Clear;
        adoqRun.sql.Add('SELECT tid, tname, slaveTh from threads');
        adoqRun.sql.Add('WHERE tid = ' + inttostr(curSTh));
        adoqRun.open;

        curSthName := adoqRun.FieldByName('tname').AsString;

        // now get the last Acc stock of the Subordinate thread...
        adoqRun.Close;
        adoqRun.sql.Clear;
        adoqRun.sql.Add('SELECT a."StockCode", a."EDate", a."ETime"');
        adoqRun.sql.Add('FROM "stocks" a');
        adoqRun.sql.Add('WHERE a."tid" = ' + inttostr(curSTh));
        adoqRun.sql.Add('AND a."SiteCode" = '+IntToStr(TheSiteCode));
        adoqRun.sql.Add('order by a."EDate", a."ETime"');
        adoqRun.open;
        adoqRun.Last;

        lastSThAccCode := adoqRun.FieldByName('stockcode').AsInteger;
        localETime := adoqRun.FieldByName('Etime').asstring;

        if localETime <> '' then
        begin
          if localEtime >= roll then
          begin
            lastSThAccEDT := adoqRun.FieldByName('EDate').AsDateTime + 1 + strtotime(localetime);
          end
          else
          begin
            lastSThAccEDT := adoqRun.FieldByName('EDate').AsDateTime + 2 + strtotime(localetime);
          end;
        end
        else
        begin
          lastSThAccEDT := adoqRun.FieldByName('EDate').AsDateTime + 1 + troll;
        end;

        lastSthAccFBD := adoqRun.FieldByName('EDate').AsDateTime;

        adoqRun.close;


        // check if new stock is possible for the Slave Thread(Rule 5, job 16901)
        if localETime = '' then
        begin
          if LAfbD < (lastSthAccFBD + 1) then
          begin
            ShowMessage('Thread "' + data1.curTidName + '" is a Master Thread.' + #13 +
             'A Master Thread creates, calculates and accepts a ' + data1.SSbig + ' for its ' +
             'Subordinate Thread (Thread "' + data1.curSThName + '").' + #13 + #13 +
             'But a new ' + data1.SSbig + ' cannot be created for the Subordinate Thread at this time' +
             ' because' + #13 + 'its Min. End Date has to be: ' + formatDateTime('ddddd', lastSthAccFBD + 1) + #13 +
             'and Sales for this Business Date have not yet been fully read in.' + #13 +
             '(Last Audited Date/Time is: ' + formatDateTime('ddddd hh:nn', data1.laDT) + ')' + #13 + #13 +
             'A new Master Thread ' + data1.SSbig + ' cannot be done at this time.');
             exit;
          end;
        end
        else
        begin
          if LAfbD <= (lastSthAccFBD + 1) then
          begin
            ShowMessage('Thread "' + data1.curTidName + '" is a Master Thread.' + #13 +
             'A Master Thread creates, calculates and accepts a ' + data1.SSbig + ' for its ' +
             'Subordinate Thread (Thread "' + data1.curSThName + '").' + #13 + #13 +
             'But a new ' + data1.SSbig + ' cannot be created for the Subordinate Thread at this time' +
             ' because' + #13 + 'its Min. End Date has to be: ' + formatDateTime('ddddd', lastSthAccFBD + 1) + #13 +
             'and Sales for this Business Date have not yet been fully read in.' + #13 +
             '(Last Audited Date/Time is: ' + formatDateTime('ddddd hh:nn', data1.laDT) + ')' + #13 + #13 +
             'A new Master Thread ' + data1.SSbig + ' cannot be done at this time.');
             exit;
          end;
        end;
      end  // if.. then..
      else if curisSTh then
      begin
        adoqRun.Close;
        adoqRun.sql.Clear;
        adoqRun.sql.Add('SELECT tid, tname, slaveTh from threads');
        adoqRun.sql.Add('WHERE slaveTh = ' + inttostr(curTid));
        adoqRun.open;

        curMthName := adoqRun.FieldByName('tname').AsString;
        curMth := adoqRun.FieldByName('tid').asinteger;

        adoqRun.close;
      end; //if.. then.. else..


      // get last stock code for this thread from stocks
      adoqRun.Close;
      adoqRun.sql.Clear;
      adoqRun.sql.Add('SELECT Max(a."StockCode") as prevCode');
      adoqRun.sql.Add('FROM "stocks" a');
      adoqRun.sql.Add('WHERE a."tid" = '+ adoqThreads.FieldByName('tid').AsString);
      adoqRun.sql.Add('AND a."SiteCode" = '+IntToStr(TheSiteCode));
      adoqRun.open;

      // set this thread's previous stock code
      PrevStkCode := adoqRun.FieldByName('prevcode').AsInteger;
      adoqRun.close;

      stkCode := prevStkCode + 1;

      adoqRun.Close;
      adoqRun.sql.Clear;
      adoqRun.sql.Add('SELECT byHZ, stkKind ,EDate, ETime');
      adoqRun.sql.Add('FROM stocks');
      adoqRun.sql.Add('WHERE tid = '+ adoqThreads.FieldByName('tid').AsString);
      adoqRun.sql.Add('AND SiteCode = '+IntToStr(TheSiteCode));
      adoqRun.sql.Add('AND StockCode = '+IntToStr(PrevStkCode));
      adoqRun.open;

      // set this thread's previous byHZ state
      PrevStkbyHZ := adoqRun.FieldByName('byHZ').AsBoolean;
      s1 := adoqRun.FieldByName('stkKind').AsString;

      if copy(OKBtn.Caption, 1, 5) = 'Start' then
      begin
        Sdate := adoqRun.FieldByName('EDate').AsDateTime + 1;
        Stime := adoqRun.FieldByName('ETime').AsString;

        // if last stk has an end time then set start time for this stk + 1 min
        // but if Site has just lost its Tills since the last stock then the new stock will no longer
        // have Part Day Sales (as there will be no sales at all!)
        if (data1.noTillsOnSite or (Stime = '')) then
          Stime := ''
        else
          Stime := TimeToStr(StrToTime(Stime) + StrToTime('00:01'));

        // validate end date/times, should be OK by now but check just as well
        if not ((dateEndDoW <= LAfbD) and (dateEndDoW >= data1.Sdate)) then
        begin
          ShowMessage('Thread "' + data1.curTidName + '" is set so its '+ data1.SSplural +' end only on ' +
           formatDateTime('dddd', dateEndDoW) + 's.' + #13 +
           'The pre-selected End Date for this new ' + data1.SSbig + ' is: ' +
              formatDateTime('dddd, '+data1.ukusDateForm2y, dateEndDoW) + '.' + #13 +
           'But the new ' + data1.SSbig + ' Start Date is ' +
              formatDateTime('dddd, '+data1.ukusDateForm2y, Sdate) +
           ' and the Last Audited Full Business Date is: ' +
              formatDateTime('dddd, '+data1.ukusDateForm2y, LAfBD) + '.' + #13 + #13 +
           'The End Date of the ' + data1.SSbig +
           ' has to be bigger or equal to the Start Date AND smaller or equal to the LAst Audited Business Date.');
          log.Event('Cannot start New Stock for Set DoW. Set ED = ' +
            formatDateTime('dddd, '+data1.ukusDateForm2y, dateEndDoW) + ', SD: ' +
            formatDateTime('dddd, '+data1.ukusDateForm2y, Sdate) + ', LAfBD: ' +
            formatDateTime('dddd, '+data1.ukusDateForm2y, LAfBD));
          exit;
        end;
      end;

      adoqRun.close;

      // is this stock different from the last stock as far as byHZ is concerned? (this also
      // means that a new HZ is added or an old one taken away).
      // if YES make this stock a new Begin for Cumulative Stock Period...
      // if already designated as begCPS then don't bother
      if not data1.curBgCP then
      begin
        if curByHZ <> prevStkByHZ then
        begin // no more checks needed, hit it...
          curBgCP := True; // set this even if current Thread is not set to use CPs as it may be set later...
        end
        else
        begin
          // check prior HZs were the same as current ones (existence check only...)
          // ONE QUERY CHECK method: outer join the stkmisc HZID for old stock and the HZID from stkHZs
          // where Active. No record should have a NULL in either of the fields for past and present to
          // be compatible. If the 2 hzid's are actually summed, any null will give a null sum.
          // count the NULLs in the result and if you get more than 0 then that's it...
          if curByHz then
          begin
            adoqRun.close;
            adoqRun.sql.Clear;
            adoqRun.sql.Add('select count(*) as thecount from (');
            adoqRun.sql.Add('  SELECT (h.hzid + m.hzid) as thesum');
            adoqRun.sql.Add('  FROM  stkHZs H FULL OUTER JOIN');
            adoqRun.sql.Add('    (select HzID from Stkmisc');
            adoqRun.sql.Add('      WHERE tid = ' + adoqThreads.FieldByName('tid').AsString);
            adoqRun.sql.Add('      AND stockcode = '+IntToStr(PrevStkCode));
            adoqRun.sql.Add('      and hzid > 0) M ON H.hzID = M.HzID');
            adoqRun.sql.Add('  where H.Active = 1');
            adoqRun.sql.Add(') a where a.thesum is null');
            adoqRun.open;

            if adoqRun.FieldByName('thecount').asinteger > 0 then
            begin
              curBgCP := True; // set this even if current Thread is not set to use CPs as it may be set later...
            end;
            adoqRun.close;
          end;
        end;
      end;

      if curThreadIsMAC then
      begin
        if s1 = 'MAC' then
          s1 := 'This Thread is enabled for MAC ' + ssplural + ' so should only be used in unattended mode.'
        else
          s1 := 'This Thread is enabled for MAC ' + ssplural + ' so should only be used in unattended mode.'+
                   #13+#10+'(though the last ' + ssBig + ' done on this Thread was NOT a MAC ' + ssBig + ')';

        if MessageDlg(s1 + #13+#10+''+#13+#10+'Are you sure you want to create a New ' +
                       ssBig + ' in this Thread?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
          exit;
      end;
    end; // with data1

    ModalResult := mrOK;
  end;
end;

// ensure tables & queries are closed.
procedure TfStkDivdlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   data1.wwtRun.Close;
   data1.adoqRun.Close;
end;

procedure TfStkDivdlg.CancelBtnClick(Sender: TObject);
begin
	modalresult := mrCancel;
end;

procedure TfStkDivdlg.adoqThStockAfterScroll(DataSet: TDataSet);
begin
  cbCPS.Visible := False;
  panel5.Visible := False;
  panel4.Visible := False;
  cbAskRcp.Visible := False;
  cbAskRcp.Checked := True;
  label19.Visible := False;
  if adoqThStock.RecordCount = 0 then
  begin
    if adoqThreads.RecordCount = 0 then
    begin
      okbtn.Enabled := False;
      okbtn.Caption := 'No Thread!';
      panel4.Visible := False;
    end
    else
    begin
      okbtn.Enabled := False;
      okbtn.Caption := 'OK';
      panel4.Visible := True;
      label15.Caption := 'Not initialised (no ' + data1.SSbig + ' Counts available)';
      label15.Color := clRed;
      label17.Caption := 'You need to initialise this thread. ' + #13 +
        'You need to provide initial ' + data1.SSbig + ' Counts and Costs for the ' + data1.SSlow + ' items.';
      bitBtn1.Caption := 'Initialise Thread';

      if (adoqThreads.FieldByName('doCPS').AsString = 'Y') and
        (adoqThreads.FieldByName('CPSmode').AsString = 'N') then
        cbCPS.Visible := True;
      if adoqThreads.FieldByName('InstTR').asboolean and
           adoqThreads.FieldByName('AskTR').asboolean then
        cbAskRcp.Visible := True;
    end;
    self.ClientHeight := 536;
  end
  else
  begin
    intEndDoW := adoqThreads.FieldByName('EndOnDoW').AsInteger;

    // check to see if any current stocks exist for selection
    with data1, data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT a."tid" FROM "curstock" a');
      sql.Add('WHERE a."tid" = '+ inttostr(adoqThStock.FieldByName('tid').asinteger));
      open;

      if (Recordcount = 0) then
      begin // no current stock, continue checking...

        if intEndDoW = 0 then   // is this a Thread with a fixed DoW End Date?
        begin  // -------------------- ---------------- -------------- NORMAL Thread...
          self.ClientHeight := 536;
        okbtn.Enabled := True;
        okbtn.Caption := 'OK';

        if adoqThStock.RecordCount = 1 then
        begin
          panel4.Visible := True;
          label15.Caption := 'Initialised OK (Start Date/Time: '+
            datetostr(adoqThStock.FieldByName('EDate').asdatetime + 1) + ' ' +
            adoqThStock.FieldByName('ETime').asstring +')';
          label15.Color := clGreen;
          label17.Caption := 'You can re-initialise this thread. ' + #13 +
            'You can change initial ' + data1.SSbig + ' Counts and Costs or the Start Date/Time.';
          bitBtn1.Caption := 'Re-Initialise Thread';
        end
        else
        begin
          panel4.Visible := False;
        end;

        // check if new stock is possible (Rule 5, job 16901)
        if adoqThStock.FieldByName('ETime').asstring = '' then
        begin
          if LAfbD >= (adoqThStock.FieldByName('EDate').asdatetime + 1) then
          begin
            okbtn.Enabled := True;
            okbtn.Caption := 'OK';
          end
          else
          begin
            okbtn.Enabled := False;
            okbtn.Caption := 'No Audit';
          end;
        end
        else
        begin
          if LAfbD > (adoqThStock.FieldByName('EDate').asdatetime + 1) then
          begin
            okbtn.Enabled := True;
            okbtn.Caption := 'OK';
          end
          else
          begin
            okbtn.Enabled := False;
            okbtn.Caption := 'No Audit';
          end;
        end;
        end
        else
        begin  // ------  ------  ------  ------  ------  ------ Set DoW for End Date Thread...
          self.ClientHeight := 574;

          okbtn.Enabled := True;
          okbtn.Caption := 'OK';

          // get the last date with the DoW as set for the Thread...
          dateEndDoW := data1.GetDateForStockEndOnDoW(intEndDoW);

          label19.Caption :=  'End Date of this '+ data1.SSbig + ' is auto-set as last ' +
            formatDateTime('dddd, '+ data1.ukusDateForm2y, dateEndDoW)+'.'+#13+ data1.SSbig +' Start Date: '+
            formatDateTime('dddd, '+ data1.ukusDateForm2y, (adoqThStock.FieldByName('EDate').asdatetime + 1)) +
            ', Period: '+inttostr(trunc(dateEndDoW - adoqThStock.FieldByName('EDate').asdatetime))+' days.';
          label19.Visible := True;
          label19.Color := clGreen;

          if adoqThStock.RecordCount = 1 then
          begin
            panel4.Visible := True;
            label15.Caption := 'Initialised OK (Start Date/Time: '+
              datetostr(adoqThStock.FieldByName('EDate').asdatetime + 1) + ' ' +
              adoqThStock.FieldByName('ETime').asstring +')';
            label15.Color := clGreen;
            label17.Caption := 'You can re-initialise this thread. ' + #13 +
              'You can change initial ' + data1.SSbig + ' Counts and Costs or the Start Date/Time.';
            bitBtn1.Caption := 'Re-Initialise Thread';
          end
          else
          begin
            panel4.Visible := False;
          end;
          
          // is the End Date of the last stock the same or later than the auto-set of the next?
          // i.e. you need to wait another week...
          if adoqThStock.FieldByName('EDate').asdatetime >= dateEndDoW then
          begin // cannot do stock, tell user and disable the OK button...
            label19.Color := clRed;
            Label18.Caption :=
              'This Thread has fixed weekly '+data1.ssPlural+' ending on ' + formatDateTime('dddd', dateEndDoW) +
                's.' +
                ' This week already has a ' + data1.SSbig + ' (End Date: ' +
                formatDateTime('dddd, '+ data1.ukusDateForm2y, (adoqThStock.FieldByName('EDate').asdatetime)) +
              ')' + #13#10#13#10 + 'A new weekly (' +
              formatDateTime('dddd', dateEndDoW-1)+' to '+ formatDateTime('dddd', dateEndDoW)+') '+ data1.SSbig +
              ' can only be done on ' +
              formatDateTime('dddd, ' + data1.ukusDateForm2y, dateEndDoW + 8) + ' at the earliest.';

            panel5.Visible := TRUE;
            okbtn.Enabled := False;
            okbtn.Caption := 'OK';
          end
          else
          begin // continue to checking for Audit Read up to date...
            // check if new stock is possible
              if LAfbD >= dateEndDoW then
              begin
                okbtn.Enabled := True;
                okbtn.Caption := 'Start ' + data1.SSbig;
              end
              else
              begin
                okbtn.Enabled := False;
                okbtn.Caption := 'No Audit';
              end;


//            if adoqThStock.FieldByName('ETime').asstring = '' then
//            begin
//              if LAfbD >= dateEndDoW then
//              begin
//                okbtn.Enabled := True;
//                okbtn.Caption := 'Start ' + data1.SSbig;
//              end
//              else
//              begin
//                okbtn.Enabled := False;
//                okbtn.Caption := 'No Audit';
//              end;
//            end
//            else
//            begin
//              if LAfbD > dateEndDoW then
//              begin
//                okbtn.Enabled := True;
//                okbtn.Caption := 'Start ' + data1.SSbig;
//              end
//              else
//              begin
//                okbtn.Enabled := False;
//                okbtn.Caption := 'No Audit';
//              end;
//            end;
          end;
        end; // ---- END of "is this a Thread with a fixed DoW End Date?"


        if (adoqThreads.FieldByName('doCPS').AsString = 'Y') and
          (adoqThreads.FieldByName('CPSmode').AsString = 'N') then
          cbCPS.Visible := True;

        if adoqThreads.FieldByName('InstTR').asboolean and
           adoqThreads.FieldByName('AskTR').asboolean then
          cbAskRcp.Visible := True;

        if adoqThStock.RecordCount > 1 then
          cbAskRcp.Checked := adoqThStock.FieldByName('RTRcp').AsBoolean;
      end
      else
      begin
        // there is a current stock, no new stock possible...
        if intEndDoW = 0 then
        begin  // -------------------- ---------------- -------------- NORMAL Thread...
          self.ClientHeight := 536;
          Label18.Caption := 'There is already a Current ' + data1.SSbig +
           ' for this Thread!'#13#10#13#10'A new ' + data1.SSbig + '' +
           ' can be done only after the Current ' + data1.SSbig + ' is Accepted or Cancelled.';
        end
        else
        begin
          self.ClientHeight := 574;
          label19.Visible := True;

          dateEndDoW := data1.GetDateForStockEndOnDoW(intEndDoW);

          label19.Caption :=  'End Date of this '+ data1.SSbig + ' is auto-set as last ' +
            formatDateTime('dddd, '+ data1.ukusDateForm2y, dateEndDoW)+'.'+#13+ data1.SSbig +' Start Date: '+
            formatDateTime('dddd, '+ data1.ukusDateForm2y, (adoqThStock.FieldByName('EDate').asdatetime + 1)) +
            ', Period: '+inttostr(trunc(dateEndDoW - adoqThStock.FieldByName('EDate').asdatetime))+' days.';

          Label18.Caption := 'There is already a Current ' + data1.SSbig +
            ' for this Thread!'#13#10#13#10'A new ' + data1.SSbig + '' +
            ' can be done only after the Current ' + data1.SSbig + ' is Accepted or Cancelled.';
        end;
        panel5.Visible := True;
        okbtn.Enabled := False;
        okbtn.Caption := 'Current';
      end;
      close;
    end; // with data1.wwqRun
  end;
  SetSecurity;
end;

procedure TfStkDivdlg.BitBtn1Click(Sender: TObject);
var
  curTid : integer;
begin
    data1.TheDiv := adoqThreads.FieldByName('division').Asstring;
    curTid := adoqThreads.FieldByName('tid').asinteger;
    data1.CurTid := curTid;
    data1.curDozForm := (adoqThreads.FieldByName('dozForm').asstring = 'Y');
    data1.curGallForm := (adoqThreads.FieldByName('gallform').asstring = 'Y');

    fStkUtil := TfStkUtil.Create(self);

    fStkUtil.isMTh := False;
    fStkUtil.ThName := adoqThreads.FieldByName('tname').Asstring;

    if adoqThreads.FieldByName('slaveTh').asinteger > 0 then
    begin
      fStkUtil.isMTh := True;
      fStkUtil.slaveTh := adoqThreads.FieldByName('slaveTh').asinteger;
    end;

    if fStkUtil.ShowModal = mrOK then
    begin
      // set new start date /start time
      adoqThStock.Requery;
      adoqThStock.Locate('tid', curTid, []);
      fStkUtil.free;
      exit;
    end
    else
    begin
      // cancel
      fStkUtil.free;
      exit;
    end;
end;

procedure TfStkDivdlg.FormCreate(Sender: TObject);
var
  lrdtHH, lrdtTill, LastAuditFullBDateHH, LastAuditFullBDateTill, lrdtAzTab, LastAuditFullBDateAzTab : tdatetime;
  HHlist, AzTablist, s1, s2: string;
  i : integer;
begin
  with dmADO.adoqRun do
  begin
    // for Greene King ONLY, allow user to ignore late read HHs
    data1.logIgnoreLateHHs := '';

    // is this a GK site?
    Close;
    sql.Clear;
    sql.Add('SELECT  *');
    sql.Add('FROM ac_Company');
    sql.Add('WHERE [Name] = ''Greene King''');
    SQL.Add('and [Deleted] = 0');
    open;

    if recordcount > 0 then
    begin
      // are there any HHs?
      Close;
      sql.Clear;
      sql.Add('SELECT  a.[TerminalID], t.POSCode, a.LRDT, a.ErrorOnLastRead, a.ErrorReason, t.[Name]');
      sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
      sql.Add('WHERE t.HardwareType = h.HardwareType');
      SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
      sql.Add('and t.[SiteCode] = ' + inttostr(data1.TheSiteCode));
      sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
      sql.Add('and t.POSCode = c.[POS Code]');
      sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
      sql.Add('and h.HardwareName = ''HandHeld''');
      sql.Add('ORDER BY a.LRDT');
      open;

      if recordcount > 0 then
      begin
        lrdtHH := fieldByName('LRDT').AsDateTime;

        if formatDateTime('hh:nn', lrdtHH) >= data1.roll then
          LastAuditFullBDateHH := DateOf(lrdtHH) - 1
        else
          LastAuditFullBDateHH := DateOf(lrdtHH) - 2;

        with dmADO.adoqRun2 do
        begin
          Close;        // get lrdt for tills only
          sql.Clear;
          sql.Add('SELECT t.POSCode, a.LRDT, a.AuditReadInterval');
          sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
          sql.Add('WHERE t.HardwareType = h.HardwareType');
          SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
          sql.Add('and t.[SiteCode] = ' + inttostr(data1.TheSiteCode));
          sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
          sql.Add('and t.POSCode = c.[POS Code]');
          sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
          sql.Add('and h.HardwareName <> ''HandHeld''');
          sql.Add('ORDER BY a.LRDT');
          open;

          lrdtTill := fieldByName('LRDT').AsDateTime;

          if formatDateTime('hh:nn', lrdtTill) >= data1.roll then
            LastAuditFullBDateTill := DateOf(lrdtTill) - 1
          else
            LastAuditFullBDateTill := DateOf(lrdtTill) - 2;
          close;
        end;

        // is the earliest HH lrdt behind by more than one business day?
        if LastAuditFullBDateHH < LastAuditFullBDateTill then
        begin
          // prepare the display string that shows the HHs that are late (max = 3)
          // we already have 1 by being in this part of code...
          i := 1;
          HHlist:= '     Hand Held Name: ' + fieldbyname('Name').AsString +
            ', Last Read: ' + fieldByName('LRDT').AsString;
          if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
            HHlist := HHlist + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

          s1 := 'Term ID: ' + fieldbyname('TerminalID').AsString +  ', POS Code: ' + fieldbyname('POSCode').AsString + ', Name: ' + fieldbyname('Name').AsString +
            ', Last Read: ' + fieldByName('LRDT').AsString;
          if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
            s1 := s1 + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

          next;
          while not eof do
          begin
            // check if this records (HHs) LRDT is also behind the Till's LRDT by 1 Business Date; if yest then add it to the string...
            lrdtHH := fieldByName('LRDT').AsDateTime;

            if formatDateTime('hh:nn', lrdtHH) >= data1.roll then
              LastAuditFullBDateHH := DateOf(lrdtHH) - 1
            else
              LastAuditFullBDateHH := DateOf(lrdtHH) - 2;

            if LastAuditFullBDateHH < LastAuditFullBDateTill then
            begin
              inc(i);

              if i <= 4 then
              begin
                HHlist:= HHlist + #13 + '     Hand Held Name: ' + fieldbyname('Name').AsString +
                  ', Last Read: ' + fieldByName('LRDT').AsString;
                if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
                  HHlist := HHlist + ', Read Error: ' + fieldbyname('ErrorReason').AsString;
              end;

              s1 := s1 + #13 + 'Term ID: ' + fieldbyname('TerminalID').AsString +  ', POS Code: ' + fieldbyname('POSCode').AsString + ', Name: ' + fieldbyname('Name').AsString +
                ', Last Read: ' + fieldByName('LRDT').AsString;
              if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
                s1 := s1 + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

              next;
            end
            else
            begin
              break; // this HH is "in line" with the Tills, get out of the loop...
            end;
          end;

          if i = 1 then
            HHlist := 'There is 1 Hand Held Terminal that is not read up to date: ' + #13 + HHlist
          else
            HHlist := 'There are ' + inttostr(i) + ' Hand Held Terminals that are not read up to date: ' + #13 + HHlist;

          if MessageDlg(HHlist +#13+#10+ #13+#10+
             'Do you want to ignore any late Hand Helds Audit Reads and proceed with the Stock?'+#13+#10,mtWarning, [mbYes,mbNo], 0) = mrYes then
          begin
            data1.logIgnoreLateHHs := 'Hand Held(s) not read up to date: ' + #13 + s1 + #13 + '"Last Audit Date/Time" for this Stock is: ' +
              formatDateTime(data1.ukusDateForm2y+' hh:nn:ss', lrdtTill) +
              ' (from terminals only) instead of: ' + formatDateTime(data1.ukusDateForm2y+' hh:nn:ss', data1.LADT);

            data1.LADT := lrdtTill;
            data1.LAD := DateOf(data1.LADT);
            data1.LAT := formatDateTime('hh:nn', data1.LADT);

            log.event('User chose to ignore late HHs, new LADT for this Stock only is: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', data1.LADT));

          end
          else
          begin
            log.event('User chose NOT to ignore late HHs, LADT for Tills only is: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', lrdtTill));
          end;
        end; // HHs make the Stock End Date late by at least 1 Business Day
      end; // we have HHs

    end; // ... if this is a Greene King site...
    close;


    // check if there are any late AzTabs and offer user the choice to disregard them when setting the End Date
    data1.logIgnoreLateAzTabs := '';

    // are there any AzTabs?
    Close;
    sql.Clear;
    sql.Add('SELECT  a.[TerminalID], t.POSCode, a.LRDT, a.ErrorOnLastRead, a.ErrorReason, t.[Name]');
    sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
    sql.Add('WHERE t.HardwareType = h.HardwareType');
    SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
    sql.Add('and t.[SiteCode] = ' + inttostr(data1.TheSiteCode));
    sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
    sql.Add('and t.POSCode = c.[POS Code]');
    sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
    sql.Add('and h.HardwareName = ''AzTab''');
    sql.Add('ORDER BY a.LRDT');
    open;

    if recordcount > 0 then
    begin
      lrdtAzTab := fieldByName('LRDT').AsDateTime;

      if formatDateTime('hh:nn', lrdtAzTab) >= data1.roll then
        LastAuditFullBDateAzTab := DateOf(lrdtAzTab) - 1
      else
        LastAuditFullBDateAzTab := DateOf(lrdtAzTab) - 2;

      with dmADO.adoqRun2 do
      begin
        Close;        // get lrdt for non-AzTab tills only
        sql.Clear;
        sql.Add('SELECT t.POSCode, a.LRDT, a.AuditReadInterval');
        sql.Add('FROM AztecPOS a, TerminalHardware h, Config c, ThemeEPOSDevice t');
        sql.Add('WHERE t.HardwareType = h.HardwareType');
        SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
        sql.Add('and t.[SiteCode] = ' + inttostr(data1.TheSiteCode));
        sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
        sql.Add('and t.POSCode = c.[POS Code]');
        sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
        sql.Add('and h.HardwareName <> ''AzTab''');
        sql.Add('ORDER BY a.LRDT');
        open;

        lrdtTill := fieldByName('LRDT').AsDateTime;

        if formatDateTime('hh:nn', lrdtTill) >= data1.roll then
          LastAuditFullBDateTill := DateOf(lrdtTill) - 1
        else
          LastAuditFullBDateTill := DateOf(lrdtTill) - 2;
        close;
      end;

      // is the earliest AzTab lrdt behind by more than one business day?
      if LastAuditFullBDateAzTab < LastAuditFullBDateTill then
      begin
        // prepare the display string that shows the AzTabs that are late (max = 3)
        // we already have 1 by being in this part of code...
        i := 1;
        AzTablist:= '     AzTab Name: ' + fieldbyname('Name').AsString +
          ', Last Read: ' + fieldByName('LRDT').AsString;
        if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
          AzTablist := AzTablist + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

        s1 := 'Term ID: ' + fieldbyname('TerminalID').AsString +  ', POS Code: ' + fieldbyname('POSCode').AsString +
          ', Name: ' + fieldbyname('Name').AsString + ', Last Read: ' + fieldByName('LRDT').AsString;
        if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
          s1 := s1 + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

        s2 := fieldbyname('TerminalID').AsString + ', ' + fieldbyname('Name').AsString;

        next;
        while not eof do
        begin
          // check if this records LRDT is also behind the Till's LRDT by 1 Business Date; if yes then add it to the string...
          lrdtAzTab := fieldByName('LRDT').AsDateTime;

          if formatDateTime('hh:nn', lrdtAzTab) >= data1.roll then
            LastAuditFullBDateAzTab := DateOf(lrdtAzTab) - 1
          else
            LastAuditFullBDateAzTab := DateOf(lrdtAzTab) - 2;

          if LastAuditFullBDateAzTab < LastAuditFullBDateTill then
          begin
            inc(i);

            if i <= 4 then
            begin
              AzTablist:= AzTablist + #13 + '     AzTab Name: ' + fieldbyname('Name').AsString +
                ', Last Read: ' + fieldByName('LRDT').AsString;
              if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
                AzTablist := AzTablist + ', Read Error: ' + fieldbyname('ErrorReason').AsString;
              s2 := s2 + '; ' + fieldbyname('TerminalID').AsString + ', ' + fieldbyname('Name').AsString;
            end;

            if i = 5 then // indicate that there are more than 4 late AzTabs by using ...
            begin
              AzTablist:= AzTablist + #13 + '     ...        ...        ...        ...';
              s2 := s2 + '; ...';
            end;

            s1 := s1 + #13 + 'Term ID: ' + fieldbyname('TerminalID').AsString +  ', POS Code: ' + fieldbyname('POSCode').AsString + ', Name: ' + fieldbyname('Name').AsString +
              ', Last Read: ' + fieldByName('LRDT').AsString;
            if fieldbyname('ErrorOnLastRead').AsBoolean and (fieldbyname('ErrorReason').AsString <> '') then
              s1 := s1 + ', Read Error: ' + fieldbyname('ErrorReason').AsString;

            next;
          end
          else
          begin
            break; // this AzTab is "in line" with the Tills, get out of the loop...
          end;
        end;

        if i = 1 then
          AzTablist := 'There is 1 AzTab Terminal that is not read up to date: ' + #13 + AzTablist
        else
          AzTablist := 'There are ' + inttostr(i) + ' AzTab Terminals that are not read up to date: ' + #13 + AzTablist;

        if MessageDlg(AzTablist +#13+#10+ #13+#10+
           'Do you want to ignore any late AzTabs Audit Reads and proceed with the '+ data1.SSbig +
           '?'+ #13+#10+ '("Yes" sets the Valid Last Audited DateTime as: ' +
           formatDateTime(theDateFormat + ' hh:nn:ss', lrdtTill) + ' instead of ' +
           formatDateTime(theDateFormat + ' hh:nn:ss', data1.LADT) + ')',mtWarning, [mbYes,mbNo], 0) = mrYes then
        begin
          data1.logIgnoreLateAzTabs := 'AzTab(s) not read up to date: ' + #13 + s1 + #13 + '"Last Audit Date/Time" for this Stock is: ' +
            formatDateTime(theDateFormat + ' hh:nn:ss', lrdtTill) +
            ' (from terminals only) instead of: ' + formatDateTime(theDateFormat + ' hh:nn:ss', data1.LADT);

          data1.LADT := lrdtTill;
          data1.LAD := DateOf(data1.LADT);
          data1.LAT := formatDateTime('hh:nn', data1.LADT);

          log.event('User chose to ignore late AzTabs (' + s2 + '), new LADT for this Stock only is: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', data1.LADT));
        end
        else
        begin
          log.event('User chose NOT to ignore late AzTabs, LADT for Tills only is: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', lrdtTill));
        end;
      end; // AzTabs make the Stock End Date late by at least 1 Business Day
    end; // we have AzTabs

    close;
  end;



  // set LAfbD (Last AuditED Full Business Day)
  if data1.LAT >= data1.roll then
  begin
    LAfbD := data1.LAD - 1;
  end
  else
  begin
    LAfbD := data1.LAD - 2;
  end;

  self.ClientHeight := 536;
end;

procedure TfStkDivdlg.SetSecurity;
var
  curTid : integer;
begin
  CurTid := adoqThreads.FieldByName('tid').AsInteger;

  bitBtn1.Visible := data1.UserAllowed(curTid, 6);
  OKbtn.Visible := data1.UserAllowed(curTid, 7);
end; // procedure..


end.
