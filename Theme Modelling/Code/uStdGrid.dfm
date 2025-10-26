object frmStdGrid: TfrmStdGrid
  Left = 466
  Top = 198
  Width = 339
  Height = 399
  HelpContext = 5025
  BorderWidth = 10
  Caption = 'Panels with Invalid Positions '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 322
    Width = 311
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 224
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 97
    Width = 311
    Height = 225
    Align = alClient
    DataSource = dsGrid
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 311
    Height = 97
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Panels cannot overlap the Order Display Header '
      'unless they are specifically marked to do so. '
      ''
      'The following panels will overlap the order display '
      'causing serious implications for the POS.  Changes '
      'cannot be saved until the user places the Order '
      'Display Header in a suitable position.')
    ParentFont = False
    TabOrder = 2
  end
  object dsGrid: TDataSource
    Left = 144
    Top = 112
  end
end
