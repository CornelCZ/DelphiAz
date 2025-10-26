inherited frmAddEditTerminal: TfrmAddEditTerminal
  Left = 656
  Top = 205
  HelpContext = 5023
  Caption = 'Site Terminal Setup'
  ClientHeight = 433
  ClientWidth = 341
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 341
    Height = 404
    DesignSize = (
      341
      404)
    object lblName: TLabel [0]
      Left = 16
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object lblIPAddress: TLabel [1]
      Left = 16
      Top = 48
      Width = 56
      Height = 13
      Caption = 'IP Address:'
    end
    object lblEposDeviceID: TLabel [2]
      Left = 16
      Top = 120
      Width = 50
      Height = 13
      Caption = 'Device ID:'
    end
    object Label1: TLabel [3]
      Left = 277
      Top = 26
      Width = 6
      Height = 13
      Caption = '*'
    end
    object Label2: TLabel [4]
      Left = 277
      Top = 26
      Width = 6
      Height = 13
      Caption = '*'
    end
    object lblForceIPAddress: TLabel [5]
      Left = 277
      Top = 50
      Width = 6
      Height = 13
      Caption = '*'
    end
    inherited lblStarDesc: TLabel
      Left = 220
      Top = 436
    end
    object lblHardwareType: TLabel
      Left = 16
      Top = 144
      Width = 78
      Height = 13
      Caption = 'Hardware Type:'
    end
    object lblForceSubnet: TLabel
      Left = 277
      Top = 74
      Width = 6
      Height = 13
      Caption = '*'
    end
    object lblSubnetmask: TLabel
      Left = 16
      Top = 72
      Width = 65
      Height = 13
      Caption = 'Subnet Mask:'
    end
    object lblGatewayIP: TLabel
      Left = 16
      Top = 96
      Width = 60
      Height = 13
      Caption = 'Gateway IP:'
    end
    object lblForceGateway: TLabel
      Left = 277
      Top = 98
      Width = 6
      Height = 13
      Caption = '*'
    end
    object Label8: TLabel
      Left = 277
      Top = 122
      Width = 6
      Height = 13
      Caption = '*'
    end
    object Label9: TLabel
      Left = 277
      Top = 144
      Width = 6
      Height = 13
      Caption = '*'
    end
    object lblScreenInterfaceID: TLabel
      Left = 16
      Top = 168
      Width = 112
      Height = 13
      Caption = 'Hardware Screen Size: '
    end
    object Label7: TLabel
      Left = 277
      Top = 168
      Width = 6
      Height = 13
      Caption = '*'
    end
    object cmbbxKioskUser: TwwDBLookupCombo
      Left = 152
      Top = 165
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'RegisterName'#9'50'#9'RegisterName'#9#9)
      DataField = 'Kiosk_SEC'
      DataSource = dsEditRec
      LookupTable = dmADO.qGetEmployees
      LookupField = 'Kiosk_SEC'
      Style = csDropDownList
      DropDownWidth = 121
      TabOrder = 7
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object cmbbxScreenInterfaceID: TwwDBComboBox
      Left = 152
      Top = 165
      Width = 121
      Height = 21
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'ScreenInterfaceID'
      DataSource = dsEditRec
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        '12" Screen'#9'0'
        '15" Screen'#9'1')
      ItemIndex = 0
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
    end
    object DBEdtName: TDBEdit
      Left = 152
      Top = 20
      Width = 122
      Height = 21
      Hint = 
        'Please note that terminal/server names may not contain '#39'/'#39','#39':'#39','#39 +
        '?'#39','#39'"'#39','#39'<'#39', '#39'>'#39' or '#39'|'#39'.'
      DataField = 'Name'
      DataSource = dsEditRec
      MaxLength = 20
      TabOrder = 0
      OnChange = DBEdtNameChange
      OnKeyPress = DBEdtNameKeyPress
    end
    object DBEdtIPAddress: TDBEdit
      Left = 152
      Top = 44
      Width = 121
      Height = 21
      DataField = 'IPAddress'
      DataSource = dsEditRec
      MaxLength = 15
      TabOrder = 1
      OnKeyPress = DBEdtNameKeyPress
    end
    object dbEdtEposDeviceID: TDBEdit
      Left = 152
      Top = 116
      Width = 121
      Height = 21
      DataField = 'EPoSDeviceID'
      DataSource = dsEditRec
      MaxLength = 5
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      OnKeyPress = dbEdtEposDeviceIDKeyPress
    end
    object cmbbxHardwareType: TwwDBComboBox
      Left = 152
      Top = 140
      Width = 121
      Height = 21
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'HardwareType'
      DataSource = dsEditRec
      DropDownCount = 8
      ItemHeight = 0
      ParentShowHint = False
      ShowHint = True
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
      OnChange = cmbbxHardwareTypeChange
    end
    object DBEditSubnetMask: TDBEdit
      Left = 152
      Top = 68
      Width = 121
      Height = 21
      DataField = 'SubnetMask'
      DataSource = dsEditRec
      MaxLength = 15
      TabOrder = 2
    end
    object DBEditGatewayIP: TDBEdit
      Left = 152
      Top = 92
      Width = 121
      Height = 21
      DataField = 'GatewayIP'
      DataSource = dsEditRec
      MaxLength = 15
      TabOrder = 3
    end
    object pnladditional: TPanel
      Left = 8
      Top = 161
      Width = 321
      Height = 203
      BevelOuter = bvNone
      TabOrder = 8
      object LblPosCode: TLabel
        Left = 8
        Top = 8
        Width = 73
        Height = 13
        Caption = 'Terminal name:'
      end
      object lblcustDisplayType: TLabel
        Left = 8
        Top = 32
        Width = 111
        Height = 13
        Caption = 'Customer display type:'
      end
      object ResetOrderNumberLabel: TLabel
        Left = 8
        Top = 32
        Width = 120
        Height = 13
        Caption = 'Reset Acc/Ord No. Daily:'
      end
      object Label3: TLabel
        Left = 269
        Top = 8
        Width = 6
        Height = 13
        Caption = '*'
      end
      object Label4: TLabel
        Left = 8
        Top = 56
        Width = 87
        Height = 13
        Caption = 'Configuration set:'
      end
      object Label5: TLabel
        Left = 8
        Top = 128
        Width = 88
        Height = 13
        Caption = 'Scrolling Message:'
      end
      object lbScrollingMessageOverrideWarning: TLabel
        Left = 101
        Top = 124
        Width = 12
        Height = 16
        Hint = 
          'Scrolling messages for this site are currently overriden by a se' +
          'tting in Estate Setup'
        Alignment = taCenter
        AutoSize = False
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Visible = False
      end
      object lblpound: TLabel
        Left = 8
        Top = 180
        Width = 77
        Height = 13
        Caption = 'Pound ('#163') code:'
        Visible = False
      end
      object cbCustomerDisplayType: TwwDBComboBox
        Left = 144
        Top = 28
        Width = 121
        Height = 21
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DataField = 'CustomerDisplayType'
        DataSource = dsEditRec
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'None'#9'1'
          'Serial'#9'2'
          'Graphical'#9'0'
          'Serial (PTC Emulation)'#9'3'
         )
        ItemIndex = 0
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object cbTerminalName: TwwDBLookupCombo
        Left = 144
        Top = 4
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'POS Name'#9'50'#9'POS Name'#9#9)
        DataField = 'POSCode'
        DataSource = dsEditRec
        LookupTable = dmADO.qGetPoses
        LookupField = 'Pos code'
        Style = csDropDownList
        DropDownWidth = 121
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        AllowClearKey = False
      end
      object cbConfigSet: TwwDBLookupCombo
        Left = 144
        Top = 52
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'50'#9'Name'#9#9)
        DataField = 'ConfigSetID'
        DataSource = dsEditRec
        LookupTable = dmThemeData.qConfigSetsLookUp
        LookupField = 'ConfigSetID'
        Style = csDropDownList
        DropDownWidth = 121
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        AllowClearKey = False
      end
      object ResetAccountNumberCheck: TDBCheckBox
        Left = 144
        Top = 28
        Width = 17
        Height = 20
        DataField = 'ResetAccountNumber'
        DataSource = dsEditRec
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object DBMemo1: TDBMemo
        Left = 144
        Top = 128
        Width = 176
        Height = 49
        DataField = 'ScrollingMessage'
        DataSource = dsEditRec
        MaxLength = 255
        TabOrder = 4
        WantReturns = False
      end
      object DBEditPound: TDBEdit
        Left = 144
        Top = 180
        Width = 121
        Height = 21
        DataField = 'PoundCode'
        DataSource = dsEditRec
        MaxLength = 4
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        Visible = False
        OnKeyPress = DBEdtNameKeyPress
      end
      object pnlTwoDrawerMode: TPanel
        Left = 7
        Top = 80
        Width = 153
        Height = 17
        Hint = 
          'Two drawer mode is only available if:'#13#10'      - Cash Drawer track' +
          'ing is enabled for the Site and this terminal.'#13#10'      - The term' +
          'inal is not using an IP printer with an attached cash drawer.'#13#10' ' +
          '     - Once the Terminal details have been saved.'
        BevelOuter = bvNone
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        object TwoDrawerModeDBCheckBox: TDBCheckBox
          Left = 0
          Top = 1
          Width = 150
          Height = 16
          Hint = 
            'Two drawer mode is only available if:'#13#10'      - Cash Drawer track' +
            'ing is enabled for the Site and this terminal.'#13#10'      - The term' +
            'inal is not using an IP printer with an attached cash drawer.'#13#10' ' +
            '     - Once the Terminal details have been saved.'#13#10'Enabling two ' +
            'drawer mode automatically sets the config set "Allow Drawer Assi' +
            'gnment"'
          Alignment = taLeftJustify
          Caption = 'Two drawer mode:'
          DataField = 'MultiDrawerMode'
          DataSource = dsEditRec
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnClick = TwoDrawerModeDBCheckBoxClick
        end
      end
      object pnlSoloMode: TPanel
        Left = 7
        Top = 104
        Width = 153
        Height = 17
        BevelOuter = bvNone
        BiDiMode = bdRightToLeftNoAlign
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        object dbcbxSoloMode: TDBCheckBox
          Left = 0
          Top = 1
          Width = 150
          Height = 16
          Alignment = taLeftJustify
          Caption = 'Solo Mode:'
          DataField = 'SoloMode'
          DataSource = dsEditRec
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnClick = dbcbxSoloModeClick
        end
      end
    end
  end
  inherited Panel1: TPanel
    Top = 404
    Width = 341
    DesignSize = (
      341
      29)
    inherited Button1: TButton
      Left = 177
      Top = 4
      Anchors = [akRight, akBottom]
    end
    inherited Button2: TButton
      Left = 266
      Top = 4
      Anchors = [akRight, akBottom]
    end
  end
  inherited dsEditRec: TDataSource
    Left = 288
    Top = 16
  end
  inherited ImageList1: TImageList
    Left = 64
    Top = 2
  end
end
