object SelectServers: TSelectServers
  Left = 494
  Top = 257
  Width = 313
  Height = 428
  HelpContext = 5045
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Select Servers to send Theme Model to'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    305
    401)
  PixelsPerInch = 96
  TextHeight = 13
  object lvServers: TListView
    Left = 8
    Top = 8
    Width = 289
    Height = 353
    Anchors = [akLeft, akTop, akRight, akBottom]
    Checkboxes = True
    Columns = <
      item
        AutoSize = True
      end>
    ShowColumnHeaders = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnContinue: TButton
    Left = 136
    Top = 368
    Width = 75
    Height = 25
    Action = actContinue
    Anchors = [akRight, akBottom]
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 224
    Top = 368
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object alButtons: TActionList
    Left = 80
    Top = 400
    object actContinue: TAction
      Caption = 'Continue'
      OnUpdate = actContinueUpdate
    end
  end
end
