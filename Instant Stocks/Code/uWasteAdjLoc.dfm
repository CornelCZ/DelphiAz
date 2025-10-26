object fWasteAdjLoc: TfWasteAdjLoc
  Left = 373
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Wastage Adjustment'
  ClientHeight = 181
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  HelpFile = '1020'
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 363
    Top = 87
    Width = 139
    Height = 32
  end
  object Bevel3: TBevel
    Left = 2
    Top = 64
    Width = 175
    Height = 57
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 181
    Top = 64
    Width = 176
    Height = 57
    Shape = bsFrame
    Style = bsRaised
  end
  object DBText1: TDBText
    Left = 93
    Top = 1
    Width = 169
    Height = 17
    Color = clBtnFace
    DataField = 'SubCat'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText2: TDBText
    Left = 93
    Top = 27
    Width = 169
    Height = 18
    Alignment = taCenter
    Color = clBlue
    DataField = 'Name'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText3: TDBText
    Left = 356
    Top = 2
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clWhite
    DataField = 'ACount'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 4
    Top = 30
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = 'Product Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 282
    Top = 4
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Caption = 'Audit Count:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 139
    Width = 212
    Height = 37
  end
  object Label4: TLabel
    Left = 15
    Top = 132
    Width = 57
    Height = 13
    Caption = ' Product: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText4: TDBText
    Left = 8
    Top = 95
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clGreen
    DataField = 'WasteTill'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DBText5: TDBText
    Left = 186
    Top = 95
    Width = 82
    Height = 17
    Alignment = taCenter
    Color = clGreen
    DataField = 'WastePC'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 271
    Top = 30
    Width = 82
    Height = 13
    Alignment = taRightJustify
    Caption = 'Counting Unit:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object DBText6: TDBText
    Left = 356
    Top = 28
    Width = 141
    Height = 17
    Alignment = taCenter
    Color = clBlue
    DataField = 'Unit'
    DataSource = fAuditLocations.wwsAuditCur
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label7: TLabel
    Left = 99
    Top = 79
    Width = 63
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Adjustment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 186
    Top = 79
    Width = 51
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Wastage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 275
    Top = 79
    Width = 63
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Adjustment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 363
    Top = 71
    Width = 141
    Height = 13
    Alignment = taRightJustify
    Caption = 'Total Adjusted Wastage:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 79
    Width = 51
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Wastage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 8
    Top = 58
    Width = 93
    Height = 13
    Alignment = taRightJustify
    Caption = ' Front of House '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 187
    Top = 58
    Width = 93
    Height = 13
    Alignment = taRightJustify
    Caption = ' Back of House '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object WasteLab: TLabel
    Left = 368
    Top = 92
    Width = 129
    Height = 22
    Alignment = taCenter
    AutoSize = False
    Caption = 'WasteLab'
    Color = clGreen
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object DBText7: TDBText
    Left = 152
    Top = 120
    Width = 49
    Height = 17
    DataField = 'WasteTillA'
    DataSource = fAuditLocations.wwsAuditCur
    Visible = False
  end
  object DBText8: TDBText
    Left = 280
    Top = 120
    Width = 49
    Height = 17
    DataField = 'WastePCA'
    DataSource = fAuditLocations.wwsAuditCur
    Visible = False
  end
  object Label11: TLabel
    Left = 9
    Top = 95
    Width = 161
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = '---- New Item ----'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object BitBtn1: TBitBtn
    Left = 272
    Top = 138
    Width = 110
    Height = 38
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 392
    Top = 138
    Width = 110
    Height = 38
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 13
    Top = 147
    Width = 102
    Height = 26
    Caption = 'Previous (PgUp)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 121
    Top = 147
    Width = 94
    Height = 26
    Caption = 'Next (PgDown)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn4Click
  end
  object wwDBEdit1: TwwDBEdit
    Left = 96
    Top = 93
    Width = 73
    Height = 21
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnChange = wwDBEdit1Change
  end
  object wwDBEdit2: TwwDBEdit
    Left = 275
    Top = 93
    Width = 73
    Height = 21
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnChange = wwDBEdit1Change
  end
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 505
    Height = 87
    TabOrder = 6
    Visible = False
    object Label10: TLabel
      Left = 1
      Top = 1
      Width = 503
      Height = 85
      Align = alClient
      Alignment = taCenter
      Caption = 'This is a Prepared Item'#13#10'Wastage cannot be adjusted for it'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clYellow
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
  end
end
