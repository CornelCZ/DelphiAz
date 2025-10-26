object fStkutil: TfStkutil
  Left = 441
  Top = 127
  Width = 672
  Height = 431
  HelpContext = 1011
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Initialise First Stock'
  Color = clBtnFace
  Constraints.MaxWidth = 672
  Constraints.MinHeight = 430
  Constraints.MinWidth = 672
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pc1: TPageControl
    Left = 0
    Top = 0
    Width = 664
    Height = 403
    ActivePage = tabManual
    Align = alClient
    TabHeight = 3
    TabIndex = 2
    TabOrder = 0
    object tabChoice: TTabSheet
      Caption = 'tabChoice'
      object Label2: TLabel
        Left = 0
        Top = 16
        Width = 649
        Height = 310
        AutoSize = False
        Caption = 
          'This is the first ever Stock for this Thread. Every stock needs ' +
          'opening stock count/cost values. Normally these figures are take' +
          'n from the closing figures of the previous stock but in the case' +
          ' of the first stock in a thread these figures do not exist.'#13#10'The' +
          're are two choices:'#13#10'1. Import the closing stock figures from th' +
          'e (accepted) stock of another thread of the same Division (if an' +
          'y exist).'#13#10'2. Enter all opening stock/cost figures manually.'#13#10'No' +
          'te: Choice 1 will also set your new stock'#39's Start Date and Start' +
          ' Time. For choice 2 you will have to choose Start Date and Start' +
          ' Time yourself.'#13#10'Choose from the available buttons, or choose "C' +
          'ancel" if you are not ready to continue at this time.'
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object BitBtn1: TBitBtn
        Left = 8
        Top = 343
        Width = 183
        Height = 39
        Caption = '1. From another Thread'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn4: TBitBtn
        Left = 524
        Top = 343
        Width = 121
        Height = 39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Kind = bkCancel
      end
      object BitBtn3: TBitBtn
        Left = 197
        Top = 343
        Width = 143
        Height = 39
        Caption = '2. Enter Manually'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn3Click
      end
    end
    object tabThread: TTabSheet
      Caption = 'tabThread'
      ImageIndex = 2
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 140
        Height = 13
        Caption = 'Threads with available stocks'
      end
      object Label4: TLabel
        Left = 220
        Top = 2
        Width = 174
        Height = 13
        Caption = 'Select Stock to import closing figures'
      end
      object wwDBGrid2: TwwDBGrid
        Left = 1
        Top = 16
        Width = 217
        Height = 257
        Selected.Strings = (
          'TName'#9'30'#9'Thread Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsThreads
        KeyOptions = [dgEnterToTab]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
      end
      object wwDBEdit1: TwwDBEdit
        Left = 1
        Top = 280
        Width = 486
        Height = 62
        AutoSize = False
        Color = clTeal
        DataField = 'TNote'
        DataSource = dsThreads
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = True
      end
      object wwDBGrid3: TwwDBGrid
        Left = 218
        Top = 16
        Width = 420
        Height = 257
        Selected.Strings = (
          'SDate'#9'10'#9'St. Date'#9'F'
          'STime'#9'5'#9'St. Tm.'#9'F'
          'EDate'#9'10'#9'End Date'#9'F'
          'ETime'#9'5'#9'End Tm.'#9'F'
          'AccDate'#9'10'#9'Acc. Date'#9'F'
          'AccTime'#9'5'#9'Acc Tm.'#9'F'
          'StkKind'#9'10'#9'Stk Kind'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsThStocks
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
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
        Left = 376
        Top = 352
        Width = 136
        Height = 30
        Caption = 'Import Figures'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BitBtn5Click
        Glyph.Data = {
          76020000424D7602000000000000760000002800000040000000100000000100
          0400000000000002000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
          FFFF33333333333FFFFF3FFFFFFFFFFFFFFF33333333333FFFFF3FFFFFFFFF00
          000F333333333377777F3FFFFFFFFF00000F333333333377777F33FFFFFFFF08
          880F33333333337F337F33FFFFFFFF0EEE0F33333333337F337F333FFFFFFF08
          880F33333333337F337F333FFFFFFF0EEE0F33333333337F337F3333FFFFFF08
          880F33333333337FFF7F3333FFFFFF0EEE0F33333333337FFF7F33333FFFFF00
          000F333333333377777333333FFFFF00000F3333333333777773333333FFFFFF
          FFFF3333333333333F33333333FFFFFFFFFF3333333333333F333333333FFFFF
          0FFF3333333333337FF33333333FFFFF0FFF3333333333337FF333333333FFF0
          00FF33333333333777FF33333333FFF000FF33333333333777FF333333333F00
          000F33FFFFF33777777F333333333F00000F33FFFFF33777777F300000333000
          0000377777F3377777773000003330000000377777F33777777730EEE0333330
          00FF37F337F3333777F330EEE033333000FF37F337F3333777F330EEE0333330
          00FF37F337F3333777F330EEE033333000FF37F337F3333777F330EEE0333330
          00FF37FFF7F333F7773330EEE033333000FF37FFF7F333F77733300000333000
          03FF377777333777733330000033300003FF3777773337777333333333333333
          333F3333333333333333333333333333333F3333333333333333}
        NumGlyphs = 4
      end
      object BitBtn6: TBitBtn
        Left = 533
        Top = 352
        Width = 106
        Height = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        Kind = bkCancel
      end
      object cbSubOnly: TCheckBox
        Left = 8
        Top = 352
        Width = 201
        Height = 17
        Caption = 'Show only the Subordinate Thread'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = cbSubOnlyClick
      end
    end
    object tabManual: TTabSheet
      Caption = 'tabManual'
      ImageIndex = 3
      object Bevel1: TBevel
        Left = 497
        Top = 180
        Width = 152
        Height = 111
      end
      object Label5: TLabel
        Left = 497
        Top = 48
        Width = 153
        Height = 124
        AutoSize = False
        Caption = 
          'Type BOTH Opening Stock AND Opening Cost figures.'#13#10'  '#13#10'BOTH figu' +
          'res should be expressed in Stock Units.'#13#10'  '#13#10'Any figure left emp' +
          'ty will be assumed to be ZERO.'
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
      object Label6: TLabel
        Left = 502
        Top = 220
        Width = 26
        Height = 13
        Caption = 'Date:'
      end
      object Label7: TLabel
        Left = 503
        Top = 271
        Width = 26
        Height = 13
        Caption = 'Time:'
      end
      object Label8: TLabel
        Left = 501
        Top = 173
        Width = 136
        Height = 13
        Caption = 'Set Start for New Stock'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 505
        Top = 241
        Width = 123
        Height = 13
        Caption = 'Include Part Day Sales for'
      end
      object Label10: TLabel
        Left = 502
        Top = 188
        Width = 142
        Height = 28
        AutoSize = False
        Caption = 'Max. Date is 22/22/2222'#13#10'given by Last Audit Date - 3'
        Color = clInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInactiveCaptionText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object Label1: TLabel
        Left = 505
        Top = 369
        Width = 39
        Height = 13
        Caption = 'Legend:'
      end
      object Label11: TLabel
        Left = 548
        Top = 367
        Width = 97
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Prepared Item'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object wwDBGrid4: TwwDBGrid
        Left = 0
        Top = 0
        Width = 491
        Height = 390
        PictureMasks.Strings = (
          'OpCost'#9'{{{#[#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T'
          'ACount'#9'{{{#[#][#][#][#][#][.#[#]]},.#[#]}}'#9'F'#9'T')
        Selected.Strings = (
          'SubCat'#9'20'#9'Sub Category'#9#9
          'Name'#9'20'#9'Retail Name'#9#9
          'PurchUnit'#9'11'#9'Stock Unit'#9#9
          'ACount'#9'10'#9'Open Stock'#9#9
          'WasteTill'#9'10'#9'Open Cost'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 3
        ShowHorzScrollBar = True
        Align = alLeft
        DataSource = dsManual
        KeyOptions = []
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = wwDBGrid4CalcCellColors
      end
      object rgOrdManual: TRadioGroup
        Left = 497
        Top = 1
        Width = 154
        Height = 47
        Caption = ' Order By: '
        ItemIndex = 0
        Items.Strings = (
          'Sub Category'
          'Retail Name')
        TabOrder = 1
        OnClick = rgOrdManualClick
      end
      object btnAcceptChanges: TBitBtn
        Left = 502
        Top = 296
        Width = 142
        Height = 31
        Caption = 'Accept Figures'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnAcceptChangesClick
        Glyph.Data = {
          76020000424D7602000000000000760000002800000040000000100000000100
          0400000000000002000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
          FFFF33333333333FFFFF3FFFFFFFFFFFFFFF33333333333FFFFF3FFFFFFFFF00
          000F333333333377777F3FFFFFFFFF00000F333333333377777F33FFFFFFFF08
          880F33333333337F337F33FFFFFFFF0EEE0F33333333337F337F333FFFFFFF08
          880F33333333337F337F333FFFFFFF0EEE0F33333333337F337F3333FFFFFF08
          880F33333333337FFF7F3333FFFFFF0EEE0F33333333337FFF7F33333FFFFF00
          000F333333333377777333333FFFFF00000F3333333333777773333333FFFFFF
          FFFF3333333333333F33333333FFFFFFFFFF3333333333333F333333333FFFFF
          0FFF3333333333337FF33333333FFFFF0FFF3333333333337FF333333333FFF0
          00FF33333333333777FF33333333FFF000FF33333333333777FF333333333F00
          000F33FFFFF33777777F333333333F00000F33FFFFF33777777F300000333000
          0000377777F3377777773000003330000000377777F33777777730EEE0333330
          00FF37F337F3333777F330EEE033333000FF37F337F3333777F330EEE0333330
          00FF37F337F3333777F330EEE033333000FF37F337F3333777F330EEE0333330
          00FF37FFF7F333F7773330EEE033333000FF37FFF7F333F77733300000333000
          03FF377777333777733330000033300003FF3777773337777333333333333333
          333F3333333333333333333333333333333F3333333333333333}
        NumGlyphs = 4
      end
      object btnCancel: TBitBtn
        Left = 502
        Top = 331
        Width = 142
        Height = 31
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        Kind = bkCancel
      end
      object EdatePick: TDateTimePicker
        Left = 531
        Top = 217
        Width = 107
        Height = 21
        CalAlignment = dtaLeft
        Date = 37510
        Time = 37510
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnChange = EdatePickChange
      end
      object EtimePick: TDateTimePicker
        Left = 532
        Top = 267
        Width = 73
        Height = 21
        Hint = 'Only Hours and Minutes used'
        CalAlignment = dtaLeft
        Date = 36244
        Time = 36244
        DateFormat = dfShort
        DateMode = dmComboBox
        Enabled = False
        Kind = dtkTime
        ParseInput = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object partDayChk: TCheckBox
        Left = 503
        Top = 253
        Width = 122
        Height = 14
        Hint = 
          'Check this box if you want to include'#13#10'part day sales for the da' +
          'y following the'#13#10'last full day sales ('#39'End Date'#39').'
        Alignment = taLeftJustify
        Caption = '22/22/2222'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = partDayChkClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 7
    BevelOuter = bvNone
    TabOrder = 1
  end
  object adoqThr: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT distinct a.*'
      'FROM "threads" a'
      'WHERE a."division" = '#39'Food'#39
      'and a.tid in '
      '  (select distinct b.tid from stocks b where b."stockcode" >= 2)'
      'order by a.tid'
      '')
    Left = 144
    Top = 208
  end
  object dsThreads: TwwDataSource
    DataSet = adoqThr
    Left = 176
    Top = 208
  end
  object adoqThStock: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = dsThreads
    Parameters = <
      item
        Name = 'tid'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 0
      end>
    SQL.Strings = (
      'select * from Stocks where Tid = :tid'
      'and stockcode >= 2'
      'order by tid, stockcode DESC')
    Left = 232
    Top = 208
  end
  object dsThStocks: TwwDataSource
    DataSet = adoqThStock
    Left = 264
    Top = 208
  end
  object dsManual: TwwDataSource
    DataSet = adotManual
    Left = 360
    Top = 248
  end
  object adotManual: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    BeforePost = adotManualBeforePost
    AfterScroll = adotManualAfterScroll
    IndexFieldNames = 'SubCat;Name'
    TableName = 'auditcur'
    Left = 328
    Top = 248
    object adotManualSubCat: TStringField
      DisplayLabel = 'Sub Category'
      DisplayWidth = 20
      FieldName = 'SubCat'
    end
    object adotManualName: TStringField
      DisplayLabel = 'Retail Name'
      DisplayWidth = 20
      FieldName = 'Name'
    end
    object adotManualPurchUnit: TStringField
      DisplayLabel = 'Stock Unit'
      DisplayWidth = 11
      FieldName = 'PurchUnit'
      Size = 10
    end
    object adotManualACount: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Open Stock'
      DisplayWidth = 10
      FieldName = 'ACount'
      Size = 9
    end
    object adotManualWasteTill: TFloatField
      DisplayLabel = 'Open Cost'
      DisplayWidth = 10
      FieldName = 'WasteTill'
      currency = True
    end
    object adotManualOpStk: TFloatField
      DisplayLabel = 'Open Stock'
      DisplayWidth = 10
      FieldName = 'OpStk'
      Visible = False
      DisplayFormat = '0.##'
    end
    object adotManualEntityCode: TFloatField
      DisplayWidth = 10
      FieldName = 'EntityCode'
      Visible = False
    end
    object adotManualImpExRef: TStringField
      DisplayWidth = 15
      FieldName = 'ImpExRef'
      Visible = False
      Size = 15
    end
    object adotManualPurchStk: TFloatField
      DisplayWidth = 10
      FieldName = 'PurchStk'
      Visible = False
    end
    object adotManualThRedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ThRedQty'
      Visible = False
    end
    object adotManualThCloseStk: TFloatField
      DisplayWidth = 10
      FieldName = 'ThCloseStk'
      Visible = False
    end
    object adotManualActCloseStk: TFloatField
      DisplayWidth = 10
      FieldName = 'ActCloseStk'
      Visible = False
    end
    object adotManualPurchBaseU: TFloatField
      DisplayWidth = 10
      FieldName = 'PurchBaseU'
      Visible = False
    end
  end
end
