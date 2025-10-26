object fSitePromotionPriorities: TfSitePromotionPriorities
  Left = 500
  Top = 194
  Width = 608
  Height = 585
  Caption = 'Set Promotion Priorities'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    592
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    DesignSize = (
      592
      60)
    object Label13: TLabel
      Left = 21
      Top = 6
      Width = 126
      Height = 13
      Caption = 'Set Promotion priority'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = -1
      Top = 58
      Width = 586
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
    end
    object imLogo: TImage
      Tag = 102
      Left = 530
      Top = 5
      Width = 49
      Height = 49
      Anchors = [akTop, akRight]
    end
    object Label2: TLabel
      Left = 40
      Top = 24
      Width = 483
      Height = 28
      AutoSize = False
      Caption = 
        'Promotions higher in the list have higher priority. Higher prior' +
        'ity promotions are applied in favour of lower priority ones rega' +
        'rdless of the price difference.'
      WordWrap = True
    end
  end
  object btOk: TButton
    Left = 429
    Top = 515
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 509
    Top = 515
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  inline SetPromotionOrderFrame: TSetPromotionOrderFrame
    Left = 0
    Top = 64
    Width = 590
    Height = 425
    HelpContext = 7102
    Constraints.MinHeight = 382
    Constraints.MinWidth = 590
    TabOrder = 3
  end
end
