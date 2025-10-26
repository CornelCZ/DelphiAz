object frmUnacceptedInternalTransferDetail: TfrmUnacceptedInternalTransferDetail
  Left = 371
  Top = 305
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Unaccepted Transfer Details'
  ClientHeight = 459
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFormPanel: TPanel
    Left = 0
    Top = 0
    Width = 504
    Height = 89
    Align = alTop
    TabOrder = 0
    DesignSize = (
      504
      89)
    object lblTransferID: TLabel
      Left = 27
      Top = 14
      Width = 53
      Height = 13
      Caption = 'Transfer ID'
    end
    object lblSiteCode: TLabel
      Left = 252
      Top = 52
      Width = 46
      Height = 13
      Caption = 'Site Code'
    end
    object lblSenderName: TLabel
      Left = 42
      Top = 52
      Width = 37
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Sent By'
    end
    object lblLMDT: TLabel
      Left = 235
      Top = 14
      Width = 63
      Height = 13
      Caption = 'Last Modified'
    end
    object edTransferID: TEdit
      Left = 93
      Top = 10
      Width = 121
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edTransferID'
    end
    object edName: TEdit
      Left = 93
      Top = 48
      Width = 121
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edName'
    end
    object edLMDT: TEdit
      Left = 312
      Top = 10
      Width = 121
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      Text = 'edLMDT'
    end
    object edSiteCode: TEdit
      Left = 312
      Top = 48
      Width = 121
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      Text = 'edSiteCode'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 504
    Height = 329
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object wwDBGridTransferDetail: TwwDBGrid
      Left = 1
      Top = 1
      Width = 502
      Height = 327
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsTransferDetail
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
  end
  object pnlButtonPanel: TPanel
    Left = 0
    Top = 418
    Width = 504
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      504
      41)
    object btnClose: TButton
      Left = 411
      Top = 8
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'Clo&se'
      ModalResult = 1
      TabOrder = 0
    end
    object btnAccept: TButton
      Left = 319
      Top = 8
      Width = 75
      Height = 25
      Anchors = []
      Caption = '&Accept'
      TabOrder = 1
      OnClick = btnAcceptClick
    end
  end
  object dsTransferDetail: TDataSource
    DataSet = ADOspTransferDetail
    Left = 176
    Top = 96
  end
  object ADOspTransferDetail: TADOStoredProc
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    ProcedureName = 'sp_getInternalTransferDetailRecs;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@transferID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@siteCode'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end
      item
        Name = '@S_R'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    Left = 144
    Top = 96
  end
  object ADOspAcceptTransfer: TADOStoredProc
    Connection = dmADO.AztecConn
    ProcedureName = 'sp_AcceptReceivedTransfer;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@transferID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@siteCode'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end
      item
        Name = '@acceptedBy'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@dateAccepted'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 304
    Top = 408
  end
  object ADOqryGetSiteIP: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'sitename'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'Select * From ValidTransferSites'
      'Where SiteName = :sitename')
    Left = 456
    Top = 56
  end
end
