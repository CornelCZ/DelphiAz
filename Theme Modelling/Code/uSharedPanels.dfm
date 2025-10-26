object SharedPanels: TSharedPanels
  Left = 562
  Top = 169
  HelpContext = 5015
  BorderStyle = bsDialog
  Caption = 'Shared Panels'
  ClientHeight = 488
  ClientWidth = 634
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 157
    Height = 13
    Caption = 'Shared Panels / Variation Groups'
  end
  object Label2: TLabel
    Left = 8
    Top = 248
    Width = 80
    Height = 13
    Caption = 'Panel Variations:'
  end
  object lbDefaultVariation: TLabel
    Left = 8
    Top = 428
    Width = 84
    Height = 13
    Caption = 'Default Variation:'
  end
  object imCheck: TImage
    Left = 416
    Top = 216
    Width = 10
    Height = 10
    Picture.Data = {
      07544269746D6170C2010000424DC20100000000000036000000280000000B00
      00000B00000001001800000000008C010000D30E0000D30E0000000000000000
      0000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00000000FFFF00FFFF00FFFF00FFFF00AEAEAEFFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00000000FFFF00FFFF00FFFF00AEAEAE000000AEAEAEFFFF00FF
      FF00FFFF00FFFF00FFFF00000000FFFF00FFFF00AEAEAE000000000000000000
      AEAEAEFFFF00FFFF00FFFF00FFFF00000000FFFF00AEAEAE0000000000000000
      00000000000000AEAEAEFFFF00FFFF00FFFF00000000FFFF00AEAEAE00000000
      0000AEAEAE000000000000000000AEAEAEFFFF00FFFF00000000FFFF00AEAEAE
      000000AEAEAEFFFF00AEAEAE000000000000000000AEAEAEFFFF00000000FFFF
      00FFFF00AEAEAEFFFF00FFFF00FFFF00AEAEAE000000000000AEAEAEFFFF0000
      0000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00AEAEAE000000AEAEAE
      FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00AEAE
      AEFFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00000000}
    Visible = False
  end
  object Bevel1: TBevel
    Left = 249
    Top = 217
    Width = 2
    Height = 23
  end
  object Bevel2: TBevel
    Left = 249
    Top = 457
    Width = 2
    Height = 23
  end
  object btAddStandard: TButton
    Left = 8
    Top = 216
    Width = 75
    Height = 25
    Action = AddStandard
    TabOrder = 1
  end
  object btEditStandard: TButton
    Left = 88
    Top = 216
    Width = 75
    Height = 25
    Action = EditStandard
    TabOrder = 2
  end
  object btDeleteStandard: TButton
    Left = 168
    Top = 216
    Width = 75
    Height = 25
    Action = DeleteStandard
    TabOrder = 3
  end
  object btClose: TButton
    Left = 552
    Top = 456
    Width = 75
    Height = 25
    Action = CloseForm
    TabOrder = 13
  end
  object btDesignStandard: TButton
    Left = 256
    Top = 216
    Width = 75
    Height = 25
    Action = DesignStandard
    TabOrder = 4
  end
  object btCopyStandard: TButton
    Left = 336
    Top = 216
    Width = 75
    Height = 25
    Action = CopyStandard
    TabOrder = 5
  end
  object btAddVariation: TButton
    Left = 8
    Top = 456
    Width = 75
    Height = 25
    Action = AddVariation
    TabOrder = 8
  end
  object btEditVariation: TButton
    Left = 88
    Top = 456
    Width = 75
    Height = 25
    Action = EditVariation
    TabOrder = 9
  end
  object btDeleteVariation: TButton
    Left = 168
    Top = 456
    Width = 75
    Height = 25
    Action = DeleteVariation
    TabOrder = 10
  end
  object btDesignVariation: TButton
    Left = 256
    Top = 456
    Width = 75
    Height = 25
    Action = DesignVariation
    TabOrder = 11
  end
  object btCopyVariation: TButton
    Left = 336
    Top = 456
    Width = 75
    Height = 25
    Action = CopyVariation
    TabOrder = 12
  end
  object dbgSharedPanels: TwwDBGrid
    Left = 8
    Top = 24
    Width = 617
    Height = 185
    ControlType.Strings = (
      'VariationGroup;CustomEdit;wwCheckBox1;F')
    Selected.Strings = (
      'Name'#9'24'#9'Name'#9'F'
      'Description'#9'67'#9'Description'#9'F'
      'VariationGroup'#9'6'#9'Var.'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsSharedPanels
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
    OnDrawDataCell = dbgSharedPanelsDrawDataCell
    OnDblClick = DesignStandardExecute
  end
  object dbgSharedPanelVariations: TwwDBGrid
    Left = 8
    Top = 264
    Width = 617
    Height = 153
    Selected.Strings = (
      'Name'#9'24'#9'Name'#9'F'
      'Description'#9'73'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsSharedPanelVariations
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
    OnDblClick = DesignVariationExecute
  end
  object cbDefaultVariation: TwwDBLookupCombo
    Left = 96
    Top = 424
    Width = 153
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PanelName'#9'50'#9'PanelName'#9#9)
    DataField = 'defaultvariationpanelid'
    DataSource = dmThemeData.dsSharedPanelDefault
    LookupTable = dmThemeData.qDefaultChoices
    LookupField = 'PanelID'
    DropDownWidth = 121
    TabOrder = 7
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
    OnChange = cbDefaultVariationChange
  end
  object SharedPanelActions: TActionList
    OnExecute = SharedPanelActionsExecute
    Left = 592
    object AddStandard: TAction
      Caption = 'Add'
      OnExecute = AddStandardExecute
    end
    object EditStandard: TAction
      Caption = 'Edit'
      OnExecute = EditStandardExecute
    end
    object CopyStandard: TAction
      Caption = 'Copy'
      OnExecute = CopyStandardExecute
    end
    object DesignStandard: TAction
      Caption = 'Design'
      OnExecute = DesignStandardExecute
      OnUpdate = HandleUpdateEnabledIfNoVariations
    end
    object DeleteStandard: TAction
      Caption = 'Delete'
      OnExecute = DeleteStandardExecute
    end
    object AddVariation: TAction
      Caption = 'Add'
      OnExecute = AddVariationExecute
    end
    object EditVariation: TAction
      Caption = 'Edit'
      OnExecute = EditVariationExecute
      OnUpdate = HandleUpdateDisabledIfNoVariations
    end
    object CopyVariation: TAction
      Caption = 'Copy'
      OnExecute = CopyVariationExecute
      OnUpdate = HandleUpdateDisabledIfNoVariations
    end
    object DesignVariation: TAction
      Caption = 'Design'
      OnExecute = DesignVariationExecute
      OnUpdate = HandleUpdateDisabledIfNoVariations
    end
    object DeleteVariation: TAction
      Caption = 'Delete'
      OnExecute = DeleteVariationExecute
      OnUpdate = HandleUpdateDisabledIfNoVariations
    end
    object CloseForm: TAction
      Caption = 'Close'
      OnExecute = CloseFormExecute
    end
  end
end
