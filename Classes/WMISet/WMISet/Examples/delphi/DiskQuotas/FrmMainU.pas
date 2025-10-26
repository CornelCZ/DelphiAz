unit FrmMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, WmiAbstract, WmiDiskQuotaControl, FrmNewHostU,
  ToolWin, ImgList, StdCtrls, DetectWinOS, FrmNewDiskQuotaU, WmiComponent,
  FrmAboutU;

type
  TFrmMain = class(TForm)
    tvBrowser: TTreeView;
    Splitter1: TSplitter;
    pcQuotas: TPageControl;
    tsSettings: TTabSheet;
    tsUserQuotas: TTabSheet;
    WmiDiskQuotaControl1: TWmiDiskQuotaControl;
    Toolbar: TToolBar;
    tlbNewHost: TToolButton;
    imlToolbar: TImageList;
    pnlSettings: TPanel;
    Label1: TLabel;
    lblLoggingOptions: TLabel;
    Bevel1: TBevel;
    chbEnableManagement: TCheckBox;
    chbDenyIfExceeded: TCheckBox;
    rbDoNotLimitDiskSpace: TRadioButton;
    chbLogWhenOverLimit: TCheckBox;
    btnApply: TButton;
    btnCancel: TButton;
    pnlQuotas: TPanel;
    lvQuotas: TListView;
    tlbQuotas: TToolBar;
    tlbNew: TToolButton;
    tlbDelete: TToolButton;
    pnlNotSupported: TPanel;
    pnlLimits: TPanel;
    edtLimit: TEdit;
    edtWarning: TEdit;
    lblWarningLimit: TLabel;
    rbLimitDiskSpace: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure tvBrowserExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tlbNewHostClick(Sender: TObject);
    procedure tvBrowserChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chbEnableManagementClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure rbDoNotLimitDiskSpaceClick(Sender: TObject);
    procedure rbLimitDiskSpaceClick(Sender: TObject);
    procedure tlbDeleteClick(Sender: TObject);
    procedure lvQuotasChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure tlbNewClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    FStoredCursor: TCursor;
    procedure InitItems;
    function ProcessNodeExpanding(ANode: TTreeNode): boolean;
    function AddVolumeNodes(ANode: TTreeNode): boolean;
    function LoadRemoteHosts(ANode: TTreeNode): boolean;
    function DoConnect(ANode: TTreeNode): boolean;
    procedure RestoreCursor;
    procedure SetWaitCursor;
    procedure CreateNewNetworkNode;
    function FindNeworkNode: TTreeNode;
    procedure LoadInformation(ANode: TTreeNode);
    procedure ProcessChangingNode(ANode: TTreeNode);
    procedure LoadDiskQuotas;
    procedure LoadQuotaSettings;
    procedure ClearControls(ARoot: TWinControl);
    procedure EnableControls(ARoot: TControl; AEnabled: boolean; Exclude: TControl);
    procedure ApplyQuotaSetting;
    procedure CancelChangesInQuotaSettings;
    procedure ShowError(AControl: TWinControl; AError: string);
    procedure ValidateChanges;
    procedure DeleteSelectedQuota;
    procedure CreateNewQuota;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';

  CNST_NO_LIMIT = 'No limit';

implementation

{$R *.dfm}

type
  TCredentials = class
  private
    FUserName: widestring;
    FPassword: widestring;
  public
    constructor Create(AUserName, APassword: widestring);

    property UserName: widestring read FUserName;
    property Password: widestring read FPassword; 
  end;

{ TCredentials }

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;

procedure TFrmMain.InitItems;
var
  vItem: TTreeNode;
begin
  vItem := tvBrowser.Items.Add(nil, LOCAL_HOST);
  tvBrowser.Items.AddChild(vItem, NO_DATA);
  vItem := tvBrowser.Items.Add(nil, NETWORK);
  tvBrowser.Items.AddChild(vItem, NO_DATA);
end;


procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitItems;
end;

procedure TFrmMain.tvBrowserExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  AllowExpansion := ProcessNodeExpanding(Node);
end;

function TFrmMain.ProcessNodeExpanding(ANode: TTreeNode): boolean;
begin
  Result := true;
  if (ANode.Count = 1) and (ANode.getFirstChild.Text = NO_DATA) then
  begin
    Result := false;
    if (ANode.Text = LOCAL_HOST) then Result := AddVolumeNodes(ANode)
      else
    if (ANode.Text = NETWORK) then Result := LoadRemoteHosts(ANode)
      else
    if (ANode.Parent <> nil) and (ANode.Parent.Text = NETWORK) then
    begin
      if DoConnect(ANode) then Result := AddVolumeNodes(ANode);
    end
  end
end;

function TFrmMain.AddVolumeNodes(ANode: TTreeNode): boolean;
var
  vMachineName: widestring;
  vCredentials: TCredentials;
  vList: TStringList;
  i: integer;
begin
  ANode.DeleteChildren;
  if ANode.Text = LOCAL_HOST then vMachineName := ''
    else vMachineName := ANode.Text;

  if (vMachineName <> WmiDiskQuotaControl1.MachineName) or
     (not WmiDiskQuotaControl1.Active) then
  begin
    WmiDiskQuotaControl1.Active := false;
    WmiDiskQuotaControl1.Credentials.Clear;
    vCredentials := TCredentials (ANode.Data);
    if vCredentials <> nil then
    begin
      WmiDiskQuotaControl1.Credentials.UserName := vCredentials.UserName;
      WmiDiskQuotaControl1.Credentials.Password := vCredentials.Password;
    end;
    WmiDiskQuotaControl1.Active := true;
  end;

  vList := TStringList.Create;
  try
    WmiDiskQuotaControl1.ListLogicalDisks(vList);
    for i := 0 to vList.Count - 1 do
      tvBrowser.Items.AddChild(ANode, vList[i]);
  finally
    vList.Free;
  end;

  Result := true;
end;

function TFrmMain.LoadRemoteHosts(ANode: TTreeNode): boolean;
var
  AList: TStrings;
  i: integer;
  vNode: TTreeNode;
begin
  ANode.DeleteChildren;
  AList := TStringList.Create;
  SetWaitCursor;
  try
    WmiDiskQuotaControl1.ListServers(AList);
    for i := 0 to AList.Count - 1 do
    begin
      vNode := tvBrowser.Items.AddChild(ANode, AList[i]);
      tvBrowser.Items.AddChild(vNode, NO_DATA);
    end;
  finally
    AList.Free;
    RestoreCursor;
  end;
  Result := true;
end;


function TFrmMain.DoConnect(ANode: TTreeNode): boolean;
var
  vCredentials: TCredentials;
  vForm: TFrmNewHost;
begin
  Result := false;

  // do not reconnect if already connected to desired host. 
  if (ANode.Text = WmiDiskQuotaControl1.MachineName) and
     (WmiDiskQuotaControl1.Active) then
  begin
    Result := true;
    Exit;
  end;

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for creadentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  SetWaitCursor;
  try
    WmiDiskQuotaControl1.Active := false;
    if ANode.Text = LOCAL_HOST then
    begin
      // connect to local host;
      WmiDiskQuotaControl1.Credentials.Clear;
      WmiDiskQuotaControl1.MachineName := '';
      WmiDiskQuotaControl1.Active := true;
      Result := true;
    end else
    begin
      if (ANode.Data = nil) then
      begin
        // connect for the first time
        // try default credentials fisrt:
        try
          WmiDiskQuotaControl1.Credentials.Clear;
          WmiDiskQuotaControl1.MachineName := ANode.Text;
          WmiDiskQuotaControl1.Active := true;
          Result := true;
        except
          // expected exception: the credentials are not valid
        end;

        // default credentials did not work.
        // try to connect with user's provided credentials
        if not WmiDiskQuotaControl1.Active then
        begin
          vForm := TFrmNewHost.Create(nil);
          vForm.MachineName := ANode.Text;
          try
            while vForm.ShowModal = mrOk do
              try
                WmiDiskQuotaControl1.Active := false;
                WmiDiskQuotaControl1.Credentials.Clear;
                WmiDiskQuotaControl1.MachineName := ANode.Text;
                WmiDiskQuotaControl1.Credentials.UserName := vForm.UserName;
                WmiDiskQuotaControl1.Credentials.Password := vForm.edtPassword.Text;
                WmiDiskQuotaControl1.Active := true;

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
        WmiDiskQuotaControl1.MachineName := ANode.Text;
        WmiDiskQuotaControl1.Credentials.UserName := vCredentials.UserName;
        WmiDiskQuotaControl1.Credentials.Password := vCredentials.Password;
        WmiDiskQuotaControl1.Active := true;
        Result := true;
      end;
    end;
  finally
    RestoreCursor;
  end;
end;

procedure TFrmMain.SetWaitCursor;
begin
  FStoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TFrmMain.RestoreCursor;
begin
  Screen.Cursor := FStoredCursor;
end;



procedure TFrmMain.tlbNewHostClick(Sender: TObject);
begin
  CreateNewNetworkNode;
end;

procedure TFrmMain.CreateNewNetworkNode;
var
  vForm: TFrmNewHost;
  vNode: TTreeNode;
begin
  vForm := TFrmNewHost.Create(nil);
  try
    while vForm.ShowModal = mrOk do
      try

        WmiDiskQuotaControl1.Active := false;
        WmiDiskQuotaControl1.Credentials.Clear;
        WmiDiskQuotaControl1.MachineName := vForm.edtHostName.Text;
        WmiDiskQuotaControl1.Credentials.UserName := vForm.UserName;
        WmiDiskQuotaControl1.Credentials.Password := vForm.edtPassword.Text;
        WmiDiskQuotaControl1.Active := true;

        // connected successfully; add the new host to a list.
        vNode := FindNeworkNode;
        if (vNode.getFirstChild <> nil) and
           (vNode.getFirstChild.Text = NO_DATA) then vNode.DeleteChildren;

        vNode := tvBrowser.Items.AddChild(vNode, vForm.edtHostName.Text);
        vNode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
        AddVolumeNodes(vNode);
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

function TFrmMain.FindNeworkNode: TTreeNode;
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

procedure TFrmMain.tvBrowserChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  ProcessChangingNode(Node);
end;

procedure TFrmMain.ProcessChangingNode(ANode: TTreeNode);
begin
  LoadInformation(ANode);
end;

procedure TFrmMain.ClearControls(ARoot: TWinControl);
var
  i: integer;
begin
  if (ARoot is TCustomEdit) then (ARoot as TCustomEdit).Text := '';
  if (ARoot is TCustomCombobox) then (ARoot as TCustomCombobox).ItemIndex := -1;
  if (ARoot is TCheckbox) then (ARoot as TCheckbox).Checked := false;
  if (ARoot is TRadioButton) then (ARoot as TRadioButton).Checked := false;
  for i := 0 to ARoot.ControlCount - 1 do
    if ARoot.Controls[i] is TWinControl then
      ClearControls(ARoot.Controls[i] as TWinControl);
end;

procedure TFrmMain.LoadQuotaSettings;
var
  vSetting: TWmiQuotaSetting;
begin
  vSetting := WmiDiskQuotaControl1.QuotaSettings[0];
  chbEnableManagement.Checked := vSetting.State <> QUOTAS_DISABLE;
  if chbEnableManagement.Checked then
  begin
    chbDenyIfExceeded.Checked := vSetting.State = QUOTAS_ENFORCE;
    rbDoNotLimitDiskSpace.Checked := vSetting.DefaultLimit = NO_LIMIT;
    rbLimitDiskSpace.Checked := not rbDoNotLimitDiskSpace.Checked;
    if rbDoNotLimitDiskSpace.Checked then
    begin
      edtLimit.Text := CNST_NO_LIMIT;
      edtWarning.Text := CNST_NO_LIMIT;
    end else
    begin
      edtLimit.Text := vSetting.DefaultLimit;
      edtWarning.Text := vSetting.DefaultWarningLimit;
    end;

    chbLogWhenOverLimit.Checked := vSetting.ExceededNotification;
  end else
  begin
    ClearControls(pnlSettings);
  end;
end;

procedure TFrmMain.ApplyQuotaSetting;
var
  vSetting: TWmiQuotaSetting;
  vState: DWORD;
begin
  ValidateChanges;
  vSetting := WmiDiskQuotaControl1.QuotaSettings[0];

  if not chbEnableManagement.Checked then vState := QUOTAS_DISABLE
    else
  if not chbDenyIfExceeded.Checked then vState := QUOTAS_TRACK
    else
  vState := QUOTAS_ENFORCE;

  vSetting.State := vState;
  if rbDoNotLimitDiskSpace.Checked then
  begin
    vSetting.DefaultLimit := NO_LIMIT;
    vSetting.DefaultWarningLimit := NO_LIMIT;
  end else
  begin
    vSetting.DefaultLimit := edtLimit.Text;
    vSetting.DefaultWarningLimit := edtWarning.Text;
  end;

  vSetting.ExceededNotification := chbLogWhenOverLimit.Checked;
end;

procedure TFrmMain.LoadDiskQuotas;
var
  i: integer;
  vItem: TListItem;
begin
  lvQuotas.Items.Clear;
  for i := 0 to WmiDiskQuotaControl1.DiskQuotas.Count - 1 do
  begin
    vItem := lvQuotas.Items.Add();
    vItem.Caption := WmiDiskQuotaControl1.DiskQuotas[i].Account;
    vItem.SubItems.Add(IntToStr(WmiDiskQuotaControl1.DiskQuotas[i].DiskSpaceUsed));
    if (WmiDiskQuotaControl1.DiskQuotas[i].Limit = NO_LIMIT) then
      vItem.SubItems.Add('No limit')
      else vItem.SubItems.Add(WmiDiskQuotaControl1.DiskQuotas[i].Limit);
    if (WmiDiskQuotaControl1.DiskQuotas[i].WarningLimit = NO_LIMIT) then
      vItem.SubItems.Add('No limit')
      else vItem.SubItems.Add(WmiDiskQuotaControl1.DiskQuotas[i].WarningLimit);
    vItem.SubItems.Add(QuotaStatusToString(WmiDiskQuotaControl1.DiskQuotas[i].Status));
  end;
end;


procedure TFrmMain.LoadInformation(ANode: TTreeNode);
begin
  if (Length(ANode.Text) = 2) and (ANode.Text[2] = ':') then
  begin
    if DoConnect(ANode.Parent) then
    begin
      WmiDiskQuotaControl1.FilterVolume := ANode.Text;
      WmiDiskQuotaControl1.DiskQuotas.ClearEntities;
      WmiDiskQuotaControl1.QuotaSettings.ClearEntities;
      if WmiDiskQuotaControl1.QuotaSettings.Count > 0 then
      begin
         LoadQuotaSettings;
         LoadDiskQuotas;
      end
    end;
    pnlNotSupported.Visible := WmiDiskQuotaControl1.QuotaSettings.Count = 0;
    pnlSettings.Visible := not pnlNotSupported.Visible;
    pnlQuotas.Visible := not pnlNotSupported.Visible;
  end else
  begin
    pnlNotSupported.Visible := false;
    pnlSettings.Visible := false;
    pnlQuotas.Visible := false;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  if not IsWindowsXPOrHigher then
    Application.MessageBox('This program is designed for Windows XP and higher',
        'Warning', MB_OK);
end;

procedure TFrmMain.EnableControls(ARoot: TControl; AEnabled: boolean; Exclude: TControl);
  function GetColor(AEnabled: boolean): TColor;
  begin
    if AEnabled then Result := clWindow
      else Result := clBtnFace;
  end;

var
  i: integer;
begin
  if (ARoot is TEdit) then
  begin
    (ARoot as TEdit).Enabled := AEnabled;
    (ARoot as TEdit).Color := GetColor(AEnabled);
    (ARoot as TEdit).Text := '';

  end else
  if (ARoot is TCombobox) then
  begin
    (ARoot as TCombobox).Enabled := AEnabled;
    (ARoot as TCombobox).Color := GetColor(AEnabled);
    if not AEnabled then (ARoot as TCombobox).ItemIndex := -1;
  end else
  if (ARoot is TRadioButton) then
  begin
    (ARoot as TRadioButton).Enabled := AEnabled;
    if not AEnabled then (ARoot as TRadioButton).Checked := false;
  end else
  if (ARoot is TCheckBox) then
  begin
    (ARoot as TCheckBox).Enabled := AEnabled;
    if ARoot <> Exclude then
      if not AEnabled then (ARoot as TCheckBox).Checked := false;
  end;

  if (ARoot is TWinControl) then
    for i := 0 to (ARoot as TWinControl).ControlCount - 1 do
      EnableControls((ARoot as TWinControl).Controls[i], AEnabled, Exclude);
end;

procedure TFrmMain.chbEnableManagementClick(Sender: TObject);
var
  vSetting: TWmiQuotaSetting;
begin
  if not chbEnableManagement.Checked then
  begin
    EnableControls(pnlSettings, false, chbEnableManagement);
    EnableControls(chbEnableManagement, true, chbEnableManagement);
  end else
  begin
    EnableControls(pnlSettings, true, chbEnableManagement);
    vSetting := WmiDiskQuotaControl1.QuotaSettings[0];
    if vSetting.State <> QUOTAS_DISABLE then LoadQuotaSettings;
  end;
end;

procedure TFrmMain.btnApplyClick(Sender: TObject);
begin
  ApplyQuotaSetting;
end;

procedure TFrmMain.ShowError(AControl: TWinControl; AError: string);
begin
  if AControl.CanFocus then AControl.SetFocus;
  Application.MessageBox(PChar(AError), 'Error', MB_OK + MB_ICONHAND);
  Abort;
end; 

procedure TFrmMain.ValidateChanges;
begin
  if rbLimitDiskSpace.Checked then
  begin
    if edtLimit.Text = '' then ShowError(edtLimit, 'Limit is required');
    if edtWarning.Text = '' then ShowError(edtWarning, 'Warning limit is required');
  end;
end;

procedure TFrmMain.CancelChangesInQuotaSettings;
begin
  LoadQuotaSettings;
end;


procedure TFrmMain.btnCancelClick(Sender: TObject);
begin
  CancelChangesInQuotaSettings;
end;

procedure TFrmMain.rbDoNotLimitDiskSpaceClick(Sender: TObject);
begin
  EnableControls(pnlLimits, false, nil);
  rbLimitDiskSpace.Enabled := true;
end;

procedure TFrmMain.rbLimitDiskSpaceClick(Sender: TObject);
begin
  EnableControls(pnlLimits, true, rbLimitDiskSpace);
end;

procedure TFrmMain.DeleteSelectedQuota;
var
  vQuota: TWmiDiskQuota;
begin
  if lvQuotas.Selected <> nil then
  begin
     vQuota := WmiDiskQuotaControl1.DiskQuotas[lvQuotas.Selected.Index];
     if vQuota.DiskSpaceUsed = 0 then 
     begin
       WmiDiskQuotaControl1.DiskQuotas.Delete(lvQuotas.Selected.Index);
       LoadDiskQuotas;
     end else
     begin
       Application.MessageBox('This quota shows the space used. '+
        'Delete all of files that are charged to this account, then try again',
        'Error', MB_OK + MB_ICONHAND);   
     end;  
  end;
end;

procedure TFrmMain.tlbDeleteClick(Sender: TObject);
begin
  DeleteSelectedQuota;
end;

procedure TFrmMain.lvQuotasChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  tlbDelete.Enabled := lvQuotas.Selected <> nil;
end;

procedure TFrmMain.CreateNewQuota;
var
  vForm: TFrmNewDiskQuota;
  vLimit, vWarningLimit: widestring;
begin
  vForm := TFrmNewDiskQuota.Create(nil);
  try
    WmiDiskQuotaControl1.ListAccounts(vForm.cmbUser.Items);
    while vForm.ShowModal = mrOk do
    begin
      try
        vLimit := vForm.cmbLimit.Text;
        if vLimit = 'No Limit' then vLimit := NO_LIMIT;
        vWarningLimit := vForm.cmbWarningLimit.Text;
        if vWarningLimit = 'No Limit' then vWarningLimit := NO_LIMIT;
        WmiDiskQuotaControl1.DiskQuotas.Add(vForm.cmbUser.Text, tvBrowser.Selected.Text, vWarningLimit, vLimit);
        Break;
      except
         on E: Exception do
          begin
            ShowMessage(E.Message);
          end;
      end;
    end;
  finally
    vForm.Free;
  end;
end;

procedure TFrmMain.tlbNewClick(Sender: TObject);
begin
  CreateNewQuota;
  LoadDiskQuotas;
end;

procedure TFrmMain.ToolButton2Click(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
