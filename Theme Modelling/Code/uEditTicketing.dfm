object EditTicketing: TEditTicketing
  Left = 228
  Top = 131
  Width = 442
  Height = 254
  HelpContext = 5037
  BorderIcons = [biSystemMenu]
  Caption = 'Edit ticketing'
  Color = clBtnFace
  Constraints.MaxWidth = 442
  Constraints.MinHeight = 150
  Constraints.MinWidth = 442
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    426
    216)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 175
    Height = 13
    Caption = 'Ticket sequences in selected Theme:'
  end
  object Bevel1: TBevel
    Left = 248
    Top = 192
    Width = 2
    Height = 24
    Anchors = [akLeft, akBottom]
  end
  object btAdd: TButton
    Left = 8
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btAddClick
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 24
    Width = 418
    Height = 163
    ControlType.Strings = (
      'PerTerminal;CheckBox;True;False'
      'PrintTicketNumber;CheckBox;True;False')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsSequences
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = btEditClick
  end
  object btEdit: TButton
    Left = 88
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btEditClick
  end
  object btDelete: TButton
    Left = 168
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btDeleteClick
  end
  object btClose: TButton
    Left = 350
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 5
    OnClick = btCloseClick
  end
  object btManageTicketImages: TButton
    Left = 256
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ticket Images'
    TabOrder = 4
    OnClick = btManageTicketImagesClick
  end
  object qSequences: TADOQuery
    Connection = dmThemeData.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    DataSource = dmThemeData.dsThemes
    Parameters = <
      item
        Name = 'themeid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select * from themecloakroomsequence'
      'where themeid = :themeid')
    Left = 360
    Top = 8
    object qSequencesName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 8
    end
    object qSequencesResetTime: TDateTimeField
      DisplayLabel = 'Reset Time'
      DisplayWidth = 10
      FieldName = 'ResetTime'
      DisplayFormat = 'hh:mm'
    end
    object qSequencesPerTerminal: TBooleanField
      DisplayLabel = 'Per Terminal'
      DisplayWidth = 5
      FieldName = 'PerTerminal'
    end
    object qSequencesCloakroomSequenceID: TIntegerField
      FieldName = 'CloakroomSequenceID'
      Visible = False
    end
    object qSequencesThemeID: TIntegerField
      FieldName = 'ThemeID'
      Visible = False
    end
    object qSequencesPrinteTicketNumber: TBooleanField
      DisplayLabel = 'Print Ticket Number'
      FieldName = 'PrintTicketNumber'
    end
  end
  object dsSequences: TDataSource
    DataSet = qSequences
    Left = 392
    Top = 8
  end
end
