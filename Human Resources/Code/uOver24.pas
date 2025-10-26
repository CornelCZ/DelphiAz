unit uOver24;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Db, Grids, Wwdbigrd, Wwdbgrid, Wwdatsrc, DBTables,
  //Wwtable, Wwquery,
  Dialogs, Variants, ADODB;

type
  TfOver24 = class(TForm)
    wwDataSource1: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    wwDBGrid1IButton: TwwIButton;
    wwTable1: TADOTable;
    wwTable1EmpFName: TStringField;
    wwTable1EmpLName: TStringField;
    wwTable1JobName: TStringField;
    wwTable1Break: TTimeField;
    wwTable1totHrs: TStringField;
    wwTable1Din: TDateField;
    wwTable1Tin: TTimeField;
    wwTable1Dout: TDateField;
    wwTable1Tout: TTimeField;
    wwTable1Match: TStringField;
    wwTable1SEC: TFloatField;
    wwTable1Jobid: TSmallintField;
    wwTable1Solved: TStringField;
    wwTable1Site: TSmallintField;
    wwTable1ClockIn: TDateTimeField;
    wwTable1ClockOut: TDateTimeField;
    wwTable1InsDT: TDateTimeField;
    wwTable1SolvedDT: TDateTimeField;
    wwTable1SolvedBy: TStringField;
    wwtRun: TADOTable;
    wwqRun: TADOQuery;
    wwTable1ClockedPaySchemeVersionId: TIntegerField;
    wwTable1ClockedUserPayRateOverrideVersionID: TIntegerField;
    procedure wwTable1CalcFields(DataSet: TDataSet);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure PatchShifts;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOver24: TfOver24;

implementation

uses dmodule1, uempmnu, uGlobals, uADO;

{$R *.DFM}

procedure TfOver24.wwTable1CalcFields(DataSet: TDataSet);
var
  dtin, dtout : tdatetime;
  dy,hr,min,sec,ms : word;
begin
  if wwTable1.RecordCount = 0 then
    exit;
  dtin := wwtable1Din.AsDateTime + wwtable1Tin.AsDateTime;
  dtout := wwtable1Dout.AsDateTime + wwtable1Tout.AsDateTime;
  if dtout < dtin then
  begin
    wwtable1TotHrs.AsString := 'Out<In!';
    exit;
  end;
  dtin := dtout - dtin;

  if double(dtin) > 30.0 then
  begin
    wwtable1TotHrs.AsString := '30days+';
    exit;
  end;

  dy := trunc(dtin);
  decodetime(dtin, hr, min, sec, ms);

  hr := hr + (dy * 24);

  wwtable1TotHrs.AsString := inttostr(hr) + format(':%.2d',[min]);
end;

procedure TfOver24.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if wwTable1.RecordCount = 0 then
    exit;
  // the total hrs field..
  if (Field.FieldName = 'totHrs') then
  begin
		if (length(Field.Text) > 5) or
      (strtoint(copy(Field.Text, 1, (pos(':', Field.Text) - 1))) >= 24) then
    begin
			AFont.Color := clWhite;
      ABrush.Color := clRed;
		end
    else
    begin
      AFont.Color := clBlack;
      ABrush.Color := clWhite;
    end;
	end;
end;

procedure TfOver24.BitBtn3Click(Sender: TObject);
begin
  if wwTable1.RecordCount > 0 then
  begin
    if wwTable1.RecordCount = 1 then
      ShowMessage('There is still '+IntToStr(wwTable1.RecordCount)+' shift over 24 hours!' + #13#10#10 +
                  'Shifts can only be imported if they are less than 24 hours long.' )
    else
      ShowMessage('There are still '+IntToStr(wwTable1.RecordCount)+' shifts over 24 hours!' + #13#10#10 +
                  'Shifts can only be imported if they are less than 24 hours long.');
  end;
  Close;
end;

procedure TfOver24.BitBtn1Click(Sender: TObject);
begin
  with wwTable1 do
  begin
    edit;
    FieldByName('solved').asstring := 'D';
    FieldByName('solvedDT').asdatetime := Now;
    FieldByName('solvedBy').asstring := CurrentUser.UserName;
    post;
    refresh;
  end;
  if wwTable1.RecordCount = 0 then
  begin
    wwTable1.close;
    Close;
  end;
end;

procedure TfOver24.FormShow(Sender: TObject);
var
  thedate : tdatetime;
begin
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select max(a."clockin") as themax from "eOver24h" a');
    open;

    thedate := FieldByName('themax').asdatetime - 200;

    close;
    sql.Clear;
    sql.Add('delete from eOver24h where "clockin" < ''' +
      formatDateTime('mm/dd/yyyy', thedate) + '''');
    execSQL;
  end;

  wwtable1Din.DisplayFormat := shortdateformat + 'yy';
  wwtable1Dout.DisplayFormat := shortdateformat + 'yy';

  wwtable1.open;
end;

procedure TfOver24.BitBtn2Click(Sender: TObject);
var
  dtin, dtout : tdatetime;
  sortstring : string[1];
  Count : integer;
begin
  // take all checked records one by one; verify that times are valid;
  // try to find how many unconfirmed recs in schedule match the shift
  // if sch shift has clockinout info but was not added, do not match.
  // if sch shift was added then match; if no clock info then match.
  // if no sch shift available insert as unscheduled...

  Count := 0;
  screen.Cursor := crHourGlass;
  wwtRun.TableName := 'Schedule';
  wwtRun.open;

  // first clear the 'ZZ-over24h' from wherever it is in the Schedule table. It should be
  // in records that came in last time and who's rates were not modified...
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update "schedule" set "PaySchemeVersionLMBy" = null');
    sql.Add('where "PaySchemeVersionLMBy" = ' + #39 + 'ZZ-over24h' + #39);
    execSQL;
  end;

  with wwTable1 do
  begin
    disablecontrols;
    first;

    while not eof do
    begin
      if FieldByName('match').asstring = 'Y' then
      begin
        dtin := FieldByName('din').AsDateTime + FieldByName('Tin').AsDateTime;
        dtout := FieldByName('Dout').AsDateTime + FieldByName('Tout').AsDateTime;

        if (dtout <= dtin) or ((dtout - dtin) >= 1) then
        begin
          edit;
          FieldByName('match').asstring := 'N';
          post;
          Count := Count + 1;
          next;
          continue;
        end;

        sortstring := 'E';
        // try to match...
        wwqRun.close;
        wwqRun.sql.Clear;
        wwqRun.sql.Add('select a."sitecode", a.UserId, a."schin"');
        wwqRun.sql.Add('from "Schedule" a');
        wwqRun.sql.Add('where a.UserId = ' + FieldByName('sec').asstring);
        wwqRun.sql.Add('and a."confirmed" = ''N'' and a."visible" = ''Y''');
        wwqRun.sql.Add('and a."SchOut" >= ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',dtin) + '''');
        wwqRun.sql.Add('and a."SchIn" <= ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',dtout) + '''');
        wwqRun.sql.Add('and ((a."clockin" is null) or (a."clockout" is null))');
        wwqRun.sql.Add('order by a."schin"');
        wwqRun.open;

        if wwqRun.recordcount = 0 then
        begin // insert as unmatched..
          wwqRun.close;
          wwtRun.Insert;
          wwtRun.FieldByName('sitecode').asinteger := FieldByName('site').asinteger;
          TLargeIntField(wwtRun.FieldByName('UserId')).AslargeInt := FieldByName('sec').Value;
          wwtRun.FieldByName('schin').asdatetime := dtin;
          wwtRun.FieldByName('schout').asdatetime := dtin;
          wwtRun.FieldByName('clockin').asdatetime := dtin;
          wwtRun.FieldByName('clockout').asdatetime := dtout;
          wwtRun.FieldByName('break').asdatetime := FieldByName('break').asdatetime;
          wwtRun.FieldByName('RoleId').asinteger :=  NULL_JOB_CODE;
          wwtRun.FieldByName('CRoleId').asinteger := FieldByName('jobid').asinteger;
          wwtRun.FieldByName('WRoleId').asinteger := FieldByName('jobid').asinteger;
          wwtRun.FieldByName('shift').asinteger := 1;
          wwtRun.FieldByName('PaySchemeVersionLMBy').asstring := 'ZZ-over24h';
          wwtRun.FieldByName('ErrCode').asinteger := -24;
          wwtRun.FieldByName('lmdt').asdatetime := Now;
          wwtRun.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
          wwtRun.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
          try
            wwtRun.Post;
            sortstring := 'U';
          except
            on exception do
            begin
              wwtRun.Cancel;
              sortstring := 'K';
            end;
          end; // try..except
        end
        else
        begin // try to match...
          // should have AT MOST 2 RECORDS!!!
          // anyway we match to 1st available record so...
          wwqRun.first;
          wwtRun.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('site').asinteger,
             FieldByName('sec').Value, wwqRun.FieldByName('schin').asdatetime]), []);

          wwtRun.edit;
          wwtRun.FieldByName('clockin').asdatetime := dtin;
          wwtRun.FieldByName('clockout').asdatetime := dtout;
          wwtRun.FieldByName('break').asdatetime := FieldByName('break').asdatetime;
          wwtRun.FieldByName('CRoleid').asinteger := FieldByName('jobid').asinteger;
          wwtRun.FieldByName('WRoleId').asinteger := FieldByName('jobid').asinteger;
          wwtRun.FieldByName('shift').asinteger := 1;
          wwtRun.FieldByName('PaySchemeVersionLMBy').asstring := 'ZZ-over24h';
          wwtRun.FieldByName('ErrCode').asinteger := -24;
          wwtRun.FieldByName('lmdt').asdatetime := Now;
          wwtRun.FieldByName('ClockedPaySchemeVersionId').Value := fieldbyname('ClockedPaySchemeVersionId').Value;
          wwtRun.FieldByName('ClockedUserPayRateOverrideVersionID').Value := fieldbyname('ClockedUserPayRateOverrideVersionID').Value;
          wwtRun.Post;

          sortstring := 'M';

          wwqRun.close;
        end;

        edit;
        FieldByName('match').asstring := sortstring;
        FieldByName('solvedDT').asdatetime := Now;
        FieldByName('solvedBy').asstring := CurrentUser.UserName;
        post;
      end;
      next;
    end;

    // all valid records inserted or matched. Make solved = M (modified)
    with wwqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update eOver24h set "Solved" = ''M''');
      sql.Add('where "solved" = ''N'' and ' +
       '("match" = ''U'' or "match" = ''M'' or "match" = ''K'')');
      execSQL;
    end;

    // now do the things needed for job type/rates, worked etc...

    //////////////////////////////////////////////////////////
    // first all employee-job matched or inserted records
    // get their rates from empjob. Also the Acc Times are given clockin-out times
    with wwqRun do

    begin
      close;
      sql.Clear;
      sql.Add('update schedule');
      sql.Add('set WorkedPaySchemeVersionId = ClockedPaySchemeVersionId,');
      sql.Add('WorkedUserPayRateOverrideVersionID = ClockedUserPayRateOverrideVersionID,');
      sql.Add('accin = s.clockin, accout = s.clockout,');
      SQL.Add('LMDT = getDate()');
      sql.Add('from schedule s');
      sql.Add('join ac_AllUserSites us');
      sql.Add('on s.UserId = us.UserId');
      sql.Add('where us.SiteId = ' + IntToStr(uGlobals.SiteCode));
      sql.Add('and s."PaySchemeVersionLMBy" = ''ZZ-over24h''');
      execSQL;
    end;

    with wwtRun do
    begin
      // FOR EACH RECORD ADDED THIS CALCULATES WORKED TIMES and sets BsDate

      close;
      filter := '(PaySchemeVersionLMBy = ' + #39 + 'ZZ-over24h' + #39 + ')';
      filtered := true;
      open;
      first;
      while not eof do
      begin
        edit;
        FieldByName('worked').asdatetime := FieldByName('clockout').asdatetime -
          FieldByName('clockin').asdatetime - FieldByName('break').asdatetime;

        if fempmnu.dtgrace > frac(FieldByName('schin').asfloat) then
        begin //previous day
          FieldByName('BsDate').asstring :=
            formatDateTime(shortdateformat + 'yy', FieldByName('schin').asdatetime - 1);
        end
        else
        begin // same day
          FieldByName('BsDate').asstring :=
            formatDateTime(shortdateformat + 'yy', FieldByName('schin').asdatetime);
        end;

        post;
        next;
      end;

      filtered := false;
      close;
      // worked will now have the real worked time, which excludes the 'official' breaks
      // (from empusck) AS WELL AS the time between the worked periods (if more than 1)
      // break now holds the sum of all official breaks + the time between periods (if more than 1)
    end;

    // Now for all scheduled salaried records make accin/out = schin/out & worked = accout - accin.
    with wwqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update Schedule');
      SQL.Add('set accin = schin, accout = schout, worked = accout - accin');
      SQL.Add('from schedule s');
      SQL.Add('join ac_PaySchemeVersion psv');
      SQL.Add('on s.PaySchemeVersionId = psv.Id');
      SQL.Add(' join ac_PayScheme ps');
      SQL.Add(' on ps.Id = psv.PaySchemeId');
      SQL.Add('where ps.PayFrequencyId > 1 and (PaySchemeVersionLMBy = ' + #39 + 'ZZ-over24h' + #39 + ')');
      ExecSQL;
    end;

    PatchShifts;
    //////////////////////////////////////////////////////////

    wwtRun.close;
    requery;
    enablecontrols;
    refresh;

    screen.Cursor := crDefault;

    if wwTable1.RecordCount = 0 then
    begin
      wwTable1.close;
      fOver24.Close;
    end
    else
    begin
      wwdbGrid1.RefreshDisplay;
    end;
  end;

  if Count > 0 then
  begin
    if Count = 1 then
      ShowMessage('There is still '+IntToStr(Count)+' shift over 24 hours!' + #13#10#10 +
                  'Shifts can only be imported if they are less than 24 hours long.')
    else
      ShowMessage('There are still '+IntToStr(Count)+' shifts over 24 hours!' + #13#10#10 +
                  'Shifts can only be imported if they are less than 24 hours long.');
  end;
end;


procedure TfOver24.PatchShifts;
var
  bdate : tdatetime;
  CurrUserId : Int64;
  shiftno : shortint;
begin
  // PATCH PATCH PATCH PATCH...
  // MAKE SURE THAT 1. for each day the recs for 1 emp are ordered by schin and
  //                   are given the correct shift...

  if wwtRun.State = dsInactive then
    wwtRun.open;

  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a."sitecode", a."UserId", a."schin", a."bsdate"');
    sql.Add('from "schedule" a');
    sql.Add('where a."PaySchemeVersionLMBy" = ''' + 'ZZ-over24h' + '''');
    sql.Add('order by a."bsdate", a."UserId", a."schin"');
    open;

    bdate := 0;
    CurrUserId := -1;
    shiftno := 1;
    first;
    while not eof do
    begin
      if bdate = FieldByName('bsdate').asdatetime then
      begin
        if CurrUserId = FieldByName('UserId').Value then
        begin
          if wwtRun.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
            FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
          begin
            wwtRun.edit;
            wwtRun.FieldByName('shift').asinteger := shiftno;
            wwtRun.post;
            inc(shiftno);
          end;
        end
        else
        begin
          CurrUserId := FieldByName('UserId').Value;
          shiftno := 1;
          if wwtRun.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
            FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
          begin
            wwtRun.edit;
            wwtRun.FieldByName('shift').asinteger := shiftno;
            wwtRun.post;
            inc(shiftno);
          end;
        end;
      end
      else
      begin
        bdate := FieldByName('bsdate').asdatetime;
        CurrUserId := FieldByName('UserId').Value;
        shiftno := 1;
        if wwtRun.locate('sitecode;UserId;schin', VarArrayOf([FieldByName('sitecode').asinteger,
          FieldByName('UserId').Value, FieldByName('schin').asdatetime]), []) then
        begin
          wwtRun.edit;
          wwtRun.FieldByName('shift').asinteger := shiftno;
          wwtRun.post;
          inc(shiftno);
        end;
      end;
      next;
    end;
    close;
    wwtRun.close;
  end;
end;

end.
