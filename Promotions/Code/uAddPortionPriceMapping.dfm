object fAddPortionPriceMapping: TfAddPortionPriceMapping
  Left = 795
  Top = 226
  Width = 251
  Height = 232
  Caption = 'Portion Price Mapping'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 235
    Height = 159
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblSalesGroup: TLabel
      Left = 8
      Top = 11
      Width = 60
      Height = 13
      Caption = 'Sales group:'
    end
    object lblTargetPortion: TLabel
      Left = 8
      Top = 75
      Width = 73
      Height = 13
      Caption = 'Target portion:'
    end
    object lblSourcePortion: TLabel
      Left = 8
      Top = 43
      Width = 74
      Height = 13
      Caption = 'Source portion:'
    end
    object lblCalculationType: TLabel
      Left = 8
      Top = 107
      Width = 81
      Height = 13
      Caption = 'Calculation type:'
    end
    object lblValue: TLabel
      Left = 8
      Top = 139
      Width = 30
      Height = 13
      Caption = 'Value:'
    end
    object dblSaleGroup: TwwDBLookupCombo
      Left = 96
      Top = 8
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'SaleGroupId'#9'10'#9'SaleGroupId'#9#9)
      DataField = 'SaleGroupId'
      DataSource = dmPromotions.dsEditPromoPortionPriceMapping
      LookupTable = qPermissableSalesGroups
      LookupField = 'SaleGroupID'
      Style = csDropDownList
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = dblSaleGroupCloseUp
    end
    object dblTargetPortionType: TwwDBLookupCombo
      Left = 96
      Top = 72
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'16'#9'Name'#9#9)
      DataField = 'TargetPortionTypeId'
      DataSource = dmPromotions.dsEditPromoPortionPriceMapping
      LookupTable = qPermissableTargetPortions
      LookupField = 'Id'
      Style = csDropDownList
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object dblSourcePortiontype: TwwDBLookupCombo
      Left = 96
      Top = 40
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'16'#9'Name'#9'F'#9)
      DataField = 'SourcePortionTypeId'
      DataSource = dmPromotions.dsEditPromoPortionPriceMapping
      LookupTable = qPermissableBasePortions
      LookupField = 'Id'
      Style = csDropDownList
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = dblSourcePortiontypeCloseUp
    end
    object dblCalculationType: TwwDBLookupCombo
      Left = 96
      Top = 104
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PromoCalcDesc'#9'20'#9'PromoCalcDesc'#9#9)
      DataField = 'CalculationType'
      DataSource = dmPromotions.dsEditPromoPortionPriceMapping
      LookupTable = dmPromotions.qPromoCalcType
      LookupField = 'PromoCalcTypeId'
      Style = csDropDownList
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = dblCalculationTypeCloseUp
    end
    object dbeCalculationValue: TwwDBEdit
      Left = 96
      Top = 134
      Width = 121
      Height = 21
      DataField = 'CalculationValue'
      DataSource = dmPromotions.dsEditPromoPortionPriceMapping
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnKeyPress = dbeCalculationValueKeyPress
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 159
    Width = 235
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnCancel: TButton
      Left = 128
      Top = 5
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      Default = True
      ModalResult = 2
      TabOrder = 0
    end
    object btnAdd: TButton
      Left = 32
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object qPermissableBasePortions: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'PromotionID'
        DataType = ftLargeint
        Size = -1
        Value = Null
      end
      item
        Name = 'SaleGroupId'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '--select null as Id,  '#39'<not selected>'#39' as Name'
      '--union'
      'select Id, Name'
      'from ac_PortionType pt'
      'where pt.Id not in (select TargetPortionTypeId'
      '                    from PromotionPortionPriceMapping'
      '                    where PromotionID = :PromotionID'
      '                    and SaleGroupId = :SaleGroupId)'
      'order by pt.Name asc')
    Left = 128
    Top = 32
  end
  object qPermissableTargetPortions: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'TargetPortion'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'PromotionId'
        DataType = ftLargeint
        Size = -1
        Value = Null
      end
      item
        Name = 'SaleGroupId'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'SourcePortion'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '--select null as Id, '#39'<not selected>'#39' as Name'
      '--union'
      'declare @TargetPortion int'
      'set @TargetPortion = :TargetPortion'
      ''
      'select Id, Name'
      'from ac_PortionType pt'
      'where pt.Id not in ('
      '  (select TargetPortionTypeId'
      '  from #PromotionPortionPriceMapping'
      '  where PromotionID = :PromotionID'
      '  and SaleGroupId = :SaleGroupId)'
      '  union'
      '  (select :SourcePortion))'
      'or @TargetPortion = pt.Id'
      'order by pt.Name asc')
    Left = 128
    Top = 64
  end
  object qPermissableSalesGroups: TADOQuery
    Connection = dmPromotions.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select PromotionID, SaleGroupId'
      'from #PromotionSaleGroup psg'
      'where psg.CalculationType between 1 and 4'
      '')
    Left = 128
  end
end
