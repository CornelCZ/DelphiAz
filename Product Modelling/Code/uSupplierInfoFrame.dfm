object SupplierInfoFrame: TSupplierInfoFrame
  Left = 0
  Top = 0
  Width = 551
  Height = 360
  TabOrder = 0
  object InvoiceNameLabel: TLabel
    Left = 3
    Top = 12
    Width = 73
    Height = 25
    AutoSize = False
    Caption = 'Invoice Name:'
    Layout = tlCenter
  end
  object StockUnitLabel: TLabel
    Left = 3
    Top = 65
    Width = 73
    Height = 25
    AutoSize = False
    Caption = 'Stock Unit:'
    Layout = tlCenter
  end
  object DefaultSupplierLabel: TLabel
    Left = 3
    Top = 95
    Width = 79
    Height = 25
    AutoSize = False
    Caption = 'Default Supplier:'
    Layout = tlCenter
  end
  object AlcoholLabel: TLabel
    Left = 3
    Top = 125
    Width = 73
    Height = 25
    AutoSize = False
    Caption = '% Alcohol:'
    Layout = tlCenter
  end
  object BudgetedCostPriceLabel: TLabel
    Left = 3
    Top = 157
    Width = 105
    Height = 25
    AutoSize = False
    Caption = 'Budgeted Cost Price:'
    Layout = tlCenter
  end
  object FutureCostlbl: TLabel
    Left = 246
    Top = 162
    Width = 58
    Height = 13
    Caption = 'Prices as of:'
  end
  object FutureCostPricesExistlbl: TLabel
    Left = 331
    Top = 144
    Width = 111
    Height = 13
    Caption = 'Future Cost Prices Exist'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object B2BNameLabel: TLabel
    Left = 3
    Top = 43
    Width = 54
    Height = 13
    Caption = 'B2B Name:'
  end
  object InvoiceNameEdit: TDBEdit
    Left = 106
    Top = 14
    Width = 177
    Height = 21
    DataField = 'Purchase Name'
    DataSource = ProductsDB.EntityDataSource
    TabOrder = 0
  end
  object PurchaseUnitComboBox: TAztecDBComboBox
    Left = 106
    Top = 67
    Width = 100
    Height = 21
    AutoDropDown = True
    DataField = 'Purchase Unit'
    DataSource = ProductsDB.EntityDataSource
    ItemHeight = 13
    TabOrder = 1
    OnCreateNew = PurchaseUnitComboBoxCreateNew
    OnExit = ComboBoxExit
  end
  object DefaultSupplierEdit: TDBEdit
    Left = 106
    Top = 97
    Width = 177
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'Default Supplier'
    DataSource = ProductsDB.EntityDataSource
    ReadOnly = True
    TabOrder = 2
  end
  object AlcoholEdit: TDBEdit
    Left = 106
    Top = 127
    Width = 65
    Height = 21
    DataField = '% Alcohol'
    DataSource = ProductsDB.EntityDataSource
    TabOrder = 3
  end
  inline UnitSupplierFrame: TUnitSupplierFrame
    Left = 0
    Top = 191
    Width = 529
    Height = 195
    TabOrder = 4
    inherited Button2: TButton
      TabOrder = 3
    end
    inherited SetDefaultSupplierButton: TButton
      TabOrder = 1
    end
    inherited FlexiDBGrid1: TFlexiDBGrid
      OnExit = UnitSupplierFrameFlexiDBGrid1Exit
    end
  end
  object CancelFutureCostBtn: TButton
    Left = 465
    Top = 156
    Width = 59
    Height = 25
    Caption = 'Cancel'
    Enabled = False
    TabOrder = 5
    OnClick = CancelFutureCostBtnClick
  end
  object FutureCostDateCbx: TComboBox
    Left = 313
    Top = 158
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
    OnChange = FutureCostDateCbxChange
    OnDropDown = FutureCostDateCbxDropDown
  end
  object BudgetedCostPriceMemo: TMemo
    Left = 106
    Top = 158
    Width = 97
    Height = 21
    Alignment = taRightJustify
    Color = clBtnFace
    Lines.Strings = (
      'BudgetedCostPrice'
      'Memo')
    ReadOnly = True
    TabOrder = 7
    WantReturns = False
    WordWrap = False
  end
  object B2BNameEdit: TDBEdit
    Left = 106
    Top = 40
    Width = 415
    Height = 21
    DataField = 'B2BName'
    DataSource = ProductsDB.EntityDataSource
    TabOrder = 8
  end
end
