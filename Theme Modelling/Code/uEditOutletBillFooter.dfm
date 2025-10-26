object EditOutletBillFooter: TEditOutletBillFooter
  Left = 145
  Top = 468
  Width = 626
  Height = 460
  Caption = 'Edit Bill Footer'
  Color = clBtnFace
  Constraints.MinHeight = 428
  Constraints.MinWidth = 593
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDataGrid: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 381
    Align = alClient
    TabOrder = 0
    DesignSize = (
      610
      381)
    object dbgrdOutletBillFooter: TwwDBGrid
      Left = 9
      Top = 61
      Width = 592
      Height = 319
      ControlType.Strings = (
        'Alignment;CustomEdit;luAlignment;F'
        'AlignmentName;CustomEdit;luAlignment;F'
        'Bold;CheckBox;True;False'
        'DoubleSize;CheckBox;True;False'
        'DoubleWidth;CheckBox;True;False'
        'DoubleHeight;CheckBox;True;False')
      Selected.Strings = (
        'LineNumber'#9'3'#9'Line~No.'
        'Text'#9'59'#9'Text'
        'AlignmentName'#9'9'#9'Alignment'
        'Bold'#9'5'#9'Bold'
        'DoubleWidth'#9'7'#9'Double-~Width'
        'DoubleHeight'#9'7'#9'Double-~Height')
      MemoAttributes = [mSizeable]
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dmADO.dsOutletBillFooter
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = pmCopyPasteMenu
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 2
      TitleButtons = False
      OnKeyPress = dbgrdOutletBillFooterKeyPress
    end
    object luAlignment: TwwDBLookupCombo
      Left = 354
      Top = 104
      Width = 65
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Position'#9'6'#9'Position'#9#9)
      DataField = 'Alignment'
      DataSource = dmADO.dsOutletBillFooter
      LookupTable = dmADO.qBillFooterAlignmentLookup
      LookupField = 'Id'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
    end
    object pnlFooterTextTop: TPanel
      Left = 1
      Top = 1
      Width = 608
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      object lblFooterText: TLabel
        Left = 20
        Top = 6
        Width = 26
        Height = 13
        Caption = 'Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTextDescription: TLabel
        Left = 45
        Top = 22
        Width = 492
        Height = 27
        AutoSize = False
        Caption = 'Enter the footer text.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 381
    Width = 610
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      610
      41)
    object btnCancel: TButton
      Left = 526
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOK: TButton
      Left = 444
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnPasteFooter: TButton
      Left = 200
      Top = 8
      Width = 106
      Height = 25
      Action = actPasteFooter
      Anchors = [akRight, akBottom]
      Caption = 'Paste from Clipboard'
      TabOrder = 3
    end
    object btnPreviewBill: TButton
      Left = 315
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Preview'
      TabOrder = 4
      OnClick = btnPreviewBillClick
    end
    object btnClearAll: TButton
      Left = 119
      Top = 8
      Width = 75
      Height = 25
      Action = actClearAll
      TabOrder = 2
    end
  end
  object ActionList1: TActionList
    Left = 472
    Top = 264
    object actPasteFooter: TAction
      Caption = 'Paste'
      OnExecute = actPasteFooterExecute
      OnUpdate = actPasteUpdate
    end
    object actPaste: TAction
      Caption = 'Paste'
      OnExecute = actPasteExecute
      OnUpdate = actPasteUpdate
    end
    object actCopy: TAction
      Caption = 'Copy'
      OnExecute = actCopyExecute
      OnUpdate = CutCopyActionUpdate
    end
    object actCut: TAction
      Caption = 'Cut'
      OnExecute = actCutExecute
      OnUpdate = CutCopyActionUpdate
    end
    object actClearAll: TAction
      Caption = 'Clear All'
      OnExecute = actClearAllExecute
    end
  end
  object pmCopyPasteMenu: TPopupMenu
    Left = 472
    Top = 192
    object miCut: TMenuItem
      Action = actCut
    end
    object miCopy: TMenuItem
      Action = actCopy
    end
    object miPaste: TMenuItem
      Action = actPaste
    end
  end
end
