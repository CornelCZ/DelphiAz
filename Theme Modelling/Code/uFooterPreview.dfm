object FooterPreview: TFooterPreview
  Left = 716
  Top = 243
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Footer Preview'
  ClientHeight = 626
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 472
    Height = 585
    VertScrollBar.Tracking = True
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 585
    Width = 472
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TButton
      Left = 391
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      Default = True
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
end
