object TMultiPurchaseFrame: TTMultiPurchaseFrame
  Left = 0
  Top = 0
  Width = 523
  Height = 350
  TabOrder = 0
  OnExit = FrameExit
  object InvoiceNameLabel: TLabel
    Left = 17
    Top = 7
    Width = 73
    Height = 25
    AutoSize = False
    Caption = 'Invoice Name:'
    Layout = tlCenter
  end
  object DBGrid1: TFlexiDBGrid
    Left = 64
    Top = 61
    Width = 393
    Height = 177
    DataSource = ProductsDB.MultiPurchIngredDataSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    OnStepPastEnd = DBGrid1StepPastEnd
    OnToggleBooleanField = DBGrid1ToggleBooleanField
    FlexiOptions = [fdboCursorNaviagtionSkipsROColumn, fdboAutoCompleteCombos]
    SelectedField = ProductsDB.MultiPurchIngredientTableIngredientName
    Columns = <
      item
        Expanded = False
        FieldName = 'IngredientName'
        ReadOnly = True
        Title.Caption = 'Ingredient Name'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IngredientDescr'
        ReadOnly = True
        Title.Caption = 'Description'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UnitName'
        Title.Caption = 'Unit'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Returnable'
        Visible = True
      end>
  end
  object Button3: TButton
    Left = 67
    Top = 244
    Width = 97
    Height = 25
    Action = InsertIngredientAction
    TabOrder = 2
  end
  object Button5: TButton
    Left = 175
    Top = 244
    Width = 97
    Height = 25
    Action = AppendIngredientAction
    TabOrder = 3
  end
  object Button4: TButton
    Left = 283
    Top = 244
    Width = 97
    Height = 25
    Action = DeleteIngredientAction
    TabOrder = 4
  end
  object InvoiceNameEdit: TDBEdit
    Left = 102
    Top = 10
    Width = 367
    Height = 21
    DataField = 'Purchase Name'
    DataSource = ProductsDB.EntityDataSource
    TabOrder = 0
  end
  object ActionList1: TActionList
    Left = 352
    Top = 104
    object InsertIngredientAction: TAction
      Caption = 'Insert Ingredient'
      OnExecute = InsertIngredientActionExecute
      OnUpdate = InsertIngredientActionUpdate
    end
    object DeleteIngredientAction: TAction
      Caption = 'Delete Ingredient'
      OnExecute = DeleteIngredientActionExecute
      OnUpdate = DeleteIngredientActionUpdate
    end
    object AppendIngredientAction: TAction
      Caption = 'Append Ingredient'
      OnExecute = AppendIngredientActionExecute
      OnUpdate = InsertIngredientActionUpdate
    end
  end
end
