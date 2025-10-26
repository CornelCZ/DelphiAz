object fTagSelection: TfTagSelection
  Left = 610
  Top = 261
  BorderStyle = bsDialog
  Caption = 'Tags'
  ClientHeight = 344
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    571
    344)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTags: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Tags:'
  end
  object btnOK: TButton
    Left = 408
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 491
    Top = 309
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnClear: TButton
    Left = 8
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    TabOrder = 3
    OnClick = btnClearClick
  end
  inline TagListFrame: TTagListFrame
    Left = 8
    Top = 25
    Width = 596
    Height = 275
    TabOrder = 2
    inherited ScrollBox: TScrollBox
      Width = 305
      Height = 275
    end
    inherited grpBoxTagFilter: TGroupBox
      Left = 314
    end
  end
end
