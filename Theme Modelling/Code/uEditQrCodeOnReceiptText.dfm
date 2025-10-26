object EditQrCodeOnReceiptText: TEditQrCodeOnReceiptText
  Left = 429
  Top = 149
  BorderStyle = bsDialog
  Caption = 'Edit QR Code Text'
  ClientHeight = 389
  ClientWidth = 583
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
  ShowHint = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDataGrid: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 348
    Align = alClient
    TabOrder = 0
    object pnlFooterTextTop: TPanel
      Left = 1
      Top = 1
      Width = 581
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object lblFooterText: TLabel
        Left = 20
        Top = 6
        Width = 76
        Height = 13
        Caption = 'QR Code Text'
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
        Caption = 'Enter the text that will be printed below the QR Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
    end
    object QrCodeFooterTextPanel: TPanel
      Left = 1
      Top = 49
      Width = 581
      Height = 298
      Align = alClient
      Caption = 'QrCodeFooterTextPanel'
      TabOrder = 1
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 579
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object QrCodeFooterTextDbGrid: TwwDBGrid
        Left = 1
        Top = 14
        Width = 579
        Height = 242
        ControlType.Strings = (
          'Alignment;CustomEdit;FooterAlignmentLookUp;F'
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False'
          'DoubleWidth;CheckBox;True;False'
          'DoubleHeight;CheckBox;True;False'
          'AlignmentName;CustomEdit;FooterAlignmentLookUp;F')
        Selected.Strings = (
          'LineNumber'#9'3'#9'Line~No.'#9#9
          'Text'#9'59'#9'Text'#9#9
          'AlignmentName'#9'7'#9'Alignment'#9#9
          'Bold'#9'5'#9'Bold'#9#9
          'DoubleWidth'#9'7'#9'Double-~Width'#9#9
          'DoubleHeight'#9'7'#9'Double-~Height'#9#9)
        MemoAttributes = [mSizeable]
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = False
        ShowVertScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dmADO.dsQrCodeOnReceiptFooterText
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 2
        TitleButtons = False
        OnKeyPress = QrCodeHeaderTextDbGridKeyPress
      end
      object FooterAlignmentLookUp: TwwDBLookupCombo
        Left = 490
        Top = 60
        Width = 65
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Position'#9'6'#9'Position'#9#9)
        DataField = 'AlignmentName'
        DataSource = dmADO.dsQrCodeOnReceiptFooterText
        LookupTable = dmADO.qBillFooterAlignmentLookup
        LookupField = 'Id'
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        ShowMatchText = True
      end
      object QrCodeFooterButtonPanel: TPanel
        Left = 1
        Top = 256
        Width = 579
        Height = 41
        Align = alBottom
        TabOrder = 2
        object QrCodeClearFooterTextBtn: TButton
          Left = 7
          Top = 8
          Width = 75
          Height = 25
          Action = actResetQrCodeFooter
          Caption = 'Clear Footer'
          TabOrder = 0
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 348
    Width = 583
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      583
      41)
    object btnCancel: TButton
      Left = 499
      Top = 8
      Width = 75
      Height = 25
      Hint = 'Discard changes and close'
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOK: TButton
      Left = 417
      Top = 8
      Width = 75
      Height = 25
      Hint = 'Save changes and close'
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
    end
    object PreviewQrCodeTextBtn: TButton
      Left = 254
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Preview'
      TabOrder = 2
      OnClick = PreviewQrCodeTextBtnClick
    end
  end
  object ActionList1: TActionList
    Left = 552
    Top = 24
    object actClearAll: TAction
      Caption = 'Clear All'
    end
    object actResetQrCodeHeader: TAction
      Caption = 'act'
    end
    object actResetQrCodeFooter: TAction
      Caption = 'actResetQrCodeFooter'
      OnExecute = actResetQrCodeFooterExecute
    end
  end
end
