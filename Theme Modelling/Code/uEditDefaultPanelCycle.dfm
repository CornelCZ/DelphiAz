object EditDefaultPanelCycle: TEditDefaultPanelCycle
  Left = 274
  Top = 297
  Width = 808
  Height = 339
  HelpContext = 5072
  Caption = 'Default Panel Cycles'
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
  object lblPanelDesign: TLabel
    Left = 5
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Panel Design: '
  end
  object btCancel: TButton
    Left = 718
    Top = 283
    Width = 80
    Height = 25
    Caption = '&Close'
    TabOrder = 3
    OnClick = btCancelClick
  end
  object gbxTimeCycles: TGroupBox
    Left = 0
    Top = 27
    Width = 223
    Height = 250
    Caption = 'Time Cycles'
    TabOrder = 1
    object btnAdd: TButton
      Left = 10
      Top = 217
      Width = 98
      Height = 25
      Caption = '&Add'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnRemove: TButton
      Left = 113
      Top = 217
      Width = 98
      Height = 25
      Caption = '&Remove'
      TabOrder = 2
      OnClick = btnRemoveClick
    end
    object dbgTimeCycleList: TwwDBGrid
      Left = 5
      Top = 18
      Width = 212
      Height = 193
      Selected.Strings = (
        'Name'#9'25'#9'Name'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dtsPanelCycles
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
  object gbxActiveTimes: TGroupBox
    Left = 228
    Top = 27
    Width = 571
    Height = 250
    Caption = 'Time Periods'
    TabOrder = 2
    object lblPanel: TLabel
      Left = 9
      Top = 20
      Width = 30
      Height = 13
      Caption = 'Panel:'
    end
    object btnNewTimePeriod: TButton
      Left = 215
      Top = 218
      Width = 98
      Height = 25
      Caption = '&New Time Period'
      TabOrder = 3
      OnClick = btnNewTimePeriodClick
    end
    object btnDeleteTimePeriod: TButton
      Left = 467
      Top = 218
      Width = 98
      Height = 25
      Caption = '&Delete Time Period'
      TabOrder = 4
      OnClick = btnDeleteTimePeriodClick
    end
    object pnlTimePeriodEdit: TPanel
      Left = 7
      Top = 42
      Width = 194
      Height = 201
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      object Label45: TLabel
        Left = 6
        Top = 3
        Width = 59
        Height = 13
        Caption = 'Days active:'
      end
      object lblStartTime: TLabel
        Left = 102
        Top = 24
        Width = 47
        Height = 13
        Caption = 'Start time:'
      end
      object lblEndTime: TLabel
        Left = 101
        Top = 80
        Width = 44
        Height = 13
        Caption = 'End time:'
      end
      object dtStartTime: TDateTimePicker
        Tag = 1
        Left = 100
        Top = 40
        Width = 70
        Height = 21
        CalAlignment = dtaLeft
        Date = 2
        Format = 'HH:mm'
        Time = 2
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkTime
        ParseInput = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnChange = dtStartTimeChange
      end
      object dtEndTime: TDateTimePicker
        Tag = 1
        Left = 100
        Top = 96
        Width = 70
        Height = 21
        CalAlignment = dtaLeft
        Date = 2.99930555555556
        Format = 'HH:mm'
        Time = 2.99930555555556
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkTime
        ParseInput = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = dtEndTimeChange
      end
      object clbValidDays: TCheckListBox
        Tag = 1
        Left = 5
        Top = 19
        Width = 78
        Height = 170
        OnClickCheck = clbValidDaysClickCheck
        BorderStyle = bsNone
        Color = clBtnFace
        Ctl3D = True
        Flat = False
        ItemHeight = 24
        Items.Strings = (
          'Monday'
          'Tuesday'
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday'
          'Sunday')
        ParentCtl3D = False
        Style = lbOwnerDrawFixed
        TabOrder = 0
      end
    end
    object dbgridValidTimes: TwwDBGrid
      Left = 214
      Top = 16
      Width = 353
      Height = 196
      Selected.Strings = (
        'PanelName'#9'25'#9'Panel Name'#9'T'
        'DayOfWeekDisplay'#9'15'#9'Days Active'#9'T'
        'StartTime'#9'5'#9' Start'#9'T'
        'EndTime'#9'5'#9' End'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dtsTimePeriods
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 2
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
    object cbxPanelList: TComboBox
      Tag = 1
      Left = 45
      Top = 16
      Width = 156
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxPanelListChange
    end
  end
  object cbxPanelDesign: TComboBox
    Left = 77
    Top = 4
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    TabStop = False
    OnSelect = cbxPanelDesignSelect
  end
  object qPanelCycles: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    BeforeScroll = qPanelCyclesBeforeScroll
    AfterScroll = qPanelCyclesAfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, Name'
      'FROM ThemeDefaultPanelCycles'
      'WHERE PanelDesignID = :PanelDesignID')
    Top = 280
  end
  object dtsPanelCycles: TDataSource
    DataSet = qPanelCycles
    Left = 32
    Top = 280
  end
  object qTimePeriods: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforeScroll = qTimePeriodsBeforeScroll
    AfterScroll = qTimePeriodsAfterScroll
    OnCalcFields = qTimePeriodsCalcFields
    Parameters = <
      item
        Name = 'CycleID'
        DataType = ftLargeint
        Size = -1
        Value = '0'
      end>
    SQL.Strings = (
      'SELECT ID, CycleID, PanelID, DayOfWeek, StartTime, EndTime'
      'FROM ThemeDefaultPanelCycleTimes'
      'WHERE CycleID = :CycleID')
    Left = 440
    Top = 280
    object qTimePeriodsID: TLargeintField
      FieldName = 'ID'
    end
    object qTimePeriodsCycleID: TLargeintField
      FieldName = 'CycleID'
    end
    object qTimePeriodsPanelID: TIntegerField
      FieldName = 'PanelID'
    end
    object qTimePeriodsDayOfWeek: TLargeintField
      FieldName = 'DayOfWeek'
    end
    object qTimePeriodsStartTime: TTimeField
      DisplayWidth = 5
      FieldName = 'StartTime'
      DisplayFormat = 'hh:mm'
    end
    object qTimePeriodsEndTime: TTimeField
      DisplayWidth = 5
      FieldName = 'EndTime'
      DisplayFormat = 'hh:mm'
    end
    object qTimePeriodsDayOfWeekDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'DayOfWeekDisplay'
      Calculated = True
    end
    object qTimePeriodsPanelName: TStringField
      FieldKind = fkCalculated
      FieldName = 'PanelName'
      Calculated = True
    end
  end
  object dtsTimePeriods: TDataSource
    DataSet = qTimePeriods
    Left = 472
    Top = 280
  end
end
