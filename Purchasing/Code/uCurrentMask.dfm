object frmCurrentMask: TfrmCurrentMask
  Left = 568
  Top = 243
  BorderStyle = bsDialog
  Caption = 'Set current mask'
  ClientHeight = 266
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSupplier: TLabel
    Left = 15
    Top = 12
    Width = 205
    Height = 13
    Caption = 'Select the current mask for Supplier'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 159
    Top = 234
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object MaskGrid: TwwDBGrid
    Left = 14
    Top = 57
    Width = 218
    Height = 165
    ControlType.Strings = (
      'CurrentMask;CheckBox;1;0')
    Selected.Strings = (
      'ConvertedMask'#9'30'#9'Mask'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsMasks
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 1
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object dsMasks: TDataSource
    DataSet = qryMasks
    Left = 144
    Top = 162
  end
  object qryMasks: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #TmpMask')
    Left = 39
    Top = 159
    object qryMasksSupplierName: TStringField
      FieldName = 'Supplier Name'
    end
    object qryMasksConvertedMask: TStringField
      FieldName = 'ConvertedMask'
      Size = 30
    end
    object qryMasksMask: TStringField
      FieldName = 'Mask'
      Size = 45
    end
    object qryMasksMaskID: TSmallintField
      FieldName = 'MaskID'
    end
    object qryMasksCurrentMask: TBooleanField
      FieldName = 'CurrentMask'
    end
  end
end
