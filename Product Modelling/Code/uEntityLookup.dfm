object EntityLookupFrame: TEntityLookupFrame
  Left = 0
  Top = 0
  Width = 287
  Height = 529
  TabOrder = 0
  OnResize = FrameResize
  DesignSize = (
    287
    529)
  object EntityGrid: TFlexiDBGrid
    Left = 0
    Top = 0
    Width = 287
    Height = 441
    Anchors = [akLeft, akTop, akRight, akBottom]
    Options = [dgTitles, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = EntityGridDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Retail Name'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Entity Type'
        Title.Caption = 'Type'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Retail Description'
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EntityCode'
        Title.Caption = 'Entity Code'
        Visible = False
      end>
  end
  object FindLineItemBox: TGroupBox
    Left = 75
    Top = 443
    Width = 131
    Height = 85
    Anchors = [akRight, akBottom]
    Caption = 'Find Item'
    TabOrder = 1
    DesignSize = (
      131
      85)
    object SearchTextEdit: TEdit
      Left = 5
      Top = 15
      Width = 116
      Height = 21
      Anchors = [akLeft, akTop, akBottom]
      TabOrder = 0
    end
    object MidWordSearchCheckBox: TCheckBox
      Left = 5
      Top = 36
      Width = 107
      Height = 17
      TabStop = False
      Caption = 'Mid-word search'
      TabOrder = 1
    end
    object FindPrevButton: TButton
      Left = 68
      Top = 55
      Width = 57
      Height = 25
      Caption = 'Find Prev'
      TabOrder = 2
      TabStop = False
    end
    object FindNextButton: TButton
      Left = 6
      Top = 55
      Width = 57
      Height = 25
      Caption = 'Find Next'
      TabOrder = 3
      TabStop = False
    end
  end
  object GroupBox1: TGroupBox
    Left = 215
    Top = 443
    Width = 71
    Height = 85
    Anchors = [akRight, akBottom]
    Caption = 'Filter'
    TabOrder = 2
    object cbFiltered: TCheckBox
      Left = 6
      Top = 36
      Width = 61
      Height = 17
      TabStop = False
      Caption = 'Filtered'
      TabOrder = 0
      OnClick = cbFilteredClick
    end
    object SetFilterButton: TButton
      Left = 5
      Top = 55
      Width = 60
      Height = 25
      Caption = 'Set Filter...'
      TabOrder = 1
      OnClick = SetFilterButtonClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 56
    object ShowRetailDescriptionMenuItem: TMenuItem
      Caption = 'Show Retail Description'
      Checked = True
      OnClick = ShowRetailDescriptionMenuItemClick
    end
    object ShowEntityCodeMenuItem: TMenuItem
      Caption = 'Show Entity Code'
      OnClick = ShowEntityCodeMenuItemClick
    end
  end
  object additionalFiltersDataset: TADODataSet
    Connection = dmADO.AztecConn
    CommandText = 
      'DECLARE @supplierRefFilter AS VARCHAR(100)'#13#10'DECLARE @supplierNam' +
      'eFilter AS VARCHAR(MAX)'#13#10'DECLARE @usesPortionFilter AS VARCHAR(1' +
      '00)'#13#10'DECLARE @usesTaxRuleFilter AS VARCHAR(100)'#13#10'DECLARE @barcod' +
      'eFilter AS VARCHAR(100)'#13#10'DECLARE @tagsFilter AS VARCHAR(MAX)'#13#10'DE' +
      'CLARE @searchForBlanksBarcode AS INTEGER'#13#10'DECLARE @searchForBlan' +
      'ksSupplierRef AS INTEGER'#13#10'DECLARE @query AS VARCHAR(MAX)'#13#10#13#10'SET ' +
      '@supplierRefFilter = :supplierRefFilter'#13#10'SET @usesPortionFilter ' +
      '= :usesPortionFilter'#13#10'SET @usesTaxRuleFilter = :usesTaxRuleFilte' +
      'r'#13#10'SET @supplierNameFilter = :supplierNameFilter'#13#10'SET @barcodeFi' +
      'lter = :barcodeFilter'#13#10'SET @tagsFilter = :tagsFilter'#13#10'SET @searc' +
      'hForBlanksBarcode = :searchForBlanksBarcode'#13#10'SET @searchForBlank' +
      'sSupplierRef = :searchForBlanksSupplierRef'#13#10'SET @query = '#39#39#13#10#13#10'I' +
      'F @supplierRefFilter <> '#39#39' OR @supplierNameFilter <> '#39#39' OR @sear' +
      'chForBlanksSupplierRef = 1'#13#10'BEGIN'#13#10#9' SET @query = @query + '#13#10#9' '#39 +
      'SELECT p.[EntityCode]'#13#10#9'   FROM Products p INNER JOIN PurchaseUn' +
      'its pu ON p.[EntityCode] = pu.[Entity Code]'#13#10#9'   WHERE '#39#13#10#9'IF @s' +
      'earchForBlanksSupplierRef = 1'#13#10#9'   BEGIN'#13#10#9'     SET @query = @qu' +
      'ery + '#39'pu.[Import/Export Reference] IS NULL'#39#13#10#9'   END '#13#10#9'ELSE IF' +
      ' @supplierRefFilter <> '#39#39#13#10#9#9'BEGIN'#13#10#9#9' SET @query = @query + '#39'pu' +
      '.[Import/Export Reference] like '#39#39'%'#39' + @supplierRefFilter + '#39'%'#39#39 +
      ' '#39#13#10#9#9'END'#13#10#9'IF (@supplierRefFilter <> '#39#39' OR @searchForBlanksSupp' +
      'lierRef = 1) AND @supplierNameFilter <> '#39#39#13#10#9#9'BEGIN'#13#10#9#9' SET @que' +
      'ry = @query + '#39' AND '#39#13#10#9#9'END'#13#10#9'IF @supplierNameFilter <> '#39#39#13#10#9#9'S' +
      'ET @query = @query + '#39'pu.[Supplier Name] IN '#39' + @supplierNameFil' +
      'ter'#13#10'END'#13#10#13#10'IF @query <> '#39#39' AND @usesPortionFilter <> '#39#39#13#10'BEGIN'#13 +
      #10'    SET @query = @query + '#39' INTERSECT '#39#13#10'END'#13#10#13#10'IF @usesPortion' +
      'Filter <> '#39#39#13#10'BEGIN'#13#10#9'SET @query = @query + '#39#13#10#9'SELECT p.[Entity' +
      'Code]'#13#10#9#9'FROM products p'#13#10#9#9'INNER JOIN portions por ON por.[Enti' +
      'tyCode] = p.[EntityCode]'#13#10#9#9'INNER JOIN ac_PortionType porTyp ON ' +
      'porTyp.[Id] = por.[PortionTypeID] '#13#10#9#9'WHERE porTyp.[Id] IN '#39' + @' +
      'usesPortionFilter'#13#10'END'#13#10#13#10'IF @query <> '#39#39' AND @usesTaxRuleFilter' +
      ' <> '#39#39#13#10'BEGIN'#13#10#9'SET @query = @query + '#39' INTERSECT '#39#13#10'END'#13#10#13#10'IF @' +
      'usesTaxRuleFilter <> '#39#39#13#10'BEGIN'#13#10#9'SET @query = @query + '#39#13#10#9'SELEC' +
      'T [EntityCode]'#13#10#9'FROM ProductTaxRules ptr'#13#10#9'WHERE ptr.TaxRule1 I' +
      'N '#39' + @usesTaxRuleFilter + '#39#13#10#9'   OR ptr.TaxRule2 IN '#39' + @usesTa' +
      'xRuleFilter + '#39#13#10#9'   OR ptr.TaxRule3 IN '#39' + @usesTaxRuleFilter +' +
      ' '#39#13#10#9'   OR ptr.TaxRule4 IN '#39' + @usesTaxRuleFilter'#13#10'END'#13#10#13#10'IF @qu' +
      'ery <> '#39#39' AND (@barcodeFilter <> '#39#39' OR @searchForBlanksBarcode =' +
      ' 1)'#13#10'BEGIN'#13#10#9'SET @query = @query + '#39' INTERSECT '#39#13#10'END'#13#10#13#10'IF @sea' +
      'rchForBlanksBarcode = 1'#13#10'BEGIN'#13#10#9'SET @query = @query + '#39#13#10#9'(SELE' +
      'CT EntityCode'#13#10#9'FROM Products p'#13#10#9'WHERE EntityCode NOT IN '#13#10#9#9'(S' +
      'ELECT EntityCode FROM ProductBarcodeRange'#13#10#9#9' UNION SELECT Entit' +
      'yCode FROM ProductBarcode))'#39#13#10'END'#13#10'ELSE IF @barcodeFilter <> '#39#39#13 +
      #10'BEGIN'#13#10#9'SET @query = @query + '#39#13#10#9'(SELECT p.[EntityCode]'#13#10#9'FROM' +
      ' Products p'#13#10#9'INNER JOIN ProductBarcode pbc'#13#10#9'  ON p.[EntityCode' +
      '] = pbc.[EntityCode]'#13#10#9'WHERE pbc.[Barcode] = CAST('#39' + @barcodeFi' +
      'lter + '#39' AS BIGINT)'#13#10#9'UNION'#13#10#9'SELECT p.[EntityCode]'#13#10#9'FROM Produ' +
      'cts p'#13#10#9'INNER JOIN ProductBarcodeRange pbcr'#13#10#9'  ON p.[EntityCode' +
      '] = pbcr.[EntityCode]'#13#10#9'INNER JOIN ThemeBarcodeExceptionRange bc' +
      'r'#13#10#9'  ON pbcr.[BarcodeRangeID] = bcr.[BarcodeRangeID]'#13#10#9'WHERE db' +
      'o.fnBarcodeInRange(StartValue, EndValue, CAST( '#39' + @barcodeFilte' +
      'r + '#39' AS BIGINT), null) = 1)'#39#13#10'END'#13#10#13#10'IF @query <> '#39#39' AND @tagsF' +
      'ilter <> '#39#39#13#10'BEGIN'#13#10#9'SET @query = @query + '#39' INTERSECT '#39#13#10'END'#13#10#13 +
      #10'IF @tagsFilter <> '#39#39#13#10'BEGIN'#13#10#9'SET @query = @query + '#39#13#10#9'SELECT ' +
      'p.[EntityCode]'#13#10#9'FROM Products p INNER JOIN ProductTag pt ON p.[' +
      'EntityCode] = pt.[EntityCode]'#13#10#9'WHERE pt.TagId IN '#39' + @tagsFilte' +
      'r'#13#10'END'#13#10#13#10'EXEC(@query)'
    Parameters = <
      item
        Name = 'supplierRefFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'usesPortionFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'usesTaxRuleFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'supplierNameFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'barcodeFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'tagsFilter'
        Size = -1
        Value = Null
      end
      item
        Name = 'searchForBlanksBarcode'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = 'searchForBlanksSupplierRef'
        DataType = ftInteger
        Value = Null
      end>
    Left = 80
    Top = 56
  end
end
