unit UVerify;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DB, Wwdatsrc,
  Dialogs, DBGrids, wwdblook, Mask, Wwdbedit, Wwdotdot, Wwdbcomb, DBTables,
  Wwtable, DBCtrls, shellAPI, Wwquery, Variants, ADODB, fEmployeeBreaks,
  AppEvnts, uRateOverrides, Menus;

type
  TVrfyDlg = class(TForm)
    Panel2: TPanel;
    DisplayDS: TwwDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnDelete: TBitBtn;
    btnInsert: TBitBtn;
    VerifyPC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    DBGrid2: TwwDBGrid;
    Combo1: TwwDBLookupCombo;
    pnlRateChg: TPanel;
    Label3: TLabel;
    bbtRateChg: TBitBtn;
    lblPayType: TLabel;
    btnLSPay: TBitBtn;
    pnlFilterView: TPanel;
    Label1: TLabel;
    BitBtn5: TBitBtn;
    Label4: TLabel;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    pnStatusMessage: TPanel;
    CopyQuery: TADOQuery;
    qryRun: TADOQuery;
    VrfySchd: TADOTable;
    VrfySchdFname: TStringField;
    VrfySchdName: TStringField;
    VrfySchdjobdesc: TStringField;
    VrfySchdwjobdesc: TStringField;
    VrfySchdSchin: TStringField;
    VrfySchdClockin: TStringField;
    VrfySchdSchout: TStringField;
    VrfySchdClockout: TStringField;
    VrfySchdAccIn: TStringField;
    VrfySchdAccOut: TStringField;
    VrfySchdBreak: TStringField;
    VrfySchdDechrs: TStringField;
    VrfySchdWorked: TStringField;
    VrfySchdConfirmed: TStringField;
    VrfySchdcworked: TStringField;
    VrfySchdShift: TSmallintField;
    VrfySchdFWorked: TFloatField;
    VrfySchdVisible: TStringField;
    VrfySchdRateMod: TStringField;
    VrfySchdRateMod2: TStringField;
    VrfySchdAdded: TSmallintField;
    VrfySchdKSchIn: TDateTimeField;
    VrfySchdBsDate: TDateField;
    DBGrid2IButton: TwwIButton;
    ADOCommand1: TADOCommand;
    adoqJobs: TADOQuery;
    VrfySchdUserId: TLargeIntField;
    VrfySchdRoleId: TIntegerField;
    VrfySchdWRoleId: TIntegerField;
    VrfySchdWorkedPayFrequencyId: TIntegerField;
    VrfySchdWorkedPaySchemeVersionId: TIntegerField;
    VrfySchdWorkedUserPayRateOverrideVersionId: TIntegerField;
    VrfySchdWorkedPaySchemeId: TIntegerField;
    procedure VerifyPCChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CopyWeek;
    procedure DBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FillList;
    procedure Combo1Enter(Sender: TObject);
    procedure DBGrid2ColEnter(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure SaveToSch;
    procedure VerifyPCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2ColExit(Sender: TObject);
    procedure ValidTime;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure OverlapAccept;
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure Combo1CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure DBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormResize(Sender: TObject);
    procedure bbtRateChgClick(Sender: TObject);
    procedure VrfySchdCalcFields(DataSet: TDataSet);
    procedure VrfySchdBeforePost(DataSet: TDataSet);
    procedure VrfySchdBeforeEdit(DataSet: TDataSet);
    procedure VrfySchdAfterScroll(DataSet: TDataSet);
    procedure VrfySchdConfirmedChange(Sender: TField);
    procedure btnLSPayClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure VrfySchdAfterDelete(DataSet: TDataSet);
    procedure BitBtn6Click(Sender: TObject);
    procedure VrfySchdAfterPost(DataSet: TDataSet);
    procedure VerifyPCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VrfySchdAfterOpen(DataSet: TDataSet);
    procedure VrfySchdBeforeClose(DataSet: TDataSet);
    procedure DBGrid2TitleButtonClick(Sender: TObject; AFieldName: String);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VrfySchdBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
    errflag, exitflag, brkflag, aoutflag, ainflag, breakflag, checkfields,
      ccDebug: boolean;
    oldvalue, lastfield, logev: string;

    ShowBreakEditForm : boolean;
    EmployeeBreaksForm : TEmployeeBreaksForm;

    procedure InsertScheduleRecord(var Ins: SmallInt; out success: boolean);
    procedure EditScheduleRecord(var Ed, Del: SmallInt; out success: boolean);
    procedure GetInAndOutTimesFromStrings(InTime, OutTime : string;
                                      var InDateTime, OutDateTime : TdateTime);
    procedure SetBreakField(newValue : string);
    procedure RevertFieldToOldValue;
    procedure ResetFieldFlags;
    procedure AutoAcceptShiftsFromScheduleTimes;
    procedure UpdateExtraPaymentButtonText;
    procedure UpdateRateChangePanel;
  public
    today, selWeekSt: tdatetime;
    delflag, reviewFlag, nocalcs: boolean;
    colno, delrecno: integer;
    vSiteCode: integer;
    vSiteName: string[20];
    paytypes: TStrings;
    { Public declarations }
  end;

var
  VrfyDlg: TVrfyDlg;

implementation

uses Dmodule1, uempmnu, UDelVrfy, UInsShft, uLSPay, uGlobals, ulog, uADO, DateUtils;

{$R *.DFM}

procedure TVrfyDlg.CopyWeek;
var
  errstr: string;
  keyvs: integer;
begin
  try
    // COPIES ALL DATA FOR SELECTED DAY INTO TEMPORARY SCHEDULE TABLE FOR VERIFYING
    keyvs := 0;
    checkfields := false;
    nocalcs := true;
    vrfyschd.DisableControls;

    vrfyschd.close;

    dmADO.EmptySQLTable('#vrfyschd');

    vrfyschd.open;
    //vrfyschd.requery;
    with CopyQuery do
    begin
      close;
      parameters.ParamByName('thedate').value := today;
      parameters.Parambyname('SiteId').value := vSiteCode;

      open;
      if not reviewFlag then
        logev := logev + ' ' + formatDateTime('ddd', today) + '(' + inttostr(recordcount) + ',';
      first;
      while not eof do
      begin
        vrfyschd.insert;
        vrfyschd.fieldbyname('name').asstring :=
          fieldbyname('lastname').asstring;
        TLargeintField(vrfyschd.fieldbyname('UserId')).AsLargeInt := fieldbyname('UserId').value;
        vrfyschd.fieldbyname('fname').asstring :=
          fieldbyname('firstname').asstring;
        vrfyschd.fieldbyname('kschin').asdatetime :=
          fieldbyname('schin').asdatetime;

        vrfyschd.fieldbyname('schin').asstring := formatDateTime('HH:nn',
          fieldbyname('schin').asdatetime);
        vrfyschd.fieldbyname('schout').asstring := formatDateTime('HH:nn',
          fieldbyname('schout').asdatetime);

        if length(fieldbyname('clockin').asstring) = 0 then
          vrfyschd.fieldbyname('clockin').asstring := ''
        else
          vrfyschd.fieldbyname('clockin').asstring := formatDateTime('HH:nn',
            fieldbyname('clockin').asdatetime);

        if length(fieldbyname('clockout').asstring) = 0 then
          vrfyschd.fieldbyname('clockout').asstring := ''
        else
          vrfyschd.fieldbyname('clockout').asstring := formatDateTime('HH:nn',
            fieldbyname('clockout').asdatetime);

        if length(fieldbyname('accin').asstring) = 0 then
          vrfyschd.fieldbyname('accin').asstring := ''
        else
          vrfyschd.fieldbyname('accin').asstring := formatDateTime('HH:nn',
            fieldbyname('accin').asdatetime);

        if length(fieldbyname('accout').asstring) = 0 then
          vrfyschd.fieldbyname('accout').asstring := ''
        else
          vrfyschd.fieldbyname('accout').asstring := formatDateTime('HH:nn',
            fieldbyname('accout').asdatetime);

        vrfyschd.fieldbyname('fworked').asfloat :=
          fieldbyname('fworked').asfloat;
        if fempmnu.paidflag then
          vrfyschd.fieldbyname('worked').asstring :=
            copy(timetostr(fieldbyname('worked').asdatetime +
            fieldbyname('break').asdatetime), 1, 5)
        else
          vrfyschd.fieldbyname('worked').asstring :=
            copy(timetostr(fieldbyname('worked').asdatetime), 1, 5);
        SetBreakField(copy(timetostr(fieldbyname('break').asdatetime), 1, 5));
        vrfyschd.fieldbyname('RoleId').asinteger :=
          fieldbyname('RoleId').asinteger;
        vrfyschd.fieldbyname('WRoleId').value :=
          fieldbyname('WRoleId').value;
        vrfyschd.fieldbyname('shift').asinteger :=
          fieldbyname('shift').asinteger;
        vrfyschd.fieldbyname('confirmed').asstring :=
          fieldbyname('confirmed').asstring;
        vrfyschd.fieldbyname('WorkedPayFrequencyId').asinteger :=
          fieldbyname('PayFrequencyId').asinteger;
        vrfyschd.fieldbyname('WorkedPaySchemeVersionId').Value := fieldbyname('WorkedPaySchemeVersionId').Value;
        vrfyschd.fieldbyname('WorkedPaySchemeId').Value := fieldbyname('PaySchemeId').Value;
        vrfyschd.fieldbyname('WorkedUserPayRateOverrideVersionId').Value := fieldbyname('WorkedUserPayRateOverrideVersionId').Value;
        if FieldByName('PaySchemeVersionLMDT').asstring = '' then
        begin
          vrfyschd.fieldbyname('ratemod').asstring := 'N';
        end
        else
        begin
          vrfyschd.fieldbyname('ratemod').asstring := 'Y';
        end;
        vrfyschd.fieldbyname('visible').asstring := 'Y';
        vrfyschd.fieldbyname('added').asinteger :=
          fieldbyname('errcode').asinteger;
        vrfyschd.fieldbyname('bsdate').asdatetime :=
          fieldbyname('bsdate').asdatetime;

        try
          vrfyschd.post;
        except
          on E: exception do
          begin
            inc(keyvs);
            vrfyschd.cancel;
            errstr := E.Message;
          end;
        end; // try..except
        next;
      end;

      if keyvs > 0 then
      begin
        dMod1.LogEventInDatabase('VrfSch CopyWeek Errs', keyvs, today, errstr);
      end;

      // do a check on BsDate SchIn. It should be all = today if not errors in Schedule...
      if isSite then
      begin
        with qryRun do
        begin
          close;
          sql.Clear;
          sql.Add('select a."bsdate", a."kschin"');
          sql.Add('from "#vrfyschd" a where a."kschin" < '
            + QuotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss', today + fempmnu.dtgrace)));
          sql.Add('or a."kschin" > '
            + QuotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss', today + 1 + fempmnu.dtgrace)));
          open;
          if recordcount > 0 then
          begin
            dMod1.LogEventInDatabase('VrfSch CopyWeek Errs', qryRun.recordcount, today, 'Shifts with BsDate-Schin wrong!');
          end;
          close;
        end;
      end;

      if (Today <= Date) and (not ReviewFlag) then
        AutoAcceptShiftsFromScheduleTimes;

      nocalcs := false;
      if not reviewFlag then
        logev := logev + inttostr(vrfyschd.recordcount) + ' - ';
      vrfyschd.first;
      vrfyschd.enablecontrols;
      checkfields := true;
    end;
  except
    on E: exception do
    begin
      fempmnu.loglist.items.clear;
      with fempmnu.loglist.items do
      begin
        add('CopyWeek ERROR other than post to VrfySchd; Error Msg: ');
        add(E.message);
      end;
      fempmnu.LogInfo;
      // end of logging..
      raise;
    end;
  end; // try..except
end;

// WRITES DATA BACK TO SCHEDULE ONCE ALL EDITING IS COMPLETED

procedure TVrfyDlg.SaveToSch;
var
  wasFiltered: Boolean;
  Ed, Ins, Del: SmallInt;
  errorOccurred, success: boolean;
begin
  errorOccurred := False;
  wasFiltered := False;

  try
    try
      Ed := 0;
      Ins := 0;
      Del := 0;
      NoCalcs := True;

      with VrfySchd do
      begin
        DisableControls;

        if Filtered then
        begin
          wasFiltered := True;
          Filtered := False;
        end;

        if Active then
          Requery
        else
          Open;

        First;
        if not ReviewFlag then
          LogEv := LogEv + inttostr(VrfySchd.RecordCount) + ',';

        // two kinds of records:
        // 1. records that arrived from schedule via CopyWeek; for them,
        //    locate and edit only neccessary fields (including making Visible = N if shift "deleted")
        // 2. records that were inserted IN THIS SESSION (as ones inserted say 2 days ago
        //    were in the schedule so they are type 1). They will have 'Added' = -999, make ErrCode = -1;
        //    Insert them using kschin, etc, and set BsDate = today. If they are Visible = N
        //    that means they were added then deleted, don't bother to insert them...

        while not EOF do
        begin
          if FieldByName('Added').AsInteger = -999 then
            InsertScheduleRecord(Ins, success)
          else
            EditScheduleRecord(Ed, Del, success);

          errorOccurred := errorOccurred or not(success);

          Next;
        end;
      end;

      LogEv := LogEv + inttostr(Ed) + ',' + inttostr(Ins) + ',' + inttostr(Del) + ')';
    except
      on E: exception do
      begin
        errorOccurred := true;

        // log the action..
        with fEmpMnu.LogList.Items do
        begin
          Clear;

          Add('SaveToSch ERROR other than post to Schedule; (' +
            formatDateTime('mm/dd/yyyy', today) + ')');
          Add('Error Msg: ' + E.message);
        end;

        fEmpMnu.LogInfo;
      end;
    end;
  finally
    if wasFiltered then
      VrfySchd.Filtered := True;

    VrfySchd.EnableControls;
    VrfySchd.Close;

    NoCalcs := False;

    if errorOccurred then
      ShowMessage('An error occurred whilst trying to save your changes.'
          + #13 + 'Part or all of your changes have not been saved. '
          + #13#13 + 'Please contact Zonal.');
  end;
end;

procedure TVrfyDlg.FormShow(Sender: TObject);
begin
  with adoqJobs do
  begin
    SQl.Clear;
    SQL.Add('select r.Id, r.Name, ps.PayFrequencyId, ps.CurrentPaySchemeVersionId, sub.CurrentUserPayRateOverrideVersionId');
    SQL.Add('from ac_UserRoles ur');
    SQL.Add('join ac_Role r');
    SQL.Add('on r.Id = ur.RoleId');
    SQL.Add('  join ac_PayScheme ps');
    SQL.Add('  on ur.PaySchemeId = ps.Id');
    SQL.Add('    join ac_PaySchemeVersion v');
    SQL.Add('    on v.Id = ps.CurrentPaySchemeVersionId');
    SQL.Add('      left join (select * from ac_UserPayRateOverride o');
    SQL.Add('                 where o.Deleted = 0) sub');
    SQL.Add('      on sub.PaySchemeId = ps.Id and sub.UserId = ur.UserId and sub.SiteId = ' + IntToStr(vSiteCode));
    SQL.Add('where ur.UserId = :UserId');
  end;

  try
    dbGrid2.Height := VerifyPC.Height - 28;
    dbGrid2.Width := VerifyPC.Width - 5;
    colno := 3;
    VerifyPC.ActivePage := Tabsheet1;
    today := selWeekSt;
    logev := 'Day(IN QryRecs,TblRecs - OUT TblRecs,ed,ins,del)';
    CopyWeek;
    if reviewFlag then
    begin
      Caption := 'Review Clock Times Week Begining   ' + datetostr(today);
      bitbtn2.visible := false;
      btnDelete.visible := false; // change back to false
      btnInsert.visible := false;
      DBGrid2.readonly := true;
      DBGrid2.fixedcols := 13;
      DBGrid2.color := clBtnFace;
      bbtRateChg.Visible := False;
      btnLSPay.visible := false;
    end
    else
    begin
      log.setmodule('VrfyClockTimes');
      log.event('START for Week Begining   ' + datetostr(today));
      Caption := 'Verify Clock Times Week Begining   ' + datetostr(today);

      if ((today + 1 + fempmnu.dtroll) > fempmnu.empLADT) then
      begin

        // 15812 beg

        pnStatusMessage.caption :=
          'Warning: All or part of the shift information has not been read in for this date.';
        pnStatusMessage.visible := true;
      end;

      if (copyquery.recordcount > 0) then
      begin
        bitbtn2.visible := true;
        btnDelete.visible := true;
        DBGrid2.readonly := false;
        btnLSPay.visible := true;
        btnInsert.visible := true;
        bitbtn6.visible := true;
      end
      else
      begin
        pnStatusMessage.caption :=
          ' Note: No schedule information defined for this date';
        pnStatusMessage.visible := true;

        bitbtn2.visible := false;
        btnDelete.visible := false;
        dbgrid2.readonly := true;
        bbtRateChg.Visible := False;
        btnLSPay.visible := false;
        btnInsert.visible := true;
        bitbtn6.visible := false;
      end;

      DBGrid2.fixedcols := 3;
      DBGrid2.color := clwindow;

      // 15812 ends

    end;
    copyquery.close;

    BitBtn7.Visible := btnDelete.Visible; // job 14572

    pnlRateChg.Visible := fempmnu.ratechg;

    //Don't allow Break field on grid to be manually edited.
    VrfySchdBreak.ReadOnly := true;
    ShowBreakEditForm := true;

    if not isSite then
    begin
      Caption := Caption + ' for Site "' + vSiteName + '"';
    end;

    Caption := Caption + ' (Schedule Day Start ' + fempmnu.grace +
      ', Business Day Start ' + fempmnu.roll + ')';
    screen.cursor := crDefault;
  except
    on E: exception do
    begin
      // log the action..
      fempmnu.loglist.items.clear;
      with fempmnu.loglist.items do
      begin
        add('Show VrfyClckTm ERROR; Error Msg: ');
        add(E.message);
      end;
      fempmnu.LogInfo;
      // end of logging..
      showmessage('There was an Error while trying to display this form!' +
        #13 +
          'Please contact Zonal. You are advised not to use Verify Clock Times until the error has been fixed.');
    end;
  end;
end;

procedure TVrfyDlg.VerifyPCChange(Sender: TObject);
var
  errstr: string;
begin
  // CATERS FOR ALL LABEL RESETTING AND BUTTON ENABLING WHEN TAB SHEET CHANGES
  try
    pnStatusMessage.visible := false;
    today := selWeekSt + Verifypc.ActivePage.PageIndex;

    CopyWeek;

    if ccDebug then
      errstr := 'Day:' + formatDateTime('ddmmmyyyy', today) + '; sWst:' +
        formatDateTime('ddmmmyyyy', selWeekSt) + '; eLADT:' +
          formatDateTime('ddmmmyyyy', fempmnu.empLADT) +
        '; CpyQRecs:' + inttostr(copyquery.recordcount);

    if reviewFlag then
    begin
      bitbtn2.visible := false;
      btnDelete.visible := false;
      btnInsert.visible := false;
      DBGrid2.readonly := true;
      DBGrid2.fixedcols := 13;
      DBGrid2.color := clBtnFace;
      bbtRateChg.Visible := False;
      btnLSPay.visible := false;
    end
    else
    begin
      // 15812 beg
      if ((today + 1 + fempmnu.dtroll) > fempmnu.empLADT) then
      begin
        pnStatusMessage.caption :=
          ' Warning: All or part of the shift information has not been read in for this date.';
        pnStatusMessage.visible := true;
      end;

      if (copyquery.recordcount > 0) then
      begin
        bitbtn2.visible := true;
        btnDelete.visible := true;
        DBGrid2.readonly := false;
        bbtRateChg.Visible := true;
        btnLSPay.visible := true;
        btnInsert.visible := true;
        bitbtn6.visible := true;
        if ccDebug then
          errStr := errStr + '; V,OK';
      end
      else
      begin
        pnStatusMessage.caption :=
          ' Note: No schedule information defined for this date';
        pnStatusMessage.visible := true;
        bitbtn2.visible := false;
        btnDelete.visible := false;
        dbgrid2.readonly := true;
        bbtRateChg.Visible := False;
        btnLSPay.visible := false;
        btnInsert.visible := true;
        bitbtn6.visible := false;
        if ccDebug then
          errStr := errStr + '; V,CpyQRC<=0';
      end;

      DBGrid2.fixedcols := 3;
      DBGrid2.color := clwindow;

    end;
    // 15812 ends

    BitBtn7.Visible := btnDelete.Visible; // job 14572

    copyquery.close;
    dbgrid2.SetFocus;

    if ccDebug then
    begin
      // log the action..
      fempmnu.loglist.items.clear;
      with fempmnu.loglist.items do
      begin
        add('ccDebug VerfyClckTm -- ' + errstr);
      end;
      fempmnu.LogInfo;
      // end of logging..
    end;
  except
    on E: exception do
    begin
      // log the action..
      fempmnu.loglist.items.clear;
      with fempmnu.loglist.items do
      begin
        add('Change VerfyClckTm Page ERROR; (' + formatDateTime('mm/dd/yyyy',
          today) + ')');
        add('Error Msg: ' + E.message);
      end;
      fempmnu.LogInfo;
      // end of logging..
      showmessage('There was an Error while trying to display this page! Error Message:'
        +
        #13 + #13 + E.Message + #13 +
        #13 +
          'Please contact Zonal. You are advised not to use Verify Clock Times until the error has been fixed.');
    end;
  end;
end;

procedure TVrfyDlg.DBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not reviewFlag then
  begin
    case DBgrid2.GetACtiveCol of
      5, 6, 7, 8: DBGrid2.setactivefield('wjobdesc');
      14:
        begin
          with vrfyschd do
          begin
            if (state = dsEdit) or (state = dsInsert) then post;
          end;
        end;
    end;
  end;
end;

procedure TvrfyDlg.FillList;
begin
//  with wwtable1 do
//  begin
//    Close;
//    Filter := '(SEC =' +
//      FloatToStr(vrfyschd.FieldByName('SEC').AsFloat) +
//      ')' + ' AND (((Deleted = ''N'')' + ' AND (Valid = ''D'')) OR ' +
//      '((termemp = ''Y'') AND (Valid = ''D'')))';
//    Filtered := true;
//    Open;
//  end;
end;


procedure Tvrfydlg.WMSysCommand;
{Used to minimise the whole app if the current form is minimised}
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
//    flogdlg.theForm := self;
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TVrfyDlg.Combo1Enter(Sender: TObject);
begin
  if (DBGrid2.GetActiveCol = 4) and
    (vrfyschd.fieldbyname('Confirmed').asstring = 'Y') then
  begin
    DBGrid2.setactivefield('Accin');
    exit;
  end;
  FillList;
end;
// PREVENTS THE USER MOVING INTO CERTAIN FIELDS IN ORDER TO KEEP THEM NON-EDITABLE

procedure TVrfyDlg.DBGrid2ColEnter(Sender: TObject);
begin
  if not reviewFlag then
  begin
    if (DBGrid2.GetActiveCol = 4) and
      (vrfyschd.fieldbyname('Confirmed').asstring = 'Y') then
      DBGrid2.setactivefield('Accin');

    if ((DBGrid2.Getactivecol <= 8) and (DBGrid2.Getactivecol >= 5)) and
      (colno = 4) then
      DBGrid2.setactivefield('Accin');
    if ((DBGrid2.Getactivecol <= 8) and (DBGrid2.Getactivecol >= 5)) and
      (colno = 9) then
      DBGrid2.setactivefield('wjobdesc');
    if (DBGrid2.Getactivecol = 12) then
      DBGrid2.setactivefield('Confirmed')
    else if (DBGrid2.Getactivecol = 13) then
      if colno = 11 then
        DBGrid2.setactivefield('Confirmed')
      else
        DBGrid2.setactivefield('Break');
    if DBGrid2.GetActiveCol > 4 then
    begin
      with vrfyschd do
      begin
        if (state = dsinsert) or (state = dsedit) then
        try
          post;
        except
          on exception do
            beep;
        end;
      end;
    end;
  end;
  if breakflag then
  begin
    DBGrid2.SetActiveField(lastfield);
    breakflag := false;
  end;
  colno := DBGrid2.Getactivecol;
end;

procedure TVrfyDlg.OKBtnClick(Sender: TObject);
begin
  close;
end;
// ALLOWS OR DISALLOWS CHANGE OF PAGE ACCORDING TO WHETHER OR NOT ALL DATA IS
// CORRECTLY POSTED

procedure TVrfyDlg.VerifyPCChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if (reviewFlag) or ((dbGrid2.readonly) and
    not (dbgrid2.datasource.dataset.recordcount = 0)) then
    exit;

  errflag := false;

  Log.Event('TVrfyDlg.VerifyPCChanging: Calling dbgrid2colexit');
  dbgrid2colexit(sender);

  if not errflag then
  begin
    with vrfyschd do
      if (state = dsedit) or (state = dsinsert) then
        post;
    exitflag := false;

    Log.Event('TVrfyDlg.VerifyPCChanging: Overlap check');
    OverlapAccept;

    if exitflag then
    begin
      allowchange := false;
      exit;
    end;
    SaveToSch; // Save to Schedule only if not reviewing
  end
  else
  begin
    allowchange := not errflag;
    errflag := false;
  end;

  Log.Event('TVrfyDlg.VerifyPCChanging: Finish');
end;

function JustExit: boolean;
begin
  if MessageDlg('There is an error with the shifts currently on display.' +
    #13 + #10 +
      'If you want to try and correct the error click "Cancel" and you will ' +
    #13 + #10 + 'stay in the Verify Clock Times window.' + #13 + #10 +
    'If you just want to exit, click "OK" and you will go back to the Main Menu.' +
    #13 + #10 +
      'Be advised that if you click "OK" any editing/insertion/deletion made to' +
    #13 + #10 + 'the shifts on display will NOT be saved.',
    mtError, [mbOK, mbCancel], 0) = mrOK then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end; // function..

procedure TVrfyDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (reviewFlag) or (dbGrid2.readonly) then
    exit;

  if (vrfyschd.state = dsinsert) or (vrfyschd.state = dsedit) then
  try
    vrfyschd.post;
  except
    on exception do
    begin
      vrfyschd.cancel;
    end;
  end;
  // check to see that all emps with accin/out have a 'Worked job'
  with qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from "#vrfyschd" a');
    sql.Add('where (a."WRoleId" < 1) and (a."confirmed" = ''Y'') and (a."accin" is not NULL) and (a."accout" is not NULL)');
    sql.Add('and a.accin <> ''''');
    sql.Add('and a.accout <> ''''');
    open;
    if recordcount > 0 then
    begin
      close;
      showmessage('All confirmed shifts with accepted times must have a "Worked Job"!');

      if JustExit then
      begin
        exit;
      end
      else
      begin
        action := caNone;
        exit;
      end;
    end;
    close;
  end;
  //////////////////////////////////////////
  // check to see that no 2 shifts have overlapping accepted times
  exitflag := false;

  Log.Event('TVrfyDlg.FormClose: Overlap check');
  OverlapAccept;
  Log.Event('TVrfyDlg.FormClose: Overlap check complete');

  if exitflag then
  begin
    if JustExit then
    begin
      exit;
    end
    else
    begin
      action := caNone;
      exit;
    end;
  end;
  SaveToSch;
  log.event('Exit Ops: ' + logev);
end;

procedure TVrfyDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  errflag := false;
  dbgrid2colexit(sender);
  canclose := not errflag;
  errflag := false;
  dbgrid2.setfocus;
end;

procedure TVrfyDlg.OverlapAccept;
var
  in1, out1, in2, out2: tdatetime;
  emps: string;
begin
  //selects relevant fields from vrfyschd.db and employee.db for all records in
  // vrfyschd.db and moves them to Overlap.db
  with qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a."UserId", a."fname", a."name", a."accin", a."accout",');
    sql.Add('(b."accin") as in2, (b."accout") as out2');
    sql.Add('from "#vrfyschd" a, "#vrfyschd" b');
    sql.Add('where a."UserId" = b."UserId"');
    sql.Add('and a."shift" = 1');
    sql.Add('and b."shift" = 2');
    sql.Add('and a."visible" = ''Y''');
    sql.Add('and b."visible" = ''Y''');
    sql.Add('and a.accin is not null');
    sql.Add('and a.accout is not null');
    sql.Add('and b.accin is not null');
    sql.Add('and b.accout is not null');
    sql.Add('and a.accin <> ''''');
    sql.Add('and a.accout <> ''''');
    sql.Add('and b.accin <> ''''');
    sql.Add('and b.accout <> '''''); 

    open;

    emps := '';

    while not eof do
    begin
      // PW Job 14672
      with TStringList.create do
      try
        if FieldbyName('accin').isnull xor FieldByName('accout').isnull then
          add('Employee ' + fieldbyname('fname').asstring + ' ' +
            fieldbyname('name').asstring +
              ' has an accepted in/out time missing.');
        if FieldbyName('in2').isnull xor FieldByName('out2').isnull then
          add('Employee ' + fieldbyname('fname').asstring + ' ' +
            fieldbyname('name').asstring +
              ' has an accepted in/out time missing.');
        if (FieldByName('accin').isnull and FieldByName('accout').isnull) or
          (FieldByName('in2').isnull and FieldByName('out2').isnull) then
        begin
          {skip overlap check for accepted in/out=NULL fields}
          {These are possible errors in the matching process - but they still}
          {shouldn't crash the system. They can't overlap anyway!}
          next;
          continue;
        end;
        if count > 0 then
        begin
          showmessage(text);
          close;
          exitflag := true;
          exit;
        end;
      finally
        free;
      end;
      if FieldByName('accin').asstring < fempmnu.grace then
        in1 := today + 1 + strtotime(FieldByName('accin').asstring)
      else
        in1 := today + strtotime(FieldByName('accin').asstring);

      if FieldByName('accout').asstring < FieldByName('accin').asstring then
        out1 := trunc(in1) + 1 + strtotime(FieldByName('accout').asstring)
      else
        out1 := trunc(in1) + strtotime(FieldByName('accout').asstring);

      if FieldByName('in2').asstring < fempmnu.grace then
        in2 := today + 1 + strtotime(FieldByName('in2').asstring)
      else
        in2 := today + strtotime(FieldByName('in2').asstring);

      if FieldByName('out2').asstring < FieldByName('in2').asstring then
        out2 := trunc(in2) + 1 + strtotime(FieldByName('out2').asstring)
      else
        out2 := trunc(in2) + strtotime(FieldByName('out2').asstring);

      if (in1 < out2) and (out1 > in2) then
      begin
        showmessage((FieldByName('fname').asstring) + ' ' +
          (FieldByName('name').asstring) +
          ' has accepted shifts which overlap.' + #13 +
          'Please alter times or delete necessary shifts');
        close;
        exitflag := true;
        exit;
      end;
      next;
    end;
    close;
  end;

end;

procedure TVrfyDlg.DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const GridMovementKeys = [VK_RETURN, VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_TAB];
var
  hrstr: string;
begin
  if (key = VK_left) and (DBGrid2.Getactivecol = 9) then
    DBGrid2.setactivefield('wjobdesc')
  else if (key = VK_up) or (key = VK_down) then
    dbgrid2colexit(sender)
  else if not DBGrid2.readonly then
  begin
    if (UpperCase(DBGrid2.SelectedField.FieldName) = 'BREAK') and ShowBreakEditForm then
    begin
       if key = VK_F2 then
         DBGrid2DblClick(nil)
       else if not(key in GridMovementKeys + [VK_F1, VK_SHIFT]) then
         ShowMessage('Press F2 or Double-click mouse to edit Break');
    end
    else
    begin
      if (key = VK_delete) and (LowerCase(DBGrid2.fieldname(DBGrid2.GetActiveCol)) = 'confirmed') then
      begin
        with vrfyschd do
        begin
          edit;
          fieldbyname('Confirmed').value := 'N';
          if state in [dsEdit, dsInsert] then
            post;
        end;
      end
      else
        if (key = VK_Return) then
          // WHEN ENTER IS PRESSED // CHECKS VALIDITY OF TIME AND APPENDS ':00' TO THE ENYTERED TEXT IF IT IS ONLY 2 CHARS
        begin
          if (vrfyschd.state <> dsedit) then
            exit;
          if dbgrid2.InPlaceEditor = nil then
            exit;
          if (length(dbgrid2.InPlaceEditor.Text) = 3) then
          begin
            hrstr := copy(DBGrid2.InPlaceEditor.Text, 1, 2);
            with vrfyschd do
            begin
              if strtoint(hrstr) > 23 then
              begin
                messagedlg((hrstr) + ' is not a valid hour !', mterror,
                  [mbok], 0);
                //edit;
                if ainflag then
                  fieldbyname('accin').asstring := oldvalue
                else if aoutflag then
                  fieldbyname('accout').asstring := oldvalue
                else if brkflag then
                  SetBreakField(oldvalue);
                post;
              end
              else
              begin
                edit;
                fieldbyname
                  (DBGrid2.fieldname(DBGrid2.GetActiveCol)).value
                  := DBGrid2.InPlaceEditor.Text + '00';
                post;
              end;
            end
          end
          else
          begin
            if (length(dbgrid2.InPlaceEditor.Text) = 5) then
              ValidTime
            else if (length(dbgrid2.InPlaceEditor.Text) = 1) or
              (length(dbgrid2.InPlaceEditor.Text) = 4) then
            begin
              messagedlg('String: "' + dbgrid2.inplaceeditor.text +
                '" is not a valid time !', mterror, [mbok], 0);
              if ainflag then
                vrfyschd.fieldbyname('accin').asstring := oldvalue
              else if aoutflag then
                vrfyschd.fieldbyname('accout').asstring := oldvalue
              else if brkflag then
                SetBreakField(oldvalue);
              vrfyschd.post;
            end;
          end;
        end;
    end;
  end;
end;
// CHECKS VALIDITY OF TIME IF 5 CHARS HAVE BEEN ENTERED

procedure Tvrfydlg.ValidTime;
var
  s1, s2: string;

begin
  with vrfyschd do
  begin
    if (DBGrid2.InPlaceEditor = nil) then
      exit;

    if (DBGrid2.InPlaceEditor.Text = '') then
      exit;

    s1 := copy(DBGrid2.InPlaceEditor.Text, 1, 2);
    s2 := copy(DBGrid2.InPlaceEditor.Text, 4, 2);
    if (s1 > inttostr(23)) or (s2 > inttostr(59)) then
    begin
      messagedlg('String: "' + DBGrid2.InPlaceEditor.Text +
        '" is not a valid time !', mterror, [mbok], 0);
      //edit;
      if ainflag then
        fieldbyname('accin').asstring := oldvalue
      else if aoutflag then
        fieldbyname('accout').asstring := oldvalue
      else if brkflag then
        SetBreakField(oldvalue);
      post;
      errflag := true;
    end
    else
    begin
      if (state = dsEdit) or (state = dsInsert) then post;
    end;
  end;
end;

procedure TVrfyDlg.DBGrid2ColExit(Sender: TObject);
begin
  if DBGrid2.InPlaceEditor = nil then
      exit;

    if (DBGrid2.InPlaceEditor.Text = '') then
      exit;

  if (length(dbgrid2.InPlaceEditor.Text) = 5) then
    ValidTime
  else
  begin
    messagedlg('String: "' + dbgrid2.inplaceeditor.text +
      '" is not a valid time !', mterror, [mbok], 0);
    if ainflag then
      vrfyschd.fieldbyname('accin').asstring := oldvalue
    else if aoutflag then
      vrfyschd.fieldbyname('accout').asstring := oldvalue
    else if brkflag then
      SetBreakField(oldvalue);
    vrfyschd.post;
  end;
end;

procedure TVrfyDlg.FormCreate(Sender: TObject);
begin
  breakflag := false;
  nocalcs := false;
  ccDebug := False;

  if HelpExists then
    setHelpContextID(self, EMP_VERIFY);

  EmployeeBreaksForm := TEmployeeBreaksForm.Create(self);
end;

procedure TVrfyDlg.BitBtn1Click(Sender: TObject);
begin
  close;
end;

// CHECKS THE CONFIRMED FLAG AGAINST ALL RECORDS WHICH HAVE VALID
// ACCEPTED TIMES

procedure TVrfyDlg.BitBtn2Click(Sender: TObject);
var
  badcount: smallint;
begin
  with vrfyschd do
  begin
    dbgrid2.SetActiveField('confirmed');
    if state = dsEdit then
      Post;
    open;
    disablecontrols;
    first;
    badcount := 0;
    while not EOF do
    begin
      if fieldbyname('confirmed').asstring = 'Y' then
      begin
        next;
        continue;
      end;

      if ((fieldbyname('accin').asstring <> '') and
        (fieldbyname('accout').asstring <> '') and
        (fieldbyname('WRoleId').asstring <> '') and
          (fieldbyname('WRoleId').asinteger <> 0) and
        (fieldbyname('accin').asstring <>
        fieldbyname('accout').asstring)) then
      begin
        edit;
        fieldbyname('confirmed').value := 'Y';
        post;
      end
      else
      begin
        inc(badcount);
      end;
      next;
    end;

    if badcount > 0 then
    begin
      if MessageDlg('Not all records could be confirmed! There are ' +
        inttostr(badcount) +
        ' records without Accepted ' +
        #13 + #10 +
          'Times and/or Worked Job information. The system can display only ' +
        #13 + #10 +
          'these unconfirmed records to allow you to deal with them all at once. ' +
        #13 + #10 +
          'Alternatively you may want to confirm them one by one later.' +
        #13 + #10 + '' + #13 + #10 +
          'Do you want to deal with these records now?',
        mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        Filter := 'Confirmed = ' + #39 + 'N' + #39;
        Filtered := True;
        //Refresh;
        pnlFilterView.Visible := True;
        if recordcount = 0 then
        begin
          dbgrid2.readonly := true;
        end;
      end;
    end;
    enablecontrols;
    //refresh;
  end;
end;

procedure TVrfyDlg.btnDeleteClick(Sender: TObject);
begin
  delrecno := VrfySchd.RecNo;
  FDelVrfy := TFDelVrfy.Create(VrfyDlg);
  FDelVrfy.showmodal;
  FDelVrfy.free;
  DBgrid2.refresh;

  if VrfySchd.RecordCount < delRecNo then
    VrfySchd.Last
  else
    VrfySchd.RecNo := delrecno;
end;

procedure CalcFworked(var fwork: real; var ftime: tdatetime);
begin
  if finsshft.maskedit2.text > finsshft.maskedit1.text then
    ftime := strtotime(finsshft.maskedit2.text) -
      strtotime(finsshft.maskedit1.text)
  else
    ftime := (strtotime(finsshft.maskedit2.text) + 1.0) -
      strtotime(finsshft.maskedit1.text);
  fwork := (strtofloat(copy(timetostr(ftime), 1, 2)) * 3600) +
    (strtofloat(copy(timetostr(ftime), 4, 2)) * 60);
end;

procedure TVrfyDlg.btnInsertClick(Sender: TObject);
var
  fwork: real;
  ftime: tdatetime;
  errstring: string;
begin
  FinsShft := TFinsShft.create(self);
  FInsShft.SiteCode := vSiteCode;
  if FinsShft.showmodal = mrOK then
  begin
    CalcFworked(fwork, ftime);
    with vrfyschd do
    begin
      try
        insert;
        TLargeIntField(fieldbyname('UserId')).AsLargeInt := strtoInt64(FInsShft.combo1.value);
        errstring := 'UserId';
        fieldbyname('fname').asstring :=
          finsshft.adoquery1.FieldByName('firstname').asstring;
        errstring := 'First Name';
        fieldbyname('name').asstring :=
          finsshft.adoquery1.FieldByName('lastname').asstring;
        errstring := 'Name';
        fieldbyname('Kschin').asdatetime := finsshft.Kschin;
        errstring := 'Sch. In DateTime';
        fieldbyname('schin').asstring := finsshft.maskedit1.text;
        errstring := 'Sch. In time';
        fieldbyname('schout').asstring := finsshft.maskedit1.text;
        errstring := 'Sch. Out time';
        fieldbyname('accin').asstring := finsshft.maskedit1.text;
        errstring := 'Acc. In time';
        fieldbyname('accout').asstring := finsshft.maskedit2.text;
        errstring := 'Acc. Out time';
        fieldbyname('fworked').asfloat := fwork;
        errstring := 'Fworked time';
        fieldbyname('worked').asstring := copy(timetostr(ftime), 1, 5);
        errstring := 'Worked time';
        SetBreakField('00:00');
        fieldbyname('RoleId').asinteger :=  NULL_JOB_CODE;
        fieldbyname('WRoleId').asstring :=
          finsshft.combo2.getcombovalue(finsshft.combo2.text);
        errstring := 'WRoleId';

        if finsshft.shiftvar = 3 then
          fieldbyname('shift').asinteger := 1
        else
          fieldbyname('shift').asinteger := finsshft.shiftvar;
        errstring := 'Shift number';
        fieldbyname('confirmed').asstring := 'N';
        fieldbyname('Visible').asstring := 'Y';
        fieldbyname('added').asinteger := -999;
        errstring := 'Pay. Info';

        // get payment info for this user-role combination
        with qryRun do
        begin
          close;
          sql.Clear;
          sql.Add('select * from');
          sql.Add('ac_UserRoles ur');
          sql.Add('join ac_PayScheme ps');
          sql.Add('on ur.PaySchemeId =  ps.Id');
          sql.Add(' left join (select * from ac_UserPayRateOverride o');
          sql.Add('            where o.Deleted = 0) sub');
          sql.Add(' on sub.SiteId = ' + IntToStr(vSiteCode));
          sql.Add('   and sub.userId = ' + finsshft.combo1.value);
          sql.Add('   and sub.PaySchemeId = ps.Id');
          sql.Add('where ur.UserId  = ' + finsshft.combo1.value);
          sql.Add('and ur."RoleId" = ' +
            finsshft.combo2.getcombovalue(finsshft.combo2.text));
          open;
        end;

        fieldbyname('WorkedPaySchemeVersionId').Value :=
          qryRun.FieldByName('CurrentPaySchemeVersionId').Value;
        fieldbyname('WorkedUserPayRateOverrideVersionID').Value :=
          qryRun.FieldByName('CurrentUserPayRateOverrideVersionId').Value;
        fieldbyname('WorkedPayFrequencyID').Value :=
          qryRun.FieldByName('PayFrequencyID').Value;

        qryRun.close;

        post;

        // change shift no of previous shift 1 if the new one becomes shift 1...
        if finsshft.shiftvar = 3 then
        begin
          locate('UserId;shift;schin',
            vararrayof([strtoint64(finsshft.combo1.value), 1, finsshft.s1time]),
              []);
          edit;
          FieldByName('shift').asinteger := 2;
          post;
        end;

        close;
        open;
        if recordcount > 0 then
        begin
          if not reviewFlag then
          begin
            bitbtn2.visible := true;
            btnDelete.visible := true;
            btnLSPay.visible := true;
            dbgrid2.readonly := false;
          end;
        end
        else
        begin
          bitbtn2.visible := false;
          btnLSPay.visible := false;
          btnDelete.visible := false;
          dbgrid2.readonly := true;
        end;
        BitBtn7.Visible := btnDelete.Visible; // job 14572
        DBGrid2.refresh;
      except
        on exception do
        begin
          cancel;
          showmessage('ERROR: Invalid ' + errstring);
          errstring := '';
        end;
      end; // try..except
    end; // with vrfyschd..
  end; // if finsshft.modalresult = mrOK
  FinsShft.free;
end;

procedure TVrfyDlg.Combo1CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if vrfyschd.State = dsEdit then
  begin
    adoqjobs.locate('Name', Combo1.Text, []);

    vrfyschd.fieldbyname('WorkedPayFrequencyId').asinteger :=
      adoqjobs.FieldByName('PayFrequencyId').Value;
    vrfyschd.fieldbyname('WorkedPaySchemeVersionId').Value :=
      adoqjobs.FieldByName('CurrentPaySchemeVersionId').Value;
    vrfyschd.fieldbyname('WorkedUserPayRateOverrideVersionId').Value :=
      adoqjobs.FieldByName('CurrentUserPayRateOverrideVersionId').Value;
    vrfyschd.fieldbyname('ratemod').asstring := '';
    vrfyschd.fieldbyname('ratemod2').asstring := '';
    vrfyschd.Post;

    UpdateRateChangePanel;
  end;
end;

procedure TVrfyDlg.DBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin

  if dbgrid2.DataSource.DataSet.FieldByName('WorkedPayFrequencyId').asinteger > 2 then
  begin
    if (Field.FieldName = 'Name') or (Field.FieldName = 'Fname') then
    begin
      AFont.Style := AFont.Style + [fsBold];
    end
    else
    begin
      AFont.Style := AFont.Style - [fsBold];
    end;
  end;

  if reviewFlag then
    exit;

  // make schin/out, clockin/out, dechrs, worked clbuttonface if conf = N,
  // make all but conf = clbuttonface if conf = Y, make salaried people bold,
  // and rate mod rows italic

  if dbgrid2.DataSource.DataSet.FieldByName('confirmed').asstring = 'Y' then
  begin
    if Field.FieldName <> 'Confirmed' then
      ABrush.Color := clBtnFace;
  end
  else
  begin
    if (Field.FieldName = 'AccIn') or (Field.FieldName = 'AccOut') or
      (Field.FieldName = 'Break') or (Field.FieldName = 'wjobdesc') or
      (Field.FieldName = 'Confirmed') then
    begin

      if (State = [gdSelected]) then // or (State = [gdFocused]) then
      begin
        ABrush.Color := clActiveCaption;
      end
      else
      begin
        ABrush.Color := clWindow;
      end;

      if Highlight then ABrush.Color := clActiveCaption;
    end
    else
    begin
      ABrush.Color := clBtnFace;
    end;
  end;

  if dbgrid2.DataSource.DataSet.FieldByName('ratemod').asstring = 'Y' then
  begin
    if (Field.FieldName = 'Name') or (Field.FieldName = 'Fname') then
    begin
      AFont.Style := AFont.Style + [fsItalic];
    end
    else
    begin
      AFont.Style := AFont.Style - [fsItalic];
    end;
  end;
end;

procedure TVrfyDlg.FormResize(Sender: TObject);
begin
  dbGrid2.Height := VerifyPC.Height - 28;
  dbGrid2.Width := VerifyPC.Width - 5;
end;

procedure TVrfyDlg.bbtRateChgClick(Sender: TObject);
var
  RateOverridesDlg: TfRateOverrides;
begin
  RateOverridesDlg := TfRateoverrides.Create(Self);
  try
    RateOverridesDlg.WorkedPaySchemeVersionID := VrfySchd.FieldByName('WorkedPaySchemeVersionId').AsInteger;
    RateOverridesDlg.WorkedUserPayRateOverrideVersionID := VrfySchd.FieldByName('WorkedUserPayRateOverrideVersionId').AsInteger;
    RateOverridesDlg.SiteId := vSiteCode;
    RateOverridesDlg.UserId := VrfySchd.FieldByName('Userid').Value;
    RateOverridesDlg.Schin := VrfySchd.FieldByName('KSchin').AsDateTime;
    if RateOverridesDlg.ShowModal = mrOK then
    begin
      with dbgrid2.DataSource.DataSet do
      begin
        edit;
        dbgrid2.DataSource.DataSet.FieldByName('RateMod').asstring := 'Y';
        dbgrid2.DataSource.DataSet.FieldByName('RateMod2').asstring := 'Y';
        post;
      end;
    end;
  finally
    RateOverridesDlg.Release;
  end;
end;

procedure TVrfyDlg.VrfySchdCalcFields(DataSet: TDataSet);
begin
  with VrfySchd do
  begin
    if FieldByName('worked').AsString = '' then
      exit;

    FieldByName('DecHrs').AsString := FormatFloat('00.00',
            dMod1.TimeToDecimalTime(StrToTime(FieldByName('worked').AsString)));
  end;
end;

procedure TVrfyDlg.RevertFieldToOldValue;
begin
  with vrfyschd do
    if ainflag then
      fieldbyname('accin').asstring := oldvalue
    else if aoutflag then
      fieldbyname('accout').asstring := oldvalue
    else
      SetBreakField(oldvalue);
end;

procedure TVrfyDlg.ResetFieldFlags;
begin
  ainflag := false;
  aoutflag := false;
  brkflag := false;
end;

procedure TVrfyDlg.VrfySchdBeforePost(DataSet: TDataSet);
var
  AccIn, AccOut, NewBreak: String;
  ShiftDuration : TDateTime;
  InDateTime, OutDateTime : TDateTime;
begin
  delflag := false;
  if vrfyschd.state = dsInsert then
    exit;

  with vrfyschd do
  begin
    if (fieldbyname('confirmed').asstring = 'Y') and ((ainflag) or
      (aoutflag) or (brkflag)) then
    begin
      showmessage('This shift is confirmed so changes are not allowed.' + #13 +
        'To edit this record uncheck the "Confirmed" box.');
      delflag := true;

      RevertFieldToOldValue;
      ResetFieldFlags;
      exit;
    end;

    if (ainflag) or (aoutflag) or (brkflag) then
    begin
      if (FieldByName('accin').AsString = '') or
         (FieldByName('accout').AsString = '') then
      begin
        AccIn := '00:00';
        AccOut := '00:00';
      end else begin
        AccIn := FieldByName('accin').AsString;
        AccOut := FieldByName('accout').AsString;
      end;

      if FieldByName('break').AsString = '' then
        SetBreakField('00:00');

      //If shift times have been changed then we must recalculate the total break time as the
      //new shift may no longer include some of the breaks.
      if (ainflag) or (aoutflag) then
      begin
        GetInAndOutTimesFromStrings(AccIn, AccOut, InDateTime, OutDateTime);
        NewBreak := EmployeeBreaksForm.TotalBreakTimeForShift(FieldByName('UserId').Value, InDateTime, OutDateTime);

        if NewBreak <> FieldByName('break').asstring then
        begin
          if MessageDlg('The breaks which lie within this shift have now changed.' + #13#10 +
                        'The break time will thus change from ' + FieldByName('break').AsString + ' to ' + NewBreak + '.'+
                         #13#10#13#10 + 'Proceed with your change ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
          begin
            SetBreakField(NewBreak);
          end else begin
            RevertFieldToOldValue;
            ResetFieldFlags;
            exit;
          end;
        end;
      end; //if (ainflag) or (aoutflag)

      if AccIn < AccOut then
        ShiftDuration := strtotime(AccOut) - strtotime(AccIn)
      else
        ShiftDuration := (strtotime(AccOut) + 1.0) - strtotime(AccIn);

      if dMod1.TimeToMins(strtotime(fieldbyname('break').asstring)) > dMod1.TimeToMins(ShiftDuration) then
      begin
        showmessage('Break length cannot be greater than shift length');
        RevertFieldToOldValue;
        ResetFieldFlags;

        errflag := true;
        exit;
      end;

      if fempmnu.paidflag then
        fieldbyname('worked').asstring := timetostr(ShiftDuration)
      else
        fieldbyname('worked').asstring := timetostr(ShiftDuration - strtotime(fieldbyname('break').asstring));

      ResetFieldFlags;
    end; // if flags...
  end; // with
end;


procedure TVrfyDlg.VrfySchdBeforeEdit(DataSet: TDataSet);
begin
  if vrfydlg.dbgrid2.fieldname(vrfydlg.dbgrid2.getactivecol) = 'AccIn' then
  begin
    ainflag := true;
    oldvalue := vrfyschd.fieldbyname(dbgrid2.fieldname
      (dbgrid2.getactivecol)).asstring;
  end
  else if dbgrid2.fieldname(vrfydlg.dbgrid2.getactivecol) = 'AccOut'
    then
  begin
    aoutflag := true;
    oldvalue := vrfyschd.fieldbyname(dbgrid2.fieldname
      (dbgrid2.getactivecol)).asstring;
  end
  else if dbgrid2.fieldname(dbgrid2.getactivecol) = 'Break'
    then
  begin
    brkflag := true;
    oldvalue := vrfyschd.fieldbyname(dbgrid2.fieldname
      (dbgrid2.getactivecol)).asstring;
  end;
end;

procedure TVrfyDlg.VrfySchdAfterScroll(DataSet: TDataSet);
begin
  btnDelete.Enabled := fempmnu.allowShiftDeletion or (VrfySchd.FieldByName('ClockIn').AsString = '');
  BitBtn7.Enabled := btnDelete.Enabled;

  if nocalcs then
    exit;

  UpdateExtraPaymentButtonText;

  UpdateRateChangePanel;
end;

procedure TVrfyDlg.VrfySchdConfirmedChange(Sender: TField);
begin
  if not checkfields then
    exit;

  with vrfyschd do
  begin
    if fieldbyname('confirmed').value = 'N' then
      exit;

    if ((fieldbyname('accin').asstring <> '') and //  shift
      (fieldbyname('accout').asstring <> '') and //  has
      (fieldbyname('accin').asstring <> //  accepted times
      fieldbyname('accout').asstring)) and
      not ((fieldbyname('WRoleId').asstring <> '') and
            // but not valid worked job
           (fieldbyname('WRoleId').asinteger <> 0) and
           (fieldbyname('WRoleId').AsInteger <> NULL_JOB_CODE)) then //
    begin
      showmessage('This shift is Accepted but does not have a Worked Job!' + #13
        +
        'Either delete the accepted times (accept it as NOT WORKED) or give' +
        ' it a valid worked job before confirming');
      edit;
      fieldbyname('confirmed').value := 'N';
      post;
      exit;
    end;

    if not ((fieldbyname('accin').asstring <> '') and
      (fieldbyname('accout').asstring <> '') and
      (fieldbyname('WRoleId').asstring <> '') and
        (fieldbyname('WRoleId').asinteger <> 0) and
      (fieldbyname('accin').asstring <>
      fieldbyname('accout').asstring)) then
    begin
      if MessageDlg('This shift does not have Accepted Times and/or Worked Job!'
        + #13 +
        'Do you want to confirm the shift as it is (accept it as NOT WORKED)?',
        mtWarning, [mbYes, mbNo], 0) = mrNO then
      begin
        edit;
        fieldbyname('confirmed').value := 'N';
        post;
        //refresh;
        dbgrid2.refresh;
      end
      else
      begin
        post;
        //refresh;
        dbgrid2.refresh;
      end;
    end;
  end;
end;

procedure TVrfyDlg.btnLSPayClick(Sender: TObject);
var
  WorkedStdRate: double;
begin
  WorkedStdRate := -1;

  //Belt and braces check - should never occur, but lets show the user a sensible
  //message before we go any further.
  if VarIsNull(Vrfyschd.FieldByName('WRoleId').Value)
  or VarIsNull(Vrfyschd.FieldByName('WorkedPaySchemeVersionId').Value) then
  begin
    MessageDlg('Enter the worked job for the shift before attempting to add an additional payment.',
               mtError,
               [mbOK],
               0);
    Exit;
  end;

  fLSPay := TfLSPay.Create(nil);
  //Application.CreateForm(tfLSPay,fLSPay);
  with flspay.qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select sum(a."value") as totval from addpay a');
    sql.Add('where a."sitecode" = ' + inttostr(vSiteCode));
    sql.Add('and a."wstart" = ' + quotedstr(formatDateTime('mm/dd/yyyy', selWeekSt)));
    sql.Add('and a."sec" = ' + Vrfyschd.FieldByName('UserId').AsString);
    sql.Add('and a.Deleted is NULL');
  end;

  flspay.Caption := 'Extra Payments for ' +
    Vrfyschd.fieldbyname('fname').asstring + ' ' +
    Vrfyschd.fieldbyname('name').asstring;

  with dmado.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select sprob.PayRate');
    SQL.Add('from ac_ShiftPayRateOverrideBand sprob');
    SQL.Add('where sprob.SiteId = ' + inttostr(vSiteCode));
    SQL.Add('and sprob.UserId = ' + Vrfyschd.FieldbyName('UserId').AsString);
    SQL.Add('and sprob.Schin = ''' + formatdatetime('yyyy-mm-dd hh:mm:nn',VrfySchd.FieldbyName('KSchin').AsDatetime) +'''');
    SQL.Add('and sprob.PaySchemeBandTypeId = 1');
    Open;

    if not VarisNull(FieldByName('PayRate').Value) then
      //Use the shift override value if it exists..
      WorkedStdRate := FieldByName('PayRate').Value
    else if not VarisNull(Vrfyschd.FieldByName('WorkedUserPayRateOverrideVersionId').Value) then
    begin
      //...othrewise use the user site override if it exists...
      Close;
      SQL.Clear;
      SQL.Add('select uprob.PayRate');
      SQL.Add('from ac_UserPayRateOverrideBand uprob');
      SQL.Add('where uprob.UserPayRateOverrideVersionId = ' + Vrfyschd.FieldByName('WorkedUserPayRateOverrideVersionId').AsString);
      SQL.Add('and uprob.SiteId = ' + inttostr(vSiteCode));
      SQL.Add('and uprob.PaySchemeBandTypeId = 1'); //The std pay rate
      Open;

      WorkedStdRate := FieldByName('PayRate').Value;
    end
    else if not VarIsNull(Vrfyschd.FieldByName('WorkedPaySchemeVersionId').Value) then
    begin
      //...otherwise use the normal pay scheme version rate
      Close;
      SQL.Clear;
      SQL.Add('select psb.PayRate');
      SQL.Add('from ac_PaySchemeBand psb');
      SQL.Add('where psb.PaySchemeVersionID = ' + Vrfyschd.FieldByName('WorkedPaySchemeVersionId').AsString);
      SQL.Add('and psb.PaySchemeBandTypeId = 1'); //The std pay rate
      Open;

      WorkedStdRate := FieldByName('PayRate').Value;
    end;
  end;

  if (WorkedStdRate = -1) then
  begin
    MessageDlg('Unable to establish either the standard rate daily hours or ' +
               'the applicable standard pay rate.  Unable to add an aditional payment.',
               mtError,
               [mbOK],
               0);
    Exit;
  end;

  case Vrfyschd.fieldbyname('WorkedPayFrequencyId').asinteger of
    // later change/add to this clause
    // to reflect what paytypes can be paid by days
    1: //Hourly 
      begin
        fLSPay.rbDays.Enabled := FALSE;
        fLSPay.rbHours.Enabled := TRUE;
        fLSPay.hourValue := WorkedStdRate;
      end;
    2: //Daily
      begin
        fLSPay.rbDays.Enabled := TRUE;
        fLSPay.rbHours.Enabled := FALSE;
        fLSPay.dayValue := WorkedStdRate;
      end;
    {PW: Job 14553: "Bonus by day's pay" payments not added for Weekly
     Apportioned, Weekly non-apportioned, monthly and 4-weekly payment types.
     It is quite easy for the user to calculate this.}
  else
    fLSPay.rbDays.Enabled := FALSE;
    fLSPay.rbHours.Enabled := FALSE;
  end; // case..

  //job 17306 delete is null changed to deleted = Null
  flspay.wwTable1.filter := '(sitecode = ' + inttostr(vSiteCode) +
    ') AND (wstart = ' + #39 +
    formatDateTime('ddddd', selWeekSt) + #39 + ') AND (SEC = ' +
    Vrfyschd.FieldByName('UserId').AsString + ') AND (Deleted = NULL)';

  flspay.thecurruser := CurrentUser.UserName;
  flspay.UserId := Vrfyschd.FieldByName('UserId').Value;
  flspay.wstart := selWeekSt;
  flspay.site := vSiteCode;

  flspay.ShowModal;

  flspay.release;

  UpdateExtraPaymentButtonText;
end;

procedure TVrfyDlg.BitBtn5Click(Sender: TObject);
begin
  //16322
  if VrfySchd.RecordCount > 0 then
  begin
    //15094
    VrfySchd.edit;
    VrfySchd.post;
  end;
  //VrfySchd.Refresh;

  VrfySchd.Filtered := False;

  pnlFilterView.Visible := False;

  DBGrid2.ReadOnly := ReviewFlag or (VrfySchd.RecordCount = 0);
end;

procedure TVrfyDlg.VrfySchdAfterDelete(DataSet: TDataSet);
begin
  if dataset.RecordCount = 0 then
  begin
    bitbtn2.visible := false;
    btnLSPay.visible := false;
    btnDelete.visible := false;
    dbgrid2.readonly := true;
  end;
  BitBtn7.Visible := btnDelete.Visible; // job 14572
  btnDelete.Enabled := fempmnu.allowShiftDeletion or (VrfySchd.FieldByName('ClockIn').AsString = '');
  BitBtn7.Enabled := btnDelete.Enabled;
end;

procedure TVrfyDlg.BitBtn6Click(Sender: TObject);
begin
  with vrfySchd do
  begin
    Filter := 'Confirmed = ' + #39 + 'N' + #39;
    Filtered := True;
    //Refresh;
    pnlFilterView.Visible := True;

    if recordcount = 0 then
    begin
      dbgrid2.readonly := true;
    end;
  end;
end;

procedure TVrfyDlg.VrfySchdAfterPost(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
  begin
    if not reviewFlag then
    begin
      bitbtn2.visible := true;
      btnDelete.visible := true;
      btnLSPay.visible := true;
      dbgrid2.readonly := false;
    end;
  end
  else
  begin
    bitbtn2.visible := false;
    btnLSPay.visible := false;
    btnDelete.visible := false;
    dbgrid2.readonly := true;
  end;
  BitBtn7.Visible := btnDelete.Visible; // job 14572
  btnDelete.Enabled := fempmnu.allowShiftDeletion or (VrfySchd.FieldByName('ClockIn').AsString = '');
  BitBtn7.Enabled := btnDelete.Enabled;
end;

procedure TVrfyDlg.VerifyPCMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (button = mbright) and (ssalt in shift) and (ssshift in shift) then
    if ccDebug then
      ccDebug := False
    else
      ccDebug := True;
end;

procedure TVrfyDlg.VrfySchdAfterOpen(DataSet: TDataSet);
begin
  adoqJobs.open;
end;

procedure TVrfyDlg.VrfySchdBeforeClose(DataSet: TDataSet);
begin
  adoqJobs.close;
end;

procedure TVrfyDlg.DBGrid2TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  if AFieldName = 'Name' then
  begin
    VrfySchd.IndexFieldNames := 'Name;Fname';
  end
  else if AFieldName = 'Fname' then
  begin
    VrfySchd.IndexFieldNames := 'Fname;Name';
  end;
end;

procedure TVrfyDlg.InsertScheduleRecord(var Ins: SmallInt; out success: boolean);
var
  InDate: TDateTime;
  SQLString1, SQLString2: string;
begin
  success := True;

  with VrfySchd do
  begin
    if FieldByName('Visible').AsString = 'Y' then  // Only if not deleted.
    begin
      // but what if there was a record with the same schin that was deleted (and is
      // thus NOT in verifyschdle)? Then find it and kill it so as not to get
      // key violations...
      qryRun.Close;
      qryRun.SQL.Clear;
      qryRun.SQL.Add('delete from Schedule');
      qryRun.SQL.Add('where SiteCode = ' + inttostr(vSiteCode));
      qryRun.SQL.Add('and UserId = ' + FieldByName('UserId').AsString);
      qryRun.SQL.Add('and SchIn = ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
        FieldByName('kSchIn').AsDateTime) + '''');
      qryRun.ExecSQL;

      // assumes kschin already set properly...
      qryRun.Close;
      qryRun.SQL.Clear;
      SQLString1 := 'insert Schedule(UserId, SiteCode, SchIn, BsDate, SchOut, AccIn,' +
        ' AccOut, RoleId, WRoleId, [Break], Worked, Shift, Confirmed, Visible,' +
        ' WorkedPaySchemeVersionId, WorkedUserPayRateOverrideVersionId, ErrCode';
      SQLString2 := 'values(' +FieldByName('UserId').AsString +
        ',' + inttostr(vSiteCode) + ',''' +
        formatDateTime('mm/dd/yyyy hh:nn:ss', FieldByName('kschin').AsDateTime) +
        ''', ''' +
        formatDateTime('mm/dd/yyyy hh:nn:ss', Today) + '''';

      if fieldbyname('schin').asstring > fieldbyname('schout').asstring then
      begin
        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          trunc(fieldbyname('kschin').asdatetime) + 1 +
          strtotime(fieldbyname('schout').asstring)) + '''';
      end
      else
      begin
        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          trunc(fieldbyname('kschin').asdatetime) +
          strtotime(fieldbyname('schout').asstring)) + '''';
      end;

      // no clockin-clockout as this shift was just added...

      if (fieldbyname('accin').asstring <> '') and
        (fieldbyname('accout').asstring <> '') then
      begin
        if fieldbyname('accin').asstring < fempmnu.grace then
          indate := today + 1.0
        else
          indate := today;

        SQLString2 := SQLString2 + ',''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          indate + strtotime(fieldbyname('accin').asstring)) + '''';

        if fieldbyname('accin').asstring > fieldbyname('accout').asstring then
          indate := indate + 1.0;

        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          indate + strtotime(fieldbyname('accout').asstring)) + '''';
      end
      else
        SQLString2 := SQLString2 + ', NULL, NULL';

      SQLString2 := SQLString2 + ',' + inttostr(fieldbyname('RoleId').asinteger) +
        ',' + inttostr(fieldbyname('WRoleId').asinteger) + ',''' +
        formatDateTime('hh:nn:ss', strtotime(fieldbyname('break').asstring)) +
        '''';

      if fempmnu.paidflag then
        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          strtotime(fieldbyname('worked').asstring) - strtotime(fieldbyname('break').asstring)) +
          ''''
      else
        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
          strtotime(fieldbyname('worked').asstring)) + '''';

      SQLString2 := SQLString2 + ',' + inttostr(fieldbyname('shift').asinteger) +
        ',' + QuotedStr(fieldbyname('confirmed').asstring) + ',' +
        QuotedSTr(fieldbyname('visible').asstring) + ',' +
        IntToStr(fieldbyname('WorkedPaySchemeVersionId').asInteger) + ',';
      if not VarIsNull(fieldbyname('WorkedUserPayRateOverrideVersionId').Value) then
        SQLString2 := SQLString2 + IntToStr(fieldbyname('WorkedUserPayRateOverrideVersionId').asInteger) + ','
      else
        SQLString2 := SQLString2 + 'null,';

      SQLString2 := SQLString2 + '-1';

      if FieldByName('RateMod2').AsString = 'Y' then
      begin
        SQLString1 := SQLString1 + ', PaySchemeVersionLMDT, PaySchemeVersionLMBy';
        SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', Now) +
          ''', ' + QuotedStr(CurrentUser.UserName);
      end;

      SQLString1 := SQLString1 + ', LMDT)';
      SQLString2 := SQLString2 + ', ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', Now) + ''')';

      try
        qryRun.SQL.Add(SQLString1);
        qryRun.SQL.Add(SQLString2);
        qryRun.ExecSQL;
        // log the action..
        inc(ins);
        fempmnu.loglist.items.clear;
        with fempmnu.loglist.items do
        begin
          add('record ADDED from VrfySchd to Schedule --> ' +
            fieldbyname('UserId').AsString +
            ', ' + FieldByName('kschin').asstring + '; ' +
              FieldByName('clockin').asstring +
            '-' + FieldByName('clockout').asstring);
        end;
        fempmnu.LogInfo;
        // end of logging..
      except
        on E:exception do
        begin
          success := False;

          // log the action..
          fempmnu.loglist.items.clear;
          with fempmnu.loglist.items do
          begin
            add('ERROR adding record to Schedule --> ' +
              fieldbyname('UserId').AsString +
              ', ' + FieldByName('kschin').asstring + '; ' +
              FieldByName('clockin').asstring +
              '-' + FieldByName('clockout').asstring);
            add('Error Msg: ' + E.message);
          end;
          fempmnu.LogInfo;
          // end of logging..
        end;
      end;
    end; // if new record was visible
  end;
end;

procedure TVrfyDlg.EditScheduleRecord(var Ed, Del: SmallInt; out success: boolean);
var
  InDate: TDateTime;
begin
  success := True;

  with VrfySchd do
  begin
    qryRun.Close;
    qryRun.SQL.Clear;
    qryRun.SQL.Add('update Schedule');

    if fieldbyname('Visible').asstring = 'N' then
      qryRun.SQL.Add('set Visible = ''N''')
    else
    begin
      if (fieldbyname('accin').asstring <> '') and
        (fieldbyname('accout').asstring <> '') then
      begin
        if fieldbyname('accin').asstring < fempmnu.grace then
          indate := today + 1.0
        else
          indate := today;

        qryRun.SQL.Add('set accin = ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', indate +
          strtotime(fieldbyname('accin').asstring)) + '''');
        if fieldbyname('accin').asstring > fieldbyname('accout').asstring then
          indate := indate + 1.0;

        qryRun.SQL.Add(', accout = '''+ formatDateTime('mm/dd/yyyy hh:nn:ss', indate +
          strtotime(fieldbyname('accout').asstring)) + '''');
      end
      else  // accin = '' so user wanted not to have accin/out anymore
      begin // save this thing...
        qryRun.SQL.Add('set accin = NULL');
        qryRun.SQL.Add(', accout = NULL');
      end;

      if fieldbyname('WRoleId').IsNull then
        qryRun.SQL.Add(', WRoleId = NULL')
      else
        qryRun.SQL.Add(', WRoleId = ' + fieldbyname('WRoleId').asstring);
      qryRun.SQL.Add(', [break] = ''' + formatDateTime('hh:nn:ss', strtotime(fieldbyname('break').asstring)) + '''');

      if fempmnu.paidflag then
        qryRun.SQL.Add(', worked = ''' + formatDateTime('hh:nn:ss',
          strtotime(fieldbyname('worked').asstring) -
          strtotime(fieldbyname('break').asstring)) + '''')
      else
        qryRun.SQL.Add(', worked = ''' + formatDateTime('hh:nn:ss',
          strtotime(fieldbyname('worked').asstring)) + '''');

      qryRun.SQL.Add(', confirmed = ' + QuotedStr(fieldbyname('confirmed').asstring));

      if not VarIsNull(fieldbyname('WorkedPaySchemeVersionId').Value) then
        qryRun.SQL.Add(', WorkedPaySchemeVersionId = ' + IntToStr(fieldbyname('WorkedPaySchemeVersionId').Asinteger))
      else
        qryRun.SQL.Add(', WorkedPaySchemeVersionId = NULL');
      if not VarIsNull(fieldbyname('WorkedUserPayRateOverrideVersionID').Value) then
        qryRun.SQL.Add(', WorkedUserPayRateOverrideVersionID = ' + InttoStr(fieldbyname('WorkedUserPayRateOverrideVersionID').AsInteger))
      else
        qryRun.SQL.Add(', WorkedUserPayRateOverrideVersionID = NULL');

      qryRun.SQL.Add(', shift = ' + inttostr(fieldbyname('shift').asinteger));

      if FieldByName('ratemod2').asstring = 'Y' then
      begin
        qryRun.SQL.Add(', PaySchemeVersionLMDT = ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', Now) +
          '''');
        qryRun.SQL.Add(', PaySchemeVersionLMBy = ' + QuotedStr(CurrentUser.UserName));
      end;
    end;

    qryRun.SQL.Add(', LMDT = ''' + formatDateTime('mm/dd/yyyy hh:nn:ss', Now) + '''');

    qryRun.SQL.Add('where SiteCode = ' + inttostr(vSiteCode));
    qryRun.SQL.Add('and UserId = ' + fieldbyname('UserId').AsString);
    qryRun.SQL.Add('and SchIn = ''' + formatDateTime('mm/dd/yyyy hh:nn:ss',
      FieldByName('kSchIn').AsDateTime) + '''');

    try
      if qryRun.ExecSQL = 0 then
      begin
        // could not locate!!!
        fempmnu.loglist.items.clear;
        with fempmnu.loglist.items do
        begin
          add('ERROR: Not Located in Schedule (edit from VrfySchd) --> '
            +
            fieldbyname('UserId').AsString +
            '; ' + FieldByName('kschin').asstring + '; ' +
            FieldByName('clockin').asstring +
            '-' + FieldByName('clockout').asstring);
        end;
        fempmnu.LogInfo;
        // end of logging..
      end
      else
      begin
        if fieldbyname('visible').asstring = 'N' then
          inc(del)
        else
          inc(ed);
      end;
    except
      on E: exception do
      begin
        success := False;

        // log the action..
        fempmnu.loglist.items.clear;
        with fempmnu.loglist.items do
        begin
          add('ERROR: Writing from VrfySchd to Schedule (edit) --> '
            +
            fieldbyname('UserId').AsString +
            '; ' + FieldByName('kschin').asstring + '; ' +
            FieldByName('clockin').asstring +
            '-' + FieldByName('clockout').asstring);
          add('Error Msg: ' + E.message);
        end;
        fempmnu.LogInfo;
        // end of logging..
      end; // on exception do...
    end; // try.. except}
  end;
end;

//Takes the clockin/out times as strings in the format hh:mm and returns the
//datetimes of these.
//ToDo: Refactor. Use this proc throughout this unit.
procedure TVrfyDlg.GetInAndOutTimesFromStrings(InTime, OutTime : string;
                                      var InDateTime, OutDateTime : TdateTime);
begin
  if InTime < fempmnu.grace then
    InDateTime := today + 1.0 + strtotime(InTime)
  else
    InDateTime := today + strtotime(InTime);

  if OutTime < InTime then
    outdatetime := DateOf(InDateTime) + 1 + strtotime(OutTime)
  else
    outdatetime := DateOf(InDateTime) + strtotime(OutTime);
end;

//If the Break field is the active field launch the break editing form.
procedure TVrfyDlg.DBGrid2DblClick(Sender: TObject);
var InDateTime, OutDateTime : TDateTime;
begin
  if not(ShowBreakEditForm and (UpperCase(DBGrid2.SelectedField.FieldName) = 'BREAK')) then
    Exit;

  with VrfySchd do
  begin
    if (FieldByName('AccIn').AsString = '') or (FieldByName('AccOut').AsString = '') then
    begin
      ShowMessage('Acc.In and Acc.Out times must be set before Break can be edited');
      Exit;
    end;

    GetInAndOutTimesFromStrings(FieldByName('AccIn').asstring,
                                FieldByName('AccOut').asstring,
                                InDateTime, OutDateTime);

    if FieldByName('Confirmed').AsString = 'Y' then
    begin
      EmployeeBreaksForm.ShowBreaks(FieldByName('UserId').Value,
                                    FieldByName('FName').AsString + ' ' + FieldByName('Name').AsString,
                                    InDateTime, OutDateTime);
    end else begin
      if EmployeeBreaksForm.EditBreaks(FieldByName('UserId').Value,
                                    FieldByName('Fname').AsString + ' ' + FieldByName('Name').AsString,
                                    InDateTime, OutDateTime) = mrOK then
      begin
        Edit;
        SetBreakField(EmployeeBreaksForm.TotalBreakTime);
        Post;
      end;
    end;

  end;
end;

//Assign a value to the Break field coping with the fact that it may be read-only.
procedure TVrfyDlg.SetBreakField(newValue : string);
var IsReadOnly : boolean;
begin
  with VrfySchd do
  begin
    IsReadOnly := FieldByName('Break').ReadOnly;
    if IsReadOnly then FieldByName('Break').ReadOnly := false;

    FieldByName('Break').AsString := newValue;

    if IsReadOnly then FieldByName('Break').ReadOnly := true;
  end;
end;

procedure TVrfyDlg.FormDestroy(Sender: TObject);
begin
  EmployeeBreaksForm.Free;
end;

procedure TVrfyDlg.AutoAcceptShiftsFromScheduleTimes;
begin
  with qryRun do
  begin
    close;
    SQL.clear;
    SQL.Add('UPDATE #vrfyschd');
    SQL.Add('SET accin = s.schin, accout = s.schout, WRoleId = s.RoleId,');
    sql.Add('WorkedPaySchemeVersionId = ps.CurrentPaySchemeVersionId,');
    sql.Add('worked = CONVERT(varchar (5), (CAST(s.schout AS datetime) - CAST(s.schin AS datetime)), 8)');
    SQL.Add('FROM #vrfyschd s');
    SQL.Add('JOIN ac_UserRoles ur');
    SQL.Add('ON s.RoleId = ur.RoleId and s.UserId = ur.UserId');
    SQL.Add(' JOIN ac_Role r');
    SQL.Add(' ON r.Id = ur.RoleId');
    SQL.Add('   JOIN ac_PayScheme ps');
    SQL.Add('   ON ps.Id = ur.PaySchemeId');
    SQL.Add('WHERE s.RoleId <> ' + inttostr(NULL_JOB_CODE));
    SQL.Add('AND s.WRoleId is null');
    SQL.Add('AND (s.accin IS NULL or LEN(s.accin) = 0)');
    SQL.Add('AND (s.accout IS NULL or LEN(s.accout) = 0)');
    SQL.Add('AND ps.AcceptedTimesSourceId = ' + IntToStr(Ord(sptScheduled)));
    SQL.Add('AND r.AutoAcceptScheduledTimes = 1');
    SQL.Add('AND s.BsDate = ''' + FormatDateTime('yyyy-mm-dd hh:nn:ss',today)+'''');
    ExecSQL;
  end;
  vrfyschd.Requery;
end;

procedure TVrfyDlg.UpdateExtraPaymentButtonText;
begin
  if not VarisNull(Vrfyschd.FieldByName('UserId').Value) then
  begin
    with qryRun do
    begin
      close;
      sql.Clear;
      sql.Add('select sum(a."value") as totval from "addpay" a');
      sql.Add('where a."sitecode" = ' + inttostr(vSiteCode));
      sql.Add('and a."wstart" = ' + QuotedStr(formatDateTime('mm/dd/yyyy', selWeekSt)));
      sql.Add('and a."sec" = ' + Vrfyschd.FieldByName('UserId').AsString);
      sql.Add('and a.Deleted is NULL');
      open;

      if FieldByName('totval').asfloat = 0 then
      begin
        btnLSPay.Caption := 'Add Extra Payment';
        btnlspay.Font.Style := [];
        btnlspay.Hint := 'There is no Extra Payment ' + #13 +
          'for this Employee for this week.';
      end
      else
      begin
        btnLSPay.Caption := 'Add/Edit Extra Payment';
        btnlspay.Font.Style := [fsBold];
        btnlspay.Hint := 'Value of Extra Payment(s) for ' + #13 +
          'this Employee for this week: ' +
          formatfloat(currencystring + '0.00', FieldByName('totval').asfloat);
      end;
      close;
    end;
  end;
end;

procedure TVrfyDlg.UpdateRateChangePanel;
begin
  if fempmnu.ratechg then
  begin
    lblPayType.Color := clWhite;
    lblPayType.Font.Color := clBlack;
    lblPayType.Caption := paytypes.Values[VrfySchd.FieldByName('WorkedPayFrequencyId').asstring];

    if VrfySchd.FieldByName('WorkedPayFrequencyId').asinteger = 1 then
      // Hourly paid *can* modify shift pay rates
      bbtRateChg.Enabled := True
    else if VrfySchd.FieldByName('WorkedPayFrequencyId').asinteger in [2,3,4,5,6,7,8,9] then
      //Other pay frequencies *cannot* modify shift pay rates
      bbtRateChg.Enabled := False
    else begin
      if (VrfySchd.FieldByName('clockin').asstring = '') and
        (VrfySchd.FieldByName('clockout').asstring = '') then
      begin
        lblPayType.Caption :=
          'Shift not worked, no pay rate/type info';
        lblPayType.Color := clBlue;
        lblPayType.Font.Color := clWhite;
      end
      else
      begin
        lblPayType.Caption := 'INVALID PAY TYPE!!!';
        lblPayType.Color := clRed;
        lblPayType.Font.Color := clWhite;
      end;

      bbtRateChg.Enabled := False;
    end; // case..
    if VrfySchd.FieldByName('confirmed').asstring = 'Y' then
      bbtRateChg.Enabled := False;
  end;
end;

procedure TVrfyDlg.VrfySchdBeforeScroll(DataSet: TDataSet);
begin
  if combo1.Grid.Visible then
    Combo1.CloseUp(Combo1.Modified);
end;

end.

