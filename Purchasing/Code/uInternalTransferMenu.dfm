object frmInternalTransferMenu: TfrmInternalTransferMenu
  Left = 492
  Top = 341
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Internal Transfer'
  ClientHeight = 193
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnUnacceptedInternalTransfers: TButton
    Left = 37
    Top = 32
    Width = 137
    Height = 33
    Caption = '&Unaccepted Transfers'
    TabOrder = 0
    OnClick = btnUnacceptedInternalTransfersClick
  end
  object btnNewInternalTransfer: TButton
    Left = 37
    Top = 80
    Width = 137
    Height = 33
    Caption = '&New Internal Transfer'
    TabOrder = 1
    OnClick = btnNewInternalTransferClick
  end
  object btnClose: TButton
    Left = 37
    Top = 128
    Width = 137
    Height = 33
    Caption = 'Clo&se'
    ModalResult = 1
    TabOrder = 2
  end
end
