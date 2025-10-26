object SettingsFrame: TSettingsFrame
  Left = 0
  Top = 0
  Width = 329
  Height = 242
  TabOrder = 0
  DesignSize = (
    329
    242)
  object Label1: TLabel
    Left = 16
    Top = 10
    Width = 280
    Height = 13
    Caption = 'Choose how Budgeted Cost Price is calculated for Choices.'
  end
  object bvlDivider1: TBevel
    Left = 16
    Top = 116
    Width = 299
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object bvlDivider2: TBevel
    Left = 16
    Top = 176
    Width = 299
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object lblNumberOfPortions1: TLabel
    Left = 16
    Top = 152
    Width = 49
    Height = 13
    Caption = 'Show first '
  end
  object lblNumberOfPortions2: TLabel
    Left = 105
    Top = 152
    Width = 37
    Height = 13
    Caption = 'portions'
  end
  object btnCancel: TButton
    Left = 244
    Top = 212
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 167
    Top = 212
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object chkbxShowPortionPrices: TCheckBox
    Left = 16
    Top = 125
    Width = 249
    Height = 17
    Caption = 'Allow setting of band A price on Portions tab'
    TabOrder = 2
  end
  object pnlBudgetedCostPriceMode: TPanel
    Left = 16
    Top = 34
    Width = 299
    Height = 72
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    TabOrder = 3
    object rbtnMin: TRadioButton
      Left = 11
      Top = 31
      Width = 113
      Height = 17
      Caption = 'Minimum item cost'
      TabOrder = 0
    end
    object rbtnMax: TRadioButton
      Left = 11
      Top = 51
      Width = 113
      Height = 17
      Caption = 'Maximum item cost'
      TabOrder = 1
    end
    object rbtnAvg: TRadioButton
      Left = 11
      Top = 11
      Width = 113
      Height = 17
      Caption = 'Average item cost'
      TabOrder = 2
    end
  end
  object chkbxUseGlobalDefault: TCheckBox
    Left = 28
    Top = 28
    Width = 112
    Height = 17
    Caption = 'Use system default'
    TabOrder = 4
    OnClick = chkbxUseGlobalDefaultClick
  end
  object chkbxShowB2BName: TCheckBox
    Left = 16
    Top = 185
    Width = 185
    Height = 17
    BiDiMode = bdRightToLeft
    Caption = 'Show B2B Name on Suppliers tab'
    ParentBiDiMode = False
    TabOrder = 5
  end
  object edtMaxNumberOfPortions: TEdit
    Left = 68
    Top = 149
    Width = 33
    Height = 21
    MaxLength = 2
    TabOrder = 6
    Text = '10'
    OnKeyPress = edtMaxNumberOfPortionsKeyPress
  end
end
