object SiteVariations: TSiteVariations
  Left = 398
  Top = 217
  Width = 873
  Height = 570
  HelpContext = 5061
  Caption = 'Site Variations'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = ShowFormExecute
  DesignSize = (
    857
    531)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 11
    Top = 24
    Width = 62
    Height = 13
    AutoSize = False
  end
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 78
    Height = 13
    Caption = 'Variations as of:'
  end
  object Image1: TImage
    Left = 296
    Top = 0
    Width = 10
    Height = 11
    AutoSize = True
    Picture.Data = {
      07544269746D617096010000424D960100000000000036000000280000000A00
      00000B000000010018000000000060010000330B0000330B0000000000000000
      0000FFFFFFFFFFFFFFFFFF0F0F0F0F0F0F0F0F0F0F0F0FFFFFFFFFFFFFFFFFFF
      0000FFFFFFFFFFFF10101083919BC1D1D6B1C4C87582890F0F0FFFFFFFFFFFFF
      0000FFFFFF111111C6DAE6FEFEFEFEFEFEFEFEFEFEFEFE8FA1A90E0E0EFFFFFF
      000010101094A3AEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE72818B0E0E0E
      0000101010D4E8ECFEFEFEFEFEFED5D5D5C1C1AFF5E8C4FEFEFE98B0C00E0E0E
      0000101010C1D5DBFEFEFEE0E0CD3C3C3C4243417A7A78BFBEB8B0CADA0E0E0E
      0000101010A1B3BFFEFEFEDFDFCF575757D0D3CAFEFEFEFEFEFEA3C6E00E0E0E
      00000F0F0F7D8A96B9CCDAFEFEFE636363F2F2F2FEFEFEFEFEFE74828F0D0D0D
      0000FFFFFF0F0F0F90A7BCC9E9FEA1A4A5FEFEFEFEFEFE8CA1B40D0D0DFFFFFF
      0000FFFFFFFFFFFF0F0F0F707D88AEC0D192A9BD6E79820D0D0DFFFFFFFFFFFF
      0000FFFFFFFFFFFFFFFFFF0D0D0D0D0D0D0D0D0D0D0D0DFFFFFFFFFFFFFFFFFF
      0000}
    Visible = False
  end
  object lbVersionWarning: TLabel
    Left = 280
    Top = 11
    Width = 577
    Height = 29
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Sites with names in Grey are not at a version which currently se' +
      'nds variations to EPOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object dbgVariationGrid: TwwDBGrid
    Left = 8
    Top = 40
    Width = 849
    Height = 465
    Selected.Strings = (
      'SiteName'#9'20'#9'SiteName'
      'SiteRef'#9'10'#9'SiteRef'
      'AreaName'#9'20'#9'AreaName'
      'CrossTabColumn1'#9'10'#9'CrossTabColumn1'
      'CrossTabColumn2'#9'10'#9'CrossTabColumn2')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = dbgVariationGridRowChanged
    FixedCols = 3
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmThemeData.dsEditSiteVariations
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = dbgVariationGridCalcCellColors
    OnDrawDataCell = dbgVariationGridDrawDataCell
    OnMouseMove = dbgVariationGridMouseMove
  end
  object cbPickEffectiveDate: TComboBox
    Left = 88
    Top = 8
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Current'
    OnChange = cbPickEffectiveDateChange
    Items.Strings = (
      'Current'
      '25/10/2007'
      '12/12/2007'
      '01/01/2008'
      '<Create new>')
  end
  object btClose: TButton
    Left = 784
    Top = 512
    Width = 75
    Height = 25
    Action = CloseForm
    Anchors = [akRight, akBottom]
    TabOrder = 7
  end
  object Button1: TButton
    Left = 166
    Top = 512
    Width = 75
    Height = 25
    Action = SaveChanges
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object Button2: TButton
    Left = 246
    Top = 512
    Width = 75
    Height = 25
    Action = RevertChanges
    Anchors = [akLeft, akBottom]
    TabOrder = 6
  end
  object Button3: TButton
    Left = 86
    Top = 512
    Width = 75
    Height = 25
    Action = ImportVariations
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object Button4: TButton
    Left = 6
    Top = 512
    Width = 75
    Height = 25
    Action = ExportVariations
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object Button5: TButton
    Left = 192
    Top = 6
    Width = 81
    Height = 25
    Action = CancelFutureChange
    TabOrder = 1
  end
  object ActionList1: TActionList
    OnExecute = ActionList1Execute
    Left = 824
    Top = 48
    object ExportVariations: TAction
      Caption = 'Export'
      OnExecute = ExportVariationsExecute
    end
    object ImportVariations: TAction
      Caption = 'Import'
      OnExecute = ImportVariationsExecute
    end
    object RevertChanges: TAction
      Caption = 'Revert'
      OnExecute = RevertChangesExecute
      OnUpdate = SaveRevertDataUpdate
    end
    object SaveChanges: TAction
      Caption = 'Save'
      OnExecute = SaveChangesExecute
      OnUpdate = SaveRevertDataUpdate
    end
    object CloseForm: TAction
      Caption = 'Close'
      OnExecute = CloseFormExecute
    end
    object ShowForm: TAction
      Caption = 'ShowForm'
      OnExecute = ShowFormExecute
    end
    object CancelFutureChange: TAction
      Caption = 'Cancel change'
      OnExecute = CancelFutureChangeExecute
      OnUpdate = CancelFutureChangeUpdate
    end
  end
  object adoqLiveSiteVariationsRowStats: TADOQuery
    Connection = dmThemeData.AztecConn
    Parameters = <>
    SQL.Strings = (
      'SELECT max_record_size_in_bytes as MaxBytes,'
      '       avg_record_size_in_bytes as AvgBytes'
      'FROM sys.dm_db_index_physical_stats'
      
        '    (DB_ID('#39'tempdb'#39'), OBJECT_ID('#39'tempdb..#EditSiteVariations'#39'), ' +
        'NULL, NULL , '#39'DETAILED'#39')'
      'WHERE alloc_unit_type_desc = '#39'IN_ROW_DATA'#39)
    Left = 824
    Top = 80
  end
end
