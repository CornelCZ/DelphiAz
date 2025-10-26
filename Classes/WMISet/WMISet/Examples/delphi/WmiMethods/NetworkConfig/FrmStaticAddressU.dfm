object FrmStaticAddress: TFrmStaticAddress
  Left = 274
  Top = 160
  Width = 295
  Height = 186
  Caption = 'Assign Static IP Address'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblIPAddress: TLabel
    Left = 7
    Top = 13
    Width = 54
    Height = 13
    Caption = 'IP Address:'
  end
  object lblSubnetMask: TLabel
    Left = 7
    Top = 39
    Width = 50
    Height = 13
    Caption = 'IP Subnet:'
  end
  object Label1: TLabel
    Left = 7
    Top = 65
    Width = 82
    Height = 13
    Caption = 'Default Gateway:'
  end
  object edtIPAddress: TEdit
    Left = 100
    Top = 11
    Width = 124
    Height = 21
    TabOrder = 0
    OnChange = edtIPAddressChange
  end
  object edtIPSubnetMask: TEdit
    Left = 100
    Top = 37
    Width = 124
    Height = 21
    TabOrder = 1
    Text = '255.255.255.0'
    OnChange = edtIPAddressChange
  end
  object btnSetStaticAddress: TButton
    Left = 52
    Top = 98
    Width = 98
    Height = 20
    Caption = 'Set Static address'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 163
    Top = 98
    Width = 60
    Height = 20
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object edtDefaultGateway: TEdit
    Left = 100
    Top = 63
    Width = 124
    Height = 21
    TabOrder = 2
    OnChange = edtIPAddressChange
  end
end
