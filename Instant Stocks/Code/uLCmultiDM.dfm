object LCmultiDM: TLCmultiDM
  OldCreateOrder = False
  Left = 423
  Top = 221
  Height = 157
  Width = 397
  object adoqMLCMaster: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT SubCatName, EntityCode, PurchaseName, PurchUnit,'
      ' SUM(sq * cumVar) as totSQ, SUM(dq * cumVar) as totDQ,'
      ' SUM(theVar * cumVar) as totVar, SUM(wq * cumVar) as totWQ,'
      '  (CASE'
      '    WHEN (SUM(ActRedQty * cumVar) = 0) THEN NULL'
      
        '    ELSE (SUM(Variance * cumVar) / SUM(ActRedQty * cumVar) * 100' +
        ')'
      '  END) as spc,'
      '  (CASE'
      '    WHEN (SUM(ActRedQty * cumVar) = 0) THEN NULL'
      '    ELSE (SUM(Wastage * cumVar) / SUM(ActRedQty * cumVar) * 100)'
      '  END) as wpc,'
      '  count(entitycode) as LCmany'
      'FROM stkMLCghost'
      'GROUP BY SubCatName, EntityCode, PurchaseName, PurchUnit'
      'ORDER BY SubCatName, PurchaseName, PurchUnit')
    Left = 32
    Top = 8
  end
  object dsMLCMaster: TwwDataSource
    DataSet = adoqMLCMaster
    Left = 112
    Top = 8
  end
  object pipeMLCMaster: TppDBPipeline
    DataSource = dsMLCMaster
    UserName = 'pipeMLCMaster'
    Left = 192
    Top = 8
  end
  object adoqMLCSlave: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsMLCMaster
    Parameters = <
      item
        Name = 'entitycode'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Value = 10000000008
      end>
    SQL.Strings = (
      
        'SELECT baseDT, LCDT, sq, dq, spc, wq, wpc, checkCount, cumVar, c' +
        'onsumed'
      'from stkMLCghost'
      'where entitycode = :entitycode'
      'order by baseDT, LCDT')
    Left = 32
    Top = 56
  end
  object dsMLCSlave: TwwDataSource
    DataSet = adoqMLCSlave
    Left = 112
    Top = 56
  end
  object pipeMLCSlave: TppDBPipeline
    DataSource = dsMLCSlave
    UserName = 'pipeMLCSlave'
    Left = 192
    Top = 56
    MasterDataPipelineName = 'pipeMLCMaster'
  end
  object repMLC: TppReport
    AutoStop = False
    DataPipeline = pipeMLCMaster
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = repMLCPreviewFormCreate
    Left = 264
    Top = 32
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeMLCMaster'
    object ppHeaderBand2: TppHeaderBand
      BeforePrint = ppHeaderBand2BeforePrint
      mmBottomOffset = 0
      mmHeight = 30427
      mmPrintPosition = 0
      object ppShape5: TppShape
        UserName = 'Shape5'
        Brush.Color = clYellow
        mmHeight = 3969
        mmLeft = 17727
        mmTop = 25665
        mmWidth = 18785
        BandType = 0
      end
      object ppLabel43: TppLabel
        UserName = 'Label43'
        Caption = 'Click on the  Yellow Area  to view/hide individual Line Checks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 25665
        mmWidth = 86741
        BandType = 0
      end
      object ppShape2: TppShape
        UserName = 'Shape2'
        mmHeight = 7408
        mmLeft = 49477
        mmTop = 3175
        mmWidth = 106627
        BandType = 0
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        AutoSize = False
        Caption = 'Cumulative Line Check Variance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5842
        mmLeft = 50271
        mmTop = 3969
        mmWidth = 104775
        BandType = 0
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        AutoSize = False
        Caption = 'Area Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3895
        mmLeft = 265
        mmTop = 3175
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'Site Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 7673
        mmWidth = 16140
        BandType = 0
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        AutoSize = False
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 12171
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel23: TppLabel
        UserName = 'ppHoldRepLabel102'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 157427
        mmTop = 8467
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 177536
        mmTop = 3969
        mmWidth = 16404
        BandType = 0
      end
      object ppLabel27: TppLabel
        UserName = 'Label27'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 529
        mmTop = 20108
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel30: TppLabel
        UserName = 'Label30'
        AutoSize = False
        Caption = 'From: 33/33/3333 33:33:33 -- To 33/33/3333 33:33:33 '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 50006
        mmTop = 11113
        mmWidth = 105040
        BandType = 0
      end
      object ppDBText28: TppDBText
        UserName = 'DBText28'
        DataField = 'Area Name'
        DataPipeline = data1.areaPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'areaPipe'
        mmHeight = 3704
        mmLeft = 18256
        mmTop = 3175
        mmWidth = 30692
        BandType = 0
      end
      object ppDBText29: TppDBText
        UserName = 'DBText29'
        DataField = 'Site Name'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 16933
        mmTop = 7673
        mmWidth = 31750
        BandType = 0
      end
      object ppDBText30: TppDBText
        UserName = 'DBText401'
        DataField = 'Site Manager'
        DataPipeline = data1.sitePipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'sitePipe'
        mmHeight = 3704
        mmLeft = 14552
        mmTop = 12171
        mmWidth = 33867
        BandType = 0
      end
      object ppSystemVariable4: TppSystemVariable
        UserName = 'SystemVariable4'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 168011
        mmTop = 8467
        mmWidth = 25929
        BandType = 0
      end
      object ppLine4: TppLine
        UserName = 'Line701'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 23283
        mmWidth = 193940
        BandType = 0
      end
      object ppLabel31: TppLabel
        UserName = 'Label31'
        Caption = 'Thread Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 138907
        mmTop = 20108
        mmWidth = 55033
        BandType = 0
      end
      object ppLabel32: TppLabel
        UserName = 'Label32'
        Caption = 'Header:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 182563
        mmTop = 12700
        mmWidth = 11377
        BandType = 0
      end
      object ppLabel22: TppLabel
        UserName = 'Label301'
        AutoSize = False
        Caption = 'Period 55/55 -- Line Checks involved: 333'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 50006
        mmTop = 15346
        mmWidth = 105040
        BandType = 0
      end
      object ppLabel53: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Expand All'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 100806
        mmTop = 25665
        mmWidth = 17727
        BandType = 0
      end
      object ppShape6: TppShape
        UserName = 'Shape6'
        Brush.Color = clBlue
        OnDrawCommandClick = ppShape6DrawCommandClick
        mmHeight = 4233
        mmLeft = 117740
        mmTop = 25400
        mmWidth = 10054
        BandType = 0
      end
      object ppLabel54: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Collapse All'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 131234
        mmTop = 25665
        mmWidth = 18256
        BandType = 0
      end
      object ppShape7: TppShape
        UserName = 'Shape7'
        Brush.Color = clRed
        OnDrawCommandClick = ppShape7DrawCommandClick
        mmHeight = 4233
        mmLeft = 149754
        mmTop = 25400
        mmWidth = 10054
        BandType = 0
      end
    end
    object ppDetailBand2: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 10054
      mmPrintPosition = 0
      object ppRegion1: TppRegion
        OnPrint = ppRegion1Print
        UserName = 'Region1'
        Brush.Color = clYellow
        Pen.Style = psClear
        mmHeight = 5292
        mmLeft = 265
        mmTop = 0
        mmWidth = 73025
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'PurchaseName'
        DataPipeline = pipeMLCMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3810
        mmLeft = 1058
        mmTop = 794
        mmWidth = 34396
        BandType = 4
      end
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        DrillDownComponent = ppRegion1
        ExpandAll = False
        NewPrintJob = False
        TraverseAllData = False
        DataPipelineName = 'pipeMLCSlave'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 5027
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = pipeMLCSlave
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Version = '6.03'
          mmColumnWidth = 0
          DataPipelineName = 'pipeMLCSlave'
          object ppTitleBand1: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 5588
            mmPrintPosition = 0
            object ppLabel52: TppLabel
              UserName = 'Label52'
              AutoSize = False
              Caption = 'Chck Count'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 153988
              mmTop = 1852
              mmWidth = 18521
              BandType = 1
            end
            object ppLabel44: TppLabel
              UserName = 'Label44'
              AutoSize = False
              Caption = 'Surplus'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 68792
              mmTop = 1852
              mmWidth = 18521
              BandType = 1
            end
            object ppLabel45: TppLabel
              UserName = 'Label45'
              AutoSize = False
              Caption = 'Deficit'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 88636
              mmTop = 1852
              mmWidth = 18521
              BandType = 1
            end
            object ppLabel47: TppLabel
              UserName = 'Label47'
              AutoSize = False
              Caption = 'Var. %'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 108215
              mmTop = 1852
              mmWidth = 11377
              BandType = 1
            end
            object ppLabel48: TppLabel
              UserName = 'Label401'
              AutoSize = False
              Caption = 'Wastage'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 120915
              mmTop = 1852
              mmWidth = 18521
              BandType = 1
            end
            object ppLabel49: TppLabel
              UserName = 'Label49'
              AutoSize = False
              Caption = 'Waste %'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 140229
              mmTop = 1852
              mmWidth = 13229
              BandType = 1
            end
            object ppLine47: TppLine
              UserName = 'Line47'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 68263
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine48: TppLine
              UserName = 'Line48'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 87842
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine49: TppLine
              UserName = 'Line49'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 107421
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine51: TppLine
              UserName = 'Line51'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 120121
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine52: TppLine
              UserName = 'Line52'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 139965
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine53: TppLine
              UserName = 'Line302'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 4233
              mmLeft = 171186
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine50: TppLine
              UserName = 'Line50'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 153459
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLabel50: TppLabel
              UserName = 'Label502'
              AutoSize = False
              Caption = 'Check Date/Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 40746
              mmTop = 1852
              mmWidth = 26723
              BandType = 1
            end
            object ppLine54: TppLine
              UserName = 'Line54'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 39952
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLabel51: TppLabel
              UserName = 'Label1'
              AutoSize = False
              Caption = 'Base Stk Date/Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 10583
              mmTop = 1852
              mmWidth = 28840
              BandType = 1
            end
            object ppLine56: TppLine
              UserName = 'Line56'
              Pen.Width = 2
              Position = lpBottom
              Weight = 1.5
              mmHeight = 1323
              mmLeft = 10054
              mmTop = 4763
              mmWidth = 182034
              BandType = 1
            end
            object ppLine57: TppLine
              UserName = 'Line57'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 1323
              mmLeft = 10054
              mmTop = 1588
              mmWidth = 182034
              BandType = 1
            end
            object ppLine58: TppLine
              UserName = 'Line58'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 4233
              mmLeft = 9790
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
            object ppLine82: TppLine
              UserName = 'Line82'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 5821
              mmLeft = 0
              mmTop = 0
              mmWidth = 1852
              BandType = 1
            end
            object ppLine94: TppLine
              UserName = 'Line94'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 5821
              mmLeft = 192352
              mmTop = 0
              mmWidth = 1852
              BandType = 1
            end
            object ppLabel1: TppLabel
              UserName = 'Label2'
              AutoSize = False
              Caption = 'Consumed'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              WordWrap = True
              mmHeight = 3704
              mmLeft = 173302
              mmTop = 1852
              mmWidth = 18521
              BandType = 1
            end
            object ppLine1: TppLine
              UserName = 'Line1'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 4233
              mmLeft = 190500
              mmTop = 1588
              mmWidth = 1852
              BandType = 1
            end
          end
          object ppDetailBand4: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 4107
            mmPrintPosition = 0
            object ppDBText7: TppDBText
              UserName = 'DBText7'
              DataField = 'LCDT'
              DataPipeline = pipeMLCSlave
              DisplayFormat = 'ddddd tt'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              ParentDataPipeline = False
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 40746
              mmTop = 529
              mmWidth = 26723
              BandType = 4
            end
            object ppDBText8: TppDBText
              OnPrint = ppDBText8Print
              UserName = 'DBText8'
              OnGetText = ppDBText8GetText
              DataField = 'sq'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              ParentDataPipeline = False
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 68527
              mmTop = 529
              mmWidth = 18521
              BandType = 4
            end
            object ppDBText22: TppDBText
              OnPrint = ppDBText8Print
              UserName = 'DBText22'
              OnGetText = ppDBText8GetText
              DataField = 'dq'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 88371
              mmTop = 529
              mmWidth = 18521
              BandType = 4
            end
            object ppDBText23: TppDBText
              UserName = 'DBText23'
              DataField = 'spc'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 107686
              mmTop = 529
              mmWidth = 11642
              BandType = 4
            end
            object ppDBText24: TppDBText
              OnPrint = ppDBText8Print
              UserName = 'DBText24'
              OnGetText = ppDBText8GetText
              DataField = 'wq'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 120650
              mmTop = 529
              mmWidth = 18521
              BandType = 4
            end
            object ppDBText25: TppDBText
              UserName = 'DBText25'
              DataField = 'wpc'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 140229
              mmTop = 529
              mmWidth = 12435
              BandType = 4
            end
            object ppDBText26: TppDBText
              OnPrint = ppDBText8Print
              UserName = 'DBText26'
              OnGetText = ppDBText8GetText
              DataField = 'checkCount'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 153988
              mmTop = 529
              mmWidth = 17992
              BandType = 4
            end
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              DataField = 'baseDT'
              DataPipeline = pipeMLCSlave
              DisplayFormat = 'ddddd tt'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 10583
              mmTop = 529
              mmWidth = 28840
              BandType = 4
            end
            object ppLine59: TppLine
              UserName = 'Line59'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1323
              mmLeft = 39952
              mmTop = 3175
              mmWidth = 152400
              BandType = 4
            end
            object ppLine60: TppLine
              UserName = 'Line60'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 4233
              mmLeft = 9790
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine61: TppLine
              UserName = 'Line61'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 39952
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine67: TppLine
              UserName = 'Line67'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 68263
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine68: TppLine
              UserName = 'Line68'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 87842
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine69: TppLine
              UserName = 'Line69'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 107421
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine70: TppLine
              UserName = 'Line702'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 120121
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine71: TppLine
              UserName = 'Line71'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 139965
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine73: TppLine
              UserName = 'Line501'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 4233
              mmLeft = 153459
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine80: TppLine
              UserName = 'Line80'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 4233
              mmLeft = 171186
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine83: TppLine
              UserName = 'Line601'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 4498
              mmLeft = 0
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine93: TppLine
              UserName = 'Line93'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 4498
              mmLeft = 192352
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppDBText1: TppDBText
              OnPrint = ppDBText8Print
              UserName = 'DBText1'
              OnGetText = ppDBText8GetText
              DataField = 'consumed'
              DataPipeline = pipeMLCSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeMLCSlave'
              mmHeight = 3175
              mmLeft = 173302
              mmTop = 529
              mmWidth = 17992
              BandType = 4
            end
            object ppLine2: TppLine
              UserName = 'Line801'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 4498
              mmLeft = 190500
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
          end
          object ppSummaryBand2: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 2117
            mmPrintPosition = 0
            object ppLine81: TppLine
              UserName = 'Line81'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 2108
              mmLeft = 0
              mmTop = 0
              mmWidth = 194205
              BandType = 7
            end
            object ppLine88: TppLine
              UserName = 'Line88'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 2108
              mmLeft = 0
              mmTop = 0
              mmWidth = 1852
              BandType = 7
            end
            object ppLine89: TppLine
              UserName = 'Line89'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 2117
              mmLeft = 192352
              mmTop = 0
              mmWidth = 1852
              BandType = 7
            end
          end
          object ppGroup2: TppGroup
            BreakName = 'baseDT'
            DataPipeline = pipeMLCSlave
            KeepTogether = True
            UserName = 'Group1'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'pipeMLCSlave'
            object ppGroupHeaderBand2: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroupFooterBand2: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 265
              mmPrintPosition = 0
              object ppLine46: TppLine
                UserName = 'Line46'
                Pen.Width = 2
                Weight = 1.5
                mmHeight = 265
                mmLeft = 9790
                mmTop = 0
                mmWidth = 182563
                BandType = 5
                GroupNo = 0
              end
            end
          end
        end
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        DataField = 'PurchUnit'
        DataPipeline = pipeMLCMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3810
        mmLeft = 36513
        mmTop = 794
        mmWidth = 21167
        BandType = 4
      end
      object ppDBText14: TppDBText
        UserName = 'DBText14'
        DataField = 'LCmany'
        DataPipeline = pipeMLCMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 58738
        mmTop = 794
        mmWidth = 9790
        BandType = 4
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        OnGetText = ppDBText15GetText
        DataField = 'totSQ'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 74083
        mmTop = 794
        mmWidth = 21167
        BandType = 4
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        OnGetText = ppDBText15GetText
        DataField = 'totDQ'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 97102
        mmTop = 794
        mmWidth = 21167
        BandType = 4
      end
      object ppDBText17: TppDBText
        UserName = 'DBText17'
        OnGetText = ppDBText15GetText
        DataField = 'totVar'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 119063
        mmTop = 794
        mmWidth = 21431
        BandType = 4
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        DataField = 'spc'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 142082
        mmTop = 794
        mmWidth = 13758
        BandType = 4
      end
      object ppDBText19: TppDBText
        UserName = 'DBText19'
        OnGetText = ppDBText15GetText
        DataField = 'totWQ'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 156898
        mmTop = 794
        mmWidth = 20902
        BandType = 4
      end
      object ppDBText21: TppDBText
        UserName = 'DBText21'
        DataField = 'wpc'
        DataPipeline = pipeMLCMaster
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeMLCMaster'
        mmHeight = 3704
        mmLeft = 179123
        mmTop = 794
        mmWidth = 13758
        BandType = 4
      end
      object ppLine35: TppLine
        UserName = 'Line35'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 0
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine36: TppLine
        UserName = 'Line36'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 35719
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine37: TppLine
        UserName = 'Line37'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 57679
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine38: TppLine
        UserName = 'Line38'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 73025
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine39: TppLine
        UserName = 'Line39'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 96044
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine40: TppLine
        UserName = 'Line40'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 118534
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine41: TppLine
        UserName = 'Line41'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 141023
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine42: TppLine
        UserName = 'Line42'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 156369
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine43: TppLine
        UserName = 'Line43'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5292
        mmLeft = 178330
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine44: TppLine
        UserName = 'Line301'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 5292
        mmLeft = 192352
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine45: TppLine
        UserName = 'Line45'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 0
        mmTop = 3704
        mmWidth = 194205
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 1852
      mmPrintPosition = 0
    end
    object ppGroup4: TppGroup
      BreakName = 'SubCatName'
      DataPipeline = pipeMLCMaster
      UserName = 'Group4'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipeMLCMaster'
      object ppGroupHeaderBand4: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 11642
        mmPrintPosition = 0
        object ppDBText31: TppDBText
          UserName = 'DBText31'
          DataField = 'SubCatName'
          DataPipeline = pipeMLCMaster
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          WordWrap = True
          DataPipelineName = 'pipeMLCMaster'
          mmHeight = 4233
          mmLeft = 2117
          mmTop = 1852
          mmWidth = 46038
          BandType = 3
          GroupNo = 0
        end
        object ppLabel33: TppLabel
          UserName = 'Label33'
          AutoSize = False
          Caption = 'Purchase Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 2910
          mmTop = 7408
          mmWidth = 26723
          BandType = 3
          GroupNo = 0
        end
        object ppLabel34: TppLabel
          UserName = 'Label34'
          AutoSize = False
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 38100
          mmTop = 7408
          mmWidth = 15610
          BandType = 3
          GroupNo = 0
        end
        object ppLabel36: TppLabel
          UserName = 'Label36'
          AutoSize = False
          Caption = 'Var. %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 141552
          mmTop = 7408
          mmWidth = 14288
          BandType = 3
          GroupNo = 0
        end
        object ppLine5: TppLine
          UserName = 'Line5'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 0
          mmTop = 4763
          mmWidth = 194205
          BandType = 3
          GroupNo = 0
        end
        object ppLine9: TppLine
          UserName = 'Line9'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1323
          mmLeft = 0
          mmTop = 10319
          mmWidth = 194205
          BandType = 3
          GroupNo = 0
        end
        object ppLine14: TppLine
          UserName = 'Line14'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 794
          mmLeft = 0
          mmTop = 1323
          mmWidth = 52917
          BandType = 3
          GroupNo = 0
        end
        object ppLine23: TppLine
          UserName = 'Line23'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 11113
          mmLeft = 0
          mmTop = 1323
          mmWidth = 3440
          BandType = 3
          GroupNo = 0
        end
        object ppLine25: TppLine
          UserName = 'Line25'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 35719
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine26: TppLine
          UserName = 'Line26'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 4763
          mmLeft = 52917
          mmTop = 1323
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine27: TppLine
          UserName = 'Line27'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 96044
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine28: TppLine
          UserName = 'ppHoldRepLine201'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 141023
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine29: TppLine
          UserName = 'Line29'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 156369
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine30: TppLine
          UserName = 'Line30'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 192352
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel37: TppLabel
          UserName = 'Label37'
          AutoSize = False
          Caption = 'Surplus'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 74083
          mmTop = 7408
          mmWidth = 21167
          BandType = 3
          GroupNo = 0
        end
        object ppLabel38: TppLabel
          UserName = 'Label38'
          AutoSize = False
          Caption = 'Deficit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 97102
          mmTop = 7408
          mmWidth = 21167
          BandType = 3
          GroupNo = 0
        end
        object ppLabel39: TppLabel
          UserName = 'Label501'
          AutoSize = False
          Caption = 'Waste %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 179123
          mmTop = 7408
          mmWidth = 14288
          BandType = 3
          GroupNo = 0
        end
        object ppLabel40: TppLabel
          UserName = 'Label40'
          AutoSize = False
          Caption = 'Wastage'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 156898
          mmTop = 7408
          mmWidth = 21167
          BandType = 3
          GroupNo = 0
        end
        object ppLine32: TppLine
          UserName = 'Line32'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 178330
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine33: TppLine
          UserName = 'Line33'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 118534
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel41: TppLabel
          UserName = 'Label41'
          AutoSize = False
          Caption = 'Tot. Variance'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 118798
          mmTop = 7408
          mmWidth = 22225
          BandType = 3
          GroupNo = 0
        end
        object ppLine34: TppLine
          UserName = 'Line34'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 73025
          mmTop = 6085
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel42: TppLabel
          UserName = 'Label42'
          AutoSize = False
          Caption = 'Checks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 4233
          mmLeft = 58208
          mmTop = 7408
          mmWidth = 14552
          BandType = 3
          GroupNo = 0
        end
        object ppLine95: TppLine
          UserName = 'Line95'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 57679
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand4: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 1323
        mmPrintPosition = 0
        object ppLine96: TppLine
          UserName = 'Line96'
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 0
          mmTop = 0
          mmWidth = 194205
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
end
