unit uProductStructureFilterFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  { Class representation of a product. For use when storing ProductIDs (EntityCodes) in the
    Product combobox }
  TProduct = class(TObject)
  public
    ProductID : Int64;
    constructor Create (const id : Int64);
  end;

  // same is required with portion Id for combobox
  TPortion = class(TObject)
  public
    PortionTypeID : Integer;
    constructor Create(id: Integer);
  end;

  //TODO: Store the Id of each item (division, sub-division, etc) in the item arrays of each combo so that we can efficiently
  // provide the properties SelectedDivisionId, SelectedSubDivisionId, etc. These properties would increase the efficiency
  // of the load queries on some of the screens which currently use the Name of each item in their WHERE clauses.

  TProductStructureFilterFrame = class(TFrame)
    lblDivision: TLabel;
    lblCategory: TLabel;
    lblSubCat: TLabel;
    lblProduct: TLabel;
    cmbbxDivision: TComboBox;
    cmbbxCategory: TComboBox;
    cmbbxSubCat: TComboBox;
    cmbbxProduct: TComboBox;
    bvlFrameIndicator: TBevel;
    lblPortion: TLabel;
    cmbbxPortion: TComboBox;
    cmbbxSubDivision: TComboBox;
    cmbbxSuperCategory: TComboBox;
    lblSubDivision: TLabel;
    lblSuperCategory: TLabel;
    lblPricing: TLabel;
    cmbbxPricing: TComboBox;
    procedure cmbbxDivisionChange(Sender: TObject);
    procedure cmbbxCategoryChange(Sender: TObject);
    procedure cmbbxSubCategoryChange(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure cmbbxProductExit(Sender: TObject);
    procedure cmbbxSubDivisionChange(Sender: TObject);
    procedure cmbbxSuperCategoryChange(Sender: TObject);
    procedure cmbbxPortionExit(Sender: TObject);
  private
    { Private declarations }
    initialised : boolean;
    FFrameEnabled: boolean;

    procedure GetDivisions;
    procedure RefreshSubDivisionCombo;
    procedure RefreshSuperCategoryCombo;
    procedure RefreshCategoryCombo;
    procedure RefreshSubCategoryCombo;
    procedure RefreshProductCombo;
    procedure InitialiseWithAllValues(combo : TComboBox);
    procedure DisposeCmbbxProduct;
    procedure DisposeCmbbxPortion;
    procedure SetFrameEnabled(const Value: boolean);
    procedure GetPortions;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialise;

    property FrameEnabled : boolean read FFrameEnabled write SetFrameEnabled;
    function SQLStatementForFilteredProducts : string;
  end;

implementation

uses uADO;

{$R *.dfm}

{TProduct}

constructor TProduct.Create (const id : Int64);
begin
  ProductID := id;
end;

{TPortion}

constructor TPortion.Create(id: Integer);
begin
  PortionTypeID := id;
end;

{ProductStructureFilterFrame}

procedure TProductStructureFilterFrame.cmbbxDivisionChange(Sender: TObject);
begin
  RefreshSubDivisionCombo;
end;

procedure TProductStructureFilterFrame.cmbbxSubDivisionChange(Sender: TObject);
begin
  RefreshSuperCategoryCombo;
end;

procedure TProductStructureFilterFrame.cmbbxSuperCategoryChange(Sender: TObject);
begin
  RefreshCategoryCombo;
end;

procedure TProductStructureFilterFrame.cmbbxCategoryChange(Sender: TObject);
begin
  RefreshSubCategoryCombo;
end;

procedure TProductStructureFilterFrame.cmbbxSubCategoryChange(Sender: TObject);
begin
  RefreshProductCombo;
end;

procedure TProductStructureFilterFrame.RefreshSubDivisionCombo;
begin
  if cmbbxSubDivision.Visible then
  begin
    cmbbxSubDivision.Items.Clear;
    cmbbxSubDivision.Items.Add('<all values>');

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Name from ac_ProductSubDivision');
      SQL.Add('where ISNULL(Deleted, 0) = 0');

      if cmbbxDivision.ItemIndex > 0 then
        SQL.Add('and ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + ')');

      SQL.Add('order by Name');
      Open;

      while not EOF do
      begin
        cmbbxSubDivision.Items.Add(FieldByName('Name').AsString);

        Next;
      end;
    end;

    cmbbxSubDivision.ItemIndex := 0;
  end;

  RefreshSuperCategoryCombo;
end;


procedure TProductStructureFilterFrame.RefreshSuperCategoryCombo;
begin
  if cmbbxSuperCategory.Visible then
  begin
    cmbbxSuperCategory.Items.Clear;
    cmbbxSuperCategory.Items.Add('<all values>');

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Name from ac_ProductSuperCategory');
      SQL.Add('where ISNULL(Deleted, 0) = 0');

      if cmbbxSubDivision.ItemIndex > 0 then
        SQL.Add('and ProductSubDivisionId = (select top 1 Id from ac_ProductSubDivision where Name = ' + QuotedStr(cmbbxSubDivision.Text) + ')')
      else if cmbbxDivision.ItemIndex > 0 then
        SQL.Add('and ProductSubDivisionId in (select Id from ac_ProductSubDivision ' +
          'where ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + '))');


      SQL.Add('order by Name');
      Open;

      while not EOF do
      begin
        cmbbxSuperCategory.Items.Add(FieldByName('Name').AsString);

        Next;
      end;
    end;

    cmbbxSuperCategory.ItemIndex := 0;
  end;

  RefreshCategoryCombo;
end;

procedure TProductStructureFilterFrame.RefreshCategoryCombo;
begin
  if cmbbxCategory.Visible then
  begin
    cmbbxCategory.Items.Clear;
    cmbbxCategory.Items.Add('<all values>');

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Name from ac_ProductCategory');
      SQL.Add('where ISNULL(Deleted, 0) = 0');

      if cmbbxSuperCategory.ItemIndex > 0 then
        SQL.Add('and ProductSuperCategoryId = (select top 1 Id from ac_ProductSuperCategory where Name = ' + QuotedStr(cmbbxSuperCategory.Text) + ')')
      else if cmbbxSubDivision.ItemIndex > 0 then
        SQL.Add('and ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
          'where ProductSubDivisionId = (select top 1 Id from ac_ProductSubDivision where Name = ' + QuotedStr(cmbbxSubDivision.Text) + '))')
      else if cmbbxDivision.ItemIndex > 0 then
        SQL.Add('and ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
          'where ProductSubDivisionId in (select Id from ac_ProductSubDivision '+
          'where ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + ')))');

      SQL.Add('order by Name');
      Open;

      while not EOF do
      begin
        cmbbxCategory.Items.Add(FieldByName('Name').AsString);

        Next;
      end;
    end;

    cmbbxCategory.ItemIndex := 0;
  end;

  RefreshSubCategoryCombo;
end;

procedure TProductStructureFilterFrame.RefreshSubCategoryCombo;
begin
  if cmbbxSubCat.Visible then
  begin
    cmbbxSubCat.Items.Clear;
    cmbbxSubCat.Items.Add('<all values>');

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Name from ac_ProductSubCategory');
      SQL.Add('where ISNULL(Deleted, 0) = 0');

      if cmbbxCategory.ItemIndex > 0 then
        SQL.Add('and ProductCategoryId = (select top 1 Id from ac_ProductCategory where Name = ' + QuotedStr(cmbbxCategory.Text) + ')')
      else if cmbbxSuperCategory.ItemIndex > 0 then
        SQL.Add('and ProductCategoryId in (select Id from ac_ProductCategory ' +
          ' where ProductSuperCategoryId = (select top 1 Id from ac_ProductSuperCategory where Name = ' + QuotedStr(cmbbxSuperCategory.Text) + '))')
      else if cmbbxSubDivision.ItemIndex > 0 then
        SQL.Add('and ProductCategoryId in (select Id from ac_ProductCategory ' +
          'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
          'where ProductSubDivisionId = (select top 1 Id from ac_ProductSubDivision where Name = ' + QuotedStr(cmbbxSubDivision.Text) + ')))')
      else if cmbbxDivision.ItemIndex > 0 then
        SQL.Add('and ProductCategoryId in (select Id from ac_ProductCategory ' +
          'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
          'where ProductSubDivisionId in (select Id from ac_ProductSubDivision '+
          'where ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + '))))');

      SQL.Add('order by Name');
      Open;

      while not EOF do
      begin
        cmbbxSubCat.Items.Add(FieldByName('Name').AsString);

        Next;
      end;

      Close;
    end;

    cmbbxSubCat.ItemIndex := 0;
  end;

  RefreshProductCombo;
end;

procedure TProductStructureFilterFrame.RefreshProductCombo;
begin
  if not cmbbxProduct.Visible then Exit;

  DisposeCmbbxProduct;
  cmbbxProduct.Items.Clear;
  cmbbxProduct.Items.Add('<all values>');

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select [EntityCode], [Extended RTL Name] from Products');
    SQL.Add('where (Deleted <> ''Y'' or Deleted is NULL)');
    SQL.Add('  and ([Entity Type] in (''Strd.Line'',''Recipe''))');
    SQL.Add('  and [Whether Open Priced] = ''F''');


    //TODO: Make all these clauses into constants with a %s parameter for the item name.
    if cmbbxSubCat.ItemIndex > 0 then
      SQL.Add('and [Sub-Category Name] = ' + QuotedStr(cmbbxSubCat.Text))
    else if cmbbxCategory.ItemIndex > 0 then
      SQL.Add('and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId = (select top 1 Id from ac_ProductCategory where Name = ' + QuotedStr(cmbbxCategory.Text) + '))')
    else if cmbbxSuperCategory.ItemIndex > 0 then
      SQL.Add('and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId = (select top 1 Id from ac_ProductSuperCategory where Name = ' + QuotedStr(cmbbxSuperCategory.Text) + ')))')
    else if cmbbxSubDivision.ItemIndex > 0 then
      SQL.Add('and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
        'where ProductSubDivisionId = (select top 1 Id from ac_ProductSubDivision where Name = ' + QuotedStr(cmbbxSubDivision.Text) + '))))')
    else if cmbbxDivision.ItemIndex > 0 then
      SQL.Add('and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
        'where ProductSubDivisionId in (select Id from ac_ProductSubDivision '+
        'where ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + ')))))');

    SQL.Add('order by [Extended RTL Name]');
    Open;

    while not EOF do
    begin
      cmbbxProduct.Items.AddObject(FieldByName('Extended RTL Name').AsString,
                                   TProduct.Create(Trunc(FieldByName('EntityCode').Value)));

      Next;
    end;

    Close;
  end;

  cmbbxProduct.ItemIndex := 0;
end;

constructor TProductStructureFilterFrame.Create(AOwner: TComponent);
begin
  inherited;

  { Initialise combo boxes with '<all values>' only. Can't initialise with all data here because at
    this point the parent form won't have made invisible the combo boxes it doesn't need. And the visible
    property is used to determine whether a combo box needs to be populated }
  InitialiseWithAllValues(cmbbxDivision);
  InitialiseWithAllValues(cmbbxSubDivision);
  InitialiseWithAllValues(cmbbxSuperCategory);
  InitialiseWithAllValues(cmbbxCategory);
  InitialiseWithAllValues(cmbbxSubCat);
  InitialiseWithAllValues(cmbbxProduct);
  InitialiseWithAllValues(cmbbxPortion);

  FrameEnabled := TRUE;
  Initialised := FALSE;
end;

destructor TProductStructureFilterFrame.Destroy;
begin
  DisposeCmbbxProduct;
  DisposeCmbbxPortion;
  inherited Destroy;
end;


procedure TProductStructureFilterFrame.InitialiseWithAllValues(combo : TComboBox);
begin
  combo.Items.Clear;
  combo.Items.Add('<all values>');
  combo.ItemIndex := 0;
end;

procedure TProductStructureFilterFrame.GetDivisions;
begin
  cmbbxDivision.Items.Clear;
  cmbbxDivision.Items.Add('<all values>');

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select [Division Name] from Division');
    SQL.Add('order by [Division Name]');
    Open;

    while not EOF do
    begin
      cmbbxDivision.Items.Add(FieldByName('Division Name').AsString);

      Next;
    end;

    Close;
  end;

  cmbbxDivision.ItemIndex := 0;
  cmbbxDivisionChange(Self);
end;

procedure TProductStructureFilterFrame.FrameEnter(Sender: TObject);
begin
  if not initialised then
  begin
    Initialise;
  end;
end;


{ Returns the SQL WHERE clause required to select filtered products }
function TProductStructureFilterFrame.SQLStatementForFilteredProducts : string;
begin
  Result :=
    '(p.Deleted <> ''Y'' or p.Deleted is NULL) and ' +
    '([Entity Type] in (''Strd.Line'',''Recipe'')) and ' +
    '[Whether Open Priced] = ''F'' ';

    if cmbbxPortion.ItemIndex > 0 then
      Result := Result + Format('and [PortionTypeID] = %d ', [TPortion(cmbbxPortion.Items.Objects[cmbbxPortion.ItemIndex]).PortionTypeID]);

    //Slightly annoying to have an alias in the following statement to refer to p.[EntityCode]
    //to prevent the ambiguity with the Portions.EntityCode column.  However, this slight trade off
    //ensures this piece of code genuinely returns the filtering condition used by both
    //the Price Matrix form and the Offband Prices form and gets rid of the untidy code that
    //existed prior to this chnage.
    if cmbbxProduct.ItemIndex > 0 then
      Result := Result + 'and p.[EntityCode] = ' + inttostr(TProduct(cmbbxProduct.Items.Objects[cmbbxProduct.ItemIndex]).ProductID)
    else if cmbbxSubCat.ItemIndex > 0 then
      Result := Result + 'and [Sub-Category Name] = ' + QuotedStr(cmbbxSubCat.Text)
    else if cmbbxCategory.ItemIndex > 0 then
      Result := Result + 'and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId = (select top 1 Id from ac_ProductCategory where Name = ' + QuotedStr(cmbbxCategory.Text) + '))'
    else if cmbbxSuperCategory.ItemIndex > 0 then
      Result := Result + 'and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId = (select top 1 Id from ac_ProductSuperCategory where Name = ' + QuotedStr(cmbbxSuperCategory.Text) + ')))'
    else if cmbbxSubDivision.ItemIndex > 0 then
      Result := Result + 'and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
        'where ProductSubDivisionId = (select top 1 Id from ac_ProductSubDivision where Name = ' + QuotedStr(cmbbxSubDivision.Text) + '))))'
    else if cmbbxDivision.ItemIndex > 0 then
      Result := Result + 'and [Sub-Category Name] in (select Name from ac_ProductSubCategory ' +
        'where ProductCategoryId in (select Id from ac_ProductCategory ' +
        'where ProductSuperCategoryId in (select Id from ac_ProductSuperCategory  ' +
        'where ProductSubDivisionId in (select Id from ac_ProductSubDivision '+
        'where ProductDivisionId = (select top 1 Id from ac_ProductDivision where Name = ' + QuotedStr(cmbbxDivision.Text) + ')))))'
end;

procedure TProductStructureFilterFrame.SetFrameEnabled(const Value: boolean);
begin
  FFrameEnabled := Value;

  cmbbxDivision.Enabled := Value;
  cmbbxSubDivision.Enabled := Value;
  cmbbxSuperCategory.Enabled := Value;
  cmbbxCategory.Enabled := Value;
  cmbbxSubCat.Enabled := Value;
  cmbbxProduct.Enabled := Value;
  cmbbxPortion.Enabled := Value;

  lblDivision.Enabled := Value;
  lblSubDivision.Enabled := Value;
  lblSuperCategory.Enabled := Value;
  lblCategory.Enabled := Value;
  lblSubCat.Enabled := Value;
  lblProduct.Enabled := Value;
  lblPortion.Enabled := Value;
  Self.Refresh;
end;

procedure TProductStructureFilterFrame.Initialise;
begin
  if cmbbxDivision.Visible then
    GetDivisions;
  if cmbbxPortion.Visible then
    GetPortions;
  initialised := true;
end;

procedure TProductStructureFilterFrame.cmbbxProductExit(Sender: TObject);
begin
  { If the user types in product name the ItemIndex property is not automatically updated with
    the index of the item. Update the ItemIndex now. Is this a TComboBox bug?}
  with cmbbxProduct do
  begin
    if (ItemIndex = -1) and (Text = '') then
      ItemIndex := 0
    else if (Text <> Items[ItemIndex]) then
      if Items.IndexOf(Text) = -1 then
      begin
        MessageDlg('Invalid product name. Please select a valid product.', mtInformation, [mbOK], 0);
        SetFocus;
      end else
      begin
        ItemIndex := Items.IndexOf(Text);
      end;
  end;
end;

//Added by AK for PM360
procedure TProductStructureFilterFrame.GetPortions;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Append('Select PortionTypeID, PortionTypeName from PortionType ');
    SQL.Append('ORDER BY PortionTypeID');
    Open;
    while not EOF do
    begin
      cmbbxPortion.Items.AddObject(FieldByName('PortionTypeName').AsString, TPortion.Create(FieldByName('PortionTypeID').AsInteger));
      Next;
    end;
    Close;
  end;
  cmbbxPortion.ItemIndex := 0;
end;

{ Free all objects associated with the Products combobox}
procedure TProductStructureFilterFrame.DisposeCmbbxProduct;
var i : integer;
begin
  for i := 0 to cmbbxProduct.Items.Count - 1 do
    cmbbxProduct.Items.Objects[i].Free;
end;

procedure TProductStructureFilterFrame.DisposeCmbbxPortion;
var i : integer;
begin
  for i := 0 to cmbbxPortion.Items.Count - 1 do
    cmbbxPortion.Items.Objects[i].Free;
end;

procedure TProductStructureFilterFrame.cmbbxPortionExit(Sender: TObject);
begin
  { If the user types in portion name the ItemIndex property is not automatically updated with
    the index of the item. Update the ItemIndex now. Is this a TComboBox bug?}
  with cmbbxPortion do
  begin
    if (ItemIndex = -1) and (Text = '') then
      ItemIndex := 0
    else if (Text <> Items[ItemIndex]) or (ItemIndex = -1) then
      if Items.IndexOf(Text) = -1 then
      begin
        MessageDlg('Invalid portion name. Please select a valid portion.', mtInformation, [mbOK], 0);
        SetFocus;
      end else
      begin
        ItemIndex := Items.IndexOf(Text);
      end;
  end;
end;

end.
