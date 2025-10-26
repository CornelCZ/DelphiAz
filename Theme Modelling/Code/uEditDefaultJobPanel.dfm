object EditDefaultJobPanel: TEditDefaultJobPanel
  Left = 827
  Top = 298
  HelpContext = 5077
  BorderStyle = bsDialog
  Caption = 'Edit Default Role Panel'
  ClientHeight = 385
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grbxPanels: TGroupBox
    Left = 0
    Top = 0
    Width = 239
    Height = 345
    TabOrder = 0
    object lblPanel: TLabel
      Left = 5
      Top = 20
      Width = 30
      Height = 13
      Caption = 'Panel:'
    end
    object cbxPanelList: TComboBox
      Tag = 1
      Left = 41
      Top = 16
      Width = 192
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxPanelListChange
    end
    object dbgTimeCycleList: TwwDBGrid
      Left = 5
      Top = 42
      Width = 228
      Height = 255
      Selected.Strings = (
        'PanelName'#9'30'#9'Panel Name'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Color = clInactiveCaption
      DataSource = dtsDefaultJobPanels
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 1
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
    object btnRemove: TButton
      Left = 123
      Top = 305
      Width = 98
      Height = 25
      Caption = '&Remove'
      TabOrder = 2
      OnClick = btnRemoveClick
    end
    object btnAdd: TButton
      Left = 20
      Top = 305
      Width = 98
      Height = 25
      Caption = '&Add'
      TabOrder = 3
      OnClick = btnAddClick
    end
  end
  object grbxJobRoles: TGroupBox
    Left = 248
    Top = 0
    Width = 241
    Height = 345
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 125
      Height = 13
      Caption = 'Available Employee Roles:'
    end
    object clbJobs: TCheckListBox
      Left = 8
      Top = 40
      Width = 225
      Height = 257
      OnClickCheck = clbJobsClickCheck
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
    end
    object btnDeSelect: TButton
      Left = 123
      Top = 305
      Width = 98
      Height = 25
      Caption = '&Deselect All'
      TabOrder = 1
      OnClick = btnDeSelectClick
    end
    object btnSelectAll: TButton
      Left = 20
      Top = 305
      Width = 98
      Height = 25
      Caption = '&Select All'
      TabOrder = 2
      OnClick = btnSelectAllClick
    end
  end
  object btClose: TButton
    Left = 407
    Top = 358
    Width = 80
    Height = 25
    Caption = '&Close'
    ModalResult = 1
    TabOrder = 2
  end
  object qDefaultJobPanels: TADOQuery
    AutoCalcFields = False
    Connection = dmADO.AztecConn
    BeforeScroll = qDefaultJobPanelsBeforeScroll
    AfterScroll = qDefaultJobPanelsAfterScroll
    OnCalcFields = qDefaultJobPanelsCalcFields
    Parameters = <
      item
        Name = 'PanelDesignID'
        Size = -1
        Value = Null
      end
      item
        Name = 'ThemeID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT DefaultID, PanelDesignID, PanelID, ThemeID '
      '               FROM ThemeDefaultRolePanel '
      '  WHERE PanelDesignID = :PanelDesignID'
      '      AND ThemeID = :ThemeID')
    Left = 8
    Top = 352
    object qDefaultJobPanelsDefaultID: TIntegerField
      FieldName = 'DefaultID'
    end
    object qDefaultJobPanelsThemeID: TIntegerField
      FieldName = 'ThemeID'
    end
    object qDefaultJobPanelsPanelDesignID: TIntegerField
      FieldName = 'PanelDesignID'
    end
    object qDefaultJobPanelsPanelID: TLargeintField
      FieldName = 'PanelID'
    end
    object qDefaultJobPanelsPanelName: TStringField
      FieldKind = fkCalculated
      FieldName = 'PanelName'
      Size = 30
      Calculated = True
    end
  end
  object dtsDefaultJobPanels: TDataSource
    DataSet = qDefaultJobPanels
    Left = 48
    Top = 352
  end
end
