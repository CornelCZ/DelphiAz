object CopyOptDlg: TCopyOptDlg
  Left = 494
  Top = 407
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Copy Options'
  ClientHeight = 184
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 257
    Height = 129
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 177
    Height = 13
    Caption = 'SELECT REQUIRED COPY OPTION'
  end
  object OKBtn: TButton
    Left = 63
    Top = 148
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 143
    Top = 148
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object RadioButton1: TRadioButton
    Left = 64
    Top = 48
    Width = 129
    Height = 17
    Caption = 'Current Day Only'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 64
    Top = 88
    Width = 113
    Height = 17
    Caption = 'Whole Week'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
