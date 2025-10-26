object fCurrdlg: TfCurrdlg
  Left = 302
  Top = 218
  HelpContext = 1004
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Current Stocks'
  ClientHeight = 473
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMThSTh: TLabel
    Left = 0
    Top = 395
    Width = 788
    Height = 17
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    Visible = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 0
    Top = 412
    Width = 788
    Height = 17
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'The inventory is now complete. It can now be Accepted, Re-Calcul' +
      'ated or Cancelled.  (Theo. Reduction done using Calculation Time' +
      ' Recipe Map)'
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
    OnDblClick = Label3DblClick
  end
  object Grid: TwwDBGrid
    Left = 0
    Top = 0
    Width = 788
    Height = 395
    ControlType.Strings = (
      'ThByHZ;CheckBox;True;False'
      'ByHz;CheckBox;True;False')
    Selected.Strings = (
      'Division'#9'17'#9'Division'#9#9
      'tname'#9'27'#9'Thread Name'#9'F'
      'SDate'#9'11'#9'Date'#9'F'#9'Start'
      'STime'#9'6'#9'Time'#9'F'#9'Start'
      'EDate'#9'11'#9'Date'#9'F'#9'End'
      'ETime'#9'6'#9'Time'#9'F'#9'End'
      'StkKind'#9'13'#9'Stk. Kind'#9'F'
      'Stage'#9'16'#9'Stage'#9'F'
      'ByHz'#9'5'#9'Stock'#9'F'#9'Holding Zones'
      'ThByHZ'#9'5'#9'Thread'#9'F'#9'Holding Zones')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = wwDS1
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = GridCalcCellColors
    PaintOptions.ActiveRecordColor = clHighlight
  end
  object Panel2: TPanel
    Left = 0
    Top = 429
    Width = 788
    Height = 44
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      788
      44)
    object sbAudNoRec: TSpeedButton
      Left = 608
      Top = 11
      Width = 17
      Height = 22
      Caption = '**'
      Visible = False
      OnClick = sbAudNoRecClick
    end
    object AccBtn: TBitBtn
      Left = 252
      Top = 5
      Width = 116
      Height = 35
      Caption = 'Accept Inventory'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = AccBtnClick
    end
    object canBtn: TBitBtn
      Left = 373
      Top = 5
      Width = 116
      Height = 35
      Caption = 'Cancel Stock'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = canBtnClick
    end
    object RepBtn: TBitBtn
      Left = 504
      Top = 5
      Width = 104
      Height = 35
      Caption = 'Reports'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = RepBtnClick
    end
    object BitBtn3: TBitBtn
      Left = 681
      Top = 5
      Width = 102
      Height = 35
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
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
    object btnRecAud: TBitBtn
      Left = 5
      Top = 5
      Width = 110
      Height = 35
      Caption = 'Edit Audit'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnRecAudClick
    end
    object btnMisc: TBitBtn
      Left = 121
      Top = 5
      Width = 110
      Height = 35
      Caption = 'Enter Misc. Info'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnMiscClick
    end
    object pnlDebug: TPanel
      Left = 342
      Top = 7
      Width = 57
      Height = 30
      Color = clRed
      TabOrder = 6
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
      object Label1: TLabel
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
        OnDblClick = Label1DblClick
      end
    end
  end
  object wwDS1: TwwDataSource
    DataSet = wwqCurStk
    Left = 40
    Top = 24
  end
  object wwqCurStk: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterScroll = wwqCurStkAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select a.*, b."tname", b."slaveTh", (b."byHZ") as ThByHZ'
      'from "curStock" a, "threads" b'
      'where a.tid = b.tid'
      'and b.tid in (select tid from stksectids where permid = 8)'
      'order by a.division, b.tname')
    Left = 8
    Top = 24
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 64
  end
end
