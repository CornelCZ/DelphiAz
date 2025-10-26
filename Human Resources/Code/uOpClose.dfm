object fOpClose: TfOpClose
  Left = 272
  Top = 146
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configure Open and Close times'
  ClientHeight = 294
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 7
    Top = 39
    Width = 61
    Height = 19
    Caption = 'Monday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 126
    Top = 12
    Width = 42
    Height = 19
    Caption = 'Open'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 242
    Top = 12
    Width = 44
    Height = 19
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 67
    Width = 66
    Height = 19
    Caption = 'Tuesday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 7
    Top = 97
    Width = 92
    Height = 19
    Caption = 'Wednesday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 7
    Top = 125
    Width = 74
    Height = 19
    Caption = 'Thursday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 7
    Top = 154
    Width = 49
    Height = 19
    Caption = 'Friday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 7
    Top = 183
    Width = 71
    Height = 19
    Caption = 'Saturday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 7
    Top = 212
    Width = 59
    Height = 19
    Caption = 'Sunday'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 202
    Top = 7
    Width = 2
    Height = 228
  end
  object EditMonOpen: TMaskEdit
    Left = 124
    Top = 37
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 0
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditMonClose: TMaskEdit
    Left = 241
    Top = 37
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 1
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditTueOpen: TMaskEdit
    Left = 124
    Top = 65
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditTueClose: TMaskEdit
    Left = 241
    Top = 65
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditWedOpen: TMaskEdit
    Left = 124
    Top = 94
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 4
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditWedClose: TMaskEdit
    Left = 241
    Top = 94
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 5
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditThuOpen: TMaskEdit
    Left = 124
    Top = 123
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 6
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditThuClose: TMaskEdit
    Left = 241
    Top = 123
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 7
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditFriOpen: TMaskEdit
    Left = 124
    Top = 152
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 8
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditFriClose: TMaskEdit
    Left = 241
    Top = 152
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 9
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditSatOpen: TMaskEdit
    Left = 124
    Top = 180
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 10
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditSatClose: TMaskEdit
    Left = 241
    Top = 180
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 11
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditSunOpen: TMaskEdit
    Left = 124
    Top = 210
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 12
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object EditSunClose: TMaskEdit
    Left = 241
    Top = 210
    Width = 39
    Height = 24
    EditMask = '!99:99;1;_'
    MaxLength = 5
    TabOrder = 13
    Text = '  :  '
    OnKeyDown = EditMonOpenKeyDown
  end
  object BitBtn1: TBitBtn
    Left = 7
    Top = 245
    Width = 137
    Height = 39
    Caption = '&Save and Exit'
    TabOrder = 14
    OnClick = BitBtn1Click
    Glyph.Data = {
      8A010000424D8A01000000000000760000002800000018000000170000000100
      0400000000001401000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
      AAAAAAAAAAAAACCCCCCCCCCCCCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFF
      CCCCFFFFCCFFCCCFFCCCACFFCCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCF
      FCCCACFFCCCCFFFFCCFFCCCFFCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCC
      CCCCCCCCCCCCAAAAAAAAAAAAAAAAAAAAAAAAAAA70000000000000AAAAAAAAAA0
      33000000FF030AAAAAAAAAA033000000FF030AAAAAAAAAA033000000FF030AAA
      AAAAAAA03300000000030AAAAAAAAAA03333333333330AAAAAAAAAA033000000
      00330AAAAAAAAAA030FAAAAAAA030AAAAAAAAAA030AFAAAAAA030AAAAAAAAAA0
      30AAAAAAAA030AAAAAAAAAA030AAAAAAAA000AAAAAAAAAA030AAAAAAAA0F0AAA
      AAAAAAA00000000000000AAAAAAA}
  end
  object BitBtn2: TBitBtn
    Left = 156
    Top = 245
    Width = 144
    Height = 39
    Caption = '&Discard and Exit'
    TabOrder = 15
    OnClick = BitBtn2Click
    Glyph.Data = {
      8A010000424D8A01000000000000760000002800000018000000170000000100
      0400000000001401000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
      CCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFFCCCCFFFFCCFFCCCFFCCCACFF
      CCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCFFCCCACFFCCCCFFFFCCFFCCCF
      FCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCCCCCCCCCCCCCCAAAAAAAAAAAA
      AAAAAAAAAAAAA7000000AAAAAAAAAAAAAAAAA0330000AA00000000AAAAAAA033
      0000AA000FF030AAAAAAA03300000AA00FF030AAAAAAA033000000AA0FF030AA
      AAAAA033333330AA000030AAAAAAA033000000AA033330AAAAAAA030FAAAA0AA
      000330AAAAAAA030AFAA0AAA0AA030AAAAAAA030AAA0AAA0AAA030AAAAAAA030
      AA0AAA0AAAA030AAAAAAA030A0AAA0AAAAA000AAAAAAA00000AA0AAAAAA0F0AA
      AAAAAAAAAAAA0000000000AAAAAA}
  end
  object wwTable1: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'OpenTime'
    Left = 144
    Top = 144
  end
end
