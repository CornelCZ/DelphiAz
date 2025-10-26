object BaseEdit: TBaseEdit
  Left = 522
  Top = 164
  Width = 833
  Height = 612
  HelpContext = 5002
  BorderWidth = 8
  Caption = 'Site Setup'
  Color = clBtnFace
  Constraints.MinHeight = 597
  Constraints.MinWidth = 833
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    801
    557)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = -86
    Top = 6
    Width = 297
    Height = 13
    Caption = 'Set up terminal addresses, printer addresses and print groups'
  end
  object Label9: TLabel
    Left = 16
    Top = 16
    Width = 73
    Height = 13
    Caption = 'PIN Pad Login :'
  end
  object pcBaseData: TPageControl
    Left = 0
    Top = 0
    Width = 809
    Height = 543
    ActivePage = tabSheet_Printing
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabIndex = 3
    TabOrder = 0
    OnChange = pcBaseDataChange
    OnChanging = pcBaseDataChanging
    object TabDeviceSetUp: TTabSheet
      Caption = 'Devices'
      ImageIndex = 5
      OnHide = TabDeviceSetUpHide
      OnShow = TabDeviceSetUpShow
      object pnlDevices: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 515
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object tvServerDevices: TTreeView
          Left = 0
          Top = 0
          Width = 200
          Height = 515
          Align = alClient
          HideSelection = False
          Indent = 15
          ReadOnly = True
          TabOrder = 0
          OnChange = tvServerDevicesChange
          OnCollapsing = tvServerDevicesCollapsing
          OnExpanding = tvServerDevicesExpanding
          OnMouseDown = tvServerDevicesMouseDown
        end
      end
      object pnlPeripherals: TPanel
        Left = 200
        Top = 0
        Width = 601
        Height = 515
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object grdDeviceList: TwwDBGrid
          Left = 0
          Top = 106
          Width = 601
          Height = 409
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          OnRowChanged = grdDeviceListRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = dsDeviceList
          KeyOptions = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Shell Dlg 2'
          TitleFont.Style = []
          TitleLines = 3
          TitleButtons = False
          UseTFields = False
          Visible = False
          OnDblClick = grdDeviceListDblClick
          OnMouseDown = grdDeviceListMouseDown
        end
        object pnlSelectedDetail: TPanel
          Left = 0
          Top = 0
          Width = 601
          Height = 106
          Align = alTop
          TabOrder = 1
          Visible = False
          object lblIPAddress: TLabel
            Left = 203
            Top = 33
            Width = 59
            Height = 13
            Caption = 'lblIPAddress'
            ShowAccelChar = False
          end
          object lblName: TLabel
            Left = 203
            Top = 10
            Width = 37
            Height = 13
            Caption = 'lblName'
            ShowAccelChar = False
          end
          object lblHardwaretype: TLabel
            Left = 203
            Top = 57
            Width = 79
            Height = 13
            Caption = 'lblHardwaretype'
            ShowAccelChar = False
          end
          object lblDeviceID: TLabel
            Left = 203
            Top = 81
            Width = 53
            Height = 13
            Caption = 'lblDeviceID'
            ShowAccelChar = False
          end
          object lblDeviceIdLabel: TLabel
            Left = 12
            Top = 83
            Width = 49
            Height = 13
            Caption = 'Device Id:'
          end
          object lblHardWareTypeLabel: TLabel
            Left = 12
            Top = 59
            Width = 78
            Height = 13
            Caption = 'Hardware Type:'
          end
          object lblIPAddressLabel: TLabel
            Left = 12
            Top = 35
            Width = 56
            Height = 13
            Caption = 'IP Address:'
          end
          object lblNameLabel: TLabel
            Left = 12
            Top = 11
            Width = 31
            Height = 13
            Caption = 'Name:'
          end
        end
      end
    end
    object tsPrintGroupGrid: TTabSheet
      Caption = 'Print Groups'
      ImageIndex = 3
      OnHide = tsPrintGroupGridHide
      OnShow = tsPrintGroupGridShow
      DesignSize = (
        801
        515)
      object lbPrintGroupsSelectServer: TLabel
        Left = 16
        Top = 14
        Width = 68
        Height = 13
        Caption = 'Select Server:'
      end
      object lblFilterType: TLabel
        Left = 248
        Top = 14
        Width = 98
        Height = 13
        Caption = 'Terminal Type Filter:'
      end
      object btSortByTill: TButton
        Left = 620
        Top = 8
        Width = 85
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Sort by terminal'
        TabOrder = 0
        OnClick = btSortByTillClick
      end
      object btsortbystream: TButton
        Left = 708
        Top = 8
        Width = 85
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Sort by group'
        TabOrder = 1
        OnClick = btsortbystreamClick
      end
      object cbxServerName: TwwDBLookupCombo
        Left = 87
        Top = 10
        Width = 145
        Height = 21
        DropDownAlignment = taLeftJustify
        LookupTable = qryServersForCbx
        LookupField = 'Name'
        DropDownWidth = 145
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnChange = cbxServerNameChange
        OnBeforeDropDown = cbxServerNameBeforeDropDown
      end
      object pcPrintGroupSettings: TPageControl
        Left = 8
        Top = 40
        Width = 793
        Height = 466
        ActivePage = tsPerTerminalPrintGroupSettings
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabIndex = 0
        TabOrder = 3
        OnChange = pcPrintGroupSettingsChange
        object tsPerTerminalPrintGroupSettings: TTabSheet
          Caption = 'Terminal Print Group Settings'
          ImageIndex = 1
          OnHide = tsPerTerminalPrintGroupSettingsHide
          OnShow = tsPerTerminalPrintGroupSettingsShow
          object dbgPstreams: TwwDBGrid
            Left = 0
            Top = 0
            Width = 785
            Height = 438
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            OnRowChanged = PStreamGridRowChanged
            FixedCols = 2
            ShowHorzScrollBar = True
            EditControlOptions = [ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
            Align = alClient
            DataSource = dsPstreams
            KeyOptions = []
            Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Shell Dlg 2'
            TitleFont.Style = []
            TitleLines = 12
            TitleButtons = False
            OnCalcCellColors = PStreamGridCalcCellColors
            OnDrawDataCell = PStreamGridDrawDataCell
            OnKeyPress = PStreamGridKeyPress
            OnMouseDown = PStreamGridMouseDown
            OnMouseMove = PStreamGridMouseMove
            OnDrawTitleCell = PStreamGridDrawTitleCell
            OnFieldChanged = dbgPstreamsFieldChanged
          end
        end
        object tsGlobalPrintGroupSettings: TTabSheet
          Caption = 'Global Print Group Settings'
          OnHide = tsGlobalPrintGroupSettingsHide
          OnShow = tsGlobalPrintGroupSettingsShow
          object dbgPStreams2: TwwDBGrid
            Left = 0
            Top = 0
            Width = 785
            Height = 417
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            OnRowChanged = PStreamGridRowChanged
            FixedCols = 1
            ShowHorzScrollBar = True
            EditControlOptions = [ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
            Align = alClient
            DataSource = dsPStreams2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Shell Dlg 2'
            Font.Style = []
            KeyOptions = []
            Options = [dgAlwaysShowEditor, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize, dgHideBottomDataLine]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Shell Dlg 2'
            TitleFont.Style = []
            TitleLines = 12
            TitleButtons = False
            OnCalcCellColors = PStreamGridCalcCellColors
            OnDrawDataCell = PStreamGridDrawDataCell
            OnKeyPress = PStreamGridKeyPress
            OnMouseDown = PStreamGridMouseDown
            OnMouseMove = PStreamGridMouseMove
            OnDrawTitleCell = PStreamGridDrawTitleCell
            OnFieldChanged = dbgPStreams2FieldChanged
          end
        end
      end
      object cbxTerminalFilterTypeName: TwwDBLookupCombo
        Left = 349
        Top = 10
        Width = 145
        Height = 21
        DropDownAlignment = taLeftJustify
        LookupTable = adoqThemeTerminalFilterTypeLookup
        LookupField = 'Value'
        Style = csDropDownList
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnChange = cbxTerminalFilterTypeNameChange
        OnBeforeDropDown = cbxTerminalFilterTypeNameBeforeDropDown
      end
    end
    object tsPinPadGrid: TTabSheet
      Caption = 'Pin Pad Groups'
      ImageIndex = 8
      OnHide = tsPinPadGridHide
      OnShow = tsPinPadGridShow
      DesignSize = (
        801
        515)
      object lbPinPadGroupsSelectServer: TLabel
        Left = 16
        Top = 14
        Width = 68
        Height = 13
        Caption = 'Select Server:'
      end
      object dbgPinPadGrid: TwwDBGrid
        Left = 8
        Top = 40
        Width = 788
        Height = 465
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 1
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsPinPadGrid
        KeyOptions = []
        Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
        TitleLines = 12
        TitleButtons = False
        OnDrawTitleCell = PStreamGridDrawTitleCell
      end
      object cbxPinPadGridServer: TwwDBLookupCombo
        Left = 87
        Top = 10
        Width = 145
        Height = 21
        DropDownAlignment = taLeftJustify
        LookupTable = qryServersForCbx2
        LookupField = 'Name'
        DropDownWidth = 145
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnChange = cbxPinPadGridServerChange
        OnBeforeDropDown = cbxPinPadGridServerBeforeDropDown
      end
    end
    object tabSheet_Printing: TTabSheet
      Caption = 'Printing'
      ImageIndex = 3
      OnHide = tabSheet_PrintingHide
      OnShow = tabSheet_PrintingShow
      object Label2: TLabel
        Left = 5
        Top = 19
        Width = 121
        Height = 13
        Caption = 'Bill/Receipt Print Groups :'
      end
      object Label4: TLabel
        Left = 5
        Top = 47
        Width = 97
        Height = 13
        Caption = 'Report Print Group :'
      end
      object Label11: TLabel
        Left = 5
        Top = 76
        Width = 82
        Height = 13
        Caption = 'EFT Print Group :'
      end
      object Label14: TLabel
        Left = 5
        Top = 162
        Width = 111
        Height = 13
        Caption = 'Printer Header Line 1 : '
      end
      object Label15: TLabel
        Left = 5
        Top = 191
        Width = 111
        Height = 13
        Caption = 'Printer Header Line 2 : '
      end
      object Label16: TLabel
        Left = 5
        Top = 220
        Width = 111
        Height = 13
        Caption = 'Printer Header Line 3 : '
      end
      object Label17: TLabel
        Left = 336
        Top = 19
        Width = 78
        Height = 13
        Caption = 'Receipt Footer :'
      end
      object Label3: TLabel
        Left = 5
        Top = 306
        Width = 97
        Height = 13
        Caption = 'EFT Header Line 3 : '
      end
      object Label5: TLabel
        Left = 5
        Top = 277
        Width = 97
        Height = 13
        Caption = 'EFT Header Line 2 : '
      end
      object Label6: TLabel
        Left = 5
        Top = 248
        Width = 97
        Height = 13
        Caption = 'EFT Header Line 1 : '
      end
      object lblVatNo: TLabel
        Left = 5
        Top = 363
        Width = 63
        Height = 13
        Caption = 'Vat Number :'
      end
      object Label26: TLabel
        Left = 5
        Top = 105
        Width = 106
        Height = 13
        Caption = 'Ticketing Print Group :'
      end
      object Label27: TLabel
        Left = 5
        Top = 334
        Width = 84
        Height = 13
        Caption = 'Ticketing Header:'
      end
      object Label18: TLabel
        Left = 336
        Top = 115
        Width = 54
        Height = 13
        Caption = 'Bill Footer :'
      end
      object lblCorrectionticket: TLabel
        Left = 336
        Top = 331
        Width = 81
        Height = 26
        Caption = 'Correction Ticket'#13#10'Footer:'
      end
      object lblTerminalAddress: TLabel
        Left = 5
        Top = 392
        Width = 143
        Height = 13
        Caption = 'Terminal Reports IP Address :'
      end
      object Label7: TLabel
        Left = 5
        Top = 133
        Width = 135
        Height = 13
        Caption = 'SOAP Function Print Group :'
      end
      object lbStandardFooterOverrideWarning: TLabel
        Left = 414
        Top = 19
        Width = 12
        Height = 16
        Hint = 'This footer is currently overriden by a setting in Estate Setup'
        Alignment = taCenter
        AutoSize = False
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lbBillFooterOverrideWarning: TLabel
        Left = 390
        Top = 114
        Width = 12
        Height = 16
        Hint = 'This footer is currently overriden by a setting in Estate Setup'
        Alignment = taCenter
        AutoSize = False
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object DBEdtHeader1: TDBEdit
        Left = 158
        Top = 158
        Width = 151
        Height = 21
        DataField = 'PrintHeader1'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 40
        TabOrder = 5
      end
      object DBEdtHeader2: TDBEdit
        Left = 158
        Top = 187
        Width = 151
        Height = 21
        DataField = 'PrintHeader2'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 40
        TabOrder = 6
      end
      object DBEdtHeader3: TDBEdit
        Left = 158
        Top = 216
        Width = 151
        Height = 21
        DataField = 'PrintHeader3'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 40
        TabOrder = 7
      end
      object wwlkcxBillPS: TwwDBLookupCombo
        Left = 158
        Top = 15
        Width = 151
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Printer Stream Name'#9'19'#9'Printer Stream Name'#9#9)
        DataField = 'BillReceiptPrintStream'
        DataSource = dmADO.dsOutletPrintConfigs
        LookupTable = dmADO.qPrintStreams
        LookupField = 'Index No'
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object wwlkcxReportPS: TwwDBLookupCombo
        Left = 158
        Top = 43
        Width = 151
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Printer Stream Name'#9'19'#9'Printer Stream Name'#9#9)
        DataField = 'ReportPrintStream'
        DataSource = dmADO.dsOutletPrintConfigs
        LookupTable = dmADO.qPrintStreams
        LookupField = 'Index No'
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object wwlkcxEFTPS: TwwDBLookupCombo
        Left = 158
        Top = 72
        Width = 151
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Printer Stream Name'#9'19'#9'Printer Stream Name'#9#9)
        DataField = 'EFTPrintStream'
        DataSource = dmADO.dsOutletPrintConfigs
        LookupTable = dmADO.qPrintStreams
        LookupField = 'Index No'
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object DBEditEFTHeader3: TDBEdit
        Left = 158
        Top = 302
        Width = 151
        Height = 21
        DataField = 'EFTHeader3'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 20
        TabOrder = 10
      end
      object DBEditEFTHeader2: TDBEdit
        Left = 158
        Top = 273
        Width = 151
        Height = 21
        DataField = 'EFTHeader2'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 20
        TabOrder = 9
      end
      object DBEditEFTHeader1: TDBEdit
        Left = 158
        Top = 244
        Width = 151
        Height = 21
        DataField = 'EFTHeader1'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 20
        TabOrder = 8
      end
      object dbEdtVatNo: TDBEdit
        Left = 158
        Top = 359
        Width = 151
        Height = 21
        DataField = 'VATNumber'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 25
        TabOrder = 12
      end
      object cmTicketPrintStream: TwwDBLookupCombo
        Left = 158
        Top = 101
        Width = 151
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Printer Stream Name'#9'19'#9'Printer Stream Name'#9#9)
        DataField = 'CloakroomPrintStream'
        DataSource = dmADO.dsOutletPrintConfigs
        LookupTable = dmADO.qPrintStreams
        LookupField = 'Index No'
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object DBEdit3: TDBEdit
        Left = 158
        Top = 330
        Width = 151
        Height = 21
        DataField = 'CloakroomTicketHeader'
        DataSource = dmADO.dsOutletPrintConfigs
        MaxLength = 40
        TabOrder = 11
      end
      object mmPrinterFooter: TMemo
        Left = 432
        Top = 15
        Width = 252
        Height = 89
        TabOrder = 16
        WordWrap = False
        OnExit = MemoBoxOnExit
        OnKeyDown = mmPrinterFooterKeyDown
        OnKeyPress = mmPrinterFooterKeyPress
      end
      object mmCorrectionTicket: TMemo
        Left = 432
        Top = 329
        Width = 252
        Height = 89
        TabOrder = 18
        WordWrap = False
        OnExit = MemoBoxOnExit
        OnKeyDown = mmPrinterFooterKeyDown
        OnKeyPress = mmPrinterFooterKeyPress
      end
      object DBCbxCompactBillLines: TDBCheckBox
        Left = 183
        Top = 410
        Width = 175
        Height = 17
        Caption = 'Compact bill lines if the same'
        DataField = 'CompactBillLines'
        DataSource = dmADO.dsOutletPrintConfigs
        TabOrder = 15
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBEditIPAddress: TDBEdit
        Left = 158
        Top = 388
        Width = 151
        Height = 21
        Hint = 'This is the Site PC IP Address visible from the EPOS Network'
        DataField = 'IPAddress'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 13
        OnChange = DBEditIPAddressChange
      end
      object cmSOAPServerTicketPrintStream: TwwDBLookupCombo
        Left = 158
        Top = 129
        Width = 151
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Printer Stream Name'#9'19'#9'Printer Stream Name'#9#9)
        DataField = 'SOAPServerTicketPrintStream'
        DataSource = dmADO.dsOutletPrintConfigs
        LookupTable = dmADO.qPrintStreams
        LookupField = 'Index No'
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object DBcbxPromotionSavingsOnBill: TDBCheckBox
        Left = 5
        Top = 410
        Width = 175
        Height = 17
        Caption = 'Promotion savings on bill'
        DataField = 'PromotionSavingsOnBill'
        DataSource = dmADO.dsOutletPrintConfigs
        TabOrder = 14
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBcbxPromotionSavingsOnBillClick
      end
      object btnEditBillFooter: TButton
        Left = 690
        Top = 112
        Width = 100
        Height = 25
        Caption = 'Edit Bill Footer'
        TabOrder = 17
        OnClick = btnEditBillFooterClick
      end
      object disableMemoPanel: TPanel
        Left = 424
        Top = 104
        Width = 265
        Height = 225
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 19
        object mmBillFooter: TMemo
          Left = 8
          Top = 7
          Width = 252
          Height = 211
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          WordWrap = False
        end
      end
      object DBcbxDiscountSavingsOnBill: TDBCheckBox
        Left = 5
        Top = 429
        Width = 175
        Height = 17
        Caption = 'Discount savings on bill'
        DataField = 'DiscountSavingsOnBill'
        DataSource = dmADO.dsOutletPrintConfigs
        TabOrder = 20
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBcbxPromotionSavingsOnBillClick
      end
      object DBcbxTotalSavingsOnBill: TDBCheckBox
        Left = 5
        Top = 448
        Width = 175
        Height = 17
        Caption = 'Total savings on bill'
        DataField = 'TotalSavingsOnBill'
        DataSource = dmADO.dsOutletPrintConfigs
        TabOrder = 21
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBcbxPromotionSavingsOnBillClick
      end
      object DBCheckBoxPrintQrCode: TDBCheckBox
        Left = 183
        Top = 429
        Width = 175
        Height = 17
        Hint = 
          'When Print QR code for Bill Payment is enabled, '#13#10'QRCode header ' +
          'text and QRCode Footer text can be edited for an estate in:'#13#10'The' +
          'me Modelling - Estate Setup - Message Display'#13#10#39'Edit QR code text ' +
          'for Bill Payment'#39
        Caption = 'Print QR code for Bill Payment'
        DataField = 'PrintQrCode'
        DataSource = dmADO.dsOutletPrintConfigs
        TabOrder = 22
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBrgPrintEftVoucher: TDBRadioGroup
        Left = 184
        Top = 448
        Width = 161
        Height = 67
        Caption = 'Prompt to print payment slip'
        DataField = 'CustomerVoucherWhenPay'
        DataSource = dmADO.dsOutletPrintConfigs
        Items.Strings = (
          'Always print'
          'Never print'
          'Prompt for print')
        TabOrder = 23
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object btnConfigureQRCode: TButton
        Left = 432
        Top = 424
        Width = 253
        Height = 25
        Caption = 'Configure footer QR Code'
        TabOrder = 24
        OnClick = btnConfigureQRCodeClick
      end
    end
    object tabSheet_ConfigurationSettings: TTabSheet
      Caption = 'Configuration Settings'
      ImageIndex = 8
      OnHide = tabSheet_ConfigurationSettingsHide
      OnShow = tabSheet_ConfigurationSettingsShow
      object lblEFTPorts: TLabel
        Left = 16
        Top = 66
        Width = 126
        Height = 13
        Caption = 'EFT IP Ports (Req./Rsp.) :'
      end
      object lblGiftPorts: TLabel
        Left = 16
        Top = 138
        Width = 104
        Height = 13
        Caption = 'Loyalty/Gift IP Ports :'
      end
      object lblGiftCardType: TLabel
        Left = 16
        Top = 90
        Width = 74
        Height = 13
        Caption = 'Gift Card Type:'
      end
      object lblEFTAddress: TLabel
        Left = 16
        Top = 42
        Width = 80
        Height = 13
        Caption = 'EFT IP Address :'
      end
      object lblGiftCardAddress: TLabel
        Left = 16
        Top = 114
        Width = 118
        Height = 13
        Caption = 'Loyalty/Gift IP Address :'
      end
      object Label8: TLabel
        Left = 16
        Top = 18
        Width = 54
        Height = 13
        Caption = 'EFT Mode :'
      end
      object lbPeripheralWarnings: TLabel
        Left = 312
        Top = 18
        Width = 12
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object dbEdtEFTRequestPort: TDBEdit
        Left = 158
        Top = 63
        Width = 73
        Height = 21
        DataField = 'EFTRequestIPPort'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 5
        TabOrder = 3
        OnExit = dbEdtEFTRequestPortExit
        OnKeyPress = dbEdtGiftRequestPortKeyPress
      end
      object dbEdtEFTResponsePort: TDBEdit
        Left = 238
        Top = 63
        Width = 73
        Height = 21
        DataField = 'EFTResponseIPPort'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 5
        TabOrder = 4
        OnExit = dbEdtEFTRequestPortExit
        OnKeyPress = dbEdtGiftRequestPortKeyPress
      end
      object dbEdtGiftRequestPort: TDBEdit
        Left = 158
        Top = 135
        Width = 73
        Height = 21
        DataField = 'GiftRequestIPPort'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 5
        TabOrder = 8
        OnExit = dbEdtEFTRequestPortExit
        OnKeyPress = dbEdtGiftRequestPortKeyPress
      end
      object dbEdtGiftResponsePort: TDBEdit
        Left = 238
        Top = 135
        Width = 73
        Height = 21
        DataField = 'GiftResponseIPPort'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 5
        TabOrder = 9
        OnExit = dbEdtEFTRequestPortExit
        OnKeyPress = dbEdtGiftRequestPortKeyPress
      end
      object cmbbxGiftCardType: TwwDBLookupCombo
        Left = 158
        Top = 87
        Width = 153
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'19'#9'Name'#9'F')
        DataField = 'GiftCardType'
        DataSource = dmADO.dsOutletConfigs
        LookupTable = dmADO.qryGiftCardTypes
        LookupField = 'ID'
        Style = csDropDownList
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        AllowClearKey = False
        OnChange = cmbbxGiftCardTypeChange
      end
      object EFTSettingsGroup: TGroupBox
        Left = 8
        Top = 385
        Width = 443
        Height = 102
        Caption = 'EFT Timeout Settings'
        TabOrder = 11
        DesignSize = (
          443
          102)
        object EFTTimeoutGrid: TwwDBGrid
          Left = 8
          Top = 16
          Width = 425
          Height = 73
          ControlType.Strings = (
            'UseDestination;CheckBox;True;False'
            'IsDefault;CheckBox;True;False')
          Selected.Strings = (
            'Name'#9'25'#9'Type'#9'F'#9
            'TotalTimeout'#9'10'#9'Total Timeout'#9#9
            'TimeoutTime'#9'10'#9'Interval (s)'#9#9
            'TimeoutRetryCount'#9'10'#9'Attempts'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 2
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dmADO.dsThemeTerminalEFTTimouts
          KeyOptions = []
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Shell Dlg 2'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          OnFieldChanged = EFTTimeoutGridFieldChanged
        end
      end
      object EditGiftAddress: TEdit
        Left = 158
        Top = 111
        Width = 153
        Height = 21
        TabOrder = 6
        OnExit = EditGiftAddressExit
      end
      object EditEFTAddress: TEdit
        Left = 158
        Top = 39
        Width = 153
        Height = 21
        TabOrder = 1
        OnExit = EditEFTAddressExit
      end
      object btnHotelCodeAllocation: TButton
        Left = 456
        Top = 448
        Width = 121
        Height = 25
        Caption = 'Hotel Code Allocation'
        TabOrder = 16
        OnClick = btnHotelCodeAllocationClick
      end
      object cbEftMode: TwwDBLookupCombo
        Left = 158
        Top = 15
        Width = 153
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'value'#9'50'#9'value'#9#9)
        DataField = 'EFTMode'
        DataSource = dmADO.dsOutletConfigs
        LookupTable = dmADO.qThemeOutletEftModeLookup
        LookupField = 'ID'
        Style = csDropDownList
        DropDownWidth = 40
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        AllowClearKey = False
        OnChange = cbEftModeChange
      end
      object pnDynamicEFTSettings: TPanel
        Left = 16
        Top = 159
        Width = 433
        Height = 228
        BevelOuter = bvNone
        TabOrder = 10
        object EFTPreAuthLabel: TLabel
          Left = 0
          Top = 3
          Width = 141
          Height = 13
          Caption = 'Pre Authorization Amount:($)'
        end
        object lblFastEFTThreshold: TLabel
          Left = 0
          Top = 27
          Width = 120
          Height = 13
          Caption = 'Fast pay EFT Threshold :'
        end
        object CommideaPinPadLoginLabel: TLabel
          Left = 0
          Top = 99
          Width = 116
          Height = 13
          Caption = 'Commidea Pinpad Login:'
        end
        object CommideaPinPadPINLabel: TLabel
          Left = 0
          Top = 123
          Width = 108
          Height = 13
          Caption = 'Commidea Pinpad PIN:'
        end
        object CommideaTransactionTimeoutLabel: TLabel
          Left = 0
          Top = 147
          Width = 92
          Height = 13
          Caption = 'Commidea timeout:'
        end
        object OciusPinPadLoginLabel: TLabel
          Left = 0
          Top = 51
          Width = 109
          Height = 13
          Caption = 'Ocius Pin Pad Login Id:'
          Layout = tlCenter
        end
        object OciusPinPadPasswordLabel: TLabel
          Left = 0
          Top = 75
          Width = 117
          Height = 13
          Caption = 'Ocius Pin Pad Password:'
          Layout = tlCenter
        end
        object DBEditEFTPreAuthAmount: TDBEdit
          Left = 142
          Top = 0
          Width = 73
          Height = 21
          DataField = 'EFTPreAuthAmount'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 5
          TabOrder = 0
        end
        object DBEditFastEFTAmount: TDBEdit
          Left = 142
          Top = 24
          Width = 73
          Height = 21
          DataField = 'FastEFTAmount'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 20
          TabOrder = 1
        end
        object DBEditCommideaPinPadLogin: TDBEdit
          Left = 142
          Top = 96
          Width = 153
          Height = 21
          DataField = 'CommideaPinPadLogin'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 20
          TabOrder = 4
        end
        object DBEditCommideaPinPadPIN: TDBEdit
          Left = 142
          Top = 120
          Width = 153
          Height = 21
          DataField = 'CommideaPinPadPIN'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 20
          TabOrder = 5
        end
        object DBEditCommideaTransactionTimeout: TDBEdit
          Left = 142
          Top = 144
          Width = 153
          Height = 21
          DataField = 'CommideaTransactionTimeout'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 20
          TabOrder = 6
        end
        object cbEnhancedTipAdjustments: TDBCheckBox
          Left = 0
          Top = 172
          Width = 209
          Height = 17
          Caption = 'Allow Enhanced Tip Adjustments'
          DataField = 'AllowEnhancedTipAdjust'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 7
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkPromptForCashback: TDBCheckBox
          Left = 0
          Top = 188
          Width = 169
          Height = 17
          Caption = 'Prompt for cashback'
          DataField = 'CashbackAllowed'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 8
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnClick = DBCheckBoxClick
        end
        object cbShowAccountDetailsOnEFTVoucher: TDBCheckBox
          Left = 0
          Top = 204
          Width = 209
          Height = 17
          Caption = 'Show account details on EFT voucher'
          DataField = 'ShowAccountInformationOnVoucher'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 9
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object cbSetCreditLimitAfterPreAuth: TDBCheckBox
          Left = 176
          Top = 172
          Width = 209
          Height = 17
          Caption = 'Set credit limit after authorisation'
          DataField = 'ZcpsApplyPreAuthCreditLimit'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 10
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object OciusPinPadLoginIdDBEdit: TDBEdit
          Left = 142
          Top = 48
          Width = 153
          Height = 21
          DataField = 'OciusPinPadLoginId'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 2
        end
        object OciusPinPadPasswordDBEdit: TDBEdit
          Left = 142
          Top = 72
          Width = 153
          Height = 21
          DataField = 'OciusPinPadPassword'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 3
        end
      end
      object btSetLocalEFTServer: TButton
        Left = 312
        Top = 39
        Width = 57
        Height = 21
        Caption = 'Set Local'
        TabOrder = 2
        OnClick = btSetLocalEFTServerClick
      end
      object btSetLocalGiftServer: TButton
        Left = 312
        Top = 111
        Width = 57
        Height = 21
        Caption = 'Set Local'
        TabOrder = 7
        OnClick = btSetLocalGiftServerClick
      end
      object ScaleSettingsGroup: TGroupBox
        Left = 456
        Top = 8
        Width = 329
        Height = 73
        Caption = 'Scale Settings'
        TabOrder = 12
        DesignSize = (
          329
          73)
        object lblDecimalPlaces: TLabel
          Left = 8
          Top = 19
          Width = 73
          Height = 13
          Caption = 'Decimal places:'
        end
        object lblDisplayUnit: TLabel
          Left = 8
          Top = 43
          Width = 59
          Height = 13
          Caption = 'Display unit:'
        end
        object cmbbxDecimalPlaces: TDBComboBox
          Left = 115
          Top = 14
          Width = 207
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          DataField = 'ScaleDecimalPlaces'
          DataSource = dmADO.dsOutletConfigs
          ItemHeight = 13
          Items.Strings = (
            '0'
            '1'
            '2'
            '3')
          TabOrder = 0
        end
        object cmbbxDisplayUnit: TDBComboBox
          Left = 115
          Top = 41
          Width = 207
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          DataField = 'ScaleDisplayUnit'
          DataSource = dmADO.dsOutletConfigs
          ItemHeight = 13
          Items.Strings = (
            'lb'
            'oz'
            'kg'
            'gm')
          TabOrder = 1
        end
      end
      object ServerSettingsBox: TGroupBox
        Left = 456
        Top = 83
        Width = 329
        Height = 118
        Caption = 'Bookings and Ledgers Server Settings'
        TabOrder = 13
        DesignSize = (
          329
          118)
        object Label10: TLabel
          Left = 8
          Top = 18
          Width = 100
          Height = 13
          Caption = 'Ledgers IP Address :'
        end
        object Label19: TLabel
          Left = 8
          Top = 42
          Width = 81
          Height = 13
          Caption = 'Ledgers IP Port :'
        end
        object Label21: TLabel
          Left = 8
          Top = 71
          Width = 104
          Height = 13
          Caption = 'Bookings IP Address :'
        end
        object Label22: TLabel
          Left = 8
          Top = 95
          Width = 72
          Height = 13
          Caption = 'Bookings Port :'
        end
        object Bevel1: TBevel
          Left = 8
          Top = 63
          Width = 314
          Height = 2
        end
        object edtLedgersServerIP: TEdit
          Left = 115
          Top = 15
          Width = 145
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnExit = edtLedgersServerIPExit
        end
        object edtLedgersServerIPPort: TEdit
          Left = 115
          Top = 39
          Width = 145
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 5
          TabOrder = 1
          OnExit = edtLedgersServerIPPortExit
          OnKeyPress = edtLedgersServerIPPortKeyPress
        end
        object edtBookingsServerIP: TEdit
          Left = 115
          Top = 68
          Width = 145
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnExit = edtBookingsServerIPExit
        end
        object edtBookingsServerIPPort: TEdit
          Left = 115
          Top = 91
          Width = 145
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 5
          TabOrder = 4
          OnExit = edtBookingsServerIPPortExit
          OnKeyPress = edtBookingsServerIPPortKeyPress
        end
        object btnSetDefaultLedgersSettings: TButton
          Left = 265
          Top = 14
          Width = 57
          Height = 21
          Anchors = [akRight, akBottom]
          Caption = 'Default'
          TabOrder = 2
          OnClick = btnSetDefaultLedgersSettingsClick
        end
        object btnSetDefaultBookingsSettings: TButton
          Left = 264
          Top = 68
          Width = 57
          Height = 21
          Anchors = [akRight, akBottom]
          Caption = 'Default'
          TabOrder = 5
          OnClick = btnSetDefaultBookingsSettingsClick
        end
      end
      object gbAdMarginProxy: TGroupBox
        Left = 456
        Top = 336
        Width = 329
        Height = 45
        Caption = 'AdMargin Client'
        TabOrder = 15
        object lblAdMarginProxy: TLabel
          Left = 8
          Top = 18
          Width = 58
          Height = 13
          Caption = 'Connection:'
        end
        object DBEditAdMarginProxy: TDBEdit
          Left = 115
          Top = 14
          Width = 207
          Height = 21
          DataField = 'AdMarginConnectionString'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 0
        end
      end
      object KMSServerSettingsBox: TGroupBox
        Left = 456
        Top = 204
        Width = 329
        Height = 130
        Caption = 'Kitchen iQ Settings'
        TabOrder = 14
        object lblKMSPrimaryServer: TLabel
          Left = 8
          Top = 17
          Width = 75
          Height = 13
          Caption = 'Primary Server:'
        end
        object lblKMSPrimaryServerPort: TLabel
          Left = 8
          Top = 44
          Width = 98
          Height = 13
          Caption = 'Primary Server Port:'
        end
        object Bevel2: TBevel
          Left = 8
          Top = 68
          Width = 313
          Height = 2
        end
        object lblKMSBackupServer: TLabel
          Left = 8
          Top = 78
          Width = 73
          Height = 13
          Caption = 'Backup Server:'
        end
        object lblKMSBackupServerPort: TLabel
          Left = 8
          Top = 105
          Width = 96
          Height = 13
          Caption = 'Backup Server Port:'
        end
        object wwDBEditKMSPrimaryServer: TwwDBEdit
          Left = 115
          Top = 14
          Width = 207
          Height = 21
          DataField = 'KMSPrimaryServerIPAddress'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnKeyPress = wwDBEditKMSPrimaryServerKeyPress
        end
        object wwDBEditKMSPrimaryServerPort: TwwDBEdit
          Left = 115
          Top = 41
          Width = 207
          Height = 21
          DataField = 'KMSPrimaryServerPort'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 5
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnKeyPress = wwDBEditKMSPrimaryServerPortKeyPress
        end
        object wwDBEditKMSBackupServer: TwwDBEdit
          Left = 115
          Top = 75
          Width = 207
          Height = 21
          DataField = 'KMSBackupServerIPAddress'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnKeyPress = wwDBEditKMSBackupServerKeyPress
        end
        object wwDBEditKMSBackupServerPort: TwwDBEdit
          Left = 115
          Top = 102
          Width = 207
          Height = 21
          DataField = 'KMSBackupServerPort'
          DataSource = dmADO.dsOutletConfigs
          MaxLength = 5
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnKeyPress = wwDBEditKMSBackupServerPortKeyPress
        end
      end
      object gbIPToSerialMapperPorts: TGroupBox
        Left = 456
        Top = 385
        Width = 329
        Height = 57
        Caption = 'IP To Serial Mapper Port Settings'
        TabOrder = 17
        object lblIPToSerialMapperStart: TLabel
          Left = 8
          Top = 24
          Width = 47
          Height = 13
          Caption = 'Start Port'
        end
        object lblPortsUsedTitle: TLabel
          Left = 192
          Top = 17
          Width = 113
          Height = 13
          Caption = 'Port range used will be:'
        end
        object lblPortsUsedLabel: TLabel
          Left = 192
          Top = 31
          Width = 84
          Height = 13
          Caption = 'lblPortsUsedLabel'
        end
        object lblDefaultStartPort: TLabel
          Left = 8
          Top = 39
          Width = 88
          Height = 11
          Caption = '(default value 49152)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -9
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
        end
        object dbedtIPToSerialMapperStartPort: TDBEdit
          Left = 115
          Top = 21
          Width = 57
          Height = 21
          DataField = 'IPToSerialMapperStartPort'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 0
          OnExit = dbedtIPToSerialMapperStartPortExit
        end
      end
    end
    object tabSheet_Misc: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 5
      OnHide = tabSheet_MiscHide
      OnShow = tabSheet_MiscShow
      object lblTipValidationPct: TLabel
        Left = 474
        Top = 408
        Width = 125
        Height = 13
        Caption = 'Tip Validation Percentage:'
      end
      object Label13: TLabel
        Left = 474
        Top = 431
        Width = 121
        Height = 13
        Caption = 'Card charge percentage:'
      end
      object Label20: TLabel
        Left = 474
        Top = 454
        Width = 126
        Height = 13
        Caption = 'House tip out percentage:'
      end
      object blAutoServiceChargeCoverThreshold: TLabel
        Left = 474
        Top = 477
        Width = 153
        Height = 13
        Caption = 'Service Cover Count Threshold:'
        WordWrap = True
      end
      object lblSurveyCodeSupplier: TLabel
        Left = 471
        Top = 135
        Width = 149
        Height = 13
        Caption = 'Receipt Survey Code Supplier: '
      end
      object DBEditTipValidationPercentage: TDBEdit
        Left = 627
        Top = 404
        Width = 151
        Height = 21
        DataField = 'TipValidationPercentage'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 3
        TabOrder = 17
        OnChange = DBEditPercentageChange
      end
      object DBEdit1: TDBEdit
        Left = 627
        Top = 427
        Width = 151
        Height = 21
        DataField = 'CardCharge'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 3
        TabOrder = 18
        OnChange = DBEditPercentageChange
      end
      object DBEdit2: TDBEdit
        Left = 627
        Top = 450
        Width = 151
        Height = 21
        DataField = 'HouseTipOut'
        DataSource = dmADO.dsOutletConfigs
        MaxLength = 3
        TabOrder = 19
        OnChange = DBEditPercentageChange
      end
      object DBCheckBox1: TDBCheckBox
        Left = 474
        Top = 1
        Width = 146
        Height = 19
        Caption = 'Declare Tips'
        DataField = 'DeclareTips'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object cbAutoPayoutTips: TDBCheckBox
        Left = 474
        Top = 39
        Width = 146
        Height = 17
        Caption = 'Auto payout tips'
        DataField = 'AutoDeductTip'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = cbAutoPayoutTipsClick
      end
      object cbOnClockOut: TDBCheckBox
        Left = 494
        Top = 57
        Width = 90
        Height = 17
        Caption = 'On Clock Out'
        DataField = 'PayoutTipsOnClockout'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 4
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = cbOnClockOutClick
      end
      object SuggestedTipRangeGroup: TGroupBox
        Left = 15
        Top = 4
        Width = 419
        Height = 477
        Caption = 'Suggested Tip Range'
        TabOrder = 0
        object lblSuggestedTipWarning: TLabel
          Left = 312
          Top = 359
          Width = 90
          Height = 52
          Caption = 
            'Partially completed'#13#10'suggested tips will'#13#10'not be sent to the'#13#10'ti' +
            'll.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object gbSuggestedTipTitle: TGroupBox
          Left = 9
          Top = 160
          Width = 399
          Height = 129
          Caption = 'Title'
          TabOrder = 2
          object dbedSuggestedTipTitle1: TDBEdit
            Left = 9
            Top = 22
            Width = 380
            Height = 21
            DataField = 'Title1'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 0
          end
          object dbedSuggestedTipTitle2: TDBEdit
            Left = 9
            Top = 58
            Width = 380
            Height = 21
            DataField = 'Title2'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 1
          end
          object dbedSuggestedTipTitle3: TDBEdit
            Left = 9
            Top = 94
            Width = 380
            Height = 21
            DataField = 'Title3'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 2
          end
        end
        object gbSuggestedTips: TGroupBox
          Left = 9
          Top = 309
          Width = 291
          Height = 140
          Caption = 'Suggested Tips'
          TabOrder = 3
          object lblPC: TLabel
            Left = 247
            Top = 17
            Width = 11
            Height = 13
            Caption = '%'
          end
          object lblPCName: TLabel
            Left = 9
            Top = 17
            Width = 27
            Height = 13
            Caption = 'Name'
          end
          object dbedText1: TDBEdit
            Left = 9
            Top = 35
            Width = 224
            Height = 21
            DataField = 'Text1'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 0
            OnChange = dbSuggestedTipTextChange
          end
          object dbedText2: TDBEdit
            Left = 9
            Top = 68
            Width = 224
            Height = 21
            DataField = 'Text2'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 2
            OnChange = dbSuggestedTipTextChange
          end
          object dbedText3: TDBEdit
            Left = 9
            Top = 102
            Width = 224
            Height = 21
            DataField = 'Text3'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 4
            OnChange = dbSuggestedTipTextChange
          end
          object dbedPercentage1: TDBEdit
            Left = 247
            Top = 35
            Width = 34
            Height = 21
            DataField = 'Percentage1'
            DataSource = dmADO.dsOutletSuggestedTip
            MaxLength = 5
            TabOrder = 1
            OnChange = dbSuggestedTipPercentageChange
          end
          object dbedPercentage3: TDBEdit
            Left = 247
            Top = 102
            Width = 34
            Height = 21
            DataField = 'Percentage3'
            DataSource = dmADO.dsOutletSuggestedTip
            MaxLength = 5
            TabOrder = 5
            OnChange = dbSuggestedTipPercentageChange
          end
          object dbedPercentage2: TDBEdit
            Left = 247
            Top = 68
            Width = 34
            Height = 21
            DataField = 'Percentage2'
            DataSource = dmADO.dsOutletSuggestedTip
            MaxLength = 5
            TabOrder = 3
            OnChange = dbSuggestedTipPercentageChange
          end
        end
        object gbLines: TGroupBox
          Left = 9
          Top = 24
          Width = 183
          Height = 49
          Caption = 'Lines'
          TabOrder = 0
          object lblLeadingLines: TLabel
            Left = 9
            Top = 21
            Width = 37
            Height = 13
            Caption = 'Leading'
          end
          object lblTrailingLInes: TLabel
            Left = 101
            Top = 21
            Width = 34
            Height = 13
            Caption = 'Trailing'
          end
          object dbSpinLeadingLines: TwwDBSpinEdit
            Left = 51
            Top = 18
            Width = 30
            Height = 21
            EditorEnabled = False
            Increment = 1
            MaxValue = 3
            DataField = 'LeadingLines'
            DataSource = dmADO.dsOutletSuggestedTip
            PopupMenu = FakeContextMenu
            TabOrder = 0
            UnboundDataType = wwDefault
          end
          object dbSpinTrailingLines: TwwDBSpinEdit
            Left = 140
            Top = 18
            Width = 30
            Height = 21
            EditorEnabled = False
            Increment = 1
            MaxValue = 3
            DataField = 'TrailingLines'
            DataSource = dmADO.dsOutletSuggestedTip
            PopupMenu = FakeContextMenu
            TabOrder = 1
            UnboundDataType = wwDefault
          end
        end
        object gbShowSuggestedTips: TGroupBox
          Left = 10
          Top = 91
          Width = 183
          Height = 49
          Caption = 'Show for'
          TabOrder = 1
          object dbcbShowForBills: TDBCheckBox
            Left = 9
            Top = 21
            Width = 60
            Height = 17
            Caption = 'Bills'
            DataField = 'ShowForBills'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 0
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbcbShowForSOAPPayments: TDBCheckBox
            Left = 71
            Top = 21
            Width = 108
            Height = 17
            Caption = 'SOAP Payments'
            DataField = 'ShowForSOAPPayments'
            DataSource = dmADO.dsOutletSuggestedTip
            TabOrder = 1
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
        end
      end
      object DBCheckBox5: TDBCheckBox
        Left = 474
        Top = 20
        Width = 207
        Height = 17
        Caption = 'Warn if Accounts Open (On Clock Out)'
        DataField = 'WarnIfAccountsOpen'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 2
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBCheckBox2: TDBCheckBox
        Left = 474
        Top = 77
        Width = 146
        Height = 17
        Caption = 'Use scheduling'
        DataField = 'UseScheduling'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 5
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object cbAutoDecimalEntry: TDBCheckBox
        Left = 474
        Top = 96
        Width = 146
        Height = 17
        Caption = 'Auto decimal entry'
        DataField = 'UseAutoDecimalEntry'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 6
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBCheckBox8: TDBCheckBox
        Left = 474
        Top = 115
        Width = 146
        Height = 17
        Caption = 'Print Clock In Ticket'
        DataField = 'PrintClockINTicket'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBCheckBox3: TDBCheckBox
        Left = 474
        Top = 222
        Width = 225
        Height = 17
        Caption = 'Use security of default job when clocking in'
        DataField = 'UseDefaultDutySecurity'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 11
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBCheckBox6: TDBCheckBox
        Left = 474
        Top = 244
        Width = 225
        Height = 17
        Caption = 'Show expected figures in spot check'
        DataField = 'PromptedSpotCheck'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 12
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object cbAutoFillValue: TDBCheckBox
        Left = 474
        Top = 267
        Width = 185
        Height = 17
        Caption = 'Auto fill value'
        DataField = 'AutoFillValue'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 13
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxClick
      end
      object DBCheckBoxPrintClockOutTicket: TDBCheckBox
        Left = 474
        Top = 290
        Width = 162
        Height = 17
        Caption = 'Print Clock Out Ticket'
        DataField = 'PrintClockOUTTicket'
        DataSource = dmADO.dsOutletConfigs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxPrintClockOutTicketClick
      end
      object DBCheckBoxAbbreviateClockOutReport: TDBCheckBox
        Left = 474
        Top = 313
        Width = 161
        Height = 17
        Caption = 'Abbreviate Clock Out Report'
        DataField = 'AbbreviatedClockOutTicket'
        DataSource = dmADO.dsOutletConfigs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBoxAbbreviateClockOutReportClick
      end
      object DBcbxQSRShowAztecCoursesSeparately: TDBCheckBox
        Left = 474
        Top = 336
        Width = 197
        Height = 17
        Caption = 'QSR show Aztec courses separately'
        DataField = 'QSRShowAztecCoursesSeparately'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 16
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object wwDBSpinEditAutoServiceCharge: TwwDBSpinEdit
        Left = 627
        Top = 473
        Width = 151
        Height = 21
        Increment = 1
        MaxValue = 32767
        MinValue = 1
        Value = 1
        DataField = 'ServiceChargeCoverThreshold'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 20
        UnboundDataType = wwDefault
      end
      object pnlWarnIfAccountOpenOnSessionChange: TPanel
        Left = 464
        Top = 161
        Width = 261
        Height = 57
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 10
        DesignSize = (
          261
          57)
        object dbchkbxLastTerminalOnly: TDBCheckBox
          Left = 30
          Top = 12
          Width = 223
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Apply Security to Last Terminal Only'
          DataField = 'SessionChangeWarnIfAccountsOpenLastTerminalOnly'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkbxRestrictToSalesArea: TDBCheckBox
          Left = 30
          Top = 34
          Width = 223
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Restrict to Current Sales Area'
          DataField = 'SessionChangeWarnIfAccountsOpenInSalesArea'
          DataSource = dmADO.dsOutletConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object DBCheckBox13: TDBCheckBox
        Left = 474
        Top = 154
        Width = 239
        Height = 17
        Caption = 'Warn if Accounts Open (On Session Change)'
        DataField = 'SessionChangeWarnIfAccountsOpen'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 9
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = DBCheckBox13Click
      end
      object cmbbxSurveyCodeSupplier: TDBLookupComboBox
        Left = 627
        Top = 131
        Width = 151
        Height = 21
        DataField = 'SurveyCodeSupplier'
        DataSource = dmADO.dsOutletConfigs
        KeyField = 'Id'
        ListField = 'AztecName'
        ListSource = dmADO.dsSurveyCodeSupplier
        TabOrder = 8
      end
      object cbReconfirmTipEntry: TDBCheckBox
        Left = 475
        Top = 383
        Width = 197
        Height = 17
        Caption = 'Reconfirm Tip Entry'
        DataField = 'ReconfirmTipEntry'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 21
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = cbReconfirmTipEntryClick
      end
      object cbReversePaymentDialogue: TDBCheckBox
        Left = 475
        Top = 359
        Width = 197
        Height = 17
        Caption = 'Reverse payment dialogue'
        DataField = 'ConfirmReversePaymentOfAnother'
        DataSource = dmADO.dsOutletConfigs
        TabOrder = 22
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = cbReversePaymentDialogueClick
      end
    end
  end
  object btnClose: TButton
    Left = 696
    Top = 544
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object qEditPrintStreams: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from #tmpstreams order by sort1, sort2')
    Left = 392
    Top = 514
  end
  object qLoadPrintStreams: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'sitecode'
        DataType = ftInteger
        Size = -1
        Value = 1
      end
      item
        Name = 'sortmode'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'serverID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'declare @outletid int, @sortmode int, @serverID int, @pstrnameco' +
        'unt int, @pstrtableid int'
      
        'declare @MOAOrderPad int, @MobileOrdering int, @MOAPayAtTable in' +
        't'
      ''
      'set @outletid = :sitecode'
      'set @sortmode = :sortmode'
      'set @serverID = :serverID'
      ''
      
        'SELECT @MOAOrderPad = HardwareType FROM TerminalHardware WHERE H' +
        'ardwareName = '#39'MOA OrderPad'#39
      
        'SELECT @MobileOrdering = HardwareType FROM TerminalHardware WHER' +
        'E HardwareName = '#39'Mobile Ordering'#39
      
        'SELECT @MOAPayAtTable = HardwareType FROM TerminalHardware WHERE' +
        ' HardwareName = '#39'MOA Pay At Table'#39
      ''
      'insert #tmpstreams'
      '(eposdeviceid, printstreamid, [sort1], [sort2], ReadOnly)'
      '--Normal terminals'
      'select'
      '  a.eposdeviceid,'
      '  b.[index no] as prinstreamid,'
      '  case @sortmode when 0 then'
      '    a.name else b.[printer stream name]'
      '  end,'
      '  case @sortmode when 1 then'
      '    a.name else b.[printer stream name]'
      '  end,'
      '  0'
      'from themeeposdevice a, pstreams b'
      'where'
      '  (a.sitecode = @outletid) and'
      '  (a.IsServer = 0) and'
      '  (a.ServerID = @serverID) and'
      '  (a.HardwareType not in (10, 14)) and'
      '  (b.Deleted is null)'
      'union'
      '--iServe/iOrder devices'
      'select SampleEPoSDeviceID, ps.[Index No],'
      'case @sortmode when 0 then'
      '  '#39'iOrder : '#39' + sa.Name else ps.[printer stream name]'
      'end,'
      'case @sortmode when 1 then'
      '  '#39'iOrder : '#39' + sa.Name else ps.[printer stream name]'
      'end, 1'
      'from'
      
        '(select min(eposdeviceid) as SampleEPoSDeviceID, SalesAreaId fro' +
        'm ThemeEposDevice ted'
      'join ac_Pos p on p.Id = ted.POSCode'
      'where ted.SiteCode = @outletid'
      #9'and ted.IsServer = 0'
      #9'and ted.ServerID = @serverID'
      #9'and ted.HardwareType in (10)'
      'group by SalesAreaId) sub'
      'join ac_SalesArea sa'
      'on sub.SalesAreaId = sa.[Id]'
      'cross join pstreams ps'
      'order by 3, 4'
      ''
      'declare printers cursor for'
      'select a.printerid,'
      '  replace('
      
        '  replace(b.[name]+'#39':'#39' + isnull(cast(a.portnumber as varchar(50)' +
        '),'#39#39') + '#39' - '#39' + a.[name], '#39'['#39', '#39#39')'
      '  , '#39']'#39', '#39#39')'
      'from themeeposprinter a'
      
        'join ThemePrinterType on (a.PrinterType = ThemePrinterType.Print' +
        'erTypeID) and (ThemePrinterType.IsPrinter = 1)'
      
        'join themeeposdevice b on a.eposdeviceid = b.eposdeviceid and b.' +
        'sitecode = @outletid and a.sitecode = @outletid'
      
        '       and ((b.IsServer = 0 and b.ServerID = @serverID and b.Har' +
        'dwareType not in (10,14)) or (b.IsServer = 1 and b.EPoSDeviceID ' +
        '= @serverID))'
      'order by b.name, a.portnumber'
      'declare @printerid bigint, @printername varchar(50)'
      'open printers'
      'fetch next from printers into @printerid, @printername'
      'while @@fetch_status = 0'
      'begin'
      '  exec('#39'insert into #tmpprintercolumns(printerid, name) '#39'+'
      '       '#39' values('#39'+@printerid+'#39', '#39#39#39'+@printername+'#39#39#39') '#39')'
      ''
      '  set @pstrnamecount = (SELECT COUNT(*) '
      '                                FROM tempdb.sys.columns'
      
        '                                 WHERE OBJECT_ID = OBJECT_ID('#39'te' +
        'mpdb..#tmpstreams'#39')'
      
        '                                                AND name LIKE '#39#39 +
        '+@printername+'#39'%'#39' )'
      '                        '
      '  if (@pstrnamecount > 0)'
      '     begin'
      
        '       set @printername = @printername + '#39' ('#39' + CAST(ISNULL(@pst' +
        'rnamecount, 0) AS VARCHAR) + '#39')'#39' '
      
        '       exec('#39'update #tmpprintercolumns set name = '#39#39#39'+@printerna' +
        'me+'#39#39#39' where printerid = '#39'+@printerid+'#39' '#39')'
      '     end'
      ''
      '  exec('#39'alter table #tmpstreams add  ['#39'+@printername+'#39'] bit'#39')'
      
        '  exec('#39'alter table #tmpstreamsaggregate add  ['#39'+@printername+'#39']' +
        ' bit'#39')'
      '  exec('#39'update #tmpstreams set ['#39'+@printername+'#39'] = 0'#39')'
      '  exec('#39'update #tmpstreams set ['#39'+@printername+'#39'] = 1 where '#39'+'
      
        '    '#39'exists(select * from themeeposprinterstream b where b.sitec' +
        'ode = '#39'+@outletid+'#39' '#39'+'
      
        '    '#39'and #tmpstreams.eposdeviceid = b.eposdeviceid and #tmpstrea' +
        'ms.printstreamid = b.printstreamid '#39'+'
      '    '#39'and b.printerid = '#39'+@printerid+'#39')'#39')'
      '  fetch next from printers into @printerid, @printername'
      'end'
      'close printers'
      'deallocate printers'
      'update #tmpstreams set optional = 0'
      'update #tmpstreams set optional = 1'
      
        'where exists(select * from themeeposprinterstream b where b.site' +
        'code = @outletid'
      
        '  and #tmpstreams.eposdeviceid = b.eposdeviceid and #tmpstreams.' +
        'printstreamid = b.printstreamid'
      '  and b.optional = 1)'
      ''
      'select 1'
      ''
      '')
    Left = 24
    Top = 306
  end
  object qSavePrintStreams: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'outletid'
        Size = -1
        Value = Null
      end
      item
        Name = 'serverID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @outletid int, @serverID int'
      'set @outletid = :outletid'
      'set @serverID = :serverID'
      ''
      
        '--if object_id('#39'tempdb..#tmpstreams'#39') is not null drop table #tm' +
        'pstreams'
      ''
      'delete from ThemeEposPrinterStream'
      'where EposDeviceID in'
      '  (Select EposDeviceID'
      '   from ThemeEposDevice'
      '   where IsServer = 0'
      '   and ServerID = @serverID'
      
        '   and HardwareType not in (10, 14))     -- Mobile Ordering Prin' +
        't Streams are set up in Base Data'
      'and SiteCode = @outletid'
      ''
      'declare printers cursor for'
      'select a.printerid,'
      '  replace('
      
        '  replace(b.[name]+'#39':'#39' + isnull(cast(a.portnumber as varchar(50)' +
        '),'#39#39') + '#39' - '#39' + a.[name], '#39'['#39', '#39#39')'
      '  , '#39']'#39', '#39#39')'
      'from themeeposprinter a '
      
        'join ThemePrinterType on (a.PrinterType = ThemePrinterType.Print' +
        'erTypeID) and (ThemePrinterType.IsPrinter = 1)'
      
        'join themeeposdevice b on a.eposdeviceid = b.eposdeviceid and b.' +
        'sitecode = @outletid and a.sitecode = @outletid'
      
        '       and ((b.IsServer = 0 and b.ServerID = @serverID) or (b.Is' +
        'Server = 1 and b.EPoSDeviceID = @serverID))'
      'order by b.name, a.portnumber'
      'declare @printerid bigint, @printername varchar(50)'
      'open printers'
      'fetch next from printers into @printerid, @printername'
      'while @@fetch_status = 0'
      'begin'
      
        '  set @printername = (SELECT name FROM #tmpprintercolumns WHERE ' +
        'printerid = @printerid)'
      '  exec('#39'insert ThemeEposPrinterStream '#39'+'
      
        '    '#39'(SiteCode, EposDeviceID, PrintStreamID, TargetID, PrinterID' +
        ', Optional) '#39'+'
      
        '    '#39'select '#39'+@outletid+'#39', eposdeviceid, printstreamid, '#39'+@print' +
        'erid+'#39', '#39'+@printerid +'
      
        '    '#39' , optional from #tmpstreams where ['#39'+@printername+'#39'] = 1 a' +
        'nd ReadOnly = 0'#39');'
      '  fetch next from printers into @printerid, @printername'
      'end'
      'close printers'
      'deallocate printers'
      ''
      '')
    Left = 88
    Top = 306
  end
  object qClearPrintStreamsTable: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'if object_id('#39'tempdb..#tmpstreams'#39') is not null drop table #tmps' +
        'treams'
      
        'create table #tmpstreams (eposdeviceid bigint, printstreamid int' +
        ', [sort1] varchar(50),'
      
        '  [sort2] varchar(50), optional bit, ReadOnly bit primary key (e' +
        'posdeviceid, printstreamid))'
      ''
      ''
      
        'if object_id('#39'tempdb..#tmpprintercolumns'#39') is not null drop tabl' +
        'e #tmpprintercolumns'
      'create table #tmpprintercolumns (printerid int, '
      '                                [name] varchar(50))'
      ''
      
        'if object_id('#39'tempdb..#tmpstreamsaggregate'#39') is not null drop ta' +
        'ble #tmpstreamsaggregate'
      
        'create table #tmpstreamsaggregate (printstreamid int, PrintStrea' +
        'mName varchar(50), optional bit, readonly bit, primary key (prin' +
        'tstreamid))')
    Left = 56
    Top = 306
  end
  object dsPstreams: TDataSource
    DataSet = qEditPrintStreams
    Left = 256
    Top = 482
  end
  object ilDevices: TImageList
    Height = 32
    Width = 32
    Left = 256
    Top = 515
    Bitmap = {
      494C010108000900040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7EF00DECEBD00C6AD9400AD8C
      6B00AD845A00AD7B5A00AD947B00E7DED600FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFF7F700D6BDAD00B58C7300B5846300B5845A00B584
      5A00B5845A00A5734A009C734A00946B5200B59C8C00F7F7EF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7F7F700FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7EFEF00BD9C8400B58C6B00BD946B00C69C7B00D6B59C00DECE
      BD00E7D6BD00D6B59C009C7B5200946B4A007B5A390084736300F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6DEDE00425263007B8C9400DEE7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFF700DEDEDE00D6D6D600E7E7E700FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEB59C00BD946B00C6AD8C00E7D6C600FFF7EF00EFEFE700FFFF
      F700EFEFE700C6C6AD00D6CEB5008C6339006B4A310052312100AD9C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEE7
      E70039526B00394A5A00424A5A0042525A007B8C9400DEE7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00B5B5
      BD00948C94009C9494009C9494009C949400A59C9C00DED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7EF00B58C6B00DED6BD00FFFFEF00E7DECE00EFEFE70094846B008C7B
      5A009CCE6B0063CE10008CA55A00B59473007B5A3900392110007B5A4200DEDE
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700425A
      6B00294A6300394A630039425200424A5A00394A5A0039525A0084949C00E7EF
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00A5ADAD009C94
      94009C9494009C8C9400948C8C00948C9400948C94009C949400DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00C6A58C00EFEFDE00DED6CE00735A4200AD947B009C8473009C8C
      7B00BDDE940052DE080063B51800BDB59C008C6339004A2918006B4A31009C84
      6B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFF7F700526B7B003152
      6B00314A63003142520039394A004A4A5200394A5A00394A5A00394A5A003952
      63008C9CA500EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00EFEFEF00E7E7E700D6D6D600C6C6C600A5A59C009C9C
      9400BDBDBD00FFFFFF00000000000000000000000000CECED6008C8C94009C94
      9400948C94009C8C940094848C0094848C008C848C0094848C008C848C00EFEF
      EF00E7E7E700E7E7E700EFEFEF00EFEFF700EFEFEF00EFEFF700FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C846B00C6B59C0073635200A5947B0094847300DED6C600F7EFE7009484
      7300ADA5840063D629005ADE08009CAD5A00AD8C6B00734A29004A3118007B5A
      4200D6CEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F70063738400425A73003952
      6B0031425A00314A5A0031394A00424A5A00394A5A00424A5A0042525A00394A
      5A00314A5A004252630094A5AD00EFF7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700B5B5B500ADADAD0094948C007B7B
      73005A5A5A004A4A420042423900393931003939310042393100423931004242
      3900524A4A00ADADA500000000000000000000000000A5A5AD009C949400A594
      9C00A5949C00ADA5AD008C8C94008C8C94008C8C9C0094949C0094949C008C8C
      9400948C9C0094949C009C9CA500948C8C008C8C8C008C8C8C00948C8C00948C
      9400DEDEDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C7B6300947B5A00735A4200E7DEC600C6BDA5007B5A4A00B5A58C006B52
      42008C7B5A00D6EFB5009CDE5A00ADC67B00E7D6BD008C5A3900422110007352
      390094846B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7FF00637B8C00425A7300425A6B00314A
      5A0031526300314A5A0031394A0039425200394A5A00424A5A00424A5A00424A
      5A00394A5A00394A5A00394A5A00425A6B00ADB5BD00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700DEDEDE00CECECE00BDBDB5009494
      9400A59C9C00D6D6D600F7F7F70063635A003931310031312900313129003131
      2900313129003931290039312900393129003931290039393100393131004239
      3100524A4200736B6300DED6D60000000000FFFFFF0094949C00AD9CA500A59C
      9C00B5A5AD00B5A5AD009494940094949C0094949C0094949C0094949C006B73
      7B00ADA5AD00B5ADAD009C9C9C00ADA5A500ADA5A500ADA5A500ADA5A500ADA5
      A500BDB5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AD8C730094734A00C6B59C00736342009C846B0094846300EFE7CE00EFE7
      D600AD947B00CEC6AD0073B5B5004A949C00B5BDA500AD8463005A3918005A39
      18007B5A4200D6CEC60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF007384940042637300425A7300394A6300395A
      6B0031526300314A5A0031314200424A520039425200394A5A00424A5A00394A
      5A00394A5A00424A5200424A5A00394A6300394A6300526B7B00CED6DE000000
      00000000000000000000000000000000000000000000E7E7E7009C9C9C008C8C
      8C0073736B005A5A520042423900393931003939310039393100393931004239
      310042423900635A5200DEDEDE00DEDED6003939310031312900313129003131
      2900313129003131290031312900393129003931290039312900393131004239
      3100635A5200BDB5AD00F7F7F70000000000FFFFFF0094949C00A59CA500A59C
      9C00ADA5AD00ADA5A500948C94008C8C9C00848494008C8C9400A59CA500A5A5
      AD0084848C0094949C009C949400B5ADAD00B5ADAD00B5ADA500B5A5A500ADA5
      A500ADA5A500DED6DE00C6C6C600DED6D600FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDAD9400734A2900847352007B634A00F7EFD600AD9C840084735200AD94
      7B00635239008C735A009CDEDE004ACEE7008CB5B500DECEAD00845231003921
      08007B5A31009C847300FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF007B8C9C00426373004263730031526300395A6B003152
      6300314A63003142520042394200C69C94008473730039394A00423942004A4A
      5200424A5A00424A5A00424A5A00424A5A00424A5A0039526300738494000000
      00000000000000000000000000000000000000000000BDBDBD00393931003131
      2900313129003131290031312900393129003931290039312900393931003931
      310042393100635A5200ADA59C00FFFFFF004A4A420039312900313129003131
      2900313129003131290031312900313129003131290039312900393131004239
      31006B6B6300F7F7F7000000000000000000000000009C9CA5009C949C009C94
      9400ADA5A500B5A5A500948C9400848494007B7B8C00A59C9C00BDA5AD00BDAD
      AD00AD9CA50084849400B5ADAD00B5ADAD00A59C9C00A59CA500BDB5B500DED6
      D600D6CECE00BDB5B50084848C007B7B7B00BDB5B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DECEBD0063391000C6AD94009C8C6B00A58C73006B5A42008C735A00EFE7
      CE00CEC6A500B5A58C00E7DEC6007B73A5007B6B9400D6CEB5009C7B52004221
      10006B4A29007B634200E7DED600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008C9CAD00396373004263730039526300395A6B0039526B00314A
      6300314A5A00314252004A394200DEBDB500D6B5AD0039394A00424252003139
      420042424200525252004A525A0042526300424A5A00394A5A0042526300949C
      AD00FFFFFF0000000000000000000000000000000000000000005A5A52003931
      2900313129003131290031312900313129003131290031312900393129003939
      31004A4239008C847B00000000000000000073736B0039393100313129003131
      2900312929002929290029292900292929002929290029292900313129003131
      29005A5A5200B5ADAD00FFFFFF000000000000000000ADADB5009C949C009C94
      9C009C949C00ADA5A5008C8494007B7B8C007B7B8C00BDADAD00D6BDBD00C6B5
      B500A5949C00847B84009C949C00A59C9C009C9CA500A59CA500BDB5B500E7D6
      D600DECECE00BDB5AD0073737B002921210042393100FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFE7006B421800AD947300634A3100A58C6B00E7E7CE009C8C7300A594
      730094846B006B5239009C8473007B7BDE004239DE009C8CA500D6C69C006B42
      21004A291800845A3900A5948400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5ADB500395A6B00425A7300314A630031526B0031526300394A5A00314A
      5A00294A520029394A005A424200D6948C00D69C94003131420039394A003939
      52003142520039425200524A5200635A63004A525A0042526300424A5A00424A
      5A00CED6D60000000000000000000000000000000000000000008C8C84003939
      3100313129003131290031312900312929003129290031292900313129003131
      290039313100ADADA500E7E7DE00CECEC6009C948C0063635A00736B63008C84
      7B00736B63004A4239004A423900524A42005A524A00635A52006B635A007B6B
      6300847B6B007B736B00D6D6CE000000000000000000E7E7E7008C8C9C009494
      940094949400948C94008C848C0031394200948C9C00CEB5B500CEB5B500BDAD
      AD00948484005252630031394A00525A63008C848400948C8C00A59C9C00C6B5
      AD00C6B5AD00A594940063636300525252004A393900F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C63420084634200BDAD94009C846300AD9C8400634A31009484
      6300E7DEC600D6CEAD00EFEFD600EFEFDE00EFEFDE00F7EFD600EFEFCE009C6B
      4A00392108007352310084634A00EFE7E7000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFEF
      EF0042637300395A7300314A5A00294A5A00294A5A0031425A00294252002942
      520029425200293142006B4A4A00DEA59400CE94840031314200313142003139
      4A0031394A003139520039425200394252005A525A006B636B00395263004252
      6300ADB5BD0000000000000000000000000000000000E7E7E700A5A59C00635A
      5200635A5200736B6300524A42003931310039393100424239004A4A42005252
      4A005A5A52006B635A0073736B006B635A00635A520052524A006B635A00736B
      63007B6B63007B736B008C7B730094847B009C8C84009C9484009C948C009C94
      8C00A59C9400B5AD9C00CECEC6000000000000000000FFFFFF00BDBDC6008C8C
      940094949400948C94008C848C0073737B004A5263007B7B8400AD9CA500AD9C
      9C007B7373006B63730029394A00424A5A00847B8400948C8C00AD9C9C00CEBD
      B500C6B5AD009C8C8C0063636300635A5A005252520094949C009C9CAD00ADB5
      B500BDC6C600D6D6DE00EFEFEF00000000000000000000000000000000000000
      000000000000B5A58C006B391800B5A58400634A2900C6B59C00E7DEC600EFEF
      CE00EFEFCE00E7E7C600EFEFCE00CEC6A500947B5A00947B5A00DED6B500CEAD
      8C00523118005A392100845A3900B5A594000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5B5
      BD00395A730029425200213142002942520021394A0029394A00213142002131
      420021314200292939005A424200C6948C00C68C7B0031293900292939003131
      420031314A0031394A0039395200314252003942520039425200394252004252
      6300949CAD00000000000000000000000000C6C6C6006B635A00736B63004A4A
      420073635A00736B6300736B63007B736B008C7B7300948C7B009C9484009C94
      8C00A5948C00ADA59C007B736B007B7B7300948C8C0094949400949494009494
      940094949400949494008C8C8C008C8484008484840084848400848484008484
      840084847B00C6B5B500CEC6C600000000000000000000000000FFFFFF00CECE
      D600ADADB500394252004A4A5A005A5A6300736B73007B7B8C00948C94009C94
      9C00A59CA500ADA5AD00ADA5A500A59CA500A59CA500A59C9C00A59C9C00AD9C
      9C009C948C008C7B84007B737B007B737B007B7B840084848C007B848C00737B
      840073737B006B737B007B848C00000000000000000000000000000000000000
      000000000000E7DED60073421800AD8C7300C6B59C00EFE7CE00E7DEBD00EFE7
      C6008C7B5A00735239009C846300AD9C7B009C846300ADA58400EFE7C600DED6
      B500845A3900422110007B5A31008C6B5200F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF004A63
      7300294252002929390021314200213142002129390021293900212931001821
      3100182931002121290031293100392931005239420031293100312939003129
      3900293142003131420031394A0039394A00394252003942520039424A003952
      6300848C9400000000000000000000000000C6C6C600736B63008C8C8C009494
      9400949494009C9C94009C9494008C8C8C008C8C8C0084848400848484008484
      8400848484009C948C009C949400847B73007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7300CEC6BD00CEC6C600000000000000000000000000000000000000
      0000C6C6CE009C949C00A59CA500A5A5A500ADA5A500ADA5A500ADA5A500ADA5
      AD00ADADAD00B5ADAD00B5ADAD00B5ADAD00BDADAD00BDADAD00BDB5AD00BDAD
      AD00ADA5A5009C949C0094949400948C94008C8C8C0084848C007B7B8400737B
      840073737B006B737B007B848C00000000000000000000000000000000000000
      000000000000FFFFFF008C6B4A00946B4200E7DEBD008C7B630073523900BDAD
      8C00A5947300BDA58400EFE7C600EFEFC600F7EFCE00E7E7BD00CEE7B500D6D6
      AD00AD846300422910006B4A290084634200C6BDAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7EF002931
      420021394A002129390021293900212131002121290021212900181829001821
      2900101821002921290031293100312931003129310031292900312929003129
      31003129390031314200313142003131420031394A0031395200313942004239
      42005A6B7300000000000000000000000000F7F7F7007B736B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B009C948C00BDB5B5007B7373007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      730073737300CEC6BD00D6CEC60000000000000000000000000000000000FFFF
      FF00948C9C00A59C9C00A59CA5008C8484007B737B007B7373007B7373007B73
      73007B6B73007B6B7300736B6B00736B6B00736B6B007B737300BDB5AD00BDB5
      AD00B5ADA500948C94009C9494008C8C8C008C8C8C00848484007B7B8400737B
      840073737B006B737B007B848C00000000000000000000000000000000000000
      00000000000000000000C6B59C0073421800D6C6AD009C8C6B00C6B59400EFE7
      C600EFEFCE00DEDEBD00C6DEB500ADDE9C0084BD630063B54A0052BD6300A5C6
      9400CEB58C006B4A290052311800845A39008C7B6300FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000BDC6C6002131
      3900212939002121310018212900181821001818210018182100181821001010
      1800181821004A39420042394200312931003129310029293100211821002921
      2100292121002929290031313900293142003139420031394A00313142004242
      4A0039424200000000000000000000000000000000008C8484007B7B7B007373
      7300737373007373730073737300737373007373730073737300737373007373
      730073737300948C8C00D6C6C600847B7300737373006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B00CEBDBD00D6CECE0000000000000000000000000000000000EFEF
      EF00ADA5A500A59C9C00A5949400524A4A002118210021182100212129002118
      29001818290021182900211821002121210021182900211821008C848400BDB5
      AD00BDB5AD00948C8C0094949400948C94008C8C8C00848484007B7B8400737B
      84006B737B006B737B00737B8400FFFFFF000000000000000000000000000000
      00000000000000000000F7F7EF00845A2900B5A58400DEDEBD00C6DEAD00A5E7
      A50084EF9C0063EF9C005AF7940052EF8C004AD66B0052E784005AFF940084D6
      9400DECEAD00946B4200422110007B52310084634200DED6CE00000000000000
      00000000000000000000000000000000000000000000000000009C9CA5001818
      2100181821001018210010181800101818001010180018101800181018001810
      18004A4242005A4A52005A4A52005A4A5200524A4A0039394200313139003129
      3900292931002921290029212100292929003131390031314200312939003929
      210031313900FFFFFF00000000000000000000000000B5ADAD007B7373006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363008C8C8400CEBDB500948C84007B73730063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      630063636300CEBDB500DED6CE0000000000000000000000000000000000EFEF
      EF00ADA5A500A59C9C00AD9C9C00635252001818210018182100211821002121
      2900211821002118290021182100211821002118210021182100847B7B00BDB5
      AD00BDB5AD00948C940094949400948C94008C8C8C00848484007B7B8400737B
      7B006B737B006B6B730073737B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000BD9C8400946B4200E7E7C60073D694004AFF
      940042F7940042EF8C0042EF8C0052FF9C0052EF8C005AFF9C005AFF9C006BF7
      9C00B5B59400B58C6B005A311800634221008C634200AD9C8C00FFFFFF000000
      00000000000000000000000000000000000000000000000000007B7B84001818
      2100101018001010180010101000101018001010100010101800181018004239
      42005A4A52005A5252005A4A52005A4A52005A4A52005A525200736B6B004A4A
      5200313142003131420031313900312931002921210029212100292931001810
      180029212900F7F7F700000000000000000000000000DEDED6007B736B005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A00847B7B00CEC6BD00A59C9C007B736B005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A00C6B5AD00D6C6C60000000000000000000000000000000000EFEF
      EF00ADA5A500A59C9C00A59C9C00635252002118210018182100211821002121
      2900211821002921310029213100211821002121290021182900847B7B00BDB5
      B500BDB5AD00948C940094949400948C8C008C848C00848484007B7B8400736B
      73006B6B6B00636B73006B737B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000F7EFE7007B523100DECEAD009CD69C0052FF
      9C0042FF940052F78C004AE77B004AEF840052EF84005AF794005AF794005AFF
      9C008CBD8400CEB58C00845A31004A291000845A390094735200F7F7EF000000
      000000000000000000000000000000000000000000000000000063636B001018
      1800101018001010180010101800101010001008100010101000423942005252
      52005A5252005A525200524A52005A4A52005A525A00847B7B00C6BDB500CECE
      CE00B5ADAD006B636B0039394200313942003939420031293100312929003931
      420039394A00F7F7F700000000000000000000000000FFFFFF00847B73005252
      5200525252005252520052525200525252005252520052525200525252005252
      520052525200736B6B00CEC6BD008C8C84007B736B0052525200525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      520052525200BDADA500C6BDB50000000000000000000000000000000000EFEF
      F700AD9CA500A59C9C00A59C9C00635252002118210018182100211821002118
      2900292129002921310039313900423139002929310021212900847B7B00BDB5
      AD00BDB5B5009C949C009C94940094949400847B840073737B00737373007B7B
      7B0073737B006B737B00636B7300F7F7F7000000000000000000000000000000
      000000000000000000000000000000000000BDA58400A58C6300DEDEBD005AE7
      8C004AFF940052FF9C0052FF940052FF940052FF9C005AFF9C0052F794004AEF
      8C0084CE9400E7DEB500AD7B4A00422910007B523100946B4A00D6C6BD000000
      000000000000000000000000000000000000000000000000000039424A001010
      2100101018001810180010101000100810001010100042424200525252005A52
      52005A525200524A4A005A4A52005A525A00635A6300DED6AD00C6BD9C00FFFF
      F700DEDED600EFEFEF00CECEC6008C8C8C004A4A520042394200392931004239
      42004A424A00FFFFFF00000000000000000000000000000000009C9C94005A5A
      5A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A0063635A00CEC6BD00948C8C008C847B005A5A52004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A00ADA59C00BDB5AD00F7F7F700000000000000000000000000FFFF
      FF00B5B5B500A59C9C00A59C9400736363002121290021182100211829002118
      21003931310021182100212129002118210021182900211821007B737300B5AD
      AD00B5A5A500CEC6BD00948C8C00848484008C848C0084848C007B7B8400737B
      7B0073737B006B737B00636B7300F7F7F7000000000000000000000000000000
      000000000000000000000000000000000000F7EFEF00946B4A00E7DEB50084D6
      940052FF940052FF940042EF8C0052EF8C006BEF9C008CEFA500B5EFBD00DEF7
      D600F7F7DE00E7DEBD00C6A57300634221005A392100946B4A00B59C8C000000
      00000000000000000000000000000000000000000000FFFFFF00292939001818
      2100181018001010180010101000181010004A4242005A5252005A525A005A52
      52004A424A005A4A52005A525A005A5252005A525A007B6B6300ADA58C00D6CE
      C600CECEBD00C6C6B500DED6CE00D6D6CE00635A5A005A525A005A5252005242
      4A0052525A000000000000000000000000000000000000000000C6BDBD00635A
      5A004A4242004A4242004A4242004A4242004A4242004A4A4A0052524A005252
      4A00524A4A005A5A5200C6BDB5008C848400847B7B00635A5A004A4242004242
      42004242420042424200424242004A4A42004A4A4A00524A4A0052524A00524A
      4A004A4A4A009C948C00BDADA500F7F7F700000000000000000000000000E7DE
      E700A5949400A5949400A59C9C006B5A5A002118210018182100211821002118
      29002118210018182100211829002118290021182900211821007B737300ADA5
      A5009C8C8C00A59C9C009C949400949494008C8C8C0084848C007B7B8400737B
      7B0073737B006B73730063737B00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000CEBDA500BDA57B00C6DE
      AD007BD69C0094DEA500ADCEA500BDCEB500E7EFCE00F7EFD600EFEFCE00EFEF
      C600E7DEB500D6C6AD00DEC69C0094633900391808008C634200947B5A00F7F7
      F7000000000000000000000000000000000000000000F7F7F700181829001818
      21001818210010101800101018005242420063525A0063525A005A5252004A42
      4A005A5252005A525A005A525A005A525A0063525A005A525A005A525A00635A
      5A00948C9400C6BDB500C6BDAD00736B6B005A525A0063525A005A525A00736B
      6B00D6D6D6000000000000000000000000000000000000000000F7F7F700DED6
      D600CECEC600C6BDBD00B5ADA500A59C9400948C84008C847B008C847B008C84
      7B00948C84009C948C00B5A59C0073736B0073736B0084847B0094948C008C84
      8400948C8400948C84008C847B008473730084737300847B73008C847B00948C
      84009C948400AD9C9400ADA59C00F7F7EF00000000000000000000000000CEC6
      C600B5ADAD00ADA5A500A59C9C006B5A5A001818210018182100211821002121
      29002118210021182100211829002118290021182900212121007B6B6B00BDB5
      AD00ADA59C00ADA5A5009C949400949494008C8C8C00848484007B7B8400737B
      7B0073737B00848C9400DEDEDE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFF700B5946B00DECE
      B500B5AD9400DED6BD00EFE7C600EFE7BD00D6CEA500D6BDA500BDAD94009484
      6B007B6B5A007B5A4A00B5A57B00B58C5A007B5231008C63420063422100E7DE
      D6000000000000000000000000000000000000000000DEDEDE00212939001821
      310018182100181821004A424A00635A5A00635A5A005A52520052424A005A52
      52005A525A0063525A005A525A005A525A005A525A005A525A005A525A005A52
      5A005A525A0063525A006B6363005A525A005A525A0063525A009C9C9C00F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6CE
      CE00736B6B006B6B6B00636363005A5252005252520052525200525252005252
      52005252520052525200CEC6BD00DED6D600F7F7F700EFEFEF00EFE7E700EFE7
      E700DEDED600D6D6CE00DED6D600000000000000000000000000FFFFFF00C6B5
      B500BDADAD00B5ADA500A59C9C00736363001818210018182100211821002121
      2900211829002118210021182900211821002118210021212900736B6B00BDB5
      B500948C8C00A59C9C009C949400948C94008C8C8C00848484007B8484007B7B
      8400B5B5BD00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFDED600C6A5
      8400CEBD9C00BDA58C0094846B007B6B5A0073635200634A3900634A31007B52
      31007B5A390073523100AD9C8400DEBD9C009C6B4200946B4A0073523100BDB5
      A5000000000000000000000000000000000000000000C6CED60029314A002129
      39002129310052424A005A525A005A525A00524A4A0052424A005A5A5A006352
      5A005A525A005A525A005A525A005A525A005A525A005A525A005A525A005A52
      5A005A525A005A525A0063525A0063525A006B636B00D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700736B63004242420042424200424242004242420042424200424242004242
      4200424242004A4A4200BDB5AD00D6D6CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFEFEF00C6B5
      AD00BDADAD00BDADAD00ADA59C00847373004239420039313900393131003939
      39002929310029212900292129002121210018182100181821006B636300B5AD
      A500948484009C9C9C009C949400949494008C8C8C00848484009CA5A500EFEF
      EF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00C6AD
      8C00AD9473006B4A3100735231006B52310073523100735239007B634A009C8C
      6B00C6B59C00E7E7CE00F7F7DE00EFDEBD00AD7B52008C5A39008C634200A594
      7B000000000000000000000000000000000000000000BDC6CE00293952002931
      420042394A0042424A0042424A00423942004A424A00635A5A005A5A5A00635A
      5A0063525A005A525A005A525A0063525A0063525A0063525A005A525A005A52
      5A005A525A005A5263005A525A008C8C9400EFEFF70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5ADAD00948C8400847B7300736B63006B635A00635A5A00736B63007B73
      6B00847B7300847B7300B5A59C00CECEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6CED600C6B5
      AD00BDB5AD00BDADAD00BDADAD0094847B00736B6300736B630073635A00524A
      4200423939004231310039313100312929001818210018181800847B73008484
      8400AD9C9C00A59C9C009C949400949494009C949C00D6D6D600FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      EF00BD9C7300C6B59400BDAD8C00C6BD9C00D6CEB500EFE7C600F7F7D600EFF7
      D600EFEFD600EFF7CE00EFF7CE00F7EFCE00BD8C5A008C5A39008C634200BDA5
      94000000000000000000000000000000000000000000DEE7E7006B737B004A4A
      5A0039394A00393142003131390042424A004A4A5200524A5A0052525A005252
      5A005A525A005A525A005A525A005A525A0063525A005A525A005A525A005A52
      5A0052525A00635A6B00BDBDC600FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFF7F700EFEFEF00E7E7E700DEDE
      DE00DED6D600D6CECE00D6CECE00EFEFEF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00C6B5B500C6B5
      AD00B5A59C00BDADAD00C6B5B500BDADAD00B5A5A500ADA5A500ADA5A500ADA5
      A500ADA5A500ADA5A500ADA59C00A59C9C00A59C9C00ADA59C00C6BDB5006B63
      6300B5ADA500A59C9C00A59C9C00C6C6C600F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFD6CE00BD9C7300EFEFC600EFEFC600EFEFCE00EFEFCE00EFEFC600EFEF
      C600EFE7CE00EFEFC600EFE7C600EFDEBD00BD8C5A00A57342008C633900BDAD
      9C0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDC600848C94005A5A73003939520039394A0039395200394252004242
      5200424252004A4252004A4252004A4A52004A4A5A00524A5A004A4A52004A4A
      5A0094949C00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700B5A5A500BDA5
      A500B5A5A500AD9C9C00AD9C9C00B5A5A500C6B5B500CEBDB500CEBDB500CEBD
      B500C6BDB500C6BDB500C6BDB500CEBDBD00CEC6BD00CEC6BD00A5949400847B
      7B00B5A5A500BDB5B500EFEFEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6C6AD00BD9C7300EFDEB500EFE7C600E7E7C600E7E7C600EFDE
      C600EFDEBD00E7DEBD00E7DEBD00DEBD9400BD845200B57B4A008C5A3900C6B5
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700CECED600949CAD005A6373003939
      520031394A0039394A0039394A0039394A0039395200525263009C9CA500E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFF7F700B5B5BD00AD9C
      A500948484009C8C8C009C8C8C009C8C8C00948484009C8C84009C948C00A59C
      9400AD9C9C00AD9C9C00AD9C9C00AD9C9C009C949400948C8C008C8C8C00E7DE
      DE00E7E7E700FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00CEB59C00BD8C6300CEAD8C00DECEAD00E7D6B500E7D6
      B500DED6B500DECEAD00CEB58C00B5845A00BD845200B57B4A009C734A00D6C6
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700BDC6CE00A5A5B5007B849400737B8C00ADB5BD00F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7DE00DEDEDE00DED6D600DEDE
      DE00DEDED600E7E7E700E7E7E700E7E7E700F7F7F700FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00CEB59C00BD8C5A00BD845A00BD8C6300BD94
      7300BD946B00B58C5A00B5845200B5845A00BD8C6B00C6A58400CEB5A500FFFF
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00DECEBD00C69C7B00C69C7B00CEAD
      9400D6BDA500DECEC600EFDED600F7F7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6D6D6009C949400736B6B00635252006363
      63005A5A5200736B6B00B5ADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6D6D6009C949400736B6B00635252006363
      63005A5A5200736B6B00B5ADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFF700A5A59C00635A5200524A
      420073736B00C6C6BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6CECE00A59C9C007B7373006B6B6B007373730073737300636363003939
      3900313131006363630063636300635A5A008C847B00CEC6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6CECE00A59C9C007B7373006B6B6B007373730073737300636363003939
      3900313131006363630063636300635A5A008C847B00CEC6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00F7F7F700DEDEDE00ADADAD007B7B7B005A5A5A007373
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700524A420010080000100800001008
      00001810000029181000736B6300EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5AD00948C84006B63
      63006B6B6B006B6B6B00736B73006B6B6B005A525A005A5A5A006B6B6B004242
      420031313100636363005A5A5A0063636300524A4A003939390052525200BDB5
      AD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5AD00948C84006B63
      63006B6B6B006B6B6B00736B73006B6B6B005A525A005A5A5A006B6B6B004242
      420031313100636363005A5A5A0063636300524A4A003939390052525200BDB5
      AD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00EFEFEF00B5B5
      B500848484005252520031313100182121002129290039394200635A5A006B63
      630084737300BDB5AD00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF007B7B6B001008000018080000181000001008
      00001808000021180800312918006B5A5200EFEFEF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6B5B50063636300636363006B63
      6B006B636B006B636B006B6B6B005A5A5A0052525200525252006B6B6B004A4A
      4A0029292900636363004A4A4A006B6B6B00525252004A42420039393900BDAD
      AD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6B5B50063636300636363006B63
      6B006B636B006B636B006B6B6B005A5A5A0052525200525252006B6B6B004A4A
      4A0029292900636363004A4A4A006B6B6B00525252004A42420039393900BDAD
      AD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00CECECE00313131001821
      21002931310042424200525A5A006B7373007B8484007B7B7B005A525200736B
      63008C7B73008C7B7300DED6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E700211808001008000018100000181008001810
      0800292110003931290039312900423129008C7B7300FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000524A4A004A4A4A00635A
      5A00636363006363630063636300525252005A5A5A0063636300737373005252
      5200313131005A5A5A004A4A4A00636363005A525A004A4A4A0042424200BDB5
      B500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000524A4A004A4A4A00635A
      5A00636363006363630063636300525252005A5A5A0063636300737373005252
      5200313131005A5A5A004A4A4A00636363005A525A004A4A4A0042424200BDB5
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF0052525A0042424A006B6B
      6B0073737300737B7B007B7B7B007B7B7B00847B7B006B6B6B005A5252007363
      630094847300947B7300ADA59C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A59C00100800001808000018100800423931007363
      6300847B7B008C7B73008C7B7B0094848400B5A5A500EFEFE700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A524A004A424A004A4A
      4A00635A63005A5A5A004A4A4A00423942006B6B6B0073737300848484005A5A
      5A00313131004A4A4A006B6B6B006B6363005A5A5A004A4A4A0042424200A594
      9400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A524A004A424A004A4A
      4A00635A63005A5A5A004A4A4A00423942006B6B6B0073737300848484005A5A
      5A00313131004A4A4A006B6B6B006B6363005A5A5A004A4A4A0042424200A594
      9400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADADAD00393939006B6B6B007373
      73006B7373006B6B73006B6B6B006B6B6B006B6B6B006363630052524A007363
      63008C7B7300635252009C8C8400EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B736B0018080000211810006B5A5A00948484008C84
      84008C8484008C848400847B7B007B6B6B00948C8C00D6CEC600FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084737300424242003131
      310021182100181018002929290042424200737373007B7B7B007B7B7B006363
      630039393900393939006B6B6B0063636300635A5A004A4A4A00424242008473
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084737300424242003131
      310021182100181018002929290042424200737373007B7B7B007B7B7B006363
      630039393900393939006B6B6B0063636300635A5A004A4A4A00424242008473
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF007B7B7B0039393900636363005A5A
      63005A5A63005A5A5A0052525A00525252005A5A5A005A5A5A00524A4A006B63
      5A008C7B7300736363007B736B00D6D6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B6B5A00211810006B635A00948C8C008C8484008C84
      84008C84840094848C009C949400948484006B635A00AD9C9C00F7EFEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000948C8400313131003939
      39004A4A4A005A5A5A00636363006B636B006B6B6B00737373007B7B7B006B6B
      6B0042424200313131005A5A5A0063636300635A5A005252520042424200635A
      5200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000948C8400313131003939
      39004A4A4A005A5A5A00636363006B636B006B6B6B00737373007B7B7B006B6B
      6B0042424200313131005A5A5A0063636300635A5A005252520042424200635A
      5200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00736B6B0039393900525252005252
      5A007B7B7B0094949C00B5B5B500D6D6D600636B6B005A5A5A00524A4A006B63
      5A0094847B0084736B00635A5200C6BDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084847B00635252008C847B008C8484008C8484009C94
      9400A59C94009C8C84008C8C5A008C8C420084736B006B635200D6D6CE00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5B5004A4A4A00524A
      4A00524A52005A525A005A5A5A005A5A63006363630063636300636363006363
      63004A4A4A002929290042424200636363005A5A5A0052525200423942004242
      3900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5B5004A4A4A00524A
      4A00524A52005A525A005A5A5A005A5A63006363630063636300636363006363
      63004A4A4A002929290042424200636363005A5A5A0052525200423942004242
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00736B6B00B5B5AD00E7DEDE00EFEF
      EF00F7F7F700FFFFFF00EFEFEF00F7F7F700949494004A4A520042424200635A
      5A009C847B0084737300635A5A00BDB5B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6BDBD007B6B6B00948C84009484840094848C008C73
      63009C5200009C5A2100737B31008C9C00008C941000635A5200948C8400FFFF
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4242004A42
      4A004A4A4A0052525200635A63006B6B6B007373730084848400949494009C9C
      9C006B6B6B002929290031313100636363005A5A5A005A525A00423942003939
      3900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4242004A42
      4A004A4A4A0052525200635A63006B6B6B007373730084848400949494009C9C
      9C006B6B6B002929290031313100636363005A5A5A005A525A00423942003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF006B636B00C6BDBD00CECED600C6C6
      CE00B5B5C600BDBDC6009C9CB500C6B5F700AD9CCE00313139004A4A4A005A52
      5200A58C840084736B00635A5200BDB5B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E7007B736B00948C8C00847384005A39CE00735A
      7300945A31008C6B630073735A0094A52900ADB552007B735A00635A4A00E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEC6C600BDB5B500948C8C005A5A5A006363
      63006B6B6B00737373007B7B7B008484840084848C008C8C8C00949494009494
      9400737373003131310029292900636363005A5A5A005A5A5A00424242003939
      3900D6CECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEC6C600BDB5B500948C8C005A5A5A006363
      63006B6B6B00737373007B7B7B008484840084848C008C8C8C00949494009494
      9400737373003131310029292900636363005A5A5A005A5A5A00424242003939
      3900D6CECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF006363630073737300BDADEF00846B
      DE003918A5002908B5002900BD002900B5005231D600737373004A4A4A005A52
      5200AD948C008C7B7300736B6300BDB5B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00948C840094848C0063429C005229E7006B52
      B5005A4A4A004A4239006B635A008C8463007B735A00635A5200524A4200C6BD
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      D6007B7373005A5A5A00524A4A0052525200525252005A5A5A005A5A5A006363
      63006B636B00736B73007B7373007B7B7B00848484008C8C8C008C8C94009494
      94007B7B7B0042424200212121005A5252005A5A5A005A525A00424242003939
      3900BDB5B500000000000000000000000000000000000000000000000000DEDE
      D6007B7373005A5A5A00524A4A0052525200525252005A5A5A005A5A5A006363
      63006B636B00736B73007B7373007B7B7B00848484008C8C8C008C8C94009494
      94007B7B7B0042424200212121005A5252005A5A5A005A525A00424242003939
      3900BDB5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00635A5A00424242007B63C6004218
      CE005231B5004A398C00424273004A426B0039424A0029313900424242005252
      52009C8C7B00BDA59C00B59C8C00BDB5B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6BD009484840063429C008473E700735A
      CE0073636300635A52006B635A00635A5A004A4242006B5A5A00635A5200948C
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00524A52005252520052525200525252005A525A005A5A5A00635A
      6300636363006B6B6B00737373007B7B7B00847B8400848484008C8C8C008C8C
      8C007B7B7B004A4A4A0029292900524A4A005A5A5A005A525A004A424A003939
      3900BDB5B5000000000000000000000000000000000000000000000000000000
      00004A4A4A00524A52005252520052525200525252005A525A005A5A5A00635A
      6300636363006B6B6B00737373007B7B7B00847B8400848484008C8C8C008C8C
      8C007B7B7B004A4A4A0029292900524A4A005A5A5A005A525A004A424A003939
      3900BDB5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00635A630039394200313131002931
      390021213100292939003939420042424A00525252004A4A4A00424242005252
      52009C847B00AD9C9400B59C8C00BDBDB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700948C8C0084737B0073638C006B5A
      63007B6B6B003129210063524A008C848400736363005A4A4A005A524A00635A
      5200F7F7EF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6300524A4A0052525200524A5200524A5200525252005A5A5A00635A
      6300636363006B6B6B00737373007373730073737300737373007B7B7B007B7B
      7B0084848400948C8C00313131007B7373005A5A5A005A525A004A4A4A003939
      3900CEC6C6000000000000000000000000000000000000000000000000000000
      00006B6B6300524A4A0052525200524A5200524A5200525252005A5A5A00635A
      6300636363006B6B6B00737373007373730073737300737373007B7B7B007B7B
      7B0084848400948C8C00313131007B7373005A5A5A005A525A004A4A4A003939
      3900CEC6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF006B63630039393900424242005A5A
      5A00635A5A00635A5A00636363006363630063635A005A5252004A424A005252
      520094847B00948C8400A59C9400CEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6BDBD008C7B7B0042393100524A
      42007B736B007B6B6B005A524A00635252005A524A007B6B63006B635A00524A
      4200DED6D6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A59C9C0042394200525252007B7B7B007B7B7B0084848400848484008484
      8400848484008484840084848400848484008484840084848400848484007B7B
      7B0073737300848484004A4242008C8C8C006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A59C9C0042394200525252007B7B7B007B7B7B0084848400848484008484
      8400848484008484840084848400848484008484840084848400848484007B7B
      7B0073737300848484004A4242008C8C8C006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00736B6300393939005A5252006363
      5A006363630063636300636363006B6363006B6B6B006B63630031313100524A
      4A008C7B73009C8C8C00B59C9400CEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700948484008C7B7300524A
      4200524239006B5A5A00635A52007B6B6B00847B7B00393129005A4A4200635A
      5200A59C9C00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE004A42420042424200848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484007B7B
      7B00736B73007B7B7B005A5A5A008C8484006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE004A42420042424200848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484007B7B
      7B00736B73007B7B7B005A5A5A008C8484006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0073736B00313131005A5A5A006B6B
      6B0073736B00737373007B7B7B007B7B7B007B7B73007B73730039393900524A
      4A0084736B00B5A59400BDA59400CEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5B500847373005A4A
      4A00635A52008473730042393100524242007B736B007B6B6B00948484007B73
      6B00736B6300F7F7EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5A00312931007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007373
      73006B6B6B007B737B00736B6B006B6B6B007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5A00312931007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007373
      73006B6B6B007B737B00736B6B006B6B6B007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C847B00393939006B6B6B007B7B
      73007B7B73007B7B73007B7B73007B7B73007B7373007B737300393939004A4A
      4A007B6B6300BDA59400BD9C9400CEC6BD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFEFEF0094847B006352
      520039312900635252007B736B008C7B7B00948484008C7B73009C633900A56B
      3900736B6300BDBDB500FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000948C8C0031313100636363007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      73006B6B6B0073737300737373005A5A5A007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000948C8C0031313100636363007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      73006B6B6B0073737300737373005A5A5A007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C948C00393939006B6363007B73
      73007B7373007B7B73007B7B73007B7B73007B7B73007B737300424242004A42
      420073635A00BDA59400C6A59400C6C6BD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00B5ADAD008C7B
      7B00847B73008C7B7B00948484008C5A4200AD6B310094736B00A57B63009C8C
      8400948C8C0084737300EFE7E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6BDBD0042424200424242007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      73006B6B6B006B636B00737373005A5A5A0073737300847B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6BDBD0042424200424242007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      73006B6B6B006B636B00737373005A5A5A0073737300847B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADA59C00393139006B6363007B7B
      7300847B7300847B7B00847B7B00847B7B007B7B7B007B7B7B004A424A004A42
      42006B635A00BD9C9400BD9C8C00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7DEDE009484
      8400845A4A00AD6B39009C734A00A57B6300AD8C7B00A5949400A59C9400A594
      9400A5949400948C8400A59C9C00F7F7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052524A00313131006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B00636363006B6B6B00525252006B6B6B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052524A00313131006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B00636363006B6B6B00525252006B6B6B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDB5B50031313100635A5A00847B
      7B00847B7B00847B7B00847B7B00847B7B0063636300424242004A4A4A004A42
      42006B5A5A00947B7300AD948400BDBDB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF009C8C
      8C009C8C7B00AD948400ADA59C009C94940094848C006B636300524242004239
      3900524A4A00847B73009C8C8C00BDB5B500FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000847B7B0031313100636363006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B0063636300635A5A0063636300525252006363630073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000847B7B0031313100636363006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B0063636300635A5A0063636300525252006363630073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECEC600313131005A5A52003939
      3900424242004242420042424200212929002929290021292900424242004A42
      42006B5A5A00393931006B636300BDBDB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5AD
      AD009C949400948C8C008C848400524A4A001008080018101000100808002118
      1000393121004A42310063524200948C8400D6D6CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00424242004A4A4A0063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363005A5A5A00636363005A5A5A004A4A4A0063636300949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00424242004A4A4A0063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363005A5A5A00636363005A5A5A004A4A4A0063636300949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7DEDE00393931005A5252002129
      290052524A00394239005A5A5A0063635A005A5A5A00293131004A4242004A42
      4200635A5A00524A420042424200BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6BD
      BD0094848C00847B7B0029212100181008001008080021181000312918004A4A
      2900737B42007B9452006B735A00423929008C8C8400FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE005A5A5A00393939005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A005A525A005A5A5A00635A5A004242420052525200A59CA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE005A5A5A00393939005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A005A525A005A5A5A00635A5A004242420052525200A59CA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF0042423900424242003942
      4200424A4200212929003939390039393900393939004A4A4A00393939004A42
      4200635A52005A524A0042424200BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600948484002921210010080800312918004A523100638439006B943900738C
      3900739C42007BAD520073946300313118004A423100EFEFE700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B737300313139005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A00525252005A525A005A5A5A004A424200525252009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B737300313139005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A00525252005A525A005A5A5A004A424200525252009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00524A4A00393939003939
      3900424242004242420042424200393939003939390042393900423939004A42
      4200635A5200736B63004A4A4200BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEC6
      C600635A5200292918004A7331005A94390063943900639439006B9C42006B9C
      4200739C420073A5520073A563004242310039311800DED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADA5A500424242004A4A4A00525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      52005252520052525200525252005A525200424242004A4A4A008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADA5A500424242004A4A4A00525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      52005252520052525200525252005A525200424242004A4A4A008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0063636300393131003939
      3900393939003939390039393900393939004239390042394200424242004A42
      42006B635A007B6B5A0073635A00C6BDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DED6
      D60042393100524A4200529442005A943900638C3100639431006B9439006B9C
      4A006BA5520073A55A007B9463005A5A42004A422900D6CECE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6CECE00635A5A0039393900525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      520052525200525252004A4A4A00525252004242420042424200737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6CECE00635A5A0039393900525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      520052525200525252004A4A4A00525252004242420042424200737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007B7B7300393939003939
      3900393939004239390042393900393939004A42420052524A00635A52007B6B
      5A009C846B009473630084635200CEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F70042423900211810006B8C63005A94390063943900639C4A006B9C5A007394
      63007B846B0063635200423929004A423100948C8400D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737373004A4A4A00393939003939
      390031313100424242004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A00525252004A4A4A00524A4A004A4A4A00393939005A5A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737373004A4A4A00393939003939
      390031313100424242004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A00525252004A4A4A00524A4A004A4A4A00393939005A5A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A59C9C0042423900524A
      4200524A4A005A524A005A524A005A52520052524A00524A4A005A5252007B73
      6B00B59C7B009C948400947B7300EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0094948C00180800006B6B5A0063945200738C6300848C730073736B00524A
      4200393121006B635A00A59C94009C9C9400A59C9C00DED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A59CA500737373007B737B007B7B
      7B00737373005A5A5A004A4A4A00393942003939390039393900424242004A4A
      4A004A4A4A004A4A4A00524A52004A4A4A004A4A4A00393139004A4A4A00CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A59CA500737373007B737B007B7B
      7B00737373005A5A5A004A4A4A00393942003939390039393900424242004A4A
      4A004A4A4A004A4A4A00524A52004A4A4A004A4A4A00393139004A4A4A00CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700ADA59C008C73
      5A00847B6B00A594840084737300847B730094847B00948C84008C7B73007B73
      6B00736B6300AD948C00EFEFEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF004A423900313121006B635A006B636300524A4200525242004A42
      3900C6BDB500FFFFFF00FFFFFF00CECECE00A59C9C00D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600A5A5
      A5008C8C8C0073737300848484007B7B7B00636363005A5A5A004A4A4A003939
      390039393900393939004A4A4A004A4A4A004A4A4A00423939004A4A4A00A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600A5A5
      A5008C8C8C0073737300848484007B7B7B00636363005A5A5A004A4A4A003939
      390039393900393939004A4A4A004A4A4A004A4A4A00423939004A4A4A00A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00DEDE
      D600BDADA500B5A59C00AD9C9400A59C9400847B7300524A4A00524A4A004A4A
      4A0042424200EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6D6CE003939290018180000424231005A524A00393121009C94
      8C00EFEFEF00FFFFFF00FFFFFF00F7F7F700B5ADAD00D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00ADA5A500847B7B00635A63005A5A5A005A5A
      5A005A52520052525A0052525200524A4A005A525A009C9C9400A5A5A500BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00ADA5A500847B7B00635A63005A5A5A005A5A
      5A005A52520052525A0052525200524A4A005A525A009C9C9400A5A5A500BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF009C8C840029292900313129003939
      39004A423900C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00C6C6BD006B635A00524A4200635A4A008C847B00BDBD
      B500FFFFFF00000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC6C600ADA5
      A5007B7B7300635A5A00525252005252520052525200CECEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC6C600ADA5
      A5007B7B7300635A5A00525252005252520052525200CECEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDB5A500635A520073736B00948C
      8C00B5B5AD00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00BDB5B50094948C009C949400C6BDBD00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6D6CE00A5A5A500847B7B00CECEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6D6CE00A5A5A500847B7B00CECEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00BDBDB500EFEFE700FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF007FFFFFFFFFFFFFFFFFFFFFFFFFFF
      FC003FFFFFF9FFFFFFFFFFFFFFFFFFFFF8001FFFFFF0FFFFFFFFFFFFF07FFFFF
      F8001FFFFFE03FFFFFFFFFFFC03FFFFFF0000FFFFFC00FFFFFFFFFFF801FFFFF
      F00007FFFF8003FFFFFFF80380001FFFF00007FFFF0000FFFFFE0003800007FF
      F00003FFFE00003FFE000001000007FFF00003FFFC00001F800000010000007F
      F00001FFF800001F800000038000007FF00001FFF0000007C00300018000003F
      F00001FFF0000007C00000018000003FF80000FFE00000078000000180000001
      F80000FFE000000700000001C0000001F800007FC000000700000001F0000001
      F800007FC000000700000001E0000001FC00003FC000000780000001E0000000
      FC00003FC000000380000001E0000000FE00001FC000000380000001E0000000
      FE00001FC000000380000001E0000000FF00001FC0000003C0000000E0000000
      FF00001F80000007C0000000E0000000FF80000F80000007C0000000E0000001
      FF80000F8000000FFFE00001C0000003FFC0000F8000003FFFE000FFC0000007
      FFC0000F8000007FFFF000FFC000001FFFE0000F800000FFFFFE00FF8000007F
      FFF0000FE00003FFFFFFFFFF800001FFFFF8000FFE000FFFFFFFFFFF800003FF
      FFF8000FFFE03FFFFFFFFFFFE0003FFFFFFC000FFFFFFFFFFFFFFFFFFFFFFFFF
      FFFE00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFFFFE01FFFFFF87FFFC0007FF
      FFF0003FFFF0003FFFF803FFFE00FFFFFF80000FFF80000FFF8001FFFC007FFF
      FF00000FFF00000FFF0001FFFC003FFFFF80000FFF80000FFF0000FFFC003FFF
      FF80000FFF80000FFF0000FFFC001FFFFF80000FFF80000FFE0000FFFC001FFF
      FF80000FFF80000FFE0000FFFC000FFFFF80000FFF80000FFE0000FFFC000FFF
      FFC0000FFFC0000FFE0000FFFC000FFFFE000007FE000007FE0000FFFC000FFF
      E0000007E0000007FE0000FFFE0007FFF0000007F0000007FE0000FFFE0007FF
      F0000007F0000007FE0000FFFF0007FFF000007FF000007FFE0000FFFF0003FF
      F000007FF000007FFE0000FFFF8003FFF800007FF800007FFF0000FFFF8001FF
      F800007FF800007FFF0000FFFF8001FFF800003FF800003FFF0000FFFFC000FF
      FC00003FFC00003FFF0000FFFFC0007FFC00003FFC00003FFF0000FFFFE0007F
      FC00001FFC00001FFF0000FFFFE0003FFC00001FFC00001FFF0000FFFFE0003F
      FE00001FFE00001FFF0000FFFFE0003FFE00001FFE00001FFF0000FFFFE0003F
      FE00001FFE00001FFF0000FFFFC0003FFF00001FFF00001FFF8000FFFFC0003F
      FF00000FFF00000FFF8001FFFFF0003FFFC0000FFFC0000FFFC003FFFFF8003F
      FFFC000FFFFC000FFFFE03FFFFF8073FFFFFC03FFFFFC03FFFFF03FFFFF807FF
      FFFFFC3FFFFFFC3FFFFF0FFFFFFE1FFF00000000000000000000000000000000
      000000000000}
  end
  object qryServers: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 25
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM [ThemeEposDevice]'
      'WHERE IsServer = 1'
      'AND SiteCode = :siteCode'
      'ORDER BY Name')
    Left = 224
    Top = 330
    object qryServersSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qryServersEPoSDeviceID: TSmallintField
      FieldName = 'EPoSDeviceID'
    end
    object qryServersPOSCode: TIntegerField
      FieldName = 'POSCode'
    end
    object qryServersName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qryServersIPAddress: TStringField
      FieldName = 'IPAddress'
      Size = 50
    end
    object qryServersCustomerDisplayType: TIntegerField
      FieldName = 'CustomerDisplayType'
    end
    object qryServersScrollingMessage: TStringField
      FieldName = 'ScrollingMessage'
      Size = 255
    end
    object qryServersConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object qryServersIsServer: TBooleanField
      FieldName = 'IsServer'
    end
    object qryServersServerID: TSmallintField
      FieldName = 'ServerID'
    end
    object qryServersHardwareType: TIntegerField
      FieldName = 'HardwareType'
    end
  end
  object qryServerTerminals: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'serverID'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 25
      end>
    SQL.Strings = (
      'DECLARE @ServerID int, @SiteCode int'
      ''
      'SET @ServerID = :serverID'
      'SET @SiteCode = :siteCode'
      ''
      
        'SELECT a.[SiteCode], a.[EPoSDeviceID], a.[POSCode], c.[Name], a.' +
        '[IPAddress], a.[SubnetMask],'
      
        '      a.[GatewayIP], a.[HardwareType], a.[CustomerDisplayType], ' +
        'a.[ScrollingMessageOverrideId],'
      
        '      a.[ScrollingMessage], a.[ConfigSetID], a.[IsServer], a.[Se' +
        'rverID], a.[ResetAccountNumber],'
      '      a.[ScreenInterfaceID], a.[Kiosk_SEC], a.[PoundCode]'
      'FROM [ThemeEposDevice] a'
      'INNER JOIN'
      ' (SELECT EposDeviceID, Name'
      '  FROM ThemeEposDevice'
      '  WHERE IsServer = 0'
      '  AND ServerID = @ServerID'
      '  AND SiteCode = @SiteCode'
      '  AND HardwareType <> 10 --NOT IN (10, 14)'
      '  UNION'
      '  SELECT MIN(e.EposDeviceID), '#39'MOA - '#39' + s.Name'
      '  FROM ThemeEposDevice e'
      '    JOIN ac_Pos p on p.Id = e.POSCode'
      '    JOIN ac_SalesArea s on s.Id = p.SalesAreaId'
      '  WHERE e.IsServer = 0'
      '  AND e.ServerID = @ServerID'
      '  AND e.SiteCode = @SiteCode'
      '  AND e.HardwareType = 10'
      
        '  GROUP BY p.SalesAreaId, s.Name) c ON c.EPoSDeviceID = a.EPoSDe' +
        'viceID '
      'ORDER BY c.Name'
      '')
    Left = 216
    Top = 306
    object qryServerTerminalsSiteCode: TIntegerField
      FieldName = 'SiteCode'
    end
    object qryServerTerminalsEPoSDeviceID: TSmallintField
      FieldName = 'EPoSDeviceID'
    end
    object qryServerTerminalsPOSCode: TIntegerField
      FieldName = 'POSCode'
    end
    object qryServerTerminalsName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qryServerTerminalsIPAddress: TStringField
      FieldName = 'IPAddress'
      Size = 50
    end
    object qryServerTerminalsCustomerDisplayType: TIntegerField
      FieldName = 'CustomerDisplayType'
    end
    object qryServerTerminalsScrollingMessage: TStringField
      FieldName = 'ScrollingMessage'
      Size = 255
    end
    object qryServerTerminalsConfigSetID: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object qryServerTerminalsIsServer: TBooleanField
      FieldName = 'IsServer'
    end
    object qryServerTerminalsServerID: TSmallintField
      FieldName = 'ServerID'
    end
    object qryServerTerminalsHardwareType: TIntegerField
      FieldName = 'HardwareType'
    end
  end
  object qryServerPrinters: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'serverID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM [ThemeEposPrinter]'
      'WHERE [EposDeviceID] = :serverID'
      'AND SiteCode = :siteCode'
      'ORDER BY Name')
    Left = 320
    Top = 330
  end
  object qryTerminalDeviceList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'siteCode1'
        DataType = ftString
        Size = 16
        Value = '25'
      end
      item
        Name = 'terminalID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 2
      end
      item
        Name = 'siteCode2'
        DataType = ftString
        Size = 16
        Value = '25'
      end>
    SQL.Strings = (
      
        'SELECT a.PrinterID as DeviceID, a.Name, c.PrinterTypeName, a.Por' +
        'tNumber,'
      
        '     a.IPAddress, a.IPPort, a.EposName1, a.EposName2, a.EposName' +
        '3,'
      
        '     a.IsSlipPrinter, b.Name as RedirectionPrinter, a.SlipStartL' +
        'inePosition, '
      
        '     a.SlipEndLinePosition, a.SlipBaudRate, a.ChangePaperTimeout' +
        ', '#39'TerminalPrinter'#39' as TypeOfDevice, a.PrinterType,'
      '     a.HasCashDrawer'
      'FROM [ThemeEposPrinter] a left outer join'
      '  (SELECT * '
      '   FROM ThemeEposPrinter'
      '   WHERE SiteCode = :siteCode1) b'
      '  ON a.RedirectionPrinterID = b.PrinterID, [ThemePrinterType] c'
      'WHERE a.[EposDeviceID] = :terminalID'
      'AND a.SiteCode = :siteCode2'
      'AND a.PrinterType = c.PrinterTypeID'
      'ORDER BY a.Name')
    Left = 288
    Top = 330
    object qryTerminalDeviceListName: TStringField
      DisplayWidth = 12
      FieldName = 'Name'
      Size = 50
    end
    object qryTerminalDeviceListPrinterTypeName: TStringField
      DisplayLabel = 'Peripheral Type'
      FieldName = 'PrinterTypeName'
      Size = 50
    end
    object qryTerminalDeviceListPortNumber: TWordField
      Alignment = taCenter
      DisplayLabel = 'Port~No.'
      DisplayWidth = 5
      FieldName = 'PortNumber'
    end
    object qryTerminalDeviceListIPAddress: TStringField
      DisplayLabel = 'IP Address'
      DisplayWidth = 14
      FieldName = 'IPAddress'
      Size = 50
    end
    object qryTerminalDeviceListIPPort: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'IP~Port~No.'
      DisplayWidth = 5
      FieldName = 'IPPort'
      ReadOnly = True
    end
    object qryTerminalDeviceListDeviceID: TLargeintField
      FieldName = 'DeviceID'
    end
    object qryTerminalDeviceListTypeOfDevice: TStringField
      FieldName = 'TypeOfDevice'
      ReadOnly = True
      Size = 15
    end
    object qryTerminalDeviceListPrinterType: TIntegerField
      FieldName = 'PrinterType'
    end
    object qryTerminalDeviceListHasCashDrawer: TBooleanField
      FieldName = 'HasCashDrawer'
    end
  end
  object dsDeviceList: TDataSource
    Left = 400
    Top = 362
  end
  object qryServerDeviceList: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'serverID'
        Attributes = [paSigned, paNullable]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 3
      end
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'eposDeviceID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = 2
      end>
    SQL.Strings = (
      ''
      'DECLARE @ServerID int, @SiteCode int'
      ''
      'SET @ServerID = :serverID'
      'SET @SiteCode = :siteCode'
      ''
      
        'SELECT EPosDeviceID AS DeviceID,Name, '#39'Terminal'#39' AS DeviceType, ' +
        'null AS PortNumber, IPAddress, null AS IPPort,'#39#39' AS EposName1, '#39 +
        #39' AS EposName2,'
      '  '#39#39' AS EposName3, TypeOfDevice = Case HardwareType'
      #9#9'WHEN 5 THEN '#39'Conqueror'#39
      '    WHEN 12 THEN '#39'MOAOrderPad'#39
      '    WHEN 14 THEN '#39'iZoneTables'#39
      #9#9'ELSE '#39'ServerTerminal'#39
      'END'
      'FROM [ThemeEposDevice]'
      'WHERE IsServer = 0'
      'AND ServerID = @ServerID'
      'AND SiteCode = @SiteCode'
      'AND HardwareType <> 10 --NOT IN (10, 14)'
      'UNION'
      
        'SELECT a.EPosDeviceID AS DeviceID, c.Name, '#39'Terminal'#39' AS DeviceT' +
        'ype, null AS PortNumber, null AS IPAddress, null AS IPPort,'#39#39' AS' +
        ' EposName1, '#39#39' AS EposName2,'
      '  '#39#39' AS EposName3, '#39'MobileOrdering'#39' AS TypeOfDevice'
      'FROM ThemeEposDevice a'
      'INNER JOIN'
      
        ' (SELECT MIN(e.EposDeviceID) AS EposDeviceID, '#39'MOA - '#39' + s.Name ' +
        'AS Name'
      '  FROM ThemeEposDevice e'
      '    JOIN ac_Pos p ON p.Id = e.POSCode'
      '    JOIN ac_SalesArea s ON s.Id = p.SalesAreaId'
      '  WHERE e.IsServer = 0'
      '  AND e.ServerID = @ServerID'
      '  AND e.SiteCode = @SiteCode'
      '  AND e.HardwareType = 10'
      
        '  GROUP BY p.SalesAreaId, s.Name) c ON c.EPoSDeviceID = a.EPoSDe' +
        'viceID '
      'UNION'
      
        'SELECT a.PrinterID, a.Name, b.PrinterTypeName, a.PortNumber, a.I' +
        'PAddress, a.IPPort, a.EposName1, a.EposName2, a.EposName3,'
      '  '#39'ServerPrinter'#39' AS TypeOfDevice'
      'FROM [ThemeEposPrinter] a, [ThemePrinterType] b'
      'WHERE a.[EposDeviceID] = :eposDeviceID'
      'AND a.PrinterType = b.PrinterTypeID'
      'AND a.SiteCode = @SiteCode'
      'ORDER BY TypeOfDevice DESC, Name ASC'
      '')
    Left = 256
    Top = 330
    object qryServerDeviceListName: TStringField
      DisplayWidth = 50
      FieldName = 'Name'
      Size = 50
    end
    object qryServerDeviceListDeviceType: TStringField
      DisplayLabel = 'Device Type'
      DisplayWidth = 14
      FieldName = 'DeviceType'
      ReadOnly = True
      Size = 50
    end
    object qryServerDeviceListPortNumber: TWordField
      Alignment = taCenter
      DisplayLabel = 'Serial~Port~No.'
      DisplayWidth = 5
      FieldName = 'PortNumber'
      ReadOnly = True
    end
    object qryServerDeviceListIPAddress: TStringField
      DisplayLabel = 'IP Address'
      DisplayWidth = 14
      FieldName = 'IPAddress'
      Size = 50
    end
    object qryServerDeviceListIPPort: TWordField
      Alignment = taCenter
      DisplayLabel = 'IP~Port~No.'
      DisplayWidth = 5
      FieldName = 'IPPort'
      ReadOnly = True
    end
    object qryServerDeviceListEposName1: TStringField
      DisplayLabel = 'Epos~Name 1'
      DisplayWidth = 9
      FieldName = 'EposName1'
      ReadOnly = True
    end
    object qryServerDeviceListEposName2: TStringField
      DisplayLabel = 'Epos~Name 2'
      DisplayWidth = 9
      FieldName = 'EposName2'
      ReadOnly = True
    end
    object qryServerDeviceListEposName3: TStringField
      DisplayLabel = 'Epos~Name 3'
      DisplayWidth = 9
      FieldName = 'EposName3'
      ReadOnly = True
    end
    object qryServerDeviceListDeviceID: TLargeintField
      FieldName = 'DeviceID'
      ReadOnly = True
    end
    object qryServerDeviceListTypeOfDevice: TStringField
      FieldName = 'TypeOfDevice'
      ReadOnly = True
      Size = 14
    end
  end
  object pmServer: TPopupMenu
    Left = 128
    Top = 515
    object AddTerminal: TMenuItem
      Caption = 'Add Terminal'
      OnClick = AddTerminalClick
    end
    object AddPrinter: TMenuItem
      Action = actAddNodeServerPrinter
      Caption = 'Add Peripheral'
    end
    object EditServer: TMenuItem
      Caption = 'Edit Server'
      OnClick = EditServerClick
    end
    object DeleteServer: TMenuItem
      Caption = 'Delete Server'
      OnClick = DeleteServerClick
    end
  end
  object pmNodeServerTerminal: TPopupMenu
    Left = 32
    Top = 515
    object AddPeripheral: TMenuItem
      Action = actAddNodeServerPrinter
      Caption = 'Add Peripheral'
    end
    object MoveTerminal: TMenuItem
      Caption = 'Move Terminal'
    end
    object EditTerminal: TMenuItem
      Caption = 'Edit Terminal'
      OnClick = EditTerminalClick
    end
    object DeleteTerminal: TMenuItem
      Action = actDeleteNodeTerminal
    end
  end
  object pmNodeServerPrinter: TPopupMenu
    Left = 152
    Top = 515
    object MoveNodeServerPrinter: TMenuItem
      Caption = 'Move Peripheral'
    end
    object EditServerPrinter: TMenuItem
      Caption = 'Edit Peripheral'
      OnClick = EditTerminalPrinter1Click
    end
    object DeleteServerPrinter: TMenuItem
      Action = actDeleteNodeServerPrinter
      Caption = 'Delete Peripheral'
    end
  end
  object pmRecordTerminalPrinter: TPopupMenu
    Top = 515
    object MoveRecordTerminalPrinter: TMenuItem
      Caption = 'Move Peripheral'
    end
    object DeleteRecordTerminalPrinter: TMenuItem
      Action = actDeleteRecordTerminalPrinter
    end
  end
  object ActionList1: TActionList
    Left = 320
    Top = 515
    object actMoveTerminal: TAction
      Caption = 'Move Terminal'
      OnExecute = actMoveTerminalExecute
    end
    object actDeleteNodeTerminal: TAction
      Caption = 'Delete Terminal'
      OnExecute = actDeleteNodeTerminalExecute
    end
    object actEditNodeTerminal: TAction
      Caption = 'Edit Terminal'
      OnExecute = actEditNodeTerminalExecute
    end
    object actDeleteRecordTerminal: TAction
      Caption = 'Delete Terminal'
      OnExecute = actDeleteRecordTerminalExecute
    end
    object actAddNodeServerPrinter: TAction
      Caption = 'Add Printer'
      OnExecute = actAddNodeServerPrinterExecute
    end
    object actDeleteNodeServerPrinter: TAction
      Caption = 'Delete Printer'
      OnExecute = actDeleteNodeServerPrinterExecute
    end
    object actEditNodeServerPrinter: TAction
      Caption = 'Edit Printer'
      OnExecute = actEditNodeServerPrinterExecute
    end
    object actMovePrinter: TAction
      Caption = 'Move Printer'
      OnExecute = actMovePrinterExecute
    end
    object actDeleteRecordServerPrinter: TAction
      Caption = 'Delete Printer'
      OnExecute = actDeleteRecordServerPrinterExecute
    end
    object actDeleteRecordTerminalPrinter: TAction
      Caption = 'Delete Peripheral'
      OnExecute = actDeleteRecordTerminalPrinterExecute
    end
    object actAddRecordTerminalPrinter: TAction
      Caption = 'Add Peripheral'
      OnExecute = actAddRecordTerminalPrinterExecute
    end
  end
  object pmRecordServerPrinter: TPopupMenu
    Left = 64
    Top = 515
    object MoveRecordServerPrinter: TMenuItem
      Caption = 'Move Printer'
    end
    object DeleteRecordServerPrinter: TMenuItem
      Action = actDeleteRecordServerPrinter
    end
  end
  object pmRecordTerminal: TPopupMenu
    Left = 96
    Top = 515
    object AddPeripheralFromGrid: TMenuItem
      Action = actAddRecordTerminalPrinter
    end
    object MoveRecordServerTerminal: TMenuItem
      Caption = 'Move Terminal'
    end
    object DeleteRecordServerTerminal: TMenuItem
      Action = actDeleteRecordTerminal
    end
  end
  object qryServersForCbx: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 25
      end>
    SQL.Strings = (
      'SELECT DISTINCT a.*, b.*'
      'FROM [ThemeEposDevice] a'
      'JOIN TerminalHardware b on a.HardwareType = b.HardwareType'
      
        'JOIN ThemeEposDevice a2 on a2.ServerID = a.EPoSDeviceID and a2.H' +
        'ardwareType <> 10'
      'WHERE a.IsServer = 1'
      'AND a.SiteCode = :siteCode'
      'AND ClassName like '#39'%.AztecEPoSDevice'#39
      'ORDER BY a.Name'
      '')
    Left = 192
    Top = 330
    object IntegerField1: TIntegerField
      FieldName = 'SiteCode'
    end
    object SmallintField1: TSmallintField
      FieldName = 'EPoSDeviceID'
    end
    object IntegerField2: TIntegerField
      FieldName = 'POSCode'
    end
    object StringField1: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'IPAddress'
      Size = 50
    end
    object IntegerField3: TIntegerField
      FieldName = 'CustomerDisplayType'
    end
    object StringField3: TStringField
      FieldName = 'ScrollingMessage'
      Size = 255
    end
    object IntegerField4: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object BooleanField1: TBooleanField
      FieldName = 'IsServer'
    end
    object SmallintField2: TSmallintField
      FieldName = 'ServerID'
    end
  end
  object ilGridIcons: TImageList
    Left = 288
    Top = 515
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A4A4A004A4AFF004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A4A4A004A4AFF004A4AA5004A4A4A004A4A4A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A004A4AFF004A4AA5004A4AA5004A4AFF004A4AA5004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A004A4AFF004A4AA5004A4AFF004A4AA5004A4AA5004A4AA5004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A004A4AFF004A4A4A004A4A4A004A4AFF004A4AA5004A4A4A004A4A4A004A4A
      4A004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A004A4A4A0000000000000000004A4A4A004A4A4A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FEFF000000000000FEFF000000000000
      FDFF000000000000FDFF000000000000F8FF000000000000F83F000000000000
      F01F000000000000F00F000000000000E007000000000000E67F000000000000
      FFFF000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object qrySiteServers: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT EPosDeviceID as DeviceID, Name, '#39'Server'#39' as DeviceType, n' +
        'ull as PortNumber, IPAddress,'#39#39' as EposName1, '#39#39' as EposName2,'
      '  '#39#39' as EposName3, '
      'TypeOfDevice = Case HardwareType'
      #9#9'When 5 Then '#39'ConquerorServ'#39
      #9#9'Else '#39'Server'#39
      'end'
      'FROM [ThemeEposDevice]'
      'WHERE IsServer = 1'
      'AND SiteCode = :siteCode'
      '')
    Left = 248
    Top = 306
  end
  object qrySelectedServerDetails: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'TerminalID'
        Size = -1
        Value = Null
      end
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT t.EPosDeviceID as DeviceID, t.Name, h.HardwareName, null ' +
        'as PortNumber, t.IPAddress,'#39#39' as EposName1, '#39#39' as EposName2,'
      '  '#39#39' as EposName3, '#39'Server'#39' as TypeOfDevice'
      
        'FROM [ThemeEposDevice] t join TerminalHardware h on t.HardwareTy' +
        'pe = h.HardwareType'
      'WHERE IsServer = 1'
      'and EPosDeviceID = :TerminalID'
      'and SiteCode = :SiteCode')
    Left = 184
    Top = 306
  end
  object qrySelectTerminal: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DeviceID'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end>
    SQL.Strings = (
      
        'select t.EposDeviceID, t.IPAddress, h.hardwareName, t.[Name], t.' +
        'ScreenInterfaceID, t.MultiDrawerMode from ThemeEposDevice t'
      'join TerminalHardware h on t.HardwareType = h.HardwareType'
      'where t.IsServer = 0 '
      'and t.SiteCode= :SiteCode'
      'and t.EposDeviceID = :DeviceID')
    Left = 312
    Top = 306
  end
  object qrySelectPeripheralDevice: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end
      item
        Name = 'DeviceID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select tp.[name], tp.PortNumber, '
      ''
      'case p.IPComms when 1 then '#39'IP '#39' else '#39#39' end +'
      'case p.IsPinPad when 1 then '#39'Pin pad '#39' else '#39#39' end +'
      'case p.IsPrinter when 1 then '#39'Printer'#39' else '#39#39' end +'
      
        'case p.IsBarCodeReader when 1 then '#39'Bar Code Reader'#39' else '#39#39' end' +
        ' +'
      'case p.IsTextInserter when 1 then '#39'Text Inserter'#39' else '#39#39' end +'
      'case p.IsePurse when 1 then '#39'ePurse'#39' else '#39#39' end +'
      
        'case tp.HasCashDrawer when 1 then '#39' (has cash drawer)'#39' else '#39#39' e' +
        'nd'
      ' '
      'as PeripheralDevice,'
      'tp.IPaddress, tp.IPPort, p.PrinterTypeName  '
      'from themeEposPrinter tp'
      'join themePrinterType p on tp.PrinterType = p.PrinterTypeID'
      'where tp.Sitecode = :SiteCode'
      'and tp.PrinterID = :DeviceID')
    Left = 120
    Top = 306
  end
  object qrySelectRoot: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'select ac_Company.Name as "Company Name", ac_Site.Name as "Site ' +
        'Name", ac_Site.Manager as "Site Manager", ac_Site.TelephoneNumbe' +
        'r as "Phone" '
      'from ac_Site'
      'join ac_Area on AreaId = ac_Area.Id'
      'join ac_Company on CompanyId = ac_Company.Id'
      'where ac_Site.Id = :SiteCode')
    Left = 344
    Top = 306
  end
  object pmRecordServer: TPopupMenu
    Left = 192
    Top = 515
    object miAddTerminal: TMenuItem
      Caption = 'Add Terminal'
      OnClick = miAddTerminalClick
    end
    object miAddPrinter: TMenuItem
      Caption = 'Add Peripheral'
      OnClick = miAddPrinterClick
    end
    object miEditServer: TMenuItem
      Caption = 'Edit Server'
      OnClick = miEditServerClick
    end
    object miDeleteServer: TMenuItem
      Caption = 'Delete Server'
      OnClick = miDeleteServerClick
    end
  end
  object qryPinPadGrid: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from dbo.#EditPinPadGrid order by DeviceName')
    Left = 336
    Top = 362
  end
  object dsPinPadGrid: TDataSource
    DataSet = qryPinPadGrid
    Left = 368
    Top = 362
  end
  object qryServersForCbx2: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsOutlets
    Parameters = <
      item
        Name = 'siteCode'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 25
      end>
    SQL.Strings = (
      'SELECT DISTINCT a.*, b.*'
      'FROM [ThemeEposDevice] a'
      'JOIN TerminalHardware b on a.HardwareType = b.HardwareType'
      
        'JOIN ThemeEposDevice a2 on a2.ServerID = a.EPoSDeviceID and a2.H' +
        'ardwareType <> 10'
      'WHERE a.IsServer = 1'
      'AND a.SiteCode = :siteCode'
      'AND ClassName like '#39'%.AztecEPoSDevice'#39
      'ORDER BY a.Name'
      '')
    Left = 280
    Top = 306
    object IntegerField5: TIntegerField
      FieldName = 'SiteCode'
    end
    object SmallintField3: TSmallintField
      FieldName = 'EPoSDeviceID'
    end
    object IntegerField6: TIntegerField
      FieldName = 'POSCode'
    end
    object StringField4: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object StringField5: TStringField
      FieldName = 'IPAddress'
      Size = 50
    end
    object IntegerField7: TIntegerField
      FieldName = 'CustomerDisplayType'
    end
    object StringField6: TStringField
      FieldName = 'ScrollingMessage'
      Size = 255
    end
    object IntegerField8: TIntegerField
      FieldName = 'ConfigSetID'
    end
    object BooleanField2: TBooleanField
      FieldName = 'IsServer'
    end
    object SmallintField4: TSmallintField
      FieldName = 'ServerID'
    end
  end
  object qIPAddresses: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT SiteCode, EFTAddress, GiftAddress FROM ThemeOutletIPAddre' +
        'ss'
      'WHERE SiteCode = :SiteCode')
    Left = 152
    Top = 306
  end
  object qServiceSettings: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteCode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @SiteCode int'
      'set @SiteCode = :SiteCode'
      ''
      'declare @localIP varchar(15)'
      
        'select @localIP = IPAddress from ThemeOutletConfigs where SiteCo' +
        'de = @SiteCode'
      ''
      'select'
      '  tss.Id as SoapServerID,'
      '  IsNull(tssco.IPAddress, @localIP) as IPAddress,'
      '  IsNull(tssco.IPPortNumber, tss.IPPortNumber) as IPPortNumber,'
      '  IsNull(tss.IPAddress, @localIP) as IPAddressDefault,'
      '  IsNull(tss.IPPortNumber,50000) as IPPortNumberDefault'
      'from SiteServiceSettings tss'
      'left join SiteServiceSettingsOverrides tssco'
      'on tssco.ServiceId = tss.Id and tssco.SiteCode = @SiteCode'
      'where tss.Id in (6,7) -- (Ledgers,Bookings)'
      '')
    Left = 352
    Top = 330
  end
  object pmNodeMobileOrdering: TPopupMenu
    Left = 223
    Top = 514
    object ViewMobileOrderingTerminal: TMenuItem
      Caption = 'View'
      OnClick = ViewMobileOrderingTerminalClick
    end
  end
  object PeripheralWarningsTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = PeripheralWarningsTimerTimer
    Left = 352
    Top = 514
  end
  object FakeContextMenu: TPopupMenu
    OnPopup = FakeContextMenuPopup
    Left = 216
    Top = 80
  end
  object dsPStreams2: TDataSource
    DataSet = qEditPrintStreamsAggregate
    Left = 320
    Top = 482
  end
  object qEditPrintStreamsAggregate: TADOQuery
    Connection = dmADO.AztecConn
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'select * from #tmpstreamsaggregate order by PrintStreamName')
    Left = 288
    Top = 482
  end
  object qSavePrintStreamsAggregate: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'FilterID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @FilterID int;'
      'SET @FilterID = :FilterID'
      ''
      
        'DECLARE @SetStatement varchar(MAX) = '#39#39', @UpdateQuery varchar(ma' +
        'x) = '#39#39', @WhereClause varchar(max) = '#39#39
      ''
      
        'SELECT @SetStatement = @SetStatement + '#39', tps.['#39' + Name + '#39']=COA' +
        'LESCE(tpsa.['#39' + Name + '#39'], tps.['#39' + Name + '#39'])'#39' FROM #tmpprinter' +
        'columns ORDER BY Name ASC'
      
        'SELECT @WhereClause = @WhereClause + '#39' OR tpsa.['#39' + Name + '#39'] IS' +
        ' NOT NULL'#39' FROM #tmpprintercolumns ORDER BY Name ASC'
      'SELECT @WhereClause = @WhereClause + '#39') AND tps.READONLY = 0'#39
      ''
      
        'SET @UpdateQuery = '#39'UPDATE tps SET tps.[Optional]=COALESCE(tpsa.' +
        '[Optional], tps.[Optional])'#39' + @SetStatement + '#39' FROM #tmpstream' +
        's tps'
      
        'JOIN #tmpstreamsaggregate tpsa ON tps.printstreamid = tpsa.print' +
        'streamid'
      'JOIN ThemeEPoSDevice ted on ted.EPoSDeviceID = tps.EPoSDeviceID'
      'JOIN TerminalHardware th on th.HardwareType = ted.HardwareType'
      'WHERE (tpsa.[Optional] IS NOT NULL'#39' + @WhereClause + '#39
      
        'AND (th.ThemeTerminalFilterTypeID = '#39' + cast(@FilterID as varcha' +
        'r(10)) + '#39' or '#39' + cast(@FilterID as varchar(10)) + '#39' = -1)'#39
      ''
      'EXEC(@UpdateQuery)')
    Left = 352
    Top = 482
  end
  object qLoadprintStreamsAggregate: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'FilterID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @FilterID int;'
      'set @FilterID = :FilterID'
      ''
      'truncate table #tmpstreamsaggregate;'
      ''
      'declare @DeviceCount int;'
      'select @DeviceCount = COUNT(distinct ps.eposdeviceid)'
      'from #tmpstreams ps'
      'join themeeposdevice ted on ted.eposdeviceid = ps.eposdeviceid'
      'join TerminalHardware th on th.HardwareType = ted.HardwareType'
      'where ted.hardwaretype >=0'
      
        'and (th.ThemeTerminalFilterTypeID = @FilterID or @FilterID = -1)' +
        ';'
      ''
      
        'declare @AggregateStatement varchar(MAX) = '#39#39', @CaseStatement va' +
        'rchar(MAX) = '#39#39', @AggQuery varchar(max) = '#39#39', @ColumnList varcha' +
        'r(max) = '#39#39';'
      ''
      
        'set @ColumnList = '#39'(PrintStreamID, PrintStreamName, Optional, Re' +
        'adOnly'#39';'
      
        'select @ColumnList = @ColumnList + '#39',['#39' + Name + '#39']'#39' from #tmppr' +
        'intercolumns order by name asc;'
      'Set @ColumnList = @ColumnList + '#39')'#39';'
      
        'set @AggregateStatement = '#39'SUM(CAST([Optional] as tinyint)) as [' +
        'Optional], SUM(CAST([ReadOnly] as tinyint)) as [ReadOnly]'#39';'
      
        'select @AggregateStatement = @AggregateStatement + '#39', SUM(CAST([' +
        #39' +Name + '#39'] as tinyint)) as ['#39' + Name + '#39']'#39' from #tmpprintercol' +
        'umns order by name asc;'
      ''
      
        'set @CaseStatement = '#39'case [Optional] when '#39' + CAST(@DeviceCount' +
        ' as varchar(10)) + '#39' then 1 when 0 then 0 else null end as [Opti' +
        'onal]'#39';'
      
        'set @CaseStatement = @CaseStatement + '#39', case [ReadOnly] when '#39' ' +
        '+ CAST(@DeviceCount as varchar(10)) + '#39' then 1 when 0 then 0 els' +
        'e null end as [ReadOnly]'#39';'
      
        'select @CaseStatement = @CaseStatement + '#39', case ['#39' + Name + '#39'] ' +
        'when '#39' + CAST(@DeviceCount as varchar(10)) + '#39' then 1 when 0 the' +
        'n 0 else null end as ['#39' + Name + '#39']'#39' from #tmpprintercolumns ord' +
        'er by name asc;'
      ''
      'set @AggQuery = '#39'insert #tmpstreamsaggregate '#39' + @ColumnList + '#39
      'select PrintStreamID, ps.Name, '#39' + @CaseStatement + '#39' from ('
      
        'select PrintStreamID, '#39' + @AggregateStatement + '#39' from #tmpstrea' +
        'ms ts'
      'join ThemeEpoSDevice ted on ts.EpoSDeviceID = ted.EposDeviceID'
      'join TerminalHardware th on th.HardwareType = ted.HardwareType'
      'where ted.hardwaretype >=0'
      
        'and (th.ThemeTerminalFilterTypeID = '#39' + cast(@FilterID as varcha' +
        'r(10)) + '#39' or '#39' + cast(@FilterID as varchar(10)) + '#39' = -1)'
      'group by PrintStreamID) sub'
      'join ac_printstream ps on sub.PrintStreamID = ps.ID'#39';'
      ''
      'exec(@AggQuery);')
    Left = 384
    Top = 482
  end
  object adoqThemeTerminalFilterTypeLookup: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'select -1 as Id, '#39'All'#39' as Value, '#39'All terminal types'#39' as Descrip' +
        'tion'
      'union'
      'select Id, Value, Description'
      'from ThemeTerminalFilterTypeLookup'
      'order by [Value] asc')
    Left = 416
    Top = 482
  end
  object qValidateMultiDrawerMode: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteId'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = 'EposDeviceId'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from ac_SiteFinanceSettingsAtHo a'
      'join ThemeEposDevice b ON a.SiteId = b.SiteCode'
      'join ac_PosFinanceSettingsAtHO c ON c.PosId = b.POSCode'
      'where a.SiteId = :SiteId'
      '  and b.EPoSDeviceID = :EposDeviceId'
      '  and a.TrackCashDrawerInserts = 1'
      
        '  and (c.TrackCashDrawerInsert = 1 and c.PaymentsAllowed in (1,3' +
        '))'
      '  and not exists(select *'
      '                 from ThemeEposPrinter'
      '                 where EposDeviceID = b.EPoSDeviceID'
      '                 and HasCashDrawer = 1)')
    Left = 384
    Top = 328
  end
end
