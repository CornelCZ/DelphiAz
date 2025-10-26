object fLCtempl: TfLCtempl
  Left = 325
  Top = 233
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Line Check Templates'
  ClientHeight = 474
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 6
    Top = 277
    Width = 257
    Height = 145
    Color = clTeal
    DataField = 'TText'
    DataSource = wwDataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 189
    Height = 13
    Caption = 'Choose a Template to Copy from:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 276
    Top = 6
    Width = 164
    Height = 13
    Caption = 'Selected Template products:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 261
    Width = 112
    Height = 13
    Caption = 'Template Comment:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 12
    Top = 166
    Width = 164
    Height = 13
    Caption = 'Selected Template products:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 12
    Top = 222
    Width = 164
    Height = 13
    Caption = 'Selected Template products:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object wwDBGrid1: TwwDBGrid
    Left = 6
    Top = 21
    Width = 257
    Height = 233
    Selected.Strings = (
      'TName'#9'36'#9'Template Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object BitBtn1: TBitBtn
    Left = 6
    Top = 429
    Width = 143
    Height = 41
    Caption = 'Copy Selection'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
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
  object BitBtn2: TBitBtn
    Left = 166
    Top = 429
    Width = 97
    Height = 41
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 273
    Height = 218
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 199
      Height = 13
      Caption = 'Type a unique name for the new template:'
    end
    object Label5: TLabel
      Left = 8
      Top = 54
      Width = 181
      Height = 13
      Caption = 'Type a comment for the new template:'
    end
    object Label6: TLabel
      Left = 198
      Top = 43
      Width = 65
      Height = 14
      Caption = 'Max. 35 char.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 192
      Top = 163
      Width = 71
      Height = 14
      Caption = 'Max. 255 char.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 8
      Top = 24
      Width = 257
      Height = 21
      MaxLength = 35
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 8
      Top = 67
      Width = 257
      Height = 97
      Lines.Strings = (
        '')
      MaxLength = 255
      TabOrder = 1
      WantReturns = False
    end
    object BitBtn3: TBitBtn
      Left = 9
      Top = 181
      Width = 138
      Height = 31
      Caption = 'Save Template'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
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
      Left = 163
      Top = 181
      Width = 101
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Kind = bkCancel
    end
  end
  object wwDBGrid2: TwwDBGrid
    Left = 276
    Top = 21
    Width = 527
    Height = 449
    Selected.Strings = (
      'Cat'#9'20'#9'Category'
      'Sub'#9'20'#9'Sub-Category'
      'PurN'#9'40'#9'Purchase Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource2
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object pnlManage: TPanel
    Left = -4
    Top = 408
    Width = 641
    Height = 474
    TabOrder = 5
    Visible = False
    DesignSize = (
      641
      474)
    object Label8: TLabel
      Left = 12
      Top = 2
      Width = 374
      Height = 13
      Caption = 'Select a Template, change its name and/or comment, or delete it '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 12
      Top = 226
      Width = 228
      Height = 13
      Caption = 'Selected Template products (read only):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 13
      Top = 159
      Width = 167
      Height = 13
      Caption = 'Template Comment (max 255 char.)'
    end
    object wwDBGrid3: TwwDBGrid
      Left = 12
      Top = 241
      Width = 515
      Height = 229
      Selected.Strings = (
        'Cat'#9'19'#9'Category'#9'F'
        'Sub'#9'19'#9'Sub-Category'#9'F'
        'PurN'#9'40'#9'Purchase Name'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      DataSource = wwDataSource2
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      LineColors.DataColor = clBlack
      LineColors.ShadowColor = clBlack
    end
    object wwDBEdit1: TwwDBEdit
      Left = 12
      Top = 172
      Width = 613
      Height = 45
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      DataField = 'TText'
      DataSource = wwDataSource3
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = True
    end
    object wwDBGrid4: TwwDBGrid
      Left = 12
      Top = 16
      Width = 381
      Height = 141
      Selected.Strings = (
        'Div'#9'20'#9'Division'#9'T'
        'TName'#9'35'#9'Template Name (max 35 char.)'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = True
      DataSource = wwDataSource3
      KeyOptions = [dgEnterToTab]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
    end
    object BitBtn5: TBitBtn
      Left = 531
      Top = 432
      Width = 108
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Done'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn5Click
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
    object BitBtn6: TBitBtn
      Left = 531
      Top = 383
      Width = 108
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Delete'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn6Click
      Glyph.Data = {
        AE010000424DAE010000000000007600000028000000180000001A0000000100
        04000000000038010000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAA0F070
        708080AAAAAAAAAAAAA0F070708080AAAAAAAAAAAAA0F070708080AAAAAAAAAA
        AAA0F070708080AAAAAAAAAAAAA0F070708080AAAAAAAAAAA0A0F070708080A0
        AAAAAAAAAA00F0707080800AAAAAAAAAAAA00000000000AAAAAAAAAAAA0FFFF7
        7788880AAAAAAAAAA000000000000000AAAAAAAAAAAA0FF9FFF9FF0AAAAAAAAA
        AAA0FFFFFF9FFFF0AAAAAAAAAA0FF9FFF9FFF9FF0AAAAAAAA0FF9FFFFFFF9FF0
        AAAAAAAA0FF9FFF9FFF9FF0AAAAAAAA0FFFFFF9FFFFFF0AAAAAAAA0FF9FFF9FF
        F9FF0AAAAAAAA0FF9FFFFFFF9FF0AAAAAAAA0FF9FFF9FFF9FF0AAAAAAAAAA0FF
        FF9FFFFFF0AAAAAAAAAAAA0FF9FFF9FF0AFFFFFFFFFFAAA0FFFF9FF0AAFCCCCC
        CCCFAAAA0FF9FF0AAAFCCCCCCCCFAAAAA0FFF0AAAAFFFFFFFFFFAAAAAA0F0AAA
        AAAAAAAAAAAAAAAAAAA0AAAAAAAAAAAAAAAA}
    end
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'theDiv'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'select * from LineCheckTemplate'
      'where Div = :theDiv'
      'and TemplateID >= 0'
      'order by TName')
    Left = 88
    Top = 88
  end
  object ADOQuery2: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = wwDataSource1
    Parameters = <
      item
        Name = 'templateid'
        DataType = ftSmallint
        Value = 1
      end>
    SQL.Strings = (
      
        'SELECT [EntityCode], [Cat], [SCat] as Sub, [PurchaseName] as Pur' +
        'N'
      'FROM stkEntity'
      'WHERE [EntityCode] in'
      '     (select m.Entitycode from LineCheckTemplateDetail m'
      '      where m.templateid = :templateid)'
      'order by [Cat], [SCat], [PurchaseName]'
      '')
    Left = 192
    Top = 80
  end
  object wwDataSource1: TwwDataSource
    DataSet = ADOQuery1
    Left = 128
    Top = 96
  end
  object wwDataSource2: TwwDataSource
    DataSet = ADOQuery2
    Left = 240
    Top = 88
  end
  object ADOQuery3: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from LineCheckTemplate'
      'where TemplateID > 0 '
      'order by div, TName')
    Left = 448
  end
  object wwDataSource3: TwwDataSource
    DataSet = ADOQuery3
    Left = 480
  end
end
