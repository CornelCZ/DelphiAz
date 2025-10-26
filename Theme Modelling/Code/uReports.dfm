object Reports: TReports
  Left = 689
  Top = 194
  AutoSize = True
  BorderStyle = bsSingle
  BorderWidth = 7
  Caption = 'Reports'
  ClientHeight = 113
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbDynamicMenuWarning: TLabel
    Left = 0
    Top = 0
    Width = 225
    Height = 113
    HelpContext = 5059
    AutoSize = False
    Caption = 
      'Report buttons are created dynamically from the "visible" action' +
      's in the action list - see formcreate handler'
    Visible = False
    WordWrap = True
  end
  object ReportActions: TActionList
    OnExecute = ReportActionsExecute
    Left = 72
    Top = 48
    object SitePriceReport: TAction
      Caption = 'Site price report'
      OnExecute = SitePriceReportExecute
    end
    object ProductInPanelReport: TAction
      Caption = 'Product in panel report'
      OnExecute = ProductInPanelReportExecute
    end
    object CloseForm: TAction
      Caption = 'Close'
      OnExecute = CloseFormExecute
    end
  end
end
