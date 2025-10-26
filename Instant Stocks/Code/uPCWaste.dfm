object fPCWaste: TfPCWaste
  Left = 420
  Top = 263
  HelpContext = 1048
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Waste'
  ClientHeight = 546
  ClientWidth = 1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 508
    Width = 1091
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnDblClick = BottomPanelDblClick
    object Label1: TLabel
      Left = 132
      Top = 2
      Width = 283
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'Products with Yellow font are Prepared Items'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object BitBtnSave: TBitBtn
      Left = 928
      Top = 8
      Width = 75
      Height = 25
      Action = ActSave
      Caption = '&Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
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
    object BitBtnCancel: TBitBtn
      Left = 1008
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnCancelClick
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
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 1091
    Height = 508
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object LeftPanel: TPanel
      Left = 1
      Top = 1
      Width = 540
      Height = 506
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PanelProduct: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 452
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          540
          452)
        object ProductsLabel: TLabel
          Left = 8
          Top = 8
          Width = 129
          Height = 13
          AutoSize = False
          Caption = 'Available for Waste'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object lblProdCount: TLabel
          Left = 416
          Top = 10
          Width = 101
          Height = 13
          Alignment = taRightJustify
          Caption = '(Showing 0 Products)'
        end
        object wwDBGrid1: TwwDBGrid
          Left = 8
          Top = 24
          Width = 528
          Height = 425
          Selected.Strings = (
            'Sub'#9'20'#9'Sub-Category'#9'F'
            'Name'#9'40'#9'Name'#9'F'
            'Descr'#9'20'#9'Description'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsTmpProducts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
          OnCalcCellColors = wwDBGrid1CalcCellColors
          OnDblClick = wwDBGrid1DblClick
        end
      end
      object SearchPanel: TPanel
        Left = 0
        Top = 452
        Width = 540
        Height = 54
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          540
          54)
        object LabelNameSearch: TLabel
          Left = 8
          Top = 8
          Width = 81
          Height = 13
          Caption = 'Name Search:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelF7: TLabel
          Left = 117
          Top = 35
          Width = 23
          Height = 13
          Caption = '(F7)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelF8: TLabel
          Left = 260
          Top = 35
          Width = 23
          Height = 13
          Caption = '(F8)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditMidwordSearchName: TEdit
          Left = 94
          Top = 4
          Width = 283
          Height = 21
          TabOrder = 0
        end
        object wwIncrementalSearchName: TwwIncrementalSearch
          Left = 94
          Top = 4
          Width = 283
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataSource = dsTmpProducts
          SearchField = 'Name'
          ShowMatchText = True
          AutoSelect = False
          TabOrder = 1
        end
        object RadioButtonIncremental: TRadioButton
          Left = 5
          Top = 33
          Width = 113
          Height = 17
          Action = ActIncrementalSearch
          TabOrder = 2
          TabStop = True
        end
        object RadioButtonMidword: TRadioButton
          Left = 160
          Top = 33
          Width = 98
          Height = 17
          Action = ActMidwordSearch
          TabOrder = 3
          TabStop = True
        end
        object BitBtnPrev: TBitBtn
          Left = 380
          Top = 4
          Width = 75
          Height = 22
          Action = ActSearchPrev
          Anchors = [akTop, akRight]
          Caption = 'Prev (F2)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Glyph.Data = {
            6A000000424D6A000000000000003E000000280000000A0000000B0000000100
            0100000000002C0000000000000000000000020000000200000000000000FFFF
            FF00FFC0000000000000000000008040000080400000C0C00000C0C00000E1C0
            0000E1C00000F3C00000F3C00000}
        end
        object BitBtnNext: TBitBtn
          Left = 460
          Top = 4
          Width = 75
          Height = 22
          Action = ActSearchNext
          Anchors = [akTop, akRight]
          Caption = 'Next (F3)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          Glyph.Data = {
            6A000000424D6A000000000000003E000000280000000A0000000B0000000100
            0100000000002C0000000000000000000000020000000200000000000000FFFF
            FF00FFC00000F3C00000F3C00000E1C00000E1C00000C0C00000C0C000008040
            0000804000000000000000000000}
        end
      end
    end
    object RightPanel: TPanel
      Left = 541
      Top = 1
      Width = 549
      Height = 506
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 549
        Height = 123
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 1
          Top = 3
          Width = 332
          Height = 119
          Caption = 'Grid Filters'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            332
            119)
          object LabelDivision: TLabel
            Left = 5
            Top = 20
            Width = 50
            Height = 13
            Caption = 'Division:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelCategory: TLabel
            Left = 5
            Top = 45
            Width = 55
            Height = 13
            Caption = 'Category:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSubCategory: TLabel
            Left = 5
            Top = 70
            Width = 81
            Height = 13
            Caption = 'Sub-Category:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBoxDivisionFilter: TComboBox
            Left = 91
            Top = 16
            Width = 233
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            OnChange = ComboBoxDivisionFilterChange
          end
          object ComboBoxCategoryFilter: TComboBox
            Left = 91
            Top = 41
            Width = 233
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
            OnChange = ComboBoxCategoryFilterChange
          end
          object ComboBoxSubCategoryFilter: TComboBox
            Left = 91
            Top = 66
            Width = 233
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 2
            OnChange = ComboBoxSubCategoryFilterChange
          end
          object rbAll: TRadioButton
            Left = 210
            Top = 98
            Width = 113
            Height = 17
            Caption = 'Show ALL items'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 3
            OnClick = rbAllClick
          end
          object rbExpSite: TRadioButton
            Left = 9
            Top = 98
            Width = 182
            Height = 17
            Caption = 'Show Site Expected Items'
            Checked = True
            TabOrder = 4
            TabStop = True
            OnClick = rbAllClick
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 123
        Width = 549
        Height = 383
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel2'
        TabOrder = 1
        DesignSize = (
          549
          383)
        object WasteLabel: TLabel
          Left = 64
          Top = 5
          Width = 61
          Height = 13
          Caption = 'Waste List'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object LabelNote: TLabel
          Left = 64
          Top = 323
          Width = 28
          Height = 13
          Caption = 'Note'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object AddBitBtn: TBitBtn
          Left = 3
          Top = 113
          Width = 50
          Height = 40
          Action = ActAddWaste
          Caption = '&Add'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
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
          Layout = blGlyphBottom
          NumGlyphs = 2
        end
        object DeleteBitBtn: TBitBtn
          Left = 3
          Top = 157
          Width = 50
          Height = 40
          Action = ActDeleteWaste
          Caption = '&Delete'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
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
          Layout = blGlyphBottom
          NumGlyphs = 2
        end
        object EditBitBtn: TBitBtn
          Left = 3
          Top = 201
          Width = 50
          Height = 40
          Action = ActEditWaste
          Caption = '&Edit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          Layout = blGlyphBottom
          NumGlyphs = 2
        end
        object wwDBGrid2: TwwDBGrid
          Left = 64
          Top = 21
          Width = 481
          Height = 296
          LineStyle = glsSingle
          Selected.Strings = (
            'PurN'#9'40'#9'Name'#9'F'
            'Unit'#9'6'#9'Unit'#9'F'
            'Qty'#9'6'#9'Qty'#9'F'
            'Sub'#9'20'#9'Sub-Cat'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsPCWaste
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
          ParentFont = False
          TabOrder = 3
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnCalcCellColors = wwDBGrid2CalcCellColors
          OnDblClick = wwDBGrid2DblClick
          IndicatorIconColor = clWindowText
        end
        object DBMemoNote: TDBMemo
          Left = 64
          Top = 338
          Width = 479
          Height = 43
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Note'
          DataSource = dsPCWaste
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 4
        end
      end
    end
  end
  object dsTmpProducts: TDataSource
    DataSet = adottmpProducts
    Left = 64
    Top = 52
  end
  object adottmpProducts: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'Expected=1'
    IndexFieldNames = 'Sub;Name'
    TableName = '#tmpproducts'
    Left = 32
    Top = 52
  end
  object adoqLoadTmpProducts: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      
        'IF object_id('#39'tempdb..#tmpProducts'#39') IS NOT NULL DROP TABLE #tmp' +
        'Products'
      ''
      'SELECT se.[EntityCode], se.[Cat], se.[Div], se.[SCat] as Sub,'
      'se.[PurchaseName] as Name,'
      
        'CASE se.ETCode WHEN '#39'P'#39' THEN '#39'Prep.- '#39' + isNULL(p.[Retail Descri' +
        'ption], '#39#39') ELSE p.[Retail Description] END  as Descr,'
      'se.[PurchaseUnit] as PurUnit,'
      
        'CASE se.ETCode WHEN '#39'P'#39' THEN se.ETCode ELSE '#39#39' END as ETCode, CA' +
        'ST(0 as bit) as Expected'
      'INTO dbo.#tmpProducts'
      'FROM stkEntity se'
      'JOIN products p'
      'on se.EntityCode = p.EntityCode'
      
        'WHERE se.[EntityType] IN ('#39'Strd.Line'#39', '#39'Purch.Line'#39', '#39'Prep.Item'#39 +
        ')'
      'and ((p.Deleted <> '#39'Y'#39') or (p.Deleted is null))'
      'ORDER BY Sub,Name')
    Left = 32
    Top = 84
  end
  object dsPCWaste: TDataSource
    DataSet = adotstkPCWaste
    Left = 540
    Top = 172
  end
  object ActionList1: TActionList
    Left = 32
    Top = 116
    object ActAddWaste: TAction
      Category = 'Edit'
      Caption = '&Add'
      OnExecute = ActAddWasteExecute
    end
    object ActDeleteWaste: TAction
      Category = 'Edit'
      Caption = '&Delete'
      OnExecute = ActDeleteWasteExecute
      OnUpdate = ActDeleteWasteUpdate
    end
    object ActEditWaste: TAction
      Category = 'Edit'
      Caption = '&Edit'
      OnExecute = ActEditWasteExecute
      OnUpdate = ActEditWasteUpdate
    end
    object ActIncrementalSearch: TAction
      Category = 'Search'
      AutoCheck = True
      Caption = 'Incremental Search'
      Checked = True
      GroupIndex = 1
      ShortCut = 118
      OnExecute = ActIncrementalSearchExecute
    end
    object ActMidwordSearch: TAction
      Category = 'Search'
      AutoCheck = True
      Caption = 'Midword Search'
      GroupIndex = 1
      ShortCut = 119
      OnExecute = ActMidwordSearchExecute
    end
    object ActSearchPrev: TAction
      Category = 'Search'
      Caption = 'Prev (F2)'
      ShortCut = 113
      OnExecute = ActSearchPrevExecute
    end
    object ActSearchNext: TAction
      Category = 'Search'
      Caption = 'Next (F3)'
      ShortCut = 114
      OnExecute = ActSearchNextExecute
    end
    object ActSave: TAction
      Category = 'Edit'
      Caption = '&Save'
      OnExecute = ActSaveExecute
      OnUpdate = ActSaveUpdate
    end
  end
  object adotstkPCWaste: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    IndexFieldNames = 'grp;recid'
    TableName = '[#pcwaste]'
    Left = 508
    Top = 172
    object adotstkPCWastePurN: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 40
      FieldName = 'PurN'
      Size = 40
    end
    object adotstkPCWasteUnit: TStringField
      DisplayWidth = 10
      FieldName = 'Unit'
      Size = 10
    end
    object adotstkPCWasteQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      OnGetText = adotstkPCWasteQtyGetText
    end
    object adotstkPCWasteSub: TStringField
      DisplayLabel = 'Sub-Cat'
      DisplayWidth = 20
      FieldName = 'Sub'
    end
    object adotstkPCWasteRecID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RecID'
      Visible = False
    end
    object adotstkPCWasteEntityCode: TFloatField
      DisplayWidth = 10
      FieldName = 'EntityCode'
      Visible = False
    end
    object adotstkPCWastegrp: TIntegerField
      DisplayWidth = 10
      FieldName = 'grp'
      Visible = False
    end
    object adotstkPCWasteBaseUnits: TFloatField
      DisplayWidth = 10
      FieldName = 'BaseUnits'
      Visible = False
    end
    object adotstkPCWasterecid2: TIntegerField
      DisplayWidth = 10
      FieldName = 'recid2'
      Visible = False
    end
    object adotstkPCWasteDescr: TStringField
      DisplayWidth = 20
      FieldName = 'Descr'
      Visible = False
      Size = 47
    end
    object adotstkPCWasteNote: TStringField
      DisplayWidth = 255
      FieldName = 'Note'
      Visible = False
      Size = 255
    end
    object adotstkPCWasteETCode: TStringField
      FieldName = 'ETCode'
      Size = 1
    end
  end
  object adoqPCWaste: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'IF object_id('#39'tempdb..#PCWaste'#39') IS NOT NULL DROP TABLE #PCWaste'
      ''
      'CREATE TABLE #PCWaste ('
      '  [RecID] [int] NULL,'
      '  [EntityCode] [float] NULL,'
      '  [Sub] [varchar] (20) NULL,'
      '  [PurN] [varchar] (40) NULL,'
      '  [grp] [int] NULL,'
      '  [Qty] [float] NULL,'
      '  [Unit] [varchar] (10) NULL,'
      '  [BaseUnits] [float] NULL,'
      '  [recid2] [int],'
      '  [Descr] [varchar] (47) NULL,'
      '  [Note] [varchar] (255) NULL,'
      '  [WasteDt] [datetime] NOT NULL,'
      '  [ETCode] [varchar] (1) NULL,'
      '  [Parent] [float] NULL'
      ')')
    Left = 508
    Top = 204
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dsTmpProducts
    SearchField = 'Name'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 420
    Top = 460
  end
end
