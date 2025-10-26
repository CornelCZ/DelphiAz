object frmSwipeCardRanges: TfrmSwipeCardRanges
  Left = 656
  Top = 328
  HelpContext = 5048
  BorderStyle = bsSingle
  Caption = 'Security Card Ranges'
  ClientHeight = 399
  ClientWidth = 545
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
  object pnlMain: TPanel
    Left = 0
    Top = 361
    Width = 545
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 454
      Top = 5
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object pcRanges: TPageControl
    Left = 0
    Top = 0
    Width = 545
    Height = 361
    ActivePage = tsCardRanges
    Align = alTop
    TabIndex = 0
    TabOrder = 1
    OnChange = pcRangesChange
    OnChanging = pcRangesChanging
    object tsCardRanges: TTabSheet
      Caption = 'Card Ranges'
      object gridSwipeCards: TwwDBGrid
        Left = 2
        Top = 1
        Width = 532
        Height = 278
        ControlType.Strings = (
          'CanPayOnBarAccount;CheckBox;True;False'
          'CanSaveOnBarAccount;CheckBox;True;False'
          'AutoPrintReceipt;CheckBox;True;False')
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9#9
          'StartValue'#9'25'#9'Range start'#9'F'
          'EndValue'#9'25'#9'Range end'#9'F'
          'Track'#9'10'#9'Card track'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnRowChanged = gridSwipeCardsRowChanged
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        DataSource = dsSwipeCards
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
        OnDblClick = gridSwipeCardsDblClick
      end
      object btnAdd: TButton
        Left = 8
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddClick
      end
      object btnEdit: TButton
        Left = 88
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Edit'
        TabOrder = 2
        OnClick = btnEditClick
      end
      object btnDelete: TButton
        Left = 168
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 3
        OnClick = btnDeleteClick
      end
      object btnExceptions: TButton
        Left = 272
        Top = 296
        Width = 129
        Height = 25
        Caption = 'Card Range Exceptions'
        TabOrder = 4
        OnClick = btnExceptionsClick
      end
      object btnValidationConfigs: TButton
        Left = 409
        Top = 296
        Width = 123
        Height = 25
        Caption = 'Validation List Configs'
        TabOrder = 5
        OnClick = btnValidationConfigsClick
      end
    end
    object tsGroups: TTabSheet
      Caption = 'Groupings'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 72
        Width = 106
        Height = 13
        Caption = 'Selected Card Ranges'
      end
      object Label2: TLabel
        Left = 312
        Top = 72
        Width = 108
        Height = 13
        Caption = 'Available Card Ranges'
      end
      object grbxCardGroups: TGroupBox
        Left = 0
        Top = 0
        Width = 537
        Height = 57
        Align = alTop
        Caption = 'Groups'
        TabOrder = 0
        object cbxGroupNames: TComboBox
          Left = 8
          Top = 18
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = cbxGroupNamesChange
          OnDropDown = cbxGroupNamesDropDown
        end
        object btnAddGroup: TButton
          Left = 200
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 1
          OnClick = btnAddGroupClick
        end
        object btnDeleteGroup: TButton
          Left = 288
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Delete'
          TabOrder = 2
          OnClick = btnDeleteGroupClick
        end
      end
      object lbSelectedRanges: TListBox
        Left = 0
        Top = 88
        Width = 225
        Height = 241
        ItemHeight = 13
        Sorted = True
        TabOrder = 1
      end
      object lbAvailableRanges: TListBox
        Left = 304
        Top = 88
        Width = 225
        Height = 241
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
      end
      object btnMoveToSelected: TButton
        Left = 244
        Top = 168
        Width = 41
        Height = 25
        Caption = '<'
        TabOrder = 3
        OnClick = btnMoveToSelectedClick
      end
      object btnMoveToAvail: TButton
        Left = 244
        Top = 208
        Width = 41
        Height = 25
        Caption = '>'
        TabOrder = 4
        OnClick = btnMoveToAvailClick
      end
    end
  end
  object dsSwipeCards: TDataSource
    DataSet = qrySwipeCards
    Left = 504
    Top = 200
  end
  object qrySwipeCards: TADOQuery
    Connection = dmADO_SwipeRange.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'isPromotional'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select * from ThemeSwipeCardRange'
      'where Promotional = :isPromotional')
    Left = 480
    Top = 208
    object qrySwipeCardsDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Description'
    end
    object qrySwipeCardsStartValue: TStringField
      DisplayLabel = 'Range start'
      DisplayWidth = 10
      FieldName = 'StartValue'
      Size = 50
    end
    object qrySwipeCardsEndValue: TStringField
      DisplayLabel = 'Range end'
      DisplayWidth = 10
      FieldName = 'EndValue'
      Size = 50
    end
    object qrySwipeCardsTrack: TSmallintField
      DisplayLabel = 'Card track'
      DisplayWidth = 10
      FieldName = 'Track'
    end
    object qrySwipeCardsSwipeCardrangeID: TLargeintField
      FieldName = 'SwipeCardrangeID'
      Visible = False
    end
    object qrySwipeCardsPromotional: TBooleanField
      FieldName = 'Promotional'
    end
    object qrySwipeCardsLoyalty: TBooleanField
      FieldName = 'Loyalty'
    end
    object qrySwipeCardsURL: TSmallintField
      FieldName = 'URL'
    end
  end
end
