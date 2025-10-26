object EmployeeBreaksForm: TEmployeeBreaksForm
  Left = 488
  Top = 389
  Width = 250
  Height = 205
  BorderIcons = [biSystemMenu]
  Caption = 'Break Times'
  Color = clBtnFace
  Constraints.MaxWidth = 250
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    242
    178)
  PixelsPerInch = 96
  TextHeight = 13
  object lblShiftTimes: TLabel
    Left = 98
    Top = 8
    Width = 3
    Height = 13
  end
  object lblEmployeeDetails: TLabel
    Left = 0
    Top = 6
    Width = 242
    Height = 13
    Alignment = taCenter
    Caption = '<Employee Name>  ( 00:00 to 00:00 )'
    Constraints.MinWidth = 242
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalBreakTimeTitle: TLabel
    Left = 56
    Top = 124
    Width = 84
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Total Break Time:'
  end
  object lblTotalBreakTimeValue: TLabel
    Left = 147
    Top = 124
    Width = 31
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'hh:mm'
  end
  object Bevel1: TBevel
    Left = 6
    Top = 139
    Width = 227
    Height = 2
    Anchors = [akLeft, akBottom]
  end
  object Bevel2: TBevel
    Left = 6
    Top = 22
    Width = 227
    Height = 2
  end
  object DBGrid: TFlexiDBGrid
    Left = 6
    Top = 34
    Width = 139
    Height = 82
    Anchors = [akLeft, akTop, akBottom]
    DataSource = dsEmployeeBreaks
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColExit = DBGridColExit
    OnExit = DBGridColExit
    SelectedField = fldStartTime
    Columns = <
      item
        Expanded = False
        FieldName = 'StartTime'
        Title.Caption = 'Break Start'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Duration'
        Visible = True
      end>
  end
  object btnInsert: TBitBtn
    Left = 159
    Top = 34
    Width = 75
    Height = 25
    Caption = '&Insert'
    TabOrder = 1
    OnClick = btnInsertClick
  end
  object btnDelete: TBitBtn
    Left = 159
    Top = 66
    Width = 75
    Height = 25
    Caption = '&Delete'
    TabOrder = 2
    OnClick = btnDeleteClick
  end
  object btnOK: TBitBtn
    Left = 6
    Top = 147
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&OK'
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 159
    Top = 147
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object tblEmployeeBreaks: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = '[Deleted] = 0'
    Filtered = True
    AfterPost = tblEmployeeBreaksAfterPost
    CommandText = '#EmployeeBreaks'
    CommandType = cmdTable
    IndexFieldNames = 'StartTime'
    Parameters = <>
    Left = 16
    Top = 72
    object fldStartTime: TStringField
      FieldName = 'StartTime'
      OnValidate = ValidateTime
      EditMask = '!90:00;1; '
      Size = 5
    end
    object fldDuration: TStringField
      FieldName = 'Duration'
      OnValidate = ValidateTime
      EditMask = '!00:00;1; '
      Size = 5
    end
    object fldBreakStartDate: TDateTimeField
      FieldName = 'BreakStartDate'
    end
    object fldBreakEndDate: TDateTimeField
      FieldName = 'BreakEndDate'
    end
    object fldTempID: TIntegerField
      FieldName = 'TempID'
    end
    object fldBreakID: TIntegerField
      FieldName = 'BreakID'
    end
    object fldDeleted: TBooleanField
      FieldName = 'Deleted'
    end
    object fldDurationMins: TIntegerField
      FieldName = 'DurationMins'
    end
  end
  object dsEmployeeBreaks: TDataSource
    DataSet = tblEmployeeBreaks
    Left = 48
    Top = 72
  end
  object ADOCommand: TADOCommand
    CommandTimeout = 0
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 80
    Top = 72
  end
  object ADODataSet: TADODataSet
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 112
    Top = 72
  end
end
