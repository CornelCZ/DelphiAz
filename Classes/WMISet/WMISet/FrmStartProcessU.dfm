object FrmStartProcess: TFrmStartProcess
  Left = 313
  Top = 195
  BorderStyle = bsDialog
  Caption = 'Start new process'
  ClientHeight = 130
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblCommandLine: TLabel
    Left = 8
    Top = 13
    Width = 90
    Height = 16
    Caption = 'Command Line'
  end
  object lblDirectory: TLabel
    Left = 8
    Top = 52
    Width = 82
    Height = 16
    Caption = 'Start directory'
  end
  object SpeedButton1: TSpeedButton
    Left = 321
    Top = 11
    Width = 21
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object edtCommandLine: TEdit
    Left = 108
    Top = 10
    Width = 213
    Height = 24
    TabOrder = 0
    OnChange = edtCommandLineChange
  end
  object edtStartDirectory: TEdit
    Left = 108
    Top = 44
    Width = 232
    Height = 24
    TabOrder = 1
    OnChange = edtCommandLineChange
  end
  object btnOk: TButton
    Left = 200
    Top = 92
    Width = 67
    Height = 25
    Caption = 'Ok'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 276
    Top = 92
    Width = 67
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object CommandLineDialog: TOpenDialog
    Filter = 'Executable (*.exe)|*.exe|Any file (*.*)|*.*'
    FilterIndex = 0
    Left = 20
    Top = 80
  end
end
