object EntityFilterForm: TEntityFilterForm
  Left = 728
  Top = 141
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Product List Filter'
  ClientHeight = 523
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShortCut = FormShortCut
  OnShow = FormShow
  DesignSize = (
    453
    523)
  PixelsPerInch = 96
  TextHeight = 16
  object pnlButtons: TPanel
    Left = 194
    Top = 488
    Width = 256
    Height = 33
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      256
      33)
    object okButton: TButton
      Left = 4
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
    end
    object clearFilterButton: TButton
      Left = 168
      Top = 6
      Width = 79
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Clear Filter (F2)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = clearFilterButtonClick
    end
    object cancelButton: TButton
      Left = 87
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cancelButtonClick
    end
  end
  object pnlActiveFilters: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 265
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      185
      265)
    object lblActiveFilters: TLabel
      Left = 8
      Top = 8
      Width = 83
      Height = 13
      Caption = 'Active Filters: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rtbActiveFilters: TRichEdit
      Left = 8
      Top = 24
      Width = 169
      Height = 233
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        'rtbActiveFilters')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 272
    Width = 185
    Height = 251
    Anchors = [akLeft, akTop, akBottom]
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      185
      251)
    object lblMenuLabel: TLabel
      Left = 5
      Top = 6
      Width = 99
      Height = 13
      Caption = 'Select filter to display'
    end
    object btnTextFilter: TButton
      Left = 0
      Top = 21
      Width = 185
      Height = 27
      Action = acnShowTextFilter
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnProductStructure: TButton
      Left = 0
      Top = 49
      Width = 185
      Height = 27
      Action = acnShowProdStructure
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnProductSetUp: TButton
      Left = 0
      Top = 77
      Width = 185
      Height = 27
      Action = acnShowProdSetUp
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnProductTags: TButton
      Left = 0
      Top = 105
      Width = 185
      Height = 27
      Action = acnShowProdTags
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnBarcodeFilters: TButton
      Left = 0
      Top = 133
      Width = 185
      Height = 27
      Action = acnShowBarcode
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object btnSupplierDetails: TButton
      Left = 0
      Top = 161
      Width = 185
      Height = 27
      Action = acnShowSupplier
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object btnEntityCode: TButton
      Left = 0
      Top = 189
      Width = 185
      Height = 27
      Action = acnShowEntityCode
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object pcMainWindow: TPageControl
    Left = 187
    Top = 0
    Width = 264
    Height = 489
    ActivePage = tsBarcode
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object tsTextFilter: TTabSheet
      Caption = 'Text Filter'
      TabVisible = False
      OnHide = tsTextFilterHide
      OnShow = tsTextFilterShow
      DesignSize = (
        256
        479)
      object lblTextFilter: TLabel
        Left = 8
        Top = 16
        Width = 58
        Height = 13
        Caption = 'Text Filter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSearchIn: TLabel
        Left = 8
        Top = 96
        Width = 49
        Height = 13
        Caption = 'Search In:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblEdText: TLabel
        Left = 8
        Top = 35
        Width = 72
        Height = 13
        Caption = 'Search for text:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edText: TEdit
        Left = 8
        Top = 51
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        TabOrder = 0
        Text = '*'
        OnChange = edTextChange
      end
      object cbName: TCheckBox
        Left = 8
        Top = 109
        Width = 97
        Height = 17
        Caption = 'Product Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = textCheckBoxClick
      end
      object cbMidwordSearch: TCheckBox
        Left = 8
        Top = 167
        Width = 105
        Height = 17
        Caption = 'Midword search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object cbInvoiceName: TCheckBox
        Left = 128
        Top = 109
        Width = 97
        Height = 17
        Caption = 'Invoice Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = textCheckBoxClick
      end
      object cbImportExportRef: TCheckBox
        Left = 128
        Top = 125
        Width = 121
        Height = 17
        Caption = 'Import/Export Ref'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = textCheckBoxClick
      end
      object cbDescription: TCheckBox
        Left = 8
        Top = 125
        Width = 113
        Height = 17
        Caption = 'Product Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = textCheckBoxClick
      end
      object cbB2BName: TCheckBox
        Left = 8
        Top = 141
        Width = 97
        Height = 17
        Caption = 'B2B Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = textCheckBoxClick
      end
      object cbTextSearchForBlank: TCheckBox
        Left = 8
        Top = 74
        Width = 177
        Height = 17
        Caption = 'Search for blank values'
        TabOrder = 1
        OnClick = cbTextSearchForBlankClick
      end
    end
    object tsProductStructure: TTabSheet
      Caption = 'Product Structure'
      ImageIndex = 1
      TabVisible = False
      OnHide = tsProductStructureHide
      OnShow = tsProductStructureShow
      DesignSize = (
        256
        479)
      object lblSupercategory: TLabel
        Left = 8
        Top = 219
        Width = 69
        Height = 13
        Caption = 'Supercategory'
      end
      object lblSubdivision: TLabel
        Left = 23
        Top = 131
        Width = 54
        Height = 13
        Caption = 'Subdivision'
      end
      object lblSubcategory: TLabel
        Left = 17
        Top = 395
        Width = 60
        Height = 13
        Caption = 'Subcategory'
      end
      object lblProductStructure: TLabel
        Left = 8
        Top = 16
        Width = 101
        Height = 13
        Caption = 'Product Structure'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDivision: TLabel
        Left = 40
        Top = 43
        Width = 37
        Height = 13
        Caption = 'Division'
      end
      object lblCategory: TLabel
        Left = 35
        Top = 307
        Width = 42
        Height = 13
        Caption = 'Category'
      end
      object clbSupercategory: TExtendedCheckListBox
        Left = 84
        Top = 213
        Width = 166
        Height = 84
        OnClickCheck = clbSupercategoryClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 2
      end
      object clbSubdivision: TExtendedCheckListBox
        Left = 84
        Top = 125
        Width = 166
        Height = 84
        OnClickCheck = clbSubdivisionClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 1
      end
      object clbSubcategory: TExtendedCheckListBox
        Left = 84
        Top = 389
        Width = 166
        Height = 84
        OnClickCheck = clbSubcategoryClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 4
      end
      object clbDivision: TExtendedCheckListBox
        Left = 84
        Top = 37
        Width = 166
        Height = 84
        OnClickCheck = clbDivisionClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 0
      end
      object clbCategory: TExtendedCheckListBox
        Left = 84
        Top = 301
        Width = 166
        Height = 84
        OnClickCheck = clbCategoryClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object tsProductSetUp: TTabSheet
      Caption = 'Product Set Up'
      ImageIndex = 2
      TabVisible = False
      OnHide = tsProductSetUpHide
      OnShow = tsProductSetUpShow
      DesignSize = (
        256
        479)
      object lblTaxRule: TLabel
        Left = 8
        Top = 375
        Width = 70
        Height = 13
        Caption = 'Uses Tax Rule'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProductType: TLabel
        Left = 14
        Top = 43
        Width = 64
        Height = 13
        Caption = 'Product Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProductSetUp: TLabel
        Left = 8
        Top = 16
        Width = 88
        Height = 13
        Caption = 'Product Set Up'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrintStream: TLabel
        Left = 21
        Top = 126
        Width = 57
        Height = 13
        Caption = 'Print Stream'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblPortion: TLabel
        Left = 18
        Top = 292
        Width = 60
        Height = 13
        Caption = 'Uses Portion'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDiscontinue: TLabel
        Left = 16
        Top = 459
        Width = 62
        Height = 13
        Caption = 'Discontinued'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCourse: TLabel
        Left = 45
        Top = 209
        Width = 33
        Height = 13
        Caption = 'Course'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object clbUsesTaxRule: TExtendedCheckListBox
        Left = 84
        Top = 369
        Width = 166
        Height = 78
        OnClickCheck = clbUsesTaxRuleClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 4
      end
      object clbUsesPortion: TExtendedCheckListBox
        Left = 84
        Top = 286
        Width = 166
        Height = 78
        OnClickCheck = clbUsesPortionClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
      end
      object clbPrintStream: TExtendedCheckListBox
        Left = 84
        Top = 120
        Width = 166
        Height = 78
        OnClickCheck = clbPrintStreamClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
      end
      object clbLineType: TExtendedCheckListBox
        Left = 84
        Top = 37
        Width = 166
        Height = 78
        OnClickCheck = clbLineTypeClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
      end
      object clbCourse: TExtendedCheckListBox
        Left = 84
        Top = 203
        Width = 166
        Height = 78
        OnClickCheck = clbCourseClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
      end
      object cbDiscontinue: TComboBox
        Left = 84
        Top = 455
        Width = 142
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 5
        Text = '<Any>'
        OnChange = productSetUpFiltersChanged
        OnExit = cbDiscontinueExit
      end
    end
    object tsProductTags: TTabSheet
      Caption = 'Product Tags'
      ImageIndex = 3
      TabVisible = False
      OnHide = tsProductTagsHide
      OnShow = tsProductTagsShow
      DesignSize = (
        256
        479)
      object lblTagGroup: TLabel
        Left = 48
        Top = 43
        Width = 29
        Height = 13
        Caption = 'Group'
      end
      object lblTag: TLabel
        Left = 58
        Top = 395
        Width = 19
        Height = 13
        Caption = 'Tag'
      end
      object lblSubsection: TLabel
        Left = 19
        Top = 307
        Width = 58
        Height = 13
        Caption = 'Sub-Section'
      end
      object lblSubgroup: TLabel
        Left = 26
        Top = 131
        Width = 51
        Height = 13
        Caption = 'Sub-Group'
      end
      object lblSection: TLabel
        Left = 41
        Top = 219
        Width = 36
        Height = 13
        Caption = 'Section'
      end
      object lblProductTags: TLabel
        Left = 8
        Top = 16
        Width = 77
        Height = 13
        Caption = 'Product Tags'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object clbTagGroup: TExtendedCheckListBox
        Left = 84
        Top = 37
        Width = 166
        Height = 84
        OnClickCheck = clbTagGroupClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 0
      end
      object clbTag: TExtendedCheckListBox
        Left = 84
        Top = 389
        Width = 166
        Height = 84
        OnClickCheck = clbTagClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 4
      end
      object clbSubsection: TExtendedCheckListBox
        Left = 84
        Top = 301
        Width = 166
        Height = 84
        OnClickCheck = clbSubsectionClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 3
      end
      object clbSubgroup: TExtendedCheckListBox
        Left = 84
        Top = 125
        Width = 166
        Height = 84
        OnClickCheck = clbSubgroupClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 1
      end
      object clbSection: TExtendedCheckListBox
        Left = 84
        Top = 213
        Width = 166
        Height = 84
        OnClickCheck = clbSectionClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        ItemHeight = 13
        TabOrder = 2
      end
    end
    object tsBarcode: TTabSheet
      Caption = 'Barcode'
      ImageIndex = 4
      TabVisible = False
      OnHide = tsBarcodeHide
      OnShow = tsBarcodeShow
      DesignSize = (
        256
        479)
      object lblBarcodeFilters: TLabel
        Left = 8
        Top = 16
        Width = 86
        Height = 13
        Caption = 'Barcode Filters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblBarcode: TLabel
        Left = 8
        Top = 39
        Width = 83
        Height = 13
        Caption = 'Filter for Barcode:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edBarcode: TEdit
        Left = 8
        Top = 55
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 13
        ParentFont = False
        TabOrder = 0
        Text = '*'
        OnChange = productSetUpFiltersChanged
      end
      object cbBarcodeSearchForBlank: TCheckBox
        Left = 8
        Top = 77
        Width = 233
        Height = 17
        Caption = 'Search for products with no barcode'
        TabOrder = 1
        OnClick = cbBarcodeSearchForBlankClick
      end
      object ThreeDigitBarcodeSearchFilterChkBx: TCheckBox
        Left = 8
        Top = 96
        Width = 233
        Height = 17
        Caption = 'Search for custom priced barcode'
        TabOrder = 2
      end
    end
    object tsSupplierDetails: TTabSheet
      Caption = 'Supplier Details'
      ImageIndex = 5
      TabVisible = False
      OnHide = tsSupplierDetailsHide
      OnShow = tsSupplierDetailsShow
      DesignSize = (
        256
        479)
      object lblSupplierRef: TLabel
        Left = 8
        Top = 39
        Width = 104
        Height = 13
        Caption = 'Supplier Ref Includes:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSupplierFilters: TLabel
        Left = 8
        Top = 16
        Width = 85
        Height = 13
        Caption = 'Supplier Filters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSupplier: TLabel
        Left = 39
        Top = 107
        Width = 38
        Height = 13
        Caption = 'Supplier'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edSupplierRef: TEdit
        Left = 8
        Top = 55
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 15
        ParentFont = False
        TabOrder = 0
        Text = '*'
        OnChange = productSetUpFiltersChanged
      end
      object clbSupplier: TExtendedCheckListBox
        Left = 83
        Top = 101
        Width = 166
        Height = 84
        OnClickCheck = clbSupplierClickCheck
        Anchors = [akLeft, akTop, akRight]
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
      end
      object cbSupplierRefSearchForBlank: TCheckBox
        Left = 8
        Top = 77
        Width = 225
        Height = 17
        Caption = 'Search for blank values'
        TabOrder = 1
        OnClick = cbSupplierRefSearchForBlankClick
      end
    end
    object tsEntityCode: TTabSheet
      Caption = 'Entity Code'
      ImageIndex = 6
      TabVisible = False
      OnHide = tsEntityCodeHide
      OnShow = tsEntityCodeShow
      DesignSize = (
        256
        479)
      object lblEntityFilter: TLabel
        Left = 8
        Top = 16
        Width = 98
        Height = 13
        Caption = 'Entity Code Filter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEntityCode: TLabel
        Left = 8
        Top = 39
        Width = 54
        Height = 13
        Caption = 'Entity Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtEntityCode: TEdit
        Left = 8
        Top = 55
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 0
        Text = 'edtEntityCode'
        OnChange = productSetUpFiltersChanged
      end
    end
  end
  object ProductStructureTreeQuery: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT div.Id as DivisionId,'
      #9'div.Name as division,'
      #9'subdiv.Id as SubdivId,'
      #9'subdiv.Name as subdivision,'
      #9'supcat.Id as SupcatId,'
      #9'supcat.Name as supercategory,'
      #9'cat.Id as CatId,'
      #9'cat.Name as category,'
      #9'subcat.Id as SubcatId,'
      #9'subcat.Name as subcategory'
      'FROM ac_productDivision div'
      '  INNER JOIN ac_ProductSubDivision subdiv'
      '    ON div.Id = subdiv.ProductDivisionId'
      '  INNER JOIN ac_ProductSuperCategory supcat'
      '    ON supcat.ProductSubDivisionId = subdiv.Id'
      '  INNER JOIN ac_ProductCategory cat'
      '    ON cat.ProductSuperCategoryId = supcat.Id'
      '  INNER JOIN ac_ProductSubCategory subcat'
      '    ON subcat.ProductCategoryId = cat.Id')
    Left = 152
    Top = 8
  end
  object productTagTreeQuery: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'SELECT t.Id as TagId, t.Name as Tag, ss.Id as SubSectionId, ss.N' +
        'ame as SubSection, ts.Id as SectionId, ts.Name as Section,'
      
        #9'sg.Id as SubGroupId, sg.Name as SubGroup, tg.Id as GroupId, tg.' +
        'Name as TagGroup'
      'FROM ac_Tag t'
      'INNER JOIN ac_TagSubSection ss'
      #9'ON t.TagSubSectionId = ss.Id'
      'INNER JOIN ac_TagSection ts'
      #9'ON ss.TagSectionId = ts.Id'
      'INNER JOIN ac_TagSubGroup sg'
      #9'ON ts.TagSubGroupId = sg.Id'
      'INNER JOIN ac_TagGroup tg'
      #9'ON sg.TagGroupId = tg.Id'
      'WHERE t.IsProductTag = 1')
    Left = 151
    Top = 40
    object productTagTreeQueryTag: TStringField
      FieldName = 'Tag'
    end
    object productTagTreeQuerySubSection: TStringField
      FieldName = 'SubSection'
    end
    object productTagTreeQuerySectionId: TIntegerField
      FieldName = 'SectionId'
    end
    object productTagTreeQuerySection: TStringField
      FieldName = 'Section'
    end
    object productTagTreeQuerySubGroupId: TIntegerField
      FieldName = 'SubGroupId'
    end
    object productTagTreeQuerySubGroup: TStringField
      FieldName = 'SubGroup'
    end
    object productTagTreeQueryGroupId: TIntegerField
      FieldName = 'GroupId'
    end
    object productTagTreeQueryTagGroup: TStringField
      FieldName = 'TagGroup'
    end
    object productTagTreeQueryTagId: TIntegerField
      FieldName = 'TagId'
    end
    object productTagTreeQuerySubSectionId: TIntegerField
      FieldName = 'SubSectionId'
    end
  end
  object ActionList1: TActionList
    Left = 152
    Top = 488
    object acnShowTextFilter: TAction
      Category = 'Show/Hide'
      Caption = 'Text Filter'
      OnExecute = acnShowTextFilterExecute
    end
    object acnShowProdStructure: TAction
      Category = 'Show/Hide'
      Caption = 'Product Structure'
      OnExecute = acnShowProdStructureExecute
    end
    object acnShowProdSetUp: TAction
      Category = 'Show/Hide'
      Caption = 'Product Set Up'
      OnExecute = acnShowProdSetUpExecute
    end
    object acnShowProdTags: TAction
      Category = 'Show/Hide'
      Caption = 'Product Tags'
      OnExecute = acnShowProdTagsExecute
    end
    object acnShowSupplier: TAction
      Category = 'Show/Hide'
      Caption = 'Supplier Filters'
      OnExecute = acnShowSupplierExecute
    end
    object acnShowBarcode: TAction
      Category = 'Show/Hide'
      Caption = 'Barcode Filters'
      OnExecute = acnShowBarcodeExecute
    end
    object acnShowEntityCode: TAction
      Category = 'Show/Hide'
      Caption = 'Entity Code'
      OnExecute = acnShowEntityCodeExecute
    end
  end
end
