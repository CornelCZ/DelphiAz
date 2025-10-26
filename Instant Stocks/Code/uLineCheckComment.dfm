object GetLineCheckCommentForm: TGetLineCheckCommentForm
  Left = 460
  Top = 355
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Enter Comment (Max 255 Characters)'
  ClientHeight = 174
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mmUserComment: TMemo
    Left = 0
    Top = 0
    Width = 330
    Height = 145
    Align = alTop
    MaxLength = 255
    TabOrder = 0
  end
  object btnDone: TButton
    Left = 254
    Top = 147
    Width = 75
    Height = 25
    Caption = 'Done'
    ModalResult = 1
    TabOrder = 1
  end
end
