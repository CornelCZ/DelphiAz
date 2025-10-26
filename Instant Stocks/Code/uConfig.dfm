object ConfigForm: TConfigForm
  Left = 336
  Top = 114
  HelpContext = 1028
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Site Configuration'
  ClientHeight = 530
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 869
    Height = 489
    ActivePage = tabMandatoryLineCheck
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabIndex = 4
    TabOrder = 0
    OnChange = PageControl1Change
    object tabGlobal: TTabSheet
      Caption = 'Global Settings'
      ImageIndex = 3
      DesignSize = (
        861
        461)
      object Label24: TLabel
        Left = 3
        Top = 2
        Width = 773
        Height = 23
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'These settings apply to each installed instance of the software ' +
          'controlled from this Head Office'
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
      object lblStockType: TLabel
        Left = 21
        Top = 146
        Width = 66
        Height = 13
        Caption = 'Stock Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BitBtn15: TBitBtn
        Left = 716
        Top = 368
        Width = 139
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'Save Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = BitBtn15Click
        Glyph.Data = {
          06020000424D0602000000000000760000002800000019000000190000000100
          04000000000090010000330B0000330B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
          CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
          CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
          CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
          CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
          70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
          70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
          70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
          7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
          7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
          7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
          AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
          9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
          99999999AAAAA0000000}
        Spacing = 10
      end
      object BitBtn16: TBitBtn
        Left = 716
        Top = 413
        Width = 139
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'Discard Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = BitBtn16Click
        Glyph.Data = {
          F6010000424DF601000000000000760000002800000019000000180000000100
          04000000000080010000230B0000230B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
          99999999999990000000999999999999999999999999900000009F99F9FFFF99
          FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
          9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
          99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
          99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
          AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
          00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
          A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
          A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
          A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
          AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
          AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
      end
      object cbLCzeroLG: TCheckBox
        Left = 21
        Top = 48
        Width = 321
        Height = 17
        Caption = 'Show Line Checks on Reports even if Variance = 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = cbLCzeroLGClick
      end
      object cbPcWAtoMisc: TCheckBox
        Left = 21
        Top = 80
        Width = 468
        Height = 17
        Caption = 
          'Set Misc Allowance #1 to be the SUM of PC Wastage Adjustment Ret' +
          'ail Value'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = cbLCzeroLGClick
      end
      object cbxStockType: TComboBox
        Left = 21
        Top = 159
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        OnChange = cbxStockTypeChange
        Items.Strings = (
          'Category'
          'Sub-Category')
      end
      object cbNoCountSheetDlg: TCheckBox
        Left = 21
        Top = 113
        Width = 321
        Height = 17
        Caption = 'Suppress the Count Sheet Dialog'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = cbLCzeroLGClick
      end
    end
    object tabPW: TTabSheet
      Caption = 'Automatic Wastage'
      DesignSize = (
        861
        461)
      object Bevel1: TBevel
        Left = 685
        Top = 6
        Width = 170
        Height = 144
        Anchors = [akTop, akRight]
        Shape = bsFrame
        Style = bsRaised
      end
      object Bevel2: TBevel
        Left = 685
        Top = 160
        Width = 170
        Height = 212
        Anchors = [akTop, akRight]
        Shape = bsFrame
        Style = bsRaised
      end
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 385
        Height = 29
        AutoSize = False
        Caption = 
          'Click on a Field Title to order grid by that field. Use the sear' +
          'ch box to do incremental search on Purchase Name.'
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
      object Label2: TLabel
        Left = 691
        Top = 0
        Width = 70
        Height = 13
        Anchors = [akTop, akRight]
        Caption = ' Grid Filters '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 691
        Top = 153
        Width = 150
        Height = 13
        Anchors = [akTop, akRight]
        Caption = ' Auto Waste Set or Reset '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 688
        Top = 189
        Width = 164
        Height = 99
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 
          '- Type Qty > 0 in edit box '#13#10'  and press ENTER key to'#13#10'  set Aut' +
          'o Waste for an item'#13#10'- Type 0 in edit box  and '#13#10'  press ENTER k' +
          'ey to Reset '#13#10'- You can choose a Waste'#13#10'  Unit from the drop-dow' +
          'n'
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
      object lblWastageQuantity: TLabel
        Left = 689
        Top = 291
        Width = 152
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Edit Waste Qty; 0 to Reset'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblWastageUnit: TLabel
        Left = 689
        Top = 333
        Width = 110
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Choose Waste Unit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblProductName: TDBText
        Left = 688
        Top = 169
        Width = 164
        Height = 17
        Alignment = taCenter
        Anchors = [akTop, akRight]
        Color = clWhite
        DataField = 'RetN'
        DataSource = wwDataSource1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Shape1: TShape
        Left = 388
        Top = 4
        Width = 246
        Height = 33
        Anchors = [akLeft, akTop, akRight]
        Brush.Style = bsClear
        Pen.Width = 2
      end
      object Label7: TLabel
        Left = 408
        Top = -2
        Width = 115
        Height = 13
        Alignment = taCenter
        Caption = ' Incremental Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 693
        Top = 17
        Width = 46
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Division'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 693
        Top = 55
        Width = 51
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Category'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 693
        Top = 94
        Width = 77
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Sub-Category'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelDel: TLabel
        Left = 835
        Top = 169
        Width = 16
        Height = 17
        Hint = 'Double Click this...'
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
        Color = clRed
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
        Visible = False
        OnDblClick = labelDelDblClick
      end
      object wwDBGrid1: TwwDBGrid
        Left = 0
        Top = 31
        Width = 684
        Height = 420
        Selected.Strings = (
          'Div'#9'20'#9'Division'#9#9
          'Cat'#9'20'#9'Category'#9#9
          'Sub'#9'20'#9'Sub-Category'#9#9
          'PurN'#9'40'#9'Purchase Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight]
        DataSource = wwDataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
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
      end
      object edtWastageQuantity: TwwDBEdit
        Left = 689
        Top = 305
        Width = 121
        Height = 21
        Anchors = [akTop, akRight]
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtWastageQuantityExit
        OnKeyPress = edtWastageQuantityKeyPress
      end
      object cmbbxWastageUnit: TwwDBLookupCombo
        Left = 689
        Top = 347
        Width = 121
        Height = 21
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Choose Unit'#9'10'#9'Choose Unit'#9#9)
        DataField = 'awUnit'
        DataSource = wwDataSource1
        LookupTable = adoqAWU
        LookupField = 'Choose Unit'
        Options = [loColLines, loRowLines, loTitles]
        Style = csDropDownList
        DropDownCount = 10
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cmbbxWastageUnitCloseUp
      end
      object lookDiv: TComboBox
        Left = 693
        Top = 29
        Width = 155
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
        OnCloseUp = lookDivCloseUp
      end
      object lookCat: TComboBox
        Left = 693
        Top = 68
        Width = 155
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 4
        OnCloseUp = lookCatCloseUp
      end
      object lookSCat: TComboBox
        Left = 693
        Top = 107
        Width = 155
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 5
        OnCloseUp = lookSCatCloseUp
      end
      object wwIncrementalSearch2: TwwIncrementalSearch
        Left = 393
        Top = 10
        Width = 236
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataSource = wwDataSource1
        SearchField = 'PurN'
        TabOrder = 6
      end
      object BitBtn1: TBitBtn
        Left = 689
        Top = 377
        Width = 165
        Height = 34
        Anchors = [akTop, akRight]
        Caption = 'Save Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnClick = BitBtn1Click
        Glyph.Data = {
          06020000424D0602000000000000760000002800000019000000190000000100
          04000000000090010000330B0000330B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
          CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
          CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
          CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
          CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
          70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
          70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
          70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
          7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
          7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
          7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
          AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
          9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
          99999999AAAAA0000000}
        Margin = 17
        Spacing = 10
      end
      object BitBtn2: TBitBtn
        Left = 689
        Top = 417
        Width = 165
        Height = 34
        Anchors = [akTop, akRight]
        Caption = 'Discard Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = BitBtn2Click
        Glyph.Data = {
          F6010000424DF601000000000000760000002800000019000000180000000100
          04000000000080010000230B0000230B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
          99999999999990000000999999999999999999999999900000009F99F9FFFF99
          FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
          9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
          99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
          99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
          AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
          00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
          A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
          A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
          A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
          AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
          AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
      end
      object cbAWonly: TCheckBox
        Left = 690
        Top = 132
        Width = 161
        Height = 16
        Anchors = [akTop, akRight]
        Caption = 'Only items with Auto Waste'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = cbAWonlyClick
      end
    end
    object tabLoc_HZ: TTabSheet
      Caption = 'Count Locations / Holding Zones'
      ImageIndex = 1
      object pagesLocOrHz: TPageControl
        Left = 0
        Top = 0
        Width = 861
        Height = 461
        ActivePage = tabLocations
        Align = alClient
        TabIndex = 0
        TabOrder = 0
        object tabLocations: TTabSheet
          Caption = 'Count Locations'
          object Bevel5: TBevel
            Left = 1
            Top = 4
            Width = 419
            Height = 36
            Shape = bsFrame
            Style = bsRaised
          end
          object Label6: TLabel
            Left = 16
            Top = 15
            Width = 112
            Height = 13
            Caption = ' Selected Division: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 3
            Top = 355
            Width = 62
            Height = 13
            Caption = 'Print Note:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object gridLocations: TwwDBGrid
            Left = 0
            Top = 46
            Width = 421
            Height = 231
            ControlType.Strings = (
              'HasFixedQty;CheckBox;True;False')
            Selected.Strings = (
              'LocationName'#9'23'#9'Location Name'#9'F'
              'allLines'#9'8'#9'Rows in~Location'#9'F'
              'unqProds'#9'8'#9'Unique~Products'#9'F'
              'LastEdit'#9'14'#9'Product List~Last Edited'#9'F'
              'HasFixedQty'#9'4'#9'Fixed~Stock'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = dsLocations
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = True
            UseTFields = False
            OnCalcCellColors = gridLocationsCalcCellColors
            OnDblClick = btnEditListClick
          end
          object cbShowDeletedLoc: TCheckBox
            Left = 246
            Top = 277
            Width = 167
            Height = 21
            Caption = 'Show Deleted Locations'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = cbShowDeletedLocClick
          end
          object wwDBEdit1: TwwDBEdit
            Left = 2
            Top = 368
            Width = 418
            Height = 63
            AutoSize = False
            Color = clSilver
            DataField = 'printnote'
            DataSource = dsLocations
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ShowVertScrollBar = True
            TabOrder = 2
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = True
          end
          object btnEditList: TBitBtn
            Left = 288
            Top = 305
            Width = 130
            Height = 36
            Caption = 'Edit Location'#10'Count List'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = btnEditListClick
          end
          object btnAddLocation: TBitBtn
            Left = 4
            Top = 305
            Width = 76
            Height = 36
            Caption = 'Add'#10'Location'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnClick = btnAddLocationClick
          end
          object btnEditLocation: TBitBtn
            Left = 90
            Top = 305
            Width = 76
            Height = 36
            Caption = 'Edit'#10'Location'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            OnClick = btnEditLocationClick
          end
          object btnDeleteLocation: TBitBtn
            Left = 176
            Top = 305
            Width = 85
            Height = 36
            Caption = 'Delete'#10'Location'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
            OnClick = btnDeleteLocationClick
          end
          object gridLocationList: TwwDBGrid
            Left = 423
            Top = 0
            Width = 430
            Height = 433
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alRight
            DataSource = dsLocationList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis]
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
          end
          object lookDivLoc: TwwDBComboBox
            Left = 133
            Top = 12
            Width = 192
            Height = 21
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            AutoSelect = False
            AutoSize = False
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            Sorted = True
            TabOrder = 8
            UnboundDataType = wwDefault
            OnCloseUp = lookDivLocCloseUp
          end
          object cbLCbyLoc: TCheckBox
            Left = 6
            Top = 277
            Width = 211
            Height = 21
            Caption = 'Use Locations for Line Checks'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 9
            OnClick = cbLCbyLocClick
          end
        end
        object tabHoldingZones: TTabSheet
          Caption = 'Holding Zones'
          ImageIndex = 1
          DesignSize = (
            853
            433)
          object Bevel3: TBevel
            Left = 468
            Top = 161
            Width = 378
            Height = 117
            Anchors = [akTop, akRight]
            Shape = bsFrame
            Style = bsRaised
          end
          object lblHoldingZoneStatus: TLabel
            Left = 476
            Top = 243
            Width = 165
            Height = 27
            Alignment = taCenter
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'INVALID'
            Color = clRed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
          end
          object Label26: TLabel
            Left = 316
            Top = 413
            Width = 89
            Height = 14
            Caption = 'or Dbl-Click record'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 231
            Top = 362
            Width = 89
            Height = 14
            Caption = 'or Dbl-Click record'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 648
            Top = 165
            Width = 194
            Height = 110
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 
              ' Conditions for Valid Settings:'#13#10'  '#13#10' a) More than 1 HZ to be se' +
              't  up;'#13#10' b) One (and only one) HZ to be '#13#10'     set up to accept ' +
              'purchases;'#13#10' c) At least 1 HZ to have Sales;'#13#10' d) All POS Termin' +
              'als (even the'#13#10'     ones Deleted) to be allocated'
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
          object Label13: TLabel
            Left = 476
            Top = 215
            Width = 165
            Height = 25
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Last time the settings '#13#10'were checked they were:'
            WordWrap = True
          end
          object Label12: TLabel
            Left = 405
            Top = 293
            Width = 217
            Height = 28
            AutoSize = False
            Caption = 'POS Terminals allocated to '#13#10'HZ: "Holding ZoneQWERTYMS" '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 4
            Top = 293
            Width = 162
            Height = 13
            Caption = 'POS Terminals not allocated'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object btnAcceptPurchases: TBitBtn
            Left = 467
            Top = 117
            Width = 185
            Height = 33
            Anchors = [akTop, akRight]
            Caption = 'Set HZ to accept Purchases'
            TabOrder = 0
            OnClick = btnAcceptPurchasesClick
          end
          object wwDBGrid3: TwwDBGrid
            Left = 3
            Top = 308
            Width = 226
            Height = 125
            ControlType.Strings = (
              'Deleted;CheckBox;True;False')
            Selected.Strings = (
              'Name'#9'20'#9'POS Name'#9'F'
              'Deleted'#9'1'#9'Deleted'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = wwDataSource3
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            UseTFields = False
            OnDblClick = btnAllocateToHZClick
          end
          object wwDBGrid2: TwwDBGrid
            Left = 405
            Top = 321
            Width = 226
            Height = 112
            ControlType.Strings = (
              'Deleted;CheckBox;True;False')
            Selected.Strings = (
              'Name'#9'20'#9'POS Name'#9'F'
              'Deleted'#9'1'#9'Deleted'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = wwDataSource4
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            TabOrder = 2
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            UseTFields = False
            OnDblClick = btnReleaseFromHZClick
          end
          object gridHZs: TwwDBGrid
            Left = 1
            Top = 5
            Width = 459
            Height = 273
            ControlType.Strings = (
              'ePur;CheckBox;True;False'
              'eOut;CheckBox;True;False'
              'eMoveIn;CheckBox;True;False'
              'eMoveOut;CheckBox;True;False'
              'eSales;CheckBox;True;False'
              'eWaste;CheckBox;True;False'
              'Active;CheckBox;True;False')
            Selected.Strings = (
              'hzName'#9'39'#9'Stock Holding Zone Name'#9'F'
              'Active'#9'7'#9'Active'#9'F'
              'ePur'#9'9'#9'Purchases'#9'F'
              'eSales'#9'12'#9'Sales'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            Anchors = [akLeft, akTop, akRight]
            DataSource = dsHZs
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgWordWrap, dgProportionalColResize]
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
            OnCalcCellColors = gridHZsCalcCellColors
            OnExit = gridHZsExit
            PaintOptions.ActiveRecordColor = clActiveCaption
          end
          object btnSaveChanges: TBitBtn
            Left = 706
            Top = 349
            Width = 139
            Height = 40
            Anchors = [akTop, akRight]
            Caption = 'Save Changes'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnClick = btnSaveChangesClick
            Glyph.Data = {
              06020000424D0602000000000000760000002800000019000000190000000100
              04000000000090010000330B0000330B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
              CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
              CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
              CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
              CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
              70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
              70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
              70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
              7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
              7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
              7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
              AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
              9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
              99999999AAAAA0000000}
            Spacing = 10
          end
          object btnReleaseFromHZ: TBitBtn
            Left = 232
            Top = 389
            Width = 171
            Height = 25
            Caption = '<= Release POS from HZ <='
            TabOrder = 5
            OnClick = btnReleaseFromHZClick
          end
          object btnNewZone: TBitBtn
            Left = 467
            Top = 29
            Width = 185
            Height = 33
            Anchors = [akTop, akRight]
            Caption = 'Add Stock Holding Zone'
            TabOrder = 6
            OnClick = btnNewZoneClick
          end
          object btnDiscardChanges: TBitBtn
            Left = 706
            Top = 393
            Width = 139
            Height = 40
            Anchors = [akTop, akRight]
            Caption = 'Discard Changes'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 7
            OnClick = btnDiscardChangesClick
            Glyph.Data = {
              F6010000424DF601000000000000760000002800000019000000180000000100
              04000000000080010000230B0000230B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
              99999999999990000000999999999999999999999999900000009F99F9FFFF99
              FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
              9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
              99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
              99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
              AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
              00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
              A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
              A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
              A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
              AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
              AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
          end
          object btnCheckSettings: TBitBtn
            Left = 474
            Top = 170
            Width = 165
            Height = 33
            Anchors = [akTop, akRight]
            Caption = 'Check Settings'
            TabOrder = 8
            OnClick = btnCheckSettingsClick
          end
          object btnAllocateToHZ: TBitBtn
            Left = 232
            Top = 338
            Width = 171
            Height = 25
            Caption = '=>  Allocate POS to HZ   =>'
            TabOrder = 9
            OnClick = btnAllocateToHZClick
          end
          object btnActivate: TBitBtn
            Left = 467
            Top = 73
            Width = 185
            Height = 33
            Anchors = [akTop, akRight]
            Caption = 'De-Activate Holding Zone'
            TabOrder = 10
            OnClick = btnActivateClick
          end
        end
      end
    end
    object tabMinStk: TTabSheet
      Caption = 'Min. Stock Levels '
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 24
        Width = 861
        Height = 437
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object gridMinLevel: TwwDBGrid
          Left = 0
          Top = 21
          Width = 671
          Height = 416
          PictureMasks.Strings = (
            'ACount'#9'#*#'#9'T'#9'T')
          Selected.Strings = (
            'DivisionName'#9'20'#9'Division'#9'F'
            'repHdr'#9'20'#9'repHdr'#9'F'
            'PurchaseName'#9'40'#9'Product Name'#9'F'
            'PurchUnit'#9'10'#9'Unit'#9'F'
            'ACount'#9'12'#9'Set Min. Level'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          OnRowChanged = gridMinLevelRowChanged
          FixedCols = 4
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = dsMinLevel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyOptions = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = True
          UseTFields = False
          OnCalcCellColors = gridMinLevelCalcCellColors
          OnCalcTitleAttributes = gridMinLevelCalcTitleAttributes
          OnTitleButtonClick = gridMinLevelTitleButtonClick
          OnExit = gridMinLevelExit
          PaintOptions.ActiveRecordColor = clHighlight
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 861
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            861
            21)
          object Label16: TLabel
            Left = 510
            Top = 1
            Width = 293
            Height = 17
            Alignment = taCenter
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Click on a Field Title to order grid by that field.'
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
          object Label17: TLabel
            Left = 46
            Top = 5
            Width = 213
            Height = 13
            Hint = 'To use the Search first order by Product Name'
            Alignment = taRightJustify
            Caption = 'Incremental Search on Product Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object prodSearch: TwwIncrementalSearch
            Left = 263
            Top = 1
            Width = 246
            Height = 21
            Hint = 'To use the Search first order by Product Name'
            Anchors = [akLeft, akTop, akRight]
            DataSource = dsMinLevel
            SearchField = 'PurchaseName'
            Color = clBtnFace
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 0
          end
        end
        object Panel5: TPanel
          Left = 671
          Top = 21
          Width = 190
          Height = 416
          Align = alRight
          Alignment = taLeftJustify
          BevelOuter = bvNone
          TabOrder = 2
          object Bevel4: TBevel
            Left = 5
            Top = 8
            Width = 180
            Height = 177
            Shape = bsFrame
            Style = bsRaised
          end
          object Label18: TLabel
            Left = 9
            Top = 2
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
          object Label19: TLabel
            Left = 11
            Top = 138
            Width = 93
            Height = 13
            Alignment = taRightJustify
            Caption = 'Min Stock Level'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label20: TLabel
            Left = 11
            Top = 80
            Width = 64
            Height = 13
            Caption = 'Sub Categ.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object Label21: TLabel
            Left = 11
            Top = 23
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
          object Label22: TLabel
            Left = 7
            Top = 189
            Width = 177
            Height = 108
            AutoSize = False
            Caption = 
              '  The "Complete Site" tab is'#13#10'  Read-Only and shows the '#13#10'  Site' +
              ' Summary.'#13#10' '#13#10'  Please type the Min. Levels'#13#10'  for each Holding ' +
              'Zone in its'#13#10'  respective tab.'
            Color = clTeal
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            Visible = False
            WordWrap = True
          end
          object BitBtn14: TBitBtn
            Left = 23
            Top = 368
            Width = 163
            Height = 36
            Caption = 'Discard Changes'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = BitBtn14Click
            Glyph.Data = {
              F6010000424DF601000000000000760000002800000019000000180000000100
              04000000000080010000230B0000230B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
              99999999999990000000999999999999999999999999900000009F99F9FFFF99
              FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
              9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
              99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
              99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
              AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
              00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
              A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
              A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
              A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
              AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
              AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
          end
          object BitBtn13: TBitBtn
            Left = 23
            Top = 320
            Width = 163
            Height = 36
            Caption = 'Save Changes'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = BitBtn13Click
            Glyph.Data = {
              06020000424D0602000000000000760000002800000019000000190000000100
              04000000000090010000330B0000330B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
              CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
              CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
              CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
              CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
              70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
              70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
              70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
              7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
              7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
              7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
              AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
              9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
              99999999AAAAA0000000}
            Margin = 17
            Spacing = 10
          end
          object lookSCMin: TComboBox
            Left = 11
            Top = 95
            Width = 167
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
            OnCloseUp = lookSCMinCloseUp
          end
          object lookMinLevel: TComboBox
            Left = 11
            Top = 152
            Width = 167
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
            OnCloseUp = lookMinLevelCloseUp
            Items.Strings = (
              ' - SHOW ALL - '
              'Min Level = 0 or NULL'
              'Min Level > 0')
          end
          object lookDivMin: TComboBox
            Left = 11
            Top = 38
            Width = 167
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
            OnCloseUp = lookDivMinCloseUp
          end
        end
      end
      object hzTabs: TPageControl
        Left = 0
        Top = 0
        Width = 861
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
        TabOrder = 1
        Visible = False
        OnChange = hzTabsChange
        object hzTab0: TTabSheet
          Caption = 'Complete Site'
          ImageIndex = -1
        end
      end
      object Panel3: TPanel
        Left = 40
        Top = 240
        Width = 409
        Height = 201
        TabOrder = 2
        object Label23: TLabel
          Left = 1
          Top = 1
          Width = 244
          Height = 24
          Align = alClient
          Alignment = taCenter
          Caption = 'Processing, Please Wait...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
      end
    end
    object tabMandatoryLineCheck: TTabSheet
      Caption = 'Mandatory Line Check'
      ImageIndex = 4
      DesignSize = (
        861
        461)
      object Label31: TLabel
        Left = 649
        Top = 165
        Width = 134
        Height = 31
        AutoSize = False
        Caption = 'Number of mandatory products to Line Check:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object pcMandatoryLineCheck: TPageControl
        Left = 0
        Top = 8
        Width = 634
        Height = 452
        ActivePage = tabMLCSiteSettings
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabIndex = 1
        TabOrder = 7
        OnChange = pcMandatoryLineCheckChange
        object tabMLCDefaultSettings: TTabSheet
          Caption = 'Default Settings'
          object gridDefaultSubcatSettings: TwwDBGrid
            Left = 0
            Top = 1
            Width = 306
            Height = 425
            ControlType.Strings = (
              'ExcludeFromMandatoryLineCheck;CheckBox;true;false')
            PictureMasks.Strings = (
              'TargetYieldPercent'#9'#[#][#]'#9'T'#9'T')
            Selected.Strings = (
              'SubCategoryName'#9'20'#9'Sub Category'#9#9
              'ExcludedProductsText'#9'11'#9'Excluded~Products'#9#9
              'TargetYieldPercent'#9'7'#9'Target~Yield%'#9'F'#9
              'ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 2
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
            DataSource = dsMLCSubcat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 2
            TitleButtons = True
            OnCalcCellColors = gridDefaultSubcatSettingsCalcCellColors
            PaintOptions.ActiveRecordColor = clDefault
          end
          object gridDefaultProductSettings: TwwDBGrid
            Left = 316
            Top = 0
            Width = 309
            Height = 425
            ControlType.Strings = (
              'Except;CheckBox;True;False'
              'NoShow;CheckBox;True;False'
              'ExcludeFromMandatoryLineCheck;CheckBox;true;false')
            Selected.Strings = (
              'PurchaseName'#9'40'#9'Purchase Name'#9#9
              'ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 1
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            DataSource = dsMLCProduct
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
            ParentFont = False
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 2
            TitleButtons = False
            PaintOptions.ActiveRecordColor = clDefault
          end
        end
        object tabMLCSiteSettings: TTabSheet
          Caption = 'Site Exceptions'
          ImageIndex = 1
          object lblChooseSite: TLabel
            Left = 0
            Top = 392
            Width = 60
            Height = 13
            Caption = 'Choose Site:'
          end
          object lblPleaseChooseASite: TLabel
            Left = 176
            Top = 176
            Width = 159
            Height = 24
            Caption = 'Please select a site'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object gridSiteSubcatSettings: TwwDBGrid
            Left = 0
            Top = 0
            Width = 306
            Height = 385
            ControlType.Strings = (
              'ExcludeFromMandatoryLineCheck;CheckBox;true;false')
            PictureMasks.Strings = (
              'TargetYieldPercent'#9'#[#][#]'#9'T'#9'T')
            Selected.Strings = (
              'SubCategoryName'#9'20'#9'Sub Category'#9'F'#9
              'ExcludedProductsText'#9'11'#9'Excluded~Products'#9#9
              'TargetYieldPercent'#9'7'#9'Target~Yield%'#9#9
              'ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 2
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
            DataSource = dsMLCSiteSubcat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 2
            TitleButtons = True
            OnCalcCellColors = gridSiteSubcatSettingsCalcCellColors
            PaintOptions.ActiveRecordColor = clDefault
          end
          object gridSiteProductSettings: TwwDBGrid
            Left = 316
            Top = 0
            Width = 309
            Height = 385
            ControlType.Strings = (
              'Except;CheckBox;True;False'
              'NoShow;CheckBox;True;False'
              'ExcludeFromMandatoryLineCheck;CheckBox;true;false')
            Selected.Strings = (
              'PurchaseName'#9'40'#9'Purchase Name'#9#9
              'ExcludeFromMandatoryLineCheck'#9'5'#9'Exclude'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 1
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            DataSource = dsMLCSiteProduct
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
            ParentFont = False
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 2
            TitleButtons = False
            OnCalcCellColors = gridSiteProductSettingsCalcCellColors
            PaintOptions.ActiveRecordColor = clDefault
          end
          object cmbbxMLCChooseSite: TComboBox
            Left = 64
            Top = 388
            Width = 153
            Height = 21
            AutoDropDown = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 2
            OnChange = cmbbxMLCChooseSiteChange
            OnEnter = cmbbxMLCChooseSiteEnter
          end
          object chkbxOnlyListSitesWithExceptions: TCheckBox
            Left = 64
            Top = 408
            Width = 161
            Height = 17
            Caption = 'Only list sites with exceptions'
            TabOrder = 3
            OnClick = chkbxOnlyListSitesWithExceptionsClick
          end
          object btnRevertThisSiteToDefault: TButton
            Left = 316
            Top = 389
            Width = 163
            Height = 34
            Caption = 'Revert &This Site To Default'
            Enabled = False
            TabOrder = 4
            OnClick = btnRevertThisSiteToDefaultClick
          end
        end
      end
      object gridMLCDivisions: TwwDBGrid
        Left = 649
        Top = 28
        Width = 205
        Height = 125
        ControlType.Strings = (
          'IncludeInMandatoryLineCheck;CheckBox;true;false')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        DataSource = dsMLCDivision
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
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
        PaintOptions.ActiveRecordColor = clDefault
      end
      object pnlColourKey: TPanel
        Left = 648
        Top = 200
        Width = 208
        Height = 81
        TabOrder = 6
        DesignSize = (
          208
          81)
        object lblColourKey: TLabel
          Left = 8
          Top = 4
          Width = 51
          Height = 13
          Caption = 'Colour Key'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblSiteExceptionColour: TLabel
          Left = 8
          Top = 26
          Width = 41
          Height = 13
          AutoSize = False
          Color = clGradientActiveCaption
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblSiteException: TLabel
          Left = 64
          Top = 19
          Width = 109
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Site setting differs from default.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label32: TLabel
          Left = 8
          Top = 54
          Width = 41
          Height = 13
          AutoSize = False
          Color = clMoneyGreen
          ParentColor = False
        end
        object Label33: TLabel
          Left = 64
          Top = 47
          Width = 133
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Sub-Category has excluded products.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
      object btnSiteExceptionsReport: TButton
        Left = 648
        Top = 292
        Width = 208
        Height = 36
        Anchors = [akLeft, akTop, akRight]
        Caption = '&Site Exceptions Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnSiteExceptionsReportClick
      end
      object btnRevertAllSitesToDefault: TButton
        Left = 648
        Top = 332
        Width = 208
        Height = 36
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Revert &All Sites To Default'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnRevertAllSitesToDefaultClick
      end
      object btnMLCSaveChanges: TBitBtn
        Left = 694
        Top = 379
        Width = 163
        Height = 36
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnMLCSaveChangesClick
        Glyph.Data = {
          06020000424D0602000000000000760000002800000019000000190000000100
          04000000000090010000330B0000330B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
          CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
          CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
          CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
          CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
          70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
          70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
          70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
          7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
          7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
          7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
          AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
          9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
          99999999AAAAA0000000}
        Margin = 17
        Spacing = 10
      end
      object btnMLCDiscardChanges: TBitBtn
        Left = 694
        Top = 421
        Width = 163
        Height = 36
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Discard Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btnMLCDiscardChangesClick
        Glyph.Data = {
          F6010000424DF601000000000000760000002800000019000000180000000100
          04000000000080010000230B0000230B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
          99999999999990000000999999999999999999999999900000009F99F9FFFF99
          FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
          9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
          99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
          99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
          AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
          00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
          A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
          A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
          A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
          AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
          AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
      end
      object edtNumMandatoryProducts: TSpinEdit
        Left = 787
        Top = 168
        Width = 69
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        MaxValue = 9999999
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 5
        OnChange = edtNumMandatoryProductsChange
        OnKeyPress = edtNumMandatoryProductsKeyPress
      end
    end
    object tabMustCount: TTabSheet
      Caption = 'Must Count Items'
      ImageIndex = 5
      DesignSize = (
        861
        461)
      object lblCompany: TLabel
        Left = 3
        Top = 33
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Company:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblArea: TLabel
        Left = 271
        Top = 33
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Area:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 467
        Top = 1
        Width = 167
        Height = 13
        Caption = '"Must Count" Item Templates'
      end
      object Label27: TLabel
        Left = 3
        Top = 3
        Width = 237
        Height = 13
        Caption = '"Must Count" Template Sites Assignment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label28: TLabel
        Left = 132
        Top = 440
        Width = 32
        Height = 13
        Caption = 'Field:'
      end
      object cbNoTemplateSites: TCheckBox
        Left = 277
        Top = 12
        Width = 182
        Height = 17
        Caption = 'Only Sites with no Template'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 5
        OnClick = cbNoTemplateSitesClick
      end
      object edSearch: TEdit
        Left = 132
        Top = 412
        Width = 213
        Height = 21
        Hint = 
          'Type the Search string required '#13#10'AND press F3 or F2 to do the s' +
          'earch'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 17
        Visible = False
      end
      object cbCompany: TComboBox
        Left = 61
        Top = 29
        Width = 160
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
        OnCloseUp = cbCompanyCloseUp
      end
      object cbArea: TComboBox
        Left = 306
        Top = 29
        Width = 152
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
        OnCloseUp = cbAreaCloseUp
      end
      object gridMustCountTemplate: TwwDBGrid
        Left = 467
        Top = 16
        Width = 381
        Height = 233
        ControlType.Strings = (
          'HasFixedQty;CheckBox;True;False')
        Selected.Strings = (
          'TemplateName'#9'35'#9'Template Name'#9'F'
          'items'#9'6'#9'Items~count'#9'F'
          'sites'#9'8'#9'Used~by Sites'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsMustCountTemplate
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
        UseTFields = False
        OnCalcCellColors = gridMustCountTemplateCalcCellColors
        OnDblClick = btnTemplateListClick
      end
      object wwDBEdit2: TwwDBEdit
        Left = 467
        Top = 311
        Width = 381
        Height = 66
        AutoSize = False
        Color = clSilver
        DataField = 'Note'
        DataSource = dsMustCountTemplate
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowVertScrollBar = True
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = True
      end
      object gridMustCountTemplateSites: TwwDBGrid
        Left = 3
        Top = 52
        Width = 455
        Height = 351
        Selected.Strings = (
          'SiteName'#9'20'#9'SiteName'#9#9
          'Reference'#9'10'#9'Reference'#9#9
          'TemplateName'#9'37'#9'TemplateName'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Constraints.MinWidth = 360
        DataSource = dsMustCountTemplateSites
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTrailingEllipsis, dgShowCellHint]
        ParentFont = False
        TabOrder = 4
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        UseTFields = False
      end
      object cbNotUsedTemplates: TCheckBox
        Left = 467
        Top = 250
        Width = 163
        Height = 16
        Caption = 'Only unused Templates'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 6
        OnClick = cbShowDeletedTemplatesClick
      end
      object btnAddTemplate: TBitBtn
        Left = 467
        Top = 270
        Width = 60
        Height = 36
        Caption = 'Add'#10'Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnClick = btnAddTemplateClick
      end
      object btnEditTemplate: TBitBtn
        Left = 605
        Top = 270
        Width = 60
        Height = 36
        Caption = 'Edit'#10'Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = btnEditTemplateClick
      end
      object btnDeleteTemplate: TBitBtn
        Left = 674
        Top = 270
        Width = 63
        Height = 36
        Caption = 'Delete'#10'Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        OnClick = btnDeleteTemplateClick
      end
      object btnTemplateList: TBitBtn
        Left = 754
        Top = 270
        Width = 94
        Height = 36
        Caption = 'Edit Template'#10'Product List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = btnTemplateListClick
      end
      object cbShowDeletedTemplates: TCheckBox
        Left = 679
        Top = 250
        Width = 168
        Height = 16
        Caption = 'Show Deleted Templates'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = cbShowDeletedTemplatesClick
      end
      object btnSaveTemplateChanges: TBitBtn
        Left = 686
        Top = 383
        Width = 163
        Height = 37
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = btnSaveTemplateChangesClick
        Glyph.Data = {
          06020000424D0602000000000000760000002800000019000000190000000100
          04000000000090010000330B0000330B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
          CCCCCCCCCCCCC0000000CCFFFCCFCCCFCCCFCCCFFFFFC0000000CFCCCFCFFFFF
          CCFCFCCFCCCCC0000000CCCCFCCFCCCFCCFCFCCFCCCCC0000000CCFFCCCFCCCF
          CFCCCFCFFFFCC0000000CFCCCFCCFCFCCFCCCFCFCCCCC0000000CCFFFCCCCFCC
          CFCCCFCFFFFFC0000000CCCCCCCCCCCCC7000000000000000000AAAAAAAAAAAA
          70330000AA0300000000AAAAAAAAAAAA70330000AA0300000000000000000000
          70330000AA0300000000EEEEEEEEEEE070330000000300000000EEEEEEEEEEE0
          70333333333300000000E0E0E0E0E0E070330000003300000000E0E0E0E0E0E0
          7030AAAAAA0300000000EEEEEEEEEEE07030AAAAAA0300000000E0E0E0E0E0E0
          7030AAAA9A0300000000E0E0E0E0E0E07030AAA9990300000000EEEEEEEEEEE0
          7030AA99999300000000E0E0E0E0E0E0A0000999999900000000E0E0E0E0E0E0
          AAAAAAA999AAA0000000EEEEEEEEEEE0AAAAAAA999AAA0000000E0E099999999
          9999999999AAA0000000E0E099999999999999999AAAA0000000EEEE99999999
          99999999AAAAA0000000}
        Margin = 17
        Spacing = 10
      end
      object btnDiscardTemplateChanges: TBitBtn
        Left = 686
        Top = 423
        Width = 163
        Height = 37
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Discard Changes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = btnDiscardTemplateChangesClick
        Glyph.Data = {
          F6010000424DF601000000000000760000002800000019000000180000000100
          04000000000080010000230B0000230B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A99999999999
          99999999999990000000999999999999999999999999900000009F99F9FFFF99
          FF99FFFF99FF900000009F9F99F9999F99F9F99999FF900000009FFF99F99999
          9F99F99999FF900000009F99F9FFF999F999FFF999FF900000009F99F9F9999F
          99F9F99999FF900000009FFF99FFFF99FF99FFFF9FFFF0000000999999999999
          99999999999990000000AAAAAAAAAAAAAAAAAAAAAAAAA0000000AA7000000AAA
          AAAAAAAAAAAAA0000000AA0330000AA00000000AAAAAA0000000AA0330000AA0
          00FF030AAAAAA0000000AA03300000AA00FF030AAAAAA0000000AA033000000A
          A0FF030AAAAAA0000000AA033333330AA000030AAAAAA0000000AA033000000A
          A033330AAAAAA0000000AA030FAAAA0AA000330AAAAAA0000000AA030AFAA0AA
          A0AA030AAAAAA0000000AA030AAA0AAA0AAA030AAAAAA0000000AA030AA0AAA0
          AAAA030AAAAAA0000000AA030A0AAA0AAAAA000AAAAAA0000000AA00000AA0AA
          AAAA0F0AAAAAA0000000AAAAAAAAA0000000000AAAAAA0000000}
      end
      object incSearch1: TwwIncrementalSearch
        Left = 132
        Top = 412
        Width = 210
        Height = 21
        DataSource = dsMustCountTemplateSites
        SearchField = 'SiteName'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 14
      end
      object btnPriorSearch: TBitBtn
        Left = 349
        Top = 406
        Width = 98
        Height = 23
        Caption = 'Prev (F2)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 15
        OnClick = btnPriorSearchClick
        Glyph.Data = {
          6A000000424D6A000000000000003E000000280000000A0000000B0000000100
          0100000000002C0000000000000000000000020000000200000000000000FFFF
          FF00FFC0000000000000000000008040000080400000C0C00000C0C00000E1C0
          0000E1C00000F3C00000F3C00000}
      end
      object btnNextSearch: TBitBtn
        Left = 349
        Top = 432
        Width = 98
        Height = 23
        Caption = 'Next (F3)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
        OnClick = btnNextSearchClick
        Glyph.Data = {
          6A000000424D6A000000000000003E000000280000000A0000000B0000000100
          0100000000002C0000000000000000000000020000000200000000000000FFFF
          FF00FFC00000F3C00000F3C00000E1C00000E1C00000C0C00000C0C000008040
          0000804000000000000000000000}
      end
      object rbSearchSiteName: TRadioButton
        Left = 168
        Top = 440
        Width = 84
        Height = 15
        Caption = 'Site Name'
        Checked = True
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 18
        TabStop = True
        OnClick = rbSearchSiteNameClick
      end
      object rbSearchSiteRef: TRadioButton
        Left = 263
        Top = 440
        Width = 84
        Height = 15
        Caption = 'Reference'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 19
        OnClick = rbSearchSiteNameClick
      end
      object rgSearchKind: TRadioGroup
        Left = 8
        Top = 405
        Width = 113
        Height = 53
        Caption = 'Search Mode'
        Ctl3D = True
        ItemIndex = 0
        Items.Strings = (
          'Incremental'
          'Mid-Word')
        ParentCtl3D = False
        TabOrder = 20
        OnClick = rgSearchKindClick
      end
      object btnUnAssignTemplate: TBitBtn
        Left = 467
        Top = 423
        Width = 169
        Height = 37
        Caption = 'Un-Assign Template'#10'from Site(s)'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 21
        OnClick = btnUnAssignTemplateClick
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
      object btnAssignTemplate: TBitBtn
        Left = 467
        Top = 382
        Width = 169
        Height = 37
        Caption = 'Assign Template'#10'to Site(s)'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 22
        OnClick = btnAssignTemplateClick
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
      object btnCopyTemplate: TBitBtn
        Left = 536
        Top = 270
        Width = 60
        Height = 36
        Caption = 'Copy'#10'Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 23
        OnClick = btnCopyTemplateClick
      end
    end
  end
  object pnlFormBottom: TPanel
    Left = 0
    Top = 489
    Width = 869
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      869
      41)
    object lblSiteVersionWarning: TLabel
      Left = 9
      Top = 6
      Width = 465
      Height = 28
      Anchors = [akLeft, akBottom]
      AutoSize = False
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
    object btnDone: TBitBtn
      Left = 684
      Top = 2
      Width = 177
      Height = 36
      Anchors = [akTop, akRight]
      Caption = 'Done'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
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
    object btnAutoWasteReport: TBitBtn
      Left = 5
      Top = 4
      Width = 188
      Height = 33
      Caption = 'Auto Waste Config Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnAutoWasteReportClick
    end
    object cbDoz: TCheckBox
      Left = 199
      Top = 2
      Width = 374
      Height = 17
      Caption = 
        'Use special "Dozens/Units" format to show Dozens (1 Dozen = 12 U' +
        'nits)'
      TabOrder = 2
      OnClick = cbDozClick
    end
    object cbGall: TCheckBox
      Left = 199
      Top = 22
      Width = 374
      Height = 17
      Caption = 
        'Use special "Gallons/Pints" format to show Gallons (1 Gallon = 8' +
        ' Pints)'
      TabOrder = 3
      OnClick = cbGallClick
    end
    object pnlLocOrHZ: TPanel
      Left = 80
      Top = 0
      Width = 665
      Height = 41
      TabOrder = 4
      Visible = False
      DesignSize = (
        665
        41)
      object lblHZLocText: TLabel
        Left = 2
        Top = 3
        Width = 278
        Height = 33
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          'to use Locations first turn OFF Holding Zones'#13#10'to use Holding Zo' +
          'nes first turn OFF Locations'
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
      object btnUseLocations: TBitBtn
        Left = 285
        Top = 3
        Width = 184
        Height = 33
        Caption = 'Use Count Locations'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnUseLocationsClick
      end
      object btnUseHZs: TBitBtn
        Left = 477
        Top = 3
        Width = 184
        Height = 33
        Caption = 'Use Holding Zones'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnUseHZsClick
      end
    end
  end
  object adotProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filtered = True
    AfterOpen = adotProdsAfterScroll
    AfterEdit = adotProdsAfterEdit
    BeforeScroll = adotProdsBeforeScroll
    AfterScroll = adotProdsAfterScroll
    TableName = 'stkAWProds'
    Left = 232
    Top = 240
  end
  object adoqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 760
  end
  object wwDataSource1: TwwDataSource
    DataSet = adotProds
    Left = 256
    Top = 240
  end
  object adoqAWU: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = wwDataSource1
    Parameters = <
      item
        Name = 'entitycode'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Value = 10000000897
      end
      item
        Name = 'entitycode2'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Value = 10000000897
      end>
    SQL.Strings = (
      
        'select a.PurchaseUnit as '#39'Choose Unit'#39', (0) as uord from stkawpr' +
        'ods a'
      'where a."entitycode" = :entitycode'
      'union'
      'select u.[Unit Name], (99) as uord from units u, stkawprods b'
      'where b."entitycode" = :entitycode2'
      'and u.[Base Type Unit] = b.uType'
      'order by uord, "Choose Unit"')
    Left = 288
    Top = 208
  end
  object wwDataSource2: TwwDataSource
    DataSet = adoqAWU
    Left = 312
    Top = 208
  end
  object adoqAWrep: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.entitycode, a.div, a.cat, a.sub, a.purn, a.unit, a.awva' +
        'lue,'
      '(b.ActRedCost * a.baseu * a.awvalue) as awCost,'
      '(b.NomPrice * a.baseu * a.awvalue) as awPrice'
      'FROM StkMain b INNER JOIN'
      
        '  [00_#ghost3] c ON b.Tid = c.tid AND b.StkCode = c.stkcode RIGH' +
        'T OUTER JOIN'
      '  [00_#ghost] a ON b.EntityCode = a.EntityCode'
      'order by a.div, a.cat, a.sub, a.purn, a.unit')
    Left = 616
  end
  object dsAWrep: TwwDataSource
    DataSet = adoqAWrep
    Left = 640
  end
  object ppAWrep: TppReport
    AutoStop = False
    DataPipeline = pipeAWrep
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter (8.5 x 11")'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppAWrepPreviewFormCreate
    Left = 688
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeAWrep'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 18256
      mmPrintPosition = 0
      object ppShape3: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 47096
        mmTop = 1852
        mmWidth = 106627
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Auto Wastage Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 48154
        mmTop = 2646
        mmWidth = 104511
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
        mmTop = 1852
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
        mmTop = 6350
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
        mmTop = 10848
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
        mmLeft = 161132
        mmTop = 7408
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
        mmLeft = 181240
        mmTop = 2646
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
        mmTop = 1852
        mmWidth = 25665
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
        mmTop = 6350
        mmWidth = 26723
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
        mmTop = 10848
        mmWidth = 28840
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
        mmLeft = 171715
        mmTop = 7408
        mmWidth = 25929
        BandType = 0
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 16140
        mmWidth = 200290
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
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 184532
        mmTop = 12435
        mmWidth = 13377
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      BeforePrint = ppDetailBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppShape5: TppShape
        UserName = 'Shape5'
        Brush.Color = 10930928
        Pen.Style = psClear
        mmHeight = 5821
        mmLeft = 192617
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        Brush.Color = 10930928
        Pen.Style = psClear
        mmHeight = 6085
        mmLeft = 7673
        mmTop = 0
        mmWidth = 6615
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'purn'
        DataPipeline = pipeAWrep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4498
        mmLeft = 14817
        mmTop = 1058
        mmWidth = 72231
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'unit'
        DataPipeline = pipeAWrep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4498
        mmLeft = 87842
        mmTop = 1058
        mmWidth = 27517
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        OnGetText = ppDBText6GetText
        DataField = 'awvalue'
        DataPipeline = pipeAWrep
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4498
        mmLeft = 116152
        mmTop = 1058
        mmWidth = 24077
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'awCost'
        DataPipeline = pipeAWrep
        DisplayFormat = '$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4498
        mmLeft = 141817
        mmTop = 1058
        mmWidth = 24077
        BandType = 4
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'awPrice'
        DataPipeline = pipeAWrep
        DisplayFormat = '$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4498
        mmLeft = 167217
        mmTop = 1058
        mmWidth = 24077
        BandType = 4
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1058
        mmLeft = 14023
        mmTop = 4498
        mmWidth = 178594
        BandType = 4
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 529
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine23: TppLine
        UserName = 'Line203'
        Position = lpRight
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 191294
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
      object ppLine25: TppLine
        UserName = 'Line25'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 87313
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine26: TppLine
        UserName = 'Line26'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 115623
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine27: TppLine
        UserName = 'Line27'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 141288
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine28: TppLine
        UserName = 'Line28'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 166952
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine45: TppLine
        UserName = 'Line45'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 14023
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine48: TppLine
        UserName = 'Line48'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 7408
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine49: TppLine
        UserName = 'Line49'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 2910
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine58: TppLine
        UserName = 'Line58'
        Position = lpRight
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 193675
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
      object ppLine65: TppLine
        UserName = 'Line65'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 196321
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
      object ppLine30: TppLine
        UserName = 'Line30'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 198967
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 17463
      mmPrintPosition = 0
      object ppDBCalc7: TppDBCalc
        UserName = 'DBCalc7'
        DataField = 'awCost'
        DataPipeline = pipeAWrep
        DisplayFormat = '$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4233
        mmLeft = 141817
        mmTop = 1323
        mmWidth = 24077
        BandType = 7
      end
      object ppDBCalc8: TppDBCalc
        UserName = 'DBCalc8'
        DataField = 'awPrice'
        DataPipeline = pipeAWrep
        DisplayFormat = '$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeAWrep'
        mmHeight = 4233
        mmLeft = 167217
        mmTop = 1323
        mmWidth = 24077
        BandType = 7
      end
      object ppLine40: TppLine
        UserName = 'Line40'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5027
        mmLeft = 141288
        mmTop = 794
        mmWidth = 1588
        BandType = 7
      end
      object ppLine41: TppLine
        UserName = 'Line41'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 166952
        mmTop = 794
        mmWidth = 1588
        BandType = 7
      end
      object ppLine42: TppLine
        UserName = 'Line42'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5027
        mmLeft = 191294
        mmTop = 794
        mmWidth = 1323
        BandType = 7
      end
      object ppLine43: TppLine
        UserName = 'Line43'
        Pen.Width = 2
        Position = lpBottom
        Weight = 1.5
        mmHeight = 1323
        mmLeft = 141288
        mmTop = 4763
        mmWidth = 51329
        BandType = 7
      end
      object ppLine44: TppLine
        UserName = 'Line44'
        Pen.Width = 2
        Weight = 1.5
        mmHeight = 1058
        mmLeft = 141288
        mmTop = 529
        mmWidth = 51329
        BandType = 7
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Totals for Site:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4191
        mmLeft = 116152
        mmTop = 1323
        mmWidth = 24680
        BandType = 7
      end
      object ppLabel17: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 
          'NOTE: The Waste Cost and Waste Value are calculated using the th' +
          'e Consumption Cost and the Nominal Price from the latest accepte' +
          'd                stock for the product'#39's division. As such, the ' +
          'actual Waste Cost and Value may be different when the Auto Wasta' +
          'ge is recorded.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 529
        mmTop = 9525
        mmWidth = 175419
        BandType = 7
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'div'
      DataPipeline = pipeAWrep
      KeepTogether = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeAWrep'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 12700
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'div'
          DataPipeline = pipeAWrep
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4498
          mmLeft = 16404
          mmTop = 2646
          mmWidth = 46831
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 529
          mmTop = 1588
          mmWidth = 64294
          BandType = 3
          GroupNo = 0
        end
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Division:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4191
          mmLeft = 1323
          mmTop = 2646
          mmWidth = 14901
          BandType = 3
          GroupNo = 0
        end
        object ppLine5: TppLine
          UserName = 'Line5'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 11642
          mmLeft = 529
          mmTop = 1588
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine20: TppLine
          UserName = 'Line20'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 63765
          mmTop = 1588
          mmWidth = 1323
          BandType = 3
          GroupNo = 0
        end
        object ppLine7: TppLine
          UserName = 'Line7'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 2910
          mmTop = 7408
          mmWidth = 197115
          BandType = 3
          GroupNo = 0
        end
        object ppLine9: TppLine
          UserName = 'Line9'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 2910
          mmTop = 11113
          mmWidth = 197115
          BandType = 3
          GroupNo = 0
        end
        object ppLine32: TppLine
          UserName = 'Line32'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 87313
          mmTop = 7673
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine33: TppLine
          UserName = 'Line33'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 115623
          mmTop = 7673
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine34: TppLine
          UserName = 'Line34'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 141288
          mmTop = 7673
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine35: TppLine
          UserName = 'Line35'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 166952
          mmTop = 7673
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine36: TppLine
          UserName = 'Line36'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5292
          mmLeft = 198967
          mmTop = 7408
          mmWidth = 1323
          BandType = 3
          GroupNo = 0
        end
        object ppLabel10: TppLabel
          UserName = 'Label10'
          Caption = 'Name (Categ/Sub-Categ/Item)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 4763
          mmTop = 8202
          mmWidth = 49477
          BandType = 3
          GroupNo = 0
        end
        object ppLabel11: TppLabel
          UserName = 'Label11'
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 91281
          mmTop = 8202
          mmWidth = 6879
          BandType = 3
          GroupNo = 0
        end
        object ppLabel13: TppLabel
          UserName = 'Label13'
          Caption = 'Waste Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 119856
          mmTop = 8202
          mmWidth = 17198
          BandType = 3
          GroupNo = 0
        end
        object ppLabel14: TppLabel
          UserName = 'Label14'
          Caption = 'Waste Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 144463
          mmTop = 8202
          mmWidth = 19050
          BandType = 3
          GroupNo = 0
        end
        object ppLabel15: TppLabel
          UserName = 'Label15'
          Caption = 'Waste Value'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 169334
          mmTop = 8202
          mmWidth = 20638
          BandType = 3
          GroupNo = 0
        end
        object ppLine54: TppLine
          UserName = 'Line54'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 5027
          mmLeft = 2910
          mmTop = 7673
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 8467
        mmPrintPosition = 0
        object ppDBCalc5: TppDBCalc
          UserName = 'DBCalc5'
          DataField = 'awCost'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 141817
          mmTop = 1058
          mmWidth = 24077
          BandType = 5
          GroupNo = 0
        end
        object ppDBCalc6: TppDBCalc
          UserName = 'DBCalc6'
          DataField = 'awPrice'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 167217
          mmTop = 1058
          mmWidth = 24077
          BandType = 5
          GroupNo = 0
        end
        object ppLine18: TppLine
          UserName = 'Line18'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 529
          mmTop = 4233
          mmWidth = 199496
          BandType = 5
          GroupNo = 0
        end
        object ppLine19: TppLine
          UserName = 'Line19'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 198967
          mmTop = 0
          mmWidth = 1323
          BandType = 5
          GroupNo = 0
        end
        object ppLine21: TppLine
          UserName = 'Line21'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 529
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 0
        end
        object ppLine38: TppLine
          UserName = 'Line38'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5292
          mmLeft = 59267
          mmTop = 529
          mmWidth = 1588
          BandType = 5
          GroupNo = 0
        end
        object ppLine39: TppLine
          UserName = 'Line39'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5292
          mmLeft = 166952
          mmTop = 794
          mmWidth = 1588
          BandType = 5
          GroupNo = 0
        end
        object ppLabel16: TppLabel
          UserName = 'Label16'
          Caption = 'Totals for Division:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 60854
          mmTop = 1058
          mmWidth = 32015
          BandType = 5
          GroupNo = 0
        end
        object ppDBText11: TppDBText
          UserName = 'DBText11'
          DataField = 'div'
          DataPipeline = pipeAWrep
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 93663
          mmTop = 1058
          mmWidth = 46831
          BandType = 5
          GroupNo = 0
        end
        object ppLine60: TppLine
          UserName = 'Line60'
          Weight = 0.75
          mmHeight = 1852
          mmLeft = 59531
          mmTop = 529
          mmWidth = 140494
          BandType = 5
          GroupNo = 0
        end
      end
    end
    object ppGroup2: TppGroup
      BreakName = 'cat'
      DataPipeline = pipeAWrep
      KeepTogether = True
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeAWrep'
      object ppGroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 6879
        mmPrintPosition = 0
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          DataField = 'cat'
          DataPipeline = pipeAWrep
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 21960
          mmTop = 2381
          mmWidth = 42863
          BandType = 3
          GroupNo = 1
        end
        object ppLabel8: TppLabel
          UserName = 'Label8'
          Caption = 'Category:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 4498
          mmTop = 2381
          mmWidth = 16404
          BandType = 3
          GroupNo = 1
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1852
          mmLeft = 7408
          mmTop = 5292
          mmWidth = 187590
          BandType = 3
          GroupNo = 1
        end
        object ppLine6: TppLine
          UserName = 'Line6'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 7408
          mmLeft = 529
          mmTop = 0
          mmWidth = 1852
          BandType = 3
          GroupNo = 1
        end
        object ppDBCalc1: TppDBCalc
          UserName = 'DBCalc1'
          DataField = 'awCost'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          LookAhead = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 141817
          mmTop = 1852
          mmWidth = 24077
          BandType = 3
          GroupNo = 1
        end
        object ppDBCalc2: TppDBCalc
          UserName = 'DBCalc2'
          DataField = 'awPrice'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          LookAhead = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 167217
          mmTop = 1852
          mmWidth = 24077
          BandType = 3
          GroupNo = 1
        end
        object ppLine13: TppLine
          UserName = 'Line13'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5821
          mmLeft = 166952
          mmTop = 1058
          mmWidth = 1588
          BandType = 3
          GroupNo = 1
        end
        object ppLine52: TppLine
          UserName = 'Line52'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 2910
          mmTop = 1058
          mmWidth = 1588
          BandType = 3
          GroupNo = 1
        end
        object ppLine63: TppLine
          UserName = 'Line63'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 196321
          mmTop = 1058
          mmWidth = 1323
          BandType = 3
          GroupNo = 1
        end
        object ppLine16: TppLine
          UserName = 'Line16'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 7408
          mmLeft = 198967
          mmTop = 0
          mmWidth = 1323
          BandType = 3
          GroupNo = 1
        end
        object ppLine56: TppLine
          UserName = 'Line56'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 2910
          mmTop = 794
          mmWidth = 194734
          BandType = 3
          GroupNo = 1
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 4498
        mmPrintPosition = 0
        object ppLine17: TppLine
          UserName = 'Line17'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1852
          mmLeft = 2910
          mmTop = 1323
          mmWidth = 194734
          BandType = 5
          GroupNo = 1
        end
        object ppLine37: TppLine
          UserName = 'Line37'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 4498
          mmLeft = 529
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 1
        end
        object ppLine47: TppLine
          UserName = 'Line47'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 2646
          mmLeft = 2910
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 1
        end
        object ppLine67: TppLine
          UserName = 'Line67'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 2910
          mmLeft = 195792
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 1
        end
        object ppLine55: TppLine
          UserName = 'Line55'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 4498
          mmLeft = 198438
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 1
        end
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'sub'
      DataPipeline = pipeAWrep
      UserName = 'Group3'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeAWrep'
      object ppGroupHeaderBand3: TppGroupHeaderBand
        BeforePrint = ppGroupHeaderBand3BeforePrint
        mmBottomOffset = 0
        mmHeight = 5821
        mmPrintPosition = 0
        object ppShape4: TppShape
          UserName = 'Shape4'
          Brush.Color = 10930928
          Pen.Style = psClear
          mmHeight = 5821
          mmLeft = 7673
          mmTop = 265
          mmWidth = 187325
          BandType = 3
          GroupNo = 2
        end
        object ppDBText3: TppDBText
          UserName = 'DBText3'
          DataField = 'sub'
          DataPipeline = pipeAWrep
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 25135
          mmTop = 1588
          mmWidth = 42863
          BandType = 3
          GroupNo = 2
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          Caption = 'Sub-Cat.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 8731
          mmTop = 1588
          mmWidth = 15610
          BandType = 3
          GroupNo = 2
        end
        object ppLine3: TppLine
          UserName = 'Line3'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1852
          mmLeft = 7408
          mmTop = 4233
          mmWidth = 187590
          BandType = 3
          GroupNo = 2
        end
        object ppLine8: TppLine
          UserName = 'Line8'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 529
          mmTop = 0
          mmWidth = 1852
          BandType = 3
          GroupNo = 2
        end
        object ppDBCalc3: TppDBCalc
          UserName = 'DBCalc3'
          DataField = 'awCost'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup3
          TextAlignment = taRightJustified
          Transparent = True
          LookAhead = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 141817
          mmTop = 1323
          mmWidth = 24077
          BandType = 3
          GroupNo = 2
        end
        object ppDBCalc4: TppDBCalc
          UserName = 'DBCalc4'
          DataField = 'awPrice'
          DataPipeline = pipeAWrep
          DisplayFormat = '$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          ResetGroup = ppGroup3
          TextAlignment = taRightJustified
          Transparent = True
          LookAhead = True
          DataPipelineName = 'pipeAWrep'
          mmHeight = 4233
          mmLeft = 167217
          mmTop = 1323
          mmWidth = 24077
          BandType = 3
          GroupNo = 2
        end
        object ppLine15: TppLine
          UserName = 'Line15'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5821
          mmLeft = 166952
          mmTop = 265
          mmWidth = 1588
          BandType = 3
          GroupNo = 2
        end
        object ppLine50: TppLine
          UserName = 'Line50'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5821
          mmLeft = 7408
          mmTop = 265
          mmWidth = 1588
          BandType = 3
          GroupNo = 2
        end
        object ppLine51: TppLine
          UserName = 'Line51'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 2910
          mmTop = 0
          mmWidth = 1588
          BandType = 3
          GroupNo = 2
        end
        object ppLine57: TppLine
          UserName = 'Line57'
          Position = lpRight
          Weight = 0.75
          mmHeight = 5821
          mmLeft = 193675
          mmTop = 265
          mmWidth = 1323
          BandType = 3
          GroupNo = 2
        end
        object ppLine64: TppLine
          UserName = 'Line64'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 196321
          mmTop = 0
          mmWidth = 1323
          BandType = 3
          GroupNo = 2
        end
        object ppLine29: TppLine
          UserName = 'Line29'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 5821
          mmLeft = 198967
          mmTop = 0
          mmWidth = 1323
          BandType = 3
          GroupNo = 2
        end
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        BeforePrint = ppGroupFooterBand3BeforePrint
        mmBottomOffset = 0
        mmHeight = 4233
        mmPrintPosition = 0
        object ppShape2: TppShape
          UserName = 'Shape2'
          Brush.Color = 10930928
          Pen.Style = psClear
          mmHeight = 2646
          mmLeft = 7408
          mmTop = 264
          mmWidth = 187590
          BandType = 5
          GroupNo = 2
        end
        object ppLine10: TppLine
          UserName = 'Line10'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1323
          mmLeft = 7408
          mmTop = 1588
          mmWidth = 187590
          BandType = 5
          GroupNo = 2
        end
        object ppLine22: TppLine
          UserName = 'Line22'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 4233
          mmLeft = 529
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
        object ppLine46: TppLine
          UserName = 'Line46'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 2910
          mmLeft = 7408
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
        object ppLine53: TppLine
          UserName = 'Line53'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 4233
          mmLeft = 2910
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
        object ppLine59: TppLine
          UserName = 'Line301'
          Position = lpRight
          Weight = 0.75
          mmHeight = 2910
          mmLeft = 193146
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
        object ppLine66: TppLine
          UserName = 'Line302'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 4233
          mmLeft = 195792
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
        object ppLine31: TppLine
          UserName = 'Line31'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 4233
          mmLeft = 198438
          mmTop = 0
          mmWidth = 1852
          BandType = 5
          GroupNo = 2
        end
      end
    end
  end
  object pipeAWrep: TppDBPipeline
    DataSource = dsAWrep
    UserName = 'pipeAWrep'
    Left = 664
  end
  object dsHZs: TwwDataSource
    DataSet = adotHZs
    Left = 312
    Top = 240
  end
  object wwDataSource4: TwwDataSource
    DataSet = adoqHzPOS
    Left = 200
    Top = 240
  end
  object adotHZs: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = adotHZsAfterEdit
    AfterPost = adotHZsAfterScroll
    AfterScroll = adotHZsAfterScroll
    IndexFieldNames = 'hzid'
    TableName = 'stkHZsTmp'
    Left = 288
    Top = 240
    object adotHZsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object adotHZshzID: TIntegerField
      FieldName = 'hzID'
    end
    object adotHZshzName: TStringField
      FieldName = 'hzName'
      FixedChar = True
      Size = 30
    end
    object adotHZsePur: TBooleanField
      FieldName = 'ePur'
      ReadOnly = True
    end
    object adotHZseOut: TBooleanField
      FieldName = 'eOut'
    end
    object adotHZseMoveIn: TBooleanField
      FieldName = 'eMoveIn'
    end
    object adotHZseMoveOut: TBooleanField
      FieldName = 'eMoveOut'
    end
    object adotHZseSales: TBooleanField
      FieldName = 'eSales'
      OnChange = adotHZseSalesChange
    end
    object adotHZseWaste: TBooleanField
      FieldName = 'eWaste'
    end
    object adotHZsActive: TBooleanField
      FieldName = 'Active'
      ReadOnly = True
    end
    object adotHZsLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
  end
  object adoqHzPOS: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqHzPOSAfterOpen
    DataSource = dsHZs
    Parameters = <
      item
        Name = 'hzID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      'SELECT a.*, b.[Name], b.Deleted '
      'FROM stkHzPosTmp a, ThemeEPOSDevice_Repl b'
      'WHERE a.TerminalID = b.EPOSDeviceID'
      'AND a.HzID = :HzID')
    Left = 176
    Top = 240
  end
  object adoqNONhzPOS: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqNONhzPOSAfterOpen
    Parameters = <>
    Left = 176
    Top = 208
  end
  object wwDataSource3: TwwDataSource
    DataSet = adoqNONhzPOS
    Left = 200
    Top = 208
  end
  object adotMinLevel: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filtered = True
    AfterOpen = adotMinLevelAfterScroll
    AfterEdit = adotMinLevelAfterEdit
    BeforePost = adotMinLevelBeforePost
    AfterScroll = adotMinLevelAfterScroll
    IndexFieldNames = '[hzid]; [DivisionName]; [repHdr]; [PurchaseName]'
    TableName = 'stkHZMinMaxTmp'
    Left = 232
    Top = 208
  end
  object dsMinLevel: TwwDataSource
    DataSet = adotMinLevel
    Left = 256
    Top = 208
  end
  object adotMLCSubcat: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = MLCAfterEdit
    AfterScroll = adotMLCSubcatAfterScroll
    OnCalcFields = adotMLCSubcatCalcFields
    CommandText = 'SELECT * FROM #MLCSubcat ORDER BY SubcategoryName'
    CommandTimeout = 0
    DataSource = dsMLCDivision
    IndexFieldNames = 'DivisionId'
    MasterFields = 'DivisionId'
    Parameters = <>
    Left = 176
    Top = 136
    object adotMLCSubcatSubCategoryName: TStringField
      DisplayLabel = 'Sub Category'
      DisplayWidth = 20
      FieldName = 'SubCategoryName'
    end
    object adotMLCSubcatExcludedProductsText: TStringField
      DisplayLabel = 'Excluded~Products'
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'ExcludedProductsText'
      Size = 14
      Calculated = True
    end
    object adotMLCSubcatTargetYieldPercent: TIntegerField
      DisplayLabel = 'Target~Yield%'
      DisplayWidth = 7
      FieldName = 'TargetYieldPercent'
      OnValidate = TargetYieldPercentValidate
    end
    object adotMLCSubcatExcludeFromMandatoryLineCheck: TBooleanField
      DisplayLabel = 'Exclude'
      DisplayWidth = 5
      FieldName = 'ExcludeFromMandatoryLineCheck'
      OnChange = adotMLCSubcatExcludeFromMandatoryLineCheckChange
    end
    object adotMLCSubcatDivisionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'DivisionId'
      Visible = False
    end
    object adotMLCSubcatSubCategoryId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SubCategoryId'
      Visible = False
    end
    object adotMLCSubcatExcludedProducts: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExcludedProducts'
      Visible = False
    end
    object adotMLCSubcatProductCount: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductCount'
      Visible = False
    end
    object adotMLCSubcatModified: TBooleanField
      DisplayWidth = 5
      FieldName = 'Modified'
      Visible = False
    end
  end
  object dsMLCSubcat: TDataSource
    DataSet = adotMLCSubcat
    Left = 200
    Top = 136
  end
  object adotMLCSiteSubcat: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = MLCAfterEdit
    AfterScroll = adotMLCSiteSubcatAfterScroll
    OnCalcFields = adotMLCSiteSubcatCalcFields
    CommandText = 'SELECT * FROM #MLCSiteSubcat ORDER BY SiteId, SubcategoryName'
    CommandTimeout = 0
    Parameters = <>
    Left = 176
    Top = 160
    object adotMLCSiteSubcatSubCategoryName: TStringField
      DisplayLabel = 'Sub Category'
      DisplayWidth = 20
      FieldName = 'SubCategoryName'
    end
    object adotMLCSiteSubcatExcludedProductsText: TStringField
      DisplayLabel = 'Excluded~Products'
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'ExcludedProductsText'
      Size = 11
      Calculated = True
    end
    object adotMLCSiteSubcatTargetYieldPercent: TIntegerField
      DisplayLabel = 'Target~Yield%'
      DisplayWidth = 7
      FieldName = 'TargetYieldPercent'
      OnValidate = TargetYieldPercentValidate
    end
    object adotMLCSiteSubcatExcludeFromMandatoryLineCheck: TBooleanField
      DisplayLabel = 'Exclude'
      DisplayWidth = 5
      FieldName = 'ExcludeFromMandatoryLineCheck'
      OnChange = adotMLCSiteSubcatExcludeFromMandatoryLineCheckChange
    end
    object adotMLCSiteSubcatSiteId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SiteId'
      Visible = False
    end
    object adotMLCSiteSubcatSubCategoryId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SubCategoryId'
      Visible = False
    end
    object adotMLCSiteSubcatDivisionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'DivisionId'
      Visible = False
    end
    object adotMLCSiteSubcatModified: TBooleanField
      DisplayWidth = 5
      FieldName = 'Modified'
      Visible = False
    end
    object adotMLCSiteSubcatExcludedProducts: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExcludedProducts'
      Visible = False
    end
    object adotMLCSiteSubcatProductCount: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductCount'
      Visible = False
    end
    object adotMLCSiteSubcatEstate_TargetYieldPercent: TIntegerField
      FieldName = 'Estate_TargetYieldPercent'
      Visible = False
    end
    object adotMLCSiteSubcatEstate_ExcludeFromMandatoryLineCheck: TBooleanField
      FieldName = 'Estate_ExcludeFromMandatoryLineCheck'
      Visible = False
    end
  end
  object dsMLCSiteSubcat: TDataSource
    DataSet = adotMLCSiteSubcat
    Left = 200
    Top = 160
  end
  object adotMLCProduct: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = MLCAfterEdit
    CommandText = 'SELECT * FROM #MLCProduct ORDER BY PurchaseName'
    CommandTimeout = 0
    DataSource = dsMLCSubcat
    IndexFieldNames = 'SubcategoryId'
    MasterFields = 'SubCategoryId'
    Parameters = <>
    Left = 240
    Top = 136
    object adotMLCProductPurchaseName: TStringField
      DisplayLabel = 'Purchase Name'
      DisplayWidth = 40
      FieldName = 'PurchaseName'
      Size = 40
    end
    object adotMLCProductExcludeFromMandatoryLineCheck: TBooleanField
      DisplayLabel = 'Exclude'
      DisplayWidth = 5
      FieldName = 'ExcludeFromMandatoryLineCheck'
      OnChange = adotMLCProductExcludeFromMandatoryLineCheckChange
    end
    object adotMLCProductProductId: TLargeintField
      FieldName = 'ProductId'
      Visible = False
    end
    object adotMLCProductSubcategoryId: TIntegerField
      FieldName = 'SubcategoryId'
      Visible = False
    end
    object adotMLCProductOriginal_ExcludeFromMandatoryLineCheck: TBooleanField
      FieldName = 'Original_ExcludeFromMandatoryLineCheck'
      Visible = False
    end
    object adotMLCProductModified: TBooleanField
      FieldName = 'Modified'
      Visible = False
    end
  end
  object dsMLCProduct: TDataSource
    DataSet = adotMLCProduct
    Left = 264
    Top = 136
  end
  object adotMLCSiteProduct: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = MLCAfterEdit
    CommandTimeout = 0
    Parameters = <>
    Left = 240
    Top = 160
    object adotMLCSiteProductPurchaseName: TStringField
      DisplayLabel = 'Purchase Name'
      DisplayWidth = 40
      FieldName = 'PurchaseName'
      Size = 40
    end
    object adotMLCSiteProductExcludeFromMandatoryLineCheck: TBooleanField
      DisplayLabel = 'Exclude'
      DisplayWidth = 5
      FieldName = 'ExcludeFromMandatoryLineCheck'
      OnChange = adotMLCSiteProductExcludeFromMandatoryLineCheckChange
    end
    object adotMLCSiteProductSiteID: TIntegerField
      FieldName = 'SiteID'
      Visible = False
    end
    object adotMLCSiteProductProductId: TLargeintField
      FieldName = 'ProductId'
      Visible = False
    end
    object adotMLCSiteProductSubcategoryId: TIntegerField
      FieldName = 'SubcategoryId'
      Visible = False
    end
    object adotMLCSiteProductEstate_ExcludeFromMandatoryLineCheck: TBooleanField
      FieldName = 'Estate_ExcludeFromMandatoryLineCheck'
      Visible = False
    end
    object adotMLCSiteProductModified: TBooleanField
      FieldName = 'Modified'
      Visible = False
    end
  end
  object dsMLCSiteProduct: TDataSource
    DataSet = adotMLCSiteProduct
    Left = 264
    Top = 160
  end
  object adotMLCDivision: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterEdit = MLCAfterEdit
    AfterScroll = adotMLCDivisionAfterScroll
    CommandText = 'SELECT * FROM #MLCDivision ORDER BY DivisionName'
    CommandTimeout = 0
    Parameters = <>
    Left = 296
    Top = 136
    object adotMLCDivisionDivisionName: TStringField
      DisplayLabel = 'Division'
      DisplayWidth = 20
      FieldName = 'DivisionName'
    end
    object adotMLCDivisionIncludeInMandatoryLineCheck: TBooleanField
      DisplayLabel = 'Mandatory~Line Check'
      DisplayWidth = 5
      FieldName = 'IncludeInMandatoryLineCheck'
    end
    object adotMLCDivisionDivisionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'DivisionId'
      Visible = False
    end
    object adotMLCDivisionModified: TBooleanField
      FieldName = 'Modified'
      Visible = False
    end
  end
  object dsMLCDivision: TDataSource
    DataSet = adotMLCDivision
    Left = 320
    Top = 136
  end
  object cmdLoadMandatoryLineCheckData: TADOCommand
    CommandText = 
      'IF OBJECT_ID('#39'tempdb..#MLCSite'#39') IS NOT NULL DROP TABLE #MLCSite' +
      #13#10'IF OBJECT_ID('#39'tempdb..#MLCDivision'#39') IS NOT NULL DROP TABLE #M' +
      'LCDivision'#13#10'IF OBJECT_ID('#39'tempdb..#MLCSubcat'#39') IS NOT NULL DROP ' +
      'TABLE #MLCSubcat'#13#10'IF OBJECT_ID('#39'tempdb..#MLCProduct'#39') IS NOT NUL' +
      'L DROP TABLE #MLCProduct'#13#10'IF OBJECT_ID('#39'tempdb..#MLCSiteSubcat'#39')' +
      ' IS NOT NULL DROP TABLE #MLCSiteSubcat'#13#10'IF OBJECT_ID('#39'tempdb..#M' +
      'LCSiteProduct'#39') IS NOT NULL DROP TABLE #MLCSiteProduct'#13#10#13#10'------' +
      '------------------------------------------------------------'#13#10#13#10 +
      'CREATE TABLE #MLCSite(SiteID int PRIMARY KEY, Name varchar(40), ' +
      'HasExceptions bit DEFAULT(0))'#13#10#13#10'INSERT #MLCSite (SiteId, Name)'#13 +
      #10'SELECT Id, Name FROM ac_Site'#13#10'WHERE Deleted = 0'#13#10#13#10'------------' +
      '------------------------------------------------------'#13#10#13#10'CREATE' +
      ' TABLE #MLCDivision'#13#10'('#13#10'  DivisionId int PRIMARY KEY,'#13#10'  Divisio' +
      'nName varchar(20),'#13#10'  IncludeInMandatoryLineCheck bit,'#13#10'  Origin' +
      'al_IncludeInMandatoryLineCheck bit,'#13#10'  Modified bit DEFAULT(0)'#13#10 +
      ')'#13#10#13#10#13#10'INSERT #MLCDivision (DivisionId, DivisionName, IncludeInM' +
      'andatoryLineCheck, Original_IncludeInMandatoryLineCheck)'#13#10'SELECT' +
      ' Id, Name, IncludeInMandatoryLineCheck, IncludeInMandatoryLineCh' +
      'eck'#13#10'FROM ac_ProductDivision'#13#10'WHERE Deleted = 0'#13#10'--where [index ' +
      'no] in (select distinct DivIx from stkEntity)'#13#10#13#10'---------------' +
      '---------------------------------------------------'#13#10#13#10'CREATE TA' +
      'BLE #MLCSubcat'#13#10'('#13#10'  SubCategoryId int PRIMARY KEY,'#13#10'  SubCatego' +
      'ryName varchar(20),'#13#10'  DivisionId int,'#13#10'  ExcludedProducts int D' +
      'EFAULT(0),'#13#10'  ProductCount int DEFAULT(0),'#13#10'  TargetYieldPercent' +
      ' int DEFAULT(100),'#13#10'  ExcludeFromMandatoryLineCheck bit DEFAULT(' +
      '0),'#13#10'  Original_TargetYieldPercent int DEFAULT(100),'#13#10'  Original' +
      '_ExcludeFromMandatoryLineCheck bit DEFAULT(0),'#13#10'  Modified bit D' +
      'EFAULT (0)'#13#10')'#13#10#13#10#13#10'INSERT #MLCSubcat (SubCategoryId, Subcategory' +
      'Name, DivisionId)'#13#10'SELECT subcat.Id, subcat.Name, cat.ProductDiv' +
      'isionId'#13#10'FROM ac_ProductSubcategory subcat'#13#10'     INNER JOIN ac_P' +
      'roductCategory cat ON subcat.ProductCategoryId = cat.Id '#13#10'WHERE ' +
      'subcat.Deleted = 0 AND cat.Deleted = 0'#13#10#13#10#13#10'UPDATE #MLCSubcat'#13#10'S' +
      'ET TargetYieldPercent = b.TargetYieldPercent,'#13#10'    ExcludeFromMa' +
      'ndatoryLineCheck = b.ExcludeFromMandatoryLineCheck,'#13#10'    Origina' +
      'l_TargetYieldPercent = b.TargetYieldPercent,'#13#10'    Original_Exclu' +
      'deFromMandatoryLineCheck = b.ExcludeFromMandatoryLineCheck'#13#10'FROM' +
      ' #MLCSubcat a'#13#10'     INNER JOIN MandatoryLineCheckSubcategoryInfo' +
      ' b ON a.SubCategoryId = b.SubCategoryId'#13#10'WHERE b.SiteId = 0 AND ' +
      'b.Deleted = 0'#13#10#13#10'-----------------------------------------------' +
      '-------------------'#13#10#13#10'CREATE TABLE #MLCSiteSubcat'#13#10'('#13#10'  SiteId ' +
      'int,'#13#10'  SubCategoryId int,'#13#10'  SubCategoryName varchar(20),'#13#10'  Di' +
      'visionId int,'#13#10'  ExcludedProducts int DEFAULT(0),'#13#10'  ProductCoun' +
      't int DEFAULT(0),'#13#10'  TargetYieldPercent int,'#13#10'  ExcludeFromManda' +
      'toryLineCheck bit,'#13#10'  Original_TargetYieldPercent int,'#13#10'  Origin' +
      'al_ExcludeFromMandatoryLineCheck bit,'#13#10'  Estate_TargetYieldPerce' +
      'nt int, -- The estate wide setting. Included so can highlight wh' +
      'en site setting differs.'#13#10'  Estate_ExcludeFromMandatoryLineCheck' +
      ' bit,'#13#10'  Modified bit DEFAULT (0),'#13#10'  PRIMARY KEY (SiteId, SubCa' +
      'tegoryId)'#13#10')'#13#10#13#10'--CREATE INDEX IX_MLCSiteSubcat_SubcategoryId ON' +
      ' #MLCSiteSubcat(SubcategoryId)'#13#10#13#10'INSERT #MLCSiteSubcat (SiteId,' +
      ' SubCategoryId, SubcategoryName, DivisionId, TargetYieldPercent,' +
      ' ExcludeFromMandatoryLineCheck,'#13#10'  Original_TargetYieldPercent, ' +
      'Original_ExcludeFromMandatoryLineCheck, Estate_TargetYieldPercen' +
      't, Estate_ExcludeFromMandatoryLineCheck)'#13#10'SELECT s.SiteId, t.Sub' +
      'CategoryId, t.SubcategoryName, t.DivisionId, t.TargetYieldPercen' +
      't, t.ExcludeFromMandatoryLineCheck,'#13#10'  t.TargetYieldPercent, t.E' +
      'xcludeFromMandatoryLineCheck, t.TargetYieldPercent, t.ExcludeFro' +
      'mMandatoryLineCheck'#13#10'FROM #MLCSite s'#13#10'     CROSS JOIN #MLCSubcat' +
      ' t'#13#10#13#10'UPDATE #MLCSiteSubcat'#13#10'SET TargetYieldPercent = b.TargetYi' +
      'eldPercent,'#13#10'    ExcludeFromMandatoryLineCheck = b.ExcludeFromMa' +
      'ndatoryLineCheck,'#13#10'    Original_TargetYieldPercent = b.TargetYie' +
      'ldPercent,'#13#10'    Original_ExcludeFromMandatoryLineCheck = b.Exclu' +
      'deFromMandatoryLineCheck'#13#10'FROM #MLCSiteSubcat a'#13#10'     INNER JOIN' +
      ' MandatoryLineCheckSubcategoryInfo b ON a.SiteId = b.SiteId AND ' +
      'a.SubcategoryId = b.SubcategoryId'#13#10'WHERE b.SiteId <> 0 AND b.Del' +
      'eted = 0'#13#10#13#10#13#10'--------------------------------------------------' +
      '----------------'#13#10#13#10'CREATE TABLE #MLCProduct'#13#10'('#13#10'  ProductId big' +
      'int PRIMARY KEY,'#13#10'  PurchaseName varchar(40),'#13#10'  SubcategoryId i' +
      'nt,'#13#10'  ExcludeFromMandatoryLineCheck bit DEFAULT (0),'#13#10'  Origina' +
      'l_ExcludeFromMandatoryLineCheck bit DEFAULT (0),'#13#10'  Modified bit' +
      ' DEFAULT (0)'#13#10')'#13#10#13#10#13#10'INSERT #MLCProduct (ProductId, PurchaseName' +
      ', SubcategoryId)'#13#10'SELECT p.EntityCode, p.[Purchase Name], s.Id'#13#10 +
      'FROM Products p INNER JOIN ac_ProductSubcategory s ON p.[Sub-Cat' +
      'egory Name] = s.Name'#13#10'WHERE p.[Entity Type] IN ('#39'Strd.Line'#39', '#39'Pu' +
      'rch.Line'#39', '#39'Prep.Item'#39') AND ISNULL(p.Deleted, '#39'N'#39') = '#39'N'#39#13#10#13#10#13#10'UP' +
      'DATE #MLCProduct'#13#10'SET ExcludeFromMandatoryLineCheck = b.ExcludeF' +
      'romMandatoryLineCheck,'#13#10'    Original_ExcludeFromMandatoryLineChe' +
      'ck = b.ExcludeFromMandatoryLineCheck'#13#10'FROM #MLCProduct a'#13#10'     I' +
      'NNER JOIN MandatoryLineCheckProductInfo b ON a.ProductId = b.Pro' +
      'ductId'#13#10'WHERE b.SiteId = 0 AND b.Deleted = 0'#13#10#13#10#13#10'UPDATE #MLCSub' +
      'cat'#13#10'SET ExcludedProducts = b.ExcludedProducts,'#13#10'    ProductCoun' +
      't = b.ProductCount'#13#10'FROM #MLCSubcat a'#13#10'     INNER JOIN'#13#10'     (SE' +
      'LECT SubcategoryId, COUNT(*) AS ProductCount, SUM(CONVERT(int, E' +
      'xcludeFromMandatoryLineCheck)) AS ExcludedProducts'#13#10'      FROM #' +
      'MLCProduct'#13#10'      GROUP BY SubcategoryId) b ON a.SubcategoryId =' +
      ' b.SubcategoryId'#13#10#13#10'--------------------------------------------' +
      '----------------------'#13#10#13#10'CREATE TABLE #MLCSiteProduct'#13#10'('#13#10'  Sit' +
      'eID int,'#13#10'  ProductId bigint,'#13#10'  PurchaseName varchar(40),'#13#10'  Su' +
      'bcategoryId int,'#13#10'  ExcludeFromMandatoryLineCheck bit,'#13#10'  Estate' +
      '_ExcludeFromMandatoryLineCheck bit,  -- The estate wide setting.' +
      ' Included so can highlight when site setting differs.'#13#10'  Origina' +
      'l_ExcludeFromMandatoryLineCheck bit,'#13#10'  Modified bit DEFAULT (0)' +
      #13#10'  PRIMARY KEY (SiteId, ProductId)'#13#10')'#13#10#13#10'--CREATE INDEX IX_MLCS' +
      'iteProduct_ProductId ON #MLCSiteProduct(ProductId)'#13#10#13#10'--drop IND' +
      'EX #MLCSiteProduct.IX_MLCSiteProduct_ProductId'#13#10#13#10#13#10'INSERT #MLCS' +
      'iteProduct (SiteId, ProductId, PurchaseName, SubcategoryId, Excl' +
      'udeFromMandatoryLineCheck,'#13#10'       Estate_ExcludeFromMandatoryLi' +
      'neCheck, Original_ExcludeFromMandatoryLineCheck)'#13#10'SELECT s.SiteI' +
      'd, t.ProductId, t.PurchaseName, t.SubcategoryId, t.ExcludeFromMa' +
      'ndatoryLineCheck, t.ExcludeFromMandatoryLineCheck, t.ExcludeFrom' +
      'MandatoryLineCheck'#13#10'FROM #MLCSite s CROSS JOIN #MLCProduct t'#13#10#13#10 +
      #13#10'UPDATE #MLCSiteProduct'#13#10'SET ExcludeFromMandatoryLineCheck = b.' +
      'ExcludeFromMandatoryLineCheck,'#13#10'    Original_ExcludeFromMandator' +
      'yLineCheck = b.ExcludeFromMandatoryLineCheck'#13#10'FROM #MLCSiteProdu' +
      'ct a'#13#10'     INNER JOIN MandatoryLineCheckProductInfo b ON a.SiteI' +
      'd = b.SiteId AND a.ProductId = b.ProductId'#13#10'WHERE b.SiteId <> 0 ' +
      'AND b.Deleted = 0'#13#10#13#10#13#10'UPDATE #MLCSiteSubcat'#13#10'SET ExcludedProduc' +
      'ts = b.ExcludedProducts,'#13#10'    ProductCount = b.ProductCount'#13#10'FRO' +
      'M #MLCSiteSubcat a'#13#10'     INNER JOIN'#13#10'     (SELECT SiteId, Subcat' +
      'egoryId, COUNT(*) AS ProductCount, SUM(CONVERT(int, ExcludeFromM' +
      'andatoryLineCheck)) AS ExcludedProducts'#13#10'      FROM #MLCSiteProd' +
      'uct'#13#10'      GROUP BY SiteId, SubcategoryId) b ON a.SiteID = b.Sit' +
      'eId AND a.SubcategoryId = b.SubcategoryId'#13#10#13#10
    CommandTimeout = 0
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 296
    Top = 160
  end
  object cmdSaveMandatoryLineCheckChanges: TADOCommand
    CommandText = 
      'UPDATE ac_ProductDivision'#13#10'SET IncludeInMandatoryLineCheck = b.I' +
      'ncludeInMandatoryLineCheck'#13#10'FROM ac_ProductDivision a'#13#10'     INNE' +
      'R JOIN #MLCDivision b ON a.Id = b.DivisionId'#13#10'WHERE a.IncludeInM' +
      'andatoryLineCheck <> b.IncludeInMandatoryLineCheck'#13#10#13#10'-- Store t' +
      'he date & time when Mandatory Line Checks were first enabled on ' +
      'the head office. This'#13#10'-- will be used by the head office Things' +
      '-To-Do check to prevent it from reporting'#13#10'-- "Mandatory line ch' +
      'eck not completed yesterday" too soon.'#13#10'IF dbo.fnGetLocalDateVar' +
      'iable('#39'DateMandatoryLineChecksEnabled'#39', NULL) IS NULL'#13#10'BEGIN'#13#10'  ' +
      'IF EXISTS(SELECT * FROM ac_ProductDivision WHERE IncludeInMandat' +
      'oryLineCheck = 1)'#13#10'  BEGIN'#13#10'    DECLARE @Now datetime'#13#10'    SET @' +
      'Now = GetDate()'#13#10'    EXEC spSetLocalDateVariable '#39'DateMandatoryL' +
      'ineChecksEnabled'#39', @Now'#13#10'  END'#13#10'END'#13#10'ELSE'#13#10'BEGIN'#13#10'  IF NOT EXIST' +
      'S(SELECT * FROM ac_ProductDivision WHERE IncludeInMandatoryLineC' +
      'heck = 1)'#13#10'    EXEC spSetLocalDateVariable '#39'DateMandatoryLineChe' +
      'cksEnabled'#39', NULL'#13#10'END'#13#10#13#10'--------------------------------------' +
      '---------------------------------'#13#10#13#10'UPDATE MandatoryLineCheckSu' +
      'bcategoryInfo'#13#10'SET TargetYieldPercent = b.TargetYieldPercent,'#13#10' ' +
      '   ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineChe' +
      'ck,'#13#10'    Deleted = 0,'#13#10'    LMDT = GetDate()'#13#10'FROM MandatoryLineC' +
      'heckSubcategoryInfo a'#13#10'     INNER JOIN'#13#10'     (SELECT 0 AS SiteID' +
      ', SubCategoryId, TargetYieldPercent, ExcludeFromMandatoryLineChe' +
      'ck, Modified'#13#10'      FROM #MLCSubcat'#13#10'      UNION ALL'#13#10'      SELE' +
      'CT SiteID, SubCategoryId, TargetYieldPercent, ExcludeFromMandato' +
      'ryLineCheck, Modified'#13#10'      FROM #MLCSiteSubcat) b ON a.SiteId ' +
      '= b.SiteId AND a.SubCategoryId = b.SubCategoryId'#13#10'WHERE b.Modifi' +
      'ed = 1'#13#10'  AND NOT (a.TargetYieldPercent = b.TargetYieldPercent A' +
      'ND a.ExcludeFromMandatoryLineCheck = b.ExcludeFromMandatoryLineC' +
      'heck AND a.Deleted = 0)'#13#10#13#10#13#10'INSERT MandatoryLineCheckSubcategor' +
      'yInfo (SiteID, SubcategoryId, TargetYieldPercent, ExcludeFromMan' +
      'datoryLineCheck)'#13#10'SELECT SiteId, SubcategoryId, TargetYieldPerce' +
      'nt, ExcludeFromMandatoryLineCheck'#13#10'FROM (SELECT 0 AS SiteID, Sub' +
      'CategoryId, TargetYieldPercent, ExcludeFromMandatoryLineCheck, M' +
      'odified'#13#10'      FROM #MLCSubcat'#13#10'      UNION ALL'#13#10'      SELECT Si' +
      'teID, SubCategoryId, TargetYieldPercent, ExcludeFromMandatoryLin' +
      'eCheck, Modified'#13#10'      FROM #MLCSiteSubcat) a'#13#10'WHERE a.Modified' +
      ' = 1'#13#10'  AND NOT EXISTS (SELECT * FROM MandatoryLineCheckSubcateg' +
      'oryInfo WHERE SiteID = a.SiteId AND SubcategoryId = a.Subcategor' +
      'yId)'#13#10#13#10#13#10'-- Mark as Deleted any estate entries which now contai' +
      'n the default values.'#13#10'UPDATE MandatoryLineCheckSubcategoryInfo'#13 +
      #10'SET Deleted = 1,'#13#10'    LMDT = GetDate()'#13#10'WHERE SiteId = 0 AND Ta' +
      'rgetYieldPercent = 100 AND ExcludeFromMandatoryLineCheck = 0'#13#10#13#10 +
      #13#10'-- Mark as Deleted any site exception entries which are now id' +
      'entical to the estate entry'#13#10'UPDATE MandatoryLineCheckSubcategor' +
      'yInfo'#13#10'SET Deleted = 1,'#13#10'    LMDT = GetDate()'#13#10'FROM MandatoryLin' +
      'eCheckSubcategoryInfo a'#13#10'     INNER JOIN '#13#10'     (SELECT * FROM #' +
      'MLCSiteSubcat'#13#10'      WHERE TargetYieldPercent = Estate_TargetYie' +
      'ldPercent'#13#10'        AND ExcludeFromMandatoryLineCheck = Estate_Ex' +
      'cludeFromMandatoryLineCheck) b'#13#10'     ON a.SiteId = b.SiteId AND ' +
      'a.SubcategoryId = b.SubcategoryId'#13#10#13#10'---------------------------' +
      '--------------------------------------------'#13#10#13#10'UPDATE Mandatory' +
      'LineCheckProductInfo'#13#10'SET ExcludeFromMandatoryLineCheck = b.Excl' +
      'udeFromMandatoryLineCheck,'#13#10'    Deleted = 0,'#13#10'    LMDT = GetDate' +
      '()'#13#10'FROM MandatoryLineCheckProductInfo a'#13#10'     INNER JOIN'#13#10'     ' +
      '(SELECT 0 AS SiteID, ProductId, ExcludeFromMandatoryLineCheck, M' +
      'odified'#13#10'      FROM #MLCProduct'#13#10'      UNION ALL'#13#10'      SELECT S' +
      'iteID, ProductId, ExcludeFromMandatoryLineCheck, Modified'#13#10'     ' +
      ' FROM #MLCSiteProduct) b ON a.SiteId = b.SiteId AND a.ProductId ' +
      '= b.ProductId'#13#10'WHERE b.Modified = 1'#13#10'  AND NOT (a.ExcludeFromMan' +
      'datoryLineCheck = b.ExcludeFromMandatoryLineCheck AND a.Deleted ' +
      '= 0)'#13#10#13#10#13#10'INSERT MandatoryLineCheckProductInfo (SiteID, ProductI' +
      'd, ExcludeFromMandatoryLineCheck)'#13#10'SELECT SiteId, ProductId, Exc' +
      'ludeFromMandatoryLineCheck'#13#10'FROM (SELECT 0 AS SiteID, ProductId,' +
      ' ExcludeFromMandatoryLineCheck, Modified'#13#10'      FROM #MLCProduct' +
      #13#10'      UNION ALL'#13#10'      SELECT SiteID, ProductId, ExcludeFromMa' +
      'ndatoryLineCheck, Modified'#13#10'      FROM #MLCSiteProduct) a'#13#10'WHERE' +
      ' a.Modified = 1'#13#10'  AND NOT EXISTS (SELECT * FROM MandatoryLineCh' +
      'eckProductInfo WHERE SiteID = a.SiteId AND ProductId = a.Product' +
      'Id)'#13#10#13#10#13#10'-- Mark as Deleted any estate entries which now contain' +
      ' the default values.'#13#10'UPDATE MandatoryLineCheckProductInfo'#13#10'SET ' +
      'Deleted = 1,'#13#10'    LMDT = GetDate()'#13#10'WHERE SiteId = 0 AND Exclude' +
      'FromMandatoryLineCheck = 0'#13#10#13#10#13#10'-- Mark as Deleted any site exce' +
      'ption entries which are now identical to the estate entry'#13#10'UPDAT' +
      'E MandatoryLineCheckProductInfo'#13#10'SET Deleted = 1,'#13#10'    LMDT = Ge' +
      'tDate()'#13#10'FROM MandatoryLineCheckProductInfo a'#13#10'     INNER JOIN '#13 +
      #10'     (SELECT * FROM #MLCSiteProduct'#13#10'      WHERE ExcludeFromMan' +
      'datoryLineCheck = Estate_ExcludeFromMandatoryLineCheck) b'#13#10'     ' +
      'ON a.SiteId = b.SiteId AND a.ProductId = b.ProductId'#13#10#13#10#13#10'EXEC s' +
      'p_SetGlobalConfiguration :NumProductsInMandatoryLineCheck_Key, :' +
      'NumProductsInMandatoryLineCheck_Value'#13#10#13#10'-----------------------' +
      '------------------------------------------------'#13#10#13#10'-- Update co' +
      'lumns in temp tables to reflect the fact all changes are now sav' +
      'ed.'#13#10'UPDATE #MLCDivision'#13#10'SET Original_IncludeInMandatoryLineChe' +
      'ck = IncludeInMandatoryLineCheck,'#13#10'    Modified = 0'#13#10#13#10'UPDATE #M' +
      'LCSubcat'#13#10'SET Original_TargetYieldPercent = TargetYieldPercent,'#13 +
      #10'    Original_ExcludeFromMandatoryLineCheck = ExcludeFromMandato' +
      'ryLineCheck,'#13#10'    Modified = 0'#13#10'WHERE Modified = 1'#13#10#13#10'UPDATE #ML' +
      'CSiteSubcat'#13#10'SET Original_TargetYieldPercent = TargetYieldPercen' +
      't,'#13#10'    Original_ExcludeFromMandatoryLineCheck = ExcludeFromMand' +
      'atoryLineCheck,'#13#10'    Modified = 0'#13#10'WHERE Modified = 1'#13#10#13#10'UPDATE ' +
      '#MLCProduct'#13#10'SET Original_ExcludeFromMandatoryLineCheck = Exclud' +
      'eFromMandatoryLineCheck,'#13#10'    Modified = 0'#13#10'WHERE Modified = 1'#13#10 +
      #13#10'UPDATE #MLCSiteProduct'#13#10'SET Original_ExcludeFromMandatoryLineC' +
      'heck = ExcludeFromMandatoryLineCheck,'#13#10'    Modified = 0'#13#10'WHERE M' +
      'odified = 1'#13#10#13#10
    CommandTimeout = 0
    Connection = dmADO.AztecConn
    Prepared = True
    Parameters = <
      item
        Name = 'NumProductsInMandatoryLineCheck_Key'
        Size = -1
        Value = Null
      end
      item
        Name = 'NumProductsInMandatoryLineCheck_Value'
        Size = -1
        Value = Null
      end>
    Left = 320
    Top = 160
  end
  object ADOCommand: TADOCommand
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 736
  end
  object adoqLocations: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqLocationsAfterScroll
    AfterScroll = adoqLocationsAfterScroll
    CommandTimeout = 120
    Parameters = <>
    SQL.Strings = (
      
        'select loc.[LocationID], loc.[LocationName], loc.[Active], loc.[' +
        'Deleted], loc.[LMDT],'
      '   loc.[PrintNote], loc.HasFixedQty, '
      '   ll.allLines, ll.unqProdUnits, ll.unqProds, ll.LastEdit '
      'from stkLocations loc'
      'left join (select sitecode, locationid, count(*) as allLines,'
      
        '     count(distinct (cast((entitycode - 10000000000) as varchar ' +
        '(12)) + unit)) as unqProdUnits,'
      
        '     count(distinct entitycode) as unqProds, MAX(LMDT) as LastEd' +
        'it'
      '     from stkLocationLists  group by sitecode, locationid) ll'
      'on loc.SiteCode = ll.SiteCode and loc.LocationID = ll.LocationID'
      'where loc.SiteCode = 1'
      'and loc.Deleted = 0')
    Left = 384
    Top = 344
    object adoqLocationsLocationID: TIntegerField
      FieldName = 'LocationID'
    end
    object adoqLocationsLocationName: TStringField
      FieldName = 'LocationName'
      Size = 25
    end
    object adoqLocationsLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object adoqLocationsPrintNote: TStringField
      FieldName = 'PrintNote'
      Size = 320
    end
    object adoqLocationsHasFixedQty: TBooleanField
      FieldName = 'HasFixedQty'
    end
    object adoqLocationsallLines: TIntegerField
      FieldName = 'allLines'
      ReadOnly = True
    end
    object adoqLocationsunqProdUnits: TIntegerField
      FieldName = 'unqProdUnits'
      ReadOnly = True
    end
    object adoqLocationsunqProds: TIntegerField
      FieldName = 'unqProds'
      ReadOnly = True
    end
    object adoqLocationsLastEdit: TDateTimeField
      DisplayWidth = 14
      FieldName = 'LastEdit'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yy hh:nn'
    end
    object adoqLocationsDeleted: TBooleanField
      FieldName = 'Deleted'
    end
  end
  object dsLocations: TwwDataSource
    DataSet = adoqLocations
    Left = 416
    Top = 344
  end
  object adoqLocationList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 120
    Parameters = <>
    SQL.Strings = (
      
        '    SQL.Add('#39'Select ll.[RecID],ll.[EntityCode],ll.[Unit],ll.[Man' +
        'ualAdd], se.[SCat], se.[PurchaseName], '#39');'
      
        '    SQL.Add('#39'CASE se.ETCode WHEN '#39#39'P'#39#39' THEN '#39#39'Prep.- '#39#39' + isNULL' +
        '(p.[Retail Description], '#39#39#39#39')'#39' +'
      
        '                            '#39'ELSE p.[Retail Description] END  as' +
        ' Descr,'#39');'
      
        '    SQL.Add('#39'CASE se.ETCode WHEN '#39#39'P'#39#39' THEN se.ETCode ELSE '#39#39#39#39' ' +
        'END as isPrepItem, '#39');'
      
        '    SQL.Add('#39'CASE WHEN se.PurchaseUnit = ll.Unit THEN 1 ELSE 0 E' +
        'ND as isPurchUnit, 1, 0'#39');'
      '    SQL.Add('#39'FROM [stkLocationLists] ll'#39');'
      
        '    SQL.Add('#39'   join stkEntity se on ll.EntityCode = se.EntityCo' +
        'de'#39');'
      
        '    SQL.Add('#39'   join products p on se.EntityCode = p.EntityCode'#39 +
        ');'
      '    SQL.Add('#39'WHERE ll.SiteCode = '#39' + inttostr(curSiteID));'
      '    SQL.Add('#39'AND ll.LocationID = '#39' + inttostr(curLocID));')
    Left = 448
    Top = 344
  end
  object dsLocationList: TwwDataSource
    DataSet = adoqLocationList
    Left = 480
    Top = 344
  end
  object dsMustCountTemplate: TwwDataSource
    DataSet = adoqMustCountTemplates
    Left = 368
    Top = 288
  end
  object dsMustCountTemplateSites: TwwDataSource
    DataSet = adotMustCountTemplateSites
    Left = 272
    Top = 288
  end
  object adotMustCountTemplateSites: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = adotMustCountTemplateSitesAfterPost
    AfterScroll = adotMustCountTemplateSitesAfterScroll
    TableName = '[#MustCountTemplateSites]'
    Left = 232
    Top = 288
  end
  object adoqMustCountTemplates: TADOQuery
    Connection = dmADO.AztecConn
    AfterOpen = adoqMustCountTemplatesAfterScroll
    AfterScroll = adoqMustCountTemplatesAfterScroll
    Parameters = <>
    Left = 336
    Top = 288
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dsMustCountTemplateSites
    SearchField = 'SiteName'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 424
    Top = 64
  end
end
