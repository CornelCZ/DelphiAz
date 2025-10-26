object FrmNewJob: TFrmNewJob
  Left = 205
  Top = 150
  BorderStyle = bsDialog
  Caption = 'Create a new job'
  ClientHeight = 328
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Command:'
  end
  object spbCommand: TSpeedButton
    Left = 369
    Top = 5
    Width = 23
    Height = 22
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
    Left = 8
    Top = 37
    Width = 47
    Height = 13
    Caption = 'Start time:'
  end
  object lblDaysOfWeek: TLabel
    Left = 8
    Top = 104
    Width = 68
    Height = 13
    Caption = 'Days of Week'
  end
  object lblDaysOfMonth: TLabel
    Left = 8
    Top = 184
    Width = 69
    Height = 13
    Caption = 'Days of Month'
  end
  object edtCommand: TEdit
    Left = 96
    Top = 5
    Width = 273
    Height = 21
    TabOrder = 0
    OnChange = edtCommandChange
  end
  object dtpStartTime: TDateTimePicker
    Left = 96
    Top = 32
    Width = 162
    Height = 21
    CalAlignment = dtaLeft
    Date = 37962.0369294676
    Time = 37962.0369294676
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 1
  end
  object chbRunRepeatedly: TCheckBox
    Left = 7
    Top = 82
    Width = 130
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Run repeatedly'
    TabOrder = 2
  end
  object clbDaysOfWeek: TCheckListBox
    Left = 8
    Top = 120
    Width = 385
    Height = 49
    Columns = 3
    ItemHeight = 13
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
    Left = 7
    Top = 59
    Width = 130
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Interact with desktop'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object clbDaysOfMonth: TCheckListBox
    Left = 7
    Top = 200
    Width = 385
    Height = 89
    Columns = 6
    ItemHeight = 13
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
    Left = 232
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Create'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancel: TButton
    Left = 317
    Top = 296
    Width = 75
    Height = 25
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
