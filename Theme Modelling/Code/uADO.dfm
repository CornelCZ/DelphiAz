inherited dmADO: TdmADO
  OldCreateOrder = True
  Left = 190
  Top = 176
  Height = 638
  Width = 1247
  inherited adocRun: TADOCommand
    Left = 116
  end
  inherited adoqRun: TADOQuery
    Left = 220
  end
  inherited adoTRun: TADOTable
    Left = 276
  end
  inherited AztecConn: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI.1;Password=0049356GNHsxkzi26TYMF;Persist Securi' +
      'ty Info=True;User ID=zonalsysadmin;Initial Catalog=Aztec;Data So' +
      'urce=192.168.81.10'
    Provider = 'SQLNCLI.1'
  end
  object qRun: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 364
    Top = 16
  end
  object dsPrinterTypes: TDataSource
    DataSet = qPrinterTypes
    Left = 388
    Top = 120
  end
  object qPrinterTypes: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Filter = 'PrinterTypeID < 10000'
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM ThemePrinterType'
      'ORDER BY [PrinterTypeName]'
      '')
    Left = 304
    Top = 120
    object qPrinterTypesPrinterTypeName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'PrinterTypeName'
      Size = 50
    end
    object qPrinterTypesPaperCut: TStringField
      DisplayLabel = 'Paper Cut'
      DisplayWidth = 13
      FieldName = 'PaperCut'
      Size = 50
    end
    object qPrinterTypesDoubleWidth: TStringField
      DisplayLabel = 'Dbl. Width'
      DisplayWidth = 13
      FieldName = 'DoubleWidth'
      Size = 50
    end
    object qPrinterTypesNewLine: TStringField
      DisplayLabel = 'New Line'
      DisplayWidth = 10
      FieldName = 'NewLine'
      Size = 50
    end
    object qPrinterTypesBold: TStringField
      DisplayWidth = 10
      FieldName = 'Bold'
      Size = 50
    end
    object qPrinterTypesNormal: TStringField
      DisplayWidth = 12
      FieldName = 'Normal'
      Size = 50
    end
    object qPrinterTypesLine: TStringField
      DisplayWidth = 6
      FieldName = 'Line'
      Size = 50
    end
    object qPrinterTypesResetPrinter: TStringField
      DisplayLabel = 'Reset Printer'
      DisplayWidth = 10
      FieldName = 'ResetPrinter'
      Size = 50
    end
    object qPrinterTypesAlternateColour: TStringField
      DisplayLabel = 'Alternate Colour'
      DisplayWidth = 8
      FieldName = 'AlternateColour'
      Size = 50
    end
    object qPrinterTypesPrinterTypeID: TIntegerField
      FieldName = 'PrinterTypeID'
      Visible = False
    end
    object qPrinterTypesBaudRate: TIntegerField
      FieldName = 'BaudRate'
    end
    object qPrinterTypesTimeout: TIntegerField
      FieldName = 'Timeout'
    end
    object qPrinterTypesDoublePly: TBooleanField
      FieldName = 'DoublePly'
    end
    object qPrinterTypesIsKitchenScreen: TBooleanField
      FieldName = 'IsKitchenScreen'
    end
  end
  object dsAllPrinters: TDataSource
    DataSet = qAllPrinters
    Left = 132
    Top = 168
  end
  object dsTerminalPrinters: TDataSource
    DataSet = qTerminalPrinters
    Left = 132
    Top = 120
  end
  object dsGetTerminals: TDataSource
    DataSet = qGetTerminals
    Left = 140
    Top = 72
  end
  object qGetTerminals: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select * from themeeposdevice'
      'where SiteCode = :SiteCode')
    Left = 228
    Top = 80
    object qGetTerminalsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 50
    end
    object qGetTerminalsIPAddress: TStringField
      DisplayLabel = 'IP Address'
      DisplayWidth = 15
      FieldName = 'IPAddress'
      Size = 50
    end
    object qGetTerminalsEPoSDeviceID: TWordField
      DisplayWidth = 12
      FieldName = 'EPoSDeviceID'
      OnSetText = qGetTerminalsEPoSDeviceIDSetText
      OnValidate = qGetTerminalsEPoSDeviceIDValidate
    end
    object qGetTerminalsSiteCode: TIntegerField
      FieldName = 'SiteCode'
      Visible = False
    end
    object qGetTerminalsPOSCode: TIntegerField
      FieldName = 'POSCode'
      Visible = False
    end
    object qGetTerminalsCustomerDisplayType: TIntegerField
      FieldName = 'CustomerDisplayType'
      Visible = False
    end
    object qGetTerminalsScrollingMessage: TStringField
      FieldName = 'ScrollingMessage'
      Visible = False
      Size = 255
    end
    object qGetTerminalsConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object qGetTerminalsIsServer: TBooleanField
      FieldName = 'IsServer'
    end
    object qGetTerminalsServerID: TSmallintField
      FieldName = 'ServerID'
    end
    object qGetTerminalsHardwareType: TIntegerField
      FieldName = 'HardwareType'
    end
    object qGetTerminalsSubnetMask: TStringField
      FieldName = 'SubnetMask'
      Size = 15
    end
    object qGetTerminalsGatewayIP: TStringField
      FieldName = 'GatewayIP'
      Size = 15
    end
    object qGetTerminalsResetAccountNumber: TBooleanField
      FieldName = 'ResetAccountNumber'
    end
    object qGetTerminalsScreenInterfaceID: TSmallintField
      FieldName = 'ScreenInterfaceID'
    end
    object qGetTerminalsKiosk_SEC: TLargeintField
      FieldName = 'Kiosk_SEC'
    end
    object qGetTerminalsScrollingMessageOverrideId: TIntegerField
      FieldName = 'ScrollingMessageOverrideId'
    end
    object qGetTerminalsPoundCode: TIntegerField
      FieldName = 'PoundCode'
    end
    object qGetTerminalsMultiDrawerMode: TBooleanField
      FieldName = 'MultiDrawerMode'
    end
    object qGetTerminalsSoloMode: TBooleanField
      FieldName = 'SoloMode'
    end
  end
  object qTerminalPrinters: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dsGetTerminals
    Parameters = <
      item
        Name = 'eposdeviceid'
        DataType = ftWord
        Precision = 3
        Value = Null
      end
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from ThemeEposPrinter'
      'where eposdeviceID = :eposdeviceid'
      'and Sitecode = :SiteCode')
    Left = 44
    Top = 120
    object qTerminalPrintersName: TStringField
      DisplayWidth = 15
      FieldName = 'Name'
      Size = 50
    end
    object qTerminalPrintersPrinterTypeName: TStringField
      DisplayLabel = 'Printer Type'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'PrinterTypeName'
      LookupDataSet = qPrinterTypes
      LookupKeyFields = 'PrinterTypeID'
      LookupResultField = 'PrinterTypeName'
      KeyFields = 'PrinterType'
      Size = 50
      Lookup = True
    end
    object qTerminalPrintersPortNumber: TWordField
      DisplayLabel = 'Port Number'
      DisplayWidth = 11
      FieldName = 'PortNumber'
      MaxValue = 255
    end
    object qTerminalPrintersEposName1: TStringField
      DisplayLabel = 'Button Name 1'
      DisplayWidth = 11
      FieldName = 'EposName1'
    end
    object qTerminalPrintersEposName2: TStringField
      DisplayLabel = 'Button Name 2'
      DisplayWidth = 12
      FieldName = 'EposName2'
    end
    object qTerminalPrintersEposName3: TStringField
      DisplayLabel = 'Button Name 3'
      DisplayWidth = 14
      FieldName = 'EposName3'
    end
    object qTerminalPrintersReDirectLkUp: TStringField
      DisplayLabel = 'Redirect Printer'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'ReDirectLkUp'
      LookupDataSet = qRedirectPrinterLookup
      LookupKeyFields = 'printerID'
      LookupResultField = 'name'
      KeyFields = 'RedirectionPrinterId'
      Lookup = True
    end
    object qTerminalPrintersPrinterType: TIntegerField
      DisplayLabel = 'Printer Type'
      DisplayWidth = 10
      FieldName = 'PrinterType'
      Visible = False
    end
    object qTerminalPrintersRedirectionPrinterId: TLargeintField
      DisplayWidth = 15
      FieldName = 'RedirectionPrinterId'
      Visible = False
    end
    object qTerminalPrintersPrinterID: TLargeintField
      FieldName = 'PrinterID'
      Visible = False
    end
    object qTerminalPrintersSiteCode: TIntegerField
      FieldName = 'SiteCode'
      Visible = False
    end
    object qTerminalPrintersEposDeviceID: TWordField
      FieldName = 'EposDeviceID'
      Visible = False
    end
    object qTerminalPrintersChangePaperTimeout: TIntegerField
      FieldName = 'ChangePaperTimeout'
    end
    object qTerminalPrintersIPAddress: TStringField
      FieldName = 'IPAddress'
    end
    object qTerminalPrintersIPPort: TIntegerField
      FieldName = 'IPPort'
    end
    object qTerminalPrintersCompactOrderLines: TBooleanField
      FieldName = 'CompactOrderLines'
    end
    object qTerminalPrintersShowSeatHeader: TBooleanField
      FieldName = 'ShowSeatHeader'
    end
    object qTerminalPrintersEFTPay: TBooleanField
      FieldName = 'EnableEFTPay'
    end
    object qTerminalPrintersHasCashDrawer: TBooleanField
      FieldName = 'HasCashDrawer'
    end
    object qTerminalPrintersOrderTicketsToPrint: TIntegerField
      FieldName = 'OrderTicketsToPrint'
      MaxValue = 5
      MinValue = 1
    end
    object qTerminalPrintersCustomDeviceID: TStringField
      FieldName = 'CustomDeviceID'
    end
  end
  object qAllPrinters: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'Sitecode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select printerid, name from ThemeEposPrinter'
      'where SiteCode = :Sitecode')
    Left = 44
    Top = 168
  end
  object dsEditStreams: TDataSource
    DataSet = qEditStreams
    Left = 388
    Top = 216
  end
  object dsPrintStreams: TDataSource
    DataSet = qPrintStreams
    Left = 388
    Top = 168
  end
  object qPrintStreams: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from pStreams'
      '')
    Left = 300
    Top = 168
    object qPrintStreamsPrinterStreamName: TStringField
      DisplayWidth = 19
      FieldName = 'Printer Stream Name'
      Size = 19
    end
    object qPrintStreamsIndexNo: TSmallintField
      DisplayWidth = 10
      FieldName = 'Index No'
      Visible = False
    end
    object qPrintStreamsAltered: TStringField
      DisplayWidth = 1
      FieldName = 'Altered'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qPrintStreamsDeleted: TStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qPrinters2: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'Sitecode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select  -1 as printerID,cast(-1 as varchar(30)) as printeraddres' +
        'sid, '#39'<no printer>'#39' as name'
      'union all'
      
        'select printerid ,cast(printerid as varchar(30)) as printeraddre' +
        'ssid , name from ThemeEposPrinter'
      'where SiteCode = :Sitecode'
      'order by 1')
    Left = 44
    Top = 216
    object qPrinters2name: TStringField
      DisplayWidth = 50
      FieldName = 'name'
      ReadOnly = True
      Size = 50
    end
    object qPrinters2printeraddressid: TStringField
      DisplayWidth = 30
      FieldName = 'printeraddressid'
      ReadOnly = True
      Visible = False
      Size = 30
    end
    object qPrinters2printerID: TLargeintField
      DisplayWidth = 15
      FieldName = 'printerID'
      ReadOnly = True
      Visible = False
    end
  end
  object qSeed: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 324
    Top = 16
  end
  object qEditStreams: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    BeforeClose = qEditStreamsBeforeClose
    BeforePost = qEditStreamsBeforePost
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        '/*if (select object_id('#39'tempdb..#tmpstreams'#39')) is not null drop ' +
        'table #tmpstreams'
      ''
      ''
      
        'select cast(Sub.printstreamid as Int) as printstreamid, sub.term' +
        'inal,'
      'cast(strm.printerID as varchar(30)) as printeraddress,'
      'cast(strm2.printerID as varchar(30)) as printeraddress2'
      ''
      'into #tmpstreams'
      'from'
      ''
      
        '(select a.[Index No] as printstreamid, b.eposdeviceid as termina' +
        'l'
      'from pStreams a, themeeposdevice b'
      'where SiteCode = 1) sub'
      ''
      'left outer join ThemeEposPrinterStream strm'
      'on sub.printstreamid = strm.printstreamid and'
      'sub.terminal = strm.EposDeviceID'
      ''
      'left outer join ThemeEposPrinterStream strm2'
      
        'on sub.printstreamid = strm2.printstreamid and strm2.TargetID = ' +
        '2 and'
      'sub.terminal = strm2.EposDeviceID'
      'order by 2, 1'
      '*/'
      ''
      'select * from #tmpstreams'
      'where terminal <> 0')
    Left = 300
    Top = 216
    object qEditStreamsTerminalName: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Terminal Name'
      LookupDataSet = qGetTerminals
      LookupKeyFields = 'EPoSDeviceID'
      LookupResultField = 'Name'
      KeyFields = 'terminal'
      Size = 50
      Lookup = True
    end
    object qEditStreamsPrintStream: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Print Stream'
      LookupDataSet = qPrintStreams
      LookupKeyFields = 'Index No'
      LookupResultField = 'Printer Stream Name'
      KeyFields = 'printstreamid'
      Size = 50
      Lookup = True
    end
    object qEditStreamsprinterlookup: TStringField
      DisplayLabel = 'Printer'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'printerlookup'
      LookupDataSet = qPrinters2
      LookupKeyFields = 'printeraddressid'
      LookupResultField = 'name'
      KeyFields = 'printeraddress'
      Size = 50
      Lookup = True
    end
    object qEditStreamsprinter2lookup: TStringField
      DisplayLabel = 'Printer 2'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'printer2lookup'
      LookupDataSet = qPrinters2
      LookupKeyFields = 'printeraddressid'
      LookupResultField = 'name'
      KeyFields = 'printeraddress2'
      Lookup = True
    end
    object qEditStreamsTerminal: TSmallintField
      DisplayWidth = 10
      FieldName = 'Terminal'
      Visible = False
    end
    object qEditStreamsprintstreamid: TIntegerField
      DisplayWidth = 10
      FieldName = 'printstreamid'
      Visible = False
    end
    object qEditStreamsprinteraddress: TStringField
      DisplayWidth = 15
      FieldName = 'printeraddress'
      Visible = False
      Size = 30
    end
    object qEditStreamsprinteraddress2: TStringField
      DisplayWidth = 15
      FieldName = 'printeraddress2'
      Visible = False
      OnValidate = qEditStreamsprinteraddress2Validate
      Size = 30
    end
  end
  object dsPrinters2: TDataSource
    DataSet = qPrinters2
    Left = 132
    Top = 216
  end
  object qRedirectPrinterLookup: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'Sitecode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'PrinterID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      
        'select  NULL as printerID,cast(0 as varchar(30)) as printeraddre' +
        'ssid, '#39'<no printer>'#39' as name'
      'union all'
      
        'select printerid ,cast(printerid as varchar(30)) as printeraddre' +
        'ssid , name from ThemeEposPrinter'
      
        'inner join themeprintertype tpt on tpt.PrinterTypeID = ThemeEpos' +
        'Printer.PrinterType'
      'where SiteCode = :Sitecode'
      'and PrinterID <> :PrinterID'
      'and tpt.IsPrinter = 1'
      'and not tpt.PrinterTypeID in (10030, 10031, 10033)'
      'order by 3')
    Left = 44
    Top = 272
    object StringField2: TStringField
      DisplayWidth = 50
      FieldName = 'name'
      ReadOnly = True
      Size = 50
    end
    object StringField1: TStringField
      FieldName = 'printeraddressid'
      ReadOnly = True
      Visible = False
      Size = 30
    end
    object LargeintField1: TLargeintField
      FieldName = 'printerID'
      ReadOnly = True
      Visible = False
    end
  end
  object dsRedirectPrinterLookUp: TDataSource
    DataSet = qRedirectPrinterLookup
    Left = 156
    Top = 280
  end
  object qOutletPrintConfigs: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      
        'SELECT * FROM ThemeOutletStandardPrintConfigs WHERE SiteCode = :' +
        'SiteCode')
    Left = 296
    Top = 272
    object qOutletPrintConfigsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qOutletPrintConfigsBillReceiptPrintStream: TLargeintField
      FieldName = 'BillReceiptPrintStream'
    end
    object qOutletPrintConfigsReportPrintStream: TLargeintField
      FieldName = 'ReportPrintStream'
      OnValidate = qOutletPrintConfigsReportPrintStreamValidate
    end
    object qOutletPrintConfigsEFTPrintStream: TLargeintField
      FieldName = 'EFTPrintStream'
    end
    object qOutletPrintConfigsSOAPServerTicketPrintStream: TLargeintField
      FieldName = 'SOAPServerTicketPrintStream'
    end
    object qOutletPrintConfigsPrintHeader1: TStringField
      FieldName = 'PrintHeader1'
      Size = 80
    end
    object qOutletPrintConfigsPrintHeader2: TStringField
      FieldName = 'PrintHeader2'
      Size = 80
    end
    object qOutletPrintConfigsPrintHeader3: TStringField
      FieldName = 'PrintHeader3'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter1: TStringField
      FieldName = 'PrintFooter1'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter2: TStringField
      FieldName = 'PrintFooter2'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter3: TStringField
      FieldName = 'PrintFooter3'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter4: TStringField
      FieldName = 'PrintFooter4'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter5: TStringField
      FieldName = 'PrintFooter5'
      Size = 80
    end
    object qOutletPrintConfigsPrintFooter6: TStringField
      FieldName = 'PrintFooter6'
      Size = 80
    end
    object qOutletPrintConfigsVATNumber: TStringField
      FieldName = 'VATNumber'
      Size = 80
    end
    object qOutletPrintConfigsEFTHeader1: TStringField
      FieldName = 'EFTHeader1'
      Size = 80
    end
    object qOutletPrintConfigsEFTHeader2: TStringField
      FieldName = 'EFTHeader2'
      Size = 80
    end
    object qOutletPrintConfigsEFTHeader3: TStringField
      FieldName = 'EFTHeader3'
      Size = 80
    end
    object qOutletPrintConfigsCloakroomPrintStream: TLargeintField
      FieldName = 'CloakroomPrintStream'
    end
    object qOutletPrintConfigsCloakroomTicketHeader: TStringField
      FieldName = 'CloakroomTicketHeader'
      Size = 80
    end
    object qOutletPrintConfigsCorrectionTicketFooter1: TStringField
      FieldName = 'CorrectionTicketFooter1'
      Size = 50
    end
    object qOutletPrintConfigsCorrectionTicketFooter2: TStringField
      FieldName = 'CorrectionTicketFooter2'
      Size = 50
    end
    object qOutletPrintConfigsCorrectionTicketFooter3: TStringField
      FieldName = 'CorrectionTicketFooter3'
      Size = 50
    end
    object qOutletPrintConfigsCorrectionTicketFooter4: TStringField
      FieldName = 'CorrectionTicketFooter4'
      Size = 50
    end
    object qOutletPrintConfigsCorrectionTicketFooter5: TStringField
      FieldName = 'CorrectionTicketFooter5'
      Size = 50
    end
    object qOutletPrintConfigsCorrectionTicketFooter6: TStringField
      FieldName = 'CorrectionTicketFooter6'
      Size = 50
    end
    object qOutletPrintConfigsCompactBillLines: TBooleanField
      FieldName = 'CompactBillLines'
    end
    object qOutletPrintConfigsStandardFooterOverrideId: TIntegerField
      FieldName = 'StandardFooterOverrideId'
    end
    object qOutletPrintConfigsPromotionSavingsOnBill: TBooleanField
      FieldName = 'PromotionSavingsOnBill'
    end
    object qOutletPrintConfigsDiscountSavingsOnBill: TBooleanField
      FieldName = 'DiscountSavingsOnBill'
    end
    object qOutletPrintConfigsTotalSavingsOnBill: TBooleanField
      FieldName = 'TotalSavingsOnBill'
    end
    object qOutletPrintConfigsBillFooterOverrideId: TIntegerField
      FieldName = 'BillFooterOverrideId'
    end
    object qOutletPrintConfigsCustomerVoucherWhenPay: TIntegerField
      FieldName = 'CustomerVoucherWhenPay'
    end
    object qOutletPrintConfigsPrintQrCode: TBooleanField
      FieldName = 'PrintQrCode'
    end
    object qOutletPrintConfigsQrCodeUrlForReceipt: TStringField
      FieldName = 'QrCodeUrlForReceipt'
      Size = 1000
    end
    object qOutletPrintConfigsPrintQrCodeOnReceipt: TBooleanField
      FieldName = 'PrintQrCodeOnReceipt'
    end
    object qOutletPrintConfigsPrintQrCodeOnBills: TBooleanField
      FieldName = 'PrintQrCodeOnBills'
    end
    object qOutletPrintConfigsPrintQrCodeSize: TIntegerField
      FieldName = 'PrintQrCodeSize'
    end
    object qOutletPrintConfigsAppendRefundData: TBooleanField
      FieldName = 'AppendRefundData'
    end
  end
  object dsOutletPrintConfigs: TDataSource
    DataSet = qOutletPrintConfigs
    Left = 392
    Top = 272
  end
  object qGetPoses: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'sitecode'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end
      item
        Name = 'current_pos'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @sitecode int = :sitecode'
      ''
      'select null as [pos code], '#39'(none)'#39' as [pos name]'
      'union'
      'select [Pos code], [pos name] from config '
      'where (deleted is null or (deleted = '#39'N'#39')) '
      'and [pos code] is not null'
      'and [site code] = @sitecode'
      'and ([Pos code] = :current_pos'
      'or [Pos code] not in (select POSCode from ThemeEposDevice_Repl'
      
        '                                   where (deleted is null or (de' +
        'leted = 0)) '
      '                                   and poscode is not null'
      '                                   and sitecode = @sitecode))')
    Left = 52
    Top = 344
    object qGetPosesPoscode: TFloatField
      FieldName = 'Pos code'
    end
    object qGetPosesposname: TStringField
      FieldName = 'pos name'
    end
  end
  object dsGetPoses: TDataSource
    DataSet = qGetPoses
    Left = 140
    Top = 344
  end
  object qDiscounts: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Filter = 'Deleted=0'
    Filtered = True
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select  a.*,'
      'cast(case ReferenceRequired when 1 then 0'
      
        #9' else (Select case count(*) when 0 then 0 else 1 end From Theme' +
        'DiscountCardSecurity where DiscountID = a.DiscountID)'
      #9' end as bit) as CardSecurityDefined'
      'from Discount_repl a'
      'order by name')
    Left = 296
    Top = 376
    object qDiscountsDiscountID: TLargeintField
      Alignment = taLeftJustify
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'DiscountID'
    end
    object qDiscountsName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 50
    end
    object qDiscountsDiscountTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'DiscountTypeName'
      LookupDataSet = qDiscountType
      LookupKeyFields = 'Id'
      LookupResultField = 'value'
      KeyFields = 'DiscountType'
      Size = 16
      Lookup = True
    end
    object qDiscountsCardSecurityDefined: TBooleanField
      DisplayLabel = 'Card~Security'
      DisplayWidth = 6
      FieldName = 'CardSecurityDefined'
      ReadOnly = True
      DisplayValues = 'Yes;No'
    end
    object qDiscountsAutoPrintReceipt: TBooleanField
      DisplayLabel = 'Auto Print~Receipt'
      DisplayWidth = 7
      FieldName = 'AutoPrintReceipt'
    end
    object qDiscountsMaximumDiscount: TFloatField
      DisplayLabel = 'Maximum~Discount'
      DisplayWidth = 7
      FieldName = 'MaximumDiscount'
      OnGetText = qDiscountsMaximumDiscountGetText
    end
    object qDiscountsMaximumRate: TIntegerField
      DisplayLabel = 'Maximum~% Rate'
      DisplayWidth = 7
      FieldName = 'MaximumRate'
      OnGetText = qDiscountsMaximumRateGetText
    end
    object qDiscountsDisablesPromotions: TBooleanField
      DisplayLabel = 'Disables~Promotions'
      DisplayWidth = 8
      FieldName = 'DisablesPromotions'
    end
    object qDiscountsReasonRequired: TBooleanField
      DisplayLabel = 'Reason~Required'
      DisplayWidth = 7
      FieldName = 'ReasonRequired'
    end
    object qDiscountsReferenceRequired: TBooleanField
      DisplayLabel = 'Reference~Required'
      DisplayWidth = 8
      FieldName = 'ReferenceRequired'
    end
    object qDiscountsAppliesToOrderLineFamily: TBooleanField
      DisplayLabel = 'Single Item~Discount'
      DisplayWidth = 5
      FieldName = 'AppliesToOrderLineFamily'
    end
    object qDiscountsDoNotDiscountNonServiceChargeExclusiveTaxes: TBooleanField
      DisplayLabel = 'Ignore~Excl. Tax'
      DisplayWidth = 5
      FieldName = 'DoNotDiscountNonServiceChargeExclusiveTaxes'
    end
    object qDiscountsConfirmForfeit: TBooleanField
      DisplayLabel = 'Warning~Threshold'
      DisplayWidth = 5
      FieldName = 'ConfirmForfeit'
    end
    object qDiscountsConfirmForfeitThresholdAmount: TCurrencyField
      DisplayLabel = 'Threshold~Amount'
      DisplayWidth = 10
      FieldName = 'ConfirmForfeitThresholdAmount'
    end
    object qDiscountsIncludeAllProducts: TBooleanField
      DisplayLabel = 'Include All~Products'
      DisplayWidth = 8
      FieldName = 'IncludeAllProducts'
      Visible = False
    end
    object qDiscountsCalcDiscountType: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 16
      FieldKind = fkCalculated
      FieldName = 'CalcDiscountType'
      Visible = False
      Calculated = True
    end
    object qDiscountsDiscountType: TSmallintField
      DisplayWidth = 10
      FieldName = 'DiscountType'
      Visible = False
    end
    object qDiscountsEposName1: TStringField
      FieldName = 'EposName1'
      Visible = False
      Size = 50
    end
    object qDiscountsEposName2: TStringField
      FieldName = 'EposName2'
      Visible = False
      Size = 50
    end
    object qDiscountsEposName3: TStringField
      FieldName = 'EposName3'
      Visible = False
      Size = 50
    end
    object qDiscountsAmount: TBCDField
      DisplayWidth = 8
      FieldName = 'Amount'
      Visible = False
      Precision = 7
      Size = 2
    end
    object qDiscountsDivisionList: TIntegerField
      FieldName = 'DivisionList'
      Visible = False
    end
    object qDiscountsMinimumSpend: TBCDField
      FieldName = 'MinimumSpend'
      Visible = False
      Precision = 19
    end
    object qDiscountsMinimumSpendDivisional: TBooleanField
      FieldName = 'MinimumSpendDivisional'
      Visible = False
    end
    object qDiscountsOpensCashDrawer: TBooleanField
      FieldName = 'OpensCashDrawer'
      Visible = False
    end
    object qDiscountsProductGroupID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductGroupID'
      Visible = False
    end
    object qDiscountsMinSpendProdGroupID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MinSpendProdGroupID'
      Visible = False
    end
    object qDiscountsPreventFurtherSales: TBooleanField
      FieldName = 'PreventFurtherSales'
      Visible = False
    end
    object qDiscountsDeleted: TBooleanField
      FieldName = 'Deleted'
      Visible = False
    end
  end
  object dsDiscounts: TDataSource
    DataSet = qDiscounts
    Left = 392
    Top = 376
  end
  object qCurrencies: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeCurrency')
    Left = 40
    Top = 400
    object qCurrenciesCurrCode: TStringField
      DisplayLabel = 'Code'
      DisplayWidth = 8
      FieldName = 'CurrCode'
      Size = 3
    end
    object qCurrenciesName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 25
    end
    object qCurrenciesSymbol: TStringField
      DisplayWidth = 1
      FieldName = 'Symbol'
      Visible = False
      Size = 1
    end
    object qCurrenciesExchangeRate: TBCDField
      DisplayLabel = 'Exchange Rate'
      DisplayWidth = 14
      FieldName = 'ExchangeRate'
      Precision = 19
    end
    object qCurrenciesShowDecimal: TBooleanField
      DisplayLabel = 'Show Decimal'
      DisplayWidth = 5
      FieldName = 'ShowDecimal'
      Visible = False
    end
    object qCurrenciesCurrencyID: TIntegerField
      FieldName = 'CurrencyID'
      Visible = False
    end
  end
  object dsCurrencies: TDataSource
    DataSet = qCurrencies
    Left = 88
    Top = 400
  end
  object qryGiftCardTypes: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeGiftCardType')
    Left = 296
    Top = 432
  end
  object dsGiftCardTypes: TDataSource
    DataSet = qryGiftCardTypes
    Left = 392
    Top = 432
  end
  object qOutletConfigs: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    BeforePost = qOutletConfigsBeforePost
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM ThemeOutletConfigs WHERE SiteCode = :SiteCode')
    Left = 296
    Top = 320
    object qOutletConfigsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qOutletConfigsDeclareTips: TBooleanField
      FieldName = 'DeclareTips'
    end
    object qOutletConfigsWarnIfAccountsOpen: TBooleanField
      FieldName = 'WarnIfAccountsOpen'
    end
    object qOutletConfigsCashbackAllowed: TBooleanField
      FieldName = 'CashbackAllowed'
    end
    object qOutletConfigsICCFallbackAllowed: TBooleanField
      FieldName = 'ICCFallbackAllowed'
    end
    object qOutletConfigsSessionChangeWarnIfAccountsOpen: TBooleanField
      FieldName = 'SessionChangeWarnIfAccountsOpen'
    end
    object qOutletConfigsSessionChangeWarnIfAccountsOpenLastTerminalOnly: TBooleanField
      FieldName = 'SessionChangeWarnIfAccountsOpenLastTerminalOnly'
    end
    object qOutletConfigsSessionChangeWarnIfAccountsOpenInSalesArea: TBooleanField
      FieldName = 'SessionChangeWarnIfAccountsOpenInSalesArea'
    end
    object qOutletConfigsTipValidationPercentage: TWordField
      FieldName = 'TipValidationPercentage'
    end
    object qOutletConfigsIPAddress: TStringField
      FieldName = 'IPAddress'
      OnChange = qOutletConfigsIPAddressChange
      OnValidate = ValidateIPAddress
      Size = 15
    end
    object qOutletConfigsUseScheduling: TBooleanField
      FieldName = 'UseScheduling'
    end
    object qOutletConfigsUseDefaultDutySecurity: TBooleanField
      FieldName = 'UseDefaultDutySecurity'
    end
    object qOutletConfigsCardCharge: TFloatField
      FieldName = 'CardCharge'
    end
    object qOutletConfigsHouseTipOut: TFloatField
      FieldName = 'HouseTipOut'
    end
    object qOutletConfigsAutoDeductTip: TBooleanField
      FieldName = 'AutoDeductTip'
    end
    object qOutletConfigsPayoutTipsOnClockout: TBooleanField
      FieldName = 'PayoutTipsOnClockout'
    end
    object qOutletConfigsPromptedSpotCheck: TBooleanField
      FieldName = 'PromptedSpotCheck'
    end
    object qOutletConfigsRequestReferenceForFloatIncrease: TBooleanField
      FieldName = 'RequestReferenceForFloatIncrease'
    end
    object qOutletConfigsRequestReferenceForFloatSkim: TBooleanField
      FieldName = 'RequestReferenceForFloatSkim'
    end
    object qOutletConfigsEFTRequestIPPort: TIntegerField
      FieldName = 'EFTRequestIPPort'
    end
    object qOutletConfigsEFTResponseIPPort: TIntegerField
      FieldName = 'EFTResponseIPPort'
    end
    object qOutletConfigsGiftRequestIPPort: TIntegerField
      FieldName = 'GiftRequestIPPort'
    end
    object qOutletConfigsGiftResponseIPPort: TIntegerField
      FieldName = 'GiftResponseIPPort'
    end
    object qOutletConfigsGiftCardType: TIntegerField
      FieldName = 'GiftCardType'
    end
    object qOutletConfigsShowAccountInformationOnVoucher: TBooleanField
      FieldName = 'ShowAccountInformationOnVoucher'
    end
    object qOutletConfigsEFTMode: TWordField
      FieldName = 'EFTMode'
    end
    object qOutletConfigsCommideaServerIPAddress: TStringField
      FieldName = 'CommideaServerIPAddress'
      Size = 15
    end
    object qOutletConfigsCommideaServerIPPort: TIntegerField
      FieldName = 'CommideaServerIPPort'
    end
    object qOutletConfigsSendAllBarcodedProducts: TBooleanField
      FieldName = 'SendAllBarcodedProducts'
    end
    object qOutletConfigsCommideaPinPadLogin: TStringField
      FieldName = 'CommideaPinPadLogin'
      Size = 4
    end
    object qOutletConfigsCommideaPinPadPIN: TStringField
      FieldName = 'CommideaPinPadPIN'
      Size = 4
    end
    object qOutletConfigsCommideaMainMenuOptions: TStringField
      FieldName = 'CommideaMainMenuOptions'
      Size = 4
    end
    object qOutletConfigsCommideaSubMenuOptions: TStringField
      FieldName = 'CommideaSubMenuOptions'
      Size = 4
    end
    object qOutletConfigsCommideaTransactionTimeout: TIntegerField
      FieldName = 'CommideaTransactionTimeout'
    end
    object qOutletConfigsEFTPreAuthAmount: TBCDField
      FieldName = 'EFTPreAuthAmount'
      EditFormat = '###0.##'
      currency = True
      Precision = 19
    end
    object qOutletConfigsAllowEnhancedTipAdjust: TBooleanField
      FieldName = 'AllowEnhancedTipAdjust'
    end
    object qOutletConfigsUseAutoDecimalEntry: TBooleanField
      FieldName = 'UseAutoDecimalEntry'
    end
    object qOutletConfigsAutoFillValue: TBooleanField
      FieldName = 'AutoFillValue'
    end
    object qOutletConfigsFastEFTAmount: TBCDField
      FieldName = 'FastEFTAmount'
      EditFormat = '###0.##'
      currency = True
      Precision = 19
    end
    object qOutletConfigsPrintClockINTicket: TBooleanField
      FieldName = 'PrintClockINTicket'
    end
    object qOutletConfigsPrintClockOUTTicket: TBooleanField
      FieldName = 'PrintClockOUTTicket'
    end
    object qOutletConfigsAbbreviatedClockOutTicket: TBooleanField
      FieldName = 'AbbreviatedClockOutTicket'
    end
    object qOutletConfigsScaleDecimalPlaces: TIntegerField
      FieldName = 'ScaleDecimalPlaces'
      OnSetText = qOutletConfigsScaleDecimalPlacesSetText
      OnValidate = qOutletConfigsScaleDecimalPlacesValidate
    end
    object qOutletConfigsScaleDisplayUnit: TStringField
      FieldName = 'ScaleDisplayUnit'
      OnSetText = qOutletConfigsScaleDisplayUnitSetText
      OnValidate = qOutletConfigsScaleDisplayUnitValidate
      Size = 2
    end
    object qOutletConfigsServiceChargeCoverThreshold: TWordField
      FieldName = 'ServiceChargeCoverThreshold'
    end
    object qOutletConfigsZcpsApplyPreAuthCreditLimit: TBooleanField
      FieldName = 'ZcpsApplyPreAuthCreditLimit'
    end
    object qOutletConfigsAdMarginConnectionString: TWideStringField
      FieldName = 'AdMarginConnectionString'
      Size = 400
    end
    object qOutletConfigsQSRShowAztecCoursesSeparately: TBooleanField
      FieldName = 'QSRShowAztecCoursesSeparately'
    end
    object qOutletConfigsKMSPrimaryServerIPAddress: TStringField
      FieldName = 'KMSPrimaryServerIPAddress'
      OnSetText = NullableFieldSetText
      OnValidate = qOutletConfigsKMSPrimaryServerIPAddressValidate
      Size = 15
    end
    object qOutletConfigsKMSPrimaryServerPort: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'KMSPrimaryServerPort'
      OnSetText = NullableFieldSetText
      OnValidate = qOutletConfigsKMSPrimaryServerPortValidate
    end
    object qOutletConfigsKMSBackupServerIPAddress: TStringField
      FieldName = 'KMSBackupServerIPAddress'
      OnSetText = NullableFieldSetText
      OnValidate = qOutletConfigsKMSBackupServerIPAddressValidate
      Size = 15
    end
    object qOutletConfigsKMSBackupServerPort: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'KMSBackupServerPort'
      OnSetText = NullableFieldSetText
      OnValidate = qOutletConfigsKMSBackupServerPortValidate
    end
    object qOutletConfigsSurveyCodeSupplier: TIntegerField
      FieldName = 'SurveyCodeSupplier'
      OnValidate = qOutletConfigsSurveyCodeSupplierValidate
    end
    object qOutletConfigsOciusPinPadLoginId: TStringField
      FieldName = 'OciusPinPadLoginId'
      Size = 8
    end
    object qOutletConfigsOciusPinPadPassword: TStringField
      FieldName = 'OciusPinPadPassword'
      Size = 8
    end
    object qOutletConfigsIPToSerialMapperStartPort: TIntegerField
      FieldName = 'IPToSerialMapperStartPort'
      OnValidate = qOutletConfigsIPToSerialMapperStartPortValidate
    end
    object qOutletConfigsReconfirmTipEntry: TBooleanField
      FieldName = 'ReconfirmTipEntry'
    end
    object qOutletConfigsConfirmReversePaymentOfAnother: TBooleanField
      FieldName = 'ConfirmReversePaymentOfAnother'
    end
  end
  object dsOutletConfigs: TDataSource
    DataSet = qOutletConfigs
    Left = 392
    Top = 320
  end
  object qDivision: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT [Division Name] as DivisionName, [Index No] as IndexNo FR' +
        'OM DIVISION'
      'order by DivisionName')
    Left = 508
    Top = 104
    object qDivisionDivisionName: TStringField
      FieldName = 'DivisionName'
    end
    object qDivisionIndexNo: TSmallintField
      FieldName = 'IndexNo'
    end
  end
  object qCategories: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'DivisionIndex'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT [Category Name] as CategoryName, [Index No] as IndexNo'
      'FROM Category'
      'WHERE [Division Index] = :DivisonIndex')
    Left = 508
    Top = 160
    object qCategoriesCategoryName: TStringField
      FieldName = 'CategoryName'
    end
    object qCategoriesIndexNo: TSmallintField
      FieldName = 'IndexNo'
    end
  end
  object qSubCategories: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'CategoryIndex'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT [Sub-Category Name] as SubCategoryName, [Index No] as Ind' +
        'exNo'
      'FROM SubCateg'
      'WHERE [Category Index] = :CategoryIndex'
      '')
    Left = 508
    Top = 216
    object qSubCategoriesSubCategoryName: TStringField
      FieldName = 'SubCategoryName'
    end
    object qSubCategoriesIndexNo: TSmallintField
      FieldName = 'IndexNo'
    end
  end
  object BaseDataTable: TADODataSet
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 136
    Top = 456
  end
  object qThemeTerminalEFTTimeouts: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    BeforePost = qThemeTerminalEFTTimeoutsBeforePost
    OnCalcFields = qThemeTerminalEFTTimeoutsCalcFields
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      '  * '
      'FROM '
      '  ThemeTerminalEFTTimeouts '
      'WHERE '
      '  SiteCode = :SiteCode')
    Left = 512
    Top = 320
    object qThemeTerminalEFTTimeoutsName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 25
    end
    object qThemeTerminalEFTTimeoutsTotalTimeout: TStringField
      DisplayLabel = 'Total Timeout'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalTimeout'
      ReadOnly = True
      Calculated = True
    end
    object qThemeTerminalEFTTimeoutsTimeoutTime: TIntegerField
      DisplayLabel = 'Interval (s)'
      DisplayWidth = 10
      FieldName = 'TimeoutTime'
    end
    object qThemeTerminalEFTTimeoutsTimeoutRetryCount: TIntegerField
      DisplayLabel = 'Attempts'
      DisplayWidth = 10
      FieldName = 'TimeoutRetryCount'
    end
    object qThemeTerminalEFTTimeoutsSiteCode: TIntegerField
      FieldName = 'SiteCode'
      Visible = False
    end
    object qThemeTerminalEFTTimeoutsID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
  end
  object dsThemeTerminalEFTTimouts: TDataSource
    DataSet = qThemeTerminalEFTTimeouts
    Left = 512
    Top = 384
  end
  object qThemeOutletEftModeLookup: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeOutletEftModeLookup')
    Left = 512
    Top = 440
  end
  object qGetEmployees: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end
      item
        Name = 'AreaID'
        Size = -1
        Value = Null
      end
      item
        Name = 'CompanyID'
        Size = -1
        Value = Null
      end
      item
        Name = 'EposDevice'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT NULL AS Kiosk_SEC, '#39#39' AS RegisterName '
      'UNION   '
      'SELECT ID, FirstName+ '#39' '#39' + LastName FROM ac_User u'
      '         LEFT OUTER JOIN ac_UserSites us ON us.UserID = u.ID'
      '         LEFT OUTER JOIN ac_UserAreas ua ON ua.UserID = u.ID'
      '         LEFT OUTER JOIN ac_UserCompanies uc ON uc.UserID = u.ID'
      
        '         LEFT OUTER JOIN ThemeEposDevice ted ON ted.Kiosk_SEC = ' +
        'u.ID'
      
        'WHERE (us.SiteID = :SiteCode OR ua.AreaID = :AreaID OR uc.Compan' +
        'yID = :CompanyID)'
      
        'AND FirstName = '#39'Kiosk'#39' AND (EposDeviceID = :EposDevice OR ID NO' +
        'T IN (SELECT ISNULL(Kiosk_SEC, 0) FROM ThemeEposDevice))')
    Left = 436
    Top = 32
    object qGetEmployeesKiosk_SEC: TLargeintField
      FieldName = 'Kiosk_SEC'
    end
    object qGetEmployeesRegisterName: TStringField
      FieldName = 'RegisterName'
      ReadOnly = True
    end
  end
  object qSMOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeScrollingMessageOverride')
    Left = 576
    Top = 24
  end
  object qPFOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeReceiptFooterOverride'
      'where IsBillFooter = 0')
    Left = 576
    Top = 136
  end
  object dsSMOverride: TDataSource
    DataSet = qSMOverride
    Left = 576
    Top = 80
  end
  object dsPFOverride: TDataSource
    DataSet = qPFOverride
    Left = 576
    Top = 192
  end
  object qGetMoaDetails: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'EposDevice'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      'DECLARE @SiteCode int, @EposDeviceID int, @SalesAreaID int '
      
        'DECLARE @MOACount int, @SalesArea varchar(20), @MOAUser varchar(' +
        '41)'
      ''
      'SET @SiteCode = :SiteCode'
      'SET @EposDeviceID = :EposDevice'
      ''
      'SELECT @SalesAreaID = p.SalesAreaId'
      'FROM ac_Pos p '
      '  JOIN ThemeEposDevice d on d.POSCode = p.Id'
      'WHERE d.EPoSDeviceID = @EposDeviceID'
      'AND d.SiteCode = @SiteCode'
      ''
      ''
      'SELECT @MOAUser = FirstName+ '#39' '#39' + LastName '
      'FROM ac_User u '
      '  JOIN ThemeEposDevice ted ON ted.Kiosk_SEC = u.Id '
      'WHERE ted.SiteCode = @SiteCode'
      'AND ted.EPoSDeviceID = @EposDeviceID'
      ''
      ''
      'SELECT @SalesArea = Name'
      'FROM ac_SalesArea '
      'WHERE id = @SalesAreaID'
      ''
      'SELECT @MOACount = COUNT(*)'
      'FROM ThemeEposDevice d'
      '  JOIN ac_Pos p on p.Id = d.POSCode'
      'WHERE p.SalesAreaId = @SalesAreaID'
      'AND d.HardwareType = 10'
      ''
      
        'SELECT @SalesArea AS SalesArea, @MOACount AS MOACount, @MOAUser ' +
        'AS MOAUser'
      ''
      '')
    Left = 436
    Top = 80
    object qGetMoaDetailsSalesArea: TStringField
      FieldName = 'SalesArea'
      ReadOnly = True
    end
    object qGetMoaDetailsMOACount: TIntegerField
      FieldName = 'MOACount'
      ReadOnly = True
    end
    object qGetMoaDetailsMOAUser: TStringField
      FieldName = 'MOAUser'
      ReadOnly = True
      Size = 41
    end
  end
  object qBFOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeBillFooterOverride'
      '')
    Left = 576
    Top = 248
    object qBFOverrideName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qBFOverrideDescription: TStringField
      FieldName = 'Description'
      Size = 250
    end
    object qBFOverrideId: TIntegerField
      FieldName = 'Id'
    end
  end
  object dsBFOverride: TDataSource
    DataSet = qBFOverride
    Left = 576
    Top = 304
  end
  object qClockoutTicketFooterOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeClockOutTicketFooterOverride'
      'where Id <> 1')
    Left = 664
    Top = 24
    object qClockoutTicketFooterOverrideName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 40
    end
    object qClockoutTicketFooterOverrideDescription: TStringField
      DisplayWidth = 250
      FieldName = 'Description'
      Size = 250
    end
    object qClockoutTicketFooterOverrideID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
  end
  object dsClockoutTicketFooterOverride: TDataSource
    DataSet = qClockoutTicketFooterOverride
    Left = 664
    Top = 80
  end
  object qClockoutticketFooterTextOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from '
      '#ClockoutTicketFooterTextOverride'
      '--[zonalaccess].[00_#ClockoutTicketFooter]'
      ' order by LineType, LineNumber')
    Left = 680
    Top = 136
    object qClockoutticketFooterTextOverrideLineNumber: TSmallintField
      FieldName = 'LineNumber'
    end
    object qClockoutticketFooterTextOverrideLineType: TWordField
      FieldName = 'LineType'
    end
    object qClockoutticketFooterTextOverrideText: TWideStringField
      FieldName = 'Text'
      OnValidate = qClockoutticketFooterTextOverrideTextValidate
      Size = 40
    end
    object qClockoutticketFooterTextOverrideBold: TBooleanField
      FieldName = 'Bold'
    end
    object qClockoutticketFooterTextOverrideDoubleSize: TBooleanField
      FieldName = 'DoubleSize'
      OnValidate = qClockoutticketFooterTextOverrideDoubleSizeValidate
    end
    object qClockoutticketFooterTextOverrideLineNumberSeq: TIntegerField
      FieldName = 'LineNumberSeq'
    end
  end
  object dsClockoutTicketFooterTextOverride: TDataSource
    DataSet = qClockoutticketFooterTextOverride
    Left = 664
    Top = 192
  end
  object qOutletSuggestedTip: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ThemeOutletSuggestedTip'
      'WHERE SiteCode = :SiteCode')
    Left = 632
    Top = 376
    object qOutletSuggestedTipSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qOutletSuggestedTipTitle1: TStringField
      FieldName = 'Title1'
      Size = 40
    end
    object qOutletSuggestedTipTitle2: TStringField
      FieldName = 'Title2'
      Size = 40
    end
    object qOutletSuggestedTipTitle3: TStringField
      FieldName = 'Title3'
      Size = 40
    end
    object qOutletSuggestedTipText1: TStringField
      FieldName = 'Text1'
    end
    object qOutletSuggestedTipText2: TStringField
      FieldName = 'Text2'
    end
    object qOutletSuggestedTipText3: TStringField
      FieldName = 'Text3'
    end
    object qOutletSuggestedTipPercentage1: TBCDField
      FieldName = 'Percentage1'
    end
    object qOutletSuggestedTipPercentage2: TBCDField
      FieldName = 'Percentage2'
    end
    object qOutletSuggestedTipPercentage3: TBCDField
      FieldName = 'Percentage3'
    end
    object qOutletSuggestedTipLeadingLines: TIntegerField
      FieldName = 'LeadingLines'
    end
    object qOutletSuggestedTipTrailingLines: TIntegerField
      FieldName = 'TrailingLines'
    end
    object qOutletSuggestedTipShowForBills: TBooleanField
      FieldName = 'ShowForBills'
    end
    object qOutletSuggestedTipShowForSOAPPayments: TBooleanField
      FieldName = 'ShowForSOAPPayments'
    end
  end
  object dsOutletSuggestedTip: TDataSource
    DataSet = qOutletSuggestedTip
    Left = 712
    Top = 352
  end
  object adoqReasons: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'Select [Name] from ThemeReason')
    Left = 666
    Top = 248
  end
  object adoqCorrectionMethods: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select CorrectionMethodId, Name from Theme_CorrectionMethod')
    Left = 668
    Top = 300
  end
  object qBillFooterTextOverride: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    BeforeInsert = qBillFooterTextOverrideBeforeInsert
    BeforePost = qBillFooterTextOverrideBeforePost
    Parameters = <>
    SQL.Strings = (
      'select * from'
      '#BillFooterTextOverride'
      'order by LineNumber'
      '')
    Left = 776
    Top = 240
    object qBillFooterTextOverrideLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object qBillFooterTextOverrideText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnValidate = qBillFooterTextOverrideTextValidate
      Size = 40
    end
    object qBillFooterTextOverrideBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object qBillFooterTextOverrideDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = qBillFooterTextOverrideDoubleWidthValidate
    end
    object qBillFooterTextOverrideDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object qBillFooterTextOverrideAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 6
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object qBillFooterTextOverrideAlignment: TSmallintField
      DisplayWidth = 11
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object dsBillFooterTextOverride: TDataSource
    DataSet = qBillFooterTextOverride
    Left = 776
    Top = 288
  end
  object qBillFooterAlignmentLookup: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    BeforeInsert = qBillFooterTextOverrideBeforeInsert
    BeforePost = qBillFooterTextOverrideBeforePost
    Parameters = <>
    SQL.Strings = (
      'SELECT a.Id, a.Position'
      'FROM'
      '  ('
      
        '    SELECT CAST(1 AS smallint) AS Id, CASE dbo.ac_fnIsLocale('#39'UK' +
        #39') WHEN 1 THEN '#39'Centre'#39' ELSE '#39'Center'#39' END AS Position'
      '    UNION'
      '    SELECT CAST(0 AS smallint) AS Id, '#39'Left'#39' AS Position'
      '    UNION'
      #9'SELECT CAST(2 AS smallint) AS Id, '#39'Right'#39' AS Position'
      '  ) a'
      'ORDER BY a.Id'
      '')
    Left = 872
    Top = 256
  end
  object qOutletBillFooter: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM'
      '#OutletBillFooterText'
      ''
      ''
      '')
    Left = 856
    Top = 168
    object qOutletBillFooterLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object qOutletBillFooterText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnSetText = qOutletBillFooterTextSetText
      OnValidate = qOutletBillFooterTextValidate
      Size = 40
    end
    object qOutletBillFooterAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object qOutletBillFooterBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object qOutletBillFooterDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = qOutletBillFooterDoubleWidthValidate
    end
    object qOutletBillFooterDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object qOutletBillFooterAlignment: TSmallintField
      DisplayWidth = 11
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object qLoadOutletBillFooter: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'set nocount on'
      ''
      'DECLARE @SiteCode smallint'
      ''
      'SET @SiteCode = :siteCode'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#OutletBillFooterText'#39'))'
      '  DROP TABLE #OutletBillFooterText'
      ''
      'create table #OutletBillFooterText'
      '('
      '  [LineNumber] smallint,'
      '  [Alignment] smallint,'
      '  [Text] nvarchar(40),'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      'declare @LineCount integer'
      'declare @Generator table (Line integer)'
      'set @LineCount = 15 '
      ' '
      'insert @Generator values(1) '
      'while @@ROWCOUNT > 0 '
      'begin '
      '  insert @Generator'
      '  select g.Line + sub.MaxRowNum from @Generator g'
      '  cross join '
      '  (select MAX(Line) as MaxRowNum from @Generator) sub'
      '  where'
      '    g.line <= @LineCount - sub.MaxRowNum'
      'end'
      ''
      
        'insert #OutletBillFooterText (LineNumber, Alignment, [Text], Bol' +
        'd, DoubleWidth, DoubleHeight)'
      'select g.Line, 1, '#39#39', 0, 0, 0'
      'from @Generator g'
      ' '
      'update #OutletBillFooterText'
      '  set'
      '    Alignment = a.Alignment,'
      '    Text = a.Text,'
      '    Bold = a.Bold,'
      '    DoubleWidth = a.DoubleWidth,'
      '    DoubleHeight = a.DoubleHeight'
      'from'
      
        '  (select LineNumber, Alignment, [Text], Bold, DoubleWidth, Doub' +
        'leHeight'
      '   from ThemeOutletBillFooterText'
      '   where SiteCode = @SiteCode) a'
      'where #OutletBillFooterText.LineNumber = a.LineNumber'
      ''
      'set nocount off'
      '')
    Left = 856
    Top = 56
    object SmallintField3: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object WideStringField2: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      Size = 40
    end
    object BooleanField4: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object BooleanField5: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = qBillFooterTextOverrideDoubleWidthValidate
    end
    object BooleanField6: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object StringField4: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 6
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object SmallintField4: TSmallintField
      DisplayWidth = 11
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object qSaveOutletBillFooterData: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'set nocount on'
      ''
      'DECLARE @SiteCode smallint'
      ''
      'SET @SiteCode = :siteCode'
      ''
      'begin try'
      '  begin tran'
      '    delete ThemeOutletBillFooterText where SiteCode = @SiteCode'
      ''
      '    insert ThemeOutletBillFooterText'
      
        '    select @SiteCode, LineNumber, Alignment, [Text], Bold, Doubl' +
        'eWidth, DoubleHeight'
      '    from #OutletBillFooterText'
      '    where (isnull([Text],'#39#39') <> '#39#39')'
      '  commit tran'
      'end try'
      'begin catch'
      '  if @@TRANCOUNT > 0 rollback transaction'
      
        '  exec ac_spRethrowError -- Re raise the error so that it gets b' +
        'ack to the Delphi runtime.'
      'end catch'
      ''
      'drop table #OutletBillFooterText'
      ''
      'set nocount off'
      ''
      '')
    Left = 856
    Top = 112
    object SmallintField5: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object WideStringField3: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      Size = 40
    end
    object BooleanField7: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object BooleanField8: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = qBillFooterTextOverrideDoubleWidthValidate
    end
    object BooleanField9: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object StringField5: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 6
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object SmallintField6: TSmallintField
      DisplayWidth = 11
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object dsOutletBillFooter: TDataSource
    DataSet = qOutletBillFooter
    Left = 912
    Top = 208
  end
  object qGetOutletBillFooterText: TADOQuery
    Connection = AztecConn
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 10
        Value = 1
      end>
    SQL.Strings = (
      'declare @OutletBillFooterText  table '
      '('
      '  [LineNumber] smallint,'
      '  [Alignment] smallint,'
      '  [Text] nvarchar(40),'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      'declare @LineCount integer'
      'declare @Generator table (Line integer)'
      'set @LineCount = 15 '
      ' '
      'insert @Generator values(1) '
      'while @@ROWCOUNT > 0 '
      'begin '
      '  insert @Generator'
      '  select g.Line + sub.MaxRowNum from @Generator g'
      '  cross join '
      '  (select MAX(Line) as MaxRowNum from @Generator) sub'
      '  where'
      '    g.line <= @LineCount - sub.MaxRowNum'
      'end'
      ''
      
        'insert @OutletBillFooterText (LineNumber, Alignment, [Text], Bol' +
        'd, DoubleWidth, DoubleHeight)'
      'select g.Line, 1, '#39#39', 0, 0, 0'
      'from @Generator g'
      ' '
      'update @OutletBillFooterText'
      '  set'
      '    Alignment = a.Alignment,'
      '    Text = a.Text,'
      '    Bold = a.Bold,'
      '    DoubleWidth = a.DoubleWidth,'
      '    DoubleHeight = a.DoubleHeight'
      'from'
      
        '  (select LineNumber, Alignment, [Text], Bold, DoubleWidth, Doub' +
        'leHeight'
      '   from ThemeOutletBillFooterText'
      '   where SiteCode = :SiteCode) a'
      'join @OutletBillFooterText b on b.LineNumber = a.LineNumber'
      ''
      'select * from @OutletBillFooterText')
    Left = 872
    Top = 304
  end
  object dsSurveyCodeSupplier: TDataSource
    DataSet = qSurveyCodeSupplier
    Left = 776
    Top = 96
  end
  object qSurveyCodeSupplier: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '--Due to the till team using an enumeration that has elements of' +
        ' different scope, i.e.'
      
        '--0 = None, 1 & 2 = site scope, 3 = per promotional footer scope' +
        '!?'
      'select *'
      'from ThemeAppendSurveyNumberTypeLookup'
      'where ID <> 3 ')
    Left = 776
    Top = 40
    object qSurveyCodeSupplierId: TIntegerField
      FieldName = 'Id'
    end
    object qSurveyCodeSupplierValue: TStringField
      FieldName = 'Value'
      Size = 50
    end
    object qSurveyCodeSupplierMaximumCodeLength: TIntegerField
      FieldName = 'MaximumCodeLength'
    end
    object qSurveyCodeSupplierAztecName: TStringField
      FieldName = 'AztecName'
      Size = 50
    end
  end
  object qCLMDiscount: TADOQuery
    Connection = AztecConn
    Parameters = <
      item
        Name = 'currDiscountId'
        DataType = ftLargeint
        Size = 4
        Value = '0'
      end
      item
        Name = 'appDiscountId'
        DataType = ftLargeint
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT CAST(CASE COUNT(*) WHEN 0 THEN 0 ELSE 1 END AS bit) AS Cl' +
        'mUsed'
      'FROM ac_ClmSiteDiscountSpecific'
      'WHERE '
      '  ExternalAmountDiscountId = :currDiscountId  or '
      '  ApportionmentDiscountId = :appDiscountId'
      '')
    Left = 296
    Top = 480
  end
  object qDiscountType: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'SELECT [Id], [value]'
      'FROM ThemeDiscountTypeLookup')
    Left = 344
    Top = 408
    object qDiscountTypeId: TIntegerField
      FieldName = 'Id'
    end
    object qDiscountTypevalue: TStringField
      FieldName = 'value'
      Size = 30
    end
  end
  object adoqSaveButtonSecurity: TADOQuery
    Connection = AztecConn
    Parameters = <
      item
        Name = 'TotalRoles'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'BEGIN TRY'
      '  BEGIN TRAN'
      ''
      
        '  DECLARE @CandidateSecurity Table (SecurityTypeId int, TaskId b' +
        'igint);'
      
        '  DECLARE @SecurityTypeId smallint, @TaskId bigint, @NewTask big' +
        'int, @TotalRoles smallint;'
      '  DECLARE @ButtonSecurityID int;'
      #9'DECLARE @RoleCount int;'
      '  SET @TotalRoles = :TotalRoles;'
      ''
      '  --1. Are there any tasks that are already applicable?'
      '  INSERT @CandidateSecurity'
      '  SELECT bstl.Id, sub.Taskid'
      '  FROM ButtonSecurityTypeLookup bstl'
      '  LEFT JOIN (SELECT tstr.SecurityTypeId, tt.TaskID FROM'
      '             Themetask tt'
      '             JOIN #SecurityTypeRoles tstr'
      '             ON tt.RoleId = tstr.RoleId'
      '             GROUP BY tt.TaskID, tstr.SecurityTypeId'
      '             HAVING COUNT(tstr.RoleId) = (SELECT COUNT(RoleId)'
      
        '                                          FROM #SecurityTypeRole' +
        's'
      
        '                                          WHERE SecurityTypeId =' +
        ' tstr.SecurityTypeId)'
      '                AND COUNT(tt.RoleId) = (SELECT COUNT(RoleID)'
      '                                        FROM ThemeTask'
      
        '                                        WHERE TaskId = tt.TaskID' +
        ')) sub'
      '  ON sub.SecurityTypeId = bstl.Id;'
      ''
      
        '  --Any security type with a full compliment of roles should be ' +
        'regarded as using the guard value of 0'
      #9'UPDATE cs'#9'SET TaskId = 0'
      #9'FROM  @CandidateSecurity cs'
      #9'JOIN (SELECT SecurityTypeId'
      #9#9#9#9'FROM #SecurityTypeRoles'
      #9#9#9#9'GROUP BY SecurityTypeId'
      #9#9#9'  HAVING COUNT(RoleId) = @TotalRoles) sub'
      #9'ON cs.SecurityTypeId = sub.SecurityTypeId;'
      ''
      
        '  --Any security types defined to have no roles (TaskId = -1) sh' +
        'ould be regarded as having the guard value -1'
      #9'UPDATE cs'#9'SET TaskId = -1'
      #9'FROM  @CandidateSecurity cs'
      #9'JOIN (SELECT SecurityTypeId'
      #9#9#9#9'FROM #SecurityTypeRoles'
      #9#9#9#9'GROUP BY SecurityTypeId'
      #9#9#9'  HAVING MAX(RoleId) = -1) sub'
      #9'ON cs.SecurityTypeId = sub.SecurityTypeId'
      ''
      
        '  --Delete any other candidates that have a NULL TaskId if they ' +
        'aren'#39't in our input recordset'
      #9'--i.e. delete spurious non-matches'
      ' '#9'DELETE cs'
      #9'FROM @CandidateSecurity cs'
      
        #9'WHERE TaskID IS NULL AND cs.SecurityTypeId NOT IN (SELECT Secur' +
        'ityTypeId FROM #SecurityTypeRoles)'
      ''
      '  DECLARE Security_Cursor CURSOR FORWARD_ONLY'
      '  FOR SELECT SecurityTypeId, TaskId FROM @CandidateSecurity;'
      ''
      '  OPEN Security_Cursor;'
      '  FETCH NEXT FROM Security_Cursor INTO @SecurityTypeId, @TaskId;'
      ''
      '  --2. Generate new tasks as necessary'
      '  WHILE @@Fetch_Status = 0'
      '  BEGIN'
      
        #9#9'select @RoleCount =  COUNT(RoleId) FROM #SecurityTypeRoles whe' +
        're SecurityTypeId = @SecurityTypeId'
      #9#9
      
        #9#9'--Generate a new task for security types that have no task as ' +
        'yet, but only if'
      '    --the security type is not '#39'access all areas'#39
      
        '    IF (@TaskId IS NULL) and @RoleCount < @TotalRoles and @RoleC' +
        'ount > 0'
      '    BEGIN'
      
        '      EXEC getnextuniqueid  '#39'ThemeTask_repl'#39', '#39'TaskID'#39', 1, 21474' +
        '83647, @NextID=@NewTask OUTPUT'
      '      INSERT ThemeTask (TaskId, RoleId)'
      '      SELECT @NewTask, RoleId'
      '      FROM #SecurityTypeRoles str'
      '      WHERE str.SecurityTypeId = @SecurityTypeId;'
      ''
      
        '      UPDATE @CandidateSecurity SET TaskId = @NewTask WHERE Secu' +
        'rityTypeId = @SecurityTypeId;'
      '    END'
      #9#9'ELSE IF (@TaskId IS NULL) '
      
        #9#9#9'UPDATE @CandidateSecurity SET TaskId = -1 WHERE SecurityTypeI' +
        'd = @SecurityTypeId;'
      ''
      '    FETCH NEXT FROM Security_Cursor'
      '    INTO @SecurityTypeId, @TaskId;'
      '  END;'
      ''
      '  CLOSE security_cursor;'
      '  DEALLOCATE security_cursor;'
      ''
      '  --3. Is there a pre-existing ButtonSecurity entry we can use?'
      '  DECLARE @SecurityId int;'
      ''
      '  SELECT @SecurityID = bs.Id FROM'
      '  ButtonSecurity bs'
      '  LEFT JOIN @CandidateSecurity cs'
      
        '  ON bs.SecurityTypeId = cs.SecurityTypeId and bs.TaskId = cs.Ta' +
        'skId'
      '  GROUP BY bs.id'
      
        '  HAVING COUNT(cs.SecurityTypeId) = (SELECT COUNT(SecurityTypeId' +
        ')'
      '                              FROM @CandidateSecurity)'
      '    AND COUNT(bs.SecurityTypeId) = (SELECT COUNT(SecurityTypeId)'
      '                              FROM @CandidateSecurity)'
      ''
      '  IF @SecurityId IS NULL'
      '  BEGIN'
      '    DECLARE @NewId int;'
      
        '    EXEC ac_spGetTableIdNextValue '#39'ButtonSecurity_Repl'#39', @Securi' +
        'tyId output;'
      ''
      '    INSERT ButtonSecurity'
      '    SELECT @SecurityId, SecurityTypeId, TaskId'
      '    FROM @CandidateSecurity;'
      '  END;'
      ''
      '  SELECT @SecurityId AS Output;'
      '  COMMIT TRAN;'
      'END TRY'
      'BEGIN CATCH'
      '  ROLLBACK TRAN'
      '  SELECT NULL AS Output;'
      'END CATCH;'
      ''
      '')
    Left = 716
    Top = 424
  end
  object adoqFoHRoles: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select * from #SecurityTypeRoles')
    Left = 636
    Top = 448
    object adoqFoHRolesSecurityTypeId: TSmallintField
      FieldName = 'SecurityTypeId'
    end
    object adoqFoHRolesRoleId: TIntegerField
      FieldName = 'RoleId'
    end
  end
  object dsQrCodeHeaderText: TDataSource
    DataSet = TmpQrCodeHeaderText
    Left = 760
    Top = 480
  end
  object dsQrCodeFooterText: TDataSource
    DataSet = TmpQrCodeFooterText
    Left = 760
    Top = 536
  end
  object qCreateQrCodeTempTables: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'set nocount on'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeHeaderText'#39'))'
      '  DROP TABLE #QrCodeHeaderText'
      ''
      'create table #QrCodeHeaderText'
      '('
      '  [Position] smallint,  '
      '  [LineNumber] smallint,'
      '  [Text] nvarchar(40),'
      '  [Alignment] smallint,'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      
        'insert #QrCodeHeaderText(Position, LineNumber, Alignment, [Text]' +
        ', Bold, DoubleWidth, DoubleHeight)'
      
        'select TOP 25 Position, LineNumber, Alignment, [Text], Bold, Dou' +
        'bleWidth, DoubleHeight'
      'from ac_ClmQrCodeText'
      'WHERE Position = 1 AND Id = 0'
      'order by LineNumber'
      ' '
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeFooterText'#39'))'
      '  DROP TABLE #QrCodeFooterText'
      ''
      'create table #QrCodeFooterText'
      '('
      '  [Position] smallint,  '
      '  [LineNumber] smallint,'
      '  [Text] nvarchar(40),'
      '  [Alignment] smallint,'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      
        'insert #QrCodeFooterText(Position, LineNumber, Alignment, [Text]' +
        ', Bold, DoubleWidth, DoubleHeight)'
      
        'select TOP 25 Position, LineNumber, Alignment, [Text], Bold, Dou' +
        'bleWidth, DoubleHeight'
      'from ac_ClmQrCodeText'
      'WHERE Position = 2 AND Id = 0'
      'order by LineNumber'
      ''
      ' '
      'set nocount off')
    Left = 864
    Top = 440
  end
  object TmpQrCodeHeaderText: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    MaxRecords = 25
    BeforePost = TmpQrCodeFooterTextBeforePost
    TableName = '#QrCodeHeaderText'
    Left = 872
    Top = 488
    object TmpQrCodeHeaderTextLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object TmpQrCodeHeaderTextText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnValidate = TmpQrCodeHeaderTextTextValidate
      Size = 40
    end
    object TmpQrCodeHeaderTextAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object TmpQrCodeHeaderTextBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object TmpQrCodeHeaderTextDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = TmpQrCodeHeaderTextDoubleWidthValidate
    end
    object TmpQrCodeHeaderTextDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object TmpQrCodeHeaderTextAlignment: TSmallintField
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object qSaveQrCodeText: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      '-- SAVE qr code header'
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeHeaderText'#39'))'
      'BEGIN'
      #9'DELETE FROM ac_ClmQrCodeText'
      #9'WHERE id = 0'
      #9'AND Position = 1'
      ''
      
        #9'INSERT ac_ClmQrCodeText (Id, Position, LineNumber, Alignment, [' +
        'Text], Bold, DoubleWidth, DoubleHeight)'
      
        #9'Select 0, Position, LineNumber, Alignment, [Text], Bold, Double' +
        'Width, DoubleHeight '
      #9'from #QrCodeHeaderText'
      'END'
      ''
      '-- SAVE qr code footer'
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeFooterText'#39'))'
      'BEGIN'
      #9'DELETE FROM ac_ClmQrCodeText'
      #9'WHERE id = 0'
      #9'AND Position = 2'
      ''
      
        #9'INSERT ac_ClmQrCodeText (Id, Position, LineNumber, Alignment, [' +
        'Text], Bold, DoubleWidth, DoubleHeight)'
      
        #9'Select 0, Position, LineNumber, Alignment, [Text], Bold, Double' +
        'Width, DoubleHeight '
      #9'from #QrCodeFooterText'
      'END')
    Left = 864
    Top = 392
  end
  object TmpQrCodeFooterText: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    MaxRecords = 25
    BeforePost = TmpQrCodeFooterTextBeforePost
    TableName = '#QrCodeFooterText'
    Left = 872
    Top = 544
    object SmallintField1: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object TmpQrCodeFooterTextText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnValidate = TmpQrCodeFooterTextTextValidate
      Size = 40
    end
    object StringField3: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object BooleanField1: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object TmpQrCodeFooterTextDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = TmpQrCodeFooterTextDoubleWidthValidate
    end
    object BooleanField3: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object SmallintField2: TSmallintField
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object qSaveQrCodeOnReceiptText: TADOQuery
    Connection = AztecConn
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '-- SAVE qr code footer'
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeOnReceiptFooterText'#39'))'
      'BEGIN'
      '                DECLARE @SiteCode integer'
      '                SET @SiteCode = :SiteCode'
      ''
      #9'DELETE FROM ac_QrCodeOnReceiptText'
      #9'WHERE id = 0'
      #9'AND SiteCode = @SiteCode '
      #9'AND Position = 2'
      ''
      
        #9'INSERT ac_QrCodeOnReceiptText (Id, SiteCode, Position, LineNumb' +
        'er, Alignment, [Text], Bold, DoubleWidth, DoubleHeight)'
      
        #9'Select 0, @SiteCode , Position, LineNumber, Alignment, [Text], ' +
        'Bold, DoubleWidth, DoubleHeight '
      #9'from #QrCodeOnReceiptFooterText'
      'END'
      '')
    Left = 1088
    Top = 36
  end
  object qCreateQrCodeOnReceiptTempTables: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'set nocount on'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#QrCodeOnReceiptFooterText'#39'))'
      '  DROP TABLE #QrCodeOnReceiptFooterText'
      ''
      'create table #QrCodeOnReceiptFooterText'
      '('
      '  [Position] smallint,  '
      '  [LineNumber] smallint,'
      '  [Text] nvarchar(40),'
      '  [Alignment] smallint,'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      'set nocount off'
      '')
    Left = 1088
    Top = 92
  end
  object TmpQrCodeOnReceiptFooterText: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    MaxRecords = 5
    BeforePost = TmpQrCodeOnReceiptHeaderTextBeforePost
    TableName = '#QrCodeOnReceiptFooterText'
    Left = 1088
    Top = 180
    object TmpQrCodeOnReceiptFooterTextLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object TmpQrCodeOnReceiptFooterTextText: TWideStringField
      FieldName = 'Text'
      OnValidate = TmpQrCodeOnReceiptFooterTextTextValidate
      Size = 40
    end
    object TmpQrCodeOnReceiptFooterTextAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object TmpQrCodeOnReceiptFooterTextBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object TmpQrCodeOnReceiptFooterTextDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = TmpQrCodeOnReceiptFooterTextDoubleWidthValidate
    end
    object TmpQrCodeOnReceiptFooterTextDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object TmpQrCodeOnReceiptFooterTextAlignment: TSmallintField
      DisplayWidth = 10
      FieldName = 'Alignment'
      Visible = False
    end
    object TmpQrCodeOnReceiptFooterTextPosition: TSmallintField
      FieldName = 'Position'
      Visible = False
    end
  end
  object dsQrCodeOnReceiptFooterText: TDataSource
    DataSet = TmpQrCodeOnReceiptFooterText
    Left = 1088
    Top = 228
  end
  object qLoadQrCodeReceiptText: TADOQuery
    Connection = AztecConn
    Parameters = <
      item
        Name = 'SiteCode'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @SiteCode integer'
      'SET @SiteCode = :SiteCode'
      ''
      
        'IF (select COUNT(*) FROM ac_QrCodeOnReceiptText WHERE Position =' +
        ' 2 AND SiteCode = @SiteCode) = 0'
      'begin'
      #9'SET @SiteCode = -1'
      'end'
      ''
      
        'insert #QrCodeOnReceiptFooterText(Position, LineNumber, Alignmen' +
        't, [Text], Bold, DoubleWidth, DoubleHeight)'
      
        'select TOP 4 Position, LineNumber, Alignment, [Text], Bold, Doub' +
        'leWidth, DoubleHeight'
      'from ac_QrCodeOnReceiptText'
      'WHERE Position = 2'
      'AND SiteCode = @SiteCode'
      'order by LineNumber')
    Left = 1096
    Top = 144
  end
  object qTerminalDynamicFields: TADOQuery
    Connection = AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from TerminalDynamicFields where Visible = 1')
    Left = 1080
    Top = 316
    object qTerminalDynamicFieldsId: TIntegerField
      FieldName = 'Id'
    end
    object qTerminalDynamicFieldsDisplayName: TStringField
      FieldName = 'DisplayName'
      Size = 25
    end
    object qTerminalDynamicFieldsAztecPlaceHolderText: TStringField
      FieldName = 'AztecPlaceHolderText'
      Size = 25
    end
    object qTerminalDynamicFieldsEposPlaceHolderText: TStringField
      FieldName = 'EposPlaceHolderText'
      Size = 25
    end
    object qTerminalDynamicFieldsReplacedBy: TIntegerField
      FieldName = 'ReplacedBy'
    end
    object qTerminalDynamicFieldsVisible: TBooleanField
      FieldName = 'Visible'
    end
  end
  object dsTerminalDynamicFields: TDataSource
    DataSet = qTerminalDynamicFields
    Left = 1080
    Top = 364
  end
  object TmpBarcodeHeaderText: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    MaxRecords = 25
    BeforePost = TmpBarcodeHeaderTextBeforePost
    TableName = '#BarcodeHeaderText'
    Left = 992
    Top = 488
    object TmpBarcodeHeaderTextLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object TmpBarcodeHeaderTextText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnValidate = TmpBarcodeHeaderTextTextValidate
      Size = 40
    end
    object TmpBarcodeHeaderTextAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object TmpBarcodeHeaderTextBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object TmpBarcodeHeaderTextDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = TmpBarcodeHeaderTextDoubleWidthValidate
    end
    object TmpBarcodeHeaderTextDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object TmpBarcodeHeaderTextAlignment: TSmallintField
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object TmpBarcodeFooterText: TADOTable
    Connection = AztecConn
    CursorType = ctStatic
    MaxRecords = 25
    BeforePost = TmpBarcodeFooterTextBeforePost
    TableName = '#BarcodeFooterText'
    Left = 992
    Top = 544
    object TmpBarcodeFooterTextLineNumber: TSmallintField
      DisplayLabel = 'Line~No.'
      DisplayWidth = 3
      FieldName = 'LineNumber'
    end
    object TmpBarcodeFooterTextText: TWideStringField
      DisplayWidth = 59
      FieldName = 'Text'
      OnValidate = TmpBarcodeFooterTextTextValidate
      Size = 40
    end
    object TmpBarcodeFooterTextAlignmentName: TStringField
      DisplayLabel = 'Alignment'
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'AlignmentName'
      LookupDataSet = qBillFooterAlignmentLookup
      LookupKeyFields = 'Id'
      LookupResultField = 'Position'
      KeyFields = 'Alignment'
      Size = 6
      Lookup = True
    end
    object TmpBarcodeFooterTextBold: TBooleanField
      DisplayWidth = 5
      FieldName = 'Bold'
    end
    object TmpBarcodeFooterTextDoubleWidth: TBooleanField
      DisplayLabel = 'Double-~Width'
      DisplayWidth = 7
      FieldName = 'DoubleWidth'
      OnValidate = TmpBarcodeFooterTextDoubleWidthValidate
    end
    object TmpBarcodeFooterTextDoubleHeight: TBooleanField
      DisplayLabel = 'Double-~Height'
      DisplayWidth = 7
      FieldName = 'DoubleHeight'
    end
    object TmpBarcodeFooterTextAlignment: TSmallintField
      FieldName = 'Alignment'
      Visible = False
    end
  end
  object dsBarcodeHeaderText: TDataSource
    DataSet = TmpBarcodeHeaderText
    Left = 1112
    Top = 488
  end
  object dsBarcodeFooterText: TDataSource
    DataSet = TmpBarcodeFooterText
    Left = 1112
    Top = 544
  end
  object qCreateBarcodeTempTables: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'set nocount on'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#BarcodeHeaderText'#39'))'
      '  DROP TABLE #BarcodeHeaderText'
      ''
      'create table #BarcodeHeaderText'
      '('
      '  [Position] smallint,  '
      '  [LineNumber] smallint,'
      '  [Text] nvarchar(40),'
      '  [Alignment] smallint,'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      
        'insert #BarcodeHeaderText(Position, LineNumber, Alignment, [Text' +
        '], Bold, DoubleWidth, DoubleHeight)'
      
        'select TOP 25 Position, LineNumber, Alignment, [Text], Bold, Dou' +
        'bleWidth, DoubleHeight'
      'from ac_ClmQrCodeText'
      'WHERE Position = 1 AND Id = 1'
      'order by LineNumber'
      ' '
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#BarcodeFooterText'#39'))'
      '  DROP TABLE #BarcodeFooterText'
      ''
      'create table #BarcodeFooterText'
      '('
      '  [Position] smallint,  '
      '  [LineNumber] smallint,'
      '  [Text] nvarchar(40),'
      '  [Alignment] smallint,'
      '  [Bold] bit DEFAULT 0,'
      '  [DoubleWidth] bit DEFAULT 0,'
      '  [DoubleHeight] bit DEFAULT (0)'
      ')'
      ''
      
        'insert #BarcodeFooterText(Position, LineNumber, Alignment, [Text' +
        '], Bold, DoubleWidth, DoubleHeight)'
      
        'select TOP 25 Position, LineNumber, Alignment, [Text], Bold, Dou' +
        'bleWidth, DoubleHeight'
      'from ac_ClmQrCodeText'
      'WHERE Position = 2 AND Id = 1'
      'order by LineNumber'
      ''
      ''
      ' '
      'set nocount off')
    Left = 1032
    Top = 448
  end
  object qSaveBarcodeText: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      '-- SAVE bar code header'
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#BarcodeHeaderText'#39'))'
      'BEGIN'
      #9'DELETE FROM ac_ClmQrCodeText'
      #9'WHERE id = 1'
      #9'AND Position = 1'
      ''
      
        #9'INSERT ac_ClmQrCodeText (Id, Position, LineNumber, Alignment, [' +
        'Text], Bold, DoubleWidth, DoubleHeight)'
      
        #9'Select 1, Position, LineNumber, Alignment, [Text], Bold, Double' +
        'Width, DoubleHeight '
      #9'from #BarcodeHeaderText'
      'END'
      ''
      '-- SAVE bar code footer'
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#BarcodeFooterText'#39'))'
      'BEGIN'
      #9'DELETE FROM ac_ClmQrCodeText'
      #9'WHERE id = 1'
      #9'AND Position = 2'
      ''
      
        #9'INSERT ac_ClmQrCodeText (Id, Position, LineNumber, Alignment, [' +
        'Text], Bold, DoubleWidth, DoubleHeight)'
      
        #9'Select 1, Position, LineNumber, Alignment, [Text], Bold, Double' +
        'Width, DoubleHeight '
      #9'from #BarcodeFooterText'
      'END')
    Left = 976
    Top = 400
  end
end
