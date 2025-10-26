object frmConfigure: TfrmConfigure
  Left = 418
  Top = 319
  Width = 409
  Height = 291
  Caption = 'Configure'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonPanel: TPanel
    Left = 0
    Top = 195
    Width = 393
    Height = 57
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 144
      Top = 8
      Width = 113
      Height = 41
      Caption = '&Close'
      ModalResult = 1
      TabOrder = 0
      NumGlyphs = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 393
    Height = 195
    Align = alClient
    TabOrder = 1
    object Button3: TButton
      Left = 80
      Top = 20
      Width = 233
      Height = 25
      Caption = 'View Cost Prices'
      TabOrder = 0
      OnClick = Button3Click
    end
    object ViewAllSuppProdsBtn: TButton
      Left = 80
      Top = 57
      Width = 233
      Height = 25
      Caption = 'View All Suppliers Products'
      TabOrder = 1
      OnClick = ViewAllSuppProdsBtnClick
    end
    object Button4: TButton
      Left = 80
      Top = 94
      Width = 233
      Height = 25
      Caption = 'Edit Cost Prices'
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 80
      Top = 131
      Width = 233
      Height = 25
      Caption = 'Allow Free Items'
      TabOrder = 3
      OnClick = Button5Click
    end
    object CreateMaskBtn: TButton
      Left = 80
      Top = 168
      Width = 233
      Height = 25
      Caption = 'Create Invoice Number Mask'
      TabOrder = 4
      OnClick = CreateMaskBtnClick
    end
  end
end
