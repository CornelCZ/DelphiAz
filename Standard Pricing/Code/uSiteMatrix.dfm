object fSiteMatrix: TfSiteMatrix
  Left = 503
  Top = 301
  Width = 537
  Height = 314
  Caption = 'Assign Site Matrices'
  Color = clBtnFace
  Constraints.MinHeight = 294
  Constraints.MinWidth = 537
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdSiteMatrix: TwwDBGrid
    Left = 0
    Top = 103
    Width = 521
    Height = 139
    ControlType.Strings = (
      'DateOfChange;CustomEdit;dtGridPick;F'
      'FutureMatrixID;CustomEdit;cmbbxFutureMatrix;F'
      'LookupFutureMatrixID;CustomEdit;cmbbxFutureMatrix;F')
    Selected.Strings = (
      'Site Name'#9'20'#9'Site Name'#9#9
      'CurrentMatrix'#9'20'#9'Current Matrix'#9'F'
      'LookupFutureMatrixID'#9'20'#9'Future Matrix'#9'F'
      'DateOfChange'#9'18'#9'Date Of Change'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 2
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsSiteMatrix
    KeyOptions = []
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = grdSiteMatrixCalcCellColors
    OnColExit = grdSiteMatrixColExit
    OnExit = grdSiteMatrixExit
    OnKeyPress = grdSiteMatrixKeyPress
    PaintOptions.AlternatingRowColor = 15793150
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 521
    Height = 103
    Align = alTop
    Caption = 'Select Sites to view'
    TabOrder = 0
    DesignSize = (
      521
      103)
    object btnLoad: TBitBtn
      Left = 438
      Top = 14
      Width = 75
      Height = 65
      Anchors = [akRight, akBottom]
      Caption = '&Load'
      Default = True
      TabOrder = 1
      OnClick = btnLoadClick
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
    inline CompanyStructureFilterFrame: TCompanyStructureFilterFrame
      Left = 14
      Top = 13
      Width = 419
      Height = 84
      TabOrder = 0
      inherited lblSite: TLabel
        Left = 162
        Top = 4
      end
      inherited lblSalesArea: TLabel
        Left = 431
        Visible = False
      end
      inherited lblArea: TLabel
        Left = 0
        Top = 44
      end
      inherited lblSiteRef: TLabel
        Left = 162
        Top = 44
      end
      inherited CbSite: TComboBox
        Left = 161
        Top = 20
      end
      inherited CbSalesArea: TComboBox
        Left = 431
        Visible = False
      end
      inherited CbArea: TComboBox
        Left = 0
        Top = 60
      end
      inherited pnlSiteTag: TPanel
        Left = 314
        Top = 15
        Width = 98
        Height = 54
        inherited chkbxFilterBySiteTag: TCheckBox
          Left = 3
        end
        inherited btnSiteTags: TButton
          Left = 24
          Top = 28
          OnClick = CompanyStructureFilterFramebtnSiteTagsClick
        end
      end
      inherited CbSiteRef: TComboBox
        Left = 161
        Top = 60
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 242
    Width = 521
    Height = 33
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      521
      33)
    object btnClose: TBitBtn
      Left = 438
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Close'
      TabOrder = 2
      OnClick = btnCloseClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777777777777777777777713777777777777778F777777777777771377777777
        7777778F7777777777777713777777777777778F777777777777770377770007
        7777778F7777888F777777007770F00077777788F778F778FF77770000000FF0
        0077778F888F777788F777000FF00FF00077778F7777777778F77708F008F00F
        8077778F7777777778F77708F008F00F8077778F7777777778F777000FF00FF0
        0077778F7777777778F777000FF00FF00077778F7777777778F77708F008000F
        8077778F7777888F78F77770F000777080777778F778F778F8F7777700077777
        00777777888F777788F777777777777777777777777777777777}
      NumGlyphs = 2
    end
    object btnUndo: TBitBtn
      Left = 358
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Undo'
      Enabled = False
      TabOrder = 1
      OnClick = btnUndoClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888FFFF88888888888999998888888888877777FF8888888999999999
        8888888777888777F888889998888899988888777F8888877F88899988888889
        9988877FF888888877F8899888888888998887F88888888877F8998888888888
        899877F888888888877F99888888888889987F8888888888877F888888888888
        8998888888888888877F8888888888888998FFFFF8888888877F999998888888
        899877777F888888877F999988888888998877778888888887F8999888888889
        9988777F8888888877F8999998888899988877777F8888877F88988999999999
        88887F8777888777F88888888999998888888888877777FF8888}
      NumGlyphs = 2
    end
    object btnSave: TBitBtn
      Left = 277
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Enabled = False
      TabOrder = 0
      OnClick = btnSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777FFFFFFFFFFFFF7700000000000007778888888888888F703330700003
        330778F778F8888F778F703330700003330778F778F8888F778F703330700003
        330778F778F8888F778F703330000003330778F77888888F778F703333333333
        330778F77FFFFFFFF78F703000000000030778F8888888888F8F703077777777
        030778F8F77777778F8F703077777777030778F8F77777778F8F703077777777
        030778F8F77777778F8F703077777777030778F8F77777778F8F703077777777
        030778F8F77777778F8F703077777777030778F8F77777778F8F700000000000
        0007788888888888888F77777777777777777777777777777777}
      NumGlyphs = 2
    end
    object bitbtnExport: TBitBtn
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Action = actExport
      Caption = 'Export'
      TabOrder = 3
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bitbtnImport: TBitBtn
      Left = 88
      Top = 5
      Width = 75
      Height = 25
      Action = actImport
      Caption = 'Import'
      TabOrder = 4
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
    end
  end
  object dtGridPick: TwwDBDateTimePicker
    Left = 16
    Top = 130
    Width = 97
    Height = 21
    TabStop = False
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    CalendarAttributes.PopupYearOptions.YearsPerColumn = 5
    CalendarAttributes.PopupYearOptions.NumberColumns = 1
    Epoch = 1950
    ShowButton = True
    TabOrder = 3
    DisplayFormat = 'ddddd'
    Visible = False
    OnChange = dtGridPickChange
  end
  object cmbbxFutureMatrix: TDBLookupComboBox
    Left = 115
    Top = 129
    Width = 64
    Height = 21
    DataField = 'FutureMatrixID'
    DataSource = dsSiteMatrix
    KeyField = 'MatrixID'
    ListField = 'MatrixName'
    ListSource = DataSource1
    TabOrder = 4
  end
  object dsSiteMatrix: TDataSource
    DataSet = tblSiteMatrix
    Left = 96
    Top = 184
  end
  object tblSiteMatrix: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = tblSiteMatrixBeforePost
    CommandTimeout = 0
    TableName = '#tmpSiteMatrix'
    Left = 96
    Top = 152
    object tblSiteMatrixSiteName: TStringField
      DisplayWidth = 20
      FieldName = 'Site Name'
      ReadOnly = True
    end
    object tblSiteMatrixCurrentMatrix: TStringField
      DisplayWidth = 20
      FieldName = 'CurrentMatrix'
      ReadOnly = True
    end
    object tblSiteMatrixDateOfChange: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DateOfChange'
    end
    object tblSiteMatrixSiteCode: TSmallintField
      DisplayWidth = 10
      FieldName = 'SiteCode'
      ReadOnly = True
      Visible = False
    end
    object tblSiteMatrixLMDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LMDT'
      Visible = False
    end
    object tblSiteMatrixLMBy: TStringField
      DisplayWidth = 20
      FieldName = 'LMBy'
      Visible = False
    end
    object tblSiteMatrixDeleted: TBooleanField
      DisplayWidth = 5
      FieldName = 'Deleted'
      Visible = False
    end
    object tblSiteMatrixRecModified: TBooleanField
      DisplayWidth = 5
      FieldName = 'RecModified'
      Visible = False
    end
    object tblSiteMatrixFutureMatrixID: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'FutureMatrixID'
      OnChange = tblSiteMatrixFutureMatrixIDChange
    end
    object tblSiteMatrixFutureMatrix: TStringField
      FieldName = 'FutureMatrix'
    end
    object tblSiteMatrixLookupFutureMatrixID: TStringField
      FieldKind = fkLookup
      FieldName = 'LookupFutureMatrixID'
      LookupDataSet = qryMatrixName
      LookupKeyFields = 'MatrixID'
      LookupResultField = 'MatrixName'
      KeyFields = 'FutureMatrixID'
      Lookup = True
    end
  end
  object qryLoadSiteMatrix: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 136
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = qryMatrixName
    Left = 56
    Top = 184
  end
  object qryMatrixName: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select NULL as MatrixID, '#39#39' as MatrixName'
      'union'
      'select MatrixID, MatrixName'
      'from PriceMatrix'
      'where Deleted = 0'
      'order by MatrixName')
    Left = 56
    Top = 152
  end
  object qrySave: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 176
    Top = 152
  end
  object alSitematrix: TActionList
    Left = 16
    Top = 152
    object actImport: TAction
      Category = 'Edit'
      Caption = 'Import'
      OnExecute = actImportExecute
      OnUpdate = actImportUpdate
    end
    object actExport: TAction
      Category = 'Edit'
      Caption = 'Export'
      OnExecute = actExportExecute
      OnUpdate = actExportUpdate
    end
  end
end
