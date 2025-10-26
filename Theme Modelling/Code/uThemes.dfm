object Themes: TThemes
  Left = 206
  Top = 84
  HelpContext = 5016
  BorderStyle = bsSingle
  Caption = 'Themes'
  ClientHeight = 559
  ClientWidth = 702
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
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 87
    Height = 13
    Caption = 'Available Themes:'
  end
  object Label2: TLabel
    Left = 8
    Top = 208
    Width = 105
    Height = 13
    Caption = 'Theme Panel Designs:'
  end
  object Label3: TLabel
    Left = 8
    Top = 400
    Width = 93
    Height = 13
    Caption = 'Theme Table plans:'
  end
  object Bevel1: TBevel
    Left = 249
    Top = 169
    Width = 2
    Height = 23
  end
  object Bevel2: TBevel
    Left = 249
    Top = 369
    Width = 2
    Height = 23
  end
  object Bevel3: TBevel
    Left = 249
    Top = 529
    Width = 2
    Height = 23
  end
  object Bevel4: TBevel
    Left = 9
    Top = 201
    Width = 685
    Height = 2
  end
  object btAddTheme: TButton
    Left = 8
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = btAddThemeClick
  end
  object btEditTheme: TButton
    Left = 88
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btEditThemeClick
  end
  object btDeleteTheme: TButton
    Left = 168
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btDeleteThemeClick
  end
  object btClose: TButton
    Left = 619
    Top = 528
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 21
    OnClick = btCloseClick
  end
  object btAddPanelDesign: TButton
    Left = 8
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 7
    OnClick = btAddPanelDesignClick
  end
  object btEditPanelDesign: TButton
    Left = 88
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 8
    OnClick = btEditPanelDesignClick
  end
  object btDeletePanelDesign: TButton
    Left = 168
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 9
    OnClick = btDeletePanelDesignClick
  end
  object btDesignPanelDesign: TButton
    Left = 256
    Top = 368
    Width = 67
    Height = 25
    Caption = 'Design'
    TabOrder = 10
    OnClick = btDesignPanelDesignClick
  end
  object btAddTablePlan: TButton
    Left = 8
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 17
    OnClick = btAddTablePlanClick
  end
  object btEditTablePlan: TButton
    Left = 88
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 18
    OnClick = btEditTablePlanClick
  end
  object btDeleteTablePlan: TButton
    Left = 168
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 19
    OnClick = btDeleteTablePlanClick
  end
  object btPreviewPanelDesign: TButton
    Left = 616
    Top = 368
    Width = 62
    Height = 25
    Caption = 'Preview'
    TabOrder = 14
    OnClick = btPreviewPanelDesignClick
  end
  object btGroup: TButton
    Left = 256
    Top = 528
    Width = 67
    Height = 25
    Caption = 'Groups'
    TabOrder = 20
    OnClick = btGroupClick
  end
  object btEditChoices: TButton
    Left = 400
    Top = 368
    Width = 67
    Height = 25
    Caption = 'Edit choices'
    TabOrder = 12
    OnClick = btEditChoicesClick
  end
  object btStaticPanelSecurity: TButton
    Left = 256
    Top = 168
    Width = 67
    Height = 25
    Caption = 'Security'
    TabOrder = 4
    OnClick = btStaticPanelSecurityClick
  end
  object btCopyPanelDesign: TButton
    Left = 328
    Top = 368
    Width = 67
    Height = 25
    Caption = 'Copy'
    TabOrder = 11
    OnClick = btCopyPanelDesignClick
  end
  object btTickets: TButton
    Left = 328
    Top = 168
    Width = 67
    Height = 25
    Caption = 'Ticketing'
    TabOrder = 5
    OnClick = btTicketsClick
  end
  object dbgThemes: TwwDBGrid
    Left = 8
    Top = 24
    Width = 685
    Height = 137
    Selected.Strings = (
      'Name'#9'25'#9'Name'#9'F'
      'Description'#9'72'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsThemes
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
    OnDblClick = btEditThemeClick
  end
  object dbgThemePanelDesigns: TwwDBGrid
    Left = 8
    Top = 224
    Width = 685
    Height = 137
    Selected.Strings = (
      'Name'#9'25'#9'Name'#9'F'
      'Description'#9'72'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsPanelDesigns
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = btDesignPanelDesignClick
  end
  object dbgThemeTablePlans: TwwDBGrid
    Left = 8
    Top = 416
    Width = 685
    Height = 104
    Selected.Strings = (
      'Name'#9'25'#9'Name'#9'F'
      'Description'#9'72'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsThemeTablePlans
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 16
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = btEditTablePlanClick
  end
  object btMacros: TButton
    Left = 544
    Top = 368
    Width = 67
    Height = 25
    Caption = 'Macros'
    TabOrder = 13
    OnClick = btMacrosClick
  end
  object btChoosePreviewType: TButton
    Left = 677
    Top = 368
    Width = 17
    Height = 25
    Hint = 'Standard preview; no site data included'
    Caption = '6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Marlett'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = btChoosePreviewTypeClick
  end
  object btnDefaultRolePanel: TButton
    Left = 472
    Top = 368
    Width = 67
    Height = 25
    Caption = 'Role Panels'
    TabOrder = 22
    OnClick = btnDefaultRolePanelClick
  end
  object PreviewTypeMenu: TPopupMenu
    MenuAnimation = [maBottomToTop]
    Left = 576
    Top = 168
    object Selectpreviewmode1: TMenuItem
      Tag = -1
      Caption = 'Preview mode:'
      Enabled = False
    end
    object ptStandardPreview: TMenuItem
      Caption = 'Standard preview'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = HandlePreviewTypePopupMenuItem
    end
    object ptRandomTerminal: TMenuItem
      Tag = 1
      Caption = 'Random terminal'
      GroupIndex = 1
      RadioItem = True
      OnClick = HandlePreviewTypePopupMenuItem
    end
    object ptChooseTerminal: TMenuItem
      Tag = 2
      Caption = 'Choose terminal'
      GroupIndex = 1
      RadioItem = True
      OnClick = HandlePreviewTypePopupMenuItem
    end
    object ShowPreviewManager1: TMenuItem
      Tag = -1
      Action = ShowPreviewManager
      GroupIndex = 1
    end
  end
  object ActionList1: TActionList
    Left = 544
    Top = 168
    object ShowPreviewManager: TAction
      Caption = 'Show Manager'
      OnExecute = ShowPreviewManagerExecute
      OnUpdate = ShowPreviewManagerUpdate
    end
  end
end
