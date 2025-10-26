object BaseEditReconfigurePinPads: TBaseEditReconfigurePinPads
  Left = 805
  Top = 237
  Width = 378
  Height = 236
  Caption = 'Configure Pin Pads'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    370
    209)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 339
    Height = 13
    Caption = 
      'The current EFT mode is not compatible with one or more Site Pin' +
      ' Pads:'
  end
  object btFixLater: TButton
    Left = 288
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Fix Later'
    TabOrder = 2
    OnClick = btFixLaterClick
  end
  object btFixNow: TButton
    Left = 208
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Fix now'
    TabOrder = 1
    OnClick = btFixNowClick
  end
  object mmWarnings: TMemo
    Left = 8
    Top = 24
    Width = 353
    Height = 129
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object cbEnableEftPay: TCheckBox
    Left = 8
    Top = 160
    Width = 97
    Height = 17
    Hint = 'If enabled, sets all Pin Pads to use EFTPAY mode (for ATS UK)'
    Caption = 'Use EftPay'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cbVx670PayAtTable: TCheckBox
    Left = 8
    Top = 176
    Width = 129
    Height = 17
    Hint = 
      'If enabled, puts converted Vx670 Peds in "Pay at Table" mode, al' +
      'l prompts will appear on the Ped instead of the terminal'
    Caption = 'Vx670 Pay at Table'
    TabOrder = 4
  end
end
