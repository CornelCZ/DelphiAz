object PromotionReports: TPromotionReports
  Left = 804
  Top = 523
  HelpContext = 7103
  BorderStyle = bsSingle
  Caption = 'Promotion Reports'
  ClientHeight = 245
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    407
    245)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 68
    Width = 106
    Height = 13
    Caption = 'Information to report:'
  end
  object Label4: TLabel
    Left = 160
    Top = 116
    Width = 48
    Height = 13
    Caption = 'Date filter'
  end
  object Label5: TLabel
    Left = 8
    Top = 116
    Width = 43
    Height = 13
    Caption = 'Site filter'
  end
  object Label6: TLabel
    Left = 8
    Top = 156
    Width = 73
    Height = 13
    Caption = 'Promotion filter'
  end
  object Panel1: TPanel
    Left = 160
    Top = 132
    Width = 233
    Height = 64
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 118
      Top = 45
      Width = 18
      Height = 13
      Caption = 'and'
    end
    object rbAllDates: TRadioButton
      Left = 0
      Top = 0
      Width = 113
      Height = 17
      Action = SetDateFilterMode
      Caption = 'All dates'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbFilterDate: TRadioButton
      Left = 0
      Top = 24
      Width = 200
      Height = 17
      Action = SetDateFilterMode
      Caption = 'Promotions effective between:'
      TabOrder = 1
    end
    object dtpDateFilterStart: TDateTimePicker
      Left = 24
      Top = 41
      Width = 89
      Height = 21
      CalAlignment = dtaLeft
      Date = 39304.6479509491
      Time = 39304.6479509491
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
      OnChange = dtpDateFilterStartChange
    end
    object dtpDateFilterEnd: TDateTimePicker
      Left = 144
      Top = 41
      Width = 89
      Height = 21
      CalAlignment = dtaLeft
      Date = 39304.6479509491
      Time = 39304.6479509491
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 3
      OnChange = dtpDateFilterEndChange
    end
  end
  object cbReportType: TComboBox
    Left = 8
    Top = 84
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Promotion usage'
    OnChange = ChangeReportDetailsExecute
    Items.Strings = (
      'Promotion usage'
      'Site Promotion usage')
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    DesignSize = (
      407
      66)
    object lblReportTitle: TLabel
      Left = 5
      Top = 6
      Width = 104
      Height = 13
      Caption = 'Promotion reports'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = -1
      Top = 64
      Width = 409
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
    end
    object Image4: TImage
      Tag = 102
      Left = 353
      Top = 5
      Width = 49
      Height = 49
      Anchors = [akTop, akRight]
    end
    object lblReportDetail: TLabel
      Left = 8
      Top = 24
      Width = 393
      Height = 33
      AutoSize = False
      Caption = 
        'Report on what promotions a site uses, or what sites are using e' +
        'ach promotion'
      WordWrap = True
    end
  end
  object cbSiteNames: TComboBox
    Left = 8
    Top = 132
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnChange = ChangeReportDetailsExecute
  end
  object cbPromotions: TComboBox
    Left = 8
    Top = 172
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = ChangeReportDetailsExecute
  end
  object btClose: TButton
    Left = 325
    Top = 214
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = btCloseClick
  end
  object btPreview: TButton
    Left = 245
    Top = 214
    Width = 75
    Height = 22
    Action = Preview
    Anchors = [akRight, akBottom]
    TabOrder = 6
  end
  object ActionList1: TActionList
    Left = 360
    Top = 132
    object SetDateFilterMode: TAction
      Caption = 'SetDateFilterMode'
      OnExecute = SetDateFilterModeExecute
    end
    object LoadSiteNames: TAction
      Caption = 'LoadSiteNames'
      OnExecute = LoadSiteNamesExecute
    end
    object LoadPromotionNames: TAction
      Caption = 'LoadPromotionNames'
      OnExecute = LoadPromotionNamesExecute
    end
    object Preview: TAction
      Caption = 'Preview'
      OnExecute = PreviewExecute
    end
    object ChangeReportDetails: TAction
      Caption = 'Change Report'
      OnExecute = ChangeReportDetailsExecute
    end
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = dsReportAll
    SkipWhenNoRecords = False
    UserName = 'DBPipeline1'
    Left = 376
    Top = 76
    object ppDBPipeline1ppField1: TppField
      FieldAlias = 'SiteName'
      FieldName = 'SiteName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField2: TppField
      FieldAlias = 'SalesAreaName'
      FieldName = 'SalesAreaName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField3: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField4: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField5: TppField
      FieldAlias = 'PromoTypeName'
      FieldName = 'PromoTypeName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField6: TppField
      FieldAlias = 'StartDate'
      FieldName = 'StartDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField7: TppField
      FieldAlias = 'EndDate'
      FieldName = 'EndDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField8: TppField
      FieldAlias = 'Exception Name'
      FieldName = 'Exception Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField9: TppField
      FieldAlias = 'Exception Description'
      FieldName = 'Exception Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField10: TppField
      FieldAlias = 'PromotionID'
      FieldName = 'PromotionID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
  end
  object adoReportTable: TADOTable
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    TableName = '#ReportPreview'
    Left = 192
    Top = 76
    object adoReportTableSiteName: TStringField
      DisplayLabel = 'Site Name'
      DisplayWidth = 15
      FieldName = 'SiteName'
    end
    object adoReportTableSalesAreaName: TStringField
      DisplayLabel = 'Sales Area Name'
      DisplayWidth = 15
      FieldName = 'SalesAreaName'
    end
    object adoReportTableName: TStringField
      DisplayLabel = 'Promotion Name'
      DisplayWidth = 18
      FieldName = 'Name'
      Size = 25
    end
    object adoReportTableDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 256
    end
    object adoReportTablePromoTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 8
      FieldName = 'PromoTypeName'
      Size = 50
    end
    object adoReportTableStartDate: TDateTimeField
      DisplayWidth = 10
      FieldName = 'StartDate'
    end
    object adoReportTableEndDate: TDateTimeField
      DisplayWidth = 10
      FieldName = 'EndDate'
    end
    object adoReportTableExceptionName: TStringField
      DisplayWidth = 20
      FieldName = 'Exception Name'
      Size = 50
    end
    object adoReportTableExceptionDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Exception Description'
      Size = 255
    end
    object adoReportTablePromotionID: TLargeintField
      DisplayLabel = 'ID'
      DisplayWidth = 3
      FieldName = 'PromotionID'
      Visible = False
    end
    object adoReportTableSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object adoReportTableCreatedBy: TStringField
      FieldName = 'CreatedBy'
      Size = 25
    end
    object adoReportTableSiteIndicator: TStringField
      DisplayWidth = 1
      FieldName = 'SiteIndicator'
      Size = 1
    end
    object adoReportTableLegendIndicator: TStringField
      FieldName = 'LegendIndicator'
      Size = 1
    end
  end
  object dsReportAll: TDataSource
    DataSet = adoReportTable
    Left = 256
    Top = 76
  end
  object adoReportAll: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT a.PromotionID, a.Name, a.Description, SiteName, SalesArea' +
        'Name, d.PromoTypeName, a.StartDate, a.EndDate, e.Name AS [Except' +
        'ion Name], e.Description AS [Exception Description]'
      'FROM Promotion AS a '
      'INNER JOIN PromotionSalesArea AS b ON '
      '  a.PromotionID = b.PromotionID '
      'JOIN (SELECT DISTINCT'
      '    CAST(config.[Sales Area Code] AS SMALLINT) AS SalesAreaID,'
      '    config.[Sales Area Name] AS SalesAreaName,'
      '    config.[Site Name] AS SiteName'
      '  FROM config'
      '  join siteaztec ON config.[site code] = siteaztec.[site code]'
      '  WHERE (config.deleted IS NULL OR config.deleted = '#39'N'#39')'
      '     AND config.[Sales Area Code] IS NOT NULL'
      ')'
      'c ON b.SalesAreaID = c.SalesAreaID'
      'INNER JOIN PromoType AS d ON'
      '  a.PromoTypeID = d.PromoTypeID'
      'LEFT OUTER JOIN PromotionException AS e ON'
      '  a.PromotionID = e.PromotionID'
      
        'GROUP BY a.PromotionID, SiteName, a.Name, SalesAreaName, a.Descr' +
        'iption, d.PromoTypeName, a.StartDate, a.EndDate, e.Description, ' +
        'e.Name')
    Left = 312
    Top = 76
    object adoReportAllPromotionID: TLargeintField
      FieldName = 'PromotionID'
      Visible = False
    end
    object adoReportAllSiteName: TStringField
      DisplayLabel = 'Site Name'
      DisplayWidth = 18
      FieldName = 'SiteName'
    end
    object adoReportAllSalesAreaName: TStringField
      DisplayLabel = 'Sales Area Name'
      DisplayWidth = 18
      FieldName = 'SalesAreaName'
    end
    object adoReportAllName: TStringField
      DisplayLabel = 'Promotion Name'
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 25
    end
    object adoReportAllDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 256
    end
    object adoReportAllPromoTypeName: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'PromoTypeName'
      Size = 50
    end
    object adoReportAllStartDate: TDateTimeField
      DisplayLabel = 'Start Date'
      DisplayWidth = 10
      FieldName = 'StartDate'
    end
    object adoReportAllEndDate: TDateTimeField
      DisplayLabel = 'End Date'
      DisplayWidth = 10
      FieldName = 'EndDate'
    end
    object adoReportAllExceptionName: TStringField
      DisplayWidth = 20
      FieldName = 'Exception Name'
      Size = 50
    end
    object adoReportAllExceptionDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Exception Description'
      Size = 255
    end
  end
  object ppRepSiteUsage: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = HandlePreviewFormCreate
    Left = 144
    Top = 20
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppShape13: TppShape
        UserName = 'Shape13'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 222515
        mmTop = 7408
        mmWidth = 44186
        BandType = 0
      end
      object ppShape11: TppShape
        UserName = 'Shape11'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 201877
        mmTop = 7408
        mmWidth = 20902
        BandType = 0
      end
      object ppShape7: TppShape
        UserName = 'Shape7'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 181240
        mmTop = 7408
        mmWidth = 20902
        BandType = 0
      end
      object ppShape9: TppShape
        UserName = 'Shape9'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 147373
        mmTop = 7408
        mmWidth = 34131
        BandType = 0
      end
      object ppShape5: TppShape
        UserName = 'Shape5'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 87577
        mmTop = 7408
        mmWidth = 60061
        BandType = 0
      end
      object ppShape3: TppShape
        UserName = 'Shape3'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 39952
        mmTop = 7408
        mmWidth = 47890
        BandType = 0
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 2647
        mmTop = 7408
        mmWidth = 37571
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Site Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 3175
        mmTop = 7938
        mmWidth = 36513
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Sales Area Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 40481
        mmTop = 7938
        mmWidth = 46831
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 88106
        mmTop = 7938
        mmWidth = 59002
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Type'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 147902
        mmTop = 7938
        mmWidth = 33073
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Start Date'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 181769
        mmTop = 7938
        mmWidth = 19844
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = 'End Date'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 202407
        mmTop = 7938
        mmWidth = 19844
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Exception Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4868
        mmLeft = 223044
        mmTop = 7938
        mmWidth = 43127
        BandType = 0
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Site Usage Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5027
        mmLeft = 110861
        mmTop = 794
        mmWidth = 44715
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'SiteName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 2646
        mmTop = 0
        mmWidth = 37306
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'SalesAreaName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 40746
        mmTop = 0
        mmWidth = 46831
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Name'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 88371
        mmTop = 0
        mmWidth = 59002
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'PromoTypeName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 148167
        mmTop = 0
        mmWidth = 32808
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'StartDate'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 181769
        mmTop = 0
        mmWidth = 19844
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'EndDate'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 202407
        mmTop = 0
        mmWidth = 19844
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'Exception Name'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 223044
        mmTop = 0
        mmWidth = 43127
        BandType = 4
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        DataField = 'SiteIndicator'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 0
        mmTop = 0
        mmWidth = 2647
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 3704
      mmPrintPosition = 0
      object ppLabel17: TppLabel
        UserName = 'Label17'
        Caption = '- promotion created at site.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2910
        mmLeft = 3175
        mmTop = 794
        mmWidth = 35983
        BandType = 8
      end
      object ppDBTextLegendIndicator: TppDBText
        UserName = 'DBTextLegendIndicator'
        Color = clSilver
        DataField = 'LegendIndicator'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 2879
        mmLeft = 794
        mmTop = 794
        mmWidth = 2381
        BandType = 8
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Pen.Color = clGrayText
        Weight = 0.75
        mmHeight = 265
        mmLeft = 0
        mmTop = 0
        mmWidth = 266701
        BandType = 8
      end
    end
  end
  object ppRepPromotion: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = HandlePreviewFormCreate
    Left = 248
    Top = 20
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand2: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppShape2: TppShape
        UserName = 'Shape13'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 222515
        mmTop = 7408
        mmWidth = 44186
        BandType = 0
      end
      object ppShape4: TppShape
        UserName = 'Shape11'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 201877
        mmTop = 7408
        mmWidth = 20902
        BandType = 0
      end
      object ppShape6: TppShape
        UserName = 'Shape7'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 180975
        mmTop = 7408
        mmWidth = 21167
        BandType = 0
      end
      object ppShape8: TppShape
        UserName = 'Shape9'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 147373
        mmTop = 7408
        mmWidth = 33867
        BandType = 0
      end
      object ppShape10: TppShape
        UserName = 'Shape5'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 3440
        mmTop = 7408
        mmWidth = 56621
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 3969
        mmTop = 7938
        mmWidth = 55563
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Type'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 147902
        mmTop = 7938
        mmWidth = 32808
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Start Date'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 181505
        mmTop = 7938
        mmWidth = 20108
        BandType = 0
      end
      object ppLabel14: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = 'End Date'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 202407
        mmTop = 7938
        mmWidth = 19844
        BandType = 0
      end
      object ppLabel15: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Exception Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 223044
        mmTop = 7938
        mmWidth = 43127
        BandType = 0
      end
      object ppLabel16: TppLabel
        UserName = 'Label8'
        Caption = 'Promotion Usage Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5027
        mmLeft = 108215
        mmTop = 1058
        mmWidth = 50006
        BandType = 0
      end
      object ppShape12: TppShape
        UserName = 'Shape3'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 99748
        mmTop = 7408
        mmWidth = 47890
        BandType = 0
      end
      object ppShape14: TppShape
        UserName = 'Shape1'
        Brush.Style = bsClear
        mmHeight = 5821
        mmLeft = 59796
        mmTop = 7408
        mmWidth = 40217
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Site Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 60325
        mmTop = 7938
        mmWidth = 39158
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Sales Area Name'
        Color = 11644811
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        mmHeight = 4763
        mmLeft = 100277
        mmTop = 7938
        mmWidth = 46831
        BandType = 0
      end
    end
    object ppDetailBand2: TppDetailBand
      BeforePrint = ppDetailBand2BeforePrint
      mmBottomOffset = 0
      mmHeight = 5027
      mmPrintPosition = 0
      object ppDBText8: TppDBText
        UserName = 'DBText1'
        DataField = 'SiteName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 60854
        mmTop = 0
        mmWidth = 39158
        BandType = 4
      end
      object ppDBText9: TppDBText
        UserName = 'DBText2'
        DataField = 'SalesAreaName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 100806
        mmTop = 0
        mmWidth = 46831
        BandType = 4
      end
      object ppDBText10: TppDBText
        UserName = 'DBText3'
        DataField = 'Name'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 3440
        mmTop = 0
        mmWidth = 56621
        BandType = 4
      end
      object ppDBText11: TppDBText
        UserName = 'DBText5'
        DataField = 'PromoTypeName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 148432
        mmTop = 0
        mmWidth = 32808
        BandType = 4
      end
      object ppDBText12: TppDBText
        UserName = 'DBText4'
        DataField = 'StartDate'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 181769
        mmTop = 0
        mmWidth = 20108
        BandType = 4
      end
      object ppDBText13: TppDBText
        UserName = 'DBText6'
        DataField = 'EndDate'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 202671
        mmTop = 0
        mmWidth = 19844
        BandType = 4
      end
      object ppDBText14: TppDBText
        UserName = 'DBText7'
        DataField = 'Exception Name'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 223309
        mmTop = 0
        mmWidth = 43127
        BandType = 4
      end
      object ppDBTextSiteIndicator: TppDBText
        UserName = 'DBText8'
        DataField = 'SiteIndicator'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3970
        mmLeft = 794
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
    end
    object ppFooterBand2: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 3704
      mmPrintPosition = 0
      object ppDBTextSiteOnly: TppDBText
        UserName = 'DBText9'
        Color = clSilver
        DataField = 'LegendIndicator'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 2879
        mmLeft = 794
        mmTop = 794
        mmWidth = 2381
        BandType = 8
      end
      object ppLabelSiteOnly: TppLabel
        UserName = 'Label9'
        Caption = '- promotion created at site.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2910
        mmLeft = 3175
        mmTop = 794
        mmWidth = 35983
        BandType = 8
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Pen.Color = clGrayText
        Weight = 0.75
        mmHeight = 265
        mmLeft = 0
        mmTop = 0
        mmWidth = 266701
        BandType = 8
      end
    end
  end
end
