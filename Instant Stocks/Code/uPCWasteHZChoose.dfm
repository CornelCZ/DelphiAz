object fPCWasteHZChoose: TfPCWasteHZChoose
  Left = 434
  Top = 308
  BorderStyle = bsDialog
  Caption = 'Waste'
  ClientHeight = 186
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 153
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    TabOrder = 0
    object LabelHZChoose: TLabel
      Left = 4
      Top = 5
      Width = 138
      Height = 13
      Caption = 'Choose a Holding Zone:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object wwDBGridHZs: TwwDBGrid
      Left = 2
      Top = 22
      Width = 316
      Height = 129
      Selected.Strings = (
        'hzName'#9'39'#9'Holding Zone'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = False
      Align = alBottom
      DataSource = dsHZs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
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
      OnDblClick = wwDBGridHZsDblClick
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 153
    Width = 320
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      320
      33)
    object BitBtnCancel: TBitBtn
      Left = 162
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
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
    object BitBtnNext: TBitBtn
      Left = 242
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Next'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnNextClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
        AAAAAAAAAAAAAAAAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA800
        8AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAAA8008AA8008AAAAAA8008AA
        8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008AAAAA8008AA8008
        AAAAA8008AA8008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}
      Layout = blGlyphRight
    end
  end
  object dsHZs: TDataSource
    DataSet = adoqHZs
    Left = 52
    Top = 48
  end
  object adoqHZs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from stkHZs where active = 1')
    Left = 20
    Top = 48
    object adoqHZsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object adoqHZshzID: TIntegerField
      FieldName = 'hzID'
    end
    object adoqHZshzName: TStringField
      FieldName = 'hzName'
      Size = 30
    end
    object adoqHZsePur: TBooleanField
      FieldName = 'ePur'
      OnGetText = adoqHZsBooleanGetText
    end
    object adoqHZseOut: TBooleanField
      FieldName = 'eOut'
    end
    object adoqHZseMoveIn: TBooleanField
      FieldName = 'eMoveIn'
    end
    object adoqHZseMoveOut: TBooleanField
      FieldName = 'eMoveOut'
    end
    object adoqHZseSales: TBooleanField
      FieldName = 'eSales'
      OnGetText = adoqHZsBooleanGetText
    end
    object adoqHZseWaste: TBooleanField
      FieldName = 'eWaste'
    end
    object adoqHZsActive: TBooleanField
      FieldName = 'Active'
    end
    object adoqHZsLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
  end
end
