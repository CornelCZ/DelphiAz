object EditOrderDisplay: TEditOrderDisplay
  Left = 474
  Top = 552
  Width = 387
  Height = 130
  Caption = 'Edit Order Display'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 37
    Height = 13
    Caption = 'Graphic'
  end
  object bbtnOK: TBitBtn
    Left = 168
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object bbtnCancel: TBitBtn
    Left = 280
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cbGraphicNames: TComboBox
    Left = 8
    Top = 32
    Width = 345
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object ADOqryTerminaGraphics: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT [ID],[FileName] FROM [dbo].[TerminalGraphics] WHERE (NOT ' +
        '([Deleted] = 1))'
      ' OR ([Deleted] IS NULL)'
      'Union'
      'Select -1 As [ID], '#39'<Default>'#39' as [FileName] '
      'ORDER BY [FileName] '
      '')
    Left = 296
    Top = 24
  end
  object dsTerminalGraphics: TDataSource
    DataSet = ADOqryTerminaGraphics
    Left = 264
    Top = 64
  end
end
