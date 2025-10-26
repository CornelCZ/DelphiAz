object NewPortionIngredientsFrame: TNewPortionIngredientsFrame
  Left = 0
  Top = 0
  Width = 607
  Height = 374
  TabOrder = 0
  object HoldingPanel: TPanel
    Left = 0
    Top = 0
    Width = 607
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonPanel: TPanel
      Left = 0
      Top = 328
      Width = 607
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        607
        46)
      object btnMoveDown: TSpeedButton
        Left = 7
        Top = 18
        Width = 23
        Height = 25
        Hint = 'Move ingredient down'
        ParentShowHint = False
        ShowHint = True
        OnClick = btnMoveDownClick
      end
      object btnMoveUp: TSpeedButton
        Left = 39
        Top = 18
        Width = 23
        Height = 25
        Hint = 'Move ingredient up'
        ParentShowHint = False
        ShowHint = True
        OnClick = btnMoveUpClick
      end
      object lblBudgetedCostPriceMethodOverride: TLabel
        Left = 179
        Top = 3
        Width = 328
        Height = 13
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '** Budgeted Cost Price calculation method overridden. **'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object InsertButton: TButton
        Left = 291
        Top = 18
        Width = 75
        Height = 25
        Hint = 'Insert Ingredient'
        Action = InsertIngredientAction
        Anchors = [akRight, akBottom]
        Caption = 'Insert'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Button2: TButton
        Left = 527
        Top = 18
        Width = 75
        Height = 25
        Hint = 'Delete Ingredient'
        Action = DeleteIngredientAction
        Anchors = [akRight, akBottom]
        Caption = 'Delete'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object Button3: TButton
        Left = 369
        Top = 18
        Width = 75
        Height = 25
        Hint = 'Append Ingredient'
        Action = AppendIngredientAction
        Anchors = [akRight, akBottom]
        Caption = 'Append'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object Button4: TButton
        Left = 448
        Top = 18
        Width = 75
        Height = 25
        Hint = 'Edit Ingredient'
        Action = EditIngredientAction
        Anchors = [akRight, akBottom]
        Caption = 'Edit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object btnSettingsOverride: TButton
        Left = 187
        Top = 18
        Width = 100
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Settings Override'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnSettingsOverrideClick
      end
      object gbPortionFilter: TGroupBox
        Left = 72
        Top = 10
        Width = 103
        Height = 37
        TabOrder = 5
        object cbPortionFilter: TCheckBox
          Left = 4
          Top = 13
          Width = 13
          Height = 17
          TabOrder = 0
          OnClick = cbPortionFilterClick
        end
        object btnPortions: TButton
          Left = 23
          Top = 8
          Width = 75
          Height = 25
          Action = PortionFilterAction
          Caption = 'Portions...'
          TabOrder = 1
        end
      end
    end
    object BasePanel: TPanel
      Left = 0
      Top = 0
      Width = 607
      Height = 328
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object SubGridPanel: TPanel
        Left = 0
        Top = 45
        Width = 607
        Height = 283
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object dbgPortions: TwwDBGrid
          Left = 0
          Top = 0
          Width = 605
          Height = 212
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          OnLeftColChanged = dbgPortionsLeftColChanged
          OnCellChanged = dbgPortionsCellChanged
          FixedCols = 3
          ShowHorzScrollBar = False
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DataSource = ProductsDB.dsPortions
          KeyOptions = []
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgTrailingEllipsis, dgShowCellHint, dgFixedResizable]
          ParentCtl3D = False
          PopupMenu = PortiongridPopupMenu
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 4
          TitleButtons = False
          UseTFields = False
          OnCalcCellColors = dbgPortionsCalcCellColors
          OnDrawGroupHeaderCell = dbgPortionsDrawGroupHeaderCell
          OnColEnter = dbgPortionsColEnter
          OnDblClick = dbgPortionsDblClick
          OnKeyDown = dbgPortionsKeyDown
          OnMouseDown = dbgPortionsMouseDown
          IndicatorIconColor = clNone
          OnDrawFooterCell = dbgPortionsDrawFooterCell
          FooterColor = clGradientInactiveCaption
          FooterCellColor = clGradientInactiveCaption
          PadColumnStyle = pcsPlain
          PaintOptions.FastRecordScrolling = False
          PaintOptions.BackgroundOptions = [coFillDataCells]
        end
        object PortionNameLookupCombo: TComboBox
          Left = 96
          Top = 10
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Visible = False
          OnCloseUp = PortionNameLookupComboCloseUp
          OnSelect = PortionNameLookupComboSelect
        end
        object Panel3: TPanel
          Left = 0
          Top = 212
          Width = 605
          Height = 69
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object dbgPortionPrices: TwwDBGrid
            Left = 0
            Top = 1
            Width = 605
            Height = 68
            LineStyle = glsSingle
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 1
            ShowHorzScrollBar = True
            ShowVertScrollBar = False
            Align = alBottom
            BorderStyle = bsNone
            Ctl3D = False
            DataSource = ProductsDB.dsPortionPrices
            KeyOptions = []
            Options = [dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgTrailingEllipsis, dgShowCellHint, dgFixedResizable]
            ParentCtl3D = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 1
            TitleButtons = False
            UseTFields = False
            LineColors.DataColor = clGradientInactiveCaption
            LineColors.FixedColor = clSilver
            OnCalcCellColors = dbgPortionPricesCalcCellColors
            OnColEnter = dbgPortionPricesColEnter
            OnDrawDataCell = dbgPortionPricesDrawDataCell
            OnFieldChanged = dbgPortionPricesFieldChanged
            PadColumnStyle = pcsPlain
            PaintOptions.FastRecordScrolling = False
            PaintOptions.BackgroundOptions = [coFillDataCells]
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 605
            Height = 1
            Align = alTop
            TabOrder = 1
          end
        end
      end
      object TopPanel: TPanel
        Left = 0
        Top = 0
        Width = 607
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 2
        TabOrder = 1
        object RightPanel: TPanel
          Left = 360
          Top = 2
          Width = 245
          Height = 41
          Align = alRight
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = '````'
          TabOrder = 0
          DesignSize = (
            245
            41)
          object Label2: TLabel
            Left = 100
            Top = 22
            Width = 49
            Height = 13
            Alignment = taCenter
            Anchors = [akRight, akBottom]
            Caption = 'hh:nn:ss'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 81
            Top = 11
            Width = 88
            Height = 13
            Alignment = taCenter
            Anchors = [akRight, akBottom]
            Caption = 'Default Cook Time'
          end
          object Bevel1: TBevel
            Left = 75
            Top = 5
            Width = 2
            Height = 31
            Anchors = [akRight, akBottom]
          end
          object CookTimesButton: TButton
            Left = 174
            Top = 8
            Width = 65
            Height = 25
            Action = CookTimesAction
            Anchors = [akRight, akBottom]
            TabOrder = 0
          end
          object ContainersButton: TButton
            Left = 6
            Top = 8
            Width = 65
            Height = 25
            Action = ContainersAction
            Anchors = [akRight, akBottom]
            TabOrder = 1
          end
        end
        object LeftPanel: TPanel
          Left = 2
          Top = 2
          Width = 22
          Height = 41
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object IngredientsAsOfCaption: TLabel
            Left = 4
            Top = 21
            Width = 84
            Height = 13
            Caption = 'Ingredients as of: '
          end
          object FuturePortionsExistlbl: TLabel
            Left = 88
            Top = 0
            Width = 96
            Height = 13
            Caption = 'Future Portions Exist'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object IngredientsAsOfComboBox: TComboBox
            Left = 88
            Top = 17
            Width = 100
            Height = 21
            AutoDropDown = True
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = IngredientsAsOfComboBoxChange
            OnDropDown = IngredientsAsOfComboBoxDropDown
            OnEnter = IngredientsAsOfComboBoxEnter
            OnKeyDown = IngredientsAsOfComboBoxKeyDown
          end
          object CancelChangesButton: TButton
            Left = 192
            Top = 15
            Width = 85
            Height = 25
            Action = CancelChangesAction
            TabOrder = 1
          end
        end
        object Panel1: TPanel
          Left = 24
          Top = 2
          Width = 336
          Height = 41
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object grbMinMaxChoices: TGroupBox
            Left = 0
            Top = 0
            Width = 336
            Height = 41
            Align = alClient
            Caption = 'Enable Multi-Select'
            TabOrder = 0
            object lblMinChoice: TLabel
              Left = 8
              Top = 20
              Width = 20
              Height = 13
              Hint = 'Minimum number of options that must be selected'
              Caption = 'Min:'
              ParentShowHint = False
              ShowHint = True
            end
            object lblMaxChoice: TLabel
              Left = 80
              Top = 20
              Width = 23
              Height = 13
              Hint = 'Maximum number of options that can be selected'
              Caption = 'Max:'
              ParentShowHint = False
              ShowHint = True
            end
            object lblSupplement: TLabel
              Left = 157
              Top = 20
              Width = 45
              Height = 13
              Hint = 
                'The number of options that can be selected before supplementary ' +
                'prices are applied'
              Caption = 'Inclusive:'
              ParentShowHint = False
              ShowHint = True
            end
            object seMinChoice: TwwDBSpinEdit
              Left = 32
              Top = 16
              Width = 41
              Height = 21
              Increment = 1
              MaxValue = 99
              DataField = 'MinChoice'
              DataSource = ProductsDB.dtsEditPortionChoices
              Enabled = False
              MaxLength = 2
              TabOrder = 0
              UnboundDataType = wwDefault
              OnChange = OnMinMaxChoiceChange
            end
            object seMaxChoice: TwwDBSpinEdit
              Left = 108
              Top = 16
              Width = 41
              Height = 21
              Increment = 1
              MaxValue = 99
              MinValue = 1
              DataField = 'MaxChoice'
              DataSource = ProductsDB.dtsEditPortionChoices
              Enabled = False
              MaxLength = 2
              TabOrder = 1
              UnboundDataType = wwDefault
              OnChange = OnMinMaxChoiceChange
            end
            object seSuppChoice: TwwDBSpinEdit
              Left = 208
              Top = 16
              Width = 41
              Height = 21
              Increment = 1
              MaxValue = 99
              DataField = 'SuppChoice'
              DataSource = ProductsDB.dtsEditPortionChoices
              Enabled = False
              MaxLength = 2
              TabOrder = 2
              UnboundDataType = wwDefault
              OnChange = OnMinMaxChoiceChange
            end
            object cbxChoiceEnabled: TwwCheckBox
              Left = 127
              Top = -1
              Width = 17
              Height = 17
              AlwaysTransparent = False
              ValueChecked = 'True'
              ValueUnchecked = 'False'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Caption = 'cbxChoiceEnabled'
              DataField = 'EnableChoices'
              DataSource = ProductsDB.dtsEditPortionChoices
              TabOrder = 3
              OnClick = cbxChoiceEnabledClick
            end
            object wwcbAllowPlain: TwwCheckBox
              Left = 256
              Top = 18
              Width = 73
              Height = 17
              Hint = 'Allow the '#39'Plain'#39' EPoS button  to be used '
              AlwaysTransparent = False
              ValueChecked = 'True'
              ValueUnchecked = 'False'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Alignment = taLeftJustify
              Caption = 'Allow plain:'
              DataField = 'AllowPlain'
              DataSource = ProductsDB.dtsEditPortionChoices
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
            end
          end
        end
      end
    end
  end
  object PortionsActionList: TActionList
    OnUpdate = PortionsActionListUpdate
    Left = 240
    Top = 92
    object InsertIngredientAction: TAction
      Caption = 'Insert Ingredient'
      OnExecute = InsertIngredientActionExecute
      OnUpdate = InsertIngredientActionUpdate
    end
    object DeleteIngredientAction: TAction
      Caption = 'Delete Ingredient'
      OnExecute = DeleteIngredientActionExecute
      OnUpdate = DeleteIngredientActionUpdate
    end
    object AppendIngredientAction: TAction
      Caption = 'Append Ingredient'
      OnExecute = AppendIngredientActionExecute
      OnUpdate = AppendIngredientActionUpdate
    end
    object EditIngredientAction: TAction
      Caption = 'Edit Ingredient'
      OnExecute = EditIngredientActionExecute
      OnUpdate = EditIngredientActionUpdate
    end
    object DeletePortionAction: TAction
      Caption = 'Delete Portion'
      OnExecute = DeletePortionActionExecute
      OnUpdate = DeletePortionActionUpdate
    end
    object CancelChangesAction: TAction
      Caption = 'Cancel Changes'
      OnExecute = CancelChangesActionExecute
      OnUpdate = CancelChangesActionUpdate
    end
    object PortionFilterAction: TAction
      Caption = 'PortionFilterAction'
      OnExecute = PortionFilterActionExecute
    end
  end
  object PortiongridPopupMenu: TPopupMenu
    AutoPopup = False
    Left = 272
    Top = 92
    object InsertIngredient1: TMenuItem
      Action = InsertIngredientAction
    end
    object DeleteIngredient2: TMenuItem
      Action = DeleteIngredientAction
    end
    object AppendIngredient1: TMenuItem
      Action = AppendIngredientAction
    end
    object DeleteIngredient1: TMenuItem
      Action = EditIngredientAction
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object DeletePortion1: TMenuItem
      Action = DeletePortionAction
    end
  end
  object FormsActionList: TActionList
    Left = 240
    Top = 128
    object CookTimesAction: TAction
      Caption = 'Cook Times'
      OnExecute = CookTimesActionExecute
    end
    object ContainersAction: TAction
      Caption = 'Containers'
      OnExecute = ContainersActionExecute
    end
  end
end
