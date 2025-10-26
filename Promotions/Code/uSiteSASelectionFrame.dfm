object SiteSASelectionFrame: TSiteSASelectionFrame
  Left = 0
  Top = 0
  Width = 606
  Height = 350
  TabOrder = 0
  OnResize = SelectSitesSAResize
  DesignSize = (
    606
    350)
  object lbAvailableItems: TLabel
    Left = 8
    Top = 4
    Width = 130
    Height = 13
    Caption = 'Available Sites/Sales Areas'
  end
  object lbSelectedItems: TLabel
    Left = 319
    Top = 4
    Width = 129
    Height = 13
    Caption = 'Selected Sites/Sales Areas'
  end
  object tvAvailableItems: TTreeView
    Left = 8
    Top = 20
    Width = 274
    Height = 242
    Anchors = [akLeft, akTop, akBottom]
    Indent = 19
    TabOrder = 0
  end
  object sbIncludeItem: TButton
    Left = 289
    Top = 68
    Width = 23
    Height = 22
    Caption = '>'
    TabOrder = 1
    OnClick = sbIncludeItemClick
  end
  object sbIncludeAllItems: TButton
    Left = 289
    Top = 100
    Width = 23
    Height = 22
    Caption = '>>'
    TabOrder = 2
    OnClick = sbIncludeAllItemsClick
  end
  object sbExcludeAllItems: TButton
    Left = 289
    Top = 132
    Width = 23
    Height = 22
    Caption = '<<'
    TabOrder = 3
    OnClick = sbExcludeAllItemsClick
  end
  object sbExcludeItem: TButton
    Left = 289
    Top = 164
    Width = 23
    Height = 22
    Caption = '<'
    TabOrder = 4
    OnClick = sbExcludeItemClick
  end
  object tvSelectedItems: TTreeView
    Left = 321
    Top = 20
    Width = 274
    Height = 298
    Anchors = [akLeft, akTop, akBottom]
    Indent = 19
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 5
  end
  object edSearchTerm: TEdit
    Tag = 1
    Left = 8
    Top = 269
    Width = 182
    Height = 21
    Hint = 'Search'
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '<Type keywords to search>'
    OnChange = edSearchTermChange
    OnEnter = SearchTermEnter
    OnExit = SearchTermExit
  end
  object btFindPrev: TButton
    Left = 191
    Top = 269
    Width = 21
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = '<'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = FindPrevClick
  end
  object btFindNext: TButton
    Left = 213
    Top = 269
    Width = 21
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = '>'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = FindNextClick
  end
  inline SiteTagFilterFrame: TSiteTagFilterFrame
    Left = 9
    Top = 296
    Width = 156
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 9
    inherited chkbxFiltered: TCheckBox
      Width = 108
    end
  end
end
