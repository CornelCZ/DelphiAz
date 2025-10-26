object PromotionalFooterWizard: TPromotionalFooterWizard
  Left = 683
  Top = 316
  Width = 620
  Height = 373
  HelpContext = 5082
  Caption = 'Promotional Footer Wizard'
  Color = clBtnFace
  Constraints.MinHeight = 373
  Constraints.MinWidth = 620
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    604
    335)
  PixelsPerInch = 96
  TextHeight = 13
  object pcFooterWizard: TPageControl
    Left = -4
    Top = -7
    Width = 620
    Height = 324
    ActivePage = tsFooterDetails
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabHeight = 1
    TabOrder = 0
    object tsFooterDetails: TTabSheet
      Caption = 'tsFooterDetails'
      TabVisible = False
      DesignSize = (
        612
        313)
      object lblName: TLabel
        Left = 153
        Top = 62
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblDescription: TLabel
        Left = 153
        Top = 101
        Width = 57
        Height = 13
        Caption = 'Description:'
      end
      object lblWizardName: TLabel
        Left = 153
        Top = 5
        Width = 159
        Height = 23
        Caption = 'New Footer Wizard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblWizardDescription: TLabel
        Left = 153
        Top = 29
        Width = 440
        Height = 36
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of setting up a n' +
          'ew footer.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lblPOSNotificationText: TLabel
        Left = 153
        Top = 165
        Width = 230
        Height = 13
        Caption = 'Terminal Notification Text (max. 40 characters):'
      end
      object lblPrintWith: TLabel
        Left = 419
        Top = 215
        Width = 49
        Height = 13
        Caption = 'Print with:'
      end
      object pnlLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 4
        object imZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object edtName: TEdit
        Left = 153
        Top = 76
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 40
        TabOrder = 0
      end
      object mmDescription: TMemo
        Left = 153
        Top = 115
        Width = 444
        Height = 45
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 256
        TabOrder = 1
      end
      object gbPrintFrequency: TGroupBox
        Left = 153
        Top = 207
        Width = 257
        Height = 57
        Caption = 'Print Frequency'
        TabOrder = 2
        object lblOccurrances: TLabel
          Left = 187
          Top = 31
          Width = 62
          Height = 13
          Caption = 'occurrences.'
        end
        object rbAlwaysPrint: TRadioButton
          Left = 8
          Top = 14
          Width = 85
          Height = 17
          Caption = 'Always print'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbPrintEveryNth: TRadioButton
          Left = 8
          Top = 31
          Width = 97
          Height = 17
          Caption = 'Print after every '
          TabOrder = 1
        end
        object sePrintFrequency: TSpinEdit
          Left = 108
          Top = 29
          Width = 73
          Height = 22
          MaxValue = 10000000
          MinValue = 2
          TabOrder = 2
          Value = 2
          OnChange = sePrintFrequencyChange
          OnKeyPress = sePrintFrequencyKeyPress
        end
      end
      object cbSeparateFromReceipt: TCheckBox
        Left = 417
        Top = 238
        Width = 180
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Separate footer from receipt:'
        TabOrder = 3
      end
      object edtEPoSNotificationText: TEdit
        Left = 153
        Top = 180
        Width = 445
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 40
        TabOrder = 5
      end
      object pnlPrintMultipleFooters: TPanel
        Left = 414
        Top = 257
        Width = 184
        Height = 19
        Hint = 
          'The option '#39'Print multiple footers'#39' may only be'#13#10'used in conjunc' +
          'tion with one sale group.'
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 6
        object cbPrintMultipleFooters: TCheckBox
          Left = 3
          Top = 1
          Width = 180
          Height = 17
          Hint = 
            'The option '#39'Print multiple footers'#39' may only be'#13#10'used in conjunc' +
            'tion with one sale group.'
          Alignment = taLeftJustify
          Caption = 'Print multiple footers.'
          TabOrder = 0
        end
      end
      object pnlPrintVoucherCode: TPanel
        Left = 152
        Top = 270
        Width = 257
        Height = 38
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 7
        object lblCampaignID: TLabel
          Left = 8
          Top = 15
          Width = 65
          Height = 13
          Caption = 'Campaign ID:'
          Enabled = False
        end
        object edtCampaignID: TEdit
          Left = 76
          Top = 11
          Width = 173
          Height = 21
          Enabled = False
          MaxLength = 10
          TabOrder = 0
          OnKeyPress = edtCampaignIDKeyPress
        end
      end
      object cbPrintVoucherCode: TCheckBox
        Left = 160
        Top = 264
        Width = 113
        Height = 17
        Caption = 'Print Voucher Code'
        TabOrder = 8
        OnClick = cbPrintVoucherCodeClick
      end
      object dblcPrintWith: TDBLookupComboBox
        Left = 472
        Top = 212
        Width = 127
        Height = 21
        DataField = 'PrintWithSlipType'
        DataSource = dmPromotionalFooter.dsEditPromotionalFooter
        KeyField = 'Id'
        ListField = 'value'
        ListSource = dmPromotionalFooter.dsSlipType
        TabOrder = 9
      end
    end
    object tsFooterOverride: TTabSheet
      Caption = 'tsFooterOverride'
      ImageIndex = 9
      OnShow = tsFooterOverrideShow
      DesignSize = (
        612
        313)
      object lblOverrideWizardName: TLabel
        Left = 153
        Top = 21
        Width = 235
        Height = 23
        Caption = 'Override Footer Text Wizard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblOverrideWizardDesc: TLabel
        Left = 153
        Top = 45
        Width = 440
        Height = 29
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of overriding pro' +
          'motional footer text.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object pnlSiteLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 0
        object imgSiteZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object dbgFooterOverrides: TwwDBGrid
        Left = 156
        Top = 68
        Width = 445
        Height = 201
        Selected.Strings = (
          'OverrideName'#9'70'#9'Name')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotionalFooter.dsSiteFooterOverride
        Enabled = False
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint, dgTabExitsOnLastCol, dgHideBottomDataLine]
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        PadColumnStyle = pcsPlain
      end
      object Button3: TButton
        Left = 156
        Top = 280
        Width = 75
        Height = 25
        Action = actAddOverride
        Anchors = [akLeft, akBottom]
        TabOrder = 2
      end
      object btnDeleteOverride: TButton
        Left = 236
        Top = 280
        Width = 75
        Height = 25
        Action = actDeleteOverride
        Anchors = [akLeft, akBottom]
        TabOrder = 3
      end
    end
    object tsSalesAreas: TTabSheet
      Caption = 'tsSalesAreas'
      ImageIndex = 1
      OnResize = tsSalesAreasResize
      DesignSize = (
        612
        313)
      object bvlSelectSites: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblAvailableSA: TLabel
        Left = 8
        Top = 64
        Width = 130
        Height = 13
        Caption = 'Available sites/sales areas:'
      end
      object lblSelectedSA: TLabel
        Left = 280
        Top = 64
        Width = 128
        Height = 13
        Caption = 'Selected sites/sales areas:'
      end
      object pnlSalesAreaTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgSelectSites: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblSelectSites: TLabel
          Left = 20
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
        object lblSelectSitesDesc: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Select the sites and/or sales areas to which the footer applies.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object tvAvailableSA: TTreeView
        Left = 8
        Top = 80
        Width = 225
        Height = 202
        Anchors = [akLeft, akTop, akRight, akBottom]
        Indent = 19
        TabOrder = 1
      end
      object tvSelectedSA: TTreeView
        Left = 280
        Top = 80
        Width = 325
        Height = 226
        Anchors = [akTop, akRight, akBottom]
        Indent = 19
        TabOrder = 2
      end
      object edtSASearch: TEdit
        Tag = 1
        Left = 8
        Top = 284
        Width = 183
        Height = 21
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '<Type keywords to search>'
        OnChange = edtSASearchChange
        OnEnter = SearchEnter
        OnExit = SearchExit
      end
      object btnFindPrevSA: TButton
        Left = 190
        Top = 284
        Width = 21
        Height = 21
        Action = actFindPrevSA
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object btnIncludeSA: TButton
        Left = 246
        Top = 126
        Width = 23
        Height = 23
        Action = actIncludeSA
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object btnIncludeAllSA: TButton
        Left = 246
        Top = 157
        Width = 23
        Height = 23
        Action = actIncludeAllSA
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object btnRemoveAllSA: TButton
        Left = 246
        Top = 188
        Width = 23
        Height = 23
        Action = actRemoveAllSA
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object btnRemoveSA: TButton
        Left = 246
        Top = 219
        Width = 23
        Height = 23
        Action = actRemoveSA
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object btnFindNextSA: TButton
        Left = 212
        Top = 284
        Width = 21
        Height = 21
        Action = actFindNextSA
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object tsSalesGroups: TTabSheet
      Caption = 'tsSalesGroups'
      ImageIndex = 4
      DesignSize = (
        612
        313)
      object bvlDefineGroups: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblSaleGroups: TLabel
        Left = 8
        Top = 64
        Width = 60
        Height = 13
        Caption = 'Sale groups:'
      end
      object pnlDefineGroupsTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgDefineGroups: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblDefineGroups: TLabel
          Left = 20
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
        object lblDefineGroupsDesc: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 
            'Define any specifc groups of products that will be eligible for ' +
            'this footer.  If no groups are defined all products will be cons' +
            'idered to be elligible.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
      object dbgSaleGroups: TwwDBGrid
        Left = 8
        Top = 80
        Width = 598
        Height = 194
        ControlType.Strings = (
          'SaleGrouptypeLookup;CustomEdit;luSaleGroupType;F')
        PictureMasks.Strings = (
          'Value'#9'#*#[.]*2[#]'#9'T'#9'T')
        Selected.Strings = (
          'SaleGroupId'#9'68'#9'Sale Group ID'#9#9
          'SaleGrouptypeLookup'#9'15'#9'Sale Group Type'#9#9
          'Value'#9'10'#9'Value'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotionalFooter.dsEditFooterSaleGroups
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        PadColumnStyle = pcsPlain
      end
      object luSaleGroupType: TwwDBLookupCombo
        Left = 324
        Top = 36
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'15'#9'Name'#9#9)
        DataField = 'SaleGroupType'
        DataSource = dmPromotionalFooter.dsEditFooterSaleGroups
        LookupTable = dmPromotionalFooter.qFooterSaleGroupType
        LookupField = 'Name'
        Style = csDropDownList
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object pnlAddSaleGroup: TPanel
        Left = 8
        Top = 278
        Width = 76
        Height = 29
        Hint = 
          'Only one Sale Group is permitted when the option'#13#10#39'Print multipl' +
          'e footers'#39' has been selected.'
        Anchors = [akLeft, akBottom]
        BevelOuter = bvNone
        TabOrder = 3
        DesignSize = (
          76
          29)
        object btnAddSaleGroup: TButton
          Left = 0
          Top = 2
          Width = 75
          Height = 25
          Action = actAddSalesGroup
          Anchors = [akLeft, akBottom]
          TabOrder = 0
        end
      end
      object pnlDeleteSaleGroup: TPanel
        Left = 88
        Top = 278
        Width = 76
        Height = 29
        Anchors = [akLeft, akBottom]
        BevelOuter = bvNone
        TabOrder = 4
        DesignSize = (
          76
          29)
        object btnDeleteSaleGroup: TButton
          Left = 0
          Top = 2
          Width = 75
          Height = 25
          Action = actDeleteSalesGroup
          Anchors = [akLeft, akBottom]
          TabOrder = 0
        end
      end
    end
    object tsSalesGroupProducts: TTabSheet
      Caption = 'tsSalesGroupProducts'
      ImageIndex = 3
      OnResize = tsSalesGroupProductsResize
      DesignSize = (
        612
        313)
      object bvlSelectProducts: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
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
      object pnlSelectProductsTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgSelectProducts: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblSelectProducts: TLabel
          Left = 20
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
        object lblSelectProductsDesc: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Select the products to which the footer applies.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object btnExcludeAllProducts: TButton
        Left = 241
        Top = 192
        Width = 23
        Height = 23
        Action = actRemoveAllProducts
        Anchors = [akTop, akRight]
        TabOrder = 8
      end
      object btnExcludeProduct: TButton
        Left = 241
        Top = 224
        Width = 23
        Height = 23
        Action = actRemoveProduct
        Anchors = [akTop, akRight]
        TabOrder = 9
      end
      object btnIncludeProduct: TButton
        Left = 241
        Top = 128
        Width = 23
        Height = 23
        Action = actIncludeProduct
        Anchors = [akTop, akRight]
        TabOrder = 6
      end
      object btnIncludeAllProducts: TButton
        Left = 241
        Top = 160
        Width = 23
        Height = 23
        Action = actIncludeAllProducts
        Anchors = [akTop, akRight]
        TabOrder = 7
      end
      object tvAvailableProducts: TTreeView
        Left = 8
        Top = 80
        Width = 225
        Height = 202
        Anchors = [akLeft, akTop, akBottom]
        Indent = 19
        TabOrder = 1
      end
      object tcSalesGroupProducts: TTabControl
        Left = 272
        Top = 80
        Width = 335
        Height = 226
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 2
        OnChange = tcSalesGroupProductsChange
      end
      object btProductFindNext: TButton
        Left = 213
        Top = 285
        Width = 21
        Height = 21
        Action = actFindNextProduct
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object btProductFindPrev: TButton
        Left = 191
        Top = 285
        Width = 21
        Height = 21
        Action = actFindPrevProduct
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object edtProductSearchTerm: TEdit
        Tag = 1
        Left = 8
        Top = 285
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
        TabOrder = 3
        Text = '<Type keywords to search>'
        OnChange = edtProductSearchTermChange
        OnEnter = SearchEnter
        OnExit = SearchExit
      end
    end
    object tsPromotionTriggers: TTabSheet
      Caption = 'tsPromotionTriggers'
      ImageIndex = 8
      OnResize = tsPromotionTriggersResize
      DesignSize = (
        612
        313)
      object bvlPromotions: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblPromotionList: TLabel
        Left = 8
        Top = 64
        Width = 103
        Height = 13
        Caption = 'Available Promotions:'
      end
      object lblSelectedPromotions: TLabel
        Left = 323
        Top = 64
        Width = 101
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Selected Promotions:'
      end
      object pnlPromotionsTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgPromotions: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblPromotions: TLabel
          Left = 20
          Top = 6
          Width = 65
          Height = 13
          Caption = 'Promotions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPromotionsDescription: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 
            'Choose which Promotions must also fire in order to initiate the ' +
            'printing of this footer.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object btnIncludePromotion: TButton
        Left = 294
        Top = 158
        Width = 23
        Height = 23
        Action = actIncludePromotion
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object btnRemovePromotion: TButton
        Left = 294
        Top = 187
        Width = 23
        Height = 23
        Action = actRemovePromotion
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object lbAvailablepromotions: TListBox
        Left = 8
        Top = 80
        Width = 280
        Height = 201
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akBottom]
        ExtendedSelect = False
        ItemHeight = 16
        Sorted = True
        TabOrder = 1
        OnDblClick = actIncludePromotionExecute
        OnDrawItem = PromotionsDrawItem
      end
      object lbSelectedPromotions: TListBox
        Left = 324
        Top = 80
        Width = 280
        Height = 225
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight, akBottom]
        ExtendedSelect = False
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
        OnDblClick = actRemovePromotionExecute
        OnDrawItem = PromotionsDrawItem
      end
      object edtSearchPromotions: TEdit
        Tag = 1
        Left = 8
        Top = 284
        Width = 237
        Height = 21
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '<Type keywords to search>'
        OnChange = edtSearchPromotionsChange
        OnEnter = SearchEnter
        OnExit = SearchExit
      end
      object btnSearchPrevPromotion: TButton
        Left = 245
        Top = 285
        Width = 21
        Height = 21
        Action = actFindPrevPromotion
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object btnSearchNextPromotion: TButton
        Left = 267
        Top = 285
        Width = 21
        Height = 21
        Action = actFindNextPromotion
        Anchors = [akLeft, akBottom]
        Caption = '>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
    end
    object tsActivationDetails: TTabSheet
      Caption = 'tsActivationDetails'
      ImageIndex = 7
      DesignSize = (
        612
        313)
      object bvlActivationDetails: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblStartDate: TLabel
        Left = 8
        Top = 74
        Width = 53
        Height = 13
        Caption = 'Start date:'
      end
      object lblEndDate: TLabel
        Left = 166
        Top = 74
        Width = 47
        Height = 13
        Caption = 'End date:'
      end
      object pnlActivationDetailsTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgActivationDetails: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblActivationDetails: TLabel
          Left = 20
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
        object lblActivationDetailsDesc: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Define the dates and times at which the footer is active.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object dtStartDate: TwwDBDateTimePicker
        Left = 64
        Top = 70
        Width = 88
        Height = 21
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Shell Dlg 2'
        CalendarAttributes.Font.Style = []
        Epoch = 1950
        ShowButton = True
        TabOrder = 1
      end
      object dtEndDate: TwwDBDateTimePicker
        Left = 216
        Top = 70
        Width = 88
        Height = 21
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Shell Dlg 2'
        CalendarAttributes.Font.Style = []
        Epoch = 1950
        ShowButton = True
        TabOrder = 2
      end
      object chkbxAllTimes: TCheckBox
        Left = 328
        Top = 72
        Width = 153
        Height = 17
        Caption = 'Footer active at all times'
        TabOrder = 3
        OnClick = chkbxAllTimesClick
      end
      object gbxActiveTimes: TGroupBox
        Left = 4
        Top = 97
        Width = 497
        Height = 213
        TabOrder = 4
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
          object lblDaysActive: TLabel
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
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Shell Dlg 2'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
        end
      end
    end
    object tsFooterBarcode: TTabSheet
      Caption = 'tsFooterBarcode'
      ImageIndex = 4
      DesignSize = (
        612
        313)
      object bvlSelectBarcode: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblBarcode: TLabel
        Left = 9
        Top = 72
        Width = 43
        Height = 13
        Caption = 'Barcode:'
      end
      object lblBarcodeValidation: TLabel
        Left = 248
        Top = 71
        Width = 234
        Height = 13
        Caption = 'Only barcodes with exactly 12 digits can be used'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object pnlSelectBarcodeTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgSelectBarcode: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblSelectBarcode: TLabel
          Left = 20
          Top = 6
          Width = 124
          Height = 13
          Caption = 'Select Footer Barcode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblSelectBarcodeDesc: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Select a barcode to be printed on the footer.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object gbProductBarcodes: TGroupBox
        Left = 8
        Top = 100
        Width = 598
        Height = 205
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Product Barcodes'
        TabOrder = 2
        DesignSize = (
          598
          205)
        object dbgProductBarcodes: TwwDBGrid
          Left = 7
          Top = 16
          Width = 583
          Height = 153
          Selected.Strings = (
            'Extended RTL Name'#9'60'#9'Product Name'
            'Barcode'#9'32'#9'Barcode'
            'CanSelect'#9'5'#9'CanSelect')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dmPromotionalFooter.dsProductBarcodes
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Shell Dlg 2'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          OnCalcCellColors = dbgProductBarcodesCalcCellColors
          PadColumnStyle = pcsPlain
        end
        object btnUseProductBarcode: TButton
          Left = 514
          Top = 174
          Width = 75
          Height = 25
          Action = actUseBarcode
          Anchors = [akRight, akBottom]
          TabOrder = 4
        end
        object edtProductBarcodeSearch: TEdit
          Tag = 1
          Left = 7
          Top = 172
          Width = 144
          Height = 21
          Anchors = [akLeft, akBottom]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '<Type keywords to search>'
          OnChange = edtProductBarcodeSearchChange
          OnEnter = SearchEnter
          OnExit = SearchExit
        end
        object btnSearchPrev: TButton
          Left = 152
          Top = 172
          Width = 21
          Height = 21
          Action = actFindPrevProductBarcode
          Anchors = [akLeft, akBottom]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object btnSearchNext: TButton
          Left = 174
          Top = 172
          Width = 21
          Height = 21
          Action = actFindNextProductBarcode
          Anchors = [akLeft, akBottom]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
      object edtBarcode: TEdit
        Left = 56
        Top = 68
        Width = 181
        Height = 21
        MaxLength = 12
        TabOrder = 1
      end
    end
    object tsFooterText: TTabSheet
      Caption = 'tsFooterText'
      ImageIndex = 5
      DesignSize = (
        612
        313)
      object bvlFooterText: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object pnlFooterTextTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgFooterText: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblFooterText: TLabel
          Left = 20
          Top = 6
          Width = 26
          Height = 13
          Caption = 'Text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTextDescription: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Enter the footer text.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object dbgFooterText: TwwDBGrid
        Left = 8
        Top = 68
        Width = 598
        Height = 208
        ControlType.Strings = (
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False')
        Selected.Strings = (
          'LineNumber'#9'4'#9'Line~No.'
          'Text'#9'65'#9'Text'#9'F'
          'Bold'#9'5'#9'Bold'
          'DoubleSize'#9'9'#9'Double-~Width')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotionalFooter.dsFooterText
        KeyOptions = []
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 1
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 3
        TitleButtons = False
        OnKeyPress = dbgFooterTextKeyPress
        OnFieldChanged = dbgFooterTextFieldChanged
      end
      object btnShowPreview: TButton
        Left = 531
        Top = 282
        Width = 75
        Height = 25
        Action = actShowPreview
        Anchors = [akRight, akBottom]
        TabOrder = 2
      end
    end
    object tsSalesAreaTextOverride: TTabSheet
      Caption = 'tsSalesAreaTextOverride'
      ImageIndex = 7
      OnResize = tsSalesAreaTextOverrideResize
      DesignSize = (
        612
        313)
      object Label3: TLabel
        Left = 8
        Top = 72
        Width = 197
        Height = 13
        Caption = 'No override allowed on sites/sales areas:'
      end
      object lblORSelectedSA: TLabel
        Left = 335
        Top = 72
        Width = 183
        Height = 13
        Caption = 'Override allowed on sites/sales areas:'
      end
      object bvlSAtextOverride: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object Image1: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object Label1: TLabel
          Left = 20
          Top = 6
          Width = 141
          Height = 13
          Caption = 'Sales Area Text Override'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 
            'Allow Site editing of footer text for individual sales areas sel' +
            'ected for this Promotional Footer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
      end
      object btnORIncludeSA: TButton
        Left = 289
        Top = 134
        Width = 23
        Height = 23
        Action = actORIncludeSA
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object btnORIncludeAll: TButton
        Left = 289
        Top = 165
        Width = 23
        Height = 23
        Action = actORIncludeAll
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object btnORRemoveAll: TButton
        Left = 289
        Top = 196
        Width = 23
        Height = 23
        Action = actORRemoveAll
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object btnORRemoveSA: TButton
        Left = 289
        Top = 227
        Width = 23
        Height = 23
        Action = actORRemoveSA
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object tvOverrideSA: TTreeView
        Left = 335
        Top = 88
        Width = 260
        Height = 210
        Anchors = [akLeft, akTop, akRight, akBottom]
        Indent = 19
        TabOrder = 2
      end
      object tvNonOverrideSA: TTreeView
        Left = 8
        Top = 88
        Width = 260
        Height = 210
        Anchors = [akLeft, akTop, akRight, akBottom]
        Indent = 19
        TabOrder = 1
      end
    end
    object tsFinish: TTabSheet
      Caption = 'tsFinish'
      ImageIndex = 2
      DesignSize = (
        612
        313)
      object bvlFinished: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object lblFinishedMessage: TLabel
        Left = 8
        Top = 72
        Width = 547
        Height = 13
        Caption = 
          'You have entered all required details for the Footer.  Click Bac' +
          'k to review details or click Finish to save the Footer.'
      end
      object pnlFinishTop: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          612
          60)
        object imgFinished: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblFinish: TLabel
          Left = 20
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
      end
    end
  end
  object btnBack: TButton
    Left = 371
    Top = 319
    Width = 75
    Height = 25
    Action = actBack
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object btnNext: TButton
    Left = 451
    Top = 319
    Width = 75
    Height = 25
    Action = actNext
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 2
  end
  object btnClose: TButton
    Left = 531
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object pnlBottom: TPanel
    Left = 1
    Top = 312
    Width = 610
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 4
  end
  object actlPromotionalFooter: TActionList
    Left = 416
    Top = 4
    object actNext: TAction
      Caption = 'Next'
      OnExecute = actNextExecute
    end
    object actBack: TAction
      Caption = 'Back'
      OnExecute = actBackExecute
    end
    object actFindNextSA: TAction
      Category = 'Sales Areas'
      Caption = '>'
      OnExecute = actFindNextSAExecute
    end
    object actFindPrevSA: TAction
      Category = 'Sales Areas'
      Caption = '<'
      OnExecute = actFindPrevSAExecute
    end
    object actIncludeSA: TAction
      Category = 'Sales Areas'
      Caption = '>'
      OnExecute = actIncludeSAExecute
    end
    object actRemoveSA: TAction
      Category = 'Sales Areas'
      Caption = '<'
      OnExecute = actRemoveSAExecute
    end
    object actIncludeAllSA: TAction
      Category = 'Sales Areas'
      Caption = '>>'
      OnExecute = actIncludeAllSAExecute
    end
    object actRemoveAllSA: TAction
      Category = 'Sales Areas'
      Caption = '<<'
      OnExecute = actRemoveAllSAExecute
    end
    object actShowPreview: TAction
      Caption = 'Show Preview'
      OnExecute = actShowPreviewExecute
      OnUpdate = actShowPreviewUpdate
    end
    object actIncludeProduct: TAction
      Category = 'Products'
      Caption = '>'
      OnExecute = actIncludeProductExecute
    end
    object actRemoveProduct: TAction
      Category = 'Products'
      Caption = '<'
      OnExecute = actRemoveProductExecute
    end
    object actIncludeAllProducts: TAction
      Category = 'Products'
      Caption = '>>'
      OnExecute = actIncludeAllProductsExecute
    end
    object actRemoveAllProducts: TAction
      Category = 'Products'
      Caption = '<<'
      OnExecute = actRemoveAllProductsExecute
    end
    object actFindNextProduct: TAction
      Category = 'Products'
      Caption = '>'
      OnExecute = actFindNextProductExecute
    end
    object actFindPrevProduct: TAction
      Category = 'Products'
      Caption = '<'
      OnExecute = actFindPrevProductExecute
    end
    object actFindNextProductBarcode: TAction
      Category = 'Barcode'
      Caption = '>'
      OnExecute = actFindPrevProductBarcodeExecute
    end
    object actFindPrevProductBarcode: TAction
      Category = 'Barcode'
      Caption = '<'
      OnExecute = actFindPrevProductBarcodeExecute
    end
    object actUseBarcode: TAction
      Category = 'Barcode'
      Caption = 'Use Barcode'
      OnExecute = actUseBarcodeExecute
      OnUpdate = actUseBarcodeUpdate
    end
    object actIncludePromotion: TAction
      Category = 'Promotions'
      Caption = '>'
      OnExecute = actIncludePromotionExecute
    end
    object actRemovePromotion: TAction
      Category = 'Promotions'
      Caption = '<'
      OnExecute = actRemovePromotionExecute
    end
    object actFindPrevPromotion: TAction
      Category = 'Promotions'
      Caption = '<'
      OnExecute = actFindPrevPromotionExecute
    end
    object actFindNextPromotion: TAction
      Category = 'Promotions'
      Caption = 'actFindNextPromotion'
      OnExecute = actFindNextPromotionExecute
    end
    object actORIncludeSA: TAction
      Category = 'SalesAreaOverride'
      Caption = '>'
      OnExecute = actORIncludeSAExecute
    end
    object actORRemoveSA: TAction
      Category = 'SalesAreaOverride'
      Caption = '<'
      OnExecute = actORRemoveSAExecute
    end
    object actORIncludeAll: TAction
      Category = 'SalesAreaOverride'
      Caption = '>>'
      OnExecute = actORIncludeAllExecute
    end
    object actORRemoveAll: TAction
      Category = 'SalesAreaOverride'
      Caption = '<<'
      OnExecute = actORRemoveAllExecute
    end
    object actDeleteOverride: TAction
      Category = 'Overrides'
      Caption = 'Delete'
      OnExecute = actDeleteOverrideExecute
      OnUpdate = actDeleteOverrideUpdate
    end
    object actAddOverride: TAction
      Category = 'Overrides'
      Caption = 'Add'
      OnExecute = actAddOverrideExecute
    end
    object actDeleteSalesGroup: TAction
      Category = 'Sales Groups'
      Caption = 'Delete'
      OnExecute = actDeleteSalesGroupExecute
      OnUpdate = actDeleteSalesGroupUpdate
    end
    object actAddSalesGroup: TAction
      Category = 'Sales Groups'
      Caption = 'Add'
      OnExecute = actAddSalesGroupExecute
      OnUpdate = actAddSalesGroupUpdate
    end
    object actPrintVoucherCode: TAction
      Caption = 'Print Voucher Code'
      Checked = True
      OnUpdate = actPrintVoucherCodeUpdate
    end
  end
  object wwldProductBarcodeSearch: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = dmPromotionalFooter.dsProductBarcodes
    SearchField = 'Extended RTL Name'
    MatchType = mtPartialMatchAny
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 384
    Top = 4
  end
  object qValidTimes: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    AfterScroll = qValidTimesAfterScroll
    OnCalcFields = qValidTimesCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT DisplayOrder, ValidDays, StartTime, EndTime'
      'FROM #PromotionalFooterTimeCycles'
      '--FROM [00_#promotionalFooterTimeCycles]'
      'ORDER BY DisplayOrder')
    Left = 448
    Top = 4
    object qValidTimesDisplayOrder: TAutoIncField
      FieldName = 'DisplayOrder'
      ReadOnly = True
    end
    object qValidTimesValidDays: TStringField
      FieldName = 'ValidDays'
      Size = 7
    end
    object qValidTimesStartTime: TDateTimeField
      FieldName = 'StartTime'
      DisplayFormat = 'hh:mm'
    end
    object qValidTimesEndTime: TDateTimeField
      FieldName = 'EndTime'
      DisplayFormat = 'hh:mm'
    end
    object qValidTimesValidDaysDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      Size = 35
      Calculated = True
    end
  end
  object dsValidTimes: TDataSource
    DataSet = qValidTimes
    Left = 480
    Top = 4
  end
end
