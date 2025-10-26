object PortionScaleContainers: TPortionScaleContainers
  Left = 596
  Top = 259
  HelpContext = 8036
  BorderStyle = bsDialog
  Caption = 'Portion Containers'
  ClientHeight = 243
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 212
    Width = 342
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      342
      31)
    object ButtonSave: TButton
      Left = 185
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      ModalResult = 1
      TabOrder = 0
      OnClick = ButtonSaveClick
    end
    object ButtonCancel: TButton
      Left = 265
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 212
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 1
    DesignSize = (
      342
      212)
    object dbgPortionScaleContainers: TwwDBGrid
      Left = 4
      Top = 4
      Width = 334
      Height = 204
      ControlType.Strings = (
        'ContainerId;CustomEdit;wwDBLookupComboContainerTares;F'
        'ContainerName;CustomEdit;wwDBLookupComboContainer;F')
      Selected.Strings = (
        'PortionName'#9'20'#9'Portion'
        'ContainerName'#9'30'#9'Container')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = ProductsDB.dsEditContainers
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      PadColumnStyle = pcsPlain
    end
    object wwDBLookupComboContainer: TwwDBLookupCombo
      Left = 204
      Top = 36
      Width = 64
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'20'#9'Name'#9#9)
      DataField = 'ContainerId'
      LookupTable = ProductsDB.qScaleContainers
      LookupField = 'ContainerId'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
end
