object fSecurity: TfSecurity
  Left = 527
  Top = 0
  Width = 692
  Height = 694
  HelpContext = 1029
  BorderIcons = [biSystemMenu]
  Caption = 'fSecurity'
  Color = clBtnFace
  Constraints.MinHeight = 340
  Constraints.MinWidth = 545
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tabsJobs: TTabControl
    Left = 0
    Top = 0
    Width = 676
    Height = 614
    Align = alClient
    MultiLine = True
    TabOrder = 0
    Tabs.Strings = (
      'ADMINISTRATOR'
      'ASSTMAN'
      'MANAGER'
      'SITEMANAGER'
      'STOCKTAKER'
      'SUPERVISORTYPE'
      'TECHNICAL')
    TabIndex = 0
    OnChange = tabsJobsChange
    object Label7: TLabel
      Left = 4
      Top = 251
      Width = 668
      Height = 19
      Align = alTop
      AutoSize = False
      Caption = ' Site settings (Dbl-Click to hide)'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlBottom
      OnDblClick = Label7DblClick
    end
    object tabsTids: TTabControl
      Left = 4
      Top = 270
      Width = 668
      Height = 340
      Align = alClient
      MultiLine = True
      TabOrder = 0
      Tabs.Strings = (
        'Food, Manager'
        'Food, Normal'
        'Merchandise, Test 1'
        'Wet, Manager'
        'Wet, Normal'
        'ALL THREADS'
        'a;ksjfhak;jsdfh;kaj k;jh'
        'askdfhasjd hk h h;kjh'
        'aS;LKJDF AFAS;LKDJFA;LSKJDF'
        '123')
      TabIndex = 0
      OnChange = tabsTidsChange
      object Label14: TLabel
        Left = 4
        Top = 42
        Width = 660
        Height = 6
        Align = alTop
        AutoSize = False
        Color = clGray
        ParentColor = False
      end
      object Label10: TLabel
        Left = 4
        Top = 48
        Width = 660
        Height = 36
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Role: ADMINISTRATOR    '#13#10'Thread: Manager   Division: Food'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object pnlProgMap: TScrollBox
        Left = 4
        Top = 116
        Width = 660
        Height = 220
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvRaised
        BevelWidth = 0
        BorderStyle = bsNone
        Color = clGray
        ParentColor = False
        TabOrder = 0
        object Label2: TLabel
          Left = 0
          Top = 470
          Width = 643
          Height = 17
          Align = alTop
          AutoSize = False
          Caption = ' Site - Accepted'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
        end
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 643
          Height = 17
          Align = alTop
          AutoSize = False
          Caption = ' Site - General'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
        end
        object Label4: TLabel
          Left = 0
          Top = 209
          Width = 643
          Height = 17
          Align = alTop
          AutoSize = False
          Caption = ' Site - Current'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
        end
        object Label5: TLabel
          Left = 0
          Top = 591
          Width = 643
          Height = 17
          Align = alTop
          AutoSize = False
          Caption = ' Site - Pick Reports'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
        end
        object Label6: TLabel
          Left = 0
          Top = 729
          Width = 643
          Height = 7
          Align = alTop
          AutoSize = False
        end
        object gridSgen: TwwDBGrid
          Left = 0
          Top = 17
          Width = 643
          Height = 192
          ControlType.Strings = (
            'set5;CheckBox;Y;N'
            'set1;CheckBox;Y;N'
            'set2;CheckBox;Y;N'
            'set3;CheckBox;Y;N'
            'set4;CheckBox;Y;N'
            '3;CheckBox;Y;N')
          Selected.Strings = (
            'smalltext'#9'35'#9'smalltext'#9#9
            '1'#9'1'#9'1'#9#9
            '3'#9'1'#9'3'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clBlack
          FixedCols = 1
          ShowHorzScrollBar = True
          ShowVertScrollBar = False
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alTop
          Color = clWhite
          DataSource = dsSgen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clYellow
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          UseTFields = False
          OnExit = gridHOExit
          IndicatorIconColor = clYellow
          OnFieldChanged = gridFieldChanged
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridScurr: TwwDBGrid
          Left = 0
          Top = 226
          Width = 643
          Height = 244
          ControlType.Strings = (
            'set5;CheckBox;Y;N'
            'set1;CheckBox;Y;N'
            'set2;CheckBox;Y;N'
            'set3;CheckBox;Y;N'
            'set4;CheckBox;Y;N')
          Selected.Strings = (
            'smalltext'#9'35'#9'smalltext'#9#9
            '0'#9'1'#9'0'#9'F'
            '1'#9'1'#9'1'#9'F'
            '2'#9'1'#9'2'#9'F'
            '3'#9'1'#9'3'#9'F'
            '4'#9'1'#9'4'#9'F'
            '5'#9'1'#9'5'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBlack
          FixedCols = 1
          ShowHorzScrollBar = True
          ShowVertScrollBar = False
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alTop
          Color = clWhite
          DataSource = dsScurr
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clYellow
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          UseTFields = False
          OnExit = gridHOExit
          IndicatorIconColor = clYellow
          OnFieldChanged = gridFieldChanged
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridSacc: TwwDBGrid
          Left = 0
          Top = 487
          Width = 643
          Height = 104
          LineStyle = glsSingle
          ControlType.Strings = (
            'set5;CheckBox;Y;N'
            'set1;CheckBox;Y;N'
            'set2;CheckBox;Y;N'
            'set3;CheckBox;Y;N'
            'set4;CheckBox;Y;N'
            '1;CheckBox;Y;N')
          Selected.Strings = (
            'smalltext'#9'35'#9'smalltext'#9#9
            '1'#9'1'#9'Granted'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBlack
          FixedCols = 1
          ShowHorzScrollBar = True
          ShowVertScrollBar = False
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alTop
          Color = clWhite
          DataSource = dsSacc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clYellow
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          UseTFields = False
          OnExit = gridHOExit
          IndicatorIconColor = clYellow
          OnFieldChanged = gridFieldChanged
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridSrep: TwwDBGrid
          Left = 0
          Top = 608
          Width = 643
          Height = 121
          ControlType.Strings = (
            'set5;CheckBox;Y;N'
            'set1;CheckBox;Y;N'
            'set2;CheckBox;Y;N'
            'set3;CheckBox;Y;N'
            'set4;CheckBox;Y;N')
          Selected.Strings = (
            'smalltext'#9'35'#9'smalltext'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clBlack
          FixedCols = 1
          ShowHorzScrollBar = True
          ShowVertScrollBar = False
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alTop
          Color = clWhite
          DataSource = dsSrep
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
          ParentFont = False
          TabOrder = 3
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clYellow
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          UseTFields = False
          OnExit = gridHOExit
          IndicatorIconColor = clYellow
          OnFieldChanged = gridFieldChanged
          PaintOptions.ActiveRecordColor = clBlue
        end
      end
      object Panel3: TPanel
        Left = 4
        Top = 84
        Width = 660
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object BitBtn7: TBitBtn
          Left = 1
          Top = 2
          Width = 78
          Height = 28
          Caption = 'Set All'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = BitBtn7Click
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
        object BitBtn8: TBitBtn
          Left = 84
          Top = 2
          Width = 78
          Height = 28
          Caption = 'Reset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = BitBtn8Click
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
        object BitBtn9: TBitBtn
          Left = 174
          Top = 2
          Width = 189
          Height = 28
          Caption = 'Set All Roles like THIS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = BitBtn9Click
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            04000000000008010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
            AAAAA000AAAAAAAAAAAAAAAAAAA00AAAAAAAAAAAAAAAAAAAAA0AA99999AAAAAA
            AAAAAAAAAA0AA9FFFFAAAAAAAAAAAAAAAA0AA9FFFFAAAAAAAAACAAAAAA0AA9FF
            FFAAAAAAAAACCAAAAA0AA99999AAAACCCCCCCCAAA0AAAAAAAAAAACCCCCCCCCCA
            0AAAA99999AACCCCCCCCCCAAA0AAA9FFFFAACCCCAAACCAAAAA0AA9FFFFAACCCA
            AAACAAAAAA0AA9FFFFAACCCAAAAAAAAAAA0AA99999AACCCAAAAAAAAAAA0AAAAA
            AAAACCCAAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAA0AA99999AA00000000AAAA
            AA0AA9FFFFAAFFFFFFF0AAAAAA0AA9FFFFAA0F0FF0F0AAAAAA0AA9FFFFAA0F0F
            00F0AAAAAA0AA99999AAFFFFFFF0AAAAAAA00AAAAAAA00000000AAAAAAAAA000
            AAAA}
        end
        object BitBtn10: TBitBtn
          Left = 367
          Top = 2
          Width = 150
          Height = 28
          Caption = 'Copy From Role'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = BitBtn10Click
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            04000000000008010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A0FF0F0AAAAA
            AAAAAAAAAAAAF00F0F0AAAAAAAAAAAAAAAAAFFFFFF0AAAAAAAAAAAAAAAAA0000
            000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA99999999ACCCCCCCCCAA
            AAAAFFFFFFF9ACCCCCCCCCCAAAAA9F9F99F9ACCCCCCCCCCCAAAA9F9F99F9AAAA
            AAAACCCCAAAAFFFFFFF9AAAAAAAAACCCAAAA99999999AAAAAAACCCCCCCAAAAAA
            AAAAAAAAAAAACCCCCAAA0000000AAAAAAAAAACCCAAAAFFFFFF0AAAAAAAAAAACA
            AAAA00F0FF0AAAAAAAAAAAAAAAAA0FF00F0AAAAAAA00000000AAFFFFFF0AAAAA
            AA0FFFFFFFAA0000000AAAAAAA0FFFFFFFAAAAAAAAAAAAAAAA0FFFFFFFAA0000
            000AAAAAAA0FFFFFFFAAFFFFFF0AAAAAAA0FFFFFFFAAF0FF0F0AAAAAAA000000
            00AA}
        end
        object BitBtn11: TBitBtn
          Left = 523
          Top = 2
          Width = 138
          Height = 28
          Caption = 'Copy From Thread'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Visible = False
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            04000000000008010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A0FF0F0AAAAA
            AAAAAAAAAAAAF00F0F0AAAAAAAAAAAAAAAAAFFFFFF0AAAAAAAAAAAAAAAAA0000
            000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA99999999ACCCCCCCCCAA
            AAAAFFFFFFF9ACCCCCCCCCCAAAAA9F9F99F9ACCCCCCCCCCCAAAA9F9F99F9AAAA
            AAAACCCCAAAAFFFFFFF9AAAAAAAAACCCAAAA99999999AAAAAAACCCCCCCAAAAAA
            AAAAAAAAAAAACCCCCAAA0000000AAAAAAAAAACCCAAAAFFFFFF0AAAAAAAAAAACA
            AAAA00F0FF0AAAAAAAAAAAAAAAAA0FF00F0AAAAAAA00000000AAFFFFFF0AAAAA
            AA0FFFFFFFAA0000000AAAAAAA0FFFFFFFAAAAAAAAAAAAAAAA0FFFFFFFAA0000
            000AAAAAAA0FFFFFFFAAFFFFFF0AAAAAAA0FFFFFFFAAF0FF0F0AAAAAAA000000
            00AA}
        end
      end
    end
    object panelHO: TPanel
      Left = 4
      Top = 24
      Width = 668
      Height = 227
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 666
        Height = 16
        Align = alClient
        AutoSize = False
        Caption = ' HO settings (Dbl-Click to hide)'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        OnDblClick = Label1DblClick
      end
      object gridHO: TwwDBGrid
        Left = 1
        Top = 48
        Width = 666
        Height = 178
        ControlType.Strings = (
          'set5;CheckBox;Y;N'
          'set1;CheckBox;Y;N'
          'set2;CheckBox;Y;N'
          'set3;CheckBox;Y;N'
          'set4;CheckBox;Y;N')
        Selected.Strings = (
          'smalltext'#9'35'#9'smalltext'#9#9
          '0'#9'1'#9'0'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBlue
        FixedCols = 1
        ShowHorzScrollBar = True
        ShowVertScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alBottom
        Color = clAqua
        DataSource = dsHO
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyOptions = []
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clYellow
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnExit = gridHOExit
        IndicatorIconColor = clYellow
        PaintOptions.ActiveRecordColor = clBlack
      end
      object Panel4: TPanel
        Left = 1
        Top = 17
        Width = 666
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object BitBtn3: TBitBtn
          Left = 3
          Top = 2
          Width = 78
          Height = 28
          Caption = 'Set All'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = BitBtn3Click
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
        object BitBtn4: TBitBtn
          Left = 86
          Top = 2
          Width = 78
          Height = 28
          Caption = 'Reset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = BitBtn4Click
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
        object BitBtn5: TBitBtn
          Left = 175
          Top = 2
          Width = 188
          Height = 28
          Caption = 'Set All Roles like THIS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = BitBtn5Click
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            04000000000008010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
            AAAAA000AAAAAAAAAAAAAAAAAAA00AAAAAAAAAAAAAAAAAAAAA0AA99999AAAAAA
            AAAAAAAAAA0AA9FFFFAAAAAAAAAAAAAAAA0AA9FFFFAAAAAAAAACAAAAAA0AA9FF
            FFAAAAAAAAACCAAAAA0AA99999AAAACCCCCCCCAAA0AAAAAAAAAAACCCCCCCCCCA
            0AAAA99999AACCCCCCCCCCAAA0AAA9FFFFAACCCCAAACCAAAAA0AA9FFFFAACCCA
            AAACAAAAAA0AA9FFFFAACCCAAAAAAAAAAA0AA99999AACCCAAAAAAAAAAA0AAAAA
            AAAACCCAAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAA0AA99999AA00000000AAAA
            AA0AA9FFFFAAFFFFFFF0AAAAAA0AA9FFFFAA0F0FF0F0AAAAAA0AA9FFFFAA0F0F
            00F0AAAAAA0AA99999AAFFFFFFF0AAAAAAA00AAAAAAA00000000AAAAAAAAA000
            AAAA}
        end
        object BitBtn6: TBitBtn
          Left = 367
          Top = 2
          Width = 147
          Height = 28
          Caption = 'Copy From Role'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = BitBtn6Click
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            04000000000008010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A0FF0F0AAAAA
            AAAAAAAAAAAAF00F0F0AAAAAAAAAAAAAAAAAFFFFFF0AAAAAAAAAAAAAAAAA0000
            000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA99999999ACCCCCCCCCAA
            AAAAFFFFFFF9ACCCCCCCCCCAAAAA9F9F99F9ACCCCCCCCCCCAAAA9F9F99F9AAAA
            AAAACCCCAAAAFFFFFFF9AAAAAAAAACCCAAAA99999999AAAAAAACCCCCCCAAAAAA
            AAAAAAAAAAAACCCCCAAA0000000AAAAAAAAAACCCAAAAFFFFFF0AAAAAAAAAAACA
            AAAA00F0FF0AAAAAAAAAAAAAAAAA0FF00F0AAAAAAA00000000AAFFFFFF0AAAAA
            AA0FFFFFFFAA0000000AAAAAAA0FFFFFFFAAAAAAAAAAAAAAAA0FFFFFFFAA0000
            000AAAAAAA0FFFFFFFAAFFFFFF0AAAAAAA0FFFFFFFAAF0FF0F0AAAAAAA000000
            00AA}
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 614
    Width = 676
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      676
      41)
    object BitBtn1: TBitBtn
      Left = 313
      Top = 3
      Width = 174
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Save Changes && Exit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        8A010000424D8A01000000000000760000002800000018000000170000000100
        0400000000001401000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
        AAAAAAAAAAAAACCCCCCCCCCCCCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFF
        CCCCFFFFCCFFCCCFFCCCACFFCCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCF
        FCCCACFFCCCCFFFFCCFFCCCFFCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCC
        CCCCCCCCCCCCAAAAAAAAAAAAAAAAAAAAAAAAAAA70000000000000AAAAAAAAAA0
        33000000FF030AAAAAAAAAA033000000FF030AAAAAAAAAA033000000FF030AAA
        AAAAAAA03300000000030AAAAAAAAAA03333333333330AAAAAAAAAA033000000
        00330AAAAAAAAAA030FAAAAAAA030AAAAAAAAAA030AFAAAAAA030AAAAAAAAAA0
        30AAAAAAAA030AAAAAAAAAA030AAAAAAAA000AAAAAAAAAA030AAAAAAAA0F0AAA
        AAAAAAA00000000000000AAAAAAA}
    end
    object BitBtn2: TBitBtn
      Left = 495
      Top = 3
      Width = 176
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Discard Changes && Exit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      Glyph.Data = {
        8A010000424D8A01000000000000760000002800000018000000170000000100
        0400000000001401000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
        CCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFFCCCCFFFFCCFFCCCFFCCCACFF
        CCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCFFCCCACFFCCCCFFFFCCFFCCCF
        FCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCCCCCCCCCCCCCCAAAAAAAAAAAA
        AAAAAAAAAAAAA7000000AAAAAAAAAAAAAAAAA0330000AA00000000AAAAAAA033
        0000AA000FF030AAAAAAA03300000AA00FF030AAAAAAA033000000AA0FF030AA
        AAAAA033333330AA000030AAAAAAA033000000AA033330AAAAAAA030FAAAA0AA
        000330AAAAAAA030AFAA0AAA0AA030AAAAAAA030AAA0AAA0AAA030AAAAAAA030
        AA0AAA0AAAA030AAAAAAA030A0AAA0AAAAA000AAAAAAA00000AA0AAAAAA0F0AA
        AAAAAAAAAAAA0000000000AAAAAA}
    end
  end
  object adoqHO: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsJobTypes
    Parameters = <
      item
        Name = 'jobtype'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'ZONAL'
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 1')
    Left = 136
    Top = 80
  end
  object dsHO: TwwDataSource
    DataSet = adoqHO
    Left = 168
    Top = 80
  end
  object adoqSgen: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsJobTypes
    Parameters = <
      item
        Name = 'jobtype'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 2'
      'order by permid')
    Left = 136
    Top = 144
  end
  object dsSgen: TwwDataSource
    DataSet = adoqSgen
    Left = 168
    Top = 144
  end
  object adoqScurr: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsJobTypes
    Parameters = <
      item
        Name = 'jobtype'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'ADMINISTRATOR'
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 3')
    Left = 272
    Top = 136
  end
  object dsScurr: TwwDataSource
    DataSet = adoqScurr
    Left = 216
    Top = 144
  end
  object adoqSacc: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsJobTypes
    Parameters = <
      item
        Name = 'jobtype'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'ADMINISTRATOR'
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 4'
      'order by permid')
    Left = 144
    Top = 312
  end
  object dsSacc: TwwDataSource
    DataSet = adoqSacc
    Left = 176
    Top = 320
  end
  object adoqSrep: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsJobTypes
    Parameters = <
      item
        Name = 'jobtype'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'ADMINISTRATOR'
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 5'
      'order by permid')
    Left = 144
    Top = 400
  end
  object dsSrep: TwwDataSource
    DataSet = adoqSrep
    Left = 176
    Top = 400
  end
  object adoqJobTypes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from stkpzjob')
    Left = 56
    Top = 80
  end
  object dsJobTypes: TwwDataSource
    DataSet = adoqJobTypes
    Left = 88
    Top = 80
  end
  object adoqRep: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from stkSecView'
      'order by jobtype, parent, permid')
    Left = 104
    Top = 656
  end
  object wwDataSource1: TwwDataSource
    DataSet = adoqRep
    Left = 136
    Top = 656
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = wwDataSource1
    UserName = 'DBPipeline1'
    Left = 168
    Top = 656
  end
  object ppRep: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter (8.5 x 11 in)'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    Left = 200
    Top = 656
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'smalltext'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3260
        mmLeft = 1323
        mmTop = 529
        mmWidth = 41010
        BandType = 4
      end
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'jobtype'
      DataPipeline = ppDBPipeline1
      KeepTogether = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline1'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 6085
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'jobtype'
          DataPipeline = ppDBPipeline1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3969
          mmLeft = 2381
          mmTop = 529
          mmWidth = 46567
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 2381
        mmPrintPosition = 0
      end
    end
    object ppGroup2: TppGroup
      BreakName = 'parent'
      DataPipeline = ppDBPipeline1
      KeepTogether = True
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline1'
      object ppGroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 8731
        mmPrintPosition = 0
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          DataField = 'parent'
          DataPipeline = ppDBPipeline1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3969
          mmLeft = 2646
          mmTop = 529
          mmWidth = 6615
          BandType = 3
          GroupNo = 1
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          Caption = 'THREAD NAME MIOPDWIJW'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3260
          mmLeft = 50800
          mmTop = 4233
          mmWidth = 38100
          BandType = 3
          GroupNo = 1
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 2381
        mmPrintPosition = 0
      end
    end
  end
end
