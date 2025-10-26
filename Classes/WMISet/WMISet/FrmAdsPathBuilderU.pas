unit FrmAdsPathBuilderU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, AdsBrowser, ImgList;

type
  TFrmAdsPathBuilder = class(TForm)
    pnlButtons: TPanel;
    pnlResult: TPanel;
    edtPath: TEdit;
    pblPath: TLabel;
    tvDirectory: TTreeView;
    AdsBrowser: TAdsBrowser;
    ilTree: TImageList;
    pnlRight: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure tvDirectoryExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvDirectoryChange(Sender: TObject; Node: TTreeNode);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    FObjectName: widestring;

    function  GetObjectName: widestring;
    procedure SetObjectName(const Value: widestring);
    procedure GetFiltersForNode(ANode: TTreeNode; AFilters: TStrings);
    procedure LoadNodeChildren(ANode: TTreeNode);
    procedure LoadNodeFilters(ANode: TTreeNode; AFilters: TStrings);
    function  GetAdsPath(ANode: TTreeNode): string;
    function  GetNodeType(ANode: TTreeNode): integer;
    function  GetImageIndex(AClassName: string): integer;
    procedure SetNodeType(ANode: TTreeNode; AType: integer);
    { Private declarations }
  public
    { Public declarations }
    property ObjectName: widestring read GetObjectName write SetObjectName;
  end;

var
  FrmAdsPathBuilder: TFrmAdsPathBuilder;

implementation

{$R *.DFM}

const
  IMAGE_UNKNOWN   = 0;
  IMAGE_NAMESPACE = 1;
  IMAGE_DOMAIN    = 2;
  IMAGE_COMPUTER  = 3;
  IMAGE_FILTER    = 4;
  IMAGE_USER      = 5;
  IMAGE_GROUP     = 6;
  IMAGE_SERVICE   = 7;
  IMAGE_FILESERVICE = 8;
  IMAGE_PRINTQUEUE  = 9;


  NODE_DATA = 0;
  NODE_FILTER = 1;

{ TFrmAdsPathBuilder }

function TFrmAdsPathBuilder.GetObjectName: widestring;
begin
  Result := FObjectName;
end;

procedure TFrmAdsPathBuilder.SetObjectName(const Value: widestring);
begin
  FObjectName := Value;
end;

procedure TFrmAdsPathBuilder.FormShow(Sender: TObject);
var
  vList: TStrings;
  i: integer;
  vNode: TTreeNode;
begin
  vList := TStringList.Create;
  try
    AdsBrowser.GetNameSpaces(vList);
    for i := 0 to vList.Count - 1 do
    begin
      vNode := tvDirectory.Items.AddChild(nil, vList[i]);
      vNode.ImageIndex := IMAGE_NAMESPACE;
      vNode.SelectedIndex := vNode.ImageIndex;
      tvDirectory.Items.AddChild(vNode, '');
    end;
  finally
    vList.Free;
  end;
end;

procedure TFrmAdsPathBuilder.tvDirectoryExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var
  vList: TStrings;
begin
  if (Node.HasChildren) and
     (Node.getFirstChild <> nil) and
     (Node.getFirstChild.Text = '') then
  begin
    Node.DeleteChildren;
    if GetNodeType(Node) = NODE_FILTER then
    begin
      // if current node is a filter node - load children
      LoadNodeChildren(Node);
      Exit;
    end;

    // check if current node has filters
    // if it has - use filters to reduce amount of loaded data
    vList := TStringList.Create;
    try
      GetFiltersForNode(Node, vList);
      if vList.Count > 0 then LoadNodeFilters(Node, vList)
        else LoadNodeChildren(Node);
    finally
      vList.Free;
    end;
  end;
end;

function TFrmAdsPathBuilder.GetNodeType(ANode: TTreeNode): integer;
begin
  Result := integer(ANode.Data);
end;

procedure TFrmAdsPathBuilder.SetNodeType(ANode: TTreeNode; AType: integer);
begin
  ANode.Data := Pointer(AType);
end;

function TFrmAdsPathBuilder.GetAdsPath(ANode: TTreeNode): string;
begin
  Result := '';
  while true do
  begin
    if GetNodeType(ANode) = NODE_DATA then
    begin
      if ANode.Level = 0 then
      begin
        // handle namespace
        if Result <> '' then Result := ANode.Text + '//' + Result
          else Result := ANode.Text;
      end else
      begin   
        // handle data node
        if Result = '' then Result := ANode.Text
          else Result := ANode.Text + '/' + Result; 
      end;  
    end;

    ANode := ANode.Parent;
    if ANode = nil then Exit;
  end;

end;

procedure TFrmAdsPathBuilder.GetFiltersForNode(ANode: TTreeNode; AFilters: TStrings);
begin
  Screen.Cursor := crHourGlass;
  try
    AdsBrowser.ObjectPath := GetAdsPath(ANode);
    AdsBrowser.Active := true;
    try
      try 
        AFilters.Assign(AdsBrowser.AdsClassInfo.Containment);
      except
        // expected exception: NDS does not implement containment property.
      end;
    finally
      AdsBrowser.Active := false;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmAdsPathBuilder.LoadNodeFilters(ANode: TTreeNode; AFilters: TStrings);
var
  i: integer;
  vNode: TTreeNode;
begin
  for i := 0 to AFilters.Count - 1 do
  begin
    vNode := tvDirectory.Items.AddChild(ANode, AFilters[i]);
    vNode.ImageIndex    := IMAGE_FILTER;
    vNode.SelectedIndex := vNode.ImageIndex;
    SetNodeType(vNode, NODE_FiLTER);
    tvDirectory.Items.AddChild(vNode, '');
  end;

end;

function TFrmAdsPathBuilder.GetImageIndex(AClassName: string): integer;
begin
  AClassName := Uppercase(AClassName);
  if AClassName = 'NAMESPACE' then Result := IMAGE_NAMESPACE else
  if AClassName = 'DOMAIN' then Result := IMAGE_DOMAIN else
  if AClassName = 'COMPUTER' then Result := IMAGE_COMPUTER else
  if AClassName = 'USER' then Result := IMAGE_USER else
  if AClassName = 'GROUP' then Result := IMAGE_GROUP else
  if AClassName = 'SERVICE' then Result := IMAGE_SERVICE else
  if AClassName = 'FILESERVICE' then Result := IMAGE_FILESERVICE else
  if AClassName = 'PRINTQUEUE' then Result := IMAGE_PRINTQUEUE else
  Result := 0;

end;

procedure TFrmAdsPathBuilder.LoadNodeChildren(ANode: TTreeNode);
var
  vList: TStrings;
  vNode: TTreeNode;
  vImageIndex: integer;
  i: integer;
  s: string;
begin
  Screen.Cursor := crHourGlass;
  try
    AdsBrowser.ObjectPath := GetAdsPath(ANode);
    if GetNodeType(ANode) = NODE_FILTER then
      AdsBrowser.ChildFilter := ANode.Text;

    vList := TStringList.Create;
    try
      AdsBrowser.Active := true;
      try
        vList.Assign(AdsBrowser.ChildItems);
      finally
        AdsBrowser.Active := false;
      end;

      if vList.Count > 0 then
      begin
        // create children nodes
        for i := 0 to vList.Count - 1 do
        begin
          vNode := tvDirectory.Items.AddChild(ANode, vList[i]);
          tvDirectory.Items.AddChild(vNode, '');
        end;

        // This code utilizes ADS filter in a way that all children of a node are
        // of the same type. Check type of the first child node. Assign the same
        // icon to all children
        vNode := ANode.getFirstChild;
        AdsBrowser.ObjectPath := GetAdsPath(vNode);
        AdsBrowser.Active := true;
        try
          s := AdsBrowser.ObjectClassName;
        finally
          AdsBrowser.Active := false;
        end;

        vImageIndex := GetImageIndex(s);
        repeat
          vNode.ImageIndex := vImageIndex;
          vNode.SelectedIndex := vNode.ImageIndex;
          vNode := ANode.GetNextChild(vNode);
        until vNode = nil;

      end;

    finally
      vList.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TFrmAdsPathBuilder.tvDirectoryChange(Sender: TObject;
  Node: TTreeNode);
begin
  edtPath.Text := GetAdsPath(Node);
end;

procedure TFrmAdsPathBuilder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Exit;
  end;
end;

procedure TFrmAdsPathBuilder.btnOkClick(Sender: TObject);
begin
  FObjectName := edtPath.Text;
end;

end.
