object fHZMoveRep: TfHZMoveRep
  Left = 298
  Top = 207
  HelpContext = 1053
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Internal Transfer Reports'
  ClientHeight = 548
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 708
    Height = 548
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PanelGrid: TPanel
      Left = 0
      Top = 0
      Width = 708
      Height = 493
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        708
        493)
      object wwDBGridHZMove: TwwDBGrid
        Left = 5
        Top = 4
        Width = 699
        Height = 485
        ControlType.Strings = (
          'MoveNote;CustomEdit;wwExpandButton1;F'
          'temp2;CustomEdit;wwExpandButton1;F'
          'MoveBy;CustomEdit;wwExpandButton1;F')
        Selected.Strings = (
          'HZSourceName'#9'30'#9'From HZ'#9#9
          'HZDestName'#9'30'#9'To HZ'#9#9
          'MoveDT'#9'18'#9'Transfer Date'#9#9
          'MoveBy'#9'30'#9'Transfer By'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = True
        DataSource = dsstkHZMoves
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnDblClick = wwDBGridHZMoveDblClick
      end
    end
    object PanelNote: TPanel
      Left = 0
      Top = 493
      Width = 708
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        708
        55)
      object LabelTransferNote: TLabel
        Left = 4
        Top = 4
        Width = 32
        Height = 13
        Caption = 'Note:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object MemoTransferNote: TDBMemo
        Left = 36
        Top = 2
        Width = 511
        Height = 50
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = True
        DataField = 'MoveNote'
        DataSource = dsstkHZMoves
        ParentCtl3D = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object BitBtn1: TBitBtn
        Left = 550
        Top = 27
        Width = 75
        Height = 25
        Action = ActionViewHZMove
        Anchors = [akRight, akBottom]
        Caption = '&View'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object BitBtn2: TBitBtn
        Left = 630
        Top = 27
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = '&Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 2
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
  end
  object adotHZs: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'stkHZs'
    Left = 256
    Top = 24
  end
  object dsstkHZMoves: TDataSource
    DataSet = adotstkHZMoves
    Left = 224
    Top = 56
  end
  object adotstkHZMoves: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    IndexFieldNames = 'MoveDT DESC'
    TableName = 'stkHZMoves'
    Left = 224
    Top = 24
    object adotstkHZMovesHZSourceName: TStringField
      DisplayLabel = 'From HZ'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'HZSourceName'
      LookupDataSet = adotHZs
      LookupKeyFields = 'hzID'
      LookupResultField = 'hzName'
      KeyFields = 'hzIDSource'
      Size = 30
      Lookup = True
    end
    object adotstkHZMovesHZDestName: TStringField
      DisplayLabel = 'To HZ'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'HZDestName'
      LookupDataSet = adotHZs
      LookupKeyFields = 'hzID'
      LookupResultField = 'hzName'
      KeyFields = 'hzIDDest'
      Size = 30
      Lookup = True
    end
    object adotstkHZMovesMoveDT: TDateTimeField
      DisplayLabel = 'Transfer Date'
      DisplayWidth = 18
      FieldName = 'MoveDT'
    end
    object adotstkHZMovesMoveBy: TStringField
      DisplayLabel = 'Transfer By'
      DisplayWidth = 30
      FieldName = 'MoveBy'
    end
    object adotstkHZMovesMoveNote: TStringField
      DisplayWidth = 255
      FieldName = 'MoveNote'
      Visible = False
      Size = 255
    end
    object adotstkHZMovesMoveID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'MoveID'
      ReadOnly = True
      Visible = False
    end
    object adotstkHZMoveshzIDSource: TIntegerField
      DisplayWidth = 10
      FieldName = 'hzIDSource'
      Visible = False
    end
    object adotstkHZMoveshzIDDest: TIntegerField
      DisplayWidth = 10
      FieldName = 'hzIDDest'
      Visible = False
    end
  end
  object ppDBPipelineHZMove: TppDBPipeline
    DataSource = dsstkHZMProds
    UserName = 'DBPipelineHZMove'
    Left = 256
    Top = 88
    object ppDBPipelineHZMoveppField1: TppField
      FieldAlias = 'SiteCode'
      FieldName = 'SiteCode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField2: TppField
      FieldAlias = 'MoveID'
      FieldName = 'MoveID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField3: TppField
      FieldAlias = 'RecID'
      FieldName = 'RecID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField4: TppField
      FieldAlias = 'EntityCode'
      FieldName = 'EntityCode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField5: TppField
      FieldAlias = 'BaseU'
      FieldName = 'BaseU'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField6: TppField
      FieldAlias = 'MoveU'
      FieldName = 'MoveU'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField7: TppField
      FieldAlias = 'LMDT'
      FieldName = 'LMDT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField8: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField9: TppField
      FieldAlias = 'Sub'
      FieldName = 'Sub'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField10: TppField
      FieldAlias = 'ActualQuantity'
      FieldName = 'ActualQuantity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineHZMoveppField11: TppField
      FieldAlias = 'Qty'
      FieldName = 'Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
  end
  object ppReportHZMove: TppReport
    AutoStop = False
    DataPipeline = ppDBPipelineHZMove
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
    OnPreviewFormCreate = ppReportHZMovePreviewFormCreate
    Left = 224
    Top = 88
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipelineHZMove'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 28575
      mmPrintPosition = 0
      object ppShape3: TppShape
        UserName = 'Shape3'
        mmHeight = 7408
        mmLeft = 52388
        mmTop = 1852
        mmWidth = 104775
        BandType = 0
      end
      object pplTitle: TppLabel
        UserName = 'lTitle'
        AutoSize = False
        Caption = 'Internal Transfer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 53181
        mmTop = 2646
        mmWidth = 103188
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
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
        mmTop = 1852
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
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
        mmTop = 6350
        mmWidth = 16140
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
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
        mmTop = 10848
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'ppHoldRepLabel101'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3703
        mmLeft = 157692
        mmTop = 6350
        mmWidth = 9790
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 177800
        mmTop = 1852
        mmWidth = 16341
        BandType = 0
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
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
        mmTop = 1852
        mmWidth = 33338
        BandType = 0
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
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
        mmTop = 6350
        mmWidth = 34396
        BandType = 0
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
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
        mmTop = 10848
        mmWidth = 36513
        BandType = 0
      end
      object ppSystemVariable3: TppSystemVariable
        UserName = 'SystemVariable3'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3703
        mmLeft = 168275
        mmTop = 6350
        mmWidth = 25929
        BandType = 0
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 19050
        mmWidth = 200290
        BandType = 0
      end
      object pplMvDate: TppLabel
        UserName = 'lMvDate'
        Caption = 'Transfer Date/Time:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 85411
        mmTop = 10319
        mmWidth = 29887
        BandType = 0
      end
      object pplFromTo: TppLabel
        UserName = 'lFromTo'
        Caption = 'From:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 95925
        mmTop = 15081
        mmWidth = 8975
        BandType = 0
      end
      object pplMvBy: TppLabel
        UserName = 'lMvBy'
        Caption = 'Manager:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 180711
        mmTop = 10848
        mmWidth = 13494
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 0
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine10: TppLine
        UserName = 'Line10'
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 0
        mmTop = 22490
        mmWidth = 194734
        BandType = 0
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 194469
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 9525
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine13: TppLine
        UserName = 'Line13'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 78581
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine14: TppLine
        UserName = 'Line14'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 107686
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine15: TppLine
        UserName = 'Line15'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 127265
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLine17: TppLine
        UserName = 'Line17'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 6085
        mmLeft = 173832
        mmTop = 22490
        mmWidth = 1852
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'No.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4657
        mmLeft = 1852
        mmTop = 23283
        mmWidth = 6265
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Product Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4657
        mmLeft = 10848
        mmTop = 23283
        mmWidth = 26374
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = 'Transfer Unit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 80698
        mmTop = 23283
        mmWidth = 24342
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Quantity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 108744
        mmTop = 23283
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Caption = 'Sub-Category'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4763
        mmLeft = 129117
        mmTop = 23283
        mmWidth = 25400
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        AutoSize = False
        Caption = 'Received'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 173832
        mmTop = 23284
        mmWidth = 20902
        BandType = 0
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 26988
        mmWidth = 194734
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'REPRINT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold, fsUnderline]
        Transparent = True
        mmHeight = 4191
        mmLeft = 179123
        mmTop = 15346
        mmWidth = 15452
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'MoveU'
        DataPipeline = ppDBPipelineHZMove
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineHZMove'
        mmHeight = 4022
        mmLeft = 79375
        mmTop = 794
        mmWidth = 28047
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        OnGetText = ppDBText5GetText
        DataField = 'ActualQuantity'
        DataPipeline = ppDBPipelineHZMove
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipelineHZMove'
        mmHeight = 4022
        mmLeft = 108479
        mmTop = 794
        mmWidth = 18256
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'RecID'
        DataPipeline = ppDBPipelineHZMove
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipelineHZMove'
        mmHeight = 4191
        mmLeft = 529
        mmTop = 794
        mmWidth = 7408
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 0
        mmTop = 0
        mmWidth = 529
        BandType = 4
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 9525
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 107686
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 127265
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 173832
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 194469
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Name'
        DataPipeline = ppDBPipelineHZMove
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'ppDBPipelineHZMove'
        mmHeight = 4191
        mmLeft = 10848
        mmTop = 794
        mmWidth = 67204
        BandType = 4
      end
      object ppLine16: TppLine
        UserName = 'Line16'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 78581
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Sub'
        DataPipeline = ppDBPipelineHZMove
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineHZMove'
        mmHeight = 4022
        mmLeft = 129117
        mmTop = 794
        mmWidth = 43656
        BandType = 4
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 4498
        mmWidth = 194469
        BandType = 4
      end
    end
    object ppSummaryBand1: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 27781
      mmPrintPosition = 0
      object ppLabel16: TppLabel
        UserName = 'Label15'
        Caption = 'Transfer Note:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsUnderline]
        Transparent = True
        mmHeight = 3969
        mmLeft = 265
        mmTop = 23813
        mmWidth = 22490
        BandType = 7
      end
      object ppMemo1: TppMemo
        UserName = 'Memo1'
        KeepTogether = True
        Caption = 'Memo1'
        CharWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Stretch = True
        Transparent = True
        mmHeight = 3969
        mmLeft = 24077
        mmTop = 23813
        mmWidth = 170127
        BandType = 7
        mmBottomOffset = 2540
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Received By -'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 794
        mmTop = 5821
        mmWidth = 23019
        BandType = 7
      end
      object ppLabel14: TppLabel
        UserName = 'Label12'
        Caption = 'Name: ________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 25400
        mmTop = 5821
        mmWidth = 89694
        BandType = 7
      end
      object ppLabel15: TppLabel
        UserName = 'Label14'
        Caption = 'Signature: _______________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 116152
        mmTop = 5821
        mmWidth = 78846
        BandType = 7
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        Caption = 'Date Received: _______________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 794
        mmTop = 15081
        mmWidth = 86519
        BandType = 7
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        Caption = 'Time Received: __________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 91546
        mmTop = 15081
        mmWidth = 77523
        BandType = 7
      end
    end
  end
  object adotHZMProds: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    OnCalcFields = adotHZMProdsCalcFields
    IndexFieldNames = 'MoveID'
    MasterFields = 'MoveID'
    MasterSource = dsstkHZMoves
    TableName = 'stkHZMProds'
    Left = 288
    Top = 24
    object adotHZMProdsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object adotHZMProdsMoveID: TIntegerField
      FieldName = 'MoveID'
    end
    object adotHZMProdsRecID: TIntegerField
      FieldName = 'RecID'
    end
    object adotHZMProdsEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object adotHZMProdsBaseU: TFloatField
      FieldName = 'BaseU'
    end
    object adotHZMProdsMoveU: TStringField
      FieldName = 'MoveU'
      Size = 10
    end
    object adotHZMProdsLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object adotHZMProdsName: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = adotProducts
      LookupKeyFields = 'EntityCode'
      LookupResultField = 'Purchase Name'
      KeyFields = 'EntityCode'
      Size = 40
      Lookup = True
    end
    object adotHZMProdsSub: TStringField
      FieldKind = fkLookup
      FieldName = 'Sub'
      LookupDataSet = adotProducts
      LookupKeyFields = 'EntityCode'
      LookupResultField = 'Sub-Category Name'
      KeyFields = 'EntityCode'
      Lookup = True
    end
    object adotHZMProdsActualQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ActualQuantity'
      Calculated = True
    end
    object adotHZMProdsQty: TFloatField
      FieldName = 'Qty'
    end
  end
  object dsstkHZMProds: TDataSource
    DataSet = adotHZMProds
    Left = 288
    Top = 56
  end
  object ActionList: TActionList
    Left = 352
    Top = 24
    object ActionViewHZMove: TAction
      Caption = '&View'
      OnExecute = ActionViewHZMoveExecute
    end
  end
  object adotProducts: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'Products'
    Left = 324
    Top = 24
  end
end
