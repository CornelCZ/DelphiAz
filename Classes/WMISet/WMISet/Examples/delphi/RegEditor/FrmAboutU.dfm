object FrmAbout: TFrmAbout
  Left = 384
  Top = 170
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 190
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object btnOk: TButton
    Left = 105
    Top = 153
    Width = 73
    Height = 24
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object memAbout: TMemo
    Left = 0
    Top = 0
    Width = 276
    Height = 137
    Align = alTop
    Ctl3D = False
    Lines.Strings = (
      'RegEditor is a demo program that shows how '
      'to use features of WmiSet component '
      'collection. Distributed by '
      'www.online-admin.com.  Redistribution is free.')
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 1
  end
end
