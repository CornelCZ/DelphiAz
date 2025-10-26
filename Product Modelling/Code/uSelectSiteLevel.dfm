object SelectLevelForm: TSelectLevelForm
  Left = 418
  Top = 307
  Width = 381
  Height = 229
  ActiveControl = ListBox
  Caption = 'Select Site Level'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    373
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object CompanyLabel: TLabel
    Left = 8
    Top = 71
    Width = 57
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Company:'
  end
  object AreaLabel: TLabel
    Left = 8
    Top = 95
    Width = 57
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Area:'
  end
  object SiteLabel: TLabel
    Left = 8
    Top = 119
    Width = 57
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Site:'
  end
  object CompanySelLabel: TLabel
    Left = 72
    Top = 71
    Width = 100
    Height = 13
    AutoSize = False
  end
  object AreaSelLabel: TLabel
    Left = 72
    Top = 95
    Width = 100
    Height = 13
    AutoSize = False
  end
  object SiteSelLabel: TLabel
    Left = 72
    Top = 119
    Width = 100
    Height = 13
    AutoSize = False
  end
  object PromptLabel: TLabel
    Left = 9
    Top = 10
    Width = 169
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'PromptLabel'
  end
  object SearchLabel: TLabel
    Left = 188
    Top = 158
    Width = 181
    Height = 13
    AutoSize = False
    Caption = 'SearchLabel'
  end
  object Button1: TButton
    Left = 184
    Top = 175
    Width = 75
    Height = 25
    Action = BackAction
    Anchors = [akLeft, akBottom]
    Cancel = True
    TabOrder = 0
  end
  object Button2: TButton
    Left = 294
    Top = 175
    Width = 75
    Height = 25
    Action = NextAction
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object ListBox: TListBox
    Left = 184
    Top = 8
    Width = 185
    Height = 145
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 2
    OnDblClick = ListBoxDblClick
    OnExit = ListBoxExit
    OnKeyDown = ListBoxKeyDown
    OnKeyPress = ListBoxKeyPress
    OnMouseDown = ListBoxMouseDown
  end
  object ActionList1: TActionList
    Left = 136
    Top = 36
    object BackAction: TAction
      Caption = '<< Back'
      OnExecute = BackActionExecute
    end
    object NextAction: TAction
      Caption = 'Next >>'
      OnExecute = NextActionExecute
      OnUpdate = NextActionUpdate
    end
  end
  object ConfigTable: TADODataSet
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandText = 
      'SELECT DISTINCT [Company Code], [Area Code], [Site Code], [Sales' +
      ' Area Code],  [Company Name], [Area Name], [Site Name]'#13#10'FROM Con' +
      'fig'#13#10'WHERE ([Site Code] IS NOT NULL) AND (Deleted <> '#39'Y'#39' OR Dele' +
      'ted IS NULL)'
    Parameters = <>
    Left = 104
    Top = 37
    object ConfigTableCompanyCode: TSmallintField
      FieldName = 'Company Code'
    end
    object ConfigTableAreaCode: TSmallintField
      FieldName = 'Area Code'
    end
    object ConfigTableSiteCode: TSmallintField
      FieldName = 'Site Code'
    end
    object ConfigTableSalesAreaCode: TSmallintField
      FieldName = 'Sales Area Code'
    end
    object ConfigTableCompanyName: TStringField
      FieldName = 'Company Name'
    end
    object ConfigTableAreaName: TStringField
      FieldName = 'Area Name'
    end
    object ConfigTableSiteName: TStringField
      FieldName = 'Site Name'
    end
  end
  object qryConfig: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 8
    Top = 37
  end
end
