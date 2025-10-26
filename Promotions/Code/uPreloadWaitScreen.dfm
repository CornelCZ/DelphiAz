object PreloadWaitScreen: TPreloadWaitScreen
  Left = 493
  Top = 212
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsToolWindow
  BorderWidth = 5
  Caption = 'Data load in progress'
  ClientHeight = 32
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lbLoadingMessage: TLabel
    Left = 48
    Top = 0
    Width = 258
    Height = 13
    Caption = 'Please wait while Site and Product data are pre-loaded'
  end
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 32
    Height = 32
  end
  object Button1: TButton
    Left = 320
    Top = 11
    Width = 75
    Height = 21
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 40
    Top = 8
  end
end
