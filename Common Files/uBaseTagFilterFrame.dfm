object BaseTagFilterFrame: TBaseTagFilterFrame
  Left = 0
  Top = 0
  Width = 154
  Height = 25
  TabOrder = 0
  object chkbxFiltered: TCheckBox
    Left = 0
    Top = 4
    Width = 113
    Height = 17
    Alignment = taLeftJustify
    Caption = '<???> Tag filter'
    TabOrder = 0
    OnClick = chkbxFilteredClick
  end
  object btnTags: TButton
    Left = 119
    Top = 0
    Width = 35
    Height = 25
    Hint = 'Filter by <???> Tags'
    Caption = 'Tags'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnTagsClick
  end
end
