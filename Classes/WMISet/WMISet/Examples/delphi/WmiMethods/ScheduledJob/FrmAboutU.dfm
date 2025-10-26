object FrmAbout: TFrmAbout
  Left = 384
  Top = 170
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 154
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 85
    Top = 124
    Width = 60
    Height = 20
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object memAbout: TMemo
    Left = 0
    Top = 0
    Width = 224
    Height = 111
    Align = alTop
    Ctl3D = False
    Lines.Strings = (
      'ScheduledJobs is a demo program that '
      'shows how to use features of WmiSet '
      'component collection. Distributed by '
      'www.online-admin.com.  Redistribution is free.')
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 1
  end
end
