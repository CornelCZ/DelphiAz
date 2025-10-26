object fViewDeleted: TfViewDeleted
  Left = 594
  Top = 203
  Width = 800
  Height = 521
  Caption = 'Deleted Promotions'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panelBottom: TPanel
    Left = 0
    Top = 396
    Width = 784
    Height = 86
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      784
      86)
    object Label13: TLabel
      Left = 6
      Top = 6
      Width = 106
      Height = 13
      Caption = 'Name OR Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFilterStatus: TLabel
      Left = 161
      Top = 49
      Width = 240
      Height = 32
      Alignment = taCenter
      AutoSize = False
      Caption = 'Filtering is OFF'
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
    object LabelSubCategory: TLabel
      Left = 5
      Top = 64
      Width = 27
      Height = 13
      Caption = 'Type:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edFilt: TEdit
      Left = 115
      Top = 2
      Width = 287
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object rbStart: TRadioButton
      Left = 199
      Top = 25
      Width = 93
      Height = 17
      Caption = 'Match at Start'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = True
    end
    object rbMid: TRadioButton
      Left = 297
      Top = 25
      Width = 103
      Height = 17
      Caption = 'Match Anywhere'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnFilter: TBitBtn
      Left = 407
      Top = 2
      Width = 80
      Height = 24
      Caption = 'Filter On (F5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnFilterClick
    end
    object btnNoFilter: TBitBtn
      Left = 407
      Top = 29
      Width = 80
      Height = 24
      Caption = 'Filter Off (F6)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnNoFilterClick
    end
    object btnResetFilters: TBitBtn
      Left = 407
      Top = 57
      Width = 80
      Height = 24
      Caption = 'Reset Filters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnResetFiltersClick
    end
    object lookType: TComboBox
      Left = 35
      Top = 60
      Width = 122
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 7
    end
    object cbDeal: TCheckBox
      Left = 5
      Top = 41
      Width = 145
      Height = 19
      Caption = 'Show Only Deals'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object cbEvOnly: TCheckBox
      Left = 5
      Top = 25
      Width = 146
      Height = 19
      Caption = 'Show Event Only Promos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object btnRestore: TButton
      Left = 650
      Top = 2
      Width = 120
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Restore Selected'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnRestoreClick
    end
    object Button1: TButton
      Left = 650
      Top = 51
      Width = 120
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 10
    end
  end
  object panelTop: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 52
    Align = alTop
    TabOrder = 1
    DesignSize = (
      784
      52)
    object lblProdCount: TLabel
      Left = 725
      Top = 32
      Width = 45
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
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
    object Label1: TLabel
      Left = 590
      Top = 34
      Width = 132
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'No. of Archived Promotions:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object pnlSearch: TPanel
      Left = 2
      Top = 1
      Width = 396
      Height = 47
      BevelOuter = bvNone
      TabOrder = 0
      object Label14: TLabel
        Left = 7
        Top = 9
        Width = 116
        Height = 13
        Caption = 'Promo Name Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rbSInc: TRadioButton
        Left = 16
        Top = 27
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
        Top = 27
        Width = 127
        Height = 21
        Caption = 'Mid-Word Search'
        TabOrder = 1
        OnClick = rbSIncClick
      end
      object btnPriorSearch: TBitBtn
        Left = 319
        Top = 3
        Width = 71
        Height = 21
        Caption = 'Prev (F2)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
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
        Top = 26
        Width = 71
        Height = 21
        Caption = 'Next (F3)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnNextSearchClick
        Glyph.Data = {
          6A000000424D6A000000000000003E000000280000000A0000000B0000000100
          0100000000002C0000000000000000000000020000000200000000000000FFFF
          FF00FFC00000F3C00000F3C00000E1C00000E1C00000C0C00000C0C000008040
          0000804000000000000000000000}
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
        TabOrder = 5
        Visible = False
      end
      object incSearch1: TwwIncrementalSearch
        Left = 128
        Top = 5
        Width = 190
        Height = 21
        DataSource = dmPromotions.dsViewDeleted
        SearchField = 'Name'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
      end
    end
  end
  object GridDelPromos: TwwDBGrid
    Left = 0
    Top = 52
    Width = 784
    Height = 344
    ControlType.Strings = (
      'EventOnly;CheckBox;1;0'
      'UserSelectsProducts;CheckBox;1;0')
    Selected.Strings = (
      'Name'#9'21'#9'Name'#9#9
      'Description'#9'41'#9'Description'#9'F'#9
      'PromoTypeName'#9'12'#9'Type'#9#9
      'EventOnly'#9'6'#9'Evt Only'#9#9
      'UserSelectsProducts'#9'5'#9'Deal'#9#9
      'StartDate'#9'10'#9'Start Date'#9#9
      'EndDate'#9'10'#9'End Date'#9#9
      'ArchivedDT'#9'12'#9'Deleted On'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dmPromotions.dsViewDeleted
    KeyOptions = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTrailingEllipsis]
    ReadOnly = True
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    OnCalcTitleAttributes = GridDelPromosCalcTitleAttributes
    OnTitleButtonClick = GridDelPromosTitleButtonClick
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dmPromotions.dsViewDeleted
    SearchField = 'Name'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 488
    Top = 136
  end
end
