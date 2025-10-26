object DesignSitePanel: TDesignSitePanel
  Left = 620
  Top = 229
  BorderStyle = bsSingle
  Caption = 'Design Site Panel'
  ClientHeight = 295
  ClientWidth = 382
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBottomBar: TPanel
    Left = 0
    Top = 263
    Width = 382
    Height = 32
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      382
      32)
    object Button1: TButton
      Left = 223
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 302
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
