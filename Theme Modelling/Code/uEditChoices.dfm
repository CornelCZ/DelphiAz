object EditChoices: TEditChoices
  Left = 465
  Top = 224
  HelpContext = 5030
  BorderStyle = bsSingle
  Caption = 'Edit Choices'
  ClientHeight = 473
  ClientWidth = 646
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
  OnShow = FormShow
  DesignSize = (
    646
    473)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 255
    Height = 13
    Caption = 'Select MOD panels for each choice that requires one.'
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 427
    Height = 13
    Caption = 
      'Only panels that can be accessed from via the panel design may b' +
      'e used as MOD panels.'
  end
  object Button1: TButton
    Left = 564
    Top = 442
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 484
    Top = 442
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button2Click
  end
  object dbgEditChoices: TwwDBGrid
    Left = 8
    Top = 48
    Width = 631
    Height = 387
    ControlType.Strings = (
      'PanelName;CustomEdit;wwDBLookupCombo1;F')
    Selected.Strings = (
      'Name'#9'50'#9'Choice Name'#9'T'
      'PanelName'#9'50'#9'Mod Panel'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 1
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 2
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
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 440
    Top = 88
    Width = 121
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'name'#9'50'#9'name'#9#9)
    DataField = 'panelid'
    DataSource = DataSource1
    LookupTable = qActivePanels
    LookupField = 'panelid'
    Style = csDropDownList
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
  end
  object qPrepareEdit: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'declare @paneldesignid int'
      'set @paneldesignid = '
      '101'
      ''
      'declare @act_panels int'
      ''
      
        'create table #PortionHeader (PortionID int, EntityCode float, Po' +
        'rtionTypeID smallint,'
      
        '  DisplayOrder tinyint, ContainsChoice bit, iteration int, IsCho' +
        'ice bit, ContainerID int, MinChoice int, MaxChoice int, SuppChoi' +
        'ce int, AllowPlain bit, primary key (portionid))'
      ''
      
        'create table #PortionDetail (PortionID int, IngredientCode float' +
        ', DisplayOrder tinyint,'
      
        '  Quantity decimal (8, 2), UnitName varchar (10) collate databas' +
        'e_default, PortionTypeID smallint, CalculationType tinyint, Cont' +
        'ainsChoice bit, IsChoice bit, IncludeByDefault bit primary key (' +
        'portionid, ingredientcode, displayorder))'
      ''
      'create table #choicelist (choiceid bigint, [name] varchar(50))'
      'create table #activepanels (panelid bigint, [name] varchar(50))'
      
        'create table #editchoices (choiceid bigint, panelid int, Name va' +
        'rchar(50))'
      'create table #panelset (panelid bigint, primary key (panelid))'
      ''
      'exec theme_getproductinfo'
      ''
      'insert #choicelist (choiceid, [name])'
      
        'select b.[entitycode], b.[extended rtl name] from #portionheader' +
        ' a'
      'join products b on a.entitycode = b.entitycode'
      'where b.[entity type] = '#39'Menu'#39
      ''
      '-- add local p.d. panels'
      ''
      
        'insert #panelset select panelid from ThemePanel where PanelDesig' +
        'nID = @PanelDesignID'
      ''
      'exec Theme_RecursePanelSet 0, 1'
      ''
      
        'delete #panelset where panelid = (select root from ThemePanelDes' +
        'ign where PanelDesignID = @PanelDesignID)'
      
        'delete #panelset where panelid = (select correctaccount from The' +
        'mePanelDesign where PanelDesignID = @PanelDesignID)'
      
        'delete #panelset where panelid = (select pay from ThemePanelDesi' +
        'gn where PanelDesignID = @PanelDesignID)'
      ''
      'insert #activepanels values (null, '#39'<None>'#39')'
      'insert #activepanels (panelid, [name])'
      'select distinct b.panelid, b.[name]'
      'from #panelset a join themepanel b on a.panelid = b.panelid'
      'where b.paneltype in (2,3) -- shared or local'
      'order by b.[name]'
      ''
      'insert #editchoices (choiceid, panelid, name)'
      'select a.choiceid, b.panelid, a.name'
      'from #choicelist a'
      
        'left outer join ThemeChoiceAndPanels b on a.choiceid = b.choicei' +
        'd'
      'and b.paneldesignid = @paneldesignid'
      'group by a.choiceid, b.panelid, a.name'
      ''
      'drop table #panelset')
    Left = 80
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = qEditChoices
    Left = 160
    Top = 40
  end
  object qEditChoices: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = qEditChoicesAfterOpen
    BeforeInsert = qEditChoicesBeforeInsert
    BeforeDelete = qEditChoicesBeforeDelete
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select  * from #editchoices')
    Left = 128
    Top = 48
    object qEditChoicesName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qEditChoicesPanelName: TStringField
      DisplayLabel = 'Mod Panel'
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'PanelName'
      LookupDataSet = qActivePanels
      LookupKeyFields = 'panelid'
      LookupResultField = 'name'
      KeyFields = 'panelid'
      Size = 50
      Lookup = True
    end
    object qEditChoiceschoiceid: TLargeintField
      FieldName = 'choiceid'
      Visible = False
    end
    object qEditChoicespanelid: TIntegerField
      FieldName = 'panelid'
      Visible = False
    end
  end
  object qChoicelist: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select  * from #choicelist')
    Left = 40
    Top = 48
    object qChoicelistname: TStringField
      DisplayWidth = 50
      FieldName = 'name'
      Size = 50
    end
    object qChoicelistchoiceid: TLargeintField
      DisplayWidth = 15
      FieldName = 'choiceid'
      Visible = False
    end
  end
  object qActivePanels: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select  * from #activepanels')
    Left = 48
    Top = 80
    object qActivePanelspanelid: TLargeintField
      DisplayWidth = 15
      FieldName = 'panelid'
    end
    object qActivePanelsname: TStringField
      DisplayWidth = 50
      FieldName = 'name'
      Size = 50
    end
  end
  object qSaveChanges: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'declare @paneldesignid int'
      'set @paneldesignid ='
      '101'
      'delete ThemeChoiceAndPanels'
      
        'where choiceid in (select choiceid from #editchoices where panel' +
        'id is null)  '
      'and PanelDesignID = @paneldesignid'
      'insert ThemeChoiceAndPanels '
      'select @paneldesignid, choiceid, panelid'
      'from #editchoices where choiceid not in'
      
        '  (select choiceid from ThemeChoiceAndPanels where paneldesignid' +
        ' = @paneldesignid)'
      'and panelid is not null'
      'update ThemeChoiceAndPanels'
      'set panelid = b.panelid '
      'from #editchoices b'
      
        'where paneldesignid = @paneldesignid and ThemeChoiceAndPanels.ch' +
        'oiceid = b.choiceid'
      'and b.panelid is not null')
    Left = 120
    Top = 80
  end
end
