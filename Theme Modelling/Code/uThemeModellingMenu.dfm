object ThemeModellingMenu: TThemeModellingMenu
  Left = 910
  Top = 238
  HelpContext = 5001
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 7
  Caption = 'Theme Modelling Menu'
  ClientHeight = 156
  ClientWidth = 184
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
    Width = 184
    Height = 156
    AutoSize = False
    Caption = 
      'Main menu buttons are created dynamically from the "visible" act' +
      'ions in the action list - see formshow handler'
    Visible = False
    WordWrap = True
  end
  object CheckInactiveTimer: TTimer
    Enabled = False
    OnTimer = CheckInactiveTimerTimer
    Left = 24
    Top = 96
  end
  object AppEvent: TApplicationEvents
    OnException = AppEventException
    OnMessage = AppEventMessage
    OnShowHint = AppEventShowHint
    Left = 88
    Top = 96
  end
  object MainMenuActions: TActionList
    OnExecute = MainMenuActionsExecute
    Left = 56
    Top = 96
    object SiteSetup: TAction
      Caption = 'Site Setup'
      OnExecute = SiteSetupExecute
    end
    object ManageEstateSetup: TAction
      Caption = 'Estate Setup'
      OnExecute = ManageEstateSetupExecute
    end
    object ManageThemes: TAction
      Caption = 'Themes'
      OnExecute = ManageThemesExecute
    end
    object ManageSharedPanels: TAction
      Caption = 'Shared Panels'
      OnExecute = ManageSharedPanelsExecute
    end
    object ManageSiteVariations: TAction
      Caption = 'Site Variations'
      OnExecute = ManageSiteVariationsExecute
    end
    object ManageSiteThemes: TAction
      Caption = 'Site Themes'
      OnExecute = ManageSiteThemesExecute
    end
    object SiteProducts: TAction
      Caption = 'Site Products'
      OnExecute = SiteProductsExecute
    end
    object SitePanels: TAction
      Caption = 'Site Panels'
      OnExecute = SitePanelsExecute
    end
    object SiteTablePlans: TAction
      Caption = 'Site Table Plans'
      OnExecute = SiteTablePlansExecute
    end
    object MatchTablePlans: TAction
      Caption = 'Match Table Plans'
      OnExecute = MatchTablePlansExecute
    end
    object DriveThruPlan: TAction
      Caption = 'Drive Thru Plan'
      OnExecute = DriveThruPlanExecute
    end
    object KeyLines: TAction
      Caption = 'Key Lines'
      OnExecute = KeyLinesExecute
    end
    object SendToPOS: TAction
      Caption = 'Send to POS'
      OnExecute = SendToPOSExecute
    end
    object SendTicketImagesToPOS: TAction
      Caption = 'Send Ticket Images'
      OnExecute = SendTicketImagesToPOSExecute
    end
    object CloseForm: TAction
      Caption = 'Close'
      OnExecute = CloseFormExecute
    end
    object ThemeReports: TAction
      Caption = 'Reports'
      OnExecute = ThemeReportsExecute
    end
    object DeviceSiteSetup: TAction
      Caption = 'Device Setup'
      OnExecute = DeviceSiteSetupExecute
    end
    object PromotionalFooters: TAction
      Caption = 'Promotional Footers'
      OnExecute = PromotionalFootersExecute
    end
    object TestEQATECException: TAction
      Caption = 'Test EQATEC Exception'
      Visible = False
      OnExecute = TestEQATECExceptionExecute
    end
  end
  object ImageList1: TImageList
    Height = 0
    Width = 280
    Left = 120
    Top = 96
  end
end
