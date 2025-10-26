unit FrmEventsMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, WmiAbstract,
  WmiComponent, WmiSystemEvents, FrmAboutU, FrmNewHostU, DetectWinOS,
  Buttons;

type

  TWmiEventType = (
    wetEventLogApplication,
    wetEventLogSystem,
    wetEventLogSecurity,
    wetUserAccount,
    wetGroupAccount,
    wetGroupMembership,
    wetNetworkConnect,
    wetNetworkDisconnect,
    wetPrinter,
    wetPrintJob,
    wetSessionLogon,
    wetSessionLogoff,
    wetCDROMInserted,
    wetCDROMEjected,
    wetService,
    wetDocking);


  TFrmEventsMain = class(TForm)
    ToolBar1: TToolBar;
    tlbNewHost: TToolButton;
    ToolButton1: TToolButton;
    tlbAbout: TToolButton;
    tvBrowser: TTreeView;
    Splitter1: TSplitter;
    ilToolbar: TImageList;
    pcMain: TPageControl;
    tsWatch: TTabSheet;
    tsSetup: TTabSheet;
    WmiSystemEvents1: TWmiSystemEvents;
    GroupBox1: TGroupBox;
    chbApplication: TCheckBox;
    chbSystem: TCheckBox;
    chbSecurity: TCheckBox;
    GroupBox2: TGroupBox;
    chbUser: TCheckBox;
    chbGroup: TCheckBox;
    chbMembership: TCheckBox;
    GroupBox3: TGroupBox;
    chbConnect: TCheckBox;
    chbDisconnect: TCheckBox;
    GroupBox4: TGroupBox;
    chbLogon: TCheckBox;
    chbLogoff: TCheckBox;
    GroupBox5: TGroupBox;
    chbPrinter: TCheckBox;
    chbJob: TCheckBox;
    GroupBox6: TGroupBox;
    chbCDROMInserted: TCheckBox;
    chbCDROMEjected: TCheckBox;
    GroupBox7: TGroupBox;
    chbService: TCheckBox;
    chbDocking: TCheckBox;
    tsAdvanced: TTabSheet;
    memSetup: TMemo;
    pnlTop: TPanel;
    lblNameSpace: TLabel;
    cmnNameSpaces: TComboBox;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    memQuery: TMemo;
    Label1: TLabel;
    Panel1: TPanel;
    chbSoundOnEvent: TCheckBox;
    btnClear: TButton;
    lvWatch: TListView;
    sbRegisterQuery: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure tvBrowserExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvBrowserChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tlbNewHostClick(Sender: TObject);
    procedure tvBrowserChange(Sender: TObject; Node: TTreeNode);
    procedure tlbAboutClick(Sender: TObject);
    procedure chbConnectClick(Sender: TObject);
    procedure chbDisconnectClick(Sender: TObject);
    procedure chbApplicationClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure chbSystemClick(Sender: TObject);
    procedure chbSecurityClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure chbUserClick(Sender: TObject);
    procedure chbGroupClick(Sender: TObject);
    procedure chbMembershipClick(Sender: TObject);
    procedure chbPrinterClick(Sender: TObject);
    procedure chbJobClick(Sender: TObject);
    procedure chbLogonClick(Sender: TObject);
    procedure chbLogoffClick(Sender: TObject);
    procedure chbServiceClick(Sender: TObject);
    procedure chbDockingClick(Sender: TObject);
    procedure chbCDROMInsertedClick(Sender: TObject);
    procedure chbCDROMEjectedClick(Sender: TObject);
    procedure sbRegisterQueryClick(Sender: TObject);
  private
    FStoredCursor: TCursor;
    procedure InitItems;
    function  ProcessNodeExpanding(ANode: TTreeNode): boolean;
    function  LoadRemoteHosts(ANode: TTreeNode): boolean;
    procedure ProcessChangingNode(Node: TTreeNode);
    procedure SetWaitCursor;
    procedure RestoreCursor;
    function  DoConnect(ANode: TTreeNode): boolean;
    procedure SetFormCaption;
    procedure CreateNewNetworkNode;
    procedure SetButtonState;
    function  FindNeworkNode: TTreeNode;
    function GetMachineName: string;

    procedure SoundOnEvent;
    procedure AddEventRecord(AText: string);
    procedure RegisterEvent(AEventType: TWmiEventType; IfRegister: boolean);

    procedure OnNetworkConnected(ASender: TObject);
    procedure OnNetworkDisconnected(ASender: TObject);
    procedure OnEventLogApplication(ASender: TObject; Instance: OleVariant;
      EventLog, AMessage: WideString);
    procedure OnEventLogSecurity(ASender: TObject; Instance: OleVariant;
      EventLog, AMessage: WideString);
    procedure OnEventLogSystem(ASender: TObject; Instance: OleVariant;
      EventLog, AMessage: WideString);
    procedure OnUserAccount(ASender: TObject; Instance: OleVariant; Name,
      Domain: WideString; Action: TWmiEventAction);
    procedure OnGroupAccount(ASender: TObject; Instance: OleVariant; Name,
      Domain: WideString; Action: TWmiEventAction);
    procedure OnGroupMembership(ASender: TObject; Instance: OleVariant;
      AGroupName, AGroupDomain, AUserName, AUserDomain: WideString;
      Action: TWmiEventAction);
    procedure OnPrinter(ASender: TObject; Instance: OleVariant;
      Name: WideString; Action: TWmiEventAction);
    procedure OnPrintJob( ASender: TObject;
                          Instance: OleVariant;
                          Document: widestring;
                          JobID: integer;
                          JobStatus: widestring;
                          Action: TWmiEventAction);
    procedure OnUserLogon(ASender: TObject;
         LogonId, Name, Domain: WideString);
    procedure OnUserLogoff(ASender: TObject;
         LogonId, Name, Domain: WideString);
    procedure OnService(ASender: TObject; Instance: OleVariant;
         AServiceName, AState: WideString; Action: TWmiEventAction);
    procedure OnDocking(ASender: TObject);
    procedure OnCDROMInserted(ASender: TObject; Instance: OleVariant; ADrive: widestring);
    procedure OnCDROMEjected(ASender: TObject; Instance: OleVariant; ADrive: widestring);
    procedure OnCustomEvent(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
  public
    { Public declarations }
  end;


  // this class keeps user's credentials for host.
  TCredentials = class
  private
    FUserName: widestring;
    FPassword: widestring;
  public
    constructor Create(AUserName, APassword: widestring);

    property UserName: widestring read FUserName;
    property Password: widestring read FPassword;
  end;

var
  FrmEventsMain: TFrmEventsMain;

implementation

{$R *.dfm}

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';
  CNST_CAPTION = 'Watch for events on ';

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;


procedure TFrmEventsMain.FormCreate(Sender: TObject);
begin
  pcMain.ActivePage := tsSetup;
  InitItems;
  WmiSystemEvents1.Active := true;
  chbLogon.Enabled := IsWindowsXPOrHigher;
  chbLogoff.Enabled := chbLogon.Enabled;
  chbDocking.Enabled := chbLogon.Enabled;
end;


procedure TFrmEventsMain.InitItems;
var
  vItem: TTreeNode;
begin
  tvBrowser.Items.Add(nil, LOCAL_HOST);
  vItem := tvBrowser.Items.Add(nil, NETWORK);
  tvBrowser.Items.AddChild(vItem, NO_DATA);
end;

procedure TFrmEventsMain.tvBrowserExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  AllowExpansion := ProcessNodeExpanding(Node);
end;


function TFrmEventsMain.ProcessNodeExpanding(ANode: TTreeNode): boolean;
begin
  Result := true;
  if (ANode.Count = 1) and (ANode.getFirstChild.Text = NO_DATA) then
  begin
    Result := false;
    if (ANode.Text = NETWORK) then Result := LoadRemoteHosts(ANode)
  end
end;

function TFrmEventsMain.LoadRemoteHosts(ANode: TTreeNode): boolean;
var
  AList: TStrings;
  i: integer;
begin
  ANode.DeleteChildren;
  AList := TStringList.Create;
  SetWaitCursor;
  try
    WmiSystemEvents1.ListServers(AList);
    for i := 0 to AList.Count - 1 do
    begin
      tvBrowser.Items.AddChild(ANode, AList[i]);
    end;
  finally
    AList.Free;
    RestoreCursor;
  end;
  Result := true;
end;


procedure TFrmEventsMain.tvBrowserChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  ProcessChangingNode(Node);
end;

procedure TFrmEventsMain.ProcessChangingNode(Node: TTreeNode);
var
  vCredentials: TCredentials;
begin
  if Node.Text = LOCAL_HOST then
  begin
    DoConnect(Node);
  end else
  if Node.Text = NETWORK then
  begin
    WmiSystemEvents1.Active := false;
  end else
  begin
    vCredentials := TCredentials (Node.Data);
    if vCredentials <> nil then DoConnect(Node);
  end;
  SetFormCaption;
end;

procedure TFrmEventsMain.SetWaitCursor;
begin
  FStoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TFrmEventsMain.RestoreCursor;
begin
  Screen.Cursor := FStoredCursor;
end;

function TFrmEventsMain.DoConnect(ANode: TTreeNode): boolean;
var
  vCredentials: TCredentials;
  vForm: TFrmNewHost;
begin
  Result := false;

  // do not reconnect if already connected to desired host. 
  if (ANode.Text = WmiSystemEvents1.MachineName) and
     (WmiSystemEvents1.Active) then
  begin
    Result := true;
    Exit;
  end;

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for credentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  SetWaitCursor;
  try
    WmiSystemEvents1.Active := false;
    if ANode.Text = LOCAL_HOST then
    begin
      // connect to local host;
      WmiSystemEvents1.Credentials.Clear;
      WmiSystemEvents1.MachineName := '';
      WmiSystemEvents1.Active := true;
      Result := true;
    end else
    begin
      if (ANode.Data = nil) then
      begin
        // connect for the first time
        // try default credentials fisrt:
        try
          WmiSystemEvents1.Credentials.Clear;
          WmiSystemEvents1.MachineName := ANode.Text;
          WmiSystemEvents1.Active := true;
          Result := true;
        except
          // expected exception: the credentials are not valid
        end;

        // default credentials did not work.
        // try to connect with user's provided credentials
        if not WmiSystemEvents1.Active then
        begin
          vForm := TFrmNewHost.Create(nil);
          vForm.MachineName := ANode.Text;
          try
            while vForm.ShowModal = mrOk do
              try
                WmiSystemEvents1.Active := false;
                WmiSystemEvents1.Credentials.Clear;
                WmiSystemEvents1.MachineName := ANode.Text;
                WmiSystemEvents1.Credentials.UserName := vForm.UserName;
                WmiSystemEvents1.Credentials.Password := vForm.edtPassword.Text;
                WmiSystemEvents1.Active := true;

                // connected successfully; remember credentials
                ANode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
                Result := true;
                Break;
              except
                on e: Exception do
                  Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
              end;
          finally
            vForm.Free;
          end;
        end;
      end else
      begin

        // reconnect with existing credentials
        vCredentials := TCredentials (ANode.Data);
        WmiSystemEvents1.MachineName := ANode.Text;
        WmiSystemEvents1.Credentials.UserName := vCredentials.UserName;
        WmiSystemEvents1.Credentials.Password := vCredentials.Password;
        WmiSystemEvents1.Active := true;
        Result := true;
      end;
    end;
  finally
    RestoreCursor;
  end;
end;

function TFrmEventsMain.GetMachineName: string;
begin
  if WmiSystemEvents1.MachineName <> '' then
    Result := WmiSystemEvents1.MachineName
    else Result := LOCAL_HOST;
end;

procedure TFrmEventsMain.SetFormCaption;
begin
  if WmiSystemEvents1.Active then
  begin
    Caption := CNST_CAPTION + GetMachineName;
  end else
  begin
    Caption := 'System Events Viewer';
  end;
end;

procedure TFrmEventsMain.tlbNewHostClick(Sender: TObject);
begin
  CreateNewNetworkNode;
  SetButtonState;
end;

procedure TFrmEventsMain.SetButtonState;
begin
end;

procedure TFrmEventsMain.CreateNewNetworkNode;
var
  vForm: TFrmNewHost;
  vNode: TTreeNode;
begin
  vForm := TFrmNewHost.Create(nil);
  try
    while vForm.ShowModal = mrOk do
      try

        WmiSystemEvents1.Active := false;
        WmiSystemEvents1.Credentials.Clear;
        WmiSystemEvents1.MachineName := vForm.edtHostName.Text;
        WmiSystemEvents1.Credentials.UserName := vForm.UserName;
        WmiSystemEvents1.Credentials.Password := vForm.edtPassword.Text;
        WmiSystemEvents1.Active := true;

        // connected successfully; add the new host to a list.
        vNode := FindNeworkNode;
        if (vNode.getFirstChild <> nil) and
           (vNode.getFirstChild.Text = NO_DATA) then vNode.DeleteChildren;

        vNode := tvBrowser.Items.AddChild(vNode, vForm.edtHostName.Text);
        vNode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
        tvBrowser.Selected := vNode;
        Break;

      except
        on e: Exception do
          Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
      end;
  finally
    vForm.Free;
  end;
end;

function TFrmEventsMain.FindNeworkNode: TTreeNode;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to tvBrowser.Items.Count - 1 do
    if tvBrowser.Items[i].Text = NETWORK then
    begin
      Result := tvBrowser.Items[i];
      Exit;
    end;
end;

procedure TFrmEventsMain.tvBrowserChange(Sender: TObject; Node: TTreeNode);
begin
  SetButtonState;
end;

procedure TFrmEventsMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmEventsMain.chbConnectClick(Sender: TObject);
begin
  RegisterEvent(wetNetworkConnect, chbConnect.Checked);
end;

procedure TFrmEventsMain.AddEventRecord(AText: string);
var
  vItem: TListItem;
begin
  SoundOnEvent;
  vItem := lvWatch.Items.Add;
  vItem.Caption := AText;
end;

procedure TFrmEventsMain.OnNetworkConnected(ASender: TObject);
begin
  AddEventRecord('Network adapter is now connected');
end;

procedure TFrmEventsMain.OnNetworkDisconnected(ASender: TObject);
begin
  AddEventRecord('Network adapter was disconnected');
end;

procedure TFrmEventsMain.SoundOnEvent;
begin
  if chbSoundOnEvent.Checked then Beep;
end;


procedure TFrmEventsMain.chbDisconnectClick(Sender: TObject);
begin
  RegisterEvent(wetNetworkDisconnect, chbDisconnect.Checked);
end;

procedure TFrmEventsMain.chbApplicationClick(Sender: TObject);
begin
  RegisterEvent(wetEventLogApplication, chbApplication.Checked);
end;

procedure TFrmEventsMain.OnEventLogApplication(ASender: TObject; Instance: OleVariant; EventLog, AMessage: WideString);
begin
  AddEventRecord('A new record was inserted into Application event log. The message is: '+AMessage);
end;

procedure TFrmEventsMain.OnEventLogSystem(ASender: TObject; Instance: OleVariant; EventLog, AMessage: WideString);
begin
  AddEventRecord('A new record was inserted into System event log. The message is: '+AMessage);
end;

procedure TFrmEventsMain.OnEventLogSecurity(ASender: TObject; Instance: OleVariant; EventLog, AMessage: WideString);
begin
  AddEventRecord('A new record was inserted into Security event log. The message is: '+AMessage);
end;

procedure TFrmEventsMain.FormResize(Sender: TObject);
begin
  lvWatch.Columns[0].Width := lvWatch.ClientWidth - 1;
end;

procedure TFrmEventsMain.chbSystemClick(Sender: TObject);
begin
  RegisterEvent(wetEventLogSystem, chbSystem.Checked);
end;

procedure TFrmEventsMain.chbSecurityClick(Sender: TObject);
begin
  RegisterEvent(wetEventLogSecurity, chbSecurity.Checked);
end;

procedure TFrmEventsMain.btnClearClick(Sender: TObject);
begin
  lvWatch.Items.Clear;
end;

procedure TFrmEventsMain.chbUserClick(Sender: TObject);
begin
  RegisterEvent(wetUserAccount, chbUser.Checked);
end;

procedure TFrmEventsMain.OnUserAccount(ASender: TObject;
  Instance: OleVariant; Name, Domain: WideString; Action: TWmiEventAction);
var
  vAction: string;
begin
  case Action of
     weaCreated: vAction := 'created';
     weaDeleted: vAction := 'deleted';
     weaModified: vAction := 'modified';
  end;
  AddEventRecord('User account "'+Domain + '\'+Name + '" was '+ vAction);
end;

procedure TFrmEventsMain.OnGroupAccount(ASender: TObject;
  Instance: OleVariant; Name, Domain: WideString; Action: TWmiEventAction);
var
  vAction: string;
begin
  case Action of
     weaCreated: vAction := 'created';
     weaDeleted: vAction := 'deleted';
     weaModified: vAction := 'modified';
  end;
  AddEventRecord('User group "'+Domain + '\'+Name + '" was '+ vAction);
end;


procedure TFrmEventsMain.chbGroupClick(Sender: TObject);
begin
  RegisterEvent(wetGroupAccount, chbGroup.Checked);
end;

procedure TFrmEventsMain.OnGroupMembership(ASender: TObject;
      Instance: OleVariant; AGroupName, AGroupDomain, AUserName,
      AUserDomain: WideString; Action: TWmiEventAction);
begin
  case Action of
     weaCreated: AddEventRecord('A user "'+AUserDomain+'\'+AUserName + '" was added to the group "'+
                                AGroupDomain+'\'+AGroupName + '"');
     weaDeleted: AddEventRecord('A user "'+AUserDomain+'\'+AUserName + '" was deleted from the group "'+
                                AGroupDomain+'\'+AGroupName + '"');
     weaModified: AddEventRecord('A membership of the user "'+AUserDomain+'\'+AUserName + '" in the group "'+
                                AGroupDomain+'\'+AGroupName + '" was modified');
  end;
end;


procedure TFrmEventsMain.chbMembershipClick(Sender: TObject);
begin
  RegisterEvent(wetGroupMembership, chbMembership.Checked);
end;

procedure TFrmEventsMain.RegisterEvent(AEventType: TWmiEventType; IfRegister: boolean);
begin
    SetWaitCursor;
    try
      case AEventType of
        wetEventLogApplication:
          if IfRegister then WmiSystemEvents1.OnEventLogApplication := OnEventLogApplication
            else WmiSystemEvents1.OnEventLogApplication := nil;
        wetEventLogSystem:
          if IfRegister then WmiSystemEvents1.OnEventLogSystem := OnEventLogSystem
            else WmiSystemEvents1.OnEventLogSystem := nil;
        wetEventLogSecurity:
          if IfRegister then WmiSystemEvents1.OnEventLogSecurity := OnEventLogSecurity
            else WmiSystemEvents1.OnEventLogSecurity := nil;
        wetUserAccount:
          if IfRegister then WmiSystemEvents1.OnUserAccount := OnUserAccount
            else WmiSystemEvents1.OnUserAccount := nil;
        wetGroupAccount:
          if IfRegister then WmiSystemEvents1.OnGroupAccount := OnGroupAccount
            else WmiSystemEvents1.OnGroupAccount := nil;
        wetGroupMembership:
          if IfRegister then WmiSystemEvents1.OnGroupMembership := OnGroupMembership
            else WmiSystemEvents1.OnGroupMembership := nil;
        wetNetworkConnect:
          if IfRegister then WmiSystemEvents1.OnNetworkConnect := OnNetworkConnected
            else WmiSystemEvents1.OnNetworkConnect := nil;
        wetNetworkDisconnect:
          if IfRegister then WmiSystemEvents1.OnNetworkDisconnect := OnNetworkDisconnected
            else WmiSystemEvents1.OnNetworkDisconnect := nil;
        wetPrinter:
          if IfRegister then WmiSystemEvents1.OnPrinter := OnPrinter
            else WmiSystemEvents1.OnPrinter := nil;
        wetPrintJob:
          if IfRegister then WmiSystemEvents1.OnPrintJob := OnPrintJob
            else WmiSystemEvents1.OnPrintJob := nil;
        wetSessionLogon:
          if IfRegister then WmiSystemEvents1.OnUserLogon := OnUserLogon
            else WmiSystemEvents1.OnUserLogon := nil;
        wetSessionLogoff:
          if IfRegister then WmiSystemEvents1.OnUserLogoff := OnUserLogoff
            else WmiSystemEvents1.OnUserLogoff := nil;
        wetCDROMInserted:
          if IfRegister then WmiSystemEvents1.OnCDROMInserted := OnCDROMInserted
            else WmiSystemEvents1.OnCDROMInserted := nil;
        wetCDROMEjected:
          if IfRegister then WmiSystemEvents1.OnCDROMEjected := OnCDROMEjected
            else WmiSystemEvents1.OnCDROMEjected := nil;
        wetService:
          if IfRegister then WmiSystemEvents1.OnService := OnService
            else WmiSystemEvents1.OnService := nil;
        wetDocking:
          if IfRegister then WmiSystemEvents1.OnDocking := OnDocking
            else WmiSystemEvents1.OnDocking := nil;
      end;
    finally
      RestoreCursor;
    end;
end;

procedure TFrmEventsMain.OnPrinter(ASender: TObject; Instance: OleVariant;
  Name: WideString; Action: TWmiEventAction);
var
  vAction: string;
begin
  case Action of
     weaCreated: vAction := 'installed';
     weaDeleted: vAction := 'deleted';
     weaModified: vAction := 'modified';
  end;
  AddEventRecord('Printer "'+Name + '" was '+ vAction);
end;

procedure TFrmEventsMain.chbPrinterClick(Sender: TObject);
begin
  RegisterEvent(wetPrinter, chbPrinter.Checked);
end;

procedure TFrmEventsMain.OnPrintJob(ASender: TObject;
  Instance: OleVariant; Document: widestring; JobID: integer;
  JobStatus: widestring; Action: TWmiEventAction);
var
  vAction: string;
begin
  case Action of
     weaCreated: vAction := 'was created';
     weaDeleted: vAction := 'has finished';
     weaModified: vAction := 'has modified';
  end;
  AddEventRecord('Job "'+IntToStr(JobID) + '"('+ Document +') '+ vAction + '. Last job status is ' + JobStatus);
end;

procedure TFrmEventsMain.chbJobClick(Sender: TObject);
begin
  RegisterEvent(wetPrintJob, chbJob.Checked);
end;

procedure TFrmEventsMain.OnUserLogon(ASender: TObject; LogonId, Name,
  Domain: WideString);
begin
  AddEventRecord('The user ' + Domain + '\' + Name + ' logged on to '+GetMachineName +
                 '. LogonId is '+LogonId);
end;

procedure TFrmEventsMain.OnUserLogoff(ASender: TObject; LogonId, Name,
  Domain: WideString);
begin
  AddEventRecord('The user ' + Domain + '\' + Name + ' logged off '+GetMachineName +
                 '. LogonId is '+LogonId);
end;

procedure TFrmEventsMain.chbLogonClick(Sender: TObject);
begin
  RegisterEvent(wetSessionLogon, chbLogon.Checked);
end;

procedure TFrmEventsMain.chbLogoffClick(Sender: TObject);
begin
  RegisterEvent(wetSessionLogoff, chbLogoff.Checked);
end;

procedure TFrmEventsMain.chbServiceClick(Sender: TObject);
begin
  RegisterEvent(wetService, chbService.Checked);
end;

procedure TFrmEventsMain.OnService(ASender: TObject; Instance: OleVariant;
  AServiceName, AState: WideString; Action: TWmiEventAction);
var
  vAction: string;
begin
  case Action of
     weaCreated: vAction := ' was installed';
     weaDeleted: vAction := ' was deinstalled';
     weaModified: vAction := ' has changed its state';
  end;
  AddEventRecord('The service '+AServiceName + vAction + '. Last service state: '+AState);
end;

procedure TFrmEventsMain.OnDocking(ASender: TObject);
begin
  AddEventRecord('The docking state has changed.');
end;

procedure TFrmEventsMain.chbDockingClick(Sender: TObject);
begin
  RegisterEvent(wetDocking, chbDocking.Checked);
end;

procedure TFrmEventsMain.OnCDROMEjected(ASender: TObject;
  Instance: OleVariant; ADrive: widestring);
begin
  AddEventRecord('CD disk was ejected from drive '+ ADrive);
end;

procedure TFrmEventsMain.OnCDROMInserted(ASender: TObject;
  Instance: OleVariant; ADrive: widestring);
begin
  AddEventRecord('CD disk was insetred into drive '+ ADrive);
end;

procedure TFrmEventsMain.chbCDROMInsertedClick(Sender: TObject);
begin
  RegisterEvent(wetCDROMInserted, chbCDROMInserted.Checked);
end;

procedure TFrmEventsMain.chbCDROMEjectedClick(Sender: TObject);
begin
  RegisterEvent(wetCDROMEjected, chbCDROMEjected.Checked);
end;

procedure TFrmEventsMain.sbRegisterQueryClick(Sender: TObject);
begin
  if sbRegisterQuery.Down then
  begin
    try
      WmiSystemEvents1.RegisterWmiEvent(cmnNameSpaces.Text,
              memQuery.Lines.Text,
              '',
              OnCustomEvent,
              []);

      memQuery.Enabled := false;
      cmnNameSpaces.Enabled := false;
    except
      sbRegisterQuery.Down := false;
      raise;
    end;
  end else
  begin
    WmiSystemEvents1.UnregisterWmiEvent(memQuery.Lines.Text);
    memQuery.Enabled := true;
    cmnNameSpaces.Enabled := true;
  end;
end;

procedure TFrmEventsMain.OnCustomEvent(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  AddEventRecord('User defined event happened. It was caused by this notification query: '+ EventInfo.EventQuery);
end;

end.
