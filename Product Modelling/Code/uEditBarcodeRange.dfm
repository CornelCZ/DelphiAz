object frmEditBarcodeRange: TfrmEditBarcodeRange
  Left = 761
  Top = 286
  HelpContext = 5049
  BorderStyle = bsSingle
  Caption = 'Range Definition Entry'
  ClientHeight = 220
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 179
    Align = alClient
    TabOrder = 0
    object lblDescription: TLabel
      Left = 8
      Top = 8
      Width = 57
      Height = 13
      Caption = 'Description:'
    end
    object lblRangeStart: TLabel
      Left = 8
      Top = 61
      Width = 61
      Height = 13
      Caption = 'Range start:'
    end
    object lblRangeEnd: TLabel
      Left = 8
      Top = 115
      Width = 56
      Height = 13
      Caption = 'Range end:'
    end
    object edtDescription: TEdit
      Left = 8
      Top = 24
      Width = 233
      Height = 21
      MaxLength = 20
      TabOrder = 0
      Text = 'New Range'
    end
    object edtRangeStart: TEdit
      Left = 8
      Top = 77
      Width = 169
      Height = 21
      MaxLength = 13
      TabOrder = 1
      OnChange = edtRangeStartChange
      OnEnter = edtRangeStartEnter
      OnKeyPress = edtRangeStartKeyPress
    end
    object edtRangeEnd: TEdit
      Left = 8
      Top = 131
      Width = 169
      Height = 21
      MaxLength = 13
      TabOrder = 2
      OnChange = edtRangeStartChange
      OnEnter = edtRangeStartEnter
      OnKeyPress = edtRangeStartKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 179
    Width = 250
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      250
      41)
    object btOk: TButton
      Left = 90
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btCancel: TButton
      Left = 170
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
