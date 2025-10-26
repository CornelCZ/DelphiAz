object ThemeTablePlanGroups: TThemeTablePlanGroups
  Left = 503
  Top = 237
  HelpContext = 5029
  BorderStyle = bsSingle
  Caption = 'Edit table plan groups'
  ClientHeight = 399
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 200
    Top = 144
    Width = 38
    Height = 13
    Caption = 'Group 2'
  end
  object Label4: TLabel
    Left = 200
    Top = 256
    Width = 38
    Height = 13
    Caption = 'Group 3'
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 347
    Height = 26
    AutoSize = False
    Caption = 
      'Grouped table plans allow navigation to other table plans in the' +
      ' group'
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 108
    Height = 13
    Caption = 'Ungrouped table plans'
  end
  object Label2: TLabel
    Left = 200
    Top = 32
    Width = 38
    Height = 13
    Caption = 'Group 1'
  end
  object lbUngrouped: TListBox
    Left = 8
    Top = 48
    Width = 153
    Height = 313
    ItemHeight = 13
    TabOrder = 0
  end
  object lbGroup1: TListBox
    Left = 200
    Top = 48
    Width = 153
    Height = 89
    ItemHeight = 13
    TabOrder = 1
  end
  object lbGroup2: TListBox
    Left = 200
    Top = 160
    Width = 153
    Height = 89
    ItemHeight = 13
    TabOrder = 2
  end
  object lbGroup3: TListBox
    Left = 200
    Top = 272
    Width = 153
    Height = 89
    ItemHeight = 13
    TabOrder = 3
  end
  object Button1: TButton
    Left = 168
    Top = 56
    Width = 25
    Height = 25
    Caption = '>'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 104
    Width = 25
    Height = 25
    Caption = '<'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 168
    Top = 168
    Width = 25
    Height = 25
    Caption = '>'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 168
    Top = 216
    Width = 25
    Height = 25
    Caption = '<'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 168
    Top = 280
    Width = 25
    Height = 25
    Caption = '>'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 168
    Top = 328
    Width = 25
    Height = 25
    Caption = '<'
    TabOrder = 9
    OnClick = Button6Click
  end
  object btCancel: TButton
    Left = 280
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 11
    OnClick = btCancelClick
  end
  object btOk: TButton
    Left = 199
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 10
    OnClick = btOkClick
  end
end
