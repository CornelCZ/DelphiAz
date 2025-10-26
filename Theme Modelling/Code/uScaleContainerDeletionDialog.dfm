object ScaleContainerDeletionDialog: TScaleContainerDeletionDialog
  Left = 819
  Top = 306
  Width = 432
  Height = 300
  Caption = 'Scale Container Deletion'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    424
    273)
  PixelsPerInch = 96
  TextHeight = 13
  object lblContainer: TLabel
    Left = 8
    Top = 8
    Width = 410
    Height = 39
    Caption = 
      'The following products have portions which use the scale contain' +
      'er <blah>.  Scale container <blah> cannot be deleted until these' +
      ' products have been modified.  Copy the details to the clipboard' +
      '?'
    WordWrap = True
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 52
    Width = 408
    Height = 182
    Selected.Strings = (
      'Retail Name'#9'16'#9'Retail Name'
      'Description'#9'30'#9'Description'
      'Portion'#9'16'#9'Portion')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsProductsUsingContainer
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    PadColumnStyle = pcsPlain
  end
  object btnNo: TButton
    Left = 340
    Top = 241
    Width = 75
    Height = 25
    Anchors = [akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnCopy: TButton
    Left = 256
    Top = 241
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Copy'
    Default = True
    ModalResult = 6
    TabOrder = 2
    OnClick = btnCopyClick
  end
  object dsProductsUsingContainer: TDataSource
    DataSet = adoqProductsUsingContainer
    Left = 28
    Top = 108
  end
  object adoqProductsUsingContainer: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #ProductsUsingContainer')
    Left = 28
    Top = 76
  end
end
