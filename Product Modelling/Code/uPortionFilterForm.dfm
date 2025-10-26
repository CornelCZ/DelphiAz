object PortionFilterForm: TPortionFilterForm
  Left = 597
  Top = 336
  Width = 190
  Height = 300
  BorderIcons = []
  Caption = 'Choose portion types to show'
  Color = clBtnFace
  Constraints.MaxWidth = 190
  Constraints.MinHeight = 160
  Constraints.MinWidth = 190
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    174
    262)
  PixelsPerInch = 96
  TextHeight = 13
  object clbPortionTypes: TExtendedCheckListBox
    Left = 6
    Top = 8
    Width = 166
    Height = 194
    OnClickCheck = clbPortionTypesClickCheck
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 6
    Top = 236
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 97
    Top = 236
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object cbAllNone: TCheckBox
    Left = 6
    Top = 208
    Width = 121
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Check / Uncheck all'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = cbAllNoneClick
  end
end
