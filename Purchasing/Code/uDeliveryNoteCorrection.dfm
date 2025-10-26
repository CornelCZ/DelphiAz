object frmDeliveryNoteCorrection: TfrmDeliveryNoteCorrection
  Left = 708
  Top = 278
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Handheld Import Corrections'
  ClientHeight = 273
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSupplierName: TLabel
    Left = 16
    Top = 11
    Width = 38
    Height = 13
    Caption = 'Supplier'
  end
  object lblStockOrder: TLabel
    Left = 16
    Top = 56
    Width = 57
    Height = 13
    Caption = 'Stock Order'
  end
  object lblDeliveryNoteNo: TLabel
    Left = 16
    Top = 115
    Width = 104
    Height = 13
    Caption = 'Delivery Note Number'
  end
  object lblDateReceived: TLabel
    Left = 16
    Top = 175
    Width = 72
    Height = 13
    Caption = 'Date Received'
  end
  object lblSupplier: TLabel
    Left = 16
    Top = 28
    Width = 60
    Height = 13
    Caption = 'lblSupplier'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmbStockOrders: TComboBox
    Left = 16
    Top = 72
    Width = 217
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'No Stock Order'
    Items.Strings = (
      'No Stock Order')
  end
  object dtpFinalised: TDateTimePicker
    Left = 16
    Top = 192
    Width = 97
    Height = 21
    CalAlignment = dtaLeft
    Date = 39049
    Time = 39049
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object edbxDeliveryNoteNumber: TMaskEdit
    Left = 15
    Top = 132
    Width = 217
    Height = 21
    MaxLength = 15
    TabOrder = 1
  end
  object btnOK: TBitBtn
    Left = 51
    Top = 232
    Width = 91
    Height = 29
    Caption = 'OK'
    TabOrder = 3
    OnClick = OKBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
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
  object btnClose: TBitBtn
    Left = 150
    Top = 232
    Width = 91
    Height = 29
    TabOrder = 4
    OnClick = btnCloseClick
    Kind = bkCancel
  end
end
