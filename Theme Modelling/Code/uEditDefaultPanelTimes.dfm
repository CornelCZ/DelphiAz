object EditDefaultPanelTimes: TEditDefaultPanelTimes
  Left = 322
  Top = 220
  Width = 532
  Height = 396
  Caption = 'Edit Default Panel Times'
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
  object grpbxPanelTimes: TGroupBox
    Left = 0
    Top = 57
    Width = 249
    Height = 242
    TabOrder = 0
    object dbgPanelList: TwwDBGrid
      Left = 8
      Top = 16
      Width = 232
      Height = 216
      ControlType.Strings = (
        'PanelDesignName;CustomEdit;wwDBLookupCombo1;F'
        'DefaultPanelName;CustomEdit;wwDBLookupCombo2;F')
      Selected.Strings = (
        'Name'#9'34'#9'Panel Name'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      OnRowChanged = dbgPanelListRowChanged
      FixedCols = 1
      ShowHorzScrollBar = True
      DataSource = dtsPanelTimeCycles
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
    end
  end
  object pn1Edit: TPanel
    Left = 0
    Top = 300
    Width = 451
    Height = 32
    BevelOuter = bvNone
    TabOrder = 1
    object btnAdd: TButton
      Left = 7
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 85
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Edit'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnRemove: TButton
      Left = 163
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 2
      OnClick = btnRemoveClick
    end
  end
  object pnlClose: TPanel
    Left = 0
    Top = 335
    Width = 523
    Height = 32
    BevelOuter = bvNone
    TabOrder = 2
    object btnClose: TButton
      Left = 443
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 524
    Height = 57
    Align = alTop
    TabOrder = 3
    object lblTerminalName: TLabel
      Left = 8
      Top = 23
      Width = 71
      Height = 13
      Caption = 'Terminal Name'
    end
    object lblDefaultPanel: TLabel
      Left = 264
      Top = 23
      Width = 64
      Height = 13
      Caption = 'Default Panel'
    end
    object edtDefaultPanel: TEdit
      Left = 343
      Top = 19
      Width = 158
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object cbTerminalNames: TComboBox
      Left = 88
      Top = 19
      Width = 153
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbTerminalNamesChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 256
    Top = 57
    Width = 267
    Height = 242
    TabOrder = 4
    object lblMon: TLabel
      Left = 24
      Top = 50
      Width = 38
      Height = 13
      Caption = 'Monday'
    end
    object Label4: TLabel
      Left = 93
      Top = 29
      Width = 44
      Height = 13
      Caption = 'Start time'
    end
    object Label2: TLabel
      Left = 182
      Top = 29
      Width = 41
      Height = 13
      Alignment = taCenter
      Caption = 'End time'
    end
    object lblTues: TLabel
      Left = 24
      Top = 74
      Width = 41
      Height = 13
      Caption = 'Tuesday'
    end
    object lblWed: TLabel
      Left = 24
      Top = 98
      Width = 57
      Height = 13
      Caption = 'Wednesday'
    end
    object lblThur: TLabel
      Left = 24
      Top = 122
      Width = 44
      Height = 13
      Caption = 'Thursday'
    end
    object lblFri: TLabel
      Left = 24
      Top = 146
      Width = 28
      Height = 13
      Caption = 'Friday'
    end
    object lblSat: TLabel
      Left = 24
      Top = 170
      Width = 42
      Height = 13
      Caption = 'Saturday'
    end
    object lblSun: TLabel
      Left = 24
      Top = 194
      Width = 36
      Height = 13
      Caption = 'Sunday'
    end
    object stMon: TLabel
      Tag = 1
      Left = 94
      Top = 50
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stTue: TLabel
      Tag = 2
      Left = 94
      Top = 74
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stWed: TLabel
      Tag = 3
      Left = 94
      Top = 98
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stThu: TLabel
      Tag = 4
      Left = 94
      Top = 122
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stFri: TLabel
      Tag = 5
      Left = 94
      Top = 146
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stSat: TLabel
      Tag = 6
      Left = 94
      Top = 170
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object stSun: TLabel
      Tag = 7
      Left = 94
      Top = 194
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etMon: TLabel
      Tag = 1
      Left = 182
      Top = 50
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etTue: TLabel
      Tag = 2
      Left = 182
      Top = 74
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etWed: TLabel
      Tag = 3
      Left = 182
      Top = 98
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etThu: TLabel
      Tag = 4
      Left = 182
      Top = 122
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etFri: TLabel
      Tag = 5
      Left = 182
      Top = 146
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etSat: TLabel
      Tag = 6
      Left = 182
      Top = 170
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
    object etSun: TLabel
      Tag = 7
      Left = 182
      Top = 194
      Width = 42
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00:00:00'
    end
  end
  object qPanelCycles: TADOQuery
    Connection = dmThemeData.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 336
    Top = 304
    object qPanelCyclesName: TStringField
      DisplayLabel = 'Panel Name'
      DisplayWidth = 26
      FieldName = 'Name'
      Size = 50
    end
    object qPanelCyclesDefaultID: TLargeintField
      FieldName = 'DefaultID'
    end
    object qPanelCyclesEposDeviceID: TIntegerField
      FieldName = 'EposDeviceID'
    end
    object qPanelCyclesPanelID: TIntegerField
      FieldName = 'PanelID'
    end
  end
  object dtsPanelTimeCycles: TDataSource
    Left = 368
    Top = 304
  end
  object qRun: TADOQuery
    Connection = dmThemeData.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 416
    Top = 304
  end
end
