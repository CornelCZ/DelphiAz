object FrmNewTask: TFrmNewTask
  Left = 312
  Top = 201
  BorderStyle = bsDialog
  Caption = 'New Task'
  ClientHeight = 91
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblFileName: TLabel
    Left = 6
    Top = 17
    Width = 68
    Height = 16
    Caption = 'File Name: '
  end
  object edtFileName: TEdit
    Left = 92
    Top = 14
    Width = 261
    Height = 24
    TabOrder = 0
    OnChange = edtFileNameChange
  end
  object btnStart: TButton
    Left = 176
    Top = 52
    Width = 75
    Height = 26
    Caption = 'Start'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 268
    Top = 52
    Width = 83
    Height = 26
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
