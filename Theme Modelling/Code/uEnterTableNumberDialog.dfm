object EnterTableNumberDialog: TEnterTableNumberDialog
  Left = 474
  Top = 197
  HelpContext = 5032
  ActiveControl = edTableNumber
  BorderStyle = bsToolWindow
  ClientHeight = 79
  ClientWidth = 169
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Table Number:'
  end
  object edTableNumber: TEdit
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    MaxLength = 4
    TabOrder = 0
    OnChange = edTableNumberChange
    OnKeyPress = edTableNumberKeyPress
  end
  object btOk: TButton
    Left = 8
    Top = 48
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 88
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = btCancelClick
  end
end
