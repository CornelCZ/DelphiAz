object fAlliant: TfAlliant
  Left = 263
  Top = 215
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Import Invoices'
  ClientHeight = 374
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 51
    Height = 19
    Caption = 'Label1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 2
    Top = 255
    Width = 425
    Height = 66
    AutoSize = False
    Caption = 
      'At least one item from at least one invoice could not be matched' +
      '! Click on "Print Unmatched" to get a listing of all unmatched i' +
      'tems.'
    Color = clRed
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 3
    Width = 433
    Height = 319
    TabOrder = 5
    Visible = False
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 431
      Height = 48
      Align = alTop
      AutoSize = False
    end
    object Label4: TLabel
      Left = 1
      Top = 49
      Width = 431
      Height = 56
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Please Wait!'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -30
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 1
      Top = 105
      Width = 431
      Height = 35
      Align = alTop
      Alignment = taCenter
      Caption = 'Processing Invoice Files...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -30
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 1
      Top = 302
      Width = 431
      Height = 16
      Align = alBottom
    end
    object Label7: TLabel
      Left = 1
      Top = 286
      Width = 431
      Height = 16
      Align = alBottom
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object FileBox: TFileListBox
    Left = 80
    Top = 344
    Width = 145
    Height = 25
    ItemHeight = 16
    TabOrder = 0
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 152
    Top = 328
    Width = 127
    Height = 42
    Caption = 'Do Import'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 40
    Width = 401
    Height = 89
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
  end
  object wwgAlliaFil: TwwDBGrid
    Left = 8
    Top = 136
    Width = 415
    Height = 113
    Selected.Strings = (
      'InvNo'#9'9'#9'Invoice No'
      'InvDate'#9'10'#9'Invoice Date'
      'Matched'#9'8'#9'Matched'
      'Unmch'#9'10'#9'Unmatched'
      'TotProd'#9'7'#9'Total'
      'Credit'#9'2'#9'Inv Type')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwsAlliaFil
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 3
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
  object BitBtn2: TBitBtn
    Left = 11
    Top = 328
    Width = 124
    Height = 42
    Caption = 'Print Unmatched'
    TabOrder = 4
    Visible = False
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 299
    Top = 328
    Width = 124
    Height = 42
    Caption = 'Close'
    TabOrder = 6
    OnClick = BitBtn3Click
    Kind = bkCancel
  end
  object bbtErrRpt: TBitBtn
    Left = 163
    Top = 328
    Width = 124
    Height = 42
    Caption = 'Error Report'
    TabOrder = 7
    Visible = False
    OnClick = bbtErrRptClick
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = AlliaInvPipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppReport1'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppReport1PreviewFormCreate
    Left = 291
    Top = 8
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'AlliaInvPipe'
    object ppReport1TitleBand1: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 8467
      mmPrintPosition = 0
      object ppRepLabel21: TppLabel
        UserName = 'ppRepLabel21'
        SaveOrder = 0
        Save = True
        Caption = 'Print date-time:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3387
        mmLeft = 6773
        mmTop = 847
        mmWidth = 18838
        BandType = 1
      end
      object ppRepLabel22: TppLabel
        UserName = 'ppRepLabel22'
        SaveOrder = 1
        Save = True
        Caption = 'No. of pages:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3387
        mmLeft = 175895
        mmTop = 847
        mmWidth = 16298
        BandType = 1
      end
      object ppReport1Label15: TppLabel
        UserName = 'ppReport1Label15'
        Caption = 'Unmatched Items from US Foods Invoices'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5080
        mmLeft = 63288
        mmTop = 2117
        mmWidth = 76623
        BandType = 1
      end
      object ppRepCalc1: TppSystemVariable
        UserName = 'RepCalc1'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3440
        mmLeft = 26988
        mmTop = 794
        mmWidth = 21960
        BandType = 1
      end
      object ppRepCalc2: TppSystemVariable
        UserName = 'RepCalc2'
        VarType = vtPageCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3440
        mmLeft = 193940
        mmTop = 794
        mmWidth = 1588
        BandType = 1
      end
    end
    object ppReport1HeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppReport1DetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4657
      mmPrintPosition = 0
      object ppReport1Line3: TppLine
        UserName = 'ppReport1Line3'
        Position = lpBottom
        Weight = 0.600000023841858
        mmHeight = 1482
        mmLeft = 2540
        mmTop = 3387
        mmWidth = 196215
        BandType = 4
      end
      object ppReport1DBText3: TppDBText
        UserName = 'ppReport1DBText3'
        DataField = 'ACode'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 11642
        mmTop = 635
        mmWidth = 11853
        BandType = 4
      end
      object ppReport1DBText4: TppDBText
        UserName = 'ppReport1DBText4'
        DataField = 'AName'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 24765
        mmTop = 635
        mmWidth = 58208
        BandType = 4
      end
      object ppReport1DBText5: TppDBText
        UserName = 'ppReport1DBText5'
        DataField = 'ASUnit'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 84455
        mmTop = 635
        mmWidth = 12065
        BandType = 4
      end
      object ppReport1DBText6: TppDBText
        UserName = 'ppReport1DBText6'
        DataField = 'APUnit'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 98002
        mmTop = 635
        mmWidth = 11007
        BandType = 4
      end
      object ppReport1DBText7: TppDBText
        UserName = 'ppReport1DBText7'
        DataField = 'AUnitQ'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 110702
        mmTop = 635
        mmWidth = 7832
        BandType = 4
      end
      object ppReport1DBText8: TppDBText
        UserName = 'ppReport1DBText8'
        DataField = 'AEachQ'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 119804
        mmTop = 635
        mmWidth = 8678
        BandType = 4
      end
      object ppReport1DBText9: TppDBText
        UserName = 'ppReport1DBText9'
        DataField = 'AWeight'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 129540
        mmTop = 635
        mmWidth = 11218
        BandType = 4
      end
      object ppReport1DBText10: TppDBText
        UserName = 'ppReport1DBText10'
        DataField = 'ACostUnit'
        DataPipeline = AlliaInvPipe
        DisplayFormat = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 141605
        mmTop = 635
        mmWidth = 11642
        BandType = 4
      end
      object ppReport1DBText11: TppDBText
        UserName = 'ppReport1DBText11'
        DataField = 'ACostEach'
        DataPipeline = AlliaInvPipe
        DisplayFormat = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 154517
        mmTop = 635
        mmWidth = 12277
        BandType = 4
      end
      object ppReport1DBText12: TppDBText
        UserName = 'ppReport1DBText12'
        DataField = 'ATotalCost'
        DataPipeline = AlliaInvPipe
        DisplayFormat = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 167640
        mmTop = 635
        mmWidth = 18203
        BandType = 4
      end
      object ppReport1Line5: TppLine
        UserName = 'ppReport1Line5'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.20000004768372
        mmHeight = 4657
        mmLeft = 2540
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line6: TppLine
        UserName = 'ppReport1Line6'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 24130
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line7: TppLine
        UserName = 'ppReport1Line7'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 83609
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line8: TppLine
        UserName = 'ppReport1Line8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 97155
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line9: TppLine
        UserName = 'ppReport1Line9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 110279
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line10: TppLine
        UserName = 'ppReport1Line10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 118957
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line11: TppLine
        UserName = 'ppReport1Line11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 128905
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line12: TppLine
        UserName = 'ppReport1Line12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 141182
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line13: TppLine
        UserName = 'ppReport1Line13'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 153670
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line14: TppLine
        UserName = 'ppReport1Line14'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 167217
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1Line28: TppLine
        UserName = 'ppReport1Line28'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.20000004768372
        mmHeight = 4657
        mmLeft = 197062
        mmTop = 0
        mmWidth = 1693
        BandType = 4
      end
      object ppReport1Line31: TppLine
        UserName = 'ppReport1Line31'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 10795
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1DBText13: TppDBText
        UserName = 'ppReport1DBText13'
        DataField = 'RecNo'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 3387
        mmTop = 635
        mmWidth = 6773
        BandType = 4
      end
      object ppReport1Line33: TppLine
        UserName = 'ppReport1Line33'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 4657
        mmLeft = 186267
        mmTop = 0
        mmWidth = 2328
        BandType = 4
      end
      object ppReport1DBText14: TppDBText
        UserName = 'ppReport1DBText14'
        DataField = 'Reason'
        DataPipeline = AlliaInvPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'AlliaInvPipe'
        mmHeight = 3387
        mmLeft = 187537
        mmTop = 635
        mmWidth = 8043
        BandType = 4
      end
    end
    object ppReport1FooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 4022
      mmPrintPosition = 0
      object ppReport1Calc1: TppSystemVariable
        UserName = 'Report1Calc1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3440
        mmLeft = 183621
        mmTop = 265
        mmWidth = 14023
        BandType = 8
      end
    end
    object ppReport1SummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 21378
      mmPrintPosition = 0
      object ppReport1Label17: TppLabel
        UserName = 'ppReport1Label17'
        Caption = 
          '* - this is the product'#39's line number as it appears on the origi' +
          'nal paper invoice.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3387
        mmLeft = 3175
        mmTop = 1058
        mmWidth = 94827
        BandType = 7
      end
      object ppReport1Memo1: TppMemo
        UserName = 'ppReport1Memo1'
        Caption = '** Reason for product rejection:'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Lines.Strings = (
          '** Reason for product rejection:'
          
            '       -  UM  - Unmatched - US Foods product code not found in t' +
            'he Purchase system'
          
            '       -  KV   - Key Violation - Key violation when attempting t' +
            'o insert product in the invoice'
          
            '       -  PE   - Post Error - Error when attempting to insert pr' +
            'oduct in the invoice')
        Transparent = True
        mmHeight = 15663
        mmLeft = 3175
        mmTop = 5080
        mmWidth = 113877
        BandType = 7
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
    object ppReport1Group1: TppGroup
      BreakName = 'FileName'
      DataPipeline = AlliaInvPipe
      UserName = 'Report1Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 40000
      DataPipelineName = 'AlliaInvPipe'
      object ppReport1GroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 7197
        mmPrintPosition = 0
        object ppReport1Label20: TppLabel
          UserName = 'ppReport1Label20'
          Caption = 'File Name:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 4022
          mmLeft = 2540
          mmTop = 2540
          mmWidth = 16510
          BandType = 3
          GroupNo = 0
        end
        object ppReport1DBText16: TppDBText
          UserName = 'ppReport1DBText16'
          DataField = 'FileName'
          DataPipeline = AlliaInvPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 4022
          mmLeft = 19897
          mmTop = 2540
          mmWidth = 38523
          BandType = 3
          GroupNo = 0
        end
      end
      object ppReport1GroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 1905
        mmPrintPosition = 0
      end
    end
    object ppReport1Group2: TppGroup
      BreakName = 'InvNo'
      DataPipeline = AlliaInvPipe
      UserName = 'Report1Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'AlliaInvPipe'
      object ppReport1GroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 11430
        mmPrintPosition = 0
        object ppReport1Label1: TppLabel
          UserName = 'ppReport1Label1'
          Caption = 'Invoice No.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 4022
          mmLeft = 3387
          mmTop = 1270
          mmWidth = 18415
          BandType = 3
          GroupNo = 1
        end
        object ppReport1DBText1: TppDBText
          UserName = 'ppReport1DBText1'
          DataField = 'InvNo'
          DataPipeline = AlliaInvPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 4022
          mmLeft = 22648
          mmTop = 1270
          mmWidth = 13758
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label2: TppLabel
          UserName = 'ppReport1Label2'
          Caption = 'Invoice Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 4022
          mmLeft = 62230
          mmTop = 1270
          mmWidth = 20320
          BandType = 3
          GroupNo = 1
        end
        object ppReport1DBText2: TppDBText
          UserName = 'ppReport1DBText2'
          DataField = 'InvDate'
          DataPipeline = AlliaInvPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 4022
          mmLeft = 83185
          mmTop = 1270
          mmWidth = 13758
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line1: TppLine
          UserName = 'ppReport1Line1'
          Pen.Width = 2
          Weight = 1.20000004768372
          mmHeight = 1693
          mmLeft = 2540
          mmTop = 0
          mmWidth = 196215
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line2: TppLine
          UserName = 'ppReport1Line2'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.20000004768372
          mmHeight = 1905
          mmLeft = 2540
          mmTop = 4233
          mmWidth = 196215
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label3: TppLabel
          UserName = 'ppReport1Label3'
          Caption = 'Prod. No.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 11642
          mmTop = 6985
          mmWidth = 11642
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label4: TppLabel
          UserName = 'ppReport1Label4'
          Caption = 'Product Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 42545
          mmTop = 6985
          mmWidth = 17568
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label5: TppLabel
          UserName = 'ppReport1Label5'
          Caption = 'Sales Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 84032
          mmTop = 6985
          mmWidth = 12700
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label6: TppLabel
          UserName = 'ppReport1Label6'
          Caption = 'Price Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 97790
          mmTop = 6985
          mmWidth = 12065
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label7: TppLabel
          UserName = 'ppReport1Label7'
          Caption = 'Units'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 111337
          mmTop = 6985
          mmWidth = 6350
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label8: TppLabel
          UserName = 'ppReport1Label8'
          Caption = 'Eaches'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 119380
          mmTop = 6985
          mmWidth = 9313
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label9: TppLabel
          UserName = 'ppReport1Label9'
          Caption = 'Weight'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 130599
          mmTop = 6985
          mmWidth = 8678
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label10: TppLabel
          UserName = 'ppReport1Label10'
          Caption = 'Unit Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 141817
          mmTop = 6985
          mmWidth = 11430
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label11: TppLabel
          UserName = 'ppReport1Label11'
          Caption = 'Each Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 154094
          mmTop = 6985
          mmWidth = 12912
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label12: TppLabel
          UserName = 'ppReport1Label12'
          Caption = 'Total Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 170604
          mmTop = 6985
          mmWidth = 12488
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line4: TppLine
          UserName = 'ppReport1Line4'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.20000004768372
          mmHeight = 11218
          mmLeft = 2540
          mmTop = 0
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line17: TppLine
          UserName = 'ppReport1Line17'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 24130
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line18: TppLine
          UserName = 'ppReport1Line18'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 83609
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line19: TppLine
          UserName = 'ppReport1Line19'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 97155
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line20: TppLine
          UserName = 'ppReport1Line20'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 110279
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line21: TppLine
          UserName = 'ppReport1Line21'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 118957
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line22: TppLine
          UserName = 'ppReport1Line22'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 128905
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line23: TppLine
          UserName = 'ppReport1Line23'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 141182
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line24: TppLine
          UserName = 'ppReport1Line24'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 153670
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line25: TppLine
          UserName = 'ppReport1Line25'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 167217
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line26: TppLine
          UserName = 'ppReport1Line26'
          Position = lpBottom
          Weight = 0.600000023841858
          mmHeight = 1482
          mmLeft = 2540
          mmTop = 9948
          mmWidth = 196215
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line27: TppLine
          UserName = 'ppReport1Line27'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.20000004768372
          mmHeight = 11218
          mmLeft = 197062
          mmTop = 0
          mmWidth = 1693
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line30: TppLine
          UserName = 'ppReport1Line30'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 10795
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label16: TppLabel
          UserName = 'ppReport1Label16'
          Caption = 'Line *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 3175
          mmTop = 6985
          mmWidth = 6985
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Line32: TppLine
          UserName = 'ppReport1Line32'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 5292
          mmLeft = 186267
          mmTop = 5927
          mmWidth = 2328
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label18: TppLabel
          UserName = 'ppReport1Label18'
          Caption = 'Reason**'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3387
          mmLeft = 186690
          mmTop = 6985
          mmWidth = 11430
          BandType = 3
          GroupNo = 1
        end
        object ppReport1Label19: TppLabel
          UserName = 'ppReport1Label19'
          Caption = 'Invoice Type:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 4022
          mmLeft = 116629
          mmTop = 1270
          mmWidth = 20743
          BandType = 3
          GroupNo = 1
        end
        object ppReport1DBText15: TppDBText
          UserName = 'ppReport1DBText15'
          DataField = 'InvType'
          DataPipeline = AlliaInvPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 4022
          mmLeft = 138007
          mmTop = 1270
          mmWidth = 13758
          BandType = 3
          GroupNo = 1
        end
      end
      object ppReport1GroupFooterBand2: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 6562
        mmPrintPosition = 0
        object ppReport1Label13: TppLabel
          UserName = 'ppReport1Label13'
          Caption = 'Total Unmatched Products:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3387
          mmLeft = 5292
          mmTop = 635
          mmWidth = 36195
          BandType = 5
          GroupNo = 1
        end
        object ppReport1Label14: TppLabel
          UserName = 'ppReport1Label14'
          Caption = 'Unmatched Products Total Cost:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3387
          mmLeft = 59690
          mmTop = 635
          mmWidth = 42757
          BandType = 5
          GroupNo = 1
        end
        object ppReport1DBCalc1: TppDBCalc
          UserName = 'ppReport1DBCalc1'
          DataField = 'ACode'
          DataPipeline = AlliaInvPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppReport1Group2
          Transparent = True
          DBCalcType = dcCount
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 3387
          mmLeft = 42333
          mmTop = 635
          mmWidth = 10372
          BandType = 5
          GroupNo = 1
        end
        object ppReport1DBCalc2: TppDBCalc
          UserName = 'ppReport1DBCalc2'
          DataField = 'ATotalCost'
          DataPipeline = AlliaInvPipe
          DisplayFormat = '$0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppReport1Group2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'AlliaInvPipe'
          mmHeight = 3387
          mmLeft = 103505
          mmTop = 635
          mmWidth = 16933
          BandType = 5
          GroupNo = 1
        end
        object ppReport1Line15: TppLine
          UserName = 'ppReport1Line15'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.20000004768372
          mmHeight = 5080
          mmLeft = 2540
          mmTop = 0
          mmWidth = 2328
          BandType = 5
          GroupNo = 1
        end
        object ppReport1Line16: TppLine
          UserName = 'ppReport1Line16'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.20000004768372
          mmHeight = 1905
          mmLeft = 2540
          mmTop = 3387
          mmWidth = 196215
          BandType = 5
          GroupNo = 1
        end
        object ppReport1Line29: TppLine
          UserName = 'ppReport1Line29'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.20000004768372
          mmHeight = 5080
          mmLeft = 197062
          mmTop = 0
          mmWidth = 1693
          BandType = 5
          GroupNo = 1
        end
      end
    end
  end
  object AlliaInvPipe: TppBDEPipeline
    DataSource = wwsAlliaInv
    UserName = 'AlliaInvPipe'
    Left = 259
    Top = 8
    object AlliaInvPipeppField1: TppField
      FieldAlias = 'FileName'
      FieldName = 'FileName'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object AlliaInvPipeppField2: TppField
      FieldAlias = 'InvNo'
      FieldName = 'InvNo'
      FieldLength = 15
      DisplayWidth = 15
      Position = 1
    end
    object AlliaInvPipeppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'RecNo'
      FieldName = 'RecNo'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 2
    end
    object AlliaInvPipeppField4: TppField
      FieldAlias = 'ACode'
      FieldName = 'ACode'
      FieldLength = 7
      DisplayWidth = 7
      Position = 3
    end
    object AlliaInvPipeppField5: TppField
      FieldAlias = 'InvDate'
      FieldName = 'InvDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 4
    end
    object AlliaInvPipeppField6: TppField
      FieldAlias = 'InvType'
      FieldName = 'InvType'
      FieldLength = 2
      DisplayWidth = 2
      Position = 5
    end
    object AlliaInvPipeppField7: TppField
      FieldAlias = 'AName'
      FieldName = 'AName'
      FieldLength = 30
      DisplayWidth = 30
      Position = 6
    end
    object AlliaInvPipeppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'AUnitQ'
      FieldName = 'AUnitQ'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 7
    end
    object AlliaInvPipeppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'AEachQ'
      FieldName = 'AEachQ'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object AlliaInvPipeppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'AWeight'
      FieldName = 'AWeight'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
    object AlliaInvPipeppField11: TppField
      FieldAlias = 'ASUnit'
      FieldName = 'ASUnit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 10
    end
    object AlliaInvPipeppField12: TppField
      FieldAlias = 'APUnit'
      FieldName = 'APUnit'
      FieldLength = 10
      DisplayWidth = 10
      Position = 11
    end
    object AlliaInvPipeppField13: TppField
      Alignment = taRightJustify
      FieldAlias = 'ACostUnit'
      FieldName = 'ACostUnit'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 12
    end
    object AlliaInvPipeppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'ACostEach'
      FieldName = 'ACostEach'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 13
    end
    object AlliaInvPipeppField15: TppField
      Alignment = taRightJustify
      FieldAlias = 'ATotalCost'
      FieldName = 'ATotalCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 14
    end
    object AlliaInvPipeppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'ConvFact'
      FieldName = 'ConvFact'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 15
    end
    object AlliaInvPipeppField17: TppField
      FieldAlias = 'Reason'
      FieldName = 'Reason'
      FieldLength = 2
      DisplayWidth = 2
      Position = 16
    end
  end
  object wwsAlliaInv: TwwDataSource
    DataSet = wwtAlliaInv
    Left = 99
    Top = 8
  end
  object wwsAlliaFil: TwwDataSource
    DataSet = wwqAlliaRes
    Left = 91
    Top = 152
  end
  object ppErrRpt: TppReport
    AutoStop = False
    DataPipeline = ppErrPipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report1'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 13970
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppErrRptPreviewFormCreate
    Left = 288
    Top = 43
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppErrPipe'
    object ppTitleBand1: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 64558
      mmPrintPosition = 0
      object ppShape2: TppShape
        UserName = 'Shape2'
        Brush.Style = bsClear
        mmHeight = 5027
        mmLeft = 3175
        mmTop = 19844
        mmWidth = 18256
        BandType = 1
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        Brush.Style = bsClear
        mmHeight = 35454
        mmLeft = 3175
        mmTop = 24871
        mmWidth = 53975
        BandType = 1
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = 'Imported On:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3175
        mmTop = 7408
        mmWidth = 19844
        BandType = 1
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 24077
        mmTop = 7408
        mmWidth = 16933
        BandType = 1
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'No. Files Processed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 25929
        mmWidth = 32279
        BandType = 1
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = 'Successfull:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 41275
        mmWidth = 18785
        BandType = 1
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Failures:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 45773
        mmWidth = 13229
        BandType = 1
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Caption = 'Duplicates (Current):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 6085
        mmTop = 50271
        mmWidth = 31485
        BandType = 1
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        Caption = 'Duplicates (Accepted):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 6085
        mmTop = 54769
        mmWidth = 34925
        BandType = 1
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = 'Bad File Format:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 30692
        mmWidth = 25665
        BandType = 1
      end
      object pplblNofiles: TppLabel
        UserName = 'lblNofiles'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 25929
        mmWidth = 7408
        BandType = 1
      end
      object pplblImpSuc: TppLabel
        UserName = 'lblImpSuc'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 41275
        mmWidth = 7408
        BandType = 1
      end
      object pplblDupCur: TppLabel
        UserName = 'lblDupCur'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 50271
        mmWidth = 7408
        BandType = 1
      end
      object pplblDupAcc: TppLabel
        UserName = 'lblDupAcc'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 54769
        mmWidth = 7408
        BandType = 1
      end
      object pplblBadFmt: TppLabel
        UserName = 'lblBadFmt'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 30692
        mmWidth = 7408
        BandType = 1
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        Caption = 'No. of Invoices Processed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 36777
        mmWidth = 40746
        BandType = 1
      end
      object pplblNoInv: TppLabel
        UserName = 'lblNoInv'
        Caption = '0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 46038
        mmTop = 36777
        mmWidth = 7408
        BandType = 1
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.75
        mmHeight = 2646
        mmLeft = 3175
        mmTop = 35719
        mmWidth = 53711
        BandType = 1
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'Import US Foods Invoices'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold, fsUnderline]
        Transparent = True
        mmHeight = 5027
        mmLeft = 79375
        mmTop = 0
        mmWidth = 44450
        BandType = 1
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Error Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold, fsUnderline]
        Transparent = True
        mmHeight = 5027
        mmLeft = 88371
        mmTop = 4763
        mmWidth = 25135
        BandType = 1
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        Caption = 'Summary'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 3969
        mmTop = 20108
        mmWidth = 16140
        BandType = 1
      end
      object pplblSite: TppLabel
        UserName = 'lblSite'
        Caption = 'lblSite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 3175
        mmTop = 2117
        mmWidth = 9525
        BandType = 1
      end
    end
    object ppHeaderBand1: TppHeaderBand
      PrintOnFirstPage = False
      mmBottomOffset = 0
      mmHeight = 7673
      mmPrintPosition = 0
      object ppLabel16: TppLabel
        UserName = 'Label16'
        Caption = 'Error Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsUnderline]
        Transparent = True
        mmHeight = 4233
        mmLeft = 41804
        mmTop = 265
        mmWidth = 18521
        BandType = 0
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        Caption = 'Import US Foods Invoices:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsUnderline]
        Transparent = True
        mmHeight = 4233
        mmLeft = 3175
        mmTop = 265
        mmWidth = 34396
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'ImpFile'
        DataPipeline = ppErrPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppErrPipe'
        mmHeight = 4233
        mmLeft = 5821
        mmTop = 794
        mmWidth = 36513
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'ImpFileDT'
        DataPipeline = ppErrPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppErrPipe'
        mmHeight = 4233
        mmLeft = 42069
        mmTop = 794
        mmWidth = 36513
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'ImpInvNo'
        DataPipeline = ppErrPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppErrPipe'
        mmHeight = 4233
        mmLeft = 82286
        mmTop = 794
        mmWidth = 30956
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'PZDate'
        DataPipeline = ppErrPipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppErrPipe'
        mmHeight = 4233
        mmLeft = 112977
        mmTop = 794
        mmWidth = 36513
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Weight = 0.75
        mmHeight = 2381
        mmLeft = 5292
        mmTop = 0
        mmWidth = 144992
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 6879
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 92869
        mmTop = 2646
        mmWidth = 17463
        BandType = 8
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'ImpLoc'
      DataPipeline = ppErrPipe
      KeepTogether = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppErrPipe'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 12700
        mmPrintPosition = 0
        object ppDBText4: TppDBText
          UserName = 'DBText4'
          OnGetText = ppDBText4GetText
          AutoSize = True
          DataField = 'ImpLoc'
          DataPipeline = ppErrPipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppErrPipe'
          mmHeight = 4233
          mmLeft = 3440
          mmTop = 2646
          mmWidth = 12435
          BandType = 3
          GroupNo = 0
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          AutoSize = False
          Caption = 'Import File Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 5821
          mmTop = 8202
          mmWidth = 36513
          BandType = 3
          GroupNo = 0
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          AutoSize = False
          Caption = 'Import File Date/Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 4233
          mmLeft = 42069
          mmTop = 8202
          mmWidth = 36513
          BandType = 3
          GroupNo = 0
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          AutoSize = False
          Caption = 'Invoice Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 82286
          mmTop = 8202
          mmWidth = 30956
          BandType = 3
          GroupNo = 0
        end
        object ppLabel4: TppLabel
          UserName = 'Label4'
          AutoSize = False
          Caption = 'Existing Invoice Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 4233
          mmLeft = 112977
          mmTop = 8202
          mmWidth = 36513
          BandType = 3
          GroupNo = 0
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 2381
          mmLeft = 5292
          mmTop = 10319
          mmWidth = 144992
          BandType = 3
          GroupNo = 0
        end
        object ppLine4: TppLine
          UserName = 'Line4'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 265
          mmLeft = 5292
          mmTop = 7673
          mmWidth = 144992
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 2910
        mmPrintPosition = 0
        object ppLine5: TppLine
          UserName = 'Line5'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 265
          mmLeft = 5292
          mmTop = 0
          mmWidth = 144992
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object ppErrPipe: TppDBPipeline
    DataSource = dsErrtbl
    UserName = 'ErrPipe'
    Left = 256
    Top = 43
  end
  object dsErrtbl: TwwDataSource
    DataSet = qryErrRpt
    Left = 88
    Top = 219
  end
  object wwtAlliaFil: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'AlliaFil'
    Left = 16
    Top = 8
    object wwtAlliaFilInvNo: TStringField
      FieldName = 'InvNo'
      Size = 15
    end
    object wwtAlliaFilDT: TDateTimeField
      FieldName = 'DT'
    end
    object wwtAlliaFilMatched: TSmallintField
      FieldName = 'Matched'
    end
    object wwtAlliaFilUnMatched: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'UnMatched'
      Calculated = True
    end
    object wwtAlliaFilTotProd: TSmallintField
      FieldName = 'TotProd'
    end
    object wwtAlliaFilNoInv: TSmallintField
      FieldName = 'NoInv'
    end
    object wwtAlliaFilImported: TStringField
      FieldName = 'Imported'
      FixedChar = True
      Size = 1
    end
    object wwtAlliaFilName: TStringField
      FieldName = 'Name'
      Size = 15
    end
    object wwtAlliaFilCredit: TStringField
      FieldName = 'Credit'
      FixedChar = True
      Size = 1
    end
  end
  object wwtAlliaInv: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'AlliaInv'
    Left = 56
    Top = 8
  end
  object wwtPurchase: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'Purchase'
    Left = 16
    Top = 40
  end
  object wwtPurchHdr: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PurchHdr'
    Left = 56
    Top = 40
  end
  object tblAccPurHd: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'AccPurHd'
    Left = 16
    Top = 80
  end
  object wwtRun: TADOTable
    Connection = dmADO.AztecConn
    Left = 16
    Top = 120
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 56
    Top = 120
  end
  object wwtAlliaRes: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'AlliaRes'
    Left = 16
    Top = 152
    object wwtAlliaResInvNo: TStringField
      FieldName = 'InvNo'
      Size = 7
    end
    object wwtAlliaResInvDate: TDateTimeField
      FieldName = 'InvDate'
    end
    object wwtAlliaResMatched: TSmallintField
      FieldName = 'Matched'
    end
    object wwtAlliaResUnMch: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'UnMch'
      Calculated = True
    end
    object wwtAlliaResTotProd: TSmallintField
      FieldName = 'TotProd'
    end
    object wwtAlliaResImported: TStringField
      FieldName = 'Imported'
      FixedChar = True
      Size = 1
    end
    object wwtAlliaResCredit: TStringField
      FieldName = 'Credit'
      Size = 2
    end
  end
  object wwqAlliaRes: TADOQuery
    Connection = dmADO.AztecConn
    OnCalcFields = wwqAlliaResCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from AlliaRes'
      'order by InvDate')
    Left = 56
    Top = 152
    object wwqAlliaResInvNo: TStringField
      FieldName = 'InvNo'
      Size = 7
    end
    object wwqAlliaResInvDate: TDateTimeField
      FieldName = 'InvDate'
    end
    object wwqAlliaResMatched: TSmallintField
      FieldName = 'Matched'
    end
    object wwqAlliaResUnMch: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'UnMch'
      Calculated = True
    end
    object wwqAlliaResTotProd: TSmallintField
      FieldName = 'TotProd'
    end
    object wwqAlliaResCredit: TStringField
      FieldName = 'Credit'
      Size = 2
    end
    object wwqAlliaResImported: TStringField
      FieldName = 'Imported'
      FixedChar = True
      Size = 1
    end
  end
  object wwtAlliant: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'Alliant'
    Left = 16
    Top = 184
  end
  object wwqPUnits: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.[Entity Code], a.[Supplier Name], a.[Unit Name], a.[Fla' +
        'vour],'
      '   a.[Import/Export Reference], a.[Unit Cost], b.[purchase name]'
      'from punits a, entity b'
      'where (a.[Import/Export Reference] is not NULL)'
      '  and (b.[entity code] = a.[entity code])')
    Left = 56
    Top = 184
  end
  object tblAlliaDup: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'AlliaDup'
    Left = 16
    Top = 216
  end
  object qryErrRpt: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT ImpLoc, ImpFile, ImpFileDT, ImpInvNo, PZDate'
      'FROM AlliaDup'
      'ORDER BY ImpLoc')
    Left = 56
    Top = 216
  end
end
