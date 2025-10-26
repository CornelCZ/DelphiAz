object EditPriceBandNameForm: TEditPriceBandNameForm
  Left = 644
  Top = 244
  HelpContext = 6009
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Price Band Rename'
  ClientHeight = 102
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 157
    Height = 13
    Caption = 'Enter a new name for price band:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 40
    Width = 380
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 200
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
