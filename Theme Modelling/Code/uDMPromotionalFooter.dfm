object dmPromotionalFooter: TdmPromotionalFooter
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 356
  Top = 240
  Height = 387
  Width = 792
  object qPromotionalFooter: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from PromotionalFooter')
    Left = 36
    Top = 8
    object qPromotionalFooterName: TStringField
      DisplayWidth = 35
      FieldName = 'Name'
      Size = 40
    end
    object qPromotionalFooterDescription: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Size = 256
    end
    object qPromotionalFooterStatusLookup: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'StatusLookup'
      LookupDataSet = qFooterStatus
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'Status'
      Size = 10
      Lookup = True
    end
    object qPromotionalFooterStartDate: TDateTimeField
      DisplayLabel = 'Start Date'
      DisplayWidth = 10
      FieldName = 'StartDate'
    end
    object qPromotionalFooterEndDate: TDateTimeField
      DisplayLabel = 'End Date'
      DisplayWidth = 10
      FieldName = 'EndDate'
    end
    object qPromotionalFooterId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
      Visible = False
    end
    object qPromotionalFooterPriority: TIntegerField
      DisplayWidth = 10
      FieldName = 'Priority'
      Visible = False
    end
    object qPromotionalFooterSeparateFromReceipt: TBooleanField
      DisplayWidth = 5
      FieldName = 'SeparateFromReceipt'
      Visible = False
    end
    object qPromotionalFooterPrintFrequency: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrintFrequency'
      Visible = False
    end
    object qPromotionalFooterStatus: TIntegerField
      FieldName = 'Status'
      Visible = False
    end
    object qPromotionalFooterBarcode: TStringField
      FieldName = 'Barcode'
      Visible = False
      Size = 25
    end
    object qPromotionalFooterPrintMultipleFooters: TBooleanField
      FieldName = 'PrintMultipleFooters'
    end
    object qPromotionalFooterPrintWithSlipType: TIntegerField
      FieldName = 'PrintWithSlipType'
    end
    object qPromotionalFooterCampaignID: TIntegerField
      FieldName = 'CampaignID'
    end
  end
  object dsPromotionalFooter: TDataSource
    AutoEdit = False
    DataSet = qPromotionalFooter
    Left = 35
    Top = 56
  end
  object qFooterStatus: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select Id, Name from PromotionalFooterStatus')
    Left = 35
    Top = 104
    object qFooterStatusId: TIntegerField
      FieldName = 'Id'
    end
    object qFooterStatusName: TStringField
      FieldName = 'Name'
      Size = 10
    end
  end
  object qEditFooterSaleGroups: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select PromotionalFooterID, SaleGroupID, SaleGroupType, Value, P' +
        'roductGroupingId'
      'from #PromotionalFooterSaleGroup'
      'order by SaleGroupID')
    Left = 144
    Top = 7
    object qEditFooterSaleGroupsSaleGroupId: TSmallintField
      Alignment = taLeftJustify
      DisplayLabel = 'Sale Group ID'
      DisplayWidth = 69
      FieldName = 'SaleGroupId'
    end
    object qEditFooterSaleGroupsSaleGrouptypeLookup: TStringField
      DisplayLabel = 'Sale Group Type'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'SaleGrouptypeLookup'
      LookupDataSet = qFooterSaleGroupType
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'SaleGroupType'
      Size = 15
      Lookup = True
    end
    object qEditFooterSaleGroupsValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Value'
      DisplayFormat = '0.##'
      EditFormat = '0.00'
      MaxValue = 9999.99
    end
    object qEditFooterSaleGroupsProductGroupingId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductGroupingId'
      Visible = False
    end
    object qEditFooterSaleGroupsPromotionalFooterId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PromotionalFooterId'
      Visible = False
    end
    object qEditFooterSaleGroupsSaleGroupType: TWordField
      DisplayWidth = 10
      FieldName = 'SaleGroupType'
      Visible = False
    end
  end
  object dsEditFooterSaleGroups: TDataSource
    DataSet = qEditFooterSaleGroups
    Left = 144
    Top = 55
  end
  object dsFooterText: TDataSource
    DataSet = qFooterText
    Left = 36
    Top = 200
  end
  object qFooterText: TADOQuery
    Connection = dmThemeData.AztecConn
    BeforeInsert = qFooterTextBeforeInsert
    BeforePost = qFooterTextBeforePost
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM #PromotionalFooterText')
    Left = 36
    Top = 152
    object qFooterTextLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 4
      FieldName = 'LineNumber'
      ReadOnly = True
    end
    object qFooterTextText: TWideStringField
      Alignment = taCenter
      DisplayWidth = 67
      FieldName = 'Text'
      OnValidate = qFooterTextTextValidate
      Size = 40
    end
    object qFooterTextBold: TBooleanField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object qFooterTextDoubleSize: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 9
      FieldName = 'DoubleSize'
      OnValidate = qFooterTextDoubleSizeValidate
    end
    object qFooterTextAppendSurveyCode: TBooleanField
      DisplayLabel = 'Append~Survey~Code'
      DisplayWidth = 8
      FieldName = 'AppendSurveyCode'
      Visible = False
      OnValidate = qFooterTextAppendSurveyCodeValidate
    end
    object qFooterTextAppendVoucherCode: TBooleanField
      FieldName = 'AppendVoucherCode'
      OnValidate = qFooterTextAppendVoucherCodeValidate
    end
  end
  object qFooterSaleGroupType: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from PromotionalFooterSaleGroupType')
    Left = 144
    Top = 104
  end
  object DataSource1: TDataSource
    Left = 144
    Top = 152
  end
  object qProcessSaleGroupDetail: TADOQuery
    Connection = dmThemeData.AztecConn
    Parameters = <>
    SQL.Strings = (
      'declare @salegroupid int'
      'set @SaleGroupId = %salegroupid%'
      ''
      '--Delete the prvious entries for the sale group.'
      'delete from #PromotionalFooterSaleGroupDetail'
      'where SaleGroupId = @SaleGroupId'
      ''
      '--Extract the portions that need to be included'
      
        'insert #PromotionalFooterSaleGroupDetail (SaleGroupId, GroupingT' +
        'ype, GroupingTypeTargetId)'
      'select @SaleGroupId, 4, a.level5id from'
      '[%temptable%] a'
      'join'
      '  (Select sub2.level4id from'
      
        '   (select level4id, count(level5id) as count1 from [%temptable%' +
        ']'
      '    group by level4id) sub1'
      '   join'
      
        '   (select level4id, count(level5id) as count2 from [##ProductTr' +
        'ee_Data]'
      '    group by level4id) sub2'
      '   on sub1.Level4id = sub2.level4id'
      '   where count1 < count2) sub3'
      'on a.Level4Id = sub3.level4id'
      ''
      'delete from [%temptable%]'
      'where level5id in (select GroupingTypeTargetId'
      '                   from #PromotionalFooterSaleGroupDetail'
      '                   where GroupingType = 4'
      '                   and SaleGroupID = @SaleGroupId)'
      ''
      '--Extract the products that need to be included'
      
        'insert #PromotionalFooterSaleGroupDetail (SaleGroupId, GroupingT' +
        'ype, GroupingTypeTargetId)'
      'select distinct @SaleGroupId, 3, a.level4id'
      'from [%temptable%] a'
      'join '
      '  (Select sub2.level3id from'
      '   (select level3id, count(level4id) as count1 from'
      
        '    (select distinct level, level1id, level2id, level3id, level4' +
        'id'
      '     from [%temptable%]) sub'
      '    group by level3id) sub1'
      '   join'
      '   (select level3id, count(level4id) as count2 from'
      '    (select distinct level1id, level2id, level3id, level4id'
      '     from [##ProductTree_Data]) sub4'
      '    group by level3id) sub2'
      '   on sub1.Level3id = sub2.level3id'
      '   where count1 < count2) sub3'
      'on a.Level3Id = sub3.level3id'
      ''
      'delete from [%temptable%]'
      'where level4id in (select GroupingTypeTargetId'
      '                   from #PromotionalFooterSaleGroupDetail'
      '                   where GroupingType = 3'
      '                   and SaleGroupID = @SaleGroupId)'
      ''
      '--Extract the sub-cats that need to be included'
      
        'insert #PromotionalFooterSaleGroupDetail (SaleGroupId, GroupingT' +
        'ype, GroupingTypeTargetId)'
      'select distinct @SaleGroupId, 2, a.level3id'
      'from [%temptable%] a'
      'join'
      '  (Select sub2.level2id from'
      '   (select level2id, count(level3id) as count1 from'
      '    (select distinct level, level1id, level2id, level3id'
      '     from [%temptable%]) sub'
      '    group by level2id) sub1'
      '   join '
      '   (select level2id, count(level3id) as count2 from'
      '    (select distinct level1id, level2id, level3id'
      '     from [##ProductTree_Data]) sub4'
      '    group by level2id) sub2'
      '   on sub1.Level2id = sub2.level2id'
      '   where count1 < count2) sub3'
      'on a.Level2Id = sub3.level2id'
      ''
      'delete from [%temptable%]'
      'where level3id in (select GroupingTypeTargetId'
      '                   from #PromotionalFooterSaleGroupDetail'
      '                   where GroupingType = 2'
      '                   and SaleGroupID = @SaleGroupId)'
      ''
      '--Extract the cats that need to be included                   '
      
        'insert #PromotionalFooterSaleGroupDetail (SaleGroupId, GroupingT' +
        'ype, GroupingTypeTargetId)'
      'select distinct @SaleGroupID, 1, a.level2id'
      'from [%temptable%] a'
      'join '
      '  (Select sub2.level1id from'
      '   (select level1id, count(level2id) as count1 from'
      '    (select distinct level, level1id, level2id'
      '     from [%temptable%]) sub'
      '    group by level1id) sub1'
      '   join'
      '   (select level1id, count(level2id) as count2 from'
      '    (select distinct level1id, level2id'
      '     from [##ProductTree_Data]) sub4'
      '    group by level1id) sub2'
      '   on sub1.Level1id = sub2.level1id'
      '   where count1 < count2) sub3'
      'on a.Level1Id = sub3.level1id'
      ''
      'delete from [%temptable%]'
      'where level2id in (select GroupingTypeTargetId'
      '                   from #PromotionalFooterSaleGroupDetail'
      '                   where GroupingType = 1'
      '                   and SaleGroupID = @SaleGroupId)'
      '                   '
      
        '-- If there is anything else left in the temp table then the who' +
        'le division was selected'
      
        'insert #PromotionalFooterSaleGroupDetail (SaleGroupId, GroupingT' +
        'ype, GroupingTypeTargetId)'
      'select distinct @SaleGroupId, 0, a.level1id'
      'from [%temptable%] a')
    Left = 144
    Top = 200
  end
  object qProductBarcodes: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Extended RTL Name], [Barcode],'
      '  case len([Barcode])'
      '    when 12 then CAST(1 AS BIT)'
      '  ELSE'
      '    CAST(0 AS BIT)'
      '  END AS CanSelect'
      'from Products p'
      'join ProductBarcode pb'
      'on p.EntityCode = pb.EntityCode'
      'where (p.Deleted is null or p.deleted = '#39'N'#39')')
    Left = 248
    Top = 7
    object qProductBarcodesExtendedRTLName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 60
      FieldName = 'Extended RTL Name'
      Size = 16
    end
    object qProductBarcodesBarcode: TStringField
      DisplayWidth = 32
      FieldName = 'Barcode'
      Size = 25
    end
    object qProductBarcodesCanSelect: TBooleanField
      FieldName = 'CanSelect'
      ReadOnly = True
    end
  end
  object dsProductBarcodes: TDataSource
    DataSet = qProductBarcodes
    Left = 249
    Top = 55
  end
  object qEditPromotionalFooter: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #PromotionalFooter')
    Left = 252
    Top = 104
    object qEditPromotionalFooterId: TIntegerField
      FieldName = 'Id'
    end
    object qEditPromotionalFooterName: TStringField
      FieldName = 'Name'
      Size = 40
    end
    object qEditPromotionalFooterDescription: TStringField
      FieldName = 'Description'
      Size = 256
    end
    object qEditPromotionalFooterPriority: TIntegerField
      FieldName = 'Priority'
    end
    object qEditPromotionalFooterSeparateFromReceipt: TBooleanField
      FieldName = 'SeparateFromReceipt'
    end
    object qEditPromotionalFooterPrintFrequency: TIntegerField
      FieldName = 'PrintFrequency'
    end
    object qEditPromotionalFooterStatus: TIntegerField
      FieldName = 'Status'
    end
    object qEditPromotionalFooterStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qEditPromotionalFooterEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object qEditPromotionalFooterBarcode: TStringField
      FieldName = 'Barcode'
      Size = 25
    end
    object qEditPromotionalFooterEPoSNotificationText: TStringField
      FieldName = 'EPoSNotificationText'
      Size = 256
    end
    object qEditPromotionalFooterPrintMultipleFooters: TBooleanField
      FieldName = 'PrintMultipleFooters'
    end
    object qEditPromotionalFooterCampaignID: TIntegerField
      FieldName = 'CampaignID'
    end
    object qEditPromotionalFooterPrintWithSlipType: TIntegerField
      FieldName = 'PrintWithSlipType'
      OnChange = qEditPromotionalFooterPrintWithSlipTypeChange
    end
    object qEditPromotionalFooterPrintVoucherCode: TBooleanField
      FieldName = 'PrintVoucherCode'
    end
  end
  object dsEditPromotionalFooter: TDataSource
    DataSet = qEditPromotionalFooter
    Left = 252
    Top = 152
  end
  object qPromotions: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select p.PromotionID, p.Name, p.Description, p.Status, pt.Promot' +
        'ionalFooterId, pf.Name as PromotionalFooterName'
      'from Promotion p'
      '--left join PromotionalFooterPromotionTriggers pt'
      'left join #PromotionalFooterPromotionTriggers pt'
      'on p.PromotionID = pt.PromotionID'
      'left join PromotionalFooter pf'
      'on pt.PromotionalFooterID = pf.ID'
      'where pt.PromotionID is null'
      'and p.SiteCode = 0')
    Left = 375
    Top = 7
    object qPromotionsPromotionID: TIntegerField
      FieldName = 'PromotionID'
    end
    object qPromotionsName: TStringField
      FieldName = 'Name'
      Size = 25
    end
    object qPromotionsDescription: TStringField
      FieldName = 'Description'
      Size = 256
    end
    object qPromotionsPromotionalFooterID: TIntegerField
      FieldName = 'PromotionalFooterID'
    end
    object qPromotionsStatus: TIntegerField
      FieldName = 'Status'
    end
    object qPromotionsPromotionalFooterName: TStringField
      FieldName = 'PromotionalFooterName'
      Size = 40
    end
  end
  object dsPromotions: TDataSource
    DataSet = qPromotions
    Left = 375
    Top = 55
  end
  object qSiteFooterOverride: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select SiteCode, OverrideID, OverrideName'
      'from #SitePromotionalFooterOverride')
    Left = 376
    Top = 104
    object qSiteFooterOverrideOverrideName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 70
      FieldName = 'OverrideName'
      Size = 40
    end
    object qSiteFooterOverrideOverrideID: TIntegerField
      DisplayLabel = 'Override'
      DisplayWidth = 10
      FieldName = 'OverrideID'
      Visible = False
    end
    object qSiteFooterOverrideSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
  end
  object dsSiteFooterOverride: TDataSource
    DataSet = qSiteFooterOverride
    Left = 376
    Top = 148
  end
  object qSiteFooterTextOverride: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'OverrideID'
        DataType = ftInteger
        Value = 1
      end>
    SQL.Strings = (
      
        'select OverrideID, LineNumber, Text, Bold, DoubleSize, AppendSur' +
        'veyCode, AppendVoucherCode'
      'from #SitePromotionalFooterTextOverride'
      'where OverrideID = :OverrideID')
    Left = 488
    Top = 4
    object qSiteFooterTextOverrideOverrideID: TIntegerField
      FieldName = 'OverrideID'
    end
    object qSiteFooterTextOverrideLineNumber: TSmallintField
      FieldName = 'LineNumber'
    end
    object qSiteFooterTextOverrideText: TWideStringField
      Alignment = taCenter
      FieldName = 'Text'
      OnValidate = qSiteFooterTextOverrideTextValidate
      Size = 40
    end
    object qSiteFooterTextOverrideBold: TBooleanField
      FieldName = 'Bold'
    end
    object qSiteFooterTextOverrideDoubleSize: TBooleanField
      FieldName = 'DoubleSize'
      OnValidate = qSiteFooterTextOverrideDoubleSizeValidate
    end
    object qSiteFooterTextOverrideAppendSurveyCode: TBooleanField
      FieldName = 'AppendSurveyCode'
      OnValidate = qSiteFooterTextOverrideAppendSurveyCodeValidate
    end
    object qSiteFooterTextOverrideAppendVoucherCode: TBooleanField
      FieldName = 'AppendVoucherCode'
      OnValidate = qSiteFooterTextOverrideAppendVoucherCodeValidate
    end
  end
  object dsSiteFooterTextOverride: TDataSource
    DataSet = qSiteFooterTextOverride
    Left = 488
    Top = 52
  end
  object qFootersWithOverrides: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterScroll = qFootersWithOverridesAfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT PromotionalFooterId, FooterName'
      'FROM #SiteFootersWithOverrides'
      'ORDER BY FooterName')
    Left = 488
    Top = 104
    object qFootersWithOverridesFooterName: TStringField
      DisplayLabel = 'Footer'
      DisplayWidth = 40
      FieldName = 'FooterName'
      Size = 40
    end
    object qFootersWithOverridesPromotionalFooterId: TIntegerField
      FieldName = 'PromotionalFooterId'
      Visible = False
    end
  end
  object qFooterOverrides: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'DECLARE @PromotionalFooterID int'
      'SET @PromotionalFooterID = 1'
      'SELECT PromotionalFooterID, OverrideID, OverrideName'
      'FROM #SiteFooterOverrides'
      'WHERE PromotionalFooterID = @PromotionalFooterID')
    Left = 612
    Top = 4
    object qFooterOverridesOverrideName: TStringField
      DisplayWidth = 40
      FieldName = 'OverrideName'
      Size = 40
    end
    object qFooterOverridesPromotionalFooterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PromotionalFooterID'
      Visible = False
    end
    object qFooterOverridesOverrideID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OverrideID'
      Visible = False
    end
  end
  object dsFootersWithOverrides: TDataSource
    DataSet = qFootersWithOverrides
    Left = 488
    Top = 148
  end
  object qSalesAreaFooterOverride: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    DataSource = dsFootersWithOverrides
    Parameters = <
      item
        Name = 'promotionalFooterID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'SELECT [PromotionalFooterID], [SalesAreaID], [OverrideID],'
      '  [SalesAreaName]'
      'FROM #SalesAreaOverrideMappings'
      'WHERE PromotionalFooterID = :promotionalFooterID')
    Left = 612
    Top = 52
    object qSalesAreaFooterOverrideSalesAreaName: TStringField
      DisplayWidth = 20
      FieldName = 'SalesAreaName'
    end
    object qSalesAreaFooterOverrideOverrideName: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'OverrideName'
      LookupDataSet = qFooterOverrides
      LookupKeyFields = 'OverrideID'
      LookupResultField = 'OverrideName'
      KeyFields = 'OverrideID'
      Size = 40
      Lookup = True
    end
    object qSalesAreaFooterOverridePromotionalFooterID: TIntegerField
      FieldName = 'PromotionalFooterID'
      Visible = False
    end
    object qSalesAreaFooterOverrideSalesAreaID: TIntegerField
      FieldName = 'SalesAreaID'
      Visible = False
    end
    object qSalesAreaFooterOverrideOverrideID: TIntegerField
      FieldName = 'OverrideID'
      Visible = False
    end
  end
  object dsSalesAreaFooterOverride: TDataSource
    DataSet = qSalesAreaFooterOverride
    Left = 612
    Top = 104
  end
  object qCanOverridePromotionalFooter: TADOQuery
    Connection = dmThemeData.AztecConn
    DataSource = dsPromotionalFooter
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM PromotionalFooterSalesArea'
      'WHERE PromotionalFooterID = :ID'
      'AND AllowSiteFooterOverride = 1'
      '')
    Left = 80
    Top = 272
  end
  object qAllOverrideSalesAreas: TADOQuery
    Connection = dmThemeData.AztecConn
    DataSource = dsPromotionalFooter
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT f.ID'
      'FROM PromotionalFooterSalesArea s'
      '  join PromotionalFooter f on f.ID = s.PromotionalFooterID'
      'WHERE s.AllowSiteFooterOverride = 1'
      'AND f.[Status] = 0')
    Left = 224
    Top = 256
  end
  object qSlipType: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeSlipTypeLookup')
    Left = 488
    Top = 196
    object qSlipTypevalue: TStringField
      DisplayWidth = 10
      FieldName = 'value'
      OnGetText = qSlipTypevalueGetText
      Size = 50
    end
    object qSlipTypeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
      Visible = False
    end
  end
  object dsSlipType: TDataSource
    DataSet = qSlipType
    Left = 488
    Top = 244
  end
end
