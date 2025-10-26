object FTotals: TFTotals
  Left = 477
  Top = 169
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Schedule Totals On/Off'
  ClientHeight = 389
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 71
    Top = 355
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 175
    Top = 355
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Emptotal: TCheckBox
    Tag = 1
    Left = 65
    Top = 32
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Employee Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Empcost: TCheckBox
    Tag = 2
    Left = 65
    Top = 64
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Employee Cost'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object Jobtotal: TCheckBox
    Tag = 3
    Left = 65
    Top = 159
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Job Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object Jobcost: TCheckBox
    Tag = 4
    Left = 65
    Top = 191
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Job Cost'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object Daytotal: TCheckBox
    Tag = 5
    Left = 65
    Top = 223
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Day Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object Daycost: TCheckBox
    Tag = 6
    Left = 65
    Top = 255
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Day Cost'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object Weektotal: TCheckBox
    Tag = 7
    Left = 65
    Top = 287
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Week Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object Weekcost: TCheckBox
    Tag = 8
    Left = 65
    Top = 319
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Week Cost'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object ExpTake: TCheckBox
    Tag = 9
    Left = 65
    Top = 95
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Expected Takings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object ExpTakePc: TCheckBox
    Tag = 10
    Left = 65
    Top = 127
    Width = 191
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Expected Wage %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
end
