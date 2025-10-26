object fPickWeek: TfPickWeek
  Left = 313
  Top = 189
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pick Week'
  ClientHeight = 488
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object btnOK: TBitBtn
    Left = 6
    Top = 448
    Width = 95
    Height = 39
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
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
  object btnCancel: TBitBtn
    Left = 116
    Top = 448
    Width = 97
    Height = 39
    TabOrder = 1
    Kind = bkCancel
  end
  object DBGrid1: TwwDBGrid
    Left = 1
    Top = 0
    Width = 217
    Height = 441
    Hint = 'Double click on required week or on OK button '
    Selected.Strings = (
      'weekStart'#9'12'#9'Week Start'
      'weekEnd'#9'12'#9'Week End'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoSearchOwnerForm, ecoDisableDateTimePicker]
    DataSource = dsRun
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = DBGrid1CalcCellColors
    OnDblClick = DBGrid1DblClick
  end
  object adoqRun: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from #PickWeekGrid'
      'order by weekStart')
    Left = 72
    Top = 424
    object adoqRunweekStart: TDateTimeField
      FieldName = 'weekStart'
    end
    object adoqRunweekEnd: TDateTimeField
      FieldName = 'weekEnd'
    end
  end
  object dsRun: TDataSource
    DataSet = adoqRun
    Left = 104
    Top = 424
  end
end
