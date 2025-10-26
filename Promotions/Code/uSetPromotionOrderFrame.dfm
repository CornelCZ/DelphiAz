object SetPromotionOrderFrame: TSetPromotionOrderFrame
  Left = 0
  Top = 0
  Width = 593
  Height = 425
  HelpContext = 7102
  Constraints.MinHeight = 382
  Constraints.MinWidth = 590
  TabOrder = 0
  OnResize = FormResize
  DesignSize = (
    593
    425)
  object Label1: TLabel
    Left = 9
    Top = 8
    Width = 151
    Height = 13
    Caption = 'Automatic priority mode for sites:'
  end
  object Label3: TLabel
    Left = 9
    Top = 53
    Width = 74
    Height = 13
    Caption = 'Global priorities:'
  end
  object cbAutoPriority: TComboBox
    Left = 9
    Top = 24
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnSelect = cbAutoPrioritySelect
    Items.Strings = (
      '<None>'
      'Always favour customer'
      'Always favour company')
  end
  object cbShowConflicts: TCheckBox
    Left = 9
    Top = 72
    Width = 521
    Height = 17
    Caption = 'Show only promotions which conflict with current selection'
    Enabled = False
    TabOrder = 1
    OnClick = cbShowConflictsClick
  end
  object outerPanel: TPanel
    Left = 7
    Top = 93
    Width = 580
    Height = 325
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 158
      Width = 578
      Height = 9
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      Color = clBtnShadow
      MinSize = 64
      ParentColor = False
    end
    object dealsPanel: TPanel
      Left = 1
      Top = 1
      Width = 578
      Height = 157
      Align = alTop
      Caption = 'dealsPanel'
      Constraints.MinHeight = 64
      TabOrder = 0
      object pnlDealsRight: TPanel
        Left = 546
        Top = 1
        Width = 31
        Height = 155
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          31
          155)
        object sbMoveDownDeal: TSpeedButton
          Left = 2
          Top = 69
          Width = 26
          Height = 25
          Anchors = [akTop, akRight]
          OnClick = sbMoveDownDealClick
        end
        object sbMoveUpDeal: TSpeedButton
          Left = 2
          Top = 37
          Width = 26
          Height = 25
          Anchors = [akTop, akRight]
          OnClick = sbMoveUpDealClick
        end
      end
      object pnlDealsLeft: TPanel
        Left = 1
        Top = 1
        Width = 545
        Height = 155
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lblDealsPanel: TLabel
          Left = 0
          Top = 0
          Width = 545
          Height = 18
          Hint = 'All Deals are always higher priority than any Promotions'
          Align = alTop
          AutoSize = False
          Caption = 'Promotional Deals '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Layout = tlCenter
        end
        object lbDealOrderHeader: TListBox
          Left = 0
          Top = 18
          Width = 545
          Height = 18
          TabStop = False
          Style = lbOwnerDrawFixed
          Align = alTop
          Enabled = False
          ExtendedSelect = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ItemHeight = 15
          Items.Strings = (
            'Name                        Description')
          ParentFont = False
          TabOrder = 0
          OnDrawItem = lbOrderHeaderDrawItem
        end
        object lbDealOrder: TListBox
          Left = 0
          Top = 36
          Width = 545
          Height = 119
          Style = lbOwnerDrawFixed
          Align = alClient
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ItemHeight = 15
          MultiSelect = True
          ParentFont = False
          TabOrder = 1
          TabWidth = 100
          OnClick = lbPromotionOrderClick
          OnDragDrop = lbDealOrderDragDrop
          OnDragOver = lbDealOrderDragOver
          OnDrawItem = lbPromotionOrderDrawItem
        end
      end
    end
    object promosPanel: TPanel
      Left = 1
      Top = 167
      Width = 578
      Height = 157
      Align = alClient
      Caption = 'promosPanel'
      Constraints.MinHeight = 64
      TabOrder = 1
      object pnlPromoRight: TPanel
        Left = 546
        Top = 1
        Width = 31
        Height = 155
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          31
          155)
        object sbMoveDown: TSpeedButton
          Left = 2
          Top = 69
          Width = 26
          Height = 25
          Anchors = [akTop, akRight]
          OnClick = sbMoveDownClick
        end
        object sbMoveUp: TSpeedButton
          Left = 2
          Top = 37
          Width = 26
          Height = 25
          Anchors = [akTop, akRight]
          OnClick = sbMoveUpClick
        end
      end
      object pnlPromoLeft: TPanel
        Left = 1
        Top = 1
        Width = 545
        Height = 155
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlPromoLeft'
        TabOrder = 1
        object lblPromosPanel: TLabel
          Left = 0
          Top = 0
          Width = 545
          Height = 18
          Hint = 'All Promotions are always lower priority than any Deal'
          Align = alTop
          AutoSize = False
          Caption = 'Promotions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Layout = tlCenter
        end
        object lbOrderHeader: TListBox
          Left = 0
          Top = 18
          Width = 545
          Height = 18
          TabStop = False
          Style = lbOwnerDrawFixed
          Align = alTop
          Enabled = False
          ExtendedSelect = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ItemHeight = 15
          Items.Strings = (
            'Name                        Description')
          ParentFont = False
          TabOrder = 0
          OnDrawItem = lbOrderHeaderDrawItem
        end
        object lbPromotionOrder: TListBox
          Left = 0
          Top = 36
          Width = 545
          Height = 119
          Style = lbOwnerDrawFixed
          Align = alClient
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ItemHeight = 15
          MultiSelect = True
          ParentFont = False
          TabOrder = 1
          TabWidth = 100
          OnClick = lbPromotionOrderClick
          OnDragDrop = ListHandleDragDrop
          OnDragOver = ListHandleDragOver
          OnDrawItem = lbPromotionOrderDrawItem
        end
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 320
    Top = 24
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer2Timer
    Left = 360
    Top = 24
  end
end
