unit uSingleTagSelectionFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uBaseTagFrame,
  StdCtrls;

type
  TfrmSingleTagSelectionFrame = class(TfrmBaseTagFrame)
    chkbxTagSelected: TCheckBox;
    lblTagName: TLabel;
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
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TfrmSingleTagSelectionFrame.ClearSelected;
begin
  chkbxTagSelected.Checked := False;
end;

function TfrmSingleTagSelectionFrame.GetTagID: Integer;
begin
  if TagSelected then
    Result := ParentTagID
  else
    Result := -1;
end;

function TfrmSingleTagSelectionFrame.GetTagName: string;
begin
  if TagSelected then
    Result := ParentTagName;
end;

function TfrmSingleTagSelectionFrame.GetTagSelected: Boolean;
begin
  Result := chkbxTagSelected.Checked;
end;

procedure TfrmSingleTagSelectionFrame.InitialiseFrame;
begin
  lblTagName.Caption := DisplayParentTagName;
  if Assigned(FOnChangeHandler) then
    chkbxTagSelected.OnClick := FOnChangeHandler;
end;

procedure TfrmSingleTagSelectionFrame.SetTagID(Value: Integer);
begin
  if Value = ParentTagID then
    chkbxTagSelected.Checked := True;
end;

end.
