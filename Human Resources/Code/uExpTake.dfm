object fExpTake: TfExpTake
  Left = 432
  Top = 187
  ActiveControl = edVal
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Modify Expected Takings'
  ClientHeight = 158
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label3: TLabel
    Left = 4
    Top = 52
    Width = 83
    Height = 16
    Caption = 'Current Value:'
  end
  object lblCurVal: TLabel
    Left = 93
    Top = 52
    Width = 59
    Height = 16
    Caption = 'lblCurVal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 6
    Top = 84
    Width = 114
    Height = 16
    Caption = 'Type the new value:'
  end
  object Label38: TLabel
    Left = 4
    Top = 4
    Width = 100
    Height = 16
    Caption = 'Selected Week:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblWeek: TLabel
    Left = 4
    Top = 21
    Width = 251
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = '02/02/2002 -- 02/02/2202'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object edVal: TEdit
    Left = 125
    Top = 80
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = '0.00'
  end
  object btnOK: TBitBtn
    Left = 6
    Top = 112
    Width = 117
    Height = 41
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
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
  object btnCancel: TBitBtn
    Left = 135
    Top = 112
    Width = 117
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Kind = bkCancel
  end
end
