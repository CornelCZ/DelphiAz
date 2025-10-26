object fHZMoveImportDelivery: TfHZMoveImportDelivery
  Left = 314
  Top = 235
  HelpContext = 1052
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Import From Delivery Note'
  ClientHeight = 550
  ClientWidth = 704
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
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 512
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object DeliveryNotePanel: TPanel
      Left = 1
      Top = 1
      Width = 344
      Height = 510
      Align = alLeft
      BevelOuter = bvLowered
      Constraints.MinHeight = 100
      TabOrder = 0
      object PanelSearch: TPanel
        Left = 1
        Top = 396
        Width = 342
        Height = 113
        Align = alBottom
        TabOrder = 0
        object LabelDelNoteNoSearch: TLabel
          Left = 8
          Top = 43
          Width = 150
          Height = 13
          Caption = 'Delivery Note No. Search:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelF7: TLabel
          Left = 149
          Top = 65
          Width = 23
          Height = 13
          Caption = '(F7)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelF8: TLabel
          Left = 299
          Top = 65
          Width = 23
          Height = 13
          Caption = '(F8)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelSupplierFilter: TLabel
          Left = 8
          Top = 8
          Width = 137
          Height = 13
          Caption = 'Filter By Supplier Name:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 4
          Top = 29
          Width = 333
          Height = 2
          Style = bsRaised
        end
        object EditMidwordSearchDeliveryNoteNo: TEdit
          Left = 172
          Top = 38
          Width = 166
          Height = 21
          TabOrder = 0
          Visible = False
        end
        object RadioButtonIncremental: TRadioButton
          Left = 33
          Top = 65
          Width = 113
          Height = 17
          Action = ActionIncrementalSearch
          TabOrder = 1
          TabStop = True
        end
        object RadioButtonMidword: TRadioButton
          Left = 191
          Top = 65
          Width = 105
          Height = 17
          Action = ActionMidwordSearch
          TabOrder = 2
          TabStop = True
        end
        object BitBtnPrev: TBitBtn
          Left = 185
          Top = 84
          Width = 75
          Height = 25
          Action = ActionSearchPrev
          Caption = 'Prev (F2)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          Glyph.Data = {
            6A000000424D6A000000000000003E000000280000000A0000000B0000000100
            0100000000002C0000000000000000000000020000000200000000000000FFFF
            FF00FFC0000000000000000000008040000080400000C0C00000C0C00000E1C0
            0000E1C00000F3C00000F3C00000}
          Spacing = 3
        end
        object BitBtnNext: TBitBtn
          Left = 263
          Top = 84
          Width = 75
          Height = 25
          Action = ActionSearchNext
          Caption = 'Next (F3)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Glyph.Data = {
            6A000000424D6A000000000000003E000000280000000A0000000B0000000100
            0100000000002C0000000000000000000000020000000200000000000000FFFF
            FF00FFC00000F3C00000F3C00000E1C00000E1C00000C0C00000C0C000008040
            0000804000000000000000000000}
        end
        object wwIncrementalSearchDeliveryNoteNo: TwwIncrementalSearch
          Left = 172
          Top = 38
          Width = 166
          Height = 21
          DataSource = DataSourceDeliveries
          SearchField = 'DeliveryNoteNo'
          TabOrder = 5
        end
        object ComboBoxSupplierFilter: TComboBox
          Left = 172
          Top = 5
          Width = 166
          Height = 21
          ItemHeight = 13
          TabOrder = 6
          OnChange = ComboBoxSupplierFilterChange
        end
      end
      object PanelDeliveryNote: TPanel
        Left = 1
        Top = 1
        Width = 342
        Height = 395
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          342
          395)
        object DeliveryNotesLabel: TLabel
          Left = 8
          Top = 8
          Width = 88
          Height = 13
          Caption = 'Delivery Notes:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object DeliveryNotesDBGrid: TwwDBGrid
          Left = 8
          Top = 29
          Width = 329
          Height = 359
          Selected.Strings = (
            'SupplierName'#9'20'#9'Supplier Name'#9'F'
            'DeliveryNoteNo'#9'15'#9'Delivery Note No'#9'F'
            'Date'#9'10'#9'Date'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = DataSourceDeliveries
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
          UseTFields = False
        end
      end
    end
    object Panel1: TPanel
      Left = 345
      Top = 1
      Width = 358
      Height = 510
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      Constraints.MinHeight = 100
      TabOrder = 1
      DesignSize = (
        358
        510)
      object ProductsLabel: TLabel
        Left = 8
        Top = 8
        Width = 108
        Height = 13
        Caption = 'Included Products:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object ProductDetailDBGrid: TwwDBGrid
        Left = 8
        Top = 30
        Width = 344
        Height = 475
        Selected.Strings = (
          'Purchase Name'#9'20'#9'Purchase Name'
          'Flavour'#9'10'#9'Flavour'
          'Unit Name'#9'10'#9'Unit Name'
          'Quantity'#9'8'#9'Qty'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = DataSourceADODeliveryProducts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
      end
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 512
    Width = 704
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      704
      38)
    object BitBtnCancel: TBitBtn
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
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
    object BitBtnImport: TBitBtn
      Left = 540
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Import'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnImportClick
    end
  end
  object ADOQueryDeliveries: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'DECLARE @LastAcc datetime'
      ''
      
        '--Take the oldest accepted date from the set of most recent acce' +
        'pted'
      
        '--stocks i.e. MIN(MAX(AccDate)) grouped by thread.  If there has' +
        ' been'
      '--no accepted stocks for a thread then take the last 30 days.'
      'SELECT @LastAcc = MIN(sub.LastAccepted)'
      
        'FROM (SELECT t.tid, MAX(ISNULL(AccDate,DATEADD(d,-30,GETDATE()))' +
        ') AS LastAccepted'
      'FROM threads t'
      'left JOIN stocks s'
      'ON s.tid = t.tid'
      'WHERE t.Active = '#39'Y'#39
      'GROUP BY t.tid'
      ') SUB'
      ''
      
        'SELECT ph.[Site Code] as SiteCode, ph.[Supplier Name] as Supplie' +
        'rName,'
      
        'ph.[Delivery Note No.] as DeliveryNoteNo, ph.[Date] as [Date], 0' +
        ' as Curr'
      'FROM [AccPurHd] ph'
      'WHERE Date >=  @LastAcc '
      ''
      'UNION ALL'
      ''
      
        'SELECT ph.[Site Code] as SiteCode, ph.[Supplier Name] as Supplie' +
        'rName,'
      
        'ph.[Delivery Note No.] as DeliveryNoteNo, ph.[Date] as [Date], 1' +
        ' as Curr'
      'FROM [PurchHdr] ph'
      'WHERE IsNull(Deleted,'#39'N'#39') <> '#39'Y'#39
      'AND Date >=  @LastAcc '
      ''
      ''
      'ORDER BY ph.[Date] desc')
    Left = 30
    Top = 56
  end
  object DataSourceDeliveries: TDataSource
    DataSet = ADOQueryDeliveries
    Left = 64
    Top = 56
  end
  object DataSourceADODeliveryProducts: TDataSource
    DataSet = ADOQueryDeliveryProducts
    Left = 406
    Top = 56
  end
  object ADOQueryDeliveryProducts: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = DataSourceDeliveries
    Parameters = <
      item
        Name = 'Curr'
        DataType = ftInteger
        Value = 1
      end
      item
        Name = 'SiteCode'
        DataType = ftSmallint
        Value = 5001
      end
      item
        Name = 'SupplierName'
        DataType = ftString
        Size = 20
        Value = 'Exel'
      end
      item
        Name = 'DeliveryNoteNo'
        DataType = ftString
        Size = 15
        Value = '1246600488'
      end>
    SQL.Strings = (
      'declare @currdelnote bit'
      'declare @sitecode smallint'
      'declare @suppliername varchar(20)'
      'declare @delnoteno varchar(15)'
      ''
      'set @currdelnote = :Curr'
      'set @sitecode = :sitecode'
      'set @suppliername = :suppliername'
      'set @delnoteno = :deliverynoteno'
      ''
      'if (@currdelnote = 1)'
      'begin'
      
        '  select [Purchase Name], Flavour, [Unit Name], Quantity from Pu' +
        'rchase p'
      '  where p.[site code] = @sitecode'
      '  and p.[supplier name] = @suppliername'
      '  and p.[Delivery Note No.]  = @delnoteno'
      '  order by p.[record id]'
      'end'
      'else'
      'begin'
      
        '  select [Purchase Name], Flavour, [Unit Name], Quantity from Ac' +
        'cPurch ap'
      '  where ap.[site code] = @sitecode'
      '  and ap.[supplier name] = @suppliername'
      '  and ap.[Delivery Note No.]  =  @delnoteno'
      '  order by ap.[record id]'
      'end')
    Left = 372
    Top = 56
  end
  object ActionList: TActionList
    Left = 64
    Top = 88
    object ActionIncrementalSearch: TAction
      AutoCheck = True
      Caption = 'Incremental Search'
      Checked = True
      GroupIndex = 1
      ShortCut = 118
      OnExecute = ActionIncrementalSearchExecute
    end
    object ActionMidwordSearch: TAction
      AutoCheck = True
      Caption = 'Mid-Word Search'
      GroupIndex = 1
      ShortCut = 119
      OnExecute = ActionMidwordSearchExecute
    end
    object ActionSearchNext: TAction
      Caption = 'Next (F3)'
      ShortCut = 114
      OnExecute = ActionSearchNextExecute
    end
    object ActionSearchPrev: TAction
      Caption = 'Prev (F2)'
      ShortCut = 113
      OnExecute = ActionSearchPrevExecute
    end
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = DataSourceDeliveries
    SearchField = 'DeliveryNoteNo'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Left = 30
    Top = 88
  end
end
