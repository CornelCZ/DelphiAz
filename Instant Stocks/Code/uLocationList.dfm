object fLocationList: TfLocationList
  Left = 122
  Top = 71
  AutoScroll = False
  Caption = 'Set Product List for Locations'
  ClientHeight = 608
  ClientWidth = 1073
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 955
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 494
    Width = 1073
    Height = 114
    Align = alBottom
    TabOrder = 1
    object Bevel4: TBevel
      Left = 662
      Top = 8
      Width = 149
      Height = 102
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel1: TBevel
      Left = 529
      Top = 4
      Width = 5
      Height = 106
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
      Left = 222
      Top = 51
      Width = 102
      Height = 53
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
      Left = 16
      Top = 66
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
      Left = 7
      Top = 92
      Width = 64
      Height = 13
      Caption = 'Sub-Categ:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 669
      Top = 1
      Width = 132
      Height = 13
      Caption = ' List Grid selected row '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnInsert: TBitBtn
      Left = 538
      Top = 39
      Width = 106
      Height = 28
      Caption = 'Insert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnInsertClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object DeleteBitBtn: TBitBtn
      Left = 668
      Top = 16
      Width = 138
      Height = 28
      Caption = 'Remove from List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = DeleteBitBtnClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object btnAppend: TBitBtn
      Left = 538
      Top = 6
      Width = 106
      Height = 28
      Caption = 'Append'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnAppendClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object lookCat: TComboBox
      Left = 72
      Top = 62
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
      TabOrder = 3
      OnCloseUp = lookCatCloseUp
    end
    object lookSCat: TComboBox
      Left = 72
      Top = 88
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
      TabOrder = 4
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
      TabOrder = 5
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
      TabOrder = 6
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
      TabOrder = 7
    end
    object btnNoFilter: TBitBtn
      Left = 431
      Top = 45
      Width = 95
      Height = 30
      Caption = 'Filters Off (F6)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = btnNoFilterClick
    end
    object btnFilter: TBitBtn
      Left = 330
      Top = 45
      Width = 95
      Height = 30
      Caption = 'Filter (F5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = btnFilterClick
    end
    object cbProdsNoLocation: TCheckBox
      Left = 11
      Top = 20
      Width = 190
      Height = 21
      Caption = 'Products not in any Location'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = cbProdsNoLocationClick
    end
    object Panel2: TPanel
      Left = 947
      Top = 1
      Width = 125
      Height = 112
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 13
      object btnReturnChangeList: TBitBtn
        Left = 2
        Top = 12
        Width = 119
        Height = 37
        Caption = 'Change List && '#10' Return to Audit '
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnClick = btnReturnChangeListClick
      end
      object btnReturnNoChange: TBitBtn
        Left = 2
        Top = 63
        Width = 119
        Height = 37
        Caption = 'Return to Audit '#10' (no change) '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnClick = btnReturnNoChangeClick
      end
      object btnDiscard: TBitBtn
        Left = 2
        Top = 36
        Width = 119
        Height = 30
        Caption = 'Discard Changes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnDiscardClick
      end
      object btnSave: TBitBtn
        Left = 2
        Top = 2
        Width = 119
        Height = 30
        Caption = 'Save Changes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnDone: TBitBtn
        Left = 2
        Top = 75
        Width = 119
        Height = 34
        Caption = 'Done'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        TabOrder = 2
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
    object btnRemoveProduct: TBitBtn
      Left = 668
      Top = 46
      Width = 138
      Height = 31
      Caption = 'Remove all Rows'#10' with selected Product'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = btnRemoveProductClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object cbProdsNotThisLocation: TCheckBox
      Left = 11
      Top = 39
      Width = 190
      Height = 21
      Caption = 'Products not in this Location'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object editMove: TEdit
      Left = 756
      Top = 85
      Width = 43
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 12
      Text = '0'
      OnKeyPress = editMoveKeyPress
    end
    object btnMoveTo: TBitBtn
      Left = 671
      Top = 85
      Width = 87
      Height = 21
      Caption = 'Move to Row:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = btnMoveToClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object btnAdvFilter: TBitBtn
      Left = 330
      Top = 79
      Width = 95
      Height = 30
      Caption = 'Advanced (F7)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = btnAdvFilterClick
    end
    object btnResetFilters: TBitBtn
      Left = 431
      Top = 79
      Width = 95
      Height = 30
      Caption = 'Reset Filters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = btnResetFiltersClick
    end
    object btnPrintSample: TBitBtn
      Left = 538
      Top = 81
      Width = 106
      Height = 28
      Caption = 'Print List Sample'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      OnClick = btnPrintSampleClick
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1073
    Height = 97
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1073
      97)
    object lblDivision: TLabel
      Left = 10
      Top = 7
      Width = 46
      Height = 13
      Caption = 'Division'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lblLocation: TLabel
      Left = 5
      Top = 30
      Width = 50
      Height = 13
      Caption = 'Location'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 919
      Top = 76
      Width = 149
      Height = 20
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Location List Grid'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object lblTopInfo: TLabel
      Left = 221
      Top = 1
      Width = 711
      Height = 31
      AutoSize = False
      Caption = 
        ' Products Grid: use Buttons or Drag-Drop, Dbl-Click, "Ins" key t' +
        'o Insert in List; Drag-Drop, "Space" key to Append to List. '#13#10' L' +
        'ist Grid Re-order: Drag-and-Drop or Ctrl - Home/Up/Down/End keys' +
        '; Remove from List: "Del" key, Dbl-Click or use button.'
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
      Left = 178
      Top = 77
      Width = 46
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '99999'
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
    object lblLocHasFixedQty: TLabel
      Left = 59
      Top = 46
      Width = 156
      Height = 11
      Alignment = taCenter
      AutoSize = False
      Caption = 'Fixed Inventory Location'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      Visible = False
    end
    object Label1: TLabel
      Left = 2
      Top = 76
      Width = 174
      Height = 20
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Available Products Grid'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object cbShowExpectedOnly: TCheckBox
      Left = 6
      Top = 62
      Width = 211
      Height = 12
      Caption = 'Show only Expected Products'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      OnClick = cbShowExpectedOnlyClick
    end
    object lookDiv: TwwDBComboBox
      Left = 58
      Top = 2
      Width = 159
      Height = 21
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoSize = False
      DropDownCount = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 0
      UnboundDataType = wwDefault
      OnCloseUp = lookDivCloseUp
    end
    object lookLocation: TwwDBComboBox
      Left = 58
      Top = 25
      Width = 159
      Height = 21
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoSize = False
      DropDownCount = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 1
      UnboundDataType = wwDefault
      OnCloseUp = lookLocationCloseUp
    end
    object pnlSearch: TPanel
      Left = 225
      Top = 38
      Width = 541
      Height = 59
      BevelOuter = bvNone
      TabOrder = 2
      object Bevel2: TBevel
        Left = 2
        Top = 0
        Width = 536
        Height = 58
        Shape = bsFrame
        Style = bsRaised
      end
      object Label14: TLabel
        Left = 7
        Top = 9
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
        Top = 29
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
        Top = 29
        Width = 127
        Height = 21
        Caption = 'Mid-Word Search'
        TabOrder = 1
        OnClick = rbSIncClick
      end
      object btnPriorSearch: TBitBtn
        Left = 319
        Top = 3
        Width = 85
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
        Top = 29
        Width = 85
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
        Left = 407
        Top = 3
        Width = 128
        Height = 48
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object Label3: TLabel
          Left = 19
          Top = 1
          Width = 105
          Height = 20
          AutoSize = False
          Caption = ' for Products Grid'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          OnClick = rbSearchProdsClick
        end
        object Label7: TLabel
          Left = 19
          Top = 27
          Width = 105
          Height = 20
          AutoSize = False
          Caption = ' for List Grid'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          OnClick = rbSearchProdsClick
        end
        object rbSearchProds: TRadioButton
          Left = 3
          Top = 1
          Width = 18
          Height = 20
          Checked = True
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
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
          Width = 18
          Height = 20
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
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
        Top = 5
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
        Top = 5
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
  object pnlList: TPanel
    Left = 0
    Top = 97
    Width = 1073
    Height = 397
    Align = alClient
    TabOrder = 2
    object Splitter3: TSplitter
      Left = 553
      Top = 1
      Width = 9
      Height = 395
      Cursor = crHSplit
      Beveled = True
      Color = clBlue
      MinSize = 360
      ParentColor = False
    end
    object gridList: TwwDBGrid
      Left = 562
      Top = 1
      Width = 510
      Height = 395
      PictureMasks.Strings = (
        'StringFixedQty'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'T'#9'T')
      Selected.Strings = (
        'RecID'#9'4'#9'Row'#9'T'
        'Name'#9'30'#9'Product Name'#9'T'
        'Unit'#9'10'#9'Unit'#9'T'
        'StringFixedQty'#9'9'#9'Fixed Qty'#9'F'
        'inList'#9'4'#9'Entries'#9'T'
        'SCat'#9'20'#9'Sub-Category'#9'T'
        'Descr'#9'30'#9'Description'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      OnRowChanged = gridListRowChanged
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
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
      OnDblClick = gridListDblClick
      OnDragDrop = gridListDragDrop
      OnDragOver = gridListDragOver
      OnEndDrag = gridListEndDrag
      OnMouseDown = gridListMouseDown
    end
    object gridProds: TwwDBGrid
      Left = 1
      Top = 1
      Width = 552
      Height = 395
      Selected.Strings = (
        'Sub-Category'#9'18'#9'Sub-Category'#9'F'
        'Product Name'#9'28'#9'Product Name'#9'F'
        'Unit'#9'10'#9'Unit'#9#9
        'In List'#9'3'#9'In List'#9#9
        'Description'#9'28'#9'Description'#9'F')
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
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTrailingEllipsis, dgShowCellHint]
      ParentFont = False
      PopupMenu = gridPopup
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
      OnDblClick = gridProdsDblClick
      OnDragDrop = gridProdsDragDrop
      OnDragOver = gridProdsDragOver
      OnEndDrag = gridProdsEndDrag
      OnMouseDown = gridProdsMouseDown
    end
  end
  object dsProds: TwwDataSource
    DataSet = adotProds
    Left = 360
    Top = 352
  end
  object adotProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = '#AllProducts'
    Left = 328
    Top = 352
  end
  object dsList: TwwDataSource
    DataSet = adotList
    Left = 544
    Top = 352
  end
  object adotList: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = adotListBeforePost
    AfterPost = adotListAfterPost
    IndexFieldNames = 'recid'
    TableName = '#LocationList'
    Left = 512
    Top = 352
    object adotListRecID: TIntegerField
      FieldName = 'RecID'
    end
    object adotListEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object adotListSCat: TStringField
      FieldName = 'SCat'
    end
    object adotListName: TStringField
      FieldName = 'Name'
      Size = 40
    end
    object adotListUnit: TStringField
      FieldName = 'Unit'
      Size = 10
    end
    object adotListManualAdd: TBooleanField
      FieldName = 'ManualAdd'
    end
    object adotListrecid2: TIntegerField
      FieldName = 'recid2'
    end
    object adotListDescr: TStringField
      FieldName = 'Descr'
      Size = 40
    end
    object adotListisPrepItem: TStringField
      FieldName = 'isPrepItem'
      Size = 1
    end
    object adotListisPurchUnit: TIntegerField
      FieldName = 'isPurchUnit'
    end
    object adotListinList: TIntegerField
      FieldName = 'inList'
    end
    object adotListFixedQty: TFloatField
      FieldName = 'FixedQty'
    end
    object adotListStringFixedQty: TStringField
      Alignment = taRightJustify
      FieldName = 'StringFixedQty'
      Size = 10
    end
  end
  object ScrollTimer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = ScrollTimerTimer
    Left = 592
    Top = 304
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
  object wwFill: TwwFilterDialog
    DataSource = dsProds
    Options = [fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdSizeable]
    SortBy = fdSortByFieldNo
    FilterMethod = fdByFilter
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    FilterPropertyOptions.DatasetFilterType = fdUseFilterProp
    FilterPropertyOptions.UseLikeOperator = True
    FilterPropertyOptions.LikeWildcardChar = '%'
    FilterOptimization = fdUseAllIndexes
    QueryFormatDateMode = qfdYearMonthDay
    SQLTables = <>
    Left = 488
    Top = 168
  end
  object gridPopup: TPopupMenu
    Left = 200
    Top = 296
    object Category1: TMenuItem
      AutoCheck = True
      Caption = 'Category'
      OnClick = Category1Click
    end
    object SubCategory1: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = 'Sub-Category'
      Checked = True
      OnClick = Category1Click
    end
    object ProductID1: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = 'Product ID'
      OnClick = Category1Click
    end
    object ProductName1: TMenuItem
      Tag = 3
      AutoCheck = True
      Caption = 'Product Name'
      Checked = True
      Enabled = False
      OnClick = Category1Click
    end
    object Unit1: TMenuItem
      Tag = 7
      AutoCheck = True
      Caption = 'Unit'
      Checked = True
      Enabled = False
      OnClick = Category1Click
    end
    object InList1: TMenuItem
      AutoCheck = True
      Caption = 'In List'
      Checked = True
      OnClick = Category1Click
    end
    object Description1: TMenuItem
      Tag = 4
      AutoCheck = True
      Caption = 'Description'
      Checked = True
      OnClick = Category1Click
    end
    object Barcodes1: TMenuItem
      Tag = 6
      AutoCheck = True
      Caption = 'Barcodes'
      OnClick = Category1Click
    end
    object ImpExpRef1: TMenuItem
      Tag = 8
      AutoCheck = True
      Caption = 'Imp-Exp Ref'
      OnClick = Category1Click
    end
    object DefaultSupplier1: TMenuItem
      Tag = 9
      AutoCheck = True
      Caption = 'Default Supplier'
      OnClick = Category1Click
    end
  end
end
