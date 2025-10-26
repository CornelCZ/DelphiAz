object fgetinvdlg: Tfgetinvdlg
  Left = 383
  Top = 139
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Search...'
  ClientHeight = 404
  ClientWidth = 617
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 89
    Align = alTop
    TabOrder = 0
    object Bevel1: TBevel
      Left = 4
      Top = 6
      Width = 611
      Height = 45
    end
    object SpeedBtnSupplier: TSpeedButton
      Left = 225
      Top = 12
      Width = 127
      Height = 34
      GroupIndex = 1
      Down = True
      Caption = 'Supplier (F5)'
      OnClick = SpeedBtnSupplierClick
    end
    object SpeedBtnDelNote: TSpeedButton
      Left = 352
      Top = 12
      Width = 134
      Height = 34
      GroupIndex = 1
      Caption = 'Invoice No. (F6)'
      OnClick = SpeedBtnDelNoteClick
    end
    object SpeedBtnDate: TSpeedButton
      Left = 486
      Top = 12
      Width = 125
      Height = 34
      GroupIndex = 1
      Caption = 'Date (F7)'
      OnClick = SpeedBtnDateClick
    end
    object Label1: TLabel
      Left = 12
      Top = 11
      Width = 181
      Height = 34
      AutoSize = False
      Caption = 'Choose field to order by and search :'
      Layout = tlCenter
      WordWrap = True
    end
    object Label3: TLabel
      Left = 12
      Top = 62
      Width = 169
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Search on Supplier:'
    end
    object suppsearch: TwwIncrementalSearch
      Left = 189
      Top = 58
      Width = 250
      Height = 24
      DataSource = dsInvoiceList
      SearchField = 'Supplier Name'
      TabOrder = 0
    end
    object btnFreeze: TBitBtn
      Left = 473
      Top = 54
      Width = 138
      Height = 31
      Caption = 'Freeze Selected'
      TabOrder = 1
      OnClick = btnFreezeClick
      Glyph.Data = {
        BA050000424DBA0500000000000042000000280000001B000000190000000100
        1000030000007805000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        FF0300001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF03100200001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C00001F7C0000FF03FF7FFF0300001F7C00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF03
        FF7FFF031002FF03FF7FFF031002FF03FF7FFF0300001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C0000FF0300000000FF7FFF03FF7F
        FF031002FF03FF7F00000000FF0300001F7C1F7C1F7C1F7C1F7C1F7C00001F7C
        0000000000001F7C1F7C0000FF7F00001F7C00000000FF03FF7FFF0300000000
        1F7C0000FF7F00001F7C1F7C0000000000001F7C00000000FF031002FF030000
        00000000FF0300001F7C1F7C0000FF7FFF03100200001F7C1F7C0000FF030000
        00000000FF031002FF03000000000000FF7FFF03FF7FFF031002FF03FF7F0000
        1F7C1F7C0000FF03FF7FFF0300001F7C1F7C0000FF7FFF031002FF03FF7FFF03
        FF7F000000001F7C0000FF7FFF03FF7FFF03FF7F1002000000001F7C0000FF7F
        FF03100200001F7C00000000FF03FF7FFF03FF7FFF03FF7F00001F7C00001F7C
        1F7C1F7C0000FF7FFF03FF7FFF03FF7FFF031002FF03FF7FFF03FF7FFF031002
        FF03FF7FFF03FF7FFF03FF7F00001F7C1F7C1F7C00001F7C1F7C00001002FF03
        FF7F00000000FF03FF7FFF03FF7FFF03FF7FFF03FF7FFF03FF7FFF0300000000
        FF7FFF03FF7F00001F7C1F7C00001F7C00001002FF03000000001F7C1F7C0000
        0000FF7FFF03FF7FFF03FF7FFF03FF7F000000001F7C1F7C00000000FF03FF7F
        00001F7C00001F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF03
        FF7FFF03FF7F00001F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C00001F7C
        00001002FF03000000001F7C1F7C000000001002FF03FF7FFF03FF7FFF031002
        000000001F7C1F7C000000001002FF7F00001F7C00001F7C1F7C0000FF7FFF03
        100200000000FF031002FF03FF7FFF03FF7FFF03FF7FFF031002FF0300000000
        1002FF03FF7F00001F7C1F7C00001F7C1F7C1F7C0000FF7FFF031002FF03FF7F
        FF03FF7FFF03FF7FFF03FF7FFF03FF7FFF03FF7FFF031002FF03FF7F00001F7C
        1F7C1F7C00001F7C00001002FF03FF7FFF03FF7FFF03000000001F7C0000FF7F
        FF03100200001F7C00000000FF03FF7FFF03FF7FFF03100200001F7C00000000
        1002FF03FF7FFF03FF7FFF03FF7F00001F7C1F7C0000FF03FF7FFF0300001F7C
        1F7C0000FF7FFF03FF7FFF03FF7FFF031002000000000000FF03FF7FFF030000
        00000000FF0300001F7C1F7C0000FF7FFF03100200001F7C1F7C0000FF030000
        00000000FF03FF7FFF03000000001F7C0000000000001F7C1F7C0000FF7F0000
        1F7C00000000FF03FF7FFF03000000001F7C0000FF7F00001F7C1F7C00000000
        00001F7C00001F7C1F7C1F7C1F7C1F7C1F7C0000FF03000000001002FF03FF7F
        FF031002FF03FF7F00000000FF0300001F7C1F7C1F7C1F7C1F7C1F7C00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF031002FF03FF7FFF03FF7FFF03FF7FFF03
        FF7FFF0300001F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C00001F7C0000FF03FF7FFF0300001F7C00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000FF7FFF03100200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        FF7F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 617
    Height = 260
    Align = alClient
    TabOrder = 1
    object dbGridInvoiceList: TwwDBGrid
      Left = 1
      Top = 1
      Width = 615
      Height = 258
      ControlType.Strings = (
        'Frozen;CheckBox;1;0')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsInvoiceList
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnDblClick = dbGridInvoiceListDblClick
      OnKeyDown = dbGridInvoiceListKeyDown
      OnMouseUp = dbGridInvoiceListMouseUp
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 349
    Width = 617
    Height = 55
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 173
      Top = 9
      Width = 119
      Height = 36
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 325
      Top = 9
      Width = 119
      Height = 36
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object dsInvoiceList: TwwDataSource
    Left = 550
    Top = 112
  end
  object qryAuditCurrent: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <
      item
        Name = 'onlyValidSuppliers'
        DataType = ftBoolean
        Size = -1
        Value = False
      end>
    SQL.Strings = (
      'DECLARE @OnlyValidSuppliers bit'
      'SET @OnlyValidSuppliers = :onlyValidSuppliers'
      ''
      'IF @OnlyValidSuppliers = 1'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.], ph.[Date],'
      
        '         ph.LMDT, p.[Total Amount], ph.[Order No], ph.Frozen, ph' +
        '.Note, ph.FrozenBy, ph.FrozenOn,'
      '         MaskID ='
      '           case'
      '             when sm.CurrentMask is null then 0'
      '           else ISNULL(ph.[MaskID],0)'
      '           end'
      '  FROM PurchHdrAztec ph'
      '    INNER JOIN'
      '      (SELECT s2.[Supplier Name], s1.SiteID'
      
        '       FROM (SELECT * FROM ac_SiteSuppliers WHERE SiteId = dbo.f' +
        'nGetSiteCode()) s1'
      
        '       LEFT OUTER JOIN Supplier s2 ON s1.SupplierID = s2.[Suppli' +
        'er Code]'
      '       UNION'
      
        '       SELECT vts.SiteName AS [Supplier Name], dbo.fnGetSiteCode' +
        '() AS SiteID'
      '       FROM ValidTransferSites vts) s'
      
        '    ON ph.[Site Code] = s.SiteID AND ph.[Supplier Name] = s.[Sup' +
        'plier Name]'
      '    LEFT OUTER JOIN'
      
        '      (SELECT [Site Code], [Supplier Name], [Delivery Note No.],' +
        ' SUM([Total Cost]) AS [Total Amount]'
      '       FROM [Purchase]'
      
        '       GROUP BY [Site Code], [Supplier Name], [Delivery Note No.' +
        ']) p'
      
        '    ON ph.[Site Code] = p.[Site Code] AND ph.[Supplier Name] = p' +
        '.[Supplier Name] AND ph.[Delivery Note No.] = p.[Delivery Note N' +
        'o.]'
      '    LEFT OUTER JOIN SupplierMask sm'
      
        '    ON p.[Supplier Name] = sm.[Supplier Name] and ph.[MaskID] = ' +
        'sm.[MaskID]'
      '  WHERE ISNULL(ph.deleted,'#39'N'#39') <> '#39'Y'#39
      '  ORDER BY ph.[Supplier Name]'
      'ELSE'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.], ph.[Date],'
      
        '         ph.LMDT, p.[Total Amount], ph.[Order No], ph.Frozen, ph' +
        '.Note, ph.FrozenBy, ph.FrozenOn,'
      '         MaskID ='
      '           case'
      '             when sm.CurrentMask is null then 0'
      '           else ISNULL(ph.[MaskID],0)'
      '           end'
      '  FROM PurchHdrAztec ph LEFT OUTER JOIN'
      
        '    (SELECT [Site Code], [Supplier Name], [Delivery Note No.], S' +
        'UM([Total Cost]) AS [Total Amount]'
      '     FROM [Purchase]'
      
        '     GROUP BY [Site Code], [Supplier Name], [Delivery Note No.])' +
        ' p '
      '       ON ph.[Site Code] = p.[Site Code]'
      '       AND ph.[Supplier Name] = p.[Supplier Name]'
      
        '       AND ph.[Delivery Note No.] = p.[Delivery Note No.] LEFT O' +
        'UTER JOIN SupplierMask sm'
      
        '          ON p.[Supplier Name] = sm.[Supplier Name] and ph.[Mask' +
        'ID] = sm.[MaskID]'
      '  WHERE ISNULL(ph.deleted,'#39'N'#39') <> '#39'Y'#39
      '  ORDER BY ph.[Supplier Name]'
      '')
    Left = 165
    Top = 62
  end
  object qryNonAuditCurrent: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'onlyValidSuppliers'
        DataType = ftBoolean
        Size = 1
        Value = False
      end>
    SQL.Strings = (
      'DECLARE @OnlyValidSuppliers bit'
      'SET @OnlyValidSuppliers = :onlyValidSuppliers'
      ''
      'IF @OnlyValidSuppliers = 1'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.],'
      '         ph.[Date], ph.[LMDT], ph.[Note], ph.[Order No],'
      '         MaskID ='
      '           CASE'
      '             WHEN sm.CurrentMask IS NULL THEN 0'
      '           ELSE ISNULL(ph.[MaskID],0)'
      '           END'
      '  FROM [PurchHdrAztec] ph'
      '    INNER JOIN'
      '      (SELECT s2.[Supplier Name], s1.SiteID'
      
        '       FROM (SELECT * FROM ac_SiteSuppliers WHERE SiteId = dbo.f' +
        'nGetSiteCode()) s1'
      
        '       LEFT OUTER JOIN Supplier s2 ON s1.SupplierID = s2.[Suppli' +
        'er Code]'
      '       UNION'
      
        '       SELECT vts.SiteName AS [Supplier Name], dbo.fnGetSiteCode' +
        '() AS SiteID'
      '       FROM ValidTransferSites vts) s'
      
        '    ON ph.[Site Code] = s.SiteID AND ph.[Supplier Name] = s.[Sup' +
        'plier Name]'
      '    LEFT OUTER JOIN'
      '      SupplierMask sm'
      
        '    ON ph.[Supplier Name] = sm.[Supplier Name] AND ph.[MaskID] =' +
        ' sm.[MaskID]'
      '  WHERE ISNULL(ph.deleted,'#39'N'#39') <> '#39'Y'#39
      '  ORDER BY ph.[Supplier Name]'
      'ELSE'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.],'
      '         ph.[Date], ph.[LMDT], ph.[Note], ph.[Order No], '
      '         MaskID ='
      '           CASE '
      '             WHEN sm.CurrentMask IS NULL THEN 0'
      '           ELSE ISNULL(ph.[MaskID],0)'
      '           END'
      '  FROM [PurchHdrAztec] ph LEFT OUTER JOIN SupplierMask sm'
      
        '  ON ph.[Supplier Name] = sm.[Supplier Name] AND ph.[MaskID] = s' +
        'm.[MaskID]'
      '  WHERE ISNULL(ph.deleted,'#39'N'#39') <> '#39'Y'#39
      '  ORDER BY ph.[Supplier Name]'
      '')
    Left = 273
    Top = 78
  end
  object qryAccepted: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'onlyValidSuppliers'
        DataType = ftBoolean
        Size = -1
        Value = False
      end>
    SQL.Strings = (
      'DECLARE @OnlyValidSuppliers bit'
      'SET @OnlyValidSuppliers = :onlyValidSuppliers'
      ''
      'IF @OnlyValidSuppliers = 1'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.],'
      '         ph.[Date], ph.[Total Amount], ph.[Note], ph.[Order No]'
      '  FROM [AccPurHd] ph'
      '  INNER JOIN'
      '    (SELECT s2.[Supplier Name], s1.SiteID'
      
        '     FROM (SELECT * FROM ac_SiteSuppliers WHERE SiteId = dbo.fnG' +
        'etSiteCode()) s1'
      
        '           LEFT OUTER JOIN Supplier s2 ON s1.SupplierID = s2.[Su' +
        'pplier Code]'
      '           UNION'
      
        '           SELECT vts.SiteName AS [Supplier Name], dbo.fnGetSite' +
        'Code() AS SiteID'
      '           FROM ValidTransferSites vts) s'
      
        '  ON ph.[Site Code] = s.SiteID AND ph.[Supplier Name] = s.[Suppl' +
        'ier Name]'
      '  ORDER BY ph.[Supplier Name]'
      'ELSE'
      
        '  SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note N' +
        'o.],'
      '         ph.[Date], ph.[Total Amount], ph.[Note], ph.[Order No]'
      '  FROM [AccPurHd] ph'
      '  ORDER BY ph.[Supplier Name]'
      ''
      ''
      '')
    Left = 370
    Top = 118
  end
  object qryAccByDate: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT ph.[Site Code], ph.[Supplier Name], ph.[Delivery Note No.' +
        '], '
      ' ph.[Date], ph.[Total Amount], ph.[Note], ph.[Order No]'
      'FROM [AccPurHd] ph '
      'ORDER BY ph.[Date] Desc, [Supplier Name]')
    Left = 368
    Top = 160
  end
end
