object ExceptionWizard: TExceptionWizard
  Left = 613
  Top = 383
  Width = 548
  Height = 413
  HelpContext = 7101
  Caption = 'Exception Wizard'
  Color = clBtnFace
  Constraints.MinHeight = 413
  Constraints.MinWidth = 512
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = SelectSitesSAResize
  DesignSize = (
    532
    374)
  PixelsPerInch = 96
  TextHeight = 13
  object pcWizard: TPageControl
    Left = -4
    Top = -7
    Width = 548
    Height = 355
    ActivePage = tsActivationException
    Anchors = [akLeft, akTop, akRight, akBottom]
    Constraints.MinHeight = 325
    Style = tsButtons
    TabHeight = 1
    TabIndex = 2
    TabOrder = 0
    object tsFirstPage: TTabSheet
      Caption = 'tsFirstPage'
      OnShow = tsFirstPageShow
      object lbWizardTitle: TLabel
        Left = 152
        Top = 8
        Width = 345
        Height = 25
        AutoSize = False
        Caption = 'New Exception Wizard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object lbWizardDescription: TLabel
        Left = 152
        Top = 32
        Width = 347
        Height = 28
        AutoSize = False
        Caption = 
          'This wizard will guide you through the process of creating a new' +
          ' exception'
        WordWrap = True
      end
      object Label3: TLabel
        Left = 152
        Top = 64
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object Label4: TLabel
        Left = 152
        Top = 104
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 344
        Align = alLeft
        Color = clWhite
        TabOrder = 2
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
        Width = 313
        Height = 21
        TabOrder = 0
        OnChange = edNameChange
      end
      object edDescription: TMemo
        Left = 152
        Top = 120
        Width = 313
        Height = 57
        MaxLength = 255
        TabOrder = 1
      end
    end
    object tsSAException: TTabSheet
      Caption = 'tsSAException'
      ImageIndex = 1
      DesignSize = (
        540
        344)
      object Label9: TLabel
        Left = 8
        Top = 64
        Width = 129
        Height = 13
        Caption = 'Available Sites/Sales Areas'
      end
      object Label10: TLabel
        Left = 272
        Top = 64
        Width = 127
        Height = 13
        Caption = 'Selected Sites/Sales Areas'
      end
      object sbExcludeAllSalesAreas: TButton
        Left = 240
        Top = 200
        Width = 23
        Height = 22
        Caption = '<<'
        TabOrder = 8
        OnClick = sbExcludeAllSalesAreasClick
      end
      object sbExcludeSalesAea: TButton
        Left = 240
        Top = 232
        Width = 23
        Height = 22
        Caption = '<'
        TabOrder = 9
        OnClick = sbExcludeSalesAeaClick
      end
      object sbIncludeSalesArea: TButton
        Left = 240
        Top = 136
        Width = 23
        Height = 22
        Caption = '>'
        TabOrder = 6
        OnClick = sbIncludeSalesAreaClick
      end
      object sbIncludeAllSalesAreas: TButton
        Left = 240
        Top = 168
        Width = 23
        Height = 22
        Caption = '>>'
        TabOrder = 7
        OnClick = sbIncludeAllSalesAreasClick
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
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
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label7: TLabel
          Left = 45
          Top = 22
          Width = 309
          Height = 13
          Caption = 
            'Select the Sites and/or Sales Areas that the Exception applies t' +
            'o'
        end
        object Image2: TImage
          Tag = 102
          Left = 486
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object tvAvailableSAs: TTreeView
        Left = 8
        Top = 80
        Width = 225
        Height = 204
        Anchors = [akLeft, akTop, akBottom]
        Indent = 19
        TabOrder = 1
      end
      object tvSelectedSAs: TTreeView
        Left = 272
        Top = 80
        Width = 261
        Height = 256
        Anchors = [akLeft, akTop, akRight, akBottom]
        Indent = 19
        TabOrder = 10
      end
      object btSAFindNext: TButton
        Left = 213
        Top = 289
        Width = 21
        Height = 21
        Action = SATreeFindNext
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object btSAFindPrev: TButton
        Left = 191
        Top = 289
        Width = 21
        Height = 21
        Action = SATreeFindPrev
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object edSASearchTerm: TEdit
        Tag = 1
        Left = 8
        Top = 289
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
        TabOrder = 2
        Text = '<Type keywords to search>'
        OnChange = edSASearchTermChange
        OnEnter = SearchTermEnter
        OnExit = SearchTermExit
      end
      inline SiteTagFilterFrame: TSiteTagFilterFrame
        Left = 9
        Top = 314
        Width = 154
        Height = 25
        Anchors = [akLeft, akBottom]
        TabOrder = 5
        inherited chkbxFiltered: TCheckBox
          Anchors = [akLeft, akBottom]
        end
        inherited btnTags: TButton
          Anchors = [akLeft, akBottom]
        end
      end
    end
    object tsActivationException: TTabSheet
      Caption = 'tsActivationException'
      ImageIndex = 8
      object Label6: TLabel
        Left = 8
        Top = 74
        Width = 53
        Height = 13
        Caption = 'Start date:'
      end
      object Label31: TLabel
        Left = 186
        Top = 74
        Width = 47
        Height = 13
        Caption = 'End date:'
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
          60)
        object Bevel8: TBevel
          Left = -1
          Top = 58
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Image8: TImage
          Tag = 102
          Left = 486
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
        object Label15: TLabel
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
        object Label16: TLabel
          Left = 45
          Top = 22
          Width = 413
          Height = 13
          Caption = 
            'Define at what dates and times the promotion is active on Except' +
            'ion Sites/Sales Areas'
        end
      end
      object chkbxAllTimes: TCheckBox
        Left = 360
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
            'ValidDaysDisplay'#9'28'#9'Days active'#9#9
            'StartTime'#9'5'#9' Start'#9#9
            'EndTime'#9'5'#9' End'#9#9)
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
      end
    end
    object tsProductException: TTabSheet
      Caption = 'tsProductException'
      Enabled = False
      ImageIndex = 4
      DesignSize = (
        540
        344)
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
      object sbIncludeProduct: TButton
        Left = 240
        Top = 128
        Width = 23
        Height = 22
        Caption = '>'
        TabOrder = 3
      end
      object sbIncludeAllProducts: TButton
        Left = 240
        Top = 160
        Width = 23
        Height = 22
        Caption = '>>'
        TabOrder = 4
      end
      object sbExcludeAllProducts: TButton
        Left = 240
        Top = 192
        Width = 23
        Height = 22
        Caption = '<<'
        TabOrder = 5
      end
      object sbExcludeProduct: TButton
        Left = 240
        Top = 224
        Width = 23
        Height = 22
        Caption = '<'
        TabOrder = 6
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
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
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label14: TLabel
          Left = 45
          Top = 22
          Width = 313
          Height = 26
          Caption = 
            'Edit the applicable products for the exception'#13#10'Prices are defin' +
            'ed by group rules or in the main Promotion Wizard'
        end
        object Image4: TImage
          Tag = 102
          Left = 486
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
        Height = 231
        Anchors = [akLeft, akTop, akBottom]
        Indent = 19
        TabOrder = 1
      end
      object tcProductGroups: TTabControl
        Left = 272
        Top = 80
        Width = 263
        Height = 256
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 2
      end
      object edProductSearchTerm: TEdit
        Tag = 1
        Left = 8
        Top = 315
        Width = 177
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
        TabOrder = 7
        Text = '<Type keywords to search>'
        OnEnter = SearchTermEnter
        OnExit = SearchTermExit
      end
      object btProductFindPrev: TButton
        Left = 191
        Top = 315
        Width = 21
        Height = 21
        Action = ProductTreeFindPrev
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object btProductFindNext: TButton
        Left = 213
        Top = 315
        Width = 21
        Height = 21
        Action = ProductTreeFindNext
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
      end
    end
    object tsEventActionException: TTabSheet
      Caption = 'tsEventActionException'
      ImageIndex = 6
      DesignSize = (
        540
        344)
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
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
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
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label36: TLabel
          Left = 45
          Top = 22
          Width = 378
          Height = 13
          Caption = 
            'Select which Promotions are active within this Event, for Except' +
            'ion Sales Areas'
        end
        object Image10: TImage
          Tag = 102
          Left = 486
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object dbgPromotionActions: TwwDBGrid
        Left = 8
        Top = 80
        Width = 525
        Height = 223
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
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
      end
      object btActivateAllPromotions: TButton
        Left = 377
        Top = 313
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Select all'
        TabOrder = 2
        OnClick = btActivateAllPromotionsClick
      end
      object btActivateNoPromotions: TButton
        Left = 460
        Top = 313
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Select none'
        TabOrder = 3
        OnClick = btActivateNoPromotionsClick
      end
      object cbHideDisabledPromotions: TCheckBox
        Left = 394
        Top = 61
        Width = 139
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Hide disabled promotions'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = cbHideDisabledPromotionsClick
      end
      inline PromotionFilterFrame: TPromotionFilterFrame
        Left = 8
        Top = 310
        Width = 365
        Height = 29
        HorzScrollBar.Visible = False
        VertScrollBar.Visible = False
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 5
        DesignSize = (
          365
          29)
        inherited FilterPanel: TPanel
          Width = 365
          DesignSize = (
            365
            29)
          inherited Bevel1: TBevel
            Left = 70
          end
          inherited Bevel2: TBevel
            Left = 780
          end
          inherited lblSiteFilter: TLabel
            Left = 788
            Width = 58
          end
          inherited edtFilter: TEdit
            Left = 78
            Width = 175
          end
          inherited chkbxMidwordSearch: TCheckBox
            Left = 260
          end
          inherited cbxSiteFilter: TComboBox
            Left = 849
            Height = 19
            ItemHeight = 13
          end
        end
      end
    end
    object tsValidateOverlap: TTabSheet
      Caption = 'tsValidateOverlap'
      ImageIndex = 3
      DesignSize = (
        540
        344)
      object Label19: TLabel
        Left = 8
        Top = 64
        Width = 489
        Height = 39
        AutoSize = False
        Caption = 
          'Some settings in this exception overlap existing exceptions. Ple' +
          'ase choose an action to correct:'#13#10'"Keep": Removes the sales area' +
          ' from the old exception(s), keeping the values you entered'#13#10'"Rem' +
          'ove" Removes the sales area from the new exception'
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
          60)
        object Label1: TLabel
          Left = 21
          Top = 6
          Width = 181
          Height = 13
          Caption = 'Validate overlapping exceptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel2: TBevel
          Left = -1
          Top = 58
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label2: TLabel
          Left = 45
          Top = 22
          Width = 3
          Height = 13
        end
        object Image1: TImage
          Tag = 102
          Left = 486
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
      object dbgExceptionOverlap: TwwDBGrid
        Left = 8
        Top = 112
        Width = 525
        Height = 223
        ControlType.Strings = (
          'Start Date;CheckBox;True;False'
          'End Date;CheckBox;True;False'
          'Times;CheckBox;True;False'
          'ActionID;CustomEdit;dblActionID;F'
          'ActionType;CustomEdit;dblActionID;F')
        Selected.Strings = (
          'SiteName'#9'16'#9'Site Name'
          'SalesAreaName'#9'16'#9'Sales Area Name'
          'SiteRef'#9'6'#9'Site Ref'
          'OverlapData'#9'27'#9'Overlap Data'#9'F'
          'ActionType'#9'9'#9'Action')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnRowChanged = HandleOverlapRowChange
        FixedCols = 4
        ShowHorzScrollBar = False
        ShowVertScrollBar = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmPromotions.dsTempExceptionOverlap
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFixedResizable]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
      end
      object dblActionID: TwwDBLookupCombo
        Left = 350
        Top = 245
        Width = 64
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ActionName'#9'30'#9'ActionName'#9#9)
        DataField = 'ActionID'
        DataSource = dmPromotions.dsTempExceptionOverlap
        LookupTable = dmPromotions.qTempExceptionOverlapAction
        LookupField = 'ActionID'
        Style = csDropDownList
        DropDownWidth = 40
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
    end
    object tsFinalPage: TTabSheet
      Caption = 'tsFinalPage'
      ImageIndex = 5
      object Label12: TLabel
        Left = 8
        Top = 72
        Width = 309
        Height = 26
        Caption = 
          'You have entered all required details for the Exception.'#13#10'Click ' +
          'Back to review details, or click Finish to save the Exception.'
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 540
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          540
          60)
        object Label17: TLabel
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
        object Bevel4: TBevel
          Left = -1
          Top = 58
          Width = 542
          Height = 2
          Anchors = [akLeft, akRight, akBottom]
        end
        object Label18: TLabel
          Left = 45
          Top = 22
          Width = 3
          Height = 13
        end
        object Image3: TImage
          Tag = 102
          Left = 486
          Top = 5
          Width = 49
          Height = 49
          Anchors = [akTop, akRight]
        end
      end
    end
  end
  object btnBack: TButton
    Left = 296
    Top = 356
    Width = 75
    Height = 23
    Action = PrevPage
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object btnNext: TButton
    Left = 372
    Top = 356
    Width = 75
    Height = 23
    Action = NextPage
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 2
  end
  object btClose: TButton
    Left = 458
    Top = 356
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 3
    OnClick = btCloseClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 343
    Width = 540
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 4
  end
  object ExceptionActions: TActionList
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
    end
    object RewardPriceExport: TAction
      Caption = 'Export'
    end
    object RewardPriceImport: TAction
      Caption = 'Import'
    end
    object SATreeFindPrev: TAction
      Caption = '<'
      OnExecute = ProductTreeFindPrevExecute
      OnUpdate = ProductTreeFindUpdate
    end
    object SATreeFindNext: TAction
      Caption = '>'
      OnExecute = ProductTreeFindNextExecute
      OnUpdate = ProductTreeFindUpdate
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
  end
  object dstValidTimes: TADODataSet
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    AfterScroll = dstValidTimesAfterScroll
    OnCalcFields = dstValidTimesCalcFields
    CommandText = 
      'SELECT ValidDays, StartTime, EndTime'#13#10'FROM #TmpPromotionExceptio' +
      'nTimeCycles'#13#10'ORDER BY DisplayOrder'
    Parameters = <>
    Top = 32
    object dstValidTimesValidDaysDisplay: TStringField
      DisplayLabel = 'Days active'
      DisplayWidth = 28
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      Size = 35
      Calculated = True
    end
    object dstValidTimesStartTime: TDateTimeField
      DisplayLabel = ' Start'
      DisplayWidth = 5
      FieldName = 'StartTime'
      DisplayFormat = 'hh:mm'
    end
    object dstValidTimesEndTime: TDateTimeField
      DisplayLabel = ' End'
      DisplayWidth = 5
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
