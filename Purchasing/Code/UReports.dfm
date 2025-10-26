object fReports: TfReports
  Left = 801
  Top = 279
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Invoice Reports'
  ClientHeight = 518
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object GridItems: TwwDBGrid
    Left = 0
    Top = 118
    Width = 752
    Height = 285
    Selected.Strings = (
      'Site Name'#9'20'#9'Site Name'
      'SubCat'#9'19'#9'Sub Category'
      'EntityName'#9'15'#9'Item Name'
      'InvoiceNo'#9'15'#9'InvoiceNo'
      'InvoiceDate'#9'9'#9'Date'
      'Quantity'#9'7'#9'Quantity'
      'Cost'#9'9'#9'Cost'
      'TotalQty'#9'7'#9'Total Qty'
      'TotalCost'#9'11'#9'Total Cost')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = itemsds
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    Visible = False
  end
  object GridVendors: TwwDBGrid
    Left = 0
    Top = 118
    Width = 752
    Height = 285
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = VendRepDS
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 403
    Width = 752
    Height = 115
    Align = alBottom
    TabOrder = 3
    TabStop = True
    object Label9: TLabel
      Left = 6
      Top = 1
      Width = 93
      Height = 16
      Caption = 'Totals for Period'
    end
    object Label11: TLabel
      Left = 16
      Top = 98
      Width = 92
      Height = 14
      Caption = '= Accepted Invoice'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label12: TLabel
      Left = 6
      Top = 96
      Width = 7
      Height = 18
      Caption = '^'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object BitBtnClose: TBitBtn
      Left = 639
      Top = 79
      Width = 105
      Height = 33
      Caption = 'Close'
      TabOrder = 1
      OnClick = BitBtnCloseClick
      Kind = bkCancel
    end
    object GridTotals: TwwDBGrid
      Left = 4
      Top = 15
      Width = 741
      Height = 58
      TabStop = False
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      ShowVertScrollBar = False
      DataSource = totalsDS
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
    end
    object BitBtnPrint: TBitBtn
      Left = 524
      Top = 79
      Width = 105
      Height = 33
      Caption = '&Print'
      Enabled = False
      TabOrder = 0
      OnClick = BitBtnPrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 752
    Height = 118
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 0
    TabStop = True
    object Label1: TLabel
      Left = 313
      Top = 10
      Width = 100
      Height = 16
      Caption = 'Period Start Date'
    end
    object Label2: TLabel
      Left = 313
      Top = 34
      Width = 95
      Height = 16
      Caption = 'Period End Date'
    end
    object Label3: TLabel
      Left = 8
      Top = 11
      Width = 118
      Height = 32
      Caption = 'Select Report and period to view :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel
      Left = 557
      Top = 9
      Width = 48
      Height = 16
      Caption = 'Division:'
      Visible = False
    end
    object Label10: TLabel
      Left = 525
      Top = 9
      Width = 44
      Height = 16
      Caption = 'Vendor:'
    end
    object Panel4: TPanel
      Left = 32
      Top = 55
      Width = 569
      Height = 59
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 8
      Visible = False
      object SpeedButtonSubcateg: TSpeedButton
        Left = 205
        Top = 11
        Width = 104
        Height = 33
        GroupIndex = 2
        Down = True
        Caption = 'Sub-Categ (F5)'
        OnClick = SpeedButtonSubcategClick
      end
      object SpeedButtonItem: TSpeedButton
        Left = 309
        Top = 11
        Width = 104
        Height = 33
        GroupIndex = 2
        Caption = 'Item (F6)'
        OnClick = SpeedButtonItemClick
      end
      object Label6: TLabel
        Left = 438
        Top = 5
        Width = 38
        Height = 16
        Caption = 'Label6'
      end
      object Label7: TLabel
        Left = 8
        Top = 4
        Width = 86
        Height = 48
        Caption = 'Choose field to order and search by'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object SpeedButtonSite: TSpeedButton
        Left = 101
        Top = 12
        Width = 104
        Height = 33
        GroupIndex = 2
        Caption = 'Site (F4)'
        OnClick = SpeedButtonSiteClick
      end
      object Search2: TwwIncrementalSearch
        Left = 437
        Top = 21
        Width = 121
        Height = 24
        DataSource = itemsds
        TabOrder = 0
      end
    end
    object combo2: TwwDBComboBox
      Left = 576
      Top = 6
      Width = 169
      Height = 24
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DropDownCount = 8
      ItemHeight = 0
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
      OnKeyDown = combo2KeyDown
    end
    object RadioButtonVendor: TRadioButton
      Left = 136
      Top = 10
      Width = 141
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Vendor Invoices'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonVendorClick
    end
    object RadioButtonItem: TRadioButton
      Left = 136
      Top = 31
      Width = 141
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Item Invoices'
      TabOrder = 1
      TabStop = True
      OnClick = RadioButtonItemClick
    end
    object Combo1: TwwDBComboBox
      Left = 621
      Top = 6
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DropDownCount = 8
      ItemHeight = 0
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      Visible = False
      OnKeyDown = Combo1KeyDown
    end
    object BitBtnView: TBitBtn
      Left = 640
      Top = 64
      Width = 105
      Height = 33
      Caption = '&View'
      TabOrder = 4
      OnClick = BitBtnViewClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        033333777777777773333330777777703333333773F333773333333330888033
        33333FFFF7FFF7FFFFFF0000000000000003777777777777777F0FFFFFFFFFF9
        FF037F3333333337337F0F78888888887F037F33FFFFFFFFF37F0F7000000000
        8F037F3777777777F37F0F70AAAAAAA08F037F37F3333337F37F0F70ADDDDDA0
        8F037F37F3333337F37F0F70A99A99A08F037F37F3333337F37F0F70A99A99A0
        8F037F37F3333337F37F0F70AAAAAAA08F037F37FFFFFFF7F37F0F7000000000
        8F037F3777777777337F0F77777777777F037F3333333333337F0FFFFFFFFFFF
        FF037FFFFFFFFFFFFF7F00000000000000037777777777777773}
      NumGlyphs = 2
    end
    object StPick: TDateTimePicker
      Left = 423
      Top = 8
      Width = 89
      Height = 21
      CalAlignment = dtaLeft
      Date = 35748
      Time = 35748
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 6
      OnKeyDown = StPickKeyDown
    end
    object EndPick: TDateTimePicker
      Left = 423
      Top = 32
      Width = 89
      Height = 20
      CalAlignment = dtaLeft
      Date = 35748
      Time = 35748
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 7
      OnKeyDown = EndPickKeyDown
    end
    object Panel3: TPanel
      Left = 22
      Top = 55
      Width = 611
      Height = 59
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 5
      Visible = False
      object Label5: TLabel
        Left = 478
        Top = 4
        Width = 38
        Height = 16
        Caption = 'Label5'
      end
      object SpeedButtonVendor: TSpeedButton
        Left = 114
        Top = 11
        Width = 111
        Height = 33
        GroupIndex = 1
        Down = True
        Caption = 'Vendor (F5)'
        OnClick = SpeedButtonVendorClick
      end
      object SpeedButtonInvoiceNo: TSpeedButton
        Left = 224
        Top = 11
        Width = 137
        Height = 33
        GroupIndex = 1
        Caption = 'Invoice No. (F6)'
        OnClick = SpeedButtonInvoiceNoClick
      end
      object SpeedButtonDate: TSpeedButton
        Left = 360
        Top = 11
        Width = 106
        Height = 33
        GroupIndex = 1
        Caption = 'Date (F7)'
        OnClick = SpeedButtonDateClick
      end
      object Label8: TLabel
        Left = 8
        Top = 4
        Width = 86
        Height = 48
        Caption = 'Choose field to order and search by'
        WordWrap = True
      end
      object Search1: TwwIncrementalSearch
        Left = 477
        Top = 18
        Width = 121
        Height = 24
        DataSource = DatesDS
        TabOrder = 0
      end
    end
  end
  object DatesDS: TwwDataSource
    Left = 296
    Top = 232
  end
  object totalsDS: TwwDataSource
    DataSet = Totalsqry
    Left = 144
    Top = 136
  end
  object itemsds: TwwDataSource
    Left = 144
    Top = 168
  end
  object VendReport: TppReport
    AutoStop = False
    DataPipeline = vendpipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'VendReport'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    Template.FileName = 
      'C:\CC_views\michaelh_sqlPurchview\SQLPurchase\CODE\vendorReport.' +
      'rtm'
    DeviceType = 'Screen'
    OnPreviewFormCreate = VendReportPreviewFormCreate
    Left = 296
    Top = 376
    Version = '6.03'
    mmColumnWidth = 266300
    DataPipelineName = 'vendpipe'
    object VendReportHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 21167
      mmPrintPosition = 0
      object VendReportShape1: TppShape
        UserName = 'VendReportShape1'
        mmHeight = 20902
        mmLeft = 265
        mmTop = 265
        mmWidth = 261938
        BandType = 0
      end
      object VendReportShape2: TppShape
        UserName = 'VendReportShape2'
        mmHeight = 7938
        mmLeft = 101336
        mmTop = 265
        mmWidth = 50800
        BandType = 0
      end
      object VendReportLabel1: TppLabel
        UserName = 'VendReportLabel1'
        Caption = 'Vendor Period Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        mmHeight = 4233
        mmLeft = 108744
        mmTop = 1852
        mmWidth = 36513
        BandType = 0
      end
      object VendReportLabel2: TppLabel
        UserName = 'VendReportLabel2'
        Caption = 'Printed : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 217753
        mmTop = 1323
        mmWidth = 11113
        BandType = 0
      end
      object VendReportLabel3: TppLabel
        UserName = 'VendReportLabel3'
        Caption = 'Showing Vendor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3387
        mmLeft = 101071
        mmTop = 10372
        mmWidth = 20743
        BandType = 0
      end
      object vendlab: TppLabel
        UserName = 'vendlab'
        Caption = 'vendlab'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3387
        mmLeft = 123296
        mmTop = 10372
        mmWidth = 9102
        BandType = 0
      end
      object VendReportCalc1: TppSystemVariable
        UserName = 'VendReportCalc1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3704
        mmLeft = 234157
        mmTop = 1323
        mmWidth = 26723
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Report Period:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3556
        mmLeft = 103462
        mmTop = 15610
        mmWidth = 18246
        BandType = 0
      end
      object PeriodLabel: TppLabel
        UserName = 'PeriodLabel'
        Caption = 'PeriodLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3556
        mmLeft = 123561
        mmTop = 15610
        mmWidth = 15071
        BandType = 0
      end
    end
    object VendReportDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object VendReportShape4: TppShape
        UserName = 'VendReportShape4'
        mmHeight = 4868
        mmLeft = 0
        mmTop = 0
        mmWidth = 261409
        BandType = 4
      end
      object VendReportDBText2: TppDBText
        UserName = 'VendReportDBText2'
        DataField = 'InvoiceNo'
        DataPipeline = vendpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'vendpipe'
        mmHeight = 3387
        mmLeft = 847
        mmTop = 529
        mmWidth = 32385
        BandType = 4
      end
      object VendReportDBText3: TppDBText
        UserName = 'VendReportDBText3'
        AutoSize = True
        DataField = 'Invoicedate'
        DataPipeline = vendpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        DataPipelineName = 'vendpipe'
        mmHeight = 3260
        mmLeft = 34660
        mmTop = 529
        mmWidth = 14139
        BandType = 4
      end
      object rptVendDBText1: TppDBText
        UserName = 'rptVendDBText1'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 50006
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText2: TppDBText
        UserName = 'rptVendDBText2'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 65617
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText3: TppDBText
        UserName = 'rptVendDBText3'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 81492
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText4: TppDBText
        UserName = 'rptVendDBText4'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 97367
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText5: TppDBText
        UserName = 'rptVendDBText5'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 113242
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object VendReportDBText9: TppDBText
        UserName = 'VendReportDBText9'
        DataField = 'TotalCost'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 240507
        mmTop = 529
        mmWidth = 20108
        BandType = 4
      end
      object VendReportLine8: TppLine
        UserName = 'VendReportLine8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 33655
        mmTop = 0
        mmWidth = 3387
        BandType = 4
      end
      object VendReportLine9: TppLine
        UserName = 'VendReportLine9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 49477
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object VendReportLine10: TppLine
        UserName = 'VendReportLine10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 65352
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object VendReportLine11: TppLine
        UserName = 'VendReportLine11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 80963
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object VendReportLine12: TppLine
        UserName = 'VendReportLine12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 96838
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object VendReportLine13: TppLine
        UserName = 'VendReportLine13'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 112713
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object VendReportLine14: TppLine
        UserName = 'VendReportLine14'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 223838
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object rptVendDBText8: TppDBText
        UserName = 'rptVendDBText8'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 160867
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText6: TppDBText
        UserName = 'rptVendDBText6'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 129117
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText7: TppDBText
        UserName = 'rptVendDBText7'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 144992
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText9: TppDBText
        UserName = 'rptVendDBText9'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 176477
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText10: TppDBText
        UserName = 'rptVendDBText10'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 192088
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object rptVendDBText11: TppDBText
        UserName = 'rptVendDBText11'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 208227
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 128588
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 144463
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 160338
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object ppLine10: TppLine
        UserName = 'Line10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 176213
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 191559
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 207434
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
      object rptVendDBText12: TppDBText
        UserName = 'rptVendDBText12'
        DataField = 'Tax'
        DataPipeline = vendpipe
        DisplayFormat = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 224632
        mmTop = 529
        mmWidth = 15081
        BandType = 4
      end
      object ppLine26: TppLine
        UserName = 'Line26'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4763
        mmLeft = 239978
        mmTop = 0
        mmWidth = 2117
        BandType = 4
      end
    end
    object VendReportFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 3704
      mmPrintPosition = 0
      object VendReportLabel14: TppLabel
        UserName = 'VendReportLabel14'
        Caption = '^ = Accepted Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 0
        mmTop = 0
        mmWidth = 26723
        BandType = 8
      end
      object VendReportCalc2: TppSystemVariable
        UserName = 'VendReportCalc2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3440
        mmLeft = 247121
        mmTop = 0
        mmWidth = 14023
        BandType = 8
      end
    end
    object VendReportSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
      object VendReportShape6: TppShape
        UserName = 'VendReportShape6'
        mmHeight = 5821
        mmLeft = 49213
        mmTop = 1323
        mmWidth = 212196
        BandType = 7
      end
      object VendReportLine15: TppLine
        UserName = 'VendReportLine15'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 65352
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object VendReportLine16: TppLine
        UserName = 'VendReportLine16'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 80963
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object VendReportLine17: TppLine
        UserName = 'VendReportLine17'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 96838
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object VendReportLine18: TppLine
        UserName = 'VendReportLine18'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 112713
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object VendReportLine19: TppLine
        UserName = 'VendReportLine19'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 223838
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object rptTotalsSumDBText1: TppDBCalc
        UserName = 'rptTotalsSumDBText1'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 50006
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText2: TppDBCalc
        UserName = 'rptTotalsSumDBText2'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 65617
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText3: TppDBCalc
        UserName = 'rptTotalsSumDBText3'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 81492
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText4: TppDBCalc
        UserName = 'rptTotalsSumDBText4'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 97367
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText5: TppDBCalc
        UserName = 'rptTotalsSumDBText5'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 113242
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object VendReportDBCalc6: TppDBCalc
        UserName = 'VendReportDBCalc6'
        DataField = 'TotalCost'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 240507
        mmTop = 2646
        mmWidth = 20108
        BandType = 7
      end
      object VendReportLabel12: TppLabel
        UserName = 'VendReportLabel12'
        Caption = 'Totals for Period:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        mmHeight = 3440
        mmLeft = 25665
        mmTop = 2646
        mmWidth = 23019
        BandType = 7
      end
      object ppLine19: TppLine
        UserName = 'Line19'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 128323
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine20: TppLine
        UserName = 'Line20'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 144198
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine21: TppLine
        UserName = 'Line21'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 160338
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine22: TppLine
        UserName = 'Line22'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 175948
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine23: TppLine
        UserName = 'Line23'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 191559
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 207434
        mmTop = 1588
        mmWidth = 2117
        BandType = 7
      end
      object ppLine28: TppLine
        UserName = 'Line28'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5821
        mmLeft = 239978
        mmTop = 1323
        mmWidth = 2117
        BandType = 7
      end
      object rptTotalsSumDBText6: TppDBCalc
        UserName = 'rptTotalsSumDBText6'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 128852
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText7: TppDBCalc
        UserName = 'rptTotalsSumDBText7'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 144727
        mmTop = 2646
        mmWidth = 15346
        BandType = 7
      end
      object rptTotalsSumDBText8: TppDBCalc
        UserName = 'rptTotalsSumDBText8'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 160602
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText9: TppDBCalc
        UserName = 'rptTotalsSumDBText9'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 176213
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText10: TppDBCalc
        UserName = 'rptTotalsSumDBText10'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 192088
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText11: TppDBCalc
        UserName = 'rptTotalsSumDBText11'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 208227
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
      object rptTotalsSumDBText12: TppDBCalc
        UserName = 'rptTotalsSumDBText12'
        DataField = 'Tax'
        DataPipeline = vendpipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'vendpipe'
        mmHeight = 3440
        mmLeft = 224367
        mmTop = 2646
        mmWidth = 15081
        BandType = 7
      end
    end
    object VendReportGroup1: TppGroup
      BreakName = 'Vendor'
      DataPipeline = vendpipe
      KeepTogether = True
      ReprintOnSubsequentColumn = False
      UserName = 'VendReportGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'vendpipe'
      object VendReportGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 16669
        mmPrintPosition = 0
        object VendReportShape3: TppShape
          UserName = 'VendReportShape3'
          mmHeight = 6350
          mmLeft = 0
          mmTop = 1693
          mmWidth = 46990
          BandType = 3
          GroupNo = 0
        end
        object VendReportDBText1: TppDBText
          UserName = 'VendReportDBText1'
          DataField = 'Vendor'
          DataPipeline = vendpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          DataPipelineName = 'vendpipe'
          mmHeight = 4233
          mmLeft = 1058
          mmTop = 2752
          mmWidth = 45085
          BandType = 3
          GroupNo = 0
        end
        object VendReportShape5: TppShape
          UserName = 'VendReportShape5'
          mmHeight = 9260
          mmLeft = 0
          mmTop = 7408
          mmWidth = 261144
          BandType = 3
          GroupNo = 0
        end
        object VendReportLabel4: TppLabel
          UserName = 'VendReportLabel4'
          Caption = 'Invoice Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3440
          mmLeft = 7144
          mmTop = 8467
          mmWidth = 19844
          BandType = 3
          GroupNo = 0
        end
        object VendReportLabel5: TppLabel
          UserName = 'VendReportLabel5'
          Caption = 'Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3556
          mmLeft = 38100
          mmTop = 8467
          mmWidth = 5969
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel1: TppLabel
          UserName = 'rptDivnLabel1'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          WordWrap = True
          mmHeight = 7408
          mmLeft = 50006
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel2: TppLabel
          UserName = 'rptDivnLabel2'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          WordWrap = True
          mmHeight = 7144
          mmLeft = 65617
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel3: TppLabel
          UserName = 'rptDivnLabel3'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          WordWrap = True
          mmHeight = 7408
          mmLeft = 81227
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel4: TppLabel
          UserName = 'rptDivnLabel4'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          WordWrap = True
          mmHeight = 7408
          mmLeft = 97631
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel5: TppLabel
          UserName = 'rptDivnLabel5'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          WordWrap = True
          mmHeight = 7408
          mmLeft = 113506
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabelTotal: TppLabel
          UserName = 'rptDivnLabelTotal'
          AutoSize = False
          Caption = 'Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3556
          mmLeft = 240242
          mmTop = 8467
          mmWidth = 20108
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine1: TppLine
          UserName = 'VendReportLine1'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 33602
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine2: TppLine
          UserName = 'VendReportLine2'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 49477
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine3: TppLine
          UserName = 'VendReportLine3'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 65352
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine4: TppLine
          UserName = 'VendReportLine4'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 80963
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine5: TppLine
          UserName = 'VendReportLine5'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 96838
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine6: TppLine
          UserName = 'VendReportLine6'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 112713
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object VendReportLine7: TppLine
          UserName = 'VendReportLine7'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 223573
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel6: TppLabel
          UserName = 'rptDivnLabel6'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 129117
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel7: TppLabel
          UserName = 'rptDivnLabel7'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 145257
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel8: TppLabel
          UserName = 'rptDivnLabel8'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 161132
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel9: TppLabel
          UserName = 'rptDivnLabel9'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 176742
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel10: TppLabel
          UserName = 'rptDivnLabel10'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 192352
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel11: TppLabel
          UserName = 'rptDivnLabel11'
          AutoSize = False
          Caption = 'N/A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7408
          mmLeft = 208227
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 128852
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 8996
          mmLeft = 144727
          mmTop = 7673
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object ppLine3: TppLine
          UserName = 'Line3'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 8996
          mmLeft = 160602
          mmTop = 7673
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object ppLine4: TppLine
          UserName = 'Line4'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 8996
          mmLeft = 176477
          mmTop = 7673
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object ppLine5: TppLine
          UserName = 'Line5'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 191823
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object ppLine6: TppLine
          UserName = 'Line6'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 9260
          mmLeft = 207698
          mmTop = 7408
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
        object rptDivnLabel12: TppLabel
          UserName = 'rptDivnLabel12'
          AutoSize = False
          Caption = 'Tax'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3440
          mmLeft = 224103
          mmTop = 8467
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
        end
        object ppLine25: TppLine
          UserName = 'Line25'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 8996
          mmLeft = 239713
          mmTop = 7673
          mmWidth = 2117
          BandType = 3
          GroupNo = 0
        end
      end
      object VendReportGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object VendReportShape7: TppShape
          UserName = 'VendReportShape7'
          mmHeight = 5080
          mmLeft = 0
          mmTop = 0
          mmWidth = 261409
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine20: TppLine
          UserName = 'VendReportLine20'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 65352
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine21: TppLine
          UserName = 'VendReportLine21'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 80963
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine22: TppLine
          UserName = 'VendReportLine22'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 96838
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine23: TppLine
          UserName = 'VendReportLine23'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 112713
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine24: TppLine
          UserName = 'VendReportLine24'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 223838
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText1: TppDBCalc
          UserName = 'rptVendSumDBText1'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 50006
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText2: TppDBCalc
          UserName = 'rptVendSumDBText2'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 65617
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText3: TppDBCalc
          UserName = 'rptVendSumDBText3'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 81492
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText4: TppDBCalc
          UserName = 'rptVendSumDBText4'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 97367
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText5: TppDBCalc
          UserName = 'rptVendSumDBText5'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 113242
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object VendReportDBCalc12: TppDBCalc
          UserName = 'VendReportDBCalc12'
          DataField = 'TotalCost'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 240507
          mmTop = 794
          mmWidth = 20108
          BandType = 5
          GroupNo = 0
        end
        object VendReportLabel13: TppLabel
          UserName = 'VendReportLabel13'
          Caption = 'Totals for Vendor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          mmHeight = 3440
          mmLeft = 25135
          mmTop = 529
          mmWidth = 23813
          BandType = 5
          GroupNo = 0
        end
        object VendReportLine25: TppLine
          UserName = 'VendReportLine25'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 49477
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine13: TppLine
          UserName = 'Line13'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 128588
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine14: TppLine
          UserName = 'Line14'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 144463
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine15: TppLine
          UserName = 'Line15'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 160338
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine16: TppLine
          UserName = 'Line16'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 176213
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine17: TppLine
          UserName = 'Line17'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 191559
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine18: TppLine
          UserName = 'Line18'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 207434
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object ppLine27: TppLine
          UserName = 'Line27'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5027
          mmLeft = 239978
          mmTop = 0
          mmWidth = 2117
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText6: TppDBCalc
          UserName = 'rptVendSumDBText6'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 129117
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText7: TppDBCalc
          UserName = 'rptVendSumDBText7'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 144992
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText8: TppDBCalc
          UserName = 'rptVendSumDBText8'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 160867
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText9: TppDBCalc
          UserName = 'rptVendSumDBText9'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 176477
          mmTop = 794
          mmWidth = 14817
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText10: TppDBCalc
          UserName = 'rptVendSumDBText10'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 192088
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText11: TppDBCalc
          UserName = 'rptVendSumDBText11'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 208227
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object rptVendSumDBText12: TppDBCalc
          UserName = 'rptVendSumDBText12'
          DataField = 'Tax'
          DataPipeline = vendpipe
          DisplayFormat = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = VendReportGroup1
          TextAlignment = taRightJustified
          DataPipelineName = 'vendpipe'
          mmHeight = 3440
          mmLeft = 224367
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'Site Name'
      DataPipeline = vendpipe
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'vendpipe'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppShape1: TppShape
          UserName = 'Shape1'
          mmHeight = 4498
          mmLeft = 0
          mmTop = 794
          mmWidth = 33867
          BandType = 3
          GroupNo = 1
        end
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'Site Name'
          DataPipeline = vendpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsItalic]
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'vendpipe'
          mmHeight = 3302
          mmLeft = 529
          mmTop = 1323
          mmWidth = 32279
          BandType = 3
          GroupNo = 1
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
  end
  object ItemReport: TppReport
    AutoStop = False
    DataPipeline = itempipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ItemReport'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = ItemReportPreviewFormCreate
    Left = 352
    Top = 376
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'itempipe'
    object ItemReportHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 22225
      mmPrintPosition = 0
      object ItemReportShape1: TppShape
        UserName = 'ItemReportShape1'
        mmHeight = 22225
        mmLeft = 0
        mmTop = 0
        mmWidth = 195263
        BandType = 0
      end
      object ItemReportShape2: TppShape
        UserName = 'ItemReportShape2'
        mmHeight = 8731
        mmLeft = 68792
        mmTop = 0
        mmWidth = 70379
        BandType = 0
      end
      object ItemReportLabel1: TppLabel
        UserName = 'ItemReportLabel1'
        Caption = 'Item Period Purchase Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        mmHeight = 4233
        mmLeft = 74348
        mmTop = 2117
        mmWidth = 48419
        BandType = 0
      end
      object ItemReportLabel2: TppLabel
        UserName = 'ItemReportLabel2'
        Caption = 'Printed : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 154782
        mmTop = 1588
        mmWidth = 11113
        BandType = 0
      end
      object ItemReportLabel12: TppLabel
        UserName = 'ItemReportLabel12'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 4233
        mmLeft = 83609
        mmTop = 10319
        mmWidth = 12700
        BandType = 0
      end
      object divlabel: TppLabel
        UserName = 'divlabel'
        Caption = 'divlabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        mmHeight = 4022
        mmLeft = 97790
        mmTop = 10372
        mmWidth = 11218
        BandType = 0
      end
      object ItemReportCalc1: TppSystemVariable
        UserName = 'ItemReportCalc1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3704
        mmLeft = 166688
        mmTop = 1588
        mmWidth = 27252
        BandType = 0
      end
      object ItemReportCalc2: TppSystemVariable
        UserName = 'ItemReportCalc2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3440
        mmLeft = 179917
        mmTop = 6879
        mmWidth = 14023
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'Period:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 85196
        mmTop = 16404
        mmWidth = 11091
        BandType = 0
      end
      object ItemRptPeriodLabel: TppLabel
        UserName = 'ItemRptPeriodLabel'
        Caption = '??/??/???? - ??/??/????'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 97896
        mmTop = 16404
        mmWidth = 38185
        BandType = 0
      end
    end
    object ItemReportDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5080
      mmPrintPosition = 0
      object ItemReportShape5: TppShape
        UserName = 'ItemReportShape5'
        mmHeight = 5292
        mmLeft = 0
        mmTop = 0
        mmWidth = 190765
        BandType = 4
      end
      object ItemReportLine7: TppLine
        UserName = 'ItemReportLine7'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 165629
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportLine8: TppLine
        UserName = 'ItemReportLine8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 147109
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportLine9: TppLine
        UserName = 'ItemReportLine9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 127265
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportLine10: TppLine
        UserName = 'ItemReportLine10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 107156
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportLine11: TppLine
        UserName = 'ItemReportLine11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 86572
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportLine12: TppLine
        UserName = 'ItemReportLine12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5080
        mmLeft = 44873
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ItemReportDBText2: TppDBText
        UserName = 'ItemReportDBText2'
        DataField = 'EntityName'
        DataPipeline = itempipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 847
        mmTop = 847
        mmWidth = 43815
        BandType = 4
      end
      object ItemReportDBText3: TppDBText
        UserName = 'ItemReportDBText3'
        DataField = 'Invoiceno'
        DataPipeline = itempipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 45720
        mmTop = 847
        mmWidth = 40640
        BandType = 4
      end
      object ItemReportDBText4: TppDBText
        UserName = 'ItemReportDBText4'
        DataField = 'InvoiceDate'
        DataPipeline = itempipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 87207
        mmTop = 847
        mmWidth = 19050
        BandType = 4
      end
      object ItemReportDBText5: TppDBText
        UserName = 'ItemReportDBText5'
        DataField = 'Quantity'
        DataPipeline = itempipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 107686
        mmTop = 847
        mmWidth = 19050
        BandType = 4
      end
      object ItemReportDBText6: TppDBText
        UserName = 'ItemReportDBText6'
        DataField = 'Cost'
        DataPipeline = itempipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 127794
        mmTop = 847
        mmWidth = 18256
        BandType = 4
      end
      object ItemReportDBText7: TppDBText
        UserName = 'ItemReportDBText7'
        DataField = 'TotalQty'
        DataPipeline = itempipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 147638
        mmTop = 847
        mmWidth = 17463
        BandType = 4
      end
      object ItemReportDBText8: TppDBText
        UserName = 'ItemReportDBText8'
        DataField = 'TotalCost'
        DataPipeline = itempipe
        DisplayFormat = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'itempipe'
        mmHeight = 3598
        mmLeft = 166159
        mmTop = 847
        mmWidth = 23283
        BandType = 4
      end
    end
    object ItemReportFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ItemReportLabel11: TppLabel
        UserName = 'ItemReportLabel11'
        Caption = '* Total for item on invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 2646
        mmTop = 265
        mmWidth = 32015
        BandType = 8
      end
    end
    object ppGroup2: TppGroup
      BreakName = 'Site Code'
      DataPipeline = itempipe
      KeepTogether = True
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'itempipe'
      object ppGroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          AutoSize = True
          DataField = 'SiteName'
          DataPipeline = itempipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold, fsUnderline]
          Transparent = True
          DataPipelineName = 'itempipe'
          mmHeight = 4191
          mmLeft = 19315
          mmTop = 0
          mmWidth = 13335
          BandType = 3
          GroupNo = 1
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          Caption = 'Site Name: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 4233
          mmLeft = 0
          mmTop = 0
          mmWidth = 18288
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ItemReportGroup1: TppGroup
      BreakName = 'SubCat'
      DataPipeline = itempipe
      ReprintOnSubsequentColumn = False
      UserName = 'ItemReportGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'itempipe'
      object ItemReportGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 12700
        mmPrintPosition = 0
        object ItemReportShape3: TppShape
          UserName = 'ItemReportShape3'
          mmHeight = 6615
          mmLeft = 0
          mmTop = 1058
          mmWidth = 45085
          BandType = 3
          GroupNo = 0
        end
        object ItemReportDBText1: TppDBText
          UserName = 'ItemReportDBText1'
          DataField = 'SubCat'
          DataPipeline = itempipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          DataPipelineName = 'itempipe'
          mmHeight = 4233
          mmLeft = 847
          mmTop = 2117
          mmWidth = 43180
          BandType = 3
          GroupNo = 0
        end
        object ItemReportShape4: TppShape
          UserName = 'ItemReportShape4'
          mmHeight = 5503
          mmLeft = 0
          mmTop = 7408
          mmWidth = 190765
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel4: TppLabel
          UserName = 'ItemReportLabel4'
          Caption = 'Items Purchased'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 2117
          mmTop = 8467
          mmWidth = 21167
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel5: TppLabel
          UserName = 'ItemReportLabel5'
          Caption = 'Invoice No.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 49213
          mmTop = 8467
          mmWidth = 14023
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel6: TppLabel
          UserName = 'ItemReportLabel6'
          Caption = 'Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 93398
          mmTop = 8467
          mmWidth = 5821
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel7: TppLabel
          UserName = 'ItemReportLabel7'
          Caption = 'Quantity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 111919
          mmTop = 8467
          mmWidth = 10583
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel8: TppLabel
          UserName = 'ItemReportLabel8'
          Caption = 'Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 133879
          mmTop = 8467
          mmWidth = 5821
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel9: TppLabel
          UserName = 'ItemReportLabel9'
          Caption = 'Total Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3175
          mmLeft = 150019
          mmTop = 8467
          mmWidth = 11642
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLabel10: TppLabel
          UserName = 'ItemReportLabel10'
          Caption = 'Total Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsUnderline]
          mmHeight = 3704
          mmLeft = 171450
          mmTop = 8467
          mmWidth = 12700
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine1: TppLine
          UserName = 'ItemReportLine1'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 44873
          mmTop = 7408
          mmWidth = 3175
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine2: TppLine
          UserName = 'ItemReportLine2'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 86572
          mmTop = 7408
          mmWidth = 2328
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine3: TppLine
          UserName = 'ItemReportLine3'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 107156
          mmTop = 7408
          mmWidth = 2328
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine4: TppLine
          UserName = 'ItemReportLine4'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 127265
          mmTop = 7408
          mmWidth = 2328
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine5: TppLine
          UserName = 'ItemReportLine5'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 147109
          mmTop = 7408
          mmWidth = 2328
          BandType = 3
          GroupNo = 0
        end
        object ItemReportLine6: TppLine
          UserName = 'ItemReportLine6'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 165629
          mmTop = 7408
          mmWidth = 2328
          BandType = 3
          GroupNo = 0
        end
      end
      object ItemReportGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 847
        mmPrintPosition = 0
      end
    end
  end
  object VendRepDS: TwwDataSource
    DataSet = Ptab2
    Left = 264
    Top = 416
  end
  object ItemRepDS: TwwDataSource
    DataSet = ItemTabOrdqry
    Left = 384
    Top = 416
  end
  object vendpipe: TppBDEPipeline
    DataSource = VendRepDS
    UserName = 'vendpipe'
    Left = 232
    Top = 376
  end
  object itempipe: TppBDEPipeline
    DataSource = ItemRepDS
    UserName = 'itempipe'
    Left = 416
    Top = 376
    object itempipeppField1: TppField
      FieldAlias = 'SiteName'
      FieldName = 'SiteName'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object itempipeppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'Site Code'
      FieldName = 'Site Code'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object itempipeppField3: TppField
      FieldAlias = 'SubCat'
      FieldName = 'SubCat'
      FieldLength = 20
      DisplayWidth = 20
      Position = 2
    end
    object itempipeppField4: TppField
      FieldAlias = 'EntityName'
      FieldName = 'EntityName'
      FieldLength = 15
      DisplayWidth = 15
      Position = 3
    end
    object itempipeppField5: TppField
      FieldAlias = 'InvoiceNo'
      FieldName = 'InvoiceNo'
      FieldLength = 15
      DisplayWidth = 15
      Position = 4
    end
    object itempipeppField6: TppField
      FieldAlias = 'InvoiceDate'
      FieldName = 'InvoiceDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 5
    end
    object itempipeppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Quantity'
      FieldName = 'Quantity'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object itempipeppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'Cost'
      FieldName = 'Cost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 7
    end
    object itempipeppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalQty'
      FieldName = 'TotalQty'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object itempipeppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCost'
      FieldName = 'TotalCost'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
  end
  object DatesQuery: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select distinct a."delivery note no.", a."date",'
      'a."supplier name", b."entity code", b."total cost",'
      'c."division name", d."whether sales taxable"'
      'from "purchhdr.db" a, "purchase.db" b, "category.db" c,'
      '"entity.db" d, "subcateg.db" e'
      'where (a."delivery note no." = b."delivery note no.")'
      '     and(a."supplier name" = b."supplier name")'
      '     and(b."entity code" = d."entity code")'
      '    and(d."sub-category name" = e."sub-category name")'
      '    and(e."category name" = c."category name")'
      '    '
      '    and (((a."date" <= :enddate) and (a."date" >= :startdate))'
      
        '            or((a."date" >= '#39'01/01/2000'#39') and (a."date" < '#39'01/01' +
        '/2050'#39')))'
      ' order by a."supplier name", a."date"')
    Left = 296
    Top = 264
  end
  object Ptab1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'VendTab1'
    Left = 256
    Top = 232
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from itemtab1'
      'order by entityname, subcat, invoicedate')
    Left = 88
    Top = 232
  end
  object Distinctqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'select distinct a.[Site Code], b.[Site Name], a.[Vendor], a.[Inv' +
        'oiceno], a.[Invoicedate]'
      'from Vendtab1 a, Site b'
      'where a.[Site Code] = b.[Site Code]'
      '')
    Left = 224
    Top = 232
  end
  object Ptab2: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Left = 312
    Top = 200
  end
  object SumQry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'select sum(a."cost") as SumCost,a."divisionname", a."Site Code",' +
        ' a."vendor",a."invoiceno", a."taxable",'
      '          a."invoicedate"'
      'from "vendtab1" a'
      
        'group by a."vendor",a."Site Code", a."invoiceno", a."invoicedate' +
        '",a."divisionname", '
      'a."taxable"')
    Left = 328
    Top = 232
  end
  object wwqGetTax: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'theband'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'high'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'low'
        DataType = ftFloat
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select a."tax"'
      'from "ustaxes.db" a'
      'where a."band" = :theband'
      'and a."from" <= :high'
      'and a."to" > :low')
    Left = 280
    Top = 304
  end
  object Totalsqry: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    Left = 112
    Top = 136
  end
  object ITab1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'ItemTab1'
    Left = 248
    Top = 304
  end
  object Ptab3: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'VendTab3'
    Left = 184
    Top = 232
  end
  object ITab2: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'ItemTab2'
    Left = 368
    Top = 216
  end
  object Items1qry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 200
    Top = 272
  end
  object VendTabOrdqry: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT b.[Site Name] AS [Site Name], a.*'
      'FROM [#tmpVendTab2] a INNER JOIN Site b '
      '                                ON a.[Site Code] = b.[Site Code]'
      'ORDER BY a.Vendor, a.[Site Code], a.InvoiceNo')
    Left = 264
    Top = 376
  end
  object ItemTabOrdqry: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT b.[Site Name] AS SiteName, a.*'
      'FROM ItemTab1 a INNER JOIN Site b '
      '                              ON a.[Site Code] = b.[Site Code]'
      'ORDER BY a.[Site Code], a.SubCat, a.EntityName')
    Left = 384
    Top = 376
  end
  object Items2qry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select distinct a.[Site Code], a."subcat", a."entityname",'
      
        '                      sum(a."quantity") as Quantity, sum(a."cost' +
        '") as Cost, '
      '                       max(a."invoicedate") as InvoiceDate'
      'from "itemtab1" a'
      'group by a.[Site Code], a."subcat", a."entityname" ')
    Left = 376
    Top = 328
  end
  object invnoqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select * '
      'from "vendtab2" a'
      'order by a."invoiceno", a."vendor", a."invoicedate"')
    Left = 616
    Top = 336
  end
  object vendqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from "vendtab2" a'
      'order by a."vendor", a."invoiceno" , a."invoicedate"')
    Left = 648
    Top = 336
  end
  object invdateqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select * '
      'from "vendtab2" a'
      'order by a."invoicedate", a."vendor", a."invoiceno"')
    Left = 680
    Top = 336
  end
  object subcatqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT b.[Site Name] AS SiteName, a.*'
      'FROM ItemTab1 a INNER JOIN Site b '
      '                              ON a.[Site Code] = b.[Site Code]'
      'ORDER BY a.SubCat, a.EntityName, a.[Site Code], a.InvoiceDate')
    Left = 616
    Top = 384
  end
  object itemordqry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select * '
      'from "Itemtab1" a'
      'order by a."entityname", a."subcat", a."invoiceno" ')
    Left = 648
    Top = 384
  end
  object qryPZrun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 680
    Top = 288
  end
  object qryItemsforDisplay: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.[SubCat],a.[EntityName],a.[InvoiceNo],a.[InvoiceDate],a' +
        '.[Quantity],  '
      
        '       a.[Cost],a.[TotalQty],a.[TotalCost],a.[Site Code],b.[Site' +
        ' Name]'
      'from itemtab1 a, site b'
      'where a.[Site Code] = b.[Site Code]'
      'order by entityname, subcat, invoicedate')
    Left = 176
    Top = 168
    object qryItemsforDisplaySiteName: TStringField
      DisplayWidth = 20
      FieldName = 'Site Name'
    end
    object qryItemsforDisplaySubCat: TStringField
      DisplayLabel = 'Sub Category'
      DisplayWidth = 19
      FieldName = 'SubCat'
    end
    object qryItemsforDisplayEntityName: TStringField
      DisplayLabel = 'Item Name'
      DisplayWidth = 15
      FieldName = 'EntityName'
      Size = 15
    end
    object qryItemsforDisplayInvoiceNo: TStringField
      DisplayWidth = 15
      FieldName = 'InvoiceNo'
      Size = 15
    end
    object qryItemsforDisplayInvoiceDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 9
      FieldName = 'InvoiceDate'
    end
    object qryItemsforDisplayQuantity: TFloatField
      DisplayWidth = 7
      FieldName = 'Quantity'
    end
    object qryItemsforDisplayCost: TBCDField
      DisplayWidth = 9
      FieldName = 'Cost'
      Precision = 19
    end
    object qryItemsforDisplayTotalQty: TFloatField
      DisplayLabel = 'Total Qty'
      DisplayWidth = 7
      FieldName = 'TotalQty'
    end
    object qryItemsforDisplayTotalCost: TFloatField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 11
      FieldName = 'TotalCost'
    end
    object qryItemsforDisplaySiteCode: TSmallintField
      DisplayLabel = 'Site'
      DisplayWidth = 3
      FieldName = 'Site Code'
      Visible = False
    end
  end
  object qryRun2: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 88
    Top = 272
  end
  object ADOStoredProc: TADOStoredProc
    Connection = dmADO.AztecConn
    ProcedureName = 'GetACCMinAndMax;1'
    Parameters = <>
    Left = 465
    Top = 156
  end
  object minMaxDatesQry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT Max([Date]) as maxDate,'
      '       Min([Date]) as minDate'
      'FROM [AccPurHd]')
    Left = 471
    Top = 204
  end
end
