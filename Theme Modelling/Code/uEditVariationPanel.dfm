inherited EditVariationPanel: TEditVariationPanel
  Left = 548
  Top = 301
  HelpContext = 5057
  Caption = 'EditVariationPanel'
  ClientHeight = 159
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbName: TLabel
    Width = 104
    Caption = 'Variation panel name:'
  end
  inherited edName: TEdit
    MaxLength = 50
  end
  inherited mmDescription: TMemo
    Height = 49
    MaxLength = 255
  end
  inherited btOk: TButton
    Top = 128
  end
  inherited btCancel: TButton
    Top = 128
  end
end
