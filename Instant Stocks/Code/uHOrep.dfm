object fHOrep: TfHOrep
  Left = 28
  Top = 142
  Width = 802
  Height = 570
  HelpContext = 1018
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Head Office Stock Reports'
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
  object Bevel1: TBevel
    Left = 1
    Top = 4
    Width = 275
    Height = 529
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 281
    Top = 2
    Width = 107
    Height = 13
    Caption = '3. Choose Division'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 281
    Top = 170
    Width = 139
    Height = 13
    Caption = '4. Choose Stock Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 284
    Top = 461
    Width = 213
    Height = 62
    AutoSize = False
    Caption = 
      '- Pick 1 Inventory from the grid ---->>'#13#10'  to view/print Single ' +
      'Stock Reports'#13#10'- Pick 2 or more stocks '#13#10'  to view/print Multi-S' +
      'tock Reports'
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
    Left = 504
    Top = 2
    Width = 224
    Height = 13
    Caption = '5. Select one or more Accepted Stocks'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 505
    Top = 489
    Width = 170
    Height = 34
    AutoSize = False
    Caption = ' Ctrl + Click for multi select'#13#10' Shift + Click for range select'
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
  object Label5: TLabel
    Left = 6
    Top = 8
    Width = 88
    Height = 13
    Caption = '1. Choose Area'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 6
    Top = 160
    Width = 84
    Height = 13
    Caption = '2. Choose Site'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object wwDBGrid1: TwwDBGrid
    Left = 281
    Top = 15
    Width = 160
    Height = 146
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
    TabOrder = 2
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
    Left = 281
    Top = 183
    Width = 219
    Height = 236
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
    TabOrder = 3
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
    Left = 504
    Top = 15
    Width = 284
    Height = 474
    Selected.Strings = (
      'SDate'#9'10'#9'Start Date'#9#9
      'EDate'#9'10'#9'End Date'#9#9
      'period'#9'5'#9'Period'#9#9
      'StkKind'#9'15'#9'Kind'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsThStocks
    KeyOptions = [dgEnterToTab]
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ReadOnly = True
    TabOrder = 4
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
    OnCalcTitleAttributes = wwDBGrid3CalcTitleAttributes
    OnTitleButtonClick = wwDBGrid3TitleButtonClick
  end
  object BitBtn1: TBitBtn
    Left = 679
    Top = 496
    Width = 109
    Height = 36
    Caption = 'Done'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 284
    Top = 425
    Width = 212
    Height = 34
    Cancel = True
    Caption = 'View Stocks Reports...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
    NumGlyphs = 2
  end
  object wwDBGrid4: TwwDBGrid
    Left = 6
    Top = 21
    Width = 265
    Height = 135
    ControlType.Strings = (
      'acode;CustomEdit;wwExpButArea;F')
    Selected.Strings = (
      'Area Name'#9'20'#9'Area Name'#9'F'
      'Area Manager'#9'19'#9'Area Manager'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsArea
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
    ParentFont = False
    RowHeightPercent = 90
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    PadColumnStyle = pcsPlain
  end
  object wwDBGrid5: TwwDBGrid
    Left = 6
    Top = 173
    Width = 265
    Height = 323
    ControlType.Strings = (
      'sitecode;CustomEdit;wwExpButSite;F'
      'Windows Employee System;CheckBox;Y;')
    Selected.Strings = (
      'site name'#9'15'#9'Site Name'#9'F'
      'site manager'#9'13'#9'Site Manager'#9#9
      'site ref'#9'10'#9'Site Ref'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Ctl3D = False
    DataSource = dsSite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
    ParentCtl3D = False
    ParentFont = False
    RowHeightPercent = 90
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object BitBtn3: TBitBtn
    Left = 29
    Top = 498
    Width = 218
    Height = 30
    Cancel = True
    Caption = 'Line/Spot Checks Reports'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = BitBtn3Click
    NumGlyphs = 2
  end
  object adoqDivs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Division Name] as Division from Division'
      'order by [Division Name]')
    Left = 292
    Top = 20
  end
  object dsDivs: TwwDataSource
    DataSet = adoqDivs
    Left = 324
    Top = 20
  end
  object adoqThreads: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
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
        Value = 'Food'
      end>
    SQL.Strings = (
      'select * from Threads'
      'where [division] = :division'
      'order by TName')
    Left = 292
    Top = 44
  end
  object dsThreads: TwwDataSource
    DataSet = adoqThreads
    Left = 324
    Top = 44
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
      
        'select [sitecode], [Tid], [StockCode], [SDate], [STime], [EDate]' +
        ', [ETime], edt, sdt, '
      #9'[AccDate], [AccTime], [StkKind], [division], [type], [byHZ],'
      
        ' (CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) / 7) AS VA' +
        'RCHAR) + '#39'/'#39' +'
      
        '  CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) % 7) AS VA' +
        'RCHAR)) as period,'
      ' pureAZ, byLocation'
      'from Stocks'
      'where Tid = :tid'
      'and sitecode = 1'
      'and stockcode >= 2'
      'order by edt DESC'
      ''
      ''
      #9
      '')
    Left = 372
    Top = 28
  end
  object dsThStocks: TwwDataSource
    DataSet = adoqThStock
    Left = 400
    Top = 28
  end
  object dsArea: TwwDataSource
    DataSet = adoqArea
    Left = 104
    Top = 272
  end
  object adoqArea: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select distinct a.[area code] as acode, a.[area name], a.[area m' +
        'anager]'
      'from area a, config c'
      'where a.[deleted] is null'
      'and a.[area code] = c.[area code]'
      'and c.[deleted] is null'
      'and c.[site code] is not null and c.[site code] > 0'
      'order by a.[area name], a.[area manager]')
    Left = 136
    Top = 272
  end
  object adoqSite: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterScroll = adoqSiteAfterScroll
    DataSource = dsArea
    Parameters = <
      item
        Name = 'acode'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 1
      end>
    SQL.Strings = (
      
        'select distinct a.[site code] as sitecode, a.[site name], a.[sit' +
        'e manager],'
      'a.[site ref]'
      'from site a, config b'
      'where a.[site code] = b.[site code]'
      'and a.[deleted] is null'
      'and b.[deleted] is null'
      'and b.[area code] = :acode'
      'order by a.[site name]')
    Left = 136
    Top = 296
  end
  object dsSite: TwwDataSource
    DataSet = adoqSite
    Left = 104
    Top = 296
  end
end
