object fAud1Pr: TfAud1Pr
  Left = 365
  Top = 228
  Width = 507
  Height = 238
  HelpContext = 1014
  Caption = 'Single Product Multi Unit Entry Screen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnKeyDown = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 93
    Top = 1
    Width = 169
    Height = 17
    Color = clBtnFace
    DataField = 'SubCat'
    DataSource = fAudit.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText2: TDBText
    Left = 93
    Top = 24
    Width = 169
    Height = 17
    Alignment = taCenter
    Color = clBlue
    DataField = 'Name'
    DataSource = fAudit.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText3: TDBText
    Left = 411
    Top = 24
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clWhite
    DataField = 'ThCloseStk'
    DataSource = fAudit.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 4
    Top = 26
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = 'Product Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 278
    Top = 26
    Width = 130
    Height = 13
    Alignment = taRightJustify
    Caption = 'Theo. Close Inventory:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 172
    Width = 212
    Height = 37
  end
  object Label4: TLabel
    Left = 15
    Top = 165
    Width = 57
    Height = 13
    Caption = ' Product: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNewItem: TLabel
    Left = 324
    Top = 2
    Width = 169
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = '---- New Item ----'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object wwDBGrid1: TwwDBGrid
    Left = 4
    Top = 42
    Width = 492
    Height = 121
    PictureMasks.Strings = (
      'q1'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q5'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q2'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q3'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q4'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T')
    Selected.Strings = (
      'unit'#9'12'#9'Unit'#9'F'
      'totQ'#9'13'#9'Total'#9'F'
      'q1'#9'9'#9'Qty 1'#9#9
      'q2'#9'9'#9'Qty 2'#9#9
      'q3'#9'9'#9'Qty 3'#9#9
      'q4'#9'9'#9'Qty 4'#9#9
      'q5'#9'9'#9'Qty 5'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = wwDBGrid1RowChanged
    FixedCols = 2
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnColEnter = wwDBGrid1ColEnter
    OnDrawFooterCell = wwDBGrid1DrawFooterCell
    OnUpdateFooter = wwDBGrid1UpdateFooter
    FooterCellColor = clWindow
    FooterHeight = 25
  end
  object btnOK: TBitBtn
    Left = 264
    Top = 171
    Width = 110
    Height = 38
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnOKClick
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
  object btnCancel: TBitBtn
    Left = 384
    Top = 171
    Width = 110
    Height = 38
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
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
  object btnPrevious: TBitBtn
    Left = 13
    Top = 180
    Width = 102
    Height = 26
    Caption = 'Previous (PgUp)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnPreviousClick
  end
  object btnNext: TBitBtn
    Left = 121
    Top = 180
    Width = 94
    Height = 26
    Caption = 'Next (PgDown)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnNextClick
  end
  object pnlPrepared: TPanel
    Left = 5
    Top = 98
    Width = 475
    Height = 40
    TabOrder = 5
    object Label6: TLabel
      Left = 1
      Top = 1
      Width = 473
      Height = 38
      Align = alClient
      Alignment = taCenter
      Caption = '---- Prepared Item ----'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clYellow
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = ADOQuery1
    Left = 216
    Top = 162
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = ADOQuery1BeforePost
    Parameters = <>
    SQL.Strings = (
      'select * from [#1prod]'
      'order by [default] desc, unit')
    Left = 184
    Top = 162
    object ADOQuery1unit: TStringField
      FieldName = 'unit'
      Size = 10
    end
    object ADOQuery1default: TStringField
      FieldName = 'default'
      Size = 1
    end
    object ADOQuery1totQ: TBCDField
      FieldName = 'totQ'
      OnGetText = ADOQuery1q1GetText
      Precision = 19
    end
    object ADOQuery1ratio: TBCDField
      FieldName = 'ratio'
      Precision = 19
    end
    object ADOQuery1btu: TStringField
      FieldName = 'btu'
      Size = 5
    end
    object ADOQuery1q1: TStringField
      Alignment = taRightJustify
      FieldName = 'q1'
      Size = 9
    end
    object ADOQuery1q2: TStringField
      Alignment = taRightJustify
      FieldName = 'q2'
      Size = 9
    end
    object ADOQuery1q3: TStringField
      Alignment = taRightJustify
      FieldName = 'q3'
      Size = 9
    end
    object ADOQuery1q4: TStringField
      Alignment = taRightJustify
      FieldName = 'q4'
      Size = 9
    end
    object ADOQuery1q5: TStringField
      Alignment = taRightJustify
      FieldName = 'q5'
      Size = 9
    end
  end
end
