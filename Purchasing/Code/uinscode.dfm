object frmInsCodeCateg: TfrmInsCodeCateg
  Left = 662
  Top = 305
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Insert Coded Category'
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
  object CatLbl: TLabel
    Left = 32
    Top = 40
    Width = 73
    Height = 13
    Caption = 'Category Name'
  end
  object CodeLbl: TLabel
    Left = 32
    Top = 126
    Width = 60
    Height = 13
    Caption = 'Report Code'
  end
  object CodeHint: TLabel
    Left = 32
    Top = 142
    Width = 81
    Height = 13
    Caption = '2 characters max'
  end
  object Label1: TLabel
    Left = 176
    Top = 40
    Width = 78
    Height = 13
    Caption = 'Select Category:'
  end
  object OKBtn: TButton
    Left = 55
    Top = 223
    Width = 75
    Height = 22
    Hint = 'Accept and insert the selected item.'
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
  object CodeCatListBox: TListBox
    Left = 176
    Top = 56
    Width = 121
    Height = 121
    Hint = 'Click the category to add.'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = CodeCatListBoxClick
  end
  object CategoryEdit: TEdit
    Left = 32
    Top = 56
    Width = 121
    Height = 21
    Hint = 
      'This is the category that will be added to the report under '#39'Oth' +
      'ers Coded'#39'.'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object ReportCodeEdit: TEdit
    Left = 32
    Top = 156
    Width = 121
    Height = 21
    Hint = 'Enter a 2 character code to use for this category.'
    CharCase = ecUpperCase
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 248
    Width = 330
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
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
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object QGetCodeCatNames: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT  b."sub-category name" AS "Category Name"'
      ''
      'FROM "subcateg" b,'
      '           "entity"   c'
      ''
      'WHERE   c."sub-category name" = b."sub-category name"'
      'AND b."sub-category name" NOT IN   (SELECT x."category name"'
      #9#9'                      FROM "FixCats" x)'
      'AND b."sub-category name" NOT IN   (SELECT y."category name"'
      #9#9#9'      FROM "codeCats" y)')
    Left = 16
    Top = 96
  end
end
