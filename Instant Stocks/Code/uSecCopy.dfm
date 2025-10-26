object fSecCopy: TfSecCopy
  Left = 309
  Top = 0
  Width = 724
  Height = 694
  HelpContext = 1042
  BorderIcons = [biSystemMenu]
  Caption = 'fSecCopy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tabsJobs: TTabControl
    Left = 0
    Top = 0
    Width = 708
    Height = 655
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
      Top = 215
      Width = 700
      Height = 23
      Align = alTop
      AutoSize = False
      Caption = ' Site settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlBottom
    end
    object tabsTids: TTabControl
      Left = 4
      Top = 238
      Width = 700
      Height = 368
      Align = alClient
      MultiLine = True
      TabOrder = 0
      Tabs.Strings = (
        'Food, Manager'
        'Food, Normal'
        'Merchandise, Test 1'
        'Wet, Manager'
        'Wet, Normal'
        'ALL THREADS')
      TabIndex = 0
      object Label14: TLabel
        Left = 4
        Top = 24
        Width = 692
        Height = 6
        Align = alTop
        AutoSize = False
        Color = clGray
        ParentColor = False
      end
      object Label10: TLabel
        Left = 4
        Top = 30
        Width = 692
        Height = 45
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Role: ADMINISTRATOR    '#13#10'Thread: Manager   Division: Food'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object pnlProgMap: TScrollBox
        Left = 4
        Top = 75
        Width = 692
        Height = 289
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
          Top = 451
          Width = 675
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
          Width = 675
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
          Top = 193
          Width = 675
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
          Top = 572
          Width = 675
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
          Top = 710
          Width = 675
          Height = 7
          Align = alTop
          AutoSize = False
        end
        object gridSgen: TwwDBGrid
          Left = 0
          Top = 17
          Width = 675
          Height = 176
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
          ReadOnly = True
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
          IndicatorIconColor = clYellow
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridScurr: TwwDBGrid
          Left = 0
          Top = 210
          Width = 675
          Height = 241
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
          ReadOnly = True
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
          IndicatorIconColor = clYellow
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridSacc: TwwDBGrid
          Left = 0
          Top = 468
          Width = 675
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
          ReadOnly = True
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
          IndicatorIconColor = clYellow
          PaintOptions.ActiveRecordColor = clBlue
        end
        object gridSrep: TwwDBGrid
          Left = 0
          Top = 589
          Width = 675
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
          ReadOnly = True
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
          IndicatorIconColor = clYellow
          PaintOptions.ActiveRecordColor = clBlue
        end
      end
    end
    object panelHO: TPanel
      Left = 4
      Top = 24
      Width = 700
      Height = 191
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 698
        Height = 24
        Align = alTop
        AutoSize = False
        Caption = ' Head Office settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
      end
      object gridHO: TwwDBGrid
        Left = 1
        Top = 25
        Width = 698
        Height = 165
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
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
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
        ReadOnly = True
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
        IndicatorIconColor = clYellow
        PaintOptions.ActiveRecordColor = clBlack
      end
    end
    object Panel1: TPanel
      Left = 4
      Top = 606
      Width = 700
      Height = 45
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        700
        45)
      object BitBtn1: TBitBtn
        Left = 211
        Top = 2
        Width = 326
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn1Click
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
      object BitBtn2: TBitBtn
        Left = 544
        Top = 2
        Width = 150
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'Cancel Copying '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Kind = bkCancel
      end
    end
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
        Value = 'ADMINISTRATOR'
      end>
    SQL.Strings = (
      'select * from stkSecView'
      'where jobtype = :jobtype'
      'and parent = 2')
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
    Left = 144
    Top = 216
  end
  object dsScurr: TwwDataSource
    DataSet = adoqScurr
    Left = 184
    Top = 216
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
      'and parent = 4')
    Left = 144
    Top = 328
  end
  object dsSacc: TwwDataSource
    DataSet = adoqSacc
    Left = 176
    Top = 328
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
      'and parent = 5')
    Left = 144
    Top = 400
  end
  object dsSrep: TwwDataSource
    DataSet = adoqSrep
    Left = 176
    Top = 400
  end
end
