object BarcodeExceptionValue: TBarcodeExceptionValue
  Left = 585
  Top = 534
  HelpContext = 5071
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Create Barcode Range Exception'
  ClientHeight = 101
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 243
    Height = 26
    Caption = 
      'Note: Multiple values can be entered by separating values with a' +
      ' comma(,).  '
    WordWrap = True
  end
  object btnCancel: TButton
    Left = 188
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 100
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object edtException: TMemo
    Left = 8
    Top = 40
    Width = 258
    Height = 21
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
end
