inherited EditSharedPanel: TEditSharedPanel
  Left = 833
  Top = 175
  HelpContext = 5019
  Caption = 'EditSharedPanel'
  ClientHeight = 231
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbName: TLabel
    Width = 96
    Caption = 'Shared Panel name:'
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 128
    Width = 88
    Height = 13
    Caption = 'Panel button text:'
  end
  inherited edName: TEdit
    MaxLength = 50
  end
  inherited mmDescription: TMemo
    Height = 49
  end
  inherited btOk: TButton
    Top = 200
    TabOrder = 3
  end
  inherited btCancel: TButton
    Top = 200
    TabOrder = 4
  end
  object mmEposName: TMemo
    Left = 8
    Top = 144
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
  object cbHideOrderDisplay: TCheckBox
    Left = 168
    Top = 144
    Width = 153
    Height = 17
    Caption = 'Panel hides order display'
    TabOrder = 5
    OnClick = cbHideOrderDisplayClick
  end
  object cbModPanel: TCheckBox
    Left = 168
    Top = 176
    Width = 153
    Height = 17
    Caption = 'Auto "And" panel'
    TabOrder = 6
    OnClick = cbModPanelClick
  end
end
