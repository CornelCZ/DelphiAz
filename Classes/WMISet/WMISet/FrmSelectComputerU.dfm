object FrmSelectComputer: TFrmSelectComputer
  Left = 288
  Top = 132
  Width = 330
  Height = 437
  Caption = 'Select target computer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 322
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblSelectDomain: TLabel
      Left = 10
      Top = 10
      Width = 86
      Height = 16
      Caption = 'Select domain'
    end
    object cmbDomains: TComboBox
      Left = 108
      Top = 6
      Width = 208
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = cmbDomainsChange
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 363
    Width = 322
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlButtons: TPanel
      Left = 103
      Top = 0
      Width = 219
      Height = 42
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOk: TButton
        Left = 9
        Top = 5
        Width = 92
        Height = 31
        Caption = 'Ok'
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 117
        Top = 4
        Width = 92
        Height = 30
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object pnlResult: TPanel
    Left = 0
    Top = 323
    Width = 322
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lblSelectedComputer: TLabel
      Left = 10
      Top = 10
      Width = 115
      Height = 16
      Caption = 'Selected Computer'
    end
    object edtSelectedComputer: TEdit
      Left = 138
      Top = 5
      Width = 178
      Height = 24
      TabOrder = 0
    end
  end
  object lbxComputers: TListBox
    Left = 0
    Top = 41
    Width = 322
    Height = 282
    Align = alClient
    ItemHeight = 16
    TabOrder = 3
    OnClick = lbxComputersClick
  end
  object WmiProcessControl1: TWmiProcessControl
    Active = False
    StartupInfo.CreateFlags = 0
    StartupInfo.ErrorMode = 0
    StartupInfo.FillAttribute = 0
    Left = 32
    Top = 128
  end
end
