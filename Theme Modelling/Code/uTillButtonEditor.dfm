object TillButtonEditor: TTillButtonEditor
  Left = 541
  Top = 291
  HelpContext = 5005
  AutoSize = True
  BorderStyle = bsDialog
  BorderWidth = 4
  Caption = 'Edit Button'
  ClientHeight = 385
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object FunctionGrpBx: TGroupBox
    Left = 0
    Top = 129
    Width = 329
    Height = 105
    Align = alTop
    Caption = 'Function Details'
    TabOrder = 3
    object lbBFunc: TLabel
      Tag = 1
      Left = 16
      Top = 25
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object lblFuncData: TLabel
      Tag = 1
      Left = 16
      Top = 51
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object lblFuncDesc: TLabel
      Tag = 1
      Left = 16
      Top = 78
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object ButtonTypeIDEdit: TEdit
      Tag = 1
      Left = 78
      Top = 20
      Width = 58
      Height = 21
      TabOrder = 0
      Text = '0'
      OnChange = ButtonTypeIDEditChange
    end
    object edButtonTypeData: TEdit
      Tag = 1
      Left = 78
      Top = 46
      Width = 105
      Height = 21
      TabOrder = 1
      OnKeyUp = edButtonTypeDataKeyUp
    end
    object edtButtonTypeDesc: TEdit
      Tag = 1
      Left = 78
      Top = 73
      Width = 203
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object edButtonTypeID: TUpDown
      Tag = 1
      Left = 136
      Top = 20
      Width = 15
      Height = 21
      Associate = ButtonTypeIDEdit
      Min = 0
      Position = 0
      TabOrder = 3
      Wrap = False
    end
  end
  object FormatGrpBx: TGroupBox
    Left = 0
    Top = 73
    Width = 329
    Height = 56
    Align = alTop
    Caption = 'Format Options'
    TabOrder = 1
    object Label2: TLabel
      Left = 40
      Top = 25
      Width = 54
      Height = 13
      Caption = 'Text Colour'
    end
    object Label3: TLabel
      Left = 149
      Top = 25
      Width = 91
      Height = 13
      Caption = 'Background Colour'
    end
    object edFGColour: TStaticText
      Left = 14
      Top = 20
      Width = 23
      Height = 22
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      Color = clSilver
      ParentColor = False
      TabOrder = 0
      OnClick = edFGColourClick
    end
    object cbBackdropColours: TComboBoxEx
      Left = 106
      Top = 20
      Width = 39
      Height = 22
      ItemsEx.CaseSensitive = False
      ItemsEx.SortType = stNone
      ItemsEx = <>
      Style = csExDropDownList
      StyleEx = []
      ItemHeight = 16
      TabOrder = 1
      Images = ilBackdropColours
      DropDownCount = 8
    end
    object cbLargeFont: TCheckBox
      Left = 249
      Top = 24
      Width = 74
      Height = 17
      Caption = 'Large Font'
      TabOrder = 2
    end
  end
  object pnlSecurity: TPanel
    Left = 0
    Top = 314
    Width = 329
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object btEditSecurity: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Edit Security'
      TabOrder = 0
      OnClick = btEditSecurityClick
    end
    object cbDefault: TCheckBox
      Left = 148
      Top = 13
      Width = 178
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Default Correction Method'
      TabOrder = 1
      Visible = False
    end
  end
  object TextGrpBx: TGroupBox
    Left = 0
    Top = 0
    Width = 329
    Height = 73
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 17
      Width = 49
      Height = 40
      Alignment = taCenter
      AutoSize = False
      Caption = '"Override" button text'
      WordWrap = True
    end
    object Label6: TLabel
      Left = 184
      Top = 20
      Width = 35
      Height = 39
      Alignment = taCenter
      Caption = 'Original'#13#10'button'#13#10'text'
    end
    object mmEposName: TMemo
      Left = 78
      Top = 16
      Width = 73
      Height = 50
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      WordWrap = False
      OnKeyPress = mmEposNameKeyPress
    end
    object mmOriginalName: TMemo
      Left = 235
      Top = 16
      Width = 73
      Height = 50
      Alignment = taCenter
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      WordWrap = False
      OnKeyPress = mmEposNameKeyPress
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 355
    Width = 329
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      329
      30)
    object btOk: TButton
      Left = 169
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 249
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object ProductGrpBx: TGroupBox
    Left = 0
    Top = 234
    Width = 329
    Height = 80
    Align = alTop
    Caption = 'Product Details'
    TabOrder = 2
    object lblProdType: TLabel
      Left = 16
      Top = 24
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object lblProdDesc: TLabel
      Left = 16
      Top = 51
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object edtProductType: TEdit
      Left = 78
      Top = 20
      Width = 121
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edtProductDescription: TEdit
      Left = 78
      Top = 46
      Width = 243
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
  end
  object ilBackdropColours: TImageList
    Left = 120
    Top = 240
  end
  object FGColourDlg: TColorDialog
    Ctl3D = True
    CustomColors.Strings = (
      'Black=000000'
      'White=FFFFFF')
    Options = [cdFullOpen, cdAnyColor]
    Left = 104
    Top = 24
  end
end
