object PreviewManager: TPreviewManager
  Left = 372
  Top = 198
  Width = 406
  Height = 314
  HelpContext = 5067
  Caption = 'Previews'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 406
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MSshelldlg32'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    394
    279)
  PixelsPerInch = 96
  TextHeight = 14
  object Bevel1: TBevel
    Left = 0
    Top = 254
    Width = 398
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object btClearList: TButton
    Left = 4
    Top = 258
    Width = 74
    Height = 25
    Action = ClearPreviewList
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object sbScrollContainer: TScrollBox
    Left = 0
    Top = 0
    Width = 396
    Height = 252
    VertScrollBar.Style = ssHotTrack
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    TabOrder = 0
    DesignSize = (
      379
      252)
    object lbNoItemsWarning: TLabel
      Left = 16
      Top = 16
      Width = 92
      Height = 14
      Caption = 'No items to display.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MSshelldlg32'
      Font.Style = []
      ParentFont = False
    end
    object lbPreviewRequests: TListBox
      Left = 0
      Top = 0
      Width = 379
      Height = 665
      Style = lbOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      ItemHeight = 50
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDblClick = lbPreviewRequestsDblClick
      OnDrawItem = lbPreviewRequestsDrawItem
      OnKeyDown = lbPreviewRequestsKeyDown
    end
  end
  object btRecordSaveMacro: TButton
    Left = 161
    Top = 258
    Width = 74
    Height = 25
    Action = StartStopMacro
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object btStartStopPreview: TButton
    Left = 83
    Top = 258
    Width = 74
    Height = 25
    Action = StartStopPreview
    Anchors = [akLeft, akBottom]
    Default = True
    TabOrder = 3
  end
  object btClose: TButton
    Left = 317
    Top = 258
    Width = 74
    Height = 25
    Action = CloseForm
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 4
  end
  object btCancelMacro: TButton
    Left = 239
    Top = 258
    Width = 74
    Height = 25
    Action = CancelMacro
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 368
    Top = 8
    object StartPreview1: TMenuItem
      Action = StartStopPreview
    end
    object RecordMacro1: TMenuItem
      Action = StartStopMacro
    end
    object CancelMacro1: TMenuItem
      Action = CancelMacro
    end
    object Bringtofront1: TMenuItem
      Action = BringPreviewToFront
    end
    object RemoveFromList1: TMenuItem
      Action = RemoveRequest
    end
  end
  object ActionList1: TActionList
    Left = 328
    Top = 8
    object ClearPreviewList: TAction
      Caption = 'Clear List'
      OnExecute = ClearPreviewListExecute
      OnUpdate = ClearPreviewListUpdate
    end
    object StartStopMacro: TAction
      Caption = 'Record Macro'
      Enabled = False
      OnExecute = StartStopMacroExecute
      OnUpdate = StartStopMacroUpdate
    end
    object StartStopPreview: TAction
      Caption = 'Start Preview'
      OnExecute = StartStopPreviewExecute
      OnUpdate = StartStopPreviewUpdate
    end
    object RemoveRequest: TAction
      Caption = 'Remove From List'
      OnExecute = RemoveRequestExecute
      OnUpdate = RemoveRequestUpdate
    end
    object CloseForm: TAction
      Caption = 'Close'
      OnExecute = CloseFormExecute
    end
    object CancelMacro: TAction
      Caption = 'Cancel Macro'
      Enabled = False
      OnExecute = CancelMacroExecute
      OnUpdate = CancelMacroUpdate
    end
    object BringPreviewToFront: TAction
      Caption = 'Bring to front'
      OnExecute = BringPreviewToFrontExecute
      OnUpdate = BringPreviewToFrontUpdate
    end
  end
  object AnimRedrawTimer: TTimer
    Interval = 80
    OnTimer = AnimRedrawTimerTimer
    Left = 232
    Top = 72
  end
  object PollPreviewProcess: TTimer
    OnTimer = PollPreviewProcessTimer
    Left = 296
    Top = 64
  end
end
