object fsumdlg: Tfsumdlg
  Left = 451
  Top = 323
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Invoice Summary'
  ClientHeight = 425
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object SpeedButton1: TSpeedButton
    Left = 48
    Top = 369
    Width = 185
    Height = 48
    GroupIndex = 1
    Down = True
    Caption = 'Show By Category (F5)'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 233
    Top = 369
    Width = 185
    Height = 48
    GroupIndex = 1
    Caption = 'Show By Sub-Category (F6)'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 16
    Top = 226
    Width = 145
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Invoice Totals:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 8
    Width = 630
    Height = 209
    Selected.Strings = (
      'ctg'#9'20'#9'Category'
      'RecCount'#9'10'#9'Item Count'
      'UCount'#9'12'#9'Unit Count'
      'ICost'#9'12'#9'Total Cost'#9'F'
      'Tax'#9'10'#9'Sales Tax'
      'CTGCost'#9'17'#9'Category Cost')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
  end
  object wwDBGrid2: TwwDBGrid
    Left = 8
    Top = 8
    Width = 630
    Height = 209
    Selected.Strings = (
      'subctg'#9'20'#9'Sub-Category'#9#9
      'RecCount'#9'10'#9'Item Count'#9#9
      'UCount'#9'12'#9'Unit Count'#9#9
      'ICost'#9'12'#9'Total Cost'#9'F'#9
      'Tax'#9'10'#9'Sales Tax'#9#9
      'CTGCost'#9'17'#9'Sub-Category Cost'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    Visible = False
    OnCalcCellColors = wwDBGrid2CalcCellColors
  end
  object wwDBGrid3: TwwDBGrid
    Left = 168
    Top = 253
    Width = 329
    Height = 107
    Selected.Strings = (
      'div'#9'20'#9'Division Name'#9'F'
      'CTGCost'#9'20'#9'Division Total')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource3
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid3CalcCellColors
  end
  object wwDBGrid4: TwwDBGrid
    Left = 165
    Top = 222
    Width = 462
    Height = 24
    TabStop = False
    Selected.Strings = (
      'RecCount'#9'10'#9'RecCount'
      'UCount'#9'12'#9'UCount'
      'ICost'#9'12'#9'ICost'
      'Tax'#9'10'#9'Tax'
      'CTGCost'#9'17'#9'CTGCost')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = False
    ShowVertScrollBar = False
    DataSource = wwDataSource4
    KeyOptions = []
    Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid4CalcCellColors
  end
  object BitBtn1: TBitBtn
    Left = 488
    Top = 369
    Width = 153
    Height = 48
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 4
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
  object wwDataSource1: TwwDataSource
    DataSet = wwqByCtg
    Left = 136
    Top = 16
  end
  object wwDataSource2: TwwDataSource
    DataSet = wwqBySub
    Left = 136
    Top = 48
  end
  object wwDataSource3: TwwDataSource
    DataSet = wwqByDiv
    Left = 136
    Top = 112
  end
  object wwDataSource4: TwwDataSource
    DataSet = wwqTotal
    Left = 136
    Top = 80
  end
  object wwqByCtg: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select ctg, count(recno) as RecCount, sum(ucount) as UCount, '
      '  sum(icost) as ICost, sum(tax) as Tax, sum(ctgcost) as CTGCost'
      'from summary'
      'group by ctg')
    Left = 96
    Top = 16
    object wwqByCtgctg: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 20
      FieldName = 'ctg'
    end
    object wwqByCtgRecCount: TIntegerField
      DisplayLabel = 'Item Count'
      DisplayWidth = 10
      FieldName = 'RecCount'
      ReadOnly = True
    end
    object wwqByCtgUCount: TFloatField
      DisplayLabel = 'Unit Count'
      DisplayWidth = 12
      FieldName = 'UCount'
      ReadOnly = True
    end
    object wwqByCtgICost: TBCDField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 12
      FieldName = 'ICost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqByCtgTax: TBCDField
      DisplayLabel = 'Sales Tax'
      DisplayWidth = 10
      FieldName = 'Tax'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqByCtgCTGCost: TBCDField
      DisplayLabel = 'Category Cost'
      DisplayWidth = 17
      FieldName = 'CTGCost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
  end
  object wwqBySub: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select subctg, count(recno) as RecCount, sum(ucount) as UCount, '
      '  sum(icost) as ICost, sum(tax) as Tax, sum(ctgcost) as CTGCost'
      'from summary'
      'group by subctg')
    Left = 96
    Top = 48
    object wwqBySubsubctg: TStringField
      DisplayLabel = 'Sub-Category'
      DisplayWidth = 20
      FieldName = 'subctg'
    end
    object wwqBySubRecCount: TIntegerField
      DisplayLabel = 'Item Count'
      DisplayWidth = 10
      FieldName = 'RecCount'
      ReadOnly = True
    end
    object wwqBySubUCount: TFloatField
      DisplayLabel = 'Unit Count'
      DisplayWidth = 12
      FieldName = 'UCount'
      ReadOnly = True
    end
    object wwqBySubICost: TBCDField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 12
      FieldName = 'ICost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqBySubTax: TBCDField
      DisplayLabel = 'Sales Tax'
      DisplayWidth = 10
      FieldName = 'Tax'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqBySubCTGCost: TBCDField
      DisplayLabel = 'Sub-Category Cost'
      DisplayWidth = 17
      FieldName = 'CTGCost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
  end
  object wwtSummary: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'Summary'
    Left = 176
    Top = 16
  end
  object wwqGetsubs: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 176
    Top = 48
  end
  object wwqTotal: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select count(recno) as RecCount, sum(ucount) as UCount, '
      '  sum(icost) as ICost, sum(tax) as Tax, sum(ctgcost) as CTGCost'
      'from summary')
    Left = 96
    Top = 80
    object wwqTotalRecCount: TIntegerField
      DisplayWidth = 10
      FieldName = 'RecCount'
      ReadOnly = True
    end
    object wwqTotalUCount: TFloatField
      DisplayWidth = 12
      FieldName = 'UCount'
      ReadOnly = True
    end
    object wwqTotalICost: TBCDField
      DisplayWidth = 12
      FieldName = 'ICost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqTotalTax: TBCDField
      DisplayWidth = 10
      FieldName = 'Tax'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
    object wwqTotalCTGCost: TBCDField
      DisplayWidth = 17
      FieldName = 'CTGCost'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 19
    end
  end
  object wwqByDiv: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select div, sum(ctgcost) as CTGCost'
      'from summary'
      'group by div')
    Left = 96
    Top = 112
  end
end
