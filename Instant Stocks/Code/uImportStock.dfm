object ImportStockForm: TImportStockForm
  Left = 419
  Top = 226
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Import Audit Counts'
  ClientHeight = 199
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDescription: TLabel
    Left = 7
    Top = 7
    Width = 355
    Height = 52
    Caption = 
      'The system has detected several accepted Inventories for this di' +
      'vision that have the same End Date/Time.'#13#10#13#10'Select an Inventory ' +
      'to import into the Audit Counts.'
    Constraints.MinHeight = 15
    Constraints.MinWidth = 287
    WordWrap = True
  end
  object gridDlg: TwwDBGrid
    Left = 9
    Top = 67
    Width = 350
    Height = 97
    Selected.Strings = (
      'TName'#9'30'#9'Thread Name'#9'F'
      'sdate'#9'10'#9'Start Date'#9'F'
      'accdate'#9'10'#9'Accepted On'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsDlg
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object btnImport: TBitBtn
    Left = 169
    Top = 168
    Width = 93
    Height = 29
    Caption = 'Import'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnImportClick
  end
  object btnNoImport: TBitBtn
    Left = 267
    Top = 168
    Width = 93
    Height = 29
    Caption = 'Do Not Import'
    ModalResult = 2
    TabOrder = 2
  end
  object dsDlg: TwwDataSource
    DataSet = data1.adoqRun
    Left = 24
    Top = 88
  end
end
