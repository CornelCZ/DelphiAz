object ConfigureFooterQRCode: TConfigureFooterQRCode
  Left = 605
  Top = 284
  BorderStyle = bsDialog
  Caption = 'Configure QR Code for Bills and Receipts'
  ClientHeight = 226
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    501
    226)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 501
    Height = 189
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 0
    object pnlQRCodeUrl: TPanel
      Left = 2
      Top = 2
      Width = 497
      Height = 151
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object grpBoxQRCodeUrl: TGroupBox
        Tag = 1
        Left = 0
        Top = 72
        Width = 497
        Height = 79
        Align = alBottom
        Caption = 'QR Code URL'
        TabOrder = 2
        TabStop = True
        object lblUrl: TLabel
          Left = 12
          Top = 20
          Width = 22
          Height = 13
          Caption = 'URL'
        end
        object lblDynamicFields: TLabel
          Left = 301
          Top = 20
          Width = 71
          Height = 13
          Caption = 'Dynamic Fields'
        end
        object DBEditQRCodeUrlForReceiprFooter: TDBEdit
          Left = 12
          Top = 36
          Width = 282
          Height = 21
          DataField = 'QrCodeUrlForReceipt'
          DataSource = dmADO.dsOutletPrintConfigs
          TabOrder = 0
          OnChange = DBEditQRCodeUrlForReceiprFooterChange
        end
        object btnInsert: TButton
          Left = 435
          Top = 34
          Width = 48
          Height = 25
          Hint = 
            'Inserts the selected Dynamic Field into the URL at the current c' +
            'ursor position.'
          Caption = 'Insert'
          TabOrder = 1
          OnClick = btnInsertClick
        end
        object cbDynamicFields: TComboBox
          Left = 302
          Top = 36
          Width = 126
          Height = 21
          Hint = 
            'To insert Dynamic Fields:'#13#10'Position the cursor in '#39'URL'#39' field wh' +
            'ere you want to insert a Dynamic Field.'#13#10'Select the desired Dyna' +
            'mic Field from the drop down list.'#13#10'Click '#39'Insert'#39'.'
          Style = csOwnerDrawFixed
          Ctl3D = True
          ItemHeight = 15
          ParentCtl3D = False
          TabOrder = 2
          OnChange = cbDynamicFieldsChange
        end
      end
      object grpBocPrintQRCode: TGroupBox
        Left = 0
        Top = 0
        Width = 123
        Height = 72
        Align = alLeft
        Caption = 'Print QR Code On:'
        TabOrder = 0
        TabStop = True
        object dbChkBoxBillFooter: TDBCheckBox
          Left = 12
          Top = 20
          Width = 97
          Height = 17
          Caption = 'Bill footer'
          DataField = 'PrintQrCodeOnBills'
          DataSource = dmADO.dsOutletPrintConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbCheckBoxReceiptFooter: TDBCheckBox
          Left = 12
          Top = 42
          Width = 97
          Height = 16
          Caption = 'Receipt footer'
          DataField = 'PrintQrCodeOnReceipt'
          DataSource = dmADO.dsOutletPrintConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object grpSizeQR: TGroupBox
        Left = 123
        Top = 0
        Width = 168
        Height = 72
        Align = alCustom
        Caption = 'QR Code Size'
        TabOrder = 1
        object cmboxQRCodeSize: TwwDBComboBox
          Left = 8
          Top = 16
          Width = 153
          Height = 21
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          DataField = 'PrintQrCodeSize'
          DataSource = dmADO.dsOutletPrintConfigs
          DropDownCount = 8
          ItemHeight = 13
          Items.Strings = (
            'Small'#9'0'
            'Medium'#9'1'
            'Large'#9'2')
          ItemIndex = 0
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
      end
      object grpQRRefund: TGroupBox
        Left = 291
        Top = 0
        Width = 206
        Height = 72
        Caption = 'QR Code Return / Refund'
        TabOrder = 3
        object dbCheckBoxAppendRefundData: TDBCheckBox
          Left = 12
          Top = 20
          Width = 181
          Height = 17
          Caption = 'Append data for Refund function'
          DataField = 'AppendRefundData'
          DataSource = dmADO.dsOutletPrintConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
    end
    object btnEditQRCodeFooterText: TButton
      Left = 12
      Top = 156
      Width = 209
      Height = 25
      Hint = 'Add/Edit the text that will be printed below the QR Code'
      Caption = 'Edit QR Code footer text'
      TabOrder = 1
      OnClick = btnEditQRCodeFooterTextClick
    end
  end
  object btnClose: TButton
    Left = 422
    Top = 196
    Width = 74
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 1
  end
end
