object fAudit: TfAudit
  Left = 213
  Top = 83
  Width = 1047
  Height = 544
  HelpContext = 1008
  Caption = 'Audit Stock - Fill in the Stock Count for each item'
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 920
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
    Width = 1031
    Height = 377
    PictureMasks.Strings = (
      
        'ActCloseStk'#9'{{{#[#][#][#][#][#][{.#[#],/{0,1[{0,1}],2,3,4,5,6,7,' +
        '8,9}}]},.#[#],0/{0,1[{0,1}],2,3,4,5,6,7,8,9,10,11}}}'#9'F'#9'T')
    Selected.Strings = (
      'SubCat'#9'20'#9'Sub Category'#9'F'
      'Name'#9'40'#9'Name'#9'F'
      'ImpExRef'#9'20'#9'ImpExRef'#9'F'
      'PurchUnit'#9'11'#9'Unit'#9'F'
      'OpStk'#9'11'#9'Open Stk'#9'F'
      'PurchStk'#9'11'#9'Purch/Transf'#9'F'
      'ThRedQty'#9'10'#9'Th. Reduct.'#9'F'
      'ThCloseStk'#9'10'#9'Th. Close Stk'#9'F'
      'Wastage'#9'11'#9'Wastage'#9'F'
      'ActCloseStk'#9'13'#9'Audit Stk'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = wwGrid1RowChanged
    FixedCols = 8
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
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = wwGrid1CalcCellColors
    OnExit = wwGrid1Exit
    OnKeyDown = wwGrid1KeyDown
    PaintOptions.ActiveRecordColor = clHighlight
  end
  object Panel1: TPanel
    Left = 0
    Top = 401
    Width = 1031
    Height = 104
    Align = alBottom
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    TabOrder = 1
    DesignSize = (
      1031
      104)
    object Bevel3: TBevel
      Left = 194
      Top = 51
      Width = 335
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
      Top = 87
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
      OnDblClick = Label5DblClick
    end
    object Bevel4: TBevel
      Left = 99
      Top = 63
      Width = 17
      Height = 42
      Shape = bsRightLine
      Style = bsRaised
    end
    object Bevel2: TBevel
      Left = 2
      Top = 62
      Width = 189
      Height = 7
      Shape = bsTopLine
      Style = bsRaised
    end
    object lblFormat: TLabel
      Left = 785
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
    object Bevel5: TBevel
      Left = 194
      Top = 8
      Width = 335
      Height = 37
      Shape = bsFrame
      Style = bsRaised
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
    object CheckBox1: TCheckBox
      Left = 3
      Top = 86
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
      Width = 257
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
      Width = 257
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnCloseUp = FBoxSCCloseUp
      OnKeyDown = FBoxSCKeyDown
      OnKeyPress = FBoxSCKeyPress
    end
    object rbExpOnly: TRadioButton
      Left = 5
      Top = 18
      Width = 184
      Height = 14
      Caption = 'Holding Zone Expected Items only'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      TabStop = True
      OnClick = rbExpOnlyClick
    end
    object rbExpSite: TRadioButton
      Left = 5
      Top = 37
      Width = 182
      Height = 14
      Caption = 'Also show Site Expected Items'
      TabOrder = 5
      OnClick = rbExpOnlyClick
    end
    object rbAll: TRadioButton
      Left = 5
      Top = 45
      Width = 113
      Height = 14
      Caption = 'Show ALL items'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      OnClick = rbExpOnlyClick
    end
    object btnClearAudit: TBitBtn
      Left = 118
      Top = 66
      Width = 72
      Height = 36
      Caption = 'Clear Audit'#10'Counts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btnClearAuditClick
    end
    object btnSaveChanges: TBitBtn
      Left = 785
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
      TabOrder = 8
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
      Left = 924
      Top = 60
      Width = 102
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Abandon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      Kind = bkCancel
    end
    object btnMultiUnit: TBitBtn
      Left = 894
      Top = 8
      Width = 64
      Height = 46
      Anchors = [akTop, akRight]
      Caption = 'Multi Unit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      TabStop = False
      OnClick = btnMultiUnitClick
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
        00007F7707770AAAAAAA0770F0F7F7F0F7F707F707770AAAAAAA0770F07F7F70
        7F7F0F7707770AAAAAAA0770F0F7F7F0F7F707F707770AAAAAAA0770F0000070
        0F7F0F7707770AAAAAAA0770F0F7F7F0F000F7F707770AAAAAAA0770F07F7F70
        7F7F7F7707770AAAAAAA0770F0F7F7F0F7F707F707770AAAAAAA0770F000007F
        00007F7707770AAAAAAA0770F7F7F7F7F7F7F7F707770AAAAAAA0770FF7F7F7F
        7F7F7F7707770AAAAAAA07770FFFFFFFFFFFFFF077770AAAAAAA070070000000
        0000000700770AAAAAAA0077777777777777777777000AAAAAAAA00000000000
        000000000000AAAAAAAA}
      Layout = blGlyphBottom
      Margin = 3
      Spacing = 1
    end
    object btnCalculator: TBitBtn
      Left = 963
      Top = 8
      Width = 64
      Height = 46
      Anchors = [akTop, akRight]
      Caption = 'Calculator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
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
      Left = 806
      Top = 8
      Width = 83
      Height = 46
      Anchors = [akTop, akRight]
      Caption = 'Wastage Adj.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
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
    object pnlRO: TPanel
      Left = 803
      Top = 6
      Width = 224
      Height = 49
      Anchors = [akTop, akRight]
      TabOrder = 13
      Visible = False
      object Label6: TLabel
        Left = 1
        Top = 1
        Width = 222
        Height = 47
        Align = alClient
        Alignment = taCenter
        Caption = 
          'The "Complete Site" tab is Read-Only.'#13#10'Please type the Audit Cou' +
          'nts for each Holding Zone in its respective tab.'
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
    object btnAutoFill: TBitBtn
      Left = 657
      Top = 8
      Width = 122
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Fill blank Counts'#10'with Theo Closing'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = btnAutoFillClick
    end
    object btnImpCounts: TBitBtn
      Left = 657
      Top = 63
      Width = 57
      Height = 32
      Hint = 'Import Audit Counts'
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      Visible = False
      OnClick = btnImpCountsClick
      Glyph.Data = {
        56080000424D560800000000000036040000280000002B000000180000000100
        08000000000020040000330B0000330B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000000330033003300660033009900
        3300CC003300FF00330000006600330066006600660099006600CC006600FF00
        660000009900330099006600990099009900CC009900FF0099000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000000FF003300FF006600FF009900
        FF00CC00FF00FF00FF0000330000333300006633000099330000CC330000FF33
        000000333300333333006633330099333300CC333300FF333300003366003333
        66006633660099336600CC336600FF3366000033990033339900663399009933
        9900CC339900FF3399000033CC003333CC006633CC009933CC00CC33CC00FF33
        CC000033FF003333FF006633FF009933FF00CC33FF00FF33FF00006600003366
        00006666000099660000CC660000FF6600000066330033663300666633009966
        3300CC663300FF66330000666600336666006666660099666600CC666600FF66
        660000669900336699006666990099669900CC669900FF6699000066CC003366
        CC006666CC009966CC00CC66CC00FF66CC000066FF003366FF006666FF009966
        FF00CC66FF00FF66FF0000990000339900006699000099990000CC990000FF99
        000000993300339933006699330099993300CC993300FF993300009966003399
        66006699660099996600CC996600FF9966000099990033999900669999009999
        9900CC999900FF9999000099CC003399CC006699CC009999CC00CC99CC00FF99
        CC000099FF003399FF006699FF009999FF00CC99FF00FF99FF0000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000CC330033CC330066CC330099CC
        3300CCCC3300FFCC330000CC660033CC660066CC660099CC6600CCCC6600FFCC
        660000CC990033CC990066CC990099CC9900CCCC9900FFCC990000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000CCFF0033CCFF0066CCFF0099CC
        FF00CCCCFF00FFCCFF0000FF000033FF000066FF000099FF0000CCFF0000FFFF
        000000FF330033FF330066FF330099FF3300CCFF3300FFFF330000FF660033FF
        660066FF660099FF6600CCFF6600FFFF660000FF990033FF990066FF990099FF
        9900CCFF9900FFFF990000FFCC0033FFCC0066FFCC0099FFCC00CCFFCC00FFFF
        CC0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4000000000000000000
        000000B4B400B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B481B2D7D7D7D7D7D7D7D7D7AC8100B400B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B481B2565656565656565656AC81560000B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B481B2B2ACACAC
        ACACACACACAC81560000B4B4B40000000000B4B4B4B4B4B4000000B4B4B4B4B4
        B4B4B4B4B4B481B2B2B2ACACACACACB46CAC81560000B400007D595905050000
        B4B4B400D7D700B4B4B4B4B4B4B4B4B4B4B481D7D7D7D7D7D7D7D7D7D7D78156
        0000007DB97D59590505050500B400D71ED700B4B4B4B4B4B4B4B4B4B4B4B481
        B2B2ACACAC818181818181560000007DB97D5959050505050000D71E1ED70000
        000000000000000000000000565656565656565656565656B400007DB9AD5959
        0505050500D71E1E1ED7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D700B4B4B4B4B4
        B4B4B4B4B400007D590000000000057DD71E1E1E1E1E1E1E1E1E1E1E1E1E1E1E
        1E1E1E1E1E1ED7000000000000B4B4B4B40000000059595905057DD71E1E1E1E
        D71E1ED71E1E1E1E1ED71E1ED71E1E1E1E1ED7D7D7D7D7D700B4B4B4B400007D
        B9AD7D59057DD71E1E1E1E1ED71E1ED71E1E1E1E1ED71E1ED71E1E1E1E1ED705
        050505D7000000B4B400007D590000007DD71E1E1E1E1E1ED71E1ED71E1E1E1E
        1ED71E1ED71E1E1E1E1ED7D7D7D7D7D700D700B4B400000000597D7DD71E1E1E
        1E1E1E1ED71E1ED71E1ED71E1ED71E1ED7D7D7D71E1ED705050505D700D70000
        000000ADD7AD7D597DD71E1E1E1E1E1ED71E1ED71ED71ED71ED71E1ED71E1E1E
        D71ED7D7D7D7D7D700D700D7000000AD59000000007DD71E1E1E1E1ED71E1ED7
        D71E1E1ED7D71E1ED71E1E1ED71ED705050505D700D700D70000000000597D59
        05057DD71E1E1E1ED71E1ED71E1E1E1E1ED71E1ED7D7D7D71E1ED7D7D7D7D7D7
        00D700D7000000ADD7AD7D590505057DD71E1E1E1E1E1E1E1E1E1E1E1E1E1E1E
        1E1E1E1E1E1ED705050505D700D700D7000000ADD7AD7D590505050500D71E1E
        1ED7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D700D700D7000000AD
        59000000000005050000D71E1ED7000000000000000000000000000000000000
        0000000000D700D7000000000059AD050505000000B400D71ED700B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B400D7D7D7D7D7D700D70000007DB9D7D77D05050505
        00B4B400D7D700B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B40000000000000000D7
        0000B400007DD77D05050000B4B4B4B4000000B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B400D7D7D7D7D7D70000B4B4B40000000000B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4000000000000000000}
      Spacing = 1
    end
    object btnExpCounts: TBitBtn
      Left = 722
      Top = 63
      Width = 57
      Height = 32
      Hint = 'Export Audit Counts'
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      Visible = False
      OnClick = btnExpCountsClick
      Glyph.Data = {
        56080000424D560800000000000036040000280000002B000000180000000100
        08000000000020040000330B0000330B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000000330033003300660033009900
        3300CC003300FF00330000006600330066006600660099006600CC006600FF00
        660000009900330099006600990099009900CC009900FF0099000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000000FF003300FF006600FF009900
        FF00CC00FF00FF00FF0000330000333300006633000099330000CC330000FF33
        000000333300333333006633330099333300CC333300FF333300003366003333
        66006633660099336600CC336600FF3366000033990033339900663399009933
        9900CC339900FF3399000033CC003333CC006633CC009933CC00CC33CC00FF33
        CC000033FF003333FF006633FF009933FF00CC33FF00FF33FF00006600003366
        00006666000099660000CC660000FF6600000066330033663300666633009966
        3300CC663300FF66330000666600336666006666660099666600CC666600FF66
        660000669900336699006666990099669900CC669900FF6699000066CC003366
        CC006666CC009966CC00CC66CC00FF66CC000066FF003366FF006666FF009966
        FF00CC66FF00FF66FF0000990000339900006699000099990000CC990000FF99
        000000993300339933006699330099993300CC993300FF993300009966003399
        66006699660099996600CC996600FF9966000099990033999900669999009999
        9900CC999900FF9999000099CC003399CC006699CC009999CC00CC99CC00FF99
        CC000099FF003399FF006699FF009999FF00CC99FF00FF99FF0000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000CC330033CC330066CC330099CC
        3300CCCC3300FFCC330000CC660033CC660066CC660099CC6600CCCC6600FFCC
        660000CC990033CC990066CC990099CC9900CCCC9900FFCC990000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000CCFF0033CCFF0066CCFF0099CC
        FF00CCCCFF00FFCCFF0000FF000033FF000066FF000099FF0000CCFF0000FFFF
        000000FF330033FF330066FF330099FF3300CCFF3300FFFF330000FF660033FF
        660066FF660099FF6600CCFF6600FFFF660000FF990033FF990066FF990099FF
        9900CCFF9900FFFF990000FFCC0033FFCC0066FFCC0099FFCC00CCFFCC00FFFF
        CC0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4000000000000000000
        000000B4B400B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B481B2D7D7D7D7D7D7D7D7D7AC8100B400B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B481B2565656565656565656AC81560000B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B481B2B2ACACAC
        ACACACACACAC81560000B4B4B40000000000B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        000000ACB4B481B2B2B2ACACACACACB46CAC81560000B400007D595905050000
        B4B4B4B4B4B4B4B4B4B4B4B400D7D700ACB481D7D7D7D7D7D7D7D7D7D7D78156
        0000007DB97D59590505050500B4B4B4B4B4B4B4B4B4B4B400D76CD700ACB481
        B2B2ACACAC818181818181560000007DB97D5959050500000000000000000000
        0000000000D76C6CD700ACB4565656565656565656565656B400007DB9AD5959
        0505D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D76C6C6CD700ACB4B4B4B4B4B4B4B4
        B4B4B4B4B400007D590000000000D76C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C
        6C6CD700AC0000000000000000B4B4B4B4000000005959590505D76CD7D7D7D7
        6CD76C6C6CD76CD76C6C6C6C6C6C6CD700ACD7D7D7D7D7D700B4B4B4B400007D
        B9AD7D590505D76CD76C6C6C6C6CD76CD76C6CD76C6C6C6C6C6C6C6CD700ACD7
        050505D7000000B4B400007D590000000000D76CD76C6C6C6C6C6CD76C6C6CD7
        6C6C6C6C6C6C6C6C6CD700ACD7D7D7D700D700B4B400000000597D590505D76C
        D7D7D76C6C6C6CD76C6C6CD7D7D7D76C6C6C6C6C6C6CD700AC0505D700D70000
        000000ADD7AD7D590505D76CD76C6C6C6C6C6CD76C6C6CD76C6C6CD76C6C6C6C
        6CD700ACD7D7D7D700D700D7000000AD590000000000D76CD76C6C6C6C6CD76C
        D76C6CD76C6C6CD76C6C6C6CD700ACD7050505D700D700D70000000000597D59
        0505D76CD7D7D7D76CD76C6C6CD76CD7D7D7D76C6C6C6CD700ACD7D7D7D7D7D7
        00D700D7000000ADD7AD7D590505D76C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C
        6C6CD700AC00D705050505D700D700D7000000ADD7AD7D590505D7D7D7D7D7D7
        D7D7D7D7D7D7D7D7D7D76C6C6CD700ACB400D7D7D7D7D7D700D700D7000000AD
        590000000000000000000000000000000000000000D76C6CD700ACB4B4000000
        0000000000D700D7000000000059AD050505000000B4B4B4B4B4B4B4B4B4B4B4
        00D76CD700ACB4B4B4B4B400D7D7D7D7D7D700D70000007DB9D7D77D05050505
        00B4B4B4B4B4B4B4B4B4B4B400D7D700ACB4B4B4B4B4B40000000000000000D7
        0000B400007DD77D05050000B4B4B4B4B4B4B4B4B4B4B4B4000000ACB4B4B4B4
        B4B4B4B4B400D7D7D7D7D7D70000B4B4B40000000000B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4000000000000000000}
    end
    object wwSearch1: TwwIncrementalSearch
      Left = 198
      Top = 19
      Width = 247
      Height = 21
      DataSource = wwsAuditCur
      SearchField = 'Name'
      OnAfterSearch = wwSearch1AfterSearch
      MaxLength = 20
      TabOrder = 17
    end
    object PanelRadioButtonSearch: TPanel
      Left = 446
      Top = 13
      Width = 79
      Height = 29
      BevelOuter = bvNone
      TabOrder = 18
      object RadioButtonName: TRadioButton
        Left = 1
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
        Left = 1
        Top = 15
        Width = 72
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
    object EditImpExRefSearch: TEdit
      Left = 198
      Top = 19
      Width = 246
      Height = 21
      TabOrder = 19
      Visible = False
    end
    object rbMustCountOnly: TRadioButton
      Left = 5
      Top = 9
      Width = 182
      Height = 13
      Caption = '"Must Count" items only'
      TabOrder = 20
      OnClick = rbExpOnlyClick
    end
    object btnPrint: TBitBtn
      Left = 3
      Top = 66
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
  end
  object hzTabs: TPageControl
    Left = 0
    Top = 0
    Width = 1031
    Height = 24
    ActivePage = hzTab0
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    Images = data1.hzTabsImgList
    ParentFont = False
    TabIndex = 0
    TabOrder = 2
    Visible = False
    OnChange = hzTabsChange
    object hzTab0: TTabSheet
      Caption = 'Complete Site'
      ImageIndex = -1
    end
  end
  object wwsAuditCur: TwwDataSource
    DataSet = wwtAuditCur
    Left = 280
    Top = 48
  end
  object wwtAuditCur: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = wwtAuditCurAfterOpen
    AfterEdit = wwtAuditCurAfterEdit
    BeforePost = wwtAuditCurBeforePost
    AfterPost = wwtAuditCurAfterPost
    AfterScroll = wwtAuditCurAfterScroll
    BeforeRefresh = wwtAuditCurBeforeRefresh
    Parameters = <>
    SQL.Strings = (
      'select *  from AuditCur'
      ''
      'Order By "SubCat", "Name"')
    Left = 248
    Top = 48
    object wwtAuditCurEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object wwtAuditCurSubCat: TStringField
      FieldName = 'SubCat'
    end
    object wwtAuditCurImpExRef: TStringField
      FieldName = 'ImpExRef'
      Size = 15
    end
    object wwtAuditCurName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 40
    end
    object wwtAuditCurOpStk: TFloatField
      FieldName = 'OpStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurPurchStk: TFloatField
      FieldName = 'PurchStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurThRedQty: TFloatField
      FieldName = 'ThRedQty'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurThCloseStk: TFloatField
      FieldName = 'ThCloseStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurActCloseStk: TFloatField
      FieldName = 'ActCloseStk'
    end
    object wwtAuditCurPurchUnit: TStringField
      FieldName = 'PurchUnit'
      Size = 10
    end
    object wwtAuditCurPurchBaseU: TFloatField
      FieldName = 'PurchBaseU'
    end
    object wwtAuditCurACount: TStringField
      Alignment = taRightJustify
      FieldName = 'ACount'
      Size = 9
    end
    object wwtAuditCurWasteTill: TFloatField
      FieldName = 'WasteTill'
      OnGetText = wwtAuditCurOpStkGetText
    end
    object wwtAuditCurWastePC: TFloatField
      FieldName = 'WastePC'
      OnGetText = wwtAuditCurOpStkGetText
    end
    object wwtAuditCurWastage: TFloatField
      FieldName = 'Wastage'
      OnGetText = wwtAuditCurOpStkGetText
    end
    object wwtAuditCurWasteTillA: TFloatField
      FieldName = 'WasteTillA'
      OnGetText = wwtAuditCurOpStkGetText
    end
    object wwtAuditCurWastePCA: TFloatField
      FieldName = 'WastePCA'
      OnGetText = wwtAuditCurOpStkGetText
    end
    object wwtAuditCurHzID: TSmallintField
      FieldName = 'HzID'
    end
    object wwtAuditCurMoveQty: TFloatField
      FieldName = 'MoveQty'
    end
    object wwtAuditCurShouldBe: TSmallintField
      FieldName = 'ShouldBe'
    end
    object wwtAuditCurPurchCostPU: TFloatField
      FieldName = 'PurchCostPU'
    end
    object wwtAuditCurNomPricePU: TFloatField
      FieldName = 'NomPricePU'
    end
    object wwtAuditCurMustCount: TBooleanField
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
