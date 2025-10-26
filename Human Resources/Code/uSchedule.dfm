object fSchedule: TfSchedule
  Left = 416
  Top = 204
  Width = 904
  Height = 560
  HorzScrollBar.Range = 790
  HorzScrollBar.Visible = False
  VertScrollBar.Range = 510
  BorderStyle = bsSingle
  Caption = 'Weekly Schedule'
  Color = clBtnFace
  Constraints.MinWidth = 904
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 888
    Height = 26
    Align = alTop
    HotTrack = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
  end
  object Panel2: TPanel
    Left = 0
    Top = 466
    Width = 888
    Height = 56
    Align = alBottom
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      888
      56)
    object BitBtn1: TBitBtn
      Left = 778
      Top = 7
      Width = 108
      Height = 42
      Hint = 'Accept current values'
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
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
    object btnInsertEmployee: TBitBtn
      Left = 171
      Top = 16
      Width = 103
      Height = 33
      Hint = 'Insert New Employee in Schedule'
      Caption = '&Insert Employee'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnInsertEmployeeClick
    end
    object copybut: TBitBtn
      Left = 514
      Top = 16
      Width = 143
      Height = 33
      Hint = 
        'Copy another week schedule into this week'#13#10'(whole week, all shif' +
        'ts, overwrite this week)'
      Caption = '&Copy Schedule From...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = copybutClick
    end
    object btnDeleteEmployee: TBitBtn
      Left = 278
      Top = 16
      Width = 106
      Height = 33
      Hint = 
        'Delete selected employee from the Schedule'#13#10'(NOT from the Employ' +
        'ee database)'
      Caption = '&Delete Employee'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnDeleteEmployeeClick
    end
    object grpBoxReports: TGroupBox
      Left = 3
      Top = 1
      Width = 157
      Height = 52
      Caption = 'Reports'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
      TabOrder = 4
      object btnByJobType: TBitBtn
        Left = 3
        Top = 19
        Width = 80
        Height = 27
        Hint = 'List shifts by job'
        Caption = 'By &Job Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnScheduleReportClick
      end
      object btnByName: TBitBtn
        Left = 86
        Top = 19
        Width = 66
        Height = 27
        Hint = 'List shifts by employee name'
        Caption = 'By &Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnScheduleReportClick
      end
    end
    object btnEmptySchedule: TBitBtn
      Left = 409
      Top = 16
      Width = 102
      Height = 33
      Hint = 
        'Empty all shifts from currently showing Schedule'#13#10'(whole week, f' +
        'or all jobs, for all employees)'
      Caption = 'Empty Schedule'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnEmptyScheduleClick
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 436
    Width = 888
    Height = 30
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    TabOrder = 1
  end
  object Panel6: TPanel
    Left = 0
    Top = 344
    Width = 888
    Height = 92
    Align = alBottom
    BorderStyle = bsSingle
    Color = clHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      884
      88)
    object Label29: TLabel
      Tag = 1
      Left = 4
      Top = 10
      Width = 62
      Height = 32
      Caption = 'Employee Total'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label30: TLabel
      Tag = 2
      Left = 4
      Top = 50
      Width = 62
      Height = 32
      Caption = 'Employee Cost'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label31: TLabel
      Tag = 3
      Left = 285
      Top = 10
      Width = 27
      Height = 32
      Caption = 'Job Total'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label32: TLabel
      Tag = 4
      Left = 285
      Top = 50
      Width = 27
      Height = 32
      Caption = 'Job Cost'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label33: TLabel
      Tag = 5
      Left = 392
      Top = 10
      Width = 27
      Height = 32
      Caption = 'Day Total'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label34: TLabel
      Tag = 6
      Left = 392
      Top = 50
      Width = 27
      Height = 32
      Caption = 'Day Cost'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label35: TLabel
      Tag = 7
      Left = 494
      Top = 10
      Width = 38
      Height = 32
      Caption = 'Week Total'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label36: TLabel
      Tag = 8
      Left = 494
      Top = 50
      Width = 38
      Height = 32
      Caption = 'Week Cost'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object lblEmpHrs: TLabel
      Tag = 1
      Left = 62
      Top = 26
      Width = 32
      Height = 16
      Caption = '00:00'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblEmpCost: TLabel
      Tag = 2
      Left = 61
      Top = 66
      Width = 71
      Height = 16
      Caption = '$999,999.99'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblJobHrs: TLabel
      Tag = 3
      Left = 320
      Top = 26
      Width = 32
      Height = 16
      Caption = '00:00'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblJobCost: TLabel
      Tag = 4
      Left = 318
      Top = 66
      Width = 71
      Height = 16
      Caption = '$999,999.99'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblDayHrs: TLabel
      Tag = 5
      Left = 425
      Top = 26
      Width = 32
      Height = 16
      Caption = '00:00'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblDayCost: TLabel
      Tag = 6
      Left = 423
      Top = 66
      Width = 71
      Height = 16
      Caption = '$999,999.99'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblWkHrs: TLabel
      Tag = 7
      Left = 534
      Top = 27
      Width = 32
      Height = 16
      Caption = '00:00'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblWkCost: TLabel
      Tag = 8
      Left = 533
      Top = 66
      Width = 71
      Height = 16
      Caption = '$999,999.99'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label53: TLabel
      Tag = 9
      Left = 134
      Top = 10
      Width = 55
      Height = 32
      Caption = 'Expected Takings'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label54: TLabel
      Tag = 10
      Left = 134
      Top = 50
      Width = 55
      Height = 32
      Caption = 'Expected Wage %'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object lblExpTake: TLabel
      Tag = 9
      Left = 191
      Top = 26
      Width = 18
      Height = 16
      Caption = '0.0'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblExpTPc: TLabel
      Tag = 10
      Left = 191
      Top = 66
      Width = 32
      Height = 16
      Caption = '00.00'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object sbExpTake: TSpeedButton
      Tag = 9
      Left = 193
      Top = 4
      Width = 40
      Height = 21
      Caption = 'Modify'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbExpTakeClick
    end
    object sprevert: TSpeedButton
      Tag = 9
      Left = 232
      Top = 4
      Width = 41
      Height = 21
      Caption = 'Revert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sprevertClick
    end
    object bbtReCalc: TBitBtn
      Left = 613
      Top = 22
      Width = 85
      Height = 49
      Caption = '&Re calculate'
      TabOrder = 0
      OnClick = bbtReCalcClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object Panel8: TPanel
      Left = 809
      Top = 1
      Width = 80
      Height = 95
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 1
      object Copybtn: TBitBtn
        Left = 3
        Top = 3
        Width = 73
        Height = 25
        Hint = 'Copy shift times from current record...'
        Caption = 'Cop&y...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = CopybtnClick
      end
      object Pastebtn: TBitBtn
        Left = 3
        Top = 32
        Width = 73
        Height = 25
        Hint = 'Paste in current record'
        Caption = '&Paste'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PastebtnClick
      end
      object fillbtn: TBitBtn
        Left = 3
        Top = 61
        Width = 73
        Height = 25
        Hint = 'Fill row with entered times'
        Caption = '&Fill Row...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = fillbtnClick
      end
    end
    object Panel11: TPanel
      Left = 278
      Top = 8
      Width = 3
      Height = 74
      BevelInner = bvLowered
      Caption = 'Panel11'
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 164
    Top = 26
    Width = 613
    Height = 5
    BevelOuter = bvNone
    TabOrder = 4
  end
  object sbxSchedule: TScrollBox
    Left = 0
    Top = 26
    Width = 888
    Height = 318
    HorzScrollBar.Range = 860
    VertScrollBar.Range = 321
    VertScrollBar.Visible = False
    Align = alClient
    AutoScroll = False
    TabOrder = 5
    object DBGrid: TwwDBGrid
      Left = 0
      Top = 74
      Width = 884
      Height = 247
      ControlType.Strings = (
        'RoleName;CustomEdit;cbEmployeeJobsLookup;F')
      PictureMasks.Strings = (
        'Monin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Monout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Tuein'#9'{##:[##],o,O}'#9'T'#9'T'
        'Tueout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Wedin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Wedout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Thuin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Thuout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Friin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Friout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Satin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Satout'#9'{##:[##],c,C}'#9'T'#9'T'
        'Sunin'#9'{##:[##],o,O}'#9'T'#9'T'
        'Sunout'#9'{##:[##],c,C}'#9'T'#9'T')
      Selected.Strings = (
        'Sname'#9'10'#9'Sname'
        'FName'#9'10'#9'FName'
        'RoleName'#9'13'#9'RoleName'#9'F'
        'Monin'#9'5'#9'Monin'
        'Monout'#9'5'#9'Monout'
        'Tuein'#9'5'#9'Tuein'
        'Tueout'#9'5'#9'Tueout'
        'Wedin'#9'5'#9'Wedin'
        'Wedout'#9'5'#9'Wedout'
        'Thuin'#9'5'#9'Thuin'
        'Thuout'#9'5'#9'Thuout'
        'Friin'#9'5'#9'Friin'
        'Friout'#9'5'#9'Friout'
        'Satin'#9'5'#9'Satin'
        'Satout'#9'5'#9'Satout'
        'Sunin'#9'5'#9'Sunin'
        'Sunout'#9'5'#9'Sunout'
        'WeekTotal'#9'7'#9'WeekTotal')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 2
      ShowHorzScrollBar = False
      Align = alClient
      DataSource = DisplayDS
      KeyOptions = [dgEnterToTab]
      Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnCalcCellColors = DBGridCalcCellColors
      OnColEnter = DBGridColEnter
      OnColExit = DBGridColExit
      OnEnter = DBGridEnter
      OnExit = DBGridExit
      OnKeyDown = DBGrid45KeyDown
      OnKeyPress = DBGridKeyPress
      OnKeyUp = DBGridKeyUp
      OnMouseUp = DBGridMouseUp
    end
    object PanelTop: TPanel
      Left = 0
      Top = 0
      Width = 884
      Height = 74
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        884
        74)
      object Panel10: TPanel
        Left = 1
        Top = 0
        Width = 258
        Height = 74
        TabOrder = 0
        object Label38: TLabel
          Left = 1
          Top = 1
          Width = 256
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Selected Week'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object lblWeek: TLabel
          Left = 1
          Top = 17
          Width = 256
          Height = 17
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = '02/02/2002 -- 02/02/2202'
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object pnlEmpJobColumnHeading: TPanel
          Left = 1
          Top = 55
          Width = 257
          Height = 20
          TabOrder = 0
          object lblEmployeeName: TLabel
            Left = 14
            Top = 2
            Width = 149
            Height = 16
            Hint = 'Click to order by employee id'
            Alignment = taCenter
            AutoSize = False
            Caption = 'Employee Name'
            ParentShowHint = False
            ShowHint = True
            Layout = tlCenter
            OnClick = lblEmployeeNameClick
            OnMouseDown = lblEmployeeNameMouseDown
          end
          object lblJobName: TLabel
            Left = 164
            Top = 2
            Width = 91
            Height = 16
            Hint = 'Click to order by Job id'
            Alignment = taCenter
            AutoSize = False
            Caption = 'Role'
            ParentShowHint = False
            ShowHint = True
            Layout = tlCenter
            OnClick = lblJobNameClick
          end
          object Bevel8: TBevel
            Left = 11
            Top = 2
            Width = 2
            Height = 16
          end
          object Bevel9: TBevel
            Left = 161
            Top = 2
            Width = 2
            Height = 16
          end
        end
      end
      object Panel3: TPanel
        Left = 259
        Top = 0
        Width = 615
        Height = 55
        TabOrder = 1
        object Label1: TLabel
          Tag = 1
          Left = 7
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label2: TLabel
          Tag = 2
          Left = 87
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label3: TLabel
          Tag = 3
          Left = 166
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label4: TLabel
          Tag = 4
          Left = 246
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label5: TLabel
          Tag = 5
          Left = 326
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label6: TLabel
          Tag = 6
          Left = 405
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label7: TLabel
          Tag = 7
          Left = 485
          Top = 22
          Width = 69
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'Wednesday'
        end
        object Label8: TLabel
          Left = 25
          Top = 38
          Width = 38
          Height = 16
          Caption = 'Label8'
        end
        object Label9: TLabel
          Left = 105
          Top = 38
          Width = 38
          Height = 16
          Caption = 'Label9'
        end
        object Label10: TLabel
          Left = 184
          Top = 38
          Width = 45
          Height = 16
          Caption = 'Label10'
        end
        object Label11: TLabel
          Left = 264
          Top = 38
          Width = 44
          Height = 16
          Caption = 'Label11'
        end
        object Label12: TLabel
          Left = 344
          Top = 38
          Width = 45
          Height = 16
          Caption = 'Label12'
        end
        object Label13: TLabel
          Left = 423
          Top = 38
          Width = 45
          Height = 16
          Caption = 'Label13'
        end
        object Label14: TLabel
          Left = 503
          Top = 38
          Width = 45
          Height = 16
          Caption = 'Label14'
        end
        object Label46: TLabel
          Left = 561
          Top = 22
          Width = 51
          Height = 29
          Alignment = taCenter
          AutoSize = False
          Caption = 'Week'#13#10'Total'
          WordWrap = True
        end
        object Label52: TLabel
          Left = 20
          Top = 7
          Width = 4
          Height = 16
          Caption = ' '
          Color = clHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlightText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object DBText1: TDBText
          Left = 505
          Top = 2
          Width = 52
          Height = 16
          AutoSize = True
          DataField = 'UserId'
          DataSource = DisplayDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
      end
      object Panel5: TPanel
        Left = 259
        Top = 55
        Width = 560
        Height = 20
        TabOrder = 2
        object Label15: TLabel
          Left = 17
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label16: TLabel
          Left = 50
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label17: TLabel
          Left = 97
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label18: TLabel
          Left = 130
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label19: TLabel
          Left = 176
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label20: TLabel
          Left = 210
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label21: TLabel
          Left = 256
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label22: TLabel
          Left = 290
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label23: TLabel
          Left = 335
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label24: TLabel
          Left = 369
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label25: TLabel
          Left = 415
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label26: TLabel
          Left = 449
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Label27: TLabel
          Left = 494
          Top = 2
          Width = 10
          Height = 16
          Caption = 'In'
        end
        object Label28: TLabel
          Left = 529
          Top = 2
          Width = 21
          Height = 16
          Caption = 'Out'
        end
        object Bevel1: TBevel
          Left = 80
          Top = 2
          Width = 2
          Height = 16
        end
        object Bevel2: TBevel
          Left = 160
          Top = 2
          Width = 2
          Height = 16
        end
        object Bevel3: TBevel
          Left = 240
          Top = 2
          Width = 2
          Height = 16
        end
        object Bevel4: TBevel
          Left = 320
          Top = 2
          Width = 2
          Height = 16
        end
        object Bevel5: TBevel
          Left = 400
          Top = 2
          Width = 2
          Height = 16
        end
        object Bevel6: TBevel
          Left = 480
          Top = 2
          Width = 2
          Height = 16
        end
      end
      object Panel4: TPanel
        Left = 819
        Top = 55
        Width = 55
        Height = 20
        Caption = 'hh:mm'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Panel7: TPanel
        Left = 874
        Top = 0
        Width = 18
        Height = 74
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
    end
    object cbEmployeeJobsLookup: TwwDBLookupCombo
      Left = 92
      Top = 137
      Width = 121
      Height = 24
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'20'#9'Name'#9#9)
      DataField = 'RoleName'
      DataSource = DisplayDS
      LookupTable = qryEmployeeJobs
      LookupField = 'Id'
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  object DisplayDS: TwwDataSource
    DataSet = DisplayQuery
    OnUpdateData = DisplayDSUpdateData
    Left = 342
    Top = 120
  end
  object DS4: TwwDataSource
    DataSet = wwtGhost
    Left = 208
    Top = 440
  end
  object ByName: TppReport
    AutoStop = False
    DataPipeline = Bynamepipe
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ByName'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 2540
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OnPreviewFormCreate = byjobtypePreviewFormCreate
    Left = 272
    Top = 440
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'Bynamepipe'
    object ByNameHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 32015
      mmPrintPosition = 0
      object ByNameShape1: TppShape
        UserName = 'ByNameShape1'
        mmHeight = 17198
        mmLeft = 0
        mmTop = 1852
        mmWidth = 240507
        BandType = 0
      end
      object ByNameLabel1: TppLabel
        UserName = 'ByNameLabel1'
        Caption = 'SCHEDULE FOR WEEK BEGINNING'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        mmHeight = 5027
        mmLeft = 84667
        mmTop = 4498
        mmWidth = 73290
        BandType = 0
      end
      object ByNameLabel2: TppLabel
        UserName = 'ByNameLabel2'
        Caption = 'Printed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3175
        mmLeft = 201877
        mmTop = 2910
        mmWidth = 9790
        BandType = 0
      end
      object BNLabel4: TppLabel
        UserName = 'BNLabel4'
        Caption = 'BNLabel4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        mmHeight = 3969
        mmLeft = 107421
        mmTop = 11113
        mmWidth = 15346
        BandType = 0
      end
      object ByNameLabel5: TppLabel
        UserName = 'ByNameLabel5'
        OnGetText = ByNameLabel5GetText
        Caption = 'Monday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 84931
        mmTop = 21696
        mmWidth = 10054
        BandType = 0
      end
      object ByNameLabel6: TppLabel
        UserName = 'ByNameLabel6'
        OnGetText = ByNameLabel6GetText
        Caption = 'Tuesday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 105304
        mmTop = 21696
        mmWidth = 10848
        BandType = 0
      end
      object ByNameLabel7: TppLabel
        UserName = 'ByNameLabel7'
        OnGetText = ByNameLabel7GetText
        Caption = 'Wednesday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 123031
        mmTop = 21696
        mmWidth = 15081
        BandType = 0
      end
      object ByNameLabel8: TppLabel
        UserName = 'ByNameLabel8'
        OnGetText = ByNameLabel8GetText
        Caption = 'Thursday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 145521
        mmTop = 21696
        mmWidth = 11642
        BandType = 0
      end
      object ByNameLabel9: TppLabel
        UserName = 'ByNameLabel9'
        OnGetText = ByNameLabel9GetText
        Caption = 'Friday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 168275
        mmTop = 21696
        mmWidth = 7938
        BandType = 0
      end
      object ByNameLabel10: TppLabel
        UserName = 'ByNameLabel10'
        OnGetText = ByNameLabel10GetText
        Caption = 'Saturday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 187325
        mmTop = 21696
        mmWidth = 11377
        BandType = 0
      end
      object ByNameLabel11: TppLabel
        UserName = 'ByNameLabel11'
        OnGetText = ByNameLabel11GetText
        Caption = 'Sunday'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 208227
        mmTop = 21696
        mmWidth = 9525
        BandType = 0
      end
      object ByNameLabel13: TppLabel
        UserName = 'ByNameLabel13'
        Caption = 'Job'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 64558
        mmTop = 24606
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel14: TppLabel
        UserName = 'ByNameLabel14'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3175
        mmLeft = 84138
        mmTop = 27517
        mmWidth = 2381
        BandType = 0
      end
      object ByNameLabel15: TppLabel
        UserName = 'ByNameLabel15'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 93134
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel16: TppLabel
        UserName = 'ByNameLabel16'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 207434
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel17: TppLabel
        UserName = 'ByNameLabel17'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 104511
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel18: TppLabel
        UserName = 'ByNameLabel18'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 124884
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel19: TppLabel
        UserName = 'ByNameLabel19'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 166159
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel20: TppLabel
        UserName = 'ByNameLabel20'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 145521
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel21: TppLabel
        UserName = 'ByNameLabel21'
        Caption = 'In'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 186796
        mmTop = 27252
        mmWidth = 2117
        BandType = 0
      end
      object ByNameLabel22: TppLabel
        UserName = 'ByNameLabel22'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 113506
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel23: TppLabel
        UserName = 'ByNameLabel23'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 133879
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel24: TppLabel
        UserName = 'ByNameLabel24'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 154517
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel25: TppLabel
        UserName = 'ByNameLabel25'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 175155
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel26: TppLabel
        UserName = 'ByNameLabel26'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 195792
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLabel27: TppLabel
        UserName = 'ByNameLabel27'
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 216430
        mmTop = 27252
        mmWidth = 4498
        BandType = 0
      end
      object ByNameLine7: TppLine
        UserName = 'ByNameLine7'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 141023
        mmTop = 20373
        mmWidth = 2910
        BandType = 0
      end
      object ByNameLine8: TppLine
        UserName = 'ByNameLine8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 120650
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ByNameLine9: TppLine
        UserName = 'ByNameLine9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 161661
        mmTop = 20373
        mmWidth = 2646
        BandType = 0
      end
      object ByNameLine10: TppLine
        UserName = 'ByNameLine10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 182298
        mmTop = 20373
        mmWidth = 2910
        BandType = 0
      end
      object ByNameLine11: TppLine
        UserName = 'ByNameLine11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 202936
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ByNameLine12: TppLine
        UserName = 'ByNameLine12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 100277
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ByNameLabel4: TppLabel
        UserName = 'ByNameLabel4'
        Caption = 'Employee'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 18521
        mmTop = 24606
        mmWidth = 12171
        BandType = 0
      end
      object ByNameLine1: TppLine
        UserName = 'ByNameLine1'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 50271
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ByNameCalc1: TppSystemVariable
        UserName = 'ByNameCalc1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        mmHeight = 3704
        mmLeft = 215636
        mmTop = 2910
        mmWidth = 23019
        BandType = 0
      end
      object ByNameCalc2: TppSystemVariable
        UserName = 'ByNameCalc2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3704
        mmLeft = 224103
        mmTop = 8996
        mmWidth = 14552
        BandType = 0
      end
      object ppLine20: TppLine
        UserName = 'Line20'
        Weight = 0.75
        mmHeight = 2117
        mmLeft = 0
        mmTop = 20108
        mmWidth = 240507
        BandType = 0
      end
      object ppLine21: TppLine
        UserName = 'Line21'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 0
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ppLine22: TppLine
        UserName = 'Line201'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 2117
        mmLeft = 0
        mmTop = 30163
        mmWidth = 240507
        BandType = 0
      end
      object ppLine23: TppLine
        UserName = 'Line202'
        Weight = 0.75
        mmHeight = 2117
        mmLeft = 79904
        mmTop = 25929
        mmWidth = 143669
        BandType = 0
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 79904
        mmTop = 20108
        mmWidth = 2381
        BandType = 0
      end
      object ppLine25: TppLine
        UserName = 'Line25'
        Position = lpRight
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 238125
        mmTop = 20373
        mmWidth = 2381
        BandType = 0
      end
      object ppLine27: TppLine
        UserName = 'Line27'
        Position = lpRight
        Weight = 0.600000023841858
        mmHeight = 11906
        mmLeft = 221457
        mmTop = 20108
        mmWidth = 2381
        BandType = 0
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        Caption = 'Total Hours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 3175
        mmLeft = 224632
        mmTop = 24871
        mmWidth = 14552
        BandType = 0
      end
    end
    object ByNameDetailBand1: TppDetailBand
      BeforePrint = ByNameDetailBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 6085
      mmPrintPosition = 0
      object ByNameDBText2: TppDBText
        UserName = 'ByNameDBText2'
        DataField = 'FirstName'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 794
        mmTop = 1323
        mmWidth = 22490
        BandType = 4
      end
      object ByNameDBText3: TppDBText
        UserName = 'ByNameDBText3'
        DataField = 'LastName'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 24342
        mmTop = 1323
        mmWidth = 25665
        BandType = 4
      end
      object ByNameDBText4: TppDBText
        UserName = 'ByNameDBText4'
        DataField = 'jobname'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 51329
        mmTop = 1323
        mmWidth = 28046
        BandType = 4
      end
      object ByNameDBText5: TppDBText
        UserName = 'ByNameDBText5'
        OnGetText = ByNameDBText5GetText
        DataField = 'monin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 80963
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText6: TppDBText
        UserName = 'ByNameDBText6'
        OnGetText = ByNameDBText5GetText
        DataField = 'monout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 90488
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText7: TppDBText
        UserName = 'ByNameDBText7'
        OnGetText = ByNameDBText5GetText
        DataField = 'tuein'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 101336
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText8: TppDBText
        UserName = 'ByNameDBText8'
        OnGetText = ByNameDBText5GetText
        DataField = 'tueout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 110861
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText9: TppDBText
        UserName = 'ByNameDBText9'
        OnGetText = ByNameDBText5GetText
        DataField = 'wedin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 121709
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText10: TppDBText
        UserName = 'ByNameDBText10'
        OnGetText = ByNameDBText5GetText
        DataField = 'wedout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 131234
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText11: TppDBText
        UserName = 'ByNameDBText11'
        OnGetText = ByNameDBText5GetText
        DataField = 'thuin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 142346
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText12: TppDBText
        UserName = 'ByNameDBText12'
        OnGetText = ByNameDBText5GetText
        DataField = 'thuout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 151871
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText13: TppDBText
        UserName = 'ByNameDBText13'
        OnGetText = ByNameDBText5GetText
        DataField = 'friin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 162984
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText14: TppDBText
        UserName = 'ByNameDBText14'
        OnGetText = ByNameDBText5GetText
        DataField = 'friout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 172509
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText15: TppDBText
        UserName = 'ByNameDBText15'
        OnGetText = ByNameDBText5GetText
        DataField = 'satin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 183621
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText16: TppDBText
        UserName = 'ByNameDBText16'
        OnGetText = ByNameDBText5GetText
        DataField = 'satout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 193146
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText17: TppDBText
        UserName = 'ByNameDBText17'
        OnGetText = ByNameDBText5GetText
        DataField = 'sunin'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 204259
        mmTop = 1323
        mmWidth = 8890
        BandType = 4
      end
      object ByNameDBText18: TppDBText
        UserName = 'ByNameDBText18'
        OnGetText = ByNameDBText5GetText
        DataField = 'sunout'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 213784
        mmTop = 1323
        mmWidth = 8996
        BandType = 4
      end
      object Bottom: TppLine
        UserName = 'Bottom'
        Position = lpBottom
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 265
        mmTop = 5027
        mmWidth = 240507
        BandType = 4
      end
      object byNametopL: TppLine
        UserName = 'Bottom1'
        Weight = 0.75
        mmHeight = 1323
        mmLeft = 0
        mmTop = 0
        mmWidth = 240507
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        OnGetText = ppDBText2GetText
        DataField = 'tothrs'
        DataPipeline = Bynamepipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        OnFormat = ppDBText2Format
        DataPipelineName = 'Bynamepipe'
        mmHeight = 3704
        mmLeft = 225955
        mmTop = 1323
        mmWidth = 12171
        BandType = 4
      end
      object ByNameLine21: TppLine
        UserName = 'ByNameLine21'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 0
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine22: TppLine
        UserName = 'ByNameLine22'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 50271
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine20: TppLine
        UserName = 'ByNameLine20'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 79904
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine18: TppLine
        UserName = 'ByNameLine18'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 100277
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine19: TppLine
        UserName = 'ByNameLine19'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 120650
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine17: TppLine
        UserName = 'ByNameLine17'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 141023
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine15: TppLine
        UserName = 'ByNameLine15'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 161661
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine16: TppLine
        UserName = 'ByNameLine16'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 182298
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine14: TppLine
        UserName = 'ByNameLine14'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 202936
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByNameLine13: TppLine
        UserName = 'ByNameLine13'
        Position = lpRight
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 222250
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ppLine26: TppLine
        UserName = 'Line26'
        Position = lpRight
        Weight = 0.600000023841858
        mmHeight = 6085
        mmLeft = 238919
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
    end
    object ByNameFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
  end
  object JobsalDS: TwwDataSource
    DataSet = wwghost3
    Left = 16
    Top = 408
  end
  object Bynamepipe: TppBDEPipeline
    DataSource = DS4
    UserName = 'Bynamepipe'
    Left = 240
    Top = 440
    object BynamepipeppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'sec'
      FieldName = 'sec'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 0
      Position = 0
    end
    object BynamepipeppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'workmin'
      FieldName = 'workmin'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 1
    end
    object BynamepipeppField3: TppField
      FieldAlias = 'worked'
      FieldName = 'worked'
      FieldLength = 0
      DataType = dtTime
      DisplayWidth = 10
      Position = 2
    end
    object BynamepipeppField4: TppField
      FieldAlias = 'break'
      FieldName = 'break'
      FieldLength = 0
      DataType = dtTime
      DisplayWidth = 10
      Position = 3
    end
  end
  object Jobsalpipe: TppBDEPipeline
    DataSource = JobsalDS
    UserName = 'Jobsalpipe'
    Left = 48
    Top = 408
  end
  object DS3: TwwDataSource
    DataSet = wwtGhost
    Top = 440
  end
  object Byjobpipe: TppBDEPipeline
    DataSource = DS3
    UserName = 'Byjobpipe'
    Left = 32
    Top = 440
    object ByjobpipeppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'sec'
      FieldName = 'sec'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 0
    end
    object ByjobpipeppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'workmin'
      FieldName = 'workmin'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 1
    end
    object ByjobpipeppField3: TppField
      FieldAlias = 'worked'
      FieldName = 'worked'
      FieldLength = 0
      DataType = dtTime
      DisplayWidth = 10
      Position = 2
    end
    object ByjobpipeppField4: TppField
      FieldAlias = 'break'
      FieldName = 'break'
      FieldLength = 0
      DataType = dtTime
      DisplayWidth = 10
      Position = 3
    end
  end
  object byjobtype: TppReport
    AutoStop = False
    DataPipeline = Byjobpipe
    NoDataBehaviors = [ndBlankReport]
    OnStartPage = ByJobTypeStartPage
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ByJobType'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 216000
    PrinterSetup.mmPaperWidth = 279000
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OnPreviewFormCreate = byjobtypePreviewFormCreate
    Left = 63
    Top = 440
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'Byjobpipe'
    object ByJobTypeHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 25929
      mmPrintPosition = 0
      object ppLabel24: TppLabel
        OnPrint = ppLabel24Print
        UserName = 'Label24'
        Caption = 'Non-Salaried'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold, fsUnderline]
        Transparent = True
        mmHeight = 5027
        mmLeft = 529
        mmTop = 19844
        mmWidth = 26194
        BandType = 0
      end
      object ByJobTypeShape5: TppShape
        UserName = 'ByJobTypeShape5'
        mmHeight = 16933
        mmLeft = 0
        mmTop = 1588
        mmWidth = 236803
        BandType = 0
      end
      object titlelab: TppLabel
        UserName = 'titlelab'
        Caption = 'SCHEDULE FOR WEEK BEGINNING'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        mmHeight = 5027
        mmLeft = 96309
        mmTop = 4763
        mmWidth = 73290
        BandType = 0
      end
      object ByJobTypeLabel2: TppLabel
        UserName = 'ByJobTypeLabel2'
        Caption = 'ByJobTypeLabel2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        mmHeight = 4233
        mmLeft = 119592
        mmTop = 11377
        mmWidth = 26988
        BandType = 0
      end
      object ByJobTypeCalc2: TppSystemVariable
        UserName = 'ByJobTypeCalc2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3704
        mmLeft = 219605
        mmTop = 8467
        mmWidth = 14552
        BandType = 0
      end
      object ByJobTypeCalc1: TppSystemVariable
        UserName = 'ByJobTypeCalc1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        mmHeight = 3704
        mmLeft = 205582
        mmTop = 2910
        mmWidth = 28575
        BandType = 0
      end
    end
    object ByJobTypeDetailBand1: TppDetailBand
      BeforePrint = ByJobTypeDetailBand1BeforePrint
      mmBottomOffset = 0
      mmHeight = 6350
      mmPrintPosition = 0
      object ByJobTypeDBText2: TppDBText
        UserName = 'ByJobTypeDBText2'
        DataField = 'FirstName'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ReprintOnSubsequent = True
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 1058
        mmTop = 1058
        mmWidth = 25929
        BandType = 4
      end
      object ByJobTypeDBText3: TppDBText
        UserName = 'ByJobTypeDBText3'
        DataField = 'LastName'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ReprintOnSubsequent = True
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 28575
        mmTop = 1058
        mmWidth = 25929
        BandType = 4
      end
      object ByJobTypeDBText4: TppDBText
        UserName = 'ByJobTypeDBText4'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'monin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 56621
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText5: TppDBText
        UserName = 'ByJobTypeDBText5'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'monout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 69586
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText6: TppDBText
        UserName = 'ByJobTypeDBText6'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'tuein'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 81492
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText7: TppDBText
        UserName = 'ByJobTypeDBText7'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'tueout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 94721
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText8: TppDBText
        UserName = 'ByJobTypeDBText8'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'wedin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 106892
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText9: TppDBText
        UserName = 'ByJobTypeDBText9'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'wedout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 120650
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText10: TppDBText
        UserName = 'ByJobTypeDBText10'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'thuin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 132821
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText11: TppDBText
        UserName = 'ByJobTypeDBText11'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'thuout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 146315
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText12: TppDBText
        UserName = 'ByJobTypeDBText12'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'friin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 158750
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText13: TppDBText
        UserName = 'ByJobTypeDBText13'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'friout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 172509
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText14: TppDBText
        UserName = 'ByJobTypeDBText14'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'satin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 184944
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText15: TppDBText
        UserName = 'ByJobTypeDBText15'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'satout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 198438
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText16: TppDBText
        UserName = 'ByJobTypeDBText16'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'sunin'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 211138
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTypeDBText17: TppDBText
        UserName = 'ByJobTypeDBText17'
        OnGetText = ByJobTypeDBText4GetText
        DataField = 'sunout'
        DataPipeline = Byjobpipe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        DataPipelineName = 'Byjobpipe'
        mmHeight = 3969
        mmLeft = 225425
        mmTop = 1058
        mmWidth = 10160
        BandType = 4
      end
      object ByJobTop: TppLine
        UserName = 'ByJobTop'
        Weight = 0.75
        mmHeight = 1588
        mmLeft = 0
        mmTop = 0
        mmWidth = 236538
        BandType = 4
      end
      object ByJobBottom: TppLine
        UserName = 'ByJobBottom'
        Position = lpBottom
        Weight = 0.600000023841858
        mmHeight = 1058
        mmLeft = 0
        mmTop = 5556
        mmWidth = 236538
        BandType = 4
      end
      object ByJobLine1: TppLine
        UserName = 'ByJobLine1'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 55298
        mmTop = 0
        mmWidth = 1852
        BandType = 4
      end
      object ByJobTypeLine14: TppLine
        UserName = 'ByJobTypeLine14'
        Pen.Width = 2
        Position = lpLeft
        Weight = 1.5
        mmHeight = 6350
        mmLeft = 0
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
      object ByJobTypeLine8: TppLine
        UserName = 'ByJobTypeLine8'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 157427
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine9: TppLine
        UserName = 'ByJobTypeLine9'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 131498
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine10: TppLine
        UserName = 'ByJobTypeLine10'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 105569
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine11: TppLine
        UserName = 'ByJobTypeLine11'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 80433
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine12: TppLine
        UserName = 'ByJobTypeLine12'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 183621
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine13: TppLine
        UserName = 'ByJobTypeLine13'
        Pen.Width = 2
        Position = lpRight
        Weight = 1.5
        mmHeight = 6615
        mmLeft = 235215
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
      object ByJobTypeLine16: TppLine
        UserName = 'ByJobTypeLine16'
        Position = lpLeft
        Weight = 0.600000023841858
        mmHeight = 6350
        mmLeft = 209550
        mmTop = 0
        mmWidth = 1588
        BandType = 4
      end
    end
    object ByJobTypeFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppSummaryBand1: TppSummaryBand
      NewPage = True
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 10054
      mmPrintPosition = 0
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        TraverseAllData = False
        DataPipelineName = 'Jobsalpipe'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 4763
        mmWidth = 266300
        BandType = 7
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object jobsal: TppChildReport
          AutoStop = False
          DataPipeline = Jobsalpipe
          OnStartPage = JobsalStartPage
          PassSetting = psTwoPass
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'ByJobType'
          PrinterSetup.Orientation = poLandscape
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 12700
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 216000
          PrinterSetup.mmPaperWidth = 279000
          PrinterSetup.PaperSize = 1
          Left = 392
          Top = 264
          Version = '6.03'
          mmColumnWidth = 0
          DataPipelineName = 'Jobsalpipe'
          object ppTitleBand1: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 13229
            mmPrintPosition = 0
            object ppLabel22: TppLabel
              UserName = 'Label22'
              Caption = 'Salaried'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold, fsUnderline]
              Transparent = True
              mmHeight = 5027
              mmLeft = 1058
              mmTop = 6085
              mmWidth = 16404
              BandType = 1
            end
            object ppLine8: TppLine
              UserName = 'Line8'
              Pen.Width = 2
              Weight = 1.5
              mmHeight = 529
              mmLeft = 0
              mmTop = 2381
              mmWidth = 236803
              BandType = 1
            end
          end
          object ppDetailBand1: TppDetailBand
            BeforePrint = JobsalDetailBand1BeforePrint
            mmBottomOffset = 0
            mmHeight = 6350
            mmPrintPosition = 0
            object jobsalDBText2: TppDBText
              UserName = 'jobsalDBText2'
              DataField = 'FirstName'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              ReprintOnSubsequent = True
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 1058
              mmTop = 1058
              mmWidth = 25928
              BandType = 4
            end
            object jobsalDBText1: TppDBText
              UserName = 'jobsalDBText1'
              DataField = 'LastName'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              ReprintOnSubsequent = True
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 28575
              mmTop = 1058
              mmWidth = 25928
              BandType = 4
            end
            object ppDBText4: TppDBText
              UserName = 'DBText4'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'monin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 56092
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText5: TppDBText
              UserName = 'DBText5'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'monout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 69586
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'tuein'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 81492
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText7: TppDBText
              UserName = 'DBText7'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'tueout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 94721
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText8: TppDBText
              UserName = 'DBText8'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'wedin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 106892
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText9: TppDBText
              UserName = 'DBText9'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'wedout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 120650
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText10: TppDBText
              UserName = 'DBText10'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'thuin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 132821
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText11: TppDBText
              UserName = 'JobsalDBText101'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'thuout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 146315
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText12: TppDBText
              UserName = 'DBText12'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'friin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 158750
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText13: TppDBText
              UserName = 'DBText13'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'friout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 172509
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText14: TppDBText
              UserName = 'DBText14'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'satin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 184944
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText15: TppDBText
              UserName = 'DBText15'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'satout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 198438
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText16: TppDBText
              UserName = 'DBText16'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'sunin'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 211403
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object ppDBText17: TppDBText
              UserName = 'DBText17'
              OnGetText = ByJobTypeDBText4GetText
              DataField = 'sunout'
              DataPipeline = Jobsalpipe
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = []
              DataPipelineName = 'Jobsalpipe'
              mmHeight = 3969
              mmLeft = 225425
              mmTop = 1058
              mmWidth = 10054
              BandType = 4
            end
            object jobsaltop: TppLine
              UserName = 'Jobsaltop1'
              Weight = 0.75
              mmHeight = 1588
              mmLeft = 0
              mmTop = 0
              mmWidth = 236538
              BandType = 4
            end
            object ppLine9: TppLine
              UserName = 'Line9'
              Position = lpBottom
              Weight = 0.600000023841858
              mmHeight = 1058
              mmLeft = 265
              mmTop = 5556
              mmWidth = 236273
              BandType = 4
            end
            object ppLine10: TppLine
              UserName = 'Line10'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 55298
              mmTop = 0
              mmWidth = 1852
              BandType = 4
            end
            object ppLine11: TppLine
              UserName = 'Line11'
              Pen.Width = 2
              Position = lpLeft
              Weight = 1.5
              mmHeight = 6350
              mmLeft = 0
              mmTop = 0
              mmWidth = 1323
              BandType = 4
            end
            object ppLine12: TppLine
              UserName = 'Line12'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 157427
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine13: TppLine
              UserName = 'Line13'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 131498
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine14: TppLine
              UserName = 'Line14'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 105569
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine15: TppLine
              UserName = 'Line15'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 80433
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine16: TppLine
              UserName = 'Line16'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 183621
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine17: TppLine
              UserName = 'JobsalLine101'
              Pen.Width = 2
              Position = lpRight
              Weight = 1.5
              mmHeight = 6879
              mmLeft = 235480
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
            object ppLine18: TppLine
              UserName = 'Line18'
              Position = lpLeft
              Weight = 0.600000023841858
              mmHeight = 6350
              mmLeft = 209550
              mmTop = 0
              mmWidth = 1588
              BandType = 4
            end
          end
          object ppGroup1: TppGroup
            BreakName = 'Jobname'
            DataPipeline = Jobsalpipe
            KeepTogether = True
            UserName = 'Group1'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'Jobsalpipe'
            object ppGroupHeaderBand1: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 14023
              mmPrintPosition = 0
              object ppShape1: TppShape
                UserName = 'Shape1'
                Pen.Width = 2
                ShiftWithParent = True
                mmHeight = 6879
                mmLeft = 0
                mmTop = 4498
                mmWidth = 33073
                BandType = 3
                GroupNo = 0
              end
              object ppDBText1: TppDBText
                UserName = 'DBText1'
                DataField = 'Jobname'
                DataPipeline = Jobsalpipe
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                DataPipelineName = 'Jobsalpipe'
                mmHeight = 3969
                mmLeft = 1323
                mmTop = 5556
                mmWidth = 29898
                BandType = 3
                GroupNo = 0
              end
              object ppShape2: TppShape
                UserName = 'Shape2'
                Pen.Width = 2
                mmHeight = 6350
                mmLeft = 55298
                mmTop = 2646
                mmWidth = 182034
                BandType = 3
                GroupNo = 0
              end
              object ppShape3: TppShape
                UserName = 'Shape3'
                Pen.Width = 2
                mmHeight = 6350
                mmLeft = 55298
                mmTop = 8202
                mmWidth = 182034
                BandType = 3
                GroupNo = 0
              end
              object ppLabel1: TppLabel
                UserName = 'Label1'
                OnGetText = JobsalLabel26GetText
                Caption = 'Monday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 62177
                mmTop = 3440
                mmWidth = 11113
                BandType = 3
                GroupNo = 0
              end
              object ppLabel2: TppLabel
                UserName = 'Label2'
                OnGetText = JobsalLabel27GetText
                Caption = 'Tuesday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 86784
                mmTop = 3440
                mmWidth = 12435
                BandType = 3
                GroupNo = 0
              end
              object ppLabel3: TppLabel
                UserName = 'Label3'
                OnGetText = JobsalLabel28GetText
                Caption = 'Wednesday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 110067
                mmTop = 3440
                mmWidth = 17198
                BandType = 3
                GroupNo = 0
              end
              object ppLabel4: TppLabel
                UserName = 'Label4'
                OnGetText = JobsalLabel29GetText
                Caption = 'Thursday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 137584
                mmTop = 3440
                mmWidth = 13494
                BandType = 3
                GroupNo = 0
              end
              object ppLabel5: TppLabel
                UserName = 'JobsalLabel301'
                OnGetText = JobsalLabel30GetText
                Caption = 'Friday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 165894
                mmTop = 3440
                mmWidth = 8731
                BandType = 3
                GroupNo = 0
              end
              object ppLabel6: TppLabel
                UserName = 'Label6'
                OnGetText = JobsalLabel31GetText
                Caption = 'Saturday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 189707
                mmTop = 3440
                mmWidth = 12700
                BandType = 3
                GroupNo = 0
              end
              object ppLabel7: TppLabel
                UserName = 'Label7'
                OnGetText = JobsalLabel32GetText
                Caption = 'Sunday'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3969
                mmLeft = 216959
                mmTop = 3440
                mmWidth = 10848
                BandType = 3
                GroupNo = 0
              end
              object ppLine1: TppLine
                UserName = 'Line1'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 80433
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLine2: TppLine
                UserName = 'Line2'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 105569
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLine3: TppLine
                UserName = 'Line3'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 131498
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLine4: TppLine
                UserName = 'JobsalLine201'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 157427
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLine5: TppLine
                UserName = 'Line5'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 183621
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLine6: TppLine
                UserName = 'Line6'
                Position = lpLeft
                Weight = 0.600000023841858
                mmHeight = 11377
                mmLeft = 209550
                mmTop = 2646
                mmWidth = 3704
                BandType = 3
                GroupNo = 0
              end
              object ppLabel8: TppLabel
                UserName = 'Label8'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 59796
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel9: TppLabel
                UserName = 'Label9'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 72231
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel10: TppLabel
                UserName = 'Label10'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 188648
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel11: TppLabel
                UserName = 'Label11'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 162454
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel12: TppLabel
                UserName = 'Label12'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 136525
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel13: TppLabel
                UserName = 'Label13'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 110596
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel14: TppLabel
                UserName = 'Label14'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 85196
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel15: TppLabel
                UserName = 'JobsalLabel401'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 201084
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel16: TppLabel
                UserName = 'Label16'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 175155
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel17: TppLabel
                UserName = 'Label17'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 148961
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel18: TppLabel
                UserName = 'Label18'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 123296
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel19: TppLabel
                UserName = 'Label19'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 97367
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLabel20: TppLabel
                UserName = 'Label20'
                Caption = 'In'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 215107
                mmTop = 9260
                mmWidth = 2646
                BandType = 3
                GroupNo = 0
              end
              object ppLabel21: TppLabel
                UserName = 'Label21'
                Caption = 'Out'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 9
                Font.Style = []
                mmHeight = 3969
                mmLeft = 228071
                mmTop = 9260
                mmWidth = 5027
                BandType = 3
                GroupNo = 0
              end
              object ppLine7: TppLine
                UserName = 'Line7'
                Pen.Width = 2
                Position = lpBottom
                Weight = 1.5
                mmHeight = 1588
                mmLeft = 0
                mmTop = 12700
                mmWidth = 55563
                BandType = 3
                GroupNo = 0
              end
            end
            object ppGroupFooterBand1: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 528
              mmPrintPosition = 0
              object ppLine19: TppLine
                UserName = 'Jobsalbtm1'
                Pen.Width = 2
                Weight = 1.5
                mmHeight = 529
                mmLeft = 0
                mmTop = 0
                mmWidth = 236803
                BandType = 5
                GroupNo = 0
              end
            end
          end
        end
      end
    end
    object ByJobTypeGroup1: TppGroup
      BreakName = 'Jobname'
      DataPipeline = Byjobpipe
      ReprintOnSubsequentColumn = False
      UserName = 'ByJobTypeGroup1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'Byjobpipe'
      object ByJobTypeGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 14023
        mmPrintPosition = 0
        object ByJobTypeShape1: TppShape
          UserName = 'ByJobTypeShape1'
          Pen.Width = 2
          mmHeight = 6350
          mmLeft = 55298
          mmTop = 2646
          mmWidth = 181769
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeShape2: TppShape
          UserName = 'ByJobTypeShape2'
          Pen.Width = 2
          mmHeight = 6350
          mmLeft = 55298
          mmTop = 8202
          mmWidth = 181769
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel5: TppLabel
          UserName = 'ByJobTypeLabel5'
          Caption = 'Monday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 62177
          mmTop = 3440
          mmWidth = 11113
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel6: TppLabel
          UserName = 'ByJobTypeLabel6'
          Caption = 'Tuesday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 86784
          mmTop = 3440
          mmWidth = 12435
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel7: TppLabel
          UserName = 'ByJobTypeLabel7'
          Caption = 'Wednesday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 110067
          mmTop = 3440
          mmWidth = 17198
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel8: TppLabel
          UserName = 'ByJobTypeLabel8'
          Caption = 'Thursday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 137584
          mmTop = 3440
          mmWidth = 13494
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel9: TppLabel
          UserName = 'ByJobTypeLabel9'
          Caption = 'Friday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 165894
          mmTop = 3440
          mmWidth = 8731
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel10: TppLabel
          UserName = 'ByJobTypeLabel10'
          Caption = 'Saturday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 189707
          mmTop = 3440
          mmWidth = 12700
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel11: TppLabel
          UserName = 'ByJobTypeLabel11'
          Caption = 'Sunday'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          TextAlignment = taCentered
          mmHeight = 3969
          mmLeft = 216959
          mmTop = 3440
          mmWidth = 10848
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeShape4: TppShape
          UserName = 'ByJobTypeShape4'
          Pen.Width = 2
          ShiftWithParent = True
          mmHeight = 6879
          mmLeft = 0
          mmTop = 4498
          mmWidth = 33073
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeDBText1: TppDBText
          UserName = 'ByJobTypeDBText1'
          DataField = 'Jobname'
          DataPipeline = Byjobpipe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          DataPipelineName = 'Byjobpipe'
          mmHeight = 3969
          mmLeft = 1058
          mmTop = 5556
          mmWidth = 30692
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine2: TppLine
          UserName = 'ByJobTypeLine2'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 80433
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine3: TppLine
          UserName = 'ByJobTypeLine3'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 105569
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine4: TppLine
          UserName = 'ByJobTypeLine4'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 131498
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine5: TppLine
          UserName = 'ByJobTypeLine5'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 157427
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine6: TppLine
          UserName = 'ByJobTypeLine6'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 183621
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLine7: TppLine
          UserName = 'ByJobTypeLine7'
          Position = lpLeft
          Weight = 0.600000023841858
          mmHeight = 11377
          mmLeft = 209550
          mmTop = 2910
          mmWidth = 3704
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel12: TppLabel
          UserName = 'ByJobTypeLabel12'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 59796
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel13: TppLabel
          UserName = 'ByJobTypeLabel13'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 72231
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel14: TppLabel
          UserName = 'ByJobTypeLabel14'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 188648
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel15: TppLabel
          UserName = 'ByJobTypeLabel15'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 162454
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel16: TppLabel
          UserName = 'ByJobTypeLabel16'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 136525
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel17: TppLabel
          UserName = 'ByJobTypeLabel17'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 110596
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel18: TppLabel
          UserName = 'ByJobTypeLabel18'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 85196
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel20: TppLabel
          UserName = 'ByJobTypeLabel20'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 201084
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel21: TppLabel
          UserName = 'ByJobTypeLabel21'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 175155
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel22: TppLabel
          UserName = 'ByJobTypeLabel22'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 148961
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel23: TppLabel
          UserName = 'ByJobTypeLabel23'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 123296
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel24: TppLabel
          UserName = 'ByJobTypeLabel24'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 97367
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel19: TppLabel
          UserName = 'ByJobTypeLabel19'
          Caption = 'In'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 215107
          mmTop = 9260
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
        end
        object ByJobTypeLabel25: TppLabel
          UserName = 'ByJobTypeLabel25'
          Caption = 'Out'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          mmHeight = 3969
          mmLeft = 228071
          mmTop = 9260
          mmWidth = 5027
          BandType = 3
          GroupNo = 0
        end
        object byjobtypeLine1: TppLine
          UserName = 'byjobtypeLine1'
          Pen.Width = 2
          Position = lpBottom
          Weight = 1.5
          mmHeight = 1588
          mmLeft = 0
          mmTop = 12700
          mmWidth = 55563
          BandType = 3
          GroupNo = 0
        end
      end
      object ByJobTypeGroupFooterBand1: TppGroupFooterBand
        BeforePrint = ByJobTypeGroupFooterBand1BeforePrint
        mmBottomOffset = 0
        mmHeight = 529
        mmPrintPosition = 0
        object ByJobTypeLine15: TppLine
          UserName = 'ByJobTypeLine15'
          Pen.Width = 2
          Weight = 1.5
          mmHeight = 529
          mmLeft = 0
          mmTop = 0
          mmWidth = 236803
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object wwtGhost: TADOTable
    Connection = dmADO.AztecConn
    TableName = '#Ghost'
    Left = 136
    Top = 440
  end
  object wwtOpClose: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'OpenTime'
    Left = 60
    Top = 228
  end
  object wwghost3: TADOTable
    Connection = dmADO.AztecConn
    TableName = '#Ghost3'
    Left = 104
    Top = 408
  end
  object tblRun: TADOTable
    Connection = dmADO.AztecConn
    Left = 28
    Top = 228
  end
  object TempTable: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = '#tmpschdl'
    Left = 28
    Top = 260
  end
  object qryRun2: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    Left = 28
    Top = 196
  end
  object WeekQuery: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'site'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'monstr'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'sunstr'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      ''
      'from schedule a'
      ''
      'where (a.sitecode = :site) '
      
        '    and (((a.schin >= :monstr) and (a.schin <= :sunstr)) or (a.s' +
        'chin is null))'
      '    and  not (a.schin = a.schout) '
      '    and a.visible = '#39'Y'#39
      ''
      'order by a.Sitecode, a.UserId, a.RoleId, a.rec, a.schin')
    Left = 28
    Top = 164
  end
  object wwQborrow: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'mid1'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'mid2'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'site'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select s.Sitecode, s.UserId, s.schin, s.schout, s.shift, s.RoleI' +
        'd, s.rec, s.oc'
      'from schedule s'
      'join ac_UserRoles ur'
      'on s.UserId = ur.UserId and s.RoleId = ur.RoleId'
      'where (s.schin >= :mid1)'
      'and(s.schin <= :mid2)'
      'and(s.sitecode = :site)'
      'and  not ((s.schin = s.schout) and (s.schin = s.clockin))'
      'and s.visible = '#39'Y'#39
      'order by s.Sitecode, s.UserId, s.RoleId, s.rec, s.schin')
    Left = 60
    Top = 164
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 60
    Top = 196
  end
  object DisplayQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Filter = 'deleted = NULL'
    Filtered = True
    BeforeOpen = DisplayQueryBeforeOpen
    AfterOpen = DisplayQueryAfterOpen
    AfterClose = DisplayQueryAfterClose
    BeforeEdit = DisplayQueryBeforeEdit
    AfterEdit = DisplayQueryAfterEdit
    AfterPost = DisplayQueryAfterPost
    AfterScroll = DisplayQueryAfterScroll
    OnCalcFields = DisplayQueryCalcFields
    OnNewRecord = DisplayQueryNewRecord
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'roleid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 6
      end>
    SQL.Strings = (
      'SELECT t.*, u.LastName, u.FirstName, r.Name AS JobName'
      'FROM #tmpschdl t'
      'JOIN ac_User u ON t.UserID = u.Id'
      'JOIN ac_Role r ON t.RoleId = r.Id'
      'WHERE RoleId =  :roleid')
    Left = 308
    Top = 120
    object DisplayQuerySname: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Sname'
      LookupDataSet = dMod1.wwtac_User
      LookupKeyFields = 'Id'
      LookupResultField = 'LastName'
      KeyFields = 'UserId'
      Size = 10
      Lookup = True
    end
    object DisplayQueryFName: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'FName'
      LookupDataSet = dMod1.wwtac_User
      LookupKeyFields = 'Id'
      LookupResultField = 'FirstName'
      KeyFields = 'UserId'
      Size = 10
      Lookup = True
    end
    object DisplayQueryRoleName: TStringField
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'RoleName'
      LookupDataSet = dMod1.wwtac_Role
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'RoleId'
      Size = 13
      Lookup = True
    end
    object DisplayQueryMonin: TStringField
      DisplayWidth = 5
      FieldName = 'Monin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryMonout: TStringField
      DisplayWidth = 5
      FieldName = 'Monout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryTuein: TStringField
      DisplayWidth = 5
      FieldName = 'Tuein'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryTueout: TStringField
      DisplayWidth = 5
      FieldName = 'Tueout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryWedin: TStringField
      DisplayWidth = 5
      FieldName = 'Wedin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryWedout: TStringField
      DisplayWidth = 5
      FieldName = 'Wedout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryThuin: TStringField
      DisplayWidth = 5
      FieldName = 'Thuin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryThuout: TStringField
      DisplayWidth = 5
      FieldName = 'Thuout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryFriin: TStringField
      DisplayWidth = 5
      FieldName = 'Friin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryFriout: TStringField
      DisplayWidth = 5
      FieldName = 'Friout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQuerySatin: TStringField
      DisplayWidth = 5
      FieldName = 'Satin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQuerySatout: TStringField
      DisplayWidth = 5
      FieldName = 'Satout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQuerySunin: TStringField
      DisplayWidth = 5
      FieldName = 'Sunin'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQuerySunout: TStringField
      DisplayWidth = 5
      FieldName = 'Sunout'
      OnChange = DisplayQueryTimeChange
      Size = 5
    end
    object DisplayQueryWeekTotal: TStringField
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'WeekTotal'
      ReadOnly = True
      OnGetText = DisplayQueryWeekTotalGetText
      Size = 5
      Calculated = True
    end
    object DisplayQueryLeftJob: TBooleanField
      DisplayWidth = 1
      FieldName = 'LeftJob'
    end
    object DisplayQueryUserId: TLargeintField
      Alignment = taLeftJustify
      DisplayWidth = 21
      FieldName = 'UserId'
      Visible = False
    end
    object DisplayQueryRoleId: TIntegerField
      DisplayWidth = 1
      FieldName = 'RoleId'
      Visible = False
    end
    object DisplayQueryShift: TSmallintField
      FieldName = 'Shift'
      Visible = False
    end
    object DisplayQueryF1: TStringField
      DisplayWidth = 1
      FieldName = 'F1'
      Visible = False
      Size = 1
    end
    object DisplayQueryF2: TStringField
      DisplayWidth = 1
      FieldName = 'F2'
      Visible = False
      Size = 1
    end
    object DisplayQueryF3: TStringField
      DisplayWidth = 1
      FieldName = 'F3'
      Visible = False
      Size = 1
    end
    object DisplayQueryF4: TStringField
      DisplayWidth = 1
      FieldName = 'F4'
      Visible = False
      Size = 1
    end
    object DisplayQueryF5: TStringField
      DisplayWidth = 1
      FieldName = 'F5'
      Visible = False
      Size = 1
    end
    object DisplayQueryF6: TStringField
      DisplayWidth = 1
      FieldName = 'F6'
      Visible = False
      Size = 1
    end
    object DisplayQueryF7: TStringField
      DisplayWidth = 1
      FieldName = 'F7'
      Visible = False
      Size = 1
    end
    object DisplayQuerymonoc: TStringField
      FieldName = 'monoc'
      Visible = False
      Size = 2
    end
    object DisplayQuerytueoc: TStringField
      FieldName = 'tueoc'
      Visible = False
      Size = 2
    end
    object DisplayQuerywedoc: TStringField
      FieldName = 'wedoc'
      Visible = False
      Size = 2
    end
    object DisplayQuerythuoc: TStringField
      FieldName = 'thuoc'
      Visible = False
      Size = 2
    end
    object DisplayQueryfrioc: TStringField
      FieldName = 'frioc'
      Visible = False
      Size = 2
    end
    object DisplayQuerysatoc: TStringField
      FieldName = 'satoc'
      Visible = False
      Size = 2
    end
    object DisplayQuerysunoc: TStringField
      FieldName = 'sunoc'
      Visible = False
      Size = 2
    end
    object DisplayQueryDeleted: TStringField
      FieldName = 'Deleted'
      Visible = False
      Size = 1
    end
    object DisplayQueryTerminated: TStringField
      FieldKind = fkLookup
      FieldName = 'Terminated'
      LookupDataSet = dMod1.wwtac_User
      LookupKeyFields = 'Id'
      LookupResultField = 'Terminated'
      KeyFields = 'UserId'
      Visible = False
      Size = 1
      Lookup = True
    end
    object DisplayQueryLastName: TStringField
      DisplayWidth = 20
      FieldName = 'LastName'
      Size = 50
    end
    object DisplayQueryFirstName: TStringField
      FieldName = 'FirstName'
    end
    object DisplayQueryJobName: TStringField
      FieldName = 'JobName'
    end
  end
  object qryEmployeeJobs: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    DataSource = DisplayDS
    Parameters = <
      item
        Name = 'userid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 10
        Value = '5'
      end>
    SQL.Strings = (
      'select r.Id , r.Name'
      'from ac_UserRoles ur'
      'join ac_User u'
      'on ur.UserId = u.Id'
      '  join ac_Role r'
      '  on r.Id = ur.RoleId'
      '    join ac_PayScheme ps'
      '    on ps.Id = ur.PaySchemeId'
      '      join ac_PaySchemeVersion v'
      '      on v.Id = ps.CurrentPaySchemeVersionId'
      '        join ac_AllUserSites s'
      '        on s.UserId = u.Id'
      'where u.Id = :userid'
      'and s.SiteId = dbo.fngetsitecode()')
    Left = 276
    Top = 120
    object qryEmployeeJobsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
    end
    object qryEmployeeJobsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
      Visible = False
    end
  end
  object cmdWageCostCalc: TADOCommand
    CommandText = 
      'DECLARE @SiteId int, @StartOfWeek datetime'#13#10'SET @SiteId = :SiteI' +
      'd'#13#10'SET @StartOfWeek = :StartOfWeek'#13#10#13#10'UPDATE #WeekShifts'#13#10'SET Pa' +
      'ySchemeVersionId = b.PaySchemeVersionId,'#13#10'    UserPayRateOverrid' +
      'eVersionId = b.UserPayRateOverrideVersionId,'#13#10'  InScheduleTable ' +
      '= 1'#13#10'FROM #WeekShifts a INNER JOIN Schedule b'#13#10'  ON a.UserId = b' +
      '.UserId AND a.RoleId = b.RoleId AND a.InTime = b.Schin'#13#10'WHERE  b' +
      '.SiteCode = @SiteId AND b.Visible = '#39'Y'#39#13#10#13#10'UPDATE #WeekShifts'#13#10'S' +
      'ET PaySchemeVersionId = c.CurrentPaySchemeVersionId'#13#10'FROM #WeekS' +
      'hifts a'#13#10'  INNER JOIN ac_UserRoles b ON a.UserId = b.UserId AND ' +
      'a.RoleId = b.RoleId'#13#10'  INNER JOIN ac_PayScheme c ON b.PaySchemeI' +
      'd = c.Id'#13#10'WHERE a.InScheduleTable = 0'#13#10#13#10'UPDATE #WeekShifts'#13#10'SET' +
      ' UserPayRateOverrideVersionId = c.CurrentUserPayRateOverrideVers' +
      'ionId'#13#10'FROM #WeekShifts a'#13#10'  INNER JOIN ac_PaySchemeVersion b ON' +
      ' a.PaySchemeVersionId = b.Id'#13#10'  INNER JOIN ac_UserPayRateOverrid' +
      'e c ON a.UserId = c.UserId AND b.PaySchemeId = c.PaySchemeId'#13#10'WH' +
      'ERE a.InScheduleTable = 0'#13#10'     AND c.Deleted = 0'#13#10#13#10'EXEC spCalc' +
      'ulateWeekWageCosts @SiteId, @StartOfWeek'#13#10
    Connection = dmADO.AztecConn
    Parameters = <
      item
        Name = 'SiteId'
        Size = -1
        Value = Null
      end
      item
        Name = 'StartOfWeek'
        Size = -1
        Value = Null
      end>
    Left = 60
    Top = 260
  end
  object evntMouseWheelCatcher: TApplicationEvents
    OnMessage = evntMouseWheelCatcherMessage
    Left = 728
    Top = 480
  end
end
