object PromotionSummary: TPromotionSummary
  Left = 483
  Top = 283
  Width = 705
  Height = 673
  VertScrollBar.Tracking = True
  Caption = 'Promotion Summary'
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  DesignSize = (
    689
    634)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 286
    Width = 93
    Height = 13
    Caption = 'Product/Price detail'
  end
  object btnClose: TButton
    Left = 616
    Top = 618
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    DesignSize = (
      689
      60)
    object Label18: TLabel
      Left = 21
      Top = 6
      Width = 173
      Height = 13
      Caption = 'Summary of Promotion Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = -1
      Top = 58
      Width = 699
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
    end
    object imLogo: TImage
      Tag = 102
      Left = 643
      Top = 5
      Width = 49
      Height = 49
      Anchors = [akTop, akRight]
    end
    object Label19: TLabel
      Left = 40
      Top = 24
      Width = 597
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'This is a summary of the selected Promotion. Selecting a Site or' +
        ' Sales Area will show data defined at that level e.g. Per Site R' +
        'eward Price/Exceptions.'
      WordWrap = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 61
    Width = 697
    Height = 220
    Anchors = [akLeft, akTop, akRight]
    Color = clInfoBk
    TabOrder = 2
    DesignSize = (
      697
      220)
    object Label2: TLabel
      Left = 8
      Top = 4
      Width = 82
      Height = 13
      Caption = 'Promotion Name:'
    end
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 57
      Height = 13
      Caption = 'Description:'
    end
    object Label4: TLabel
      Left = 8
      Top = 76
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object DBText1: TDBText
      Left = 112
      Top = 4
      Width = 576
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Name'
      DataSource = dsPromotionDetails
    end
    object DBText2: TDBText
      Left = 112
      Top = 20
      Width = 576
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Description'
      DataSource = dsPromotionDetails
      WordWrap = True
    end
    object DBText3: TDBText
      Left = 112
      Top = 76
      Width = 89
      Height = 17
      DataField = 'PromoTypeName'
      DataSource = dsPromotionDetails
    end
    object Label5: TLabel
      Left = 8
      Top = 92
      Width = 38
      Height = 13
      Caption = 'Favour:'
    end
    object DBText4: TDBText
      Left = 112
      Top = 92
      Width = 89
      Height = 17
      DataField = 'FavourCustomerOrCompany'
      DataSource = dsPromotionDetails
    end
    object Label6: TLabel
      Left = 8
      Top = 108
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
    object DBText5: TDBText
      Left = 112
      Top = 108
      Width = 89
      Height = 17
      DataField = 'Status'
      DataSource = dsPromotionDetails
    end
    object lbRewardPrice: TLabel
      Left = 8
      Top = 148
      Width = 67
      Height = 13
      Caption = 'Reward price:'
    end
    object dbtRewardPrice: TDBText
      Left = 112
      Top = 148
      Width = 77
      Height = 17
      DataField = 'GlobalRewardPrice'
      DataSource = dsPromotionDetails
    end
    object lbSiteRewardPrice: TLabel
      Left = 8
      Top = 164
      Width = 85
      Height = 13
      Caption = 'Site reward price:'
    end
    object dbtSiteRewardPrice: TDBText
      Left = 112
      Top = 164
      Width = 77
      Height = 17
      DataField = 'RewardPrice'
      DataSource = dsSiteRewardPrice
    end
    object lblSumCardActivated: TLabel
      Left = 8
      Top = 184
      Width = 123
      Height = 13
      Caption = 'Card Activated Promotion'
    end
    object lblValidation: TLabel
      Left = 8
      Top = 199
      Width = 76
      Height = 13
      Caption = 'Card validation:'
    end
    object lblValidType: TLabel
      Left = 112
      Top = 199
      Width = 56
      Height = 13
      Caption = 'lblValidType'
    end
    object lblPromoDeal: TLabel
      Left = 8
      Top = 124
      Width = 121
      Height = 13
      Caption = 'This is a Promotional Deal'
      Visible = False
    end
    object GroupBox1: TGroupBox
      Left = 192
      Top = 60
      Width = 278
      Height = 152
      Caption = ' Activation settings '
      TabOrder = 0
      object Label8: TLabel
        Left = 7
        Top = 16
        Width = 54
        Height = 13
        Caption = 'Start Date:'
      end
      object Label9: TLabel
        Left = 7
        Top = 32
        Width = 48
        Height = 13
        Caption = 'End Date:'
      end
      object Label12: TLabel
        Left = 7
        Top = 50
        Width = 56
        Height = 13
        Caption = 'Valid Times:'
      end
      object DBText7: TDBText
        Left = 73
        Top = 32
        Width = 81
        Height = 17
        DataField = 'EndDate'
        DataSource = dsPromotionDetails
      end
      object DBText6: TDBText
        Left = 73
        Top = 16
        Width = 81
        Height = 17
        DataField = 'StartDate'
        DataSource = dsPromotionDetails
      end
      object DBGridValidTimes: TDBGrid
        Left = 70
        Top = 48
        Width = 206
        Height = 81
        BorderStyle = bsNone
        Color = clInfoBk
        Ctl3D = False
        DataSource = dsValidTimes
        Options = [dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
      end
    end
    object GroupBox2: TGroupBox
      Left = 474
      Top = 60
      Width = 218
      Height = 151
      Caption = ' Exception overrides '
      TabOrder = 1
      object DBText17: TDBText
        Left = 11
        Top = 16
        Width = 81
        Height = 17
        DataField = 'StartDate'
        DataSource = dsExceptions
      end
      object DBText16: TDBText
        Left = 11
        Top = 32
        Width = 81
        Height = 17
        DataField = 'EndDate'
        DataSource = dsExceptions
      end
      object DBGridExceptionTimes: TDBGrid
        Left = 10
        Top = 48
        Width = 206
        Height = 48
        BorderStyle = bsNone
        Color = clInfoBk
        Ctl3D = False
        DataSource = dsExceptionValidTimes
        Options = [dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
      end
    end
  end
  object tvPromotionSummary: TTreeView
    Left = 8
    Top = 304
    Width = 681
    Height = 307
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    ReadOnly = True
    TabOrder = 3
    OnExpanding = tvPromotionSummaryExpanding
    OnGetSelectedIndex = tvPromotionSummaryGetSelectedIndex
  end
  object btnPrint: TButton
    Left = 528
    Top = 618
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Print...'
    TabOrder = 4
    OnClick = btnPrintClick
  end
  object dsSalesAreas: TDataSource
    DataSet = qSalesAreas
    Left = 64
    Top = 366
  end
  object qSalesAreas: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'PromotionID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select a.promotionid, a.salesareaid, sub.siteid,'
      
        '  isnull(sub.sitename + '#39' / '#39'+sub.salesareaname, '#39'Sales Area '#39'+c' +
        'ast(a.salesareaid as varchar(50))) as SalesAreaName'
      'from promotionsalesarea a'
      'left outer join ('
      '  select distinct [site code] as siteid,'
      
        '    [sales area code] as salesareaid, [site name] as sitename, [' +
        'sales area name] as salesareaname'
      '  from config'
      '  where deleted is null or deleted = '#39'N'#39
      ') sub on a.salesareaid = sub.salesareaid'
      'where promotionid = :PromotionID'
      'order by 4')
    Left = 32
    Top = 366
    object qSalesAreasExpandSA: TBooleanField
      DisplayLabel = ' '
      DisplayWidth = 2
      FieldKind = fkCalculated
      FieldName = 'ExpandSA'
      Calculated = True
    end
    object qSalesAreasSalesAreaName: TStringField
      DisplayLabel = 'Sales Area'
      DisplayWidth = 30
      FieldName = 'SalesAreaName'
      Size = 50
    end
    object qSalesAreassiteid: TSmallintField
      FieldName = 'siteid'
      Visible = False
    end
    object qSalesAreasSalesAreaID: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalesAreaID'
      Visible = False
    end
    object qSalesAreasPromotionID: TLargeintField
      FieldName = 'PromotionID'
    end
  end
  object qExceptions: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    DataSource = dsSalesAreas
    Parameters = <
      item
        Name = 'SalesAreaID'
        DataType = ftSmallint
        Value = 2
      end>
    SQL.Strings = (
      'select StartDate,'
      
        '  case ChangeEndDate when 1 then EndDate else null end as EndDat' +
        'e'
      'from #PromotionException a'
      
        '  inner join #PromotionExceptionSalesArea b  on a.ExceptionId = ' +
        'b.ExceptionId'
      'where b.SalesareaId = :SalesAreaID and a.status = 0'
      '')
    Left = 32
    Top = 398
    object qExceptionsStartDate: TDateTimeField
      FieldName = 'StartDate'
      OnGetText = GetText_BlankToNA
    end
    object qExceptionsEndDate: TDateTimeField
      FieldName = 'EndDate'
      ReadOnly = True
      OnGetText = GetText_BlankToNA
    end
  end
  object dsExceptions: TDataSource
    DataSet = qExceptions
    Left = 64
    Top = 398
  end
  object qPromotionDetails: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select SiteCode, PromotionID, Name, (CASE WHEN (Description IS N' +
        'ULL) OR (Description = '#39#39') THEN '#39' '#39' ELSE Description END) AS Des' +
        'cription,'
      
        '  case when (ExtendedFlag = 1 and a.PromoTypeID = 3) THEN ('#39'Enh.' +
        ' '#39' + PromoTypeName) ELSE PromoTypeName end as PromoTypeName,'
      '  StartDate, EndDate, ExtendedFlag, UserSelectsProducts,'
      
        '  case FavourCustomer when 1 then '#39'Customer'#39' else '#39'Company'#39' end ' +
        'as FavourCustomerOrCompany,'
      
        '  case Status when 0 then '#39'Enabled'#39' when 2 then '#39'Unpriced'#39' else ' +
        #39'Disabled'#39' end as Status,'
      
        '  SingleRewardPrice as GlobalRewardPrice, a.PromoTypeID, CardAct' +
        'ivated, ISNULL(DisplayString, '#39'n/a'#39') AS DisplayString '
      'from #Promotion a'
      'join PromoType b on a.PromoTypeID = b.PromoTypeID'
      
        'left outer join CardRangeValidationRatings cr ON cr.Rating = a.C' +
        'ardRating')
    Left = 32
    Top = 302
    object qPromotionDetailsSiteCode: TIntegerField
      FieldName = 'SiteCode'
      Visible = False
    end
    object qPromotionDetailsPromotionID: TLargeintField
      FieldName = 'PromotionID'
    end
    object qPromotionDetailsName: TStringField
      FieldName = 'Name'
      Size = 25
    end
    object qPromotionDetailsDescription: TStringField
      FieldName = 'Description'
      Size = 256
    end
    object qPromotionDetailsPromoTypeName: TStringField
      FieldName = 'PromoTypeName'
      Size = 50
    end
    object qPromotionDetailsStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qPromotionDetailsEndDate: TDateTimeField
      FieldName = 'EndDate'
      OnGetText = GetText_BlankToNA
    end
    object qPromotionDetailsFavourCustomerOrCompany: TStringField
      FieldName = 'FavourCustomerOrCompany'
      ReadOnly = True
      Size = 8
    end
    object qPromotionDetailsStatus: TStringField
      FieldName = 'Status'
      ReadOnly = True
      Size = 8
    end
    object qPromotionDetailsGlobalRewardPrice: TBCDField
      FieldName = 'GlobalRewardPrice'
      OnGetText = GetText_BlankToNA
      currency = True
      Precision = 19
    end
    object qPromotionDetailsPromoTypeID: TSmallintField
      FieldName = 'PromoTypeID'
    end
    object qPromotionDetailsCardActivated: TBooleanField
      FieldName = 'CardActivated'
    end
    object qPromotionDetailsDisplayString: TStringField
      FieldName = 'DisplayString'
    end
    object qPromotionDetailsExtendedFlag: TBooleanField
      FieldName = 'ExtendedFlag'
    end
    object qPromotionDetailsUserSelectsProducts: TBooleanField
      FieldName = 'UserSelectsProducts'
    end
  end
  object dsPromotionDetails: TDataSource
    DataSet = qPromotionDetails
    Left = 64
    Top = 302
  end
  object qSiteRewardPrice: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    DataSource = dsSalesAreas
    Parameters = <
      item
        Name = 'PromotionID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = 23
      end
      item
        Name = 'SalesAreaID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Value = 2
      end>
    SQL.Strings = (
      'select RewardPrice'
      'from PromotionSalesAreaRewardPrice'
      'where PromotionID = :PromotionID and SalesAreaID = :SalesAreaID')
    Left = 32
    Top = 334
    object qSiteRewardPriceRewardPrice: TBCDField
      FieldName = 'RewardPrice'
      OnGetText = GetText_BlankToNA
      currency = True
      Precision = 19
    end
  end
  object dsSiteRewardPrice: TDataSource
    DataSet = qSiteRewardPrice
    Left = 64
    Top = 334
  end
  object ppDBPipelinePromotion: TppDBPipeline
    DataSource = dsPromotionDetails
    UserName = 'DBPipelinePromotion'
    Left = 96
    Top = 446
    object ppDBPipelinePromotionppField1: TppField
      FieldAlias = 'SiteCode'
      FieldName = 'SiteCode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField2: TppField
      FieldAlias = 'PromotionID'
      FieldName = 'PromotionID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField3: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField4: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField5: TppField
      FieldAlias = 'PromoTypeName'
      FieldName = 'PromoTypeName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField6: TppField
      FieldAlias = 'StartDate'
      FieldName = 'StartDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField7: TppField
      FieldAlias = 'EndDate'
      FieldName = 'EndDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField8: TppField
      FieldAlias = 'FavourCustomerOrCompany'
      FieldName = 'FavourCustomerOrCompany'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField9: TppField
      FieldAlias = 'Status'
      FieldName = 'Status'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField10: TppField
      FieldAlias = 'GlobalRewardPrice'
      FieldName = 'GlobalRewardPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField11: TppField
      FieldAlias = 'PromoTypeID'
      FieldName = 'PromoTypeID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField12: TppField
      FieldAlias = 'CardActivated'
      FieldName = 'CardActivated'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField13: TppField
      FieldAlias = 'DisplayString'
      FieldName = 'DisplayString'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField14: TppField
      FieldAlias = 'ExtendedFlag'
      FieldName = 'ExtendedFlag'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionppField15: TppField
      FieldAlias = 'UserSelectsProducts'
      FieldName = 'UserSelectsProducts'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
  end
  object ppPromotionSummary: TppReport
    AutoStop = False
    DataPipeline = ppDBPipelinePromotion
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
    OnPreviewFormCreate = ppPromotionSummaryPreviewFormCreate
    Left = 32
    Top = 446
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipelinePromotion'
    object ppTitleBand1: TppTitleBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 75671
      mmPrintPosition = 0
      object ppRegion1: TppRegion
        UserName = 'Region1'
        Caption = 'Region1'
        Stretch = True
        mmHeight = 75142
        mmLeft = 0
        mmTop = 0
        mmWidth = 202671
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppLabel2: TppLabel
          UserName = 'Label2'
          Caption = 'Promotion Name:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 4498
          mmTop = 14552
          mmWidth = 29369
          BandType = 1
        end
        object ppDBTextPromoName: TppDBText
          UserName = 'DBTextPromoName'
          DataField = 'Name'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 35719
          mmTop = 14552
          mmWidth = 75936
          BandType = 1
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          Caption = 'Description:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 13229
          mmTop = 20902
          mmWidth = 20638
          BandType = 1
        end
        object ppShape1: TppShape
          UserName = 'Shape1'
          mmHeight = 8731
          mmLeft = 66411
          mmTop = 0
          mmWidth = 69850
          BandType = 1
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          Caption = 'Promotion Summary Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4995
          mmLeft = 72496
          mmTop = 2381
          mmWidth = 56388
          BandType = 1
        end
        object ppDBMemoDescription: TppDBMemo
          UserName = 'DBMemoDescription'
          CharWrap = False
          DataField = 'Description'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Stretch = True
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 4233
          mmLeft = 35719
          mmTop = 20902
          mmWidth = 75671
          BandType = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
      end
      object ppRegion2: TppRegion
        UserName = 'Region2'
        Brush.Style = bsClear
        Caption = 'Region2'
        Pen.Style = psClear
        ShiftRelativeTo = ppDBMemoDescription
        Transparent = True
        mmHeight = 48419
        mmLeft = 1852
        mmTop = 25665
        mmWidth = 105569
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Type:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 24342
          mmTop = 28310
          mmWidth = 9525
          BandType = 1
        end
        object ppDBTextPromoType: TppDBText
          UserName = 'DBTextPromoType'
          DataField = 'PromoTypeName'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 35719
          mmTop = 28310
          mmWidth = 55033
          BandType = 1
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          Caption = 'Favour:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 20902
          mmTop = 34396
          mmWidth = 12965
          BandType = 1
        end
        object ppDBTextFavour: TppDBText
          UserName = 'DBTextFavour'
          DataField = 'FavourCustomerOrCompany'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 35719
          mmTop = 34660
          mmWidth = 54769
          BandType = 1
        end
        object ppLabel6: TppLabel
          UserName = 'Label6'
          Caption = 'Status:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 21960
          mmTop = 40746
          mmWidth = 11906
          BandType = 1
        end
        object ppDBTextStatus: TppDBText
          UserName = 'DBTextStatus'
          DataField = 'Status'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 35719
          mmTop = 41010
          mmWidth = 16933
          BandType = 1
        end
        object ppLabelRewardPrice: TppLabel
          UserName = 'LabelRewardPrice'
          Caption = 'Reward price:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 10319
          mmTop = 56621
          mmWidth = 23283
          BandType = 1
        end
        object ppDBTextRewardPrice: TppDBText
          UserName = 'DBTextRewardPrice'
          DataField = 'GlobalRewardPrice'
          DataPipeline = ppDBPipelinePromotion
          DisplayFormat = '$0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 35190
          mmTop = 56886
          mmWidth = 17198
          BandType = 1
        end
        object ppLabelCardActivated: TppLabel
          UserName = 'LabelCardActivated'
          Caption = 'Card Activated Promotion'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 6879
          mmTop = 62971
          mmWidth = 43656
          BandType = 1
        end
        object ppLabelValidation: TppLabel
          UserName = 'LabelValidation'
          Caption = 'Card validation:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 7144
          mmTop = 67998
          mmWidth = 26723
          BandType = 1
        end
        object ppDBTextValidType: TppDBText
          UserName = 'DBTextValidType'
          DataField = 'DisplayString'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 4498
          mmLeft = 35454
          mmTop = 68263
          mmWidth = 55298
          BandType = 1
        end
        object ppLblPromoDeal: TppLabel
          UserName = 'LblPromoDeal'
          Caption = 'This is a Promotional Deal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          Visible = False
          mmHeight = 4191
          mmLeft = 35719
          mmTop = 47096
          mmWidth = 43984
          BandType = 1
        end
      end
      object ppRegion3: TppRegion
        UserName = 'Region3'
        Caption = 'Region3'
        Stretch = True
        mmHeight = 21167
        mmLeft = 114829
        mmTop = 16140
        mmWidth = 86519
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppLabel10: TppLabel
          UserName = 'Label10'
          Caption = 'Dates:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4191
          mmLeft = 116152
          mmTop = 21167
          mmWidth = 10753
          BandType = 1
        end
        object ppDBText3: TppDBText
          UserName = 'DBText3'
          DataField = 'StartDate'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 129116
          mmTop = 21432
          mmWidth = 28840
          BandType = 1
        end
        object ppLabel11: TppLabel
          UserName = 'Label11'
          Caption = 'to'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3969
          mmLeft = 149489
          mmTop = 21432
          mmWidth = 14552
          BandType = 1
        end
        object ppDBText4: TppDBText
          UserName = 'DBText4'
          OnGetText = ppDBText4GetText
          DataField = 'EndDate'
          DataPipeline = ppDBPipelinePromotion
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelinePromotion'
          mmHeight = 3969
          mmLeft = 155839
          mmTop = 21432
          mmWidth = 28840
          BandType = 1
        end
        object ppLabel12: TppLabel
          UserName = 'Label12'
          Caption = 'Times:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4191
          mmLeft = 116152
          mmTop = 27252
          mmWidth = 11388
          BandType = 1
        end
        object ppMemoValidDaysTimes: TppMemo
          UserName = 'MemoValidDaysTimes'
          Caption = 'MemoValidDaysTimes'
          CharWrap = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Name = 'Courier'
          Font.Pitch = fpFixed
          Font.Size = 11
          Font.Style = []
          Stretch = True
          Transparent = True
          mmHeight = 4763
          mmLeft = 129116
          mmTop = 27252
          mmWidth = 72231
          BandType = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
        object ppMemoBufferSpace: TppMemo
          UserName = 'MemoBufferSpace'
          Caption = 'MemoBufferSpace'
          CharWrap = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          ShiftRelativeTo = ppMemoValidDaysTimes
          Transparent = True
          mmHeight = 2381
          mmLeft = 129116
          mmTop = 33073
          mmWidth = 54504
          BandType = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
      end
      object ppRegion4: TppRegion
        UserName = 'Region4'
        Caption = 'Region4'
        Pen.Style = psClear
        mmHeight = 8467
        mmLeft = 118798
        mmTop = 11642
        mmWidth = 34131
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppLabel9: TppLabel
          UserName = 'Label9'
          Caption = 'Activation Settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4191
          mmLeft = 120121
          mmTop = 13494
          mmWidth = 31792
          BandType = 1
        end
      end
    end
    object ppHeaderBand1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 22490
      mmPrintPosition = 0
      object ppSubReportExceptionOverrides: TppSubReport
        UserName = 'SubReportExceptionOverrides'
        ExpandAll = False
        NewPrintJob = False
        ShiftRelativeTo = SubReportSaRewardPrices
        TraverseAllData = False
        DataPipelineName = 'ppDBPipelineExceptions'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 8731
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPipelineExceptions
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
          DataPipelineName = 'ppDBPipelineExceptions'
          object ppTitleBand2: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 21167
            mmPrintPosition = 0
            object ppLabel13: TppLabel
              UserName = 'Label13'
              Caption = 'Site'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 15346
              mmTop = 15081
              mmWidth = 6350
              BandType = 1
            end
            object ppLabel14: TppLabel
              UserName = 'Label14'
              Caption = 'Sales Area'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 47890
              mmTop = 15081
              mmWidth = 17727
              BandType = 1
            end
            object ppLabel15: TppLabel
              UserName = 'Label15'
              Caption = 'Start Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 77258
              mmTop = 15081
              mmWidth = 16669
              BandType = 1
            end
            object ppLabel16: TppLabel
              UserName = 'Label16'
              Caption = 'End Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 97367
              mmTop = 15081
              mmWidth = 15346
              BandType = 1
            end
            object ppLabel17: TppLabel
              UserName = 'Label17'
              Caption = 'Valid Days'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 122767
              mmTop = 15081
              mmWidth = 17727
              BandType = 1
            end
            object ppLabel18: TppLabel
              UserName = 'Label18'
              Caption = 'Start Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 151871
              mmTop = 15081
              mmWidth = 17727
              BandType = 1
            end
            object ppLabel19: TppLabel
              UserName = 'Label19'
              Caption = 'End Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 170657
              mmTop = 15081
              mmWidth = 16404
              BandType = 1
            end
            object ppLine1: TppLine
              UserName = 'Line1'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 1588
              mmLeft = 0
              mmTop = 13229
              mmWidth = 188384
              BandType = 1
            end
            object ppShape2: TppShape
              UserName = 'Shape2'
              Brush.Color = clBtnFace
              Pen.Width = 2
              mmHeight = 8996
              mmLeft = 0
              mmTop = 5027
              mmWidth = 49742
              BandType = 1
            end
            object ppLabel20: TppLabel
              UserName = 'Label20'
              Caption = 'Exception Overrides'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 8202
              mmTop = 6879
              mmWidth = 34131
              BandType = 1
            end
            object ppLine4: TppLine
              UserName = 'Line4'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 7673
              mmLeft = 0
              mmTop = 13229
              mmWidth = 2646
              BandType = 1
            end
            object ppLine13: TppLine
              UserName = 'Line11'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 38100
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine14: TppLine
              UserName = 'Line14'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 151077
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine15: TppLine
              UserName = 'Line15'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 169598
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine16: TppLine
              UserName = 'Line16'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 7673
              mmLeft = 187061
              mmTop = 13494
              mmWidth = 1323
              BandType = 1
            end
            object ppLine17: TppLine
              UserName = 'Line17'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 75406
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine18: TppLine
              UserName = 'Line18'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 94986
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine19: TppLine
              UserName = 'Line19'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 114565
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine20: TppLine
              UserName = 'Line20'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1588
              mmLeft = 0
              mmTop = 19579
              mmWidth = 188119
              BandType = 1
            end
          end
          object ppHeaderBand2: TppHeaderBand
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object ppDetailBand2: TppDetailBand
            PrintHeight = phDynamic
            mmBottomOffset = 0
            mmHeight = 7408
            mmPrintPosition = 0
            object ppDBText5: TppDBText
              UserName = 'DBTextSiteName'
              DataField = 'SiteName'
              DataPipeline = ppDBPipelineExceptions
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              ResetGroup = ppGroupExceptionsSalesAreaId
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 1852
              mmTop = 1588
              mmWidth = 35433
              BandType = 4
            end
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              DataField = 'SalesAreaName'
              DataPipeline = ppDBPipelineExceptions
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              ResetGroup = ppGroupExceptionsSalesAreaId
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 39158
              mmTop = 1588
              mmWidth = 35433
              BandType = 4
            end
            object ppDBText7: TppDBText
              UserName = 'DBTextStartDate'
              DataField = 'StartDate'
              DataPipeline = ppDBPipelineExceptions
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              ResetGroup = ppGroupExceptionsSalesAreaId
              SuppressRepeatedValues = True
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 76465
              mmTop = 1588
              mmWidth = 17198
              BandType = 4
            end
            object ppDBTextValidDays: TppDBText
              UserName = 'DBTextValidDays'
              DataField = 'ValidDaysDisplay'
              DataPipeline = ppDBPipelineExceptions
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 116152
              mmTop = 1588
              mmWidth = 34396
              BandType = 4
            end
            object ppDBText10: TppDBText
              UserName = 'DBText10'
              DataField = 'StartTime'
              DataPipeline = ppDBPipelineExceptions
              DisplayFormat = 'hh:nn'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 152665
              mmTop = 1588
              mmWidth = 15081
              BandType = 4
            end
            object ppDBText11: TppDBText
              UserName = 'DBText11'
              DataField = 'EndTime'
              DataPipeline = ppDBPipelineExceptions
              DisplayFormat = 'hh:nn'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 170921
              mmTop = 1588
              mmWidth = 15081
              BandType = 4
            end
            object ppLine2: TppLine
              UserName = 'Line2'
              Weight = 0.75
              mmHeight = 1058
              mmLeft = 0
              mmTop = 0
              mmWidth = 188119
              BandType = 4
            end
            object ppLine5: TppLine
              UserName = 'Line5'
              Pen.Width = 2
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 1.5
              mmHeight = 7408
              mmLeft = 0
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine6: TppLine
              UserName = 'Line6'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 38100
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine7: TppLine
              UserName = 'Line7'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 75406
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine8: TppLine
              UserName = 'Line8'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 94986
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine9: TppLine
              UserName = 'Line9'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 114565
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine10: TppLine
              UserName = 'Line10'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 151077
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine11: TppLine
              UserName = 'Line101'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 169598
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine12: TppLine
              UserName = 'Line12'
              Pen.Width = 2
              ParentHeight = True
              Position = lpRight
              StretchWithParent = True
              Weight = 1.5
              mmHeight = 7408
              mmLeft = 186796
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppDBText8: TppDBText
              UserName = 'DBTextEndDate'
              DataField = 'EndDate'
              DataPipeline = ppDBPipelineExceptions
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              ResetGroup = ppGroupExceptionsSalesAreaId
              SuppressRepeatedValues = True
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppDBPipelineExceptions'
              mmHeight = 3969
              mmLeft = 96309
              mmTop = 1852
              mmWidth = 17198
              BandType = 4
            end
          end
          object ppSummaryBand2: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 265
            mmPrintPosition = 0
            object ppLine21: TppLine
              UserName = 'Line21'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 265
              mmLeft = 0
              mmTop = 0
              mmWidth = 188384
              BandType = 7
            end
          end
          object ppGroupExceptionsSalesAreaId: TppGroup
            BreakName = 'SalesAreaId'
            DataPipeline = ppDBPipelineExceptions
            KeepTogether = True
            UserName = 'GroupExceptionsSalesAreaId'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'ppDBPipelineExceptions'
            object ppGroupHeaderBand3: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroupFooterBand3: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
          end
        end
      end
      object ppSubReportPromotionPrices: TppSubReport
        UserName = 'SubReportPromotionPrices'
        ExpandAll = False
        NewPrintJob = False
        ShiftRelativeTo = ppSubReportExceptionOverrides
        TraverseAllData = False
        DataPipelineName = 'ppDBPipelinePromotionPrices'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 16140
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport2: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPipelinePromotionPrices
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
          DataPipelineName = 'ppDBPipelinePromotionPrices'
          object ppTitleBand3: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 7673
            mmPrintPosition = 0
          end
          object ppDetailBand3: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 7408
            mmPrintPosition = 0
            object ppDBText13: TppDBText
              UserName = 'DBText13'
              DataField = 'Extended RTL Name'
              DataPipeline = ppDBPipelinePromotionPrices
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppDBPipelinePromotionPrices'
              mmHeight = 3969
              mmLeft = 2381
              mmTop = 1588
              mmWidth = 35454
              BandType = 4
            end
            object ppDBText9: TppDBText
              UserName = 'DBText9'
              DataField = 'PortionName'
              DataPipeline = ppDBPipelinePromotionPrices
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPipelinePromotionPrices'
              mmHeight = 3969
              mmLeft = 40217
              mmTop = 1588
              mmWidth = 35454
              BandType = 4
            end
            object ppDBTextPrice: TppDBText
              UserName = 'DBTextPrice'
              OnGetText = ppDBTextPriceGetText
              DataField = 'Price'
              DataPipeline = ppDBPipelinePromotionPrices
              DisplayFormat = '$0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPipelinePromotionPrices'
              mmHeight = 3969
              mmLeft = 84138
              mmTop = 1588
              mmWidth = 17198
              BandType = 4
            end
            object ppLine30: TppLine
              UserName = 'Line30'
              ParentHeight = True
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 38894
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine31: TppLine
              UserName = 'Line301'
              ParentHeight = True
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 76729
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine32: TppLine
              UserName = 'Line32'
              Pen.Width = 2
              ParentHeight = True
              Position = lpRight
              Weight = 1.5
              mmHeight = 7408
              mmLeft = 105834
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine33: TppLine
              UserName = 'Line33'
              Pen.Width = 2
              ParentHeight = True
              Position = lpLeft
              Weight = 1.5
              mmHeight = 7408
              mmLeft = 0
              mmTop = 0
              mmWidth = 1323
              BandType = 4
            end
            object ppLine34: TppLine
              UserName = 'Line34'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1852
              mmLeft = 0
              mmTop = 5555
              mmWidth = 107156
              BandType = 4
            end
          end
          object ppGroup2: TppGroup
            BreakName = 'SiteAndSalesAreaName'
            DataPipeline = ppDBPipelinePromotionPrices
            UserName = 'Group2'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'ppDBPipelinePromotionPrices'
            object ppGroupHeaderBand2: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 10583
              mmPrintPosition = 0
              object ppShape4: TppShape
                UserName = 'Shape4'
                Brush.Color = clBtnFace
                Pen.Width = 2
                mmHeight = 10583
                mmLeft = 0
                mmTop = 265
                mmWidth = 107686
                BandType = 3
                GroupNo = 1
              end
              object DBTextSiteSalesArea: TppDBText
                UserName = 'DBTextSiteSalesArea'
                DataField = 'SiteAndSalesAreaName'
                DataPipeline = ppDBPipelinePromotionPrices
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                ParentDataPipeline = False
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDBPipelinePromotionPrices'
                mmHeight = 4233
                mmLeft = 3175
                mmTop = 3175
                mmWidth = 79375
                BandType = 3
                GroupNo = 1
              end
              object ppLabelContinued1: TppLabel
                OnPrint = ppLabelContinued1Print
                UserName = 'LabelContinued1'
                Caption = 'contd...'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 4233
                mmLeft = 92075
                mmTop = 3175
                mmWidth = 12435
                BandType = 3
                GroupNo = 0
              end
            end
            object ppGroupFooterBand2: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 7938
              mmPrintPosition = 0
            end
          end
          object ppGroup1: TppGroup
            BreakName = 'GroupName'
            DataPipeline = ppDBPipelinePromotionPrices
            UserName = 'Group1'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'ppDBPipelinePromotionPrices'
            object ppGroupHeaderBand1: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 18521
              mmPrintPosition = 0
              object DBTextSalesGroup1: TppDBText
                UserName = 'DBTextSalesGroup1'
                DataField = 'GroupName'
                DataPipeline = ppDBPipelinePromotionPrices
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                ReprintOnSubsequent = True
                ResetGroup = ppGroup2
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppDBPipelinePromotionPrices'
                mmHeight = 3969
                mmLeft = 26458
                mmTop = 3969
                mmWidth = 40746
                BandType = 3
                GroupNo = 1
              end
              object ppLabelContinued2: TppLabel
                OnPrint = DBTextSalesGroupPrint
                UserName = 'LabelContinued2'
                Caption = 'contd...'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                mmHeight = 3969
                mmLeft = 68527
                mmTop = 3969
                mmWidth = 11642
                BandType = 3
                GroupNo = 1
              end
              object ppLine35: TppLine
                UserName = 'Line35'
                Pen.Width = 2
                ParentHeight = True
                Position = lpLeft
                Weight = 1.5
                mmHeight = 18521
                mmLeft = 0
                mmTop = 0
                mmWidth = 3440
                BandType = 3
                GroupNo = 1
              end
              object ppLine36: TppLine
                UserName = 'Line36'
                Pen.Width = 2
                Weight = 1.5
                mmHeight = 1588
                mmLeft = 0
                mmTop = 10319
                mmWidth = 107421
                BandType = 3
                GroupNo = 1
              end
              object ppLabel26: TppLabel
                UserName = 'Label26'
                Caption = 'Product'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 4233
                mmLeft = 13229
                mmTop = 12700
                mmWidth = 13229
                BandType = 3
                GroupNo = 1
              end
              object ppLine38: TppLine
                UserName = 'Line38'
                Position = lpLeft
                Weight = 0.75
                mmHeight = 7673
                mmLeft = 38894
                mmTop = 10583
                mmWidth = 1852
                BandType = 3
                GroupNo = 1
              end
              object ppLine39: TppLine
                UserName = 'Line39'
                Pen.Width = 2
                Position = lpBottom
                Weight = 1.5
                mmHeight = 1588
                mmLeft = 0
                mmTop = 16933
                mmWidth = 107421
                BandType = 3
                GroupNo = 1
              end
              object ppLine40: TppLine
                UserName = 'Line40'
                Pen.Width = 2
                ParentHeight = True
                Position = lpRight
                Weight = 1.5
                mmHeight = 18521
                mmLeft = 105834
                mmTop = 0
                mmWidth = 1588
                BandType = 3
                GroupNo = 1
              end
              object ppLabel27: TppLabel
                UserName = 'Label27'
                Caption = 'Portion'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 4233
                mmLeft = 50800
                mmTop = 12700
                mmWidth = 12435
                BandType = 3
                GroupNo = 1
              end
              object ppLabel28: TppLabel
                UserName = 'Label28'
                Caption = 'Promotion Price'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 4191
                mmLeft = 78581
                mmTop = 12700
                mmWidth = 27136
                BandType = 3
                GroupNo = 1
              end
              object ppLine41: TppLine
                UserName = 'Line41'
                Position = lpLeft
                Weight = 0.75
                mmHeight = 8202
                mmLeft = 76729
                mmTop = 10319
                mmWidth = 1588
                BandType = 3
                GroupNo = 1
              end
              object ppLabel29: TppLabel
                UserName = 'Label29'
                Caption = 'Sales Group:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 4233
                mmLeft = 2910
                mmTop = 3704
                mmWidth = 21960
                BandType = 3
                GroupNo = 1
              end
            end
            object ppGroupFooterBand1: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 265
              mmPrintPosition = 0
              object ppLine3: TppLine
                UserName = 'Line3'
                Weight = 0.75
                mmHeight = 265
                mmLeft = 0
                mmTop = 0
                mmWidth = 107156
                BandType = 5
                GroupNo = 1
              end
            end
          end
        end
      end
      object SubReportSaRewardPrices: TppSubReport
        UserName = 'SubReportSaRewardPrices'
        ExpandAll = False
        NewPrintJob = False
        TraverseAllData = False
        DataPipelineName = 'ppDBPipelineSaRewardPrices'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 1852
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport3: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPipelineSaRewardPrices
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
          DataPipelineName = 'ppDBPipelineSaRewardPrices'
          object ppTitleBand4: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 21167
            mmPrintPosition = 0
            object ppLabel7: TppLabel
              UserName = 'Label7'
              Caption = 'Site'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 15081
              mmTop = 15081
              mmWidth = 8467
              BandType = 1
            end
            object ppLabel8: TppLabel
              UserName = 'Label8'
              Caption = 'Sales Area'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 47625
              mmTop = 15346
              mmWidth = 19315
              BandType = 1
            end
            object ppLine22: TppLine
              UserName = 'Line22'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 1588
              mmLeft = 0
              mmTop = 13494
              mmWidth = 102923
              BandType = 1
            end
            object ppShape3: TppShape
              UserName = 'Shape3'
              Brush.Color = clBtnFace
              Pen.Width = 2
              mmHeight = 8996
              mmLeft = 0
              mmTop = 5292
              mmWidth = 49742
              BandType = 1
            end
            object ppLabel30: TppLabel
              UserName = 'Label201'
              Caption = 'Site Reward Prices'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 7938
              mmTop = 7144
              mmWidth = 34396
              BandType = 1
            end
            object ppLine23: TppLine
              UserName = 'Line23'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 7673
              mmLeft = 0
              mmTop = 13229
              mmWidth = 2646
              BandType = 1
            end
            object ppLine24: TppLine
              UserName = 'Line24'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 37835
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLine27: TppLine
              UserName = 'Line27'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 7673
              mmLeft = 101865
              mmTop = 13494
              mmWidth = 1323
              BandType = 1
            end
            object ppLine42: TppLine
              UserName = 'Line201'
              Position = lpBottom
              Weight = 0.75
              mmHeight = 1588
              mmLeft = 0
              mmTop = 19579
              mmWidth = 102923
              BandType = 1
            end
            object ppLine25: TppLine
              UserName = 'Line25'
              Position = lpLeft
              Weight = 0.75
              mmHeight = 7408
              mmLeft = 75405
              mmTop = 13494
              mmWidth = 2117
              BandType = 1
            end
            object ppLabel21: TppLabel
              UserName = 'Label21'
              Caption = 'Reward Price'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4233
              mmLeft = 76994
              mmTop = 15346
              mmWidth = 23813
              BandType = 1
            end
          end
          object ppDetailBand4: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 7409
            mmPrintPosition = 0
            object ppLine26: TppLine
              UserName = 'Line26'
              Pen.Width = 2
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 1.5
              mmHeight = 7409
              mmLeft = 0
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppDBText1: TppDBText
              UserName = 'DBTextSiteName1'
              DataField = 'SiteName'
              DataPipeline = ppDBPipelineSaRewardPrices
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppDBPipelineSaRewardPrices'
              mmHeight = 3969
              mmLeft = 1588
              mmTop = 1588
              mmWidth = 35454
              BandType = 4
            end
            object ppLine28: TppLine
              UserName = 'Line28'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7409
              mmLeft = 37835
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppDBText2: TppDBText
              UserName = 'DBText2'
              DataField = 'SalesAreaName'
              DataPipeline = ppDBPipelineSaRewardPrices
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPipelineSaRewardPrices'
              mmHeight = 3969
              mmLeft = 38894
              mmTop = 1588
              mmWidth = 35454
              BandType = 4
            end
            object ppLine29: TppLine
              UserName = 'Line29'
              ParentHeight = True
              Position = lpLeft
              StretchWithParent = True
              Weight = 0.75
              mmHeight = 7409
              mmLeft = 75142
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine37: TppLine
              UserName = 'Line37'
              Weight = 0.75
              mmHeight = 1058
              mmLeft = 0
              mmTop = 0
              mmWidth = 102923
              BandType = 4
            end
            object ppLine43: TppLine
              UserName = 'Line43'
              Pen.Width = 2
              ParentHeight = True
              Position = lpRight
              StretchWithParent = True
              Weight = 1.5
              mmHeight = 7409
              mmLeft = 101865
              mmTop = 0
              mmWidth = 1323
              BandType = 4
            end
            object ppDBText12: TppDBText
              UserName = 'DBText1'
              DataField = 'RewardPrice'
              DataPipeline = ppDBPipelineSaRewardPrices
              DisplayFormat = '$0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPipelineSaRewardPrices'
              mmHeight = 3969
              mmLeft = 78052
              mmTop = 1852
              mmWidth = 20373
              BandType = 4
            end
          end
          object ppSummaryBand1: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 1058
            mmPrintPosition = 0
            object ppLine44: TppLine
              UserName = 'Line44'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 1058
              mmLeft = 0
              mmTop = 0
              mmWidth = 102923
              BandType = 7
            end
          end
        end
      end
    end
  end
  object qExceptionsForReport: TADODataSet
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    OnCalcFields = ValidDaysCalcFields
    CommandText = 
      'SELECT e.Name AS SiteName, d.Name AS SalesAreaName, d.Id AS Sale' +
      'sAreaId,'#13#10'  a.StartDate, CASE a.ChangeEndDate WHEN 1 THEN a.EndD' +
      'ate ELSE NULL END AS EndDate,'#13#10'  c.ValidDays, c.StartTime, c.End' +
      'Time'#13#10'FROM #PromotionException a'#13#10'  INNER JOIN #PromotionExcepti' +
      'onSalesArea b ON a.ExceptionId = b.ExceptionId'#13#10'  INNER JOIN #Pr' +
      'omotionExceptionTimeCycles c ON a.ExceptionId = c.ExceptionId'#13#10' ' +
      ' INNER JOIN ac_SalesArea d ON b.SalesAreaId = d.Id'#13#10'  INNER JOIN' +
      ' ac_Site e ON d.Siteid = e.Id'#13#10'WHERE a.Status = 0'#13#10'ORDER BY e.Na' +
      'me, d.Name'
    Parameters = <>
    Left = 32
    Top = 478
    object qExceptionsForReportSiteName: TStringField
      FieldName = 'SiteName'
    end
    object qExceptionsForReportSalesAreaName: TStringField
      FieldName = 'SalesAreaName'
    end
    object qExceptionsForReportSalesAreaID: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalesAreaID'
      Visible = False
    end
    object qExceptionsForReportStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qExceptionsForReportEndDate: TDateTimeField
      FieldName = 'EndDate'
      ReadOnly = True
    end
    object qExceptionsForReportValidDays: TStringField
      FieldName = 'ValidDays'
      Size = 7
    end
    object qExceptionsForReportStartTime: TDateTimeField
      FieldName = 'StartTime'
      DisplayFormat = 'hh:nn'
    end
    object qExceptionsForReportEndTime: TDateTimeField
      FieldName = 'EndTime'
      DisplayFormat = 'hh:nn'
    end
    object qExceptionsForReportValidDaysDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      Calculated = True
    end
  end
  object dsExceptionsForReport: TDataSource
    DataSet = qExceptionsForReport
    Left = 64
    Top = 478
  end
  object ppDBPipelineExceptions: TppDBPipeline
    DataSource = dsExceptionsForReport
    UserName = 'DBPipelineExceptions'
    Left = 96
    Top = 478
    object ppDBPipelineExceptionsppField1: TppField
      FieldAlias = 'SiteName'
      FieldName = 'SiteName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField2: TppField
      FieldAlias = 'SalesAreaName'
      FieldName = 'SalesAreaName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField3: TppField
      FieldAlias = 'StartDate'
      FieldName = 'StartDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField4: TppField
      FieldAlias = 'EndDate'
      FieldName = 'EndDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField5: TppField
      FieldAlias = 'ValidDays'
      FieldName = 'ValidDays'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField6: TppField
      FieldAlias = 'StartTime'
      FieldName = 'StartTime'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField7: TppField
      FieldAlias = 'EndTime'
      FieldName = 'EndTime'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField8: TppField
      FieldAlias = 'ValidDaysDisplay'
      FieldName = 'ValidDaysDisplay'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineExceptionsppField9: TppField
      FieldAlias = 'SalesAreaId'
      FieldName = 'SalesAreaId'
      FieldLength = 10
      DataType = dtInteger
      DisplayWidth = 10
      Position = 8
    end
  end
  object qPromoPricesForReport: TADODataSet
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    CommandText = 
      'SELECT s.Name + '#39' \ '#39' + sa.Name AS SiteAndSalesAreaName, '#13#10'  CAS' +
      'E WHEN pr.PromoTypeId = 4 THEN -- 4 = '#39'Event Pricing'#39#13#10'    psg.N' +
      'ame'#13#10'  ELSE'#13#10'    '#39'Group '#39' + CONVERT(VARCHAR(2),psg.SaleGroupId) ' +
      '+ '#39' ,  Sale quantity '#39' + CONVERT(VARCHAR(5), psg.Quantity) '#13#10'  E' +
      'ND AS GroupName,'#13#10'  p.[Extended RTL Name], pt.Name AS PortionNam' +
      'e,'#13#10'  CASE WHEN  pr.PromoTypeId = 2 THEN -- 2 = '#39'Multi Buy'#39#13#10'   ' +
      '   NULL  -- Multi-buys have a single reward price so not interes' +
      'ted in any per product price'#13#10'  ELSE'#13#10'      pp.Price'#13#10'  END AS P' +
      'rice'#13#10#13#10'FROM #Promotion pr'#13#10'     INNER JOIN #PromotionSaleGroup ' +
      'psg ON pr.PromotionId = psg.PromotionId'#13#10'     INNER JOIN #Promot' +
      'ionPrices pp ON psg.PromotionId = pp.PromotionId AND psg.SaleGro' +
      'upId = pp.SaleGroupId'#13#10'     INNER JOIN Products p ON pp.ProductI' +
      'd = p.EntityCode'#13#10'     INNER JOIN ac_PortionType pt ON pp.Portio' +
      'nTypeId = pt.Id'#13#10'     INNER JOIN ac_SalesArea sa ON pp.SalesArea' +
      'Id = sa.Id'#13#10'     INNER JOIN ac_Site s ON sa.Siteid = s.Id'#13#10'ORDER' +
      ' BY SiteAndSalesAreaName, psg.SaleGroupId, p.[Extended RTL Name]' +
      ', pt.Id'#13#10#13#10
    Parameters = <>
    Left = 32
    Top = 513
    object qPromoPricesForReportSiteAndSalesAreaName: TStringField
      FieldName = 'SiteAndSalesAreaName'
      ReadOnly = True
      Size = 43
    end
    object qPromoPricesForReportGroupName: TStringField
      FieldName = 'GroupName'
      ReadOnly = True
      Size = 30
    end
    object qPromoPricesForReportExtendedRTLName: TStringField
      FieldName = 'Extended RTL Name'
      Size = 16
    end
    object qPromoPricesForReportPortionName: TStringField
      FieldName = 'PortionName'
      Size = 16
    end
    object qPromoPricesForReportPrice: TBCDField
      FieldName = 'Price'
      Precision = 19
    end
  end
  object dsPromoPricesForReport: TDataSource
    DataSet = qPromoPricesForReport
    Left = 64
    Top = 510
  end
  object ppDBPipelinePromotionPrices: TppDBPipeline
    DataSource = dsPromoPricesForReport
    UserName = 'DBPipelinePromotionPrices'
    Left = 96
    Top = 510
    object ppDBPipelinePromotionPricesppField1: TppField
      FieldAlias = 'SiteAndSalesAreaName'
      FieldName = 'SiteAndSalesAreaName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionPricesppField2: TppField
      FieldAlias = 'GroupName'
      FieldName = 'GroupName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionPricesppField3: TppField
      FieldAlias = 'Quantity'
      FieldName = 'Quantity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionPricesppField4: TppField
      FieldAlias = 'Extended RTL Name'
      FieldName = 'Extended RTL Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionPricesppField5: TppField
      FieldAlias = 'PortionName'
      FieldName = 'PortionName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelinePromotionPricesppField6: TppField
      FieldAlias = 'Price'
      FieldName = 'Price'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
  end
  object qSaRewardPricesForReport: TADODataSet
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    CommandText = 
      'SELECT s.Name AS SiteName, sa.Name AS SalesAreaName, rp.RewardPr' +
      'ice'#13#10'FROM #PromotionSalesAreaRewardPrice rp'#13#10'     INNER JOIN ac_' +
      'SalesArea sa ON rp.SalesAreaId = sa.Id'#13#10'     INNER JOIN ac_Site ' +
      's ON sa.Siteid = s.Id'#13#10'ORDER BY s.Name, sa.Name'
    Parameters = <>
    Left = 32
    Top = 542
    object qSaRewardPricesForReportSiteName: TStringField
      FieldName = 'SiteName'
    end
    object qSaRewardPricesForReportSalesAreaName: TStringField
      FieldName = 'SalesAreaName'
    end
    object qSaRewardPricesForReportRewardPrice: TBCDField
      FieldName = 'RewardPrice'
      Precision = 19
    end
  end
  object dsSaRewardPricesForReport: TDataSource
    DataSet = qSaRewardPricesForReport
    Left = 64
    Top = 542
  end
  object ppDBPipelineSaRewardPrices: TppDBPipeline
    DataSource = dsSaRewardPricesForReport
    UserName = 'DBPipelineSaRewardPrices'
    Left = 96
    Top = 543
    object ppDBPipelineSaRewardPricesppField1: TppField
      FieldAlias = 'SiteName'
      FieldName = 'SiteName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineSaRewardPricesppField2: TppField
      FieldAlias = 'SalesAreaName'
      FieldName = 'SalesAreaName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineSaRewardPricesppField3: TppField
      FieldAlias = 'RewardPrice'
      FieldName = 'RewardPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
  end
  object qValidTimes: TADODataSet
    Connection = dmPromotions.AztecConn
    OnCalcFields = ValidDaysCalcFields
    CommandText = 
      'SELECT  ValidDays, StartTime, EndTime'#13#10'FROM #PromotionTimeCycles' +
      #13#10'ORDER BY DisplayOrder'
    Parameters = <>
    Left = 96
    Top = 302
    object qValidTimesValidDays: TStringField
      FieldName = 'ValidDays'
      Visible = False
      Size = 7
    end
    object qValidTimesStartTime: TDateTimeField
      DisplayLabel = 'Start'
      DisplayWidth = 5
      FieldName = 'StartTime'
      Visible = False
    end
    object qValidTimesEndTime: TDateTimeField
      DisplayLabel = 'End'
      DisplayWidth = 5
      FieldName = 'EndTime'
      Visible = False
    end
    object qValidTimesValidDaysDisplay: TStringField
      DisplayLabel = 'Days Active'
      DisplayWidth = 19
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      ReadOnly = True
      Calculated = True
    end
    object qValidTimesValidTimesDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'ValidTimesDisplay'
      ReadOnly = True
      Size = 11
      Calculated = True
    end
  end
  object dsValidTimes: TDataSource
    DataSet = qValidTimes
    Left = 128
    Top = 302
  end
  object qExceptionValidTimes: TADODataSet
    Connection = dmPromotions.AztecConn
    OnCalcFields = ValidDaysCalcFields
    CommandText = 
      'SELECT b.SalesAreaId, c.ValidDays, c.StartTime, c.EndTime'#13#10'FROM ' +
      '#PromotionException a'#13#10'  INNER JOIN #PromotionExceptionSalesArea' +
      ' b ON a.ExceptionId = b.ExceptionId'#13#10'  INNER JOIN #PromotionExce' +
      'ptionTimeCycles c ON a.ExceptionId = c.ExceptionId'#13#10'WHERE a.Stat' +
      'us = 0'#13#10
    DataSource = dsSalesAreas
    IndexFieldNames = 'SalesAreaId'
    MasterFields = 'SalesAreaID'
    Parameters = <>
    Left = 96
    Top = 398
    object qExceptionValidTimesSalesAreaId: TSmallintField
      FieldName = 'SalesAreaId'
      Visible = False
    end
    object StringField1: TStringField
      FieldName = 'ValidDays'
      Visible = False
      Size = 7
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Start'
      DisplayWidth = 5
      FieldName = 'StartTime'
      Visible = False
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'End'
      DisplayWidth = 5
      FieldName = 'EndTime'
      Visible = False
    end
    object StringField2: TStringField
      DisplayLabel = 'Days Active'
      DisplayWidth = 19
      FieldKind = fkCalculated
      FieldName = 'ValidDaysDisplay'
      ReadOnly = True
      Calculated = True
    end
    object StringField3: TStringField
      FieldKind = fkCalculated
      FieldName = 'ValidTimesDisplay'
      ReadOnly = True
      Size = 11
      Calculated = True
    end
  end
  object dsExceptionValidTimes: TDataSource
    DataSet = qExceptionValidTimes
    Left = 128
    Top = 398
  end
end
