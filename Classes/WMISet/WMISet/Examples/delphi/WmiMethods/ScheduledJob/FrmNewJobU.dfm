object FrmNewJob: TFrmNewJob
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Create a new job'
  ClientHeight = 399
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 65
    Height = 16
    Caption = 'Command:'
  end
  object spbCommand: TSpeedButton
    Left = 454
    Top = 6
    Width = 28
    Height = 27
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
      FFFFF00B7B7B7B7B0FFFF0F0B7B7B7B7B0FFF0BF0B7B7B7B7B0FF0FBF0000000
      000FF0BFBFBFBFB0FFFFF0FBFBFBFBF0FFFFF0BFBFBF000FFFFFFF0BFBF0FFFF
      FFFFFF800008FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = spbCommandClick
  end
  object lblStartTime: TLabel
    Left = 10
    Top = 46
    Width = 58
    Height = 16
    Caption = 'Start time:'
  end
  object lblDaysOfWeek: TLabel
    Left = 10
    Top = 128
    Width = 85
    Height = 16
    Caption = 'Days of Week'
  end
  object lblDaysOfMonth: TLabel
    Left = 10
    Top = 226
    Width = 85
    Height = 16
    Caption = 'Days of Month'
  end
  object edtCommand: TEdit
    Left = 118
    Top = 6
    Width = 336
    Height = 24
    TabOrder = 0
    OnChange = edtCommandChange
  end
  object dtpStartTime: TDateTimePicker
    Left = 118
    Top = 39
    Width = 200
    Height = 24
    CalAlignment = dtaLeft
    Date = 0.0369294675983838
    Time = 0.0369294675983838
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 1
  end
  object chbRunRepeatedly: TCheckBox
    Left = 9
    Top = 101
    Width = 160
    Height = 21
    Alignment = taLeftJustify
    Caption = 'Run repeatedly'
    TabOrder = 2
  end
  object clbDaysOfWeek: TCheckListBox
    Left = 10
    Top = 148
    Width = 474
    Height = 60
    Columns = 3
    ItemHeight = 16
    Items.Strings = (
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
      'Sunday')
    TabOrder = 3
  end
  object chbInteract: TCheckBox
    Left = 9
    Top = 73
    Width = 160
    Height = 21
    Alignment = taLeftJustify
    Caption = 'Interact with desktop'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object clbDaysOfMonth: TCheckListBox
    Left = 9
    Top = 246
    Width = 473
    Height = 110
    Columns = 6
    ItemHeight = 16
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '21'
      '22'
      '23'
      '24'
      '25'
      '26'
      '27'
      '28'
      '29'
      '30'
      '31')
    TabOrder = 5
  end
  object btnCreate: TButton
    Left = 286
    Top = 364
    Width = 92
    Height = 31
    Caption = 'Create'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancel: TButton
    Left = 390
    Top = 364
    Width = 92
    Height = 31
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object odCommand: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 'Executable files (*.exe)|*.exe|All files (*.*)|*.*'
    Left = 360
    Top = 32
  end
end
