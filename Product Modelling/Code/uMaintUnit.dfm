object fMaintUnit: TfMaintUnit
  Left = 436
  Top = 244
  BorderStyle = bsDialog
  Caption = 'New Standard Unit'
  ClientHeight = 218
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'New Standard Unit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object nameLabel: TLabel
    Left = 36
    Top = 73
    Width = 38
    Height = 13
    Caption = '* Name:'
  end
  object AmountLabel: TLabel
    Left = 44
    Top = 156
    Width = 30
    Height = 13
    Caption = '* Size:'
  end
  object UnitTypeLabel: TLabel
    Left = 18
    Top = 48
    Width = 56
    Height = 13
    Caption = '* Base Unit:'
  end
  object DescriptionLabel: TLabel
    Left = 21
    Top = 98
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object edtUName: TEdit
    Left = 86
    Top = 71
    Width = 145
    Height = 21
    MaxLength = 10
    TabOrder = 1
  end
  object edtUSize: TEdit
    Left = 86
    Top = 154
    Width = 120
    Height = 21
    TabOrder = 3
  end
  object cmbbxBaseUnit: TComboBox
    Left = 86
    Top = 46
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbbxBaseUnitChange
  end
  object btnOK: TBitBtn
    Left = 180
    Top = 188
    Width = 75
    Height = 25
    TabOrder = 5
    OnClick = btnOKClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 260
    Top = 188
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkCancel
  end
  object UnitDescriptionMemo: TMemo
    Left = 86
    Top = 96
    Width = 250
    Height = 53
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object DefinedByUnitComboBox: TComboBox
    Left = 216
    Top = 154
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 4
  end
end
