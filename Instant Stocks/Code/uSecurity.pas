unit uSecurity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Wwdbigrd,
  Wwdbgrid, DB, Wwdatsrc, ADODB, Math, ppPrnabl, ppClass, ppCtrls, ppBands,
  ppDB, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, uGlobals;

type
  TfSecurity = class(TForm)
    adoqHO: TADOQuery;
    dsHO: TwwDataSource;
    adoqSgen: TADOQuery;
    dsSgen: TwwDataSource;
    adoqScurr: TADOQuery;
    dsScurr: TwwDataSource;
    adoqSacc: TADOQuery;
    dsSacc: TwwDataSource;
    adoqSrep: TADOQuery;
    dsSrep: TwwDataSource;
    adoqJobTypes: TADOQuery;
    dsJobTypes: TwwDataSource;
    tabsJobs: TTabControl;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    tabsTids: TTabControl;
    panelHO: TPanel;
    Label1: TLabel;
    gridHO: TwwDBGrid;
    Label7: TLabel;
    Label14: TLabel;
    Label10: TLabel;
    pnlProgMap: TScrollBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    gridSgen: TwwDBGrid;
    gridScurr: TwwDBGrid;
    gridSacc: TwwDBGrid;
    gridSrep: TwwDBGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    adoqRep: TADOQuery;
    wwDataSource1: TwwDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppRep: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppSummaryBand1: TppSummaryBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel1: TppLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabsJobsChange(Sender: TObject);
    procedure tabsTidsChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure gridFieldChanged(Sender: TObject; Field: TField);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label7DblClick(Sender: TObject);
    procedure gridHOExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    theH : integer;
    procedure SetGrid(theGrid: TwwDBGrid; theThread: integer);
    procedure FormSettings;
    procedure SynchTabs;
  public
    { Public declarations }
    theTids : TStringList;
    showThread : integer;
    curTName, curDiv, curJobType : string;
    curTid : integer;
    okToShow : boolean;
  end;

var
  fSecurity: TfSecurity;

implementation

uses uADO, uConfTh, udata1, ulog, uSecCopy;

{$R *.dfm}

//,
//    ('N') as [set2], ('N') as [set3], ('N') as [set4], ('N') as [set5]
//into stkSecView
//from stkSecperms a, stkpzjob z
//



procedure TfSecurity.FormCreate(Sender: TObject);
var
  s1 : string;
begin

  theTids := TStringList.Create;
  okToShow := False;

  dmADO.DelSQLTable('stkPzJob');
  dmADO.DelSQLTable('stkSecView');

  with dmADO.adoqRun do
  begin
    // get job types and make up tabs for them
    tabsJobs.Tabs.Clear;

    close;
    sql.Clear;
    sql.Add('select ID as RoleID, name as jobtype into dbo.stkPzJob from ac_role');
    sql.Add('where ID not ' +uGlobals.CurrentUser.Roles.AsSQLCheck); // cannot set your own rights!!!
    sql.Add('and RoleTypeID = 0');
    sql.Add('and Deleted = 0');
    execSQL;

    close;
    sql.Clear;
    sql.Add('select jobtype from stkPzJob');
    sql.Add('order by jobtype');
    open;

    if recordcount = 0 then
    begin
      if uGlobals.CurrentUser.Roles.Count = 0 then
        s1 := 'No valid Role is available at this time. '
      else
        s1 := 'Your Role ( ' + uGlobals.CurrentUser.Roles[0].Name + ' ) is the only one available. ';

      log.event('Only one Role present! User was refused permission to the Security dialog.');
      showMessage('You cannot set Stocks Security Permissions for your own Role!' + #13 + #13 +
        s1 + #13 + 'Until another Role is added to the system the Security dialog will not be accessible.');

    end
    else
    begin
      while not eof do
      begin
        tabsJobs.Tabs.Append(FieldByName('jobtype').asstring);
        next;
      end;
      okToShow := True;
    end;

  end;
end;

procedure TfSecurity.FormSettings;
var
  p1 : integer;
begin
  curJobType := adoqJobTypes.FieldByName('jobtype').AsString; //tabsJobs.tabs[tabsJobs.tabindex];

  if tabsTids.Visible then
  begin
    if showThread = -1 then
    begin
      curTName := tabsTids.tabs[tabsTids.tabindex]; // if there's a squiggle this is not ALL THREADS
      if curTName = 'ALL THREADS' then
      begin
        curTid := -1;
        label10.Caption := 'Role: ' + curJobType + #13 + 'Showing ALL THREADS';
        //bitbtn11.Visible := False;
      end
      else
      begin
        p1 := pos('~ ', curTName);
        label10.Caption := 'Role: ' + curJobType + #13 + 'Division: ' +
          copy(curTName, 1, p1) + ' Thread: ' + copy(curTName, p1 + 2, length(curTName));
        curTid := strtoint(thetids.values[curTName]);
        //bitbtn11.Visible := True;
      end;
    end
    else
    begin // single thread mode, no tabsTids values to look at...
      label10.Caption := 'Role: ' + curJobType + #13 + 'Division: ' +
          curDiv + ' ~ Thread: ' + curTName;
    end;
  end
  else
  begin
    // ...
  end;
end; // procedure..


procedure TfSecurity.SetGrid(theGrid: TwwDBGrid; theThread: integer);
var
  i : integer;
  s1 : string;
begin
  with theGrid, theGrid.DataSource.DataSet do   // grid field names, etc...
  begin
    open;
    DisableControls;

    Selected.Clear;
    Selected.Add('smalltext' + #9 + '40' + #9 + 'Security Permission');

    if theThread = -1 then // all threads
    begin
      for i := 0 to pred(theTids.Count) do
      begin
        s1 := thetids.values[thetids.names[i]];
        Selected.Add(s1 + #9 + '1' + #9 + ' ' + thetids.names[i] + ' ');
        SetControlType(s1, fctCheckBox, 'Y;N');
      end; // for..
      Selected.Add('0' + #9 + '1' + #9 + ' ALL THREADS ');
      SetControlType('0', fctCheckBox, 'Y;N');

    end
    else  // one thread...
    begin
      s1 := inttostr(theThread);
      Selected.Add(s1 + #9 + '1' + #9 + ' Granted ');
      SetControlType(s1, fctCheckBox, 'Y;N');
    end;

    ApplySelected;
    Invalidate;
    EnableControls;
  end;

end; // procedure..


procedure TfSecurity.FormShow(Sender: TObject);
var
  s1 : string;
  i, totH : integer;
begin
  // create level stuff

  with dmADO.adoqRun do
  begin
    // get the threads and make up tabs for them...
    // ALSO create the table stkSecView to hold the settings by jobType/Thread...
    tabsTids.Tabs.Clear;

    close;
    sql.Clear;
    sql.Add('select tid, division, tname from threads order by Division, tname');
    open;

    // start the query that makes up stkSecView
    dmADO.adoqRun2.close;
    dmADO.adoqRun2.sql.Clear;
    dmADO.adoqRun2.sql.Add('select z.RoleID, z.jobtype, a.permid, a.parent, null as topLevelPerm, a.smalltext');

    while not eof do
    begin
      // make up the Name=Value for the theTids list
      s1 := FieldByName('division').AsString + ' ~ ' + FieldByName('tname').asstring +
            '=' + FieldByName('tid').AsString;

      theTids.Append(s1);
      tabsTids.Tabs.Append(FieldByName('division').AsString + ' ~ ' + FieldByName('tname').asstring);

      dmADO.adoqRun2.sql.Add(', (''N'') as [' + FieldByName('tid').AsString + ']');

      next;
    end;

    // complete the query that makes up stkSecView
    tabsTids.Tabs.Append('ALL THREADS');
    dmADO.adoqRun2.sql.Add(', (''N'') as [0]');    // HO settings OR all threads...
    dmADO.adoqRun2.sql.Add('into dbo.stkSecView from stkSecperms a, stkpzjob z');
    dmADO.adoqRun2.sql.Add('ORDER BY z.RoleID, a.Parent, a.PermID');
    dmADO.adoqRun2.ExecSQL;

    close;

    // now set the check boxes to Y/N depending on setting in stkSecurity
    // do an update query for each Tid (and thus for each tid field in stkSecView)
    for i := 0 to pred(theTids.Count) do
    begin
      s1 := thetids.values[thetids.names[i]];

      close;
      sql.Clear;
      sql.Add('update stkSecView set [' + s1 + '] = sq.permset');
      sql.Add('from (');
      sql.Add('  select distinct RoleID, permid, permset');
      sql.Add('  from stkSecurity');
      sql.Add('  where tid = ' + s1);
      sql.Add('  and permset = ''Y'') as sq');
      sql.Add('where stkSecView.RoleID = sq.RoleID');
      sql.Add('and stkSecView.permid = sq.permid');
      execSQL;
    end; // for..

    // get Tid = 0 as well...
    s1 := '0';
    close;
    sql.Clear;
    sql.Add('update stkSecView set [' + s1 + '] = sq.permset');
    sql.Add('from (');
    sql.Add('  select distinct RoleID, permid, permset');
    sql.Add('  from stkSecurity');
    sql.Add('  where tid = ' + s1);
    sql.Add('  and permset = ''Y'') as sq');
    sql.Add('where stkSecView.RoleID = sq.RoleID');
    sql.Add('and stkSecView.permid = sq.permid');
    execSQL;

    // set the top level permission for each row in the new table
    close;
    sql.Clear;
    sql.Add('DECLARE @smalltext VARCHAR(40)');
    sql.Add('DECLARE @permid INTEGER');
    sql.Add('DECLARE @lastTopPerm INTEGER');
    sql.Add('DECLARE topLevelPerm_Cursor CURSOR FOR ');
    sql.Add('  select permid, smalltext from stkSecView');
    sql.Add('OPEN topLevelPerm_Cursor');
    sql.Add('FETCH FROM topLevelPerm_Cursor INTO @permid, @smalltext');
    sql.Add('WHILE @@FETCH_STATUS = 0 ');
    sql.Add('BEGIN');
    sql.Add('  IF @smalltext NOT LIKE ' + QuotedStr(' [-][-] %'));
    sql.Add('  BEGIN');
    sql.Add('    UPDATE stkSecView SET topLevelPerm = PermID');
    sql.Add('	 WHERE CURRENT OF topLevelPerm_Cursor');
    sql.Add('    SET @lastTopPerm = @permid');
    sql.Add('  END');
    sql.Add('  ELSE');
    sql.Add('  BEGIN');
    sql.Add('    UPDATE stkSecView SET topLevelPerm = @lastTopPerm');
    sql.Add('	 WHERE CURRENT OF topLevelPerm_Cursor');
    sql.Add('  END');
    sql.Add('  FETCH NEXT FROM topLevelPerm_Cursor INTO @permid, @smalltext');
    sql.Add('END');
    sql.Add('CLOSE topLevelPerm_Cursor');
    sql.Add('DEALLOCATE topLevelPerm_Cursor');
    execSQL;

    adoqJobTypes.open;

    // Set the names for the grids fields, show/no show grids etc. depending on settings
    // is this to show ALL threads or only one?
    // if only 1 thread then this user will already have site settings permission - do not show HO settings

    if showThread = -1 then // ALL threads (call came from Security button on Main Menu)
    begin
      // is this user allowed HO settings?
      if (data1.UserAllowed(0, 4)) then
      begin
        totH := 356;
        panelHO.Visible := True;

        with gridHO, gridHO.DataSource.DataSet do   // grid field names, etc...
        begin
          open;
          DisableControls;

          Selected.Clear;
          Selected.Add('smalltext' + #9 + '40' + #9 + 'Security Permission');

          Selected.Add('0' + #9 + '1' + #9 + ' Granted ');
          SetControlType('0', fctCheckBox, 'Y;N');

          ApplySelected;
          Invalidate;
          EnableControls;
        end;
      end
      else
      begin
        panelHO.Visible := False;
        totH := 0;
      end;

      // is this user allowed Site Settings?
      if data1.UserAllowed(0, 5) then
      begin
        self.Height := 596;
        self.Width := 790;
        label7.Visible := True;
        tabsTids.Visible := True;

        // show All threads, so call SetGrid with theThread = -1
        SetGrid(gridSGen, -1);
        SetGrid(gridScurr, -1);
        SetGrid(gridSacc, -1);
        SetGrid(gridSrep, -1);

        // set the Threads tab to ALL THREADS...
        tabsTids.TabIndex := tabsTids.Tabs.Count - 1;
      end
      else
      begin
        self.Height := totH;
        self.Width := 547;
        label7.Visible := False;
        tabsTids.Visible := False;
      end;

    end
    else   // 1 thread only, don't show HO settings, make sure only one thread is here...
    begin
      self.Height := 596;
      self.Width := 547;
      panelHO.Visible := False;

      tabsTids.Tabs.Clear;

      // call SetGrid with the Thread given
      SetGrid(gridSGen, showThread);
      SetGrid(gridScurr, showThread);
      SetGrid(gridSacc, showThread);
      SetGrid(gridSrep, showThread);
    end;

    if label7.Visible and panelHO.Visible then
    begin
      label1.Caption := ' HO settings (Dbl-Click to hide)';
      label7.Caption := ' Site settings (Dbl-Click to hide)';
    end
    else
    begin
      label1.Caption := ' HO settings';
      label7.Caption := ' Site settings';
    end;

    SynchTabs;
  end;
end;

procedure TfSecurity.tabsJobsChange(Sender: TObject);
begin
  SynchTabs;
end;

procedure TfSecurity.tabsTidsChange(Sender: TObject);
begin
  FormSettings;

  // call SetGrid with the Thread id given or with -1
  SetGrid(gridSGen, curTid);
  SetGrid(gridScurr, curTid);
  SetGrid(gridSacc, curTid);
  SetGrid(gridSrep, curTid);
end;

procedure TfSecurity.BitBtn1Click(Sender: TObject);
var
  i : integer;
  errstr, s1 : string;
begin
  // Now save all from stkSecView into stkSecurity...

  // deleteing all from stkSecurity first ensures that JobTypes no longer in use are wiped out,
  // also sec setting for threads no longer active are wiped out...

  // do all in a transaction to avoid wiping out settings and then fail on writing...


  if dmADO.AztecConn.InTransaction then
  begin
    log.event('Error in Save Security (before BeginTrans): Already in Transaction');
    showMessage('Error trying to save Security Settings!' + #13 + #13 +
      'Cannot begin transaction');

    exit;
  end;

  dmADO.AztecConn.BeginTrans;

  try
    errstr := 'Empty stkSecurity';
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('delete stkSecurity');
      sql.Add('where RoleID not '+CurrentUser.Roles.AsSQLCheck);
      execSQL;

      errstr := 'Insert in stkSecurity';

      for i := 0 to pred(theTids.Count) do
      begin
        s1 := thetids.values[thetids.names[i]];
        errstr := 'Insert in stkSecurity, Tid: ' + s1;

        close;
        sql.Clear;
        sql.Add('insert stkSecurity (RoleID, Tid, PermID, PermSet, LMDT, LMBy)');
        sql.Add('select RoleID, (' + s1 + ') as Tid, PermID, ''Y'',');
        sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as LMDT,');
        sql.Add('(' + quotedStr(CurrentUser.UserName) + ') as LMBy');
        sql.Add('from stkSecView');
        sql.Add('where [' + s1 + '] = ''Y''');
        execSQL;
      end; // for..

      // dont't forget tid = 0
      s1 := '0';
      errstr := 'Insert in stkSecurity, Tid: ' + s1;

      close;
      sql.Clear;
      sql.Add('insert stkSecurity (RoleID, Tid, PermID, PermSet, LMDT, LMBy)');
      sql.Add('select RoleID, (' + s1 + ') as Tid, PermID, ''Y'',');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as LMDT,');
      sql.Add('(' + quotedStr(CurrentUser.UserName) + ') as LMBy');
      sql.Add('from stkSecView');
      sql.Add('where [' + s1 + '] = ''Y''');
      execSQL;

    end;
  except
    on E:exception do
    begin
      // Error in transaction, attempt to rollback
      if dmADO.AztecConn.InTransaction then
      begin
        dmADO.RollbackTransaction;

        showMessage('Transaction Error trying to Save Security! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message);

        log.event('Error in Save Security - Trans. Rolled Back (' + errstr + '): ' + E.Message);
      end
      else
      begin
        showMessage('Transaction Error trying to Save Security! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'Data Integrity concerning Security may have been compromised!');

        log.event('Error in Save Security - Trans. NOT Rolled Back (' + errstr + '): ' + E.Message);
      end;

      exit;
    end;
  end;

  dmADO.CommitTransaction;
end;

procedure TfSecurity.BitBtn3Click(Sender: TObject);
begin
  // set ALL perms in HO to Y

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkSecView set [0] = ''Y'' where parent = 1');
    sql.Add('and jobtype = ' + quotedStr(curJobType));
    execSQL;
  end;

  adoqHO.Requery;
  gridHO.Refresh;

end;

procedure TfSecurity.BitBtn4Click(Sender: TObject);
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkSecView set [0] = ''N'' where parent = 1');
    sql.Add('and jobtype = ' + quotedStr(curJobType));
    execSQL;
  end;

  adoqHO.Requery;
  gridHO.Refresh;

end;

procedure TfSecurity.BitBtn7Click(Sender: TObject);
var
  i : integer;
  s1 : string;
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkSecView');

    if showThread = -1 then
    begin
      if curTid = -1 then // all...
      begin
        sql.Add('set [0] = ''Y''');
        for i := 0 to pred(theTids.Count) do
        begin
          s1 := thetids.values[thetids.names[i]];
          sql.Add(', [' + s1 + '] = ''Y''');
        end; // for..
      end
      else
      begin
        sql.Add('set [' + inttostr(curTid) + '] = ''Y''');
      end;
    end
    else   // one field only
    begin
      sql.Add('set [' + inttostr(curTid) + '] = ''Y''');
    end;

    sql.Add('where parent <> 1');
    sql.Add('and jobtype = ' + quotedStr(curJobType));
    execSQL;
  end;

  adoqSgen.Requery;
  adoqScurr.Requery;
  adoqSacc.Requery;
  adoqSrep.Requery;
  gridSGen.Refresh;
  gridScurr.Refresh;
  gridSacc.Refresh;
  gridSrep.Refresh;

end;

procedure TfSecurity.BitBtn8Click(Sender: TObject);
var
  i : integer;
  s1 : string;
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkSecView');

    if showThread = -1 then
    begin
      if curTid = -1 then // all...
      begin
        sql.Add('set [0] = ''N''');
        for i := 0 to pred(theTids.Count) do
        begin
          s1 := thetids.values[thetids.names[i]];
          sql.Add(', [' + s1 + '] = ''N''');
        end; // for..
      end
      else
      begin
        sql.Add('set [' + inttostr(curTid) + '] = ''N''');
      end;
    end
    else   // one field only
    begin
      sql.Add('set [' + inttostr(curTid) + '] = ''N''');
    end;

    sql.Add('where parent <> 1');
    sql.Add('and jobtype = ' + quotedStr(curJobType));
    execSQL;
  end;

  adoqSgen.Requery;
  adoqScurr.Requery;
  adoqSacc.Requery;
  adoqSrep.Requery;
  gridSGen.Refresh;
  gridScurr.Refresh;
  gridSacc.Refresh;
  gridSrep.Refresh;

end;

procedure TfSecurity.gridFieldChanged(Sender: TObject; Field: TField);

  procedure updateAllThreads(permid: integer; newValue: String);
  var
    i : integer;
  begin
    with dmAdo.adoqRun do
    begin;
      close;
      sql.Clear;
      sql.Add('update stkSecView set [0] = ' + quotedStr(newValue));
      for i := 1 to (TwwDBGrid(sender).FieldCount - 2) do // do all
      begin
        sql.Add(', [' + TwwDBGrid(sender).Fields[i].FieldName + '] = ' + quotedStr(newValue));
      end; // for..
      sql.Add('where permid = ' + inttostr(permid));
      sql.Add('and jobtype = ' + quotedStr(curJobType));
      execSQL;
    end;
  end;

  procedure updateOneThread(permid: integer; newValue: String);
  begin
    with dmAdo.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkSecView set [' + Field.FieldName + '] = ' + quotedStr(newValue));
      sql.Add('where permid = ' + inttostr(permid));
      sql.Add('and jobtype = ' + quotedStr(curJobType));
      execSQL;
    end;
  end;

  procedure updateAllPermissionsForThread(topLevelPerm: integer; newValue: String);
  begin
    with dmAdo.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE stkSecView SET [' + Field.FieldName  + '] = ' + quotedStr(newValue));
      sql.Add('WHERE topLevelPerm = ' + intToStr(topLevelPerm));
      sql.Add('  AND jobtype = ' + quotedStr(curJobType));
      execSQL;
    end;
  end;

  procedure updateAllPermissionsForAllThreads(topLevelPerm: integer; newValue: String);
  var
    i : integer;
  begin
    with dmAdo.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkSecView set [0] = ' + quotedStr(newValue));
      for i := 1 to (TwwDBGrid(sender).FieldCount - 2) do // do all
      begin
        sql.Add(', [' + intToStr(i) + '] = ' + quotedStr(newValue));
      end; // for..
      sql.Add('where [topLevelPerm] = ' + inttostr(topLevelPerm));
      sql.Add('and jobtype = ' + quotedStr(curJobType));
      execSQL;
    end;
  end;

  procedure updateGridViews;
  begin
    TwwDBGrid(sender).DataSource.DataSet.DisableControls;
    TADOQuery(TwwDBGrid(sender).DataSource.DataSet).close;
    TADOQuery(TwwDBGrid(sender).DataSource.DataSet).open;
    TwwDBGrid(sender).DataSource.DataSet.EnableControls;
  end;

  function anyChildPermissionsToChange(topLevelPerm: integer) : boolean;
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select * from stkSecView');
      sql.Add('where [topLevelPerm] = ' + inttostr(topLevelPerm));
      sql.Add('and smalltext LIKE ' + quotedStr(' [-][-] %'));
      sql.Add('and [' + Field.FieldName + '] <> ' + quotedStr(Field.AsString));
      sql.Add('and jobtype = ' + quotedStr(curJobType));
      open;

      result :=  recordcount > 0;
    end; // with
  end;

  procedure checkParentPermissions(topLevelPerm: integer);
  var
    i, threadNumber : integer;
    fieldName : string;
  begin
    with dmADO.adoqRun do
    begin
      for i := 0 to (TwwDBGrid(sender).DataSource.DataSet.FieldCount - 1) do
      begin
        fieldName := TwwDBGrid(sender).DataSource.DataSet.Fields[i].FieldName;
        if (TryStrToInt(fieldName, threadNumber)) and (threadNumber <> 0) then
        begin
          close;
          sql.Clear;
          sql.Add('IF (SELECT COUNT(permid) FROM stkSecView ');
          sql.Add('WHERE toplevelPerm = ' + intToStr(topLevelPerm));
          sql.Add('  AND jobtype = ' + QuotedStr(curJobType) + ') > 1');
          sql.Add('BEGIN');
          sql.Add('  IF EXISTS ');
          sql.Add('   (SELECT permid');
          sql.Add('   FROM stkSecView');
          sql.Add('   WHERE [' + fieldName + '] = ''Y''');
          sql.Add('     AND jobtype = ' + QuotedStr(curJobType));
          sql.Add('     AND topLevelPerm = ' + IntToStr(topLevelPerm));
          sql.Add('     AND permid <> topLevelPerm)');
          sql.Add('  BEGIN');
          sql.Add('    UPDATE stkSecView SET [' + fieldName + '] = ''Y''');
          sql.Add('    WHERE permid = ' + IntToStr(topLevelPerm));
          sql.Add('      AND jobtype = ' + quotedStr(curJobType));
          sql.Add('  END');
          sql.Add('END');
          ExecSQL;
        end; // if
      end; // for
    end; // with
  end;

  procedure checkAllThreadsSetting(permid: integer);
  var
    i, threadNumber : integer;
    fieldName : string;
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update S set [0] = ''Y''');
      sql.Add('from stkSecView s');
      sql.Add('  WHERE exists ( select *');
      sql.Add('		from stkSecView as b');
      sql.Add('		where jobtype = ' + quotedStr(curJobType));
      sql.Add('		  and s.permid = b.permid');
      for i := 0 to (TwwDBGrid(sender).DataSource.DataSet.FieldCount - 1) do
      begin
        fieldName := TwwDBGrid(sender).DataSource.DataSet.Fields[i].FieldName;
        if (TryStrToInt(fieldName, threadNumber)) and (threadNumber <> 0) then
        begin
          sql.Add('            and [' + fieldName + '] = ''Y''');
        end; // if
      end;
      sql.Add('                 )');
      sql.Add('  AND jobtype = ' + quotedStr(curJobType));
      sql.Add('update S set [0] = ''N''');
      sql.Add('from stkSecView s');
      sql.Add('  WHERE NOT exists ( select *');
      sql.Add('		from stkSecView as b');
      sql.Add('		where jobtype = ' + quotedStr(curJobType));
      sql.Add('		  and s.permid = b.permid');
      for i := 0 to (TwwDBGrid(sender).DataSource.DataSet.FieldCount - 1) do
      begin
        fieldName := TwwDBGrid(sender).DataSource.DataSet.Fields[i].FieldName;
        if (TryStrToInt(fieldName, threadNumber)) and (threadNumber <> 0) then
        begin
          sql.Add('            and [' + fieldName + '] = ''Y''');
        end; // if
      end;
      sql.Add('                 )');
      sql.Add('  AND jobtype = ' + quotedStr(curJobType));
      ExecSQL;
    end;
  end;

  function allFieldClicked : boolean;
  begin
    result := (Field.FieldName = '0') and (TwwDBGrid(Sender).SelectedField.FieldName = '0');
  end;

  function isChildField : boolean;
  var
    ss : string;
  begin
    ss := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('smalltext').asstring;
    ss := copy(ss, 1, 4);
    result := ss = ' -- ';
  end;

var
  permid, topLevelPerm: integer;
begin
  permid := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('permid').asinteger;
  topLevelPerm := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('topLevelPerm').asinteger;

  if allFieldClicked then
    if (isChildField) or (Field.AsString = 'Y') then
      updateAllThreads(permid, Field.AsString)
    else   // top level field being set to 'N'
      if MessageDlg('You are about to reset ALL top level permissions. '+#13+
                        'This will reset ALL subordinate permissions on all threads to match.'+#13 +''+#13+
                        'Do you want to continue?', mtWarning, [mbYes,mbNo], 0) = mrYes then
        updateAllPermissionsForAllThreads(topLevelPerm, Field.AsString)
      else  // warning message 'No'
        // reverse change...
        field.Value := 'Y'
  else
  begin
    if isChildField then
      updateOneThread(permid, Field.AsString)
    else   // top level field
    begin
      if (anyChildPermissionsToChange(topLevelPerm)) and (Field.AsString = 'N') then
      begin
        if MessageDlg('You are about to reset a top level permission. '+#13+
                        'This will reset all subordinate permissions to match.'+#13 +''+#13+
                        'Do you want to continue?', mtWarning, [mbYes,mbNo], 0) = mrYes then
          updateAllPermissionsForThread(topLevelPerm, Field.AsString)
        else
          // reverse change...
            field.Value := 'Y';
      end // if anychild...
      else // no child permissions
        updateOneThread(permid, Field.AsString);
    end; // top level field field
  end; // if wasAllFieldClicked ... else

  checkParentPermissions(topLevelPerm);
  checkAllThreadsSetting(permid);
  updateGridViews;
  TwwDBGrid(sender).DataSource.DataSet.Locate('permid; jobtype', VarArrayOf([IntToStr(permid), curJobType]), []);
end;

procedure TfSecurity.BitBtn5Click(Sender: TObject);
begin
  // make ALL job types HO settings like this
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update stkSecView set [0] = sq.AllThreads');
    sql.Add('from (select permid, [0] as allThreads from stkSecView');
    sql.Add('      where [parent] = 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
    sql.Add('where stkSecView.[parent] = 1');
    sql.Add('and stkSecView.permid = sq.permid');
    sql.Add('and stkSecView.jobtype <> ' + quotedStr(curJobType));
    execSQL;
  end;
end;

procedure TfSecurity.BitBtn9Click(Sender: TObject);
var
  i : integer;
begin
  // make ALL job types Site settings like this
  with dmADO.adoqRun do
  begin
    if curTid = -1 then
    begin
      close;
      sql.Clear;
      sql.Add('update stkSecView set [0] = sq.AllThreads');

      for i := 0 to pred(theTids.Count) do
      begin
        sql.Add(', [' + thetids.values[thetids.names[i]] + '] = sq.[' + thetids.values[thetids.names[i]] + ']');
      end; // for..

      sql.Add('from (select permid, [0] as allThreads');

      for i := 0 to pred(theTids.Count) do
      begin
        sql.Add('    , [' + thetids.values[thetids.names[i]] + ']');
      end; // for..

      sql.Add('      from stkSecView where [parent] <> 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
      sql.Add('where stkSecView.[parent] <> 1');
      sql.Add('and stkSecView.permid = sq.permid');
      sql.Add('and stkSecView.jobtype <> ' + quotedStr(curJobType));
      execSQL;
    end
    else
    begin
      close;
      sql.Clear;
      sql.Add('update stkSecView set [' + inttostr(curTid) + '] = sq.theSet');
      sql.Add('from (select permid, [' + inttostr(curTid) + '] as theSet');
      sql.Add('      from stkSecView where [parent] <> 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
      sql.Add('where stkSecView.[parent] <> 1');
      sql.Add('and stkSecView.permid = sq.permid');
      sql.Add('and stkSecView.jobtype <> ' + quotedStr(curJobType));
      execSQL;
    end;
  end;
end;

procedure TfSecurity.BitBtn6Click(Sender: TObject);
begin
  fSecCopy := TfSecCopy.Create(self);
  fSecCopy.panelHO.Visible := True;
  fSecCopy.tabsTids.Visible := False;
  fSecCopy.Caption := 'Copy HO Permissions in "' + curJobType + '"';
  fSecCopy.ShowModal;
  fSecCopy.Free;
end;

procedure TfSecurity.BitBtn10Click(Sender: TObject);
begin
  fSecCopy := TfSecCopy.Create(self);
  fSecCopy.panelHO.Visible := False;
  fSecCopy.tabsTids.Visible := True;
  fSecCopy.showThread := curTid;
  fSecCopy.Caption := 'Copy Site Permissions in "' + curJobType + '"';
  fSecCopy.ShowModal;
  fSecCopy.Free;

end;

procedure TfSecurity.Label1DblClick(Sender: TObject);
begin
  // if only HO visible don't do hiding....
  if label1.Caption = ' HO settings' then
    exit;

  if label1.Caption = ' HO settings (Dbl-Click to hide)' then
  begin
    label1.Caption := ' HO settings (Dbl-Click to see)';
    if label7.Caption = ' Site settings (Dbl-Click to see)' then
      self.Height := self.Height - panelHO.ClientHeight + label1.Height;
    panelHO.ClientHeight := label1.Height;
    gridHO.Visible := false;
    panel4.Visible := false;
  end
  else
  begin
    label1.Caption := ' HO settings (Dbl-Click to hide)';
    panelHO.Height := 227;
    gridHO.Visible := true;
    panel4.Visible := true;

    if label7.Caption = ' Site settings (Dbl-Click to see)' then
      self.Height := self.Height + 227 - label1.Height
    else
      self.Height := max(self.Height, 534);
  end;
end;

procedure TfSecurity.Label7DblClick(Sender: TObject);
begin
  // if only site visible don't do hiding....
  if label7.Caption = ' Site settings' then
    exit;

  if label7.Caption = ' Site settings (Dbl-Click to hide)' then
  begin
    label7.Caption := ' Site settings (Dbl-Click to see)';
    theH := tabsTids.Height;
    tabsTids.Visible := false;
    self.Height := self.Height - theH;
  end
  else
  begin
    label7.Caption := ' Site settings (Dbl-Click to hide)';
    tabsTids.Visible := true;
    self.Height := max(self.Height + theH, 534);
  end;
end;

procedure TfSecurity.gridHOExit(Sender: TObject);
begin
  if TwwDBGrid(Sender).DataSource.DataSet.State = dsEdit then
    TwwDBGrid(Sender).DataSource.DataSet.Post;
end;

procedure TfSecurity.SynchTabs;
begin
  adoqJobTypes.Locate('jobtype', tabsJobs.Tabs[tabsJobs.TabIndex], []);

  FormSettings;

//  adoqSgen.Requery;
//  adoqScurr.Requery;
//  adoqSacc.Requery;
//  adoqSrep.Requery;
  gridHO.Refresh;
  gridSGen.Refresh;
  gridScurr.Refresh;
  gridSacc.Refresh;
  gridSrep.Refresh;

  Application.ProcessMessages;
end;

procedure TfSecurity.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   theTids.Free;
end;

end.
