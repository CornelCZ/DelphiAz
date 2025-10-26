object dMod1: TdMod1
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Left = 479
  Top = 244
  Height = 479
  Width = 850
  object wwsGenerVar: TwwDataSource
    DataSet = wwtGenerVar
    Left = 92
    Top = 56
  end
  object wwtSysVar: TADOTable
    Connection = dmADO.AztecConn
    AfterOpen = wwtSysVarAfterOpen
    TableName = 'SysVar'
    Left = 24
    Top = 112
  end
  object SchdlTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = SchdlTableBeforePost
    OnNewRecord = SchdlTableNewRecord
    TableName = 'Schedule'
    Left = 24
    Top = 8
  end
  object wwtGenerVar: TADOTable
    Connection = dmADO.AztecConn
    Filter = 'VarName = '#39'UDFTabName'#39
    BeforePost = wwtGenerVarBeforePost
    TableName = 'GenerVar'
    Left = 92
    Top = 8
  end
  object wwtMasterVar: TADOTable
    Connection = dmADO.AztecConn
    AfterOpen = wwtMasterVarAfterOpen
    BeforePost = wwtMasterVarBeforePost
    TableName = 'MasterVar'
    Left = 24
    Top = 164
  end
  object wwtSiteVar: TADOTable
    Connection = dmADO.AztecConn
    AfterOpen = wwtSiteVarAfterOpen
    TableName = 'SiteVar'
    Left = 92
    Top = 164
  end
  object wwtPrizmSite: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'Site'
    Left = 420
    Top = 11
  end
  object adoqRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 24
    Top = 220
  end
  object adoqRun2: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 93
    Top = 223
  end
  object adotRun: TADOTable
    Connection = dmADO.AztecConn
    Left = 24
    Top = 280
  end
  object wwqROAtt: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from attcodes where "default" = '#39'Y'#39)
    Left = 284
    Top = 11
  end
  object dsROAtt: TwwDataSource
    DataSet = wwqROAtt
    Left = 284
    Top = 62
  end
  object wwtAttCd: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'Default = '#39'N'#39
    Filtered = True
    BeforeEdit = wwtAttCdBeforeEdit
    BeforePost = wwtAttCdBeforePost
    TableName = 'AttCodes'
    Left = 346
    Top = 11
  end
  object dsAtt: TwwDataSource
    DataSet = wwtAttCd
    Left = 345
    Top = 61
  end
  object ADOtWageCostUplift: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PConfigs'
    Left = 193
    Top = 9
  end
  object dsWageCostUplift: TwwDataSource
    DataSet = ADOtWageCostUplift
    Left = 193
    Top = 61
  end
  object adoqGetAllJobs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'siteid'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        '--Need to take into account the default job (if it is still pres' +
        'ent in the new system).'
      'select distinct r.Id as RoleId, r.Name as RoleName'
      'from ac_User u'
      'join ac_UserRoles ur'
      'on u.Id = ur.UserId'
      '  join ac_Role r'
      '  on r.Id = ur.RoleId'
      '    join ac_PayScheme ps'
      '    on ur.PaySchemeId = ps.Id'
      '      join ac_AllUserSites us'
      '      on u.Id = us.UserId'
      'where r.RoleTypeId = 1'
      'and r.ShowInTimeAndAttendance = 1'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = :siteid'
      'order by RoleName')
    Left = 501
    Top = 11
  end
  object adoqGetAllEmployeesAndJobs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @Siteid bigint'
      'set @SiteId = :SiteId'
      ''
      'select u.Id as UserId, r.Id as RoleId,'
      
        '  case when u.DefaultTerminalRoleId = ur.RoleId then 1 else 0 en' +
        'd as [default],'
      '  ps.CurrentPaySchemeVersionId as PaySchemeVersionId,'
      
        '  sub.CurrentUserPayRateOverrideVersionId as UserPayRateOverride' +
        'VersionId'
      'from ac_User u'
      'join ac_UserRoles ur'
      'on u.Id = ur.UserId'
      '  join ac_Role r'
      '  on r.Id = ur.RoleId'
      '    join ac_PayScheme ps'
      '    on ur.PaySchemeId = ps.Id'
      '      join ac_AllUserSites us'
      '      on u.Id = us.UserId'
      '        join ac_PaySchemeVersion v'
      '        on ps.CurrentPaySchemeVersionId = v.Id'
      '          left join (select * from ac_UserPayRateOverride o'
      '                     where o.Deleted = 0) sub'
      
        '          on u.Id = sub.UserId and sub.SiteId = @SiteId and sub.' +
        'PaySchemeId = ps.Id'
      'where r.RoleTypeId = 1'
      'and r.ShowInTimeAndAttendance = 1'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = @SiteId')
    Left = 502
    Top = 61
  end
  object wwtac_User: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'ac_User'
    Left = 503
    Top = 124
  end
  object wwtac_Role: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'ac_Role'
    Left = 503
    Top = 176
  end
  object qSiteStartOfWeek: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT CASE WHEN sps.StartOfWeek IS NULL THEN cps.StartOfWeek'
      
        '            ELSE sps.StartOfWeek END AS StartOfWeek, s.id AS Sit' +
        'eID'
      '                 FROM ac_CompanyPayrollSettings cps'
      
        '                      INNER JOIN ac_Area a ON a.CompanyId = cps.' +
        'CompanyID'
      '                      INNER JOIN ac_Site s ON s.AreaId = a.Id'
      
        '                      INNER JOIN ac_SitePayrollSettings sps ON s' +
        'ps.SiteId = s.Id'
      'WHERE sps.SiteId = :SiteCode  ')
    Left = 504
    Top = 240
  end
end
