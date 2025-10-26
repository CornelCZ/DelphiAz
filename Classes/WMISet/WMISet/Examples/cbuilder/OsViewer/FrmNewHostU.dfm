object FrmNewHost: TFrmNewHost
  Left = 385
  Top = 237
  BorderStyle = bsDialog
  Caption = 'Connect to network host'
  ClientHeight = 194
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 9
    Top = 9
    Width = 143
    Height = 16
    Caption = 'Host name or IP adress:'
  end
  object edtHostName: TEdit
    Left = 160
    Top = 5
    Width = 153
    Height = 24
    TabOrder = 0
    OnChange = OnEditChanged
  end
  object grbCredentials: TGroupBox
    Left = 9
    Top = 32
    Width = 312
    Height = 121
    Caption = 'Credentials'
    TabOrder = 1
    object lblDomain: TLabel
      Left = 9
      Top = 25
      Width = 47
      Height = 16
      Caption = 'Domain'
    end
    object lblUserName: TLabel
      Left = 9
      Top = 57
      Width = 69
      Height = 16
      Caption = 'User Name'
    end
    object lblPassword: TLabel
      Left = 9
      Top = 89
      Width = 60
      Height = 16
      Caption = 'Password'
    end
    object edtDomain: TEdit
      Left = 89
      Top = 22
      Width = 216
      Height = 24
      TabOrder = 0
    end
    object edtUserName: TEdit
      Left = 89
      Top = 54
      Width = 216
      Height = 24
      TabOrder = 1
      OnChange = OnEditChanged
    end
    object edtPassword: TEdit
      Left = 89
      Top = 86
      Width = 216
      Height = 24
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object btnConnect: TButton
    Left = 153
    Top = 160
    Width = 73
    Height = 25
    Caption = 'Connect'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 240
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
