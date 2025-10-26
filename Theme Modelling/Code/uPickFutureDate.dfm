object PickFutureDate: TPickFutureDate
  Left = 763
  Top = 254
  BorderStyle = bsSingle
  Caption = 'Pick future date'
  ClientHeight = 105
  ClientWidth = 169
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Please select the date for the future change to take effect:'
    WordWrap = True
  end
  object dtpFutureDate: TDateTimePicker
    Left = 8
    Top = 40
    Width = 153
    Height = 21
    CalAlignment = dtaLeft
    Date = 39350
    Time = 39350
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 0
  end
  object btOk: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 88
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
