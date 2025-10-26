object PleaseWaitForm: TPleaseWaitForm
  Left = 347
  Top = 215
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 51
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    217
    51)
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessage: TLabel
    Left = 0
    Top = 29
    Width = 217
    Height = 19
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = 'lblMessage'
  end
  object Label1: TLabel
    Left = 0
    Top = 8
    Width = 217
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Please Wait'
  end
end
