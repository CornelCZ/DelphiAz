object fMaintSuperCategory: TfMaintSuperCategory
  Left = 639
  Top = 459
  BorderStyle = bsDialog
  Caption = 'New Super Category'
  ClientHeight = 101
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    342
    101)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Super Category'
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
  object edtSuperCategName: TEdit
    Left = 88
    Top = 46
    Width = 250
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 168
    Top = 73
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 256
    Top = 73
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
