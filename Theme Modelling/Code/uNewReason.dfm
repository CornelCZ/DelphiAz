object frmNewReason: TfrmNewReason
  Left = 627
  Top = 445
  HelpContext = 5047
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'New Reason'
  ClientHeight = 163
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    391
    163)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 228
    Top = 129
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 308
    Top = 129
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object gbNewReason: TGroupBox
    Left = 16
    Top = 8
    Width = 361
    Height = 105
    TabOrder = 0
    object lblNewReason: TLabel
      Left = 24
      Top = 24
      Width = 60
      Height = 13
      Caption = 'New Reason'
    end
    object edNewReason: TEdit
      Left = 24
      Top = 48
      Width = 305
      Height = 21
      MaxLength = 40
      TabOrder = 0
      OnChange = edNewReasonChange
    end
  end
end
