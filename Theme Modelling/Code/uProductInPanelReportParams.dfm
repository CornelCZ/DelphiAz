object ProductInPanelReportParams: TProductInPanelReportParams
  Left = 399
  Top = 174
  Width = 260
  Height = 417
  HelpContext = 5060
  ActiveControl = edName
  Caption = 'Product in panel report'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    252
    390)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 138
    Height = 13
    Caption = 'Select a product to report on:'
  end
  object btPreview: TButton
    Left = 91
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Preview'
    TabOrder = 0
    OnClick = btPreviewClick
  end
  object Button2: TButton
    Left = 171
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 7
    Top = 24
    Width = 239
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
    object tvProductSelection: TTreeView
      Left = 0
      Top = 0
      Width = 239
      Height = 280
      Align = alClient
      HideSelection = False
      Indent = 19
      MultiSelectStyle = []
      ReadOnly = True
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 280
      Width = 239
      Height = 49
      Align = alBottom
      Caption = ' Search '
      TabOrder = 1
      DesignSize = (
        239
        49)
      object edName: TEdit
        Left = 8
        Top = 17
        Width = 172
        Height = 21
        Hint = 'Type search terms here.'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = edNameChange
      end
      object Button1: TButton
        Left = 208
        Top = 16
        Width = 22
        Height = 23
        Anchors = [akTop, akRight]
        Caption = '>'
        Default = True
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 184
        Top = 16
        Width = 22
        Height = 23
        Anchors = [akTop, akRight]
        Caption = '<'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      '-- TODO load from resource!!'
      'create table #ProductTree_Names'
      '('
      '  ID int identity(1,1),'
      '  Name varchar(50)'
      ')'
      ''
      'insert #ProductTree_Names select Name'
      'from ('
      'select [division name] as Name from division'
      'union'
      'select [category name] as Name from category'
      'union'
      'select [sub-category name] as Name from subcategory'
      'where subcategory.deleted is null or subcategory.deleted = '#39'N'#39
      'union'
      'select [extended rtl name] as Name from products'
      'where (products.deleted is null or products.deleted = '#39'N'#39')'
      '  and (Products.[Entity Type] in ('#39'Recipe'#39', '#39'Strd.Line'#39')) '
      '--union'
      '--select portiontype.[portiontypename] as portionname'
      '--from portions'
      
        '--join portiontype on portions.portiontypeid = portiontype.porti' +
        'ontypeid'
      ') a '
      'order by Name'
      ''
      'create table #ProductTree_data'
      '('
      '  Level1ID int,'
      '  Level2ID int,'
      '  Level3ID int,'
      '  Level4ID int,'
      '--  Level5ID int,'
      '  Level1Name int,'
      '  Level2Name int,'
      '  Level3Name int,'
      '  Level4Name int,'
      '--  Level5Name int,'
      '  primary key (Level1ID, Level2ID, Level3ID, Level4ID)'
      ')'
      ''
      'insert #ProductTree_Data'
      'select'
      '  division.[index no] as Level1ID,'
      '  category.[index no] as Level2ID,'
      '  subcategory.[index no] as Level3ID,'
      
        '  cast((products.[entitycode] - 10000000000.0) as int) as Level4' +
        'ID,'
      '--  portions.[portionid] as Level5ID,'
      '  divisionname.ID as Level1Name,'
      '  categoryname.ID as Level2Name,'
      '  subcategoryname.ID as Level3Name,'
      '  productname.ID as Level4Name'
      '--  portionname.ID as Level5Name'
      'from products'
      
        'join #ProductTree_Names productname on products.[extended rtl na' +
        'me] = productname.Name'
      
        'join subcategory on products.[sub-category name] = subcategory.[' +
        'sub-category name]'
      
        'join #ProductTree_Names subcategoryname on subcategory.[sub-cate' +
        'gory name] = subcategoryname.Name'
      
        'join category on subcategory.[category index] = category.[index ' +
        'no]'
      
        'join #ProductTree_Names categoryname on category.[category name]' +
        ' = categoryname.Name'
      'join division on category.[division index] = division.[index no]'
      
        'join #ProductTree_Names divisionname on division.[division name]' +
        ' = divisionname.Name'
      'where (products.deleted is null or products.deleted = '#39'N'#39')'
      '  and (Products.[Entity Type] in ('#39'Recipe'#39', '#39'Strd.Line'#39'))'
      '  and (subcategory.deleted is null or subcategory.deleted = '#39'N'#39')'
      
        '  -- PW fix for unsupported "site products" with massive entity ' +
        'codes'
      '  and products.entitycode < 19999999999.0'
      'order by division.[division name], category.[category name],'
      '  subcategory.[sub-category name], products.[extended rtl name]'
      '')
    Left = 184
    Top = 16
  end
end
