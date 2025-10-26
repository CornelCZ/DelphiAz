object MatchOutletTablePlans: TMatchOutletTablePlans
  Left = 754
  Top = 157
  HelpContext = 5012
  BorderStyle = bsSingle
  Caption = 'Match Table Plans'
  ClientHeight = 264
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    386
    264)
  PixelsPerInch = 96
  TextHeight = 13
  object lbMatchTablePlansAdvice: TLabel
    Left = 8
    Top = 8
    Width = 361
    Height = 26
    AutoSize = False
    Caption = 
      'Please match the Theme table plans (defined at head office) with' +
      ' the table plans set up on site.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 10
    Top = 40
    Width = 92
    Height = 13
    Caption = 'Site Table Plans:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 225
    Top = 40
    Width = 109
    Height = 13
    Caption = 'Theme Table Plans:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btOk: TButton
    Left = 224
    Top = 232
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 304
    Top = 232
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = btCancelClick
  end
  object lbxOTP: TListBox
    Left = 8
    Top = 56
    Width = 153
    Height = 137
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Items.Strings = (
      'Site/Site PC 1 Bar'
      'Site/Site PC 1 Restaurant')
    TabOrder = 0
    OnDragDrop = lbxOTPDragDrop
    OnDragOver = lbxOTPDragOver
  end
  object lbxTTp: TListBox
    Left = 224
    Top = 56
    Width = 153
    Height = 137
    Anchors = [akTop, akRight, akBottom]
    DragMode = dmAutomatic
    ItemHeight = 13
    Items.Strings = (
      'Bar Tables'
      'Restaurant Tables 1'
      'Restaurant Tables 2')
    TabOrder = 1
  end
  object btAddMatch: TButton
    Left = 104
    Top = 200
    Width = 84
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add match'
    TabOrder = 2
    OnClick = btAddMatchClick
  end
  object btRemoveMatch: TButton
    Left = 200
    Top = 200
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Remove match'
    TabOrder = 5
    OnClick = btRemoveMatchClick
  end
  object Panel1: TPanel
    Left = 162
    Top = 58
    Width = 61
    Height = 136
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 6
    OnResize = Panel1Resize
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 61
      Height = 136
      Align = alClient
    end
  end
  object qApplyMappings: TADOQuery
    Connection = dmThemeData.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 64
    Top = 136
  end
end
