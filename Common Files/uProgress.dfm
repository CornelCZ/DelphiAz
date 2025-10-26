object ProgressForm: TProgressForm
  Left = 563
  Top = 118
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'ProgressForm'
  ClientHeight = 253
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    419
    253)
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressLabel: TLabel
    Left = 16
    Top = 8
    Width = 265
    Height = 13
    AutoSize = False
    Caption = 'ProgressLabel'
    Layout = tlCenter
  end
  object ProgressRatio: TLabel
    Left = 335
    Top = 8
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'ProgressRatio'
  end
  object ProgressBar: TProgressBar
    Left = 16
    Top = 32
    Width = 385
    Height = 17
    Min = 0
    Max = 100
    Step = 1
    TabOrder = 1
  end
  object ProgressMemo: TMemo
    Left = 16
    Top = 64
    Width = 385
    Height = 153
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    Lines.Strings = (
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----'
      '---- 01234567890123456789012345678912 [ 00/00]  ----')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object ProgressButton: TButton
    Left = 160
    Top = 225
    Width = 97
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&OK'
    Default = True
    Enabled = False
    TabOrder = 0
    OnClick = ProgressButtonClick
  end
  object ProgressTimer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = ProgressTimerTimer
    Left = 192
    Top = 176
  end
end
