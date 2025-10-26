object TicketingSendToEPOS: TTicketingSendToEPOS
  Left = 993
  Top = 210
  Width = 369
  Height = 308
  HelpContext = 5076
  Caption = 'Send Ticket Images'
  Color = clBtnFace
  Constraints.MinHeight = 308
  Constraints.MinWidth = 369
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    361
    281)
  PixelsPerInch = 96
  TextHeight = 13
  object lbAvailablePrinters: TLabel
    Left = 8
    Top = 8
    Width = 83
    Height = 13
    Caption = 'Available printers:'
  end
  object btSend: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Send images'
    Default = True
    TabOrder = 0
    OnClick = btSendClick
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 224
    Width = 345
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Min = 0
    Max = 100
    TabOrder = 1
  end
  object btClose: TButton
    Left = 280
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 2
    OnClick = btCloseClick
  end
  object clbPrinterList: TCheckListBox
    Left = 8
    Top = 24
    Width = 345
    Height = 193
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    PopupMenu = ContextMenu
    TabOrder = 3
  end
  object ProgressTimer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = ProgressTimerTimer
    Left = 312
    Top = 32
  end
  object ContextMenu: TPopupMenu
    Left = 272
    Top = 32
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object SelectNone1: TMenuItem
      Caption = 'Select None'
      OnClick = SelectNone1Click
    end
  end
end
