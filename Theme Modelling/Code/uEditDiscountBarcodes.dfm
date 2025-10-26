object EditDiscountBarcodes: TEditDiscountBarcodes
  Left = 361
  Top = 395
  BorderStyle = bsSingle
  BorderWidth = 1
  Caption = 'Discount Barcodes'
  ClientHeight = 366
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblDiscount: TLabel
      Left = 10
      Top = 12
      Width = 48
      Height = 13
      Caption = 'Discount: '
    end
    object lblDiscountName: TLabel
      Left = 62
      Top = 12
      Width = 97
      Height = 13
      Caption = '<discount name>'
      Color = clScrollBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object pnlData: TPanel
    Left = 0
    Top = 41
    Width = 631
    Height = 284
    Align = alClient
    TabOrder = 1
    object pnlGrid: TPanel
      Left = 1
      Top = 57
      Width = 629
      Height = 226
      Align = alClient
      TabOrder = 1
      object lblAssignedBarcodes: TLabel
        Left = 10
        Top = 13
        Width = 94
        Height = 13
        Caption = 'Assigned Barcodes:'
      end
      object grdDiscountBarcodes: TwwDBGrid
        Left = 10
        Top = 32
        Width = 527
        Height = 185
        TabStop = False
        ControlType.Strings = (
          'FromPromotionalFooter;CheckBox;TRUE;FALSE')
        Selected.Strings = (
          'Barcode'#9'25'#9'Barcode'
          'FromPromotionalFooter'#9'10'#9'From~Promotional~Footer'#9'F'
          'PromotionalFooterName'#9'45'#9'Promotional Footer Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Color = clBtnFace
        DataSource = dsDiscountBarcodes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 3
        TitleButtons = False
        UseTFields = False
      end
      object btnDeleteBarcode: TButton
        Left = 545
        Top = 32
        Width = 75
        Height = 25
        Action = actDeleteBarcode
        TabOrder = 1
      end
    end
    object pnlAddBarcodes: TPanel
      Left = 1
      Top = 1
      Width = 629
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object pnlEnterBarcode: TPanel
        Left = 288
        Top = 0
        Width = 341
        Height = 56
        Align = alRight
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 11
          Width = 71
          Height = 13
          Caption = 'Enter Barcode:'
        end
        object edtEnterBarcode: TEdit
          Left = 10
          Top = 27
          Width = 191
          Height = 21
          TabOrder = 0
        end
        object btnNewBarcode: TButton
          Left = 209
          Top = 25
          Width = 75
          Height = 25
          Action = actEnterBarcode
          TabOrder = 1
        end
      end
      object pnlFooterBarcode: TPanel
        Left = 0
        Top = 0
        Width = 288
        Height = 56
        Align = alClient
        TabOrder = 0
        object lblSelectFooterBarcode: TLabel
          Left = 10
          Top = 11
          Width = 156
          Height = 13
          Caption = 'Add Promotional Footer Barcode:'
        end
        object luFooterBarcodes: TwwDBLookupCombo
          Left = 10
          Top = 27
          Width = 223
          Height = 21
          DropDownAlignment = taLeftJustify
          LookupTable = qryLookUpFooterBarcodes
          LookupField = 'Name'
          Style = csDropDownList
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = luFooterBarcodesCloseUp
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 325
    Width = 631
    Height = 41
    Align = alBottom
    TabOrder = 2
    object pnlButtons: TPanel
      Left = 445
      Top = 1
      Width = 185
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Left = 20
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Save'
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 102
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
  end
  object qryDiscountBarcodes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM #DiscountBarcodes')
    Left = 36
    Top = 208
    object qryDiscountBarcodesBarcode: TStringField
      DisplayWidth = 25
      FieldName = 'Barcode'
      Size = 25
    end
    object qryDiscountBarcodesFromPromotionalFooter: TBooleanField
      DisplayLabel = 'From~Footer'
      DisplayWidth = 5
      FieldName = 'FromPromotionalFooter'
    end
    object qryDiscountBarcodesPromotionalFooterID: TIntegerField
      FieldName = 'PromotionalFooterID'
      Visible = False
    end
    object qryDiscountBarcodesPromotionalFooterName: TStringField
      FieldName = 'PromotionalFooterName'
      Size = 40
    end
  end
  object dsDiscountBarcodes: TDataSource
    DataSet = qryDiscountBarcodes
    Left = 72
    Top = 208
  end
  object ActionList1: TActionList
    Left = 384
    Top = 8
    object actEnterBarcode: TAction
      Caption = 'Add'
      OnExecute = actEnterBarcodeExecute
      OnUpdate = actEnterBarcodeUpdate
    end
    object actDeleteBarcode: TAction
      Caption = 'Delete'
      OnExecute = actDeleteBarcodeExecute
      OnUpdate = actDeleteBarcodeUpdate
    end
  end
  object qryLookUpFooterBarcodes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DiscountID'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT Id, [Name],'
      '       [Barcode]'
      'FROM PromotionalFooter'
      'WHERE Barcode IS NOT NULL'
      'AND Barcode NOT IN'
      '  (SELECT DISTINCT Barcode'
      '   FROM ProductBarCode)'
      'AND Barcode NOT IN'
      '  (SELECT DISTINCT Barcode'
      '   FROM ThemeDiscountBarcode'
      '   WHERE DiscountID <> :DiscountID)'
      'AND Id NOT IN'
      '  (SELECT PromotionalFooterID FROM #DiscountBarcodes'
      '   WHERE PromotionalFooterID IS NOT NULL)'
      'AND Barcode NOT IN'
      '  (SELECT Barcode FROM #DiscountBarcodes'
      '   WHERE PromotionalFooterID IS NOT NULL)'
      ''
      ''
      '')
    Left = 240
    Top = 43
    object qryLookUpFooterBarcodesName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Visible = False
      Size = 40
    end
    object qryLookUpFooterBarcodesBarcode: TStringField
      DisplayWidth = 25
      FieldName = 'Barcode'
      Visible = False
      Size = 25
    end
    object qryLookUpFooterBarcodesId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
      Visible = False
    end
  end
  object qryEnteredBarcodeExists: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'CheckBarcode'
        DataType = ftString
        Size = 2
        Value = #39#39
      end
      item
        Name = 'DiscountID'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      'DECLARE'
      '  @CheckBarcode VARCHAR(20),'
      '  @DiscountID int,'
      '  @Product int,'
      '  @PurchaseUnit int,'
      '  @OtherDiscount int,'
      '  @ThisDiscount int,'
      '  @PaymentMethod int,'
      '  @PromotionalFooter int,'
      '  @WhereFound VARCHAR(850),'
      '  @ObjectDetail VARCHAR(250),'
      '  @IDNum smallint'
      ''
      'SET @CheckBarcode = :CheckBarcode'
      'SET @DiscountID = :DiscountID'
      ''
      'SET @Product = 1'
      'SET @PurchaseUnit = 2'
      'SET @OtherDiscount = 3'
      'SET @ThisDiscount = 4'
      'SET @PaymentMethod = 5'
      'SET @PromotionalFooter = 6'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#TableWithBarcode'#39'))'
      '  DROP TABLE #TableWithBarcode'
      ''
      'CREATE TABLE #TableWithBarcode '
      '('
      '  IDNum smallint IDENTITY(1,1) NOT NULL,'
      '  WhereFound int NOT NULL,'
      '  ObjectType varchar(50) NOT NULL,'
      '  ObjectName varchar(50) NULL,'
      '  SupplierName varchar(50) NULL'
      ')'
      ''
      'INSERT #TableWithBarcode'
      
        'SELECT @OtherDiscount AS WhereFound, '#39'discount'#39' AS ObjectType, d' +
        '.[Name] AS ObjectName, CAST('#39#39' AS VARCHAR(20)) AS SupplierName'
      
        'FROM ThemeDiscountBarcode b JOIN ThemeDiscount d ON d.DiscountID' +
        ' = b.DiscountID'
      'WHERE b.Barcode = @CheckBarcode'
      '  AND b.DiscountID <> @DiscountID'
      '  AND b.Barcode NOT IN (SELECT Barcode FROM #DiscountBarcodes)'
      'UNION'
      
        'SELECT @Product, '#39'product'#39' AS ObjectType, p.[Extended RTL Name] ' +
        'AS ObjectName, CAST('#39#39' AS VARCHAR(20)) AS SupplierName'
      
        'FROM ProductBarcode b JOIN Products p ON p.EntityCode = b.Entity' +
        'Code'
      'WHERE b.Barcode = @CheckBarcode'
      'UNION '
      
        'SELECT @PurchaseUnit, '#39'purchase unit for product'#39' AS ObjectType,' +
        ' p.[Extended RTL Name] AS ObjectName, [Supplier Name] AS Supplie' +
        'rName'
      
        'FROM PurchaseUnits b JOIN Products p ON p.EntityCode = b.[Entity' +
        ' Code]'
      'WHERE b.Barcode = @CheckBarcode'
      'UNION'
      
        'SELECT @ThisDiscount, '#39'this discount'#39' AS ObjectType, CAST('#39#39' AS ' +
        'VARCHAR(20)) AS ObjectName, CAST('#39#39' AS VARCHAR(20)) AS SupplierN' +
        'ame'
      'FROM #DiscountBarcodes'
      'WHERE Barcode = @CheckBarcode'
      'UNION'
      
        'SELECT @PaymentMethod, '#39'payment method'#39' AS ObjectType, p.[Name],' +
        ' CAST('#39#39' AS VARCHAR(20)) AS SupplierName'
      
        'FROM ac_PaymentMethodBarcode b JOIN ac_PaymentMethod p ON p.ID =' +
        ' b.PaymentMethodID '
      'WHERE b.Barcode = @CheckBarcode'
      'UNION'
      
        'SELECT @PromotionalFooter, '#39'promotional footer'#39' AS ObjectType, p' +
        '.[Name], CAST('#39#39' AS VARCHAR(20)) AS SupplierName '
      'FROM PromotionalFooter p '
      'WHERE p.Barcode = @CheckBarcode'
      '  AND p.Barcode NOT IN (SELECT Barcode FROM #DiscountBarcodes)'
      
        '  AND p.Barcode IN (SELECT Barcode FROM ThemeDiscountBarcode WHE' +
        'RE FromPromotionalFooter = 1 AND DiscountID = @DiscountID)'
      'UNION'
      
        'SELECT @PromotionalFooter, '#39'promotional footer'#39' AS ObjectType, p' +
        '.[Name], CAST('#39#39' AS VARCHAR(20)) AS SupplierName '
      'FROM PromotionalFooter p '
      'WHERE p.Barcode = @CheckBarcode'
      '  AND p.Barcode NOT IN (SELECT Barcode FROM #DiscountBarcodes)'
      
        '  AND p.Barcode NOT IN (SELECT Barcode FROM ThemeDiscountBarcode' +
        ')'
      ''
      '  '
      'IF (SELECT COUNT(*) FROM #TableWithBarcode) = 0'
      '  SELECT CAST(0 AS bit) AS BarcodeExists, '#39#39' AS WhereFound'
      'ELSE'
      'BEGIN'
      '  IF (SELECT COUNT(*) FROM #TableWithBarcode) = 1'
      '  BEGIN'
      
        '    SET @WhereFound = '#39'Barcode '#39' + @CheckBarcode + '#39' is already ' +
        'used in '#39' +'
      '     (SELECT'
      '        CASE WhereFound'
      
        '          WHEN 2 THEN (SELECT ObjectType + '#39' "'#39' + ObjectName + '#39 +
        '", supplier "'#39' + SupplierName +'#39'.'#39')'
      '          WHEN 4 THEN (SELECT ObjectType + '#39'.'#39')'
      
        '          WHEN 6 THEN (SELECT ObjectType + '#39' "'#39' + ObjectName + '#39 +
        '" and can only be selected from the footer.'#39')'
      '        ELSE'
      '          (SELECT ObjectType + '#39' "'#39' + ObjectName + '#39'".'#39')'
      '        END'
      '      FROM #TableWithBarcode)'
      '  END  '
      '  ELSE'
      '  BEGIN'
      
        '    SET @WhereFound = '#39'Barcode '#39' + @CheckBarcode + '#39' is already ' +
        'used '#39' + '#39'\n'#39
      '    SET @IDNum = (SELECT MIN(IDNum) FROM #TableWithBarcode)'
      '    SET @ObjectDetail = '
      '          (SELECT '
      '             CASE WhereFound'
      
        '               WHEN 2 THEN (SELECT '#39'  - in '#39' + ObjectType + '#39' "'#39 +
        ' + ObjectName + '#39'", supplier "'#39' + SupplierName + '#39'"'#39')'
      
        '               WHEN 6 THEN (SELECT '#39'  - in '#39' + ObjectType + '#39' "'#39 +
        ' + ObjectName + '#39'" and can only be selected from the footer.'#39')'
      '             ELSE'
      
        '              (SELECT '#39'  - for '#39' + ObjectType + '#39' "'#39' + ObjectNam' +
        'e + '#39'"'#39')  '
      '             END'
      '           FROM #TableWithBarcode WHERE IDNum = @IDNum)'
      ''
      '    WHILE @IDNum IS NOT NULL'
      '    BEGIN '
      '      SET @WhereFound = @WhereFound + '#39'\n'#39' + @ObjectDetail'
      
        '      SET @IDNum = (SELECT MIN(IDNum) FROM #TableWithBarcode WHE' +
        'RE IDNum > @IDNum)'
      '      SET @ObjectDetail = '
      '          (SELECT '
      '             CASE WhereFound'
      
        '               WHEN 2 THEN (SELECT '#39'  - in '#39' + ObjectType + '#39' "'#39 +
        ' + ObjectName + '#39'", supplier "'#39' + SupplierName + '#39'"'#39')'
      
        '               WHEN 6 THEN (SELECT '#39'  - in '#39' + ObjectType + '#39' "'#39 +
        ' + ObjectName + '#39'" and can only be selected from the footer.'#39')'
      '             ELSE'
      
        '               (SELECT '#39'  - for '#39' + ObjectType + '#39' "'#39' + ObjectNa' +
        'me + '#39'"'#39') '
      '             END'
      '           FROM #TableWithBarcode'
      '           WHERE IDNum = @IDNum) '
      '    END'
      '  END'
      
        '  SELECT CAST(1 AS bit) AS BarcodeExists, @WhereFound + '#39'\n\nPle' +
        'ase enter another barcode.'#39' AS WhereFound'
      'END'
      ''
      '')
    Left = 584
    Top = 64
  end
  object qryFooterBarcodeExists: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'CheckBarcode'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'FooterID'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      'DECLARE'
      '  @CheckBarcode VARCHAR(20),'
      '  @SelectedFooter Integer,'
      '  @IDNum smallint,'
      '  @WhereFound VARCHAR(850),'
      '  @MatchedFootersCount smallint,'
      '  @MatchedFooterName VARCHAR(40)'
      '  '
      'SET @CheckBarcode = :CheckBarcode'
      'SET @SelectedFooter = :FooterID'
      ''
      
        'IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39 +
        'tempdb..#FooterWithBarcode'#39'))'
      '  DROP TABLE #FooterWithBarcode'
      ''
      'CREATE TABLE #FooterWithBarcode'
      '('
      '  IDNum smallint IDENTITY(1,1) NOT NULL,'
      '  FooterName varchar(40) NULL'
      ')'
      ''
      'INSERT #FooterWithBarcode(FooterName)'
      'SELECT pf.Name'
      'FROM PromotionalFooter pf'
      'left outer join ProductBarcode pb on pb.Barcode = pf.Barcode'
      
        'left outer join (SELECT Barcode FROM ThemeDiscountBarcode WHERE ' +
        'DiscountID <> 2) tdb on tdb.Barcode = pf.Barcode'
      
        'left outer join (SELECT PromotionalFooterID FROM #DiscountBarcod' +
        'es WHERE PromotionalFooterID IS NOT NULL) db1 on db1.Promotional' +
        'FooterID = pf.Id '
      
        'left outer join (SELECT Barcode FROM #DiscountBarcodes WHERE Pro' +
        'motionalFooterID IS NOT NULL) db2 on db2.Barcode = pf.Barcode'
      'WHERE pb.Barcode IS NULL'
      'AND pf.Id <> @SelectedFooter'
      'AND pf.Barcode = @CheckBarcode'
      ''
      'SET @WhereFound = '#39#39
      ''
      'IF (SELECT COUNT(*) FROM #FooterWithBarcode) = 0'
      '  SELECT CAST(0 AS bit) AS BarcodeUsed, '#39#39' AS WhereFound'
      'ELSE'
      'BEGIN'
      '  SELECT @MatchedFootersCount = COUNT(*) FROM #FooterWithBarcode'
      '  IF (@MatchedFootersCount = 1)'
      
        '    SET @WhereFound = @WhereFound + '#39'Promotional Footer "'#39' + (SE' +
        'LECT FooterName FROM #FooterWithBarcode) +'
      
        '                      '#39'" also uses this barcode\nand will no lon' +
        'ger be selectable.'#39
      '  ELSE'
      '  BEGIN'
      '    SET @IDNum = (SELECT MIN(IDNum) FROM #FooterWithBarcode)'
      
        '    SET @WhereFound = @WhereFound + '#39'The following promotional f' +
        'ooters also use this barcode\nand will no longer be selectable:\' +
        'n'#39
      
        '    SET @MatchedFooterName = (SELECT FooterName FROM #FooterWith' +
        'Barcode WHERE IDNum = @IDNum)'
      ''
      '    WHILE @IDNum IS NOT NULL'
      '    BEGIN'
      
        '      SET @WhereFound = @WhereFound + '#39'\n     '#39' + @MatchedFooter' +
        'Name'
      
        '      SET @IDNum = (SELECT MIN(IDNum) FROM #FooterWithBarcode WH' +
        'ERE IDNum > @IDNum)'
      
        '      SET @MatchedFooterName = (SELECT FooterName FROM #FooterWi' +
        'thBarcode WHERE IDNum = @IDNum)'
      '   END'
      '  END'
      ''
      
        '  SELECT CAST(1 AS bit) AS BarcodeUsed, @WhereFound AS WhereFoun' +
        'd'
      'END '
      '')
    Left = 240
    Top = 75
  end
end
