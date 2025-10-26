object fAddMatrix: TfAddMatrix
  Left = 383
  Top = 307
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Price Matrix'
  ClientHeight = 169
  ClientWidth = 411
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
  object btnCancel: TBitBtn
    Left = 332
    Top = 141
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object btnFinish: TBitBtn
    Left = 252
    Top = 141
    Width = 75
    Height = 25
    Caption = 'Finish'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btnFinishClick
    NumGlyphs = 2
  end
  object lbMatrices: TListBox
    Left = 0
    Top = 0
    Width = 185
    Height = 169
    Align = alLeft
    ItemHeight = 13
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 189
    Top = 0
    Width = 222
    Height = 134
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 45
      Width = 59
      Height = 13
      Caption = 'Matrix Name'
    end
    object edtMatrixName: TEdit
      Left = 21
      Top = 64
      Width = 193
      Height = 21
      MaxLength = 20
      TabOrder = 0
    end
  end
end
