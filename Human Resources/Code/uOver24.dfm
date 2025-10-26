object fOver24: TfOver24
  Left = 309
  Top = 195
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Worked Shifts over 24 hours...'
  ClientHeight = 317
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 57
    Width = 673
    Height = 199
    ControlType.Strings = (
      'Match;CheckBox;Y;N')
    Selected.Strings = (
      'EmpFName'#9'10'#9'First Name'#9#9
      'EmpLName'#9'10'#9'Last Name'#9#9
      'JobName'#9'14'#9'Job Name'#9#9
      'Break'#9'5'#9'Break'#9#9
      'totHrs'#9'7'#9'Total Hrs.'#9#9
      'Din'#9'10'#9'Date in'#9#9
      'Tin'#9'6'#9'Time in'#9#9
      'Dout'#9'10'#9'Date out'#9#9
      'Tout'#9'6'#9'Time out'#9#9
      'Match'#9'5'#9'Import'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 4
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
    Align = alClient
    DataSource = wwDataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgWordWrap]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 13
      Height = 22
      AllowAllUp = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 671
      Height = 55
      Align = alClient
      Caption = 
        'All shifts showing here have not been imported in the Employee S' +
        'ystem. There are three things you can do:'#13#10'1 -  Check the "Impor' +
        't" field and change the Date/Time fields for shifts you want to ' +
        'import. When done click "Import Checked Shifts".'#13#10'2 - Delete the' +
        ' currently selected shift.'#13#10'3 - Any shifts not imported remainin' +
        'g on the grid when this window is closed will still be here next' +
        ' time Aztec Time & Attendance is started.'
      Color = clInactiveCaption
      Font.Charset = ANSI_CHARSET
      Font.Color = clInactiveCaptionText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 256
    Width = 673
    Height = 61
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 8
      Top = 9
      Width = 153
      Height = 44
      Caption = 'Delete Shift'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 264
      Top = 9
      Width = 193
      Height = 44
      Caption = 'Import All Checked Shifts'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 560
      Top = 9
      Width = 105
      Height = 44
      Caption = 'Close'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = wwTable1
    Left = 64
    Top = 152
  end
  object wwTable1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'Solved = '#39'N'#39
    Filtered = True
    OnCalcFields = wwTable1CalcFields
    TableName = 'EOver24h'
    Left = 32
    Top = 152
    object wwTable1EmpFName: TStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'EmpFName'
      LookupDataSet = dMod1.wwtac_User
      LookupKeyFields = 'Id'
      LookupResultField = 'FirstName'
      KeyFields = 'SEC'
      Size = 10
      Lookup = True
    end
    object wwTable1EmpLName: TStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'EmpLName'
      LookupDataSet = dMod1.wwtac_User
      LookupKeyFields = 'Id'
      LookupResultField = 'LastName'
      KeyFields = 'SEC'
      Size = 10
      Lookup = True
    end
    object wwTable1JobName: TStringField
      DisplayLabel = 'Job Name'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'JobName'
      LookupDataSet = dMod1.wwtac_Role
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'Jobid'
      Size = 15
      Lookup = True
    end
    object wwTable1Break: TTimeField
      DisplayWidth = 5
      FieldName = 'Break'
      DisplayFormat = 'hh:nn'
    end
    object wwTable1totHrs: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Total Hrs.'
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'totHrs'
      Size = 7
      Calculated = True
    end
    object wwTable1Din: TDateField
      DisplayLabel = 'Date in'
      DisplayWidth = 10
      FieldName = 'Din'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object wwTable1Tin: TTimeField
      DisplayLabel = 'Time in'
      DisplayWidth = 6
      FieldName = 'Tin'
      DisplayFormat = 'hh:nn'
    end
    object wwTable1Dout: TDateField
      DisplayLabel = 'Date out'
      DisplayWidth = 10
      FieldName = 'Dout'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object wwTable1Tout: TTimeField
      DisplayLabel = 'Time out'
      DisplayWidth = 6
      FieldName = 'Tout'
      DisplayFormat = 'hh:nn'
    end
    object wwTable1Match: TStringField
      DisplayLabel = 'Import'
      DisplayWidth = 5
      FieldName = 'Match'
      Size = 1
    end
    object wwTable1SEC: TFloatField
      DisplayWidth = 10
      FieldName = 'SEC'
      Visible = False
    end
    object wwTable1Jobid: TSmallintField
      DisplayWidth = 10
      FieldName = 'Jobid'
      Visible = False
    end
    object wwTable1Solved: TStringField
      DisplayWidth = 1
      FieldName = 'Solved'
      Visible = False
      Size = 1
    end
    object wwTable1Site: TSmallintField
      FieldName = 'Site'
      Visible = False
    end
    object wwTable1ClockIn: TDateTimeField
      FieldName = 'ClockIn'
      Visible = False
    end
    object wwTable1ClockOut: TDateTimeField
      FieldName = 'ClockOut'
      Visible = False
    end
    object wwTable1InsDT: TDateTimeField
      FieldName = 'InsDT'
      Visible = False
    end
    object wwTable1SolvedDT: TDateTimeField
      FieldName = 'SolvedDT'
      Visible = False
    end
    object wwTable1SolvedBy: TStringField
      FieldName = 'SolvedBy'
      Visible = False
      Size = 10
    end
    object wwTable1ClockedPaySchemeVersionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClockedPaySchemeVersionId'
      Visible = False
    end
    object wwTable1ClockedUserPayRateOverrideVersionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClockedUserPayRateOverrideVersionID'
      Visible = False
    end
  end
  object wwtRun: TADOTable
    Connection = dmADO.AztecConn
    Left = 288
    Top = 80
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 192
    Top = 72
  end
end
