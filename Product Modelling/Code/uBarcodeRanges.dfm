object frmBarcodeRanges: TfrmBarcodeRanges
  Left = 517
  Top = 254
  HelpContext = 5048
  BorderStyle = bsSingle
  Caption = 'Barcode Ranges'
  ClientHeight = 396
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 359
    Width = 727
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 646
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 727
    Height = 359
    Align = alClient
    TabOrder = 1
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 479
      Height = 357
      Align = alClient
      TabOrder = 0
      object lblBarcodeRanges: TLabel
        Left = 11
        Top = 11
        Width = 78
        Height = 13
        Caption = 'Barcode Ranges'
      end
      object gridBarcodes: TwwDBGrid
        Left = 9
        Top = 28
        Width = 459
        Height = 281
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9'F'
          'StartValue'#9'25'#9'Range start'#9'F'
          'EndValue'#9'25'#9'Range end'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnRowChanged = gridBarcodesRowChanged
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        DataSource = dmBarcodeRanges.dsBarcodeRanges
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnDblClick = gridBarcodesDblClick
      end
      object btnAdd: TButton
        Left = 8
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddClick
      end
      object btnEdit: TButton
        Left = 88
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Edit'
        TabOrder = 2
        OnClick = btnEditClick
      end
      object btnDelete: TButton
        Left = 168
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 3
        OnClick = btnDeleteClick
      end
    end
    object Panel3: TPanel
      Left = 480
      Top = 1
      Width = 246
      Height = 357
      Align = alRight
      TabOrder = 1
      object lblRangeExceptions: TLabel
        Left = 9
        Top = 48
        Width = 52
        Height = 13
        Caption = 'Exceptions'
      end
      object gridBarcodeExceptions: TwwDBGrid
        Left = 9
        Top = 65
        Width = 217
        Height = 245
        Selected.Strings = (
          'Value'#9'32'#9'Value'#9'T')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        DataSource = dmBarcodeRanges.dsBarcodeExceptions
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
      end
      object btnAddException: TButton
        Left = 10
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddExceptionClick
      end
      object btnDeleteException: TButton
        Left = 92
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = btnDeleteExceptionClick
      end
    end
  end
end
