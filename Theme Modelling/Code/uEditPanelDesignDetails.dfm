object EditPanelDesignDetails: TEditPanelDesignDetails
  Left = 120
  Top = 289
  HelpContext = 5009
  BorderStyle = bsSingle
  Caption = 'Panel Design Details'
  ClientHeight = 254
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 89
    Height = 13
    Caption = 'Panel design name'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label3: TLabel
    Left = 8
    Top = 128
    Width = 85
    Height = 13
    Caption = 'Panel design type'
  end
  object lblPayPanel: TLabel
    Left = 8
    Top = 171
    Width = 85
    Height = 13
    Caption = 'Default Pay Panel'
  end
  object lblScreenSize: TLabel
    Left = 232
    Top = 128
    Width = 116
    Height = 13
    Caption = 'Panel design screen size'
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 401
    Height = 49
    TabOrder = 1
  end
  object Button1: TButton
    Left = 256
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
    OnClick = Button2Click
  end
  object cbPanelDesignType: TComboBox
    Left = 8
    Top = 144
    Width = 217
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = cbPanelDesignTypeChange
  end
  object cbUseForcedSelection: TCheckBox
    Left = 232
    Top = 190
    Width = 161
    Height = 17
    Caption = 'Use Forced Item Selection'
    TabOrder = 5
  end
  object cbPayPanel: TComboBox
    Left = 8
    Top = 189
    Width = 217
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    TabStop = False
    OnSelect = cbPayPanelSelect
  end
  object cbxScreenSize: TComboBox
    Left = 232
    Top = 144
    Width = 178
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
end
