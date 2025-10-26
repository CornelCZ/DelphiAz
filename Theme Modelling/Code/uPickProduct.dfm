object PickProduct: TPickProduct
  Left = 926
  Top = 251
  Width = 428
  Height = 461
  HelpContext = 5041
  BorderIcons = [biSystemMenu]
  Caption = 'Pick product'
  Color = clBtnFace
  Constraints.MinHeight = 423
  Constraints.MinWidth = 412
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    412
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 88
    Height = 13
    Caption = 'Product(s) to add:'
  end
  object lblSubcat: TLabel
    Left = 8
    Top = 398
    Width = 67
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Sub-Category'
  end
  object btnCancel: TButton
    Left = 328
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 247
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object cmbbxSubcategory: TComboBox
    Left = 84
    Top = 394
    Width = 129
    Height = 21
    Anchors = [akLeft, akBottom]
    ItemHeight = 13
    TabOrder = 1
    Text = 'cmbbxSubcategory'
    OnChange = cmbbxSubcategoryChange
  end
  object wwdbgProducts: TwwDBGrid
    Left = 8
    Top = 27
    Width = 396
    Height = 352
    Selected.Strings = (
      'Subcategory'#9'15'#9'Sub-Category'
      'Name'#9'44'#9'Product  (Description)')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowLinesDisableFixed]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    OnTitleButtonClick = wwdbgProductsTitleButtonClick
  end
  object DataSource1: TDataSource
    DataSet = dProducts
    Left = 352
    Top = 56
  end
  object dProducts: TADODataSet
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 360
    Top = 96
    object dProductsSubCategory: TStringField
      DisplayLabel = 'Sub-Category'
      DisplayWidth = 15
      FieldName = 'Subcategory'
      ReadOnly = True
      Size = 15
    end
    object dProductsName: TStringField
      DisplayLabel = 'Product  (Description)'
      DisplayWidth = 44
      FieldName = 'Name'
      ReadOnly = True
      Size = 50
    end
    object dProductsProductId: TLargeintField
      FieldName = 'ProductId'
      ReadOnly = True
      Visible = False
    end
  end
end
