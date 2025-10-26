object OutletTablePlans: TOutletTablePlans
  Left = 388
  Top = 129
  HelpContext = 5013
  BorderStyle = bsSingle
  Caption = 'Site Table Plans'
  ClientHeight = 359
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Available Sites'
  end
  object Label2: TLabel
    Left = 8
    Top = 168
    Width = 77
    Height = 13
    Caption = 'Site table plans:'
  end
  object Bevel2: TBevel
    Left = 249
    Top = 328
    Width = 2
    Height = 23
  end
  object btAddOutletTablePlan: TButton
    Left = 8
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 2
    OnClick = btAddOutletTablePlanClick
  end
  object btEditOutletTablePlan: TButton
    Left = 88
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 3
    OnClick = btEditOutletTablePlanClick
  end
  object btDeleteOutletTablePlan: TButton
    Left = 168
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = btDeleteOutletTablePlanClick
  end
  object btClose: TButton
    Left = 552
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 6
    OnClick = btCloseClick
  end
  object btEditOutletTablePlanDesign: TButton
    Left = 256
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Design'
    TabOrder = 5
    OnClick = btEditOutletTablePlanDesignClick
  end
  object dbgSiteList: TwwDBGrid
    Left = 8
    Top = 24
    Width = 617
    Height = 137
    Selected.Strings = (
      'ReferenceCode'#9'15'#9'Reference Code'#9'F'
      'Name'#9'82'#9'Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsOutlets
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
  end
  object dbgTablePlanList: TwwDBGrid
    Left = 8
    Top = 184
    Width = 617
    Height = 137
    Selected.Strings = (
      'Name'#9'15'#9'Name'#9'F'
      'Description'#9'82'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dmThemeData.dsOutletTablePlans
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = btEditOutletTablePlanDesignClick
  end
end
