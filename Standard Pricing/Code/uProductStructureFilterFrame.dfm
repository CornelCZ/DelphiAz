object ProductStructureFilterFrame: TProductStructureFilterFrame
  Left = 0
  Top = 0
  Width = 1418
  Height = 67
  Ctl3D = True
  ParentCtl3D = False
  TabOrder = 0
  OnEnter = FrameEnter
  object bvlFrameIndicator: TBevel
    Left = 0
    Top = 0
    Width = 1418
    Height = 67
    Align = alClient
  end
  object lblDivision: TLabel
    Left = 0
    Top = 4
    Width = 37
    Height = 13
    Caption = 'Division'
  end
  object lblCategory: TLabel
    Left = 529
    Top = 4
    Width = 42
    Height = 13
    Caption = 'Category'
  end
  object lblSubCat: TLabel
    Left = 705
    Top = 4
    Width = 64
    Height = 13
    Caption = 'Sub-Category'
  end
  object lblProduct: TLabel
    Left = 881
    Top = 4
    Width = 37
    Height = 13
    Caption = 'Product'
  end
  object lblPortion: TLabel
    Left = 1057
    Top = 4
    Width = 33
    Height = 13
    Caption = 'Portion'
  end
  object lblSubDivision: TLabel
    Left = 177
    Top = 4
    Width = 59
    Height = 13
    Caption = 'Sub-Division'
  end
  object lblSuperCategory: TLabel
    Left = 353
    Top = 4
    Width = 73
    Height = 13
    Caption = 'Super-Category'
  end
  object lblPricing: TLabel
    Left = 1229
    Top = 3
    Width = 32
    Height = 13
    Caption = 'Pricing'
  end
  object cmbbxDivision: TComboBox
    Left = 0
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbbxDivisionChange
    Items.Strings = (
      '<all values>')
  end
  object cmbbxCategory: TComboBox
    Left = 529
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnChange = cmbbxCategoryChange
  end
  object cmbbxSubCat: TComboBox
    Left = 705
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = cmbbxSubCategoryChange
  end
  object cmbbxProduct: TComboBox
    Left = 881
    Top = 20
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    OnExit = cmbbxProductExit
  end
  object cmbbxPortion: TComboBox
    Left = 1057
    Top = 18
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    OnExit = cmbbxPortionExit
  end
  object cmbbxSubDivision: TComboBox
    Left = 177
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = cmbbxSubDivisionChange
    Items.Strings = (
      '<all values>')
  end
  object cmbbxSuperCategory: TComboBox
    Left = 353
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = cmbbxSuperCategoryChange
    Items.Strings = (
      '<all values>')
  end
  object cmbbxPricing: TComboBox
    Left = 1230
    Top = 17
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    OnExit = cmbbxPortionExit
  end
end
