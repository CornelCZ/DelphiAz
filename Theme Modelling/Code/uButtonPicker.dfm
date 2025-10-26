object ButtonPicker: TButtonPicker
  Left = 549
  Top = 235
  Width = 605
  Height = 685
  HelpContext = 5004
  BorderStyle = bsSizeToolWin
  Caption = 'Button Picker'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonGrid: TDBCtrlGrid
    Left = 0
    Top = 22
    Width = 589
    Height = 526
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    ColCount = 1
    DataSource = DataSource2
    PanelHeight = 58
    PanelWidth = 572
    TabOrder = 0
    RowCount = 9
    OnMouseDown = ButtonGridMouseDown
    object DBText1: TDBText
      Left = 71
      Top = 2
      Width = 305
      Height = 17
      Hint = 'Product Name'
      DataField = 'buttonname'
      DataSource = DataSource2
      ParentShowHint = False
      Transparent = True
      ShowHint = True
      OnMouseDown = DBText1MouseDown
    end
    object DBText2: TDBText
      Left = 79
      Top = 34
      Width = 305
      Height = 17
      Hint = 'Product Description'
      Color = clBtnFace
      DataField = 'buttondescription'
      DataSource = DataSource2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      Transparent = True
      ShowHint = True
      OnMouseDown = DBText2MouseDown
    end
    object DBText3: TDBText
      Left = 79
      Top = 18
      Width = 305
      Height = 17
      Hint = 'Product Subcategory'
      DataField = 'subcategory'
      DataSource = DataSource2
      ParentShowHint = False
      Transparent = True
      ShowHint = True
      OnMouseDown = DBText3MouseDown
    end
    object TillButton1: TTillbutton
      Left = 1
      Top = 1
      Width = 64
      Height = 48
      Datasource = DataSource2
      upd = True
      AllowDrag = True
      showhint = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 548
    Width = 589
    Height = 79
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      589
      79)
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 62
      Height = 13
      Caption = 'Name search'
    end
    object Label2: TLabel
      Left = 4
      Top = 30
      Width = 62
      Height = 13
      Caption = 'Desc. search'
    end
    object lblTagFilter: TLabel
      Left = 4
      Top = 55
      Width = 63
      Height = 13
      Caption = 'Product Tags'
    end
    object edNameFilter: TEdit
      Left = 70
      Top = 3
      Width = 445
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = FilterTextChange
    end
    object edDescFilter: TEdit
      Left = 70
      Top = 27
      Width = 445
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = FilterTextChange
    end
    object cbNameMidword: TCheckBox
      Left = 522
      Top = 5
      Width = 66
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Mid-word'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = FilterTextChange
    end
    object cbDescMidword: TCheckBox
      Left = 522
      Top = 29
      Width = 66
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Mid-word'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = FilterTextChange
    end
    object edtTagFilter: TEdit
      Left = 70
      Top = 52
      Width = 445
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 4
      OnChange = edtTagFilterChange
    end
    object btnTags: TButton
      Left = 520
      Top = 50
      Width = 65
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Tags'
      TabOrder = 5
      OnClick = btnTagsClick
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 627
    Width = 589
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ADOQuery1: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    Left = 8
    Top = 144
  end
  object ADOQuery2: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    Left = 8
    Top = 176
  end
  object qButtonList: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterOpen = qButtonListAfterOpen
    CommandTimeout = 0
    Parameters = <>
    Left = 8
    Top = 208
  end
  object DataSource2: TDataSource
    DataSet = qButtonList
    Left = 40
    Top = 208
  end
  object FilterTimer: TTimer
    Enabled = False
    OnTimer = FilterTimerTimer
    Left = 8
    Top = 240
  end
  object qGetSearchNames: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterOpen = qButtonListAfterOpen
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'if OBJECT_ID('#39'tempdb..#ButtonNameLookup'#39') is not null'
      '  drop table #ButtonNameLookup'
      '  '
      
        'select ButtonTypeChoiceID, ButtonTypeChoiceAttr01, ButtonTypeCho' +
        'iceAttr02,'
      
        '  replace(eposname1 + ISNULL('#39' '#39'+eposname2, '#39#39') + ISNULL('#39' '#39'+epo' +
        'sname3, '#39#39'), CHAR(13)+CHAR(10), '#39' '#39') as SearchName'
      'into #ButtonNameLookup'
      'from ('
      
        '  select Id as ButtonTypeChoiceID, null as ButtonTypeChoiceAttr0' +
        '1, null as ButtonTypeChoiceAttr02, '
      
        '    null as Name, b.Text as EposName1, '#39#39' as EposName2, '#39#39' as Ep' +
        'osName3'
      '  from ThemeButtonTypeChoiceLookup a'
      '  join ThemeFunctionText b on a.Name = b.ButtonFunction'
      '  where [Lookup] is null and DataConditionals is null'
      
        '  and a.Id NOT IN (select id from themebuttontypechoicelookup wh' +
        'ere Name = '#39'ShellExecute'#39')'
      '  union'
      
        '  select Id as ButtonTypeChoiceID, a.ElemAttrName01 as ButtonTyp' +
        'eChoiceAttr01, null as ButtonTypeChoiceAttr02,'
      
        '    null as Name, b.Text as EposName1, '#39#39' as EposName2, '#39#39' as Ep' +
        'osName3'
      '  from ThemeButtonTypeChoiceLookup a'
      '  join ThemeFunctionText b on a.Name = b.ButtonFunction'
      '  where [Lookup] is null and DataConditionals is null'
      
        '  and a.Id IN (select id from themebuttontypechoicelookup where ' +
        'Name = '#39'ShellExecute'#39')'
      '  union'
      '  select Id, '#39'T'#39', null, null, '#39'Increase'#39', '#39'Float'#39', '#39#39
      '  from ThemeButtonTypeChoiceLookup where Name = '#39'UpdateFloat'#39
      '  union'
      
        '  select Id, '#39'F'#39', null, null, (Select top 1 SkimTerminology from' +
        ' ac_CompanyFinanceSettings), '#39#39', '#39#39
      '  from ThemeButtonTypeChoiceLookup where Name = '#39'UpdateFloat'#39
      '  union'
      
        '  select Id, '#39'1'#39', null, null, '#39'1'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'2'#39', null, null, '#39'2'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'3'#39', null, null, '#39'3'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'4'#39', null, null, '#39'4'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'5'#39', null, null, '#39'5'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'6'#39', null, null, '#39'6'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'7'#39', null, null, '#39'7'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'8'#39', null, null, '#39'8'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      
        '  select Id, '#39'9'#39', null, null, '#39'9'#39', '#39#39', '#39#39' from ThemeButtonTypeCh' +
        'oiceLookup where Name = '#39'UpdateQuantity'#39' union'
      ''
      
        '  select Id as ButtonTypeChoiceID, ButtonTypeChoiceAttr01, Butto' +
        'nTypeChoiceAttr02, LookupData.Name, EPosName1, EPosName2, EPosNa' +
        'me3'
      '  from ThemeButtonTypeChoiceLookup a'
      '  join ThemeFunctionText b on a.Name = b.ButtonFunction'
      '  join ('
      
        '    select '#39'Correction'#39' as LookupName, CAST(CorrectionMethodID a' +
        's varchar(50)) as ButtonTypeChoiceAttr01, null as ButtonTypeChoi' +
        'ceAttr02, Name, EPOSName1, EPOSName2, EPOSName3 from Theme_Corre' +
        'ctionMethod'
      '    union'
      
        '    select '#39'Panel'#39' as LookupName, null, Cast(TablePlanID as varc' +
        'har(50)), Name, EposName1, EposName2, EposName3 from ThemeTableP' +
        'lan'
      '    union'
      
        '    select '#39'Discount'#39', CAST(DiscountID as varchar(50)), null, Na' +
        'me, EposName1, EposName2, EposName3 from Discount'
      '    union'
      
        '    select '#39'Macro'#39',  CAST(MacroId as varchar(50)), null, Name, E' +
        'posName1, EposName2, EposName3 from ThemePanelDesignMacro'
      '    union'
      
        '    select '#39'OrderDestination'#39',  CAST(Id as varchar(50)), null, N' +
        'ame, PosButtonTextLine1, PosButtonTextLine2, PosButtonTextLine3 ' +
        'from ac_OrderDestination'
      '    union'
      
        '    select '#39'ButtonUrl'#39', CAST(Id as varchar(50)), null, Name, Epo' +
        'sName1, EposName2, EposName3 from ThemeButtonUrl'
      '    union'
      
        '    select '#39'Panel'#39', Cast(PanelId as varchar(50)), null, Name, Ep' +
        'osName1, EposName2, EposName3 from ThemePanel'
      '    union'
      
        '    select '#39'Payment'#39', CAST(Id as varchar(50)), null, Name, PosBu' +
        'ttonTextLine1, PosButtonTextLine2, PosButtonTextLine3 from ac_Pa' +
        'ymentMethod'
      '    union'
      
        '    select '#39'PortionType'#39', CAST(Id as varchar(50)), null, Name, P' +
        'osButtonTextLine1, PosButtonTextLine2, PosButtonTextLine3 from a' +
        'c_PortionType'
      '    union'
      
        '    select '#39'Report'#39', CAST(ReportID as varchar(50)), null, Name, ' +
        'EposName1, Eposname2, EposName3 from ThemeReport'
      '    union'
      
        '    select '#39'Tax'#39', CAST(Id as varchar(50)), null, Name, PosButton' +
        'TextLine1, PosButtonTextLine2, PosButtonTextLine3 from ac_TaxRul' +
        'e'
      '  ) LookupData on b.[Lookup] = LookupName'
      ') sub'
      ''
      ''
      
        'create index ix_buttonnamelookup  on #ButtonNameLookup (ButtonTy' +
        'peChoiceID, ButtonTypeChoiceAttr01, ButtonTypeChoiceAttr02)'
      '')
    Left = 8
    Top = 272
  end
end
