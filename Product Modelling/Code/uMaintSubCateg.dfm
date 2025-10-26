object fMaintSubCateg: TfMaintSubCateg
  Left = 761
  Top = 221
  BorderStyle = bsDialog
  Caption = 'New Sub-Category'
  ClientHeight = 459
  ClientWidth = 344
  Color = clBtnFace
  Constraints.MaxWidth = 360
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    344
    459)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 344
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Sub-Category'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DivisionLabel: TLabel
    Left = 15
    Top = 44
    Width = 40
    Height = 13
    Caption = 'Division:'
  end
  object CategoryLabel: TLabel
    Left = 15
    Top = 124
    Width = 45
    Height = 13
    Caption = 'Category:'
  end
  object NameLabel: TLabel
    Left = 15
    Top = 151
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object lblMinCustAge: TLabel
    Left = 15
    Top = 404
    Width = 92
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Min. Customer Age:'
    Enabled = False
    WordWrap = True
  end
  object DescriptionLabel: TLabel
    Left = 16
    Top = 177
    Width = 56
    Height = 13
    Caption = 'Description:'
  end
  object lblSubDivision: TLabel
    Left = 15
    Top = 71
    Width = 62
    Height = 13
    Caption = 'Sub Division:'
  end
  object lblSuperCategory: TLabel
    Left = 15
    Top = 98
    Width = 73
    Height = 13
    Caption = 'Super Category'
  end
  object edtSubCategName: TEdit
    Left = 109
    Top = 147
    Width = 210
    Height = 21
    MaxLength = 20
    TabOrder = 4
  end
  object btnOK: TButton
    Left = 186
    Top = 429
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 9
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 266
    Top = 429
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 10
  end
  object cmbbxDivision: TComboBox
    Left = 109
    Top = 40
    Width = 210
    Height = 21
    AutoDropDown = True
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnExit = cmbbxDivisionExit
  end
  object cmbbxCategory: TComboBox
    Left = 109
    Top = 120
    Width = 210
    Height = 21
    AutoDropDown = True
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object btnDivision: TButton
    Left = 319
    Top = 40
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = btnDivisionClick
  end
  object btnCategory: TButton
    Left = 319
    Top = 120
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnCategoryClick
  end
  object sedtMinCustomerAge: TwwDBSpinEdit
    Left = 109
    Top = 400
    Width = 56
    Height = 21
    Anchors = [akLeft, akBottom]
    Increment = 1
    MaxValue = 99
    MinValue = 1
    Value = 1
    DataField = 'MinimumCustomerAge'
    Enabled = False
    TabOrder = 8
    UnboundDataType = wwDefault
    OnChange = sedtMinCustomerAgeChange
  end
  object AllowSitePricingCheckBox: TCheckBox
    Left = 109
    Top = 305
    Width = 100
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Allow Site Pricing'
    TabOrder = 6
  end
  object CoverCountCheckBox: TCheckBox
    Left = 109
    Top = 353
    Width = 80
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Cover Count'
    TabOrder = 7
  end
  object CategoryDescriptionMemo: TMemo
    Left = 109
    Top = 177
    Width = 210
    Height = 120
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object AgeRestrictionComboBox: TCheckBox
    Left = 109
    Top = 377
    Width = 96
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Age Restriction'
    TabOrder = 11
    OnClick = AgeRestrictionComboBoxClick
  end
  object cmbbxSuperCategory: TComboBox
    Left = 109
    Top = 94
    Width = 210
    Height = 21
    AutoDropDown = True
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 12
    OnExit = cmbbxSuperCategoryExit
  end
  object cmbbxSubDivision: TComboBox
    Left = 109
    Top = 67
    Width = 210
    Height = 21
    AutoDropDown = True
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 13
    OnExit = cmbbxSubDivisionExit
  end
  object btnSubDivision: TButton
    Left = 319
    Top = 67
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 14
    OnClick = btnSubDivisionClick
  end
  object btnSuperCategory: TButton
    Left = 319
    Top = 94
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 15
    OnClick = btnSuperCategoryClick
  end
  object cbAllowSiteNaming: TCheckBox
    Left = 109
    Top = 329
    Width = 116
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Allow Site Naming'
    TabOrder = 16
  end
  object ActionListSubCat: TActionList
    Left = 2
    Top = 312
    object ActionAgeRestriction: TAction
      Caption = 'Age Restriction'
    end
  end
end
