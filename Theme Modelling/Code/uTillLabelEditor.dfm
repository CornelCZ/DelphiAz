object TillLabelEditor: TTillLabelEditor
  Left = 510
  Top = 236
  HelpContext = 5006
  ActiveControl = edLabel
  AutoSize = True
  BorderStyle = bsDialog
  BorderWidth = 4
  Caption = 'Edit Label'
  ClientHeight = 137
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 111
    Height = 13
    Caption = 'Enter/Amend label text:'
  end
  object Label2: TLabel
    Left = 37
    Top = 56
    Width = 54
    Height = 13
    Caption = 'Text Colour'
  end
  object Label3: TLabel
    Left = 0
    Top = 80
    Width = 91
    Height = 13
    Caption = 'Background Colour'
  end
  object edLabel: TEdit
    Left = 0
    Top = 16
    Width = 297
    Height = 33
    AutoSize = False
    TabOrder = 0
    Text = 'edLabel'
  end
  object btOk: TButton
    Left = 144
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btCancel: TButton
    Left = 224
    Top = 112
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object edFGColour: TStaticText
    Left = 96
    Top = 56
    Width = 33
    Height = 17
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    Color = clSilver
    ParentColor = False
    TabOrder = 1
    OnClick = edFGColourClick
  end
  object edBGColour: TStaticText
    Left = 96
    Top = 80
    Width = 33
    Height = 17
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    Color = clSilver
    ParentColor = False
    TabOrder = 2
    OnClick = edBGColourClick
  end
  object cbLargeFont: TCheckBox
    Left = 136
    Top = 56
    Width = 81
    Height = 17
    Caption = 'Large Font'
    TabOrder = 3
  end
  object FGColourDlg: TColorDialog
    Ctl3D = True
    CustomColors.Strings = (
      'Black=000000'
      'White=FFFFFF')
    Options = [cdFullOpen, cdAnyColor]
    Left = 224
    Top = 56
  end
  object BGColourDlg: TColorDialog
    Ctl3D = True
    CustomColors.Strings = (
      'Black=000000'
      'White=FFFFFF')
    Options = [cdFullOpen, cdAnyColor]
    Left = 264
    Top = 56
  end
end
