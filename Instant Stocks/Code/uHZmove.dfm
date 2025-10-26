object fHZmove: TfHZmove
  Left = 207
  Top = 179
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Internal Transfer'
  ClientHeight = 678
  ClientWidth = 1166
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStep3: TPanel
    Left = 118
    Top = 38
    Width = 570
    Height = 551
    HelpContext = 1034
    TabOrder = 1
    Visible = False
    object Label19: TLabel
      Left = 5
      Top = 445
      Width = 302
      Height = 13
      Caption = 'Type a Transfer Note (optional; max. 255 characters)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label21: TLabel
      Left = 188
      Top = 507
      Width = 174
      Height = 41
      Alignment = taRightJustify
      AutoSize = False
      Caption = 
        'Transfer Rows: 355'#13#10'Products: 256'#13#10'("Confirm && Save" also Print' +
        's)'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object wwDBGrid1: TwwDBGrid
      Left = 4
      Top = 23
      Width = 563
      Height = 418
      Selected.Strings = (
        'RecID'#9'3'#9'No.'#9#9
        'PurN'#9'20'#9'Name'#9#9
        'Unit'#9'10'#9'Unit'#9#9
        'Qty'#9'10'#9'Qty'#9#9
        'Sub'#9'20'#9'Sub-Category'#9#9
        'Descr'#9'20'#9'Description'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Color = clBtnFace
      DataSource = dsList
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
      UseTFields = False
      OnDblClick = gridListDblClick
    end
    object Memo1: TMemo
      Left = 5
      Top = 459
      Width = 560
      Height = 47
      MaxLength = 255
      TabOrder = 2
      WantReturns = False
    end
    object BitBtn5: TBitBtn
      Left = 4
      Top = 513
      Width = 179
      Height = 30
      Caption = 'Consolidate Products per Unit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object BitBtn7: TBitBtn
      Left = 366
      Top = 509
      Width = 69
      Height = 36
      Caption = '&Back'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn7Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
        AAAAAAAAAAAAAAAAAAAAAAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA800
        8AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008AAAAAA8008AA8008AA
        AAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA80
        08AAAAAAA8008AA8008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}
    end
    object BitBtn8: TBitBtn
      Left = 440
      Top = 509
      Width = 124
      Height = 36
      Caption = '&Confirm && Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 5
      OnClick = BitBtn8Click
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
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 568
      Height = 22
      Align = alTop
      TabOrder = 1
      object Label18: TLabel
        Left = 1
        Top = 1
        Width = 46
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = '   From:  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object lblFrom: TLabel
        Left = 47
        Top = 1
        Width = 60
        Height = 20
        Align = alLeft
        Caption = 'lblFrom'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object Label20: TLabel
        Left = 107
        Top = 1
        Width = 38
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = '    To:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object lblTo: TLabel
        Left = 145
        Top = 1
        Width = 39
        Height = 20
        Align = alLeft
        Caption = 'lblTo'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
    end
  end
  object pnlStep1: TPanel
    Left = 4
    Top = 4
    Width = 305
    Height = 265
    HelpContext = 1032
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      Left = 47
      Top = 35
      Width = 201
      Height = 13
      AutoSize = False
      Caption = 'Transfer From:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 4
      Top = 4
      Width = 294
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Step 1: Choose the transfer holding zones'
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
    object Label3: TLabel
      Left = 47
      Top = 91
      Width = 201
      Height = 13
      AutoSize = False
      Caption = 'Transfer To:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label22: TLabel
      Left = 47
      Top = 145
      Width = 100
      Height = 13
      AutoSize = False
      Caption = 'Move Date/Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 149
      Top = 147
      Width = 103
      Height = 12
      Caption = '(Max Date/Time = NOW)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object btnChooseItems: TBitBtn
      Left = 148
      Top = 208
      Width = 147
      Height = 33
      Caption = 'Ne&xt (choose items)'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnChooseItemsClick
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
    object BitBtn2: TBitBtn
      Left = 40
      Top = 208
      Width = 91
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Kind = bkCancel
    end
    object lookSource: TwwDBLookupCombo
      Left = 47
      Top = 49
      Width = 209
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'hzname'#9'30'#9'hzname'#9'F')
      LookupTable = adoqSource
      LookupField = 'hzid'
      Style = csDropDownList
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = lookSourceCloseUp
    end
    object lookDest: TwwDBLookupCombo
      Left = 47
      Top = 105
      Width = 209
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'hzname'#9'30'#9'hzname'#9'F')
      LookupTable = adoqDest
      LookupField = 'hzid'
      Style = csDropDownList
      Enabled = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = lookDestChange
    end
    object dtPick: TwwDBDateTimePicker
      Left = 47
      Top = 158
      Width = 209
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 2
      DisplayFormat = 'ddddd hh:nn'
    end
  end
  object pnlStep2: TPanel
    Left = 91
    Top = 54
    Width = 1070
    Height = 577
    HelpContext = 1033
    TabOrder = 2
    Visible = False
    object PanelLeft: TPanel
      Left = 1
      Top = 37
      Width = 444
      Height = 539
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object pnlSearch: TPanel
        Left = 0
        Top = 468
        Width = 444
        Height = 71
        Align = alBottom
        TabOrder = 0
        object Label14: TLabel
          Left = 3
          Top = 6
          Width = 125
          Height = 13
          Caption = 'Product Name Search'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 116
          Top = 27
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
        object Label17: TLabel
          Left = 254
          Top = 27
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
        object edSearch: TEdit
          Left = 131
          Top = 3
          Width = 149
          Height = 21
          Hint = 
            'Type the Search string required '#13#10'AND press F3 or F2 to do the s' +
            'earch'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Visible = False
        end
        object rbSInc: TRadioButton
          Left = 4
          Top = 26
          Width = 110
          Height = 17
          Caption = 'Incremental Search'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbSIncClick
        end
        object rbsMid: TRadioButton
          Left = 151
          Top = 26
          Width = 103
          Height = 17
          Caption = 'Mid-Word Search'
          TabOrder = 2
          OnClick = rbSIncClick
        end
        object btnPriorSearch: TBitBtn
          Left = 68
          Top = 42
          Width = 102
          Height = 25
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
          Left = 175
          Top = 42
          Width = 104
          Height = 25
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
        object incSearch1: TwwIncrementalSearch
          Left = 131
          Top = 3
          Width = 148
          Height = 21
          DataSource = dsProds
          SearchField = 'PurN'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 5
        end
      end
      object gridProds: TwwDBGrid
        Left = 0
        Top = 0
        Width = 444
        Height = 468
        Selected.Strings = (
          'Sub'#9'20'#9'Sub-Category'
          'PurN'#9'30'#9'Product Name'#9'F'
          'Descr'#9'30'#9'Retail Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsProds
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
        OnCalcTitleAttributes = gridProdsCalcTitleAttributes
        OnTitleButtonClick = gridProdsTitleButtonClick
        OnDblClick = gridProdsDblClick
      end
    end
    object PanelTop: TPanel
      Left = 1
      Top = 1
      Width = 1068
      Height = 36
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label5: TLabel
        Left = 181
        Top = 3
        Width = 436
        Height = 13
        AutoSize = False
        Caption = 
          'Select a product. Press '#39'Enter'#39', Double-Click or click '#39'Transfer' +
          #39'. The Insert box will appear.'
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 7
        Top = 3
        Width = 175
        Height = 13
        AutoSize = False
        Caption = 'Products available for transfer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Panel4: TPanel
        Left = 519
        Top = 18
        Width = 618
        Height = 16
        BevelOuter = bvNone
        Color = clWindow
        TabOrder = 0
        object Label23: TLabel
          Left = 0
          Top = 0
          Width = 36
          Height = 16
          Align = alLeft
          Caption = ' From:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lblFrom1: TLabel
          Left = 36
          Top = 0
          Width = 53
          Height = 16
          Align = alLeft
          Caption = 'lblFrom'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label25: TLabel
          Left = 89
          Top = 0
          Width = 28
          Height = 16
          Align = alLeft
          Caption = '  To:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lblTo1: TLabel
          Left = 117
          Top = 0
          Width = 37
          Height = 16
          Align = alLeft
          Caption = 'lblTo'
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
      end
    end
    object ClientPanel: TPanel
      Left = 445
      Top = 37
      Width = 624
      Height = 539
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Imp'
      TabOrder = 2
      object Bevel3: TBevel
        Left = 57
        Top = 92
        Width = 563
        Height = 386
        Style = bsRaised
      end
      object Bevel1: TBevel
        Left = 57
        Top = 6
        Width = 501
        Height = 83
        Shape = bsFrame
        Style = bsRaised
      end
      object Bevel2: TBevel
        Left = 281
        Top = 14
        Width = 274
        Height = 46
        Style = bsRaised
      end
      object Label7: TLabel
        Left = 64
        Top = 94
        Width = 72
        Height = 13
        Caption = 'Transfer List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 140
        Top = 94
        Width = 357
        Height = 13
        AutoSize = False
        Caption = 
          'Press '#39'Delete'#39' to delete record. Press '#39'Enter'#39' to show the Edit ' +
          'box.'
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label9: TLabel
        Left = 66
        Top = 0
        Width = 124
        Height = 13
        Caption = ' Products Grid Filters '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 93
        Top = 20
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
      object Label11: TLabel
        Left = 88
        Top = 43
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
      object Label12: TLabel
        Left = 62
        Top = 66
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
      object Label13: TLabel
        Left = 289
        Top = 21
        Width = 81
        Height = 13
        Caption = 'Product Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 282
        Top = 63
        Width = 104
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = 'Filtering is OFF'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object Bevel4: TBevel
        Left = 3
        Top = 220
        Width = 55
        Height = 258
        Style = bsRaised
      end
      object Label4: TLabel
        Left = 52
        Top = 221
        Width = 10
        Height = 256
        AutoSize = False
      end
      object BitBtn3: TBitBtn
        Left = 391
        Top = 508
        Width = 85
        Height = 27
        Caption = '&Back'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn3Click
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
          AAAAAAAAAAAAAAAAAAAAAAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA800
          8AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008AAAAAA8008AA8008AA
          AAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA80
          08AAAAAAA8008AA8008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}
      end
      object BitBtn4: TBitBtn
        Left = 480
        Top = 508
        Width = 141
        Height = 27
        Caption = '&Finalize Transfer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn4Click
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
      object lookDiv: TComboBox
        Left = 141
        Top = 16
        Width = 137
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
        OnCloseUp = lookDivCloseUp
      end
      object lookCat: TComboBox
        Left = 141
        Top = 39
        Width = 137
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
        Left = 141
        Top = 62
        Width = 137
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
        OnCloseUp = lookSCatCloseUp
      end
      object edFilt: TEdit
        Left = 377
        Top = 17
        Width = 149
        Height = 21
        TabOrder = 5
      end
      object rbStart: TRadioButton
        Left = 285
        Top = 42
        Width = 121
        Height = 17
        Caption = 'Partial Match at Start'
        Checked = True
        TabOrder = 6
        TabStop = True
      end
      object rbMid: TRadioButton
        Left = 415
        Top = 42
        Width = 133
        Height = 17
        Caption = 'Partial Match Anywhere'
        TabOrder = 7
      end
      object btnFilter: TBitBtn
        Left = 481
        Top = 62
        Width = 74
        Height = 23
        Caption = 'Filter (F5)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = btnFilterClick
      end
      object btnNoFilter: TBitBtn
        Left = 392
        Top = 62
        Width = 85
        Height = 23
        Caption = 'No Filter (F6)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        OnClick = btnNoFilterClick
      end
      object btnTransfer: TBitBtn
        Left = -2
        Top = 143
        Width = 54
        Height = 35
        Caption = 'Transfer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = btnTransferClick
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
        Spacing = 0
      end
      object btnDel: TBitBtn
        Left = 11
        Top = 262
        Width = 56
        Height = 35
        Caption = 'Delete'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = btnDelClick
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
        Spacing = 0
      end
      object btnEdit: TBitBtn
        Left = 11
        Top = 323
        Width = 56
        Height = 35
        Caption = 'Edit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = btnEditClick
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
        Spacing = 0
      end
      object BitBtn9: TBitBtn
        Left = 3
        Top = 478
        Width = 169
        Height = 26
        Caption = 'View/Print Transfer List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = BitBtn9Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
          8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
          8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
          8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
      end
      object gridList: TwwDBGrid
        Left = 63
        Top = 108
        Width = 555
        Height = 368
        Selected.Strings = (
          'RecID'#9'3'#9'No.'#9#9
          'PurN'#9'30'#9'Name'#9'F'
          'Unit'#9'10'#9'Unit'#9#9
          'Qty'#9'10'#9'Qty'#9#9
          'Sub'#9'20'#9'Sub-Category'#9#9
          'Descr'#9'30'#9'Retail Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 4
        ShowHorzScrollBar = True
        Color = clBtnFace
        DataSource = dsList
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
        TabOrder = 14
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnDblClick = gridListDblClick
      end
      object BitBtnImportDeliveryNote: TBitBtn
        Left = 4
        Top = 510
        Width = 169
        Height = 25
        Caption = 'Import Delivery Note'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 15
        OnClick = BitBtnImportDeliveryNoteClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
          FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
          00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
          F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
          00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
          F033777777777337F73309999990FFF0033377777777FFF77333099999000000
          3333777777777777333333399033333333333337773333333333333903333333
          3333333773333333333333303333333333333337333333333333}
        NumGlyphs = 2
      end
    end
  end
  object adoqSource: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select hzid, hzname, ePur from stkhzs where active = 1')
    Left = 8
    Top = 64
  end
  object dsList: TwwDataSource
    DataSet = adotList
    Left = 568
    Top = 184
  end
  object adoqDest: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'thesource'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select hzid, hzname from stkhzs where active = 1'
      'and hzid <> :thesource')
    Left = 8
    Top = 96
  end
  object dsProds: TwwDataSource
    DataSet = adotProds
    Left = 536
    Top = 184
  end
  object adotProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'sub = '#39'020 Draught Bitter'#39' and purN like '#39'*dew*'#39
    TableName = 'stkHZMProdsTMP'
    Left = 504
    Top = 184
  end
  object adotList: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adotListAfterPost
    IndexFieldNames = 'recid'
    TableName = 'stkHZMListTMP'
    Left = 536
    Top = 152
    object adotListRecID: TIntegerField
      FieldName = 'RecID'
    end
    object adotListEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object adotListSub: TStringField
      FieldName = 'Sub'
    end
    object adotListPurN: TStringField
      DisplayWidth = 40
      FieldName = 'PurN'
      Size = 40
    end
    object adotListQty: TFloatField
      FieldName = 'Qty'
      OnGetText = adotListQtyGetText
    end
    object adotListUnit: TStringField
      FieldName = 'Unit'
      Size = 10
    end
    object adotListBaseUnits: TFloatField
      FieldName = 'BaseUnits'
    end
    object adotListgrp: TIntegerField
      FieldName = 'grp'
    end
    object adotListrecid2: TIntegerField
      FieldName = 'recid2'
    end
    object adotListDescr: TStringField
      FieldName = 'Descr'
    end
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dsProds
    SearchField = 'PurN'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 536
    Top = 120
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = dsList
    UserName = 'DBPipeline1'
    Left = 24
    Top = 200
    object ppDBPipeline1ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'RecID'
      FieldName = 'RecID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipeline1ppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'EntityCode'
      FieldName = 'EntityCode'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 1
    end
    object ppDBPipeline1ppField3: TppField
      FieldAlias = 'Sub'
      FieldName = 'Sub'
      FieldLength = 20
      DisplayWidth = 20
      Position = 2
    end
    object ppDBPipeline1ppField4: TppField
      FieldAlias = 'PurN'
      FieldName = 'PurN'
      FieldLength = 40
      DisplayWidth = 40
      Position = 3
    end
    object ppDBPipeline1ppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'Qty'
      FieldName = 'Qty'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipeline1ppField6: TppField
      FieldAlias = 'Unit'
      FieldName = 'Unit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPipeline1ppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'BaseUnits'
      FieldName = 'BaseUnits'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object ppDBPipeline1ppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'grp'
      FieldName = 'grp'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 7
    end
    object ppDBPipeline1ppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'recid2'
      FieldName = 'recid2'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 8
    end
    object ppDBPipeline1ppField10: TppField
      FieldAlias = 'Descr'
      FieldName = 'Descr'
      FieldLength = 20
      DisplayWidth = 20
      Position = 9
    end
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppReport1PreviewFormCreate
    Left = 24
    Top = 232
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 28310
      mmPrintPosition = 0
      object ppShape3: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 52388
        mmTop = 1852
        mmWidth = 104775
        BandType = 0
      end
      object pplTitle: TppLabel
        UserName = 'lTitle'
        AutoSize = False
        Caption = 'Internal Transfer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 53181
        mmTop = 2646
        mmWidth = 103188
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
        mmLeft = 157692
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
        mmLeft = 177800
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
        mmWidth = 33338
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
        mmWidth = 34396
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
        mmWidth = 36513
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
        mmLeft = 168275
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
        mmTop = 19050
        mmWidth = 200290
        BandType = 0
      end
      object pplMvDate: TppLabel
        UserName = 'lMvDate'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 93721
        mmTop = 10319
        mmWidth = 13377
        BandType = 0
      end
      object pplFromTo: TppLabel
        UserName = 'lFromTo'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 93663
        mmTop = 15081
        mmWidth = 13494
        BandType = 0
      end
      object pplMvBy: TppLabel
        UserName = 'lMvBy'
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 180711
        mmTop = 11642
        mmWidth = 13420
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 0
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine10: TppLine
        UserName = 'Line10'
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 0
        mmTop = 22490
        mmWidth = 194205
        BandType = 0
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 193940
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 26988
        mmWidth = 194205
        BandType = 0
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 9525
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine13: TppLine
        UserName = 'Line13'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 80698
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine14: TppLine
        UserName = 'Line14'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5556
        mmLeft = 109538
        mmTop = 22754
        mmWidth = 1852
        BandType = 0
      end
      object ppLine15: TppLine
        UserName = 'Line15'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 127529
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine17: TppLine
        UserName = 'Line17'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 173302
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'No.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4657
        mmLeft = 1852
        mmTop = 23283
        mmWidth = 6265
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Product Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4657
        mmLeft = 10848
        mmTop = 23283
        mmWidth = 26374
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = 'Transfer Unit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 81492
        mmTop = 23283
        mmWidth = 24342
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Quantity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 110331
        mmTop = 23283
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Caption = 'Sub-Category'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 128588
        mmTop = 23283
        mmWidth = 25400
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        AutoSize = False
        Caption = 'Received'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4657
        mmLeft = 173567
        mmTop = 23019
        mmWidth = 20373
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'Unit'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4487
        mmLeft = 81227
        mmTop = 794
        mmWidth = 28046
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        OnGetText = ppDBText5GetText
        DataField = 'Qty'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4487
        mmLeft = 110331
        mmTop = 794
        mmWidth = 16669
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'RecID'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4657
        mmLeft = 529
        mmTop = 794
        mmWidth = 7408
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 0
        mmTop = 0
        mmWidth = 529
        BandType = 4
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 9525
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 109538
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 127529
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 173302
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 193940
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 4498
        mmWidth = 194205
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'PurN'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4191
        mmLeft = 10583
        mmTop = 794
        mmWidth = 69586
        BandType = 4
      end
      object ppLine16: TppLine
        UserName = 'Line16'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 80698
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Sub'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4487
        mmLeft = 128588
        mmTop = 794
        mmWidth = 43656
        BandType = 4
      end
    end
    object ppSummaryBand1: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 27517
      mmPrintPosition = 0
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Received By -'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 529
        mmTop = 6085
        mmWidth = 23019
        BandType = 7
      end
      object ppLabel14: TppLabel
        UserName = 'Label12'
        Caption = 'Name: ________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 25135
        mmTop = 6085
        mmWidth = 89694
        BandType = 7
      end
      object ppLabel15: TppLabel
        UserName = 'Label14'
        Caption = 'Signature: _______________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 115888
        mmTop = 6085
        mmWidth = 78846
        BandType = 7
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        Caption = 'Date Received: _______________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 529
        mmTop = 15346
        mmWidth = 86519
        BandType = 7
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        Caption = 'Time Received: __________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 91281
        mmTop = 15346
        mmWidth = 77523
        BandType = 7
      end
      object ppLabel16: TppLabel
        UserName = 'Label15'
        Caption = 'Transfer Note:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsUnderline]
        Transparent = True
        mmHeight = 4022
        mmLeft = 529
        mmTop = 22754
        mmWidth = 22564
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
        mmHeight = 4498
        mmLeft = 24342
        mmTop = 22490
        mmWidth = 170127
        BandType = 7
        mmBottomOffset = 2540
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
  end
end
