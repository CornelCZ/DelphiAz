object PickSite: TPickSite
  Left = 379
  Top = 159
  Width = 340
  Height = 531
  HelpContext = 5021
  BorderIcons = [biSystemMenu]
  Caption = 'Select Site'
  Color = clBtnFace
  Constraints.MaxWidth = 340
  Constraints.MinHeight = 531
  Constraints.MinWidth = 340
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 485
    Width = 332
    Height = 19
    Panels = <
      item
        Text = 'Dbl Click  Grid to edit terminal setup'
        Width = 200
      end>
    SimplePanel = False
  end
  object DBGridOutlets: TwwDBGrid
    Left = 0
    Top = 0
    Width = 332
    Height = 485
    Selected.Strings = (
      'ReferenceCode'#9'10'#9'Site Ref'#9'F'
      'Name'#9'40'#9'Site Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dmThemeData.dsOutlets
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
    OnKeyPress = DBGridOutletsKeyPress
  end
end
