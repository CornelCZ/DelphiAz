object SiteThemes: TSiteThemes
  Left = 772
  Top = 211
  HelpContext = 5014
  Anchors = [akTop]
  BorderStyle = bsDialog
  Caption = 'Site Themes'
  ClientHeight = 461
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = HideFormExecute
  OnShow = ShowFormExecute
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Select Theme:'
  end
  object Label2: TLabel
    Left = 384
    Top = 48
    Width = 73
    Height = 13
    Caption = 'Sites in Theme:'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 92
    Height = 13
    Caption = 'Sites not in Theme:'
  end
  object Label4: TLabel
    Left = 8
    Top = 272
    Width = 220
    Height = 13
    Caption = 'Terminal settings (for selected Site in Theme):'
  end
  object btClose: TButton
    Left = 553
    Top = 430
    Width = 76
    Height = 25
    Caption = 'Close'
    TabOrder = 11
    OnClick = btCloseClick
  end
  object dbgSitesInTheme: TwwDBGrid
    Left = 384
    Top = 64
    Width = 246
    Height = 201
    Selected.Strings = (
      'Site Ref'#9'10'#9'Site Ref'
      'Site Name'#9'26'#9'Site Name')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = dbgSitesInThemeRowChanged
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsSiteTheme_InTheme
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object dbgSitesNotInTheme: TwwDBGrid
    Left = 8
    Top = 64
    Width = 246
    Height = 201
    Selected.Strings = (
      'Site Ref'#9'10'#9'Site Ref'#9'F'
      'Site Name'#9'26'#9'Site Name')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsSiteTheme_NotInTheme
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object dbgTerminalSettings: TwwDBGrid
    Left = 8
    Top = 288
    Width = 622
    Height = 137
    ControlType.Strings = (
      'PanelDesignName;CustomEdit;wwDBLookupCombo1;F'
      'DefaultPanelName;CustomEdit;wwDBLookupCombo2;F'
      'DefaultCycleName;CustomEdit;wwDBLookupCombo3;F'
      'DashboardReportName;CustomEdit;wwDBLookupCombo4;F'
      'DashboardTimeout;CustomEdit;wwDBSpinEdit1;F')
    Selected.Strings = (
      'Name'#9'20'#9'Name'#9'F'
      'PanelDesignName'#9'20'#9'Panel Design'#9'F'
      'DefaultPanelName'#9'30'#9'Default Panel'#9'F'
      'DefaultCycleName'#9'27'#9'Default Cycle Name'#9'F'
      'DashboardReportName'#9'30'#9'Dashboard Report Name'#9'F'
      'DashboardTimeout'#9'10'#9'Timeout (in minutes)'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 1
    ShowHorzScrollBar = True
    DataSource = dsSiteTheme_TerminalSettings
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 7
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = dbgTerminalSettingsCalcCellColors
    OnMouseMove = dbgTerminalSettingsMouseMove
  end
  object cbThemeList: TwwDBLookupCombo
    Left = 8
    Top = 24
    Width = 137
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Name'#9'50'#9'Name'#9#9)
    LookupTable = qSiteTheme_ThemeListDisplay
    LookupField = 'themeID'
    Style = csDropDownList
    DropDownWidth = 137
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = cbThemeListCloseUp
  end
  object btExcludeSingle: TButton
    Left = 309
    Top = 200
    Width = 25
    Height = 25
    Action = ExcludeSingleSite
    TabOrder = 2
  end
  object btExcludeAll: TButton
    Left = 309
    Top = 168
    Width = 25
    Height = 25
    Action = ExcludeAllSites
    TabOrder = 3
  end
  object btIncludeAll: TButton
    Left = 309
    Top = 136
    Width = 25
    Height = 25
    Action = IncludeAllSites
    TabOrder = 4
  end
  object btIncludeSingle: TButton
    Left = 309
    Top = 104
    Width = 25
    Height = 25
    Action = IncludeSingleSite
    TabOrder = 5
  end
  object btMatchTablePlans: TButton
    Left = 262
    Top = 432
    Width = 146
    Height = 25
    Action = ShowTablePlanMatchings
    TabOrder = 10
  end
  object wwDBLookupCombo2: TwwDBLookupCombo
    Left = 140
    Top = 392
    Width = 186
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'name'#9'50'#9'name'#9#9)
    DataField = 'DefaultPanelID'
    DataSource = dsSiteTheme_TerminalSettings
    LookupTable = qSiteTheme_DefaultPanelList
    LookupField = 'id'
    Style = csDropDownList
    DropDownWidth = 186
    TabOrder = 8
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
  end
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 16
    Top = 392
    Width = 121
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'name'#9'50'#9'name'#9#9)
    DataField = 'PanelDesignID'
    DataSource = dsSiteTheme_TerminalSettings
    LookupTable = qSiteTheme_PanelDesignList
    LookupField = 'paneldesignid'
    Style = csDropDownList
    DropDownWidth = 121
    TabOrder = 9
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
  end
  object btPreview: TButton
    Left = 8
    Top = 432
    Width = 75
    Height = 25
    Action = SitePreview
    TabOrder = 12
  end
  object btnPanelTimes: TButton
    Left = 100
    Top = 432
    Width = 145
    Height = 25
    Action = ViewDefaultPanelTimes
    TabOrder = 13
  end
  object wwDBLookupCombo3: TwwDBLookupCombo
    Left = 328
    Top = 392
    Width = 126
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'name'#9'50'#9'name'#9#9)
    DataField = 'DefaultCycleID'
    DataSource = dsSiteTheme_TerminalSettings
    LookupTable = qSiteTheme_DefaultCycleList
    LookupField = 'ID'
    Style = csDropDownList
    DropDownWidth = 186
    ParentShowHint = False
    ShowHint = False
    TabOrder = 14
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
  end
  object wwDBLookupCombo4: TwwDBLookupCombo
    Left = 464
    Top = 392
    Width = 126
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'DisplayName'#9'50'#9'DisplayName'#9#9)
    DataField = 'DashboardReportID'
    DataSource = dsSiteTheme_TerminalSettings
    LookupTable = qSiteTheme_DashboardReportList
    LookupField = 'ID'
    Style = csDropDownList
    DropDownWidth = 186
    ParentShowHint = False
    ShowHint = False
    TabOrder = 15
    Visible = False
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
    OnCloseUp = wwDBLookupCombo4CloseUp
  end
  object wwDBSpinEdit1: TwwDBSpinEdit
    Left = 496
    Top = 352
    Width = 121
    Height = 21
    Increment = 1
    MaxValue = 60
    MinValue = 1
    Value = 1
    DataField = 'DashboardTimeout'
    DataSource = dsSiteTheme_TerminalSettings
    MaxLength = 2
    TabOrder = 16
    UnboundDataType = wwDefault
    Visible = False
  end
  object qSiteTheme_ThemeList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select themeID, Name from Theme'
      
        'where exists (select * from themepaneldesign where themepaneldes' +
        'ign.themeid =  theme.themeid)'
      'order by Name')
    Left = 535
    Top = 8
  end
  object ActionList1: TActionList
    Left = 152
    Top = 8
    object ShowForm: TAction
      Caption = 'ShowForm'
      OnExecute = ShowFormExecute
    end
    object HideForm: TAction
      Caption = 'HideForm'
      OnExecute = HideFormExecute
    end
    object ShowTablePlanMatchings: TAction
      Caption = 'View Matched Table Plans'
      OnExecute = ShowTablePlanMatchingsExecute
      OnUpdate = UpdateActiveWhenSitesAvailable
    end
    object ExcludeSingleSite: TAction
      Caption = '<'
      OnExecute = ExcludeSingleSiteExecute
    end
    object ExcludeAllSites: TAction
      Caption = '<<'
      OnExecute = ExcludeAllSitesExecute
    end
    object IncludeAllSites: TAction
      Caption = '>>'
      OnExecute = IncludeAllSitesExecute
    end
    object IncludeSingleSite: TAction
      Caption = '>'
      OnExecute = IncludeSingleSiteExecute
    end
    object SitePreview: TAction
      Caption = 'Preview'
      OnExecute = SitePreviewExecute
      OnUpdate = SitePreviewUpdate
    end
    object ViewDefaultPanelTimes: TAction
      Caption = 'View Default Panel Times'
      OnExecute = ViewDefaultPanelTimesExecute
      OnUpdate = UpdateActiveWhenSitesAvailable
    end
  end
  object dsSiteTheme_ThemeList: TDataSource
    DataSet = qSiteTheme_ThemeList
    Left = 567
    Top = 8
  end
  object qSiteTheme_InTheme: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsSiteTheme_ThemeList
    Parameters = <
      item
        Name = 'ThemeID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'select SiteCode, [Site Ref], [Site Name] '
      'from ThemeSites '
      'join SiteAztec on Sitecode = [Site Code]'
      'where ThemeID = :ThemeID')
    Left = 549
    Top = 40
  end
  object dsSiteTheme_InTheme: TDataSource
    DataSet = qSiteTheme_InTheme
    Left = 581
    Top = 40
  end
  object qSiteTheme_NotInTheme: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Site Code] as SiteCode, [Site Ref], [Site Name] '
      
        'from SiteAztec where [Site code] not in (select sitecode from Th' +
        'emeSites)'
      'and (Deleted is null or Deleted = '#39'N'#39')')
    Left = 549
    Top = 72
  end
  object dsSiteTheme_NotInTheme: TDataSource
    DataSet = qSiteTheme_NotInTheme
    Left = 581
    Top = 72
  end
  object qSiteTheme_TerminalSettings: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = qSiteTheme_TerminalSettingsAfterPost
    AfterScroll = qSiteTheme_TerminalSettingsAfterScroll
    DataSource = dsSiteTheme_InTheme
    Parameters = <
      item
        Name = 'siteCode'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @SiteCode int'
      'SET @SiteCode = :siteCode'
      ''
      
        'SELECT a.EposDeviceId, c.Name, ted.PanelDesignId, DefaultPanelID' +
        ', DefaultCycleID, DashboardReportID,'
      
        '       DashboardTimeout, a.HardwareType AS HardwareType, a.Multi' +
        'DrawerMode'
      'FROM ThemeEposDevice a'
      'INNER JOIN'
      ' (SELECT EposDeviceID, Name'
      '  FROM ThemeEposDevice'
      '  WHERE SiteCode = @SiteCode'
      '  AND HardwareType <> 10'
      '  UNION'
      '  SELECT MIN(e.EposDeviceID), '#39'MOA - '#39' + s.Name'
      '  FROM ThemeEposDevice e'
      '    JOIN ac_Pos p on p.Id = e.POSCode'
      '    JOIN ac_SalesArea s on s.Id = p.SalesAreaId'
      '  WHERE e.SiteCode = @SiteCode'
      '  AND e.HardwareType = 10'
      
        '  GROUP BY p.SalesAreaId, s.Name) c ON c.EPoSDeviceID = a.EPoSDe' +
        'viceID  '
      'JOIN TerminalHardware b on a.HardwareType = b.HardwareType'
      'JOIN themeeposdesign ted on a.poscode = ted.poscode'
      'WHERE a.SiteCode = @SiteCode'
      
        'AND ClassName in ('#39'Aztec.Logic.EPoSDevice.AztecEPoSDevice'#39', '#39'Azt' +
        'ec.Logic.EPoSDevice.ConquerorEPoSDevice'#39')'
      ''
      ''
      ''
      '')
    Left = 549
    Top = 104
    object qSiteTheme_TerminalSettingsEposDeviceID: TSmallintField
      FieldName = 'EposDeviceID'
    end
    object qSiteTheme_TerminalSettingsName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qSiteTheme_TerminalSettingsPanelDesignID: TIntegerField
      FieldName = 'PanelDesignID'
      OnChange = qSiteTheme_TerminalSettingsPanelDesignIDChange
      OnValidate = qSiteTheme_TerminalSettingsPanelDesignIDValidate
    end
    object qSiteTheme_TerminalSettingsDefaultPanelID: TIntegerField
      FieldName = 'DefaultPanelID'
    end
    object qSiteTheme_TerminalSettingsPanelDesignName: TStringField
      FieldKind = fkLookup
      FieldName = 'PanelDesignName'
      LookupDataSet = qSiteTheme_PanelDesignList
      LookupKeyFields = 'paneldesignid'
      LookupResultField = 'name'
      KeyFields = 'PanelDesignID'
      Size = 50
      Lookup = True
    end
    object qSiteTheme_TerminalSettingsDefaultPanelName: TStringField
      FieldKind = fkLookup
      FieldName = 'DefaultPanelName'
      LookupDataSet = qSiteTheme_DefaultPanelList_All
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'DefaultPanelID'
      Size = 50
      Lookup = True
    end
    object qSiteTheme_TerminalSettingsDefaultCycleID: TIntegerField
      FieldName = 'DefaultCycleID'
    end
    object qSiteTheme_TerminalSettingsDefaultCycleName: TStringField
      FieldKind = fkLookup
      FieldName = 'DefaultCycleName'
      LookupDataSet = qSiteTheme_DefaultCycleList_All
      LookupKeyFields = 'ID'
      LookupResultField = 'Name'
      KeyFields = 'DefaultCycleID'
      Size = 50
      Lookup = True
    end
    object qSiteTheme_TerminalSettingsDashboardReprortID: TIntegerField
      FieldName = 'DashboardReportID'
    end
    object qSiteTheme_TerminalSettingsDashboardReportName: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'DashboardReportName'
      LookupDataSet = qSiteTheme_DashboardReportList
      LookupKeyFields = 'ID'
      LookupResultField = 'DisplayName'
      KeyFields = 'DashboardReportID'
      Size = 50
      Lookup = True
    end
    object qSiteTheme_TerminalSettingsDashboardTimeout: TIntegerField
      FieldName = 'DashboardTimeout'
    end
    object qSiteTheme_TerminalSettingsHardwareType: TIntegerField
      FieldName = 'HardwareType'
    end
    object qSiteTheme_TerminalSettingsMultiDrawerMode: TBooleanField
      FieldName = 'MultiDrawerMode'
    end
  end
  object dsSiteTheme_TerminalSettings: TDataSource
    DataSet = qSiteTheme_TerminalSettings
    Left = 581
    Top = 104
  end
  object qSiteTheme_PanelDesignList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsSiteTheme_ThemeList
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'select paneldesignid, name '
      'from themepaneldesign '
      'where themeid = :themeid'
      'order by name')
    Left = 549
    Top = 152
  end
  object qSiteTheme_DefaultPanelList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'declare @result table(id int, name varchar(100))'
      'declare @paneldesignid int'
      'set @paneldesignid = 100'
      ''
      
        'insert @result select null, '#39'Root Panel'#39' from themepaneldesign w' +
        'here paneldesignid = @paneldesignid'
      'insert @result select tableplanid, '#39'Table Plan "'#39' +name+'#39'"'#39' '
      'from  ThemeTablePlan where'
      
        'themeid = (select top 1 themeid from ThemePanelDesign where pane' +
        'ldesignid = @paneldesignid)'
      'insert @result'
      'select panelid, name from themepanel'
      'where paneltype = 3 and paneldesignid = @paneldesignid'
      'and panelid not in '
      '('
      'select root from themepaneldesign '
      'where paneldesignid = @paneldesignid'
      'union'
      'select correctaccount from themepaneldesign '
      'where paneldesignid = @paneldesignid'
      'union'
      'select forcedselection from themepaneldesign '
      
        'where paneldesignid = @paneldesignid and forcedselection is not ' +
        'null'
      ')'
      'order by name'
      'select * from @result'
      '')
    Left = 549
    Top = 184
  end
  object qSiteTheme_DefaultPanelList_All: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'declare @result table(id int, name varchar(100))'
      ''
      'insert @result select null, '#39'Root Panel'#39
      'insert @result select tableplanid, '#39'Table Plan "'#39' +name+'#39'"'#39' '
      'from  ThemeTablePlan'
      'insert @result'
      'select panelid, name from themepanel'
      'where paneltype = 3 and panelid not in '
      '('
      'select root from themepaneldesign'
      'union'
      'select correctaccount from themepaneldesign '
      'union '
      
        'select forcedselection from themepaneldesign where forcedselecti' +
        'on is not null'
      ')'
      'order by name'
      'select * from @result'
      '')
    Left = 549
    Top = 216
  end
  object qSiteTheme_ThemeListDisplay: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select themeID, Name from Theme'
      
        'where exists (select * from themepaneldesign where themepaneldes' +
        'ign.themeid =  theme.themeid)'
      'order by Name')
    Left = 503
    Top = 8
  end
  object qSiteTheme_DefaultCycleList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'declare @paneldesignid int'
      'set @paneldesignid = 101'
      ''
      'SELECT NULL AS ID, '#39#39' AS NAME'
      'UNION'
      'SELECT ID, Name FROM '
      'ThemeDefaultPanelCycles'
      'WHERE PanelDesignID = @paneldesignid'
      'ORDER BY Name')
    Left = 549
    Top = 248
  end
  object qSiteTheme_DefaultCycleList_All: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, Name FROM '
      'ThemeDefaultPanelCycles')
    Left = 550
    Top = 280
  end
  object qSiteTheme_DashboardReportList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT NULL  AS ID, '#39'<No Inactivity Report>'#39' AS DisplayName'
      'UNION'
      'SELECT ReportID, Name FROM '
      'ThemeReport'
      'WHERE isDashboardReport = 1'
      'ORDER BY DisplayName')
    Left = 589
    Top = 248
  end
  object qSiteTheme_DashboardReportList_All: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, DisplayName FROM '
      'InactivityReports')
    Left = 590
    Top = 280
  end
  object qUpdateMOAPanelDesign: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'siteCode'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'panelDesignID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'salesAreaID'
        Size = -1
        Value = Null
      end
      item
        Name = 'MOADeviceID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @SiteCode int'
      ''
      'SET @SiteCode =  :siteCode'
      ''
      'UPDATE ThemeEposDesign'
      '  SET PanelDesignID = :panelDesignID'
      'WHERE SiteCode = @SiteCode'
      'AND POSCode IN '
      '  (SELECT e.POSCode'
      '   FROM ThemeEposDevice e'
      '     JOIN ac_Pos p on p.Id = e.POSCode'
      '   WHERE e.SiteCode = @SiteCode'
      '   AND e.HardwareType = 10'
      '   AND p.SalesAreaId = :salesAreaID'
      '   AND e.EPoSDeviceID <> :MOADeviceID)'
      '   ')
    Left = 512
    Top = 248
  end
end
