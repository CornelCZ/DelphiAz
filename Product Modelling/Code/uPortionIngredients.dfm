object PortionIngredientsFrame: TPortionIngredientsFrame
  Left = 0
  Top = 0
  Width = 448
  Height = 234
  TabOrder = 0
  DesignSize = (
    448
    234)
  object IngredientsGrid: TwwDBGrid
    Left = 0
    Top = 4
    Width = 445
    Height = 229
    Selected.Strings = (
      'IngredientName'#9'20'#9'IngredientName'
      'IngredientDescription'#9'20'#9'IngredientDescription'
      'UnitDisplayName'#9'14'#9'UnitDisplayName'
      'Quantity'#9'9'#9'Quantity')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = IngredientsGridDblClick
    OnKeyDown = IngredientsGridKeyDown
    OnMouseUp = IngredientsGridMouseUp
    OnUpdateFooter = IngredientsGridUpdateFooter
    FooterColor = clGradientInactiveCaption
    FooterCellColor = clGradientInactiveCaption
    PadColumnStyle = pcsPlain
  end
  object PortionIngredientActionList: TActionList
    Left = 296
    Top = 120
    object InsertPortionIngredientAction: TAction
      Caption = 'Insert Ingredient'
      OnExecute = InsertPortionIngredientActionExecute
    end
    object DeletePortionIngredientAction: TAction
      Caption = 'Delete Ingredient'
      OnExecute = DeletePortionIngredientActionExecute
      OnUpdate = DeletePortionIngredientActionUpdate
    end
    object AppendPortionIngredientAction: TAction
      Caption = 'Append Ingredient'
      OnExecute = AppendPortionIngredientActionExecute
    end
    object EditPortionIngredientAction: TAction
      Caption = 'Edit Ingredient'
      OnExecute = EditPortionIngredientActionExecute
      OnUpdate = EditPortionIngredientActionUpdate
    end
  end
end
