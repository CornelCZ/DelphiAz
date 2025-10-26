object fbasefrm: Tfbasefrm
  Left = 460
  Top = 228
  Width = 751
  Height = 542
  AutoSize = True
  Caption = 'Aztec Time & Attendance - Base Data'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBtnText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 459
    Width = 735
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object BitBtn5: TBitBtn
      Left = 296
      Top = 4
      Width = 145
      Height = 39
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn5Click
      Kind = bkCancel
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 735
    Height = 459
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 735
      Height = 459
      ActivePage = SysVarTab
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      OnChange = PageControl1Change
      OnChanging = PageControl1Changing
      object SysVarTab: TTabSheet
        Caption = 'System Variables'
        object Panel4: TPanel
          Left = 0
          Top = 372
          Width = 727
          Height = 56
          Align = alBottom
          TabOrder = 1
          object BitBtn17: TBitBtn
            Left = 109
            Top = 5
            Width = 217
            Height = 46
            Caption = '&Save the new variables'
            TabOrder = 0
            OnClick = BitBtn17Click
            Glyph.Data = {
              8A010000424D8A01000000000000760000002800000018000000170000000100
              0400000000001401000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA70000000000000A
              AAAAAAAAA033000000FF030AAAAAAAAAA033000000FF030AAAAAAAAAA0330000
              00FF030AAAAAAAAAA03300000000030AAAAAAAAAA03333333333330AAAAAAAAA
              A03300000000330AAAAAAAAAA030FAAAAAAA030AAAAAAAAAA030AFAAAAAA030A
              AAAAAAAAA030AAAAAAAA030AAAAAAAAAA030AAAAAAAA030AAAAAAAAAA030AAAA
              AAAA000AAAAAAAAAA030AAAAAAAA0F0AAAAAAAAAA00000000000000AAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAA}
          end
          object BitBtn18: TBitBtn
            Left = 397
            Top = 5
            Width = 217
            Height = 46
            Caption = '&Discard changes'
            TabOrder = 1
            OnClick = BitBtn18Click
            Glyph.Data = {
              8A010000424D8A01000000000000760000002800000018000000170000000100
              0400000000001401000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAA7000000AAAAAAAAAAAAAAAAA0330000AA00000000
              AAAAAAA0330000AA000FF030AAAAAAA03300000AA00FF030AAAAAAA033000000
              AA0FF030AAAAAAA033333330AA000030AAAAAAA033000000AA033330AAAAAAA0
              30FAAAA0AA000330AAAAAAA030AFAA0AAA0AA030AAAAAAA030AAA0AAA0AAA030
              AAAAAAA030AAA0AA0AAAA030AAAAAAA030AA0AAA0AAAA030AAAAAAA030A0AAA0
              AAAAA000AAAAAAA00000AA0AAAAAA0F0AAAAAAAAAAAAAA0000000000AAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
              AAAAAAAAAAAAAAAAAAAAAAAAAAAA}
          end
        end
        object ScrollBox1: TScrollBox
          Left = 0
          Top = 0
          Width = 727
          Height = 372
          Align = alClient
          TabOrder = 0
          object Label11: TLabel
            Left = 13
            Top = 42
            Width = 659
            Height = 16
            Caption = 
              'DESCRIPTION: time showing how much earlier the schedule roll-ove' +
              'r time is, compared with the business roll-over'
          end
          object Label10: TLabel
            Left = 13
            Top = 62
            Width = 112
            Height = 16
            Caption = 'FORMAT:  HH:mm '
          end
          object Label12: TLabel
            Left = 197
            Top = 62
            Width = 380
            Height = 16
            Caption = 
              'RESTRICTION: the two roll-over times should fall in the same day' +
              '.'
          end
          object Label13: TLabel
            Left = 13
            Top = 14
            Width = 103
            Height = 19
            Caption = 'Grace Period'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape3: TShape
            Left = 29
            Top = 83
            Width = 662
            Height = 3
            Brush.Color = clBtnFace
          end
          object Label14: TLabel
            Left = 11
            Top = 95
            Width = 109
            Height = 19
            Caption = 'Early Clock-In'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 11
            Top = 123
            Width = 667
            Height = 16
            Caption = 
              'DESCRIPTION: times showing how much earlier (or later) than sche' +
              'duled the employees will be allowed to clock-in '
          end
          object Label16: TLabel
            Left = 11
            Top = 143
            Width = 180
            Height = 16
            Caption = 'FORMAT:  HH:mm ; 24hr clock'
          end
          object Label17: TLabel
            Left = 267
            Top = 143
            Width = 308
            Height = 16
            Caption = 'RESTRICTION: Both should be smaller than 24 hours'
          end
          object Label18: TLabel
            Left = 227
            Top = 95
            Width = 103
            Height = 19
            Caption = 'Late Clock-In'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape4: TShape
            Left = 29
            Top = 166
            Width = 662
            Height = 3
            Brush.Color = clBtnFace
          end
          object Label20: TLabel
            Left = 376
            Top = 14
            Width = 182
            Height = 19
            Caption = 'Current Roll-Over Time'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label22: TLabel
            Left = 376
            Top = 180
            Width = 171
            Height = 19
            Caption = 'Schedule totals on/off'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label24: TLabel
            Left = 376
            Top = 225
            Width = 169
            Height = 19
            Caption = 'Set Open/Close times'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape7: TShape
            Left = 350
            Top = 174
            Width = 4
            Height = 138
            Brush.Color = clBtnFace
          end
          object Shape8: TShape
            Left = 389
            Top = 213
            Width = 303
            Height = 3
            Brush.Color = clBtnFace
          end
          object Shape10: TShape
            Left = 389
            Top = 255
            Width = 303
            Height = 3
            Brush.Color = clBtnFace
          end
          object Label25: TLabel
            Left = 11
            Top = 180
            Width = 202
            Height = 19
            Caption = 'Auto - fill grid in Schedule'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label26: TLabel
            Left = 376
            Top = 271
            Width = 261
            Height = 36
            Caption = 
              'Allow individual shift pay rate change'#13#10'in Verify Schedule (hour' +
              'ly jobs only)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape6: TShape
            Left = 29
            Top = 322
            Width = 662
            Height = 3
            Brush.Color = clBtnFace
          end
          object Label27: TLabel
            Left = 11
            Top = 328
            Width = 293
            Height = 19
            Caption = 'Tip Tracking Statement Configuration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label28: TLabel
            Left = 11
            Top = 355
            Width = 103
            Height = 18
            Caption = 'Employer EIN: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 7
            Top = 209
            Width = 208
            Height = 32
            Caption = 'Only when starting a new Schedule '#13#10'(i.e. empty Schedule)'
          end
          object Label6: TLabel
            Left = 63
            Top = 244
            Width = 150
            Height = 16
            Caption = 'Every time form is opened'
          end
          object Label9: TLabel
            Left = 8
            Top = 264
            Width = 338
            Height = 35
            AutoSize = False
            Caption = 
              'This will create a row for each active employee. Only default jo' +
              'bs are considered. Empty shifts are NOT saved!'
            Color = clInactiveCaption
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            WordWrap = True
          end
          object Label29: TLabel
            Left = 376
            Top = 328
            Width = 80
            Height = 19
            Caption = 'Time Outs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape13: TShape
            Left = 350
            Top = 333
            Width = 4
            Height = 45
            Brush.Color = clBtnFace
          end
          object Label36: TLabel
            Left = 376
            Top = 353
            Width = 64
            Height = 16
            Caption = 'Auto Close'
          end
          object Shape14: TShape
            Left = 29
            Top = 386
            Width = 662
            Height = 3
            Brush.Color = clBtnFace
          end
          object Shape15: TShape
            Left = 350
            Top = 398
            Width = 4
            Height = 18
            Brush.Color = clBtnFace
          end
          object Label40: TLabel
            Left = 376
            Top = 398
            Width = 246
            Height = 19
            Caption = 'Scheduler Look Ahead (Weeks)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape17: TShape
            Left = 29
            Top = 424
            Width = 662
            Height = 3
            Brush.Color = clBtnFace
          end
          object Shape18: TShape
            Left = 350
            Top = 436
            Width = 4
            Height = 62
            Brush.Color = clBtnFace
          end
          object lblAutoPrintPayReport: TLabel
            Left = 11
            Top = 436
            Width = 235
            Height = 19
            Caption = 'Auto Print Weekly Pay Report'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblWageCostUplift: TLabel
            Left = 11
            Top = 396
            Width = 216
            Height = 19
            Caption = 'Wage Cost Uplift Factor(%)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object graceedit: TMaskEdit
            Left = 133
            Top = 11
            Width = 49
            Height = 24
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 0
            Text = '  :  '
            OnExit = ValidateTimeInEditControl
          end
          object lee1edit: TMaskEdit
            Left = 131
            Top = 92
            Width = 49
            Height = 24
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 1
            Text = '  :  '
            OnExit = ValidateTimeInEditControl
          end
          object lee2edit: TMaskEdit
            Left = 347
            Top = 92
            Width = 49
            Height = 24
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 2
            Text = '  :  '
            OnExit = ValidateTimeInEditControl
          end
          object BitBtn19: TBitBtn
            Left = 598
            Top = 175
            Width = 77
            Height = 29
            TabOrder = 4
            OnClick = BitBtn19Click
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              0400000000000001000000000000000000001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              003337777777777777F330FFFFFFFFFFF033373F3F3F3F3F3733330F0F0F0F0F
              03333F7F737373737FFF0000FFFFFFF0000377773FFFFFF7777F0FF800000008
              FF037F3F77777773FF7F0F9FFFFFFFF000037F7333333337777F0FFFFFFFFFFF
              FF0373FFFFFFFFFFFF7330000000000000333777777777777733333000000000
              3333333777777777F3333330FFFFFFF033333337F3FFFFF7F3333330F00000F0
              33333337F77777F7F3333330F0AAE0F033333337F7F337F7F3333330F0DAD0F0
              33333337F7FFF7F7F3333330F00000F033333337F7777737F3333330FFFFFFF0
              33333337FFFFFFF7F33333300000000033333337777777773333}
            NumGlyphs = 2
          end
          object BitBtn21: TBitBtn
            Left = 598
            Top = 221
            Width = 77
            Height = 29
            TabOrder = 5
            OnClick = BitBtn21Click
            Glyph.Data = {
              06020000424D0602000000000000760000002800000019000000190000000100
              0400000000009001000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
              6666666666666000000066666666666666666666666660000000666666666666
              66666666666660000000666666666666666666666666600000006FFFFFFFFFFF
              FFFFFFFFFFF6600000006F99999999999999999999F6600000006F99FF99F999
              FFF9F999F9F6600000006F9F99F9F999F999F99FF9F6600000006F9F99F9FF99
              FF99F9F9F9F6600000006F9F99F9F9F9F999FF99F9F6600000006F99FF99FF99
              FFF9F999F9F6600000006F99999999999999999999F6600000006FFFFFFFFFFF
              FFFFFFFFFFF6600000006666666F6666666F666666666000000066666666F666
              66F66666666660000000666666666F666F666666666660000000666666666600
              F666666666666000000066666666606F06666666666660000000666666666066
              0666666666666000000066666666666600066666666660000000666666666666
              6606666666666000000066666666666666666666666660000000666666666666
              6666666666666000000066666666666666666666666660000000666666666666
              66666666666660000000}
          end
          object CheckBox3: TCheckBox
            Left = 220
            Top = 224
            Width = 17
            Height = 17
            Caption = 'CheckBox3'
            Checked = True
            State = cbChecked
            TabOrder = 6
            OnClick = CheckBox3Click
          end
          object CheckBox4: TCheckBox
            Left = 656
            Top = 281
            Width = 17
            Height = 17
            Caption = 'CheckBox3'
            Checked = True
            State = cbChecked
            TabOrder = 7
          end
          object edEIN: TEdit
            Left = 120
            Top = 352
            Width = 121
            Height = 24
            TabOrder = 8
          end
          object CheckBox5: TCheckBox
            Left = 220
            Top = 244
            Width = 16
            Height = 17
            TabOrder = 9
          end
          object autoclose: TCheckBox
            Left = 448
            Top = 353
            Width = 17
            Height = 17
            TabOrder = 10
          end
          object Rolledit: TEdit
            Left = 576
            Top = 11
            Width = 57
            Height = 24
            ReadOnly = True
            TabOrder = 3
            Text = 'Rolledit'
          end
          object edtLookAhead: TMaskEdit
            Left = 624
            Top = 394
            Width = 60
            Height = 24
            EditMask = '9;0;0'
            MaxLength = 1
            TabOrder = 11
          end
          object cbAutoPrintPayReport: TCheckBox
            Left = 40
            Top = 461
            Width = 225
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Auto Print Pay Report'
            TabOrder = 12
          end
          object cbDecimalHours: TCheckBox
            Left = 40
            Top = 479
            Width = 225
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Print Pay Report as Decimal Hours'
            TabOrder = 13
          end
          object spinEdWageCostUplift: TwwDBSpinEdit
            Left = 259
            Top = 394
            Width = 60
            Height = 24
            Increment = 1
            MaxValue = 100
            DataField = 'Wage Cost Uplift Factor'
            DataSource = dMod1.dsWageCostUplift
            TabOrder = 14
            UnboundDataType = wwDefault
          end
        end
      end
      object AttCodeTab: TTabSheet
        Caption = 'Attendance Codes'
        ImageIndex = 5
        object Bevel1: TBevel
          Left = 366
          Top = 0
          Width = 367
          Height = 135
          Shape = bsFrame
          Style = bsRaised
        end
        object Bevel2: TBevel
          Left = 368
          Top = 2
          Width = 363
          Height = 131
        end
        object Label30: TLabel
          Left = 481
          Top = 5
          Width = 242
          Height = 16
          Alignment = taRightJustify
          Caption = 'Default Attendance Codes (Read Only)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label31: TLabel
          Left = 2
          Top = 1
          Width = 264
          Height = 16
          Caption = 'User Defined Attendance Codes (Editable)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object wwDBGrid1: TwwDBGrid
          Left = 371
          Top = 24
          Width = 357
          Height = 106
          Selected.Strings = (
            'AttCode'#9'2'#9'Code'
            'Display'#9'10'#9'Display'
            'Description'#9'30'#9'Description')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 1
          ShowHorzScrollBar = False
          Color = clBtnFace
          DataSource = dMod1.dsROAtt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBtnText
          TitleFont.Height = -13
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
        end
        object gridAttCd: TwwDBGrid
          Left = -1
          Top = 18
          Width = 366
          Height = 409
          Selected.Strings = (
            'AttCode'#9'2'#9'Code'
            'Display'#9'10'#9'Display'
            'Description'#9'30'#9'Description')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 1
          ShowHorzScrollBar = True
          DataSource = dMod1.dsAtt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgEnterToTab]
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBtnText
          TitleFont.Height = -13
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
        end
        object btnInsAttCode: TBitBtn
          Left = 377
          Top = 240
          Width = 177
          Height = 41
          Caption = 'Insert New Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnInsAttCodeClick
        end
        object rgAttOrd: TRadioGroup
          Left = 377
          Top = 160
          Width = 353
          Height = 65
          Caption = ' Order By (for user defined codes only) '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemIndex = 0
          Items.Strings = (
            'Order By Code'
            'Order By Display')
          ParentFont = False
          TabOrder = 3
          OnClick = rgAttOrdClick
        end
        object pnlInsAtt: TPanel
          Left = 377
          Top = 290
          Width = 353
          Height = 137
          TabOrder = 4
          Visible = False
          object Label32: TLabel
            Left = 9
            Top = 50
            Width = 234
            Height = 16
            Caption = 'Attendance Code (max. 2 characters)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label33: TLabel
            Left = 9
            Top = 77
            Width = 208
            Height = 16
            Caption = 'Display String (max 10 charcters)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label34: TLabel
            Left = 19
            Top = 5
            Width = 315
            Height = 35
            AutoSize = False
            Caption = 
              'Fill in the new code and display string and click OK when ready.' +
              ' Both code and display have to be unique.'
            Color = clInactiveCaption
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clInactiveCaptionText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            WordWrap = True
          end
          object btnOKAttCode: TBitBtn
            Left = 266
            Top = 103
            Width = 81
            Height = 29
            Caption = 'OK'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = btnOKAttCodeClick
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
          object BitBtn22: TBitBtn
            Left = 162
            Top = 103
            Width = 89
            Height = 29
            Cancel = True
            Caption = 'Cancel'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = BitBtn22Click
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
          object edAttDisp: TEdit
            Left = 225
            Top = 73
            Width = 120
            Height = 24
            MaxLength = 10
            TabOrder = 3
            OnKeyPress = edAttDispKeyPress
          end
          object edAttCode: TEdit
            Left = 296
            Top = 46
            Width = 49
            Height = 24
            MaxLength = 2
            TabOrder = 2
            OnKeyPress = edAttCodeKeyPress
          end
        end
      end
    end
  end
end
