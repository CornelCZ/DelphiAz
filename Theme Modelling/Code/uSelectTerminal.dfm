object SelectTerminalForm: TSelectTerminalForm
  Left = 539
  Top = 174
  Width = 338
  Height = 322
  HelpContext = 5068
  Caption = 'Select terminal'
  Color = clBtnFace
  Constraints.MinHeight = 322
  Constraints.MinWidth = 338
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    330
    295)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 132
    Height = 13
    Caption = 'Select terminal for preview:'
  end
  object tvSelectTerminal: TTreeView
    Left = 8
    Top = 24
    Width = 315
    Height = 233
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    TabOrder = 0
  end
  object Button1: TButton
    Left = 168
    Top = 264
    Width = 75
    Height = 25
    Action = Ok
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 1
  end
  object Button2: TButton
    Left = 248
    Top = 264
    Width = 75
    Height = 25
    Action = Close
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 2
  end
  object qFetchTreeData: TADOQuery
    Connection = dmThemeData.AztecConn
    Parameters = <>
    SQL.Strings = (
      'declare @PanelDesignID int'
      'set @PanelDesignID = 113'
      ''
      'if OBJECT_ID(''tempdb..##SelectTerminal_Names'') is not null'
      '  drop table ##SelectTerminal_Names'
      'if OBJECT_ID(''tempdb..##SelectTerminal_Data'') is not null'
      '  drop table ##SelectTerminal_Data'
      ''
      'create table ##SelectTerminal_Names'
      '('
      '  ID int identity(1,1),'
      '  Name varchar(50)'
      ')'
      ''
      '-- deleted flag ignored here for speed, should only contribute'
      '-- a small percentage of unused names'
      'insert ##SelectTerminal_Names select Name'
      'from ('
      'select [company name] as Name from config'
      'union'
      'select [area name] as Name from config'
      'union '
      'select [site name] as Name from config'
      'union'
      'select [sales area name] as Name from config'
      'union '
      'select [pos name] as name from config'
      
        'where [pos code] not in (select PosCode from ThemeEposDevice whe' +
        're HardwareType in (10, 11, 12, 13, 14))'
      ') a'
      'order by Name'
      ''
      'create table ##SelectTerminal_data'
      '('
      '  Level1ID int,'
      '  Level2ID int,'
      '  Level3ID int,'
      '  Level4ID int,'
      '  Level5ID int,'
      '  Level1Name int,'
      '  Level2Name int,'
      '  Level3Name int,'
      '  Level4Name int,'
      '  Level5Name int,'
      '  primary key (Level1ID, Level2ID, Level3ID, Level4ID, Level5ID)'
      ')'
      ''
      'insert ##SelectTerminal_Data'
      'select '
      '  [company code] as Level1ID,'
      '  [area code] as Level2ID,'
      '  [site code] as Level3ID,'
      '  [sales area code] as Level4ID,'
      '  cast([POS Code] as integer) as Level5ID,'
      '  companyname.ID as Level1Name,'
      '  areaname.ID as Level2Name,'
      '  sitename.ID as Level3Name,'
      '  salesareaname.ID as Level4Name,'
      '  posname.ID as Level5Name'
      'from config'
      
        'join ##SelectTerminal_Names companyname on [company name] = comp' +
        'anyname.Name'
      
        'join ##SelectTerminal_Names areaname on [area name] = areaname.N' +
        'ame'
      
        'join ##SelectTerminal_Names sitename on [site name] = sitename.N' +
        'ame'
      
        'join ##SelectTerminal_Names salesareaname on [sales area name] =' +
        ' salesareaname.Name'
      'join ##SelectTerminal_Names posname on [pos name] = posname.Name'
      'join ThemeEposDesign a on [POS Code] = a.POSCode'
      'join ThemeEposDevice b on b.POSCode = a.POSCode'
      'where ([Deleted] is null or [Deleted] = ''N'')'
      '  and [company code] is not null'
      '  and [area code] is not null'
      '  and [site code] is not null'
      '  and [sales area code] is not null'
      '  and [pos code] is not null'
      '  and a.PanelDesignID = @PanelDesignID'
      
        '  and [pos code] not in (select PosCode from ThemeEposDevice whe' +
        're HardwareType in (10, 11, 12, 13, 14))'
      
        'order by [company name], [area name], [site name], [sales area n' +
        'ame], [pos name]'
      ''
      '')
    Left = 288
    Top = 40
  end
  object ActionList1: TActionList
    Left = 288
    Top = 72
    object Ok: TAction
      Caption = 'Ok'
      OnExecute = OkExecute
      OnUpdate = OkUpdate
    end
    object Close: TAction
      Caption = 'Close'
      OnExecute = CloseExecute
    end
  end
end
