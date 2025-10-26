object frmStockOrderMenu: TfrmStockOrderMenu
  Left = 498
  Top = 145
  Width = 302
  Height = 354
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Stock Ordering Menu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOrders: TButton
    Left = 40
    Top = 16
    Width = 217
    Height = 57
    Caption = 'Current Stock Orders'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnOrdersClick
  end
  object btnSchedule: TButton
    Left = 40
    Top = 93
    Width = 217
    Height = 57
    Caption = 'Scheduler'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnScheduleClick
  end
  object btnExit: TButton
    Left = 40
    Top = 248
    Width = 217
    Height = 57
    Caption = 'Return to Main Menu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
  end
  object btnSupSet: TButton
    Left = 40
    Top = 170
    Width = 217
    Height = 57
    Caption = 'Supplier Settings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnClick = btnSupSetClick
  end
end
