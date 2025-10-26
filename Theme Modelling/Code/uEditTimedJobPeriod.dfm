object EditJobPeriod: TEditJobPeriod
  Left = 806
  Top = 133
  HelpContext = 5036
  BorderStyle = bsDialog
  Caption = 'Add/edit time period'
  ClientHeight = 135
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Start time'
  end
  object Label2: TLabel
    Left = 88
    Top = 8
    Width = 41
    Height = 13
    Caption = 'End time'
  end
  object dtStart: TDateTimePicker
    Left = 8
    Top = 24
    Width = 65
    Height = 21
    Hint = 
      'If start time is between midnight and rollover time, period will' +
      #10#13'start on the calendar day AFTER the selected day(s) of week'
    CalAlignment = dtaLeft
    Date = 38168.375
    Time = 38168.375
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 0
  end
  object dtEnd: TDateTimePicker
    Left = 88
    Top = 24
    Width = 65
    Height = 21
    CalAlignment = dtaLeft
    Date = 38168.9166666667
    Time = 38168.9166666667
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 1
  end
  object cbMon: TCheckBox
    Left = 8
    Top = 56
    Width = 45
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Mon'
    TabOrder = 2
  end
  object cbTue: TCheckBox
    Left = 56
    Top = 56
    Width = 45
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Tue'
    TabOrder = 3
  end
  object cbWed: TCheckBox
    Left = 104
    Top = 56
    Width = 45
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Wed'
    TabOrder = 4
  end
  object cbThu: TCheckBox
    Left = 152
    Top = 56
    Width = 45
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Thu'
    TabOrder = 5
  end
  object cbFri: TCheckBox
    Left = 200
    Top = 56
    Width = 33
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Fri'
    TabOrder = 6
  end
  object cbSat: TCheckBox
    Left = 8
    Top = 80
    Width = 45
    Height = 17
    Hint = 'Defines the business days on which the period starts'
    Caption = 'Sat'
    TabOrder = 7
  end
  object cbSun: TCheckBox
    Left = 56
    Top = 80
    Width = 45
    Height = 17
    Hint = 'Define the business days on which the period starts'
    Caption = 'Sun'
    TabOrder = 8
  end
  object Button1: TButton
    Left = 80
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 10
    OnClick = Button2Click
  end
end
