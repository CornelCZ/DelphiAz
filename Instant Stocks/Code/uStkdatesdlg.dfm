object fStkDatesDlg: TfStkDatesDlg
  Left = 661
  Top = 188
  HelpContext = 1010
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'New Stock Setup - Step 2'
  ClientHeight = 313
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 3
    Top = 169
    Width = 369
    Height = 67
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 5
    Top = 134
    Width = 63
    Height = 13
    Caption = 'Start Date:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 258
    Top = 134
    Width = 58
    Height = 13
    Caption = 'End Date:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 303
    Top = 172
    Width = 58
    Height = 13
    Caption = 'End Time:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SiteLbl: TLabel
    Left = 74
    Top = 25
    Width = 50
    Height = 18
    Caption = 'SiteLbl'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = -49
    Top = 45
    Width = 428
    Height = 2
  end
  object Label4: TLabel
    Left = 8
    Top = 25
    Width = 55
    Height = 18
    Caption = 'Thread:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 2
    Top = 4
    Width = 62
    Height = 18
    Caption = 'Division:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DivLbl: TLabel
    Left = 74
    Top = 4
    Width = 46
    Height = 18
    Caption = 'DivLbl'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 0
    Top = 49
    Width = 381
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Minimum End Date: 22/22/2222 (Start Date + 1)'#13#10'Maximum End Date:' +
      ' 22/22/2222 (Last Audit Date - 2)'
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 0
    Top = 77
    Width = 381
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Max Date/Time for Part Day Sales: 23/23/2002 14:00 (Last Audit D' +
      'ate Time)'
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Label8: TLabel
    Left = 0
    Top = 239
    Width = 381
    Height = 29
    Alignment = taCenter
    AutoSize = False
    Caption = 'Stock Period: 999 full business days'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object lblSTh: TLabel
    Left = 0
    Top = 97
    Width = 381
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Minimum End Date: 22/22/2222 (Start Date + 1)'#13#10'End Date/Time of ' +
      'Last Acc: 22/22/2222 (Last Audit Date - 2)'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object lblTimeNote: TLabel
    Left = 14
    Top = 205
    Width = 343
    Height = 27
    AutoSize = False
    Caption = 
      'Note: Times between midnight and roll-over (00:00 to 03:00) refe' +
      'r to the '#13#10'          calendaristic date 33/33/3333 (Business Dat' +
      'e: 22/22/2222)'
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    Visible = False
    WordWrap = True
  end
  object EtimePick: TDateTimePicker
    Left = 303
    Top = 184
    Width = 65
    Height = 21
    Hint = 'Only Hours and Minutes used'
    CalAlignment = dtaLeft
    Date = 36244
    Format = 'HH:mm'
    Time = 36244
    DateFormat = dfShort
    DateMode = dmComboBox
    Enabled = False
    Kind = dtkTime
    ParseInput = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object OKBtn: TBitBtn
    Left = 66
    Top = 272
    Width = 113
    Height = 38
    Hint = 
      'Accept the inventory details entered'#13#10'and proceed with data retr' +
      'ieval'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 202
    Top = 272
    Width = 113
    Height = 38
    Hint = 
      'Cancels the current inventory.'#13#10'Any details entered so far will ' +
      'be lost.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Kind = bkCancel
  end
  object partDayChk: TCheckBox
    Left = 5
    Top = 187
    Width = 289
    Height = 16
    Hint = 
      'Check this box if you want to include'#13#10'part day sales for the da' +
      'y following the'#13#10'last full day sales ('#39'End Date'#39').'
    Alignment = taLeftJustify
    Caption = 'Include Sales For 22/22/2222 (Business Date)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = partDayChkClick
  end
  object SdatePick: TDateTimePicker
    Left = 5
    Top = 146
    Width = 110
    Height = 21
    CalAlignment = dtaLeft
    Date = 37510
    Time = 37510
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object EdatePick: TDateTimePicker
    Left = 258
    Top = 146
    Width = 110
    Height = 21
    CalAlignment = dtaLeft
    Date = 37510
    Time = 37510
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnCloseUp = EdatePickChange
    OnExit = EdatePickChange
  end
end
