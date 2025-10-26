object TextOverrideWizard: TTextOverrideWizard
  Left = 766
  Top = 251
  Width = 620
  Height = 373
  HelpContext = 5082
  Caption = 'Text Override Wizard'
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
  OnCloseQuery = FormCloseQuery
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
    ActivePage = tsClockoutTicketFooterOverrideText
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabHeight = 1
    TabIndex = 2
    TabOrder = 0
    object tsScrollingMessageOverride: TTabSheet
      Caption = 'tsScrollingMessageOverride'
      Enabled = False
      TabVisible = False
      DesignSize = (
        612
        313)
      object lblName: TLabel
        Left = 153
        Top = 82
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblDescription: TLabel
        Left = 153
        Top = 121
        Width = 88
        Height = 13
        Caption = 'Scrolling message:'
      end
      object lblSMOverrideName: TLabel
        Left = 153
        Top = 21
        Width = 226
        Height = 23
        Caption = 'Scrolling Message Override'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblSMOverrideDescription: TLabel
        Left = 153
        Top = 45
        Width = 440
        Height = 29
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of overriding the' +
          ' terminal Scrolling Message for multiple sites.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object pnlLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 2
        object imZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object edScrollingMessageOverrideName: TEdit
        Left = 153
        Top = 96
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 50
        TabOrder = 0
      end
      object edScrollingMessageOverrideText: TEdit
        Left = 153
        Top = 136
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 255
        TabOrder = 1
      end
    end
    object tsStandardFooterOverride: TTabSheet
      Caption = 'tsStandardFooterOverride'
      Enabled = False
      ImageIndex = 1
      DesignSize = (
        612
        313)
      object lblPFOverrideName: TLabel
        Left = 153
        Top = 21
        Width = 174
        Height = 23
        Caption = 'Print Footer Override'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblPFOverrideDescription: TLabel
        Left = 153
        Top = 45
        Width = 440
        Height = 29
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of overriding the' +
          ' standard receipt footer for multiple sites.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label4: TLabel
        Left = 153
        Top = 82
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label5: TLabel
        Left = 153
        Top = 121
        Width = 59
        Height = 13
        Caption = 'Footer text:'
      end
      object pnlSiteLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 2
        object imgSiteZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object edStandardFooterOverrideName: TEdit
        Left = 153
        Top = 96
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 50
        TabOrder = 0
      end
      object mmStandardFooterOverrideText: TMemo
        Left = 152
        Top = 136
        Width = 337
        Height = 113
        TabOrder = 1
        WordWrap = False
        OnChange = mmStandardFooterOverrideTextChange
        OnKeyPress = mmStandardFooterOverrideTextKeyPress
      end
    end
    object tsClockoutTicketFooterOverride: TTabSheet
      Caption = 'tsClockoutTicketFooterOverride'
      Enabled = False
      ImageIndex = 4
      DesignSize = (
        612
        313)
      object lblClockOutFooterOverrideName: TLabel
        Left = 153
        Top = 82
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblClockOutFooterOverrideHeader: TLabel
        Left = 153
        Top = 21
        Width = 261
        Height = 23
        Caption = 'Clockout Ticket Footer Override'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblClockOutFooterOverrideWizardDesc: TLabel
        Left = 153
        Top = 45
        Width = 440
        Height = 29
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of overriding the' +
          ' Clockout Ticket footer.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lblClockOutFooterOverrideDescription: TLabel
        Left = 153
        Top = 120
        Width = 57
        Height = 13
        Caption = 'Description:'
      end
      object pnlZonalLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 0
        object imgZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object edtClockOutFooterOverrideName: TEdit
        Left = 153
        Top = 96
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 40
        TabOrder = 1
      end
      object mClockOutFooterOverrideDescription: TMemo
        Left = 152
        Top = 136
        Width = 444
        Height = 58
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 2
      end
    end
    object tsClockoutTicketFooterOverrideText: TTabSheet
      Caption = 'tsClockoutTicketFooterOverrideText'
      Enabled = False
      ImageIndex = 5
      DesignSize = (
        612
        313)
      object bvlClockOutTicketFooterOverrideText: TBevel
        Left = 0
        Top = 60
        Width = 611
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object pnllockOutTicketFooterOverrideText: TPanel
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
        object imgClockOutTicketFooterOverrideText: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblClockOutTicketFooterOverrideTextDescription: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Enter clockout footer text.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
        object lblClockOutTicketFooterOverrideText: TLabel
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
      end
      object dbgrdClockoutTicketFooterOverride: TwwDBGrid
        Left = 10
        Top = 70
        Width = 585
        Height = 200
        ControlType.Strings = (
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False')
        Selected.Strings = (
          'Text'#9'76'#9'Text'
          'Bold'#9'5'#9'Bold'
          'DoubleSize'#9'5'#9'DoubleSize')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnCellChanged = dbgrdClockoutTicketFooterOverrideCellChanged
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmADO.dsClockoutTicketFooterTextOverride
        KeyOptions = []
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = dbgrdClockoutTicketFooterOverrideCalcCellColors
        OnKeyDown = dbgrdClockoutTicketFooterOverrideKeyDown
        OnKeyPress = dbgrdClockoutTicketFooterOverrideKeyPress
      end
      object btnPreview: TButton
        Left = 531
        Top = 280
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Preview'
        TabOrder = 2
        OnClick = btnPreviewClick
      end
      object btnInsert: TButton
        Left = 371
        Top = 280
        Width = 75
        Height = 25
        Action = actInsertClockoutTicketFooterLine
        Anchors = [akRight, akBottom]
        TabOrder = 3
      end
      object btnDelete: TButton
        Left = 451
        Top = 280
        Width = 75
        Height = 25
        Action = actDeleteClockoutTicketFooterLine
        Anchors = [akRight, akBottom]
        TabOrder = 4
      end
    end
    object tsBillFooterOverride: TTabSheet
      Caption = 'tsBillFooterOverride'
      Enabled = False
      ImageIndex = 6
      DesignSize = (
        612
        313)
      object lblBillFooterOverrideHeader: TLabel
        Left = 153
        Top = 21
        Width = 159
        Height = 23
        Caption = 'Bill Footer Override'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lblBillFooterOverrideWizardDesc: TLabel
        Left = 153
        Top = 45
        Width = 440
        Height = 29
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of overriding the' +
          ' Bill footer.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lblBillFooterOverrideName: TLabel
        Left = 153
        Top = 82
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblBillFooterOverrideDescription: TLabel
        Left = 153
        Top = 120
        Width = 57
        Height = 13
        Caption = 'Description:'
      end
      object pnlBillZonalLogo: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 313
        Align = alLeft
        Color = clWindow
        TabOrder = 0
        object imgBillZonalLogo: TImage
          Tag = 101
          Left = 23
          Top = 24
          Width = 100
          Height = 100
        end
      end
      object edtBillFooterOverrideName: TEdit
        Left = 153
        Top = 96
        Width = 444
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 40
        TabOrder = 1
      end
      object mBillFooterOverrideDescription: TMemo
        Left = 152
        Top = 136
        Width = 444
        Height = 58
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 2
      end
    end
    object tsBillFooterOverrideText: TTabSheet
      Caption = 'tsBillFooterOverrideText'
      Enabled = False
      ImageIndex = 7
      DesignSize = (
        612
        313)
      object dbgrdBillFooterOverride: TwwDBGrid
        Left = 10
        Top = 70
        Width = 585
        Height = 200
        ControlType.Strings = (
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False'
          'DoubleWidth;CheckBox;True;False'
          'DoubleHeight;CheckBox;True;False'
          'Alignment;CustomEdit;luAlignment;F'
          'AlignmentName;CustomEdit;luAlignment;F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmADO.dsBillFooterTextOverride
        KeyOptions = []
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 2
        TitleButtons = False
        OnKeyPress = dbgrdClockoutTicketFooterOverrideKeyPress
      end
      object btnPreviewBill: TButton
        Left = 531
        Top = 280
        Width = 75
        Height = 25
        Action = actPreviewBillFooter
        Anchors = [akRight, akBottom]
        TabOrder = 1
      end
      object pnlBillFooterOverrideText: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 2
        DesignSize = (
          612
          60)
        object imgBillFooterOverrideText: TImage
          Tag = 102
          Left = 558
          Top = 5
          Width = 50
          Height = 50
          Anchors = [akTop, akRight]
        end
        object lblBillFooterOverrideTextDescription: TLabel
          Left = 45
          Top = 22
          Width = 492
          Height = 27
          AutoSize = False
          Caption = 'Enter bill footer text.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
        object lblBillFooterOverrideText: TLabel
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
      end
      object luAlignment: TwwDBLookupCombo
        Left = 360
        Top = 96
        Width = 70
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Position'#9'6'#9'Position'#9#9)
        DataField = 'Alignment'
        DataSource = dmADO.dsBillFooterTextOverride
        LookupTable = dmADO.qBillFooterAlignmentLookup
        LookupField = 'Id'
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        ShowMatchText = True
      end
    end
    object tsSelectSites: TTabSheet
      Caption = 'tsSelectSites'
      ImageIndex = 2
      OnResize = tsSelectSitesResize
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
        Width = 72
        Height = 13
        Caption = 'Available sites:'
      end
      object lblSelectedSA: TLabel
        Left = 280
        Top = 64
        Width = 70
        Height = 13
        Caption = 'Selected sites:'
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
          Caption = 'Select the sites to which the override applies.'
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
        Height = 169
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
        Top = 256
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
        Top = 256
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
        Top = 256
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
      inline SiteTagFilterFrame: TSiteTagFilterFrame
        Left = 10
        Top = 282
        Width = 154
        Height = 25
        TabOrder = 10
      end
    end
    object tsFinish: TTabSheet
      Caption = 'tsFinish'
      ImageIndex = 3
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
        Width = 521
        Height = 13
        Caption = 
          'You have entered all required details for the text override. Cli' +
          'ck Back to review details or click Finish to save.'
      end
      object lbNoSitesAssignedWarning: TLabel
        Left = 8
        Top = 96
        Width = 376
        Height = 13
        Caption = 
          'No changes will take effect until sites are assigned to this ove' +
          'rride.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbChangeAssignmentWarning: TLabel
        Left = 16
        Top = 104
        Width = 483
        Height = 13
        Caption = 
          'The following sites have other overrides assigned and will be sw' +
          'itched to use this one:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
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
      object sgChangeAssignmentWarning: TStringGrid
        Left = 8
        Top = 112
        Width = 264
        Height = 193
        Anchors = [akLeft, akTop, akBottom]
        ColCount = 2
        DefaultColWidth = 120
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        TabOrder = 1
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
    end
    object actInsertClockoutTicketFooterLine: TAction
      Category = 'Clockout'
      Caption = 'Insert Line'
      OnExecute = actInsertClockoutTicketFooterLineExecute
    end
    object actDeleteClockoutTicketFooterLine: TAction
      Category = 'Clockout'
      Caption = 'Delete Line'
      OnExecute = actDeleteClockoutTicketFooterLineExecute
    end
    object actPreviewBillFooter: TAction
      Category = 'BillFooter'
      Caption = 'Preview'
      OnExecute = actPreviewBillFooterExecute
    end
  end
end
