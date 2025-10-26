unit uSiteCustomise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uADO, DB, ADODB, Grids, DBGrids, StdCtrls, Wwdbigrd, Wwdbgrid,
  uGridSortHelper, wwDialog, Wwlocate, ActnList, uPleaseWaitForm;

const
  EDIT_PRODUCTS_BASE_CLAUSE = 'select * from #editproducts';

  ONLY_CHANGED_PRODUCTS_CLAUSE = ' ProductID in (select distinct productid' + #13#10 +
                                 'from #editproducts where overridenames = 1' + #13#10 +
                                 'union' + #13#10 +
                                 'select distinct productid' + #13#10 +
                                 'from #editprices where overrideprice = 1)';

  ONLY_AVAILABLE_PRODUCTS_CLAUSE = ' ProductID in (select distinct EntityCode' + #13#10 +
                                   '  from #PanelProduct where PanelID in ' + #13#10 +
                                   '    (select PanelID from #PanelsOnSite))';

type
  TSiteCustomise = class(TForm)
    qEditProducts: TADOQuery;
    dsEditProducts: TDataSource;
    Label1: TLabel;
    btOk: TButton;
    btCancel: TButton;
    qSetupEditData: TADOQuery;
    dbgProducts: TwwDBGrid;
    qApplyEdits: TADOQuery;
    qDeleteTempTables: TADOQuery;
    qEditPrices: TADOQuery;
    dsEditPrices: TDataSource;
    dbgPrices: TwwDBGrid;
    qEditProductsproductid: TLargeintField;
    qEditProductscentralname: TStringField;
    qEditProductscentralline1: TStringField;
    qEditProductscentralline2: TStringField;
    qEditProductscentralline3: TStringField;
    qEditProductsoverridenames: TBooleanField;
    qEditProductssitename: TStringField;
    qEditProductssiteline1: TStringField;
    qEditProductssiteline2: TStringField;
    qEditProductssiteline3: TStringField;
    qEditProductsmodified: TBooleanField;
    qEditPricesproductid: TLargeintField;
    qEditPricesportiontypeid: TIntegerField;
    qEditPricesportiontype: TStringField;
    qEditPricesoverrideprice: TBooleanField;
    qEditPricessiteprice: TBCDField;
    qEditPricessitesupplementprice: TBCDField;
    qEditPricesmodified: TBooleanField;
    Label2: TLabel;
    qDeleteUnchanged: TADOQuery;
    qCheckForBlanks: TADOQuery;
    qEditProductsallowrename: TBooleanField;
    qEditProductsallowreprice: TBooleanField;
    gbxFindProduct: TGroupBox;
    edtFindProduct: TEdit;
    chkbxProductMidWordSearch: TCheckBox;
    btnFindPrevProduct: TButton;
    btnFindNextProduct: TButton;
    gbxFilters: TGroupBox;
    qEditProductsSubCategoryId: TIntegerField;
    cmbbxSubCategoryFilter: TComboBox;
    qSubCategory: TADOQuery;
    qEditProductsSubCategoryname: TStringField;
    qCreateTempTables: TADOQuery;
    cbShowOnlyAvailableProducts: TCheckBox;
    cbShowOnlyChangedProducts: TCheckBox;
    lblSubcategoryFilter: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProductDataChange(Sender: TField);
    procedure PriceDataChange(Sender: TField);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtProductNameSearchEnter(Sender: TObject);
    procedure dbgProductsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qEditProductsAfterScroll(DataSet: TDataSet);
    procedure dbgPricesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmbbxSubCategoryFilterChange(Sender: TObject);
    procedure cmbbxSubCategoryFilterDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure qEditPricesAfterScroll(DataSet: TDataSet);
    procedure OverrideNamesGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure OverridePricesGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure FilterCheckBoxClick(Sender: TObject);
  private
    ProductsSortHelper, PricesSortHelper: TGridSortHelper;
    procedure BuildSubCategoryFilter;
    procedure TogglePriceEditability(Editable: Boolean);
    procedure ToggleProductEditability(Editable: Boolean);
    procedure SetSiteProductsQuery(ShowOnlyChanged, showOnlyAvailable: Boolean);
    procedure LoadEditProductsData;
    procedure ApplyFilters(ShowOnlyChanged, ShowOnlyAvailable: Boolean);
    procedure SaveChangesToTempTables;
    procedure ResetFilters;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SiteCustomise: TSiteCustomise;

implementation

uses uDMThemeData, uAztecLog, uFormNavigate, StrUtils, uGuiUtils;

{$R *.dfm}

procedure TSiteCustomise.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  screen.Cursor := crAppStart;
  LoadEditProductsData;
  screen.Cursor := crDefault;

  //Set Currency String
  qEditPricessiteprice.DisplayFormat := CurrencyString + '#######0.00';
  qEditPricessitesupplementprice.DisplayFormat := CurrencyString + '#######0.00';

  qEditProducts.SQL.Text := EDIT_PRODUCTS_BASE_CLAUSE;
  qEditProducts.Filter := '';
  qEditProducts.Filtered := False;
  qEditProducts.Open;
  if qEditProducts.RecordCount = 0 then
  begin
    btOk.Enabled := false;
    label1.Caption := 'No products may have details edited on site.';
  end
  else
  begin
    btOk.Enabled := true;
    label1.Caption := 'The following products may be edited on site:';
  end;
  qEditPrices.Open;
  ProductsSortHelper.Reset;
  PricesSortHelper.Reset;
  BuildSubCategoryFilter;
  ResetFilters;
end;

procedure TSiteCustomise.ResetFilters;
begin
  cbShowOnlyAvailableProducts.Checked := true;
  cbShowOnlyChangedProducts.Checked := false;
  cmbbxSubCategoryFilter.ItemIndex := 0;
  qEditProducts.Filter := '';
  qEditProducts.Filtered := false;
  ApplyFilters(cbShowOnlyChangedProducts.Checked, cbShowOnlyAvailableProducts.Checked);
end;

procedure TSiteCustomise.LoadEditProductsData;
var
  oldCursor : TCursor;
  waitWindow : TPleaseWaitForm;
begin
  oldCursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  waitWindow := TPleaseWaitForm.ShowPleaseWait('Loading data', 'Site Products data is loading');
  try
    qDeleteTempTables.ExecSQL;
    qCreateTempTables.ExecSQL;
    qSetupEditData.ExecSQL;

    qEditProducts.Open;
    qEditPrices.Open;
    waitWindow.Hide;
  finally
    Screen.Cursor := oldCursor;
    waitWindow.Free;
  end;
end;

procedure TSiteCustomise.btOkClick(Sender: TObject);
var
  BlankNames: Boolean;
begin
  ButtonClicked(Sender);
  SaveChangesToTempTables;

  qCheckForBlanks.Open;
  BlankNames := (qCheckForBlanks.RecordCount > 0);
  qCheckForBlanks.Close;
  if BlankNames then
  begin
    raise Exception.Create('One or more products have blank names, this must be fixed before data can be saved.');
  end;

  qApplyEdits.ExecSQL;
  modalresult := mrOk;
  Close;
end;

procedure TSiteCustomise.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  qEditProducts.close;
  qEditPrices.close;
  qDeleteTempTables.execsql;
  Nav.MoveBack;
end;

procedure TSiteCustomise.ProductDataChange(Sender: TField);
begin
  Tfield(sender).DataSet.FieldByName('modified').AsBoolean := true;
  if TField(sender).FieldName = 'overridenames' then
  begin
    if TField(sender).AsBoolean then
    begin
      ToggleProductEditability(True);
      with TField(sender).dataset do
      begin
        // we are overriding prices so make sure prices are non-null
        if fieldbyname('sitename').isnull then
          fieldbyname('sitename').asstring := fieldbyname('centralname').asstring;
        if fieldbyname('siteline1').isnull then
          fieldbyname('siteline1').asstring := fieldbyname('centralline1').asstring;
        if fieldbyname('siteline2').isnull then
          fieldbyname('siteline2').asstring := fieldbyname('centralline2').asstring;
        if fieldbyname('siteline3').isnull then
          fieldbyname('siteline3').asstring := fieldbyname('centralline3').asstring;
      end;
    end
    else
      ToggleProductEditability(False);
  end;
end;

procedure TSiteCustomise.PriceDataChange(Sender: TField);
begin
  Tfield(sender).DataSet.FieldByName('modified').AsBoolean := true;
  if Sender.FieldName = 'overrideprice' then
  begin
    if Sender.AsBoolean then
    begin
      TogglePriceEditability(True);
      with Sender.dataset do
      begin
        // we are overriding prices so make sure prices are non-null
        if fieldbyname('siteprice').isnull then
          fieldbyname('siteprice').AsCurrency := 0;
        if fieldbyname('sitesupplementprice').isnull then
          fieldbyname('sitesupplementprice').AsCurrency := 0;
      end
    end
    else
      TogglePriceEditability(False);
  end;
end;

procedure TSiteCustomise.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

procedure TSiteCustomise.FormCreate(Sender: TObject);
begin
  ProductsSortHelper := TGridSortHelper.Create;
  ProductsSortHelper.Initialise(dbgProducts);
  PricesSortHelper := TGridSortHelper.Create;
  PricesSortHelper.Initialise(dbgPrices);
  uGuiUtils.setupSearchBox(gbxFindProduct, dbgProducts,
                           ['CentralName', 'CentralLine1', 'CentralLine2', 'CentralLine3',
                            'SiteName', 'Siteline1', 'SiteLine2', 'SiteLine3'], []);
end;

procedure TSiteCustomise.FormDestroy(Sender: TObject);
begin
  ProductsSortHelper.Free;
  PricesSortHelper.Free;
end;

procedure TSiteCustomise.edtProductNameSearchEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TSiteCustomise.dbgProductsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if not qEditproducts.FieldByName('allowrename').AsBoolean and not (gdFixed in State) then
  begin
    ABrush.Color := clBtnface;
  end;
end;

procedure TSiteCustomise.qEditProductsAfterScroll(DataSet: TDataSet);
var
  AllowRenaming: Boolean;
  OverrideNames: Boolean;
begin
  qEditProducts.DisableControls;
  try
    AllowRenaming := qEditproducts.FieldByName('allowrename').AsBoolean;
    OverrideNames := qEditproducts.FieldByName('overridenames').AsBoolean;
    if AllowRenaming then
      dbgProducts.Options := dbgProducts.Options + [dgEditing]
    else
      dbgProducts.Options := dbgProducts.Options - [dgEditing];
    ToggleProductEditability(OverrideNames and AllowRenaming);
  finally
    qEditProducts.EnableControls
  end;
end;

procedure TSiteCustomise.dbgPricesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if not qEditProducts.FieldByName('allowreprice').AsBoolean then
  begin
    ABrush.Color := clBtnface;
  end;
end;

procedure TSiteCustomise.BuildSubCategoryFilter;
begin
  with dmThemeData.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select distinct ep.SubCategoryID, psc.Name');
    SQL.Add('from #editproducts ep');
    SQL.Add('join ac_ProductSubCategory psc');
    SQL.Add('on ep.SubCategoryId = psc.Id');
    SQL.Add('order by psc.Name asc');
    Open;

    cmbbxSubCategoryFilter.Items.Clear;
    cmbbxSubCategoryFilter.Items.Add('<no filter>');
    while not EOF do
    begin
      cmbbxSubCategoryFilter.Items.AddObject(FieldByName('Name').AsString, TObject(FieldByName('SubCategoryId').AsInteger));
      Next;
    end;
    cmbbxSubCategoryFilter.ItemIndex := 0;
  end;
end;

procedure TSiteCustomise.cmbbxSubCategoryFilterChange(Sender: TObject);
var
  bkmark: Int64;
begin
  bkmark := TLargeIntField(qEditProducts.FieldbyName('productid')).AsLargeInt;
  try
    with Sender as TComboBox do
    begin
      if ItemIndex = 0 then
      begin
        qEditProducts.Filter := '';
        qEditProducts.Filtered := False;
      end
      else begin
        qEditProducts.Filter := 'SubCategoryId = ' + IntToStr(Integer(cmbbxSubCategoryFilter.Items.Objects[cmbbxSubCategoryFilter.ItemIndex]));
        qEditProducts.Filtered := True;
      end;
    end;
  finally
    qEditProducts.Locate('ProductId',bkmark,[]);
  end;
end;

procedure TSiteCustomise.cmbbxSubCategoryFilterDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  with Control as TComboBox do
  begin
    if (Index = 0) and not (odSelected in State) then
      Canvas.Font.Color := clGrayText
    else if (odSelected in State) then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clBtnText;

    (Control as TComboBox).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TSiteCustomise.qEditPricesAfterScroll(DataSet: TDataSet);
var
  AllowRepricing: Boolean;
  OverridePrices: Boolean;
begin
  qEditPrices.DisableControls;
  try
    AllowRepricing := qEditproducts.FieldByName('allowreprice').AsBoolean;
    OverridePrices := qEditPrices.FieldByName('overrideprice').AsBoolean;

    dbgPrices.ReadOnly := not AllowRepricing;
    if AllowRepricing then
      dbgPrices.Options := dbgPrices.Options + [dgEditing]
    else
      dbgPrices.Options := dbgPrices.Options - [dgEditing];

    TogglePriceEditability(OverridePrices and AllowRepricing)
  finally
    qEditPrices.EnableControls
  end;
end;

procedure TSiteCustomise.TogglePriceEditability(Editable: Boolean);
var
  i: Integer;
begin
  for i := 0 to qEditPrices.FieldCount - 1 do
    qEditPrices.Fields.Fields[i].ReadOnly :=    (qEditPrices.Fields.Fields[i].FieldName <> 'overrideprice') and
                                                (qEditPrices.Fields.Fields[i].visible) and
                                            not Editable;
end;

procedure TSiteCustomise.ToggleProductEditability(Editable: Boolean);
var
  i: Integer;
begin
  for i := 0 to qEditProducts.FieldCount - 1 do                                                           
    qEditProducts.Fields.Fields[i].ReadOnly :=      (qEditProducts.Fields.Fields[i].FieldName <> 'overridenames') and
                                                    (qEditProducts.Fields.Fields[i].visible) and
                                                not Editable;
end;

procedure TSiteCustomise.OverrideNamesGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
var
  Overriding: Boolean;
begin
  Overriding := qEditProducts.FieldByName('overridenames').AsBoolean;
  if (not Overriding) and DisplayText then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure TSiteCustomise.OverridePricesGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
var
  Overriding: Boolean;
begin
  Overriding := qEditPrices.FieldByName('overrideprice').AsBoolean;
  if (not Overriding) and DisplayText then
    Text := ''
  else
    Text := FloatToStrF(Sender.AsCurrency,ffCurrency, 10, 2);
end;

procedure TSiteCustomise.FilterCheckBoxClick(Sender: TObject);
begin
  ApplyFilters(cbShowOnlyChangedProducts.Checked, cbShowOnlyAvailableProducts.Checked);
end;

procedure TSiteCustomise.ApplyFilters(ShowOnlyChanged, ShowOnlyAvailable : Boolean);
begin
  SaveChangesToTempTables;

  SetSiteProductsQuery(ShowOnlyChanged, ShowOnlyAvailable);
  qEditProducts.Open;
end;

procedure TSiteCustomise.SaveChangesToTempTables;
begin
  if dsEditProducts.DataSet.State = dsEdit then
    dsEditProducts.DataSet.post;
  if dsEditPrices.DataSet.State = dsEdit then
    dsEditPrices.DataSet.post;
end;

procedure TSiteCustomise.SetSiteProductsQuery(ShowOnlyChanged, ShowOnlyAvailable: Boolean);
var
  newQuery : String;
begin
  NewQuery := EDIT_PRODUCTS_BASE_CLAUSE;

  if ShowOnlyChanged or showOnlyAvailable then
  begin
    NewQuery := NewQuery + ' WHERE ';
    if ShowOnlyChanged then
    begin
      NewQuery := newQuery + #13#10 + ONLY_CHANGED_PRODUCTS_CLAUSE;
      if showOnlyAvailable then
        newQuery := newQuery + #13#10 + ' AND ';
    end;
    if showOnlyAvailable then
    begin
      newQuery := newQuery + ONLY_AVAILABLE_PRODUCTS_CLAUSE;
    end;
  end;

  qEditProducts.SQL.Text := NewQuery;
end;

end.
