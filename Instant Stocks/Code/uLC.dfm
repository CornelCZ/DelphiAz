object fLC: TfLC
  Left = 545
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Line Checks'
  ClientHeight = 644
  ClientWidth = 965
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlProds: TPanel
    Left = 154
    Top = 4
    Width = 805
    Height = 529
    HelpContext = 1037
    TabOrder = 1
    DesignSize = (
      805
      529)
    object Bevel1: TBevel
      Left = 613
      Top = 381
      Width = 179
      Height = 68
      Shape = bsFrame
      Style = bsRaised
      Visible = False
    end
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 803
      Height = 19
      Align = alTop
      AutoSize = False
      Caption = ' Choose the Products for this Line Check '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlBottom
    end
    object Label9: TLabel
      Left = 172
      Top = 30
      Width = 113
      Height = 13
      Alignment = taCenter
      Caption = 'Incremental search:'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Bevel3: TBevel
      Left = 613
      Top = 32
      Width = 179
      Height = 112
      Shape = bsFrame
      Style = bsRaised
    end
    object Label11: TLabel
      Left = 618
      Top = 26
      Width = 70
      Height = 13
      Caption = ' Grid Filters '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 622
      Top = 42
      Width = 51
      Height = 13
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 622
      Top = 85
      Width = 77
      Height = 13
      Caption = 'Sub-Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSelectStatus1: TLabel
      Left = 617
      Top = 454
      Width = 169
      Height = 35
      Alignment = taCenter
      AutoSize = False
      Caption = '455 items selected'
      Color = clRed
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 617
      Top = 390
      Width = 171
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'Label5'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      Visible = False
    end
    object Label4: TLabel
      Left = 618
      Top = 375
      Width = 128
      Height = 13
      Caption = ' Now using Template: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 2
      Top = 29
      Width = 164
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 'Click on a Field Title to order grid'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object lblSelectStatus2: TLabel
      Left = 617
      Top = 472
      Width = 169
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '(including 255 mandatory)'
      Color = clRed
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object wwIncrementalSearch2: TwwIncrementalSearch
      Left = 286
      Top = 25
      Width = 247
      Height = 21
      DataSource = dsProds
      SearchField = 'PurN'
      TabOrder = 0
    end
    object lookCat: TComboBox
      Left = 622
      Top = 55
      Width = 155
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
      OnCloseUp = lookCatCloseUp
    end
    object lookSCat: TComboBox
      Left = 622
      Top = 99
      Width = 155
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
      OnCloseUp = lookSCatCloseUp
    end
    object cbAWonly: TCheckBox
      Left = 618
      Top = 125
      Width = 171
      Height = 16
      Caption = 'Only items selected for LC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cbAWonlyClick
    end
    object BitBtn11: TBitBtn
      Left = 617
      Top = 495
      Width = 73
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 5
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnNext: TBitBtn
      Left = 697
      Top = 495
      Width = 89
      Height = 25
      Caption = 'Next'
      TabOrder = 6
      OnClick = btnNextClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
        AAAAAAAAAAAAAAAAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA800
        8AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAA8008AA
        8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008
        AAAAA8008AA8008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}
      Layout = blGlyphRight
    end
    object BitBtn17: TBitBtn
      Left = 613
      Top = 264
      Width = 179
      Height = 32
      Caption = 'Copy last Line Check Selection'
      TabOrder = 7
      OnClick = BitBtn17Click
    end
    object BitBtn18: TBitBtn
      Left = 613
      Top = 336
      Width = 179
      Height = 32
      Caption = 'Save Selection as New Template'
      TabOrder = 8
      OnClick = BitBtn18Click
    end
    object BitBtn19: TBitBtn
      Left = 613
      Top = 300
      Width = 179
      Height = 32
      Caption = 'Copy from Selection Template'
      TabOrder = 9
      OnClick = BitBtn19Click
    end
    object BitBtn20: TBitBtn
      Left = 630
      Top = 185
      Width = 144
      Height = 32
      Caption = 'Select All'
      TabOrder = 10
      OnClick = BitBtn20Click
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA00000000
        00008AAAAAAAAAAA08FFF99FFFF08AAAAAAAAAAA08FF9998FFF08AAAAAAAAAAA
        08F99999FFF08AAAAAAAAAAA089998998FF08AAAAAAAAAAA08998F999FF08AAA
        AAAAAAAA08FFF8888888888888AAAAAA08FFF0000000000008AA888808FFF08F
        FF99FFFF08AA000008FFF08FF9998FFF08AA08FF0888808F99999FFF08AA08FF
        00000089998998FF08AA08F99999F08998F999FF08AA08999899808FFFF899FF
        08AA08998F99908FFFFF998F08AA08FFFF89908FFFFF999F08AA08FFFFF9908F
        FFFF899908AA08FFFFF990888888889998AA08FFFFF890000000000999AA0888
        888889998AAAAAAA99AA0000000000999AAAAAAAAAAAAAAAAAAAAAA99AAAAAAA
        AAAA}
    end
    object BitBtn21: TBitBtn
      Left = 630
      Top = 221
      Width = 144
      Height = 32
      Caption = 'Select None'
      TabOrder = 11
      OnClick = BitBtn21Click
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA00000000
        00008AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA
        08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAA
        AAAAAAAA08FFF8888888888888AAAAAA08FFF0000000000008AA888808FFF08F
        FFFFFFFF08AA000008FFF08FFFFFFFFF08AA08FF0888808FFFFFFFFF08AA08FF
        0000008FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF
        08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08F
        FFFFFFFF08AA08FFFFFFF0888888888808AA08FFFFFFF000000000000AAA0888
        888888808AAAAAAAAAAA000000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        AAAA}
    end
    object BitBtn3: TBitBtn
      Left = 624
      Top = 412
      Width = 157
      Height = 31
      Caption = 'Save Changes of Template'
      TabOrder = 12
      Visible = False
      OnClick = BitBtn3Click
    end
    object pnlHZprods: TPanel
      Left = 286
      Top = 0
      Width = 517
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 13
      object lblHZname: TLabel
        Left = 5
        Top = 6
        Width = 333
        Height = 13
        Caption = 'For Holding Zone: QWERTYUUIOPLKJHhgfdsazxcvbnmpw'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Image1: TImage
        Left = 344
        Top = 1
        Width = 30
        Height = 21
        Center = True
        Transparent = True
      end
    end
    object wwDBGrid1: TwwDBGrid
      Left = 0
      Top = 44
      Width = 606
      Height = 483
      ControlType.Strings = (
        'doLC;CheckBox;True;False')
      Selected.Strings = (
        'Cat'#9'22'#9'Category'#9'F'
        'Sub'#9'22'#9'Sub-Category'#9'F'
        'PurN'#9'40'#9'Name'#9'F'
        'doLC'#9'1'#9'Selected'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 4
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      DataSource = dsProds
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = [dgEnterToTab]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnCalcCellColors = wwDBGrid1CalcCellColors
      OnCalcTitleAttributes = wwDBGrid1CalcTitleAttributes
      OnTitleButtonClick = wwDBGrid1TitleButtonClick
      OnExit = wwDBGrid1Exit
      OnKeyPress = wwDBGrid1KeyPress
      OnMouseUp = wwDBGrid1MouseUp
      PaintOptions.ActiveRecordColor = clHighlight
    end
    object BitBtn1: TBitBtn
      Left = 613
      Top = 151
      Width = 179
      Height = 29
      Caption = 'Add New Item'
      TabOrder = 14
      OnClick = BitBtn1Click
    end
  end
  object pnlThread: TPanel
    Left = 8
    Top = 360
    Width = 385
    Height = 281
    HelpContext = 1036
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 383
      Height = 26
      Align = alTop
      AutoSize = False
      Caption = '  Choose a Division'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object wwDBGrid2: TwwDBGrid
      Left = 1
      Top = 27
      Width = 383
      Height = 171
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsThreads
      KeyOptions = [dgEnterToTab]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
    end
    object pnlHZ: TPanel
      Left = 1
      Top = 198
      Width = 383
      Height = 41
      Align = alBottom
      TabOrder = 1
      Visible = False
      object Label7: TLabel
        Left = 3
        Top = 3
        Width = 134
        Height = 33
        Alignment = taCenter
        AutoSize = False
        Caption = 'Select a Holding Zone for this Line Check'
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
      object Label8: TLabel
        Left = 139
        Top = 3
        Width = 191
        Height = 13
        AutoSize = False
        Caption = 'Currently Selected Holding Zone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoHZs: TLabel
        Left = 1
        Top = 1
        Width = 381
        Height = 39
        Align = alClient
        Alignment = taCenter
        Caption = 
          'Line Checks cannot be done for Division "FOOD" because the Last ' +
          'Accepted Inventory was by Holding Zone and this Site does not ha' +
          've a VALID Holding Zone setup at present'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object comboHZ: TComboBox
        Left = 139
        Top = 16
        Width = 198
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'comboHZ'
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 239
      Width = 383
      Height = 41
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        383
        41)
      object BitBtn14: TBitBtn
        Left = 193
        Top = 4
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
        OnClick = btnCancelClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object BitBtn10: TBitBtn
        Left = 280
        Top = 4
        Width = 97
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Next'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn10Click
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
          AAAAAAAAAAAAAAAAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA800
          8AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAA8008AA
          8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008
          AAAAA8008AA8008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}
        Layout = blGlyphRight
      end
    end
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    SearchField = 'Name'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 136
    Top = 72
  end
  object adoqRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 120
    Top = 40
  end
  object dsProds: TwwDataSource
    DataSet = adotProds
    Left = 40
    Top = 48
  end
  object adotProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filtered = True
    AfterOpen = adotProdsAfterOpen
    BeforePost = adotProdsBeforePost
    AfterPost = adotProdsAfterPost
    IndexFieldNames = 'Cat;Sub;PurN'
    TableName = 'stkLCProds'
    Left = 8
    Top = 48
  end
  object adoqThreads: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqThreadsAfterScroll
    AfterScroll = adoqThreadsAfterScroll
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'select b.tid, b.tname, a.division, a.byHZ, a.baseDT, a.baseBsDat' +
        'e,'
      'b.dozForm, b.gallForm'
      'from Threads b, '
      
        '(select division, max(basetid) as basetid, max(baseDT) as baseDT' +
        ', max(baseBsDate) as baseBsDate,'
      
        '   (CASE max(hzid) WHEN 0 THEN 0 ELSE 1 END) as byHZ from stkECL' +
        'evel group by division) a'
      'where a.basetid = b.tid'
      'order by a.division')
    Left = 8
    Top = 12
    object adoqThreadsdivision: TStringField
      DisplayLabel = 'Division'
      DisplayWidth = 20
      FieldName = 'division'
    end
    object adoqThreadsbaseBsDate: TDateTimeField
      DisplayLabel = 'Base Bs. Date'
      DisplayWidth = 11
      FieldName = 'baseBsDate'
    end
    object adoqThreadsbaseDT: TDateTimeField
      DisplayLabel = 'Base Date/Time'
      DisplayWidth = 18
      FieldName = 'baseDT'
    end
    object adoqThreadsbyHZ: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'By HZ'
      DisplayWidth = 5
      FieldName = 'byHZ'
      OnGetText = adoqThreadsbyHZGetText
    end
    object adoqThreadstid: TSmallintField
      DisplayWidth = 10
      FieldName = 'tid'
      Visible = False
    end
    object adoqThreadstname: TStringField
      DisplayWidth = 30
      FieldName = 'tname'
      Visible = False
      Size = 30
    end
    object adoqThreadsdozForm: TStringField
      DisplayWidth = 1
      FieldName = 'dozForm'
      Visible = False
      Size = 1
    end
    object adoqThreadsgallForm: TStringField
      DisplayWidth = 1
      FieldName = 'gallForm'
      Visible = False
      Size = 1
    end
  end
  object dsThreads: TwwDataSource
    DataSet = adoqThreads
    Left = 40
    Top = 12
  end
  object adoqCount: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT ac.*, lcp.IsPreparedItem'
      
        'FROM AuditCur ac JOIN stkLCProds lcp ON ac.EntityCode = lcp.Enti' +
        'tyCode'
      'ORDER BY ac.SubCat, ac.Name')
    Left = 8
    Top = 96
  end
  object dsCount: TwwDataSource
    DataSet = adoqCount
    Left = 39
    Top = 101
  end
  object pipeCount: TppBDEPipeline
    DataSource = dsCount
    UserName = 'pipeCount'
    Left = 72
    Top = 96
    object pipeCountppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'EntityCode'
      FieldName = 'EntityCode'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 0
      Position = 0
    end
    object pipeCountppField2: TppField
      FieldAlias = 'SubCat'
      FieldName = 'SubCat'
      FieldLength = 20
      DisplayWidth = 20
      Position = 1
    end
    object pipeCountppField3: TppField
      FieldAlias = 'ImpExRef'
      FieldName = 'ImpExRef'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object pipeCountppField4: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 20
      DisplayWidth = 20
      Position = 3
    end
    object pipeCountppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'OpStk'
      FieldName = 'OpStk'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 4
    end
    object pipeCountppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'PurchStk'
      FieldName = 'PurchStk'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 5
    end
    object pipeCountppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'ThRedQty'
      FieldName = 'ThRedQty'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object pipeCountppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'ThCloseStk'
      FieldName = 'ThCloseStk'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 7
    end
    object pipeCountppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'ActCloseStk'
      FieldName = 'ActCloseStk'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object pipeCountppField10: TppField
      FieldAlias = 'PurchUnit'
      FieldName = 'PurchUnit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 9
    end
    object pipeCountppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'PurchBaseU'
      FieldName = 'PurchBaseU'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 10
    end
    object pipeCountppField12: TppField
      FieldAlias = 'ACount'
      FieldName = 'ACount'
      FieldLength = 9
      DisplayWidth = 9
      Position = 11
    end
    object pipeCountppField13: TppField
      Alignment = taRightJustify
      FieldAlias = 'WasteTill'
      FieldName = 'WasteTill'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 12
    end
    object pipeCountppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'WastePC'
      FieldName = 'WastePC'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 13
    end
    object pipeCountppField15: TppField
      Alignment = taRightJustify
      FieldAlias = 'WasteTillA'
      FieldName = 'WasteTillA'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 14
    end
    object pipeCountppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'WastePCA'
      FieldName = 'WastePCA'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 15
    end
    object pipeCountppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'Wastage'
      FieldName = 'Wastage'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 16
    end
  end
  object ppCount: TppReport
    AutoStop = False
    DataPipeline = pipeCount
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppS_Prep'
    PrinterSetup.PaperName = 'Letter (8.5 x 11 in)'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    ArchiveFileName = 'Aud.raf'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppCountPreviewFormCreate
    Left = 104
    Top = 104
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeCount'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 27252
      mmPrintPosition = 0
      object ppShape3: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 50006
        mmTop = 3175
        mmWidth = 102659
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Stock Count'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 51065
        mmTop = 3969
        mmWidth = 100542
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Area Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 3175
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = 'Site Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 7673
        mmWidth = 16140
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 12171
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'ppHoldRepLabel101'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 157163
        mmTop = 8202
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 177536
        mmTop = 3969
        mmWidth = 16341
        BandType = 0
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        DataField = 'Area Name'
        DataPipeline = data1.areaPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'areaPipe'
        mmHeight = 3704
        mmLeft = 18256
        mmTop = 3175
        mmWidth = 31485
        BandType = 0
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        DataField = 'Site Name'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 16933
        mmTop = 7673
        mmWidth = 32544
        BandType = 0
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        DataField = 'Site Manager'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 14552
        mmTop = 12171
        mmWidth = 34660
        BandType = 0
      end
      object ppSystemVariable3: TppSystemVariable
        UserName = 'SystemVariable3'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 168011
        mmTop = 8202
        mmWidth = 25929
        BandType = 0
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 25135
        mmWidth = 193940
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 265
        mmTop = 16669
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'From: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83608
        mmTop = 11377
        mmWidth = 39455
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = '     To: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83608
        mmTop = 15346
        mmWidth = 39836
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Header:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 182563
        mmTop = 16669
        mmWidth = 11377
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'lRight2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        Visible = False
        mmHeight = 3704
        mmLeft = 100806
        mmTop = 20902
        mmWidth = 93134
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'ppS_PrepDBText1'
        DataField = 'Name'
        DataPipeline = pipeCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeCount'
        mmHeight = 4763
        mmLeft = 1588
        mmTop = 1323
        mmWidth = 65352
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'ppS_PrepDBText2'
        DataField = 'PurchUnit'
        DataPipeline = pipeCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeCount'
        mmHeight = 4763
        mmLeft = 68792
        mmTop = 1323
        mmWidth = 21960
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'ppS_PrepDBText4'
        OnGetText = ppDBText5GetText
        DataField = 'PurchStk'
        DataPipeline = pipeCount
        DisplayFormat = '#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeCount'
        mmHeight = 4498
        mmLeft = 111125
        mmTop = 1323
        mmWidth = 17727
        BandType = 4
      end
      object ppDBText11: TppDBText
        UserName = 'ppS_PrepDBText11'
        OnGetText = ppDBText11GetText
        DataField = 'OpStk'
        DataPipeline = pipeCount
        DisplayFormat = '#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeCount'
        mmHeight = 4498
        mmLeft = 92075
        mmTop = 1323
        mmWidth = 16669
        BandType = 4
      end
      object ppLine6: TppLine
        UserName = 'ppS_PrepLine3'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 529
        mmTop = 4498
        mmWidth = 192882
        BandType = 4
      end
      object ppLine7: TppLine
        UserName = 'ppS_PrepLine8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 67733
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine8: TppLine
        UserName = 'ppS_PrepLine9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 91017
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine10: TppLine
        UserName = 'ppS_PrepLine11'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 110331
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine16: TppLine
        UserName = 'ppS_PrepLine17'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5821
        mmLeft = 191294
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine17: TppLine
        UserName = 'ppS_PrepLine18'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5821
        mmLeft = 529
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine18: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 166952
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine85: TppLine
        UserName = 'ppS_PrepLine24'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 130969
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
    end
    object ppSummaryBand1: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 31221
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 28310
        mmLeft = 0
        mmTop = 2646
        mmWidth = 193940
        BandType = 7
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = ' Notes: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        mmHeight = 4022
        mmLeft = 1058
        mmTop = 794
        mmWidth = 12107
        BandType = 7
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'SubCat'
      DataPipeline = pipeCount
      UserName = 'S_PrepGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 17780
      DataPipelineName = 'pipeCount'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 14552
        mmPrintPosition = 0
        object ppDBText20: TppDBText
          UserName = 'ppS_PrepDBText10'
          DataField = 'SubCat'
          DataPipeline = pipeCount
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeCount'
          mmHeight = 5027
          mmLeft = 1588
          mmTop = 3175
          mmWidth = 51858
          BandType = 3
          GroupNo = 0
        end
        object ppLabel25: TppLabel
          UserName = 'ppS_PrepLabel1'
          Caption = 'Purchase Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3969
          mmLeft = 1852
          mmTop = 9790
          mmWidth = 65088
          BandType = 3
          GroupNo = 0
        end
        object ppLabel26: TppLabel
          UserName = 'ppS_PrepLabel2'
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3969
          mmLeft = 72761
          mmTop = 10054
          mmWidth = 14552
          BandType = 3
          GroupNo = 0
        end
        object ppLabel28: TppLabel
          UserName = 'ppS_PrepLabel4'
          AutoSize = False
          Caption = 'Opening Stock'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 8202
          mmLeft = 92075
          mmTop = 5821
          mmWidth = 17727
          BandType = 3
          GroupNo = 0
        end
        object ppLabel29: TppLabel
          UserName = 'ppS_PrepLabel5'
          AutoSize = False
          Caption = 'Purchases'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4763
          mmLeft = 110596
          mmTop = 8731
          mmWidth = 20108
          BandType = 3
          GroupNo = 0
        end
        object ppLine62: TppLine
          UserName = 'ppS_PrepLine1'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 529
          mmTop = 8467
          mmWidth = 53711
          BandType = 3
          GroupNo = 0
        end
        object ppLine63: TppLine
          UserName = 'ppS_PrepLine2'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 794
          mmTop = 13494
          mmWidth = 192882
          BandType = 3
          GroupNo = 0
        end
        object ppLine64: TppLine
          UserName = 'ppS_PrepLine6'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 529
          mmTop = 2381
          mmWidth = 53711
          BandType = 3
          GroupNo = 0
        end
        object ppLine65: TppLine
          UserName = 'ppS_PrepLine7'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 11642
          mmLeft = 529
          mmTop = 2910
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ppLine66: TppLine
          UserName = 'ppS_PrepLine5'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 9525
          mmLeft = 191294
          mmTop = 5027
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine72: TppLine
          UserName = 'ppS_PrepLine32'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 110331
          mmTop = 5027
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine74: TppLine
          UserName = 'ppS_PrepLine34'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 91017
          mmTop = 5027
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine75: TppLine
          UserName = 'ppS_PrepLine35'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 67733
          mmTop = 5027
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine76: TppLine
          UserName = 'ppS_PrepLine36'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 6350
          mmLeft = 52123
          mmTop = 2381
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine77: TppLine
          UserName = 'Line1'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 54504
          mmTop = 5027
          mmWidth = 138907
          BandType = 3
          GroupNo = 0
        end
        object ppLabel35: TppLabel
          UserName = 'ppS_PrepLabel101'
          AutoSize = False
          Caption = '          Closing              '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4498
          mmLeft = 131498
          mmTop = 6350
          mmWidth = 41540
          BandType = 3
          GroupNo = 0
        end
        object ppLine78: TppLine
          UserName = 'Line2'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 3969
          mmLeft = 166952
          mmTop = 10584
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine84: TppLine
          UserName = 'ppS_PrepLine23'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 130969
          mmTop = 5027
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLabel24: TppLabel
          UserName = 'ppS_PrepLabel14'
          Caption = 'TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 4022
          mmLeft = 174361
          mmTop = 10054
          mmWidth = 11430
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 15081
        mmPrintPosition = 0
        object ppLine11: TppLine
          UserName = 'Line11'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 12171
          mmLeft = 529
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine12: TppLine
          UserName = 'Line12'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 12171
          mmLeft = 67733
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine13: TppLine
          UserName = 'Line13'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 12171
          mmLeft = 91017
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine15: TppLine
          UserName = 'Line15'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 12171
          mmLeft = 110331
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine19: TppLine
          UserName = 'Line19'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 12171
          mmLeft = 130969
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine20: TppLine
          UserName = 'Line20'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 12171
          mmLeft = 166952
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine21: TppLine
          UserName = 'Line21'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 12171
          mmLeft = 191294
          mmTop = 0
          mmWidth = 2381
          BandType = 5
          GroupNo = 0
        end
        object ppLine22: TppLine
          UserName = 'Line22'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 529
          mmTop = 4498
          mmWidth = 192882
          BandType = 5
          GroupNo = 0
        end
        object ppLine31: TppLine
          UserName = 'Line31'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 529
          mmTop = 10583
          mmWidth = 192882
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object adoqLG: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'SELECT [cat] as SubCatName, entitycode, PurN as PurchaseName, Pu' +
        'rchaseUnit as PurchUnit,'
      '(lcVar / PurchBaseU) as q,'
      '(lcVar / PurchBaseU) as sq,'
      '(-1 * lcVar / PurchBaseU) as dq,'
      '((lcc - TrueECL) / PurchBaseU) as bq,'
      '((lcc - TrueECL) / PurchBaseU) as bsq,'
      '(-1 * (lcc - TrueECL) / PurchBaseU) as bdq,'
      '(CASE'
      '  WHEN (TheoRed = 0) THEN NULL'
      '  ELSE (((lcc - TrueECL) / TheoRed) * 100)'
      'END) as spc,'
      '(lcc / PurchBaseU) as CheckCount'
      'FROM stkLCProds'
      'WHERE lcc is NOT NULL'
      '     -- and (ABS(lcVar) > 0.001)'
      'Order By  [cat], PurN')
    Left = 16
    Top = 144
  end
  object dsLG: TDataSource
    DataSet = adoqLG
    Left = 64
    Top = 144
  end
  object pipeLG: TppDBPipeline
    DataSource = dsLG
    UserName = 'pipeLG'
    Left = 96
    Top = 144
    object pipeLGppField1: TppField
      FieldAlias = 'SubCatName'
      FieldName = 'SubCatName'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object pipeLGppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'entitycode'
      FieldName = 'entitycode'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 1
    end
    object pipeLGppField3: TppField
      FieldAlias = 'PurchaseName'
      FieldName = 'PurchaseName'
      FieldLength = 20
      DisplayWidth = 20
      Position = 2
    end
    object pipeLGppField4: TppField
      FieldAlias = 'PurchUnit'
      FieldName = 'PurchUnit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object pipeLGppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'sq'
      FieldName = 'sq'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 4
    end
    object pipeLGppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'dq'
      FieldName = 'dq'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 5
    end
    object pipeLGppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'bsq'
      FieldName = 'bsq'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object pipeLGppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'bdq'
      FieldName = 'bdq'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 7
    end
    object pipeLGppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'spc'
      FieldName = 'spc'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object pipeLGppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'CheckCount'
      FieldName = 'CheckCount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
  end
  object ppLGsmall: TppReport
    AutoStop = False
    DataPipeline = pipeLG
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppHoldRep'
    PrinterSetup.PaperName = 'Letter (8.5 x 11 in)'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.FileName = 'C:\cornel_view\SQLStock\Code\hold.rtm'
    AllowPrintToArchive = True
    ArchiveFileName = 'LG.raf'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppLGsmallPreviewFormCreate
    Left = 132
    Top = 144
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeLG'
    object ppHeaderBand3: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 26194
      mmPrintPosition = 0
      object ppShape4: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 50536
        mmTop = 3175
        mmWidth = 104775
        BandType = 0
      end
      object ppLabel65: TppLabel
        UserName = 'ppHoldRepLabel1'
        AutoSize = False
        Caption = 'Stock Loss/Gain Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5842
        mmLeft = 51065
        mmTop = 3969
        mmWidth = 103188
        BandType = 0
      end
      object ppLabel66: TppLabel
        UserName = 'ppHoldRepLabel2'
        AutoSize = False
        Caption = 'Area Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 3175
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel67: TppLabel
        UserName = 'ppHoldRepLabel3'
        AutoSize = False
        Caption = 'Site Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 7673
        mmWidth = 16140
        BandType = 0
      end
      object ppLabel68: TppLabel
        UserName = 'ppHoldRepLabel4'
        AutoSize = False
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 12171
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel73: TppLabel
        UserName = 'ppHoldRepLabel10'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 157427
        mmTop = 7938
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable6: TppSystemVariable
        UserName = 'HoldRepCalc1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 177536
        mmTop = 3175
        mmWidth = 16404
        BandType = 0
      end
      object ppDBText41: TppDBText
        UserName = 'DBText38'
        DataField = 'Area Name'
        DataPipeline = data1.areaPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'areaPipe'
        mmHeight = 3704
        mmLeft = 18256
        mmTop = 3175
        mmWidth = 32015
        BandType = 0
      end
      object ppDBText42: TppDBText
        UserName = 'DBText39'
        DataField = 'Site Name'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 16933
        mmTop = 7673
        mmWidth = 33073
        BandType = 0
      end
      object ppDBText43: TppDBText
        UserName = 'DBText40'
        DataField = 'Site Manager'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 14552
        mmTop = 12171
        mmWidth = 35190
        BandType = 0
      end
      object ppSystemVariable7: TppSystemVariable
        UserName = 'SystemVariable5'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 168011
        mmTop = 7938
        mmWidth = 25929
        BandType = 0
      end
      object ppLine86: TppLine
        UserName = 'Line70'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 24871
        mmWidth = 193940
        BandType = 0
      end
      object ppLmid1: TppLabel
        UserName = 'lFrom2'
        Caption = 'From: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83608
        mmTop = 11377
        mmWidth = 39455
        BandType = 0
      end
      object ppLmid2: TppLabel
        UserName = 'Lmid2'
        Caption = '     To: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83608
        mmTop = 15346
        mmWidth = 39836
        BandType = 0
      end
      object pplDiv: TppLabel
        UserName = 'lDiv2'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 265
        mmTop = 16669
        mmWidth = 13494
        BandType = 0
      end
      object pplRight2: TppLabel
        UserName = 'lRight2'
        AutoSize = False
        Caption = 'lRight2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        Visible = False
        mmHeight = 3704
        mmLeft = 100806
        mmTop = 20902
        mmWidth = 93134
        BandType = 0
      end
      object pplHeader: TppLabel
        UserName = 'Label1002'
        Caption = 'Header:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 182563
        mmTop = 16669
        mmWidth = 11377
        BandType = 0
      end
    end
    object ppDetailBand3: TppDetailBand
      BeforePrint = ppDetailBand3BeforePrint
      mmBottomOffset = 0
      mmHeight = 4233
      mmPrintPosition = 0
      object ppDBText44: TppDBText
        UserName = 'ppHoldRepDBText2'
        DataField = 'PurchaseName'
        DataPipeline = pipeLG
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 265
        mmTop = 529
        mmWidth = 55033
        BandType = 4
      end
      object ppDBText45: TppDBText
        UserName = 'ppHoldRepDBText3'
        DataField = 'PurchUnit'
        DataPipeline = pipeLG
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 56621
        mmTop = 529
        mmWidth = 19050
        BandType = 4
      end
      object ppDBText46: TppDBText
        UserName = 'ppHoldRepDBText4'
        OnGetText = ppDBText46GetText
        DataField = 'q'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 76729
        mmTop = 529
        mmWidth = 30956
        BandType = 4
      end
      object ppDBText55: TppDBText
        UserName = 'ppHoldRepDBText13'
        DataField = 'spc'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 138113
        mmTop = 529
        mmWidth = 16404
        BandType = 4
      end
      object ppLine87: TppLine
        UserName = 'ppHoldRepLine9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 0
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine90: TppLine
        UserName = 'ppHoldRepLine12'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1852
        mmLeft = 0
        mmTop = 2646
        mmWidth = 193940
        BandType = 4
      end
      object ppLine91: TppLine
        UserName = 'ppHoldRepLine26'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 55827
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppLine92: TppLine
        UserName = 'ppHoldRepLine27'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 76200
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine101: TppLine
        UserName = 'ppHoldRepLine33'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 107950
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine105: TppLine
        UserName = 'ppHoldRepLine36'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 137054
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine106: TppLine
        UserName = 'ppHoldRepLine38'
        Position = lpRight
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 190500
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 155046
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        OnGetText = ppDBText46GetText
        DataField = 'CheckCount'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 156634
        mmTop = 529
        mmWidth = 19579
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText2'
        OnGetText = ppDBText46GetText
        DataField = 'bq'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 108744
        mmTop = 529
        mmWidth = 27517
        BandType = 4
      end
      object ppLabelPrepItem: TppLabel
        UserName = 'LabelPrepItem'
        AutoSize = False
        Caption = 
          '--------------------------  Prepared Item ----------------------' +
          '------------------- '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Visible = False
        mmHeight = 3440
        mmLeft = 76729
        mmTop = 265
        mmWidth = 7673
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        OnGetText = ppDBText46GetText
        DataField = 'FromPrep'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 177800
        mmTop = 529
        mmWidth = 15346
        BandType = 4
      end
      object ppLine14: TppLine
        UserName = 'Line14'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4233
        mmLeft = 176742
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
    end
    object ppFooterBand3: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppLabel14: TppLabel
        UserName = 'Label14'
        AutoSize = False
        Caption = 
          'Note: Surplus/Deficit is calculated using the "Included in Prep.' +
          ' Items" qty. added to the "Check Count" qty. (for those products' +
          ' that have it)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 529
        mmTop = 794
        mmWidth = 192617
        BandType = 8
      end
    end
    object ppSummaryBand3: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 13758
      mmPrintPosition = 0
      object ppShape12: TppShape
        UserName = 'Shape12'
        Brush.Color = clSilver
        mmHeight = 5027
        mmLeft = 265
        mmTop = 1058
        mmWidth = 193940
        BandType = 7
      end
      object ppLabel78: TppLabel
        UserName = 'ppHoldRepLabel25'
        Caption = 'LINE CHECK TOTALS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 529
        mmTop = 1852
        mmWidth = 28871
        BandType = 7
      end
      object ppLine171: TppLine
        UserName = 'Line171'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 137054
        mmTop = 1058
        mmWidth = 3440
        BandType = 7
      end
      object ppDBCalc38: TppDBCalc
        UserName = 'DBCalc38'
        DataField = 'spc'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 137848
        mmTop = 1852
        mmWidth = 16669
        BandType = 7
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Comment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 0
        mmTop = 8202
        mmWidth = 16404
        BandType = 7
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 155046
        mmTop = 1058
        mmWidth = 3440
        BandType = 7
      end
      object ppMemo1: TppMemo
        UserName = 'Memo1'
        KeepTogether = True
        Caption = 'Memo1'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Stretch = True
        Transparent = True
        mmHeight = 4763
        mmLeft = 17463
        mmTop = 8202
        mmWidth = 176213
        BandType = 7
        mmBottomOffset = 762
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppLine27: TppLine
        UserName = 'Line27'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 0
        mmTop = 1058
        mmWidth = 3440
        BandType = 7
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'SubCatName'
      DataPipeline = pipeLG
      UserName = 'HoldRepGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 22860
      DataPipelineName = 'pipeLG'
      object ppGroupHeaderBand3: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 12171
        mmPrintPosition = 0
        object ppDBText56: TppDBText
          UserName = 'ppHoldRepDBText1'
          DataField = 'SubCatName'
          DataPipeline = pipeLG
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          WordWrap = True
          DataPipelineName = 'pipeLG'
          mmHeight = 4233
          mmLeft = 4763
          mmTop = 2910
          mmWidth = 47361
          BandType = 3
          GroupNo = 0
        end
        object ppLabel81: TppLabel
          UserName = 'ppHoldRepLabel11'
          AutoSize = False
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 17992
          mmTop = 7938
          mmWidth = 20373
          BandType = 3
          GroupNo = 0
        end
        object ppLabel82: TppLabel
          UserName = 'ppHoldRepLabel12'
          AutoSize = False
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 59002
          mmTop = 6615
          mmWidth = 15610
          BandType = 3
          GroupNo = 0
        end
        object ppLabel86: TppLabel
          UserName = 'ppHoldRepLabel19'
          AutoSize = False
          Caption = 'Surplus %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 137848
          mmTop = 8467
          mmWidth = 16933
          BandType = 3
          GroupNo = 0
        end
        object ppLine110: TppLine
          UserName = 'ppHoldRepLine1'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 0
          mmTop = 5821
          mmWidth = 55827
          BandType = 3
          GroupNo = 0
        end
        object ppLine111: TppLine
          UserName = 'ppHoldRepLine2'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1323
          mmLeft = 0
          mmTop = 10848
          mmWidth = 193940
          BandType = 3
          GroupNo = 0
        end
        object ppLine112: TppLine
          UserName = 'ppHoldRepLine3'
          Weight = 0.75
          mmHeight = 794
          mmLeft = 0
          mmTop = 1588
          mmWidth = 55827
          BandType = 3
          GroupNo = 0
        end
        object ppLine113: TppLine
          UserName = 'ppHoldRepLine8'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 10583
          mmLeft = 0
          mmTop = 1588
          mmWidth = 3440
          BandType = 3
          GroupNo = 0
        end
        object ppLine115: TppLine
          UserName = 'ppHoldRepLine14'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 10583
          mmLeft = 55827
          mmTop = 1588
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine117: TppLine
          UserName = 'ppHoldRepLine20'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7938
          mmLeft = 107950
          mmTop = 4233
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine119: TppLine
          UserName = 'ppHoldRepLine25'
          Position = lpRight
          Weight = 0.75
          mmHeight = 7938
          mmLeft = 192088
          mmTop = 4233
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel90: TppLabel
          UserName = 'Label51'
          AutoSize = False
          Caption = 'Surplus (+) / Deficit (-)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 76729
          mmTop = 8467
          mmWidth = 30956
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 3704
          mmLeft = 137054
          mmTop = 8467
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7938
          mmLeft = 155046
          mmTop = 4233
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel15: TppLabel
          UserName = 'Label15'
          AutoSize = False
          Caption = 'Check Count'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 156634
          mmTop = 6879
          mmWidth = 19579
          BandType = 3
          GroupNo = 0
        end
        object ppLine4: TppLine
          UserName = 'Line6'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 55827
          mmTop = 2910
          mmWidth = 137848
          BandType = 3
          GroupNo = 0
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          AutoSize = False
          Caption = 'Current Line Check'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold, fsUnderline]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 76729
          mmTop = 4763
          mmWidth = 30956
          BandType = 3
          GroupNo = 0
        end
        object ppLabel19: TppLabel
          UserName = 'Label3'
          AutoSize = False
          Caption = 'Surplus(+) / Deficit (-)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 108479
          mmTop = 8467
          mmWidth = 27781
          BandType = 3
          GroupNo = 0
        end
        object ppLabel21: TppLabel
          UserName = 'Label6'
          AutoSize = False
          Caption = 'Since Last Accepted Inventory'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold, fsUnderline]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 3704
          mmLeft = 108479
          mmTop = 4763
          mmWidth = 46302
          BandType = 3
          GroupNo = 0
        end
        object ppLine23: TppLine
          UserName = 'Line23'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7938
          mmLeft = 176742
          mmTop = 4233
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel16: TppLabel
          UserName = 'Label16'
          AutoSize = False
          Caption = 'Included in Prep. Items'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7673
          mmLeft = 177536
          mmTop = 4498
          mmWidth = 15610
          BandType = 3
          GroupNo = 0
        end
        object ppLine25: TppLine
          UserName = 'Line7'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7673
          mmLeft = 76200
          mmTop = 4233
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 4498
        mmPrintPosition = 0
        object ppShape11: TppShape
          UserName = 'Shape11'
          Brush.Color = clSilver
          mmHeight = 4498
          mmLeft = 265
          mmTop = 0
          mmWidth = 193940
          BandType = 5
          GroupNo = 0
        end
        object ppLabel96: TppLabel
          UserName = 'ppHoldRepLabel24'
          Caption = 'TOTALS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3175
          mmLeft = 1058
          mmTop = 794
          mmWidth = 11113
          BandType = 5
          GroupNo = 0
        end
        object ppDBText57: TppDBText
          UserName = 'ppHoldRepDBText15'
          AutoSize = True
          DataField = 'SubCatName'
          DataPipeline = pipeLG
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeLG'
          mmHeight = 3810
          mmLeft = 13229
          mmTop = 529
          mmWidth = 23580
          BandType = 5
          GroupNo = 0
        end
        object ppLine163: TppLine
          UserName = 'Line163'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 4233
          mmLeft = 137054
          mmTop = 0
          mmWidth = 3440
          BandType = 5
          GroupNo = 0
        end
        object ppDBCalc15: TppDBCalc
          UserName = 'DBCalc15'
          DataField = 'spc'
          DataPipeline = pipeLG
          DisplayFormat = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = ppGroup3
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcAverage
          DataPipelineName = 'pipeLG'
          mmHeight = 3440
          mmLeft = 137848
          mmTop = 529
          mmWidth = 16669
          BandType = 5
          GroupNo = 0
        end
        object ppLine9: TppLine
          UserName = 'Line4'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 4233
          mmLeft = 155046
          mmTop = 0
          mmWidth = 3440
          BandType = 5
          GroupNo = 0
        end
        object ppLine26: TppLine
          UserName = 'Line26'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 4498
          mmLeft = 0
          mmTop = 0
          mmWidth = 3440
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object LCconn: TADOConnection
    CommandTimeout = 800
    LoginPrompt = False
    Left = 32
    Top = 248
  end
  object adoqLock: TADOQuery
    Connection = LCconn
    CommandTimeout = 0
    Parameters = <>
    Left = 64
    Top = 248
  end
  object pipeLocationCount: TppBDEPipeline
    DataSource = dsLocationCount
    SkipWhenNoRecords = False
    UserName = 'pipeCount1'
    Left = 104
    Top = 200
  end
  object ppLocationCount: TppReport
    AutoStop = False
    DataPipeline = pipeLocationCount
    NoDataBehaviors = [ndBlankReport]
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppS_Prep'
    PrinterSetup.PaperName = 'Letter (8.5 x 11 in)'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    ArchiveFileName = 'Aud.raf'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppCountPreviewFormCreate
    Left = 136
    Top = 200
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeLocationCount'
    object ppHeaderBand4: TppHeaderBand
      BeforePrint = ppHeaderBand4BeforePrint
      mmBottomOffset = 0
      mmHeight = 23548
      mmPrintPosition = 0
      object ppLine99: TppLine
        UserName = 'Line24'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 6350
        mmTop = 21167
        mmWidth = 190500
        BandType = 0
      end
      object ppShape5: TppShape
        UserName = 'Shape5'
        mmHeight = 7408
        mmLeft = 50006
        mmTop = 3175
        mmWidth = 102659
        BandType = 0
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        AutoSize = False
        Caption = 'Stock Count'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 51065
        mmTop = 3969
        mmWidth = 100542
        BandType = 0
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        AutoSize = False
        Caption = 'Area Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 3175
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'Site Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 7673
        mmWidth = 16140
        BandType = 0
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        AutoSize = False
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 12171
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 159544
        mmTop = 8202
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 179917
        mmTop = 3969
        mmWidth = 16341
        BandType = 0
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'Area Name'
        DataPipeline = data1.areaPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'areaPipe'
        mmHeight = 3704
        mmLeft = 18256
        mmTop = 3175
        mmWidth = 31485
        BandType = 0
      end
      object ppDBText8: TppDBText
        UserName = 'DBText101'
        DataField = 'Site Name'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 16933
        mmTop = 7673
        mmWidth = 32544
        BandType = 0
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        DataField = 'Site Manager'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 14552
        mmTop = 12171
        mmWidth = 34660
        BandType = 0
      end
      object ppSystemVariable4: TppSystemVariable
        UserName = 'SystemVariable4'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 170392
        mmTop = 8202
        mmWidth = 25929
        BandType = 0
      end
      object ppLabel27: TppLabel
        UserName = 'Label27'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 265
        mmTop = 16669
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel30: TppLabel
        UserName = 'Label30'
        Caption = 'From: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 80698
        mmTop = 11377
        mmWidth = 39455
        BandType = 0
      end
      object ppLabel31: TppLabel
        UserName = 'Label31'
        Caption = '     To: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 80698
        mmTop = 15346
        mmWidth = 39836
        BandType = 0
      end
      object ppLabel32: TppLabel
        UserName = 'Label101'
        Caption = 'Header:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 184944
        mmTop = 16669
        mmWidth = 11377
        BandType = 0
      end
    end
    object ppDetailBand7: TppDetailBand
      BeforePrint = ppDetailBand7BeforePrint
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppDBText48: TppDBText
        UserName = 'ppS_PrepDBText1'
        DataField = 'Name'
        DataPipeline = pipeLocationCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLocationCount'
        mmHeight = 4498
        mmLeft = 17463
        mmTop = 794
        mmWidth = 76200
        BandType = 4
      end
      object ppDBText49: TppDBText
        UserName = 'ppS_PrepDBText2'
        DataField = 'Unit'
        DataPipeline = pipeLocationCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLocationCount'
        mmHeight = 4498
        mmLeft = 95250
        mmTop = 794
        mmWidth = 20902
        BandType = 4
      end
      object ppDBText51: TppDBText
        UserName = 'ppS_PrepDBText11'
        DataField = 'RecID'
        DataPipeline = pipeLocationCount
        DisplayFormat = '#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLocationCount'
        mmHeight = 4445
        mmLeft = 6773
        mmTop = 794
        mmWidth = 9260
        BandType = 4
      end
      object ppLine100: TppLine
        UserName = 'ppS_PrepLine3'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 6615
        mmTop = 3969
        mmWidth = 190765
        BandType = 4
      end
      object ppLine28: TppLine
        UserName = 'ppS_PrepLine8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 94192
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppLine29: TppLine
        UserName = 'ppS_PrepLine9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 116840
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppLine107: TppLine
        UserName = 'ppS_PrepLine17'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 195792
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine108: TppLine
        UserName = 'ppS_PrepLine18'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 6615
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine30: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 177165
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppLocationsTot: TppDBText
        UserName = 'tTot'
        DataField = 'ActCloseStk'
        DataPipeline = pipeLocationCount
        DisplayFormat = '#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        Visible = False
        DataPipelineName = 'pipeLocationCount'
        mmHeight = 4445
        mmLeft = 177589
        mmTop = 794
        mmWidth = 17992
        BandType = 4
      end
      object ppLine118: TppLine
        UserName = 'Line118'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 16722
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppDBText50: TppDBText
        UserName = 'DBText50'
        OnGetText = ppDBText50GetText
        DataField = 'Wastage'
        DataPipeline = pipeLocationCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'pipeLocationCount'
        mmHeight = 4498
        mmLeft = 117740
        mmTop = 794
        mmWidth = 23813
        BandType = 4
      end
    end
    object ppFooterBand2: TppFooterBand
      PrintOnLastPage = False
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppGroup2: TppGroup
      BreakName = 'LocationID'
      DataPipeline = pipeLocationCount
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeLocationCount'
      object ppGroupHeaderBand2: TppGroupHeaderBand
        BeforePrint = ppGroupHeaderBand2BeforePrint
        mmBottomOffset = 0
        mmHeight = 12965
        mmPrintPosition = 0
        object ppLabel69: TppLabel
          UserName = 'ppS_PrepLabel1'
          Caption = 'Purchase Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3704
          mmLeft = 18256
          mmTop = 8731
          mmWidth = 27517
          BandType = 3
          GroupNo = 0
        end
        object ppLabel70: TppLabel
          UserName = 'ppS_PrepLabel2'
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 96044
          mmTop = 8731
          mmWidth = 19844
          BandType = 3
          GroupNo = 0
        end
        object ppLabel71: TppLabel
          UserName = 'ppS_PrepLabel4'
          AutoSize = False
          Caption = 'Row No.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 8202
          mmLeft = 7144
          mmTop = 4498
          mmWidth = 8996
          BandType = 3
          GroupNo = 0
        end
        object ppLine34: TppLine
          UserName = 'ppS_PrepLine2'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1323
          mmLeft = 6615
          mmTop = 12171
          mmWidth = 190765
          BandType = 3
          GroupNo = 0
        end
        object ppLine35: TppLine
          UserName = 'ppS_PrepLine7'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 9525
          mmLeft = 6615
          mmTop = 3704
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ppLine120: TppLine
          UserName = 'ppS_PrepLine5'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 9525
          mmLeft = 195791
          mmTop = 3704
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine122: TppLine
          UserName = 'ppS_PrepLine34'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 116946
          mmTop = 3704
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine123: TppLine
          UserName = 'ppS_PrepLine35'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 94192
          mmTop = 3704
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLine125: TppLine
          UserName = 'Line1'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1323
          mmLeft = 6615
          mmTop = 3704
          mmWidth = 190765
          BandType = 3
          GroupNo = 0
        end
        object ppLabel34: TppLabel
          UserName = 'ppS_PrepLabel101'
          AutoSize = False
          Caption = 'Quantity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4498
          mmLeft = 157427
          mmTop = 4763
          mmWidth = 38894
          BandType = 3
          GroupNo = 0
        end
        object ppLine126: TppLine
          UserName = 'Line2'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 4233
          mmLeft = 177271
          mmTop = 8996
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppLabel74: TppLabel
          UserName = 'ppS_PrepLabel14'
          Caption = 'TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 178065
          mmTop = 8996
          mmWidth = 17992
          BandType = 3
          GroupNo = 0
        end
        object ppLine116: TppLine
          UserName = 'Line116'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 9525
          mmLeft = 16669
          mmTop = 3704
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
        object ppShape2: TppShape
          UserName = 'Shape2'
          mmHeight = 5556
          mmLeft = 17992
          mmTop = 1588
          mmWidth = 61383
          BandType = 3
          GroupNo = 0
        end
        object ppDBText13: TppDBText
          UserName = 'DBText13'
          DataField = 'LocationName'
          DataPipeline = pipeLocationCount
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeLocationCount'
          mmHeight = 4233
          mmLeft = 18785
          mmTop = 2381
          mmWidth = 59796
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 4233
        mmPrintPosition = 0
        object ppLine129: TppLine
          UserName = 'Line129'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1323
          mmLeft = 6615
          mmTop = 0
          mmWidth = 190765
          BandType = 5
          GroupNo = 0
        end
      end
    end
    object ppGroup4: TppGroup
      BreakName = 'SubCat'
      DataPipeline = pipeLocationCount
      KeepTogether = True
      UserName = 'Group4'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeLocationCount'
      object ppGroupHeaderBand4: TppGroupHeaderBand
        BeforePrint = ppGroupHeaderBand4BeforePrint
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppLine36: TppLine
          UserName = 'Line36'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1323
          mmLeft = 6615
          mmTop = 4233
          mmWidth = 190765
          BandType = 3
          GroupNo = 1
        end
        object ppLine37: TppLine
          UserName = 'Line37'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 5027
          mmLeft = 6615
          mmTop = 0
          mmWidth = 2646
          BandType = 3
          GroupNo = 1
        end
        object ppLine38: TppLine
          UserName = 'Line38'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5027
          mmLeft = 195792
          mmTop = 0
          mmWidth = 1588
          BandType = 3
          GroupNo = 1
        end
        object ppDBText14: TppDBText
          UserName = 'DBText14'
          DataField = 'SubCat'
          DataPipeline = pipeLocationCount
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeLocationCount'
          mmHeight = 4233
          mmLeft = 7938
          mmTop = 529
          mmWidth = 47890
          BandType = 3
          GroupNo = 1
        end
        object ppLine40: TppLine
          UserName = 'Line40'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 529
          mmLeft = 6615
          mmTop = 0
          mmWidth = 190765
          BandType = 3
          GroupNo = 1
        end
      end
      object ppGroupFooterBand4: TppGroupFooterBand
        Visible = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
  end
  object adoqLocationCount: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT locs.[LocationName], locs.[Active], alc.* from   '
      
        '  (SELECT loc.[LocationID], loc.[LocationName], loc.[Active] fro' +
        'm stkLocations loc  '
      '    WHERE loc.Deleted = 0) locs'
      'JOIN'
      '  (select * from AuditLocationsCur'
      '   WHERE LocationID > 0  '
      
        '   AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ("WasteTill" <' +
        '> 0) or ("WastePC" <> 0))) alc  '
      'ON locs.LocationID = alc.LocationID  '
      'ORDER BY [Active], locationName, RecID, SubCat, [Name]'
      '')
    Left = 32
    Top = 192
  end
  object dsLocationCount: TwwDataSource
    DataSet = adoqLocationCount
    Left = 71
    Top = 197
  end
end
