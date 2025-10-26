object frm1wklypurch: Tfrm1wklypurch
  Left = 397
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Weekly Purchase Reports'
  ClientHeight = 387
  ClientWidth = 564
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 564
    Height = 387
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 562
      Height = 29
      Align = alTop
      Alignment = taCenter
      Caption = 'Weekly Reports'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnMouseDown = Label1MouseDown
    end
    object WaitLbl: TLabel
      Left = 43
      Top = 334
      Width = 213
      Height = 44
      Alignment = taCenter
      AutoSize = False
      Caption = 'Generating Report, Please Wait....'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 23
      Top = 78
      Width = 126
      Height = 16
      Caption = 'Select Week to View:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ConfigBttn: TBitBtn
      Left = 187
      Top = 30
      Width = 185
      Height = 33
      Hint = 'Set the Column Order and Report Headings'
      Caption = 'Configure Report &Layout'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ConfigBttnClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object CloseBitBtn: TBitBtn
      Left = 420
      Top = 344
      Width = 123
      Height = 33
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      Glyph.Data = {
        76020000424D7602000000000000760000002800000040000000100000000100
        0400000000000002000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F33330000000000033333300000000000333301BBBBBBBB
        033333773F3333337F333301111111110333333011111111103333011BBBBBBB
        0333337F73F333337F3333011111111103333330111111111033330111BBBBBB
        0333337F373F33337F33330111111111033333301111111110333301110BBBBB
        0333337F337F33337F33330111111111033333301111111110333301110BBBBB
        0333337F337F33337F33330111111111033333301111111110333301110BBBBB
        0333337F337F33337F33330111111111033333301111111110333301110BBBBB
        0333337F337F33337F333301111111B1033333301111111B10333301110BBBBB
        0333337F337F33337F33330111111111033333301111111110333301110BBBBB
        0333337F337FF3337F3333011111111103333330111111111033330111B0BBBB
        0333337F337733337F3333011EEEEE110333333011EEEEE110333301110BBBBB
        0333337F337F33337F3333011EEEEE110333333011EEEEE110333301110BBBBB
        0333337F3F7F33337F3333011EEEEE110333333011EEEEE110333301E10BBBBB
        0333337F7F7F33337F33330111111111033333301111111110333301EE0BBBBB
        0333337F777FFFFF7F3333011111111103333330111111111033330000000000
        0333337777777777733333000000000003333330000000000033}
      NumGlyphs = 4
    end
    object BitBtn1: TBitBtn
      Left = 314
      Top = 73
      Width = 229
      Height = 25
      Caption = 'PURCHASE REPORT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn1Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555500000
        55555555000BB3B30555555030BB3303305555030BB0B3B3330555033BBBB333
        330550B3B3BB3BB3B33050B3B33BBBBB333050B3B33BBBBB3B3050B3B333BB0B
        33B050B33333BBB3B3B050BB33333333BB05550B33B3333BB305550BB33330BB
        B0555550BB33B3BB0555555500B3333055555555550000055555}
    end
    object WPRPanel: TPanel
      Left = 23
      Top = 105
      Width = 253
      Height = 221
      BevelInner = bvLowered
      TabOrder = 3
      object Label3: TLabel
        Left = 6
        Top = 8
        Width = 77
        Height = 13
        Caption = 'Week Selected:'
      end
      object WkSelLbl: TLabel
        Left = 91
        Top = 8
        Width = 3
        Height = 13
      end
      object OrderByRadioGrp: TRadioGroup
        Left = 34
        Top = 34
        Width = 187
        Height = 122
        Hint = 'Select the Report Order'
        Caption = 'Order By'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Vendor'
          'Invoice Date'
          'Invoice Number')
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PrintBttn: TBitBtn
        Left = 33
        Top = 171
        Width = 187
        Height = 33
        Hint = 'Display a print preview of the report'
        Caption = 'View/&Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PrintBttnClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
          8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
          8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
          8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
      end
    end
    object DatePick: TDateTimePicker
      Left = 153
      Top = 74
      Width = 120
      Height = 24
      Hint = 'Select Report Week'
      CalAlignment = dtaRight
      Date = 36145.6843536574
      Time = 36145.6843536574
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = dtkDate
      MaxDate = 2958464
      ParseInput = True
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnChange = DatePickChange
    end
  end
end
