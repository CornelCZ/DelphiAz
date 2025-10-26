object GroupPriceMethodFrame: TGroupPriceMethodFrame
  Left = 0
  Top = 0
  Width = 450
  Height = 43
  Anchors = [akLeft, akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 450
    Height = 43
    Align = alClient
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 86
    Top = 2
    Width = 70
    Height = 13
    Caption = 'Pricing method'
  end
  object lbParameterCaption: TLabel
    Left = 222
    Top = 2
    Width = 26
    Height = 13
    Caption = 'Value'
    Visible = False
  end
  object lbPercentage: TLabel
    Left = 281
    Top = 22
    Width = 11
    Height = 13
    Caption = '%'
    Visible = False
  end
  object lbGroupName: TLabel
    Left = 4
    Top = 2
    Width = 78
    Height = 38
    AutoSize = False
    Caption = 'Group 999'
    WordWrap = True
  end
  object cbBandList: TComboBox
    Left = 222
    Top = 18
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Visible = False
    OnChange = cbBandListChange
  end
  object cbCalculationMethod: TComboBox
    Left = 86
    Top = 18
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Price Entry'
    OnChange = cbCalculationMethodChange
    Items.Strings = (
      'Price Entry'
      'Value Increase'
      'Value Decrease'
      'Percentage Increase'
      'Percentage Decrease'
      'Banded Price')
  end
  object edValue: TEdit
    Left = 222
    Top = 18
    Width = 57
    Height = 21
    TabOrder = 1
    Visible = False
    OnChange = edValueChange
    OnKeyPress = edValueKeyPress
  end
  object ckRememberCalculation: TCheckBox
    Left = 299
    Top = 20
    Width = 130
    Height = 17
    Action = RememberCalculationChange
    TabOrder = 3
  end
  object ActionList1: TActionList
    Left = 368
    Top = 8
    object RememberCalculationChange: TAction
      Caption = 'Remember Calculation'
      OnExecute = RememberCalculationChangeExecute
    end
  end
end
