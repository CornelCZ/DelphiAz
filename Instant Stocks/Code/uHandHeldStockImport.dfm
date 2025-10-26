object frmHandHeldStockCountImport: TfrmHandHeldStockCountImport
  Left = 367
  Top = 161
  BorderStyle = bsDialog
  Caption = 'Hand Held Stock Counts'
  ClientHeight = 396
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblHandHeldStockHeader: TLabel
    Left = 16
    Top = 16
    Width = 295
    Height = 13
    Caption = 'The following Hand Held Stock counts are available for import.'
  end
  object lblHint: TLabel
    Left = 16
    Top = 269
    Width = 258
    Height = 13
    Caption = '(Ctrl + left mouse button click to select multiple records)'
  end
  object rgImportMethods: TRadioGroup
    Left = 16
    Top = 293
    Width = 185
    Height = 89
    Caption = 'Import Method'
    ItemIndex = 0
    Items.Strings = (
      'Overwrite Existing Counts'
      'Add To Existing Counts'
      'Fill Un-audited Products Only')
    TabOrder = 0
  end
  object btnImport: TButton
    Left = 367
    Top = 357
    Width = 75
    Height = 25
    Caption = 'Import'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnImportClick
  end
  object btnCancel: TButton
    Left = 454
    Top = 357
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object wwDBGridHandHeldSessions: TwwDBGrid
    Left = 16
    Top = 32
    Width = 513
    Height = 229
    ControlType.Strings = (
      'Selected;CheckBox;True;False')
    Selected.Strings = (
      'Thread Name'#9'20'#9'Thread Name'#9#9
      'Holding Zone'#9'21'#9'Holding Zone'#9'F'#9
      'Start Time'#9'18'#9'Start Time'#9#9
      'End Time'#9'18'#9'End Time'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsHandHeldImports
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object dsHandHeldImports: TDataSource
    DataSet = ADOqHandHeldSessions
    Left = 408
    Top = 48
  end
  object ADOqHandHeldSessions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '--Place holder for design time column settings'
      'SELECT S.SessionID, S.HoldingZone, T.TName AS [Thread Name], '
      '  H.hzName AS [Holding Zone], S.StartTime AS [Start Time], '
      '  S.EndTime AS [End Time]'
      'FROM StockHandHeldSessions S'
      ' JOIN Threads T on S.StockThread = T.Tid'
      ' LEFT OUTER JOIN stkHZs H on S.HoldingZone = H.hzName'
      ''
      '')
    Left = 440
    Top = 48
    object ADOqHandHeldSessionsThreadName: TStringField
      DisplayWidth = 20
      FieldName = 'Thread Name'
      Size = 30
    end
    object ADOqHandHeldSessionsHoldingZone: TStringField
      DisplayWidth = 21
      FieldName = 'Holding Zone'
      Size = 30
    end
    object ADOqHandHeldSessionsStartTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'Start Time'
    end
    object ADOqHandHeldSessionsEndTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'End Time'
    end
    object ADOqHandHeldSessionsHoldingZone2: TIntegerField
      FieldName = 'HoldingZone'
      Visible = False
    end
    object ADOqHandHeldSessionsSessionID: TLargeintField
      DisplayWidth = 15
      FieldName = 'SessionID'
      Visible = False
    end
  end
  object ADOqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 440
    Top = 88
  end
end
