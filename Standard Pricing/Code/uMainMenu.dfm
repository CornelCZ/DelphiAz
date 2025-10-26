object fmainmenu: Tfmainmenu
  Left = 272
  Top = 192
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Main Menu'
  ClientHeight = 448
  ClientWidth = 656
  Color = clBtnFace
  Constraints.MaxHeight = 486
  Constraints.MaxWidth = 672
  Constraints.MinHeight = 475
  Constraints.MinWidth = 664
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 617
    Height = 35
    Alignment = taCenter
    AutoSize = False
    Caption = 'Aztec Standard Pricing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object btnExit: TBitBtn
    Left = 347
    Top = 336
    Width = 294
    Height = 97
    Caption = 'E&XIT PROGRAM'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnExitClick
  end
  object btnSABands: TButton
    Left = 11
    Top = 208
    Width = 294
    Height = 97
    Caption = 'Sales Area &Bandings'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnSABandsClick
  end
  object btnPriceMatrix: TButton
    Left = 11
    Top = 80
    Width = 294
    Height = 97
    Caption = 'Price &Matrix'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnPriceMatrixClick
  end
  object btnSupplementBands: TBitBtn
    Left = 347
    Top = 208
    Width = 294
    Height = 97
    Caption = '&Supplement Bandings'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnSupplementBandsClick
  end
  object btnSiteMatrix: TBitBtn
    Left = 347
    Top = 80
    Width = 294
    Height = 97
    Caption = 'S&ite Matrix'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnSiteMatrixClick
  end
  object btnOffBandPricing: TButton
    Left = 11
    Top = 336
    Width = 294
    Height = 97
    Caption = '&Off-Band Pricing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnOffBandPricingClick
  end
  object btnEQATECExceptionTest: TButton
    Left = 8
    Top = 48
    Width = 625
    Height = 25
    Caption = 'EQATEC Exception Test'
    TabOrder = 6
    Visible = False
    OnClick = btnEQATECExceptionTestClick
  end
  object CheckInactiveTimer: TTimer
    Enabled = False
    OnTimer = CheckInactiveTimerTimer
    Left = 8
    Top = 8
  end
  object AppEvent: TApplicationEvents
    OnMessage = AppEventMessage
    Left = 40
    Top = 8
  end
  object wwqGeneral: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 72
    Top = 8
  end
  object spSetFutureToCurrent: TADOStoredProc
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    ProcedureName = 'spFutureToCurrent;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = 'CurrDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = 'TableName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end>
    Left = 104
    Top = 8
  end
  object spSetFutureToCurrentMatrix: TADOStoredProc
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    ProcedureName = 'spFutureToCurrentMatrix;1'
    Parameters = <
      item
        Name = 'CurrDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end>
    Left = 136
    Top = 8
  end
end
