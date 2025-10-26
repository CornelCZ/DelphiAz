object fmiddlg: Tfmiddlg
  Left = 489
  Top = 272
  ActiveControl = Edit1
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Mid-Word Search'
  ClientHeight = 120
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 4
    Top = 42
    Width = 220
    Height = 17
    AutoSize = False
    Caption = 'Type a string to use for mid-word search'
    WordWrap = True
  end
  object lblSearchMode: TLabel
    Left = 4
    Top = 12
    Width = 75
    Height = 15
    Caption = 'Search Mode:'
  end
  object lblSearchModeValue: TLabel
    Left = 87
    Top = 12
    Width = 3
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 4
    Top = 61
    Width = 222
    Height = 23
    TabOrder = 0
  end
  object btnFirst: TBitBtn
    Left = 3
    Top = 93
    Width = 56
    Height = 25
    Caption = 'Fi&rst'
    Default = True
    TabOrder = 1
    OnClick = btnFirstClick
    Glyph.Data = {
      46010000424D460100000000000076000000280000001C0000000D0000000100
      040000000000D000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333000033333333333333333333333333330000333333333333
      3333FFF33333FFF30000330733333370333733F333FF33F30000330733337000
      333733F3FF3333F30000330733700000333733FF333333F30000330770000000
      3337333333333003000033073370000033373337333300000000330733337000
      333733F3773300000000330733333370333733F3337730030000333333333333
      3337773333337733000033333333333333333333333333330000333333333333
      33333333333333330000}
    NumGlyphs = 2
  end
  object btnClose: TBitBtn
    Left = 152
    Top = 93
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object btnNext: TBitBtn
    Left = 65
    Top = 93
    Width = 56
    Height = 25
    Caption = '&Next'
    Default = True
    TabOrder = 2
    OnClick = btnNextClick
    Glyph.Data = {
      12010000424D12010000000000007600000028000000140000000D0000000100
      0400000000009C00000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333000033333333333333333333000033333333333FF333333300003073
      333333733FF333330000300073333373333FF333000030000073337333333FF3
      00003000000073733333333F0000300000733373333337730000300073333373
      3337733300003073333333733773333300003333333333777333333300003333
      33333333333333330000333333333333333333330000}
    NumGlyphs = 2
  end
end
