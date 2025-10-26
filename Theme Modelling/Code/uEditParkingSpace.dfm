object EditParkingSpace: TEditParkingSpace
  Left = 628
  Top = 478
  HelpContext = 5064
  BorderStyle = bsDialog
  ClientHeight = 213
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSequence: TLabel
    Left = 8
    Top = 8
    Width = 89
    Height = 13
    Caption = 'Sequence Number'
  end
  object lblAssign: TLabel
    Left = 8
    Top = 56
    Width = 74
    Height = 13
    Caption = 'Assign Terminal'
  end
  object btOk: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 88
    Top = 184
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = btCancelClick
  end
  object gbxType: TGroupBox
    Left = 8
    Top = 104
    Width = 155
    Height = 73
    Caption = 'Type'
    TabOrder = 0
    object cbxPayPoint: TCheckBox
      Tag = 1
      Left = 24
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Pay Point'
      TabOrder = 0
    end
    object cbxPickupPoint: TCheckBox
      Tag = 1
      Left = 24
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Pickup Point'
      TabOrder = 1
    end
  end
  object cbTerminalName: TComboBox
    Left = 8
    Top = 72
    Width = 155
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnChange = cbTerminalNameChange
  end
  object edtSeqNum: TEdit
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
end
