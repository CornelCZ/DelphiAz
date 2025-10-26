object EditDiscountReasons: TEditDiscountReasons
  Left = 386
  Top = 388
  Width = 578
  Height = 410
  BorderStyle = bsSizeToolWin
  Caption = 'Discount Reasons'
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
    372)
  PixelsPerInch = 96
  TextHeight = 13
  inline SelectReasonsFrame: TSelectReasonsFrame
    Left = 0
    Top = 0
    Width = 562
    Height = 372
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    inherited pnlClient: TPanel
      Height = 330
      inherited pnlLeft: TPanel
        Height = 326
        inherited lbAvailableReasons: TListBox
          Height = 284
        end
        inherited pnlButtons: TPanel
          Height = 326
          inherited btnSelect: TButton
            Top = 130
          end
          inherited btnDeselect: TButton
            Top = 156
          end
        end
      end
      inherited pnlRight: TPanel
        Height = 326
        inherited lbSelectedReasons: TListBox
          Height = 284
        end
      end
    end
    inherited pnlBottom: TPanel
      Top = 330
    end
  end
end
