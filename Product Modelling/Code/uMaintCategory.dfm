object fMaintCategory: TfMaintCategory
  Left = 659
  Top = 213
  BorderStyle = bsDialog
  Caption = 'New Category'
  ClientHeight = 173
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
    173)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Category'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 22
    Top = 48
    Width = 38
    Height = 13
    Caption = '* Name:'
  end
  object DescriptionLabel: TLabel
    Left = 22
    Top = 74
    Width = 62
    Height = 13
    Caption = '  Description:'
  end
  object edtCategName: TEdit
    Left = 88
    Top = 46
    Width = 250
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 168
    Top = 146
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 256
    Top = 146
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object CategoryDescMemo: TMemo
    Left = 88
    Top = 72
    Width = 250
    Height = 69
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
