object DefineMacros: TDefineMacros
  Left = 446
  Top = 131
  Width = 571
  Height = 339
  HelpContext = 5065
  Caption = 'Define Macros'
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
  OnHide = FormHide
  OnShow = FormShow
  DesignSize = (
    563
    312)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 158
    Height = 13
    Caption = 'Macros defined for Panel Design:'
  end
  object btAddMacro: TButton
    Left = 8
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btAddMacroClick
  end
  object btEditMacro: TButton
    Left = 88
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btEditMacroClick
  end
  object btDeleteMacro: TButton
    Left = 168
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btDeleteMacroClick
  end
  object btClose: TButton
    Left = 480
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 5
    OnClick = btCloseClick
  end
  object dbgDefineMacros: TwwDBGrid
    Left = 8
    Top = 24
    Width = 547
    Height = 249
    Selected.Strings = (
      'Name'#9'25'#9'Name'
      'Description'#9'61'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmThemeData.dsMacros
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = dbgDefineMacrosDblClick
  end
  object btShowUses: TButton
    Left = 248
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Show Uses'
    TabOrder = 4
    OnClick = btShowUsesClick
  end
end
