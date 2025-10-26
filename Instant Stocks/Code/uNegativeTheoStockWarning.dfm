object fNegativeTheoStockWarning: TfNegativeTheoStockWarning
  Left = 741
  Top = 308
  BorderStyle = bsSingle
  Caption = 'Negative Theoretical Stock Levels'
  ClientHeight = 303
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblWarningText: TLabel
    Left = 8
    Top = 8
    Width = 345
    Height = 26
    Caption = 
      'The following products have a negative theoretical closing value' +
      ' and will be filled with a value of 0 if you continue:'
    WordWrap = True
  end
  object lblContinue: TLabel
    Left = 8
    Top = 256
    Width = 48
    Height = 13
    Caption = 'Continue?'
  end
  object btnYes: TButton
    Left = 192
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Yes'
    ModalResult = 6
    TabOrder = 0
  end
  object btnNo: TButton
    Left = 280
    Top = 272
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'No'
    ModalResult = 7
    TabOrder = 1
  end
  object memProductList: TMemo
    Left = 8
    Top = 48
    Width = 345
    Height = 201
    Lines.Strings = (
      'memProductList')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
