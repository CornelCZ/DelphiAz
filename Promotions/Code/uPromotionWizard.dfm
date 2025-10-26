object PromotionWizard: TPromotionWizard
  Left = 710
  Top = 324
  Width = 620
  Height = 460
  HelpContext = 7004
  Caption = 'Promotion Wizard'
  Color = clBtnFace
  Constraints.MinHeight = 460
  Constraints.MinWidth = 620
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    604
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object pcWizard: TPageControl
    Left = -4
    Top = -7
    Width = 620
    Height = 402
    ActivePage = tsPromoDetails
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabHeight = 1
    TabIndex = 0
    TabOrder = 0
    TabStop = False
    object tsPromoDetails: TTabSheet
      Caption = 'z'
      OnShow = tsPromoDetailsShow
      DesignSize = (
        612
        391)
      object lbWizardTitle: TLabel
        Left = 152
        Top = 8
        Width = 345
        Height = 25
        AutoSize = False
        Caption = 'New Promotion Wizard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lbWizardDescription: TLabel
        Left = 148
        Top = 32
        Width = 455
        Height = 33
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of setting up a n' +
          'ew promotion.'
        WordWrap = True
      end
      object Label3: TLabel
        Left = 152
        Top = 63
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object Label4: TLabel
        Left = 152
        Top = 103
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label5: TLabel
        Left = 152
        Top = 182
        Width = 75
        Height = 13
        Caption = 'Promotion Type'
      end
      object Label6: TLabel
        Left = 152
        Top = 221
        Width = 70
        Height = 13
        Caption = 'Promotion Bias'
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 391
        Align = alLeft
        Color = clWhite
        TabOrder = 1
        object imZonalBig: TImage
          Tag = 101
          Left = 22
          Top = 24
          Width = 99
          Height = 88
          AutoSize = True
          Center = True
        end
      end
      object edName: TEdit
        Left = 152
        Top = 80
        Width = 229
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 25
        TabOrder = 0
      end
      object edDescription: TMemo
        Left = 152
        Top = 119
        Width = 229
        Height = 62
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 256
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object cbPromotionType: TComboBox
        Left = 152
        Top = 198
        Width = 153
        Height = 21
        Hint = 
          'Timed - define promotional prices for each product'#13#10'Multi Buy - ' +
          'define groups of products eligible for a single "deal" price'#13#10'BO' +
          'GOF - define groups of products with promotional prices per prod' +
          'uct per group'#13#10'Event Pricing - define prices and enabled promoti' +
          'ons for a site-activated Event tariff'#13#10'Enhanced BOGOF - defines ' +
          'priced child items (e.g choices) to be included'#13#10'               ' +
          '                  (with parent items) in BOGOF calculations'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = 'Timed'
        OnChange = cbPromotionTypeChange
        Items.Strings = (
          'Timed'
          'Multi Buy'
          'BOGOF'
          'Event Pricing'
          'Enhanced BOGOF')
      end
      object cbFavourCustomer: TComboBox
        Left = 152
        Top = 237
        Width = 153
        Height = 21
        Hint = 
          'Affects behaviour when multiple promotions apply to an order:'#13#10'A' +
          'lways favour Company - picks promotions giving the least saving'#13 +
          #10'Always favour Customer - picks promotions giving the most savin' +
          'g'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Text = 'Always favour company'
        Items.Strings = (
          'Always favour company'
          'Always favour customer')
      end
      object pnlHideFromCustomer: TPanel
        Left = 389
        Top = 214
        Width = 206
        Height = 18
        Hint = 
          'Option not available when the system is configured to use Normal' +
          ' Accounting Rules (NAR) VAT'
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        object cbHideFromCustomer: TCheckBox
          Left = 0
          Top = 1
          Width = 205
          Height = 15
          Hint = 
            'If ticked the promotion name and price decrease\increase will no' +
            't be displayed on the EPoS Order Display or on the Bill Receipt.'
          Caption = 'Hide promotion details from customers'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
      object gbPromoVerification: TGroupBox
        Left = 389
        Top = 65
        Width = 185
        Height = 117
        Anchors = [akTop, akRight]
        Caption = 'Promotion Verification'
        TabOrder = 6
        object lblSwipeCardGroup: TLabel
          Left = 10
          Top = 36
          Width = 97
          Height = 13
          Caption = 'Security Card Group'
        end
        object lblCardValidation: TLabel
          Left = 11
          Top = 74
          Width = 72
          Height = 13
          Caption = 'Card Validation'
        end
        object cbVerification: TComboBox
          Left = 10
          Top = 15
          Width = 167
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          OnChange = cbVerificationChange
          Items.Strings = (
            'None'
            'By Card Swipe')
        end
        object cbSwipeCardGroup: TComboBox
          Left = 10
          Top = 51
          Width = 167
          Height = 21
          Style = csDropDownList
          Enabled = False
          ItemHeight = 13
          TabOrder = 1
          OnChange = cbSwipeCardGroupChange
        end
        object cbValidation: TComboBox
          Left = 10
          Top = 89
          Width = 167
          Height = 21
          Style = csDropDownList
          Enabled = False
          ItemHeight = 13
          TabOrder = 2
          OnChange = cbValidationChange
        end
      end
      object pnlValidWithAllPaymentMethods: TPanel
        Left = 389
        Top = 240
        Width = 214
        Height = 41
        Hint = 'Option not applicable to Event Pricing promotions.'
        ParentShowHint = False
        ShowHint = False
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 7
        object cbValidWithAllPaymentMethods: TCheckBox
          Left = 0
          Top = 0
          Width = 217
          Height = 16
          Hint = 
            'If ticked the promotion will apply even with a ''restricted product'' payment on' +
            ' the EPoS account'
          Caption = 'Available for all payments'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object cbValidWithAllDiscounts: TCheckBox
          Left = 0
          Top = 25
          Width = 217
          Height = 16
          Hint =
            'If ticked the promotion will apply even with a discount configured to disable ' +
            'promotions on the EPoS account'
          Caption = 'Available for all discounts'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object pnlLoyalty: TPanel
        Left = 152
        Top = 276
        Width = 185
        Height = 33
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Enabled = False
        TabOrder = 8
        object lblLoyaltyPointsRequired: TLabel
          Left = 10
          Top = 12
          Width = 76
          Height = 13
          Caption = 'Points required:'
          Enabled = False
        end
        object edtLoyaltyPointsRequired: TEdit
          Left = 88
          Top = 8
          Width = 89
          Height = 21
          TabOrder = 0
          OnKeyPress = edtLoyaltyPointsRequiredKeyPress
        end
      end
      object chkbxLoyaltyPromotion: TCheckBox
        Left = 164
        Top = 268
        Width = 105
        Height = 16
        Action = actLoyaltyPromotion
        TabOrder = 9
      end
      object cbCanIncreasePrice: TCheckBox
        Left = 389
        Top = 289
        Width = 212
        Height = 18
        Hint = 
          'If ticked the promotion will be able to generate a promotion pri' +
          'ce greater than the tariff price.'
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Allow tariff price increase'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
      end
      object pnlEventOnly: TPanel
        Left = 389
        Top = 189
        Width = 213
        Height = 18
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 11
        object cbEventOnly: TCheckBox
          Left = 0
          Top = 0
          Width = 201
          Height = 17
          Caption = 'Only available within event pricing'
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
        end
      end
      object cbGroupItemsUnderPromotion: TCheckBox
        Left = 389
        Top = 315
        Width = 212
        Height = 18
        Hint = 
          'If ticked the promoted items will be grouped together under the ' +
          'promotion name on the receipt.'
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Group items under promotion'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
      end
      object cbReferenceRequired: TCheckBox
        Left = 389
        Top = 341
        Width = 208
        Height = 17
        Hint = 
          'If ticked this promotion will not trigger unless the user also p' +
          'rovides a reference.'
        Caption = 'Reference required'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
      end
      object cbPromotionalDeal: TCheckBox
        Left = 389
        Top = 367
        Width = 208
        Height = 17
        Hint = 
          'Allows products in different groups to be bundled together under' +
          ' '#13#10'a trigger product, with a higher priority than non-deal promo' +
          'tions types.'
        Caption = 'Promotional Deal'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 14
      end
    end
    object tsSelectSites: TTabSheet
      Caption = 'tsSelectSites'
      ImageIndex = 1
      OnResize = tsSelectSitesResize
      DesignSize = (
        612
        391)
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label8: TLabel
          Left = 21
          Top = 6
          Width = 66
          Height = 13
          Caption = 'Select Sites'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object lbSelectSitesInfo: TLabel
          Left = 45
          Top = 22
          Width = 307
          Height = 13
          Caption = 
            'Select the sites and/or sales areas that the promotion applies t' +
            'o'
        end
        object Image2: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      inline SiteSASelectionFrame: TSiteSASelectionFrame
        Left = 0
        Top = 60
        Width = 606
        Height = 350
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        inherited lbAvailableItems: TLabel
          Width = 129
        end
        inherited lbSelectedItems: TLabel
          Width = 127
        end
      end
    end
    object tsDefineGroups: TTabSheet
      Caption = 'tsDefineGroups'
      ImageIndex = 7
      OnShow = tsDefineGroupsShow
      DesignSize = (
        612
        391)
      object lbDefineGroups: TLabel
        Left = 8
        Top = 64
        Width = 85
        Height = 13
        Caption = 'Promotion Groups'
      end
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label23: TLabel
          Left = 21
          Top = 6
          Width = 79
          Height = 13
          Caption = 'Define Groups'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel7: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object lbDefineGroupsInfo: TLabel
          Left = 45
          Top = 22
          Width = 510
          Height = 27
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = False
          Caption = 'Define the groups of eligible products for the promotion'
          WordWrap = True
        end
        object Image1: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object btAddGroup: TButton
        Left = 8
        Top = 357
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Add'
        TabOrder = 1
        OnClick = btAddGroupClick
      end
      object btDeleteGroup: TButton
        Left = 88
        Top = 357
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Delete'
        TabOrder = 2
        OnClick = btDeleteGroupClick
      end
      object dbgPromotionGroups: TwwDBGrid
        Left = 8
        Top = 80
        Width = 597
        Height = 270
        ControlType.Strings = (
          'MakeChildrenFree;CheckBox;true;false'
          'RecipeChildrenMode;CustomEdit;dbComboRecipeChildrenMode;F')
        Selected.Strings = (
          'SaleGroupID'#9'10'#9'Group Num'
          'Quantity'#9'10'#9'Quantity'
          'Name'#9'20'#9'Name'
          'RecipeChildrenMode'#9'38'#9'Recipe Children Mode'
          'MakeChildrenFree'#9'16'#9'Make Children Free')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = True
        EditControlOptions = [ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsEditPromotionGroups
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFixedResizable]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = dbgPromotionGroupsCalcCellColors
        OnMouseMove = dbgPromotionGroupsMouseMove
        FooterColor = clWindow
        FooterCellColor = clWindow
      end
      object dbComboRecipeChildrenMode: TwwDBComboBox
        Left = 288
        Top = 216
        Width = 121
        Height = 21
        Hint = 'Default hint'
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'RecipeChildrenMode'
        DataSource = dmPromotions.dsEditPromotionGroups
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'Exclude Children From Promotion'#9'0'
          'Select Recipe With Highest Family Price'#9'1'
          'Select Recipe With Lowest Family Price'#9'2')
        ParentShowHint = False
        ShowHint = True
        Sorted = False
        TabOrder = 4
        UnboundDataType = wwDefault
        OnChange = dbComboRecipeChildrenModeChange
      end
    end
    object tsSelectProducts: TTabSheet
      Caption = 'tsSelectProducts'
      ImageIndex = 2
      OnResize = tsSelectProductsResize
      DesignSize = (
        612
        391)
      object Label11: TLabel
        Left = 8
        Top = 64
        Width = 88
        Height = 13
        Caption = 'Available Products'
      end
      object lbSelectedProducts: TLabel
        Left = 272
        Top = 64
        Width = 86
        Height = 13
        Caption = 'Selected Products'
      end
      object sbExcludeAllProducts: TButton
        Left = 240
        Top = 192
        Width = 23
        Height = 22
        Caption = '<<'
        TabOrder = 8
        OnClick = sbExcludeAllProductsClick
      end
      object sbExcludeProduct: TButton
        Left = 240
        Top = 224
        Width = 23
        Height = 22
        Caption = '<'
        TabOrder = 9
        OnClick = sbExcludeProductClick
      end
      object sbIncludeProduct: TButton
        Left = 240
        Top = 128
        Width = 23
        Height = 22
        Caption = '>'
        TabOrder = 6
        OnClick = sbIncludeProductClick
      end
      object sbIncludeAllProducts: TButton
        Left = 240
        Top = 160
        Width = 23
        Height = 22
        Caption = '>>'
        TabOrder = 7
        OnClick = sbIncludeAllProductsClick
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label13: TLabel
          Left = 21
          Top = 6
          Width = 88
          Height = 13
          Caption = 'Select Products'
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
        object lbSelectProductsInfo: TLabel
          Left = 45
          Top = 22
          Width = 235
          Height = 13
          Caption = 'Select the products that the promotion applies to'
        end
        object Image4: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object tvAvailableProducts: TTreeView
        Left = 8
        Top = 80
        Width = 225
        Height = 201
        Anchors = [akLeft, akTop, akBottom]
        Indent = 19
        TabOrder = 1
      end
      object tcProductGroups: TTabControl
        Left = 272
        Top = 80
        Width = 335
        Height = 303
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 10
        OnChange = tcProductGroupsChange
      end
      object grpbxProductFilter: TGroupBox
        Left = 8
        Top = 311
        Width = 242
        Height = 72
        Anchors = [akLeft, akBottom]
        Caption = 'Filter'
        TabOrder = 5
        DesignSize = (
          242
          72)
        object Label2: TLabel
          Left = 8
          Top = 51
          Width = 34
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Portion'
        end
        inline ProductTagFilterFrame: TProductTagFilterFrame
          Left = 8
          Top = 16
          Width = 177
          Height = 25
          Anchors = [akLeft]
          TabOrder = 0
          inherited chkbxFiltered: TCheckBox
            Width = 89
            Caption = 'Product Tags'
          end
          inherited btnTags: TButton
            Left = 106
          end
        end
        object cmbbxPortion: TComboBox
          Left = 113
          Top = 46
          Width = 123
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 2
          Text = '<Select a portion>'
          OnChange = cmbbxPortionChange
        end
        object chkbxPortionFilter: TCheckBox
          Left = 8
          Top = 48
          Width = 89
          Height = 17
          Alignment = taLeftJustify
          Anchors = [akLeft]
          Caption = 'Portion'
          TabOrder = 1
          OnClick = chkbxPortionFilterClick
        end
      end
      object edProductSearchTerm: TEdit
        Tag = 1
        Left = 8
        Top = 286
        Width = 194
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
        TabOrder = 2
        Text = '<Type keywords to search>'
        OnChange = edProductSearchTermChange
        OnEnter = SearchTermEnter
        OnExit = SearchTermExit
      end
      object btProductFindPrev: TButton
        Left = 205
        Top = 285
        Width = 21
        Height = 21
        Action = ProductTreeFindPrev
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object btProductFindNext: TButton
        Left = 228
        Top = 285
        Width = 21
        Height = 21
        Action = ProductTreeFindNext
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
    end
    object tsEventPromotionActions: TTabSheet
      Caption = 'tsEventPromotionActions'
      ImageIndex = 10
      DesignSize = (
        612
        391)
      object Label37: TLabel
        Left = 8
        Top = 64
        Width = 103
        Height = 13
        Caption = 'Available Promotions:'
      end
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label35: TLabel
          Left = 21
          Top = 6
          Width = 104
          Height = 13
          Caption = 'Promotion Actions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel10: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label36: TLabel
          Left = 45
          Top = 22
          Width = 247
          Height = 13
          Caption = 'Select which promotions are active within the event'
        end
        object Image10: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object dbgPromotionActions: TwwDBGrid
        Left = 8
        Top = 80
        Width = 597
        Height = 270
        ControlType.Strings = (
          'Activate;CheckBox;True;False'
          'Enabled;CheckBox;True;False')
        Selected.Strings = (
          'Name'#9'20'#9'Name'
          'Description'#9'31'#9'Description'
          'PromoTypeName'#9'10'#9'Type'
          'Enabled'#9'7'#9'Enabled'
          'Activate'#9'7'#9'Active')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 4
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsEditEventStatus
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFixedResizable]
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
      end
      object btActivateNoPromotions: TButton
        Left = 530
        Top = 360
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Select none'
        TabOrder = 2
        OnClick = btActivateNoPromotionsClick
      end
      object btActivateAllPromotions: TButton
        Left = 449
        Top = 360
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Select all'
        TabOrder = 3
        OnClick = btActivateAllPromotionsClick
      end
      inline PromotionFilterFrame: TPromotionFilterFrame
        Left = 8
        Top = 357
        Width = 435
        Height = 29
        HorzScrollBar.Visible = False
        VertScrollBar.Visible = False
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 4
        DesignSize = (
          435
          29)
        inherited FilterPanel: TPanel
          Width = 431
          DesignSize = (
            431
            29)
          inherited Bevel1: TBevel
            Left = 70
          end
          inherited lblSiteFilter: TLabel
            Width = 58
          end
          inherited edtFilter: TEdit
            Left = 78
            Width = 246
          end
          inherited chkbxMidwordSearch: TCheckBox
            Left = 328
          end
        end
      end
      object cbHideDisabledPromotions: TCheckBox
        Left = 351
        Top = 61
        Width = 139
        Height = 17
        Caption = 'Hide disabled promotions'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = cbHideDisabledPromotionsClick
      end
    end
    object tsPromoActivation: TTabSheet
      Caption = 'tsDatesTimes2'
      ImageIndex = 12
      object lblStartDate: TLabel
        Left = 8
        Top = 74
        Width = 53
        Height = 13
        Caption = 'Start date:'
      end
      object lblEndDate: TLabel
        Left = 182
        Top = 74
        Width = 47
        Height = 13
        Caption = 'End date:'
      end
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label38: TLabel
          Left = 21
          Top = 6
          Width = 100
          Height = 13
          Caption = 'Activation Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel12: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label41: TLabel
          Left = 45
          Top = 22
          Width = 262
          Height = 13
          Caption = 'Define at what dates and times the promotion is active'
        end
        object Image12: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object chkbxAllTimes: TCheckBox
        Left = 356
        Top = 72
        Width = 153
        Height = 17
        Caption = 'Promotion runs at all times'
        TabOrder = 1
        OnClick = chkbxAllTimesClick
      end
      object gbxActiveTimes: TGroupBox
        Left = 4
        Top = 97
        Width = 497
        Height = 213
        TabOrder = 2
        object btnNewTimePeriod: TButton
          Left = 215
          Top = 182
          Width = 98
          Height = 25
          Caption = '&New Time Period'
          TabOrder = 0
          OnClick = btnNewTimePeriodClick
        end
        object btnDeleteTimePeriod: TButton
          Left = 392
          Top = 182
          Width = 98
          Height = 25
          Caption = '&Delete Time Period'
          TabOrder = 1
          OnClick = btnDeleteTimePeriodClick
        end
        object pnlTimePeriodEdit: TPanel
          Left = 7
          Top = 11
          Width = 194
          Height = 196
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 2
          object Label45: TLabel
            Left = 6
            Top = 3
            Width = 60
            Height = 13
            Caption = 'Days active:'
          end
          object lblStartTime: TLabel
            Left = 102
            Top = 24
            Width = 51
            Height = 13
            Caption = 'Start time:'
          end
          object lblEndTime: TLabel
            Left = 101
            Top = 80
            Width = 45
            Height = 13
            Caption = 'End time:'
          end
          object dtStartTime: TDateTimePicker
            Left = 100
            Top = 40
            Width = 70
            Height = 21
            CalAlignment = dtaLeft
            Date = 40137.5893892014
            Format = 'HH:mm'
            Time = 40137.5893892014
            DateFormat = dfShort
            DateMode = dmComboBox
            Kind = dtkTime
            ParseInput = False
            TabOrder = 0
            OnChange = dtStartTimeChange
          end
          object dtEndTime: TDateTimePicker
            Left = 100
            Top = 96
            Width = 70
            Height = 21
            Hint = 
              'The final minute the promotion will run. Example: To end as 19:0' +
              '0 strikes enter 16:59'
            CalAlignment = dtaLeft
            Date = 40137.5893895602
            Format = 'HH:mm'
            Time = 40137.5893895602
            DateFormat = dfShort
            DateMode = dmComboBox
            Kind = dtkTime
            ParseInput = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnChange = dtEndTimeChange
          end
          object clbValidDays: TCheckListBox
            Left = 5
            Top = 19
            Width = 78
            Height = 170
            OnClickCheck = clbValidDaysClickCheck
            BorderStyle = bsNone
            Color = clBtnFace
            Ctl3D = True
            Flat = False
            ItemHeight = 24
            Items.Strings = (
              'Monday'
              'Tuesday'
              'Wednesday'
              'Thursday'
              'Friday'
              'Saturday'
              'Sunday')
            ParentCtl3D = False
            Style = lbOwnerDrawFixed
            TabOrder = 2
          end
        end
        object dbgridValidTimes: TwwDBGrid
          Left = 214
          Top = 11
          Width = 277
          Height = 165
          Selected.Strings = (
            'ValidDaysDisplay'#9'24'#9'Days active'#9#9
            'StartTime'#9'7'#9' Start'#9#9
            'EndTime'#9'7'#9' End'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Color = clInactiveCaption
          DataSource = dsValidTimes
          KeyOptions = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          TabOrder = 3
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Shell Dlg 2'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
        end
      end
      object dtStartDate: TDateTimePicker
        Left = 68
        Top = 71
        Width = 100
        Height = 21
        CalAlignment = dtaLeft
        Date = 45089.6312155556
        Time = 45089.6312155556
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 3
      end
      object dtEndDate: TDateTimePicker
        Left = 236
        Top = 72
        Width = 100
        Height = 21
        CalAlignment = dtaLeft
        Date = 45090.5658405556
        Time = 45090.5658405556
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 4
        OnClick = dtEndDateClick
        OnKeyDown = dtEndDateKeyDown
      end
    end
    object tsExceptions: TTabSheet
      Caption = 'tsExceptions'
      ImageIndex = 8
      OnResize = tsExceptionsResize
      OnShow = tsExceptionsShow
      DesignSize = (
        612
        391)
      object Label32: TLabel
        Left = 8
        Top = 64
        Width = 107
        Height = 13
        Caption = 'Activation exceptions:'
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label26: TLabel
          Left = 21
          Top = 6
          Width = 61
          Height = 13
          Caption = 'Exceptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel8: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object lbExceptionsInfo: TLabel
          Left = 45
          Top = 22
          Width = 400
          Height = 13
          Caption = 
            'Define exceptions to the products and activation rules for a set' +
            ' of sites/sales areas'
        end
        object Image8: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object btNewException: TButton
        Left = 8
        Top = 357
        Width = 75
        Height = 25
        Action = NewException
        Anchors = [akLeft, akBottom]
        TabOrder = 1
      end
      object btDeleteException: TButton
        Left = 328
        Top = 357
        Width = 75
        Height = 25
        Action = DeleteException
        Anchors = [akLeft, akBottom]
        TabOrder = 2
      end
      object btEditException: TButton
        Left = 88
        Top = 357
        Width = 75
        Height = 25
        Action = EditException
        Anchors = [akLeft, akBottom]
        TabOrder = 3
      end
      object btCopyException: TButton
        Left = 168
        Top = 357
        Width = 75
        Height = 25
        Action = CopyException
        Anchors = [akLeft, akBottom]
        TabOrder = 4
      end
      object btEnableDisable: TButton
        Left = 248
        Top = 357
        Width = 75
        Height = 25
        Action = DisableException
        Anchors = [akLeft, akBottom]
        TabOrder = 5
      end
      object cbHideDisabledExceptions: TCheckBox
        Left = 8
        Top = 333
        Width = 161
        Height = 17
        Action = HideDisabledExceptions
        Anchors = [akLeft, akBottom]
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object dbgrdExceptions: TwwDBGrid
        Left = 8
        Top = 80
        Width = 597
        Height = 246
        Selected.Strings = (
          'Name'#9'16'#9'Name'#9'F'
          'Description'#9'48'#9'Description'#9'F'
          'Name_1'#9'10'#9'Status'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsEditPromotionExceptions
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgFixedResizable]
        ReadOnly = True
        TabOrder = 7
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = True
        UseTFields = False
        OnTitleButtonClick = dbgrdExceptionsTitleButtonClick
        OnDrawDataCell = dbgrdExceptionsDrawDataCell
        OnDblClick = EditExceptionExecute
      end
    end
    object tsSingleRewardPrice: TTabSheet
      Caption = 'tsSingleRewardPrice'
      ImageIndex = 4
      DesignSize = (
        612
        391)
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label17: TLabel
          Left = 21
          Top = 6
          Width = 74
          Height = 13
          Caption = 'Reward Price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel4: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label18: TLabel
          Left = 45
          Top = 22
          Width = 286
          Height = 13
          Caption = 'Set a single reward price for all sites, or define for each site'
        end
        object Image5: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object rbSingleRewardPrice: TRadioButton
        Left = 8
        Top = 64
        Width = 113
        Height = 17
        Action = SetRewardPriceMode
        Caption = 'Single reward price'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbPerSalesAreaRewardPrice: TRadioButton
        Left = 8
        Top = 104
        Width = 161
        Height = 17
        Action = SetRewardPriceMode
        Caption = 'Reward price per sales area'
        TabOrder = 2
      end
      object rbDefinePricesLater: TRadioButton
        Left = 8
        Top = 365
        Width = 161
        Height = 17
        Action = SetRewardPriceMode
        Anchors = [akLeft, akBottom]
        Caption = 'Define prices later'
        TabOrder = 3
      end
      object dbedRewardPrice: TDBEdit
        Left = 24
        Top = 80
        Width = 121
        Height = 21
        DataField = 'SingleRewardPrice'
        DataSource = dmPromotions.dsEditSingleRewardPrice
        TabOrder = 4
        OnKeyPress = dbedRewardPriceKeyPress
      end
      object btRewardPriceImport: TButton
        Left = 530
        Top = 341
        Width = 75
        Height = 23
        Action = RewardPriceImport
        Anchors = [akRight, akBottom]
        TabOrder = 5
      end
      object btRewardPriceExport: TButton
        Left = 450
        Top = 341
        Width = 75
        Height = 23
        Action = RewardPriceExport
        Anchors = [akRight, akBottom]
        TabOrder = 6
      end
      object dbgRewardPrices: TwwDBGrid
        Left = 24
        Top = 120
        Width = 581
        Height = 214
        Selected.Strings = (
          'SiteRef'#9'10'#9'Site Ref'#9'F'
          'SiteName'#9'20'#9'Site Name'#9'F'
          'SalesAreaName'#9'20'#9'Sales Area Name'#9'F'
          'RewardPrice'#9'10'#9'Reward Price'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 3
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsEditSalesAreaRewardPrice
        KeyOptions = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgFixedResizable]
        TabOrder = 7
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnKeyPress = GridPriceKeyPress
      end
      object btnRewardPriceIncDec: TButton
        Left = 370
        Top = 341
        Width = 75
        Height = 23
        Action = RewardPriceIncDec
        Anchors = [akRight, akBottom]
        TabOrder = 8
      end
    end
    object tsGroupPriceMethod: TTabSheet
      Caption = 'tsGroupPriceMethod'
      ImageIndex = 6
      DesignSize = (
        612
        391)
      object Label28: TLabel
        Left = 8
        Top = 64
        Width = 96
        Height = 13
        Caption = 'Group price settings'
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label19: TLabel
          Left = 21
          Top = 6
          Width = 85
          Height = 13
          Caption = 'Pricing method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel5: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label20: TLabel
          Left = 45
          Top = 22
          Width = 302
          Height = 13
          Caption = 'Select how you want to define prices for each promotion group'
        end
        object Image6: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object cbLeaveUnpriced: TCheckBox
        Left = 8
        Top = 365
        Width = 121
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Define prices later'
        TabOrder = 1
      end
      object sbPromoGroupPriceMethod: TScrollBox
        Left = 8
        Top = 80
        Width = 597
        Height = 278
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelInner = bvLowered
        BevelKind = bkSoft
        BevelWidth = 2
        BorderStyle = bsNone
        TabOrder = 2
      end
    end
    object tsPortionPriceMappings: TTabSheet
      Caption = 'tsPortionPriceMappings'
      ImageIndex = 11
      DesignSize = (
        612
        391)
      object lblPortionPriceMapping: TLabel
        Left = 8
        Top = 64
        Width = 108
        Height = 13
        Caption = 'Portion price mappings'
      end
      object pnlPortionPriceMappingTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 4
        DesignSize = (
          612
          60)
        object Bevel2: TBevel
          Left = -2
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object lblDefinePortionPriceMappings: TLabel
          Left = 21
          Top = 6
          Width = 168
          Height = 13
          Caption = 'Define Portion Price Mappings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPromotionPriceGroupingInfo: TLabel
          Left = 45
          Top = 22
          Width = 510
          Height = 27
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = False
          Caption = 'Define portion prices in terms of other portions prices.'
          WordWrap = True
        end
      end
      object dbgPortionPriceMapping: TwwDBGrid
        Left = 8
        Top = 80
        Width = 594
        Height = 278
        ControlType.Strings = (
          'SaleGroupId;CustomEdit;dblSalesGroup;F'
          'CalculationType;CustomEdit;dblCalculationType;F'
          'CalculationTypeLookup;CustomEdit;dblCalculationType;F'
          'SourcePortionTypeLookup;CustomEdit;dblPortionName;F'
          'TargetPortionTypeLookup;CustomEdit;dblPortionName;F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clBtnFace
        Ctl3D = True
        DataSource = dmPromotions.dsEditPromoPortionPriceMapping
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint, dgHideBottomDataLine]
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnDblClick = dbgPortionPriceMappingDblClick
        OnKeyDown = dbgPortionPriceMappingKeyDown
        PadColumnStyle = pcsPlain
      end
      object btnAddPortionPriceMapping: TButton
        Left = 8
        Top = 361
        Width = 75
        Height = 25
        Action = actAddPortionPriceMapping
        Anchors = [akLeft, akBottom]
        TabOrder = 1
      end
      object btEditPortionPriceMapping: TButton
        Left = 88
        Top = 361
        Width = 75
        Height = 25
        Action = actEditPortionPriceMapping
        Anchors = [akLeft, akBottom]
        TabOrder = 2
      end
      object btnDeletePortionPricemapping: TButton
        Left = 168
        Top = 361
        Width = 75
        Height = 25
        Action = actDeletePortionPriceMapping
        Anchors = [akLeft, akBottom]
        TabOrder = 3
      end
    end
    object tsGroupPrices: TTabSheet
      Caption = 'tsGroupPrices'
      ImageIndex = 7
      DesignSize = (
        612
        391)
      object Label29: TLabel
        Left = 8
        Top = 64
        Width = 29
        Height = 13
        Caption = 'Group'
      end
      object Label30: TLabel
        Left = 188
        Top = 64
        Width = 73
        Height = 13
        Caption = 'Site/Sales Area'
      end
      object Label33: TLabel
        Left = 8
        Top = 104
        Width = 28
        Height = 13
        Caption = 'Prices'
      end
      object lbPriceHighlightLegend: TLabel
        Left = 8
        Top = 361
        Width = 174
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '* = Price differs from standard price'
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label21: TLabel
          Left = 21
          Top = 6
          Width = 106
          Height = 13
          Caption = 'Review/edit prices'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel6: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object lbGroupPricesInfo: TLabel
          Left = 45
          Top = 22
          Width = 289
          Height = 13
          Caption = 'Review or edit the effective prices for all products or groups'
        end
        object Image7: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object btPriceExport: TButton
        Left = 449
        Top = 357
        Width = 75
        Height = 23
        Action = GroupPriceExport
        Anchors = [akRight, akBottom]
        TabOrder = 1
      end
      object btPriceImport: TButton
        Left = 529
        Top = 357
        Width = 75
        Height = 23
        Action = GroupPriceImport
        Anchors = [akRight, akBottom]
        TabOrder = 2
      end
      object cbEditPriceGroup: TComboBox
        Left = 8
        Top = 80
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnCloseUp = cbEditPriceGroupCloseUp
      end
      object cbEditPriceSA: TComboBox
        Left = 188
        Top = 80
        Width = 225
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnCloseUp = cbEditPriceGroupCloseUp
      end
      object dbgPromoPrices: TwwDBGrid
        Left = 8
        Top = 120
        Width = 597
        Height = 230
        Selected.Strings = (
          'SaleGroupID'#9'3'#9'Grp'
          'SiteRef'#9'5'#9'S.Ref.'#9'F'
          'SiteName'#9'15'#9'Site Name'#9'F'
          'SalesAreaName'#9'9'#9'Sales Area'#9'F'
          'ProductName'#9'16'#9'Product'#9'F'
          'ProductDescription'#9'16'#9'Description'#9'F'
          'PortionTypeName'#9'9'#9'Portion'#9'F'
          'TariffPrice'#9'7'#9'Std. Price'#9'F'
          'Price'#9'7'#9'Price'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnMultiSelectRecord = dbgPromoPricesMultiSelectRecord
        OnRowChanged = dbgPromoPricesRowChanged
        FixedCols = 8
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsEditPromoPrice
        KeyOptions = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgFixedResizable]
        TabOrder = 5
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = dbgPromoPricesCalcCellColors
        OnDrawDataCell = dbgPromoPricesDrawDataCell
        OnKeyPress = GridPriceKeyPress
      end
      object btnPriceIncDec: TButton
        Left = 369
        Top = 357
        Width = 75
        Height = 23
        Action = GroupPriceIncDec
        Anchors = [akRight, akBottom]
        TabOrder = 6
      end
    end
    object tsFinish: TTabSheet
      Caption = 'tsFinish'
      ImageIndex = 9
      DesignSize = (
        612
        391)
      object Label34: TLabel
        Left = 8
        Top = 72
        Width = 310
        Height = 26
        Caption = 
          'You have entered all required details for the Promotion.'#13#10'Click ' +
          'Back to review details, or click Finish to save the Promotion.'
      end
      object lbDuplicateWarning: TLabel
        Left = 8
        Top = 112
        Width = 595
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          'Warning: This Promotion has one or more products in common with ' +
          'other Promotions. '#13#10'Check the Promotion status and priorities to' +
          ' make sure this Promotion will work as intended.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        WordWrap = True
      end
      object lbOtherUserChangesWarning: TLabel
        Left = 8
        Top = 152
        Width = 595
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          'Warning: Another user has made changes to this Promotion while t' +
          'he wizard was running. '#13#10'Select Finish to overwrite their change' +
          's or Close if you want to review their changes first.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        WordWrap = True
      end
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Label10: TLabel
          Left = 21
          Top = 6
          Width = 46
          Height = 13
          Caption = 'Finished'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel9: TBevel
          Left = -1
          Top = 58
          Width = 614
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label12: TLabel
          Left = 45
          Top = 22
          Width = 3
          Height = 13
        end
        object Image9: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
    end
  end
  object btnBack: TButton
    Left = 368
    Top = 403
    Width = 75
    Height = 23
    Action = PrevPage
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object btnNext: TButton
    Left = 444
    Top = 403
    Width = 75
    Height = 23
    Action = NextPage
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 3
  end
  object btClose: TButton
    Left = 530
    Top = 403
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 4
    OnClick = btCloseClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 390
    Width = 612
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object PromotionActions: TActionList
    OnExecute = PromotionActionsExecute
    Left = 456
    Top = 16
    object NextPage: TAction
      Caption = 'Next'
      OnExecute = NextPageExecute
    end
    object PrevPage: TAction
      Caption = 'Back'
      OnExecute = PrevPageExecute
    end
    object SetRewardPriceMode: TAction
      Caption = 'SetRewardPriceMode'
      OnExecute = SetRewardPriceModeExecute
    end
    object RewardPriceExport: TAction
      Caption = 'Export'
      OnExecute = RewardPriceExportExecute
      OnUpdate = RewardPriceExportUpdate
    end
    object RewardPriceImport: TAction
      Caption = 'Import'
      OnExecute = RewardPriceImportExecute
      OnUpdate = RewardPriceImportUpdate
    end
    object GroupPriceExport: TAction
      Caption = 'Export'
      OnExecute = GroupPriceExportExecute
      OnUpdate = GroupPriceExportUpdate
    end
    object GroupPriceImport: TAction
      Caption = 'Import'
      OnExecute = GroupPriceImportExecute
      OnUpdate = GroupPriceImportUpdate
    end
    object DisableException: TAction
      Caption = 'Disable'
      OnExecute = DisableExceptionExecute
      OnUpdate = DisableExceptionUpdate
    end
    object DeleteException: TAction
      Caption = 'Delete'
      OnExecute = DeleteExceptionExecute
      OnUpdate = ExceptionButtonUpdate
    end
    object CopyException: TAction
      Caption = 'Copy'
      OnExecute = CopyExceptionExecute
      OnUpdate = ExceptionButtonUpdate
    end
    object HideDisabledExceptions: TAction
      Caption = 'Hide disabled exceptions'
      OnExecute = HideDisabledExceptionsExecute
    end
    object EditException: TAction
      Caption = 'Edit'
      OnExecute = EditExceptionExecute
      OnUpdate = ExceptionButtonUpdate
    end
    object NewException: TAction
      Caption = 'New'
      OnExecute = NewExceptionExecute
    end
    object SATreeFindPrev: TAction
      Caption = '<'
    end
    object SATreeFindNext: TAction
      Caption = '>'
    end
    object ProductTreeFindPrev: TAction
      Caption = '<'
      OnExecute = ProductTreeFindPrevExecute
      OnUpdate = ProductTreeFindUpdate
    end
    object ProductTreeFindNext: TAction
      Caption = '>'
      OnExecute = ProductTreeFindNextExecute
      OnUpdate = ProductTreeFindUpdate
    end
    object GroupPriceIncDec: TAction
      Caption = '+/-'
      OnExecute = GroupPriceIncDecExecute
      OnUpdate = GroupPriceIncDecUpdate
    end
    object RewardPriceIncDec: TAction
      Caption = '+/-'
      OnExecute = RewardPriceIncDecExecute
      OnUpdate = RewardPriceIncDecUpdate
    end
    object actLoyaltyPromotion: TAction
      AutoCheck = True
      Caption = 'Loyalty promotion'
      OnExecute = actLoyaltyPromotionExecute
    end
    object actAddPortionPriceMapping: TAction
      Caption = 'Add'
      OnExecute = actAddPortionPriceMappingExecute
    end
    object actEditPortionPriceMapping: TAction
      Caption = 'Edit'
      OnExecute = actEditPortionPriceMappingExecute
      OnUpdate = actEditPortionPriceMappingUpdate
    end
    object actDeletePortionPriceMapping: TAction
      Caption = 'Delete'
      OnExecute = actDeletePortionPriceMappingExecute
      OnUpdate = actDeletePortionPriceMappingUpdate
    end
  end
  object dstValidTimes: TADODataSet
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    AfterScroll = dstValidTimesAfterScroll
    OnCalcFields = dstValidTimesCalcFields
    CommandText = 
      'SELECT DisplayOrder, ValidDays, StartTime, EndTime'#13#10'FROM #Promot' +
      'ionTimeCycles'#13#10'ORDER BY DisplayOrder'
    Parameters = <>
    Top = 32
    object dstValidTimesValidDaysDisplay: TStringField
      DisplayLabel = 'Days active'
      DisplayWidth = 24
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      Size = 35
      Calculated = True
    end
    object dstValidTimesStartTime: TDateTimeField
      DisplayLabel = ' Start'
      DisplayWidth = 7
      FieldName = 'StartTime'
      DisplayFormat = 'hh:mm'
    end
    object dstValidTimesEndTime: TDateTimeField
      DisplayLabel = ' End'
      DisplayWidth = 7
      FieldName = 'EndTime'
      DisplayFormat = 'hh:mm'
    end
    object dstValidTimesValidDays: TStringField
      DisplayWidth = 7
      FieldName = 'ValidDays'
      Visible = False
      Size = 7
    end
  end
  object dsValidTimes: TDataSource
    DataSet = dstValidTimes
    Left = 32
    Top = 32
  end
end
