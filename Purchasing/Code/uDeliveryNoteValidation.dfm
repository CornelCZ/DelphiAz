object frmDeliveryNoteValidation: TfrmDeliveryNoteValidation
  Left = 419
  Top = 464
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Handheld Delivery Note Validation'
  ClientHeight = 378
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 507
    Height = 26
    Caption = 
      'The imported delivery notes listed below require reconciliation ' +
      'before being added to the Purchasing system.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lblDeliveryNotes: TLabel
    Left = 16
    Top = 47
    Width = 69
    Height = 13
    Caption = 'Delivery Notes'
  end
  object Label2: TLabel
    Left = 19
    Top = 226
    Width = 82
    Height = 13
    Caption = 'Failure Reason(s)'
  end
  object lvDeliveryNotes: TListView
    Left = 16
    Top = 64
    Width = 553
    Height = 150
    Columns = <
      item
        Caption = 'Supplier Name'
        Width = 180
      end
      item
        Caption = 'Delivery Note No.'
        Width = 120
      end
      item
        Caption = 'Date'
        Width = 90
      end
      item
        Caption = 'Order Number'
        Width = 140
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = lvDeliveryNotesChange
  end
  object Panel1: TPanel
    Left = 16
    Top = 239
    Width = 553
    Height = 94
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 4
    object reErrors: TRichEdit
      Left = 1
      Top = 1
      Width = 551
      Height = 92
      TabStop = False
      Align = alClient
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
  end
  object btnCorrectNote: TButton
    Left = 17
    Top = 343
    Width = 153
    Height = 25
    Hint = 'Correct the selected Delivery Note'
    Caption = 'Correct Delivery Note Errors'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnCorrectNoteClick
  end
  object btnDiscardNote: TButton
    Left = 184
    Top = 343
    Width = 145
    Height = 25
    Hint = 'Remove the selected Delivery Note'
    Caption = 'Discard Delivery Note'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnDiscardNoteClick
  end
  object btnClose: TBitBtn
    Left = 477
    Top = 343
    Width = 91
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
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
end
