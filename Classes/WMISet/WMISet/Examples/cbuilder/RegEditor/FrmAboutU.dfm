object FrmAbout: TFrmAbout
  Left = 407
  Top = 298
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 189
  ClientWidth = 286
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
    Left = 104
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object memAbout: TMemo
    Left = 0
    Top = 0
    Width = 286
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
