unit FrmNetworkConfigMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, WmiAbstract, WmiMethod, WmiDataSet,
  WmiConnection, StdCtrls, ToolWin, ComCtrls, ExtCtrls, Mask, DBCtrls,
  FrmStaticAddressU, ImgList,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  FrmNewHostU, FrmAboutU;

type
  TFrmNetworkConfigMain = class(TForm)
    WmiConnection1: TWmiConnection;
    wqConfigurations: TWmiQuery;
    dsConfigurations: TDataSource;
    ToolBar1: TToolBar;
    cmbAdapters: TComboBox;
    lblNetworkAdapter: TLabel;
    Bevel1: TBevel;
    lblMACAddress: TLabel;
    dbeMACAddress: TDBEdit;
    Label2: TLabel;
    dbeIPAddress: TDBEdit;
    lblIPSubnet: TLabel;
    dbeIPSubnet: TDBEdit;
    lblDeafultIPGateway: TLabel;
    dbeDeafultIPGateway: TDBEdit;
    btnSetStaticIP: TButton;
    btnEnableDHCP: TButton;
    WmiMethod1: TWmiMethod;
    Label3: TLabel;
    dbeDNSPrimaryDomain: TDBEdit;
    tlbConnect: TToolButton;
    tlbRefresh: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    wqAdapters: TWmiQuery;
    ToolButton1: TToolButton;
    tlbAbout: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbAdaptersChange(Sender: TObject);
    procedure btnSetStaticIPClick(Sender: TObject);
    procedure btnEnableDHCPClick(Sender: TObject);
    procedure tlbRefreshClick(Sender: TObject);
    procedure tlbConnectClick(Sender: TObject);
    procedure tlbAboutClick(Sender: TObject);
  private
    procedure RefreshInfo;
    function RemoveBrackets(AText: string): string;
    function SetFormCaption: string;
    procedure DisableControls;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNetworkConfigMain: TFrmNetworkConfigMain;

implementation

{$R *.dfm}

procedure TFrmNetworkConfigMain.FormCreate(Sender: TObject);
begin
  ClientWidth := cmbAdapters.Left + cmbAdapters.Width + 5;
  ClientHeight := dbeDNSPrimaryDomain.Top + dbeDNSPrimaryDomain.Height + 5;
  WmiConnection1.Connected := true;
  WmiMethod1.WmiObjectSource := wqConfigurations;
  RefreshInfo;
  SetFormCaption;
end;

procedure TFrmNetworkConfigMain.RefreshInfo;
var
  vWasIndex: integer;
begin
  wqConfigurations.Active := false;
  wqConfigurations.Active := true;
  wqAdapters.Active := false;
  wqAdapters.Active := true;

  vWasIndex := cmbAdapters.ItemIndex;
  cmbAdapters.Items.Clear;
  wqConfigurations.DisableControls;
  try
    wqAdapters.First;
    // find all adapters of type 'Ethernet 802.3' that
    // have the flag IPEnabled set
    while not wqAdapters.EOF do
    begin
      if wqConfigurations.Locate('Index', wqAdapters.FieldByName('Index').AsString, []) and
         wqConfigurations.FieldByName('IPEnabled').AsBoolean then
           cmbAdapters.Items.Add(
                 wqAdapters.FieldByName('Index').AsString + ': ' +
                 wqAdapters.FieldByName('Description').AsString);
      wqAdapters.Next;
    end;
  finally
    wqConfigurations.EnableControls;
  end;

  if (vWasIndex <> -1) and (vWasIndex < cmbAdapters.Items.Count) then
    cmbAdapters.ItemIndex := vWasIndex
  else
  if cmbAdapters.Items.Count > 0 then
    cmbAdapters.ItemIndex := 0
  else DisableControls;

  cmbAdaptersChange(nil);
end;

procedure TFrmNetworkConfigMain.DisableControls;
begin
  wqConfigurations.Active := false;
  wqAdapters.Active := false;
  WmiConnection1.Connected := false;
  cmbAdapters.Enabled :=  false;
  btnSetStaticIP.Enabled := false;
  btnEnableDHCP.Enabled := false;
end;


procedure TFrmNetworkConfigMain.cmbAdaptersChange(Sender: TObject);
var
  vIndex: integer;
  s: string;
begin
  if cmbAdapters.Items.Count > 0 then
  begin
    s := Copy(cmbAdapters.Text, 1, Pos(':', cmbAdapters.Text)-1);
    vIndex := StrToInt(s);

    wqConfigurations.Locate('Index',
                      vIndex,
                      []);
    btnEnableDHCP.Enabled := not wqConfigurations.FieldByName('DHCPEnabled').AsBoolean;
  end;
end;

function TFrmNetworkConfigMain.RemoveBrackets(AText: string): string;
begin
  if (Length(AText) > 0) and (AText[1] = '{') then AText := Copy(AText, 2, Length(AText)-1);
  if (Length(AText) > 0) and (AText[Length(AText)] = '}') then AText := Copy(AText, 1, Length(AText)-1);
  Result := AText;
end;

procedure TFrmNetworkConfigMain.btnSetStaticIPClick(Sender: TObject);
var
  s: string;
begin
  with TFrmStaticAddress.Create(nil) do
  try
    edtIPAddress.Text := RemoveBrackets(dbeIPAddress.Text);
    edtIPSubnetMask.Text := RemoveBrackets(dbeIPSubnet.Text);
    edtDefaultGateway.Text := RemoveBrackets(dbeDeafultIPGateway.Text);
    while ShowModal = mrOk do
    begin
       Screen.Cursor := crHourGlass;
       try
         try
           // set static IP address
           WmiMethod1.WmiMethodName := 'EnableStatic';
           WmiMethod1.InParams.ParamByName('IPAddress').AsString := edtIPAddress.Text;
           WmiMethod1.InParams.ParamByName('SubnetMask').AsString := edtIPSubnetMask.Text;
           if WmiMethod1.Execute <> 0 then
           begin
             s := WmiMethod1.LastWmiErrorDescription;
             Application.MessageBox(PChar(s), 'Cannot set static IP', MB_ICONHAND + MB_OK);
           end;
           
           // set default gateway
           WmiMethod1.WmiMethodName := 'SetGateways';
           WmiMethod1.InParams.ParamByName('DefaultIPGateway').AsString := edtDefaultGateway.Text;
           if WmiMethod1.Execute = 0 then
           begin
             RefreshInfo;
             ShowMessage('You have to reboot the computer for the changes to take effect');
             Break;
           end else
           begin
             s := WmiMethod1.LastWmiErrorDescription;
             Application.MessageBox(PChar(s), 'Cannot set default gateway', MB_ICONHAND + MB_OK);
           end;

         except
           on e: Exception do
           begin
             s := e.Message;
             Application.MessageBox(PChar(s), 'Error', MB_ICONHAND + MB_OK);
           end;
         end;
       finally
         Screen.Cursor := crDefault;
       end;
    end;
  finally
    Free;
  end;
end;

procedure TFrmNetworkConfigMain.btnEnableDHCPClick(Sender: TObject);
var
  s: string;
begin
  Screen.Cursor := crHourGlass;
  try
    WmiMethod1.WmiMethodName := 'EnableDHCP';
    if WmiMethod1.Execute <> 0 then
    begin
      s := WmiMethod1.LastWmiErrorDescription;
      Application.MessageBox(PChar(s), 'Error enabling DHCP', MB_ICONHAND + MB_OK);
    end;

    WmiMethod1.WmiMethodName := 'RenewDHCPLease';
    if WmiMethod1.Execute = 0 then
    begin
      RefreshInfo;
      ShowMessage('You have to reboot the computer for the changes to take effect');
    end else
    begin
      s := WmiMethod1.LastWmiErrorDescription;
      Application.MessageBox(PChar(s), 'Error renewing DHCP lease', MB_ICONHAND + MB_OK);
    end;
    
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmNetworkConfigMain.tlbRefreshClick(Sender: TObject);
begin
  RefreshInfo;
end;

function TFrmNetworkConfigMain.SetFormCaption: string;
begin
  if WmiConnection1.MachineName = '' then
    Caption := 'Network configuration on local host' else
    Caption := 'Network configuration on '+ WmiConnection1.MachineName;
end;

procedure TFrmNetworkConfigMain.tlbConnectClick(Sender: TObject);
var
  vUserName: string;
  vWasCursor: TCursor;

  vOldUserName, vOldPassword, vOldMachineName: widestring;
  vFrmNewHost: TFrmNewHost;
begin
  vFrmNewHost := TFrmNewHost.Create(nil);
  try
    while true do
    begin
      if vFrmNewHost.ShowModal = mrOk then
      begin
        // save current credentials to be able to restore
        // them if new credentials are invalid.
        vOldUserName := WmiConnection1.Credentials.UserName;
        vOldPassword := WmiConnection1.Credentials.Password;
        vOldMachineName := WmiConnection1.MachineName;

        WmiConnection1.Connected := false;
        vUserName := vFrmNewHost.edtUserName.Text;
        if vFrmNewHost.edtDomain.Text <> '' then
          vUserName := vFrmNewHost.edtDomain.Text + '\' + vUserName;

        WmiConnection1.Credentials.UserName := vUserName;
        WmiConnection1.Credentials.Password := vFrmNewHost.edtPassword.Text;
        WmiConnection1.MachineName := vFrmNewHost.edtHostName.Text;

        vWasCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          try
            WmiConnection1.Connected := true;
            SetFormCaption;
            RefreshInfo;
            Break;
          finally
            Screen.Cursor := vWasCursor;
          end;
        except
          on E: Exception do
            begin
              Application.MessageBox(PChar(E.Message), 'Error', MB_Ok + MB_ICONSTOP);
              // restore previous credentials.
              WmiConnection1.Credentials.UserName := vOldUserName;
              WmiConnection1.Credentials.Password := vOldPassword;
              WmiConnection1.MachineName          := vOldMachineName;
              WmiConnection1.Connected := true;
              RefreshInfo;
            end;
        end;
      end else
      begin
        Break;
      end;
    end;
  finally
    vFrmNewHost.Free;
  end;
end;

procedure TFrmNetworkConfigMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
