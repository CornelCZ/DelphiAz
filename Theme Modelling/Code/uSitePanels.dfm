object SitePanels: TSitePanels
  Left = 332
  Top = 164
  BorderStyle = bsSingle
  Caption = 'Site Panels'
  ClientHeight = 407
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 224
    Height = 13
    Caption = 'The following panels may be customised at site:'
  end
  object btCancel: TButton
    Left = 488
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 0
    OnClick = btCancelClick
  end
  object btCustomise: TButton
    Left = 8
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Customise'
    TabOrder = 1
    OnClick = btCustomiseClick
  end
  object dbgSitePanels: TwwDBGrid
    Left = 8
    Top = 24
    Width = 553
    Height = 345
    Selected.Strings = (
      'Name'#9'20'#9'Name'
      'Description'#9'66'#9'Description')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsSitePanels
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = dbgSitePanelsDblClick
  end
  object qGetSitePanels: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select ('
      '  select top 1 sitecode from themesites'
      ') as sitecode, subpanelid, [Name], [Description] '
      'from themepanelsubpanel '
      'where parentpanelid in (select panelid  from #panelset)')
    Left = 40
    Top = 136
    object qGetSitePanelsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 50
    end
    object qGetSitePanelsDescription: TStringField
      DisplayWidth = 66
      FieldName = 'Description'
      Size = 255
    end
    object qGetSitePanelssitecode: TSmallintField
      FieldName = 'sitecode'
      ReadOnly = True
      Visible = False
    end
    object qGetSitePanelssubpanelid: TLargeintField
      FieldName = 'subpanelid'
      Visible = False
    end
  end
  object dsSitePanels: TDataSource
    DataSet = qGetSitePanels
    Left = 96
    Top = 136
  end
  object qSetup: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'if object_id('#39'tempdb..#panelset'#39') is not null'
      '  drop table #panelset'
      ''
      'declare @sitecode int'
      'create table #panelset (panelid bigint primary key(panelid))'
      'declare @act_panels int'
      ''
      'select top 1 @sitecode = sitecode from ThemeSites'
      ''
      'insert #panelset'
      'select distinct panelid from ThemePanel'
      'where paneldesignid in'
      '       (select distinct paneldesignid'
      '        from ThemeEposDesign'
      
        '        where POSCode IN (select POSCode from ThemeEposDevice wh' +
        'ere SiteCode = @sitecode))'
      'and PanelType = 3'
      ''
      'exec Theme_RecursePanelSet @SiteCode, 1'
      '')
    Left = 64
    Top = 176
  end
end
