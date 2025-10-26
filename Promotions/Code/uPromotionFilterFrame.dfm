object PromotionFilterFrame: TPromotionFilterFrame
  Left = 0
  Top = 0
  Width = 1092
  Height = 29
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  TabOrder = 0
  DesignSize = (
    1092
    29)
  object FilterPanel: TPanel
    Left = 0
    Top = 0
    Width = 1092
    Height = 29
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      1092
      29)
    object Bevel1: TBevel
      Left = 75
      Top = 4
      Width = 2
      Height = 18
    end
    object Bevel2: TBevel
      Left = 744
      Top = 4
      Width = 2
      Height = 18
      Anchors = [akTop, akRight]
    end
    object lblSiteFilter: TLabel
      Left = 752
      Top = 6
      Width = 54
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Created by:'
    end
    object edtFilter: TEdit
      Left = 86
      Top = 3
      Width = 551
      Height = 21
      Hint = 'Show promotions whose Name or Description matches this text'
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = ApplyFilterSettings
    end
    object chkbxMidwordSearch: TCheckBox
      Left = 643
      Top = 5
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Midword search'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ApplyFilterSettings
    end
    object chkbxFiltered: TCheckBox
      Left = 8
      Top = 5
      Width = 57
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Filtered'
      TabOrder = 0
      OnClick = ApplyFilterSettings
    end
    object cbxSiteFilter: TComboBox
      Left = 813
      Top = 3
      Width = 273
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akTop, akRight]
      ItemHeight = 16
      TabOrder = 3
      OnChange = ApplyFilterSettings
      OnDrawItem = cbxSiteFilterDrawItem
    end
  end
end
