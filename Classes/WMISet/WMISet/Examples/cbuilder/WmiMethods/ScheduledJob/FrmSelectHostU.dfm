object FrmSelectHost: TFrmSelectHost
  Left = 334
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Select Computer'
  ClientHeight = 176
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblSelectComputer: TLabel
    Left = 7
    Top = 10
    Width = 139
    Height = 13
    Caption = 'Computer Name (IP Address):'
  end
  object cmbComputers: TComboBox
    Left = 156
    Top = 7
    Width = 137
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnDropDown = cmbComputersDropDown
  end
  object pnlCredentials: TPanel
    Left = 7
    Top = 52
    Width = 286
    Height = 92
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object lblDomain: TLabel
      Left = 10
      Top = 13
      Width = 39
      Height = 13
      Caption = 'Domain:'
    end
    object lblUserName: TLabel
      Left = 10
      Top = 39
      Width = 56
      Height = 13
      Caption = 'User Name:'
    end
    object Label1: TLabel
      Left = 10
      Top = 65
      Width = 49
      Height = 13
      Caption = 'Password:'
    end
    object edtDomain: TEdit
      Left = 81
      Top = 10
      Width = 196
      Height = 21
      Color = clBtnFace
      Enabled = False
      TabOrder = 0
    end
    object edtUserName: TEdit
      Left = 81
      Top = 36
      Width = 196
      Height = 21
      Color = clBtnFace
      Enabled = False
      TabOrder = 1
    end
    object edtPassword: TEdit
      Left = 81
      Top = 62
      Width = 196
      Height = 21
      Color = clBtnFace
      Enabled = False
      TabOrder = 2
    end
  end
  object chbConnectAsCurrent: TCheckBox
    Left = 8
    Top = 33
    Width = 134
    Height = 13
    Caption = 'Connect as current user'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = chbConnectAsCurrentClick
  end
  object btnOk: TButton
    Left = 150
    Top = 150
    Width = 60
    Height = 20
    Cursor = crDrag
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 231
    Top = 150
    Width = 61
    Height = 20
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
