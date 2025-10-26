unit uAttend;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Wwdatsrc,
  //DBTables, Wwtable, Wwquery,
  StdCtrls, wwdblook, Grids,
  Wwdbigrd, Wwdbgrid, Buttons, DBGrids, ADODB;

type
  TfAttend = class(TForm)
    dsEmpAtTmp: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    lookAttCodes: TwwDBLookupCombo;
    btnSave: TBitBtn;
    btnDiscard: TBitBtn;
    btnSign: TBitBtn;
    wwtEmpAtTmp: TADOTable;
    wwtEmpAtTmpFName: TStringField;
    wwtEmpAtTmpLName: TStringField;
    wwtEmpAtTmpdisp1: TStringField;
    wwtEmpAtTmpdisp2: TStringField;
    wwtEmpAtTmpdisp3: TStringField;
    wwtEmpAtTmpdisp4: TStringField;
    wwtEmpAtTmpdisp5: TStringField;
    wwtEmpAtTmpdisp6: TStringField;
    wwtEmpAtTmpdisp7: TStringField;
    wwtEmpAtTmpD3: TStringField;
    wwtEmpAtTmpD4: TStringField;
    wwtEmpAtTmpD5: TStringField;
    wwtEmpAtTmpD6: TStringField;
    wwtEmpAtTmpD7: TStringField;
    wwtEmpAtTmpD1: TStringField;
    wwtEmpAtTmpD2: TStringField;
    wwtEmpAtTmpSiteCode: TSmallintField;
    wwqAttCodes: TADOQuery;
    wwtEmpAtTmpUserId: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid1CellChanged(Sender: TObject);
    procedure wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure wwtEmpAtTmpAfterPost(DataSet: TDataSet);
    procedure lookAttCodesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnSignClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    updown, init, goback, spec : boolean;
    thecol, newcol, prevcol : integer;
    procedure GetGoodCell;
  public
    { Public declarations }
    selWeekSt : tdatetime;
    sitecode : smallint;
  end;

var
  fAttend: TfAttend;

implementation

uses dmodule1, uGlobals, uADO;

{$R *.DFM}

procedure TfAttend.FormShow(Sender: TObject);
var
  curUserId : int64;
  fieldno : shortint;
begin
  // fill table with emps and their Att Codes for the selected week...
  // assume that by this time the VerClkTimes have been checked out and are OK,
  // and that the EmpAttCd.db has been filled properly for this week...

  self.Caption := 'Employee Attendance for week: ' + formatDateTime('ddd ddddd', selWeekSt) +
    ' - ' + formatDateTime('ddd ddddd', selWeekSt + 6);
  init := True;
  updown := False;


  wwtEmpAtTmp.close;
  dmADO.EmptySQLTable('#EmpAtTmp');
  wwtEmpAtTmp.open;

  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a.*, u.lastname, u.firstname');
    sql.Add('from empattcd a');
    sql.Add('join ac_User u');
    sql.Add('on a.sec = u.Id');
    sql.Add(' join ac_AllUserSites us');
    sql.Add(' on us.SiteId =' + inttostr(sitecode) + ' and us.UserId = u.id');
    sql.Add('where a.sec = u.Id');
    sql.Add('and a.date >= ' + quotedStr(formatDateTime('mm/dd/yyyy', selWeekSt)));
    sql.Add('and a.date <= ' + quotedStr(formatDateTime('mm/dd/yyyy', selWeekSt + 6)));
    sql.Add('order by a.sec, a.date');
    open;
    first;

    if not EOF then
    begin
      curUserId := FieldByName('sec').Value;
      wwtEmpAtTmp.Insert;
      wwtEmpAtTmp.FieldByName('sitecode').asinteger := FieldByName('sitecode').asinteger;
      TLargeIntField(wwtEmpAtTmp.FieldByName('UserId')).AsLargeInt := curUserId;
      wwtEmpAtTmp.FieldByName('lname').asstring := FieldByName('lastname').asstring;
      wwtEmpAtTmp.FieldByName('fname').asstring := FieldByName('firstname').asstring;

      while not eof do
      begin
        if FieldByName('sec').Value = curUserId then
        begin // put the code in the right field (d1..d7) depending on date
          fieldno := trunc(FieldByName('date').asdatetime - selWeekSt) + 1;
          if (fieldno <= 7) and (fieldno > 0) then
          begin
            wwtEmpAtTmp.FieldByName('d' + inttostr(fieldno)).asstring :=
              FieldByName('attcode').asstring;
          end
          else
          begin
            // handle errors
          end;
          next;
        end
        else  // post last changes and insert a new record. DO NOT ADVANCE QUERY!!
        begin
          curUserId := FieldByName('sec').Value;
          wwtEmpAtTmp.Post;

          wwtEmpAtTmp.Insert;
          wwtEmpAtTmp.FieldByName('sitecode').asinteger := FieldByName('sitecode').asinteger;
          TLargeIntField(wwtEmpAtTmp.FieldByName('UserId')).AsLargeInt := FieldByName('sec').Value;
          wwtEmpAtTmp.FieldByName('lname').asstring := FieldByName('lastname').asstring;
          wwtEmpAtTmp.FieldByName('fname').asstring := FieldByName('firstname').asstring;
        end;
      end;
      wwtEmpAtTmp.Post;
    end;

    close;
    sql.Clear;
    sql.Add('INSERT [#EmpAtTmp] ([SiteCode], [UserId], [LName], [FName])');
    sql.Add('SELECT DISTINCT us.[SiteId], u.[Id], u.[lastname], u.[firstname]');
    sql.Add('FROM ac_User u');
    sql.Add('JOIN ac_AllUserSites us');
    sql.Add('ON u.Id = us.UserId');
    sql.Add('JOIN ac_Userroles ur');
    sql.Add('ON ur.Userid = u.Id');
    sql.Add('JOIN ac_Role r');
    sql.Add('ON r.Id = ur.RoleId');
    sql.Add('WHERE us.[SiteId] = ' + inttostr(sitecode));
    sql.Add('AND u.[terminated] = 0');
    sql.Add('AND r.RoleTypeId = 1  AND r.ShowInTimeAndAttendance = 1');
    sql.Add('AND NOT EXISTS (select UserId from [#EmpAtTmp] where [UserId] = u.Id)');
    execSQL;

    wwtEmpAtTmp.Requery;
  end;

  // set up the field titles for the 7 days...
  wwtEmpAtTmpdisp1.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt);
  wwtEmpAtTmpdisp2.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 1);
  wwtEmpAtTmpdisp3.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 2);
  wwtEmpAtTmpdisp4.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 3);
  wwtEmpAtTmpdisp5.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 4);
  wwtEmpAtTmpdisp6.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 5);
  wwtEmpAtTmpdisp7.DisplayLabel := formatdatetime('ddd ' + copy(ShortDateFormat, 1, 5), selWeekSt + 6);

  wwqAttCodes.open;
  wwqAttCodes.First;

  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a."UserId" from "#empattmp" a');
    sql.Add('where a."d1" = '''' or a."d2" = ''''');
    sql.Add('or a."d3" = '''' or a."d4" = ''''');
    sql.Add('or a."d5" = '''' or a."d6" = '''' or a."d7" = ''''');
    open;
    if recordcount = 0 then
    begin
      btnSign.Enabled := True;
    end
    else
    begin
      btnSign.Enabled := False;
    end;
    close;
  end;
  init := False;
  wwtEmpAtTmp.First;
  wwDBGrid1CellChanged(self);
end;

procedure TfAttend.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Field.Text = 'Worked' then
  begin
    AFont.Color := clBtnText;
    ABrush.Color := clBtnFace;
  end;
end;

procedure TfAttend.wwDBGrid1CellChanged(Sender: TObject);
begin
  if init then
    exit;

  if (wwdbgrid1.GetActiveCol = 9) and (prevcol = 7) and not goback and spec then
  begin
    exit;
  end;

  if (wwdbgrid1.GetActiveCol = 3) and (prevcol = 1) and goback and spec then
  begin
    exit;
  end;

  prevcol := wwdbgrid1.GetActiveCol - 2;

  if wwDBGrid1.GetActiveField.Text = 'Worked' then  //GetActiveField.Text = 'Worked' then
  begin
    init := True;
    prevcol := 0;
    thecol := wwdbgrid1.GetActiveCol - 2; // give the field number as in D1, D2.. D7
    wwtempattmp.DisableControls;
    GetGoodCell;
    wwdbgrid1.SetActiveField('disp' + inttostr(newcol));
    prevcol := newcol;
    wwtempattmp.EnableControls;
    wwdbgrid1.RefreshDisplay;
    init := False;
  end;
  lookAttCodes.DataField := 'disp' + inttostr(wwdbgrid1.GetActiveCol - 2);
end;

procedure TfAttend.wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // set navigation direction
  spec := false;
  updown := False;
  case key of
    VK_TAB : begin
              if ssShift in Shift then
                 goback := True
              else
                 goback := False;
              spec := true;
             end;
    VK_RETURN: begin
                goback := False;
                spec := true;
               end;
    VK_RIGHT: begin
                goback := False;
              end;
    VK_DOWN: begin
               updown := True;
               goback := False;
              end;
    VK_LEFT: begin
               goback := True;
             end;
    VK_UP: begin
               updown := True;
               goback := True;
           end;
  else
    exit;
  end; // case..

end;

procedure TfAttend.GetGoodCell;
var
  i : integer;
begin
  // get the cell's coordinates (recno and col)

  with wwtempattmp do
  begin
    newcol := -1;

    // search the table upwards or downwards for the first available cell
    if goback then
    begin // search left and up
      // first stay on current record...
      if thecol > 1 then
      begin
        for i := (thecol - 1) downto 1 do
        begin
          if FieldByName('D' + inttostr(i)).asstring <> 'W' then
          begin
            newcol := i;
            break; // out of the for loop...
          end;
        end; //for
      end; //if

      if newcol = -1 then // didn't find available cell yet, go up...
      begin
        if updown then
        begin //but first look for good cell on same row in reverse
          for i := 1 to 7 do
          begin
            if FieldByName('D' + inttostr(i)).asstring <> 'W' then
            begin
              newcol := i;
              break; // out of the for loop...
            end;
          end; //for
          if newcol > 1 then
          begin
            exit;
          end;
        end;

        Prior;
        while ((not bof) and (newcol = -1)) do
        begin
          for i := 7 downto 1 do // try ALL fields from right to left...
          begin
            if FieldByName('D' + inttostr(i)).asstring <> 'W' then
            begin
              newcol := i;
              break; // out of the for loop...
            end;
          end; //for
          if newcol = -1 then
            Prior;
        end; // while

        // at this point either an available cell has been found on some record..
        // with newcol > 0 or the beginnig of file has been reached. If this is the case
        // then go to the last record and keep doing it...
        if newcol = -1 then
        begin
          Last;
          while ((not bof) and (newcol = -1)) do
          begin
            for i := 7 downto 1 do // try ALL fields from right to left...
            begin
              if FieldByName('D' + inttostr(i)).asstring <> 'W' then
              begin
                newcol := i;
                break; // out of the for loop...
              end;
            end;
            if newcol = -1 then
              Prior;
          end;
        end;

        // at this point the only way we don't have a valid cell is if ALL cells
        // somehow have 'W' on them (impossible!!!). If this is the case then exit
        // the grid...
        if newcol = -1 then
        begin
          btnSave.SetFocus;
          EnableControls;
          exit;
        end;
      end; // if newcol = -1
    end
    else
    begin // search right and down
      // first stay on current record...
      if thecol < 7 then
      begin
        for i := (thecol + 1) to 7 do
        begin
          if FieldByName('D' + inttostr(i)).asstring <> 'W' then
          begin
            newcol := i;
            break; // out of the for loop...
          end;
        end;
      end;

      if newcol = -1 then // didn't find available cell yet, go down...
      begin
        if updown then
        begin    //but first look for good cell on same row in reverse
          for i := 7 downto 1 do
          begin
            if FieldByName('D' + inttostr(i)).asstring <> 'W' then
            begin
              newcol := i;
              break; // out of the for loop...
            end;
          end; //for
          if newcol > 1 then
          begin
            exit;
          end;
        end;

        Next;
        while ((not eof) and (newcol = -1)) do
        begin
          for i := 1 to 7 do // try ALL fields from left to right...
          begin
            if FieldByName('D' + inttostr(i)).asstring <> 'W' then
            begin
              newcol := i;
              break; // out of the for loop...
            end;
          end;
          if newcol = -1 then
            Next;
        end;

        // at this point either an available cell has been found on some record..
        // with newcol > 0 or the end of file has been reached. If this is the case
        // then go to the first record and keep doing it...
        if newcol = -1 then
        begin
          First;
          while ((not eof) and (newcol = -1)) do
          begin
            for i := 1 to 7 do // try ALL fields from left to right...
            begin
              if FieldByName('D' + inttostr(i)).asstring <> 'W' then
              begin
                newcol := i;
                break; // out of the for loop...
              end;
            end;
            if newcol = -1 then
              Next;
          end;
        end;

        // at this point the only way we don't have a valid cell is if ALL cells
        // somehow have 'W' on them (impossible!!!). If this is the case then exit
        // the grid...
        if newcol = -1 then
        begin
          btnSave.SetFocus;
          EnableControls;
          exit;
        end;
      end;
    end;

    // set table on new record, enable controls, set grid on new column

  end;

end; // procedure..


procedure TfAttend.btnSaveClick(Sender: TObject);
var
  i : integer;
begin
  // save only the codes that are not worked.
  // also make sure that a code that is now empty overwrites
  // another code in empattcd....

  if wwtempattmp.State = dsEdit then
    wwtempattmp.Post;
    
  with dmod1.adoqRun do
  begin
    // first delete all current week from empattcd.db...
    close;
    sql.Clear;
    sql.Add('delete from empattcd');
    sql.Add('where "sitecode" = ' + inttostr(sitecode));
    sql.Add('and (not("attcode" = ''W'') or attcode is null)');
    sql.Add('and "date" >= ' + quotedstr(formatDateTime('mm/dd/yyyy', selweekst)));
    sql.Add('and "date" <= ' + quotedstr(formatDateTime('mm/dd/yyyy', selweekst + 6)));
    execSQL;

    close;
    sql.Clear;
    sql.Add('select * from [#empattmp]');
    open;
  end;

  with dmod1.adotRun do
  begin
    close;
    tablename := 'EmpAttCd';

    open;

    while not dmod1.adoqRun.eof do
    begin
      // go to all d1-d7 fields...
      for i := 1 to 7 do
      begin
        if not(dmod1.adoqRun.FieldByName('d' + inttostr(i)).asstring = 'W') then
        begin
          insert;
          FieldByName('sitecode').asinteger := dmod1.adoqRun.FieldByName('sitecode').asinteger;
          FieldByName('sec').Value := dmod1.adoqRun.FieldByName('UserId').Value;
          FieldByName('date').asdatetime := selweekst + i - 1;
          FieldByName('attcode').asstring := dmod1.adoqRun.FieldByName('d' + inttostr(i)).asstring;
          FieldByName('lmdt').asdatetime := Now;
          post;
        end;
      end;
      dmod1.adoqRun.next;
    end;
    close;
    dmod1.adoqRun.close;
  end;
end;

procedure TfAttend.wwtEmpAtTmpAfterPost(DataSet: TDataSet);
begin
  // check if all days are filled in and enable btnSign if they are...
  if not init then
  begin
    with dmod1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select a."UserId" from "#empattmp" a');
      sql.Add('where a."d1" = '''' or a."d2" = ''''');
      sql.Add('or a."d3" = '''' or a."d4" = ''''');
      sql.Add('or a."d5" = '''' or a."d6" = '''' or a."d7" = ''''');
      open;
      if recordcount = 0 then
      begin
        btnSign.Enabled := True;
      end
      else
      begin
        btnSign.Enabled := False;
      end;
      close;
    end;
  end;
end;

procedure TfAttend.lookAttCodesCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if lookAttCodes.LookupValue = 'W' then
  begin
    showmessage('You can only declare an employee as "Worked" for a day by inserting' + #13 +
      ' at least one valid shift in Verify Clock Times for that employee for that day.');
    wwtempattmp.Cancel;
    exit;
  end;

  if wwtempattmp.State = dsEdit then
    wwtempattmp.Post;
end;

procedure TfAttend.btnSignClick(Sender: TObject);
begin
  // warn, ask for confirmation....
  if MessageDlg('You are about to sign off a week. If you proceed you will not be able to modify' +
    ' the week''s shift information anymore.' + #13 + #13 +
    'Click OK To Sign Off the Payroll from ' +
    formatDateTime('ddd ' + theDateFormat, selweekst) + ' to ' +
    formatDateTime('ddd ' + theDateFormat, selweekst + 6),
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then
  begin
    // first save the attcodes....
    btnSaveClick(self);

    // now sign-off the week...
    dmod1.adotRun.close;
    dmod1.adotRun.TableName := 'PaySign';
    dmod1.adotRun.open;
    dmod1.adotRun.insert;
    dmod1.adotRun.FieldByName('sitecode').asinteger := sitecode;
    dmod1.adotRun.FieldByName('PerSt').asdatetime := selWeekst;
    dmod1.adotRun.FieldByName('PerEnd').asdatetime := selweekst + 6;
    dmod1.adotRun.FieldByName('SignDT').asdatetime := Now;
    dmod1.adotRun.FieldByName('SignBy').asstring := CurrentUser.UserName;
    dmod1.adotRun.FieldByName('LMDT').asdatetime := Now;
    dmod1.adotRun.post;
    dmod1.adotRun.close;

    with dMod1.wwtSysVar do
    begin
      Open;
      if FieldByName('AutoPrintPayReport').AsBoolean then
         dmod1.DimReport(CurrentUser.UserName, CurrentUser.Password, 'Time & Attendance', 'btnSignClick', Selweekst, Selweekst + 6 );
      Close;
    end;

  end
  else
  begin
    if MessageDlg('You chose not to sign off the current week.' + #13 + #13 +
      'Do you want to save any changes you may have made to the Employee Attendance in this session?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      //save the attcodes....
      btnSaveClick(self);
    end;
  end;
end;


procedure TfAttend.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_SIGN_OFF);
end;

end.
