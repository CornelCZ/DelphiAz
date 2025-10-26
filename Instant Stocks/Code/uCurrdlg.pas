unit uCurrdlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, Wwdatsrc, DBTables, Wwquery, Grids, Wwdbigrd,
  Wwdbgrid, Buttons, Variants, ADODB, Math, DBCtrls, uGlobals;

type
  TfCurrdlg = class(TForm)
    Grid: TwwDBGrid;
    wwDS1: TwwDataSource;
    Panel2: TPanel;
    AccBtn: TBitBtn;
    canBtn: TBitBtn;
    RepBtn: TBitBtn;
    wwqCurStk: TADOQuery;
    lblMThSTh: TLabel;
    BitBtn3: TBitBtn;
    btnRecAud: TBitBtn;
    btnMisc: TBitBtn;
    qryRun: TADOQuery;
    Label3: TLabel;
    pnlDebug: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    Label1: TLabel;
    sbAudNoRec: TSpeedButton;
    procedure FormDefault;
    procedure FormCreate(Sender: TObject);
    procedure wwqCurStkAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure RepBtnClick(Sender: TObject);
    procedure canBtnClick(Sender: TObject);
    procedure AccBtnClick(Sender: TObject);
    procedure btnRecAudClick(Sender: TObject);
    procedure btnMiscClick(Sender: TObject);
    procedure GridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure Label3DblClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure sbAudNoRecClick(Sender: TObject);
  private
    dt1 : tdatetime;
    formBusy: boolean;
    function AcceptPurch: boolean;
    procedure SetSecurity;
    procedure AutoPrint;
    procedure AccMTh;
    function CheckCurrentStockBalances ( StartDate, EndDate, LastRecalc : TDateTime ) : Boolean;
    { Private declarations }
  public
    { Public declarations }
    astage: integer;
  end;

var
  fCurrdlg: TfCurrdlg;

implementation

uses uAudit, uDataProc, uADO, dAccPurch, ulog, uWaitAR, uwait, udata1, uRepSP, uReps1,
  dRunSP, uHandHeldStockImport, uCommon, uAuditLocations, uMobileStockImport;

{$R *.DFM}

procedure TfCurrdlg.SetSecurity;
var
  curTid : integer;
begin
  CurTid := wwqCurStk.FieldByName('tid').AsInteger;

  Accbtn.Visible := data1.UserAllowed(curTid, 15);
  Canbtn.Visible := data1.UserAllowed(curTid, 17);
  Repbtn.Visible := data1.UserAllowed(curTid, 16);

  btnMisc.Visible := (
     ((btnMisc.Caption = 'Edit Misc. Info') and (data1.UserAllowed(curTid, 14)))
    or ((btnMisc.Caption = 'Enter Misc. Info') and (data1.UserAllowed(curTid, 13))));

  btnRecAud.Visible := (
     ((btnRecAud.Caption = 'Enter Audit') and (data1.UserAllowed(curTid, 10)))
    or ((btnRecAud.Caption = 'Complete Audit') and (data1.UserAllowed(curTid, 11)))
    or ((btnRecAud.Caption = 'Edit Audit') and (data1.UserAllowed(curTid, 12))));
end; // procedure..


procedure TfCurrdlg.FormDefault;
begin
  label3.Caption := '';
  AccBtn.Enabled := False;
  btnRecAud.Enabled := True;
  btnMisc.Enabled := True;
end; // procedure..


procedure TfCurrdlg.FormCreate(Sender: TObject);
begin
  formBusy := False;

  if data1.siteUsesHZs then
    self.Width := 796
  else
    self.Width := 735;

  FormDefault;

  wwqCurStk.Open;
end;

procedure TfCurrdlg.wwqCurStkAfterScroll(DataSet: TDataSet);
var
  locCurByHZ, locCurStkByHZ : boolean;
  locSlaveTh : integer;
  calcTypeStr: string;
begin
  if wwqCurStk.RecordCount = 0 then
  begin
    exit;
  end;

	// set rb, cb's & labels to appropriate settings according to the curr stage
  FormDefault;
  if wwqCurStk.FieldByName('rtrcp').AsBoolean then
    calcTypeStr := ''
  else
    calcTypeStr := ' (Theo. Reduction done using Calculation Time Recipe Map)';
  aStage := wwqCurStk.FieldByName('CurStage').AsInteger;
  case astage of
  	0,1:begin
        label3.Caption := 'The next step for the selected ' + data1.SSlow + ' is the'+
        									' entry of the Audit figures.' + calcTypeStr;
        btnRecAud.Caption := 'Enter Audit';
        btnMisc.Enabled := False;
      end;
  	2:begin
        label3.Caption := 'The next step for the selected ' + data1.SSlow + ' is to complete'+
        									' the entry of the Audit figures.' + calcTypeStr;
        btnRecAud.Caption := 'Complete Audit';
        btnMisc.Enabled := False;
      end;
    3:begin
        label3.Caption := 'The final step for the selected ' + data1.SSlow + ' is the'+
        									' entry of miscellaneous information.' + calcTypeStr;
        btnRecAud.Caption := 'Edit Audit';
        btnMisc.Caption := 'Enter Misc. Info';
        btnMisc.Enabled := True;
      end;
    4:begin
        label3.Caption := 'This ' + data1.SSlow + ' is Complete.' +
          'It can be Accepted, Re-Calculated ("Edit Audit") or Cancelled.' + calcTypeStr;
        btnRecAud.Caption := 'Edit Audit';
        btnMisc.Caption := 'Edit Misc. Info';
        btnMisc.Enabled := True;
        AccBtn.Enabled := True;
        RepBtn.Enabled := True;
      end;
  end;

  // now set buttons enabled or not depending if curByHz (thread) is <> to curStkByHZ...
  locCurByHz := (wwqCurStk.FieldByName('ThbyHZ').asboolean) and data1.siteUsesHZs;

  locCurStkByHz := wwqCurStk.FieldByName('byHZ').Asboolean;

  if locCurByHz <> locCurStkByHz then
  begin
    btnRecAud.Enabled := False;
    btnMisc.Enabled := False;

    if locCurByHz then
      label3.Caption := 'This Thread is set to use Holding Zones. This ' + data1.SSlow +
        ' was NOT made by Holding Zone so it cannot be Re-Calculated or Edited.'
    else // either the Thread or the Site or both are not byHZ
      if wwqCurStk.FieldByName('ThbyHZ').asboolean then  // the Thread is till "ON" so the Site must be off...
        label3.Caption := 'This ' + data1.SSlow + ' was made by Holding Zone and it cannot' +
          ' be Re-Calculated or Edited because the Site is currently NOT set to use Holding Zones.'
      else  // the Thread is OFF, just say that...
        label3.Caption := 'This ' + data1.SSlow + ' was made by Holding Zone and it cannot' +
          ' be Re-Calculated or Edited because this Thread is NOT set to use Holding Zones.';
  end;

  if wwqCurStk.FieldByName('RTRcp').IsNull then // old style stock!!!!
  begin                   
    btnRecAud.Caption := 'Enter Audit';
    accBtn.Enabled := False;
    btnMisc.Enabled := False;
    repBtn.Enabled := False;

    label3.Caption := 'This ' + data1.SSlow + ' was made by an old program version and it can only' +
        ' be Re-Calculated or Cancelled.';
  end;


  // Master Thread or Slave Thread visual indicators ONLY...
  lblMThSTh.Visible := False;
  locSlaveTh := wwqCurStk.FieldByName('slaveTh').Asinteger;
  if (locSlaveTh <> 0) then
  begin
    with qryRun do
    begin
      close;
      sql.Clear;
      sql.Add('select tname from threads where tid = ' + inttostr(abs(locSlaveTh)));
      open;

      if locSlaveTh > 0 then
      begin
        lblMThSTh.Caption := 'This is a Master Thread. Its Subordinate Thread is "' +
          FieldByName('tname').AsString + '"';
        lblMThSTh.Color := clBlue;
        lblMThSTh.Font.Color := clWhite;
      end
      else
      begin
        lblMThSTh.Caption := 'This is a Subordinate Thread. Its Master Thread is "' +
          FieldByName('tname').AsString + '"';
        lblMThSTh.Color := clAqua;
        lblMThSTh.Font.Color := clBlack;
      end;

      close;
      lblMThSTh.Visible := True;
    end;
  end;

  SetSecurity;
  if wwqCurStk.FieldByName('RTRcp').IsNull then // old style stock!!!!
  begin
    btnRecAud.Caption := 'Re-Calculate';
  end;
end;

procedure TfCurrdlg.FormShow(Sender: TObject);
begin
  self.Caption := 'Current ' + data1.SSplural;
  accbtn.Caption := 'Accept ' + data1.SSbig;
  canbtn.Caption := 'Cancel ' + data1.SSbig;

  if data1.siteUsesHZs then
  begin
    with Grid, Grid.DataSource.DataSet do   // grid field names, etc...
    begin
      DisableControls;
      Selected.Clear;

      Selected.Add('Division'#9'17'#9'Division'#9#9);
      Selected.Add('tname'#9'27'#9'Thread Name'#9'F');
      Selected.Add('SDate'#9'11'#9'Date'#9'F'#9'Start');
      Selected.Add('STime'#9'5'#9'Time'#9'F'#9'Start');
      Selected.Add('EDate'#9'11'#9'Date'#9'F'#9'End');
      Selected.Add('ETime'#9'5'#9'Time'#9'F'#9'End');
      Selected.Add('StkKind'#9'13'#9'' + data1.ss6 + ' Kind'#9'F');
      Selected.Add('Stage'#9'16'#9'Stage'#9'F');
      Selected.Add('ByHz'#9'5'#9'Stock'#9'F'#9'Holding Zones');
      Selected.Add('ThByHZ'#9'5'#9'Thread'#9'F'#9'Holding Zones');

      grid.ApplySelected;

      EnableControls;
    end;
  end
  else
  begin
    with Grid, Grid.DataSource.DataSet do   // grid field names, etc...
    begin
      DisableControls;
      Selected.Clear;

      Selected.Add('Division'#9'17'#9'Division'#9#9);
      Selected.Add('tname'#9'27'#9'Thread Name'#9'F');
      Selected.Add('SDate'#9'11'#9'Date'#9'F'#9'Start');
      Selected.Add('STime'#9'6'#9'Time'#9'F'#9'Start');
      Selected.Add('EDate'#9'11'#9'Date'#9'F'#9'End');
      Selected.Add('ETime'#9'6'#9'Time'#9'F'#9'End');
      Selected.Add('StkKind'#9'13'#9'' + data1.ss6 + ' Kind'#9'F');
      Selected.Add('Stage'#9'16'#9'Stage'#9'F');

      grid.ApplySelected;

      EnableControls;
    end;
  end;

	wwqCurStk.First;
end;

procedure TfCurrdlg.RepBtnClick(Sender: TObject);
var
  per: integer;
  errStr : string;
begin
  if formBusy then
    Exit;

  formBusy := True;

  try
    log.event('In fCurrDlg.RepBtnClick');
    EnableWindow(Self.Handle, FALSE);

    try
      data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);


      fReps1 := TfReps1.Create(self);
      if astage in [1,2] then
      begin
        // try the calculations now...
        if not fReps1.TheoRepCalc then
        begin
          fReps1.Free;
          data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);
          showmessage('There was an error while doing calculations for Non Audited ' + data1.SSbig +
            ' Reports.' + #13 + 'Reports can not be shown.' + #13 + #13 +
            'You should do a full Re-Calculate NOW to make sure the data is consistent!');
          exit;
        end;

        fReps1.doTheo := True;
      end
      else if astage = 4 then // fill stkMisc with values but only if stock complete....
      begin
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
            sql.Add('(SELECT hzid, sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
            sql.Add('  sum(b."opStk" * b."opCost") as opCost,');
            sql.Add('  sum(moveQty * moveCost) as moveCost,');

            sql.Add('  (sum ');
            sql.Add('   (CASE');
            sql.Add('    WHEN b.key2 >= 1000 THEN 0');
            sql.Add('    ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
            sql.Add('   END)) as gains,');

            sql.Add('  (sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
            sql.Add('  (sum (b."wastage" * b."NomPrice")) as faultVal');
            sql.Add('  FROM "StkCrDiv" b group by hzid) sq');
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            sql.Add('and stkMisc.hzid = sq.hzid');
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
            sql.Add('(select hzid, (sum(a."income")) as income,');
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
            sql.Add('  FROM "StkCrSld" a group by hzid) sq');
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            sql.Add('and stkMisc.hzid = sq.hzid');
            execSQL;

            per := trunc(data1.Edate - data1.Sdate + 1);

            errStr := 'put period figures into StkMisc';
            // now put all this into StkMisc
            close;
            sql.Clear;
            sql.Add('update stkMisc set');
            sql.Add('	[Per] = ' + inttostr(Per) + ', ');
            sql.Add(' [totPurch] = (CASE WHEN [totPurch] is NULL THEN 0 ELSE [totPurch] END),');
            sql.Add(' [miscBal1] = (CASE WHEN [miscBal1] is NULL THEN 0 ELSE [miscBal1] END),');
            sql.Add(' [miscBal2] = (CASE WHEN [miscBal2] is NULL THEN 0 ELSE [miscBal2] END),');
            sql.Add(' [miscBal3] = (CASE WHEN [miscBal3] is NULL THEN 0 ELSE [miscBal3] END)');
            // do not set lmdt here as we don't want this to go to HO yet...
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            execSQL;
          end;
        except
          on E:Exception do
          begin
            log.event('ERROR filling stkMisc for Current stock (Tid: ' + IntToStr(data1.curtid) +
              ', StkCode: ' + IntToStr(data1.StkCode) + ') Location: ' + errstr +
              ' Message: ' + E.Message);
            fReps1.Free;
            exit;
          end;
        end;
      end;

      fReps1.ShowModal;
      fReps1.Free;

      // reset stkCrDiv and stkCrSld as well as takings in stkmisc
      if astage in [1,2] then
        data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

      log.event('Exiting fCurrDlg.RepBtnClick');
    finally
      EnableWindow(Self.Handle, TRUE);
    end;
  finally
    formBusy := False;
  end;
end;

procedure TfCurrdlg.canBtnClick(Sender: TObject);
begin
  if formBusy then
    Exit;

  formBusy := True;

  try
    if MessageDlg('WARNING!'+#13+'This action will remove ALL data for the '+
          'current ' + data1.SSlow + ' and cannot be undone.'+#13+#13+
          'Click "OK" to remove the selected ' + data1.SSlow + '.'+#13+
          'Click "Cancel" to abort operation and keep the selected ' + data1.SSlow + '.',
          mtWarning,[mbOK,mbCancel],0) = mrOK then
    begin
      data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

      log.event('Cancel Stock Started - Thread: ' + data1.curTidName +
        ', StkCode: ' + inttostr(data1.StkCode));

      data1.killStock(data1.curTid, data1.StkCode);

      wwqCurStk.Requery;
      Grid.Refresh;
      Grid.RePaint;
      if wwqCurStk.RecordCount = 0 then
      begin
        showMessage('There are no more Current ' + data1.SSplural + ' to view!');
        modalResult := mrOK;
      end;
    end;
  finally
    formBusy := False;
  end;
end;

procedure TfCurrdlg.AutoPrint;
begin
  with qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a.[AR], b.[text] from stkAutoRep a, stkAReps b where a.AR = b.AR');
    sql.Add('and a.Tid = ' + inttostr(data1.CurTid));
    open;

    if recordcount = 0 then
    begin
      close;
      exit;
    end;
  end;

  data1.AccDate := Date;

  fWaitAR := TfWaitAR.Create(self);
  fWaitAR.ShowModal;
  fWaitAR.Free;

  qryRun.close;
end; // procedure..

function TfCurrdlg.AcceptPurch:boolean;
begin
  // accept invoices ...
  dmAccPurch := TdmAccPurch.Create(self);
  Result := dmAccPurch.AcceptPurchases;
  dmAccPurch.Free;
end;

procedure TfCurrdlg.btnRecAudClick(Sender: TObject);
var
  i : integer;
begin
  if formBusy then
    Exit;

  formBusy := True;

  try
    try
      log.event('In fCurrDlg.btnRecAudClick, ThreadID = ' + IntToStr(wwqCurStk.FieldByName('Tid').AsInteger) +
         ', StockCode = ' + IntToStr(wwqCurStk.FieldByName('StockCode').AsInteger));
      data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
         wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, False, True);

      if wwqCurStk.FieldByName('RTRcp').IsNull then // THIS IS an OLD stock!!!!
      begin
        case data1.curTidRcpHow of
          1: begin   // use Real Time (time of sale) recipes
               data1.curRTrcp := True;
               i := 1;
             end;
          2: begin   // ask on new stock
               case MessageDlg('What Theoretical Reduction Calculation Method do you want to use?' +
                 #13 + #13 + 'Click "Yes" to use Recipes as they WERE at the time of Sale.' + #13 +
                 'Click "No" to use Recipes as they ARE now.' + #13 + #13 +
                 'Click "Cancel" if you are not sure (this will stop the re-calculation).'
                   , mtConfirmation, [mbYes,mbNo,mbCancel], 0) of
                 mrYes: begin
                        log.event('fCurrDlg.btnRecAudClick - User selected to use Recipes as at time of sale');
                        data1.curRTrcp := True;
                        i := 1;
                      end;
                 mrNo:  begin
                        log.event('fCurrDlg.btnRecAudClick - User selected to use Recipes as they are now');
                        data1.curRTrcp := False;
                        i := 0;
                      end;
                 else exit;
               end; // case
             end;
        else begin   // use Stock Time Recipe
               data1.curRTrcp := False;
               i := 0;
             end;
        end; // case..

        log.event('fCurrDlg.btnRecAudClick - Updating CurrStock');
        with data1.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('UPDATE "CurStock" SET RTrcp = ' + inttostr(i)+',');
          sql.Add( 'LMDT = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
          sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
          sql.Add('and tid = '+IntToStr(data1.curtid));
          ExecSQL;
        end;
      end;

      if TControl(Sender).Name <> 'sbAudNoRec' then
      begin
        log.event('fCurrDlg.btnRecAudClick - Re-Calculate Started');
        data1.UpdateCurrStage(0); // stage 0

        if not dataProc.PreAudit(data1.curRTrcp, True, 0) then
        begin
          log.event('ERROR - fCurrDlg.btnRecAudClick - PreAudit did not work, Stage is now 0');
          exit;
        end;

        data1.PushStkMain; // push sales, purch data into stkmain
        data1.UpdateCurrStage(1); // stage 1, Sales & purch got & calc'ed & saved...
        log.event('fCurrDlg.btnRecAudClick - Sales & Recipe Map Recalculated - Ask to enter Audit.');
      end
      else
      begin
        log.event('DEBUG MODE: Re-Calculate Bypassed');
      end;

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
             if MessageDlg('There are ' + inttostr(RecordCount) + ' products newly detected by the system which are '+#13+#10+
                     'expected to be on Site but are not allocated to any Count Location.'+#13+#10+''+#13+#10+
                     'You can proceed with the '+ data1.SSlow +' and these products will appear in "<No Location>"' + #13+#10+
                     'or you can stop and go to configure these products to be in one or more Locations'+#13+#10+#13+#10+
                     'Do you want to continue with the '+ data1.SSlow +' as it is?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
             begin
                // if the stock was at stage 2 or higher prior to re-calculate then there are some
                // figures in Audit table. We need to keep the stage to have the correct text on the button
                // "aStage" variable has the stage of the stock prior to re-calculate...
                if aStage >= 2 then // there could be figures in Audit...
                begin
                  // ARE there figure in Audit for this stock?

                  close;
                  sql.Clear;
                  sql.Add('select a."entitycode" ');
                  if data1.curByLocation then
                    sql.Add(' FROM  "AuditLocations" a')
                  else
                    sql.Add(' FROM  "Audit" a');
                  sql.Add('WHERE a."StkCode" = '+IntToStr(data1.StkCode));
                  sql.Add('and tid = '+IntToStr(data1.CurTid));
                  open;

                  if recordcount > 0 then
                  begin
                    data1.UpdateCurrStage(2); // stage 2, Some Audit Count figures entered...
                  end;
                  close;
                end;

                exit; // user chooses not to proceed to Audit...
             end;
           end;

           close;
         end; // with
      end; // if byLocation


      if not data1.noCountSheetDlg then // if not configured to suppress the Count Sheet printing prompt
      begin
        case MessageDlg('In the next step the actual closing ' + data1.SSlow +
            ' levels will be required to complete the ' + data1.SSlow + '.' +
            #13 + #13 + 'Do you want to print the Count Sheets for the current ' + data1.SSlow + ' now?' + #13 +
            '(Click "Yes" to print the Count Sheets with no count figures, Click "All" to print any Count figures already entered.)',
            mtConfirmation, [mbYes,mbAll,mbNo], 0) of
          mrYes: begin
                   fRepSP := TfRepSP.Create(Self);
                   try
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
                     else if data1.curByLocation then
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
                     else    // not by HZ and not by Location...
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
                   finally
                      fRepSP.Free;
                   end;
                 end;
          mrAll: begin
                   fRepSP := TfRepSP.Create(Self);
                   fRepSP.pptTot.Visible := True;
                   if data1.curByHZ then
                   begin
                     Data1.GenerateCurrentStockAuditFigures(True, False);
                     with dmADO.adoqRun do
                     begin
                       close;
                       sql.Clear;
                       sql.Add('select hzid, hzname from stkHZs where active = 1');
                       open;

                       while not eof do
                       begin
                         fRepSP.adoqCount.sql.Clear;
                         fRepSP.adoqCount.sql.Add('select * from AuditCur');
                         fRepSP.adoqCount.sql.Add('WHERE hzid = ' + FieldByName('hzid').asstring);
                         fRepSP.adoqCount.sql.Add('and (shouldbe = 0 OR MustCount = 1)');
                         fRepSP.adoqCount.sql.Add('Order By "SubCat", "Name"');
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
                   else if data1.curByLocation then
                   begin
                     Data1.GenerateCurrentStockAuditLocationFigures(True, False);
                     with dmADO.adoqRun do
                     begin
                       // first print the <No Location> Count Sheet, if there are any products for it...
                       // use "normal" count sheet
                       fRepSP.pptTot.Visible := True;

                       fRepSP.adoqCount.Close;
                       fRepSP.adoqCount.sql.Clear;
                       fRepSP.adoqCount.sql.Add('select * from AuditLocationsCur');
                       fRepSP.adoqCount.sql.Add('WHERE LocationID = 999');
                       fRepSP.adoqCount.sql.Add('AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ' +
                                   '("WasteTill" <> 0) or ("WastePC" <> 0) or (MustCount = 1))');
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
                       fRepSP.ppLocationsTot.Visible := True;

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

                       close;
                     end;
                   end
                   else
                   begin
                     Data1.GenerateCurrentStockAuditFigures(True, False);
                     fRepSP.adoqCount.sql.Clear;
                     fRepSP.adoqCount.sql.Add('select * from AuditCur');
                     fRepSP.adoqCount.sql.Add('WHERE hzid = 0');
                     fRepSP.adoqCount.sql.Add('and (shouldbe = 0 OR MustCount = 1)');
                     fRepSP.adoqCount.sql.Add('Order By "SubCat", "Name"');
                     fRepSP.adoqCount.Open;
                     fRepSP.ppLabel23.Visible := False;
                     fRepSP.ACSprint(false); // sets the fields
                     fRepSP.PrintCount;
                     fRepSP.adoqCount.Close;
                   end;
                   fRepSP.Free;
                 end;
        end; // end   case.
      end; // end   if not data1.noCountSheetDlg.


      // Get user to enter stock levels
      if MessageDlg('All opening ' + data1.SSlow + ', purchases and sales '+
               'information has been gathered and processed.'+#13+
               'The actual closing ' + data1.SSlow + ' levels are now required to complete the ' + data1.SSlow + '.'+#13+
               #13+'Click "Yes" to enter audited ' + data1.SSlow + ' levels.'+#13+
               'Click "No" to Exit.'
               ,mtConfirmation,[mbYes,mbNo],0) = mrNo then
      begin
        // if the stock was at stage 2 or higher prior to re-calculate then there are some
        // figures in Audit table. We need to keep the stage to have the correct text on the button
        // "aStage" variable has the stage of the stock prior to re-calculate...
        if aStage >= 2 then // there could be figures in Audit...
        begin
          // ARE there figure in Audit for this stock?
          with data1.adoqRun do
          begin
            close;
            sql.Clear;
            sql.Add('select a."entitycode" ');
            if data1.curByLocation then
              sql.Add(' FROM  "AuditLocations" a')
            else
              sql.Add(' FROM  "Audit" a');
            sql.Add('WHERE a."StkCode" = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.CurTid));
            open;

            if recordcount > 0 then
            begin
              data1.UpdateCurrStage(2); // stage 2, Some Audit Count figures entered...
            end;
            close;
          end;
        end;

        exit; // user chooses not to proceed to Audit...
      end;

      // user chose to continue...
      log.event('fCurrDlg.btnRecAudClick - User selected to enter audit');

      if data1.curByLocation then
        Data1.GenerateCurrentStockAuditLocationFigures(True, True)
      else
        Data1.GenerateCurrentStockAuditFigures(True, True);

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

        log.event('fCurrDlg.btnRecAudClick - updating StkCrDiv');
        with data1.adoqRun do
        begin
          // by now AuditLocations table has all the Locations Count data. Sum it up per Product.
          // as far as the rest of the system is concerned that is the only Audit Count data...

          close;
          sql.Clear;
          sql.Add('UPDATE StkCrDiv SET AuditStk = sq.ActCloseStk,'); // 17841 & 17700
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
        fAudit.Top := self.Top;
        fAudit.Left := self.Left;
        if fAudit.ShowModal = mrCancel then
        begin
          fAudit.Free;
          exit;
        end;
        fAudit.Free;

        log.event('fCurrDlg.btnRecAudClick - updating StkCrDiv');
        with data1.adoqRun do
        begin
          close;
          sql.Clear;
          sql.Add('UPDATE StkCrDiv SET AuditStk = sq."ActCloseStk",');
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
      end;   // if by Location, else, end.



      log.event('fCurrDlg.btnRecAudClick - Audit figures in. Start Re-Calc processing again...');
      if not dataProc.PostAudit then
      begin
        log.event('ERROR - fCurrDlg.btnRecAudClick - PostAudit did not work');
        exit;
      end;
      data1.PushStkMain;
      data1.PushStkSold;
      data1.PushPrepared;
      data1.UpdateCurrStage(3); // stage 3, All audit figs, costs, prices, sitems calc'ed

      if aStage >= 4 then // this stock was already complete...
      begin
        data1.FinishStk(False); // get misc stuff, prep for reps & acceptance
        data1.UpdateCurrStage(4); // stage 4, ready for acceptance
        log.event('fCurrDlg.btnRecAudClick - Edit Audit & Recalc Finished');
      end
      else
      begin  // stock was not complete, we're not further than stage 3 at this point...
        if data1.FinishStk(True) then // get misc stuff, prep for reps & acceptance
        begin
          data1.UpdateCurrStage(4); // stage 4, ready for acceptance
          log.event('fCurrDlg.btnRecAudClick - Edit Audit & Recalc Finished - Stock complete');
        end
        else
        begin
          log.event('fCurrDlg.btnRecAudClick -Edit Audit & Recalc Finished - Stock Audited - User cancelled out of Misc Info');
        end;
      end;

      with data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('UPDATE "CurStock" SET ');
        sql.Add('"DateRecalc" = '+#39+formatDateTime('mm/dd/yy',Date)+#39);
        sql.Add(',"TimeRecalc" = '+#39+formatDateTime('hh:nn',Time)+#39);
        sql.Add(', LMDT = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
        sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        ExecSQL;
      end;
      log.event('Exiting fCurrDlg.btnRecAudClick');
    finally
      wwqCurStk.Requery;
      wwqCurStk.locate('tid;stockcode', VarArrayOf([data1.curtid , data1.StkCode]), []);
      Grid.Refresh;
      Grid.RePaint;
    end;
  finally
    formBusy := False;
  end;
end;

procedure TfCurrdlg.btnMiscClick(Sender: TObject);
begin
  if formBusy then
    Exit;

  formBusy := True;

  try
    try
      data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);
      log.event('Edit Misc Info');

      if aStage >= 4 then // this stock was already complete...
      begin
        data1.FinishStk(False); // get misc stuff, prep for reps & acceptance
        log.event('Edit Misc Info Finished');
      end
      else
      begin  // stock was not complete, we're not further than stage 3 at this point...
        if data1.FinishStk(True) then // get misc stuff, prep for reps & acceptance
        begin
          data1.UpdateCurrStage(4); // stage 4, ready for acceptance
          log.event('Edit Misc Info Finished');
        end
        else
        begin
          log.event('Edit Misc Info Finished - Stock Audited - User cancelled out of Misc Info');
          exit;
        end;
      end;

      with data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('UPDATE "CurStock" SET ');
        sql.Add('"DateRecalc" = '+#39+formatDateTime('mm/dd/yy',Date)+#39);
        sql.Add(',"TimeRecalc" = '+#39+formatDateTime('hh:nn',Time)+#39);
        sql.Add(', LMDT = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
        sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        ExecSQL;
      end;
    finally
      wwqCurStk.Requery;
      wwqCurStk.locate('tid;stockcode', VarArrayOf([data1.curtid , data1.StkCode]), []);
      Grid.Refresh;
      Grid.RePaint;
    end;
  finally
    formBusy := False;
  end;
end;

procedure TfCurrdlg.GridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Highlight then
    exit;
    
  if Field.FieldName = 'tname' then // Master Thread or Slave Thread visual indicators ONLY...
  begin
    if wwqCurStk.FieldByName('slaveTh').Asinteger > 0 then
    begin
      ABrush.Color := clBlue;
      AFont.Color := clWhite;
      AFont.Style := [fsBold];
    end
    else if wwqCurStk.FieldByName('slaveTh').Asinteger < 0 then
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
         (Field.FieldName = 'SDate') or (Field.FieldName = 'STime') then
  begin
    if wwqCurStk.FieldByName('RTRcp').IsNull then
    begin
      ABrush.Color := clSilver;
      AFont.Color := clBlack;
    end;
  end;

end;


procedure TfCurrdlg.AccBtnClick(Sender: TObject);
var
  per: integer;
  theNow : tdatetime;
  errStr : string;
begin
  if formBusy then
    Exit;

  formBusy := True;

  try
    log.event('In fCurrDlg.AccBtnClick, ThreadID = ' + IntToStr(wwqCurStk.FieldByName('Tid').AsInteger) +
    ', StockCode = ' + IntToStr(wwqCurStk.FieldByName('StockCode').AsInteger));
    if data1.CheckForOutstandingDeliveryNotes(
      wwqCurStk.FieldByName('SDate').AsDateTime,
      wwqCurStk.FieldByName('EDate').AsDateTime) then
    begin
      MessageDlg('There are Hand Held Delivery Note issues that require user intervention which '
        + 'fall inside the selected stocks range. (' +
        FormatDateTime(data1.ukusDateForm2y, wwqCurStk.FieldByName('SDate').AsDateTime) + ' - ' +
        FormatDateTime(data1.ukusDateForm2y, wwqCurStk.FieldByName('EDate').AsDateTime) + ')'
        +#13#10 + #13#10 + 'In order to accept a stock, all outstanding issues need to be resolved.'
        +#13#10 + #13#10 + 'Use the Purchasing system to address these issues.',
        mtError, [mbOK], 0);
      Exit;
    end;

    if not CheckCurrentStockBalances(
      wwqCurStk.FieldByName('SDate').AsDateTime,
      wwqCurStk.FieldByName('EDate').AsDateTime,
      wwqCurStk.FieldByName('DateRecalc').AsDateTime + wwqCurStk.FieldByName('TimeRecalc').AsDateTime) then
    begin
      if uCommon.CreateMessageDialog('Confirmation', 'The current ' + data1.SSlow + ' figures do not match those of the system estimated '
          + data1.SSlow + ' figures.'+#13#10+'It is recommended that the ' + data1.SSlow + ' is recalculated '
          +'before accepting the ' + data1.SSlow + '.'
          +#13#10+#13#10
          +'Would you like to continue accepting the ' + data1.SSlow + ' without the Recalculate?',
          mtConfirmation, [mbYes, mbNo], mrNo, 0) = mrNo then
            Exit;
    end;

    if wwqCurStk.FieldByName('slaveTh').Asinteger > 0 then
    begin
      // This is a Master Thread handle this in another procedure...
      log.event('fCurrDlg.AccBtnClick - is master thread');
      AccMTh;
      exit;
    end;

    if MessageDlg('Accept ' + data1.SSbig + '?'+#13+#13+
                            'Once the selected ' + data1.SSlow + ' has been accepted it cannot be modified.' +
         #13+#13+'Click "OK" to accept the ' + data1.SSlow + '.'+#13+
         'Click "Cancel" to keep the ' + data1.SSlow + ' as current.',
         mtWarning,[mbOK,mbCancel],0) = mrOK then
    begin
      try
        log.event('fCurrDlg.AccBtnClick - User confirmed stock acceptance');
        screen.Cursor := crHourGlass;

        data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

        log.event('fCurrDlg.AccBtnClick - Start Accepting a stock');

        if not data1.curNoPurAcc then
        begin
          if not AcceptPurch then
          begin
            showMessage('Invoices involved in this ' + data1.SSlow + ' could not be accepted because of an error!' +
              #13 + #13 +
              'This ' + data1.SSlow + ' can not be accepted until that error is fixed.');

            log.event('fCurrDlg.AccBtnClick - Stock Acceptance stopped because of error in Accept Purchases');

            exit;
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
            sql.Add('(SELECT hzid, sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
            sql.Add('  sum(b."opStk" * b."opCost") as opCost,');
            sql.Add('  sum(moveQty * moveCost) as moveCost,');

            sql.Add('  (sum ');
            sql.Add('   (CASE');
            sql.Add('    WHEN b.key2 >= 1000 THEN 0');
            sql.Add('    ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
            sql.Add('   END)) as gains,');

            sql.Add('  (sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
            sql.Add('  (sum (b."wastage" * b."NomPrice")) as faultVal');
            sql.Add('  FROM "StkCrDiv" b group by hzid) sq');
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            sql.Add('and stkMisc.hzid = sq.hzid');
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
            sql.Add('(select hzid, (sum(a."income")) as income,');
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
            sql.Add('  FROM "StkCrSld" a group by hzid) sq');
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            sql.Add('and stkMisc.hzid = sq.hzid');
            execSQL;

            per := trunc(data1.Edate - data1.Sdate + 1);

            errStr := 'put period figures into StkMisc';
            // now put all this into StkMisc
            close;
            sql.Clear;
            sql.Add('update stkMisc set');
            sql.Add('	[Per] = ' + inttostr(Per) + ', ');
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

            // now set lmdt on StkMain and StkSold to have these recs tx'd to the HO
            theNow := Now;

            errStr := 'update StkMain set lmdt';
            close;
            sql.Clear;
            sql.Add('update StkMain set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
            sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            execSQL;

            errStr := 'update StkSold set lmdt';
            close;
            sql.Clear;
            sql.Add('update StkSold set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
            sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            execSQL;

            errStr := 'update StkSoldChoice set lmdt';
            close;
            sql.Clear;
            sql.Add('update StkSoldChoice set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss:zzz', theNow)));
            sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            execSQL;

            errStr := 'DELETE FROM "Audit"';
            close;
            sql.Clear;
            sql.Add('DELETE FROM "Audit"');
            sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            ExecSQL;

            errStr := 'curstock -> stocks';
            // do it all in one query so the stock is not left as both Current and Accepted in case of errors

            close;
            sql.Clear;
            sql.Add('insert Stocks ([SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
            sql.Add('      [ETime], [SDT], [EDT], [AccDate], [AccTime], [Stage], [Type], [DateRecalc],');
            sql.Add('      [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], [LMDT], [AccBy], [PureAZ], [rtRcp])');
            sql.Add('select [SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
            sql.Add('       [ETime], [SDT], [EDT], ' + quotedStr(formatDateTime('yyyymmdd', Date)) + ',' +
              quotedStr(formatDateTime('hh:nn', Time)) + ', ''Accepted'', [Type], [DateRecalc],');
            sql.Add('       [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], ' +
              quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', theNow)) + ', ' + quotedStr(CurrentUser.UserName) + ', 1, [rtRcp]');
            sql.Add('from curstock');
            sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            sql.Add('  ');

            sql.Add('  ');
            sql.Add('DELETE FROM "curstock"');
            sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
            sql.Add('and tid = '+IntToStr(data1.curtid));
            ExecSQL;
          end; // with
          errStr := 'Requery & Refresh';

          wwqCurStk.Requery;
          Grid.Refresh;
        except
          on E:Exception do
          begin
            log.event('fCurrDlg.AccBtnClick - ERROR Accepting Stock (Tid: ' + IntToStr(data1.curtid) +
              ', StkCode: ' + IntToStr(data1.StkCode) + ') Location: ' + errstr +
              ' Message: ' + E.Message);
            exit;
          end;
        end;

        log.event('fCurrDlg.AccBtnClick - Stock Accepted.');

        if data1.curTidAsBase then // update stkECLevel
        begin
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
               log.event('fCurrDlg.AccBtnClick - SP Body NOT Executed - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
              else
                log.event('fCurrDlg.AccBtnClick - SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
                 ' RET CODE: ' + fields[0].AsString);
             except
               on E:Exception do
                 log.event('fCurrDlg.AccBtnClick - SP ERROR - "' + sql[1] + '"' +
                 ' ERR MSG: ' + E.Message);
             end;
             Close;
           end;
           spConn.Close;
         end;
        end
        else if not data1.curDivAsBase then
        begin // if no tid in this div is NOW a Base then if there delete any data for that Div in stkECLevel
          with data1.adoqRun do
          begin
            close;
            sql.Clear;
            sql.Add('delete stkECLevel where division = ' + quotedStr(data1.TheDiv));
            per := execSQL; // reuse per to get the records deleted...
            log.event('fCurrDlg.AccBtnClick - DELETED ' + inttostr(per) + ' records from stkECLevel as Div: "' + data1.TheDiv +
                 '" no longer has any Tids serving as Base.');
          end;
        end;
        // now send reports straight to printer using thread settings...

        if data1.curAutoRep then
        begin
          try
            AutoPrint;
          except
            on E : Exception do
            begin
              // log
              // warn
            end;
          end;
        end;

        if wwqCurStk.RecordCount = 0 then
        begin
          showMessage('There are no more Current ' + data1.SSplural + ' to view!');
          modalResult := mrOK;
        end;
        log.event('Exiting fCurrDlg.AccBtnClick');
      finally
        screen.Cursor := crDefault;
      end;
    end;
  finally
    formBusy := False;
  end;
end;

// Acceptance of stocks Master
procedure TfCurrdlg.AccMTh;
var
  per, slaveStk, slaveTh: integer;
  theNow : tdatetime;
  errStr, s1 : string;
  slaveAsBase : boolean;
  masterThread, masterStock: integer;
begin
  data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

  masterThread := data1.CurTid;
  masterStock := data1.StkCode;

  log.event(format('In fCurrDlg.AccMth (Accepting Master Stock, ThreadID = %d, StockCode = %d', [masterThread, masterStock]));

  s1 := 'AUTOGEN-' + inttostr(masterThread) + ':' + inttostr(masterStock);

  // check if the subordinate thread (abbrev. STh) stock is OK to be produced and delete any Current stock as well.
  // Warn user about what's about the happen and ask if OK to proceed.
  if (data1.lastSThAccEDT >= data1.EDT - 1/24) or (data1.lastSthAccFBD >= data1.Edate) then
  begin
    // someone made and/or accepted a stock for the Sub Thread with EDT > the cur Master Thread stock!!!
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select * from stocks where tid = ' + inttostr(data1.curSTh));
      sql.Add('and StockCode = ' + inttostr(data1.lastSThAccCode));
      open;

      MessageDlg('Thread "' + data1.curTidName + '" is a Master Thread! Accepting a ' + data1.SSbig +
       ' of a Master Thread means also automatically '+#13+'creating and accepting a ' + data1.SSbig +
       ' in its Subordinate Thread "' + data1.CurSThName + '" (with a minimum period of 1 day).'+#13+''+#13+
       'But Thread "' + data1.CurSThName + '" already has an ACCEPTED ' + data1.SSbig +
       ' for the current time period:'+#13+
       'Start Date: ' + FieldByName('SDate').asstring +
       ', End Date: ' + FieldByName('EDate').asstring +
       ', Accepted Date: ' + FieldByName('AccDate').asstring +
       ', Accepted By:' + FieldByName('AccBy').asstring +#13+''+#13+
       'As such the ' + data1.SSbig +' for the Master Thread cannot be accepted!'+#13+
       'Either cancel the ' + data1.SSbig +' you are now trying to accept and do a new one with a later End Date' + #13 +
       'or deal with the Accepted ' + data1.SSbig +' of the Subordinate Thread.  ', mtWarning, [mbOK], 0);
       log.event('fCurrDlg.AccMth (Accepting Master Stock), User warned that master stock cannot be accepted ' +
         'because subordinate is accepted in the current time period');
      close;
    end;

    exit;
  end
  else
  begin
    // look to see if STh has any Current Stock
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select * from curstock where tid = ' + inttostr(data1.curSTh));
      open;

      if recordcount > 0 then // really can only be 0 or 1 but...
      begin
        log.event('fCurrDlg.AccMth (Accepting Master Stock), User warned that accepting master will automatically ' +
         'cancel subordinate stock');
        // tell user I'm about to erase the current stock
        if MessageDlg('Thread "' + data1.curTidName + '" is a Master Thread! Accepting a ' + data1.SSbig +
          ' of a Master Thread means also automatically creating and accepting a ' + data1.SSbig +
          ' in the Subordinate Thread "' + data1.CurSThName + '".'+#13+''+#13+
          'But Thread "' + data1.CurSThName + '" has a CURRENT ' + data1.SSbig +
          ' for the current time period:'+#13+
          'Start Date: ' + FieldByName('SDate').asstring +
          ', End Date: ' + FieldByName('EDate').asstring +
          ', Stage: ' + FieldByName('Stage').asstring +#13+''+#13+
          'For the ' + data1.SSbig +' of the Master Thread to be accepted the system will CANCEL the CURRENT ' +
          data1.SSbig + ' of the Subordinate Thread first.', mtWarning, [mbOK,mbCancel], 0) = mrCancel then
        begin
          log.event('fCurrDlg.AccMth (Accepting Master Stock), User selected Cancel to stop the master stock acceptance');
          close;
          exit;
        end
        ELSE
        begin
          // cancel the current slave stock
          log.event('fCurrDlg.AccMth (Accepting Master Stock), User selected OK to cancel the current subordinate stock');
          data1.killStock(data1.curSTh, FieldByName('stockcode').asinteger);
        end;
      end
      else
      begin
        // all OK but are you sure?
        if MessageDlg('Thread "' + data1.curTidName + '" is a Master Thread! Accepting a ' + data1.SSbig +
          ' of a Master Thread means also' + #13 + 'automatically creating and accepting a ' + data1.SSbig +
          ' in the Subordinate Thread "' + data1.CurSThName + '".'+#13+''+#13+
          'Continue?', mtWarning, [mbYes,mbNo], 0) = mrNo then
        begin
          close;
          exit;
        end;
      end;
    end;
  end;

  // automatically create, process, audit, process and accept a stock for the STh
 try
  screen.Cursor := crHourGlass;
  try
    errStr := 'Start Auto-Processing';
    log.event('fCurrDlg.AccMth (Accepting Master Stock), New Sub Thread Auto-Stock Started');

    // set cur variables for the Stock of the STh (equivalent to init curr)
    Data1.TheStkTkr := 'AUTO-' + Data1.TheStkTkr;
    Data1.curMth := data1.CurTid;
    Data1.curMthName := data1.curTidName;
    data1.CurTid := data1.curSTh;
    data1.curTidName := data1.CurSThName;

    data1.curisSth := True;
    data1.curIsMTh := False;
    data1.curBgCP := False;
    // the curRTRcp is left to be same as Master...

    // temporarily use lastSThAccCode to store the StockCode of the MTh stock (for data imports...)
    data1.lastSThAccCode := data1.stkCode;

    with data1 do
    begin
      // get some Thread variables
      adoqRun.close;
      adoqRun.sql.Clear;
      adoqRun.sql.Add('select * from threads where tid = ' + inttostr(curTid));
      adoqRun.open;

      curDozForm := (adoqRun.FieldByName('dozform').asstring = 'Y');      // 17701
      curIsGP := (adoqRun.FieldByName('isGP').asstring = 'Y');
      curAutoRep := (adoqRun.FieldByName('AutoRep').asstring = 'Y');
      curGallForm := (adoqRun.FieldByName('gallform').asstring = 'Y');
      curNoPurAcc := (adoqRun.FieldByName('NoPurAcc').asstring = 'Y');
      slaveAsBase := adoqRun.FieldByName('LCBase').asboolean;

      // get last stock code for this thread from stocks
      adoqRun.Close;
      adoqRun.sql.Clear;
      adoqRun.sql.Add('SELECT Max(a."StockCode") as prevCode');
      adoqRun.sql.Add('FROM "stocks" a');
      adoqRun.sql.Add('WHERE a."tid" = '+ inttostr(curTid));
      adoqRun.open;

      // set this thread's previous stock code
      PrevStkCode := adoqRun.FieldByName('prevcode').AsInteger;
      adoqRun.close;

      stkCode := prevStkCode + 1;

      adoqRun.Close;
      adoqRun.sql.Clear;
      adoqRun.sql.Add('SELECT byHZ');
      adoqRun.sql.Add('FROM stocks');
      adoqRun.sql.Add('WHERE tid = '+ inttostr(curTid));
      adoqRun.sql.Add('AND SiteCode = '+IntToStr(TheSiteCode));
      adoqRun.sql.Add('AND StockCode = '+IntToStr(PrevStkCode));
      adoqRun.open;

      // set this thread's previous byHZ state
      PrevStkbyHZ := adoqRun.FieldByName('byHZ').AsBoolean;
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
          if curByHZ then
          begin
            adoqRun.close;
            adoqRun.sql.Clear;
            adoqRun.sql.Add('select count(*) as thecount from (');
            adoqRun.sql.Add('  SELECT (h.hzid + m.hzid) as thesum');
            adoqRun.sql.Add('  FROM  stkHZs H FULL OUTER JOIN');
            adoqRun.sql.Add('    (select HzID from Stkmisc');
            adoqRun.sql.Add('      WHERE tid = ' + inttostr(curTid));
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

      // set StartDate/Time ONLY as EndDate/Time are taken from the current MTh stock
      adoqRun.sql.Clear;
      adoqRun.sql.Add('Select a."SDate",a."EDate", a."STime",');
      adoqRun.sql.Add('a."ETime", a.SDT, a.EDT');
      adoqRun.sql.Add('From "stocks" a');
      adoqRun.sql.Add('Where a."StockCode" = '+IntToStr(PrevStkCode));
      adoqRun.sql.Add('and a."tid" = ' + IntToStr(curtid));

      adoqRun.open;
      Sdate := adoqRun.FieldByName('EDate').AsDateTime + 1;
      Stime := adoqRun.FieldByName('ETime').AsString;
      SDT := adoqRun.FieldByName('EDT').AsDateTime + StrToTime('00:01');

      adoqRun.close;
      // if last stk has an end time then set start time for this stk + 1 min
      if Stime <> '' then
      begin
         Stime := TimeToStr(StrToTime(Stime) + StrToTime('00:01'));
         NeedBeg := True;
      end
      else
      begin
         Stime := '';
         NeedBeg := False;
      end; //if
    end; // with data1

    errStr := 'Variables Initialised. Create...';

    //make new rec in CURSTOCK AND STKMISC
    with data1, dmADO.adoTRun do
    begin
      Close;
      TableName := 'curstock';
      Open;
      log.event('fCurrDlg.AccMth (Accepting Master Stock), appending record to CurrStock');
      if curBgCP then
        AppendRecord([TheSiteCode,curTid,StkCode,TheDiv,Sdate,Stime,Edate,Etime,SDT, EDT,null,
                      null,'UnAudited','B',null,null,s1,PrevStkCode,curByHZ,null, curRTRcp,
                      Now, curByLocation])
      else
        AppendRecord([TheSiteCode,curTid,StkCode,TheDiv,Sdate,Stime,Edate,Etime,SDT, EDT,null,
                      null,'UnAudited','A',null,null,s1,PrevStkCode,curByHZ,null, curRTRcp,
                      Now, curByLocation]);
      Close;
    end;

    with data1, dmADO.adoTRun do
    begin
      Close;
      TableName := 'stkmisc';
      Open;
      // first add the Site Wide record...
      log.event('fCurrDlg.AccMth (Accepting Master Stock), adding site wide record to stkMisc');
      AppendRecord([TheSiteCode,curtid,StkCode,0,null,null,null,null,null,
                    null,TheMgr,TheStkTkr,null,RepHdr,TheStkType,
                    null]);

      // then if needed add the individual HZs records
      if curByHz then
      begin
        log.event('fCurrDlg.AccMth (Accepting Master Stock), adding HZ records');
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
          log.event('fCurrDlg.AccMth (Accepting Master Stock), all HZ records added');
        end; // while

        dmADO.adoqRun.close;
      end;

      Close;
    end;

    // START Stock calculation PROCESSING
    errStr := 'Calculate Theoretical Figures';
    data1.UpdateCurrStage(0); // stage 0, sdate, edate, etc...
    data1.autoSlaveStk := True;

    dataproc.FastPurch(TRUE);

    if not dataProc.PreAudit(data1.curRTrcp, True, 0) then
    begin
      log.event('ERROR -fCurrDlg.AccMth (Accepting Master Stock), PreAudit did not work, Stage is now 0');
      exit;
    end;
    data1.PushStkMain; // push sales, purch data into stkmain
    data1.UpdateCurrStage(1); // stage 1, Sales & purch got & calc'ed & saved...

    log.event('fCurrDlg.AccMth (Accepting Master Stock), New Auto Stock Info Gathered - Copy Audit Counts from Master.');

    screen.Cursor := crHourGlass;

    errStr := 'Copy Audit Counts from the Master Thread';
    // first the Audit Counts...
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE [StkCrDiv] SET [AuditStk] = sq.[ActCloseStk],');
      sql.Add('[ActCloseStk] = sq.[ActCloseStk],');
      sql.Add('[WasteTillA] = sq.[WasteTillA], [WastePCA] = sq.[WastePCA], ');
      sql.Add('[Wastage] = [WasteTill] + [WastePC] + sq.[WasteTillA] + sq.[WastePCA]');
      sql.Add('from');
      sql.Add(' ( SELECT a.[hzid], a.[entitycode], a.[ActCloseStk], a.[WasteTillA], a.[WastePCA]');
      sql.Add('   FROM.[stkMain] a WHERE a.[stkcode] = '+IntToStr(data1.lastSThAccCode));
      sql.Add('   and [tid] = '+IntToStr(data1.curMth));
      sql.Add(' ) as sq');
      sql.Add('where [stkcrdiv].[entitycode] = sq.[entitycode] and [stkcrdiv].[hzid] = sq.[hzid]');
      Execsql;
    end;

    log.event('fCurrDlg.AccMth (Accepting Master Stock), Audit figures Copied. Start processing again...');

    errStr := 'Calculate Actual Figures';
    if not dataProc.PostAudit then
    begin
      log.event('ERROR - fCurrDlg.AccMth (Accepting Master Stock), PostAudit did not work');
      exit;
    end;

    // update stkmain.db from stkcrdiv.db
    data1.PushStkMain;
    data1.PushStkSold;
    data1.PushPrepared;

    data1.UpdateCurrStage(3); // stage 3, All audit figs, costs, prices, sitems calc'ed

    errStr := 'Set Misc. Allowances and Takings';
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

      // null and 0 the fields that are always recalcualted ...
      Close;
      sql.Clear;
      sql.Add('update stkCrMisc set totInc = 0, totNetInc = 0, totTillVar = 0, totAWValue = 0');
      execSQL;

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
        sql.Add('and a.[pos code] = t.poscode and t.TerminalID = b.TerminalID group by b.hzid) as sq');
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

      // now set the misc Allowance and Takings as differences...

      // select and sum up data from the Accepted Slave Stocks for the Master Stock period...
      if data1.firstSThAccCode > 1 then
      begin
        close;
        sql.Clear;
        sql.Add('update stkCrMisc set [MiscBal1] = sq.[Misc1], [MiscBal2] = sq.[Misc2],');
        sql.Add('  [MiscBal3] = sq.[Misc3], [Banked] = sq.[take]');
        sql.Add('from');
        sql.Add('  (select hzid, sum([MiscBal1]) as misc1, sum([MiscBal2]) as misc2,');
        sql.Add('     sum([MiscBal3]) as misc3, sum(banked) as take');
        sql.Add('     from stkMisc');
        sql.Add('     where tid = '+IntToStr(data1.CurTid));
        sql.Add('     and stockcode >= ' + inttostr(data1.firstSThAccCode));
        sql.Add('   group by hzid) sq');
        sql.Add('where stkCrMisc.hzid = sq.hzid');
        execSQL;
      end;

      // zero out the misc bal fields in case they are NULL
      close;
      sql.Clear;
      sql.Add('update stkCrMisc set ');
      sql.Add(' [banked] = (CASE WHEN [banked] is NULL THEN 0 ELSE [banked] END),');
      sql.Add(' [miscBal1] = (CASE WHEN [miscBal1] is NULL THEN 0 ELSE [miscBal1] END),');
      sql.Add(' [miscBal2] = (CASE WHEN [miscBal2] is NULL THEN 0 ELSE [miscBal2] END),');
      sql.Add(' [miscBal3] = (CASE WHEN [miscBal3] is NULL THEN 0 ELSE [miscBal3] END)');
      execSQL;

      // do the same for the MTh now, before calcualtions...
      close;
      sql.Clear;
      sql.Add('update stkMisc set ');
      sql.Add(' [miscBal1] = (CASE WHEN [miscBal1] is NULL THEN 0 ELSE [miscBal1] END),');
      sql.Add(' [miscBal2] = (CASE WHEN [miscBal2] is NULL THEN 0 ELSE [miscBal2] END),');
      sql.Add(' [miscBal3] = (CASE WHEN [miscBal3] is NULL THEN 0 ELSE [miscBal3] END)');
      sql.Add('where tid = '+IntToStr(data1.curMth));
      sql.Add('and stockcode >= ' + inttostr(data1.lastSThAccCode));
      execSQL;


      close;
      sql.Clear;
      sql.Add('update stkCrMisc set ');
      sql.Add('  [MiscBalReason1] = sq.[MiscBalReason1], [MiscBal1] = sq.[Misc1] - [MiscBal1],');
      sql.Add('  [MiscBalReason2] = sq.[MiscBalReason2], [MiscBal2] = sq.[Misc2] - [MiscBal2],');
      sql.Add('  [MiscBalReason3] = sq.[MiscBalReason3], [MiscBal3] = sq.[Misc3] - [MiscBal3],');
      sql.Add('  [Banked] = sq.[take] - [Banked], StockNote = ' +
               quotedSTR('This was Automatically Created, Calculated and Accepted by the Master Thread "' +
                 data1.curMthName + '"'));
      sql.Add('from');
      sql.Add('  (select hzid, ([MiscBal1]) as misc1, ([MiscBal2]) as misc2,');
      sql.Add('     ([MiscBal3]) as misc3, (banked) as take,');
      sql.Add('   [MiscBalReason1], [MiscBalReason2], [MiscBalReason3]');
      sql.Add('     from stkMisc');
      sql.Add('     where tid = '+IntToStr(data1.curMth));
      sql.Add('     and stockcode >= ' + inttostr(data1.lastSThAccCode));
      sql.Add('   ) sq');
      sql.Add('where stkCrMisc.hzid = sq.hzid');
      execSQL;

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


    data1.UpdateCurrStage(4); // stage 4, ready for acceptance
    log.event('fCurrDlg.AccMth (Accepting Master Stock), Auto Stock complete');

    screen.Cursor := crHourGlass;

    // now ACCEPT the Auto slave stock
    errStr := 'Accept for the Subordinate Thread';

    if not data1.curNoPurAcc then
    begin
      if not AcceptPurch then
      begin
        showMessage('Invoices involved in this ' + data1.SSlow + ' could not be accepted because of an error!' +
          #13 + #13 +
          'This ' + data1.SSlow + ' can not be accepted until that error is fixed.');

        log.event('fCurrDlg.AccMth (Accepting Master Stock), Sub. Stock Acceptance stopped because of error in Accept Purchases');
        data1.killStock(data1.curTid, data1.StkCode);
        exit;
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
        sql.Add('(SELECT hzid, sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
        sql.Add('  sum(b."opStk" * b."opCost") as opCost,');
        sql.Add('  sum(moveQty * moveCost) as moveCost,');

        sql.Add('  (sum ');
        sql.Add('   (CASE');
        sql.Add('    WHEN b.key2 >= 1000 THEN 0');
        sql.Add('    ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
        sql.Add('   END)) as gains,');

        sql.Add('  (sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
        sql.Add('  (sum (b."wastage" * b."NomPrice")) as faultVal');
        sql.Add('  FROM "StkCrDiv" b group by hzid) sq');
        sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        sql.Add('and stkMisc.hzid = sq.hzid');
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
        sql.Add('(select hzid, (sum(a."income")) as income,');
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
        sql.Add('  FROM "StkCrSld" a group by hzid) sq');
        sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        sql.Add('and stkMisc.hzid = sq.hzid');
        execSQL;

        per := trunc(data1.Edate - data1.Sdate + 1);

        errStr := 'put period figures into StkMisc';
        // now put all this into StkMisc
        close;
        sql.Clear;
        sql.Add('update stkMisc set');
        sql.Add('	[Per] = ' + inttostr(Per) + ', ');
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

        theNow := Now;
        close;
        sql.Clear;
        sql.Add('insert Stocks ([SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
        sql.Add('      [ETime], [SDT], [EDT], [AccDate], [AccTime], [Stage], [Type], [DateRecalc],');
        sql.Add('      [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], [LMDT], [AccBy], [PureAZ], [rtRcp])');
        sql.Add('select [SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
        sql.Add('       [ETime], [SDT], [EDT], ' + quotedStr(formatDateTime('yyyymmdd', Date)) + ',' +
          quotedStr(formatDateTime('hh:nn', Time)) + ', ''Accepted'', [Type], [DateRecalc],');
        sql.Add('       [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], ' +
          quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', theNow)) + ', ' + quotedStr(CurrentUser.UserName) + ', 1, [rtRcp]');
        sql.Add('from curstock');
        sql.Add('WHERE StockCode = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        execSQL;

        // now set lmdt on StkMain and StkSold to have these recs tx'd to the HO
        errStr := 'update StkMain set lmdt';
        close;
        sql.Clear;
        sql.Add('update StkMain set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
        sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        execSQL;

        errStr := 'update StkSold set lmdt';
        close;
        sql.Clear;
        sql.Add('update StkSold set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
        sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        execSQL;

        errStr := 'DELETE FROM "Audit"';
        close;
        sql.Clear;
        sql.Add('DELETE FROM "Audit"');
        sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        ExecSQL;

        errStr := 'DELETE FROM "curstock"';
        close;
        sql.Clear;
        sql.Add('DELETE FROM "curstock"');
        sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
        sql.Add('and tid = '+IntToStr(data1.curtid));
        ExecSQL;
      end; // with
      errStr := 'Requery & Refresh';
    except
      on E:Exception do
      begin
        ShowMessage('ERROR Accepting the ' + data1.ssBig + ' of the Subordinate Thread' + #13 + 'Error Location: ' + errstr +
          #13 + 'Error Message: ' + E.Message);

        log.event('ERROR - fCurrDlg.AccMth (Accepting Master Stock), Accepting Stock (Tid: ' + IntToStr(data1.curtid) +
          ', StkCode: ' + IntToStr(data1.StkCode) + ') Location: ' + errstr +
          ' Message: ' + E.Message);

        data1.killStock(data1.curtid, data1.StkCode);

        exit;
      end;
    end;

    screen.Cursor := crHourGlass;

    with dmADO.adoqRun do
    begin
      if NOT data1.curTidAsBase then // curTidAsBase is still the Master Thread's setting
      begin                          // if TRUE, let the Master Stock do the ECL update but if not...
        if slaveAsBase then
        begin
          if data1.curByHZ then // CAN act as Base for LC/SC
          begin                // update stkECLevel
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
                  log.event('fCurrDlg.AccMth (Accepting Master Stock), SP Body NOT Executed - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
                 else
                   log.event('fCurrDlg.AccMth (Accepting Master Stock), SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
                    ' RET CODE: ' + fields[0].AsString);
                except
                  on E:Exception do
                    log.event('fCurrDlg.AccMth (Accepting Master Stock), SP ERROR -  "' + sql[1] + '"' +
                    ' ERR MSG: ' + E.Message);
                end;
                Close;
              end;
              spConn.Close;
            end;
            dmRunSP.Free;
          end
          else
          begin
            // is there any thread with byHZ, with LCBase and at least 1 stock accepted for THIS division?
            with dmADO.adoqRun2 do
            begin
              close;
              sql.Clear;
              sql.Add('select count(*) as thecount from Threads where division = ' + quotedStr(data1.TheDiv));
              sql.Add('and byHZ = 1 and LCBase = 1 and Active = ''Y''');
              sql.Add('and Tid in (select Tid from stocks where stockcode > 1)');
              open;

              if FieldByName('thecount').AsInteger = 0 then
              begin
                // update stkECLevel
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
                      log.event('fCurrDlg.AccMth (Accepting Master Stock), SP Body NOT Executed - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
                     else
                       log.event('fCurrDlg.AccMth (Accepting Master Stock), SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
                        ' RET CODE: ' + fields[0].AsString);
                    except
                      on E:Exception do
                        log.event('fCurrDlg.AccMth (Accepting Master Stock), SP ERROR - "' + sql[1] + '"' +
                        ' ERR MSG: ' + E.Message);
                    end;
                    Close;
                  end;
                  spConn.Close;
                end;
                dmRunSP.Free;
              end;
              close;
            end;
          end;
        end;
      end;
    end;

    log.event('fCurrDlg.AccMth (Accepting Master Stock), Sub. Stock Accepted.');

    errStr := 'All OK with Sub Thread Stock';
  except
    on E: exception do
    begin
      ShowMessage('ERROR Accepting the ' + data1.ssBig + ' of the Subordinate Thread' + #13 + 'Error Location: ' + errstr +
        #13 + 'Error Message: ' + E.Message);
      log.event('fCurrDlg.AccMth (Accepting Master Stock) - ERROR Accepting the ' + data1.ssBig +
        ' of the Subordinate Thread - Error Location: ' + errstr + ' Error Message: ' + E.Message);
      data1.killStock(data1.curtid, data1.StkCode);

      exit;
    end;
  end;

  screen.Cursor := crHourGlass;

  if errStr <> 'All OK with Sub Thread Stock' then
  begin
    ShowMessage('ERROR Accepting the ' + data1.ssBig + ' of the Subordinate Thread' + #13 +
      'Error Location: ' + errstr);
    log.event('fCurrDlg.AccMth (Accepting Master Stock) - ERROR Accepting the ' + data1.ssBig +
      ' of the Subordinate Thread - Error Location: ' + errstr);
    data1.killStock(data1.curtid, data1.StkCode);

    exit;
  end;


  // if all OK by this point then accept the MTh stock
  // save the Slave Stock tid and code to use in KillSlaveStock
  slaveTh := data1.CurTid;
  slaveStk := data1.StkCode;

  //Re-locate the master stock in the wwqCurStk dataset before re-initialising the current stock variables by calling initCurr
  if not wwqCurStk.Locate('Tid;StockCode', VarArrayOf([masterThread, masterStock]), []) then
  begin
    MessageDlg('Error accepting stock. Failed to relocate the Master ' + data1.SSlow + ' in the local dataset.'#13#10+
        'The  ' + data1.SSlow + ' acceptance process has been aborted. Please contact Zonal',
        mtError, [mbOk], 0);

    log.event('fCurrDlg.AccMth (Accepting Master Stock), Stock Acceptance abandoned due to an error. ' +
        'Failed to relocate the Master stock in the wwqCurStk dataset.');

    data1.killStock(slaveTh, slaveStk);
    exit;
  end;

  data1.initCurr(wwqCurStk.FieldByName('tid').AsInteger,
                     wwqCurStk.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

  log.event('fCurrDlg.AccMth (Accepting Master Stock), Start Accepting a stock');

  if not data1.curNoPurAcc then
  begin
    if not AcceptPurch then
    begin
      showMessage('Invoices involved in this ' + data1.SSlow + ' could not be accepted because of an error!' +
        #13 + #13 +
        'This ' + data1.SSlow + ' can not be accepted until that error is fixed.');

      log.event('fCurrDlg.AccMth (Accepting Master Stock), Stock Acceptance stopped because of error in Accept Purchases');
      data1.killStock(slaveTh, slaveStk);
      exit;
    end;
  end;

  screen.Cursor := crHourGlass;

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
      sql.Add('(SELECT hzid, sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
      sql.Add('  sum(b."opStk" * b."opCost") as opCost,');
      sql.Add('  sum(moveQty * moveCost) as moveCost,');

      sql.Add('  (sum ');
      sql.Add('   (CASE');
      sql.Add('    WHEN b.key2 >= 1000 THEN 0');
      sql.Add('    ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
      sql.Add('   END)) as gains,');

      sql.Add('  (sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
      sql.Add('  (sum (b."wastage" * b."NomPrice")) as faultVal');
      sql.Add('  FROM "StkCrDiv" b group by hzid) sq');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      sql.Add('and stkMisc.hzid = sq.hzid');
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
      sql.Add('(select hzid, (sum(a."income")) as income,');
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
      sql.Add('  FROM "StkCrSld" a group by hzid) sq');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      sql.Add('and stkMisc.hzid = sq.hzid');
      execSQL;

      per := trunc(data1.Edate - data1.Sdate + 1);

      errStr := 'put period figures into StkMisc';
      // now put all this into StkMisc
      close;
      sql.Clear;
      sql.Add('update stkMisc set');
      sql.Add('	[Per] = ' + inttostr(Per) + ', ');
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

      theNow := Now;
      close;
      sql.Clear;
      sql.Add('insert Stocks ([SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('      [ETime], [SDT], [EDT], [AccDate], [AccTime], [Stage], [Type], [DateRecalc],');
      sql.Add('      [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], [LMDT], [AccBy], [PureAZ], [rtRcp])');
      sql.Add('select [SiteCode], [Tid], [StockCode], [Division], [SDate], [STime], [EDate],');
      sql.Add('       [ETime], [SDT], [EDT], ' + quotedStr(formatDateTime('yyyymmdd', Date)) + ',' +
          quotedStr(formatDateTime('hh:nn', Time)) + ', ''Accepted'', [Type], [DateRecalc],');
      sql.Add('       [TimeRecalc], [StkKind], [PrevStkCode], [ByHz], ' +
          quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', theNow)) + ', ' + quotedStr(CurrentUser.UserName) + ', 1, [rtRcp]');
      sql.Add('from curstock');
      sql.Add('WHERE StockCode = '+ IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      // now set lmdt on StkMain and StkSold to have these recs tx'd to the HO
      errStr := 'update StkMain set lmdt';
      close;
      sql.Clear;
      sql.Add('update StkMain set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
      sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'update StkSold set lmdt';
      close;
      sql.Clear;
      sql.Add('update StkSold set lmdt = ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', theNow)));
      sql.Add('WHERE StkCode = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      execSQL;

      errStr := 'DELETE FROM "Audit"';
      close;
      sql.Clear;
      sql.Add('DELETE FROM "Audit"');
      sql.Add('WHERE "StkCode" = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      ExecSQL;

      errStr := 'DELETE FROM "curstock"';
      close;
      sql.Clear;
      sql.Add('DELETE FROM "curstock"');
      sql.Add('WHERE "StockCode" = '+IntToStr(data1.StkCode));
      sql.Add('and tid = '+IntToStr(data1.curtid));
      ExecSQL;
    end; // with
    errStr := 'Requery & Refresh';

    wwqCurStk.Requery;
    Grid.Refresh;
  except
    on E:Exception do
    begin
      ShowMessage('ERROR Accepting Master ' + data1.ssbig + #13 + 'Error Location: ' + errstr +
        #13 + 'Error Message: ' + E.Message);

      log.event('fCurrDlg.AccMth (Accepting Master Stock) - ERROR Accepting Stock (Tid: ' + IntToStr(data1.curtid) +
        ', StkCode: ' + IntToStr(data1.StkCode) + ') Location: ' + errstr +
        ' Message: ' + E.Message);

      data1.killStock(slaveTh, slaveStk);

      exit;
    end;
  end;

  screen.Cursor := crHourGlass;

  with dmADO.adoqRun do
  begin
    if data1.curTidAsBase then
    begin
      // update stkECLevel
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
            log.event('SP Body NOT Executed - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"')
           else
             log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' + sql[1] + '"' +
              ' RET CODE: ' + fields[0].AsString);

          except
            on E:Exception do
              log.event('fCurrDlg.AccMth (Accepting Master Stock) - SP ERROR - "' + sql[1] + '"' +
              ' ERR MSG: ' + E.Message);
          end;
          Close;
        end;
        spConn.Close;
      end;
      dmRunSP.Free;
    end
    else if not data1.curDivAsBase then
    begin // if no tid in this div is NOW a Base then if there delete any data for that Div in stkECLevel
      close;
      sql.Clear;
      sql.Add('delete stkECLevel where division = ' + quotedStr(data1.TheDiv));
      per := execSQL; // reuse per to get the records deleted...
      log.event('fCurrDlg.AccMth (Accepting Master Stock) - DELETED ' + inttostr(per) + ' records from stkECLevel as Div: "' + data1.TheDiv +
           '" no longer has any Tids serving as Base.');
    end;
  end;
  log.event('fCurrDlg.AccMth (Accepting Master Stock), Stock Accepted.');

  // now send reports straight to printer using thread settings...

  if data1.curAutoRep then
  begin
    try
      AutoPrint;
    except
      on E : Exception do
      begin
        // log

        // warn

      end;
    end;
  end;
 finally
   screen.Cursor := crDefault;
 end;

 if wwqCurStk.RecordCount = 0 then
 begin
   showMessage('There are no more Current ' + data1.SSplural + ' to view!');
   modalResult := mrOK;
 end;
 log.event('Exiting fCurrDlg.AccMth (Accepting Master Stock)');
end;


{Used to minimise the whole app if the current form is minimised}
procedure TfCurrdlg.WMSysCommand;
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

procedure TfCurrdlg.Label3DblClick(Sender: TObject);
begin
  if data1.ssDebug then
    pnlDebug.Visible := not pnlDebug.Visible;
end;

procedure TfCurrdlg.Label1DblClick(Sender: TObject);
begin
  sbAudNoRec.Visible := not(sbAudNoRec.Visible);
end;

procedure TfCurrdlg.sbAudNoRecClick(Sender: TObject);
begin
  btnRecAudClick(Sender);
end;

function TfCurrdlg.CheckCurrentStockBalances(StartDate,
  EndDate, LastRecalc: TDateTime): Boolean;
begin
  log.event('In fCurrdlg,CheckCurrentStockBalances');
  with qryRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT COUNT(*) AS SqlCount');
    Sql.Add('FROM dbo.[PurchHdrAztec] P');
    Sql.Add('WHERE P.[Date] BETWEEN :SDate AND :EDate');
    Sql.Add('AND P.[LMDT] > :LastRecalc');
    Sql.Add('AND P.[Deleted] is Null');
    Parameters.ParamByName('SDate').Value := StartDate;
    Parameters.ParamByName('EDate').Value := EndDate;
    Parameters.ParamByName('LastRecalc').Value := LastRecalc;
    Open;
    Result := FieldByName('SqlCount').AsInteger = 0;
  end;
  log.event('Leaving fCurrdlg,CheckCurrentStockBalances');
end;

end.

