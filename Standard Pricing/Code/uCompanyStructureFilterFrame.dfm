object CompanyStructureFilterFrame: TCompanyStructureFilterFrame
  Left = 0
  Top = 0
  Width = 327
  Height = 124
  TabOrder = 0
  OnEnter = FrameEnter
  object lblSite: TLabel
    Left = 2
    Top = 44
    Width = 18
    Height = 13
    Caption = 'Site'
  end
  object lblSalesArea: TLabel
    Left = 175
    Top = 44
    Width = 51
    Height = 13
    Caption = 'Sales Area'
  end
  object lblCompany: TLabel
    Left = 0
    Top = 4
    Width = 44
    Height = 13
    Caption = 'Company'
  end
  object lblArea: TLabel
    Left = 176
    Top = 4
    Width = 22
    Height = 13
    Caption = 'Area'
  end
  object lblSiteRef: TLabel
    Left = 2
    Top = 84
    Width = 71
    Height = 13
    Caption = 'Site Reference'
  end
  object CbSite: TComboBox
    Left = 0
    Top = 60
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = CbSiteChange
  end
  object CbSalesArea: TComboBox
    Left = 175
    Top = 60
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object CbCompany: TComboBox
    Left = 0
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = CbCompanyChange
  end
  object CbArea: TComboBox
    Left = 176
    Top = 20
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = CbAreaChange
  end
  object pnlSiteTag: TPanel
    Left = 174
    Top = 88
    Width = 145
    Height = 33
    BevelOuter = bvNone
    TabOrder = 4
    object chkbxFilterBySiteTag: TCheckBox
      Left = 0
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Filter by site tag'
      TabOrder = 0
      OnClick = chkbxFilterBySiteTagClick
    end
    object btnSiteTags: TButton
      Left = 104
      Top = 4
      Width = 40
      Height = 25
      Caption = 'Tags'
      Enabled = False
      TabOrder = 1
      OnClick = btnSiteTagsClick
    end
  end
  object CbSiteRef: TComboBox
    Left = 0
    Top = 100
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnChange = CbSiteRefChange
  end
end
