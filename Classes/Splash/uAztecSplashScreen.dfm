object frmAztecSplashForm: TfrmAztecSplashForm
  Left = 242
  Top = 136
  AlphaBlend = True
  AlphaBlendValue = 0
  AutoSize = True
  BorderStyle = bsNone
  Caption = 'Aztec Splash Screen'
  ClientHeight = 235
  ClientWidth = 391
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clYellow
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
  object imgMainImage: TImage
    Left = 0
    Top = 0
    Width = 391
    Height = 235
    AutoSize = True
  end
  object tmrDisplayTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrDisplayTimerTimer
    Left = 8
    Top = 8
  end
  object AlphaBlendTimer: TTimer
    Tag = 5
    Enabled = False
    Interval = 2
    OnTimer = AlphaBlendTimerTimer
    Left = 40
    Top = 8
  end
end
