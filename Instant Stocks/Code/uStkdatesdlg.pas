//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 26 mar 99
//  Unit: uStkdatesdlg,
//  Form: fStkDatesDlg
//  Globals (R): None
//  Globals (W): None
//  Objects Used: None
//
//  Displays form fStkDatesDlg where user supplies stock end date and start time
//  (if this is the first stock for that division). User can also choose to
//  include part day sales for the end stock date + 1 up to the time of the
//  last till audit read (this is the latest time that ALL tills have beed read.
//  the dates\times are validated against a query on pos.db/lastaudt.DB.
//  if all values are valid the global dates/times are set in udata1.
//
///////////////////////////////////////////////////////////////////////////////
unit uStkdatesdlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask;

type
  TfStkDatesDlg = class(TForm)
    EtimePick: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    partDayChk: TCheckBox;
    SiteLbl: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    DivLbl: TLabel;
    SdatePick: TDateTimePicker;
    EdatePick: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblSTh: TLabel;
    lblTimeNote: TLabel;
    Bevel2: TBevel;
    procedure FormShow(Sender: TObject);
    procedure partDayChkClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure EdatePickChange(Sender: TObject);
  private
    { Private declarations }
    LAfbD: TdateTime;
  public
    { Public declarations }
  end;

var
  fStkDatesDlg: TfStkDatesDlg;

implementation

uses udata1;

{$R *.DFM}

procedure TfStkDatesDlg.FormShow(Sender: TObject);
var
  auditedString : string;
begin
  self.Caption := 'New ' + data1.SSbig + ' Setup - Step 2';

  if data1.noTillsOnSite then
    auditedString := ' (Last Completed Business Date)'
  else
    auditedString := ' (Last Audited Full Business Date)';

  // get SD, ST for curr stock as ED + 1, ET + 00:01 of prev stock
  // if this point reached then a stock of min 1 BsDate is possible...
  with data1 do
  begin
    adoqRun.sql.Clear;
    adoqRun.sql.Add('Select a."SDate",a."EDate", a."STime",');
    adoqRun.sql.Add('a."ETime"');
    adoqRun.sql.Add('From "stocks" a');
    adoqRun.sql.Add('Where a."StockCode" = '+IntToStr(PrevStkCode));
    adoqRun.sql.Add('and a."tid" = ' + IntToStr(curtid));

    adoqRun.open;
    Sdate := adoqRun.FieldByName('EDate').AsDateTime + 1;
    Stime := adoqRun.FieldByName('ETime').AsString;
    adoqRun.close;

    // if last stk has an end time then set start time for this stk + 1 min
    // but if Site has just lost its Tills since the last stock then the new stock will no longer
    // have Part Day Sales (as there will be no sales at all!)
    if (data1.noTillsOnSite or (Stime = '')) then
    begin
      Stime := '';
      NeedBeg := False;
    end
    else
    begin
      Stime := TimeToStr(StrToTime(Stime) + StrToTime('00:01'));
      NeedBeg := True;
    end; //if
  end; // with data1

  DivLbl.Caption  := Data1.TheDiv;
  SiteLbl.Caption := Data1.curTidName;

  if data1.curIsMTh then
  begin
    sitelbl.Color := clRed;
    sitelbl.Caption := sitelbl.Caption + ' (Master Thread)';
    sitelbl.Font.Color := clWhite;
    lblSTh.Caption := 'Subordinate Thread: ' + data1.curSThName + #13 +
      'Sub Thr. Last Acc. End Date/Time: ' + formatDateTime('ddddd hh:nn', data1.lastSthAccEDT) +
       ' (sets Min End Date)';
    lblSTh.Visible := True;
    lblSTh.Color := clYellow;
    lblSTh.Font.Color := clBlack;

    // set LAfbD (Last AuditED Full Business Day)
    if data1.LAT >= data1.roll then
    begin
      LAfbD := data1.LAD - 1;
    end
    else
    begin
      LAfbD := data1.LAD - 2;
    end;

    // set initial EDate as LAfbD (max possible end date)
    Data1.Edate := LAfbD;
    EDatePick.MaxDate := data1.Edate;

    EDatePick.MinDate := data1.lastSthAccFBD + 1;
    label6.Caption := 'Minimum End Date: ' + DateToStr(EdatePick.MinDate) + ' (Sub Thread Last Accepted End Date + 1)' + #13 +
          'Maximum End Date: ' + DateToStr(EdatePick.MaxDate) + auditedString;
  end
  else if data1.curIsSTh then
  begin
    sitelbl.Color := clYellow;
    sitelbl.Caption := sitelbl.Caption + ' (Subordinate Thread)';
    sitelbl.Font.Color := clBlack;
    lblSTh.Visible := True;
    lblSTh.Caption := 'Master: ' + data1.curMThName;
    lblSTh.Color := clRed;
    lblSTh.Font.Color := clWhite;

    // set LAfbD (Last AuditED Full Business Day)
    if data1.LAT >= data1.roll then
    begin
      LAfbD := data1.LAD - 1;
    end
    else
    begin
      LAfbD := data1.LAD - 2;
    end;

    // set initial EDate as LAfbD (max possible end date)
    Data1.Edate := LAfbD;
    EDatePick.MaxDate := data1.Edate;

    if data1.NeedBeg then // only ED > SD allowed to have 1 full BsDate (the ED itself)
    begin
      EDatePick.MinDate := data1.Sdate + 1;
      label6.Caption := 'Minimum End Date: ' + DateToStr(EdatePick.MinDate) + ' (Start Date + 1)' + #13 +
          'Maximum End Date: ' + DateToStr(EdatePick.MaxDate) + auditedString;
    end
    else
    begin
      EDatePick.MinDate := data1.Sdate;
      label6.Caption := 'Minimum End Date: ' + DateToStr(EdatePick.MinDate) + ' (Start Date)' + #13 +
          'Maximum End Date: ' + DateToStr(EdatePick.MaxDate) + auditedString;
    end;
  end
  else
  begin
    sitelbl.Color := clGreen;
    sitelbl.Font.Color := clWhite;
    lblSTh.Visible := False;

    // set LAfbD (Last AuditED Full Business Day)
    if data1.LAT >= data1.roll then
    begin
      LAfbD := data1.LAD - 1;
    end
    else
    begin
      LAfbD := data1.LAD - 2;
    end;

    // set initial EDate as LAfbD (max possible end date)
    Data1.Edate := LAfbD;
    EDatePick.MaxDate := data1.Edate;

    if data1.NeedBeg then // only ED > SD allowed to have 1 full BsDate (the ED itself)
    begin
      EDatePick.MinDate := data1.Sdate + 1;
      label6.Caption := 'Minimum End Date: ' + DateToStr(EdatePick.MinDate) + ' (Start Date + 1)' + #13 +
          'Maximum End Date: ' + DateToStr(EdatePick.MaxDate) + auditedString;
    end
    else
    begin
      EDatePick.MinDate := data1.Sdate;
      label6.Caption := 'Minimum End Date: ' + DateToStr(EdatePick.MinDate) + ' (Start Date)' + #13 +
          'Maximum End Date: ' + DateToStr(EdatePick.MaxDate) + auditedString;
    end;
  end;

  if data1.noTillsOnSite then
  begin
    partdaychk.Visible := FALSE;
    label7.Visible := FALSE;
  end
  else
  begin
    if data1.roll = data1.LAT then
    begin
      label7.Caption := 'Sales cannot be included for ' + datetostr(EDatePick.MaxDate + 1) + ' (No Audit)';
      partdaychk.Enabled := False;
    end
    else
    begin
      label7.Caption := 'Maximum allowable End Time: ' + data1.LAT + ' (Last Audit Time)';
    end;
  end;

  EdatePick.Date := Data1.Edate;
  partDayChk.Caption := 'Include Sales For '+ DateToStr(EdatePick.Date + 1) + ' (Business Date)';

  
  eTimePick.Visible := partdaychk.Visible;
  label3.Visible := partdaychk.Visible;
  bevel2.Visible := partdaychk.Visible;

  SdatePick.Enabled := False;
  SdatePick.Date := data1.Sdate;

  label8.Caption := data1.SSbig + ' Period: ' + inttostr(trunc(edatepick.Date - sdatepick.Date + 1)) +
   ' full business days';

end;


/////////////////////////////////////////////////////////////////////////
//
//  if user selects part day sales set value of the end time display.
//
/////////////////////////////////////////////////////////////////////////
procedure TfStkDatesDlg.partDayChkClick(Sender: TObject);
begin
	if partDayChk.Checked then
  begin
    //EtimePick.Time := StrToTime('00:00');
    EtimePick.Enabled := True;

    lblTimeNote.Visible := True;
    if edatepick.Date < edatepick.MaxDate then
    begin
      // no restriction on EndTime...
      lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
        ') refer to the' + #13 + '          calendar date ' + DateToStr(EdatePick.Date + 2) +
        ' (Business Date: ' + DateToStr(EdatePick.Date + 1) + ')';
    end
    else
    begin
      if data1.roll = data1.LAT then
      begin
        lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
          ') refer' + #13 + '           to the next calendar date (Business Date + 1)';
        lblTimeNote.Enabled := False;
      end
      else
      begin
        lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
        ') refer to the' + #13 + '          calendar date ' + DateToStr(EdatePick.Date + 2) +
        ' (Business Date: ' + DateToStr(EdatePick.Date + 1) + ')';
      end;
    end;
  end
  else
  begin
    EtimePick.Enabled := False;
    EtimePick.Time := StrToTime('00:00');
    lblTimeNote.Visible := False;
  end;
end;

////////////////////////////////////////////////////////////////////////
//
//  Validate stock start/end date/times, if all OK set globals.
//
////////////////////////////////////////////////////////////////////////
procedure TfStkDatesDlg.OKBtnClick(Sender: TObject);
begin
	if (EdatePick.Date <= LAfbD) and
     (EdatePick.Date >= data1.Sdate)  then // validate end date/times, should be OK but check just as well
  begin
     if partDayChk.Checked then
     begin
       // validate end time if this is last day...
       if EdatePick.Date = LAfbD then
       begin
         if FormatDateTime('hh:mm',EtimePick.Time) > data1.roll then
         begin
           if (EdatePick.Date + frac(EtimePick.Time) + 1) > data1.LADT then
           begin
             showmessage('ERROR: Wrong End Time!' + #13 + #13 +
               'If End Date is the Last Audited Business Date then the maximum ' +
               'allowable End Time is ' + data1.LAT + ' (Last Audit Time).');

             EtimePick.Time := strtotime(data1.LAT);
             etimepick.SetFocus;
             modalresult := mrNone;
             exit;
           end;
         end
         else if FormatDateTime('hh:mm',EtimePick.Time) < data1.roll then
         begin
           if (EdatePick.Date + frac(EtimePick.Time) + 2) > data1.LADT then
           begin
             showmessage('ERROR: Wrong End Time!' + #13 + #13 +
               'If End Date is the Last Audited Business Date then the maximum ' +
               'allowable End Time is ' + data1.LAT + ' (Last Audit Time).');

             EtimePick.Time := strtotime(data1.LAT);
             etimepick.SetFocus;
             modalresult := mrNone;
             exit;
           end;
         end; // if etime = roll take care of it below (no part day sales)
       end;

       if FormatDateTime('hh:mm',EtimePick.Time) = data1.roll then
       begin
         if MessageDlg('The End Time for Part Day Sales is set at ' + data1.roll + ' (roll-over time)!'+
           #13+ 'This means there will be no Sales Included for Date ' + DateToStr(EdatePick.Date + 1) +
           #13+#13+ 'Do you want to continue?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
         begin
           Data1.Etime := '';
           data1.NeedEnd := False;
         end
         else
         begin
           modalresult := mrNone;
           exit;
         end;
       end
       else
       begin
         Data1.Etime := FormatDateTime('hh:mm',EtimePick.Time);
         data1.NeedEnd := True;
       end;
     end
     else
     begin
        Data1.Etime := '';
        data1.NeedEnd := False;
     end;

     Data1.Edate := EdatePick.Date;

     modalresult := mrOK;
  end
  else
  begin
    showmessage('ERROR: Invalid End Date');
  	modalresult := mrNone;
  end;
end;

procedure TfStkDatesDlg.EdatePickChange(Sender: TObject);
begin
  partDaychk.Enabled := True;
  lblTimeNote.Enabled := True;
  if edatepick.Date < edatepick.MaxDate then
  begin
    // no restriction on EndTime...
    label7.Caption := 'No restriction on setting End Time for ' + DateToStr(EdatePick.Date + 1);
    lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
      ') refer to the' + #13 + '            calendar date ' + DateToStr(EdatePick.Date + 2) +
      ' (Business Date: ' + DateToStr(EdatePick.Date + 1) + ')';
  end
  else
  begin
    if data1.roll = data1.LAT then
    begin
      label7.Caption := 'Sales cannot be included for ' + datetostr(EDatePick.MaxDate + 1) + ' (No Audit)';
      partdaychk.Enabled := False;
      partdaychk.Checked := False;
      lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
        ') refer' + #13 + '             to the next calendar date (Business Date + 1)';
      lblTimeNote.Enabled := False;
    end
    else
    begin
      label7.Caption := 'Maximum allowable End Time: ' + data1.LAT + ' (Last Audit Time)';
      lblTimeNote.Caption := 'Note: Times between midnight and roll-over (00:00 to '+ data1.roll +
      ') refer to the' + #13 + '            calendar date ' + DateToStr(EdatePick.Date + 2) +
      ' (Business Date: ' + DateToStr(EdatePick.Date + 1) + ')';
    end;
  end;

	partDayChk.Caption := 'Include Sales For '+ DateToStr(EdatePick.Date + 1) + ' (Business Date)';

  label8.Caption := data1.SSbig + ' Period: ' + inttostr(trunc(edatepick.Date - sdatepick.Date + 1)) +
    ' full business days';
end;

end.
