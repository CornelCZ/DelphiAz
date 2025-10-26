object FrmSelectComputer: TFrmSelectComputer
  Left = 292
  Top = 239
  BorderStyle = bsDialog
  Caption = 'Select Computer'
  ClientHeight = 217
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object lblSelectComputer: TLabel
    Left = 9
    Top = 12
    Width = 178
    Height = 16
    Caption = 'Computer Name (IP Address):'
  end
  object cmbComputers: TComboBox
    Left = 192
    Top = 9
    Width = 169
    Height = 24
    ItemHeight = 16
    TabOrder = 0
    OnDropDown = cmbComputersDropDown
  end
  object pnlCredentials: TPanel
    Left = 9
    Top = 64
    Width = 352
    Height = 113
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object lblDomain: TLabel
      Left = 12
      Top = 16
      Width = 50
      Height = 16
      Caption = 'Domain:'
    end
    object lblUserName: TLabel
      Left = 12
      Top = 48
      Width = 72
      Height = 16
      Caption = 'User Name:'
    end
    object Label1: TLabel
      Left = 12
      Top = 80
      Width = 63
      Height = 16
      Caption = 'Password:'
    end
    object edtDomain: TEdit
      Left = 100
      Top = 12
      Width = 241
      Height = 24
      Color = clBtnFace
      Enabled = False
      TabOrder = 0
    end
    object edtUserName: TEdit
      Left = 100
      Top = 44
      Width = 241
      Height = 24
      Color = clBtnFace
      Enabled = False
      TabOrder = 1
    end
    object edtPassword: TEdit
      Left = 100
      Top = 76
      Width = 241
      Height = 24
      Color = clBtnFace
      Enabled = False
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object chbConnectAsCurrent: TCheckBox
    Left = 10
    Top = 41
    Width = 165
    Height = 16
    Caption = 'Connect as current user'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = chbConnectAsCurrentClick
  end
  object btnOk: TButton
    Left = 185
    Top = 185
    Width = 73
    Height = 24
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 284
    Top = 185
    Width = 75
    Height = 24
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
