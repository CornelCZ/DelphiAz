object frmNewInternalTransfer: TfrmNewInternalTransfer
  Left = 840
  Top = 241
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'New Internal Transfer'
  ClientHeight = 613
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtonPanel: TPanel
    Left = 0
    Top = 512
    Width = 693
    Height = 101
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      693
      101)
    object btnClose: TButton
      Left = 606
      Top = 69
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
    object btnAddItem: TButton
      Left = 304
      Top = 9
      Width = 75
      Height = 25
      Hint = 'Add the current Product to the Transfer Item list'
      Caption = '&Add Item'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAddItemClick
    end
    object btnSend: TButton
      Left = 304
      Top = 69
      Width = 75
      Height = 25
      Hint = 'Send the transfer Item to the destination site'
      Caption = '&Send'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSendClick
    end
    object btnRemoveItem: TButton
      Left = 304
      Top = 39
      Width = 75
      Height = 25
      Hint = 'Remove the current item from the Transfer Items list'
      Caption = '&Remove Item'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnRemoveItemClick
    end
    object gbFindProduct: TGroupBox
      Left = 8
      Top = 3
      Width = 187
      Height = 91
      Caption = 'Find Product'
      TabOrder = 4
      object btnPrevious: TButton
        Left = 135
        Top = 24
        Width = 46
        Height = 22
        Hint = 'Go to the previous record that matches the search text'
        Caption = 'Prev'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnPreviousClick
      end
      object btnNext: TButton
        Left = 136
        Top = 53
        Width = 46
        Height = 22
        Hint = 'Go to the next record that matches the search text'
        Caption = 'Next'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnNextClick
      end
      object cbMidWordSearch: TCheckBox
        Left = 8
        Top = 56
        Width = 97
        Height = 17
        Hint = 
          'Select this option to search for products that have '#13#10'the search' +
          ' text at any position in the Purchase Name.'
        Caption = 'Mid-word search'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = cbMidWordSearchClick
      end
    end
    object gbFilter: TGroupBox
      Left = 200
      Top = 3
      Width = 98
      Height = 91
      Caption = 'Filter'
      TabOrder = 5
      object cbFiltered: TCheckBox
        Left = 9
        Top = 27
        Width = 65
        Height = 17
        Hint = 'Remove the current search filter'
        Caption = 'Filtered'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = cbFilteredClick
      end
      object btnSetFilter: TButton
        Left = 8
        Top = 53
        Width = 80
        Height = 22
        Hint = 'Set the criteria for the search filter'
        Caption = 'Set Filter...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnSetFilterClick
      end
    end
    object edSearchEdit: TEdit
      Left = 16
      Top = 27
      Width = 121
      Height = 21
      Hint = 'Enter the text to search for'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnChange = edSearchEditChange
    end
  end
  object pnlHeaderPanel: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 49
    Align = alTop
    TabOrder = 1
    DesignSize = (
      693
      49)
    object lblSendToSite: TLabel
      Left = 39
      Top = 16
      Width = 65
      Height = 13
      Caption = 'Send To Site:'
    end
    object lblDateToSend: TLabel
      Left = 251
      Top = 16
      Width = 67
      Height = 13
      Caption = 'Delivery Date:'
    end
    object lbltransferID: TLabel
      Left = 469
      Top = 16
      Width = 56
      Height = 13
      Caption = 'Transfer ID:'
    end
    object edSendToSite: TEdit
      Left = 111
      Top = 14
      Width = 121
      Height = 17
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object edDateToSend: TEdit
      Left = 324
      Top = 14
      Width = 121
      Height = 17
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object edOrderNo: TEdit
      Left = 534
      Top = 14
      Width = 121
      Height = 17
      Anchors = [akRight, akBottom]
      BorderStyle = bsNone
      Enabled = False
      TabOrder = 2
    end
  end
  object pnlFormPanel: TPanel
    Left = 0
    Top = 49
    Width = 693
    Height = 463
    Align = alClient
    TabOrder = 2
    object pnlProductList: TPanel
      Left = 1
      Top = 169
      Width = 691
      Height = 293
      Align = alClient
      BorderWidth = 5
      TabOrder = 0
      object lblProductList: TLabel
        Left = 6
        Top = 6
        Width = 679
        Height = 13
        Align = alTop
        Caption = 'Available Product List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object wwDBGridProductList: TwwDBGrid
        Left = 6
        Top = 19
        Width = 679
        Height = 268
        Hint = 'Double click to add the current item to the Transfer Item list'
        Selected.Strings = (
          'Purchase Name'#9'20'#9'Purchase Name'
          'Retail Description'#9'20'#9'Retail Description'
          'Unit Name'#9'10'#9'Unit Name'
          'Unit Cost'#9'10'#9'Unit Cost'
          'Flavour'#9'10'#9'Flavour'
          'Sub-Category Name'#9'20'#9'Sub-Category Name')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsAllProductsList
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnDblClick = wwDBGridProductListDblClick
      end
    end
    object pnlTransferItems: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 168
      Align = alTop
      BorderWidth = 5
      Caption = 'pnlTransferItems'
      TabOrder = 1
      object lblTransferItems: TLabel
        Left = 6
        Top = 6
        Width = 679
        Height = 13
        Align = alTop
        Caption = 'Transfer Items'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object wwDBGridNewTransferItems: TwwDBGrid
        Left = 6
        Top = 19
        Width = 679
        Height = 143
        ControlType.Strings = (
          'UnitName;CustomEdit;wwDBcbUnitName;F'
          'Flavour;CustomEdit;wwDBcbFlavour;F')
        Selected.Strings = (
          'RecordID'#9'10'#9'Record No.'#9'T'
          'PurchaseName'#9'20'#9'Purchase Name'#9'T'
          'UnitName'#9'10'#9'Unit Name'#9'T'
          'Quantity'#9'11'#9'Quantity'
          'CostPerUnit'#9'11'#9'Cost Per Unit'#9'T'
          'TotalCost'#9'11'#9'Total Cost'#9'T'
          'Flavour'#9'10'#9'Flavour'#9'T'
          'LMDT'#9'18'#9'LMDT'#9'T')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsNewTransferItems
        KeyOptions = [dgAllowDelete]
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnColEnter = wwDBGridNewTransferItemsColEnter
      end
    end
  end
  object cdsNewTransferItems: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DestinationSiteCode'
        DataType = ftSmallint
      end
      item
        Name = 'SenderName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'InternalTransferSentID'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RecordID'
        DataType = ftFloat
      end
      item
        Name = 'EntityCode'
        DataType = ftFloat
      end
      item
        Name = 'PurchaseName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Flavour'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Quantity'
        DataType = ftBCD
        Precision = 10
        Size = 2
      end
      item
        Name = 'UnitName'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'CostPerUnit'
        DataType = ftBCD
        Precision = 10
        Size = 4
      end
      item
        Name = 'TotalCost'
        DataType = ftBCD
        Precision = 10
        Size = 4
      end
      item
        Name = 'LMDT'
        DataType = ftDateTime
      end
      item
        Name = 'SentBy'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Accepted'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    Params = <
      item
        DataType = ftSmallint
        Name = 'sitecode'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'transferID'
        ParamType = ptInput
        Value = #39#39
      end>
    ProviderName = 'dspNewTransferItems'
    StoreDefs = True
    Left = 120
    Top = 88
    object cdsNewTransferItemsDestinationSiteCode: TSmallintField
      DisplayWidth = 10
      FieldName = 'DestinationSiteCode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsNewTransferItemsSenderName: TStringField
      DisplayWidth = 20
      FieldName = 'SenderName'
    end
    object cdsNewTransferItemsInternalTransferSentID: TStringField
      DisplayWidth = 15
      FieldName = 'InternalTransferSentID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 15
    end
    object cdsNewTransferItemsRecordID: TFloatField
      DisplayWidth = 10
      FieldName = 'RecordID'
    end
    object cdsNewTransferItemsEntityCode: TFloatField
      DisplayWidth = 10
      FieldName = 'EntityCode'
    end
    object cdsNewTransferItemsPurchaseName: TStringField
      DisplayWidth = 20
      FieldName = 'PurchaseName'
    end
    object cdsNewTransferItemsFlavour: TStringField
      DisplayWidth = 10
      FieldName = 'Flavour'
      Size = 10
    end
    object cdsNewTransferItemsQuantity: TBCDField
      DisplayWidth = 11
      FieldName = 'Quantity'
      OnChange = QuantityChange
      Precision = 10
      Size = 2
    end
    object cdsNewTransferItemsUnitName: TStringField
      DisplayWidth = 10
      FieldName = 'UnitName'
      Size = 10
    end
    object cdsNewTransferItemsCostPerUnit: TBCDField
      DisplayWidth = 11
      FieldName = 'CostPerUnit'
      Precision = 10
    end
    object cdsNewTransferItemsTotalCost: TBCDField
      DisplayWidth = 11
      FieldName = 'TotalCost'
      Precision = 10
    end
    object cdsNewTransferItemsLMDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LMDT'
    end
    object cdsNewTransferItemsSentBy: TStringField
      DisplayWidth = 20
      FieldName = 'SentBy'
    end
    object cdsNewTransferItemsAccepted: TStringField
      DisplayWidth = 1
      FieldName = 'Accepted'
      FixedChar = True
      Size = 1
    end
  end
  object dspNewTransferItems: TDataSetProvider
    DataSet = ADOqryInternalTransferSentDetail
    Constraints = True
    Left = 152
    Top = 88
  end
  object dsNewTransferItems: TDataSource
    DataSet = cdsNewTransferItems
    Left = 120
    Top = 56
  end
  object dsAllProductsList: TDataSource
    DataSet = ADOqryGetTransferableProducts
    Left = 120
    Top = 248
  end
  object ADOsp_createMasterSentRec: TADOStoredProc
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    ProcedureName = 'sp_createSentMasterRec;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@siteCode'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end
      item
        Name = '@senderName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@sentBy'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@deliveryDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@accepted'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@transferID'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 15
        Value = Null
      end>
    Left = 8
    Top = 8
  end
  object ADOqryInternalTransferSentDetail: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'sitecode'
        DataType = ftSmallint
        Value = 0
      end
      item
        Name = 'transferID'
        DataType = ftString
        Size = 2
        Value = #39#39
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM InternalTransferSentDetail'
      'WHERE DestinationSiteCode  = :sitecode'
      'AND InternalTransferSentID = :transferID'
      'ORDER BY RecordID')
    Left = 184
    Top = 88
  end
  object ADOqryGetTransferableProducts: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'SELECT DISTINCT a.[EntityCode], a.[Purchase Name], a.[Retail Des' +
        'cription], a.[Sub-Category Name],'
      '   b.[Unit Name], b.[Flavour],b.[Unit Cost]'
      'FROM Products a '
      '  INNER JOIN punits b'
      '    ON a.[EntityCode] = b.[Entity Code]'
      '  INNER JOIN '
      '     (SELECT s2.[Supplier Name]'
      
        '      FROM (select * from ac_SiteSuppliers where SiteId = dbo.fn' +
        'GetSiteCode()) s1'
      
        '      LEFT OUTER JOIN Supplier s2 ON s1.SupplierID = s2.[Supplie' +
        'r Code]) c'
      '    ON b.[Supplier Name] = c.[Supplier Name]'
      
        'WHERE ( a.[Entity Type] = '#39'Strd.Line'#39' OR a.[Entity Type] = '#39'Purc' +
        'h.Line'#39' )'
      'AND (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      'ORDER BY [Purchase name]')
    Left = 152
    Top = 248
    object ADOqryGetTransferableProductsPurchaseName: TStringField
      DisplayWidth = 20
      FieldName = 'Purchase Name'
    end
    object ADOqryGetTransferableProductsRetailDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Retail Description'
    end
    object ADOqryGetTransferableProductsUnitName: TStringField
      DisplayWidth = 10
      FieldName = 'Unit Name'
      Size = 10
    end
    object ADOqryGetTransferableProductsUnitCost: TBCDField
      DisplayWidth = 10
      FieldName = 'Unit Cost'
      Precision = 19
    end
    object ADOqryGetTransferableProductsFlavour: TStringField
      DisplayWidth = 10
      FieldName = 'Flavour'
      Size = 10
    end
    object ADOqryGetTransferableProductsSubCategoryName: TStringField
      DisplayWidth = 20
      FieldName = 'Sub-Category Name'
    end
    object ADOqryGetTransferableProductsEntityCode: TFloatField
      FieldName = 'EntityCode'
      Visible = False
    end
  end
  object ADOQrySearchSubSet: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = '@PurchName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = ''
      end>
    SQL.Strings = (
      
        'SELECT DISTINCT a.[EntityCode], a.[Purchase Name], a.[Retail Des' +
        'cription], a.[Sub-Category Name],'
      '   b.[Unit Name], b.[Flavour],b.[Unit Cost]'
      
        'FROM Products a INNER JOIN punits b ON a.[EntityCode] = b.[Entit' +
        'y Code]'
      
        'WHERE ( a.[Entity Type] = '#39'Strd.Line'#39' OR a.[Entity Type] = '#39'Purc' +
        'h.Line'#39' )'
      'AND (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      'AND a.[Purchase Name] LIKE :@PurchName'
      'ORDER BY [Purchase name]')
    Left = 120
    Top = 488
  end
  object wwfdProducts: TwwFilterDialog
    DataSource = dsAllProductsList
    Options = [fdShowOKCancel]
    SortBy = fdSortByFieldName
    Caption = 'Product Search Filter'
    FilterMethod = fdByQueryModify
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    DefaultField = 'Purchase Name'
    FieldsFetchMethod = fmUseSQL
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    FilterPropertyOptions.LikeWildcardChar = '%'
    SelectedFields.Strings = (
      'Purchase Name'
      'Retail Description'
      'Unit Name'
      'Unit Cost'
      'Flavour'
      'Sub-Category Name')
    FilterOptimization = fdNone
    QueryFormatDateMode = qfdDayMonthYear
    SQLTables = <
      item
        TableName = 'Products'
        TableAliasName = 'a'
      end
      item
        TableName = 'Punits'
        TableAliasName = 'b'
      end>
    Left = 264
    Top = 504
  end
end
