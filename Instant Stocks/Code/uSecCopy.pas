unit uSecCopy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, ComCtrls,
  DB, Wwdatsrc, ADODB;

type
  TfSecCopy = class(TForm)
    tabsJobs: TTabControl;
    Label7: TLabel;
    tabsTids: TTabControl;
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
    panelHO: TPanel;
    Label1: TLabel;
    gridHO: TwwDBGrid;
    adoqJobTypes: TADOQuery;
    dsJobTypes: TwwDataSource;
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
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure tabsJobsChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    curJobType : string;
    procedure SetGrid(theGrid: TwwDBGrid; theThread: integer);
    procedure FormSettings;
    { Private declarations }
  public
    { Public declarations }
    showThread : integer;
    curDiv, curThread : string;
  end;

var
  fSecCopy: TfSecCopy;

implementation

uses uSecurity, udata1, uADO, uGlobals;

{$R *.dfm}

procedure TfSecCopy.FormShow(Sender: TObject);
begin
  with adoqJobTypes do
  begin
    // get job types and make up tabs for them
    tabsJobs.Tabs.Clear;

    close;
    sql.Clear;
    sql.Add('select jobtype from stkPzJob');
    sql.Add('where roleid not ' + CurrentUser.Roles.AsSQLCheck);
    sql.Add('and jobType <> ' + quotedStr(fSecurity.curjobType));
    sql.Add('order by jobtype');
    open;

    while not eof do
    begin
      tabsJobs.Tabs.Append(FieldByName('jobtype').asstring);
      next;
    end;
    first;
    tabsJobs.TabIndex := 0;
  end;

  if panelHO.visible = True then
  begin
    self.HelpContext := 1042;
    tabsTids.Visible := False;
    label7.Visible := False;
    panelHO.Align := alClient;
      self.Width := 550;
      self.Height := 320 + ((tabsJobs.RowCount -1) * ABS(tabsJobs.Font.Height));
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
    self.HelpContext := 1043;
    self.Height := 580;
    if showThread = -1 then // ALL threads
    begin
        self.Width := 795;
        label7.Visible := True;

        tabsTids.Tabs.Clear;

        // show All threads, so call SetGrid with theThread = -1
        SetGrid(gridSGen, -1);
        SetGrid(gridScurr, -1);
        SetGrid(gridSacc, -1);
        SetGrid(gridSrep, -1);




    end
    else   // 1 thread only, don't show HO settings, make sure only one thread is here...
    begin
      self.Width := 550;

      tabsTids.Tabs.Clear;

      // call SetGrid with the Thread given
      SetGrid(gridSGen, showThread);
      SetGrid(gridScurr, showThread);
      SetGrid(gridSacc, showThread);
      SetGrid(gridSrep, showThread);
    end;
  end;
  FormSettings;

end;

procedure TfSecCopy.SetGrid(theGrid: TwwDBGrid; theThread: integer);
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
      for i := 0 to pred(fSecurity.theTids.Count) do
      begin
        s1 := fSecurity.thetids.values[fSecurity.thetids.names[i]];
        Selected.Add(s1 + #9 + '1' + #9 + ' ' + fSecurity.thetids.names[i] + ' ');
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

procedure TfSecCopy.FormSettings;
var
  p1 : integer;
begin
  curJobType := adoqJobTypes.FieldByName('jobtype').AsString; //tabsJobs.tabs[tabsJobs.tabindex];

  if tabsTids.Visible then
  begin
    if showThread = -1 then
    begin
        label10.Caption := 'Role: ' + curJobType + #13 + 'Showing ALL THREADS';
    end
    else
    begin // single thread mode, no tabsTids values to look at...
      if fSecurity.showThread = -1 then
      begin
        p1 := pos('~ ', fSecurity.curTName);
        label10.Caption := 'Role: ' + curJobType + #13 + 'Division: ' +
          copy(fSecurity.curTName, 1, p1) + ' Thread: ' + copy(fSecurity.curTName, p1 + 2, length(fSecurity.curTName));
      end
      else
        label10.Caption := 'Role: ' + curJobType + #13 + 'Division: ' +
          fSecurity.curDiv + ' ~ Thread: ' + fSecurity.curTName;
    end;
  end
  else
  begin
    // ...
  end;

  bitbtn1.Caption := 'Do Copy From "' + curJobType + '"';

end; // procedure..


procedure TfSecCopy.tabsJobsChange(Sender: TObject);
begin
  adoqJobTypes.Locate('jobtype', tabsJobs.Tabs[tabsJobs.TabIndex], []);

  FormSettings;

  gridHO.Refresh;
  gridSGen.Refresh;
  gridScurr.Refresh;
  gridSacc.Refresh;
  gridSrep.Refresh;

  Application.ProcessMessages;

end;

procedure TfSecCopy.BitBtn1Click(Sender: TObject);
var
  i : integer;
begin
  // now copy the settings selected...

  // HO mode
  if panelHO.Visible then
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update stkSecView set [0] = sq.AllThreads');
      sql.Add('from (select permid, [0] as allThreads from stkSecView');
      sql.Add('      where [parent] = 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
      sql.Add('where stkSecView.[parent] = 1');
      sql.Add('and stkSecView.permid = sq.permid');
      sql.Add('and stkSecView.jobtype = ' + quotedStr(fSecurity.curJobType));
      execSQL;
    end;

    fSecurity.adoqHO.Requery;
    fSecurity.gridHO.Refresh;
  end
  else
  begin
  // Site ALL THREADS
    if showThread = -1 then
    begin
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update stkSecView set [0] = sq.AllThreads');

        for i := 0 to pred(fSecurity.theTids.Count) do
        begin
          sql.Add(', [' + fSecurity.thetids.values[fSecurity.thetids.names[i]] +
            '] = sq.[' + fSecurity.thetids.values[fSecurity.thetids.names[i]] + ']');
        end; // for..

        sql.Add('from (select permid, [0] as allThreads');

        for i := 0 to pred(fSecurity.theTids.Count) do
        begin
          sql.Add('    , [' + fSecurity.thetids.values[fSecurity.thetids.names[i]] + ']');
        end; // for..

        sql.Add('      from stkSecView where [parent] <> 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
        sql.Add('where stkSecView.[parent] <> 1');
        sql.Add('and stkSecView.permid = sq.permid');
        sql.Add('and stkSecView.jobtype = ' + quotedStr(fSecurity.curJobType));
        execSQL;
      end;
    end
    else
    begin
  // Site 1 THREAD
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update stkSecView set [' + inttostr(showThread) + '] = sq.theSet');
        sql.Add('from (select permid, [' + inttostr(showThread) + '] as theSet');
        sql.Add('      from stkSecView where [parent] <> 1 and jobtype = ' + quotedStr(curJobType) + ') as sq');
        sql.Add('where stkSecView.[parent] <> 1');
        sql.Add('and stkSecView.permid = sq.permid');
        sql.Add('and stkSecView.jobtype = ' + quotedStr(fSecurity.curJobType));
        execSQL;
      end;
    end;

    fSecurity.adoqSgen.Requery;
    fSecurity.adoqScurr.Requery;
    fSecurity.adoqSacc.Requery;
    fSecurity.adoqSrep.Requery;
    fSecurity.gridSGen.Refresh;
    fSecurity.gridScurr.Refresh;
    fSecurity.gridSacc.Refresh;
    fSecurity.gridSrep.Refresh;
  end;

end;

end.
