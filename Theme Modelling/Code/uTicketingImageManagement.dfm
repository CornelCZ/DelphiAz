object TicketingImageManagement: TTicketingImageManagement
  Left = 605
  Top = 177
  Width = 441
  Height = 332
  HelpContext = 5074
  Caption = 'Manage Ticket Images'
  Color = clBtnFace
  Constraints.MinHeight = 332
  Constraints.MinWidth = 441
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    433
    305)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 155
    Height = 13
    Caption = 'Ticket images in selected theme:'
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 79
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Total image size:'
  end
  object DBText1: TDBText
    Left = 90
    Top = 256
    Width = 42
    Height = 13
    Anchors = [akLeft, akBottom]
    AutoSize = True
    DataField = 'TotalImageSize'
    DataSource = dmThemeData.dsTotalImageSize
  end
  object lbSizeWarning: TLabel
    Left = 144
    Top = 256
    Width = 160
    Height = 13
    Caption = '(Max size for BTP R580 is 128KB)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btAdd: TButton
    Left = 8
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btAddClick
  end
  object btEdit: TButton
    Left = 88
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btEditClick
  end
  object btDelete: TButton
    Left = 168
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btDeleteClick
  end
  object btClose: TButton
    Left = 350
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 4
    OnClick = btCloseClick
  end
  object dbgImages: TwwDBGrid
    Left = 8
    Top = 24
    Width = 417
    Height = 225
    Selected.Strings = (
      'Name'#9'50'#9'Name'#9'F'
      'BitmapSize'#9'14'#9'Size'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmThemeData.dsThemeCloakroomImage
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnDblClick = btEditClick
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 400
    Top = 8
  end
end
