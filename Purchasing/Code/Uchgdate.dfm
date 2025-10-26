object fchgdate: Tfchgdate
  Left = 484
  Top = 189
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Change Invoice Date'
  ClientHeight = 116
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 54
    Top = 8
    Width = 131
    Height = 16
    Caption = 'Choose the new date :'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 72
    Width = 97
    Height = 33
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 120
    Top = 72
    Width = 97
    Height = 33
    TabOrder = 1
    Kind = bkCancel
  end
  object dtNewdate: TDateTimePicker
    Left = 59
    Top = 33
    Width = 105
    Height = 24
    CalAlignment = dtaLeft
    Date = 36497
    Time = 36497
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object qryLastStockDate: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select min(MaxEnd) as LastStock'
      'from (select s.Division, max(s.[EDate]) as MaxEnd'
      '         from Stocks s, Threads t'
      '         where s.TID = t.TID'
      '         and ISNULL(t.NoPurAcc,'#39#39') <> '#39'Y'#39
      '         group by s.Division) a')
    Left = 16
    Top = 24
  end
  object qryUnstockedDiv: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    SQL.Strings = (
      'select [Division Name]'
      'from Division'
      'where [Division Name] in'
      '  (select s.[Division]'
      '   from Stocks s, Threads t'
      '   where s.TID = t.TID'
      '   and ISNULL(t.NoPurAcc,'#39#39') = '#39'Y'#39')'
      'or [Division Name] not in'
      '  (select s.[Division]'
      '   from Stocks s, Threads t'
      '   where s.TID = t.TID'
      '   and ISNULL(t.NoPurAcc,'#39#39') <> '#39'Y'#39')')
    Left = 183
    Top = 27
  end
end
