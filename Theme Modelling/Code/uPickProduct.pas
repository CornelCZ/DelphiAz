unit uPickProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, ADODB, Wwdbigrd, Wwdbgrid;

type
  TPickProduct = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    DataSource1: TDataSource;
    Label1: TLabel;
    dProducts: TADODataSet;
    dProductsProductId: TLargeintField;
    dProductsName: TStringField;
    dProductsSubCategory: TStringField;
    cmbbxSubcategory: TComboBox;
    lblSubcat: TLabel;
    wwdbgProducts: TwwDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dgProductsTitleClick(Column: TColumn);
    procedure btnOkClick(Sender: TObject);
    procedure cmbbxSubcategoryChange(Sender: TObject);
    procedure wwdbgProductsTitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    sortedColumn: string;
    sortOrder: string;
    procedure GetProductList;
    procedure PopulateSubcategoryCombo;
  public
    selectedProduct: int64;
  end;

implementation

uses uDMThemeData, uAztecLog;

{$R *.dfm}

procedure TPickProduct.btnOkClick(Sender: TObject);
begin
  buttonClicked(Sender);
  with wwdbgProducts do
  begin
    selectedProduct := TLargeIntField(datasource.dataset.fieldbyname('ProductId')).aslargeint;
    Log(datasource.dataset.FieldByName('Name').AsString + ' Selected From Pick Product List');
  end;
  modalresult := mrOk;
end;

procedure TPickProduct.GetProductList;
begin
  dProducts.CommandText :=
    'select cast([entitycode] as bigint) as ProductId, [Sub-Category Name] as Subcategory, [Extended Rtl Name] + ' +
    '  case isnull([retail description], '''') when '''' then '''' else ''  ('' + [retail description] + '')'' end as Name ' +
    'from Products ' +
    'where [Entity Type] in (''Strd.Line'', ''Recipe'') and isnull(Deleted, ''N'') = ''N'' ' +
    'order by [Sub-Category Name], [Extended Rtl Name]';
  dProducts.open;
end;

procedure TPickProduct.PopulateSubcategoryCombo;
begin
  cmbbxSubcategory.Items.Add('<Show All>');

  with dmThemeData.adoqRun do
  try
    SQL.Text := 'SELECT Name FROM ac_ProductSubcategory WHERE Deleted = 0 ORDER BY Name';
    Open;
    while not(Eof) do
    begin
      cmbbxSubcategory.Items.Add(FieldByName('Name').AsString);
      Next;
    end;
  finally
    Close;
  end;

  cmbbxSubcategory.ItemIndex := 0;
end;

procedure TPickProduct.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log('Form Close ' + Caption);
end;

procedure TPickProduct.FormCreate(Sender: TObject);
begin
  log('Form Create ' + Caption);
  GetProductList;
  PopulateSubcategoryCombo;
  sortedColumn := 'Subcategory';
  sortOrder := 'ASC';
end;

procedure TPickProduct.dgProductsTitleClick(Column: TColumn);
var
  bkmark: TBookmark;
  otherColumn: string;
begin
  dProducts.DisableControls;
  bkmark := dProducts.GetBookmark;

  try
    if Column.FieldName = sortedColumn then
      if sortOrder = 'ASC' then
        sortOrder := 'DESC'
      else
        sortOrder := 'ASC';

    sortedColumn := Column.FieldName;

    if sortedColumn = 'Subcategory' then
      otherColumn := 'Name'
    else
      otherColumn := 'Subcategory';

    dProducts.IndexFieldNames := sortedColumn + ' ' + sortOrder + ';' + otherColumn + ' ASC';
  finally
    dProducts.GotoBookmark(bkmark);
    dProducts.EnableControls;
  end;
end;

procedure TPickProduct.cmbbxSubcategoryChange(Sender: TObject);
var selectedProductID: Int64;
begin
  selectedProductID := TLargeIntField(dProducts.FieldByName('ProductId')).AsLargeInt;
  dProducts.DisableControls;

  try
    if cmbbxSubcategory.ItemIndex = 0 then
    begin
      dProducts.Filtered := False;
    end
    else
    begin
      dProducts.Filter := 'Subcategory = ' + QuotedStr(cmbbxSubcategory.Items[cmbbxSubcategory.ItemIndex]);
      dProducts.Filtered := True;
    end;
  finally
    dProducts.EnableControls;
  end;

  if not(dProducts.Eof and dProducts.Bof) then
    dProducts.Locate('ProductId', selectedProductID, []);
end;

procedure TPickProduct.wwdbgProductsTitleButtonClick(Sender: TObject;
  AFieldName: String);
var
  bkmark: TBookmark;
  otherColumn: string;
begin
  dProducts.DisableControls;
  bkmark := dProducts.GetBookmark;

  try
    if AFieldName = sortedColumn then
      if sortOrder = 'ASC' then
        sortOrder := 'DESC'
      else
        sortOrder := 'ASC';

    sortedColumn := AFieldName;

    if sortedColumn = 'Subcategory' then
      otherColumn := 'Name'
    else
      otherColumn := 'Subcategory';

    dProducts.IndexFieldNames := sortedColumn + ' ' + sortOrder + ';' + otherColumn + ' ASC';
  finally
    dProducts.GotoBookmark(bkmark);
    dProducts.EnableControls;
  end;
end;

end.
