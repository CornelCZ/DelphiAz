inherited frmAddEditConquerorTerminal: TfrmAddEditConquerorTerminal
  Left = 671
  Top = 424
  Caption = 'Conqueror Terminal'
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    object lblName: TLabel
      Left = 16
      Top = 24
      Width = 34
      Height = 13
      Caption = 'Name :'
    end
    object Label2: TLabel
      Left = 277
      Top = 26
      Width = 4
      Height = 13
      Caption = '*'
    end
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 74
      Height = 13
      Caption = 'Terminal Name:'
    end
    object Label3: TLabel
      Left = 277
      Top = 50
      Width = 4
      Height = 13
      Caption = '*'
    end
    object Label4: TLabel
      Left = 16
      Top = 72
      Width = 51
      Height = 13
      Caption = 'Device ID:'
    end
    object Label5: TLabel
      Left = 277
      Top = 74
      Width = 4
      Height = 13
      Caption = '*'
    end
    object Label6: TLabel
      Left = 16
      Top = 96
      Width = 103
      Height = 13
      Caption = 'Conqueror Device ID:'
    end
    object Label7: TLabel
      Left = 277
      Top = 98
      Width = 4
      Height = 13
      Caption = '*'
    end
    object Label8: TLabel
      Left = 16
      Top = 120
      Width = 76
      Height = 13
      Caption = 'Hardware Type:'
    end
    object Label9: TLabel
      Left = 277
      Top = 121
      Width = 4
      Height = 13
      Caption = '*'
    end
    object DBEdtName: TDBEdit
      Left = 152
      Top = 20
      Width = 121
      Height = 21
      Hint = 
        'Please note that terminal/server names may not contain '#39'/'#39','#39':'#39','#39 +
        '?'#39','#39'"'#39','#39'<'#39', '#39'>'#39' or '#39'|'#39'.'
      DataField = 'Name'
      DataSource = dsEditRec
      MaxLength = 20
      TabOrder = 0
    end
    object dbeditEPoSDeviceID: TDBEdit
      Left = 152
      Top = 68
      Width = 121
      Height = 21
      Hint = 
        'Please note that terminal/server names may not contain '#39'/'#39','#39':'#39','#39 +
        '?'#39','#39'"'#39','#39'<'#39', '#39'>'#39' or '#39'|'#39'.'
      DataField = 'EPoSDeviceID'
      DataSource = dsEditRec
      MaxLength = 20
      TabOrder = 1
    end
    object cmbbxHardwareType: TwwDBComboBox
      Left = 152
      Top = 116
      Width = 121
      Height = 21
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'HardwareType'
      DataSource = dsEditRec
      DropDownCount = 8
      DropDownWidth = 121
      Enabled = False
      ItemHeight = 0
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object editbxConquerorDeviceID: TMemo
      Left = 152
      Top = 93
      Width = 121
      Height = 21
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 3
      OnKeyPress = editbxConquerorDeviceIDKeyPress
    end
    object dbcmbTerminalName: TwwDBLookupCombo
      Left = 152
      Top = 44
      Width = 121
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'POS Name'#9'50'#9'POS Name'#9#9)
      DataField = 'POSCode'
      DataSource = dsEditRec
      LookupTable = dmADO.qGetPoses
      LookupField = 'Pos code'
      Style = csDropDownList
      DropDownWidth = 121
      TabOrder = 4
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  inherited dsEditRec: TDataSource
    Left = 160
    Top = 192
  end
  inherited ImageList1: TImageList
    Left = 192
    Top = 192
  end
end
