object fSiteTemplates: TfSiteTemplates
  Left = 524
  Top = 255
  Width = 688
  Height = 470
  Caption = 'Site Templates'
  Color = clBtnFace
  Constraints.MinHeight = 470
  Constraints.MinWidth = 688
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    672
    431)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 592
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 504
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object dbgSiteTemplate: TwwDBGrid
    Left = 8
    Top = 8
    Width = 657
    Height = 313
    ControlType.Strings = (
      'PriorityTemplateId;CustomEdit;dbcTemplateName;F'
      'TemplateName;CustomEdit;dbcTemplateName;T')
    Selected.Strings = (
      'Reference'#9'10'#9'Reference'#9'T'
      'SiteName'#9'20'#9'Site Name'#9'T'
      'TemplateName'#9'50'#9'Template Name'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = dmPromotions.dsSitePriorityTemplate
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object dbcTemplateName: TwwDBLookupCombo
    Left = 368
    Top = 72
    Width = 304
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Name'#9'50'#9'Name'#9'F')
    DataField = 'PriorityTemplateId'
    DataSource = dmPromotions.dsSitePriorityTemplate
    LookupTable = dmPromotions.qPromotionPriorityTemplate
    LookupField = 'Id'
    TabOrder = 1
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object pnlFilters: TPanel
    Left = 8
    Top = 328
    Width = 657
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      657
      65)
    object lblCompany: TLabel
      Left = 8
      Top = 8
      Width = 44
      Height = 13
      Caption = 'Company'
    end
    object lblArea: TLabel
      Left = 280
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Area'
    end
    object lblTextFilter: TLabel
      Left = 8
      Top = 36
      Width = 46
      Height = 13
      Caption = 'Text Filter'
    end
    object edtTextFilter: TEdit
      Left = 64
      Top = 32
      Width = 209
      Height = 21
      TabOrder = 2
    end
    object btnApplyFilters: TButton
      Left = 560
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Apply Filters'
      TabOrder = 5
      OnClick = btnApplyFiltersClick
    end
    object btnClearFilters: TButton
      Left = 560
      Top = 32
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Clear Filters'
      TabOrder = 6
      OnClick = btnClearFiltersClick
    end
    object cbCompany: TComboBox
      Left = 64
      Top = 4
      Width = 209
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbCompanyChange
    end
    object cbArea: TComboBox
      Left = 312
      Top = 4
      Width = 209
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object chbxFilterBySiteTags: TCheckBox
      Left = 280
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Filter By Site Tags'
      TabOrder = 3
    end
    object btnTags: TButton
      Left = 400
      Top = 28
      Width = 57
      Height = 25
      Caption = 'Tags'
      TabOrder = 4
      OnClick = btnTagsClick
    end
  end
  object qSiteTags: TADOQuery
    Connection = dmPromotions.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'select SiteID from ac_SiteTag where TagId in (select TagID from ' +
        '#Tags)')
    Left = 264
    Top = 400
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = evntMouseWheelCatcherMessage
    Left = 120
    Top = 400
  end
end
