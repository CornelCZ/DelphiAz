object ViewMOATerminal: TViewMOATerminal
  Left = 507
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 10
  Caption = 'Mobile Remote Ordering Terminal Configuration'
  ClientHeight = 177
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 383
    Height = 148
    Align = alClient
    TabOrder = 0
    object lblStarDesc: TLabel
      Left = 278
      Top = 127
      Width = 3
      Height = 13
      Visible = False
    end
    object lblSalesArea: TLabel
      Left = 16
      Top = 24
      Width = 55
      Height = 13
      Caption = 'Sales Area:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
    end
    object lblNumTerminals: TLabel
      Left = 16
      Top = 60
      Width = 108
      Height = 13
      Caption = 'No. of MOA Terminals:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
    end
    object lblMOAEmployee: TLabel
      Left = 16
      Top = 96
      Width = 76
      Height = 13
      Caption = 'MOA Employee:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
    end
    object edSalesArea: TEdit
      Left = 140
      Top = 20
      Width = 173
      Height = 21
      TabStop = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edMOACount: TEdit
      Left = 140
      Top = 56
      Width = 53
      Height = 21
      TabStop = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edMOAUser: TEdit
      Left = 140
      Top = 92
      Width = 221
      Height = 21
      TabStop = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 148
    Width = 383
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOK: TButton
      Left = 307
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
  end
end
