object fMaintVATBand: TfMaintVATBand
  Left = 372
  Top = 178
  BorderStyle = bsDialog
  Caption = 'New Tax Rule'
  ClientHeight = 459
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 315
    Height = 459
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      315
      459)
    object Label4: TLabel
      Left = 4
      Top = 440
      Width = 128
      Height = 13
      Caption = '* denotes a mandatory field'
    end
    object btnOK: TBitBtn
      Left = 151
      Top = 428
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnClick = btnOKClick
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 234
      Top = 428
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 3
      Kind = bkCancel
    end
    object pnlHeading: TPanel
      Left = 0
      Top = 0
      Width = 315
      Height = 29
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Tax Rule'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object pnlTop: TPanel
      Left = 0
      Top = 29
      Width = 315
      Height = 392
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 12
        Top = 15
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label5: TLabel
        Left = 12
        Top = 41
        Width = 56
        Height = 13
        Caption = 'Description:'
      end
      object RateLabel: TLabel
        Left = 11
        Top = 122
        Width = 26
        Height = 13
        Caption = 'Rate:'
      end
      object lblPosName: TLabel
        Left = 12
        Top = 264
        Width = 50
        Height = 13
        Caption = 'Pos name:'
      end
      object UseTaxTableLabel: TLabel
        Left = 12
        Top = 367
        Width = 65
        Height = 13
        Caption = 'Use tax table:'
      end
      object lblInclusiveTaxRuleToApply: TLabel
        Left = 12
        Top = 235
        Width = 122
        Height = 13
        Caption = 'Inclusive tax rule to apply:'
        Enabled = False
      end
      object Bevel1: TBevel
        Left = 10
        Top = 221
        Width = 292
        Height = 2
      end
      object lblHotelDivisionAssigned: TLabel
        Left = 12
        Top = 340
        Width = 111
        Height = 13
        Caption = 'Hotel division assigned:'
        Enabled = False
      end
      object Label1: TLabel
        Left = 6
        Top = 15
        Width = 4
        Height = 13
        Caption = '*'
      end
      object Label3: TLabel
        Left = 6
        Top = 122
        Width = 4
        Height = 13
        Caption = '*'
      end
      object edtName: TEdit
        Left = 145
        Top = 11
        Width = 165
        Height = 21
        MaxLength = 10
        TabOrder = 0
      end
      object cbExclusive: TCheckBox
        Left = 10
        Top = 198
        Width = 148
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Exclusive:'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        OnClick = cbExclusiveClick
      end
      object cbPurchasedGoods: TCheckBox
        Left = 10
        Top = 172
        Width = 148
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Apply to purchased goods:'
        TabOrder = 4
      end
      object cbTaxOnTax: TCheckBox
        Left = 9
        Top = 147
        Width = 149
        Height = 17
        Alignment = taLeftJustify
        Caption = 'On by default:'
        TabOrder = 3
      end
      object RateEdit: TEdit
        Left = 145
        Top = 118
        Width = 73
        Height = 21
        TabOrder = 2
        OnKeyDown = RateEditKeyDown
        OnKeyPress = RateEditKeyPress
      end
      object mmPosName: TMemo
        Left = 145
        Top = 261
        Width = 73
        Height = 50
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        WordWrap = False
        OnChange = mmPosNameChange
      end
      object lkupTaxTables: TwwDBLookupCombo
        Left = 145
        Top = 363
        Width = 165
        Height = 21
        DropDownAlignment = taLeftJustify
        LookupTable = tblTaxTables
        LookupField = 'Name'
        Style = csDropDownList
        TabOrder = 7
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object cbServiceCharge: TCheckBox
        Left = 9
        Top = 315
        Width = 149
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Service charge:'
        Enabled = False
        TabOrder = 8
        OnClick = cbServiceChargeClick
      end
      object luSubjectToTax: TwwDBLookupCombo
        Left = 145
        Top = 231
        Width = 165
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'VAT Band Name'#9'10'#9'VAT Band Name'#9#9)
        LookupTable = qrySubjectToTax
        LookupField = 'VAT Band Name'
        Style = csDropDownList
        Enabled = False
        TabOrder = 9
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object cboHotelDivisionAssigned: TwwDBLookupCombo
        Left = 145
        Top = 336
        Width = 165
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'25'#9'Name'#9'T'#9)
        DataField = 'HotelDivision'
        LookupTable = qryHotelDivisions
        LookupField = 'HotelDivisionID'
        Enabled = False
        TabOrder = 10
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object DescriptionMemo: TMemo
        Left = 144
        Top = 36
        Width = 165
        Height = 77
        MaxLength = 250
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
  end
  object tblTaxRules: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'TaxRules'
    Left = 208
    Top = 215
  end
  object qrySubjectToTax: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select [Index No], [VAT Band Name]'
      'from TaxRules'
      'where ExclusiveTax = 0'
      'union'
      'select NULL, '#39'<None>'#39
      'order by [VAT Band Name]')
    Left = 240
    Top = 215
  end
  object tblTaxTables: TADOTable
    Connection = dmADO.AztecConn
    AfterOpen = tblTaxTablesAfterOpen
    TableName = 'ThemeTaxTable'
    Left = 176
    Top = 215
    object tblTaxTablesTaxTableID: TIntegerField
      FieldName = 'TaxTableID'
    end
    object tblTaxTablesName: TStringField
      FieldName = 'Name'
      Size = 50
    end
  end
  object qryHotelDivisions: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select HotelDivisionID, Name'
      'From ThemeHotelDivision')
    Left = 273
    Top = 215
  end
end
