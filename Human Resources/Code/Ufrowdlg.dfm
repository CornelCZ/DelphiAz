object Ffrowdlg: TFfrowdlg
  Left = 563
  Top = 168
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Fill Row'
  ClientHeight = 152
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 186
    Height = 16
    Caption = 'Enter values to fill current record'
  end
  object Label2: TLabel
    Left = 64
    Top = 32
    Width = 10
    Height = 16
    Caption = 'In'
  end
  object Label3: TLabel
    Left = 144
    Top = 32
    Width = 21
    Height = 16
    Caption = 'Out'
  end
  object OKBtn: TButton
    Left = 17
    Top = 110
    Width = 93
    Height = 30
    Caption = '&OK'
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 132
    Top = 110
    Width = 92
    Height = 30
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object MaskEdit1: TMaskEdit
    Left = 47
    Top = 56
    Width = 49
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
    OnExit = MaskEdit1Exit
    OnKeyDown = MaskEdit1KeyDown
  end
  object MaskEdit2: TMaskEdit
    Left = 131
    Top = 56
    Width = 49
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
    OnExit = MaskEdit2Exit
    OnKeyDown = MaskEdit2KeyDown
  end
end
