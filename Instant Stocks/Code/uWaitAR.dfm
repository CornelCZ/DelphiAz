object fWaitAR: TfWaitAR
  Left = 297
  Top = 134
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Auto Print'
  ClientHeight = 408
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 707
    Height = 41
    Align = alTop
    AutoSize = False
  end
  object Label4: TLabel
    Left = 0
    Top = 41
    Width = 707
    Height = 228
    Align = alClient
    Alignment = taCenter
    AutoSize = False
    Caption = 'Please Wait, Printing Reports....'
    Color = clRed
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -32
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 0
    Top = 269
    Width = 707
    Height = 32
    Align = alBottom
    AutoSize = False
  end
  object labRep: TLabel
    Left = 0
    Top = 301
    Width = 707
    Height = 34
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Preparing to print...'
    Color = clGreen
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ShowAccelChar = False
    Layout = tlCenter
    WordWrap = True
  end
  object Label2: TLabel
    Left = 0
    Top = 335
    Width = 707
    Height = 32
    Align = alBottom
    AutoSize = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 367
    Width = 707
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      707
      41)
    object BitBtn1: TBitBtn
      Left = 540
      Top = 5
      Width = 161
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Cancel Printing'
      TabOrder = 0
      OnClick = BitBtn1Click
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
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 552
    Top = 8
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 64
  end
end
