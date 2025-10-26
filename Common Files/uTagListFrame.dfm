object TagListFrame: TTagListFrame
  Left = 0
  Top = 0
  Width = 614
  Height = 240
  TabOrder = 0
  DesignSize = (
    614
    240)
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 345
    Height = 240
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWindow
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object grpBoxTagFilter: TGroupBox
    Left = 365
    Top = 0
    Width = 243
    Height = 240
    Caption = 'Tag Filter'
    TabOrder = 1
    object lblGroup: TLabel
      Left = 8
      Top = 76
      Width = 29
      Height = 13
      Caption = 'Group'
    end
    object lblSubGroup: TLabel
      Left = 8
      Top = 109
      Width = 51
      Height = 13
      Caption = 'Sub-Group'
    end
    object lblSubSection: TLabel
      Left = 8
      Top = 176
      Width = 58
      Height = 13
      Caption = 'Sub-Section'
    end
    object lblSection: TLabel
      Left = 8
      Top = 142
      Width = 36
      Height = 13
      Caption = 'Section'
    end
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 223
      Height = 26
      Caption = 
        'Use this section to restrict the list of tags shown on the left ' +
        'hand side.'
      WordWrap = True
    end
    object cmbbxTagGroup: TComboBox
      Left = 73
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbbxTagGroupChange
    end
    object cmbbxTagSubGroup: TComboBox
      Left = 73
      Top = 105
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cmbbxTagSubGroupChange
    end
    object cmbbxTagSection: TComboBox
      Left = 73
      Top = 138
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cmbbxTagSectionChange
    end
    object cmbbxTagSubSection: TComboBox
      Left = 73
      Top = 172
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = cmbbxTagSubSectionChange
    end
    object chkboxFiltered: TCheckBox
      Left = 152
      Top = 209
      Width = 63
      Height = 17
      Hint = 'Enable/Disable the filter settings'
      Alignment = taLeftJustify
      Caption = 'Filtered'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = chkboxFilteredClick
    end
  end
  object adoqTags: TADOQuery
    Parameters = <
      item
        Name = 'Context'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'declare @context varchar(20), @stmt varchar(1000), @contextclaus' +
        'e varchar(100)'
      'set @context = :Context'
      ''
      'if @context = '#39'site'#39
      '  set @contextclause = '#39'where t.IsLocationTag = 1'#39
      'else if @context = '#39'Product'#39
      '  set @contextclause = '#39'where t.IsProductTag = 1'#39
      ''
      
        'set @stmt = '#39'select distinct Coalesce(t2.id, t.id) as parent, ca' +
        'se when t.ParentTagId is not null then t.id else null end as chi' +
        'ld,'
      
        'Coalesce(t2.name,t.name) as ParentName, case when t.ParentTagId ' +
        'is not null then t.Name else null end as ChildName'
      'from ac_Tag t'
      'left join ac_Tag t2'
      
        'on t.ParentTagId = t2.Id '#39' + @contextclause + '#39' and ((t.TagType ' +
        '= 1) or ((t.TagType = 2) and (t.ParentTagId is not null))) order' +
        ' by ParentName, ChildName asc'#39
      ''
      'exec(@stmt)'
      '')
    Left = 8
    Top = 8
  end
  object adoc: TADOCommand
    Parameters = <>
    Left = 40
    Top = 40
  end
  object adoq: TADODataSet
    ParamCheck = False
    Parameters = <>
    Left = 8
    Top = 40
  end
end
