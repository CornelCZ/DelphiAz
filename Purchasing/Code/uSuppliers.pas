unit uSuppliers;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, Controls, StdCtrls, 
  Buttons, DB, ADODB;

type
  TfrmSuppliers = class(TForm)
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    qryUpdate: TADOQuery;
    qrySource: TADOQuery;
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    EditFieldName: string;
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
  end;

implementation

uses uADO, uConfigure;

{$R *.dfm}

procedure TfrmSuppliers.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

procedure TfrmSuppliers.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

procedure TfrmSuppliers.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I], 
      SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
end;

procedure TfrmSuppliers.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure TfrmSuppliers.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure TfrmSuppliers.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

function TfrmSuppliers.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TfrmSuppliers.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;

procedure TfrmSuppliers.BitBtn1Click(Sender: TObject);
var
  i: Integer;
  SuppName: String;
begin
  with qryUpdate do
  begin
    SQL.Clear;
    SQL.Add('update ac_Supplier');
    SQL.Add('set [' + EditFieldName + '] = 0');
    ExecSQL;
    Close;

    for i := 0 to DstList.Items.Count - 1 do
    begin
      SuppName := DstList.Items.Strings[i];

      SQL.Clear;
      SQL.Add('update ac_Supplier');
      SQL.Add('set [' + EditFieldName + '] = 1');
      SQL.Add('where [Name] = ' + QuotedStr(SuppName));
      ExecSQL;
      Close;

      if EditFieldName = EDIT_COST_PRICES then
      begin
        SQL.Clear;
        SQL.Add('update ac_Supplier');
        SQL.Add('SET [AddFreeItems] = 0');
        SQL.Add('where [Name] = ' + QuotedStr(SuppName));
        ExecSQL;
        Close;
      end;
    end;

    if EditFieldName = VIEW_COST_PRICES then
    begin
      for i := 0 to SrcList.Items.Count - 1 do
      begin
        SuppName := SrcList.Items.Strings[i];

        SQL.Clear;
        SQL.Add('update ac_Supplier');
        SQL.Add('SET [EditCostPrices] = 0');
        SQL.Add('where [Name] = ' + QuotedStr(SuppName));
        ExecSQL;
        Close;
      end;
    end;
  end;
end;

procedure TfrmSuppliers.FormShow(Sender: TObject);
begin
  SrcList.Clear;

  with qrySource do
  begin
    SQL.Clear;
    SQL.Add('select distinct Name from ac_Supplier');
    SQL.Add('where (([' + EditFieldName + '] = 0)');
    SQL.Add('or ([' + EditFieldName + '] is NULL))');

    if EditFieldName = EDIT_COST_PRICES then
      SQL.Add('and [DisplayCostPrices] = 1');

    if EditFieldName = ALLOW_FREE_ITEMS then
      SQL.Add('and [EditCostPrices] = 0');

    SQL.Add('Order By [Name]');
    Open;

    while not Eof do
    begin
      SrcList.Items.Add(FieldByName('Name').AsString);
      Next;
    end;

    Close;
  end;

  DstList.Clear;

  with qrySource do
  begin
    SQL.Clear;
    SQL.Add('select distinct [Name] from ac_Supplier');
    SQL.Add('where [' + EditFieldName + '] = 1');

    if EditFieldName = EDIT_COST_PRICES then
      SQL.Add('and [DisplayCostPrices] = 1');

    if EditFieldName = ALLOW_FREE_ITEMS then
      SQL.Add('and [EditCostPrices] = 0');

    SQL.Add('Order By [Name]');
    Open;

    while not Eof do
    begin
      DstList.Items.Add(FieldByName('Name').AsString);
      Next;
    end;

    Close;
  end;

  SetButtons;
end;

end.
