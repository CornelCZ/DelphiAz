object PromotionList: TPromotionList
  Left = 570
  Top = 219
  Width = 965
  Height = 502
  HelpContext = 7001
  ActiveControl = dbgPromotions
  Caption = 'Promotions'
  Color = clBtnFace
  Constraints.MinHeight = 485
  Constraints.MinWidth = 950
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    949
    463)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 144
    Height = 13
    Caption = 'Currently defined promotions:'
  end
  object imCheck: TImage
    Left = 416
    Top = 4
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
  object lastBevel: TBevel
    Left = 855
    Top = 445
    Width = 2
    Height = 23
    Anchors = [akLeft, akBottom]
  end
  object Bevel2: TBevel
    Left = 458
    Top = 445
    Width = 2
    Height = 23
    Anchors = [akLeft, akBottom]
  end
  object cbHideDisabledPromotions: TCheckBox
    Left = 8
    Top = 406
    Width = 153
    Height = 17
    Action = ToggleHideDisabled
    Anchors = [akLeft, akBottom]
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 432
    Width = 957
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object btNew: TButton
    Left = 5
    Top = 445
    Width = 60
    Height = 23
    Action = CreateNew
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object btEdit: TButton
    Left = 70
    Top = 445
    Width = 60
    Height = 23
    Action = Edit
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object btImport: TButton
    Left = 330
    Top = 445
    Width = 60
    Height = 23
    Action = Export
    Anchors = [akLeft, akBottom]
    TabOrder = 8
  end
  object btExport: TButton
    Left = 395
    Top = 445
    Width = 60
    Height = 23
    Action = Import
    Anchors = [akLeft, akBottom]
    TabOrder = 9
  end
  object btReports: TButton
    Left = 592
    Top = 445
    Width = 60
    Height = 23
    Action = Reports
    Anchors = [akLeft, akBottom]
    TabOrder = 12
  end
  object btClose: TButton
    Left = 873
    Top = 445
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 13
    OnClick = btCloseClick
  end
  object btPriorities: TButton
    Left = 527
    Top = 445
    Width = 60
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Priorities'
    TabOrder = 11
    OnClick = btPrioritiesClick
  end
  object dbgPromotions: TwwDBGrid
    Left = 8
    Top = 20
    Width = 940
    Height = 375
    ControlType.Strings = (
      'EventOnly;CustomEdit;;F'
      'CreatedOnThisSite;CheckBox;True;False'
      'UserSelectsProducts;CustomEdit;;F')
    Selected.Strings = (
      'CreatedAt'#9'20'#9'Created By'#9#9
      'Name'#9'25'#9'Name'#9#9
      'Description'#9'50'#9'Description'#9#9
      'PromoTypeName'#9'11'#9'Type'#9#9
      'EventOnly'#9'8'#9'Evt. Only'#9#9
      'UserSelectsProducts'#9'4'#9'Deal'#9#9
      'PromotionStatusLookup'#9'10'#9'Status'#9#9
      'StartDate'#9'10'#9'Start Date'#9#9
      'EndDate'#9'10'#9'End Date'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmPromotions.dsPromotions
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 14
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    OnCalcCellColors = dbgPromotionsCalcCellColors
    OnTitleButtonClick = dbgPromotionsTitleButtonClick
    OnDrawDataCell = dbgPromotionsDrawDataCell
    OnDblClick = dbgPromotionsDblClick
  end
  object btSummary: TButton
    Left = 462
    Top = 445
    Width = 60
    Height = 23
    Action = ShowSummary
    Anchors = [akLeft, akBottom]
    TabOrder = 10
  end
  inline PromotionFilterFrame: TPromotionFilterFrame
    Left = 159
    Top = 402
    Width = 775
    Height = 29
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    inherited FilterPanel: TPanel
      Width = 775
      Align = alClient
      DesignSize = (
        775
        29)
      inherited Bevel2: TBevel
        Left = 541
      end
      inherited lblSiteFilter: TLabel
        Left = 549
        Width = 58
      end
      inherited edtFilter: TEdit
        Width = 344
      end
      inherited chkbxMidwordSearch: TCheckBox
        Left = 437
      end
      inherited cbxSiteFilter: TComboBox
        Left = 609
        Width = 163
      end
    end
  end
  object btnSwipeCardRange: TButton
    Left = 658
    Top = 445
    Width = 117
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Security Card Ranges'
    TabOrder = 15
    OnClick = btnSwipeCardRangeClick
  end
  object btnEQATECExceptionTest: TButton
    Left = 568
    Top = 3
    Width = 225
    Height = 19
    Caption = 'EQATEC Exception Test'
    TabOrder = 16
    Visible = False
  end
  object btnViewDeleted: TButton
    Left = 779
    Top = 445
    Width = 74
    Height = 23
    Hint = 'View and Restore Delete Promotions'
    Anchors = [akLeft, akBottom]
    Caption = 'View Deleted'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = btnViewDeletedClick
  end
  object btDelete: TButton
    Left = 135
    Top = 445
    Width = 60
    Height = 23
    Action = CopyPromotion
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object btEnable: TButton
    Left = 200
    Top = 445
    Width = 60
    Height = 23
    Action = EnableDisable
    Anchors = [akLeft, akBottom]
    TabOrder = 6
  end
  object btCopy: TButton
    Left = 265
    Top = 445
    Width = 60
    Height = 23
    Action = Delete
    Anchors = [akLeft, akBottom]
    TabOrder = 7
  end
  object PromotionActions: TActionList
    OnExecute = PromotionActionsExecute
    Left = 24
    Top = 72
    object ToggleHideDisabled: TAction
      Caption = 'Hide disabled promotions'
      OnExecute = ToggleHideDisabledExecute
    end
    object CreateNew: TAction
      Caption = 'New'
      OnExecute = CreateNewExecute
    end
    object Edit: TAction
      Caption = 'Edit'
      OnExecute = EditExecute
      OnUpdate = EditUpdate
    end
    object CopyPromotion: TAction
      Caption = 'Copy'
      OnExecute = CopyPromotionExecute
      OnUpdate = CopyPromotionUpdate
    end
    object EnableDisable: TAction
      Caption = 'Enable'
      OnExecute = EnableDisableExecute
      OnUpdate = EnableDisableUpdate
    end
    object Delete: TAction
      Caption = 'Delete'
      OnExecute = DeleteExecute
      OnUpdate = DeleteUpdate
    end
    object Export: TAction
      Caption = 'Export'
      OnExecute = ExportExecute
      OnUpdate = ExportUpdate
    end
    object Import: TAction
      Caption = 'Import'
      OnExecute = ImportExecute
      OnUpdate = ImportUpdate
    end
    object ShowSummary: TAction
      Caption = 'Summary'
      OnExecute = ShowSummaryExecute
    end
    object SetPromotionOrder: TAction
      Caption = 'Priorities'
    end
    object Reports: TAction
      Caption = 'Reports'
      OnExecute = ReportsExecute
    end
  end
end
