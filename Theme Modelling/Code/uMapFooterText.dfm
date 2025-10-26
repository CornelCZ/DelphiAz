object MapFooterText: TMapFooterText
  Left = 724
  Top = 285
  Width = 425
  Height = 450
  HelpContext = 5084
  Caption = 'Map Sales Areas to Promotional Footer Text Override'
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 425
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnHide = HideFormExecute
  OnShow = ShowFormExecute
  DesignSize = (
    417
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFooters: TLabel
    Left = 4
    Top = 8
    Width = 66
    Height = 13
    Caption = 'Select Footer:'
  end
  object lblMapSAOverrides: TLabel
    Left = 4
    Top = 160
    Width = 187
    Height = 13
    Caption = 'Select Sales Area Footer Text Override:'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 385
    Width = 410
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object dbgFootersWithOverrides: TwwDBGrid
    Left = 4
    Top = 24
    Width = 410
    Height = 129
    Selected.Strings = (
      'FooterName'#9'62'#9'Footer')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = dmPromotionalFooter.dsFootersWithOverrides
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
  object wwDBGrid1: TwwDBGrid
    Left = 4
    Top = 176
    Width = 410
    Height = 206
    ControlType.Strings = (
      'OverrideName;CustomEdit;wwDBLookupCombo1;F')
    Selected.Strings = (
      'SalesAreaName'#9'21'#9'Sales Area'#9#9
      'OverrideName'#9'40'#9'Override Name'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmPromotionalFooter.dsSalesAreaFooterOverride
    TabOrder = 1
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
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 156
    Top = 188
    Width = 244
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'OverrideName'#9'60'#9'Override Name'#9#9)
    DataField = 'OverrideID'
    DataSource = dmPromotionalFooter.dsSalesAreaFooterOverride
    LookupTable = dmPromotionalFooter.qFooterOverrides
    LookupField = 'OverrideID'
    TabOrder = 2
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object btClose: TButton
    Left = 338
    Top = 394
    Width = 76
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 3
    OnClick = btCloseClick
  end
  object ActionList1: TActionList
    Left = 336
    Top = 8
    object ShowForm: TAction
      Caption = 'ShowForm'
      OnExecute = ShowFormExecute
    end
    object HideForm: TAction
      Caption = 'HideForm'
      OnExecute = HideFormExecute
    end
  end
end
