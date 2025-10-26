inherited EditDiscount: TEditDiscount
  Left = 595
  Top = 134
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = 'Add/Edit Discount'
  ClientHeight = 656
  ClientWidth = 660
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited AppFeatureBox: TGroupBox
    Top = -3
    Height = 657
    DesignSize = (
      276
      657)
    inherited SearchGroupBox: TGroupBox
      Top = 531
    end
    inherited tvAllProducts: TTreeView
      Height = 516
    end
  end
  inherited btOk: TButton
    Left = 503
    Top = 625
    TabOrder = 2
    OnClick = btOkClick
  end
  inherited btCancel: TButton
    Left = 583
    Top = 625
    TabOrder = 3
    OnClick = btCancelClick
  end
  object pnlDiscountDetails: TPanel [3]
    Left = 279
    Top = 2
    Width = 377
    Height = 616
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object lbName: TLabel
      Left = 8
      Top = 7
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 68
      Height = 13
      Caption = 'Discount type:'
    end
    object lblDiscountAmount: TLabel
      Left = 8
      Top = 56
      Width = 83
      Height = 13
      Caption = 'Discount amount:'
    end
    object lblMaxDiscount: TLabel
      Left = 200
      Top = 32
      Width = 90
      Height = 13
      Caption = 'Maximum discount:'
    end
    object lbPercentage: TLabel
      Left = 183
      Top = 56
      Width = 8
      Height = 13
      Caption = '%'
      Visible = False
    end
    object lblClmDiscount: TLabel
      Left = 8
      Top = 74
      Width = 186
      Height = 13
      Caption = 'Used as CLM External amount discount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMaxRate: TLabel
      Left = 200
      Top = 56
      Width = 79
      Height = 13
      Caption = 'Maximum % rate:'
    end
    object edName: TEdit
      Left = 48
      Top = 4
      Width = 321
      Height = 21
      MaxLength = 20
      TabOrder = 0
    end
    object cbDiscountType: TComboBox
      Left = 95
      Top = 28
      Width = 98
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Fixed rate'
      OnChange = cbDiscountTypeChange
      Items.Strings = (
        'Fixed rate'
        'Fixed amount'
        'Open rate'
        'Open amount')
    end
    object DBEditMaxDiscount: TDBEdit
      Left = 295
      Top = 28
      Width = 74
      Height = 21
      DataField = 'MaximumDiscount'
      DataSource = dsTmp
      MaxLength = 8
      TabOrder = 2
      OnContextPopup = DiscardContextPopup
      OnKeyPress = NumericFieldKeyPress
    end
    object gbxMinimumSpend: TGroupBox
      Left = 8
      Top = 120
      Width = 361
      Height = 75
      Caption = 'Minimum Spend'
      TabOrder = 6
      object Label4: TLabel
        Left = 8
        Top = 23
        Width = 39
        Height = 13
        Caption = 'Amount:'
      end
      object Label5: TLabel
        Left = 8
        Top = 47
        Width = 49
        Height = 13
        Caption = 'Applies to:'
      end
      object dbeMinSpend: TDBEdit
        Left = 64
        Top = 19
        Width = 89
        Height = 21
        DataField = 'MinimumSpend'
        DataSource = dsTmp
        MaxLength = 8
        TabOrder = 0
        OnContextPopup = DiscardContextPopup
        OnKeyPress = NumericFieldKeyPress
      end
      object cbMinSpend: TComboBox
        Left = 64
        Top = 43
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'Discount Items'
        OnChange = cbMinSpendChange
        Items.Strings = (
          'Discount Items'
          'Whole Account'
          'Min. Spend Group')
      end
      object btnDefineMinSpendGroup: TButton
        Left = 261
        Top = 41
        Width = 87
        Height = 25
        Hint = 'Define minimum spend group'
        Caption = 'Define Group'
        Enabled = False
        TabOrder = 2
        OnClick = btnDefineMinSpendGroupClick
      end
    end
    object btnAssignBarcodes: TButton
      Left = 8
      Top = 90
      Width = 145
      Height = 25
      Caption = 'Assign Barcodes'
      TabOrder = 5
      OnClick = btnAssignBarcodesClick
    end
    object gbxEpos: TGroupBox
      Left = 8
      Top = 285
      Width = 361
      Height = 157
      Caption = 'EPoS'
      TabOrder = 8
      object lblAppliesToOrderLineFamilyHint: TLabel
        Left = 9
        Top = 108
        Width = 147
        Height = 14
        Hint = 'fyulkryluryliu'
        AutoSize = False
        ParentShowHint = False
        ShowHint = True
        Transparent = True
      end
      object lblAppliesToOrderLineFamilyInfo: TLabel
        Left = 158
        Top = 108
        Width = 10
        Height = 19
        Hint = 
          'A single item discount allows individual orders within an accoun' +
          't to be discounted.'#13#10'This discount type can only be added to the' +
          ' '#39'Correct Account'#39' panel and once saved'#13#10'this property cannot be' +
          ' changed.'#13#10#13#10'Only available on sites at Aztec 3.8.3 and above.  ' +
          'Single item discounts will be removed'#13#10'from themes at lower vers' +
          'ion sites.'
        Caption = '*'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object lblIgnoreExclusiveTaxInfo: TLabel
        Left = 158
        Top = 128
        Width = 10
        Height = 19
        Hint = 
          'When checked the discount will not reduce exclusive taxes that a' +
          're being charged.'#13#10#13#10'Only available on sites at Aztec 3.11.1 and' +
          ' above.  All exclusive taxes will continue'#13#10'to be discounted on ' +
          'lower version sites.'#13#10#13#10'Service Charge will not be affected.'
        Caption = '*'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object gpbxEPoSText: TGroupBox
        Left = 235
        Top = 9
        Width = 118
        Height = 76
        Caption = 'Text'
        TabOrder = 6
        object mmEposName: TMemo
          Left = 14
          Top = 17
          Width = 89
          Height = 50
          Alignment = taCenter
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            '')
          ParentFont = False
          TabOrder = 0
          WordWrap = False
        end
      end
      object cbOpensCashDrawer: TCheckBox
        Left = 9
        Top = 18
        Width = 125
        Height = 17
        Caption = 'Opens cash drawer.'
        TabOrder = 0
      end
      object cbPrintReceipt: TCheckBox
        Left = 9
        Top = 40
        Width = 117
        Height = 17
        Caption = 'Auto print receipt.'
        TabOrder = 1
      end
      object cbDisablesPromotions: TCheckBox
        Left = 9
        Top = 63
        Width = 125
        Height = 17
        Caption = 'Disables promotions.'
        TabOrder = 2
      end
      object cbPreventFurtherSales: TCheckBox
        Left = 9
        Top = 85
        Width = 125
        Height = 17
        Caption = 'Prevent further sales.'
        TabOrder = 3
      end
      object pnlReasons: TPanel
        Left = 235
        Top = 100
        Width = 119
        Height = 49
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 8
        object btnSelectReasons: TButton
          Left = 16
          Top = 12
          Width = 87
          Height = 25
          Caption = 'Select Reasons'
          Enabled = False
          TabOrder = 0
          OnClick = btnSelectReasonsClick
        end
      end
      object cbReasonRequired: TCheckBox
        Left = 244
        Top = 92
        Width = 97
        Height = 17
        Caption = 'Reason required'
        TabOrder = 7
        OnClick = cbReasonRequiredClick
      end
      object cbAppliesToOrderLineFamily: TCheckBox
        Left = 9
        Top = 108
        Width = 148
        Height = 17
        Caption = 'Only applies to single items.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = cbAppliesToOrderLineFamilyClick
      end
      object cbIgnoreExclusiveTax: TCheckBox
        Left = 9
        Top = 130
        Width = 148
        Height = 17
        Caption = 'Don'#39't reduce exclusive tax.'
        TabOrder = 5
        OnClick = cbIgnoreExclusiveTaxClick
      end
    end
    object gpbxAdditionalActivationRequirements: TGroupBox
      Left = 8
      Top = 450
      Width = 361
      Height = 159
      Caption = 'Additional activation criteria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnShadow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      DesignSize = (
        361
        159)
      object lblSwipeCardRangesRequired: TLabel
        Left = 8
        Top = 44
        Width = 190
        Height = 13
        Caption = 'Swipe card ranges required for discount:'
      end
      object bvlSplitter: TBevel
        Left = 20
        Top = 39
        Width = 321
        Height = 2
      end
      object cbReferenceRequired: TCheckBox
        Left = 8
        Top = 18
        Width = 281
        Height = 17
        Caption = 'Require reference (text entry or QR/barcode scan only).'
        TabOrder = 0
        OnClick = cbReferenceRequiredClick
      end
      object clbGrantedCardRanges: TCheckListBox
        Left = 8
        Top = 60
        Width = 344
        Height = 92
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        Items.Strings = (
          'Range 1'
          'Range 2')
        TabOrder = 1
      end
    end
    object DBEditMaxRate: TDBEdit
      Left = 295
      Top = 52
      Width = 74
      Height = 21
      DataField = 'MaximumRate'
      DataSource = dsTmp
      MaxLength = 3
      TabOrder = 4
      OnContextPopup = DiscardContextPopup
      OnKeyPress = NumericFieldKeyPress
    end
    object gbxForfeitSetup: TGroupBox
      Left = 8
      Top = 201
      Width = 361
      Height = 77
      Caption = 'Fixed Amount Discount Warning'
      TabOrder = 7
      object lblForfeitThreshold: TLabel
        Left = 8
        Top = 48
        Width = 89
        Height = 13
        Caption = 'Warning threshold:'
        Enabled = False
      end
      object cbConfirmForfeit: TDBCheckBox
        Left = 8
        Top = 24
        Width = 201
        Height = 17
        Caption = 'Warn if full discount value not applied'
        DataField = 'ConfirmForfeit'
        DataSource = dsTmp
        TabOrder = 0
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = cbConfirmForfeitClick
      end
      object dbeForfeitThreshold: TDBEdit
        Left = 108
        Top = 44
        Width = 97
        Height = 21
        DataField = 'ConfirmForfeitThresholdAmount'
        DataSource = dsTmp
        Enabled = False
        MaxLength = 8
        TabOrder = 1
        OnContextPopup = DiscardContextPopup
        OnKeyPress = NumericFieldKeyPress
      end
    end
    object dbeAmount: TDBEdit
      Left = 95
      Top = 52
      Width = 87
      Height = 21
      DataField = 'DiscountAmount'
      DataSource = dsTmp
      MaxLength = 8
      TabOrder = 3
      OnContextPopup = DiscardContextPopup
      OnKeyPress = NumericFieldKeyPress
    end
  end
  object qTmp: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    BeforeOpen = qTmpBeforeOpen
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'create table #edtmp (DiscountAmount money, MinimumSpend money, M' +
        'aximumDiscount money, DiscountPercentage decimal(5,2), MaximumRa' +
        'te integer, ConfirmForfeit bit,  ConfirmForfeitThresholdAmount m' +
        'oney)'
      'insert #edtmp select 0,0,0,0,0,0,0'
      'select * from #edtmp')
    Left = 554
    Top = 114
    object qTmpDiscountAmount: TBCDField
      FieldName = 'DiscountAmount'
      DisplayFormat = '###0.00'
      EditFormat = '###0.00'
      Precision = 2
      Size = 2
    end
    object qTmpMinimumSpend: TBCDField
      FieldName = 'MinimumSpend'
      DisplayFormat = '###0.00'
      EditFormat = '###0.00'
      Precision = 2
    end
    object qTmpMaximumDiscount: TBCDField
      FieldName = 'MaximumDiscount'
      DisplayFormat = '###0.00'
      EditFormat = '###0.00'
      Precision = 2
    end
    object qTmpMaximumRate: TIntegerField
      FieldName = 'MaximumRate'
    end
    object qTmpConfirmForfeit: TBooleanField
      FieldName = 'ConfirmForfeit'
    end
    object qTmpConfirmForfeitThresholdAmount: TBCDField
      FieldName = 'ConfirmForfeitThresholdAmount'
      DisplayFormat = '###0.00'
      EditFormat = '###0.00'
      Precision = 2
    end
    object qTmpDiscountPercentage: TBCDField
      FieldName = 'DiscountPercentage'
      Size = 2
    end
  end
  object dsTmp: TDataSource
    DataSet = qTmp
    Left = 618
    Top = 82
  end
  object qDelTmp: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'if object_id('#39'tempdb..#edtmp'#39') is not null drop table #edtmp')
    Left = 586
    Top = 82
  end
  object qrySaveDiscountBarcodes: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'DiscountID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET NOCOUNT ON'
      ''
      'DECLARE @DiscountID bigint'
      ''
      'SET @DiscountID = :DiscountID'
      ''
      'BEGIN TRY'
      '  DELETE ThemeDiscountEnteredBarcode_repl'
      '  WHERE DiscountID = @DiscountID'
      ''
      '  DELETE ThemeDiscountFooterBarcode_repl'
      '  WHERE DiscountID = @DiscountID'
      ''
      '  INSERT ThemeDiscountEnteredBarcode_repl(DiscountID, Barcode)'
      '  SELECT @DiscountID, Barcode'
      '  FROM #DiscountBarcodes'
      '  WHERE FromPromotionalFooter = 0'
      ''
      ''
      
        '  INSERT ThemeDiscountFooterBarcode_repl(DiscountID, Promotional' +
        'FooterID)'
      '  SELECT @DiscountID, PromotionalFooterID'
      '  FROM #DiscountBarcodes'
      '  WHERE FromPromotionalFooter = 1'
      ''
      'END TRY'
      'BEGIN CATCH'
      '  EXEC ac_spRethrowError'
      'END CATCH')
    Left = 587
    Top = 114
  end
  object cmdLoadDiscountBarcodes: TADOCommand
    CommandText = 
      'DECLARE @DiscountID bigint'#13#10'SET @DiscountID = :DiscountID'#13#10#13#10'IF ' +
      'EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('#39'tem' +
      'pdb..#DiscountBarcodes'#39'))'#13#10'  DROP TABLE #DiscountBarcodes'#13#10#13#10'CRE' +
      'ATE TABLE #DiscountBarcodes '#13#10'('#13#10'  Barcode Varchar(25) COLLATE D' +
      'ATABASE_DEFAULT,'#13#10'  FromPromotionalFooter bit,'#13#10'  PromotionalFoo' +
      'terID int,'#13#10'  PromotionalFooterName varchar(40) COLLATE DATABASE' +
      '_DEFAULT,'#13#10'  PRIMARY KEY (Barcode)'#13#10')'#13#10#13#10'INSERT #DiscountBarcode' +
      's'#13#10'SELECT Barcode, CAST(0 AS BIT) AS FromPromotionalFooter, NULL' +
      ' AS PromotionalFooterID, NULL AS PromotionalFooterName'#13#10'FROM The' +
      'meDiscountEnteredBarcode_repl'#13#10'WHERE Deleted = 0 AND DiscountID ' +
      '= @DiscountID'#13#10'UNION'#13#10'SELECT p.Barcode, CAST(1 AS BIT) AS FromPr' +
      'omotionalFooter, t.PromotionalFooterID, p.Name'#13#10'FROM ThemeDiscou' +
      'ntFooterBarcode_repl t '#13#10'LEFT OUTER JOIN'#13#10'  PromotionalFooter AS' +
      ' p ON t.PromotionalFooterID = p.Id'#13#10'WHERE t.Deleted = 0 AND t.Di' +
      'scountID = @DiscountID AND p.Barcode IS NOT NULL'#13#10'  AND p.Barcod' +
      'e NOT IN (SELECT DISTINCT Barcode FROM ProductBarcode)'#13#10
    CommandTimeout = 0
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'DiscountID'
        Size = -1
        Value = Null
      end>
    Left = 552
    Top = 80
  end
  object adoqLoadDiscountReasons: TADOQuery
    Connection = dmADO.AztecConn
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'DECLARE @DiscountID bigint'
      'SET @DiscountID = ~~DiscountID~~'
      ''
      'IF OBJECT_ID('#39'tempdb..#ThemeDiscountReasonMap'#39') IS NOT NULL'
      '  DROP TABLE #ThemeDiscountReasonMap'
      ''
      'CREATE TABLE #ThemeDiscountReasonMap'
      '('
      '  DiscountID bigint,'
      '  ReasonID int,'
      '  PRIMARY KEY(DiscountID, ReasonID)'
      ')'
      ''
      'INSERT #ThemeDiscountReasonMap'
      'SELECT DiscountID, ReasonID'
      'FROM ThemeDiscountReasonMap'
      'WHERE DiscountID = @DiscountID'
      '')
    Left = 428
    Top = 336
  end
  object adoqSaveDiscountReasons: TADOQuery
    Connection = dmADO.AztecConn
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SET NOCOUNT ON'
      ''
      'DECLARE @DiscountID bigint'
      ''
      'SET @DiscountID = ~~DiscountID~~'
      ''
      
        '--A new disocunt has a temporary discount ID of 0.  Set it to th' +
        'e proper value.'
      
        'UPDATE #ThemeDiscountReasonMap SET DiscountID = @DiscountID WHER' +
        'E DiscountID = 0'
      ''
      'BEGIN TRY'
      '  MERGE ThemeDiscountReasonMap AS Target'
      '  USING #ThemeDiscountReasonMap AS Source'
      
        '  ON Target.DiscountID = Source.DiscountID AND Target.ReasonID =' +
        ' Source.ReasonID AND Target.DiscountID = @DiscountID'
      '  WHEN NOT MATCHED BY Target'
      
        '    THEN INSERT (ReasonID, DiscountID) VALUES(Source.ReasonID, S' +
        'ource.DiscountID)'
      '  --WHEN MATCHED'
      
        '    --Do Nothing: THEN UPDATE SET T.ReasonID = S.ReasonID AND T.' +
        'DiscountID = S.DiscountID'
      '  WHEN NOT MATCHED BY Source AND Target.DiscountID = @DiscountID'
      '    THEN DELETE;'
      'END TRY'
      'BEGIN CATCH'
      '  EXEC ac_spRethrowError'
      'END CATCH'
      '')
    Left = 428
    Top = 304
  end
end
