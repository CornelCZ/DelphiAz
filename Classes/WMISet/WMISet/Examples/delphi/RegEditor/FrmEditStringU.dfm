object FrmEditString: TFrmEditString
  Left = 226
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Edit String'
  ClientHeight = 150
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object lblValueName: TLabel
    Left = 8
    Top = 8
    Width = 75
    Height = 16
    Caption = 'Value name:'
  end
  object lblValueData: TLabel
    Left = 8
    Top = 62
    Width = 68
    Height = 16
    Caption = 'Value data:'
  end
  object edtValueName: TEdit
    Left = 8
    Top = 28
    Width = 460
    Height = 24
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object edtValueData: TEdit
    Left = 8
    Top = 84
    Width = 460
    Height = 24
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 304
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 392
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
