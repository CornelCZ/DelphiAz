object PortionCookTimes: TPortionCookTimes
  Left = 809
  Top = 263
  HelpContext = 8034
  BorderStyle = bsDialog
  Caption = 'Portion Cook Times - 10/11/2007'
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 212
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    Caption = 'Panel1'
    TabOrder = 0
    object dbgCookTimes: TwwDBGrid
      Left = 4
      Top = 4
      Width = 334
      Height = 204
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
      Align = alClient
      DataSource = ProductsDB.dsEditCookTimes
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFixedResizable, dgFixedProportionalResize, dgHideBottomDataLine]
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnKeyDown = dbgCookTimesKeyDown
      OnMouseDown = dbgCookTimesMouseDown
      OnDrawTitleCell = dbgCookTimesDrawTitleCell
      OnFieldChanged = dbgCookTimesFieldChanged
      PadColumnStyle = pcsPlain
    end
    object pnlCheckBoxHider: TPanel
      Left = 223
      Top = 24
      Width = 81
      Height = 15
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 1
    end
    object wwDBDateTimePicker: TwwDBDateTimePicker
      Left = 72
      Top = 24
      Width = 121
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 1
      DisplayFormat = 'hh:mm:ss'
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 212
    Width = 342
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      342
      31)
    object SaveButton: TButton
      Left = 183
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      ModalResult = 1
      TabOrder = 0
      OnClick = SaveButtonClick
    end
    object CancelButton: TButton
      Left = 263
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = CancelButtonClick
    end
  end
end
