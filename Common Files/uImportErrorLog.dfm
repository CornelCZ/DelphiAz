object fImportErrorLog: TfImportErrorLog
  Left = 382
  Top = 280
  Width = 538
  Height = 87
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Pricing Import Errors'
  Color = clBtnFace
  Constraints.MinHeight = 84
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    522
    48)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 346
    Height = 13
    Caption = 
      'The data import failed to complete.  Please check the import fil' +
      'e for errors.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbErrorList: TListBox
    Left = -1
    Top = 59
    Width = 530
    Height = 1
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
  object OKButton: TButton
    Left = 452
    Top = 6
    Width = 71
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object DetailsButton: TButton
    Left = 452
    Top = 32
    Width = 71
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Detail >>'
    TabOrder = 2
    OnClick = DetailsButtonClick
  end
  object Panel2: TPanel
    Left = 360
    Top = 0
    Width = 33
    Height = 60
    Caption = 'Panel2'
    TabOrder = 3
    Visible = False
  end
end
