object EditTableMoveReasons: TEditTableMoveReasons
  Left = 386
  Top = 388
  Width = 578
  Height = 458
  BorderStyle = bsSizeToolWin
  Caption = 'Table Move/Merge Reasons'
  Color = clBtnFace
  Constraints.MinHeight = 380
  Constraints.MinWidth = 560
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    562
    420)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 11
    Width = 507
    Height = 26
    Caption = 
      'Select the reasons the terminal user can choose from when moving' +
      ' or merging tables (or accounts).'#13#10'Whether or not a terminal wil' +
      'l prompt for a reason in these scenarios is set in the terminal'#39 +
      's Configuration Set.'
  end
  inline SelectReasonsFrame: TSelectReasonsFrame
    Left = 0
    Top = 46
    Width = 562
    Height = 372
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    inherited pnlClient: TPanel
      Height = 330
      BevelInner = bvNone
      BevelOuter = bvNone
      inherited pnlLeft: TPanel
        Left = 0
        Top = 0
        Height = 330
        inherited lbAvailableReasons: TListBox
          Height = 288
        end
        inherited pnlButtons: TPanel
          Height = 330
          inherited btnSelect: TButton
            Top = 132
          end
          inherited btnDeselect: TButton
            Top = 167
          end
        end
      end
      inherited pnlRight: TPanel
        Left = 315
        Top = 0
        Width = 247
        Height = 330
        inherited lbSelectedReasons: TListBox
          Width = 229
          Height = 288
        end
      end
    end
    inherited pnlBottom: TPanel
      Top = 330
    end
  end
end
