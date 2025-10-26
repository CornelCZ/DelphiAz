unit FrmRegBrowserU;
{$I DEFINE.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ComCtrls, ImgList, WmiRegistry,
  NTStringTokenizer;

type
  TFrmRegBrowser = class(TForm)
    tvRegistry: TTreeView;
    btnOk: TButton;
    btnCancel: TButton;
    imlFolders: TImageList;
    edtPath: TEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tvRegistryExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvRegistryGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvRegistryChange(Sender: TObject; Node: TTreeNode);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FRegistry: TWmiRegistry;
    procedure InitTree;
    procedure AddChildren(ANode: TTreeNode);
    function  FindChildByName(ANode: TTreeNode; AName: string): TTreeNode;
    function  GetNodePath(ANode: TTreeNode): string;
    function  GetCurrentPath: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ARegistry: TWmiRegistry); reintroduce;
    destructor  Destroy; override;
    property CurrentPath: string read GetCurrentPath;
  end;

var
  FrmRegBrowser: TFrmRegBrowser;

implementation

{$R *.DFM}

function TFrmRegBrowser.GetNodePath(ANode: TTreeNode): string;
begin
  Result := '';
  while ANode.Parent <> nil do
    begin  Result := ANode.Text+'\'+Result; ANode := ANode.Parent; end;
  if (Length(Result) > 0) and (Result[Length(Result)] = '\') then
    Result := Copy(Result, 1, Length(Result) - 1);
end;


procedure TFrmRegBrowser.AddChildren(ANode: TTreeNode);
var
  Path: string;
  vList: TStringList;
  i: integer;
  tmpNode: TTreeNode;
begin
  tvRegistry.Items.BeginUpdate;
  try
    Path    := GetNodePath(ANode);
    tmpNode := ANode;
    if tmpNode.HasChildren then tmpNode.DeleteChildren;

    FRegistry.CurrentPath := Path;
    vList := TStringList.Create;
    try
      FRegistry.ListSubKeys(vList); 
      vList.Sorted := true;
      for i := 0 to vList.Count - 1 do
      begin
        tmpNode := tvRegistry.Items.AddChild(ANode, vList[i]);
        tvRegistry.Items.AddChild(tmpNode, '');
      end;
    finally
      vList.Free;
    end;
  finally
    tvRegistry.Items.EndUpdate;
  end;
end;

procedure TFrmRegBrowser.InitTree;
var
  vCurrentNode: TTreeNode;
  vTokenizer: TNTStringTokenizer;
begin
  try
    Screen.Cursor := crHourGlass;
    tvRegistry.Items.Clear;
    vCurrentNode := tvRegistry.Items.Add(nil, FRegistry.RegRootToString(FRegistry.RootKey));
    vTokenizer := TNTStringTokenizer.Create(FRegistry.CurrentPath, '\');
    while not vTokenizer.EndOfString do
    begin
      AddChildren(vCurrentNode);
      vCurrentNode := FindChildByName(vCurrentNode, vTokenizer.NextToken);
      if vCurrentNode = nil then Break;
    end;

    if vCurrentNode <> nil then
    begin
      tvRegistry.Items.AddChild(vCurrentNode, '');
      tvRegistry.Selected := vCurrentNode;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TFrmRegBrowser.FindChildByName(ANode: TTreeNode; AName: string): TTreeNode;
var
  tmpNode: TTreeNode;
begin
  Result := nil;
  if (ANode = nil) or (not ANode.HasChildren) then Exit;
  tmpNode := ANode.GetFirstChild;
  AName := UpperCase(Trim(AName));
  while (tmpNode <> nil) do
    if (UpperCase(Trim(tmpNode.Text)) = AName) then begin Result := tmpNode; Break end
      else tmpNode := ANode.GetNextChild(tmpNode);
end;

procedure TFrmRegBrowser.FormShow(Sender: TObject);
begin
  InitTree;
end;

procedure TFrmRegBrowser.tvRegistryExpanded(Sender: TObject;
  Node: TTreeNode);
var
  tmpNode: TTreeNode;
begin
  try
  Screen.Cursor := crHourGlass;
  tmpNode := Node.GetFirstChild;
  if (tmpNode <> nil) and (tmpNode.Text = '') then
      begin
      tvRegistry.Items.Delete(tmpNode);
      AddChildren(Node);
      end;
  finally
  Screen.Cursor := crDefault;
  end;
end;

procedure TFrmRegBrowser.tvRegistryGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if not Node.HasChildren then Node.ImageIndex := 1 else
    begin
    if Node.Expanded then Node.ImageIndex := 0 else Node.ImageIndex := 2;
    end;
  Node.StateIndex    := Node.ImageIndex;
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TFrmRegBrowser.tvRegistryChange(Sender: TObject;
  Node: TTreeNode);
begin
  edtPath.Text := GetNodePath(Node);
end;

procedure TFrmRegBrowser.btnOkClick(Sender: TObject);
begin
  FRegistry.CurrentPath := edtPath.Text;
end;

constructor TFrmRegBrowser.Create(AOwner: TComponent; ARegistry: TWmiRegistry);
begin
  inherited Create(AOwner);
  FRegistry := TWmiRegistry.Create(nil);
  FRegistry.Credentials.Assign(ARegistry.Credentials);
  FRegistry.RootKey := ARegistry.RootKey;
  FRegistry.CurrentPath := ARegistry.CurrentPath;
  FRegistry.MachineName := ARegistry.MachineName;
  FRegistry.Active := true;
  if FRegistry.MachineName <> '' then
    Caption := Caption + ' on ' + FRegistry.MachineName;
end;

destructor TFrmRegBrowser.Destroy;
begin
  FRegistry.Free;
  inherited;
end;

function TFrmRegBrowser.GetCurrentPath: string;
begin
  Result := edtPath.Text;
end;

end.
  