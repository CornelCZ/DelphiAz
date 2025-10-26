object FrmMain: TFrmMain
  Left = 611
  Top = 119
  Width = 510
  Height = 511
  Caption = 'Processes on'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object stbInfo: TStatusBar
    Left = 0
    Top = 436
    Width = 502
    Height = 19
    Panels = <
      item
        Text = 'Processes:'
        Width = 120
      end
      item
        Text = 'CPU Usage:'
        Width = 150
      end
      item
        Text = 'Mem Usage:'
        Width = 50
      end>
    SimplePanel = False
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 502
    Height = 436
    ActivePage = tsProcesses
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object tsProcesses: TTabSheet
      Caption = 'Processes'
      object pnlBottom: TPanel
        Left = 0
        Top = 363
        Width = 494
        Height = 42
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object pnlButton: TPanel
          Left = 377
          Top = 0
          Width = 117
          Height = 42
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object btnTerminate: TButton
            Left = 12
            Top = 12
            Width = 98
            Height = 25
            Caption = 'End Process'
            TabOrder = 0
            OnClick = btnTerminateClick
          end
        end
      end
      object lvProcesses: TListView
        Left = 0
        Top = 0
        Width = 494
        Height = 363
        Align = alClient
        Columns = <
          item
            Caption = 'Image name'
            Width = 100
          end
          item
            Caption = 'PID'
          end
          item
            Caption = 'CPU'
          end
          item
            Caption = 'CPU Time'
          end>
        HideSelection = False
        IconOptions.WrapText = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object tsTrace: TTabSheet
      Caption = 'Process Trace'
      ImageIndex = 1
      object lbProcessTrace: TListBox
        Left = 0
        Top = 0
        Width = 494
        Height = 405
        Align = alClient
        ItemHeight = 16
        Items.Strings = (
          'Tracing is possible only if both local and target computer '
          'are running Windows XP or higher.'
          '')
        TabOrder = 0
      end
    end
  end
  object mnuMain: TMainMenu
    Left = 88
    Top = 100
    object miFile: TMenuItem
      Caption = 'File'
      object miSelectComputer: TMenuItem
        Caption = 'Select Computer ...'
        OnClick = miSelectComputerClick
      end
      object miNewTask: TMenuItem
        Caption = 'New Task (Run ...)'
        OnClick = miNewTaskClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = 'Exit'
        OnClick = miExitClick
      end
    end
    object Options1: TMenuItem
      Caption = 'View'
      object miRefresh: TMenuItem
        Caption = 'Refresh Now'
        OnClick = miRefreshClick
      end
      object miUpdateSpeed: TMenuItem
        Caption = 'Update Speed'
        object miHigh: TMenuItem
          Tag = 2000
          Caption = 'High'
          GroupIndex = 1
          RadioItem = True
          OnClick = OnChangeSpeed
        end
        object miNormal: TMenuItem
          Tag = 4000
          Caption = 'Normal'
          Checked = True
          GroupIndex = 1
          RadioItem = True
          OnClick = OnChangeSpeed
        end
        object miLow: TMenuItem
          Tag = 8000
          Caption = 'Low'
          GroupIndex = 1
          RadioItem = True
          OnClick = OnChangeSpeed
        end
        object miPaused: TMenuItem
          Caption = 'Paused'
          GroupIndex = 1
          RadioItem = True
          OnClick = OnChangeSpeed
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miSelectColumns: TMenuItem
        Caption = 'Select Columns ...'
        OnClick = miSelectColumnsClick
      end
    end
  end
  object wmiProcesses: TWmiProcessControl
    Active = False
    StartupInfo.CreateFlags = 0
    StartupInfo.ErrorMode = 0
    StartupInfo.FillAttribute = 0
    OnProcessStarted = wmiProcessesProcessStarted
    OnProcessStopped = wmiProcessesProcessStopped
    Left = 44
    Top = 100
  end
  object tmRefresh: TTimer
    Interval = 4000
    OnTimer = tmRefreshTimer
    Left = 132
    Top = 100
  end
end
