object EditScaleContainer: TEditScaleContainer
  Left = 687
  Top = 183
  HelpContext = 5079
  BorderStyle = bsSingle
  Caption = 'EditScaleContainer'
  ClientHeight = 202
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object lblDescription: TLabel
    Left = 8
    Top = 56
    Width = 56
    Height = 13
    Caption = 'Description:'
  end
  object lblTareWeight: TLabel
    Left = 8
    Top = 128
    Width = 62
    Height = 13
    Caption = 'Tare Weight:'
  end
  object btnOK: TButton
    Left = 248
    Top = 172
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 332
    Top = 172
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object edtContainerName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object memoDesc: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 48
    MaxLength = 250
    TabOrder = 1
  end
  object edtTareWeight: TEdit
    Left = 8
    Top = 144
    Width = 401
    Height = 21
    TabOrder = 2
    OnKeyPress = edtTareWeightKeyPress
  end
end
