object fnewinvdlg: Tfnewinvdlg
  Left = 578
  Top = 199
  ActiveControl = SupplierLookUp
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Invoice...'
  ClientHeight = 278
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 15
    Width = 51
    Height = 16
    Caption = 'Supplier:'
  end
  object lblInvoiceNumber: TLabel
    Left = 8
    Top = 125
    Width = 183
    Height = 16
    Caption = 'Invoice No (max. 15 characters)'
  end
  object Label3: TLabel
    Left = 8
    Top = 177
    Width = 83
    Height = 16
    Caption = 'Date Received'
  end
  object Label4: TLabel
    Left = 8
    Top = 69
    Width = 70
    Height = 16
    Caption = 'Stock Order'
  end
  object OKBtn: TBitBtn
    Left = 11
    Top = 236
    Width = 119
    Height = 36
    Caption = 'OK'
    TabOrder = 4
    OnClick = OKBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
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
    Left = 147
    Top = 233
    Width = 119
    Height = 36
    TabOrder = 5
    Kind = bkCancel
  end
  object SupplierLookUp: TwwDBLookupCombo
    Left = 8
    Top = 32
    Width = 249
    Height = 24
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'SupplierName'#9'20'#9'SupplierName'#9'F'#9)
    LookupTable = qrySupplier
    LookupField = 'SupplierName'
    Style = csDropDownList
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    OnChange = SupplierLookUpChange
    OnCloseUp = SupplierLookUpCloseUp
  end
  object dtDateReceived: TDateTimePicker
    Left = 8
    Top = 195
    Width = 186
    Height = 24
    CalAlignment = dtaLeft
    Date = 35893
    Time = 35893
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
    OnKeyPress = dtDateReceivedKeyPress
  end
  object InvoiceNoEdit: TMaskEdit
    Left = 8
    Top = 140
    Width = 249
    Height = 24
    MaxLength = 15
    TabOrder = 2
    OnKeyPress = InvoiceNoEditKeyPress
  end
  object StockOrderCombo: TComboBox
    Left = 9
    Top = 90
    Width = 235
    Height = 24
    ItemHeight = 16
    TabOrder = 1
    OnChange = StockOrderComboChange
    OnCloseUp = StockOrderComboCloseUp
  end
  object qrySupplier: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT v.[Supplier Name] AS SupplierName'
      'FROM vwSupplier v'
      '  INNER JOIN'
      '    (SELECT SupplierID'
      '     FROM ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s'
      '  ON v.[Supplier Code] = s.SupplierID'
      'ORDER BY [Supplier Name]')
    Left = 72
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 112
  end
  object qStockOrder: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsSupplier
    Parameters = <
      item
        Name = 'SupplierName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = 'Brake Bros.'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM StockOrder'
      'WHERE Deleted = 0'
      'AND ((Status = 1) OR (Status = 2))'
      'AND Supplier = :SupplierName')
    Left = 153
    Top = 63
  end
  object dsSupplier: TDataSource
    DataSet = qrySupplier
    Left = 75
    Top = 39
  end
end
