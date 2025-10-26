object fMaintDivision: TfMaintDivision
  Left = 393
  Top = 200
  BorderStyle = bsDialog
  Caption = 'New Division'
  ClientHeight = 229
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    342
    229)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Division'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 4
    Top = 48
    Width = 38
    Height = 13
    Caption = '* Name:'
  end
  object lblType: TLabel
    Left = 4
    Top = 150
    Width = 34
    Height = 13
    Caption = '* Type:'
  end
  object DescriptionLabel: TLabel
    Left = 4
    Top = 74
    Width = 62
    Height = 13
    Caption = '  Description:'
  end
  object ReferenceCodeLabel: TLabel
    Left = 4
    Top = 176
    Width = 87
    Height = 13
    Caption = '  Reference Code:'
  end
  object edtDivName: TEdit
    Left = 90
    Top = 46
    Width = 225
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 184
    Top = 200
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 264
    Top = 200
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object TypeComboBox: TComboBox
    Left = 90
    Top = 146
    Width = 67
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object DivisionDescMemo: TMemo
    Left = 90
    Top = 72
    Width = 250
    Height = 69
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ReferenceCodeEdit: TEdit
    Left = 90
    Top = 172
    Width = 225
    Height = 21
    MaxLength = 10
    TabOrder = 3
  end
end
