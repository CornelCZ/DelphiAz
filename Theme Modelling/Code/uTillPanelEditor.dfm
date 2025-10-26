object TillPanelEditor: TTillPanelEditor
  Left = 600
  Top = 139
  HelpContext = 5007
  BorderStyle = bsSingle
  Caption = 'Edit Panel'
  ClientHeight = 305
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Panel Name'
  end
  object lbDescription: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label1: TLabel
    Left = 8
    Top = 128
    Width = 88
    Height = 13
    Caption = 'Panel button text:'
  end
  object Label2: TLabel
    Left = 170
    Top = 200
    Width = 28
    Height = 13
    AutoSize = False
    Caption = 'Width'
  end
  object Label3: TLabel
    Left = 250
    Top = 200
    Width = 31
    Height = 13
    AutoSize = False
    Caption = 'Height'
  end
  object Label6: TLabel
    Left = 10
    Top = 200
    Width = 19
    Height = 13
    AutoSize = False
    Caption = 'Top'
  end
  object Label5: TLabel
    Left = 90
    Top = 200
    Width = 18
    Height = 13
    AutoSize = False
    Caption = 'Left'
  end
  object btOk: TButton
    Left = 255
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 9
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 335
    Top = 272
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 10
    OnClick = btCancelClick
  end
  object cbHideOrderDisplay: TCheckBox
    Left = 9
    Top = 248
    Width = 145
    Height = 17
    Caption = 'Panel hides order display'
    TabOrder = 7
    OnClick = cbHideOrderDisplayClick
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    TabOrder = 0
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 49
    TabOrder = 1
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
  object seWidth: TSpinEdit
    Left = 170
    Top = 216
    Width = 72
    Height = 22
    MaxValue = 14
    MinValue = 1
    TabOrder = 5
    Value = 1
  end
  object seHeight: TSpinEdit
    Left = 250
    Top = 216
    Width = 72
    Height = 22
    MaxValue = 14
    MinValue = 1
    TabOrder = 6
    Value = 1
  end
  object seTop: TSpinEdit
    Left = 10
    Top = 216
    Width = 72
    Height = 22
    MaxValue = 13
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object seLeft: TSpinEdit
    Left = 90
    Top = 216
    Width = 72
    Height = 22
    MaxValue = 13
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object cbModPanel: TCheckBox
    Left = 169
    Top = 248
    Width = 152
    Height = 17
    Caption = 'Auto "And" panel'
    TabOrder = 8
    OnClick = cbModPanelClick
  end
end
