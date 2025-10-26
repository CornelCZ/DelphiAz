inherited dmPromotions: TdmPromotions
  OldCreateOrder = True
  Left = 666
  Top = 91
  Height = 834
  Width = 491
  inherited adoqRun: TADOQuery
    SQL.Strings = ()
  end
  inherited AztecConn: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Password=0049356GNHsxkzi26TYMF;Persist Secu' +
      'rity Info=True;User ID=zonalsysadmin;Initial Catalog=Aztec;Data ' +
      'Source=localhost'
    Provider = 'SQLNCLI11.1'
  end
  inherited AztecConnSysAdmin: TADOConnection
    Left = 48
    Top = 80
  end
  object qPromotions: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    OnCalcFields = qPromotionsCalcFields
    Parameters = <
      item
        Name = 'Sitecode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @sitecode bigint'
      'set @sitecode = :sitecode'
      ''
      
        'select case p.SiteCode when 0 then '#39'Head Office'#39' else s.Name end' +
        ' as CreatedAt, p.Name, p.Description,'
      
        '  case when (ExtendedFlag = 1 and p.PromoTypeID = 3) THEN ('#39'Enh.' +
        ' '#39' + PromoTypeName) ELSE PromoTypeName end as PromoTypeName, Eve' +
        'ntOnly,  '
      '  PromotionStatus.Name AS PromoStatus, p.UserSelectsProducts,'
      
        '  case p.PromoTypeID when 4 then null else StartDate end as Star' +
        'tDate, EndDate, p.PromoTypeID, Status, p.PromotionID,'
      '  SingleRewardPrice, p.SiteCode, p.ExtendedFlag'
      'from Promotion p'
      'join PromoType on p.PromoTypeID = PromoType.PromoTypeID'
      'join PromotionStatus on p.Status = PromotionStatus.StatusID'
      'left join ac_Site s on s.ID = p.SiteCode'
      'join (select distinct p.PromotionID'
      
        '      from Promotion p join PromotionSalesArea psa on psa.Promot' +
        'ionID = p.PromotionID'
      '      join ac_SalesArea sa on sa.ID = psa.SalesAreaID'
      '      where sa.SiteID = @SiteCode or @SiteCode = 0) sub'
      'on p.PromotionID = sub.PromotionID'
      'order by 1 asc, 2 asc, 3 asc, 4 asc, 5 asc, 6 asc, 7 asc'
      ''
      ''
      '')
    Left = 48
    Top = 136
    object qPromotionsCreatedAt: TStringField
      DisplayLabel = 'Created By'
      DisplayWidth = 20
      FieldName = 'CreatedAt'
      ReadOnly = True
    end
    object qPromotionsName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 25
    end
    object qPromotionsDescription: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Size = 256
    end
    object qPromotionsPromoTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 11
      FieldName = 'PromoTypeName'
      Size = 50
    end
    object qPromotionsEventOnly: TBooleanField
      DisplayLabel = 'Evt. Only'
      DisplayWidth = 8
      FieldName = 'EventOnly'
    end
    object qPromotionsUserSelectsProducts: TBooleanField
      DisplayLabel = 'Deal'
      DisplayWidth = 4
      FieldName = 'UserSelectsProducts'
    end
    object qPromotionsPromotionStatusLookup: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PromotionStatusLookup'
      LookupDataSet = qPromotionStatus
      LookupKeyFields = 'StatusID'
      LookupResultField = 'Name'
      KeyFields = 'Status'
      Size = 10
      Lookup = True
    end
    object qPromotionsStartDate: TDateTimeField
      DisplayLabel = 'Start Date'
      DisplayWidth = 10
      FieldName = 'StartDate'
    end
    object qPromotionsEndDate: TDateTimeField
      DisplayLabel = 'End Date'
      DisplayWidth = 10
      FieldName = 'EndDate'
    end
    object qPromotionsPromoTypeID: TSmallintField
      DisplayWidth = 10
      FieldName = 'PromoTypeID'
      Visible = False
    end
    object qPromotionsStatus: TIntegerField
      DisplayWidth = 10
      FieldName = 'Status'
      Visible = False
    end
    object qPromotionsSingleRewardPrice: TBCDField
      DisplayWidth = 20
      FieldName = 'SingleRewardPrice'
      Visible = False
      Precision = 19
    end
    object qPromotionsSiteCode: TIntegerField
      FieldName = 'SiteCode'
      Visible = False
    end
    object qPromotionsCreatedOnThisSite: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'CreatedOnThisSite'
      Visible = False
      Calculated = True
    end
    object qPromotionsExtendedFlag: TBooleanField
      FieldName = 'ExtendedFlag'
      Visible = False
    end
    object qPromotionsPromotionID: TLargeintField
      FieldName = 'PromotionID'
      Visible = False
    end
  end
  object dsPromotions: TDataSource
    DataSet = qPromotions
    Left = 120
    Top = 136
  end
  object qPromotionTypes: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT PromoTypeID, PromoTypeName FROM PromoType')
    Left = 48
    Top = 192
  end
  object qPromotionStatus: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT StatusID, Name FROM PromotionStatus')
    Left = 48
    Top = 240
  end
  object qEditPromotionGroups: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    AfterPost = qEditPromotionGroupsAfterScroll
    AfterScroll = qEditPromotionGroupsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from #PromotionSaleGroup'
      'order by SaleGroupID')
    Left = 224
    Top = 80
    object qEditPromotionGroupsSaleGroupID: TSmallintField
      DisplayWidth = 10
      FieldName = 'SaleGroupID'
    end
    object qEditPromotionGroupsQuantity: TIntegerField
      DisplayWidth = 10
      FieldName = 'Quantity'
    end
    object qEditPromotionGroupsRecipeChildrenMode: TSmallintField
      DisplayLabel = 'Recipe Children Mode'
      DisplayWidth = 38
      FieldName = 'RecipeChildrenMode'
      OnChange = qEditPromotionGroupsRecipeChildrenModeChange
    end
    object qEditPromotionGroupsMakeChildrenFree: TBooleanField
      DisplayLabel = 'Make Children Free'
      DisplayWidth = 16
      FieldName = 'MakeChildrenFree'
    end
    object qEditPromotionGroupsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Visible = False
      Size = 30
    end
    object qEditPromotionGroupsSiteCode: TIntegerField
      DisplayWidth = 10
      FieldName = 'SiteCode'
      Visible = False
    end
    object qEditPromotionGroupsPromotionID: TLargeintField
      DisplayWidth = 25
      FieldName = 'PromotionID'
      Visible = False
    end
    object qEditPromotionGroupsCalculationType: TSmallintField
      DisplayWidth = 10
      FieldName = 'CalculationType'
      Visible = False
    end
    object qEditPromotionGroupsCalculationValue: TFloatField
      DisplayWidth = 10
      FieldName = 'CalculationValue'
      Visible = False
    end
    object qEditPromotionGroupsCalculationBand: TStringField
      DisplayWidth = 2
      FieldName = 'CalculationBand'
      Visible = False
      Size = 2
    end
    object qEditPromotionGroupsRememberCalculation: TBooleanField
      DisplayWidth = 5
      FieldName = 'RememberCalculation'
      Visible = False
    end
  end
  object qEditPromotionExceptions: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.Name, a.Description, b.Name, a.ExceptionID, a.Promotion' +
        'ID, a.StartDate, a.EndDate, a.Status, ChangeEndDate'
      'from #PromotionException a'
      '  join PromotionStatus b on a.Status = b.StatusID')
    Left = 224
    Top = 176
  end
  object dsEditPromotionGroups: TDataSource
    DataSet = qEditPromotionGroups
    Left = 224
    Top = 128
  end
  object dsEditPromotionExceptions: TDataSource
    DataSet = qEditPromotionExceptions
    Left = 224
    Top = 224
  end
  object qEditSalesAreaRewardPrice: TADOQuery
    Connection = AztecConn
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'select a.*'
      'from #PromotionSalesAreaRewardPrice a'
      'join #SiteSaNames b on a.SalesAreaID = b.SalesAreaID'
      'order by SiteRef, SalesAreaName')
    Left = 224
    Top = 272
    object qEditSalesAreaRewardPricePromotionID: TLargeintField
      DisplayWidth = 10
      FieldName = 'PromotionID'
      Visible = False
    end
    object qEditSalesAreaRewardPriceSalesAreaID: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalesAreaID'
      Visible = False
    end
    object qEditSalesAreaRewardPriceSiteRef: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'SiteRef'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SiteRef'
      KeyFields = 'SalesAreaID'
      Size = 10
      Lookup = True
    end
    object qEditSalesAreaRewardPriceSiteName: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SiteName'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SiteName'
      KeyFields = 'SalesAreaID'
      Lookup = True
    end
    object qEditSalesAreaRewardPriceSalesAreaName: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SalesAreaName'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SalesAreaName'
      KeyFields = 'SalesAreaID'
      Lookup = True
    end
    object qEditSalesAreaRewardPriceRewardPrice: TBCDField
      DisplayWidth = 20
      FieldName = 'RewardPrice'
      DisplayFormat = '####0.00'
      Precision = 19
    end
  end
  object dsEditSalesAreaRewardPrice: TDataSource
    DataSet = qEditSalesAreaRewardPrice
    Left = 224
    Top = 320
  end
  object qSiteSANames: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      ' '
      'select * from #SiteSANames')
    Left = 48
    Top = 336
  end
  object qUsedBands: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select distinct band, len(band) from pbandval'
      'where deleted = 0 '
      'order by 2, 1'
      ''
      '/*select distinct currentband as Band, len(currentband)'
      'from SABands'
      
        'where currentband is not null and len(currentband) between 1 and' +
        ' 2'
      'order by 2, 1*/')
    Left = 48
    Top = 384
  end
  object qEditPromoPrice: TADOQuery
    Tag = 6
    AutoCalcFields = False
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 224
    Top = 368
    object qEditPromoPricePromotionID: TLargeintField
      DisplayWidth = 10
      FieldName = 'PromotionID'
    end
    object qEditPromoPriceSaleGroupID: TSmallintField
      DisplayLabel = 'Grp'
      DisplayWidth = 3
      FieldName = 'SaleGroupID'
    end
    object qEditPromoPriceProductID: TLargeintField
      DisplayWidth = 15
      FieldName = 'ProductID'
      Visible = False
    end
    object qEditPromoPricePortionTypeID: TSmallintField
      DisplayWidth = 10
      FieldName = 'PortionTypeID'
      Visible = False
    end
    object qEditPromoPriceSalesAreaCode: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalesAreaID'
      Visible = False
    end
    object qEditPromoPriceTariffPrice: TBCDField
      DisplayLabel = 'Tariff'
      DisplayWidth = 8
      FieldName = 'TariffPrice'
      DisplayFormat = '####0.00'
      Precision = 19
    end
    object qEditPromoPricePrice: TBCDField
      DisplayWidth = 8
      FieldName = 'Price'
      DisplayFormat = '####0.00'
      Precision = 19
    end
    object qEditPromoPriceStringField: TStringField
      DisplayLabel = 'S.Ref.'
      DisplayWidth = 6
      FieldKind = fkLookup
      FieldName = 'SiteRef'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SiteRef'
      KeyFields = 'SalesAreaID'
      Size = 10
      Lookup = True
    end
    object qEditPromoPriceStringField2: TStringField
      DisplayLabel = 'Site Name'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'SiteName'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SiteName'
      KeyFields = 'SalesAreaID'
      Lookup = True
    end
    object qEditPromoPriceStringField3: TStringField
      DisplayLabel = 'Sales Area Name'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'SalesAreaName'
      LookupDataSet = qSiteSANames
      LookupKeyFields = 'SalesAreaID'
      LookupResultField = 'SalesAreaName'
      KeyFields = 'SalesAreaID'
      Lookup = True
    end
    object qEditPromoPriceProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'ProductName'
      LookupDataSet = qProductNames
      LookupKeyFields = 'ProductID'
      LookupResultField = 'ProductName'
      KeyFields = 'ProductID'
      Size = 16
      Lookup = True
    end
    object qEditPromoPriceProductDescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'ProductDescription'
      LookupDataSet = qProductNames
      LookupKeyFields = 'ProductID'
      LookupResultField = 'ProductDescription'
      KeyFields = 'ProductID'
      Size = 40
      Lookup = True
    end
    object qEditPromoPricePortionTypeName: TStringField
      DisplayLabel = 'Portion'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PortionTypeName'
      LookupDataSet = qPortionNames
      LookupKeyFields = 'PortionTypeID'
      LookupResultField = 'PortionTypeName'
      KeyFields = 'PortionTypeID'
      Size = 16
      Lookup = True
    end
  end
  object dsEditPromoPrice: TDataSource
    Tag = 6
    DataSet = qEditPromoPrice
    Left = 224
    Top = 416
  end
  object qPortionNames: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select PortionTypeID, PortionTypeName from portiontype')
    Left = 48
    Top = 432
  end
  object qProductNames: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select cast(entitycode as bigint) as ProductID, [Extended Rtl Na' +
        'me] as ProductName, [Retail Description] as ProductDescription'
      'from Products')
    Left = 48
    Top = 480
  end
  object qEditSingleRewardPrice: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select SingleRewardPrice '
      'from #Promotion')
    Left = 368
    Top = 56
    object qEditSingleRewardPriceSingleRewardPrice: TBCDField
      FieldName = 'SingleRewardPrice'
      DisplayFormat = '####0.00'
      Precision = 19
    end
  end
  object dsEditSingleRewardPrice: TDataSource
    DataSet = qEditSingleRewardPrice
    Left = 368
    Top = 112
  end
  object dsTempExceptionOverlap: TDataSource
    DataSet = qTempExceptionOverlap
    Left = 368
    Top = 208
  end
  object qTempExceptionOverlap: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <
      item
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        '-- Note: This SQL is never executed. It is always replaced at ru' +
        'ntime before the dataset is opened.'
      
        '-- I suspect this SQL is only here so that the TField components' +
        ' could be created at design time. GDM'
      
        'SELECT SANames.SiteName, SANames.SalesAreaName, SANames.SiteRef,' +
        ' PromotionID, sub.SalesAreaID,'
      '  '
      
        '  CASE StartDateDefined WHEN 0 THEN '#39#39' WHEN 1 THEN '#39#39' ELSE '#39'Star' +
        't Date, '#39' END +'
      
        '  CASE EndDateDefined WHEN 0 THEN '#39#39' WHEN 1 THEN '#39#39' ELSE '#39'End Da' +
        'te, '#39' END +'
      
        '  CASE TimeCycleDefined WHEN 0 THEN '#39#39' WHEN 1 THEN '#39#39' ELSE '#39'Time' +
        's/Days, '#39' END as OverlapData,'
      '  0 AS ActionID'
      '--INTO ##Overlap'
      'FROM ('
      '  SELECT a.PromotionID, b.SalesAreaID,'
      
        '    SUM(CASE IsNull(StartDate, 0) WHEN 0 THEN 0 ELSE 1 END) AS S' +
        'tartDateDefined,'
      
        '    SUM(CASE ChangeEndDate WHEN 1 THEN 1 ELSE 0 END) AS EndDateD' +
        'efined,'
      
        '    SUM(CASE IsNull(TimeCycleID, 0) WHEN 0 THEN 0 ELSE 1 END) AS' +
        ' TimeCycleDefined'
      '  FROM PromotionException a'
      '  JOIN PromotionExceptionSalesArea b ON'
      '    a.ExceptionID = b.ExceptionID'
      '  WHERE Status = 0'
      '  GROUP BY SalesAreaID, PromotionID'
      ') SUB'
      'JOIN ('
      '  SELECT DISTINCT'
      '    CAST(config.[Sales Area Code] AS SMALLINT) AS SalesAreaID,'
      '    siteaztec.[Site Ref] AS SiteRef,'
      '    siteaztec.[Site Name] AS SiteName,'
      '    config.[Sales Area Name] AS SalesAreaName'
      '  FROM config'
      '  join siteaztec ON config.[site code] = siteaztec.[site code]'
      '  WHERE (config.deleted IS NULL OR config.deleted = '#39'N'#39')'
      '     AND config.[Sales Area Code] IS NOT NULL'
      ') SANames ON Sub.SalesAreaID = SANames.SalesAreaID'
      
        'WHERE StartDateDefined>1 or EndDateDefined>1 or TimeCycleDefined' +
        '>1')
    Left = 368
    Top = 160
    object qTempExceptionOverlapSiteName: TStringField
      DisplayLabel = 'Site Name'
      DisplayWidth = 16
      FieldName = 'SiteName'
    end
    object qTempExceptionOverlapSalesAreaName: TStringField
      DisplayLabel = 'Sales Area Name'
      DisplayWidth = 16
      FieldName = 'SalesAreaName'
    end
    object qTempExceptionOverlapSiteRef: TStringField
      DisplayLabel = 'Site Ref'
      DisplayWidth = 6
      FieldName = 'SiteRef'
      Size = 10
    end
    object qTempExceptionOverlapOverlapData: TStringField
      DisplayLabel = 'Overlap Data'
      DisplayWidth = 27
      FieldName = 'OverlapData'
      ReadOnly = True
      Size = 34
    end
    object qTempExceptionOverlapActionType: TStringField
      DisplayLabel = 'Action'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'ActionType'
      LookupDataSet = qTempExceptionOverlapAction
      LookupKeyFields = 'ActionID'
      LookupResultField = 'ActionName'
      KeyFields = 'ActionID'
      Lookup = True
    end
    object qTempExceptionOverlapActionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ActionID'
      Visible = False
    end
    object qTempExceptionOverlapSalesAreaID: TSmallintField
      FieldName = 'SalesAreaID'
      Visible = False
    end
  end
  object qTempExceptionOverlapAction: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    DataSource = dsTempExceptionOverlap
    Parameters = <>
    SQL.Strings = (
      
        'select top 0 0 as ActionID, '#39'Delete from existing exception'#39' as ' +
        'ActionName'
      'into #OverlapAction'
      ''
      'insert #OverlapAction '
      'select 0, '#39'Keep'#39' '
      'insert #OverlapAction'
      'select 1, '#39'Remove'#39
      ''
      'select ActionID, ActionName from #OverlapAction'
      ''
      'drop table #OverlapAction')
    Left = 368
    Top = 256
  end
  object qEditEventStatus: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* if OBJECT_ID('#39'tempdb..#TmpPromotionEventStatus'#39') is not null ' +
        'drop table #TmpPromotionEventStatus'
      'select a.PromotionID, a.Name, a.Description, b.PromoTypeName,'
      
        '  cast(case a.Status when 0 then 1 else 0 end as bit) as Enabled' +
        ','
      
        '  cast(case IsNull(c.EnabledPromotionID, -1) when -1 then 0 else' +
        ' 1 end as bit) as Activate '
      'into #TmpPromotionEventStatus '
      'from Promotion a '
      'join PromoType b on a.PromoTypeID = b.PromoTypeID '
      
        'left outer join PromotionEventStatus c on a.PromotionID = c.Enab' +
        'ledPromotionID '
      'where a.PromoTypeID <> 4 */'
      ''
      'select * from #TmpPromotionEventStatus'
      '')
    Left = 224
    Top = 472
    object qEditEventStatusName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      ReadOnly = True
      Size = 25
    end
    object qEditEventStatusDescription: TStringField
      DisplayWidth = 31
      FieldName = 'Description'
      ReadOnly = True
      Size = 256
    end
    object qEditEventStatusPromoTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'PromoTypeName'
      ReadOnly = True
      Size = 50
    end
    object qEditEventStatusEnabled: TBooleanField
      DisplayWidth = 7
      FieldName = 'Enabled'
      ReadOnly = True
    end
    object qEditEventStatusActivate: TBooleanField
      DisplayLabel = 'Active'
      DisplayWidth = 7
      FieldName = 'Activate'
    end
    object qEditEventStatusPromotionID: TLargeintField
      FieldName = 'PromotionID'
      Visible = False
    end
    object qEditEventStatusSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
  end
  object dsEditEventStatus: TDataSource
    Tag = 6
    DataSet = qEditEventStatus
    Left = 228
    Top = 520
  end
  object qGetSiteSANames: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'create table #SiteSANames ('
      'SalesAreaID int not null,'
      'SiteRef varchar(50) null,'
      'SiteName varchar(50) not null,'
      'SalesAreaName varchar(50) not null'
      'primary key (SalesAreaID)'
      ')'
      'insert #SiteSANames'
      
        'select sa.Id as SalesAreaID, s.Reference as SiteRef, s.Name as S' +
        'iteName, sa.Name as SalesAreaName'
      'from ac_SalesArea sa join ac_Site s on sa.SiteId = s.Id'
      'where sa.Deleted = 0')
    Left = 48
    Top = 288
  end
  object qFixPriorities: TADOQuery
    Connection = AztecConn
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @SiteCode int'
      'set @SiteCode = :SiteCode'
      ''
      'declare @TemplateID int'
      
        'select @TemplateID = PriorityTemplateId from ac_SitePriorityTemp' +
        'late where SiteId = @SiteCode'
      ''
      
        'while EXISTS(select pto.Priority from ac_PromotionPriorityTempla' +
        'teOrder pto '
      #9#9'join Promotion p on pto.PromotionId = p.PromotionId '
      #9#9'where p.SiteCode = @SiteCode'
      #9#9'  and pto.TemplateId = @TemplateID '
      #9#9'group by pto.Priority '
      #9#9'having count(*) > 1)'
      
        '  update ac_PromotionPriorityTemplateOrder set Priority = Priori' +
        'ty + 1'
      '  from ac_PromotionPriorityTemplateOrder'
      '  join ('
      
        '    select top 1 Priority as DupPriority, min(p.PromotionID) as ' +
        'MinID '
      #9'from ac_PromotionPriorityTemplateOrder pto'
      #9'join Promotion p'
      #9'on pto.PromotionId = p.PromotionId'
      #9'where p.SiteCode = @SiteCode'
      #9'  and pto.TemplateId = @TemplateID'
      '    group by Priority'
      '    having count(*) > 1'
      '  ) CandidateDuplicates'
      
        '  on ac_PromotionPriorityTemplateOrder.Priority >= DupPriority a' +
        'nd ac_PromotionPriorityTemplateOrder.PromotionID <> MinID'
      '  where TemplateID = @TemplateID')
    Left = 368
    Top = 304
  end
  object qEditPromoPortionPriceMapping: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select pppm.SiteCode, pppm.PromotionID, pppm.SaleGroupId, Source' +
        'PortionTypeId, TargetPortionTypeId, '
      'pppm.CalculationType, pppm.CalculationValue'
      'from #PromotionPortionPriceMapping pppm'
      'join #PromotionSaleGroup psg'
      
        'on pppm.PromotionID = psg.PromotionId and pppm.SaleGroupId = psg' +
        '.SaleGroupId'
      'where psg.CalculationType between 1 and 4'
      
        'order by pppm.SaleGroupId, pppm.SourcePortionTypeId, pppm.Target' +
        'PortionTypeId')
    Left = 368
    Top = 360
    object qEditPromoPortionPriceMappingSaleGroupId: TSmallintField
      Alignment = taLeftJustify
      DisplayLabel = 'Sales Group'
      DisplayWidth = 18
      FieldName = 'SaleGroupId'
    end
    object qEditPromoPortionPriceMappingSourcePortionTypeLookup: TStringField
      DisplayLabel = 'Source Portion'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SourcePortionTypeLookup'
      LookupDataSet = qPortionNames
      LookupKeyFields = 'PortionTypeID'
      LookupResultField = 'PortionTypeName'
      KeyFields = 'SourcePortionTypeId'
      Lookup = True
    end
    object qEditPromoPortionPriceMappingTargetPortionTypeLookup: TStringField
      DisplayLabel = 'Target Portion'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'TargetPortionTypeLookup'
      LookupDataSet = qPortionNames
      LookupKeyFields = 'PortionTypeID'
      LookupResultField = 'PortionTypeName'
      KeyFields = 'TargetPortionTypeId'
      Lookup = True
    end
    object qEditPromoPortionPriceMappingCalculationTypeLookup: TStringField
      DisplayLabel = 'Calculation Type'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'CalculationTypeLookup'
      LookupDataSet = qPromoCalcType
      LookupKeyFields = 'PromoCalcTypeId'
      LookupResultField = 'PromoCalcDesc'
      KeyFields = 'CalculationType'
      Lookup = True
    end
    object qEditPromoPortionPriceMappingSourcePortionTypeId: TSmallintField
      DisplayLabel = 'Source Portion'
      DisplayWidth = 20
      FieldName = 'SourcePortionTypeId'
      Visible = False
    end
    object qEditPromoPortionPriceMappingTargetPortionTypeId: TSmallintField
      DisplayLabel = 'Target Portion'
      DisplayWidth = 20
      FieldName = 'TargetPortionTypeId'
      Visible = False
    end
    object qEditPromoPortionPriceMappingCalculationType: TSmallintField
      DisplayLabel = 'Calculation Type'
      DisplayWidth = 10
      FieldName = 'CalculationType'
      Visible = False
    end
    object qEditPromoPortionPriceMappingPromotionID: TLargeintField
      FieldName = 'PromotionID'
      Visible = False
    end
    object qEditPromoPortionPriceMappingCalculationValue: TFloatField
      DisplayLabel = 'Calculation Value'
      FieldName = 'CalculationValue'
      OnGetText = qEditPromoPortionPriceMappingCalculationValueGetText
      OnSetText = qEditPromoPortionPriceMappingCalculationValueSetText
      Precision = 3
    end
    object qEditPromoPortionPriceMappingSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
  end
  object dsEditPromoPortionPriceMapping: TDataSource
    DataSet = qEditPromoPortionPriceMapping
    Left = 368
    Top = 416
  end
  object qPromoCalcType: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select PromoCalcTypeId, PromoCalcDesc from PromoCalcType'
      'where PromoCalcTypeId <> 5')
    Left = 48
    Top = 528
  end
  object qSiteNameLookup: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select 0 as ID, '#39'Head Office'#39' as SiteName'
      'union'
      'select Id, Name from ac_site')
    Left = 48
    Top = 580
    object qSiteNameLookupId: TIntegerField
      FieldName = 'Id'
    end
    object qSiteNameLookupSiteName: TStringField
      FieldName = 'SiteName'
    end
  end
  object qPromotionPriorityTemplate: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select id, Name '
      'from ac_PromotionPriorityTemplate'
      'where Deleted = 0')
    Left = 368
    Top = 480
    object qPromotionPriorityTemplateName: TStringField
      DisplayWidth = 50
      FieldName = 'Name'
      Size = 50
    end
    object qPromotionPriorityTemplateId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
  end
  object qSitePriorityTemplate: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
      'select s.Id as SiteId, IsNull(s.Reference, '''') as Reference, s.Name as SiteName,  a.Name ' +
      'as AreaName, c.Name as CompanyName, PriorityTemplateId'
      'from ac_Site s '
      'join ac_SitePriorityTemplate spt'
      'on s.Id = spt.SiteId'
      'join ac_Area a'
      'on s.AreaId  = a.Id'
      'join ac_Company c'
      'on a.CompanyId = c.Id'
      
        'join (select distinct Level3Id as SiteID from ##ConfigTree_Data)' +
        ' ctd'
      'on s.Id = ctd.SiteID'
      'order by s.Reference asc')
    Left = 368
    Top = 592
    object qSitePriorityTemplateReference: TStringField
      DisplayWidth = 10
      FieldName = 'Reference'
      Size = 10
    end
    object qSitePriorityTemplateSiteName: TStringField
      DisplayLabel = 'Site Name'
      DisplayWidth = 20
      FieldName = 'SiteName'
    end
    object qSitePriorityTemplateTemplateName: TStringField
      DisplayLabel = 'Template Name'
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'TemplateName'
      LookupDataSet = qPromotionPriorityTemplate
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'PriorityTemplateId'
      Size = 50
      Lookup = True
    end
    object qSitePriorityTemplatePriorityTemplateId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PriorityTemplateId'
      Visible = False
    end
    object qSitePriorityTemplateSiteId: TIntegerField
      DisplayLabel = 'Site Id'
      DisplayWidth = 10
      FieldName = 'SiteId'
      Visible = False
    end
    object qSitePriorityTemplateAreaName: TStringField
      DisplayWidth = 20
      FieldName = 'AreaName'
      Visible = False
    end
    object qSitePriorityTemplateCompanyName: TStringField
      DisplayWidth = 20
      FieldName = 'CompanyName'
      Visible = False
    end
  end
  object dsPromotionPriorityTemplate: TDataSource
    DataSet = qPromotionPriorityTemplate
    Left = 368
    Top = 536
  end
  object dsSitePriorityTemplate: TDataSource
    DataSet = qSitePriorityTemplate
    Left = 368
    Top = 648
  end
  object cmdAddMissingSitesDefaultTemplates: TADOCommand
    CommandText = 
      'insert ac_SitePriorityTemplate (SiteID, PriorityTemplateId)'#13#10#9'se' +
      'lect s.ID as SiteID, COALESCE(pt.PriorityTemplateId, 1) as Prior' +
      'ityTemplateID'#13#10#9'from ac_site s'#13#10#9'left join ac_SitePriorityTempla' +
      'te pt'#13#10#9'on s.Id = pt.SiteId '#13#10#9'where pt.PriorityTemplateID is nu' +
      'll'
    Connection = AztecConn
    Parameters = <>
    Left = 232
    Top = 696
  end
  object qTempPriorityTemplate: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select Id, Name, AutoPriorityModeId'
      'from #PriorityTemplate')
    Left = 232
    Top = 584
    object qTempPriorityTemplateId: TIntegerField
      FieldName = 'Id'
    end
    object qTempPriorityTemplateName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qTempPriorityTemplateAutoPriorityModeId: TIntegerField
      FieldName = 'AutoPriorityModeId'
    end
  end
  object dsTempPriorityTemplate: TDataSource
    DataSet = qTempPriorityTemplate
    Left = 232
    Top = 640
  end
  object cmdAddMissingPromotionPriorities: TADOCommand
    CommandText = 
      '-- update ac_PromotionPriorityTemplateOrder to add Promotions ad' +
      'ded since templates last updated'#13#10#13#10'-- first add entries for eac' +
      'h new promotion with a dummy (-1) priority'#13#10'insert ac_PromotionP' +
      'riorityTemplateOrder (PromotionId, TemplateID, Priority)'#13#10'select' +
      ' sub.PromotionID, sub.TemplateID, sub.Priority'#13#10'from (select p.P' +
      'romotionID, @TemplateID as TemplateID, COALESCE(o.Priority, -1) ' +
      'as Priority'#13#10#9'from Promotion p'#13#10#9'left join ac_PromotionPriorityT' +
      'emplateOrder o'#13#10#9'on p.PromotionId = o.PromotionId'#13#10#9'and o.Templa' +
      'teId = @TemplateID) sub'#13#10'where sub.Priority = -1;'#13#10#13#10'-- then use' +
      ' a variable to update priority values, using the current highest' +
      ' + 1 as a starting point'#13#10'-- note hacky looking SET @Priority = ' +
      'Priority = @Priority + 1  syntax to update both the variable and' +
      ' column '#13#10'-- at the same time'#13#10'DECLARE @priority INT;'#13#10'select @p' +
      'riority = max(Priority) from ac_PromotionPriorityTemplateOrder w' +
      'here TemplateID = @TemplateID;'#13#10#13#10'UPDATE ac_PromotionPriorityTem' +
      'plateOrder'#13#10'SET @Priority = Priority = @Priority + 1 '#13#10'where Tem' +
      'plateID = @TemplateID and Priority = -1'#13#10'OPTION ( MAXDOP 1 )'
    Connection = AztecConn
    Prepared = True
    Parameters = <>
    Left = 368
    Top = 712
  end
  object dsViewDeleted: TwwDataSource
    DataSet = tViewDeleted
    Left = 48
    Top = 696
  end
  object tViewDeleted: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    TableName = 'Promotion_DelPromos'
    Left = 48
    Top = 648
  end
end
