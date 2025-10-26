object ProductsDB: TProductsDB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 678
  Top = 119
  Height = 806
  Width = 894
  object ProductTypesDS: TDataSource
    DataSet = ProductTypesTable
    Left = 256
    Top = 240
  end
  object RecipeNotesTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    BeforePost = RecipeNotesTableBeforePost
    IndexFieldNames = '[Entity Code]'
    MasterFields = 'EntityCode'
    MasterSource = EntityDataSource
    TableName = 'RecipeNt'
    Left = 32
    Top = 296
    object RecipeNotesTableEntityCode: TFloatField
      FieldName = 'Entity Code'
    end
    object RecipeNotesTableRecipeNotes: TMemoField
      FieldName = 'Recipe Notes'
      OnChange = RecipeNotesTableRecipeNotesChange
      BlobType = ftMemo
    end
    object RecipeNotesTableOriginalLMD: TDateTimeField
      FieldName = 'Original LMD'
    end
    object RecipeNotesTableOriginalLMT: TStringField
      FieldName = 'Original LMT'
      FixedChar = True
      Size = 5
    end
    object RecipeNotesTableLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
  end
  object EntityDataSource: TDataSource
    DataSet = ClientEntityTable
    Left = 152
    Top = 80
  end
  object RecipeNotesDataSource: TDataSource
    DataSet = RecipeNotesTable
    Left = 152
    Top = 296
  end
  object UnitSupplierTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = '#tmpPurchaseUnits'
    Left = 32
    Top = 352
    object UnitSupplierTableEntityCode: TFloatField
      FieldName = 'Entity Code'
    end
    object UnitSupplierTableSupplierName: TStringField
      FieldName = 'Supplier Name'
    end
    object UnitSupplierTableUnitName: TStringField
      FieldName = 'Unit Name'
      Size = 10
    end
    object UnitSupplierTableFlavour: TStringField
      FieldName = 'Flavour'
      Size = 10
    end
    object UnitSupplierTableImportExportReference: TStringField
      FieldName = 'Import/Export Reference'
      Size = 15
    end
    object UnitSupplierTableBarcode: TStringField
      FieldName = 'Barcode'
    end
    object UnitSupplierTableUnitCost: TBCDField
      FieldName = 'Unit Cost'
      currency = True
      Precision = 19
    end
    object UnitSupplierTableDefaultFlag: TStringField
      FieldName = 'Default Flag'
      FixedChar = True
      Size = 1
    end
    object UnitSupplierTableEffectiveDate: TDateTimeField
      FieldName = 'EffectiveDate'
      Visible = False
    end
    object UnitSupplierTableUserID: TLargeintField
      FieldName = 'UserID'
      Visible = False
    end
  end
  object UnitSupplierDataSource: TDataSource
    DataSet = UnitSupplierTable
    Left = 152
    Top = 352
  end
  object UnitsQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT [Unit Name], [Base Type], [Base Units]'
      'FROM Units'
      'WHERE (Deleted <> '#39'Y'#39') OR Deleted IS NULL'
      'ORDER BY [Unit Name]')
    Left = 392
    Top = 144
  end
  object SubcategoryQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT s.Name AS SubcategoryName, c.ProductDivisionId AS Divisio' +
        'nId'
      'FROM ac_ProductSubCategory s JOIN ac_ProductCategory c'
      '  ON s.ProductCategoryId = c.Id'
      'WHERE s.Deleted = 0'
      'ORDER BY s.Name')
    Left = 392
    Top = 192
  end
  object VatBandQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT [VAT Band Name], [Index No]'
      'FROM Vatband'
      'WHERE (Deleted <> '#39'Y'#39') OR Deleted IS NULL'
      'ORDER BY [VAT Band Name]')
    Left = 392
    Top = 96
  end
  object PrintStreamQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT [Printer Stream Name]'
      'FROM PStreams'
      'WHERE (Deleted <> '#39'Y'#39') OR Deleted IS NULL'
      'ORDER BY [Printer Stream Name]')
    Left = 392
    Top = 48
  end
  object SupplierQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT [Supplier Name]'
      'FROM Supplier'
      'ORDER BY [Supplier Name]')
    Left = 392
    Top = 240
  end
  object EntityTable: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = 'SELECT * FROM Products'#13#10'WHERE Deleted <> '#39'Y'#39' OR Deleted IS NULL'
    Parameters = <>
    Left = 32
    Top = 8
    object EntityTableEntityCode: TFloatField
      Alignment = taLeftJustify
      FieldName = 'EntityCode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object EntityTableRetailName: TStringField
      FieldName = 'Retail Name'
      Size = 11
    end
    object EntityTableRetailDescription: TStringField
      DisplayWidth = 32
      FieldName = 'Retail Description'
      Size = 40
    end
    object EntityTableEntityType: TStringField
      FieldName = 'Entity Type'
      Size = 10
    end
    object EntityTableImportExportReference: TStringField
      FieldName = 'Import/Export Reference'
      Size = 15
    end
    object EntityTableSubCategoryName: TStringField
      FieldName = 'Sub-Category Name'
    end
    object EntityTableDefaultPrinterStream: TStringField
      FieldName = 'Default Printer Stream'
      Size = 19
    end
    object EntityTableAlcohol: TFloatField
      FieldName = '% Alcohol'
    end
    object EntityTableWhetherSalesTaxable: TStringField
      FieldName = 'Whether Sales Taxable'
      FixedChar = True
      Size = 1
    end
    object EntityTableWhetherOpenPriced: TStringField
      FieldName = 'Whether Open Priced'
      FixedChar = True
      Size = 1
    end
    object EntityTablePurchaseName: TStringField
      FieldName = 'Purchase Name'
      Size = 40
    end
    object EntityTablePurchaseUnit: TStringField
      FieldName = 'Purchase Unit'
      Size = 10
    end
    object EntityTableDefaultSupplier: TStringField
      FieldName = 'Default Supplier'
    end
    object EntityTableBudgetedCostPrice: TBCDField
      FieldName = 'Budgeted Cost Price'
      Precision = 19
    end
    object EntityTableLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object EntityTableModifiedBy: TStringField
      FieldName = 'Modified By'
      Size = 10
    end
    object EntityTableCreationDate: TDateTimeField
      FieldName = 'Creation Date'
    end
    object EntityTableDeleted: TStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object EntityTableAztecEposButton1: TStringField
      FieldName = 'AztecEposButton1'
      Size = 8
    end
    object EntityTableAztecEposButton2: TStringField
      FieldName = 'AztecEposButton2'
      Size = 8
    end
    object EntityTableAztecEposButton3: TStringField
      FieldName = 'AztecEposButton3'
      Size = 8
    end
    object EntityTableExtendedRTLName: TStringField
      FieldName = 'Extended RTL Name'
      Size = 16
    end
    object EntityTableSpecialRecipe: TStringField
      FieldName = 'SpecialRecipe'
      FixedChar = True
      Size = 1
    end
    object EntityTableTrueHalfAllowed: TBooleanField
      FieldName = 'TrueHalfAllowed'
    end
    object EntityTableCourseID: TSmallintField
      FieldName = 'CourseID'
    end
    object EntityTablePrintStreamWhenChild: TWordField
      FieldName = 'PrintStreamWhenChild'
    end
    object EntityTableRollupPriceWhenChild: TBooleanField
      FieldName = 'RollupPriceWhenChild'
    end
    object EntityTableFollowCourseWhenChild: TBooleanField
      FieldName = 'FollowCourseWhenChild'
    end
    object EntityTableDiscontinue: TBooleanField
      FieldName = 'Discontinue'
    end
    object EntityTableSoldByWeight: TBooleanField
      FieldName = 'SoldByWeight'
    end
    object EntityTableisGiftCard: TWordField
      FieldName = 'isGiftCard'
    end
    object EntityTableB2BName: TStringField
      FieldName = 'B2BName'
      Size = 100
    end
  end
  object EntityTableProvider: TDataSetProvider
    DataSet = EntityTable
    Constraints = True
    ResolveToDataSet = True
    Options = [poFetchDetailsOnDemand]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = EntityTableProviderUpdateError
    Left = 120
    Top = 8
  end
  object ClientEntityTable: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    DisableStringTrim = True
    Params = <>
    ProviderName = 'EntityTableProvider'
    OnCalcFields = ClientEntityTableCalcFields
    Left = 32
    Top = 80
    object ClientEntityTableEntityCode: TFloatField
      Alignment = taLeftJustify
      FieldName = 'EntityCode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ClientEntityTableRetailName: TStringField
      FieldName = 'Retail Name'
      Size = 11
    end
    object ClientEntityTableRetailDescription: TStringField
      DisplayWidth = 32
      FieldName = 'Retail Description'
      Size = 40
    end
    object ClientEntityTableEntityType: TStringField
      FieldName = 'Entity Type'
      OnGetText = ClientEntityTableEntityTypeGetText
      Size = 10
    end
    object ClientEntityTableImportExportReference: TStringField
      FieldName = 'Import/Export Reference'
      Size = 15
    end
    object ClientEntityTableSubCategoryName: TStringField
      FieldName = 'Sub-Category Name'
    end
    object ClientEntityTableDefaultPrinterStream: TStringField
      FieldName = 'Default Printer Stream'
      Size = 19
    end
    object ClientEntityTableAlcohol: TFloatField
      FieldName = '% Alcohol'
      MaxValue = 100
    end
    object ClientEntityTableWhetherSalesTaxable: TStringField
      FieldName = 'Whether Sales Taxable'
      FixedChar = True
      Size = 1
    end
    object ClientEntityTableWhetherOpenPriced: TStringField
      FieldName = 'Whether Open Priced'
      FixedChar = True
      Size = 1
    end
    object ClientEntityTablePurchaseName: TStringField
      FieldName = 'Purchase Name'
      Size = 40
    end
    object ClientEntityTablePurchaseUnit: TStringField
      FieldName = 'Purchase Unit'
      Size = 10
    end
    object ClientEntityTableDefaultSupplier: TStringField
      FieldName = 'Default Supplier'
    end
    object ClientEntityTableBudgetedCostPrice: TBCDField
      FieldName = 'Budgeted Cost Price'
      currency = True
      Precision = 19
    end
    object ClientEntityTableLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object ClientEntityTableModifiedBy: TStringField
      FieldName = 'Modified By'
      Size = 10
    end
    object ClientEntityTableCreationDate: TDateTimeField
      FieldName = 'Creation Date'
    end
    object ClientEntityTableDeleted: TStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object ClientEntityTableAztecEposButton1: TStringField
      FieldName = 'AztecEposButton1'
      Size = 8
    end
    object ClientEntityTableAztecEposButton2: TStringField
      FieldName = 'AztecEposButton2'
      Size = 8
    end
    object ClientEntityTableAztecEposButton3: TStringField
      FieldName = 'AztecEposButton3'
      Size = 8
    end
    object ClientEntityTableExtendedRTLName: TStringField
      FieldName = 'Extended RTL Name'
      Size = 16
    end
    object ClientEntityTableSpecialRecipe: TStringField
      FieldName = 'SpecialRecipe'
      FixedChar = True
      Size = 1
    end
    object ClientEntityTableEntityTypeOrder: TSmallintField
      FieldKind = fkInternalCalc
      FieldName = 'EntityTypeOrder'
    end
    object ClientEntityTableTrueHalfAllowed: TBooleanField
      FieldName = 'TrueHalfAllowed'
    end
    object ClientEntityTableCourseID: TSmallintField
      FieldName = 'CourseID'
    end
    object ClientEntityTablePrintStreamWhenChild: TSmallintField
      FieldName = 'PrintStreamWhenChild'
      OnGetText = ClientEntityTablePrintStreamWhenChildGetText
      OnSetText = ClientEntityTablePrintStreamWhenChildSetText
    end
    object ClientEntityTableRollupPriceWhenChild: TBooleanField
      FieldName = 'RollupPriceWhenChild'
    end
    object ClientEntityTableFollowCourseWhenChild: TBooleanField
      FieldName = 'FollowCourseWhenChild'
    end
    object ClientEntityTableDiscontinue: TBooleanField
      FieldName = 'Discontinue'
    end
    object ClientEntityTableSoldByWeight: TBooleanField
      FieldName = 'SoldByWeight'
    end
    object ClientEntityTableisGiftCard: TWordField
      Alignment = taLeftJustify
      FieldName = 'isGiftCard'
      OnGetText = ClientEntityTableisGiftCardGetText
      OnSetText = ClientEntityTableisGiftCardSetText
    end
    object ClientEntityTableB2BName: TStringField
      FieldName = 'B2BName'
      Size = 100
    end
  end
  object ADOCommand: TADOCommand
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 256
    Top = 8
  end
  object ADOQuery: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 256
    Top = 56
  end
  object PortionTypeTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'PortionType'
    Left = 464
    Top = 404
  end
  object PortionTypeDataSource: TDataSource
    DataSet = PortionTypeTable
    Left = 612
    Top = 408
  end
  object IngredDataSource1: TDataSource
    DataSet = IngredientsQuery1
    Left = 336
    Top = 412
  end
  object PortionsDataSource1: TDataSource
    DataSet = PortionsQuery1
    Left = 125
    Top = 412
  end
  object ADOStoredProc: TADOStoredProc
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 256
    Top = 112
  end
  object ProductTypesTable: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandText = '#ProductTypes'
    CommandType = cmdTable
    Parameters = <>
    Left = 392
    Top = 288
  end
  object ProductTaxTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    AfterScroll = ProductTaxTableAfterScroll
    IndexFieldNames = 'EntityCode'
    MasterFields = 'EntityCode'
    MasterSource = EntityDataSource
    TableName = 'ProductTaxRules'
    Left = 256
    Top = 168
    object ProductTaxTableEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object ProductTaxTableTaxRule1: TSmallintField
      FieldName = 'TaxRule1'
      OnChange = ProductTaxTableTaxRuleChange
    end
    object ProductTaxTableTaxRule2: TSmallintField
      FieldName = 'TaxRule2'
      OnChange = ProductTaxTableTaxRuleChange
    end
    object ProductTaxTableTaxRule3: TSmallintField
      FieldName = 'TaxRule3'
      OnChange = ProductTaxTableTaxRuleChange
    end
    object ProductTaxTableTaxRule4: TSmallintField
      FieldName = 'TaxRule4'
      OnChange = ProductTaxTableTaxRuleChange
    end
  end
  object ProductTaxDS: TDataSource
    DataSet = ProductTaxTable
    OnUpdateData = ProductTaxDSUpdateData
    Left = 312
    Top = 184
  end
  object qryTaxRules: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ac_TaxRule'
      'WHERE OpenAmount = 0'
      'AND'
      '((Deleted is NULL) OR (Deleted = 0))')
    Left = 256
    Top = 296
  end
  object dsTaxRules: TDataSource
    DataSet = qryTaxRules
    Left = 312
    Top = 296
  end
  object DefaultPortionQuery: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'defaultID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end
      item
        Name = 'defaultName'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT [PortionTypeID], [PortionTypeName]'
      'FROM [PortionType]'
      'WHERE [PortionTypeID] = :defaultID'
      'AND [PortionTypeName] = :defaultName')
    Left = 498
    Top = 15
  end
  object IngredientsQuery1: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    OnCalcFields = IngredientsQueryCalcFields
    CommandText = 
      'SELECT *, CONVERT(money, 0) AS Cost'#13#10'FROM PortionIngredients'#13#10'OR' +
      'DER BY [DisplayOrder] ASC'#13#10
    DataSource = PortionsDataSource1
    IndexFieldNames = 'PortionID;DisplayOrder'
    MasterFields = 'PortionID'
    Parameters = <>
    Left = 228
    Top = 412
    object IngredientsQuery1IngredientName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'IngredientName'
      Calculated = True
    end
    object IngredientsQuery1IngredientDescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'IngredientDescription'
      Calculated = True
    end
    object IngredientsQuery1UnitDisplayName: TStringField
      DisplayLabel = 'Unit'
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'UnitDisplayName'
      ReadOnly = True
      Calculated = True
    end
    object IngredientsQuery1Quantity: TBCDField
      DisplayWidth = 8
      FieldName = 'Quantity'
      Precision = 8
      Size = 2
    end
    object IngredientsQuery1PortionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PortionID'
      Visible = False
    end
    object IngredientsQuery1IngredientCode: TFloatField
      DisplayWidth = 10
      FieldName = 'IngredientCode'
      Visible = False
    end
    object IngredientsQuery1UnitName: TStringField
      DisplayWidth = 10
      FieldName = 'UnitName'
      Visible = False
      Size = 10
    end
    object IngredientsQuery1PortionTypeID: TSmallintField
      DisplayWidth = 10
      FieldName = 'PortionTypeID'
      Visible = False
    end
    object IngredientsQuery1CalculationType: TWordField
      DisplayWidth = 10
      FieldName = 'CalculationType'
      Visible = False
    end
    object IngredientsQuery1DisplayOrder: TWordField
      DisplayWidth = 10
      FieldName = 'DisplayOrder'
      Visible = False
    end
    object IngredientsQuery1IngredientType: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'IngredientType'
      LookupDataSet = EntityTable
      LookupKeyFields = 'EntityCode'
      LookupResultField = 'Entity Type'
      KeyFields = 'IngredientCode'
      Visible = False
      Lookup = True
    end
    object IngredientsQuery1Cost: TBCDField
      DisplayWidth = 8
      FieldKind = fkInternalCalc
      FieldName = 'Cost'
      DisplayFormat = '0.0000'
      currency = True
      Size = 10
    end
    object IngredientsQuery1IsMinor: TBooleanField
      DisplayWidth = 8
      FieldName = 'IsMinor'
    end
  end
  object PortionsQuery1: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandText = 'SELECT *'#13#10'FROM [Portions]'#13#10'WHERE [DisplayOrder] = 1'#13#10
    DataSource = EntityDataSource
    IndexFieldNames = 'EntityCode'
    MasterFields = 'EntityCode'
    Parameters = <>
    Left = 32
    Top = 412
  end
  object MultiPurchIngredientTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    OnCalcFields = MultiPurchIngredientTableCalcFields
    IndexFieldNames = 'EntityCode; DisplayOrder'
    MasterFields = 'EntityCode'
    MasterSource = EntityDataSource
    TableName = 'MultiPurchIngredients'
    Left = 464
    Top = 472
    object MultiPurchIngredientTableEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object MultiPurchIngredientTableIngredientCode: TFloatField
      FieldName = 'IngredientCode'
    end
    object MultiPurchIngredientTableDisplayOrder: TWordField
      FieldName = 'DisplayOrder'
    end
    object MultiPurchIngredientTableUnitName: TStringField
      FieldName = 'UnitName'
      Size = 10
    end
    object MultiPurchIngredientTableIngredientName: TStringField
      FieldKind = fkCalculated
      FieldName = 'IngredientName'
      Calculated = True
    end
    object MultiPurchIngredientTableIngredientDescr: TStringField
      FieldKind = fkCalculated
      FieldName = 'IngredientDescr'
      Calculated = True
    end
    object MultiPurchIngredientTableReturnable: TBooleanField
      FieldName = 'Returnable'
    end
  end
  object MultiPurchIngredDataSource: TDataSource
    DataSet = MultiPurchIngredientTable
    Left = 612
    Top = 472
  end
  object FindEditSessionIdsQuery: TADODataSet
    Connection = dmADO.AztecConn
    CommandText = 'select distinct [SessionId] from ProductChangeLog2'
    Parameters = <>
    Left = 512
    Top = 280
  end
  object ProductChangeLog: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandText = 'select * from ProductChangeLog2 where [SessionId] = :sessionid'
    IndexFieldNames = 'SessionId; ParentCode; ChildCode; Operation'
    Parameters = <
      item
        Name = 'sessionid'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 64
        Value = Null
      end>
    Left = 504
    Top = 128
  end
  object spDeleteEntityFromTheme: TADOStoredProc
    Connection = dmADO.AztecConn
    ProcedureName = 'Theme_RemoveProduct;1'
    Parameters = <
      item
        Name = 'ProductID'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end>
    Left = 464
    Top = 536
  end
  object CategoryTreeQuery: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'select'#13#10'  division.[Division Name] as division,'#13#10'  category.[Cat' +
      'egory Name] as category,'#13#10'  subcateg.[Sub-category Name] as subc' +
      'ategory'#13#10'from'#13#10'  division'#13#10'    join'#13#10'  category on ( division.[D' +
      'ivision Name] = category.[Division Name] )'#13#10'    join'#13#10'  subcateg' +
      ' on ( category.[Category Name] = subcateg.[category Name] )'#13#10'whe' +
      're'#13#10'  subcateg.Deleted is null'#13#10'order by'#13#10'  division.[Division N' +
      'ame],'#13#10'  category.[Category Name],'#13#10'  subcateg.[Sub-category Nam' +
      'e]'#13#10'  '
    Parameters = <>
    Left = 504
    Top = 192
  end
  object dsProductBarcodes: TDataSource
    DataSet = qryProductBarCodes
    Left = 40
    Top = 528
  end
  object qryProductBarCodes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = EntityDataSource
    Parameters = <
      item
        Name = 'EntityCode'
        Attributes = [paSigned]
        DataType = ftFloat
        Precision = 19
        Value = 10000000001
      end>
    SQL.Strings = (
      'select * from ProductBarCode'
      'where EntityCode = :EntityCode'
      'order by Barcode')
    Left = 32
    Top = 468
  end
  object tblPreparedItemDetails: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    IndexFieldNames = 'EntityCode'
    MasterFields = 'EntityCode'
    MasterSource = EntityDataSource
    TableName = 'PreparedItemDetail'
    Left = 272
    Top = 352
    object tblPreparedItemDetailsEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object tblPreparedItemDetailsStorageUnit: TStringField
      FieldName = 'StorageUnit'
      OnChange = tblPreparedItemDetailsStorageUnitChange
      Size = 10
    end
    object tblPreparedItemDetailsBatchUnit: TStringField
      FieldName = 'BatchUnit'
      OnChange = tblPreparedItemDetailsBatchUnitChange
      Size = 10
    end
    object tblPreparedItemDetailsBatchSize: TBCDField
      FieldName = 'BatchSize'
      OnValidate = tblPreparedItemDetailsBatchSizeValidate
      DisplayFormat = '0.##'
      EditFormat = '0.##'
      MaxValue = 999
      Precision = 8
      Size = 2
    end
    object tblPreparedItemDetailsNotes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
    end
    object tblPreparedItemDetailsLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
  end
  object dsPreparedItemDetails: TDataSource
    DataSet = tblPreparedItemDetails
    Left = 408
    Top = 352
  end
  object qEditTempPortions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'displayorder'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'declare @displayorder int'
      'set @displayorder = :displayorder'
      ''
      'select * from #tmpportions'
      'where displayorder = @displayorder')
    Left = 507
    Top = 596
  end
  object dsTempPortions: TDataSource
    DataSet = qEditTempPortions
    Left = 507
    Top = 640
  end
  object qEditCookTimes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #tmpportions'
      'order by displayorder asc')
    Left = 355
    Top = 596
    object qEditCookTimesportionname: TStringField
      FieldName = 'portionname'
    end
    object qEditCookTimesCookTime: TDateTimeField
      FieldName = 'CookTime'
      OnGetText = qEditCookTimesCookTimeGetText
    end
    object qEditCookTimesdefaultcooktime: TBooleanField
      FieldName = 'defaultcooktime'
    end
    object qEditCookTimesportiontypeid: TSmallintField
      FieldName = 'portiontypeid'
    end
  end
  object dsEditCookTimes: TDataSource
    DataSet = qEditCookTimes
    Left = 355
    Top = 640
  end
  object dsPortionType: TDataSource
    DataSet = qPortionType
    Left = 427
    Top = 640
  end
  object qPortionType: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from PortionType'
      'where discontinued = 0')
    Left = 427
    Top = 596
  end
  object DataSource1: TDataSource
    Left = 692
    Top = 224
  end
  object qLoadPortions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'entitycode'
        DataType = ftFloat
        Value = Null
      end
      item
        Name = 'effectivedate'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'declare @ProductCode float, @EffectiveDate varchar(20), @EffectD' +
        'ate_AsDateTime datetime'
      'set @ProductCode = :EntityCode'
      'set @EffectiveDate = :EffectiveDate'
      
        'set @EffectDate_AsDateTime = CASE WHEN @EffectiveDate = '#39'Current' +
        #39' THEN NULL ELSE CONVERT(datetime, @EffectiveDate) END'
      ''
      'TRUNCATE TABLE #TmpPortionCrosstab'
      'TRUNCATE TABLE #TmpPortions'
      
        'TRUNCATE TABLE #PortionBudgetedCosts  -- Empty the temp tables t' +
        'hat cache budgeted cost prices'
      
        'TRUNCATE TABLE #UnitBudgetedCosts     -- to force recalculation ' +
        'when a new parent product is selected.'
      'TRUNCATE TABLE #TmpPortionChoices'
      ''
      'if @effectivedate = '#39'Current'#39
      'begin'
      '  -- Build table of portions for this product'
      
        '  insert #TmpPortions (portionid,portiontypeid,displayorder,cook' +
        'time,containerid)'
      
        '  select portionid,portiontypeid,displayorder,cooktime,container' +
        'id'
      '  from portions p'
      '  where p.entitycode = @productcode'
      '  order by displayorder'
      ''
      '  -- Build cross tab of product portion ingredients'
      '  insert #tmpportioncrosstab'
      '    (entitycode,Name,Description,displayorder)'
      '  select distinct'
      
        '    pr.entitycode, pr.[Extended RTL Name], pr.[retail descriptio' +
        'n], pi.displayorder'
      '  from portions p'
      
        '    join portioningredients pi on (p.portionID = pi.portionid an' +
        'd p.entitycode = @productcode)'
      '    join products pr on pr.entitycode = pi.ingredientcode'
      '  order by pi.DisplayOrder'
      ''
      '  -- update include by default column from standard portion'
      
        '  update #tmpportioncrosstab set IncludeByDefault = x.IncludeByD' +
        'efault'
      '              from (select ingredientcode, includebydefault'
      '                                 from PortionIngredients pin'
      
        '                                        inner join Portions p on' +
        ' p.PortionID = pin.PortionID'
      
        '                       where p.EntityCode = @productcode and p.D' +
        'isplayOrder = 1) x'
      '  where x.IngredientCode = #tmpportioncrosstab.EntityCode'
      ''
      
        '  insert into #TmpPortionChoices(portionid, entitycode, minchoic' +
        'e, maxchoice, suppchoice, allowplain)'
      
        '  select portionid, entitycode, minchoice, maxchoice, suppchoice' +
        ', allowplain'
      '         from portions p'
      '  where p.entitycode = @productcode and DisplayOrder = 1'
      'end'
      'else'
      'begin'
      '  -- Build table of future portions for this product'
      
        '  insert #TmpPortions (portionid,portiontypeid,displayorder,cook' +
        'time,containerid)'
      
        '  select portionid,portiontypeid,displayorder,cooktime,container' +
        'id'
      '  from portionsfuture pf'
      '  where pf.entitycode = @productcode'
      '  and pf.effectivedate = @effectivedate'
      '  order by displayorder'
      ''
      '  -- Build cross tab of future portion ingredients'
      '  insert #tmpportioncrosstab'
      '    (entitycode,Name,Description,displayorder)'
      '  select distinct'
      
        '    pr.entitycode, pr.[Extended RTL Name], pr.[retail descriptio' +
        'n], pi.displayorder'
      '  from portionsfuture p'
      '    join portioningredientsfuture pi'
      
        '      on (p.portionID = pi.portionid and p.entitycode = @product' +
        'code'
      
        '      and pi.effectivedate = p.effectivedate and pi.effectivedat' +
        'e = @effectivedate)'
      '    join products pr on pr.entitycode = pi.ingredientcode'
      '  order by pi.DisplayOrder'
      ''
      '  -- update include by default column from standard portion'
      
        '  update #tmpportioncrosstab set IncludeByDefault = x.IncludeByD' +
        'efault '
      '              from (select ingredientcode, includebydefault '
      
        '                                 from portioningredientsfuture p' +
        'in'
      
        '                                        inner join Portions p on' +
        ' p.PortionID = pin.PortionID'
      
        '                       where p.EntityCode = @productcode and p.D' +
        'isplayOrder = 1 '
      
        '                                 and pin.effectivedate = @effect' +
        'ivedate ) x'
      '  where x.IngredientCode = #tmpportioncrosstab.EntityCode'
      '  '
      
        '  insert into #TmpPortionChoices(portionid, entitycode, minchoic' +
        'e, maxchoice, suppchoice, allowplain)'
      
        '  select portionid, entitycode, minchoice, maxchoice, suppchoice' +
        ', allowplain'
      '         from portionsfuture pf'
      '  where pf.entitycode = @productcode'
      
        '        and pf.effectivedate = @effectivedate and DisplayOrder =' +
        ' 1'
      'end'
      ''
      '-- Amend the extra fields in #tmpportions'
      'update #tmpportions'
      'set defaultcooktime = case'
      '  when cooktime is null then 1'
      '  else 0'
      '  end'
      ''
      'update #tmpportions'
      'set defaultcooktime = 0'
      'where portionTypeID = 1'
      ''
      'update #tmpportions'
      'set portionname ='
      '  (select PortionTypeName'
      '   from PortionType pt'
      '   where pt.portiontypeid = #tmpportions.portiontypeid)'
      ''
      'update #tmpportions'
      'set entitycode = @productcode'
      ''
      'update #tmpportionchoices'
      '  set enablechoices = case when minchoice is null then 0'
      '                           when maxchoice is null then 0'
      '                           when suppchoice is null then 0'
      
        '                           when allowplain is null then 0 else 1' +
        ' end'
      ''
      'if @effectivedate = '#39'Current'#39
      'begin'
      '  declare portionsCur cursor for'
      '  select'
      '    pi.ingredientcode,'
      '    pi.displayorder as '#39'ingredient_displayorder'#39','
      '    pi.quantity,'
      '    pi.calculationtype,'
      '    pi.unitname,'
      '    p.displayorder,'
      '    p.portionid,'
      '    pi.portiontypeid as '#39'portioningredients_portiontypeid'#39','
      '    pi.isminor'
      '  from portions p'
      
        '  inner join portioningredients pi on (p.portionid = pi.portioni' +
        'd and p.entitycode = @productcode)'
      '  order by p.DisplayOrder, pi.displayorder'
      'end'
      'else'
      'begin'
      '  declare portionsCur cursor for'
      '  select'
      '    pi.ingredientcode,'
      '    pi.displayorder as '#39'ingredient_displayorder'#39','
      '    pi.quantity,'
      '    pi.calculationtype,'
      '    pi.unitname,'
      '    p.displayorder,'
      '    p.portionid,'
      '    pi.portiontypeid as '#39'portioningredients_portiontypeid'#39','
      '    pi.isminor'
      '  from portionsfuture p'
      
        '  inner join portioningredientsfuture pi on (p.portionid = pi.po' +
        'rtionid and p.entitycode = @productcode'
      
        '  and pi.effectivedate = p.effectivedate and pi.effectivedate = ' +
        '@effectivedate)'
      '  order by p.DisplayOrder, pi.displayorder'
      'end'
      ''
      
        'declare @ingredientcode bigint, @ingredient_displayOrder tinyint' +
        ','
      '        @quantity decimal(10,4), @calculationtype tinyint,'
      '        @UnitName varchar(10), @portionorder int,'
      
        '        @portionid bigint, @portioningredients_portiontypeid as ' +
        'int, @isminor bit'
      ''
      'open portionsCur'
      
        'fetch next from portionsCur into @ingredientcode,@ingredient_dis' +
        'playOrder,'
      
        '                                 @quantity,@calculationtype,@uni' +
        'tname,@portionorder,'
      
        '                                 @portionID, @portioningredients' +
        '_portiontypeid, @isminor'
      ''
      'declare @CostPrice money'
      ''
      'declare @query1 varchar(400)'
      'declare @query2 varchar(400)'
      'declare @query3 varchar(400)'
      'declare @query4 varchar(400)'
      'declare @query5 varchar(400)'
      'declare @query6 varchar(400)'
      'declare @query7 varchar(400)'
      ''
      'while @@fetch_status = 0'
      'begin'
      '  set @CostPrice = NULL'
      ''
      '  if @calculationtype = 1'
      '  begin'
      
        '    exec #spGetUnitBudgetedCostPrice @CostPrice OUTPUT, @Ingredi' +
        'entCode, @UnitName, @Quantity, @EffectDate_AsDateTime'
      '  end else if @calculationtype = 2'
      '  begin'
      
        '    set @unitname = (select portiontypename from PortionType whe' +
        're portiontypeid = @portioningredients_portiontypeid)'
      
        '    exec #spGetPortionBudgetedCostPrice @CostPrice OUTPUT, @Ingr' +
        'edientCode, @portioningredients_portiontypeid, @Quantity, @Effec' +
        'tDate_AsDateTime'
      '  end else if @calculationtype = 3'
      '  begin'
      '    set @unitname ='#39'Factor'#39
      
        '    select @CostPrice = CostPrice1 * @Quantity from #tmpportionc' +
        'rosstab'
      
        '    where entitycode = @ingredientcode and displayorder = @ingre' +
        'dient_displayOrder'
      '  end'
      ''
      
        '  set @query1 = '#39'update #tmpportioncrosstab set [quantity'#39' + cas' +
        't(@portionorder as varchar(50)) + '#39'] = '#39' + cast(@quantity as var' +
        'char(50))'
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query2 = '#39'update #tmpportioncrosstab set [unitname'#39' + cas' +
        't(@portionorder as varchar(50)) + '#39'] = '#39#39#39' + REPLACE(@UnitName,'#39 +
        #39#39#39','#39#39#39#39#39#39') + '#39#39#39#39
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query3 = '#39'update #tmpportioncrosstab set [calculationtype' +
        #39' + cast(@portionorder as varchar(50)) + '#39'] = '#39' + cast(@calculat' +
        'iontype as varchar(50))'
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query4 = '#39'update #tmpportioncrosstab set [portionid'#39' + ca' +
        'st(@portionorder as varchar(50)) + '#39'] = '#39#39#39' + cast(@portionid as' +
        ' varchar(50)) + '#39#39#39#39
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query5 = '#39'update #tmpportioncrosstab set [portioningredie' +
        'nts_portiontypeid'#39' + cast(@portionorder as varchar(50)) + '#39'] = '#39 +
        #39#39' + cast(@portioningredients_portiontypeid as varchar(10)) + '#39#39 +
        #39#39
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query6 = '#39'update #tmpportioncrosstab set [CostPrice'#39' + ca' +
        'st(@portionorder as varchar(50)) + '#39'] = '#39' + convert(char, @CostP' +
        'rice, 2)'
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      
        '  set @query7 = '#39'update #tmpportioncrosstab set [IsMinor'#39' + cast' +
        '(@portionorder as varchar(50)) + '#39'] = '#39' + cast(@isminor as varch' +
        'ar(50))'
      
        '    + '#39' where entitycode = '#39#39#39' + cast(@ingredientcode as varchar' +
        '(50)) + '#39#39#39' and displayorder = '#39' + cast(@ingredient_displayOrder' +
        ' as varchar(10))'
      ''
      ''
      '  exec(@query1)'
      '  exec(@query2)'
      '  exec(@query3)'
      '  exec(@query4)'
      '  exec(@query5)'
      '  exec(@query6)'
      '  exec(@query7)'
      ''
      
        '  fetch next from portionsCur into @ingredientcode,@ingredient_d' +
        'isplayOrder,'
      
        '                                   @quantity,@calculationtype,@u' +
        'nitname,@portionorder,'
      
        '                                   @portionID,@portioningredient' +
        's_portiontypeid, @isminor'
      'end'
      'close portionsCur'
      'deallocate portionsCur'
      ''
      ''
      
        '-- Ensure the DisplayOrders in #TmpPricesCrosstab are are sequen' +
        'tial without gaps.'
      '-- This is necessary for the re-ordering functionality to work.'
      'UPDATE #TmpPortionCrosstab'
      'SET DisplayOrder = b.RowNumber'
      'FROM #TmpPortionCrosstab a'
      '  JOIN'
      '  ('
      
        '     SELECT ROW_NUMBER() OVER (ORDER BY DisplayOrder) AS RowNumb' +
        'er, EntityCode, DisplayOrder'
      '     FROM #TmpPortionCrosstab'
      
        '  ) b ON a.EntityCode = b.EntityCode AND a.DisplayOrder = b.Disp' +
        'layOrder'
      'WHERE a.DisplayOrder <> b.RowNumber'
      ''
      ''
      ''
      '')
    Left = 22
    Top = 596
  end
  object qEditPortions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = qEditPortionsAfterPost
    Parameters = <>
    SQL.Strings = (
      'SELECT DisplayOrder AS Row, *'
      'FROM #tmpportioncrosstab'
      'ORDER BY DisplayOrder')
    Left = 174
    Top = 596
  end
  object qSavePortions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      '-- --------------------'
      
        '-- This routine does not use the normal Delphi parameters due to' +
        ' conflict'
      
        '-- with the labels, e.g. onerror, at the bottom.  A Format is do' +
        'ne in'
      '-- code to set @productcode, @maxportions, @effectivedate.'
      '-- --------------------'
      ''
      
        '-- This is necessary to enable errors to be detected by the ADO ' +
        'component. Without this messages of the type'
      
        '-- "X rows were updated" are passed to the ADO component which (' +
        'due to a bug) then fails to detect any errors'
      '-- that also may have occurred. Bug 338652.'
      'SET NOCOUNT ON'
      ''
      '-- Holding table for the new portion ingredients'
      
        'if object_id('#39'tempdb..#tmpportioningredients'#39') is not null drop ' +
        'table #tmpportioningredients'
      'create table #tmpportioningredients ('
      '  portionid int,'
      '  entitycode float,'
      '  displayorder tinyint,'
      '  quantity decimal(10,4),'
      '  UnitName varchar(10),'
      '  PortionTypeID smallint,'
      '  CalculationType tinyint,'
      '  IncludeByDefault bit,'
      '  IsMinor bit,'
      '  primary key (portionid,entitycode,displayorder)'
      '  )'
      ''
      '-- Holding table for the new portions'
      
        'if object_id('#39'tempdb..#portiontemp'#39') is not null drop table #por' +
        'tiontemp'
      'create table #portiontemp ('
      '  portionid int,'
      '  entitycode float,'
      '  portiontypeid smallint,'
      '  displayorder tinyint,'
      '  cooktime datetime,'
      '  containerid int,'
      '  minchoice smallint,'
      '  maxchoice smallint,'
      '  suppchoice smallint,'
      '  allowplain bit,'
      '  primary key (portionid)'
      ' )'
      ' '
      '-- Holding table for new portion ids'
      'DECLARE @NewPortionIds TABLE('
      '  PortionID int,'
      '  PortionTypeID smallint'
      ')'
      ''
      
        '--Holding table for future portions to allow manipulation of dat' +
        'a following bug 362370'
      'DECLARE @tempFuturePortions TABLE('
      '  PortionID int,'
      '  EntityCode float,'
      '  PortionTypeID smallint,'
      '  DisplayOrder tinyint,'
      '  CookTime datetime,'
      '  EffectiveDate datetime,'
      '  ContainerID int,'
      '  MinChoice smallint,'
      '  MaxChoice smallint,'
      '  SuppChoice smallint,'
      '  AllowPlain bit,'
      '  New bit, '
      '  Moved int'
      ' )'
      ''
      
        '--Holding table for dates of future portions that require a copy' +
        ' of'
      '--any new portions added in the current bug 362370'
      'DECLARE @tempEffectiveDates TABLE('
      '  EffectiveDate datetime'
      '  )'
      ''
      
        '--Holding table for duplicate display orders in the future creat' +
        'ed after copying'
      '--new portions added to the current bug 362370'
      'DECLARE @tempDuplicateDisplayOrders TABLE('
      '  DisplayOrder tinyint,'
      '  EffectiveDate datetime,'
      '  MaxMoved int'
      '  )'
      ''
      'declare @productcode float'
      'set @productcode = %s'
      ''
      'declare @maxportions smallint'
      'set @maxportions = %d'
      ''
      'declare @effectivedate varchar(20)'
      'set @effectivedate = '#39'%s'#39
      ''
      'declare @i int, @sql varchar(500)'
      ''
      'BEGIN TRY'
      '   BEGIN TRANSACTION'
      ''
      
        '   --blank Min/Max choice fields if the user didn'#39't check the ch' +
        'eck box'
      '   UPDATE #tmpportionchoices'
      
        '   SET minchoice = null, maxchoice = null, suppchoice = null, al' +
        'lowplain = null'
      '   WHERE EnableChoices = 0'
      ''
      '   UPDATE #tmpportionchoices'
      
        '   SET entitycode = @productcode, portionid = (SELECT portionid ' +
        'FROM #tmpportions WHERE displayorder = 1)'
      ''
      '   -- Prefill our holding table with the working copy values'
      '   INSERT INTO #PortionTemp'
      
        '   (portionid,entitycode,portiontypeid,displayorder,cooktime,con' +
        'tainerid,minchoice,maxchoice,suppchoice,allowplain)'
      
        '   SELECT tp.portionid, tp.entitycode,portiontypeid,displayorder' +
        ',cooktime,containerid,minchoice,maxchoice,suppchoice,allowplain'
      '   FROM #TmpPortions tp'
      
        '        left outer join #tmpportionchoices tpc ON tp.portionid =' +
        ' tpc.portionid and tp.entitycode = tpc.entitycode'
      '   WHERE not tp.portionid is null'
      ''
      '   UPDATE #PortionTemp'
      '   SET entitycode = @productcode'
      ''
      '   -- ensure min max is the same for all portions'
      
        '   UPDATE #PortionTemp SET MinChoice = a.MinChoice, MaxChoice = ' +
        'a.MaxChoice, SuppChoice = a.SuppChoice, AllowPlain = a.AllowPlai' +
        'n'
      
        '   FROM (SELECT EntityCode, MinChoice, MaxChoice, SuppChoice, Al' +
        'lowPlain FROM #PortionTemp WHERE displayorder = 1) a'
      '   WHERE #PortionTemp.EntityCode = a.EntityCode'
      ''
      
        '   -- Ensure the DisplayOrders in #TmpPricesCrosstab are are seq' +
        'uential without gaps. Gaps will exist if ingredients'
      '   -- have been deleted. Bug 358864.'
      '   UPDATE #TmpPortionCrosstab'
      '   SET DisplayOrder = b.RowNumber'
      '   FROM #TmpPortionCrosstab a'
      '     JOIN'
      '     ('
      
        '        SELECT ROW_NUMBER() OVER (ORDER BY DisplayOrder) AS RowN' +
        'umber, EntityCode, DisplayOrder'
      '        FROM #TmpPortionCrosstab'
      
        '     ) b ON a.EntityCode = b.EntityCode AND a.DisplayOrder = b.D' +
        'isplayOrder'
      '   WHERE a.DisplayOrder <> b.RowNumber'
      ''
      ''
      '   --Reinsert the portionid to the crosstab data'
      '   SET @i = 1'
      '   WHILE @i <= @maxportions'
      '   BEGIN'
      '     SET @sql = REPLACE('
      
        '       '#39'UPDATE #TmpPortionCrosstab SET PortionId{0} = (SELECT Po' +
        'rtionId FROM #PortionTemp WHERE DisplayOrder = {0})'#39','
      '       '#39'{0}'#39', convert(varchar(2), @i))'
      '     EXEC(@sql)'
      '     SET @i = @i + 1'
      '   END'
      ''
      
        '   --use the resinserted portionid to reverse the crosstab and g' +
        'et the portioningredients table back'
      '   SET @i = 1'
      '   WHILE @i <= @maxportions'
      '   BEGIN'
      '     SET @sql = REPLACE('
      '       '#39'INSERT #TmpPortionIngredients '#39' +'
      
        '       '#39'SELECT PortionId{0}, tp.entitycode, tp.displayorder, Qua' +
        'ntity{0}, Unitname{0}, PortionIngredients_PortionTypeID{0}, '#39' +'
      
        '       '#39'  CalculationType{0}, ISNULL(tp.IncludeByDefault, 0), IS' +
        'NULL(tp.IsMinor{0}, 0) '#39' +'
      
        '       '#39'FROM #TmpPortionCrosstab tp JOIN #PortionTemp pit on tp.' +
        'PortionId{0} = pit.portionid'#39','
      '       '#39'{0}'#39', convert(varchar(2), @i))'
      '     EXEC(@sql)'
      '     SET @i = @i + 1'
      '   END'
      ''
      
        '   --Remove the IncludeByDefault status if the choice isn'#39't min/' +
        'max'
      '   UPDATE #tmpportioningredients'
      
        '   SET IncludeByDefault = CASE WHEN (minchoice is null) AND (max' +
        'choice is null) AND (suppchoice is null) AND (allowplain is null' +
        ') THEN 0 ELSE IncludeByDefault END'
      '   FROM #tmpportioningredients tpi'
      '   JOIN #portiontemp pt'
      '   ON tpi.PortionID = pt.PortionID'
      ''
      
        '   -- Unitname only set when calculation type is '#39'Unit'#39', temp ta' +
        'ble has it filled'
      
        '   -- with portion names for the case when calculation type is '#39 +
        'Portion'#39
      '   UPDATE #tmpportioningredients'
      '   SET UnitName = null'
      '   WHERE calculationtype <> 1'
      ''
      '   IF @effectivedate = '#39'Current'#39
      '   BEGIN'
      ''
      '     DELETE PortionIngredients'
      '     FROM PortionIngredients pi'
      '     JOIN Portions p'
      '     ON  pi.portionid = p.portionid'
      '     AND p.entitycode = @productcode'
      ''
      '     --Store the new portions ids into table'
      '     INSERT @NewPortionIds'
      '     SELECT PortionID, PortionTypeID'
      '     FROM #portiontemp'
      '     WHERE PortionID NOT IN(SELECT PortionID FROM Portions)'
      ''
      '     DELETE Portions'
      '     WHERE entitycode = @productcode'
      ''
      
        '     INSERT Portions (portionid,entitycode,portiontypeid,display' +
        'order,cooktime,containerid,minchoice,maxchoice,suppchoice,allowp' +
        'lain)'
      '     SELECT * FROM #portiontemp'
      ''
      '     INSERT INTO @tempFuturePortions'
      '     SELECT *, 0 AS New, 0 AS Moved'
      '     FROM PortionsFuture'
      '     WHERE EntityCode = @productcode'
      ''
      
        '     -- GDM This handles case where an existing portion has been' +
        ' given a new portion type e.g. '#39'Double'#39' changed to '#39'Large'#39
      '     UPDATE @tempFuturePortions'
      '     SET PortionTypeID = temp.PortionTypeID'
      '     FROM @tempFuturePortions p'
      '     JOIN #portiontemp temp'
      '     ON p.Portionid = temp.portionid'
      ''
      
        '     -- GDM Handles the case where a portion type is added to cu' +
        'rrent which already exists in the future. We must make sure'
      
        '     -- the future portion has the same portionId and display or' +
        'der as the new current portion. Note: This scenario is unlikely'
      
        '     -- to occur as it is no longer possible (from 3.9.0) to add' +
        ' new portions on a future date.'
      '     UPDATE @tempFuturePortions'
      
        '     SET PortionID = temp.PortionID, DisplayOrder = temp.Display' +
        'Order, New = 1'
      '     FROM @tempFuturePortions p'
      '     JOIN  #portiontemp temp'
      '     ON p.PortionTypeID = temp.PortionTypeID '
      
        '     AND (p.PortionID <> temp.PortionID OR p.DisplayOrder <> tem' +
        'p.DisplayOrder)'
      ''
      '     INSERT INTO @tempEffectiveDates '
      '     SELECT DISTINCT EffectiveDate '
      '     FROM @tempFuturePortions'
      ''
      
        '     -- GDM Ensure any new portions added to Current are also ad' +
        'ded to any future dates'
      '     INSERT INTO @tempFuturePortions'
      
        '     SELECT p.PortionID, p.EntityCode, p.PortionTypeID, p.Displa' +
        'yOrder, p.CookTime, d.EffectiveDate, p.ContainerID, p.MinChoice,' +
        ' p.MaxChoice, p.SuppChoice, p.AllowPlain, 1 AS New, 0 AS Moved'
      '     FROM #portiontemp p'
      '     CROSS JOIN @tempEffectiveDates d'
      '     WHERE p.PortionID IN (SELECT PortionID'
      '                           FROM @NewPortionIds)'
      '                           '
      '     DELETE #dups'
      
        '     FROM (SELECT *, row_number() OVER (PARTITION BY PortionID, ' +
        'EffectiveDate ORDER BY PortionID, EffectiveDate) AS dupCount FRO' +
        'M @tempFuturePortions) #dups'
      '     WHERE dupCount > 1                       '
      ''
      '     INSERT INTO @tempDuplicateDisplayOrders'
      '     SELECT DisplayOrder, EffectiveDate, MAX(Moved) AS MaxMoved'
      '     FROM @tempFuturePortions'
      '     GROUP BY DisplayOrder, EffectiveDate'
      '     HAVING'
      '       COUNT(*) > 1'
      ''
      '     WHILE EXISTS(SELECT * FROM @tempDuplicateDisplayOrders)'
      '     BEGIN'
      ''
      '       UPDATE @tempFuturePortions'
      #9'   SET DisplayOrder = p.DisplayOrder + 1,'
      #9'   Moved = p.Moved + 1'
      #9'   FROM @tempFuturePortions p'
      #9'   JOIN @tempDuplicateDisplayOrders dup'
      #9'   ON p.DisplayOrder = dup.DisplayOrder'
      #9'   AND p.EffectiveDate = dup.EffectiveDate'
      #9'   AND p.Moved = dup.MaxMoved'
      #9'   WHERE New = 0'
      ''
      
        '       IF ((SELECT MAX(DisplayOrder) FROM @tempFuturePortions) >' +
        '= @maxportions)'
      '       BEGIN'
      
        '         RAISERROR('#39'Adding this portion will cause a future vers' +
        'ion of this product to exceed it maximum number of portions'#39', 16' +
        ', 1);'
      '       END'
      ''
      '       DELETE @tempDuplicateDisplayOrders'
      ''
      '       INSERT INTO @tempDuplicateDisplayOrders'
      
        '       SELECT DisplayOrder, EffectiveDate, MAX(Moved) AS MaxMove' +
        'd'
      '       FROM @tempFuturePortions'
      '       GROUP BY DisplayOrder, EffectiveDate'
      '       HAVING'
      '         COUNT(*) > 1'
      ''
      ''
      '     END'
      '     DELETE PortionsFuture'
      '     WHERE EntityCode = @productcode'
      ''
      '     INSERT PortionsFuture'
      
        '     SELECT DISTINCT PortionID, EntityCode, PortionTypeID, Displ' +
        'ayOrder, CookTime, EffectiveDate, ContainerID, MinChoice, MaxCho' +
        'ice, SuppChoice, AllowPlain'
      '     FROM @tempFuturePortions'
      ''
      '     INSERT PortionIngredients'
      '     SELECT * FROM #tmpportioningredients'
      ''
      
        '     -- GDM For all new portions added, copy the ingredients to ' +
        'each existing future change.'
      '     INSERT INTO PortionIngredientsFuture'
      
        '     SELECT i.PortionID, i.EntityCode, i.DisplayOrder, i.Quantit' +
        'y, i.UnitName, i.PortionTypeID, i.CalculationType, fpi.Effective' +
        'Date, i.IncludeByDefault, i.IsMinor'
      '     FROM #tmpPortionIngredients i'
      '     CROSS JOIN @tempEffectiveDates fpi'
      '     WHERE i.PortionID IN (SELECT PortionID'
      '                           FROM @NewPortionIds)'
      '                                                      '
      '   END'
      '   ELSE'
      '   BEGIN'
      ''
      '     DELETE PortionIngredientsFuture'
      '     FROM PortionIngredientsFuture pif join PortionsFuture pf'
      '     ON  pif.portionid = pf.portionid'
      '     AND pif.effectivedate = pf.effectivedate'
      '     AND pf.entitycode = @productcode'
      '     AND pf.effectivedate = @effectivedate'
      ''
      '     DELETE PortionsFuture'
      '     WHERE entitycode = @productcode'
      '     AND effectivedate = @effectivedate'
      ''
      '     DECLARE @query1 VARCHAR(1000)'
      
        '     SET @query1 = '#39'insert PortionsFuture (portionid,entitycode,' +
        'portiontypeid,'#39
      
        '       + '#39'displayorder,cooktime,effectivedate,containerid,mincho' +
        'ice,maxchoice,suppchoice,allowplain) '#39
      
        '       + '#39'select portionid,entitycode,portiontypeid,displayorder' +
        ',cooktime,'#39#39#39' + @effectivedate + '#39#39#39',containerid,minchoice,maxch' +
        'oice,suppchoice,allowplain from #portiontemp'#39
      '     EXEC(@query1)'
      ''
      '     DECLARE @query2 VARCHAR(1000)'
      
        '     SET @query2 = '#39'insert PortionIngredientsFuture (portionid,i' +
        'ngredientcode,'#39
      
        '       + '#39'displayorder,quantity,unitname,portiontypeid,calculati' +
        'ontype,effectivedate,IncludeByDefault, IsMinor) '#39
      
        '       + '#39'select portionid,entitycode,displayorder,quantity,unit' +
        'name,portiontypeid,'#39
      
        '       + '#39'calculationtype,'#39#39#39' + @effectivedate + '#39#39#39', IncludeByD' +
        'efault, IsMinor from #tmpportioningredients'#39
      '     EXEC(@query2)'
      ''
      '   END'
      ''
      'COMMIT TRANSACTION'
      'END TRY'
      ''
      'BEGIN CATCH'
      ''
      '   IF @@TRANCOUNT > 0'
      '   ROLLBACK TRANSACTION'
      '   EXEC ac_spRethrowError'
      ''
      'END CATCH'
      '')
    Left = 102
    Top = 596
  end
  object dsPortions: TDataSource
    DataSet = qEditPortions
    Left = 246
    Top = 596
  end
  object qSavePurchaseUnits: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      
        '-- This is necessary to enable errors to be detected by the ADO ' +
        'component. Without this messages of the type'
      
        '-- "X rows were updated" are passed to the ADO component which (' +
        'due to a bug) then fails to detect any errors'
      '-- that also may have occurred. Bug 338652.'
      'SET NOCOUNT ON'
      ''
      'declare @EffectiveDate varchar(20)'
      'set @EffectiveDate = '#39'%s'#39
      ''
      'declare @EntityCode float'
      'set @EntityCode = %s'
      ''
      'declare @UserID bigint'
      'set @UserID = %d'
      ''
      'begin try'
      '  begin transaction'
      ''
      
        '  if exists(select * from #tmpPurchaseUnits where [Entity Code] ' +
        '<> @EntityCode)'
      
        '    raiserror('#39'##tmpPurchaseUnits has an unexpected [Entity Code' +
        ']'#39', 16, 1);'
      ''
      
        '  -- New purchase units created by down-arrowing off the bottom ' +
        'of the grid are created will a NULL [Entity Code].'
      
        '  -- Populate these with the correct entity code. Subsequent que' +
        'ries depend on this field being populated.'
      '  UPDATE #tmpPurchaseUnits'
      '  SET [Entity Code] = @EntityCode'
      '  WHERE [Entity Code] IS NULL'
      ''
      '  if @EffectiveDate <> '#39'Current'#39
      '  begin'
      
        '    -- Note: If [OriginalUnitCost] or [Unit Cost] columns of #tm' +
        'pPurchaseUnits are NULL in the case of a future cost change'
      
        '    -- then something has gone wrong. Hence the explicit exclusi' +
        'on of such records in this query. Should never happen...'
      '    MERGE PurchaseUnitsFuture AS target'
      '    USING'
      '      ('
      '      SELECT [Supplier Name], [Unit Name], Flavour, [Unit Cost]'
      '      FROM #tmpPurchaseUnits'
      
        '      WHERE [Unit Cost] <> [OriginalUnitCost] AND [OriginalUnitC' +
        'ost] IS NOT NULL AND [Unit Cost] IS NOT NULL'
      '      ) AS source'
      '    ON target.[Entity Code] = @EntityCode AND'
      '       target.[Supplier Name] = source.[Supplier Name] AND'
      '       target.[Unit Name] = source.[Unit Name] AND'
      
        '       ISNULL(target.[Flavour], '#39#39') = ISNULL(source.[Flavour], '#39 +
        #39') AND'
      '       target.[EffectiveDate] = @EffectiveDate'
      '    WHEN MATCHED THEN'
      
        '      UPDATE SET target.[Unit Cost] = source.[Unit Cost], target' +
        '.[UserId] = @UserID, target.LMDT = GetDate()'
      '    WHEN NOT MATCHED BY TARGET THEN'
      
        '      INSERT ([Entity Code], [Supplier Name], [Unit Name], Flavo' +
        'ur, [Unit Cost], EffectiveDate, UserID, LMDT)'
      
        '      VALUES (@EntityCode, source.[Supplier Name], source.[Unit ' +
        'Name], source.Flavour, source.[Unit Cost], @EffectiveDate, @User' +
        'ID, GETDATE());'
      ''
      ''
      
        '    -- Note: This query is only necessary for the '#39'Cancel'#39' butto' +
        'n which cancels all the future changes for one date. In this'
      
        '    -- case the #tmpPurchaseUnits is emptied by the '#39'Cancel'#39' but' +
        'ton, and this query will therefore delete all the rows'
      '    -- for the given product and date.'
      '    DELETE PurchaseUnitsFuture'
      '    WHERE [Entity Code] = @EntityCode'
      '      AND EffectiveDate = @EffectiveDate'
      '      AND NOT EXISTS'
      '        (SELECT * FROM #tmpPurchaseUnits'
      '         WHERE [Entity Code] = PurchaseUnitsFuture.[Entity Code]'
      
        '           AND [Supplier Name] = PurchaseUnitsFuture.[Supplier N' +
        'ame]'
      '           AND [Unit Name] = PurchaseUnitsFuture.[Unit Name]'
      
        '           AND ISNULL([Flavour], '#39#39') = ISNULL(PurchaseUnitsFutur' +
        'e.[Flavour], '#39#39'))'
      '  end'
      '  else'
      '  begin'
      '    DECLARE @Now datetime'
      '    SET @Now = GETDATE()'
      ''
      
        '    --Delete future changes that will be affected by edits to ke' +
        'y fields, but'
      
        '    --only delete those that have not yet been applied i.e. pres' +
        'erve the historic ones.'
      '    delete PurchaseUnitsFuture'
      '    from PurchaseUnitsFuture puf'
      '    left join #tmpPurchaseUnits tpu'
      '    on puf.[Supplier Name] = tpu.[Supplier Name]'
      '      and puf.[Unit Name] = tpu.[Unit Name]'
      '      and ISNULL(puf.Flavour, '#39#39') = ISNULL(tpu.Flavour, '#39#39')'
      '    where puf.[Entity code] = @EntityCode'
      '    and tpu.[Entity Code] is null'
      '    and (puf.EffectiveDate > GETDATE())'
      ''
      
        '    --Insert the records whose [Unit Cost] has changed into Purc' +
        'haseUnitsFuture for accountability'
      
        '    insert PurchaseUnitsFuture ([Entity Code], [Supplier Name],[' +
        'Unit Name], Flavour, [Unit Cost], EffectiveDate, UserID, LMDT)'
      
        '    select @EntityCode, tpu.[Supplier Name], tpu.[Unit Name], tp' +
        'u.Flavour, tpu.[Unit Cost], @Now, @UserID, @Now'
      '    from #tmpPurchaseUnits tpu'
      '    where [Unit Cost] <> [OriginalUnitCost]'
      
        '       OR [OriginalUnitCost] IS NULL -- This means it is a new r' +
        'ecord '
      ''
      
        '    -- Insert a *deactivation* record to show a given supplier/u' +
        'nit/flavour combo no longer used'
      '    -- from this date forward i.e. a user edited a *key* field'
      
        '    insert PurchaseUnitsFuture ([Entity Code], [Supplier Name],[' +
        'Unit Name],'
      
        '      Flavour, [Unit Cost], EffectiveDate, DeactivatedDate, User' +
        'ID, LMDT)'
      '    select pu.[Entity Code], pu.[Supplier Name], pu.[Unit Name],'
      '      pu.Flavour, pu.[Unit Cost], @Now, @Now, @UserID, @Now'
      '    from PurchaseUnits pu'
      '    left join #tmppurchaseunits tpu'
      '    on pu.[Entity code] = tpu.[entity Code]'
      '      and pu.[Supplier Name] = tpu.[Supplier Name]'
      '      and pu.[Unit Name] = tpu.[Unit Name]'
      '      and ISNULL(pu.Flavour, '#39#39') = ISNULL(tpu.Flavour, '#39#39')'
      
        '    where (tpu.[Entity Code] is null) and (pu.[Entity Code] = @E' +
        'ntityCode)'
      ''
      
        '    -- Replace the current purchase unit data with the new edits' +
        '.'
      '    MERGE PurchaseUnits AS target'
      '    USING'
      
        '      (SELECT * FROM #tmpPurchaseUnits WHERE [Unit Cost] IS NOT ' +
        'NULL) AS source --  If [Unit Cost] is null something has gone wr' +
        'ong. The UI is meant to disallow this.'
      '    ON target.[Entity Code] = source.[Entity Code] AND'
      '       target.[Supplier Name] = source.[Supplier Name] AND'
      '       target.[Unit Name] = source.[Unit Name] AND'
      
        '       ISNULL(target.[Flavour], '#39#39') = ISNULL(source.[Flavour], '#39 +
        #39')'
      '    WHEN MATCHED AND'
      '      (target.[Unit Cost] <> source.[Unit Cost] OR'
      
        '       ISNULL(target.[Barcode], '#39#39') <> ISNULL(source.[Barcode], ' +
        #39#39') OR'
      
        '       ISNULL(target.[Import/Export Reference]  COLLATE Latin1_G' +
        'eneral_CS_AS, '#39#39') <> ISNULL(source.[Import/Export Reference] COL' +
        'LATE Latin1_General_CS_AS, '#39#39') OR'
      
        '       ISNULL(target.[Default Flag], '#39#39') <> ISNULL(source.[Defau' +
        'lt Flag], '#39#39'))'
      '      THEN'
      '      UPDATE'
      '      SET target.[Unit Cost] = source.[Unit Cost],'
      '          target.[Barcode] = source.[Barcode],'
      
        '          target.[Import/Export Reference] = source.[Import/Expo' +
        'rt Reference],'
      '          target.[Default Flag] = source.[Default Flag],'
      '          target.LMDT = @now'
      '    WHEN NOT MATCHED BY TARGET THEN'
      
        '      INSERT ([Entity Code], [Supplier Name], [Unit Name], [Flav' +
        'our], [Import/Export Reference],'
      '              [Barcode],[Unit Cost], [Default Flag], [LMDT])'
      
        '      VALUES (source.[Entity Code], source.[Supplier Name], sour' +
        'ce.[Unit Name], source.Flavour, source.[Import/Export Reference]' +
        ','
      
        '              source.[Barcode], source.[Unit Cost], source.[Defa' +
        'ult Flag], @now)'
      
        '    WHEN NOT MATCHED BY SOURCE AND target.[Entity Code] = @Entit' +
        'yCode THEN'
      '      DELETE;'
      '  end'
      ''
      '  commit transaction'
      'end try'
      'begin catch'
      '  if @@TRANCOUNT > 0'
      '    rollback transaction'
      ''
      '  EXEC ac_spRethrowError'
      'end catch'
      '')
    Left = 723
    Top = 636
  end
  object qLoadPurchaseUnits: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'effectivedate'
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = 'entitycode'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @EffectiveDate varchar(20)'
      'set @EffectiveDate = :effectivedate'
      ''
      'declare @EntityCode float'
      'set @EntityCode = :entitycode'
      ''
      'delete from #tmpPurchaseUnits'
      ''
      'if @EffectiveDate <> '#39'Current'#39
      'begin'
      '  insert #tmpPurchaseUnits'
      
        '    ([Entity Code], [Supplier Name], [Unit Name], Flavour, [Impo' +
        'rt/Export Reference], Barcode,'
      '     [Unit Cost], [OriginalUnitCost], [Default Flag])'
      '  select'
      
        '     [Entity Code], [Supplier Name], [Unit Name], ISNULL(Flavour' +
        ', '#39#39'), [Import/Export Reference], Barcode,'
      '     [Unit Cost], [Unit Cost], [Default Flag]'
      '  from dbo.fn_ProductCostPrices(@EffectiveDate, @EntityCode)'
      'end'
      'else'
      'begin'
      '  insert #tmpPurchaseUnits'
      
        '    ([Entity Code], [Supplier Name], [Unit Name], Flavour, [Impo' +
        'rt/Export Reference], Barcode,'
      '     [Unit Cost], [OriginalUnitCost], [Default Flag])'
      '  select'
      
        '     [Entity Code], [Supplier Name], [Unit Name], ISNULL(Flavour' +
        ', '#39#39'), [Import/Export Reference], Barcode,'
      '     [Unit Cost], [Unit Cost], [Default Flag]'
      '  from PurchaseUnits'
      '  where [Entity Code] = @EntityCode'
      'end;')
    Left = 723
    Top = 592
  end
  object ScaleContainerTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'Deleted = 0'
    TableName = 'ThemeScaleContainer'
    Left = 612
    Top = 540
    object ScaleContainerTableContainerId: TIntegerField
      FieldName = 'ContainerId'
    end
    object ScaleContainerTableName: TStringField
      FieldName = 'Name'
    end
    object ScaleContainerTableDescription: TStringField
      FieldName = 'Description'
      Size = 250
    end
    object ScaleContainerTableTareWeight: TFloatField
      FieldName = 'TareWeight'
    end
  end
  object qEditContainers: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #tmpportions'
      'order by displayorder asc'
      '')
    Left = 611
    Top = 596
    object qEditContainersPortionName: TStringField
      DisplayLabel = 'Portion'
      DisplayWidth = 20
      FieldName = 'PortionName'
      Size = 50
    end
    object qEditContainersContainerName: TStringField
      DisplayLabel = 'Container'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'ContainerName'
      LookupDataSet = qScaleContainers
      LookupKeyFields = 'ContainerId'
      LookupResultField = 'Name'
      KeyFields = 'ContainerId'
      Lookup = True
    end
    object qEditContainersCookTime: TDateTimeField
      DisplayLabel = 'Cook Time'
      DisplayWidth = 18
      FieldName = 'CookTime'
      Visible = False
    end
    object qEditContainersDefaultCookTime: TBooleanField
      DisplayWidth = 5
      FieldName = 'DefaultCookTime'
      Visible = False
    end
    object qEditContainersContainerId: TIntegerField
      FieldName = 'ContainerId'
      Visible = False
    end
    object qEditContainersPortionid: TIntegerField
      FieldName = 'Portionid'
      Visible = False
    end
    object qEditContainersEntityCode: TFloatField
      FieldName = 'EntityCode'
      Visible = False
    end
    object qEditContainersPortionTypeId: TIntegerField
      FieldName = 'PortionTypeId'
      Visible = False
    end
    object qEditContainersDisplayOrder: TIntegerField
      FieldName = 'DisplayOrder'
      Visible = False
    end
  end
  object dsEditContainers: TDataSource
    DataSet = qEditContainers
    Left = 611
    Top = 640
  end
  object adoqProductHasChoices: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'TargetEntityCode'
        Size = -1
        Value = Null
      end
      item
        Name = 'IntegrateTempTables'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'declare @TargetEntityCode float'
      'set @TargetEntityCode = :TargetEntityCode'
      ''
      'declare @IntegrateTempTables bit'
      'set @IntegrateTempTables = :IntegrateTempTables'
      ''
      'declare @PortionsCopy table ('
      '  PortionID int not null,'
      '  EntityCode float null'
      '  primary key (PortionID)'
      ')'
      ''
      'declare @PortionIngredientsCopy table ('
      '  PortionID int not null,'
      '  IngredientCode float not null,'
      '  Displayorder tinyint not null'
      '  primary key (PortionID, IngredientCode, DisplayOrder)'
      ')'
      ''
      'insert @PortionsCopy'
      'select PortionID, EntityCode'
      'from Portions'
      ''
      'insert @PortionIngredientsCopy'
      'select PortionID, ingredientCode, DisplayOrder'
      'from PortionIngredients'
      ''
      'if @IntegrateTempTables = 1'
      'begin'
      '  declare @PortionTemp table ('
      '    portionid int,'
      '    entitycode float,'
      '    displayorder tinyint'
      '    primary key (PortionID)'
      '  )'
      ''
      '  declare @TmpPortionCrosstab table ('
      '    EntityCode float,'
      '    DisplayOrder int,'
      '    PortionID1 int,'
      '    PortionID2 int,'
      '    PortionID3 int,'
      '    PortionID4 int,'
      '    PortionID5 int,'
      '    PortionID6 int,'
      '    PortionID7 int,'
      '    PortionID8 int,'
      '    PortionID9 int,'
      '    PortionID10 int'
      '    primary key (EntityCode, DisplayOrder)'
      '  )'
      ''
      '  declare @TmpPortionIngredients table ('
      '    portionid int,'
      '    entitycode float,'
      '    displayorder tinyint'
      '    primary key (portionid,entitycode,displayorder)'
      '  )'
      ''
      '  --Add the temporary portions'
      '  delete from @PortionsCopy'
      '  where PortionID in (select PortionID from #tmpportions)'
      ''
      '  insert @PortionTemp'
      '  select portionid,@TargetEntityCode,displayorder'
      '  from #tmpportions'
      '  where not portionid is null'
      ''
      '  insert @PortionsCopy (PortionID, EntityCode)'
      '  select PortionID, EntityCode'
      '  from @PortionTemp'
      '  where not PortionID is null'
      '  --Add the temporary portions'
      ''
      '  --Add the temporary portioningredients'
      '  --The underlying tables require a refactor to make this better'
      '  insert @tmpportioncrosstab'
      
        '  select EntityCode float, DisplayOrder, PortionID1, PortionID2,' +
        ' PortionID3, PortionID4,'
      
        '    PortionID5, PortionID6, PortionID7, PortionID8, PortionID9, ' +
        'PortionID10'
      '  from #tmpportioncrosstab'
      ''
      '  update @tmpportioncrosstab'
      
        '  set portionid1 = (select portionid from @PortionTemp where dis' +
        'playorder = 1)'
      '  update @tmpportioncrosstab'
      
        '  set portionid2 = (select portionid from @PortionTemp where dis' +
        'playorder = 2)'
      '  update @tmpportioncrosstab'
      
        '  set portionid3 = (select portionid from @PortionTemp where dis' +
        'playorder = 3)'
      '  update @tmpportioncrosstab'
      
        '  set portionid4 = (select portionid from @PortionTemp where dis' +
        'playorder = 4)'
      '  update @tmpportioncrosstab'
      
        '  set portionid5 = (select portionid from @PortionTemp where dis' +
        'playorder = 5)'
      '  update @tmpportioncrosstab'
      
        '  set portionid6 = (select portionid from @PortionTemp where dis' +
        'playorder = 6)'
      '  update @tmpportioncrosstab'
      
        '  set portionid7 = (select portionid from @PortionTemp where dis' +
        'playorder = 7)'
      '  update @tmpportioncrosstab'
      
        '  set portionid8 = (select portionid from @PortionTemp where dis' +
        'playorder = 8)'
      '  update @tmpportioncrosstab'
      
        '  set portionid9 = (select portionid from @PortionTemp where dis' +
        'playorder = 9)'
      '  update @tmpportioncrosstab'
      
        '  set portionid10 = (select portionid from @PortionTemp where di' +
        'splayorder = 10)'
      ''
      
        '  --use the resinserted portionid to reverse the crosstab and ge' +
        't the portioningredients table back'
      '  insert into @TmpPortionIngredients'
      '  select portionid1,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid1 = pit.portionid'
      '  union'
      '  select portionid2,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid2 = pit.portionid'
      '  union'
      '  select portionid3,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid3 = pit.portionid'
      '  union'
      '  select portionid4,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid4 = pit.portionid'
      '  union'
      '  select portionid5,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid5 = pit.portionid'
      '  union'
      '  select portionid6,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid6 = pit.portionid'
      '  union'
      '  select portionid7,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid7 = pit.portionid'
      '  union'
      '  select portionid8,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid8 = pit.portionid'
      '  union'
      '  select portionid9,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid9 = pit.portionid'
      '  union'
      '  select portionid10,tp.entitycode,tp.displayorder'
      '  from @tmpportioncrosstab tp join @PortionTemp pit'
      '  on tp.portionid10 = pit.portionid'
      ''
      '  --Add to temporary portioningredients'
      '  delete @PortionIngredientsCopy'
      
        '  where PortionID in (select PortionID from @TmpPortionIngredien' +
        'ts)'
      ''
      
        '  insert @PortionIngredientsCopy (PortionID, IngredientCode, Dis' +
        'playorder)'
      '  select portionid, entitycode, displayorder'
      '  from @TmpPortionIngredients'
      'end;'
      ''
      'declare @Portions table (PortionId int)'
      'declare @Ingredients table (IngredientCode float)'
      'declare @UsedIngredients table (IngredientCode float)'
      ''
      'declare @HasChoices bit'
      'set @HasChoices = 0'
      ''
      'insert @Ingredients'
      'select distinct pic.IngredientCode'
      'from @PortionsCopy pc'
      'join @PortionIngredientsCopy pic'
      'on pc.PortionID = pic.PortionID'
      'where pc.EntityCode = @TargetEntityCode'
      ''
      'declare @Iterations int'
      'select @Iterations = 0'
      
        'while (@HasChoices = 0) and ((Select count(*) from @Ingredients)' +
        ' > 0)'
      'begin'
      '  select @Iterations = @Iterations + 1'
      ''
      '  select @HasChoices = case when count(*) > 0 then 1 else 0 end'
      '  from products p'
      '  join @Ingredients i'
      '  on i.IngredientCode = p.EntityCode'
      '  and p.[entity type] = '#39'Menu'#39
      ''
      '  insert into @UsedIngredients'
      '  select * from @Ingredients'
      ''
      '  delete @Portions'
      '  insert into @Portions'
      '    select distinct pc.PortionId from @PortionsCopy pc'
      '    join @Ingredients i on i.IngredientCode = pc.EntityCode'
      ''
      '  delete @Ingredients'
      '  insert into @Ingredients'
      '    select distinct pic.IngredientCode as IngredientCode'
      '    from @PortionIngredientsCopy pic'
      '    join @Portions po on po.portionid = pic.portionid'
      ''
      '  delete @Ingredients'
      
        '  where IngredientCode in (select IngredientCode from @UsedIngre' +
        'dients)'
      'end'
      ''
      'select @HasChoices as HasChoices')
    Left = 612
    Top = 352
  end
  object qScaleContainers: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select null as ContainerID, '#39'<no container>'#39' as Name'
      'union'
      'select ContainerID, Name from ThemeScaleContainer')
    Left = 615
    Top = 692
  end
  object qryProductBarcodeRanges: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = EntityDataSource
    Parameters = <
      item
        Name = 'EntityCode'
        DataType = ftFloat
        Precision = 19
        Value = 10000000011
      end>
    SQL.Strings = (
      
        'select p.EntityCode, r.BarcodeRangeID, r.Description, r.StartVal' +
        'ue, r.EndValue, '
      '       cast(case ISNULL(e.BarcodeRangeID,0) '
      '              when 0 then 0'
      '            else 1'
      '            end as bit) as HasExceptions'
      'from ProductBarcodeRange p '
      
        '  join ThemeBarcodeRange r on r.BarcodeRangeID = p.BarcodeRangeI' +
        'D'
      '  left outer join'
      '   (select BarcodeRangeID'
      '    from ThemeBarcodeException'
      '    group by BarcodeRangeID'
      '    having COUNT(*) > 0) e '
      '      on e.BarcodeRangeID = r.BarcodeRangeID'
      'where p.EntityCode = :EntityCode')
    Left = 152
    Top = 468
    object qryProductBarcodeRangesStartValue: TStringField
      DisplayWidth = 19
      FieldName = 'StartValue'
      ReadOnly = True
      Size = 23
    end
    object qryProductBarcodeRangesEndValue: TStringField
      DisplayWidth = 23
      FieldName = 'EndValue'
      ReadOnly = True
      Size = 23
    end
    object qryProductBarcodeRangesDescription: TStringField
      DisplayWidth = 13
      FieldName = 'Description'
      ReadOnly = True
      Visible = False
    end
    object qryProductBarcodeRangesEntityCode: TLargeintField
      FieldName = 'EntityCode'
      ReadOnly = True
      Visible = False
    end
    object qryProductBarcodeRangesBarcodeRangeID: TLargeintField
      FieldName = 'BarcodeRangeID'
      ReadOnly = True
      Visible = False
    end
    object qryProductBarcodeRangesHasExceptions: TBooleanField
      FieldName = 'HasExceptions'
      ReadOnly = True
      DisplayValues = 'Yes;No'
    end
  end
  object dsProductBarcodeRanges: TDataSource
    DataSet = qryProductBarcodeRanges
    Left = 152
    Top = 528
  end
  object dtsEditPortionChoices: TDataSource
    DataSet = qEditPortionChoices
    Left = 292
    Top = 528
  end
  object qEditPortionChoices: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = qEditPortionChoicesAfterPost
    Parameters = <>
    SQL.Strings = (
      'select * from #TmpPortionChoices')
    Left = 292
    Top = 476
  end
  object ADOQueryPConfigs: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 640
    Top = 152
  end
  object adoqRMControlled: TADOQuery
    Connection = adocRecipeModelling
    LockType = ltBatchOptimistic
    DataSource = EntityDataSource
    Parameters = <
      item
        Name = 'EntityCode'
        DataType = ftFloat
        Size = -1
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'select * from '
      'AztecProducts'
      'where AztecProductID = :EntityCode')
    Left = 720
    Top = 336
  end
  object adocRecipeModelling: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    Left = 720
    Top = 288
  end
  object adotRMControlled: TADOTable
    Connection = adocRecipeModelling
    TableName = 'AztecProducts'
    Left = 719
    Top = 384
  end
  object dsPortionPrices: TDataSource
    DataSet = PortionPricesTable
    Left = 264
    Top = 652
  end
  object qLoadPortionPrices: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'productId'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'ppgvPortionPrice'
        Size = -1
        Value = Null
      end
      item
        Name = 'ppgvGPAmount'
        Size = -1
        Value = Null
      end
      item
        Name = 'ppgvGPorCOSPercent'
        Size = -1
        Value = Null
      end
      item
        Name = 'PortionPriceModeText'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET NOCOUNT ON'
      ''
      
        'DECLARE @productId float, @ppgvPortionPrice tinyint, @ppgvGPAmou' +
        'nt tinyint, @ppgvGPorCOSPercent tinyint, @PortionPriceModeText v' +
        'archar(15)'
      'SET @productId = :productId'
      'SET @ppgvPortionPrice = :ppgvPortionPrice'
      'SET @ppgvGPAmount = :ppgvGPAmount'
      'SET @ppgvGPorCOSPercent = :ppgvGPorCOSPercent'
      'SET @portionPriceModeText = :portionPriceModeText'
      ''
      ''
      'TRUNCATE TABLE #TmpPricesCrosstab'
      ''
      'BEGIN TRY'
      '  BEGIN TRAN'
      ''
      
        '  INSERT #TmpPricesCrosstab (Type, Heading) VALUES (@ppgvPortion' +
        'Price, '#39'Current Band A Price '#39')'
      
        '  INSERT #TmpPricesCrosstab (Type, Heading) VALUES (@ppgvGPAmoun' +
        't, '#39'Gross Profit '#39')'
      
        '  INSERT #TmpPricesCrosstab (Type, Heading) VALUES (@ppgvGPorCOS' +
        'Percent, @portionPriceModeText + '#39' '#39')'
      ''
      ''
      
        '  IF OBJECT_ID('#39'tempdb..#PortionPrice'#39') <> 0 DROP TABLE #Portion' +
        'Price'
      ''
      '  SELECT PortionTypeID, Price'
      '  INTO #PortionPrice'
      '  FROM'
      '    ('
      '    SELECT PortionTypeID, Price,'
      
        '      ROW_NUMBER() OVER(PARTITION BY [PortionTypeId] ORDER BY St' +
        'artDate DESC) AS StartDateOrder'
      '    FROM PBandVal'
      
        '    WHERE MatrixId = (SELECT TOP 1 MatrixId FROM PriceMatrix WHE' +
        'RE Deleted = 0 ORDER BY MatrixID)'
      '      AND Band = '#39'A'#39
      '      AND ProductID = @productId'
      '      AND StartDate <= GETDATE()'
      '      AND Deleted = 0'
      '    ) x'
      '  WHERE StartDateOrder = 1'
      ''
      '  DECLARE PortionCursor CURSOR FOR'
      
        '  SELECT CONVERT(varchar(5), DisplayOrder) AS DisplayOrder, CONV' +
        'ERT(varchar(5), PortionTypeId) AS PortionTypeId'
      '  FROM #TmpPortions'
      '  WHERE EntityCode = @productId'
      '  ORDER BY DisplayOrder'
      ''
      '  DECLARE @displayOrder varchar(5), @portionTypeId varchar(5)'
      ''
      '  OPEN PortionCursor'
      
        '  FETCH NEXT FROM PortionCursor INTO @displayOrder, @portionType' +
        'Id'
      ''
      '  WHILE @@fetch_status = 0'
      '  BEGIN'
      '    EXEC'
      '    ('
      '      '#39'UPDATE #TmpPricesCrosstab'
      
        '       SET Value'#39' + @displayOrder + '#39' = (SELECT TOP 1 Price FROM' +
        ' #PortionPrice WHERE PortionTypeId = '#39' + @portionTypeId + '#39'),'
      
        '           OldValue'#39' + @displayOrder + '#39' = (SELECT TOP 1 Price F' +
        'ROM #PortionPrice WHERE PortionTypeId = '#39' + @portionTypeId + '#39')'
      '       WHERE Type = '#39' + @ppgvPortionPrice'
      '    )'
      
        '    FETCH NEXT FROM PortionCursor INTO @displayOrder, @portionTy' +
        'peId'
      '  END'
      '  CLOSE PortionCursor'
      '  DEALLOCATE PortionCursor'
      ''
      '  COMMIT TRAN'
      'END TRY'
      'BEGIN CATCH'
      '   IF @@trancount > 0 ROLLBACK TRAN'
      '   EXEC ac_spRethrowError'
      'END CATCH'
      '')
    Left = 24
    Top = 652
  end
  object qSavePortionPrices: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'productId'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'maxPortions'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end
      item
        Name = 'ppgtPortionPrice'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end
      item
        Name = 'userName'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET NOCOUNT ON'
      ''
      
        'DECLARE @productId float, @maxPortions tinyint, @portion tinyint' +
        ', @ppgtPortionPrice tinyint, @userName varchar(20)'
      ''
      'SET @productId = :productId'
      'SET @MaxPortions = :maxPortions'
      'SET @ppgtPortionPrice = :ppgtPortionPrice'
      'SET @userName = :userName'
      ''
      'BEGIN TRY'
      ''
      
        '  IF OBJECT_ID('#39'tempdb..#TmpPortionPrices'#39') IS NOT NULL DROP TAB' +
        'LE #TmpPortionPrices'
      '  CREATE TABLE #TmpPortionPrices ('
      '    DisplayOrder tinyint not null,'
      '    PortionTypeId smallint,'
      '    Price decimal(7,2),'
      '    ExistingPrice decimal(7,2))'
      ''
      '  SET @portion = 1'
      '  WHILE @portion <= @maxPortions'
      '  BEGIN'
      
        '    EXEC('#39'INSERT #TmpPortionPrices (DisplayOrder, Price, Existin' +
        'gPrice)'
      
        '          SELECT '#39' + @portion + '#39', Value'#39' + @portion + '#39', OldVal' +
        'ue'#39' + @portion + '#39' FROM #TmpPricesCrosstab WHERE Type = '#39' + @ppg' +
        'tPortionPrice)'
      '    SET @portion = @portion + 1'
      '  END'
      ''
      '  UPDATE #TmpPortionPrices'
      '  SET PortionTypeId = b.PortionTypeId'
      
        '  FROM #TmpPortionPrices a JOIN Portions b ON b.EntityCode = @pr' +
        'oductId AND b.DisplayOrder = a.DisplayOrder'
      ''
      
        '  -- RaiseError if any rows have non null Price but a null Porti' +
        'onTypeId.'
      '  DECLARE @missingDisplayOrder tinyint'
      
        '  SET @missingDisplayOrder = (SELECT TOP 1 DisplayOrder FROM #Tm' +
        'pPortionPrices WHERE Price IS NOT NULL AND PortionTypeID IS NULL' +
        ')'
      '  IF @missingDisplayOrder IS NOT NULL'
      '  BEGIN'
      '    DECLARE @ErrorMsg varchar(100)'
      
        '    SET @ErrorMsg = '#39'Cannot save prices because Portions record ' +
        'not found for EntityCode '#39' + LTRIM(STR(@productId, 20, 0)) +'
      
        '                    '#39' and DisplayOrder '#39' +  CONVERT(varchar(5), ' +
        '@MissingDisplayOrder)'
      '    RAISERROR(@ErrorMsg, 16, 1)'
      '  END'
      ''
      '  DECLARE @priceMatrix int'
      
        '  SET @priceMatrix = (SELECT TOP 1 MatrixId FROM PriceMatrix WHE' +
        'RE Deleted = 0 ORDER BY MatrixID)'
      ''
      '  MERGE PBandval AS target'
      '  USING'
      
        '    (SELECT @priceMatrix, @productId, PortionTypeId, '#39'A'#39', dbo.fn' +
        '_DateFromDateTime(GetDate()), Price'
      '     FROM #TmpPortionPrices'
      
        '     WHERE ISNULL(Price, 0) <> ISNULL(ExistingPrice, 0)) AS sour' +
        'ce (MatrixId, ProductId, PortionTypeId, Band, StartDate, Price)'
      '  ON target.MatrixId = source.MatrixId AND'
      '     target.ProductId = source.ProductId AND'
      '     target.PortionTypeId = source.PortionTypeId AND'
      '     target.Band = source.Band AND'
      '     target.StartDate = source.StartDate'
      '  WHEN MATCHED THEN'
      
        '    UPDATE SET Price = source.Price, Deleted = 0, LMDT = GetDate' +
        '(), ModifiedBy = LEFT(@userName, 16)+'#39'(PM)'#39
      '  WHEN NOT MATCHED THEN'
      
        '    INSERT (MatrixId, ProductId, PortionTypeId, Band, StartDate,' +
        ' Price, LMDT, ModifiedBy)'
      
        '    VALUES (source.MatrixId, source.ProductId, source.PortionTyp' +
        'eId, source.Band, source.StartDate, source.Price,'
      '            GetDate(), LEFT(@userName, 16)+'#39'(PM)'#39');'
      'END TRY'
      'BEGIN CATCH'
      '  EXEC ac_spRethrowError'
      'END CATCH')
    Left = 102
    Top = 668
  end
  object PortionPricesTable: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = '#TmpPricesCrosstab'
    CommandType = cmdTable
    IndexFieldNames = '[Type]'
    Parameters = <>
    Left = 168
    Top = 652
  end
  object adotProductCostPrice: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    IndexFieldNames = 'EntityCode'
    MasterFields = 'EntityCode'
    MasterSource = EntityDataSource
    TableName = 'ProductCostPriceMode'
    Left = 720
    Top = 432
    object adotProductCostPriceEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object adotProductCostPriceCostPriceMode: TWordField
      FieldName = 'CostPriceMode'
    end
  end
  object adoqGiftCardTypes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeProductGiftCardLookup'
      'order by Id')
    Left = 391
    Top = 12
  end
  object ProductPropertiesTable: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = 'SELECT * FROM ProductProperties'
    Parameters = <>
    Left = 48
    Top = 160
    object ProductPropertiesTableEntityCode: TFloatField
      FieldName = 'EntityCode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ProductPropertiesTableIsAdmission: TBooleanField
      FieldName = 'IsAdmission'
    end
    object ProductPropertiesTableValidateMembership: TBooleanField
      FieldName = 'ValidateMembership'
    end
    object ProductPropertiesTableIsFootfall: TBooleanField
      FieldName = 'IsFootfall'
    end
    object ProductPropertiesTableIsDonation: TBooleanField
      FieldName = 'IsDonation'
    end
    object ProductPropertiesTablePromptForGiftAid: TBooleanField
      FieldName = 'PromptForGiftAid'
    end
    object ProductPropertiesTableCountryOfOrigin: TStringField
      FieldName = 'CountryOfOrigin'
      Size = 100
    end
  end
  object PPTableProvider: TDataSetProvider
    DataSet = ProductPropertiesTable
    Constraints = True
    ResolveToDataSet = True
    Options = [poFetchDetailsOnDemand, poAllowMultiRecordUpdates]
    UpdateMode = upWhereKeyOnly
    Left = 136
    Top = 176
  end
  object ClientPPTable: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    DisableStringTrim = True
    Params = <>
    ProviderName = 'PPTableProvider'
    AfterScroll = ClientPPTableAfterScroll
    OnPostError = ClientPPTablePostError
    OnReconcileError = ClientPPTableReconcileError
    Left = 32
    Top = 216
    object ClientPPTableEntityCode: TFloatField
      FieldName = 'EntityCode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ClientPPTableIsAdmission: TBooleanField
      FieldName = 'IsAdmission'
    end
    object ClientPPTableValidateMembership: TBooleanField
      FieldName = 'ValidateMembership'
    end
    object ClientPPTableIsFootfall: TBooleanField
      FieldName = 'IsFootfall'
    end
    object ClientPPTableIsDonation: TBooleanField
      FieldName = 'IsDonation'
    end
    object ClientPPTablePromptForGiftAid: TBooleanField
      FieldName = 'PromptForGiftAid'
    end
    object ClientPPTableCountryOfOrigin: TStringField
      FieldName = 'CountryOfOrigin'
      Size = 100
    end
  end
  object PPDataSource: TDataSource
    DataSet = ClientPPTable
    Left = 112
    Top = 232
  end
end
