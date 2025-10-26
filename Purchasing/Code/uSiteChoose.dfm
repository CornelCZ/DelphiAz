object fSiteChoose: TfSiteChoose
  Left = 499
  Top = 286
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Clock Times Review'
  ClientHeight = 136
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 102
    Height = 16
    Caption = 'Choose a Site:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lookSites: TwwDBLookupCombo
    Left = 8
    Top = 34
    Width = 217
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'site name'#9'20'#9'site name'#9#9)
    LookupTable = wwqSites
    LookupField = 'Site Code'
    Style = csDropDownList
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = lookSitesCloseUp
  end
  object BitBtn1: TBitBtn
    Left = 4
    Top = 89
    Width = 108
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 122
    Top = 89
    Width = 108
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Kind = bkCancel
  end
  object AllSitesCheckBox: TCheckBox
    Left = 8
    Top = 64
    Width = 65
    Height = 17
    Caption = 'All Sites'
    TabOrder = 3
    OnClick = AllSitesCheckBoxClick
  end
  object wwqSites: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select distinct a.[Site Code], a.[site name]'
      'from Config a, PurSysVar b'
      'where a.[site code] = b.SiteCode '
      '  and a.Deleted is null')
    Left = 104
    Top = 56
  end
end
