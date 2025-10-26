object FrmNewHost: TFrmNewHost
  Left = 260
  Top = 154
  BorderStyle = bsDialog
  Caption = 'Connect to network host'
  ClientHeight = 158
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 113
    Height = 13
    Caption = 'Host name or IP adress:'
  end
  object edtHostName: TEdit
    Left = 130
    Top = 4
    Width = 124
    Height = 24
    TabOrder = 0
    OnChange = EditChanged
  end
  object grbCredentials: TGroupBox
    Left = 7
    Top = 26
    Width = 254
    Height = 98
    Caption = 'Credentials'
    TabOrder = 1
    object lblDomain: TLabel
      Left = 7
      Top = 20
      Width = 36
      Height = 13
      Caption = 'Domain'
    end
    object lblUserName: TLabel
      Left = 7
      Top = 46
      Width = 53
      Height = 13
      Caption = 'User Name'
    end
    object lblPassword: TLabel
      Left = 7
      Top = 72
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object edtDomain: TEdit
      Left = 72
      Top = 18
      Width = 176
      Height = 24
      TabOrder = 0
    end
    object edtUserName: TEdit
      Left = 72
      Top = 44
      Width = 176
      Height = 24
      TabOrder = 1
      OnChange = EditChanged
    end
    object edtPassword: TEdit
      Left = 72
      Top = 70
      Width = 176
      Height = 24
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object btnConnect: TButton
    Left = 124
    Top = 130
    Width = 60
    Height = 20
    Caption = 'Connect'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 195
    Top = 130
    Width = 61
    Height = 20
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
