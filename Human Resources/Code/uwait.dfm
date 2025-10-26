object fwait: Tfwait
  Left = 448
  Top = 289
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Dialog'
  ClientHeight = 141
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 385
    Height = 141
    Brush.Style = bsClear
    Pen.Color = clRed
    Pen.Width = 5
  end
  object Label1: TLabel
    Left = 112
    Top = 12
    Width = 168
    Height = 35
    Caption = 'Please Wait'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 369
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bar: TProgressBar
    Left = 32
    Top = 88
    Width = 321
    Height = 25
    Min = 0
    Max = 100
    TabOrder = 0
  end
end
