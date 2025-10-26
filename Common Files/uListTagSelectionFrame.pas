unit uListTagSelectionFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uBaseTagFrame,
  StdCtrls;

type
  TfrmListTagSelectionFrame = class(TfrmBaseTagFrame)
    lblTagName: TLabel;
    cmbTagList: TComboBox;
  protected
    { Protected declarations }
    procedure SetTagID(Value: Integer); override;
    function GetTagName: string; override;
    function GetTagID: Integer; override;
    function GetTagSelected: Boolean; override;
  public
    { Public declarations }
    procedure InitialiseFrame; override;
    procedure ClearSelected; override;
    procedure AddChild(ChildID: integer; ChildName: String);
  end;

implementation

{$R *.dfm}

function TfrmListTagSelectionFrame.GetTagID: Integer;
begin
  if TagSelected then
    Result := Integer(cmbTagList.Items.Objects[cmbTagList.ItemIndex])
  else
    Result := -1;
end;

function TfrmListTagSelectionFrame.GetTagSelected: Boolean;
begin
  Result := cmbTagList.ItemIndex > 0;
end;

procedure TfrmListTagSelectionFrame.InitialiseFrame;
begin
  cmbTagList.Style := csDropDownList;
  cmbTagList.Tag := ParentTagID;
  cmbTagList.Items.AddObject('<none>',nil);
  cmbTagList.ItemIndex := 0;
  lblTagName.Caption := DisplayParentTagName;
  if Assigned(FOnChangeHandler) then
    cmbTagList.OnChange := FOnChangeHandler;
end;

procedure TfrmListTagSelectionFrame.AddChild(ChildID: integer; ChildName: String);
begin
  cmbTagList.items.AddObject(ChildName, Pointer(ChildID));
end;

procedure TfrmListTagSelectionFrame.SetTagID(Value: Integer);
var
  i: Integer;
begin
  for i := 0 to cmbTagList.Items.Count - 1 do
  begin
    if cmbTagList.Items.Objects[i] <> nil then
      if Integer(cmbTagList.Items.Objects[i]) = Value then
      begin
        cmbTagList.ItemIndex := i;
        Break;
      end;
  end;
end;

function TfrmListTagSelectionFrame.GetTagName: string;
begin
  if TagSelected then
    Result := cmbTagList.Text;
end;

procedure TfrmListTagSelectionFrame.ClearSelected;
begin
  cmbTagList.ItemIndex := 0;
end;

end.
