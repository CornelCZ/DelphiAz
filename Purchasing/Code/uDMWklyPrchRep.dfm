object frmDMWklyPrchRep: TfrmDMWklyPrchRep
  OldCreateOrder = True
  OnCreate = frmDMWklyPrchRepCreate
  OnDestroy = frmDMWklyPrchRepDestroy
  Left = 243
  Top = 234
  Height = 550
  Width = 817
  object TblWklyPurchDS: TwwDataSource
    DataSet = qryWklyPurch
    Left = 99
    Top = 19
  end
  object WklyPurchPipe: TppBDEPipeline
    DataSource = TblWklyPurchDS
    UserName = 'WklyPurchPipe'
    Left = 188
    Top = 15
    object WklyPurchPipeppField1: TppField
      FieldAlias = 'Vendor'
      FieldName = 'Vendor'
      FieldLength = 20
      DisplayWidth = 20
      Position = 0
    end
    object WklyPurchPipeppField2: TppField
      FieldAlias = 'Inv Date'
      FieldName = 'Inv Date'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 1
    end
    object WklyPurchPipeppField3: TppField
      FieldAlias = 'Invoice No.'
      FieldName = 'Invoice No.'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object WklyPurchPipeppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'Inv Total'
      FieldName = 'Inv Total'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 3
    end
    object WklyPurchPipeppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'Red_C_Sides'
      FieldName = 'Red_C_Sides'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 4
    end
    object WklyPurchPipeppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'Spirits_Gins'
      FieldName = 'Spirits_Gins'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 5
    end
    object WklyPurchPipeppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Tobacco'
      FieldName = 'Tobacco'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 6
    end
    object WklyPurchPipeppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'Oxygen_Cans'
      FieldName = 'Oxygen_Cans'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 7
    end
    object WklyPurchPipeppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'Spirits_Liqueurs'
      FieldName = 'Spirits_Liqueurs'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 8
    end
    object WklyPurchPipeppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'Bar_Food'
      FieldName = 'Bar_Food'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 9
    end
    object WklyPurchPipeppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'Main_Courses'
      FieldName = 'Main_Courses'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 10
    end
    object WklyPurchPipeppField12: TppField
      FieldAlias = 'C1'
      FieldName = 'C1'
      FieldLength = 2
      DisplayWidth = 2
      Position = 11
    end
    object WklyPurchPipeppField13: TppField
      Alignment = taRightJustify
      FieldAlias = 'Others_Coded1'
      FieldName = 'Others_Coded1'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 12
    end
    object WklyPurchPipeppField14: TppField
      FieldAlias = 'C2'
      FieldName = 'C2'
      FieldLength = 2
      DisplayWidth = 2
      Position = 13
    end
    object WklyPurchPipeppField15: TppField
      Alignment = taRightJustify
      FieldAlias = 'Others_Coded2'
      FieldName = 'Others_Coded2'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 14
    end
  end
  object WklyPurchRep: TppReport
    AutoStop = False
    DataPipeline = WklyPurchPipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'WklyPurchRep'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 5080
    PrinterSetup.mmMarginRight = 12700
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OnPreviewFormClose = WklyPurchRepPreviewFormClose
    OnPreviewFormCreate = WklyPurchRepPreviewFormCreate
    Left = 262
    Top = 16
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'WklyPurchPipe'
    object WklyPurchRepHdrBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 32544
      mmPrintPosition = 0
      object Lbl10: TppLabel
        Tag = 13
        UserName = 'Lbl10'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 222250
        mmTop = 27517
        mmWidth = 37835
        BandType = 0
      end
      object Lbl5: TppLabel
        Tag = 8
        UserName = 'Lbl5'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 155311
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object Lbl6: TppLabel
        Tag = 9
        UserName = 'Lbl6'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 171980
        mmTop = 27517
        mmWidth = 16140
        BandType = 0
      end
      object Lbl7: TppLabel
        Tag = 10
        UserName = 'Lbl7'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 188384
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object Lbl8: TppLabel
        Tag = 11
        UserName = 'Lbl8'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 205052
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object Lbl4: TppLabel
        Tag = 7
        UserName = 'Lbl4'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 138642
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object Lbl3: TppLabel
        Tag = 6
        UserName = 'Lbl3'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 121973
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object Lbl2: TppLabel
        Tag = 5
        UserName = 'Lbl2'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 105569
        mmTop = 27517
        mmWidth = 16140
        BandType = 0
      end
      object Lbl1: TppLabel
        Tag = 4
        UserName = 'Lbl1'
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 88816
        mmTop = 27517
        mmWidth = 16404
        BandType = 0
      end
      object InvTotLbl: TppLabel
        Tag = 3
        UserName = 'InvTotLbl'
        AutoSize = False
        Caption = 'Inv Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 72178
        mmTop = 27517
        mmWidth = 16087
        BandType = 0
      end
      object InvDateHdrLbl: TppLabel
        Tag = 2
        UserName = 'InvDateHdrLbl'
        AutoSize = False
        Caption = 'Inv Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3704
        mmLeft = 56134
        mmTop = 27517
        mmWidth = 15790
        BandType = 0
      end
      object InvNoHdrLbl: TppLabel
        Tag = 1
        UserName = 'InvNoHdrLbl'
        AutoSize = False
        Caption = 'Invoice No.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3704
        mmLeft = 31115
        mmTop = 27517
        mmWidth = 24553
        BandType = 0
      end
      object TitleLbl: TppLabel
        UserName = 'TitleLbl'
        AutoSize = False
        Caption = 'Weekly Purchase Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 0
        mmTop = 0
        mmWidth = 261673
        BandType = 0
      end
      object PrintedLbl: TppLabel
        UserName = 'PrintedLbl'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3556
        mmLeft = 221721
        mmTop = 0
        mmWidth = 9779
        BandType = 0
      end
      object SiteNameLbl: TppLabel
        UserName = 'SiteNameLbl'
        AutoSize = False
        Caption = 'SiteNameLbl'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5027
        mmLeft = 0
        mmTop = 6615
        mmWidth = 261673
        BandType = 0
      end
      object PeriodLbl: TppLabel
        UserName = 'PeriodLbl'
        Caption = 'Period:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 130440
        mmTop = 14552
        mmWidth = 10848
        BandType = 0
      end
      object DatesLbl: TppLabel
        UserName = 'DatesLbl'
        Caption = 'DatesLbl'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 129117
        mmTop = 18785
        mmWidth = 13494
        BandType = 0
      end
      object WklyPurchRepLine2: TppLine
        UserName = 'WklyPurchRepLine2'
        Weight = 0.75
        mmHeight = 529
        mmLeft = 0
        mmTop = 25400
        mmWidth = 261144
        BandType = 0
      end
      object WklyPurchRepLine3: TppLine
        UserName = 'WklyPurchRepLine3'
        Weight = 0.75
        mmHeight = 265
        mmLeft = 0
        mmTop = 32279
        mmWidth = 261144
        BandType = 0
      end
      object WklyPurchRepLine4: TppLine
        UserName = 'WklyPurchRepLine4'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 7027
        mmLeft = 260880
        mmTop = 25400
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine5: TppLine
        UserName = 'WklyPurchRepLine5'
        Position = lpRight
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 0
        mmTop = 25665
        mmWidth = 265
        BandType = 0
      end
      object WklyPurchRepLine7: TppLine
        UserName = 'WklyPurchRepLine7'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 155046
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine8: TppLine
        UserName = 'WklyPurchRepLine8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 171715
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine9: TppLine
        UserName = 'WklyPurchRepLine9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 188119
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine10: TppLine
        UserName = 'WklyPurchRepLine10'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 204788
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine11: TppLine
        UserName = 'WklyPurchRepLine11'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 221457
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine12: TppLine
        UserName = 'WklyPurchRepLine12'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 138377
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine13: TppLine
        UserName = 'WklyPurchRepLine13'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 121709
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine14: TppLine
        UserName = 'WklyPurchRepLine14'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 105304
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine15: TppLine
        UserName = 'WklyPurchRepLine15'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 88519
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine16: TppLine
        UserName = 'WklyPurchRepLine16'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 71882
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine17: TppLine
        UserName = 'WklyPurchRepLine17'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 55922
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object WklyPurchRepLine18: TppLine
        UserName = 'WklyPurchRepLine18'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6879
        mmLeft = 30861
        mmTop = 25665
        mmWidth = 3440
        BandType = 0
      end
      object ppVariable1: TppVariable
        UserName = 'Variable1'
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 84138
        mmTop = 11377
        mmWidth = 14288
        BandType = 0
      end
      object WklyPurchRepCalc1: TppSystemVariable
        UserName = 'WklyPurchRepCalc1'
        VarType = vtPrintDateTime
        DisplayFormat = 'mmm d, yyyy hh:nn:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3556
        mmLeft = 232569
        mmTop = 0
        mmWidth = 28998
        BandType = 0
      end
      object VendorHdrLbl: TppLabel
        UserName = 'VendorHdrLbl'
        AutoSize = False
        Caption = 'Vendor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        mmHeight = 3704
        mmLeft = 254
        mmTop = 27517
        mmWidth = 30607
        BandType = 0
      end
    end
    object WklyPurchRepDetailBand1: TppDetailBand
      BeforePrint = WklyPurchRepDetailBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 6350
      mmPrintPosition = 0
      object InvDateDBtxt: TppDBText
        Tag = 2
        UserName = 'InvDateDBtxt'
        Color = clNone
        DataField = 'Inv Date'
        DataPipeline = WklyPurchPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 56134
        mmTop = 1058
        mmWidth = 15790
        BandType = 4
      end
      object DBtxt8: TppDBText
        Tag = 11
        UserName = 'DBtxt8'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 205052
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object DBtxt7: TppDBText
        Tag = 10
        UserName = 'DBtxt7'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 188384
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object DBtxt5: TppDBText
        Tag = 8
        UserName = 'DBtxt5'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 155311
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object DBtxt4: TppDBText
        Tag = 7
        UserName = 'DBtxt4'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 138642
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object DBtxt6: TppDBText
        Tag = 9
        UserName = 'DBtxt6'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 171980
        mmTop = 1058
        mmWidth = 16140
        BandType = 4
      end
      object DBtxt3: TppDBText
        Tag = 6
        UserName = 'DBtxt3'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 121973
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object DBtxt2: TppDBText
        Tag = 5
        UserName = 'DBtxt2'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 105569
        mmTop = 1058
        mmWidth = 16140
        BandType = 4
      end
      object DBtxt1: TppDBText
        Tag = 4
        UserName = 'DBtxt1'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 88816
        mmTop = 1058
        mmWidth = 16404
        BandType = 4
      end
      object InvNoDBtxt: TppDBText
        Tag = 1
        UserName = 'InvNoDBtxt'
        CharWrap = True
        Color = clNone
        DataField = 'Invoice No.'
        DataPipeline = WklyPurchPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 31115
        mmTop = 1058
        mmWidth = 24553
        BandType = 4
      end
      object InvTotalDBtxt: TppDBText
        Tag = 3
        UserName = 'InvTotalDBtxt'
        Color = clNone
        DataField = 'Inv Total'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 72178
        mmTop = 1058
        mmWidth = 16087
        BandType = 4
      end
      object InvSupNameDBtxt: TppDBText
        UserName = 'InvSupNameDBtxt'
        OnGetText = InvSupNameDBtxtGetText
        Color = clNone
        DataField = 'Vendor'
        DataPipeline = WklyPurchPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 254
        mmTop = 1058
        mmWidth = 30607
        BandType = 4
      end
      object DBtxt11: TppDBText
        Tag = 14
        UserName = 'DBtxt11'
        DataField = 'C2'
        DataPipeline = WklyPurchPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 241565
        mmTop = 1058
        mmWidth = 6435
        BandType = 4
      end
      object DBtxt10: TppDBText
        Tag = 13
        UserName = 'DBtxt10'
        DataField = 'Others_Coded1'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 228600
        mmTop = 1058
        mmWidth = 12700
        BandType = 4
      end
      object DBtxt9: TppDBText
        Tag = 12
        UserName = 'DBtxt9'
        DataField = 'C1'
        DataPipeline = WklyPurchPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 221721
        mmTop = 1058
        mmWidth = 6435
        BandType = 4
      end
      object DBTxt12: TppDBText
        Tag = 15
        UserName = 'DBTxt12'
        DataField = 'Others_Coded2'
        DataPipeline = WklyPurchPipe
        DisplayFormat = '#0.00;-#0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'WklyPurchPipe'
        mmHeight = 4233
        mmLeft = 248180
        mmTop = 1058
        mmWidth = 12700
        BandType = 4
      end
      object WklyPurchRepLine1: TppLine
        UserName = 'WklyPurchRepLine1'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 265
        mmLeft = 0
        mmTop = 6085
        mmWidth = 261144
        BandType = 4
      end
      object WklyPurchRepLine19: TppLine
        UserName = 'WklyPurchRepLine19'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6350
        mmLeft = 260880
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object WklyPurchRepLine20: TppLine
        UserName = 'WklyPurchRepLine20'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 241300
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object Shape12: TppLine
        UserName = 'Shape12'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 221457
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape11: TppLine
        UserName = 'Shape11'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 204788
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape10: TppLine
        UserName = 'Shape10'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 188119
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape9: TppLine
        UserName = 'Shape9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 171715
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape8: TppLine
        UserName = 'Shape8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 155046
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape7: TppLine
        UserName = 'Shape7'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 138377
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape6: TppLine
        UserName = 'Shape6'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 121709
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape5: TppLine
        UserName = 'Shape5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 105304
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape4: TppLine
        UserName = 'Shape4'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 88519
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape3: TppLine
        UserName = 'Shape3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 71882
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape2: TppLine
        UserName = 'Shape2'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 55922
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object Shape1: TppLine
        UserName = 'Shape1'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 30861
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object WklyPurchRepLine33: TppLine
        UserName = 'WklyPurchRepLine33'
        Position = lpRight
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 0
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object WklyPurchRepLine34: TppLine
        UserName = 'WklyPurchRepLine34'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 247915
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object WklyPurchRepLine35: TppLine
        UserName = 'WklyPurchRepLine35'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 228336
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
    end
    object WklyPurchRepFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object WklyPurchRepCalc2: TppSystemVariable
        UserName = 'WklyPurchRepCalc2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 123296
        mmTop = 529
        mmWidth = 17463
        BandType = 8
      end
    end
    object WklyPurchRepSummaryBand1: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 28840
      mmPrintPosition = 0
      object WklyPurchRepSubReport1: TppSubReport
        UserName = 'WklyPurchRepSubReport1'
        ExpandAll = False
        NewPrintJob = False
        ParentPrinterSetup = False
        TraverseAllData = False
        DataPipelineName = 'CodeSmryPipe'
        mmHeight = 18521
        mmLeft = 0
        mmTop = 2381
        mmWidth = 261621
        BandType = 7
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object CodeSmrySub: TppChildReport
          AutoStop = False
          DataPipeline = CodeSmryPipe
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'WklyPurchRep'
          PrinterSetup.Orientation = poLandscape
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 12700
          PrinterSetup.mmMarginLeft = 5080
          PrinterSetup.mmMarginRight = 4318
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 215900
          PrinterSetup.mmPaperWidth = 279401
          PrinterSetup.PaperSize = 1
          Version = '6.03'
          mmColumnWidth = 0
          DataPipelineName = 'CodeSmryPipe'
          object CodeSmrySubTitleBand1: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 5556
            mmPrintPosition = 0
            object CodeSmrySubLabel1: TppLabel
              UserName = 'CodeSmrySubLabel1'
              Caption = 'Others Coded Summary'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 0
              mmTop = 529
              mmWidth = 39952
              BandType = 1
            end
          end
          object CodeSmrySubDetailBand1: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 5027
            mmPrintPosition = 0
            object CodeSmrySubShape1: TppShape
              UserName = 'CodeSmrySubShape1'
              Pen.Width = 2
              mmHeight = 5821
              mmLeft = 0
              mmTop = 0
              mmWidth = 232305
              BandType = 4
            end
            object S1lbl: TppDBText
              UserName = 'S1lbl'
              DataField = 'S1'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 794
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A1lbl: TppDBText
              UserName = 'A1lbl'
              DataField = 'A1'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 8731
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S2lbl: TppDBText
              UserName = 'S2lbl'
              DataField = 'S2'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 29898
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A2lbl: TppDBText
              UserName = 'A2lbl'
              DataField = 'A2'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 37835
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S3lbl: TppDBText
              UserName = 'S3lbl'
              DataField = 'S3'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 59002
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A3lbl: TppDBText
              UserName = 'A3lbl'
              DataField = 'A3'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 66940
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S4lbl: TppDBText
              UserName = 'S4lbl'
              DataField = 'S4'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 87842
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A4lbl: TppDBText
              UserName = 'A4lbl'
              DataField = 'A4'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 95779
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S5lbl: TppDBText
              UserName = 'S5lbl'
              DataField = 'S5'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 116946
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A5lbl: TppDBText
              UserName = 'A5lbl'
              DataField = 'A5'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 124884
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S6lbl: TppDBText
              UserName = 'S6lbl'
              DataField = 'S6'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 146050
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A6lbl: TppDBText
              UserName = 'A6lbl'
              DataField = 'A6'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 153988
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S7lbl: TppDBText
              UserName = 'S7lbl'
              DataField = 'S7'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 175155
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A7lbl: TppDBText
              UserName = 'A7lbl'
              DataField = 'A7'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 183092
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object S8lbl: TppDBText
              UserName = 'S8lbl'
              DataField = 'S8'
              DataPipeline = CodeSmryPipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 204788
              mmTop = 1323
              mmWidth = 6615
              BandType = 4
            end
            object A8lbl: TppDBText
              UserName = 'A8lbl'
              DataField = 'A8'
              DataPipeline = CodeSmryPipe
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'CodeSmryPipe'
              mmHeight = 3704
              mmLeft = 212990
              mmTop = 1323
              mmWidth = 18256
              BandType = 4
            end
            object CodeSmrySubLine1: TppLine
              UserName = 'CodeSmrySubLine1'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 27781
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine2: TppLine
              UserName = 'CodeSmrySubLine2'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 7673
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine3: TppLine
              UserName = 'CodeSmrySubLine3'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 36777
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine4: TppLine
              UserName = 'CodeSmrySubLine4'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 56886
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine5: TppLine
              UserName = 'CodeSmrySubLine5'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 65881
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine6: TppLine
              UserName = 'CodeSmrySubLine6'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 85990
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine7: TppLine
              UserName = 'CodeSmrySubLine7'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 94721
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine8: TppLine
              UserName = 'CodeSmrySubLine8'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 115094
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine9: TppLine
              UserName = 'CodeSmrySubLine9'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 123825
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine10: TppLine
              UserName = 'CodeSmrySubLine10'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 144198
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine11: TppLine
              UserName = 'CodeSmrySubLine11'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 152929
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine12: TppLine
              UserName = 'CodeSmrySubLine12'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5027
              mmLeft = 173302
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine13: TppLine
              UserName = 'CodeSmrySubLine13'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 182034
              mmTop = 0
              mmWidth = 4233
              BandType = 4
            end
            object CodeSmrySubLine14: TppLine
              UserName = 'CodeSmrySubLine14'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5556
              mmLeft = 202671
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
            object CodeSmrySubLine15: TppLine
              UserName = 'CodeSmrySubLine15'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 5556
              mmLeft = 211932
              mmTop = 0
              mmWidth = 3969
              BandType = 4
            end
          end
        end
      end
    end
  end
  object OthersSmryDS: TwwDataSource
    DataSet = OthersSmryQry2
    Left = 100
    Top = 135
  end
  object CodeSmryPipe: TppBDEPipeline
    DataSource = CodeSmryDS
    UserName = 'CodeSmryPipe'
    Left = 183
    Top = 68
  end
  object CodeSmryDS: TwwDataSource
    DataSet = otherssmry2TBL
    Left = 101
    Top = 68
  end
  object QGetPurchHdr: TADOQuery
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
      'select       [supplier name] as "Vendor",'
      '                [date] as "Inv Date",'
      '                [delivery note no.] as "Invoice No.",'
      #9'Convert(float, [total amount]) as "Inv Total"'
      'from accpurhd'
      'where [date] >= :startdate'
      'and [date] <= :enddate')
    Left = 24
    Top = 336
  end
  object QWeeks: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 24
    Top = 392
  end
  object QGetCurrPurchHdr: TADOQuery
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
      'select       a.[site code], a.[supplier name] as "Vendor",'
      '                a.[delivery note no.] as "Invoice No.",'
      '                a.[date] as "Inv Date",'
      '                sum(b.[total cost]) as "Inv Total"'
      'from '#9'purchhdr a, purchase b'
      'where '#9'a.[date] >= :startdate'
      'and '#9'a.[date] <= :enddate'
      'and a.[deleted] is NULL'
      'and b.[site code] = a.[site code]'
      'and b.[supplier name] = a.[supplier name]'
      'and b.[delivery note no.] = a.[delivery note no.]'
      
        'group by a.[site code], a.[supplier name], a.[delivery note no.]' +
        ', a.[date]')
    Left = 24
    Top = 456
  end
  object PconfigsTbl: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PConfigs'
    Left = 24
    Top = 208
  end
  object wwCodeCatsTbl: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'CodeCats'
    Left = 24
    Top = 256
  end
  object wwFixedCatsTbl: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'FixCats'
    Left = 104
    Top = 208
  end
  object wwCodeSubsTbl: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'CodeSubs'
    Left = 104
    Top = 256
  end
  object QAlter: TADOQuery
    Connection = dmADO.AztecConn
    ParamCheck = False
    Parameters = <>
    Left = 112
    Top = 344
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 112
    Top = 400
  end
  object wwQCodedCats: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'Invoice'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'Vendor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'Select '#9'Vendor,'
      #9'[invoice no.],'
      '                [Date],'
      #9'[total cost],'#9
      '                [category name],'
      #9'Code'
      ''
      'From CodeSubs'
      'Where [Invoice no.] = :Invoice and [Vendor] = :Vendor'
      'Order By  Code')
    Left = 112
    Top = 456
  end
  object QWklyTots: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 200
    Top = 344
  end
  object QGetInvCatSubTots: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 200
    Top = 400
  end
  object TblWklyPurch: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'WklyPurch'
    Left = 16
    Top = 19
  end
  object otherssmry2TBL: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'OthCsmry2'
    Left = 16
    Top = 72
  end
  object otherssmryTBL: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'OthCsmry'
    Left = 184
    Top = 208
  end
  object OthersSmryQry2: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT Code, SUM(Amount) as Total'
      'FROM OthCsmry'
      'WHERE Code IS NOT NULL'
      'AND Amount <> 0'
      'GROUP BY Code'
      'ORDER BY Code')
    Left = 16
    Top = 136
  end
  object OthersSmryQry1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT convert(varchar (2), a.C1) AS "Code", Convert(float, SUM(' +
        'a.Others_Coded1)) as "Amount"'
      'FROM wklypurch a'
      'WHERE a.C1 IS NOT NULL'
      'GROUP BY a.C1'
      ''
      'UNION ALL'
      ''
      
        'SELECT convert(varchar (2), b.C2), Convert(float, SUM(b.Others_C' +
        'oded2))'
      'FROM wklypurch b'
      'WHERE b.C2 IS NOT NULL'
      'GROUP BY b.C2'
      'ORDER BY convert(varchar (2), a.C1)')
    Left = 200
    Top = 456
  end
  object QWklyPrchOrd: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 288
    Top = 344
  end
  object qryWklyPurch: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM WklyPurch')
    Left = 342
    Top = 18
  end
end
