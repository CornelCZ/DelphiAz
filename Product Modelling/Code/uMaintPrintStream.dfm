object fMaintPrintStream: TfMaintPrintStream
  Left = 396
  Top = 315
  BorderStyle = bsDialog
  Caption = 'New Print Stream'
  ClientHeight = 218
  ClientWidth = 342
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
  object lblTitle: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Print Stream'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblName: TLabel
    Left = 21
    Top = 50
    Width = 38
    Height = 13
    Caption = '* Name:'
  end
  object DescriptionLabel: TLabel
    Left = 21
    Top = 76
    Width = 62
    Height = 13
    Caption = '  Description:'
  end
  object btnOK: TBitBtn
    Left = 180
    Top = 188
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = btnOKClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 260
    Top = 188
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object edtStreamName: TEdit
    Left = 85
    Top = 46
    Width = 250
    Height = 21
    MaxLength = 19
    TabOrder = 0
  end
  object PrintStreamDescMemo: TMemo
    Left = 85
    Top = 72
    Width = 250
    Height = 110
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
