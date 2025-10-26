unit uEditDefaultJobPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB;

const NULL_JOB_CODE = '-22222';

type
  TEditDefaultJobPanel = class(TForm)
    grbxPanels: TGroupBox;
    lblPanel: TLabel;
    cbxPanelList: TComboBox;
    dbgTimeCycleList: TwwDBGrid;
    btnRemove: TButton;
    btnAdd: TButton;
    grbxJobRoles: TGroupBox;
    clbJobs: TCheckListBox;
    btnDeSelect: TButton;
    btnSelectAll: TButton;
    btClose: TButton;
    qDefaultJobPanels: TADOQuery;
    dtsDefaultJobPanels: TDataSource;
    qDefaultJobPanelsPanelName: TStringField;
    Label1: TLabel;
    qDefaultJobPanelsDefaultID: TIntegerField;
    qDefaultJobPanelsThemeID: TIntegerField;
    qDefaultJobPanelsPanelDesignID: TIntegerField;
    qDefaultJobPanelsPanelID: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnDeSelectClick(Sender: TObject);
    procedure cbxPanelDesignSelect(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure qDefaultJobPanelsCalcFields(DataSet: TDataSet);
    procedure qDefaultJobPanelsAfterScroll(DataSet: TDataSet);
    procedure cbxPanelListChange(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure clbJobsClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qDefaultJobPanelsBeforeScroll(DataSet: TDataSet);
  private
    PanelList, DefaultPanelList : TStringlist;
    modified, canDelete : Boolean;
    function GetPanelList: TStrings;
    procedure InitialisePanels;
    function GetPanelName(PanelID: Int64): String;
    procedure EnableSelections;
    procedure SaveRoles;
    function PanelNameExists: Boolean;
    function ValidDefaultJobPanel: Boolean;
    function noRolesSelected: Boolean;
    procedure loadPanelSelections(nThemeID, nPanelDesignID, nDefaultID : integer; nPanelID : Largeint);
    procedure removefromPanelList(PanelID: integer);
    function isLowVersionSite(ReqDBVer: String): Boolean;
    { Private declarations }
  public
    FThemeID, FPanelDesignID : Integer;
    FPanelName : String;
    { Public declarations }
  end;

implementation

uses uADO, uDMThemeData, uGenerateThemeIDs,uDatabaseVersion;

{$R *.dfm}

procedure TEditDefaultJobPanel.FormShow(Sender: TObject);
begin
  PanelList := TStringList.Create;
  DefaultPanelList := TStringList.Create;

  InitialisePanels;
end;

procedure TEditDefaultJobPanel.InitialisePanels;
begin
  PanelList.Clear;
  cbxPanelList.Items.Assign(GetPanelList);

  with dmADO.qRun do
  begin
    SQL.Text := Format('SELECT DefaultID, PanelDesignID, PanelID, ThemeID '+
                       '       FROM ThemeDefaultRolePanel '+
                       ' WHERE PanelDesignID = %d '+
                       '       AND ThemeID = %d  ', [FPanelDesignID,FThemeID]);
    Open;

    First;
    while not EOF do
          begin
            DefaultPanelList.Add(FieldByName('PanelID').AsString);
            Next;
          end;
  end;

  qDefaultJobPanels.Parameters[0].Value := FPanelDesignID;
  qDefaultJobPanels.Parameters[1].Value := FThemeID;
  qDefaultJobPanels.Open;
  loadPanelSelections(qDefaultJobPanelsThemeID.Value, qDefaultJobPanelsPanelDesignID.Value, qDefaultJobPanelsDefaultID.Value, qDefaultJobPanelsPanelID.Value);

  EnableSelections;
end;

procedure TEditDefaultJobPanel.loadPanelSelections(nThemeID, nPanelDesignID, nDefaultID : integer; nPanelID : Largeint);
   procedure checkRole(nRoleID : Largeint);
   var i : integer;
   begin
     for i := 0 to Pred(clbJobs.Items.Count) do
         if integer(clbJobs.Items.Objects[i]) = nRoleID then
             clbJobs.Checked[i] := true;

   end;
   
begin
  // load available roles
  with dmADO.qRun do
  begin
    SQL.text := Format('SELECT DISTINCT Id, Name   '+
                       '       FROM ac_Role  '+
                       ' WHERE deleted = 0 AND RoleTypeId = 1 AND Id <> %s  '+
                       '      AND Id NOT IN (SELECT ISNULL(RoleID, 0) '+
                       '                            FROM ThemeDefaultRolePanel rp '+
                       '                                 INNER JOIN ThemeDefaultRolePanelRoles pr ON pr.DefaultID = rp.DefaultID '+
                       '                     WHERE ThemeID = %d AND PanelDesignID = %d)', [NULL_JOB_CODE, nThemeID, nPanelDesignID]);
    Open;
    clbJobs.clear;
    while not Eof do
    begin
      clbjobs.AddItem(fieldbyname('Name').asstring, TObject(fieldbyname('Id').asinteger));
      next;
    end;
  close;
  end;

  // load selected roles
  with dmADO.qRun do
  begin
    SQL.text := Format('SELECT DISTINCT Id, Name   '+
                       '       FROM ac_Role  '+
                       ' WHERE deleted = 0 AND RoleTypeId = 1 AND Id <> %s  '+
                       '      AND Id IN (SELECT ISNULL(RoleID, 0) '+
                       '                            FROM ThemeDefaultRolePanel rp '+
                       '                                 INNER JOIN ThemeDefaultRolePanelRoles pr ON pr.DefaultID = rp.DefaultID '+
                       '                     WHERE ThemeID = %d AND PanelDesignID = %d AND PanelID = %d AND rp.DefaultID = %d )', [NULL_JOB_CODE, nThemeID, nPanelDesignID, nPanelID, nDefaultID]);
    Open;
    while not Eof do
    begin
      clbjobs.AddItem(fieldbyname('Name').asstring, TObject(fieldbyname('Id').asinteger));
      checkRole(fieldbyname('Id').asinteger);
      next;
    end;
  close;
  end;
end;

procedure TEditDefaultJobPanel.SaveRoles;

  procedure deleteExistingRoles(nDefaultID : integer);
  begin
    with dmADO.qRun do
    begin
      SQL.Text := Format('DELETE FROM ThemeDefaultRolePanelRoles WHERE DefaultID = %d ', [nDefaultID]);
      ExecSQL;
    end;
  end;

var
  dynamic_grantedroles : String;
  i : integer;
begin

  dynamic_grantedroles := '';

  deleteExistingRoles(qDefaultJobPanelsDefaultID.Value);

  for i := 0 to pred(clbJobs.Items.Count) do
  begin
    if clbJobs.checked[i] then
       dynamic_grantedroles := dynamic_grantedroles +
         format('INSERT @grantedroles SELECT %d, %d, %d ', [getNewID(scThemeDefaultJobPanelRole), qDefaultJobPanelsDefaultID.Value, cardinal(clbJobs.Items.Objects[i])]);
  end;

  with dmADO.qRun do
  begin
    sql.text := 'DECLARE @grantedRoles TABLE (ID INT, DefaultID BIGINT, RoleID BIGINT) '+ dynamic_grantedroles +
                ' INSERT INTO ThemeDefaultRolePanelRoles SELECT ID, DefaultID, RoleID FROM @grantedRoles ';
    ExecSQL;
  end;

  if isLowVersionSite('3.4.2.0') then
     MessageDlg('Default Role Panels are not supported by all sites using the '+FPanelName+' panel design.'+#10+
                'This functionality will not be available on terminals at these sites.', mtWarning, [mbOk],0);

  modified := false;
end;

function TEditDefaultJobPanel.isLowVersionSite(ReqDBVer : String) : Boolean;
var
  DBVer, DBRequiredVer : TDatabaseVersion;
begin
  Result := False;

  with dmADO.qRun do
    begin
      Close;
      SQL.Text:= Format('SELECT DBVersion FROM CommsVersions cv  '+
                        '                 INNER JOIN (SELECT DISTINCT(SiteCode) AS SiteCode FROM ThemeEposDesign '+
                        '                             WHERE PanelDesignID = %d) t ON t.SiteCode = cv.SiteCode ', [FPanelDesignID]);
      Open;

      DBRequiredVer := TDatabaseVersion.Create(ReqDBVer);
      First;
      while not EOF do
         begin
           if (FieldByName('DBVersion').AsString = '') then
              Result := True
           else
             begin
               DBVer := TDataBaseVersion.Create(FieldByName('DBVersion').AsString);
               if DBVer.IsLowerThan(DBRequiredVer) then
                  begin
                    Result := True;
                    DBVer.Free;
                    exit;
                  end;
             end;
           next;
         end;
    end;
end;

procedure TEditDefaultJobPanel.EnableSelections;

   function HasRecordsSelectable : boolean;
   begin
     Result := False;
     if qDefaultJobPanels.RecordCount > 0 then
        Result := True
   end;

begin
   cbxPanelList.Enabled := HasRecordsSelectable;
   clbJobs.Enabled := HasRecordsSelectable;
end;

function TEditDefaultJobPanel.GetPanelList: TStrings;
begin
    PanelList.Clear;
    with dmADO.qRun do
    try
      Close;
      SQL.Text := 'declare @result table(id int, name varchar(100))  '+
                  'declare @paneldesignid int '+
                  'set @paneldesignid = '+ IntToStr(FPanelDesignID) +''+

                  'insert @result select 0, ''Root'' '+
                  'insert @result select tableplanid, ''Table Plan "'' +name+''"''  '+
                  'from  ThemeTablePlan where '+
                  'themeid = (select top 1 themeid from ThemePanelDesign where paneldesignid = @paneldesignid) '+
                  'insert @result        '+
                  'select panelid, name from themepanel     '+
                  'where paneltype = 3 and paneldesignid = @paneldesignid   '+
                  'and panelid not in     '+
                  '(                       '+
                  'select root from themepaneldesign where paneldesignid = @paneldesignid '+
                  'union '+
                  'select correctaccount from themepaneldesign where paneldesignid = @paneldesignid '+
                  ') '+
                  'union  '+
                  'select ts.panelid, tp.name from themepanelbutton tpb  '+
                  '         join themepanelsharedpos ts on CAST(ts.panelid as varchar) = tpb.ButtonTypeChoiceAttr01  '+
                  '         join themepanel tp on tp.panelid = ts.panelid  '+
                  'where ts.paneldesignid = @paneldesignid  '+
                  'order by name  '+
                  'select * from @result';
      Open;
      while not EOF do
      begin
        PanelList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('ID').AsInteger)));
        Next;
      end
    finally
      Close;
    end;
  Result := PanelList;
end;

procedure TEditDefaultJobPanel.btnSelectAllClick(Sender: TObject);
var
  i : integer;
begin
  modified := True;
  if qDefaultJobPanels.RecordCount > 0 then
      for i:= 0 to pred(clbJobs.Items.Count) do
          begin
            clbJobs.checked[i] := True;
          end;

end;

procedure TEditDefaultJobPanel.btnDeSelectClick(Sender: TObject);
var
  i : integer;
begin
  modified := True;
  if qDefaultJobPanels.RecordCount > 0 then
     for i:= 0 to pred(clbJobs.Items.Count) do
         begin
           clbJobs.checked[i] := False;
         end;
end;

procedure TEditDefaultJobPanel.cbxPanelDesignSelect(Sender: TObject);
begin
  InitialisePanels;
  EnableSelections;
end;

procedure TEditDefaultJobPanel.btnAddClick(Sender: TObject);
begin
  if not ValidDefaultJobPanel then
     abort;

  if clbJobs.Items.Count > 0 then
     begin
       if modified then
          SaveRoles;

       cbxPanelList.ItemIndex := 0;

       with qDefaultJobPanels do
            begin
              Insert;
              qDefaultJobPanelsDefaultID.Value := getNewID(scThemeDefaultJobPanel);
              qDefaultJobPanelsPanelDesignID.Value := FPanelDesignID;
              qDefaultJobPanelsThemeID.Value := FThemeID;
              qDefaultJobPanelsPanelID.Value := Integer(cbxPanelList.Items.Objects[cbxPanelList.ItemIndex]);
              qDefaultJobPanelsPanelName.Value := GetPanelName(qDefaultJobPanelsPanelID.value);
              Post;
              DefaultPanelList.Add(IntToStr(qDefaultJobPanelsPanelID.Value));
            end;
       EnableSelections;
       loadPanelSelections(qDefaultJobPanelsThemeID.Value, qDefaultJobPanelsPanelDesignID.Value, qDefaultJobPanelsDefaultID.Value, qDefaultJobPanelsPanelID.Value);
     end
  else
     MessageDlg('There are no Role available to assign to a New Default Role Panel.', mtError, [mbOK], 0);
end;

function TEditDefaultJobPanel.GetPanelName(PanelID:Int64) : String;
var i : integer;
begin
  for i:= 0 to Pred(PanelList.Count) do
    begin
      if Integer(PanelList.Objects[i]) = PanelID then
         result := PanelList.Strings[i]
    end;
end;

procedure TEditDefaultJobPanel.qDefaultJobPanelsCalcFields(
  DataSet: TDataSet);
begin
     qDefaultJobPanelsPanelName.Value := GetPanelName(qDefaultJobPanelsPanelID.value);
end;

procedure TEditDefaultJobPanel.qDefaultJobPanelsAfterScroll(
  DataSet: TDataSet);
begin
  cbxPanelList.ItemIndex := PanelList.IndexOfObject(TObject(qDefaultJobPanelsPanelID.Value));
  loadPanelSelections(qDefaultJobPanelsThemeID.Value, qDefaultJobPanelsPanelDesignID.Value, qDefaultJobPanelsDefaultID.value, qDefaultJobPanelsPanelID.Value);
end;

procedure TEditDefaultJobPanel.removefromPanelList(PanelID : integer);
var i : integer;
begin
  for i := 0 to Pred(DefaultPanelList.Count) do
      if StrToInt(DefaultPanelList.Strings[i]) = PanelID then
         begin
           DefaultPanelList.Delete(i);
           Exit;
         end;
end;

procedure TEditDefaultJobPanel.cbxPanelListChange(Sender: TObject);
begin
  removefromPanelList(qDefaultJobPanelsPanelID.Value);
  qDefaultJobPanels.Edit;
  qDefaultJobPanelsPanelID.Value := integer(cbxPanelList.Items.Objects[cbxPanelList.ItemIndex]);
  qDefaultJobPanels.Post;
  DefaultPanelList.Add(IntToStr(integer(cbxPanelList.Items.Objects[cbxPanelList.ItemIndex])));
end;

procedure TEditDefaultJobPanel.btnRemoveClick(Sender: TObject);
   procedure RemoveFromList(sPanelID : Int64);
   var i : integer;
   begin
     for i := 0 to Pred(DefaultPanelList.Count) do
       if StrToInt(DefaultPanelList.Strings[i]) = sPanelID then
          begin
            DefaultPanelList.Delete(i);
            Exit;
          end;
   end;

begin
  if qDefaultJobPanels.RecordCount > 0 then
     begin
       with dmADO.qRun do
            begin
              SQL.Text := Format('DELETE FROM ThemeDefaultRolePanel WHERE DefaultID = %d ', [qDefaultJobPanelsDefaultID.Value]);
              ExecSQL;
              RemoveFromList(qDefaultJobPanelsPanelID.Value);
            end;
       qDefaultJobPanels.Close;
       qDefaultJobPanels.Open;
       EnableSelections;
     end
  else
     MessageDlg('Please select a valid Panel Name.', mtError, [mbOK], 0);
end;

function TEditDefaultJobPanel.PanelNameExists : Boolean;
var nameCount, i : integer;
begin
  Result := False;
  nameCount := 0;

  for i := 0 to Pred(DefaultPanelList.Count) do
      if StrToInt(DefaultPanelList.Strings[i]) = Integer(cbxPanelList.Items.Objects[cbxPanelList.ItemIndex]) then
         Inc(nameCount);

  if nameCount > 1 then
     Result := True;
end;

function TEditDefaultJobPanel.noRolesSelected : Boolean;
var i : integer;
begin
  Result := True;
  for i := 0 to Pred(clbJobs.Items.Count) do
     if clbJobs.checked[i] then
        Result := False;
end;

function TEditDefaultJobPanel.ValidDefaultJobPanel : Boolean;
begin
  result := True;
  if qDefaultJobPanels.RecordCount > 0 then
     begin
  if PanelNameExists then
     Begin
       MessageDlg('Panel Name already exists.', mtError, [mbOK], 0);
       result := False;
     end
  else
       if noRolesSelected then
          begin
            MessageDlg('At least one Role must be assigned to a Default Job Panel.', mtError, [mbOK], 0);
            Result := False
          end;
     end;
end;

procedure TEditDefaultJobPanel.clbJobsClickCheck(Sender: TObject);
begin
  modified := True;
end;

procedure TEditDefaultJobPanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if qDefaultJobPanels.RecordCount > 0 then
     begin
       if not ValidDefaultJobPanel then
          begin
            Action := caNone;
            Abort;
          end;

       if modified then
          begin
            SaveRoles;
            Action := caFree;
          end
       else
          Action := caFree;
     end;
end;

procedure TEditDefaultJobPanel.qDefaultJobPanelsBeforeScroll(
  DataSet: TDataSet);
begin
  if not canDelete then
    begin
       if not ValidDefaultJobPanel  then
          Abort
       else
       if modified then
          SaveRoles;
    end;
end;

end.
