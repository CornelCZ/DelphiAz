object fPCWasteEdit: TfPCWasteEdit
  Left = 289
  Top = 326
  HelpContext = 1049
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Edit Quantities'
  ClientHeight = 293
  ClientWidth = 553
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    553
    293)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 435
    Top = 7
    Width = 113
    Height = 181
    Anchors = [akTop, akRight]
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 68
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Categ.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 438
    Top = 2
    Width = 84
    Height = 13
    Anchors = [akTop, akRight]
    Caption = ' Product Grid: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSub: TLabel
    Left = 78
    Top = 9
    Width = 29
    Height = 13
    Caption = 'lblSub'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblProd: TLabel
    Left = 48
    Top = 41
    Width = 385
    Height = 18
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lblProd'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 440
    Top = 80
    Width = 103
    Height = 106
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 
      'Prior/Next also inserts the waste qtys. in the List.'#13#10' '#13#10'Qty. = ' +
      '0 means no waste for this Unit.'
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object Label5: TLabel
    Left = 7
    Top = 24
    Width = 69
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblDesc: TLabel
    Left = 78
    Top = 25
    Width = 29
    Height = 13
    Caption = 'lblSub'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelNote: TLabel
    Left = 8
    Top = 193
    Width = 28
    Height = 13
    Caption = 'Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblPrep: TLabel
    Left = 192
    Top = 190
    Width = 148
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'This is a Prepared Item'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 62
    Width = 425
    Height = 126
    PictureMasks.Strings = (
      'q1'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q5'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q2'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q3'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
      'q4'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T')
    Selected.Strings = (
      'unit'#9'14'#9'Unit'#9'F'
      'q1'#9'11'#9'Qty.'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnRowChanged = wwDBGrid1RowChanged
    FixedCols = 1
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFooter3DCells]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    FooterCellColor = clWindow
    FooterHeight = 25
  end
  object BitBtn3: TBitBtn
    Left = 440
    Top = 16
    Width = 102
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Prior (PgUp)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 440
    Top = 49
    Width = 102
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Next (PgDown)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn4Click
  end
  object BitBtnOK: TBitBtn
    Left = 442
    Top = 260
    Width = 109
    Height = 32
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtnOKClick
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
  object BitBtnCancel: TBitBtn
    Left = 327
    Top = 260
    Width = 105
    Height = 32
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
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
  object MemoNote: TMemo
    Left = 8
    Top = 209
    Width = 541
    Height = 48
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxLength = 255
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object ADOQuery1: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = ADOQuery1BeforePost
    Parameters = <>
    SQL.Strings = (
      'select * from [#1prod]'
      'order by [default] desc, unit')
    Left = 26
    Top = 85
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
  end
  object wwDataSource1: TwwDataSource
    DataSet = ADOQuery1
    Left = 58
    Top = 85
  end
end
