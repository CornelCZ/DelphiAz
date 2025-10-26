object ShowSitePriceReport: TShowSitePriceReport
  Left = 710
  Top = 149
  HelpContext = 5034
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Site price report'
  ClientHeight = 183
  ClientWidth = 170
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Select site:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 26
    Height = 13
    Caption = 'From:'
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 16
    Height = 13
    Caption = 'To:'
  end
  object cbSites: TComboBox
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    Text = 'cbSites'
    OnCloseUp = cbSitesCloseUp
  end
  object dtpFrom: TDateTimePicker
    Left = 8
    Top = 64
    Width = 153
    Height = 21
    CalAlignment = dtaLeft
    Date = 38176.6848867361
    Time = 38176.6848867361
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
    OnCloseUp = dtpFromCloseUp
  end
  object dtpTo: TDateTimePicker
    Left = 8
    Top = 104
    Width = 153
    Height = 21
    CalAlignment = dtaLeft
    Date = 38176.6848867361
    Time = 38176.6848867361
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
    OnCloseUp = dtpToCloseUp
  end
  object btPreview: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 3
    OnClick = btPreviewClick
  end
  object Button2: TButton
    Left = 88
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 4
    OnClick = Button2Click
  end
  object cbOrderByProduct: TCheckBox
    Left = 8
    Top = 128
    Width = 161
    Height = 17
    Caption = 'Order by product, then date'
    TabOrder = 5
    OnClick = cbOrderByProductClick
  end
end
