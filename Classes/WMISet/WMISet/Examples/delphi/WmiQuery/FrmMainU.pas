unit FrmMainU;

interface       
{$I define.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids, DBGrids, DB, WmiDataSet,
  WmiConnection, WmiAbstract, ToolWin, ImgList, FrmAboutU, Buttons, DBCtrls;

type
  TFrmMain = class(TForm)
    tvBroswer: TTreeView;
    Splitter1: TSplitter;
    pnlRight: TPanel;
    memWQL: TMemo;
    Splitter2: TSplitter;
    WmiQuery1: TWmiQuery;
    dsWQL: TDataSource;
    WmiConnection1: TWmiConnection;
    ToolBar1: TToolBar;
    tlbNewHost: TToolButton;
    ilToolbar: TImageList;
    tlbConnect: TToolButton;
    ToolButton1: TToolButton;
    tlbPrevQuery: TToolButton;
    tlbNextQuery: TToolButton;
    ToolButton2: TToolButton;
    tlbExecute: TToolButton;
    StatusBar: TStatusBar;
    ToolButton3: TToolButton;
    chbIrregular: TCheckBox;
    ToolButton4: TToolButton;
    tlbAbout: TToolButton;
    ToolButton5: TToolButton;
    cmbClasses: TComboBox;
    lblClasses: TLabel;
    spbInsert: TSpeedButton;
    Label1: TLabel;
    cmbNameSpace: TComboBox;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure tvBroswerExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvBroswerChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tlbNewHostClick(Sender: TObject);
    procedure tlbExecuteClick(Sender: TObject);
    procedure tlbConnectClick(Sender: TObject);
    procedure tvBroswerChange(Sender: TObject; Node: TTreeNode);
    procedure tvBroswerCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure tlbPrevQueryClick(Sender: TObject);
    procedure tlbNextQueryClick(Sender: TObject);
    procedure WmiQuery1BeforeScroll(DataSet: TDataSet);
    procedure WmiQuery1AfterScroll(DataSet: TDataSet);
    procedure chbIrregularClick(Sender: TObject);
    procedure tlbAboutClick(Sender: TObject);
    procedure WmiConnection1AfterConnect(Sender: TObject);
    procedure spbInsertClick(Sender: TObject);
    procedure cmbNameSpaceCloseUp(Sender: TObject);
  private
    FHistory: TStringList;
    FHistoryIndex: integer;

    function  DoConnect(ANode: TTreeNode): boolean;
    procedure SetWaitCursor;
    procedure RestoreCursor;
    procedure InitItems;
    function  ProcessNodeExpanding(ANode: TTreeNode): boolean;
    function  LoadRemoteHosts(ANode: TTreeNode): boolean;
    procedure ProcessChangingNode(Node: TTreeNode);
    procedure CreateNewNetworkNode;
    function  FindNeworkNode: TTreeNode;
    procedure SetButtonState;
    procedure OnShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    
    { Private declarations }
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
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

Uses FrmNewHostU;

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';


  SECOND = 1/24/60/60;
  
function TFrmMain.DoConnect(ANode: TTreeNode): boolean;
var
  vCredentials: TCredentials;
  vForm: TFrmNewHost;
begin
  Result := false;

  // do not reconnect if already connected to desired host. 
  if (ANode.Text = WmiConnection1.MachineName) and
     (WmiConnection1.Connected) then
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
    WmiConnection1.Connected := false;
    if ANode.Text = LOCAL_HOST then
    begin
      // connect to local host;
      WmiConnection1.Credentials.Clear;
      WmiConnection1.MachineName := '';
      WmiConnection1.Connected := true;
      Result := true;
    end else
    begin
      if (ANode.Data = nil) then
      begin
        // connect for the first time
        // try default credentials fisrt:
        try
          WmiConnection1.Credentials.Clear;
          WmiConnection1.MachineName := ANode.Text;
          WmiConnection1.Connected := true;
          Result := true;
        except
          // expected exception: the credentials are not valid
        end;

        // default credentials did not work.
        // try to connect with user's provided credentials
        if not WmiConnection1.Connected then
        begin
          vForm := TFrmNewHost.Create(nil);
          vForm.MachineName := ANode.Text;
          try
            while vForm.ShowModal = mrOk do
              try
                WmiConnection1.Connected := false;
                WmiConnection1.Credentials.Clear;
                WmiConnection1.MachineName := ANode.Text;
                WmiConnection1.Credentials.UserName := vForm.UserName;
                WmiConnection1.Credentials.Password := vForm.edtPassword.Text;
                WmiConnection1.Connected := true;

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
        WmiConnection1.MachineName := ANode.Text;
        WmiConnection1.Credentials.UserName := vCredentials.UserName;
        WmiConnection1.Credentials.Password := vCredentials.Password;
        WmiConnection1.Connected := true;
        Result := true;
      end;
    end;
  finally
    RestoreCursor;
  end;
end;

procedure TFrmMain.SetWaitCursor;
begin
  Screen.Cursor := crHourGlass;
end;

procedure TFrmMain.RestoreCursor;
begin
  Screen.Cursor := crDefault;
end;


{ TCredentials }

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  FHistory := TStringList.Create;
  FHistory.Duplicates := dupIgnore;
  FHistory.Add('select DefaultIPGateway from Win32_NetworkAdapterConfiguration '+
               'where IPEnabled = true');
  FHistory.Add('select * FROM  Win32_PerfRawData_PerfOS_Processor');
  FHistory.Add('select * from Win32_UserAccount');
  FHistory.Add('select Domain, Name from Win32_Group');
  FHistory.Add('select * from Win32_Service where state="Running"');
  FHistory.Add('ASSOCIATORS OF {Win32_Group.Domain="BUILTIN",Name="Administrators"}'#$0D0A+
               'WHERE ResultClass = Win32_UserAccount');
  FHistory.Add('select * from Win32_DiskDrive');
  FHistoryIndex := FHistory.Count - 1;

  Application.OnShowHint := OnShowHint;
  InitItems;
end;

procedure TFrmMain.InitItems;
var
  vItem: TTreeNode;
begin
  tvBroswer.Items.Add(nil, LOCAL_HOST);
  vItem := tvBroswer.Items.Add(nil, NETWORK);
  tvBroswer.Items.AddChild(vItem, NO_DATA);
end;


procedure TFrmMain.tvBroswerExpanding(Sender: TObject; Node: TTreeNode;
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
    if (ANode.Text = NETWORK) then Result := LoadRemoteHosts(ANode)
  end
end;

function TFrmMain.LoadRemoteHosts(ANode: TTreeNode): boolean;
var
  AList: TStrings;
  i: integer;
begin
  ANode.DeleteChildren;
  AList := TStringList.Create;
  SetWaitCursor;
  try
    WmiConnection1.ListServers(AList);
    for i := 0 to AList.Count - 1 do
    begin
      tvBroswer.Items.AddChild(ANode, AList[i]);
    end;
  finally
    AList.Free;
    RestoreCursor;
  end;
  Result := true;
end;

procedure TFrmMain.tvBroswerChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  ProcessChangingNode(Node);
end;

procedure TFrmMain.ProcessChangingNode(Node: TTreeNode);
var
  vCredentials: TCredentials;
begin
  if Node.Text = LOCAL_HOST then
  begin
    DoConnect(Node);
    tlbConnect.Down := true;
  end else
  if Node.Text = NETWORK then
  begin
    tlbConnect.Down := false;
    WmiConnection1.Connected := false;
  end else
  begin
    vCredentials := TCredentials (Node.Data);
    tlbConnect.Down := vCredentials <> nil;
    if vCredentials <> nil then DoConnect(Node);
  end;
  SetButtonState;  
end;

procedure TFrmMain.tlbNewHostClick(Sender: TObject);
begin
  CreateNewNetworkNode;
  SetButtonState;
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

        WmiConnection1.Connected := false;
        WmiConnection1.Credentials.Clear;
        WmiConnection1.MachineName := vForm.edtHostName.Text;
        WmiConnection1.Credentials.UserName := vForm.UserName;
        WmiConnection1.Credentials.Password := vForm.edtPassword.Text;
        WmiConnection1.Connected := true;

        // connected successfully; add the new host to a list.
        vNode := FindNeworkNode;
        if (vNode.getFirstChild <> nil) and
           (vNode.getFirstChild.Text = NO_DATA) then vNode.DeleteChildren;

        vNode := tvBroswer.Items.AddChild(vNode, vForm.edtHostName.Text);
        vNode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
        tvBroswer.Selected := vNode;
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
  for i := 0 to tvBroswer.Items.Count - 1 do
    if tvBroswer.Items[i].Text = NETWORK then
    begin
      Result := tvBroswer.Items[i];
      Exit;
    end;
end;

procedure TFrmMain.tlbExecuteClick(Sender: TObject);
var
  vStartTime: TDateTime;
  execTime: integer;
begin
  WmiQuery1.Active := false;
  WmiQuery1.WQL.Text := memWQL.Lines.Text;

  SetWaitCursor;
  try
    vStartTime := Now;
    WmiQuery1.Active := true;
    execTime := Trunc((Now - vStartTime) / SECOND);
    StatusBar.Panels[0].Text := 'Execution time: ' +
                                IntToStr(execTime) + ' sec';
  finally
    RestoreCursor;
  end;

  // remember executed query in the history.
  if FHistory.IndexOf(memWQL.Text) = -1 then
    FHistory.Add(memWQL.Text);
  FHistoryIndex := FHistory.Count - 1;
  SetButtonState;
end;

procedure TFrmMain.tlbConnectClick(Sender: TObject);
var
  vObject: TObject;
begin
  // connect to remote host.
  vObject := TObject(tvBroswer.Selected.Data);
  if vObject = nil then
  begin
    tlbConnect.Down := doConnect(tvBroswer.Selected);    
  end else
  begin
    WmiConnection1.Connected := false;
    vObject.Free;
    tvBroswer.Selected.Data := nil;
    tlbConnect.Down := false;
  end;
end;

procedure TFrmMain.SetButtonState;
var
  ANode: TTreeNode;
begin
  if tvBroswer.Selected <> nil then
  begin
    ANode := tvBroswer.Selected;
    tlbConnect.Enabled := (ANode.Text <> LOCAL_HOST) and
                          (ANode.Text <> NETWORK);
    tlbExecute.Enabled := WmiConnection1.Connected;
  end else
  begin
    tlbConnect.Enabled := false;
    tlbExecute.Enabled := false;
  end;

  tlbPrevQuery.Enabled := FHistoryIndex > 0;
  tlbNextQuery.Enabled := FHistoryIndex < FHistory.Count - 1;

end;

procedure TFrmMain.tvBroswerChange(Sender: TObject; Node: TTreeNode);
begin
  SetButtonState;
end;

procedure TFrmMain.tvBroswerCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with tvBroswer.Canvas do
  begin
    // show connected server with underlined font.
    if (Node.Data <> nil) or (Node.Text = LOCAL_HOST) then
    begin
      Font.Style := Font.Style + [fsUnderline];
    end;
  end;  
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FHistory.Free;
end;

procedure TFrmMain.tlbPrevQueryClick(Sender: TObject);
begin
  Dec(FHistoryIndex);
  memWQL.Lines.Text := FHistory[FHistoryIndex];
  SetButtonState
end;

procedure TFrmMain.tlbNextQueryClick(Sender: TObject);
begin
  Inc(FHistoryIndex);
  memWQL.Lines.Text := FHistory[FHistoryIndex];
  SetButtonState
end;

procedure TFrmMain.WmiQuery1BeforeScroll(DataSet: TDataSet);
begin
  // SetWaitCursor;
end;

procedure TFrmMain.WmiQuery1AfterScroll(DataSet: TDataSet);
begin
  // RestoreCursor;
end;

procedure TFrmMain.chbIrregularClick(Sender: TObject);
begin
  WmiQuery1.IrregularView := chbIrregular.Checked;
  DBGrid1.ShowHint        := chbIrregular.Checked;
end;

procedure TFrmMain.OnShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
begin
  if (HintInfo.HintControl = DBGrid1)
     and (WmiQuery1.Active)
     and (not WmiQuery1.EOF)
     and (WmiQuery1.IrregularView) then
  begin
    HintStr := WmiQuery1.Fields[0].AsString;
    HintInfo.HideTimeout := 20000;
  end else
  begin
    HintStr := '';
  end;
end;

procedure TFrmMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmMain.WmiConnection1AfterConnect(Sender: TObject);
begin
  cmbClasses.Items.Clear;
  WmiConnection1.ListClasses(cmbClasses.Items);
  cmbClasses.Sorted := true;
end;

procedure TFrmMain.spbInsertClick(Sender: TObject);
begin
  if cmbClasses.Text <> '' then
  begin
    memWQL.SelLength := 0;
    memWQL.Seltext := cmbClasses.Text;
    memWQL.Sellength := 0;
  end;
end;

procedure TFrmMain.cmbNameSpaceCloseUp(Sender: TObject);
var
  vWasConnected: boolean;
  vOldNameSpace: widestring;
  vCursor: TCursor; 
begin
  vCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    vWasConnected := WmiConnection1.Connected;
    vOldNameSpace := WmiConnection1.NameSpace;
    if WmiConnection1.Connected then WmiConnection1.Connected := false;
    try
      WmiConnection1.NameSpace := cmbNameSpace.Text;
      WmiConnection1.Connected := vWasConnected;
    except
      cmbNameSpace.ItemIndex := cmbNameSpace.Items.IndexOf(vOldNameSpace);
      WmiConnection1.NameSpace := vOldNameSpace;
      WmiConnection1.Connected := vWasConnected;
      raise;
    end;
  finally
    Screen.Cursor := vCursor;
  end;
end;

end.
