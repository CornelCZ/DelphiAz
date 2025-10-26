object BarCodeForm: TBarCodeForm
  Left = 393
  Top = 255
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Barcode'
  ClientHeight = 114
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 14
    Width = 241
    Height = 13
    Caption = 'Please scan or type in the barcode you wish to add'
  end
  object edtBarCode: TEdit
    Left = 8
    Top = 32
    Width = 249
    Height = 21
    MaxLength = 13
    TabOrder = 0
    OnChange = edtBarCodeChange
    OnEnter = edtBarCodeEnter
    OnKeyPress = edtBarCodeKeyPress
  end
  object btnOk: TButton
    Left = 56
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 136
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object UseCustomBarcodeChkBx: TCheckBox
    Left = 128
    Top = 56
    Width = 129
    Height = 17
    Caption = 'Custom priced barcode'
    TabOrder = 3
  end
end
