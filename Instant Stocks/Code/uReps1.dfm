object fReps1: TfReps1
  Left = 705
  Top = 257
  HelpContext = 1007
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Single Stock Reports Menu'
  ClientHeight = 398
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 564
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object CloseBtn: TBitBtn
      Left = 183
      Top = 325
      Width = 213
      Height = 44
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Kind = bkCancel
    end
    object SPBtn: TBitBtn
      Left = 387
      Top = 14
      Width = 171
      Height = 40
      Caption = 'Sales && Profitability'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = SPBtnClick
    end
    object Panel1: TPanel
      Left = 3
      Top = 239
      Width = 371
      Height = 80
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object rgInv: TRadioGroup
        Left = 190
        Top = 3
        Width = 171
        Height = 69
        Caption = ' Order Delivery Notes By: '
        ItemIndex = 0
        Items.Strings = (
          'Date'
          'Supplier'
          'Note Number')
        TabOrder = 0
      end
      object BitBtn1: TBitBtn
        Left = 10
        Top = 15
        Width = 171
        Height = 40
        Caption = 'Delivery Notes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
    object GroupBox1: TGroupBox
      Left = 3
      Top = 155
      Width = 559
      Height = 77
      Caption = ' Summary Reports '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      TabOrder = 3
      object Bevel2: TBevel
        Left = 187
        Top = 13
        Width = 365
        Height = 53
        Shape = bsFrame
        Style = bsRaised
      end
      object RetSumBtn: TBitBtn
        Left = 192
        Top = 19
        Width = 170
        Height = 40
        Caption = 'Retail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = RetSumBtnClick
      end
      object TrSumBtn: TBitBtn
        Left = 10
        Top = 19
        Width = 171
        Height = 40
        Caption = 'Traditional'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = TrSumBtnClick
      end
      object RadioButton1: TRadioButton
        Left = 383
        Top = 22
        Width = 137
        Height = 17
        Caption = 'Show Cost Variance'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = True
      end
      object cbSPprof: TRadioButton
        Left = 383
        Top = 42
        Width = 137
        Height = 17
        Caption = 'Show Profit Variance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
    end
    object GroupBox2: TGroupBox
      Left = 3
      Top = 0
      Width = 376
      Height = 68
      TabOrder = 4
      object HoldBtn: TBitBtn
        Left = 10
        Top = 16
        Width = 171
        Height = 40
        Caption = 'Stock Holding'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = HoldBtnClick
      end
      object rbHold1: TRadioButton
        Left = 190
        Top = 28
        Width = 184
        Height = 17
        Caption = 'With Prepared Items Breakdown'
        TabOrder = 1
      end
      object rbHoldPo: TRadioButton
        Left = 190
        Top = 10
        Width = 184
        Height = 17
        Caption = 'Basic Version'
        Checked = True
        TabOrder = 2
        TabStop = True
      end
      object rbHold2: TRadioButton
        Left = 190
        Top = 46
        Width = 184
        Height = 17
        Caption = 'With Variance Cost/Value && Yield'
        TabOrder = 3
      end
    end
    object Bevel3: TGroupBox
      Left = 3
      Top = 71
      Width = 376
      Height = 79
      TabOrder = 5
      object btnLossGain: TBitBtn
        Left = 10
        Top = 21
        Width = 171
        Height = 40
        Caption = 'Loss Gain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnLossGainClick
      end
      object rbBoth: TRadioButton
        Left = 190
        Top = 43
        Width = 169
        Height = 17
        Caption = 'Show Both Cost and Value'
        TabOrder = 1
      end
      object rbPrice: TRadioButton
        Left = 190
        Top = 26
        Width = 169
        Height = 17
        Caption = 'Show Loss/Gain Value'
        TabOrder = 2
      end
      object rbCost: TRadioButton
        Left = 190
        Top = 9
        Width = 169
        Height = 17
        Caption = 'Show Loss/Gain at Cost'
        Checked = True
        TabOrder = 3
        TabStop = True
      end
      object rbHZsummary: TRadioButton
        Left = 190
        Top = 60
        Width = 169
        Height = 17
        Caption = 'Holding Zones Breakdown'
        TabOrder = 4
      end
    end
    object GroupBox3: TGroupBox
      Left = 382
      Top = 234
      Width = 180
      Height = 85
      TabOrder = 6
      object BitBtn2: TBitBtn
        Left = 4
        Top = 9
        Width = 171
        Height = 35
        Caption = 'Internal Transfers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn2Click
      end
      object rbSite: TRadioButton
        Left = 7
        Top = 48
        Width = 146
        Height = 17
        Caption = 'Group by Transfer ID'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbProds: TRadioButton
        Left = 7
        Top = 66
        Width = 170
        Height = 17
        Caption = 'By Product by Holding Zone'
        TabOrder = 2
      end
    end
    object cbDetail: TCheckBox
      Left = 392
      Top = 56
      Width = 161
      Height = 17
      Caption = 'Menu Choices Breakdown '
      TabOrder = 7
    end
  end
  object hzTabs: TPageControl
    Left = 0
    Top = 0
    Width = 564
    Height = 24
    ActivePage = hzTab0
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    Images = data1.hzTabsImgList
    ParentFont = False
    TabIndex = 0
    TabOrder = 1
    Visible = False
    OnChange = hzTabsChange
    object hzTab0: TTabSheet
      Caption = 'Complete Site'
      ImageIndex = -1
    end
  end
end
