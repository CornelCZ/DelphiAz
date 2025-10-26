object PromotionalFooters: TPromotionalFooters
  Left = 459
  Top = 238
  Width = 800
  Height = 600
  Caption = 'Promotional Footers'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    792
    573)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 530
    Width = 776
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object lblPromoFooters: TLabel
    Left = 8
    Top = 8
    Width = 174
    Height = 13
    Caption = 'Currently defined promotional footers:'
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 24
    Width = 776
    Height = 495
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object btnNew: TButton
    Left = 8
    Top = 539
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'New'
    TabOrder = 1
  end
  object btnEdit: TButton
    Left = 88
    Top = 539
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Edt'
    TabOrder = 2
  end
  object btnDelete: TButton
    Left = 168
    Top = 539
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Delete'
    TabOrder = 3
  end
end
