object frmSuppliers: TfrmSuppliers
  Left = 287
  Top = 171
  BorderStyle = bsDialog
  Caption = 'Choices Dialog'
  ClientHeight = 255
  ClientWidth = 345
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SrcLabel: TLabel
    Left = 8
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = 'Available Suppliers:'
  end
  object DstLabel: TLabel
    Left = 192
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = 'Selected Suppliers'
  end
  object IncludeBtn: TSpeedButton
    Left = 160
    Top = 32
    Width = 24
    Height = 24
    Caption = '>'
    OnClick = IncludeBtnClick
  end
  object IncAllBtn: TSpeedButton
    Left = 160
    Top = 64
    Width = 24
    Height = 24
    Caption = '>>'
    OnClick = IncAllBtnClick
  end
  object ExcludeBtn: TSpeedButton
    Left = 160
    Top = 96
    Width = 24
    Height = 24
    Caption = '<'
    Enabled = False
    OnClick = ExcludeBtnClick
  end
  object ExAllBtn: TSpeedButton
    Left = 160
    Top = 128
    Width = 24
    Height = 24
    Caption = '<<'
    Enabled = False
    OnClick = ExcAllBtnClick
  end
  object BitBtn2: TBitBtn
    Left = 261
    Top = 220
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn1: TBitBtn
    Left = 181
    Top = 220
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object SrcList: TListBox
    Left = 8
    Top = 24
    Width = 144
    Height = 185
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 0
  end
  object DstList: TListBox
    Left = 192
    Top = 24
    Width = 144
    Height = 185
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
  object qryUpdate: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 16
    Top = 216
  end
  object qrySource: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 56
    Top = 216
  end
end
