object PromotionalFooterPriorities: TPromotionalFooterPriorities
  Left = 584
  Top = 320
  Width = 620
  Height = 373
  HelpContext = 5083
  Caption = 'Promotional Footer Priorities'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    604
    335)
  PixelsPerInch = 96
  TextHeight = 13
  object sbMoveUp: TSpeedButton
    Left = 582
    Top = 68
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    OnClick = sbMoveUpClick
  end
  object sbMoveDown: TSpeedButton
    Left = 582
    Top = 91
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    OnClick = sbMoveDownClick
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    DesignSize = (
      604
      60)
    object lblSetPriority: TLabel
      Left = 21
      Top = 6
      Width = 102
      Height = 13
      Caption = 'Set footer priority'
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
      Width = 614
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
    end
    object imLogo: TImage
      Tag = 102
      Left = 558
      Top = 5
      Width = 49
      Height = 49
      Anchors = [akTop, akRight]
    end
    object lblSetPriorityDescription: TLabel
      Left = 40
      Top = 24
      Width = 483
      Height = 28
      AutoSize = False
      Caption = 
        'Footers higher in the list have higher priority. Higher priority' +
        ' footers are applied in favour of lower priority ones.'
      WordWrap = True
    end
  end
  object lbFooterPriority: TListBox
    Left = 8
    Top = 68
    Width = 567
    Height = 234
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    DragMode = dmAutomatic
    ItemHeight = 16
    TabOrder = 1
    OnDragDrop = lbFooterPriorityDragDrop
    OnDragOver = lbFooterPriorityDragOver
    OnDrawItem = lbFooterPriorityDrawItem
  end
  object btnOK: TButton
    Left = 450
    Top = 317
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 530
    Top = 317
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object pnlBottom: TPanel
    Left = 2
    Top = 309
    Width = 607
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 4
  end
end
