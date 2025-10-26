object FrmEditDWORD: TFrmEditDWORD
  Left = 226
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Edit DWORD value'
  ClientHeight = 127
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblValueName: TLabel
    Left = 7
    Top = 7
    Width = 59
    Height = 13
    Caption = 'Value name:'
  end
  object lblValueData: TLabel
    Left = 7
    Top = 50
    Width = 54
    Height = 13
    Caption = 'Value data:'
  end
  object edtValueName: TEdit
    Left = 7
    Top = 23
    Width = 373
    Height = 24
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object edtValueData: TEdit
    Left = 7
    Top = 68
    Width = 169
    Height = 24
    MaxLength = 8
    TabOrder = 1
    OnKeyPress = edtValueDataKeyPress
  end
  object btnOk: TButton
    Left = 247
    Top = 98
    Width = 61
    Height = 20
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 319
    Top = 98
    Width = 60
    Height = 20
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object rgBase: TRadioGroup
    Left = 189
    Top = 55
    Width = 191
    Height = 34
    Caption = 'Base'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Hexadecimal'
      'Decimal')
    TabOrder = 4
    OnClick = rgBaseClick
  end
end
