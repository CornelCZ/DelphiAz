object fPCWasteRep: TfPCWasteRep
  Left = 383
  Top = 196
  HelpContext = 1050
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Waste'
  ClientHeight = 548
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 510
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PanelFilter: TPanel
      Left = 792
      Top = 1
      Width = 219
      Height = 508
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object PanelLegend: TPanel
        Left = 0
        Top = 317
        Width = 219
        Height = 191
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 215
          Height = 187
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Click a field title to sort in ascending order (the title will b' +
            'ecome yellow).'#13#10'Click a yellow field title to sort in descending' +
            ' order (the title will become red).'#13#10'Click a red field title to ' +
            'return to the default ordering of: Division, Category, Sub-Categ' +
            'ory, Name(all ASC), Waste Date (DESC).'#13#10'  '#13#10'Waste records that h' +
            'ave not yet been included in a stock are highlighted and can be ' +
            'deleted.'#13#10'  '#13#10'Names in Red are for Prepared Items'
          Layout = tlCenter
          WordWrap = True
        end
      end
      object PanelTop: TPanel
        Left = 0
        Top = 0
        Width = 219
        Height = 317
        Align = alTop
        Caption = 'PanelTop'
        TabOrder = 1
        DesignSize = (
          219
          317)
        object GroupBoxGridFilters: TGroupBox
          Left = 5
          Top = 88
          Width = 210
          Height = 225
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Grid Filters'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            210
            225)
          object LabelWasteBy: TLabel
            Left = 8
            Top = 145
            Width = 59
            Height = 13
            Caption = 'Waste By:'
          end
          object LabelNameFilter: TLabel
            Left = 8
            Top = 117
            Width = 37
            Height = 13
            Caption = 'Name:'
          end
          object Bevel1: TBevel
            Left = 24
            Top = 104
            Width = 164
            Height = 2
          end
          object LabelSubCatFilter: TLabel
            Left = 8
            Top = 80
            Width = 50
            Height = 13
            Caption = 'Sub-Cat:'
          end
          object LabelCatFilter: TLabel
            Left = 8
            Top = 52
            Width = 55
            Height = 13
            Caption = 'Category:'
          end
          object LabelDivFilter: TLabel
            Left = 8
            Top = 24
            Width = 50
            Height = 13
            Caption = 'Division:'
          end
          object Bevel2: TBevel
            Left = 26
            Top = 168
            Width = 164
            Height = 2
          end
          object HZLabel: TLabel
            Left = 8
            Top = 180
            Width = 22
            Height = 13
            Caption = 'HZ:'
          end
          object CheckBoxStockedItems: TCheckBox
            Left = 6
            Top = 203
            Width = 198
            Height = 17
            Alignment = taLeftJustify
            Anchors = [akRight, akBottom]
            Caption = 'Show Waste in Unstocked Divs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = CheckBoxStockedItemsClick
          end
          object ComboBoxWasteByFilter: TComboBox
            Left = 72
            Top = 141
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 1
            OnChange = ComboBoxWasteByFilterChange
          end
          object ComboBoxNameFilter: TComboBox
            Left = 72
            Top = 113
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 2
            OnChange = ComboBoxNameFilterChange
          end
          object ComboboxSubCategoryFilter: TComboBox
            Left = 72
            Top = 76
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 3
            OnChange = ComboboxSubCategoryFilterChange
          end
          object ComboboxCategoryFilter: TComboBox
            Left = 72
            Top = 48
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 4
            OnChange = ComboboxCategoryFilterChange
          end
          object ComboboxDivisionFilter: TComboBox
            Left = 72
            Top = 20
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 5
            OnChange = ComboboxDivisionFilterChange
          end
          object ComboBoxHZFilter: TComboBox
            Left = 72
            Top = 176
            Width = 134
            Height = 21
            ItemHeight = 13
            TabOrder = 6
            OnChange = ComboBoxHZFilterChange
          end
        end
        object PanelFilterByDate: TPanel
          Left = 5
          Top = 9
          Width = 210
          Height = 76
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object LabelFrom: TLabel
            Left = 8
            Top = 20
            Width = 32
            Height = 13
            Caption = 'From:'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTo: TLabel
            Left = 8
            Top = 48
            Width = 20
            Height = 13
            Caption = 'To:'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DateTimePickerFrom: TDateTimePicker
            Left = 72
            Top = 16
            Width = 134
            Height = 21
            CalAlignment = dtaLeft
            Date = 40093.4079446759
            Time = 40093.4079446759
            DateFormat = dfShort
            DateMode = dmComboBox
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Kind = dtkDate
            ParseInput = False
            ParentFont = False
            TabOrder = 0
            OnCloseUp = DateTimePickerCloseUp
          end
          object DateTimePickerTo: TDateTimePicker
            Left = 72
            Top = 44
            Width = 134
            Height = 21
            CalAlignment = dtaLeft
            Date = 40093.4081228009
            Time = 40093.4081228009
            DateFormat = dfShort
            DateMode = dmComboBox
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Kind = dtkDate
            ParseInput = False
            ParentFont = False
            TabOrder = 1
            OnCloseUp = DateTimePickerCloseUp
          end
        end
        object CheckBoxFilterByDate: TCheckBox
          Left = 12
          Top = 1
          Width = 97
          Height = 17
          Action = ActDateFilter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object PanelGrid: TPanel
      Left = 1
      Top = 1
      Width = 791
      Height = 508
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 789
        Height = 442
        Align = alClient
        BevelOuter = bvLowered
        Caption = 'Panel1'
        TabOrder = 0
        DesignSize = (
          789
          442)
        object wwDBGridPCWaste: TwwDBGrid
          Left = 10
          Top = 10
          Width = 771
          Height = 423
          LineStyle = glsSingle
          Selected.Strings = (
            'SCat'#9'20'#9'Sub-Cat'
            'Name'#9'40'#9'Name'#9'F'
            'WValue'#9'10'#9'Qty'#9'F'
            'Unit'#9'10'#9'Unit'
            'WasteDT'#9'18'#9'Waste Date'
            'WasteBy'#9'20'#9'Entered By')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Ctl3D = True
          DataSource = dsPCWaste
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
          TitleButtons = True
          UseTFields = False
          OnCalcCellColors = wwDBGridPCWasteCalcCellColors
          OnCalcTitleAttributes = wwDBGridPCWasteCalcTitleAttributes
          OnTitleButtonClick = wwDBGridPCWasteTitleButtonClick
        end
      end
      object PanelGridBottom: TPanel
        Left = 1
        Top = 443
        Width = 789
        Height = 64
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          789
          64)
        object LabelNote: TLabel
          Left = 8
          Top = 8
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
        object DBMemoNote: TDBMemo
          Left = 43
          Top = 8
          Width = 662
          Height = 50
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Note'
          DataSource = dsPCWaste
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object BitBtn1: TBitBtn
          Left = 710
          Top = 6
          Width = 75
          Height = 25
          Action = ActReport
          Anchors = [akRight, akBottom]
          Caption = '&Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
            00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
            00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
            F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
            F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
            F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
            FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
            0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
            0033333337FFFFFF773333333000000003333333377777777333}
          NumGlyphs = 2
        end
        object BitBtn2: TBitBtn
          Left = 710
          Top = 34
          Width = 75
          Height = 25
          Action = ActDelete
          Anchors = [akRight, akBottom]
          Caption = '&Delete'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            300033FFFFFF3333377739999993333333333777777F3333333F399999933333
            3300377777733333337733333333333333003333333333333377333333333333
            3333333333333333333F333333333333330033333F33333333773333C3333333
            330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
            333333377F33333333FF3333C333333330003333733333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 510
    Width = 1012
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1012
      38)
    object BitBtnClose: TBitBtn
      Left = 932
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
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
  object ActionList: TActionList
    Left = 32
    Top = 104
    object ActDelete: TAction
      Caption = '&Delete'
      OnExecute = ActDeleteExecute
      OnUpdate = ActDeleteUpdate
    end
    object ActReport: TAction
      Caption = '&Report'
      OnExecute = ActReportExecute
      OnUpdate = ActReportUpdate
    end
    object ActCancel: TAction
      Caption = '&Cancel'
    end
    object ActDateFilter: TAction
      AutoCheck = True
      Caption = 'Filter By Date'
      OnExecute = ActDateFilterExecute
    end
  end
  object adoqLoadTempstkPCWaste: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <
      item
        Name = 'lbnd'
        Size = -1
        Value = Null
      end
      item
        Name = 'ubnd'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @LowerBound varchar(20)'
      'SET @LowerBound = :lbnd'
      ''
      'DECLARE @UpperBound varchar(20)'
      'SET @UpperBound = :ubnd'
      ''
      'DECLARE @LastStocksByThread TABLE ('
      '  [Tid] [int],'
      '  [LastStockEnd] [datetime]'
      ')'
      ''
      '--If there is no existing stock for a thread then use the'
      '--@Lowerbound as as the deleteability cut-off as they cannot'
      '--see records before this date anyway'
      'INSERT @LastStocksByThread'
      'SELECT t.Tid, MAX(ISNULL(EDT,@LowerBound)) AS LastStockEnd'
      'FROM threads t'
      'left JOIN stocks s'
      'ON s.Tid = t.Tid'
      'WHERE t.Active = '#39'Y'#39
      'GROUP BY t.Tid'
      ''
      
        '--Add any PC Waste records that were entered after the earliest ' +
        'of all the'
      '--last accepted stocks across threads.'
      
        'INSERT #stkPCWaste (SiteCode, HzID, EntityCode, [Name], Div, Cat' +
        ', Scat, WasteDT, BsDate,'
      
        '                    Unit, WValue, BaseUnits, WasteBy, WasteFlag,' +
        ' LMDT, LMBy, Note, Deleteable, Stocked)'
      
        'SELECT SiteCode, HzID, w.EntityCode, se.PurchaseName, se.Div, se' +
        '.Cat, se.Scat,'
      
        '       WasteDT, BsDate, Unit, WValue, BaseUnits, WasteBy, WasteF' +
        'lag, LMDT, LMBy, Note,'
      '       CASE'
      '       WHEN (sub.LastStockEnd < w.WasteDT) THEN 1'
      '       ELSE 0'
      '       END,'
      '       1'
      'FROM stkPCWaste w'
      'JOIN stkEntity se'
      'ON w.EntityCode = se.EntityCode'
      'JOIN'
      '(SELECT pcw.entitycode,MAX(lsbt.LastStockEnd) AS LastStockEnd'
      'FROM stkPCWaste pcw'
      'JOIN stkEntity se'
      'ON pcw.EntityCode = se.EntityCode'
      'JOIN Threads t'
      'ON t.Division = se.Div'
      'JOIN @LastStocksByThread lsbt'
      'ON lsbt.Tid = t.Tid'
      'GROUP BY pcw.EntityCode) sub'
      'ON w.EntityCode = sub.EntityCode'
      'WHERE (w.BSDate >= @LowerBound)'
      'AND (w.BSDate <= @UpperBound)'
      'AND (w.Deleted = 0)'
      'AND ((w.WasteFlag = '#39'M'#39') or (w.WasteFlag = '#39'P'#39'))'
      ''
      'UNION'
      ''
      
        '--Add any PC Waste records that are in a division for which ther' +
        'e are no'
      
        '--valid stocks threads.  The user can filter in these records if' +
        ' they want to '
      
        'SELECT SiteCode, HzID, w.EntityCode, se.PurchaseName, se.Div, se' +
        '.Cat, se.Scat,'
      
        '       WasteDT, BsDate, Unit, WValue, BaseUnits, WasteBy, WasteF' +
        'lag, w.LMDT, w.LMBy, Note,'
      '       1,'
      '       0'
      'FROM stkPCWaste w'
      'JOIN stkEntity se'
      'ON w.EntityCode = se.EntityCode'
      'LEFT JOIN Threads t'
      'ON se.Div = t.Division'
      'WHERE t.Tid is null'
      'AND (w.Deleted = 0)'
      'AND ((w.WasteFlag = '#39'M'#39') or (w.WasteFlag = '#39'P'#39'))'
      ''
      '')
    Left = 64
    Top = 72
  end
  object adotPCWaste: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    IndexFieldNames = 'Div;Cat;Scat;Name;WasteDT DESC'
    TableName = '#stkPCwaste'
    Left = 32
    Top = 40
    object adotPCWasteSCat: TStringField
      DisplayLabel = 'Sub-Cat'
      DisplayWidth = 20
      FieldName = 'SCat'
    end
    object adotPCWasteName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 40
    end
    object adotPCWasteWValue: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'WValue'
      OnGetText = adotPCWasteWValueGetText
    end
    object adotPCWasteUnit: TStringField
      DisplayWidth = 10
      FieldName = 'Unit'
      Size = 10
    end
    object adotPCWasteWasteDT: TDateTimeField
      DisplayLabel = 'Waste Date'
      DisplayWidth = 18
      FieldName = 'WasteDT'
    end
    object adotPCWasteWasteBy: TStringField
      DisplayLabel = 'Entered By'
      DisplayWidth = 20
      FieldName = 'WasteBy'
    end
    object adotPCWasteSiteCode: TSmallintField
      FieldName = 'SiteCode'
      Visible = False
    end
    object adotPCWasteHzID: TSmallintField
      FieldName = 'HzID'
      Visible = False
    end
    object adotPCWasteEntityCode: TFloatField
      FieldName = 'EntityCode'
      Visible = False
    end
    object adotPCWasteBsDate: TDateTimeField
      FieldName = 'BsDate'
      Visible = False
    end
    object adotPCWasteBaseUnits: TFloatField
      FieldName = 'BaseUnits'
      Visible = False
    end
    object adotPCWasteWasteFlag: TStringField
      FieldName = 'WasteFlag'
      Visible = False
      Size = 1
    end
    object adotPCWasteLMDT: TDateTimeField
      FieldName = 'LMDT'
      Visible = False
    end
    object adotPCWasteLMBy: TStringField
      FieldName = 'LMBy'
      Visible = False
    end
    object adotPCWasteNote: TStringField
      FieldName = 'Note'
      Visible = False
      Size = 255
    end
    object adotPCWasteDiv: TStringField
      DisplayWidth = 20
      FieldName = 'Div'
      Visible = False
    end
    object adotPCWasteCat: TStringField
      DisplayWidth = 20
      FieldName = 'Cat'
      Visible = False
    end
    object adotPCWasteDeleteable: TBooleanField
      FieldName = 'Deleteable'
    end
  end
  object dsPCWaste: TDataSource
    DataSet = adotPCWaste
    Left = 64
    Top = 40
  end
  object adoqBuildTempstkPCWaste: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'IF object_id('#39'tempdb..#stkPCWaste'#39') IS NOT NULL DROP TABLE #stkP' +
        'CWaste'
      ''
      'CREATE TABLE #stkPCWaste ('
      '  [SiteCode] [smallint],'
      '  [HzID] [smallint],'
      '  [EntityCode] [float],'
      '  [Name] [varchar](40),'
      '  [Div] [varchar](20),'
      '  [Cat] [varchar](20),'
      '  [SCat] [varchar](20),'
      '  [WasteDT] [datetime],'
      '  [BsDate] [datetime],'
      '  [Unit] [varchar](10),'
      '  [WValue] [float],'
      '  [BaseUnits] [float],'
      '  [WasteBy] [varchar](20),'
      '  [WasteFlag] [varchar](1),'
      '  [LMDT] [datetime],'
      '  [LMBy] [varchar](20),'
      '  [Note] [varchar](255),'
      '  [Deleteable] [bit],'
      '  [Stocked] [bit]'
      ')')
    Left = 32
    Top = 72
  end
  object ppReportPCWaste: TppReport
    AutoStop = False
    DataPipeline = ppDBPipelinePCWaste
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
    OnPreviewFormCreate = ppReportPCWastePreviewFormCreate
    Left = 64
    Top = 136
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipelinePCWaste'
    object ppHeaderBand1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 21696
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
        Caption = 'Waste'
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
        Weight = 0.75
        mmHeight = 2117
        mmLeft = 0
        mmTop = 19579
        mmWidth = 198967
        BandType = 0
      end
      object pplToLabel: TppLabel
        UserName = 'lToLabel'
        Caption = 'To:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 89694
        mmTop = 15081
        mmWidth = 8731
        BandType = 0
      end
      object pplFromLabel: TppLabel
        UserName = 'lFromLabel'
        Caption = 'From:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 89429
        mmTop = 10319
        mmWidth = 8975
        BandType = 0
      end
      object pplFromField: TppLabel
        UserName = 'lFromField'
        AutoSize = False
        Caption = 'dd-mm-yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 99219
        mmTop = 10319
        mmWidth = 19050
        BandType = 0
      end
      object pplToField: TppLabel
        UserName = 'lToField'
        AutoSize = False
        Caption = 'dd-mm-yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 99219
        mmTop = 15081
        mmWidth = 19050
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      BeforePrint = ppDetailBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        OnGetText = ppDBText4GetText
        DataField = 'WValue'
        DataPipeline = ppDBPipelinePCWaste
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipelinePCWaste'
        mmHeight = 3598
        mmLeft = 80433
        mmTop = 1059
        mmWidth = 14817
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'Unit'
        DataPipeline = ppDBPipelinePCWaste
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelinePCWaste'
        mmHeight = 3598
        mmLeft = 96838
        mmTop = 1059
        mmWidth = 23548
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5821
        mmLeft = 0
        mmTop = 0
        mmWidth = 529
        BandType = 4
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 96044
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 123825
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 158221
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 5821
        mmLeft = 196057
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Name'
        DataPipeline = ppDBPipelinePCWaste
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'ppDBPipelinePCWaste'
        mmHeight = 3704
        mmLeft = 1058
        mmTop = 1058
        mmWidth = 77788
        BandType = 4
      end
      object ppLine16: TppLine
        UserName = 'Line16'
        Position = lpLeft
        Weight = 0.75
        mmHeight = 5821
        mmLeft = 79640
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'WasteDT'
        DataPipeline = ppDBPipelinePCWaste
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelinePCWaste'
        mmHeight = 3598
        mmLeft = 124619
        mmTop = 1059
        mmWidth = 32808
        BandType = 4
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 4763
        mmWidth = 196321
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'WasteBy'
        DataPipeline = ppDBPipelinePCWaste
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelinePCWaste'
        mmHeight = 3598
        mmLeft = 159015
        mmTop = 1058
        mmWidth = 36777
        BandType = 4
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'P'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 196850
        mmTop = 1058
        mmWidth = 2117
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 12171
      mmPrintPosition = 0
      object ppLabelFilterStatus: TppLabel
        UserName = 'LabelFilterStatus'
        Caption = 'Report Filters:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold, fsItalic]
        Transparent = True
        mmHeight = 3683
        mmLeft = 794
        mmTop = 1323
        mmWidth = 21759
        BandType = 8
      end
      object ppMemoFilters: TppMemo
        UserName = 'MemoFilters'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsItalic]
        Stretch = True
        Transparent = True
        mmHeight = 9525
        mmLeft = 23813
        mmTop = 1323
        mmWidth = 175155
        BandType = 8
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'SCat'
      DataPipeline = ppDBPipelinePCWaste
      KeepTogether = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipelinePCWaste'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 11906
        mmPrintPosition = 0
        object ppLine1: TppLine
          UserName = 'Line1'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 0
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine10: TppLine
          UserName = 'Line10'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 0
          mmTop = 5821
          mmWidth = 196321
          BandType = 3
          GroupNo = 0
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 196057
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine13: TppLine
          UserName = 'Line13'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 79640
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine14: TppLine
          UserName = 'Line14'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 96044
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine15: TppLine
          UserName = 'Line15'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 123825
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLine17: TppLine
          UserName = 'Line17'
          Position = lpLeft
          Weight = 0.75
          mmHeight = 6085
          mmLeft = 158221
          mmTop = 5821
          mmWidth = 1852
          BandType = 3
          GroupNo = 0
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4498
          mmLeft = 529
          mmTop = 6615
          mmWidth = 78317
          BandType = 3
          GroupNo = 0
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          Caption = 'Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4498
          mmLeft = 80433
          mmTop = 6615
          mmWidth = 6350
          BandType = 3
          GroupNo = 0
        end
        object ppLabel10: TppLabel
          UserName = 'Label10'
          Caption = 'Unit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4498
          mmLeft = 96838
          mmTop = 6615
          mmWidth = 7673
          BandType = 3
          GroupNo = 0
        end
        object ppLabel11: TppLabel
          UserName = 'Label11'
          Caption = 'Entered'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4498
          mmLeft = 124619
          mmTop = 6615
          mmWidth = 15875
          BandType = 3
          GroupNo = 0
        end
        object ppLabel13: TppLabel
          UserName = 'Label13'
          AutoSize = False
          Caption = 'Entered By'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 4498
          mmLeft = 159015
          mmTop = 6615
          mmWidth = 20902
          BandType = 3
          GroupNo = 0
        end
        object ppLine9: TppLine
          UserName = 'Line9'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1323
          mmLeft = 0
          mmTop = 10583
          mmWidth = 196057
          BandType = 3
          GroupNo = 0
        end
        object ppLine18: TppLine
          UserName = 'Line18'
          Pen.Width = 2
          Position = lpLeft
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 0
          mmTop = 0
          mmWidth = 1588
          BandType = 3
          GroupNo = 0
        end
        object ppLine19: TppLine
          UserName = 'Line19'
          Pen.Width = 2
          Position = lpRight
          Weight = 1.5
          mmHeight = 6085
          mmLeft = 55033
          mmTop = 0
          mmWidth = 2910
          BandType = 3
          GroupNo = 0
        end
        object ppLine20: TppLine
          UserName = 'Line20'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 0
          mmTop = 0
          mmWidth = 57679
          BandType = 3
          GroupNo = 0
        end
        object ppDBText6: TppDBText
          UserName = 'DBText6'
          DataField = 'SCat'
          DataPipeline = ppDBPipelinePCWaste
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppDBPipelinePCWaste'
          mmHeight = 4498
          mmLeft = 794
          mmTop = 794
          mmWidth = 56092
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 2117
        mmPrintPosition = 0
        object ppLine4: TppLine
          UserName = 'Line4'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 2117
          mmLeft = 0
          mmTop = 0
          mmWidth = 196586
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object ppDBPipelinePCWaste: TppDBPipeline
    DataSource = dsPCWaste
    UserName = 'DBPipelinePCWaste'
    Left = 32
    Top = 136
    object ppDBPipelinePCWasteppField1: TppField
      FieldAlias = 'SCat'
      FieldName = 'SCat'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField2: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField3: TppField
      FieldAlias = 'WValue'
      FieldName = 'WValue'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField4: TppField
      FieldAlias = 'Unit'
      FieldName = 'Unit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField5: TppField
      FieldAlias = 'WasteDT'
      FieldName = 'WasteDT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField6: TppField
      FieldAlias = 'WasteBy'
      FieldName = 'WasteBy'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField7: TppField
      FieldAlias = 'SiteCode'
      FieldName = 'SiteCode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField8: TppField
      FieldAlias = 'HzID'
      FieldName = 'HzID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField9: TppField
      FieldAlias = 'EntityCode'
      FieldName = 'EntityCode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField10: TppField
      FieldAlias = 'BsDate'
      FieldName = 'BsDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField11: TppField
      FieldAlias = 'BaseUnits'
      FieldName = 'BaseUnits'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField12: TppField
      FieldAlias = 'WasteFlag'
      FieldName = 'WasteFlag'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField13: TppField
      FieldAlias = 'LMDT'
      FieldName = 'LMDT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField14: TppField
      FieldAlias = 'LMBy'
      FieldName = 'LMBy'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField15: TppField
      FieldAlias = 'Note'
      FieldName = 'Note'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField16: TppField
      FieldAlias = 'Div'
      FieldName = 'Div'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField17: TppField
      FieldAlias = 'Cat'
      FieldName = 'Cat'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePCWasteppField18: TppField
      FieldAlias = 'Deleteable'
      FieldName = 'Deleteable'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
  end
end
