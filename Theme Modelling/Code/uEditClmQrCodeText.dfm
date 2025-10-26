object EditClmQrCodeTextFrm: TEditClmQrCodeTextFrm
  Left = 494
  Top = 264
  BorderStyle = bsDialog
  Caption = 'Edit QR Code Text'
  ClientHeight = 427
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
    Height = 386
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
        Caption = 'Enter the text that will be printed above and below the QR Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
    end
    object QrCodeHeaderTextPanel: TPanel
      Left = 1
      Top = 49
      Width = 581
      Height = 177
      Align = alTop
      Caption = 'QrCodeHeaderTextPanel'
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 579
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object QrCodeHeaderTextDbGrid: TwwDBGrid
        Left = 1
        Top = 14
        Width = 579
        Height = 121
        ControlType.Strings = (
          'Alignment;CustomEdit;luAlignment;F'
          'AlignmentName;CustomEdit;HeaderAlignmentLookUp;F'
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False'
          'DoubleWidth;CheckBox;True;False'
          'DoubleHeight;CheckBox;True;False')
        Selected.Strings = (
          'LineNumber'#9'3'#9'Line~No.'
          'Text'#9'59'#9'Text'
          'AlignmentName'#9'7'#9'Alignment'
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
        Align = alClient
        DataSource = dmADO.dsQrCodeHeaderText
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
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
      object HeaderAlignmentLookUp: TwwDBLookupCombo
        Left = 490
        Top = 60
        Width = 65
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Position'#9'6'#9'Position'#9#9)
        DataField = 'Alignment'
        DataSource = dmADO.dsQrCodeHeaderText
        LookupTable = dmADO.qBillFooterAlignmentLookup
        LookupField = 'Id'
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        ShowMatchText = True
      end
      object QrCodeHeaderButtonPanel: TPanel
        Left = 1
        Top = 135
        Width = 579
        Height = 41
        Align = alBottom
        TabOrder = 2
        object QrCodeClearHeaderTextBtn: TButton
          Left = 7
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Clear Header'
          TabOrder = 0
          OnClick = QrCodeClearHeaderTextBtnClick
        end
        object eHeaderExpDate: TEdit
          Left = 105
          Top = 8
          Width = 55
          Height = 25
          Hint = 
            'Number of days to calculate Expiry Date. Should be positive numb' +
            'er between 1 and 999.'
          AutoSize = False
          MaxLength = 3
          TabOrder = 1
          Text = '1'
        end
        object bInsertHeaderExpDate: TButton
          Left = 164
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Insert Date'
          TabOrder = 2
          OnClick = bInsertHeaderExpDateClick
        end
      end
    end
    object QrCodeFooterTextPanel: TPanel
      Left = 1
      Top = 226
      Width = 581
      Height = 159
      Align = alClient
      Caption = 'QrCodeFooterTextPanel'
      TabOrder = 2
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
        Height = 103
        ControlType.Strings = (
          'Alignment;CustomEdit;luAlignment;F'
          'AlignmentName;CustomEdit;FooterAlignmentLookUp;F'
          'Bold;CheckBox;True;False'
          'DoubleSize;CheckBox;True;False'
          'DoubleWidth;CheckBox;True;False'
          'DoubleHeight;CheckBox;True;False')
        Selected.Strings = (
          'LineNumber'#9'3'#9'Line~No.'
          'Text'#9'59'#9'Text'
          'AlignmentName'#9'7'#9'Alignment'
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
        Align = alClient
        DataSource = dmADO.dsQrCodeFooterText
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
        DataField = 'Alignment'
        DataSource = dmADO.dsQrCodeFooterText
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
        Top = 117
        Width = 579
        Height = 41
        Align = alBottom
        TabOrder = 2
        object QrCodeClearFooterTextBtn: TButton
          Left = 7
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Clear Footer'
          TabOrder = 0
          OnClick = QrCodeClearFooterTextBtnClick
        end
        object bInsertFooterExpDate: TButton
          Left = 164
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Insert Date'
          TabOrder = 1
          OnClick = bInsertFooterExpDateClick
        end
        object eFooterExpDate: TEdit
          Left = 105
          Top = 8
          Width = 55
          Height = 25
          Hint = 
            'Number of days to calculate Expiry Date. Should be positive numb' +
            'er between 1 and 999.'
          AutoSize = False
          MaxLength = 3
          TabOrder = 2
          Text = '1'
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 386
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
      TabOrder = 3
      OnClick = PreviewQrCodeTextBtnClick
    end
    object btnClearAll: TButton
      Left = 7
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Clear All'
      TabOrder = 2
      OnClick = btnClearAllClick
    end
  end
  object ActionList1: TActionList
    Left = 552
    Top = 24
    object actClearBarcodeAll: TAction
      Caption = 'Clear All'
      OnExecute = actClearBarcodeAllExecute
    end
    object actResetBarcodeHeader: TAction
      Caption = 'act'
      OnExecute = actResetBarcodeHeaderExecute
    end
    object actResetBarcodeFooter: TAction
      Caption = 'actResetQrCodeFooter'
      OnExecute = actResetBarcodeFooterExecute
    end
    object actClearQrCodeAll: TAction
      Caption = 'Clear All'
      OnExecute = actClearQrCodeAllExecute
    end
    object actResetQrCodeHeader: TAction
      Caption = 'act'
      OnExecute = actResetQrCodeHeaderExecute
    end
    object actResetQrCodeFooter: TAction
      Caption = 'actResetQrCodeFooter'
      OnExecute = actResetQrCodeFooterExecute
    end
  end
end
