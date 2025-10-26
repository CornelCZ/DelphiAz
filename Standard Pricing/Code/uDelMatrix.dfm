object fDelMatrix: TfDelMatrix
  Left = 375
  Top = 346
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Delete Matrix'
  ClientHeight = 259
  ClientWidth = 177
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbMatrix: TListBox
    Left = 0
    Top = 0
    Width = 177
    Height = 225
    Align = alTop
    ItemHeight = 13
    TabOrder = 0
  end
  object btnDel: TBitBtn
    Left = 4
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Delete'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnDelClick
  end
  object btnCancel: TBitBtn
    Left = 99
    Top = 232
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
