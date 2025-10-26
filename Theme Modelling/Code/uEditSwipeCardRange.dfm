object frmEditSwipeCardRange: TfrmEditSwipeCardRange
  Left = 467
  Top = 200
  HelpContext = 5049
  BorderStyle = bsSingle
  Caption = 'Range Definition Entry'
  ClientHeight = 284
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    250
    284)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDescription: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Description:'
  end
  object lblRangeStart: TLabel
    Left = 8
    Top = 48
    Width = 61
    Height = 13
    Caption = 'Range start:'
  end
  object lblCardTrack: TLabel
    Left = 8
    Top = 128
    Width = 54
    Height = 13
    Caption = 'Card track:'
  end
  object lblRangeEnd: TLabel
    Left = 8
    Top = 88
    Width = 56
    Height = 13
    Caption = 'Range end:'
  end
  object cmbCardTrack: TComboBox
    Left = 8
    Top = 144
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'Track 1'
    Items.Strings = (
      'Track 1'
      'Track 2')
  end
  object edtDescription: TEdit
    Left = 8
    Top = 24
    Width = 233
    Height = 21
    MaxLength = 20
    TabOrder = 0
    Text = 'New Range'
  end
  object btOk: TButton
    Left = 88
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 168
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object edtRangeStart: TEdit
    Left = 8
    Top = 64
    Width = 169
    Height = 21
    MaxLength = 25
    TabOrder = 1
    OnChange = edtRangeStartChange
    OnEnter = edtRangeStartEnter
    OnKeyPress = edtRangeStartKeyPress
  end
  object edtRangeEnd: TEdit
    Left = 8
    Top = 104
    Width = 169
    Height = 21
    MaxLength = 25
    TabOrder = 2
    OnChange = edtRangeStartChange
    OnEnter = edtRangeStartEnter
    OnKeyPress = edtRangeStartKeyPress
  end
  object pnlLoyalty: TPanel
    Left = 8
    Top = 172
    Width = 239
    Height = 73
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      239
      73)
    object lblLoyaltyName: TLabel
      Left = 10
      Top = 20
      Width = 78
      Height = 13
      Caption = 'Loyalty Method:'
      Enabled = False
    end
    object bvlLoyalty: TBevel
      Left = 1
      Top = 10
      Width = 233
      Height = 57
      Anchors = [akLeft, akTop, akRight]
    end
    object cmbbxName: TComboBox
      Left = 10
      Top = 38
      Width = 217
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '<not set >'
      Items.Strings = (
        '<not set >')
    end
    object cbxLoyaltyCardRange: TCheckBox
      Left = 9
      Top = 2
      Width = 122
      Height = 17
      Action = actLoyalty
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object dsSwipeCardRange: TDataSource
    DataSet = qrySwipeCardRange
    Left = 216
    Top = 104
  end
  object qrySwipeCardRange: TADOQuery
    Connection = dmADO_SwipeRange.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeSwipeCardRange')
    Left = 216
    Top = 136
    object qrySwipeCardRangeDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Description'
    end
    object qrySwipeCardRangeStartValue: TStringField
      FieldName = 'StartValue'
      Size = 50
    end
    object qrySwipeCardRangeEndValue: TStringField
      FieldName = 'EndValue'
      Size = 50
    end
    object qrySwipeCardRangeTrack: TSmallintField
      DisplayWidth = 10
      FieldName = 'Track'
    end
    object qrySwipeCardRangeSwipeCardRangeID: TLargeintField
      FieldName = 'SwipeCardRangeID'
    end
    object qrySwipeCardRangePromotional: TBooleanField
      FieldName = 'Promotional'
    end
    object qrySwipeCardRangeLoyalty: TBooleanField
      FieldName = 'Loyalty'
    end
    object qrySwipeCardRangeURL: TSmallintField
      FieldName = 'URL'
    end
  end
  object qryThemeButtonURL: TADOQuery
    Connection = dmADO_SwipeRange.AztecConn
    Parameters = <>
    SQL.Strings = (
      
        'SELECT tb.Id, CASE WHEN tb.Deleted = 1 THEN tb.Name + '#39' - Remove' +
        'd'#39
      '                   ELSE tb.Name END as Name'
      '       FROM ThemeButtonUrl_Repl tb'
      '            INNER JOIN ac_Module m ON tb.ModuleId = m.Id'
      
        'WHERE m.SystemName = '#39'Loyalty'#39' /* Loyalty*/ AND tb.HideFromMenu ' +
        '= 1 AND tb.Deleted = 0             ')
    Left = 8
    Top = 248
  end
  object alSwipeCardRange: TActionList
    Left = 40
    Top = 248
    object actLoyalty: TAction
      AutoCheck = True
      Caption = 'Loyalty Card Range'
      OnExecute = actLoyaltyExecute
    end
  end
end
