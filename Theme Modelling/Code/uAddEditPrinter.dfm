inherited frmAddEditPrinter: TfrmAddEditPrinter
  Left = 524
  Top = 261
  HelpContext = 5022
  Caption = 'Device Setup'
  ClientHeight = 456
  ClientWidth = 374
  Constraints.MaxHeight = 600
  Constraints.MinHeight = 402
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label24: TLabel [0]
    Left = 4
    Top = 50
    Width = 63
    Height = 13
    Caption = 'Display Unit :'
  end
  object Label10: TLabel [1]
    Left = 4
    Top = 20
    Width = 76
    Height = 13
    Caption = 'Decimal Places :'
  end
  inherited GroupBox1: TGroupBox
    Width = 374
    Height = 422
    DesignSize = (
      374
      422)
    object lblName: TLabel [0]
      Left = 8
      Top = 15
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object lblPrinterType: TLabel [1]
      Left = 8
      Top = 45
      Width = 61
      Height = 13
      Caption = 'Device type:'
    end
    object lblNameReq: TLabel [2]
      Left = 359
      Top = 15
      Width = 6
      Height = 13
      Caption = '*'
    end
    object Label1: TLabel [3]
      Left = 359
      Top = 46
      Width = 6
      Height = 13
      Caption = '*'
    end
    inherited lblStarDesc: TLabel
      Left = 246
      Top = 400
    end
    object DBedtName: TDBEdit
      Left = 95
      Top = 11
      Width = 259
      Height = 21
      DataField = 'Name'
      DataSource = dsEditRec
      MaxLength = 20
      TabOrder = 0
      OnKeyPress = DBedtNameKeyPress
    end
    object pcPortOrIPSettings: TPageControl
      Left = 4
      Top = 65
      Width = 349
      Height = 82
      ActivePage = tsIPSettings
      MultiLine = True
      TabHeight = 16
      TabIndex = 1
      TabOrder = 2
      TabPosition = tpRight
      TabStop = False
      object tsPortSettings: TTabSheet
        Caption = 'tsPortSettings'
        object lbValidPorts: TLabel
          Left = 0
          Top = 27
          Width = 313
          Height = 34
          AutoSize = False
          Caption = 'Valid ports:'#10#13'1, 2, 3, 4, 5, 6'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 215
          Top = 6
          Width = 6
          Height = 13
          Caption = '*'
        end
        object lblPortNumber: TLabel
          Left = 0
          Top = 4
          Width = 63
          Height = 13
          Caption = 'Port number:'
        end
        object DBEdtPortNo: TDBEdit
          Left = 87
          Top = 0
          Width = 121
          Height = 21
          DataField = 'PortNumber'
          DataSource = dsEditRec
          MaxLength = 2
          TabOrder = 0
          OnKeyPress = DBedtNameKeyPress
        end
      end
      object tsIPSettings: TTabSheet
        Caption = 'tsIPSettings'
        ImageIndex = 1
        object Label6: TLabel
          Left = 215
          Top = 6
          Width = 6
          Height = 13
          Caption = '*'
        end
        object Label7: TLabel
          Left = 0
          Top = 4
          Width = 56
          Height = 13
          Caption = 'IP Address:'
        end
        object Label8: TLabel
          Left = 215
          Top = 35
          Width = 6
          Height = 13
          Caption = '*'
        end
        object Label9: TLabel
          Left = 0
          Top = 33
          Width = 76
          Height = 13
          Caption = 'IP Port number:'
        end
        object DBEditIPAddress: TDBEdit
          Left = 87
          Top = 0
          Width = 121
          Height = 21
          DataField = 'IPAddress'
          DataSource = dsEditRec
          MaxLength = 15
          TabOrder = 0
          OnKeyPress = DBedtNameKeyPress
        end
        object DBEditIPPort: TDBEdit
          Left = 87
          Top = 29
          Width = 121
          Height = 21
          DataField = 'IPPort'
          DataSource = dsEditRec
          MaxLength = 5
          TabOrder = 1
          OnKeyPress = DBedtNameKeyPress
        end
        object pnlCashDrawer: TPanel
          Left = 0
          Top = 56
          Width = 109
          Height = 17
          BevelOuter = bvNone
          TabOrder = 2
          object DBcbxCashDrawer: TDBCheckBox
            Left = 0
            Top = 0
            Width = 106
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Has Cash Drawer:'
            DataField = 'HasCashDrawer'
            DataSource = dsEditRec
            TabOrder = 0
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
        end
      end
    end
    object dbLkCbxPrinterType: TwwDBLookupCombo
      Left = 95
      Top = 41
      Width = 259
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PrinterTypeName'#9'50'#9'PrinterTypeName'#9#9)
      DataField = 'PrinterType'
      DataSource = dsEditRec
      LookupTable = dmADO.qPrinterTypes
      LookupField = 'PrinterTypeID'
      Style = csDropDownList
      DropDownWidth = 121
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = dbLkCbxPrinterTypeCloseUp
      OnKeyUp = dbLkCbxPrinterTypeKeyUp
    end
    object pcScaleOrOtherSettings: TPageControl
      Left = 4
      Top = 147
      Width = 349
      Height = 246
      ActivePage = tsBottomControls
      MultiLine = True
      TabIndex = 0
      TabOrder = 3
      TabPosition = tpRight
      object tsBottomControls: TTabSheet
        Caption = 'tsBottomControls'
        object lblEposName1: TLabel
          Left = 0
          Top = 4
          Width = 74
          Height = 13
          Caption = 'Button name 1:'
        end
        object lblEposName2: TLabel
          Left = 0
          Top = 27
          Width = 74
          Height = 13
          Caption = 'Button name 2:'
        end
        object lblEposName3: TLabel
          Left = 0
          Top = 50
          Width = 74
          Height = 13
          Caption = 'Button name 3:'
        end
        object lblREdirectionalPrinterID: TLabel
          Left = 0
          Top = 77
          Width = 83
          Height = 13
          Caption = 'Re-direct printer:'
        end
        object lblTimeout: TLabel
          Left = 0
          Top = 95
          Width = 89
          Height = 30
          AutoSize = False
          Caption = 'Change paper timeout (ms):'
          WordWrap = True
        end
        object lblTimeoutRequired: TLabel
          Left = 215
          Top = 104
          Width = 6
          Height = 13
          Caption = '*'
        end
        object lblNoOrderTickets: TLabel
          Left = 0
          Top = 127
          Width = 139
          Height = 13
          Caption = 'No. of Order Tickets to print:'
        end
        object lblCustomDeviceID: TLabel
          Left = 0
          Top = 204
          Width = 89
          Height = 13
          Caption = 'Custom Device ID:'
        end
        object DBEdtEposName1: TDBEdit
          Left = 87
          Top = 0
          Width = 121
          Height = 21
          DataField = 'EposName1'
          DataSource = dsEditRec
          TabOrder = 0
          OnKeyPress = DBedtNameKeyPress
        end
        object DBEdtEposName2: TDBEdit
          Left = 87
          Top = 23
          Width = 121
          Height = 21
          DataField = 'EposName2'
          DataSource = dsEditRec
          TabOrder = 1
          OnKeyPress = DBedtNameKeyPress
        end
        object DBEdtEposName3: TDBEdit
          Left = 87
          Top = 46
          Width = 121
          Height = 21
          DataField = 'EposName3'
          DataSource = dsEditRec
          TabOrder = 2
          OnKeyPress = DBedtNameKeyPress
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 87
          Top = 73
          Width = 121
          Height = 21
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'name'#9'50'#9'name'#9#9)
          DataField = 'RedirectionPrinterId'
          DataSource = dsEditRec
          LookupTable = dmADO.qRedirectPrinterLookup
          LookupField = 'printerID'
          Style = csDropDownList
          DropDownWidth = 121
          TabOrder = 3
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
          ShowMatchText = True
          OnKeyPress = DBedtNameKeyPress
        end
        object edTimeout: TDBEdit
          Left = 87
          Top = 99
          Width = 121
          Height = 21
          DataField = 'ChangePaperTimeout'
          DataSource = dsEditRec
          MaxLength = 6
          TabOrder = 4
          OnKeyPress = DBedtNameKeyPress
        end
        object DBCbxCompactOrderLines: TDBCheckBox
          Left = 0
          Top = 153
          Width = 175
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Compact order lines if the same:'
          DataField = 'CompactOrderLines'
          DataSource = dsEditRec
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCbxShowSeatHeaders: TDBCheckBox
          Left = 0
          Top = 168
          Width = 175
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Show seat headers:'
          DataField = 'ShowSeatHeader'
          DataSource = dsEditRec
          TabOrder = 6
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBcbxEFTPay: TDBCheckBox
          Left = 0
          Top = 183
          Width = 175
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Enable EFTPay:'
          DataField = 'EnableEFTPay'
          DataSource = dsEditRec
          TabOrder = 7
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBEdtNoOrderTickets: TDBEdit
          Left = 162
          Top = 123
          Width = 25
          Height = 21
          DataField = 'OrderTicketsToPrint'
          DataSource = dsEditRec
          MaxLength = 1
          TabOrder = 8
          OnKeyPress = DBedtNameKeyPress
        end
        object DBEditCustomDeviceID: TDBEdit
          Left = 90
          Top = 200
          Width = 121
          Height = 21
          DataField = 'CustomDeviceID'
          DataSource = dsEditRec
          TabOrder = 9
        end
      end
      object tsSiteScaleConfigs: TTabSheet
        Caption = 'tsSiteScaleConfigs'
        ImageIndex = 1
        object Label4: TLabel
          Left = 4
          Top = 70
          Width = 62
          Height = 13
          Caption = 'Display unit :'
        end
        object Label5: TLabel
          Left = 4
          Top = 40
          Width = 76
          Height = 13
          Caption = 'Decimal places :'
        end
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 230
          Height = 2
        end
        object Label11: TLabel
          Left = 0
          Top = 5
          Width = 219
          Height = 26
          Caption = 
            'The following configurations apply to all scale devices used on ' +
            'this site.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label12: TLabel
          Left = 215
          Top = 41
          Width = 6
          Height = 13
          Caption = '*'
        end
        object Label13: TLabel
          Left = 215
          Top = 71
          Width = 6
          Height = 13
          Caption = '*'
        end
        object cmScaleDecimalPlaces: TwwDBComboBox
          Left = 87
          Top = 36
          Width = 121
          Height = 21
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          DataField = 'ScaleDecimalPlaces'
          DataSource = dmADO.dsOutletConfigs
          DropDownCount = 4
          ItemHeight = 0
          Items.Strings = (
            '0'#9'0'
            '1'#9'1'
            '2'#9'2'
            '3'#9'3')
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
        object cmScaleDisplayUnit: TwwDBComboBox
          Left = 87
          Top = 66
          Width = 121
          Height = 21
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          DataField = 'ScaleDisplayUnit'
          DataSource = dmADO.dsOutletConfigs
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            'lb'#9'lb'
            'oz'#9'oz'
            'kg'#9'kg'
            'gm'#9'gm')
          Sorted = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
      end
    end
  end
  inherited Panel1: TPanel
    Top = 422
    Width = 374
    Height = 34
    DesignSize = (
      374
      34)
    inherited Button1: TButton
      Left = 209
      Top = 8
      Anchors = [akRight, akBottom]
    end
    inherited Button2: TButton
      Left = 297
      Top = 8
      Anchors = [akRight, akBottom]
    end
  end
  inherited dsEditRec: TDataSource
    Left = 40
    Top = 0
  end
  inherited ImageList1: TImageList
    Left = 256
    Top = 88
  end
end
