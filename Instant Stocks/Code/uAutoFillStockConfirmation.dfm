object fAutoFillStockConfirmation: TfAutoFillStockConfirmation
  Left = 758
  Top = 299
  Width = 366
  Height = 223
  Caption = 'Confirm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblConfirmationText: TLabel
    Left = 8
    Top = 8
    Width = 335
    Height = 78
    Caption = 
      'Not all audit figures have been entered.'#13#10#13#10'The '#39'Fill blank coun' +
      'ts with Theo Closing'#39' setting is active for this thread.'#13#10#13#10'Woul' +
      'd you like to Save the current stock counts to allow more figure' +
      's to be entered later, or Complete the current stock?'
    WordWrap = True
  end
  object btnAutoComplete: TButton
    Left = 216
    Top = 152
    Width = 131
    Height = 25
    Caption = 'Complete Stock'
    ModalResult = 99
    TabOrder = 0
  end
  object btnSave: TButton
    Left = 216
    Top = 120
    Width = 131
    Height = 25
    Caption = 'Save Stock'
    ModalResult = 98
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
