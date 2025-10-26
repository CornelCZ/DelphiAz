object fPriorityTemplates: TfPriorityTemplates
  Left = 650
  Top = 242
  Width = 496
  Height = 320
  Caption = 'Promotion Priority Templates'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    480
    281)
  PixelsPerInch = 96
  TextHeight = 13
  object btnNew: TButton
    Left = 384
    Top = 8
    Width = 91
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'New Template'
    TabOrder = 1
    OnClick = btnNewClick
  end
  object btnEdit: TButton
    Left = 384
    Top = 40
    Width = 91
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Edit Template'
    TabOrder = 2
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 384
    Top = 72
    Width = 91
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete Template'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnSiteTemplates: TButton
    Left = 384
    Top = 216
    Width = 91
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Site Templates'
    TabOrder = 4
    OnClick = btnSiteTemplatesClick
  end
  object btnClose: TButton
    Left = 384
    Top = 248
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 5
  end
  object dbgPriorityTemplates: TDBGrid
    Left = 8
    Top = 8
    Width = 369
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmPromotions.dsPromotionPriorityTemplate
    Options = [dgRowSelect, dgMultiSelect]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyUp = dbgPriorityTemplatesKeyUp
    OnMouseUp = dbgPriorityTemplatesMouseUp
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 365
        Visible = True
      end>
  end
end
