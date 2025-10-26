object fAddEditLocation: TfAddEditLocation
  Left = 263
  Top = 196
  BorderStyle = bsDialog
  Caption = 'fAddEditLocation'
  ClientHeight = 232
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 13
    Top = 7
    Width = 86
    Height = 13
    Caption = 'Location Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblNameInfo: TLabel
    Left = 13
    Top = 43
    Width = 300
    Height = 15
    Caption = 'Min. 1, Max. 25 characters, unique for the Site, required.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblNote: TLabel
    Left = 13
    Top = 70
    Width = 185
    Height = 13
    Caption = 'Location Count Sheet Print Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblNoteInfo: TLabel
    Left = 13
    Top = 171
    Width = 162
    Height = 15
    Caption = 'Max. 320 characters, optional.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object editLocName: TEdit
    Left = 13
    Top = 23
    Width = 308
    Height = 21
    MaxLength = 25
    TabOrder = 0
    Text = 'WWWWWWWWWWwwwwwwwwwwwwwww'
  end
  object BitBtnSave: TBitBtn
    Left = 134
    Top = 192
    Width = 114
    Height = 31
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtnSaveClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
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
  object BitBtnCancel: TBitBtn
    Left = 278
    Top = 192
    Width = 114
    Height = 31
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object memoPrintNote: TMemo
    Left = 13
    Top = 86
    Width = 505
    Height = 86
    Lines.Strings = (
      'WWWWWWWWWWwwwwwwwwwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWW'
      'WWWWWWWwwwwwwwwwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWWWWW'
      'WWWWwwwwwwwwwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWWWWWWWW'
      'WwwwwwwwwwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWWWWWWWWWwww'
      'wwwwwwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWWWWWWWWWwwwwwww'
      'wwwwwwwwWWWWWWWWWWwwwwwwwwwwwwwwwWWWWWWWWWW1234567890')
    MaxLength = 320
    TabOrder = 3
  end
  object cbHasFixedStock: TCheckBox
    Left = 328
    Top = 25
    Width = 129
    Height = 17
    Caption = 'Has Fixed Inventory'
    TabOrder = 4
  end
end
