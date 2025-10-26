object FrmGetName: TFrmGetName
  Left = 253
  Top = 182
  Width = 409
  Height = 137
  Caption = 'FrmGetName'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblPrompt: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 16
    Caption = 'Prompt'
  end
  object edtName: TEdit
    Left = 8
    Top = 32
    Width = 385
    Height = 24
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 234
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Cancel: TButton
    Left = 317
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
