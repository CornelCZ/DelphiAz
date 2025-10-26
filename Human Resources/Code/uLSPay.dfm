object fLSPay: TfLSPay
  Left = 471
  Top = 396
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Extra Payments for JHONATHANW ANDREWSSSS'
  ClientHeight = 220
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    449
    220)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 7
    Top = 5
    Width = 188
    Height = 16
    Caption = 'Extra Payments for this week:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 4
    Top = 164
    Width = 290
    Height = 50
  end
  object Label2: TLabel
    Left = 8
    Top = 156
    Width = 127
    Height = 16
    Caption = ' Payment Operations '
  end
  object Label3: TLabel
    Left = 16
    Top = 131
    Width = 96
    Height = 16
    Caption = 'Total for Week:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotPay: TLabel
    Left = 120
    Top = 130
    Width = 65
    Height = 18
    Caption = 'lblTotPay'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object wwDBGrid1: TwwDBGrid
    Left = 1
    Top = 23
    Width = 445
    Height = 105
    Selected.Strings = (
      'Value'#9'11'#9'Payment'#9#9
      'Description'#9'30'#9'Description'#9#9
      'InsDT'#9'15'#9'Inserted Date/Time'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = False
    Anchors = [akLeft, akTop, akRight]
    Color = clInactiveCaption
    DataSource = wwDataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = wwDBGrid1DblClick
  end
  object btnAdd: TBitBtn
    Left = 9
    Top = 175
    Width = 87
    Height = 34
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnEdit: TBitBtn
    Left = 105
    Top = 175
    Width = 87
    Height = 34
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btnEditClick
  end
  object btnDel: TBitBtn
    Left = 201
    Top = 175
    Width = 87
    Height = 34
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDelClick
  end
  object btnDone: TBitBtn
    Left = 312
    Top = 160
    Width = 125
    Height = 54
    Caption = 'Done'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Kind = bkOK
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 220
    Align = alClient
    TabOrder = 5
    Visible = False
    DesignSize = (
      449
      220)
    object lblPanelName: TLabel
      Left = 8
      Top = 8
      Width = 145
      Height = 19
      Caption = 'Edit Extra Payment'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 69
      Width = 315
      Height = 16
      Caption = 'Enter Extra Payment Description (max. 30 characters)'
    end
    object Label6: TLabel
      Left = 16
      Top = 125
      Width = 353
      Height = 16
      Caption = 'Enter Lump Sum Payment (no currency symbol, e.g. 530.55)'
    end
    object rbLSPay: TRadioButton
      Left = 16
      Top = 41
      Width = 150
      Height = 17
      Caption = 'Lump Sum Payment'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rbLSPayClick
    end
    object rbDays: TRadioButton
      Left = 196
      Top = 41
      Width = 92
      Height = 17
      Caption = 'No. of Days'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = rbLSPayClick
    end
    object edDesc: TEdit
      Left = 16
      Top = 86
      Width = 415
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object edValue: TEdit
      Left = 16
      Top = 142
      Width = 121
      Height = 24
      TabOrder = 4
    end
    object BitBtn1: TBitBtn
      Left = 199
      Top = 176
      Width = 110
      Height = 36
      Caption = 'OK'
      TabOrder = 5
      OnClick = BitBtn1Click
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
    object BitBtn2: TBitBtn
      Left = 327
      Top = 176
      Width = 110
      Height = 36
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 6
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object rbHours: TRadioButton
      Left = 320
      Top = 41
      Width = 98
      Height = 17
      Caption = 'No. of Hours'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = rbLSPayClick
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = wwTable1
    Left = 248
  end
  object wwTable1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'Deleted <> null'
    Filtered = True
    TableName = 'AddPay'
    Left = 192
    object wwTable1Value: TCurrencyField
      DisplayLabel = 'Payment'
      DisplayWidth = 11
      FieldName = 'Value'
    end
    object wwTable1Description: TStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Size = 30
    end
    object wwTable1InsDT: TDateTimeField
      Alignment = taRightJustify
      DisplayLabel = 'Inserted Date/Time'
      DisplayWidth = 15
      FieldName = 'InsDT'
      DisplayFormat = 'ddddd hh:nn'
    end
    object wwTable1InsBy: TStringField
      DisplayLabel = 'Inserted By'
      DisplayWidth = 10
      FieldName = 'InsBy'
      Visible = False
      Size = 10
    end
    object wwTable1SiteCode: TSmallintField
      DisplayWidth = 10
      FieldName = 'SiteCode'
      Visible = False
    end
    object wwTable1WStart: TDateField
      DisplayWidth = 10
      FieldName = 'WStart'
      Visible = False
    end
    object wwTable1SEC: TFloatField
      DisplayWidth = 10
      FieldName = 'SEC'
      Visible = False
    end
    object wwTable1Deleted: TStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      Size = 1
    end
    object wwTable1LMBy: TStringField
      DisplayWidth = 10
      FieldName = 'LMBy'
      Visible = False
      Size = 10
    end
    object wwTable1LMDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LMDT'
      Visible = False
    end
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 208
    Top = 112
  end
end
