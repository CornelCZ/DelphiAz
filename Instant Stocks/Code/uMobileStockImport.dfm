object frmMobileStockCountImport: TfrmMobileStockCountImport
  Left = 296
  Top = 161
  BorderStyle = bsDialog
  Caption = 'Mobile Stock Counts'
  ClientHeight = 396
  ClientWidth = 778
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
  object lblMobileStockHeader: TLabel
    Left = 8
    Top = 30
    Width = 275
    Height = 13
    Caption = 'The following Mobile Stock counts are available for import.'
  end
  object lblHint: TLabel
    Left = 8
    Top = 284
    Width = 258
    Height = 13
    Caption = '(Ctrl + left mouse button click to select multiple records)'
  end
  object lblDivision: TLabel
    Left = 61
    Top = 5
    Width = 141
    Height = 16
    AutoSize = False
    Caption = 'Division Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 9
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Division:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 233
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Thread:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblThread: TLabel
    Left = 280
    Top = 5
    Width = 141
    Height = 16
    AutoSize = False
    Caption = 'Division Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblByLoc: TLabel
    Left = 448
    Top = 5
    Width = 218
    Height = 16
    AutoSize = False
    Caption = 'Inventory Count is By Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object rgImportMethods: TRadioGroup
    Left = 8
    Top = 305
    Width = 185
    Height = 84
    Caption = ' Import Method '
    ItemIndex = 0
    Items.Strings = (
      'Overwrite Existing Counts'
      'Add To Existing Counts'
      'Fill Un-audited Products Only')
    TabOrder = 0
  end
  object btnImport: TButton
    Left = 560
    Top = 352
    Width = 97
    Height = 37
    Caption = 'Import'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnImportClick
  end
  object btnCancel: TButton
    Left = 672
    Top = 352
    Width = 97
    Height = 37
    Caption = 'Done'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object wwDBGridMobileStockSessions: TwwDBGrid
    Left = 8
    Top = 46
    Width = 761
    Height = 237
    Selected.Strings = (
      'SessionID'#9'13'#9'Session'
      'LocationId'#9'10'#9'LocationId'
      'Location Name'#9'25'#9'Location Name'
      'Start Time'#9'18'#9'Start Time'
      'End Time'#9'18'#9'End Time')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsMobileStockImports
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
    OnCalcCellColors = wwDBGridMobileStockSessionsCalcCellColors
  end
  object dsMobileStockImports: TDataSource
    DataSet = ADOqMobileStockSessions
    Left = 408
    Top = 48
  end
  object ADOqMobileStockSessions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '--Place holder for design time column settings'
      'SELECT sl.SessionID, sl.LocationId, t.TName AS [Thread Name], '
      
        #9'CASE WHEN sl.LocationId = 999 THEN '#39'No Location'#39' ELSE loc.Locat' +
        'ionName END AS [Location Name], '
      #9'sl.StartTime AS [Start Time], sl.EndTime AS [End Time]'
      'FROM '
      #9'(SELECT DISTINCT ms.*, msc.LocationId'
      #9' FROM ac_MobileStockSession ms'
      
        #9' JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.Ses' +
        'sionId) sl'
      ' JOIN Threads t ON sl.StockThread = t.Tid'
      
        ' LEFT OUTER JOIN stkLocations loc ON sl.LocationId = loc.Locatio' +
        'nID'
      ''
      '')
    Left = 440
    Top = 48
  end
  object ADOqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 440
    Top = 88
  end
  object qryMobileStockCountInLocation: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'Tid'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'StockEndDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'StockRollEndDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'StockEndDate2'
        Size = -1
        Value = Null
      end
      item
        Name = 'StockRollEndDate2'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT SiteId, SessionId, LocationId, RowId, ProductId, UnitName'
      
        'FROM (SELECT DISTINCT ms.*, msc.LocationId, msc.RowId, msc.Produ' +
        'ctId, msc.UnitName'
      '     FROM ac_MobileStockSession ms'
      
        '     JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.' +
        'SessionId where msc.LocationID <> 999) sl'
      'WHERE sl.StockThread = :Tid'
      'AND sl.StartTime > :StockEndDate'
      'AND sl.StartTime <= :StockRollEndDate'
      'AND sl.EndTime > :StockEndDate2'
      'AND sl.EndTime <= :StockRollEndDate2')
    Left = 488
    Top = 48
  end
end
