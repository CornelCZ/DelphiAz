object EditJobSecurity: TEditJobSecurity
  Left = 728
  Top = 359
  Width = 264
  Height = 325
  HelpContext = 5026
  BorderWidth = 8
  Caption = 'Edit Button Security'
  Color = clBtnFace
  Constraints.MinHeight = 325
  Constraints.MinWidth = 264
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    232
    271)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 177
    Height = 13
    Caption = 'Roles which can access this function:'
  end
  object clbRoles: TCheckListBox
    Left = 0
    Top = 16
    Width = 233
    Height = 223
    OnClickCheck = clbRolesClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 25
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 131
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object qRun: TADOQuery
    CommandTimeout = 0
    Parameters = <>
    Left = 16
    Top = 32
  end
end
