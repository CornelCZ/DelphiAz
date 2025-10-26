unit U1WklyPurch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, ComCtrls, checklst, ExtCtrls, Wwdbigrd,
  Wwdbgrid, wwdblook, Wwdbdlg, Buttons, ppViewr, DBTables, Wwkeycb, ppCtrls,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, DBCtrls;

type
  Tfrm1wklypurch = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    WaitLbl: TLabel;
    ConfigBttn: TBitBtn;
    CloseBitBtn: TBitBtn;
    BitBtn1: TBitBtn;
    WPRPanel: TPanel;
    OrderByRadioGrp: TRadioGroup;
    PrintBttn: TBitBtn;
    DatePick: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    WkSelLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PrintBttnClick(Sender: TObject);
    Procedure ChangeRepOrd;
    procedure ToggleControls(toggle: boolean);
    procedure ConfigBttnClick(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DatePickChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RepStart, RepEnd: TDateTime; // user selected start & end dates for report
    CalFDate, CalLDate: TDateTime; //set to First & last invoice dates in ACCPURHD.DB and PURCHHDR.DB
    ToXY,FromXY: TGridCoord;
    FromRec, ToRec: integer;
    Fromstr, TmpStr: TstringList;
    Generated: Boolean;
    stweek: integer;	// purchase start of week
    TheSiteName: String;
    procedure InitStartScreen;
    procedure FindWeek(DateToFind: Tdate);
    procedure GenerateRep;
    function GetStartOfWeek: integer;
  end;

var
  frm1wklypurch: Tfrm1wklypurch;

implementation

uses
  uDMWklyPrchRep, config, uRptMenu1, uGlobals, uADO, uLog;

{$R *.DFM}

procedure Tfrm1wklypurch.InitStartScreen;
begin
  Generated := False;
  OrderByRadioGrp.ItemIndex := 0;
  frm1wklypurch.WPRPanel.Visible := False;
  CloseBitBtn.Enabled := True;
  Application.ProcessMessages;
end;

Procedure Tfrm1wklypurch.ChangeRepOrd;
Var
  RepOrd: Integer;
begin
  try
    With frmDMwklyprchrep.wwFixedCatsTbl do
    begin
      log.event('Weekly Purchase Report; ChangeRepOrd: wwFixedCatsTbl opened: ' + frmDMwklyprchrep.wwFixedCatsTbl.TableName);
      Open;
      First;
      // set display labels in WKLYPURCH.DB to 'Report Name' in wwFixedCatsTbl
      While not EOF do
      begin
        frmDMwklyprchrep.TblWklyPurch.FieldByName(FieldValues['Map Name']).
                                                      DisplayLabel := FieldValues['Report Name'];
        RepOrd := FieldValues['Report Order'];

        frmDMwklyprchrep.TblWklyPurch.FieldByName(FieldValues['Map Name']).Index := (RepOrd + 3);
        Next;
      end; //while
      First;
    end; //with

    With frmDMwklyprchrep.TblWklyPurch do
    begin
      log.event('Weekly Purchase Report; ChangeRepOrd: TblWklyPurch opened: ' + frmDMwklyprchrep.TblWklyPurch.TableName );
      Open;
      FieldByName('C1').DisplayLabel := 'C';
      FieldByName('C2').DisplayLabel := 'C';
      FieldByName('Others_Coded1').DisplayLabel := 'Others Coded';
      FieldByName('Others_Coded2').DisplayLabel := 'Others Coded';
    end;
    frmDMWklyPrchRep.qryWklyPurch.Close;
    frmDMWklyPrchRep.qryWklyPurch.Open;

  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report; ERROR - ChangeRepOrd: ' + E.Message);
      raise;
    end
  end;
end;

procedure Tfrm1wklypurch.ToggleControls(toggle: boolean);
begin
  OrderByRadioGrp.Enabled := toggle;
  PrintBttn.Enabled := toggle;
end;

procedure Tfrm1wklypurch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmDMWklyPrchRep.TblWklyPurch.active := False;
  frmDMWklyPrchRep.OthersSmryQry2.Close;
  frmDMWklyPrchRep.OthersSmryQry1.Close;
  frmDMWklyPrchRep.otherssmry2TBL.Close;
  log.event('Weekly Purchase Report; Weekly Purchase Report closed');
end;

procedure Tfrm1wklypurch.GenerateRep;
begin
  log.event('Weekly Purchase Report; Generating Report..');
  Screen.Cursor := crHourGlass;
  WaitLbl.Visible := True;
  Application.ProcessMessages;
  { TODO -owilma -ctidy up :
FindWeek is called every time DatePick is changed so there is no need to
call it here or anywhere else for DatePick.Date }
  FindWeek(DatePick.Date);
  try
    frmDMWklyPrchRep.MakeReportTable;  // generate report table
  except
    on E:Exception do
    begin
      ShowMessage('Unable to generate report.'+#13+E.Message);
      log.event('Weekly Purchase Report; ERROR - GenerateRep: Unable to generate report. ' + E.Message);
      generated := False;
    end;//on
  end; //try
  WaitLbl.Visible := False;
  Application.ProcessMessages;
  if Generated = False then
  begin
    Screen.Cursor := crDefault;
    InitStartScreen;
  end
  else
  begin
    ChangeRepOrd;
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
end;

procedure Tfrm1wklypurch.FormShow(Sender: TObject);
// set calender min/max and selected dates
begin
  log.event('Weekly Purchase Report; FormShow');
  InitStartScreen;
  try
    with frmDMWklyPrchRep do
    begin
      // get min, max dates from Accpted invoices
      Qweeks.Close;
      Qweeks.SQL.Clear;
      Qweeks.SQL.Add('SELECT min([date]) as mindate, max([date]) as maxdate');
      Qweeks.SQL.Add('FROM accpurhd');
      log.event('Weekly Purchase Report; FormShow: QWeeks for Accepted Invoices opened: ' + frmDMWklyPrchRep.QWeeks.SQL.Text);
      Qweeks.Open;

      CalFDate := Qweeks.FieldByName('mindate').AsDateTime;
      CalLDate	:= Qweeks.FieldByName('maxdate').AsDateTime;

      // get min, max dates from current invoices
      Qweeks.Close;
      Qweeks.SQL.Clear;
      Qweeks.SQL.Add('SELECT min([date]) as mindate, max([date]) as maxdate');
      Qweeks.SQL.Add('FROM purchhdr');
      log.event('Weekly Purchase Report; FormShow: QWeeks for Current Invoices opened: ' + frmDMWklyPrchRep.QWeeks.SQL.Text);
      Qweeks.Open;

      //find earliest and lastest dates out of both
      if (CalFDate = 0) and (Qweeks.FieldByName('mindate').AsDateTime = 0) then
      begin
        ShowMessage('There are no invoice details on record');
        Exit;
      end;

      if (CalFDate <> 0) and (Qweeks.FieldByName('mindate').AsDateTime = 0) then
      begin
        CalFDate := CalFDate;
      end
      else if (CalFDate = 0) and (Qweeks.FieldByName('mindate').AsDateTime <> 0) then
        CalFDate := Qweeks.FieldByName('mindate').AsDateTime
      else
      begin
        if (CalFDate <= Qweeks.FieldByName('mindate').AsDateTime) then
          CalFDate := CalFDate
        else
          CalFDate:= Qweeks.FieldByName('mindate').AsDateTime;
      end;

      if (CalLDate <> 0) and (Qweeks.FieldByName('maxdate').AsDateTime = 0) then
      begin
        CalLDate := CalLDate;
      end
      else if (CalLDate = 0) and (Qweeks.FieldByName('maxdate').AsDateTime <> 0) then
        CalLDate := Qweeks.FieldByName('maxdate').AsDateTime
      else
      begin
        if CalLDate >= Qweeks.FieldByName('maxdate').AsDateTime then
          CalLDate := CalLDate
        else
          CalLDate:= Qweeks.FieldByName('maxdate').AsDateTime;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report; ERROR - FormShow: ' + E.Message);
      raise;
    end;
  end;

  DatePick.Date    := CalLDate; // set the selected pick date as the latest invoice
  //DatePick.MaxDate := StrToDate('12/31/9999'); // max pick date
  FindWeek(CalFDate); //get the starting dow for the first invoice....
  DatePick.MinDate := RepStart; //...use that date as the min pick date
  FindWeek(CalLDate);
end;

procedure Tfrm1wklypurch.FindWeek(DateToFind: Tdate);
Var
  DaysToSub: integer;
begin
  // find start of week before first date
  DaysToSub := DayOfWeek(DateToFind) - stweek;
  if stweek > DayOfWeek(DateToFind) then
    RepStart := (DateToFind - DaysToSub) - 7
  else
    RepStart := DateToFind - DaysToSub;
  // set end of week
    RepEnd := RepStart + 6;
end;

procedure Tfrm1wklypurch.PrintBttnClick(Sender: TObject);
var
  RecCount, i, j: integer;
  Mappings: TStrings;
begin
  log.event('Weekly Purchase Report; Print Button pressed');
  ToggleControls(False);
  GenerateRep;
  if Generated then
  begin
    With frmDMWklyPrchRep do
    begin
      TblWklyPurch.First;
      SiteNameLbl.caption := uGlobals.SiteName;
      // datetostr changed to formatdatetime - MH 10/12/1999
      DatesLbl.Caption := (FormatDateTime('ddddd',RepStart)+' - '+
                                           FormatDateTime('ddddd',RepEnd));

      // set report label fields
      wwFixedCatsTbl.Open;
      RecCount := wwFixedCatsTbl.RecordCount;
      case RecCount of
     	1: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
           end;

        2: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
           end;

        3: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
           end;

        4: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             Lbl4.Caption := TblWklyPurch.Fields[7].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
             DBTxt4.DataField := TblWklyPurch.Fields[7].FieldName;
           end;

        5: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             Lbl4.Caption := TblWklyPurch.Fields[7].DisplayName;
             Lbl5.Caption := TblWklyPurch.Fields[8].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
             DBTxt4.DataField := TblWklyPurch.Fields[7].FieldName;
             DBTxt5.DataField := TblWklyPurch.Fields[8].FieldName;
           end;

        6: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             Lbl4.Caption := TblWklyPurch.Fields[7].DisplayName;
             Lbl5.Caption := TblWklyPurch.Fields[8].DisplayName;
             Lbl6.Caption := TblWklyPurch.Fields[9].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
             DBTxt4.DataField := TblWklyPurch.Fields[7].FieldName;
             DBTxt5.DataField := TblWklyPurch.Fields[8].FieldName;
             DBTxt6.DataField := TblWklyPurch.Fields[9].FieldName;
           end;

        7: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             Lbl4.Caption := TblWklyPurch.Fields[7].DisplayName;
             Lbl5.Caption := TblWklyPurch.Fields[8].DisplayName;
             Lbl6.Caption := TblWklyPurch.Fields[9].DisplayName;
             Lbl7.Caption := TblWklyPurch.Fields[10].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
             DBTxt4.DataField := TblWklyPurch.Fields[7].FieldName;
             DBTxt5.DataField := TblWklyPurch.Fields[8].FieldName;
             DBTxt6.DataField := TblWklyPurch.Fields[9].FieldName;
             DBTxt7.DataField := TblWklyPurch.Fields[10].FieldName;
           end;

        8: begin
             Lbl1.Caption := TblWklyPurch.Fields[4].DisplayName;
             Lbl2.Caption := TblWklyPurch.Fields[5].DisplayName;
             Lbl3.Caption := TblWklyPurch.Fields[6].DisplayName;
             Lbl4.Caption := TblWklyPurch.Fields[7].DisplayName;
             Lbl5.Caption := TblWklyPurch.Fields[8].DisplayName;
             Lbl6.Caption := TblWklyPurch.Fields[9].DisplayName;
             Lbl7.Caption := TblWklyPurch.Fields[10].DisplayName;
             Lbl8.Caption := TblWklyPurch.Fields[11].DisplayName;
             DBTxt1.DataField := TblWklyPurch.Fields[4].FieldName;
             DBTxt2.DataField := TblWklyPurch.Fields[5].FieldName;
             DBTxt3.DataField := TblWklyPurch.Fields[6].FieldName;
             DBTxt4.DataField := TblWklyPurch.Fields[7].FieldName;
             DBTxt5.DataField := TblWklyPurch.Fields[8].FieldName;
             DBTxt6.DataField := TblWklyPurch.Fields[9].FieldName;
             DBTxt7.DataField := TblWklyPurch.Fields[10].FieldName;
             DBTxt8.DataField := TblWklyPurch.Fields[11].FieldName;
           end;
     end; //case

     Lbl10.Caption := 'Others Coded';
     DBTxt9.DataField := TblWklyPurch.Fields[3 + RecCount + 1].FieldName;
     DBTxt10.DataField := TblWklyPurch.Fields[3 + RecCount + 2].FieldName;
     DBTxt11.DataField := TblWklyPurch.Fields[3 + RecCount + 3].FieldName;
     DBTxt12.DataField := TblWklyPurch.Fields[3 + RecCount + 4].FieldName;

     try
       OthersSmryQry1.Close;
       OthersSmryQry1.Open;
     except
       on E: Exception do
       begin
         Log.Event('Weekly Purchase Report ERROR - PrintBttnClick: ' + E.Message + '; '  + OthersSmryQry1.SQL.Text);
         raise;
       end;
     end;

     //OthersSmryBM.Execute;
     Mappings := TStringList.Create;

     try
       try
         dmADO.BatchMove(OthersSmryQry1, otherssmryTBL, Mappings, batCopy);
       except
         on E: Exception do
         begin
           Log.Event('Weekly Purchase Report; ERROR - PrintBttnClick BatchMove OthersSmryQry1 to otherssmryTbl: ' + E.Message);
           raise;
         end;
       end;
     finally
       Mappings.Free;
     end;

     try
       OthersSmryQry2.Close;
       log.event('Weekly Purchase Report; PrintBttnClick: OthersSmryQry2 opened');
       OthersSmryQry2.Open;

       otherssmry2TBL.Close;
       dmADO.EmptySQLTable('OthCsmry2');
       log.event('Weekly Purchase Report; PrintBttnClick: OthersSmry2Tbl opened');
       otherssmry2TBL.Open;
       j := 1;
       while NOT OthersSmryQry2.EOF do
       begin
         otherssmry2TBL.Insert;
         for i := 1 to otherssmry2TBL.FieldCount do
         begin
           if (j > 8) then
           begin
             otherssmry2TBL.Post;
             otherssmry2TBL.Append;
             j := 1;
           end;
           otherssmry2TBL.FieldByName('S'+IntToStr(j)).AsString := OthersSmryQry2.FieldByName('Code').AsString;
           otherssmry2TBL.FieldByName('A'+IntToStr(j)).AsCurrency := OthersSmryQry2.FieldByName('Total').AsCurrency;
           OthersSmryQry2.Next;
           if OthersSmryQry2.EOF then
             break;
           inc(j);
         end;
         otherssmry2TBL.Post;
       end;
     except
       on E: Exception do
       begin
         Log.Event('Weekly Purchase Report; ERROR - PrintBttnClick: OthersSmry2Tbl ' + OthersSmry2Tbl.TableName + ': ' + E.Message + OthersSmryQry2.SQL.Text);
         raise;
       end;
     end;

     TitleLbl.Caption := 'Weekly '+appGUIString+' Report';

//     if UKUSmode = 'UK' then
//      WklyPurchRep.PrinterSetup.PaperName := 'A4'
//     else
//      WklyPurchRep.PrinterSetup.PaperName := 'Letter';

     WklyPurchRep.Print;
     wwFixedCatsTbl.Close;
   end; //with
  end; //if
  ToggleControls(True);
end;

procedure Tfrm1wklypurch.ConfigBttnClick(Sender: TObject);
begin
  frmMainConfig := TfrmMainConfig.Create(Self);
  frmMainConfig.showmodal;
  frmMainConfig.Free;
end;

procedure Tfrm1wklypurch.Label1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft,ssRight,ssCtrl,ssShift] then
  begin
    ConfigBttn.Visible := True;
    ConfigBttn.Enabled := True;
  end;
end;

procedure Tfrm1wklypurch.FormCreate(Sender: TObject);
begin
  Log.Event('Weekly Purchase Report; FormCreate');
  if purchHelpExists then
    setHelpContextID(self, HLP_WEEKLY_REPORT);

  Caption := 'Weekly ' +appGUIString+ ' Reports';
  BitBtn1.Caption := appGUIString + ' Report';
  ConfigBttn.Visible := False;

  OrderByRadioGrp.Items.Strings[1] := GetLocalisedName(lsInvoice) + ' Date';
  OrderByRadioGrp.Items.Strings[2] := GetLocalisedName(lsInvoice) + ' Number';

  WPRPanel.Visible := False;
  stweek := GetStartOfWeek;
end;

procedure Tfrm1wklypurch.BitBtn1Click(Sender: TObject);
begin
  FindWeek(DatePick.Date);
  // datetostr changed to formatdatetime - MH 10/12/1999
  WkSelLbl.Caption := FormatDateTime('ddddd',RepStart)+' - '+ FormatDateTime('ddddd',RepEnd);
  WPRPanel.Visible := True;
end;

procedure Tfrm1wklypurch.DatePickChange(Sender: TObject);
begin
  FindWeek(DatePick.Date);
  // datetostr changed to formatdatetime - MH 10/12/1999
  WkSelLbl.Caption := FormatDateTime('ddddd',RepStart)+' - '+ FormatDateTime('ddddd',RepEnd);
end;

function Tfrm1wklypurch.GetStartOfWeek: integer;
begin
  with dmAdo.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  CASE (SELECT COUNT(*) FROM FinSettings WHERE [SiteCode] = ' + IntToStr(SiteCode) + ') ');
    SQL.Add('    WHEN 0 THEN ');
    SQL.Add('      (SELECT ');
    SQL.Add('         CASE [EndOfFinancialWeek] ');
    SQL.Add('           WHEN 6 THEN 1 ');
    SQL.Add('         ELSE [EndOfFinancialWeek] + 2 ');
    SQL.Add('         END ');
    SQL.Add('       FROM [ac_CompanyFinanceSettings]) ');
    SQL.Add('    ELSE ');
    SQL.Add('      (SELECT stWeek FROM FinSettings WHERE [SiteCode] = ' + IntToStr(SiteCode) + ') ');
    SQL.Add('  END AS stWeek ');
    Open;
    assert(not FieldByName('stweek').IsNull,'STWeek value in FinSettings table is null.' );
    assert(FieldByName('stweek').asinteger in [1..7],'STWeek value in FinSettings table is not in 1 to 7.' );
    Result := FieldByName('stweek').Value;
  finally
    close;
  end;
end;

end.
