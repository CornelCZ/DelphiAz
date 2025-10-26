object KeyLinesForm: TKeyLinesForm
  Left = 230
  Top = 240
  Width = 1024
  Height = 680
  HelpContext = 5062
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Key Lines'
  Color = clBtnFace
  Constraints.MaxWidth = 1024
  Constraints.MinHeight = 470
  Constraints.MinWidth = 1024
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    1016
    650)
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddProduct: TSpeedButton
    Left = 283
    Top = 72
    Width = 33
    Height = 24
    Hint = 'Add Product'
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = btnAddItemClick
  end
  object btnAddSubcat: TSpeedButton
    Left = 694
    Top = 72
    Width = 33
    Height = 24
    Hint = 'Add Subcategory'
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = btnAddItemClick
  end
  object gbxProduct: TGroupBox
    Left = 2
    Top = 16
    Width = 271
    Height = 625
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Products'
    TabOrder = 0
    DesignSize = (
      271
      625)
    object wwDBGridProduct: TwwDBGrid
      Left = 6
      Top = 24
      Width = 259
      Height = 497
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = False
      Anchors = [akLeft, akTop, akBottom]
      DataSource = dsProduct
      KeyOptions = []
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Shell Dlg 2'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = True
      OnTitleButtonClick = wwDBGridProductTitleButtonClick
      OnDblClick = wwDBGridDblClick
    end
    object gbxFindProduct: TGroupBox
      Left = 6
      Top = 528
      Width = 259
      Height = 91
      Anchors = [akRight, akBottom]
      Caption = 'Find Product'
      TabOrder = 1
      DesignSize = (
        259
        91)
      object edtFindProduct: TEdit
        Left = 5
        Top = 15
        Width = 244
        Height = 21
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 0
      end
      object chkbxProductMidWordSearch: TCheckBox
        Left = 5
        Top = 38
        Width = 107
        Height = 17
        TabStop = False
        Caption = 'Mid-word search'
        TabOrder = 1
      end
      object btnFindPrevProduct: TButton
        Left = 92
        Top = 60
        Width = 75
        Height = 25
        Caption = 'Find Previous'
        TabOrder = 2
        TabStop = False
      end
      object btnFindNextProduct: TButton
        Left = 6
        Top = 60
        Width = 75
        Height = 25
        Caption = 'Find Next'
        TabOrder = 3
        TabStop = False
      end
    end
  end
  object gbxSubCategory: TGroupBox
    Left = 735
    Top = 16
    Width = 280
    Height = 625
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Sub Categories'
    TabOrder = 1
    DesignSize = (
      280
      625)
    object wwDBGridSubcat: TwwDBGrid
      Left = 6
      Top = 24
      Width = 269
      Height = 497
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = False
      Anchors = [akLeft, akTop, akBottom]
      DataSource = dsSubcat
      KeyOptions = []
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Shell Dlg 2'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = True
      OnTitleButtonClick = wwDBGridSubcatTitleButtonClick
      OnDblClick = wwDBGridDblClick
    end
    object gbxFindSubcat: TGroupBox
      Left = 6
      Top = 528
      Width = 269
      Height = 91
      Anchors = [akRight, akBottom]
      Caption = 'Find Subcategory'
      TabOrder = 1
      DesignSize = (
        269
        91)
      object edtFindSubcat: TEdit
        Left = 5
        Top = 15
        Width = 252
        Height = 21
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 0
      end
      object chkbxSubcatMidWordSearch: TCheckBox
        Left = 5
        Top = 38
        Width = 107
        Height = 17
        TabStop = False
        Caption = 'Mid-word search'
        TabOrder = 1
      end
      object btnFindPrevSubcat: TButton
        Left = 92
        Top = 59
        Width = 75
        Height = 25
        Caption = 'Find Previous'
        TabOrder = 2
        TabStop = False
      end
      object btnFindNextSubcat: TButton
        Left = 6
        Top = 60
        Width = 75
        Height = 25
        Caption = 'Find Next'
        TabOrder = 3
        TabStop = False
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 325
    Top = 16
    Width = 361
    Height = 281
    Caption = 'Key Lines'
    TabOrder = 2
    object wwDBGridKeyLine: TwwDBGrid
      Left = 9
      Top = 24
      Width = 344
      Height = 209
      Selected.Strings = (
        'Name'#9'20'#9'Name'
        'DivisionName'#9'20'#9'Division'
        'TypeName'#9'12'#9'Type')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      DataSource = dsKeyLine
      KeyOptions = []
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Shell Dlg 2'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
    end
    object btnRemoveItem: TButton
      Left = 256
      Top = 248
      Width = 97
      Height = 25
      Caption = '&Remove Item'
      TabOrder = 1
      OnClick = btnRemoveItemClick
    end
  end
  object Panel1: TPanel
    Left = 325
    Top = 344
    Width = 361
    Height = 57
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 31
      Top = 15
      Width = 299
      Height = 26
      AutoSize = False
      WordWrap = True
    end
  end
  object btnOk: TButton
    Left = 418
    Top = 616
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 522
    Top = 616
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object pnlWarning: TPanel
    Left = 325
    Top = 416
    Width = 361
    Height = 97
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 6
    object Label2: TLabel
      Left = 31
      Top = 15
      Width = 309
      Height = 65
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object dtProduct: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = 'SELECT *'#13#10'FROM #SellableProducts'#13#10'ORDER BY ProductName'
    Parameters = <>
    Left = 104
    Top = 72
    object dtProductProductId: TLargeintField
      FieldName = 'ProductId'
      Visible = False
    end
    object dtProductSubcategoryId: TIntegerField
      FieldName = 'SubcategoryId'
      Visible = False
    end
    object dtProductProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 16
      FieldName = 'ProductName'
    end
    object dtProductSubcategoryName: TStringField
      DisplayLabel = 'Sub Category'
      FieldName = 'SubcategoryName'
    end
    object dtProductDivisionName: TStringField
      FieldName = 'DivisionName'
      Visible = False
    end
  end
  object dsProduct: TDataSource
    DataSet = dtProduct
    Left = 136
    Top = 72
  end
  object dtSubcat: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = 'SELECT *'#13#10'FROM #SellableSubcats'#13#10'ORDER BY SubcategoryName'
    Parameters = <>
    Left = 816
    Top = 72
    object dtSubcatSubcategoryId: TIntegerField
      FieldName = 'SubcategoryId'
      Visible = False
    end
    object dtSubcatSubcategoryName: TStringField
      DisplayLabel = 'Sub Category'
      FieldName = 'SubcategoryName'
    end
    object dtSubcatDivisionName: TStringField
      DisplayLabel = 'Division'
      DisplayWidth = 17
      FieldName = 'DivisionName'
    end
  end
  object dsSubcat: TDataSource
    DataSet = dtSubcat
    Left = 840
    Top = 72
  end
  object cmdInitialise: TADOCommand
    CommandText = 
      'DECLARE @SiteId int'#13#10'SET @SiteId = :SiteId'#13#10#13#10'IF OBJECT_ID('#39'temp' +
      'db..#SellableProducts'#39') IS NOT NULL'#13#10'  DROP TABLE #SellableProdu' +
      'cts '#13#10#13#10'CREATE TABLE #SellableProducts'#13#10'('#13#10'  ProductId bigint PR' +
      'IMARY KEY,'#13#10'  SubcategoryId int,'#13#10'  ProductName varchar(20),'#13#10'  ' +
      'SubcategoryName varchar(20),'#13#10'  DivisionName varchar(20)'#13#10')'#13#10#13#10'I' +
      'F OBJECT_ID('#39'tempdb..#SellableSubcats'#39') IS NOT NULL'#13#10'  DROP TABL' +
      'E #SellableSubcats '#13#10#13#10'CREATE TABLE #SellableSubcats'#13#10'('#13#10'  Subca' +
      'tegoryId int PRIMARY KEY,'#13#10'  SubcategoryName varchar(20),'#13#10'  Div' +
      'isionName varchar(20)'#13#10')'#13#10#13#10'IF OBJECT_ID('#39'tempdb..#KeyLine'#39') IS ' +
      'NOT NULL'#13#10'  DROP TABLE #KeyLine '#13#10#13#10'CREATE TABLE #KeyLine'#13#10'('#13#10'  ' +
      'Id bigint, -- Either a ProductId or a SubcategoryId'#13#10'  Type int,' +
      '   -- 0=Product, 1=Subcategory'#13#10'  Name varchar(20),'#13#10'  DivisionN' +
      'ame varchar(20)'#13#10')'#13#10#13#10#13#10'INSERT #SellableProducts (ProductId, Sub' +
      'categoryId, ProductName, SubcategoryName, DivisionName)'#13#10'SELECT ' +
      'a.ProductId, subcat.Id, p.[Extended RTL Name], p.[Sub-Category N' +
      'ame], div.Name'#13#10'FROM dbo.fnGetProductsSelectedOnTouchPanelDesign' +
      ' ('#39'SITE'#39', @SiteId) a'#13#10'     INNER JOIN Products p ON a.ProductId ' +
      '= p.EntityCode'#13#10'     INNER JOIN ac_ProductSubcategory subcat ON ' +
      'p.[Sub-Category Name] = subcat.Name'#13#10'     INNER JOIN ac_ProductC' +
      'ategory cat ON subcat.ProductCategoryId = cat.Id'#13#10'     INNER JOI' +
      'N ac_ProductDivision div ON cat.ProductDivisionId = div.Id'#13#10#13#10#13#10 +
      'INSERT #SellableSubcats (SubcategoryId, SubcategoryName, Divisio' +
      'nName)'#13#10'SELECT a.Id, a.Name, c.Name'#13#10'FROM ac_ProductSubcategory ' +
      'a'#13#10'  INNER JOIN ac_ProductCategory b ON a.ProductCategoryId = b.' +
      'Id'#13#10'  INNER JOIN ac_ProductDivision c ON b.ProductDivisionId = c' +
      '.Id'#13#10'WHERE a.Id IN (SELECT DISTINCT SubcategoryId FROM #Sellable' +
      'Products)'#13#10#13#10#13#10'INSERT #KeyLine (Id, [Type], Name, DivisionName)'#13 +
      #10'SELECT kl.Id, kl.Type, p.ProductName, p.DivisionName'#13#10'FROM KeyL' +
      'ine kl'#13#10'     INNER JOIN #SellableProducts p ON kl.Id = p.Product' +
      'Id'#13#10'WHERE SiteId = @SiteId AND kl.Type = 0 -- 0=Product'#13#10#13#10#13#10'INS' +
      'ERT #KeyLine (Id, [Type], Name, DivisionName)'#13#10'SELECT kl.Id, kl.' +
      'Type, s.SubcategoryName, s.DivisionName'#13#10'FROM KeyLine kl'#13#10'     I' +
      'NNER JOIN #SellableSubcats s ON kl.Id = s.SubcategoryId'#13#10'WHERE S' +
      'iteId = @SiteId AND kl.Type = 1 -- 1=Subcategory'#13#10
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end>
    Left = 368
    Top = 304
  end
  object dtKeyLine: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    OnCalcFields = dtKeyLineCalcFields
    CommandText = 'SELECT *'#13#10'FROM #KeyLine'#13#10'ORDER BY Name'
    Parameters = <>
    Left = 416
    Top = 64
    object dtKeyLineName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
    end
    object dtKeyLineDivisionName: TStringField
      DisplayLabel = 'Division'
      DisplayWidth = 20
      FieldName = 'DivisionName'
    end
    object dtKeyLineTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'TypeName'
      Size = 12
      Calculated = True
    end
    object dtKeyLineId: TLargeintField
      DisplayWidth = 15
      FieldName = 'Id'
      Visible = False
    end
    object dtKeyLineType: TIntegerField
      DisplayWidth = 10
      FieldName = 'Type'
      Visible = False
    end
  end
  object dsKeyLine: TDataSource
    DataSet = dtKeyLine
    Left = 448
    Top = 64
  end
  object PopupMenu: TPopupMenu
    Left = 328
    Top = 304
    object AddToKeyLines: TMenuItem
      Caption = 'Add To Key Lines'
      OnClick = AddToKeyLinesClick
    end
  end
end
