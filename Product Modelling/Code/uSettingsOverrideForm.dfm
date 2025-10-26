object SettingsOverrideForm: TSettingsOverrideForm
  Left = 597
  Top = 300
  BorderStyle = bsDialog
  Caption = 'Settings Override'
  ClientHeight = 157
  ClientWidth = 304
  Color = clBtnFace
  Constraints.MaxHeight = 195
  Constraints.MaxWidth = 320
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
    Height = 157
    Align = alClient
    TabOrder = 0
    DesignSize = (
      304
      157)
    inherited Label1: TLabel
      Width = 276
      Height = 26
      Caption = 
        'Choose how the Budgeted Cost Price will be calculated for this p' +
        'roduct.'
      WordWrap = True
    end
    inherited bvlDivider1: TBevel
      Top = 157
      Width = 276
      Visible = False
    end
    inherited btnCancel: TButton
      Left = 219
      Top = 127
    end
    inherited btnOk: TButton
      Left = 142
      Top = 127
    end
    inherited chkbxShowPortionPrices: TCheckBox
      Top = 166
      Visible = False
    end
    inherited pnlBudgetedCostPriceMode: TPanel
      Top = 48
      Width = 276
      Height = 74
    end
    inherited chkbxUseGlobalDefault: TCheckBox
      Top = 41
    end
  end
end
