inherited dmThemeData: TdmThemeData
  OldCreateOrder = True
  Left = 671
  Top = 4
  Height = 737
  Width = 737
  inherited adocRun: TADOCommand
    Left = 88
    Top = 8
  end
  inherited adoqRun: TADOQuery
    Left = 144
    Top = 8
  end
  inherited adoTRun: TADOTable
    Left = 200
    Top = 8
  end
  inherited AztecConn: TADOConnection
    Provider = 'SQLOLEDB.1'
    Top = 4
  end
  inherited AztecConnSysAdmin: TADOConnection
    Top = 56
  end
  object qThemes: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    AfterOpen = qThemesAfterOpen
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from theme'
      'order by name')
    Left = 32
    Top = 104
    object qThemesThemeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ThemeId'
    end
    object qThemesName: TStringField
      DisplayWidth = 50
      FieldName = 'Name'
      Size = 50
    end
    object qThemesDescription: TStringField
      DisplayWidth = 255
      FieldName = 'Description'
      Size = 255
    end
    object qThemesIdleTime: TIntegerField
      DisplayWidth = 10
      FieldName = 'IdleTime'
    end
  end
  object dsThemes: TDataSource
    DataSet = qThemes
    Left = 112
    Top = 88
  end
  object qPanelDesigns: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsThemes
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'select * from themepaneldesign where themeid = :themeid'
      'order by name')
    Left = 32
    Top = 152
    object qPanelDesignsPanelDesignID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PanelDesignID'
    end
    object qPanelDesignsThemeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ThemeId'
    end
    object qPanelDesignsPanelDesignType: TWordField
      DisplayWidth = 10
      FieldName = 'PanelDesignType'
    end
    object qPanelDesignsName: TStringField
      DisplayWidth = 50
      FieldName = 'Name'
      Size = 50
    end
    object qPanelDesignsDescription: TStringField
      DisplayWidth = 255
      FieldName = 'Description'
      Size = 255
    end
    object qPanelDesignsRoot: TLargeintField
      DisplayWidth = 15
      FieldName = 'Root'
    end
    object qPanelDesignsCorrectAccount: TLargeintField
      DisplayWidth = 15
      FieldName = 'CorrectAccount'
    end
    object qPanelDesignsPay: TLargeintField
      DisplayWidth = 15
      FieldName = 'Pay'
    end
    object qPanelDesignsDesignType: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'DesignType'
      LookupDataSet = qPanelDesignType
      LookupKeyFields = 'PanelDesignTypeID'
      LookupResultField = 'DisplayName'
      KeyFields = 'PanelDesignType'
      LookupCache = True
      Size = 50
      Lookup = True
    end
    object qPanelDesignsDefaultPay: TLargeintField
      FieldName = 'DefaultPay'
    end
    object qPanelDesignsScreenInterfaceID: TSmallintField
      FieldName = 'ScreenInterfaceID'
    end
  end
  object dsPanelDesigns: TDataSource
    DataSet = qPanelDesigns
    Left = 112
    Top = 136
  end
  object qPanelDesignType: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select DISTINCT PanelDesignTypeID, DisplayName from'
      'themepaneldesigntype')
    Left = 200
    Top = 56
  end
  object qThemeTablePlans: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsThemes
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'select * from themetableplan where themeid = :themeid'
      'order by name')
    Left = 32
    Top = 200
  end
  object dsThemeTablePlans: TDataSource
    DataSet = qThemeTablePlans
    Left = 112
    Top = 184
  end
  object qOutlets: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'select [Site Code] as SiteCode, [Site Ref] as ReferenceCode, [Si' +
        'te Name] as Name'
      'from siteaztec'
      'where deleted is null or deleted = '#39'N'#39
      'order by Name')
    Left = 32
    Top = 248
    object qOutletsSiteCode: TSmallintField
      DisplayWidth = 10
      FieldName = 'SiteCode'
    end
    object qOutletsReferenceCode: TStringField
      DisplayWidth = 10
      FieldName = 'ReferenceCode'
      Size = 10
    end
    object qOutletsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
    end
  end
  object dsOutlets: TDataSource
    DataSet = qOutlets
    Left = 112
    Top = 232
  end
  object qOutletTablePlans: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsOutlets
    Parameters = <
      item
        Name = 'sitecode'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 10
        Value = 5002
      end>
    SQL.Strings = (
      'select * from ThemeOutletTablePlan where sitecode = :sitecode'
      'order by name')
    Left = 32
    Top = 296
  end
  object dsOutletTablePlans: TDataSource
    DataSet = qOutletTablePlans
    Left = 112
    Top = 280
  end
  object qSharedPanels: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsOutlets
    Parameters = <>
    SQL.Strings = (
      
        'select distinct themepanel.*, case isnull(themepanelvariation.pa' +
        'nelid, -1) when -1 then cast(0 as bit) else cast(1 as bit) end a' +
        's VariationGroup'
      'from themepanel'
      
        'left outer join themepanelvariation on themepanel.panelid = them' +
        'epanelvariation.panelid'
      'where themepanel.paneltype = 2'
      'order by themepanel.name')
    Left = 32
    Top = 344
  end
  object dsSharedPanels: TDataSource
    DataSet = qSharedPanels
    Left = 128
    Top = 328
  end
  object qSitesInTheme: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsThemes
    Parameters = <
      item
        Name = 'ThemeID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT S.[Site Code] , S.[Site Name]'
      'FROM ThemeSites T'
      'JOIN  SiteAztec S on S.[Site Code] = T.sitecode'
      'WHERE ThemeId = :ThemeId'
      'and s.deleted is null or s.deleted = '#39'N'#39)
    Left = 296
    Top = 8
    object qSitesInThemeSiteCode: TSmallintField
      FieldName = 'Site Code'
    end
    object qSitesInThemeSiteName: TStringField
      FieldName = 'Site Name'
    end
  end
  object qSitesNotInTheme: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT S.[Site Code], S.[Site Name]'
      'FROM SiteAztec S'
      'where S.[Site Code] not in (SELECT sitecode FROM ThemeSites)   '
      'and s.deleted is null or s.deleted = '#39'N'#39)
    Left = 296
    Top = 56
    object qSitesNotInThemeSiteCode: TSmallintField
      FieldName = 'Site Code'
    end
    object qSitesNotInThemeSiteName: TStringField
      FieldName = 'Site Name'
    end
  end
  object dsSitesInTheme: TDataSource
    DataSet = qSitesInTheme
    Left = 408
    Top = 8
  end
  object dsSitesNotInTheme: TDataSource
    DataSet = qSitesNotInTheme
    Left = 408
    Top = 56
  end
  object tThemeSites: TADOTable
    Connection = AztecConn
    TableName = 'ThemeSites'
    Left = 296
    Top = 160
  end
  object qClearOutletMappings: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'Update ThemeOutletTablePlan Set TablePlanID = NULL Where SiteCod' +
        'e = :SiteCode')
    Left = 296
    Top = 112
  end
  object qOutletTerminals: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    BeforeInsert = qOutletTerminalsBeforeInsert
    BeforeDelete = qOutletTerminalsBeforeDelete
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'sitecode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      'select a.[name], b.[paneldesignid], b.[defaultpanelid] '
      'from themeeposdevice a'
      'join themeeposdesign b'
      'on a.poscode = b.poscode'
      'where'
      'a.sitecode = :sitecode'
      'and a.IsServer = 0')
    Left = 48
    Top = 536
    object qOutletTerminalsname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object qOutletTerminalspaneldesignid: TIntegerField
      FieldName = 'paneldesignid'
      OnChange = qOutletTerminalspaneldesignidChange
    end
    object qOutletTerminalsdefaultpanelid: TIntegerField
      FieldName = 'defaultpanelid'
    end
    object qOutletTerminalspd_displayname: TStringField
      FieldKind = fkLookup
      FieldName = 'pd_displayname'
      LookupDataSet = qPanelDesigns
      LookupKeyFields = 'PanelDesignID'
      LookupResultField = 'Name'
      KeyFields = 'paneldesignid'
      Size = 50
      Lookup = True
    end
    object qOutletTerminalsdefault_panel_name: TStringField
      FieldKind = fkLookup
      FieldName = 'default_panel_name'
      LookupDataSet = qPanelNames
      LookupKeyFields = 'panelid'
      LookupResultField = 'name'
      KeyFields = 'defaultpanelid'
      Size = 50
      Lookup = True
    end
  end
  object qPanelNames: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select cast (null as bigint) as panelid, cast('#39'Root Panel'#39' as va' +
        'rchar(50)) as name'
      'union '
      'select tableplanid, '#39'Table Plan "'#39'+name+'#39'"'#39' from themetableplan'
      'where themeid = :themeid')
    Left = 200
    Top = 152
  end
  object dsOutletTerminals: TDataSource
    DataSet = qOutletTerminals
    Left = 120
    Top = 560
  end
  object qSharedPanelDims: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    DataSource = dsSharedPanels
    Parameters = <
      item
        Name = 'PanelID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT P.PanelID,'
      
        ' cast (Round((  (z300.[Left] * z300Type.ScreenWidth) - ((z300Typ' +
        'e.ButtonWidth * P.Width)/2) ) / z300Type.ButtonWidth,0) as Int) ' +
        '[z300Left],'
      
        ' cast (Round((  (z300.[Top] * z300Type.ScreenHeight) - ((z300Typ' +
        'e.ButtonHeight * P.Height)/2) ) / z300Type.Buttonheight,0) as In' +
        't)[z300Top],'
      
        ' cast (Round((  (z400.[Left] * z400Type.ScreenWidth) - ((z400Typ' +
        'e.ButtonWidth * P.Width)/2) ) / z400Type.ButtonWidth,0) as Int) ' +
        '[z400Left],'
      
        ' cast (Round((  (z400.[Top] * z400Type.ScreenHeight) - ((z400Typ' +
        'e.ButtonHeight * P.Height)/2) ) / z400Type.Buttonheight,0) as In' +
        't)[z400Top],'
      ' P.Width,'
      ' P.Height'
      'FROM ThemePanel P'
      
        'Join ThemePanelSharedPos z300 on z300.PAnelID = P.PanelID and Z3' +
        '00.PanelDesignTypeID = 1'
      
        'Join ThemePanelDesignType z300Type on z300Type.PanelDesignTypeID' +
        ' = z300.PanelDesignTypeID'
      
        'Join ThemePanelSharedPos z400 on z400.PAnelID = P.PAnelID and Z4' +
        '00.PanelDesignTypeID = 2'
      
        'Join ThemePanelDesignType z400Type on z400Type.PanelDesignTypeID' +
        ' = z400.PanelDesignTypeID'
      ''
      'WHERE P.panelID = :PanelID'
      ''
      '')
    Left = 408
    Top = 296
  end
  object sp_SharedPanelDimensionsOK: TADOStoredProc
    Connection = AztecConn
    CommandTimeout = 0
    ProcedureName = 'sp_SharedPanelOrderHeaderOverlap;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SharedPanelID'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end>
    Left = 296
    Top = 272
  end
  object qOutletTerminalsSetDefs: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'themeid'
        DataType = ftInteger
        Size = 1
        Value = 1
      end
      item
        Name = 'sitecode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      'declare @themeid int, @sitecode int'
      'set @themeid = :themeid'
      'set @sitecode = :sitecode'
      'insert themeeposdesign '
      '(poscode, paneldesignid, sitecode)'
      
        'select a.poscode, (select top 1 paneldesignid from themepaneldes' +
        'ign where themeid = @themeid), @sitecode'
      'from themeeposdevice a'
      'where'
      'a.sitecode = @sitecode'
      'and a.IsServer = 0'
      'and a.poscode is not null'
      'and a.poscode not in (select poscode from themeeposdesign)'
      'and a.HardwareType <> 11'
      ''
      'update themeeposdesign '
      'set paneldesignid = '
      
        '  (select top 1 paneldesignid from themepaneldesign where themei' +
        'd = @themeid)'
      'where'
      '  paneldesignid not in '
      
        ' (select paneldesignid from themepaneldesign where themeid = @th' +
        'emeid)'
      '  and sitecode = @sitecode'
      ''
      'update themeeposdesign '
      'set defaultpanelid = null'
      'where sitecode = @sitecode'
      
        '  and defaultpanelid not in (select tableplanid from themetablep' +
        'lan)'
      
        '  and defaultpanelid not in (select panelid from themepanel wher' +
        'e paneltype = 3 and paneldesignid = themeeposdesign.paneldesigni' +
        'd)'
      ''
      'delete themeeposdesign '
      '  where [poscode] not in '
      
        '  (select [poscode] from themeeposdevice where [poscode] is not ' +
        'null) and sitecode = @sitecode')
    Left = 48
    Top = 584
    object StringField1: TStringField
      FieldName = 'name'
      Size = 50
    end
    object IntegerField1: TIntegerField
      FieldName = 'paneldesignid'
      OnChange = qOutletTerminalspaneldesignidChange
    end
    object IntegerField2: TIntegerField
      FieldName = 'defaultpanelid'
    end
    object StringField2: TStringField
      FieldKind = fkLookup
      FieldName = 'pd_displayname'
      LookupDataSet = qPanelDesigns
      LookupKeyFields = 'PanelDesignID'
      LookupResultField = 'Name'
      KeyFields = 'paneldesignid'
      Size = 50
      Lookup = True
    end
    object StringField3: TStringField
      FieldKind = fkLookup
      FieldName = 'default_panel_name'
      LookupDataSet = qPanelNames
      LookupKeyFields = 'panelid'
      LookupResultField = 'name'
      KeyFields = 'defaultpanelid'
      Size = 50
      Lookup = True
    end
  end
  object qUpdateNewSiteConfigs: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'BEGIN TRANSACTION'
      ''
      '-- put in defaults for outlet configs'
      
        'if exists(select * from themeoutletconfigs where ipaddress is nu' +
        'll)'
      
        '  update themeoutletconfigs set ipaddress = '#39#39' where ipaddress i' +
        's null'
      ''
      
        'if exists (select * from (select [site code] as sitecode from si' +
        'teaztec) a where sitecode not in '
      '(select sitecode from ThemeOutletStandardPrintConfigs) )'
      'begin'
      '  insert ThemeOutletStandardPrintConfigs '
      
        '  (SiteCode, BillReceiptPrintStream, ReportPrintStream, EFTPrint' +
        'Stream, PrintHeader1, PrintHeader2,'
      
        '  PrintHeader3, EFTHeader1, EFTHeader2, EFTHeader3, PrintFooter1' +
        ', PrintFooter2, PrintFooter3,'
      
        '  VATNumber, CompactBillLines, PromotionSavingsOnBill, DiscountS' +
        'avingsOnBill, TotalSavingsOnBill)'
      '  select a.Sitecode, 1, 1, 1, '
      '    -- print headers and footers'
      '    '#39#39','#39#39','#39#39',  '#39#39','#39#39','#39#39',  '#39#39','#39#39','#39#39', '#39#39', 0, 0, 0, 0'
      
        '  from (select * from (select [site code] as sitecode from sitea' +
        'ztec) a where sitecode not in '
      '    (select sitecode from ThemeOutletStandardPrintConfigs)) a'
      'end'
      ''
      
        'IF EXISTS (SELECT * FROM (SELECT id AS sitecode FROM ac_Site) a ' +
        'WHERE sitecode not in'
      '(SELECT sitecode FROM themeoutletconfigs) )'
      'BEGIN'
      
        '  IF EXISTS(SELECT * FROM GenerVar WHERE VarName = '#39'UKUSMode'#39' an' +
        'd VarString = '#39'UK'#39')'
      '  BEGIN'
      '    insert themeoutletconfigs'
      
        #9#9'(SiteCode, WarnIfAccountsOpen, DeclareTips, TipValidationPerce' +
        'ntage, PrintClockOUTTicket, ScaleDisplayUnit, ScaleDecimalPlaces' +
        ')'
      #9#9'select a.Sitecode, 0, 0, 20, 0, '#39'kg'#39', 3'
      
        #9#9'from (select * from (select id as sitecode from ac_Site) a whe' +
        're sitecode not in'
      #9#9#9'(select sitecode from themeoutletconfigs)) a'
      '  END'
      '  '
      '  ELSE'
      '  BEGIN'
      '    insert themeoutletconfigs'
      
        #9#9'(SiteCode, WarnIfAccountsOpen, DeclareTips, TipValidationPerce' +
        'ntage, PrintClockOUTTicket, ScaleDisplayUnit, ScaleDecimalPlaces' +
        ')'
      #9#9'select a.Sitecode, 0, 1, 20, 1, '#39'lb'#39', 2'
      
        #9#9'from (select * from (select id as sitecode from ac_Site) a whe' +
        're sitecode not in'
      #9#9#9'(select sitecode from themeoutletconfigs)) a'
      '  END'
      ''
      'END'
      ''
      
        'IF EXISTS (SELECT * FROM (SELECT [site code] AS sitecode FROM si' +
        'teaztec) a WHERE sitecode NOT IN'
      #9'(SELECT sitecode FROM ThemeTerminalEFTTimeouts) )'
      'BEGIN'
      'INSERT ThemeTerminalEFTTimeouts'
      #9'(SiteCode, ID, Name, TimeoutTime, TimeoutRetryCount)'
      #9'SELECT '
      #9#9'a.SiteCode,  1, '#39'Gift Card'#39', 30, 4'
      #9'FROM '
      
        #9#9'(SELECT * FROM (SELECT [site code] AS sitecode FROM siteaztec)' +
        ' a WHERE sitecode NOT IN'
      #9#9#9'(SELECT sitecode FROM ThemeTerminalEFTTimeouts)) a'
      'UNION'
      #9'SELECT a.SiteCode,  2, '#39'Mag Stripe'#39', 30, 4'
      #9'FROM '
      
        #9#9'(SELECT * FROM (SELECT [site code] AS sitecode FROM siteaztec)' +
        ' a WHERE sitecode NOT IN'
      #9#9#9'(SELECT sitecode FROM ThemeTerminalEFTTimeouts)) a'
      'UNION'
      '    SELECT a.SiteCode,  3, '#39'Pre Auth / Local Card'#39', 5, 4'
      
        #9'FROM (SELECT * FROM (SELECT [site code] as sitecode FROM siteaz' +
        'tec) a WHERE sitecode NOT IN'
      #9#9'(SELECT sitecode FROM ThemeTerminalEFTTimeouts)) a'
      'END'
      ''
      
        'IF EXISTS (SELECT * FROM (SELECT [site code] AS SiteCode FROM Si' +
        'teAztec) a WHERE SiteCode NOT IN '
      '             (SELECT SiteCode FROM ThemeOutletSuggestedTip) )'
      'BEGIN'
      '  INSERT ThemeOutletSuggestedTip(SiteCode)'
      '  SELECT a.Sitecode'
      
        '  FROM (SELECT * FROM (SELECT [site code] AS SiteCode FROM SiteA' +
        'ztec) a WHERE SiteCode NOT IN '
      '    (SELECT SiteCode FROM ThemeOutletSuggestedTip)) a'
      'END'
      ''
      'COMMIT TRANSACTION')
    Left = 296
    Top = 216
  end
  object qConfigSets: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    AfterOpen = qConfigSetsAfterOpen
    BeforeEdit = qConfigSetsBeforeEdit
    BeforePost = qConfigSetsBeforePost
    AfterScroll = qConfigSetsAfterScroll
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeConfigSet')
    Left = 216
    Top = 440
    object qConfigSetsConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object qConfigSetsName: TStringField
      FieldName = 'Name'
    end
    object qConfigSetsAutoClose: TBooleanField
      FieldName = 'AutoClose'
    end
    object qConfigSetsAutoCloseTime: TStringField
      FieldName = 'AutoCloseTime'
      Size = 5
    end
    object qConfigSetsAutoDeclare: TBooleanField
      FieldName = 'AutoDeclare'
    end
    object qConfigSetsUseLogOnPassword: TBooleanField
      FieldName = 'UseLogOnPassword'
    end
    object qConfigSetsPrintSplitBillOnSave: TBooleanField
      FieldName = 'PrintSplitBillOnSave'
    end
    object qConfigSetsBarUseCoverCount: TBooleanField
      FieldName = 'BarUseCoverCount'
    end
    object qConfigSetsBarUseCustomerName: TBooleanField
      FieldName = 'BarUseCustomerName'
    end
    object qConfigSetsPrintReceiptByDefault: TBooleanField
      FieldName = 'PrintReceiptByDefault'
    end
    object qConfigSetsAutomaticReceiptPrintRequiresConfirmation: TBooleanField
      FieldName = 'AutomaticReceiptPrintRequiresConfirmation'
    end
    object qConfigSetsValidateBarAccounts: TBooleanField
      FieldName = 'ValidateBarAccounts'
    end
    object qConfigSetsValidateNonPerSeatTableAccounts: TBooleanField
      FieldName = 'ValidateNonPerSeatTableAccounts'
    end
    object qConfigSetsPrintTipLineOnEFTReceipt: TBooleanField
      FieldName = 'PrintTipLineOnEFTReceipt'
    end
    object qConfigSetsUseDrawerAssignment: TBooleanField
      FieldName = 'UseDrawerAssignment'
      OnChange = qConfigSetsUseDrawerAssignmentEnabledChange
    end
    object qConfigSetsShowChangeAndTip: TBooleanField
      FieldName = 'ShowChangeAndTip'
    end
    object qConfigSetsShowProductNameIfSerial: TBooleanField
      FieldName = 'ShowProductNameIfSerial'
    end
    object qConfigSetsCashbackAllowedOnBarAccounts: TBooleanField
      FieldName = 'CashbackAllowedOnBarAccounts'
    end
    object qConfigSetsCashbackAllowedOnPerSeatTableAccounts: TBooleanField
      FieldName = 'CashbackAllowedOnPerSeatTableAccounts'
    end
    object qConfigSetsCashbackAllowedOnNonPerSeatTableAccounts: TBooleanField
      FieldName = 'CashbackAllowedOnNonPerSeatTableAccounts'
    end
    object qConfigSetsValidateCustomerAge: TBooleanField
      FieldName = 'ValidateCustomerAge'
    end
    object qConfigSetsKitchenScreenType: TSmallintField
      FieldName = 'KitchenScreenType'
    end
    object qConfigSetsKitchenScreenTypeName: TStringField
      FieldKind = fkLookup
      FieldName = 'KitchenScreenTypeName'
      LookupDataSet = qKitchenScreenType
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'KitchenScreenType'
      Size = 50
      Lookup = True
    end
    object qConfigSetsKitchenScreenRedirectToBillReceiptPrinter: TBooleanField
      FieldName = 'KitchenScreenRedirectToBillReceiptPrinter'
    end
    object qConfigSetsGraphicID: TIntegerField
      FieldName = 'GraphicID'
    end
    object qConfigSetsForcedSelection: TBooleanField
      FieldName = 'ForcedSelection'
    end
    object qConfigSetsGraphicIDDisplay: TStringField
      FieldKind = fkLookup
      FieldName = 'GraphicIDDisplay'
      LookupDataSet = qTerminalGraphicsWithDefault
      LookupKeyFields = 'ID'
      LookupResultField = 'FileName'
      KeyFields = 'GraphicID'
      Lookup = True
    end
    object qConfigSetsDisplayDestinations: TBooleanField
      FieldName = 'DisplayDestinations'
    end
    object qConfigSetsSendAllBarcodedProducts: TBooleanField
      FieldName = 'SendAllBarcodedProducts'
    end
    object qConfigSetsDriveThruAllowCashBack: TBooleanField
      FieldName = 'CashBackAllowedOnDriveThruAccounts'
    end
    object qConfigSetsPrintValidationSlip: TBooleanField
      FieldName = 'PrintValidationSlip'
    end
    object qConfigSetsValidatePerSeatTableAccounts: TBooleanField
      FieldName = 'ValidatePerSeatTableAccounts'
    end
    object qConfigSetsPerSeatTableUseCoverCount: TBooleanField
      FieldName = 'PerSeatTableUseCoverCount'
    end
    object qConfigSetsPerSeatTableUseCustomerName: TBooleanField
      FieldName = 'PerSeatTableUseCustomerName'
    end
    object qConfigSetsNonPerSeatTableUseCustomerName: TBooleanField
      FieldName = 'NonPerSeatTableUseCustomerName'
    end
    object qConfigSetsNonPerSeatTableUseCoverCount: TBooleanField
      FieldName = 'NonPerSeatTableUseCoverCount'
    end
    object qConfigSetsUseLargeChangePrompt: TBooleanField
      FieldName = 'UseLargeChangePrompt'
    end
    object qConfigSetsUseFastEFT: TBooleanField
      FieldName = 'UseFastEFT'
    end
    object qConfigSetsConversationalRecipesEnabled: TBooleanField
      FieldName = 'ConversationalRecipesEnabled'
      OnChange = qConfigSetsConversationalRecipesEnabledChange
    end
    object qConfigSetsConversationalRecipesAutoAdvance: TBooleanField
      FieldName = 'ConversationalRecipesAutoAdvance'
    end
    object qConfigSetsHighlightAccountNumber: TBooleanField
      FieldName = 'HighlightAccountNumber'
    end
    object qConfigSetsUseAccountNumber: TBooleanField
      FieldName = 'UseAccountNumber'
    end
    object qConfigSetsRemoveChoiceAnd: TBooleanField
      FieldName = 'RemoveChoiceAnd'
    end
    object qConfigSetsRemoveChoiceMessage: TBooleanField
      FieldName = 'RemoveChoiceMessage'
    end
    object qConfigSetsOnlyDisplayDrawerChange: TBooleanField
      FieldName = 'OnlyDisplayDrawerChange'
    end
    object qConfigSetsAllowReopeningOfYesterdaysAccounts: TBooleanField
      FieldName = 'AllowReopeningOfYesterdaysAccounts'
    end
    object qConfigSetsRecordBarcodeUsage: TBooleanField
      FieldName = 'RecordBarcodeUsage'
    end
    object qConfigSetsPerSeatTableAutoServiceCharge: TBooleanField
      FieldName = 'PerSeatTableAutoServiceCharge'
    end
    object qConfigSetsBarAutoServiceCharge: TBooleanField
      FieldName = 'BarAutoServiceCharge'
    end
    object qConfigSetsNonPerSeatTableAutoServiceCharge: TBooleanField
      FieldName = 'NonPerSeatTableAutoServiceCharge'
    end
    object qConfigSetsEnableAdMargin: TBooleanField
      FieldName = 'EnableAdMargin'
    end
    object qConfigSetsReceiptBreakdownByHotelDivision: TBooleanField
      FieldName = 'ReceiptBreakdownByHotelDivision'
    end
    object qConfigSetsOpenDrawerOnFinalPayOnly: TBooleanField
      FieldName = 'OpenDrawerOnFinalPayOnly'
    end
    object qConfigSetsDisableAllButtonsWhenDrawerOpen: TBooleanField
      FieldName = 'DisableAllButtonsWhenDrawerOpen'
      OnChange = qConfigSetsDisableAllButtonsWhenDrawerOpenChange
    end
    object qConfigSetsi700CheckDrawerStatusBeforeOpening: TBooleanField
      FieldName = 'i700CheckDrawerStatusBeforeOpening'
    end
    object qConfigSetsCustomerInformationPrompt: TIntegerField
      FieldName = 'CustomerInformationPrompt'
    end
    object qConfigSetsCustomerInformationPromptText: TStringField
      FieldKind = fkLookup
      FieldName = 'CustomerInformationPromptText'
      LookupDataSet = qCustomerInformationPromptLookup
      LookupKeyFields = 'id'
      LookupResultField = 'PromptText'
      KeyFields = 'CustomerInformationPrompt'
      Size = 40
      Lookup = True
    end
    object qConfigSetsUsesPosPrinting: TBooleanField
      FieldName = 'UsesPosPrinting'
    end
    object qConfigSetsPrintPriceEmbeddedBarcode: TBooleanField
      FieldName = 'PrintPriceEmbeddedBarcode'
    end
    object qConfigSetsEnableKeyboardSupport: TBooleanField
      FieldName = 'EnableKeyboardSupport'
    end
    object qConfigSetsAutoThemeSendToBlankTerminals: TBooleanField
      FieldName = 'AutoThemeSendToBlankTerminals'
    end
    object qConfigSetsAllowCharityDonations: TBooleanField
      FieldName = 'AllowCharityDonations'
    end
    object qConfigSetsShowExchangeRateOnReceipt: TBooleanField
      FieldName = 'ShowExchangeRateOnReceipt'
    end
    object qConfigSetsShowExchangeRateOnBill: TBooleanField
      FieldName = 'ShowExchangeRateOnBill'
    end
    object qConfigSetsPromptForReasonOnTableMove: TBooleanField
      FieldName = 'PromptForReasonOnTableMove'
    end
    object qConfigSetsPromptForReasonOnTableMerge: TBooleanField
      FieldName = 'PromptForReasonOnTableMerge'
    end
    object qConfigSetsPromptForReasonOnAccountMove: TBooleanField
      FieldName = 'PromptForReasonOnAccountMove'
    end
    object qConfigSetsPromptForReasonOnAccountMerge: TBooleanField
      FieldName = 'PromptForReasonOnAccountMerge'
    end
    object qConfigSetsEnableTillCameraScanning: TBooleanField
      FieldName = 'EnableTillCameraScanning'
    end
    object qConfigSetsPrintAllOrderLinesOnBillAndReceipt: TBooleanField
      FieldName = 'PrintAllOrderLinesOnBillAndReceipt'
    end
    object qConfigSetsPromptToRedeemBookingOnStartTable: TBooleanField
      FieldName = 'PromptToRedeemBookingOnStartTable'
    end
  end
  object dsConfigSets: TDataSource
    DataSet = qConfigSets
    Left = 288
    Top = 424
  end
  object qConfigSetDivisions: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsConfigSets
    Parameters = <
      item
        Name = 'configsetid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    SQL.Strings = (
      'select * from ThemeConfigSetDivision'
      'where configsetid = :configsetid')
    Left = 216
    Top = 392
    object qConfigSetDivisionsConfigSetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ConfigSetID'
    end
    object qConfigSetDivisionsDivisionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DivisionID'
    end
    object qConfigSetDivisionsCanPayOnBarAccount: TBooleanField
      DisplayWidth = 5
      FieldName = 'CanPayOnBarAccount'
    end
    object qConfigSetDivisionsCanSaveOnBarAccount: TBooleanField
      DisplayWidth = 5
      FieldName = 'CanSaveOnBarAccount'
    end
    object qConfigSetDivisionsDivisionName: TStringField
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'DivisionName'
      LookupDataSet = qDivisionNames
      LookupKeyFields = 'divisionid'
      LookupResultField = 'name'
      KeyFields = 'DivisionID'
      Visible = False
      Lookup = True
    end
    object qConfigSetDivisionsAutoPrintReceipt: TBooleanField
      FieldName = 'AutoPrintReceipt'
    end
  end
  object dsConfigSetDivisions: TDataSource
    DataSet = qConfigSetDivisions
    Left = 288
    Top = 376
  end
  object qConfigSetCheckDivisions: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsConfigSets
    Parameters = <>
    SQL.Strings = (
      'DELETE ThemeConfigSetDivision'
      
        'WHERE ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigSet' +
        ')'
      'OR DivisionID NOT IN (SELECT [ID] FROM ac_ProductDivision)'
      ''
      'INSERT ThemeConfigSetDivision (ConfigSetId, DivisionId)'
      'SELECT a.ConfigSetID, b.Id AS DivisionId'
      'FROM ThemeConfigSet a, ac_ProductDivision b'
      
        'WHERE a.ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigS' +
        'etDivision)'
      'OR b.Id NOT IN (SELECT DivisionID FROM ThemeConfigSetDivision)'
      ''
      'DELETE ThemeConfigSetSubcategory'
      
        'WHERE ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigSet' +
        ')'
      'OR SubcategoryID NOT IN (SELECT [ID] FROM ac_ProductSubcategory)'
      ''
      'INSERT ThemeConfigSetSubcategory (ConfigSetId, SubcategoryId)'
      'SELECT a.ConfigSetID, b.Id AS SubCategoryId'
      'FROM ThemeConfigSet a, ac_ProductSubcategory b'
      
        'WHERE a.ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigS' +
        'etSubcategory)'
      
        'OR b.Id NOT IN (SELECT SubcategoryId FROM ThemeConfigSetSubcateg' +
        'ory)'
      '')
    Left = 408
    Top = 104
  end
  object dsDivisionNames: TDataSource
    DataSet = qDivisionNames
    Left = 288
    Top = 328
  end
  object qDivisionNames: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsConfigSets
    Parameters = <>
    SQL.Strings = (
      
        'select [index no] as divisionid, [division name] as name from di' +
        'vision')
    Left = 216
    Top = 344
  end
  object qConfigSetSubcat: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsConfigSets
    Parameters = <
      item
        Name = 'configsetid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    SQL.Strings = (
      'select * from ThemeConfigSetSubcategory'
      'where configsetid = :configsetid'
      'and SubcategoryID in'
      '(SELECT [Index No] FROM Subcategory'
      ' WHERE ISNULL([Deleted],'#39'N'#39') = '#39'N'#39')')
    Left = 216
    Top = 488
    object qConfigSetSubcatSubCategoryName: TStringField
      DisplayLabel = 'Sub-Cat.'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'SubCategoryName'
      LookupDataSet = qSubcategories
      LookupKeyFields = 'SubcategoryID'
      LookupResultField = 'Name'
      KeyFields = 'SubcategoryID'
      Lookup = True
    end
    object qConfigSetSubcatHotelDivisionName: TStringField
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'HotelDivisionName'
      LookupDataSet = qHotelDivisions
      LookupKeyFields = 'HotelDivisionID'
      LookupResultField = 'name'
      KeyFields = 'HotelDivision'
      Size = 16
      Lookup = True
    end
    object qConfigSetSubcatHotelDivision: TIntegerField
      DisplayWidth = 10
      FieldName = 'HotelDivision'
      Visible = False
    end
    object qConfigSetSubcatConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
      Visible = False
    end
    object qConfigSetSubcatSubcategoryID: TIntegerField
      FieldName = 'SubcategoryID'
      Visible = False
    end
  end
  object dsConfigSetSubcat: TDataSource
    DataSet = qConfigSetSubcat
    Left = 288
    Top = 472
  end
  object qHotelDivisions: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'select HotelDivisionID, Name, Description from ThemeHotelDivisio' +
        'n')
    Left = 216
    Top = 536
    object qHotelDivisionsHotelDivisionID: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'HotelDivisionID'
    end
    object qHotelDivisionsName: TStringField
      DisplayWidth = 33
      FieldName = 'Name'
      Size = 25
    end
    object qHotelDivisionsDescription: TStringField
      DisplayWidth = 34
      FieldName = 'Description'
      Size = 25
    end
  end
  object qSubcategories: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select [index no] as SubcategoryID, [sub-category name] as Name'
      'from subcateg'
      'where'
      'deleted is null or deleted = '#39'N'#39)
    Left = 288
    Top = 568
  end
  object dsHotelDivisions: TDataSource
    DataSet = qHotelDivisions
    Left = 288
    Top = 520
  end
  object qHotelDivsCombo: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select HotelDivisionID, Name from ThemeHotelDivision')
    Left = 216
    Top = 584
    object IntegerField3: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 8
      FieldName = 'HotelDivisionID'
    end
    object StringField4: TStringField
      DisplayWidth = 26
      FieldName = 'Name'
      Size = 25
    end
  end
  object ADOqryUpdateLastThemeSend: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'TerminalID'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    Prepared = True
    SQL.Strings = (
      'UPDATE AztecPos'
      'SET LastThemeSend = GetDate()'
      'WHERE TerminalID = :TerminalID')
    Left = 140
    Top = 500
  end
  object qKitchenScreenType: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeKitchenScreenTypeLookup')
    Left = 200
    Top = 200
  end
  object qTerminalGraphicsWithDefault: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT -1 AS ID, '#39'<Default>'#39' AS FileName'
      'UNION ALL'
      'SELECT ID, FileName FROM TerminalGraphics '
      'WHERE deleted = 0 OR deleted IS NULL'
      'ORDER BY FileName ')
    Left = 200
    Top = 248
  end
  object qSharedPanelVariations: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsSharedPanels
    Parameters = <
      item
        Name = 'panelid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Value = '100092'
      end>
    SQL.Strings = (
      'select * from ThemePanel'
      
        'where panelid in (select variationpanelid from themepanelvariati' +
        'on where panelid = :panelid)'
      'order by Name')
    Left = 48
    Top = 392
  end
  object dsSharedPanelVariations: TDataSource
    DataSet = qSharedPanelVariations
    Left = 128
    Top = 376
  end
  object qEditSiteVariations: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      ''
      '/*drop table #editsitevariations'
      
        '    create table #EditSiteVariations (    SiteCode int not null,' +
        '    SiteName varchar (20),    SiteRef varchar(10),    AreaName v' +
        'archar(20),    CrossTabColumn1 int, CrossTabColumn2 int,      pr' +
        'imary key (SiteCode)     )    '
      '*/'
      ''
      'select * from #EditSiteVariations')
    Left = 408
    Top = 152
    object qEditSiteVariationsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qEditSiteVariationsSiteName: TStringField
      FieldName = 'SiteName'
    end
    object qEditSiteVariationsSiteRef: TStringField
      FieldName = 'SiteRef'
      Size = 10
    end
    object qEditSiteVariationsAreaName: TStringField
      FieldName = 'AreaName'
    end
  end
  object dsEditSiteVariations: TDataSource
    DataSet = qEditSiteVariations
    Left = 408
    Top = 200
  end
  object qSetDefaultEposDesign: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '-- clear invalid ThemeEposDesign entries'
      'delete ThemeEposDesign'
      'from themeeposdesign'
      
        'join ThemeSites on ThemeEposDesign.SiteCode = ThemeSites.SiteCod' +
        'e'
      'left outer join ThemePanelDesign on '
      '  ThemeSites.ThemeID = ThemePanelDesign.ThemeID '
      
        '  and ThemeEposDesign.PanelDesignID = ThemePanelDesign.PanelDesi' +
        'gnID'
      'where '
      '  ThemePanelDesign.PanelDesignID is null'
      ''
      
        '-- add in default entries, taking hint from device type as to wh' +
        'ich one to use'
      'insert ThemeEposDesign (POSCode, PanelDesignID, SiteCode)'
      'select NewEposDesign.* '
      'from '
      '('
      
        '  select ThemeEposDevice.POSCode, a.PanelDesignID, ThemeEposDevi' +
        'ce.SiteCode'
      '  from ThemeEposDevice'
      
        '  join ThemeSites on ThemeEposDevice.SiteCode = ThemeSites.SiteC' +
        'ode'
      '  join ('
      
        '    select ThemeID, PanelDesignType, min(PanelDesignID) as Panel' +
        'DesignID from ThemePanelDesign'
      '    group by ThemeID, PanelDesignType'
      
        '  ) a on ThemeSites.ThemeID = a.ThemeID and PanelDesignType = ca' +
        'se ThemeEposDevice.HardwareType when 3 then 3 when 2 then 1 else' +
        ' 2 end'
      
        '  where ThemeEposDevice.IsServer = 0 and ThemeEposDevice.Hardwar' +
        'eType in'
      
        '    (select HardwareType from TerminalHardware where ClassName i' +
        'n ('#39'Aztec.Logic.EPoSDevice.AztecEPoSDevice'#39', '#39'Aztec.Logic.EPoSDe' +
        'vice.ConquerorEPoSDevice'#39'))'
      ') NewEposDesign'
      'left outer join ThemeEposDesign'
      '  on NewEposDesign.POSCode = ThemeEposDesign.POSCode'
      'where ThemeEposDesign.POSCode is null'
      ''
      '-- add in default entries, just taking first-set-up paneldesign'
      'insert ThemeEposDesign (POSCode, PanelDesignID, SiteCode)'
      'select NewEposDesign.* '
      'from '
      '('
      
        '  select ThemeEposDevice.POSCode, a.PanelDesignID, ThemeEposDevi' +
        'ce.SiteCode'
      '  from ThemeEposDevice'
      
        '  join ThemeSites on ThemeEposDevice.SiteCode = ThemeSites.SiteC' +
        'ode'
      '  join ('
      
        '    select ThemeID, min(PanelDesignID) as PanelDesignID from The' +
        'mePanelDesign'
      '    group by ThemeID'
      '  ) a on ThemeSites.ThemeID = a.ThemeID '
      
        '  where ThemeEposDevice.IsServer = 0 and ThemeEposDevice.Hardwar' +
        'eType in'
      
        '    (select HardwareType from TerminalHardware where ClassName i' +
        'n ('#39'Aztec.Logic.EPoSDevice.AztecEPoSDevice'#39', '#39'Aztec.Logic.EPoSDe' +
        'vice.ConquerorEPoSDevice'#39'))'
      ') NewEposDesign'
      'left outer join ThemeEposDesign'
      '  on NewEposDesign.POSCode = ThemeEposDesign.POSCode'
      'where ThemeEposDesign.POSCode is null')
    Left = 408
    Top = 344
    object StringField5: TStringField
      FieldName = 'name'
      Size = 50
    end
    object IntegerField4: TIntegerField
      FieldName = 'paneldesignid'
      OnChange = qOutletTerminalspaneldesignidChange
    end
    object IntegerField5: TIntegerField
      FieldName = 'defaultpanelid'
    end
    object StringField6: TStringField
      FieldKind = fkLookup
      FieldName = 'pd_displayname'
      LookupDataSet = qPanelDesigns
      LookupKeyFields = 'PanelDesignID'
      LookupResultField = 'Name'
      KeyFields = 'paneldesignid'
      Size = 50
      Lookup = True
    end
    object StringField7: TStringField
      FieldKind = fkLookup
      FieldName = 'default_panel_name'
      LookupDataSet = qPanelNames
      LookupKeyFields = 'panelid'
      LookupResultField = 'name'
      KeyFields = 'defaultpanelid'
      Size = 50
      Lookup = True
    end
  end
  object qSharedPanelDefault: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsSharedPanels
    Parameters = <
      item
        Name = 'panelid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Value = '100053'
      end>
    SQL.Strings = (
      'select defaultvariationpanelid from themepanelvariationgroup a '
      'where a.panelid = :panelid'
      '')
    Left = 48
    Top = 440
  end
  object dsSharedPanelDefault: TDataSource
    DataSet = qSharedPanelDefault
    Left = 128
    Top = 424
  end
  object qDefaultChoices: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsSharedPanels
    Parameters = <
      item
        Name = 'panelid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = '100053'
      end>
    SQL.Strings = (
      'select cast(-1 as int) as PanelID, '#39'<n/a>'#39' as PanelName'
      'union'
      'select cast(a.variationpanelid as int), b.name '
      'from themepanelvariation a '
      'join themepanel b on a.variationpanelid = b.panelid'
      'where a.panelid = :panelid'
      'order by 2')
    Left = 48
    Top = 488
  end
  object qSetDefaultSPPos: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '-- Check shared panel positions'
      '-- 1) Remove shared panel position records for non-shared panels'
      '-- 2) Check if all shared panels have a position defined'
      
        '-- 3) For any shared panels with no position defined, default th' +
        'eir position'
      
        '--   to any defined position for a panel of equal size in the sa' +
        'me panel design'
      ''
      
        '-- This check should be run when leaving the shared panel screen' +
        ' and after setting '
      '-- shared panel position for a panel'
      'delete ThemePanelSharedPos'
      'from ThemePanelSharedPos'
      
        'left outer join ThemePanel on ThemePanel.PanelID = ThemePanelSha' +
        'redPos.PanelID'
      '  and (themepanel.paneltype = 2) '
      'where ThemePanel.PanelID is null'
      ''
      'declare @PanelDesignCount int'
      'declare @SharedPanelCount int'
      'select @PanelDesignCount = count(*) from ThemePanelDesign'
      
        'select @SharedPanelCount = count(*) from ThemePanel where PanelT' +
        'ype = 2'
      ''
      
        'if (select count(*) from ThemePanelSharedPos) <> (@PanelDesignCo' +
        'unt * @SharedPanelCount)'
      'begin'
      '  insert ThemePanelSharedPos'
      '  (PanelID, PanelDesignID, [Left], [Top])'
      
        '  select sub.PanelID, sub.PanelDesignID, sub3.[Left], sub3.[Top]' +
        ' '
      '  from ('
      '   select ThemePanelDesign.PanelDesignID, Width, Height, PanelID'
      '   from ThemePanelDesign, ThemePanel '
      '   where PanelType = 2'
      '  ) sub'
      '  left outer Join ThemePanelSharedPos'
      '    on sub.PanelID = ThemePanelSharedPos.PanelID'
      '    and sub.PanelDesignID = ThemePanelSharedPos.PanelDesignID'
      '  join ('
      
        '    select ThemePanelSharedPos.PanelDesignID, Max(ThemePanelShar' +
        'edPos.PanelID) as PanelID, [Width], [Height]'
      '    from ThemePanelSharedPos'
      
        '    join ThemePanel on ThemePanelSharedPos.PanelID = ThemePanel.' +
        'PanelID'
      '    group by ThemePanelSharedPos.PanelDesignID, Width, Height'
      '  ) sub2 on sub.PanelDesignid = sub2.PanelDesignid'
      '    and sub.Width = sub2.Width'
      '    and sub.Height = sub2.Height'
      '  join ThemePanelSharedPos sub3 '
      '    on sub2.PanelDesignID = sub3.PanelDesignID'
      '    and sub2.PanelID = sub3.PanelID'
      '  where ThemePanelSharedPos.PanelID is null'
      'end')
    Left = 408
    Top = 392
    object StringField8: TStringField
      FieldName = 'name'
      Size = 50
    end
    object IntegerField6: TIntegerField
      FieldName = 'paneldesignid'
      OnChange = qOutletTerminalspaneldesignidChange
    end
    object IntegerField7: TIntegerField
      FieldName = 'defaultpanelid'
    end
    object StringField9: TStringField
      FieldKind = fkLookup
      FieldName = 'pd_displayname'
      LookupDataSet = qPanelDesigns
      LookupKeyFields = 'PanelDesignID'
      LookupResultField = 'Name'
      KeyFields = 'paneldesignid'
      Size = 50
      Lookup = True
    end
    object StringField10: TStringField
      FieldKind = fkLookup
      FieldName = 'default_panel_name'
      LookupDataSet = qPanelNames
      LookupKeyFields = 'panelid'
      LookupResultField = 'name'
      KeyFields = 'defaultpanelid'
      Size = 50
      Lookup = True
    end
  end
  object dsConfigSetDestinations: TDataSource
    DataSet = qConfigSetDestinations
    Left = 408
    Top = 440
  end
  object qConfigSetDestinations: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    DataSource = dsConfigSets
    Parameters = <
      item
        Name = 'configsetid'
        DataType = ftInteger
        Value = 0
      end>
    SQL.Strings = (
      'select * from ThemeConfigSetOrderDestinations'
      'where configsetid = :configsetid')
    Left = 408
    Top = 528
    object qConfigSetDestinationsDestinationName: TStringField
      DisplayLabel = 'Destination'
      DisplayWidth = 19
      FieldKind = fkLookup
      FieldName = 'DestinationName'
      LookupDataSet = qDestinations
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'OrderDestination'
      Size = 50
      Lookup = True
    end
    object qConfigSetDestinationsUseDestination: TBooleanField
      DisplayLabel = 'Use Destination'
      DisplayWidth = 12
      FieldName = 'UseDestination'
    end
    object qConfigSetDestinationsIsDefault: TBooleanField
      DisplayLabel = 'Default'
      DisplayWidth = 11
      FieldName = 'IsDefault'
    end
    object qConfigSetDestinationsConfigSetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ConfigSetID'
      Visible = False
    end
    object qConfigSetDestinationsOrderDestination: TIntegerField
      DisplayWidth = 10
      FieldName = 'OrderDestination'
      Visible = False
    end
  end
  object qDestinations: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ac_orderdestination')
    Left = 408
    Top = 572
  end
  object qConfigSetCheckOrderDestinations: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'DELETE ThemeConfigSetOrderDestinations'
      
        'WHERE ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigSet' +
        ')'
      
        'OR OrderDestination NOT IN (SELECT [ID] FROM ac_OrderDestination' +
        ' WHERE Deleted = 0)'
      ''
      
        'INSERT ThemeConfigSetOrderDestinations (ConfigSetID, OrderDestin' +
        'ation) '
      'SELECT a.ConfigSetID, b.Id AS OrderDestination'
      
        'FROM ThemeConfigSet a, (SELECT Id from ac_OrderDestination WHERE' +
        ' Deleted = 0) b'
      
        'WHERE a.ConfigSetID NOT IN (SELECT ConfigSetID FROM ThemeConfigS' +
        'etOrderDestinations)'
      
        'OR b.Id NOT IN (SELECT OrderDestination FROM ThemeConfigSetOrder' +
        'Destinations)')
    Left = 408
    Top = 484
  end
  object qMacros: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'PanelDesignID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 108
      end>
    SQL.Strings = (
      'select * from ThemePanelDesignMacro '
      'where PanelDesignID = :PanelDesignID')
    Left = 48
    Top = 632
    object qMacrosName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 50
    end
    object qMacrosDescription: TStringField
      DisplayWidth = 61
      FieldName = 'Description'
      Size = 255
    end
    object qMacrosMacroID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MacroID'
      Visible = False
    end
    object qMacrosPanelDesignID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PanelDesignID'
      Visible = False
    end
    object qMacrosEposName1: TStringField
      DisplayWidth = 50
      FieldName = 'EposName1'
      Visible = False
      Size = 50
    end
    object qMacrosEposName2: TStringField
      DisplayWidth = 50
      FieldName = 'EposName2'
      Visible = False
      Size = 50
    end
    object qMacrosEposName3: TStringField
      DisplayWidth = 50
      FieldName = 'EposName3'
      Visible = False
      Size = 50
    end
  end
  object dsMacros: TDataSource
    DataSet = qMacros
    Left = 128
    Top = 632
  end
  object qHotelAnalysisCodes: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, SiteID, Package, Code'
      'FROM HotelCodes '
      'WHERE Deleted = 0 and ID <> 0')
    Left = 216
    Top = 640
    object qHotelAnalysisCodesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
    end
    object qHotelAnalysisCodesCode: TStringField
      DisplayWidth = 27
      FieldName = 'Code'
      Size = 30
    end
    object qHotelAnalysisCodesSiteID: TIntegerField
      FieldName = 'SiteID'
      Visible = False
    end
    object qHotelAnalysisCodesPackage: TStringField
      FieldName = 'Package'
      Visible = False
      Size = 30
    end
  end
  object dsHotelAnalysisCodes: TDataSource
    DataSet = qHotelAnalysisCodes
    Left = 296
    Top = 624
  end
  object qCheckConvWidth: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'declare @ConfigSetId int'
      'set @ConfigSetId = 1'
      'declare @ConversationalWidth int'
      'select @ConversationalWidth = cast(FLOOR(min(width)) as int) '
      'from ThemeDialogPanelSet a '
      'join ThemePanel b on a.panelid = b.panelid'
      'join ('
      '  select distinct c.PanelDesignType '
      '  from ThemeEposDevice a'
      '  join ThemeEposDesign b on a.POSCode = b.POSCode'
      '  join ThemePanelDesign c on b.PanelDesignID = c.PanelDesignID'
      '  where a.ConfigSetID = @ConfigSetID'
      ') DesignsUsed on a.PanelDesignType = DesignsUsed.PanelDesignType'
      'where DialogPanelName = '#39'ConversationalOrdering'#39
      ''
      '-- check for recipes that blow the width limit.'
      
        '-- the width of the conv. ordering panel constrains the number o' +
        'f'
      '-- choices at the first level of the recipe'
      'select COUNT(*) from Portions a'
      'join PortionIngredients b on a.PortionID = b.PortionID'
      'where '
      
        '  a.EntityCode in (select EntityCode from Products where [Entity' +
        ' Type] in ('#39'std.line'#39', '#39'recipe'#39'))'
      'and'
      
        '  b.IngredientCode in (select EntityCode from Products where [En' +
        'tity Type] = '#39'Menu'#39')'
      'group by a.PortionID having COUNT(*) > @ConversationalWidth')
    Left = 408
    Top = 620
  end
  object qThemeCloakroomImage: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    OnCalcFields = qThemeCloakroomImageCalcFields
    CommandTimeout = 0
    DataSource = dsThemes
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from themecloakroomimage'
      'where themeid = :themeid')
    Left = 496
    Top = 32
    object qThemeCloakroomImageCloakroomImageID: TIntegerField
      FieldName = 'CloakroomImageID'
      Visible = False
    end
    object qThemeCloakroomImageThemeID: TIntegerField
      FieldName = 'ThemeID'
      Visible = False
    end
    object qThemeCloakroomImageName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qThemeCloakroomImageBitmap: TBlobField
      FieldName = 'Bitmap'
      Visible = False
    end
    object qThemeCloakroomImageBitmapSize: TIntegerField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'BitmapSize'
      DisplayFormat = '#######0'#39' kb'#39
      Calculated = True
    end
    object qThemeCloakroomImageThemeImageIndex: TIntegerField
      FieldName = 'ThemeImageIndex'
    end
    object qThemeCloakroomImageImageControlCode: TStringField
      FieldName = 'ImageControlCode'
      Size = 50
    end
  end
  object dsThemeCloakroomImage: TDataSource
    DataSet = qThemeCloakroomImage
    Left = 496
    Top = 80
  end
  object dsTotalImageSize: TDataSource
    DataSet = qTotalImageSize
    Left = 496
    Top = 176
  end
  object qTotalImageSize: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsThemes
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select isnull(1023+sum(datalength(bitmap)), 0) / 1024 as TotalIm' +
        'ageSize'
      'from ThemeCloakroomImage'
      'where themeid = :themeid')
    Left = 496
    Top = 128
    object qTotalImageSizeTotalImageSize: TLargeintField
      FieldName = 'TotalImageSize'
      ReadOnly = True
      DisplayFormat = '#######0'#39' kb'#39
    end
  end
  object qScaleContainer: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeScaleContainer')
    Left = 496
    Top = 232
    object qScaleContainerName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
    end
    object qScaleContainerDescription: TStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Size = 250
    end
    object qScaleContainerTareWeight: TFloatField
      DisplayLabel = 'Tare Weight'
      DisplayWidth = 12
      FieldName = 'TareWeight'
    end
    object qScaleContainerContainerId: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 4
      FieldName = 'ContainerId'
      Visible = False
    end
  end
  object dsScaleContainer: TDataSource
    DataSet = qScaleContainer
    Left = 496
    Top = 284
  end
  object qConfigSetsLookUp: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT [ConfigSetID], [Name]'
      'FROM ThemeConfigSet')
    Left = 520
    Top = 392
    object qConfigSetsLookUpConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object qConfigSetsLookUpName: TStringField
      FieldName = 'Name'
    end
  end
  object qKitchenScreenMessageSentWhenOrderSaved: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeMessageSentWhenOrderSavedLookup')
    Left = 520
    Top = 336
  end
  object qInitZcpsConfigs: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      '--- meta configs ---'
      'declare @IsSecureUser bit = 0'
      'set @IsSecureUser = 0  -- Set dynamically'
      ''
      'if object_id('#39'tempdb..#ZcpsMetaConfigColumns'#39') is not null'
      '  drop table #ZcpsMetaConfigColumns'
      'if object_id('#39'tempdb..#ZcpsMetaConfigValues'#39') is not null'
      '  drop table #ZcpsMetaConfigValues'
      ''
      
        'create table #ZcpsMetaConfigColumns (ColumnID int identity(1, 1)' +
        ', Name varchar(50), DisplayName varchar(50), MinValueId int, pri' +
        'mary key(ColumnID))'
      
        'create table #ZcpsMetaConfigValues (ColumnID int, ValueID int id' +
        'entity(1,1), ActualID int, Name varchar(50), DisplayName varchar' +
        '(50), primary key (ColumnID, Name))'
      ''
      'declare @CurrMC varchar(2000)'
      
        'declare MC cursor for select StringValue from GlobalConfiguratio' +
        'n'
      'where KeyName like '#39'ZcpsMetaConfig%'#39
      
        '  or (@IsSecureUser = 1 and KeyName like '#39'ZcpsSecureMetaConfig%'#39 +
        ')'
      'order by KeyName'
      'open MC; fetch next from MC into @CurrMC'
      'while @@FETCH_STATUS = 0'
      'begin'
      '  declare @CurrSplitMC varchar(2000)'
      
        '  declare SplitMC cursor for select * from dbo.fnSeparateStringL' +
        'ist(@CurrMC)'
      '  open SplitMC; fetch next from SplitMC into @CurrSplitMC'
      '  while @@FETCH_STATUS = 0'
      '  begin'
      
        '    declare @ConfigName varchar(50) = substring(@CurrSplitMC, 1,' +
        ' charindex('#39'='#39', @CurrSplitMC) -1)'
      
        '    declare @ConfigValues varchar(2000) = replace(substring(@Cur' +
        'rSplitMC, len(@ConfigName)+1+1, len(@CurrSplitMC)), '#39'|'#39', '#39' '#39')'
      '    declare @ConfigColumnID int'
      
        '    if exists(select * from #ZcpsMetaConfigColumns where Name = ' +
        '@ConfigName)'
      '    begin'
      
        '      select @ConfigColumnID = ColumnId from #ZcpsMetaConfigColu' +
        'mns where Name = @ConfigName'
      
        '      delete #ZcpsMetaConfigValues where ColumnID = @ConfigColum' +
        'nID'
      '    end'
      '    else'
      '    begin'
      '      insert #ZcpsMetaConfigColumns (Name) values (@ConfigName)'
      '      set @ConfigColumnID = SCOPE_IDENTITY()'
      '    end'
      '    insert #ZcpsMetaConfigValues (ColumnID, Name)'
      '    select @ConfigColumnID, Item'
      '    from dbo.fnSeparateStringList(@ConfigValues)'
      '    fetch next from SplitMC into @CurrSplitMC'
      '  end'
      '  close SplitMC; deallocate SplitMC'
      ''
      '  fetch next from MC into @CurrMC'
      'end'
      'close MC; deallocate MC'
      ''
      '-- Aztec-provided configs, not using globalconfig manifest'
      'declare @TmpColumnID int'
      ''
      
        'insert #ZcpsMetaConfigColumns (Name, DisplayName) values ('#39'AtsVx' +
        '680Logo'#39', '#39'ATS VX680 Logo'#39')'
      'set @TmpColumnID = SCOPE_IDENTITY()'
      
        'insert #ZcpsMetaConfigValues (ColumnID, ActualId, Name, DisplayN' +
        'ame) '
      
        'select @TmpColumnID, Id, FileName, FileName from TerminalGraphic' +
        's where IsNull(Deleted, 0) = 0'
      'union select @TmpColumnID, -1, '#39'<No image>'#39', '#39'<No image>'#39
      ''
      
        'insert #ZcpsMetaConfigColumns (Name, DisplayName) values ('#39'AtsVx' +
        '820Logo'#39', '#39'ATS VX820 Logo'#39')'
      'set @TmpColumnID = SCOPE_IDENTITY()'
      
        'insert #ZcpsMetaConfigValues (ColumnID, ActualId, Name, DisplayN' +
        'ame)'
      
        'select @TmpColumnID, Id, FileName, FileName from TerminalGraphic' +
        's where IsNull(Deleted, 0) = 0'
      'union select @TmpColumnID, -1, '#39'<No image>'#39', '#39'<No image>'#39
      '--'
      ''
      'update #ZcpsMetaConfigValues set ActualID = ValueID - MinId'
      'from #ZcpsMetaConfigValues a'
      'join ('
      'select ColumnID, MIN(ValueID) as MinId'
      'from #ZcpsMetaConfigValues'
      'group by ColumnID'
      ') b on a.ColumnID = b.ColumnID where ActualID is null'
      ''
      
        'create unique index IX_ZcpsMetaConfigValues_ColumnID_ActualID on' +
        ' #ZcpsMetaConfigValues (ColumnID, ActualID)'
      ''
      'update #ZcpsMetaConfigColumns'
      '  set MinValueId = MinimumId'
      'from #ZcpsMetaConfigColumns a'
      'join'
      '('
      '  select ColumnId, Min(ValueId) as MinimumId'
      '  from #ZcpsMetaConfigValues'
      '  group by ColumnId'
      ') b on a.ColumnId = b.ColumnId'
      ''
      '--=-=-=--'
      ''
      
        'declare @SQLOutput table (ScriptName varchar(50), OrderID int, S' +
        'QL varchar(7900))'
      'declare @ColumnCount int'
      'declare @ColumnLoop int'
      ''
      ''
      'insert @SQLOutput select '#39'DropSQL'#39', 1,'
      '  '#39
      '  if object_id('#39#39'tempdb..#EditZcpsMetaConfig'#39#39') is not null'
      '  drop table #EditZcpsMetaConfig'
      
        '  if object_id('#39#39'tempdb..#EditZcpsMetaConfig_Backup'#39#39') is not nu' +
        'll'
      '  drop table #EditZcpsMetaConfig_Backup'
      
        '  if object_id('#39#39'tempdb..#EditZcpsMetaConfig_Changes'#39#39') is not n' +
        'ull'
      '  drop table #EditZcpsMetaConfig_Changes'
      '  '#39
      ''
      'insert @SQLOutput select '#39'CreateSQL'#39', 0,'
      '  '#39
      '  create table #EditZcpsMetaConfig ('
      '    SiteCode int not null,'
      '    SiteName varchar (20),'
      '    SiteRef varchar(10),'
      '    AreaName varchar(20),'
      '  '#39
      ''
      'insert @SQLOutput select '#39'CreateSQL'#39', 20000,'
      '  '#39
      
        '  select top 0 * into #EditZcpsMetaConfig_Backup from #EditZcpsM' +
        'etaConfig'
      
        '  create unique clustered index IX_EditZcpsMetaConfig_Backup_Sit' +
        'e on #EditZcpsMetaConfig_Backup (SiteCode)'
      
        '  select top 0 * into #EditZcpsMetaConfig_Changes from #EditZcps' +
        'MetaConfig'
      
        '  create unique clustered index IX_EditZcpsMetaConfig_Changes_Si' +
        'te on #EditZcpsMetaConfig_Changes (SiteCode)'
      '  '#39
      ''
      ''
      'insert @SQLOutput select '#39'LoadSQL'#39', 0,'
      '  '#39
      '    truncate table #EditZcpsMetaConfig'
      '    insert #EditZcpsMetaConfig'
      '    (SiteCode, SiteName, SiteRef, AreaName)'
      
        '    select distinct ac_Site.id, ac_site.Name, ac_Site.Reference,' +
        ' Config.[Area Name]'
      '    from ThemeOutletConfigs'
      '    join ac_Site on ThemeOutletConfigs.SiteCode = ac_Site.id'
      '    join Config on ac_Site.id = Config.[Site Code]'
      '      and Config.Deleted is null or Config.Deleted = '#39#39'N'#39#39
      
        '    where ac_Site.id <> 0 and ThemeOutletConfigs.EFTMode = 2 and' +
        ' (ac_Site.Deleted = 0)'
      
        '    insert #EditZcpsMetaConfig (SiteCode, SiteName, SiteRef, Are' +
        'aName)'
      '    select 0, '#39#39'Default'#39#39', '#39#39'All'#39#39', '#39#39'All'#39#39
      ''
      ''
      ''
      '  '#39
      ''
      'insert @SQLOutput select '#39'LoadSQL'#39', 10000,'
      '  '#39
      'truncate table #EditZcpsMetaConfig_Backup'
      
        'insert #EditZcpsMetaConfig_Backup select * from #EditZcpsMetaCon' +
        'fig  '
      '  '
      '  '#39
      ''
      'insert @SQLOutput select '#39'SaveSQL'#39', 0,'
      '  '#39
      'truncate table #EditZcpsMetaConfig_Backup'
      
        'insert #EditZcpsMetaConfig_Backup select * from #EditZcpsMetaCon' +
        'fig '
      
        'declare @SaveData table (SiteCode int, KeyName varchar(255), Str' +
        'ingValue varchar(8000), Deleted bit)'
      ''
      '  '#39
      ''
      'insert @SQLOutput select '#39'SaveSQL'#39', 20000, '
      '  '#39
      '  update a'
      '    set Deleted = 1'
      '  from @SaveData a'
      
        '  join @SaveData b on b.SiteCode = 0 and a.KeyName = b.KeyName a' +
        'nd a.StringValue = b.StringValue'
      '  where a.SiteCode <> 0'
      ''
      
        '  update GlobalConfiguration set StringValue = a.StringValue, LM' +
        'DT = GETDATE()'
      '  from GlobalConfiguration'
      
        '  join @SaveData a on a.SiteCode = 0 and Globalconfiguration.Key' +
        'Name = a.KeyName'
      '  where GlobalConfiguration.StringValue <> a.StringValue'
      ''
      
        '  insert GlobalConfiguration select a.KeyName, a.StringValue, GE' +
        'TDATE()'
      '  from @SaveData a'
      
        '  left outer join GlobalConfiguration on a.KeyName = GlobalConfi' +
        'guration.KeyName'
      
        '  where a.SiteCode = 0 and GlobalConfiguration.KeyName is null a' +
        'nd a.Deleted = 0 --??'
      ''
      
        '  update SiteConfiguration set StringValue = a.StringValue, Dele' +
        'ted = a.Deleted, LMDT = GETDATE()'
      
        '  from SiteConfiguration join @SaveData a on SiteConfiguration.S' +
        'iteCode = a.SiteCode '
      '    and SiteConfiguration.KeyName = a.KeyName'
      
        '  where a.SiteCode <> 0 and SiteConfiguration.StringValue <> a.S' +
        'tringValue or SiteConfiguration.Deleted <> a.Deleted'
      '  '
      
        '  insert SiteConfiguration select a.SiteCode, a.KeyName, a.Strin' +
        'gValue, a.Deleted, GETDATE()'
      '  from @SaveData a'
      
        '  left outer join SiteConfiguration on a.SiteCode = SiteConfigur' +
        'ation.SiteCode and a.KeyName = SiteConfiguration.KeyName'
      
        '  where a.SiteCode <> 0 and SiteConfiguration.KeyName is null an' +
        'd a.Deleted = 0'
      '  '
      '  '#39
      ''
      ''
      'select @ColumnCount = max(ColumnID) from #ZcpsMetaConfigColumns'
      'set @ColumnLoop = 1'
      'while @ColumnLoop <= @ColumnCount'
      'begin'
      '  insert @SQLOutput select '#39'CreateSQL'#39', @ColumnLoop,'
      
        '   '#39'CrossTabColumn'#39'+cast(@ColumnLoop as varchar(10))+ '#39' int null' +
        ', '#39
      ''
      '  -- set default, then load from data table'
      '  insert @SQLOutput select '#39'LoadSQL'#39', @ColumnLoop,'
      '  '#39
      '    update #EditZcpsMetaConfig'
      
        '      set CrossTabColumn'#39'+cast(@ColumnLoop as varchar(10))+ '#39' = ' +
        'IsNull(d.ValueID, c.MinValueId)'
      '    from #EditZcpsMetaConfig a'
      
        '    join #ZcpsMetaConfigColumns c on c.ColumnID = '#39'+cast(@Column' +
        'Loop as varchar(10))+'#39
      
        '    left outer join GlobalConfiguration b on b.KeyName = '#39#39'Zcps'#39 +
        #39'+c.Name'
      
        '    left outer join #ZcpsMetaConfigValues d on d.ColumnID = c.Co' +
        'lumnID and b.StringValue = cast(d.ActualID as varchar(50))'
      ''
      '    update #EditZcpsMetaConfig'
      
        '      set CrossTabColumn'#39'+cast(@ColumnLoop as varchar(10))+ '#39' = ' +
        'd.ValueID'
      '    from #EditZcpsMetaConfig a'
      
        '    join #ZcpsMetaConfigColumns c on c.ColumnID = '#39'+cast(@Column' +
        'Loop as varchar(10))+'#39' '
      
        '    join SiteConfiguration b on a.SiteCode = b.SiteCode and b.De' +
        'leted = 0 and b.KeyName = '#39#39'Zcps'#39#39'+c.Name'
      
        '    join #ZcpsMetaConfigValues d on d.ColumnID = c.ColumnID and ' +
        'b.StringValue = cast(d.ActualID as varchar(50))'
      '    where a.SiteCode <> 0'
      '  '#39
      ''
      '  insert @SQLOutput select '#39'SaveSQL'#39', @ColumnLoop,'
      '  '#39
      
        '    insert @SaveData select 0, '#39#39'Zcps'#39#39'+c.Name, IsNull(cast(d.Ac' +
        'tualID as varchar(50)), '#39#39'<deleted>'#39#39'), case when d.ActualID is ' +
        'null then 1 else 0 end'
      '    from #EditZcpsMetaConfig a'
      
        '    join #ZcpsMetaConfigColumns c on c.ColumnID = '#39'+cast(@Column' +
        'Loop as varchar(10))+'#39' '
      
        '    left outer join #ZcpsMetaConfigValues d on d.ColumnID = c.Co' +
        'lumnID and CrossTabColumn'#39'+cast(@ColumnLoop as varchar(10))+'#39' = ' +
        'd.ValueID'
      '    where a.SiteCode = 0'
      '    '
      
        '    insert @SaveData select a.SiteCode, '#39#39'Zcps'#39#39'+c.Name, IsNull(' +
        'cast(d.ActualID as varchar(50)), '#39#39'<deleted>'#39#39'), case when d.Act' +
        'ualID is null then 1 else 0 end'
      '    from #EditZcpsMetaConfig a'
      
        '    join #ZcpsMetaConfigColumns c on c.ColumnID = '#39'+cast(@Column' +
        'Loop as varchar(10))+'#39' '
      
        '    left outer join #ZcpsMetaConfigValues d on d.ColumnID = c.Co' +
        'lumnID and CrossTabColumn'#39'+cast(@ColumnLoop as varchar(10))+'#39' = ' +
        'd.ValueID'
      '    where a.SiteCode <> 0   '
      '    '
      '  '#39
      ''
      '  set @ColumnLoop = @ColumnLoop + 1'
      'end'
      ''
      'insert @SQLOutput select '#39'CreateSQL'#39', 10000,'
      '  '#39
      '  primary key (SiteCode)'
      '  )'
      '  '#39
      ''
      'select * from @SQLOutput order by 1, 2'
      '')
    Left = 512
    Top = 464
  end
  object qEditZcpsConfigs: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/*'
      '  create table #EditZcpsMetaConfig ('
      '    SiteCode int not null,'
      '    SiteName varchar (20),'
      '    SiteRef varchar(10),'
      '    AreaName varchar(20),'
      
        '  CrossTabColumn1 int null, CrossTabColumn2 int null, CrossTabCo' +
        'lumn3 int null, CrossTabColumn4 int null, '
      '  primary key (SiteCode)'
      '  )'
      '  */'
      ''
      'select * from #EditZcpsMetaConfig'
      'order by case when SiteCode = 0 then 0 else 1 end, SiteRef')
    Left = 512
    Top = 576
    object IntegerField8: TIntegerField
      FieldName = 'SiteCode'
    end
    object StringField11: TStringField
      FieldName = 'SiteName'
    end
    object StringField12: TStringField
      FieldName = 'SiteRef'
      Size = 10
    end
    object StringField13: TStringField
      FieldName = 'AreaName'
    end
  end
  object dsEditZcpsConfigs: TDataSource
    DataSet = qEditZcpsConfigs
    OnDataChange = dsEditZcpsConfigsDataChange
    Left = 512
    Top = 624
  end
  object qInitZcpsConfigsGetSummary: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'declare @ColCount int'
      'declare @ColChecksum int'
      'declare @ValCount int'
      'declare @ValChecksum int'
      ''
      
        'select @ColCount = count(*), @ColChecksum = checksum_agg(checksu' +
        'm(name))'
      'from #ZcpsMetaConfigColumns'
      ''
      
        'select @ValCount = count(*), @ValChecksum = checksum_agg(checksu' +
        'm(actualid, name))'
      'from #ZcpsMetaConfigValues'
      ''
      
        'select @ColCount ColCount, @ColChecksum ColChecksum, @ValCount V' +
        'alCount, @ValChecksum ValChecksum')
    Left = 512
    Top = 512
  end
  object qCustomerInformationPrompts: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    AfterPost = updateCustomerInformationPromptLookup
    AfterDelete = updateCustomerInformationPromptLookup
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from ThemeCustomerInformationPrompts'
      'where id > 0')
    Left = 600
    Top = 64
    object qCustomerInformationPromptsPromptText: TStringField
      DisplayLabel = 'Prompt Text'
      DisplayWidth = 80
      FieldName = 'PromptText'
      OnSetText = qCustomerInformationPromptsPromptTextSetText
      Size = 40
    end
    object qCustomerInformationPromptsMaximumEntryLength: TIntegerField
      DisplayLabel = 'Maximum Entry Length'
      DisplayWidth = 16
      FieldName = 'MaximumEntryLength'
      Required = True
      OnSetText = qCustomerInformationPromptsMaximumEntryLengthSetText
      MaxValue = 40
      MinValue = 1
    end
    object qCustomerInformationPromptsid: TIntegerField
      DisplayWidth = 10
      FieldName = 'id'
      Visible = False
    end
  end
  object dsCustomerInformationPrompts: TDataSource
    DataSet = qCustomerInformationPrompts
    Left = 600
    Top = 116
  end
  object qCustomerInformationPromptLookup: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from ThemeCustomerInformationPrompts')
    Left = 600
    Top = 200
    object qCustomerInformationPromptLookupid: TIntegerField
      FieldName = 'id'
    end
    object qCustomerInformationPromptLookupPromptText: TStringField
      FieldName = 'PromptText'
      Size = 40
    end
  end
  object dsCustomerInformationPromptLookup: TDataSource
    DataSet = qCustomerInformationPromptLookup
    Left = 600
    Top = 248
  end
end
