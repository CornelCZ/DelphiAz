unit uPortionFilterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, uExtendedCheckListBox, ExtCtrls;

type
  TPortionFilterForm = class(TForm)
    clbPortionTypes: TExtendedCheckListBox;
    btnOK: TButton;
    btnCancel: TButton;
    cbAllNone: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cbAllNoneClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure clbPortionTypesClickCheck(Sender: TObject);
  private
    FSelectedIds: TList;

    procedure SaveSelections;
    procedure RestoreSelections;
    procedure PopulateFromDB;
    procedure Refresh;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FilterApplied: boolean; // Return true if any portion types are not selected
    function NoneSelected: boolean; //Return true if no portion types are selected.
    function SelectedPortionTypesAsCommaSeparatedString: string;
    procedure SelectedPortionTypesAsIntList(var portionTypeIdList: TList);
  end;

implementation

uses uDatabaseADO, uGuiUtils;

{$R *.dfm}

constructor TPortionFilterForm.Create(AOwner: TComponent);
begin
  inherited;
  FSelectedIds := TList.Create;

  PopulateFromDB;
  clbPortionTypes.CheckAll;
  SaveSelections;
end;

destructor TPortionFilterForm.Destroy;
begin
  FSelectedIds.Free;
  inherited;
end;

function TPortionFilterForm.FilterApplied: boolean;
begin
  result := not clbPortionTypes.AllSelected;
end;

function TPortionFilterForm.NoneSelected: boolean;
begin
  Result := FSelectedIds.Count = 0;
end;

function TPortionFilterForm.SelectedPortionTypesAsCommaSeparatedString: string;
var
  i: integer;
  first: boolean;
  idStr: string;
begin
  result := '';
  first := true;

  for i := 0 to FSelectedIds.Count - 1 do
  begin
     idStr := IntToStr(Integer(FSelectedIds[i]));

    if first then
      result := result + idStr
    else
      result := result + ',' + idStr;

    first := false;
  end
end;

procedure TPortionFilterForm.SelectedPortionTypesAsIntList(var portionTypeIdList: TList);
begin
  portionTypeIdList.Assign(FSelectedIds);
end;

procedure TPortionFilterForm.SaveSelections;
var
  i: integer;
begin
  FSelectedIds.Clear;
  FSelectedIds.Capacity := clbPortionTypes.Count;

  for i := 0 to clbPortionTypes.Count - 1 do
  begin
    if clbPortionTypes.Checked[i] then
      FSelectedIds.Add(Pointer(clbPortionTypes.Items.Objects[i]));
  end;
end;

procedure TPortionFilterForm.RestoreSelections;
var
  i, selectedIndex: integer;
begin
  clbPortionTypes.ClearSelection;
  for i := 0 to FSelectedIds.Count - 1 do
  begin
    selectedIndex := clbPortionTypes.Items.IndexOfObject(Pointer(FSelectedIds[i]));
    if selectedIndex <> -1 then
      clbPortionTypes.Checked[selectedIndex] := true;
  end;
end;

procedure TPortionFilterForm.PopulateFromDB;
var
  portionTypes: TStringList;
begin
  portionTypes := TStringList.Create;
  try
    ProductsDB.GetPortionTypesInUse(portionTypes);
    clbPortionTypes.Clear;
    clbPortionTypes.Items.AddStrings(portionTypes);
  finally
    portionTypes.Free;
  end;
end;

procedure TPortionFilterForm.Refresh;
var allSelected: boolean;
begin
  allSelected := false;

  if clbPortionTypes.AllSelected then
    allSelected := true;

  PopulateFromDB;

  if allSelected then
  begin
    clbPortionTypes.CheckAll;
    SaveSelections;
  end
  else
  begin
    RestoreSelections;
  end;
end;


procedure TPortionFilterForm.FormShow(Sender: TObject);
begin
  Refresh;
end;

procedure TPortionFilterForm.cbAllNoneClick(Sender: TObject);
begin
  if cbAllNone.Checked then
    clbPortionTypes.CheckAll
  else
    clbPortionTypes.ClearSelection;
end;

procedure TPortionFilterForm.btnCancelClick(Sender: TObject);
begin
  RestoreSelections;
  setCbStateWithNoEvent(cbAllNone, clbPortionTypes.AllSelected);
end;

procedure TPortionFilterForm.btnOKClick(Sender: TObject);
begin
  SaveSelections;
end;

procedure TPortionFilterForm.clbPortionTypesClickCheck(Sender: TObject);
begin
  setCbStateWithNoEvent(cbAllNone, clbPortionTypes.AllSelected);
end;

end.
