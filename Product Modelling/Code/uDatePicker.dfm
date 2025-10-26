object DatePickerForm: TDatePickerForm
  Left = 515
  Top = 338
  BorderStyle = bsDialog
  Caption = 'Product Modelling'
  ClientHeight = 119
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object QueryLabel: TLabel
    Left = 5
    Top = 5
    Width = 204
    Height = 41
    AutoSize = False
    Caption = 
      'What date would you like any changes made to become effective on' +
      ' site(s)?'
    WordWrap = True
  end
  object DatePicker: TDateTimePicker
    Left = 16
    Top = 48
    Width = 186
    Height = 21
    CalAlignment = dtaLeft
    Date = 37454.6766404398
    Time = 37454.6766404398
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 0
    OnDropDown = DatePickerDropDown
  end
  object Button1: TButton
    Left = 28
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 116
    Top = 80
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
