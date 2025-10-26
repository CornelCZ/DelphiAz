object fStkDivdlg: TfStkDivdlg
  Left = 506
  Top = 99
  HelpContext = 1009
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'New Stock Setup - Step 1'
  ClientHeight = 574
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    411
    574)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel4: TBevel
    Left = 5
    Top = 290
    Width = 390
    Height = 92
  end
  object Bevel3: TBevel
    Left = 7
    Top = 392
    Width = 393
    Height = 99
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 5
    Top = 30
    Width = 168
    Height = 174
    Style = bsRaised
  end
  object Label2: TLabel
    Left = 11
    Top = 396
    Width = 102
    Height = 13
    Caption = 'Site Managers Name:'
  end
  object Label3: TLabel
    Left = 11
    Top = 435
    Width = 98
    Height = 13
    Caption = 'Stock Takers Name:'
  end
  object Label4: TLabel
    Left = 16
    Top = 3
    Width = 38
    Height = 20
    Caption = 'Site:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SiteLbl: TLabel
    Left = 60
    Top = 3
    Width = 57
    Height = 20
    Caption = 'SiteLbl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 1
    Top = 24
    Width = 404
    Height = 2
  end
  object Label5: TLabel
    Left = 209
    Top = 396
    Width = 58
    Height = 13
    Caption = 'Stock Type:'
  end
  object Label1: TLabel
    Left = 12
    Top = 33
    Width = 56
    Height = 13
    Caption = 'Divisions:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 51
    Top = 319
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'SDate'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText2: TDBText
    Left = 131
    Top = 319
    Width = 47
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'STime'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText3: TDBText
    Left = 211
    Top = 319
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'EDate'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText4: TDBText
    Left = 290
    Top = 319
    Width = 47
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'ETime'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText5: TDBText
    Left = 211
    Top = 359
    Width = 126
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'StkKind'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText6: TDBText
    Left = 51
    Top = 359
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'AccDate'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText7: TDBText
    Left = 131
    Top = 359
    Width = 47
    Height = 17
    Alignment = taCenter
    Color = clInactiveCaption
    DataField = 'AccTime'
    DataSource = dsThStocks
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label6: TLabel
    Left = 51
    Top = 303
    Width = 82
    Height = 13
    AutoSize = False
    Caption = 'Start Date / Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 211
    Top = 303
    Width = 79
    Height = 13
    AutoSize = False
    Caption = 'End Date / Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 51
    Top = 343
    Width = 106
    Height = 13
    AutoSize = False
    Caption = 'Accepted Date / Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 211
    Top = 343
    Width = 58
    Height = 13
    Caption = 'Stock Type:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 180
    Top = 33
    Width = 51
    Height = 13
    Caption = 'Threads:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 8
    Top = 209
    Width = 163
    Height = 13
    Caption = 'Selected Thread Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 16
    Top = 284
    Width = 269
    Height = 13
    Caption = ' Last Accepted Stock Info for selected Thread '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label19: TLabel
    Left = 3
    Top = 494
    Width = 404
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 
      ' End Date of this Stock is auto-set as last Wednesday, 28/08/16.' +
      #13#10' Stock Start Date: Wed 14/08/16, Period: 14 days. '
    Color = clGreen
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
  object MgrEdit: TEdit
    Left = 11
    Top = 409
    Width = 183
    Height = 21
    MaxLength = 20
    TabOrder = 2
    Text = 'MgrEdit'
  end
  object StkTkrEdit: TEdit
    Left = 11
    Top = 447
    Width = 142
    Height = 21
    MaxLength = 20
    TabOrder = 4
  end
  object StkTypeLCB: TDBLookupComboBox
    Left = 209
    Top = 409
    Width = 183
    Height = 21
    DropDownRows = 6
    TabOrder = 3
  end
  object wwDBGrid1: TwwDBGrid
    Left = 10
    Top = 48
    Width = 157
    Height = 149
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
    Left = 178
    Top = 48
    Width = 228
    Height = 178
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
  end
  object wwDBEdit1: TwwDBEdit
    Left = 5
    Top = 224
    Width = 401
    Height = 57
    TabStop = False
    AutoSize = False
    Color = clTeal
    DataField = 'TNote'
    DataSource = dsThreads
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = True
  end
  object Panel4: TPanel
    Left = 0
    Top = 281
    Width = 410
    Height = 108
    TabOrder = 6
    object Label13: TLabel
      Left = 1
      Top = 23
      Width = 408
      Height = 7
      Align = alTop
      AutoSize = False
    end
    object Label14: TLabel
      Left = 1
      Top = 1
      Width = 408
      Height = 5
      Align = alTop
      AutoSize = False
    end
    object Label15: TLabel
      Left = 1
      Top = 30
      Width = 408
      Height = 27
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Not initialised (no Stock Counts available)'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label16: TLabel
      Left = 1
      Top = 6
      Width = 408
      Height = 17
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'No Accepted Stock on this Thread'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label17: TLabel
      Left = 3
      Top = 61
      Width = 201
      Height = 42
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'You need to initialise this thread. '#13#10'You need to provide initia' +
        'l Stock Counts and Costs for the stock items.'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object BitBtn1: TBitBtn
      Left = 211
      Top = 61
      Width = 185
      Height = 43
      Caption = 'Initialise Thread'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Panel5: TPanel
    Left = 1
    Top = 282
    Width = 409
    Height = 108
    TabOrder = 7
    Visible = False
    object Label18: TLabel
      Left = 1
      Top = 1
      Width = 407
      Height = 106
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'There is already a Current Stock for this Thread!'#13#10#13#10'A new stock' +
        ' can be done only after the Current Stock is Accepted or Cancell' +
        'ed.'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
  end
  object OKBtn: TBitBtn
    Left = 136
    Top = 533
    Width = 133
    Height = 36
    Hint = 'Accept the inventory details entered.'
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = OKBtnClick
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
  object CancelBtn: TBitBtn
    Left = 276
    Top = 533
    Width = 124
    Height = 36
    Hint = 
      'Cancels the current inventory.'#13#10'Any details entered so far will ' +
      'be lost.'
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Kind = bkCancel
  end
  object cbCPS: TCheckBox
    Left = 209
    Top = 449
    Width = 177
    Height = 17
    Caption = 'Start New Cumulative Period '
    TabOrder = 10
  end
  object cbAskRcp: TCheckBox
    Left = 11
    Top = 472
    Width = 297
    Height = 17
    Caption = 'Use Sale Time Recipes for Theo. Reduction calculations'
    TabOrder = 11
  end
  object wwStktypeDS: TwwDataSource
    DataSet = data1.wwtRun
    Left = 103
    Top = 4
  end
  object adoqThreads: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsDivs
    Parameters = <
      item
        Name = 'division'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'Beer/Wine'
      end>
    SQL.Strings = (
      'select * from Threads'
      'where [active] = '#39'Y'#39
      'and [division] = :division'
      'and [tid] in (select tid from stksectids where permid in (6,7))'
      'order by TName')
    Left = 192
  end
  object dsThreads: TwwDataSource
    DataSet = adoqThreads
    Left = 224
  end
  object adoqDivs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Division Name] as Division from Division'
      'order by [Division Name]')
  end
  object dsDivs: TwwDataSource
    DataSet = adoqDivs
    Left = 32
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
        Value = Null
      end>
    SQL.Strings = (
      'select * from Stocks where Tid = :tid'
      'order by stockcode DESC')
    Left = 280
    object adoqThStockSiteCode: TSmallintField
      FieldName = 'SiteCode'
    end
    object adoqThStockTid: TSmallintField
      FieldName = 'Tid'
    end
    object adoqThStockStockCode: TSmallintField
      FieldName = 'StockCode'
    end
    object adoqThStockDivision: TStringField
      FieldName = 'Division'
    end
    object adoqThStockSDate: TDateTimeField
      FieldName = 'SDate'
      DisplayFormat = 'ddddd'
    end
    object adoqThStockSTime: TStringField
      FieldName = 'STime'
      Size = 5
    end
    object adoqThStockEDate: TDateTimeField
      FieldName = 'EDate'
      DisplayFormat = 'ddddd'
    end
    object adoqThStockETime: TStringField
      FieldName = 'ETime'
      Size = 5
    end
    object adoqThStockAccDate: TDateTimeField
      FieldName = 'AccDate'
      DisplayFormat = 'ddddd'
    end
    object adoqThStockAccTime: TStringField
      FieldName = 'AccTime'
      Size = 5
    end
    object adoqThStockStage: TStringField
      FieldName = 'Stage'
    end
    object adoqThStockType: TStringField
      FieldName = 'Type'
      Size = 1
    end
    object adoqThStockDateRecalc: TDateTimeField
      FieldName = 'DateRecalc'
    end
    object adoqThStockTimeRecalc: TStringField
      FieldName = 'TimeRecalc'
      Size = 5
    end
    object adoqThStockStkKind: TStringField
      FieldName = 'StkKind'
      Size = 15
    end
    object adoqThStockPrevStkCode: TSmallintField
      FieldName = 'PrevStkCode'
    end
    object adoqThStockSDT: TDateTimeField
      FieldName = 'SDT'
    end
    object adoqThStockEDT: TDateTimeField
      FieldName = 'EDT'
    end
    object adoqThStockByHZ: TBooleanField
      FieldName = 'ByHZ'
    end
    object adoqThStockLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object adoqThStockAccBy: TStringField
      FieldName = 'AccBy'
    end
    object adoqThStockPureAZ: TBooleanField
      FieldName = 'PureAZ'
    end
    object adoqThStockRTRcp: TBooleanField
      FieldName = 'RTRcp'
    end
  end
  object dsThStocks: TwwDataSource
    DataSet = adoqThStock
    Left = 312
  end
end
