object fAuditLocations: TfAuditLocations
  Left = 262
  Top = 184
  Width = 1053
  Height = 617
  HelpContext = 1008
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Audit Stock - Fill in the Stock Count for each item'
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwGrid1: TwwDBGrid
    Left = 0
    Top = 24
    Width = 1037
    Height = 452
    PictureMasks.Strings = (
      
        'ActCloseStk'#9'{{{#[#][#][#][#][#][{.#[#],/{0,1[{0,1}],2,3,4,5,6,7,' +
        '8,9}}]},.#[#],0/{0,1[{0,1}],2,3,4,5,6,7,8,9,10,11}}}'#9'F'#9'T')
    Selected.Strings = (
      'RecID'#9'4'#9'Row'#9'F'
      'SubCat'#9'20'#9'Sub Category'#9'F'
      'Name'#9'40'#9'Name'#9'F'
      'ImpExRef'#9'20'#9'ImpExRef'#9'F'
      'OpStk'#9'11'#9'Open Stk'#9'T'
      'PurchStk'#9'10'#9'PurchStk'#9'T'
      'ThRedQty'#9'10'#9'Th. Reduct.'#9'F'
      'ThCloseStk'#9'10'#9'Th. Close Stk'#9'F'
      'Wastage'#9'11'#9'Wastage'#9'F'
      'ActCloseStk'#9'13'#9'Audit Stk'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = wwGrid1RowChanged
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = wwsAuditCur
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = wwGrid1CalcCellColors
    OnDblClick = wwGrid1DblClick
    OnExit = wwGrid1Exit
    OnKeyDown = wwGrid1KeyDown
    PaintOptions.ActiveRecordColor = clHighlight
  end
  object Panel1: TPanel
    Left = 0
    Top = 476
    Width = 1037
    Height = 102
    Align = alBottom
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    TabOrder = 1
    DesignSize = (
      1037
      102)
    object Bevel5: TBevel
      Left = 194
      Top = 8
      Width = 335
      Height = 37
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel3: TBevel
      Left = 194
      Top = 51
      Width = 250
      Height = 48
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel1: TBevel
      Left = 168
      Top = 1
      Width = 25
      Height = 100
      Shape = bsRightLine
      Style = bsRaised
    end
    object Label1: TLabel
      Left = 17
      Top = 85
      Width = 96
      Height = 14
      AutoSize = False
      Caption = 'show typed counts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object Label3: TLabel
      Left = 199
      Top = 59
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub Categ.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel
      Left = 210
      Top = 78
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Audit Stk'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 201
      Top = 45
      Width = 66
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Grid Filters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 99
      Top = 59
      Width = 17
      Height = 42
      Shape = bsRightLine
      Style = bsRaised
    end
    object Bevel2: TBevel
      Left = 2
      Top = 58
      Width = 189
      Height = 7
      Shape = bsTopLine
      Style = bsRaised
    end
    object lblFormat: TLabel
      Left = 789
      Top = 8
      Width = 18
      Height = 46
      Hint = 'Double Click to see '#13#10'Special Formatting.'
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'D'#13#10'G'
      Color = clBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      OnDblClick = lblFormatDblClick
    end
    object dbtEntCode: TDBText
      Left = 282
      Top = 43
      Width = 123
      Height = 12
      DataField = 'EntityCode'
      DataSource = wwsAuditCur
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LabelSearch: TLabel
      Left = 201
      Top = 2
      Width = 178
      Height = 13
      Caption = 'Incremental Search (Next = F3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnDblClick = LabelSearchDblClick
    end
    object btnAutoFill: TBitBtn
      Left = 809
      Top = 8
      Width = 82
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'Fill blank '#10'Counts with'#10'Theo Closing'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      Visible = False
      OnClick = btnAutoFillClick
    end
    object PanelRadioButtonSearch: TPanel
      Left = 445
      Top = 12
      Width = 82
      Height = 31
      BevelOuter = bvNone
      TabOrder = 11
      object RadioButtonName: TRadioButton
        Left = 2
        Top = 1
        Width = 72
        Height = 13
        Caption = 'Name'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = RadioButtonSearchClick
      end
      object RadioButtonImpExRef: TRadioButton
        Left = 2
        Top = 17
        Width = 80
        Height = 13
        Caption = 'Imp/Ex Ref'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = RadioButtonSearchClick
      end
    end
    object btnPrint: TBitBtn
      Left = 3
      Top = 62
      Width = 110
      Height = 22
      Caption = 'Print Count Sheet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnPrintClick
    end
    object CheckBox1: TCheckBox
      Left = 3
      Top = 84
      Width = 15
      Height = 17
      Caption = 'Show Counts entered'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object FBoxCnt: TComboBox
      Left = 266
      Top = 76
      Width = 175
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnCloseUp = FBoxCntCloseUp
      OnKeyDown = FBoxCntKeyDown
      OnKeyPress = FBoxCntKeyPress
      Items.Strings = (
        'Show All'
        'No Audit Entry'
        'Audit Entry = 0'
        'No Audit Entry or Entry = 0')
    end
    object FBoxSC: TComboBox
      Left = 266
      Top = 55
      Width = 175
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnCloseUp = FBoxSCCloseUp
      OnKeyDown = FBoxSCKeyDown
      OnKeyPress = FBoxSCKeyPress
    end
    object btnClearAudit: TBitBtn
      Left = 118
      Top = 62
      Width = 72
      Height = 36
      Caption = 'Clear Audit'#10'Counts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnClearAuditClick
    end
    object btnSaveChanges: TBitBtn
      Left = 789
      Top = 60
      Width = 134
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Save Changes'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnSaveChangesClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnAbandon: TBitBtn
      Left = 929
      Top = 60
      Width = 103
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Abandon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Kind = bkCancel
    end
    object btnCalculator: TBitBtn
      Left = 968
      Top = 8
      Width = 64
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'Calculator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnClick = btnCalculatorClick
      Glyph.Data = {
        06020000424D0602000000000000760000002800000019000000190000000100
        04000000000090010000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A00000000000
        000000000000AAAAAAAA0077777777777777777777700AAAAAAA007777777777
        7777777777070AAAAAAA0707777777777777777770770AAAAAAA070777777777
        7777777770770AAAAAAA0770777777777777777707770AAAAAAA077070000000
        0000000707770AAAAAAA0777077777777777777077770AAAAAAA0770FF7F7F7F
        7F7F7F7707770AAAAAAA0770F7F7F7F7F7F7F7F707770AAAAAAA0770F07F7F7F
        707F7F7707770AAAAAAA0770F0F7F7F7F0F7F7F707770AAAAAAA0770F07F7F7F
        707F7F7707770AAAAAAA0770F0F7F7F7F707F7F707770AAAAAAA0770F000007F
        7F0F7F7707770AAAAAAA0770F0F7F7F7F7F0F7F707770AAAAAAA0770F07F7F7F
        7F707F7707770AAAAAAA0770F0F7F7F7F7F707F707770AAAAAAA0770F000007F
        00000F7707770AAAAAAA0770F7F7F7F7F7F7F7F707770AAAAAAA0770FF7F7F7F
        7F7F7F7707770AAAAAAA07770FFFFFFFFFFFFFF077770AAAAAAA070070000000
        0000000700770AAAAAAA0077777777777777777777000AAAAAAAA00000000000
        000000000000AAAAAAAA}
      Layout = blGlyphBottom
      Margin = 3
      Spacing = 1
    end
    object btnWastage: TBitBtn
      Left = 895
      Top = 8
      Width = 70
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'Waste Adj.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnClick = btnWastageClick
      Glyph.Data = {
        06020000424D0602000000000000760000002800000019000000190000000100
        04000000000090010000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A00000000000
        000000000000AAAAAAAA0077777777777777777777700AAAAAAA007777777777
        7777777777070AAAAAAA0707777777777777777770770AAAAAAA070777777777
        7777777770770AAAAAAA0770777777777777777707770AAAAAAA077070000000
        0000000707770AAAAAAA0777077777777777777077770AAAAAAA0770FF7F7F7F
        7F7F7F7707770AAAAAAA0770F7F7F7F7F7F7F7F707770AAAAAAA0770F07F7F7F
        70007F7707770AAAAAAA0770F0F7F7F707F707F707770AAAAAAA0770F07F7F7F
        7F7F0F7707770AAAAAAA0770F0F7F7F7F7F707F707770AAAAAAA0770F000007F
        0F7F0F7707770AAAAAAA0770F0F7F7F70000F7F707770AAAAAAA0770F07F7F7F
        0F7F7F7707770AAAAAAA0770F0F7F7F707F7F7F707770AAAAAAA0770F000007F
        00000F7707770AAAAAAA0770F7F7F7F7F7F7F7F707770AAAAAAA0770FF7F7F7F
        7F7F7F7707770AAAAAAA07770FFFFFFFFFFFFFF077770AAAAAAA070070000000
        0000000700770AAAAAAA0077777777777777777777000AAAAAAAA00000000000
        000000000000AAAAAAAA}
      Layout = blGlyphBottom
      Margin = 3
      Spacing = 1
    end
    object wwSearch1: TwwIncrementalSearch
      Left = 198
      Top = 19
      Width = 245
      Height = 21
      DataSource = wwsAuditCur
      SearchField = 'Name'
      OnAfterSearch = wwSearch1AfterSearch
      MaxLength = 20
      TabOrder = 10
    end
    object EditImpExRefSearch: TEdit
      Left = 198
      Top = 19
      Width = 245
      Height = 21
      TabOrder = 12
      Visible = False
    end
    object pnlRO: TPanel
      Left = 807
      Top = 4
      Width = 226
      Height = 55
      Anchors = [akTop, akRight]
      TabOrder = 9
      Visible = False
      object Label6: TLabel
        Left = 1
        Top = 1
        Width = 224
        Height = 53
        Align = alClient
        Alignment = taCenter
        Caption = 
          'The "Complete Site" tab is Read-Only.'#13#10'Please type the Audit Cou' +
          'nts for each Count Location in its respective tab.'
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
    end
    object rbExpOnly: TRadioButton
      Left = 5
      Top = 23
      Width = 172
      Height = 17
      Caption = 'Show Expected Items Only'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      TabStop = True
      OnClick = rbExpOnlyClick
    end
    object rbAll: TRadioButton
      Left = 5
      Top = 40
      Width = 156
      Height = 17
      Caption = 'Show ALL items on the List'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 14
      OnClick = rbExpOnlyClick
    end
    object btnEditList: TBitBtn
      Left = 449
      Top = 55
      Width = 77
      Height = 39
      Caption = 'Edit'#10'List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = btnEditListClick
    end
    object rbMustCountOnly: TRadioButton
      Left = 5
      Top = 7
      Width = 182
      Height = 13
      Caption = '"Must Count" items only'
      TabOrder = 17
      OnClick = rbExpOnlyClick
    end
  end
  object locTabs: TPageControl
    Left = 0
    Top = 0
    Width = 1037
    Height = 24
    ActivePage = hzTab0
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    Images = data1.locTabsImgList
    ParentFont = False
    TabIndex = 0
    TabOrder = 2
    Visible = False
    OnChange = locTabsChange
    object hzTab0: TTabSheet
      Caption = 'Complete Site'
      ImageIndex = -1
    end
  end
  object wwsAuditCur: TwwDataSource
    DataSet = qryAuditLoc
    Left = 280
    Top = 48
  end
  object qryAuditLoc: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = qryAuditLocAfterOpen
    AfterEdit = qryAuditLocAfterEdit
    BeforePost = qryAuditLocBeforePost
    AfterPost = qryAuditLocAfterPost
    AfterScroll = qryAuditLocAfterScroll
    BeforeRefresh = qryAuditLocBeforeRefresh
    Parameters = <>
    SQL.Strings = (
      'select *  from AuditLocationsCur'
      ''
      'Order By RecID')
    Left = 248
    Top = 48
    object qryAuditLocEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object qryAuditLocSubCat: TStringField
      FieldName = 'SubCat'
    end
    object qryAuditLocImpExRef: TStringField
      FieldName = 'ImpExRef'
      Size = 15
    end
    object qryAuditLocName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 40
    end
    object qryAuditLocOpStk: TFloatField
      FieldName = 'OpStk'
      OnGetText = qryAuditLocOpStkGetText
      DisplayFormat = '0.##'
    end
    object qryAuditLocPurchStk: TFloatField
      FieldName = 'PurchStk'
      OnGetText = qryAuditLocOpStkGetText
      DisplayFormat = '0.##'
    end
    object qryAuditLocThRedQty: TFloatField
      FieldName = 'ThRedQty'
      OnGetText = qryAuditLocOpStkGetText
      DisplayFormat = '0.##'
    end
    object qryAuditLocThCloseStk: TFloatField
      FieldName = 'ThCloseStk'
      OnGetText = qryAuditLocOpStkGetText
      DisplayFormat = '0.##'
    end
    object qryAuditLocActCloseStk: TFloatField
      FieldName = 'ActCloseStk'
    end
    object qryAuditLocUnit: TStringField
      FieldName = 'Unit'
      Size = 10
    end
    object qryAuditLocPurchBaseU: TFloatField
      FieldName = 'PurchBaseU'
    end
    object qryAuditLocACount: TStringField
      Alignment = taRightJustify
      FieldName = 'ACount'
      Size = 9
    end
    object qryAuditLocWasteTill: TFloatField
      FieldName = 'WasteTill'
      OnGetText = qryAuditLocOpStkGetText
    end
    object qryAuditLocWastePC: TFloatField
      FieldName = 'WastePC'
      OnGetText = qryAuditLocOpStkGetText
    end
    object qryAuditLocWastage: TFloatField
      FieldName = 'Wastage'
      OnGetText = qryAuditLocOpStkGetText
    end
    object qryAuditLocWasteTillA: TFloatField
      FieldName = 'WasteTillA'
      OnGetText = qryAuditLocOpStkGetText
    end
    object qryAuditLocWastePCA: TFloatField
      FieldName = 'WastePCA'
      OnGetText = qryAuditLocOpStkGetText
    end
    object qryAuditLocLocationID: TSmallintField
      FieldName = 'LocationID'
    end
    object qryAuditLocShouldBe: TSmallintField
      FieldName = 'ShouldBe'
    end
    object qryAuditLocPurchCostPU: TFloatField
      FieldName = 'PurchCostPU'
    end
    object qryAuditLocNomPricePU: TFloatField
      FieldName = 'NomPricePU'
    end
    object qryAuditLocRecID: TIntegerField
      FieldName = 'RecID'
      OnGetText = qryAuditLocRecIDGetText
    end
    object qryAuditLocIsPurchUnit: TBooleanField
      FieldName = 'IsPurchUnit'
    end
    object qryAuditLocMustCount: TBooleanField
      FieldName = 'MustCount'
    end
  end
  object RxCalculator1: TRxCalculator
    Precision = 10
    Left = 448
    Top = 376
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = wwsAuditCur
    SearchField = 'Name'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 504
  end
  object Op1: TOpenDialog
    Filter = 'Audit Count Files (*.STKA)|*.STKA|All Files (*.*)|*.*'
    FilterIndex = 0
    Title = 'Choose an Audit Count file to import:'
    Left = 560
    Top = 208
  end
  object Save1: TSaveDialog
    Filter = 'Audit Count Files (*.STKA)|*.STKA|All Files (*.*)|*.*'
    FilterIndex = 0
    Title = 'Save Audit Counts to file'
    Left = 600
    Top = 208
  end
  object adoqImpExRefSearch: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'ImpExRef'
        DataType = ftString
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @ImpExRefPattern varchar(20)'
      ''
      'SET @ImpExRefPattern = :ImpExRef'
      'SET @ImpExRefPattern = '#39'%'#39' + @ImpExRefPattern + '#39'%'#39
      ''
      'SELECT distinct ac.EntityCode,ac.[SubCat], ac.[Name]'
      'FROM PurchaseUnits pu'
      'JOIN (AuditCurSubExpr) ac'
      'ON    pu.[Entity Code] = ac.EntityCode'
      '  AND pu.[Import/Export Reference] like @ImpExRefPattern'
      'ORDER BY ac.[SubCat], ac.[Name]')
    Left = 260
    Top = 368
  end
end
