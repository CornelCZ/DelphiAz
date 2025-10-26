object AztecPreparedItemFrame: TAztecPreparedItemFrame
  Left = 0
  Top = 0
  Width = 523
  Height = 350
  TabOrder = 0
  DesignSize = (
    523
    350)
  object lblPreparationBatch: TLabel
    Left = 3
    Top = 17
    Width = 88
    Height = 13
    Caption = 'Preparation Batch:'
  end
  object lblStorageCountUnit: TLabel
    Left = 3
    Top = 45
    Width = 93
    Height = 13
    Caption = 'Storage Count Unit:'
  end
  object lblNotes: TLabel
    Left = 0
    Top = 265
    Width = 31
    Height = 13
    Caption = 'Notes:'
  end
  object Label1: TLabel
    Left = 3
    Top = 70
    Width = 55
    Height = 13
    Caption = 'Ingredients:'
  end
  object cbBatchUnit: TAztecDBComboBox
    Left = 176
    Top = 13
    Width = 105
    Height = 21
    AutoDropDown = True
    DataField = 'BatchUnit'
    DataSource = ProductsDB.dsPreparedItemDetails
    ItemHeight = 13
    Items.Strings = (
      '<Create New...>')
    TabOrder = 1
    OnCreateNew = CreateNewUnit
  end
  object cbStorageUnit: TAztecDBComboBox
    Left = 113
    Top = 41
    Width = 103
    Height = 21
    AutoDropDown = True
    DataField = 'StorageUnit'
    DataSource = ProductsDB.dsPreparedItemDetails
    ItemHeight = 13
    Items.Strings = (
      '<Create New...>')
    TabOrder = 2
    OnCreateNew = CreateNewUnit
  end
  object dbEditBatchSize: TwwDBEdit
    Left = 113
    Top = 13
    Width = 57
    Height = 21
    DataField = 'BatchSize'
    DataSource = ProductsDB.dsPreparedItemDetails
    Picture.PictureMask = '[-]{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  inline PortionIngredientsFrame: TPortionIngredientsFrame
    Left = 3
    Top = 84
    Width = 514
    Height = 169
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    DesignSize = (
      514
      169)
    inherited IngredientsGrid: TwwDBGrid
      Width = 510
      Height = 164
      DataSource = ProductsDB.IngredDataSource1
    end
  end
  object dbMemoNotes: TDBMemo
    Left = 32
    Top = 261
    Width = 253
    Height = 88
    Anchors = [akLeft, akRight, akBottom]
    DataField = 'Notes'
    DataSource = ProductsDB.dsPreparedItemDetails
    MaxLength = 10000
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object btnInsertIngredient: TButton
    Left = 298
    Top = 262
    Width = 105
    Height = 25
    Action = PortionIngredientsFrame.InsertPortionIngredientAction
    Anchors = [akRight, akBottom]
    TabOrder = 5
  end
  object btnDeleteIngredient: TButton
    Left = 410
    Top = 262
    Width = 105
    Height = 25
    Action = PortionIngredientsFrame.DeletePortionIngredientAction
    Anchors = [akRight, akBottom]
    TabOrder = 6
  end
  object btnEditIngredient: TButton
    Left = 410
    Top = 295
    Width = 105
    Height = 25
    Action = PortionIngredientsFrame.EditPortionIngredientAction
    Anchors = [akRight, akBottom]
    TabOrder = 8
  end
  object btnAppendIngredient: TButton
    Left = 298
    Top = 294
    Width = 105
    Height = 25
    Action = PortionIngredientsFrame.AppendPortionIngredientAction
    Anchors = [akRight, akBottom]
    TabOrder = 7
  end
end
