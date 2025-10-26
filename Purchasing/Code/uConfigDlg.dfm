object fconfigdlg: Tfconfigdlg
  Left = 403
  Top = 199
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Configure....'
  ClientHeight = 247
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label2: TLabel
    Left = 36
    Top = 14
    Width = 269
    Height = 32
    AutoSize = False
    Caption = 
      'Save new Unit Costs entered in Delivery Note without prompting t' +
      'he user'
    WordWrap = True
  end
  object Label1: TLabel
    Left = 12
    Top = 148
    Width = 215
    Height = 16
    Caption = 'Choose a tax rate to use for invoices:'
  end
  object Label3: TLabel
    Left = 36
    Top = 67
    Width = 269
    Height = 17
    AutoSize = False
    Caption = 'Hide Sort Order on Delivery Note Screen'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 36
    Top = 107
    Width = 269
    Height = 17
    AutoSize = False
    Caption = 'Insert delivered items after selected item'
    WordWrap = True
  end
  object Button1: TButton
    Left = 88
    Top = 201
    Width = 139
    Height = 41
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object cbxNoUserPrompt: TCheckBox
    Left = 12
    Top = 14
    Width = 17
    Height = 32
    TabOrder = 1
  end
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 236
    Top = 144
    Width = 65
    Height = 24
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'band'#9'7'#9'band')
    LookupTable = wwqBand
    LookupField = 'band'
    Style = csDropDownList
    TabOrder = 2
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cbxHideSortOrder: TCheckBox
    Left = 12
    Top = 60
    Width = 17
    Height = 32
    TabOrder = 3
  end
  object cbxInsertAfter: TCheckBox
    Left = 12
    Top = 100
    Width = 17
    Height = 32
    TabOrder = 4
  end
  object wwtSysVar: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PurSysVar'
    Left = 40
    Top = 192
  end
  object wwqBand: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select distinct a."band"'
      'from "ustaxes" a')
    Left = 8
    Top = 192
  end
  object qGenerVar: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 39
    Top = 159
  end
end
