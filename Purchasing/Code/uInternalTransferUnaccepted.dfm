object frmInternalTransferUnaccepted: TfrmInternalTransferUnaccepted
  Left = 398
  Top = 234
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Unaccepted Internal Transfers'
  ClientHeight = 536
  ClientWidth = 475
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
  object pnlButtonPanel: TPanel
    Left = 0
    Top = 498
    Width = 475
    Height = 38
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      475
      38)
    object btnClose: TButton
      Left = 377
      Top = 6
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'Clo&se'
      ModalResult = 1
      TabOrder = 0
    end
    object btnNewTransfer: TButton
      Left = 16
      Top = 7
      Width = 145
      Height = 25
      Caption = '&New Internal Transfer'
      TabOrder = 1
      OnClick = btnNewTransferClick
    end
  end
  object pnlDBGridPanel: TPanel
    Left = 0
    Top = 0
    Width = 475
    Height = 498
    Align = alClient
    TabOrder = 1
    object lblReceived: TLabel
      Left = 18
      Top = 8
      Width = 71
      Height = 19
      Caption = 'Received'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSent: TLabel
      Left = 18
      Top = 243
      Width = 35
      Height = 19
      Caption = 'Sent'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object wwDBGridTransfersReceived: TwwDBGrid
      Left = 18
      Top = 30
      Width = 439
      Height = 194
      Hint = 'Double click to view/accept the received items for this transfer'
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsTransfersReceived
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnDblClick = wwDBGridTransfersReceivedDblClick
    end
    object wwDBGridTranfersSent: TwwDBGrid
      Left = 18
      Top = 267
      Width = 439
      Height = 194
      Hint = 'Double click to view the sent items for this transfer'
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsTransfersSent
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnDblClick = wwDBGridTranfersSentDblClick
    end
    object btnViewRcvdTranferDetails: TButton
      Left = 382
      Top = 224
      Width = 75
      Height = 25
      Hint = 'View/Accept the received items for the selected transfer'
      Caption = 'View'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnViewRcvdTranferDetailsClick
    end
    object btnViewSebtTransferDetails: TButton
      Left = 382
      Top = 461
      Width = 75
      Height = 25
      Hint = 'View the sent items for the selected transfer'
      Caption = 'View'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnViewSebtTransferDetailsClick
    end
  end
  object dsTransfersReceived: TDataSource
    DataSet = ADOspGetRecvdTransfers
    Left = 96
    Top = 8
  end
  object dsTransfersSent: TDataSource
    DataSet = ADOspGetSentTransfers
    Left = 64
    Top = 232
  end
  object ADOspGetRecvdTransfers: TADOStoredProc
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    ProcedureName = 'sp_getInternalTransferMasterRecs;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@accepted'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = 'N'
      end
      item
        Name = '@S_R'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = 'R'
      end>
    Left = 128
    Top = 8
  end
  object ADOspGetSentTransfers: TADOStoredProc
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    ProcedureName = 'sp_getInternalTransferMasterRecs;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@accepted'
        Attributes = [paNullable]
        DataType = ftString
        Size = 16
        Value = 'N'
      end
      item
        Name = '@S_R'
        Attributes = [paNullable]
        DataType = ftString
        Size = 16
        Value = 'S'
      end>
    Left = 96
    Top = 232
  end
end
