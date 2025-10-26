object LineEditForm: TLineEditForm
  Left = 549
  Top = 176
  Width = 920
  Height = 630
  Caption = 'Product Modelling'
  Color = clBtnFace
  Constraints.MinHeight = 630
  Constraints.MinWidth = 910
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 277
    Height = 591
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      277
      591)
    object Bevel1: TBevel
      Left = 0
      Top = 546
      Width = 277
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
    end
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 102
      Height = 13
      Caption = 'Select an item to edit:'
    end
    inline EntityLookupFrame: TEntityLookupFrame
      Left = 1
      Top = 29
      Width = 274
      Height = 478
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      DesignSize = (
        274
        478)
      inherited EntityGrid: TFlexiDBGrid
        Left = 4
        Width = 272
        Height = 394
        OnDrawColumnCell = EntityLookupFrameEntityGridDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'Extended RTL Name'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Entity Type'
            Title.Caption = 'Type'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Retail Description'
            Width = 91
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EntityCode'
            Title.Caption = 'Entity Code'
            Visible = False
          end>
      end
      inherited FindLineItemBox: TGroupBox
        Left = 4
        Top = 397
        Width = 185
        Height = 77
        Caption = 'Find Item (F3)'
        DesignSize = (
          185
          77)
        inherited SearchTextEdit: TEdit
          Width = 124
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        inherited MidWordSearchCheckBox: TCheckBox
          Top = 43
        end
        inherited FindPrevButton: TButton
          Left = 134
          Top = 44
          Width = 43
          Anchors = [akTop, akRight]
          Caption = 'Prev'
        end
        inherited FindNextButton: TButton
          Left = 134
          Top = 14
          Width = 43
          Anchors = [akTop, akRight]
          Caption = 'Next'
        end
      end
      inherited GroupBox1: TGroupBox
        Left = 193
        Top = 397
        Width = 78
        Height = 77
        Caption = 'Filter (Ctrl-F)'
        inherited cbFiltered: TCheckBox
          Left = 10
          Top = 19
        end
        inherited SetFilterButton: TButton
          Left = 9
          Top = 44
        end
      end
    end
    object ReloadButton: TButton
      Left = 196
      Top = 513
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Refresh Data'
      TabOrder = 3
      OnClick = ReloadButtonClick
    end
    object btn_LinkedProds: TButton
      Left = 97
      Top = 554
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Linked Products'
      TabOrder = 6
      TabStop = False
      OnClick = btn_LinkedProdsClick
    end
    object CloneItemButton: TButton
      Left = 70
      Top = 513
      Width = 50
      Height = 25
      Action = CloneItemAction
      Anchors = [akLeft, akBottom]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object InsertItemButton: TButton
      Left = 8
      Top = 513
      Width = 50
      Height = 25
      Action = AddItemAction
      Anchors = [akLeft, akBottom]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DeleteItemButton: TButton
      Left = 132
      Top = 513
      Width = 50
      Height = 25
      Action = DeleteItemAction
      Anchors = [akLeft, akBottom]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btnSettings: TButton
      Left = 8
      Top = 554
      Width = 85
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Settings'
      TabOrder = 4
      TabStop = False
      OnClick = btnSettingsClick
    end
    object btnClose: TButton
      Left = 213
      Top = 554
      Width = 58
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Close'
      TabOrder = 5
      TabStop = False
      OnClick = btnCloseClick
    end
  end
  object Panel4: TPanel
    Left = 277
    Top = 0
    Width = 627
    Height = 591
    HelpType = htKeyword
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      627
      591)
    object Bevel2: TBevel
      Left = 1
      Top = 206
      Width = 633
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object NoProductsLabel: TLabel
      Left = 1
      Top = 330
      Width = 633
      Height = 20
      Alignment = taCenter
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 'Click '#39'New'#39' to create a product'
    end
    object lblROAlert: TLabel
      Left = 128
      Top = 187
      Width = 371
      Height = 13
      Caption = 
        'This product is maintained via Recipe Modelling and is read only' +
        '.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object PageControlPanel: TPanel
      Left = 1
      Top = 215
      Width = 633
      Height = 540
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      object PageControl: TPageControl
        Left = 0
        Top = 0
        Width = 633
        Height = 540
        ActivePage = OtherFlagsTabSheet
        Align = alClient
        TabIndex = 7
        TabOrder = 0
        TabStop = False
        object AztecStandardTabSheet: TTabSheet
          Caption = 'Standard'
          ImageIndex = 6
          inline TTCoursesAndTaxRulesFrame1: TTCoursesAndTaxRulesFrame
            Left = 0
            Top = 0
            Width = 625
            Height = 512
            Align = alClient
            TabOrder = 1
            inherited childBehaviourGroupBox: TGroupBox
              inherited cmbChoicePrintMode: TDBComboBox
                Font.Color = clInfoText
              end
            end
            inherited PricingRadioGroup: TDBRadioGroup
              Top = 60
              Height = 53
              OnClick = ChangeProductPricing
            end
            inherited gbCourse: TGroupBox
              Height = 52
              inherited cmbbxCourses: TAztecDBLookupBox
                Top = 19
              end
            end
          end
          object gbGiftCards: TGroupBox
            Left = 286
            Top = 116
            Width = 170
            Height = 51
            TabOrder = 0
            object wwdbcomboGiftCardType: TwwDBComboBox
              Left = 8
              Top = 19
              Width = 154
              Height = 21
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'isGiftCard'
              DataSource = ProductsDB.EntityDataSource
              DropDownCount = 8
              Enabled = False
              ItemHeight = 0
              Sorted = False
              TabOrder = 0
              UnboundDataType = wwDefault
              OnChange = wwdbcomboGiftCardTypeChange
            end
            object cbxIsGiftCard: TCheckBox
              Left = 9
              Top = 1
              Width = 73
              Height = 12
              Action = actIsGiftCard
              TabOrder = 1
            end
          end
        end
        object AztecMultiPurchaseTabSheet: TTabSheet
          Caption = 'Multi Purchase'
          ImageIndex = 8
          inline MultiPurchaseFrame: TTMultiPurchaseFrame
            Left = 0
            Top = 0
            Width = 625
            Height = 512
            Align = alClient
            TabOrder = 0
            inherited DBGrid1: TFlexiDBGrid
              TitleFont.Color = clInfoText
            end
          end
        end
        object AztecBarcodesTabSheet: TTabSheet
          Caption = 'Barcodes'
          ImageIndex = 10
          OnShow = AztecBarcodesTabSheetShow
          object pnlSingleEntryBarcodes: TPanel
            Left = 0
            Top = 0
            Width = 281
            Height = 356
            TabOrder = 0
            DesignSize = (
              281
              356)
            object Label2: TLabel
              Left = 8
              Top = 8
              Width = 55
              Height = 13
              Caption = 'Single entry'
            end
            object grdProductBarcode: TwwDBGrid
              Left = 8
              Top = 24
              Width = 257
              Height = 289
              Selected.Strings = (
                'Barcode'#9'34'#9'Barcode')
              IniAttributes.Delimiter = ';;'
              TitleColor = clBtnFace
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akBottom]
              DataSource = ProductsDB.dsProductBarcodes
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clInfoText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitleLines = 1
              TitleButtons = False
              PadColumnStyle = pcsPlain
            end
            object btnAddBarcode: TButton
              Left = 8
              Top = 324
              Width = 75
              Height = 25
              Anchors = [akLeft, akBottom]
              Caption = 'Add'
              TabOrder = 1
              OnClick = btnAddBarcodeClick
            end
            object btnDeleteBarcode: TButton
              Left = 96
              Top = 324
              Width = 75
              Height = 25
              Anchors = [akLeft, akBottom]
              Caption = 'Delete'
              TabOrder = 2
              OnClick = btnDeleteBarcodeClick
            end
          end
          object pnlBarcodeRanges: TPanel
            Left = 281
            Top = 0
            Width = 304
            Height = 356
            TabOrder = 1
            object Label3: TLabel
              Left = 8
              Top = 8
              Width = 37
              Height = 13
              Caption = 'Ranges'
            end
            object btnEditBarcodeRanges: TButton
              Left = 9
              Top = 324
              Width = 113
              Height = 25
              Caption = 'Edit Barcode Ranges'
              TabOrder = 0
              OnClick = btnEditBarcodeRangesClick
            end
            object grdProductBarcodeRange: TwwDBGrid
              Left = 8
              Top = 24
              Width = 281
              Height = 289
              TabStop = False
              LineStyle = glsSingle
              ControlType.Strings = (
                'BarcodeRangeID;CustomEdit;wdiBarcodeRanges;T')
              Selected.Strings = (
                'BarcodeRangeID'#9'41'#9'Barcode Ranges'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clBtnFace
              FixedCols = 0
              ShowHorzScrollBar = False
              DataSource = ProductsDB.dsProductBarcodeRanges
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ReadOnly = True
              RowHeightPercent = 415
              TabOrder = 1
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clInfoText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
            end
            object wdiBarcodeRanges: TwwDataInspector
              Left = 21
              Top = 44
              Width = 250
              Height = 65
              TabStop = False
              Ctl3D = False
              Enabled = False
              CaptionColor = clNone
              TreeLineColor = clBtnFace
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 2
              DataSource = ProductsDB.dsProductBarcodeRanges
              Items = <
                item
                  DataSource = ProductsDB.dsProductBarcodeRanges
                  DataField = 'Description'
                  Caption = 'Name'
                  ReadOnly = True
                  WordWrap = False
                end
                item
                  DataSource = ProductsDB.dsProductBarcodeRanges
                  DataField = 'StartValue'
                  Caption = 'Start'
                  ReadOnly = True
                  WordWrap = False
                end
                item
                  DataSource = ProductsDB.dsProductBarcodeRanges
                  DataField = 'EndValue'
                  Caption = 'End'
                  ReadOnly = True
                  WordWrap = False
                end
                item
                  DataSource = ProductsDB.dsProductBarcodeRanges
                  DataField = 'HasExceptions'
                  Caption = 'Has exceptions'
                  WordWrap = False
                end>
              CaptionWidth = 101
              Options = [ovEnterToTab, ovHighlightActiveRow, ovCenterCaptionVert]
              CaptionFont.Charset = DEFAULT_CHARSET
              CaptionFont.Color = clWindowText
              CaptionFont.Height = -11
              CaptionFont.Name = 'MS Sans Serif'
              CaptionFont.Style = []
              LineStyleCaption = ovDottedLine
              LineStyleData = ovDottedLine
              ReadOnly = True
              object cbxExceptionsExist: TCheckBox
                Left = 592
                Top = 368
                Width = 169
                Height = 15
                TabStop = False
                Alignment = taLeftJustify
                Checked = True
                State = cbChecked
                TabOrder = 0
                Visible = False
              end
            end
          end
        end
        object tbsAztecPreparedItem: TTabSheet
          Caption = 'Prepared Item'
          ImageIndex = 11
          DesignSize = (
            625
            512)
          inline AztecPreparedItemFrame: TAztecPreparedItemFrame
            Left = 1
            Top = 2
            Width = 618
            Height = 347
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            DesignSize = (
              618
              347)
            inherited lblNotes: TLabel
              Top = 258
              Anchors = [akLeft, akBottom]
            end
            inherited PortionIngredientsFrame: TPortionIngredientsFrame
              Top = 83
              Width = 608
              Height = 166
              Anchors = [akLeft, akTop, akBottom]
              DesignSize = (
                608
                166)
              inherited IngredientsGrid: TwwDBGrid
                Width = 560
                TitleFont.Color = clInfoText
              end
            end
            inherited dbMemoNotes: TDBMemo
              Top = 258
              Width = 347
            end
            inherited btnInsertIngredient: TButton
              Left = 392
              Top = 259
              Action = AztecPreparedItemFrame.PortionIngredientsFrame.InsertPortionIngredientAction
            end
            inherited btnDeleteIngredient: TButton
              Left = 504
              Top = 259
              Action = AztecPreparedItemFrame.PortionIngredientsFrame.DeletePortionIngredientAction
            end
            inherited btnEditIngredient: TButton
              Left = 504
              Top = 292
              Action = AztecPreparedItemFrame.PortionIngredientsFrame.EditPortionIngredientAction
            end
            inherited btnAppendIngredient: TButton
              Left = 392
              Top = 291
              Action = AztecPreparedItemFrame.PortionIngredientsFrame.AppendPortionIngredientAction
            end
          end
        end
        object NewPortionsTabSheet: TTabSheet
          Caption = 'Portions'
          ImageIndex = 12
          OnShow = NewPortionsTabSheetShow
          inline NewPortionIngredientsFrame: TNewPortionIngredientsFrame
            Left = 0
            Top = 0
            Width = 625
            Height = 346
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            inherited HoldingPanel: TPanel
              Width = 625
              Height = 346
              inherited ButtonPanel: TPanel
                Top = 300
                Width = 625
                DesignSize = (
                  625
                  46)
              end
              inherited BasePanel: TPanel
                Width = 625
                Height = 300
                inherited SubGridPanel: TPanel
                  Width = 625
                  Height = 255
                  inherited dbgPortions: TwwDBGrid
                    Width = 623
                    Height = 184
                    TitleFont.Color = clInfoText
                  end
                  inherited Panel3: TPanel
                    Top = 184
                    Width = 623
                    inherited dbgPortionPrices: TwwDBGrid
                      Width = 623
                      TitleFont.Color = clInfoText
                    end
                    inherited Panel2: TPanel
                      Width = 623
                    end
                  end
                end
                inherited TopPanel: TPanel
                  Width = 625
                  inherited RightPanel: TPanel
                    Left = 378
                  end
                  inherited LeftPanel: TPanel
                    Width = 40
                  end
                  inherited Panel1: TPanel
                    Left = 42
                    inherited grbMinMaxChoices: TGroupBox
                      inherited cbxChoiceEnabled: TwwCheckBox
                        Caption = ''
                      end
                      inherited wwcbAllowPlain: TwwCheckBox
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                    end
                  end
                end
              end
            end
          end
        end
        object SupplierTabSheet: TTabSheet
          Caption = 'Supplier Details'
          ImageIndex = 5
          OnShow = SupplierTabSheetShow
          inline SupplierInfoFrame: TSupplierInfoFrame
            Left = 0
            Top = 0
            Width = 625
            Height = 512
            Align = alClient
            TabOrder = 0
            DesignSize = (
              625
              512)
            inherited FutureCostlbl: TLabel
              Left = 334
              Width = 61
              Caption = 'Prices As Of:'
            end
            inherited FutureCostPricesExistlbl: TLabel
              Left = 419
            end
            inherited InvoiceNameEdit: TDBEdit
              Width = 367
            end
            inherited UnitSupplierFrame: TUnitSupplierFrame
              Width = 617
              Height = 163
              Anchors = [akLeft, akTop, akBottom]
              DesignSize = (
                617
                163)
              inherited Button2: TButton
                Top = 131
                Anchors = [akLeft, akBottom]
              end
              inherited Button3: TButton
                Top = 131
                Anchors = [akLeft, akBottom]
              end
              inherited SetDefaultSupplierButton: TButton
                Top = 131
                Anchors = [akLeft, akBottom]
              end
              inherited SetDefaultPurchaseUnitButton: TButton
                Top = 131
                Anchors = [akLeft, akBottom]
              end
              inherited FlexiDBGrid1: TFlexiDBGrid
                Width = 617
                Height = 122
                Anchors = [akLeft, akTop, akBottom]
                TitleFont.Color = clInfoText
              end
            end
            inherited CancelFutureCostBtn: TButton
              Left = 553
            end
            inherited FutureCostDateCbx: TComboBox
              Left = 401
            end
            inherited B2BNameEdit: TDBEdit
              Width = 503
            end
          end
          object DBcbDiscontinue: TDBCheckBox
            Left = 510
            Top = 17
            Width = 97
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Discontinue'
            DataField = 'Discontinue'
            DataSource = ProductsDB.EntityDataSource
            TabOrder = 1
            ValueChecked = 'D'
            ValueUnchecked = 'False'
            OnKeyDown = DBcbDiscontinueKeyDown
            OnMouseDown = DBcbDiscontinueMouseDown
          end
        end
        object TagsTabSheet: TTabSheet
          Caption = 'Tags'
          ImageIndex = 13
          OnShow = TagsTabSheetShow
          DesignSize = (
            625
            512)
          inline ProductTagsFrame: TProductTagsFrame
            Left = 7
            Top = 6
            Width = 618
            Height = 341
            Anchors = [akLeft, akTop, akBottom]
            TabOrder = 0
            DesignSize = (
              618
              341)
            inherited ScrollBox: TScrollBox
              Height = 337
            end
          end
        end
        object OtherFlagsTabSheet: TTabSheet
          Caption = 'Other'
          ImageIndex = 7
          object lCountryOfOrigin: TLabel
            Left = 8
            Top = 147
            Width = 81
            Height = 13
            Caption = 'Country of Origin:'
          end
          object AdmissionGroupBox: TGroupBox
            Left = 8
            Top = 6
            Width = 160
            Height = 125
            Caption = 'Admission'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            object cbIsAdmission: TCheckBox
              Left = 6
              Top = 24
              Width = 130
              Height = 17
              Caption = 'Is Admission'
              TabOrder = 0
              OnClick = cbIsAdmissionClick
            end
            object cbValidateMembership: TCheckBox
              Left = 6
              Top = 56
              Width = 130
              Height = 17
              Caption = 'Validate Membership'
              Enabled = False
              TabOrder = 1
              OnClick = cbValidateMembershipClick
            end
            object cbIsFootfall: TCheckBox
              Left = 6
              Top = 89
              Width = 130
              Height = 17
              Caption = 'Is Footfall'
              TabOrder = 2
              OnClick = cbIsFootfallClick
            end
          end
          object DonationGroupBox: TGroupBox
            Left = 179
            Top = 6
            Width = 160
            Height = 125
            Caption = 'Donation'
            TabOrder = 1
            object cbIsDonation: TCheckBox
              Left = 6
              Top = 24
              Width = 130
              Height = 17
              Hint = 
                'Please note this flag, restricts the product from discounts and ' +
                'promotions!'
              Caption = 'Is Donation'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = cbIsDonationClick
            end
            object cbPromptForGiftAid: TCheckBox
              Left = 6
              Top = 56
              Width = 130
              Height = 17
              Caption = 'Prompt For Gift Aid'
              Enabled = False
              TabOrder = 1
              Visible = False
              OnClick = cbPromptForGiftAidClick
            end
          end
          object CountryOfOriginTextBox: TMemo
            Left = 96
            Top = 145
            Width = 241
            Height = 34
            MaxLength = 100
            TabOrder = 2
            OnExit = CountryOfOriginTextBoxExit
          end
        end
      end
    end
    object SharedDataPanel: TPanel
      Left = 8
      Top = 8
      Width = 604
      Height = 176
      Alignment = taLeftJustify
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      object DescriptionLabel: TLabel
        Left = 2
        Top = 32
        Width = 57
        Height = 25
        AutoSize = False
        Caption = 'Description:'
        Layout = tlCenter
      end
      object Label14: TLabel
        Left = 369
        Top = 73
        Width = 66
        Height = 25
        AutoSize = False
        Caption = 'Product Type:'
        Layout = tlCenter
      end
      object Label23: TLabel
        Left = 369
        Top = 98
        Width = 73
        Height = 25
        AutoSize = False
        Caption = 'Date Created:'
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 2
        Top = 101
        Width = 89
        Height = 25
        AutoSize = False
        Caption = 'Import/Export Ref:'
        Layout = tlCenter
      end
      object PrintStreamLabel: TLabel
        Left = 369
        Top = 124
        Width = 65
        Height = 25
        AutoSize = False
        Caption = 'Print Stream:'
        Layout = tlCenter
      end
      object RetailNameLabel: TLabel
        Left = 2
        Top = 0
        Width = 81
        Height = 25
        AutoSize = False
        Caption = 'Retail Name:'
        Layout = tlCenter
      end
      object SpecialLabel: TLabel
        Left = 550
        Top = 78
        Width = 50
        Height = 13
        Caption = '(SPECIAL)'
      end
      object SubcategoryLabel: TLabel
        Left = 1
        Top = 74
        Width = 65
        Height = 25
        AutoSize = False
        Caption = 'Subcategory:'
        Layout = tlCenter
      end
      object TouchScreenLabel: TLabel
        Left = 362
        Top = 0
        Width = 114
        Height = 20
        AutoSize = False
        Caption = 'Touch Screen Name:'
        Layout = tlCenter
      end
      object EntityCodeLabel: TLabel
        Left = 2
        Top = 128
        Width = 82
        Height = 25
        AutoSize = False
        Caption = 'Entity Code:'
        Layout = tlCenter
      end
      object lblKDSItemID: TLabel
        Left = 369
        Top = 151
        Width = 66
        Height = 25
        AutoSize = False
        Caption = 'KDS Item ID:'
        Layout = tlCenter
      end
      object DBEdit17: TDBEdit
        Left = 440
        Top = 101
        Width = 123
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'Creation Date'
        DataSource = ProductsDB.EntityDataSource
        ReadOnly = True
        TabOrder = 7
      end
      object DescriptionEditBox: TDBEdit
        Left = 96
        Top = 32
        Width = 176
        Height = 21
        DataField = 'Retail Description'
        DataSource = ProductsDB.EntityDataSource
        TabOrder = 1
        OnChange = DescriptionEditBoxChange
      end
      object ExtendedNameEditBox: TDBEdit
        Left = 96
        Top = 5
        Width = 175
        Height = 21
        DataField = 'Extended Rtl Name'
        DataSource = ProductsDB.EntityDataSource
        TabOrder = 0
      end
      object ImportExportRefEditBox: TDBEdit
        Left = 96
        Top = 103
        Width = 177
        Height = 21
        DataField = 'Import/Export Reference'
        DataSource = ProductsDB.EntityDataSource
        TabOrder = 9
        OnExit = ImportExportRefEditBoxExit
      end
      object LineTypeComboBox: TDBLookupComboBox
        Left = 440
        Top = 75
        Width = 105
        Height = 21
        DataField = 'Entity Type'
        DataSource = ProductsDB.EntityDataSource
        DropDownAlign = daRight
        DropDownRows = 8
        DropDownWidth = 240
        KeyField = 'ProductType'
        ListField = 'DisplayProductType; Description'
        ListSource = ProductsDB.ProductTypesDS
        TabOrder = 3
        OnKeyDown = LineTypeComboBoxKeyDown
        OnKeyPress = LineTypeComboBoxKeyPress
      end
      object pnl3by8: TPanel
        Left = 472
        Top = 1
        Width = 68
        Height = 54
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInfoText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        object AztecEposButton1: TDBMemo
          Left = -32
          Top = 0
          Width = 128
          Height = 17
          Alignment = taCenter
          BevelEdges = [beTop]
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DataField = 'AztecEposButton1'
          DataSource = ProductsDB.EntityDataSource
          MaxLength = 8
          TabOrder = 0
          WantReturns = False
          WordWrap = False
        end
        object AztecEposButton2: TDBMemo
          Left = -32
          Top = 17
          Width = 128
          Height = 17
          TabStop = False
          Alignment = taCenter
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DataField = 'AztecEposButton2'
          DataSource = ProductsDB.EntityDataSource
          MaxLength = 8
          TabOrder = 1
          WantReturns = False
          WordWrap = False
        end
        object AztecEposButton3: TDBMemo
          Left = -32
          Top = 34
          Width = 128
          Height = 16
          TabStop = False
          Alignment = taCenter
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DataField = 'AztecEposButton3'
          DataSource = ProductsDB.EntityDataSource
          MaxLength = 8
          TabOrder = 2
          WantReturns = False
          WordWrap = False
        end
      end
      object PrintStreamComboBox: TAztecDBComboBox
        Left = 440
        Top = 128
        Width = 164
        Height = 21
        AutoDropDown = True
        DataField = 'Default Printer Stream'
        DataSource = ProductsDB.EntityDataSource
        ItemHeight = 13
        TabOrder = 11
        OnCreateNew = PrintStreamComboBoxCreateNew
        OnExit = ComboBoxExit
      end
      object SubcategoryComboBox: TAztecDBComboBox
        Left = 96
        Top = 76
        Width = 177
        Height = 21
        AutoDropDown = True
        DataField = 'Sub-Category Name'
        DataSource = ProductsDB.EntityDataSource
        DropDownCount = 25
        ItemHeight = 13
        TabOrder = 2
        OnCloseUp = SubcategoryComboBoxCloseUp
        OnCreateNew = SubcategoryComboBoxCreateNew
        OnExit = ComboBoxExit
      end
      object EntityCodeEditBox: TDBEdit
        Left = 96
        Top = 131
        Width = 177
        Height = 21
        Color = clBtnFace
        DataField = 'EntityCode'
        DataSource = ProductsDB.EntityDataSource
        ReadOnly = True
        TabOrder = 4
      end
      object edtKDSItemID: TEdit
        Left = 440
        Top = 154
        Width = 81
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
        Text = 'edtKDSItemID'
      end
      object DBCheckBoxSoldByWeight: TDBCheckBox
        Left = 0
        Top = 157
        Width = 108
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Sold by Weight:'
        DataField = 'SoldByWeight'
        DataSource = ProductsDB.EntityDataSource
        TabOrder = 6
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxSoldByWeightClick
      end
      object btnEQATECExceptionTest: TButton
        Left = 296
        Top = 40
        Width = 161
        Height = 25
        Caption = 'EQATEC Exception Test'
        TabOrder = 8
        Visible = False
        OnClick = btnEQATECExceptionTestClick
      end
    end
  end
  object ActionList1: TActionList
    Left = 80
    Top = 320
    object AddItemAction: TAction
      Caption = 'New'
      Hint = 
        'Create a new product using some settings of selected product. Ex' +
        'cludes: Ingredients, Purchase Units, Tags'
      OnExecute = AddItemActionExecute
    end
    object DeleteItemAction: TAction
      Caption = 'Delete'
      Hint = 'Delete the selected product'
      OnExecute = DeleteItemActionExecute
      OnUpdate = DeleteItemActionUpdate
    end
    object actIsGiftCard: TAction
      AutoCheck = True
      Caption = 'Is Gift Card'
      OnExecute = actIsGiftCardExecute
      OnUpdate = actIsGiftCardUpdate
    end
    object CloneItemAction: TAction
      Caption = 'Clone'
      Hint = 'Create a copy of the selected product.'
      OnExecute = CloneItemActionExecute
      OnUpdate = CloneItemActionUpdate
    end
  end
  object AutoScrollEposButtonTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = AutoScrollEposButtonTimerTimer
    Left = 856
    Top = 16
  end
  object EntityListDataSet: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    DisableStringTrim = True
    Params = <>
    ReadOnly = True
    BeforeScroll = EntityListDataSetBeforeScroll
    AfterScroll = EntityListDataSetAfterScroll
    Left = 48
    Top = 112
    object EntityListDataSetEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object EntityListDataSetRetailName: TStringField
      DisplayLabel = 'Retail Name'
      FieldName = 'Extended RTL Name'
      OnGetText = EntityListDataSetFieldGetText
    end
    object EntityListDataSetRetailDescription: TStringField
      FieldName = 'Retail Description'
      OnGetText = EntityListDataSetFieldGetText
    end
    object EntityListDataSetEntityType: TStringField
      FieldName = 'Entity Type'
      OnGetText = EntityListDataSetEntityTypeGetText
    end
    object EntityListDataSetDeleted: TStringField
      FieldName = 'Deleted'
    end
    object EntityListDataSetSubCategoryName: TStringField
      FieldName = 'Sub-Category Name'
    end
    object EntityListDataSetDiscontinue: TBooleanField
      FieldName = 'Discontinue'
    end
    object EntityListDataSetDefaultPrinterStream: TStringField
      FieldName = 'Default Printer Stream'
    end
    object EntityListDataSetRMControlled: TFloatField
      FieldKind = fkLookup
      FieldName = 'RMControlled'
      LookupDataSet = ProductsDB.adotRMControlled
      LookupKeyFields = 'AztecProductID'
      LookupResultField = 'AztecProductID'
      KeyFields = 'EntityCode'
      Lookup = True
    end
    object EntityListDataSetPurchaseName: TStringField
      FieldName = 'Purchase Name'
    end
    object EntityListDataSetCourseId: TIntegerField
      FieldName = 'CourseId'
    end
    object EntityListDataSetImportExportReference: TStringField
      FieldName = 'Import/Export Reference'
      Size = 15
    end
    object EntityListDataSetB2BName: TStringField
      FieldName = 'B2BName'
      Size = 100
    end
  end
  object EntityListDataSource: TDataSource
    AutoEdit = False
    DataSet = EntityListDataSet
    OnDataChange = EntityListDataSourceDataChange
    Left = 48
    Top = 144
  end
end
