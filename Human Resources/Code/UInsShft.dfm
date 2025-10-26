object FInsShft: TFInsShft
  Left = 526
  Top = 373
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Insert Shift'
  ClientHeight = 285
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 6
    Top = 39
    Width = 125
    Height = 19
    Caption = 'Employee Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 102
    Width = 96
    Height = 19
    Caption = 'Worked Job'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 18
    Top = 172
    Width = 85
    Height = 19
    Caption = 'Shift Start '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 136
    Top = 172
    Width = 72
    Height = 19
    Caption = 'Shift End'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 7
    Top = 12
    Width = 41
    Height = 16
    Alignment = taCenter
    Caption = 'Label5'
  end
  object OKBtn: TButton
    Left = 14
    Top = 238
    Width = 92
    Height = 30
    Caption = 'OK'
    TabOrder = 4
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 126
    Top = 238
    Width = 92
    Height = 30
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object Combo1: TwwDBLookupCombo
    Left = 6
    Top = 60
    Width = 208
    Height = 24
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'FirstName'#9'20'#9'FirstName'#9#9
      'LastName'#9'20'#9'LastName'#9#9)
    LookupTable = ADOQuery1
    LookupField = 'Id'
    Options = [loColLines, loRowLines, loTitles]
    Style = csDropDownList
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    SeqSearchOptions = [ssoEnabled, ssoCaseSensitive]
    AllowClearKey = False
    OnCloseUp = Combo1CloseUp
    OnExit = Combo1Exit
  end
  object Combo2: TwwDBComboBox
    Left = 6
    Top = 123
    Width = 208
    Height = 24
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
  end
  object MaskEdit1: TMaskEdit
    Left = 40
    Top = 196
    Width = 41
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
  end
  object MaskEdit2: TMaskEdit
    Left = 151
    Top = 196
    Width = 42
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'siteid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      'select distinct u.Id, u.LastName, u.FirstName'
      'from ac_User u'
      'join ac_AllUserSites us'
      'on u.Id = us.UserId'
      '  join ac_UserRoles ur'
      '  on u.Id = ur.UserId'
      '    join ac_Role r'
      '    on r.Id = ur.RoleId'
      'where r.RoleTypeId = 1 --FoH'
      'and r.ShowInTimeAndAttendance = 1'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = :siteid'
      'order by LastName, FirstName')
    Left = 144
    Top = 8
  end
  object ListQry: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'siteid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end
      item
        Name = 'userid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 10
        Size = 4
        Value = '5'
      end>
    SQL.Strings = (
      'select r.Id, r.Name'
      'from ac_User u'
      'join ac_AllUserSites us'
      'on u.Id = us.UserId'
      '  join ac_UserRoles ur'
      '  on u.Id = ur.UserId'
      '    join ac_Role r'
      '    on r.Id = ur.RoleId'
      'where r.RoleTypeId = 1 --FoH'
      'and r.ShowInTimeAndAttendance = 1'
      'and r.Deleted = 0'
      'and u.Terminated = 0'
      'and us.SiteId = :SiteId'
      'and u.Id  = :UserId'
      'order by r.Id'
      '')
    Left = 104
    Top = 144
  end
end
