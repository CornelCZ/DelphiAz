object fIncDec: TfIncDec
  Left = 696
  Top = 352
  HelpContext = 6008
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Adjust selected prices'
  ClientHeight = 276
  ClientWidth = 259
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
  object pnlButtons: TPanel
    Left = 0
    Top = 227
    Width = 259
    Height = 49
    Align = alBottom
    TabOrder = 1
    object bbtOK: TBitBtn
      Left = 92
      Top = 13
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = bbtOKClick
      Kind = bkOK
    end
    object bbtCancel: TBitBtn
      Left = 178
      Top = 13
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 259
    Height = 227
    Align = alClient
    TabOrder = 0
    object lblAmount: TLabel
      Left = 57
      Top = 196
      Width = 88
      Height = 13
      Alignment = taRightJustify
      Caption = 'Increase Value by:'
    end
    object lblPercent: TLabel
      Left = 244
      Top = 196
      Width = 8
      Height = 13
      Caption = '%'
      Visible = False
    end
    object rgAdjustType: TRadioGroup
      Left = 5
      Top = 16
      Width = 248
      Height = 161
      Align = alCustom
      Caption = 'Calculation Type'
      ItemIndex = 0
      Items.Strings = (
        'Value Increase'
        'Value Decrease'
        'Percentage Increase'
        'Percentage Decrease')
      TabOrder = 0
      OnClick = rgAdjustTypeClick
    end
    object edAmount: TEdit
      Left = 150
      Top = 192
      Width = 87
      Height = 21
      TabOrder = 1
      OnExit = edAmountExit
      OnKeyPress = edAmountKeyPress
    end
  end
end
