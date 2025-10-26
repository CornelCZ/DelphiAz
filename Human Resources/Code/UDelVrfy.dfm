object FDelVrfy: TFDelVrfy
  Left = 424
  Top = 192
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Delete Record'
  ClientHeight = 195
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 377
    Height = 155
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 59
    Top = 20
    Width = 131
    Height = 13
    Caption = 'DELETE THIS RECORD  ?'
  end
  object Name: TLabel
    Left = 38
    Top = 52
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 20
    Top = 78
    Width = 64
    Height = 13
    Caption = 'Accepted In: '
  end
  object Label3: TLabel
    Left = 14
    Top = 104
    Width = 69
    Height = 13
    Caption = 'Accepted Out:'
  end
  object Label4: TLabel
    Left = 98
    Top = 52
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 98
    Top = 78
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 98
    Top = 104
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 13
    Top = 138
    Width = 322
    Height = 13
    Caption = 'WARNING - THIS RECORDS DETAILS HAVE BEEN CONFIRMED'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object OKBtn: TButton
    Left = 118
    Top = 167
    Width = 76
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 205
    Top = 167
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
  end
end
