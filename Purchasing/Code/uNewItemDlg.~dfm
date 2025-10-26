object fnewitemdlg: Tfnewitemdlg
  Left = 165
  Top = 229
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Add Item'
  ClientHeight = 455
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 791
    Height = 455
    Align = alClient
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 52
      Width = 89
      Height = 16
      Caption = ' Search Mode: '
    end
    object Panel3: TPanel
      Left = 1
      Top = 352
      Width = 789
      Height = 102
      Align = alBottom
      TabOrder = 0
      object Bevel1: TBevel
        Left = 3
        Top = 43
        Width = 497
        Height = 53
      end
      object sbPurchName: TSpeedButton
        Left = 8
        Top = 57
        Width = 113
        Height = 33
        GroupIndex = 1
        Down = True
        Caption = 'Purch. Name (F5)'
        OnClick = SearchModeButtonClick
      end
      object sbSubCat: TSpeedButton
        Left = 256
        Top = 57
        Width = 113
        Height = 33
        GroupIndex = 1
        Caption = 'Sub-Categ (F7)'
        OnClick = SearchModeButtonClick
      end
      object Label2: TLabel
        Left = 13
        Top = 12
        Width = 89
        Height = 16
        Alignment = taRightJustify
        Caption = 'Type to search:'
      end
      object Label3: TLabel
        Left = 8
        Top = 35
        Width = 89
        Height = 16
        Caption = ' Search Mode: '
      end
      object Bevel2: TBevel
        Left = 518
        Top = 4
        Width = 131
        Height = 92
      end
      object sbRetDesc: TSpeedButton
        Left = 132
        Top = 57
        Width = 113
        Height = 33
        GroupIndex = 1
        Caption = 'Retail Descr. (F6)'
        OnClick = SearchModeButtonClick
      end
      object sbImpExpRef: TSpeedButton
        Left = 381
        Top = 57
        Width = 113
        Height = 33
        GroupIndex = 1
        Caption = 'Imp/Exp Ref. (F8)'
        OnClick = SearchModeButtonClick
      end
      object BtnNext: TBitBtn
        Left = 276
        Top = 8
        Width = 66
        Height = 24
        Caption = 'Next (F3)'
        TabOrder = 1
        OnClick = BtnNextClick
      end
      object BtnAccept: TBitBtn
        Left = 669
        Top = 56
        Width = 113
        Height = 35
        Caption = '&Accept'
        TabOrder = 5
        OnClick = BtnAcceptClick
      end
      object wwincsearch: TwwIncrementalSearch
        Left = 104
        Top = 8
        Width = 164
        Height = 24
        DataSource = wwDataSource1
        SearchField = 'purchase name'
        TabOrder = 0
        OnEnter = wwincsearchEnter
      end
      object BtnMidWord: TBitBtn
        Left = 528
        Top = 11
        Width = 113
        Height = 35
        Caption = 'Mid-Word (F2)'
        TabOrder = 2
        OnClick = BtnMidWordClick
      end
      object BtnToggleSupplier: TBitBtn
        Left = 669
        Top = 12
        Width = 113
        Height = 35
        Action = ToggleSupplierAction
        Caption = 'Single &Supplier'
        TabOrder = 4
      end
      object btnAdvanced: TBitBtn
        Left = 528
        Top = 54
        Width = 113
        Height = 35
        Caption = 'Advanced (F9)'
        TabOrder = 3
        OnClick = btnAdvancedClick
      end
    end
    object wwDBGrid1: TwwDBGrid
      Left = 1
      Top = 1
      Width = 789
      Height = 351
      Selected.Strings = (
        'Purchase Name'#9'20'#9'Purchase Name'#9#9
        'Retail Description'#9'20'#9'Retail Description'#9#9
        'Sub-Category Name'#9'20'#9'Sub-Category Name'#9#9
        'Import/Export Reference'#9'15'#9'Import/Export~Reference'#9#9
        'Unit Name'#9'10'#9'Unit Name'#9#9
        'Flavour'#9'10'#9'Flavour'#9#9
        'MultiPurchaseProduct'#9'1'#9'Multi-~Purchase'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = wwDataSource1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnDblClick = wwDBGrid1DblClick
      OnKeyDown = wwDBGrid1KeyDown
    end
  end
  object Panel1: TPanel
    Left = 2
    Top = 2
    Width = 236
    Height = 217
    BevelWidth = 2
    TabOrder = 0
    object SearchLabel: TLabel
      Left = 8
      Top = 8
      Width = 115
      Height = 16
      Caption = 'Choose Item Name:'
    end
    object lookitem: TwwDBLookupCombo
      Left = 8
      Top = 24
      Width = 217
      Height = 24
      DropDownAlignment = taLeftJustify
      LookupTable = wwqSearch
      LookupField = 'itemname'
      Options = [loColLines, loRowLines, loTitles]
      Style = csDropDownList
      Enabled = False
      TabOrder = 0
      Visible = False
      AutoDropDown = False
      ShowButton = True
      UseTFields = False
      AllowClearKey = False
    end
    object BtnOK: TBitBtn
      Left = 64
      Top = 182
      Width = 75
      Height = 25
      TabOrder = 2
      OnClick = BtnOKClick
      Kind = bkOK
    end
    object BtnCancel: TBitBtn
      Left = 150
      Top = 182
      Width = 75
      Height = 25
      TabOrder = 3
      Kind = bkCancel
    end
    object rgSearchMode: TRadioGroup
      Left = 9
      Top = 60
      Width = 178
      Height = 115
      Caption = ' Search Mode: '
      ItemIndex = 0
      Items.Strings = (
        'Purchase Name'
        'Retail Description'
        'Sub-Category'
        'Import/Export Reference')
      TabOrder = 1
      TabStop = True
      OnClick = rgSearchModeClick
    end
  end
  object wwDataSource1: TwwDataSource
    Left = 429
    Top = 173
  end
  object wwFind: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = wwDataSource1
    SearchField = 'purchase name'
    MatchType = mtPartialMatchAny
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsAllFields
    ShowMessages = True
    UseLocateMethod = True
    Options = []
    Left = 241
    Top = 288
  end
  object qPurchName: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT recno, [itemname], [SubCat Name] as SubCatName, [ImpExp R' +
        'ef] as ImpExpRef, [ItemCost], [Qty]'
      'FROM invoice')
    Left = 157
    Top = 53
  end
  object qRetDescr: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'SELECT recno, b.[Retail Description] as RetailDesc, [itemname], ' +
        '[SubCat Name] as SubCatName, [ImpExp Ref] as ImpExpRef, ItemCost' +
        ', [Qty]'
      'FROM invoice, products b'
      'WHERE ItemID = [EntityCode]')
    Left = 156
    Top = 84
  end
  object qSubCat: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'SELECT recno, [SubCat Name] as SubCatName, [itemname], [ImpExp R' +
        'ef] as ImpExpRef, [ItemCost], [Qty]'
      'FROM invoice')
    Left = 156
    Top = 120
  end
  object qImpExpRef: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'SELECT recno, [ImpExp Ref] as ImpExpRef, [SubCat Name] as SubCat' +
        'Name, [itemname], [ItemCost], [Qty]'
      'FROM invoice')
    Left = 156
    Top = 150
  end
  object wwqSearch: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT recno,[itemname],[Retail Description] as RetailDesc,[SubC' +
        'at Name],[ImpExp Ref],[ItemCost],[Qty]'
      'FROM invoice, products'
      'WHERE ItemID = [EntityCode]')
    Left = 198
    Top = 96
  end
  object qAllSupplierProducts: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'delNoteDate'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT c.*, d.[Division Name]'
      'FROM'
      '('
      
        '        SELECT DISTINCT a.[Entity Code], a.[Purchase Name], a.[R' +
        'etail Description], a.[Sub-Category Name],'
      
        '          b.[Supplier Name], b.[Import/Export Reference], b.[Uni' +
        't Name], b.[Flavour],'
      
        '          b.[Default Flag],b.[Unit Cost], a.[Whether Sales Taxab' +
        'le], NULL AS MultiPurchaseProduct'
      
        '        FROM Products a INNER JOIN punits b ON a.[Entity Code] =' +
        ' b.[Entity Code]'
      
        '        WHERE ( a.[Entity Type] = '#39'Strd.Line'#39' OR a.[Entity Type]' +
        ' = '#39'Purch.Line'#39' )'
      '        AND (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      '        AND (a.discontinue <> 1 or a.Discontinue is Null)'
      ''
      '        UNION'
      ''
      
        '        SELECT DISTINCT b.[MultiPurchParent], a.[Purchase Name],' +
        ' a.[Retail Description], a.[Sub-Category Name],'
      
        '          b.[Supplier Name], NULL, NULL, b.[Flavour], NULL, NULL' +
        ', a.[Whether Sales Taxable], '#39'Y'#39' as MultiPurchaseProduct'
      
        '        FROM Products a INNER JOIN MultiPurchSupplier b on a.[En' +
        'tityCode] = b.[MultiPurchParent]'
      '        WHERE (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      ') c, division d, category e, subcateg f'
      'WHERE c.[Sub-Category Name] = f.[Sub-Category Name]'
      'AND f.[Category Name] = e.[Category Name]'
      'AND e.[Division Name] = d.[Division Name]'
      'AND ( ( d.[Division Name] IN'
      '        ( select Division'
      '          from ( select s.Division, max(s.[EDate]) as MaxEnd'
      '                 from Stocks s, Threads t'
      '                 where s.TID = t.TID'
      '                 and ISNULL(t.NoPurAcc,'#39#39') <> '#39'Y'#39
      '                 group by s.Division ) g'
      '          where g.MaxEnd < :delNoteDate'
      '        ) )'
      '      OR'
      
        '      ( d.[Division Name] NOT IN ( SELECT DISTINCT [Division] FR' +
        'OM Stocks ) )'
      '    )'
      
        'ORDER BY c.[Sub-Category Name], c.[Purchase Name], c.[Retail Des' +
        'cription], c.[Default Flag] DESC, c.[Import/Export Reference]'
      ''
      '')
    Left = 396
    Top = 171
  end
  object qSingleSupplierProds: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'thesupplier'
        Size = -1
        Value = Null
      end
      item
        Name = 'thesupplier'
        Size = -1
        Value = Null
      end
      item
        Name = 'delNoteDate'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT c.*, d.[Division Name]'
      'FROM'
      '('
      
        '        SELECT DISTINCT a.[Entity Code], a.[Purchase Name], a.[R' +
        'etail Description], a.[Sub-Category Name],'
      
        '          b.[Supplier Name], b.[Import/Export Reference], b.[Uni' +
        't Name], b.[Flavour],'
      
        '          b.[Default Flag],b.[Unit Cost], a.[Whether Sales Taxab' +
        'le], NULL AS MultiPurchaseProduct'
      
        '        FROM Products a INNER JOIN punits b ON a.[Entity Code] =' +
        ' b.[Entity Code]'
      
        '        WHERE ( a.[Entity Type] = '#39'Strd.Line'#39' OR a.[Entity Type]' +
        ' = '#39'Purch.Line'#39' )'
      '        AND ( b.[Supplier Name] = :thesupplier )'
      '        AND (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      '        AND (a.discontinue <> 1 or a.Discontinue is Null)'
      ''
      '        UNION'
      ''
      
        '        SELECT DISTINCT b.[MultiPurchParent], a.[Purchase Name],' +
        ' a.[Retail Description], a.[Sub-Category Name],'
      
        '          b.[Supplier Name], NULL, NULL, b.[Flavour], NULL, NULL' +
        ', a.[Whether Sales Taxable], '#39'Y'#39' as MultiPurchaseProduct'
      
        '        FROM Products a INNER JOIN MultiPurchSupplier b on a.[En' +
        'tityCode] = b.[MultiPurchParent]'
      '        WHERE b.[Supplier Name] = :thesupplier'
      '        AND (a.Deleted is NULL or a.Deleted <> '#39'Y'#39')'
      ') c, division d, category e, subcateg f'
      'WHERE c.[Sub-Category Name] = f.[Sub-Category Name]'
      'AND f.[Category Name] = e.[Category Name]'
      'AND e.[Division Name] = d.[Division Name]'
      'AND ( ( d.[Division Name] IN'
      '        ( select Division'
      
        '          from ( select Division, max([EDate]) as MaxEnd from St' +
        'ocks group by Division ) g'
      '          where g.MaxEnd < :delNoteDate'
      '        ) )'
      '      OR'
      
        '      ( d.[Division Name] NOT IN ( SELECT DISTINCT [Division] FR' +
        'OM Stocks ) )'
      '    )'
      
        'ORDER BY c.[Sub-Category Name], c.[Purchase Name], c.[Retail Des' +
        'cription], c.[Default Flag] DESC, c.[Import/Export Reference]'
      '')
    Left = 396
    Top = 203
  end
  object ActionList1: TActionList
    Left = 405
    Top = 108
    object ToggleSupplierAction: TAction
      Caption = 'Single &Supplier'
      SecondaryShortCuts.Strings = (
        'ALT+S')
      OnExecute = ToggleSupplierActionExecute
      OnUpdate = ToggleSupplierActionUpdate
    end
  end
end
