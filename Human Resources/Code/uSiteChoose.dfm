object fSiteChoose: TfSiteChoose
  Left = 409
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Clock Times Review'
  ClientHeight = 116
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
    Top = 72
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
    Top = 72
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
  object wwqSites: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select distinct a."Site Code", a."site name"'
      ''
      'from "SiteAztec" a, "sysvar" b'
      ''
      'where a."site code" = b."sitecode" '
      '  and a."deleted" is null'
      'order by a."site name"')
    Left = 104
    Top = 56
  end
end
