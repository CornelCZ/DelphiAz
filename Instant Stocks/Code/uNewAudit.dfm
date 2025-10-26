object fNewAudit: TfNewAudit
  Left = 357
  Top = 150
  HelpContext = 1019
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Add New Items...'
  ClientHeight = 523
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwGrid1: TwwDBGrid
    Left = 0
    Top = 0
    Width = 629
    Height = 523
    ControlType.Strings = (
      'Sel;CheckBox;Y;N')
    Selected.Strings = (
      'subcat'#9'20'#9'subcat'#9'F'
      'purchasename'#9'40'#9'Name'#9#9
      'entitytype'#9'15'#9'Entity Type'#9#9
      'purchaseunit'#9'15'#9'Purchase Unit'#9#9
      'Sel'#9'5'#9'Add'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 6
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Align = alClient
    DataSource = wwDataSource1
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgWordWrap]
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
    OnCalcTitleAttributes = wwGrid1CalcTitleAttributes
    OnTitleButtonClick = wwGrid1TitleButtonClick
    PaintOptions.ActiveRecordColor = clHighlight
  end
  object Panel1: TPanel
    Left = 629
    Top = 0
    Width = 194
    Height = 523
    Align = alRight
    TabOrder = 0
    object Label3: TLabel
      Left = 14
      Top = 67
      Width = 121
      Height = 13
      AutoSize = False
      Caption = 'Sub Category Filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 14
      Top = 114
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = 'Entity Type Filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 194
      Width = 169
      Height = 27
      AutoSize = False
      Caption = 'Incremental Search On Purchase Name (Next = F3): '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 13
      Top = 297
      Width = 134
      Height = 13
      Caption = 'Items available to add: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 11
      Top = 345
      Width = 163
      Height = 13
      Caption = 'Selected for addition so far: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAv: TLabel
      Left = 61
      Top = 314
      Width = 33
      Height = 16
      Caption = ' 245 '
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblSel: TLabel
      Left = 61
      Top = 363
      Width = 33
      Height = 16
      Caption = ' 233 '
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 3
      Top = 2
      Width = 186
      Height = 51
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Click on a Field Title of the grid to order the data by that Fie' +
        'ld (Title will turn Yellow).'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object findPur: TwwIncrementalSearch
      Left = 8
      Top = 222
      Width = 161
      Height = 21
      DataSource = wwDataSource1
      SearchField = 'purchaseName'
      OnAfterSearch = findPurAfterSearch
      TabOrder = 0
    end
    object FBoxSC: TComboBox
      Left = 14
      Top = 80
      Width = 140
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnCloseUp = FBoxSCCloseUp
      OnKeyDown = FBoxSCKeyDown
      OnKeyPress = FBoxSCKeyPress
    end
    object FBoxCnt: TComboBox
      Left = 14
      Top = 128
      Width = 96
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnCloseUp = FBoxCntCloseUp
      OnKeyDown = FBoxSCKeyDown
      OnKeyPress = FBoxSCKeyPress
      Items.Strings = (
        'Show All'
        'Prep.Item'
        'Purch.Line'
        'Strd.Line')
    end
    object BitBtn1: TBitBtn
      Left = 10
      Top = 478
      Width = 79
      Height = 33
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 96
      Top = 478
      Width = 89
      Height = 33
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 4
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = ADOQuery1
    Left = 288
    Top = 480
  end
  object ADOQuery1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = ADOQuery1AfterPost
    TableName = '[00_#NewAudit]'
    Left = 240
    Top = 480
    object ADOQuery1entitycode: TFloatField
      FieldName = 'entitycode'
    end
    object ADOQuery1subcat: TStringField
      FieldName = 'subcat'
    end
    object ADOQuery1purchasename: TStringField
      DisplayWidth = 40
      FieldName = 'purchasename'
      Size = 40
    end
    object ADOQuery1entitytype: TStringField
      FieldName = 'entitytype'
      Size = 10
    end
    object ADOQuery1purchaseunit: TStringField
      FieldName = 'purchaseunit'
      Size = 10
    end
    object ADOQuery1Sel: TStringField
      FieldName = 'Sel'
      OnChange = ADOQuery1SelChange
      Size = 1
    end
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = wwDataSource1
    SearchField = 'purchasename'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = False
    Left = 392
    Top = 96
  end
end
