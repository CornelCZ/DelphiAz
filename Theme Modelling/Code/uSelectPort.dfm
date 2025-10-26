object SelectPortForm: TSelectPortForm
  Left = 688
  Top = 317
  Width = 212
  Height = 264
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Select available port'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object theLabel: TLabel
    Left = 8
    Top = 27
    Width = 121
    Height = 65
    Caption = 
      'Please select one of these available ports and press OK or press' +
      ' Cancel to abandon the move action.'
    WordWrap = True
  end
  object btnOK: TButton
    Left = 30
    Top = 208
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 120
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object rgpPorts: TRadioGroup
    Left = 138
    Top = 24
    Width = 57
    Height = 41
    Caption = 'Ports'
    TabOrder = 2
  end
end
