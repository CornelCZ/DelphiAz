object TicketingImageAddEdit: TTicketingImageAddEdit
  Left = 610
  Top = 153
  Width = 425
  Height = 372
  HelpContext = 5075
  Caption = 'TicketingImageAddEdit'
  Color = clBtnFace
  Constraints.MinHeight = 372
  Constraints.MinWidth = 425
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    417
    345)
  PixelsPerInch = 96
  TextHeight = 13
  object Name: TLabel
    Left = 8
    Top = 8
    Width = 61
    Height = 13
    Caption = 'Image name:'
  end
  object lbDescription: TLabel
    Left = 8
    Top = 56
    Width = 48
    Height = 13
    Caption = 'Image file:'
  end
  object Label1: TLabel
    Left = 291
    Top = 104
    Width = 116
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '<== Paper feed direction'
  end
  object Label2: TLabel
    Left = 8
    Top = 296
    Width = 53
    Height = 13
    Caption = 'Image size:'
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object edFileName: TEdit
    Left = 8
    Top = 72
    Width = 377
    Height = 21
    Color = clBtnFace
    MaxLength = 50
    ReadOnly = True
    TabOrder = 1
  end
  object btOpenImage: TButton
    Left = 384
    Top = 72
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btOpenImageClick
  end
  object pnImage: TPanel
    Left = 8
    Top = 120
    Width = 401
    Height = 169
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object CloakroomImage: TImage
      Left = 1
      Top = 1
      Width = 399
      Height = 167
      Align = alClient
      Center = True
      Proportional = True
    end
  end
  object btOk: TButton
    Left = 254
    Top = 312
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    DragCursor = crDefault
    TabOrder = 6
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 334
    Top = 312
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object btConvertBW: TButton
    Left = 8
    Top = 312
    Width = 73
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'To Mono'
    TabOrder = 4
    OnClick = btConvertBWClick
  end
  object btRotate: TButton
    Left = 168
    Top = 312
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Rotate'
    TabOrder = 5
    OnClick = btRotateClick
  end
  object btInvert: TButton
    Left = 88
    Top = 312
    Width = 73
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Invert'
    TabOrder = 8
    OnClick = btInvertClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = '*.bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 336
    Top = 48
  end
end
