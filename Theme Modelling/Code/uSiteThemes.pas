unit uSiteThemes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, DB,
  Wwdbigrd, Wwdbgrid, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  ADODB, ActnList, wwdblook, uGridSortHelper, Wwdbspin;

type
  TSiteThemes = class(TForm)
    btClose: TButton;
    dbgSitesInTheme: TwwDBGrid;
    dbgSitesNotInTheme: TwwDBGrid;
    dbgTerminalSettings: TwwDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qSiteTheme_ThemeList: TADOQuery;
    ActionList1: TActionList;
    dsSiteTheme_ThemeList: TDataSource;
    cbThemeList: TwwDBLookupCombo;
    ShowForm: TAction;
    HideForm: TAction;
    qSiteTheme_InTheme: TADOQuery;
    dsSiteTheme_InTheme: TDataSource;
    qSiteTheme_NotInTheme: TADOQuery;
    dsSiteTheme_NotInTheme: TDataSource;
    btExcludeSingle: TButton;
    btExcludeAll: TButton;
    btIncludeAll: TButton;
    btIncludeSingle: TButton;
    Label4: TLabel;
    qSiteTheme_TerminalSettings: TADOQuery;
    dsSiteTheme_TerminalSettings: TDataSource;
    btMatchTablePlans: TButton;
    qSiteTheme_PanelDesignList: TADOQuery;
    wwDBLookupCombo2: TwwDBLookupCombo;
    qSiteTheme_TerminalSettingsEposDeviceID: TSmallintField;
    qSiteTheme_TerminalSettingsName: TStringField;
    qSiteTheme_TerminalSettingsPanelDesignID: TIntegerField;
    qSiteTheme_TerminalSettingsDefaultPanelID: TIntegerField;
    qSiteTheme_TerminalSettingsPanelDesignName: TStringField;
    qSiteTheme_DefaultPanelList: TADOQuery;
    qSiteTheme_TerminalSettingsDefaultPanelName: TStringField;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qSiteTheme_DefaultPanelList_All: TADOQuery;
    ShowTablePlanMatchings: TAction;
    ExcludeSingleSite: TAction;
    ExcludeAllSites: TAction;
    IncludeAllSites: TAction;
    IncludeSingleSite: TAction;
    btPreview: TButton;
    SitePreview: TAction;
    qSiteTheme_ThemeListDisplay: TADOQuery;
    btnPanelTimes: TButton;
    qSiteTheme_DefaultCycleList: TADOQuery;
    qSiteTheme_TerminalSettingsDefaultCycleID: TIntegerField;
    qSiteTheme_TerminalSettingsDefaultCycleName: TStringField;
    wwDBLookupCombo3: TwwDBLookupCombo;
    qSiteTheme_DefaultCycleList_All: TADOQuery;
    qSiteTheme_DashboardReportList: TADOQuery;
    qSiteTheme_TerminalSettingsDashboardReprortID: TIntegerField;
    qSiteTheme_TerminalSettingsDashboardTimeout: TIntegerField;
    qSiteTheme_TerminalSettingsDashboardReportName: TStringField;
    qSiteTheme_TerminalSettingsHardwareType: TIntegerField;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwDBSpinEdit1: TwwDBSpinEdit;
    qSiteTheme_DashboardReportList_All: TADOQuery;
    qUpdateMOAPanelDesign: TADOQuery;
    ViewDefaultPanelTimes: TAction;
    qSiteTheme_TerminalSettingsMultiDrawerMode: TBooleanField;
    procedure ShowFormExecute(Sender: TObject);
    procedure HideFormExecute(Sender: TObject);
    procedure qSiteTheme_TerminalSettingsAfterScroll(DataSet: TDataSet);
    procedure qSiteTheme_TerminalSettingsPanelDesignIDChange(
      Sender: TField);
    procedure ShowTablePlanMatchingsExecute(Sender: TObject);
    procedure ExcludeSingleSiteExecute(Sender: TObject);
    procedure ExcludeAllSitesExecute(Sender: TObject);
    procedure IncludeAllSitesExecute(Sender: TObject);
    procedure IncludeSingleSiteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SitePreviewExecute(Sender: TObject);
    procedure SitePreviewUpdate(Sender: TObject);
    procedure cbThemeListCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure dbgTerminalSettingsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure dbgSitesInThemeRowChanged(Sender: TObject);
    procedure dbgTerminalSettingsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure wwDBLookupCombo4CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qSiteTheme_TerminalSettingsAfterPost(DataSet: TDataSet);
    procedure ViewDefaultPanelTimesExecute(Sender: TObject);
    procedure UpdateActiveWhenSitesAvailable(Sender: TObject);
    procedure qSiteTheme_TerminalSettingsPanelDesignIDValidate(
      Sender: TField);
  private
    isLowVersionCycle, isLowVersionDashboard : Boolean;
    SitesInThemeSortHelper: TGridSortHelper;
    SitesNotInThemeSortHelper: TGridSortHelper;
    TerminalSettingsSortHelper: TGridSortHelper;
    { Private declarations }
    procedure UpdateDefaultPanelLookup;
    procedure PopulateDefaultDesigns;
    function isLowVersionSite(ReqDBVer: String): Boolean;
    procedure ToggleDefaultCycle;
    procedure ToggleDashboardSettings;
    procedure ToggleKioskSettings;
    procedure GetPanelDesignForMultiDrawerModeTerminal(
      PanelDesignID: integer; out IsValidPanelDesign: Boolean; out PanelDesignName: String);
  public
    function IsValidDashboardEPoSDevice(EPoSDeviceID : Integer) : Boolean;
  end;

var
  SiteThemes: TSiteThemes;

implementation

uses udmThemeData, uMatchOutletTablePlans, uPreviewManager, uFormNavigate, uEditDefaultPanelCycle, uAztecLog,
  uADO, uDatabaseVersion, uEposDevice;

{$R *.dfm}

procedure TSiteThemes.ShowFormExecute(Sender: TObject);
  function DashboardAvailableToEstate : boolean;
  begin
      with dmADO.qRun do
        begin
          SQL.Clear;
          SQL.Text := 'SELECT ZbsDashboard FROM ac_EstateLicensedFunctionality';
          Open;

          Result := FieldByName('ZbsDashboard').AsBoolean;
        end;
  end;

begin
  PopulateDefaultDesigns;

  if not DashboardAvailableToEstate then
     with dbgTerminalSettings do
        begin
          Selected.Clear;
          ControlType.Clear;

          ControlType.Add('PanelDesignName;CustomEdit;wwDBLookupCombo1;F');
          ControlType.Add('DefaultPanelName;CustomEdit;wwDBLookupCombo2;F');
          ControlType.Add('DefaultCycleName;CustomEdit;wwDBLookupCombo3;F');

          Selected.Add('Name'#9'20'#9'Name'#9'F');
          Selected.Add('PanelDesignName'#9'20'#9'Panel Design'#9'F');
          Selected.Add('DefaultPanelName'#9'30'#9'Default Panel'#9'F');
          Selected.Add('DefaultCycleName'#9'27'#9'Default Cycle Name'#9'F');
          ApplySelected;
        end;

  qSiteTheme_ThemeList.Active := true;
  qSiteTheme_ThemeListDisplay.Active := true;
  qSiteTheme_DefaultCycleList.Active := true;
  qSiteTheme_DefaultPanelList.Active := true;
  qSiteTheme_DashboardReportList.Active := True;
  qSiteTheme_InTheme.Active := true;
  qSiteTheme_NotInTheme.Active := true;
  qSiteTheme_TerminalSettings.Active := true;


  cbThemeList.Text := qSiteTheme_ThemeList.fieldbyname('name').asstring;

  SitesInThemeSortHelper.Reset;
  SitesNotInThemeSortHelper.Reset;
  TerminalSettingsSortHelper.Reset;
end;

procedure TSiteThemes.HideFormExecute(Sender: TObject);
begin
  qSiteTheme_ThemeList.Active := false;
  qSiteTheme_ThemeListDisplay.Active := false;
  qSiteTheme_InTheme.Active := false;
  qSiteTheme_NotInTheme.Active := false;
  qSiteTheme_TerminalSettings.Active := false;

  qSiteTheme_PanelDesignList.active := false;
  qSiteTheme_DefaultPanelList.active := false;
  qSiteTheme_DefaultPanelList_All.Active := false;
  qSiteTheme_DefaultCycleList.Active := false;

  qSiteTheme_DashboardReportList.Active := False;
end;

procedure TSiteThemes.qSiteTheme_TerminalSettingsAfterScroll(
  DataSet: TDataSet);
begin
  UpdateDefaultPanelLookup;
  dbgTerminalSettings.Enabled := dbgTerminalSettings.datasource.dataset.recordcount > 0;
  ToggleDashboardSettings;
end;

procedure TSiteThemes.qSiteTheme_TerminalSettingsPanelDesignIDChange(
  Sender: TField);
begin
  UpdateDefaultPanelLookup;
  // Clear any references to specific panels within old panel design
  if qSiteTheme_TerminalSettingsDefaultPanelID.AsInteger >= 100000 then
    qSiteTheme_TerminalSettingsDefaultPanelID.Clear;

  if not VarIsNull(qSiteTheme_TerminalSettingsDefaultCycleID.Value) then
    qSiteTheme_TerminalSettingsDefaultCycleID.Clear;
end;

procedure TSiteThemes.UpdateDefaultPanelLookup;
begin
  qSiteTheme_DefaultCycleList.SQL[1] := Format('set @paneldesignid = %d', [
    qSiteTheme_TerminalSettings.FieldByName('PanelDesignID').AsInteger
  ]);
  qSiteTheme_DefaultCycleList.Active := true;

  qSiteTheme_DefaultPanelList.SQL[2] := Format('set @paneldesignid = %d', [
    qSiteTheme_TerminalSettings.FieldByName('PanelDesignID').AsInteger
  ]);
  qSiteTheme_DefaultPanelList.Active := true;

  qSiteTheme_DashboardReportList.Active := True;
end;

procedure TSiteThemes.ShowTablePlanMatchingsExecute(Sender: TObject);
begin
  MatchOutletTablePlans.Caption := 'View Matched Table Plans';
  MatchOutletTablePlans.SiteCode := qSiteTheme_InTheme.FieldByName('SiteCode').AsInteger;
  MatchOutletTablePlans.ThemeID := qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger;
  MatchOutletTablePlans.Showmodal;
end;

procedure TSiteThemes.ExcludeSingleSiteExecute(Sender: TObject);
begin
  if MessageDlg(Format('Site "%s" will be unassigned from theme "%s".  All variation details' + #13#10 +
    'and panel design details for this site will be removed.' + #13#10 + #13#10 +
    'Do you wish to continue?', [qSiteTheme_InTheme.FieldByName('Site Name').AsString,
                                 qSiteTheme_ThemeList.FieldByName('Name').AsString]), mtWarning, [mbYes, mbNo], 0) = mrNo then
    Exit;

  if qSiteTheme_InTheme.RecordCount = 0 then
    Exit;
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('DELETE ThemeEposDesign WHERE SiteCode = %d', [qSiteTheme_InTheme.FieldByName('SiteCode').AsInteger]);
    ExecSQL;
    SQL.Text := Format('DELETE ThemeSites WHERE SiteCode = %d', [qSiteTheme_InTheme.FieldByName('SiteCode').AsInteger]);
    ExecSQL;
  end;
  qSiteTheme_InTheme.Requery;
  qSiteTheme_NotInTheme.Requery;
end;

procedure TSiteThemes.ExcludeAllSitesExecute(Sender: TObject);
begin
  if MessageDlg(Format('All sites will be unassigned from theme "%s".  All variation details' + #13#10 +
    'and panel design details for these sites will be removed.' + #13#10 + #13#10 +
    'Do you wish to continue?', [qSiteTheme_ThemeList.FieldByName('Name').AsString]), mtWarning, [mbYes, mbNo], 0) = mrNo then
    Exit;

  if qSiteTheme_InTheme.RecordCount = 0 then
    Exit;
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('DELETE ThemeEposDesign WHERE SiteCode IN (SELECT SiteCode FROM ThemeSites WHERE ThemeID = %d)', [qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger]);
    ExecSQL;
    SQL.Text := Format('DELETE ThemeSites WHERE ThemeID = %d', [qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger]);
    ExecSQL;
  end;
  qSiteTheme_InTheme.Requery;
  qSiteTheme_NotInTheme.Requery;
end;

procedure TSiteThemes.IncludeAllSitesExecute(Sender: TObject);
begin
  if qSiteTheme_NotInTheme.RecordCount = 0 then
    Exit;
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('INSERT ThemeSites (SiteCode, ThemeID) '+
      'SELECT [Site Code], %d FROM SiteAztec '+
      'WHERE [Site Code] NOT IN (SELECT SiteCode FROM ThemeSites) '+
      'AND (Deleted IS NULL OR Deleted = ''N'')',
      [qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger]);
    ExecSQL;
  end;
  PopulateDefaultDesigns;
  qSiteTheme_InTheme.Requery;
  qSiteTheme_NotInTheme.Requery;
end;

procedure TSiteThemes.IncludeSingleSiteExecute(Sender: TObject);
begin
  if qSiteTheme_NotInTheme.RecordCount = 0 then
    Exit;
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('INSERT ThemeSites (SiteCode, ThemeID) SELECT %d, %d', [
      qSiteTheme_NotInTheme.FieldByName('SiteCode').AsInteger,
      qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger
    ]);
    ExecSQL;
  end;
  PopulateDefaultDesigns;
  qSiteTheme_InTheme.Requery;
  qSiteTheme_NotInTheme.Requery;
end;

procedure TSiteThemes.PopulateDefaultDesigns;
begin
  try
    dmThemeData.qSetDefaultEposDesign.ExecSQL;
  except
  end;
end;

procedure TSiteThemes.FormCreate(Sender: TObject);
begin
  SitesInThemeSortHelper := TGridSortHelper.create;
  SitesInThemeSortHelper.Initialise(dbgSitesInTheme);
  SitesNotInThemeSortHelper := TGridSortHelper.create;
  SitesNotInThemeSortHelper.Initialise(dbgSitesNotInTheme);
  TerminalSettingsSortHelper := TGridSortHelper.create;
  TerminalSettingsSortHelper.Initialise(dbgTerminalSettings);
end;

procedure TSiteThemes.btCloseClick(Sender: TObject);
begin
  if qSiteTheme_TerminalSettings.State = dsEdit then
    qSiteTheme_TerminalSettings.Post;
  ModalResult := mrOk;
  Close;
end;

procedure TSiteThemes.FormDestroy(Sender: TObject);
begin
  SitesInThemeSortHelper.Free;
  SitesNotInThemeSortHelper.Free;
  TerminalSettingsSortHelper.Free;
end;

procedure TSiteThemes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Nav.MoveBack;
end;

procedure TSiteThemes.SitePreviewExecute(Sender: TObject);
var
  SiteCode, EposDeviceID, SalesAreaID, POSCode: integer;
begin
  if qSiteTheme_TerminalSettings.State = dsEdit then
    qSiteTheme_TerminalSettings.Post;
    
  SiteCode := dbgSitesInTheme.datasource.dataset.FieldByName('SiteCode').AsInteger;
  EposDeviceID := dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger;

  dmThemeData.GetSalesAreaAndPOSCode(SiteCode, EposDeviceID, SalesAreaID, POSCode);
  PreviewManager.AddPreviewRequest(
    SiteCode,
    SalesAreaID,
    POSCode,
    dbgTerminalSettings.datasource.dataset.FieldByName('PanelDesignID').AsInteger
  );
end;

procedure TSiteThemes.SitePreviewUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    (dbgTerminalSettings.DataSource.DataSet.RecordCount > 0) and
    not (qSiteTheme_TerminalSettings.FieldByName('HardwareType').AsInteger in [Ord(ehtKiosk), Ord(ehtMobileOrdering), Ord(ehtMOAOrderPad), Ord(ehtiZoneTables)]);
end;

procedure TSiteThemes.cbThemeListCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if modified then
  begin
    qSiteTheme_ThemeList.Locate('ThemeID', LookupTable.fieldbyname('ThemeID').AsInteger, []);
    ToggleDefaultCycle;
    ToggleDashboardSettings;
  end;
end;

function TSiteThemes.isLowVersionSite(ReqDBVer : String) : Boolean;
var
  DBVer, DBRequiredVer : TDatabaseVersion;
begin
  Result := False;

  if (qSiteTheme_InTheme.RecordCount = 0) then
    Exit;

  with dmADO.qRun do
    begin
      Close;
      SQL.Text:= Format('SELECT DBVersion FROM CommsVersions WHERE SiteCode = %s', [qSiteTheme_InTheme.FieldByName('SiteCode').AsString]);
      Open;

      // If the site is not in CommsVersions then skip the version check because the blank
      // version raises an assertion exception.  Still need to return TRUE so that the Default
      // Time Cycle dropdown is disabled because the site's actual version is unknown
      if (FieldByName('DBVersion').AsString = '') then
      begin
        Result := TRUE;
        Exit;
      end;

      DBRequiredVer := TDatabaseVersion.Create(ReqDBVer);
      DBVer := TDataBaseVersion.Create(FieldByName('DBVersion').AsString);
      // if the returned DBVersion is less than the required version then the result will
      // return false.

      if DBVer.IsLowerThan(DBRequiredVer) then
         Result := True;

      DBVer.Free;
    end;
end;

procedure TSiteThemes.dbgTerminalSettingsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  IsiServeiOrder: Boolean;
  IsiServeIOrderKiosk: Boolean;
  HardwareType: TEPOSHardwareType;
begin
  if (Field.FieldName = 'DefaultCycleName')  then
     begin
       if isLowVersionCycle then
          ABrush.Color := clBtnFace
     end;

  if (Field.FieldName = 'DashboardReportName') or (Field.FieldName = 'DashboardTimeout') then
     begin
       if (isLowVersionDashboard) or (not IsValidDashboardEPoSDevice(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger)) then
          ABrush.Color := clBtnFace
     end;

  if (dbgTerminalSettings.DataSource.DataSet.FieldByName('DashboardReportName').AsString = '<No Inactivity Report>') and (Field.FieldName = 'DashboardTimeout') then
     ABrush.Color := clBtnFace;

  HardwareType := TEposDevice.GetHardwareType(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger);
  IsiServeIOrder := HardwareType in [ehtMobileOrdering, ehtMOAOrderPad];
  IsiServeIOrderKiosk := HardwareType in [ehtKiosk, ehtMobileOrdering, ehtMOAOrderPad];
  if IsiServeIOrder then
    AFont.Color := clGrayText
  else if IsiServeIOrderKiosk and (Field.FieldName <> 'PanelDesignName') then
    AFont.Color := clGrayText
end;

procedure TSiteThemes.dbgSitesInThemeRowChanged(Sender: TObject);
begin
  ToggleDefaultCycle;
  ToggleDashboardSettings;
end;

procedure TSiteThemes.dbgTerminalSettingsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  gridpos: TGridCoord;
begin
  dbgTerminalSettings.ShowHint := FALSE;
  dbgTerminalSettings.Hint := '';
  gridpos := TwwdbGrid(Sender).MouseCoord(X,Y);
  if (gridpos.X = 3) then
    if not wwDBLookUpCombo3.Enabled then
    begin
      dbgTerminalSettings.ShowHint := TRUE;
      dbgTerminalSettings.Hint :=
        'This feature is disabled because either the' + #13#10 +
        'Site version is less than 3.4 or a comms job ' + #13#10 +
        'should be sent to the site.';
    end;

end;

procedure TSiteThemes.ToggleDefaultCycle;
begin
  isLowVersionCycle := isLowVersionSite('3.4.0.0');
  wwDBLookupCombo3.Enabled := not isLowVersionSite('3.4.0.0');
end;

procedure TSiteThemes.ToggleDashboardSettings;
begin
  isLowVersionDashboard := isLowVersionSite('3.5.1.0');


  if qSiteTheme_TerminalSettings.Active then
     begin
       wwDBLookupCombo4.Enabled := not isLowVersionDashboard and ( IsValidDashboardEPoSDevice(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger));
       wwDBSpinEdit1.Enabled := not isLowVersionDashboard and ( IsValidDashboardEPoSDevice(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger));
     end;
  wwDBSpinEdit1.Enabled := not (wwDBLookupCombo4.Text = '<No Inactivity Report>');
  ToggleKioskSettings;
end;

procedure TSiteThemes.ToggleKioskSettings;
var
  IsiServeiOrder: Boolean;
  ISiServeIOrderKiosk: Boolean;
begin
  if qSiteTheme_TerminalSettings.Active then
  begin
    dbgTerminalSettings.ControlType.Clear;

    IsiServeiOrder := (TEposDevice.GetHardwareType(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger) in [ehtMobileOrdering, ehtMOAOrderPad]);
    IsiServeIOrderKiosk := (TEposDevice.GetHardwareType(dbgTerminalSettings.DataSource.DataSet.FieldByName('EposDeviceID').AsInteger) in [ehtKiosk, ehtMobileOrdering, ehtMOAOrderPad]);

    qSiteTheme_TerminalSettingsPanelDesignName.ReadOnly := IsiServeiOrder;
    if not IsiServeiOrder then
      dbgTerminalSettings.ControlType.Add('PanelDesignName;CustomEdit;wwDBLookupCombo1;F');

    qSiteTheme_TerminalSettingsDefaultPanelName.ReadOnly := ISiServeIOrderKiosk;
    qSiteTheme_TerminalSettingsDefaultCycleName.ReadOnly := ISiServeIOrderKiosk;
    qSiteTheme_TerminalSettingsDashboardReportName.ReadOnly := ISiServeIOrderKiosk;
    qSiteTheme_TerminalSettingsDashboardTimeout.ReadOnly := ISiServeIOrderKiosk;
    if not ISiServeIOrderKiosk then
    begin
      dbgTerminalSettings.ControlType.Add('DefaultPanelName;CustomEdit;wwDBLookupCombo2;F');
      dbgTerminalSettings.ControlType.Add('DefaultCycleName;CustomEdit;wwDBLookupCombo3;F');
      dbgTerminalSettings.ControlType.Add('DashboardReportName;CustomEdit;wwDBLookupCombo4;F');
      dbgTerminalSettings.ControlType.Add('DashboardTimeout;CustomEdit;wwDBSpinEdit1;F');
    end
  end;
end;

procedure TSiteThemes.wwDBLookupCombo4CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if dsSiteTheme_TerminalSettings.State = dsEdit then
     begin
       if wwDBLookupCombo4.Text = '<No Inactivity Report>' then
          begin
            qSiteTheme_TerminalSettingsDashboardTimeout.Clear;
            wwDBSpinEdit1.Enabled := False;
          end
       else
          begin
            wwDBSpinEdit1.Enabled := True;
            if qSiteTheme_TerminalSettingsDashboardTimeout.AsInteger = 0 then
               qSiteTheme_TerminalSettingsDashboardTimeout.AsInteger := 5;
         end;
    end;
end;

function TSiteThemes.IsValidDashboardEPoSDevice(EPoSDeviceID : Integer) : Boolean;
begin
 if TEposDevice.GetHardwareType(EPoSDeviceID) in [ehtZ500, ehti700, ehtZonalZ9] then
     Result := True
  else
     Result := False;
end;

procedure TSiteThemes.qSiteTheme_TerminalSettingsAfterPost(DataSet: TDataSet);
var
  SalesAreaID, POSCode: integer;
begin
  if not (TEposDevice.GetHardwareType(qSiteTheme_TerminalSettingsEposDeviceID.Value) = ehtMobileOrdering) then
    exit;

  // update all MOA terminals in the sales area with the panel design
  dmThemeData.GetSalesAreaAndPOSCode(qSiteTheme_InTheme.FieldByName('SiteCode').AsInteger,
                 qSiteTheme_TerminalSettingsEposDeviceID.AsInteger, SalesAreaID, POSCode);
  qUpdateMOAPanelDesign.Parameters[0].Value := qSiteTheme_InTheme.FieldByName('SiteCode').Value;
  qUpdateMOAPanelDesign.Parameters[1].Value := qSiteTheme_TerminalSettingsPanelDesignID.Value;
  qUpdateMOAPanelDesign.Parameters[2].Value := SalesAreaID;
  qUpdateMOAPanelDesign.Parameters[3].Value := qSiteTheme_TerminalSettingsEposDeviceID.Value;
  qUpdateMOAPanelDesign.ExecSQL;
end;

procedure TSiteThemes.ViewDefaultPanelTimesExecute(Sender: TObject);
begin
  with TEditDefaultPanelCycle.Create(nil) do
  try
    FPanelDesignID := dbgTerminalSettings.datasource.dataset.FieldByName('PanelDesignID').AsInteger;
    FThemeID := qSiteTheme_ThemeList.FieldByName('ThemeID').AsInteger;
    Log('Default Panel Times opened.');
    if ShowModal = mrOK then
       begin
         //Refresh the cycle lists.
         qSiteTheme_DefaultCycleList_All.Close;
         qSiteTheme_DefaultCycleList_All.Open;
         qSiteTheme_DefaultCycleList.Close;
         qSiteTheme_DefaultCycleList.Open;
         qSiteTheme_TerminalSettings.Close;
         qSiteTheme_TerminalSettings.Open;

         Log('Default Panel Times closed.');
       end;
  finally
    free;
  end;
end;

procedure TSiteThemes.UpdateActiveWhenSitesAvailable(Sender: TObject);
begin
  TAction(Sender).Enabled := dsSiteTheme_InTheme.DataSet.RecordCount > 0;
end;

procedure TSiteThemes.GetPanelDesignForMultiDrawerModeTerminal(PanelDesignID: integer;
  out IsValidPanelDesign: Boolean; out PanelDesignName: String);
begin
  with dmADo.qRun do
  begin
    SQL.Clear;
    SQL.Add('select cast(case when PanelDesignType in (1,3) then 0 else 1 end as bit) as ValidPanelDesignType, Name as PanelDesignName');
    SQL.Add('from ThemePanelDesign tpd');
    SQL.Add(Format('where tpd.PanelDesignID = %d',[PanelDesignID]));
    Open;
    if not EOF then
    begin
      IsValidPanelDesign := FieldByName('ValidPanelDesignType').AsBoolean;
      PanelDesignName := FieldByName('PanelDesignName').AsString;
    end;
  end;
end;

procedure TSiteThemes.qSiteTheme_TerminalSettingsPanelDesignIDValidate(
  Sender: TField);
var
  IsValidPanelDesign: Boolean;
  PanelDesignName: String;
begin
  if qSiteTheme_TerminalSettingsMultiDrawerMode.AsBoolean = True then
  begin
    GetPanelDesignForMultiDrawerModeTerminal(Sender.Value, IsValidPanelDesign, PanelDesignName);
    if not IsValidPanelDesign then
    begin
      MessageDlg(Format('Terminal "%s" is using two drawer mode and is not compatible with panel design "%s".' + #10#13#10#13 +
                        'Terminals using two drawer mode cannot be assigned "Z300" or "Handheld" panel design types.',
                        [qSiteTheme_TerminalSettingsName.AsString, PanelDesignName]),
                 mtError,
                 [mbOK],
                 0);
      dbgTerminalSettings.SetActiveField('PanelDesignName');
      Abort;
    end;
  end;
end;

end.
