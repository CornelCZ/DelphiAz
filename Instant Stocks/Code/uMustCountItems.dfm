object fMustCountItems: TfMustCountItems
  Left = 269
  Top = 110
  Width = 979
  Height = 522
  Caption = 'fMustCountItems'
  Color = clBtnFace
  Constraints.MinHeight = 362
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 963
    Height = 83
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      963
      83)
    object Label2: TLabel
      Left = 808
      Top = 62
      Width = 150
      Height = 20
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Template List Grid'
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object lblTopInfo: TLabel
      Left = 571
      Top = 1
      Width = 359
      Height = 59
      AutoSize = False
      Caption = 
        ' Products Grid: Dbl-Click, "Ins" key to Assign to Template'#13#10' (us' +
        'e Ctrl-Click and Shift-Click to multi-select)'#13#10' Template List: D' +
        'bl-Click, "Del" key to Remove from Template'#13#10' (use Ctrl-Click an' +
        'd Shift-Click to multi-select)'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object lblProdCount: TLabel
      Left = 746
      Top = 63
      Width = 56
      Height = 17
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = '99999'
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 2
      Top = 62
      Width = 174
      Height = 20
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Available Products Grid'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object pnlSearch: TPanel
      Left = 1
      Top = -2
      Width = 569
      Height = 62
      BevelOuter = bvNone
      TabOrder = 0
      object Bevel2: TBevel
        Left = 1
        Top = 3
        Width = 566
        Height = 58
        Shape = bsFrame
        Style = bsRaised
      end
      object Label14: TLabel
        Left = 7
        Top = 12
        Width = 125
        Height = 13
        Caption = 'Product Name Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rbSInc: TRadioButton
        Left = 16
        Top = 32
        Width = 123
        Height = 21
        Caption = 'Incremental Search'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbSIncClick
      end
      object rbsMid: TRadioButton
        Left = 155
        Top = 32
        Width = 127
        Height = 21
        Caption = 'Mid-Word Search'
        TabOrder = 1
        OnClick = rbSIncClick
      end
      object btnPriorSearch: TBitBtn
        Left = 319
        Top = 6
        Width = 81
        Height = 23
        Caption = 'Prev (F2)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btnPriorSearchClick
        Glyph.Data = {
          6A000000424D6A000000000000003E000000280000000A0000000B0000000100
          0100000000002C0000000000000000000000020000000200000000000000FFFF
          FF00FFC0000000000000000000008040000080400000C0C00000C0C00000E1C0
          0000E1C00000F3C00000F3C00000}
      end
      object btnNextSearch: TBitBtn
        Left = 319
        Top = 32
        Width = 81
        Height = 23
        Caption = 'Next (F3)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnNextSearchClick
        Glyph.Data = {
          6A000000424D6A000000000000003E000000280000000A0000000B0000000100
          0100000000002C0000000000000000000000020000000200000000000000FFFF
          FF00FFC00000F3C00000F3C00000E1C00000E1C00000C0C00000C0C000008040
          0000804000000000000000000000}
      end
      object Panel1: TPanel
        Left = 402
        Top = 6
        Width = 164
        Height = 48
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object rbSearchProds: TRadioButton
          Left = 3
          Top = 1
          Width = 158
          Height = 20
          Caption = 'Available Products Grid'
          Checked = True
          Color = clMoneyGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = rbSearchProdsClick
        end
        object rbSearchList: TRadioButton
          Left = 3
          Top = 27
          Width = 158
          Height = 20
          Caption = 'Template List Grid'
          Color = clAqua
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          OnClick = rbSearchProdsClick
        end
      end
      object edSearch: TEdit
        Left = 136
        Top = 8
        Width = 181
        Height = 21
        Hint = 
          'Type the Search string required '#13#10'AND press F3 or F2 to do the s' +
          'earch'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        Visible = False
      end
      object incSearch1: TwwIncrementalSearch
        Left = 136
        Top = 8
        Width = 182
        Height = 21
        DataSource = dsProds
        SearchField = 'Product Name'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 394
    Width = 963
    Height = 89
    Align = alBottom
    TabOrder = 1
    object Bevel1: TBevel
      Left = 529
      Top = 4
      Width = 5
      Height = 84
      Shape = bsFrame
      Style = bsRaised
    end
    object Label5: TLabel
      Left = 5
      Top = 2
      Width = 184
      Height = 13
      Caption = ' Available Products Grid Filters: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 222
      Top = 9
      Width = 71
      Height = 13
      Caption = 'Product Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFilterStatus: TLabel
      Left = 219
      Top = 46
      Width = 75
      Height = 40
      Alignment = taCenter
      AutoSize = False
      Caption = 'Filtering '#13#10'is OFF'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object LabelCategory: TLabel
      Left = 13
      Top = 45
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
    object LabelSubCategory: TLabel
      Left = 4
      Top = 68
      Width = 60
      Height = 13
      Caption = 'Sub-Categ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 18
      Top = 22
      Width = 46
      Height = 13
      Caption = 'Division'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lookCat: TComboBox
      Left = 68
      Top = 41
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnCloseUp = lookCatCloseUp
    end
    object lookSCat: TComboBox
      Left = 68
      Top = 64
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
    object edFilt: TEdit
      Left = 296
      Top = 5
      Width = 227
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object rbStart: TRadioButton
      Left = 238
      Top = 26
      Width = 131
      Height = 17
      Caption = 'Partial Match at Start'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TabStop = True
    end
    object rbMid: TRadioButton
      Left = 375
      Top = 26
      Width = 143
      Height = 17
      Caption = 'Partial Match Anywhere'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object btnNoFilter: TBitBtn
      Left = 377
      Top = 48
      Width = 67
      Height = 36
      Caption = 'Filters'#10'Off (F6)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnNoFilterClick
    end
    object btnFilter: TBitBtn
      Left = 299
      Top = 48
      Width = 67
      Height = 36
      Caption = 'Filters'#10'On (F5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btnFilterClick
    end
    object Panel2: TPanel
      Left = 831
      Top = 1
      Width = 131
      Height = 87
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 7
      object btnDiscard: TBitBtn
        Left = 2
        Top = 3
        Width = 126
        Height = 37
        Caption = 'Discard Changes'#10'to Template List'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnDiscardClick
      end
      object btnDone: TBitBtn
        Left = 2
        Top = 43
        Width = 126
        Height = 40
        Caption = 'Done'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        OnClick = btnDoneClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
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
    end
    object btnResetFilters: TBitBtn
      Left = 456
      Top = 48
      Width = 67
      Height = 36
      Caption = 'Reset'#10'Filters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = btnResetFiltersClick
    end
    object lookDiv: TComboBox
      Left = 68
      Top = 18
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 9
      OnCloseUp = lookDivCloseUp
    end
    object btnRemove: TBitBtn
      Left = 539
      Top = 46
      Width = 150
      Height = 37
      Caption = 'Remove From'#10'Template'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = btnRemoveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Margin = 12
      NumGlyphs = 2
      Spacing = 22
    end
    object btnAssign: TBitBtn
      Left = 539
      Top = 6
      Width = 150
      Height = 37
      Caption = 'Assign Product'#10'to Template'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = btnAssignClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Margin = 12
      NumGlyphs = 2
      Spacing = 11
    end
  end
  object pnlList: TPanel
    Left = 0
    Top = 83
    Width = 963
    Height = 311
    Align = alClient
    TabOrder = 2
    object Splitter3: TSplitter
      Left = 445
      Top = 1
      Width = 9
      Height = 309
      Cursor = crHSplit
      Beveled = True
      Color = clBlue
      MinSize = 360
      ParentColor = False
    end
    object gridList: TwwDBGrid
      Left = 454
      Top = 1
      Width = 508
      Height = 309
      Selected.Strings = (
        'Division'#9'11'#9'Division'#9'F'
        'Category'#9'11'#9'Category'#9'F'
        'Sub-Category'#9'14'#9'Sub-Category'#9'F'
        'Product Name'#9'28'#9'Product Name'#9'F'
        'Product Type'#9'10'#9'Type'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      Constraints.MinWidth = 360
      DataSource = dsList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTrailingEllipsis, dgShowCellHint]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnCalcCellColors = gridListCalcCellColors
      OnCalcTitleAttributes = gridListCalcTitleAttributes
      OnTitleButtonClick = gridListTitleButtonClick
      OnDblClick = btnRemoveClick
    end
    object gridProds: TwwDBGrid
      Left = 1
      Top = 1
      Width = 444
      Height = 309
      Selected.Strings = (
        'Sub-Category'#9'12'#9'Sub-Category'#9'F'
        'Product Name'#9'28'#9'Product Name'#9'F'
        'Product Type'#9'10'#9'Type'#9'F'
        'Description'#9'14'#9'Description'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alLeft
      Constraints.MinWidth = 360
      DataSource = dsProds
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTrailingEllipsis, dgShowCellHint]
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
      OnCalcCellColors = gridProdsCalcCellColors
      OnCalcTitleAttributes = gridProdsCalcTitleAttributes
      OnTitleButtonClick = gridProdsTitleButtonClick
      OnDblClick = btnAssignClick
    end
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dsProds
    SearchField = 'Product Name'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 488
    Top = 136
  end
  object adotProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'inList = 0'
    Filtered = True
    IndexFieldNames = '[Division], [Category], [Sub-Category], [Product Name]'
    TableName = '[00_#AllProducts]'
    Left = 328
    Top = 352
  end
  object dsProds: TwwDataSource
    DataSet = adotProds
    Left = 360
    Top = 352
  end
  object adotList: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = adotListAfterPost
    AfterDelete = adotListAfterPost
    IndexFieldNames = '[Division], [Category], [Sub-Category], [Product Name]'
    TableName = '[00_#TemplateList]'
    Left = 512
    Top = 352
  end
  object dsList: TwwDataSource
    DataSet = adotList
    Left = 544
    Top = 352
  end
  object wwLoc: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dsProds
    SearchField = 'Product ID'
    MatchType = mtExactMatch
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 552
    Top = 152
  end
end
