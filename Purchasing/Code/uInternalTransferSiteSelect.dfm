object frmInternalTransferSiteSelect: TfrmInternalTransferSiteSelect
  Left = 450
  Top = 399
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Internal Transfer Site Select'
  ClientHeight = 164
  ClientWidth = 265
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
  object btnPanelButtons: TPanel
    Left = 0
    Top = 123
    Width = 265
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      265
      41)
    object btnOK: TButton
      Left = 99
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnClose: TButton
      Left = 180
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlFormPanel: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 123
    Align = alClient
    TabOrder = 1
    object lblTransferTo: TLabel
      Left = 25
      Top = 32
      Width = 58
      Height = 13
      Caption = 'Transfer To:'
    end
    object lblDeliveryDate: TLabel
      Left = 16
      Top = 72
      Width = 67
      Height = 13
      Caption = 'Delivery Date:'
    end
    object dtpDeliveryDate: TDateTimePicker
      Left = 92
      Top = 68
      Width = 145
      Height = 21
      CalAlignment = dtaLeft
      Date = 38406.7110312963
      Time = 38406.7110312963
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object cbValidTransferSites: TwwDBLookupCombo
      Left = 92
      Top = 26
      Width = 145
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'SiteName'#9'20'#9'SiteName'#9'F'#9
        'ID'#9'10'#9'ID'#9#9)
      LookupTable = ADOqryValidTransferSites
      LookupField = 'ID'
      Style = csDropDownList
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  object ADOqryValidTransferSites: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ValidTransferSites'
      'where deleted = 0')
  end
end
