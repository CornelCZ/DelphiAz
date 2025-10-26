unit uWaitAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ppReport, DB, ADODB,ppPrintr;

type
  TfWaitAR = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    labRep: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    qryRun: TADOQuery;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DoPrinting;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    killAutoRep, doing : boolean;
    theRep : TppReport;
  public
    { Public declarations }
    thedevice : string;
  end;

var
  fWaitAR: TfWaitAR;

implementation

uses udata1, uADO, uCurrdlg, uRepHold, uRepSP, uRepTrad;

{$R *.dfm}

procedure TfWaitAR.FormActivate(Sender: TObject);
begin

  if data1.ssDebug then
    theDevice := 'Archive'
  else
    theDevice := 'Printer';

  killAutoRep := False;
  doing := False;
  Timer1.Enabled := True;
end;

procedure TfWaitAR.Timer1Timer(Sender: TObject);
begin
  if label4.Font.Color = clWhite then
    label4.Font.Color := clBlack
  else
    label4.Font.Color := clWhite;

  if not doing then
  begin
    doing := True;
    DoPrinting;
  end
  else
  begin
    if killAutoRep then
    begin
      // try to stop this....
      if Assigned(theRep) then
        theRep.Cancel;
      Application.ProcessMessages;

      modalResult := mrCancel;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TfWaitAR.DoPrinting;
var
  cnt, curno : integer;
  holdP, holdT, holdV, sp, lgCV, lgC, lgV, Trad, RetC, RetP : boolean; //, lgHZ, HZMP
  repHZidStr : string;
begin
  // take each report in turn (reports codes are by necessity hardcoded...)
  repHZidStr := '0';
  curno := 0;
  cnt := fCurrDlg.qryRun.RecordCount;


  holdP := fCurrDlg.qryRun.Locate('AR', 1, []);
  holdT := fCurrDlg.qryRun.Locate('AR', 2, []);
  holdV := fCurrDlg.qryRun.Locate('AR', 10, []);
  sp := fCurrDlg.qryRun.Locate('AR', 3, []);
  lgCV := fCurrDlg.qryRun.Locate('AR', 6, []);
  lgC := fCurrDlg.qryRun.Locate('AR', 4, []);
  lgV := fCurrDlg.qryRun.Locate('AR', 5, []);
  Trad := fCurrDlg.qryRun.Locate('AR', 7, []);
  RetC := fCurrDlg.qryRun.Locate('AR', 8, []);
  RetP := fCurrDlg.qryRun.Locate('AR', 9, []);
//  lgHZ := fCurrDlg.qryRun.Locate('AR', 11, []);
//  HZMP := fCurrDlg.qryRun.Locate('AR', 12, []);

  // Do Holding reps and LG
  if holdP or holdT or holdV or lgCV or lgC or lgV then //or lgHZ
  begin
    fRepHold := TfRepHold.Create(Self);
    fRepHold.wwqRun.Close;

    if holdP or holdT or holdV then
    begin
      labRep.Caption := 'Preparing for Holding reports (done ' +
        inttostr(curno) + ' of ' + inttostr(cnt) + ')';

      data1.HoldRepQuery(repHZidStr, fRepHold.wwqRun);
      fRepHold.wwqRun.open;

      if fRepHold.wwqRun.recordcount = 0 then
      begin
        //showmessage('No ' + data1.SSsmall + ' movement detected. Nothing to report.');
      end
      else
      begin
        with dmADO.adoqRun do
        begin
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
        end;

        fRepHold.ppsubreport2.Visible := false;
        fRepHold.ppsubreport3.Visible := false;
        fRepHold.ppsubreport4.Visible := false;
        fRepHold.ppsubreport5.Visible := false;
        fRepHold.ppSubReport6.Visible := False;
        fRepHold.ppSubReport7.Visible := False;
        fRepHold.ppsubreport2.DataPipeline := nil;
        fRepHold.ppsubreport3.DataPipeline := nil;
        fRepHold.ppsubreport4.DataPipeline := nil;
        fRepHold.ppsubreport5.DataPipeline := nil;
        fRepHold.ppsubreport6.DataPipeline := nil;
        fRepHold.ppsubreport7.DataPipeline := nil;

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
        fRepHold.doTheo := False;

        if holdP then
        begin
          inc(curno);
          labRep.Caption := 'Holding - Basic Version (Portrait page) (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';

          fRepHold.ppHoldRep.ShowPrintDialog := False;
          fRepHold.ppHoldRep.DeviceType := theDevice;
          theRep := fRepHold.ppHoldRep;
          fRepHold.ppHoldRep.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppHoldRep.Print;
        end;
        if holdT then
        begin
          inc(curno);
          labRep.Caption := 'Holding - with Theo. & Prep. Reduction (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';

          fRepHold.ppHoldRepBig.ShowPrintDialog := False;
          fRepHold.ppHoldRepBig.DeviceType := theDevice;
          theRep := fRepHold.ppHoldRepBig;
          fRepHold.ppHoldRepBig.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppHoldRepBig.Print;
        end;
        if holdV then
        begin
          inc(curno);
          labRep.Caption := 'Holding - with Var. Cost/Value & Yield (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';

          fRepHold.ppHoldRep2.ShowPrintDialog := False;
          fRepHold.ppHoldRep2.DeviceType := theDevice;
          theRep := fRepHold.ppHoldRep2;
          fRepHold.ppHoldRep2.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppHoldRep2.Print;
        end;
      end;

      fRepHold.wwqRun.Close;
    end;

    if lgCV or lgC or lgV then
    begin
      labRep.Caption := 'Preparing for LossGain reports (done ' +
        inttostr(curno) + ' of ' + inttostr(cnt) + ')';

      fRepHold.adoqLG.Close;
      data1.LGRepQuery(repHZidStr, fRepHold.adoqLG);
      fRepHold.adoqLG.Open;
      fRepHold.doTheo := False;

      if fRepHold.adoqLG.RecordCount = 0 then
        //showmessage('There are no Losses or Gains to report.')
      else
      begin
        fRepHold.ppLabel352.Visible := False;
        fRepHold.ppLabel353.Visible := False;

        if lgC then
        begin
          inc(curno);
          labRep.Caption := 'Loss/Gain - at Cost (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';
          with fRepHold do
          begin
            pplabel84.Text := 'Cost';
            ppdbtext47.DataField := 'sc';
            ppdbtext50.DataField := 'dc';
            ppdbtext54.DataField := 'Wc';
            ppdbtext48.DataField := 'totc';
            pplabel65.Text := data1.SSbig + ' Loss/Gain Cost Report';

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

          fRepHold.ppLGsmall.ShowPrintDialog := False;
          fRepHold.ppLGsmall.DeviceType := theDevice;
          theRep := fRepHold.ppLGsmall;
          fRepHold.ppLGsmall.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppLGsmall.Print;
        end;

        if lgV then
        begin
          inc(curno);
          labRep.Caption := 'Loss/Gain - at Value (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';
          with fRepHold do
          begin
            pplabel84.Text := 'Value';
            ppdbtext47.DataField := 'sv';
            ppdbtext50.DataField := 'dv';
            ppdbtext54.DataField := 'Wv';
            ppdbtext48.DataField := 'totv';
            pplabel65.Text := data1.SSbig + ' Loss/Gain Value Report';

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

          fRepHold.ppLGsmall.ShowPrintDialog := False;
          fRepHold.ppLGsmall.DeviceType := theDevice;
          theRep := fRepHold.ppLGsmall;
          fRepHold.ppLGsmall.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppLGsmall.Print;
        end;

        if lgCV then
        begin
          inc(curno);
          labRep.Caption := 'Loss/Gain - Cost & Value (' +
            inttostr(curno) + ' of ' + inttostr(cnt) + ')';

          fRepHold.ppLG.ShowPrintDialog := False;
          fRepHold.ppLG.DeviceType := theDevice;
          theRep := fRepHold.ppLG;
          fRepHold.ppLG.PrinterSetup.PaperName := data1.repPaperName;
          fRepHold.ppLG.Print;
        end;
      end;

      fRepHold.adoqLG.Close;
    end;
    fRepHold.Free;
  end;

  // SalesProfDM based reports...
  if sp then //or hzmp
  begin
    inc(curno);
    labRep.Caption := 'Sales & Profitability Report (' +
      inttostr(curno) + ' of ' + inttostr(cnt) + ')';

    if data1.SPQuery(repHZidStr) = 0 then
    begin
      //showmessage('No stockable products have been sold. Nothing to report.');
    end
    else
    begin
      fRepSP := TfRepSP.Create(Self);
      fRepSP.spSlave := False;

      fRepSP.wwqRun.close;
      fRepSP.wwqRun.sql.Clear;
      fRepSP.wwqRun.sql.Add('select * from [#sp] order by SubCatName, RetailName, producttype');
      fRepSP.wwqRun.Open;

      fRepSP.ppSPslave.Visible := False;
      fRepSP.ppSPslave.DataPipeline := nil;
      fRepSP.ppShape19.Visible := False;
      fRepSP.ppLabel349.Visible := False;
      fRepSP.doTheo := False;

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

      fRepSP.wwqOrphan.Close;
      fRepSP.wwqOrphan.Open;

      fRepSP.ppS_PRep.ShowPrintDialog := False;
      fRepSP.ppS_PRep.DeviceType := theDevice;
      theRep := fRepSP.ppS_PRep;
      fRepSP.ppS_PRep.PrinterSetup.PaperName := data1.repPaperName;
      fRepSP.ppS_PRep.Print;

      fRepSP.wwqOrphan.Close;
      fRepSP.wwqRun.Close;

      fRepSP.Free;
    end;
  end;

  // Do Summary reps
  if trad or retC or retP then
  begin
    fRepTrad := TfRepTrad.Create(Self);
    fRepTrad.audited := True;
    fRepTrad.repHZid := 0;
    fRepTrad.repHZidStr := repHZidStr;

    if trad then
    begin
      inc(curno);
      labRep.Caption := 'Traditional Summary (' +
        inttostr(curno) + ' of ' + inttostr(cnt) + ')';

      if fRepTrad.MakeRep then
      begin
        fRepTrad.ppLabel349.Visible := False;
        fRepTrad.pplabel211.Visible := True;
        fRepTrad.pplabel211.Caption := 'Cost of Purchases';
        fRepTrad.ppLabel212.Visible := False;
        fRepTrad.pplabel32.Caption := ' Purchases   Cost';

        fRepTrad.ppTrad.ShowPrintDialog := False;
        fRepTrad.ppTrad.DeviceType := theDevice;
        theRep := fRepTrad.ppTrad;
        fRepTrad.ppTrad.PrinterSetup.PaperName := data1.repPaperName;
        fRepTrad.ppTrad.Print;
      end;
    end;

    if retC then
    begin
      inc(curno);
      labRep.Caption := 'Retail Summary - Cost Variance (' +
        inttostr(curno) + ' of ' + inttostr(cnt) + ')';

      fRepTrad.prof := False;

      if fRepTrad.MakeRetRep then
      begin
        fRepTrad.ppLabel210.Visible := False;
        fRepTrad.pplabel105.Caption := ' Purchases   Cost';

        fRepTrad.ppRet.ShowPrintDialog := False;
        fRepTrad.ppRet.DeviceType := theDevice;
        theRep := fRepTrad.ppRet;
        fRepTrad.ppRet.PrinterSetup.PaperName := data1.repPaperName;
        fRepTrad.ppRet.Print;
      end;
    end;

    if retP then
    begin
      inc(curno);
      labRep.Caption := 'Retail Summary - Profit Variance (' +
        inttostr(curno) + ' of ' + inttostr(cnt) + ')';

      fRepTrad.prof := True;

      if fRepTrad.MakeRetRep then
      begin
        fRepTrad.ppLabel210.Visible := False;
        fRepTrad.pplabel105.Caption := ' Purchases   Cost';

        fRepTrad.ppRet.ShowPrintDialog := False;
        fRepTrad.ppRet.DeviceType := theDevice;
        theRep := fRepTrad.ppRet;
        fRepTrad.ppRet.PrinterSetup.PaperName := data1.repPaperName;
        fRepTrad.ppRet.Print;
      end;
    end;

    fRepTrad.Free;
  end;

  // ready....
  modalResult := mrOK;
  Application.ProcessMessages;
end;


procedure TfWaitAR.BitBtn1Click(Sender: TObject);
begin
  killAutoRep := True;
end;

end.
