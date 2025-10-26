object SettingsForm: TSettingsForm
  Left = 695
  Top = 438
  HelpContext = 8035
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 246
  ClientWidth = 304
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline SettingsFrame: TSettingsFrame
    Left = 0
    Top = 0
    Width = 304
    Height = 246
    Align = alClient
    TabOrder = 0
    DesignSize = (
      304
      246)
    inherited bvlDivider1: TBevel
      Width = 276
    end
    inherited bvlDivider2: TBevel
      Width = 316
    end
    inherited btnCancel: TButton
      Left = 219
      Top = 210
    end
    inherited btnOk: TButton
      Left = 138
      Top = 211
      OnClick = SettingsFramebtnOkClick
    end
    inherited pnlBudgetedCostPriceMode: TPanel
      Width = 274
    end
  end
end
