object ThemeDetails: TThemeDetails
  Left = 528
  Top = 91
  HelpContext = 5010
  BorderStyle = bsSingle
  Caption = 'Theme Details'
  ClientHeight = 248
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Theme name'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label3: TLabel
    Left = 8
    Top = 182
    Width = 170
    Height = 13
    Caption = 'Idle time before automatic log off (s):'
  end
  object Label1: TLabel
    Left = 311
    Top = 182
    Width = 92
    Height = 13
    Caption = '(0 = no auto log off)'
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    MaxLength = 50
    TabOrder = 0
    Text = 'New theme 1'
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 97
    Lines.Strings = (
      'A new theme')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 256
    Top = 216
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = Button2Click
  end
  object seIdleTime: TSpinEdit
    Left = 184
    Top = 179
    Width = 121
    Height = 22
    Increment = 10
    MaxValue = 86400
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
end
