unit uExtendedCheckListBox;

interface

uses
  Classes, Controls, CheckLst;

(*
 * TExtendedCheckListBox adds functionality to the base TCheckListBox to more
 * conveniently get and set current selections without having to code iteration
 * over the checked collection every time - this is now done here instead
 *)

type
  TExtendedCheckListBox = class(TCheckListBox)
  private
    FCurrentSelections : TStringList;
    FObserverList : TInterfaceList;
    procedure setCurrentSelections(newSelections : TStringList);
    function getCurrentSelections : TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearSelection; override; // overrides the base procedure to add clearing checkboxes as well as selection status
    procedure CheckAll;
    function AnySelectionsMade : boolean; // returns true if any boxes are checked
    function AllSelected : boolean;

    property CurrentSelections : TStringList read getCurrentSelections write setCurrentSelections;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Zonal', [TExtendedCheckListBox]);
end;

constructor TExtendedCheckListBox.Create(AOwner : TComponent);
begin
  inherited;
  FCurrentSelections := TStringList.Create;
  FObserverList := TInterfaceList.Create;
end;

destructor TExtendedCheckListBox.Destroy;
begin
  FCurrentSelections.Free;
  FObserverList.Free;
  Inherited;
end;

function TExtendedCheckListBox.GetCurrentSelections : TStringList;
var
  i : integer;
begin
  FCurrentSelections.Clear;
  for i := 0 to Items.Count - 1 do
  begin
    if Checked[i] then
      FCurrentSelections.Add(Items[i]);
  end;
  result := FCurrentSelections;
end;

procedure TExtendedCheckListBox.SetCurrentSelections(newSelections: TStringList);
var
  i : integer;
  selectionIndex : integer;
begin
  clearSelection;
  for i := 0 to newSelections.Count - 1 do
  begin
    selectionIndex := Items.IndexOf(newSelections[i]);
    if (selectionIndex <> -1) then
      Checked[selectionIndex] := true;
  end;
end;

function TExtendedCheckListBox.AnySelectionsMade : boolean;
var i: integer;
begin
  result := false;
  for i := 0 to Items.Count - 1 do
  begin
    if Checked[i] then
    begin
      result := true;
      break;
    end;
  end;
end;

function TExtendedCheckListBox.AllSelected : boolean;
var i: integer;
begin
  result := true;
  for i := 0 to Items.Count - 1 do
  begin
    if not Checked[i] then
    begin
      result := false;
      break;
    end;
  end;
end;

procedure TExtendedCheckListBox.CheckAll;
var
  i : integer;
begin
  for i := 0 to Items.Count - 1 do
    Checked[i] := true;
end;

procedure TExtendedCheckListBox.ClearSelection;
var
  i : integer;
begin
  for i := 0 to Items.Count - 1 do
    Checked[i] := false;
  inherited;
end;

end.
