object faccepted: Tfaccepted
  Left = 301
  Top = 147
  HelpContext = 1005
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Accepted Stocks'
  ClientHeight = 483
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 444
    Width = 77
    Height = 13
    Caption = 'Enter Password:'
  end
  object Label23: TLabel
    Left = 4
    Top = 0
    Width = 706
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Click on a Field Title to order data by that field (Title will t' +
      'urn Yellow). Click on a Yellow Title to use descending order by ' +
      'that field (Title will turn Red).'#13#10'Note: Time fields cannot be s' +
      'elected for ordering.  Click on a Red Title or on "Division" to ' +
      'use Default order (Div > Thread > End Date DESC).'
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
    OnDblClick = Label23DblClick
  end
  object UnaccBtn: TBitBtn
    Left = 8
    Top = 448
    Width = 177
    Height = 33
    Caption = 'Un Accept Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = UnaccBtnClick
  end
  object RepBtn: TBitBtn
    Left = 448
    Top = 448
    Width = 121
    Height = 33
    Caption = 'Reports'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = RepBtnClick
  end
  object CloseBtn: TBitBtn
    Left = 584
    Top = 448
    Width = 121
    Height = 33
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Grid: TwwDBGrid
    Left = 3
    Top = 32
    Width = 708
    Height = 409
    Selected.Strings = (
      'Division'#9'17'#9'Division'#9#9
      'tname'#9'30'#9'Thread Name'#9'F'
      'SDate'#9'10'#9'Start Date'#9'F'
      'STime'#9'5'#9'Start At'#9'F'
      'EDate'#9'10'#9'End Date'#9'F'
      'ETime'#9'5'#9'End At'#9'F'
      'AccDate'#9'10'#9'Acc. Date'#9'F'
      'AccTime'#9'5'#9'Acc. At'#9'F'
      'StkKind'#9'10'#9'Invntry Kind'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDS1
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
    OnCalcCellColors = GridCalcCellColors
    OnCalcTitleAttributes = GridCalcTitleAttributes
    OnTitleButtonClick = GridTitleButtonClick
  end
  object Edit1: TEdit
    Left = 192
    Top = 458
    Width = 142
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
  end
  object BitBtn2: TBitBtn
    Left = 334
    Top = 458
    Width = 54
    Height = 21
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 19
    Top = 435
    Width = 708
    Height = 48
    TabOrder = 6
    Visible = False
    object Label2: TLabel
      Left = 3
      Top = 4
      Width = 563
      Height = 13
      Caption = 
        'Enter a reason for Un Accepting (MIN 10 characters, MAX 80 chara' +
        'cters) then click OK to proceed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit2: TEdit
      Left = 3
      Top = 21
      Width = 585
      Height = 21
      MaxLength = 80
      TabOrder = 0
      OnChange = Edit2Change
    end
    object BitBtn1: TBitBtn
      Left = 594
      Top = 19
      Width = 51
      Height = 25
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
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
    object BitBtn3: TBitBtn
      Left = 651
      Top = 19
      Width = 49
      Height = 25
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object pnlDebug: TPanel
    Left = 390
    Top = 451
    Width = 57
    Height = 30
    Color = clRed
    TabOrder = 7
    Visible = False
    object DBText2: TDBText
      Left = 26
      Top = 16
      Width = 29
      Height = 12
      DataField = 'StockCode'
      DataSource = wwDS1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 26
      Top = 2
      Width = 29
      Height = 12
      DataField = 'Tid'
      DataSource = wwDS1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 3
      Top = 2
      Width = 21
      Height = 29
      AutoSize = False
      Caption = 'TID:'#13#10'Stk:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object wwDS1: TwwDataSource
    DataSet = wwtaccstk
    Left = 88
    Top = 56
  end
  object wwtaccstk: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = wwtaccstkAfterScroll
    AfterScroll = wwtaccstkAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select a.*, b."tname", b."slaveTh", (b."byHZ") as ThByHZ'
      'from "Stocks" a, "threads" b'
      'where a.tid = b.tid'
      'and a."stockcode" > 1'
      'and b.tid in (select tid from stksectids where permid = 18)'
      'order by a.division, b.tname, a."stockcode"')
    Left = 56
    Top = 56
  end
  object adoqMaxStock: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = wwDS1
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
      'select (max([stockcode])) as mS from [stocks]'
      'where tid = :tid')
    Left = 232
    Top = 64
  end
end
