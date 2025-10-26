object InsertFixCatDlg: TInsertFixCatDlg
  Left = 501
  Top = 326
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Insert Report Category'
  ClientHeight = 283
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 313
    Height = 201
    Shape = bsFrame
  end
  object CatNameLbl: TLabel
    Left = 32
    Top = 40
    Width = 76
    Height = 13
    Caption = 'Category Name:'
  end
  object RepNameLbl: TLabel
    Left = 32
    Top = 124
    Width = 66
    Height = 13
    Caption = 'Report Name:'
  end
  object Label1: TLabel
    Left = 176
    Top = 40
    Width = 78
    Height = 13
    Caption = 'Select Category:'
  end
  object RepnameInfoLbl: TLabel
    Left = 32
    Top = 140
    Width = 87
    Height = 13
    Caption = '10 characters max'
  end
  object OKBtn: TButton
    Left = 55
    Top = 220
    Width = 75
    Height = 25
    Hint = 'Accept and insert the selected item'
    Caption = 'OK'
    Default = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 183
    Top = 220
    Width = 75
    Height = 25
    Hint = 'Cancel the current operation'
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object FixCatListBox: TListBox
    Left = 176
    Top = 56
    Width = 121
    Height = 121
    Hint = 'Click on the category to add.'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 3
    OnClick = FixCatListBoxClick
  end
  object CatnameEdit: TEdit
    Left = 32
    Top = 56
    Width = 121
    Height = 21
    Hint = 'This is used as the default '#39'Report Name'#39
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 4
  end
  object RepNameEdit: TEdit
    Left = 32
    Top = 156
    Width = 121
    Height = 21
    Hint = 'Enter a display name to use on the report or use the default'
    MaxLength = 10
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = RepNameEditChange
  end
  object Panel1: TPanel
    Left = 0
    Top = 248
    Width = 330
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 5
    object HintLbl: TLabel
      Left = 2
      Top = 2
      Width = 326
      Height = 31
      Align = alClient
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object QGetFixedCatNames: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT  b."sub-category name" AS "Category Name"'
      ''
      'FROM "subcateg" b,'
      #9'  "entity"   c'
      ''
      'WHERE   c.[sub-category name] = b.[sub-category name]'
      'AND     b.[sub-category name] NOT IN '
      #9#9'  (SELECT x.[category name]'
      #9#9#9'FROM "FixCats" x)'
      'AND b.[sub-category name] NOT IN '
      #9#9#9'(SELECT y.[category name]'
      #9#9#9' FROM "codeCats" y)')
    Left = 40
    Top = 80
  end
end
