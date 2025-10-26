object SiteCustomise: TSiteCustomise
  Left = 509
  Top = 293
  HelpContext = 5028
  BorderStyle = bsSingle
  Caption = 'Site Products'
  ClientHeight = 425
  ClientWidth = 926
  Color = clBtnFace
  Constraints.MinHeight = 420
  Constraints.MinWidth = 816
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    926
    425)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 218
    Height = 13
    Caption = 'The following products may be edited on site:'
  end
  object Label2: TLabel
    Left = 8
    Top = 172
    Width = 128
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Prices of selected product:'
  end
  object btOk: TButton
    Left = 766
    Top = 393
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    TabOrder = 4
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 846
    Top = 393
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = btCancelClick
  end
  object dbgProducts: TwwDBGrid
    Left = 8
    Top = 32
    Width = 911
    Height = 135
    ControlType.Strings = (
      'overridenames;CheckBox;True;False')
    Selected.Strings = (
      'SubCategoryname'#9'20'#9'Sub-Category'
      'centralname'#9'16'#9'Name'
      'centralline1'#9'14'#9'Terminal line 1'
      'centralline2'#9'14'#9'Terminal line 2'
      'centralline3'#9'14'#9'Terminal line 3'
      'overridenames'#9'14'#9'Use site name'
      'sitename'#9'16'#9'Site name'
      'siteline1'#9'10'#9'Site line 1'
      'siteline2'#9'10'#9'Site line 2'
      'siteline3'#9'10'#9'Site line 3')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 5
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsEditProducts
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint, dgHideBottomDataLine]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = dbgProductsCalcCellColors
  end
  object dbgPrices: TwwDBGrid
    Left = 8
    Top = 190
    Width = 911
    Height = 97
    ControlType.Strings = (
      'overrideprice;CheckBox;True;False')
    Selected.Strings = (
      'portiontype'#9'16'#9'Portion type'
      'overrideprice'#9'14'#9'Use site price'#9'F'
      'siteprice'#9'10'#9'Site price'
      'sitesupplementprice'#9'20'#9'Site supplement price')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 1
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Anchors = [akLeft, akRight, akBottom]
    DataSource = dsEditPrices
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint, dgHideBottomDataLine]
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = dbgPricesCalcCellColors
  end
  object gbxFindProduct: TGroupBox
    Left = 468
    Top = 300
    Width = 453
    Height = 56
    Anchors = [akLeft, akBottom]
    Caption = 'Find product'
    TabOrder = 3
    TabStop = True
    DesignSize = (
      453
      56)
    object edtFindProduct: TEdit
      Left = 5
      Top = 15
      Width = 281
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object chkbxProductMidWordSearch: TCheckBox
      Left = 5
      Top = 37
      Width = 107
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Mid-word search'
      TabOrder = 3
    end
    object btnFindPrevProduct: TButton
      Left = 371
      Top = 11
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Find &Previous'
      TabOrder = 2
    end
    object btnFindNextProduct: TButton
      Left = 290
      Top = 11
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Find &Next'
      TabOrder = 1
    end
  end
  object gbxFilters: TGroupBox
    Left = 8
    Top = 300
    Width = 453
    Height = 117
    Anchors = [akLeft, akBottom]
    Caption = 'Product Filtering'
    TabOrder = 2
    DesignSize = (
      453
      117)
    object lblSubcategoryFilter: TLabel
      Left = 8
      Top = 22
      Width = 88
      Height = 13
      Caption = 'Subcategory Filter'
    end
    object cmbbxSubCategoryFilter: TComboBox
      Left = 8
      Top = 38
      Width = 438
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akRight]
      ItemHeight = 16
      TabOrder = 0
      OnChange = cmbbxSubCategoryFilterChange
      OnDrawItem = cmbbxSubCategoryFilterDrawItem
    end
    object cbShowOnlyAvailableProducts: TCheckBox
      Left = 8
      Top = 72
      Width = 297
      Height = 17
      Caption = 'Show only products available on this site'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = FilterCheckBoxClick
    end
    object cbShowOnlyChangedProducts: TCheckBox
      Left = 8
      Top = 88
      Width = 177
      Height = 17
      Caption = 'Show only changed products'
      TabOrder = 2
      OnClick = FilterCheckBoxClick
    end
  end
  object qEditProducts: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterScroll = qEditProductsAfterScroll
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from #editproducts')
    Left = 280
    Top = 112
    object qEditProductsSubCategoryname: TStringField
      DisplayLabel = 'Sub-Category'
      FieldKind = fkLookup
      FieldName = 'SubCategoryname'
      LookupDataSet = qSubCategory
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'SubCategoryId'
      Lookup = True
    end
    object qEditProductscentralname: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 16
      FieldName = 'centralname'
      Size = 16
    end
    object qEditProductscentralline1: TStringField
      DisplayLabel = 'Terminal line 1'
      DisplayWidth = 14
      FieldName = 'centralline1'
      Size = 8
    end
    object qEditProductscentralline2: TStringField
      DisplayLabel = 'Terminal line 2'
      DisplayWidth = 14
      FieldName = 'centralline2'
      Size = 8
    end
    object qEditProductscentralline3: TStringField
      DisplayLabel = 'Terminal line 3'
      DisplayWidth = 14
      FieldName = 'centralline3'
      Size = 8
    end
    object qEditProductsoverridenames: TBooleanField
      DisplayLabel = 'Use site name'
      DisplayWidth = 14
      FieldName = 'overridenames'
      OnChange = ProductDataChange
    end
    object qEditProductssitename: TStringField
      DisplayLabel = 'Site name'
      DisplayWidth = 16
      FieldName = 'sitename'
      OnChange = ProductDataChange
      OnGetText = OverrideNamesGetText
      Size = 16
    end
    object qEditProductssiteline1: TStringField
      DisplayLabel = 'Site line 1'
      DisplayWidth = 10
      FieldName = 'siteline1'
      OnChange = ProductDataChange
      OnGetText = OverrideNamesGetText
      Size = 8
    end
    object qEditProductssiteline2: TStringField
      DisplayLabel = 'Site line 2'
      DisplayWidth = 10
      FieldName = 'siteline2'
      OnChange = ProductDataChange
      OnGetText = OverrideNamesGetText
      Size = 8
    end
    object qEditProductssiteline3: TStringField
      DisplayLabel = 'Site line 3'
      DisplayWidth = 10
      FieldName = 'siteline3'
      OnChange = ProductDataChange
      OnGetText = OverrideNamesGetText
      Size = 8
    end
    object qEditProductsmodified: TBooleanField
      DisplayWidth = 5
      FieldName = 'modified'
      Visible = False
    end
    object qEditProductsproductid: TLargeintField
      DisplayWidth = 15
      FieldName = 'productid'
      Visible = False
    end
    object qEditProductsallowrename: TBooleanField
      FieldName = 'allowrename'
      Visible = False
    end
    object qEditProductsallowreprice: TBooleanField
      FieldName = 'allowreprice'
      Visible = False
    end
    object qEditProductsSubCategoryId: TIntegerField
      FieldName = 'SubCategoryId'
      Visible = False
    end
  end
  object dsEditProducts: TDataSource
    DataSet = qEditProducts
    Left = 280
    Top = 80
  end
  object qSetupEditData: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'set nocount on'
      'print convert(varchar(50), getdate(), 21) + '#39'; start'#39
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; call getproductin' +
        'fo'#39
      ''
      'exec Theme_GetProductInfo'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; getproductinfo fi' +
        'nished'#39
      ''
      'update #portionheader set IsChoice = 1'
      'from #portionheader a '
      
        'join products b on (a.entitycode = b.entitycode and b.[entity ty' +
        'pe] = '#39'Menu'#39')'
      ''
      
        'update #portiondetail set IsChoice = b.ischoice, ContainsChoice ' +
        '= b.containschoice'
      'from #portionheader b where ingredientcode = b.entitycode'
      ''
      
        'declare @paneldesignids table (paneldesignid int primary key (pa' +
        'neldesignid))'
      
        'declare @validproducts table (productid bigint primary key (prod' +
        'uctid))'
      
        'declare @validportions table (productid bigint, portiontypeid in' +
        't primary key (productid, portiontypeid))'
      ''
      'declare @current_iteration int'
      'declare @iteration_rows_added int'
      ''
      
        'declare @activepanels table (panelid bigint primary key (panelid' +
        '))'
      ''
      
        'declare @toplevelproducts table (entitycode bigint, iteration sm' +
        'allint primary key(entitycode, iteration))'
      
        'declare @toplevelproducts_add table (entitycode bigint primary k' +
        'ey(entitycode))'
      ''
      
        'insert @paneldesignids (paneldesignid) select paneldesignid from' +
        ' themepaneldesign where themeid ='
      '  (select top 1 themeid from themesites)'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; prepare active pa' +
        'nels iteration'#39
      '-- add local panels for all panel designs in theme'
      ''
      'insert #panelset'
      
        'select PanelID from ThemePanel where PanelDesignID in (select pa' +
        'neldesignid from @paneldesignids)'
      ''
      'declare @sitecode int'
      'select top 1 @sitecode = sitecode from Themesites'
      ''
      'exec Theme_RecursePanelSet @SiteCode, 1'
      ''
      'insert @Activepanels select PanelID from #panelset'
      'drop table #panelset'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; prepare to iterat' +
        'e top level products '#39
      ''
      '-- find top level products'
      ''
      'set @current_iteration = 0'
      ''
      'insert @toplevelproducts'
      
        'select distinct cast(b.buttontypechoiceattr01 as bigint), @curre' +
        'nt_iteration'
      'from @activepanels a'
      
        'join themepanelbutton b on (a.panelid = b.panelid and b.buttonty' +
        'pechoiceid = ('
      
        '  select id from themebuttontypechoicelookup where name = '#39'RingU' +
        'pProduct'#39
      '))'
      'set @iteration_rows_added = @@rowcount'
      ''
      'insert #PanelProduct '
      
        'select distinct  a.PanelID, cast(b.buttontypechoiceattr01 as big' +
        'int) as EntityCode'
      'from @activepanels a'
      
        'join ThemePanelButton b on (a.panelid = b.panelid and b.buttonty' +
        'pechoiceid = ('
      
        '  select id from themebuttontypechoicelookup where name = '#39'RingU' +
        'pProduct'#39
      '))'
      ''
      'while @iteration_rows_added > 0'
      'begin'
      
        '  print convert(varchar(50), getdate(), 21) + '#39';  iterate to get' +
        ' top level products'#39
      '  set @current_iteration = @current_iteration + 1'
      '  delete @toplevelproducts_add'
      
        '  insert @toplevelproducts_add select distinct cast(c.Ingredient' +
        'code as bigint)'
      '  from @toplevelproducts a'
      '  join #portionheader b on (a.entitycode = b.entitycode) '
      '  join #portiondetail c on (b.portionid = c.portionid)'
      '  where a.iteration = @current_iteration -1 and'
      
        '    (b.ischoice = 1 or (b.containschoice = 1 and (c.containschoi' +
        'ce = 1 or c.ischoice = 1)))'
      '  '
      '  set @iteration_rows_added = @@rowcount'
      ''
      '    delete @toplevelproducts_add'
      '  from @toplevelproducts_add a'
      '  join @toplevelproducts b on a.entitycode = b.entitycode'
      '  set @iteration_rows_added = @iteration_rows_added - @@rowcount'
      ' '
      
        '  insert @toplevelproducts select entitycode, @current_iteration' +
        ' from @toplevelproducts_add'
      'end'
      ''
      'delete from @toplevelproducts'
      'from @toplevelproducts a'
      
        'join #portionheader b on (a.entitycode = b.entitycode and b.isch' +
        'oice = 1)'
      ''
      'insert @validproducts'
      '(productid)'
      'select a.entitycode '
      'from products a'
      'join @toplevelproducts b on a.entitycode = b.entitycode'
      
        'join ac_productsubcategory psc on a.[sub-category name] = psc.[N' +
        'ame]'
      
        'and (psc.AllowSitePricing = 1 or psc.AllowSiteNaming = 1) and IS' +
        'NULL(psc.deleted, 0) = 0'
      
        'where a.[Entity Type] <> '#39'Instruct.'#39' and ISNULL(a.deleted, '#39'N'#39') ' +
        '= '#39'N'#39
      ''
      'insert @validportions'
      '(productid, portiontypeid)'
      'select b.entitycode as productid, b.portiontypeid'
      'from @validproducts a'
      'join #portionheader b on (a.productid = b.entitycode) '
      ''
      'delete @toplevelproducts'
      'drop table #portionheader'
      'drop table #portiondetail'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; produce editing t' +
        'ables '#39
      ''
      
        'delete from ThemeSiteProducts where productid not in (select pro' +
        'ductid from @validproducts)'
      
        'delete from ThemeSiteProductPrice where productid not in (select' +
        ' productid from @validproducts)'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; insert central pr' +
        'oduct details'#39
      ''
      'insert #editproducts'
      
        '(productid, SubCategoryID, centralname, centralline1, centrallin' +
        'e2, centralline3, overridenames, modified, allowreprice, allowre' +
        'name)'
      
        'select entitycode, psc.Id, "Extended Rtl Name", AztecEposButton1' +
        ', AztecEposButton2, AztecEposButton3, 0, 0, psc.AllowSitePricing' +
        ', psc.AllowSiteNaming'
      'from products p'
      
        'join ac_productsubcategory psc on p.[sub-category name] = psc.[N' +
        'ame]'
      'and (psc.AllowSitePricing = 1 or psc.AllowSiteNaming = 1)'
      'where entitycode in (select productid from @validproducts)'
      ''
      '-- add existing site customisations'
      
        'print convert(varchar(50), getdate(), 21) + '#39'; update site produ' +
        'ct settings'#39
      'update #editproducts'
      'set overridenames = 1,'
      '  sitename = a.name,'
      '  siteline1 = a.eposname1,'
      '  siteline2 = a.eposname2,'
      '  siteline3 = a.eposname3'
      'from'
      '('
      '  select productid, name, eposname1, eposname2, eposname3'
      '  from themesiteproducts'
      '  where sitecode = (select top 1 sitecode from themesites)'
      ') a'
      'where a.productid = #editproducts.productid'
      ''
      'print convert(varchar(50), getdate(), 21) + '#39'; insert portions '#39
      ''
      'insert #editprices'
      '(productid, portiontypeid, portiontype, overrideprice, modified)'
      'select productid, a.portiontypeid, b.portiontypename, 0, 0'
      'from @validportions a'
      'join PortionType b on a.portiontypeid = b.portiontypeid'
      ''
      
        'print convert(varchar(50), getdate(), 21) + '#39'; update site price' +
        's '#39
      ''
      'update #editprices'
      'set overrideprice = 1,'
      '  siteprice = a.price,'
      '  sitesupplementprice = a.supplementprice'
      'from'
      '('
      '  select productid, portiontypeid, price, supplementprice'
      '  from themesiteproductprice'
      '  where sitecode = (select top 1 sitecode from themesites)'
      ') a'
      
        'where a.productid = #editprices.productid and a.portiontypeid = ' +
        '#editprices.portiontypeid'
      '  '
      
        'print convert(varchar(50), getdate(), 21) + '#39'; get list of Panel' +
        's used on Site '#39
      'insert #PanelsOnSite '
      'select distinct panelid'
      'from #PanelProduct where PanelID in '
      '  (select PanelID from themePanel '
      #9'where PanelDesignID in '
      '      (select distinct PanelDesignID from ThemeEposDesign))'
      ''
      'insert #PanelsOnSite'
      'select distinct VariationPanelID from ThemeSiteVariation'
      ''
      'insert #PanelsOnSite'
      'select subPanelID from ThemePanelSubPanel where ParentPanelID in'
      '          (select PanelID from #PanelsOnSite)'
      ''
      'print convert(varchar(50), getdate(), 21) + '#39'; end'#39)
    Left = 217
    Top = 112
  end
  object qApplyEdits: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '-- apply changes'
      '-- delete site prices that were removed from site control'
      'delete ThemeSiteProductPrice '
      'from'
      '('
      
        '  select productid, portiontypeid from #editprices where modifie' +
        'd = 1 and overrideprice = 0'
      ') a'
      
        'where a.productid = ThemeSiteProductPrice.productid and a.portio' +
        'ntypeid = ThemeSiteProductPrice.portiontypeid and '
      '  sitecode = (select top 1 [site code] from siteaztec)'
      
        '-- delete site product entries that were removed from site name ' +
        'control'
      'delete ThemeSiteProducts'
      'from'
      '('
      
        '  select productid from #editproducts where modified = 1 and ove' +
        'rridenames = 0'
      ') a'
      'where a.productid = ThemeSiteProducts.productid and'
      '  sitecode = (select top 1 [site code] from siteaztec)'
      ''
      '-- modify site prices that were changed'
      'update ThemeSiteProductPrice'
      'set'
      '  Price = a.siteprice,'
      '  SupplementPrice = a.sitesupplementprice'
      'from'
      '('
      
        '  select productid, portiontypeid, isnull(siteprice, 0) as sitep' +
        'rice, isnull(sitesupplementprice, 0) as sitesupplementprice from' +
        ' #editprices where modified = 1 and overrideprice = 1'
      ') a'
      
        'where a.productid = ThemeSiteProductPrice.productid and a.portio' +
        'ntypeid = ThemeSiteProductPrice.portiontypeid and '
      '  sitecode = (select top 1 [site code] from siteaztec)'
      '-- modify site product names that were changed'
      'update ThemeSiteProducts'
      'set'
      '  [Name] = a.sitename,'
      '  [eposname1] = a.siteline1,'
      '  [eposname2] = a.siteline2,'
      '  [eposname3] = a.siteline3'
      'from'
      '('
      '  select productid, sitename, siteline1, siteline2, siteline3 '
      '  from #editproducts where modified = 1 and overridenames = 1'
      ') a'
      'where ThemeSiteProducts.productid = a.productid and'
      '  sitecode = (select top 1 [site code] from siteaztec)'
      ''
      '-- clear modified flags for records that were updated'
      ''
      'update #editprices'
      'set modified = 0 '
      'from '
      '('
      '  select productid, portiontypeid'
      '  from ThemeSiteProductPrice'
      '  where sitecode = (select top 1 [site code] from siteaztec)'
      ') a'
      
        'where (a.productid = #editprices.productid and a.portiontypeid =' +
        ' #editprices.portiontypeid)'
      ''
      'update #editproducts'
      'set modified = 0 '
      'from'
      '('
      '  select productid'
      '  from ThemeSiteProducts'
      '  where sitecode = (select top 1 [site code] from siteaztec)'
      ') a'
      'where (a.productid = #editproducts.productid) '
      ''
      '-- insert newly defined site prices'
      'insert ThemeSiteProductPrice'
      '(SiteCode, ProductID, PortionTypeID, Price, SupplementPrice)'
      
        'select (select top 1 [site code] from siteaztec), productid, por' +
        'tiontypeid, isnull(siteprice, 0), isnull(sitesupplementprice, 0)'
      'from #editprices '
      'where '
      '  modified = 1 and overrideprice = 1'
      ''
      ''
      '-- insert newly defined site product names'
      'insert ThemeSiteProducts'
      '(SiteCode, ProductID, Name, Eposname1, eposname2, eposname3)'
      
        'select (select top 1 [site code] from siteaztec), a.productid, a' +
        '.sitename, a.siteline1, a.siteline2, a.siteline3'
      'from #editproducts a'
      'where '
      '  modified = 1 and overridenames = 1'
      ''
      'update #editprices set modified = 0'
      'update #editproducts set modified = 0'
      '')
    Left = 360
    Top = 112
  end
  object qDeleteTempTables: TADOQuery
    Connection = dmThemeData.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'if object_id('#39'tempdb..#editproducts'#39') is not null drop table #ed' +
        'itproducts'
      
        'if object_id('#39'tempdb..#editprices'#39') is not null drop table #edit' +
        'prices'
      
        'if object_id('#39'tempdb..#panelset'#39') is not null drop table #panels' +
        'et'
      
        'if object_id('#39'tempdb..#PanelsOnSite'#39') is not null drop table #Pa' +
        'nelsOnSite'
      
        'if object_id('#39'tempdb..#panelproduct'#39') is not null drop table #pa' +
        'nelproduct'
      
        'if object_id('#39'tempdb..#portionheader'#39') is not null drop table #p' +
        'ortionheader'
      
        'if object_id('#39'tempdb..#portiondetail'#39') is not null drop table #p' +
        'ortiondetail')
    Left = 152
    Top = 112
  end
  object qEditPrices: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterScroll = qEditPricesAfterScroll
    CommandTimeout = 0
    DataSource = dsEditProducts
    Parameters = <
      item
        Name = 'productid'
        DataType = ftLargeint
        Value = Null
      end>
    SQL.Strings = (
      'select * from #editprices where productid = :productid'
      '')
    Left = 312
    Top = 112
    object qEditPricesportiontype: TStringField
      DisplayLabel = 'Portion type'
      DisplayWidth = 16
      FieldName = 'portiontype'
      Size = 16
    end
    object qEditPricesoverrideprice: TBooleanField
      DisplayLabel = 'Use site price'
      DisplayWidth = 14
      FieldName = 'overrideprice'
      OnChange = PriceDataChange
    end
    object qEditPricessiteprice: TBCDField
      DisplayLabel = 'Site price'
      DisplayWidth = 10
      FieldName = 'siteprice'
      OnChange = PriceDataChange
      OnGetText = OverridePricesGetText
      DisplayFormat = #163'#######0.00'
      EditFormat = '#######0.00'
      Precision = 19
    end
    object qEditPricessitesupplementprice: TBCDField
      DisplayLabel = 'Site supplement price'
      DisplayWidth = 20
      FieldName = 'sitesupplementprice'
      OnChange = PriceDataChange
      OnGetText = OverridePricesGetText
      DisplayFormat = #163'#######0.00'
      EditFormat = '#######0.00'
      currency = True
      Precision = 19
    end
    object qEditPricesproductid: TLargeintField
      FieldName = 'productid'
      Visible = False
    end
    object qEditPricesportiontypeid: TIntegerField
      FieldName = 'portiontypeid'
      Visible = False
    end
    object qEditPricesmodified: TBooleanField
      FieldName = 'modified'
      Visible = False
    end
  end
  object dsEditPrices: TDataSource
    DataSet = qEditPrices
    Left = 312
    Top = 80
  end
  object qDeleteUnchanged: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'delete from #editproducts where'
      'productid not in'
      '(select distinct productid'
      'from #editproducts where overridenames = 1'
      'union'
      'select distinct productid'
      'from #editprices where overrideprice = 1)'
      '')
    Left = 400
    Top = 112
  end
  object qCheckForBlanks: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select top 1 *'
      'from #editproducts'
      'where '
      '  overridenames = 1 and (rtrim(ltrim(sitename))= '#39#39
      '    or'
      
        '    rtrim(ltrim(isnull(siteline1, '#39#39')+isnull(siteline2, '#39#39')+isnu' +
        'll(siteline3, '#39#39'))) = '#39#39')'
      ''
      '')
    Left = 432
    Top = 112
  end
  object qSubCategory: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ac_productsubcategory where deleted = 0')
    Left = 464
    Top = 112
  end
  object qCreateTempTables: TADOQuery
    Connection = dmThemeData.AztecConn
    Parameters = <>
    SQL.Strings = (
      '-- create tables used to pass/retrieve data from sub-procedures'
      
        'create table #PortionHeader (PortionID int, EntityCode float, Po' +
        'rtionTypeID smallint,'
      
        '  DisplayOrder tinyint, ContainsChoice bit, iteration int, IsCho' +
        'ice bit, ContainerID int, MinChoice int, MaxChoice int, SuppChoi' +
        'ce int, AllowPlain bit, primary key (portionid))'
      
        'create table #PortionDetail (PortionID int, IngredientCode float' +
        ', DisplayOrder tinyint,'
      
        '  Quantity decimal (8, 2), UnitName varchar (10) collate databas' +
        'e_default, PortionTypeID smallint, CalculationType tinyint, Cont' +
        'ainsChoice bit, IsChoice bit, IncludeByDefault bit, primary key ' +
        '(portionid, ingredientcode, displayorder))'
      ''
      'create table #panelset (panelid int, primary key (panelid))'
      
        'create table #PanelsOnSite (PanelID bigint, primary key (PanelID' +
        '))'
      
        'create table #panelProduct (panelid bigint, EntityCode bigint, p' +
        'rimary key (panelid, EntityCode))'
      ''
      
        'create table #editproducts (productid bigint, SubCategoryID int,' +
        ' centralname varchar(16), centralline1 varchar(8),'
      
        '  centralline2 varchar(8), centralline3 varchar(8), overridename' +
        's bit, sitename varchar(16),'
      
        '  siteline1 varchar(8), siteline2 varchar(8), siteline3 varchar(' +
        '8), modified bit, allowreprice bit,'
      '  allowrename bit primary key (productid))'
      ''
      
        'create table #editprices (productid bigint, portiontypeid int, p' +
        'ortiontype varchar(16), overrideprice bit, siteprice money,'
      
        '  sitesupplementprice money, modified bit primary key (productid' +
        ', portiontypeid))'
      ''
      '')
    Left = 184
    Top = 112
  end
end
