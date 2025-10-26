object frmPriceIncDec: TfrmPriceIncDec
  Left = 899
  Top = 334
  BorderStyle = bsToolWindow
  BorderWidth = 2
  Caption = 'Price Adjustment'
  ClientHeight = 91
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    277
    91)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 1
    Top = 51
    Width = 274
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object lblCalculationType: TLabel
    Left = 8
    Top = 8
    Width = 79
    Height = 13
    Caption = 'Calculation Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
  end
  object lblValue: TLabel
    Left = 160
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Value'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
  end
  object lblPercent: TLabel
    Left = 264
    Top = 28
    Width = 11
    Height = 13
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object btnOK: TButton
    Left = 117
    Top = 61
    Width = 75
    Height = 25
    Action = actOK
    Anchors = [akRight, akBottom]
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 197
    Top = 61
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
  object cbxCalculationType: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnChange = cbxCalculationTypeChange
    Items.Strings = (
      'Value Increase'
      'Value Decrease'
      'Percentage Increase'
      'Percentage Decrease')
  end
  object edtCalculationAmount: TEdit
    Left = 160
    Top = 24
    Width = 101
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnKeyPress = edtCalculationAmountKeyPress
  end
  object ActionList1: TActionList
    Left = 40
    Top = 56
    object actOK: TAction
      Caption = 'OK'
      OnExecute = actOKExecute
      OnUpdate = actOKUpdate
    end
  end
end
