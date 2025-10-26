object fSetNom: TfSetNom
  Left = 337
  Top = 197
  HelpContext = 1015
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Set Nominal Prices for items without one'
  ClientHeight = 496
  ClientWidth = 890
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
  object wwGrid1: TwwDBGrid
    Left = 0
    Top = 0
    Width = 890
    Height = 447
    PictureMasks.Strings = (
      'PurchCost'#9'#.##'#9'T'#9'T'
      'ActCloseStk'#9'{{{#[#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T')
    Selected.Strings = (
      'SubCat'#9'20'#9'Sub Category'#9'F'
      'Name'#9'40'#9'Name'#9'F'
      'PurchUnit'#9'10'#9'Unit'#9'F'
      'ThRedQty'#9'9'#9'Theo. Reduct.'#9'F'
      'PurchStk'#9'8'#9'Actual Reduct.'#9'F'
      'WastePC'#9'9'#9'Act. Red. Cost'#9'F'
      'OpStk'#9'8'#9'Closing Stk'#9'F'
      'WasteTill'#9'9'#9'Closing Cost'#9'F'
      'ActCloseStk'#9'12'#9'Nominal Price'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 8
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = wwsAuditCur
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = [dgEnterToTab]
    ParentFont = False
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
    OnCalcCellColors = wwGrid1CalcCellColors
    OnExit = wwGrid1Exit
    OnKeyUp = wwGrid1KeyUp
    PaintOptions.ActiveRecordColor = clHighlight
  end
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 890
    Height = 49
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 7
      Width = 94
      Height = 28
      AutoSize = False
      Caption = 'Legend for'#13#10'pre-filled Prices:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNomPriceTariffRO: TLabel
      Left = 253
      Top = 8
      Width = 68
      Height = 13
      Caption = '(Read Only)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblNomPriceOldRO: TLabel
      Left = 253
      Top = 27
      Width = 68
      Height = 13
      Caption = '(Read Only)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object OKBitBtn: TBitBtn
      Left = 376
      Top = 4
      Width = 214
      Height = 41
      Caption = 'Save and use these prices'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
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
    object BitBtn1: TBitBtn
      Left = 598
      Top = 4
      Width = 286
      Height = 41
      Caption = 'Abandon and do not use these prices'
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
    object StaticText1: TStaticText
      Left = 103
      Top = 5
      Width = 149
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BorderStyle = sbsSunken
      Caption = 'Terminal Selling Price '
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 2
    end
    object StaticText2: TStaticText
      Left = 103
      Top = 23
      Width = 149
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BorderStyle = sbsSunken
      Caption = 'Prior stock user-entered Price '
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
    end
  end
  object wwsAuditCur: TwwDataSource
    DataSet = wwtAuditCur
    Left = 280
    Top = 24
  end
  object wwtAuditCur: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforeEdit = wwtAuditCurBeforeEdit
    BeforePost = wwtAuditCurBeforePost
    AfterScroll = wwtAuditCurAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from AuditCur'
      ''
      'Order By "SubCat", "Name"')
    Left = 248
    Top = 24
    object wwtAuditCurEntityCode: TFloatField
      FieldName = 'EntityCode'
    end
    object wwtAuditCurSubCat: TStringField
      FieldName = 'SubCat'
    end
    object wwtAuditCurImpExRef: TStringField
      FieldName = 'ImpExRef'
      Size = 15
    end
    object wwtAuditCurName: TStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Size = 40
    end
    object wwtAuditCurOpStk: TFloatField
      FieldName = 'OpStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurPurchStk: TFloatField
      FieldName = 'PurchStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurThRedQty: TFloatField
      FieldName = 'ThRedQty'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurThCloseStk: TFloatField
      FieldName = 'ThCloseStk'
      OnGetText = wwtAuditCurOpStkGetText
      DisplayFormat = '0.##'
    end
    object wwtAuditCurActCloseStk: TFloatField
      FieldName = 'ActCloseStk'
      DisplayFormat = '0.00'
    end
    object wwtAuditCurPurchUnit: TStringField
      FieldName = 'PurchUnit'
      Size = 10
    end
    object wwtAuditCurPurchBaseU: TFloatField
      FieldName = 'PurchBaseU'
    end
    object wwtAuditCurACount: TStringField
      FieldName = 'ACount'
      Size = 9
    end
    object wwtAuditCurWasteTill: TFloatField
      FieldName = 'WasteTill'
      DisplayFormat = '0.00'
    end
    object wwtAuditCurWastePC: TFloatField
      FieldName = 'WastePC'
      DisplayFormat = '0.00'
    end
    object wwtAuditCurWasteTillA: TFloatField
      FieldName = 'WasteTillA'
    end
    object wwtAuditCurWastePCA: TFloatField
      FieldName = 'WastePCA'
    end
    object wwtAuditCurWastage: TFloatField
      FieldName = 'Wastage'
    end
  end
end
