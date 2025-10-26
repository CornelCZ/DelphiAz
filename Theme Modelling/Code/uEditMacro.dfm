object EditMacro: TEditMacro
  Left = 843
  Top = 177
  HelpContext = 5066
  BorderStyle = bsSingle
  Caption = 'Add/Edit Macro'
  ClientHeight = 280
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Macro name:'
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
    Top = 176
    Width = 53
    Height = 13
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 97
    TabOrder = 1
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
  object btOk: TButton
    Left = 254
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DragCursor = crDefault
    TabOrder = 3
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 334
    Top = 248
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
