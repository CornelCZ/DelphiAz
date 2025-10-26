object fInsEmp: TfInsEmp
  Left = 387
  Top = 246
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Insert Employee'
  ClientHeight = 203
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 10
    Top = 10
    Width = 303
    Height = 135
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 17
    Width = 173
    Height = 16
    Caption = 'Schedule a new EMPLOYEE '
  end
  object lblEmployeeJob: TLabel
    Left = 16
    Top = 80
    Width = 185
    Height = 16
    Caption = 'Choose the job they will perform'
  end
  object btnOK: TBitBtn
    Left = 24
    Top = 160
    Width = 97
    Height = 33
    Caption = '&OK'
    TabOrder = 2
    OnClick = btnOKClick
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000688DA200BBCC
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DDE6EA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      03030303030303030303030303030303030303030303FF030303030303030303
      03030303030303040403030303030303030303030303030303F8F8FF03030303
      03030303030303030303040202040303030303030303030303030303F80303F8
      FF030303030303030303030303040202020204030303030303030303030303F8
      03030303F8FF0303030303030303030304020202020202040303030303030303
      0303F8030303030303F8FF030303030303030304020202FA0202020204030303
      0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
      040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
      03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
      FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
      0303030303030303030303FA0202020403030303030303030303030303F8FF03
      03F8FF03030303030303030303030303FA020202040303030303030303030303
      0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
      03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
      030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
      0202040303030303030303030303030303F8FF03F8FF03030303030303030303
      03030303FA0202030303030303030303030303030303F8FFF803030303030303
      030303030303030303FA0303030303030303030303030303030303F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 216
    Top = 160
    Width = 89
    Height = 33
    Caption = '&Cancel'
    TabOrder = 0
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Combo2: TwwDBLookupCombo
    Left = 16
    Top = 41
    Width = 161
    Height = 24
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'firstname'#9'10'#9'First Name'#9'F'
      'lastname'#9'10'#9'Last Name'#9'F')
    LookupTable = listQuery
    LookupField = 'Id'
    Options = [loColLines, loRowLines, loTitles]
    Style = csDropDownList
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    AllowClearKey = False
    OnCloseUp = Combo2CloseUp
    OnEnter = Combo2Enter
  end
  object cbEmployeeJobLookup: TwwDBLookupCombo
    Left = 16
    Top = 104
    Width = 161
    Height = 24
    DropDownAlignment = taLeftJustify
    LookupTable = qryEmployeeJobs
    LookupField = 'Name'
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object listQuery: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'roleId'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'siteid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'declare @roleid int'
      'set @roleid = :roleid'
      ''
      'select distinct u.LastName, u.FirstName, u.Id'
      'from ac_User u'
      'join ac_AllUserSites us'
      'on u.Id = us.UserId'
      '  join ac_UserRoles ur'
      '  on u.Id = ur.UserId'
      '    join ac_Role r'
      '    on r.Id = ur.RoleId'
      '      join ac_PayScheme ps'
      '      on ur.PaySchemeId = ps.Id'
      '        join ac_PaySchemeVersion v'
      '        on ps.CurrentPaySchemeVersionId = v.Id'
      'where r.RoleTypeId = 1 --FoH'
      'and r.ShowInTimeAndAttendance = 1'
      'and ((r.Id = @roleid) or (@roleid = -1))'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = :siteid'
      'order by LastName, FirstName')
    Left = 184
    Top = 40
  end
  object qryEmployeeJobs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'siteid'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'userid'
        DataType = ftLargeint
        Size = -1
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'select r.Id, r.Name'
      'from ac_User u'
      'join ac_AllUserSites us'
      'on u.Id = us.UserId'
      '  join ac_UserRoles ur'
      '  on u.Id = ur.UserId'
      '    join ac_Role r'
      '    on r.Id = ur.RoleId'
      '      join ac_PayScheme ps'
      '      on ur.PaySchemeId = ps.Id'
      '          join ac_PaySchemeVersion v'
      '          on ps.CurrentPaySchemeVersionId = v.Id'
      'where r.RoleTypeId = 1 --FoH'
      'and r.ShowInTimeAndAttendance = 1'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = :siteid'
      'and u.Id  = :userid'
      'order by r.Id')
    Left = 184
    Top = 104
  end
end
