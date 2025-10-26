object UnitSupplierFrame: TUnitSupplierFrame
  Left = 0
  Top = 0
  Width = 523
  Height = 195
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  object Button2: TButton
    Left = 8
    Top = 138
    Width = 75
    Height = 25
    Action = AddSupplierAction
    TabOrder = 1
  end
  object Button3: TButton
    Left = 88
    Top = 138
    Width = 89
    Height = 25
    Action = DeleteSupplierAction
    TabOrder = 2
  end
  object SetDefaultSupplierButton: TButton
    Left = 224
    Top = 138
    Width = 129
    Height = 25
    Action = SetDefaultSupplierAction
    TabOrder = 3
    TabStop = False
  end
  object SetDefaultPurchaseUnitButton: TButton
    Left = 360
    Top = 138
    Width = 153
    Height = 25
    Action = SetDefaultPurchaseUnitAction
    TabOrder = 4
    TabStop = False
  end
  object FlexiDBGrid1: TFlexiDBGrid
    Left = 0
    Top = 0
    Width = 527
    Height = 129
    DataSource = ProductsDB.UnitSupplierDataSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnStepPastEnd = FlexiDBGrid1StepPastEnd
    OnToggleBooleanField = FlexiDBGrid1ToggleBooleanField
    FlexiOptions = [fdboCursorNaviagtionSkipsROColumn, fdboAutoCompleteCombos]
    SelectedField = ProductsDB.UnitSupplierTableSupplierName
    Columns = <
      item
        DropDownRows = 15
        Expanded = False
        FieldName = 'Supplier Name'
        Title.Caption = 'Supplier'
        Width = 121
        Visible = True
      end
      item
        DropDownRows = 11
        Expanded = False
        FieldName = 'Unit Name'
        Title.Caption = 'Unit'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Flavour'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Import/Export Reference'
        Title.Caption = 'Supplier Ref'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Barcode'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Unit Cost'
        Title.Caption = 'Cost'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Default Flag'
        ReadOnly = True
        Title.Caption = 'D'
        Width = 13
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Left = 192
    Top = 136
    object SetDefaultSupplierAction: TAction
      Category = 'Dataset'
      Caption = 'Set Default Supplier (F4)'
      OnExecute = SetDefaultSupplierActionExecute
      OnUpdate = SetDefaultSupplierActionUpdate
    end
    object SetDefaultPurchaseUnitAction: TAction
      Category = 'Dataset'
      Caption = 'Set Default Purchase Unit (F5)'
      OnExecute = SetDefaultPurchaseUnitActionExecute
      OnUpdate = SetDefaultPurchaseUnitActionUpdate
    end
    object DeleteSupplierAction: TAction
      Category = 'Dataset'
      Caption = 'Delete Supplier'
      OnExecute = DeleteSupplierActionExecute
      OnUpdate = DeleteSupplierActionUpdate
    end
    object AddSupplierAction: TAction
      Category = 'Dataset'
      Caption = 'Add Supplier'
      Enabled = False
      OnExecute = AddSupplierActionExecute
      OnUpdate = AddSupplierActionUpdate
    end
  end
end
