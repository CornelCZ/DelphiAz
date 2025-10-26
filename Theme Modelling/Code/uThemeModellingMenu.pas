unit uThemeModellingMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts, ExtCtrls,DB, ActnList, ComCtrls, ToolWin,
  ImgList;

type
  TThemeModellingMenu = class(TForm)
    CheckInactiveTimer: TTimer;
    AppEvent: TApplicationEvents;
    MainMenuActions: TActionList;
    SiteSetup: TAction;
    ManageThemes: TAction;
    ManageSharedPanels: TAction;
    SiteProducts: TAction;
    SitePanels: TAction;
    SiteTablePlans: TAction;
    MatchTablePlans: TAction;
    SendToPOS: TAction;
    CloseForm: TAction;
    ImageList1: TImageList;
    lbDynamicMenuWarning: TLabel;
    ManageSiteVariations: TAction;
    ManageSiteThemes: TAction;
    ThemeReports: TAction;
    KeyLines: TAction;
    DriveThruPlan: TAction;
    DeviceSiteSetup: TAction;
    SendTicketImagesToPOS: TAction;
    PromotionalFooters: TAction;
    ManageEstateSetup: TAction;
    TestEQATECException: TAction;
    procedure btSharedPanelsClick(Sender: TObject);
    procedure btnEditTerminalsClick(Sender: TObject);
    procedure CheckInactiveTimerTimer(Sender: TObject);
    procedure AppEventMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseFormExecute(Sender: TObject);
    procedure MainMenuActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure SiteSetupExecute(Sender: TObject);
    procedure ManageThemesExecute(Sender: TObject);
    procedure ManageSharedPanelsExecute(Sender: TObject);
    procedure SiteProductsExecute(Sender: TObject);
    procedure SitePanelsExecute(Sender: TObject);
    procedure SiteTablePlansExecute(Sender: TObject);
    procedure MatchTablePlansExecute(Sender: TObject);
    procedure SendToPOSExecute(Sender: TObject);
    procedure ManageSiteVariationsExecute(Sender: TObject);
    procedure ManageSiteThemesExecute(Sender: TObject);
    procedure ThemeReportsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AppEventException(Sender: TObject; E: Exception);
    procedure KeyLinesExecute(Sender: TObject);
    procedure DriveThruPlanExecute(Sender: TObject);
    procedure DeviceSiteSetupExecute(Sender: TObject);
    procedure SendTicketImagesToPOSExecute(Sender: TObject);
    procedure PromotionalFootersExecute(Sender: TObject);
    procedure ManageEstateSetupExecute(Sender: TObject);
    procedure TestEQATECExceptionExecute(Sender: TObject);
    procedure AppEventShowHint(var HintStr: String; var CanShow: Boolean;
      var HintInfo: THintInfo);
  private
    { Private declarations }
    // <activity variables>
    activityticks, lastactivityticks: cardinal;
    lastactivitytime: TDateTime;
    Finactivity_timeout: TDateTime;
    // </activity variables>
    Function GetApacheDirectory:string;
    Procedure UpdateGraphics;
    procedure ExportBitMapFromSQL(DataSet:TDataSet;FieldName:String;Target:String);
    procedure ShowTerminalEdit(sender: TObject);
    procedure BuildMainMenuButtons;
    procedure AppException(Sender: TObject; E: Exception);
    procedure BuildDynamicMenu;
  public
    ApplicationClosing: boolean;
    function UpdateTills: boolean;
    property inactivity_timeout: TDateTime read Finactivity_timeout;
  end;

var
  ThemeModellingMenu: TThemeModellingMenu;

implementation

uses uThemes, uSharedPanels, uSiteThemes, uOutletTablePlans, uPickSite, UBAseEdit,
  uDMThemeData, adodb, math, uUpdateTerminals, registry, uMatchOutletTablePlans,
  uSiteCustomise, uShowSitePriceReport, uSitePanels, uAztecLog, uSelectServers,
  uADO, useful, uSiteVariations, uProductInPanelReport, uReports,
  uSitePriceReport, uSimpleLocalise, DateUtils, uKeyLines, uEditOutletDriveThru,
  uFormNavigate, uEngDeviceList, uHardwareIcons, uEditChoices,
  uTicketingSendToEPOS, uPromotionalFooter, uMapFooterText, uEstateSetup, uPreviewManager,
  uEQATECMonitor;


{$R *.dfm}

procedure TThemeModellingMenu.btSharedPanelsClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
procedure TThemeModellingMenu.ShowTerminalEdit(sender : TObject);
var
  BaseEdit: TBaseEdit;
begin
  // Ensure any new sites added while Main Menu is displayed are given default
  // site config values
  dmADO.logTime1 := Now;
  dmThemeData.qUpdateNewSiteConfigs.ExecSQL;
  BaseEdit := TBaseEdit.Create(nil);                   
  dmADO.LogDuration('TMMenu TBaseEdit.Create done');
  try
    BaseEdit.FSiteCode := dmthemedata.qOutlets.fieldbyname('SiteCode').asinteger;
    dmADO.updateVirtualServerDeviceLimit(BaseEdit.FSiteCode);
    Nav.MoveForward(BaseEdit, True);
  finally
    //FreeAndNil(BaseEdit);
  end;
end;

//------------------------------------------------------------------------------
procedure TThemeModellingMenu.btnEditTerminalsClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
procedure TThemeModellingMenu.CheckInactiveTimerTimer(Sender: TObject);
begin
  TTimer(Sender).Interval := 100;
  if (LastActivityTime = 0) or ((UpdateTerminals<> nil) and UpdateTerminals.UpdateRunning )
    or (Screen.ActiveForm is TTicketingSendToEPOS) or ((PreviewManager <> nil) and PreviewManager.PreviewRunning ) then
    LastActivityTime := Now;
  if LastActivityTicks <> ActivityTicks then
  begin
    LastActivityTicks := ActivityTicks;
    LastActivityTime := Now;
  end
  else
    if Now-LastActivityTime > (InActivity_Timeout) then
    {after some time of no mouse movement or keyboard input, quit.}
    begin
      if not ApplicationClosing then
      begin
        ApplicationClosing := TRUE;
        // cause a one-time delay of 10 seconds for the inactivity check
        // timer.
        TTimer(sender).Interval := 10000;

        //No prompt in the autosend case
        if not (uUpdateTerminals.DoingThemeAutoSend or uUpdateTerminals.SendingThemeToEmptyPos) then
        begin
          if MessageDlg('Inactivity Warning - This application will close itself in 10 seconds.'+#13+
           'Press NO to stop this and continue with your work.', mtWarning,
              [mbCancel, mbNo], 0) = mrNo then
          begin
            // cancel the auto close process.
            ApplicationClosing := FALSE;
            LastActivityTime := Now;
            TTimer(sender).Interval := 1000;
          end;
        end;
      end
      else
        ApplicationClosing := TRUE;
    end;
  if ApplicationClosing then
  begin
    {kill off all the windows}
    {N.b. the use of "screen.activeform" works for "Save changes?" message
     dialog boxes too, but will not save changes}
    if not Assigned(Screen.Activeform) and not (Application.Terminated) then
    begin
      Application.BringToFront;
      exit;
    end;
    if Assigned(Screen.Activeform) and not (Application.Terminated) then
    begin
      Screen.Activeform.Close;
    end
    else Application.Terminate;
  end;
end;

procedure TThemeModellingMenu.AppEventMessage(var Msg: tagMSG;
  var Handled: Boolean);

begin
  if (Msg.message = WM_MOUSEMOVE) or
     (Msg.message = WM_KEYDOWN) or
     (Msg.message = WM_NCMOUSEMOVE) then
  begin
    {wrap the ticks counter round so as not to cause integer overflow}
    if activityticks = $ffffffff then
      activityticks := 0
    else
      inc(activityticks);
  end;

  if (Msg.message = WM_MOUSEWHEEL)
      and ((Screen.ActiveForm is TSiteThemes) or (Screen.ActiveForm is TSitevariations)
      or (Screen.ActiveForm is TEditChoices) or (Screen.ActiveForm is TBaseEdit)
      or (Screen.ActiveForm is TEstateSetup)) then
  begin
    ConvertMouseWheelMessageToCursorKey(Msg, Handled);
  end;
end;

procedure TThemeModellingMenu.FormShow(Sender: TObject);
begin
  log('Form Show ' + Caption);

  //Only build the menu (including the dunamic buttons) once.
  if Assigned(lbDynamicMenuWarning) then
  begin
    RemoveControl(lbDynamicMenuWarning);
    FreeAndNil(lbDynamicMenuWarning);
    BuildDynamicMenu;
  end;
end;

procedure TThemeModellingMenu.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

procedure TThemeModellingMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
begin
  try
    if (Nav.Level > 0) then
    begin
      Log('Closing forms');
      for i := 1 to Nav.Level do
         Nav.MoveBack();
    end;
  except on E:Exception do
      Log('Exception raised in Closing: '+E.Message);
  end;
  Log('Form Close ' + Caption);
end;

procedure TThemeModellingMenu.ExportBitMapFromSQL(DataSet:TDataSet;FieldName:String;Target:String);
var
  ImageStream : TStream ;

begin
  ImageStream := DataSet.CreateBlobStream(DataSet.FieldByName(FieldName), bmRead);
  try
    ImageStream.Seek(0, soFromBeginning);
    with TFileStream.Create(Target,fmCreate) do
    try
      CopyFrom(ImageStream, ImageStream.Size)
    finally
      Free
    end;
  finally
    ImageStream.Free
  end;
end;

Function TThemeModellingMenu.GetApacheDirectory:string;
begin
  result := EnsureTrailingSlash(GetProgramFilesDir) + 'zonal\aztec\Apache';
end;

Procedure TThemeModellingMenu.UpdateGraphics;
var
  adoqTerminalGraphics,adoqGetBitMap:TADOQuery;
  SiteCode:Integer;
  FileModifiedDate:TDateTime;
  ImageDir, FileName:string;
  FStruct: TOFSTRUCT;
  FileHandle: Integer;
begin
  ImageDir:=EnsureTrailingSlash(GetApacheDirectory)+'htdocs\Images\';
  ForceDirectories(ImageDir);
  try
    adoqTerminalGraphics:=TADOQuery.Create(nil);
    adoqTerminalGraphics.Connection:=dmADO.AztecConn;
    adoqGetBitMap:=TADOQuery.Create(nil);
    adoqGetBitMap.Connection:=dmADO.AztecConn;

    adoqTerminalGraphics.SQL.Clear;
    adoqTerminalGraphics.SQL.text := 'select top 1 [site code] from siteaztec';
    adoqTerminalGraphics.Open;
    sitecode := adoqTerminalGraphics.fieldbyname('site code').asinteger;
    adoqTerminalGraphics.close;

    adoqTerminalGraphics.SQL.Clear;
    adoqTerminalGraphics.SQL.Add('SELECT Graphic.ID, Graphic.[FileName],Graphic.LMDT ');
    adoqTerminalGraphics.SQL.Add(' FROM [dbo].[ThemeConfigSet] ConfigSet, ');
    adoqTerminalGraphics.SQL.Add(' [dbo].[Themeeposdevice] epos, [dbo].[TerminalGraphics] Graphic ');
    adoqTerminalGraphics.SQL.Add(' WHERE ConfigSet.[ConfigSetID]=epos.[ConfigSetID] AND ');
    adoqTerminalGraphics.SQL.Add(' ConfigSet.[GraphicID]= Graphic.[ID] AND epos.[SiteCode]='+inttostr(sitecode));
    adoqTerminalGraphics.SQL.Add(' Union ');
    adoqTerminalGraphics.SQL.Add('SELECT Graphic.ID, Graphic.[FileName],Graphic.LMDT ');
    adoqTerminalGraphics.SQL.Add(' FROM ThemeSites site, ThemePanelDesign Des, ');
    adoqTerminalGraphics.SQL.Add('themePanelHeader head, [dbo].[TerminalGraphics] Graphic ');
    adoqTerminalGraphics.SQL.Add(' WHERE Site.[ThemeID]=Des.[ThemeID] AND ');
    adoqTerminalGraphics.SQL.Add('head.[PanelID]=Des.[root] AND Graphic.[ID] = head.[GraphicID] ');
    adoqTerminalGraphics.SQL.Add(' AND site.[SiteCode] = '+inttostr(sitecode));

    adoqTerminalGraphics.Open;
    adoqTerminalGraphics.First;
    While Not adoqTerminalGraphics.Eof do
    begin
      FileName:=ImageDir+adoqTerminalGraphics.FieldByName('FileName').AsString+'.bmp';
      if FileExists(FileName) then
      begin
        FileHandle := OpenFile(PChar(FileName), FStruct, OF_SHARE_DENY_NONE);
        FileModifiedDate:=FileDateToDateTime(FileGetDate(FileHandle));
        CloseHandle(FileHandle);
        if not WithinPastMilliSeconds(FileModifiedDate,adoqTerminalGraphics.FieldByName('LMDT').AsDateTime,2000) then
          DeleteFile(FileName);
      end;
      if NOT FileExists(FileName) then
      begin
        adoqGetBitMap.SQL.Clear;
        adoqGetBitMap.SQL.Add('Select * From TerminalGraphics Where ID = '+adoqTerminalGraphics.FieldByName('ID').AsString);
        adoqGetBitMap.Open;
        ExportBitMapFromSQL(adoqGetBitMap,'BitMap',FileName);
        adoqGetBitMap.Close;
        FileSetDate(FileName, DateTimeToFileDate(adoqTerminalGraphics.FieldByName('LMDT').AsDateTime));
      end;
      adoqTerminalGraphics.Next;
    end;
  Finally
    FreeAndNil(adoqGetBitMap);
    FreeAndNil(adoqTerminalGraphics);
  End;

end;
procedure TThemeModellingMenu.CloseFormExecute(Sender: TObject);
begin
  Close;
end;

procedure TThemeModellingMenu.MainMenuActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action is TCustomAction then
  Log('User action: ' + TCustomAction(Action).Caption);
end;

procedure TThemeModellingMenu.SiteSetupExecute(Sender: TObject);
begin
  PickSite.SetGridDoubleClick(ShowTerminalEdit, 'Dbl click to Edit Terminal/Print Group Setup');
  Nav.MoveForward(PickSite);
end;

procedure TThemeModellingMenu.ManageThemesExecute(Sender: TObject);
begin
  Nav.MoveForward(Themes);
end;

procedure TThemeModellingMenu.ManageSharedPanelsExecute(Sender: TObject);
begin
  Nav.MoveForward(SharedPanels);
end;

procedure TThemeModellingMenu.SiteProductsExecute(Sender: TObject);
begin
  Nav.MoveForward(SiteCustomise);
end;

procedure TThemeModellingMenu.SitePanelsExecute(Sender: TObject);
begin
  Nav.MoveForward(TSitePanels.Create(nil), True);
end;

procedure TThemeModellingMenu.SiteTablePlansExecute(Sender: TObject);
begin
  Nav.MoveForward(OutletTablePlans);
end;

procedure TThemeModellingMenu.MatchTablePlansExecute(Sender: TObject);
var
  sitecode: integer;
begin
  dmthemedata.adoqRun.SQL.text := 'select top 1 [site code] from siteaztec';
  dmthemedata.adoqRun.Open;
  sitecode := dmthemedata.adoqRun.fieldbyname('site code').asinteger;
  dmthemedata.adoqRun.close;
  dmThemeData.accessdataset('qOutlets');
  dmThemeData.AccessDataset('qThemes');
  dmThemeData.AccessDataset('qSitesInTheme');
  dmThemeData.qOutlets.Locate('SiteCode',SiteCode,[]);

  Matchoutlettableplans.ShowModal;

  dmThemeData.deaccessdataset('qOutlets');
  dmThemeData.deAccessDataset('qThemes');
  dmThemeData.deAccessDataset('qSitesInTheme');
end;

procedure TThemeModellingMenu.SendToPOSExecute(Sender: TObject);
begin
  UpdateTills;
end;

procedure TThemeModellingMenu.ManageSiteVariationsExecute(Sender: TObject);
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text :=
      'if not exists(select * from ThemePanelVariationGroup) '+
      '  select cast(1 as bit) as Result '+
      'else '+
      '  select cast(0 as bit) as Result';
    Open;
    if FieldByName('Result').AsBoolean = true then
    begin
      raise Exception.Create('There are no Panel Variations set up yet.'+#13#10+
        'Please set some up in the Shared Panels screen first.');
    end;
    Close;
  end;
  Nav.MoveForward(SiteVariations);
end;

procedure TThemeModellingMenu.BuildMainMenuButtons;
var
  NewTop, NewLeft, CloseTop, VisibleActionCount: integer;
  TempButton: TButton;
  i: integer;
begin
  NewTop := 0;
  NewLeft := 0;
  CloseTop := 0;
  VisibleActionCount := 0;
  for i := 0 to pred(MainMenuActions.ActionCount) do
    if TAction(MainMenuActions.Actions[i]).Visible then
      Inc(VisibleActionCount);
  for i := 0 to pred(MainMenuActions.ActionCount) do
  begin
    if TAction(MainMenuActions.Actions[i]).Visible and (MainMenuActions[i] <> CloseForm) then
    begin
      TempButton := TButton.Create(self);
      TempButton.Font := self.Font;
      TempButton.Font.Size := 14;
      TempButton.Action := MainMenuActions.Actions[i];
      TempButton.Top := NewTop;
      TempButton.Width := 217;
      TempButton.Left := NewLeft;
      TempButton.Height := 41;
      NewTop := NewTop + TempButton.Height+7;
      TempButton.Parent := Self;
      if (i = Pred(VisibleActionCount div 2)) and (VisibleActionCount > 6) then
      begin
        CloseTop := NewTop;
        NewLeft := 217+7;
        NewTop := 0;
      end;
    end;
  end;
  // Add close button at the bottom
  CloseTop := Max(CloseTop, NewTop);
  TempButton := TButton.Create(self);
  TempButton.Font := self.Font;
  TempButton.Font.Size := 14;
  TempButton.Cancel := true;
  TempButton.Action := CloseForm;
  TempButton.Top := CloseTop;
  TempButton.Width := Clientwidth;
  TempButton.Left := 0;
  TempButton.Height := 41;
  TempButton.Parent := Self;
end;

procedure TThemeModellingMenu.ManageSiteThemesExecute(Sender: TObject);
begin
  Nav.MoveForward(SiteThemes);
end;

procedure TThemeModellingMenu.ThemeReportsExecute(Sender: TObject);
begin
  Nav.MoveForward(Reports);
end;

procedure TThemeModellingMenu.FormCreate(Sender: TObject);
begin
  LocaliseForm(self);
  if EQATECMonitor.IsEQATECEnabled() then
  begin
    TestEQATECException.Visible := EQATECMonitor.TriggerEQATECTestException();
    EQATECMonitor.SetupMonitor(Application.Title);  
    EQATECMonitor.TrackFeatureStart(Application.Title); 
  end;
  Application.OnException := AppException;
end;

procedure TThemeModellingMenu.AppException(Sender: TObject; E: Exception);
begin
   EQATECMonitor.EQATECAppException(Application.Title, E);
   Application.ShowException(E);
end;

procedure TThemeModellingMenu.AppEventException(Sender: TObject;
  E: Exception);
begin
  Log(Format('Exception %s with message %s', [E.ClassName, E.Message]));
  Screen.Cursor := crDefault;
  // NB "Exception" class abused slightly in Theme Modelling to abort operations.
  if E.ClassNameIs('Exception') then
    MessageDlg(E.Message, mtWarning, [mbOk], 0)
  else
    Application.ShowException(E);
end;

function TThemeModellingMenu.UpdateTills: boolean;
var
  saved_iact_timeout: TDateTime;
  SelectedServers: TStringList;
  dummy: TCloseAction;
begin

  Result := false;
  with TADOQuery.Create(self) do
  try
    Connection := dmThemeData.AztecConn;
    SQL.Text := 'select [Overnite Timeout] from PConfigs';
    Open;
    Finactivity_timeout := max(fieldbyname('Overnite Timeout').AsInteger, 5) *
      1/24/60;
    CheckInactiveTimer.enabled := true;
    Close;
  finally
    free;
  end;

  UpdateGraphics;
  // copied from uGlobals "GetLocale" method
  // TODO:  Move this code to uSelectServers

  with TRegistry.create do try
    RootKey := HKEY_CURRENT_USER;
    if OpenKeyReadOnly('Control Panel\International') then
    begin
      if ValueExists('Locale') and (ReadString('Locale') = '00000409') then
        dmThemeData.AztecConn.Execute('update genervar set varstring = ''US'' where varname = ''ukusmode''');
      CloseKey;
    end;
  finally
    free;
  end;

  SelectedServers := TStringList.Create;
  if CheckForMultipleServers(SelectedServers) = mrCancel then
    Exit;

  saved_iact_timeout := inactivity_timeout;

  UpdateTerminals := TUpdateTerminals.Create(Nil);
  try
    Finactivity_timeout := 30.0/24/60;
    UpdateTerminals.SelectedServers.AddStrings(SelectedServers);
    // Don't show update terminals GUI if doing an automated send on Vista
    // TODO: Should actually check if current session is a non interactive one
    if (DoingThemeAutoSend or SendingThemeToEmptyPos)
        and useful.RunningOnVista
        and (useful.GetTerminalServicesSessionID = 0) then
    begin
      if Assigned(UpdateTerminals.OnShow) then
        UpdateTerminals.OnShow(UpdateTerminals);
      UpdateTerminals.ModalResult := mrNone;
      repeat
        Application.HandleMessage;
        if Application.Terminated then UpdateTerminals.ModalResult := mrCancel
        else
          if UpdateTerminals.ModalResult <> mrNone then
            if Assigned(UpdateTerminals.OnClose) then
              UpdateTerminals.OnClose(UpdateTerminals, dummy);
      until UpdateTerminals.ModalResult <> mrNone;
    end
    else
      UpdateTerminals.showmodal;
    Result := (UpdateTerminals.ErrorCount = 0) and not UpdateTerminals.Cancelled;
  finally
    Finactivity_timeout := saved_iact_timeout;
    FreeAndNil(UpdateTerminals);
  end;
end;

procedure TThemeModellingMenu.KeyLinesExecute(Sender: TObject);
begin
  Nav.MoveForward(TKeyLinesForm.Create(nil), True);

{  Screen.Cursor := crHourGlass;
  try
    with TKeyLinesForm.Create(nil) do
    try
      Screen.Cursor := crDefault;
      ShowModal;
    finally
      Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end; }
end;

procedure TThemeModellingMenu.DriveThruPlanExecute(Sender: TObject);
var sitecode : integer;
begin
  dmthemedata.adoqRun.SQL.text := 'select top 1 [site code] from siteaztec';
  dmthemedata.adoqRun.Open;
  sitecode := dmthemedata.adoqRun.fieldbyname('site code').asinteger;
  dmthemedata.adoqRun.close;
  TEditOutletDriveThru.EditOutletDriveThru(sitecode);
end;

procedure TThemeModellingMenu.DeviceSiteSetupExecute(Sender: TObject);
const
  IconSize = 16;
begin
  with TEngDeviceList.Create(nil) do
  try
    dmthemedata.adoqRun.SQL.text := 'select top 1 [site code] from siteaztec';

    dmthemedata.adoqRun.Open;
    FSiteCode := dmthemedata.adoqRun.fieldbyname('site code').asinteger;
    dmthemedata.adoqRun.close;

    dmThemeData.accessdataset('qOutlets');
    dmThemeData.qOutlets.Locate('SiteCode',FSiteCode,[]);

    uHardwareIcons.SetupIconList(dmADO.AztecConn);
    uHardwareIcons.LoadIconImageList(ilDevices, IconSize);
    tvServerDevices.Images := ilDevices;
    if ShowModal = mrOk then
      begin
        dmThemeData.DeAccessDataset('qOutlets');
      end;
  finally
    free;
  end;
end;

procedure TThemeModellingMenu.SendTicketImagesToPOSExecute(
  Sender: TObject);
var
  TicketingSendToEPOS: TTicketingSendToEPOS;
begin
  TicketingSendToEPOS:= TTicketingSendToEPOS.Create(nil);
  Nav.MoveForward(TicketingSendToEPOS, True);
end;

procedure TThemeModellingMenu.PromotionalFootersExecute(Sender: TObject);
begin
  Nav.MoveForward(TPromotionalFooter.Create(self), True);
end;

procedure TThemeModellingMenu.ManageEstateSetupExecute(Sender: TObject);
var
  EstateSetup: TEstateSetup;
begin
  EstateSetup := TEstateSetup.Create(nil);
  Nav.MoveForward(EstateSetup, True);
end;


procedure TThemeModellingMenu.TestEQATECExceptionExecute(Sender: TObject);
begin
   raise Exception.Create('Test EQATEC Exception - Theme Modelling');
end;

procedure TThemeModellingMenu.BuildDynamicMenu;
begin
  if IsMaster then
    dmThemeData.AztecConn.Execute('EXEC dbo.Theme_ApplyAnyFutureSiteVariations');
  with TADOQuery.Create(self) do
  try
    Connection := dmThemeData.AztecConn;
    SQL.Text := 'select [Overnite Timeout] from PConfigs';
    Open;
    Finactivity_timeout := max(fieldbyname('Overnite Timeout').AsInteger, 5) *
      1/24/60;
    // for testing -- set to small timeout
    //Finactivity_timeout := 1/(24*16)/60;
    CheckInactiveTimer.enabled := true;
    Close;
  finally
    free;
  end;
  SiteSetup.Visible := IsMaster;
  ManageEstateSetup.Visible := IsMaster;
  ManageThemes.Visible := IsMaster;
  ManageSharedPanels.Visible := IsMaster;
  ManageSiteVariations.Visible := IsMaster;
  ManageSiteThemes.Visible := IsMaster;
  SiteProducts.Visible := IsSite;

  with dmThemeData.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ac_SiteLicensedFunctionality WHERE DriveThru = 1');
    Open;
    DriveThruPlan.Visible := IsSite and (RecordCount > 0);
  end;

  if (lowercase(dmADO.Logon_Name) <> 'zonaldev') and
     (lowercase(dmADO.Logon_Name) <> 'zonalqa') and
     (lowercase(dmADO.Logon_Name) <> 'zonalhc') and
     (lowercase(dmADO.Logon_Name) <> 'zzcritical') then
         DeviceSiteSetup.Visible := false
     else
         DeviceSiteSetup.Visible := IsSite and not IsMaster;

  SiteTablePlans.Visible := IsSite;
  // don't show on Single site master
  MatchTablePlans.Visible := IsSite and not IsMaster;
  SendToPOS.Visible := IsSite;

  with dmthemeData.adoqRun do
  begin
    SQL.Text :=
      'if OBJECT_ID(''ThemeCloakroomImage'') is not null '+
      '  exec(''select * from ThemeCloakroomImage where ThemeId = (select ThemeId from ThemeSites where SiteCode = dbo.fnGetSiteCode())'')';
    Open;
    SendTicketImagesToPOS.Visible := IsSite and (RecordCount > 0);
    Close;
  end;
  ThemeReports.Visible := IsMaster;
  SitePanels.Visible := IsSite;
  KeyLines.Visible := IsSite;

  //Button creation has to happend after the action visibility settings have been actioned.
  BuildMainMenuButtons;

  dmThemeData.qUpdateNewSiteConfigs.ExecSQL;
end;

procedure TThemeModellingMenu.AppEventShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if HintInfo.HintControl is TPanel then
  begin
    with HintInfo.HintControl as TPanel do
    begin
      if   (Name = 'pnlTwoDrawerMode')
        or (Name = 'pnlCashDrawer') then
        HintInfo.HideTimeout := HintInfo.HideTimeout * 2;
    end;
  end;
end;

end.
