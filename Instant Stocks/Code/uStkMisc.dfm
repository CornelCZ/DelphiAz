object fstkmisc: Tfstkmisc
  Left = 465
  Top = 188
  HelpContext = 1012
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Miscellaneous Stock Figures'
  ClientHeight = 467
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 391
    Height = 443
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PanelMiddle: TPanel
      Left = 0
      Top = 97
      Width = 391
      Height = 169
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 47
        Top = 2
        Width = 297
        Height = 163
        Caption = ' Allowances '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 18
          Width = 44
          Height = 13
          Caption = 'Reason'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 221
          Top = 18
          Width = 43
          Height = 13
          Caption = 'Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object DBEditR1: TwwDBEdit
          Left = 8
          Top = 65
          Width = 176
          Height = 21
          DataField = 'MiscBalReason1'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBEditA1: TwwDBEdit
          Left = 209
          Top = 65
          Width = 78
          Height = 21
          DataField = 'MiscBal1'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Picture.PictureMask = '[-]{{{#[#][#][#][#][.#[#]]},.#[#]}}'
          Picture.AutoFill = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBEditA2: TwwDBEdit
          Left = 209
          Top = 99
          Width = 78
          Height = 21
          DataField = 'MiscBal2'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Picture.PictureMask = '[-]{{{#[#][#][#][#][.#[#]]},.#[#]}}'
          Picture.AutoFill = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBEditR2: TwwDBEdit
          Left = 8
          Top = 99
          Width = 176
          Height = 21
          DataField = 'MiscBalReason2'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBEditR3: TwwDBEdit
          Left = 8
          Top = 133
          Width = 176
          Height = 21
          DataField = 'MiscBalReason3'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBEditA3: TwwDBEdit
          Left = 209
          Top = 133
          Width = 78
          Height = 21
          DataField = 'MiscBal3'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Picture.PictureMask = '[-]{{{#[#][#][#][#][.#[#]]},.#[#]}}'
          Picture.AutoFill = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object StaticText1: TStaticText
          Left = 8
          Top = 35
          Width = 176
          Height = 18
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkSoft
          BorderStyle = sbsSunken
          Caption = 'Automatic Wastage Value'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 6
        end
        object stAWvalue: TDBEdit
          Left = 209
          Top = 35
          Width = 78
          Height = 18
          TabStop = False
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkSoft
          BorderStyle = bsSizeable
          Color = clTeal
          DataField = 'TotAWvalue'
          DataSource = wwDS1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          TabOrder = 7
        end
      end
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 266
      Width = 391
      Height = 177
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 10
        Top = 2
        Width = 73
        Height = 13
        Caption = 'Inventory Note:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object OKBtn: TBitBtn
        Left = 10
        Top = 135
        Width = 182
        Height = 37
        Caption = 'Save Changes && Exit'
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = OKBtnClick
        Glyph.Data = {
          8A010000424D8A01000000000000760000002800000018000000170000000100
          0400000000001401000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
          AAAAAAAAAAAAACCCCCCCCCCCCCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFF
          CCCCFFFFCCFFCCCFFCCCACFFCCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCF
          FCCCACFFCCCCFFFFCCFFCCCFFCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCC
          CCCCCCCCCCCCAAAAAAAAAAAAAAAAAAAAAAAAAAA70000000000000AAAAAAAAAA0
          33000000FF030AAAAAAAAAA033000000FF030AAAAAAAAAA033000000FF030AAA
          AAAAAAA03300000000030AAAAAAAAAA03333333333330AAAAAAAAAA033000000
          00330AAAAAAAAAA030FAAAAAAA030AAAAAAAAAA030AFAAAAAA030AAAAAAAAAA0
          30AAAAAAAA030AAAAAAAAAA030AAAAAAAA000AAAAAAAAAA030AAAAAAAA0F0AAA
          AAAAAAA00000000000000AAAAAAA}
      end
      object DBStkMemo: TDBMemo
        Left = 10
        Top = 18
        Width = 370
        Height = 109
        DataField = 'StockNote'
        DataSource = wwDS1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        OnDblClick = DBStkMemoDblClick
      end
      object CancelBtn: TBitBtn
        Left = 198
        Top = 135
        Width = 182
        Height = 37
        Cancel = True
        Caption = 'Abandon Changes && Exit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = CancelBtnClick
        Glyph.Data = {
          8A010000424D8A01000000000000760000002800000018000000170000000100
          0400000000001401000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
          CCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFFCCCCFFFFCCFFCCCFFCCCACFF
          CCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCFFCCCACFFCCCCFFFFCCFFCCCF
          FCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCCCCCCCCCCCCCCAAAAAAAAAAAA
          AAAAAAAAAAAAA7000000AAAAAAAAAAAAAAAAA0330000AA00000000AAAAAAA033
          0000AA000FF030AAAAAAA03300000AA00FF030AAAAAAA033000000AA0FF030AA
          AAAAA033333330AA000030AAAAAAA033000000AA033330AAAAAAA030FAAAA0AA
          000330AAAAAAA030AFAA0AAA0AA030AAAAAAA030AAA0AAA0AAA030AAAAAAA030
          AA0AAA0AAAA030AAAAAAA030A0AAA0AAAAA000AAAAAAA00000AA0AAAAAA0F0AA
          AAAAAAAAAAAA0000000000AAAAAA}
      end
    end
    object PanelTop: TPanel
      Left = 0
      Top = 0
      Width = 391
      Height = 97
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Shape1: TShape
        Left = 155
        Top = 43
        Width = 95
        Height = 3
        Brush.Style = bsClear
      end
      object Label7: TLabel
        Left = 65
        Top = 27
        Width = 84
        Height = 13
        Caption = 'Cashup Variance:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 60
        Top = 8
        Width = 89
        Height = 13
        Caption = 'Expected Takings:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 60
        Top = 74
        Width = 90
        Height = 13
        Caption = 'Actual Takings:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label9: TDBText
        Left = 163
        Top = 51
        Width = 87
        Height = 13
        Alignment = taRightJustify
        DataField = 'DeclaredPay'
        DataSource = wwDS1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TDBText
        Left = 163
        Top = 27
        Width = 87
        Height = 13
        Alignment = taRightJustify
        DataField = 'TotTillVar'
        DataSource = wwDS1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TDBText
        Left = 163
        Top = 8
        Width = 87
        Height = 13
        Alignment = taRightJustify
        DataField = 'TotInc'
        DataSource = wwDS1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labWholeSite: TLabel
        Left = 256
        Top = 11
        Width = 132
        Height = 81
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Blue boxes represent Site Totals and are Read Only on this tab.'#13 +
          #10'Their editing is done by Holding Zone '
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
      end
      object labNoSales: TLabel
        Left = 56
        Top = 8
        Width = 272
        Height = 84
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'This Holding Zone is not enabled for Sales '#13#10'so it cannot have a' +
          'ny Takings or Variance. '
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
      end
      object DBEditActT: TwwDBEdit
        Left = 157
        Top = 70
        Width = 96
        Height = 21
        DataField = 'Banked'
        DataSource = wwDS1
        Picture.PictureMask = '{{{#[#][#][#][#][#][#][.#[#]]},.#[#]}}'
        Picture.AutoFill = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object pnlNoTills: TPanel
        Left = 0
        Top = 0
        Width = 391
        Height = 33
        Align = alTop
        TabOrder = 1
        Visible = False
        object Label10: TLabel
          Left = 24
          Top = 88
          Width = 345
          Height = 89
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'This Site has no Terminals.'#13#10'There are no Sales and thus there a' +
            're '#13#10'no Retail related figures to fill in.'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
      end
    end
  end
  object hzTabs: TPageControl
    Left = 0
    Top = 0
    Width = 391
    Height = 24
    ActivePage = hzTab0
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    Images = data1.hzTabsImgList
    ParentFont = False
    TabIndex = 0
    TabOrder = 1
    Visible = False
    OnChange = hzTabsChange
    object hzTab0: TTabSheet
      Caption = 'Complete Site'
      ImageIndex = -1
    end
  end
  object wwDS1: TwwDataSource
    DataSet = wwqStkMisc
    Left = 158
    Top = 356
  end
  object wwqStkMisc: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *, (totInc + tottillvar) as DeclaredPay FROM "StkMisc" a')
    Left = 126
    Top = 356
    object wwqStkMiscSiteCode: TSmallintField
      FieldName = 'SiteCode'
    end
    object wwqStkMiscTid: TSmallintField
      FieldName = 'Tid'
    end
    object wwqStkMiscStockCode: TSmallintField
      FieldName = 'StockCode'
    end
    object wwqStkMiscHzID: TSmallintField
      FieldName = 'HzID'
    end
    object wwqStkMiscMiscBalReason1: TStringField
      FieldName = 'MiscBalReason1'
    end
    object wwqStkMiscMiscBal1: TFloatField
      FieldName = 'MiscBal1'
      DisplayFormat = '0.00'
    end
    object wwqStkMiscMiscBalReason2: TStringField
      FieldName = 'MiscBalReason2'
    end
    object wwqStkMiscMiscBal2: TFloatField
      FieldName = 'MiscBal2'
    end
    object wwqStkMiscMiscBalReason3: TStringField
      FieldName = 'MiscBalReason3'
    end
    object wwqStkMiscMiscBal3: TFloatField
      FieldName = 'MiscBal3'
    end
    object wwqStkMiscSiteManager: TStringField
      FieldName = 'SiteManager'
    end
    object wwqStkMiscStockTaker: TStringField
      FieldName = 'StockTaker'
    end
    object wwqStkMiscBanked: TFloatField
      FieldName = 'Banked'
      DisplayFormat = '0.00'
    end
    object wwqStkMiscReportHeader: TStringField
      FieldName = 'ReportHeader'
      Size = 15
    end
    object wwqStkMiscStockTypeShort: TStringField
      FieldName = 'StockTypeShort'
      Size = 5
    end
    object wwqStkMiscStockNote: TMemoField
      FieldName = 'StockNote'
      BlobType = ftMemo
    end
    object wwqStkMiscTotOpCost: TFloatField
      FieldName = 'TotOpCost'
    end
    object wwqStkMiscTotPurch: TFloatField
      FieldName = 'TotPurch'
    end
    object wwqStkMiscTotMoveCost: TFloatField
      FieldName = 'TotMoveCost'
    end
    object wwqStkMiscTotCloseCost: TFloatField
      FieldName = 'TotCloseCost'
    end
    object wwqStkMiscTotInc: TFloatField
      FieldName = 'TotInc'
      DisplayFormat = '#,0.00'
    end
    object wwqStkMiscTotNetInc: TFloatField
      FieldName = 'TotNetInc'
    end
    object wwqStkMiscTotCostVar: TFloatField
      FieldName = 'TotCostVar'
    end
    object wwqStkMiscTotProfVar: TFloatField
      FieldName = 'TotProfVar'
    end
    object wwqStkMiscTotSPCost: TFloatField
      FieldName = 'TotSPCost'
    end
    object wwqStkMiscTotConsVal: TFloatField
      FieldName = 'TotConsVal'
    end
    object wwqStkMiscTotLGW: TFloatField
      FieldName = 'TotLGW'
    end
    object wwqStkMiscTotRcpVar: TFloatField
      FieldName = 'TotRcpVar'
    end
    object wwqStkMiscTotAWvalue: TFloatField
      FieldName = 'TotAWvalue'
      DisplayFormat = '#,0.00'
    end
    object wwqStkMiscPer: TSmallintField
      FieldName = 'Per'
    end
    object wwqStkMiscLMDT: TDateTimeField
      FieldName = 'LMDT'
    end
    object wwqStkMiscextraInc: TFloatField
      FieldName = 'extraInc'
    end
    object wwqStkMiscTotTillVar: TFloatField
      FieldName = 'TotTillVar'
      DisplayFormat = '#,0.00'
    end
    object wwqStkMischzName: TStringField
      FieldName = 'hzName'
      Size = 30
    end
    object wwqStkMischzPurch: TBooleanField
      FieldName = 'hzPurch'
    end
    object wwqStkMischzSales: TBooleanField
      FieldName = 'hzSales'
    end
    object wwqStkMiscDeclaredPay: TFloatField
      FieldName = 'DeclaredPay'
      ReadOnly = True
      DisplayFormat = '#,0.00'
    end
  end
  object memoDlg: TwwMemoDialog
    DataSource = wwDS1
    DataField = 'StockNote'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    MemoAttributes = [mWordWrap]
    Caption = 'Inventory Note'
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 795
    DlgHeight = 550
    Left = 94
    Top = 356
  end
end
