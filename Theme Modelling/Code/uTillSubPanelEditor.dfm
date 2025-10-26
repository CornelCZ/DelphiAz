object TillSubPanelEditor: TTillSubPanelEditor
  Left = 606
  Top = 105
  BorderStyle = bsSingle
  Caption = 'Edit Site Panel'
  ClientHeight = 391
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label3: TLabel
    Left = 8
    Top = 176
    Width = 81
    Height = 13
    Caption = 'Allowed buttons:'
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 281
    Height = 21
    TabOrder = 0
    Text = 'edName'
  end
  object mmDesc: TMemo
    Left = 8
    Top = 72
    Width = 281
    Height = 57
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object cbSiteSetAppearance: TCheckBox
    Left = 8
    Top = 136
    Width = 193
    Height = 17
    Caption = 'Site can set button properties'
    TabOrder = 2
  end
  object cbSiteSetSecurity: TCheckBox
    Left = 8
    Top = 152
    Width = 201
    Height = 17
    Caption = 'Site can set button security'
    Enabled = False
    TabOrder = 3
    Visible = False
  end
  object dbcgSubPanelButtons: TDBCtrlGrid
    Left = 8
    Top = 192
    Width = 297
    Height = 162
    AllowInsert = False
    ColCount = 4
    DataSource = DataSource1
    PanelHeight = 54
    PanelWidth = 70
    TabOrder = 4
    RowCount = 3
    OnDragDrop = dbcgSubPanelButtonsDragDrop
    OnDragOver = dbcgSubPanelButtonsDragOver
    OnMouseDown = HandleButtonMouseDown
    object Tillbutton1: TTillbutton
      Left = 3
      Top = 3
      Width = 64
      Height = 48
      Datasource = DataSource1
      upd = True
      AllowDrag = False
      showhint = True
      OnDragDrop = dbcgSubPanelButtonsDragDrop
      OnDragOver = dbcgSubPanelButtonsDragOver
      OnMouseDown = HandleButtonMouseDown
      OnDblClick = Tillbutton1DblClick
    end
  end
  object btOk: TButton
    Left = 152
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 5
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 232
    Top = 360
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object qGetSubPanelButtons: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 88
    Top = 232
  end
  object DataSource1: TDataSource
    DataSet = qEditSubPanelButtons
    Left = 120
    Top = 232
  end
  object qEditSubPanelButtons: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from #editsubpanelbuttons')
    Left = 120
    Top = 200
  end
  object qDelSubPanelTmp: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'if object_id('#39'tempdb..#editsubpanelbuttons'#39') is not null drop ta' +
        'ble #editsubpanelbuttons')
    Left = 88
    Top = 200
  end
  object qSaveSubPanelButtons: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'drop table #editsubpanelbuttons')
    Left = 152
    Top = 200
  end
end
