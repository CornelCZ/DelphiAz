object fProddlg: TfProddlg
  Left = 155
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Product Analysis'
  ClientHeight = 519
  ClientWidth = 692
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
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 70
    Width = 692
    Height = 306
    Selected.Strings = (
      'itemname'#9'17'#9'Name'
      'punit'#9'8'#9'Unit'
      'flavor'#9'8'#9'Flavor'
      'MinUCost'#9'10'#9'Min'
      'AvgUcost'#9'10'#9'Mean'
      'MaxUCost'#9'10'#9'Max'
      'SumQty'#9'7'#9'Quantity'
      'SumItemCost'#9'10'#9'Item Cost'
      'AvgItemCost'#9'9'#9'Avg Cost')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = wwDataSource1
    KeyOptions = [dgEnterToTab]
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 70
    Align = alTop
    TabOrder = 0
    object Shape1: TShape
      Left = 247
      Top = 60
      Width = 225
      Height = 25
      Brush.Style = bsClear
    end
    object Label1: TLabel
      Left = 322
      Top = 51
      Width = 89
      Height = 16
      Caption = ' Price Per Unit '
    end
    object Label2: TLabel
      Left = 8
      Top = 5
      Width = 177
      Height = 52
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Enter start and end dates for the time period and click '#39'Execute' +
        #39' to view analysis.'
      Color = clInactiveCaption
      Font.Charset = ANSI_CHARSET
      Font.Color = clInactiveCaptionText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label3: TLabel
      Left = 188
      Top = 8
      Width = 61
      Height = 16
      Caption = 'Start date:'
    end
    object Label4: TLabel
      Left = 193
      Top = 32
      Width = 56
      Height = 16
      Caption = 'End date:'
    end
    object BitBtn3: TBitBtn
      Left = 333
      Top = 6
      Width = 153
      Height = 41
      Caption = 'Execute'
      TabOrder = 0
      OnClick = BitBtn3Click
    end
    object BitBtn1: TBitBtn
      Left = 589
      Top = 6
      Width = 99
      Height = 41
      Caption = 'Close'
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 489
      Top = 6
      Width = 97
      Height = 41
      Caption = 'Print'
      Enabled = False
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object stPick: TDateTimePicker
      Left = 250
      Top = 5
      Width = 81
      Height = 21
      CalAlignment = dtaLeft
      CalColors.BackColor = clWhite
      CalColors.TextColor = clBlack
      CalColors.TitleBackColor = clTeal
      CalColors.TrailingTextColor = clSilver
      Date = 35748.6661298611
      Time = 35748.6661298611
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 3
      OnKeyDown = stPickKeyDown
    end
    object EndPick: TDateTimePicker
      Left = 250
      Top = 30
      Width = 81
      Height = 21
      CalAlignment = dtaLeft
      CalColors.BackColor = clWhite
      CalColors.TextColor = clBlack
      CalColors.TitleBackColor = clTeal
      CalColors.TrailingTextColor = clSilver
      Date = 35748.6669212963
      Time = 35748.6669212963
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
      OnKeyDown = EndPickKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 376
    Width = 692
    Height = 143
    Align = alBottom
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object Shape2: TShape
      Left = 246
      Top = 13
      Width = 226
      Height = 25
      Brush.Style = bsClear
    end
    object Label5: TLabel
      Left = 315
      Top = 5
      Width = 89
      Height = 16
      Caption = ' Price Per Unit '
    end
    object wwDBGrid2: TwwDBGrid
      Left = 2
      Top = 24
      Width = 688
      Height = 117
      Selected.Strings = (
        'supplier'#9'34'#9'supplier'
        'MinUCost'#9'10'#9'Min.'
        'AvgUCost'#9'10'#9'Mean'
        'MaxUCost'#9'10'#9'Max.'
        'SumQty'#9'7'#9'Quantity'
        'SumICost'#9'10'#9'Total Cost'
        'AvgICost'#9'9'#9'Avg Cost'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alBottom
      DataSource = wwDataSource2
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnCalcCellColors = wwDBGrid2CalcCellColors
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = wwqProdAllSup
    Left = 136
    Top = 240
  end
  object wwDataSource2: TwwDataSource
    DataSet = wwqget1Prod
    Left = 136
    Top = 273
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = prodpipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppReport1'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297127
    PrinterSetup.mmPaperWidth = 210079
    PrinterSetup.PaperSize = 9
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppReport1PreviewFormCreate
    Left = 200
    Top = 136
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'prodpipe'
    object ppReport1TitleBand1: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 21167
      mmPrintPosition = 0
      object ppReport1Label11: TppLabel
        UserName = 'ppReport1Label11'
        Caption = 'Product Analysis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 20
        Font.Style = [fsBold, fsUnderline]
        mmHeight = 8467
        mmLeft = 71967
        mmTop = 265
        mmWidth = 59267
        BandType = 1
      end
      object ppReport1Label14: TppLabel
        UserName = 'ppReport1Label14'
        Caption = 'Time period:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        mmHeight = 4498
        mmLeft = 7144
        mmTop = 15875
        mmWidth = 21431
        BandType = 1
      end
      object pplabTheTime: TppLabel
        UserName = 'pplabTheTime'
        Caption = 'pplabTheTime'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        mmHeight = 4498
        mmLeft = 30427
        mmTop = 15875
        mmWidth = 24606
        BandType = 1
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Site Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 7144
        mmTop = 10319
        mmWidth = 19315
        BandType = 1
      end
      object SiteNameLabel: TppLabel
        UserName = 'SiteNameLabel'
        Caption = 'the site name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 30427
        mmTop = 10319
        mmWidth = 23283
        BandType = 1
      end
      object ppReport1Calc2: TppSystemVariable
        UserName = 'Report1Calc2'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3556
        mmLeft = 22225
        mmTop = 265
        mmWidth = 27898
        BandType = 1
      end
      object ppReport1Label13: TppLabel
        UserName = 'ppReport1Label13'
        Caption = 'Print Date/Time:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3556
        mmLeft = 1058
        mmTop = 265
        mmWidth = 20532
        BandType = 1
      end
      object ppReport1Calc1: TppSystemVariable
        UserName = 'Report1Calc1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3969
        mmLeft = 166423
        mmTop = 0
        mmWidth = 17992
        BandType = 1
      end
    end
    object ppReport1HeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 1323
      mmPrintPosition = 0
    end
    object ppReport1DetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppReport1DBText1: TppDBText
        UserName = 'ppReport1DBText1'
        DataField = 'supplier'
        DataPipeline = prodpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        DataPipelineName = 'prodpipe'
        mmHeight = 4498
        mmLeft = 11906
        mmTop = 265
        mmWidth = 47625
        BandType = 4
      end
      object ppReport1DBText5: TppDBText
        UserName = 'ppReport1DBText5'
        DataField = 'MinUCost'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 60854
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1DBText6: TppDBText
        UserName = 'ppReport1DBText6'
        DataField = 'AvgUCost'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 82286
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1DBText7: TppDBText
        UserName = 'ppReport1DBText7'
        DataField = 'MaxUCost'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 103717
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1DBText8: TppDBText
        UserName = 'ppReport1DBText8'
        DataField = 'SumQty'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 125148
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1DBText9: TppDBText
        UserName = 'ppReport1DBText9'
        DataField = 'SumItemCost'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 146579
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1DBText10: TppDBText
        UserName = 'ppReport1DBText10'
        DataField = 'AvgItemCost'
        DataPipeline = prodpipe
        DisplayFormat = '0.0000;-0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'prodpipe'
        mmHeight = 4233
        mmLeft = 168011
        mmTop = 265
        mmWidth = 20373
        BandType = 4
      end
      object ppReport1Line3: TppLine
        UserName = 'ppReport1Line3'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.20000004768372
        mmHeight = 5292
        mmLeft = 11113
        mmTop = 0
        mmWidth = 4498
        BandType = 4
      end
      object ppReport1Line4: TppLine
        UserName = 'ppReport1Line4'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 60325
        mmTop = 0
        mmWidth = 4498
        BandType = 4
      end
      object ppReport1Line5: TppLine
        UserName = 'ppReport1Line5'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 81756
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line6: TppLine
        UserName = 'ppReport1Line6'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 103188
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line7: TppLine
        UserName = 'ppReport1Line7'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 124619
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line8: TppLine
        UserName = 'ppReport1Line8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 146050
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line9: TppLine
        UserName = 'ppReport1Line9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 5292
        mmLeft = 167482
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line10: TppLine
        UserName = 'ppReport1Line10'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.20000004768372
        mmHeight = 5292
        mmLeft = 186532
        mmTop = 0
        mmWidth = 2646
        BandType = 4
      end
      object ppReport1Line11: TppLine
        UserName = 'ppReport1Line11'
        Position = lpBottom
        Weight = 0.600000023841858
        mmHeight = 2646
        mmLeft = 11113
        mmTop = 2646
        mmWidth = 178065
        BandType = 4
      end
    end
    object ppReport1FooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppReport1Group1: TppGroup
      BreakName = 'itemname'
      DataPipeline = prodpipe
      ReprintOnSubsequentColumn = False
      ReprintOnSubsequentPage = False
      UserName = 'Report1Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'prodpipe'
      object ppReport1GroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppReport1GroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppReport1Group2: TppGroup
      BreakName = 'punit'
      DataPipeline = prodpipe
      ReprintOnSubsequentColumn = False
      ReprintOnSubsequentPage = False
      UserName = 'Report1Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'prodpipe'
      object ppReport1GroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppReport1GroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppReport1Group3: TppGroup
      BreakName = 'flavor'
      DataPipeline = prodpipe
      KeepTogether = True
      ReprintOnSubsequentColumn = False
      ReprintOnSubsequentPage = False
      UserName = 'Report1Group3'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'prodpipe'
      object ppReport1GroupHeaderBand3: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 12965
        mmPrintPosition = 0
        object ppReport1Line1: TppLine
          UserName = 'ppReport1Line1'
          Pen.Width = 2
          Weight = 1.20000004768372
          mmHeight = 2381
          mmLeft = 6879
          mmTop = 0
          mmWidth = 182034
          BandType = 3
          GroupNo = 2
        end
        object ppReport1DBText2: TppDBText
          UserName = 'ppReport1DBText2'
          DataField = 'flavor'
          DataPipeline = prodpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 13
          Font.Style = [fsBold]
          DataPipelineName = 'prodpipe'
          mmHeight = 5027
          mmLeft = 132027
          mmTop = 794
          mmWidth = 29104
          BandType = 3
          GroupNo = 2
        end
        object ppReport1DBText3: TppDBText
          UserName = 'ppReport1DBText3'
          DataField = 'itemname'
          DataPipeline = prodpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 13
          Font.Style = [fsBold]
          DataPipelineName = 'prodpipe'
          mmHeight = 5027
          mmLeft = 8731
          mmTop = 794
          mmWidth = 59531
          BandType = 3
          GroupNo = 2
        end
        object ppReport1DBText4: TppDBText
          UserName = 'ppReport1DBText4'
          DataField = 'punit'
          DataPipeline = prodpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 13
          Font.Style = [fsBold]
          DataPipelineName = 'prodpipe'
          mmHeight = 5027
          mmLeft = 82286
          mmTop = 794
          mmWidth = 26194
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line2: TppLine
          UserName = 'ppReport1Line2'
          Pen.Width = 2
          Weight = 1.20000004768372
          mmHeight = 2381
          mmLeft = 6879
          mmTop = 6350
          mmWidth = 181769
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line18: TppLine
          UserName = 'ppReport1Line18'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.20000004768372
          mmHeight = 12965
          mmLeft = 186532
          mmTop = 0
          mmWidth = 2646
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line20: TppLine
          UserName = 'ppReport1Line20'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.20000004768372
          mmHeight = 2646
          mmLeft = 11113
          mmTop = 10319
          mmWidth = 178065
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line21: TppLine
          UserName = 'ppReport1Line21'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.20000004768372
          mmHeight = 6615
          mmLeft = 6879
          mmTop = 0
          mmWidth = 5292
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line22: TppLine
          UserName = 'ppReport1Line22'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.20000004768372
          mmHeight = 6350
          mmLeft = 11113
          mmTop = 6615
          mmWidth = 6085
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label1: TppLabel
          UserName = 'ppReport1Label1'
          Caption = 'Min. price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 61119
          mmTop = 7408
          mmWidth = 16404
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label2: TppLabel
          UserName = 'ppReport1Label2'
          Caption = 'Mean price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 82286
          mmTop = 7408
          mmWidth = 18785
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label3: TppLabel
          UserName = 'ppReport1Label3'
          Caption = 'Max. price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 103981
          mmTop = 7408
          mmWidth = 17463
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label4: TppLabel
          UserName = 'ppReport1Label4'
          Caption = 'Quantity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 125677
          mmTop = 7408
          mmWidth = 14288
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label5: TppLabel
          UserName = 'ppReport1Label5'
          Caption = 'Total cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 146844
          mmTop = 7408
          mmWidth = 16933
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label6: TppLabel
          UserName = 'ppReport1Label6'
          Caption = 'Avg. cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 168275
          mmTop = 7408
          mmWidth = 15875
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label8: TppLabel
          UserName = 'ppReport1Label8'
          Caption = 'Breakdown on Suppliers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 11906
          mmTop = 7408
          mmWidth = 41804
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label9: TppLabel
          UserName = 'ppReport1Label9'
          Caption = 'Unit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 13
          Font.Style = []
          mmHeight = 5027
          mmLeft = 72231
          mmTop = 794
          mmWidth = 8731
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Label10: TppLabel
          UserName = 'ppReport1Label10'
          Caption = 'Flavor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 13
          Font.Style = []
          mmHeight = 5249
          mmLeft = 114300
          mmTop = 794
          mmWidth = 13928
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line19: TppLine
          UserName = 'ppReport1Line19'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 60325
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line27: TppLine
          UserName = 'ppReport1Line27'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 81756
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line28: TppLine
          UserName = 'ppReport1Line28'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 103188
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line29: TppLine
          UserName = 'ppReport1Line29'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 124619
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line30: TppLine
          UserName = 'ppReport1Line30'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 146050
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
        object ppReport1Line31: TppLine
          UserName = 'ppReport1Line31'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 6615
          mmLeft = 167482
          mmTop = 6350
          mmWidth = 3969
          BandType = 3
          GroupNo = 2
        end
      end
      object ppReport1GroupFooterBand3: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 10054
        mmPrintPosition = 0
        object ppReport1Line23: TppLine
          UserName = 'ppReport1Line23'
          Weight = 0.75
          mmHeight = 2646
          mmLeft = 11113
          mmTop = 0
          mmWidth = 178065
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc1: TppDBCalc
          UserName = 'ppReport1DBCalc1'
          DataField = 'MinUCost'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DBCalcType = dcMinimum
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 60854
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc2: TppDBCalc
          UserName = 'ppReport1DBCalc2'
          DataField = 'AvgUCost'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DBCalcType = dcAverage
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 82286
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc3: TppDBCalc
          UserName = 'ppReport1DBCalc3'
          DataField = 'MaxUCost'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DBCalcType = dcMaximum
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 103717
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc4: TppDBCalc
          UserName = 'ppReport1DBCalc4'
          DataField = 'SumQty'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 125148
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc5: TppDBCalc
          UserName = 'ppReport1DBCalc5'
          DataField = 'SumItemCost'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 146579
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1DBCalc6: TppDBCalc
          UserName = 'ppReport1DBCalc6'
          DataField = 'AvgItemCost'
          DataPipeline = prodpipe
          DisplayFormat = '0.0000;-0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ResetGroup = ppReport1Group3
          TextAlignment = taRightJustified
          DBCalcType = dcAverage
          DataPipelineName = 'prodpipe'
          mmHeight = 4233
          mmLeft = 168011
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line12: TppLine
          UserName = 'ppReport1Line12'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 60325
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line13: TppLine
          UserName = 'ppReport1Line13'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 81756
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line14: TppLine
          UserName = 'ppReport1Line14'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 103188
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line15: TppLine
          UserName = 'ppReport1Line15'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 124619
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line16: TppLine
          UserName = 'ppReport1Line16'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 146050
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line17: TppLine
          UserName = 'ppReport1Line17'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5556
          mmLeft = 167482
          mmTop = 0
          mmWidth = 3969
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line24: TppLine
          UserName = 'ppReport1Line24'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.20000004768372
          mmHeight = 5556
          mmLeft = 11113
          mmTop = 0
          mmWidth = 4498
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Label7: TppLabel
          UserName = 'ppReport1Label7'
          Caption = 'Item Totals:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          mmHeight = 4498
          mmLeft = 39158
          mmTop = 794
          mmWidth = 20108
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line25: TppLine
          UserName = 'ppReport1Line25'
          Pen.Width = 2
          Weight = 1.20000004768372
          mmHeight = 1852
          mmLeft = 11113
          mmTop = 5556
          mmWidth = 178065
          BandType = 5
          GroupNo = 2
        end
        object ppReport1Line26: TppLine
          UserName = 'ppReport1Line26'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.20000004768372
          mmHeight = 6085
          mmLeft = 186532
          mmTop = 0
          mmWidth = 2646
          BandType = 5
          GroupNo = 2
        end
      end
    end
  end
  object wwDataSource3: TwwDataSource
    DataSet = wwqReport
    Left = 136
    Top = 136
  end
  object prodpipe: TppBDEPipeline
    DataSource = wwDataSource3
    UserName = 'prodpipe'
    Left = 168
    Top = 136
    object prodpipeppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'itemid'
      FieldName = 'itemid'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 0
      Position = 0
    end
    object prodpipeppField2: TppField
      FieldAlias = 'itemname'
      FieldName = 'itemname'
      FieldLength = 20
      DisplayWidth = 20
      Position = 1
    end
    object prodpipeppField3: TppField
      FieldAlias = 'punit'
      FieldName = 'punit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 2
    end
    object prodpipeppField4: TppField
      FieldAlias = 'flavor'
      FieldName = 'flavor'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object prodpipeppField5: TppField
      FieldAlias = 'supplier'
      FieldName = 'supplier'
      FieldLength = 20
      DisplayWidth = 20
      Position = 4
    end
    object prodpipeppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'MinUCost'
      FieldName = 'MinUCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 5
    end
    object prodpipeppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'MaxUCost'
      FieldName = 'MaxUCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 6
    end
    object prodpipeppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'AvgUCost'
      FieldName = 'AvgUCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 7
    end
    object prodpipeppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'AvgItemCost'
      FieldName = 'AvgItemCost'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object prodpipeppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'SumQty'
      FieldName = 'SumQty'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
    object prodpipeppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'SumItemCost'
      FieldName = 'SumItemCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 10
    end
  end
  object wwtProduct2: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'Product2'
    Left = 104
    Top = 104
  end
  object wwtProduct: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'Product'
    Left = 136
    Top = 104
  end
  object wwqReport: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select itemid, itemname, punit, flavor, supplier,min(ucost) as M' +
        'inUCost, '
      '   max(ucost) as MaxUCost, avg(ucost) as AvgUCost, '
      '  ((sum(itemcost)) / sum(qty)) as AvgItemCost, '
      '   sum(qty) as SumQty, sum(itemcost) as SumItemCost    '
      'from product'
      'group by  itemid, itemname, punit, flavor, supplier'
      'order by itemname')
    Left = 104
    Top = 136
  end
  object wwqProd1_2: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select itemid, itemname, punit, flavor, ucost, '
      '   tax, sum(qty) as qty, sum(itemcost) as ItemCost   '
      'from product'
      'group by  itemid, itemname, punit, flavor, ucost, tax')
    Left = 104
    Top = 176
  end
  object wwqGetAllProd: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'startdate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'enddate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      
        'select p.[entity code], p.[purchase name], p.[unit name], p.[fla' +
        'vour],'
      
        '     p.[supplier name],  p.[cost per unit],e.[Whether Sales Taxa' +
        'ble],'
      
        '     sum(p.[quantity]) as Quantity, sum(p.[total cost]) as [Tota' +
        'l Cost]'
      'from purchase p, purchhdr h, entity e'
      'where (((h.[date] >= :startdate) and (h.[date] <= :enddate))'
      
        '     or((h.[date] >= '#39'01/01/2000'#39' ) and (h.[date] < '#39'01/01/2050'#39 +
        ')))'
      '    and p.[Delivery note no.] = h.[delivery note no.] '
      '    and e.[entity code] = p.[entity code] '
      '    and p.[unit name] is not null'
      '    and p.[cost per unit] > 0.0'
      '    and p.[quantity] > 0'
      
        'group by  p.[entity code], p.[purchase name], p.[unit name], p.[' +
        'flavour],'
      
        '     p.[supplier name],  p.[cost per unit],e.[Whether Sales Taxa' +
        'ble]')
    Left = 136
    Top = 176
  end
  object wwqPutFlavor: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'update product'
      'set flavor = '#39'.'#39
      'where flavor is null')
    Left = 104
    Top = 208
  end
  object wwqProdAllSup: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select itemid, itemname, punit, flavor, min(ucost) as MinUCost, '
      '   max(ucost) as MaxUCost, avg(ucost) as AvgUcost,'
      '   ((sum(itemcost)) / sum(qty)) as AvgItemCost, '
      '   sum(qty) as SumQty, sum(itemcost) as SumItemCost'
      'from Product2'
      'group by  itemid, itemname, punit, flavor'
      'order by itemname')
    Left = 104
    Top = 240
    object wwqProdAllSupitemname: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 17
      FieldName = 'itemname'
    end
    object wwqProdAllSuppunit: TStringField
      DisplayLabel = 'Unit'
      DisplayWidth = 8
      FieldName = 'punit'
      Size = 10
    end
    object wwqProdAllSupflavor: TStringField
      DisplayLabel = 'Flavor'
      DisplayWidth = 8
      FieldName = 'flavor'
      Size = 10
    end
    object wwqProdAllSupMinUCost: TBCDField
      DisplayLabel = 'Min'
      DisplayWidth = 10
      FieldName = 'MinUCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqProdAllSupAvgUcost: TBCDField
      DisplayLabel = 'Mean'
      DisplayWidth = 10
      FieldName = 'AvgUcost'
      ReadOnly = True
      Precision = 19
    end
    object wwqProdAllSupMaxUCost: TBCDField
      DisplayLabel = 'Max'
      DisplayWidth = 10
      FieldName = 'MaxUCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqProdAllSupSumQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 7
      FieldName = 'SumQty'
      ReadOnly = True
    end
    object wwqProdAllSupSumItemCost: TBCDField
      DisplayLabel = 'Item Cost'
      DisplayWidth = 10
      FieldName = 'SumItemCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqProdAllSupAvgItemCost: TFloatField
      DisplayLabel = 'Avg Cost'
      DisplayWidth = 9
      FieldName = 'AvgItemCost'
      ReadOnly = True
    end
    object wwqProdAllSupitemid: TFloatField
      FieldName = 'itemid'
      Visible = False
    end
  end
  object wwqget1Prod: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = wwDataSource1
    Parameters = <
      item
        Name = 'itemid'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Value = 10000004758
      end
      item
        Name = 'punit'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = 'Single'
      end
      item
        Name = 'flavor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = '.'
      end>
    SQL.Strings = (
      
        'select supplier, min(ucost) as MinUCost, avg(ucost) as AvgUCost,' +
        ' '
      
        '  max(ucost) as MaxUCost, sum(qty) as SumQty, sum(itemcost) as S' +
        'umICost,'
      '  ((sum(itemcost))  /  (sum(qty))) as AvgICost'
      'from product'
      'where itemid = :itemid'
      '    and punit = :punit'
      '    and flavor = :flavor'
      'group by  supplier')
    Left = 104
    Top = 272
    object wwqget1Prodsupplier: TStringField
      DisplayWidth = 33
      FieldName = 'supplier'
    end
    object wwqget1ProdMinUCost: TBCDField
      DisplayLabel = 'Min.'
      DisplayWidth = 10
      FieldName = 'MinUCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqget1ProdAvgUCost: TBCDField
      DisplayLabel = 'Mean'
      DisplayWidth = 10
      FieldName = 'AvgUCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqget1ProdMaxUCost: TBCDField
      DisplayLabel = 'Max.'
      DisplayWidth = 10
      FieldName = 'MaxUCost'
      ReadOnly = True
      Precision = 19
    end
    object wwqget1ProdSumQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 7
      FieldName = 'SumQty'
      ReadOnly = True
    end
    object wwqget1ProdSumICost: TBCDField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 10
      FieldName = 'SumICost'
      ReadOnly = True
      Precision = 19
    end
    object wwqget1ProdAvgICost: TFloatField
      DisplayLabel = 'Avg Cost'
      DisplayWidth = 9
      FieldName = 'AvgICost'
      ReadOnly = True
    end
  end
  object QryRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 72
    Top = 104
  end
end
