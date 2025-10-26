object PortionIngredientDialog: TPortionIngredientDialog
  Left = 728
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ingredient Details'
  ClientHeight = 198
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IngredientNameLabel: TLabel
    Left = 101
    Top = 40
    Width = 3
    Height = 13
  end
  object IngredientTypeLabel: TLabel
    Left = 101
    Top = 62
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 61
    Top = 106
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = '* Unit:'
  end
  object Label3: TLabel
    Left = 41
    Top = 129
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = '* Quantity:'
  end
  object MinorIngredientLbl: TLabel
    Left = 49
    Top = 152
    Width = 40
    Height = 13
    Caption = 'Is Minor:'
  end
  object Label2: TLabel
    Left = 9
    Top = 40
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'Ingredient Name:'
  end
  object Label4: TLabel
    Left = 13
    Top = 62
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = 'Ingredient Type:'
  end
  object lblTitle: TLabel
    Left = 40
    Top = 3
    Width = 161
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Standard'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 34
    Top = 84
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = '* Unit Type:'
  end
  object UnitNameComboBox: TComboBox
    Left = 101
    Top = 102
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object QuantityDBEdit: TwwDBEdit
    Left = 101
    Top = 125
    Width = 73
    Height = 21
    Picture.PictureMaskFromDataSet = False
    Picture.PictureMask = '[-]{{{#[#][#][#][#][#][.#[#][#][#]]},.#[#][#][#]}}'
    Picture.AllowInvalidExit = True
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object MinorIngredientChkBx: TwwCheckBox
    Left = 101
    Top = 152
    Width = 17
    Height = 17
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    TabOrder = 7
  end
  object OkButton: TBitBtn
    Left = 81
    Top = 173
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 3
    OnClick = OkButtonClick
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
  object CancelButton: TBitBtn
    Left = 162
    Top = 173
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 4
    Kind = bkCancel
  end
  object CalcTypeComboBox: TComboBox
    Left = 101
    Top = 80
    Width = 121
    Height = 21
    Style = csDropDownList
    DropDownCount = 3
    ItemHeight = 13
    TabOrder = 0
    OnSelect = CalcTypeComboBoxSelect
  end
  object btnPreviousPortion: TBitBtn
    Left = 3
    Top = 4
    Width = 32
    Height = 25
    Caption = '&Prev'
    TabOrder = 5
    OnClick = btnPreviousPortionClick
  end
  object btnNextPortion: TBitBtn
    Left = 205
    Top = 4
    Width = 32
    Height = 25
    Caption = '&Next'
    TabOrder = 6
    OnClick = btnNextPortionClick
  end
  object PortionTypeNameQry: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'portion_type_id'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PortionTypeName, PortionTypeID'
      'FROM PortionType'
      'WHERE PortionTypeID = :portion_type_id'
      'ORDER BY PortionTypeName')
    Left = 124
    Top = 37
  end
  object SupportedPortionsQry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'parentEntityCode'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PortionType.PortionTypeName, Portions.PortionTypeID'
      'FROM Portions '
      '  INNER JOIN'
      
        '    PortionType ON Portions.PortionTypeID = PortionType.PortionT' +
        'ypeID'
      'WHERE (Portions.EntityCode = :parentEntityCode)'
      'ORDER BY PortionType.PortionTypeName')
    Left = 159
    Top = 38
  end
  object PortionTypeIDQry: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'portion_type_name'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT [PortionTypeID]'
      'FROM [PortionType]'
      'WHERE (PortionTypeName = :portion_type_name)')
    Left = 195
    Top = 37
  end
end
