object SwipeCardExceptions: TSwipeCardExceptions
  Left = 703
  Top = 316
  HelpContext = 5070
  BorderStyle = bsDialog
  Caption = 'Card Range Exceptions'
  ClientHeight = 341
  ClientWidth = 233
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
  object gridSwipeExceptions: TwwDBGrid
    Left = 8
    Top = 8
    Width = 217
    Height = 265
    ControlType.Strings = (
      'CanPayOnBarAccount;CheckBox;True;False'
      'CanSaveOnBarAccount;CheckBox;True;False'
      'AutoPrintReceipt;CheckBox;True;False')
    Selected.Strings = (
      'Value'#9'32'#9'Exception Value'#9'T')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    DataSource = dtsSwipeExceptions
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
  object btnClose: TButton
    Left = 152
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 3
  end
  object btnDelete: TButton
    Left = 122
    Top = 281
    Width = 75
    Height = 20
    Caption = 'Delete'
    TabOrder = 2
    OnClick = btnDeleteClick
  end
  object btnAdd: TButton
    Left = 36
    Top = 281
    Width = 75
    Height = 20
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object dtsSwipeExceptions: TDataSource
    DataSet = qSwipeExceptions
    Left = 40
    Top = 312
  end
  object qSwipeExceptions: TADOQuery
    Connection = dmADO_SwipeRange.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SwipeCardRangeID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT ExceptionID, SwipeCardrangeID, Value'
      'FROM ThemeSwipeCardExceptions'
      'WHERE SwipeCardRangeID = :SwipeCardRangeID'
      'ORDER BY ABS(Value)')
    Left = 8
    Top = 312
    object qSwipeExceptionsExceptionID: TLargeintField
      FieldName = 'ExceptionID'
    end
    object qSwipeExceptionsSwipeCardrangeID: TLargeintField
      FieldName = 'SwipeCardrangeID'
    end
    object qSwipeExceptionsValue: TStringField
      FieldName = 'Value'
      Size = 25
    end
  end
end
