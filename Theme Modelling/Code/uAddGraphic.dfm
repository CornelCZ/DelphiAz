object AddGraphic: TAddGraphic
  Left = 456
  Top = 363
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Add New Graphic'
  ClientHeight = 192
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 433
    Height = 129
  end
  object Bevel2: TBevel
    Left = 320
    Top = 16
    Width = 110
    Height = 110
  end
  object LblGraphicName: TLabel
    Left = 24
    Top = 24
    Width = 68
    Height = 13
    Caption = 'Graphic Name'
  end
  object lblFileName: TLabel
    Left = 24
    Top = 72
    Width = 53
    Height = 13
    Caption = 'Source File'
  end
  object imPreview: TImage
    Left = 322
    Top = 18
    Width = 105
    Height = 105
    Proportional = True
  end
  object PanelDisableFilenameEdit: TPanel
    Left = 24
    Top = 88
    Width = 257
    Height = 25
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 4
    object edtFileName: TEdit
      Left = 0
      Top = 1
      Width = 257
      Height = 21
      MaxLength = 50
      ReadOnly = True
      TabOrder = 0
    end
  end
  object edtGraphicName: TEdit
    Left = 24
    Top = 40
    Width = 281
    Height = 21
    MaxLength = 50
    TabOrder = 0
    OnKeyPress = edtGraphicNameKeyPress
  end
  object btnOpenFile: TButton
    Left = 280
    Top = 89
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = btnOpenFileClick
  end
  object btnOK: TButton
    Left = 272
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object bntCancel: TButton
    Left = 368
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object odGetFileName: TOpenDialog
    DefaultExt = '*.bmp'
    Filter = 'BMP|*.bmp'
    Left = 144
    Top = 152
  end
end
