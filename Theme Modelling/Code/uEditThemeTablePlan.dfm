inherited EditThemeTablePlan: TEditThemeTablePlan
  Left = 832
  Top = 119
  HelpContext = 5018
  Caption = 'EditThemeTablePlan'
  ClientHeight = 281
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    418
    281)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbName: TLabel
    Width = 117
    Caption = 'Theme Table Plan name:'
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 176
    Width = 53
    Height = 13
  end
  inherited edName: TEdit
    MaxLength = 50
  end
  inherited btOk: TButton
    Top = 248
    TabOrder = 3
  end
  inherited btCancel: TButton
    Top = 248
    TabOrder = 4
  end
  object mmEposName: TMemo
    Left = 8
    Top = 192
    Width = 145
    Height = 50
    Alignment = taCenter
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    WordWrap = False
  end
  object cbSplitTableMode: TCheckBox
    Left = 240
    Top = 224
    Width = 169
    Height = 17
    Caption = 'Allow "New split table" mode'
    TabOrder = 5
    OnClick = cbSplitTableModeClick
  end
end
