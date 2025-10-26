object fConfTh: TfConfTh
  Left = 393
  Top = 153
  HelpContext = 1003
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Threads Configuration'
  ClientHeight = 738
  ClientWidth = 807
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 4
    Top = 411
    Width = 309
    Height = 13
    Caption = 'Description for Selected Thread (max. 256 characters)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 397
    Top = 2
    Width = 164
    Height = 13
    Caption = 'Settings for Selected Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblMasTh: TLabel
    Left = 4
    Top = 371
    Width = 387
    Height = 36
    AutoSize = False
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Bevel1: TBevel
    Tag = 99
    Left = 397
    Top = 250
    Width = 404
    Height = 30
    Shape = bsFrame
  end
  object Label11: TLabel
    Tag = 99
    Left = 410
    Top = 244
    Width = 193
    Height = 13
    Caption = ' Signature Line on the Summary Reports '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel4: TBevel
    Tag = 99
    Left = 397
    Top = 84
    Width = 303
    Height = 63
    Shape = bsFrame
  end
  object Bevel5: TBevel
    Tag = 99
    Left = 397
    Top = 24
    Width = 404
    Height = 51
    Shape = bsFrame
  end
  object Label15: TLabel
    Tag = 99
    Left = 397
    Top = 589
    Width = 178
    Height = 13
    AutoSize = False
    Caption = 'End Date only allowed this weekday:'
  end
  object Label14: TLabel
    Tag = 99
    Left = 659
    Top = 578
    Width = 144
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = ' End Date automatically set'#13#10' to most recent Wednesday'
    Color = clTeal
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Bevel6: TBevel
    Left = 400
    Top = 408
    Width = 401
    Height = 29
    Shape = bsFrame
  end
  object cbUseMustCountItems: TwwCheckBox
    Left = 434
    Top = 127
    Width = 247
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Use '#39'Must Count Items'#39' Template (where set)'
    DataField = 'UseMustCountItems'
    DataSource = wwDataSource1
    TabOrder = 41
  end
  object cbAutoFillBlankItems: TwwCheckBox
    Left = 418
    Top = 111
    Width = 271
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Automatically fill blank counts with Theo Closing'
    DataField = 'AutoFillBlindStockBlankCounts'
    DataSource = wwDataSource1
    TabOrder = 39
    OnClick = cbAutoFillBlankItemsClick
  end
  object wwcbMobileStocks: TwwCheckBox
    Left = 397
    Top = 441
    Width = 404
    Height = 11
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Show Expected Items Only in Mobile Stocks'
    DataField = 'ShowExpectedItemsOnlyInMobileStocks'
    DataSource = wwDataSource1
    TabOrder = 40
    OnExit = wwcbMobileStocksExit
  end
  object wwCbConfirmMobileLocationImportCounts: TwwCheckBox
    Tag = 99
    Left = 424
    Top = 417
    Width = 249
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Confirm mobile stock count imports for locations'
    DataField = 'ConfirmMobileStockImport'
    DataSource = wwDataSource1
    TabOrder = 38
    OnExit = wwDBGrid1Exit
  end
  object btnCountSheetFields: TBitBtn
    Tag = 99
    Left = 706
    Top = 92
    Width = 94
    Height = 42
    Caption = 'Set Count'#10'Sheet Fields'
    TabOrder = 33
    OnClick = btnCountSheetFieldsClick
    Layout = blGlyphBottom
  end
  object wwdbcEndDateDoW: TwwDBComboBox
    Tag = 99
    Left = 572
    Top = 586
    Width = 87
    Height = 21
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DataField = 'EndOnDoW'
    DataSource = wwDataSource1
    DropDownCount = 8
    ItemHeight = 0
    Items.Strings = (
      '- Any Day -'#9'0'
      'Monday'#9'1'
      'Tuesday'#9'2'
      'Wednesday'#9'3'
      'Thursday'#9'4'
      'Friday'#9'5'
      'Saturday'#9'6'
      'Sunday'#9'7')
    Sorted = False
    TabOrder = 37
    UnboundDataType = wwDefault
    OnChange = wwdbcEndDateDoWChange
  end
  object cbHideFillAudit: TwwCheckBox
    Tag = 99
    Left = 418
    Top = 94
    Width = 269
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = 'N'
    DisplayValueUnchecked = 'Y'
    NullAndBlankState = cbUnchecked
    Caption = 'Hide button "Fill blank Counts with Theo Closing"'
    DataField = 'HideFillAudit'
    DataSource = wwDataSource1
    TabOrder = 34
    OnExit = wwDBGrid1Exit
  end
  object wwcbNPfromOldRO: TwwCheckBox
    Tag = 99
    Left = 418
    Top = 55
    Width = 345
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Disallow change of Nominal Prices manually set on prior Inventor' +
      'ies'
    DataField = 'NomPriceOldRO'
    DataSource = wwDataSource1
    TabOrder = 36
    OnExit = wwDBGrid1Exit
  end
  object wwcbNPfromTariffRO: TwwCheckBox
    Tag = 99
    Left = 418
    Top = 38
    Width = 353
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Disallow change of Nominal Prices derived from the Tariff Price'
    DataField = 'NomPriceTariffRO'
    DataSource = wwDataSource1
    TabOrder = 35
    OnExit = wwDBGrid1Exit
  end
  object rgMAST: TwwRadioGroup
    Tag = 99
    Left = 410
    Top = 479
    Width = 391
    Height = 35
    ItemIndex = 0
    Caption = ' When in the Trading Day are Mobile Counts done : '
    Columns = 2
    DataField = 'DayStartMAC'
    DataSource = wwDataSource1
    Items.Strings = (
      'after or around End of Day'
      'before or around Start of Day')
    TabOrder = 32
    Values.Strings = (
      'False'
      'True')
    OnExit = wwDBGrid1Exit
  end
  object wwcbMAST: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 458
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Do un-attended Mobile Auto Count Stock Take (MAC stocks)'
    DataField = 'MobileAutoCount'
    DataSource = wwDataSource1
    TabOrder = 31
    OnClick = wwcbMASTClick
    OnExit = wwDBGrid1Exit
  end
  object cbLCBase: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 553
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = '1'
    ValueUnchecked = '0'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Inventories of this Thread can be used as Base for Line && Spot ' +
      'Checks'
    Checked = True
    DataField = 'LCBase'
    DataSource = wwDataSource1
    State = cbChecked
    TabOrder = 29
    OnExit = wwDBGrid1Exit
  end
  object rgInstTR: TwwRadioGroup
    Tag = 99
    Left = 397
    Top = 518
    Width = 404
    Height = 35
    Caption = ' What Recipes to use for Theo Reduction in Stock calculation: '
    Columns = 2
    DataField = 'InstTR'
    DataSource = wwDataSource1
    Items.Strings = (
      'As they ARE at Calculation time'
      'As they WERE at Sale time')
    TabOrder = 27
    Values.Strings = (
      'False'
      'True')
    OnClick = rgInstTRClick
    OnExit = wwDBGrid1Exit
  end
  object cbAskTR: TwwCheckBox
    Tag = 99
    Left = 601
    Top = 530
    Width = 177
    Height = 17
    AlwaysTransparent = False
    ValueChecked = '1'
    ValueUnchecked = '0'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Set when starting new Inventory'
    DataField = 'AskTR'
    DataSource = wwDataSource1
    TabOrder = 28
    OnExit = wwDBGrid1Exit
  end
  object btnMasTh: TBitBtn
    Left = 6
    Top = 544
    Width = 175
    Height = 47
    Caption = 'Make This a'#10'Master Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
    OnClick = btnMasThClick
    Glyph.Data = {
      C6010000424DC6010000000000007600000028000000180000001C0000000100
      04000000000050010000230B0000230B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AA0990990AAA
      AAAA0BB0AAAAAA0999090AAAAAAAA0B0AAAAAA099990AAAAAAAA0B0AAAAAAAA0
      99990AAAAAAA0BB0AAAAAA0909990AAAAAAAA0B0AAAAAA0990990AAAAAAA0B0A
      AAAAAA0999090AAAAAAA0BB0AAAAAA099990AAAAAAAAA0B0AAAAAAA099990AAA
      AAAA0B0AAAAAAA0909990AAAAAAA0BB0AAAAAA0990990AAAAAA0B0B0AAAAAA09
      99000000AAA0BB0AAAAAAA0000B0BB0B0A0B0BB0AAAAA00BB0BB0B0B000BB0B0
      AAAA00B0BB0000000BB0BB0AAAAA0B00009900B0B0BB00AAAAAA0BB099090BB0
      BB00AAAAAAAAA0099990A0000BB000AAAAAAAAA099990AA0B0B00B0AAAAAAA09
      09990AA0BB00BBB0AAAAAA0990990AA00B0A000AAAAAAA0999090AAA00AA0BB0
      AAAAAA099990AAAAAAAAA0B0AAAAAAA099990AAAAAAA0B0AAAAAAA0909990AAA
      AAAA0BB0AAAAAA0990990AAAAAAAA0B0AAAAAA0999090AAAAAAA0B0AAAAAAA09
      9990AAAAAAAA0BB0AAAA}
    Spacing = -1
  end
  object wwcbWasteAdj: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 362
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Allow Wastage Adjustment when Auditing'
    DataField = 'WasteAdj'
    DataSource = wwDataSource1
    TabOrder = 21
    OnExit = wwDBGrid1Exit
  end
  object wwcbUseHZ: TwwCheckBox
    Tag = 99
    Left = 407
    Top = 401
    Width = 378
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Use Holding Zones OR Count Locations (based on what is set at ea' +
      'ch Site)'
    Checked = True
    DataField = 'ByHZ'
    DataSource = wwDataSource1
    State = cbChecked
    TabOrder = 20
    OnClick = wwcbUseHZClick
    OnExit = wwDBGrid1Exit
  end
  object wwcbNoPurAcc: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 381
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = 'N'
    DisplayValueUnchecked = 'Y'
    NullAndBlankState = cbChecked
    Caption = 
      'When accepting an Inventory lock all Purchases used by the Inven' +
      'tory'
    Checked = True
    DataField = 'NOPurAcc'
    DataSource = wwDataSource1
    State = cbChecked
    TabOrder = 19
    OnExit = wwDBGrid1Exit
  end
  object wwcbTakingsIncludeVar: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 205
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Default Takings include POS Variance (uncheck to ignore POS Vari' +
      'ance)'
    DataField = 'TillVarTak'
    DataSource = wwDataSource1
    TabOrder = 18
    OnExit = wwDBGrid1Exit
  end
  object wwcbGallon: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 167
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Use special "Gallons/Pints" format to show Gallons (1 Gallon = 8' +
      ' Pints)'
    DataField = 'GallForm'
    DataSource = wwDataSource1
    TabOrder = 17
    OnExit = wwDBGrid1Exit
  end
  object BitBtn6: TBitBtn
    Tag = 99
    Left = 266
    Top = 489
    Width = 122
    Height = 47
    Caption = 'Thread'#10'Security'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = BitBtn6Click
    Glyph.Data = {
      36020000424D360200000000000076000000280000001C0000001C0000000100
      040000000000C0010000130B0000130B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAA000AAAAA0
      990AA0BB0AAA0E0AAAAAA0088800AA09090AA0BBB0A0E0AAAAAA077707770A09
      90AAAA0BB0A0EE0AAAAA088808880A09990AA0B0B0A0EE0AAAAA077000770AA0
      990AA0BB0AAA0E0AAAAA088000880A09090AA0BBB0A0E0AAAAAA077777770A09
      90AAAA0BB0A0EE0AAAAA000000000A09990AA0B0B0A0EE0AAAAAA07AAA70AAA0
      990AA0BB0AAA0E0AAAAAA07A0A70AA09090AA0BBB0A0E0AAAAAAAA00000AAA09
      90AAAA0BB0A0EE0AAAAAAAA808AAAA099900A0B0B0A0EE0AAAAAAAAAA0A00AA0
      099000BB0A0EEE0AAAAAAAAAAA0880AAA09990BBB0EEE0AAAAAAAAAAA080A80A
      AA09900BBA0E0AAAAAAAAAAAA08AAA80A0909AB0B0E0AAAAAAAAAAAAAA08A080
      A030000BBAE0000AAAAAAAAAAAA0880003088880BE088880AAAAAAAAAAAA00AA
      0000AA000000AA00AAAAAAAAAAAAAAAA03088880BE088880AAAAAAAAAAAAAAAA
      0330000BBAE0000AAAAAAAAAAAAAAAA00099A8BBB0AEE0AAAAAAAAAAAAAAAA09
      9090AA0BB0A0EE0AAAAAAAAAAAAAAA099900A0B0B0A0EE0AAAAAAAAAAAAAAAA0
      9900A0BB0AAA0E0AAAAAAAAAAAAAAA09090AA0BBB0A0E0AAAAAAAAAAAAAAAA09
      90AAAA0BB0A0EE0AAAAAAAAAAAAAAA09990AA0B0B0A0EE0AAAAA}
    Spacing = -1
  end
  object rgCPS: TwwRadioGroup
    Tag = 99
    Left = 405
    Top = 300
    Width = 396
    Height = 35
    Caption = ' Set Cumulative Periods 1st Inventories: '
    Columns = 2
    DataField = 'CPSmode'
    DataSource = wwDataSource1
    Items.Strings = (
      'At Creation time (no user reset)'
      'On Reports screen (free set/reset)')
    TabOrder = 12
    Values.Strings = (
      'N'
      'R')
    OnExit = wwDBGrid1Exit
  end
  object wwCbCPS: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 283
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 'Show Cumulative Period Summary box on the Summary Reports'
    DataField = 'DoCPS'
    DataSource = wwDataSource1
    TabOrder = 11
    OnClick = wwCbCPSClick
    OnExit = wwDBGrid1Exit
  end
  object wwcbEditTakings: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 186
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 'Auditor is allowed to edit the Takings'
    Checked = True
    DataField = 'EditTak'
    DataSource = wwDataSource1
    State = cbChecked
    TabOrder = 9
    OnExit = wwDBGrid1Exit
  end
  object wwcbDozForm: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 148
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Use special "Dozens/Units" format to show Dozens (1 Dozen = 12 U' +
      'nits)'
    DataField = 'DozForm'
    DataSource = wwDataSource1
    TabOrder = 8
    OnExit = wwDBGrid1Exit
  end
  object BitBtn5: TBitBtn
    Left = 269
    Top = 544
    Width = 119
    Height = 47
    Caption = 'Done'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 5
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
  object wwDBGrid1: TwwDBGrid
    Left = 6
    Top = 4
    Width = 383
    Height = 362
    ControlType.Strings = (
      'Active;CheckBox;Y;N')
    PictureMasks.Strings = (
      'TName'#9'{?*@,#*@}'#9'F'#9'T')
    Selected.Strings = (
      'Division'#9'20'#9'Division'#9#9
      'TName'#9'30'#9'Name'#9'F'#9
      'Active'#9'1'#9'Active'#9'T'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 1
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
    OnExit = wwDBGrid1Exit
  end
  object BitBtn1: TBitBtn
    Left = 6
    Top = 489
    Width = 122
    Height = 47
    Caption = 'Create'#10'Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      36020000424D360200000000000076000000280000001F0000001C0000000100
      040000000000C0010000130B0000130B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
      AAAA000AAAAAAAAAAAA0AAAAAAAAAAAA808A070A808AAAAA0000AAAAAAAAAAAA
      07000700070AAAA0BBB0AAAAAAAAAAAA80077777008AAA0BB000AAAAAAAAAAAA
      A077000770AAA0BB0AA0AAAAAAAAAAA000F077707000A0B0AAA0AAAAAAAAAAA0
      77F0F0707770A0B0AAA0AAAAAAAAAAA000F07F707000A0B0AAA0AAAAAAAAAAAA
      A07F000770AAA0B0AAA0AAAAAAAAAAAA8007FF7700800BB0AAA0AAAAAAAAAAAA
      07000700070BBB0AAAA0000A000A000A808A070A80BB00A7AAA0BBB0BBB0BBB0
      00A000000BB0A70007A0BB0BBB0BBB0BBB0BBB0B0B0AA07770A0B0BBB0BBB0BB
      B0BBB0B0BB0A70F070700A000A000A000A000A0A0BB0A07F70A0AAAAAAAAAA80
      8A070A8080BB070007A0AAAAAAAAAA07000700070A0B0AA7AAA0AAAAAAAAAA80
      077777008A0BB0AAAAA0AAAAAAAAAAA077000770AAA0B0AAAAA0AAAAAAAAA000
      F077707000A0B0AAAAA0AAAAAAAAA077F0F0707770A0B0AAAAA0AAAAAAAAA000
      F07F707000A0BB0AAAA0AAAAAAAAAAA07F000770AAAA0BB00000AAAAAAAAAA80
      07FF77008AAAA0BBBBB0AAAAAAAAAA07000700070AAAAA000000AAAAAAAAAA80
      8A0A0A808AAAAAAAAAA0AAAAAAAAAAAAAA000AAAAAAAAAAAAAA0}
    Spacing = -1
  end
  object BitBtn2: TBitBtn
    Left = 137
    Top = 489
    Width = 121
    Height = 47
    Caption = 'Deactivate'#10'Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
    Glyph.Data = {
      C6010000424DC6010000000000007600000028000000180000001C0000000100
      04000000000050010000130B0000130B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA09990AAA
      AAAAAAAAAAAAAAAAA0990AAAAAAAAAAAAAAAAAAA09090AAAAAAAAAAAAAAAAAAA
      0990AAAAAAAAAAAAAAAAAAAA09990AAAAAAAAAAAAAAAAAAAA0990AAAAAAAAAAA
      AAAAAAAA09090AAAAAAAAAAAAAAA0007A990AAAAAAAAAA444AAAFFF000777AAA
      AAAAA44444AAAA7FEF00007AAAAA44AAA44AAAAA09EFE000AAA444AAA44AAAAA
      0990AFE00074444444AAAAAA09990AAFE0007AAAAAAAAAAAA0990FE000744444
      4AAAAAAA09090000AAA44AAA44AAAAAA09907AAAAAA44AAA44AAAA7F09990AAA
      AAAA44444AAA7FF0A0990AAAAAAAA444AAAAF00709090AAAAAAAAAAAAAAAAAAA
      0990AAAAAAAAAAAAAAAAAAAA09990AAAAAAAAAAAAAAAAAAAA0990AAAAAAAAAAA
      AAAAAAAA09090AAAAAAAAAAAAAAAAAAA0990AAAAAAAAAAAAAAAAAAAA09990AAA
      AAAAAAAAAAAAAAAAA0990AAAAAAAAAAAAAAAAAAA09090AAAAAAAAAAAAAAAAAAA
      0990AAAAAAAAAAAAAAAA}
    Spacing = -1
  end
  object wwDBEdit1: TwwDBEdit
    Left = 4
    Top = 424
    Width = 384
    Height = 57
    AutoSize = False
    DataField = 'TNote'
    DataSource = wwDataSource1
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = True
  end
  object wwcbSetNomPrices: TwwCheckBox
    Tag = 99
    Left = 407
    Top = 18
    Width = 364
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Allow Setting of Nominal Price where Nominal Price (from Sales) ' +
      'is NULL'
    DataField = 'NomPrice'
    DataSource = wwDataSource1
    TabOrder = 6
    OnClick = wwcbSetNomPricesClick
    OnExit = wwDBGrid1Exit
  end
  object wwcbBlindStock: TwwCheckBox
    Tag = 99
    Left = 407
    Top = 77
    Width = 257
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'N'
    ValueUnchecked = 'Y'
    DisplayValueChecked = 'N'
    DisplayValueUnchecked = 'Y'
    NullAndBlankState = cbUnchecked
    Caption = 'Blind Inventory (Theo figures not shown on Audit)'
    DataField = 'FillClose'
    DataSource = wwDataSource1
    TabOrder = 7
    OnClick = wwcbBlindStockClick
    OnExit = wwDBGrid1Exit
  end
  object wwcbGPreporting: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 225
    Width = 400
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 
      'Use Gross Profit Reporting (uncheck to use Cost of Sales Reporti' +
      'ng)'
    DataField = 'isGP'
    DataSource = wwDataSource1
    TabOrder = 10
    OnExit = wwDBGrid1Exit
  end
  object cbDBAutoRep: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 338
    Width = 184
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'Y'
    ValueUnchecked = 'N'
    DisplayValueChecked = 'Y'
    DisplayValueUnchecked = 'N'
    NullAndBlankState = cbUnchecked
    Caption = 'Auto-Print Reports on Acceptance'
    DataField = 'AutoRep'
    DataSource = wwDataSource1
    TabOrder = 14
    OnClick = cbDBAutoRepClick
    OnExit = wwDBGrid1Exit
  end
  object btnAutoRep: TButton
    Tag = 99
    Left = 587
    Top = 334
    Width = 213
    Height = 27
    Caption = 'Set Reports to Auto-Print (3 of 233)'
    TabOrder = 15
    OnClick = btnAutoRepClick
  end
  object cbAudSig: TwwCheckBox
    Tag = 99
    Left = 593
    Top = 260
    Width = 161
    Height = 17
    AlwaysTransparent = False
    ValueChecked = '1'
    ValueUnchecked = '0'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Show Auditor Signature'
    DataField = 'AudSig'
    DataSource = wwDataSource1
    TabOrder = 24
    OnExit = wwDBGrid1Exit
  end
  object cbManagerSig: TwwCheckBox
    Tag = 99
    Left = 401
    Top = 260
    Width = 149
    Height = 17
    AlwaysTransparent = False
    ValueChecked = '1'
    ValueUnchecked = '0'
    DisplayValueChecked = '1'
    DisplayValueUnchecked = '0'
    NullAndBlankState = cbUnchecked
    Caption = 'Show Manager Signature'
    DataField = 'MngSig'
    DataSource = wwDataSource1
    TabOrder = 25
    OnExit = wwDBGrid1Exit
  end
  object wwcbDisplayImpExRef: TwwCheckBox
    Tag = 99
    Left = 397
    Top = 570
    Width = 262
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Show the '#39'Import/Export Reference'#39' when Auditing'
    DataField = 'ShowImpExRef'
    DataSource = wwDataSource1
    TabOrder = 30
    OnExit = wwcbDisplayImpExRefExit
  end
  object pnlCountSheet: TPanel
    Left = -132
    Top = 620
    Width = 785
    Height = 435
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 26
    Visible = False
    object Label10: TLabel
      Left = 148
      Top = 0
      Width = 489
      Height = 48
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Choose what optional fields should appear on the Audit Count She' +
        'et.'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShowAccelChar = False
      Layout = tlCenter
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 243
      Top = 308
      Width = 298
      Height = 65
      Shape = bsFrame
      Style = bsRaised
    end
    object Label12: TLabel
      Left = 256
      Top = 291
      Width = 241
      Height = 13
      Caption = ' Choose the line spacing for the Audit Count Sheet '
    end
    object BitBtn11: TBitBtn
      Left = 249
      Top = 387
      Width = 145
      Height = 39
      Caption = 'Save Settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn11Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn12: TBitBtn
      Left = 404
      Top = 387
      Width = 131
      Height = 39
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn12Click
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
    object PanelOptionalFields: TPanel
      Left = 243
      Top = 54
      Width = 298
      Height = 232
      BevelInner = bvLowered
      TabOrder = 2
      object Bevel3: TBevel
        Left = 4
        Top = 85
        Width = 290
        Height = 59
        Shape = bsFrame
        Style = bsRaised
      end
      object Label13: TLabel
        Left = 13
        Top = 80
        Width = 147
        Height = 13
        Caption = ' Not availalble on Blind Stocks '
      end
      object LabelOptionalFieldsWarning: TLabel
        Left = 4
        Top = 171
        Width = 290
        Height = 57
        AutoSize = False
        Caption = 
          ' Count Sheets have a maximum 3 spaces for optional fields.'#13#10#13#10' '#39 +
          'Import/Export Reference'#39' uses 2 spaces.'#13#10' All other optional fie' +
          'lds use 1 space.'
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object cbOp: TCheckBox
        Left = 38
        Top = 5
        Width = 167
        Height = 17
        Caption = 'Opening Qty'
        TabOrder = 0
        OnClick = OptionalFieldComboBoxClick
      end
      object cbPurS: TCheckBox
        Left = 38
        Top = 29
        Width = 167
        Height = 17
        Caption = 'Purchased Qty'
        TabOrder = 1
        OnClick = OptionalFieldComboBoxClick
      end
      object cbPurC: TCheckBox
        Left = 38
        Top = 53
        Width = 167
        Height = 17
        Caption = 'Purchase Cost Average '
        TabOrder = 2
        OnClick = OptionalFieldComboBoxClick
      end
      object cbNomP: TCheckBox
        Left = 38
        Top = 97
        Width = 167
        Height = 17
        Caption = 'Theoretical Nominal Price'
        TabOrder = 3
        OnClick = OptionalFieldComboBoxClick
      end
      object cbTheoClose: TCheckBox
        Left = 38
        Top = 121
        Width = 167
        Height = 17
        Caption = 'Theoretical Closing Qty'
        TabOrder = 4
        OnClick = OptionalFieldComboBoxClick
      end
      object cbShowImpExpRef: TCheckBox
        Left = 38
        Top = 150
        Width = 167
        Height = 17
        Caption = 'Import/Export Reference'
        TabOrder = 5
        OnClick = OptionalFieldComboBoxClick
      end
    end
    object rbSingle: TRadioButton
      Left = 281
      Top = 318
      Width = 113
      Height = 17
      Caption = 'Normal Height'
      TabOrder = 3
    end
    object rb1_5: TRadioButton
      Left = 281
      Top = 342
      Width = 113
      Height = 17
      Caption = '1.5 Normal Height '
      TabOrder = 4
    end
  end
  object pnlAutoRep: TPanel
    Left = -168
    Top = 652
    Width = 785
    Height = 393
    TabOrder = 16
    Visible = False
    object Label6: TLabel
      Left = 185
      Top = 1
      Width = 415
      Height = 72
      AutoSize = False
      Caption = 
        'Choose what reports should be sent directly to the Printer when ' +
        'Accepting.'#13#10'Be aware that some reports have more than one form (' +
        'e.g. Loss/Gain is at Cost OR Value OR Cost & Value).'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShowAccelChar = False
      Layout = tlCenter
      WordWrap = True
    end
    object Panel2: TPanel
      Left = 185
      Top = 338
      Width = 415
      Height = 53
      TabOrder = 0
      object BitBtn7: TBitBtn
        Left = 117
        Top = 8
        Width = 145
        Height = 39
        Caption = 'Save Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn7Click
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object BitBtn8: TBitBtn
        Left = 272
        Top = 8
        Width = 131
        Height = 39
        Caption = 'Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn8Click
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
    end
    object wwDBGrid2: TwwDBGrid
      Left = 185
      Top = 73
      Width = 415
      Height = 264
      ControlType.Strings = (
        'SetAR;CheckBox;Y;N')
      Selected.Strings = (
        'AR'#9'10'#9'Rep. No'
        'Text'#9'40'#9'Report Name'
        'SetAR'#9'1'#9'Auto Print')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 2
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      DataSource = dsAutoRep
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnExit = wwDBGrid2Exit
    end
  end
  object pnlMakeMaster: TPanel
    Left = 12
    Top = 672
    Width = 785
    Height = 385
    TabOrder = 23
    object Label5: TLabel
      Left = 96
      Top = 63
      Width = 617
      Height = 90
      AutoSize = False
      Caption = 
        'Choose a Thread from the ones present to act as the Subordinate ' +
        'Thread.'#13#10' '#13#10'"Edit Takings" will be locked to "Allowed"  for the ' +
        'Master Thread and to "Not Allowed" for the Subordinate.'#13#10'The Sub' +
        'ordinate Thread will use the "Default Takings include POS Varian' +
        'ce" from the Master Thread.'#13#10'Both Master and Subordinate will ha' +
        've "Use Holding Zones..." locked to the current setting and'#13#10'the' +
        'y cannot be De-Activated while the Master-Subordinate link exist' +
        's.'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 120
      Top = 163
      Width = 241
      Height = 13
      Caption = 'Candidate Subordinate Threads (pick one)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 48
      Top = 8
      Width = 689
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = 'Make Thread "QWERTYUIOPasdfghjklpoiuytrewqw" a Master Thread'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object gridMakeMaster: TwwDBGrid
      Left = 96
      Top = 177
      Width = 617
      Height = 119
      Selected.Strings = (
        'tname'#9'28'#9'Thread'#9#9
        'atSites'#9'7'#9'Sites~using it'#9#9
        'minSD'#9'20'#9'Start Date of Earliest~Accepted Stock '#9#9
        'maxED'#9'20'#9'End Date of Latest~Accepted Stock'#9#9
        'avgPer'#9'16'#9'(Days) Average~Stock Period'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsMakeMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      UseTFields = False
    end
    object BitBtn9: TBitBtn
      Left = 120
      Top = 304
      Width = 361
      Height = 57
      Caption = 'BitBtn9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn9Click
      Glyph.Data = {
        C6010000424DC6010000000000007600000028000000180000001C0000000100
        04000000000050010000230B0000230B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AA0990990AAA
        AAAA0BB0AAAAAA0999090AAAAAAAA0B0AAAAAA099990AAAAAAAA0B0AAAAAAAA0
        99990AAAAAAA0BB0AAAAAA0909990AAAAAAAA0B0AAAAAA0990990AAAAAAA0B0A
        AAAAAA0999090AAAAAAA0BB0AAAAAA099990AAAAAAAAA0B0AAAAAAA099990AAA
        AAAA0B0AAAAAAA0909990AAAAAAA0BB0AAAAAA0990990AAAAAA0B0B0AAAAAA09
        99000000AAA0BB0AAAAAAA0000B0BB0B0A0B0BB0AAAAA00BB0BB0B0B000BB0B0
        AAAA00B0BB0000000BB0BB0AAAAA0B00009900B0B0BB00AAAAAA0BB099090BB0
        BB00AAAAAAAAA0099990A0000BB000AAAAAAAAA099990AA0B0B00B0AAAAAAA09
        09990AA0BB00BBB0AAAAAA0990990AA00B0A000AAAAAAA0999090AAA00AA0BB0
        AAAAAA099990AAAAAAAAA0B0AAAAAAA099990AAAAAAA0B0AAAAAAA0909990AAA
        AAAA0BB0AAAAAA0990990AAAAAAAA0B0AAAAAA0999090AAAAAAA0B0AAAAAAA09
        9990AAAAAAAA0BB0AAAA}
    end
    object BitBtn10: TBitBtn
      Left = 536
      Top = 304
      Width = 161
      Height = 57
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn10Click
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
  end
  object Panel1: TPanel
    Left = -236
    Top = 736
    Width = 785
    Height = 393
    TabOrder = 4
    Visible = False
    object Label1: TLabel
      Left = 202
      Top = 9
      Width = 380
      Height = 69
      AutoSize = False
      Caption = 
        ' Type a Stock Thread Name (max. 30 characters).'#13#10' This name will' +
        ' be used to identify the Thread.'#13#10' Thread Names have to be uniqu' +
        'e for each Division.'#13#10' Thread Names can be changed later.'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 206
      Top = 125
      Width = 238
      Height = 57
      AutoSize = False
      Caption = 
        ' Assign this Thread to a Division.'#13#10' Threads cannot be re-assign' +
        'ed '#13#10' to another Division later!'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 206
      Top = 227
      Width = 372
      Height = 18
      AutoSize = False
      Caption = ' Type a Thread Description (max. 256 characters)'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object edName: TEdit
      Left = 220
      Top = 83
      Width = 225
      Height = 21
      MaxLength = 30
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 219
      Top = 328
      Width = 177
      Height = 41
      Caption = 'Save New Thread'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn3Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn4: TBitBtn
      Left = 411
      Top = 328
      Width = 145
      Height = 41
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn4Click
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
    object lookDiv: TwwDBLookupCombo
      Left = 220
      Top = 186
      Width = 217
      Height = 21
      DropDownAlignment = taLeftJustify
      LookupTable = adoqDiv
      LookupField = 'Division Name'
      Style = csDropDownList
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
    object edNote: TMemo
      Left = 207
      Top = 249
      Width = 371
      Height = 59
      Lines.Strings = (
        
          'sgbnsrgnbsfrgnsfgnsrftnhhsrfthsfrthnsrftnbsrfdxfbsfgbnsfgnsfdgns' +
          'fgnsfgndsfng'
        
          'dfngsgbnsrgnbsfrgnsfgnsrftnhhsrfthsfrthnsrftnbsrfdxfbsfgbnsfgnsf' +
          'dgnsfgnsfgn'
        
          'dsfngdfngsgbnsrgnbsfrgnsfgnsrftnhhsrfthsfrthnsrftNBSRFDXFBSFGBNS' +
          'FGnS'
        'FDGNSFGNSFGNDSFNGDFNGMWMWMWMWmwmwmwmw')
      MaxLength = 256
      TabOrder = 4
    end
  end
  object adoqTh: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterOpen = adoqThAfterPost
    AfterEdit = adoqThAfterEdit
    BeforePost = adoqThBeforePost
    AfterPost = adoqThAfterPost
    AfterScroll = adoqThAfterPost
    Parameters = <>
    SQL.Strings = (
      'select * from Threads'
      'order by Division, TName')
    Left = 282
    Top = 1
    object adoqThDivision: TStringField
      DisplayWidth = 20
      FieldName = 'Division'
    end
    object adoqThTName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'TName'
      OnValidate = adoqThTNameValidate
      Size = 30
    end
    object adoqThActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Size = 1
    end
    object adoqThTid: TSmallintField
      FieldName = 'Tid'
      Visible = False
    end
    object adoqThType: TStringField
      FieldName = 'Type'
      Visible = False
      Size = 1
    end
    object adoqThNomPrice: TStringField
      FieldName = 'NomPrice'
      Visible = False
      Size = 1
    end
    object adoqThFillClose: TStringField
      FieldName = 'FillClose'
      Visible = False
      Size = 1
    end
    object adoqThMadeBy: TStringField
      FieldName = 'MadeBy'
      Visible = False
      Size = 10
    end
    object adoqThMadeDT: TDateTimeField
      FieldName = 'MadeDT'
      Visible = False
    end
    object adoqThTNote: TStringField
      FieldName = 'TNote'
      Visible = False
      Size = 256
    end
    object adoqThLMDT: TDateTimeField
      FieldName = 'LMDT'
      Visible = False
    end
    object adoqThlmby: TStringField
      FieldName = 'lmby'
      Visible = False
    end
    object adoqThDozForm: TStringField
      FieldName = 'DozForm'
      Visible = False
      Size = 1
    end
    object adoqThEditTak: TStringField
      FieldName = 'EditTak'
      Visible = False
      Size = 1
    end
    object adoqThisGP: TStringField
      FieldName = 'isGP'
      Visible = False
      Size = 1
    end
    object adoqThDoCPS: TStringField
      FieldName = 'DoCPS'
      Visible = False
      Size = 1
    end
    object adoqThCPSmode: TStringField
      FieldName = 'CPSmode'
      Visible = False
      Size = 1
    end
    object adoqThAutoRep: TStringField
      FieldName = 'AutoRep'
      Visible = False
      Size = 1
    end
    object adoqThGallForm: TStringField
      FieldName = 'GallForm'
      Visible = False
      Size = 1
    end
    object adoqThTillVarTak: TStringField
      FieldName = 'TillVarTak'
      Visible = False
      Size = 1
    end
    object adoqThNOPurAcc: TStringField
      FieldName = 'NOPurAcc'
      Visible = False
      Size = 1
    end
    object adoqThByHZ: TBooleanField
      FieldName = 'ByHZ'
      Visible = False
    end
    object adoqThWasteAdj: TBooleanField
      FieldName = 'WasteAdj'
      Visible = False
    end
    object adoqThSlaveTh: TIntegerField
      FieldName = 'SlaveTh'
      Visible = False
    end
    object adoqThMngSig: TBooleanField
      FieldName = 'MngSig'
      Visible = False
    end
    object adoqThAudSig: TBooleanField
      FieldName = 'AudSig'
      Visible = False
    end
    object adoqThACSfields: TStringField
      FieldName = 'ACSfields'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object adoqThACSheight: TFloatField
      FieldName = 'ACSheight'
      Visible = False
    end
    object adoqThInstTR: TBooleanField
      FieldName = 'InstTR'
      Visible = False
    end
    object adoqThAskTR: TBooleanField
      FieldName = 'AskTR'
      Visible = False
    end
    object adoqThLCBase: TBooleanField
      FieldName = 'LCBase'
      Visible = False
    end
    object adoqThShowImpExRef: TBooleanField
      FieldName = 'ShowImpExRef'
      Visible = False
    end
    object adoqThMobileAutoCount: TBooleanField
      FieldName = 'MobileAutoCount'
      Visible = False
    end
    object adoqThDayStartMAC: TBooleanField
      FieldName = 'DayStartMAC'
      Visible = False
    end
    object adoqThEndOnDoW: TSmallintField
      DisplayWidth = 10
      FieldName = 'EndOnDoW'
      Visible = False
    end
    object adoqThHideFillAudit: TBooleanField
      DisplayWidth = 5
      FieldName = 'HideFillAudit'
      Visible = False
    end
    object adoqThNomPriceTariffRO: TBooleanField
      DisplayWidth = 5
      FieldName = 'NomPriceTariffRO'
      Visible = False
    end
    object adoqThNomPriceOldRO: TBooleanField
      DisplayWidth = 5
      FieldName = 'NomPriceOldRO'
      Visible = False
    end
    object adoqThConfirmMobileStockImport: TBooleanField
      FieldName = 'ConfirmMobileStockImport'
      Visible = False
    end
    object adoqThAutoFillBlindStockBlankCounts: TBooleanField
      FieldName = 'AutoFillBlindStockBlankCounts'
      Visible = False
    end
    object adoqThShowExpectedItemsOnlyInMobileStocks: TBooleanField
      FieldName = 'ShowExpectedItemsOnlyInMobileStocks'
      Visible = False
    end
    object adoqThUseMustCountItems: TBooleanField
      DisplayWidth = 5
      FieldName = 'UseMustCountItems'
      Visible = False
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = adoqTh
    Left = 314
    Top = 1
  end
  object adoqDiv: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Division Name] from Division'
      'order by [Division Name]')
    Left = 354
    Top = 1
  end
  object adoqThNames: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = wwDataSource1
    Parameters = <
      item
        Name = 'division'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      
        'select [tid], [tName], [active], [byHz], [SlaveTh], EndOnDoW, Co' +
        'nfirmMobileStockImport from [threads]'
      'where [division] = :division')
    Left = 242
    Top = 41
  end
  object adoqAutoReps: TADOQuery
    Connection = dmADO.AztecConn
    DataSource = wwDataSource1
    Parameters = <
      item
        Name = 'Tid'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end>
    SQL.Strings = (
      'select a.[AR], b.[Text] from stkAutoRep a, stkAReps b'
      'where a.AR = b.AR'
      'and a.Tid = :Tid')
    Left = 10
    Top = 33
  end
  object dsAutoRep: TwwDataSource
    DataSet = adoqARView
    Left = 66
    Top = 17
  end
  object adoqARView: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #stkARView')
    Left = 114
    Top = 49
  end
  object dsMakeMaster: TwwDataSource
    DataSet = adoqMakeMaster
    Left = 226
    Top = 153
  end
  object adoqMakeMaster: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterScroll = adoqMakeMasterAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select a.tid, a.tname, a.tnote, count(b.sitecode) as atSites, '
      
        'min(b.minSD) as minSD, max(b.maxED) as maxED, avg(b.avgPer) as a' +
        'vgPer'
      'from Threads a,'
      
        ' (select sitecode, tid, min(Sdate) as minSD, max(Edate) as maxED' +
        ', '
      '   avg(CAST((edate - sdate + 1) AS float)) as avgPer '
      '  from Stocks'
      '  where stockcode > 1'
      '  and division = '#39'01 Wet'#39
      '  group by sitecode, tid '
      '  having count(stockcode) > 0'
      ' ) b'
      'where a.tid = b.tid'
      'and a.division = '#39'01 Wet'#39
      'group by a.tid, a.tname, a.tnote')
    Left = 266
    Top = 153
  end
end
