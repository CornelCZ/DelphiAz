object fLCRep: TfLCRep
  Left = 270
  Top = 161
  Width = 805
  Height = 584
  HelpContext = 1038
  Caption = 'Line Checks and Spot Checks Reports'
  Color = clBtnFace
  Constraints.MaxWidth = 850
  Constraints.MinWidth = 795
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gridLCReps: TwwDBGrid
    Left = 0
    Top = 0
    Width = 440
    Height = 546
    ControlType.Strings = (
      'hzID;CheckBox;1;0'
      'byHZ;CheckBox;1;0')
    Selected.Strings = (
      'Division'#9'20'#9'Division'#9'F'
      'BaseDT'#9'22'#9'Base Date Time'#9'F'
      'LCSCDT'#9'23'#9'Line/Spot Check DT'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnMultiSelectRecord = gridLCRepsMultiSelectRecord
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alLeft
    DataSource = dsLCReps
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
    OnCalcCellColors = gridLCRepsCalcCellColors
    OnCalcTitleAttributes = gridLCRepsCalcTitleAttributes
    OnTitleButtonClick = gridLCRepsTitleButtonClick
    OnDblClick = BitBtn15Click
  end
  object PanelRight: TPanel
    Left = 440
    Top = 0
    Width = 349
    Height = 546
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      349
      546)
    object Bevel4: TBevel
      Left = 180
      Top = 11
      Width = 161
      Height = 119
      Shape = bsFrame
      Style = bsRaised
    end
    object Label27: TLabel
      Left = 4
      Top = 6
      Width = 153
      Height = 13
      Caption = 'Check is for Holding Zone:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 4
      Top = 111
      Width = 100
      Height = 13
      Caption = 'Line Check Note:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 4
      Top = 77
      Width = 93
      Height = 13
      Caption = 'Check Done By:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 4
      Top = 42
      Width = 121
      Height = 13
      Caption = 'Check Committed on:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 180
      Top = 133
      Width = 163
      Height = 155
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Click on a Field Title to order grid by that field with newest a' +
        't top (Title will turn Yellow)'#13#10'  '#13#10'Click a Yellow Title to orde' +
        'r with oldest at top (Title will turn Red) '#13#10'  '#13#10'Click "Division' +
        '" or a Red Title to go back to Default order'#13#10'(Div > Base DT > L' +
        'C/SC DT) newest at top.'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object Label22: TLabel
      Left = 186
      Top = 85
      Width = 152
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Current Checks are the ones having the latest Accepted Stock as ' +
        'their Base Stock'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label21: TLabel
      Left = 189
      Top = 23
      Width = 46
      Height = 13
      Caption = 'Division'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 185
      Top = 5
      Width = 70
      Height = 13
      Caption = ' Grid Filters '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 4
      Top = 23
      Width = 169
      Height = 14
      Color = clWhite
      DataField = 'hzName'
      DataSource = dsLCReps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 4
      Top = 127
      Width = 169
      Height = 162
      Color = clWhite
      DataField = 'LCText'
      DataSource = dsLCReps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object DBText2: TDBText
      Left = 4
      Top = 93
      Width = 169
      Height = 14
      Color = clSilver
      DataField = 'CommitBy'
      DataSource = dsLCReps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 4
      Top = 58
      Width = 169
      Height = 14
      Color = clSilver
      DataField = 'LMDT'
      DataSource = dsLCReps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 3
      Top = 312
      Width = 177
      Height = 115
      Alignment = taCenter
      AutoSize = False
      Caption = 
        '4 Line Checks selected'#13#10#13#10'Report shown will be:'#13#10#13#10'Cumulative Li' +
        'ne '#13#10'Check Variance'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      Visible = False
      WordWrap = True
    end
    object lookRepDiv: TComboBox
      Left = 187
      Top = 37
      Width = 149
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnCloseUp = lookRepDivCloseUp
    end
    object cbCurrLC: TCheckBox
      Left = 186
      Top = 69
      Width = 149
      Height = 16
      Caption = 'Only current Checks'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cbCurrLCClick
    end
    object BitBtn15: TBitBtn
      Left = 112
      Top = 508
      Width = 113
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = 'View Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn15Click
    end
    object BitBtn16: TBitBtn
      Left = 232
      Top = 508
      Width = 113
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
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
  object adotLCReps: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filtered = True
    AfterOpen = adotLCRepsAfterScroll
    AfterScroll = adotLCRepsAfterScroll
    IndexFieldNames = 'Division;BaseDT DESC;LCSCDT DESC'
    TableName = 'stkLCReps'
    Left = 320
    Top = 200
  end
  object dsLCReps: TwwDataSource
    DataSet = adotLCReps
    Left = 368
    Top = 200
  end
  object adoqLG: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * from [00_#lcrep] order by SubCatName, PurchaseName')
    Left = 136
    Top = 392
  end
  object dsLG: TDataSource
    DataSet = adoqLG
    Left = 184
    Top = 392
  end
  object pipeLG: TppDBPipeline
    DataSource = dsLG
    UserName = 'pipeLG'
    Left = 216
    Top = 392
  end
  object ppLGsmall: TppReport
    AutoStop = False
    DataPipeline = pipeLG
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ppHoldRep'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.FileName = 'C:\cornel_view\SQLStock\Code\hold.rtm'
    AllowPrintToArchive = True
    ArchiveFileName = 'LG.raf'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppLGsmallPreviewFormCreate
    Left = 248
    Top = 392
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'pipeLG'
    object ppHeaderBand3: TppHeaderBand
      BeforePrint = ppHeaderBand3BeforePrint
      mmBottomOffset = 0
      mmHeight = 28310
      mmPrintPosition = 0
      object ppShape4: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 50536
        mmTop = 3175
        mmWidth = 104775
        BandType = 0
      end
      object ppLabel65: TppLabel
        UserName = 'ppHoldRepLabel1'
        AutoSize = False
        Caption = 'Stock Loss/Gain Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5842
        mmLeft = 51065
        mmTop = 3969
        mmWidth = 103188
        BandType = 0
      end
      object ppLabel66: TppLabel
        UserName = 'ppHoldRepLabel2'
        AutoSize = False
        Caption = 'Area Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 265
        mmTop = 3175
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel67: TppLabel
        UserName = 'ppHoldRepLabel3'
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
      object ppLabel68: TppLabel
        UserName = 'ppHoldRepLabel4'
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
      object ppLabel73: TppLabel
        UserName = 'ppHoldRepLabel10'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 162984
        mmTop = 7938
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable6: TppSystemVariable
        UserName = 'HoldRepCalc1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 183621
        mmTop = 3175
        mmWidth = 16404
        BandType = 0
      end
      object pplDiv: TppLabel
        UserName = 'lDiv2'
        Caption = 'Division:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 265
        mmTop = 16669
        mmWidth = 13494
        BandType = 0
      end
      object ppLmid1: TppLabel
        UserName = 'lFrom2'
        Caption = 'From: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83725
        mmTop = 11377
        mmWidth = 39455
        BandType = 0
      end
      object ppDBText41: TppDBText
        UserName = 'DBText38'
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
        mmWidth = 32015
        BandType = 0
      end
      object ppDBText42: TppDBText
        UserName = 'DBText39'
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
        mmWidth = 33073
        BandType = 0
      end
      object ppDBText43: TppDBText
        UserName = 'DBText40'
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
        mmWidth = 35190
        BandType = 0
      end
      object ppSystemVariable7: TppSystemVariable
        UserName = 'SystemVariable5'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 174096
        mmTop = 7938
        mmWidth = 25929
        BandType = 0
      end
      object ppLine86: TppLine
        UserName = 'Line70'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 23813
        mmWidth = 200025
        BandType = 0
      end
      object pplHeader: TppLabel
        UserName = 'Label1002'
        Caption = 'Header:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 188648
        mmTop = 16669
        mmWidth = 11377
        BandType = 0
      end
      object ppLmid3: TppLabel
        UserName = 'Lmid3'
        Caption = 'Commited on: 33/33/3333 33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 159544
        mmTop = 12435
        mmWidth = 40481
        BandType = 0
      end
      object ppLmid2: TppLabel
        UserName = 'Lmid2'
        Caption = '     To: 33/33/3333 33:33:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 83534
        mmTop = 15346
        mmWidth = 39836
        BandType = 0
      end
      object pplRight2: TppLabel
        UserName = 'lRight2'
        AutoSize = False
        Caption = 'lRight2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        Visible = False
        mmHeight = 3704
        mmLeft = 106892
        mmTop = 20902
        mmWidth = 93134
        BandType = 0
      end
      object ppShape20: TppShape
        UserName = 'Shape20'
        Brush.Color = clYellow
        mmHeight = 3440
        mmLeft = 6615
        mmTop = 20902
        mmWidth = 17463
        BandType = 0
      end
      object ppLabel230: TppLabel
        UserName = 'Label230'
        AutoSize = False
        Caption = 'Click  Yellow Area  to view/hide previous checks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 0
        mmTop = 21167
        mmWidth = 68527
        BandType = 0
      end
    end
    object ppDetailBand3: TppDetailBand
      BeforePrint = ppDetailBand3BeforePrint
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 9790
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        Brush.Color = clYellow
        Pen.Style = psClear
        mmHeight = 4233
        mmLeft = 148696
        mmTop = 265
        mmWidth = 11113
        BandType = 4
      end
      object ppDBText44: TppDBText
        UserName = 'ppHoldRepDBText2'
        DataField = 'PurchaseName'
        DataPipeline = pipeLG
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 794
        mmTop = 794
        mmWidth = 54240
        BandType = 4
      end
      object ppDBText45: TppDBText
        UserName = 'ppHoldRepDBText3'
        DataField = 'PurchUnit'
        DataPipeline = pipeLG
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 56092
        mmTop = 794
        mmWidth = 17727
        BandType = 4
      end
      object ppDBText46: TppDBText
        UserName = 'ppHoldRepDBText4'
        OnGetText = ppDBText46GetText
        DataField = 'q'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 74877
        mmTop = 794
        mmWidth = 27252
        BandType = 4
      end
      object ppDBText55: TppDBText
        UserName = 'ppHoldRepDBText13'
        DataField = 'spc'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 132821
        mmTop = 794
        mmWidth = 15081
        BandType = 4
      end
      object ppLine87: TppLine
        UserName = 'ppHoldRepLine9'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 0
        mmTop = 0
        mmWidth = 3440
        BandType = 4
      end
      object ppLine90: TppLine
        UserName = 'ppHoldRepLine12'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1852
        mmLeft = 0
        mmTop = 3175
        mmWidth = 198702
        BandType = 4
      end
      object ppLine92: TppLine
        UserName = 'ppHoldRepLine27'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 55563
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppLine101: TppLine
        UserName = 'ppHoldRepLine33'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 102659
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppLine105: TppLine
        UserName = 'ppHoldRepLine36'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 132292
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppLine106: TppLine
        UserName = 'ppHoldRepLine38'
        Position = lpRight
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 196850
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 159809
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        OnGetText = ppDBText46GetText
        DataField = 'CheckCount'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 160867
        mmTop = 794
        mmWidth = 21960
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        OnGetText = ppDBText46GetText
        DataField = 'bq'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 103452
        mmTop = 794
        mmWidth = 28310
        BandType = 4
      end
      object ppSlave: TppSubReport
        UserName = 'Slave'
        DrillDownComponent = ppShape1
        ExpandAll = False
        NewPrintJob = False
        TraverseAllData = False
        DataPipelineName = 'pipeSlave'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 4763
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = pipeSlave
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'ppHoldRep'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 12700
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Version = '6.03'
          mmColumnWidth = 0
          DataPipelineName = 'pipeSlave'
          object ppDetailBand1: TppDetailBand
            BeforePrint = ppDetailBand1BeforePrint
            mmBottomOffset = 0
            mmHeight = 3969
            mmPrintPosition = 0
            object ppDBText3: TppDBText
              UserName = 'DBText3'
              DataField = 'theDT'
              DataPipeline = pipeSlave
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 20638
              mmTop = 265
              mmWidth = 28046
              BandType = 4
            end
            object ppDBText4: TppDBText
              UserName = 'DBText4'
              DataField = 'isSC'
              DataPipeline = pipeSlave
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              Visible = False
              DataPipelineName = 'pipeSlave'
              mmHeight = 3175
              mmLeft = 200025
              mmTop = 529
              mmWidth = 2381
              BandType = 4
            end
            object ppDBText5: TppDBText
              UserName = 'DBText5'
              OnGetText = ppDBText46GetText
              DataField = 'q'
              DataPipeline = pipeSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 74613
              mmTop = 265
              mmWidth = 27517
              BandType = 4
            end
            object ppDBText8: TppDBText
              UserName = 'DBText8'
              DataField = 'spc'
              DataPipeline = pipeSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 132822
              mmTop = 265
              mmWidth = 14023
              BandType = 4
            end
            object ppLine7: TppLine
              UserName = 'Line7'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3704
              mmLeft = 13758
              mmTop = 0
              mmWidth = 794
              BandType = 4
            end
            object ppLine8: TppLine
              UserName = 'Line8'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1323
              mmLeft = 13758
              mmTop = 2647
              mmWidth = 184680
              BandType = 4
            end
            object ppLine10: TppLine
              UserName = 'Line10'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 74082
              mmTop = 0
              mmWidth = 3440
              BandType = 4
            end
            object ppLine12: TppLine
              UserName = 'Line12'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 102659
              mmTop = 0
              mmWidth = 3440
              BandType = 4
            end
            object ppLine14: TppLine
              UserName = 'Line14'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 132291
              mmTop = 0
              mmWidth = 3440
              BandType = 4
            end
            object ppLine15: TppLine
              UserName = 'Line15'
              Position = lpRight
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 196850
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine16: TppLine
              UserName = 'Line16'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 159809
              mmTop = 0
              mmWidth = 3440
              BandType = 4
            end
            object ppDBText9: TppDBText
              UserName = 'DBText9'
              OnGetText = ppDBText46GetText
              DataField = 'CheckCount'
              DataPipeline = pipeSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 160867
              mmTop = 265
              mmWidth = 22225
              BandType = 4
            end
            object ppDBText10: TppDBText
              UserName = 'DBText10'
              OnGetText = ppDBText46GetText
              DataField = 'bq'
              DataPipeline = pipeSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 103452
              mmTop = 265
              mmWidth = 28575
              BandType = 4
            end
            object ppLabel7: TppLabel
              UserName = 'Label7'
              Caption = 'LC'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial Black'
              Font.Size = 9
              Font.Style = []
              Transparent = True
              mmHeight = 3969
              mmLeft = 14552
              mmTop = 0
              mmWidth = 4572
              BandType = 4
            end
            object ppLabelPrepItem2: TppLabel
              UserName = 'LabelPrepItem2'
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taCentered
              Visible = False
              mmHeight = 3440
              mmLeft = 74613
              mmTop = 265
              mmWidth = 12700
              BandType = 4
            end
            object ppDBText13: TppDBText
              UserName = 'DBText13'
              OnGetText = ppDBText46GetText
              DataField = 'FromPrep'
              DataPipeline = pipeSlave
              DisplayFormat = '0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'pipeSlave'
              mmHeight = 3440
              mmLeft = 184150
              mmTop = 265
              mmWidth = 14023
              BandType = 4
            end
            object ppLine21: TppLine
              UserName = 'Line21'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 3969
              mmLeft = 183622
              mmTop = 0
              mmWidth = 3440
              BandType = 4
            end
          end
          object ppSummaryBand1: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 2117
            mmPrintPosition = 0
            object ppLine9: TppLine
              UserName = 'Line9'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1323
              mmLeft = 0
              mmTop = 794
              mmWidth = 193675
              BandType = 7
            end
          end
        end
      end
      object ppLine18: TppLine
        UserName = 'Line18'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 148696
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        DataField = 'PrevC'
        DataPipeline = pipeLG
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 149225
        mmTop = 794
        mmWidth = 10319
        BandType = 4
      end
      object ppLabelPrepItem: TppLabel
        UserName = 'LabelPrepItem'
        AutoSize = False
        Caption = 
          '--------------------------  Prepared Item ----------------------' +
          '------------------- '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Visible = False
        mmHeight = 3704
        mmLeft = 74613
        mmTop = 265
        mmWidth = 8467
        BandType = 4
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        OnGetText = ppDBText46GetText
        DataField = 'FromPrep'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipeLG'
        mmHeight = 3175
        mmLeft = 184150
        mmTop = 794
        mmWidth = 13758
        BandType = 4
      end
      object ppLine19: TppLine
        UserName = 'Line19'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 183621
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
      object ppLine23: TppLine
        UserName = 'Line23'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 4763
        mmLeft = 74083
        mmTop = 0
        mmWidth = 3175
        BandType = 4
      end
    end
    object ppFooterBand3: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Caption = 
          'Note: Surplus/Deficit is calculated using the "Included in Prep.' +
          ' Items" qty. added to the "Check Count" qty. (for those products' +
          ' that have it)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 0
        mmTop = 794
        mmWidth = 198438
        BandType = 8
      end
    end
    object ppSummaryBand3: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 12965
      mmPrintPosition = 0
      object ppShape12: TppShape
        UserName = 'Shape12'
        Brush.Color = clSilver
        mmHeight = 5027
        mmLeft = 0
        mmTop = 1058
        mmWidth = 198438
        BandType = 7
      end
      object ppLabel78: TppLabel
        UserName = 'ppHoldRepLabel25'
        Caption = 'CHECK TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 529
        mmTop = 1852
        mmWidth = 19854
        BandType = 7
      end
      object ppLine171: TppLine
        UserName = 'Line171'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 132292
        mmTop = 1058
        mmWidth = 3440
        BandType = 7
      end
      object ppDBCalc38: TppDBCalc
        UserName = 'DBCalc38'
        DataField = 'spc'
        DataPipeline = pipeLG
        DisplayFormat = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'pipeLG'
        mmHeight = 3704
        mmLeft = 132821
        mmTop = 1852
        mmWidth = 15081
        BandType = 7
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Comment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 0
        mmTop = 8202
        mmWidth = 16404
        BandType = 7
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5027
        mmLeft = 148696
        mmTop = 1058
        mmWidth = 3440
        BandType = 7
      end
      object ppMemo1: TppMemo
        UserName = 'Memo1'
        KeepTogether = True
        Caption = 'Memo1'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Stretch = True
        Transparent = True
        mmHeight = 4763
        mmLeft = 18256
        mmTop = 8202
        mmWidth = 180182
        BandType = 7
        mmBottomOffset = 762
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'SubCatName'
      DataPipeline = pipeLG
      UserName = 'HoldRepGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 22860
      DataPipelineName = 'pipeLG'
      object ppGroupHeaderBand3: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 11642
        mmPrintPosition = 0
        object ppDBText56: TppDBText
          UserName = 'ppHoldRepDBText1'
          DataField = 'SubCatName'
          DataPipeline = pipeLG
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeLG'
          mmHeight = 4763
          mmLeft = 794
          mmTop = 2910
          mmWidth = 47890
          BandType = 3
          GroupNo = 0
        end
        object ppLabel81: TppLabel
          UserName = 'ppHoldRepLabel11'
          AutoSize = False
          Caption = 'Purchase Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 3175
          mmTop = 7938
          mmWidth = 21960
          BandType = 3
          GroupNo = 0
        end
        object ppLabel82: TppLabel
          UserName = 'ppHoldRepLabel12'
          AutoSize = False
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 57150
          mmTop = 6350
          mmWidth = 16140
          BandType = 3
          GroupNo = 0
        end
        object ppLabel86: TppLabel
          UserName = 'ppHoldRepLabel19'
          AutoSize = False
          Caption = 'Surplus %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 132821
          mmTop = 7938
          mmWidth = 15610
          BandType = 3
          GroupNo = 0
        end
        object ppLine110: TppLine
          UserName = 'ppHoldRepLine1'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 265
          mmTop = 6085
          mmWidth = 55298
          BandType = 3
          GroupNo = 0
        end
        object ppLine111: TppLine
          UserName = 'ppHoldRepLine2'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1323
          mmLeft = 0
          mmTop = 10320
          mmWidth = 183886
          BandType = 3
          GroupNo = 0
        end
        object ppLine112: TppLine
          UserName = 'ppHoldRepLine3'
          Weight = 0.75
          mmHeight = 794
          mmLeft = 0
          mmTop = 1323
          mmWidth = 55563
          BandType = 3
          GroupNo = 0
        end
        object ppLine113: TppLine
          UserName = 'ppHoldRepLine8'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 10054
          mmLeft = 0
          mmTop = 1588
          mmWidth = 3440
          BandType = 3
          GroupNo = 0
        end
        object ppLine115: TppLine
          UserName = 'ppHoldRepLine14'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 10319
          mmLeft = 55563
          mmTop = 1323
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine117: TppLine
          UserName = 'ppHoldRepLine20'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7673
          mmLeft = 102659
          mmTop = 3969
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine119: TppLine
          UserName = 'ppHoldRepLine25'
          Position = lpRight
          Weight = 0.75
          mmHeight = 7673
          mmLeft = 196850
          mmTop = 3969
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel90: TppLabel
          UserName = 'Label51'
          AutoSize = False
          Caption = 'Surplus(+) / Deficit(-)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 74613
          mmTop = 7938
          mmWidth = 27781
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 3440
          mmLeft = 132292
          mmTop = 8202
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7673
          mmLeft = 159809
          mmTop = 3969
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel15: TppLabel
          UserName = 'Label15'
          AutoSize = False
          Caption = 'Check Count'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 160602
          mmTop = 6350
          mmWidth = 22490
          BandType = 3
          GroupNo = 0
        end
        object ppLine6: TppLine
          UserName = 'Line6'
          Position = lpBottom
          Weight = 0.75
          mmHeight = 1588
          mmLeft = 55563
          mmTop = 2381
          mmWidth = 143140
          BandType = 3
          GroupNo = 0
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          AutoSize = False
          Caption = 'Current Check'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold, fsUnderline]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3969
          mmLeft = 74613
          mmTop = 4763
          mmWidth = 27781
          BandType = 3
          GroupNo = 0
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          AutoSize = False
          Caption = 'Surplus(+) / Deficit (-)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 103188
          mmTop = 7938
          mmWidth = 28840
          BandType = 3
          GroupNo = 0
        end
        object ppLabel6: TppLabel
          UserName = 'Label6'
          AutoSize = False
          Caption = 'Since Last Accepted Inventory'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold, fsUnderline]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3969
          mmLeft = 103188
          mmTop = 4763
          mmWidth = 56886
          BandType = 3
          GroupNo = 0
        end
        object ppLine17: TppLine
          UserName = 'Line17'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 3704
          mmLeft = 148696
          mmTop = 7938
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          AutoSize = False
          Caption = 'Checks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3704
          mmLeft = 149225
          mmTop = 7938
          mmWidth = 10319
          BandType = 3
          GroupNo = 0
        end
        object ppLine20: TppLine
          UserName = 'Line20'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7938
          mmLeft = 183621
          mmTop = 3969
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          AutoSize = False
          Caption = 'Included in Prep. Items'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taCentered
          Transparent = True
          WordWrap = True
          mmHeight = 7938
          mmLeft = 184150
          mmTop = 3704
          mmWidth = 14023
          BandType = 3
          GroupNo = 0
        end
        object ppLine22: TppLine
          UserName = 'Line22'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 7673
          mmLeft = 74083
          mmTop = 3969
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppShape11: TppShape
          UserName = 'Shape11'
          Brush.Color = clSilver
          mmHeight = 5027
          mmLeft = 0
          mmTop = 0
          mmWidth = 198702
          BandType = 5
          GroupNo = 0
        end
        object ppLabel96: TppLabel
          UserName = 'ppHoldRepLabel24'
          Caption = 'TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          mmHeight = 3260
          mmLeft = 529
          mmTop = 1058
          mmWidth = 9144
          BandType = 5
          GroupNo = 0
        end
        object ppDBText57: TppDBText
          UserName = 'ppHoldRepDBText15'
          AutoSize = True
          DataField = 'SubCatName'
          DataPipeline = pipeLG
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'pipeLG'
          mmHeight = 3810
          mmLeft = 12965
          mmTop = 688
          mmWidth = 23580
          BandType = 5
          GroupNo = 0
        end
        object ppLine163: TppLine
          UserName = 'Line163'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 132292
          mmTop = 0
          mmWidth = 3440
          BandType = 5
          GroupNo = 0
        end
        object ppDBCalc15: TppDBCalc
          UserName = 'DBCalc15'
          DataField = 'spc'
          DataPipeline = pipeLG
          DisplayFormat = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = ppGroup3
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcAverage
          DataPipelineName = 'pipeLG'
          mmHeight = 3704
          mmLeft = 132821
          mmTop = 794
          mmWidth = 15081
          BandType = 5
          GroupNo = 0
        end
        object ppLine4: TppLine
          UserName = 'Line4'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 5027
          mmLeft = 148696
          mmTop = 0
          mmWidth = 3440
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object adoqSlave: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsLG
    Parameters = <
      item
        Name = 'entitycode'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Value = 10000000074
      end>
    SQL.Strings = (
      'SELECT * '
      'from [00_#lcSlaveRep] '
      'where entitycode = :entitycode order by theDT')
    Left = 136
    Top = 432
  end
  object dsSlave: TDataSource
    DataSet = adoqSlave
    Left = 184
    Top = 432
  end
  object pipeSlave: TppDBPipeline
    DataSource = dsSlave
    SkipWhenNoRecords = False
    UserName = 'pipeSlave'
    Left = 224
    Top = 432
    MasterDataPipelineName = 'pipeLG'
  end
end
