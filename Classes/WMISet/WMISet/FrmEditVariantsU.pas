unit FrmEditVariantsU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ImgList, AdsBrowser,
  {$IFDEF Delphi6}
  Variants, 
  {$ENDIF}
  ExtCtrls, StdCtrls;

type
  TFrmEditVariants = class(TForm)
    tbMain: TToolBar;
    ilToolbar: TImageList;
    lvValues: TListView;
    tbNew: TToolButton;
    tbDelete: TToolButton;
    ToolButton3: TToolButton;
    tbUp: TToolButton;
    tbDown: TToolButton;
    pnlButtons: TPanel;
    pnlRight: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure lvValuesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure tbDeleteClick(Sender: TObject);
    procedure lvValuesEdited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure tbNewClick(Sender: TObject);
    procedure tbUpClick(Sender: TObject);
    procedure tbDownClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FVariants: TAdsVariants;
    FMultiValued: boolean;
    procedure SetVariants(const Value: TAdsVariants);
    function GetVariants: TAdsVariants;
    procedure RefreshListView;
    procedure SetButtonsState;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Variants: TAdsVariants read GetVariants write SetVariants;
    property MultiValued: boolean read FMultiValued write FMultiValued;
  end;

var
  FrmEditVariants: TFrmEditVariants;

implementation

{$R *.dfm}

{ TFrmEditVariants }

constructor TFrmEditVariants.Create(AOwner: TComponent);
begin
  inherited;
  FVariants := TAdsVariants.Create;
end;

destructor TFrmEditVariants.Destroy;
begin
  FVariants.Free;
  inherited;
end;

procedure TFrmEditVariants.SetVariants(const Value: TAdsVariants);
begin
  FVariants.Assign(Value);
  RefreshListView;
end;

function TFrmEditVariants.GetVariants: TAdsVariants;
begin
  Result := FVariants;
end;

procedure TFrmEditVariants.RefreshListView;
var
  i: integer;
  vItem: TListItem;
begin
  lvValues.Items.Clear;
  for i := 0 to FVariants.Count - 1 do
  begin
    vItem := lvValues.Items.Add;
    vItem.Caption := VarToStr(FVariants[i]);
    vItem.StateIndex := 0;
  end;
end;


procedure TFrmEditVariants.SetButtonsState;
begin
  tbNew.Enabled := MultiValued;
  tbDelete.Enabled := (lvValues.Selected <> nil) and MultiValued;
  tbUp.Enabled := tbDelete.Enabled;
  tbDown.Enabled := tbDelete.Enabled;
end;

procedure TFrmEditVariants.lvValuesChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  SetButtonsState;
end;

procedure TFrmEditVariants.tbDeleteClick(Sender: TObject);
begin
  FVariants.Delete(lvValues.Selected.Index);
  RefreshListView;
end;

procedure TFrmEditVariants.lvValuesEdited(Sender: TObject; Item: TListItem;
  var S: String);
begin
  FVariants[Item.Index] := S;
end;

procedure TFrmEditVariants.tbNewClick(Sender: TObject);
begin
  FVariants.Add(Unassigned);
  RefreshListView;
  lvValues.Items[lvValues.Items.Count - 1].EditCaption;
end;

procedure TFrmEditVariants.tbUpClick(Sender: TObject);
var
  vIndex: integer;
  vVar: variant;
begin
  vIndex := lvValues.Selected.Index;
  if vIndex <> 0 then
  begin
    vVar := FVariants[vIndex];
    FVariants.Delete(vIndex);
    FVariants.Insert(vVar, vIndex - 1);
    RefreshListView;
    lvValues.Selected := lvValues.Items[vIndex - 1];
  end;
end;

procedure TFrmEditVariants.tbDownClick(Sender: TObject);
var
  vIndex: integer;
  vVar: variant;
begin
  vIndex := lvValues.Selected.Index;
  if vIndex < lvValues.Items.Count - 1 then
  begin
    vVar := FVariants[vIndex];
    FVariants.Delete(vIndex);
    vIndex := vIndex + 1;
    if vIndex >= FVariants.Count then FVariants.Add(vVar)
      else FVariants.Insert(vVar, vIndex);
    RefreshListView;
    lvValues.Selected := lvValues.Items[vIndex];
  end;
end;

procedure TFrmEditVariants.FormResize(Sender: TObject);
begin
  lvValues.Column[0].Width := ClientWidth - 4;
end;

end.
