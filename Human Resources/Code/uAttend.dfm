object fAttend: TfAttend
  Left = 292
  Top = 195
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Employee Attendance for week:'
  ClientHeight = 513
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 0
    Width = 792
    Height = 449
    ControlType.Strings = (
      'disp7;CustomEdit;lookAttCodes;F'
      'disp1;CustomEdit;lookAttCodes;F'
      'disp2;CustomEdit;lookAttCodes;F'
      'disp3;CustomEdit;lookAttCodes;F'
      'disp4;CustomEdit;lookAttCodes;F'
      'disp5;CustomEdit;lookAttCodes;F'
      'disp6;CustomEdit;lookAttCodes;F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    OnCellChanged = wwDBGrid1CellChanged
    FixedCols = 2
    ShowHorzScrollBar = True
    Align = alTop
    DataSource = dsEmpAtTmp
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgEnterToTab]
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
    OnKeyDown = wwDBGrid1KeyDown
  end
  object lookAttCodes: TwwDBLookupCombo
    Left = 358
    Top = 72
    Width = 79
    Height = 21
    ControlInfoInDataset = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Display'#9'8'#9'Display'#9'F')
    LookupTable = wwqAttCodes
    LookupField = 'AttCode'
    Options = [loRowLines]
    Style = csDropDownList
    DropDownCount = 12
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
    OnCloseUp = lookAttCodesCloseUp
  end
  object btnSave: TBitBtn
    Left = 8
    Top = 456
    Width = 213
    Height = 47
    Caption = 'Save Changes && Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
    OnClick = btnSaveClick
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
  object btnDiscard: TBitBtn
    Left = 232
    Top = 456
    Width = 233
    Height = 47
    Caption = 'Discard Changes && Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
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
  object btnSign: TBitBtn
    Left = 536
    Top = 456
    Width = 209
    Height = 47
    Caption = 'Sign Off Week'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 8
    ParentFont = False
    TabOrder = 4
    OnClick = btnSignClick
  end
  object dsEmpAtTmp: TwwDataSource
    DataSet = wwtEmpAtTmp
    Left = 336
    Top = 208
  end
  object wwtEmpAtTmp: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    AfterPost = wwtEmpAtTmpAfterPost
    TableName = '[#EmpAtTmp]'
    Left = 432
    Top = 224
    object wwtEmpAtTmpFName: TStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 15
      FieldName = 'FName'
    end
    object wwtEmpAtTmpLName: TStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 17
      FieldName = 'LName'
    end
    object wwtEmpAtTmpdisp1: TStringField
      DisplayLabel = 'Monday'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp1'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D1'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp2: TStringField
      DisplayLabel = 'Tuesday'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp2'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D2'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp3: TStringField
      DisplayLabel = 'Wed 08/08'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp3'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D3'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp4: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp4'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D4'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp5: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp5'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D5'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp6: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp6'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D6'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpdisp7: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'disp7'
      LookupDataSet = wwqAttCodes
      LookupKeyFields = 'AttCode'
      LookupResultField = 'Display'
      KeyFields = 'D7'
      Size = 10
      Lookup = True
    end
    object wwtEmpAtTmpD3: TStringField
      DisplayLabel = 'Wednesday'
      DisplayWidth = 10
      FieldName = 'D3'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD4: TStringField
      DisplayLabel = 'Thursday'
      DisplayWidth = 10
      FieldName = 'D4'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD5: TStringField
      DisplayLabel = 'Friday'
      DisplayWidth = 10
      FieldName = 'D5'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD6: TStringField
      DisplayLabel = 'Saturday'
      DisplayWidth = 10
      FieldName = 'D6'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD7: TStringField
      DisplayLabel = 'Sunday'
      DisplayWidth = 10
      FieldName = 'D7'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD1: TStringField
      DisplayLabel = 'Monday'
      DisplayWidth = 10
      FieldName = 'D1'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpD2: TStringField
      DisplayLabel = 'Tuesday'
      DisplayWidth = 10
      FieldName = 'D2'
      Visible = False
      Size = 2
    end
    object wwtEmpAtTmpSiteCode: TSmallintField
      FieldName = 'SiteCode'
      Visible = False
    end
    object wwtEmpAtTmpUserId: TLargeintField
      DisplayWidth = 15
      FieldName = 'UserId'
      Visible = False
    end
  end
  object wwqAttCodes: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from attcodes'
      'order by display')
    Left = 328
    Top = 152
  end
end
