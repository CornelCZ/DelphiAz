object fRateOverrides: TfRateOverrides
  Left = 726
  Top = 185
  Width = 335
  Height = 220
  Caption = 'Pay Rate'
  Color = clBtnFace
  Constraints.MaxHeight = 225
  Constraints.MaxWidth = 335
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 155
    Width = 327
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      327
      38)
    object ButtonPostChanges: TButton
      Left = 141
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Save Changes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonPostChangesClick
    end
    object ButtonCancel: TButton
      Left = 247
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 327
    Height = 155
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      327
      155)
    object wwDBGrid1: TwwDBGrid
      Left = 6
      Top = 8
      Width = 314
      Height = 139
      PictureMasks.Strings = (
        'PayRate'#9'*#[.[#[#]]]'#9'F'#9'T'
        'OverriddenPayRate'#9'*#[.[#[#]]]'#9'T'#9'T')
      Selected.Strings = (
        'BandName'#9'25'#9'Pay Scheme Band'
        'OverriddenPayRate'#9'20'#9'Pay Rate')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsRateOverrides
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
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
  object adotRateOverrides: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableDirect = True
    TableName = '#RateOverrides'
    Left = 12
    Top = 80
    object adotRateOverridesBandName: TStringField
      DisplayLabel = 'Pay Scheme Band'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'BandName'
      LookupDataSet = adotPaySchemeBandTypes
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'BandType'
      Lookup = True
    end
    object adotRateOverridesOverriddenPayRate: TBCDField
      DisplayLabel = 'Pay Rate'
      DisplayWidth = 20
      FieldName = 'OverriddenPayRate'
      Precision = 19
    end
    object adotRateOverridesBasePayRate: TBCDField
      DisplayWidth = 20
      FieldName = 'BasePayRate'
      Visible = False
      Precision = 19
    end
    object adotRateOverridesOldOverriddenPayRate: TBCDField
      DisplayWidth = 20
      FieldName = 'OldOverriddenPayRate'
      Visible = False
      Precision = 19
    end
    object adotRateOverridesBandType: TIntegerField
      DisplayWidth = 10
      FieldName = 'BandType'
      Visible = False
    end
  end
  object adoqSave: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end
      item
        Name = 'UserId'
        Size = -1
        Value = Null
      end
      item
        Name = 'Schin'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'declare @NextId int, @SiteId int, @UserId bigint, @Schin datetim' +
        'e'
      'set @SiteId = :SiteId'
      'set @UserId = :UserId'
      'set @Schin = :Schin'
      ''
      '--Changes were made....'
      
        'if exists(select * from #RateOverrides where OldOverriddenPayRat' +
        'e <> OverriddenPayrate)'
      'begin'
      '  --Remove previous overrides'
      '  delete from ac_ShiftPayRateOverrideBand'
      '  where SiteId = @SiteId and UserId = @UserId and Schin = @Schin'
      ''
      
        '  --Save new overrides if different from base or if they have ch' +
        'anged'
      
        '  insert ac_ShiftPayRateOverrideBand (Siteid, UserId, Schin, Pay' +
        'SchemeBandTypeId, PayRate)'
      '  select @SiteId, @UserId, @Schin, BandType, OverriddenPayRate'
      '  from #RateOverrides'
      '  where exists(select * from #RateOverrides'
      '               where (OldOverriddenPayRate <> OverriddenPayRate)'
      '               and (OverriddenPayRate <> BasePayRate))'
      ''
      '  select cast(1 as bit) as ChangesMade'
      'end'
      'else'
      '  select cast(0 as bit) as ChangesMade')
    Left = 266
    Top = 111
  end
  object dsRateOverrides: TDataSource
    DataSet = adotRateOverrides
    Left = 44
    Top = 80
  end
  object adotPaySchemeBandTypes: TADOTable
    Active = True
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'ac_PaySchemeBandType'
    Left = 12
    Top = 112
  end
  object adoqPopulate: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'PaySchemeVersion'
        Size = -1
        Value = Null
      end
      item
        Name = 'UserPayRateOverride'
        Size = -1
        Value = Null
      end
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end
      item
        Name = 'UserId'
        Size = -1
        Value = Null
      end
      item
        Name = 'Schin'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'declare @PaySchemeVersion int, @UserPayRateOverride int, @SiteId' +
        ' int, @UserId bigint, @Schin datetime'
      'set @PaySchemeVersion = :PaySchemeVersion'
      'set @UserPayRateOverride = :UserPayRateOverride'
      'set @SiteId = :SiteId'
      'set @UserId = :UserId'
      'set @Schin = :Schin'
      ''
      
        '--Populate first with the base values. User overrides trump vani' +
        'lla pay rates'
      'if @UserPayRateOverride <> 0'
      'begin'
      
        '  insert #RateOverrides(BandType, BasePayrate, OverriddenPayRate' +
        ', OldOverriddenPayrate)'
      '  select PaySchemeBandTypeId, PayRate, PayRate, PayRate'
      '  from ac_UserPayRateOverrideBand'
      '  where UserPayRateOverrideVersionId = @UserPayRateOverride'
      '  and SiteId = @SiteId'
      'end'
      'else if @PaySchemeVersion <> 0'
      'begin'
      
        '  insert #RateOverrides(BandType, BasePayrate, OverriddenPayRate' +
        ', OldOverriddenPayrate)'
      '  select PaySchemeBandTypeId, PayRate, PayRate, PayRate'
      '  from ac_PaySchemeBand'
      '  where PaySchemeVersionId = @PaySchemeVersion'
      'end'
      ''
      '--Update with any existing shift override'
      
        'if Exists(Select * from ac_ShiftPayRateOverrideBand where SiteId' +
        ' = @SiteId and UserId = @UserId and Schin = @Schin)'
      'begin'
      '  update #RateOverrides'
      
        '  set OverriddenPayRate = s.PayRate, OldOverriddenPayRate = s.Pa' +
        'yRate'
      '  from #RateOverrides o'
      '  join ac_ShiftPayRateOverrideBand s'
      
        '  on o.BandType = s.PaySchemeBandTypeId and s.SiteId = @SiteId a' +
        'nd s.UserId = @UserId and s.Schin = @Schin'
      'end'
      '')
    Left = 234
    Top = 111
  end
end
