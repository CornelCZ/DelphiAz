object TCoursesAndTaxRulesFrame: TTCoursesAndTaxRulesFrame
  Left = 0
  Top = 0
  Width = 464
  Height = 332
  TabOrder = 0
  object lblAlcohol: TLabel
    Left = 8
    Top = 310
    Width = 57
    Height = 25
    AutoSize = False
    Caption = '% Alcohol:'
    Layout = tlCenter
  end
  object TaxRuleGroupBox: TGroupBox
    Left = 8
    Top = 6
    Width = 265
    Height = 161
    Caption = 'Tax Rules'
    TabOrder = 0
    object TaxRuleLabel1: TLabel
      Left = 58
      Top = 31
      Width = 9
      Height = 13
      Caption = '1:'
    end
    object TaxRuleLabel2: TLabel
      Left = 58
      Top = 63
      Width = 9
      Height = 13
      Caption = '2:'
    end
    object TaxRuleLabel3: TLabel
      Left = 58
      Top = 96
      Width = 9
      Height = 13
      Caption = '3:'
    end
    object TaxRuleLabel4: TLabel
      Left = 58
      Top = 129
      Width = 9
      Height = 13
      Caption = '4:'
    end
    object AztecDBLookupBox1: TAztecDBLookupBox
      Left = 87
      Top = 27
      Width = 145
      Height = 21
      DataField = 'TaxRule1'
      DataSource = ProductsDB.ProductTaxDS
      ItemHeight = 13
      KeyField = 'Id'
      ListField = 'Name'
      ListSource = ProductsDB.dsTaxRules
      ShowCreateNew = False
      TabOrder = 0
      OnChange = TaxRuleSelected
      OnExit = TaxRuleSelected
    end
    object AztecDBLookupBox2: TAztecDBLookupBox
      Left = 87
      Top = 59
      Width = 145
      Height = 21
      DataField = 'TaxRule2'
      DataSource = ProductsDB.ProductTaxDS
      ItemHeight = 13
      KeyField = 'Id'
      ListField = 'Name'
      ListSource = ProductsDB.dsTaxRules
      ShowCreateNew = False
      TabOrder = 1
      OnChange = TaxRuleSelected
      OnExit = TaxRuleSelected
    end
    object AztecDBLookupBox3: TAztecDBLookupBox
      Left = 87
      Top = 92
      Width = 145
      Height = 21
      DataField = 'TaxRule3'
      DataSource = ProductsDB.ProductTaxDS
      ItemHeight = 13
      KeyField = 'Id'
      ListField = 'Name'
      ListSource = ProductsDB.dsTaxRules
      ShowCreateNew = False
      TabOrder = 2
      OnChange = TaxRuleSelected
      OnExit = TaxRuleSelected
    end
    object AztecDBLookupBox4: TAztecDBLookupBox
      Left = 87
      Top = 125
      Width = 145
      Height = 21
      DataField = 'TaxRule4'
      DataSource = ProductsDB.ProductTaxDS
      ItemHeight = 13
      KeyField = 'Id'
      ListField = 'Name'
      ListSource = ProductsDB.dsTaxRules
      ShowCreateNew = False
      TabOrder = 3
      OnChange = TaxRuleSelected
      OnExit = TaxRuleSelected
    end
  end
  object childBehaviourGroupBox: TGroupBox
    Left = 8
    Top = 182
    Width = 449
    Height = 121
    Caption = 'Behaviour when product is part of a choice'
    TabOrder = 3
    object lblChoicePrintMode: TLabel
      Left = 49
      Top = 58
      Width = 60
      Height = 13
      Caption = 'Print Stream:'
    end
    object cbRollupPrice: TDBCheckBox
      Left = 48
      Top = 26
      Width = 85
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Rollup Price:'
      DataField = 'RollupPriceWhenChild'
      DataSource = ProductsDB.EntityDataSource
      TabOrder = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object cmbChoicePrintMode: TDBComboBox
      Left = 120
      Top = 55
      Width = 201
      Height = 21
      AutoDropDown = True
      DataField = 'PrintStreamWhenChild'
      DataSource = ProductsDB.EntityDataSource
      DropDownCount = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
    object cbFollowCourse: TDBCheckBox
      Left = 8
      Top = 87
      Width = 125
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Follow Parent Course:'
      DataField = 'FollowCourseWhenChild'
      DataSource = ProductsDB.EntityDataSource
      TabOrder = 2
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object PricingRadioGroup: TDBRadioGroup
    Left = 286
    Top = 102
    Width = 171
    Height = 65
    Caption = 'Pricing'
    DataField = 'Whether Open Priced'
    DataSource = ProductsDB.EntityDataSource
    Items.Strings = (
      'Open Pricing'
      'Fixed Pricing')
    TabOrder = 2
    TabStop = True
    Values.Strings = (
      'O'
      'F')
  end
  object gbCourse: TGroupBox
    Left = 286
    Top = 6
    Width = 171
    Height = 85
    Caption = 'Course'
    TabOrder = 1
    object cmbbxCourses: TAztecDBLookupBox
      Left = 16
      Top = 33
      Width = 145
      Height = 21
      DataField = 'CourseID'
      DataSource = ProductsDB.EntityDataSource
      ItemHeight = 13
      KeyField = 'Id'
      ListField = 'Name'
      ListSource = dsCourses
      TabOrder = 0
      OnCreateNew = cmbbxCoursesCreateNew
    end
  end
  object dbedAlcohol: TDBEdit
    Left = 63
    Top = 312
    Width = 65
    Height = 21
    DataField = '% Alcohol'
    DataSource = ProductsDB.EntityDataSource
    TabOrder = 4
    OnKeyPress = dbedAlcoholKeyPress
  end
  object dsCourses: TDataSource
    DataSet = tblCourses
    Left = 40
  end
  object tblCourses: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 'select * from ac_Course where Deleted = 0'
    Parameters = <>
    Left = 8
  end
end
