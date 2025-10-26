object fPickRep: TfPickRep
  Left = 34
  Top = 174
  Width = 737
  Height = 573
  HelpContext = 1006
  Caption = 'Stock Reports'
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
  object Bevel2: TBevel
    Left = 605
    Top = 453
    Width = 116
    Height = 38
  end
  object Bevel1: TBevel
    Left = 3
    Top = 415
    Width = 223
    Height = 114
  end
  object Label1: TLabel
    Left = 6
    Top = 0
    Width = 111
    Height = 13
    Caption = '1. Choose Division:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 6
    Top = 164
    Width = 106
    Height = 13
    Caption = '2. Choose Thread:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 9
    Top = 459
    Width = 213
    Height = 62
    AutoSize = False
    Caption = 
      '- Pick 1 stock from the grid --------->>'#13#10'  to view/print Single' +
      ' Stock Reports'#13#10'- Pick 2 or more stocks '#13#10'  to view/print Multi-' +
      'Stock Reports'
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
  object Label3: TLabel
    Left = 231
    Top = 0
    Width = 102
    Height = 13
    Caption = 'Accepted Stocks:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 231
    Top = 495
    Width = 226
    Height = 33
    AutoSize = False
    Caption = 
      'Grid: Use Ctrl+Click for multi select'#13#10'        Use Shift+Click f' +
      'or range select'
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
  object Label7: TLabel
    Left = 607
    Top = 455
    Width = 111
    Height = 34
    AutoSize = False
    Color = clBlack
    ParentColor = False
  end
  object Label6: TLabel
    Left = 610
    Top = 458
    Width = 105
    Height = 28
    Alignment = taCenter
    AutoSize = False
    Caption = 'Start of New Cumulative Period'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object Bevel3: TBevel
    Left = 231
    Top = 453
    Width = 99
    Height = 38
  end
  object Label8: TLabel
    Left = 233
    Top = 455
    Width = 94
    Height = 34
    AutoSize = False
    Color = clBlack
    ParentColor = False
  end
  object Label5: TLabel
    Left = 236
    Top = 458
    Width = 88
    Height = 28
    Alignment = taCenter
    AutoSize = False
    Caption = 'Normal'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object wwDBGrid1: TwwDBGrid
    Left = 6
    Top = 15
    Width = 160
    Height = 140
    Selected.Strings = (
      'Division'#9'20'#9'Division')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsDivs
    KeyOptions = [dgEnterToTab]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
  end
  object wwDBGrid2: TwwDBGrid
    Left = 6
    Top = 179
    Width = 217
    Height = 184
    Selected.Strings = (
      'TName'#9'30'#9'Thread Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsThreads
    KeyOptions = [dgEnterToTab]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid2CalcCellColors
  end
  object wwDBGrid3: TwwDBGrid
    Left = 231
    Top = 15
    Width = 489
    Height = 477
    Selected.Strings = (
      'SDate'#9'12'#9'Start Date'#9#9
      'STime'#9'6'#9'Time'#9#9
      'EDate'#9'12'#9'End Date'#9#9
      'ETime'#9'6'#9'Time'#9#9
      'AccDate'#9'12'#9'Acc. Date'#9#9
      'AccTime'#9'6'#9'Time'#9#9
      'StkKind'#9'18'#9'Kind'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
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
    UseTFields = False
    OnCalcCellColors = wwDBGrid3CalcCellColors
    OnCalcTitleAttributes = wwDBGrid3CalcTitleAttributes
    OnTitleButtonClick = wwDBGrid3TitleButtonClick
  end
  object BitBtn1: TBitBtn
    Left = 586
    Top = 495
    Width = 134
    Height = 33
    Caption = 'Done'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 9
    Top = 421
    Width = 213
    Height = 34
    Cancel = True
    Caption = 'Accepted Inventory Reports...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn2Click
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 9
    Top = 371
    Width = 213
    Height = 34
    Cancel = True
    Caption = 'Current Stock Reports...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn3Click
    NumGlyphs = 2
  end
  object btnCPS: TBitBtn
    Left = 334
    Top = 455
    Width = 267
    Height = 33
    Caption = 'Reset from Start of New Cumulative Period ->'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnCPSClick
  end
  object adoqDivs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqDivsAfterScroll
    AfterScroll = adoqDivsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select [Division Name] as Division from Division'
      'order by [Division Name]')
    Left = 88
    Top = 4
  end
  object dsDivs: TwwDataSource
    DataSet = adoqDivs
    Left = 112
    Top = 4
  end
  object adoqThreads: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqThreadsAfterScroll
    AfterScroll = adoqThreadsAfterScroll
    DataSource = dsDivs
    Parameters = <
      item
        Name = 'division'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'Wet'
      end>
    SQL.Strings = (
      'select * from Threads'
      'where [division] = :division'
      'and tid in (select tid from stksectids where permid = 21)'
      'order by TName')
    Left = 88
    Top = 60
  end
  object dsThreads: TwwDataSource
    DataSet = adoqThreads
    Left = 120
    Top = 60
  end
  object adoqThStock: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqThStockAfterScroll
    AfterScroll = adoqThStockAfterScroll
    DataSource = dsThreads
    Parameters = <
      item
        Name = 'tid'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 1
      end>
    SQL.Strings = (
      
        'select [Tid], [StockCode], [SDate], [STime], [EDate], [ETime], [' +
        'edt], [sdt],'
      
        '[AccDate], [AccTime], [StkKind], [division], [type], [byHZ], pur' +
        'eaz, ByLocation from Stocks'
      'where Tid = :tid and stockcode >= 2 and PureAZ = 1'
      'order by [edt] DESC'
      ''
      ''
      #9
      '')
    Left = 176
    Top = 4
  end
  object dsThStocks: TwwDataSource
    DataSet = adoqThStock
    Left = 200
    Top = 4
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = ADOQuery1AfterScroll
    AfterScroll = ADOQuery1AfterScroll
    DataSource = dsThreads
    Parameters = <
      item
        Name = 'tid'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 1
      end>
    SQL.Strings = (
      
        'select [Tid], [StockCode], [SDate], [STime], [EDate], [ETime], e' +
        'dt, sdt,'
      '[AccDate], [AccTime], [StkKind], [division], [type], [byHZ] '
      'from curStock'
      'where Tid = :tid'
      'and curstage = 4'
      'and rtrcp is not NULL'
      #9
      '')
    Left = 176
    Top = 44
  end
end
