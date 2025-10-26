object FrmAddDiskQuota: TFrmAddDiskQuota
  Left = 252
  Top = 126
  BorderStyle = bsDialog
  Caption = 'Add disk quota'
  ClientHeight = 208
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblUserName: TLabel
    Left = 10
    Top = 20
    Width = 168
    Height = 16
    Caption = 'User name (DOMAIN\User):'
  end
  object lblVolume: TLabel
    Left = 10
    Top = 54
    Width = 49
    Height = 16
    Caption = 'Volume:'
  end
  object lblWarningLimit: TLabel
    Left = 10
    Top = 94
    Width = 120
    Height = 16
    Caption = 'Warning limit (bytes)'
  end
  object lblLimit: TLabel
    Left = 10
    Top = 133
    Width = 71
    Height = 16
    Caption = 'Limit (bytes)'
  end
  object cmbVolume: TComboBox
    Left = 186
    Top = 49
    Width = 258
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 1
    OnChange = OnControlChange
  end
  object edtWarningLimit: TEdit
    Left = 185
    Top = 89
    Width = 262
    Height = 24
    TabOrder = 2
    OnChange = OnControlChange
    OnKeyPress = edtLimitKeyPress
  end
  object edtLimit: TEdit
    Left = 185
    Top = 128
    Width = 262
    Height = 24
    TabOrder = 3
    OnChange = OnControlChange
    OnKeyPress = edtLimitKeyPress
  end
  object btnOk: TButton
    Left = 241
    Top = 167
    Width = 93
    Height = 31
    Caption = 'Ok'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 354
    Top = 167
    Width = 93
    Height = 31
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object cmbUser: TComboBox
    Left = 186
    Top = 14
    Width = 258
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 0
    OnChange = OnControlChange
  end
end
