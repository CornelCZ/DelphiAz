object EditGenericDetails: TEditGenericDetails
  Left = 686
  Top = 113
  BorderStyle = bsSingle
  Caption = '<insert keyword here> Details'
  ClientHeight = 205
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    418
    205)
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel
    Left = 8
    Top = 8
    Width = 133
    Height = 13
    Caption = '<insert keyword here> name'
  end
  object lbDescription: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    TabOrder = 0
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 97
    TabOrder = 1
    WantReturns = False
  end
  object btOk: TButton
    Left = 256
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 336
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = btCancelClick
  end
end
