object VrfyDlg: TVrfyDlg
  Left = 515
  Top = 243
  BorderStyle = bsSingle
  ClientHeight = 525
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 457
    Width = 790
    Height = 68
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlRateChg: TPanel
      Left = 0
      Top = 0
      Width = 385
      Height = 68
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 4
      DesignSize = (
        385
        68)
      object Label3: TLabel
        Left = 5
        Top = 8
        Width = 58
        Height = 16
        Anchors = [akRight, akBottom]
        Caption = 'Pay Type:'
      end
      object lblPayType: TLabel
        Left = 65
        Top = 8
        Width = 243
        Height = 16
        Anchors = [akRight, akBottom]
        Caption = 'Shift not worked, no pay rate/type info'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bbtRateChg: TBitBtn
        Left = 4
        Top = 32
        Width = 149
        Height = 30
        Anchors = [akRight, akBottom]
        Caption = 'View/Modify Pay Rate'
        TabOrder = 0
        OnClick = bbtRateChgClick
      end
    end
    object BitBtn1: TBitBtn
      Left = 706
      Top = 15
      Width = 82
      Height = 39
      Caption = '&Close'
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 390
      Top = 36
      Width = 116
      Height = 30
      Caption = 'Confirm &All'
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA00000000
        00008AAAAAAAAAAA08FFF99FFFF08AAAAAAAAAAA08FF9998FFF08AAAAAAAAAAA
        08F99999FFF08AAAAAAAAAAA089998998FF08AAAAAAAAAAA08998F999FF08AAA
        AAAAAAAA08FFF8888888888888AAAAAA08FFF0000000000008AA888808FFF08F
        FF99FFFF08AA000008FFF08FF9998FFF08AA08FF0888808F99999FFF08AA08FF
        00000089998998FF08AA08F99999F08998F999FF08AA08999899808FFFF899FF
        08AA08998F99908FFFFF998F08AA08FFFF89908FFFFF999F08AA08FFFFF9908F
        FFFF899908AA08FFFFF990888888889998AA08FFFFF890000000000999AA0888
        888889998AAAAAAA99AA0000000000999AAAAAAAAAAAAAAAAAAAAAA99AAAAAAA
        AAAA}
    end
    object btnDelete: TBitBtn
      Left = 512
      Top = 36
      Width = 97
      Height = 30
      Caption = '&Delete'
      TabOrder = 2
      OnClick = btnDeleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      NumGlyphs = 2
    end
    object btnInsert: TBitBtn
      Left = 615
      Top = 36
      Width = 87
      Height = 30
      Caption = '&Insert'
      TabOrder = 3
      OnClick = btnInsertClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btnLSPay: TBitBtn
      Left = 390
      Top = 3
      Width = 158
      Height = 30
      Caption = 'Add/Edit Extra Payment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnLSPayClick
      NumGlyphs = 2
    end
    object BitBtn6: TBitBtn
      Left = 556
      Top = 3
      Width = 146
      Height = 30
      Caption = 'View Unconfirmed Only'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = BitBtn6Click
      NumGlyphs = 2
    end
    object pnlFilterView: TPanel
      Left = 0
      Top = 0
      Width = 790
      Height = 68
      Alignment = taLeftJustify
      TabOrder = 6
      Visible = False
      object Label4: TLabel
        Left = 4
        Top = 3
        Width = 417
        Height = 63
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'These records have not been confirmed because they are not compl' +
          'eted. '#13#10'You can confirm them as they are (accept the shifts as N' +
          'OT WORKED), you can delete them, or you can type Accepted Times ' +
          #13#10'and/or choose a valid job before confirming.'
        Color = clInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInactiveCaptionText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Label1: TLabel
        Left = 521
        Top = 2
        Width = 176
        Height = 64
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'You are currently viewing only the unconfirmed records! To retur' +
          'n to normal view click "Done".'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object BitBtn5: TBitBtn
        Left = 700
        Top = 13
        Width = 85
        Height = 41
        Caption = 'Done'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn5Click
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object BitBtn7: TBitBtn
        Left = 428
        Top = 19
        Width = 87
        Height = 30
        Caption = '&Delete'
        TabOrder = 1
        OnClick = btnDeleteClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
          305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
          B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
          B0557777FF577777F7F500000E055550805577777F7555575755500000555555
          05555777775555557F5555000555555505555577755555557555}
        NumGlyphs = 2
      end
    end
  end
  object VerifyPC: TPageControl
    Left = 0
    Top = 0
    Width = 790
    Height = 26
    ActivePage = TabSheet1
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrack = True
    ParentFont = False
    TabIndex = 0
    TabOrder = 1
    OnChange = VerifyPCChange
    OnChanging = VerifyPCChanging
    OnMouseUp = VerifyPCMouseUp
    object TabSheet1: TTabSheet
      Caption = 'Monday 22/12/00'
    end
    object TabSheet2: TTabSheet
      Caption = 'Tuesday'
    end
    object TabSheet3: TTabSheet
      Caption = 'Wednesday'
    end
    object TabSheet4: TTabSheet
      Caption = 'Thursday'
    end
    object TabSheet5: TTabSheet
      Caption = 'Friday'
    end
    object TabSheet6: TTabSheet
      Caption = 'Saturday'
    end
    object TabSheet7: TTabSheet
      Caption = 'Sunday'
    end
  end
  object DBGrid2: TwwDBGrid
    Left = 0
    Top = 26
    Width = 790
    Height = 409
    ControlType.Strings = (
      'wjobdesc;CustomEdit;Combo1;F'
      'Confirmed;CheckBox;Y;N')
    PictureMasks.Strings = (
      'AccIn'#9'##:##'#9'T'#9'T'
      'AccOut'#9'##:##'#9'T'#9'T'
      'Break'#9'##:##'#9'T'#9'T')
    Selected.Strings = (
      'Fname'#9'11'#9'First Name'#9#9
      'Name'#9'12'#9'Last Name'#9#9
      'jobdesc'#9'13'#9'Scheduled Job'#9#9
      'wjobdesc'#9'13'#9'Worked Job'#9#9
      'Schin'#9'5'#9'Schd.~In'#9#9
      'Schout'#9'5'#9'Schd.~Out'#9#9
      'Clockin'#9'5'#9'Clock~In'#9#9
      'Clockout'#9'5'#9'Clock~Out'#9#9
      'AccIn'#9'5'#9'Acc.~In'#9#9
      'AccOut'#9'5'#9'Acc.~Out'#9#9
      'Break'#9'5'#9'Break'#9#9
      'Dechrs'#9'5'#9'Decml~Hrs.'#9#9
      'Worked'#9'5'#9'Wrkd.~Hrs'#9#9
      'Confirmed'#9'2'#9'Cnf.'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 3
    ShowHorzScrollBar = False
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Align = alClient
    DataSource = DisplayDS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = True
    LineColors.DataColor = clBlack
    OnCalcCellColors = DBGrid2CalcCellColors
    OnTitleButtonClick = DBGrid2TitleButtonClick
    OnColEnter = DBGrid2ColEnter
    OnColExit = DBGrid2ColExit
    OnDblClick = DBGrid2DblClick
    OnKeyDown = DBGrid2KeyDown
    OnMouseUp = DBGrid2MouseUp
    object DBGrid2IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 13
      Height = 22
      AllowAllUp = True
    end
  end
  object Combo1: TwwDBLookupCombo
    Left = 632
    Top = 1
    Width = 97
    Height = 24
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Name'#9'20'#9'Name'#9#9)
    DataField = 'wjobdesc'
    DataSource = DisplayDS
    LookupTable = adoqJobs
    LookupField = 'Id'
    Style = csDropDownList
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    SeqSearchOptions = [ssoEnabled, ssoCaseSensitive]
    AllowClearKey = False
    OnCloseUp = Combo1CloseUp
    OnEnter = Combo1Enter
  end
  object pnStatusMessage: TPanel
    Left = 0
    Top = 435
    Width = 790
    Height = 22
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Note: '
    TabOrder = 4
    Visible = False
  end
  object DisplayDS: TwwDataSource
    DataSet = VrfySchd
    Left = 158
    Top = 67
  end
  object CopyQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end
      item
        Name = 'thedate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'declare @SiteId int'
      'set @SiteId = :SiteId'
      ''
      
        'select  s.sitecode, s.UserId, s.schin, s.schout, s.clockin, s.cl' +
        'ockout,'
      
        '        s.accin, s.accout, s.fworked, s.worked, s.[break], s.Rol' +
        'eId,'
      '        s.WRoleId, s.shift, s.confirmed, u.lastname, s.errcode,'
      
        '        s.WorkedPaySchemeVersionId, v.PaySchemeId, s.WorkedUserP' +
        'ayRateOverrideVersionId,'
      
        '        s.PaySchemeVersionLMDT,  u.firstname,  s.bsdate, ps.PayF' +
        'requencyId'
      'from Schedule s'
      'join ac_User u'
      'on s.UserId = u.Id'
      '  left join ac_PaySchemeVersion v'
      '  on v.Id = s.WorkedPaySchemeVersionId'
      '    left join ac_PayScheme ps'
      '    on ps.Id = v.PaySchemeId'
      'where s.bsDate = :thedate'
      '     and s.sitecode = @SiteId'
      '     and s.visible = '#39'Y'#39
      '     and u.Id in (select distinct u.Id'
      '                  from ac_User u'
      '                     join ac_UserRoles ur on u.Id = ur.UserId'
      '                     join ac_Role r on ur.RoleId = r.Id'
      '                  where r.ShowInTimeAndAttendance = 1)')
    Left = 124
    Top = 36
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'drop TABLE [dbo].[#vrfyschd] ')
    Left = 191
    Top = 36
  end
  object VrfySchd: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = VrfySchdAfterOpen
    BeforeClose = VrfySchdBeforeClose
    BeforeEdit = VrfySchdBeforeEdit
    BeforePost = VrfySchdBeforePost
    AfterPost = VrfySchdAfterPost
    AfterDelete = VrfySchdAfterDelete
    BeforeScroll = VrfySchdBeforeScroll
    AfterScroll = VrfySchdAfterScroll
    OnCalcFields = VrfySchdCalcFields
    IndexFieldNames = 'Name;FName'
    TableDirect = True
    TableName = '#vrfyschd'
    Left = 158
    Top = 36
    object VrfySchdFname: TStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 11
      FieldName = 'Fname'
      Size = 10
    end
    object VrfySchdName: TStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 12
      FieldName = 'Name'
      Size = 10
    end
    object VrfySchdjobdesc: TStringField
      DisplayLabel = 'Scheduled Job'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'jobdesc'
      LookupDataSet = dMod1.wwtac_Role
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'RoleId'
      Lookup = True
    end
    object VrfySchdwjobdesc: TStringField
      DisplayLabel = 'Worked Job'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'wjobdesc'
      LookupDataSet = dMod1.wwtac_Role
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'WRoleId'
      Lookup = True
    end
    object VrfySchdSchin: TStringField
      DisplayLabel = 'Schd.~In'
      DisplayWidth = 5
      FieldName = 'Schin'
      Required = True
      Size = 5
    end
    object VrfySchdSchout: TStringField
      DisplayLabel = 'Schd.~Out'
      DisplayWidth = 5
      FieldName = 'Schout'
      Size = 5
    end
    object VrfySchdClockin: TStringField
      DisplayLabel = 'Clock~In'
      DisplayWidth = 5
      FieldName = 'Clockin'
      Size = 5
    end
    object VrfySchdClockout: TStringField
      DisplayLabel = 'Clock~Out'
      DisplayWidth = 5
      FieldName = 'Clockout'
      Size = 5
    end
    object VrfySchdAccIn: TStringField
      DisplayLabel = 'Acc.~In'
      DisplayWidth = 5
      FieldName = 'AccIn'
      Size = 5
    end
    object VrfySchdAccOut: TStringField
      DisplayLabel = 'Acc.~Out'
      DisplayWidth = 5
      FieldName = 'AccOut'
      Size = 5
    end
    object VrfySchdBreak: TStringField
      DisplayWidth = 5
      FieldName = 'Break'
      Size = 5
    end
    object VrfySchdDechrs: TStringField
      DisplayLabel = 'Decml~Hrs.'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'Dechrs'
      Size = 5
      Calculated = True
    end
    object VrfySchdWorked: TStringField
      DisplayLabel = 'Wrkd.~Hrs'
      DisplayWidth = 5
      FieldName = 'Worked'
      Size = 5
    end
    object VrfySchdConfirmed: TStringField
      DisplayLabel = 'Cnf.'
      DisplayWidth = 2
      FieldName = 'Confirmed'
      OnChange = VrfySchdConfirmedChange
      Size = 1
    end
    object VrfySchdcworked: TStringField
      DisplayWidth = 6
      FieldKind = fkCalculated
      FieldName = 'cworked'
      ReadOnly = True
      Visible = False
      Size = 5
      Calculated = True
    end
    object VrfySchdShift: TSmallintField
      FieldName = 'Shift'
      Required = True
      Visible = False
    end
    object VrfySchdFWorked: TFloatField
      DisplayWidth = 10
      FieldName = 'FWorked'
      Visible = False
    end
    object VrfySchdVisible: TStringField
      DisplayWidth = 1
      FieldName = 'Visible'
      Visible = False
      Size = 1
    end
    object VrfySchdRateMod: TStringField
      FieldName = 'RateMod'
      Visible = False
      Size = 1
    end
    object VrfySchdRateMod2: TStringField
      FieldName = 'RateMod2'
      Visible = False
      Size = 1
    end
    object VrfySchdAdded: TSmallintField
      FieldName = 'Added'
      Visible = False
    end
    object VrfySchdKSchIn: TDateTimeField
      FieldName = 'KSchIn'
      Visible = False
    end
    object VrfySchdBsDate: TDateField
      FieldName = 'BsDate'
      Visible = False
    end
    object VrfySchdUserId: TLargeintField
      FieldName = 'UserId'
      Visible = False
    end
    object VrfySchdRoleId: TIntegerField
      FieldName = 'RoleId'
      Visible = False
    end
    object VrfySchdWRoleId: TIntegerField
      FieldName = 'WRoleId'
      Visible = False
    end
    object VrfySchdWorkedPayFrequencyId: TIntegerField
      FieldName = 'WorkedPayFrequencyId'
      Visible = False
    end
    object VrfySchdWorkedPaySchemeVersionId: TIntegerField
      FieldName = 'WorkedPaySchemeVersionId'
      Visible = False
    end
    object VrfySchdWorkedUserPayRateOverrideVersionId: TIntegerField
      FieldName = 'WorkedUserPayRateOverrideVersionId'
      Visible = False
    end
    object VrfySchdWorkedPaySchemeId: TIntegerField
      FieldName = 'WorkedPaySchemeId'
      Visible = False
    end
  end
  object ADOCommand1: TADOCommand
    CommandText = 
      'CREATE TABLE [dbo].[#vrfyschd] ('#13#10#9'[Name] [nvarchar] (20) collat' +
      'e database_default NOT NULL ,'#13#10#9'[SEC] [float] NOT NULL ,'#13#10#9'[KSch' +
      'In] [datetime] NOT NULL ,'#13#10#9'[Shift] [smallint] NULL ,'#13#10#9'[Schin] ' +
      '[nvarchar] (5) collate database_default NULL ,'#13#10#9'[Schout] [nvarc' +
      'har] (5) collate database_default NULL ,'#13#10#9'[Clockin] [nvarchar] ' +
      '(5) collate database_default NULL ,'#13#10#9'[Clockout] [nvarchar] (5) ' +
      'collate database_default NULL ,'#13#10#9'[AccIn] [nvarchar] (5) collate' +
      ' database_default NULL ,'#13#10#9'[AccOut] [nvarchar] (5) collate datab' +
      'ase_default NULL ,'#13#10#9'[Fname] [nvarchar] (20) collate database_de' +
      'fault NULL ,'#13#10#9'[FWorked] [float] NULL ,'#13#10#9'[Worked] [nvarchar] (5' +
      ') collate database_default NULL ,'#13#10#9'[Break] [nvarchar] (5) colla' +
      'te database_default NULL ,'#13#10#9'[JobId] [smallint] NULL ,'#13#10#9'[WJobid' +
      '] [smallint] NULL ,'#13#10#9'[PayType] [smallint] NULL ,'#13#10#9'[NRate] [flo' +
      'at] NULL ,'#13#10#9'[ORate] [float] NULL ,'#13#10#9'[RateMod] [nvarchar] (1) c' +
      'ollate database_default NULL ,'#13#10#9'[RateMod2] [nvarchar] (1) colla' +
      'te database_default NULL ,'#13#10#9'[Confirmed] [nvarchar] (1) collate ' +
      'database_default NULL ,'#13#10#9'[Visible] [nvarchar] (1) collate datab' +
      'ase_default NULL ,'#13#10#9'[Added] [smallint] NULL ,'#13#10#9'[BsDate] [datet' +
      'ime] NULL'#13#10') ON [PRIMARY]'
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 88
    Top = 36
  end
  object adoqJobs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = DisplayDS
    Parameters = <
      item
        Name = 'UserId'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = '5'
      end>
    SQL.Strings = (
      
        'select r.Id, r.Name, ps.PayFrequencyId, ps.CurrentPaySchemeVersi' +
        'onId, sub.CurrentUserPayRateOverrideVersionId'
      'from ac_UserRoles ur'
      'join ac_Role r'
      'on r.Id = ur.RoleId'
      '  join ac_PayScheme ps'
      '  on ur.PaySchemeId = ps.Id'
      '    left join (select * from ac_UserPayRateOverride o'
      '               where o.Deleted = 0) sub'
      
        '    on sub.PaySchemeId = ps.Id and sub.UserId = ur.UserId and su' +
        'b.SiteId = 1'
      'where ur.UserId = :UserId')
    Left = 191
    Top = 67
  end
end
