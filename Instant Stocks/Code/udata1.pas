unit udata1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Wwquery, ppComm, ppCache, ppDB, ppDBBDE, Db, Wwdatsrc, Wwtable,
  ppRelatv, ppDBPipe, Variants, ADODB, Printers, ppProd, ppClass, ppReport, DateUtils,
  ImgList, ppBands, ppStrtch, ppSubRpt, ppCtrls, ppVar, ppPrnabl;


type
  Tdata1 = class(TDataModule)
    SiteDS: TwwDataSource;
    AreaDS: TwwDataSource;
    sitePipe: TppBDEPipeline;
    areaPipe: TppBDEPipeline;
    wwtRun: TADOTable;
    adoqRun: TADOQuery;
    SiteTab: TADOQuery;
    Areatab: TADOQuery;
    adoqSecure: TADOQuery;
    hzTabsImgList: TImageList;
    locTabsImgList: TImageList;
    procedure data1Create(Sender: TObject);
    procedure initGlobals;
    procedure initCurr(theTid, theCode, theSite : integer; RepOnly, Curr: boolean);

    procedure UpdateCurrStage(cstage: integer);
    procedure GenerateCurrentStockAuditFigures(load, tryImport: boolean);
    procedure GenerateCurrentStockAuditLocationFigures(load, tryImport: boolean);
    procedure PushStkMain;
    procedure PushStkSold;
    procedure PushPrepared;
    function FinishStk(newStk: boolean) : boolean;
    function isDozen(theUnit: string) : boolean;
    procedure DataModuleDestroy(Sender: TObject);
    procedure SetPrinterSize(prs : string);
    function UserAllowed(theTid, thePermID: integer): boolean;

    function isGallon(theUnit: string) : boolean;

    // function to do with Dozens, Gallons, normal floats...
    function fmtRepQtyText(theUnit, Text : string) : string;
    function setGridMask(theUnit, curMask : string) : string;
    function dozGallFloatToStr(theUnit : string; theValue : real) : string;
    function dozGallStrToFloat(theUnit, theText : string) : real;

    procedure killStock(TIDtoKill, StkToKill: integer);
    procedure doStkEntity;

    function CheckForOutstandingDeliveryNotes ( StartDate : TDateTime = 0; EndDate : TDateTime = 0 ): Boolean;

    function CheckHZsValid (temp: boolean): boolean;
    function CheckLocationsValid: boolean;

    function CheckSiteUsesHZs: boolean;
    function CheckSiteUsesLocations: boolean;

  private
    dt1 : Tdatetime;
    theDoz : TStringList;
    { Private declarations }
  public
    { Public declarations }
//////////////////////////// GLOBALS //////////////////////////////////////////
    ERRSTR1: String;
    theStage, repSite,
    TheSiteCode, CurTid, StkCode, PrevStkCode,
    curMth, curSTh, lastSThAccCode, firstSThAccCode, curDivIx : integer;         // site code, new stk code, last div/stk code

    troll, Sdate, SDT, Edate, EDT, AccDate, LAD, LADT,
    lastSthAccEDT, lastSthAccFBD         : TDateTime; // rollover in DT fmt, stk start/end dates

    roll, repHdr,                                    // rollover time, current user
    Stime, Etime, UserName, LAT, TheDiv, TheMgr,                         // stk start/end times and...
    TheStkTkr, TheStkType, StkTypeLong, TheSiteName,
    curTidName, curMthName, CurSThName, curStkLastCalc   : String; // ... other misc stk details

    NeedBeg, NeedEnd, Cancel, debugF, curNomPrice, curFillClose, curEditTak,
    curTillVarTak, curdozForm, curGallForm, curIsGP, curCPS, curCPNew,
    curCPSet, curBgCP, curAutoRep,curNoPurAcc,
    prevStkByHZ, curWasteAdj, curIsMTh, curIsSTh, ssDebug, curMngSig,curAudSig,
    curRTrcp, curTidAsBase, curDivAsBase, curShowImpExpRef,
    curThreadIsMAC, curStkIsMAC, curHideFillAudit, curNomPriceTariffRO,
    curNomPriceOldRO, curAutoFillBlankCounts, curUseMustCountItems : boolean;


    autoSlaveStk : boolean;
    UKUSmode, SSbig, SSsmall, SSplural, SSlow, SS6, SS5, ssTill, ukusDateForm2y : string;

    dozGalChar : char;

    curACSnp, oldMadeStock : boolean;
    curTidRcpHow, purHZid, curEndOnDoW : integer;  // curEndDoW: 0- OFF, 1-Mon, 2-Tue, ..., 7-Sun
    curACSheight : single;

    pcWAtoMisc, lcZeroLG, isDeactivatedThread, noCountSheetDlg : boolean;
    logDetsCurStock, logIgnoreLateHHs, logIgnoreLateAzTabs : string;

    noTillsOnSite : boolean;

    // a Site can have --both-- Valid Locations and Valid HZs set up
    // a Site can be set up to use either Locations --OR-- HZs --OR-- none.
    siteHasValidHZs, siteUsesHZs, curByHZ, curStkByHZ : boolean;
    siteHasValidLocations, siteUsesLocations, curByLocation, curStkByLocation,
    siteLCbyLocation, confirmMobileStockCountImports: boolean;

    blindRun : boolean;

    repPaperName, curACSfields : string; // curACSfields: OpStk,PurStk,PurCost,NomPrice,TheoClose
    procedure HoldRepQuery (repHZidStr: string; var theQ: TADOQuery);
    function SPQuery(repHZidStr: string): integer;
    procedure LGRepQuery (repHZidStr: string; var theQ: TADOQuery);
    function CheckSPsLocks(checkWhat: string = 'A'): string;
    function HandHeldImportsExist: Boolean;
    function MobileStockImportsExist: Boolean;
    function IncludePrepItemsInAudit: Boolean;
    function GetDateForStockEndOnDoW(theDoW: smallint): tdatetime;
    procedure SetCurrentDivisionId(divisionStr: string);
    function GetNegativeTheoCloseProducts: TStringList;
  end;

const
  MAX_HOLDING_ZONES = 99; // Max number of Active Holding Zones for one Site // 9
  INCLUDE_PREP_ITEMS_IN_AUDIT = 'IncludePrepItemsInAudit';

var
  data1: Tdata1;

implementation

uses uwait, uStkDivdlg, uStkdatesdlg, uStkMisc, uADO, uImportStock, ulog,
  uDataProc, dRunSP, uGlobals;

{$R *.DFM}

procedure Tdata1.data1Create(Sender: TObject);
begin
  theDoz := TStringList.Create;
  theDoz.CaseSensitive := False;

  initGlobals;
  debugF := True;
end;

//////////////////////////////////  MH  ///////////////////////////////////////
//
//  Initialises all global variables.
//
///////////////////////////////////////////////////////////////////////////////
procedure Tdata1.initGlobals;
var
  s1 : string;
begin
  with adoqRun do
  begin
    // get the dozens
        // To recognize dozens:
        // Use the purchase unit. Convert to upper case.
        // If the string = 'DOZEN' is found anywhere in the name AND the "Base Units" field
        // in table "Units" for that unit is 12, then we have a Dozen to format.
    theDoz.Clear;

    close;
    sql.Clear;
    sql.Add('select distinct [unit name] from [units]');
    sql.Add('where Upper([unit name]) like ''%DOZEN%''');
    sql.Add('and [base units] = 12');
    open;

    if recordcount > 0 then
    begin
      while not eof do
      begin
        theDoz.Append(uppercase(FieldByName('unit name').asstring));
        next;
      end;
    end;

    // Get GenerVar variables
    close;
    SQL.Clear;
    SQL.Add('select * from Genervar');
    Open;

    // is this a DEBUG run?
    if locate('varname', 'ssDebug', []) then
    begin
      ssDebug := (FieldByName('varstring').asstring[1] = 'Z');
    end
    else
    begin
      ssDebug := False;
    end;

    Close;
    SQL.Clear;
    SQL.Add('select [StringValue]');
    SQL.Add('from [dbo].[GlobalConfiguration]');
    SQL.Add('where [KeyName] = ''StocksQuantitySeparator''');
    Open;

    if RecordCount = 0 then
      dozGalChar := '/'
    else
      dozGalChar := FieldByName('StringValue').AsString[1];

    // get the report header
    Close;
    sql.Clear;
    sql.Add('select a."stock_type", a."Gross Profit Reported" from "pconfigs" a');
    open;

    if FieldByName('stock_type').asstring = '' then
      RepHdr := 'Sub-Category'
    else
      RepHdr := FieldByName('stock_type').asstring;

    Close;

    // get the rollover time
    close;
    sql.Clear;
    sql.Add('Select a."rollover time" From "timeout" a');
    Open;
    roll := FieldByName('rollover time').asstring;
    troll := strtotime(roll);

    // get the site code, name, manager...
    if isSite then
    begin
      close;
      sql.Clear;
      sql.Add('Select a."Site Code",a."Site Name", a."Site Manager"');
      sql.Add('From "Site" a');
      sql.add('where (a."deleted" is null) or (a."deleted" <> ''Y'')');
      Open;
      First;
      TheSiteCode := FieldByName('site code').AsInteger;
      TheSiteName := FieldByName('site name').AsString;
      TheMgr      := FieldByName('Site Manager').AsString;
      Close;


      // check if there are any tills on this site...
      close;
      sql.Clear;
      sql.Add('select [TerminalID] from AztecPOS where isPOS = 1');
      open;
      noTillsOnSite := (recordcount = 0);
      close;

      if noTillsOnSite then
      begin
        LADT := Date + troll;  // roll-over time TODAY
        LAD := DateOf(LADT);
        LAT := formatDateTime('hh:nn', LADT);

        log.event('ROLL: ' + roll + ', LADT: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', LADT) +
          ', NO TILLS ON SITE <<<<<<<<<<<<<<<<<<<<<<<<<');


        dmRunSP := TdmRunSP.Create(self);
        with dmRunSP do
        begin
          spConn.Open;
          with adoqRunSP do
          begin
            close;
            sql.Clear;
            sql.Add('exec stkSP_make121Rcp');

            try
              execSQL;
              log.event('SP EXECUTED - stkSP_make121Rcp (Site has no terminals)');
            except
              on E:Exception do
              begin
                log.event('SP ERROR - stkSP_make121Rcp' + E.Message);
                showMessage('ERROR updating one-to-one Recipes!' + #13 +
                  'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
                exit;
              end;
            end;
          end;
          spConn.Close;
        end;
        dmRunSP.Free;
      end
      else
      begin
        // LAST AUDITED DATE/TIME  : earliest NOT NULL [LRDT] where till not Deleted = Y in [Config]
        close;
        sql.Clear;
        sql.Add('SELECT t.POSCode, a.LRDT');
        sql.Add('FROM AztecPOS a, Config c, ThemeEPOSDevice t');
        sql.Add('WHERE t.POSCode = c.[POS Code]');
        SQL.Add('and t.EPOSDeviceID = a.[TerminalID]');
        sql.Add('and c.[Site Code] = ' + inttostr(thesitecode));
        sql.Add('and a.LRDT is NOT NULL and a.isPOS = 1');
        sql.Add('AND (c.Deleted is null OR c.Deleted = ''N'')');
        sql.Add('ORDER BY a.LRDT');
        Open;
        First;

        //set global Last Audit vars
        LADT := FieldByName('LRDT').AsDateTime;
        LAD := DateOf(LADT);
        LAT := formatDateTime('hh:nn', LADT);

        s1 := 'ROLL: ' + roll + ', LADT: ' + formatDateTime('ddmmmyy hh:nn:ss:zzz', LADT) +
          ', POSs: ' + inttostr(RecordCount) + ', POSminRDT: ' + FieldByName('POSCode').AsString;

        close;

        // check Locations and Holding Zones setup
        siteUsesLocations := CheckSiteUsesLocations;
        siteUsesHZs := CheckSiteUsesHZs;

        // Only ONE of them can be ON (both can be OFF).
        if siteUsesLocations and siteUsesHZs then
        begin
          // this is wrong, it should not be possible to turn both on!!!
          // by now we know that both have valid setups so we need to pick a looser.
          // the looser will be the one with the earliest LMDT, because we need to pick one.

          // so fix the improbable problem but check again (CASE clause) in the query just in case...
          close;
          sql.Clear;
          sql.Add('UPDATE stkVarLocal set VarBit = 0, LMDT = GETDATE()  ');
          sql.Add('FROM stkVarLocal v1,   ');
          sql.Add(' (SELECT CASE COUNT(*) when 1 then NULL else MIN(LMDT) end as minLMDT  ');
          sql.Add('  from stkVarLocal  where  [SiteCode] = ' + inttostr(thesitecode));
          sql.Add('  and VarBit = 1 and (VarName = ''UseHZs'' or VarName = ''UseLocatns'')) v2 ');
          sql.Add('WHERE v1.[SiteCode] = ' + inttostr(thesitecode));
          sql.Add('and v1.LMDT = v2.minLMDT and VarBit = 1  ');
          sql.Add('and (VarName = ''UseHZs'' or VarName = ''UseLocatns'')  ');

          if execSQL > 0 then
          begin
            // there was a loser, check who it was...
            siteUsesHZs := CheckSiteUsesHZs;
            siteUsesLocations := CheckSiteUsesLocations;

            // whichever is false now was the loser, log it...
            if not siteUsesHZs then
              log.event('WARNING: The site was set to use both HZs and Locations by some error. The HZs were turned OFF as it was the oldest setting.')
            else
              log.event('WARNING: The site was set to use both HZs and Locations by some error. The Locations were turned OFF as it was the oldest setting.')
          end;
        end;

        if siteUsesLocations then
          s1 := s1 + '; Site uses Locations'
        else if siteUsesHZs then
          s1 := s1 + '; Site uses HZs'
        else
          s1 := s1 + '; Not using Locs or HZs';

        log.event(s1);

        Close;

        // vk - added here to reflect product-devision changes
        // also look at stkSP_make121Rcp
        doStkEntity;
      end;
    end
    else
    begin
      doStkEntity; // stkSP_121Rcp is only called at site; for HO stkEntity needs to be created here...
    end;

    // Get stkHOConf GLOBAL variables
    close;
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    // Default is NO (cbit = 0)
    if locate('cname', 'LCzeroLG', []) then
    begin
      lcZeroLG := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      lcZeroLG := False;
    end;

    // should I set Misc1 to be Sum(pcWaste Adjustment RETAIL VALUE)?
    // Default is NO (cbit = 0)
    if locate('cname', 'pcWAtoMisc', []) then
    begin
      pcWAtoMisc := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'pcWAtoMisc';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      pcWAtoMisc := False;
    end;

    // should I Suppress the Count Sheet Dialog
    // Default is NO (cbit = 0)
    if locate('cname', 'NoCSheetDlg', []) then
    begin
      noCountSheetDlg := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'NoCSheetDlg';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      noCountSheetDlg := False;
    end;

    close;
  end;

  StkCode     := 0;
  PrevStkCode := 0;
  curTid := 0;

  Stime       := '';
  Etime       := '';

  TheDiv      := '';
  TheStkTkr   := '';
  TheStkType  := '';

  NeedBeg  := False;
  NeedEnd  := False;

  // for site the repSite is the site code, at HO this will be overwritten in fHOrep at report time
  repSite := TheSiteCode;

  sitetab.close;
  sitetab.Parameters.ParamByName('repSite').Value := repSite;
  sitetab.Open;

  areatab.close;
  areatab.Parameters.ParamByName('repSite').Value := repSite;
  areatab.Open;

  // delete this temp table if it exists - used to keep user nom prices for full re-calc
  dmADO.DelSQLTable('#nomp');
  autoSlaveStk := False;
end;

procedure Tdata1.SetCurrentDivisionId(divisionStr: string);
begin
  adoqRun.close;
  adoqRun.sql.Clear;

  adoqRun.sql.Add('select ID from ac_ProductDivision where [Name] = ' + QuotedStr(divisionStr));
  adoqRun.open;
  curDivIx := adoqRun.FieldByName('ID').asinteger;

  adoqRun.close;
  adoqRun.sql.Clear;
end;

procedure Tdata1.initCurr(theTid, theCode, theSite : integer; RepOnly, Curr: boolean);
var
  lcBaseStr : string;
begin
  try
    with data1, data1.adoqRun do
    begin
      initGlobals;

      Log.event('Data1.InitCurr - ThreadID = ' + IntToStr(theTid) + ', StockCode = ' + IntToStr(theCode) +
         ', SiteCode = ' + IntToStr(theSite) + ', ReportOnly = ' + SysUtils.BoolToStr(RepOnly, TRUE) +
         ', Current = ' + SysUtils.BoolToStr(Curr, TRUE));

      repSite := theSite;

      if repSite <> theSiteCode then
      begin
        sitetab.close;
        sitetab.Parameters.ParamByName('repSite').Value := repSite;
        sitetab.Open;

        areatab.close;
        areatab.Parameters.ParamByName('repSite').Value := repSite;
        areatab.Open;
      end;

      Close;
      sql.Clear;
      sql.Add('SELECT [Division], [SDate], [STime], [EDate], [ETime], [SDT], ');
      sql.Add('  [EDT],[PrevStkCode], [Type], [ByHz], [StkKind], [RTRcp], byLocation, [DateRecalc], [TimeRecalc],');
      if curr then
      begin
        sql.Add('[CurStage]');
        sql.Add('FROM curStock');
      end
      else
      begin
        sql.Add('[AccDate]');
        sql.Add('FROM stocks');
      end;
      sql.Add('WHERE tid = ' + inttostr(theTid));
      sql.Add('AND SiteCode = '+IntToStr(repSite));
      sql.Add('and StockCode = ' + inttostr(theCode));
      open;

      curTid      := theTid;
      StkCode     := theCode;
      TheDiv      := FieldByName('Division').AsString;
      PrevStkCode := FieldByName('PrevStkCode').AsInteger;
      Sdate       := FieldByName('Sdate').AsDateTime;
      Edate       := FieldByName('Edate').AsDateTime;
      Stime       := FieldByName('Stime').AsString;
      Etime       := FieldByName('Etime').AsString;
      SDT         := FieldByName('Sdt').AsDateTime;
      EDT         := FieldByName('Edt').AsDateTime;
      curBgCP     := (FieldByName('type').asstring = 'B');

      if FieldByName('DateRecalc').AsString <> '' then
        curStkLastCalc := formatdatetime('yyyymmdd hh:nn:ss.zzz',
                          FieldByName('DateRecalc').AsDateTime + FieldByName('TimeRecalc').AsDateTime)
      else
        curStkLastCalc := '';
      
      curStkByHZ  := FieldByName('byHZ').AsBoolean;
      curStkByLocation := FieldByName('byLocation').AsBoolean;

      StkTypeLong := FieldByName('stkKind').AsString;
      curRTrcp    := FieldByName('RTrcp').AsBoolean;

      if curr then
      begin
        theStage  := FieldByName('CurStage').AsInteger;
        AccDate   := 0;
      end
      else
      begin
        theStage  := 4;
        AccDate   := FieldByName('Accdate').AsDateTime;
      end;

      // set NeedBeg, NeedEnd in data1
      if Stime <> '' then NeedBeg  := True;

      if Etime <> '' then NeedEnd  := True;

      SetCurrentDivisionId(TheDiv);

      close;
      sql.Clear;
      sql.Add('select stocktaker, stocktypeshort from stkmisc where tid = ' + IntToStr(curTid));
      sql.Add('and StockCode = '+IntToStr(StkCode));
      sql.Add('AND SiteCode = '+IntToStr(repSite));
      open;
      thestktkr := FieldByName('stocktaker').asstring;
      thestktype  := FieldByName('stocktypeshort').AsString;

      close;
      sql.Clear;
      sql.Add('select * from threads where tid = ' + IntToStr(curTid));
      open;

      curTidName := FieldByName('tname').asstring;
      curNomPrice := ((FieldByName('nomprice').asstring = 'Y') and (not noTillsOnSite));
      curFillClose := (FieldByName('fillclose').asstring = 'Y');
      curDozForm := (FieldByName('dozform').asstring = 'Y');      // 17701
      curEditTak := ((FieldByName('editTak').asstring = 'Y') and (not noTillsOnSite));
      curIsGP := (FieldByName('isGP').asstring = 'Y');
      curCPS := (FieldByName('doCPS').asstring = 'Y');
      curAutoRep := (FieldByName('AutoRep').asstring = 'Y');
      curGallForm := (FieldByName('gallform').asstring = 'Y');
      curTillVarTak := (FieldByName('tillVarTak').asstring = 'Y');
      curNoPurAcc := (FieldByName('NoPurAcc').asstring = 'Y');

      curByLocation := (FieldByName('byHZ').asboolean) and data1.siteUsesLocations; // only one of ...
      curByHz := (FieldByName('byHZ').asboolean) and data1.siteUsesHZs;            // these 2 can be TRUE
      confirmMobileStockCountImports := (FieldByName('ConfirmMobileStockImport').asboolean) AND curByLocation;

      curWasteAdj := (FieldByName('WasteAdj').asboolean);

      curisMth := (FieldByName('slaveTh').asinteger > 0);
      curisSth := (FieldByName('slaveTh').asinteger < 0);
      curSth := FieldByName('slaveTh').asinteger;

      curMngSig := FieldByName('MngSig').asboolean;
      curAudSig := FieldByName('AudSig').asboolean;
      curACSfields := FieldByName('ACSfields').asstring;
      curACSnp := (curACSfields[4] = '1');
      curACSheight := FieldByName('ACSheight').asfloat;
      curShowImpExpRef := FieldByName('ShowImpExRef').AsBoolean;
      curThreadIsMAC := FieldByName('MobileAutoCount').AsBoolean;
      curHideFillAudit := FieldByName('HideFillAudit').asboolean;
      curAutoFillBlankCounts := FieldByName('AutoFillBlindStockBlankCounts').AsBoolean;
      curNomPriceTariffRO := FieldByName('NomPriceTariffRO').asboolean;
      curNomPriceOldRO := FieldByName('NomPriceOldRO').asboolean;
      curEndOnDoW := FieldByName('EndOnDoW').asinteger;
      curUseMustCountItems := FieldByName('UseMustCountItems').asboolean;


  ////////////////////////////////////////////////////////////////////////////////////////////
  //
  // If you add a new variable (check box) for a Thread above REMEMBER to also load it from
  // from the DB in the code that initialises a NEW STOCK, unit uStkDivdlg procedure OKBtnClick
  // also check if you need to add it to procedure TdmAutoStockTake.Auto1StockTake
  //
  ////////////////////////////////////////////////////////////////////////////////////////////



      if curr then // only used for Accepting
      begin
        log.event('Data1.InitCurr, Is current stock, getting base for LC/SC');
        if FieldByName('LCBase').asboolean then
        begin
          if curByHZ then
          begin
            curTidAsBase := True;  // CAN act as Base for LC/SC
            lcBaseStr := 'LCbase,';
          end
          else
          begin
            // does the site have VALID HZs at this time? If not then a bySite Thread is OK...

            if SiteUsesHZs then // check if any OTHER Threads are byHZ AND LCbase...
            begin
              // is there any thread with byHZ, with LCBase and at least 1 stock accepted for THIS division?
              with dmADO.adoqRun2 do
              begin
                close;
                sql.Clear;
                sql.Add('select count(*) as thecount from Threads where division = ' + quotedStr(TheDiv));
                sql.Add('and byHZ = 1 and LCBase = 1 and Active = ''Y''');
                sql.Add('and Tid <> ' + inttostr(curTid)); // not this thread
                sql.Add('and Tid in (select Tid from stocks where stockcode > 1)');
                open;

                if FieldByName('thecount').AsInteger > 0 then
                begin
                  curTidAsBase := False;
                  curDivAsBase := True; // this will bypass the "kill stkECLevel if no Thread has LCbase" code...
                                        // as some Threads ARE SET as LCbase (that's why THIS stock is False).
                  lcBaseStr := 'NOT LCbase(' + FieldByName('thecount').AsString + ' tids with HZ-LCb),';
                end
                else
                begin
                  curTidAsBase := True;
                  lcBaseStr := 'LCbase,';
                end;
                close;
              end;
            end
            else
            begin
              curTidAsBase := True;
              lcBaseStr := 'LCbase,';
            end;
          end;
        end
        else
        begin
          curTidAsBase := False;  // can NOT act as Base for LC/SC
          // is there ANY active thread with stocks in it that can be a Base for this Division?
          with dmADO.adoqRun2 do
          begin
            close;
            sql.Clear;
            sql.Add('select count(*) as thecount from Threads where division = ' + quotedStr(TheDiv));
            sql.Add('and LCBase = 1 and Active = ''Y''');
            sql.Add('and Tid in (select Tid from stocks where stockcode > 1)');
            open;

            if FieldByName('thecount').AsInteger = 0 then
            begin
              curDivAsBase := False;
              lcBaseStr := 'NOT LCbase(no other Bases!!!),';
            end
            else
            begin
              curDivAsBase := True;
              lcBaseStr := 'NOT LCbase(but ' + FieldByName('thecount').AsString + ' tids are),';
            end;
            close;
          end;
        end;
      end;

      if FieldByName('InstTR').asboolean then
        if FieldByName('AskTR').asboolean then
          curTidRcpHow := 2   // ask on new stock
        else
          curTidRcpHow := 1   // use Real Time (time of sale) recipes
      else
        curTidRcpHow  := 0;   // use Stock Time Recipe
      close;

      // get MTh/STh info if needed...
      if curisMth then
      begin
        log.event('Data1.InitCurr, getting Master info');
        Close;
        sql.Clear;
        sql.Add('SELECT tid, tname, slaveTh from threads');
        sql.Add('WHERE tid = ' + inttostr(curSTh));
        open;

        curSthName := FieldByName('tname').AsString;

        // now get the last Acc stock of the Subordinate thread...
        Close;
        sql.Clear;
        sql.Add('SELECT a."StockCode", a."EDate", a."ETime", a."sdate", a."stime", a.edt, a.sdt');
        sql.Add('FROM "stocks" a');
        sql.Add('WHERE a."tid" = ' + inttostr(curSTh));
        sql.Add('AND a."SiteCode" = '+IntToStr(repSite));
        sql.Add('and a.edt > ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss', SDT)));
        sql.Add('order by a."EDate", a."ETime"');
        open;
        Last;

        lastSThAccCode := FieldByName('stockcode').AsInteger;
        lastSThAccEDT := FieldByName('EDT').AsDateTime;
        lastSthAccFBD := FieldByName('Edate').asdatetime;
        firstSThAccCode := FieldByName('stockCode').asinteger;

        // now using the same query go back to discover the first slave stock included in the
        // current Master Stock
        while not bof do
        begin
          prior;
          if (FieldByName('SDate').AsDateTime = SDate) and (FieldByName('STime').asstring = STime) then
          begin
            // found it...
            firstSThAccCode := FieldByName('stockCode').asinteger;
            break;
          end
          else
          begin
            // have we passed beyond the required start date? BAAAD Error somewhere
            if FieldByName('SDate').AsDateTime < SDate then
            begin
              // reset the variable saying this is a Master Stock
              curisMTh := False;

              log.event('ERROR: 1st Sub. Stock involved with the Master Stock could not be found!');
              // tell the user
              ShowMessage('ERROR: This is a Master Thread!' +
                'The first ' + ssBig + ' of its Subordinate Thread "' + curSThName +
                '" to be synchronized by the Master Thread ' + ssbig + ' could not be identified!' +
                #13 + #13 + 'Please call ZONAL Help Centre BEFORE attempting to Accept this ' + ssBig + '!');
              break;
            end;
          end;
        end;
        close;
      end  // if.. then..
      else if curisSTh then
      begin
        log.event('Data1.InitCurr, getting Subordinate info');
        Close;
        sql.Clear;
        sql.Add('SELECT tid, tname, slaveTh from threads');
        sql.Add('WHERE slaveTh = ' + inttostr(curTid));
        open;

        curMthName := FieldByName('tname').AsString;
        curMth := FieldByName('tid').asinteger;

        close;
      end; //if.. then.. else..

      log.event('Data1.InitCurr, rebuilding StkCrDiv');
      dmADO.EmptySQLTable('stkcrdiv');
      close;
      sql.Clear;
      sql.Add('Insert into [StkCrDiv] (hzid, [EntityCode], [Key2], [OpStk], [OpCost], [PurchStk],');
      sql.Add('    [PurchCost], [ThRedQty], [ThRedCost], [ThCloseStk], [ThCloseCost], [ActRedQty],');
      sql.Add('    [ActRedCost], [ActCloseStk], [ActCloseCost], [PrepRedQty],');
      sql.Add('    [PurchUnit], [PurchBaseU], [StdBaseSize], [NomPrice], [TheoPrice],');
      sql.Add('    [VatRate], [Yield], [GP], [COS%], [lossgain],');
      sql.Add('    [wastetill], [wastetillA], [wastepc], [wastepcA], [wastage],');
      sql.Add('    [soldqty], [auditstk], moveqty, movecost, OpenPrep, ClosePrep, TrueRedCost)');
      sql.Add('SELECT a.hzid, a.[EntityCode], a.[Key2], a.[OpStk], a.[OpCost], a.[PurchStk],');
      sql.Add('    a.[PurchCost], a.[ThRedQty], a.[ThRedCost], a.[ThCloseStk], a.[ThCloseCost], a.[ActRedQty],');
      sql.Add('    a.[ActRedCost], a.[ActCloseStk], a.[ActCloseCost], a.[PrepRedQty],');
      sql.Add('    a.[PurchUnit], a.[PurchBaseU], a.[StdBaseSize], a.[NomPrice], a.[TheoPrice],');
      sql.Add('    a.[VatRate], a.[Yield], a.[GP], a.[COS%], a.[lossgain],');
      sql.Add('    a.[wastetill], a.[wastetillA], a.[wastepc], a.[wastepcA], a.[wastage],');
      sql.Add('    a.[soldqty], a.[auditstk], moveqty, movecost, OpenPrep, ClosePrep, TrueRedCost');
      sql.Add('FROM [stkmain] a');
      sql.Add('WHERE a."StkCode" = '+IntToStr(StkCode));
      sql.Add('and tid = '+IntToStr(curtid));
      sql.Add('and SiteCode = '+IntToStr(repSite));
      execSQL;

      if curr then
      begin
        log.event('Data1.InitCurr, Is current stock, getting Nominal Prices');
        // if this is a full recalc the user nom prices have to be kept separately
        dmADO.DelSQLTable('#nomp');
        close;
        sql.Clear;
        sql.Add('SELECT a.[EntityCode], a.[GP] INTO [#nomp]');
        sql.Add('FROM [stkcrdiv] a');
        sql.Add('WHERE a."GP" is not NULL');
        execSQL;
      end;

      if theStage >= 1 then
      begin
        if isSite then // HO Holding Report does not get the purch sub-report
          dataproc.FastPurch((not RepOnly) and Curr); // do not update stkMisc if stock is Complete...

        if theStage > 2 then
        begin
          log.event('Data1.InitCurr, rebuilding PreparedItemSplit');
          dmADO.DelSQLTable('#PreparedItemSplit');

          close;
          sql.Clear;
          sql.Add('Select [HoldingZoneID] as hzid, [PreparedItem], [BatchUnit], [BatchSize],[Ingredient],');
          sql.Add('   [Ratio], [OpenSplit], [CloseSplit], [Adjustment]');
          sql.Add('INTO [#PreparedItemSplit]FROM PreparedItemSplit');
          sql.Add('WHERE StockCode = '+IntToStr(StkCode));
          sql.Add('and ThreadID = '+IntToStr(data1.curtid));
          sql.Add('and SiteCode = '+IntToStr(repSite));
          execSQL;

          log.event('Data1.InitCurr, rebuilding StkCrSld');
          dmADO.EmptySQLTable('stkcrsld');

          close;
          sql.Clear;
          sql.Add('Insert into [StkCrsld] (hzid, EntityCode, Portion, [ProductType], [StdBaseSize], [SalesQty],');
          sql.Add('  [Income],[AvSalesPrice], [TheoPrice], [Faults], [TheoCost], [ActCost], [AvVATCost],');
          sql.Add('  [VATRate], [RcpCost], [GP], [COS%], [IngPrice])');
          sql.Add('Select hzid, EntityCode, Portion, [ProductType], [StdBaseSize], [SalesQty],');
          sql.Add('  [Income], [AvSalesPrice], [TheoPrice], [Faults], [TheoCost], [ActCost], [AvVATCost],');
          sql.Add('    [VATRate], [RcpCost], [GP], [COS%], [IngPrice]');
          sql.Add('FROM [stksold]');
          sql.Add('WHERE StkCode = '+IntToStr(StkCode));
          sql.Add('and tid = '+IntToStr(data1.curtid));
          sql.Add('and SiteCode = '+IntToStr(repSite));
          execSQL;
        end;
      end;
      close;

      logDetsCurStock := '(Tid '+IntToStr(data1.curtid) + ' ' + data1.curTidName;

      if curByLocation then
        logDetsCurStock := logDetsCurStock + '(byLocation) '
      else if curByHZ then
        logDetsCurStock := logDetsCurStock + '(byHZ) '
      else
        logDetsCurStock := logDetsCurStock + '(bySite) ';

      logDetsCurStock := logDetsCurStock + ' Stk ' +
        inttostr(data1.StkCode) + ' (' + theDiv + ') ' + formatDateTime('ddmmmyy hhnnss', SDT) + '-' +
        formatDateTime('ddmmmyy hhnnss', EDT) + '(ED ' + formatDateTime('ddmmmyy', EDate) + ' ET ' +
        ETime + ') ';

      if stkTypeLong = 'MAC' then
        logDetsCurStock := logDetsCurStock + ' MAC ';

      if curStkbyLocation then
        logDetsCurStock := logDetsCurStock + 'byLocation,'
      else if curStkbyHZ then
        logDetsCurStock := logDetsCurStock + 'byHZ,'
      else
        logDetsCurStock := logDetsCurStock + 'bySite,';

      if curr then
        logDetsCurStock := logDetsCurStock + lcBaseStr;

      if curRtrcp then
        logDetsCurStock := logDetsCurStock + 'RealTimeTheoRed.'
      else
        logDetsCurStock := logDetsCurStock + 'CountTimeTheoRed.';

      if curisMth then
        logDetsCurStock := logDetsCurStock + ' MASTER(Slv ' + inttostr(curSTh) + ' ' + curSthName + ')';

      if curisSth then
        logDetsCurStock := logDetsCurStock + ' SLAVE(Master ' + inttostr(curMTh) + ' ' + curMthName + ')';

      log.event('LOAD STK ->> ' + logDetsCurStock);
    end; // with
  except
    on E: Exception do
    begin
      log.event('ERROR - Data1.InitCurr - ' + E.Message);
      showMessage('ERROR initializing current stock!' + #13 +
         'Error: "' + E.Message + #13#13 + 'Please check any stock closing values' + #13#13 +
         'already entered.');
    end;
  end;
end;

///////////  CC  //////////////////////////////////////////////////////////////
//
//  checks to see if HZs are setup PROPERLY.
//
///////////////////////////////////////////////////////////////////////////////
function Tdata1.CheckHZsValid(temp: boolean): boolean;
var
  tot, j, sls, purHZidtmp : integer;
  allPOS : boolean;
  badPOSs : string;
begin

  if noTillsOnSite then
  begin
    Result := False;
    exit;
  end;

  // at least 2 HZs
  // is there one (and only one) HZ that gets Purchases?
  // are all Valid Tills assigned to a HZ?

  with adoqRun do
  begin
    // is there any setup at all?
    close;
    sql.Clear;
    sql.Add('select ePur, count(hzid) as thecount, sum(hzid) as theID');
    if temp then
      sql.Add('from stkHZsTmp')
    else
      sql.Add('from stkHZs');
    sql.Add('where active = 1 group by ePur');
    open;

    // expect 2 records...
    tot := 0;
    j := 0;
    purHzIDtmp := -1;

    while not eof do
    begin
      tot := tot + FieldByName('thecount').asinteger;

      if FieldByName('epur').asboolean then
      begin
        j := FieldByName('thecount').asinteger;
        if j = 1 then
        begin
          purHzIDtmp := FieldByName('theID').asinteger; // sum of hzID from 1 record gives the hzID.
        end;
      end;

      next;
    end;

    // now look at Sales. We need at least 1 Sales enabled HZ AND all active tills to be assigned
    // to some HZ(s).
    // is there any setup at all?
    close;
    sql.Clear;
    sql.Add('select hzid');
    if temp then
      sql.Add('from stkHZsTmp')
    else
      sql.Add('from stkHZs');
    sql.Add('where active = 1 and eSales = 1');

    open;

    // expect at least 1 record.
    sls := recordcount;
    close;

    Close;
    SQL.Clear;
    SQL.Add('SELECT EPOSDeviceID');
    SQL.Add('FROM ThemeEPOSDevice_Repl');
    SQL.Add('WHERE EPOSDeviceID NOT IN (SELECT TerminalID FROM ');
    if temp then
      SQL.Add('stkhzpostmp)')
    else
      SQL.Add('stkHZpos)');

    SQL.Add('AND (  (IsServer = 0)  ');                                                // select only Tills
    SQL.Add('     OR(  (IsServer = 1)');                                               // or "Servers" that are
    SQL.Add('        AND (HardwareType IN (SELECT HardwareType FROM TerminalHardware');// inputs for Hotel plugins
    SQL.Add('                              WHERE HardwareName = ''Hotel System''))))');
    SQL.Add('AND SiteCode = ' + inttostr(TheSiteCode));
    SQL.Add('and HardwareType NOT IN');
    SQL.Add(' (SELECT HardwareType FROM TerminalHardware WHERE HardwareName = ''External API Access'')');
    Open;

    allPOS := (recordcount = 0); // leave it open for err log (if any)

    // now analyse the results (tot, j, purHzID)

    if (tot >= 2) and (j = 1) and (purHzIDtmp > 0) and (sls > 0) and (allPOS) then
    begin // all OK...
      if not temp then
      begin
        purHZid := purHZidTmp;
        log.event('Check HZs: VALID - (all, Sales, PurHZ ID): ' + inttostr(tot) + ', ' + inttostr(sls) +
          ', ' + inttostr(purHZid));
      end;

      // if there is any HZ with eSales but no POS assigned then take the SSales off..
      close;
      sql.Clear;
      if temp then
        sql.Add('update stkHZsTmp set eSales = 0')
      else
        sql.Add('update stkHZs set eSales = 0');
      sql.Add('where active = 1 and eSales = 1');
      sql.Add('and hzid not in (select distinct hzid ');
      if temp then
        sql.Add('from stkhzpostmp)')
      else
        sql.Add('from stkHZpos)');

      // reuse j
      j := execSQL;

      if temp and (not data1.blindRun) then
      begin
        if j = 1 then
          showMessage('WARNING: There was a Holding Zone set up for Sales which had no POS Terminals ' +
            'assigned to it.'#13'The Sales flag has now been removed from that Holding Zone.')
        else if j > 1 then
          showMessage('WARNING: There were ' + inttostr(j) +
            ' Holding Zones set up for Sales which had no POS Terminals assigned to them.'#13 +
            'The Sales flag has now been removed from those Holding Zones.')
      end;


      Result := True;
    end
    else
    begin
      if not temp then
      begin
        // read the till(s) in AztecPOS NOT in stkHZpos
        badPOSs := '';
        while not eof do
        begin
          badPOSs := badPOSs + FieldByName('EPOSDeviceID').AsString + ',';
          next;
        end;

        //add the rest of the stuff in front of badPOSs
        badPOSs := 'Check HZs: Invalid - (all, Sales, PurHZid, NonHZ Tills): ' + inttostr(tot) + ', ' +
          inttostr(sls) + ', ' + inttostr(purHZid) + ', ' + inttostr(recordcount) + '[' + badPOSs + ']';

        log.event(badPOSs);
      end;

      Result := False;
    end;

    close;
  end;
end; // procedure..

// checks to see if Locations are properly set up on this site...
function Tdata1.CheckLocationsValid: boolean;
var
  nonDeletedLocs, deletedLocs : integer;
begin
  // for now the only thing to check is that there is at least one non-Deleted Location

  nonDeletedLocs := 0;
  deletedLocs := 0;

  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a.Deleted, count(*) as thecount');
    sql.Add('from stkLocations a');
    sql.Add('group by a.Deleted');
    open;

    while not eof do
    begin
      if fieldByName('Deleted').asboolean = FALSE then
        nonDeletedLocs := fieldByName('thecount').asinteger
      else
        deletedLocs := fieldByName('thecount').asinteger;
      next;
    end;
    close;

    if nonDeletedLocs > 0 then
      log.event('Locations: ' + inttostr(nonDeletedLocs) + ' Valid, ' + inttostr(deletedLocs) + ' Deleted');

    Result := (nonDeletedLocs > 0);
  end;
end;


function Tdata1.CheckSiteUsesHZs: boolean;
var
  useHZs : boolean;
begin
  // setting is saved in stkVarLocal
  // check the HZs are Valid; if not Valid then change and save the setting to FALSE.

  siteHasValidHZs := CheckHZsValid(FALSE);

  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT VarBit from stkVarLocal where VarName = ''UseHZs'' ');
    sql.Add('and [SiteCode] = ' + inttostr(thesitecode));
    open;
    useHZs := (fieldByName('VarBit').asboolean);
    close;

    // if UseHZs are ON but not Valid (some change happened) turn UseHZs off and save...
    if useHZs and not siteHasValidHZs then
    begin
      useHZs := FALSE;

      close;
      sql.Clear;
      sql.Add('  DELETE stkVarLocal where VarName = ''UseHZs''');
      sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
      sql.Add('     VALUES('+IntToStr(TheSiteCode)+',''UseHZs'', 0, GetDate())');
      execSQL;

      log.event('WARNING: Use HZs was ON but was turned OFF because HZs setup was found to be Invalid!');
    end;

    Result := useHZs;
  end;
end;

function Tdata1.CheckSiteUsesLocations: boolean;
var
  useLocations : boolean;
begin
  // setting is saved in stkVarLocal
  // check the Locations are Valid; if not Valid then change and save the setting to FALSE.

  siteHasValidLocations := CheckLocationsValid;

  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT VarBit, VarString from stkVarLocal where VarName = ''UseLocatns'' ');
    sql.Add('and [SiteCode] = ' + inttostr(thesitecode));
    open;
    useLocations := (fieldByName('VarBit').asboolean);
    siteLCbyLocation := (fieldByName('VarString').asstring = 'LC');
    close;

    // if UseLocations is ON but not Valid (some change happened) turn it off and save...
    if useLocations and not siteHasValidLocations then
    begin
      useLocations := FALSE;

      close;
      sql.Clear;
      sql.Add('  DELETE stkVarLocal where VarName = ''UseLocatns''');
      sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
      sql.Add('     VALUES('+IntToStr(TheSiteCode)+',''UseLocatns'', 0, GetDate())');
      execSQL;

      log.event('WARNING: Use Locations was ON but was turned OFF because Locations setup was found to be Invalid!');
    end;

    Result := useLocations;
  end;
end;

procedure Tdata1.UpdateCurrStage(cstage: integer);
begin
  theStage := cStage;
  with dmADO.adoTRun do
  begin
  	close;
    TableName := 'curstock';
    open;
    if locate('tid;stockcode', VarArrayOf([data1.curtid , data1.StkCode]), []) then
    begin
      edit;
      FieldByName('CurStage').AsInteger := cstage;
      FieldByName('LMDT').AsDateTime := now;

      case cstage of
         0,1: FieldByName('Stage').AsString := 'UnAudited';
           2: FieldByName('Stage').AsString := 'Part Audited';
           3: FieldByName('Stage').AsString := 'Audited';
           4: begin
                FieldByName('Stage').AsString := 'Completed';
                FieldByName('DateRecalc').AsDateTime := Date;
                FieldByName('TimeRecalc').AsString := formatDateTime('hh:nn',Time);
              end;
      end;

      post;
    end;
    close;
  end;
  log.event('Data1.UpdateCurrState: ' + inttostr(cStage) + ' done.');
end;

procedure Tdata1.GenerateCurrentStockAuditLocationFigures(load, tryImport: boolean);
var
  cpyStkCode, cpyTid, i : integer;
  s1 : string;
begin
  log.event('In Data1.GenerateCurrentStockAuditLocationFigures');
  dmAdo.EmptySQLTable('auditLocationscur');

  with data1.adoqRun do
  begin
    if curACSnp and (theStage < 3) then // calc Theo Nom Prices and get them into AuditCur...
    begin
      // CALCULATE Nom Prices from Theoretical figures
      if data1.curByHZ then s1 := '1, ' else s1 := '0, ';
      if data1.ssDebug then s1 := s1 + '1' else s1 := s1 + '0';

      dmRunSP := TdmRunSP.Create(self);
      with dmRunSP do
      begin
        //spConn.ConnectionString := dmADO.AztecConn.ConnectionString;
        spConn.Open;

        with adoqRunSP do
        begin
          close;
          sql.Clear;
          sql.Add('exec stkSP_NomPriceForAudit ' + s1);
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
              showMessage('ERROR Calculating Retail Cost and Nominal Prices!' + #13 +
                'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
              exit;
            end;
          end;
        end;
        spConn.Close;
      end;
      dmRunSP.Free;
    end;

    // first load the Complete Site...
    close;
    sql.Clear;
    sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');

    sql.Add('SELECT 0, 0, b.entitycode,');
    sql.Add(' (CASE ');
    sql.Add('    WHEN (a.key2 < 1000) THEN b.purchasename'); // NORMAL items
    sql.Add('    ELSE b.retailname');                                                // 17841 - Prep.Items
    sql.Add('  END) as purchasename,');
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('(b.[SCat]) as SubCatName, b.ImpExRef,')
    else
      sql.Add('(b.[Cat]) as SubCatName, b.ImpExRef,');
    sql.Add(' (CASE ');
    sql.Add('    WHEN ((a.key2 = 55) or (a.key2 = 1055)) THEN -888888'); // 17841 - NEW Items
    sql.Add('    WHEN ((a.key2 = 66) or (a.key2 = 1066)) THEN -777777'); // NEW HZ Items
    sql.Add('    ELSE (a.OpStk / a.purchbaseU)');                        // NORMAL items
    sql.Add('  END) as OpStk,');
    sql.Add(' (CASE ');
    sql.Add('    WHEN (a.key2 < 1000) THEN (a.PurchStk / a.purchbaseU)'); // NORMAL items
    sql.Add('    ELSE -999999');                                                // 17841 - Prep.Items
    sql.Add('  END) as PurchStk,');
    sql.Add('(a.ThRedQty / a.purchbaseU) as ThRedQty,');
    sql.Add('(a.ThCloseStk / a.purchbaseU) as ThCloseStk,');
    sql.Add('a.purchunit, a.purchbaseU, 1, (a.[wastetill] / a.purchbaseU),');
    sql.Add('(a.[wastetillA] / a.purchbaseU), (a.[wastepc] / a.purchbaseU),');
    sql.Add('(a.[wastepcA] / a.purchbaseU), (a.[wastage] / a.purchbaseU), ');

    if curACSnp then // if stage is 3 or 4 then we already have nominal prices so use them...
      sql.Add('1, (a.PurchCost * a.purchbaseU), (a.nomprice * a.purchbaseU)')
    else
      sql.Add('1, (a.PurchCost * a.purchbaseU), NULL');

    sql.Add('FROM StkCrDiv a, stkEntity b');
    sql.Add('WHERE a.entitycode = b.entitycode');
    execSQL;

    // if Theo NomPrices were calculated now delete them so they don't interfere with proper Nom Prices...
    if curACSnp and (theStage < 3) then
    begin
      close;
      sql.Clear;
      sql.Add('update stkcrdiv set nomprice = 0');
      execSQL;
    end;

    //now load the Location Lists...
    // the Prep Item indicator switches from the PurchStk column to the Wastage Adj. column
    close;
    sql.Clear;
    sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');

    sql.Add('SELECT ll.LocationID, ll.RecID, b.entitycode,');
    sql.Add(' (CASE ');
    sql.Add('    WHEN (a.key2 < 1000) THEN b.purchasename'); // NORMAL items
    sql.Add('    ELSE b.retailname');                                                // 17841 - Prep.Items
    sql.Add('  END) as purchasename,');

    if data1.RepHdr = 'Sub-Category' then
      sql.Add('(b.[SCat]) as SubCatName, b.ImpExRef,')
    else
      sql.Add('(b.[Cat]) as SubCatName, b.ImpExRef,');

    sql.Add(' (CASE  WHEN ((a.key2 = 55) or (a.key2 = 1055)) THEN -888888'); // 17841 - NEW Items
    sql.Add('    ELSE OpStk END) as OpStk,');
    sql.Add(' (CASE  WHEN (a.key2 < 1000) THEN PurchStk'); // NORMAL items
    sql.Add('    ELSE -999999  END) as PurchStk,');    // 17841 - Prep.Items
    sql.Add('(a.ThRedQty) as ThRedQty, (a.ThCloseStk) as ThCloseStk, ll.Unit, NULL,  ');
    sql.Add(' (CASE WHEN (ll.Unit = a.purchunit) THEN 1 ELSE 0 END) as IsPurchUnit,');
    sql.Add('0, 0, 0, 0, NULL, 0, NULL, NULL  ');

    sql.Add('FROM stkLocationLists ll, StkCrDiv a, stkEntity b');
    sql.Add('WHERE ll.entitycode = a.entitycode ');
    sql.Add('and a.entitycode = b.entitycode and ll.Deleted = 0');
    execSQL;

    // get the Base Units for the Units...
    close;
    sql.Clear;
    sql.Add('update auditLocationsCur set purchbaseu = sq.[base units]');
    sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
    sql.Add('where unit = sq.[unit name] and LocationID > 0');
    execSQL;

    // now for any product NOT in at least one Location add it to the <No Location> list
    close;
    sql.Clear;
    sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');
    sql.Add('SELECT 999, 0, a.entitycode, a.name, a.SubCat, ');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU');
    sql.Add('FROM (select * from auditLocationscur where LocationID = 0) a');
    sql.Add('LEFT OUTER JOIN ');
    sql.Add('  (select distinct entitycode from auditLocationscur where LocationID > 0) ll ');
    sql.Add('ON a.entitycode = ll.entitycode ');
    sql.Add('WHERE ll.entitycode is NULL');
    execSQL;

    if load then
    begin
      close;
      sql.Clear;
      sql.Add('Update AuditLocationsCur ');
      sql.Add('set ActCloseStk = CASE a.CloseStkAutofilled WHEN 1 THEN NULL ELSE a.ActCloseStk END,');
      sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
      sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
      sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
      sql.Add('WHERE a."entitycode" = b."entitycode"');
      sql.Add('and a.RecId = b.RecId');
      sql.Add('and a.LocationId = b.LocationId and a.LocationID < 999');
      sql.Add('and a.Unit = b.Unit');
      sql.Add('AND a."StkCode" = '+IntToStr(StkCode));
      sql.Add('and a.tid = '+IntToStr(curtid));
      i := execSQL;

      // now add any "for this Stock only" records temporarily appended to the Location Lists and saved...
      close;
      sql.Clear;
      sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
      sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
      sql.Add('purchbaseU, isPurchUnit, ActCloseStk, [wastetill], [wastetillA], [wastepc], [wastepcA],');
      sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');

      sql.Add('SELECT al.LocationID, al.RecID, b.entitycode,');
      sql.Add(' (CASE ');
      sql.Add('    WHEN (a.key2 < 1000) THEN b.purchasename'); // NORMAL items
      sql.Add('    ELSE b.retailname');                                                // 17841 - Prep.Items
      sql.Add('  END) as purchasename,');

      if data1.RepHdr = 'Sub-Category' then
        sql.Add('(b.[SCat]) as SubCatName, b.ImpExRef,')
      else
        sql.Add('(b.[Cat]) as SubCatName, b.ImpExRef,');

      sql.Add(' (CASE  WHEN ((a.key2 = 55) or (a.key2 = 1055)) THEN -888888'); // 17841 - NEW Items
      sql.Add('    ELSE OpStk END) as OpStk,');
      sql.Add(' (CASE  WHEN (a.key2 < 1000) THEN PurchStk'); // NORMAL items
      sql.Add('    ELSE -999999  END) as PurchStk,');    // 17841 - Prep.Items
      sql.Add('(a.ThRedQty) as ThRedQty, (a.ThCloseStk) as ThCloseStk, al.Unit, NULL,  ');
      sql.Add(' (CASE WHEN (al.Unit = a.purchunit) THEN 1 ELSE 0 END) as IsPurchUnit,');
      sql.Add('al.ActCloseStk, 0, al.[wastetillA], 0, al.[wastepca], al.[wastetillA] + al.[wastepca],');
      sql.Add('0, al.RecID - 1000000, NULL  ');
      sql.Add('FROM StkCrDiv a, stkEntity b, ');

//      sql.Add(' (select * from AuditLocations where RecID > 1000000 and LocationID < 999) al');

//    bug 370926 recommended by Cornel Condescu
      sql.Add(' (');
      sql.Add('select * from AuditLocations where RecID > 1000000 and LocationID < 999 ');
      sql.Add('and StkCode = ' + IntToStr(StkCode) + ' ');
      sql.Add('and Tid = ' + IntToStr(curTid) + ' ');
      sql.Add(') al ');

      sql.Add('WHERE al.entitycode = a.entitycode  and a.entitycode = b.entitycode');
      execSQL;

      // get the Base Units for the Units...
      close;
      sql.Clear;
      sql.Add('update auditLocationsCur set purchbaseu = sq.[base units]');
      sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
      sql.Add('where unit = sq.[unit name] and LocationID > 0 and RecID > 1000000');
      execSQL;

      // also add the <No Location> records, this time match by EntityCode only...
      close;
      sql.Clear;
      sql.Add('Update AuditLocationsCur set ActCloseStk = a."ActCloseStk",');
      sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
      sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
      sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
      sql.Add('WHERE a."entitycode" = b."entitycode"');
      sql.Add('and a.LocationId = b.LocationId and a.LocationID = 999');
      sql.Add('and a.Unit = b.Unit');
      sql.Add('AND a."StkCode" = '+IntToStr(StkCode));
      sql.Add('and a.tid = '+IntToStr(curtid));
      i := i + execSQL;

      if i > 0 then
      begin
        close;
        sql.Clear;
        sql.Add('select * from AuditLocationsCur');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('ActCloseStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);

          post;
          next;
        end;
      end;
    end;

    if tryImport then
    begin
      //==========================================================================================
      // try to detect an accepted stock in another thread but same division that has the same
      // End date/end time as this one. If yes offer to import its audit counts (the ones that fit)...
      // also it has to have byLocation = True, as the current one...

      close;
      sql.Clear;
      sql.Add('select a.stockcode, a.tid, a.sdate, a.stime, a.accdate, b.TName');
      sql.Add('from stocks a, threads b where a.[division] = ' + quotedStr(data1.TheDiv));
      sql.Add('and abs(CAST(a.edt - ' + quotedstr(formatDateTime('yyyymmdd hh:nn', data1.EDT)) +
             ' AS FLOAT)) <= 0.000694444');
      sql.Add('and a.stockcode > 1');
      sql.Add('and a.tid = b.tid');
      sql.Add('and a.byLocation = 1');
      sql.Add('order by b.Tname');
      open;

      if RecordCount > 0 then
      begin
        cpystkcode := 0;

        if recordcount = 1 then
        begin
          if MessageDlg('The system has detected an accepted '+ data1.sslow + ' for Division '+
              '"' + data1.TheDiv + '" that has the same End Date/Time as this '+ data1.sslow + '.'+#13+
              'THREAD: "' + FieldByName('tname').asstring + '"; Start Date: "' +
              formatDateTime('ddddd', FieldByName('Sdate').asdatetime) +
              '"; Accepted Date: "' + formatDateTime('ddddd', FieldByName('accdate').asdatetime) + '" ' +
              #13+''+#13+ 'The Closing '+ data1.SSbig + ' figures of that '+ data1.sslow +
              ' can be imported into the Audit Counts.' + #13 +
              'This would overwrite any Audit Counts you may have previously typed in.'+#13+''+#13+
              'Do you want to import these figures?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
          begin
            cpystkcode := FieldByName('stockcode').AsInteger;
            cpytid := FieldByName('tid').AsInteger;
          end;
        end
        else
          GetStockToCopy(cpystkcode, cpytid);

        if cpyStkCode <> 0 then
        begin
          close;
          sql.Clear;
          sql.Add('Update AuditLocationsCur set ActCloseStk = a."ActCloseStk",');
          sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
          sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
          sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
          sql.Add('WHERE a."entitycode" = b."entitycode"');
          sql.Add('and a.RecId = b.RecId');
          sql.Add('and a.LocationId = b.LocationId and a.LocationID < 999');
          sql.Add('and a.Unit = b.Unit');
          sql.Add('AND a."StkCode" = '+IntToStr(cpyStkCode));
          sql.Add('and tid = '+IntToStr(cpytid));
          i := execSQL; // pre-use cpyTid as a simple counter...

          // also add the <No Location> records, this time match by EntityCode only...
          close;
          sql.Clear;
          sql.Add('Update AuditLocationsCur set ActCloseStk = a."ActCloseStk",');
          sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
          sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
          sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
          sql.Add('WHERE a."entitycode" = b."entitycode"');
          sql.Add('and a.LocationId = b.LocationId and a.LocationID = 999');
          sql.Add('and a.Unit = b.Unit');
          sql.Add('AND a."StkCode" = '+IntToStr(cpyStkCode));
          sql.Add('and a.tid = '+IntToStr(cpytid));
          i := i + execSQL; // pre-use cpyTid as a simple counter...

          if i > 0 then
          begin
            close;
            sql.Clear;
            sql.Add('select * from AuditLocationsCur');
            open;

            while not eof do
            begin
              //import the floats in the string field
              edit;
              if FieldByName('ActCloseStk').asstring = '' then
                FieldByName('ACount').AsString := ''
              else
                FieldByName('ACount').AsString :=
                  data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);

              post;
              next;
            end;
          end;

          close;
        end;
      end;
      close;
      //========================================================================================
    end;

    // 357774 - for PrepItems find out if any of their Parent Recipes were sold and if yes then the Prep Item
    //          should be visible on the Audit Grid...
    if IncludePrepItemsInAudit then
    begin
      close;
      sql.Clear;
      sql.Add('update auditLocationscur set ThRedQty = sq.theCount');
      sql.Add('from');
      sql.Add('  (select sq1.Child, COUNT (DISTINCT t.Parent) as TheCount ');
      sql.Add('   from (select s1.* from ');
      sql.Add('     (select * from auditLocationscur a where PurchStk = -999999) ac ');
      sql.Add('     inner join ');
      sql.Add('     (select r.Child, r.Parent from stk121Rcp r where r.Ctype = ''P'' and r.Ptype is NULL) s1 ');
      sql.Add('     on ac.EntityCode = s1.Child) sq1');
      sql.Add('   inner join stkTRtemp t on t.Parent = sq1.Parent');
      sql.Add('   group by Child  ) sq');
      sql.Add('where auditLocationscur.entitycode = sq.Child');
      execSQL;
    end;

    // markup records depending if they should be there or not based on open/purch/move/sold/waste/thclose
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ShouldBe = 0');
    sql.Add('where (   ("OpStk" <> 0)');
    sql.Add('       or (("PurchStk" <> 0) and ("PurchStk" <> -999999))');
    sql.Add('       or ("ThRedQty" <> 0)');
    sql.Add('       or ("ThCloseStk" <> 0)');
    sql.Add('       or ("WasteTill" <> 0)');
    sql.Add('       or ("WastePC" <> 0)');
    sql.Add('       or ("Wastage" <> 0))');
    execSQL;

    // for Locations OpStk is meant to show the Location Audit Count of the previous stock
    // for the same Row ID (as long as there is the same Product-Unit).

    close;
    sql.Clear;
    sql.Add('update auditLocationscur set opstk = 0 where LocationID > 0 and LocationID < 999 and opstk <> -888888');
    execSQL;

    close;
    sql.Clear;
    sql.Add('Update AuditLocationsCur set OpStk = a.ActCloseStk');
    sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and a.RecId = b.RecId');
    sql.Add('and a.LocationId = b.LocationId and a.LocationID < 999');
    sql.Add('and a.Unit = b.Unit');
    sql.Add('AND a."StkCode" = '+IntToStr(StkCode - 1));
    sql.Add('and a.tid = '+IntToStr(curtid));
    execSQL;

    // markup records to be visible in Complete Site if the Product is in any Location List.
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ShouldBe = 0');
    sql.Add('from (select distinct EntityCode from auditLocationscur where LocationID > 0 and LocationID < 999) a');
    sql.Add('where (auditLocationscur.LocationID = 0) and (auditLocationscur.entitycode = a.EntityCode)');
    execSQL;

    // empty ThRed if PrepItem
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set thredqty = NULL where PurchStk = -999999');
    execSQL;

    // fill Wastage with -999999 if PrepItem for Locations only...
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set Wastage = -999999 where PurchStk = -999999');
    sql.Add('  and LocationID > 0 and LocationID < 999');
    execSQL;

    // should we have Must Count Items?
    if (not curFillClose) and curAutoFillBlankCounts and curUseMustCountItems then
    begin
      // is there a Must Count Template assigned to this site?
      // if it is, are there products in it for this Stock (because Division...)? If so, mark them
      close;
      sql.Clear;
      sql.Add('update auditLocationscur set MustCount = 1 ');
      sql.Add('from auditLocationscur a,                  ');
      sql.Add('   (select i.ProductID            ');
      sql.Add('    from (select * from stkMustCountTemplateSites where SiteCode = ' +
                          inttostr(theSiteCode) +') s   ');
      sql.Add('    join stkMustCountItems i on s.TemplateID = i.TemplateID where i.Deleted = 0) b');
      sql.Add('where a.EntityCode = b.ProductID   ');
      execSQL;
    end;
  end;
  log.event('Leaving Data1.GenerateCurrentStockAuditLocationFigures');
end;

procedure Tdata1.GenerateCurrentStockAuditFigures(load, tryImport: boolean);
var
  cpyStkCode, cpyTid : integer;
  s1 : string;
begin
  log.event('In Data1.GenerateCurrentStockAuditFigures');
  dmAdo.EmptySQLTable('auditcur');

  with data1.adoqRun do
  begin
    if curACSnp and (theStage < 3) then // calc Theo Nom Prices and get them into AuditCur...
    begin
      // CALCULATE Nom Prices from Theoretical figures
      if data1.curByHZ then s1 := '1, ' else s1 := '0, ';
      if data1.ssDebug then s1 := s1 + '1' else s1 := s1 + '0';

      dmRunSP := TdmRunSP.Create(self);
      with dmRunSP do
      begin
        //spConn.ConnectionString := dmADO.AztecConn.ConnectionString;
        spConn.Open;

        with adoqRunSP do
        begin
          close;
          sql.Clear;
          sql.Add('exec stkSP_NomPriceForAudit ' + s1);
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
              showMessage('ERROR Calculating Retail Cost and Nominal Prices!' + #13 +
                'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
              exit;
            end;
          end;
        end;
        spConn.Close;
      end;
      dmRunSP.Free;
    end;

    close;
    sql.Clear;
    sql.Add('insert into auditcur (hzid, "entitycode", "name", "subcat",');
    sql.Add('"ImpExRef", OpStk, PurchStk, ThRedQty, ThCloseStk, "purchunit",');
    sql.Add('"purchbaseU", [wastetill], [wastetillA], [wastepc], [wastepcA],');
    if curACSnp then
      sql.Add('[wastage], moveqty, ShouldBe, PurchCostPU, NomPricePU)')
    else
      sql.Add('[wastage], moveqty, ShouldBe, PurchCostPU)');

    sql.Add('SELECT a.hzid, b."entitycode",');

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
    sql.Add('    WHEN ((a."key2" = 66) or (a."key2" = 1066)) THEN -777777'); // NEW HZ Items
    sql.Add('    ELSE (a."OpStk" / a."purchbaseU")');                        // NORMAL items
    sql.Add('  END) as OpStk,');

    sql.Add(' (CASE ');
    sql.Add('    WHEN (a."key2" < 1000) THEN (a."PurchStk" / a."purchbaseU")'); // NORMAL items
    sql.Add('    ELSE -999999');                                                // 17841 - Prep.Items
    sql.Add('  END) as PurchStk,');

    sql.Add('(a."ThRedQty" / a."purchbaseU") as ThRedQty,');
    sql.Add('(a."ThCloseStk" / a."purchbaseU") as ThCloseStk,');
    sql.Add('a."purchunit", a."purchbaseU", (a.[wastetill] / a."purchbaseU"),');
    sql.Add('(a.[wastetillA] / a."purchbaseU"), (a.[wastepc] / a."purchbaseU"),');
    sql.Add('(a.[wastepcA] / a."purchbaseU"), (a.[wastage] / a."purchbaseU"), ');

    if curACSnp then // if stage is 3 or 4 then we already have nominal prices so use them...
      sql.Add('(a.[moveqty] / a."purchbaseU"), 1, ' +
                 '(a."PurchCost" * a."purchbaseU"), (a."nomprice" * a."purchbaseU")')
    else
      sql.Add('(a.[moveqty] / a."purchbaseU"), 1, (a."PurchCost" * a."purchbaseU")');

    sql.Add('FROM "StkCrDiv" a, "stkEntity" b');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    execSQL;

    // if Theo NomPrices were calculated now delete them so they don't interfere with proper Nom Prices...
    if curACSnp and (theStage < 3) then
    begin
      close;
      sql.Clear;
      sql.Add('update stkcrdiv set nomprice = 0');
      execSQL;
    end;


    if load then
    begin
      close;
      sql.Clear;
      sql.Add('Update AuditCur ');
      sql.Add('set ActCloseStk = CASE a.CloseStkAutofilled WHEN 1 THEN NULL ELSE a.ActCloseStk END,');
      sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
      sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
      sql.Add('FROM "Auditcur" b, "Audit" a');
      sql.Add('WHERE a."entitycode" = b."entitycode"');
      sql.Add('and a.hzid = b.hzid');
      sql.Add('AND a."StkCode" = '+IntToStr(StkCode));
      sql.Add('and tid = '+IntToStr(curtid));
      cpyTid := execSQL; // pre-use cpyTid as a simple counter...

      if cpyTid > 0 then
      begin
        close;
        sql.Clear;
        sql.Add('select * from AuditCur');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('ActCloseStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);

          post;
          next;
        end;
      end;
      cpyTid := 0; // reset cpyTid to a neutral value...
    end;


    if tryImport then
    begin
      //==========================================================================================
      // try to detect an accepted stock in another thread but same division that has the same
      // End date/end time as this one. If yes offer to import its audit counts (the ones that fit)...
      // also it has to have the same byHZ (True/False) as the current one...

      close;
      sql.Clear;
      sql.Add('select a.stockcode, a.tid, a.sdate, a.stime, a.accdate, b.TName');
      sql.Add('from stocks a, threads b where a.[division] = ' + quotedStr(data1.TheDiv));
      sql.Add('and abs(CAST(a.edt - ' + quotedstr(formatDateTime('yyyymmdd hh:nn', data1.EDT)) +
             ' AS FLOAT)) <= 0.000694444');
      sql.Add('and a.stockcode > 1');
      sql.Add('and a.tid = b.tid');
      if curByHZ then
        sql.Add('and a.byHZ = 1')
      else
        sql.Add('and a.byHZ = 0');
      sql.Add('order by b.Tname');
      open;

      if RecordCount > 0 then
      begin
        cpystkcode := 0;

        if recordcount = 1 then
        begin
          if MessageDlg('The system has detected an accepted '+ data1.sslow + ' for Division '+
              '"' + data1.TheDiv + '" that has the same End Date/Time as this '+ data1.sslow + '.'+#13+
              'THREAD: "' + FieldByName('tname').asstring + '"; Start Date: "' +
              formatDateTime('ddddd', FieldByName('Sdate').asdatetime) +
              '"; Accepted Date: "' + formatDateTime('ddddd', FieldByName('accdate').asdatetime) + '" ' +
              #13+''+#13+ 'The Closing '+ data1.SSbig + ' figures of that '+ data1.sslow +
              ' can be imported into the Audit Counts.' + #13 +
              'This would overwrite any Audit Counts you may have previously typed in.'+#13+''+#13+
              'Do you want to import these figures?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
          begin
            cpystkcode := FieldByName('stockcode').AsInteger;
            cpytid := FieldByName('tid').AsInteger;
          end;
        end
        else
          GetStockToCopy(cpystkcode, cpytid);

        if cpyStkCode <> 0 then
        begin
          close;
          sql.Clear;
          sql.Add('Update AuditCur set ActCloseStk = (a."ActCloseStk" / a."purchbaseU")');
          sql.Add('FROM "Auditcur" b, "StkMain" a');
          sql.Add('WHERE a."entitycode" = b."entitycode"');
          sql.Add('AND a."StkCode" = '+IntToStr(cpyStkCode));
          sql.Add('and tid = '+IntToStr(cpytid));
          sql.Add('and a.hzid = b.hzid');
          execSQL;

          close;
          sql.Clear;
          sql.Add('select * from AuditCur');
          open;

          while not eof do
          begin
            //import the floats in the string field
            edit;
            if FieldByName('ActCloseStk').asstring = '' then
              FieldByName('ACount').AsString := ''
            else
              FieldByName('ACount').AsString :=
                data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
            post;
            next;
          end;
          close;
        end;

      end;
      close;
      //========================================================================================
    end;

    // 357774 - for PrepItems find out if any of their Parent Recipes were sold and if yes then the Prep Item
    //          should be visible on the Audit Grid...
    if IncludePrepItemsInAudit then
    begin
      close;
      sql.Clear;
      sql.Add('update auditcur set ThRedQty = sq.theCount');
      sql.Add('from');
      sql.Add('  (select sq1.Child, COUNT (DISTINCT t.Parent) as TheCount ');
      sql.Add('   from (select s1.* from ');
      sql.Add('     (select * from auditcur a where PurchStk = -999999) ac ');
      sql.Add('     inner join ');
      sql.Add('     (select r.Child, r.Parent from stk121Rcp r where r.Ctype = ''P'' and r.Ptype is NULL) s1 ');
      sql.Add('     on ac.EntityCode = s1.Child) sq1');
      sql.Add('   inner join stkTRtemp t on t.Parent = sq1.Parent');
      sql.Add('   group by Child  ) sq');
      sql.Add('where auditcur.entitycode = sq.Child');
      execSQL;
    end;

    // markup records depending if they should be there or not based on open/purch/move/sold/waste/thclose
    close;
    sql.Clear;
    sql.Add('update auditcur set ShouldBe = 0');
    sql.Add('where (   ("OpStk" <> 0)');
    sql.Add('       or ("MoveQty" <> 0)');
    sql.Add('       or (("PurchStk" <> 0) and ("PurchStk" <> -999999))');
    sql.Add('       or ("ThRedQty" <> 0)');
    sql.Add('       or ("ThCloseStk" <> 0)');
    sql.Add('       or ("WasteTill" <> 0)');
    sql.Add('       or ("WastePC" <> 0)');
    sql.Add('       or ("Wastage" <> 0))');
    execSQL;

    // for HZs only...
    if curByHZ then
    begin
      dmADO.DelSQLTable('#ghost');
      close;
      sql.Clear;
      sql.Add('update auditcur set shouldbe = 2');
      sql.Add('from');
      sql.Add('  (select a.entitycode from auditcur a where a.hzid = 0 and a.shouldbe = 0) sq');
      sql.Add('where auditcur.hzid > 0 and auditcur.shouldbe = 1 and auditcur.entitycode = sq.entitycode');
      execSQL;
    end;

    // empty ThRed if PrepItem
    close;
    sql.Clear;
    sql.Add('update auditcur set thredqty = NULL where PurchStk = -999999');
    execSQL;

    // should we have Must Count Items?
    if (not curFillClose) and curAutoFillBlankCounts and curUseMustCountItems then
    begin
      // is there a Must Count Template assigned to this site?
      // if it is, are there products in it for this Stock (because Division...)? If so, mark them
      close;
      sql.Clear;
      sql.Add('update auditcur set MustCount = 1 ');
      sql.Add('from auditcur a,                  ');
      sql.Add('   (select i.ProductID            ');
      sql.Add('    from (select * from stkMustCountTemplateSites where SiteCode = ' +
                          inttostr(theSiteCode) +') s   ');
      sql.Add('    join stkMustCountItems i on s.TemplateID = i.TemplateID where i.Deleted = 0) b');
      sql.Add('where a.EntityCode = b.ProductID   ');
      execSQL;
    end;
  end;
  log.event('Leaving Data1.GenerateCurrentStockAuditFigures');
end; // procedure..

function Tdata1.FinishStk(newStk: boolean) : boolean;
begin
  fStkMisc := TfStkMisc.Create(self);
  fStkMisc.newStk := newStk;
 	if fStkMisc.ShowModal = mrOK then
    Result := True
  else
    Result := False;
 	fStkMisc.Free;
end; // procedure..

procedure TData1.PushStkMain;
begin
 with adoqRun do
 begin
    close;
    sql.Clear;
    sql.Add('DELETE FROM "StkMain"');
    sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    ExecSQL;

   close;
   sql.Clear;
   sql.Add('Insert INTO stkMain ("EntityCode","Key2","OpStk","OpCost","PurchStk",');
   sql.Add('    "PurchCost","ThRedQty","ThRedCost","ThCloseStk",');
   sql.Add('    "ThCloseCost","ActRedQty","ActRedCost","ActCloseStk",');
   sql.Add('    "ActCloseCost","PrepRedQty","PurchUnit",');
   sql.Add('    "PurchBaseU","StdBaseSize","NomPrice","VatRate","Yield",');
   sql.Add('    SiteCode, "TheoPrice", StkCode, "GP","COS%", "lossgain", "tid",');
   sql.Add('    [wastetill], [wastetillA], [wastepc], [wastepcA], [wastage],');
   sql.Add('    [soldqty], [auditstk], hzid, moveqty, movecost, OpenPrep, ClosePrep, TrueRedCost)');
   sql.Add('SELECT a."EntityCode",a."Key2",a."OpStk",a."OpCost",a."PurchStk",');
   sql.Add('isNULL(a."PurchCost", 0),a."ThRedQty",a."ThRedCost",a."ThCloseStk",');
   sql.Add('a."ThCloseCost",a."ActRedQty",isNULL(a."ActRedCost", 0),a."ActCloseStk",');
   sql.Add('isNULL(a."ActCloseCost", 0),a."PrepRedQty",a."PurchUnit",');
   sql.Add('a."PurchBaseU",a."StdBaseSize",a."NomPrice",a."VatRate",a."Yield",');
   sql.Add('('+IntToStr(data1.TheSiteCode)+') as SiteCode, a."TheoPrice",');
   sql.Add('('+IntToStr(data1.StkCode)+') as StkCode, a."GP",a."COS%", a."lossgain",');
   sql.Add('('+IntToStr(data1.curtid)+') as curtid,');
   sql.Add('    [wastetill], [wastetillA], [wastepc], [wastepcA], [wastage],');
   sql.Add('    [soldqty], [auditstk], hzid, moveqty, movecost, OpenPrep, ClosePrep, TrueRedCost');
   sql.Add('FROM "StkCrDiv" a');
   ExecSQL;

 end;
 log.event('Data1.PushStkMain done');
end; // procedure..

procedure TData1.PushPrepared;
begin
 with adoqRun do
 begin
    close;
    sql.Clear;
    sql.Add('DELETE FROM PreparedItemSplit');
    sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
    sql.Add('and ThreadID = '+IntToStr(data1.curtid));
    ExecSQL;

   close;
   sql.Clear;
   sql.Add('Insert INTO PreparedItemSplit ([SiteCode], [ThreadID], [StockCode],');
   sql.Add(' [HoldingZoneID], [PreparedItem], [Ingredient],');
   sql.Add(' [BatchUnit], [BatchSize], [Ratio], [OpenSplit], [CloseSplit], [Adjustment], [LMDT])');
   sql.Add('SELECT '+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',');
   sql.Add(''+IntToStr(data1.StkCode)+', hzid, [PreparedItem], [Ingredient],');
   sql.Add('[BatchUnit], [BatchSize], [Ratio], [OpenSplit], [CloseSplit], [Adjustment], GetDate()');
   sql.Add('FROM [#PreparedItemSplit]');
   ExecSQL;
 end;
end; // procedure..


procedure TData1.PushStkSold;
begin
  with adoqRUn do
  begin
    close;
    sql.Clear;
    sql.Add('DELETE FROM "StkSold"');
    sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    ExecSQL;

   close;
   sql.Clear;
   sql.Add('Insert INTO stkSold ("EntityCode", "ProductType", Portion,');
   sql.Add('       "StdBaseSize", "SalesQty", "Income", "AvSalesPrice",');
   sql.Add('       "TheoPrice", "Faults", "TheoCost", "IngPrice",');
   sql.Add('       "ActCost", "AvVATCost", "VATRate", "RcpCost", "GP",');
   sql.Add('       SiteCode, StkCode, "COS%", tid, hzid)');
   sql.Add('SELECT a."EntityCode", a."ProductType", Portion,');
   sql.Add('a."StdBaseSize", a."SalesQty", a."Income", a."AvSalesPrice",');
   sql.Add('a."TheoPrice", a."Faults", a."TheoCost", a."IngPrice",');
   sql.Add('a."ActCost", a."AvVATCost", a."VATRate", a."RcpCost", a."GP",');
   sql.Add('('+IntToStr(data1.TheSiteCode)+') as SiteCode,');
   sql.Add('('+IntToStr(data1.StkCode)+') as StkCode, a."COS%",');
   sql.Add('('+IntToStr(data1.curtid)+') as curtid, a.hzid');
   sql.Add('FROM "StkCrSld" a');
   execSQL;

    close;
    sql.Clear;
    sql.Add('DELETE FROM "stkSoldChoice"');
    sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    ExecSQL;

   close;
   sql.Clear;
   sql.Add('Insert INTO stkSoldChoice (hzid, EntityCode, Portion, [ProductType], [SalesQty],');
   sql.Add('    [Income], [AvSalesPrice], [TheoCost], [ActCost], [VATRate], choice,');
   sql.Add('    SiteCode, StkCode, tid)');
   sql.Add('SELECT hzid, EntityCode, Portion, [ProductType], [SalesQty],');
   sql.Add('    [Income], [AvSalesPrice], [TheoCost], [ActCost], [VATRate], choice,');
   sql.Add('('+IntToStr(data1.TheSiteCode)+') as SiteCode,');
   sql.Add('('+IntToStr(data1.StkCode)+') as StkCode,');
   sql.Add('('+IntToStr(data1.curtid)+') as curtid');
   sql.Add('FROM "StkCrSldChoice"');
   execSQL;
  end;
end; // procedure..

// To recognize dozens:
// Use the purchase unit. Convert to upper case.
// If the string = 'DOZEN' is found anywhere in the name AND the "Base Units" field
// in table "Units" for that unit is 12, then we have a Dozen to format.
function Tdata1.isDozen(theUnit: string): boolean;
begin
  Result := false;                                      // 17701 - check if Dozens format is
  if (not(data1.curdozForm)) or (theDoz.Count = 0) then // set = Y for current Thread
    exit;

  if theDoz.IndexOf(theUnit) <> -1 then
    Result := true;
end;

procedure Tdata1.DataModuleDestroy(Sender: TObject);
begin
  theDoz.Free;
end;

procedure Tdata1.SetPrinterSize(prs: string);
Var
  papNames : TStringList;
  s1, s2 : string;
  i : integer;
  rep : TppReport;
begin

  papNames := TStringList.Create;

  rep := TppReport.Create(self);
  papNames.Text := rep.PrinterSetup.PaperNames.Text;
  rep.Free;

  s2 := prs;
  for i := 0 to (papnames.Count - 1) do
  begin
    s1 := papnames[i];

    if pos(uppercase(s2), uppercase(s1)) > 0 then
    begin
      s2 := s1;
      break;
    end;

  end; // for..

  data1.repPaperName := s2;
  papNames.Free;
end;

function Tdata1.UserAllowed(theTid, thePermID: integer): boolean;
begin
  if CurrentUser.IsZonalUser then
    Result := True
  else
  begin
    if theTid = -1 then // do you have "thePermID" right for at least one Thread?
    begin
      Result := adoqSecure.locate('permID;PermSet', VarArrayOf([thePermID, 'Y']), []);
    end
    else  // do you have "thePermID" right for the "theTid" thread?
    begin
      Result := adoqSecure.locate('tid;permID;PermSet', VarArrayOf([theTid, thePermID, 'Y']), []);
    end;
  end;
end; // procedure..


function Tdata1.isGallon(theUnit: string): boolean;
begin
  Result := ((curGallForm) and (upperCase(theUnit) = 'GALLON'));
end;

function Tdata1.dozGallFloatToStr(theUnit: string; theValue: real): string;
var
  d,u : integer;
  decd : real;
  Text : string;
begin
  // first assume simple float; if not special unit or if some error this is the return...
  Text := formatfloat('0.##', theValue);
  Result := Text;

  // format dozens...
  if data1.isDozen(theUnit) then
  begin
    try // in case the text is wrong just leave it as it is
      decd := theValue;
      d := trunc(decd); // full dozens
      u := round(12 * (decd - d)); // units of a dozen
      // check validity just in case...
      if (u < -11) or (u > 11) then
      begin
        if u = 12 then
        begin
          u := 0;
          d := d + 1;
        end
        else if u = -12 then
        begin
          u := 0;
          d := d - 1;
        end
        else
        begin
          exit;
        end;
      end;

      if (d = 0) and (u < 0) then
      begin
        Text := '-0' + data1.dozgalchar + inttostr(abs(u));
      end
      else
      begin
        Text := inttostr(d) + data1.dozgalchar + inttostr(abs(u)); // use abs to show units without the "-" sign
      end;                                            // as if negative the dozens will have the sign
    except
      // do nothing
    end;
  end
  else if data1.isGallon(theUnit) then
  begin
    try // in case the text is wrong just leave it as it is
      decd := theValue;

      d := trunc(decd); // full gallons

      u := round(8 * (decd - d)); // pints
      // check validity just in case...
      if (u < -7) or (u > 7) then
      begin
        if u = 8 then
        begin
          u := 0;
          d := d + 1;
        end
        else if u = -8 then
        begin
          u := 0;
          d := d - 1;
        end
        else
        begin
          exit;
        end;
      end;

      if (d = 0) and (u < 0) then
      begin
        Text := '-0' + data1.dozgalchar + inttostr(abs(u));
      end
      else
      begin
        Text := inttostr(d) + data1.dozgalchar + inttostr(abs(u)); // use abs to show units without the "-" sign
      end;                                            // as if negative the dozens will have the sign
    except
      // do nothing
    end;
  end;

  // in case formatting was applied...
  Result := Text;

end;

function Tdata1.dozGallStrToFloat(theUnit, theText: string): real;
var
  d,u,p, sign : integer;
  decd : double;
begin

  if isDozen(theUnit) then
  begin
    try // in case the text is wrong just return 0
      // get the sign, is there "-" as the first character?
      sign := 1;
      if theText[1] = '-' then
      begin
        sign := -1;
        theText := copy(theText, 2, length(theText)); // eliminate the "-"
      end;

      // is there a "/" ?
      p := pos(data1.dozgalchar, theText);

      if p = 0 then
      begin // full dozens only...
        decd := strtofloat(theText);
      end
      else
      begin
        // get the dozens
        if  p = 1 then
          d := 0
        else
          d := strtoint(copy(theText, 1, p - 1));

        // get the units
        u := strtoint(copy(theText, p + 1, 2));
        decd := d + (u / 12);
      end;

      Result := sign * decd;
    except
      Result := 0;
    end;
  end
  else if isGallon(theUnit) then
  begin
    try // in case the text is wrong just return 0
      // get the sign, is there "-" as the first character?
      sign := 1;
      if theText[1] = '-' then
      begin
        sign := -1;
        theText := copy(theText, 2, length(theText)); // eliminate the "-"
      end;

      // is there a "/" ?
      p := pos(data1.dozgalchar, theText);

      if p = 0 then
      begin // full gallons only...
        decd := strtofloat(theText);
      end
      else
      begin
        // get the gallons
        if  p = 1 then
          d := 0
        else
          d := strtoint(copy(theText, 1, p - 1));

        // get the pints
        u := strtoint(copy(theText, p + 1, 2));
        decd := d + (u / 8);
      end;

      Result := sign * decd;
    except
      Result := 0;
    end;
  end
  else   // "Normal" units
  begin
    try // in case the text is wrong just return 0
      Result := strtofloat(theText);
    except
      Result := 0;
    end;
  end;
end;

function Tdata1.fmtRepQtyText(theUnit, Text: string): string;
var
  d,u : integer;
  decd : real;
begin
  // to begin with function return is set to original text then
  // the need for "special" formats is tested and applied if required...
  Result := Text;

  // format dozens...
  if isDozen(theUnit) then
  begin
    try // in case the text is wrong just leave it as it is
      decd := strtofloat(Text);
      d := trunc(decd); // full dozens
      u := round(12 * (decd - d)); // units of a dozen
      // check validity just in case...
      if (u < -11) or (u > 11) then
      begin
        if u = 12 then
        begin
          u := 0;
          d := d + 1;
        end
        else if u = -12 then
        begin
          u := 0;
          d := d - 1;
        end
        else
        begin
          exit;
        end;
      end;

      if (d = 0) and (u < 0) then
      begin
        Text := '-0' + data1.dozgalchar + inttostr(abs(u));
      end
      else
      begin
        Text := inttostr(d) + data1.dozgalchar + inttostr(abs(u)); // use abs to show units without the "-" sign
      end;                                            // as if negative the dozens will have the sign
    except
      // do nothing
    end;
  end
  else if data1.isGallon(theUnit) then
  begin
    try // in case the text is wrong just leave it as it is
      decd := strtofloat(Text);

      d := trunc(decd); // full gallons

      u := round(8 * (decd - d)); // pints
      // check validity just in case...
      if (u < -7) or (u > 7) then
      begin
        if u = 8 then
        begin
          u := 0;
          d := d + 1;
        end
        else if u = -8 then
        begin
          u := 0;
          d := d - 1;
        end
        else
        begin
          exit;
        end;
      end;

      if (d = 0) and (u < 0) then
      begin
        Text := '-0' + data1.dozgalchar + inttostr(abs(u));
      end
      else
      begin
        Text := inttostr(d) + data1.dozgalchar + inttostr(abs(u)); // use abs to show units without the "-" sign
      end;                                            // as if negative the dozens will have the sign
    except
      // do nothing
    end;
  end;

  // in case formatting was applied...
  Result := Text;
end;

function Tdata1.setGridMask(theUnit, curMask: string): string;
begin
  if isDozen(theUnit) then
  begin
    Result := #9'{{{#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,' +
        '8,9}]},' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,8,9,10,11}}}'#9'F'#9'T';
  end
  else if isGallon(theUnit) then
  begin
    Result := #9'{{{#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7}]},' + data1.dozgalchar +
         '{0,1[{0,1}],2,3,4,5,6,7}}}'#9'F'#9'T';
  end
  else
  begin
    Result := #9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T';
  end;
end;


procedure TData1.killStock(TIDtoKill, StkToKill: integer);
begin
  log.event('Trying to Kill Stock - Tid: ' + IntToStr(TIDtoKill) + ' Code: ' + IntToStr(StkToKill));
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('DECLARE @Tid int, @Stk int');
    sql.Add('SET @Tid = '+IntToStr(TIDtoKill));
    sql.Add('SET @Stk = '+IntToStr(StkToKill));
    sql.Add('   ');
    sql.Add('DELETE FROM StkMain WHERE StkCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM StkSold WHERE StkCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM StkSoldChoice WHERE StkCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM Audit WHERE StkCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM StkMisc WHERE StockCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM CurStock WHERE StockCode = @Stk AND tid = @Tid ');
    sql.Add('   ');
    sql.Add('DELETE FROM Stocks WHERE StockCode = @Stk AND tid = @Tid ');
    ExecSQL;
    log.event('Stock Killed - Tid: ' + IntToStr(TIDtoKill) + ' Code: ' + IntToStr(StkToKill));
  end;
end;

procedure TData1.HoldRepQuery (repHZidStr: string; var theQ: TADOQuery);
begin
  with theQ do
  begin
    close;
    sql.Clear;

    if data1.RepHdr = 'Sub-Category' then
      sql.Add('SELECT b.hzid, (a.[SCat]) as SubCatName, a.entitycode,')
    else
      sql.Add('SELECT b.hzid, (a.[Cat]) as SubCatName, a.entitycode,');
    sql.Add('(CASE');
    sql.Add('   WHEN (b.key2 < 1000) THEN a.purchasename');
    sql.Add('   ELSE a.retailname');
    sql.Add('END) as purchasename2,');
    sql.Add('b.PurchUnit,');
    sql.Add('(b.OpStk / b.PurchBaseU) as opstk,');
    sql.Add('((b.PurchStk/ b.PurchBaseU) + (b.moveQty / b.PurchBaseU)) as purchStk,');
    sql.Add('(b.PurchStk/ b.PurchBaseU) as truePurch,');
    sql.Add('(b.moveQty / b.PurchBaseU) as trueMove,');
    sql.Add('(b.Wastage / b.PurchBaseU) as FaultRedQty,');
    sql.Add('(b.ActCloseStk / b.PurchBaseU) as actclosestk,');
    sql.Add('(b.ActRedQty / b.PurchBaseU) as ActRedQty,');
    sql.Add('((b.SoldQty + b.Wastage) / b.PurchBaseU) as ThRedQty,');
    sql.Add('(b.PrepRedQty / b.PurchBaseU) as PrepRedQty,');
    sql.Add('(b.ActRedQty * b.NomPrice) as consVal,');
    sql.Add('((opStk * opCost) + (PurchStk * purchCost) - ' +
            '    (ActCloseStk * ActCloseCost) + (moveQty * moveCost)) as TotConsCst,');
    sql.Add('(b.ActCloseStk * b.ActCloseCost) as stkVal,');
    sql.Add('((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b.PurchBaseU) as VarStk,');

    sql.Add('(CASE WHEN (ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost)');
    sql.Add('       THEN ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.TrueRedCost)');
    sql.Add('  ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.ActRedCost)');
    sql.Add(' END)  as VarCost,');

    sql.Add('((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice) as VarVal,');
    sql.Add('(CASE');
    sql.Add('  WHEN ((b.ActRedQty + b.PrepRedQty) = 0) ' +
             ' OR ((ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost)) THEN 100');
    sql.Add('  ELSE (b.SoldQty / (b.ActRedQty + b.PrepRedQty) * 100)');
    sql.Add('END) as Yield,');
    if data1.curIsGP then
      sql.Add('(100 - b."COS%") as exGP,')
    else
      sql.Add('(b."COS%") as exGP,');
    sql.Add('(CASE');
    sql.Add('  when b."ActRedQty" = 0 then NULL');
    sql.Add('  else (b."ActCloseStk" / b."ActRedQty")');
    sql.Add('END) as hand,');
    sql.Add('b."key2", b.TheoPrice, (b.purchstk - b.actclosestk) as purConsBase, b.purchcost,');
    sql.Add('b.OpenPrep, b.ClosePrep');
    sql.Add('FROM "stkEntity" a, "StkCrDiv" b');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and ((b."OpStk" <> 0) or (b."PurchStk" <> 0) or (b."actCloseStk" <> 0) or');
    sql.Add('  ((b."soldQty" <> 0) and (b."key2" < 1000)) or (b."Wastage" <> 0) or');
    sql.Add('   (b."PrepRedQty" <> 0) or (b.purchcost <> 0) or (b."MoveQty" <> 0))');
    sql.Add('and b.hzid = ' + repHZidStr);
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('Order By a.[SCat], purchasename2')
    else
      sql.Add('Order By a.[Cat], purchasename2');
  end;
end;

function TData1.SPQuery(repHZidStr: string): integer;
begin
  dmADO.DelSQLTable('#sp');

  with adoqRun do
  begin
    close;
    sql.Clear;
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('SELECT b.hzid, (a.[SCat]) as SubCatName, a.entitycode,')
    else
      sql.Add('SELECT b.hzid, (a.[Cat]) as SubCatName, a.entitycode,');
    sql.Add('a."RetailName", b.portion, p.portiontypename, b."salesqty", ');
    sql.Add('b."avSalesPrice", b."theocost", b."actCost",');
    sql.Add('(CASE b.producttype WHEN ''R'' THEN 1 ELSE 0 END) as producttype,');
    if data1.curIsGP then
    begin
      sql.Add('(CASE');
      sql.Add('  WHEN b."income" = 0 then 0');
      sql.Add('  ELSE (1- (b."TheoCost" * b."salesqty" / (b."Income" - b."vatRate"))) * 100');
      sql.Add(' END) as ThGpP,');
      sql.Add('(CASE');
      sql.Add('  WHEN b."income" = 0 then 0');
      sql.Add('  ELSE (1- (b."ActCost" * b."salesqty" / (b."Income" - b."vatRate"))) * 100');
      sql.Add(' END) as ActGpP,');
    end
    else
    begin
      sql.Add('(CASE');
      sql.Add('  WHEN b."income" = 0 then 0');
      sql.Add('  ELSE (b."TheoCost" * b."salesqty" / (b."Income" - b."vatRate")) * 100');
      sql.Add(' END) as ThGpP,');
      sql.Add('(CASE');
      sql.Add('  WHEN b."income" = 0 then 0');
      sql.Add('  ELSE (b."ActCost" * b."salesqty" / (b."Income" - b."vatRate")) * 100');
      sql.Add(' END) as ActGpP,');
    end;
    sql.Add('b."Income",');
    sql.Add('((b."Income" - b."vatRate") - (b."ActCost" * b."salesqty")) as GrossProf,');
    sql.Add('(b."TheoCost" * b."salesqty") as ThVal,');
    sql.Add('(b."ActCost" * b."salesqty") as ActVal,');
    sql.Add('(b."Income" - b."vatRate") as NetInc,');
    sql.Add('(CASE');
    sql.Add('   WHEN (b."TheoCost" = 0) AND (b."ActCost" = 0) THEN (b."income")');
    sql.Add('   ELSE 0');
    sql.Add('END) as rcpVar, a."purchaseunit", 0 as choices');

    sql.Add('INTO [#sp]');

    sql.Add('FROM stkEntity a, "StkCrSld" b, [portiontype] p');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and ((b."producttype" not like ''X%'' and b."producttype" not like ''Z'')');
    sql.Add('     or b."producttype" is null)');
    sql.Add('and b.hzid = ' + repHZidStr);
    sql.Add('and p.portiontypeid = b.portion');

    Result := execSQL;
  end;
end;

procedure Tdata1.LGRepQuery(repHZidStr: string; var theQ: TADOQuery);
begin
  with theQ do
  begin
    close;
    sql.Clear;
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('SELECT (a.[SCat]) as SubCatName, a."PurchaseName", b."PurchUnit",')
    else
      sql.Add('SELECT (a.[Cat]) as SubCatName, a."PurchaseName", b."PurchUnit",');
    sql.Add('(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU" as q,');
    sql.Add('(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice as v,');
    sql.Add('(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.ActRedCost as c,');
    sql.Add('((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU") as sq,');
    sql.Add('(-1 * (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU") as dq,');
    sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) +');
    sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / 2) * b.NomPrice) as sv,');
    sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) +');
    sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / 2) * b.ReductionCost) as sc,');
    sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) -');
    sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / -2) * b.NomPrice) as dv,');
    sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) -');
    sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / -2) * b.ReductionCost) as dc,');
    sql.Add('(CASE WHEN (b.ActRedQty = 0) ' +
             ' OR ((ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost)) THEN NULL');
    sql.Add('  ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b.ActRedQty * 100)');
    sql.Add('END) as spc,');
    sql.Add('(b."wastage" / b."PurchBaseU") as Wq,');
    sql.Add('(b."wastage" * b.ReductionCost) as Wc,');
    sql.Add('(b."wastage" * b."NomPrice") as Wv,');
    sql.Add('(CASE WHEN (b.ActRedQty = 0) ' +
             ' OR ((ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost)) THEN NULL');
    sql.Add('  ELSE (b."wastage" / b.ActRedQty * 100)');
    sql.Add('END) as Wpc,');
    sql.Add('((b.SoldQty - b.ActRedQty - b.PrepRedQty) * b.NomPrice) as totv,');
    sql.Add('((b.SoldQty - b.ActRedQty - b.PrepRedQty) * b.ReductionCost) as totc,');
    sql.Add('(CASE WHEN ((b.ActRedQty + b.PrepRedQty) = 0) ' +
             ' OR ((ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost)) THEN 100');
    sql.Add('  ELSE (b.SoldQty / (b.ActRedQty + b.PrepRedQty) * 100)');
    sql.Add('END) as Yield');
    sql.Add('FROM stkEntity a, ');
    sql.Add(' (SELECT [HzID], [EntityCode], [Key2], [SoldQty],  [ActRedQty], [Wastage], [PrepRedQty], ');
    sql.Add('     [PurchUnit], [PurchBaseU], [NomPrice], [PurchStk], [PurchCost], [ActRedCost], ');
    sql.Add('     CASE WHEN (ActRedQty = 0.00001) and (PurchStk = 0.00001) and (ActRedCost = PurchCost) ');
    sql.Add('            THEN [TrueRedCost] ELSE [ActRedCost] END as ReductionCost ');
    sql.Add('  FROM StkCrDiv ');
    sql.Add('  WHERE ((ABS((SoldQty + Wastage - ActRedQty - PrepRedQty) / PurchBaseU) >= 0.001) or (ABS(wastage) >= 0.001)) ');
    sql.Add('  and key2 < 1000  and hzid = ' + rephzidStr + ') b ');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('Order By a.[SCat], a."PurchaseName"')
    else
      sql.Add('Order By a.[Cat], a."PurchaseName"');
  end;
end;

procedure Tdata1.doStkEntity;
begin
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('TRUNCATE TABLE stkEntity');
    sql.Add(' ');
    sql.Add('-- first get all items EXCEPT Prep.Items ');
    sql.Add('INSERT stkEntity ([EntityCode], [RetailName], [EntityType], [ETcode], [SCatIx], [CatIx], [DivIx], ');
    sql.Add('  [ImpExRef], [PurchaseName], [PurchaseUnit], [CreationDate], [SR], [SCat], [Cat], [Div]) ');
    sql.Add('SELECT p.[EntityCode], p.[extended RTL name] as "Retail Name", p.[Entity Type], ');
    sql.Add('  CASE p.[Entity Type] ');
    sql.Add('    WHEN ''Menu'' THEN ''M'' ');
    sql.Add('    WHEN ''Purch.Line'' THEN ''G'' ');
    sql.Add('    WHEN ''Recipe'' THEN ''R'' ');
    sql.Add('    WHEN ''Strd.Line'' THEN ''S'' ');
    sql.Add('    ELSE ''Z'' ');
    sql.Add('  END as ETCode, ');
    sql.Add('  s.[index no], s.[category index], c.[division index], p.[Import/Export Reference], ');
    sql.Add('  p.[Purchase Name], p.[Purchase Unit], p.[Creation Date], ');
    sql.Add('  CASE p.[SpecialRecipe] ');
    sql.Add('    WHEN ''Y'' THEN 1 ');
    sql.Add('    WHEN NULL THEN 0 ');
    sql.Add('    ELSE 0 ');
    sql.Add('  END as SR, s.[Sub-Category Name], s.[Category Name], c.[Division Name] ');
    sql.Add('FROM [products] p, [CATEGORY] c, [SUBCATEG] s ');
    sql.Add('WHERE (p.[Sub-Category Name] = s.[Sub-Category Name]) ');
    sql.Add('  AND	  (s.[Category Name] = c.[Category Name]) ');
    sql.Add('  AND (p.[Entity Type] in (''Menu'', ''Purch.Line'', ''Recipe'', ''Strd.Line'')) ');
    sql.Add(' ');
    sql.Add('-- now get all Prep.Items defined for Aztec mode ');
    sql.Add('INSERT stkEntity ([EntityCode], [RetailName], [EntityType], [ETcode], [SCatIx], [CatIx], [DivIx], ');
    sql.Add('  [ImpExRef], [PurchaseName], [PurchaseUnit], [CreationDate], [SR], [SCat], [Cat], [Div]) ');
    sql.Add('SELECT p.[EntityCode], p.[extended RTL name] as "Retail Name", p.[Entity Type], ''P'', ');
    sql.Add('  s.[index no], s.[category index], c.[division index], p.[Import/Export Reference], ');
    sql.Add('  p.[extended RTL name], -- for PrepItems only PurchaseName gets set to [Extended RTL Name]... ');
    sql.Add('  pid.[StorageUnit], p.[Creation Date], ');
    sql.Add('  CASE p.[SpecialRecipe] ');
    sql.Add('    WHEN ''Y'' THEN 1 ');
    sql.Add('    WHEN NULL THEN 0 ');
    sql.Add('    ELSE 0 ');
    sql.Add('  END as SR, s.[Sub-Category Name], s.[Category Name], c.[Division Name] ');
    sql.Add('FROM [products] p, [CATEGORY] c, [SUBCATEG] s, [PreparedItemDetail] pid ');
    sql.Add('WHERE (p.[Sub-Category Name] = s.[Sub-Category Name]) ');
    sql.Add('  AND	  (s.[Category Name] = c.[Category Name]) ');
    sql.Add('  AND (p.[Entity Type] = ''Prep.Item'') ');
    sql.Add('  AND (p.[EntityCode] = pid.[EntityCode]) ');
    sql.Add(' ');
    sql.Add('-- get the base units ');
    sql.Add('update stkEntity set purchbaseu = sq.[base units] ');
    sql.Add('from (select b.[unit name], b.[base units] from Units b) sq ');
    sql.Add('where purchaseunit = sq.[unit name] ');

    sql.Add(' ');
    sql.Add('-- change division in list table due to product-devision change ');

    sql.Add('UPDATE stkLocationLists ');
    sql.Add('SET DivisionID = b.divix ');
    sql.Add('FROM ( SELECT divix , EntityCode FROM stkEntity) AS b ');
    sql.Add('WHERE b.EntityCode = stkLocationLists.EntityCode ');

    execSQL;
  end;
end; // procedure..


// checkWhat: A - ALL; R - 121Rcp; T - TheoRed; L - LC; S - SC
//            the code may contain up to 3 letters (e.g. RLS)
//            but any 'A' present will just do them all
function Tdata1.CheckSPsLocks(checkWhat: string = 'A'): string;
begin
  if pos('A', upperCase(checkWhat)) > 0 then
    checkWhat := 'RTLS'
  else
    checkWhat := upperCase(checkWhat);

  // Return rules:
  // 0. Locks NOT on will return OK (i.e. ROK, TOK, LOK, SOK)
  // 1. If any lock is ON (because the operation is on-going) then
  //    return RON and/or TON, LON, SON followed by space then the lock's lmdt (18 chars always)
  // 2. Stuck Locks return RERR, TERR, followed by space then the lock's lmdt (18 chars always)
  //    note THAT FOR lc AND sc WE DO NOT DIFFERENTIATE between lock ON or stuck so no LERR and SERR
  // 4. Return Values may not be used by the calling code (in all cases)

  Result := '';

  with adoqRun do
  begin
    if pos('R', upperCase(checkWhat)) > 0 then // stk121Rcp lock
    begin
      close;
      sql.Clear;
      sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''EntRcpLck'') = 1');
      sql.Add('  if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..##stkLock_121Rcp_' + dmADO.getDBID + '''))');
      sql.Add('    select ''RON '' + ' +   // the op is on-going
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          ' from stkVarLocal where VarName = ''EntRcpLck'' and VarBit = 1) + ''; ''');
      sql.Add('  else');
      sql.Add('    select ''RERR '' + ' +   // the lock is 'stuck'
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          'from stkVarLocal where VarName = ''EntRcpLck'' and VarBit = 1)  + ''; ''');
      sql.Add('ELSE');
      sql.Add('  select ''ROK ''');
      open;
      Result := Result + Fields[0].AsString;
    end;

    if pos('T', upperCase(checkWhat)) > 0 then // stkTheoRed lock
    begin
      close;
      sql.Clear;
      sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''TheoRedLck'') = 1');
      sql.Add('  if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..##stkLock_TR_' + dmADO.getDBID + '''))');
      sql.Add('    select ''TON '' + ' +   // the op is on-going
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          'from stkVarLocal where VarName = ''TheoRedLck'' and VarBit = 1) + ''; ''');
      sql.Add('  else');
      sql.Add('    select ''TERR '' + ' +   // the lock is 'stuck'
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          'from stkVarLocal where VarName = ''TheoRedLck'' and VarBit = 1) + ''; ''');
      sql.Add('ELSE');
      sql.Add('  select ''TOK ''');
      open;
      Result := Result + Fields[0].AsString;
    end;

    if pos('L', upperCase(checkWhat)) > 0 then // LC lock
    begin
      close;
      sql.Clear;
      sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''LConLck'') = 1');
      sql.Add('  select ''LON '' + ' +   // the LOCK IS on
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          'from stkVarLocal where VarName = ''LConLck'' and VarBit = 1) + ''; ''');
      sql.Add('ELSE');
      sql.Add('  select ''LOK ''');
      open;
      Result := Result + Fields[0].AsString;
    end;

    if pos('S', upperCase(checkWhat)) > 0 then // SC lock
    begin
      close;
      sql.Clear;
      sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''SConLck'') = 1');
      sql.Add('  select ''SON '' + ' +   // the LOCK IS on
          '(SELECT Convert(char(9), lmdt, 6) + '' '' + Convert(char(8), lmdt, 8) ' +
          'from stkVarLocal where VarName = ''SConLck'' and VarBit = 1) + ''; ''');
      sql.Add('ELSE');
      sql.Add('  select ''SOK ''');
      open;
      Result := Result + Fields[0].AsString;
    end;

    close;
  end; // with adoqRun

  log.event('Lock Check (' + checkWhat + ') Result: ' + Result);

end;

function Tdata1.HandHeldImportsExist: Boolean;
var
  StockRollEndDate: String; //Stock rollover end date
  StockEndDate: String; //Stock end date
begin
  log.event('udata1: Begin - HandHeldImportsExist');
  StockEndDate     := FormatDateTime('yyyy-mm-dd hh:nn:ss', EDT - 1);
  StockRollEndDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', EDT + 1);

  with adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM StockHandHeldSessions');
    SQL.Add('WHERE StockThread = ' + IntToStr(CurTid));
    SQL.Add('AND StartTime > '     + QuotedStr(StockEndDate));
    SQL.Add('AND StartTime <= '    + QuotedStr(StockRollEndDate));
    SQL.Add('AND EndTime > '       + QuotedStr(StockEndDate));
    SQL.Add('AND EndTime <= '      + QuotedStr(StockRollEndDate));

    if curByHZ then
      SQL.Add('AND HoldingZone > 0')
    else
      SQL.Add('AND (HoldingZone <= 0)');

    Open;
    Result := (RecordCount > 0);
    Close;
    SQL.Clear;
  end;
  log.event('udata1: End - HandHeldImportsExist');
end;

function Tdata1.MobileStockImportsExist: Boolean;
var
  StockRollEndDate: String; //Stock rollover end date
  StockEndDate: String; //Stock end date
begin
  log.event('udata1: Begin - MobileStockImportsExist');
  StockEndDate     := FormatDateTime('yyyy-mm-dd hh:nn:ss', EDT - 1);
  StockRollEndDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', EDT + 5);

  with adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ac_MobileStockSession');
    SQL.Add('WHERE StockThread = ' + IntToStr(CurTid));
    SQL.Add('AND StartTime > '     + QuotedStr(StockEndDate));
    SQL.Add('AND StartTime <= '    + QuotedStr(StockRollEndDate));
    SQL.Add('AND EndTime > '       + QuotedStr(StockEndDate));
    SQL.Add('AND EndTime <= '      + QuotedStr(StockRollEndDate));

    Open;
    Result := (RecordCount > 0);
    Close;
    SQL.Clear;
  end;
  log.event('udata1: End - MobileStockImportsExist');
end;

function Tdata1.CheckForOutstandingDeliveryNotes(StartDate,
  EndDate: TDateTime): Boolean;
var
  UsingDateRange : Boolean;
begin
  log.event('In Data1.CheckForOutstandingDeliveryNotes');
  UsingDateRange := ((StartDate > 0) and (EndDate > 0));

  with adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT COUNT(*) AS SqlCount');
    Sql.Add('FROM dbo.[HandHeldDeliveryFailureHeader]');
    Sql.Add('WHERE [Deleted] = 0');
    if UsingDateRange then
    begin
      Sql.Add('AND [FinalisedDateTime] BETWEEN :StartDate AND :EndDate');
      Parameters.ParamByName('StartDate').Value := StartDate;
      Parameters.ParamByName('EndDate').Value := EndDate;
    end;
    Open;
    Result := (FieldByName('SqlCount').AsInteger > 0);
  end;
  log.event('Exiting Data1.CheckForOutstandingDeliveryNotes');
end;

function Tdata1.IncludePrepItemsInAudit: Boolean;
begin
  with ADOqRun do
  try
    Close;
    SQL.Text := Format('sp_GetConfiguration %d, ''%s''', [TheSiteCode, INCLUDE_PREP_ITEMS_IN_AUDIT]);
    Open;
    if FieldByName('Setting').IsNull then
      Result := True
    else
      Result := CompareText((FieldByName('Setting').AsString),'T') = 0;
  finally
    Close;
  end;
end;

function Tdata1.GetDateForStockEndOnDoW(theDoW: smallint): tdatetime;
begin
  Result := Date-1 - ((dayofweek(Date-1) + ((13 - theDow) mod 7)) mod 7);
end;

function Tdata1.GetNegativeTheoCloseProducts : TStringList;
begin
  result := TStringList.Create();
  with data1.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select Name from AuditCur where ActCloseStk is NULL and ThCloseStk < 0');
    Open;
    while not eof do
    begin
      result.Add(FieldByName('Name').AsString);
      next;
    end;
    Close;
  end;
end;

initialization

end.

